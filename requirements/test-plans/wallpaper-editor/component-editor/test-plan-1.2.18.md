# Test Plan — Wallpaper Component Editor (TestFlight 1.2.18 (111, rc3))

> ✅ **Test Plan Status: `READY` — CÓ ĐIỀU KIỆN** *(kế thừa từ Analysis Status `READY` có điều kiện do **QC (người) duyệt ngày 2026-09-28**, phương án "A. Cho phép chạy Test Plan ngay"; agent `qc-test-plan` chỉ đánh giá theo bảng trạng thái, **quyết định gọi `test-case` thuộc orchestrator**)*
>
> **Vì sao không có banner `DRAFT`:** mục 10 không còn gap nào **đang mở** mà ảnh hưởng **scope hoặc priority** — Q-4 (scope) đã được người duyệt **descope chính thức** (mục 3); Q-7 / Q-10 / Q-12 chỉ làm đổi **expected result** của các condition đã có priority, **không** đổi scope/priority, và đã được người duyệt chấp nhận làm **giả định làm việc**.
>
> **READY này KHÔNG có nghĩa là spec đã hết mơ hồ.** Ba điều kiện bắt buộc kèm theo (vi phạm = test plan không hợp lệ — bảng tự kiểm ở mục 12):
> 1. **Q-7 · Q-10 · Q-12 vẫn là ASSUMPTION (QC chấp nhận), CHƯA có dev xác nhận** — không được ghi như fact ở bất kỳ tài liệu downstream nào. Mâu thuẫn **§7.07 ↔ §7.08** vẫn nằm nguyên trong test basis. Dev trả lời khác ⇒ **dev thắng**, chỉ các condition ⚠️ tương ứng phải viết lại.
> 2. **TC18-99 / TC18-100 (Q-4) ra khỏi phạm vi thực thi** — `GAP`, không có expected result (mục 3).
> 3. **Mang nguyên 18 nhãn ⚠️ (gap-dependent) kèm điều kiện thay đổi** (mục 6.3) và các nhãn **(QC)** (mục 6.4). Test-case **không được** bỏ/làm gọn nhãn.
>
> **Chỉ được thiết kế test-case** với đúng ràng buộc trên; **thực thi** còn bị chặn bởi Entry criteria (mục 8) — hiện **chưa đủ** (build 111 chưa xác nhận trên máy, baseline screenshot Q-19 chưa chụp).

> **Test basis:** [QC — Component Editor 1.2.18.md](../../../specs/wallpaper-editor/component-editor/QC%20—%20Component%20Editor%201.2.18.md) — TestFlight **1.2.18 (111)**, tag `v1.2.18-rc3`, PR #226 · #325 · #326, chép từ ảnh trang dev ngày 2026-09-28. **Chỉ §0–§13** là requirement; phần "Ghi chú của QC" ở cuối file **không phải requirement**.
> **Test analysis (input chính):** [test-analysis-1.2.18.md](test-analysis-1.2.18.md) — **118 test condition trong phạm vi (P1 41 · P2 58 · P3 19)** + 2 GAP ngoài phạm vi; dùng trực tiếp, **không phân tích lại**. Câu trả lời/giả định: [answers-1.2.18.md](answers-1.2.18.md).
> **Chuẩn:** ISTQB Foundation Level v4.0.1 (test basis → test object → kỹ thuật thiết kế → rủi ro → entry/exit)
> **Test case cụ thể:** [test-cases-1.2.18.md](test-cases-1.2.18.md) — *chưa tồn tại*; sẽ sinh bởi skill `test-case` **nếu và chỉ nếu** orchestrator xác nhận Test Plan Status = READY.
> **Đối chiếu tài liệu đã có:** [diff-component-editor-1.2.17-vs-1.2.18.md](../../../specs/wallpaper-editor/component-editor/diff-component-editor-1.2.17-vs-1.2.18.md) · bộ 1.2.17 (giữ nguyên, **không sửa**): [test-plan-component-editor-SUPERSEDED.md](test-plan-component-editor-SUPERSEDED.md) · [test-analysis-component-editor-SUPERSEDED.md](test-analysis-component-editor-SUPERSEDED.md) · [test-cases-component-editor-SUPERSEDED.md](test-cases-component-editor-SUPERSEDED.md) · [wireframe § S03](../../../ui/ux/wideframes/14_edit-wallpaper.md) · [exploratory 14_edit-wallpaper.md § S03](../../../exploratory/14_edit-wallpaper.md) · `bugs/` (đã rà: **không có bug nào** liên quan Component Editor).
> **Ngày lập:** 2026-09-28 · **Người lập:** QC (agent `qc-test-plan`)

---

## 1. Phát hiện khi đối chiếu với tài liệu đã có

### 1.1 Bảng đối chiếu V-cũ (1.2.17) → V-mới (1.2.18)

Test basis 1.2.17 đã `-SUPERSEDED`. Bộ test 1.2.17 **giữ nguyên để truy vết**, nhưng 4 mục sau **không còn đúng** — tester **không được chạy lại nguyên trạng**:

| Bộ 1.2.17 | Kỳ vọng cũ | 1.2.18 | Thay bằng |
|---|---|---|---|
| **TC-14** | Kéo có chặn trên/dưới **vùng nội dung** | §4.03/§4.04: giới hạn là **mép ảnh**; band đầu qua được vạch trên grid | TC18-22 · **TC18-23** · **TC18-24** |
| **TC-29** | Sheet Add đủ **6 nhóm** (có Text) | §6/§7.22: **5 nhóm, 16 mục**, bỏ Text; Quote/Almanac day/Timeline không thêm mới | **TC18-54** · TC18-55 · TC18-56 |
| **TC-66** | Lúc kéo chữ **không** xuống dòng lại, chiều cao không đổi | §5.04: resize → chữ xuống dòng lại + đổi chiều cao **ngay lúc kéo** (đảo ngược) | **TC18-47** (resize) · TC18-40 (move: chữ hơi mềm 2/3 độ phân giải) |
| **TC-67** | Thẻ nền container không đổi theo từng frame | §4.12 + §10 #8 (Q-1, cách hiểu A **(QC)**) | **TC18-36a** (kéo container → thẻ đi cùng) + **TC18-36b** (kéo con → thẻ tạm ẩn, cố ý) |

Các mục còn lại (TC-01…TC-73) **tái sử dụng nội dung**, chỉ đổi mã trace sang `§N.M` (ánh xạ đầy đủ: test-analysis mục 3B). TC-71 / TC-72 / TC-73 (nguồn: trao đổi miệng 2026-09-24) → TC18-61 / TC18-115 / TC18-116: QC xác nhận **còn đúng ở 1.2.18** (Q-11) nhưng **vẫn nằm ngoài spec** → giữ nhãn ⚠️.

### 1.2 Điểm khác/lỗi thời so với tài liệu hình ảnh cũ

1. **Bộ ảnh S03 (15 ảnh, wireframe § S03, index screenshot) là lứa 1.2.17, chụp 2026-09-24** — wireframe ghi *"6 nhóm: Calendar · Events · Tasks · Progress · Text · Layout"*, còn 1.2.18 chỉ **5 nhóm** (§6, §7.22). **Không dùng bộ ảnh này làm oracle cho 1.2.18** (sẽ báo sai). Chưa có ảnh nào cho: pill ↑/↓, chip gap âm, đường gióng snap, grabber, ✕. Ảnh sheet Add QC gửi 2026-09-28 khớp spec (16 mục/5 nhóm) nhưng **chưa hiện số build** → phải chụp lại kèm build 111 (Q-19) — là **entry criterion** (mục 8).
2. **`exploratory/14_edit-wallpaper.md` § S03** (case `CMP-H28` "đủ 6 nhóm…Text") **cũng lỗi thời** theo 1.2.18. Không sửa file đó ở bước này (ngoài quyền hạn); khi thiết kế test-case phải bỏ qua các dòng CMP-* mâu thuẫn với mục 1.1.
3. **`bugs/`**: không có bug nào liên quan → không có regression từ bug cũ; regression của 1.2.18 đến từ **danh sách "đã sửa" ở §0/§4/§6.1** của chính test basis (mục 4).
4. **Danh mục component không chính thức (TB-22)** — xem mục 2.2: chỉ ~10 loại có knob trong spec.

---

## 2. Test object — In scope

### 2.1 Bảng test object và mã nhóm case

> **Gap-dependent** = nhóm chứa ≥1 condition ⚠️ (mục 6.3). Số P1/P2/P3 là số **test condition** (không phải số test case). Tổng: **118 = P1 41 · P2 58 · P3 19**.

