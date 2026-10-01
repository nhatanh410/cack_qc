# Test Analysis — Wallpaper Component Editor (QC 1.2.17)

> ⚠️ SUPERSEDED — không dùng tài liệu này làm test basis.
> Bộ test này viết từ spec **1.2.17 (103)**, đã được thay thế bởi bộ **1.2.18 (111, rc3)**: [test-analysis-1.2.18.md](test-analysis-1.2.18.md) (test basis: [QC — Component Editor 1.2.18.md](../../../specs/wallpaper-editor/component-editor/QC%20—%20Component%20Editor%201.2.18.md)). Lý do: spec 1.2.18 đảo ngược một số hành vi (giới hạn kéo tới mép ảnh; chữ xuống dòng lại lúc kéo góc; thẻ nền container khi kéo; sheet Add còn 16 mục, bỏ nhóm Text/Timeline) và thêm hành vi mới (snap dọc, reorder ↑/↓, grabber…) — xem [diff-component-editor-1.2.17-vs-1.2.18.md](../../../specs/wallpaper-editor/component-editor/diff-component-editor-1.2.17-vs-1.2.18.md). Giữ lại để truy vết; các condition/case cũ bị 🔴 làm sai (TC-14, TC-29, TC-66, TC-67 / DRG-01, ADD-01, INT-01) đã được thay trong bộ 1.2.18.

> **Cập nhật 2026-09-24:** câu hỏi #1 (bảng thiết bị/OS) đã giải quyết bằng cách đối chiếu
> [QC — Component Editor 1.2.17.pdf](../../../specs/wallpaper-editor/component-editor/QC%20—%20Component%20Editor%201.2.17.pdf)
> — bản PDF giữ đúng bảng gốc, không bị vỡ như bản markdown. Xem bảng đã khôi phục ở mục 1 (TB-1) và mục 2A.
> Câu hỏi #2–#5 vẫn còn mở nhưng **không chặn** việc chạy test-plan (chỉ ảnh hưởng độ chính xác của vài test
> condition cụ thể — xem mục 4).

> **Test basis:** [QC — Component Editor 1.2-SUPERSEDED.md](../../../specs/wallpaper-editor/component-editor/QC%20—%20Component%20Editor%201.2-SUPERSEDED.md) — bàn giao QC nội bộ cho TestFlight 1.2.17 (103), Sep 24 2026, tác giả `@Someone`. Đối chiếu bổ sung với [bản PDF cùng tên](../../../specs/wallpaper-editor/component-editor/QC%20—%20Component%20Editor%201.2.17.pdf) để bù phần bị vỡ khi copy sang markdown (chủ yếu là bảng thiết bị/OS).
> **Tài liệu tham chiếu bổ sung (không phải test basis chính, chỉ dùng đối chiếu):**
> - [wallpaper-component-editor-wireframe.html](../../../specs/wallpaper-editor/component-editor/wallpaper-component-editor-wireframe.html) — bản đề xuất UI (status Draft, viết trước build 1.2.17). Đã tự cập nhật mục "QC — đối chiếu bản build thực tế" ngày 2026-09-24 với ảnh chụp trên nhánh `feat/component-editor`; test basis này (1.2.17) xác nhận Row/Column nesting mà wireframe từng đánh dấu "không có trong đề xuất gốc" **là tính năng thật, đã ship**.
> - [wallpaper-component-editor-prd.md](../../../specs/wallpaper-editor/component-editor/wallpaper-component-editor-prd.md) — PRD gốc, cũng Draft, §11 Open Questions chưa chốt.
> - [iphone/index.md § 03_component-editor](../../../ui/ux/screenshots/iphone/index.md) — 11 ảnh thực tế, chụp cùng ngày 2026-09-24 trên nhánh `feat/component-editor`, **build/commit chưa xác nhận** — khả năng cao cùng lứa với 1.2.17 (103) nhưng chưa đối chiếu được build number chính xác (xem mục 1, dòng cuối).
> **Chuẩn:** ISTQB Foundation Level v4.0.1 §1.4.1 (Test Analysis) + §3 (Static Testing) + §5.2 (Risk Management)
> **Bước tiếp theo:** [test-plan](../../../../.claude/skills/test-plan/SKILL.md) sẽ dùng mục 2 (test condition) làm test object và mục 2 cột risk level làm cơ sở mục 6 (risk-based prioritization) — câu hỏi #1 (mục 4) đã giải quyết nên có thể chạy test-plan ngay; các câu hỏi #2–#5 còn mở nên trả lời trước khi test-case thiết kế BVA cho vùng liên quan (TC-27, TC-28, TC-31, TC-39, TC-41) nhưng không chặn toàn bộ test-plan.
> **Ngày lập:** 2026-09-24 · **Người lập:** QC

