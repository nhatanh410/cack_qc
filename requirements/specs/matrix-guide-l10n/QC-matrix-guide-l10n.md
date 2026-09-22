# Change note cho QC — Ink 1.2.14

**Phạm vi:** PR #172 + #174 (phần vừa làm).
Build 26 còn chứa #167–#171 từ trước — **không nằm trong note này**.

---

## 1. Ma trận Eisenhower — user tự đặt tên / đổi màu / đổi icon

Trước đây 4 ô là cố định theo phương pháp. Giờ user sửa được.

**Tab Tasks → chuyển sang chế độ Matrix.**

| # | Thao tác | Kết quả mong đợi |
|---|---|---|
| 1.1 | Chạm vào 1 ô | Ô phóng to thành popup ở giữa màn hình, nền bị làm mờ + tối |
| 1.2 | Xem kỹ mép dưới màn hình khi popup mở | **Thanh tab bar phải bị che luôn** — không được còn dải sáng ở đáy |
| 1.3 | Đổi tên ô | Tên mới hiện trên card, trong popup, và trên chip ở danh sách task |
| 1.4 | Đổi dòng mô tả (subtitle) | Đổi theo |
| 1.5 | Đổi màu ô | Card đổi màu — **và các task thuộc ô đó trong danh sách cũng đổi màu theo** |
| 1.6 | Chọn icon | Icon hiện trước tên ô |
| 1.7 | Xoá trắng ô tên rồi lưu | Quay về **tên mặc định**, không được để card trống |
| 1.8 | Nhập tên toàn dấu cách rồi lưu | Như 1.7 — về mặc định |
| 1.9 | Nút Reset | Chỉ hiện khi ô **đã** bị sửa; bấm xong về nguyên bản (tên + màu + icon) |
| 1.10 | Sửa ô A, kiểm tra ô B/C/D | 3 ô kia **không** bị ảnh hưởng |
| 1.11 | Kill app → mở lại | Toàn bộ tuỳ biến còn nguyên |

### ⚠️ Điểm dễ vỡ nhất — cần test kỹ

| # | Thao tác | Kết quả mong đợi |
|---|---|---|
| 1.12 | Tạo vài task, kéo vào các ô. **Đổi tên cả 4 ô.** Kill app, mở lại | **Task vẫn nằm đúng ô cũ.** Đổi tên chỉ là hiển thị — không được làm task rơi ra ngoài / nhảy ô |
| 1.13 | Sau khi đổi tên, đổi ngôn ngữ máy sang tiếng khác | Ô **đã đặt tên** giữ tên user; ô **chưa đặt tên** đổi theo ngôn ngữ mới |
| 1.14 | Chỉ đổi *màu* 1 ô rồi đổi ngôn ngữ máy | Ô đó vẫn phải **dịch tên** theo ngôn ngữ mới (chỉ màu là custom) |

---

## 2. Đưa ma trận lên màn hình khoá

**Điều kiện:** đang ở tab Tasks, chế độ Matrix.

| # | Trạng thái | Kết quả mong đợi |
|---|---|---|
| 2.1 | Wallpaper hiện tại **không** phải matrix | Hiện banner 1 dòng mời đưa matrix lên màn khoá |
| 2.2 | Bấm banner | Nhảy sang tab Discover và **mở đúng template matrix đó** |
| 2.3 | Sau khi đã áp matrix làm wallpaper | Banner **biến mất**, thay bằng nút tròn Update nổi |
| 2.4 | Bấm Update | Mở màn preview wallpaper hiện tại |
| 2.5 | Từ preview đổi sang wallpaper khác (không phải matrix) rồi thoát | Nút Update **biến mất**, banner ở 2.1 quay lại |

> **Lưu ý cho QC:** nút Update ở tab Tasks **luôn hiện** khi matrix đang là wallpaper — không tự phát hiện "có thay đổi hay chưa" như tab Calendar. Đây là **cố ý**, không phải bug: kéo task đổi ô hay tick xong task bằng Siri đều không có cách nào biết chính xác, nên thà mời refresh còn hơn đoán sai.

---

## 3. Header 4 tab dùng chung một kiểu (giao diện kính)

| # | Thao tác | Kết quả mong đợi |
|---|---|---|
| 3.1 | Xem header 4 tab: Discover / Calendar / Tasks / Notes | Nút tròn cùng cỡ, khoảng cách đều, cùng chất liệu kính; tiêu đề thẳng hàng nhau |
| 3.2 | Header Discover, tài khoản **chưa** Pro | Bên phải là **một viên thuốc kính duy nhất** chứa vương miện + bánh răng, ở giữa có vạch ngăn mảnh |
| 3.3 | Header Discover, tài khoản **đã** Pro | Chỉ còn bánh răng — **không được còn vạch ngăn thừa** nằm cạnh nút đơn |
| 3.4 | Nút Guide ở Discover | Là chip kính có chữ, **cao bằng** các nút tròn bên cạnh |
| 3.5 | Chạm sát mép các nút trong viên thuốc | Bấm đúng nút mình nhắm, không lệch sang nút kế bên |

