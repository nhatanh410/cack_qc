# QC — Ink 1.2.20

Gồm: tab mặc định khi mở app + tour gợi ý (PR #394), nhắc chọn lại ảnh wallpaper bị mất (#397),
dải preview của onboarding (#398), nút phụ / Default tab / cuộn Discover (#399).

## Chuẩn bị

- Bản **dev** từ Firebase App Distribution. Test trên 1 máy **iOS 27** và 1 máy **iOS 26**, cả **light** lẫn **dark mode**.
- Settings của bản dev có mục **Debug → Default-tab tour**:
  - 3 dòng trạng thái: lựa chọn hiện tại, số lần bấm từng tab, các tab đã bấm "Not now";
  - hàng chip chọn tab + nút **Show tour**: đóng Settings, chuyển sang tab đó và hiện tour ngay, bỏ qua mọi điều kiện;
  - nút **Reset**: về như máy mới cài (xoá lựa chọn, bộ đếm, danh sách "Not now").
- Bấm **Reset** trước mỗi phần 1–3.
- "Mở app" trong tài liệu này là **tắt hẳn app** (vuốt khỏi app switcher) rồi mở lại. Mở lại từ nền thì app giữ tab đang dùng — đúng thiết kế.

---

## 1. Setting "Default tab"

Settings → mục **Appearance** → hàng **Default tab** dưới Language.

- [ ] Máy mới cài: hàng ghi **Discover**; mở app vào Discover.
- [ ] Bấm vào giá trị bên phải → menu hiện: **Most used**, Discover, Calendar, Tasks, Notes, Assistant — mỗi dòng có icon giống tab bar, dấu tích ở lựa chọn hiện tại.
- [ ] Chọn **Calendar** → hàng đổi thành Calendar → mở app → vào thẳng tab Calendar.
- [ ] Lặp lại với Tasks, Notes, Assistant: mở app vào đúng tab đã chọn.
- [ ] Chọn **Assistant**: icon mascot bên phải hàng có cỡ bằng các icon khác, không to bất thường.
- [ ] Chọn **Most used**: giá trị hiện gọn **một dòng** ("Most used"), không kèm câu giải thích.
- [ ] Chọn xong, cuộn danh sách Settings lên xuống: cả hàng nằm yên trong thẻ, **không** trôi lệch theo tay.
- [ ] Đổi ngôn ngữ (iOS Settings → Ink → Language), vd. Tiếng Việt / Deutsch: tên hàng, tên tab và "Most used" đều đã dịch, không bị cắt chữ.

## 2. Most used

Chọn **Most used** ở Settings.

- [ ] Chưa bấm đủ **10 lần** vào các tab trên tab bar: mở app vẫn vào Discover.
- [ ] Bấm tab **Calendar** trên tab bar nhiều lần (xen kẽ tab khác) cho tới khi Calendar có số lần bấm nhiều nhất và tổng ≥ 10 → mở app → vào Calendar.
- [ ] Hai tab bằng số lần bấm: mở app vào tab **nằm bên trái hơn**.
- [ ] Chỉ tính lần **tự bấm trên tab bar**. Mở tab bằng cách khác **không** được đếm: thông báo push, Quick Action (giữ icon app), link, nút "Ask Ink AI" trong Settings. Kiểm bằng dòng *Taps* ở Debug.

## 3. Tour gợi ý tab mặc định

Khi user chưa từng tự chọn tab mặc định và hay dùng một tab khác Discover, app hỏi có muốn mở app ở tab đó không.

**Cách gọi nhanh:** Debug → Default-tab tour → chọn chip → **Show tour**.
**Cách thật:** Reset, rồi bấm một tab (vd. Tasks) trên tab bar 10 lần, xen kẽ tab khác.

- [ ] Tour hiện sau khoảng nửa giây: màn hình tối lại, **vòng sáng ôm đúng nút tab** vừa bấm trên tab bar — kiểm cả tab ngoài cùng trái (Discover/Calendar) và ngoài cùng phải (Assistant), không lệch trái/phải hay lên trên.
- [ ] Chữ: tiêu đề "You use **Tasks** the most", dòng dưới "Open Ink here every time? You can change it in Settings."
- [ ] Hai nút: **Not now** bên trái (xám tối), **Start here** bên phải (**trắng, chữ đen** ở cả light lẫn dark mode).
- [ ] Bấm **Start here** → tour đóng → Settings → Default tab ghi Tasks → mở app vào Tasks.
- [ ] Reset, gọi lại tour, bấm **Not now** → tour đóng → mở app vẫn vào Discover. Bấm Tasks thêm nhiều lần: **không** hỏi lại cho Tasks. Dòng *Declined* ở Debug có Tasks.
- [ ] Sau khi "Not now" cho Tasks, một tab khác (vd. Notes) vượt lên nhiều nhất → vẫn được hỏi cho Notes.
- [ ] Chạm vùng tối bên ngoài vòng sáng = **Not now**.
- [ ] Mỗi lần mở app hỏi **tối đa một lần**, dù trả lời thế nào.
- [ ] Đã tự chọn tab trong Settings (kể cả chọn lại Discover) → **không bao giờ** hỏi nữa.
- [ ] Tour **không** hiện khi đang có màn khác che: paywall, Settings, sheet, tour hướng dẫn Discover. Nếu đang chờ hiện mà mở thông báo/link chuyển sang tab khác, tour bị huỷ và lần mở app sau hỏi lại.

## 4. Tab mặc định không ảnh hưởng chỗ khác

- [ ] Máy chưa từng mở Settings, chưa đủ lượt bấm: mọi thứ như bản cũ (mở vào Discover, không có tour).
- [ ] Tour hướng dẫn của Discover (sau onboarding) vẫn chạy bình thường, nút **Next / Got it** trắng chữ đen.
- [ ] Update app từ bản cũ lên: mở vào Discover, không mất dữ liệu gì.

---

## 5. Nhắc chọn lại ảnh wallpaper bị mất (#397)

Các bản 1.2.14 → 1.2.19-rc6 có lỗi xoá nhầm ảnh wallpaper đang dùng. Bản này nhắc người đã bị mất ảnh chọn lại.

**Chuẩn bị:** một wallpaper đang dùng có nền là **ảnh của mình** (không phải ảnh có sẵn trong app), rồi làm mất file ảnh đó — cách tạo trên simulator/máy dev ở runbook `docs/runbooks/in-app-messages.md`, mục *QC on the simulator*.

- [ ] Mở app (không phải lần mở đầu tiên): popup nhắc chọn lại ảnh hiện ra.
- [ ] Bấm **Pick a photo** → mở thẳng màn chỉnh wallpaper hiện tại, tab **Background**.
- [ ] Chưa có wallpaper hiện tại → bấm nút → dừng ở Discover, không lỗi.
- [ ] Chọn ảnh mới, lưu → các lần mở app sau popup **không** hiện lại.
- [ ] Nền là ảnh có sẵn của app bị mất (ảnh catalog) → **không** nhắc; ảnh tự tải lại.
- [ ] Home Screen để chế độ **ảnh riêng** mà ảnh đó đã mất → chạy shortcut → **chỉ Lock Screen đổi**, Home Screen giữ nguyên ảnh iOS đang hiện.
- [ ] Popup một ngày tối đa một lần, không hiện ở lần mở app đầu tiên.
- [ ] Đổi ngôn ngữ: chữ trong popup đã dịch (17 ngôn ngữ).

## 6. Onboarding — dải preview (#398)

- [ ] Cài mới, đi hết onboarding tới bước **preview** (dải các mẫu lock screen tự trôi):
  - lúc tới: card đầu nằm sát lề trái, card thứ 2 hiện trọn, card thứ 3 ló ra;
  - đứng yên khoảng 1,5 giây rồi mới bắt đầu trôi.
- [ ] Đi chậm ở các bước trước (đợi lâu) rồi mới tới preview: vẫn bắt đầu từ card đầu, không bị trôi mất mấy card đầu.
- [ ] Quay lại bước trước rồi tới preview lần nữa: lại bắt đầu từ card đầu.

## 7. Nút phụ, Default tab, cuộn Discover (#399)

**Nút phụ** (Cancel / Not now / More… — nút đi cùng nút chính đen/trắng):

- [ ] **Light mode**: nút phụ là viên **xám nhẹ**, nhìn rõ trên nền trắng của popup/sheet.
- [ ] **Dark mode**: nút phụ là viên **xám tối, chữ sáng**; nút chính màu trắng — hai nút **không** trùng màu. Kiểm ở popup bật Ink AI (**Turn on Ink AI** / **Not now**), popup xác nhận xoá, sheet chia sẻ.
- [ ] Nút phụ nằm **trong card** (vd. **Save as task** ở thẻ sự kiện của Ink AI): viên **trắng phẳng, không bóng**, nhìn rõ trên nền card ở light mode — trên cả iOS 26 và iOS 27.
- [ ] Màn crop ảnh nền (chọn ảnh làm wallpaper → crop): nút **Crop** trắng, chữ đen, rõ trên nền đen.
- [ ] Coach tour (Discover sau onboarding, và tour gợi ý tab ở phần 3): nút **Next / Got it / Start here** trắng chữ đen ở cả hai mode.

**Cuộn Discover:**

- [ ] Trên **máy thật**, cuộn Discover lên xuống nhanh nhiều lần, có hàng **Your collection** đầy mẫu: mượt hơn bản trước, không khựng.
- [ ] Bóng dưới các mẫu trong hàng Your collection và màn lưới **Your collection** vẫn có, nhìn như cũ.
- [ ] Gợi ý "bấm nút khoá" (sau khi set wallpaper) tắt khi **tự tay cuộn** Discover; **không** tự tắt khi tour hướng dẫn tự cuộn màn hình.
