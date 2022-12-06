const std = @import("std");
const gui = @import("src/gui.zig");
const Backend = @import("src/SDLBackend.zig");

const sqlite = @import("sqlite");
const curl = @import("curl");

pub const c = @cImport({
    @cDefine("_XOPEN_SOURCE", "1");
    @cInclude("time.h");

    @cInclude("locale.h");

    @cInclude("libxml/parser.h");

    @cDefine("LIBXML_XPATH_ENABLED", "1");
    @cInclude("libxml/xpath.h");
});

// when set to true, looks for feed-{rowid}.xml and episode-{rowid}.mp3 instead
// of fetching from network
const DEBUG = true;

var gpa_instance = std.heap.GeneralPurposeAllocator(.{}){};
const gpa = gpa_instance.allocator();

const db_name = "podcast-db.sqlite3";
var g_db: ?sqlite.Db = null;

var g_quit = false;

var g_podcast_id_on_right: usize = 0;

const Episode = struct {
    rowid: usize,
    title: []const u8,
    description: []const u8,
};

fn dbErrorCallafter(id: u32, response: gui.DialogResponse) gui.Error!void {
    _ = id;
    _ = response;
    g_quit = true;
}

fn dbError(comptime fmt: []const u8, args: anytype) !void {
    try gui.dialogOk(@src(), 0, true, "DB Error", try std.fmt.allocPrint(gpa, fmt, args), dbErrorCallafter);
}

fn dbRow(arena: std.mem.Allocator, comptime query: []const u8, comptime return_type: type, values: anytype) !?return_type {
    if (g_db) |*db| {
        var stmt = db.prepare(query) catch {
            try dbError("{}\n\npreparing statement:\n\n{s}", .{ db.getDetailedError(), query });
            return error.DB_ERROR;
        };
        defer stmt.deinit();

        const row = stmt.oneAlloc(return_type, arena, .{}, values) catch {
            try dbError("{}\n\nexecuting statement:\n\n{s}", .{ db.getDetailedError(), query });
            return error.DB_ERROR;
        };

        return row;
    }

    return null;
}

fn dbInit(arena: std.mem.Allocator) !void {
    g_db = sqlite.Db.init(.{
        .mode = sqlite.Db.Mode{ .File = db_name },
        .open_flags = .{
            .write = true,
            .create = true,
        },
    }) catch |err| {
        try dbError("Can't open/create db:\n{s}\n{}", .{ db_name, err });
        return error.DB_ERROR;
    };

    _ = try dbRow(arena, "CREATE TABLE IF NOT EXISTS 'schema' (version INTEGER)", u8, .{});

    if (try dbRow(arena, "SELECT version FROM schema", u32, .{})) |version| {
        if (version != 1) {
            try dbError("{s}\n\nbad schema version: {d}", .{ db_name, version });
            return error.DB_ERROR;
        }
    } else {
        // new database
        _ = try dbRow(arena, "INSERT INTO schema (version) VALUES (1)", u8, .{});
        _ = try dbRow(arena, "CREATE TABLE podcast (url TEXT, error TEXT, title TEXT, description TEXT, copyright TEXT, pubDate INTEGER, lastBuildDate TEXT, link TEXT, image_url TEXT, speed REAL)", u8, .{});
        _ = try dbRow(arena, "CREATE TABLE episode (podcast_id INTEGER, visible INTEGER DEFAULT 1, guid TEXT, title TEXT, description TEXT, pubDate INTEGER, enclosure_url TEXT, position INTEGER, duration INTEGER)", u8, .{});
        _ = try dbRow(arena, "CREATE TABLE player (episode_id INTEGER)", u8, .{});
        _ = try dbRow(arena, "INSERT INTO player (episode_id) values (0)", u8, .{});
    }

    _ = try dbRow(arena, "UPDATE podcast SET error=NULL", u8, .{});
}

pub fn getContent(xpathCtx: *c.xmlXPathContext, node_name: [:0]const u8, attr_name: ?[:0]const u8) ?[]u8 {
    var xpathObj = c.xmlXPathEval(node_name.ptr, xpathCtx);
    defer c.xmlXPathFreeObject(xpathObj);
    if (xpathObj.*.nodesetval.*.nodeNr >= 1) {
        if (attr_name) |attr| {
            var data = c.xmlGetProp(xpathObj.*.nodesetval.*.nodeTab[0], attr.ptr);
            return std.mem.sliceTo(data, 0);
        } else {
            return std.mem.sliceTo(xpathObj.*.nodesetval.*.nodeTab[0].*.children.*.content, 0);
        }
    }

    return null;
}

