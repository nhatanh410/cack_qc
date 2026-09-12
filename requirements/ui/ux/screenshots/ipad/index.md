# Screenshot Index — iPad

Bảng tra tên file mới ↔ tên gốc từ iOS ↔ mô tả màn hình.
Quy tắc đặt tên: [.claude/rules/screenshot-naming.md](../../../../../.claude/rules/screenshot-naming.md)

Tổng: **29 screenshot** / 7 flow đã build (01, 02, 03, 04, 06, 08, 14). Batch 1 chụp 19/08/2026, batch 2 chụp 09/09/2026, batch 3 chụp 12/09/2026 (`14_edit-wallpaper`, 15 ảnh, cả 2 chiều).

> **Thiết bị:** iPad 10.2" — **1620×2160 portrait** (suy ra từ độ phân giải: iPad gen 7/8/9. Cần xác nhận model chính xác.)
> **Phiên bản app:** TestFlight — **build chưa xác định** cho cả 2 batch, status bar chỉ hiện "TestFlight". Cần điền.
> **Orientation:** 13 ảnh portrait, **1 ảnh landscape** (`06_task_05_task-matrix_landscape`) — landscape đầu tiên của bộ ảnh iPad.

`flow-no` dùng **chung** với iPhone — cùng số = cùng nghiệp vụ, để đối chiếu song song 2 device.
Xem flow map đầy đủ ở mục 7 của [rule đặt tên](../../../../../.claude/rules/screenshot-naming.md).

## Lịch sử chụp

| Batch | Ngày | Build | Ghi chú |
|---|---|---|---|
| 1 | 2026-08-19 | TestFlight, build chưa xác định | Batch gốc — 12 ảnh, 5 flow. Chi tiết dưới đây. |
| 2 | 2026-09-09 | TestFlight, build chưa xác định | Batch refresh Phase 2 — bắt đầu với `06_task` matrix (2 ảnh: default + landscape). Confirmed matrix dùng chung component với iPhone. Còn thiếu build number — điền khi xác nhận được. |
| 3 | 2026-09-12 | TestFlight 1.2.15 (56) | Flow mới `14_edit-wallpaper` (Decorate) — 15 ảnh, đủ cả portrait + landscape. Còn thiếu 5 state so với checklist gốc (sticker-selected, sticker-settings, eyedropper, limit-warning, discard-dialog) — xem ghi chú ⏳ trong mục flow. |

> Quy tắc refresh giống iPhone: giữ `screen-no`, đổi `state` nếu UI đổi state, hoặc thêm hậu tố `-v2`
> nếu cùng state khác nội dung (rule §5.3). Không xoá ảnh cũ trừ khi xác nhận lỗi thời.

---

## Orientation

iPad xoay được, iPhone thì không — nên `state` phải nói rõ hướng màn hình khi nó ảnh hưởng layout:

| state | Dùng khi |
|-------|----------|
| `landscape` | Layout ngang, khác hẳn portrait |
| `portrait` | Layout dọc — chỉ ghi khi **cùng màn hình** đã có bản `landscape` để phân biệt |
| `split-view` | Chia đôi màn hình với app khác (Split View / Slide Over) |
| `sidebar-collapsed` / `sidebar-expanded` | Sidebar / master-detail — chỉ iPad mới có |

Màn hình chỉ có 1 hướng, hoặc 2 hướng giống hệt nhau → dùng state thường (`default`, `filled`…), **không cần** ghi orientation.
Đã có cặp đối chiếu đầu tiên ở `06_task` (`_default` portrait vs `_landscape`) — layout đổi thật (giãn cột, dời nút `+`) nên tách state đúng theo bảng trên. Các flow khác vẫn toàn portrait, chưa có bản landscape để so sánh → giữ state thường.

---

## 01_onboarding — 5/6 slide giới thiệu

| File | Gốc | Mô tả |
|------|-----|-------|
| `01_onboarding_01_stat-186_default.png` | IMG_1406 | Slide 1/6 — "186 times a day you check your phone" (Reviews.org, 2026) |
| `01_onboarding_02_stat-23min_default.png` | IMG_1407 | Slide 2/6 — "23 min to refocus after just one glance" (Gloria Mark, UC Irvine, 2008) |
| `01_onboarding_03_value-lockscreen_default.png` | IMG_1408 | Slide 3/6 — "Ink puts your day on your lock screen", ảnh mockup iPhone |
| `01_onboarding_04_value-benefits_default.png` | IMG_1409 | Slide 4/6 — "Less scrolling, more doing" + 3 benefit |
| `01_onboarding_05_sync-intro_default.png` | IMG_1410 | Slide 5/6 — dẫn dắt xin quyền, CTA "Sync my data" + "Skip for now" |

