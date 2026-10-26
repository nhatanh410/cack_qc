# Rule: Screenshot Naming (Screenshot → Wireframe)

> Áp dụng cho toàn bộ screenshot trong `requirements/ui/ux/screenshots/<device>/`.
> Mục tiêu: đọc tên file là hiểu được User Flow, thứ tự màn hình và state,
> đủ để convert sang Wireframe / Flow Diagram / PRD mà không cần mở ảnh.
>
> Phần 1–6 là convention dùng chung, tái sử dụng được cho project khác.
> Phần 7 là Flow Map riêng của **Hệ thống Quản lý vụ việc Công An Cửa Khẩu Nội Bài (CACK)**.
> Bản gốc của dự án Ink cũ: `3ada18a:.claude/rules/screenshot-naming.md`.

---

## 1. Format

```
<flow-no>_<flow-name>_<screen-no>_<screen-name>_<state>.png
```

Ví dụ:

```
01_login_01_login-form_default.png
03_case-create_06_subject-info_filled.png
04_case-handling_02_case-detail_in-progress.png
05_record-signing_04_signature_dialog.png
```

### 1.1 Quy tắc chữ

**Tên file LUÔN LUÔN viết thường — 100%, không ngoại lệ.**

- Toàn bộ tên file: `lowercase`. Kể cả tên riêng, viết tắt, tên brand.
  `cack`, `pdf`, `ui`, `otp` — không viết `CACK`, `PDF`, `OTP`.
- **Dấu `_` (underscore)**: phân tách 5 thành phần của format. Chỉ dùng đúng 4 lần.
- **Dấu `-` (hyphen)**: nối các từ **bên trong** một thành phần.
  `case-detail`, `subject-info`, `system-dialog`, `section-focused`.
- **Phần mở rộng cũng viết thường**: `.png`, không phải `.PNG`.
  iOS export ra `.PNG` → phải đổi thành `.png` khi rename.
- Tên thư mục: cùng quy tắc, viết thường — `01_login`, không phải `01_Login`.

### 1.2 Cấm

- ✗ Chữ hoa ở bất kỳ vị trí nào.
- ✗ Khoảng trắng, dấu tiếng Việt, ký tự đặc biệt (`copy`, `(1)`, `@`, `&`, `#`).
- ✗ camelCase / PascalCase / snake_case bên trong một thành phần
  (`caseDetail`, `CaseDetail`, `case_detail` → đúng là `case-detail`).
- ✗ Viết tắt gây khó hiểu (`vv`, `scr`, `btm`, `usr`).

### 1.3 Số thứ tự

`flow-no` và `screen-no`: **luôn 2 chữ số** — `01`, `02`, … `10`, `11`.

### 1.4 Device

**Device KHÔNG nằm trong tên file** — nằm ở thư mục cha:

```
requirements/ui/ux/screenshots/iphone/01_login/01_login_01_login-form_default.png
                               └─ device          └─ tên file, KHÔNG lặp lại device
```

Device hợp lệ hiện tại:

- `iphone` — app Quản lý trên iPhone (model + phiên bản iOS ghi ở `index.md` của device). Xác nhận 2026-10-26:
  app **tạm thời chỉ chạy trên iPhone**; khi có Android/iPad → thêm thư mục `android/` / `ipad/` cùng cấp.
- `web` — trang quản trị hệ thống chung trên trình duyệt (trình duyệt + độ phân giải ghi ở `index.md`).

Thêm device mới → tạo thư mục cùng cấp, kèm `index.md` riêng.

Cùng một màn hình trên 2 device → **cùng `flow-no`, cùng `screen-no`, cùng `screen-name`**.
Chỉ khác nhau ở thư mục device và (nếu layout khác) ở `state`.

Màn hình **chỉ device này mới có** → cấp `screen-no` mới trong flow tương ứng, chỉ tồn tại ở
thư mục device đó. Không tạo `flow-no` riêng cho device.

---

## 2. flow-name

Đặt theo **nghiệp vụ**, không theo tên màn hình hay tên file design. Viết tiếng Anh, không dấu.

| GOOD | BAD |
|------|-----|
| `login` `case-create` `task-assign` `daily-report` | `screen-1` `page-1` `abc` `new-flow` |

**Cấp số flow mới:** luôn lấy số tiếp theo (`10`, `11`, …).
**Không chèn giữa, không đánh số lại flow cũ** — để link trong PRD/wireframe không hỏng.

