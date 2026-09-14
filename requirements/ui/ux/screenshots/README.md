# Screenshots — Ink Calendar iOS

Bộ screenshot thực tế của app Ink, dùng làm **nguồn đầu vào** để dựng Wireframe, User Flow và PRD.

Tên file được chuẩn hoá để đọc tên là hiểu ngay flow / thứ tự màn hình / state — không cần mở ảnh.

---

## Thư mục theo device

Ảnh tách theo **device ở cấp thư mục**. Tên file **không** chứa device — vị trí thư mục đã nói rõ.

| Device | Thư mục | Index | Số ảnh |
|--------|---------|-------|--------|
| iPhone | [`iphone/`](iphone/) | [`iphone/index.md`](iphone/index.md) | 77 ảnh / 11 flow đã build |
| iPad | [`ipad/`](ipad/) | [`ipad/index.md`](ipad/index.md) | 29 ảnh / 7 flow (22 portrait, 7 landscape) |

```
screenshots/
├── README.md              ← file này
├── iphone/
│   ├── index.md           ← bảng tra ngược về ảnh gốc (iPhone)
│   ├── 01_onboarding/      6 ảnh — slide giới thiệu giá trị
│   ├── 02_permission/      4 ảnh — xin quyền Calendar / Reminders
│   ├── 03_shortcut-setup/  9 ảnh — tạo Apple Shortcut chạy hằng ngày
│   ├── 04_discover/       13 ảnh — tab Discover: collection, lockscreen, widget, live activity
│   ├── 05_calendar/       11 ảnh — tab Calendar
│   ├── 06_task/            5 ảnh — tab Tasks
│   ├── 07_note/            4 ảnh — tab Notes
│   ├── 08_paywall/         3 ảnh — màn hình mua gói
│   ├── 09_settings/        1 ảnh — cài đặt
│   ├── 10_lockscreen/      1 ảnh — lock screen thật sau khi áp dụng
│   ├── 11_share/          🚧 0 ảnh — Phase 2, chưa build
│   ├── 12_ai-assistant/   🚧 0 ảnh — Phase 2, chưa build
│   ├── 13_community/      🚧 0 ảnh — Phase 2, chưa build
│   └── 14_edit-wallpaper/ 16 ảnh — editor trang trí wallpaper (Decorate), build 1.2.15 (56)
└── ipad/
    ├── index.md           ← bảng tra ngược về ảnh gốc (iPad)
    ├── 01_onboarding/      5 ảnh — slide 1–5/6 (thiếu slide 6)
    ├── 02_permission/      1 ảnh — dialog Calendar
    ├── 03_shortcut-setup/  3 ảnh — guide + success + automation-guide
    ├── 04_discover/        2 ảnh — home tooltip + home có collection
    ├── 05_calendar/       0 ảnh — chưa chụp
    ├── 06_task/            2 ảnh — matrix mode (default + landscape)
    ├── 07_note/           0 ảnh — chưa chụp
    ├── 08_paywall/         1 ảnh — Unlock everything (3 gói)
    ├── 09_settings/       0 ảnh — chưa chụp
    ├── 10_lockscreen/     0 ảnh — chưa chụp
    ├── 11_share/          🚧 0 ảnh — Phase 2, chưa build
    ├── 12_ai-assistant/   🚧 0 ảnh — Phase 2, chưa build
    ├── 13_community/      🚧 0 ảnh — Phase 2, chưa build
    └── 14_edit-wallpaper/ 15 ảnh — cùng flow trên, cả portrait + landscape
```