## 1. Đánh giá testability của test basis

| # | Trích đoạn/mục | Vấn đề | Loại | Cần hỏi ai |
|---|---|---|---|---|
| TB-1 | Dòng 11–14, bảng "Máy iPhone iOS 18.x Có Nền chính \| Bắt buộc Lý do" | ~~Bảng markdown bị vỡ hoàn toàn khi paste~~ — **✅ Đã giải quyết**: đối chiếu [bản PDF gốc](../../../specs/wallpaper-editor/component-editor/QC%20—%20Component%20Editor%201.2.17.pdf) (giữ đúng bảng, không bị vỡ) khôi phục được: `iPhone iOS 18.x` → Bắt buộc **Có**, Nền chính · `iPhone iOS 26.x` → Bắt buộc **Có**, Chrome dạng glass render khác · `iPad (dọc+ngang)` → Bắt buộc **Nếu có** (optional, chỉ test khi có máy) · `iPhone iOS 27` → Bắt buộc **Không**, vì có bug Shortcut riêng (không liên quan Component Editor) khiến QC loại iOS 27 khỏi đợt này. Dòng "Shortcut" **không phải nhiễu** — là lý do thật trong bảng gốc. | Đã giải quyết (trước đây: mâu thuẫn + thiếu) | — |
| TB-2 | Dòng 137, tiêu đề "Hànhvicốý—khôngcầnreport" | Lỗi format (mất khoảng trắng) — không ảnh hưởng nội dung 7 gạch đầu dòng bên dưới, nhưng nên sửa lại nguồn cho gọn. | Mơ hồ hình thức, mức thấp — không chặn phân tích | Không cần hỏi, chỉ nên báo lại để sửa doc |
| TB-3 | Dòng 67, "kéo góc = kéo vách ngăn — cái này rộng ra thì cái bên cạnh hẹp lại đúng bằng đó" | Chỉ mô tả rõ trường hợp Row có **đúng 2 con**. Không nói hành vi khi Row có **3+ con**: chia đều bù trừ cho tất cả phần còn lại, chỉ ảnh hưởng phần tử liền kề, hay phần tử cuối cùng hấp thụ phần chênh lệch? | Thiếu | Dev (implementer tính năng resize) |
| TB-4 | Dòng 69, "Không kéo được nhỏ hơn mức tối thiểu (không co về 0)" | Không nêu giá trị tối thiểu cụ thể (pt hay %). Cần cho BVA ở bước test-case. | Thiếu (giá trị biên) | Dev/design |
| TB-5 | Dòng 77, "nó có lề hai bên sẵn (giống Studio)" | "Studio" là tham chiếu nội bộ không định nghĩa trong tài liệu này (công cụ khác? phiên bản trước?) — người đọc ngoài team có thể không hiểu. Không có giá trị lề cụ thể. | Mơ hồ + thiếu giá trị | Tác giả / design |
| TB-6 | Dòng 97–99, "Tối đa 3 cấp container. Ví dụ hợp lệ: Column > Row > Column" | Không rõ cấp được đếm từ đâu: canvas gốc (ngoài cùng, không phải Row/Column) có tính là 1 cấp không, hay chỉ đếm số lớp Row/Column lồng nhau? Ảnh hưởng điểm chính xác mà hệ thống chặn thêm container thứ 4. | Mơ hồ | Dev, hoặc xác nhận qua exploratory trước khi chốt test-case |
| TB-7 | Toàn bộ file vs. batch ảnh `iphone/index.md § 03_component-editor` | Test basis ghi rõ build **TestFlight 1.2.17 (103)**; batch ảnh QC đã chụp trước đó trong phiên làm việc này lấy từ nhánh `feat/component-editor`, **build/commit chưa xác nhận qua công cụ**. Cùng ngày (2026-09-24) nên khả năng cao là cùng lứa, nhưng chưa có bằng chứng build number khớp nhau. | Thiếu (traceability) | Không chặn — chỉ cần re-confirm build number khi có dịp chụp lại |

