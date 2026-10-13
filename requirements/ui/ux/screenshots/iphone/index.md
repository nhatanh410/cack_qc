# Screenshot Index — iPhone

Bảng tra tên file mới ↔ tên gốc từ iOS ↔ mô tả màn hình.
Quy tắc đặt tên: [.claude/rules/screenshot-naming.md](../../../../../.claude/rules/screenshot-naming.md)

Tổng: **114 screenshot** / 11 flow đã build. iPhone (1290×2796 trừ khi ghi chú khác).

## Lịch sử chụp

| Batch | Ngày | Build | Ghi chú |
|---|---|---|---|
| 1 | 2026-08-14 → 19 | TestFlight 1.2.10 (27) | Batch gốc — 57 ảnh, 10 flow. Chi tiết dưới đây. |
| 2 | 2026-09-09 | TestFlight, build chưa xác định | Batch refresh Phase 2 — `06_task` matrix (4 ảnh: `default`, `completed-empty`, `customize`, `customize-scrolled`). Khớp `screen-no 05` với ảnh iPad đã có. Còn thiếu build number — điền khi xác nhận được. |
| 3 | 2026-09-12 | TestFlight 1.2.15 (56) | Flow mới `14_edit-wallpaper` (Decorate) — 16 ảnh, chỉ portrait (UI không xoay trên iPhone). Còn thiếu 2 state so với checklist gốc (eyedropper, limit-warning). |
| 4 | 2026-09-22 | Ink Dev, nhánh `fix/ios27-shortcut-automation`, build/commit chưa xác nhận | 1 ảnh — `14_edit-wallpaper_01_wallpaper-editor_home-screen-off.png`, chụp ngoài quy trình batch (file gốc dạng `Screenshot ... .png`, không phải `IMG_xxxx`) để minh hoạ tính năng Home Screen mode mới đang QC ở [test-plan-ios26-27.md](../../../../test-plans/shortcuts/test-plan-ios26-27.md). Kích thước chưa xác nhận qua công cụ (không đọc được metadata). |
| 5 | 2026-09-24 | Ink Dev, nhánh `feat/component-editor`, build/commit chưa xác nhận | 12 ảnh — screen-no mới `03_component-editor` (+ 1 state entry trên `01_wallpaper-editor`) cho tính năng "Wallpaper Component Editor" đang build, xem [wallpaper-component-editor-prd.md](../../../../specs/wallpaper-editor/component-editor/wallpaper-component-editor-prd.md). Chụp ngoài quy trình batch (file gốc dạng `Screenshot ... .png`, không phải `IMG_xxxx`). Kích thước chưa xác nhận qua công cụ. |
| 6 | 2026-09-28 | **Build chưa xác nhận qua công cụ** — ảnh không hiện số build; nội dung khớp spec 1.2.18 (111, rc3) nên nhiều khả năng cùng lứa, **chưa có bằng chứng** (xem `answers-1.2.18.md` mục Q-21, Q-19) | 2 ảnh — `03_component-editor` `add-component-v2` + `add-component-scrolled-v2`: sheet **Add component** bản **1.2.18** (16 mục, 5 nhóm, **không** có nhóm Text, **không** có Timeline). QC gửi trực tiếp (dán vào chat), 1290×2796. Còn thiếu ảnh baseline khác cho 1.2.18 — xem Coverage matrix Phần 3 của [`exploratory/14_edit-wallpaper.md`](../../../../exploratory/14_edit-wallpaper.md). |
| 7 | 2026-09-29 | **TestFlight, build/commit chưa xác nhận** — ảnh không hiện số build; nội dung khớp spec TF-117 (`component-editor-specs-dev-change(TF-117).md`) nên nhiều khả năng cùng lứa, **chưa có bằng chứng qua công cụ** | 17 ảnh — screen-no mới **`04_customize`** (16 ảnh) + 1 state mới trên `01_wallpaper-editor` (`customize-entry`), cho màn **Customize** gộp `02_decorate` + `03_component-editor` theo TF-117. QC thả trực tiếp vào repo (file gốc `IMG_14xx.PNG` + 1 `Screenshot ... .png`), 1290×2796. Đây là **bằng chứng ảnh đầu tiên** cho màn Customize — trước đó `test-plan-tf-117.md` (Entry criterion E2) ghi nhận **chưa có baseline nào**. Còn thiếu nhiều state so với spec TF-117 (xem ghi chú cuối mục `04_customize`). |
| 8 | 2026-10-02 | TestFlight **1.2.19** | 3 ảnh — sheet **Add component** bản 1.2.19, state `add-component-v2` / `add-component-scrolled-v2` / `add-component-scrolled-v3` trên `04_customize` (23 mục, 6 nhóm — nhóm **Fitness** mới xuất hiện lần đầu). Khớp 6 component mới mô tả ở [stack-components.md](../../../../specs/wallpaper-editor/wallpaper-customize/stack-components.md). QC dán trực tiếp vào chat, không có tên file gốc, 1290×2796. |

> Khi chụp batch mới cho màn hình **đã có ảnh**: giữ nguyên `screen-no`, chỉ đổi `state` nếu UI đổi
> trạng thái, hoặc thêm hậu tố `-v2` nếu cùng `state` nhưng nội dung/layout khác (rule §5.3). Ảnh cũ
> **không xoá** trừ khi xác nhận đã lỗi thời hoàn toàn — giữ lại để đối chiếu lịch sử thiết kế.
> Thêm dòng mới vào đúng bảng flow bên dưới, ghi build number vào cột **Gốc** hoặc **Mô tả** nếu
> khác batch 1.

---

## 01_onboarding — 6 slide giới thiệu

| File | Gốc | Mô tả |
|------|-----|-------|
| `01_onboarding_01_stat-186_default.png` | IMG_0050 | Slide 1/6 — "186 times a day you check your phone" |
| `01_onboarding_02_stat-23min_default.png` | IMG_0051 | Slide 2/6 — "23 min to refocus after just one glance" |
| `01_onboarding_03_value-lockscreen_default.png` | IMG_0052 | Slide 3/6 — "Ink puts your day on your lock screen" |
| `01_onboarding_04_value-benefits_default.png` | IMG_0053 | Slide 4/6 — "Less scrolling, more doing" + 3 benefit |
| `01_onboarding_05_sync-intro_default.png` | IMG_0054 | Slide 5/6 — dẫn dắt xin quyền, CTA "See my lock screen" |
| `01_onboarding_06_lockscreen-preview_default.png` | IMG_0055 | Slide 6/6 — preview wallpaper, CTA "Get started" |

