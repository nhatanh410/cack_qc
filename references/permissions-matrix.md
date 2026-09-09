# Ma trận quyền — Ink: Lockscreen Calendar, Note

> Liệt kê **mọi quyền và uỷ quyền** app cần để hoạt động đúng, kèm: hỏi lúc nào · hỏng gì nếu bị từ chối ·
> cấp lại ở đâu.
>
> **Cách đọc ký hiệu:**
> ✅ **Đã quan sát** trong screenshot — chắc chắn app có xin
> ⚠️ **Suy luận** từ chức năng thấy được — **chưa có bằng chứng**, phải đối chiếu `Info.plist` và máy thật
> ❌ **Không cần** — kèm lý do
>
> Tên `Info.plist` key dưới đây là **key chuẩn của iOS**, cần đối chiếu với project thật, không chép thẳng
> vào tài liệu bàn giao khi chưa kiểm.
>
> **Tham chiếu:** [exploratory-references](exploratory-references.md) · [wireframes](../requirements/ui/ux/wideframes/README.md)

---

## 0 · Bốn tầng uỷ quyền

Ink không chỉ cần "quyền iOS". Có **4 tầng khác nhau**, cấp ở 4 nơi khác nhau, và người dùng phải vượt qua
đủ cả 4:

| Tầng | Cấp ở đâu | Rút lại ở đâu | Ink phát hiện được khi bị rút? |
|------|-----------|---------------|:---:|
| **A** · Quyền hệ thống iOS | Dialog trong app | Settings → Ink | Có (API trả lỗi) |
| **B** · Quyền cho Shortcut | Dialog trong app Shortcuts | Settings → Shortcuts | **Không** |
| **C** · Uỷ quyền Google OAuth | Web/OAuth ngoài app | myaccount.google.com | **?** cần kiểm |
| **D** · Công tắc iOS không phải "quyền" | Settings hệ thống | Settings hệ thống | **Không** |

Tầng B và D là nguồn của kiểu **hỏng im lặng** — xem [shortcut-flow-cases](shortcut-flow-cases.md).

---

## 1 · Tầng A — Quyền hệ thống iOS

### 1.1 ✅ Calendar — quyền **3 trạng thái**, không phải bật/tắt

| | |
|---|---|
| **Key** | `NSCalendarsFullAccessUsageDescription` *(iOS 17+)* · `NSCalendarsUsageDescription` *(iOS ≤16)* |
| **Chuỗi quan sát được** | *"Ink needs calendar access to show and create your events."* |
| **Hỏi lúc nào** | Onboarding slide 5, sau khi bấm CTA — [Flow 02 · S01](../requirements/ui/ux/wideframes/02_permission.md) |
| **Vì sao cần full** | App vừa **đọc** (vẽ wallpaper, widget, live activity, 4 view lịch) vừa **ghi** (tạo/sửa/xoá event, tạo calendar mới) |
| **Cấp lại** | Settings → Ink → Calendars — ✅ app **có** màn hình dẫn ra, xem [S03](../requirements/ui/ux/wideframes/02_permission.md) |

#### 🔴 Ba trạng thái quyền — và cái ở giữa là bẫy

Từ iOS 17, quyền Calendar **không còn nhị phân**. Trong Settings → Ink → Calendars có **3 lựa chọn**:

| Trạng thái | `EKAuthorizationStatus` | App đọc được? | App ghi được? |
|---|---|:---:|:---:|
| **None** | `.denied` | ❌ | ❌ |
| **Add Events Only** | `.writeOnly` | ❌ | ✅ |
| **Full Access** | `.fullAccess` | ✅ | ✅ |

**Điểm mấu chốt:** dialog xin quyền lúc onboarding chỉ có **2 nút** (`Allow Full Access` / `Don't Allow`).
Trạng thái **`Add Events Only` chỉ xuất hiện trong Settings** — tức là chỉ user nào **tự vào Settings** mới
chọn được nó. Mà đó chính xác là nơi màn hình `Open Settings` của Ink đẩy user tới.

**Hậu quả của `Add Events Only` — app ghi được nhưng mù hoàn toàn:**

