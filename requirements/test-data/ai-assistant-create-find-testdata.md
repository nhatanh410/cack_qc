# Test Data — AI Assistant: Tạo Event/Reminder & Tìm theo khung giờ trong ngày

> **Test basis:** [ai-chat-tab-prd.md](../specs/ai-assistant/ai-chat-tab-prd.md) — Flow 1 (§2, tạo event/reminder) và Flow 2
> (§2, đọc lịch) · Action Map §2.0 · AC §4.1 (đọc) · AC §4.2, §4.3 (ghi + xử lý câu mơ hồ).
> **Liên quan:** [ai-assistant-read-flow-testdata.md](./ai-assistant-read-flow-testdata.md) — dùng chung
> Persona A (lịch dày đặc, 2026-09-17) làm nền cho phần "tìm theo khung giờ" ở mục 3–4 dưới đây.
> **Ngày lập:** 2026-09-17 · **Người lập:** QC

---

## 0. Khung áp dụng

> **Cập nhật 2026-09-17:** ảnh chụp thiết bị thật do QC cung cấp xác nhận **Flow tạo Reminder đã chạy thật**
> — "Tạo task giặt sấy quần áo lúc 3pm ngày mai" ra đúng Reminder Card "Giặt sấy quần áo, Due Fri 18 Sep
> 15:00" kèm "Added to your Reminders". Vì vậy mục 2 (`NLP-CR`) có thể test **đầy đủ cả 2 bước** (parse card
> + verify ghi thật vào Reminders) ngay, không cần chờ xác nhận riêng nữa. Mục 1 (`NLP-CE`, tạo Event) **chưa
> có bằng chứng riêng** trong ảnh — vẫn giữ nguyên khung 2 bước bên dưới cho tới khi có ảnh/bằng chứng tương
> tự cho Event Card.

- **Tạo event / tạo reminder (mục 1–2) = Flow 1, hành động ghi.** Tách làm 2 việc **độc lập nhau**, để không
  phải chờ xác nhận write API mới test được:
  1. **Test được ngay, không cần chờ:** AI có **hiểu đúng ý định và parse đúng field** (Title/Date/Time/
     Location) để dựng ra Interactive Card không — quan sát ở nội dung Card, chưa cần bấm "Lưu".
  2. **Tạo Event (`NLP-CE`) — vẫn chờ xác nhận riêng:** bấm "Lưu vào Lịch" có thật sự ghi vào Apple Calendar
     đúng như Card hiển thị không (đối chiếu theo nguyên tắc ở file read-flow mục 5). **Tạo Reminder
     (`NLP-CR`) — đã xác nhận, test đầy đủ ngay** theo đúng cập nhật ở trên.
- **Tìm event / tìm reminder theo khung giờ (mục 3–4) = Flow 2, đã trong scope test ngay** (cùng nhóm với
  [file read-flow](./ai-assistant-read-flow-testdata.md)) — dùng lại **Persona A** (lịch ngày 2026-09-17) làm
  ground truth, chỉ đổi câu hỏi sang hỏi theo **khung giờ cụ thể** thay vì "hôm nay"/"chiều nay" chung chung.