## 02_permission — xin quyền hệ thống

| File | Gốc | Mô tả |
|------|-----|-------|
| `02_permission_01_calendar-access_system-dialog.png` | IMG_0048 | Dialog iOS — full access to Calendar |
| `02_permission_02_reminder-access_system-dialog.png` | IMG_0049 | Dialog iOS — access to Reminders, có "Skip for now" |
| `02_permission_03_calendar-access_denied.png` | IMG_0139 | Tab Calendar khi bị từ chối — "Turn on Calendar access" + Open Settings |
| `02_permission_04_reminder-access_denied.png` | IMG_0141 | Tab Tasks khi bị từ chối — "Turn on Reminders access" + Open Settings |

> Nền của 2 dialog này là `01_onboarding_05_sync-intro`, nhưng tách flow vì đây là bước xin quyền độc lập, có thể trigger lại từ Settings.

## 03_shortcut-setup — tạo Apple Shortcut chạy hằng ngày

| File | Gốc | Mô tả |
|------|-----|-------|
| `03_shortcut-setup_01_shortcut-guide_default.png` | IMG_0057 | Guide 1/2 trong Ink — "Tap to add shortcut" |
| `03_shortcut-setup_02_shortcuts-app_default.png` | IMG_0058 | **External** — trang shortcut "Generate Latest Wallpaper", nút Add Shortcut |
| `03_shortcut-setup_03_shortcuts-library_default.png` | IMG_0059 | **External** — All Shortcuts sau khi thêm |
| `03_shortcut-setup_04_run-access_system-dialog.png` | IMG_0063 | Dialog — cho phép shortcut chạy actions từ Ink |
| `03_shortcut-setup_05_wallpaper-access_system-dialog.png` | IMG_0064 | Dialog — cho phép set wallpaper |
| `03_shortcut-setup_06_output-access_system-dialog.png` | IMG_0065 | Dialog — cho phép output 1 wallpaper (Once / Always) |
| `03_shortcut-setup_07_shortcut-guide_success.png` | IMG_0066 | "Shortcut is working!" |
| `03_shortcut-setup_08_automation-guide_default.png` | IMG_0067 | Guide 2/2 — "Open Automations" |
| `03_shortcut-setup_09_automation_default.png` | IMG_0068 | **External** — Personal Automation, chọn "Time of Day" |

## 04_discover — tab Discover

| File | Gốc | Mô tả |
|------|-----|-------|
| `04_discover_01_home_default.png` | IMG_0069 | Discover — section Lockscreen (28) / Live Activities (5) / Widgets (93) |
| `04_discover_01_home_scrolled.png` | IMG_0070 | Discover cuộn xuống — section Widgets |
| `04_discover_01_home_tooltip.png` | IMG_0071 | Tooltip "Set current wallpaper — Open Shortcut" |
| `04_discover_02_collection_section-focused.png` | IMG_0072 | Section "Your collection" (1) — 1 lockscreen active |
| `04_discover_02_collection_section-focused-v2.png` | IMG_0075 | Section "Your collection" (2) — thêm live activity đang Live |
| `04_discover_03_collection_default.png` | IMG_0081 | Màn hình "Your collection" đầy đủ, filter All/Lockscreen/Live Activity/Note |
| `04_discover_04_lockscreen_default.png` | IMG_0079 | Màn hình "Lockscreen" — grid template, filter Timeline/Timetable/Today's events |
| `04_discover_05_template_preview.png` | IMG_0080 | Preview template "Class Schedule — Timeline", CTA "Add to lock screen" |
| `04_discover_06_live-activity_default.png` | IMG_0073 | Live Activity "Weekly Schedule" đang chạy, CTA "Stop Live Activity" |
| `04_discover_07_live-activity_editing.png` | IMG_0074 | Sửa Live Activity — Display Time, Event Display (Block/List) |
| `04_discover_08_add-widget_step-1.png` | IMG_0076 | Hướng dẫn add widget 1/3 — giữ màn hình chính |
| `04_discover_08_add-widget_step-2.png` | IMG_0077 | Hướng dẫn add widget 2/3 — tap "+", tìm Ink |
| `04_discover_08_add-widget_step-3.png` | IMG_0078 | Hướng dẫn add widget 3/3 — chọn style, Add Widget |
| `04_discover_09_widget_editing.png` | *(QC thả trực tiếp 2026-10-12, build 1.2.22 (147), file gốc không có tên, 1290×2796)* | Màn cấu hình widget **Calendar** — preview 2 cỡ (tuần, tháng), tab **Style / Layout / Calendars** đang ở **Calendars** (danh sách lịch Công Việc, Ngày lễ Việt Nam, Calendar, Fitness), CTA "Add widget". Không có tuỳ chọn ngày đầu tuần ở đầu tab (BUG-007) |
| `04_discover_10_ios-calendar-settings_default.png` | *(QC thả trực tiếp 2026-10-12, 1290×2796, file gốc không có tên)* | **External (iOS)** — Settings của app Calendar hệ thống, màn "Start Week On": đang chọn **System Setting (Monday)**. Máy iPhone 15, iOS 18.5 của BUG-009 (QC cung cấp) |

## 05_calendar — tab Calendar

