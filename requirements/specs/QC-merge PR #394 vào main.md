# QC — merge PR #394 vào main

Oct 5, 2026 · @Duke

## Phạm vi

Ưu tiên số 1 là lỗi ảnh nền tự đổi về mặc định (mục P0): đây là lỗi mất dữ liệu user đang báo. Phần còn lại là UI mới và một sửa lỗi tab bar.

- **Code:** [PR #394](https://github.com/sfunvn/lockscreen-calendar/pull/394) merge vào `main`, merge commit `c426ddbb`.
- **Build để test:** bản TestFlight kế tiếp cắt từ `c426ddbb` trở đi (sau `v1.2.19-rc6`). Bản rc6 trở về trước CHƯA có các thay đổi dưới đây.
- **Thiết bị:** ít nhất 1 iPhone thật chạy iOS 26 (tab bar và hiệu ứng glass mới) và 1 iPhone iOS 17 hoặc 18 (bóng đổ chỉ vẽ dưới iOS 26). Mục P0 bắt buộc test trên máy thật, simulator không tái hiện được.
- **Ngôn ngữ:** chạy tối thiểu Tiếng Việt, English và Arabic (RTL) cho các màn có chữ mới.

| Mục | Thay đổi | Ưu tiên |
| --- | --- | --- |
| Ảnh nền tự đổi về mặc định | Sửa lỗi xóa nhầm ảnh nền của user | P0 |
| Onboarding | Minh hoạ chuyển động, tường mockup, preview rail | P1 |
| Nút glass | Nút Delete/Edit, empty state, nút Update | P1 |
| Tab Tasks | Picker wallpaper matrix dạng lưới | P1 |
| Chia sẻ template | Ảnh thumbnail trên thẻ QR | P2 |
| Màn Calendar | Tiêu đề tháng năm; hồi quy secondary calendar | P2 |
| Tab bar iOS 26 | Đếm đúng nút tab cho tour hướng dẫn | P2 |

## P0 — Ảnh nền tự đổi về mặc định

Ảnh user tự chọn phải còn nguyên sau nhiều lần mở lại app, kể cả khi ảnh đã cũ hơn 24 giờ. Trước bản sửa, app tự xóa mọi ảnh cũ hơn 24 giờ ở lần mở lạnh kế tiếp, và hình nền quay về ảnh mặc định nền xanh có cái cây.

Mục này chỉ test được trên iPhone thật. Để khỏi chờ 24 giờ, tắt giờ tự động và chỉnh ngày máy lên trước (Settings › General › Date & Time).

**Các bước**

1. Cài bản mới. Mở một wallpaper lịch, chọn ảnh nền từ thư viện ảnh của máy, lưu và Update lên màn khóa.
2. Tắt giờ tự động, chỉnh ngày máy lùi về sau 2 ngày.
3. Vuốt tắt hẳn app (kill), mở lại. Lặp lại kill + mở 2 lần nữa.
4. Mở lại wallpaper đó và bấm Update màn khóa.
5. Trả giờ máy về tự động sau khi test xong.

**Kiểm tra**

- [ ] Ảnh nền user chọn vẫn hiện trong editor và trên màn khóa sau bước 4, không phải ảnh nền xanh có cây
- [ ] Bộ nhiều ảnh xoay theo ngày (chọn 3 ảnh, bật đổi hằng ngày): cả 3 ảnh còn, kể cả ảnh chưa tới lượt
- [ ] Ảnh đã crop lại khung: còn đúng khung đã crop
- [ ] Ảnh dán làm sticker trong lớp trang trí (Decorate): còn
- [ ] Ảnh nền Home Screen và ảnh nền của một note: còn
- [ ] Wallpaper đã lưu trong bộ sưu tập (saved) có ảnh riêng: mở lại vẫn đúng ảnh
- [ ] Ảnh đã bỏ chọn (không còn wallpaper nào dùng) được dọn đi, app không phình dung lượng mãi

**Lưu ý khi báo kết quả:** ảnh đã bị xóa bởi bản cũ không khôi phục được. Nếu máy test từng dùng bản cũ và đã mất ảnh, hãy chọn lại ảnh trước bước 1, đừng ghi nhận là lỗi của bản mới.

Có Mac cắm máy thì kiểm tra thêm: Console.app, lọc subsystem `com.silverai.ink`, category `AssetSweep`. Sau khi mở lại app, dòng `deleted 0 photo` (hoặc chỉ đếm ảnh đã bỏ chọn) là đúng.

## Onboarding

Onboarding có minh hoạ chuyển động ở cả 4 bước và một dải preview template tự trôi. Cần cài mới (xóa app) để thấy lại từ đầu.

- [ ] **Splash:** logo nhỏ hơn, có tên sản phẩm; tiêu đề đậm vừa (bold), không quá dày
- [ ] **Bước 1–2:** minh hoạ chuyển động lặp lại (điểm ping chạy theo đường nét đứt, thông báo nảy, thẻ trôi); con số thống kê đếm tăng dần, gạch chân hiện đúng ở cả Light và Dark mode
- [ ] **Bước 3:** tường mockup màn khóa nghiêng, các cột trôi ngược chiều nhau, tràn dưới thanh trạng thái và mờ dần vào phần chữ; chữ vẫn đọc rõ
- [ ] **Bước 4:** hiệu ứng sắp xếp nhanh hơn, icon lợi ích có màu, các thẻ nằm cách nút CTA một khoảng, không bị nút che
- [ ] **Preview:** 3 template năng suất thay cho 2 slide đầu; dải tự trôi, vuốt tay thì dải đi theo, thả tay thì trôi tiếp
- [ ] **Chuyển trang:** vuốt qua lại giữa các bước mượt, nội dung không bị cắt xấu ở cạnh trên (chạy dưới thanh trạng thái)
- [ ] **Hiệu năng:** trên máy cũ nhất có sẵn, chuyển động không giật, máy không nóng bất thường
- [ ] **Reduce Motion bật** (Settings › Accessibility › Motion): onboarding vẫn đi hết được, không kẹt
- [ ] **Arabic (RTL):** bố cục và chiều trôi không vỡ, chữ không bị cắt

## Nút glass

Nút Delete/Edit ở đáy màn chi tiết, nút của empty state và nút Update đổi sang kiểu glass. Kiểm tra cả Light và Dark mode, trên iOS 26 và iOS 17/18.

- [ ] **Màn chi tiết Event, Task, Template:** hai nút tròn Delete và Edit ở đáy là glass, bấm đúng chức năng, Delete vẫn hỏi xác nhận
- [ ] **Empty state** (nút hành động khi màn trống): Calendar chưa có sự kiện, Tasks trống, Notes trống, Assistant và Help chat, bộ sưu tập Discover trống, lịch chia sẻ, import lịch chia sẻ, template được chia sẻ. Nút hiện đúng chữ đã dịch, bấm được
- [ ] **Nút Update lên màn khóa:** nền sáng, đọc rõ trên mọi wallpaper
- [ ] **Bóng đổ:** nút Update và nút + nổi có bóng trên iOS 17/18, không có bóng trên iOS 26
- [ ] **Nút trắng trên lớp coach (tour hướng dẫn):** vẫn trắng, chữ tối, không bị xám đi khi ở Dark mode
- [ ] **Nút glass tối trên ảnh:** nhạt hơn trước, vẫn nhìn xuyên thấy ảnh phía sau, chữ trên nút vẫn đọc được
- [ ] **Arabic (RTL):** vị trí Delete/Edit không bị đảo sai

## Tab Tasks — picker wallpaper matrix

Bấm “Put your matrix on the lock screen” ở tab Tasks giờ mở lưới 3 cột các ô wallpaper màn khóa, thay cho popup danh sách.

- [ ] Lưới hiện 3 cột, ảnh ô đúng tỉ lệ màn khóa, cuộn mượt
- [ ] Ô template Pro có tag Pro; user chưa Pro bấm vào thì ra paywall, user Pro thì dùng được
- [ ] Chọn một ô thì áp dụng đúng wallpaper matrix đó, task hiện đúng ô góc phần tư
- [ ] Đóng picker không chọn gì thì không đổi gì
- [ ] Màn nhỏ (iPhone SE hoặc mini) và Dynamic Type lớn: không vỡ lưới

## Chia sẻ template — thumbnail trên thẻ QR

Thẻ QR khi chia sẻ template giờ có ảnh thumbnail của wallpaper.

- [ ] Giữ lâu một wallpaper đã lưu › Share: thẻ QR hiện đúng thumbnail của wallpaper đó
- [ ] Quét QR bằng máy khác: mở đúng template được chia sẻ
- [ ] Lưu hoặc gửi ảnh thẻ QR: ảnh xuất ra có thumbnail, không bị cắt
- [ ] Thẻ QR của lịch chia sẻ (Calendar › Share) vẫn hiện bình thường, không lẫn thumbnail wallpaper

## Màn Calendar

Tiêu đề trên cùng bỏ dấu phẩy: “Oct, 2026” thành “Oct 2026”, tên tháng giữ màu đậm, năm màu nhạt.

- [ ] Chế độ Day và Week: tên tháng đậm, năm nhạt (cùng màu mũi tên ▾), không có dấu phẩy
- [ ] Chế độ Month: tiêu đề chỉ có năm, màu đậm
- [ ] Mở bộ chọn tháng (bấm tiêu đề) rồi lướt sang tháng khác: tiêu đề đổi theo tháng đang xem
- [ ] Tiếng Việt, English, Arabic (RTL): tiêu đề không bị cắt, thứ tự tháng/năm đúng
- [ ] VoiceOver đọc “Oct 2026”, không có dấu phẩy

### Hồi quy: secondary calendar

Tính năng này đã có từ `v1.2.19-rc5`/`rc6`, không thay đổi trong lần merge này. Test lại vì tiêu đề Calendar vừa đổi ngay phía trên dòng lịch phụ.

- [ ] Settings › Secondary calendar mở picker; chọn lần lượt âm lịch Việt, Trung, Hàn, Hijri, Hebrew, Persian, Indian
- [ ] Tab Calendar: ngày âm hiện dưới mỗi ngày dương ở dải tuần và view tháng; âm lịch Việt, Trung, Hàn hiện dạng “22/8”
- [ ] View tháng: dòng lịch phụ có tiêu đề và tên lịch đang chọn, công tắc bên phải bật tắt được
- [ ] Bộ chọn tháng và tab Home đọc đúng lịch phụ đã chọn
- [ ] Wallpaper Daily page hiện ngày theo lịch phụ đã chọn
- [ ] Wallpaper tháng âm lịch giữ màu ngày của template
- [ ] Chưa chọn gì: dùng lịch mặc định theo vùng của máy

## Tab bar iOS 26 và tour tab

Trên iOS 26, tour hướng dẫn phải khoanh đúng nút tab được nhắc tới. Tab bar mới của iOS 26 vẽ mỗi nút hai lớp, trước đây app đếm sai số nút.

- [ ] iOS 26: tour chỉ vào tab nào thì vòng sáng nằm đúng trên tab đó, lần lượt cả 5 tab
- [ ] iOS 17/18: tour vẫn đúng như trước
- [ ] Arabic (RTL): tab bị đảo thứ tự, vòng sáng vẫn đúng tab
- [ ] Xoay ngang (nếu app cho phép) và iPad: vòng sáng không lệch

## Hồi quy chung và báo lỗi

Chạy nhanh các luồng chính một lượt để chắc lần merge không làm hỏng gì ngoài phạm vi.

- [ ] Tạo, sửa, xóa một event và một task
- [ ] Tạo wallpaper từ Discover, lưu, Update lên màn khóa bằng shortcut
- [ ] Paywall mở được từ tag Pro; user Pro không bị hiện paywall lại
- [ ] Chia sẻ lịch và tham gia lịch chia sẻ vẫn đồng bộ
- [ ] App mở lạnh nhanh như bản trước, không crash khi kill và mở lại nhiều lần

**Báo lỗi:** ghi máy, phiên bản iOS, số build, ngôn ngữ, Light/Dark, các bước tái hiện, kèm ảnh hoặc video. Lỗi P0 báo ngay, không chờ hết vòng test. Comment thẳng vào dòng checklist tương ứng trong doc này cũng được.
