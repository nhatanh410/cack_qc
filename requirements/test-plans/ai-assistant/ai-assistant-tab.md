# Test Plan — Ink AI Assistant Tab (Phase 2)

> **Test basis:** [ai-chat-tab-prd.md](../../specs/ai-assistant/ai-chat-tab-prd.md) v1.1 — **Status: Draft, chặn bởi §9 (Open Questions)**
> **Liên hệ:** [docs/ai-assist-scope.md](../../docs/ai-assist-scope.md) — PRD tự đặt câu hỏi #6 liệu doc này có bị supersede hay chia phạm vi, chưa trả lời
> **Flow map:** [screenshot-naming.md §7](../../../.claude/rules/screenshot-naming.md) đánh dấu `12_ai-assistant` là 🚧 **Phase 2 — chưa build**, chưa có screenshot nào
> **Chuẩn:** ISTQB Foundation Level
> **Ngày lập:** 2026-09-11 · **Người lập:** QC

> ⚠️ **Bản chất của test plan này khác 2 bản trước (1.2.14, 1.2.15):** feature chưa build, PRD còn ở trạng
> thái Draft và tự nhận đang bị chặn bởi 7 câu hỏi mở. Đây là test plan **shift-left** — chuẩn bị sẵn test
> design để không mất thời gian khi PRD chốt, **không phải** test plan cho một build đang chạy trên TestFlight.
> Mục 8 (Entry criteria) vì vậy hiện tại **chắc chắn chưa đạt**. Mọi câu hỏi PRD chưa trả lời được gom vào
> **mục 10 (Open)** thay vì rải rác — theo yêu cầu.

---

## 1. Test basis

- `ai-chat-tab-prd.md` v1.1 — PRD nội bộ, có Action Map (§2.0) chốt cứng: mỗi nút trên Interactive Card phải
  gọi thẳng một API mutation đã có sẵn trong app, không tự định nghĩa đường ghi riêng. Đây là nguồn quan
  trọng nhất để verify tính đúng đắn của mọi test case ghi dữ liệu.
- Acceptance Criteria (§4) là phần chi tiết và có cấu trúc nhất từng thấy trong dự án này — nhiều AC đã tự
  đánh dấu `(mới)` nghĩa là được bổ sung sau khi review bản 1.0, dùng làm tín hiệu ưu tiên (thứ bị bỏ sót lần
  đầu thường dễ bị code bỏ sót lại lần nữa).
- §9 Open Questions — 7 câu hỏi tự PRD liệt kê là **chặn code**, dùng nguyên văn cho mục 10.

## 2. Test object — In scope (giả định PRD sẽ chốt các câu hỏi mở)

| # | Feature | Nguồn PRD |
|---|---|---|
| 1 | Flow 1 — Nhập lịch/task siêu tốc (text/voice/paste → Event/Reminder Card) | §2 Flow 1 |
| 2 | Flow 2 — Daily brief & tìm giờ rảnh | §2 Flow 2 |
| 3 | Flow 3 — Đặt quote Lock Screen (điều kiện quote band) | §2 Flow 3 |
| 4 | Khả năng đọc (cửa sổ 7 ngày mọi tier, free slot ≥30p, lọc theo calendar đang bật) | §4.1 |
| 5 | Khả năng ghi (xác nhận trước khi ghi, idempotency, calendar đích, undo, xử lý ghi thất bại, hoàn thành/xoá task, ghi đè/thêm quote) | §4.2 |
| 6 | Xử lý câu lệnh mơ hồ (tối đa 1 vòng hỏi lại, resolve timezone) | §4.3 |
| 7 | Error/Offline/Latency (6 trạng thái riêng biệt, streaming) | §4.4 |
| 8 | Localization & Voice — **2 lớp riêng biệt cần test độc lập:** (a) chrome UI (chip/nút/empty state) qua `Localizable.xcstrings`, đủ 11 ngôn ngữ; (b) **chất lượng NLP parsing** khi user gõ/nói bằng ngôn ngữ khác — độ chính xác tách Title/Date/Time/Location không được PRD cam kết ngang nhau giữa các ngôn ngữ (xem mục 5, 6, 10) | §4.5 |
| 9 | Platform & Design System (iPad width cap, Dynamic Type/VoiceOver, tái dùng component) | §4.6 |
| 10 | Privacy & Consent (consent gate, payload tối thiểu, cảnh báo paste, Clear Chat) | §6 |
| 11 | Hiển thị Monetization (quota còn lại, khác biệt Free/Pro) | §7 |
| 12 | Vị trí TabBar & ràng buộc kỹ thuật (enum không chèn giữa, l10n 5 label) | §8 |

