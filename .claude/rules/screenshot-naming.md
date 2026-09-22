# Rule: Screenshot Naming (Screenshot → Wireframe)

> Áp dụng cho toàn bộ screenshot trong `requirements/ui/ux/screenshots/<device>/`.
> Mục tiêu: đọc tên file là hiểu được User Flow, thứ tự màn hình và state,
> đủ để convert sang Wireframe / Flow Diagram / PRD mà không cần mở ảnh.
>
> Phần 1–6 là convention dùng chung, tái sử dụng được cho project khác.
> Phần 7 là Flow Map riêng của **Ink Calendar iOS**.

---

## 1. Format

```
<flow-no>_<flow-name>_<screen-no>_<screen-name>_<state>.png
```

Ví dụ:

```
01_onboarding_01_stat-186_default.png
02_permission_01_calendar-access_system-dialog.png
04_discover_03_widget_section-focused.png
06_task_02_task-detail_editing.png
```

### 1.1 Quy tắc chữ

**Tên file LUÔN LUÔN viết thường — 100%, không ngoại lệ.**

- Toàn bộ tên file: `lowercase`. Kể cả tên riêng, viết tắt, tên brand.
  `ink`, `ios`, `ui`, `otp`, `iap` — không viết `Ink`, `iOS`, `OTP`.
- **Dấu `_` (underscore)**: phân tách 5 thành phần của format. Chỉ dùng đúng 4 lần.
- **Dấu `-` (hyphen)**: nối các từ **bên trong** một thành phần.
  `calendar-access`, `task-detail`, `system-dialog`, `section-focused`.
- **Phần mở rộng cũng viết thường**: `.png`, không phải `.PNG`.
  iOS export ra `.PNG` → phải đổi thành `.png` khi rename.
- Tên thư mục: cùng quy tắc, viết thường — `01_onboarding`, không phải `01_Onboarding`.

### 1.2 Cấm

- ✗ Chữ hoa ở bất kỳ vị trí nào.
- ✗ Khoảng trắng, dấu tiếng Việt, ký tự đặc biệt (`copy`, `(1)`, `@`, `&`, `#`).
- ✗ camelCase / PascalCase / snake_case bên trong một thành phần
  (`taskDetail`, `TaskDetail`, `task_detail` → đúng là `task-detail`).
- ✗ Viết tắt gây khó hiểu (`perm`, `scr`, `btm`, `usr`).

### 1.3 Số thứ tự

`flow-no` và `screen-no`: **luôn 2 chữ số** — `01`, `02`, … `10`, `11`.

### 1.4 Device

**Device KHÔNG nằm trong tên file** — nằm ở thư mục cha:

```
requirements/ui/ux/screenshots/iphone/01_onboarding/01_onboarding_01_stat-186_default.png
                               └─ device                └─ tên file, KHÔNG lặp lại device
```

Device hợp lệ hiện tại: `iphone`, `ipad`. Thêm device mới (`mac`, `watch`…) → tạo thư mục
cùng cấp, kèm `index.md` riêng.

Cùng một màn hình trên 2 device → **cùng `flow-no`, cùng `screen-no`, cùng `screen-name`**.
Chỉ khác nhau ở thư mục device và (nếu layout khác) ở `state`.

```
iphone/05_calendar/05_calendar_02_day-view_default.png
ipad/05_calendar/05_calendar_02_day-view_landscape.png     ← cùng màn hình, khác layout
```

Màn hình **chỉ device này mới có** (sidebar iPad, split view…) → cấp `screen-no` mới trong
flow tương ứng, chỉ tồn tại ở thư mục device đó. Không tạo `flow-no` riêng cho device.

---

## 2. flow-name

Đặt theo **nghiệp vụ**, không theo tên màn hình hay tên file design.

| GOOD | BAD |
|------|-----|
| `login` `checkout` `onboarding` `permission` `paywall` | `screen-1` `page-1` `abc` `new-flow` |

