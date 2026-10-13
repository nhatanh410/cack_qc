# QC — Day brief, Quote trở lại sheet "+", mép card răng cưa

Ba thay đổi trong cùng một PR:

1. Component mới **Day brief** (vi: **Điểm tin ngày**, type `daySummary`): tóm hôm nay hoặc tuần này thành vài câu, kèm sticker theo mood.
2. **Quote** có lại trong sheet "+" (nhóm **Text**).
3. Hai knob mới cho template: card **mép răng cưa** và **vạch kẻ giữa các khối** của column.
   Hai knob này chưa có nút trong editor; chỉ template viết sẵn mới dùng.

Spec chi tiết: [day-summary-component.md](../components/day-summary-component.md),
[existing-part-knobs.md](../components/existing-part-knobs.md).

## Chuẩn bị

- Bản **dev** từ Firebase App Distribution, test trên 1 máy **iOS 27** và 1 máy **iOS 26**, cả **light** lẫn **dark mode**.
- Cấp quyền **Lịch** và **Lời nhắc** cho Ink.
- Lịch thử cho hôm nay. Tạo bằng app Calendar/Reminders:
  - 3 event có giờ: một event **dài ≥ 1 tiếng** buổi sáng, một event buổi chiều, một event ngắn 30 phút.
  - 2 lời nhắc hạn hôm nay. Một cái đặt **Ưu tiên cao** (hoặc xếp vào ô "Do now" trong ma trận của Ink), có giờ.
  - 1 event có tên **rất dài**, ví dụ "Họp tổng kết quý với toàn bộ đội thiết kế và đối tác".
- "Đổi ngôn ngữ" = Settings → Ink → Language. Cần thử **Tiếng Việt**, **English** và **العربية**.
- Wallpaper chỉ vẽ lại khi shortcut chạy, không cập nhật theo giờ. Đổi lịch xong phải cập nhật wallpaper (nút trong app, hoặc chạy shortcut) mới thấy chữ mới.

---

## 1. Day brief (Điểm tin ngày)

### Thêm và mặc định

- [ ] Customize một wallpaper → **+** → nhóm **Events** có ô **Day brief / Điểm tin ngày** đứng **đầu**, có thumbnail và một dòng mô tả.
- [ ] Thêm vào → band hiện ngay, **không card** (nền Auto). Từ trên xuống: dòng ngày ("10 tháng 7, 2026", chữ đầu viết hoa) · tên thứ **to** + chấm đỏ · sticker góc phải · đoạn câu · vạch kẻ · hàng số liệu.
- [ ] Dòng ngày to và đậm, rõ trên cả nền tối lẫn sáng.

### Câu chữ

- [ ] Câu đọc **tự nhiên**, không giống danh sách. Ví dụ vi: "Đừng quên **Mua đồ** trước 17:30. **Ôn thi** chiếm trọn buổi sáng, 3g từ 09:00. Sau đó là **Cầu lông** lúc 15:00."
- [ ] Tên event và lời nhắc nằm trong **pill màu**. Event mang màu lịch của nó và có chấm màu; lời nhắc quan trọng có pill đỏ với lá cờ.
- [ ] Event tên rất dài: pill bị cắt và có "…", **không** tràn khỏi dòng, **không** đè sticker.
- [ ] Không bao giờ quá **4 dòng**. Lịch nhiều thì câu cuối bị bỏ, không có câu nào bị cắt giữa chừng.
- [ ] Giờ theo cài đặt 12h/24h của máy.
- [ ] Event kéo qua đêm (22:00 hôm qua → 06:00 hôm nay) được nói là "buổi sáng, … từ 00:00", **không** phải "buổi tối, từ 22:00".

### Sticker theo mood

| Lịch hôm nay | Sticker |
|---|---|
| Không event, không lời nhắc | 😎, câu "Hôm nay lịch trống trơn…", không có hàng số liệu |
| ≤ 2 event, rảnh ≥ 6 tiếng | 😌 |
| Có lời nhắc **Ưu tiên cao** / Do now | 🤓, câu về lời nhắc đứng đầu |
| ≥ 5 event, hoặc rảnh < 2 tiếng | 💪 |
| Các ngày còn lại | 😊 |

