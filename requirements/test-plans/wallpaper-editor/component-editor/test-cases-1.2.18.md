# Test Case Specification — Wallpaper Component Editor (TestFlight 1.2.18 (111, rc3))

> Thiết kế case theo [test-plan-1.2.18.md](test-plan-1.2.18.md) (ISTQB Foundation) — bám đúng kỹ thuật đã chọn ở mục 5 test plan
> (State Transition cho SEL/PRP/PUX/UND, Decision Table cho ROD/SNP/RSZ/PUX/KNB-Bold×Italic/NST-ô trống, EP + BVA cho DRG/SNP/NST/KNB-Size,
> EP cho ENT/LOC/ADD/KNB, Compatibility matrix cho DEV, Checklist-based cho REG/INT/CHR/ADD, 1 charter Exploratory tuỳ chọn).
> Test basis: [QC — Component Editor 1.2.18.md](../../../specs/wallpaper-editor/component-editor/QC%20—%20Component%20Editor%201.2.18.md) (§N.M do QC gán; **chỉ §0–§13** là requirement).
> Test analysis: [test-analysis-1.2.18.md](test-analysis-1.2.18.md) (118 condition `TC18-xx`) · Câu trả lời/giả định: [answers-1.2.18.md](answers-1.2.18.md).
> Bộ 1.2.17 [test-cases-component-editor-SUPERSEDED.md](test-cases-component-editor-SUPERSEDED.md) **giữ nguyên, không sửa** — 4 mục cũ **không được chạy lại nguyên trạng** (TC-14, TC-29, TC-66, TC-67 — xem test-plan mục 1.1).

> **Trạng thái nguồn:** Test Plan = `READY` **CÓ ĐIỀU KIỆN** (QC duyệt 2026-09-28). File này **chỉ là thiết kế case** — **thực thi còn bị chặn bởi Entry criteria** (test-plan mục 8: build 111 chưa xác nhận trên máy, baseline screenshot Q-19 chưa chụp, test data mục 7 chưa xác nhận). Nhóm case nào viết ở dạng ⚠️ là **theo chỉ đạo đã duyệt của QC** (viết theo giả định, gắn nhãn, review lại khi dev trả lời) — không phải agent tự chọn mặc định.

## Quy ước

- **Ưu tiên:** P1 (chặn phát hành) · P2 · P3 — **kế thừa từ condition** (test-plan mục 6; **không có P0**). Case truy về **nhiều condition** khác priority → lấy mức **cao hơn**. Ngoại lệ (lệch có lý do): `TC-SEL-10` (P2) và `TC-SEL-11` (P3) là case **chỉ ghi nhận quan sát, không có oracle** nên hạ so với condition neo (TC18-09 / TC18-11 đều P1); `TC-EXP-01` (P3) — test plan **không gán priority** cho phiên exploratory tuỳ chọn, chọn mức thấp nhất, **không tính exit**.
- **Cột "Trace":** `TC18-xx` (test-analysis) · `§N.M` (test basis) · dòng ở mục 5 test plan (rule/transition/partition/charter). Mỗi case truy được về đúng chuỗi này; **ngoại lệ neo gần nhất** được liệt kê ở **Phụ lục C**.
- **⚠️ Phụ thuộc gap mở** (đặt ngay sau ID) — case bắt nguồn từ 1 trong **18 condition ⚠️** (TC18-19, 20, 23, 24, 25, 27, 51, 61, 68, 70, 80, 82, 106, 115, 116, 117, 118, 119). **Nhãn không được bỏ.** Expected result ghi **"theo giả định"**; chạy và ghi nhận thực tế, **không tự suy đoán câu trả lời của dev**. Bảng "điều kiện thay đổi → case nào viết lại" ở **Phụ lục A**.
  - **Quy tắc xử lý kết quả ⚠️ (test-plan 6.3):** lệch so với expected **giả định** ⇒ **không tự mở defect ngay** — ghi **"Query → dev"** kèm video/ảnh (§13), **trừ khi** vi phạm **bất biến có căn cứ trong spec** (đè band §3.08/§4.02, mất dữ liệu, mất thành phần). **Pass theo giả định ≠ đã xác nhận** — báo cáo phải nêu rõ.
  - **Q-7 · Q-10 · Q-12 là ASSUMPTION (QC chấp nhận, CHƯA dev xác nhận)** — không ghi như fact ở bất kỳ đâu. Mâu thuẫn §7.07 ↔ §7.08 vẫn nằm nguyên trong test basis.
- **Nhãn "(QC)"** trong expected result = lấy từ **câu trả lời của QC** ([answers-1.2.18.md](answers-1.2.18.md)), **chưa dev xác nhận**; dev trả lời khác ⇒ **dev thắng**, sửa đúng case đó.
- **🔭 Exploratory** — case chưa có đáp án đúng/sai định sẵn (test plan tự khai). Cột "Kết quả mong đợi" ghi **"Phải quan sát/ghi lại"**, không PASS/FAIL.
- **🆕** — case bổ sung bằng error guessing ngoài test plan: **không có** trong bản này (mọi case đều bám mục 5 test plan).
- **Không có ngưỡng — kiểm hành vi, không kiểm giá trị:** áp cho fps/độ trễ, bán kính hút snap, ngưỡng góc/thời gian gesture, đơn vị chip gap, bề rộng tối thiểu, biên dưới/đơn vị Size, giá trị lề (Q-3a, Q-7, Q-12, Q-14, Q-15, Q-16 đã cố ý bỏ).
- **Bảng thuộc tính — đóng bảng (dễ nhầm):** **grabber (vuốt xuống) ≠ ✕ / Deselect / chạm vùng trống.** Grabber **giữ selection** (viền còn, thành phần vẫn chọn); ✕ / Deselect / chạm vùng trống **cùng trạng thái cuối** (bảng đóng · viền mất · nút **+** hiện lại) **(QC · Q-17)**.
- **Oracle trực quan:** **không** dùng bộ ảnh/wireframe/exploratory S03 lứa 1.2.17 (báo sai: 6 nhóm Add, có Text…). Chỉ dùng ảnh **baseline chụp trên build 111** (Q-19) + ảnh sheet Add QC gửi 2026-09-28. Các dòng `CMP-*` cũ mâu thuẫn (vd `CMP-H28` "6 nhóm") bị bỏ qua.
- **Ảnh/video bằng chứng:** lưu vào `screenshots/1.2.18/<mã nhóm>/`, tên `TC-<MÃ>-NN_<mô tả>.png/.mov` — xem [screenshots/1.2.18/README.md](screenshots/1.2.18/README.md). Lỗi lúc kéo **bắt buộc quay video** (§13).
- **Môi trường mặc định (mọi case):** TestFlight **1.2.18 (111)** tag `v1.2.18-rc3` (xác nhận ở `TC-ENT-01`, là **entry criterion**) · **iPhone iOS 18.x và iOS 26.x, máy thật** (bắt buộc; **không** simulator cho DRG/SNP/PUX/haptic) · ngôn ngữ máy **Tiếng Việt và English** (bắt buộc) · iPad "nếu có" · **không** iOS 27 · ghi **model máy + phiên bản iOS** ở mỗi lần chạy. Case nói "chạy trên cả 2 iOS" thì lặp lại theo `TC-DEV-01/02`.
- **Test data (`[D#]` = số thứ tự ở bảng "Dữ liệu/test-data chuẩn bị trước" — test-plan mục 7):** `[D1]` template stack · `[D2]` template không phải stack · `[D3]` bố cục `Column > Row > Column` · `[D4]` Row 2 con + Row 3+ con · `[D5]` container có thẻ nền · `[D6]` template có band Fixed + ≥2 Auto (Fixed giữa 2 Auto; Fixed sau band Auto cuối) · `[D7]` band đầu gap âm + 2 band cao–thấp khác nhau · `[D8]` 4 template `mix-*` · `[D9]` template có sẵn Quote / Almanac day / Timeline · `[D10]` template bold+italic sẵn · `[D11]` wallpaper có sticker/nét vẽ Decorate · `[D12]` card frosted + sticker dưới · `[D13]` event/task thật · `[D14]` template lịch cũ + wallpaper Note · `[D15]` Shortcut automation qua đêm · `[D16]` Live Activity + widget bật.
- **Thứ tự thực thi gợi ý (test-plan 8.1):** ① Smoke E7 = `TC-ENT-02` + `TC-SEL-01` → ② **khởi động `TC-REG-08` (qua đêm) sớm nhất** → ③ ENT/DEV/SEL/LOC → ④ ROD, DRG, SNP, RSZ (P1 trước) → ⑤ ADD/NST/PRP/PUX/KNB/UND/CHR → ⑥ INT → ⑦ **REG** (sau cùng) → ⑧ lặp DEV trên iOS còn lại. Suspend/Resume theo test-plan 8.1.

---

## 1 · Entry & gating · `TC-ENT` (mục 2 #1 test plan — EP loại template + Checklist)

> `TC-ENT-01` là **entry criterion E1**, không phải case thường. `TC-ENT-02` + `TC-SEL-01` là **smoke E7** — fail ⇒ dừng, không chạy tiếp.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Trace |
|---|---|---|:---:|---|
| TC-ENT-01 | Trên **mỗi máy test**: mở TestFlight → trang app Ink → ghi **phiên bản + số build**; ghi model máy + iOS. *(Tag `v1.2.18-rc3` chỉ đối chiếu qua tài liệu — không kiểm được trên máy.)* | Hiển thị **1.2.18 (111)**. **Số build khác** (rc1/rc2 không lên TestFlight) → **DỪNG toàn bộ, báo lại** (test-plan 8.1b); mọi kết quả sau vô nghĩa | P1 | TC18-01 · header · §5.1 |
| TC-ENT-02 | *(EP partition "stack")* `[D1]`: Discover → chọn template lịch dạng stack → **Edit** → nhìn header cạnh nút crop. Lặp qua đường vào thứ hai: Calendar tab → nút cập nhật wallpaper → **Edit**. Bấm nút vừa thấy | Nút tròn **hình chồng lớp (Components)** **hiện** ở cả 2 đường vào. Bấm → mở màn **full-screen**: wallpaper chiếm hết màn, các nút nổi lên trên | P1 | TC18-02 · §2, §10 #5 · §5.1 EP "stack" |
| TC-ENT-03 | *(EP partition "không phải stack")* `[D2]`: mở template **không phải stack** → Edit → nhìn header | Nút Components **không hiện** — **đúng thiết kế, không phải lỗi** | P1 | TC18-02 · §2, §10 #5 · §5.1 EP "không phải stack" |
| TC-ENT-04 | `[D1]`: quan sát vị trí nút Components trên header | Nút nằm **cạnh nút crop** | P3 | TC18-03 · §2 · §5.1 Checklist |
| TC-ENT-05 | Vào màn Component Editor, quan sát toàn bộ chrome | **Header:** ✕ (Cancel) · Undo · Redo · ✓ (Done). **Đáy:** nút **+ (Add component)** và nút **Show grid**. Wallpaper chiếm hết màn | P2 | TC18-04 · §2 · §5.1 Checklist |
| TC-ENT-06 | Điều kiện: tài khoản/cài đặt **chưa từng** vào màn này *(nếu không còn "lần đầu" thì ghi **Not run**, không suy đoán cách reset)*. Vào màn lần đầu → bấm để bỏ qua | Bước hướng dẫn *"Tap to edit a piece"* **hiện**; **bấm để bỏ qua được** | P3 | TC18-05 · §2 · §5.1 Checklist |

---

## 2 · Thiết bị / OS · `TC-DEV` (mục 2 #2 test plan — Compatibility matrix)

> Không phải EP/BVA — mỗi dòng = chạy **toàn bộ nhóm ENT–INT** trên thiết bị đó (ghi nhận sai lệch vào case của nhóm tương ứng), không phải case riêng lẻ.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Trace |
|---|---|---|:---:|---|
| TC-DEV-01 | Chạy toàn bộ 17 nhóm trên **iPhone iOS 18.x** (nền chính, máy thật, ghi model) | Không có sai lệch so với kỳ vọng của từng nhóm | P2 | TC18-06 · §1 · §5.2 (hàng iOS 18.x) |
| TC-DEV-02 | Chạy toàn bộ 17 nhóm trên **iPhone iOS 26.x** (máy thật, ghi model); chú ý riêng chrome dạng **glass** (header ✕/Undo/Redo/✓, đáy +/Show grid, bảng thuộc tính) | Không sai lệch; chrome **glass render đúng**, không vỡ layout header/đáy | P1 | TC18-07 · §1 · §5.2 (hàng iOS 26.x) |
| TC-DEV-03 | *(Chỉ khi có iPad — Q-20 chưa trả lời)* Chọn 1 thành phần + có Row/Column có ô trống → xoay iPad **dọc ↔ ngang** | **Khung viền** và **các ô trống** vẫn khớp với thành phần, **không lệch** bound. **Không có máy ⇒ ghi "Not run — không có thiết bị"** (không tính fail — test-plan mục 9) | P2 | TC18-108 · §9.04, §1 · §5.2 (hàng iPad) |

---

