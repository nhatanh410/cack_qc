# PRD: Ink AI Assistant Tab

**Document Version:** 1.1  
**Status:** Draft — chặn bởi §9 (Open Questions)  
**Product:** Ink (iOS / LockScreen Calendar)  
**Author:** Senior Product Manager  
**Target Platform:** iOS (SwiftUI Native TabBar)  

---

## 1. Executive Summary & Product Positioning

### 1.1. Bối cảnh & Vấn đề
Hiện tại, Ink là ứng dụng tùy biến lịch màn hình khóa (Lock Screen Calendar). Việc tạo lịch, thêm việc cần làm hay cấu hình hiển thị lịch trình trên thiết bị di động vẫn phải thông qua các form nhập liệu truyền thống (chọn ngày, cuộn giờ, phân loại danh mục) gây tốn thời gian (5–8 clicks cho 1 sự kiện).

### 1.2. Định vị Tab AI (The Executive Assistant)
- **Tên Tab**: `Assistant` (Icon: `sparkles.bubble` hoặc `wand.and.stars`).
- **Không phải Chatbot hỏi đáp kiến thức chung**: Không cạnh tranh với ChatGPT/Claude về hỏi đáp bách khoa toàn thư.
- **Tập trung 100% vào ngữ cảnh người dùng**: Đóng vai trò là **Trợ lý điều hành cá nhân (Executive Assistant)** kết nối trực tiếp với Apple Calendar, Reminders và Màn hình khóa (Lock Screen) — mỗi kết nối này là một wrapper của action đã có sẵn trong app, xem Action Map §2.0.
- **Nguyên tắc cốt lõi**: *"Chat để hành động, không phải chat để đọc văn bản"* — 100% phản hồi liên quan đến sự kiện/task đều được thể hiện dưới dạng **Interactive Cards** có nút bấm xác nhận 1 chạm.

---

## 2. Core User Flows

### 2.0. Nguyên tắc bắt buộc: mọi action = wrapper của một action đã có trong app

> **Assistant không phải một hệ thống ghi dữ liệu mới.** Nó không được tự định nghĩa một
> đường ghi riêng — mỗi nút bấm trên Interactive Card phải gọi thẳng vào đúng API mutation
> app đã có, cùng validation, cùng side-effect (undo, analytics, sync widget) như khi user
> bấm qua UI thường. Nếu một hành động chưa có API tương ứng, nó **không nằm trong scope
> Assistant** cho tới khi được xây như một feature độc lập trước — Assistant không phải chỗ
> để lén đưa vào một khả năng ghi mới.

**Action Map — chốt trước khi code bất kỳ card nào:**