## 2. Test condition đã ưu tiên hoá

> Risk level = Likelihood × Impact (Thấp/Vừa/Cao mỗi trục) → quy đổi Ưu tiên: **Cao → P1, Vừa → P2, Thấp → P3**.
> Điều kiện đánh dấu **TBD** chưa gán được risk chính xác do phụ thuộc câu hỏi mở ở mục 4 — test-plan không nên tự chốt scope cho các dòng này trước khi có câu trả lời.

### A. Môi trường & đường vào (nguồn: dòng 16–20)

| # | Test condition | Loại | Likelihood | Impact | Risk | Ưu tiên |
|---|---|---|---|---|---|---|
| TC-01 | Nút Components (icon layers, cạnh crop) chỉ hiện với template dạng stack, ẩn với template cũ | Functional | Vừa | Cao | Cao | P1 |
| TC-02 | Nút Components đặt đúng vị trí trên header (cạnh nút crop) | Functional | Thấp | Thấp | Thấp | P3 |
| TC-03 | Mở màn full-screen: header đủ ✕/Undo/Redo/✓, đáy đủ nút + và Show grid | Functional | Thấp | Cao | Vừa | P2 |
| TC-04 | Lần đầu vào: coach mark "Tap to edit a piece" hiện và bấm bỏ qua được | Usability | Thấp | Thấp | Thấp | P3 |

### A2. Phạm vi thiết bị/OS (bổ sung sau khi đối chiếu PDF gốc — trước đây TB-1/TC-58 ở dạng TBD)

> Ma trận đầy đủ: xem TB-1 ở mục 1. Tóm tắt scope: **bắt buộc** iPhone iOS 18.x + iPhone iOS 26.x · **nếu có** thì test thêm iPad (dọc+ngang) · **không** cần test iPhone iOS 27 đợt này (bug Shortcut riêng, ngoài phạm vi feature).

| # | Test condition | Loại | Likelihood | Impact | Risk | Ưu tiên |
|---|---|---|---|---|---|---|
| TC-69 | Toàn luồng Component Editor hoạt động đúng trên **iPhone iOS 18.x** (baseline bắt buộc, "Nền chính") | Compatibility | Thấp | Cao | Vừa | P2 |
| TC-70 | Toàn luồng Component Editor hoạt động đúng trên **iPhone iOS 26.x**, đặc biệt chrome dạng glass render đúng (iOS 26 vẽ khác bản khác) | Compatibility | Vừa | Cao | Cao | P1 |

### B. Chọn thành phần (dòng 22–34)

| # | Test condition | Loại | Likelihood | Impact | Risk | Ưu tiên |
|---|---|---|---|---|---|---|
| TC-05 | Chạm 1 thành phần (không trong container) → hiện khung viền + pill "Edit component / Delete component" | Functional | Vừa | Cao | Cao | P1 |
| TC-06 | Chạm ra vùng trống → bỏ chọn, pill biến mất | Functional | Vừa | Vừa | Vừa | P2 |
| TC-07 | Chạm thành phần trong Row/Column lần 1 → chọn cả container, KHÔNG chọn thẳng con | Functional | Cao | Cao | Cao | P1 |
| TC-08 | Chạm tiếp vào đúng con bên trong container đã chọn → chọn con (đi sâu từng cấp) | Functional | Cao | Cao | Cao | P1 |
| TC-09 | Khung viền chọn ôm đúng kích thước thật của thành phần, kể cả đã bị thu nhỏ (không to hơn nội dung) | Functional | Vừa | Vừa | Vừa | P2 |
| TC-10 | "Edit component" trên pill mở đúng bảng thuộc tính của thành phần đang chọn | Functional | Thấp | Cao | Vừa | P2 |
| TC-11 | "Delete component" xoá thành phần, hiện toast "Removed …" kèm Undo | Functional | Vừa | Cao | Cao | P1 |
| TC-12 | Bấm Undo trên toast Removed → thành phần quay lại đúng vị trí cũ | Reliability | Vừa | Cao | Cao | P1 |

