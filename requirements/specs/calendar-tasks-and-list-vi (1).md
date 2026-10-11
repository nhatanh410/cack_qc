# QC — Task trong tab Calendar và chế độ List

Task từ tab Tasks hiện trong tab Calendar; chế độ List cuộn liên tục với banner đầu tháng; giao diện
week strip, header, card; menu chọn lịch khi tạo event.

## Chuẩn bị

- Bản **dev** từ Firebase App Distribution. Test trên 1 máy **iOS 27** và 1 máy **iOS 26**, cả **light** lẫn **dark mode**.
- Tab **Tasks** có sẵn:
  - 1 task **không giờ** và 1 task **có giờ** hôm nay;
  - 1 task **lặp lại hằng ngày**, và 1 task lặp có **ngày kết thúc** trong tuần này;
  - 1 task **đã hoàn thành**;
  - tên dài 2 dòng cho ít nhất 1 task.
- Lịch:
  - ít nhất 1 **lịch Ink** (Calendars sheet → nút **+**) và 1 lịch **iCloud**;
  - nếu được, kết nối thêm **Google** hoặc **Outlook**, và join 1 **lịch được chia sẻ**;
  - có sự kiện trải trên **vài tháng**, và có 1 tuần **vắt qua hai tháng**.
- Bật hiện **âm lịch** để kiểm phần 3, rồi tắt để kiểm lại.

---

## 1. Task trong tab Calendar

**Bật / tắt** — header tab Calendar → nút **lịch** (cuối cụm nút) → sheet Calendars → mục **TASKS** → hàng **Show tasks**.

- [ ] Máy mới cài và máy update từ bản trước: **Show tasks** đang **bật**.
- [ ] Bấm bất kỳ đâu trên hàng (chữ, ô vuông, khoảng trống) đều bật/tắt được.
- [ ] Tắt → task biến mất ở Day, Week, Month, List và ở chấm dưới ngày. Bật lại → hiện lại. Tắt hẳn app mở lại vẫn giữ lựa chọn.

**Vị trí:**

- [ ] **Day / Week**:
  - task **không giờ** nằm ở dải cả ngày trên cùng, là chip có **vòng tròn màu** ở đầu;
  - task **có giờ** nằm đúng giờ trên lưới, cao bằng ô **30 phút**.
- [ ] **Month**: task là chip có vòng tròn nhỏ ở đầu; sự kiện là chip có thanh màu.
- [ ] Chấm dưới ngày ở week strip: tính cả task chưa xong; task **đã xong** không có chấm. Tối đa 4 chấm.
- [ ] Màu task trùng màu task đó ở tab Tasks.

**Trong List** (phần 2):

- [ ] Task là card có **ô tick tròn**; ô tick thẳng hàng với **dòng đầu** của tên, kể cả tên dài 2 dòng.
- [ ] Dòng dưới tên: giờ (nếu có), icon lặp (nếu lặp), tên list.
- [ ] Bấm ô tick ở **ngày hiện tại** của task: tên gạch ngang, card mờ đi; sang tab Tasks thấy task cũng đã tick. Bỏ tick → cả hai bên trở lại.

**Task lặp:**

- [ ] Chỉ lần **hiện tại** tick được. Các lần sau: ô tick mờ, bấm không có tác dụng.
- [ ] Bấm task ở ngày hiện tại (list, timeline hoặc Month) → sheet chi tiết task, có nút **Edit**.
- [ ] Bấm một **lần lặp sau** → màn **Task** chỉ đọc, có:
  - tên task, dòng *An upcoming repeat. Changes are made on the task's current date.*;
  - ngày, giờ, nhãn lặp (*Repeats daily*, *Repeats every 2 weeks*…);
  - nút **Go to current task**.
- [ ] Bấm **Go to current task** → về đúng ngày hiện tại của task và mở sheet chi tiết.
- [ ] Task lặp có ngày kết thúc: **không** hiện sau ngày đó.
- [ ] Đổi ngôn ngữ (vd. Tiếng Việt): nhãn lặp, *Show tasks*, *Go to current task* đã dịch.
- [ ] Task thuộc list **chỉ đọc** (list được chia sẻ, list đăng ký): không tick được, bấm không mở gì.

## 2. Chế độ List

Header → nút **chế độ hiển thị** (giữa cụm nút) → **List**.

**Cuộn và chọn ngày:**

- [ ] **Một** danh sách cuộn liên tục theo tuần. Mỗi tuần có nhãn kiểu **5 – 11 OCT** và một đường kẻ mảnh.
- [ ] Ngày không có gì bị **ẩn**, trừ **hôm nay** và **ngày đang chọn** (hiện *No events*).
- [ ] Cuộn lên và xuống xa vài tháng: tự tải thêm, không giật, không nhảy về chỗ cũ.
- [ ] Đang cuộn: week strip trên đổi theo tuần đang xem.
- [ ] Chọn một ngày trên week strip → list nhảy tới ngày đó. Nút **hôm nay** (số đỏ) → về hôm nay.

**Cột ngày bên trái:**

- [ ] Gồm thứ và số ngày.
- [ ] Hôm nay: **vòng đỏ, số trắng**. Ngày đang chọn: **vòng xám**.
- [ ] Mép trên cột ngày **thẳng hàng** với mép trên card đầu tiên của ngày.

**Card sự kiện:**