fn bgFetchFeed(arena: std.mem.Allocator, rowid: u32, url: []const u8) !void {
    var buf: [256]u8 = undefined;
    var contents: [:0]const u8 = undefined;
    if (DEBUG) {
        const filename = try std.fmt.bufPrint(&buf, "feed-{d}.xml", .{rowid});
        std.debug.print("  bgFetchFeed fetching {s}\n", .{filename});

        const file = std.fs.cwd().openFile(filename, .{}) catch |err| switch (err) {
            error.FileNotFound => return,
            else => |e| return e,
        };
        defer file.close();

        contents = try file.readToEndAllocOptions(arena, 1024 * 1024 * 20, null, @alignOf(u8), 0);
    } else {
        std.debug.print("  bgFetchFeed fetching {s}\n", .{url});

        var easy = try curl.Easy.init();
        defer easy.cleanup();

        const urlZ = try std.fmt.bufPrintZ(&buf, "{s}", .{url});
        try easy.setUrl(urlZ);
        try easy.setSslVerifyPeer(false);
        try easy.setAcceptEncodingGzip();

        const Fifo = std.fifo.LinearFifo(u8, .{ .Dynamic = {} });
        try easy.setWriteFn(struct {
            fn writeFn(ptr: ?[*]u8, size: usize, nmemb: usize, data: ?*anyopaque) callconv(.C) usize {
                _ = size;
                var slice = (ptr orelse return 0)[0..nmemb];
                const fifo = @ptrCast(
                    *Fifo,
                    @alignCast(
                        @alignOf(*Fifo),
                        data orelse return 0,
                    ),
                );

                fifo.writer().writeAll(slice) catch return 0;
                return nmemb;
            }
        }.writeFn);

        var fifo = Fifo.init(arena);
        defer fifo.deinit();
        try easy.setWriteData(&fifo);
        try easy.setVerbose(true);
        easy.perform() catch |err| {
            try gui.dialogOk(@src(), 0, true, "Network Error", try std.fmt.allocPrint(arena, "curl error {!}\ntrying to fetch url:\n{s}", .{ err, url }), null);
        };
        const code = try easy.getResponseCode();
        std.debug.print("  bgFetchFeed curl code {d}\n", .{code});

        // add null byte
        fifo.writeItem(0);

        const tempslice = fifo.readableSlice(0);
        contents = tempslice[0 .. tempslice.len - 1 :0];

        const filename = try std.fmt.bufPrint(&buf, "feed-{d}.xml", .{rowid});
        const file = std.fs.cwd().createFile(filename, .{}) catch |err| switch (err) {
            error.FileNotFound => return,
            else => |e| return e,
        };
        defer file.close();

        try file.writeAll(contents);
    }

    const doc = c.xmlReadDoc(contents.ptr, null, null, 0);
    defer c.xmlFreeDoc(doc);

    var xpathCtx = c.xmlXPathNewContext(doc);
    defer c.xmlXPathFreeContext(xpathCtx);

    {
        var xpathObj = c.xmlXPathEval("/rss/channel", xpathCtx);
        defer c.xmlXPathFreeObject(xpathObj);

        if (xpathObj.*.nodesetval.*.nodeNr > 0) {
            const node = xpathObj.*.nodesetval.*.nodeTab[0];
            _ = c.xmlXPathSetContextNode(node, xpathCtx);

            if (getContent(xpathCtx, "title", null)) |str| {
                _ = try dbRow(arena, "UPDATE podcast SET title=? WHERE rowid=?", i32, .{ str, rowid });
            }

            if (getContent(xpathCtx, "description", null)) |str| {
                _ = try dbRow(arena, "UPDATE podcast SET description=? WHERE rowid=?", i32, .{ str, rowid });
            }

            if (getContent(xpathCtx, "copyright", null)) |str| {
                _ = try dbRow(arena, "UPDATE podcast SET copyright=? WHERE rowid=?", i32, .{ str, rowid });
            }

            if (getContent(xpathCtx, "pubDate", null)) |str| {
                _ = c.setlocale(c.LC_ALL, "C");
                var tm: c.struct_tm = undefined;
                _ = c.strptime(str.ptr, "%a, %e %h %Y %H:%M:%S %z", &tm);
                _ = c.strftime(&buf, buf.len, "%s", &tm);
                _ = c.setlocale(c.LC_ALL, "");

                _ = try dbRow(arena, "UPDATE podcast SET pubDate=? WHERE rowid=?", i32, .{ std.mem.sliceTo(&buf, 0), rowid });
            }

            if (getContent(xpathCtx, "lastBuildDate", null)) |str| {
                _ = try dbRow(arena, "UPDATE podcast SET lastBuildDate=? WHERE rowid=?", i32, .{ str, rowid });
            }

            if (getContent(xpathCtx, "link", null)) |str| {
                _ = try dbRow(arena, "UPDATE podcast SET link=? WHERE rowid=?", i32, .{ str, rowid });
            }

            if (getContent(xpathCtx, "image/url", null)) |str| {
                _ = try dbRow(arena, "UPDATE podcast SET image_url=? WHERE rowid=?", i32, .{ str, rowid });
            }
        }
    }

    {
        var xpathObj = c.xmlXPathEval("//item", xpathCtx);
        defer c.xmlXPathFreeObject(xpathObj);

        var i: usize = 0;
        while (i < xpathObj.*.nodesetval.*.nodeNr) : (i += 1) {
            std.debug.print("node {d}\n", .{i});

            const node = xpathObj.*.nodesetval.*.nodeTab[i];
            _ = c.xmlXPathSetContextNode(node, xpathCtx);

            var episodeRow: ?i64 = null;
            if (getContent(xpathCtx, "guid", null)) |str| {
                if (try dbRow(arena, "SELECT rowid FROM episode WHERE podcast_id=? AND guid=?", i64, .{ rowid, str })) |erow| {
                    std.debug.print("podcast {d} existing episode {d} guid {s}\n", .{ rowid, erow, str });
                    episodeRow = erow;
                } else {
                    std.debug.print("podcast {d} new episode guid {s}\n", .{ rowid, str });
                    _ = try dbRow(arena, "INSERT INTO episode (podcast_id, guid) VALUES (?, ?)", i64, .{ rowid, str });
                    if (g_db) |*db| {
                        episodeRow = db.getLastInsertRowID();
                    }
                }
            } else if (getContent(xpathCtx, "title", null)) |str| {
                if (try dbRow(arena, "SELECT rowid FROM episode WHERE podcast_id=? AND title=?", i64, .{ rowid, str })) |erow| {
                    std.debug.print("podcast {d} existing episode {d} title {s}\n", .{ rowid, erow, str });
                    episodeRow = erow;
                } else {
                    std.debug.print("podcast {d} new episode title {s}\n", .{ rowid, str });
                    _ = try dbRow(arena, "INSERT INTO episode (podcast_id, title) VALUES (?, ?)", i64, .{ rowid, str });
                    if (g_db) |*db| {
                        episodeRow = db.getLastInsertRowID();
                    }
                }
            } else if (getContent(xpathCtx, "description", null)) |str| {
                if (try dbRow(arena, "SELECT rowid FROM episode WHERE podcast_id=? AND description=?", i64, .{ rowid, str })) |erow| {
                    std.debug.print("podcast {d} existing episode {d} description {s}\n", .{ rowid, erow, str });
                    episodeRow = erow;
                } else {
                    std.debug.print("podcast {d} new episode description {s}\n", .{ rowid, str });
                    _ = try dbRow(arena, "INSERT INTO episode (podcast_id, description) VALUES (?, ?)", i64, .{ rowid, str });
                    if (g_db) |*db| {
                        episodeRow = db.getLastInsertRowID();
                    }
                }
            }

            if (episodeRow) |erow| {
                if (getContent(xpathCtx, "guid", null)) |str| {
                    _ = try dbRow(arena, "UPDATE episode SET guid=? WHERE rowid=?", i32, .{ str, erow });
                }

                if (getContent(xpathCtx, "title", null)) |str| {
                    _ = try dbRow(arena, "UPDATE episode SET title=? WHERE rowid=?", i32, .{ str, erow });
                }

                if (getContent(xpathCtx, "description", null)) |str| {
                    _ = try dbRow(arena, "UPDATE episode SET description=? WHERE rowid=?", i32, .{ str, erow });
                }

                if (getContent(xpathCtx, "pubDate", null)) |str| {
                    _ = c.setlocale(c.LC_ALL, "C");
                    var tm: c.struct_tm = undefined;
                    _ = c.strptime(str.ptr, "%a, %e %h %Y %H:%M:%S %z", &tm);
                    _ = c.strftime(&buf, buf.len, "%s", &tm);
                    _ = c.setlocale(c.LC_ALL, "");

                    _ = try dbRow(arena, "UPDATE episode SET pubDate=? WHERE rowid=?", i32, .{ std.mem.sliceTo(&buf, 0), erow });
                }

                if (getContent(xpathCtx, "enclosure", "url")) |str| {
                    _ = try dbRow(arena, "UPDATE episode SET enclosure_url=? WHERE rowid=?", i32, .{ str, erow });
                }
            }
        }
    }
}

