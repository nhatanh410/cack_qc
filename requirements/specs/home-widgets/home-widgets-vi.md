# Home-screen widget — checklist QC

Phạm vi: 11 widget màn hình chính, màn cấu hình widget trong app (Preview / Layout / Style /
Calendars) và cách widget thật đọc cấu hình. Không gồm widget khoá màn hình và Live Activity.

**Chuẩn bị:** máy có lịch với vài sự kiện hôm nay, vài task ở đủ 4 nhóm Reminder
(Do now / Plan / Delegate / Drop), một task có giờ, một task lặp. Test cả **Light** và **Dark**.
Các widget ma trận **không** khoá Pro.

## 1. Danh sách widget

| Widget | Cỡ | Tuỳ chọn Layout | Nhãn màu Style |
|---|---|---|---|
| Calendar | Medium, Large | Events per day, Show event time | Today highlight |
| Today Timeline | Medium | — | Current time color |
| Tasks | Small, Medium | Task rows, Show month grid | Today highlight |
| Up Next | Small | Show countdown | Event color |
| Agenda | Medium, Large | Show event time, Show tomorrow, Today/Tomorrow axis | Today highlight |
| Month Tasks | Large | Task rows | Today highlight |
| Task Graph | Medium | — | Heatmap color |
| Date & Matrix | Medium | Show counts, Show due dates | Today highlight |
| Matrix | Medium, Large | Task rows, Show counts, Show due dates | (không có — mỗi nhóm giữ màu riêng) |
| Today's Schedule | Large | Task rows, Show counts, Show due dates | Today highlight |
| Calendar & Matrix | Large | Task rows, Show counts, Show due dates | Today highlight |

- [ ] Cả 11 widget có trong danh sách widget của iOS và trong màn danh sách widget của app.
- [ ] Mỗi dòng bảng trên: đúng cỡ, đúng các tuỳ chọn Layout, đúng nhãn màu (không thừa, không thiếu).
- [ ] Ma trận: nhóm và màu khớp tab Reminder (Do now / Plan / Delegate / Drop).

## 2. Màn cấu hình

- [ ] **Preview** vẽ đúng như widget thật (cùng tỉ lệ, chữ, màu); đổi tuỳ chọn thì preview đổi ngay.
- [ ] Khung preview nền xám như canvas editor, không có viền xám bao quanh thẻ widget; thẻ co giãn theo khung, giữ đúng tỉ lệ.
- [ ] Đổi tab Layout ↔ Style ↔ Calendars: nút dưới cùng **không nhảy vị trí**.
- [ ] **Style:** Accent + Background, mỗi hàng có icon + label, dãy màu nằm **dưới** label, căn trái thẳng với icon, khoảng cách label–màu vừa phải, không còn card xám bao ngoài.
- [ ] Dãy màu giống editor: chip **Auto**, ô chọn màu hệ thống, rồi 4 màu có sẵn. Chọn **Auto** trả về mặc định; chọn màu tuỳ ý thì Auto tắt.
- [ ] Cỡ chữ Dynamic Type lớn nhất: dãy màu không bị cắt hay tràn ngang.
- [ ] **Calendars:** chỉ hiện ở widget có sự kiện (Calendar, Agenda, Today Timeline, Up Next, Today's Schedule, Calendar & Matrix, Date & Matrix); bỏ chọn một lịch thì sự kiện của lịch đó biến khỏi widget.
- [ ] Nút lưu áp dụng cho widget thật trên màn hình chính (thử xoá và thêm lại widget nếu vẫn thấy bản cũ).

## 3. Màu nền và độ tương phản

- [ ] Mặc định (Auto): trắng ở Light, `#1A1F27` ở Dark — không ngả tím.
- [ ] Chọn nền: hiện **đúng màu đã chọn**, đặc, không bị làm mờ; không đổi theo Light/Dark của máy.
- [ ] Nền tối (đen, navy) → chữ sáng; nền sáng (vàng, trắng) → chữ tối. Kiểm tra cả widget ma trận.
- [ ] Chip sự kiện (Calendar tuần/tháng, khối Today Timeline) vẫn đọc rõ trên nền vàng và nền navy.
- [ ] **Vòng tròn ngày hôm nay:** thấy được số (nền tối: vòng trắng, số đen; nền sáng: vòng đen, số trắng); có chọn màu thì vòng màu đó, số trắng.
- [ ] Nền sáng bão hoà: nhãn nhóm "Delegate" (cam) có thể khó đọc — ghi lại, chưa sửa.

## 4. Widget ma trận

- [ ] Số task bên phải tên nhóm nằm trong vòng tròn nền nhạt, chữ đậm; **Show counts** tắt thì ẩn.
- [ ] Chữ hạn (Today, Tomorrow…) dưới tên task màu trung tính, kể cả task quá hạn; **Show due dates** tắt thì ẩn.
- [ ] Có vạch chia mảnh giữa các nhóm.
- [ ] Today's Schedule: các task gộp trong một nền xám nhạt.
- [ ] **Task rows** chỉ đưa ra số dòng widget thực sự hiển thị (Matrix 1–3; Today's Schedule, Calendar & Matrix 1–2); chọn số nào cũng thấy khác nhau.
- [ ] Nhóm rỗng hiện trạng thái trống, không vỡ layout; tên task dài bị cắt một dòng.
- [ ] Chạm ô tròn task trên widget → task hoàn thành và widget cập nhật.

## 5. Dữ liệu và cập nhật

- [ ] Thêm/sửa/hoàn thành task, thêm sự kiện trong app → widget cập nhật (chờ vài giây đến vài phút).
- [ ] Đổi ngôn ngữ / ngày đầu tuần: tên thứ và thứ tự cột đúng (thử Arabic RTL).
- [ ] Máy chưa cấp quyền lịch: widget hiện trạng thái trống, không crash.
- [ ] Cấu hình cũ từ bản trước (widget đã thêm sẵn) mở lên không mất tuỳ chọn, không crash.

## Đã biết, chưa sửa

- Accent trên Tasks cỡ Small chưa có tác dụng.
- Calendar: các tuỳ chọn Layout chỉ áp dụng cho cỡ Medium.
- Preview của widget cũ vẫn là bản vẽ tay (chỉ Calendar và 4 widget ma trận render bằng view thật).