| # | Test object | Mã nhóm | Test condition (TC18-…) | Nguồn (test basis) | P1 | P2 | P3 | Gap-dependent |
|---|---|---|---|---|---|---|---|---|
| 1 | Entry & gating: build, nút Components, header, coach mark | **ENT** | 01–05 | header, §2, §10 #5 | 2 | 1 | 2 | — |
| 2 | Thiết bị/OS: iPhone iOS 18.x, 26.x (glass), **iPad xoay (nếu có)** | **DEV** | 06, 07, 108 | §1, §9.04 | 1 | 2 | 0 | — *(TC18-108 có điều kiện thiết bị, Q-20)* |
| 3 | Bản địa hoá VI + EN | **LOC** | 08 | §1 | 0 | 1 | 0 | — |
| 4 | Chọn thành phần (đơn, lồng container, đi sâu), Delete + Undo | **SEL** | 09–14 | §3.01–§3.06, §10 #4 | 3 | 3 | 0 | — |
| 5 | **Đổi thứ tự ↑/↓ (←/→), Fixed, Duplicate** *(mới)* | **ROD** | 15–20 | §3.07–§3.09, §10 #13 | 4 | 2 | 0 | ⚠️ **TC18-19, 20** (Q-10) |
| 6 | Di chuyển — kéo, giới hạn mép ảnh, invariant, thẻ nền | **DRG** | 21–24, 30–39 (36a/36b) | §4.01–§4.04, §4.07–§4.15, §10 #8 | 9 | 6 | 0 | ⚠️ **TC18-23, 24** (Q-8) |
| 7 | **Snap dọc, chip gap âm, haptic** *(mới)* | **SNP** | 25–29 | §4.05, §4.06 | 3 | 2 | 0 | ⚠️ **TC18-25, 27** (Q-12) |
| 8 | Đổi bề rộng — kéo góc | **RSZ** | 44–52 | §5.01–§5.08 | 4 | 5 | 0 | ⚠️ **TC18-51** (Q-13) |
| 9 | Thêm thành phần, sheet Add 16 mục/5 nhóm | **ADD** | 54–61 | §6, §6.01–§6.04, §7.22 | 0 | 7 | 1 | ⚠️ **TC18-61** (Q-11a, ngoài spec) |
| 10 | Row/Column, ô trống, giới hạn 3 cấp, container rỗng | **NST** | 62–72 | §6.1, §6.2, §6.3 | 1 | 5 | 5 | ⚠️ **TC18-68, 70** (Q-3b) |
| 11 | Bảng thuộc tính — nền (Position, Width, Size, Duplicate/Delete/Deselect) | **PRP** | 74, 75, 76, 78, 79 | §7.01–§7.06 | 1 | 4 | 0 | — |
| 12 | **Bảng thuộc tính — slider, gesture, grabber/✕, canvas đẩy lên, đáy bảng** *(mới)* | **PUX** | 80–86 | §7.07–§7.11 | 4 | 3 | 0 | ⚠️ **TC18-80, 82** (Q-7) |
| 13 | Knob riêng theo loại, Size 200/60, Bold+Italic, Reset màu, **loại không có oracle knob** | **KNB** | 87, 88, 90–97, 118, 119 | §7.12–§7.21, §7.05, TB-22 | 0 | 9 | 3 | ⚠️ **TC18-118, 119** (TB-22) |
| 14 | Undo / Redo / Done / Cancel | **UND** | 101–104 | §8.01–§8.04 | 3 | 1 | 0 | — |
| 15 | Chrome phụ: Show grid, cảnh báo tràn màn, ẩn/hiện chrome | **CHR** | 105–107 | §9.01–§9.03 | 0 | 2 | 1 | ⚠️ **TC18-106** (Q-8) |
| 16 | **Regression ngoài màn editor** (lock screen, Live Activity, widget, template cũ, Note, Decorate ⇄ S03, automation overnight, card frosted) | **REG** | 109–117 | §11.01–§11.06, §10 #6, TB-18 | 6 | 2 | 1 | ⚠️ **TC18-115, 116, 117** (Q-11 / Q-18) |
| 17 | Hành vi CỐ Ý — xác nhận, tránh báo nhầm | **INT** | 40, 41, 42, 43, 53, 73, 77, 89, 98 | §10 #1–3, #7, #9–#12, §7.13 | 0 | 3 | 6 | — *(TC18-89 mang nhãn (QC))* |
| | **Tổng** | | **118** | | **41** | **58** | **19** | **18 nhãn ⚠️** |

> Mỗi test condition thuộc **đúng 1 nhóm**. Mã nhóm (ENT, DEV, LOC, SEL, ROD, DRG, SNP, RSZ, ADD, NST, PRP, PUX, KNB, UND, CHR, REG, INT) sẽ là tiền tố ID của `test-cases-1.2.18.md`.

### 2.2 Danh mục component **chưa chính thức** (TB-22)

**Không có danh mục component chính thức, đầy đủ từ dev.** Sheet Add (ảnh QC 2026-09-28, khớp §6/§7.22) có **16 mục / 5 nhóm**; tên UI → tên code (`contributionGrid`, `reminderList`, `timelineCards`) **chỉ là suy luận, không dùng làm expected result**.

| Lớp | Loại component | Nguồn oracle | Cách test trong plan này |
|---|---|---|---|
| **A — có knob riêng trong spec (10 loại)** | Month grid · Mini month · Today's events · Timeline *(chỉ template có sẵn)* · Week events · Year progress · Countdown · Priority matrix · Hour timeline · Timetable | §7.14 – §7.21 | Kiểm knob **theo từng loại được nêu tên** (KNB: TC18-90 – 97) + vòng đời chung |
| **B — không có oracle knob (5 loại, thêm mới được)** | **Lunar calendar · Week schedule · Month progress · Reminders · Activity grid** | chỉ §7.05 nói chung chung | **TC18-118 ⚠️:** chỉ kiểm **vòng đời chung** (thêm + toast *Added…* + Undo · hiện đúng · chọn · kéo · đổi bề rộng · Duplicate/Delete + Undo). **KHÔNG kiểm/suy diễn knob** |
| **C — không có oracle knob (2 loại, chỉ trên template có sẵn)** | **Quote · Almanac day** | không có | **TC18-119 ⚠️:** chọn/kéo/đổi bề rộng/Duplicate/Delete + Undo; bảng thuộc tính **mở được**. **KHÔNG kiểm knob**. Ô *Lines* của Quote thuộc Q-4 → **GAP, ngoài phạm vi** |
| **Layout (2)** | Row · Column | §6.1 | Nhóm NST |

⇒ **7 loại không có oracle knob** (B + C) — chỉ vòng đời chung. Đếm kiểm chứng: 9 loại lớp A có trong sheet Add + 5 lớp B + 2 Layout = **16** ✓; Timeline, Quote, Almanac day nằm ngoài sheet.

---

## 3. Out of scope

| # | Hạng mục | Lý do | Điều kiện đưa lại phạm vi |
|---|---|---|---|
| 1 | **TC18-99 — Year progress "target date"** (§12) | **`GAP` — descope chính thức** (quyết định người duyệt 2026-09-28). §12 ghi rõ *"chưa có quyết định"*, không có acceptance criteria. **Không viết expected result.** Giả định QC (Year progress không có target date) **không dùng làm oracle** | **QC gửi ảnh chụp** chỗ thấy "target date" **+ dev chốt** → quyết định phạm vi mới của người review |
| 2 | **TC18-100 — Quote "chữ / số dòng"** (§12) | **`GAP` — descope chính thức**, như trên. Giả định QC (ô *Lines* phải có tác dụng; sửa chữ quote không phải requirement) **không dùng làm oracle** | **QC gửi mô tả** (làm gì / thấy gì / mong đợi gì) **+ dev chốt** |
| 3 | iPhone **iOS 27** | §1: ❌ — Shortcut đang lỗi sẵn trên iOS 27, không tính đợt này | — |
| 4 | 10 ngôn ngữ còn lại (ngoài VI/EN) | §1 yêu cầu chạy chính VI + EN; "nếu thấy chuỗi tiếng Anh lọt vào máy VI thì report" — không yêu cầu full-pass 12 ngôn ngữ | — |
| 5 | Đo hiệu năng **định lượng** (fps/latency), bán kính hút snap, ngưỡng góc/thời gian gesture, đơn vị chip gap, bề rộng tối thiểu, biên dưới/đơn vị Size, giá trị lề "giống Studio" | Đã **cố ý bỏ** (Q-3a, Q-7 phần ngưỡng, Q-12 phần đơn vị, Q-14, Q-15, Q-16) → condition ghi *"không có ngưỡng — kiểm hành vi, không kiểm giá trị"*. Đây là **quyết định phạm vi của QC**, không phải gap chưa xử lý | Dev bàn giao số cụ thể |
| 6 | **Knob riêng của 7 loại không có oracle** (mục 2.2) | Không có nguồn để viết expected result (TB-22); suy diễn = vi phạm `.claude/rules/testing.md` | Dev bàn giao danh mục chính thức (Q-22) |
| 7 | Bộ ảnh/wireframe/exploratory S03 lứa 1.2.17 **làm oracle** | Lỗi thời (mục 1.2) | Chụp lại baseline trên build 111 (Q-19) |
| 8 | PRO gating theo loại component | Kế thừa từ 1.2.17: test basis 1.2.18 không nhắc; không đủ căn cứ viết case | — |
| 9 | Automation/unit test | Plan này là black-box thủ công, đúng quy ước repo | — |

### 3.1 Ảnh hưởng chéo tới flow khác

