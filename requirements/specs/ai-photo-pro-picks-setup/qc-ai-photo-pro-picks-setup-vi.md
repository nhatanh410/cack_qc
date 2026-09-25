# QC — Ink AI đọc ảnh, thử tính năng Pro trước khi mua, luồng setup shortcut, badge Guide

PR: [sfunvn/lockscreen-calendar#317](https://github.com/sfunvn/lockscreen-calendar/pull/317)

## Chuẩn bị

- Bản **dev** từ Firebase App Distribution. Test trên 1 máy **iOS 27** và 1 máy **iOS 26**.
- Dùng tài khoản **Free**. Settings của bản dev có nút **Grant Pro (dev)** / **Revoke Pro (dev)** để chuyển qua lại Free và Pro.
- Chuẩn bị vài ảnh trong thư viện: một ảnh chụp thời khoá biểu hoặc poster có chữ rõ, một ảnh **không có chữ** (phong cảnh), và một ảnh chụp trang sách **rất nhiều chữ**.
- Có ít nhất một sự kiện trong Calendar vào ngày mai lúc 15:00–16:00, để test cảnh báo trùng lịch.
- Đổi ngôn ngữ ở iOS Settings → Ink → Language khi cần kiểm chữ.

---

## 1. Ink AI: gửi ảnh để tạo sự kiện

Ở tab Ink AI, ô nhập có thêm nút **+** bên trái.

- [ ] Bấm **+** thì thư viện ảnh của iOS mở ra. **Không** có hộp xin quyền truy cập ảnh.
- [ ] Chọn ảnh có chữ:
  - ảnh hiện ngay bên phải thành ô vuông;
  - dòng chờ ghi "Reading the photo…" rồi "Still going…";
  - chữ đọc được hiện dưới ảnh, thu gọn 3 dòng, bấm vào để mở hoặc thu lại;
  - sau đó Ink trả lời và tạo thẻ sự kiện như khi gõ tay.
- [ ] Bấm vào ảnh: ảnh mở toàn màn hình, có nút ✕ góc trên trái. Kéo xuống đủ xa thì đóng, kéo ít thì ảnh bật lại.
- [ ] Ảnh **không có chữ**: ảnh vẫn hiện, sau đó báo "No text found in that photo…". Không có nút Retry, có nút tạo thủ công. **Không** bị trừ lượt hỏi trong ngày.
- [ ] Ảnh **rất nhiều chữ**: Ink chỉ đọc phần đầu, trả lời xong thì thêm câu "That photo has a lot of text, so I only read the first part…".
- [ ] Chọn lại **đúng ảnh vừa gửi** lần nữa: vẫn gửi được.
- [ ] Đang đọc ảnh thì bấm **Clear chat**: chat trống hẳn, **không** có ảnh cũ hiện lại.
- [ ] Tắt mạng rồi gửi ảnh: báo lỗi mạng. Bật mạng lại rồi bấm Retry: gửi lại chữ, không đọc lại ảnh.
- [ ] Tắt app rồi mở lại: ảnh và chữ trong lịch sử chat vẫn còn.
- [ ] Nút **+** bị ẩn khi đang viết quote, hoặc khi đã hết lượt hỏi trong ngày.
- [ ] Ô nhập: khi chưa bấm vào thì nằm trên một hàng; bấm vào thì chữ chiếm cả chiều ngang, các nút xuống hàng dưới. Bàn phím **không** bị tắt khi đổi qua lại.
- [ ] Màn Help (hỏi đáp) **không** có nút +.

## 2. Ink AI: cảnh báo trùng lịch

Cần đã cấp quyền lịch.

- [ ] Gõ "gym tomorrow 3pm". Thẻ sự kiện hiện dòng cam **"Overlaps with <tên sự kiện>"**.
- [ ] Đổi giờ thẻ sang giờ trống thì dòng cảnh báo biến mất. Đổi lại giờ trùng thì dòng cảnh báo hiện lại.
- [ ] Sự kiện liền kề (15:00–16:00 cạnh 16:00–17:00) **không** bị báo trùng.
- [ ] Bấm Add để lưu thẻ: dòng cảnh báo biến mất.
- [ ] Task, sự kiện cả ngày và thẻ chưa có giờ: không có cảnh báo.
- [ ] Chưa cấp quyền lịch: không có cảnh báo và **không** hiện hộp xin quyền. Cấp quyền rồi quay lại app: cảnh báo hiện ra.

## 3. Ink AI: copy và độ dài tin nhắn

- [ ] Giữ tay trên một bong bóng chat có chữ (của mình, của Ink, hoặc bong bóng lỗi) thì hiện menu **Copy**. Dán ra app khác thì đúng nội dung. Áp dụng cho cả màn Help.
- [ ] Bong bóng chỉ có thẻ hoặc danh sách: không có menu.
- [ ] Gõ tin dài: tới **1000 ký tự** vẫn gửi được. Quá 1000 thì hiện "N of 1000 characters" và nút gửi bị khoá.

## 4. Editor: thử tính năng Pro trước khi mua

Trước đây user Free bấm vào lựa chọn có vương miện là mở paywall ngay. Giờ **user Free được chọn thử và thấy kết quả trên canvas**; tới lúc bấm nút xác nhận mới hỏi.

Các lựa chọn Pro áp dụng cơ chế này:
- font Pro (tab Style);
- màu sự kiện **Custom** (tab Style);
- ảnh nền Pro trong catalog (tab Background);
- mode Home Screen Pro (Background → Home Screen).

Làm cho từng lựa chọn:

- [ ] Chọn được, canvas đổi theo ngay.
- [ ] Nút **Set as current / Update wallpaper** có thêm nhãn **PRO**. Chọn lại giá trị lúc mở editor thì nhãn PRO biến mất.
- [ ] Bấm nút xác nhận thì hiện popup **"Keep your Pro picks?"**, liệt kê từng lựa chọn kèm giá trị đã chọn (tên font, chấm màu, tên mode, "×2" nếu nhiều ảnh).
  - [ ] **Unlock Pro**: mở paywall, vẫn ở trong editor. Mua xong thì nhãn PRO biến mất; bấm xác nhận lần nữa mới set, không tự set.
  - [ ] **Set without Pro**: mọi lựa chọn Pro quay về như lúc mở editor, rồi chạy luồng set bình thường.
  - [ ] Vuốt popup xuống thì không có gì xảy ra, vẫn ở trong editor.
- [ ] **Ảnh nền của mình bị thay bằng ảnh Pro**: wallpaper đang dùng ảnh riêng, chọn thử một ảnh nền Pro, rồi chọn Set without Pro. Wallpaper phải quay về **đúng ảnh riêng ban đầu**, không phải ảnh mặc định của template. Ảnh preview trong luồng set cũng không được còn ảnh Pro.
- [ ] **Mode Home Screen Pro chưa xác nhận**: chọn thử "My photo", rồi thoát ra màn hình chính **không** bấm xác nhận, sau đó chạy shortcut. Home Screen **không** được đổi theo mode Pro.
- [ ] Mở editor cho mẫu đã có sẵn lựa chọn Pro (user vừa hết Pro): không bị hỏi về những lựa chọn có sẵn đó.
- [ ] User **Pro**: không thấy nhãn PRO, không có popup.
- [ ] Popup hiển thị đủ khi có 4 dòng trở lên, với chữ cỡ lớn, và ở tiếng Đức / tiếng Nga (không tràn, không bị cắt mất nút).

## 5. Decorate: Cutout và style chữ Pro

- [ ] Cutout (trong menu thêm) có vương miện nhưng dùng được với user Free.
- [ ] Style chữ Pro trong khung soạn chữ có vương miện nhưng áp dụng được; nút ✓ của khung soạn chữ có vương miện khi đang dùng style Pro.
- [ ] Nút ✓ của Decorate có vương miện khi vừa thêm cutout hoặc style chữ Pro. Bấm vào thì hiện cùng popup, với nút thứ hai là **"Save without Pro"**.
  - [ ] Go Pro: mở paywall, vẫn ở trong Decorate.
  - [ ] Save without Pro: cutout bị bỏ, chữ giữ nguyên nội dung nhưng về style mặc định, rồi đóng Decorate.
- [ ] Xoá cutout trước khi bấm ✓ thì không bị hỏi.

## 6. Hàng ảnh nền và màn Backgrounds

Áp dụng cho hàng ảnh nền Lock và hàng "My photo" của Home Screen.

- [ ] Thứ tự: ô thêm ảnh → ảnh template/Default → ảnh của mình → 15 ảnh catalog đầu tiên → ô **More (›)** (chỉ hiện khi catalog có hơn 15 ảnh).
- [ ] Ảnh đã chọn nằm ngoài 15 ảnh đầu vẫn hiện trong hàng.
- [ ] Bấm More: mở màn **Backgrounds** toàn màn hình, có ✕ và +, các chip "All N", "Your photos N" (nếu có ảnh riêng) và từng danh mục kèm số lượng. Lưới cuộn tới ảnh đang chọn.
- [ ] Tên danh mục hiển thị đúng ngôn ngữ (Cute, Doodle, Floral, Food, Minimal, Nature, Quotes, Wealth).
- [ ] Màn Lock: wallpaper một ảnh thì chọn xong đóng màn; bật "New photo every day" thì chọn được nhiều ảnh. Chạm giới hạn Free thì đóng màn rồi hiện popup giới hạn.
- [ ] Màn Home Screen: chọn hoặc thêm ảnh thì đóng màn.

## 7. Thay đổi giao diện nhỏ

- [ ] Ảnh nền đang chọn có dấu **tick** ở góc trên phải. Với ảnh của mình, dấu tick **thay cho nút ✕** khi đang chọn (bỏ chọn thì mới xoá được).
- [ ] Ảnh Pro đang chọn thì ẩn nhãn PRO.
- [ ] Khoảng cách giữa các ô ảnh hẹp lại (6pt), kể cả ở màn chọn nền của note.
- [ ] Ảnh riêng lần đầu hiện có thể nháy nền xám rồi mới lên ảnh. Kiểm tra: **crop lại một ảnh** thì ô ảnh đổi theo khung mới ngay, không giữ khung cũ.
- [ ] Popup "Photo limit reached" / "Photo set is full" (user Free) có hình vương miện mới, không bị cắt.

## 8. Luồng setup shortcut

**Setup lần đầu** (Home banner hoặc Settings → Set up shortcut, khi chưa có shortcut):

- [ ] Bấm **Tap to add shortcut** → thêm shortcut → quay lại app. Nút **"I've added it — check now"** hiện lên và trở thành nút chính (to, tối, nằm trên). Nút add phía dưới đổi thành **"Re-add shortcut"** (nhạt).
- [ ] Kiểm tra không thấy shortcut: hiện câu báo lỗi, nút **Re-add shortcut** là nút chính (có dấu +), **Try again** ở dưới.
- [ ] Lỗi do từ chối quyền đặt wallpaper: **không** có Re-add, Try again là nút chính.

**Settings → Set up shortcut, khi đã có shortcut:**

- [ ] Shortcut chạy thành công **trong 24 giờ qua**: trang shortcut mở ra ở trạng thái xong. Tiêu đề **"Shortcut is working!" ✅**, mô tả "Now let's make it run every day.", chỉ có nút **Next**, không có Re-add và không có dòng hướng dẫn "step 1". Bấm Next thì sang bước automation, không mở Shortcuts.
- [ ] Quá 24 giờ (hoặc chưa từng chạy): tiêu đề "Check your lock screen shortcut.", nút **"I've added it — check now"**. Bấm vào thì app mở Shortcuts chạy thử, quay về thì kiểm tra rồi sang bước automation.
- [ ] Kiểm tra thành công rồi bấm **Back** từ bước automation: trang shortcut ở trạng thái xong (như trên), bấm Next thì sang lại automation mà **không** chạy shortcut lần nữa.
- [ ] Thoát ở bước automation: sau đó app **không** hiện lại lời mời setup automation.

## 9. Settings: dòng trạng thái shortcut

- [ ] Shortcut đã cài nhưng automation hằng ngày chưa chạy lần nào: dòng dưới "Set up shortcut" ghi **"Shortcut added · daily refresh not detected yet"**. Kiểm ở vài ngôn ngữ (vi: "Đã thêm phím tắt · chưa ghi nhận lần tự làm mới nào").
- [ ] Automation đã chạy: vẫn là "Refreshed automatically …" như cũ.

## 10. Guide: badge Done / To do

Mở tab Guide.

- [ ] **Add the shortcut (once)**: đã cài shortcut bản mới nhất thì có badge xanh **Done** (có tick), chưa cài (hoặc đang dùng shortcut bản cũ) thì có badge **To do**.
- [ ] **Allow calendar access**: đã cấp quyền lịch thì **Done**, chưa cấp thì **To do**.
- [ ] Vào iOS Settings bật hoặc tắt quyền lịch rồi quay lại app: badge đổi ngay.
- [ ] Setup shortcut ngay từ màn Guide xong: badge của mục shortcut đổi sang Done.
- [ ] Các mục khác (automation, design, note…) **không** có badge.
- [ ] Badge hiển thị đúng ngôn ngữ (vi: "Xong" / "Cần làm") và không đẩy tiêu đề dài bị cắt quá mức.

## 11. Kiểm tra hồi quy

- [ ] Widget ngoài Home Screen vẫn cập nhật sau khi mở app, sau khi lịch Google/Outlook đồng bộ, và sau khi lịch được chia sẻ đồng bộ (widget có thể cập nhật chậm khoảng 1 giây).
- [ ] Mở app nhiều lần liên tiếp: không bị giật; Home và thumbnail trong collection hiển thị bình thường.
- [ ] Đăng nhập tài khoản ở Settings → Account vẫn hoạt động (tài khoản giờ chỉ được khởi tạo khi cần).
- [ ] Đang là Pro, tắt app rồi mở lại: vẫn là Pro, không bị hiện paywall lúc mở app.
- [ ] Render wallpaper với nhiều sự kiện (#316): set wallpaper tuần hoặc tháng có nhiều sự kiện, không bị treo.