## 3. Out of scope

- Lựa chọn nhà cung cấp LLM, kiến trúc proxy, ngân sách hạ tầng — quyết định kỹ thuật/kinh doanh, QC chỉ verify hành vi quan sát được từ app, không audit lựa chọn nội bộ.
- Độ chính xác tuyệt đối của ước tính chi phí §5.3 — chính PRD ghi "cần đo lại sau prototype", không phải việc của QC.
- Toàn bộ acceptance test chi tiết cho phần bị chặn bởi §9 chưa chốt — xem mục 10, không viết case cụ thể cho tới khi có quyết định vì viết trước dễ phải bỏ.

## 4. Test levels & types

- **Test levels (đầy đủ 4 cấp vì đây là feature mới có backend riêng — khác các note trước chỉ cần System testing):**
  - Component: proxy service (quota counter, App Attest verify, SSE passthrough).
  - Integration: proxy ↔ LLM provider ↔ EventKit/Reminders/CalendarTemplateEditorViewModel.
  - System: toàn bộ luồng chat trên TestFlight, black-box.
  - Acceptance: beta có chi phí thật — đây là tính năng **duy nhất trong app có COGS trực tiếp theo lượt dùng**, nên acceptance cần theo dõi cả chi phí thật lẫn hành vi.
- **Functional:** đúng 3 flow; đặc biệt verify **Action Map wrapper correctness** — mỗi nút phải tạo ra đúng side-effect quan sát được trong Apple Calendar/Reminders/wallpaper thật (không tin UI card báo "đã lưu", phải mở app gốc kiểm chứng — theo đúng nguyên tắc "đo, đừng đoán" đã dùng xuyên suốt dự án).
- **Non-functional:** Performance (latency §4.4.1), Security (API key không lộ trong binary, ZDR), Usability (copy lỗi riêng biệt theo từng trạng thái), Reliability (idempotency/undo), Portability (iPad, 11 ngôn ngữ), Accessibility (§4.6.2).
- **Change-related (regression):** vì mọi action đều wrap API có sẵn, **bất kỳ thay đổi nào ở `CalendarService`/`ReminderService`/`CalendarTemplateEditorViewModel` đều phải test cả đường cũ (form thủ công) lẫn đường mới (qua AI)** để 2 đường không lệch hành vi nhau.

## 5. Kỹ thuật thiết kế test case

- **Equivalence Partitioning:** trạng thái quota {dưới hạn · đúng lượt cuối · đã vượt hạn}; hỗ trợ Speech theo locale {có · không}; loại lỗi ghi {quyền bị thu hồi giữa chừng · calendar read-only · hết dung lượng máy}; **ngôn ngữ nhập vào Flow 1** {Việt · Anh (2 ngôn ngữ có trong eval set §5.2) · 9 ngôn ngữ còn lại (chưa có eval — xem mục 6, 10)}.
- **Boundary Value Analysis:**
  - Quota 5 lượt/ngày *(hoặc 3, xem mục 10)* — test tại lượt thứ 4, 5, 6.
  - Latency §4.4.1 — test tại ~2s (p50 first token) và tại biên 8s (ngưỡng huỷ request).
  - Độ dài quote ≤60 ký tự — test tại 60 và 61 ký tự.
  - Free slot tối thiểu 30 phút (§4.1.2) — test tại 29, 30, 31 phút.
- **Decision Table 1 — Calendar đích khi ghi event (§4.2.3):**

  | Có nối Google? | Có nối Outlook? | Chỉ nối remote, không có EventKit mặc định? | Hành vi ghi đúng |
  |---|---|---|---|
  | N | N | – | Ghi EventKit bình thường, card hiện đúng tên calendar |
  | Y | N/Y | Y | **Phải nói rõ** v1 chỉ ghi EventKit — không được ghi im lặng vào calendar khác với cái user tưởng |
  | Y/N | Y/N | N | Ghi EventKit, card vẫn hiện đúng tên + cho đổi calendar đích trước khi lưu |

- **Decision Table 2 — Hiện Quote Card (Action Map + §4.2.7):**

  | Template đang áp dụng có quote band? | Tier | Hành vi |
  |---|---|---|
  | N | Free/Pro | Không hiện Quote Card, chip "Đổi câu quote" ẩn, AI trả lời text giải thích lý do |
  | Y | Free | Hiện Quote Card, chỉ 1 tone mặc định |
  | Y | Pro | Hiện Quote Card, chọn được mọi Style Tone (Stoic, Minimalist, Coach…) |

