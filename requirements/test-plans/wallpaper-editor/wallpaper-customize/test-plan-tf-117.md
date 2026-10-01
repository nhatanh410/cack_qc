# Test Plan — Wallpaper Customize (gộp Layout | Decorate) · ticket **TF-117**

> ✅ **Test Plan Status: `READY` — CÓ ĐIỀU KIỆN** *(kế thừa từ Analysis Status `READY` có điều kiện, chuyển
> `BLOCKED → READY` do **người review (QC)** quyết định ngày 2026-09-29 — đợt trả lời thứ 2, ghi trong
> [answers-tf-117.md](answers-tf-117.md). Agent `qc-test-plan` chỉ đánh giá theo bảng trạng thái của
> [`.claude/rules/testing.md`](../../../../.claude/rules/testing.md); **quyết định gọi `test-case` thuộc
> orchestrator**, không phải agent này.)*
>
> **Vì sao không hạ xuống `DRAFT`:** mục 10 không còn gap nào **đang mở** làm đổi **scope hoặc priority**
> của các test condition **đã có trong phạm vi**. Q-7b (đường vào Cutout) chỉ loại **một** condition
> (`TC117-165`) khỏi việc viết/chạy case ở đợt này — tương tự đúng tiền lệ TC18-99/TC18-100 của bộ 1.2.18 —
> chứ không làm thay đổi phạm vi của 170 condition còn lại.
>
> **READY này KHÔNG có nghĩa là spec đã hết mơ hồ.** Sáu điều kiện bắt buộc kèm theo (mang nguyên từ banner
> test-analysis, **không được bỏ bớt** — bảng tự kiểm ở mục 12):
> 1. **Q-1 … Q-6 và Q-8 vẫn là ASSUMPTION** do **QC chấp nhận, dev CHƯA xác nhận** (A-7 … A-12, A-15). Nhiều
>    expected result **ngược với câu chữ test basis** (§4.02, §6, §7.03) — test-case **không được** tự "sửa"
>    lại theo spec khi thấy khác nhau.
> 2. **Mang nguyên 65 nhãn ⚠️ (gap-dependent)** kèm điều kiện thay đổi của từng nhãn (mục 6.3/6.4) —
>    **không** được gộp/lược bớt.
> 3. **Nhóm R (7 condition, TO-SNAP) và nhóm S (21 condition, TO-DECORATE) KHÔNG có requirement trong chính
>    test basis TF-117** — oracle của chúng lấy từ spec **Component Editor 1.2.18** / spec **Decorate
>    1.2.15** (tài liệu **đối chiếu**, không phải test basis) **+ quyết định phạm vi của QC**. Traceability
>    của hai nhóm này phải ghi rõ là **"về quyết định của QC"**, không phải "về spec TF-117" (mục 2, Phụ lục A).
> 4. **`TC117-G4` (Q-9 descope hẹp):** chỉ nhánh **"phiên chỉ đổi ảnh nền / chỉ kéo Darken rồi bấm ✕"** ra
>    khỏi phạm vi thực thi đợt này (giữ nhãn `GAP`, không viết/chạy case, không suy diễn expected result).
>    **Phần còn lại** của `TC117-100 / 120 / 121 / 170` và **toàn bộ §8.04** (✕/Discard khi phiên **có** đổi
>    Layout/Decorate) **vẫn trong phạm vi** — **không** được descope nhầm rộng ra cả nhóm L/N (mục 2, mục 3).
> 5. **`TC117-G6` ngoài phạm vi** (hệ quả Q-8 = A: band lịch không tương tác được ở chế độ Decorate) —
>    **nếu khi thực thi phát hiện band vẫn tương tác được ở Decorate thì đó là bug cần report**, không phải
>    lỗi test case (mục 3, mục 6.4).
> 6. **`TC117-165` (Cutout) CHƯA được viết/chạy** — phụ thuộc **Q-7b** (đường vào Cutout chưa rõ, rail
>    Decorate mới không có nút Cutout riêng). Ghi rõ "chờ trả lời Q-7b", **không** tự đoán đường vào (mục 3,
>    mục 10).
>
> **Ngoài 6 điều kiện trên — 2 ràng buộc bổ sung của đợt lập test-plan này:**
> - **`TC117-01` (định danh build/branch/PR của TF-117) là một phần Entry criteria** (mục 8, E1) — hiện
>   **tài liệu spec không có mã build nào** (TB-08); toàn bộ đợt test **chưa có build cụ thể** để chạy.
> - **Không dùng ảnh chụp màn hình lứa 1.2.17/1.2.18 (Component Editor cũ) hay 1.2.15 (Decorate cũ) làm
>   oracle hình ảnh cho màn Customize.** Toàn bộ UI mới (chip Customize, công tắc Layout|Decorate, rail mới,
>   coach tour 2 bước, Layers gộp 2 nhóm + Background, Style → Text size) **chưa có bất kỳ
>   screenshot/wireframe baseline nào** trong repo (TB-27) — đây là **risk/limitation** của đợt test này,
>   không phải gap có thể tự giải quyết (mục 6.5, mục 11, entry criteria E2).
>
> **Chỉ được thiết kế test-case** với đúng 8 ràng buộc trên; **thực thi** còn bị chặn thêm bởi Entry criteria
> (mục 8) — hiện **chưa đủ điều kiện chạy thật** (chưa có build, chưa có baseline screenshot, chưa có thiết
> bị xác nhận).

> **Test basis (duy nhất):** [component-editor-specs-dev-change(TF-117).md](<../../../specs/wallpaper-editor/wallpaper-customize/component-editor-specs-dev-change(TF-117).md>) — toàn bộ §1–§12. **Không có mã build/branch/PR** (TB-08) — xem entry criteria E1.
> **Test analysis (input chính):** [test-analysis-tf-117.md](test-analysis-tf-117.md) — **171 test condition đã ưu tiên hoá** (P1 106 · P2 55 · P3 10) + 1 cụm `GAP` còn mở (`TC117-G4`, đã descope hẹp) + 1 cụm `GAP` đã đóng (`TC117-G6`, ngoài phạm vi); dùng trực tiếp mục 2 làm test object và cột Risk level làm cơ sở risk-based prioritization, **không phân tích lại**. Câu trả lời/giả định: [answers-tf-117.md](answers-tf-117.md).
> **Chuẩn:** ISTQB Foundation Level v4.0.1 [§5.2](../../../istqb-foundation/ISTQB_CTFL_Syllabus_v4.0.1.md) (Risk Management) + §4.1/§4.2 (Test Techniques) + §5.1.3 (Entry/Exit Criteria) + §5.1.5 (Prioritization).
> **Test case cụ thể:** [test-cases-tf-117.md](test-cases-tf-117.md) — *chưa tồn tại*; sẽ sinh bởi skill `test-case` **nếu và chỉ nếu** orchestrator xác nhận Test Plan Status = READY.
> **Đối chiếu tài liệu đã có (KHÔNG phải test basis):**
> - [QC — Component Editor 1.2.18.md](../../../specs/wallpaper-editor/component-editor/QC%20—%20Component%20Editor%201.2.18.md) · [test-plan-1.2.18.md](../component-editor/test-plan-1.2.18.md) · [test-analysis-1.2.18.md](../component-editor/test-analysis-1.2.18.md) · [answers-1.2.18.md](../component-editor/answers-1.2.18.md) — bộ test **cũ** của riêng Component Editor, oracle nguồn cho nhóm **TO-SNAP**.
> - [qc-wallpaper-decoration.md](../../../specs/wallpaper-editor/wallpaper-decoration/qc-wallpaper-decoration.md) · [1.2.15-decoration-inkai.md](../wallpaper-decoration/1.2.15-decoration-inkai.md) — bộ test **cũ** của riêng Decorate, oracle nguồn cho nhóm **TO-DECORATE**.
> - [component-editor/README.md](../component-editor/README.md) · [wallpaper-decoration/README.md](../wallpaper-decoration/README.md) — banner giải thích 2 folder đó là phiên bản **trước** TF-117.
> - Bằng chứng ảnh: [screenshots iPhone](../../../ui/ux/screenshots/iphone/index.md), [wireframe 14_edit-wallpaper](../../../ui/ux/wideframes/14_edit-wallpaper.md), [exploratory 14_edit-wallpaper](../../../exploratory/14_edit-wallpaper.md) — **toàn bộ là lứa 1.2.17/1.2.18/1.2.15, KHÔNG dùng làm oracle cho Customize** (xem banner + mục 11).
> - `bugs/bug-log.md` — chưa có bug nào gắn nhãn `Screen: customize` (feature mới); severity mapping ở mục 6.2.
> **Ngày lập:** 2026-09-29 · **Người lập:** QC (agent `qc-test-plan`)

---

## 1. Phát hiện khi đối chiếu với tài liệu đã có

### 1.1 TF-117 không phải bản vá của một file cũ — mà là **gộp 2 flow**

Khác các đợt trước (nơi có một bảng "V-cũ → V-mới" một-đối-một), TF-117 **gộp** hai editor độc lập
(`Component Editor` nút `Components` + chip `Decorate`) thành **một** màn `Customize` với công tắc
**Layout | Decorate**. Vì vậy đối chiếu tài liệu cũ tách làm hai nhánh:

| Nhánh kế thừa | Test cũ | Trạng thái sau đối chiếu |
|---|---|---|
| **Layout** (band lịch, kéo/resize/reorder/Add/Row-Column) | `test-plan-1.2.18.md` (118 condition) | Phần lớn hành vi **lặp lại nguyên văn** (♻️, xem test-analysis mục A–P) — TF-117 **im lặng** về cụm snap/chip gap (§4.05–§4.07, §3.09 của 1.2.18) → mở lại thành **nhóm R** (⚠️, oracle ngoài test basis, xem điều kiện 3 ở banner) |
| **Decorate** (bút vẽ, sticker, emoji, ảnh, cutout) | `1.2.15-decoration-inkai.md` | TF-117 **chỉ liệt kê nút trên rail** (§2), không có acceptance criteria cho nội dung bên trong → QC quyết định (**Q-7 = B**) test lại **toàn bộ** trong ngữ cảnh mới → **nhóm S** (⚠️⚠️, mức yếu nhất của tài liệu, xem điều kiện 3 ở banner). **3 điểm của 1.2.15 đã bị TF-117 ghi đè tường minh** và **không** dùng lại nguyên văn ô tick cũ: rail **không còn** toggle *Lock screen* (§9.11) · dialog Discard của Decorate nay là dialog **chung cả phiên** (§8.04, không còn dialog riêng 1.2.15 §2.5) · lịch sử Undo nay **chung 2 chế độ** (§8.1.02, không còn tách riêng theo chế độ như 1.2.15) |

**Không có bảng "V-cũ → V-mới" kiểu một-đối-một** vì TF-117 không thay thế một bản test-plan cũ nào ở đúng
scope của nó (Component Editor và Decorate vẫn còn giá trị lịch sử cho hành vi **bên trong** từng chế độ,
chỉ chrome bên ngoài — header, Undo, Layers, Discard — đã đổi kiến trúc).

### 1.2 Mâu thuẫn/khoảng trống nội bộ của TF-117 — **vẫn còn nguyên trong tài liệu**, chỉ đã có quyết định chọn bên

Theo đúng cảnh báo ở banner test-analysis: các câu mâu thuẫn dưới đây **không biến mất** khỏi test basis, chỉ
có **quyết định của QC chọn một bên** để viết được oracle. Test-case **không được** đọc lại test basis rồi tự
"sửa" oracle theo câu chữ gốc.

| Vị trí mâu thuẫn | Câu chữ TF-117 vẫn giữ nguyên | Oracle đã chọn (⚠️ QC, dev chưa xác nhận) |
|---|---|---|
| §4.02 "không được ra khỏi **vùng nội dung**" | Ngược với 1.2.18 (chặn ở **mép ảnh**) | **A-7**: chặn ở mép ảnh, band đầu vẫn qua được vạch trên grid |
| §6 liệt kê nhóm **Text** trong sheet Add | Ngược với §7.29 ("không còn Quote/Almanac/Timeline") và với 1.2.18 (đã bỏ Text) | **A-10**: **không có** nhóm Text — thấy nhóm Text = bug |
| §7.03 "Fixed → hiện **Vertical position**" | Ngược với §7.35 ("Vertical position chỉ ở Quote") | **A-11**: Fixed **không có** Vertical position; chỉ Quote (More options) có |
| §8.04 ↔ §8.2.13 ↔ Q-6 = C | Lỗ oracle mới: nền/Darken không vào lịch sử Undo thì có tính "có thay đổi" để hỏi Discard không? | **A-16**: **descope hẹp** nhánh này (`TC117-G4`), phần còn lại của §8.04 giữ nguyên oracle |
| §8.1.04/§8.1.05/§8.2.09 | Không câu nào khẳng định band có tương tác được ở Decorate hay không | **A-15**: band **trơ** ở Decorate (Q-8 = A) |

