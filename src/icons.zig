
pub const papirus = struct {
  pub const actions = struct {
    pub const action_unavailable_symbolic = @embedFile("icons/papirus/actions/action-unavailable-symbolic.tvg");
    pub const address_book_new_symbolic = @embedFile("icons/papirus/actions/address-book-new-symbolic.tvg");
    pub const application_exit_symbolic = @embedFile("icons/papirus/actions/application-exit-symbolic.tvg");
    pub const application_menu_symbolic = @embedFile("icons/papirus/actions/application-menu-symbolic.tvg");
    pub const appointment_new_symbolic = @embedFile("icons/papirus/actions/appointment-new-symbolic.tvg");
    pub const bookmark_new_symbolic = @embedFile("icons/papirus/actions/bookmark-new-symbolic.tvg");
    pub const browser_download_symbolic = @embedFile("icons/papirus/actions/browser-download-symbolic.tvg");
    pub const calendar_go_today_symbolic = @embedFile("icons/papirus/actions/calendar-go-today-symbolic.tvg");
    pub const call_start_symbolic = @embedFile("icons/papirus/actions/call-start-symbolic.tvg");
    pub const call_stop_symbolic = @embedFile("icons/papirus/actions/call-stop-symbolic.tvg");
    pub const category_search_symbolic = @embedFile("icons/papirus/actions/category-search-symbolic.tvg");
    pub const chat_message_new_symbolic = @embedFile("icons/papirus/actions/chat-message-new-symbolic.tvg");
    pub const color_select_symbolic = @embedFile("icons/papirus/actions/color-select-symbolic.tvg");
    pub const contact_new_symbolic = @embedFile("icons/papirus/actions/contact-new-symbolic.tvg");
    pub const dino_double_tick_symbolic = @embedFile("icons/papirus/actions/dino-double-tick-symbolic.tvg");
    pub const dino_tick_symbolic = @embedFile("icons/papirus/actions/dino-tick-symbolic.tvg");
    pub const document_export_symbolic = @embedFile("icons/papirus/actions/document-export-symbolic.tvg");
    pub const document_import_symbolic = @embedFile("icons/papirus/actions/document-import-symbolic.tvg");
    pub const document_new_symbolic = @embedFile("icons/papirus/actions/document-new-symbolic.tvg");
    pub const document_open_recent_symbolic = @embedFile("icons/papirus/actions/document-open-recent-symbolic.tvg");
    pub const document_open_symbolic = @embedFile("icons/papirus/actions/document-open-symbolic.tvg");
    pub const document_page_setup_symbolic = @embedFile("icons/papirus/actions/document-page-setup-symbolic.tvg");
    pub const document_print_preview_symbolic = @embedFile("icons/papirus/actions/document-print-preview-symbolic.tvg");
    pub const document_print_symbolic = @embedFile("icons/papirus/actions/document-print-symbolic.tvg");
    pub const document_properties_symbolic = @embedFile("icons/papirus/actions/document-properties-symbolic.tvg");
    pub const document_revert_rtl_symbolic = @embedFile("icons/papirus/actions/document-revert-rtl-symbolic.tvg");
    pub const document_revert_symbolic = @embedFile("icons/papirus/actions/document-revert-symbolic.tvg");
    pub const document_save_as_symbolic = @embedFile("icons/papirus/actions/document-save-as-symbolic.tvg");
    pub const document_save_symbolic = @embedFile("icons/papirus/actions/document-save-symbolic.tvg");
    pub const document_send_symbolic = @embedFile("icons/papirus/actions/document-send-symbolic.tvg");
    pub const edit_clear_all_symbolic = @embedFile("icons/papirus/actions/edit-clear-all-symbolic.tvg");
    pub const edit_clear_symbolic_rtl = @embedFile("icons/papirus/actions/edit-clear-symbolic-rtl.tvg");
    pub const edit_clear_symbolic = @embedFile("icons/papirus/actions/edit-clear-symbolic.tvg");
    pub const edit_copy_symbolic = @embedFile("icons/papirus/actions/edit-copy-symbolic.tvg");
    pub const edit_cut_symbolic = @embedFile("icons/papirus/actions/edit-cut-symbolic.tvg");
    pub const edit_delete_symbolic = @embedFile("icons/papirus/actions/edit-delete-symbolic.tvg");
    pub const edit_find_replace_symbolic = @embedFile("icons/papirus/actions/edit-find-replace-symbolic.tvg");
    pub const edit_find_symbolic = @embedFile("icons/papirus/actions/edit-find-symbolic.tvg");
    pub const edit_paste_symbolic = @embedFile("icons/papirus/actions/edit-paste-symbolic.tvg");
    pub const edit_redo_symbolic = @embedFile("icons/papirus/actions/edit-redo-symbolic.tvg");
    pub const edit_select_all_symbolic = @embedFile("icons/papirus/actions/edit-select-all-symbolic.tvg");
    pub const edit_select_symbolic = @embedFile("icons/papirus/actions/edit-select-symbolic.tvg");
    pub const edit_symbolic = @embedFile("icons/papirus/actions/edit-symbolic.tvg");
    pub const edit_tag_symbolic = @embedFile("icons/papirus/actions/edit-tag-symbolic.tvg");
    pub const edit_undo_symbolic = @embedFile("icons/papirus/actions/edit-undo-symbolic.tvg");
    pub const ephy_bookmarks_symbolic = @embedFile("icons/papirus/actions/ephy-bookmarks-symbolic.tvg");
    pub const ephy_reader_mode_symbolic = @embedFile("icons/papirus/actions/ephy-reader-mode-symbolic.tvg");
    pub const extract_archive_symbolic = @embedFile("icons/papirus/actions/extract-archive-symbolic.tvg");
    pub const fcitx_fullwidth_active_symbolic = @embedFile("icons/papirus/actions/fcitx-fullwidth-active-symbolic.tvg");
    pub const fcitx_fullwidth_inactive_symbolic = @embedFile("icons/papirus/actions/fcitx-fullwidth-inactive-symbolic.tvg");
    pub const fcitx_punc_active_symbolic = @embedFile("icons/papirus/actions/fcitx-punc-active-symbolic.tvg");
    pub const fcitx_punc_inactive_symbolic = @embedFile("icons/papirus/actions/fcitx-punc-inactive-symbolic.tvg");
    pub const fcitx_vk_active_symbolic = @embedFile("icons/papirus/actions/fcitx-vk-active-symbolic.tvg");
    pub const fcitx_vk_inactive_symbolic = @embedFile("icons/papirus/actions/fcitx-vk-inactive-symbolic.tvg");
    pub const find_location_symbolic = @embedFile("icons/papirus/actions/find-location-symbolic.tvg");
    pub const focus_legacy_systray_symbolic = @embedFile("icons/papirus/actions/focus-legacy-systray-symbolic.tvg");
    pub const focus_top_bar_symbolic = @embedFile("icons/papirus/actions/focus-top-bar-symbolic.tvg");
    pub const focus_windows_symbolic = @embedFile("icons/papirus/actions/focus-windows-symbolic.tvg");
    pub const folder_new_symbolic = @embedFile("icons/papirus/actions/folder-new-symbolic.tvg");
    pub const font_select_symbolic = @embedFile("icons/papirus/actions/font-select-symbolic.tvg");
    pub const format_indent_less_symbolic = @embedFile("icons/papirus/actions/format-indent-less-symbolic.tvg");
    pub const format_indent_more_symbolic = @embedFile("icons/papirus/actions/format-indent-more-symbolic.tvg");
    pub const format_justify_center_symbolic = @embedFile("icons/papirus/actions/format-justify-center-symbolic.tvg");
    pub const format_justify_fill_symbolic = @embedFile("icons/papirus/actions/format-justify-fill-symbolic.tvg");
    pub const format_justify_left_symbolic = @embedFile("icons/papirus/actions/format-justify-left-symbolic.tvg");
    pub const format_justify_right_symbolic = @embedFile("icons/papirus/actions/format-justify-right-symbolic.tvg");
    pub const format_text_bold_symbolic = @embedFile("icons/papirus/actions/format-text-bold-symbolic.tvg");
    pub const format_text_direction_ltr_symbolic = @embedFile("icons/papirus/actions/format-text-direction-ltr-symbolic.tvg");
    pub const format_text_direction_rtl_symbolic = @embedFile("icons/papirus/actions/format-text-direction-rtl-symbolic.tvg");
    pub const format_text_italic_symbolic = @embedFile("icons/papirus/actions/format-text-italic-symbolic.tvg");
    pub const format_text_larger_symbolic = @embedFile("icons/papirus/actions/format-text-larger-symbolic.tvg");
    pub const format_text_remove_formatting_symbolic = @embedFile("icons/papirus/actions/format-text-remove-formatting-symbolic.tvg");
    pub const format_text_smaller_symbolic = @embedFile("icons/papirus/actions/format-text-smaller-symbolic.tvg");
    pub const format_text_strikethrough_symbolic = @embedFile("icons/papirus/actions/format-text-strikethrough-symbolic.tvg");
    pub const format_text_underline_symbolic = @embedFile("icons/papirus/actions/format-text-underline-symbolic.tvg");
    pub const go_bottom_symbolic = @embedFile("icons/papirus/actions/go-bottom-symbolic.tvg");
    pub const go_down_symbolic = @embedFile("icons/papirus/actions/go-down-symbolic.tvg");
    pub const go_first_symbolic = @embedFile("icons/papirus/actions/go-first-symbolic.tvg");
    pub const go_home_symbolic = @embedFile("icons/papirus/actions/go-home-symbolic.tvg");
    pub const go_jump_rtl_symbolic = @embedFile("icons/papirus/actions/go-jump-rtl-symbolic.tvg");
    pub const go_jump_symbolic = @embedFile("icons/papirus/actions/go-jump-symbolic.tvg");
    pub const go_last_symbolic = @embedFile("icons/papirus/actions/go-last-symbolic.tvg");
    pub const go_next_symbolic = @embedFile("icons/papirus/actions/go-next-symbolic.tvg");
    pub const go_previous_symbolic = @embedFile("icons/papirus/actions/go-previous-symbolic.tvg");
    pub const go_top_symbolic = @embedFile("icons/papirus/actions/go-top-symbolic.tvg");
    pub const go_up_symbolic = @embedFile("icons/papirus/actions/go-up-symbolic.tvg");
    pub const help_info_symbolic = @embedFile("icons/papirus/actions/help-info-symbolic.tvg");
    pub const image_crop_symbolic = @embedFile("icons/papirus/actions/image-crop-symbolic.tvg");
    pub const image_denoise_symbolic = @embedFile("icons/papirus/actions/image-denoise-symbolic.tvg");
    pub const image_filter_symbolic = @embedFile("icons/papirus/actions/image-filter-symbolic.tvg");
    pub const image_red_eye_symbolic = @embedFile("icons/papirus/actions/image-red-eye-symbolic.tvg");
    pub const image_resize_symbolic = @embedFile("icons/papirus/actions/image-resize-symbolic.tvg");
    pub const image_sharpen_symbolic = @embedFile("icons/papirus/actions/image-sharpen-symbolic.tvg");
    pub const image_straighten_symbolic = @embedFile("icons/papirus/actions/image-straighten-symbolic.tvg");
    pub const insert_emoticon_symbolic = @embedFile("icons/papirus/actions/insert-emoticon-symbolic.tvg");
    pub const insert_image_symbolic = @embedFile("icons/papirus/actions/insert-image-symbolic.tvg");
    pub const insert_link_symbolic = @embedFile("icons/papirus/actions/insert-link-symbolic.tvg");
    pub const insert_object_symbolic = @embedFile("icons/papirus/actions/insert-object-symbolic.tvg");
    pub const insert_text_symbolic = @embedFile("icons/papirus/actions/insert-text-symbolic.tvg");
    pub const keyboard_caps_lock_filled_symbolic = @embedFile("icons/papirus/actions/keyboard-caps-lock-filled-symbolic.tvg");
    pub const keyboard_enter_symbolic = @embedFile("icons/papirus/actions/keyboard-enter-symbolic.tvg");
    pub const keyboard_hide_symbolic = @embedFile("icons/papirus/actions/keyboard-hide-symbolic.tvg");
    pub const keyboard_layout_filled_symbolic = @embedFile("icons/papirus/actions/keyboard-layout-filled-symbolic.tvg");
    pub const keyboard_shift_filled_symbolic = @embedFile("icons/papirus/actions/keyboard-shift-filled-symbolic.tvg");
    pub const link_symbolic = @embedFile("icons/papirus/actions/link-symbolic.tvg");
    pub const list_add_symbolic = @embedFile("icons/papirus/actions/list-add-symbolic.tvg");
    pub const list_remove_all_symbolic = @embedFile("icons/papirus/actions/list-remove-all-symbolic.tvg");
    pub const list_remove_symbolic = @embedFile("icons/papirus/actions/list-remove-symbolic.tvg");
    pub const location_symbolic = @embedFile("icons/papirus/actions/location-symbolic.tvg");
    pub const mail_flag_symbolic = @embedFile("icons/papirus/actions/mail-flag-symbolic.tvg");
    pub const mail_forward_symbolic = @embedFile("icons/papirus/actions/mail-forward-symbolic.tvg");
    pub const mail_mark_important_symbolic = @embedFile("icons/papirus/actions/mail-mark-important-symbolic.tvg");
    pub const mail_mark_junk_symbolic = @embedFile("icons/papirus/actions/mail-mark-junk-symbolic.tvg");
    pub const mail_mark_notjunk_symbolic = @embedFile("icons/papirus/actions/mail-mark-notjunk-symbolic.tvg");
    pub const mail_mark_read_symbolic = @embedFile("icons/papirus/actions/mail-mark-read-symbolic.tvg");
    pub const mail_mark_unread_symbolic = @embedFile("icons/papirus/actions/mail-mark-unread-symbolic.tvg");
    pub const mail_message_new_symbolic = @embedFile("icons/papirus/actions/mail-message-new-symbolic.tvg");
    pub const mail_reply_all_symbolic_rtl = @embedFile("icons/papirus/actions/mail-reply-all-symbolic-rtl.tvg");
    pub const mail_reply_all_symbolic = @embedFile("icons/papirus/actions/mail-reply-all-symbolic.tvg");
    pub const mail_reply_symbolic = @embedFile("icons/papirus/actions/mail-reply-symbolic.tvg");
    pub const mail_send_receive_symbolic = @embedFile("icons/papirus/actions/mail-send-receive-symbolic.tvg");
    pub const mail_send_symbolic = @embedFile("icons/papirus/actions/mail-send-symbolic.tvg");
    pub const mark_location_symbolic = @embedFile("icons/papirus/actions/mark-location-symbolic.tvg");
    pub const media_eject_symbolic = @embedFile("icons/papirus/actions/media-eject-symbolic.tvg");
    pub const media_mount_symbolic = @embedFile("icons/papirus/actions/media-mount-symbolic.tvg");
    pub const media_playback_pause_symbolic = @embedFile("icons/papirus/actions/media-playback-pause-symbolic.tvg");
    pub const media_playback_start_rtl_symbolic = @embedFile("icons/papirus/actions/media-playback-start-rtl-symbolic.tvg");
    pub const media_playback_start_symbolic = @embedFile("icons/papirus/actions/media-playback-start-symbolic.tvg");
    pub const media_playback_stop_symbolic = @embedFile("icons/papirus/actions/media-playback-stop-symbolic.tvg");
    pub const media_record_symbolic = @embedFile("icons/papirus/actions/media-record-symbolic.tvg");
    pub const media_seek_backward_symbolic = @embedFile("icons/papirus/actions/media-seek-backward-symbolic.tvg");
    pub const media_seek_forward_symbolic = @embedFile("icons/papirus/actions/media-seek-forward-symbolic.tvg");
    pub const media_skip_backward_symbolic = @embedFile("icons/papirus/actions/media-skip-backward-symbolic.tvg");
    pub const media_skip_forward_symbolic = @embedFile("icons/papirus/actions/media-skip-forward-symbolic.tvg");
    pub const media_view_subtitles_symbolic = @embedFile("icons/papirus/actions/media-view-subtitles-symbolic.tvg");
    pub const object_flip_horizontal_symbolic = @embedFile("icons/papirus/actions/object-flip-horizontal-symbolic.tvg");
    pub const object_flip_vertical_symbolic = @embedFile("icons/papirus/actions/object-flip-vertical-symbolic.tvg");
    pub const object_merge_symbolic = @embedFile("icons/papirus/actions/object-merge-symbolic.tvg");
    pub const object_move_symbolic = @embedFile("icons/papirus/actions/object-move-symbolic.tvg");
    pub const object_rotate_left_symbolic = @embedFile("icons/papirus/actions/object-rotate-left-symbolic.tvg");
    pub const object_rotate_right_symbolic = @embedFile("icons/papirus/actions/object-rotate-right-symbolic.tvg");
    pub const object_select_symbolic = @embedFile("icons/papirus/actions/object-select-symbolic.tvg");
    pub const object_straighten_symbolic = @embedFile("icons/papirus/actions/object-straighten-symbolic.tvg");
    pub const open_menu_symbolic = @embedFile("icons/papirus/actions/open-menu-symbolic.tvg");
    pub const pan_down_symbolic = @embedFile("icons/papirus/actions/pan-down-symbolic.tvg");
    pub const pan_end_symbolic = @embedFile("icons/papirus/actions/pan-end-symbolic.tvg");
    pub const pan_start_symbolic = @embedFile("icons/papirus/actions/pan-start-symbolic.tvg");
    pub const pan_up_symbolic = @embedFile("icons/papirus/actions/pan-up-symbolic.tvg");
    pub const pane_hide_symbolic = @embedFile("icons/papirus/actions/pane-hide-symbolic.tvg");
    pub const pane_show_symbolic = @embedFile("icons/papirus/actions/pane-show-symbolic.tvg");
    pub const process_stop_symbolic = @embedFile("icons/papirus/actions/process-stop-symbolic.tvg");
    pub const qrscanner_symbolic = @embedFile("icons/papirus/actions/qrscanner-symbolic.tvg");
    pub const selection_end_symbolic = @embedFile("icons/papirus/actions/selection-end-symbolic.tvg");
    pub const selection_start_symbolic = @embedFile("icons/papirus/actions/selection-start-symbolic.tvg");
    pub const send_to_symbolic = @embedFile("icons/papirus/actions/send-to-symbolic.tvg");
    pub const sidebar_places_symbolic = @embedFile("icons/papirus/actions/sidebar-places-symbolic.tvg");
    pub const sidebar_show_right_symbolic = @embedFile("icons/papirus/actions/sidebar-show-right-symbolic.tvg");
    pub const sidebar_show_symbolic = @embedFile("icons/papirus/actions/sidebar-show-symbolic.tvg");
    pub const star_new_symbolic = @embedFile("icons/papirus/actions/star-new-symbolic.tvg");
    pub const system_hibernate_symbolic = @embedFile("icons/papirus/actions/system-hibernate-symbolic.tvg");
    pub const system_lock_screen_symbolic = @embedFile("icons/papirus/actions/system-lock-screen-symbolic.tvg");
    pub const system_log_out_symbolic = @embedFile("icons/papirus/actions/system-log-out-symbolic.tvg");
    pub const system_restart_symbolic = @embedFile("icons/papirus/actions/system-restart-symbolic.tvg");
    pub const system_run_symbolic = @embedFile("icons/papirus/actions/system-run-symbolic.tvg");
    pub const system_shutdown_symbolic = @embedFile("icons/papirus/actions/system-shutdown-symbolic.tvg");
    pub const system_suspend_symbolic = @embedFile("icons/papirus/actions/system-suspend-symbolic.tvg");
    pub const system_switch_user_symbolic = @embedFile("icons/papirus/actions/system-switch-user-symbolic.tvg");
    pub const tab_new_symbolic = @embedFile("icons/papirus/actions/tab-new-symbolic.tvg");
    pub const tool_arc_symbolic = @embedFile("icons/papirus/actions/tool-arc-symbolic.tvg");
    pub const tool_brush_symbolic = @embedFile("icons/papirus/actions/tool-brush-symbolic.tvg");
    pub const tool_circle_symbolic = @embedFile("icons/papirus/actions/tool-circle-symbolic.tvg");
    pub const tool_eraser_symbolic = @embedFile("icons/papirus/actions/tool-eraser-symbolic.tvg");
    pub const tool_filters_symbolic = @embedFile("icons/papirus/actions/tool-filters-symbolic.tvg");
    pub const tool_freeshape_symbolic = @embedFile("icons/papirus/actions/tool-freeshape-symbolic.tvg");
    pub const tool_highlight_symbolic = @embedFile("icons/papirus/actions/tool-highlight-symbolic.tvg");
    pub const tool_line_symbolic = @embedFile("icons/papirus/actions/tool-line-symbolic.tvg");
    pub const tool_magic_symbolic = @embedFile("icons/papirus/actions/tool-magic-symbolic.tvg");
    pub const tool_oval_symbolic = @embedFile("icons/papirus/actions/tool-oval-symbolic.tvg");
    pub const tool_paint_symbolic = @embedFile("icons/papirus/actions/tool-paint-symbolic.tvg");
    pub const tool_polygon_symbolic = @embedFile("icons/papirus/actions/tool-polygon-symbolic.tvg");
    pub const tool_rectangle_symbolic = @embedFile("icons/papirus/actions/tool-rectangle-symbolic.tvg");
    pub const tool_roundedrect_symbolic = @embedFile("icons/papirus/actions/tool-roundedrect-symbolic.tvg");
    pub const tool_skew_symbolic = @embedFile("icons/papirus/actions/tool-skew-symbolic.tvg");
    pub const tools_check_spelling_symbolic = @embedFile("icons/papirus/actions/tools-check-spelling-symbolic.tvg");
    pub const twitter_dm_symbolic = @embedFile("icons/papirus/actions/twitter-dm-symbolic.tvg");
    pub const twitter_home_symbolic = @embedFile("icons/papirus/actions/twitter-home-symbolic.tvg");
    pub const twitter_mentions_symbolic = @embedFile("icons/papirus/actions/twitter-mentions-symbolic.tvg");
    pub const twitter_profile_symbolic = @embedFile("icons/papirus/actions/twitter-profile-symbolic.tvg");
    pub const value_decrease_symbolic = @embedFile("icons/papirus/actions/value-decrease-symbolic.tvg");
    pub const value_increase_symbolic = @embedFile("icons/papirus/actions/value-increase-symbolic.tvg");
    pub const view_app_grid_symbolic = @embedFile("icons/papirus/actions/view-app-grid-symbolic.tvg");
    pub const view_bottom_pane_symbolic = @embedFile("icons/papirus/actions/view-bottom-pane-symbolic.tvg");
    pub const view_column_symbolic = @embedFile("icons/papirus/actions/view-column-symbolic.tvg");
    pub const view_compact_symbolic = @embedFile("icons/papirus/actions/view-compact-symbolic.tvg");
    pub const view_continuous_symbolic = @embedFile("icons/papirus/actions/view-continuous-symbolic.tvg");
    pub const view_coverflow_symbolic = @embedFile("icons/papirus/actions/view-coverflow-symbolic.tvg");
    pub const view_dual_symbolic = @embedFile("icons/papirus/actions/view-dual-symbolic.tvg");
    pub const view_filter_rtl_symbolic = @embedFile("icons/papirus/actions/view-filter-rtl-symbolic.tvg");
    pub const view_filter_symbolic = @embedFile("icons/papirus/actions/view-filter-symbolic.tvg");
    pub const view_fullscreen_symbolic = @embedFile("icons/papirus/actions/view-fullscreen-symbolic.tvg");
    pub const view_grid_symbolic = @embedFile("icons/papirus/actions/view-grid-symbolic.tvg");
    pub const view_left_pane_symbolic = @embedFile("icons/papirus/actions/view-left-pane-symbolic.tvg");
    pub const view_list_bullet_symbolic = @embedFile("icons/papirus/actions/view-list-bullet-symbolic.tvg");
    pub const view_list_compact_symbolic = @embedFile("icons/papirus/actions/view-list-compact-symbolic.tvg");
    pub const view_list_images_symbolic = @embedFile("icons/papirus/actions/view-list-images-symbolic.tvg");
    pub const view_list_ordered_symbolic = @embedFile("icons/papirus/actions/view-list-ordered-symbolic.tvg");
    pub const view_list_symbolic = @embedFile("icons/papirus/actions/view-list-symbolic.tvg");
    pub const view_list_video_symbolic = @embedFile("icons/papirus/actions/view-list-video-symbolic.tvg");
    pub const view_mirror_symbolic = @embedFile("icons/papirus/actions/view-mirror-symbolic.tvg");
    pub const view_more_horizontal_symbolic = @embedFile("icons/papirus/actions/view-more-horizontal-symbolic.tvg");
    pub const view_more_symbolic = @embedFile("icons/papirus/actions/view-more-symbolic.tvg");
    pub const view_paged_symbolic = @embedFile("icons/papirus/actions/view-paged-symbolic.tvg");
    pub const view_pin_symbolic = @embedFile("icons/papirus/actions/view-pin-symbolic.tvg");
    pub const view_refresh_symbolic = @embedFile("icons/papirus/actions/view-refresh-symbolic.tvg");
    pub const view_restore_symbolic = @embedFile("icons/papirus/actions/view-restore-symbolic.tvg");
    pub const view_right_pane_symbolic = @embedFile("icons/papirus/actions/view-right-pane-symbolic.tvg");
    pub const view_sort_ascending_symbolic = @embedFile("icons/papirus/actions/view-sort-ascending-symbolic.tvg");
    pub const view_sort_descending_symbolic = @embedFile("icons/papirus/actions/view-sort-descending-symbolic.tvg");
    pub const view_top_pane_symbolic = @embedFile("icons/papirus/actions/view-top-pane-symbolic.tvg");
    pub const window_close_symbolic = @embedFile("icons/papirus/actions/window-close-symbolic.tvg");
    pub const window_maximize_symbolic = @embedFile("icons/papirus/actions/window-maximize-symbolic.tvg");
    pub const window_minimize_symbolic = @embedFile("icons/papirus/actions/window-minimize-symbolic.tvg");
    pub const window_pop_out_symbolic = @embedFile("icons/papirus/actions/window-pop-out-symbolic.tvg");
    pub const window_restore_symbolic = @embedFile("icons/papirus/actions/window-restore-symbolic.tvg");
    pub const xapp_go_history_next_symbolic = @embedFile("icons/papirus/actions/xapp-go-history-next-symbolic.tvg");
    pub const xapp_go_history_previous_symbolic = @embedFile("icons/papirus/actions/xapp-go-history-previous-symbolic.tvg");
    pub const xapp_prefs_display_symbolic = @embedFile("icons/papirus/actions/xapp-prefs-display-symbolic.tvg");
    pub const xapp_prefs_plugins_symbolic = @embedFile("icons/papirus/actions/xapp-prefs-plugins-symbolic.tvg");
    pub const xapp_prefs_preview_symbolic = @embedFile("icons/papirus/actions/xapp-prefs-preview-symbolic.tvg");
    pub const xapp_prefs_toolbar_symbolic = @embedFile("icons/papirus/actions/xapp-prefs-toolbar-symbolic.tvg");
    pub const xapp_search_wrap_symbolic = @embedFile("icons/papirus/actions/xapp-search-wrap-symbolic.tvg");
    pub const xapp_text_case_symbolic = @embedFile("icons/papirus/actions/xapp-text-case-symbolic.tvg");
    pub const xapp_use_regex_symbolic = @embedFile("icons/papirus/actions/xapp-use-regex-symbolic.tvg");
    pub const ymuse_consume_symbolic = @embedFile("icons/papirus/actions/ymuse-consume-symbolic.tvg");
    pub const ymuse_delete_symbolic = @embedFile("icons/papirus/actions/ymuse-delete-symbolic.tvg");
    pub const ymuse_delete_track_symbolic = @embedFile("icons/papirus/actions/ymuse-delete-track-symbolic.tvg");
    pub const ymuse_filter_symbolic = @embedFile("icons/papirus/actions/ymuse-filter-symbolic.tvg");
    pub const ymuse_level_up_symbolic = @embedFile("icons/papirus/actions/ymuse-level-up-symbolic.tvg");
    pub const ymuse_now_playing_symbolic = @embedFile("icons/papirus/actions/ymuse-now-playing-symbolic.tvg");
    pub const ymuse_random_symbolic = @embedFile("icons/papirus/actions/ymuse-random-symbolic.tvg");
    pub const ymuse_repeat_symbolic = @embedFile("icons/papirus/actions/ymuse-repeat-symbolic.tvg");
    pub const ymuse_replace_queue_symbolic = @embedFile("icons/papirus/actions/ymuse-replace-queue-symbolic.tvg");
    pub const ymuse_update_db_symbolic = @embedFile("icons/papirus/actions/ymuse-update-db-symbolic.tvg");
    pub const zoom_fit_best_symbolic = @embedFile("icons/papirus/actions/zoom-fit-best-symbolic.tvg");
    pub const zoom_in_symbolic = @embedFile("icons/papirus/actions/zoom-in-symbolic.tvg");
    pub const zoom_original_symbolic = @embedFile("icons/papirus/actions/zoom-original-symbolic.tvg");
    pub const zoom_out_symbolic = @embedFile("icons/papirus/actions/zoom-out-symbolic.tvg");
  };
};