- [ ] Thanh màu bên trái cách đều mép trái, trên, dưới.
- [ ] Giờ **không còn** icon đồng hồ phía trước.
- [ ] Icon sự kiện (nếu có) nằm **sát** tên.
- [ ] Bên phải tên là icon nguồn: táo (iCloud), G (Google), Outlook. Sự kiện của **lịch Ink**: logo Ink **màu xám**. Lịch được chia sẻ: không có icon.

**Banner đầu tháng:**

- [ ] Đầu mỗi tháng có banner **tràn hết chiều ngang**, không bo góc:
  - nền màu riêng của tháng;
  - tên tháng bên trái, hình minh hoạ bên phải;
  - 12 tháng là 12 hình khác nhau, màu tươi.
- [ ] Tháng của **năm khác** (vd. Jan 2027): banner ghi kèm năm. Tháng của năm nay chỉ ghi tên tháng.
- [ ] Tháng **không có** sự kiện/task nào vẫn có banner; hai banner liền nhau thì sát nhau, không hở.
- [ ] Tuần vắt qua 2 tháng bị **cắt ở ngày 1**: *28 – 30 SEP* nằm dưới banner tháng 9, *1 – 4 OCT* dưới banner tháng 10.
- [ ] Dark mode: nền banner tối, hình vẫn rõ.
- [ ] (Nếu kịp) iOS Settings → General → Language & Region → **Calendar = Hebrew**: list vẫn mở bình thường, không crash.

## 3. Week strip và header

Ở chế độ Day, Week, List.

**Week strip:**

- [ ] Ngày đang chọn:
  - nền **tím mờ đậm dần xuống đáy**, có **thanh tím** mảnh chạy ngang dưới đáy;
  - 2 góc trên bo, 2 góc dưới vuông;
  - thứ, số ngày, số âm lịch đều **màu tím**.
- [ ] Chỉ số ngày **đang chọn** in đậm; các ngày khác chữ thường.
- [ ] Hôm nay khi **không** được chọn: số màu đỏ.
- [ ] Bật âm lịch: số âm nằm sát số dương, dưới cùng là chấm.
- [ ] Tắt âm lịch: strip thấp lại, không cắt mất chấm.
- [ ] Vuốt strip trái/phải → đổi tuần, vẫn giữ đúng thứ đang chọn.

**Header:**

- [ ] Tiêu đề kiểu **Oct 2026**: số năm **nhạt hơn** tên tháng.
- [ ] Hàng thứ nằm gần header hơn bản trước.
- [ ] Cụm nút bên phải **to hơn** bản trước, cả khung nút lẫn icon. Kiểm cả khi nút **hôm nay** hiện và ẩn.

## 4. Cụm nút ở màn khác

Cụm nút dùng chung được làm to hơn, nên kiểm các màn khác có dùng nó:

- [ ] **Assistant**: cụm nút ngôn ngữ / xoá chat to hơn; avatar bên trái cao bằng cụm nút; header không lệch, không đè chữ.
- [ ] **Editor wallpaper**: nút **undo / redo** trên cùng giữ kích cỡ cũ; icon cân với nút ✕ và ✓ hai bên.
- [ ] Editor, chạm một component hoặc sticker: menu nổi (sửa / xoá…) to hơn một chút, không tràn khỏi mép màn hình.

## 5. Tạo event — chọn lịch

Tab Calendar → **+**.

**Ô Calendar trên form:**

- [ ] Có **icon nguồn** trước tên lịch, thay cho chấm màu:
  - logo Ink (màu) cho lịch Ink;
  - táo cho iCloud; G cho Google;
  - icon lịch cho lịch không rõ nguồn.

**Menu chọn lịch** (bấm vào ô):

- [ ] Menu chia **nhóm có tiêu đề**, theo thứ tự:
  1. **Ink**;
  2. **iCloud**;
  3. các tài khoản khác (vd. Gmail, On My iPhone);
  4. **Shared** (các lịch được chia sẻ) ở cuối.
- [ ] Mỗi dòng có icon nguồn; dấu tích ở lịch đang chọn.
- [ ] Lịch **chỉ đọc** không có trong menu.

**Lịch được chọn sẵn:**

- [ ] Có lịch Ink, chưa tạo event nào từ khi cài bản này: chọn sẵn **lịch Ink**.
- [ ] Không có lịch Ink: chọn sẵn lịch mặc định của iOS (Settings → Calendar → Default Calendar).
- [ ] Chọn lịch khác (vd. Work của iCloud), **lưu** event → mở form tạo mới lần sau: chọn sẵn **Work**.
- [ ] Đổi lịch rồi **huỷ** form (không lưu) → lần sau **không** nhớ lựa chọn đó.
- [ ] Xoá lịch đang được nhớ → lần sau quay về lịch Ink.
- [ ] **Ink AI** mở form tạo event (câu nhờ tạo event mà Ink AI không tự xếp được giờ): form chọn lịch theo cùng quy tắc, lưu xong cũng được nhớ.
- [ ] Mở form từ **bên trong một lịch** (màn chi tiết lịch Ink → Add event):
  - lịch cố định, không có menu;
  - tạo xong, lần sau **không** đổi lịch được nhớ.
- [ ] **Sửa** một event có sẵn: vẫn giữ đúng lịch của event đó.

## 6. Không ảnh hưởng chỗ khác

- [ ] Update từ bản trước lên: lịch, sự kiện, task không mất; **Show tasks** bật sẵn.
- [ ] Day view và Week view: sự kiện vẫn đúng giờ, đúng màu như bản trước.
- [ ] Tab Tasks: tick, sửa, xoá task vẫn như cũ.