- **Decision Table 3 — Ngôn ngữ nhập vs ngôn ngữ hệ thống (AC 4.5.1/4.5.2, rủi ro "câu lai" đã từng xảy ra ở Ink 1.2.14):**

  | Ngôn ngữ user gõ/nói | Ngôn ngữ hệ thống máy | Ngôn ngữ chrome card (nút, chip) | Ngôn ngữ AI trả lời | Rủi ro |
  |---|---|---|---|---|
  | Việt | Việt | Việt (theo AC 4.5.1) | Việt (theo AC 4.5.2 — khớp input) | Không, đây là case đồng nhất |
  | Anh | Việt | Việt (chrome theo **hệ thống**) | Anh (AI trả lời theo **input**) | 🔴 **Card hiển thị lai 2 ngôn ngữ cùng lúc** — nút "Lưu vào Lịch" tiếng Việt nhưng câu trả lời AI phía trên tiếng Anh. AC 4.5.1 và 4.5.2 dùng 2 tiêu chí khác nhau (system vs input) nên **chắc chắn tạo ra tổ hợp lai** khi 2 ngôn ngữ khác nhau — không phải edge case hiếm, mà là hệ quả trực tiếp của 2 rule như đã viết |
  | Thái/Nhật/Hàn/Trung/Đức/Bồ... | Khác ngôn ngữ user gõ | Theo hệ thống | Theo input | Cùng rủi ro lai như trên, nhân với 9 ngôn ngữ còn lại |

  → Case này **không cần build xong mới viết được** — là hệ quả suy ra trực tiếp từ 2 AC đã có, nên đưa thẳng
  vào P1 (mục 6) thay vì chờ.

- **State Transition Testing:**
  - Card ghi dữ liệu: `pending → saved (disabled, có idempotency key) → [lỗi → retry, giữ nguyên data đã parse]`
  - Request chat: `sending → streaming → done / timeout (>8s) / error`
  - Task match: `nhiều task trùng tên → hỏi lại task nào` (không tự đoán) → chọn đúng id → hành động
- **Security testing:** kiểm tra binary release không chứa API key (string dump / static analysis); verify proxy không log prompt/response (§6.5) — yêu cầu bằng chứng từ dev nếu QC không có quyền truy cập log server.
- **Exploratory testing** (session-based): hội thoại nhiều lượt (chat resend cả history — theo §5.3 lượt sau đắt hơn lượt đầu, cần xem hành vi khi history dài), ngôn ngữ trộn trong 1 câu, chuỗi câu lệnh mơ hồ liên tiếp vượt quá 1 vòng hỏi (§4.3.2), **thử parse ngày/giờ tương đối bằng 9 ngôn ngữ ngoài Việt/Anh** (vd tương đương "chiều mai", "thứ 7 tuần này" bằng Thái/Nhật/Hàn/Trung/Đức/Bồ...) — không có script cố định vì chưa biết AI phản ứng thế nào ngoài 2 ngôn ngữ đã eval.

## 6. Risk-based prioritization

**P1 — mất dữ liệu / mất tiền / vi phạm pháp lý:**
- §4.2.1/4.2.2 — ghi không qua xác nhận, hoặc double-write do thiếu/lỗi idempotency key
- §4.2.6 — xoá nhầm task do match tên mờ thay vì id (PRD tự nêu ví dụ "Nộp báo cáo" trùng tên)
- Flow 3 + open question #7 — **ghi đè im lặng toàn bộ quote user tự soạn** — PRD tự gọi đây là "hành vi phá dữ liệu"
- §4.2.3 — ghi nhầm vào EventKit trong khi user tưởng đã ghi vào Google/Outlook đang nối — event "biến mất" khỏi nơi user tìm
- §6.1–§6.6 — vi phạm carve-out của rule cấm log nội dung event (CLAUDE.md) sai cách, hoặc thiếu cập nhật Privacy Nutrition Label → rủi ro bị App Store reject
- §5.4 Lifetime cost model — không phải bug kỹ thuật nhưng là **release blocker cấp business**: nếu ship với "AI không giới hạn" cho gói Lifetime mà chưa chọn 1 trong 3 hướng khắc phục, đây là lỗ tài chính có thể đoán trước, QC nên chặn release cho tới khi thấy quyết định bằng văn bản
- **§4.5.1 vs §4.5.2 — card hiển thị lai 2 ngôn ngữ** khi ngôn ngữ user gõ khác ngôn ngữ hệ thống (Decision Table 3, mục 5). Xếp P1 vì đây là **hệ quả tất định** suy từ chính 2 AC đã viết, không phải giả thuyết cần chờ build mới biết — và đúng loại bug đã từng xảy ra thật ở Ink 1.2.14 (câu lai kiểu *"Allow kalender access"*)

