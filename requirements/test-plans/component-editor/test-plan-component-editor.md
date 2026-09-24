# Test Plan — Wallpaper Component Editor (TestFlight 1.2.17)

> **Test basis:** [QC — Component Editor 1.2.md](../../specs/wallpaper-component/QC%20—%20Component%20Editor%201.2.md) — bàn giao QC nội bộ, TestFlight **1.2.17 (103)**, Sep 24 2026, tác giả `@Someone`. Bảng thiết bị/OS đã sửa khớp [bản PDF gốc](../../specs/wallpaper-component/QC%20—%20Component%20Editor%201.2.17.pdf) (xem test-analysis TB-1) — dùng bản markdown hiện tại, không dùng lại bản cũ có bảng vỡ định dạng.
> **Test analysis:** [test-analysis-component-editor.md](test-analysis-component-editor.md) — 73 test condition đã ưu tiên hoá (27 P1 · 30 P2 · 15 P3 · 1 TBD), dùng thẳng cho mục 2 và mục 6 dưới đây, không phân tích lại từ đầu. TC-71/TC-72/TC-73 bổ sung 2026-09-24 (câu hỏi #6, #7, #8 mục 10 đã có trả lời từ dev — **TC-73 là case quan trọng nhất: bố cục có sống sót qua automation Shortcut overnight không**).
> **Chuẩn:** ISTQB Foundation Level v4.0.1 (test basis → test object → kỹ thuật thiết kế → rủi ro → entry/exit)
> **Test case cụ thể:** [test-cases-component-editor.md](test-cases-component-editor.md) — sẽ sinh bởi skill test-case sau khi test plan này được duyệt.
> **Đối chiếu tài liệu đã có:**
> [wideframe 14_edit-wallpaper.md § S03](../../ui/ux/wideframes/14_edit-wallpaper.md#s03--component-editor--8-state-có-ảnh-bổ-sung-2026-09-24) (vừa dựng 2026-09-24 từ 8 screenshot thực tế),
> [screenshots iphone/index.md § 03_component-editor](../../ui/ux/screenshots/iphone/index.md),
> [wallpaper-component-editor-prd.md](../../specs/wallpaper-component/wallpaper-component-editor-prd.md) (PRD gốc, **Draft**, đã lỗi thời một phần — xem mục 1),
> [wallpaper-component-editor-wireframe.html](../../specs/wallpaper-component/wallpaper-component-editor-wireframe.html) (đề xuất UI, **Draft**),
> [exploratory/14_edit-wallpaper.md](../../exploratory/14_edit-wallpaper.md) (checklist hiện có — **chỉ cover S01/S02 Decorate, chưa có case nào cho S03**),
> `bugs/bug-log.md` (đã rà soát — **không có bug nào liên quan trực tiếp** tới wallpaper-component/component-editor).
> **Ngày lập:** 2026-09-24 · **Người lập:** QC

---

## 1. Phát hiện khi đối chiếu với tài liệu đã có

1. **PRD gốc (Draft) đã lỗi thời so với bản build thật — không dùng PRD để suy ra scope.** PRD §1.3 đặt 4 "nguyên tắc bất biến", trong đó NT-1 nói rõ *"không biến canvas thành mặt phẳng 2D tự do"* — hệ thống vị trí chỉ 1D (`y` **hoặc** `gap`, không có tự do 2 chiều). Nhưng test basis 1.2.17 (test basis chính, có hiệu lực cao hơn PRD Draft) mô tả rõ **Row/Column lồng nhau tới 3 cấp**, kéo thả cả chiều ngang lẫn dọc, và nhóm **Layout** hẳn hoi trong sheet Add component — vượt xa giới hạn PRD Draft từng đặt ra. Đây không phải mâu thuẫn cần hỏi (test basis 1.2.17 là nguồn sự thật), chỉ là ghi nhận: **PRD Draft không còn phản ánh đúng phạm vi thật, test plan này bám theo test basis 1.2.17, không bám PRD**.
2. **Wireframe đề xuất (HTML, Draft) mô tả sai cách vào tính năng — đã tự sửa lại trong chính file đó ngày 2026-09-24, nhắc lại ở đây để không lặp lại giả định cũ.** Đề xuất ban đầu: chạm trực tiếp vào 1 thành phần trên canvas màn wallpaper-editor để chọn, không qua "chế độ" riêng. Thực tế (test basis + ảnh S03): phải bấm icon **layers** riêng → mở **1 màn full-screen tách biệt hẳn** (header đổi hoàn toàn: ✕/Undo/Redo/✓, không còn tên template). Test plan này bám theo thực tế, không theo đề xuất.
3. **Inspector không dùng tab như đề xuất.** Wireframe đề xuất (rule L4 trong chính file đó) kỳ vọng 4 tab bấm chuyển Content/Text/Background/Position. Ảnh S03 (`inspector` → `inspector-scrolled-v4`) cho thấy đây là **1 sheet cuộn dọc duy nhất**, thứ tự quan sát được là **Position → Content → Text**. Test basis 1.2.17 không quy định thứ tự cụ thể nên **đây không phải mâu thuẫn với test basis** — chỉ là điểm khác so với bản đề xuất cũ, đã ghi chú tại nguồn.
4. **Không có exploratory checklist nào cho S03 để đối chiếu/regression** — khác các flow khác trong bộ luôn có ít nhất 1 vòng khám phá trước. `exploratory/14_edit-wallpaper.md` hiện tại 100% dành cho S01/S02 (Decorate, build 1.2.15). Đây là **lần đầu S03 được test có hệ thống** — không có case cũ nào tái hiện lỗi đã fix để regression lại (khác ví dụ `test-plan-ios26-27.md` vốn có nguyên khối R1–R8 để regression). Khuyến nghị chạy skill `exploratory-checklist` cho S03 sau khi test plan này execute xong lần đầu — xem mục 11.
5. **`bugs/bug-log.md` không có bug nào liên quan** — không có case regression từ bug cũ cho feature này (khác ví dụ `test-plan-ios26-27.md` có BUG-004 phải chạy lại).
6. **Traceability build chưa chắc chắn.** Batch 11 ảnh trong `iphone/index.md § 03_component-editor` ghi "build/commit chưa xác nhận qua công cụ", trong khi test basis ghi rõ **TestFlight 1.2.17 (103)**. Cùng ngày 2026-09-24 nên khả năng cao cùng lứa, nhưng chưa có bằng chứng chắc chắn (test-analysis TB-7) — **entry criteria (mục 8) yêu cầu xác nhận lại build trước khi execute**, không dùng ảnh đã chụp làm bằng chứng build khớp.

---

## 2. Test object — In scope

| # | Hạng mục | Mã nhóm | Nguồn (test basis) | Ghi chú |
|---|---|---|---|---|
| 1 | Entry & gating — nút Components, header full-screen, coach mark | **ENT** | dòng 16–20 | Nền tảng cho mọi mục khác — nếu nút không hiện đúng hoặc không mở được S03, toàn bộ các mục sau không chạy được |
| 2 | Phạm vi thiết bị/OS — iPhone iOS 18.x/26.x bắt buộc, iPad nếu có, iOS 27 ngoài phạm vi | **DEV** | dòng 11–14 (bảng, đã sửa khớp PDF) | TC-58 (xoay iPad) đặt chung với **PRP** vì gắn với hành vi Inspector/khung viền, không tách riêng |
| 3 | Chọn thành phần — đơn lẻ, lồng trong container, đi sâu từng cấp | **SEL** | dòng 22–34 | Hành vi cố ý dễ hiểu nhầm là lỗi (chạm 1 lần chỉ chọn container) — cần State Transition rõ ràng, xem mục 5 |
| 4 | Di chuyển (kéo/move) | **DRG** | dòng 38–50 | Test basis tự xếp **"đã sửa đi sửa lại nhiều nhất trong đợt này"** — vùng rủi ro cao nhất toàn bộ test plan |
| 5 | Đổi bề rộng (kéo góc/resize) | **RSZ** | dòng 55–69 | 2 điểm còn thiếu giá trị cụ thể (Row 3+ con, min-width) — xem mục 10 |
| 6 | Thêm thành phần / Row / Column | **ADD** | dòng 73–93 | TC-36 là regression của 1 lỗi **vừa fix gần đây** — ghi rõ trong case để dễ trace nếu tái phát |
| 7 | Giới hạn lồng nhau & container rỗng | **NST** | dòng 95–107 | Điểm chính xác của "cấp 3" chưa rõ — xem mục 10 |
| 8 | Bảng thuộc tính, Undo, lưu (Inspector) | **PRP** | dòng 109–135 | Gồm cả TC-58 (xoay iPad, điều kiện "nếu có máy") |
| 9 | Bản địa hoá | **LOC** | dòng 9 | Chỉ VI/EN đầy đủ — xem Out of scope |
| 10 | Regression ngoài màn editor (lock screen thật, Live Activity, widget, thumbnail, template cũ, Note) | **REG** | dòng 156–170 | Test basis tự cảnh báo: *"ghi thẳng vào dữ liệu wallpaper"* — chạy **sau cùng**, phụ thuộc SEL/DRG/RSZ/ADD/NST/PRP đã pass |
| 11 | Hành vi cố ý — xác nhận đúng tài liệu, tránh báo nhầm lỗi | **INT** | dòng 137–154 | Không phải tìm lỗi — mục đích là huấn luyện tester nhận ra 7 điểm này **không** phải bug |

---

## 3. Out of scope

- **Bản đề xuất UI cũ trong wireframe.html (tab-based Inspector, chọn trực tiếp không qua "chế độ" riêng)** — đã xác nhận không khớp thực tế (mục 1, phát hiện #2/#3), không test theo đề xuất đó.
- **Kiểm tra đầy đủ 10/12 ngôn ngữ còn lại (ngoài VI/EN)** — test basis chỉ yêu cầu *"chạy chính bằng Tiếng Việt và English"*, không yêu cầu full pass 12 ngôn ngữ; lý do: ngoài phạm vi bàn giao đợt này.
- **iPhone iOS 27** — test basis (bảng đã sửa) ghi rõ **Không**, lý do: có bug Shortcut riêng không liên quan đến Component Editor, không tính vào đợt này.
- **Đo hiệu năng định lượng (FPS/latency chính xác) khi kéo/resize** — test basis dùng ngôn ngữ định tính ("ngay lập tức, không trễ"), không yêu cầu số liệu; lý do: ngoài phạm vi bàn giao, chỉ cần quan sát cảm nhận.
- **Automated/unit test** — test plan này là black-box thủ công, đúng quy ước các test plan trước trong repo.
- **PRO gating theo từng loại component** — PRD §11 (Open Questions) tự nhận đây là cơ chế **mới, chưa có tiền lệ**; test basis 1.2.17 không nhắc badge PRO nào, và 2 ảnh sheet Add component hiện có không thấy badge PRO — không đủ căn cứ viết case, không suy diễn đã có/chưa có. Ghi vào coverage gap (mục 11) thay vì scope chính thức.

### 3.1 Ảnh hưởng chéo tới flow khác

> Đối chiếu [screenshot-naming.md §7](../../../.claude/rules/screenshot-naming.md#7-flow-map--ink-calendar-ios).

| Flow | Ảnh hưởng? | Lý do |
|---|---|---|
| `14_edit-wallpaper` (S01/S02 — Decorate) | **Trực tiếp, trong cùng flow-no** | S01 là màn gốc dùng chung cho cả 2 tính năng (nút "Decorate" và icon "layers" nằm cạnh nhau). **Đã xác nhận qua dev (2026-09-24): 2 tính năng độc lập về dữ liệu**, không đụng nhau — nhưng wallpaper cuối cùng phải render **đầy đủ cả 2 phần** cùng lúc, xem TC-72 (nhóm REG) |
| `03_shortcut-setup` | **Gián tiếp, rủi ro cao** | Wallpaper tự render lại mỗi sáng qua Apple Shortcut automation. **Đã xác nhận qua dev (2026-09-24): bắt buộc phải sống sót và cập nhật đầy đủ qua automation**, không phải "nếu được" — xem TC-73 (nhóm REG, P1), cùng mức độ quan trọng với `DEC-Q01` đã đặt cho Decorate |
| `04_discover` | **Gián tiếp** | Đường vào editor (chọn/tạo template) nằm ở đây; "Set as current"/"Update" là CTA kích hoạt lưu bố cục thật |
| `05_calendar` | **Gián tiếp** | Nguồn dữ liệu event hiển thị trong các component dạng lịch (Timetable, Month grid, Today's events...) |
| `08_paywall` | **Gián tiếp, nhẹ** | PRD §11 nêu khả năng gate Pro theo loại component — hiện chưa thấy bằng chứng trong test basis 1.2.17, không log case, chỉ ghi nhận theo dõi |
| `09_settings` | **Không rõ** | Không có entry point trực tiếp từ Settings trong test basis — không ghi nhận ảnh hưởng |
| `10_lockscreen` | **Trực tiếp** | Toàn bộ mục **REG** (mục 2, #10) — kết quả cuối cùng của mọi thay đổi bố cục hiện ở đây |
| `06_task`, `07_note`, `01_onboarding`, `02_permission` | **Không ảnh hưởng** | Không entry point, không chia sẻ data pipeline với Component Editor |
| `11_share`, `12_ai-assistant`, `13_community` | **Không áp dụng** | Chưa build (Phase 2) |

---

## 4. Test levels & test types

- **Level:** System testing, black-box, trên **TestFlight 1.2.17 (103)** — khác `test-plan-ios26-27.md` (vốn test trên Ink Dev/Xcode); QC dùng quyền tester TestFlight thông thường, không cần quyền vào code.
- **Functional:** toàn bộ 11 test object ở mục 2 (ENT, DEV, SEL, DRG, RSZ, ADD, NST, PRP, LOC, REG, INT).
- **Non-functional:**
  - **Performance efficiency:** kéo (DRG) và resize (RSZ) phản hồi realtime, không có độ trễ cảm nhận được (TC-13, TC-23) — quan sát định tính, không đo số liệu (xem Out of scope).
  - **Compatibility:** iPhone iOS 18.x + iOS 26.x bắt buộc cả hai (TC-69, TC-70); iPad nếu có máy (TC-58).
  - **Reliability:** Undo/Redo đúng 1 bước cho 1 thao tác (TC-51), không mất dữ liệu khi kéo/xoá/resize (TC-11, 12, 17, 18, 19, 24, 43), và toàn bộ nhóm REG — đây là loại risk **cao nhất** toàn bộ test plan vì test basis tự nói *"ghi thẳng vào dữ liệu wallpaper"* (ảnh hưởng lock screen thật, Live Activity, widget, thumbnail).
  - **Usability:** hit target 4 góc kéo không có chỉ báo hình tròn (TC-20); Inspector dạng cuộn dài không có tab định hướng (mục 1, phát hiện #3) — quan sát thêm mức độ dễ dùng dù không phải bug.
  - **Internationalization:** LOC (TC-59) — không lọt tiếng Anh vào máy tiếng Việt.
- **Change-related (confirmation + regression):**
  - Regression nhóm **REG** (TC-60–65) sau khi mọi thay đổi bố cục đã lưu — xác nhận không vỡ lock screen thật/Live Activity/widget/thumbnail, và **template cũ chưa từng mở bằng Component Editor vẫn render y như trước** (TC-64 — regression diện rộng, ảnh hưởng mọi user kể cả người chưa dùng tính năng mới).
  - Confirmation nhóm **INT** (TC-66–68): xác nhận 3 hành vi tài liệu hoá vẫn đúng như mô tả — không phải tìm lỗi mới, mà đảm bảo tester không báo nhầm và phát hiện sớm nếu có regression khỏi đúng hành vi đã "chốt".

---

## 5. Kỹ thuật thiết kế test case

### ENT — Checklist-based + Equivalence Partitioning

- **EP theo loại template:** {template dạng **stack** (mới) | template **không phải stack** (cũ)} → nút Components chỉ hiện ở partition đầu (TC-01).
- Phần còn lại (header đủ control, coach mark) dùng **checklist-based** trực tiếp từ dòng 16–20 test basis — không có tổ hợp điều kiện, không cần kỹ thuật phức tạp hơn.

### DEV — Compatibility test matrix (không phải EP/BVA vì đây là tập thiết bị rời rạc)

| Thiết bị | Bắt buộc | Test object áp dụng |
|---|---|---|
| iPhone iOS 18.x | Có | Toàn bộ 11 test object |
| iPhone iOS 26.x | Có | Toàn bộ 11 test object, đặc biệt chú ý chrome glass render (TC-70) |
| iPad (dọc + ngang) | Nếu có máy | TC-58 tối thiểu; nếu có thời gian, lặp lại ENT/SEL cơ bản |
| iPhone iOS 27 | Không (ngoài scope) | — |

### SEL — State Transition Testing

Khớp đúng hành vi cố ý "chạm lần 1 chọn container, chạm tiếp mới vào con" (dòng 28, xác nhận lại ở `INT`/dòng 152):

| State hiện tại | Event | State kế tiếp |
|---|---|---|
| Không chọn gì | Chạm thành phần đơn (không trong container) | Đã chọn thành phần đó |
| Không chọn gì | Chạm vào 1 container (Row/Column cấp 1) | Đã chọn container cấp 1 |
| Đã chọn container cấp N (N < độ sâu tối đa) | Chạm đúng con bên trong | Đã chọn con ở cấp N+1 |
| Đã chọn bất kỳ | Chạm ra vùng trống | Không chọn gì |
| Đã chọn bất kỳ | Chạm 1 thành phần/container khác | Đã chọn thành phần/container mới (không cộng dồn) |

Transition không hợp lệ cần thử: chạm 2 lần liên tiếp **rất nhanh** vào cùng 1 con bên trong container — có nhảy cấp/double-select nhầm không (không có trong test basis, thêm vào error guessing).

### DRG — Equivalence Partitioning + Checklist-based

- **EP theo loại thành phần đang kéo:** {thành phần đơn lẻ (top-level, không trong container) | Row/Column (cả container di chuyển cùng con) | thành phần con bên trong 1 Row/Column} — 3 partition, mỗi partition test riêng theo checklist dòng 40–50.
- **Checklist-based cho các invariant bất biến khi kéo** (không có bản sao, không mất/hiện lại, không giật khi nhả tay) — áp dụng cho cả 3 partition trên.
- Bắt buộc test với **template có Row lồng trong Column** theo đúng chỉ dẫn test basis dòng 38.

### RSZ — Decision Table + Boundary Value Analysis

**Decision Table — hướng kéo góc × vị trí thành phần:**

| Rule | Vị trí thành phần | Góc kéo | Kỳ vọng |
|---|---|---|---|
| RSZ-DT1 | Top-level (ngoài cùng) | Phải | Mép phải chạy, cạnh trái đứng yên, canh giữa |
| RSZ-DT2 | Top-level (ngoài cùng) | Trái | Mép trái chạy, cạnh phải đứng yên, canh giữa |
| RSZ-DT3 | Trong Row (2 con) | Bất kỳ | Bù trừ đúng với con liền kề, tổng bề rộng Row không đổi |
| RSZ-DT4 | Trong Row (3+ con) | Bất kỳ | **TBD — chờ câu hỏi #2 (mục 10)**, chưa viết được kỳ vọng cụ thể |

**BVA — số con trong Row khi kéo góc 1 phần tử:** 1 con (không áp dụng — không có ai để bù trừ) · 2 con (rule rõ, RSZ-DT3) · 3 con (biên dưới của "3+") · N con lớn (kiểm không vỡ UI khi Row có nhiều con). Giá trị **min-width tuyệt đối** (dòng 69) chưa có số cụ thể — **BVA 2-value không viết được chính xác cho tới khi có câu trả lời #3 (mục 10)**, tạm thời chỉ verify có tồn tại 1 ngưỡng chặn (không co về 0), chưa test đúng-sai ngưỡng đó.

### ADD — Equivalence Partitioning + Decision Table

- **EP theo trạng thái đang chọn khi bấm +:** {đang chọn 1 thành phần đơn (TC-32) | đang chọn 1 Row/Column (TC-33) | **không chọn gì** → chèn vào **giữa canvas/center** (TC-71, xác nhận qua dev 2026-09-24, test basis gốc không mô tả)}.

**Decision Table — bấm trong ô trống của Row/Column:**

| Rule | Chạm vào | Kỳ vọng |
|---|---|---|
| ADD-DT1 | Đúng nút + giữa ô trống | Thành phần lấp đúng ô đó, ô còn lại giữ nguyên (regression của lỗi vừa fix — TC-36) |
| ADD-DT2 | Nền ô trống, trượt ngoài nút + | Chọn container, KHÔNG mở sheet Add component |

### NST — Boundary Value Analysis

Độ sâu lồng container, biên tại giới hạn tối đa công bố (3 cấp):

| Cấp | Kỳ vọng |
|---|---|
| 1 | Nhóm Layout hiện đầy đủ trong Add component |
| 2 | Nhóm Layout hiện đầy đủ |
| 3 (biên trên hợp lệ) | Nhóm Layout **biến mất**, nhóm khác vẫn còn |
| 4 (phải bị chặn) | **TBD — chờ câu hỏi #5 (mục 10)**, chưa rõ cấp được đếm từ đâu (canvas gốc có tính là 1 cấp không) nên chưa xác định được đây có thật sự là "cấp 4" hay "cấp 3" theo cách đếm của hệ thống |

### PRP — Checklist-based + State Transition

- Phần lớn là danh sách control rời rạc (Duplicate/Delete/Deselect, Show grid, cảnh báo tràn màn...) → **checklist-based** trực tiếp từ dòng 109–135.
- **State Transition riêng cho Placement Auto ↔ Fixed:** 2 state (`Auto` dùng `gap` / `Fixed` dùng `y`), chuyển qua lại **không được** làm thành phần nhảy vị trí (AC ngầm định từ dòng 111) — test cả 2 chiều chuyển đổi.

### LOC — Equivalence Partitioning

{Máy tiếng Việt | Máy tiếng Anh | 10 ngôn ngữ còn lại (out of scope)} — chỉ 2 partition đầu trong scope, verify không lọt chuỗi tiếng Anh vào máy VI.

### REG — Checklist-based (chạy sau cùng, có phụ thuộc)

Mỗi dòng regression (dòng 160–170) = 1 case độc lập, nhưng **toàn bộ nhóm phải chạy sau khi SEL/DRG/RSZ/ADD/NST/PRP đã pass** — regression kiểm tra kết quả **đã lưu**, không có ý nghĩa nếu bố cục lưu vào còn sai từ bước dựng.

### INT — Checklist-based (xác nhận, không phải tìm lỗi)

3 case xác nhận đúng hành vi tài liệu hoá (dòng 142–154, các điểm 1/2/3) — mục đích ghi lại bằng chứng "đây là đúng thiết kế" để tester tương lai không báo nhầm.

---

## 6. Risk-based prioritization

> Risk level = risk likelihood × risk impact (ISTQB §5.2.1) — đã tính sẵn ở test-analysis mục 2, dùng lại nguyên vẹn ở đây, nhóm theo chủ đề để tránh lặp 25 dòng rời rạc.

**P1 — chặn phát hành (25 test condition):**

- **Chọn/Xoá/Undo cốt lõi** (TC-05, 07, 08, 11, 12) — nếu sai, mọi thao tác sau đó (kéo, resize, thêm) đều thao tác nhầm đối tượng hoặc mất dữ liệu không phục hồi được.
- **Toàn bộ nhóm kéo — DRG** (TC-13, 14, 16, 17, 18, 19) — test basis tự xếp đây là vùng sửa nhiều nhất; bản sao chồng lên nhau hoặc mất thành phần khi kéo là mất dữ liệu trực tiếp của user.
- **Resize theo đúng hướng** (TC-21, 22, 26) — sai hướng kéo góc hoặc sai công thức bù trừ trong Row phá vỡ toàn bộ bố cục đã dựng, khó phát hiện bằng mắt nếu không test kỹ.
- **Regression thêm component trong ô trống** (TC-36) — lỗi **vừa fix gần đây**, khả năng tái phát cao nếu code path liên quan bị đụng lại ở bản build này.
- **Auto/Fixed không nhảy vị trí, Undo trọn vẹn, Done/Cancel đúng** (TC-44, 51, 53, 54) — sai một trong các case này khiến user mất niềm tin vào toàn bộ editor (không biết Undo có tin được không, Cancel có thật sự huỷ hết không).
- **Baseline thiết bị** (TC-70 — iOS 26.x, chrome glass) — bắt buộc theo test basis, impact cao vì ảnh hưởng toàn bộ user chạy iOS 26.
- **Toàn bộ nhóm REG** (TC-60–63) — impact cao nhất trong cả bộ: sai ở đây nghĩa là lock screen thật/Live Activity/widget/thumbnail của user bị hỏng ngoài phạm vi app, không có cách nào user tự sửa ngoài xoá app.
- **Gộp Decorate + Component Editor vào cùng 1 wallpaper cuối** (TC-72, xác nhận qua dev) — 2 tính năng độc lập về dữ liệu nên rủi ro chính nằm ở bước **lưu/render cuối cùng** có gộp đủ cả 2 hay bị 1 bên ghi đè mất bên kia; impact cao vì mất công sức user đã bỏ ra ở 1 trong 2 phần.
- **Bố cục sống sót qua automation Shortcut overnight** (TC-73, xác nhận **bắt buộc** qua dev) — impact cao nhất về mặt giá trị sản phẩm: nếu bố cục tuỳ chỉnh bị mất/reset sau mỗi lần automation chạy (mỗi sáng), toàn bộ tính năng chỉ có giá trị dùng được đúng 1 ngày — đúng tiền lệ mức độ nghiêm trọng của `DEC-Q01` đã áp dụng cho Decorate.

**P2 (30 test condition):** các hành vi phụ trong SEL/DRG/RSZ/ADD/NST/PRP không trực tiếp mất dữ liệu nhưng sai lệch UX rõ rệt (vd bỏ chọn khi chạm ra ngoài, cảnh báo tràn màn, Redo, sheet Add component đúng nhóm, vị trí chèn khi chưa chọn gì — TC-71...), cộng bản địa hoá (TC-59) và baseline iOS 18.x (TC-69, do khả năng lỗi thấp hơn 26.x vì là phiên bản chính được dev test nhiều nhất).

**P3 (15 test condition):** cosmetic/UX nhẹ có workaround rõ ràng (vị trí icon, coach mark, ẩn/hiện chrome, nhóm Add component hiện đủ 6 mục...) và 3 case **INT** (xác nhận hành vi cố ý, không phải bug nếu "sai" theo cảm nhận ban đầu).

**Chưa xếp priority — 1 test condition (TC-27):** hành vi Row 3+ con khi kéo góc — chờ câu hỏi #2 (mục 10) trước khi gán risk level chính xác, không đoán P-level cho có.

---

## 7. Test environment matrix

- **Build:** TestFlight **1.2.17 (103)**. Trước khi execute, **xác nhận lại** build trên máy test khớp đúng số hiệu này — không mặc định batch ảnh QC hiện có (`iphone/index.md § 03_component-editor`) là cùng build, vì build/commit của batch ảnh đó chưa xác nhận qua công cụ (mục 1, phát hiện #6).
- **Thiết bị bắt buộc:** iPhone **iOS 18.x** (baseline) + iPhone **iOS 26.x** (chrome glass) — cả hai. iPad (dọc + ngang) **nếu có máy sẵn**, không bắt buộc. Không cần iPhone iOS 27.
- **Ngôn ngữ máy:** chạy chính bằng **Tiếng Việt** và **English**.
- **Dữ liệu chuẩn bị trước mỗi máy:**
  - Tối thiểu 1 template lịch **dạng stack** (để có nút Components) — bắt buộc để test bất kỳ mục nào.
  - Tối thiểu 1 template **không phải stack** — chỉ để verify TC-01 (ẩn đúng nút).
  - Tối thiểu 1 template có sẵn **Row lồng trong Column** — nếu build chưa có mẫu sẵn, tự dựng bằng chính tính năng Add Row/Column trong lúc test (test basis dòng 38 yêu cầu test kỹ với layout này).
  - Tối thiểu 3–4 loại component khác nhau ngoài Timetable — **đã có ảnh tham chiếu cho `Year progress`, `Month grid`, `Mini month`** (bổ sung 2026-09-24, xem wideframe S03), ưu tiên dùng 3 loại này cộng ít nhất 1 loại chưa có ảnh (vd `quote`, `countdown`) để mở rộng coverage; vẫn còn 12/16 loại hoàn toàn chưa có bằng chứng (xem mục 11).
- **🔴 Bắt buộc chuẩn bị cho TC-73 (sống sót qua automation overnight):** máy test phải đã cài đúng Apple Shortcut automation của Flow 03 (`03_shortcut-setup`) và **chạy được qua đêm** — không dùng máy ảo/simulator, không rút ngắn bằng đổi giờ hệ thống (cùng nguyên tắc đã áp dụng cho `DEC-E12`/`shortcut-flow-cases §10`). Nên bắt đầu chuỗi qua đêm **sớm nhất có thể** trong lịch execute vì đây là case chờ lâu nhất và quan trọng nhất.

---

## 8. Entry criteria

- Build TestFlight **1.2.17 (103)** cài được trên máy test, đã xác nhận số hiệu khớp đúng — nếu không cài được đúng build này, dừng và báo lại trước khi dùng build khác thay thế.
- Testware sẵn sàng: test basis (đã sửa khớp PDF), [test-analysis-component-editor.md](test-analysis-component-editor.md), wireframe S03 — cả 3 đã có tại thời điểm lập test plan này.
- Tài khoản test có sẵn tối thiểu 1 template dạng stack.
- **Smoke test ban đầu phải pass:** TC-01 (nút Components hiện đúng) và TC-05 (mở được S03, chọn được 1 thành phần) — nếu smoke fail, dừng lại, không tiếp tục các mục khác của test plan.

## 8.1 Suspension & Resumption criteria

- **Dừng toàn bộ ngay lập tức** nếu phát hiện mất dữ liệu **không phục hồi được** ở nhóm REG (vd lock screen thật hỏng vĩnh viễn, dữ liệu event/wallpaper gốc của user bị ghi đè) — báo dev/PO trước khi tiếp tục bất kỳ case nào khác, đúng tinh thần severity Critical ở `bugs/bug-log.md`.
- **Tạm dừng cục bộ nhóm DRG hoặc RSZ** nếu >50% case P1 trong nhóm đó fail liên tiếp — các nhóm ADD/NST/REG phụ thuộc DRG/RSZ hoạt động đúng để dựng được layout test, tiếp tục chạy sẽ cho kết quả không đáng tin.
- **Resume:** chạy lại **từ đầu cụm đã suspend** sau khi có bản fix mới, không tiếp tục giữa chừng — state canvas (vị trí, lịch sử Undo) dễ bị ảnh hưởng bởi case chạy trước đó trong cùng cụm.

## 9. Exit criteria

- Toàn bộ **27 test condition P1** đã chạy, **0 bug Critical/High còn mở** trong nhóm P1.
- Case P2 đã chạy **≥ 90%**, không có case nào trong nhóm **REG** fail (đây là nhóm rủi ro cao nhất, không chấp nhận exit nếu còn REG fail).
- Câu hỏi #1 (mục 10, thiết bị/OS) — **đã trả lời** (✅ xong, xem test-analysis). Câu hỏi #2–#8 (mục 10) — nếu chưa trả lời hết, chấp nhận exit **chỉ khi** đã ghi rõ thành known gap được PO xác nhận, không chặn release ngầm.
- Toàn bộ nhóm **REG** và **INT** đã chạy — không phát hiện sai lệch nào so với hành vi tài liệu hoá của test basis.
- Coverage tối thiểu: đã thử **≥ 3 loại component** khác nhau (không chỉ Timetable) trên ít nhất nhóm SEL/RSZ/PRP.

---

## 10. Gap cần làm rõ trước khi execute

> Câu #1–#5 kế thừa nguyên trạng từ [test-analysis mục 4](test-analysis-component-editor.md#4-câu-hỏi-cần-làm-rõ-trước-khi-lập-test-plan) — câu #1 đã giải quyết, giữ lại để tra cứu nhanh không cần mở file khác. Câu #6–#8 mới phát hiện khi lập test plan này.

1. ~~Bảng thiết bị/OS bị vỡ định dạng~~ — **✅ Đã giải quyết** (đối chiếu PDF gốc). Không ảnh hưởng scope nữa.
2. **[Ảnh hưởng RSZ-DT4 / TC-27]** Trong 1 Row có 3+ thành phần con, kéo góc đổi bề rộng 1 phần tử thì các phần tử còn lại bù trừ thế nào?
3. **[Ảnh hưởng TC-28]** Giá trị bề rộng tối thiểu cụ thể (pt hoặc %) khi kéo góc thu nhỏ là bao nhiêu?
4. **[Ảnh hưởng TC-31]** "Giống Studio" (dòng 77) nghĩa là gì, và giá trị lề 2 bên mặc định của thành phần mới thêm là bao nhiêu?
5. **[Ảnh hưởng NST cấp 4 / TC-39, TC-41]** "Tối đa 3 cấp container" — canvas gốc có tính là 1 cấp không, hay chỉ đếm số lớp Row/Column lồng nhau?
6. ~~Bấm + khi chưa chọn gì thì thành phần mới rơi vào đâu?~~ — **✅ Đã trả lời (2026-09-24):** chèn vào **giữa canvas (center)**. Đã thêm TC-71 vào test-analysis, xem EP nhóm ADD ở mục 5.
7. ~~Decorate (S02) và Component Editor (S03) có tương tác gì với nhau không?~~ — **✅ Đã trả lời (2026-09-24):** 2 tính năng **độc lập**, không ảnh hưởng dữ liệu của nhau — nhưng wallpaper cuối cùng phải **render đầy đủ những gì được edit từ cả 2 phần**. Đã thêm TC-72 (nhóm REG, P1) để verify đúng kỳ vọng "gộp đủ cả 2" này.
8. ~~Bố cục Component Editor vừa lưu có sống sót qua lần chạy automation Shortcut tiếp theo không?~~ — **✅ Đã trả lời (2026-09-24): bắt buộc phải sống sót và cập nhật đầy đủ** khi automation chạy — không phải "chấp nhận được nếu mất". Đã thêm **TC-73** (nhóm REG, P1) — đây là case quan trọng nhất của cả test plan dù test basis không nhắc tới, đúng tiền lệ `DEC-Q01`. **Phải test qua đêm thật**, không rút ngắn được bằng đổi giờ hệ thống.
9. **[Mới — ảnh hưởng TC-54, phát hiện QA 2026-09-24]** **Nên bổ sung dialog xác nhận khi bấm ✕ (Cancel) có thay đổi chưa lưu không?** Đã kiểm tra thực tế: hiện tại **không có dialog nào**, thoát thẳng mất hết thay đổi không cảnh báo — đúng theo test basis (dòng 127) nên không phải bug, nhưng **khác hẳn S02 (Decorate)** vốn có popup "Discard changes?" xác nhận cho đúng loại hành động mất dữ liệu này. QA khuyến nghị bổ sung để nhất quán UX trong cùng 1 flow, nhưng cần PO/design xác nhận đây có phải chủ đích (S03 đơn giản hơn S02 vì thường sửa nhỏ, ít rủi ro mất công sức lớn) hay là thiếu sót cần fix trước khi ship.

---

## 11. Coverage gap — case chưa được test basis liệt kê

| # | Thiếu gì | Vì sao là gap |
|---|---|---|
| 1 | **15/16 loại component** khác ngoài Timetable — chưa có ảnh tham chiếu nào | Test basis viết chung chung "chọn một loại bất kỳ", không phải riêng Timetable — QC cần chủ động chọn thêm vài loại đại diện (có/không có container, top-level/trong Row) khi thiết kế test-case, không chỉ lặp lại Timetable |
| 2 | ~~Bấm **+** khi chưa chọn gì~~ | ✅ **Đã giải quyết** — xem câu hỏi #6 (mục 10) và TC-71 (test-analysis, nhóm ADD) |
| 3 | ~~Tương tác Decorate (S02) ⇄ Component Editor (S03)~~ | ✅ **Đã giải quyết** — 2 tính năng độc lập, wallpaper cuối phải gộp đủ cả 2 (câu hỏi #7, mục 10; TC-72 trong test-analysis) |
| 4 | ~~Bố cục mới có sống sót qua automation Shortcut overnight không~~ | ✅ **Đã giải quyết** — bắt buộc phải sống sót (xác nhận qua dev, câu hỏi #8 mục 10; TC-73 trong test-analysis, P1, **quan trọng nhất cả test plan**) |
| 5 | ~~Dialog xác nhận khi bấm ✕ (Cancel)~~ | ✅ **Đã kiểm tra thực tế 2026-09-24: KHÔNG có dialog** — thoát thẳng, mất hết thay đổi không cảnh báo. Đúng theo spec (dòng 127), không phải bug — nhưng khác S02 (có popup Discard), **QA khuyến nghị bổ sung**. Đã thêm câu hỏi #9 (mục 10) để PO/design quyết định chính thức |
| 6 | Chưa có **exploratory checklist** riêng cho S03 | Khác mọi flow khác trong repo đều có ít nhất 1 vòng khám phá tự do trước khi có test plan — S03 là **"gesture-heavy editor"** giống Decorate (kéo/resize/lồng container), nhiều khả năng có tổ hợp thao tác tự do mà checklist theo test basis không phủ hết. Khuyến nghị chạy skill `exploratory-checklist` cho S03 sau khi test plan này execute xong lần đầu |
| 7 | ~~Toast "Added ..."~~ ✅ đã có ảnh (`added.png`, `added-v2.png`, bổ sung 2026-09-24) — xác nhận thêm **phát hiện mới:** thành phần vừa thêm **không tự động được chọn** (không viền/pill), khác kỳ vọng của wireframe đề xuất cũ (WPC-4b). Badge **PRO** trong sheet Add component vẫn **chưa có bằng chứng** — cần chụp bổ sung hoặc hỏi dev |