> ⚠️ **Thiếu slide 6/6** (`06_lockscreen-preview`) — iPhone có, iPad chưa chụp. Xem *Possible missing screen*.

## 02_permission — xin quyền hệ thống

| File | Gốc | Mô tả |
|------|-----|-------|
| `02_permission_01_calendar-access_system-dialog.png` | IMG_1411 | Dialog iOS — full access to Calendar, "1.802 events in the next year", data mẫu tiếng Việt ("Uống Omega-3") |

> Nền của dialog là `01_onboarding_05_sync-intro`, nhưng tách flow vì đây là bước xin quyền độc lập.
> Chưa có dialog **Reminders** và chưa có 2 trạng thái `denied` — iPhone đã có cả 3.

## 03_shortcut-setup — tạo Apple Shortcut chạy hằng ngày

| File | Gốc | Mô tả |
|------|-----|-------|
| `03_shortcut-setup_01_shortcut-guide_default.png` | IMG_1414 | Guide 1/2 trong Ink — "Add the shortcut to set up your lock screen", CTA "Tap to add shortcut" / "I've added it — check now" |
| `03_shortcut-setup_07_shortcut-guide_success.png` | IMG_1415 | Kết quả thành công — "You're all set! Your new lock screen is ready" + tooltip "Lock your phone to see it live". Quay về từ app Shortcuts. |
| `03_shortcut-setup_08_automation-guide_default.png` | IMG_1416 | Guide 2/2 — "Schedule the shortcut to run daily", CTA "Open Automations" |

> `screen-no` giữ **đúng số của iPhone** (01 → 07 → 08) để đối chiếu song song. Các số 02–06 là màn hình
> ngoài app (Shortcuts, dialog quyền) — iPad chưa chụp, không phải là không tồn tại.
>
> ⚠️ **Copy khác iPhone ở screen 07**: iPhone ghi *"Shortcut is working!"*, iPad ghi *"You're all set! Your new
> lock screen is ready."* Chưa xác định là **khác theo device** hay do **khác build** — cần người xác nhận.

## 04_discover — tab Discover

| File | Gốc | Mô tả |
|------|-----|-------|
| `04_discover_01_home_tooltip.png` | IMG_1413 | Coach mark lần đầu — "Start with a lock screen", nút "Got it", nền là Discover (Lockscreen 28 / Live Activities 5 / Widgets 93) |
| `04_discover_01_home_default.png` | IMG_1417 | Discover sau khi áp dụng — có section "Your collection" (1) với "Active Lockscreen", + banner cuối màn "Lock screen didn't change? — Ink saved it, open Settings, then find it under Wallpaper" |

> Hai ảnh cùng `screen-no 01` = **một màn hình**, khác state và khác data (chưa có / đã có collection).

## 08_paywall — màn hình mua gói

| File | Gốc | Mô tả |
|------|-----|-------|
| `08_paywall_01_upgrade_default.png` | IMG_1412 | "Unlock everything" — 3 gói: 3-day free (Weekly) 59.000đ · **Lifetime 599.000đ (BEST VALUE, đang chọn)** · Annual 299.000đ. Có Restore purchases / Terms / Privacy |

## 06_task — tab Tasks, chế độ Matrix

| File | Gốc | Mô tả |
|------|-----|-------|
| `06_task_05_task-matrix_default.png` | IMG_554262B08B5C-1 | Matrix mode mặc định — 4 ô Do now/Plan/Delegate/Drop, chưa tuỳ biến tên/màu/icon. 1 task "Chuyển nhà 1" trong ô Do now |
| `06_task_05_task-matrix_landscape.png` | IMG_00484BA8691D-1 | Cùng màn hình, xoay ngang — layout 2 cột giãn rộng hơn, vị trí nút `+` nổi đổi |

> **`screen-no 05`** — chọn số này để **khớp với iPhone khi chụp matrix trên iPhone sau này** (iPhone hiện có 01–04: task-list/create-task/task-detail/edit-task, chưa có matrix). Theo cùng cách `05_calendar` tách mỗi view-mode (list/day/week/month) thành 1 screen-no riêng.
> Đây là ảnh **đầu tiên** của flow `06_task` trên iPad — trước đó thư mục này trống hoàn toàn.
> Confirmed (2026-09-09): Matrix trên iPad **dùng chung component** với iPhone — không phải implementation riêng.

## 05_calendar · 07_note · 09_settings · 10_lockscreen — chưa chụp