| Chức năng | Hoạt động? | Vì sao |
|---|:---:|---|
| Wallpaper lock screen | 🔴 trống | Không đọc được event nào để vẽ |
| Widget · Live Activity | 🔴 trống | Như trên |
| 4 view lịch (List/Day/Week/Month) | 🔴 trống | Như trên |
| Template preview ở Discover | 🔴 trống | Như trên |
| Sheet **Calendars** (chọn lịch hiển thị) | 🔴 hỏng | Liệt kê danh sách calendar **cũng cần quyền đọc** |
| **Tạo event mới** | ⚠️ **có thể hỏng** | Form tạo event có dòng `Calendar` để chọn lịch đích — mà không đọc được danh sách calendar thì chọn kiểu gì? |
| Sửa / xoá event có sẵn | ❌ | Phải đọc được mới lấy ra để sửa |

> Nghịch lý: `Add Events Only` cho phép **ghi**, nhưng chức năng ghi của Ink lại **phụ thuộc vào việc đọc**
> (phải chọn calendar đích). Rất có thể app hỏng ở cả hai chiều. **Phải test.**

**Ba khả năng app đang xử lý — phải xác định app rơi vào cái nào:**

| # | Hành vi | Đánh giá |
|---|---|---|
| **a** | Hiện màn `Turn on Calendar access` (coi `.writeOnly` như `.denied`) | 🟡 Chấp nhận được, nhưng **nội dung đang sai** — user đã cấp quyền rồi mà app vẫn bảo "turn on", họ sẽ tưởng app lỗi |
| **b** | Hiện lịch **trống trơn**, không giải thích gì | 🔴 **Tệ nhất.** User tưởng **mất sạch dữ liệu lịch của mình**. Không có đường nào để hiểu hay sửa |
| **c** | Crash / loading vô tận | 🔴 |

**Nội dung cần có nếu rơi vào (a):** phải nói đúng tên lựa chọn — *"Ink cần **Full Access**. Bạn đang để
**Add Events Only** nên Ink không đọc được lịch."* Câu hiện tại (*"tap to allow in Settings"*) **không nêu
tên lựa chọn nào**, nên user hoàn toàn có thể chọn lại đúng cái sai lần nữa.

#### Đây là lần thứ **ba** cùng một mẫu lỗi lặp lại

| # | Nơi xảy ra | Lựa chọn đúng | App có nói tên lựa chọn không |
|---|---|---|:---:|
| 1 | Dialog output wallpaper *(Shortcuts)* | `Always Allow` — không phải `Allow Once` | ❌ |
| 2 | Tạo Personal Automation | `Run Immediately` — không phải `Ask Before Running` | ❌ |
| 3 | **Settings → Calendars** | **`Full Access`** — không phải `Add Events Only` | ❌ |

Cả ba đều là: **lựa chọn 3 nhánh, chỉ một nhánh chạy được, app không gọi tên nhánh đó.** Đây không phải ba
lỗi rời rạc mà là **một lỗ hổng hệ thống trong cách viết hướng dẫn** — nên sửa cùng lúc, cùng một nguyên tắc:
*luôn gọi đúng tên lựa chọn mà user phải bấm.*

#### Về phía App Review

Apple khuyến khích xin **write-only** khi đủ dùng. Ink cần full access thật, nên purpose string phải nêu rõ
cả hai việc — chuỗi hiện tại đã nêu đúng (*"show and create"*). Giữ nguyên.

### 1.2 ✅ Reminders

| | |
|---|---|
| **Key** | `NSRemindersFullAccessUsageDescription` *(iOS 17+)* · `NSRemindersUsageDescription` *(iOS ≤16)* |
| **Chuỗi quan sát được** | *"Ink needs reminders access to show and create your reminders."* |
| **Hỏi lúc nào** | Ngay sau dialog Calendar, cùng một lần bấm CTA — [Flow 02 · S02](../requirements/ui/ux/wideframes/02_permission.md) |
| **Cấp lại** | Settings → Ink → Reminders — ✅ app **có** màn hình dẫn ra, xem [S04](../requirements/ui/ux/wideframes/02_permission.md) |
| **Ghi chú** | Có link `Skip for now` ở màn nền → gợi ý quyền này **tuỳ chọn** |