fn bgUpdateFeed(arena: std.mem.Allocator, rowid: u32) !void {
    std.debug.print("bgUpdateFeed {d}\n", .{rowid});
    if (try dbRow(arena, "SELECT url FROM podcast WHERE rowid = ?", []const u8, .{rowid})) |url| {
        std.debug.print("  updating url {s}\n", .{url});
        var timer = try std.time.Timer.start();
        try bgFetchFeed(arena, rowid, url);
        const timens = timer.read();
        std.debug.print("  fetch took {d}ms\n", .{timens / 1000000});
    }
}

fn mainGui(arena: std.mem.Allocator) !void {
    //var float = gui.floatingWindow(@src(), 0, false, null, null, .{});
    //defer float.deinit();

    var window_box = try gui.box(@src(), 0, .vertical, .{ .expand = .both, .color_style = .window, .background = true });
    defer window_box.deinit();

    var b = try gui.box(@src(), 0, .vertical, .{ .expand = .both, .background = false });
    defer b.deinit();

    if (g_db) |db| {
        _ = db;
        var paned = try gui.paned(@src(), 0, .horizontal, 400, .{ .expand = .both, .background = false });
        const collapsed = paned.collapsed();

        try podcastSide(arena, paned);
        try episodeSide(arena, paned);

        paned.deinit();

        if (collapsed) {
            try player(arena);
        }
    }
}