### C. Di chuyển — kéo (dòng 38–50, vùng "sửa đi sửa lại nhiều nhất")

| # | Test condition | Loại | Likelihood | Impact | Risk | Ưu tiên |
|---|---|---|---|---|---|---|
| TC-13 | Giữ và kéo → thành phần đi theo ngón tay ngay lập tức, không có độ trễ cảm nhận được | Performance efficiency | Cao | Cao | Cao | P1 |
| TC-14 | Kéo lên/xuống trong stack/column: không đè lên thành phần phía trên, có chặn trên và dưới đúng vùng nội dung | Functional | Cao | Cao | Cao | P1 |
| TC-15 | Kéo ngang: dịch trái/phải trong phạm vi cho phép, không vượt biên | Functional | Vừa | Vừa | Vừa | P2 |
| TC-16 | Kéo cả 1 Row/Column: toàn bộ con đi theo đúng 1 lần, không trễ hơn khung viền, không văng ra ngoài | Functional | Cao | Cao | Cao | P1 |
| TC-17 | Trong lúc kéo KHÔNG xuất hiện bản sao chồng lên nhau (component hiện 2 lần đè nhau) | Reliability | Vừa | Cao | Cao | P1 |
| TC-18 | Trong lúc kéo KHÔNG có hiện tượng thành phần biến mất rồi hiện lại khi nhả tay | Reliability | Vừa | Cao | Cao | P1 |
| TC-19 | Nhả tay → render lại đúng 1 lần tại vị trí thả, không nhảy về chỗ cũ rồi nhảy lại | Reliability | Cao | Cao | Cao | P1 |

### D. Đổi bề rộng — kéo góc (dòng 55–69)