### 1.3 Đối chiếu bằng chứng ảnh — kết luận: **không có baseline nào dùng được**

`requirements/ui/ux/screenshots/iphone/`, wireframe và exploratory `14_edit-wallpaper` hiện có **đều là lứa
Component Editor 1.2.17/1.2.18 và Decorate 1.2.15**. Chưa có ảnh nào của: chip Customize, công tắc
Layout|Decorate, rail mới, coach tour 2 bước, Layers gộp 2 nhóm + Background, Style → Text size. Theo
[`screenshot-naming.md`](../../../../.claude/rules/screenshot-naming.md) sẽ cần `screen-name` mới trong flow
`14_edit-wallpaper` khi chụp lại trên build thật của TF-117 — xem entry criteria E2 và coverage gap mục 11.

---

## 2. Test object — In scope

> **19 test object**, ánh xạ **1-1 không chồng lấn** từ 171 test condition của test-analysis mục 2. Mã nhóm
> là tiền tố ID mà skill `test-case` sẽ dùng (`TC-<MÃ>-NN`). Cột **Gap-dependent** đánh dấu nhóm có ≥1
> condition mang nhãn ⚠️ — chi tiết đầy đủ từng condition ở mục 6.3/6.4 (không lặp lại ở đây để tránh sai
> lệch với nguồn test-analysis).

| # | Test object | Mã nhóm | TC117-... | Nguồn test basis | P1 | P2 | P3 | Gap-dependent |
|---|---|---|---|---|---|---|---|---|
| 1 | Môi trường, định danh build, đường vào, rail tồn kho | **ENV** | 01–08 | §1, §2 (văn xuôi) | 6 | 2 | 0 | ⚠️ TC117-01 (TB-08, entry) · 07 (TB-09) |
| 2 | Coach tour 2 bước | **COACH** | 09–12 | §2.01–§2.04 | 1 | 2 | 1 | ⚠️ TB-20 (reset), TB-21 (bất đối xứng) |
| 3 | Chọn thành phần | **SEL** | 13–19 | §3.01–§3.07, §10 #4 | 3 | 4 | 0 | — |
| 4 | Di chuyển — kéo tự do | **DRG** | 20–32, 39 | §4.01–§4.03, §4.08–§4.14 | 11 | 3 | 0 | ⚠️ **(QC) A-7**: 30, 31, 32 · TB-17: 39 |
| 5 | Nhấn giữ để đổi chỗ (reorder) *(🆕 lõi)* | **ROD** | 33–38 | §4.04–§4.07 | 6 | 0 | 0 | ⚠️ TB-11: 34 · **(QC) A-9**: 36, 38 · TB-24: 37 |
| 6 | Đổi bề rộng — kéo góc | **RSZ** | 40–47 | §5.01–§5.08 | 3 | 5 | 0 | ⚠️ TB-13: 46 · TB-12: 47 |
| 7 | Thêm thành phần + chặn khi tràn | **ADD** | 48–53 | §6, §6.01–§6.05 | 4 | 2 | 0 | ⚠️ **(QC) A-10**: 48 · **(QC) A-7**: 52 |
| 8 | Row/Column, lồng nhau, container rỗng | **CTN** | 54–61 | §6.1–§6.3, §10 #1 | 3 | 4 | 1 | ⚠️ **(QC) A-10** + TB-14: 59 |
| 9 | Bảng thuộc tính — khung chung & tương tác sheet | **INS** | 62–73 | §7.01–§7.12, §7.21–§7.22 | 4 | 6 | 2 | ⚠️ **(QC) A-11**: 64 · TB-10: 73 |
| 10 | Bảng thuộc tính — chữ, màu, font, cỡ, card | **TXT** | 74–85 | §7.07, §7.13–§7.20, §7.37, §7.40 | 5 | 7 | 0 | ⚠️ TB-16: 74, 75 · TB-18: 85 |
| 11 | Bảng thuộc tính — knob riêng theo loại band | **KNB** | 86–96 | §7.06, §7.23–§7.36, §7.38 | 3 | 8 | 0 | ⚠️ TB-22 (không có danh mục chính thức): 86 · TB-19: 89, 96 · **(QC) A-11**: 96 |
| 12 | Undo / Redo / Lưu / Discard | **SAV** | 97–101 | §8.01–§8.05 | 5 | 0 | 0 | ⚠️ **TB-31 / Q-9 descope hẹp (A-16)**: 100 |
| 13 | Hai chế độ Layout \| Decorate *(🆕 lõi của TF-117)* | **MOD** | 102–107 | §8.1.01–§8.1.06 | 6 | 0 | 0 | ⚠️ **Q-7b (MỞ, chưa chặn)**: 107 |
| 14 | Panel Layers *(🆕)* | **LYR** | 108–121 | §8.2.01–§8.2.14 | 11 | 3 | 0 | ⚠️ TB-25: 108, 110 · **(QC) A-9**: 109 · **(QC) A-12 + TB-31/Q-9 (A-16)**: 120, 121 |
| 15 | Chrome phụ (Grid, toast, ống hút, cảnh báo tràn màn) | **CHR** | 122–126, 130–136 | §9.01–§9.04, §9.07, §9.09–§9.14 | 6 | 2 | 4 | ⚠️ TB-28: 124 · **(QC) A-7**: 134 · TB-10: 136 |
| 16 | Style sheet + Text size | **STY** | 127–129 | §9.05–§9.06 | 3 | 0 | 0 | ⚠️ TB-22: 128 |
| 17 | Regression ngoài màn Customize | **REG** | 137–143 | §11 #1–#7 | 6 | 1 | 0 | — |
| 18 | **Snap dọc + chip gap** — **KHÔNG có trong test basis TF-117** | **SNP** | 144–150 | 1.2.18 §4.05–§4.07, §3.09 (đối chiếu) + **quyết định QC (Q-2 = A)** | 4 | 2 | 1 | ⚠️⚠️ **toàn nhóm (QC) A-8** |
| 19 | **Nội dung Decorate chạy lại trong ngữ cảnh gộp** — **KHÔNG có trong test basis TF-117** | **DEC** | 151–171 | 1.2.15 §2.1–§2.5, R1–R8 (đối chiếu) + **quyết định QC (Q-7 = B)** | 16* | 4 | 1 | ⚠️⚠️ **toàn nhóm (QC) A-13**; **TC117-165 GAP, chờ Q-7b — không viết case** |
| | **Tổng** | | **171** | | **106** | **55** | **10** | **65 nhãn ⚠️** |

`*` Nhóm DEC: 16 P1 gồm cả **TC117-165** (Cutout) — condition này **giữ nguyên mức risk P1** trong
test-analysis nhưng **không được viết/chạy case** ở đợt này (điều kiện 6 ở banner); khi Q-7b có trả lời thì
mở khoá bình thường, không cần thay đổi risk level.

**Ghi chú bắt buộc cho nhóm SNP và DEC (điều kiện 3 ở banner):** traceability của 2 nhóm này **không** đi
qua test basis TF-117 — Phụ lục A ghi rõ nguồn là "spec đối chiếu + quyết định QC", **không** trình bày như
thể đó là requirement của TF-117. Nếu dev sau này xác nhận nhóm SNP đã bị bỏ (đảo A-8) hoặc bàn giao checklist
Decorate mới (thay A-13) → **toàn bộ 2 nhóm phải viết lại**, không chỉ vài dòng.

---

## 3. Out of scope

| # | Hạng mục | Lý do | Điều kiện đưa lại phạm vi |
|---|---|---|---|
| 1 | **`TC117-G4` — nhánh "phiên chỉ đổi ảnh nền / chỉ kéo Darken rồi bấm ✕"** | **`GAP` — descope hẹp**, quyết định của người review (Q-9, 2026-09-29 đợt 2). Lỗ oracle (§8.04 ↔ §8.2.13 ↔ Q-6 = C) **vẫn còn nguyên** trong tài liệu, chỉ nhánh dùng nó ra khỏi phạm vi thực thi. **Không viết case, không suy diễn expected result.** **Không** descope phần còn lại của TC117-100/120/121/170 hay toàn bộ §8.04 | Dev xác nhận hành vi (O-31) → mở lại thành condition bình thường, dự kiến **P1** vì là đường dẫn tới mất dữ liệu người dùng |
| 2 | **`TC117-165` — Cutout** | **`GAP` chờ Q-7b** (đường vào Cutout chưa rõ — rail Decorate mới không có nút Cutout riêng). **Không viết/chạy case trước khi có trả lời**, không tự đoán "nằm trong menu con của Photo" | Q-7b có trả lời → viết case bình thường, giữ nguyên mức **P1** đã gán ở test-analysis |
| 3 | **`TC117-G6` — cụm gesture-arbitration band↔Decorate** | **Đã đóng** (Q-8 = A, band trơ). Cả cụm (~6–8 condition ứng viên: chọn band ở Decorate, kéo/kéo góc/nhấn giữ band ở Decorate, quy tắc ẩn công tắc khi kéo band ở Decorate, cử chỉ nào thắng khi cầm bút) **không tồn tại** trong phạm vi đợt này | **Hệ quả ngược:** nếu khi thực thi phát hiện band **vẫn** chọn/kéo/kéo góc/nhấn giữ được ở Decorate ⇒ đây **là bug cần report ngay**, không phải lỗi thiết kế test case (khớp điều kiện 5 ở banner) |
| 4 | iPhone **iOS 27** | TF-117 §1 bỏ hẳn dòng loại trừ tường minh của 1.2.18 nhưng không nói rõ là đưa vào hay quên chép (TB-10, O-3) — **QC giữ nguyên trạng loại trừ của 1.2.18** cho tới khi có xác nhận khác | Dev xác nhận iOS 27 nằm trong phạm vi |
| 5 | 16 locale ngoài **VI + EN** (trong tổng "18 ngôn ngữ" §1) | Không có danh sách 18 locale cụ thể (TB-09, O-2); chỉ kiểm được "không lọt chuỗi tiếng Anh vào máy VI" | Dev bàn giao danh sách 18 locale |
| 6 | Đo định lượng: fps/frame-drop (TB-17), ngưỡng "kéo nhẹ" trước 0,4s (TB-11), mức tối thiểu bề rộng (TB-12), lề "giống Studio" (TB-15), ngưỡng tương phản "khó đọc/đọc được" (TB-18), 4pt khoảng cách rail (TB-28), trần lịch sử Undo (TB-34) | Không có giá trị/đơn vị trong bất kỳ tài liệu nào — chỉ kiểm được **hành vi**, không kiểm được **giá trị** | Dev/design bàn giao số cụ thể |
| 7 | Quy tắc bù trừ Row **3+ con** khi kéo vách ngăn (TB-13) | Chỉ mô tả Row 2 con; chỉ kiểm được bất biến "tổng bề rộng Row không đổi" | Dev bàn giao quy tắc bù trừ |
| 8 | Cách đếm "tối đa 3 cấp container" (TB-14) | Không rõ stack gốc có tính 1 cấp | Dev xác nhận cách đếm |
| 9 | **Danh mục component chính thức** (tên UI ↔ tên code ↔ knob riêng) | Chưa được bàn giao từ bộ 1.2.18 (TB-22/O-23) — chỉ kiểm knob **đã nêu tên** trong test basis | Dev bàn giao danh mục |
| 10 | Known-issue triage emoji iOS 26 (TB-32) | TF-117 không có mục "lỗi đã biết"; 1.2.15 nói đây là known issue chưa fix — cần dev xác nhận trạng thái trước khi phân loại pass/fail | Dev xác nhận đã fix hay chưa (O-28) |
| 11 | Cách reset **chỉ** coach tour trên build TestFlight (TB-20) | Cờ `-ink-debug-customize-coach` chỉ chạy từ Xcode; "cài mới" xoá luôn state khác | Dev bàn giao cách reset không phá state khác |
| 12 | Gate Pro cho **loại component** (kế thừa từ 1.2.17/1.2.18) | Không có trong TF-117 lẫn 1.2.18; không đủ căn cứ viết case | — |
| 13 | Automation/unit test | Test plan này là black-box thủ công, đúng quy ước repo | — |