**P2:**
- §4.4.1 — streaming/latency, không có spinner vô hạn
- §4.3.2 — vòng hỏi lại không được vượt quá 1 lần
- §4.5 — l10n **chrome** đủ 11 ngôn ngữ, đặc biệt copy lỗi (6 trạng thái ở §4.4) và chip gợi ý giờ (§4.3.1 — rủi ro lỗi ngữ pháp số ít/nhiều như case "1 filters" đã gặp ở 1.2.15)
- **Chất lượng NLP parsing ngoài Việt/Anh** — §5.2 chỉ cam kết eval trên 2 ngôn ngữ này; 9 ngôn ngữ còn lại chưa có gì đảm bảo độ chính xác tách Date/Time/Location tương đương (xem mục 10)
- §5.5 — quota Free phải enforce ở **server**, không phải chỉ ở client (test bằng cách xoá app cài lại, quota phải không reset)
- §8 — thứ tự tab không phá raw value enum đang dùng cho UITest/`-ink-debug-tab`

**P3:**
- UI cosmetic (chip, bubble, input dock) — miễn tái dùng đúng design system (§4.6.3)
- Wording chi tiết của từng trạng thái lỗi (chức năng đúng là đủ, câu chữ polish sau)

## 7. Test environment matrix

- **Device:** iPhone + iPad (§4.6.1, bubble không được kéo full-width trên iPad)
- **Ngôn ngữ — test theo ma trận, không chỉ theo từng ngôn ngữ đơn lẻ:**
  - **Chrome:** đủ 11 ngôn ngữ, đặc biệt Đức/Việt (dài nhất, ảnh hưởng 5-label TabBar theo §8)
  - **Tổ hợp ngôn ngữ nhập × ngôn ngữ hệ thống:** tối thiểu 1 cặp **giống nhau** (Việt/Việt) và 1 cặp **khác nhau** (Anh/Việt) cho mỗi ngôn ngữ trong 11 — xem Decision Table 3 (mục 5), đây là nơi bug "câu lai" sẽ lộ ra
  - **NLP parsing:** Việt + Anh có eval set theo §5.2; 9 ngôn ngữ còn lại **chưa có cam kết chất lượng**, test như exploratory (mục 5), không kỳ vọng độ chính xác ngang Việt/Anh cho tới khi có xác nhận từ dev
  - **Speech:** locale nào **không hỗ trợ** phải liệt kê cụ thể trước khi test (§4.5.4 — danh sách chưa có, xem mục 10)
- **Account/Tier:** Free và Pro, ở mọi mốc quota {còn nhiều · sắp hết · đã hết}
- **Kết nối calendar:** chỉ EventKit · có nối Google · có nối Outlook · có cả hai
- **Mạng:** online ổn định · offline · mạng chậm (test timeout 8s) · giả lập server 5xx (cần môi trường staging riêng biệt với production LLM)
- **Dữ liệu test cần chuẩn bị trước:** 2 task trùng tên (test §4.2.6) · template đã áp và có sẵn nhiều quote tự soạn (test Flow 3 overwrite) · template không có quote band (test nhánh từ chối) · calendar read-only (test §4.2.5)

## 8. Entry criteria

- **PRD phải thoát trạng thái Draft** — nghĩa là cả 7 câu hỏi ở §9 đã có quyết định bằng văn bản. Hiện tại **chưa đạt**.
- Proxy backend + cơ chế enforce quota đã deploy tới môi trường test, không chạy trực tiếp vào production LLM khi test negative case.
- Hợp đồng zero-data-retention với nhà cung cấp LLM đã ký (§6.4) — nếu chưa, **không được test bằng dữ liệu calendar/reminder thật của tài khoản QC thật**, phải dùng tài khoản/dữ liệu giả lập.

## 9. Exit criteria

- 0 bug P1 mở, đặc biệt toàn bộ nhóm ghi dữ liệu (double-write, xoá nhầm task, ghi đè quote, ghi nhầm calendar).
- Consent gate + Privacy Nutrition Label đã cập nhật và submit đúng trước khi release (§6.6) — đây là điều kiện submit App Store, không phải nice-to-have theo chính PRD.
- Quota Free đã verify enforce đúng ở server (xoá app cài lại không reset được lượt).
- Quyết định về gói Lifetime (§5.4) đã có bằng văn bản, không ship với "không giới hạn" còn để nguyên.

## 10. Open — Phase 2 chưa code / chưa chốt

Toàn bộ mục này lấy nguyên văn từ §9 của PRD cộng các điểm khác tự đánh dấu chưa chắc chắn trong các AC —
gom về một chỗ theo yêu cầu, thay vì rải rác như 2 test plan trước.

