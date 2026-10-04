# QC — Component lịch mới và knob mới (stack)

Phạm vi: 6 component mới (Agenda, Event tickets, Workout, Daily page, Today at a glance,
Milestones), knob mới trên Week events / Month progress / Priority matrix, icon trang trí,
nhãn bảng chỉnh, ô emoji. Thao tác chung của bảng chỉnh (chọn, kéo, Undo, Card…) ở
[component-editor.md](component-editor.md); spec từng component ở
[docs/components/](../components/new-components.md).

## 1. Chuẩn bị

- [ ] Máy có lịch thật: vài sự kiện hôm nay, một ngày ≥ 3 sự kiện trong tuần, một sự kiện
      cả ngày, một lịch ngày lễ / sinh nhật bật trong Lịch.
- [ ] Reminders có vài việc, ít nhất một việc có giờ.
- [ ] Test cả **tiếng Việt** và một ngôn ngữ khác (Đức hoặc Nhật), cả Light và Dark.
- [ ] Thêm từng component bằng nút **Add** trong Customize → Layout.

## 2. Agenda (Lịch trình)

- [ ] Hiện N ngày tới (mặc định 7), gom theo ngày: cột trái thứ + số ngày to, mỗi sự kiện
      một khối màu có vạch trái, tên đậm, giờ bên phải (hoặc "All day").
- [ ] **Days** 1 và 14; **Events per day** 1 → ngày nhiều hơn hiện dòng **+N more**.
- [ ] Hết chỗ dọc → bỏ ngày **xa nhất** trước, không cắt nửa ngày.
- [ ] Tắt **Show title** / **Date range** → phần đầu mất đúng phần đó.

## 3. Event tickets (Vé sự kiện)

- [ ] Chưa ghim gì → hiện sự kiện sắp tới; ghim (từ lịch) → chỉ hiện sự kiện đã ghim.
- [ ] Đổi **Ticket style** (Classic, Admit, Side stub, Poster) và **Color scheme** → vé
      đổi kiểu, chữ luôn đọc được.
- [ ] Tắt **Cover** / **Location** → vé gọn lại, không chừa khoảng trống.
- [ ] Phóng to chữ (Style → cỡ chữ) → vé cao lên theo, chữ không tràn ra ngoài vé.

## 4. Workout (Lịch tập)

- [ ] **Weekly plan**: chạm một ngày → sheet chọn môn, đặt tên, chi tiết; **Rest** làm ngày đó
      mờ đi.
- [ ] Ô emoji cạnh tên: xem mục 9.
- [ ] Style List / Week strip; Icons Symbol / Emoji; **Fade past days** làm mờ ngày đã qua.
- [ ] Ngày kế tiếp có dòng **Up next** với icon mũi tên; tắt **Decorative icons** → mất icon.
- [ ] Bấm **Reset** của thành phần → kế hoạch tập **vẫn còn**.

## 5. Daily page (Tờ lịch)

- [ ] Ngày to, thứ, sự kiện hôm nay; ngày rảnh → hiện một câu trích dẫn.
- [ ] Ngày lễ (từ lịch ngày lễ) → tên lễ to, sự kiện của ngày đó liệt kê bên dưới.
- [ ] **Lunar date**: máy vùng VN/CN/… mặc định bật, vùng khác mặc định tắt.
- [ ] Dòng âm lịch và ngày lễ có icon (trăng, pháo giấy); tắt **Decorative icons** → mất icon.

## 6. Today at a glance (Tóm tắt hôm nay)

- [ ] Sự kiện chính, thanh giờ, việc cần làm, giờ rảnh — mỗi phần tắt được riêng.
- [ ] Nhãn có icon (mặt trời, checklist); giờ rảnh có icon lá; tắt **Decorative icons** → mất.
- [ ] Ngày đổi giờ mùa hè (nếu máy ở vùng có DST): thanh giờ không lệch một tiếng.

## 7. Milestones (Mốc ngày)

