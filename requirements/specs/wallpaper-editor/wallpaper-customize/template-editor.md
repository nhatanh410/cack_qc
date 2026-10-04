# QC — Template editor, sheet chỉnh sửa và hiệu năng Customize

Phần bổ sung cho [component-editor.md](component-editor.md): panel dưới canvas của
**template editor** (màn Edit một template lịch), các sheet mở từ đó và từ Customize,
thư viện ảnh nền đầy, và độ mượt khi chỉnh. Môi trường test như mục 1 của file kia —
**bắt buộc có iOS 26** (nút trên thanh sheet là glass).

---

## 1. Panel dưới canvas

- [ ] Panel có thanh nắm (grabber) ở trên, bo **2 góc trên**
- [ ] Kéo grabber hoặc **hàng tab** lên → panel cao theo ngón tay, thả tay về điểm neo
      gần nhất (mặc định hoặc ~60% màn); kéo xuống → về mặc định
- [ ] Nội dung đang ở **đầu** mà vuốt xuống → panel thu lại; panel chưa cao hết mà vuốt
      nội dung lên → panel cao lên trước, cao hết rồi thì nội dung mới cuộn
- [ ] Vuốt dọc **bắt đầu trên một slider** (Darken, Intensity…) vẫn kéo được panel;
      kéo ngang slider vẫn chỉnh slider, không kéo panel
- [ ] Trong lúc kéo panel: nội dung trong panel, đồng hồ/Dynamic Island trên canvas
      **không** nhảy lên rồi mới về chỗ
- [ ] VoiceOver: grabber đọc **Expand / Collapse**

## 2. Tab trong panel

**Calendar**
- [ ] Danh sách lịch nằm trong một card xám, có vạch ngăn giữa các lịch; không còn hàng
      "All calendars" và không còn chấm màu
- [ ] Trước tên mỗi lịch là icon nguồn: Apple · Google · Outlook · Ink
- [ ] Cạnh tiêu đề có nhãn nhỏ (All / None / tên lịch / số lịch); bên phải là
      **Show all / Hide all** — bấm là chọn/bỏ hết
- [ ] Có vạch ngăn giữa danh sách lịch và **First day of week**

**Background**
- [ ] Không còn "Match colors to photo" (đã sang Style); còn "New photo every day"

**Style** — giống hệt sheet **Global style** trong Customize
- [ ] Các nhóm cách đều nhau, có vạch ngăn; khoảng cách gọn hơn các tab khác
- [ ] Cạnh tiêu đề **Font** là tên font đang dùng (chữ nhỏ, xám)
- [ ] **Event colors**: 3 nút **Default · By calendar · Custom**; cạnh tiêu đề là mô tả
      ngắn đổi theo nút đang chọn (As designed / Each calendar's color / Pick up to 5)
- [ ] **Color tone** (chỉ khi có band sự kiện): **Auto · Light · Dark**, mô tả ngắn cạnh
      tiêu đề; ngay dưới là công tắc **Match colors to photo**. Template không có band
      sự kiện → Match colors to photo đứng thành nhóm riêng
- [ ] Bảng thuộc tính của từng thành phần, dòng **Font**: khi Style đã đặt font chung,
      cạnh tên ghi **From Global style** và dải font mờ; chưa đặt thì ghi tên font

## 3. Sheet chỉnh sửa (thanh điều hướng kiểu iOS)

Áp dụng cho **Layers, Add component, Global style, Emoji, cài đặt sticker/ảnh**:

- [ ] Tiêu đề ở giữa, **✕** bên trái (đóng sheet), nút hành động bên phải — cùng kiểu
      với bảng thuộc tính thành phần
- [ ] iOS 26: nút trên thanh là **glass**, không phải vòng tròn xám; nền sheet đặc
- [ ] Cuộn nội dung → chữ chạy dưới thanh vẫn đọc được (iOS 26 mờ dần, iOS 18 thanh đặc)
- [ ] Cài đặt sticker/ảnh: nút xoá là **thùng rác** trên thanh, bên phải
- [ ] Emoji: sheet vừa đủ dải emoji + hàng tab nhóm, không bị cắt, không thừa khoảng trống

## 4. Layers từ template editor

- [ ] Cạnh nút **Crop** có nút **Layers** → mở panel Layers, **không** có nhóm Background
- [ ] Bên phải thanh có **Edit** → panel đóng rồi mở màn **Customize** (không kẹt, không
      phải bấm hai lần). Layers mở trong Customize **không** có Edit
- [ ] Mỗi dòng là một ô xám riêng; dòng chữ *Hold a row, then drag it to reorder.* căn
      trái, sát nhóm đầu tiên
- [ ] Trong Customize: mỗi dòng component/sticker có nút **−** đỏ bên trái → xoá, Undo
      trả lại được. Layers ngoài template editor không có nút −

## 5. Thư viện ảnh nền đầy — Replace oldest

Thêm ảnh cho tới khi đầy (free: giới hạn free; Pro: giới hạn cứng), rồi bấm ô **+**:

- [ ] Free: popup có **Go Pro** và **Replace oldest**. Pro: **Replace oldest** và Cancel
      (không còn OK)
- [ ] **Replace oldest** → popup đóng rồi mở thư viện ảnh; chọn ảnh → ảnh **cũ nhất**
      biến mất, ảnh mới được dùng làm nền
- [ ] Huỷ trình chọn ảnh → **không** ảnh nào bị xoá
- [ ] Làm ở cả template lịch **và** wallpaper ghi chú (note)

## 6. Hiệu năng Customize

Test trên máy yếu nhất có (iPhone 12 trở xuống nếu được), template nhiều band:

- [ ] Kéo slider (Text size, Darken, knob trong bảng thuộc tính) → canvas đổi **theo
      ngón tay**, không khựng; thả tay → hình cuối khớp đúng giá trị
- [ ] Kéo trong bảng chọn màu (color well) → canvas đổi mượt; đóng bảng màu rồi **Undo
      một lần** → về màu trước khi mở (không phải từng bước nhỏ)
- [ ] Kéo/xoay/phóng sticker, vẽ nét ở Decorate → mượt, lịch phía dưới không nháy
- [ ] Kéo band trong Layout → mượt, thả tay band đứng đúng chỗ, không giật
- [ ] Sau một loạt chỉnh sửa, **set wallpaper** → màn khoá giống hệt canvas

## 7. Cách report

Như [component-editor.md](component-editor.md) mục 12. Lỗi kéo panel hay lag: quay
video màn hình, ghi kiểu máy.