---

## 3. screen-name

Tên **chức năng chính** của màn hình. Tối đa 2 từ ghép.

| GOOD | BAD |
|------|-----|
| `case-detail` | `case-detail-screen-for-officer-to-update` |
| `subject-info` | `screen-3` |

### Màn hình ngoài app

Screenshot của **hệ điều hành hoặc app khác** (camera hệ thống, trình xem PDF, dialog quyền)
vẫn thuộc flow đang chạy, nhưng `screen-name` phải chỉ rõ nguồn:

```
03_case-create_06_camera-access_system-dialog.png
05_record-signing_07_pdf-viewer_default.png
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

### 4.2 State nghiệp vụ của hệ thống CACK

```
system-dialog     dialog quyền của hệ điều hành (camera, thư viện ảnh, thông báo)
granted / denied  kết quả sau khi user chọn quyền
pending           vụ việc/giao việc chờ tiếp nhận
in-progress       đang thực hiện (sau khi bấm "Đang làm")
completed         đã hoàn thành
overdue           quá hạn hoàn thành
extended          đã gia hạn
reassigned        đã phân công lại
cancelled         đã huỷ phần việc
unsigned / signed biên bản chưa ký / đã ký
section-focused   chụp tập trung vào 1 section của màn hình cuộn dài
step-1 / step-2   một bước của guide nhiều bước nằm trong CÙNG một màn hình
unknown           chưa xác định được — cần người review
```

**Màn hình khác nhau theo vai trò** (người giao việc vs cán bộ): thêm hậu tố vai trò vào cuối
`state` — `-assigner` hoặc `-officer`. Ví dụ `04_case-handling_02_case-detail_default-officer.png`.
Chỉ thêm khi giao diện **thực sự khác** giữa 2 vai trò.

### 4.3 State cho web

Chỉ ghi kích thước màn hình khi nó **làm đổi layout**:

```
desktop            layout màn rộng
narrow             layout khi thu hẹp cửa sổ / màn nhỏ — chỉ ghi khi đã có bản desktop để phân biệt
sidebar-collapsed  sidebar thu gọn
sidebar-expanded   sidebar mở
```

Màn hình chỉ có 1 layout → dùng state thường (`default`, `filled`…), **không** ghi kích thước cho có.

---

**`step-N` vs `screen-no` riêng:** dùng `step-N` khi các bước là pager/carousel **trong một
màn hình**. Dùng `screen-no` riêng khi mỗi bước là một màn hình thật sự user điều hướng tới
(vd 9 bước "Tạo vụ việc" — mỗi bước một `screen-no`).

---

## 5. Case đặc biệt

### 5.1 Màn hình cuộn dài, chụp nhiều đoạn

**Không tách thành nhiều flow.** Mỗi section = một `screen-no` riêng, theo thứ tự từ trên xuống:

```
05_record-signing_03_record-form_section-focused.png
05_record-signing_04_subject-fields_section-focused.png
05_record-signing_05_dangerous-items_section-focused.png
```

Nếu chỉ là cuộn tiếp của **cùng một section** → giữ nguyên `screen-no`, đổi `state`:

```
04_case-handling_02_case-detail_default.png
04_case-handling_02_case-detail_scrolled.png
```

### 5.2 Popup / bottom sheet / dialog

Giữ nguyên `screen-no` của màn hình nền, chỉ đổi `state`:

```
04_case-handling_02_case-detail_default.png
04_case-handling_02_case-detail_bottom-sheet.png
04_case-handling_02_case-detail_complete-dialog.png
04_case-handling_02_case-detail_completed.png
```

### 5.3 Cùng màn hình + cùng state, khác nội dung

Thêm hậu tố `-v2`, `-v3` vào cuối, **sau** state:

```
05_record-signing_06_record-preview_default.png
05_record-signing_06_record-preview_default-v2.png
```

Tuyệt đối không dùng ` copy`, ` (1)`, ` 2`.

### 5.4 Nội dung tiếng Việt trong ảnh

App có data tiếng Việt (vụ việc, biên bản, họ tên). **Tên file luôn tiếng Anh, không dấu.**
Nội dung tiếng Việt mô tả trong wireframe/PRD, không đưa vào tên file.

### 5.5 Dữ liệu cá nhân trong ảnh

Hệ thống xử lý giấy tờ tuỳ thân (CCCD, hộ chiếu), họ tên, ngày sinh, chữ ký. **Chỉ chụp bằng
dữ liệu test giả**; ảnh lỡ chứa dữ liệu thật phải che trước khi đưa vào repo. Screenshot đang bị
`.gitignore` chặn khi repo GitHub còn ở chế độ public.

---

## 6. Folder Structure

Đúng **2 cấp**, không hơn:

1. `<device>` — `iphone`, `web`.
2. `<flow-no>_<flow-name>` — khớp chính xác với 2 thành phần đầu của tên file.

Bên trong thư mục flow là ảnh, **không có thư mục con** — mọi phân cấp đã nằm trong `screen-no`.

```
requirements/ui/ux/screenshots/
├── README.md              ← hub, so sánh 2 device
├── iphone/
│   ├── index.md
│   ├── 01_login/
│   │   └── 01_login_01_login-form_default.png
│   ├── 02_home/
│   └── ...
└── web/
    ├── index.md
    └── 09_web-admin/