pub fn main() !void {
    var backend = try Backend.init(360, 600);
    defer backend.deinit();

    var win = gui.Window.init(gpa, backend.guiBackend());
    defer win.deinit();

    {
        var arena_allocator = std.heap.ArenaAllocator.init(std.heap.page_allocator);
        defer arena_allocator.deinit();
        var arena = arena_allocator.allocator();
        dbInit(arena) catch |err| switch (err) {
            error.DB_ERROR => {},
            else => return err,
        };
    }

    main_loop: while (true) {
        var arena_allocator = std.heap.ArenaAllocator.init(std.heap.page_allocator);
        defer arena_allocator.deinit();
        var arena = arena_allocator.allocator();

        var nstime = win.beginWait(backend.hasEvent());
        try win.begin(arena, nstime);

        const quit = try backend.addAllEvents(&win);
        if (quit) break :main_loop;
        if (g_quit) break :main_loop;

        backend.clear();

        //_ = gui.examples.demo();

        mainGui(arena) catch |err| switch (err) {
            error.DB_ERROR => {},
            else => return err,
        };

        const end_micros = try win.end();

        backend.setCursor(win.cursorRequested());

        backend.renderPresent();

        const wait_event_micros = win.waitTime(end_micros, null);

        backend.waitEventTimeout(wait_event_micros);
    }
}

var add_rss_dialog: bool = false;