_Chưa có screenshot trên iPad cho 4 flow này — xem "Possible missing screen" bên dưới. Không suy ra
là app thiếu chức năng, chỉ chưa chụp trên device này._

## 11_share · 12_ai-assistant · 13_community — 🚧 Phase 2, chưa build

_Chưa có screenshot — 3 flow này chưa tồn tại trong app, chờ Phase 2. Xem flow map [§7 rule đặt tên](../../../../../.claude/rules/screenshot-naming.md#7-flow-map--ink-calendar-ios)
và [`requirements/specs/phase-2-feedback.md`](../../../specs/phase-2-feedback.md). Cấp số flow **dùng chung** với iPhone — khi feature ra mắt, chụp song song cả 2 device nếu có thể._

## 14_edit-wallpaper — editor soạn/trang trí wallpaper (Decorate)

> Nguồn: [qc-wallpaper-decoration.md](../../../specs/qc-wallpaper-decoration.md), build 1.2.15 (56). **2 screen-no riêng biệt** — `01_wallpaper-editor` là màn hình chỉnh wallpaper đã có từ trước (chứa nút "Trang trí" mới), `02_decorate` là canvas trang trí thực sự (mới hoàn toàn), vào từ nút Trang trí ở màn 01. Đã chụp **cả 2 chiều** — khớp yêu cầu bắt buộc của R8 (bug xoay ngang làm lệch sticker, đã sửa).

| File | Gốc | Mô tả |
|------|-----|-------|
| `14_edit-wallpaper_01_wallpaper-editor_default.png` | IMG_1476 | Màn chỉnh wallpaper "Cân bằng · Kết hợp" — tab Hình nền/Lịch/Kiểu, nút "Trang trí" góc dưới trái, "Đặt làm hiện tại" |
| `14_edit-wallpaper_01_wallpaper-editor_landscape.png` | IMG_1485 | Cùng màn, xoay ngang — **đã có wallpaper đã lưu với đủ decoration** (emoji, cutout, ảnh, nét vẽ) áp trên preview → xác nhận trực tiếp mục 2.5 (save khớp editor) qua cả 2 chiều |
| `14_edit-wallpaper_02_decorate_default.png` | IMG_1477 | Canvas Decorate vừa mở, toolbar phải: grid/lịch/bút/Aa/emoji/ảnh — mục 2.1 |
| `14_edit-wallpaper_02_decorate_calendar-shown.png` | IMG_1478 | Toggle "Show calendar" bật — preview lịch hiện trên canvas — mục 2.1 |
| `14_edit-wallpaper_02_decorate_drawing.png` | IMG_1479 | Đang vẽ (nét trắng), header + toolbar **ẩn** trong lúc kéo — mục 2.2. *Cần verify: ẩn lúc đang vẽ là chủ ý, khác với bug R1 (ẩn vĩnh viễn sau khi buông tay resize handle)* |
| `14_edit-wallpaper_02_decorate_text-editing.png` | IMG_1480 | Tool Text — placeholder "Nhập nội dung", bàn phím mở, thanh format (màu/Aa/canh lề/Bold/cỡ chữ/tương phản) — mục 2.3 |
| `14_edit-wallpaper_02_decorate_text-collapsed.png` | IMG_1481 | Cùng tool Text, bàn phím đã tắt (chạm ra ngoài), thanh format vẫn còn — chưa nhập gì |
| `14_edit-wallpaper_02_decorate_emoji-picker.png` | IMG_1482 | Sheet Emoji picker, nhóm "Mặt cười", 7 tab nhóm dưới đáy — mục 2.4 |
| `14_edit-wallpaper_02_decorate_photo-menu.png` | IMG_1483 | Menu ảnh mở ra 2 lựa chọn "Cắt nền" / "Ảnh" — mục 2.1 |
| `14_edit-wallpaper_02_decorate_filled.png` | IMG_1484 | Canvas đầy đủ: emoji 🤫, nét vẽ trái tim, cutout người đeo balo, ảnh thường — không sticker nào đang chọn, sẵn sàng lưu |
| `14_edit-wallpaper_02_decorate_filled-landscape.png` | IMG_1486 | Cùng nội dung như `filled`, xoay ngang — canvas letterbox giữa màn, toolbar dời sang phải — đối chiếu R8 |
| `14_edit-wallpaper_02_decorate_calendar-shown-landscape.png` | IMG_1487 (dup export → " 2") | Toggle lịch bật, xoay ngang |
| `14_edit-wallpaper_02_decorate_brush-toolbar-landscape.png` | IMG_1488 | **Toàn bộ thanh công cụ vẽ** — eyedropper + 12 màu + 4 loại nét (Pen/Marker/Highlighter/Dotted) + Eraser — mục 2.2, ảnh rõ nhất cho case này trong cả bộ |
| `14_edit-wallpaper_02_decorate_text-editing-landscape.png` | IMG_1489 | Tool Text, bàn phím mở, xoay ngang |
| `14_edit-wallpaper_02_decorate_emoji-picker-landscape.png` | IMG_1490 | Sheet Emoji picker, xoay ngang — sheet **không co giãn theo chiều ngang**, giữ nguyên kích thước như portrait |

> ⏳ **Còn thiếu so với checklist gốc của note** (chưa chụp, không chặn — bổ sung nếu có dịp chụp lại):
> - `sticker-selected` — 1 sticker đang chọn, thấy rõ handle resize + nút ✕ (mục 2.3, và cần đặt gần mép để test R8 khi kéo/xoay)
> - `sticker-settings` — bottom-sheet cài đặt sticker (opacity, xoá — mục 2.3)
> - `eyedropper` — đang hút màu (mục 2.2, liên quan R5)
> - `limit-warning` — thông báo hết chỗ vẽ sau >50 nét (R6)
> - `discard-dialog` — popup "Discard changes?" (mục 2.5)
> - Bản **portrait** của `photo-menu` và `brush-toolbar` đã có (brush-toolbar chỉ có landscape) — nên chụp thêm bản còn thiếu để đối chiếu chéo 2 chiều nếu nghi ngờ có khác biệt layout.
>
> ⚠️ **Cần verify riêng, không suy đoán:** `drawing.png` (IMG_1479) cho thấy header/toolbar biến mất trong lúc đang vẽ — cần xác nhận đây là **hành vi cố ý** (ẩn tạm trong lúc thao tác, hiện lại khi buông tay) chứ không phải biến thể của bug R1 (ẩn vĩnh viễn sau resize). Nếu buông tay mà toolbar không hiện lại → đó chính là R1, log ngay theo severity Critical.

---

## Khác biệt so với iPhone

Ghi nhận từ ảnh, **không suy diễn thêm**:

| Điểm | iPhone | iPad |
|------|--------|------|
| Điều hướng chính | Tab bar **dưới** màn hình | **Segmented control trên đầu** (Discover · Calendar · Tasks · Notes) |
| CTA slide 5 onboarding | "See my lock screen" | **"Sync my data"** |
| Paywall | 1 gói hiển thị (59.000đ/tuần) | **3 gói** — Weekly / Lifetime / Annual, mặc định chọn Lifetime |
| Copy màn success shortcut | "Shortcut is working!" | "You're all set! Your new lock screen is ready." |
| Banner Discover | chưa thấy trong bộ iPhone | Banner "Lock screen didn't change?" ở cuối màn |

> ⚠️ Các khác biệt trên có thể do **device** hoặc do **build khác nhau** — bộ iPhone là TestFlight 1.2.10 (27),
> build iPad chưa xác định. **Cần xác nhận build trước khi đưa vào PRD.**

---

## Ghi chú

- **Possible missing screen** — flow có trên iPhone nhưng iPad chưa chụp. Chỉ ghi nhận, **không tự bổ sung nội dung**:
  - `01_onboarding` — thiếu slide **6/6** `lockscreen-preview` (CTA "Get started").
  - `02_permission` — thiếu dialog **Reminders**, và 2 trạng thái **`denied`** (Calendar + Reminders).
  - `03_shortcut-setup` — thiếu toàn bộ màn **external** (screen 02–06, 09): trang shortcut trong app Shortcuts,
    All Shortcuts, 3 dialog quyền (run / wallpaper / output), tab Automation.
  - `04_discover` — thiếu màn Your collection đầy đủ, Lockscreen grid, template preview, Live Activity, add widget.
  - `06_task` — chỉ có **matrix mode** (`screen-no 05`). Thiếu `01_task-list`, `02_create-task`, `03_task-detail`, `04_edit-task` — 4 screen-no này iPhone đã có, iPad chưa chụp.
  - `05_calendar` · `07_note` · `09_settings` · `10_lockscreen` — **chưa có ảnh nào**.
- **Landscape / split view** — đã có 1 cặp đối chiếu đầu tiên (`06_task` matrix). Các flow còn lại vẫn chưa có ảnh landscape/split-view, nên ưu tiên chụp bổ sung khi refresh Phase 2.
- **Build iPad chưa xác định** — phải điền trước khi so sánh chéo với iPhone.
