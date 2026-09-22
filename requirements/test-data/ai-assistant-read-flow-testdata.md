# Test Data — AI Assistant, khả năng đọc lịch (Flow 2, LLM qua BE)

> **Lý do có file này:** theo thông tin từ QC (2026-09-17), phần AI Assistant đã có **BE thật + LLM tích hợp
> hoàn chỉnh**, đọc data event từ lịch của user và trả lời — tức **Flow 2 (Daily Brief & Free Slot Finder)**
> và AC §4.1 (Khả năng đọc) của [ai-chat-tab-prd.md](../specs/ai-assistant/ai-chat-tab-prd.md) đã chạy thật, không còn chỉ
> nằm trên giấy như lúc [test plan](../test-plans/ai-assistant/ai-assistant-tab.md) và
> [checklist](../exploratory/12_ai-assistant.md) được viết (2026-09-11, lúc đó PRD còn Draft, flow đánh dấu
> 🚧 chưa build ở [screenshot-naming.md §7](../../.claude/rules/screenshot-naming.md)).
> **Phạm vi file này:** chỉ test data cho **đọc + trả lời** (Flow 2, AC 4.1.1–4.1.3). **Không** gồm test data
> ghi (Flow 1 tạo event/task, Flow 3 quote) — chưa có xác nhận phần ghi đã build; xem mục 0.2.
> **Ngày lập:** 2026-09-17 · **Người lập:** QC

---

## 0. Phân tích trước khi dùng bộ data này

### 0.1. Việc build đã "vượt" tài liệu ở đâu — cần đối chiếu lại, không tự suy diễn

Test plan hiện tại viết dựa trên giả định PRD còn Draft. Tin "BE + LLM đã tích hợp xong phần đọc" kéo theo vài
việc cần làm rõ **trước khi** dùng bộ test data này để test thật trên build, không phải sau:

| # | Vấn đề | Vì sao quan trọng |
|---|---|---|
| 1 | 🔴 **Entry criteria ở [test plan §8](../test-plans/ai-assistant/ai-assistant-tab.md#8-entry-criteria)** đòi hỏi hợp đồng zero-data-retention (ZDR) với nhà cung cấp LLM đã ký (Open Question #1) — nếu chưa, **không được test bằng calendar/reminder thật của tài khoản QC thật**, phải dùng tài khoản/dữ liệu giả lập. Việc BE đã "chạy được" không đồng nghĩa hợp đồng ZDR đã ký — đây là 2 việc khác nhau, cần hỏi dev/PM riêng câu này trước khi seed data thật lên bất kỳ thiết bị nào. |
| 2 | 🟠 Cần xác nhận **AC 6.1 (Consent gate)** đã build cùng đợt hay chưa — nếu phần đọc chạy nhưng consent gate chưa có, đó tự nó là 1 bug P1 (đọc data trước khi hỏi ý user), không phải điều kiện tiên quyết bị thiếu. |
| 3 | 🟡 Câu hỏi mở **#6** (PRD §9) — `docs/ai-assist-scope.md` có bị supersede hay không — vẫn chưa có câu trả lời trong repo này (không tìm thấy file đó). Không ảnh hưởng trực tiếp tới test data đọc lịch, nhưng vẫn nên hỏi lại vì có thể chứa yêu cầu chưa đưa vào PRD. |
| 4 | 🟠 PRD không nói rõ **cửa sổ 7 ngày** (AC 4.1.1) là "168 giờ tính từ thời điểm hỏi" hay "hết ngày thứ 7 theo lịch". Hai cách tính cho kết quả khác nhau với event nằm cuối ngày thứ 7 / đầu ngày thứ 8 — bộ data ở mục 3.4 dựng đúng ranh giới này để lộ ra AI đang implement theo cách nào, **không đoán trước** cách nào đúng. |
| 5 | 🟡 PRD không nói **all-day event** có tính vào free/busy khi tìm free slot không (AC 4.1.2 chỉ nói "khoảng trống ≥30 phút", không loại trừ all-day). Bộ data mục 3.6 test riêng case này. |

> Khuyến nghị: trước khi chạy bộ data bên dưới, xác nhận với dev **build cụ thể** đã bật phần đọc trên
> môi trường nào (TestFlight/staging), và trạng thái ZDR contract — ghi kết quả vào
> [test plan mục 10](../test-plans/ai-assistant/ai-assistant-tab.md#10-open--phase-2-chưa-code--chưa-chốt) thay vì chỉ ở đây.

### 0.2. Vì sao chưa có test data cho Flow 1 / Flow 3 (ghi)

Yêu cầu gốc chỉ nói "lấy data event từ lịch và trả lời" — đúng mô tả của Flow 2 (đọc), không nhắc tới việc tạo
event/task hay đổi quote (Flow 1/3, cần ghi ngược lại Calendar/Reminders/wallpaper). Hai flow đó có action map
gọi thẳng `CalendarService.createEvent`, `ReminderService.*`, `CalendarTemplateEditorViewModel.*` — rủi ro cao
hơn hẳn (mất dữ liệu, ghi trùng — xem [test plan §6 nhóm P1](../test-plans/ai-assistant/ai-assistant-tab.md#6-risk-based-prioritization)).
Nếu phần ghi cũng đã build, cần một bộ test data riêng (event/task **kết quả sau khi AI ghi**, không phải input
đọc) — báo lại để mình làm tiếp, tránh gộp chung 2 loại rủi ro khác nhau vào 1 bộ data.

---

## 1. Nguyên tắc dựng bộ data

- Mỗi persona là **một trạng thái lịch** dựng sẵn để hỏi AI và biết trước đáp án đúng (ground truth) — đúng
  tinh thần "đối chiếu Apple Calendar, không tin UI" đã dùng xuyên suốt dự án
  ([exploratory-references §1.4](../../references/exploratory-references.md#14--đồng-bộ-2-chiều-với-apple-calendar--reminders-có-làm-mất-dữ-liệu-không)).
- Bao phủ đúng các kỹ thuật đã chốt ở [test plan mục 5](../test-plans/ai-assistant/ai-assistant-tab.md#5-kỹ-thuật-thiết-kế-test-case):
  Equivalence Partitioning (nguồn calendar, có/không permission), Boundary Value Analysis (cửa sổ 7 ngày, free
  slot 29/30/31 phút), và AC 4.1.3 (chỉ đọc calendar đang bật hiển thị).
- Ngày mốc: **hôm nay = Thứ 5, 2026-09-17** (giữ cố định trong toàn bộ file để câu hỏi/đáp án khớp nhau — đổi
  ngày chạy thật thì cộng/trừ lại theo đúng số ngày lệch, không đổi thứ tự logic).
- Dữ liệu giả lập 100%, không dùng tên/địa điểm/số điện thoại thật — theo đúng cảnh báo ở mục 0.1 (#1).

---

## 2. Danh sách persona (bộ lịch mẫu)

| Persona | Mục tiêu test | AC / kỹ thuật liên quan |
|---|---|---|
| A — Lịch dày đặc hôm nay | Daily brief đúng số lượng + tìm đúng khoảng rảnh lớn nhất buổi chiều | Flow 2, AC 4.1.2 |
| B — Lịch trống hoàn toàn | AI không bịa ra sự kiện, trả lời đúng "cả ngày rảnh" | Flow 2 |
| C — Nhiều nguồn calendar, có 1 nguồn bị ẩn | AI **không** được nhắc tới event của calendar đã tắt hiển thị | AC 4.1.3 (🔴 rủi ro rò rỉ data user đã chủ động ẩn) |
| D — Biên cửa sổ 7 ngày | Event nằm sát mép cửa sổ đọc — lộ ra cách BE tính "7 ngày tới" | AC 4.1.1, BVA |
| E — Biên free slot 29/30/31 phút | 3 khoảng trống đúng 29, 30, 31 phút liền nhau trong 1 ngày | AC 4.1.2, BVA (test plan mục 5) |
| F — All-day / recurring / lệch timezone nguồn | Event tạo ở timezone khác, event lặp lại, event cả ngày | AC 4.1.1 (gián tiếp), mục 0.1 (#4, #5) |
| G — Task trùng tên (Reminders) | Chuẩn bị sẵn cho bước match id khi Flow ghi được xác nhận build | AC 4.2.6 (chuẩn bị trước — chưa test được tới khi có ghi) |

---

## 3. Chi tiết từng persona

### 3.1. Persona A — Lịch dày đặc hôm nay (Thứ 5, 2026-09-17)

Calendar nguồn: EventKit "Công việc" — **hiển thị: Bật**.

| Giờ | Sự kiện | Loại |
|---|---|---|
| 09:00–09:30 | Daily Standup | Event |
| 10:00–11:00 | 1:1 với Manager | Event |
| 11:30–12:30 | Gọi khách hàng ABC Corp | Event |
| 13:00–14:30 | Ăn trưa + họp nhanh với team Design | Event |
| 17:00–18:00 | Team Sync | Event |

Reminders (list "Việc cần làm"):
| Task | Due | Trạng thái |
|---|---|---|
| Nộp báo cáo tuần | Hôm nay 18:00 | Chưa hoàn thành |
| Gửi invoice cho ABC Corp | Hôm nay 17:00 | Chưa hoàn thành |

**Ground truth suy ra được:**
- Tổng số event hôm nay: **5**.
- Khoảng trống ≥30 phút trong ngày: 09:30–10:00 (30p), 11:00–11:30 (30p), 12:30–13:00 (30p), **14:30–17:00 (150p)**.
- Khoảng trống lớn nhất buổi chiều (sau 12:00): **14:30–17:00**, ngay trước "Team Sync" — dựng khớp 1:1 với ví
  dụ trong [PRD Flow 2](../specs/ai-assistant/ai-chat-tab-prd.md#flow-2-tóm-tắt--tối-ưu-thời-gian-daily-brief--free-slot-finder):
  *"Chiều nay bạn trống từ 14:30 đến 17:00 trước cuộc họp Team Sync lúc 17h."*

### 3.2. Persona B — Lịch trống hoàn toàn (Thứ 6, 2026-09-18)

Không có event nào, không có reminder nào, trên bất kỳ calendar nào đang bật.

**Ground truth:** cả ngày rảnh (00:00–23:59, hoặc theo giờ làm việc nếu AI có giới hạn khung giờ gợi ý —
nếu có giới hạn đó thì đây là hành vi cần ghi lại, PRD không nói tới khung giờ làm việc).

### 3.3. Persona C — Nhiều nguồn calendar, 1 nguồn bị ẩn (Thứ 7, 2026-09-19)

| Nguồn | Hiển thị (`InkCalendarVisibilityStore`) | Sự kiện |
|---|---|---|
| EventKit "Cá nhân" | Bật | 10:00–11:00 Đi cafe với bạn |
| Google "work@company.com" | Bật | 14:00–15:00 Workshop nội bộ |
| Outlook "Team Sync" | **Tắt** | 15:00–16:00 Review lương (nội dung nhạy cảm) |

**Ground truth:** khi hỏi "Ngày mai (thứ 7) tôi có lịch gì?", AI **chỉ được liệt kê 2 event** của Cá nhân +
Google. **Tuyệt đối không được nhắc tới** "Review lương" — nếu AI nhắc tới, đây là bug 🔴 vi phạm AC 4.1.3 và
là rò rỉ dữ liệu user đã chủ động ẩn, mức độ nghiêm trọng tương đương nhóm P1 ở test plan (dù AC 4.1.3 hiện
xếp ở mục "khả năng đọc" chứ chưa được test plan liệt vào bảng risk P1 — QC nên đề xuất nâng mức case này lên
P1 khi cập nhật lại test plan, vì hậu quả là lộ nội dung calendar user không muốn AI thấy).

### 3.4. Persona D — Biên cửa sổ đọc "7 ngày tới" (từ Thứ 5, 2026-09-17)

| Ngày | Giờ | Sự kiện | Vị trí so với cửa sổ |
|---|---|---|---|
| Thứ 5, 2026-09-24 (ngày +7) | 23:00–23:30 | Sát mép cuối — trong cửa sổ | Biên trong |
| Thứ 6, 2026-09-25 (ngày +8) | 00:30–01:00 | Ngay sau mép — ngoài cửa sổ theo nghĩa "7 ngày" | Biên ngoài |

**Câu hỏi test:** "Tuần sau tôi có lịch gì không?" hoặc "Từ giờ đến hết tuần sau có gì không?".
**Việc cần ghi nhận (không có "đúng/sai" định trước — đây là case đo hành vi thật, xem mục 0.1 #4):**
AI có nhắc tới event ngày +7 (23:00) không? Có nhắc tới event ngày +8 (00:30) không? Kết quả quan sát được
chính là câu trả lời cho câu hỏi mở "168 giờ rolling hay hết ngày thứ 7 theo lịch" — ghi lại nguyên văn cách
BE trả lời, đừng suy diễn PASS/FAIL theo một cách hiểu tự chọn.

### 3.5. Persona E — Biên free slot 29 / 30 / 31 phút (Chủ nhật, 2026-09-20)

| Giờ | Sự kiện | Khoảng trống sau đó |
|---|---|---|
| 08:00–09:00 | Event M1 | → 09:00–09:29 = **29 phút** |
| 09:29–10:00 | Event M2 | → 10:00–10:30 = **30 phút** |
| 10:30–11:00 | Event M3 | → 11:00–11:31 = **31 phút** |
| 11:31–12:00 | Event M4 | (hết case) |

**Ground truth (theo AC 4.1.2 "tối thiểu 30 phút"):**
- 09:00–09:29 (29p) → **KHÔNG** được tính là free slot.
- 10:00–10:30 (30p) → **PHẢI** được tính là free slot (biên dưới, inclusive).
- 11:00–11:31 (31p) → **PHẢI** được tính là free slot.

Đây là bộ dựng thẳng từ BVA đã chốt ở [test plan mục 5](../test-plans/ai-assistant/ai-assistant-tab.md#5-kỹ-thuật-thiết-kế-test-case)
— nếu AI báo "rảnh lúc 9h" (dựa trên khoảng 29 phút) là bug 🟡 sai boundary.

### 3.6. Persona F — All-day / recurring / lệch timezone nguồn (Thứ 2 → Thứ 4, 21→23/09)

| Ngày | Sự kiện | Loại | Ghi chú |
|---|---|---|---|
| Thứ 7, 2026-09-19 | "Nghỉ lễ" | All-day event | Không có giờ bắt đầu/kết thúc cụ thể |
| Thứ 3, 2026-09-22 | "Đá bóng" 19:00–21:00 | Recurring (hàng tuần, thứ 3) | Instance trong tuần đang xét |
| Thứ 4, 2026-09-23 | "Gọi khách hàng Mỹ" | Event tạo lúc thiết bị ở timezone New York (EDT, UTC-5), lưu **22:00 EDT 2026-09-22** | Quy đổi sang giờ máy hiện tại (giả định ICT, UTC+7) phải hiển thị **09:00 sáng 2026-09-23** |

**Câu hỏi test:**
- "Thứ 7 này tôi có lịch gì?" → phải nhắc tới "Nghỉ lễ" là sự kiện cả ngày (không phải giờ cụ thể — kiểm tra
  AI có bịa giờ bắt đầu/kết thúc cho all-day event không).
- "Tôi có rảnh chiều thứ 7 không?" → **case cần ghi nhận, không đoán trước:** all-day event có chặn hết ngày
  (báo bận cả ngày) hay bị bỏ qua khi tính free slot (báo rảnh cả ngày dù có nghỉ lễ)? Xem mục 0.1 (#5).
- "Thứ 4 tuần này tôi có lịch gì buổi sáng?" → phải trả lời **09:00** (giờ máy hiện tại), không phải 22:00 (giờ
  gốc lúc tạo) và không phải hiển thị nhầm ngày 22/09 — nếu sai đây là bug quy đổi timezone, liên quan trực
  tiếp tới nguyên tắc "chiều mai/thứ 7 resolve theo timezone thiết bị" ở AC 4.3.3 (AC đó viết cho input, nhưng
  cùng rủi ro áp dụng cho output khi đọc event có nguồn timezone khác).

### 3.7. Persona G — Reminders trùng tên (chuẩn bị trước cho Flow ghi)

| ID (giả lập) | Task | Due |
|---|---|---|
| R-1001 | Nộp báo cáo | Hôm nay 2026-09-17 |
| R-1002 | Nộp báo cáo | Thứ 6 2026-09-18 |

Chưa test được hành động xoá/hoàn thành (Flow ghi chưa xác nhận build — mục 0.2), nhưng **đọc** đã test được
ngay: hỏi "Tôi có việc gì tên 'Nộp báo cáo'?" → AI phải liệt kê **cả 2**, phân biệt được theo due date, không
gộp thành 1 hoặc chỉ trả lời 1 cái.

---

## 4. Bảng câu hỏi test tổng hợp

| # | Persona | Câu hỏi gõ vào Assistant | Kết quả đúng kỳ vọng | Mức |
|---|---|---|---|---|
| 1 | A | "Lịch hôm nay ra sao?" | Đúng 5 event, đúng thứ tự giờ | 🔴 |
| 2 | A | "Chiều nay tôi rảnh lúc nào?" | 14:30–17:00 (không chỉ liệt kê khoảng nhỏ buổi sáng) | 🔴 |
| 3 | A | "Việc cần làm gấp hôm nay?" | 2 task, đúng deadline | 🟠 |
| 4 | B | "Ngày mai tôi có lịch gì?" (hỏi cho 18/09) | "Không có lịch" — không bịa event | 🔴 |
| 5 | C | "Thứ 7 này tôi có lịch gì?" | Chỉ 2 event (Cá nhân + Google), **không** có "Review lương" | 🔴 |
| 6 | D | "Tuần sau có lịch gì không?" | Ghi nhận nguyên văn — xem mục 3.4 | 🟠 |
| 7 | E | "Sáng chủ nhật tôi rảnh lúc nào?" | Chỉ báo 10:00–10:30 và 11:00–11:31, **không** báo 09:00–09:29 | 🟡 |
| 8 | F | "Thứ 7 này tôi có lịch gì?" | Nhắc "Nghỉ lễ" là sự kiện cả ngày, không bịa giờ | 🟠 |
| 9 | F | "Tôi có rảnh chiều thứ 7 không?" | Ghi nhận nguyên văn — xem mục 3.6 | 🟠 |
| 10 | F | "Thứ 4 tuần này buổi sáng tôi có gì?" | Báo đúng 09:00 giờ máy, đúng ngày 23/09 | 🔴 |
| 11 | G | "Tôi có việc gì tên 'Nộp báo cáo' không?" | Liệt kê cả 2, phân biệt theo due date | 🟠 |

---

## 5. Cách seed data vào thiết bị test

- Dùng **tài khoản/thiết bị test riêng**, không dùng calendar cá nhân thật của QC — bắt buộc theo mục 0.1 (#1)
  cho tới khi có xác nhận ZDR.
- Event EventKit: tạo trực tiếp qua app Calendar gốc của iOS (không qua Ink) để đảm bảo AI đang đọc đúng
  nguồn thật, không phải cache riêng của Ink.
- Event Google/Outlook (Persona C): cần tài khoản test đã nối theo đúng hướng dẫn ở
  [login-account-deep-dive.md](../test-plans/login-and-calendar-sharing/login-account-deep-dive.md) — dùng account test đã có sẵn ở đó
  nếu còn hiệu lực, không tạo account mới trùng lặp.
- Sau khi hỏi AI, luôn **mở lại Apple Calendar/Reminders gốc để đối chiếu** trước khi kết luận PASS/FAIL —
  không tin câu trả lời hiển thị trên chat, đúng nguyên tắc xuyên suốt dự án.
- Ghi lại **nguyên văn** câu trả lời của AI cho mục 3.4 và 3.6 (case chưa có "đúng/sai" định trước) — dán vào
  test plan mục 10 hoặc báo lại để cập nhật PRD.

---

## 6. Test data đa ngôn ngữ — EN / VI / JA / TH / ZH-Hant / ZH-Hans / KO

### 6.0. Cần xác nhận trước khi tính kết quả là PASS/FAIL

| # | Vấn đề | Ảnh hưởng |
|---|---|---|
| 1 | 🟠 [Test plan mục 10](../test-plans/ai-assistant/ai-assistant-tab.md#10-open--phase-2-chưa-code--chưa-chốt) đã tự ghi nhận: PRD nói "đủ 11 ngôn ngữ" nhưng **không liệt kê tên cụ thể** của 11 ngôn ngữ đó. Cần hỏi dev/PM xem 6 ngôn ngữ được yêu cầu (en/vi/ja/th/zh-Hant/zh-Hans/ko) có **nằm trong 11** hay không, trước khi coi lỗi chrome (chip/nút/empty state) ở ngôn ngữ nào đó là bug — nếu ngôn ngữ đó nằm ngoài 11, chrome chưa dịch là **đúng thiết kế**, không phải bug. |
| 2 | 🟠 [PRD §5.2](../specs/ai-assistant/ai-chat-tab-prd.md#52-model--đơn-giá) chỉ cam kết có eval set NLP cho **tiếng Việt + tiếng Anh**. **JA/TH/ZH-Hant/ZH-Hans/KO đều thuộc nhóm 9 ngôn ngữ chưa có eval** (test plan gọi đây là "coverage gap thật sự", xem AST-E10 ở [checklist](../exploratory/12_ai-assistant.md#3--edge--ast-e)). → Kết quả đọc lịch/NLP cho 5 ngôn ngữ này chạy theo kiểu **exploratory, ghi nhận nguyên văn**, không đặt ngưỡng pass/fail độ chính xác ngang Việt/Anh cho tới khi có xác nhận từ dev. |
| 3 | 🟡 Cần hỏi dev **mã locale chính xác** app dùng cho tiếng Trung — `zh-Hant`/`zh-Hans` hay `zh-TW`/`zh-CN`/`zh-HK` — để test đúng bundle `.xcstrings`, tránh trường hợp app chỉ có 1 biến thể Trung mà QC tưởng có 2. |
| 4 | 🟡 AC 4.5.4: locale nào **không được Apple Speech hỗ trợ** phải ẩn nút mic. Danh sách cụ thể chưa có trong PRD (đã flag ở test plan mục 10) — cần verify riêng cho **Thái** (locale ít phổ biến hơn, rủi ro Speech framework không hỗ trợ cao hơn 5 ngôn ngữ còn lại). |

### 6.0.1. Cập nhật quan trọng (2026-09-17) — dựa trên ảnh chụp thiết bị thật QC cung cấp

QC xác nhận qua ảnh chụp thật: **không cần đổi ngôn ngữ hệ thống iOS** để test câu trả lời AI bằng ngôn ngữ
khác — phần chat đã chuyển **100% sang LLM**, gõ ngôn ngữ nào AI trả lời đúng ngôn ngữ đó ngay trên cùng 1
thiết bị, kể cả xen kẽ nhiều ngôn ngữ trong **cùng một thread** (ảnh thực tế cho thấy 1 đoạn chat có tiếng
Anh ("I can add Tập gym 1 for Thu, 17 Sep..."), tiếng Việt ("Tạo task giặt sấy quần áo lúc 3pm ngày mai"), rồi
tiếng Nhật ("今日の予定を教えて") nối tiếp nhau — AI trả lời đúng ngôn ngữ của từng câu hỏi, không dính ngôn ngữ
câu trước). Điều này **đơn giản hoá đáng kể** phần setup ở mục 6.3 cho việc test **nội dung trả lời của AI**
— nhưng đặt lại câu hỏi cho phần **chrome**:

- Trong đúng ảnh đó, chrome (label "Due", "Added to your Reminders", nút "Assist"/"How to") **vẫn cố định
  tiếng Anh** dù 2 tin nhắn liền kề là tiếng Việt và tiếng Nhật — tức chrome **không** đổi theo từng tin nhắn
  như câu trả lời AI. Có 1 icon cờ (🇺🇸) ở header, nghi là **language switcher cấp app**, tách biệt khỏi cả
  (a) ngôn ngữ hệ thống iOS lẫn (b) ngôn ngữ user vừa gõ.
- → **Decision Table 3 gốc** (chrome theo *ngôn ngữ hệ thống iOS*, câu trả lời theo *input*, dùng làm nền cho
  toàn bộ mục 6.2 bên dưới) **có thể đã lỗi thời** so với kiến trúc thật sau khi chuyển 100% sang LLM. Giả
  thuyết mới cần verify trên thiết bị: chrome theo **1 setting chọn tay trong app** (icon cờ), câu trả lời AI
  theo **input của từng tin nhắn** — cả hai **độc lập với Settings ngôn ngữ iOS**. Đây là giả thuyết dựa trên
  **1 ảnh chụp**, chưa phải kết luận chính thức — mục 6.2 giữ nguyên bên dưới làm bộ case dự phòng (đề phòng
  app vẫn còn đọc OS language ở đâu đó), nhưng ưu tiên chạy mục 6.4 (mới) trước để xác nhận cơ chế thật.
- 🟡 **Quan sát phụ, cần verify riêng, chưa kết luận:** tin nhắn tiếng Nhật trong ảnh hiển thị dạng
  `"今日の予定を教えて""今日の予定を教えて"` — nội dung lặp lại 2 lần dính liền trong cùng 1 bong bóng chat. Có thể
  là lỗi double-submit / lỗi nối chuỗi lúc gửi, cũng có thể chỉ là cách paste lúc chụp ảnh demo — không suy
  diễn là bug thật cho tới khi tái hiện được. Thêm case: gõ 1 câu, bấm Send 2 lần liên tiếp thật nhanh, kiểm
  tra bong bóng chat của **user** (khác với AST-N01 vốn chỉ nói về double-tap nút "Lưu vào Lịch" trên Card,
  chưa nói tới double-submit ở khung nhập) có bị nhân đôi nội dung không.
- Ảnh cũng xác nhận thêm 2 việc ngoài phạm vi ngôn ngữ, ghi nhận tiện thể: (a) **Flow tạo Reminder (ghi) đã
  chạy thật** — "Tạo task giặt sấy quần áo lúc 3pm ngày mai" ra đúng "Giặt sấy quần áo, Due Fri 18 Sep 15:00",
  cập nhật lại caveat "chưa xác nhận build" ở
  [file create-find](./ai-assistant-create-find-testdata.md#0-khung-áp-dụng); (b) AI có hỏi lại **loại Card**
  ("as an event, or as a task") khi câu lệnh không rõ ý định event hay task — case chưa có trong bộ
  `NLP-CE`/`NLP-CR`, xem case mới AMB-01 ở file đó.

### 6.1. Câu hỏi test dịch sang từng ngôn ngữ (dùng lại ground truth đã dựng ở mục 3)

Giữ nguyên bộ dữ liệu lịch (Persona A, C) — chỉ đổi **ngôn ngữ của câu hỏi**, để tách riêng lỗi "NLP hiểu sai
ý" khỏi lỗi "dữ liệu lịch sai" đã test ở mục 4.

| Ngôn ngữ | Q1 — Daily brief (persona A, kỳ vọng 5 event) | Q2 — Free slot (persona A, kỳ vọng 14:30–17:00) | Q3 — Relative date (persona C, kỳ vọng 2 event, ẩn "Review lương") |
|---|---|---|---|
| VI (đối chứng) | "Lịch hôm nay ra sao?" | "Chiều nay tôi rảnh lúc nào?" | "Thứ 7 này tôi có lịch gì?" |
| EN | "What's on my schedule today?" | "When am I free this afternoon?" | "What's on my schedule this Saturday?" |
| JA | "今日の予定を教えて" | "今日の午後、いつ空いていますか？" | "今週の土曜日は何か予定がありますか？" |
| TH | "วันนี้ฉันมีนัดอะไรบ้าง" | "บ่ายนี้ฉันว่างช่วงไหนบ้าง" | "วันเสาร์นี้ฉันมีนัดอะไรไหม" |
| ZH-Hant (phồn thể) | "我今天有什麼行程？" | "我今天下午什麼時候有空？" | "這週六我有什麼行程嗎？" |
| ZH-Hans (giản thể) | "我今天有什么日程？" | "我今天下午什么时候有空？" | "这周六我有什么日程吗？" |
| KO | "오늘 제 일정이 어떻게 되나요?" | "오늘 오후에 언제 한가해요?" | "이번 주 토요일에 일정이 있나요?" |

> Bản dịch trên là bản dịch tham khảo để chuẩn bị data, **không phải chuỗi literal đã được duyệt bởi
> native speaker** — nếu team có bản dịch chính thức (vd từ cùng nguồn dịch `Localizable.xcstrings`), ưu tiên
> dùng bản đó để câu hỏi tự nhiên đúng văn phong bản địa, tránh false positive vì câu hỏi nghe "dịch máy".

**Đo gì cho mỗi ô:** (a) AI có hiểu đúng ý định (đọc lịch/tìm giờ rảnh) không — vẫn hiểu dù ngữ pháp lạ; (b)
kết quả trả lời có khớp ground truth ở mục 3.1/3.3 không; (c) AI trả lời **bằng đúng ngôn ngữ user vừa gõ**
(AC 4.5.2), không lẫn sang tiếng Việt hay tiếng Anh.

### 6.2. [Dự phòng] Ma trận ngôn ngữ nhập × ngôn ngữ hệ thống (rủi ro "card lai" — Decision Table 3 gốc)

> ⚠️ Xem mục 6.0.1 — bảng này dựng theo giả thuyết **chrome đọc theo Settings ngôn ngữ iOS**, giả thuyết đó
> đang bị nghi lỗi thời sau khi chuyển 100% sang LLM. Chỉ chạy bộ này **nếu** mục 6.4 xác nhận app vẫn còn
> đọc OS language ở một phần chrome nào đó; nếu mục 6.4 xác nhận chrome hoàn toàn theo icon cờ (app-level),
> bảng này không còn áp dụng — thay bằng bảng ở mục 6.4.2.

Theo đúng yêu cầu test plan §7: mỗi ngôn ngữ cần tối thiểu 1 cặp **giống nhau** (baseline, không rủi ro) và 1
cặp **khác nhau** (nơi bug từng xảy ra thật ở Ink 1.2.14 — "Allow kalender access").

| # | Ngôn ngữ nhập | Ngôn ngữ hệ thống máy | Loại | Kỳ vọng |
|---|---|---|---|---|
| 1 | EN | EN | Baseline | Chrome + câu trả lời đều tiếng Anh |
| 2 | EN | VI | 🔴 Mismatch | Chrome (chip/nút/quota) tiếng Việt, câu trả lời AI tiếng Anh — **ghi lại xem có bị lai không** |
| 3 | JA | JA | Baseline | Chrome + câu trả lời đều tiếng Nhật |
| 4 | JA | VI | 🔴 Mismatch | Như #2, đổi sang Nhật |
| 5 | TH | TH | Baseline | Chrome + câu trả lời đều tiếng Thái |
| 6 | TH | VI | 🔴 Mismatch | Như #2, đổi sang Thái |
| 7 | ZH-Hant | ZH-Hant | Baseline | Chrome + câu trả lời đều tiếng Trung phồn thể |
| 8 | ZH-Hant | VI | 🔴 Mismatch | Như #2, đổi sang Trung phồn thể |
| 9 | ZH-Hans | ZH-Hans | Baseline | Chrome + câu trả lời đều tiếng Trung giản thể |
| 10 | ZH-Hans | VI | 🔴 Mismatch | Như #2, đổi sang Trung giản thể |
| 11 | KO | KO | Baseline | Chrome + câu trả lời đều tiếng Hàn |
| 12 | KO | VI | 🔴 Mismatch | Như #2, đổi sang Hàn |
| 13 | ZH-Hant | ZH-Hans (hệ thống) | 🟡 Riêng cho tiếng Trung | Case đặc thù: 2 biến thể **cùng ngôn ngữ, khác chữ viết** — chrome hiện đúng giản thể (theo hệ thống) nhưng câu trả lời AI có tự chuyển sang phồn thể đúng theo input không, hay bị lẫn chữ giản thể vào câu trả lời phồn thể (và ngược lại)? Rủi ro **không tồn tại** ở 5 ngôn ngữ còn lại, riêng của cặp Hant/Hans |
| 14 | VI | EN | 🟡 Chiều ngược | Kiểm tra fallback AC 4.5.2 hoạt động đúng cả 2 chiều, không chỉ chiều "ngôn ngữ khác → hệ thống Việt" |

### 6.3. Việc cần chuẩn bị trên thiết bị test

- Đổi **Settings → General → Language & Region → iPhone Language** để đổi ngôn ngữ hệ thống thật (không chỉ đổi
  keyboard) — chrome app đọc theo setting này.
- Với ZH-Hant/ZH-Hans: bàn phím Trung trên iOS có 2 layout riêng biệt (Phồn thể/Giản thể) — chọn đúng layout
  tương ứng khi gõ, không gõ giản thể rồi kỳ vọng ra kết quả test phồn thể.
- Ghi lại **ảnh chụp màn hình** cho mỗi ô ở mục 6.2 có 🔴 — đây là bằng chứng trực tiếp cho case "card lai
  ngôn ngữ" nếu xảy ra, cùng loại bằng chứng đã yêu cầu ở AST-N08 trong checklist.
- Với TH: thử cả nhập bằng gõ và bằng Mic (nếu nút mic không bị ẩn) — verify riêng theo mục 6.0 (#4) trước khi
  báo bug "mic không hoạt động" vì rất có thể là locale không được hỗ trợ theo đúng thiết kế (ẩn nút mic).

### 6.4. [Ưu tiên chạy trước] Multi-turn nhiều ngôn ngữ trong cùng 1 thread + xác định icon cờ

Tái hiện đúng kịch bản đã quan sát được qua ảnh thật — **không cần đổi Settings ngôn ngữ iOS** cho phần này,
chỉ cần gõ trực tiếp bằng thiết bị đang ở ngôn ngữ mặc định (Việt hoặc Anh tuỳ máy QC).

#### 6.4.1. Kịch bản multi-turn (đúng thứ tự, trong cùng 1 thread, không Clear Chat giữa chừng)

| Bước | Gõ (giữ nguyên ngôn ngữ theo đúng thứ tự) | Kỳ vọng |
|---|---|---|
| 1 | Một câu tiếng Anh, ví dụ: "What's on my schedule today?" | AI trả lời tiếng Anh |
| 2 | Ngay sau đó, một câu tiếng Việt: "Tạo task giặt đồ lúc 3h chiều mai" | AI trả lời tiếng Việt, **không** bị dính tiếng Anh còn sót từ câu trước; Reminder Card tạo đúng field |
| 3 | Ngay sau đó, một câu tiếng Nhật: "今日の予定を教えて" | AI trả lời tiếng Nhật, **không** bị dính tiếng Việt/Anh |
| 4 | Quay lại tiếng Việt: "Cảm ơn nhé" | AI trả lời tiếng Việt — verify chuyển ngôn ngữ được **cả 2 chiều liên tục**, không chỉ 1 lần đầu thread |

**Đo gì:** (a) mỗi câu trả lời đúng ngôn ngữ của **chính câu hỏi đó**, không lệch theo câu liền trước; (b)
event/task được tạo/đọc ở bước 2 và 3 dùng **chung 1 ground truth** (đúng lịch thật), ngôn ngữ hỏi không làm
đổi kết quả dữ liệu — chỉ đổi ngôn ngữ diễn đạt; (c) lịch sử chat cuộn lại xem có hiển thị đúng, không vỡ thứ
tự tin nhắn 3 ngôn ngữ.

#### 6.4.2. Xác định icon cờ (language switcher nghi cấp app)

| Bước | Việc làm | Đo gì |
|---|---|---|
| 1 | Bấm vào icon cờ ở header | Có mở menu chọn ngôn ngữ không? Hay là chức năng khác (vd chọn định dạng ngày tháng US/VN)? — **không suy đoán trước**, ghi lại đúng UI hiện ra |
| 2 | Nếu có menu chọn ngôn ngữ, đổi sang 🇻🇳 | Chrome ("Due" → "Hạn", "Added to your Reminders" → tương đương tiếng Việt, "Assist"/"How to") có đổi theo không? |
| 3 | Sau khi đổi cờ, lặp lại bước 3 ở mục 6.4.1 (hỏi tiếng Nhật) | Câu trả lời AI có vẫn theo **input** (tiếng Nhật) hay bị ép theo cờ vừa chọn (tiếng Việt)? — đây là điểm mấu chốt phân biệt "cờ chỉ đổi chrome" hay "cờ đổi cả ngôn ngữ ưu tiên trả lời" |
| 4 | Kill app, mở lại | Lựa chọn cờ có được nhớ lại (persist) không, hay reset về mặc định |

**Nếu bước 1 xác nhận cờ đúng là app-level language switcher độc lập với OS:** viết lại AC 4.5.1 thành "chrome
theo lựa chọn trong app, mặc định theo hệ thống lần đầu mở" thay vì "chrome theo `Localizable.xcstrings` bám
Settings iOS" — báo lại để cập nhật PRD, đừng tự sửa AC trong tài liệu test data này.