fn podcastSide(arena: std.mem.Allocator, paned: *gui.PanedWidget) !void {
    var b = try gui.box(@src(), 0, .vertical, .{ .expand = .both });
    defer b.deinit();

    {
        var overlay = try gui.overlay(@src(), 0, .{ .expand = .horizontal });
        defer overlay.deinit();

        {
            var menu = try gui.menu(@src(), 0, .horizontal, .{ .expand = .horizontal });
            defer menu.deinit();

            _ = gui.spacer(@src(), 0, .{ .expand = .horizontal });

            if (try gui.menuItemIcon(@src(), 0, true, try gui.themeGet().font_heading.lineSkip(), "toolbar dots", gui.icons.papirus.actions.xapp_prefs_toolbar_symbolic, .{})) |r| {
                var fw = try gui.popup(@src(), 0, gui.Rect.fromPoint(gui.Point{ .x = r.x, .y = r.y + r.h }), .{});
                defer fw.deinit();
                if (try gui.menuItemLabel(@src(), 0, "Add RSS", false, .{})) |rr| {
                    _ = rr;
                    gui.menuGet().?.close();
                    add_rss_dialog = true;
                }

                if (try gui.menuItemLabel(@src(), 0, "Update All", false, .{})) |rr| {
                    _ = rr;
                    gui.menuGet().?.close();
                    if (g_db) |*db| {
                        const query = "SELECT rowid FROM podcast";
                        var stmt = db.prepare(query) catch {
                            try dbError("{}\n\npreparing statement:\n\n{s}", .{ db.getDetailedError(), query });
                            return error.DB_ERROR;
                        };
                        defer stmt.deinit();

                        var iter = try stmt.iterator(u32, .{});
                        while (try iter.nextAlloc(arena, .{})) |rowid| {
                            try bgUpdateFeed(arena, rowid);
                        }
                    }
                }
            }
        }

        try gui.label(@src(), 0, "fps {d}", .{@round(gui.FPS())}, .{});
    }

    if (add_rss_dialog) {
        var dialog = try gui.floatingWindow(@src(), 0, true, null, &add_rss_dialog, .{});
        defer dialog.deinit();

        try gui.labelNoFmt(@src(), 0, "Add RSS Feed", .{ .gravity = .center });

        const TextEntryText = struct {
            var text = [_]u8{0} ** 100;
        };

        var te = gui.TextEntryWidget.init(@src(), 0, 26.0, &TextEntryText.text, .{ .gravity = .center });
        if (gui.firstFrame(te.data().id)) {
            std.mem.set(u8, &TextEntryText.text, 0);
            gui.focusWidget(te.wd.id, null);
        }
        try te.install(.{});
        te.deinit();

        var box2 = try gui.box(@src(), 0, .horizontal, .{ .gravity = .right });
        defer box2.deinit();
        if (try gui.button(@src(), 0, "Ok", .{})) {
            dialog.close();
            const url = std.mem.trim(u8, &TextEntryText.text, " \x00");
            const row = try dbRow(arena, "SELECT rowid FROM podcast WHERE url = ?", i32, .{url});
            if (row) |_| {
                try gui.dialogOk(@src(), 0, true, "Note", try std.fmt.allocPrint(arena, "url already in db:\n\n{s}", .{url}), null);
            } else {
                _ = try dbRow(arena, "INSERT INTO podcast (url) VALUES (?)", i32, .{url});
                if (g_db) |*db| {
                    const rowid = db.getLastInsertRowID();
                    _ = rowid;
                }
            }
        }
        if (try gui.button(@src(), 0, "Cancel", .{})) {
            dialog.close();
        }
    }

    var scroll = try gui.scrollArea(@src(), 0, null, .{ .expand = .both, .color_style = .window, .background = false });

    const oo3 = gui.Options{
        .expand = .horizontal,
        .gravity = .left,
        .color_style = .content,
    };

    if (g_db) |*db| {
        const num_podcasts = try dbRow(arena, "SELECT count(*) FROM podcast", usize, .{});

        const query = "SELECT rowid FROM podcast";
        var stmt = db.prepare(query) catch {
            try dbError("{}\n\npreparing statement:\n\n{s}", .{ db.getDetailedError(), query });
            return error.DB_ERROR;
        };
        defer stmt.deinit();

        var iter = try stmt.iterator(u32, .{});
        var i: usize = 1;
        while (try iter.nextAlloc(arena, .{})) |rowid| {
            defer i += 1;

            const title = try dbRow(arena, "SELECT title FROM podcast WHERE rowid=?", []const u8, .{rowid}) orelse "Error: No Title";
            var margin: gui.Rect = .{ .x = 8, .y = 0, .w = 8, .h = 0 };
            var border: gui.Rect = .{ .x = 1, .y = 0, .w = 1, .h = 0 };
            var corner = gui.Rect.all(0);

            if (i != 1) {
                try gui.separator(@src(), i, oo3.override(.{ .margin = margin }));
            }

            if (i == 1) {
                margin.y = 8;
                border.y = 1;
                corner.x = 9;
                corner.y = 9;
            }

            if (i == num_podcasts) {
                margin.h = 8;
                border.h = 1;
                corner.w = 9;
                corner.h = 9;
            }

            if (try gui.button(@src(), i, title, oo3.override(.{
                .margin = margin,
                .border = border,
                .corner_radius = corner,
                .padding = gui.Rect.all(8),
            }))) {
                g_podcast_id_on_right = rowid;
                paned.showOther();
            }
        }
    }

    scroll.deinit();

    if (!paned.collapsed()) {
        try player(arena);
    }
}