| File | Gốc | Mô tả |
|------|-----|-------|
| `05_calendar_01_list-view_empty.png` | IMG_0082 | List view, ngày không có event |
| `05_calendar_01_list-view_dialog.png` | IMG_0085 | List view có event + menu chọn view (List/Day/Week/Month) |
| `05_calendar_02_day-view_default.png` | IMG_0099 | Day view — lưới giờ 1 cột, có đường đỏ chỉ giờ hiện tại |
| `05_calendar_03_week-view_default.png` | IMG_0101 | Week view — lưới giờ 7 cột, cột hồng = ngày đang chọn |
| `05_calendar_04_month-view_default.png` | IMG_0102 | Month view — cuộn liên tục nhiều tháng, pill "Today", âm lịch |
| `05_calendar_05_calendars_bottom-sheet.png` | IMG_0086 | Sheet "Calendars" — iCloud / Other / Subscribed / Suggested |
| `05_calendar_06_new-calendar_bottom-sheet.png` | IMG_0087 | Sheet "New calendar" — chọn preset hoặc Custom name |
| `05_calendar_07_create-event_default.png` | IMG_0105 | "Create new event" — form rỗng, nút ✓ disabled |
| `05_calendar_07_create-event_editing.png` | IMG_0107 | Đang nhập "Event name", bàn phím mở, ✓ enabled |
| `05_calendar_07_create-event_expanded.png` | IMG_0106 | Picker Start + End mở đồng thời, lịch inline |
| `05_calendar_08_event-detail_default.png` | IMG_0110 | Chi tiết event "Uống Creatine" — ngày, giờ, lặp, nút xoá/sửa |

## 06_task — tab Tasks

| File | Gốc | Mô tả |
|------|-----|-------|
| `06_task_01_task-list_empty.png` | IMG_0089 | Chưa có task nào |
| `06_task_02_create-task_default.png` | IMG_0092 | "Create new task" — Title, Notes, Color, Date, Time, Priority, Repeat |
| `06_task_01_task-list_filled.png` | IMG_0091 | Có Task 1 (Today) + Task 2 (Tomorrow), filter All/Reminder/Ink |
| `06_task_03_task-detail_default.png` | IMG_0093 | Chi tiết Task 1 — CTA "Mark it completed", xoá, sửa |
| `06_task_04_edit-task_default.png` | IMG_0094 | "Edit task" — có thêm "Delete reminder" |
| `06_task_05_task-matrix_default.png` | Screenshot 2026-09-09 at 13.52.52 | Matrix mode trên iPhone — 4 ô Do now/Plan/Delegate/Drop mặc định, 1 task "Test 1" trong ô Plan. **Có banner "Put your matrix on the lock screen"** ở đầu màn — bằng chứng trực tiếp cho change note mục 2.1 |
| `06_task_05_task-matrix_completed-empty.png` | IMG_0921 | Popup mở rộng của ô "Do now" *(khớp note 1.1 — nền mờ + tối)*, đang ở sub-tab **Completed**, rỗng: *"No completed tasks yet"*. Header popup có icon ✎ (mở Customize) + nút ✕ đóng |
| `06_task_05_task-matrix_customize.png` | IMG_0922 | Bottom sheet "Customize" (mở từ ✎ ở popup) — field tên "Do now", field subtitle "Important & Urgent", chọn **Color** (11 màu), **Choose an icon** (mặc định chọn "no icon") |
| `06_task_05_task-matrix_customize-scrolled.png` | IMG_0923 | Cùng sheet Customize, cuộn xuống — header thu gọn thành "Important & Urgent" dính trên cùng, lộ thêm icon + nút **Save** |

> ✅ **`screen-no 05` — Matrix mode đã có 4 ảnh iPhone** (default, completed-empty, customize, customize-scrolled), khớp số với [`ipad/06_task/`](../ipad/06_task/) (2 ảnh: `default` + `landscape`). Layout default giống iPad — xác nhận thêm cho claim "dùng chung component" ở `ipad/index.md`.
>
> ⚠️ **Header có 3 nút tròn** (`?` help/guide, `List`, filter) khác với ảnh iPad batch 09/09 chỉ thấy 2 nút (`List`, filter) — chưa rõ do iPad thiếu 1 nút, hay do version app khác nhau giữa 2 lần chụp. Change note mục 3.4 chỉ nhắc nút Guide ở **Discover**, không nhắc ở Tasks — **cần xác nhận** đây có phải hành vi mới hay lỗi hiển thị.
>
> 🆕 **Phát hiện mới, chưa có trong change note:** popup của 1 ô (note 1.1) có sẵn 1 sub-tab **Completed** riêng cho ô đó, và icon ✎ trong popup mới là lối vào sheet Customize (đổi tên/subtitle/màu/icon) — note không mô tả 2 chi tiết này. Sheet Customize sửa **cả subtitle**, không chỉ tên (note chỉ nói mục 1.4 "Đổi dòng mô tả" chung chung, ảnh xác nhận nó nằm trong cùng 1 sheet với tên/màu/icon).

## 07_note — tab Notes

| File | Gốc | Mô tả |
|------|-----|-------|
| `07_note_01_note-list_empty.png` | IMG_0095 | Chưa có note nào |
| `07_note_02_create-note_default.png` | IMG_0096 | "Create new note" — toolbar Aa / checklist / đính kèm / màu / nhắc |
| `07_note_02_create-note_editing.png` | IMG_0097 | Đang gõ "Note 1 / Des 1", bàn phím mở |
| `07_note_01_note-list_filled.png` | IMG_0098 | Danh sách có Note 1 |

## 08_paywall

| File | Gốc | Mô tả |
|------|-----|-------|
| `08_paywall_01_upgrade_default.png` | IMG_0021 | "Unlock everything" — Weekly ₩3,300 / Lifetime ₩33,000 / Annual ₩17,000 |
| `08_paywall_01_upgrade_purchasing.png` | IMG_0103 | Chọn gói Weekly, toast "Processing…", CTA loading |
| `08_paywall_02_storekit-sheet_system-dialog.png` | IMG_0104 | Sheet StoreKit (TestFlight) — 59 000đ/tuần. ⚠️ chứa email tester |

## 09_settings

| File | Gốc | Mô tả |
|------|-----|-------|
| `09_settings_01_home_default.png` | IMG_0032 | Settings — Upgrade to Pro, iOS/Google Calendar, Set up shortcut, About |

## 10_lockscreen — kết quả ngoài app

| File | Gốc | Mô tả |
|------|-----|-------|
| `10_lockscreen_01_wallpaper_applied.png` | IMG_0115 | Lock screen thật sau khi áp dụng template "Class Schedule — Timeline" |

## 11_share — 🚧 Phase 2, chưa build

