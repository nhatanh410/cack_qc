# Test Case Checklist — 12 AI Assistant (Phase 2, chưa build)

> **Nguồn:** [test plan ISTQB](../test-plans/ai-assistant/ai-assistant-tab.md) — chuyển trực tiếp từ mục 2/5/6 của test plan
> thành case cụ thể. **Không phải exploratory checklist theo nghĩa thông thường của dự án này** — flow này
> chưa có wireframe, chưa có screenshot, chưa build (`12_ai-assistant` đánh dấu 🚧 Phase 2 trong
> [screenshot-naming.md §7](../../.claude/rules/screenshot-naming.md)). Đây là **checklist chờ sẵn**, viết ra
> để không mất thời gian thiết kế case khi PRD chốt và feature build xong — không phải danh sách để bấm thử
> trên app hôm nay.
> **PRD:** [ai-chat-tab-prd.md](../specs/ai-assistant/ai-chat-tab-prd.md) v1.1 — Status Draft, chặn bởi §9.
> **Khung đánh giá:** [exploratory-references](../../references/exploratory-references.md)
> **Build:** _(chưa có — điền khi feature build xong và có TestFlight build đầu tiên)_ · **Thiết bị:** ____________ · **Người test:** ____________

---

## 0 · Framing

**Q1 — Mục tiêu user:** nhập lịch/task bằng ngôn ngữ tự nhiên (gõ/nói/paste) thay vì form nhiều bước, và hỏi
nhanh về lịch trình của chính mình — không phải chatbot hỏi đáp chung.

**Q8 — Mục tiêu business:** giảm ma sát tạo sự kiện (hiện 5–8 click/sự kiện theo PRD §1.1); đồng thời đây là
tính năng **duy nhất trong app có chi phí trực tiếp theo lượt dùng** (COGS), nên mọi case liên quan quota/tier
đều mang rủi ro tài chính, không chỉ rủi ro UX.