## 3 · Bản địa hoá · `TC-LOC` (mục 2 #3 test plan — EP ngôn ngữ; partition "10 ngôn ngữ còn lại" ngoài phạm vi)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Trace |
|---|---|---|:---:|---|
| TC-LOC-01 | *(EP máy VI)* Đặt ngôn ngữ máy = **Tiếng Việt** → đi qua chuỗi **mới** của 1.2.18: toast *Added…* / *Removed…* / *Removed the empty layout*; tiêu đề mục *Weekday / Time / Date / Caption*; tên 5 nhóm + mô tả 1 dòng dưới từng mục sheet Add; header/đáy/bảng thuộc tính | **Không lọt chuỗi tiếng Anh** vào máy VI *(test basis không cho bản dịch chuẩn → chỉ kiểm "không còn tiếng Anh"; nghi tên riêng giữ nguyên ⇒ ghi nhận, không tự kết luận)* | P2 | TC18-08 · §1 · §5.3 EP "máy VI" |
| TC-LOC-02 | *(EP máy EN)* Đặt ngôn ngữ máy = **English** → lặp lại toàn bộ danh sách chuỗi trên | Mọi chuỗi hiển thị đúng tiếng Anh, không vỡ/cắt chữ | P2 | TC18-08 · §1 · §5.3 EP "máy EN" |

---

## 4 · Chọn thành phần · `TC-SEL` (mục 2 #4 test plan — State Transition + EP độ sâu lồng)