_Chưa có screenshot — chờ feature "share lịch (co-edit / lịch cố định)" ra mắt._
Xem [phase-2-feedback.md § P3](../../../../specs/phase-2-feedback/phase-2-feedback.md#p3--share-lịch-tạo-lịch-gss).

## 12_ai-assistant — 🚧 Phase 2, chưa build

_Chưa có screenshot — chờ feature trợ lý AI (chat → tự lên schedule) ra mắt._
Xem [phase-2-feedback.md § P4](../../../../specs/phase-2-feedback/phase-2-feedback.md#p4--ai-assistant-vào-calendarevent-improve-home-theo-category).

## 13_community — 🚧 Phase 2, chưa build

_Chưa có screenshot — chờ feature community/calendar riêng của Ink ra mắt._
Xem [phase-2-feedback.md § P6](../../../../specs/phase-2-feedback/phase-2-feedback.md#p6--build-community-co-edit-lịch-âm---tâm-linh).

## 14_edit-wallpaper — editor soạn/trang trí wallpaper (Decorate)

> Nguồn: [qc-wallpaper-decoration.md](../../../../specs/wallpaper-editor/wallpaper-decoration/qc-wallpaper-decoration.md), build 1.2.15 (56), entry point "Wallpaper editor → nút Decorate". **4 screen-no** — `01_wallpaper-editor` (màn chỉnh wallpaper có sẵn, chứa entry point mở editor con), `02_decorate` và `03_component-editor` (2 canvas **tách riêng** trước TF-117, nay là **tài liệu cũ** — xem banner ở [`../../../../test-plans/wallpaper-editor/component-editor/README.md`](../../../../test-plans/wallpaper-editor/component-editor/README.md) / [`wallpaper-decoration/README.md`](../../../../test-plans/wallpaper-editor/wallpaper-decoration/README.md)), và **`04_customize`** (mới, batch 7 — canvas gộp Layout + Decorate qua công tắc, theo spec [`component-editor-specs-dev-change(TF-117).md`](../../../../specs/wallpaper-editor/wallpaper-customize/component-editor-specs-dev-change(TF-117).md)). Từ TF-117, đường vào `03_component-editor`/`02_decorate` cũ **không còn** — chip **Customize** ở `01_wallpaper-editor` mở thẳng `04_customize`. Không có bản landscape — iPhone không xoay UI này.

| File | Gốc | Mô tả |
|------|-----|-------|
| `14_edit-wallpaper_01_wallpaper-editor_default.png` | IMG_1026 | Màn "Balance · Mix ✓ Current" — nút "Decorate" góc dưới trái, tab Background/Calendar/Style, đã có sẵn 1 nét vẽ từ trước |
| `14_edit-wallpaper_01_wallpaper-editor_filled.png` | IMG_1030 | Cùng màn, sau khi lưu đủ decoration (emoji, 2 ảnh, cutout, nét vẽ) — xác nhận trực tiếp mục 2.5 (save khớp editor) |
| `14_edit-wallpaper_01_wallpaper-editor_home-screen-off.png` | *(ảnh chụp ngoài quy trình — file gốc `Screenshot 2026-09-22 at 10.23.32 AM.png`, build/thiết bị chưa xác nhận)* | Cùng màn wallpaper-editor (template "Progress + Month", tab Background), scroll xuống mục **Home Screen** (dưới thanh Intensity) — 4 nút chọn `Off/Same/Photo only/Own photo`, đang chọn `Off`; copy text *"Ink sets your Lock Screen only. If your Home Screen matches it, iOS updates both."* Không có toggle Blur khi ở Off — khớp đúng thiết kế. Liên quan tính năng Home Screen mode mới (`fix/ios27-shortcut-automation`, xem [test-plan-ios26-27.md](../../../../test-plans/shortcuts/test-plan-ios26-27.md)), chưa nằm trong bàn giao `qc-wallpaper-decoration.md` gốc của flow này — **⚠️ chưa có state cho 3 mode còn lại (Same/Photo only/Own photo) và trạng thái có Blur** |
| `14_edit-wallpaper_01_wallpaper-editor_component-editor-entry.png` | *(ảnh chụp ngoài quy trình — file gốc `Screenshot 2026-09-24 at 14.28.11.png`, build/thiết bị chưa xác nhận, nhánh `feat/component-editor`)* | ⛔ *Đường vào cũ, trước TF-117 — xem `customize-entry` bên dưới.* Cùng màn wallpaper-editor, tab Background — **mũi tên đỏ chèn tay** (annotation, không phải UI thật) trỏ vào icon **layers** cạnh icon crop, góc dưới phải. Đây là entry point mở màn `03_component-editor` — nút này **chưa có trong bàn giao gốc của flow Decorate** |
| `14_edit-wallpaper_01_wallpaper-editor_customize-entry.png` | *(QC thả trực tiếp — batch 7, 2026-09-29, file gốc `Screenshot 2026-09-29 at 11.11.32.png`, 1290×2796, build chưa xác nhận)* | Màn "Week + countdown · Mix" — chip **Customize** (icon cọ vẽ) góc dưới trái thay cho icon layers cũ, tab Background/Calendar/Style, icon crop góc dưới phải. Đây là entry point **duy nhất** mở `04_customize` theo TF-117 (§2), thay thế cả `component-editor-entry` lẫn chip "Decorate" cũ |
| `14_edit-wallpaper_02_decorate_tooltip.png` | IMG_1018 | Coach mark lần đầu mở Decorate — "Your toolbar: Text, emoji, photos and a pen. The top two switches preview the clock and calendar." + nút "Got it". **State mới, note không nhắc tới** |
| `14_edit-wallpaper_02_decorate_default.png` | IMG_1019 | Canvas trống, toolbar phải hiện đủ 6 icon — mục 2.1 |
| `14_edit-wallpaper_02_decorate_calendar-shown.png` | IMG_1020 | Toggle "Show calendar" bật — mục 2.1 |
| `14_edit-wallpaper_02_decorate_brush-toolbar.png` | IMG_1021 | Toolbar vẽ đầy đủ — eyedropper + 8 màu + 4 loại nét + Eraser, đang kéo brush-size — mục 2.2 |
| `14_edit-wallpaper_02_decorate_brush-toolbar-v2.png` | IMG_1022 | Gần như giống hệt ảnh trên (chưa thấy khác biệt rõ khi so sánh) — giữ cả 2 theo nguyên tắc không xoá ảnh đã chụp, xem lại nếu cần khi có thời gian |
| `14_edit-wallpaper_02_decorate_text-editing.png` | IMG_1023 | Tool Text, bàn phím mở, placeholder "Type something" — mục 2.3 |
| `14_edit-wallpaper_02_decorate_emoji-picker.png` | IMG_1024 | Sheet Emoji picker, nhóm "Smileys" — mục 2.4 |
| `14_edit-wallpaper_02_decorate_photo-menu.png` | IMG_1025 | Menu ảnh — "Cutout" / "Photo" — mục 2.1 |
| `14_edit-wallpaper_02_decorate_sticker-selected.png` | IMG_1027 | Sticker **emoji** đang chọn — khung xanh, ✕ góc trên, handle resize+xoay góc dưới — mục 2.3 |
| `14_edit-wallpaper_02_decorate_sticker-selected-v2.png` | IMG_1028 | Cùng state, sticker **cutout ảnh** đang chọn thay vì emoji |
| `14_edit-wallpaper_02_decorate_sticker-selected-v3.png` | IMG_1029 | Cùng state, sticker **ảnh thường (không cutout)** đang chọn |
| `14_edit-wallpaper_02_decorate_discard-dialog.png` | *(ảnh chụp ngoài quy trình — file gốc `Screenshot 2026-09-12 at 14.25.22.png`, 920×1756, có khung viền máy — khác định dạng raw của các ảnh còn lại, 1290×2796)* | Bottom-sheet **"Discard changes?"** — subtitle "Your decorations won't be saved.", 2 nút: **Discard** (tối màu, nổi bật) / **Keep editing** (viền, phụ) — mục 2.5. ⚠️ Nút **Discard (huỷ, mất dữ liệu) lại có trọng lượng thị giác của nút chính**, ngược khuyến nghị thường thấy (hành động phá huỷ nên là nút phụ) — xem ghi chú UX ở wireframe |
| `14_edit-wallpaper_02_decorate_sticker-settings.png` | *(ảnh chụp ngoài quy trình — ban đầu thả nhầm vào `ipad/`, đã chuyển đúng chỗ vì nội dung là iPhone (Dynamic Island); file gốc `Screenshot 2026-09-12 at 16.01.32.png`, 920×1756, cùng định dạng khung viền máy như `discard-dialog`)* | Bottom-sheet cài đặt sticker — tiêu đề **"Emoji"** (đổi theo loại sticker), slider **Opacity** (đang 100%), nút **Delete** (chữ đỏ, nền xám nhạt — nút phụ dạng chuẩn, khác hẳn style của nút Discard ở dialog kia) — mục 2.3. **Trigger đúng bằng double-tap** vào sticker/ảnh, không phải 2 lần chạm rời rạc |
| `14_edit-wallpaper_02_decorate_sticker-settings-v2.png` | *(cùng nguồn, file gốc `Screenshot 2026-09-12 at 16.01.55.png`)* | Cùng sheet, tiêu đề đổi thành **"Photo"** khi sticker đang chọn là ảnh (chim đội balo đỏ) thay vì emoji — xác nhận tiêu đề sheet đổi theo loại sticker |

### 03_component-editor — chỉnh riêng từng band (batch 5, 2026-09-24, chưa có build number)

> Nguồn: [wallpaper-component-editor-prd.md](../../../../specs/wallpaper-editor/component-editor/wallpaper-component-editor-prd.md), status **Draft**, tính năng đang build trên nhánh `feat/component-editor`. Đối chiếu chính thức: [QC — Component Editor 1.2-SUPERSEDED.md](../../../../specs/wallpaper-editor/component-editor/QC%20—%20Component%20Editor%201.2-SUPERSEDED.md) (TestFlight 1.2.17 (103)). Mở từ icon layers ở `01_wallpaper-editor` (xem `component-editor-entry` ở trên). 15 ảnh dưới đây chụp ngoài quy trình batch, build/thiết bị chưa xác nhận — 11 ảnh đầu có file gốc dạng `Screenshot 2026-09-24 at HH.MM.SS.png`, 4 ảnh cuối (`added`, `added-v2`, `default-v3`, `default-v4`) dán trực tiếp, không có tên file gốc.

| File | Gốc | Mô tả |
|------|-----|-------|
| `14_edit-wallpaper_03_component-editor_default.png` | `Screenshot 2026-09-24 at 14.28.42.png` | Vào màn ngay sau khi tap entry — top bar đổi thành X / undo / redo / checkmark (khác top bar của `01_wallpaper-editor`), canvas hiện đủ, **chưa chọn band nào** |
| `14_edit-wallpaper_03_component-editor_add-component.png` | `Screenshot 2026-09-24 at 14.28.52.png` | ⛔ *Lứa 1.2.17 — 1.2.18 xem `add-component-v2`.* Bottom-sheet **"Add component"**, phần trên — nhóm **CALENDAR** (Month grid, Mini month, Lunar calendar, Timetable, Week schedule) và **EVENTS** (Today's events, Timeline, Hour timeline, Week events, Activity grid) |
| `14_edit-wallpaper_03_component-editor_add-component-scrolled.png` | `Screenshot 2026-09-24 at 14.29.02.png` | ⛔ *Lứa 1.2.17 — 1.2.18 xem `add-component-scrolled-v2`.* Cùng sheet, cuộn xuống — nhóm **TASKS** (Reminders, Priority matrix), **PROGRESS** (Year/Month progress, Countdown), **TEXT** (Quote, Almanac day), **LAYOUT** (Row, Column) |
| `14_edit-wallpaper_03_component-editor_add-component-v2.png` | *(dán trực tiếp, không có tên gốc — batch 6, 2026-09-28, 1290×2796, build chưa xác nhận)* | **Bản 1.2.18.** Bottom-sheet **"Add component"**, phần trên — nhóm **CALENDAR** (Month grid, Mini month, Lunar calendar, Timetable, Week schedule; mỗi mục có icon + mô tả một dòng) và **EVENTS** chỉ còn **4 mục** (Today's events, Hour timeline, Week events, Activity grid — **không còn Timeline**); đầu nhóm **TASKS** (Reminders, Priority matrix) lộ ở đáy. Header sheet có nút ✕ tròn. Cùng screen + state với `add-component`, khác nội dung → `-v2` (rule §5.3) |
| `14_edit-wallpaper_03_component-editor_add-component-scrolled-v2.png` | *(dán trực tiếp, không có tên gốc — batch 6, 2026-09-28, 1290×2796, build chưa xác nhận)* | **Bản 1.2.18.** Cùng sheet, cuộn xuống — cuối **EVENTS**, nhóm **TASKS** (Reminders, Priority matrix), **PROGRESS** (Year progress, Month progress, Countdown), **LAYOUT** (Row, Column). **Không có nhóm TEXT** (Quote, Almanac day) và không thấy badge **PRO** ở bất kỳ mục nào trong cả hai đoạn cuộn |
| `14_edit-wallpaper_03_component-editor_default-v2.png` | `Screenshot 2026-09-24 at 14.29.13.png` | Quay lại canvas sau khi đóng sheet Add component, vẫn chưa chọn band nào — gần như trùng `default` nhưng chụp ở thời điểm khác trong flow, giữ cả 2 theo rule §5.3 |
| `14_edit-wallpaper_03_component-editor_selected.png` | `Screenshot 2026-09-24 at 14.29.23.png` | Tap vào band Timetable (bảng lịch tuần) — khung viền xanh lá bao quanh band, nổi toolbar mini phía trên (icon sliders + icon thùng rác) |
| `14_edit-wallpaper_03_component-editor_inspector.png` | `Screenshot 2026-09-24 at 14.29.35.png` | Bottom-sheet inspector mở ra, tiêu đề **"Timetable"** (+ icon duplicate/delete/close) — đầu sheet, mục **POSITION**: Placement (Auto), Width (354, slider), Horizontal offset (0), Size (1.00×) |
| `14_edit-wallpaper_03_component-editor_inspector-scrolled.png` | `Screenshot 2026-09-24 at 14.29.48.png` | Cùng inspector, cuộn xuống — cuối **POSITION** (Size), mục **CONTENT**: Cards per day (10) |
| `14_edit-wallpaper_03_component-editor_inspector-scrolled-v2.png` | `Screenshot 2026-09-24 at 14.30.08.png` | Cuộn tiếp — Cards per day, đầu mục **TEXT**: Font (Rounded), Size (29), Color (bắt đầu lộ) |
| `14_edit-wallpaper_03_component-editor_inspector-scrolled-v3.png` | `Screenshot 2026-09-24 at 14.30.16.png` | Cuộn tiếp — mục **TEXT** đủ: Font, Size, Color, Bold (on), Italic (off), Alignment (cắt ở mép dưới) |
| `14_edit-wallpaper_03_component-editor_inspector-scrolled-v4.png` | `Screenshot 2026-09-24 at 14.30.20.png` | Cuối sheet — Color, Bold, Italic, Alignment (Left), **More options** (chevron, còn control khác chưa lộ) |
| `14_edit-wallpaper_03_component-editor_resizing.png` | `Screenshot 2026-09-24 at 14.31.05.png` | Band Timetable đang kéo resize — nhãn số **"106"** góc trên trái (giá trị đang chỉnh), đường dẫn hướng đứt nét màu xanh lá ở giữa canvas (snap guide), handle resize hiện ở 2 góc |
| `14_edit-wallpaper_03_component-editor_added.png` | *(dán trực tiếp, không có tên gốc)* | Vừa thêm **Year progress** qua sheet Add component — toast **"✓ Added Year progress · Undo"** (chữ Undo màu xanh lá) nổi ngay dưới header; canvas hiện band Year progress (`2026 — 73% · 98 days left`), **chưa được chọn** (không viền, không pill). Lần đầu có ảnh xác nhận đúng toast mô tả trong QC spec dòng 75 |
| `14_edit-wallpaper_03_component-editor_added-v2.png` | *(dán trực tiếp, không có tên gốc)* | Cùng toast, đổi nội dung **"Added Timetable"** — band Timetable vừa thêm cũng **không tự động được chọn** sau khi thêm (khác đề xuất cũ trong wireframe.html vốn kỳ vọng tự chọn + mở Inspector ngay) |
| `14_edit-wallpaper_03_component-editor_default-v3.png` | *(dán trực tiếp, không có tên gốc)* | Canvas với band **Month grid** (lịch tháng 9 đầy đủ, có chấm màu dưới các ngày có event, ngày 24 tô nền xám nhạt = hôm nay) — không toast, không chọn |
| `14_edit-wallpaper_03_component-editor_default-v4.png` | *(dán trực tiếp, không có tên gốc)* | Canvas với band **Mini month** — cùng bố cục lịch tháng nhưng **không có chấm event**, ngày 24 tô nền **hồng đậm tròn** (khác kiểu highlight xám của Month grid) — xác nhận 2 loại calendar-view khác nhau rõ rệt về mặt hiển thị, không chỉ khác kích thước |

> ⏳ **Chưa đối chiếu được với checklist/spec đầy đủ** — PRD `wallpaper-component-editor-prd.md` đang ở status Draft, §11 Open Questions chưa chốt. Bộ ảnh này chỉ ghi lại UI hiện có trên nhánh `feat/component-editor`, **không suy ra đây là spec cuối cùng**. Đã có bằng chứng cho **4/16 loại part** (Timetable, Year progress, Month grid, Mini month) — còn thiếu 12 loại, cộng state `error`/`disabled` khi control không hợp lệ, hành vi khi `is_pro: true` (Pro gate theo PRD §11), và bản `ipad/` tương ứng.

> ⏳ **Còn thiếu so với checklist gốc** (chưa chụp, không chặn): `eyedropper` (đang hút màu — liên quan R5), `limit-warning` (>50 nét — R6). Dark Mode **không cần chụp** — app hiện chưa hỗ trợ Dark Mode. Đối chiếu thêm với bản iPad ([`ipad/index.md`](../ipad/index.md#14_edit-wallpaper--editor-soạntrang-trí-wallpaper-decorate)) — iPad có thêm `filled`/`filled-landscape` (canvas đầy đủ, không sticker nào đang chọn) và `text-collapsed` mà bộ iPhone này chưa có; ngược lại iPhone có `tooltip`, 3 biến thể `sticker-selected`, và sheet `sticker-settings` mà iPad chưa có. Nên chụp bổ sung chéo nếu cần đối chiếu hành vi giữa 2 device.
>
> ⛔ **`02_decorate` và `03_component-editor` là tài liệu trước TF-117** — từ khi 2 editor gộp thành
> `04_customize`, đường vào riêng của 2 màn này không còn. Ảnh vẫn giữ nguyên để tham khảo hành vi nền
> (nhiều hành vi được TF-117 kế thừa gần như nguyên văn), nhưng **không dùng làm oracle hình ảnh** cho
> `04_customize` — xem banner ở `test-plans/wallpaper-editor/component-editor/README.md` và
> `wallpaper-decoration/README.md`.

### 04_customize — màn gộp Layout + Decorate (batch 7, 2026-09-29, chưa có build number)

> Nguồn: [component-editor-specs-dev-change(TF-117).md](../../../../specs/wallpaper-editor/wallpaper-customize/component-editor-specs-dev-change(TF-117).md) — dev bàn giao, gộp `02_decorate` (chip cũ) và
> `03_component-editor` (nút cũ) thành 1 màn **Customize** với công tắc **Layout | Decorate**. Mở từ
> chip **Customize** ở `01_wallpaper-editor` (xem `customize-entry` ở mục trên). 16 ảnh dưới đây do QC
> thả trực tiếp vào repo, build/thiết bị **chưa xác nhận qua công cụ** — đây là **bằng chứng ảnh đầu
> tiên** cho màn này, lấp một phần Entry criterion E2 của
> [test-plan-tf-117.md](../../../../test-plans/wallpaper-editor/wallpaper-customize/test-plan-tf-117.md)
> (trước đó ghi nhận "chưa có bất kỳ baseline nào").

| File | Gốc | Mô tả |
|------|-----|-------|
| `14_edit-wallpaper_04_customize_coach-step-1.png` | `IMG_1469 2.PNG` | Coach tour bước 1 (lần đầu mở màn) — tiêu đề **"Layout and Decorate"**, mô tả "Layout arranges the calendar's components. Decorate adds text, emoji, photos and drawings on top.", công tắc Layout\|Decorate ở đáy được khoanh sáng, nút **Next** — khớp §2 |
| `14_edit-wallpaper_04_customize_coach-step-1-v2.png` | `IMG_1470.PNG` | Cùng bước 1, template nền khác (lịch tuần thay vì lịch tháng) — giữ cả 2 theo rule §5.3 |
| `14_edit-wallpaper_04_customize_coach-step-2-layout.png` | `IMG_1471.PNG` | Coach tour bước 2 cho **Layout** — tiêu đề **"Your toolbar"**, mô tả "Add a component, restyle the whole calendar, and turn on the grid to line things up.", rail dọc góc phải khoanh sáng (+, Style, Sample events, Grid — **Show decorations chưa hiện vì canvas chưa có trang trí**, khớp §2), nút **Got it** |
| `14_edit-wallpaper_04_customize_add-component.png` | `IMG_1472.PNG` | Sheet **Add component**, phần trên — nhóm **CALENDAR** (Month grid, Mini month, Lunar calendar, Timetable, Week schedule) + đầu **EVENTS** (Today's events, Hour timeline, Week events, Activity grid) — mỗi mục có icon minh hoạ + mô tả 1 dòng, **không có nhóm Text**, khớp §6 |
| `14_edit-wallpaper_04_customize_add-component-scrolled.png` | `IMG_1473.PNG` | Cùng sheet, cuộn xuống — cuối EVENTS, nhóm **TASKS** (Reminders, Priority matrix), **PROGRESS** (Year progress, Month progress, Countdown), **LAYOUT** (Row, Column) |
| `14_edit-wallpaper_04_customize_style.png` | `IMG_1474.PNG` | Sheet **Style** mở, phần trên — Font (chip Default/System/Caveat/Patrick Hand/Excalifont), Text size (slider), Event colors (Template/Calendar/Custom), toggle **Match colors to photo** + mô tả, Intensity, đầu mục Position |
| `14_edit-wallpaper_04_customize_style-scrolled.png` | `IMG_1475.PNG` | Cùng sheet, cuộn thêm chút — lộ đủ 3 thanh **Scale/Horizontal/Vertical** của Position |
| `14_edit-wallpaper_04_customize_sample-events-on.png` | `IMG_1476 2.PNG` | Toast **"Showing sample events"**, nút Sample events trên rail đang bật (tô đậm) — canvas đổi sang dữ liệu mẫu (Standup, Dentist, Team sync, Lunch, Coffee chat) — khớp §9 |
| `14_edit-wallpaper_04_customize_sample-events-off.png` | `IMG_1477 2.PNG` | Toast **"Showing your events"** — tắt Sample events, canvas về lịch thật (giữ nguyên dữ liệu mẫu trong khung hình vì demo chưa đổi lại) |
| `14_edit-wallpaper_04_customize_grid-on.png` | `IMG_1478 2.PNG` | Toast **"Grid on"**, lưới căn hiện trên canvas, nút Grid trên rail tô đậm — khớp §9.01 |
| `14_edit-wallpaper_04_customize_grid-off.png` | `IMG_1479 2.PNG` | Toast **"Grid off"**, lưới tắt — xác nhận 1 toast thay thế toast trước, không chồng (§9) |
| `14_edit-wallpaper_04_customize_added.png` | `IMG_1480 2.PNG` | Toast **"✓ Added Countdown · Undo"** sau khi thêm qua sheet Add component — khớp §6 |
| `14_edit-wallpaper_04_customize_inspector.png` | `IMG_1481 2.PNG` | Band **Countdown** đang chọn (pill ⌄ / 🗑 phía trên), bảng thuộc tính mở — tiêu đề "Countdown" + icon duplicate/delete/close, mục **Content**: Target date (31 Dec 2026), Caption (trống); đầu mục **Text**: Font, Size — khớp thứ tự Content → Text → Background → Position ở §7 |
| `14_edit-wallpaper_04_customize_layers.png` | `IMG_1482 2.PNG` | Sheet **Layers** — nhóm **LAYOUT** (Week schedule, Countdown, mũi tên ↓ ở tiêu đề nhóm), nhóm **DECORATE** (1 dòng "Decorate", mũi tên ↑ ở tiêu đề), nhóm **BACKGROUND** cuối panel (dải ảnh nền + nút **+**, ảnh "Default" đang chọn) và thanh **Darken** — khớp đúng cấu trúc 3 nhóm ở §8.2 |
| `14_edit-wallpaper_04_customize_coach-step-2-decorate.png` | `IMG_1485 2.PNG` | Coach tour bước 2 **riêng cho Decorate** (lần đầu chuyển sang Decorate, không phải lần đầu mở màn) — tiêu đề **"Your toolbar"**, mô tả "Text, emoji, photos and a pen. The top two switches preview the clock and calendar.", rail Decorate khoanh sáng (Draw, Aa, Emoji, Photo, Show calendar, Grid) — khớp §2 "sang Decorate lần đầu thì có riêng bước rail Decorate" |
| `14_edit-wallpaper_04_customize_decorate-mode.png` | `IMG_1486 2.PNG` | Canvas ở chế độ **Decorate** — công tắc đáy chuyển sang "Decorate" (tô đậm), rail đổi thành Draw/Aa/Emoji/Photo/Show calendar/Grid, nền tối + minh hoạ trang trí sẵn có |
| `14_edit-wallpaper_04_customize_add-component-v2.png` | *(dán trực tiếp, không có tên gốc — batch 8, 2026-10-02, TestFlight **1.2.19**, 1290×2796)* | **Bản 1.2.19 — thay cho `add-component.png`/`add-component-scrolled.png` của batch 7 (TF-117), sheet đã đổi nội dung đáng kể → `-v2` (rule §5.3).** Đầu sheet **Add component** — nhóm **CALENDAR** 7 mục: Daily page, Month grid, **Month heatmap** (mới, icon trống trong ảnh), Mini month, Lunar calendar, Timetable, Week schedule; đầu nhóm **EVENTS**: Today at a glance, Today's events, **Agenda**, **Event tickets**, Hour timeline (cắt ở mép dưới). 5/6 component mới của [stack-components.md](../../../../specs/wallpaper-editor/wallpaper-customize/stack-components.md) lộ trong ảnh này |
| `14_edit-wallpaper_04_customize_add-component-scrolled-v2.png` | *(dán trực tiếp, không có tên gốc — batch 8, cùng nguồn)* | Cuộn tiếp — cuối **EVENTS** (Agenda, Event tickets, Hour timeline, Week events, Activity grid), nhóm **FITNESS** mới xuất hiện lần đầu (**Workout**), **TASKS** (Reminders, Priority matrix), đầu **PROGRESS** (Milestones, Year progress, Month progress, Countdown cắt ở mép dưới) |
| `14_edit-wallpaper_04_customize_add-component-scrolled-v3.png` | *(dán trực tiếp, không có tên gốc — batch 8, cùng nguồn)* | Cuối sheet — **FITNESS** (Workout), **TASKS** (Reminders, Priority matrix), **PROGRESS** đủ 4 mục (**Milestones**, Year progress, Month progress, Countdown), **LAYOUT** (Row, Column) |

> 🆕 **Batch 8 xác nhận đủ 6/6 component mới** mô tả trong `stack-components.md` (Agenda, Event tickets,
> Workout, Daily page, Today at a glance, Milestones) — tên khớp chính xác chữ, không lệch. Sheet tăng từ
> 16 → **23 mục**, thêm nhóm **Fitness** chưa từng có ở batch 6/7.
>
> ⚠️ **Chưa đối chiếu được:** `Month heatmap` xuất hiện như **component độc lập** trong nhóm Calendar,
> nhưng mục 8 của `stack-components.md` mô tả "Heat map" là một **style/knob của Week events**
> (`Style: Bars / Dots / Heat map`), không phải component riêng. Chưa rõ đây là 2 tính năng khác nhau hay
> tài liệu ghi nhầm chỗ — **cần hỏi lại dev**, không tự suy diễn. Icon của `Month heatmap` cũng đang trống
> trong ảnh, có thể UI chưa xong.

> ⏳ **Còn thiếu rất nhiều so với spec TF-117** (chưa chụp, không chặn nhưng nên bổ sung sớm — đây mới
> là 16/~40+ state có thể liệt kê từ spec): chọn/xoá 1 thành phần (pill Edit/Delete, §3), kéo đổi vị trí
> + nhấn giữ đổi chỗ (§4), kéo đổi bề rộng (§5), Row/Column + giới hạn lồng nhau + container rỗng (§6.1–
> §6.3), sheet Add ở trạng thái **bị chặn** ("calendar already fills the wallpaper"), các knob riêng theo
> từng loại band (§7.06+), Undo/Redo/Discard dialog (§8), cảnh báo *"Part of this runs off the screen"*
> (§9), toàn bộ nội dung **bên trong** Decorate khi chạy trong ngữ cảnh màn gộp (vẽ, sticker, ống hút —
> Q-7 của `test-analysis-tf-117.md` đã chọn **test lại toàn bộ**), và bản `ipad/` tương ứng (chưa có ảnh
> nào cho `04_customize` trên iPad). Không có ảnh nào xác nhận số build/commit — vẫn là gap đã ghi ở
> Entry criterion E1 của test-plan.

---

## Ghi chú

- **`IMG_0071 copy.PNG` đã xoá** — trùng byte-for-byte với `IMG_0071.PNG` (cùng MD5).
- **Possible missing screen** — các khoảng trống trong dãy `IMG_xxxx`, cần chụp bổ sung nếu muốn flow đầy đủ:
  - `IMG_0056`, `IMG_0060`–`0062`: giữa guide shortcut và các dialog quyền (flow 03).
  - Calendar — **đã phủ đủ**: 4 view, tạo event, chi tiết event. Còn thiếu **Edit event** và **dialog xác nhận xoá**.
  - `IMG_0088`, `IMG_0090`: Tasks — chưa có ảnh task đã hoàn thành, xoá task.
  - Paywall — đã có `purchasing` + sheet StoreKit. Còn thiếu trạng thái **`unlocked`** sau khi mua, lỗi thanh toán, và luồng Restore purchases.
  - Settings — mới có 1 ảnh trạng thái chưa mua; thiếu các màn con và trạng thái đã mua Pro.