**Cấp số flow mới:** luôn lấy số tiếp theo (`10`, `11`, …).
**Không chèn giữa, không đánh số lại flow cũ** — để link trong PRD/wireframe không hỏng.

---

## 3. screen-name

Tên **chức năng chính** của màn hình. Tối đa 2 từ ghép.

| GOOD | BAD |
|------|-----|
| `project-detail` | `project-detail-screen-for-editing-project` |
| `email-input` | `screen-3` |

### Màn hình ngoài app

Screenshot của **iOS system hoặc app khác** (Settings, Shortcuts, Photos, dialog quyền)
vẫn thuộc flow đang chạy, nhưng `screen-name` phải chỉ rõ nguồn:

```
03_shortcut-setup_02_shortcuts-app_default.png
02_permission_01_calendar-access_system-dialog.png
```

---

## 4. state

Luôn mô tả trạng thái UI. Mặc định ghi rõ `_default`, không bỏ trống.

### 4.1 State chuẩn

```
default      filled       selected     expanded     collapsed
loading      refreshing   searching    result       empty
no-result    error        offline      success      failed
warning      confirmation dialog       bottom-sheet tooltip
disabled     enabled      editing      preview      scrolled
```

### 4.2 State cho app iOS có permission / IAP / wallpaper

```
system-dialog     dialog quyền của iOS (allow / don't allow)
granted / denied  kết quả sau khi user chọn quyền
applied           wallpaper / template đã áp dụng thành công
locked            nội dung pro bị khoá (chưa mua)
unlocked          đã mở khoá sau khi mua
purchasing        đang xử lý thanh toán
section-focused   chụp tập trung vào 1 section của màn hình cuộn dài
step-1 / step-2   một bước của guide nhiều bước nằm trong CÙNG một màn hình
unknown           chưa xác định được — cần người review
```

### 4.3 State cho iPad

iPad xoay được, iPhone thì không. Chỉ ghi orientation khi nó **làm đổi layout**:

```
landscape          layout ngang, khác hẳn portrait
portrait           layout dọc — chỉ ghi khi màn hình đó ĐÃ có bản landscape để phân biệt
split-view         chia đôi màn hình với app khác (Split View / Slide Over)
sidebar-collapsed  sidebar thu gọn
sidebar-expanded   sidebar mở
```

Màn hình chỉ có 1 hướng, hoặc 2 hướng render giống hệt nhau → dùng state thường
(`default`, `filled`…), **không** ghi orientation cho có.

---

**`step-N` vs `screen-no` riêng:** dùng `step-N` khi các bước là pager/carousel **trong một
màn hình** (ví dụ modal "Add widget" 3 bước). Dùng `screen-no` riêng khi mỗi bước là một
màn hình thật sự user điều hướng tới.

---

## 5. Case đặc biệt

### 5.1 Màn hình cuộn dài, chụp nhiều đoạn

**Không tách thành nhiều flow.** Mỗi section = một `screen-no` riêng, theo thứ tự từ trên xuống:

```
04_discover_01_home_default.png
04_discover_02_collection_section-focused.png
04_discover_03_widget_section-focused.png
```

Nếu chỉ là cuộn tiếp của **cùng một section** → giữ nguyên `screen-no`, đổi `state`:

```
04_discover_03_widget_default.png
04_discover_03_widget_scrolled.png
```

### 5.2 Popup / bottom sheet / dialog

Giữ nguyên `screen-no` của màn hình nền, chỉ đổi `state`:

```
06_task_02_task-detail_default.png
06_task_02_task-detail_bottom-sheet.png
06_task_02_task-detail_delete-dialog.png
06_task_02_task-detail_delete-success.png
```

### 5.3 Cùng màn hình + cùng state, khác nội dung

Thêm hậu tố `-v2`, `-v3` vào cuối, **sau** state:

```
04_discover_03_lock-screen_preview.png
04_discover_03_lock-screen_preview-v2.png
```