- [ ] Đổi lịch theo từng dòng trong bảng → cập nhật wallpaper → sticker và câu mở đầu đổi đúng.
- [ ] Sticker hiện **trọn**, không bị cắt mép.

### Công tắc trong panel của band

- [ ] **Tuần này**: tiêu đề thành "Tuần này", dòng ngày thành khoảng tuần, câu nói về cả tuần ("Thứ Sáu là ngày bận nhất…"). Ô thứ 3 của hàng số liệu là ngày bận nhất kèm ngọn lửa.
- [ ] **Tên thứ** tắt: mất tên thứ to, còn dòng ngày "Thứ Sáu, 10 tháng 7".
- [ ] **Tiêu đề dạng thẻ** tắt: tên event thành chữ đậm, không có pill.
- [ ] **Số lượng** tắt: mất hàng số liệu; câu mở đầu lúc này tự nói số ("Hôm nay có 3 sự kiện và 2 việc.").
- [ ] **Tên sự kiện** tắt: **không** còn tên event hay lời nhắc nào trên màn hình ("Quãng bận dài nhất kéo dài 3g, từ 09:00.").
- [ ] **Sticker cảm xúc** tắt: mất sticker; đoạn câu dùng hết bề ngang.
- [ ] More options → **So với tuần trước** chỉ hiện khi đang bật **Tuần này**; tắt thì mất mũi tên ↑/↓ cạnh số event.
- [ ] More options → **Icon trang trí** tắt: mất icon trong pill và hàng số liệu, chữ dồn sát lề trái, không chừa khoảng trống.
- [ ] Đổi cỡ, màu chữ của **Tóm tắt**, **Thứ trong tuần**, **Ngày**, **Dòng chú thích** (hàng số liệu): có tác dụng ngay.
- [ ] Bật **Thẻ nền** trong Background: một card chung bọc cả band.

### Ngôn ngữ

- [ ] **Tiếng Việt**, **English**: đúng hết các mục trên.
- [ ] **العربية**: tên thứ và dòng ngày căn **phải**, sticker sang **trái**, câu chạy phải→trái, pill vẫn ôm đúng tên (kể cả tên tiếng Anh), hàng số liệu bắt đầu từ phải.
- [ ] Lướt nhanh 2–3 ngôn ngữ khác (日本語, Deutsch, Русский): câu không lỗi ký tự lạ như `%@`, không tràn.

### Riêng tư

- [ ] Chưa cấp quyền Lời nhắc: band vẫn vẽ, chỉ không có câu về lời nhắc, không crash.

---

## 2. Quote trong sheet "+"

- [ ] Customize → **+** → có nhóm **Chữ** (en: Text) chứa **Quote**, thumbnail dấu ngoặc kép. Almanac day và Timeline vẫn **không** có trong sheet.
- [ ] Thêm Quote → hiện "Make today count." → Content → **Trích dẫn** sửa được câu ngay; thêm câu thứ 2 thì mỗi ngày đổi một câu.
- [ ] Template có sẵn quote: vẫn sửa như trước.

---

## 3. Mép răng cưa và vạch kẻ (template)

Chưa có template nào trong catalog dùng hai knob này. Phần này chỉ test khi team template gửi template thử có `container.edge: "scallop"` hoặc `divider` trên column.

- [ ] Card có mép trên và dưới **răng cưa** đều nhau, hai đầu đối xứng; ảnh nền card, blur, pattern, viền đều đi theo mép răng cưa.
- [ ] Column có `divider`: một vạch (liền hoặc gạch đứt) giữa mỗi hai khối. Khối trống (ví dụ danh sách lời nhắc rỗng) **không** sinh ra hai vạch sát nhau.
- [ ] Bản app cũ mở cùng template: card bo góc thường, không có vạch, không lỗi.