```

`index.md` **bắt buộc có ở MỖI device**: bảng tra tên file mới ↔ tên gốc (`IMG_xxxx`, `hinh-NN`)
↔ mô tả 1 dòng, để truy ngược về ảnh gốc khi cần chụp lại. Đầu file ghi rõ model device + độ
phân giải (hoặc trình duyệt + kích thước cửa sổ với `web`).

Thư mục flow **rỗng vẫn giữ lại** (kèm `.gitkeep`) — nó nói rõ flow đó chưa chụp trên device
này, khác hẳn với "device này không có flow đó".

---

## 7. Flow Map — Hệ thống Quản lý vụ việc CACK Nội Bài

> ✅ **Đã xác nhận 2026-10-26** (QC lead duyệt). Suy ra từ
> [mo-ta-chuc-nang-v1.md](../../requirements/specs/xu-ly-vi-pham-giao-viec/mo-ta-chuc-nang-v1.md) +
> [lam-ro-2026-10-26.md](../../requirements/specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-26.md).
> `flow-no`/`flow-name` từ `01` đến `09` đã khoá theo quy tắc "không đánh số lại" ở mục 2.

Thứ tự flow bám theo **hành trình người dùng thật**, không theo thứ tự chụp ảnh.
**Flow map dùng chung cho mọi device** — cùng `flow-no` = cùng nghiệp vụ trên iphone và web.

Vai trò (theo [đặc tả v2.1](../../requirements/specs/xu-ly-vi-pham-giao-viec/dac-ta-chuc-nang-v2.1.md) §3):
**người giao việc** = Đội trưởng/Chỉ huy Đội, Tổ trưởng, Tổ phó, Phó đội trưởng, Phó trưởng CACK, Trưởng CACK,
và **cán bộ được uỷ quyền Tổ phó** (quản trị viên cấp) · **cán bộ** = người nhận việc (kể cả Phòng Camera).

| flow-no | flow-name | Nội dung | Vai trò |
|---------|-----------|----------|---------|
| `01` | `login` | Đăng nhập vào hệ thống | Tất cả |
| `02` | `home` | Tab Trang chủ: Thống kê, lối vào Tạo vụ việc / Giao việc | Tất cả |
| `03` | `case-create` | Tạo vụ việc xử lý vi phạm — 9 bước (ảnh/bằng chứng, khu vực, loại, mức độ, mô tả, đối tượng [quét giấy tờ / thư viện / thủ công], đề xuất xử lý, chọn cán bộ, hạn hoàn thành) | Người giao việc |
| `04` | `case-handling` | Tiếp nhận & xử lý vụ việc: tab Tiếp nhận, Của tôi, Thông báo, chi tiết vụ việc, Đang làm → Hoàn thành (nhập kết quả/lý do), Lịch sử | Cả hai |
| `05` | `record-signing` | Biểu mẫu & chữ ký: lập biên bản, trường thêm theo nhóm cá nhân (hành khách / cán bộ), vật phẩm nguy hiểm, chốt để ký, cá nhân ký + đại diện CACK ký, xem/xuất PDF, ký lại biên bản khi 1 trong 2 bên chưa ký đủ ở lần đầu (đặc tả XL04; [làm rõ L3](../../requirements/specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-26.md)) | Cán bộ |
| `06` | `task-assign` | Giao việc: tạo giao việc, tab Tôi đã giao / Giao cho tôi / Của Đội, chi tiết giao việc | Cả hai |
| `07` | `case-actions` | Thao tác điều phối trên vụ việc: Gia hạn, Phân công lại, Huỷ phần việc, Phân công tiếp | Người giao việc (kể cả cán bộ được uỷ quyền Tổ phó) — [đặc tả §3.4](../../requirements/specs/xu-ly-vi-pham-giao-viec/dac-ta-chuc-nang-v2.1.md), [làm rõ L2a](../../requirements/specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-26.md) |
| `08` | `daily-report` | Tab Cá nhân → Báo cáo hằng ngày: chọn ngày, xem các mục, xuất PDF | Người giao việc |
| `09` | `web-admin` | 🚧 Trang quản trị hệ thống chung (web) — spec chỉ nhắc "lưu kết quả vào trang quản trị", chưa có mô tả/screenshot | ❓ |

🚧 = chưa có mô tả/screenshot. Folder đã tạo sẵn (`.gitkeep`) để chụp ngay khi có.
❓ = spec chưa nói rõ — cần xác nhận, không suy diễn.

### 7.1 screen-name đặc thù CACK (đề xuất)

| screen-name | Dùng khi |
|-------------|----------|
| `login-form` | Màn đăng nhập |
| `statistics` | Khối Thống kê ở Trang chủ |
| `evidence` / `area` / `case-type` / `severity` / `description` / `subject-info` / `proposal` / `assignee` / `review` | 9 bước Tạo vụ việc (theo đúng thứ tự spec; bước 9 trên app là "Xem lại & gửi", chứa cả chọn hạn hoàn thành) |
| `document-scan` | Quét CCCD/hộ chiếu bằng camera trong app |
| `case-list` | Danh sách vụ việc (tab Tiếp nhận / Của tôi) |
| `notification-list` | Tab Thông báo |
| `case-detail` / `case-history` | Chi tiết / Lịch sử một vụ việc |
| `record-form` / `record-preview` / `signature` | Biểu mẫu biên bản / Biên bản đã tạo / Màn ký |
| `pdf-viewer` | Xem biên bản hoặc báo cáo dạng PDF |
| `task-list` / `task-detail` / `task-form` | Danh sách / chi tiết / form tạo Giao việc |
| `extend` / `reassign` / `cancel-part` / `add-assignee` | Gia hạn / Phân công lại / Huỷ phần việc / Phân công tiếp |
| `profile` / `daily-report` | Tab Cá nhân / Báo cáo hằng ngày |
| `*-access` | Bước xin quyền — `camera-access`, `photo-access`, `notification-access` |

---

## 8. AI Requirements

Khi AI đọc bộ screenshot này:

1. Giữ nguyên thứ tự theo `flow-no` → `screen-no`.
2. Suy luận User Flow dựa trên thứ tự file trong cùng `flow-no`.
3. Cùng `screen-no` khác `state` = các trạng thái của **một màn hình duy nhất**,
   không tách thành 2 node trong flow diagram.
4. `screen-name` là `pdf-viewer`, hoặc `state` là `system-dialog`
   → màn hình **ngoài app** — đánh dấu rõ là *external screen* trong wireframe.
5. Không tự tạo thêm hoặc bỏ qua màn hình không có trong screenshot.
6. Giữ nguyên `flow-name` và `screen-name` khi sinh Wireframe / Flow Diagram / PRD.
7. Thiếu bước trong flow → chỉ ghi nhận `possible missing screen`, **không tự bổ sung nội dung**.
8. `state` là `unknown` → cần người xác nhận, không được đoán trong tài liệu output.
9. Khi rename hoặc thêm screenshot mới → **bắt buộc** tuân thủ rule này và cập nhật `index.md`
   **của đúng device**.
10. Device lấy từ **thư mục cha**, không lấy từ tên file. Cùng `flow-no` + `screen-no` ở
    `iphone/` và `web/` = **một màn hình duy nhất**, chỉ khác layout — không tách thành 2 node
    trong flow diagram, mà ghi 2 biến thể layout trong cùng một node.
11. Màn hình chỉ tồn tại ở một device → đánh dấu rõ *device-specific* trong wireframe, kèm tên
    device. Không suy ra rằng device kia thiếu chức năng — có thể chỉ là chưa chụp; đối chiếu
    mục *Possible missing screen* của `index.md` device đó trước khi kết luận.
12. Hậu tố vai trò (`-assigner` / `-officer`) trong `state` → cùng một màn hình, khác quyền;
    ghi 2 biến thể vai trò trong cùng một node, không tách node.