fn episodeSide(arena: std.mem.Allocator, paned: *gui.PanedWidget) !void {
    var b = try gui.box(@src(), 0, .vertical, .{ .expand = .both });
    defer b.deinit();

    if (paned.collapsed()) {
        var menu = try gui.menu(@src(), 0, .horizontal, .{ .expand = .horizontal });
        defer menu.deinit();

        if (try gui.menuItemLabel(@src(), 0, "Back", false, .{})) |rr| {
            _ = rr;
            paned.showOther();
        }
    }

    if (g_db) |*db| {
        const num_episodes = try dbRow(arena, "SELECT count(*) FROM episode WHERE podcast_id = ?", usize, .{g_podcast_id_on_right}) orelse 0;
        const height: f32 = 200;

        var scroll = try gui.scrollArea(@src(), 0, gui.Size{ .w = 0, .h = height * @intToFloat(f32, num_episodes) }, .{ .expand = .both, .background = false });
        defer scroll.deinit();

        const query = "SELECT rowid, title, description FROM episode WHERE podcast_id = ?";
        var stmt = db.prepare(query) catch {
            try dbError("{}\n\npreparing statement:\n\n{s}", .{ db.getDetailedError(), query });
            return error.DB_ERROR;
        };
        defer stmt.deinit();

        const visibleRect = scroll.visibleRect();
        var cursor: f32 = 0;

        var iter = try stmt.iterator(Episode, .{g_podcast_id_on_right});
        while (try iter.nextAlloc(arena, .{})) |episode| {
            defer cursor += height;
            const r = gui.Rect{ .x = 0, .y = cursor, .w = 0, .h = height };
            if (visibleRect.intersect(r).h > 0) {
                var tl = try gui.textLayout(@src(), episode.rowid, .{ .expand = .horizontal, .rect = r });
                defer tl.deinit();

                var cbox = try gui.box(@src(), 0, .vertical, gui.Options{ .gravity = .upright });

                _ = try gui.buttonIcon(@src(), 0, 18, "play", gui.icons.papirus.actions.media_playback_start_symbolic, .{ .padding = gui.Rect.all(6) });
                _ = try gui.buttonIcon(@src(), 0, 18, "more", gui.icons.papirus.actions.view_more_symbolic, .{ .padding = gui.Rect.all(6) });

                cbox.deinit();

                var f = gui.themeGet().font_heading;
                f.line_skip_factor = 1.3;
                try tl.format("{s}\n", .{episode.title}, .{ .font_style = .custom, .font_custom = f });
                //const lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
                //try tl.addText(lorem, .{});
                try tl.addText(episode.description, .{});
            }
        }
    }
}

fn player(arena: std.mem.Allocator) !void {
    const oo = gui.Options{
        .expand = .horizontal,
        .color_style = .content,
    };

    var box2 = try gui.box(@src(), 0, .vertical, oo.override(.{ .background = true }));
    defer box2.deinit();

    var episode = Episode{ .rowid = 0, .title = "Episode Title", .description = "" };

    const episode_id = try dbRow(arena, "SELECT episode_id FROM player", i32, .{});
    if (episode_id) |id| {
        episode = try dbRow(arena, "SELECT rowid, title FROM episode WHERE rowid = ?", Episode, .{id}) orelse episode;
    }

    try gui.label(@src(), 0, "{s}", .{episode.title}, oo.override(.{
        .margin = gui.Rect{ .x = 8, .y = 4, .w = 8, .h = 4 },
        .font_style = .heading,
    }));

    var box3 = try gui.box(@src(), 0, .horizontal, oo.override(.{ .padding = .{ .x = 4, .y = 0, .w = 4, .h = 4 } }));
    defer box3.deinit();

    const oo2 = gui.Options{ .expand = .horizontal, .gravity = .center };

    _ = try gui.buttonIcon(@src(), 0, 20, "back", gui.icons.papirus.actions.media_seek_backward_symbolic, oo2);

    try gui.label(@src(), 0, "0.00%", .{}, oo2.override(.{ .color_style = .content }));

    _ = try gui.buttonIcon(@src(), 0, 20, "forward", gui.icons.papirus.actions.media_seek_forward_symbolic, oo2);

    _ = try gui.buttonIcon(@src(), 0, 20, "play", gui.icons.papirus.actions.media_playback_start_symbolic, oo2);
}