🚧 = tính năng Phase 2 **chưa build trong app** — folder đã tạo sẵn (kèm `.gitkeep`) để chụp ngay
khi feature ra mắt. Chi tiết map với feedback Phase 2 nằm ở flow map [§7 rule đặt tên](../../../../.claude/rules/screenshot-naming.md#7-flow-map--ink-calendar-ios) và [`requirements/specs/phase-2-feedback.md`](../../specs/phase-2-feedback.md).

Trong mỗi device, thư mục flow là **phẳng — không có thư mục con**. Mọi phân cấp nằm trong `screen-no` của tên file.

**`flow-no` dùng chung giữa 2 device** — cùng số = cùng nghiệp vụ, để đối chiếu song song iPhone ↔ iPad.
Màn hình chỉ iPad mới có (sidebar, split view…) → thêm `screen-no` mới **trong flow tương ứng**, không tạo flow riêng.

---

## Tài liệu liên quan

| File | Nội dung |
|------|----------|
| [`iphone/index.md`](iphone/index.md) · [`ipad/index.md`](ipad/index.md) | Bảng tra **tên file ↔ tên gốc `IMG_xxxx` ↔ mô tả** từng màn hình. Có mục *Possible missing screen*. |
| [`../../../../.claude/rules/screenshot-naming.md`](../../../../.claude/rules/screenshot-naming.md) | Rule đặt tên đầy đủ — format, device, từ vựng screen-name / state, case đặc biệt. **Đọc file này trước khi thêm ảnh mới.** |

---

## Quy ước đặt tên (tóm tắt)

```
<flow-no>_<flow-name>_<screen-no>_<screen-name>_<state>.png

04_discover_08_add-widget_step-1.png
│  │        │  │          └── state: trạng thái UI
│  │        │  └───────────── screen-name: chức năng màn hình
│  │        └──────────────── screen-no: thứ tự user thao tác (2 chữ số)
│  └───────────────────────── flow-name: nghiệp vụ
└──────────────────────────── flow-no: 2 chữ số
```

- **Toàn bộ viết thường**, kể cả đuôi `.png` — không ngoại lệ.
- `_` phân tách 5 field (đúng 4 lần) · `-` nối từ trong một field.
- Cùng `flow-no` = một flow liên tục.
- Cùng `screen-no` khác `state` = các trạng thái của **một màn hình**, không phải 2 màn hình.
- **Device không nằm trong tên file** — nằm ở thư mục cha (`iphone/` hoặc `ipad/`).

Chi tiết đầy đủ nằm trong file rule.

---

## Thêm screenshot mới

1. Đọc [rule đặt tên](../../../../.claude/rules/screenshot-naming.md) — đặc biệt mục từ vựng `screen-name` và `state`.
2. Chụp full màn hình, **giữ nguyên status bar** (dùng để xác định context: giờ, pin, TestFlight).
3. Đặt tên theo format, bỏ vào **đúng thư mục device → đúng thư mục flow**.
   - Màn hình đã có, chỉ khác trạng thái → **giữ nguyên `screen-no`**, đổi `state`.
   - Màn hình mới xen giữa → chèn `screen-no` mới và đánh số lại các màn sau **trong cùng flow, cùng device đó**.
   - Flow mới → lấy `flow-no` tiếp theo (`11`, `12`…), **không chèn giữa, không đánh số lại flow cũ**. Cấp số cho **cả 2 device cùng lúc**.
4. Cập nhật `index.md` **của device tương ứng**: thêm dòng gồm tên file, tên gốc `IMG_xxxx`, mô tả 1 dòng.

Chưa chắc chắn state là gì → đặt `_unknown` và ghi vào `index.md` để review sau, **không đoán**.

### Riêng iPad

- iPad xoay được → dùng state `landscape` / `portrait` / `split-view` / `sidebar-expanded` khi hướng màn hình làm **đổi layout**. Cùng một layout ở cả 2 hướng thì dùng state thường.
- Ghi model iPad + độ phân giải vào đầu [`ipad/index.md`](ipad/index.md) — layout iPad phụ thuộc kích thước màn hình.

---

## Lưu ý khi đọc bộ ảnh này

- Ảnh có `screen-name` là `shortcuts-app`, `shortcuts-library`, `automation`, hoặc `state` là `system-dialog` → **màn hình ngoài app Ink** (iOS system / app Shortcuts của Apple). Khi dựng wireframe phải đánh dấu rõ là *external screen*.
- Thứ tự `screen-no` bám **luồng thao tác của user**, không theo thứ tự chụp. Ví dụ ở `06_task`, màn `02_create-task` đứng trước `01_task-list_filled` vì phải tạo task thì danh sách mới có dữ liệu.
- Cùng `flow-no` + `screen-no` ở 2 device = **cùng một màn hình**, chỉ khác layout. Không tách thành 2 node trong flow diagram.
- Bộ ảnh **chưa đủ mọi màn hình** của app. Xem mục *Possible missing screen* cuối mỗi `index.md` trước khi kết luận app thiếu chức năng — và không tự bổ sung màn hình không có trong ảnh.