| Ý định người dùng | Card | Gọi thẳng vào | Ghi chú |
|---|---|---|---|
| Tạo sự kiện | Event Card → *"Lưu vào Lịch"* | `CalendarService.createEvent(_:)` ([CalendarService.swift:423](ios/Ink/Core/Services/CalendarService.swift#L423)) | Cùng validation với Create Event form |
| Tạo task | Reminder Card → *"Tạo việc cần làm"* | `ReminderService.createReminder(_:)` ([ReminderService.swift:185](ios/Ink/Core/Services/ReminderService.swift#L185)) | |
| Đánh dấu hoàn thành task | Reminder Card (task có sẵn) → checkbox | `ReminderService.setCompleted(reminderId:completed:)` ([ReminderService.swift:227](ios/Ink/Core/Services/ReminderService.swift#L227)) | *(mới thêm — PRD gốc chưa có action nào sửa/xoá task có sẵn)* |
| Xoá / bỏ task | Reminder Card → *"Xoá"* | `ReminderService.deleteReminder(reminderId:)` ([ReminderService.swift:320](ios/Ink/Core/Services/ReminderService.swift#L320)) | *(mới thêm)* — cần bước xác nhận, đây là action phá huỷ |
| Đặt/đổi quote lên Lock Screen | Quote Card → *"Áp dụng lên Lock Screen"* | `CalendarTemplateEditorViewModel.addQuote(_:)` / `.updateQuote(at:to:)` ([CalendarTemplateEditorPanel.swift:845](ios/Ink/UI/Wallpaper/CalendarTemplateEditorPanel.swift#L845)) → ghi vào `quote.items` qua `QuoteBandEdits` → `InkShortcutLauncher.runWallpaperShortcut()` để áp dụng | Xem §2.3 — **chỉ khả dụng khi template đang áp dụng có quote band** (`QuoteBandEdits.bandIndex` khác nil) |

Bất kỳ card mới nào thêm sau này bắt buộc có một dòng trong bảng này trước khi vào code —
không có dòng nghĩa là chưa có action đích, chưa được build.

### Flow 1: Nhập lịch / Task siêu tốc (Natural Language Quick-Add)
```
User mở Tab AI
   │
   ├── Gõ hoặc bấm Mic nói: "Chiều mai 3h cafe Highlands với Nam bàn việc"
   │   (Hoặc Paste đoạn chat hẹn hò từ Zalo / Slack / Mail)
   │
   ▼
AI phân tích ngữ cảnh (Title, Date, Time, Location, Notes)
   │
   ▼
Hiển thị "Interactive Event Card" ngay trong luồng chat
   ├── Tiêu đề: Cafe với Nam
   ├── Thời gian: 15:00 - 16:00, Ngày mai
   ├── Địa điểm: Highlands Coffee
   └── Ghi chú: Bàn việc
   │
   ├── [ Sửa ]             [ Lưu vào Lịch ]
   │
User bấm [ Lưu vào Lịch ] ──► Ghi trực tiếp vào Apple Calendar & cập nhật hình nền
```

---

### Flow 2: Tóm tắt & Tối ưu thời gian (Daily Brief & Free Slot Finder)
```
User bấm Action Chip: "Lịch hôm nay ra sao?"
hoặc hỏi: "Chiều nay tôi có rảnh 2 tiếng tập gym không?"
   │
   ▼
AI quét lịch Calendar & Reminders trong ngày
   │
   ▼
Trả lời cô đọng kèm Smart Action Card:
   "Chiều nay bạn trống từ 14:30 đến 17:00 trước cuộc họp Team Sync lúc 17h."
   │
   └── [ Thẻ đề xuất: Đặt lịch Gym 15:00 - 16:30 ] ──► Bấm 1 chạm để chốt lịch
```

---

### Flow 3: Đặt Quote lên Lock Screen (Set Lockscreen Quote) — **thu hẹp scope, xem điều kiện bên dưới**

*(Bản 1.0 gọi flow này là "Lock Screen Prompting" với ví dụ AI tự tổng hợp 3 việc quan
trọng nhất thành headline. Đã kiểm tra renderer: không có part nào nhận một chuỗi tổng hợp
tuỳ ý — **nhưng** có sẵn cơ chế quote band (`QuoteBandEdits` + `QuotePart`, xem Action Map
§2.0) mà user đã tự gõ quote vào hôm nay. Flow 3 viết lại theo đúng action đó thay vì bịa
một action mới.)*

```
User yêu cầu: "Đổi quote lock screen thành câu về sự tập trung"
   │
   ▼
Kiểm tra template đang áp dụng có quote band không (QuoteBandEdits.bandIndex)
   │
   ├── KHÔNG có ──► Trả lời: "Mẫu hiện tại chưa có khung trích dẫn — chọn một mẫu có Quote
   │                 trong Discover trước" (không giả vờ áp dụng được)
   │
   └── CÓ ──► AI soạn 1 câu ngắn (≤ 60 ký tự, theo Tone user chọn — §7)
              │
              ▼
       Hiển thị "Quote Card":
         "🧘 Tập trung vào điều quan trọng nhất."
         │
         ├── [ Sửa ]              [ Áp dụng lên Lock Screen ]
         │
       User bấm Áp dụng ──► CalendarTemplateEditorViewModel.addQuote/.updateQuote
                             ──► ghi vào quote.items của SNAPSHOT user đang dùng
                             ──► InkShortcutLauncher.runWallpaperShortcut()
```

**Điều kiện chặn trước khi build:**

* Chỉ hoạt động trên template **đang áp dụng** của user, và chỉ khi nó có quote band
  editable (`QuoteBandEdits.bandIndex` khác nil). Catalog bundle hiện có **5/46** template
  mang part `quote` — tỉ lệ ở Remote Config catalog thực tế cần đo lại, không giả định.
* Quote band có thể đang **rotate theo ngày** (nhiều `items`) — AI ghi đè cả danh sách
  (`QuoteBandEdits.setting(items:)` viết lại **toàn bộ mảng**, không phải append). Cần quyết
  định: AI thay thế toàn bộ danh sách quote cũ của user, hay chỉ chèn thêm một entry mới vào
  cuối? Ghi đè im lặng danh sách quote user tự tay soạn là hành vi phá dữ liệu cần cảnh báo
  rõ trong card trước khi bấm Áp dụng.
* Đây là ghi vào **snapshot riêng của user** (không phải catalog) — đúng model quyền sở hữu
  hiện có, không cần thêm cơ chế mới.
* "Tóm tắt 3 việc quan trọng nhất" (bản gốc PRD) vẫn làm được — AI chỉ cần nén 3 việc đó
  thành 1 câu ngắn trước khi ghi vào `quote.items`, y hệt cách user tự gõ tay hôm nay.

---

## 3. UI/UX Architecture & Layout Spec

### 3.1. Wireframe bố cục màn hình

```text
┌────────────────────────────────────────────────────────┐
│  [⚙️ Cài đặt]               Ink AI            [🗑️ Xoá chat]│  <- Navigation Header
├────────────────────────────────────────────────────────┤
│                                                        │
│  ✨ Chào Duke! Hôm nay bạn có 4 sự kiện.              │  <- Bot Greeting
│                                                        │
│  [📅 Tóm tắt hôm nay]  [➕ Thêm lịch]  [🧹 Tìm giờ rảnh]  │  <- Quick Action Chips
│                                                        │
│  ────────────────────────────────────────────────────  │
│                                                        │
│  [User Bubble]                                         │
│  Chiều mai 3h cafe bàn việc với Nam ở Highlands        │
│                                                        │
│  [AI Assistant Bubble]                                 │
│  Mình đã chuẩn bị lịch hẹn cho bạn:                    │
│  ┌──────────────────────────────────────────────────┐  │
│  │ ☕ Cafe với Nam                                  │  │
│  │ 🕒 15:00 - 16:00, Chiều mai                      │  │  <- Interactive
│  │ 📍 Highlands Coffee                               │  │     Event Card
│  │ 📝 Bàn việc                                      │  │
│  │ ──────────────────────────────────────────────── │  │
│  │  [ Sửa chi tiết ]              [ Lưu vào Lịch ]  │  │
│  └──────────────────────────────────────────────────┘  │
│                                                        │
├────────────────────────────────────────────────────────┤
│  [ 🎙️ ]   Nhập sự kiện hoặc hỏi lịch...         [ ↑ ]  │  <- Bottom Input Dock
└────────────────────────────────────────────────────────┘
```

### 3.2. Thành phần UI chi tiết

1. **Navigation Header**:
   * Tiêu đề `Ink AI` với biểu tượng phát sáng (glow accent).
   * Nút `Clear Chat` (icon thùng rác nhỏ) để reset session khi user muốn bắt đầu cuộc trò chuyện mới.

2. **Quick Action Chips (Gợi ý 1 chạm)**:
   * Thanh cuộn ngang các gợi ý thường dùng nhất, tránh hội chứng "ngại gõ" (prompt paralysis):
     * `📅 Lịch hôm nay ra sao?`
     * `🕒 Chiều nay rảnh lúc nào?`
     * `📌 Việc cần làm gấp hôm nay`
     * `🎨 Đổi câu quote Lockscreen` — chip này **ẩn** khi template đang áp dụng không có quote band (xem §2.0 Action Map, §2 Flow 3)

3. **Interactive Action Cards**:
   * **Event Card**: Thẻ bo tròn, hiển thị icon loại sự kiện, tên, giờ bắt đầu - kết thúc, địa điểm. Nút CTA xanh: *"Lưu vào Lịch"*.
   * **Reminder Card**: Checklist kèm checkbox cho task mới, hoặc thẻ task có sẵn với hành động **Hoàn thành** / **Xoá** (xem §2.0 Action Map — `setCompleted` / `deleteReminder`).
   * **Quote Card**: Xem trước dòng quote AI soạn, nút *"Sửa"* / *"Áp dụng lên Lock Screen"* — ghi vào quote band có sẵn của template đang áp dụng (điều kiện ở Flow 3, §2). Không hiện thẻ này nếu template không có quote band.

4. **Bottom Input Dock**:
   * Thanh nhập liệu gắn đáy (Docked Keyboard Safe Area).
   * Nút Micro bên trái: Kích hoạt Apple Speech-to-Text để nói trực tiếp.
   * Textfield tự co giãn độ cao (từ 1 đến 4 dòng).
   * Nút Send chuyển màu active khi có ký tự.

---


## 4. Product Requirements & Acceptance Criteria (AC)

### 4.1. Khả năng đọc (Read Capabilities)

* **AC 4.1.1**: AI đọc dữ liệu đã được cấp phép (EventKit Calendar & Reminders) từ hiện tại đến **7 ngày tới, cho mọi tier**. Phân tầng Free/Pro nằm ở *độ sâu phân tích* (§7), không ở cửa sổ đọc — một cửa sổ đọc khác nhau theo tier sẽ khiến câu "tuần này tôi có bận không?" trả lời **sai sự thật** với user Free.
* **AC 4.1.2**: Lọc được các khoảng trống (free slots) tối thiểu 30 phút.
* **AC 4.1.3** *(mới)*: AI chỉ đọc đúng tập calendar user đang bật trong `InkCalendarVisibilityStore`, không đọc rộng hơn phạm vi user đã chọn cho phần còn lại của app.

### 4.2. Khả năng ghi (Write & Action Capabilities)

* **AC 4.2.1**: AI **không bao giờ** tự ghi vào Calendar/Reminders mà không qua xác nhận trên Interactive Card.
* **AC 4.2.2**: Sau khi bấm *"Lưu vào Lịch"*, thẻ chuyển trạng thái *"Đã lưu"* và nút bị vô hiệu hoá. Mỗi card mang một **idempotency key**; gửi lại cùng key không tạo bản trùng (chống double-tap và chống retry sau lỗi mạng).
* **AC 4.2.3** *(mới)* — **Calendar đích**: Card phải hiển thị tên calendar sẽ ghi vào và cho đổi trước khi lưu. App đã nối cả Google ([InkGoogleCalendarApi.swift](ios/Ink/Data/InkGoogleCalendarApi.swift)) và Outlook ([InkGraphCalendarApi.swift](ios/Ink/Data/InkGraphCalendarApi.swift)) — v1 chỉ ghi qua EventKit; nếu user chỉ nối tài khoản remote, card phải nói rõ thay vì lưu im lặng vào một calendar khác.
* **AC 4.2.4** *(mới)* — **Undo**: Lưu thành công raise `inkSnackbar` tone `.success` kèm `InkToast.Action("Hoàn tác")` xoá event vừa tạo. Cửa sổ auto-dismiss của toast *là* cửa sổ undo (pattern đã có ở tab Tasks) — tái dụng, không tự nghĩ affordance mới.
* **AC 4.2.5** *(mới)* — **Ghi thất bại** (quyền bị thu hồi giữa chừng, calendar read-only, hết dung lượng): card về trạng thái lỗi kèm nút *Thử lại*, **giữ nguyên dữ liệu đã parse**. Không được văng user về ô nhập trắng.
* **AC 4.2.6** *(mới)* — **Hoàn thành / xoá task**: AI chỉ được thao tác trên task **đã định danh rõ ràng** — match theo id trả về từ `ReminderService.fetchReminders`, không match mờ theo tên (hai task trùng tên "Nộp báo cáo" phải hỏi lại task nào, không đoán). **Xoá là hành động phá huỷ**: card xoá luôn cần một bước xác nhận riêng (không tự xoá ngay khi AI hiểu ý định), và raise undo toast như AC 4.2.4.
* **AC 4.2.7** *(mới)* — **Đặt quote Lock Screen**: chỉ hiện Quote Card khi template đang áp dụng có quote band (`QuoteBandEdits.bandIndex != nil`); nếu không, AI trả lời bằng text nói rõ lý do, không dựng card giả. Card phải nói rõ **ghi đè hay thêm vào cuối** danh sách quote hiện có trước khi user bấm Áp dụng — xem câu hỏi mở #7.

### 4.3. Xử lý câu lệnh không đầy đủ (Ambiguous Input)

* **AC 4.3.1**: Thiếu thời gian → không báo lỗi generic, hỏi lại kèm chips gợi ý nhanh (`Hôm nay 19:00`, `Ngày mai 19:00`, `Thứ 7 tuần này`).
* **AC 4.3.2** *(mới)*: **Tối đa 1 vòng hỏi lại.** Nếu sau một lần hỏi vẫn thiếu dữ kiện, mở thẳng form Create Event đã điền sẵn phần AI parse được. Hỏi vòng thứ hai là lúc chat chậm hơn form — đúng cái vấn đề feature này sinh ra để giải.
* **AC 4.3.3** *(mới)*: "chiều mai", "thứ 7" resolve theo **timezone thiết bị tại thời điểm gửi**. Card luôn hiện ngày tuyệt đối (`Th 5, 09/09`) cạnh nhãn tương đối — nhãn tương đối sai nghĩa nếu user xem lại lịch sử chat hôm sau.

### 4.4. Error, Offline & Latency *(mới — thiếu hoàn toàn ở v1.0)*

Mọi trạng thái dưới đây cần copy riêng + affordance riêng, không dùng chung một alert "Đã có lỗi xảy ra":

| Trạng thái | Hành vi yêu cầu |
|---|---|
| Mất mạng | Tab vẫn mở, đọc lại được lịch sử chat, input disabled kèm lý do |
| Timeout | Huỷ request, hiện *Thử lại*, không mất nội dung user đã gõ |
| Hết quota | **Không phải lỗi** — là paywall moment (§7) + đếm ngược tới lượt reset |
| Chưa cấp quyền EventKit | `InkEmptyStateView` + CTA *Mở Cài đặt* (pattern đã có ở Calendar/Tasks) |
| LLM từ chối trả lời | Thông báo trung tính + gợi ý diễn đạt lại |
| Server 5xx | *Thử lại*, và sau 2 lần fail thì đề xuất mở form thủ công |

* **AC 4.4.1**: Streaming bắt buộc. First token ≤ 2s (p50). Quá 8s không có token → huỷ + báo lỗi.
* **AC 4.4.2**: Không có spinner vô hạn ở bất kỳ nhánh nào.
* **AC 4.4.3**: Lịch sử chat lưu local (SwiftData, App Group) — offline vẫn xem lại được.

### 4.5. Localization & Voice *(mới)*

* **AC 4.5.1**: Toàn bộ chrome (chips, nút, empty state, mọi câu lỗi) qua `Localizable.xcstrings`, **đủ 11 ngôn ngữ**. `Phase7AcceptanceTests` đóng băng locale set và l10n ratchet fail build nếu còn tiếng Anh trong bản dịch.
* **AC 4.5.2**: AI trả lời theo ngôn ngữ user gõ; fallback về ngôn ngữ hệ thống.
* **AC 4.5.3**: Voice cần **`NSSpeechRecognitionUsageDescription`** — hiện `ios/Ink/Info.plist` mới có `NSMicrophoneUsageDescription`. Usage description phải dịch đủ 11 ngôn ngữ theo `docs/runbooks/localization.md`.
* **AC 4.5.4**: Locale không được Speech hỗ trợ → **ẩn** nút mic, không hiện nút bấm vào không phản hồi.

### 4.6. Platform & Design System *(mới)*

* **AC 4.6.1**: iPad — nội dung chat cap qua `inkReadableWidth`, không kéo bubble ngang toàn màn.
* **AC 4.6.2**: Dynamic Type + VoiceOver — card đọc theo thứ tự tiêu đề → thời gian → địa điểm; nút có accessibility label rõ nghĩa.
* **AC 4.6.3**: Tái dụng design system thay vì hand-roll: chips → `InkChip`, thẻ → `InkGroupedCard`, header → `InkScreenHeader`, CTA → `AppButton`, ô nhập → `InkTextField`, toast → `inkSnackbar`. **Chat bubble** và **input dock** là hai component mới thật sự → phải đăng ký vào `.claude/rules/swift/design-system.md` trong cùng change.

---

## 5. Backend, Auth & Cost Model *(mới — hạng mục chặn)*

### 5.1. Kiến trúc bắt buộc

Ink hiện **zero backend** (push notification còn soạn tay trong Firebase Console). Không được ship API key trong binary — vi phạm `.claude/rules/common/security.md`. Kiến trúc tối thiểu:

```
App  ──►  Ink proxy  ──►  LLM provider
          ├─ App Attest / DeviceCheck → session token (app chưa có login)
          ├─ verify Pro qua App Store Server API (transaction id)
          ├─ đếm & enforce quota
          ├─ SSE streaming passthrough
          └─ log tối thiểu (§6)
```

### 5.2. Model & đơn giá

Giá first-party Anthropic (cached 2026-06-24, $/1M token):

| Model | ID | Context | Input | Output |
|---|---|---|---|---|
| Claude Opus 5 | `claude-opus-5` | 1M | $5.00 | $25.00 |
| Claude Sonnet 5 | `claude-sonnet-5` | 1M | $2.00 | $10.00 |
| Claude Haiku 4.5 | `claude-haiku-4-5` | 200K | $1.00 | $5.00 |

Định hướng: Flow 1 (quick-add) là **trích xuất có schema** — dùng structured output, model rẻ có thể đủ. Flow 2/3 cần suy luận trên lịch nên đắt hơn. **Chốt bằng eval trên tập câu tiếng Việt + tiếng Anh thật, không chốt bằng cảm tính.**

**Prompt caching** là đòn bẩy chi phí lớn nhất ở đây vì system prompt + tool schema lặp lại mọi request: đặt phần tĩnh (system, tool defs) trước, phần biến thiên (thời điểm hiện tại, lịch hôm nay) **sau** breakpoint cuối. Verify bằng `usage.cache_read_input_tokens` — bằng 0 nghĩa là có thứ đang âm thầm phá cache (thường là timestamp nhét trong system prompt).

### 5.3. Đơn giá một lượt *(ước tính, cần đo lại sau prototype)*

Giả định ~1.000 token input (system đã cache + lịch rút gọn + câu user) và ~250 token output:

| Model | ~$ / lượt | 5 lượt/ngày × 30 ngày |
|---|---|---|
| Haiku 4.5 | ~$0.002 | ~$0.30 / user / tháng |
| Sonnet 5 | ~$0.005 | ~$0.75 / user / tháng |
| Opus 5 | ~$0.011 | ~$1.65 / user / tháng |

Lưu ý: chat nhiều lượt **resend cả history**, nên lượt thứ n đắt hơn lượt đầu. Một phiên 4 lượt tốn khoảng 2,5× đơn giá một lượt, không phải 4×1.

### 5.4. Vấn đề cấu trúc: gói Lifetime không chịu được "không giới hạn"

Giá hiện tại ([ProStack.swift:287-289](ios/Ink/UI/Pro/ProStack.swift#L287-L289)): weekly **$1.99**, annual **$19.99**, lifetime **$49.99**.

* Annual $19.99/năm ≈ **$1.67/tháng gross**, còn ~$1.42 sau phí Apple 15%. Một Pro user chat 20 lượt/ngày trên Sonnet 5 tốn ~$3/tháng COGS → **âm ngay tháng đầu**.
* Lifetime $49.99 kèm "AI không giới hạn" là **lỗ không có điểm dừng**: hoà vốn sau ~10–15 tháng rồi lỗ vĩnh viễn, và user Lifetime chính là nhóm dùng nhiều nhất.

Phải chọn một trước khi §7 được duyệt:

1. **Fair-use cap cho Pro** (vd 50 lượt/ngày; vượt thì hạ xuống model rẻ hơn thay vì chặn) — khuyến nghị;
2. **Loại AI khỏi gói Lifetime**;
3. **AI là add-on subscription riêng**.

Cho tới khi chốt, ô "Không giới hạn" ở §7 không được để nguyên.

### 5.5. Quota Free phải enforce ở server

5 lượt/ngày = 150 lượt/tháng cho một user **chưa trả đồng nào** — ~$0.30–$1.65/user/tháng tuỳ model. Ở 10k MAU free đó là $3k–$16k/tháng.

* Cân nhắc hạ xuống 3 lượt/ngày, hoặc chỉ để Flow 1 (quick-add) miễn phí và đặt Flow 2/3 sau paywall — Flow 1 mới là cái tạo thói quen.
* **Counter phải nằm ở server.** Repo hiện không có cơ chế metering nào; counter trong `UserDefaults` reset bằng cách xoá app.

---

## 6. Privacy & Consent *(mới — hạng mục pháp lý)*

CLAUDE.md quy định: *"Never log event titles, notes, locations, attendee data, tokens, or reminder content."* Tab chat **phá rule này theo thiết kế** — nên cần một carve-out được viết ra rõ ràng, không phải ngầm hiểu.

* **AC 6.1** — **Consent gate** lần đầu mở tab: nói rõ dữ liệu nào rời máy, đi đâu, giữ bao lâu. Từ chối → tab hiện trạng thái đã tắt + đường bật lại, không dùng được (không có chế độ "nửa vời" gửi ít dữ liệu hơn mà user không thấy).
* **AC 6.2** — **Payload tối thiểu**: gửi `title` + thời gian + tên calendar. **Không gửi** notes, attendees, email, số điện thoại, URL phòng họp. Với Flow 2 (tìm giờ rảnh) chỉ cần busy/free block — cân nhắc gửi ẩn danh hoàn toàn, không kèm title.
* **AC 6.3** — Nội dung **user tự paste** là ngoại lệ có chủ đích, nhưng chip "Paste" phải cảnh báo một lần rằng đoạn text sẽ được gửi đi.
* **AC 6.4** — Hợp đồng **zero data retention / no-training** với nhà cung cấp. Ghi trong hợp đồng, không chỉ trong doc này.
* **AC 6.5** — Proxy **không log prompt/response**. Chỉ log: timestamp, token count, latency, error code, user hash.
* **AC 6.6** — Cập nhật **privacy policy site** và **App Store Privacy Nutrition Label** (thêm mục dữ liệu gửi bên thứ ba). Đây là điều kiện submit, không phải nice-to-have.
* **AC 6.7** — *Clear Chat* xoá sạch bản local, và nói rõ server không giữ gì để xoá.

---

## 7. Chiến lược Monetization (Free vs Pro Tier)

| Tính năng | Gói Miễn phí (Free) | Gói Pro (Subscription) |
|---|---|---|
| **Lượt chat / Tạo lịch** | 5 lượt / ngày *(cân nhắc 3 — §5.5)* | Không giới hạn **trong fair-use cap** *(chốt ở §5.4)* |
| **Bóc tách từ giọng nói / Paste tin nhắn** | Có | Có |
| **Phân tích lịch trống & Tối ưu ngày** | Cơ bản (hôm nay) | Nâng cao (toàn bộ tuần) |
| **Đổi quote Lock Screen qua chat** | Có, *chỉ trên template có quote band* | Có, mọi Style Tone (Stoic, Minimalist, Coach…) |
| **Gói Lifetime ($49.99)** | — | **Chưa chốt** — xem §5.4 trước khi bán |

Quota reset theo **giờ địa phương của thiết bị**, tính ở server, và trạng thái còn lại phải nhìn thấy được trước khi user gõ (không để user soạn xong câu rồi mới bị chặn).

---

## 8. Vị trí TabBar đề xuất

Cấu trúc 5 tab: **Discover · Calendar · AI · Tasks · Notes** (AI ở giữa).

Ba ràng buộc kỹ thuật đi kèm:

1. **Đừng chèn case vào giữa enum.** `InkTab` là `enum … : Int` ([AppShellViewModel.swift:7](ios/Ink/UI/Shell/AppShellViewModel.swift#L7)) và raw value đang được `-ink-debug-tab` + UITests dùng để chụp màn. Append case `.ai` và tách **thứ tự hiển thị** ra khỏi raw value.
2. **Kiểm 5 label × 11 ngôn ngữ** trên iPhone màn nhỏ trước khi chốt. Tiếng Đức và tiếng Việt là hai bản dài nhất.
3. **Đặt điều kiện giữ slot giữa.** Slot giữa là vị trí đắt nhất trong app. Nếu sau 4 tuần Assistant không đạt ngưỡng DAU đã định, hạ nó xuống thành entry point trên Calendar/Tasks thay vì giữ một tab ít dùng ở trung tâm.

---

## 9. Open Questions — phải chốt trước khi vào code

| # | Câu hỏi | Chặn phần nào |
|---|---|---|
| 1 | Nhà cung cấp LLM nào, đã có hợp đồng ZDR chưa? | §5.2, §6.4 |
| 2 | Ai xây và host proxy? Ngân sách hạ tầng/tháng? | §5.1 |
| 3 | Gói Lifetime có kèm AI không? | §5.4, §7 |
| 4 | Free quota 5 hay 3 lượt/ngày? | §5.5, §7 |
| 5 | Ghi vào Google/Outlook calendar: v1 hay để sau? | §4.2.3 |
| 6 | `docs/ai-assist-scope.md` (§1 "Why NO Chatbot") bị superseded, hay hai doc chia phạm vi? | Toàn bộ |
| 7 | Đặt quote qua AI: **ghi đè** toàn bộ danh sách quote user đã tự soạn, hay **thêm vào cuối**? Ghi đè im lặng là mất dữ liệu user tự tay gõ. | §2 Flow 3, §4.2.7 |
