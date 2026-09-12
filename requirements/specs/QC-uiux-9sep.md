# Change note cho QC — Ink 1.2.15

**Phạm vi:** PR #179. Chỉ phần vừa làm — không gồm #177/#178 đã merge trước đó.

---

## 1. Header 4 tab đổi sang nền kính

Toàn bộ nút tròn trên thanh trên cùng (back, ✕, Save/Done, Share, Help, ⋯) nay là kính.
Nút tròn ở **hàng hành động dưới đáy** màn chi tiết vẫn giữ nền trắng đặc — **đúng thiết kế**, không phải sót.

| # | Thao tác | Kết quả mong đợi |
|---|---|---|
| 1.1 | Mở các màn có header: Discover, Calendar, Tasks, Notes, chi tiết template, editor | Nút tròn cùng chất liệu kính, không còn nút trắng đơn lẻ lạc giữa hàng |
| 1.2 | Màn có nút **Save/Done** — để trống form cho nút bị **disable** | Nút phải **mờ đi rõ ràng** so với lúc bấm được |
| 1.3 | Bấm Save, nhìn lúc đang quay vòng loading | Vòng quay nằm trên chính nút đó, **không có đĩa tròn đen** nhá lên |
| 1.4 | So sánh **iOS 26** với **iOS cũ hơn** | iOS 26: kính thật, có phản chiếu. iOS cũ: kính mờ kiểu cũ (là giao diện app đã dùng từ trước) |

> 1.2 và 1.3 là **2 lỗi có thật** vừa sửa, trước đây bị che vì nút nào cũng đang màu tối. Test kỹ 2 case này.

---

## 2. Discover — duyệt theo mục đích sử dụng

| # | Thao tác | Kết quả mong đợi |
|---|---|---|
| 2.1 | Mở danh sách duyệt template | Chia nhóm theo mục đích: "Lịch học", "Ghi chú", "Kế hoạch hằng ngày"… |
| 2.2 | Kiểm tra thứ tự nhóm | Ổn định, không đổi mỗi lần mở |
| 2.3 | Cuộn xuống cuối | Template chưa gắn nhóm nằm ở nhóm cuối cùng — **không được mất template nào** |
| 2.4 | Nút **Filter** trên header, chọn 1 loại rồi chọn 4 loại | Chữ luôn là "Filter", số nằm trên **chấm tròn nhỏ** cạnh bên. Bề rộng nút gần như không đổi |
| 2.5 | Lặp lại 2.4 ở **tiếng Đức / Bồ Đào Nha / Việt** (ngôn ngữ chữ dài) | Nút **không được tràn** ra ngoài hoặc **đè lên tiêu đề** ở giữa header |

---

## 3. Notes — kéo/xoay khối chữ trên template ảnh

Đây là phần **mới hoàn toàn**, cần test kỹ nhất.

| # | Thao tác | Kết quả mong đợi |
|---|---|---|
| 3.1 | Mở note dùng template ảnh → vào chế độ sắp xếp | Chạm chọn khối, kéo di chuyển, chụm 2 ngón phóng to/thu nhỏ, 2 ngón xoay, kéo góc để scale 1 tay |
| 3.2 | Trong chế độ sắp xếp, chạm vào chữ | **Không** hiện bàn phím — chế độ sắp xếp tạm ngưng gõ chữ |
| 3.3 | Chạm vào vùng ảnh trống | Bỏ chọn khối |
| 3.4 | **Xoay nghiêng** khối tiêu đề rồi kéo về sát góc ảnh | **Góc khối không được thò ra ngoài ảnh** (đã tính theo khung bao sau khi xoay) |
| 3.5 | Thu nhỏ khối tiêu đề | Chữ **co lại theo khung** — trước đây tiêu đề không co, chữ tràn ra ngoài |
| 3.6 | Thu nhỏ khối nội dung | Co lại y như tiêu đề — 2 khối phải hành xử giống nhau |
| 3.7 | Sắp xong → thoát → mở lại note; xem note trên **card danh sách**, **hình nền khoá**, **Live Activity** | Khối nằm **đúng chỗ đã đặt** ở cả 3 nơi |

