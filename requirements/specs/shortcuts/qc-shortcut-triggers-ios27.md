# QC — Automation có sẵn trong shortcut V2 (iOS 27)

**Đã vào `main`** (PR #302) · bản **Ink Dev** dựng từ `main` · máy **iOS 27**.
iOS 26 không có loại automation này: ở đó người dùng tự tạo automation trong tab Automation.

> Mục tiêu: xác nhận 5 automation đi kèm shortcut **bật được, tự chạy đúng lúc, không hỏi
> xác nhận, và cập nhật đúng màn**. Mục 8 là bảng ghi kết quả. "Không chạy" cũng là một kết
> quả cần ghi lại.

## 1. Shortcut mang theo những automation nào

Shortcut V2 (**`Ink Refresh Lock Screen V2`**) mang sẵn **5 automation**. Tất cả **tắt** khi mới
cài, và không có link nào bật hộ được. Tab Automation xếp theo thứ tự của iOS; Guide xếp theo
thứ tự nên bật:

| Automation trong tab Automation | Khi nào chạy | App có hướng dẫn bật? |
|---|---|---|
| **At sunrise, daily** | Bình minh mỗi ngày, theo vị trí của máy | ✅ Bước automation trong luồng setup, và Guide |
| **When I get a notification from Ink** | Ink gửi thông báo làm mới (Title có `·`, Message có `Ink`) | Guide — test riêng ở [`qc-notification-automation-ios27.md`](qc-notification-automation-ios27.md) |
| **When Ink is closed** | Rời app Ink | Chỉ trong Guide |
| **When Calendar is closed** | Rời app Lịch của Apple | Chỉ trong Guide |
| **When Google Calendar is closed** | Rời app Google Calendar | Chỉ trong Guide |

Link Dev gắn automation "Ink is closed" và "notification from Ink" với **Ink Dev**, link Prod
gắn với **Ink** bản store.

## 2. Link và máy

| Bản app | Link |
|---|---|
| **Ink Dev** | `https://www.icloud.com/shortcuts/007226dffb9240439830f196201a5ed6` ← dùng link này |
| **Ink** (Prod) | `https://www.icloud.com/shortcuts/dd5b40be467c4ed2aecd38316471b2d7` |

- Nút **Add shortcut** trong luồng setup của app mở đúng link của bản đang chạy.
- Máy cài **Ink Dev** thì dùng link Dev. Nếu các action của Ink hiện **màu đỏ** là do cài
  nhầm bản, không phải bug.
- **Không dùng link `43e6966e…`.** Đó là bản ai đó đã sửa trên máy: chỉ còn **1**
  automation, ở giờ cố định 00:05 (xem mục 7).
- Nên có thêm **một máy dùng Apple Account khác** để xem automation có về máy người khác không.

## 3. Chuẩn bị (làm một lần)

1. **Máy sạch:** xoá mọi shortcut Ink cũ trong app Phím tắt. Xoá shortcut thì automation của
   nó bị xoá theo. Mở tab **Automation** và xác nhận không còn dòng nào của Ink.
   > Vì sao phải xoá: cài đè bằng **Replace** (cùng tên) để lại automation của bản cũ thành
   > dòng riêng, và chúng vẫn chạy **bản cũ**. Test trên máy còn bản cũ thì có thể một lúc
   > chạy hai shortcut, và kết quả sẽ lẫn.
2. Mở link (hoặc Add shortcut trong app) → **Add Shortcut**.
3. Mở shortcut → ⓘ / Settings → bật **Allow Running When Locked** nếu có.
4. Mở Ink → chạy setup shortcut (Settings → shortcut, hoặc nút Set) cho tới bước
   **Open Automations**.
5. Trong tab **Automation**, bật **4 dòng** sunrise và đóng app. Dòng **notification from Ink**
   để tắt trong doc này (test riêng), để kết quả không lẫn. Với mỗi dòng, mở ra kiểm tra:
   - **Run Immediately** (chạy ngay) hay **Run After Confirmation** (hỏi trước)?
     Ghi lại mặc định rồi chọn **Run Immediately**.
   - **Notify When Run**: nên bật trong lúc test, để biết automation có chạy không.

## 4. Test từng automation

**Mẹo kiểm tra:** trước mỗi lần chờ automation chạy, **tạo một sự kiện mới trong Lịch** có tên
dễ nhận (ví dụ `QC 07:15 sunrise`) và **đừng mở Ink**. Nếu sau đó sự kiện hiện trên màn khoá
thì automation đã chạy. Chỉ đổi ảnh nền thì chưa chắc, vì nhiều template có nền đổi theo ngày.

### 4.1 At sunrise, daily

- [ ] Lần đầu bật hoặc lần đầu chạy, iOS có **xin quyền vị trí** không?
- [ ] Tối trước: tạo sự kiện `QC sunrise` cho ngày mai → **khoá máy** qua đêm.
- [ ] Sáng hôm sau, **chưa mở khoá**: màn khoá đã có `QC sunrise` và đúng ngày mới chưa?
- [ ] Có bị hỏi xác nhận không? Có hiện thông báo "running your automation" không?
- [ ] Mở Ink: **không** có cảnh báo "automation không chạy" ở Home / Settings.

**Không muốn chờ tới sáng:** tạm đổi automation Sunrise sang **Time of Day, 2–3 phút tới** →
khoá máy → chờ → kiểm tra như trên.
> ⚠️ Test xong **xoá shortcut và cài lại từ link**, đừng chỉ đổi giờ ngược lại. Và
> **không share** bản đã sửa: link share sẽ mang giờ đã sửa đi theo. Link `43e6966e…`
> chính là trường hợp này.

### 4.2 When Calendar is closed

- [ ] Mở **Lịch** → thêm sự kiện `QC calendar` hôm nay → về màn hình chính (vuốt lên).
- [ ] Trong vài giây: automation có chạy không? Khoá máy xem `QC calendar` đã hiện chưa.
- [ ] Chỉ **chuyển sang app khác** (App Switcher), không về màn hình chính, có tính là
      "closed" không?
- [ ] **Vuốt tắt hẳn** Lịch trong App Switcher có tính không?
- [ ] Mở Lịch rồi thoát ngay mà **không sửa gì**: automation vẫn chạy (đúng thiết kế, chỉ ghi
      nhận). Mất bao lâu, có làm máy khựng không?

### 4.3 When Google Calendar is closed

- [ ] Như 4.2 nhưng với app **Google Calendar** (tài khoản Google đã kết nối với Ink).
- [ ] Máy **không cài** Google Calendar: dòng automation này hiện ra sao, có báo lỗi không?

### 4.4 When Ink is closed

- [ ] Trong Ink: đổi template hoặc chế độ Home Screen → rời Ink **mà không bấm Set/Update**
      → màn khoá có cập nhật theo lựa chọn mới không?
- [ ] Rời Ink **ngay sau** khi bấm Update: shortcut có chạy **hai lần liên tiếp** không
      (một lần do Update, một lần do automation)? Có hiện toast lỗi không?
- [ ] Không bị **vòng lặp**: shortcut chạy xong không làm Ink "closed" thêm một lần nữa.

## 5. Kiểm tra chung sau mỗi lần automation chạy

- [ ] **Lock** có **lịch**; **Home** chỉ có **ảnh nền** (với chế độ Home Screen khác Off).
      Nếu **hai màn bị đổi chỗ** (lock chỉ có nền, home có lịch), ghi ngay vào bảng: chế độ
      Home Screen, blur, máy đang khoá hay mở, và **chạy tay có bị không**. Đã có một báo cáo
      như vậy khi chạy lúc 00:05.
- [ ] Màn khoá đang dùng **cặp wallpaper của Ink** (Switch chạy đúng).
- [ ] Settings → **Debug**:
  - **Last shortcut run** có số liệu mới;
  - thẻ **In-app messages** có dòng `Runs Ink Refresh Lock Screen V2 · old still running false`.
    Nếu thấy `true` nghĩa là một automation vẫn đang gọi shortcut cũ.

## 6. Trường hợp biên

- [ ] **Cài lại cùng link** (Replace): tab Automation có bị **trùng dòng** không? Dòng cũ còn
      bật không?
- [ ] **Xoá shortcut**: cả 5 dòng automation có biến mất theo không?
- [ ] **Máy Apple Account khác**: cài link → 5 automation có về máy không, bật hay tắt?
- [ ] **Chế độ nguồn điện thấp** / máy nóng: automation Sunrise có bị bỏ qua không?
- [ ] **Bình minh và mở Lịch cùng lúc**: hai lần chạy chồng nhau có lỗi gì không?

## 7. Đã biết

- Automation luôn cài ở trạng thái **tắt**; không có URL nào bật hộ. App chỉ mở được tab
  Automation (`shortcuts://automations`).
- Trên simulator, **chạm** vào công tắc sẽ mở shortcut; **kéo ngang** công tắc mới bật được.
  Trên máy thật cần xác nhận lại (mục 8).
- Link `43e6966e…` (tạo 23/9 10:47): hành động giống bản V2 nhưng chỉ còn 1 automation giờ
  cố định 00:05, và tên không có "V2". Không dùng để phát hành.

## 8. Bảng ghi kết quả

| Câu hỏi | Kết quả | Ghi chú |
|---|---|---|
| Sau khi cài, 5 automation bật hay tắt? | | |
| Bật được từ danh sách tab Automation (không cần vào Edit)? | | |
| Mặc định Run Immediately hay Run After Confirmation? | | |
| Sunrise có xin quyền vị trí? | | |
| Sunrise chạy khi máy khoá, không hỏi? | | |
| Calendar closed: chuyển app có tính là "closed"? | | |
| Calendar closed: chạy sau bao nhiêu giây? | | |
| Google Calendar closed chạy? Máy không cài GCal thì sao? | | |
| Ink closed: rời app ngay sau Update có chạy 2 lần? | | |
| Có lần nào **Lock / Home bị đổi chỗ**? (mode, blur, khoá/mở) | | |
| Replace cùng link: automation trùng dòng? | | |
| Xoá shortcut: automation biến mất theo? | | |
| Account khác: automation có về máy? | | |