- Ngôn ngữ mặc định trong file này: **tiếng Việt**. Nếu cần dịch sang bộ 6 ngôn ngữ đã làm ở
  [mục 6 file read-flow](./ai-assistant-read-flow-testdata.md#6-test-data-đa-ngôn-ngữ--en--vi--ja--th--zh-hant--zh-hans--ko),
  báo lại — chưa làm ở đây để tránh nhân bản không cần thiết trước khi biết có cần không.

---

## 1. Tạo Event — `NLP-CE`

Đối chiếu Action Map: card này gọi `CalendarService.createEvent(_:)` ([PRD §2.0](../specs/ai-assistant/ai-chat-tab-prd.md#20-nguyên-tắc-bắt-buộc-mọi-action--wrapper-của-một-action-đã-có-trong-app)).
Field kỳ vọng trên Interactive Event Card: **Title / Date / Time (start–end) / Location / Notes**.

| ID | Câu input | Title kỳ vọng | Date | Time | Location | Notes | Rủi ro / điều cần quan sát | Mức |
|---|---|---|---|---|---|---|---|---|
| CE-01 | "Đặt lịch họp với Nam lúc 15h chiều mai tại phòng họp tầng 3" | Họp với Nam | 2026-09-18 (Thứ 6) | 15:00–? | Phòng họp tầng 3 | — | Không nói giờ kết thúc — xem CE-04/AST-E11 (default duration) | 🔴 |
| CE-02 | "Nhắc tôi gọi cho khách hàng lúc 9h sáng thứ 2 tuần sau" | Gọi cho khách hàng | 2026-09-21 (Thứ 2) | 09:00–? | — | — | Ý định là "nhắc" — kiểm tra AI đưa ra **Event Card** hay **Reminder Card**; PRD không phân định rạch ròi ranh giới 2 loại khi câu dùng từ "nhắc tôi" cho việc có mốc giờ cụ thể — ghi nhận, không đoán trước loại card đúng | 🔴 |
| CE-03 | "Tối nay đi ăn với gia đình" | Đi ăn với gia đình | 2026-09-17 | thiếu giờ | — | — | Thiếu thời gian cụ thể → phải kích hoạt AC 4.3.1 (hỏi lại kèm chip giờ gợi ý), không tự bịa giờ | 🔴 |
| CE-04 | "3h chiều mai họp với sếp" | Họp với sếp | 2026-09-18 | 15:00–? | — | — | Chỉ có giờ bắt đầu — verify **default duration** được suy ra (bao nhiêu phút?) và so với form Create Event thủ công có bắt buộc chọn tay End time không — nếu khác nhau là lệch validation (đã nêu ở AST-E11 trong [checklist](../exploratory/12_ai-assistant.md#3--edge--ast-e)) | 🟠 |
| CE-05 | *(paste đoạn chat)* "Nam: 7h tối thứ 6 này qua nhà mình ăn lẩu nhé — Ngọc: ok đi" | Ăn lẩu ở nhà Nam *(hoặc tương đương)* | 2026-09-18 | 19:00–? | Nhà Nam | Có thể ghi lại đoạn hội thoại gốc vào Notes | Test paste flow (§2 Flow 1) — kiểm tra AI tách đúng người/giờ/địa điểm từ hội thoại 2 chiều, không lẫn tên người gửi vào Title | 🟠 |
| CE-06 | "Sáng mai họp team lúc 9h, chiều họp khách hàng lúc 2h" | *(2 event)* | 2026-09-18 | 09:00–? và 14:00–? | — | — | **Một câu chứa 2 ý định tạo event** — AI có tách thành 2 Card riêng không, hay chỉ lấy 1 và bỏ sót cái còn lại? PRD không có ví dụ multi-intent nào — ghi nhận hành vi thật, đây là case dễ bị bỏ sót khi build | 🔴 |
| CE-07 | "Tạo lịch họp ngày 25/9 lúc 10h30" | Họp | 2026-09-25 (Thứ 6) | 10:30–? | — | — | Ngày dạng số tuyệt đối (dd/mm) — verify không bị hiểu nhầm mm/dd (rủi ro locale ngày tháng kiểu Mỹ nếu backend dùng sai định dạng) | 🟠 |
| CE-08 | "Họp lúc 7 giờ" | Họp | hôm nay/ngày gần nhất hợp lý | 07:00 **hoặc** 19:00 — chưa rõ | — | — | Không rõ sáng/tối — phải kích hoạt hỏi lại (AC 4.3.1), **không tự chọn** một trong hai theo suy đoán (7h sáng đã qua trong ngày là gợi ý hợp lý nhưng vẫn nên hỏi, không tự quyết) | 🟠 |
| CE-09 | "Họp Zoom lúc 2h chiều nay, link zoom.us/abc-xyz" | Họp Zoom | 2026-09-17 | 14:00–? | zoom.us/abc-xyz *(lưu vào Location hay Notes?)* | — | Verify field chứa link — Location của EventKit thường là text tự do nên lưu được, nhưng cần xác nhận AI không cắt bớt/link-hoá sai | 🟡 |
| CE-10 | "Đặt lịch họp hôm qua lúc 3h chiều" | — | 2026-09-16 (đã qua) | — | — | — | **Ngày trong quá khứ** — AI nên hỏi lại xác nhận ("bạn muốn tạo sự kiện cho ngày đã qua?") thay vì âm thầm tạo event ở ngày cũ; PRD không nói tới case này — ghi nhận, đề xuất bổ sung AC nếu chưa có | 🟠 |

---

## 2. Tạo Reminder / Task — `NLP-CR`

Đối chiếu Action Map: gọi `ReminderService.createReminder(_:)` ([PRD §2.0](../specs/ai-assistant/ai-chat-tab-prd.md#20-nguyên-tắc-bắt-buộc-mọi-action--wrapper-của-một-action-đã-có-trong-app)).

| ID | Câu input | Task kỳ vọng | Due date/time kỳ vọng | Rủi ro / điều cần quan sát | Mức |
|---|---|---|---|---|---|
| CR-01 | "Nhắc tôi nộp báo cáo trước 5h chiều nay" | Nộp báo cáo | 2026-09-17, 17:00 | Happy path — verify Reminder Card hiện đúng, không lẫn thành Event Card | 🔴 |
| CR-02 | "Thêm việc: mua quà sinh nhật cho mẹ" | Mua quà sinh nhật cho mẹ | — (không có deadline) | Task **không có due date** — verify Reminder Card cho phép tạo task không hạn, không tự gán bừa 1 mốc giờ | 🟠 |
| CR-03 | "Nhắc tôi uống thuốc lúc 8h tối mỗi ngày" | Uống thuốc | 20:00, **lặp lại hàng ngày** | **Recurring reminder** — `ReminderService.createReminder` có hỗ trợ recurrence không? Nếu form thủ công của Ink hiện không cho chọn lặp lại, AI **không được tự bịa ra khả năng đó** (vi phạm nguyên tắc Action Map §2.0 "chỉ wrap action đã có") — verify đúng theo field form thủ công đang có, không hơn | 🔴 |
| CR-04 | "Việc cần làm: gọi điện xác nhận lịch hẹn nha sĩ trước thứ 6" | Gọi điện xác nhận lịch hẹn nha sĩ | trước 2026-09-18 (thứ 6 tuần này) | "Trước thứ 6" — verify due time cụ thể AI chọn (đầu ngày? cuối ngày thứ 6? 23:59?) — ghi nhận cách hiểu | 🟡 |
| CR-05 | "Note lại là cần renew hộ chiếu trong tháng này" | Renew hộ chiếu | trong tháng 09/2026 — mốc ngày cụ thể chưa rõ | Deadline rất mơ hồ ("trong tháng này") — kỳ vọng đúng: AI hỏi lại ngày cụ thể (AC 4.3.1 áp dụng tương tự cho task, không chỉ event) thay vì tự chọn bừa 1 ngày cuối tháng | 🟠 |
| CR-06 | "Tạo task ưu tiên cao: fix bug production" | Fix bug production | — | **Priority field** — verify `ReminderService.createReminder` có field priority không; nếu không có, AI phải nói rõ không set được priority thay vì im lặng bỏ qua yêu cầu của user | 🟡 |

### 2.1. Nhập nhằng Event vs Task — `NLP-AMB` *(bổ sung 2026-09-17, phát hiện qua ảnh chụp thiết bị thật)*

Ảnh QC cung cấp cho thấy AI từng hỏi lại: *"I can add Tập gym 1 for Thu, 17 Sep at 21:00 — as an event, or as
a task."* — tức khi câu lệnh không có động từ rõ ràng chỉ loại card (không phải "nhắc tôi…" cũng không phải
"đặt lịch…"), AI **chủ động hỏi lại loại Card** thay vì tự đoán. Đây là case chưa có trong CE-01→10/CR-01→06
(toàn bộ case cũ đều dùng động từ rõ ý định) — bổ sung riêng để phủ đúng nhánh này.

| ID | Câu input | Vì sao mơ hồ | Kỳ vọng | Rủi ro nếu sai | Mức |
|---|---|---|---|---|---|
| AMB-01 | "Tập gym lúc 9h tối" *(không có động từ "nhắc"/"đặt lịch"/"tạo task")* | Không có tín hiệu ngôn ngữ nào phân biệt event/task | AI hỏi lại "muốn thêm dưới dạng event hay task?" — đúng như ảnh quan sát được | Nếu AI tự đoán 1 loại mà user không muốn — vd đoán Event trong khi user muốn Task để tick hoàn thành — user phải xoá làm lại | 🟠 |
| AMB-02 | "Họp với Nam" *(không giờ, không rõ event hay task)* | Vừa thiếu giờ (AC 4.3.1) vừa mơ hồ loại card — 2 loại ambiguity cùng lúc | Ghi nhận AI hỏi cái nào trước (giờ hay loại card), hay hỏi gộp 1 lần — case chưa có tiền lệ trong PRD, đo hành vi thật, không đoán trước đúng/sai | 🟡 |
| AMB-03 | Sau AMB-01, user trả lời "task" | — | Reminder Card đúng "Tập gym", due hôm nay 21:00 — verify AI giữ đúng field đã parse được từ câu gốc (giờ 21:00), không hỏi lại từ đầu | 🟠 |

---

## 3. Tìm Event theo khung giờ trong ngày — `NLP-FE`

Dùng **Persona A** ([read-flow mục 3.1](./ai-assistant-read-flow-testdata.md#31-persona-a--lịch-dày-đặc-hôm-nay-thứ-5-2026-09-17)),
lịch ngày 2026-09-17: Standup 09:00–09:30 · 1:1 Manager 10:00–11:00 · Gọi khách hàng ABC Corp 11:30–12:30 ·
Ăn trưa 13:00–14:30 · Team Sync 17:00–18:00.

| ID | Câu hỏi | Khung giờ hỏi | Ground truth rõ ràng | Case biên cần ghi nhận (không đoán trước) | Mức |
|---|---|---|---|---|---|
| FE-01 | "Từ 9h đến 12h trưa nay tôi có lịch gì?" | [09:00, 12:00] | Standup, 1:1 Manager — chắc chắn nằm trọn trong khung | "Gọi khách hàng ABC Corp" (11:30–12:30) chỉ **giao một phần** với khung hỏi — AI có liệt kê event overlap một phần không, hay chỉ lấy event nằm trọn? PRD không định nghĩa | 🟠 |
| FE-02 | "Buổi sáng nay tôi có mấy cuộc họp?" | ngầm định "sáng" | Standup, 1:1 Manager — chắc chắn tính là sáng | "Gọi khách hàng" (11:30–12:30) — AI coi 11:30 là "sáng" hay đã tính "trưa"? Ranh giới "buổi sáng" theo giờ nào chưa được PRD định nghĩa | 🟡 |
| FE-03 | "Sau 2h chiều nay tôi còn lịch gì không?" | (14:00, hết ngày] | Team Sync 17:00–18:00 — chắc chắn có | "Ăn trưa" (13:00–14:30) đang diễn ra tại mốc 14:00 (bắt đầu trước, kết thúc sau) — có được tính là "sau 2h chiều" không? | 🟠 |
| FE-04 | "Trước 10h sáng nay tôi có gì không?" | [00:00, 10:00) | **Chỉ** Standup (09:00–09:30) — boundary sạch, "1:1 Manager" bắt đầu đúng 10:00 nên **không** được tính | Nếu AI liệt kê cả "1:1 Manager" là bug sai boundary (giống lỗi 29/30/31 phút ở free-slot) | 🔴 |
| FE-05 | "Tối nay tôi có lịch gì không?" | ngầm định "tối" (thường hiểu sau 18h) | Không có event nào sau 18:00 → kỳ vọng đúng: "Không có lịch tối nay" | "Team Sync" kết thúc **đúng** 18:00 — AI có nhầm xếp vào "tối" không (nó là ranh giới chiều muộn/tối rất phổ biến gây hiểu lầm) | 🟠 |
| FE-06 | "Giờ là 4h chiều, tôi còn việc gì hôm nay không?" *(cố định mốc "giờ" ngay trong câu hỏi để tránh phụ thuộc giờ máy lúc test)* | (16:00, hết ngày] | Team Sync 17:00–18:00 — chắc chắn có, và chỉ có đúng 1 event này | Verify AI không liệt lại các event đã qua (Standup, 1:1, Gọi khách hàng, Ăn trưa) — bịa "còn việc" cho việc đã xong là bug rõ ràng | 🔴 |

---

## 4. Tìm Reminder theo khung giờ trong ngày — `NLP-FR`

Dùng **Persona A**, reminders: "Nộp báo cáo tuần" due hôm nay 18:00 · "Gửi invoice cho ABC Corp" due hôm nay
17:00 — cả 2 chưa hoàn thành ([read-flow mục 3.1](./ai-assistant-read-flow-testdata.md#31-persona-a--lịch-dày-đặc-hôm-nay-thứ-5-2026-09-17)).

**Bổ sung riêng cho file này** (không đổi ground truth "2 task hôm nay" đã dùng ở
[read-flow mục 4](./ai-assistant-read-flow-testdata.md#4-bảng-câu-hỏi-test-tổng-hợp) vì task dưới đây due
**hôm qua**, khác ngày):

| Task | Due | Trạng thái |
|---|---|---|
| Trả lời email đối tác | 2026-09-16 (hôm qua), 17:00 | Chưa hoàn thành — **quá hạn** |

| ID | Câu hỏi | Khung giờ hỏi | Ground truth | Case biên cần ghi nhận | Mức |
|---|---|---|---|---|---|
| FR-01 | "Hôm nay tôi có việc gì cần làm trước 6h chiều không?" | (–, 18:00) strict trước | **Chỉ** "Gửi invoice" (17:00) | "Nộp báo cáo" due **đúng** 18:00 — "trước 6h chiều" có tính luôn mốc 18:00 không? Nếu AI liệt cả 2 task, verify có đúng ý "trước" (strict <) theo cách hiểu tự nhiên hay không — boundary giống case 29/30/31 phút | 🔴 |
| FR-02 | "Giờ là 4h chiều, việc nào tôi cần làm gấp trong 2 tiếng tới?" | [16:00, 18:00] | Cả 2: "Gửi invoice" (17:00) và "Nộp báo cáo" (18:00, đúng biên cuối — inclusive) | Nếu AI bỏ sót "Nộp báo cáo" vì rơi đúng mốc 18:00 (biên trên) là bug sai boundary | 🟠 |
| FR-03 | "Tôi có việc gì quá hạn chưa làm không?" | quá hạn tính tới hôm nay | **Chỉ** "Trả lời email đối tác" (quá hạn từ hôm qua) — **không** gồm 2 task due hôm nay (chưa quá hạn) | Nếu AI liệt cả task due hôm nay (18:00, 17:00 — chưa tới giờ) vào "quá hạn" là bug nghiêm trọng (báo sai tình trạng, có thể khiến user hoảng vì tưởng trễ việc chưa tới hạn) | 🔴 |
| FR-04 | "Sáng nay tôi cần làm gì không?" | buổi sáng (trước 12:00) | Không có task nào due buổi sáng → "Không có" | Verify AI không kéo nhầm "Trả lời email đối tác" (due hôm qua, không phải sáng nay) vào câu trả lời | 🟠 |

---

## 5. Ghi chú chung khi chạy bộ case này

- **FE-01/FE-03 (event giao một phần khung giờ) và "buổi sáng/tối" ở FE-02/FE-05** là case **đo hành vi thật,
  không có đáp án định trước** — đúng tinh thần persona D/F ở file read-flow: ghi lại nguyên văn câu trả lời,
  không tự gán PASS/FAIL theo một cách hiểu tự chọn, rồi báo lại để chốt thành AC chính thức nếu cần.
- **CE-06 (multi-intent trong 1 câu)** nên chạy sớm — đây là loại lỗi dễ bị bỏ sót nhất khi build vì phần lớn
  ví dụ trong PRD chỉ có 1 ý định/câu.
- **CR-03 (recurring reminder)** — trước khi báo bug "AI không tạo được nhắc lặp lại", xác nhận trước xem form
  Create Reminder thủ công của Ink hiện có field lặp lại hay không (đúng nguyên tắc Action Map §2.0: Assistant
  không được có khả năng vượt quá form thủ công).
- Toàn bộ case "Tạo Event/Tạo Reminder" ở mục 1–2: nếu chạy được tới bước bấm "Lưu" thật, luôn đối chiếu lại
  Apple Calendar/Reminders gốc theo đúng nguyên tắc ở
  [read-flow mục 5](./ai-assistant-read-flow-testdata.md#5-cách-seed-data-vào-thiết-bị-test) — không tin trạng
  thái "Đã lưu" hiển thị trên Card.