### ⚠️ Cỡ chữ tăng 1pt — cần soi

Vừa sửa một lỗi: chữ nào **vừa khung** thì trước đây bị render **nhỏ hơn 1pt** so với cỡ đã chọn. Giờ đúng cỡ.

| # | Thao tác | Kết quả mong đợi |
|---|---|---|
| 3.8 | Mở lại các note **đã tạo từ trước**, xem trên card, hình nền, Live Activity | Chữ **to hơn 1pt** so với bản cũ — đúng. Nhưng phải xác nhận **không có note nào bị cắt chữ / tràn khung** vì tăng cỡ |

---

## 4. Notes — chọn template & chọn font

| # | Thao tác | Kết quả mong đợi |
|---|---|---|
| 4.1 | Chọn template cho note | Chỉ còn **một** màn chọn (màn chọn nhanh cũ đã bỏ). Áp dụng template chạy đúng |
| 4.2 | So sánh ô template ở màn chọn và ở thanh trong editor | Cùng kiểu hiển thị; thanh trong editor không hiện tên preset ("#12") |
| 4.3 | Mở danh sách **font** | Mỗi tên font hiển thị **bằng chính font đó** |
| 4.4 | So font ở editor note và ở editor hình nền | Cùng một font phải trông giống nhau ở cả 2 nơi |

---

## 5. Hình nền từ note — màn preview làm lại

| # | Thao tác | Kết quả mong đợi |
|---|---|---|
| 5.1 | Mở preview hình nền từ một note | Header giống các màn preview khác (không còn tự vẽ riêng) |
| 5.2 | Bảng điều khiển bên dưới | Là **panel cố định 2 tab** (Background / Layout), **không còn sheet kéo lên kéo xuống** |
| 5.3 | **Trên iPad**: mở preview rồi **xoay ngang/dọc** | Ảnh **vẽ lại theo chiều mới**. Trước đây iPad hiện **ảnh bị cắt sai**, không giống hình nền thật sẽ nhận |
| 5.4 | Đổi máy sang tiếng Việt, xem 2 nhãn "Lockscreen" và "Current" trên màn này | Phải **đã dịch**. Trước đây màn này để tiếng Anh trong khi màn lịch đã dịch |

---

## 6. Bảng màu của template (chưa bật)

Đã thêm khả năng template tự khai báo bảng màu sự kiện, **nhưng chưa template nào dùng**.

| # | Thao tác | Kết quả mong đợi |
|---|---|---|
| 6.1 | Xem lại các hình nền lịch hiện có (tuần, tháng, timeline, thời khoá biểu, danh sách hôm nay) | Màu sự kiện **y hệt trước**, không đổi gì |
| 6.2 | Vào Edit sheet chọn **Custom** và chọn màu | Vẫn hoạt động như cũ |
| 6.3 | Chọn nguồn màu **Calendar** | Sự kiện lấy màu lịch như cũ |

---

## Đã biết / cần bạn quyết

- **VoiceOver tiếng Anh đọc "1 filters"** khi chọn đúng 1 bộ lọc (sai ngữ pháp). Nguyên nhân: quy tắc của dự án không cho phép đặt riêng bản tiếng Anh cho chuỗi mới. Sửa đúng là đổi câu gốc thành dạng không phụ thuộc số ít/nhiều (vd "1 selected" / "3 selected"), phải dịch lại 11 ngôn ngữ — **chưa làm, chờ quyết**.
- Thêm **1 màu sticky note mới** (xanh dương) vào bộ preset → tổng 71 preset. Nếu QC có checklist đếm số preset thì cập nhật lại.

---

## Kết quả test tự động

**2826 test — 0 fail.**
3 test render Notes vốn fail ở các bản trước đã được sửa trên `main`, nên lần này **sạch hoàn toàn**.

## PR

https://github.com/sfunvn/lockscreen-calendar/pull/179