**Rủi ro xuyên suốt chạm vào flow này:**
- [exploratory-references §1.4](../../references/exploratory-references.md#14--đồng-bộ-2-chiều-với-apple-calendar--reminders-có-làm-mất-dữ-liệu-không) — mọi action ghi của Assistant đều ghi thẳng vào Calendar/Reminders thật, chịu chung rủi ro mất dữ liệu 2 chiều
- [exploratory-references §1.5](../../references/exploratory-references.md#15--bốn-cửa-vào-một-dữ-liệu-có-nhất-quán-không) — event/task tạo qua AI là **một cửa nhập liệu mới**, phải nhất quán với 4 cửa cũ (List/Day/Week/Month, widget, live activity)
- Toàn bộ 7 câu hỏi mở + 5 điểm chưa chắc chắn ở [test plan mục 10](../test-plans/ai-assistant/ai-assistant-tab.md#10-open--phase-2-chưa-code--chưa-chốt) — **không lặp lại ở đây**, chỉ tham chiếu

**⚠️ Trước khi dùng checklist này:** đọc [test plan §10](../test-plans/ai-assistant/ai-assistant-tab.md#10-open--phase-2-chưa-code--chưa-chốt)
trước — nhiều case dưới đây **không thể chạy** cho tới khi câu hỏi tương ứng được trả lời. Case nào bị chặn
đã ghi rõ trong cột "Đo gì"/"Câu hỏi", không tự đoán kết quả.

---

## 1 · Happy path — `AST-H`

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **AST-H01** | Mở tab Assistant lần đầu | Consent gate hiện trước, nói rõ dữ liệu nào rời máy, đi đâu, giữ bao lâu *(§6 AC 6.1)* | — | ☐ |
| **AST-H02** | Đồng ý consent, xem màn chờ | Bot greeting + quota còn lại hiện **trước khi gõ** (không để soạn xong mới báo hết) *(§7)* | — | ☐ |
| **AST-H03** | Gõ "Chiều mai 3h cafe Highlands với Nam bàn việc" | Event Card hiện đủ Title/Time/Location/Notes, đúng ví dụ Flow 1 | — | ☐ |
| **AST-H04** | Bấm Mic, nói cùng câu trên | Speech-to-Text điền đúng vào ô nhập, kết quả parse giống H03 | — | ☐ |
| **AST-H05** | Paste đoạn chat hẹn có ngày giờ địa điểm | Parse đúng như gõ tay | — | ☐ |
| **AST-H06** | Bấm "Lưu vào Lịch" | Card chuyển "Đã lưu", nút disable, mở Apple Calendar thật xác nhận event xuất hiện đúng — **không tin UI Ink** | Đối chiếu Apple Calendar | ☐ |
| **AST-H07** | Sau khi lưu, xem snackbar | `inkSnackbar` tone success + nút "Hoàn tác" hiện *(§4.2.4)* | — | ☐ |
| **AST-H08** | Hỏi "Lịch hôm nay ra sao?" (Action Chip) | Trả lời cô đọng, đúng số sự kiện thật trong ngày | Đối chiếu Apple Calendar | ☐ |
| **AST-H09** | Hỏi "Chiều nay rảnh lúc nào?" | Trả lời đúng khoảng trống ≥30 phút, kèm Smart Action Card đề xuất | — | ☐ |
| **AST-H10** | Bấm thẻ đề xuất ở H09 | Chốt lịch 1 chạm, event xuất hiện đúng | Đối chiếu Apple Calendar | ☐ |
| **AST-H11** | Yêu cầu tạo task ("nhắc tôi nộp báo cáo") | Reminder Card hiện, bấm "Tạo việc cần làm" → xuất hiện trong Reminders thật | Đối chiếu Apple Reminders | ☐ |
| **AST-H12** | Với 1 task có sẵn, bấm checkbox trên Reminder Card | Task chuyển hoàn thành qua `setCompleted`, đồng bộ đúng | — | ☐ |
| **AST-H13** | Yêu cầu đổi quote lock screen, **template đang áp có quote band** | Quote Card hiện câu ≤60 ký tự, bấm Áp dụng → wallpaper cập nhật đúng quote mới | — | ☐ |
| **AST-H14** | Thiếu giờ trong câu lệnh | AI hỏi lại kèm chip gợi ý (`Hôm nay 19:00`, `Ngày mai 19:00`, `Thứ 7 tuần này`) *(§4.3.1)* | — | ☐ |
| **AST-H15** | Bấm "Xoá chat" (Clear Chat) | Lịch sử local xoá sạch, AI xác nhận server không giữ gì để xoá *(§6.7)* | — | ☐ |

---

## 2 · Negative — `AST-N`

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **AST-N01** | Bấm "Lưu vào Lịch" 2 lần liên tiếp thật nhanh (double-tap) | Chỉ tạo **1** event — idempotency key chặn trùng *(§4.2.2, P1)* | Tạo 2 event trùng | 🔴 | ☐ |
| **AST-N02** | Bấm Lưu khi mạng chập chờn, request fail giữa chừng, thử lại | Không tạo bản trùng khi retry cùng key | Double-write sau lỗi mạng | 🔴 | ☐ |
| **AST-N03** | Có 2 task cùng tên "Nộp báo cáo", yêu cầu AI xoá 1 task | AI phải **hỏi lại task nào**, không tự đoán theo tên *(§4.2.6, P1)* | Xoá nhầm task, mất dữ liệu không match đúng ý user | 🔴 | ☐ |
| **AST-N04** | Bấm "Xoá" trên Reminder Card | Có bước xác nhận riêng trước khi xoá thật, kèm undo toast | Xoá ngay không hỏi — hành động phá huỷ không có lưới an toàn | 🔴 | ☐ |
| **AST-N05** | Chỉ nối Google Calendar (không dùng EventKit mặc định), yêu cầu tạo event | Card phải **nói rõ** v1 chỉ ghi EventKit, không âm thầm ghi vào calendar khác với cái user tưởng *(§4.2.3, P1)* | Event "biến mất" khỏi nơi user tìm (Google), nằm ở EventKit user không ngờ | 🔴 | ☐ |
| **AST-N06** | Template có sẵn nhiều quote tự soạn (rotate theo ngày), yêu cầu AI đổi quote | Card phải nói rõ **ghi đè hay thêm vào cuối** trước khi bấm Áp dụng — hành vi cụ thể tuỳ [quyết định #7](../test-plans/ai-assistant/ai-assistant-tab.md#10-open--phase-2-chưa-code--chưa-chốt) | Mất trắng danh sách quote user tự tay soạn, không cảnh báo | 🔴 | ☐ |
| **AST-N07** | Tạo event có Location ("Highlands Coffee"), mở lại bằng Apple Calendar | Xác nhận Location **thật sự được lưu**, không chỉ hiện trên card rồi mất — xem phân tích [Location field](#0--framing) | Card hiện 📍 nhưng event lưu không có địa điểm — form thủ công của Ink hiện không có trường Location (xem exploratory-references Flow 05) | 🔴 | ☐ |
| **AST-N08** | Gõ bằng tiếng Anh trong khi máy để hệ thống tiếng Việt | AI trả lời tiếng Anh (theo input, §4.5.2) nhưng nút "Lưu vào Lịch"/"Sửa" trên card vẫn tiếng Việt (theo hệ thống, §4.5.1) | Card **lai 2 ngôn ngữ** trong cùng 1 khung nhìn — xem Decision Table 3 ở [test plan](../test-plans/ai-assistant/ai-assistant-tab.md#5-kỹ-thuật-thiết-kế-test-case) | 🔴 | ☐ |
| **AST-N09** | Sau 1 vòng hỏi lại giờ (H14) mà vẫn thiếu | Mở thẳng form Create Event điền sẵn phần đã parse, **không hỏi vòng 2** *(§4.3.2)* | Hỏi lặp — đúng vấn đề feature sinh ra để giải quyết | 🟠 | ☐ |
| **AST-N10** | Ghi thất bại (quyền bị thu hồi giữa chừng / calendar read-only / hết dung lượng) | Card về trạng thái lỗi kèm "Thử lại", **giữ nguyên** dữ liệu đã parse | Văng user về ô nhập trắng, mất công gõ lại | 🟠 | ☐ |
| **AST-N11** | Bấm "Hoàn tác" sau khi lưu thành công | Event bị xoá thật; kiểm tra **card có quay lại trạng thái bấm lưu được không**, hay đứng yên ở "Đã lưu" dù thực tế đã xoá | Card "nói dối" — hiện đã lưu trong khi dữ liệu đã mất | 🟠 | ☐ |

---

## 3 · Edge — `AST-E`

| ID | Tình huống | Câu hỏi | Mức | ☐ |
|---|---|---|:---:|:---:|
| **AST-E01** | Dùng đúng lượt chat thứ 4, 5, 6 trong ngày (Free tier) | Đúng biên quota — chặn đúng lượt 6 (nếu hạn là 5), hiện paylwall moment chứ không phải lỗi *(§4.4, BVA)* | 🟠 | ☐ |
| **AST-E02** | Đo latency first token | ~2s (p50), huỷ + báo lỗi nếu >8s *(§4.4.1, BVA)* | 🟡 | ☐ |
| **AST-E03** | Quote AI soạn dài đúng 60 và 61 ký tự | Tại 60 chấp nhận, tại 61 bị chặn/rút gọn theo đúng giới hạn *(§2 Flow 3, BVA)* | 🟡 | ☐ |
| **AST-E04** | Free slot đúng 29, 30, 31 phút | Chỉ 30/31 phút được tính là "rảnh", 29 phút không được đề xuất *(§4.1.2, BVA)* | 🟡 | ☐ |
| **AST-E05** | Tắt mạng giữa phiên chat | Tab vẫn mở, đọc lại lịch sử chat, input disabled kèm lý do rõ ràng *(§4.4)* | 🟠 | ☐ |
| **AST-E06** | Server trả 5xx 2 lần liên tiếp | Sau 2 lần fail, đề xuất mở form thủ công *(§4.4)* | 🟠 | ☐ |
| **AST-E07** | Locale không hỗ trợ Speech-to-Text | Nút mic **ẩn hẳn**, không hiện nút bấm vào không phản hồi *(§4.5.4)* — danh sách locale cụ thể xem [test plan mục 10](../test-plans/ai-assistant/ai-assistant-tab.md) | 🟡 | ☐ |
| **AST-E08** | Bật Dynamic Type cỡ chữ lớn nhất + VoiceOver | Card đọc theo thứ tự tiêu đề → thời gian → địa điểm; nút có accessibility label rõ nghĩa *(§4.6.2)* | 🟠 | ☐ |
| **AST-E09** | **iPad** | Nội dung chat cap theo `inkReadableWidth`, bubble không kéo full-width *(§4.6.1)* | 🟡 | ☐ |
| **AST-E10** | Gõ/nói bằng 1 trong 9 ngôn ngữ ngoài Việt/Anh (Thái/Nhật/Hàn/Trung/Đức/Bồ...) | Chất lượng parse Date/Time/Location ra sao — **chưa có eval set, coverage gap thật sự**, không kỳ vọng bằng Việt/Anh *(§5.2)* | 🟠 | ☐ |
| **AST-E11** | Yêu cầu tạo event chỉ nói 1 mốc giờ ("3h chiều mai"), không nói giờ kết thúc | Xác nhận default duration được suy ra — so sánh với form Create Event thủ công có bắt buộc chọn tay End time không (nếu khác nhau là lệch validation) | 🟠 | ☐ |
| **AST-E12** | Đặt câu hỏi ngoài phạm vi cá nhân (kiến thức chung, vd "thủ đô nước Pháp là gì") | AI từ chối trung tính + gợi ý diễn đạt lại — đúng định vị "không phải chatbot bách khoa" *(§1.2)* | 🟡 | ☐ |
| **AST-E13** | Hết quota giữa lúc đang soạn câu dài | Không chặn giữa chừng làm mất nội dung đang gõ — quota hiển thị trước khi gõ (H02) phải đã cảnh báo từ sớm | 🟠 | ☐ |
| **AST-E14** | Kill app giữa lúc AI đang streaming trả lời | Mở lại app, lịch sử chat local vẫn còn (SwiftData), không kẹt ở trạng thái loading vô hạn *(§4.4.2/4.4.3)* | 🟡 | ☐ |

---

## 4 · Coverage matrix

| Vùng | State cần phủ | Đã chạm |
|------|---------------|:-------:|
| Tier × Quota | Free {còn nhiều · lượt cuối · đã hết} · Pro {trong fair-use cap · vượt cap} | ☐ |
| Kết nối calendar | chỉ EventKit · +Google · +Outlook · cả hai | ☐ |
| Ngôn ngữ nhập × hệ thống | giống nhau (11 cặp) · khác nhau (tối thiểu 1 cặp/ngôn ngữ) | ☐ |
| Quote band | template có band · không có band · band đang rotate nhiều item | ☐ |
| Lỗi/offline | mất mạng · timeout · hết quota · chưa cấp quyền · LLM từ chối · server 5xx | ☐ |
| Vòng đời app | mở lần đầu (consent) · quay lại từ background · kill giữa streaming · Clear Chat | ☐ |
| Accessibility | Dynamic Type lớn nhất · VoiceOver · Speech không hỗ trợ locale | ☐ |
| Device | iPhone · iPad | ☐ |

---

## 5 · Câu hỏi cần PO/dev trả lời

Không lặp lại ở đây — toàn bộ nằm ở [test plan mục 10](../test-plans/ai-assistant/ai-assistant-tab.md#10-open--phase-2-chưa-code--chưa-chốt),
gồm 7 câu §9 của PRD + 5 điểm chưa chắc chắn khác. Case nào trong checklist này bị chặn bởi câu hỏi nào đã
ghi chú trực tiếp trong bảng tương ứng ở §1–§3.

---

## 6 · Smoke 15 phút (chạy đầu tiên khi có build đầu tiên)

1. AST-N01 — double-tap "Lưu vào Lịch", xác nhận không tạo 2 event. *(3 phút, 🔴 P1)*
2. AST-N07 — tạo event có Location, mở Apple Calendar xác nhận có lưu thật không. *(3 phút, 🔴 P1)*
3. AST-N08 — gõ tiếng Anh trên máy hệ thống tiếng Việt, xem card có lai ngôn ngữ không. *(2 phút, 🔴 P1)*
4. AST-N03 — 2 task trùng tên, yêu cầu xoá, xác nhận AI hỏi lại thay vì đoán. *(3 phút, 🔴 P1)*
5. AST-N06 — đổi quote khi đã có quote tự soạn, xác nhận card cảnh báo ghi đè/thêm. *(2 phút, 🔴 P1)*
6. AST-H06 — happy path cơ bản, đối chiếu Apple Calendar. *(2 phút)*

---

## 7 · Kết luận phiên

```
Phiên: __________            Build: __________      Thiết bị: __________

Q1 Mục tiêu user:            ______________________________
Q8 Mục tiêu business:        ______________________________
— Chạy luồng chính —
Q2 Xong dễ lần đầu?          Có / Không — vì: __________
Q3 Điểm khựng/bối rối:       ______________________________
Q4 Thao tác sai / gián đoạn: ______________________________
Q5 State chưa test:          ______________________________
— Kết luận —
Q6 Rủi ro #1 nếu ship:       ______________________________
Q7 Tự mình dùng hằng ngày?   Có / Không — vì: __________
Q9 15 phút thì test gì:      ______________________________

=> Verdict: 🟢 ship được / 🟡 ship có điều kiện / 🔴 chưa nên ship
   Bằng chứng: ______________________________
```