- [ ] **Add a day** → sheet mở ngay; đóng mà **chưa đặt tên** → ngày đó tự biến mất.
- [ ] Tiêu đề sheet = tên ngày; chưa tên thì "New day" (mới) / "Untitled" (cũ).
- [ ] Ngày tới → **còn N ngày**; hôm nay → **Today**; ngày mai/hôm qua → chữ; đã qua → **đã N ngày**.
- [ ] **Every year** → đếm tới lần kế; badge số năm cạnh tên ("6 years", dịch theo ngôn ngữ).
- [ ] Dòng ngày có icon lịch phía trước; con số dài (≥ 4 chữ số) co lại, không tràn thẻ.
- [ ] **Card palette** khác Plain → các thẻ tô xoay vòng màu; thẻ **hôm nay** luôn màu nhấn và
      thẻ ngay sau nó lấy **màu đầu** của bảng.
- [ ] **Card pattern** in họa tiết trên từng thẻ ngày; thẻ nền không có mục họa tiết/ảnh.
- [ ] **Birthdays & holidays** tắt → chỉ còn ngày tự thêm.
- [ ] Máy dùng lịch Phật giáo (Thái): thêm ngày → lưu đúng năm dương lịch, đếm đúng.

## 8. Knob mới trên component cũ

- [ ] **Week events → Style**: Bars / Dots / Heat map. Dots: mỗi sự kiện một chấm, 4 chấm một
      hàng. Heat map: ô đậm theo số sự kiện, ngày bận nhất có **ngọn lửa** (≥ 2 sự kiện; hòa thì
      mọi ngày bằng nhau đều có). Knob của thanh (Block opacity, +N more) chỉ hiện ở Bars.
- [ ] **Month progress → Date range**: This month / Custom. Chọn Custom → tự điền hôm nay và
      +90 ngày; có ô Title. Thanh chuyển **cam từ 75%**, **đỏ từ 90%** (tắt được); ngày trước
      khoảng → 0%, sau khoảng → 100%.
- [ ] **Priority matrix**: **Each box** có 4 màu riêng (Do now, Plan, Delegate, Drop) đè màu
      chung; **Box pattern** in trên cả 4 ô; thẻ nền không còn họa tiết/ảnh.
- [ ] Matrix: **Strike out the Drop box** mặc định **tắt**; bật → việc trong ô Loại bỏ gạch ngang.

## 9. Ô emoji (Milestones, Workout)

- [ ] Ô emoji là **hình vuông**, cao bằng ô tên bên cạnh.
- [ ] Chạm → bàn phím mở thẳng **trang emoji**; chọn một emoji → lưu và bàn phím đóng.
- [ ] Phím xóa → bỏ emoji, ô hiện emoji mặc định mờ.
- [ ] Đổi sang bàn phím chữ (quả địa cầu) gõ chữ → không nhận.
- [ ] Máy đã tắt bàn phím Emoji trong Cài đặt → hiện bàn phím thường, vẫn chỉ nhận emoji.

## 10. Nhãn bảng chỉnh

- [ ] Nhóm thứ ba tên **Backdrop** ("**Nền**"), không phải "Hình nền".
- [ ] Không component nào có hai dòng trùng tên. Thẻ sau cả band ghi **Thẻ nền / Màu thẻ nền /
      Lề thẻ nền**; thẻ con của band: Matrix "ô", Timeline "thẻ sự kiện", Milestones "thẻ".
- [ ] Week schedule: **Days shown** = **Mon – Fri** / **Full week**; chữ đầu cột = **Day header**.
- [ ] Workout: **Weekly plan** ("Kế hoạch tuần").
- [ ] Ô Drop của Matrix (cả widget và form nhắc nhở) bằng tiếng Đức/Ý/Nga không còn nghĩa
      "giọt nước".
- [ ] Ô nhập tiêu đề trong bảng chỉnh căn **trái**.

## 11. Chia sẻ template

- [ ] Share template có Milestones → người nhận **không** thấy ngày riêng (tên, ngày) của người
      gửi; có Event tickets → không thấy sự kiện đã ghim.
- [ ] Ảnh thẻ chọn từ máy không đi theo link share.

## 12. Chưa làm — không report

- Màu chữ tiêu đề Matrix chưa đổi theo **Color tone** Light/Dark trong Customize.
- Ảnh so sánh (golden) chỉ chạy trên iOS 18.6 qua CI đêm.