> States (test-plan 5.4): **S0** không chọn · **S1** chọn thành phần đơn · **S2** chọn container cấp N · **S3** chọn con cấp N+1 · **S4** bảng thuộc tính mở · **S5** đã chọn, bảng đóng bằng grabber.
> **Valid-transition coverage:** T1, T2, T3, T4 (từ S1/S2/S3 ở `SEL-05`, từ S4 ở `SEL-06`), T5, T6 phủ ở đây; **T7 (grabber) → `TC-PUX-07`, T8 (✕) → `TC-PUX-08`, T9 (Deselect) → `TC-PRP-08`**. T10 và transition thử thêm → 🔭.
> **Trình tự chạy gộp:** `[D3]` dựng 1 lần — `SEL-01` (chạm thành phần đơn) → `SEL-02` (chạm A trong Row) → `SEL-03` (chạm tiếp A) → `SEL-04` (đi sâu 3 cấp) → `SEL-05`/`06` (chạm vùng trống).

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Trace |
|---|---|---|:---:|---|
| TC-SEL-01 | **T1:** *[S0]* → chạm 1 thành phần **đơn** (top-level, không trong container) | *[→ S1]* Hiện **khung viền** quanh nó + **pill** có 2 mục **Edit component** / **Delete component** (kèm mũi tên ↑/↓ — xem `TC-ROD`) | P1 | TC18-09 · §3.01 · §5.4 T1 |
| TC-SEL-02 | **T2:** *[S0]* → `[D3]` chạm thành phần **A nằm trong Row** (lần 1) | *[→ S2]* Chọn **cả container (Row)**, **không** chọn thẳng A *(cố ý — §10 #4)* | P1 | TC18-11 · §3.03, §10 #4 · §5.4 T2 |
| TC-SEL-03 | **T3:** *[S2 — đang chọn Row]* → chạm tiếp **đúng A** | *[→ S3]* Chọn **A** (đi sâu 1 cấp); viền/pill chuyển sang A | P1 | TC18-11 · §3.03 · §5.4 T3 |
| TC-SEL-04 | **EP độ sâu 0/1/2/3** — `[D3]` `Column > Row > Column` + 1 thành phần lá X trong Column trong cùng: chạm lần lượt (i) thành phần đơn top-level; (ii)–(iv) X: mỗi lần chạm vào X, ghi thứ được chọn | Cấp 0: chạm **1 lần** chọn ngay thành phần đơn. Cấp 1–3: **lần chạm đầu chọn container ngoài cùng**, mỗi lần chạm tiếp **đi sâu đúng 1 cấp** (Column → Row → Column → X); không nhảy cấp *(không suy diễn cách đếm cấp — Q-3b)* | P1 | TC18-11 · §3.03, §10 #4 · §5.4 EP độ sâu |
| TC-SEL-05 | **T4 (từ S1/S2/S3):** lần lượt ở mỗi trạng thái: chọn thành phần đơn (S1) / container (S2) / con (S3) → chạm **vùng trống** | Mỗi lần → *[S0]* bỏ chọn, **viền và pill biến mất** | P2 | TC18-10 · §3.02 · §5.4 T4 |
| TC-SEL-06 | **T4 (từ S4):** chọn thành phần → **Edit component** (bảng mở, *S4*) → chạm **vùng trống** trên canvas *(nếu vùng trống không chạm được vì bảng che ⇒ ghi nhận, không suy đoán)* | *[→ S0]* **(QC · Q-17)** bảng **đóng** · khung viền **mất** · nút **+** **hiện lại** — **cùng trạng thái cuối** với ✕ (`TC-PUX-08`) và Deselect (`TC-PRP-08`) | P2 | TC18-10 (+ TC18-79/84 đối chiếu) · §3.02, §7.09 · §5.4 T4 |
| TC-SEL-07 | **T5:** chọn 1 thành phần **ở giữa stack** (ghi thứ tự + vị trí) → pill → **Delete component** → nhìn toast → bấm **Undo** | Thành phần bị xoá, *[→ S0]*; toast *"Removed …"* kèm **Undo**; **Undo trả lại đúng chỗ cũ** (đúng thứ tự + vị trí như trước khi xoá) | P1 | TC18-14 · §3.06 · §5.4 T5 |
| TC-SEL-08 | **T6:** chọn thành phần loại 1 → pill → **Edit component**; đóng; chọn thành phần **loại khác** → Edit | *[→ S4]* Bảng thuộc tính mở **đúng của thành phần đang chọn** (nội dung/knob khớp loại, khác nhau giữa 2 loại) | P2 | TC18-13 · §3.05 · §5.4 T6 |
| TC-SEL-09 | Thu nhỏ 1 thành phần (kéo góc hẹp lại) → chọn nó; lặp với thành phần trong Row | **Khung viền ôm đúng** nội dung thật, **không to hơn** phần nội dung | P2 | TC18-12 · §3.04 · §5.4 (Checklist SEL) |
| TC-SEL-10 🔭 | **T10 (suy luận QC, không có expected trong spec):** *[S1 — đang chọn X]* → chạm sang thành phần khác Y | **Phải quan sát/ghi lại:** có chọn Y và bỏ chọn X (không cộng dồn) hay khác. Không pass/fail. *(Lệch priority so với condition neo — xem Quy ước.)* | P2 | TC18-09 (neo gần nhất; T10 không có condition riêng) · — · §5.4 T10 |
| TC-SEL-11 🔭 | **Transition thử thêm (error guessing của test plan 1.2.17):** `[D3]` đang chọn Row → chạm **rất nhanh 2 lần liên tiếp** vào cùng 1 con | **Phải quan sát/ghi lại:** có nhảy cấp / double-select / lỗi trạng thái không. Không pass/fail (spec không có expected). *(Lệch priority — xem Quy ước.)* | P3 | TC18-11 (neo gần nhất) · §3.03 · §5.4 "Transition thử thêm" |

---

## 5 · Đổi thứ tự ↑/↓, Fixed, Duplicate · `TC-ROD` (mục 2 #5 test plan — Decision Table R1–R10 + State Transition Undo)

> **Decision Table copy đúng 10 rule (R1–R10) — mỗi rule 1 case** (R1 tách thêm 1 case Undo cho TC18-18). Điều kiện: C1 Auto/Fixed · C2 vị trí (chỉ tính band Auto) · C3 container dọc/Row · C4 có Fixed giữa 2 Auto.
> **Mọi expected R7–R9 là "theo giả định Q-10"** (giữ **gap của từng vị trí**; gap âm ở lại vị trí đầu). **Điều kiện thay đổi:** dev nói **"giữ đỉnh ô/slot"** ⇒ **viết lại expected `ROD-08/09/10`**, có thể **thêm condition** cho trường hợp band cao đổi xuống slot thấp.
> Precondition chung: `[D6]` (Fixed giữa 2 Auto + Fixed sau band Auto cuối) cho R3/R4/R5; `[D7]` cho R7–R9; `[D4]` Row ≥3 con cho R6.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Trace |
|---|---|---|:---:|---|
| TC-ROD-01 | **R1** *(Auto · giữa · dọc · không Fixed chen)*: chọn 1 band Auto **ở giữa** danh sách → quan sát pill → bấm **↓** → bấm **↑** | Pill hiện **cả ↑ và ↓**. ↓ → band **đổi chỗ với band kế bên phía dưới**; ↑ → đổi lại. *(Kiểm đè band ở R7–R9.)* | P1 | TC18-15 · §3.07 · §5.5 R1 |
| TC-ROD-02 | **R1 + Undo (State Transition phụ):** bấm ↓ **2 lần liên tiếp** → bấm **Undo 1 lần** | **Mỗi lần bấm mũi tên = đúng 1 bước Undo:** 1 Undo chỉ hoàn lại **lần bấm thứ 2** (không hoàn cả 2) | P2 | TC18-18 · §3.07 · §5.5 R1 |
| TC-ROD-03 | **R2** *(Auto · đầu · dọc)*: chọn **band Auto đầu tiên** | **↑ ẩn**, **↓ hiện** | P2 | TC18-16 · §3.07 · §5.5 R2 |
| TC-ROD-04 | **R3** `[D6]` *(Auto · cuối · dọc · Fixed nằm SAU nó)*: chọn **band Auto cuối cùng** (phía sau còn band Fixed) | **(QC · Q-9b)** **↓ ẩn** *(band Auto cuối vẫn là "cuối" — band Fixed không tính vào danh sách xác định đầu/cuối)*; ↑ hiện | P2 | TC18-16 · §3.07, §10 #13 · §5.5 R3 |
| TC-ROD-05 | **R4** `[D6]` *(Auto trên · Fixed giữa 2 Auto)*: ghi vị trí Fixed **F** trên màn → chọn band Auto **A1** phía trên F → bấm **↓** | **(QC · Q-9a)** A1 **nhảy qua F**, **đổi chỗ với band Auto kế tiếp A2**; **F đứng yên** (vị trí trên màn không đổi) | P1 | TC18-17 · §3.07, §10 #13 · §5.5 R4 |
| TC-ROD-06 | **R5** `[D6]` *(Fixed)*: chọn **band Fixed F** → quan sát pill; chọn band Auto kề F → xem mũi tên | Pill của F **không có ↑/↓**; F **không bị tính là "kế bên"** của band Auto kề nó (mũi tên band Auto không coi F là đích đổi chỗ trực tiếp) | P1 | TC18-17 · §3.07, §10 #13 · §5.5 R5 |
| TC-ROD-07 | **R6** `[D4]` *(Auto · **Row**)*: Row có ≥3 con Auto → chọn con **giữa**; chọn con **đầu**; chọn con **cuối** | Trong Row pill là **← / →** (thay cho ↑/↓). Con giữa: cả 2 hiện; bấm → đổi chỗ với con kế bên. Con đầu: **← ẩn**; con cuối: **→ ẩn** | P1 | TC18-15, TC18-16 · §3.07 · §5.5 R6 |
| TC-ROD-08 ⚠️ | **R7** `[D7]` *(Auto · đầu · **gap âm** · dọc)*: kéo band đầu lên qua vạch trên grid (Show grid bật) để có gap âm; chụp trước → bấm **↓** để đổi chỗ với band thứ 2 → chụp sau | **(Theo giả định Q-10 — chưa dev xác nhận)** **không band nào đè lên band khác** *(phần này có căn cứ spec §3.08)*; **tổng chiều cao stack không đổi**; **gap âm ở lại vị trí đầu** (đỉnh của band đứng đầu sau khi đổi giữ nguyên như trước) *(2 phần sau là giả định)* | P1 | TC18-19 ⚠️ · §3.08 · §5.5 R7 |
| TC-ROD-09 ⚠️ | **R8** `[D7]` *(Duplicate · band đầu · gap âm)*: band đầu đang gap âm → Edit component → **Duplicate** | **(Theo giả định Q-10)** bản sao nằm **dưới** bản gốc, **có khoảng cách**, **không đè** *(spec §3.09 nêu phần "dưới, không đè"; cách tính gap là giả định)* | P1 | TC18-20 ⚠️ · §3.09 · §5.5 R8 |
| TC-ROD-10 ⚠️ | **R9** `[D7]` *(Auto · giữa · 2 band **cao/thấp khác nhau**)*: chọn band **cao**, bấm **↓** đổi chỗ với band **thấp** kế bên (chụp trước/sau) | **(Theo giả định Q-10)** hai band **không đè nhau**; khoảng trống giữa các band như cũ *(đúng vùng dev chưa trả lời — lệch ⇒ "Query → dev", không mở bug trừ khi thấy đè band)* | P1 | TC18-19 ⚠️ · §3.08 · §5.5 R9 |
| TC-ROD-11 🔭 | **R10 (suy luận QC):** dựng stack chỉ còn **đúng 1 band Auto** (xoá các band khác) → chọn nó | **Phải quan sát/ghi lại:** ↑/↓ có ẩn cả hai không. Không pass/fail (suy luận từ "đầu/cuối ẩn", không phải spec) | P2 | TC18-16 (neo) · §3.07 · §5.5 R10 |

---

## 6 · Di chuyển — kéo · `TC-DRG` (mục 2 #6 test plan — EP + BVA 3-value + Checklist invariant + State Transition)

> Test basis: vùng **"sửa đi sửa lại nhiều nhất"** — bắt buộc **máy thật** + `[D3]` (Row lồng trong Column), **quay video** lỗi kéo.
> **EP (§5.6):** {thành phần đơn top-level · **container** Row/Column (con đi theo) · **con bên trong** container} × {có thẻ nền · không thẻ nền (mặc định)}. *Each choice:* case invariant chạy **lặp trên cả 3 partition đối tượng**; partition thẻ nền = `DRG-18` (có, kéo container) + `DRG-19` (có, kéo con) + các case còn lại (không thẻ nền).
> **BVA 3-value biên "mép ảnh"** (Show grid **bật** để thấy vạch): `DRG-03…06` (dưới a–d), `DRG-07…10` (trên band đầu a–d), `DRG-11` (band khác).
> ⚠️ **Điều kiện thay đổi (Q-8) cho `DRG-03…11`:** giả định còn lại **"cạnh screen ≡ mép ảnh"** chưa xác nhận. Nếu khi chạy thấy **có vùng giữa hai biên** (kéo được tới mép ảnh nhưng vẫn cảnh báo, hoặc ngược lại) ⇒ **không kết luận pass/fail**, ghi nhận + hỏi dev; dev xác nhận 2 biên khác nhau ⇒ **viết lại điều kiện bật cảnh báo** và **thêm condition cho vùng giữa hai biên**. Trong editor, "mép ảnh" quan sát được = **mép của wallpaper full-screen** (giả định).
> **Trình tự chạy gộp:** dựng `[D3]` + Show grid bật; với **mỗi cú kéo** ở `DRG-01/14` kiểm luôn `DRG-15`, `DRG-16`, `DRG-21` ngay lúc đó (không dồn cuối). Bảng case đầy đủ vẫn giữ để trích dẫn khi báo bug.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Trace |
|---|---|---|:---:|---|
| TC-DRG-01 | *(EP đối tượng)* Lần lượt chọn **(i)** thành phần đơn, **(ii)** container Row (chọn qua A), **(iii)** con A bên trong → mỗi lần **giữ và kéo** chậm rồi nhanh | Đi theo ngón tay **ngay lập tức**, không trễ cảm nhận được — **cả 3 partition** (ghi kết quả từng partition). *Không có ngưỡng — kiểm hành vi* | P1 | TC18-21 · §4.01 · §5.6 EP + invariant "đi theo ngón" |
| TC-DRG-02 | Kéo 1 band **lên** trong stack/column tới **sát band phía trên**, rồi tiếp tục cố kéo lên | **Không đè lên thành phần phía trên** (khung viền không chồng lên band trên) | P1 | TC18-22 · §4.02 · §5.6 BVA "Trên — band khác" |
| TC-DRG-03 ⚠️ | **BVA Dưới (a)** *(Show grid bật)*: kéo band xuống tới **vạch dưới của grid** | Đáy band **khớp vạch dưới grid** (snap — chi tiết hút/rung ở `TC-SNP-07`); cho phép; **không** cảnh báo *"Part of this runs off the screen"* | P1 | TC18-23 ⚠️ (+TC18-28) · §4.03, §4.06 · §5.6 BVA Dưới (a) |
| TC-DRG-04 ⚠️ | **BVA Dưới (b):** kéo xuống **quá vạch dưới grid** nhưng vẫn **trong ảnh** | **(QC · Q-8)** **cho phép**, **không** bật cảnh báo. *(Giả định còn lại: cạnh screen ≡ mép ảnh)* | P1 | TC18-23 ⚠️ · §4.03, §9.02 · §5.6 BVA Dưới (b) |
| TC-DRG-05 ⚠️ | **BVA Dưới (c):** kéo tới **đúng mép dưới ảnh** (vị trí xa nhất kéo được, giữ tay) | **(QC · Q-8)** cho phép, **không** cảnh báo; band **không tràn ra ngoài ảnh** | P1 | TC18-23 ⚠️ · §4.03 · §5.6 BVA Dưới (c) |
| TC-DRG-06 ⚠️ | **BVA Dưới (d):** từ (c) **cố kéo vượt** mép dưới ảnh (tay đi thêm xuống dưới) → nhả tay | **Bị chặn** — band **không tràn ra ngoài ảnh** (vị trí giữ nguyên ở mép). Nếu thấy cảnh báo/kéo được quá mép ⇒ ghi nhận + "Query → dev" (Q-8) | P1 | TC18-23 ⚠️ · §4.03 · §5.6 BVA Dưới (d) |
| TC-DRG-07 ⚠️ | **BVA Trên — band đầu (a):** chọn **band đầu tiên**, kéo lên nhưng **chưa tới** vạch trên grid | Cho phép, **không** cảnh báo | P1 | TC18-24 ⚠️ · §4.04 · §5.6 BVA Trên (a) |
| TC-DRG-08 ⚠️ | **BVA Trên — band đầu (b):** kéo band đầu **qua vạch trên grid** (lấn vào vùng đồng hồ) nhưng vẫn trong ảnh | **(QC · Q-8)** **cho phép** (giống Studio), **không** cảnh báo | P1 | TC18-24 ⚠️ · §4.04, §10 #10 · §5.6 BVA Trên (b) |
| TC-DRG-09 ⚠️ | **BVA Trên — band đầu (c):** kéo band đầu tới **đúng mép trên ảnh** | **(QC · Q-8)** cho phép, không cảnh báo; không tràn ra ngoài ảnh | P1 | TC18-24 ⚠️ · §4.04 · §5.6 BVA Trên (c) |
| TC-DRG-10 ⚠️ | **BVA Trên — band đầu (d):** từ (c) **cố kéo vượt** mép trên ảnh → nhả tay | **Bị chặn**, không tràn ra ngoài ảnh. Lệch ⇒ ghi nhận + "Query → dev" (Q-8) | P1 | TC18-24 ⚠️ · §4.04 · §5.6 BVA Trên (d) |
| TC-DRG-11 ⚠️ | **BVA Trên — band khác:** chọn **band thứ 2** (không phải band đầu) → kéo lên tới khi chạm band phía trên | **Dừng khi chạm band phía trên**, **không đè**; **không** qua được vạch trên grid như band đầu (điểm biên phân biệt band đầu / band khác) | P1 | TC18-22, TC18-24 ⚠️ · §4.02, §4.04 · §5.6 BVA "Trên — band khác" |
| TC-DRG-12 | **State Transition (§5.7):** kéo 1 band tới **1 điểm snap** (vd giữa màn) cho hút vào → **nhả** → **chờ vài giây** → chạm giữ và kéo tiếp *(chờ để không lẫn với độ trễ 0.1 s — `TC-INT-02`)* | Band đang **nằm sẵn** trên điểm snap: chạm kéo **không bị giữ lại** — đi theo ngón; **phải ra khỏi điểm rồi mới hút lại** | P2 | TC18-30 · §4.07 · §5.7 State Transition (nằm sẵn) |
| TC-DRG-13 | Kéo 1 band **ngang** trái/phải | Dịch trái/phải theo ngón, dừng ở giới hạn phạm vi cho phép *(test basis không nêu số — ghi nhận điểm dừng, không kiểm giá trị)* | P2 | TC18-31 · §4.08 · §5.6 invariant "kéo ngang" |
| TC-DRG-14 | *(EP container, không thẻ nền)* `[D3]` chọn **cả Row** (chạm A lần 1) → giữ kéo | **Toàn bộ con** (A, B…) đi theo **đúng 1 lần**, **không nhanh hơn khung viền**, **không văng ra ngoài** | P1 | TC18-32 · §4.09 · §5.6 EP container |
| TC-DRG-15 | Ở mỗi cú kéo của `DRG-01` (3 partition): quan sát **suốt lúc kéo** và **lúc nhả** (quay video) | **Không** xuất hiện **bản sao** (component hiện 2 lần đè nhau); **không mất** thành phần rồi hiện lại khi nhả | P1 | TC18-33 · §4.10 · §5.6 invariant |
| TC-DRG-16 | Sau mỗi cú kéo (3 partition) **nhả tay** (quay video, xem từng frame) | Ảnh render lại **đúng 1 lần**, **đúng chỗ vừa thả**, **không nhảy về chỗ cũ rồi nhảy lại** | P1 | TC18-34 · §4.11 · §5.6 invariant |
| TC-DRG-17 | Trong stack: kéo 1 band (giữ tay, chưa nhả) → nhìn **các band phía dưới** | Band dưới **dồn theo thật** (vẽ lại thật, không phải kéo ảnh tĩnh). *(Đảo ngược so với "cố ý" 1.2.17 — không dùng TC-67 cũ)* | P2 | TC18-35 · §4.12 · §5.6 invariant |
| TC-DRG-18 | **36a** `[D5]` container Row/Column **có thẻ nền**: chọn **cả container** → giữ kéo | **(QC · Q-1, cách hiểu A)** **thẻ nền (card) đi cùng** với con của nó — **không bị bỏ lại**, **không nhấp nháy** | P1 | TC18-36a · §4.12 · §5.6 State Transition thẻ nền (36a) |
| TC-DRG-19 | **36b** `[D5]` chọn **1 con bên trong** container có thẻ nền → giữ kéo → nhả | **(QC · Q-1, cách hiểu A)** thẻ nền **tạm ẩn trong lúc kéo, hiện lại khi nhả** — **đúng thiết kế, KHÔNG report**. *(Nếu thẻ ẩn khi kéo **cả container** thì đó là `DRG-18` fail, không phải case này)* | P2 | TC18-36b · §10 #8 · §5.6 State Transition thẻ nền (36b) |
| TC-DRG-20 | `[D11]` wallpaper có **sticker / nét vẽ trang trí** → kéo 1 band (quay video) | **Sticker/nét vẽ không biến mất** trong lúc kéo (lỗi cũ) và vẫn còn sau khi nhả | P1 | TC18-37 · §4.13 · §5.6 invariant |
| TC-DRG-21 | Kéo **nhanh** (3 partition), quan sát khung viền chọn | Khung viền **luôn ôm đúng** thành phần đang được vẽ, kể cả khi kéo nhanh | P2 | TC18-38 · §4.14 · §5.6 invariant |
| TC-DRG-22 | Kéo liên tục **5–10 giây**, lên xuống nhiều lần (máy thật) | **Không giật cục rõ mắt, không đứng hình**. **Không có ngưỡng fps** (Q-15 đã bỏ) — thấy giật ⇒ report kèm **model máy** | P2 | TC18-39 · §4.15 · §5.6 invariant |

---

## 7 · Snap dọc, chip gap, haptic · `TC-SNP` (mục 2 #7 test plan — BVA 3-value (dấu của gap) + Decision Table (điểm snap × loại band))

> **Show grid bật**, máy thật, `[D7]`. **Chỉ kiểm dấu và hành vi, không kiểm giá trị tuyệt đối/đơn vị chip.**
> ⚠️ **Điều kiện thay đổi (Q-12):** mốc gap = 0 của band đầu = **vạch trên của grid** là **ASSUMPTION** (chưa dev xác nhận). Dev nêu mốc khác (**mép trên vùng nội dung** / **mép trên ảnh**) ⇒ **điểm snap gap 0 đổi chỗ** ⇒ **viết lại `SNP-01/02/03/05/06`** (và mốc tham chiếu ở `DRG-07/08`).
> **Không sinh case (chưa có oracle — test-plan 5.7):** snap khi band là **con trong Row/Column**; tương tác snap + độ trễ 0.1 s (§10 #9).

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Trace |
|---|---|---|:---:|---|
| TC-SNP-01 ⚠️ | **BVA gap < 0:** chọn **band đầu** → giữ kéo lên **quá vạch trên grid** → nhìn chip **gap** lúc đang kéo | **(Theo giả định Q-12)** chip hiện **số âm** (vd `-40`) khi band đầu ở trên vạch. Không so giá trị tuyệt đối/đơn vị | P1 | TC18-25 ⚠️ · §4.05 · §5.7 BVA gap<0 |
| TC-SNP-02 ⚠️ | **BVA gap = 0:** kéo band đầu để **hút vào gap 0** rồi **nhả tay** ở đó; đồng thời quan sát chip lúc kéo qua mốc | **(Theo giả định Q-12)** chip hiện **`0`** — **không bao giờ `-0`** (ở cả lúc kéo qua mốc lẫn sau khi nhả) | P1 | TC18-25 ⚠️, TC18-27 ⚠️ · §4.05, §4.06 · §5.7 BVA gap=0 |
| TC-SNP-03 ⚠️ | **BVA gap > 0:** kéo band đầu **xuống dưới** vạch trên grid | **(Theo giả định Q-12)** chip hiện **số dương** | P1 | TC18-25 ⚠️ · §4.05 · §5.7 BVA gap>0 |
| TC-SNP-04 | **S1 — Giữa màn (mọi band):** kéo 1 band tới gần **giữa màn** | **Hút vào** giữa màn + **đường gióng ngang hiện ra** + **rung nhẹ** (máy thật) | P1 | TC18-26 · §4.06 · §5.7 DT S1 |
| TC-SNP-05 ⚠️ | **S2 — Gap 0, band đầu:** kéo **band đầu** lên gần **vạch trên grid** → nhả | **(Theo giả định Q-12)** **hút vào** tại "chỗ khối bắt đầu" (= vạch trên grid); nhả tay → chip **`0`**; rung **1 lần** | P1 | TC18-27 ⚠️ · §4.06, §4.05 · §5.7 DT S2 |
| TC-SNP-06 ⚠️ | **S3 — Gap 0, band khác:** kéo **band thứ 2** lên tới **vừa chạm band phía trên** → nhả | **(Theo giả định Q-12)** **hút vào** khi vừa chạm band trên; nhả → chip **`0`** | P1 | TC18-27 ⚠️ · §4.06 · §5.7 DT S3 |
| TC-SNP-07 | **S4 — Vạch dưới grid (mọi band):** kéo 1 band xuống gần **vạch dưới của grid** | **Hút vào**, **đáy band khớp vạch** | P2 | TC18-28 · §4.06 · §5.7 DT S4 |
| TC-SNP-08 | **Haptic:** điều kiện — **máy thật**, haptic hệ thống **bật** (tester xác nhận trước). Trong **1 cú kéo liên tục** (không nhả) kéo 1 band **đi qua 3 điểm snap** (vd gap 0 → giữa màn → vạch dưới grid); đếm số lần rung | **(QC · Q-6a)** rung nhẹ **1 lần cho MỖI điểm snap** hút vào ⇒ **3 lần rung** | P2 | TC18-29 · §4.06 · §5.7 Haptic |
| TC-SNP-09 | **Haptic — 2 điểm snap rất gần:** tạo tình huống 2 điểm gần nhau (vd band **ngắn** để gap 0 gần vạch dưới grid) → kéo qua vùng đó, đếm rung. *Ghi nhận (không expected): bán kính hút; có rung khi rời điểm snap không* | **(QC · Q-6b)** **hút vào điểm gần hơn** và **chỉ rung 1 lần** (không rung kép). Bán kính hút / rung khi rời điểm: **Phải ghi lại** (Q-6 phần mở, không có expected) | P2 | TC18-29 · §4.06 · §5.7 Haptic |

---

## 8 · Đổi bề rộng — kéo góc · `TC-RSZ` (mục 2 #8 test plan — Decision Table Z1–Z5 + BVA số con trong Row)

> **BVA số con trong Row:** 1 (không áp dụng) · **2** (`RSZ-04`, Z3) · **3** (biên dưới "3+", `RSZ-05`, Z4) · **N lớn** (`RSZ-06`).
> ⚠️ **Điều kiện thay đổi (Q-13):** dev trả lời cách bù trừ Row 3+ con ⇒ **thêm rule kiểm quy tắc cụ thể vào `RSZ-05/06`, gỡ ⚠️**. Tới lúc đó **KHÔNG kiểm** quy tắc bù trừ (chia đều / liền kề / con cuối hấp thụ).
> Precondition: `[D3]`, `[D4]`.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Trace |
|---|---|---|:---:|---|
| TC-RSZ-01 | **Z1:** chọn thành phần **ngoài cùng** (stack/column) → kéo **góc phải** (ra rộng và co hẹp) | **Cạnh trái đứng yên**, **chỉ mép phải chạy theo ngón** | P1 | TC18-44 · §5.01 · §5.8 Z1 |
| TC-RSZ-02 | **Z2:** cùng thành phần → kéo **góc trái** | **Cạnh phải đứng yên** | P1 | TC18-45 · §5.02 · §5.8 Z2 |
| TC-RSZ-03 | **Z1/Z2 — canh giữa:** ghi vị trí thành phần **trước** → kéo hẹp/rộng bằng góc phải rồi góc trái → **nhả tay** → so vị trí sau | Thành phần **vẫn canh giữa** (§5.06) và **không nhảy** khi nhả (`RSZ-09`). *Ghi nhận:* §5.01/§5.02 ("cạnh kia đứng yên trong lúc kéo") và §5.06 ("vẫn canh giữa") — nếu khi quan sát 2 điều xung đột (vd sau nhả cạnh đứng yên bị dịch) ⇒ ghi nhận + hỏi dev, **không tự kết luận** | P2 | TC18-49 · §5.06 · §5.8 Z1, Z2 |
| TC-RSZ-04 | **Z3:** `[D4]` Row **2 con** (A, B) → kéo góc A (rộng ra rồi hẹp lại) | **Vách ngăn:** B **hẹp lại đúng bằng** phần A rộng thêm (và ngược lại); **tổng bề rộng Row không đổi** | P1 | TC18-50 · §5.07 · §5.8 Z3 |
| TC-RSZ-05 ⚠️ | **Z4 (3 con):** `[D4]` Row **3 con** → kéo góc con **giữa** *(chỉ ghi lại — không đánh giá — cách 2 con còn lại co giãn, để gửi dev)* | **Chỉ kiểm bất biến:** **không con nào co về 0**; **không con bị đẩy ra ngoài Row / đè nhau**; thao tác = **1 bước Undo**. **KHÔNG kiểm quy tắc bù trừ** (Q-13 mở) | P2 | TC18-51 ⚠️ · §5.07 (thiếu), §5.08 · §5.8 Z4, BVA "3" |
| TC-RSZ-06 ⚠️ | **BVA "N lớn":** thêm con vào Row (chọn Row → **+**) tới **số con lớn nhất thêm được** *(ghi lại N thực tế; test basis không nêu số)* → kéo góc 1 con | **Chỉ bất biến** như `RSZ-05` + **UI không vỡ**. Không kiểm quy tắc bù trừ | P2 | TC18-51 ⚠️ (neo) · §5.07, §5.08 · §5.8 BVA "N lớn" |
| TC-RSZ-07 | **Z5:** thành phần **có chữ** → kéo góc **hẹp lại từ từ** (quay video) | Chữ **xuống dòng lại** và **chiều cao đổi ngay trong lúc kéo** — **không co giãn méo hình, không chờ nhả tay**. *(Đảo ngược so với 1.2.17 TC-66 — không chạy TC-66 cũ)* | P1 | TC18-47 · §5.04 · §5.8 Z5 |
| TC-RSZ-08 | Kéo góc, nhìn bề rộng **trong lúc đang kéo** (chưa nhả) | Bề rộng đổi **realtime** theo ngón, **không chờ nhả tay**. *Không ngưỡng độ trễ* | P2 | TC18-46 · §5.03 · §5.8 (realtime) |
| TC-RSZ-09 | Sau khi kéo góc → **nhả tay** (quay video) | **Không nhảy**, **không đổi kích thước thêm lần nữa** | P2 | TC18-48 · §5.05 · §5.8 |
| TC-RSZ-10 | Kéo góc **thu nhỏ hết cỡ** | **Có chặn — không co về 0**. **Không có ngưỡng** (Q-3a đã bỏ): không ghi/kiểm giá trị tối thiểu | P2 | TC18-52 · §5.08 · §5.8 BVA min-width |

---

## 9 · Thêm thành phần, sheet Add · `TC-ADD` (mục 2 #9 test plan — EP + Checklist 16 mục / 5 nhóm)

> **Oracle sheet Add:** spec §6/§7.22 + ảnh sheet Add QC gửi 2026-09-28 (**chưa hiện số build → chụp lại trên build 111 — Q-19, entry criterion E2**). **16 mục / 5 nhóm: Calendar 5 · Events 4 · Tasks 2 · Progress 3 · Layout 2; KHÔNG có nhóm Text; KHÔNG có Quote / Almanac day / Timeline.** Không dùng ảnh 1.2.17 (6 nhóm) làm oracle.
> **EP loại component (`ADD-09…22`):** 14 mục **không thuộc Layout** — **mỗi mục 1 case** (Row/Column thuộc `TC-NST`). Mỗi case gộp TC18-57 (P2) + TC18-58 (P3) → lấy **P2**.
> **EP trạng thái chọn khi bấm +:** `ADD-23` (chọn 1 thành phần) · `ADD-24` (chọn Row/Column) · `ADD-25` ⚠️ (không chọn gì).
> Tên UI → tên code (`contributionGrid`, `reminderList`, `timelineCards`) chỉ là suy luận — **không dùng làm expected**.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Trace |
|---|---|---|:---:|---|
| TC-ADD-01 | Bấm **+** → quan sát **toàn bộ sheet Add component** (cuộn hết); đếm nhóm/mục | **(QC · Q-21 đã đóng)** đúng **5 nhóm theo thứ tự CALENDAR · EVENTS · TASKS · PROGRESS · LAYOUT**, **tổng 16 mục**; **không có nhóm Text** | P2 | TC18-54 · §6, §7.22 · §5.9 Checklist (cấp sheet) |
| TC-ADD-02 | Nhóm **CALENDAR** | **5 mục đúng thứ tự:** Month grid · Mini month · Lunar calendar · Timetable · Week schedule; **mỗi mục có 1 dòng mô tả** (đối chiếu ảnh baseline) | P2 | TC18-54 · §6 · §5.9 Checklist |
| TC-ADD-03 | Nhóm **EVENTS** | **4 mục:** Today's events · Hour timeline · Week events · Activity grid; mỗi mục 1 dòng mô tả. **Không có Timeline** *(bản 1.2.17 có 5 mục)* | P2 | TC18-54 · §6, §7.22 · §5.9 Checklist |
| TC-ADD-04 | Nhóm **TASKS** | **2 mục:** Reminders · Priority matrix; mỗi mục 1 dòng mô tả | P2 | TC18-54 · §6 · §5.9 Checklist |
| TC-ADD-05 | Nhóm **PROGRESS** | **3 mục:** Year progress · Month progress · Countdown; mỗi mục 1 dòng mô tả | P2 | TC18-54 · §6 · §5.9 Checklist |
| TC-ADD-06 | Nhóm **LAYOUT** (ở cấp còn cho phép) | **2 mục:** Row · Column; mỗi mục 1 dòng mô tả | P2 | TC18-54 · §6 · §5.9 Checklist |
| TC-ADD-07 | **Âm tính:** tìm **Quote**, **Almanac day**, **Timeline** trong sheet; đối chiếu **tên hiển thị** | **(QC · Q-21)** **cả 3 KHÔNG xuất hiện**; **không có nhóm Text**; tên hiển thị đúng là **"Timetable"** (không phải "Week timetable"), **"Activity grid"**, **"Reminders"** | P2 | TC18-55 · §6, §7.22 · §5.9 Checklist âm tính |
| TC-ADD-08 | `[D9]` mở template **có sẵn** Quote / Almanac day / Timeline → với **từng loại**: chạm chọn → **Edit component** → kéo di chuyển | **Vẫn sửa được** trên template có sẵn: chọn được (viền + pill), **bảng thuộc tính mở được**, kéo được (**không** kiểm knob riêng — không oracle). Chỉ mất khả năng **thêm mới** | P2 | TC18-56 · §6, §7.22 · §5.9 (âm tính, TC18-56) |
| TC-ADD-09 | *(EP loại: Month grid)* **+** → **Month grid** → xem toast + thành phần mới → bấm **Undo** trên toast | Toast *"Added …"* + **Undo**; thành phần **không chiếm hết bề rộng** (có lề 2 bên; **không kiểm giá trị lề** — Q-14 bỏ; full-width ⇒ report); Undo gỡ thành phần vừa thêm | P2 | TC18-57, TC18-58 · §6.01, §6.02 · §5.9 EP loại |
| TC-ADD-10 | *(EP loại: Mini month)* như `ADD-09` | như `ADD-09` | P2 | TC18-57, TC18-58 · §6.01, §6.02 · §5.9 EP loại |
| TC-ADD-11 | *(EP loại: Lunar calendar)* như `ADD-09` | như `ADD-09` | P2 | TC18-57, TC18-58 · §6.01, §6.02 · §5.9 EP loại |
| TC-ADD-12 | *(EP loại: Timetable)* như `ADD-09` | như `ADD-09` | P2 | TC18-57, TC18-58 · §6.01, §6.02 · §5.9 EP loại |
| TC-ADD-13 | *(EP loại: Week schedule)* như `ADD-09` | như `ADD-09` | P2 | TC18-57, TC18-58 · §6.01, §6.02 · §5.9 EP loại |
| TC-ADD-14 | *(EP loại: Today's events)* như `ADD-09` | như `ADD-09` | P2 | TC18-57, TC18-58 · §6.01, §6.02 · §5.9 EP loại |
| TC-ADD-15 | *(EP loại: Hour timeline)* như `ADD-09` | như `ADD-09` | P2 | TC18-57, TC18-58 · §6.01, §6.02 · §5.9 EP loại |
| TC-ADD-16 | *(EP loại: Week events)* như `ADD-09` | như `ADD-09` | P2 | TC18-57, TC18-58 · §6.01, §6.02 · §5.9 EP loại |
| TC-ADD-17 | *(EP loại: Activity grid)* như `ADD-09` | như `ADD-09` | P2 | TC18-57, TC18-58 · §6.01, §6.02 · §5.9 EP loại |
| TC-ADD-18 | *(EP loại: Reminders)* như `ADD-09` | như `ADD-09` | P2 | TC18-57, TC18-58 · §6.01, §6.02 · §5.9 EP loại |
| TC-ADD-19 | *(EP loại: Priority matrix)* như `ADD-09` | như `ADD-09` | P2 | TC18-57, TC18-58 · §6.01, §6.02 · §5.9 EP loại |
| TC-ADD-20 | *(EP loại: Year progress)* như `ADD-09` | như `ADD-09` | P2 | TC18-57, TC18-58 · §6.01, §6.02 · §5.9 EP loại |
| TC-ADD-21 | *(EP loại: Month progress)* như `ADD-09` | như `ADD-09` | P2 | TC18-57, TC18-58 · §6.01, §6.02 · §5.9 EP loại |
| TC-ADD-22 | *(EP loại: Countdown)* như `ADD-09` | như `ADD-09` | P2 | TC18-57, TC18-58 · §6.01, §6.02 · §5.9 EP loại |
| TC-ADD-23 | *(EP: đang chọn 1 thành phần)* chọn 1 thành phần đơn → **+** → chọn 1 loại | Thành phần mới rơi **ngay dưới** cái đang chọn | P2 | TC18-59 · §6.03 · §5.9 EP chọn-1 |
| TC-ADD-24 | *(EP: đang chọn Row/Column)* chọn 1 **Row/Column** → **+** → chọn 1 loại | Thành phần mới rơi **vào trong** container đó | P2 | TC18-60 · §6.04 · §5.9 EP chọn-container |
| TC-ADD-25 ⚠️ | *(EP: không chọn gì)* bỏ chọn hết (chạm vùng trống) → **+** → chọn 1 loại | **(QC · Q-11a — còn đúng ở 1.2.18)** thành phần mới **chèn vào giữa canvas**. ⚠️ **Hành vi này KHÔNG có trong spec 1.2.18** (nguồn: trao đổi miệng 2026-09-24) — **điều kiện thay đổi:** dev đưa vào tài liệu chính thức ⇒ gỡ ⚠️; dev phủ nhận ⇒ bỏ case | P2 | TC18-61 ⚠️ · — (ngoài spec, TB-18) · §5.9 EP không-chọn |

---

## 10 · Row/Column, giới hạn lồng, container rỗng · `TC-NST` (mục 2 #10 test plan — BVA độ sâu + Decision Table ô trống + State Transition container rỗng)

> ⚠️ **Điều kiện thay đổi (Q-3b còn mở) cho `NST-07`, `NST-10`:** cách đếm cấp ("Tối đa 3 cấp" — canvas/stack gốc có tính 1 cấp không) chưa chốt. **Kiểm bằng cách lồng thực tế `Column > Row > Column` (`[D3]`, ví dụ hợp lệ §6.2), không suy diễn mốc đếm, KHÔNG thiết kế "cấp 4".** Dev chốt cách đếm ⇒ gỡ ⚠️, có thể thêm case cấp 4.
> **Trình tự chạy gộp:** dựng dần độ sâu 1 → 2 → 3 trên **cùng 1 nhánh**, mỗi lần thêm 1 cấp thì mở sheet Add kiểm nhóm Layout (`NST-08` → `NST-09` → `NST-07`) trước khi lồng tiếp.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Trace |
|---|---|---|:---:|---|
| TC-NST-01 | **+** → **Layout → Row** | Hiện 1 hàng gồm **2 ô trống nét đứt nằm cạnh nhau**, mỗi ô có nút **+** ở giữa | P3 | TC18-62 · §6.1.01 · §5.10 (62, 63) |
| TC-NST-02 | **+** → **Layout → Column** | **2 ô trống nét đứt xếp dọc**, mỗi ô có nút **+** | P3 | TC18-63 · §6.1.02 · §5.10 (62, 63) |
| TC-NST-03 | **DT ô trống — nút +:** với **Row** rồi **Column**: bấm đúng **nút +** trong ô trống số 1 → sheet mở → chọn 1 loại; lặp với ô số 2 *(4 tổ hợp: Row/Column × ô 1/ô 2)* | Sheet **mở**; thành phần lấp **đúng ô đó**; **ô còn lại vẫn còn nguyên**. **Ô số 2 biến mất hoặc thành phần vừa thêm chiếm hết hàng ⇒ REPORT** (regression lỗi đã fix) | P1 | TC18-64 · §6.1.03 · §5.9 DT ô trống (nút +) |
| TC-NST-04 | **DT ô trống — nền ô:** bấm vào **nền** ô trống (**không** trúng nút +) | **Chọn container**, **không mở sheet** | P2 | TC18-65 · §6.1.04 · §5.9 DT ô trống (nền ô) |
| TC-NST-05 | Lấp nốt **ô thứ 2** của Row (rồi Column) | Container hiện **đủ 2 thành phần, chia đôi** | P3 | TC18-66 · §6.1.05 · §5.10 |
| TC-NST-06 | Quan sát container **đã đủ con** | **Không còn ô trống** nào thừa | P3 | TC18-67 · §6.1.06 · §5.10 |
| TC-NST-07 ⚠️ | **BVA cấp 3 (biên trên hợp lệ):** dựng `[D3]` `Column > Row > Column` → chọn/bấm **+** trong **Column trong cùng** → mở sheet Add | **(Theo giả định — Q-3b mở)** nhóm **LAYOUT biến mất**; còn **14 mục / 4 nhóm** (Calendar 5 · Events 4 · Tasks 2 · Progress 3). Nếu Layout **còn hiện** hoặc biến mất **sớm hơn** cấu trúc này ⇒ **ghi nhận cấu trúc thực tế + hỏi dev**, không kết luận | P2 | TC18-68 ⚠️ · §6.2.01 · §5.10 BVA cấp 3 |
| TC-NST-08 | **BVA cấp 1:** chọn **Column cấp 1** (mới thêm) → **+** → mở sheet | Sheet còn nhóm **LAYOUT** (**16 mục / 5 nhóm**) | P3 | TC18-69 · §6.2.02 · §5.10 BVA cấp 1 |
| TC-NST-09 | **BVA cấp 2:** lồng **Row trong Column** → chọn Row → **+** → mở sheet | Nhóm **LAYOUT vẫn hiện** bình thường | P3 | TC18-69 · §6.2.02 · §5.10 BVA cấp 2 |
| TC-NST-10 ⚠️ | **Sibling:** ở cấp còn cho phép, chọn 1 thành phần con **thuộc cùng container cha** → **+** → **Layout → Row/Column** (container mới ngang hàng với thành phần đó) | **(Theo giả định — Q-3b mở)** **vẫn thêm được**, **không bị tính dồn vào độ sâu** (không bị chặn sai). Lệch ⇒ ghi cấu trúc + hỏi dev | P2 | TC18-70 ⚠️ · §6.2.03 · §5.10 (Sibling) |
| TC-NST-11 | **State Transition container rỗng:** thêm Row (hoặc Column), **không lấp gì** → bấm **✓ (Done)** | Container rỗng **bị bỏ**; hiện toast *"Removed the empty layout"* kèm **Undo** *(ghi nhận toast xuất hiện ở màn nào)* | P2 | TC18-71 · §6.3.01 · §5.10 State Transition |
| TC-NST-12 | Tiếp `NST-11`: bấm **Undo** trên toast | Container rỗng **quay lại màn editor** *(nếu app không tự mở Component Editor thì mở lại để kiểm; ghi nhận)* | P2 | TC18-72 · §6.3.02 · §5.10 State Transition |

---

## 11 · Bảng thuộc tính — nền · `TC-PRP` (mục 2 #11 test plan — State Transition Auto ↔ Fixed + Checklist)

> States: **Position = Auto** · **Position = Fixed**. Chuyển **cả 2 chiều**. (TC18-77 → `TC-INT-07`.)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Trace |
|---|---|---|:---:|---|
| TC-PRP-01 | *[Auto]* `[D1]` chọn 1 thành phần → Edit component → **Position: Auto → Fixed** (ghi vị trí trên canvas trước/sau) | *[→ Fixed]* thành phần **không tự nhảy chỗ** khi đổi | P1 | TC18-74 · §7.01 · §5.11 Auto→Fixed |
| TC-PRP-02 | *[Fixed]* → **Position: Fixed → Auto** (ghi vị trí trước/sau) | *[→ Auto]* thành phần **không tự nhảy chỗ** | P1 | TC18-74 · §7.01 · §5.11 Fixed→Auto |
| TC-PRP-03 | Ở **Fixed**: kéo thanh **Vertical position** | Thanh **hiện** khi chọn Fixed; thành phần **chạy dọc theo** khi kéo | P2 | TC18-75 · §7.02 · §5.11 |
| TC-PRP-04 | Kéo thanh **Width** trong bảng → so với canvas; rồi kéo **góc** trên canvas → xem giá trị Width | **Đồng bộ 2 chiều:** kéo Width ⇒ bề rộng canvas đổi theo; kéo góc ⇒ Width cập nhật *(số cạnh tên slider chỉ cập nhật khi nhả — `TC-INT-09`)* | P2 | TC18-76 · §7.03 · §5.11 |
| TC-PRP-05 | **Knob theo loại — lớp A (10 loại):** lần lượt với Month grid · Mini month · Today's events · Timeline `[D9]` · Week events · Year progress · Countdown · Priority matrix · Hour timeline · Timetable: đổi **1 knob riêng bất kỳ** trong bảng (ghi knob đã đổi) | Mỗi loại: knob **đổi được và ăn ngay** trên canvas. *(Chỉ 10 loại spec nêu knob; lớp B/C → `TC-KNB-28…34`. Kiểm giá trị chi tiết từng loại ở `TC-KNB`)* | P2 | TC18-78 · §7.05, §7.14–§7.21 · §5.11 |
| TC-PRP-06 | Bảng → cuối bảng: **Duplicate** | Tạo **đúng 1 bản sao** của thành phần; bản gốc giữ nguyên | P2 | TC18-79 · §7.06 · §5.11 |
| TC-PRP-07 | Bảng → **Delete** *(spec không nêu toast cho Delete từ bảng — ghi nhận có/không)* | Thành phần bị **xoá** khỏi canvas | P2 | TC18-79 · §7.06 · §5.11 |
| TC-PRP-08 | **T9:** bảng → **Deselect** | **(QC · Q-17)** *[→ S0]* bảng **đóng** · khung viền **mất** · nút **+ hiện lại** — **cùng trạng thái cuối** với ✕ (`TC-PUX-08`) và chạm vùng trống (`TC-SEL-06`) | P2 | TC18-79 · §7.06, §7.09, §3.02 · §5.4 T9 |

---

## 12 · Bảng thuộc tính — slider, gesture, grabber/✕ · `TC-PUX` (mục 2 #12 test plan — Decision Table gesture + State Transition bảng)

> ⚠️ **Toàn bộ `PUX-01…05` dựa trên ASSUMPTION Q-7 (QC chấp nhận, CHƯA dev xác nhận):** hướng cử chỉ **khoá một lần từ đầu**, giữ tới khi nhả tay; đã khoá thì **không đổi giữa chừng**. **Mâu thuẫn §7.07 ↔ §7.08 vẫn nằm nguyên trong test basis.** **Không có ngưỡng góc/thời gian** — "thiên về ngang" / "gần thẳng dọc" chỉ kiểm định tính.
> ⚠️ **Điều kiện thay đổi:** dev nêu **quy tắc gesture khác** (vd slider giành cử chỉ tới cùng / không khoá hướng) ⇒ **viết lại expected `PUX-01…04`** (G1–G4); dev **sửa spec** gỡ mâu thuẫn §7.07 ↔ §7.08 ⇒ gỡ ⚠️ theo chuỗi answers → test-analysis → test-plan → test-case.
> Slider nhóm **Position:** Vertical position (chỉ khi Fixed), Width, Horizontal offset, Size (chỉ thành phần ngoài cùng) — dùng slider nào có sẵn. Máy thật.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Trace |
|---|---|---|:---:|---|
| TC-PUX-01 ⚠️ | **G1:** mở bảng của thành phần có nhiều knob → **bắt đầu trên slider**, kéo theo hướng **thiên về ngang**, đều tay | **(Theo giả định Q-7)** slider **chạy mượt, không khựng**; canvas chạy theo **ngay**; **bảng không cuộn** | P1 | TC18-80 ⚠️, TC18-82 ⚠️ · §7.07, §7.08 · §5.12 G1 |
| TC-PUX-02 ⚠️ | **G2:** bắt đầu trên slider, thiên ngang, nhưng **kéo qua kéo lại, tay lệch dọc nhẹ** | **(Theo giả định Q-7)** slider **vẫn chạy, không khựng** (lỗi cũ); bảng **vẫn không cuộn** (đã khoá hướng). Khựng ⇒ *Query → dev* / confirmation lỗi đã sửa | P1 | TC18-80 ⚠️ · §7.07 · §5.12 G2 |
| TC-PUX-03 ⚠️ | **G3:** bắt đầu trên slider, vuốt **gần thẳng dọc** *(bảng đủ dài để cuộn)* | **(Theo giả định Q-7)** **bảng cuộn**; **giá trị slider không đổi** | P1 | TC18-82 ⚠️ · §7.08 · §5.12 G3 |
| TC-PUX-04 ⚠️ | **G4:** bắt đầu trên slider, thiên ngang (slider đã "khoá") → **giữa chừng vuốt dọc mạnh** | **(Theo giả định Q-7)** **không đổi sang cuộn bảng** — slider vẫn theo tay (không đổi hướng giữa chừng) | P1 | TC18-82 ⚠️ · §7.08 · §5.12 G4 |
| TC-PUX-05 ⚠️ | **G5 (đối chứng — suy luận QC):** bắt đầu **ngoài slider**, vuốt dọc | Bảng **cuộn bình thường** *(đối chứng, không phụ thuộc giả định khoá hướng)* | P1 | TC18-82 ⚠️ · §7.08 · §5.12 G5 |
| TC-PUX-06 | Kéo 1 slider Position (1 lần giữ, có thể qua lại) → **nhả tay** → bấm **Undo 1 lần** | Nhả tay = **đúng 1 bước Undo**: Undo đưa giá trị về **trước lúc bắt đầu kéo** (không hoàn từng frame) | P2 | TC18-81 · §7.07 · §5.12 (Undo slider) |
| TC-PUX-07 | **T7 — Grabber:** mở bảng → **vuốt xuống ở thanh grabber** trên đầu bảng | *[→ S5]* **bảng đóng**, **thành phần vẫn được chọn**: **khung viền còn** — **khác hẳn ✕/Deselect**. **(QC · Q-17, đối chiếu)** nút **+** **chưa hiện lại** *(phần nút + theo test-analysis TC18-83; spec §7.09 không nói rõ — **chốt bằng ảnh baseline Q-19**, ghi nhận nếu khác)* | P1 | TC18-83 · §7.09 · §5.4 T7, §5.12 |
| TC-PUX-08 | **T8 — ✕:** mở bảng → bấm **✕ trong bảng** | **(QC · Q-17)** *[→ S0]* bảng **đóng** · khung viền **mất** · nút **+ (Add)** **hiện lại** — **cùng trạng thái cuối** với Deselect (`TC-PRP-08`) và chạm vùng trống (`TC-SEL-06`); **khác** grabber (`TC-PUX-07`) | P1 | TC18-84 · §7.09, §7.06, §3.02 · §5.4 T8 |
| TC-PUX-09 | Chọn thành phần ở **nửa dưới màn** (bảng sẽ che) → **Edit component**; sau đó đóng bảng bằng **grabber**, rồi lặp và đóng bằng **✕** | Bảng che thành phần → **canvas tự đẩy lên** cho thấy thành phần; **đóng bảng → canvas về chỗ cũ** (cả 2 cách đóng) | P2 | TC18-85 · §7.10 · §5.12 |
| TC-PUX-10 | Mở bảng thuộc tính trên máy **có home indicator** và máy **không có** *(thiếu loại nào ⇒ ghi giới hạn coverage, không suy diễn)*; iOS 18.x + 26.x | **Đáy bảng không hở** (không lộ khe/nền dưới đáy bảng) trên cả 2 loại máy | P2 | TC18-86 · §7.11 · §5.12 |

---

## 13 · Knob riêng theo loại · `TC-KNB` (mục 2 #13 test plan — EP loại A/B/C + BVA 2-value Size + Decision Table 2×2 + Checklist theo loại)

> **Mỗi loại lớp A một case riêng** (không kiểm chung). **Lớp B (5 loại) / C (2 loại) — chỉ vòng đời chung, CẤM suy diễn knob** (Lunar calendar · Week schedule · Month progress · Reminders · Activity grid · Quote · Almanac day). Ánh xạ tên UI → tên code là suy luận, không dùng làm expected.
> ⚠️ **Điều kiện thay đổi `KNB-28…34` (TB-22):** dev bàn giao **danh mục chính thức** (tên UI ↔ tên code ↔ knob riêng) ⇒ **thêm case knob cho 7 loại, gỡ ⚠️**.
> Ô *Lines* của Quote thuộc Q-4 ⇒ **GAP, ngoài phạm vi** (Phụ lục B).
> **Decision Table 2×2 Bold × Italic:** `KNB-05…08` = B1–B4 — dùng thành phần có chữ **không** thuộc `[D10]` (tránh nhiễu bởi dữ liệu bold+italic sẵn của template).

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Trace |
|---|---|---|:---:|---|
| TC-KNB-01 | **BVA Size — chữ chính = 200:** chọn thành phần **ngoài cùng** có chữ chính → Edit → kéo thanh **Size** tới **hết cỡ**; **nhả tay rồi đọc** số cạnh tên slider | Giá trị tối đa của chữ chính = **200** | P2 | TC18-87 · §7.12 · §5.13 BVA 200 |
| TC-KNB-02 | **BVA Size — chữ phụ = 60:** với chữ phụ (caption / giờ / thứ…) → thanh **Size** của mục chữ phụ → kéo hết cỡ, nhả, đọc số | Giá trị tối đa của chữ phụ = **60** *(nếu UI không có Size riêng cho chữ phụ ⇒ ghi nhận, không suy đoán)* | P2 | TC18-87 · §7.12 · §5.13 BVA 60 |
| TC-KNB-03 | **BVA Size — vượt trần:** ở `KNB-01` và `KNB-02` sau khi tới hết cỡ, **cố kéo tiếp** ngón vượt đầu mút → nhả | **Bị chặn:** giá trị vẫn **200** (chính) / **60** (phụ), không vượt | P2 | TC18-87 · §7.12 · §5.13 BVA "vượt trần" |
| TC-KNB-04 🔭 | Nếu có **template có sẵn đang vượt trần** (Size > 200 hoặc chữ phụ > 60) → mở bảng, ghi giá trị hiển thị; thử kéo Size | **Phải quan sát/ghi lại:** giá trị hiển thị, có bị clamp xuống hay giữ nguyên khi chưa chạm slider. **Không kết luận pass/fail** (Q-16 đã bỏ). Không có template nào vượt ⇒ ghi "N/A" | P2 | TC18-87 · §7.12 · §5.13 (template vượt trần) |
| TC-KNB-05 | **B1:** Bold **tắt** · Italic **tắt** | Chữ **thường** | P2 | TC18-88 · §7.13 · §5.13 DT B1 |
| TC-KNB-06 | **B2:** Bold **bật** · Italic **tắt** | Chữ **đậm** | P2 | TC18-88 · §7.13 · §5.13 DT B2 |
| TC-KNB-07 | **B3:** Bold **tắt** · Italic **bật** | Chữ **nghiêng** | P2 | TC18-88 · §7.13 · §5.13 DT B3 |
| TC-KNB-08 | **B4:** Bold **bật** · Italic **bật** cùng lúc | Chữ **vừa đậm vừa nghiêng** *(trước đây chỉ ăn 1)* | P2 | TC18-88 · §7.13 · §5.13 DT B4 |
| TC-KNB-09 | **Month grid — mục phụ:** Edit → tìm mục **Weekday** | Có mục **Weekday** với **tiêu đề nhỏ riêng**, **ở ngoài** (không còn trong *More options*); đổi thử 1 knob trong mục → canvas cập nhật | P2 | TC18-90 · §7.14 · §5.13 Month grid |
| TC-KNB-10 | **Mini month — mục phụ:** mục **Weekday** | như `KNB-09` (Weekday, tiêu đề riêng, ngoài *More options*) | P2 | TC18-90 · §7.14 · §5.13 Mini month |
| TC-KNB-11 | **Today's events — mục phụ:** mục **Time** | Mục **Time** có tiêu đề nhỏ riêng, ngoài *More options*; đổi thử 1 knob → canvas cập nhật | P2 | TC18-90 · §7.14 · §5.13 Today's events |
| TC-KNB-12 | **Timeline `[D9]` — mục phụ:** mục **Time** | Mục **Time** có tiêu đề riêng, ngoài *More options* | P2 | TC18-90 · §7.14 · §5.13 Timeline |
| TC-KNB-13 | **Week events — mục phụ:** mục **Date** | Mục **Date** có tiêu đề riêng, ngoài *More options* | P2 | TC18-90 · §7.14 · §5.13 Week events |
| TC-KNB-14 | **Year progress — mục phụ:** mục **Caption** *(không kiểm "target date" — GAP, Phụ lục B)* | Mục **Caption** có tiêu đề riêng, ngoài *More options* | P2 | TC18-90 · §7.14 · §5.13 Year progress |
| TC-KNB-15 | **Countdown — mục phụ:** mục **Caption** | Mục **Caption** có tiêu đề riêng, ngoài *More options* | P2 | TC18-90 · §7.14 · §5.13 Countdown |
| TC-KNB-16 | **Priority matrix — ↺ Reset:** chụp **bộ 4 màu mặc định** trước → đổi màu **từng ô** → hàng màu đã chỉnh có nút **↺ Reset** → bấm | Nút **↺ Reset** xuất hiện ở hàng màu đã chỉnh; bấm → **trả về bộ 4 màu mặc định theo từng ô** (so với ảnh chụp trước khi chỉnh) | P2 | TC18-91 · §7.15 · §5.13 Priority matrix |
| TC-KNB-17 | **Countdown — caption:** Edit → **Content → Caption** → gõ chữ mới *(chưa bấm Done)* → quan sát canvas → bấm **Done** (hoặc chạm ra ngoài ô) → bấm **Undo 1 lần** | Chỉ khi **Done/ra ngoài ô** chữ caption mới **áp** lên canvas; áp = **đúng 1 bước Undo** (Undo về caption cũ) | P2 | TC18-92 · §7.16 · §5.13 Countdown caption |
| TC-KNB-18 | **Countdown — caption trống:** xoá trống ô Caption → Done | **Caption ẩn** khỏi canvas | P2 | TC18-92 · §7.16 · §5.13 Countdown caption |
| TC-KNB-19 | **Priority matrix — màu chữ:** đổi lần lượt màu chữ **ghi chú**, **công việc**, **giờ** | Mỗi màu **riêng biệt**: đổi màu loại chữ nào chỉ **loại chữ đó** đổi trên canvas | P2 | TC18-93 · §7.17 · §5.13 Priority matrix |
| TC-KNB-20 | **Priority matrix — Blur & Layout:** chỉnh **Blur** (nền ô); tìm mục **"Layout"** | **Blur** nền ô **có tác dụng**; **không còn** mục "Layout" | P2 | TC18-93 · §7.17 · §5.13 Priority matrix |
| TC-KNB-21 | **Month grid — màu ngày:** mục **Day** → đổi màu ngày **quá khứ**, rồi **tương lai** *(cần tháng đang hiển thị có cả ngày đã qua và chưa tới)* | Đổi màu quá khứ ⇒ chỉ **ngày quá khứ** đổi; đổi màu tương lai ⇒ chỉ **ngày tương lai** đổi | P2 | TC18-94 · §7.18 · §5.13 Month grid |
| TC-KNB-22 | **Month grid — căn phải tiêu đề tháng:** đặt **căn phải** cho tiêu đề tháng | Tiêu đề tháng **căn phải** đúng | P2 | TC18-94 · §7.18 · §5.13 Month grid |
| TC-KNB-23 | **Hour timeline — Elapsed color:** Edit → **Elapsed color** → đổi màu *(cần thời điểm có phần "đã qua" hiển thị)* | Có **Elapsed color**; đổi màu ⇒ **phần đã qua** đổi màu | P3 | TC18-95 · §7.19 · §5.13 Hour timeline |
| TC-KNB-24 | **Timetable — cỡ chữ ngày:** đổi cỡ chữ ngày | Cỡ chữ ngày **có tác dụng** trên canvas | P3 | TC18-96 · §7.20 · §5.13 Timetable |
| TC-KNB-25 | **Timetable — màu giờ:** đổi màu giờ | Màu giờ **có tác dụng** trên canvas | P3 | TC18-96 · §7.20 · §5.13 Timetable |
| TC-KNB-26 | **Timeline `[D9]` — Blur:** đổi **Blur** nền thẻ | Blur nền thẻ **có tác dụng** | P3 | TC18-97 · §7.21 · §5.13 Timeline |
| TC-KNB-27 | **Timeline `[D9]` — Cards per day:** tìm mục "Cards per day" | **Không còn** "Cards per day" | P3 | TC18-97 · §7.21 · §5.13 Timeline |
| TC-KNB-28 ⚠️ | **Lớp B — Lunar calendar (chỉ vòng đời chung):** (1) **+** → Lunar calendar → toast *Added…* + Undo *(Undo gỡ; thêm lại)* (2) hiện trên canvas (3) chạm **chọn** → viền + pill; **Edit component** mở được bảng *(không kiểm knob)* (4) **kéo** di chuyển (5) **kéo góc** đổi bề rộng (6) **Duplicate**; **Delete** rồi **Undo** | Mỗi bước chạy đúng như thành phần thường: toast + Undo; **render ra nội dung phù hợp loại đã chọn** (không trống/lỗi/vỡ layout — **không đối chiếu hình dáng chi tiết**, không oracle); chọn/kéo/đổi bề rộng đúng; Duplicate ra 1 bản; Delete + Undo trả đúng chỗ. **KHÔNG kiểm/suy diễn knob** | P2 | TC18-118 ⚠️ · §6, §6.01, §3, §4, §5 + TB-22 · §5.13 Lớp B |
| TC-KNB-29 ⚠️ | **Lớp B — Week schedule:** như `KNB-28` | như `KNB-28` | P2 | TC18-118 ⚠️ · như trên |
| TC-KNB-30 ⚠️ | **Lớp B — Month progress:** như `KNB-28` | như `KNB-28` | P2 | TC18-118 ⚠️ · như trên |
| TC-KNB-31 ⚠️ | **Lớp B — Reminders:** như `KNB-28` | như `KNB-28` | P2 | TC18-118 ⚠️ · như trên |
| TC-KNB-32 ⚠️ | **Lớp B — Activity grid:** như `KNB-28` | như `KNB-28` | P2 | TC18-118 ⚠️ · như trên |
| TC-KNB-33 ⚠️ | **Lớp C — Quote `[D9]`** (chỉ có trên template có sẵn): (1) chọn (2) **Edit component** mở được bảng *(không kiểm knob, không kiểm ô Lines)* (3) kéo (4) đổi bề rộng (5) Duplicate (6) Delete + Undo | Chọn/kéo/đổi bề rộng/Duplicate/Delete + Undo **chạy đúng**; bảng thuộc tính **mở được**. **KHÔNG kiểm knob** (TB-22); ô *Lines* thuộc Q-4 ⇒ **GAP ngoài phạm vi** | P2 | TC18-119 ⚠️ · §6, §7.22, §3, §4, §5 + TB-22 · §5.13 Lớp C |
| TC-KNB-34 ⚠️ | **Lớp C — Almanac day `[D9]`:** như `KNB-33` | như `KNB-33` | P2 | TC18-119 ⚠️ · như trên |

---

## 14 · Undo / Redo / Done / Cancel · `TC-UND` (mục 2 #14 test plan — State Transition / Checklist: 1 thao tác = 1 bước)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Trace |
|---|---|---|:---:|---|
| TC-UND-01 | Kéo 1 thành phần **1 cú dài** (đổi hướng nhiều lần trong 1 lần giữ) → nhả → bấm **Undo 1 lần** | Undo hoàn lại **đúng 1 thao tác** — **về vị trí trước lúc bắt đầu kéo**, **không** hoàn từng frame | P1 | TC18-101 · §8.01 · §5.14 |
| TC-UND-02 | Tiếp `UND-01`: bấm **Redo** | **Làm lại đúng thao tác** vừa Undo (thành phần về vị trí sau cú kéo) | P2 | TC18-102 · §8.02 · §5.14 |
| TC-UND-03 | Thêm 1 thành phần + đổi 1 thuộc tính → bấm **✓ (Done)** → nhìn màn quay lại; mở lại Component Editor | Quay lại màn editor; **bố cục mới được giữ** (preview + khi mở lại) | P1 | TC18-103 · §8.03 · §5.14 |
| TC-UND-04 | Trong 1 phiên: **thêm** 1 thành phần mới + **kéo** 1 thành phần + **đổi thuộc tính** → bấm **✕ (Cancel)**. *(Ghi nhận có hiện dialog xác nhận hay không — bản 1.2.17 không có; **không phải tiêu chí pass/fail**, test-plan mục 11 #7)* | Quay lại; **mọi** thay đổi trong phiên **bị bỏ** — **kể cả thành phần vừa thêm**; wallpaper **về đúng như lúc mở màn** | P1 | TC18-104 · §8.04 · §5.14 |
| TC-UND-05 | **Chuỗi thao tác ghi dữ liệu:** **thêm** 1 thành phần → **Duplicate** nó → **Delete** bản sao *(không kết hợp reorder/gap âm/snap — coverage gap #4 — Phụ lục B)* → bấm **Undo 3 lần** (ghi kết quả mỗi lần) | Mỗi Undo hoàn lại **đúng 1 thao tác theo thứ tự ngược** (Delete → Duplicate → Add); không mất/nhân bản thành phần. *(Toast Undo của Delete và Undo ở header là 2 đường — ghi nhận cả hai)* | P1 | TC18-101 · §8.01 · §5.14 (thêm/xoá/duplicate) |

---

## 15 · Chrome phụ · `TC-CHR` (mục 2 #15 test plan — Checklist-based)

> ⚠️ **Điều kiện thay đổi (Q-8) cho `CHR-02/03`:** giả định "cạnh screen ≡ mép ảnh" chưa xác nhận; nếu 2 biên khác nhau ⇒ **viết lại điều kiện bật cảnh báo + thêm condition vùng giữa hai biên**.
> **Lưu ý thiết kế:** `DRG-06/10` cho thấy giới hạn kéo là **mép ảnh** ⇒ có thể **không đưa thành phần ra ngoài screen bằng kéo** được. Test basis **không nêu cách kích hoạt cảnh báo** ⇒ `CHR-02` thử **mọi thao tác hợp lệ** (kéo tới mép, thêm thành phần cao, đổi Size, đổi Width…) và **ghi lại cách kích hoạt được**; **không kích hoạt được bằng cách nào** ⇒ ghi nhận + hỏi dev (Q-8), không kết luận.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Trace |
|---|---|---|:---:|---|
| TC-CHR-01 | Bấm **Show grid** bật → tắt; khi **lưới đang bật** chọn + kéo 1 thành phần nằm dưới lưới | Lưới **hiện/ẩn** đúng; **lưới không đè lên thao tác kéo** (chọn/kéo bình thường) | P2 | TC18-105 · §9.01 · §5.15 |
| TC-CHR-02 ⚠️ | Thử làm 1 thành phần **tràn ra ngoài cạnh screen** bằng thao tác hợp lệ (xem lưu ý) → quan sát cảnh báo → rồi đưa nó **về trong** | **(QC · Q-8)** cảnh báo *"Part of this runs off the screen"* **hiện khi thành phần ra khỏi cạnh screen**; **kéo/đưa về trong thì cảnh báo mất**. Không kích hoạt được ⇒ **ghi nhận cách đã thử, hỏi dev** | P2 | TC18-106 ⚠️ · §9.02, §4.03 · §5.15 |
| TC-CHR-03 ⚠️ | Kéo 1 thành phần **sát mép** screen/ảnh nhưng **vẫn bên trong** (giống `DRG-05/09`) | **(QC · Q-8)** **KHÔNG** bật cảnh báo. Thấy cảnh báo ở đây ⇒ ghi nhận **vùng giữa hai biên** + hỏi dev, không kết luận | P2 | TC18-106 ⚠️ · §9.02, §4.03 · §5.15 |
| TC-CHR-04 | Bấm nút **ẩn/hiện chrome** → ẩn hết nút → chạm lại | Ẩn hết nút để xem wallpaper "sạch"; **chạm lại thì hiện lại** đầy đủ | P3 | TC18-107 · §9.03 · §5.15 |

---

## 16 · Regression ngoài màn editor · `TC-REG` (mục 2 #16 test plan — Checklist-based, có thứ tự phụ thuộc; **KHÔNG rút gọn: 9/9**)

> Chạy **SAU** khi ROD/DRG/SNP/RSZ/ADD/NST/PRP/PUX/UND đã pass; kiểm kết quả **đã lưu** (**✓ Done**). Mỗi dòng = 1 case độc lập. Precondition chung: bố cục đã sửa & lưu; `[D16]` Live Activity + widget bật; máy thật.
> **`REG-08` (qua đêm thật) phải KHỞI ĐỘNG SỚM NHẤT** (test-plan 8.1) — không simulator, **không đổi giờ hệ thống**; chưa chạy được ⇒ **không exit** (test-plan mục 9).
> ⚠️ **Điều kiện thay đổi:** `REG-07/08` (Q-11b/c) — dev đưa vào tài liệu chính thức ⇒ gỡ ⚠️; dev phủ nhận ⇒ bỏ case. `REG-09` (Q-18) — "đúng" = sticker **được** hay **không được** làm mờ chưa chốt ⇒ **chỉ ghi nhận quan sát kèm ảnh** tới khi dev chốt.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Trace |
|---|---|---|:---:|---|
| TC-REG-01 | **Đặt làm màn khoá thật** (qua luồng đặt wallpaper của app) → nhìn lock screen thật, so với preview trong editor | Wallpaper render **đúng bố cục vừa sửa** — không chỉ đúng trên preview | P1 | TC18-109 · §11.01 · §5.16 |
| TC-REG-02 | Kiểm **Live Activity** của template vừa sửa | Vẫn **chạy**, **không vỡ layout** | P1 | TC18-110 · §11.02 · §5.16 |
| TC-REG-03 | Kiểm **widget** và **thumbnail** trong "Your collection" | **Cập nhật theo** bố cục mới | P1 | TC18-111 · §11.03 · §5.16 |
| TC-REG-04 | **Mở lại** template đã sửa (thoát hẳn rồi vào lại) → Edit → Components | Bố cục **giữ nguyên** như đã lưu; **sửa tiếp được** | P1 | TC18-112 · §11.04 · §5.16 |
| TC-REG-05 | `[D14]` mở 1 template lịch **cũ** chưa từng động vào | Render **y như trước** | P2 | TC18-113 · §11.05 · §5.16 |
| TC-REG-06 | `[D14]` mở 1 wallpaper **Note** (không phải lịch) | **Không bị ảnh hưởng** | P3 | TC18-114 · §11.06 · §5.16 |
| TC-REG-07 ⚠️ | `[D11]` trên **cùng template**: sửa bố cục ở **Component Editor (S03)** **và** trang trí ở **Decorate (S02)** → lưu cả hai → xem wallpaper cuối (S01 / lock screen thật) | **(QC · Q-11b — còn đúng ở 1.2.18)** wallpaper cuối **render đủ cả 2 phần**, không mất/đè lẫn nhau. ⚠️ **Không có trong spec 1.2.18** (trao đổi miệng 2026-09-24) | P1 | TC18-115 ⚠️ · — (ngoài spec, TB-18) · §5.16 |
| TC-REG-08 ⚠️ | `[D15]` đặt bố cục Component Editor → **chụp ảnh wallpaper TRƯỚC khi khoá máy** → để automation Shortcut chạy **qua đêm thật** (không đổi giờ hệ thống) → **chụp ảnh sáng hôm sau** | **(QC · Q-11c — còn đúng ở 1.2.18)** bố cục đã lưu **sống sót**, **không reset về bố cục gốc**. Cần **đủ 2 ảnh** (trước/sáng hôm sau), không kết luận nếu chỉ có 1. ⚠️ **Không có trong spec 1.2.18** | P1 | TC18-116 ⚠️ · — (ngoài spec, TB-18) · §5.16 |
| TC-REG-09 ⚠️🔭 | `[D12]` card **kính mờ (frosted)** có sticker nằm dưới → chụp **trong editor** và **wallpaper đã lưu** *(và lock screen thật nếu cần)* | **Phải quan sát/ghi lại kèm ảnh:** trong editor card chỉ làm mờ ảnh nền, không mờ sticker; wallpaper đã lưu "thì đúng" (§10 #6). **Không kết luận pass/fail** tới khi dev chốt Q-18 (sticker được hay không được làm mờ); chỉ report nếu sai trên **lock screen thật** | P2 | TC18-117 ⚠️ · §10 #6 · §5.16 |

---

## 17 · Hành vi CỐ Ý — xác nhận, không phải tìm lỗi · `TC-INT` (mục 2 #17 test plan — Checklist-based, **9/9**)

> Mỗi dòng = "đây là **đúng thiết kế, không report**".

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Trace |
|---|---|---|:---:|---|
| TC-INT-01 | **Chữ mềm khi kéo:** kéo 1 thành phần có chữ → quan sát chữ trong lúc kéo → **nhả tay** | Lúc kéo chữ hơi **mềm** (vẽ 2/3 độ phân giải) — **cố ý**; **nhả tay là nét lại**. **Chỉ là lỗi nếu vẫn mờ sau khi nhả** | P2 | TC18-40 · §10 #7 · §5.17 |
| TC-INT-02 | **Chờ ~0.1 s:** vừa **nhả tay** xong **chạm kéo tiếp ngay** | Thành phần **chờ khoảng 0.1 giây** rồi mới đi theo ngón — **cố ý** (đợi layout vẽ xong); không report. *(Định tính, không đo)* | P3 | TC18-41 · §10 #9 · §5.17 |
| TC-INT-03 | **Band đầu trên vạch grid:** với **từng** template `[D8]` `mix-class-schedule`, `mix-daily-brief`, `mix-focus-today`, `mix-mindful-month` → mở Component Editor, **Show grid bật** *(template không có sẵn ⇒ ghi Not run cho template đó)* | Band đầu **nằm trên vạch trên grid** (lấn vùng đồng hồ) — **hợp lệ, cố ý**; không report | P2 | TC18-42 · §10 #10 · §5.17 |
| TC-INT-04 | `[D5]` band có **thẻ nền**, đặt ở **gap 0** → quan sát viền thẻ so với vạch grid | Viền thẻ có thể nằm **trên** vạch grid (thẻ nhô lên trên band) — **thiết kế đã duyệt**; không report | P3 | TC18-43 · §10 #11 · §5.17 |
| TC-INT-05 | **4 góc là vùng kéo:** chọn 1 thành phần → kéo thử **cả 4 góc** *(không thấy vòng tròn chỉ báo)* | Cả 4 góc **kéo được** dù **không vẽ vòng tròn** — **cố ý**; không report thiếu chỉ báo | P2 | TC18-53 · §5 intro, §10 #3 · §5.17 |
| TC-INT-06 | Quan sát **Row/Column chỉ có 1 con** (ô trống thứ 2 còn) | **Vẫn chiếm chỗ như có 2 con** (ô trống thứ 2 giữ chỗ) — **cố ý** | P3 | TC18-73 · §10 #1 · §5.17 |
| TC-INT-07 | So bảng thuộc tính của thành phần **ngoài cùng** vs thành phần **trong Row/Column** | **Thanh Size** chỉ có ở thành phần **ngoài cùng**; con trong Row/Column **không có** — **cố ý** (bề rộng do container chia) | P3 | TC18-77 · §7.04, §10 #2 · §5.17 |
| TC-INT-08 | `[D10]` mở 2 template có sẵn cả bold+italic (month *"elegant script"*, priority matrix) → xem tiêu đề giờ; đối chiếu ảnh nếu có *(ghi phần tử nào đậm hơn)* | **(QC · Q-2)** tiêu đề giờ **đậm hơn trước** là **đúng dữ liệu template — KHÔNG report**. Chưa chỉ rõ phần tử nào / chưa có baseline 1.2.17 ⇒ **chỉ ghi nhận quan sát**, không mở bug | P3 | TC18-89 · §7.13 · §5.17 (§5.13) |
| TC-INT-09 | Kéo slider **Position** (vd Width): trong lúc kéo xem **bong bóng** trên núm; xem số cạnh tên slider; nhả tay | Số cạnh tên slider (vd `259`) **chỉ cập nhật khi nhả tay**; lúc kéo xem giá trị ở **bong bóng** — **cố ý**; không report | P3 | TC18-98 · §10 #12 · §5.17 |

---

## 18 · Exploratory tuỳ chọn · `TC-EXP` (test-plan 5.18 — session-based, **không tính exit criteria**)

| ID | Charter | Kết quả mong đợi | Ưu tiên | Trace |
|---|---|---|:---:|---|
| TC-EXP-01 🔭 | **Charter (đề xuất, cần QC duyệt):** "Khám phá **7 loại component không có oracle knob** (Lunar calendar · Week schedule · Month progress · Reminders · Activity grid · Quote · Almanac day) trên iOS 18.x/26.x để **ghi nhận knob nào xuất hiện trong bảng thuộc tính**, phục vụ Q-22." Timebox: **1 phiên**. Ghi: loại → tên từng knob/mục nhìn thấy → ảnh bảng thuộc tính | **Phải quan sát/ghi lại.** Kết quả chỉ là **dữ liệu gửi dev** — **không sinh pass/fail**, không tính coverage, **không đổi expected của `KNB-28…34`**. *(Priority P3: test plan không gán — xem Quy ước)* | P3 | TB-22 / Q-22 (không có condition `TC18-xx` riêng; liên quan TC18-118/119) · — · §5.18 |

---

# Phụ lục

## A · Bảng "điều kiện thay đổi → case nào phải viết lại" (18 nhãn ⚠️, giữ nguyên từ test-plan 6.3)

| Gap / giả định | Loại | Condition | Case bị ảnh hưởng | Khi dev trả lời khác thì… |
|---|---|---|---|---|
| **Q-10** — giữ **gap từng vị trí** khi đổi chỗ/Duplicate | **ASSUMPTION** (chờ dev) | TC18-19, 20 | `ROD-08`, `ROD-09`, `ROD-10` | Dev nói "giữ đỉnh ô/slot" ⇒ viết lại expected 3 case; có thể thêm case band cao → slot thấp |
| **Q-8** — "cạnh screen" ≡ "mép ảnh" | Giả định còn lại | TC18-23, 24, 106 | `DRG-03…11`, `CHR-02`, `CHR-03` | 2 biên khác nhau ⇒ viết lại điều kiện bật cảnh báo + thêm case vùng giữa hai biên |
| **Q-12** — mốc gap 0 = vạch trên grid | **ASSUMPTION** (chờ dev) | TC18-25, 27 | `SNP-01`, `SNP-02`, `SNP-03`, `SNP-05`, `SNP-06` | Dev nêu mốc khác (mép trên vùng nội dung / mép trên ảnh) ⇒ điểm snap gap 0 đổi chỗ, sửa 5 case (+ mốc ở `DRG-07/08`) |
| **Q-7** — khoá hướng cử chỉ một lần; mâu thuẫn §7.07 ↔ §7.08 | **ASSUMPTION** (chờ dev) | TC18-80, 82 | `PUX-01…05` | Quy tắc gesture khác ⇒ viết lại G1–G4; sửa spec gỡ mâu thuẫn ⇒ gỡ ⚠️ |
| **Q-13** — Row 3+ con bù trừ | Gap mở | TC18-51 | `RSZ-05`, `RSZ-06` | Dev trả lời ⇒ thêm rule kiểm quy tắc bù trừ, gỡ ⚠️ |
| **Q-3b** — "tối đa 3 cấp" đếm từ đâu | Gap mở | TC18-68, 70 | `NST-07`, `NST-10` | Dev chốt cách đếm ⇒ gỡ ⚠️, có thể thêm case cấp 4 |
| **Q-18** — sticker dưới card frosted: "đúng" là gì | Gap mở | TC18-117 | `REG-09` | Dev chốt ⇒ đổi từ "ghi nhận" sang pass/fail |
| **Q-11** — 3 hành vi ngoài spec | Ngoài spec | TC18-61, 115, 116 | `ADD-25`, `REG-07`, `REG-08` | Dev đưa vào tài liệu chính thức ⇒ gỡ ⚠️; phủ nhận ⇒ bỏ case |
| **TB-22 / Q-22** — 7 loại không có oracle knob | Thiếu oracle | TC18-118, 119 | `KNB-28…34` (+ `EXP-01`) | Dev bàn giao danh mục chính thức ⇒ thêm case knob cho 7 loại, gỡ ⚠️ |

**Nhãn (QC) — dev thắng nếu khác:** TC18-16, 17 (Q-9: `ROD-04/05`) · 23, 24, 106 (Q-8: `DRG-04/05/08/09`, `CHR-02/03`) · 29 (Q-6: `SNP-08/09`) · 36a, 36b (Q-1: `DRG-18/19`) · 54, 55 (Q-21: `ADD-01…07`) · 61, 115, 116 (Q-11: `ADD-25`, `REG-07/08`) · 79, 83, 84 (Q-17: `SEL-06`, `PRP-08`, `PUX-07/08`) · 89 (Q-2: `INT-08`).

## B · Không sinh case (theo quyết định duyệt của QC + phạm vi test plan)

| # | Hạng mục | Lý do | Điều kiện đưa lại |
|---|---|---|---|
| 1 | **TC18-99 — Year progress "target date"** (§12) | **GAP — descope chính thức** (QC 2026-09-28); spec ghi *"chưa có quyết định"*, không có acceptance criteria. Giả định QC (không có target date) **không dùng làm oracle** | QC gửi ảnh chụp chỗ thấy "target date" **+ dev chốt** |
| 2 | **TC18-100 — Quote "chữ / số dòng"** (§12) | **GAP — descope chính thức**; giả định QC (ô *Lines* phải có tác dụng) **không dùng làm oracle** | QC gửi mô tả (làm gì / thấy gì / mong đợi gì) **+ dev chốt** |
| 3 | **Knob riêng của 7 loại** (Lunar calendar, Week schedule, Month progress, Reminders, Activity grid, Quote, Almanac day) | Không có oracle (TB-22); suy diễn = vi phạm `.claude/rules/testing.md`. Chỉ vòng đời chung `KNB-28…34` | Dev bàn giao danh mục chính thức (Q-22) |
| 4 | Snap khi band là **con trong Row/Column**; chip gap trong container; tương tác snap + 0.1 s | Test-plan mục 11 #3/#4: không có oracle | Dev nêu hành vi |
| 5 | Tổ hợp reorder ↑/↓ ↔ gap âm ↔ snap ↔ Undo liên tiếp | Test-plan mục 11 #4: ứng viên exploratory, không có oracle (`UND-05` cố ý **không** kết hợp) | Bổ sung ở test plan |
| 6 | iPhone iOS 27 · 10 ngôn ngữ ngoài VI/EN · đo hiệu năng định lượng · bán kính snap · ngưỡng gesture/góc · đơn vị chip gap · bề rộng tối thiểu · biên dưới Size · giá trị lề · PRO gating theo loại component | Test-plan mục 3 (ngoài phạm vi / cố ý bỏ) | Dev bàn giao số cụ thể |
| 7 | Case **cấp 4** container; dialog xác nhận khi ✕ Cancel (chỉ ghi nhận ở `UND-04`) | Q-3b mở; test-plan mục 11 #7 là câu hỏi sản phẩm | Dev chốt cách đếm cấp / PO quyết |

## C · Traceability ngược — mỗi test condition → case (118/118)

| Condition | Case | Condition | Case | Condition | Case |
|---|---|---|---|---|---|
| TC18-01 | ENT-01 | TC18-41 | INT-02 | TC18-81 | PUX-06 |
| TC18-02 | ENT-02, 03 | TC18-42 | INT-03 | TC18-82 ⚠️ | PUX-01, 03, 04, 05 |
| TC18-03 | ENT-04 | TC18-43 | INT-04 | TC18-83 | PUX-07 |
| TC18-04 | ENT-05 | TC18-44 | RSZ-01 | TC18-84 | PUX-08 |
| TC18-05 | ENT-06 | TC18-45 | RSZ-02 | TC18-85 | PUX-09 |
| TC18-06 | DEV-01 | TC18-46 | RSZ-08 | TC18-86 | PUX-10 |
| TC18-07 | DEV-02 | TC18-47 | RSZ-07 | TC18-87 | KNB-01…04 |
| TC18-08 | LOC-01, 02 | TC18-48 | RSZ-09 | TC18-88 | KNB-05…08 |
| TC18-09 | SEL-01 (+SEL-10 neo) | TC18-49 | RSZ-03 | TC18-89 | INT-08 |
| TC18-10 | SEL-05, 06 | TC18-50 | RSZ-04 | TC18-90 | KNB-09…15 |
| TC18-11 | SEL-02, 03, 04 (+SEL-11 neo) | TC18-51 ⚠️ | RSZ-05, 06 | TC18-91 | KNB-16 |
| TC18-12 | SEL-09 | TC18-52 | RSZ-10 | TC18-92 | KNB-17, 18 |
| TC18-13 | SEL-08 | TC18-53 | INT-05 | TC18-93 | KNB-19, 20 |
| TC18-14 | SEL-07 | TC18-54 | ADD-01…06 | TC18-94 | KNB-21, 22 |
| TC18-15 | ROD-01, 07 | TC18-55 | ADD-07 | TC18-95 | KNB-23 |
| TC18-16 | ROD-03, 04, 07 (+ROD-11 neo) | TC18-56 | ADD-08 | TC18-96 | KNB-24, 25 |
| TC18-17 | ROD-05, 06 | TC18-57 | ADD-09…22 | TC18-97 | KNB-26, 27 |
| TC18-18 | ROD-02 | TC18-58 | ADD-09…22 | TC18-98 | INT-09 |
| TC18-19 ⚠️ | ROD-08, 10 | TC18-59 | ADD-23 | TC18-101 | UND-01, 05 |
| TC18-20 ⚠️ | ROD-09 | TC18-60 | ADD-24 | TC18-102 | UND-02 |
| TC18-21 | DRG-01 | TC18-61 ⚠️ | ADD-25 | TC18-103 | UND-03 |
| TC18-22 | DRG-02, 11 | TC18-62 | NST-01 | TC18-104 | UND-04 |
| TC18-23 ⚠️ | DRG-03…06 | TC18-63 | NST-02 | TC18-105 | CHR-01 |
| TC18-24 ⚠️ | DRG-07…11 | TC18-64 | NST-03 | TC18-106 ⚠️ | CHR-02, 03 |
| TC18-25 ⚠️ | SNP-01, 02, 03 | TC18-65 | NST-04 | TC18-107 | CHR-04 |
| TC18-26 | SNP-04 | TC18-66 | NST-05 | TC18-108 | DEV-03 |
| TC18-27 ⚠️ | SNP-02, 05, 06 | TC18-67 | NST-06 | TC18-109 | REG-01 |
| TC18-28 | SNP-07 (+DRG-03) | TC18-68 ⚠️ | NST-07 | TC18-110 | REG-02 |
| TC18-29 | SNP-08, 09 | TC18-69 | NST-08, 09 | TC18-111 | REG-03 |
| TC18-30 | DRG-12 | TC18-70 ⚠️ | NST-10 | TC18-112 | REG-04 |
| TC18-31 | DRG-13 | TC18-71 | NST-11 | TC18-113 | REG-05 |
| TC18-32 | DRG-14 | TC18-72 | NST-12 | TC18-114 | REG-06 |
| TC18-33 | DRG-15 | TC18-73 | INT-06 | TC18-115 ⚠️ | REG-07 |
| TC18-34 | DRG-16 | TC18-74 | PRP-01, 02 | TC18-116 ⚠️ | REG-08 |
| TC18-35 | DRG-17 | TC18-75 | PRP-03 | TC18-117 ⚠️ | REG-09 |
| TC18-36a | DRG-18 | TC18-76 | PRP-04 | TC18-118 ⚠️ | KNB-28…32 |
| TC18-36b | DRG-19 | TC18-77 | INT-07 | TC18-119 ⚠️ | KNB-33, 34 |
| TC18-37 | DRG-20 | TC18-78 | PRP-05 | TC18-99 / 100 | **GAP — không sinh case** (mục B #1, #2) |
| TC18-38 | DRG-21 | TC18-79 | PRP-06, 07, 08 | *(charter)* TB-22 | EXP-01 |
| TC18-39 | DRG-22 | TC18-80 ⚠️ | PUX-01, 02 | | |
| TC18-40 | INT-01 | | | | |

**Ngoại lệ traceability (case không có condition `TC18-xx` riêng — neo vào condition/transition gần nhất trong test plan, đã nêu ở cột Trace):** `SEL-10` (T10 — suy luận QC) · `SEL-11` (transition thử thêm — error guessing của test plan) · `ROD-11` (R10 — suy luận QC) · `PUX-05` (G5 — đối chứng suy luận QC) · `RSZ-06` (BVA "N lớn" — cùng gap Q-13) · `UND-05` (chuỗi thêm/xoá/duplicate của §5.14) · `EXP-01` (charter §5.18, neo TB-22). Đều có dòng tương ứng ở **mục 5 test plan**; không có case nào ngoài kỹ thuật đã chọn.