Tuyệt đối không dùng ` copy`, ` (1)`, ` 2`.

### 5.4 Nội dung tiếng Việt trong ảnh

App có data tiếng Việt (event, task, note). **Tên file luôn tiếng Anh, không dấu.**
Nội dung tiếng Việt mô tả trong wireframe/PRD, không đưa vào tên file.

---

## 6. Folder Structure

Đúng **2 cấp**, không hơn:

1. `<device>` — `iphone`, `ipad`.
2. `<flow-no>_<flow-name>` — khớp chính xác với 2 thành phần đầu của tên file.

Bên trong thư mục flow là ảnh, **không có thư mục con** — mọi phân cấp đã nằm trong `screen-no`.

```
requirements/ui/ux/screenshots/
├── README.md              ← hub, so sánh 2 device
├── iphone/
│   ├── index.md
│   ├── 01_onboarding/
│   │   ├── 01_onboarding_01_stat-186_default.png
│   │   └── 01_onboarding_02_stat-23min_default.png
│   ├── 02_permission/
│   └── ...
└── ipad/
    ├── index.md
    ├── 01_onboarding/
    ├── 02_permission/
    └── ...
```

`index.md` **bắt buộc có ở MỖI device**: bảng tra tên file mới ↔ tên gốc (`IMG_xxxx`) ↔ mô tả
1 dòng, để truy ngược về ảnh gốc khi cần chụp lại. Đầu file ghi rõ model device + độ phân giải.

Thư mục flow **rỗng vẫn giữ lại** (kèm `.gitkeep`) — nó nói rõ flow đó chưa chụp trên device
này, khác hẳn với "device này không có flow đó".

---

## 7. Flow Map — Ink Calendar iOS

Thứ tự flow bám theo **hành trình người dùng thật**, không theo thứ tự chụp ảnh.
**Flow map dùng chung cho mọi device** — cùng `flow-no` = cùng nghiệp vụ trên iPhone và iPad.