### 3.1 Ảnh hưởng chéo tới flow khác

> Đối chiếu [screenshot-naming.md §7](../../../../.claude/rules/screenshot-naming.md#7-flow-map--ink-calendar-ios).

| Flow | Ảnh hưởng? | Lý do / condition liên quan |
|---|---|---|
| `14_edit-wallpaper` (chính nó) | **Trực tiếp** | Toàn bộ 171 condition; **chưa có screenshot/wireframe** cho state mới (mục 1.3) — cần `screen-name` mới khi chụp lại |
| `10_lockscreen` | **Trực tiếp** | Kết quả cuối của mọi thay đổi bố cục/trang trí/nền — nhóm REG (TC117-137), độ tối Darken khớp canvas (TC117-121), sticker render đúng vị trí (TC117-163, 169) |
| `04_discover` | **Gián tiếp** | Đường vào 1 (Discover → template → Edit); "Your collection" thumbnail/widget cập nhật (TC117-139), mở lại template đã sửa (TC117-140) |
| `05_calendar` | **Gián tiếp** | Đường vào 2 (Calendar tab → nút cập nhật wallpaper → Edit); nguồn dữ liệu event cho band dạng lịch và Sample events (TC117-133) |
| `08_paywall` | **Gián tiếp, có case tường minh** | Gate Pro: sticker cutout / font Pro (TC117-107) và ảnh nền Pro (TC117-120) — cả hai đều mang nhãn ⚠️ (Q-7b, TB-23) |
| `03_shortcut-setup` | **Không xác định — không có case tường minh** | TF-117 §11 **không** nhắc lại yêu cầu "sống sót automation overnight" mà 1.2.18 từng có (TC18-116); wallpaper vẫn tự render mỗi sáng qua Shortcut, nhưng test basis không đặt điều kiện kiểm — ghi vào coverage gap (mục 11), **không** tự thêm case |
| `06_task`, `07_note`, `09_settings`, `01_onboarding`, `02_permission` | **Không** (trừ Note) | Wallpaper **note** (không phải lịch) phải **không bị ảnh hưởng** — TC117-142 (REG). Còn lại không có entry point/pipeline dữ liệu chung |
| `11_share`, `12_ai-assistant`, `13_community` | **Không áp dụng** | 🚧 chưa build |

---

## 4. Test levels & test types

- **Level:** **System testing**, black-box, thủ công (ISTQB §2.2.1). Không dùng simulator cho nhóm **DRG /
  ROD / SNP / DEC** (cần cảm nhận cử chỉ + haptic → **máy thật bắt buộc**). **REG** có phần
  **Integration/System-integration** với lock screen thật, Live Activity, widget.
- **Functional:** cả 19 test object.
- **Non-functional (ISO 25010 — §2.2.2):**

| Quality characteristic | Áp dụng cho | Condition tiêu biểu |
|---|---|---|
| **Performance efficiency** | Phản hồi kéo/resize realtime; kéo liên tục 5–10s | TC117-20, 39, 41 — quan sát định tính, không có ngưỡng (out of scope #6) |
| **Compatibility** | iOS 18.x vs 26.x (chrome glass); iPad xoay ("nếu có") | ENV (04, 05), CHR (136), INS (73), DEC (163, 169) |
| **Usability** | Coach tour, haptic (nhấn giữ + snap), canvas tự đẩy lên, vị trí rail 4pt | COACH, ROD (33), SNP (148), INS (70) |
| **Reliability** | Undo/Redo = đúng 1 bước, lịch sử chung 2 chế độ, không mất/nhân bản thành phần, render 1 lần, migration | SAV, MOD (103, 104), LYR (118), REG (140, 143), DEC (154, 155, 159, 160, 166) |
| **Portability** | Xoay iPad, bảng thuộc tính = cột bên phải | CHR (136), INS (73) |
| **Internationalization** | Chuỗi VI/EN của Customize (mới) và của Decorate (kế thừa 1.2.15, chỉ cam kết 10 locale cũ) | ENV (07), DEC (171) |
| Security · Maintainability · Safety | **Không áp dụng** | Không có yêu cầu trong TF-117 |

- **Change-related (§2.2.3):**
  - **Confirmation testing:** TF-117 **không có mục "đã sửa"** kiểu §0 của bộ 1.2.18 — không xác định được
    danh sách lỗi cũ được tuyên bố đã fix trong đợt này. Việc kiểm các hành vi **đảo ngược** so với 1.2.18
    (TC117-30/31/32 biên mép ảnh, TC117-64 Vertical position, TC117-48 bỏ nhóm Text) đóng vai trò tương
    đương confirmation testing cho các quyết định đã chốt bằng câu trả lời QC.
  - **Regression testing — KHÔNG được rút gọn, phạm vi rộng hơn cả 1.2.18 lẫn 1.2.15:**
    - Toàn nhóm **REG** (7 condition, §11) vì màn ghi thẳng vào dữ liệu wallpaper.
    - Toàn nhóm **SNP** (7 condition) — xác nhận cụm snap/gap của 1.2.18 còn sống sau khi viết lại cơ chế
      kéo/đổi chỗ.
    - Toàn nhóm **DEC** (21 condition, trừ TC117-165) — xác nhận nội dung Decorate của 1.2.15 còn đúng sau
      khi đổi kiến trúc (Undo chung, Layers gộp, Discard chung). **4 case đã từng vỡ ở 1.2.15** (TC117-159,
      160, 166, 169 — quy định lỗi tái phát) nên ưu tiên chạy sớm trong nhóm DEC.

---

## 5. Kỹ thuật thiết kế test case

> Kỹ thuật chỉ áp dụng nơi thật sự phù hợp (ISTQB §4.1). Dữ liệu dưới đây dùng được ngay cho `test-case`;
> **mọi dòng ⚠️ giữ nhãn** đúng như test-analysis mục 2/4C.

### Bảng tóm tắt theo nhóm

| Nhóm | Kỹ thuật chính | Kỹ thuật phụ |
|---|---|---|
| ENV | Equivalence Partitioning (loại template stack/không-stack) | Checklist-based |
| COACH | **State Transition** (2 bước tour) | EP (điểm vào Layout/Decorate) |
| SEL | **State Transition** (đã dùng ở 1.2.18, tái sử dụng) | EP theo độ sâu lồng |
| DRG | EP (đối tượng kéo) + **BVA 3-value** (biên mép ảnh) | Checklist-based (invariant), State Transition (thẻ nền) |
| ROD | **Decision Table** (cơ chế mới hoàn toàn) | BVA (ngưỡng 0,4s — ghi nhận quan sát, không có giá trị) |
| RSZ | Decision Table + BVA (số con trong Row) | Checklist-based |
| ADD | EP (trạng thái chọn khi bấm +) + Decision Table (điều kiện chặn tràn) | Checklist-based (tồn kho sheet) |
| CTN | **BVA** (độ sâu 1/2/3 cấp) | State Transition (container rỗng) |
| INS | State Transition (Auto ↔ Fixed, bảng thuộc tính mở/đóng) | Checklist-based |
| TXT | **BVA 2-value** (Size 200/60) | Decision Table (Bold × Italic 2×2), Checklist-based |
| KNB | EP (loại band theo tên nêu trong spec) | Checklist-based theo từng loại |
| SAV | State Transition (Undo/Redo/Done/Cancel) | — |
| MOD | **State Transition** (lịch sử Undo chung 2 chế độ — lõi của TF-117) | Decision Table (điều kiện ẩn công tắc) |
| LYR | **Decision Table** (kéo dòng × nhóm × Fixed) | State Transition (đổi tầng ↔ Undo chung) |
| CHR | Checklist-based | — |
| STY | State Transition (mở/đóng sheet Style, Undo gộp) + **BVA 3-value** (Text size 80/100/130%) | Checklist-based |
| REG | Checklist-based, có thứ tự phụ thuộc | — |
| SNP | **BVA 3-value trên dấu của gap** + Decision Table (điểm snap × loại band) | State Transition (đang nằm sẵn trên snap) |
| DEC | Checklist-based theo công cụ + **Decision Table** (gesture sticker/band, TC117-168) | State Transition (Undo/Redo xuyên công cụ) |

**Exploratory (session-based):** **không** dùng nhãn exploratory cho case đã có đáp án. Đề xuất áp dụng
**đúng nguyên tắc như bộ 1.2.18** — dành cho phần test basis **tự thừa nhận không có oracle**: danh mục
component chưa chính thức (out of scope #9) và checklist Text sticker của Decorate (O-27, coverage nông).
Kết quả chỉ là dữ liệu gửi dev, **không tính vào exit criteria**.

### 5.1 ENV — EP + Checklist

**EP theo loại template:** {stack (có công tắc) | không phải stack (mở thẳng Decorate, không công tắc)} →
TC117-03. **TC117-01** (đúng build TF-117) **là entry criterion**, không phải test case thường (mục 8) — sai
build ⇒ kết quả mọi nhóm vô nghĩa. Còn lại: vị trí chip Customize ở cả 2 đường vào (02), header/rail tồn kho
(06, 08), chrome glass iOS 26 (05) → checklist từ §1–§2.

### 5.2 COACH — State Transition

**States:** T0 chưa xem tour · T1 bước 1 (soi công tắc) · T2 bước 2 (soi rail của chế độ đang mở) · T3 tour
đã tắt.

| # | State | Event | State kế tiếp | Condition |
|---|---|---|---|---|
| C1 | T0 | Mở Customize lần đầu (template stack) | T1 | TC117-09 |
| C2 | T1 | Bấm **Next** | T2 (rail của chế độ **đang mở**, không đổi) | TC117-09 |
| C3 | T1 | Bấm **thẳng vào một tab** của công tắc | **Đổi chế độ** rồi → T2 với rail **của chế độ vừa chọn** | TC117-10 |
| C4 | T2 | Bấm **Got it** | T3 | TC117-09 |
| C5 | T2 | Bấm **một nút trên rail** | T3 **và** nút vẫn chạy | TC117-10 |
| C6 | T0, mở lần đầu ở **Layout** | Sang **Decorate** lần đầu | Có **riêng** bước rail Decorate (⚠️ TB-21, chờ xác nhận cố ý) | TC117-11 |
| C7 | T0, mở lần đầu ở **Decorate** | Sang **Layout** lần đầu | **Không** có gì thêm | TC117-11 |
| C8 | T3 | Mở lại màn | **Không** hiện tour nữa | TC117-09 |
| C9 | T0, template **không phải stack** | Mở Customize | Tour **chỉ một bước rail** (không có bước công tắc) | TC117-12 |

> ⚠️ **TB-20 — điều kiện thực thi:** cờ `-ink-debug-customize-coach` chỉ chạy từ Xcode; cần thống nhất cách
> reset tour không xoá state khác trước khi lặp lại C1–C9 nhiều lần (mục 3, out of scope #11).

### 5.3 SEL — State Transition (tái sử dụng bảng 1.2.18 §5.4, không viết lại)

Dùng nguyên bảng State Transition T1–T10 của `test-plan-1.2.18.md` mục 5.4 (chọn đơn/container/con, Delete +
Undo, chạm vùng trống) — hành vi **không đổi** ở TF-117 ngoại trừ **TC117-14**: pill nay **chỉ còn Edit ·
Delete**, không còn mũi tên ↑/↓/←/→ (đổi thứ tự chuyển sang nhóm ROD). Test-case chỉ cần thay T5 (Delete) và
bỏ transition liên quan mũi tên, giữ nguyên phần còn lại.

### 5.4 DRG — EP + BVA + Checklist

**EP theo đối tượng kéo:** {thành phần đơn top-level | container Row/Column (con đi theo) | con bên trong
container} × {container có thẻ nền | không có thẻ nền}. Bắt buộc dùng template có **Row lồng trong Column**.

**BVA 3-value — biên "mép ảnh" (kéo dọc), oracle = A-7 (⚠️ QC, dev chưa xác nhận):**

| Biên | Giá trị test | Kỳ vọng | Condition |
|---|---|---|---|
| Dưới | (a) tới vạch dưới grid · (b) quá vạch dưới grid, vẫn trong ảnh · (c) đúng mép dưới ảnh · (d) cố vượt mép dưới | (a),(b),(c) cho phép · (d) bị chặn | TC117-32 ⚠️ |
| Trên — **band đầu** | (a) chưa tới vạch trên grid · (b) qua vạch trên grid · (c) đúng mép trên ảnh · (d) cố vượt | (a),(b),(c) cho phép (band đầu vẫn qua được vạch trên) · (d) bị chặn | TC117-30, 31 ⚠️ |
| Cảnh báo tràn màn | kéo band ra ngoài vùng an toàn / band đầu lên quá vạch trên | *"Part of this runs off the screen"* bật; kéo về trong → mất | TC117-134 ⚠️ |
| Chặn tràn đáy | band cuối vượt biên dưới (mép ảnh, theo A-7) | sheet Add mờ toàn bộ khi bấm + | TC117-52 ⚠️ |

> ⚠️ **Điều kiện thay đổi:** dev nói TF-117 **cố ý thắt lại** về đúng "vùng nội dung" (khác mép ảnh) ⇒ viết
> lại toàn bộ BVA trên với biên mới, và §9.12 cần cơ chế khác để bật cảnh báo tràn màn (xem TB-01).

**Checklist invariant:** đi theo ngón ngay (20) · không đè lên band trên (21) · kéo ngang (22) · kéo cả
container đi cùng, không văng ra (23) · không bản sao/không mất rồi hiện lại (24) · nhả tay render 1 lần
(25) · vẽ lại thật, band dưới dồn theo, chữ mềm 2/3 độ phân giải là cố ý (26) · thẻ nền: kéo container → đi
cùng, kéo con → tạm ẩn (27, 2 case tách biệt, cách hiểu A của Q-1 bộ 1.2.18 — vẫn ASSUMPTION, A-2) · sticker
không biến mất khi kéo band (28) · khung viền ôm đúng khi kéo nhanh (29) · kéo liên tục 5–10s không giật —
không ngưỡng (39, TB-17).

### 5.5 ROD — Decision Table (cơ chế mới hoàn toàn thay mũi tên ↑/↓)

**Điều kiện:** C1 Kiểu band (Auto/Fixed) · C2 Band là con duy nhất trong Row/Column hay không · C3 Container
(dọc → kéo lên/xuống; Row → kéo trái/phải) · C4 Band cao/thấp khác nhau khi đổi chỗ.

| Rule | C1 | C2 | C3 | C4 | Kỳ vọng | Condition | Nhãn |
|---|---|---|---|---|---|---|---|
| R1 | Auto | không | dọc/Row | — | Giữ yên ~0,4s → rung nhẹ, nổi lên (to hơn, có bóng), khung chọn chuyển sang nó | TC117-33 | — |
| R2 | Auto | không | — | — | **Kéo nhẹ trước 0,4s** → là kéo tự do (nhóm DRG), không vào chế độ nhấc-đổi-chỗ | TC117-34 | ⚠️ TB-11 (ngưỡng chưa rõ) |
| R3 | Auto | không | dọc | có | Đang giữ, kéo qua nhiều chỗ: mỗi lần qua rung nhẹ; **giữ nguyên gap giữa các band**, không band nào đè band khác | TC117-35, 36 | ⚠️ **(QC) A-9** |
| R4 | Auto | không | — | — | Nhả tay: trượt vào chỗ mới, không nháy 2 lần; nhả ở chỗ cũ → không đổi gì, **không** sinh Undo; đổi nhiều chỗ → **Undo 1 lần** về như trước; nhả không bị hiểu là chạm | TC117-38 | ⚠️ **(QC) A-9** |
| R5 | **Fixed** | — | — | — | Nhấn giữ **không** nổi lên, **không** tính là "kế bên", đứng yên khi band khác đổi chỗ | TC117-37 | ⚠️ TB-24 — nặng thêm sau A-11 (Fixed cũng không có Vertical position ⇒ **chưa rõ còn đường nào đổi vị trí band Fixed**, chỉ ghi nhận, không suy diễn) |
| R6 | — | **có** (con duy nhất) | — | — | Nhấn giữ → nhấc **cả container** | TC117-37 | — |

> ⚠️ **Điều kiện thay đổi (A-9 / Q-3):** dev nói "giữ toạ độ đỉnh của từng slot" (thay vì giữ gap) ⇒ viết
> lại R3/R4, thêm case band cao đổi xuống slot thấp. **Đây là đợt thứ 2 liên tiếp** dev chưa trả lời câu hỏi
> này (kế thừa Q-10 của bộ 1.2.18) — rủi ro tích luỹ, phải nêu trong risk (mục 6.5).

### 5.6 RSZ — Decision Table + BVA

| Rule | Vị trí | Góc kéo | Kỳ vọng | Condition |
|---|---|---|---|---|
| Z1 | Ngoài cùng (stack/column) | Phải | Cạnh trái đứng yên, vẫn canh giữa | TC117-40, 44 |
| Z2 | Ngoài cùng | Trái | Cạnh phải đứng yên | TC117-40, 44 |
| Z3 | Trong Row (2 con) | bất kỳ | Vách ngăn: con bên cạnh hẹp lại đúng bằng đó, tổng bề rộng Row không đổi | TC117-45 |
| Z4 | Trong Row (3+ con) | bất kỳ | ⚠️ **Chỉ kiểm bất biến:** không con nào co về 0, không đè nhau, tổng bề rộng không đổi. **KHÔNG kiểm quy tắc bù trừ cụ thể** | TC117-46 (TB-13) |
| Z5 | Bất kỳ, có chữ | kéo hẹp | Chữ xuống dòng lại + chiều cao đổi **ngay lúc kéo** | TC117-42 |

**BVA số con trong Row:** 2 (Z3) · 3 (biên "3+", Z4). **Min-width:** không có ngưỡng ⇒ chỉ xác nhận có chặn /
không co về 0 (TC117-47, TB-12). Còn lại: realtime (41), nhả tay không nhảy/đổi lần nữa (43).

### 5.7 ADD — EP + Decision Table + Checklist

**EP trạng thái chọn khi bấm +:** {đang chọn 1 thành phần (50: rơi ngay dưới) | đang chọn Row/Column (51: rơi
vào trong) | không chọn gì (rơi cuối stack, suy luận từ hành vi mặc định, không có câu riêng)}.

**Checklist tồn kho sheet Add — oracle = A-10 (⚠️ QC, ngược câu chữ §6):** **16 mục / 5 nhóm** (Calendar ·
Events · Tasks · Progress · Layout) — **KHÔNG** có nhóm Text; thấy nhóm Text ⇒ **report** (TC117-48).

**Decision Table — điều kiện chặn khi tràn đáy (TC117-52, 53):**

| Rule | Điều kiện | Kỳ vọng |
|---|---|---|
| B1 | Lịch đã tràn qua đáy (theo A-7: đo bằng mép ảnh) | Sheet Add hiện dòng cảnh báo, **mọi loại mờ, không bấm được** |
| B2 | Band tràn đáy là **Fixed** | **Không** chặn |
| B3 | Đang bật **Sample events** | **Không** chặn |
| B4 | Bấm + ở **ô trống** của Row/Column hoặc đang chọn **container** | **Không** chặn |
| B5 | Band chỉ tràn **lề trái/phải** | **Không** chặn |
| B6 | Xoá/thu nhỏ bớt cho vừa lại | Mở + chọn được bình thường |

### 5.8 CTN — BVA (độ sâu) + State Transition

| Cấp container | Kỳ vọng | Condition |
|---|---|---|
| 1–2 | Sheet Add còn nhóm Layout | TC117-59 |
| **3** (biên trên hợp lệ) | Layout **biến mất**, 4 nhóm còn lại vẫn còn (theo A-10: 16→14 mục) | TC117-59 ⚠️ |
| Sibling ở cấp còn cho phép | vẫn thêm được | TC117-60 |

> ⚠️ TB-14: cách đếm "3 cấp" (stack gốc có tính 1 cấp không) chưa chốt — **kiểm bằng cấu trúc lồng thật**
> `Column > Row > Column` (ví dụ hợp lệ của §6.2), không suy diễn mốc đếm, không thiết kế "cấp 4".

**State Transition — container rỗng:** {Container rỗng} —Done→ {bị bỏ + toast *"Removed the empty
layout"* + Undo} —Undo→ {quay lại editor} (TC117-61). Còn lại: 2 ô trống nét đứt cạnh nhau/xếp dọc (54) ·
bấm + trong ô trống lấp đúng ô đó (55) · bấm nền ô → chọn container (56) · lấp đủ → chia đôi, hết ô thừa (57)
· INT: Row/Column 1 con vẫn chiếm chỗ như 2 con — cố ý (58, §10 #1).

### 5.9 INS — State Transition (Auto↔Fixed, bảng thuộc tính) + Checklist

**Auto ↔ Fixed:** 2 state, chuyển 2 chiều không tự nhảy chỗ (TC117-63). **Bảng thuộc tính mở/đóng:** dùng lại
tinh thần State Transition T4–T9 của 1.2.18 (chạm vùng trống/grabber/✕/Deselect đều về S0, chỉ khác selection
có giữ hay không) — áp cho TC117-68, 69. Còn lại checklist: thứ tự nhóm Content→Text→Background→Position
(62) · Width khớp kéo góc (65) · Size chỉ có ở thành phần ngoài cùng (66) · Duplicate/Delete/Deselect (67) ·
canvas tự đẩy lên (70) · đáy bảng không hở (71) · xoá trong lúc bảng mở vẫn còn nội dung (72) · iPad: bảng =
cột bên phải (73, ⚠️ TB-10 "nếu có").

### 5.10 TXT — BVA 2-value + Decision Table + Checklist

**BVA 2-value — thanh Size (TC117-74, 75):** chữ chính **tối đa 200**, chữ phụ **tối đa 60**. Giá trị test:
**200** / **60** (biên trên hợp lệ), **"cố kéo vượt trần"** (phải bị chặn). ⚠️ TB-16: **chỉ biên trên** — thiếu
biên dưới, đơn vị, và phân loại "chữ chính/chữ phụ" theo từng band (template script **130** không nhất quán
với 2 trần 200/60) → **chỉ kiểm "chạm vào không bị thu nhỏ"**, không kiểm số 130 như một biên hợp lệ.

**Decision Table 2×2 — Bold × Italic (TC117-78):**

| Rule | Bold | Italic | Kỳ vọng |
|---|---|---|---|
| B1 | tắt | tắt | thường |
| B2 | bật | tắt | đậm |
| B3 | tắt | bật | nghiêng |
| B4 | bật | bật | vừa đậm vừa nghiêng — 2 template có sẵn (month *elegant script*, priority matrix) vốn vậy, **không report** |

**Checklist còn lại:** nút B sáng sẵn khi vốn đậm (76) · Reset Position về đúng lúc thêm (77) · mục phụ ngoài
More options: Weekday/Time/Date/Caption (79) · Auto màu trả về mặc định (80) · chip Default font (81) · cỡ
chữ lớn Accessibility không tràn Layers (82) · card tự thu vào theo mép template (83) · mọi thành phần bật
được Card (84) · Card đặc/trắng đổi màu chữ đúng, Match colors to photo đổi chữ khó đọc — ⚠️ TB-18 không có
ngưỡng tương phản (85).

### 5.11 KNB — EP (theo tên nêu trong spec) + Checklist theo loại

**Checklist theo từng loại có tên trong test basis** (không suy diễn cho loại không được nêu — TB-22, out of
scope #9): Countdown (caption sửa/ẩn, 1 bước Undo) · Priority matrix (chữ riêng, Card/Border opacity=0, không
còn Blur/Layout, tối đa 4 việc/ô) · Month grid (màu ngày quá khứ/tương lai, căn phải tiêu đề, Event chips) ·
Hour timeline (Elapsed color) · Timetable/Timeline (cỡ chữ, Blur/viền, Header/Subheader) · Week
schedule/events (font/cỡ/màu, Today color, Show +N) · Quote (danh sách câu xoay vòng, Reset, không có ở kiểu
âm lịch) — tương ứng TC117-88, 89, 90, 91, 92, 93, 94. Còn: dòng Event colors chỉ ở band có sự kiện (95) ·
tồn kho More options + không còn control vô tác dụng, **Vertical position chỉ còn ở Quote** (96, ⚠️ A-11 +
TB-19 Blur vẫn MỞ) · inspector lần đầu đúng như đang vẽ (87) · knob đổi ăn ngay (86, ⚠️ TB-22).

### 5.12 SAV — State Transition

{Có thay đổi} —✕→ {hỏi *"Discard changes?"*} —Discard→ {mọi thay đổi Layout+Decorate+Background bị bỏ, về
đúng lúc mở màn} (TC117-100 ⚠️ **A-16, chỉ nhánh "có đổi Layout/Decorate" — nhánh hẹp "chỉ đổi nền/Darken"
ngoài phạm vi**). {Không thay đổi hoặc đã undo hết} —✕→ {đóng luôn, không hỏi}. Còn: Undo = đúng 1 thao tác
(97) · Redo (98) · ✓ giữ bố cục (99) · sau Discard, Undo bị mờ (101).

### 5.13 MOD — State Transition (lõi của TF-117)

**States:** L (đang ở Layout) · D (đang ở Decorate).

| # | State | Event | State kế tiếp | Condition |
|---|---|---|---|---|
| M1 | (mở lần đầu) | Mở Customize | **L** | TC117-102 |
| M2 | L hoặc D | Đóng rồi mở lại | **State dùng lần trước** (nhớ chế độ) | TC117-102 |
| M3 | L | Kéo band → sang D vẽ 1 nét → **Undo lần 1** | Mất nét vẽ, **vẫn ở D** | TC117-103 |
| M4 | D (sau M3) | **Undo lần 2** | Band về chỗ cũ **và tự chuyển sang L** | TC117-103 |
| M5 | bất kỳ | **Redo** (ngược M3/M4) | Đi ngược đúng thứ tự, **tự chuyển chế độ** theo bước làm lại | TC117-104 |
| M6 | L (đã sửa bố cục) | Sang D, bật **Show calendar** | Lịch vẽ đúng **bố cục mới** | TC117-105 |
| M7 | L hoặc D | Đang kéo / đang mở bảng thuộc tính / đang cầm bút-tẩy-eyedropper / đang gõ chữ | Công tắc chế độ **ẩn** | TC117-106 (⚠️ O-32: ý định "đang kéo" ở D nay = kéo sticker/ảnh, không còn "kéo band") |
| M8 | L hoặc D | Có sticker cutout hoặc font Pro (free) → bấm ✓ | **Hỏi Pro**, ở cả hai chế độ | TC117-107 (⚠️ Q-7b — nhánh cutout chờ đường vào) |

### 5.14 LYR — Decision Table (kéo dòng) + State Transition (Undo xuyên nhóm)

**Điều kiện:** C1 Nhóm (Layout/Decorate/Background) · C2 Band Fixed hay Auto (chỉ áp cho nhóm Layout) · C3
Template stack hay không.

| Rule | C1 | C2 | C3 | Kỳ vọng | Condition |
|---|---|---|---|---|---|
| Y1 | Layout | Auto | stack | Nhấn giữ dòng (có ≡) kéo → đổi thứ tự band, **gap giữa các band giữ nguyên** (A-9); qua nhiều band = 1 bước Undo | TC117-109 ⚠️ |
| Y2 | Layout | **Fixed** | — | **Không có ≡**, không kéo được | TC117-109 |
| Y3 | Layout | — | **không phải stack** | Chỉ có 1 dòng "Calendar", **vẫn** đổi tầng được cho nhóm Decorate | TC117-119 |
| Y4 | Decorate | — | — | Dòng trên cùng = item trước nhất; kéo thả đổi item nào đè item nào, thấy ngay trên canvas | TC117-110 (⚠️ TB-25) |
| Y5 | — (giữa 2 nhóm) | — | — | **Không** kéo được dòng từ nhóm này sang nhóm kia | TC117-111 |
| Y6 | Background | — | — | Không kéo (chỉ Default/ảnh của bạn/ảnh có sẵn/thêm ảnh/More + Darken); đổi ảnh **không** sinh Undo (A-12) | TC117-120 ⚠️, 121 ⚠️ |

**State Transition Undo xuyên nhóm:** mỗi lần đổi thứ tự (Layout hoặc Decorate) = 1 bước Undo; Undo 1 bước
**của nhóm kia** → màn **tự chuyển chế độ** (giống mục 5.13) — TC117-118. Còn: card/góc bo đứng yên khi kéo
(112), VoiceOver Move up/down (113), mũi tên tiêu đề đổi chỗ 2 nhóm (114), Decorate lên trên lịch → sticker
đè cả 2 chế độ + lock screen thật (115), band luôn đi dưới sticker khi kéo (116), card kính mờ chỉ làm mờ
nền không mờ sticker — cố ý §10 #6 (117).

### 5.15 CHR — Checklist-based

Grid bật/tắt không đè thao tác kéo (122) · Grid dùng chung 2 chế độ, rail Decorate không còn *Lock screen*
(123, TC117-08 liên quan) · 4pt rail — ⚠️ TB-28 không đo được chắc (124) · Sample events + Grid chỉ 1 toast
(125) · ống hút màu lấy đúng nền mới/sticker đè lên chữ (126) · Match colors to photo mô tả (130) · sheet
đang mở đóng trước khi sheet mới hiện (131) · Show decorations ẩn cả 2 lớp sticker, không lưu, không Undo
(132) · Sample events không lọt vào wallpaper thật (133) · cảnh báo tràn màn (134, ⚠️ A-7) · ẩn/hiện chrome
(135) · xoay iPad khung viền khớp — ⚠️ TB-10 (136).

### 5.16 STY — State Transition + BVA 3-value

**Mở/đóng sheet Style:** đổi gì thấy ngay (127) · đóng sheet = **Undo 1 lần** trả lại toàn bộ thay đổi của
lần mở đó; mở-đóng không đổi gì → không sinh Undo, Redo còn nguyên; Undo ở header khi sheet đang mở → trả lại
đúng thay đổi trong sheet (128, ⚠️ TB-22: nhánh lai "Undo trong sheet rồi đóng sheet" chưa có oracle).

**BVA 3-value — Text size (TC117-129):** **80%** (biên dưới) · **100%** (mốc "chưa chỉnh") · **130%** (biên
trên — không component nào bị cắt/đè: miniMonth, todayList, reminderList, weekTimetable, progress; lịch âm
chỉ tiêu đề+thứ to lên, số trong vòng tròn giữ nguyên; caption Decorate **không đổi**). Về 100% = như chưa
chỉnh; lưu rồi mở lại vẫn giữ.

### 5.17 REG — Checklist-based, có thứ tự phụ thuộc

Chạy **sau** khi các nhóm ghi dữ liệu (DRG/ROD/RSZ/ADD/CTN/INS/TXT/KNB/SAV/MOD/LYR/SNP/DEC) đã pass:
lock screen thật đúng bố cục+trang trí+lớp (137) · Live Activity không vỡ (138) · widget/thumbnail cập nhật
(139) · mở lại template đã sửa (140) · template cũ y như trước (141) · wallpaper Note không ảnh hưởng (142)
· **migration**: wallpaper có decoration từ bản cũ mở lên vẫn đúng lớp dưới lịch (143, duy nhất case
migration có trong spec — TB-26 đề xuất thêm 2 case còn thiếu, xem mục 11).

### 5.18 SNP — BVA 3-value (dấu gap) + Decision Table + State Transition — **toàn nhóm ⚠️⚠️ (QC) A-8**

> **Không có trong test basis TF-117.** Oracle = spec 1.2.18 §4.05–§4.07, §3.09 + quyết định QC (Q-2 = A).
> Nếu dev nói cụm này đã bị bỏ ⇒ **cả 7 condition ra khỏi phạm vi**, và app vẫn snap mới là bug.

**BVA 3-value trên dấu gap (band đầu):**

| Giá trị | Vị trí | Chip hiển thị | Condition |
|---|---|---|---|
| gap < 0 | band đầu quá vạch trên grid | số âm, **không bao giờ `-0`** | TC117-144 ⚠️ |
| gap = 0 | đúng mốc | `0` | TC117-146 ⚠️ |
| gap > 0 | dưới mốc | số dương | TC117-144 ⚠️ |

**Decision Table điểm snap × loại band:**

| Rule | Điểm snap | Loại band | Kỳ vọng | Condition |
|---|---|---|---|---|
| N1 | Giữa màn | mọi | Hút vào + đường gióng | TC117-145 ⚠️ |
| N2 | Gap = 0 | band đầu/band khác | Hút vào, nhả → chip `0` | TC117-146 ⚠️ |
| N3 | Vạch dưới grid | mọi | Đáy band khớp vạch | TC117-147 ⚠️ |

**Haptic:** rung nhẹ **1 lần** mỗi lần hút — ⚠️ O-26: nay có **3 loại rung** trong cùng cử chỉ (nhấn giữ
0,4s · qua một chỗ khi đổi chỗ · hút vào snap), test basis không nói cách phân biệt (TC117-148 ⚠️). **State
Transition:** band đang nằm sẵn trên điểm snap → chạm kéo **không** bị giữ lại (TC117-149 ⚠️). **Duplicate**
band đầu đang gap âm → bản sao không đè (TC117-150 ⚠️).

### 5.19 DEC — Checklist theo công cụ + Decision Table (gesture) + State Transition — **toàn nhóm ⚠️⚠️ (QC) A-13**

> **Không có trong test basis TF-117** (§2 chỉ liệt kê nút rail). Oracle = 1.2.15 §2.1–§2.5, R1–R8 + quyết
> định QC (Q-7 = B). **3 điểm của 1.2.15 đã bị TF-117 ghi đè** (không dùng lại nguyên văn): rail không còn
> *Lock screen*, Discard là dialog chung, Undo chung 2 chế độ.

**Checklist theo công cụ (ưu tiên chạy trước 4 regression đã từng vỡ ở 1.2.15 — TC117-159, 160, 166, 169):**

| Công cụ | Kiểm | Condition |
|---|---|---|
| **Draw** | 4 loại nét khác nhau rõ rệt, giữ đúng sau lưu (151) · brush size đổi độ dày thật (152) · màu đúng (153) · eraser tẩy đúng phần, không sinh Undo thừa (154) · vẽ >50 nét → thông báo hết chỗ, không mất nét cũ (155, ⚠️ TB-34) |
| **Sticker** | chạm 1 = chọn, chạm 2 = mở sheet cài đặt (156) · kéo di chuyển có đường canh giữa (157) · pinch/xoay đúng (158) · **✕ xoá, handle scale+xoay, thả ra header/rail/công tắc hiện lại được — regression đã từng vỡ, ưu tiên chạy sớm** (159) · sheet cài đặt opacity + Undo trả lại (160) |
| **Text** | gõ/áp được, hiện 1 dòng riêng trong Layers (161, ⚠️ O-27: coverage nông, không có checklist chi tiết font/cỡ/màu ở cả 2 tài liệu) |
| **Emoji** | đủ 7 nhóm, tiêu đề đổi theo cuộn (162) · render đúng cỡ/vị trí trên wallpaper đã lưu, cả 2 iOS (163, ⚠️ TB-32 known-issue triage) |
| **Photo** | thêm ảnh → sticker, kéo/scale, quyền Photos đúng (164) |
| **Cutout** | **KHÔNG viết/chạy — chờ Q-7b** (165) |
| **Undo/Redo xuyên công cụ** | Vẽ → Undo → chọn sticker → Redo vẫn sáng **và** nằm đúng lịch sử chung 2 chế độ — **regression đã từng vỡ** (166) |

**Decision Table gesture band↔Decorate (TC117-168, oracle = A-15, cụm G6 đóng):**

| Rule | Công cụ đang cầm | Điểm bắt đầu cử chỉ | Kỳ vọng |
|---|---|---|---|
| G1 | bút/tẩy/sticker | trên **band** lịch | Band **không** phản ứng gì (không viền, không pill, không di chuyển) — cử chỉ thuộc công cụ đang cầm |
| G2 | bút | đè ngang qua band | Nét vẽ ra bình thường, band không bị chọn/di chuyển |
| G3 | (đối chứng) | — | Band **vẫn** chọn/kéo/kéo góc/nhấn giữ được ở Decorate ⇒ **report bug ngay** (khớp điều kiện 5 ở banner) |

Áp dụng G1 làm nhánh bổ sung cho **TC117-157/158/167** (điểm bắt đầu cử chỉ sticker/vẽ nằm **trên** một band).

**iPad xoay ngang, sticker gần mép trên → lưu → đúng chỗ — regression đã từng vỡ** (169). **✓ lưu đúng trang
trí; ✕ dùng hộp thoại chung của Customize, không còn hộp riêng 1.2.15** (170, ⚠️ A-16: nhánh "chỉ đổi
nền/Darken" ngoài phạm vi, nhánh "có trang trí" vẫn trong phạm vi). Chuỗi VI/EN của Decorate — ⚠️ TB-33 (chỉ
kiểm được VI/EN, không kiểm "đủ 18") (171).

---

## 6. Risk-based prioritization

### 6.1 Cơ sở

**Risk level = Risk likelihood × Risk impact** (ISTQB §5.2.1), đã tính sẵn ở test-analysis mục 2 — dùng
**nguyên**, không tính lại: **Cao → P1** · **Vừa → P2** · **Thấp → P3**. Căn cứ **impact**: lấy từ câu mở đầu
test basis — *"vùng ảnh hưởng là toàn bộ wallpaper lịch: bản render thật trên màn khoá, Live Activity, widget
và thumbnail đều ăn theo dữ liệu mà màn này ghi ra"* → condition ghi/đọc dữ liệu bố cục ⇒ impact **Cao**;
condition chỉ ảnh hưởng UI tạm trong editor ⇒ impact **Vừa/Thấp**. Condition liên quan **gate Pro** được gán
impact **Cao** theo ISTQB §5.2.2 (*loss of revenue*) — **suy luận loại rủi ro, không phải số liệu business
do PM cung cấp** (A-3, kế thừa từ bộ 1.2.18). Căn cứ **likelihood:** hành vi **🆕 lần đầu tồn tại** (gộp 2
editor, lịch sử Undo chung, Layers gộp, coach tour) ⇒ **Cao**; hành vi ♻️ lặp lại nguyên văn từ 1.2.18 đã
test một lượt ⇒ **Vừa**; chrome tĩnh ⇒ **Thấp** (A-4).

### 6.2 Severity mapping với `bugs/bug-log.md`

> `bugs/bug-log.md` dùng `Critical/High/Medium/Low`, không phải P1/P2/P3. Khi log bug tìm được trong đợt
> test này: **P1 → Critical hoặc High** (Critical nếu mất dữ liệu wallpaper không khôi phục được — vd
> Undo/Redo sai, mất band/sticker, sai bố cục render ra lock screen thật; High nếu chỉ sai chức năng chính
> nhưng còn cách khôi phục) · **P2 → Medium** · **P3 → Low**. P1/P2/P3 ở đây là **độ ưu tiên test** (nên
> test cái gì trước), **không** tự động là severity của bug tìm được — 2 khái niệm khác nhau, tránh gán
> nhầm khi ghi bug log. Khi log bug, `Flow` = `14_edit-wallpaper`, `Screen` = `customize` (chưa có trong
> danh sách screen-name hiện tại của `screenshot-naming.md` §7.1 — cần bổ sung khi có ảnh baseline, mục 11).

### 6.3 P1 — 106 condition theo nhóm

| Nhóm | Số P1 | Vì sao impact cao (tiêu biểu, không lặp lại toàn bộ) |
|---|---|---|
| ENV | 6 | Build sai / chip Customize không hiện / rail sai tồn kho ⇒ chặn toàn bộ đợt test |
| COACH | 1 | Bấm tab ở bước 1 phải đổi đúng chế độ, sai ⇒ user vào nhầm chế độ ngay lần đầu |
| SEL | 3 | Chọn nhầm đối tượng/xoá sai ⇒ mọi thao tác sau tác động sai dữ liệu |
| DRG | 11 | Bản sao/mất thành phần/nhảy vị trí/mất sticker = mất dữ liệu trực tiếp; biên mép ảnh **đảo ngược** so với câu chữ hiện tại của §4.02 |
| ROD | 6 | Cơ chế **hoàn toàn mới** thay ↑/↓; đè band/mất Undo ⇒ hỏng bố cục ngay từ thao tác cơ bản nhất |
| RSZ | 3 | Sai hướng kéo góc phá bố cục đã dựng |
| ADD | 4 | Chặn nhầm/không chặn khi tràn ⇒ wallpaper tràn ra ngoài màn khoá thật |
| CTN | 3 | Container rỗng bị xoá nhầm không Undo được; cấp 3 chặn nhầm Layout ở cấp 1–2 |
| INS | 4 | Auto↔Fixed nhảy vị trí; sheet đóng-mở làm hỏng state chọn |
| TXT | 5 | Cỡ chữ template có sẵn (script 130) bị thu nhỏ nhầm; card không tự thu mép ⇒ vỡ layout hiển thị |
| KNB | 3 | Knob đổi không ăn ngay trên canvas ⇒ user tưởng đã lưu nhưng chưa |
| SAV | 5 | Undo/Redo/Done/Cancel sai ⇒ mất niềm tin vào editor, mất dữ liệu toàn phiên |
| MOD | 6 | **Lõi của TF-117** — lịch sử Undo chung 2 chế độ sai ⇒ hỏng cả Layout lẫn Decorate cùng lúc |
| LYR | 11 | Đổi tầng sai ⇒ sticker/band hiển thị sai lớp trên lock screen thật; Background/Darken sai ⇒ đổi nền không mong muốn |
| CHR | 6 | Sample events lọt vào wallpaper thật (đã có yêu cầu tường minh "không bao giờ") là mất niềm tin nghiêm trọng |
| STY | 3 | Text size 130% làm vỡ layout nhiều loại band cùng lúc; Undo gộp sai ⇒ mất nhiều thay đổi cùng lúc |
| REG | 6 | Impact **cao nhất theo định nghĩa nhóm**: sai ở đây ⇒ lock screen thật/Live Activity/widget hỏng ngoài app |
| SNP | 4 | Sai dấu chip / mốc gap 0 ⇒ user đặt band sai chỗ mà không biết (dù nằm ngoài test basis, vẫn ảnh hưởng dữ liệu bố cục thật nếu còn tồn tại) |
| DEC | 16 | Cử chỉ vẽ/sticker mất dữ liệu (kẹt cứng màn, mất nét, mất sticker khi Undo) — **4 case đã từng vỡ ở 1.2.15** (159, 160, 166, 169); render sai trên wallpaper đã lưu (163); gate Pro (165, dù chưa viết case) |

**P2 — 55** (mất một phần chức năng/UX rõ nhưng có workaround): phần lớn hành vi phụ của INS/TXT/KNB/RSZ,
haptic phân biệt 3 loại rung (SNP), UI nội bộ công cụ Decorate ít thay đổi từ 1.2.15. **P3 — 10** (cosmetic/
xác nhận cố ý): vị trí nút, coach tour bất đối xứng (nếu xác nhận cố ý), 4pt rail, emoji picker tên nhóm, ẩn/
hiện chrome, Row/Column 1 con.

### 6.4 65 nhãn ⚠️ (gap-dependent) — mang nguyên từ test-analysis A-7 … A-16, KHÔNG được bỏ

> Chi tiết đầy đủ từng condition nằm ở test-analysis mục 4C — bảng dưới đây **tóm tắt để test-case tra cứu
> nhanh**, không thay thế nguồn gốc. **0 condition còn gắn câu hỏi CHẶN** sau đợt trả lời thứ 2.

| Loại | Số lượng (không cộng dồn — 1 condition có thể thuộc nhiều loại) | Điều kiện thay đổi tóm tắt |
|---|---|---|
| **(QC) A-7** — biên kéo = mép ảnh | TC117-30, 31, 32, 52, 134, 144, 150 | Dev nói TF-117 **cố ý thắt lại** về "vùng nội dung" ⇒ viết lại toàn bộ biên |
| **(QC) A-8** — toàn nhóm SNP còn tồn tại | TC117-144…150 (7) | Dev nói cụm đã bị bỏ ⇒ cả nhóm ra khỏi phạm vi, app vẫn snap = bug |
| **(QC) A-9** — giữ gap khi đổi chỗ | TC117-35, 36, 38, 109 | Dev nói giữ toạ độ đỉnh slot ⇒ viết lại + thêm case band cao/thấp |
| **(QC) A-10** — không có nhóm Text | TC117-48, 59 | Dev nói nhóm Text quay lại ⇒ cần danh mục cụ thể, đảo expected result |
| **(QC) A-11** — Fixed không có Vertical position | TC117-64, 96 | Dev nói Fixed vẫn có ⇒ TC117-64 quay lại dạng cũ |
| **(QC) A-12** — nền/Darken không sinh Undo | TC117-120, 121 | Dev nói có sinh Undo ⇒ cần hỏi thêm Undo bước đó chuyển chế độ nào |
| **(QC) A-13** — toàn nhóm DEC, oracle = 1.2.15 | TC117-151…171 trừ 168 (20) | Dev nói không dùng 1.2.15 làm oracle / bàn giao checklist mới ⇒ viết lại toàn nhóm |
| **(QC) A-15** — band trơ ở Decorate | TC117-168 | Dev nói band vẫn tương tác ⇒ đảo TC117-168, mở lại cả cụm G6 |
| **A-16 — descope hẹp** | TC117-100, 120, 121, 170 (chỉ nhánh hẹp) | Dev xác nhận hành vi nhánh "chỉ đổi nền/Darken" ⇒ mở lại thành condition bình thường, dự kiến P1 |
| **Gap mở (không chặn, chỉ giới hạn coverage)** | TC117-07, 09, 11, 34, 37, 39, 46, 47, 59, 73, 74, 75, 85, 86, 89, 96, 100, 106, 107, 108, 110, 120, 124, 128, 136, 148, 152, 153, 155, 161, 162, 163, 169, 171 | Xem mục 10B của test-analysis — giá trị/ngưỡng/danh sách chưa được bàn giao |
| **GAP — ngoài phạm vi hoàn toàn** | TC117-165 (chờ Q-7b), `TC117-G4` (nhánh hẹp descope) | Xem mục 3 |

### 6.5 Product risk vs project risk (ISTQB §5.2)

| Loại | Rủi ro | Xử lý trong plan |
|---|---|---|
| **Project** | Giả định A-7…A-13, A-15 sai ⇒ viết lại toàn bộ condition ⚠️ tương ứng (có thể tới **43 condition** nếu nhóm SNP/DEC bị đảo hoàn toàn) | Giữ nhãn ⚠️; chỉ những dòng đó phải sửa; không ảnh hưởng phần còn lại |
| Project | **Chưa có build cụ thể** (TB-08) — không biết branch/PR nào chứa TF-117 | Entry criterion E1 — dừng toàn bộ nếu chưa xác định |
| Project | **Chưa có baseline screenshot** cho bất kỳ UI mới nào (TB-27) | Entry criterion E2; risk/limitation ghi ở mục 11 |
| Project | Q-3 (A-9) là **đợt thứ 2 liên tiếp** dev không trả lời (kế thừa Q-10 của 1.2.18) — rủi ro tích luỹ về độ tin cậy của giả định | Ghi rõ ở báo cáo cuối; đề nghị escalate nếu còn một đợt nữa không có trả lời |
| Project | Nhánh descope của Q-9 (`TC117-G4`) **không có bằng chứng kiểm thử** dù là đường dẫn tới mất dữ liệu người dùng | Ghi vào mục 10 và mục 11; đề nghị PO xác nhận chấp nhận rủi ro bằng văn bản |
| Product | Haptic, cử chỉ, giật hình chỉ kiểm được trên **máy thật**, đánh giá định tính | Máy thật bắt buộc cho DRG/ROD/SNP/DEC; ghi model máy khi report |
| Product | Nội dung Decorate (nhóm DEC) test dựa trên spec **khác flow** (1.2.15) — rủi ro oracle không khớp hoàn toàn với kiến trúc mới | Ưu tiên chạy 4 case regression-đã-từng-vỡ trước; escalate ngay nếu sai lệch lớn hơn 3 điểm đã biết bị ghi đè |

---

## 7. Test environment matrix

| Hạng mục | Yêu cầu |
|---|---|
| **Build** | **CHƯA XÁC ĐỊNH** — TF-117 không có mã build/branch/PR/commit (TB-08). Trước khi test phải xác định đúng build chứa TF-117; build khác ⇒ dừng, báo lại (TC117-01, entry E1) |
| **Thiết bị bắt buộc** | iPhone **iOS 18.x** (nền chính) + iPhone **iOS 26.x** (chrome glass) — cả hai, máy thật. Ghi **model máy** khi báo giật/lag (TC117-39) |
| **iPad** (dọc + ngang) | "Nếu có" (TB-10) — không có ⇒ TC117-73, 136, 169 = *Not run* |
| **Không dùng** | iPhone iOS 27 (out of scope); simulator cho DRG/ROD/SNP/DEC (cần haptic + cảm nhận cử chỉ) |
| **Ngôn ngữ máy** | Tiếng Việt và English bắt buộc; 18 ngôn ngữ khai báo nhưng không có danh sách (out of scope #5) |
| **Điều kiện haptic** | Máy thật có Taptic Engine, haptic hệ thống bật (tester xác nhận trước khi kết luận ROD/SNP) |

**Dữ liệu/test-data chuẩn bị trước:**

| # | Dữ liệu | Dùng cho |
|---|---|---|
| 1 | ≥1 template lịch **dạng stack** | Mọi nhóm (bắt buộc) |
| 2 | ≥1 template **không phải stack** | ENV (03), COACH (12), LYR (119) |
| 3 | Bố cục **`Column > Row > Column`** | DRG, CTN (59), RSZ |
| 4 | Row **2 con** và Row **3+ con** | RSZ (45, 46) |
| 5 | Container **có thẻ nền (card)** chứa Row/Column con | DRG (thẻ nền), CHR (117 kế thừa) |
| 6 | Template có **band Fixed** + ≥2 band Auto | ROD (37), LYR (109) |
| 7 | Band đầu **gap âm** (kéo lên qua vạch trên grid); 2 band **cao–thấp khác nhau** | ROD (35, 36), SNP (144, 150) |
| 8 | Template có sẵn **Quote** (kiểm danh sách câu) và **kiểu âm lịch tự sinh chữ** (không có danh sách) | KNB (94) |
| 9 | Template có **bold + italic sẵn** (month *elegant script*, priority matrix) | TXT (78) |
| 10 | Template có cỡ chữ **vượt thanh Size** (tiêu đề tháng script 130) | TXT (75) |
| 11 | Wallpaper có **sticker / nét vẽ trang trí** từ bản cũ (migration) | REG (143), DRG (28) |
| 12 | Dữ liệu event/task thật (component dạng lịch/danh sách) | KNB, REG |
| 13 | Template lịch **cũ** chưa động vào; wallpaper **Note** | REG (141, 142) |
| 14 | Live Activity + widget đã bật; lock screen đặt được | REG (137–139) |
| 15 | Máy **không có** sự kiện nào (để test Sample events) | CHR (133) |
| 16 | Ảnh Pro (để test hỏi Pro khi chọn ảnh nền) | LYR (120) |
| 17 | **Baseline screenshot trên build thật của TF-117** — sheet Add 16 mục, chip Customize, công tắc Layout\|Decorate, rail mới, coach tour 2 bước, Layers 2 nhóm + Background, Style → Text size | Oracle trực quan; **entry criterion E2**, hiện **chưa có ảnh nào** (TB-27) |
| 18 | ≥50 nét vẽ liên tục (test trần lịch sử Decorate) | DEC (155) |
| 19 | Ảnh nền để test ống hút màu sau khi đổi Background | CHR (126) |

---

## 8. Entry criteria

> Theo §5.1.3. Cột "Hiện trạng" phản ánh thực tế tại 2026-09-29 — **phần lớn CHƯA đủ điều kiện chạy thật**,
> đúng như banner đầu file đã nêu.

| # | Tiêu chí | Hiện trạng |
|---|---|---|
| E1 | **Build/branch/PR chứa TF-117 đã được xác định** và cài được trên mọi máy test (TC117-01) — sai build ⇒ dừng, báo lại | ⬜ **chưa có** — TF-117 không có mã định danh nào (TB-08) |
| E2 | **Baseline screenshot trên build thật của TF-117** đã chụp (mục 7 #17) — bộ ảnh 1.2.17/1.2.18/1.2.15 **không** được dùng làm oracle | ⬜ **chưa có bất kỳ ảnh nào** (TB-27) |
| E3 | Test plan này = READY (có điều kiện) và **`test-cases-tf-117.md` đã tạo + được duyệt** *(orchestrator quyết định gọi `test-case`)* | ⬜ chưa có test-case |
| E4 | Test data mục 7 (đặc biệt #3, #6, #7, #17) sẵn sàng | ⬜ chưa xác nhận |
| E5 | Thiết bị: ≥1 iPhone iOS 18.x **và** ≥1 iPhone iOS 26.x, máy thật | ⬜ chưa xác nhận |
| E6 | Nhãn ⚠️ và nhãn (QC) đã được **giữ nguyên** trong test-case (kiểm chéo mục 12) | ⬜ chờ test-case |
| E7 | **Smoke test pass:** chip **Customize** hiện đúng vị trí (TC117-02) + mở được màn Customize, chọn được 1 thành phần (TC117-13). Fail ⇒ dừng, không chạy tiếp | ⬜ chưa chạy |
| E8 | `bugs/bug-log.md` rà soát — chưa có bug liên quan `screen: customize` (feature mới) | ✅ đã rà, không có |
| E9 | **Q-7b chưa cần trả lời để bắt đầu** (chỉ chặn riêng TC117-165) — nhưng **phải có trả lời trước khi test-case chạm tới nhóm DEC phần Cutout** | ⬜ mở, không chặn E1–E8 |

## 8.1 Suspension & Resumption criteria

- **Dừng toàn bộ:** (a) mất dữ liệu **không phục hồi được** ở nhóm REG/MOD/LYR (lock screen thật/Live
  Activity/widget hỏng vĩnh viễn, dữ liệu wallpaper gốc bị ghi đè); (b) phát hiện đang chạy **sai build**
  (chưa xác định lại đúng build sau E1); (c) phát hiện band **vẫn** tương tác được ở Decorate (đảo A-15) —
  dừng nhóm DEC/MOD để báo bug trước, vì đây thay đổi cả kiến trúc gesture arbitration.
- **Dừng cục bộ nhóm DRG/ROD/SNP/DEC** nếu **>50% case P1** trong nhóm fail liên tiếp — các nhóm
  ADD/CTN/REG phụ thuộc chúng để dựng layout test.
- **Dừng cục bộ các condition ⚠️** khi dev trả lời khác giả định (A-7…A-13, A-15) ⇒ chỉ viết lại **đúng các
  dòng ⚠️ đó** (mục 6.4), phần còn lại tiếp tục.
- **Dừng riêng nhóm DEC phần Cutout** cho tới khi Q-7b có trả lời — không tự đoán đường vào để "test cho có".
- **Resume:** chạy lại **từ đầu cụm đã suspend** sau khi có bản fix/xác nhận mới, không tiếp tục giữa chừng
  (state canvas và lịch sử Undo chung 2 chế độ bị ảnh hưởng bởi case trước).

**Thứ tự thực thi gợi ý (§5.1.5):** ① E1–E2 xác nhận build + baseline → ② Smoke E7 → ③ ENV/COACH/SEL (nền
tảng) → ④ DRG, ROD, RSZ (P1 trước, cơ chế mới nhất) → ⑤ ADD/CTN/INS/TXT/KNB → ⑥ SAV/MOD (lõi Undo chung) →
⑦ LYR → ⑧ CHR/STY → ⑨ SNP (regression cụm cũ 1.2.18) → ⑩ DEC (trừ Cutout, ưu tiên 4 case đã từng vỡ ở
1.2.15) → ⑪ **REG** (sau cùng) → ⑫ lặp toàn bộ trên iOS còn lại.

---

## 9. Exit criteria

**Đo lường:**
- Toàn bộ **106 test condition P1** đã chạy; **0 bug Critical/High còn mở** trong nhóm P1 (theo mapping mục
  6.2).
- **P2 ≥ 90%** đã chạy (≥ 50/55); **P3** chạy đủ hoặc ghi lý do.
- **REG: 7/7 đã chạy và 0 fail.**
- **SNP: 7/7 đã chạy** (nếu dev xác nhận cụm đã bị bỏ ⇒ loại khỏi exit, ghi rõ lý do thay vì tính "chưa
  chạy").
- **DEC: 20/21 đã chạy** (trừ TC117-165, chờ Q-7b) — nếu Q-7b có trả lời trước khi kết thúc đợt thì tính đủ
  21/21.
- Đã chạy trên **cả** iOS 18.x **và** iOS 26.x; VI **và** EN.

**Nhị phân:**
- **Regression đã chạy** (mục 4) — không rút gọn nhóm REG/SNP/DEC.
- **65 condition ⚠️ đã chạy** nhưng **kết quả phải ghi rõ "theo giả định QC / chưa dev xác nhận"**. Exit
  **không** được tuyên bố các condition này đã **xác nhận** trừ khi dev đã trả lời (khi đó đổi nhãn
  ASSUMPTION → FACT ở `answers-tf-117.md` trước).
- **`TC117-G4`** không tính vào exit (ngoài phạm vi); **`TC117-165`** không tính vào exit trừ khi Q-7b có
  trả lời trong đợt này.
- **iPad:** có máy ⇒ phải chạy; **không có** ⇒ ghi *"Not run — không có thiết bị"*, không tính fail.
- Mọi "Query → dev" từ nhãn ⚠️ có phản hồi hoặc được PO chấp nhận là known gap bằng văn bản.
- **Baseline screenshot (E2) đã chụp trên build thật** — nếu chưa chụp được trong đợt này, exit **phải** ghi
  rõ đây là limitation đã biết, không được im lặng bỏ qua.

> ### 📦 WRAP-UP — tính năng đã RELEASE trước khi đạt đủ exit criteria ở trên (2026-10-02)
>
> **Quyết định của QC, không phải agent.** Tính năng đã release. Entry criteria **E1** (build/branch/PR)
> và phần lớn checklist exit criteria ở trên **chưa từng được đo theo đúng quy trình** — `test-cases-
> tf-117.md` **không tồn tại** (chưa hoàn tất thiết kế, dừng giữa chừng 2026-09-29) nên **106 P1 / 55 P2 /
> 10 P3 chưa có bằng chứng "đã chạy" theo case cụ thể nào**. Thay vào đó, **QC tự báo cáo đã manual
> verification trên build thật, kết quả: đạt, không phát hiện bug.**
>
> **Không suy ra từ đó:** rằng 171 test condition đã PASS theo đúng nghĩa ISTQB, rằng 65 nhãn ⚠️ đã được
> dev xác nhận (vẫn là assumption), hay rằng `TC117-G4`/`TC117-165`/`TC117-G6`/Q-7b đã được giải quyết —
> tất cả **vẫn giữ nguyên trạng thái** như mục 2/3/10 đã ghi. Việc release chỉ phản ánh quyết định sản
> phẩm/engineering, không phải kết luận QA.
>
> **Dùng cho đợt sau:** nếu có bug report thật từ user hoặc cần quay lại test (hotfix, feature kế tiếp
> đụng tới màn Customize), coi 171 condition trong mục 2 + bảng risk ở mục 6 là **nền đã có sẵn** để viết
> `test-cases-tf-117.md` thật, không cần phân tích/lập kế hoạch lại. Xem ghi chú tương ứng ở
> [test-analysis-tf-117.md](test-analysis-tf-117.md) (banner WRAP-UP).

---

## 10. Gap cần làm rõ trước khi execute

> Mục 10 = câu hỏi mà câu trả lời sẽ **đổi expected result hoặc scope**. Cột "Ảnh hưởng scope/priority?"
> quyết định READY theo bảng trạng thái — **không dòng nào đang mở làm mất trạng thái READY** (Q-8/Q-9 đã
> được người review xử lý; Q-7b chỉ loại 1 condition theo đúng tiền lệ đã có ở bộ 1.2.18).

### 10A. Hai câu CHẶN cũ — đã được người review xử lý (không được coi là "đã trả lời bởi dev")

| # | Câu hỏi | Trạng thái | Ảnh hưởng scope/priority? |
|---|---|---|---|
| **Q-8** | Band lịch có tương tác được ở Decorate không? | **A** (QC, A-15) — cụm `TC117-G6` đóng, TC117-168 có oracle | Đã xử lý — không mở lại tập condition thứ hai trừ khi dev nói khác |
| **Q-9** | Điều kiện hỏi *Discard changes?* khi chỉ đổi nền/Darken | **Descope hẹp** (QC, A-16) — `TC117-G4` giữ GAP, phần còn lại của §8.04 vẫn trong phạm vi | Đã xử lý — chỉ 1 nhánh hẹp ngoài phạm vi |

### 10B. Câu hỏi còn MỞ — không chặn, nhưng bắt buộc ghi làm giới hạn coverage

| # | Câu hỏi | Condition | Ghi chú |
|---|---|---|---|
| **Q-7b** | Cutout vào bằng đường nào? (rail mới không có nút Cutout riêng) | TC117-165 | **Phải** có trả lời trước khi test-case chạm tới condition này; chỉ chặn 1/171 condition |
| O-31 | Điều kiện mở lại nhánh descope của Q-9 | `TC117-G4` | Là đường dẫn tới mất dữ liệu người dùng — nên hỏi sớm dù không chặn |
| O-32 | §8.1.05 (ẩn công tắc khi "đang kéo") có áp cho kéo sticker ở Decorate không | TC117-106, 157, 158, 159 | Kiểm theo đúng câu chữ (mọi cú kéo → ẩn), không chắc ý định |
| O-1 | Build/branch/PR/commit chứa TF-117 | TC117-01, toàn bộ | **Là entry criterion E1** |
| O-2 | Danh sách 18 ngôn ngữ cụ thể | TC117-07, 171 | Chỉ kiểm được VI/EN |
| O-3 | iOS 27 có trong phạm vi? | TC117-04, 05 | Giữ nguyên trạng loại trừ của 1.2.18 |
| O-4 | Có máy iPad cho đợt này? | TC117-73, 136, 169 | Ảnh hưởng exit criteria nhóm iPad |
| O-5 | Cờ debug coach tour chạy được trên TestFlight không; cách reset | TC117-09→12 | Ảnh hưởng khả năng lặp lại test |
| O-6 | Ngưỡng "kéo nhẹ" trước 0,4s | TC117-34 | Không có giá trị pt/thời gian |
| O-7…O-30 | (giữ nguyên như test-analysis mục 4B — giá trị biên, tiêu chí đo, danh mục component, ảnh baseline, cách đếm cấp, quy tắc bù trừ Row 3+ con, ngưỡng tương phản, trần Undo, known-issue emoji iOS 26…) | nhiều | Xem test-analysis mục 4B để tra đầy đủ; **không lặp lại toàn bộ ở đây** để tránh lệch nguồn khi test-analysis cập nhật |

---

## 11. Coverage gap — case chưa được test basis liệt kê

> Suy luận của **QC** (tách khỏi sự thật do test basis xác nhận). **Không có expected result** — chỉ dùng
> để ghi nhận quan sát hoặc bổ sung khi có oracle.

| # | Thiếu gì | Vì sao là gap | Ảnh hưởng đáng kể? |
|---|---|---|---|
| 1 | **Không có bất kỳ screenshot/wireframe baseline nào** cho toàn bộ UI mới của Customize | TB-27 — bộ ảnh hiện có toàn bộ là lứa cũ, dùng làm oracle sẽ báo sai | **Cao** — là entry criterion E2, chặn khả năng đối chiếu oracle trực quan cho các nhóm COACH, MOD, LYR, STY |
| 2 | **Không có mã build/branch/PR** | TB-08 — không biết bug tìm được thuộc build nào | **Cao** — entry criterion E1 |
| 3 | **Checklist chi tiết Text sticker** của Decorate (font, cỡ, màu, nhiều dòng) | O-27 — cả TF-117 lẫn 1.2.15 đều không có | Trung bình — TC117-161 chỉ phủ mức "gõ được, áp được, hiện trong Layers" |
| 4 | **2 case migration còn thiếu** (TB-26, O-20): wallpaper tạo bằng Component Editor 1.2.18 (layout-only, chưa có decoration) mở ở Customize; template **không phải stack có decoration** mở ở Customize | §11 chỉ có case "đã có decoration từ trước" | Trung bình — đề xuất bổ sung khi có oracle rõ (ai xác nhận default z-order cho 2 trường hợp này) |
| 5 | **Tổ hợp** reorder ↔ gap âm ↔ snap ↔ Undo liên tiếp; snap khi band là con trong Row/Column | Mỗi hành vi mô tả riêng ở test basis + spec đối chiếu, chưa có tổ hợp | Trung bình — ứng viên cho phiên exploratory (mục 5, nguyên tắc như 1.2.18) |
| 6 | **iPad toàn bộ luồng** (dọc + ngang), máy không có home indicator | "Nếu có" (TB-10); chưa xác nhận có thiết bị | Trung bình — phụ thuộc thiết bị (O-4) |
| 7 | **Danh mục component chính thức** (tên UI ↔ tên code ↔ knob riêng) | Tồn từ bộ 1.2.18 (TB-22/O-23), vẫn chưa được bàn giao | Trung bình — KNB chỉ kiểm loại có tên nêu trong spec |
| 8 | **`screen-name` mới trong flow `14_edit-wallpaper`** chưa được thêm vào `screenshot-naming.md` §7.1 (chip customize, layout-switch, decorate-switch, rail mới…) | Hệ quả trực tiếp của gap #1 — khi chụp ảnh baseline sẽ cần đặt tên đúng convention | Thấp — chỉ là việc làm theo sau khi có build |
| 9 | **Regression "sống sót qua đêm" (Shortcut automation)** không được TF-117 nhắc lại như 1.2.18 từng có | §11 của TF-117 không có case tương đương TC18-116 | Trung bình — đã ghi ở mục 3.1 (flow `03_shortcut-setup`), không tự thêm case vì test basis không đặt điều kiện |
| 10 | **Nhánh descope của Q-9 hoàn toàn không có bằng chứng kiểm thử** trong đợt này | A-16 — quyết định phạm vi, không phải đã kiểm và pass | **Cao (rủi ro dữ liệu người dùng)** — đề nghị PO xác nhận chấp nhận rủi ro bằng văn bản trước khi release nếu Q-9 chưa được dev trả lời tới lúc đó |

---

## 12. Bảng tự kiểm — 8 ràng buộc bắt buộc của việc duyệt READY (6 điều kiện của test-analysis + 2 bổ sung)

| # | Điều kiện | Được đáp ứng ở | Kết quả |
|---|---|---|---|
| 1 | Q-1…Q-6, Q-8 giữ **ASSUMPTION**, chưa nâng thành fact | Banner đầu file · mục 1.2 · mục 5 (từng nhóm) · mục 6.4 | ✅ |
| 2 | Mang nguyên **65 nhãn ⚠️** kèm điều kiện thay đổi | Mục 2 (cột Gap-dependent) · mục 5 (từng dòng) · mục 6.4 | ✅ |
| 3 | Nhóm **SNP** và **DEC** ghi rõ **không có requirement trong test basis TF-117** | Banner · mục 1.1 · mục 2 (ghi chú cuối bảng) · mục 5.18/5.19 · Phụ lục A | ✅ |
| 4 | `TC117-G4` chỉ descope **nhánh hẹp**, phần còn lại của TC117-100/120/121/170 và §8.04 **vẫn trong phạm vi** | Mục 2 (nhãn) · mục 3 (#1) · mục 5.12, 5.14 | ✅ |
| 5 | `TC117-G6` ngoài phạm vi, band tương tác được ở Decorate ⇒ **report bug** | Mục 3 (#3) · mục 5.19 (Decision Table G3) · mục 6.5 | ✅ |
| 6 | `TC117-165` **không viết/chạy** trước Q-7b | Banner · mục 2 (ghi chú `*`) · mục 3 (#2) · mục 5.19 · mục 8 (E9) · mục 10B | ✅ |
| 7 | `TC117-01` là **entry criterion**, chưa có build cụ thể | Banner · mục 5.1 · mục 7 (Build) · mục 8 (E1) | ✅ |
| 8 | **Không dùng ảnh 1.2.17/1.2.18/1.2.15 làm oracle hình ảnh** cho Customize | Banner · mục 1.3 · mục 7 (#17) · mục 8 (E2) · mục 11 (#1) | ✅ |

**Tự kiểm số liệu:** tổng **171** condition = ENV 8 + COACH 4 + SEL 7 + DRG 14 + ROD 6 + RSZ 8 + ADD 6 + CTN 8
+ INS 12 + TXT 12 + KNB 11 + SAV 5 + MOD 6 + LYR 14 + CHR 12 + STY 3 + REG 7 + SNP 7 + DEC 21 = **171** ✓ ·
P1 106 · P2 55 · P3 10 ✓ (đối chiếu độc lập với tổng test-analysis, khớp) · 1 `GAP` còn mở (`TC117-G4`,
descope hẹp) · 1 `GAP` đã đóng (`TC117-G6`) · 1 condition tạm hoãn (`TC117-165`, chờ Q-7b, vẫn tính risk P1
nhưng không tính vào exit đợt này).

---

## Phụ lục A — Traceability: Nguồn → Test condition → Nhóm test case dự kiến

> Chuỗi: Nguồn (test basis §N.MM, hoặc "spec đối chiếu + quyết định QC" cho SNP/DEC) → Test condition
> (TC117-xx, test-analysis mục 2) → Nhóm test case (mã nhóm → `TC-<MÃ>-NN` do skill `test-case` cấp).

| Nguồn | Test condition | Nhóm | | Nguồn | Test condition | Nhóm |
|---|---|---|---|---|---|---|
| §1, §2 (văn xuôi), TB-08 | 01–08 | ENV | | §8.01–§8.05 | 97–101 | SAV |
| §2.01–§2.04 | 09–12 | COACH | | §8.1.01–§8.1.06 | 102–107 | MOD |
| §3.01–§3.07, §10 #4 | 13–19 | SEL | | §8.2.01–§8.2.14 | 108–121 | LYR |
| §4.01–§4.03, §4.08–§4.14 | 20–32, 39 | DRG | | §9.01–§9.04, §9.09–§9.14 | 122–126, 130–136 | CHR |
| §4.04–§4.07 | 33–38 | ROD | | §9.05–§9.06 | 127–129 | STY |
| §5.01–§5.08 | 40–47 | RSZ | | §11 #1–#7 | 137–143 | REG |
| §6, §6.01–§6.05 | 48–53 | ADD | | **1.2.18 §4.05–§4.07, §3.09 (đối chiếu) + Q-2 = A** | **144–150** | **SNP** *(không map về TF-117)* |
| §6.1.01–§6.3.02, §10 #1 | 54–61 | CTN | | **1.2.15 §2.1–§2.5, R1–R8 (đối chiếu) + Q-7 = B** | **151–171** | **DEC** *(không map về TF-117; 165 chờ Q-7b)* |
| §7.01–§7.12, §7.21–§7.22 | 62–73 | INS | | §8.04 ↔ §8.2.13 ↔ Q-6=C | `TC117-G4` | **không map** — GAP, descope hẹp |
| §7.07, §7.13–§7.20, §7.37, §7.40 | 74–85 | TXT | | §8.1.04, §8.1.05, §8.2.09 | ~~`TC117-G6`~~ | **đã đóng** — Q-8 = A |
| §7.06, §7.23–§7.36, §7.38 | 86–96 | KNB | | §10 #1–#9 (hành vi cố ý) | — | dùng làm expected result / "không report", nhúng vào TC117-58, 26 |

**Ngược lại:** mỗi condition trong test-analysis mục 2 được ánh xạ **đúng 1 nhóm** ở mục 2 của file này;
test-case tương lai phải trace `TC-<MÃ>-NN` → `TC117-xx` → nguồn tương ứng (test basis §N.MM, hoặc "spec đối
chiếu + quyết định QC" cho nhóm SNP/DEC — **không** viết như thể đó là requirement của TF-117).

---

**Bước tiếp theo:** báo cáo cho orchestrator. **Chỉ khi** orchestrator (và QC) xác nhận Test Plan Status =
`READY` có điều kiện **và** entry criteria mục 8 đã đủ (đặc biệt E1 — build, E2 — baseline screenshot) →
gọi skill `test-case` trên file này, với ràng buộc giữ nguyên toàn bộ 65 nhãn ⚠️/(QC), không viết case cho
`TC117-165` trước Q-7b, không viết case cho nhánh hẹp của `TC117-G4`, và ghi rõ nhóm SNP/DEC không truy vết
về test basis TF-117.