### Từ §9 — chặn code, PRD tự liệt kê

| # | Câu hỏi | Chặn phần nào | Ảnh hưởng tới test plan này |
|---|---|---|---|
| 1 | Nhà cung cấp LLM nào, đã có hợp đồng ZDR chưa? | §5.2, §6.4 | Chặn Entry criteria §8 — không được test với data thật nếu chưa ký |
| 2 | Ai xây và host proxy? Ngân sách hạ tầng/tháng? | §5.1 | Chặn toàn bộ Component/Integration test level |
| 3 | Gói Lifetime có kèm AI không? | §5.4, §7 | Chặn Exit criteria §9 — release blocker cấp business |
| 4 | Free quota 5 hay 3 lượt/ngày? | §5.5, §7 | Chặn Boundary Value Analysis ở mục 5 — chưa biết số biên chính xác |
| 5 | Ghi vào Google/Outlook calendar: v1 hay để sau? | §4.2.3 | Chặn Decision Table 1 ở mục 5 — nếu để sau thì bớt 1 nhánh cần test ngay |
| 6 | `docs/ai-assist-scope.md` bị superseded, hay hai doc chia phạm vi? | Toàn bộ | Chặn việc chọn test basis chính — có thể có yêu cầu ở doc kia chưa được đưa vào mục 2 |
| 7 | Đặt quote qua AI: ghi đè toàn bộ hay thêm vào cuối? | §2 Flow 3, §4.2.7 | Chặn case P1 quan trọng nhất của Flow 3 — không thể viết acceptance case cụ thể cho tới khi chốt |

### Các điểm khác chưa chắc chắn, tự đánh dấu trong AC (chưa lên tới mức "Open Question" chính thức nhưng cùng loại)

| Vị trí | Ghi chú "chưa chắc" | Ảnh hưởng |
|---|---|---|
| §2.0 Action Map, Flow 3 | "Catalog bundle hiện có 5/46 template mang part quote — tỉ lệ ở Remote Config catalog thực tế cần đo lại, không giả định" | Không biết % user thực tế nhìn thấy Quote Card — ảnh hưởng độ ưu tiên test Flow 3 |
| §5.3 | Đơn giá $/lượt là "ước tính, cần đo lại sau prototype" | Không dùng số này để tính ngân sách QA/test thật, chỉ tham khảo |
| §4.5.4 | Danh sách locale nào không hỗ trợ Speech-to-Text chưa được liệt kê cụ thể | Không viết được test case chính xác cho nhánh ẩn nút mic tới khi có danh sách |
| §6.2 | "cân nhắc gửi ẩn danh hoàn toàn, không kèm title" cho Flow 2 — chưa chốt là sẽ làm hay không | Chưa biết payload thật để verify §6.5 (proxy không log gì hơn) |
| §8.3 | "Nếu sau 4 tuần Assistant không đạt ngưỡng DAU đã định, hạ xuống entry point" — ngưỡng DAU cụ thể chưa nêu | Không phải case QC test trước ship, nhưng cần theo dõi sau khi ra mắt — ghi nhận để không quên |
| §5.2 | "Chốt bằng eval trên tập câu tiếng Việt + tiếng Anh thật" — **không có eval set nào cho 9 ngôn ngữ còn lại** dù app cam kết đủ 11 ngôn ngữ ở §4.5.1 | Không biết độ chính xác parse Date/Time/Location ở Thái/Nhật/Hàn/Trung/Đức/Bồ... — QC không thể đặt ngưỡng pass/fail hợp lý cho các ngôn ngữ này tới khi có eval set hoặc quyết định rõ (vd: giới hạn Flow 1 ở v1 chỉ cho Việt/Anh?) |
| §4.5.1 | PRD nói "đủ 11 ngôn ngữ" nhưng — giống các change note khác trong dự án này — **không liệt kê tên cụ thể của cả 11** | Không tự suy ra danh sách từ các note trước (đã từng thiếu đúng 1 ngôn ngữ không tên ở note 1.2.14) — cần một nguồn danh sách 11 ngôn ngữ dùng chung, chốt một lần cho toàn dự án |

**Khuyến nghị:** không viết acceptance test case chi tiết (mức "case theo kịch bản cụ thể") cho các mục ở
bảng trên cho tới khi có quyết định — chỉ giữ ở mức test **kỹ thuật/thiết kế** (mục 5) để sẵn sàng triển khai
ngay khi câu hỏi được trả lời, tránh viết case rồi phải bỏ khi quyết định đổi hướng.