> ⚠️ **Reminders cũng có 3 trạng thái** như Calendar (`None` / `Add Reminders Only` / `Full Access`) từ
> iOS 17 — cần xác nhận trên máy thật. Nếu đúng thì mọi phân tích ở [§1.1](#-ba-trạng-thái-quyền--và-cái-ở-giữa-là-bẫy)
> áp dụng y hệt: `Add Reminders Only` = ghi được, đọc không được → tab Tasks trống.

#### 🔴 Từ chối Reminders làm chết cả task nguồn `Ink`

Bằng chứng: [S04](../requirements/ui/ux/wideframes/02_permission.md) — khi từ chối Reminders, **toàn bộ tab
Tasks bị thay bằng màn hình xin quyền**, kể cả nút `+`.

Nhưng tab Tasks vốn có **2 nguồn dữ liệu**, thấy rõ qua segmented control `All | Reminder | Ink`:

| Nguồn | Cần quyền Reminders? |
|---|:---:|
| `Reminder` — đồng bộ từ Apple Reminders | ✅ Có |
| `Ink` — task tạo và lưu **trong app** | ❌ **Không** |

→ User từ chối một quyền **được app coi là tuỳ chọn** (có `Skip for now`) nhưng **mất luôn tính năng không
hề phụ thuộc quyền đó**. Không tạo được task Ink, không xem được task Ink đã có.

**Đúng ra nên là:** tab Tasks vẫn hoạt động với nguồn `Ink`, filter `Reminder` hiện empty state riêng kèm nút
`Open Settings`. Chặn cả tab là **degrade quá tay**.

**Cần xác nhận:** task nguồn `Ink` lưu ở đâu? Nếu thật sự lưu local (Core Data / SwiftData) thì đây chắc chắn
là bug. Nếu `Ink` cũng chỉ là một list bên trong Apple Reminders thì hành vi hiện tại đúng — nhưng khi đó
tên gọi `Ink` đang **gây hiểu nhầm** là task nội bộ.

### 1.3 ⚠️ Photos — nhiều khả năng cần, chưa thấy dialog

| | |
|---|---|
| **Key** | `NSPhotoLibraryAddUsageDescription` (chỉ ghi) và/hoặc `NSPhotoLibraryUsageDescription` (đọc) |
| **Vì sao có thể cần** | ① Shortcut sinh ảnh wallpaper — nhiều shortcut kiểu này **lưu ảnh vào Photos** trước khi đặt làm wallpaper ② Paywall quảng cáo *"Day colors & **backgrounds**"* — nếu user được chọn ảnh nền riêng thì cần **quyền đọc** |
| **Bằng chứng hiện có** | **Không có dialog Photos nào** trong 55 ảnh |
| **Nếu từ chối** | Tuỳ cơ chế: có thể shortcut lỗi im lặng, hoặc chỉ mất tính năng nền tuỳ chỉnh |
| **Phải xác định** | Shortcut có ghi vào Photos không? Có cho chọn ảnh nền riêng không? Nếu có, xin quyền ở **thời điểm nào** — app hay Shortcuts? |

> **Lưu ý kỹ thuật:** nếu chọn ảnh bằng `PHPickerViewController` thì **không cần quyền** (chạy ngoài tiến
> trình app). Nếu dùng `PHPhotoLibrary` trực tiếp thì cần. Cách implement quyết định có phải xin hay không.

### 1.4 ⚠️ Notifications — chắc chắn cần, chưa thấy dialog

| | |
|---|---|
| **Cơ chế** | `UNUserNotificationCenter.requestAuthorization` — không có key `Info.plist` |
| **Vì sao cần** | ① Note toolbar có icon 🔔 *(nhắc nhở)* ② Task có Date + Time ③ Reminders đồng bộ 2 chiều ④ Live Activity trên lock screen |
| **Bằng chứng hiện có** | **Không có dialog thông báo nào** trong 55 ảnh |
| **Nếu từ chối** | 🟠 Nhắc nhở của task/note **không bao giờ kêu**. User đặt nhắc rồi lỡ việc — mất niềm tin nặng |
| **Phải xác định** | App xin quyền lúc nào? Lần đầu đặt nhắc nhở, hay lúc onboarding? Nếu user từ chối, app có **chặn không cho đặt nhắc** hay vẫn cho đặt rồi im lặng không kêu? *(Cái sau là bug nghiêm trọng.)* |

### 1.5 ⚠️ Camera — chỉ khi Note cho chụp ảnh đính kèm

| | |
|---|---|
| **Key** | `NSCameraUsageDescription` |
| **Vì sao có thể cần** | Toolbar soạn note có icon 📎 *(đính kèm)*. Nếu menu đính kèm có "Chụp ảnh" thì cần |
| **Bằng chứng** | Chưa mở được menu đính kèm — **coverage gap** |

### 1.6 ⚠️ App Tracking Transparency — nếu có quảng cáo/attribution

| | |
|---|---|
| **Key** | `NSUserTrackingUsageDescription` |
| **Vì sao có thể cần** | App có thu phí và nhiều khả năng chạy quảng cáo cài đặt. Bất kỳ SDK attribution nào (AppsFlyer, Adjust, Meta SDK…) đều kích hoạt yêu cầu ATT |
| **Bằng chứng** | Không thấy dialog ATT — có thể chưa tích hợp, hoặc chưa tới thời điểm hỏi |
| **Rủi ro nếu làm sai** | Dùng IDFA mà không xin ATT là **lý do bị reject** |

### 1.7 ⚠️ Siri — nếu hỗ trợ gọi bằng giọng nói

| | |
|---|---|
| **Key** | `NSSiriUsageDescription` |
| **Bằng chứng** | Trang shortcut ghi *"Say 'Siri, Generate Latest Wallpaper'"* — nhưng đây là khả năng của **Shortcuts**, không nhất thiết là SiriKit của Ink |
| **Phải xác định** | Ink có expose App Intents riêng cho Siri không? Nếu chỉ dùng qua Shortcuts thì **không cần** key này |

---

## 2 · Tầng B — Quyền cấp trong app Shortcuts *(per-shortcut, ngoài tầm Ink)*

Cả 3 quyền dưới đây **không phải quyền của app Ink**. Chúng gắn với **shortcut**, cấp trong app Shortcuts,
và Ink **không đọc được trạng thái**.

| # | Dialog | Lựa chọn | Nếu từ chối / chọn sai |
|---|--------|----------|------------------------|
| ✅ **B1** | *"Allow 'Generate Latest Wallpaper' to run actions from 'Ink'?"* | Don't Allow · Allow | Shortcut không gọi được Ink → không sinh được ảnh |
| ✅ **B2** | *"Allow … to set a wallpaper?"* | Don't Allow · Allow | Sinh được ảnh nhưng **không đặt được** làm wallpaper |
| ✅ **B3** | *"Allow … to output 1 wallpaper?"* | Don't Allow · **Allow Once** · **Always Allow** | 🔴 `Allow Once` → chạy được **đúng một lần**, hôm sau automation chết im lặng |

> 🔴 **B3 là rủi ro số 1 của toàn sản phẩm.** Nút `Allow Once` nằm **giữa**, dễ bấm hơn `Always Allow` ở dưới
> cùng, và không màn hướng dẫn nào của Ink nhắc tới. Chi tiết:
> [shortcut-flow-cases · N4](shortcut-flow-cases.md#n4--allow-once-thay-vì-always-allow-).

**Rút lại ở đâu:** Settings → Shortcuts → (per-app / per-shortcut). Ink không phát hiện được khi bị rút.

---

## 3 · Tầng C — Uỷ quyền Google Calendar (OAuth)

Không phải quyền iOS. Đây là uỷ quyền phía **Google**, cấp qua luồng OAuth, và **hết hạn được**.

| | |
|---|---|
| **Bằng chứng** | Toggle `Google Calendar` trong Settings, mô tả *"Sign in to sync and show events from Google Calendar."* |
| **Scope nhiều khả năng cần** | `.../auth/calendar` hoặc `.../auth/calendar.events` — vì app **ghi** được event *(read-only không đủ)* |
| **Đặc thù nguy hiểm** | Là uỷ quyền duy nhất **cần mạng**, **hết hạn được**, và **user có thể thu hồi ở nơi khác** (myaccount.google.com) mà Ink không biết |
| **Nếu mất uỷ quyền** | 🔴 Shortcut vẫn chạy, wallpaper vẫn vẽ — nhưng **thiếu toàn bộ event Google**. Lock screen trông đúng mà thiếu nửa số cuộc họp |
| **Yêu cầu phía Google** | Scope Calendar là **sensitive scope** → app phải qua **OAuth verification**. Chưa duyệt thì user gặp màn cảnh báo "app chưa được xác minh" giữa luồng đăng nhập |
| **Ràng buộc riêng tư** | Onboarding khẳng định *"Your data stays on your device"* — cần làm rõ câu này khi bật Google sync |

**Toàn bộ luồng này chưa có screenshot nào** — xem [exploratory-references §1.6](exploratory-references.md#16--google-calendar-nguồn-dữ-liệu-duy-nhất-cần-mạng-và-tài-khoản).

---

## 4 · Tầng D — Công tắc iOS không phải "quyền" nhưng chặn tính năng

Không có dialog xin, không có API kiểm tra dễ dàng, người dùng tự bật/tắt — và khi tắt thì tính năng chết
**không kèm thông báo nào**.

| Công tắc | Ở đâu | Ảnh hưởng nếu tắt |
|---|---|---|
| **Live Activities** | Settings → Ink → Live Activities | Live Activity không hiện trên lock screen. *(S06 có ghi "Tap **Allow** to let it show" → nhiều khả năng có prompt lần đầu)* |
| **Background App Refresh** | Settings → General | Widget và Live Activity cập nhật chậm hoặc đứng |
| **Cellular Data cho Ink** | Settings → Cellular | Google Calendar không sync khi dùng 4G/5G |
| **Low Power Mode** | Control Center | Automation có thể bị hoãn — [E2](shortcut-flow-cases.md#41--thời-điểm-automation-chạy) |
| **Screen Time / MDM chặn Shortcuts** | Settings → Screen Time | Không cài được shortcut — [N17](shortcut-flow-cases.md#nhóm-34--phá-vỡ-sau-khi-đã-setup-xong) |
| **Focus / nhiều lock screen** | Settings → Focus | Shortcut ghi đè lock screen nào? — [E15](shortcut-flow-cases.md#43--vòng-đời-máy--tài-khoản) |

---

## 5 · ❌ Quyền **không** cần — và vì sao

Ghi lại để tránh xin thừa (xin thừa làm tăng tỷ lệ từ chối và bị soi khi review):

| Quyền | Vì sao không cần |
|---|---|
| **Location** | Form tạo event **không có trường Location**. Không có tính năng travel time hay nhắc theo vị trí |
| **Contacts** | Không thấy tính năng mời người tham dự trong app. *(Nếu sau này hiển thị attendee của event Google thì chỉ là hiển thị, không cần quyền Contacts)* |
| **Microphone** | Không có ghi âm trong note |
| **Face ID / biometrics** | Không có khoá app hay khoá note |
| **HealthKit** | Có event *"Uống Creatine"*, *"Upper Day"* nhưng đó chỉ là **tên event do user tự đặt**, không phải tích hợp Health |
| **Local Network** | Không có tính năng chia sẻ trong mạng LAN |

---

## 6 · Ma trận hỏng theo quyền

Cột = quyền bị từ chối. Ô = tính năng còn dùng được không.

| Tính năng | Calendar<br/>**None** | Calendar<br/>**Add Events Only** | Reminders | Notifications | Photos⚠️ | B3 Always Allow | Google OAuth |
|---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Wallpaper lock screen | 🔴 chết | 🔴 **chết** | 🟠 thiếu to-do | ✅ | ⚠️ tuỳ cơ chế | 🔴 chết sau ngày 1 | 🟠 **thiếu event Google, im lặng** |
| Widget | 🔴 chết | 🔴 **chết** | 🟠 thiếu | ✅ | ✅ | ✅ | 🟠 thiếu |
| Live Activity | 🔴 chết | 🔴 **chết** | 🟠 thiếu | ⚠️ cần kiểm | ✅ | ✅ | 🟠 thiếu |
| Tab Calendar — xem | 🔴 có màn hướng dẫn | 🔴 **trống, có thể không giải thích** | ✅ | ✅ | ✅ | ✅ | 🟠 thiếu |
| Tab Calendar — tạo event | ❌ | ⚠️ **có thể hỏng** *(không chọn được calendar đích)* | ✅ | ✅ | ✅ | ✅ | ✅ |
| Sheet Calendars | ❌ | 🔴 **hỏng** *(liệt kê cần quyền đọc)* | ✅ | ✅ | ✅ | ✅ | ✅ |
| Tab Tasks | ✅ | ✅ | 🔴 **chết cả tab**, kể cả task nguồn Ink | 🟠 nhắc không kêu | ✅ | ✅ | ✅ |
| Tab Notes | ✅ | ✅ | ✅ | 🟠 nhắc không kêu | ⚠️ đính kèm | ✅ | ✅ |
| Mua Pro | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |

**Đọc ra được từ bảng:**

- **`Add Events Only` hỏng gần bằng `None`** nhưng nguy hiểm hơn, vì user **tin rằng mình đã cấp quyền rồi**.
  Khi mọi thứ vẫn trống, họ sẽ kết luận app hỏng chứ không nghĩ tới quyền.
- Chỉ **Calendar** (cả 2 trạng thái thiếu) và **B3** gây chết hoàn toàn.
- **Google OAuth** gây kiểu hỏng tệ nhất về bản chất — **mất một phần dữ liệu mà không báo**. Ô 🟠 nhưng
  nguy hiểm hơn nhiều ô 🔴, vì 🔴 thì user biết là hỏng, còn 🟠 thì không.

---

## 7 · Thời điểm hỏi quyền — rủi ro đã nhận diện

**iOS chỉ cho hỏi mỗi quyền đúng một lần.** Từ chối rồi là phải tự vào Settings — mà phần lớn user không biết
đường. Nên **thời điểm hỏi quyết định tỷ lệ đồng ý**.

Hiện tại:

```
Onboarding slide 1 → 2 → 3 → 4 → 5 ──┬─→ [dialog Calendar]
                                     └─→ [dialog Reminders]   ← ngay sau, cùng 1 lần bấm
```

- [ ] Xin **2 quyền liên tiếp** trong một lần bấm — user có bị dội không? Có ai đo tỷ lệ đồng ý từng dialog chưa?
- [ ] Có nên hoãn **Reminders** tới lúc user thật sự mở tab Tasks không? *(Quyền tuỳ chọn thì nên hỏi đúng
      lúc cần, không hỏi trước.)*
- [ ] Quyền **Notifications** hỏi lúc nào? Nếu gộp luôn vào onboarding thì thành **3 dialog liên tiếp**.
- [ ] Pre-permission priming ở slide 5 có làm tăng tỷ lệ đồng ý không? *(Có số liệu không, hay chỉ là niềm tin?)*
- [ ] Nếu user từ chối, app có màn hình *"Bật lại quyền trong Settings"* kèm nút mở thẳng
      `UIApplication.openSettingsURLString` không? **Chưa có ảnh nào.**

---

## 8 · Việc QC phải làm với danh sách này

1. **Đối chiếu `Info.plist` thật** — liệt kê mọi key `*UsageDescription` đang khai. Key nào khai mà không
   dùng → gỡ đi (App Review có soi). Key nào dùng mà chưa khai → **app sẽ crash** khi gọi API.
2. **Đối chiếu App Privacy Label trên App Store Connect** với thực tế thu thập — đặc biệt phần Google Calendar.
3. **Test từng đường từ chối** — mỗi quyền một lần, xem app degrade hay vỡ. Chưa có ảnh nào cho đường từ chối.
4. **Test đường rút quyền sau khi đã cấp** — vào Settings tắt đi rồi quay lại app.
5. **Xác định dứt điểm 4 dấu ⚠️**: Photos, Notifications, Camera, ATT — có xin hay không, xin lúc nào.
6. **Đo tỷ lệ đồng ý từng dialog** nếu có analytics. Không có thì ghi là gap về đo lường.