### Cần test trên 2 đời iOS

| # | Máy | Kết quả mong đợi |
|---|---|---|
| 3.6 | **iOS 26** | Kính thật (Liquid Glass) — có phản chiếu, hệ thống tự đổ bóng |
| 3.7 | **iOS 25 trở xuống** | Kính mờ kiểu cũ (frosted). Đây là giao diện app **đã dùng từ trước**, không phải giao diện mới |

---

## 4. Màn hướng dẫn (How-to Guide)

| # | Thao tác | Kết quả mong đợi |
|---|---|---|
| 4.1 | Mở Guide | Mục **"Add the shortcut"** nằm đầu tiên và tự mở sẵn (trước đây là mục xin quyền lịch) |
| 4.2 | Mỗi mục | Có 1–2 dòng giải thích **"để làm gì"** nằm **trên** danh sách bước, chữ nhỏ hơn và mờ hơn các bước |
| 4.3 | Mục shortcut → nút "Set up shortcut" | Mở đúng luồng cài shortcut (chế độ xem lại — user đã cài rồi vẫn đi hết được các bước) |
| 4.4 | Kéo ngang hàng ảnh mục **"Refresh when you close your calendar app"** | Ảnh đã crop sát nội dung — **không còn viền đen letterbox** hai đầu |
| 4.5 | Hàng ảnh nói chung | Ảnh cao thấp khác nhau được, canh **mép trên** thẳng hàng, không bị bóp méo |

---

## 5. Màn giải thích cập nhật màn khoá

| # | Thao tác | Kết quả mong đợi |
|---|---|---|
| 5.1 | Mở màn explainer, xem khối trên cùng | **Chữ bên trái, hình điện thoại bên phải**. Câu đầu tiên bắt đầu thẳng hàng với mọi khối bên dưới |
| 5.2 | Cài đặt → Trợ năng → cỡ chữ **lớn nhất** | Chữ và hình xếp dọc, **hình lên trên**, chữ xuống dưới |

---

## 6. Dịch thuật — 11 ngôn ngữ

Đã thêm một lớp kiểm tra tự động chặn build nếu còn câu tiếng Anh sót trong bản dịch, và **đã dịch sạch toàn bộ nợ cũ**.

| # | Thao tác | Kết quả mong đợi |
|---|---|---|
| 6.1 | Đổi máy sang **Indonesia** và **Malay**, đi hết app | Không còn câu lai kiểu *"Allow kalender access"*, *"1 pengingat due"*, *"Hapus all events in the series"* |
| 6.2 | Đổi sang **Thái / Nhật / Hàn / Trung giản thể / Trung phồn thể** | Không còn nguyên câu tiếng Anh |
| 6.3 | Kiểm tra số nhiều (1 task / nhiều task) | Cả 2 dạng đều đã dịch — không được dạng "nhiều" dịch rồi mà dạng "1" còn tiếng Anh |
| 6.4 | Các ngôn ngữ còn lại (Việt, Tây Ban Nha, Bồ Đào Nha) | Rà lại bình thường |

**Chữ vẫn giữ nguyên tiếng Anh — đúng, không phải lỗi:**
tên shortcut *"Generate Latest Wallpaper"*, *"Refresh Lock Screen"*, *"Google Calendar"*, *"Outlook Calendar"*, *"Live Activity"*, *"Face ID"*, tên font, và các nút của **chính app Shortcuts** được trích dẫn trong màn hướng dẫn (nằm trong ngoặc kép).

### Đổi chữ trong luồng cài shortcut

| Chỗ | Trước | Sau |
|---|---|---|
| Tiêu đề lần đầu | Add the shortcut to set **up** your lock screen. | Add the shortcut to **set** your lock screen. |
| Tiêu đề xem lại | Add **the shortcut**, then schedule it. | Add the **lock screen** shortcut, then schedule it. |

→ Cần xác nhận cả 11 ngôn ngữ đã dịch theo chữ mới.

---

## Đã biết — không phải lỗi mới

- **3 test render ảnh nền dạng Notes** (grid / masonry / single) đang fail. Đã fail sẵn trên `main` **từ trước 2 PR này**, không do thay đổi lần này. Chưa sửa.
- 2 file tài liệu `docs/ai-assist-scope.md` và `docs/ai-chat-tab-prd.md` có trong commit nhưng **chỉ là tài liệu kế hoạch, chưa code gì** — không có gì để QC.

---

## Kết quả test tự động

`2699 test — 3 fail`, đúng 3 test render Notes nói ở trên.
Riêng 22 test mới của phần ma trận: **pass hết**. Bộ test dịch thuật: **13/13 pass**.

## PR tham chiếu

- https://github.com/sfunvn/lockscreen-calendar/pull/172
- https://github.com/sfunvn/lockscreen-calendar/pull/174