> Đối chiếu [screenshot-naming.md §7](../../../../.claude/rules/screenshot-naming.md#7-flow-map--ink-calendar-ios). Flow nào 🚧 chưa build → không áp dụng.

| Flow | Ảnh hưởng? | Lý do / condition liên quan |
|---|---|---|
| `14_edit-wallpaper` (S01/S02 Decorate — cùng flow-no) | **Trực tiếp** | S03 mở từ S01 (nút Components cạnh crop). Dữ liệu độc lập nhưng wallpaper cuối phải **gộp đủ cả 2 phần** — **TC18-115 ⚠️** (Q-11b, ngoài spec). Cũng ảnh hưởng: sticker không biến mất khi kéo (TC18-37) |
| `10_lockscreen` | **Trực tiếp** | Kết quả cuối của mọi thay đổi bố cục — TC18-109; card frosted trên lock screen thật — TC18-117 ⚠️ |
| `03_shortcut-setup` | **Gián tiếp, rủi ro cao** | Wallpaper tự render mỗi sáng qua Shortcut automation; bố cục phải sống sót — **TC18-116 ⚠️** (Q-11c, ngoài spec, **chờ qua đêm thật**) |
| `04_discover` | **Gián tiếp** | Đường vào (Discover → template → Edit) và "Your collection" (thumbnail/widget cập nhật — TC18-111, mở lại template đã sửa — TC18-112) |
| `05_calendar` | **Gián tiếp** | Đường vào thứ hai (Calendar tab → nút cập nhật wallpaper → Edit) + nguồn dữ liệu event cho component dạng lịch |
| `08_paywall` | **Không xác định** | 1.2.18 không nhắc gating Pro cho component; không log case |
| `09_settings`, `06_task`, `07_note`, `01_onboarding`, `02_permission` | **Không** | Không entry point/pipeline dữ liệu chung (Note chỉ kiểm không bị ảnh hưởng — TC18-114) |
| `11_share`, `12_ai-assistant`, `13_community` | **Không áp dụng** | 🚧 chưa build |

---

## 4. Test levels & test types

- **Level:** **System testing**, black-box, thủ công, trên **TestFlight 1.2.18 (111, rc3)** (ISTQB §2.2.1). Không dùng simulator cho DRG/SNP/PUX (cần cảm nhận cử chỉ + haptic → **máy thật**). REG có phần **Integration/System-integration** với lock screen, Live Activity, widget, Shortcut automation.
- **Functional:** tất cả 17 test object.
- **Non-functional (ISO 25010 — §2.2.2):**

| Quality characteristic | Áp dụng cho | Condition tiêu biểu |
|---|---|---|
| **Performance efficiency** | Phản hồi kéo/resize/slider realtime; kéo liên tục 5–10 s | TC18-21, 39, 46, 80 — **quan sát định tính, không có ngưỡng** (Q-15/Q-7 đã bỏ) |
| **Compatibility** | iOS 18.x vs 26.x (chrome glass); đáy bảng có/không home indicator | TC18-06, 07, 86 |
| **Usability** | Haptic snap, coach mark, vùng kéo 4 góc không vẽ, canvas tự đẩy lên, vị trí nút | TC18-03, 05, 29, 53, 85 |
| **Reliability** | Undo = 1 bước, không mất/nhân bản thành phần, render 1 lần, bố cục sống sót overnight, lưu đúng dữ liệu | TC18-14, 18, 33, 34, 48, 81, 101–104, 109–116 |
| **Portability** | Xoay iPad — **có điều kiện thiết bị** | TC18-108 |
| **Internationalization** (thuộc usability/portability) | Chuỗi mới VI/EN | TC18-08 |
| Security · Maintainability · Safety | **Không áp dụng** | Không có yêu cầu trong 1.2.18 |

- **Change-related (§2.2.3):**
  - **Confirmation testing** — các lỗi test basis nêu là **đã sửa** (§0, §4.13, §6.1.03, §7.07, §7.11): TC18-64 (ô trống Row/Column), TC18-19/20 (đè band khi reorder/duplicate), TC18-37 (sticker mất khi kéo), TC18-80 (slider khựng), TC18-86 (đáy bảng hở), TC18-33/34 (bản sao/nhảy vị trí).
  - **Regression testing — KHÔNG được rút gọn:** toàn nhóm **REG (9 condition)** vì màn này *"ghi thẳng vào dữ liệu wallpaper"* và phạm vi thay đổi 1.2.18 (snap, gap âm, reorder, kéo tới mép ảnh) **rộng hơn 1.2.17**; cộng các hành vi **đảo ngược** (TC18-23/24/35/36a/36b/47/54) để đảm bảo bản cũ không còn lọt vào test-case mới.

---

## 5. Kỹ thuật thiết kế test case

> Kỹ thuật chỉ áp dụng nơi test object thật sự phù hợp (ISTQB §4.1). Dữ liệu dưới đây dùng được ngay cho `test-case`; **mọi dòng ⚠️ giữ nhãn**.

### Bảng tóm tắt kỹ thuật theo nhóm

| Nhóm | Kỹ thuật chính | Kỹ thuật phụ |
|---|---|---|
| ENT | Equivalence Partitioning (loại template) | Checklist-based |
| DEV | Compatibility matrix (tập rời rạc, không EP/BVA) | — |
| LOC | Equivalence Partitioning (ngôn ngữ) | — |
| SEL | **State Transition** | EP theo độ sâu lồng (0/1/2/3) |
| ROD | **Decision Table** | State Transition (Undo 1 bước) |
| DRG | EP (đối tượng kéo) + **BVA** (biên mép ảnh) | Checklist-based (invariant), State Transition (thẻ nền) |
| SNP | **BVA 3-value trên dấu của gap** + Decision Table (điểm snap × loại band) | State Transition (đang nằm sẵn trên snap) |
| RSZ | Decision Table + BVA (số con trong Row) | Checklist-based |
| ADD | EP (trạng thái chọn khi bấm **+**; loại component) + Decision Table (ô trống) | Checklist-based (nội dung sheet) |
| NST | **BVA** (độ sâu 1/2/3) | State Transition (container rỗng) |
| PRP | State Transition (Auto ↔ Fixed) | Checklist-based |
| PUX | **Decision Table (gesture)** + **State Transition (bảng thuộc tính)** | — |
| KNB | EP (loại component A/B/C) + **BVA 2-value biên trên (Size 200/60)** + Decision Table 2×2 (Bold × Italic) | Checklist-based (theo từng loại) |
| UND | State Transition / Checklist (1 thao tác = 1 bước) | — |
| CHR | Checklist-based | — |
| REG | Checklist-based (có thứ tự phụ thuộc) | — |
| INT | Checklist-based (xác nhận hành vi cố ý, §10) | — |

**Exploratory (session-based):** **không** dùng nhãn exploratory cho case đã có đáp án. Đề xuất **1 phiên tuỳ chọn** (mục 5.18) cho phần test basis **tự thừa nhận không có oracle** (7 loại không có knob) — **không tính vào exit criteria**.

---

### 5.1 ENT — EP + Checklist-based

- **EP theo loại template:** {stack (mới) | không phải stack (cũ)} → nút Components chỉ hiện ở partition đầu (TC18-02, §10 #5).
- **TC18-01** (đúng build 111, rc3) là **entry criterion**, không phải test case thường (mục 8). Sai build ⇒ kết quả mọi nhóm vô nghĩa.
- Còn lại (vị trí nút, header ✕/Undo/Redo/✓, đáy + / Show grid, coach mark) → checklist từ §2.

### 5.2 DEV — Compatibility matrix

| Thiết bị | Bắt buộc | Áp dụng |
|---|---|---|
| iPhone **iOS 18.x** | ✅ (nền chính) | Toàn bộ 17 nhóm (TC18-06) |
| iPhone **iOS 26.x** | ✅ | Toàn bộ 17 nhóm; chrome **glass** render đúng (TC18-07, **P1**) |
| **iPad** (dọc + ngang) | **"Nếu có"** — **Q-20 chưa trả lời** | **TC18-108** tối thiểu: xoay → khung viền + ô trống khớp thành phần. Không có máy ⇒ ghi **"Not run — không có thiết bị"**, không tính fail (mục 9) |
| iPhone **iOS 27** | ❌ ngoài phạm vi | — |

### 5.3 LOC — EP

{Máy VI | Máy EN | 10 ngôn ngữ còn lại (out of scope)} → chỉ 2 partition đầu; kiểm chuỗi **mới** của 1.2.18 (toast *Added…/Removed…/Removed the empty layout*, tiêu đề mục *Weekday/Time/Date/Caption*, nhóm sheet Add, mô tả một dòng dưới từng mục) không lọt tiếng Anh vào máy VI (TC18-08).

### 5.4 SEL — State Transition

**States:** S0 Không chọn · S1 Đã chọn thành phần đơn · S2 Đã chọn container (cấp N) · S3 Đã chọn con (cấp N+1) · S4 Bảng thuộc tính mở (đang chọn) · S5 Đã chọn, bảng **đã đóng bằng grabber**.

| # | State | Event | State kế tiếp | Nguồn / condition |
|---|---|---|---|---|
| T1 | S0 | Chạm thành phần đơn | S1 (viền + pill Edit/Delete) | §3.01 · TC18-09 |
| T2 | S0 | Chạm thành phần **trong** container | **S2** (chọn container, không phải con) | §3.03, §10 #4 · TC18-11 |
| T3 | S2 | Chạm tiếp đúng con | S3 (đi sâu 1 cấp; lặp theo độ sâu) | §3.03 · TC18-11 |
| T4 | S1/S2/S3/S4 | Chạm **vùng trống** | S0 | §3.02 · TC18-10 |
| T5 | S1 | Delete component | S0 + toast *"Removed …"* + Undo (trả **đúng chỗ cũ**) | §3.06 · TC18-14 |
| T6 | S1 | Edit component | S4 | §3.05 · TC18-13 |
| T7 | S4 | **Grabber vuốt xuống** | **S5**: viền **còn**, thành phần **vẫn chọn**; nút **+** *chưa* hiện lại *(theo TC18-83 của test-analysis — chốt bằng ảnh baseline Q-19)* | §7.09 · TC18-83 |
| T8 | S4 | **✕** trong bảng | **S0**: bảng đóng · viền mất · **+** hiện lại **(QC · Q-17)** | §7.09 · TC18-84 |
| T9 | S4 | **Deselect** | **S0** — **cùng trạng thái cuối với T8 và T4 (QC · Q-17)** | §7.06 · TC18-79 |
| T10 | S1 | Chạm thành phần khác | Chọn thành phần mới, không cộng dồn *(suy luận QC — chỉ ghi nhận quan sát)* | — |

**Transition thử thêm (error guessing, nguồn: test plan 1.2.17):** chạm 2 lần **rất nhanh** vào cùng 1 con trong container — có nhảy cấp/double-select không (không có expected result trong spec ⇒ **ghi nhận quan sát**).
**EP theo độ sâu (TC18-11):** cấp 0 (đơn) · 1 · 2 · 3 — mỗi cấp chạm lần 1 = chọn container ngoài cùng, chạm tiếp mới đi sâu.

### 5.5 ROD — Decision Table (đổi thứ tự / Fixed / Duplicate)

**Điều kiện:** C1 Kiểu band (Auto/Fixed) · C2 Vị trí trong danh sách **chỉ gồm band Auto** (đầu/giữa/cuối) · C3 Container (stack-Column dọc → ↑/↓; Row → ←/→) · C4 Có band Fixed nằm giữa hai band Auto không.

| Rule | C1 | C2 | C3 | C4 | Kỳ vọng | Condition | Nguồn kỳ vọng |
|---|---|---|---|---|---|---|---|
| R1 | Auto | giữa | dọc | không | ↑ **và** ↓ hiện; bấm → đổi chỗ với band kế bên; **1 bước Undo** | 15, 18 | §3.07 (spec) |
| R2 | Auto | đầu | dọc | — | **↑ ẩn**, ↓ hiện | 16 | §3.07 (spec) |
| R3 | Auto | cuối | dọc | Fixed nằm **sau** nó | **↓ ẩn** (band Auto cuối vẫn là "cuối" dù còn Fixed phía sau) | 16 | **(QC · Q-9b)** |
| R4 | Auto | trên | dọc | Fixed **giữa** 2 Auto | bấm ↓ → **nhảy qua** Fixed, đổi chỗ với **Auto kế tiếp**; Fixed **đứng yên** | 17 | **(QC · Q-9a)** |
| R5 | **Fixed** | — | — | — | **không có** mũi tên; không bị tính là "kế bên" | 17 | §3.07, §10 #13 (spec) |
| R6 | Auto | giữa | **Row** | không | **←/→** thay cho ↑/↓; cùng quy tắc đầu/cuối | 15, 16 | §3.07 (spec) |
| R7 | Auto | đầu, **gap âm** | dọc | — | Đổi thứ tự: **không band nào đè band khác**; tổng chiều cao stack **không đổi**; gap âm **ở lại vị trí đầu** | **19 ⚠️** | **ASSUMPTION Q-10** (phần "không đè" là spec §3.08; phần "giữ gap từng vị trí" là giả định) |
| R8 | Auto | đầu, **gap âm** | dọc | — | **Duplicate** → bản sao nằm **dưới** bản gốc, có khoảng cách, không đè | **20 ⚠️** | spec §3.09 + **ASSUMPTION Q-10** (cách tính gap) |
| R9 | Auto | giữa | dọc | — | Hai band **cao/thấp khác nhau** đổi chỗ: không đè nhau | **19 ⚠️** | ASSUMPTION Q-10 — **đúng vùng dev chưa trả lời** |
| R10 | Auto | duy nhất trong danh sách | dọc | — | Cả ↑ và ↓ ẩn *(suy luận QC từ "đầu/cuối ẩn" — chỉ ghi nhận quan sát)* | 16 | suy luận, không phải spec |

> ⚠️ **TC18-19/20 — điều kiện thay đổi:** nếu dev trả lời **"giữ đỉnh ô/slot"** (thay vì giữ gap) ⇒ **viết lại expected result R7–R9** và có thể phải **thêm condition** cho trường hợp band cao đổi xuống slot thấp (Q-10).

### 5.6 DRG — EP + BVA + Checklist

**EP theo đối tượng kéo:** {thành phần đơn top-level | **container** Row/Column (con đi theo) | **con bên trong** container} × {container có thẻ nền | không có thẻ nền (mặc định)}. Bắt buộc dùng template có **Row lồng trong Column** (§4).

**BVA 3-value — biên "mép ảnh" (kéo dọc):**

| Biên | Giá trị test | Kỳ vọng | Condition |
|---|---|---|---|
| Dưới | (a) tới **vạch dưới grid** · (b) **quá** vạch dưới grid nhưng vẫn trong ảnh · (c) **đúng mép dưới ảnh** · (d) cố kéo **vượt** mép dưới ảnh | (a) snap đáy band khớp vạch · (b),(c) cho phép, **không** cảnh báo **(QC · Q-8)** · (d) bị chặn, không tràn ra ngoài ảnh | 23 ⚠️, 28 |
| Trên — **band đầu** | (a) chưa tới vạch trên grid · (b) qua vạch trên grid (vùng đồng hồ) · (c) đúng mép trên ảnh · (d) cố vượt | (a),(b),(c) cho phép, không cảnh báo · (d) bị chặn | 24 ⚠️ |
| Trên — **band khác** | kéo lên tới khi chạm band phía trên | **dừng** khi chạm, không đè | 22, 24 |

> ⚠️ **TC18-23/24/106 — điều kiện thay đổi (Q-8):** giả định còn lại là **"cạnh screen ≡ mép ảnh"**, **chưa xác nhận**. Nếu khi chạy quan sát thấy **có vùng giữa hai biên** (kéo được tới mép ảnh nhưng vẫn cảnh báo, hoặc ngược lại) ⇒ **không kết luận pass/fail** mà ghi nhận + hỏi dev; dev xác nhận hai biên khác nhau ⇒ **viết lại điều kiện bật cảnh báo** và **thêm condition cho vùng giữa hai biên**.

**Checklist invariant (áp dụng cho cả 3 EP):** đi theo ngón ngay (21) · không bản sao/không mất rồi hiện lại (33) · nhả tay render **1 lần**, không nhảy về chỗ cũ (34) · vẽ lại thật, band dưới dồn theo (35) · sticker không biến mất (37) · khung viền ôm đúng kể cả kéo nhanh (38) · kéo liên tục 5–10 s không giật/đứng hình — **không ngưỡng** (39) · kéo ngang (31) · band nằm sẵn trên điểm snap chạm kéo không bị giữ lại (30).

**State Transition — thẻ nền (Q-1, cách hiểu A **(QC)**), tách **2 case riêng**:**

| Case | Kéo gì | Thẻ nền (card) | Loại kỳ vọng |
|---|---|---|---|
| **TC18-36a** (P1) | **Cả container** Row/Column | **Đi cùng** con, không bị bỏ lại, không nhấp nháy | §4.12 |
| **TC18-36b** (P2) | **Một con bên trong**, container cha có thẻ nền | **Tạm ẩn khi kéo, hiện lại khi nhả** — **đúng thiết kế, KHÔNG report** | §10 #8 |

### 5.7 SNP — BVA (dấu của gap) + Decision Table + State Transition

**BVA 3-value trên gap của band đầu** *(chỉ kiểm **dấu và hành vi**, không kiểm giá trị tuyệt đối — đơn vị chip đã cố ý bỏ)*:

| Giá trị | Vị trí | Chip hiển thị | Condition |
|---|---|---|---|
| gap **< 0** (số âm) | band đầu **quá** vạch trên grid | **số âm** (vd `-40`) | 25 ⚠️ |
| gap **= 0** | đúng mốc gap 0 | **`0`** — và **không bao giờ `-0`** | 25 ⚠️, 27 ⚠️ |
| gap **> 0** | dưới mốc | số dương | 25 |

> ⚠️ **TC18-25/27 — điều kiện thay đổi (Q-12):** mốc gap = 0 của band đầu = **vạch trên grid** là **giả định** (kiểm bằng bật **Show grid**). Dev nêu mốc khác (**mép trên vùng nội dung** hoặc **mép trên ảnh**) ⇒ **điểm snap gap 0 đổi chỗ** ⇒ sửa 2 dòng này.

**Decision Table — điểm snap × loại band:**

| Rule | Điểm snap | Loại band | Kỳ vọng | Condition |
|---|---|---|---|---|
| S1 | **Giữa màn** | mọi | hút vào + **đường gióng ngang** hiện ra + rung | 26 |
| S2 | **Gap = 0** | **band đầu** | hút vào "chỗ khối bắt đầu" (= vạch trên grid — ⚠️ Q-12); nhả tay → chip `0` | 27 ⚠️ |
| S3 | **Gap = 0** | **band khác** | hút khi **vừa chạm band phía trên**; nhả → chip `0` | 27 ⚠️ |
| S4 | **Vạch dưới grid** | mọi | đáy band khớp vạch | 28 |

**Haptic (TC18-29, P2, **(QC · Q-6a/6b)**, máy thật):** rung nhẹ **1 lần cho MỖI điểm snap** hút vào (kéo qua 3 điểm ⇒ 3 lần); **2 điểm snap rất gần nhau** ⇒ hút vào điểm **gần hơn** và **chỉ rung 1 lần** (không rung kép). *Bán kính hút và "có rung khi rời điểm snap" **chưa xác định — không có expected result, ghi nhận quan sát**.*

**State Transition (§4.07, TC18-30):** {Ngoài vùng snap | Trong vùng hút | **Đang nằm sẵn trên điểm snap**}; từ trạng thái *nằm sẵn*, chạm kéo **không bị giữ lại** — phải ra khỏi điểm rồi mới hút lại.

**Chưa có oracle (không thiết kế expected):** hành vi snap khi band là **con trong Row/Column** (§4.06 chỉ nói "band"); tương tác snap + 0.1 s chờ (§10 #9) — xem mục 11.

### 5.8 RSZ — Decision Table + BVA

| Rule | Vị trí | Góc kéo | Kỳ vọng | Condition |
|---|---|---|---|---|
| Z1 | Ngoài cùng (stack/column) | Phải | Cạnh trái **đứng yên**, chỉ mép phải chạy; **vẫn canh giữa** | 44, 49 |
| Z2 | Ngoài cùng | Trái | Cạnh phải đứng yên | 45, 49 |
| Z3 | **Trong Row (2 con)** | bất kỳ | Vách ngăn: con bên cạnh **hẹp lại đúng bằng đó**, tổng bề rộng Row **không đổi** | 50 |
| Z4 | **Trong Row (3+ con)** | bất kỳ | ⚠️ **Chỉ kiểm phần bất biến:** không con nào co về 0, không con bị đẩy ra ngoài Row/đè nhau, **1 bước Undo**. **KHÔNG kiểm quy tắc bù trừ** (chia đều / liền kề / con cuối hấp thụ) | **51 ⚠️** |
| Z5 | Bất kỳ, thành phần có chữ | kéo hẹp | Chữ **xuống dòng lại + chiều cao đổi ngay lúc kéo** (không méo, không chờ nhả) — **đảo ngược so với 1.2.17** | 47 |

**BVA số con trong Row:** 1 (không áp dụng) · **2** (Z3) · **3** (biên dưới "3+", Z4) · N lớn (không vỡ UI). **Min-width:** không có ngưỡng ⇒ chỉ xác nhận **có chặn / không co về 0** (TC18-52), **không kiểm giá trị**. Còn lại: realtime (46), nhả tay không nhảy/đổi lần nữa (48), 4 góc là vùng kéo dù không vẽ vòng (INT: 53).

> ⚠️ **TC18-51 — điều kiện thay đổi:** Q-13 (Row 3+ con bù trừ thế nào) còn mở; dev trả lời ⇒ thêm Rule kiểm quy tắc cụ thể, gỡ ⚠️.

### 5.9 ADD — EP + Decision Table + Checklist

**EP trạng thái chọn khi bấm +:** {đang chọn 1 thành phần (59: rơi **ngay dưới**) | đang chọn Row/Column (60: rơi **vào trong**) | **không chọn gì** (61 ⚠️: chèn **giữa canvas** — **(QC · Q-11a)**, **KHÔNG có trong spec 1.2.18**)}.

**Checklist sheet Add — oracle: spec §6/§7.22 + ảnh QC (16 mục / 5 nhóm; chụp lại trên build 111 — Q-19)** (TC18-54, 55, 56):
CALENDAR (5) Month grid · Mini month · Lunar calendar · Timetable · Week schedule — EVENTS (4) Today's events · Hour timeline · Week events · Activity grid — TASKS (2) Reminders · Priority matrix — PROGRESS (3) Year progress · Month progress · Countdown — LAYOUT (2) Row · Column. **Không có nhóm Text**; **Quote/Almanac day/Timeline không có** (EVENTS chỉ 4 mục); tên hiển thị đúng **"Timetable"**, **"Activity grid"**, **"Reminders"**; mỗi mục có **một dòng mô tả**. Kiểm tra **âm tính:** 3 loại vắng vẫn **sửa được trên template có sẵn** (TC18-56).

**EP loại component (TC18-57, 58):** lặp "thêm → toast *Added…* + Undo → **không full-width** (có lề hai bên)" cho **14 mục không thuộc Layout**. *Không kiểm giá trị lề (Q-14 đã bỏ).*

**Decision Table ô trống (thuộc NST):** chạm đúng **nút +** ⇒ mở sheet, thành phần lấp **đúng ô đó**, ô còn lại giữ nguyên (TC18-64, P1, regression lỗi đã fix) · chạm **nền ô** ⇒ **chọn container**, không mở sheet (65).

### 5.10 NST — BVA (độ sâu) + State Transition

| Cấp container | Kỳ vọng | Condition |
|---|---|---|
| 1 | Sheet Add còn nhóm **Layout** (16 mục / 5 nhóm) | 69 |
| 2 | Layout vẫn hiện | 69 |
| **3** (biên trên hợp lệ) | Layout **biến mất** — còn **14 mục / 4 nhóm** | **68 ⚠️** |
| Sibling ở cấp còn cho phép | vẫn thêm được | **70 ⚠️** |

> ⚠️ **TC18-68/70 — điều kiện thay đổi (Q-3b còn mở):** **cách đếm cấp** ("Tối đa 3 cấp" — canvas/stack gốc có tính 1 cấp không) chưa chốt. **Kiểm bằng cách lồng thực tế `Column > Row > Column`** (ví dụ hợp lệ của §6.2), **không suy diễn mốc đếm**, **không thiết kế "cấp 4"**. Dev chốt cách đếm ⇒ gỡ ⚠️ và có thể thêm case cấp 4.

**State Transition — container rỗng (§6.3):** {Container rỗng đang có} —**Done**→ {container bị bỏ + toast *"Removed the empty layout"* + Undo} —**Undo**→ {container quay lại editor} (TC18-71, 72). Còn lại: 2 ô trống nét đứt Row cạnh nhau / Column xếp dọc (62, 63) · lấp đủ → chia đôi (66) · đủ con không còn ô thừa (67) · INT: Row 1 con vẫn chiếm chỗ như 2 con (73).

### 5.11 PRP — State Transition + Checklist

**Auto ↔ Fixed:** 2 state; chuyển **cả 2 chiều không làm thành phần tự nhảy chỗ** (TC18-74, P1); ở Fixed hiện **Vertical position**, kéo thì chạy dọc (75); **Width** đồng bộ 2 chiều với kéo góc (76); **Duplicate · Delete · Deselect** đúng, Deselect cùng trạng thái cuối với ✕ / chạm vùng trống **(QC · Q-17)** (79); knob theo loại — chỉ kiểm giá trị cho **lớp A** (78), lớp B/C xem KNB.

### 5.12 PUX — Decision Table (gesture) + State Transition (bảng)

**Decision Table gesture slider (nhóm Position) — ⚠️ toàn bảng dựa trên ASSUMPTION Q-7:**

**Giả định làm việc (Q-7, QC chấp nhận — CHƯA có dev xác nhận):** hướng cử chỉ được **khoá một lần từ đầu**, giữ tới khi nhả tay; đã khoá thì **không đổi giữa chừng**.
**Mâu thuẫn §7.07 ↔ §7.08 vẫn nằm nguyên trong test basis.**

| Rule | Điểm bắt đầu | Hướng ban đầu | Giữa chừng | Kỳ vọng | Condition |
|---|---|---|---|---|---|
| G1 | Trên slider | **Thiên về ngang** | không đổi | Slider **chạy mượt**, canvas chạy theo **ngay**, bảng **không cuộn** | 80 ⚠️, 82 ⚠️ |
| G2 | Trên slider | Thiên về ngang | Tay **lệch dọc nhẹ / kéo qua kéo lại** | Slider **vẫn chạy, không khựng**, bảng vẫn không cuộn (đã khoá) | **80 ⚠️** |
| G3 | Trên slider | **Gần thẳng dọc** | — | **Bảng cuộn**, **giá trị slider không đổi** | **82 ⚠️** |
| G4 | Trên slider (đã khoá slider) | — | Vuốt dọc mạnh giữa chừng | **Không đổi sang cuộn bảng** (không đổi giữa chừng) | 82 ⚠️ |
| G5 | Ngoài slider | Dọc | — | Bảng cuộn bình thường *(đối chứng — suy luận QC)* | 82 |

**Không có ngưỡng góc/thời gian** (đã cố ý bỏ) — chỉ kiểm **hành vi**, không kiểm giá trị. Còn: nhả tay = **1 bước Undo** (TC18-81, P2, **không** ⚠️); INT: số cạnh tên slider chỉ cập nhật **khi nhả tay**, lúc kéo xem **bong bóng** (98).

> ⚠️ **TC18-80/82 — điều kiện thay đổi:** dev nêu **quy tắc gesture khác** (vd slider giành cử chỉ tới cùng, hoặc không khoá hướng) ⇒ **viết lại expected result G1–G4**; nếu dev **sửa spec** để gỡ mâu thuẫn §7.07 ↔ §7.08 ⇒ gỡ ⚠️ theo đúng chuỗi (answers → test-analysis → test-plan → test-case).

**State Transition bảng thuộc tính** — dùng lại bảng **5.4 (T4–T9)**: grabber (T7, TC18-83, P1) khác hẳn ✕ / Deselect / chạm vùng trống (T8/T9/T4, TC18-84, P1) ở chỗ **grabber giữ selection**. Còn: **canvas tự đẩy lên** khi bảng che thành phần, đóng thì về chỗ cũ (85) · **đáy bảng không hở** trên máy **có và không có home indicator** (86).

### 5.13 KNB — EP + BVA 2-value + Decision Table 2×2 + Checklist theo loại

**Checklist theo từng loại lớp A** (mỗi loại **một case riêng**, không kiểm chung — test-analysis mục 3A):

| Loại | Knob/kiểm | Nguồn | Condition |
|---|---|---|---|
| Month grid | Mục **Weekday** riêng · màu ngày **quá khứ/tương lai** (mục **Day**) · căn phải tiêu đề tháng | §7.14, §7.18 | 90, 94 |
| Mini month | Mục **Weekday** riêng | §7.14 | 90 |
| Today's events | Mục **Time** riêng | §7.14 | 90 |
| Timeline *(template có sẵn)* | Mục **Time** · **Blur** nền thẻ có tác dụng · **không còn** "Cards per day" | §7.14, §7.21 | 90, 97 |
| Week events | Mục **Date** riêng | §7.14 | 90 |
| Year progress | Mục **Caption** riêng *(không kiểm "target date" — GAP)* | §7.14 | 90 |
| Countdown | Mục **Caption**; sửa **chữ caption** (Content → Caption); để trống = **ẩn caption**; áp khi Done/ra ngoài ô = **1 bước Undo** | §7.14, §7.16 | 90, 92 |
| Priority matrix | Màu chữ **ghi chú / công việc / giờ** riêng · **Blur** nền ô · **không còn "Layout"** · **↺ Reset** → bộ **4 màu** theo từng ô | §7.15, §7.17 | 91, 93 |
| Hour timeline | **Elapsed color** có tác dụng | §7.19 | 95 |
| Timetable | Đổi **cỡ chữ ngày** và **màu giờ** có tác dụng | §7.20 | 96 |

**BVA 2-value — thanh Size (§7.12, TC18-87):** chữ chính **tối đa 200**, chữ phụ (caption, giờ, thứ…) **tối đa 60**. Giá trị test: **200** / **60** (biên trên hợp lệ) và **"cố kéo vượt trần"** (phải bị chặn). **Chỉ biên trên** — không có biên dưới/đơn vị (Q-16 đã bỏ). Template có sẵn **đang vượt trần** ⇒ **ghi nhận quan sát, không kết luận pass/fail**.

**Decision Table 2×2 — Bold × Italic (TC18-88):**

| Rule | Bold | Italic | Kỳ vọng |
|---|---|---|---|
| B1 | tắt | tắt | thường |
| B2 | bật | tắt | đậm |
| B3 | tắt | bật | nghiêng |
| **B4** | **bật** | **bật** | **vừa đậm vừa nghiêng** (trước chỉ ăn 1) |

TC18-89 (INT, P3, **(QC · Q-2)**): tiêu đề giờ "đậm hơn trước" ở 2 template có sẵn (month *elegant script*, priority matrix) là **đúng dữ liệu template — KHÔNG report**; chưa rõ phần tử nào ⇒ **đối chiếu ảnh, chỉ ghi nhận**.

**Lớp B/C — TC18-118, TC18-119 ⚠️ (TB-22):** **chỉ vòng đời chung**, **cấm suy diễn knob**.
> ⚠️ **Điều kiện thay đổi:** dev bàn giao **danh mục chính thức** (tên UI ↔ tên code ↔ knob riêng) ⇒ thêm case knob cho 7 loại, gỡ ⚠️.

### 5.14 UND — State Transition / Checklist

Mọi thao tác ghi dữ liệu = **đúng 1 bước Undo**: một lần kéo (101, không phải từng frame) · mỗi lần bấm mũi tên đổi thứ tự (18) · nhả slider (81) · áp caption Countdown (92) · thêm/xoá/duplicate. **Redo** làm lại đúng thao tác (102). **✓ Done** → giữ bố cục (103). **✕ Cancel** → **mọi** thay đổi trong phiên bị bỏ (kể cả thành phần vừa thêm), wallpaper về **đúng như lúc mở màn** (104).

### 5.15 CHR — Checklist-based

**Show grid** bật/tắt, lưới **không đè lên thao tác kéo** (105) · **cảnh báo *"Part of this runs off the screen"*** (106 ⚠️ — xem 5.6; kéo về trong thì cảnh báo mất) · ẩn/hiện chrome (107).

### 5.16 REG — Checklist-based, có thứ tự phụ thuộc

Mỗi dòng = 1 case độc lập, **chạy SAU** khi ROD/DRG/SNP/RSZ/ADD/NST/PRP/PUX/UND đã pass (regression kiểm tra kết quả **đã lưu**). TC18-109 lock screen thật · 110 Live Activity · 111 widget/thumbnail "Your collection" · 112 mở lại template đã sửa · 113 template lịch cũ y như trước · 114 Note không ảnh hưởng · **115 ⚠️** S03 + Decorate gộp đủ cả 2 · **116 ⚠️** sống sót automation overnight (**qua đêm thật, KHÔNG đổi giờ hệ thống; khởi động sớm nhất**) · **117 ⚠️** card frosted.
> ⚠️ **Điều kiện thay đổi:** **115/116** — dev đưa vào tài liệu bàn giao chính thức ⇒ gỡ ⚠️; dev phủ nhận ⇒ bỏ condition. **117** — Q-18: "đúng" = sticker **được** hay **không được** làm mờ chưa chốt ⇒ **chỉ ghi nhận quan sát kèm ảnh, không kết luận pass/fail** tới khi dev chốt.

### 5.17 INT — Checklist-based (xác nhận, không phải tìm lỗi)

Mỗi mục = "đây là **đúng thiết kế**, không report": 40 (§10 #7 chữ mềm 2/3 độ phân giải khi kéo, **nhả là nét** — chỉ lỗi nếu vẫn mờ) · 41 (#9 chờ ~0.1 s) · 42 (#10 band đầu trên vạch grid; 4 template `mix-class-schedule`, `mix-daily-brief`, `mix-focus-today`, `mix-mindful-month`) · 43 (#11 viền thẻ nền có thể nằm trên vạch grid) · 53 (#3 4 góc là vùng kéo dù không vẽ) · 73 (#1 Row/Column 1 con) · 77 (#2 con trong container không có Size) · 89 (§7.13) · 98 (#12).

### 5.18 Exploratory — 1 phiên tuỳ chọn (không tính exit)

- **Charter (đề xuất, cần QC duyệt):** "Khám phá 7 loại component không có oracle knob (lớp B/C) trên iOS 18.x/26.x để **ghi nhận quan sát** knob nào xuất hiện trong bảng thuộc tính, phục vụ Q-22." **Kết quả chỉ là dữ liệu gửi dev — không sinh pass/fail, không tính coverage, không đổi expected result của TC18-118/119.** Timebox: 1 phiên.

---

## 6. Risk-based prioritization

### 6.1 Cơ sở

**Risk level = Risk likelihood × Risk impact** (ISTQB §5.2.1) — đã tính sẵn ở test-analysis mục 2, dùng nguyên: Cao → **P1** (chặn phát hành) · Vừa → **P2** · Thấp → **P3**. **Không có P0.** Product risk: mất/hỏng dữ liệu wallpaper, sai thứ tự/đè band, bố cục không sống sót automation; likelihood tăng ở vùng **mới/vừa sửa** (§0: kéo, snap, reorder, slider) và vùng **có cử chỉ phức tạp**.

### 6.2 P1 — 41 condition (lý do impact cao, không chỉ dán nhãn)

| Cụm | Condition | Vì sao impact cao |
|---|---|---|
| Baseline & gating | 01 (build), 02 (nút Components), 07 (iOS 26 glass) | Sai build ⇒ mọi kết quả vô nghĩa; không mở được S03 ⇒ toàn bộ nhóm sau không chạy; iOS 26 chrome vẽ khác |
| Chọn / Xoá | 09, 11, 14 | Chọn nhầm đối tượng ⇒ mọi thao tác sau (kéo/xoá/resize) tác động sai; Delete + Undo sai ⇒ mất thành phần không phục hồi |
| **Đổi thứ tự** *(mới, tương tác gap âm)* | 15, 17, **19 ⚠️, 20 ⚠️** | Tính năng mới hoàn toàn; đúng vùng vừa sửa lỗi **đè band**; Fixed dễ sai vì bị loại khỏi "kế bên" |
| **Kéo** *(test basis: "sửa đi sửa lại nhiều nhất")* | 21, 22, **23 ⚠️, 24 ⚠️**, 32, 33, 34, 36a, 37 | Bản sao/mất thành phần/nhảy vị trí/mất sticker = mất dữ liệu trực tiếp; giới hạn kéo **đảo ngược** so với 1.2.17 |
| **Snap / gap** *(mới)* | **25 ⚠️**, 26, **27 ⚠️** | Sai dấu chip (`-0`) hoặc sai mốc gap 0 ⇒ user đặt band sai chỗ mà không biết; mới hoàn toàn |
| Resize | 44, 45, 47, 50 | Sai hướng/bù trừ phá bố cục đã dựng; 47 là **đảo ngược** hành vi cũ |
| Thêm/lồng | 64 | Lỗi **vừa fix** (ô số 2 biến mất / thành phần chiếm hết hàng) — khả năng tái phát cao |
| Bảng thuộc tính | 74, **80 ⚠️**, **82 ⚠️**, 83, 84 | Auto↔Fixed nhảy vị trí; slider khựng (lỗi cũ) + xung đột cử chỉ; grabber vs ✕ là 2 trạng thái cuối khác nhau |
| Undo / lưu | 101, 103, 104 | Undo không đáng tin / Cancel không huỷ hết ⇒ mất niềm tin vào editor |
| **Regression ngoài màn** | 109, 110, 111, 112, **115 ⚠️**, **116 ⚠️** | Impact **cao nhất**: sai ở đây ⇒ lock screen thật/Live Activity/widget hỏng ngoài app; bố cục không sống sót overnight ⇒ tính năng chỉ dùng được đúng 1 ngày |

P1 tổng: **41** = ENT 2 · DEV 1 · SEL 3 · ROD 4 · DRG 9 · SNP 3 · RSZ 4 · NST 1 · PRP 1 · PUX 4 · UND 3 · REG 6. Trong đó **10 P1 mang ⚠️** (19, 20, 23, 24, 25, 27, 80, 82, 115, 116).

**P2 — 58** (mất một phần chức năng/UX rõ nhưng có workaround): hầu hết hành vi phụ SEL/DRG/RSZ/ADD/NST/KNB, TC18-29 (haptic), 36b, 39, 40, 42, Redo, sheet Add đúng 16 mục, **8 P2 mang ⚠️** (51, 61, 68, 70, 106, 117, 118, 119). **P3 — 19** (cosmetic/xác nhận cố ý): vị trí nút, coach mark, 6 INT, knob nhỏ (95–97), Row/Column ô trống (62, 63, 66, 67, 69), 89, 114, 107.

### 6.3 **18 nhãn ⚠️ (gap-dependent) — BẮT BUỘC mang sang, kèm điều kiện thay đổi**

> Nguồn: test-analysis §5.1. **Nhãn ⚠️ không được bỏ khi thiết kế test-case; giả định không được ghi như fact.**

| # | Condition (nhóm) | P | Nguồn giả định / gap | Loại | **Điều kiện thay đổi** |
|---|---|---|---|---|---|
| 1 | **TC18-19** (ROD) | P1 | **Q-10** — giữ **gap từng vị trí** khi đổi chỗ | **ASSUMPTION** (chờ dev) | Dev nói "giữ đỉnh ô/slot" ⇒ viết lại expected result, có thể thêm condition band cao → slot thấp |
| 2 | **TC18-20** (ROD) | P1 | **Q-10** (cách tính gap khi Duplicate) | **ASSUMPTION** | như trên |
| 3 | **TC18-23** (DRG) | P1 | **Q-8** — còn giả định "cạnh screen ≡ mép ảnh" | Giả định còn lại | Dev xác nhận hai biên khác nhau ⇒ viết lại điều kiện bật cảnh báo + thêm condition vùng giữa |
| 4 | **TC18-24** (DRG) | P1 | **Q-8** (như trên) | Giả định còn lại | như trên |
| 5 | **TC18-25** (SNP) | P1 | **Q-12** — mốc gap = 0 = **vạch trên grid** | **ASSUMPTION** | Dev nêu mốc khác (mép trên vùng nội dung / mép trên ảnh) ⇒ điểm snap gap 0 đổi chỗ |
| 6 | **TC18-27** (SNP) | P1 | **Q-12** | **ASSUMPTION** | như trên |
| 7 | **TC18-80** (PUX) | P1 | **Q-7** — khoá hướng cử chỉ một lần từ đầu; mâu thuẫn §7.07 ↔ §7.08 còn nguyên | **ASSUMPTION** | Dev nêu quy tắc gesture khác ⇒ viết lại |
| 8 | **TC18-82** (PUX) | P1 | **Q-7** | **ASSUMPTION** | như trên |
| 9 | **TC18-51** (RSZ) | P2 | **Q-13** — Row 3+ con bù trừ thế nào (còn mở) | Gap mở | Chỉ kiểm phần bất biến tới khi dev trả lời |
| 10 | **TC18-68** (NST) | P2 | **Q-3b** — "tối đa 3 cấp" đếm từ đâu (còn mở) | Gap mở | Chỉ kiểm bằng cấu trúc lồng thật, không suy diễn mốc đếm |
| 11 | **TC18-70** (NST) | P2 | **Q-3b** | Gap mở | như trên |
| 12 | **TC18-106** (CHR) | P2 | **Q-8** ("screen" vs "ảnh") | Giả định còn lại | Như #3 |
| 13 | **TC18-117** (REG) | P2 | **Q-18** — sticker dưới card frosted: "đúng" là gì | Gap mở | **Chỉ ghi nhận quan sát kèm ảnh, không kết luận pass/fail** |
| 14 | **TC18-61** (ADD) | P2 | **Q-11a** — requirement **ngoài spec 1.2.18** (nguồn: trao đổi miệng 2026-09-24; QC xác nhận còn đúng) | Ngoài spec | Dev đưa vào tài liệu chính thức ⇒ gỡ ⚠️; dev phủ nhận ⇒ bỏ condition |
| 15 | **TC18-115** (REG) | P1 | **Q-11b** (như trên) | Ngoài spec | như trên |
| 16 | **TC18-116** (REG) | P1 | **Q-11c** (như trên; phải chờ qua đêm thật) | Ngoài spec | như trên |
| 17 | **TC18-118** (KNB) | P2 | **TB-22** — 5 loại không có oracle knob | Thiếu oracle | Dev bàn giao danh mục chính thức |
| 18 | **TC18-119** (KNB) | P2 | **TB-22** — Quote, Almanac day | Thiếu oracle | như trên |

**Test object mang nhãn gap-dependent:** ROD (19, 20) · DRG (23, 24) · SNP (25, 27) · PUX (80, 82) · RSZ (51) · NST (68, 70) · ADD (61) · CHR (106) · REG (115, 116, 117) · KNB (118, 119).

**Quy tắc xử lý khi thực thi ⚠️ (cho test-case):** kết quả lệch so với expected **giả định** ⇒ **không tự mở defect ngay** — ghi **"Query → dev"** kèm video/ảnh (theo §13), trừ khi vi phạm một **bất biến có căn cứ trong spec** (đè band §3.08/§4.02, mất dữ liệu, mất thành phần). Kết quả **pass theo giả định ≠ đã xác nhận** — báo cáo phải nêu rõ.

### 6.4 Nhãn **(QC)** — expected result từ câu trả lời của QC, **chưa dev xác nhận**

**17 condition:** TC18-16, 17 *(Q-9)* · 23, 24, 106 *(Q-8)* · 29 *(Q-6)* · 36a, 36b *(Q-1)* · 54, 55 *(Q-21)* · 61, 115, 116 *(Q-11)* · 79, 83, 84 *(Q-17)* · 89 *(Q-2)*. Test-case phải giữ nhãn **(QC)** ngay trong expected result; dev trả lời khác ⇒ **dev thắng**, sửa đúng condition đó.

### 6.5 Product risk vs project risk (ISTQB §5.2)

| Loại | Rủi ro | Xử lý trong plan |
|---|---|---|
| **Project** | **Giả định Q-7/Q-10/Q-12 sai** ⇒ viết lại 6 P1 (19, 20, 25, 27, 80, 82) | Giữ nhãn ⚠️; chỉ những dòng đó phải sửa; không ảnh hưởng 100+ condition còn lại |
| Project | Baseline screenshot lỗi thời / chưa có trên build 111 (TB-17, Q-19) | Entry criterion (mục 8) |
| Project | Test basis có thể **thiếu 1 mục** (82/83 — Q-5) | Coverage gap mục 11; QC đối chiếu trang gốc |
| Project | Không có iPad / máy không home indicator (Q-20, TB-20) | Quy tắc "Not run" ở mục 9; ghi vào mục 10/11 |
| Project | 7 loại không có oracle knob (TB-22) | TC18-118/119 giới hạn vòng đời chung |
| Product | Haptic, cử chỉ, giật hình chỉ kiểm được trên **máy thật**, đánh giá định tính | Máy thật bắt buộc; không ngưỡng, ghi model máy |

---

## 7. Test environment matrix

| Hạng mục | Yêu cầu |
|---|---|
| **Build** | TestFlight **1.2.18 (111)**, tag `v1.2.18-rc3`. **rc1/rc2 không lên TestFlight** — nếu TestFlight hiện 1.2.18 với số build khác ⇒ **dừng và báo lại** (TC18-01) |
| **Thiết bị bắt buộc** | iPhone **iOS 18.x** (nền chính) + iPhone **iOS 26.x** (chrome glass) — **cả hai, máy thật**. Ghi **model máy** (TC18-39 yêu cầu báo model nếu giật). Ít nhất **1 máy có** và **1 máy không có** home indicator cho TC18-86 — *nếu thiếu: ghi giới hạn coverage, không suy diễn* |
| **iPad** (dọc + ngang) | **Nếu có** (**Q-20 chưa trả lời**). Không có ⇒ TC18-108 = *Not run* |
| **Không dùng** | iPhone iOS 27; simulator cho DRG/SNP/PUX/haptic |
| **Ngôn ngữ máy** | **Tiếng Việt** và **English** (bắt buộc); 12 ngôn ngữ đã khai báo, chỉ VI/EN kiểm |
| **Điều kiện haptic** | Máy thật có Taptic Engine, haptic hệ thống **bật** *(tester xác nhận trước khi kết luận TC18-29)* |

**Dữ liệu/test-data chuẩn bị trước:**

| # | Dữ liệu | Dùng cho |
|---|---|---|
| 1 | ≥1 template lịch **dạng stack** | Mọi nhóm (bắt buộc) |
| 2 | ≥1 template **không phải stack** | TC18-02 |
| 3 | Bố cục **`Column > Row > Column`** (tự dựng nếu không có mẫu; test basis yêu cầu test kỹ) | DRG, NST (68, 70), RSZ |
| 4 | Row **2 con** và Row **3+ con** | RSZ (50, 51) |
| 5 | Container **có thẻ nền (card)** chứa Row/Column con | TC18-36a, 36b, 43 |
| 6 | Template có **band Fixed** + ≥2 band Auto; Fixed **giữa** 2 Auto; Fixed **sau** band Auto cuối | ROD (16, 17) |
| 7 | Band đầu **gap âm** (kéo lên qua vạch trên grid); 2 band **cao–thấp khác nhau** | ROD (19, 20), SNP |
| 8 | 4 template `mix-class-schedule`, `mix-daily-brief`, `mix-focus-today`, `mix-mindful-month` | TC18-42 |
| 9 | Template có sẵn **Quote · Almanac day · Timeline** | TC18-56, 97, 119 |
| 10 | Template có **bold + italic sẵn** (month *elegant script*, priority matrix) | TC18-89 |
| 11 | Wallpaper có **sticker / nét vẽ trang trí** (Decorate) | TC18-37, 115 |
| 12 | Card **frosted** có sticker nằm dưới | TC18-117 |
| 13 | Dữ liệu event/task thật (component dạng lịch/danh sách) | KNB, REG |
| 14 | Template lịch **cũ** chưa động vào; wallpaper **Note** | TC18-113, 114 |
| 15 | Apple **Shortcut automation** (Flow 03) đã cài, **chạy qua đêm thật** — không simulator, **không đổi giờ hệ thống** | TC18-116 (khởi động sớm nhất) |
| 16 | Live Activity + widget đã bật; lock screen đặt được | TC18-109 – 111 |
| 17 | **Baseline screenshot trên build 111** (Q-19): sheet Add 16 mục, pill ↑/↓, chip gap âm, đường gióng snap, grabber + ✕ | Oracle trực quan; entry criterion |

---

## 8. Entry criteria

> Theo §5.1.3. Cột "Hiện trạng" phản ánh thực tế tại 2026-09-28.

| # | Tiêu chí | Hiện trạng |
|---|---|---|
| E1 | **Build 1.2.18 (111, rc3)** cài được trên **mọi máy test**, **xác nhận số build khớp** (TC18-01). Sai số build ⇒ dừng, báo lại | ⬜ chưa xác nhận trên máy |
| E2 | **Baseline screenshot trên build 111** (Q-19) đã chụp — kèm số build; bộ ảnh 1.2.17 **không** được dùng làm oracle | ⬜ **chưa làm** *(ảnh sheet Add 2026-09-28 khớp spec nhưng chưa hiện số build)* |
| E3 | Test plan này = READY và **`test-cases-1.2.18.md` đã tạo + được duyệt** *(orchestrator quyết định gọi `test-case`)* | ⬜ chưa có test-case |
| E4 | Test data mục 7 (đặc biệt #3, #5, #6, #7, #15) sẵn sàng | ⬜ chưa xác nhận |
| E5 | Thiết bị: ≥1 iPhone iOS 18.x **và** ≥1 iPhone iOS 26.x, máy thật | ⬜ chưa xác nhận |
| E6 | Nhãn ⚠️ và nhãn (QC) đã được **giữ nguyên** trong test-case (kiểm chéo mục 12) | ⬜ chờ test-case |
| E7 | **Smoke test pass:** **TC18-02** (nút Components hiện trên template stack) + **TC18-09** (mở được S03, chọn được 1 thành phần). Fail ⇒ dừng, không chạy tiếp | ⬜ chưa chạy |
| E8 | `bugs/bug-log.md` rà soát xong *(đã rà: không có bug liên quan)* | ✅ |

## 8.1 Suspension & Resumption criteria

- **Dừng toàn bộ:** (a) mất dữ liệu **không phục hồi được** ở nhóm REG (lock screen thật/Live Activity/widget hỏng vĩnh viễn, dữ liệu wallpaper gốc bị ghi đè) ⇒ báo dev/PO trước khi tiếp tục; (b) phát hiện **build không phải 111**.
- **Dừng cục bộ nhóm DRG / SNP / ROD / RSZ / PUX** nếu **>50% case P1** trong nhóm fail liên tiếp — các nhóm ADD/NST/REG phụ thuộc chúng để dựng layout test.
- **Dừng cục bộ các condition ⚠️ liên quan** khi **dev trả lời khác giả định** (Q-7/Q-10/Q-12/Q-8…) ⇒ chỉ viết lại **đúng các dòng ⚠️ đó** (theo bảng 6.3), phần còn lại tiếp tục.
- **Resume:** chạy lại **từ đầu cụm đã suspend** sau khi có bản fix/xác nhận mới, không tiếp tục giữa chừng (state canvas và lịch sử Undo bị ảnh hưởng bởi case trước).

**Thứ tự thực thi gợi ý (§5.1.5 — không có lịch/nguồn lực vì skill và test basis không yêu cầu):** ① Smoke E7 → ② **khởi động TC18-116 (overnight) sớm nhất** → ③ ENT/DEV/SEL → ④ ROD, DRG, SNP, RSZ (P1 trước) → ⑤ ADD/NST/PRP/PUX/KNB/UND/CHR → ⑥ INT → ⑦ **REG** (sau cùng) → ⑧ lặp DEV trên iOS còn lại.

---

## 9. Exit criteria

**Đo lường:**
- Toàn bộ **41 test condition P1** đã chạy; **0 bug Critical/High còn mở** trong nhóm P1.
- **P2 ≥ 90%** đã chạy (≥ 53/58); **P3** chạy đủ hoặc ghi lý do.
- **REG: 9/9 đã chạy và 0 fail** (chưa chạy được **TC18-116** — cần qua đêm — thì **không exit**).
- **INT: 9/9 đã chạy**, không có sai lệch so với hành vi tài liệu hoá.
- **Coverage loại component:** **mỗi loại trong 10 loại lớp A** đã chạy ≥1 lần với kiểm knob (TC18-90 – 97) **và** **7 loại lớp B/C** đã chạy vòng đời chung ≥1 lần (TC18-118/119).
- Đã chạy trên **cả** iOS 18.x **và** iOS 26.x; VI **và** EN.

**Nhị phân:**
- **Regression đã chạy** (mục 4) — không rút gọn.
- **10 P1 ⚠️ + 8 P2 ⚠️ đã chạy** nhưng **kết quả phải ghi rõ "theo giả định / chưa dev xác nhận"**. Exit **không** được tuyên bố các condition này đã **xác nhận** trừ khi dev đã trả lời (khi đó đổi nhãn ASSUMPTION → FACT ở `answers-1.2.18.md` trước).
- **Câu hỏi mở còn lại** (mục 10) hoặc **có trả lời**, hoặc được **PO chấp nhận là known gap** bằng văn bản — không chặn release ngầm.
- **TC18-99/100 không tính vào exit** (ngoài phạm vi); Q-4 vẫn mở.
- **iPad (TC18-108):** có máy ⇒ phải chạy; **không có** ⇒ ghi *"Not run — không có thiết bị"* và được PO chấp nhận (Q-20) — không tính fail.
- Mọi "Query → dev" từ ⚠️ có phản hồi hoặc được ghi nhận known gap.

---

## 10. Gap cần làm rõ trước khi execute

> Mục 10 = câu hỏi mà **câu trả lời sẽ đổi expected result**. Cột "Ảnh hưởng scope/priority?" quyết định READY (theo bảng trạng thái): **không dòng nào đang mở mà ảnh hưởng scope/priority.**

### 10A. Gap đã được người duyệt chấp nhận có điều kiện (mang nhãn — **không được coi là đã trả lời**)

| # | Gap | Condition | Ảnh hưởng scope/priority? | Trạng thái |
|---|---|---|---|---|
| **Q-7** | §7.07 ↔ §7.08: kéo slider vs cuộn bảng (mâu thuẫn **còn nguyên**) | TC18-80, 82 ⚠️ | **Không** — chỉ expected result | **ASSUMPTION** (khoá hướng một lần) — **chờ dev** |
| **Q-10** | §3.08 "khoảng cách giữ nguyên": giữ **gap** hay giữ **đỉnh slot** | TC18-19, 20 ⚠️ | **Không** — chỉ expected result | **ASSUMPTION** — **chờ dev** |
| **Q-12** | §4.06 mốc gap = 0 của band đầu | TC18-25, 27 ⚠️ | **Không** — chỉ vị trí điểm snap | **ASSUMPTION** (vạch trên grid) — **chờ dev** |
| **Q-4** | §12 Year progress "target date"; Quote "chữ / số dòng" | TC18-99, 100 | **Có (scope)** — nhưng **đã xử lý bằng quyết định của người duyệt: descope** | **GAP mở** — chờ **QC gửi ảnh/mô tả → dev chốt**; **ngoài phạm vi** |

### 10B. Open Questions không chặn (vẫn cần trước khi viết expected result chính xác ở test-case)

| # | Câu hỏi | Condition | Ghi chú |
|---|---|---|---|
| Q-8 (phần còn lại) | "Cạnh screen" có ≡ "mép ảnh" (§4.03) không? | 23, 24, 106 ⚠️ | Đã trả lời một phần (cảnh báo chỉ khi ra khỏi cạnh screen) |
| Q-3b | "Tối đa 3 cấp" đếm từ đâu | 68, 70 ⚠️ | Kế thừa 1.2.17 |
| Q-13 | Row 3+ con bù trừ thế nào | 51 ⚠️ | Kế thừa 1.2.17 |
| Q-18 | Sticker dưới card frosted trên wallpaper đã lưu: "đúng" là được/không được làm mờ; có cách kiểm rẻ hơn lock screen thật không | 117 ⚠️ | |
| Q-11 | Đề nghị dev **đưa 3 hành vi (chèn giữa canvas · gộp Editor + Decorate · sống sót overnight) vào tài liệu bàn giao chính thức** | 61, 115, 116 ⚠️ | QC xác nhận còn đúng nhưng ngoài spec |
| **Q-22 (TB-22)** | Dev bàn giao **danh mục component chính thức** (tên UI ↔ tên code ↔ knob riêng) cho 16 mục Add + Quote/Almanac day/Timeline | 78, 90–97, 118, 119 ⚠️ | 7 loại không có oracle knob |
| Q-20 | Đợt này **có máy iPad** không? Không có ⇒ *Not run* hay *out of scope*? | 108 | Chưa trả lời; plan xử lý cả 2 nhánh (mục 9) |
| Q-5 | Bộ đếm gốc `0 / 83` vs bản chép **82** mục — có mục bị khuất? | toàn bộ | **QC tự xử lý, chưa làm**; xem mục 11 |
| Q-19 | Chụp lại baseline screenshot **trên build 111** | oracle chung | **Là entry criterion E2** |
| Q-6 (phần mở) | Bán kính hút snap; có rung khi rời điểm snap không | 26–29 | Đã bỏ / không có expected result |
| TB-19 | Trạng thái nút **+** sau grabber (TC18-83 nói "chưa hiện lại") | 83 | Chốt bằng baseline Q-19 |
| Đã **cố ý bỏ** | Q-3a, Q-14, Q-15, Q-16, đơn vị chip gap, ngưỡng gesture | 25, 39, 52, 58, 80, 87 | Không chờ trả lời — "kiểm hành vi, không kiểm giá trị" |

---

## 11. Coverage gap — case chưa được test basis liệt kê

> Suy luận của **QC** (tách khỏi sự thật do test basis xác nhận). **Không có expected result** — chỉ dùng để ghi nhận quan sát hoặc bổ sung khi có oracle.

| # | Thiếu gì | Vì sao là gap | Ảnh hưởng đáng kể? |
|---|---|---|---|
| 1 | **1 mục tick có thể bị khuất** (82/83, Q-5) | Bản Markdown có thể thiếu 1 requirement; không condition nào phủ được | **Có** — rủi ro completeness của test basis; QC đối chiếu `docs/qc-component-editor.md` |
| 2 | **Knob của 7 loại** không có oracle (TB-22) | Chỉ có §7.05 chung chung | **Có** — đã xử lý bằng TC18-118/119 (chỉ vòng đời) |
| 3 | **Snap + con trong Row/Column**; chip gap trong container | §4.06 chỉ nói "band", không nêu cho con | Trung bình |
| 4 | **Tổ hợp** reorder ↑/↓ ↔ gap âm ↔ snap ↔ Undo liên tiếp | Mỗi hành vi mô tả riêng, chưa có tổ hợp | Trung bình — ứng viên cho phiên exploratory |
| 5 | **iPad** (dọc + ngang) toàn bộ luồng | Spec chỉ nêu xoay iPad (§9.04); Q-20 chưa trả lời | Trung bình — phụ thuộc thiết bị |
| 6 | **Máy không có home indicator** cho TC18-86 | Cần thiết bị cụ thể; chưa xác nhận có sẵn | Thấp — ghi giới hạn coverage |
| 7 | **Dialog xác nhận khi ✕ Cancel** | Kế thừa 1.2.17: hiện **không có dialog**, đúng §8.04 — không phải bug; khác S02 (có "Discard changes?"). QA từng khuyến nghị; cần PO/design quyết | Thấp — câu hỏi sản phẩm, không thuộc phạm vi 1.2.18 |
| 8 | Oracle trực quan **lỗi thời** (wireframe/ảnh/exploratory S03 lứa 1.2.17) | Xem mục 1.2 | Trung bình — giải quyết bằng E2 |
| 9 | Hiệu năng **định lượng** khi kéo (fps) | Đã cố ý bỏ (Q-15) | Thấp — chấp nhận |

---

## 12. Bảng tự kiểm — 3 điều kiện bắt buộc của việc duyệt READY

| # | Điều kiện | Được đáp ứng ở | Kết quả |
|---|---|---|---|
| 1 | Q-7, Q-10, Q-12 **giữ ASSUMPTION, chưa nâng thành fact**; nêu ở rủi ro/giả định | Banner đầu file · mục 5.5, 5.7, 5.12 · mục 6.3 (#1–#8, loại "ASSUMPTION") · mục 6.5 · mục 10A | ✅ |
| 2 | **TC18-99, TC18-100 descope**, kèm điều kiện đưa lại phạm vi | Mục 3 (#1, #2) · mục 10A (Q-4) · mục 9 | ✅ Không có condition/expected nào cho hai dòng này |
| 3 | **Nguyên 18 nhãn ⚠️ kèm điều kiện thay đổi**; gắn nhãn gap-dependent cho test object; giữ nhãn (QC) | Mục 2.1 (cột Gap-dependent) · mục 6.3 (18 dòng: TC18-19, 20, 23, 24, 25, 27, 51, 61, 68, 70, 80, 82, 106, 115, 116, 117, 118, 119) · mục 6.4 (17 nhãn (QC)) | ✅ 18/18 |

**Tự kiểm số liệu:** tổng **118** condition = ENT 5 + DEV 3 + LOC 1 + SEL 6 + ROD 6 + DRG 15 + SNP 5 + RSZ 9 + ADD 8 + NST 11 + PRP 5 + PUX 7 + KNB 12 + UND 4 + CHR 3 + REG 9 + INT 9 = **118** ✓ · P1 41 · P2 58 · P3 19 ✓ · 2 GAP ngoài phạm vi ✓.

---

## Phụ lục A — Traceability: Requirement §N.M → Test condition → Nhóm test case dự kiến

> Chuỗi: Requirement (§N.M) → Test condition (TC18-xx, test-analysis mục 2) → Nhóm test case (mã nhóm → `TC-<MÃ>-NN` do skill test-case cấp). Mã `§N.M` do QC gán trong spec 1.2.18.

| Requirement | Test condition | Nhóm | | Requirement | Test condition | Nhóm |
|---|---|---|---|---|---|---|
| header (build/rc3) | 01 | ENT | | §5.01 / §5.02 | 44 / 45 | RSZ |
| §1 (thiết bị, ngôn ngữ) | 06, 07, 08, 108 | DEV, LOC | | §5.03 – §5.05 | 46, 47, 48 | RSZ |
| §2, §10 #5 | 02, 03, 04, 05 | ENT | | §5.06 / §5.07 | 49 / 50, 51 ⚠️ | RSZ |
| §3.01 / §3.02 | 09 / 10 (+79, 84) | SEL | | §5.08, §10 #3 | 52 / 53 | RSZ / INT |
| §3.03, §10 #4 | 11 | SEL | | §6 (5 nhóm/16 mục), §7.22 | 54, 55, 56, 118 ⚠️, 119 ⚠️ | ADD, KNB |
| §3.04 / §3.05 / §3.06 | 12 / 13 / 14 | SEL | | §6.01 – §6.04 | 57, 58, 59, 60 | ADD |
| §3.07, §10 #13 | 15, 16, 17, 18 | ROD | | (Q-11a — ngoài spec) | **61 ⚠️** | ADD |
| §3.08 | **19 ⚠️** | ROD | | §6.1.01 – §6.1.06 | 62 – 67 | NST |
| §3.09 | **20 ⚠️** | ROD | | §6.2.01 / .02 / .03 | **68 ⚠️** / 69 / **70 ⚠️** | NST |
| §4.01 / §4.02 | 21 / 22 | DRG | | §6.3.01 / §6.3.02 | 71 / 72 | NST |
| §4.03 / §4.04 | **23 ⚠️** / **24 ⚠️** (+§10 #10 → 42) | DRG, INT | | §7.01 / .02 / .03 / .04 | 74 / 75 / 76 / 77 | PRP, INT |
| §4.05 | **25 ⚠️** | SNP | | §7.05 | 78, 118 ⚠️, 119 ⚠️ | PRP, KNB |
| §4.06 | 26, **27 ⚠️**, 28, 29 | SNP | | §7.06 | 79 | PRP |
| §4.07 | 30 | DRG | | §7.07 / §7.08 | **80 ⚠️**, 81 / **82 ⚠️** | PUX |
| §4.08 – §4.11 | 31 – 34 | DRG | | §7.09 | 83, 84 | PUX |
| §4.12, §10 #8 | 35, 36a, 36b | DRG | | §7.10 / §7.11 | 85 / 86 | PUX |
| §4.13 / §4.14 / §4.15 | 37 / 38 / 39 | DRG | | §7.12 / §7.13 | 87 / 88, 89 | KNB, INT |
| §10 #7 / #9 / #10 / #11 | 40 / 41 / 42 / 43 | INT | | §7.14 – §7.21 | 90 – 97 | KNB |
| §10 #1 / #2 / #12 | 73 / 77 / 98 | INT | | §8.01 – §8.04 | 101 – 104 | UND |
| §10 #6 | **117 ⚠️** | REG | | §9.01 / §9.02 / §9.03 / §9.04 | 105 / **106 ⚠️** / 107 / 108 | CHR, DEV |
| §11.01 – §11.06 | 109 – 114 | REG | | (Q-11b / Q-11c — ngoài spec) | **115 ⚠️**, **116 ⚠️** | REG |
| **§12 (Q-4)** | ~~TC18-99, TC18-100~~ | **GAP — ngoài phạm vi** | | Test-analysis TB/Q | xem cột "Nguồn giả định" mục 6.3 | — |

**Ngược lại:** mỗi condition trong test-analysis mục 2 được ánh xạ **đúng 1 nhóm** ở mục 2.1; test-case tương lai phải trace `TC-<MÃ>-NN` → `TC18-xx` → `§N.M` (hoặc "ngoài spec — TB-18 / TB-22" cho 61, 115, 116, 118, 119).

---

**Bước tiếp theo:** báo cáo cho orchestrator. **Chỉ khi** orchestrator (và QC) xác nhận Test Plan Status = `READY` có điều kiện → gọi skill `test-case` trên file này, với ràng buộc giữ nguyên nhãn ⚠️/(QC), không thiết kế case cho TC18-99/100, không suy diễn knob 7 loại.