| flow-no | flow-name | Nội dung |
|---------|-----------|----------|
| `01` | `onboarding` | Slide giới thiệu giá trị, kết thúc bằng CTA "Get started" |
| `02` | `permission` | Xin quyền Calendar / Reminders |
| `03` | `shortcut-setup` | Hướng dẫn one-time tạo Apple Shortcut đổi wallpaper hằng ngày |
| `04` | `discover` | Tab Discover: collection, lock screen, widget, live activity |
| `05` | `calendar` | Tab Calendar: xem lịch, chi tiết event |
| `06` | `task` | Tab Tasks: danh sách + thao tác to-do |
| `07` | `note` | Tab Notes: danh sách + soạn note |
| `08` | `paywall` | Màn hình mua gói / IAP |
| `09` | `settings` | Cài đặt app |
| `10` | `lockscreen` | Lock screen thật của iPhone sau khi áp dụng template (ngoài app) |
| `11` | `share` | 🚧 Phase 2 — chia sẻ lịch (co-edit / lịch cố định), xem [phase-2-feedback.md](../../requirements/specs/phase-2-feedback/phase-2-feedback.md#p3--share-lịch-tạo-lịch-gss) |
| `12` | `ai-assistant` | 🚧 Phase 2 — trợ lý AI dạng chat, tự lên schedule, xem [phase-2-feedback.md](../../requirements/specs/phase-2-feedback/phase-2-feedback.md#p4--ai-assistant-vào-calendarevent-improve-home-theo-category) |
| `13` | `community` | 🚧 Phase 2 — calendar cộng đồng riêng của Ink, xem [phase-2-feedback.md](../../requirements/specs/phase-2-feedback/phase-2-feedback.md#p6--build-community-co-edit-lịch-âm---tâm-linh) |
| `14` | `edit-wallpaper` | Editor soạn/trang trí wallpaper trước khi lưu — vẽ tay, chữ, emoji, ảnh, tách nền (Decorate). Tách riêng khỏi `04_discover` (browse/collection) vì đây là nghiệp vụ **soạn/sửa**, không phải **duyệt/chọn**. Thêm 2026-09-12, build 1.2.15 (56) — xem [qc-wallpaper-decoration.md](../../requirements/specs/wallpaper-decoration/qc-wallpaper-decoration.md) |

🚧 = tính năng **chưa build**, chưa có screenshot. Folder đã tạo sẵn (`.gitkeep`) để chụp ngay khi
feature ra mắt. `flow-name` của 3 flow này có thể còn đổi trước khi có screenshot đầu tiên — sau đó
khoá lại theo đúng quy tắc "không đánh số lại" ở mục 2.

### 7.1 screen-name đặc thù Ink

| screen-name | Dùng khi |
|-------------|----------|
| `lock-screen` | Lock screen wallpaper do Ink sinh ra |
| `home-screen` | Home screen wallpaper / widget trên home |
| `widget` | Chọn hoặc cấu hình widget |
| `live-activity` | Live Activity / Dynamic Island |
| `collection` | "Your collection" — template người dùng đã lưu |
| `template` | Chi tiết / preview một template wallpaper |
| `theme` | Chọn theme, màu, wallpaper nền |
| `*-access` | Bước xin quyền — `calendar-access`, `reminder-access`, `photo-access`, `run-access`, `wallpaper-access`, `output-access` |
| `shortcut-guide` / `automation-guide` | Bước hướng dẫn trong app Ink của flow tạo shortcut |
| `shortcuts-app` / `shortcuts-library` | Màn hình app Shortcuts của Apple (external) |
| `automation` | Tab Automation trong app Shortcuts (external) |
| `list-view` / `day-view` / `week-view` / `month-view` | Chế độ xem lịch |
| `event-detail` | Chi tiết một event |
| `task-list` / `task-detail` | Danh sách / chi tiết to-do |
| `task-matrix` | Chế độ xem Eisenhower Matrix trong tab Tasks (4 ô Do now/Plan/Delegate/Drop) |
| `note-list` / `note-detail` | Danh sách / chi tiết note |

---

## 8. AI Requirements

Khi AI đọc bộ screenshot này:

1. Giữ nguyên thứ tự theo `flow-no` → `screen-no`.
2. Suy luận User Flow dựa trên thứ tự file trong cùng `flow-no`.
3. Cùng `screen-no` khác `state` = các trạng thái của **một màn hình duy nhất**,
   không tách thành 2 node trong flow diagram.
4. `screen-name` là `shortcuts-app` / `automation`, hoặc `state` là `system-dialog`
   → màn hình **ngoài app** — đánh dấu rõ là *external screen* trong wireframe.
5. Không tự tạo thêm hoặc bỏ qua màn hình không có trong screenshot.
6. Giữ nguyên `flow-name` và `screen-name` khi sinh Wireframe / Flow Diagram / PRD.
7. Thiếu bước trong flow → chỉ ghi nhận `possible missing screen`, **không tự bổ sung nội dung**.
8. `state` là `unknown` → cần người xác nhận, không được đoán trong tài liệu output.
9. Khi rename hoặc thêm screenshot mới → **bắt buộc** tuân thủ rule này và cập nhật `index.md`
   **của đúng device**.
10. Device lấy từ **thư mục cha**, không lấy từ tên file. Cùng `flow-no` + `screen-no` ở
    `iphone/` và `ipad/` = **một màn hình duy nhất**, chỉ khác layout — không tách thành 2 node
    trong flow diagram, mà ghi 2 biến thể layout trong cùng một node.
11. Màn hình chỉ tồn tại ở một device → đánh dấu rõ *device-specific* trong wireframe, kèm tên
    device. Không suy ra rằng device kia thiếu chức năng — có thể chỉ là chưa chụp; đối chiếu
    mục *Possible missing screen* của `index.md` device đó trước khi kết luận.