| # | Test condition | Loại | Likelihood | Impact | Risk | Ưu tiên |
|---|---|---|---|---|---|---|
| TC-20 | 4 góc là vùng kéo hợp lệ dù không vẽ chỉ báo hình tròn (hit target ẩn) | Usability | Vừa | Vừa | Vừa | P2 |
| TC-21 | Kéo góc phải → chỉ mép phải di chuyển, cạnh trái đứng yên | Functional | Vừa | Cao | Cao | P1 |
| TC-22 | Kéo góc trái → chỉ mép trái di chuyển, cạnh phải đứng yên | Functional | Vừa | Cao | Cao | P1 |
| TC-23 | Bề rộng cập nhật realtime theo ngón tay, không chờ nhả tay | Performance efficiency | Vừa | Vừa | Vừa | P2 |
| TC-24 | Nhả tay sau kéo góc → không có thay đổi kích thước thêm lần nữa | Reliability | Vừa | Vừa | Vừa | P2 |
| TC-25 | Thành phần ngoài cùng (không trong container): kéo góc đổi bề rộng và vẫn canh giữa | Functional | Vừa | Vừa | Vừa | P2 |
| TC-26 | Thành phần trong Row **2 con**: kéo góc A → B liền kề co/giãn bù đúng bằng đó, tổng bề rộng Row không đổi | Functional | Cao | Cao | Cao | P1 |
| TC-27 | Thành phần trong Row **3+ con**: hành vi phân bổ bù trừ khi kéo góc 1 phần tử | Functional | **TBD** | **TBD** | **TBD — chờ câu hỏi #2** | — |
| TC-28 | Không kéo được nhỏ hơn mức tối thiểu (giá trị cụ thể chờ câu hỏi #3) — xác nhận có chặn, chưa xác nhận đúng ngưỡng | Functional | Vừa | Vừa | Vừa | P2 |

### E. Thêm thành phần / Row / Column (dòng 73–93)

| # | Test condition | Loại | Likelihood | Impact | Risk | Ưu tiên |
|---|---|---|---|---|---|---|
| TC-29 | Bấm + → sheet Add component hiện đủ 6 nhóm: Calendar, Events, Tasks, Progress, Text, Layout | Functional | Thấp | Vừa | Thấp | P3 |
| TC-30 | Chọn 1 loại bất kỳ trong sheet → thêm thành công, toast "Added …" + Undo | Functional | Thấp | Cao | Vừa | P2 |
| TC-31 | Thành phần mới có lề 2 bên mặc định, không chiếm full-width | Functional | Vừa | Thấp | Thấp | P3 |
| TC-32 | Đang chọn 1 thành phần (không phải container) rồi bấm + → thành phần mới rơi ngay dưới thành phần đang chọn | Functional | Vừa | Vừa | Vừa | P2 |
| TC-33 | Đang chọn 1 Row/Column rồi bấm + → thành phần mới rơi vào TRONG container đó | Functional | Vừa | Vừa | Vừa | P2 |
| TC-71 | **Đang KHÔNG chọn gì** rồi bấm + → thành phần mới chèn vào **giữa canvas (center)** — trường hợp thứ 3 ngoài 2 case TC-32/33, xác nhận qua trao đổi trực tiếp với dev 2026-09-24 (test basis dòng 79–81 không mô tả case này) | Functional | Vừa | Vừa | Vừa | P2 |
| TC-34 | Thêm Row → hiện 1 hàng gồm 2 ô trống nét đứt, mỗi ô có nút + riêng, nằm cạnh nhau | Functional | Thấp | Vừa | Thấp | P3 |
| TC-35 | Thêm Column → hiện 2 ô trống nét đứt xếp dọc | Functional | Thấp | Vừa | Thấp | P3 |
| TC-36 | Bấm + trong 1 ô trống của Row/Column → chỉ ô đó được lấp, ô còn lại giữ nguyên (regression đã fix gần đây) | Functional | Cao | Cao | Cao | P1 |
| TC-37 | Bấm vào nền ô trống (không trúng nút +) → chọn container, KHÔNG mở sheet Add component | Functional | Vừa | Vừa | Vừa | P2 |
| TC-38 | Lấp đủ 2 ô của Row/Column → không còn ô trống thừa hiển thị | Functional | Thấp | Vừa | Thấp | P3 |

### F. Giới hạn lồng nhau & container rỗng (dòng 97–107)

| # | Test condition | Loại | Likelihood | Impact | Risk | Ưu tiên |
|---|---|---|---|---|---|---|
| TC-39 | Ở cấp lồng thứ 3 (tối đa), mở Add component → nhóm Layout biến mất, các nhóm khác vẫn còn | Functional | Vừa | Vừa | Vừa | P2 |
| TC-40 | Ở cấp 1–2, nhóm Layout vẫn hiện đầy đủ trong Add component | Functional | Thấp | Vừa | Thấp | P3 |
| TC-41 | Thêm container ngang hàng (sibling) ở cấp còn cho phép vẫn được, không bị tính dồn vào độ sâu | Functional | Vừa | Vừa | Vừa | P2 |
| TC-42 | Thêm Row/Column rồi không lấp gì, bấm ✓ → container rỗng tự động bị xoá, toast "Removed the empty layout" kèm Undo | Functional | Vừa | Vừa | Vừa | P2 |
| TC-43 | Bấm Undo trên toast "Removed the empty layout" → container rỗng quay lại đúng vị trí | Reliability | Vừa | Vừa | Vừa | P2 |

### G. Bảng thuộc tính, Undo, lưu (dòng 111–135)

| # | Test condition | Loại | Likelihood | Impact | Risk | Ưu tiên |
|---|---|---|---|---|---|---|
| TC-44 | Position: chuyển Auto ↔ Fixed, thành phần KHÔNG tự nhảy vị trí ngay khi đổi | Functional | Vừa | Cao | Cao | P1 |
| TC-45 | Chọn Fixed → hiện thanh "Vertical position", kéo thì thành phần chạy dọc theo đúng tỉ lệ | Functional | Vừa | Vừa | Vừa | P2 |
| TC-46 | Thanh Width trong bảng thuộc tính khớp giá trị với thao tác kéo góc trên canvas (đồng bộ 2 chiều) | Functional | Vừa | Vừa | Vừa | P2 |
| TC-47 | Thanh Size chỉ hiện với thành phần NGOÀI CÙNG (không nằm trong Row/Column) | Functional | Thấp | Vừa | Thấp | P3 |
| TC-48 | Thành phần trong Row/Column KHÔNG có thanh Size (đúng thiết kế, không phải thiếu) | Functional | Thấp | Thấp | Thấp | P3 |
| TC-49 | Knob riêng theo loại thành phần (màu, phông, số dòng…) đổi được và cập nhật ngay trên canvas | Functional | Vừa | Vừa | Vừa | P2 |
| TC-50 | Duplicate / Delete / Deselect trên bảng thuộc tính chạy đúng chức năng | Functional | Vừa | Vừa | Vừa | P2 |
| TC-51 | Undo hoàn tác đúng 1 thao tác trọn vẹn (1 lần kéo = 1 bước, không phải từng frame) | Reliability | Cao | Cao | Cao | P1 |
| TC-52 | Redo làm lại đúng thao tác vừa Undo | Reliability | Vừa | Vừa | Vừa | P2 |
| TC-53 | Bấm ✓ (Done) → quay lại màn editor gốc, giữ nguyên bố cục mới | Functional | Vừa | Cao | Cao | P1 |
| TC-54 | Bấm ✕ (Cancel) → toàn bộ thay đổi trong phiên bị bỏ, kể cả thành phần vừa thêm mới. **Xác nhận thực tế 2026-09-24: KHÔNG có dialog xác nhận, thoát thẳng ngay** — đúng như test basis dòng 127 mô tả (không nhắc dialog nào), không phải bug theo spec. Nhưng khác S02 (có popup "Discard changes?" cho cùng loại hành động mất dữ liệu) — xem câu hỏi #9 mục 10 test-plan, QA khuyến nghị bổ sung | Functional / Usability | Vừa | Cao | Cao | P1 |
| TC-55 | Show grid bật/tắt lưới canh; lưới KHÔNG cản trở/đè lên thao tác kéo (hit-testing) | Functional | Vừa | Vừa | Vừa | P2 |
| TC-56 | Thành phần tràn ra ngoài màn → hiện cảnh báo "Part of this runs off the screen"; kéo về trong thì cảnh báo tự mất | Functional | Vừa | Vừa | Vừa | P2 |
| TC-57 | Nút ẩn/hiện chrome: ẩn hết control để xem wallpaper sạch, chạm lại hiện lại đầy đủ | Functional | Thấp | Thấp | Thấp | P3 |
| TC-58 | Xoay iPad: khung viền chọn và các ô trống Row/Column vẫn khớp, không lệch — chỉ bắt buộc **nếu có máy iPad khả dụng** (ma trận thiết bị ghi "Nếu có"), không có máy thì skip, không chặn release | Portability | Vừa | Vừa | Vừa | P2 |

### H. Bản địa hoá (dòng 9)

| # | Test condition | Loại | Likelihood | Impact | Risk | Ưu tiên |
|---|---|---|---|---|---|---|
| TC-59 | String mới hiển thị đúng ngôn ngữ máy (VI/EN tối thiểu; đủ 12 ngôn ngữ theo khai báo) — không lọt tiếng Anh vào máy tiếng Việt | Internationalization | Vừa | Vừa | Vừa | P2 |

### I. Regression ngoài màn editor (dòng 158–170) — "ghi thẳng vào dữ liệu wallpaper"

| # | Test condition | Loại | Likelihood | Impact | Risk | Ưu tiên |
|---|---|---|---|---|---|---|
| TC-60 | Đặt bố cục vừa sửa làm màn khoá thật → wallpaper render đúng bố cục đã sửa (không chỉ đúng trên preview trong editor) | Reliability | Vừa | Cao | Cao | P1 |
| TC-61 | Live Activity của template đã sửa vẫn chạy đúng, không vỡ layout | Functional | Vừa | Cao | Cao | P1 |
| TC-62 | Widget và thumbnail trong "Your collection" cập nhật theo bố cục mới | Functional | Vừa | Cao | Cao | P1 |
| TC-63 | Mở lại template đã sửa → bố cục giữ nguyên đúng như đã lưu, sửa tiếp được | Reliability | Vừa | Cao | Cao | P1 |
| TC-64 | Các template lịch cũ (chưa từng mở bằng Component Editor) vẫn render y như trước, không bị ảnh hưởng ngoài ý muốn | Reliability | Thấp | Cao | Vừa | P2 |
| TC-65 | Wallpaper dạng Note (không phải lịch) không bị ảnh hưởng bởi tính năng này | Functional | Thấp | Vừa | Thấp | P3 |
| TC-72 | Vừa chỉnh bố cục ở Component Editor (S03) vừa trang trí ở Decorate (S02) trên **cùng 1 template** → wallpaper cuối cùng (S01 `filled` / lock screen thật) render **đầy đủ cả 2 phần**, không mất/đè lẫn nhau — xác nhận qua dev 2026-09-24: 2 tính năng độc lập về dữ liệu, nhưng **kết quả cuối phải gộp đủ cả 2** | Reliability | Vừa | Cao | Cao | P1 |
| TC-73 | 🔴 Bố cục Component Editor đã lưu → **chờ qua đêm** để automation Shortcut chạy lại (wallpaper tự render mỗi sáng) → bố cục **bắt buộc phải sống sót và cập nhật đầy đủ** (không bị mất/reset về bố cục gốc) — xác nhận qua dev 2026-09-24: **bắt buộc**, không phải "nếu được". Test basis không có case cụ thể cho automation overnight, nhưng đây là case **quan trọng nhất của cả nhóm REG** theo đúng tiền lệ `DEC-Q01` (Decorate) — quyết định giá trị cốt lõi: nếu không sống sót, bố cục tuỳ chỉnh chỉ dùng được đúng 1 lần. **Phải test qua đêm thật, không rút ngắn bằng đổi giờ hệ thống** (cùng cảnh báo đã áp dụng cho `DEC-E12` và `shortcut-flow-cases §10`) | Reliability | Vừa | Cao | Cao | P1 |

### J. Hành vi cố ý — xác nhận đúng như tài liệu, tránh báo nhầm lỗi (dòng 142–154)

| # | Test condition | Loại | Likelihood | Impact | Risk | Ưu tiên |
|---|---|---|---|---|---|---|
| TC-66 | Trong lúc kéo, chữ trong thành phần không xuống dòng lại, chiều cao không đổi (chỉ co giãn theo hình); nhả tay mới chỉnh lại đúng | Functional (xác nhận cố ý) | Thấp | Thấp | Thấp | P3 |
| TC-67 | Thẻ nền của container không đổi theo từng frame khi đang kéo, chỉ thành phần con đổi | Functional (xác nhận cố ý) | Thấp | Thấp | Thấp | P3 |
| TC-68 | Row/Column chỉ có 1 con vẫn chiếm chỗ như đang có 2 con (ô trống thứ 2 giữ chỗ) | Functional (xác nhận cố ý) | Thấp | Thấp | Thấp | P3 |

## 3. Traceability nháp

| Test condition # | Mục test basis (dòng) | Ghi chú cho test-plan |
|---|---|---|
| TC-01 – TC-04 | "Môi trường và đường vào", dòng 16–20 | Gợi ý test object **TO-ENTRY**. TC-01 nên là smoke test đầu tiên của cả bộ — gate cho mọi condition khác. |
| TC-69 – TC-70 | Bảng thiết bị/OS, dòng 11–14 (khôi phục từ PDF) | Gợi ý **TO-ENTRY** (gộp chung compatibility) hoặc tách riêng **TO-DEVICE-MATRIX** nếu test-plan muốn track coverage theo device riêng. |
| TC-05 – TC-12 | "Chọn thành phần", dòng 22–34 | Gợi ý **TO-SELECT**. TC-07/TC-08 nên thiết kế Decision Table riêng cho các cấp lồng (0/1/2/3) vì đây là hành vi cố ý dễ hiểu nhầm là lỗi. |
| TC-13 – TC-19 | "Di chuyển (kéo)", dòng 38–50 | Gợi ý **TO-DRAG**. Toàn bộ nhóm risk Cao — test-plan nên ưu tiên thiết bị thật (không simulator) vì đây là cử chỉ, và test riêng với layout Row lồng trong Column như ghi chú dòng 38 yêu cầu. |
| TC-20 – TC-28 | "Đổi bề rộng (kéo góc)", dòng 55–69 | Gợi ý **TO-RESIZE**. TC-27/TC-28 chờ câu hỏi #2, #3 trước khi thiết kế BVA ở test-case. |
| TC-29 – TC-38, TC-71 | "Thêm thành phần, Row và Column", dòng 73–93 | Gợi ý **TO-ADD**. TC-36 nên có ghi chú "regression — lỗi cũ vừa fix" trong test-case để dễ trace lại nếu tái phát. TC-71 xác nhận qua dev, không có trong test basis gốc — ghi rõ nguồn là "trao đổi trực tiếp" trong test-case. |
| TC-39 – TC-43 | "Giới hạn lồng nhau và container rỗng", dòng 95–107 | Gợi ý **TO-NEST**. TC-39/TC-41 chờ câu hỏi #5 để xác định chính xác biên "cấp 3". |
| TC-44 – TC-58 | "Bảng thuộc tính, Undo và lưu", dòng 109–135 | Gợi ý **TO-PROPS**. TC-58 chờ câu hỏi #1. |
| TC-59 | dòng 9 | Gợi ý **TO-L10N**, có thể gộp chung với các test plan localization khác của app nếu đã có sẵn ở nơi khác. |
| TC-60 – TC-65, TC-72, TC-73 | "Regression cần rà lại", dòng 158–170 | Gợi ý **TO-REGRESSION**. Toàn bộ nhóm nên chạy sau khi TO-DRAG/TO-RESIZE/TO-ADD pass, không chạy song song — regression phụ thuộc kết quả các nhóm trên đã lưu đúng. TC-72/TC-73 xác nhận qua dev, không có trong test basis gốc — ghi rõ nguồn "trao đổi trực tiếp" trong test-case. **TC-73 nên chạy sớm nhất trong nhóm** (bắt đầu qua đêm ngay khi có bố cục đầu tiên để lưu) vì cần thời gian chờ dài nhất. |
| TC-66 – TC-68 | "Hành vi cố ý — không cần report", dòng 137–154 | Gợi ý **TO-INTENDED**, ưu tiên thấp — chủ yếu để QA lead dùng huấn luyện tester mới, tránh report nhầm. |

## 4. Câu hỏi cần làm rõ trước khi lập test plan

1. ~~**[Chặn — ảnh hưởng TC-01, TC-58]** Bảng "Máy / iOS bắt buộc" bị vỡ định dạng~~ — **✅ Đã giải quyết** bằng cách đối chiếu [bản PDF gốc](../../../specs/wallpaper-editor/component-editor/QC%20—%20Component%20Editor%201.2.17.pdf). Scope thật: bắt buộc iPhone iOS 18.x + iPhone iOS 26.x, iPad "nếu có" (optional), iPhone iOS 27 ngoài phạm vi đợt này (bug Shortcut riêng, không liên quan). Xem TB-1, TC-58, TC-69, TC-70.
2. **[Ảnh hưởng TC-27]** Trong 1 Row có 3+ thành phần con, kéo góc đổi bề rộng 1 phần tử thì các phần tử còn lại bù trừ thế nào — chia đều, chỉ ảnh hưởng phần tử liền kề, hay phần tử cuối cùng?
3. **[Ảnh hưởng TC-28]** Giá trị bề rộng tối thiểu cụ thể (pt hoặc %) khi kéo góc thu nhỏ là bao nhiêu?
4. **[Ảnh hưởng TC-31]** "Giống Studio" ở dòng 77 nghĩa là gì, và giá trị lề 2 bên mặc định của thành phần mới thêm là bao nhiêu?
5. **[Ảnh hưởng TC-39, TC-41]** "Tối đa 3 cấp container" — canvas gốc (ngoài cùng) có tính là 1 cấp không, hay chỉ đếm số lớp Row/Column lồng nhau? Cần biết chính xác để xác nhận điểm hệ thống chặn thêm container thứ 4.
