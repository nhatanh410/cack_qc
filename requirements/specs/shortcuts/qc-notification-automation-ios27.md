# Bàn giao QC — automation chạy theo THÔNG BÁO (iOS 27), đợt 2

**Đã vào `main`** (PR #302) · bản **Ink Dev** dựng từ `main` ·
máy **iOS 27** (iOS 26 không có loại automation này).

> Đợt 1 đã trả lời: trigger **chạy được**, và bộ lọc là **"contains"** (Title có thêm chữ
> vẫn khớp). Đợt này trả lời **câu hỏi còn lại ở mục 6**: thông báo **passive** (không
> kêu, không banner, không sáng màn) có còn kích hoạt được không, và xoá nó đi sau khi chạy
> có ổn không.

## 1. Đang thử điều gì, và vì sao

Shortcut **V2** mang sẵn trigger "khi Ink gửi thông báo". Ink sẽ gửi thông báo đúng lúc cần
làm mới wallpaper. Điều cần biết là thông báo đó có thể **kín đáo** tới đâu:

- **Passive** (`interruptionLevel = .passive`): không âm thanh, không rung, không banner, không
  sáng màn — chỉ lặng lẽ vào Notification Center. Nếu trigger vẫn thấy nó, người dùng gần như
  không bị làm phiền.
- **Xoá sau khi chạy**: action cuối của shortcut (Confirm) xoá thông báo khỏi Notification
  Center ngay khi wallpaper đã đặt xong, nên nó chỉ tồn tại vài giây.

## 2. Chuẩn bị

| Thứ | Ghi chú |
|---|---|
| iPhone **iOS 27** | Bắt buộc |
| Bản **Ink Dev** từ nhánh trên | Cài bằng Xcode hoặc App Distribution |
| Quyền thông báo cho Ink | iOS Settings → Ink → Notifications → **Allow** |
| Shortcut | **Ink Refresh Lock Screen V2** bản Dev: `https://www.icloud.com/shortcuts/007226dffb9240439830f196201a5ed6` (hoặc Add shortcut trong app) |

Shortcut có **5 trigger**, cài về đều **tắt**. Tab Automation xếp theo thứ tự của iOS, không
theo file:

```
At sunrise, daily
When Calendar is closed
When Google Calendar is closed
When Ink Dev is closed
When I get a notification from Ink Dev   Title contains "·" AND Message contains "Ink"
```

Trên simulator, **chạm** vào công tắc sẽ mở shortcut; **kéo ngang** công tắc mới bật được.

**Cài:**

1. Xoá mọi shortcut `Ink Refresh Lock Screen V2` cũ, rồi cài từ link.
2. Mở shortcut → **ⓘ → Privacy → bật "Allow Running When Locked"**.
3. Tab **Automation** → bật **chỉ** trigger thông báo (tắt 4 cái kia để kết quả không lẫn).
4. Chạy tay shortcut một lần, chọn **Always Allow** ở hộp thoại quyền đặt wallpaper.

## 3. Chỗ gửi thông báo trong app

**Ink (bản Dev) → Settings → mục "Debug" cuối trang → "Test notification automation"** → sheet.
Chỉ có trên iOS 27 và bản Dev.

| Ô | Mặc định | Để làm gì |
|---|---|---|
| **Title** | `Wednesday · 3 events` | Phải có `·` |
| **Subtitle** | trống | Không bị lọc |
| **Body** | `First at 9:00. Ink refreshed your lock screen.` | Phải có `Ink` |
| Dòng nhắc dưới Body | | Báo nội dung đang gõ **có khớp** shortcut V2 không (đỏ = không khớp) |
| **Passive** | **bật** | Không kêu, không banner, không sáng màn |
| **Remove after the run** | tắt | Shortcut chạy xong thì xoá thông báo khỏi Notification Center |
| **Delay** | `15s` | `3s` khi đang mở app · `15s` đủ để khoá máy · `60s` để máy nằm yên |

Gửi xong thì sheet tự đóng và Settings hiện *"Notification in 15s"*. Thông báo luôn gửi
**sau độ trễ**: phát trong lúc Ink đang mở thì nó được giao cho app chứ không vào danh sách
của hệ thống, mà trigger theo dõi danh sách của hệ thống.

## 4. Kịch bản test

Sau **mỗi** lần gửi, ghi: **thông báo có hiện/kêu/sáng màn không**, **wallpaper có đổi
không**, **có bị hỏi xác nhận không**, **thông báo còn trong Notification Center không**. Đổi
template trong app trước khi gửi để chắc ảnh là mới.

### 4.1 Passive

- [ ] **Passive + máy khoá**: mặc định, Delay 15s, bấm Send rồi **khoá máy ngay**.
      Kịch bản quan trọng nhất.
- [ ] **Passive + máy khoá lâu**: Delay **60s**, khoá máy, để yên.
- [ ] **Passive + máy mở, ở ngoài Ink**: Delay 15s, về màn hình chính.
- [ ] **So sánh**: tắt Passive, gửi lại như 4.1 đầu tiên — để biết khác biệt là do passive.

### 4.2 Xoá sau khi chạy

- [ ] Bật **Remove after the run** (Passive bật), Delay 15s, khoá máy. Chờ wallpaper đổi rồi
      mở Notification Center → thông báo **không còn** mới đúng.
- [ ] Bật Remove nhưng tắt **"Allow Running When Locked"** (để lần chạy hỏng) → thông báo
      phải **còn lại** (chỉ xoá khi chạy tới cuối).

### 4.3 Bộ lọc

- [ ] Title **không có** `·` (ví dụ `Wednesday`) → **không** được chạy.
- [ ] Body **không có** `Ink` → **không** được chạy.
- [ ] Body có `ink` viết thường thay vì `Ink` → chạy hay không? (hoa thường)

### 4.4 Khi người dùng đổi cài đặt thông báo

- [ ] **Tắt hẳn** thông báo của Ink → gửi lại → có chạy không?
- [ ] Tắt **"Show on Lock Screen"**, giữ Notification Center → gửi khi máy khoá → có chạy?
- [ ] Bật **Scheduled Summary** cho Ink → gửi lại → chạy ngay, hay đợi tới giờ tóm tắt?
- [ ] Bật một **Focus** chặn Ink → gửi lại → có chạy?

### 4.5 Thông báo thật (không qua mục Debug)

Bật từ **bước automation của luồng setup**, hoặc **Guide → "Set the daily automation"** /
**"Refresh the moment your schedule changes"** → **Open Automations**: các nút này xin quyền
thông báo (lần đầu), rồi mở tab Automation. Chỉ từ lúc đó Ink mới tự gửi. Trang
**How updates work** cũng dẫn tới đúng mục Guide này (nút **How to set it up** trong mục
"Refresh it right after every change").

- [ ] Chưa bấm các nút trên (ví dụ máy đã setup từ bản cũ) → Ink **không** gửi gì, kể cả khi
      đã cho phép thông báo.
- [ ] Đã **từ chối** quyền thông báo trước đó → bấm nút trong Guide → app mở trang **Settings của
      Ink** (iOS không hỏi lần hai). Bật Notifications ở đó → lần rời Ink sau, Ink bắt đầu gửi mà
      **không** cần bấm lại nút.
- [ ] **Sửa trong Ink**: thêm/sửa/xoá một sự kiện hôm nay → về màn hình chính → sau khoảng 2 giây
      có thông báo kiểu `Schedule updated · 4 events` / `Next up at 15:00. Ink refreshed your
      lock screen.` → wallpaper đổi → thông báo **tự biến mất** khỏi Notification Center.
- [ ] Mở rồi đóng Ink mà **không sửa gì** → **không** có thông báo.
- [ ] **Sửa ở app Calendar**, rồi mở và đóng Ink → có thông báo như trên.
- [ ] **Buổi sáng**: đổi giờ máy sang 04:59 ngày mai (hoặc đợi) → 05:00 có
      `Thursday · 2 events` / `First at 9:00. Ink refreshed your lock screen.` → wallpaper đổi;
      thông báo này **ở lại** trong Notification Center.
- [ ] Đổi ngôn ngữ máy (ví dụ Tiếng Việt) → nội dung được dịch, và automation **vẫn chạy**.
- [ ] Đang mở Ink khi thông báo tới → **không** hiện banner, chỉ nằm trong danh sách.

### 4.6 Chạy nền (chỉ máy thật, cần Xcode)

Simulator **không có** trình lập lịch chạy nền — yêu cầu gửi đi không được giữ, nên không test
được ở đó. Trên máy thật, chạy bản Dev từ Xcode:

1. Mở Ink rồi về màn hình chính (để app gửi yêu cầu chạy nền).
2. Thêm một sự kiện hôm nay bằng app **Calendar** (không mở Ink).
3. Trong Xcode: **Pause** app, gõ vào console:
   `e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.silverai.calendar.lockscreen.calendar-store-refresh"]`
   (cùng một mã cho cả Dev và Prod), rồi **Continue**.
4. Mong đợi: thông báo thay đổi tới → shortcut chạy → thông báo tự xoá.

Đừng để app dừng trong debugger quá lâu khi nó đang ở nền: iOS sẽ kill vì quá 30 giây
(`0x8BADF00D`) — đó là do debugger, không phải bug.

## 5. Ảnh hưởng tới phần còn lại của app

- [ ] Sau mỗi lần automation chạy, mở Ink: **không** hiện cảnh báo kiểu "automation không chạy".
- [ ] Wallpaper đúng template và đúng chế độ Home Screen đang đặt.
- [ ] Nút **Update** trong app vẫn chạy bình thường.

## 6. Bảng trả lời

Đã chạy trên **simulator iOS 27.0** (2026-09-24, bản Prod): thông báo passive khớp keyword →
shortcut tự chạy (~15 giây, không banner); thiếu `·` → không chạy; `ink` viết thường → **không**
chạy (bộ lọc phân biệt hoa thường); sửa sự kiện trong Ink rồi thoát → thông báo thay đổi tới
sau ~8 giây → shortcut chạy → thông báo tự bị xoá; **khoá máy** rồi gửi → vẫn chạy (~20 giây).
Chạy nền (4.6) không test được trên simulator. Máy thật vẫn cần xác nhận toàn bộ, nhất là với
Focus / Scheduled Summary.

| Câu hỏi | Trả lời | Ghi chú |
|---|---|---|
| Thông báo **passive** có kích hoạt trigger khi **máy khoá**? | | |
| Passive có sáng màn / kêu / hiện banner không? | | |
| **Remove after the run** có xoá được thông báo không? | | |
| Bộ lọc có phân biệt **hoa thường**? | | |
| Tắt thông báo / Scheduled Summary / Focus → trigger còn chạy? | | |
| Có bị **hỏi xác nhận** trước khi chạy không? | | |

## 7. Không phải bug (đừng report)

- Mục **Debug** và ô **Test notification automation** chỉ có trên bản Dev chạy iOS 27.
- Chữ trong mục Debug và sheet chỉ có tiếng Anh.
- Cả 5 trigger cài về đều **tắt** — iOS làm vậy với mọi trigger đi kèm shortcut.
- Ink chỉ tự gửi sau khi bấm nút trong mục Guide ở 4.5; ô Debug gửi được bất cứ lúc nào.
- Thay đổi ở app khác chỉ được thấy khi Ink chạy (mở/đóng app, hoặc iOS cho chạy nền) —
  không phải ngay lúc sửa.

## 8. Khi report, ghi kèm

- Title / Body, Passive bật/tắt, Remove bật/tắt, Delay
- Trạng thái máy lúc thông báo tới: khoá, mở ngoài Ink, hay trong Ink
- Ảnh tab **Automation** trong Shortcuts
- Ảnh lock screen trước và sau
