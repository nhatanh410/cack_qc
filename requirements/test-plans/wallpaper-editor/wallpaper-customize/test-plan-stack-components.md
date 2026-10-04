# Test Plan — Component lịch mới & knob mới (stack) · slug `stack-components`

> ✅ **Test Plan Status: `READY` — CÓ ĐIỀU KIỆN** *(kế thừa từ Analysis Status `READY` có điều kiện, tuyên bố
> bởi **user/chủ repo** ngày 2026-10-03, ghi trong banner đầu
> [test-analysis-stack-components.md](test-analysis-stack-components.md). Agent `qc-test-plan` **không tự nâng
> trạng thái** — chỉ đối chiếu theo bảng quy tắc của
> [`.claude/rules/testing.md`](../../../../.claude/rules/testing.md) và tái xác nhận rằng không phát sinh gap
> mới ở mức test-plan đủ để hạ trạng thái. **Quyết định gọi `test-case` tiếp theo thuộc orchestrator**, không
> thuộc agent này.)*
>
> **Vì sao không hạ xuống `DRAFT`/`BLOCKED`:** mục 10 dưới đây không có gap **mới phát sinh ở mức test-plan**
> làm đổi scope/priority của 87 condition đã có; 2 `GAP` còn lại (`SC-G3`, `SC-G8`) đã được test-analysis xử lý
> dứt điểm là "không sinh test case" (không phải ambiguity 2-cách-hiểu còn treo) — đúng tiền lệ
> `TC117-G4`/`TC117-165` của bộ [`tf-117`](test-plan-tf-117.md).
>
> ### 4 điều kiện bắt buộc — mang nguyên từ test-analysis, KHÔNG được bỏ bớt
>
> 1. **Nhóm M · N · O · P (14 condition: SC-76…SC-88) KHÔNG có requirement trong test basis
>    `stack-components.md`.** Oracle là [component-editor.md](../../../specs/wallpaper-editor/wallpaper-customize/component-editor.md)
>    (tài liệu **đối chiếu**) + quyết định phạm vi của user (O-24, O-25). Mục 2 dưới đây ghi rõ nguồn gốc này
>    cho từng nhóm — **không** trình bày như requirement của test basis. *(Đúng tiền lệ nhóm R/S của bộ tf-117.)*
> 2. **7 vùng Exploratory (EX-1…EX-7) KHÔNG có expected result ⇒ KHÔNG chứng minh được pass.** Báo cáo kết quả
>    thực thi sau này **bắt buộc tách bạch** "scripted" (~80 condition) và "exploratory" (7 condition) —
>    **cấm** gộp thành một con số coverage duy nhất (xem mục 2, mục 5.20, mục 9).
> 3. **Privacy khi share (nhóm SHR, SC-71/72/73/89) chỉ kiểm ở MỨC UI của người nhận.** Mức payload/network là
>    `SC-G8` — **CHƯA TEST**, giữ nhãn `GAP`. **Cấm** phát biểu "privacy đã test đầy đủ"; phát biểu đúng duy
>    nhất: *"đã kiểm ở mức hiển thị UI phía người nhận; mức payload/network chưa nằm trong phạm vi đợt này."*
> 4. **Mọi quyết định mở/thu hẹp phạm vi (Q-1, Q-2, Q-3 đợt 1; O-1/O-7/O-24/O-25/O-27/O-29 đợt 2; O-31/O-33 đợt
>    3) là quyết định của USER — dev CHƯA xác nhận.** Không nâng thành fact. Riêng **SC-23** (Reset Workout)
>    giữ nguyên ô ghi chú: *"nếu thực thi thấy kế hoạch tập bị xoá ⇒ REPORT BUG NGAY"*, không phải lỗi test
>    case (mục 2, nhóm WKT).
>
> ### 3 câu hỏi mở mang sang dạng ⚠️ — KHÔNG chặn, nhưng không được coi là đã đóng
>
> **O-23** (chưa có baseline ảnh render thật cho bất kỳ component mới nào — chỉ có 3 ảnh sheet Add) ·
> **O-30** (chưa rõ 6/7 component mới nào được hỗ trợ ở Live Activity/widget/thumbnail — ảnh hưởng SC-77,
> SC-78) · **O-32** (chưa có ngưỡng hiệu năng định lượng + tập máy tối thiểu — ảnh hưởng SC-83, SC-84, EX-5).
>
> ### 🚩 Một điểm QC phát hiện thêm ở mức test-plan — chưa có trong 3 câu ⚠️ nêu trên
>
> **O-26** (test-analysis mục 4B, **chưa được trả lời** ở cả 3 đợt) — 3 condition §11 (SC-71, SC-72, SC-73)
> **chưa chốt thuộc bộ test nào**: đợt này (`stack-components`) hay bộ [share-template-link](../../share-template-link/)
> slug `1-2-19` (cùng build 1.2.19). QC đã đối chiếu trực tiếp
> [template-sharing-api.md](../../../specs/share-template-link/template-sharing-api.md) và
> [test-plan-1-2-19.md](../../share-template-link/test-plan-1-2-19.md): bộ đó **chỉ** kiểm strip ở mức
> *"selected calendars, note id, album id, rotation clock"* (nhóm `ST-E`/`TS-29`), **không** nhắc Milestones,
> Event tickets hay Workout. Hai bộ test **không chồng lắp nội dung**, nhưng **chưa ai xác nhận bằng văn bản
> ai là owner** của SC-71/72/73/89 — rủi ro là **không bộ nào** chạy case này nếu mỗi bên đều giả định "bên
> kia lo". Ghi vào mục 10 (Gap) + mục 7 (Dependencies), **không** tự nhận owner thay người review.

---

> **Test basis (duy nhất):** [stack-components.md](../../../specs/wallpaper-editor/wallpaper-customize/stack-components.md) — toàn bộ §1–§12.
> **Test analysis (input chính):** [test-analysis-stack-components.md](test-analysis-stack-components.md) —
> **87 test condition đã ưu tiên hoá** (P1 44 · P2 24 · P3 19) + 2 `GAP` (`SC-G3`, `SC-G8`) + 7 Exploratory
> (EX-1…EX-7); dùng trực tiếp mục 2 làm test object và cột Risk level làm cơ sở risk-based prioritization,
> **không phân tích lại**.
> **Chuẩn:** ISTQB Foundation Level v4.0.1 [§5.2](../../../istqb-foundation/ISTQB_CTFL_Syllabus_v4.0.1.md) (Risk
> Management) + §4.1/§4.2/§4.4 (Test Techniques) + §5.1.3 (Entry/Exit Criteria) + §5.1.5 (Prioritization).
> **Test case cụ thể:** [test-cases-stack-components.md](test-cases-stack-components.md) — *chưa tồn tại*; sẽ
> sinh bởi skill `test-case` **nếu và chỉ nếu** orchestrator xác nhận Test Plan Status = READY.
> **Đối chiếu tài liệu đã có (KHÔNG phải test basis):**
> - [component-editor.md](../../../specs/wallpaper-editor/wallpaper-customize/component-editor.md) — oracle
>   nguồn cho nhóm **RGT, MIG, PRF, NST** (điều kiện 1) + ma trận môi trường iOS 18.x/26.x.
> - [test-analysis-tf-117.md](test-analysis-tf-117.md) · [test-plan-tf-117.md](test-plan-tf-117.md) — bộ test
>   **READY (có điều kiện)** cho cơ chế chung của màn Customize (kéo/resize/reorder/Add/Row-Column); dùng lại
>   **phương pháp**, không dùng lại kết luận. Mã nhóm của file này **cố ý khác tiền tố** với tf-117 (vd `AGD`
>   khác `ADD`) để tránh nhầm khi 2 bộ `TC-xxx-NN` nằm cạnh nhau trong cùng thư mục.
> - [template-sharing-api.md](../../../specs/share-template-link/template-sharing-api.md) ·
>   [test-plan-1-2-19.md](../../share-template-link/test-plan-1-2-19.md) — hợp đồng API + bộ test share
>   template **cùng build 1.2.19**; liên quan trực tiếp nhóm **SHR** (xem 🚩 ở banner).
> - [screenshots iPhone · index.md](../../../ui/ux/screenshots/iphone/index.md) mục `14_edit-wallpaper` batch 8
>   + 3 ảnh `add-component-v2 / -scrolled-v2 / -scrolled-v3` — **bằng chứng duy nhất**, chỉ chụp sheet Add,
>   **không có** ảnh component nào đã render trên canvas (O-23).
> **Ngày lập:** 2026-10-03 · **Người lập:** QC (agent `qc-test-plan`)

---

## 1. Phát hiện khi đối chiếu với tài liệu đã có

### 1.1 Đây là bản test-plan ĐẦU TIÊN của slug `stack-components` — không có "V-cũ → V-mới"

Không có test-plan trước đó cho đúng phạm vi "6 component mới + knob mới" này. Thư mục đã có
[test-plan-tf-117.md](test-plan-tf-117.md) nhưng phạm vi của nó là **cơ chế** của màn Customize (kéo, resize,
reorder, Add, Row/Column, Undo/Redo, Layers, Decorate) — hoàn toàn khác đối tượng với test-plan này (**nội
dung/hành vi riêng của từng component mới**). Hai bộ **bổ sung cho nhau**, không chồng lấn: tf-117 trả lời
"cơ chế sắp xếp hoạt động đúng không", bộ này trả lời "từng component mới hiển thị/tính toán đúng không".

### 1.2 Nhóm M–P không đến từ test basis — nhắc lại nguyên nhân, không lặp lại toàn bộ lý luận

Test-analysis đã kiểm chứng và ghi rõ: câu *"vùng ảnh hưởng là toàn bộ wallpaper lịch…"* mà user viện dẫn để mở
rộng phạm vi (O-24/O-25) **nằm ở component-editor.md dòng 7–9, không có trong `stack-components.md`**. QC đọc
lại cả hai tài liệu ở lượt này và **xác nhận lại đúng kết luận đó** (đã grep lần 2, không khớp "vùng ảnh
hưởng", "Live Activity", "thumbnail" trong test basis). Test-plan áp dụng nguyên quyết định phạm vi của user —
xem mục 2, nhóm RGT/MIG/PRF/NST ghi rõ cột "Nguồn".

### 1.3 Đối chiếu với bộ `tf-117` — không dùng lại case, chỉ dùng lại khung môi trường

`component-editor.md` §1 (môi trường: iPhone iOS 18.x bắt buộc, iOS 26.x bắt buộc vì chrome glass, iPad nếu có)
là tài liệu nền chung cho cả `tf-117` và bộ này — màn Customize không đổi giữa hai đợt. Test-plan này **kế
thừa** đúng ma trận môi trường đó (mục 7) vì test basis `stack-components.md` **không tự có** bảng môi trường
riêng (TB-05) — đây là suy luận của QC từ tài liệu đối chiếu, **không phải** acceptance criteria của chính
`stack-components.md`.

### 1.4 Đối chiếu bằng chứng ảnh — không có baseline cho bất kỳ nội dung nào

Giống kết luận TB-26 của test-analysis: 3 ảnh batch 8 hiện có trong
[index.md](../../../ui/ux/screenshots/iphone/index.md) chỉ chụp **sheet Add component** (tồn kho 23 mục),
không có ảnh nào của Agenda/Event tickets/Workout/Daily page/Today at a glance/Milestones/Month heatmap **đã
render trên canvas**. Test-plan không tự chụp bổ sung (ngoài phạm vi của agent này) — ghi là entry criterion
(mục 8, E2) và limitation (mục 11, #1).

---

## 2. Test object — In scope

> **15 test object**, ánh xạ **1-1 không chồng lắp** từ 87 test condition của test-analysis mục 2 (nhóm A–P +
> sổ GAP + sổ Exploratory). Mã nhóm là tiền tố ID mà skill `test-case` sẽ dùng (`TC-<MÃ>-NN`) — **cố ý đặt
> khác** tiền tố của `tf-117` để không nhầm khi đọc 2 bộ case cạnh nhau. Cột **Nguồn gốc** phân biệt rõ
> "test basis trực tiếp" với "tài liệu đối chiếu + quyết định phạm vi của user" (điều kiện 1).

| # | Test object | Mã nhóm | SC-... | Nguồn gốc | P1 | P2 | P3 | Gap/Exploratory |
|---|---|---|---|---|---|---|---|---|
| 1 | Sheet Add component & tồn kho (6 component mới + `Month heatmap`) | **INV** | 01–04, 74, 75 | §1.04 test basis + **Q-1=A** (user) cho SC-74/75 | 2 | 3 | 1 | ⚠️ SC-74/75 chỉ phủ "tồn tại & thêm được"; hành vi sâu `Month heatmap` = 🔭 **EX-3** |
| 2 | Agenda | **AGD** | 05–10 | §2.01–§2.04 | 2 | 3 | 1 | ⚠️ TB-08 (thiếu biên Days/Events per day) · TB-09 (SC-08 thiếu điều kiện kích hoạt) |
| 3 | Event tickets | **TKT** | 11–16 | §3.01–§3.04 | 5 | 1 | 0 | 🔭 **EX-2** (SC-12, đường vào "ghim" chưa rõ) · ⚠️ TB-11 (SC-14/16 thiếu ngưỡng tương phản) |
| 4 | Workout | **WKT** | 17–23 | §4.01–§4.05 | 2 | 3 | 2 | **SC-23**: expected result theo đúng §4.05 (Q-2, user) — *"thấy kế hoạch tập bị xoá ⇒ REPORT BUG"* |
| 5 | Daily page | **DLP** | 24–28 | §5.01–§5.04 | 3 | 1 | 1 | ⚠️ TB-12 (SC-25 chưa định nghĩa "ngày rảnh") · TB-13 (SC-27 danh sách vùng bỏ lửng) |
| 6 | Today at a glance | **TAG** | 29–33 | §6.01–§6.03 | 4 | 0 | 1 | ⚠️ TB-14 (SC-32 DST — chưa có phương tiện dựng) · TB-15 (SC-33 thiếu thuật toán "giờ rảnh") |
| 7 | Milestones | **MLS** | 34–44 | §7.01–§7.09 | 6 | 3 | 2 | 🔭 **EX-6** (SC-36, xoá trắng tên ngày cũ — đường dẫn xoá dữ liệu, P1) · ⚠️ TB-17 (SC-41 thiếu quy tắc khi không có thẻ hôm nay) |
| 8 | Knob mới trên component cũ (Week events Style, Month progress, Priority matrix) | **KNW** | 46–55 | §8.01–§8.04 + **Q-1=A** cho SC-46–49 | 5 | 3 | 2 | ⚠️ TB-19 (SC-48 thiếu thang độ đậm) · TB-20 (SC-49 tên control lệch 2 tài liệu) · **phải nói rõ với tester: Week events Style độc lập với `Month heatmap` (INV #75), không gộp nhầm** |
| 9 | Ô emoji (Milestones + Workout) | **EMJ** | 57–62 | §9.01–§9.05 | 3 | 1 | 2 | 🔭 **EX-7** (SC-62, paste/dictation — không có nguồn) · ⚠️ TB-21 (SC-61 ngõ cụt nhập liệu, thiếu oracle trải nghiệm) |
| 10 | Nhãn bảng chỉnh & localization | **LBL** | 63–70 | §10.01–§10.06 + §1.03 | 1 | 2 | 5 | ⚠️ TB-07 (thiếu bảng đối chiếu VI) · TB-23 (SC-64 phạm vi quét không xác định) · TB-24 (SC-68/70 chỉ bắt buộc DE **hoặc** JA, it/ru là mở rộng) |
| 11 | Chia sẻ template — **UI-level only** | **SHR** | 71–73, 89 | §11.01–§11.02 + **Q-3** (UI-level) + **O-29** (Workout) | 4 | 0 | 0 | 🔒 xem banner điều kiện 3 · 🚩 O-26 ownership chưa chốt với bộ `share-template-link` |
| 12 | Regression render thật *(ngoài test basis)* | **RGT** | 76–80 | `component-editor.md` §11 + **O-24** (user) | 3 | 2 | 0 | ⚠️ **ngoài test basis** (điều kiện 1) · ⚠️ O-30 (SC-77/78: chưa rõ component nào được hỗ trợ ở Live Activity/widget) |
| 13 | Migration dữ liệu template *(ngoài test basis)* | **MIG** | 81, 82 | `component-editor.md` §11 + **O-24** | 2 | 0 | 0 | ⚠️ **ngoài test basis** · 🔭 **EX-4** (SC-82, migration ngược — không viết script cố định) |
| 14 | Hiệu năng *(ngoài test basis)* | **PRF** | 83, 84 | `component-editor.md` §4.14 + **O-24** | 1 | 1 | 0 | ⚠️ **ngoài test basis** · 🔭 **EX-5** (phần đo định lượng của SC-83, ⚠️ O-32 thiếu ngưỡng/tập máy) |
| 15 | Component mới lồng Row/Column *(ngoài test basis)* | **NST** | 85–88 | `component-editor.md` §5.07, §6.1, §6.2, §7, §10 #2 + **O-25** | 1 | 1 | 2 | ⚠️ **ngoài test basis** |
| | **Tổng** | | **87** | | **44** | **24** | **19** | — |

**Ghi chú bắt buộc cho nhóm RGT/MIG/PRF/NST (điều kiện 1):** traceability của 4 nhóm này **không** đi qua test
basis `stack-components.md` — Phụ lục A ghi rõ nguồn là "spec đối chiếu + quyết định user", **không** trình
bày như thể đó là requirement của `stack-components.md`. Nếu dev/PO sau này nói 4 nhóm này **không** thuộc
đợt bàn giao → chỉ 14 condition (SC-76…SC-88) phải gỡ, phần còn lại (73 condition) không ảnh hưởng.

**Ghi chú riêng cho Exploratory (điều kiện 2):** 7 vùng EX-1…EX-7 nằm **lồng trong** các test object ở trên
(không tách thành test object riêng) vì chúng gắn với một condition cụ thể đã có risk rating (SC-12, SC-36,
SC-62, SC-74/75 phần sâu, SC-82, SC-83 phần đo). Mục 5.20 cấp charter riêng cho từng vùng; mục 9 (Exit
criteria) yêu cầu báo cáo tách bạch scripted/exploratory.

**2 `GAP` không sinh test object/test case** — giữ đúng nguyên tắc traceability của
[`.claude/rules/testing.md`](../../../../.claude/rules/testing.md) *(Requirement → Condition → Objective →
Case; không xác định được quan hệ thì đánh dấu GAP, không suy diễn)*:

| GAP | Nội dung | Vì sao không sinh case |
|---|---|---|
| **SC-G3** | Month progress → Custom với khoảng không hợp lệ (end ≤ start) | Không có requirement, không có expected result cho nhánh âm (TB-18b) |
| **SC-G8** | Audit riêng tư mức payload/network khi share (Milestones, Event tickets, Workout) | Descope có chủ đích của user (Q-3) — không phải thiếu sót; xem điều kiện 3 ở banner |

---

## 3. Out of scope

| # | Hạng mục | Lý do | Điều kiện đưa lại phạm vi |
|---|---|---|---|
| 1 | **§12.01** — Màu chữ tiêu đề Priority matrix chưa đổi theo Color tone Light/Dark trong Customize | Test basis **tuyên bố tường minh** "chưa làm, không report" | Dev sửa và tuyên bố đã fix |
| 2 | **§12.02** — So sánh ảnh golden chỉ chạy trên iOS 18.6 qua CI đêm | Không phải việc của test thủ công; hệ quả là tester không có baseline (mục 1.4, mục 11 #1) | Không áp dụng — việc CI, không phải QC thủ công |
| 3 | **`SC-G3`** — Month progress Custom, khoảng end ≤ start | `GAP` thiếu requirement (TB-18b) | Dev bổ sung expected result cho nhánh âm |
| 4 | **`SC-G8`** — Audit riêng tư mức payload/network | `GAP` descope có chủ đích (Q-3, điều kiện 3) | Có yêu cầu audit riêng tư chính thức (pháp lý/báo cáo bảo mật) hoặc dev làm rõ ý (b) của Q-3 |
| 5 | **Hành vi chi tiết `Month heatmap`** (thang độ đậm, khác biệt với Week events Heat map và Activity grid) | Chuyển Exploratory (EX-3, O-27) — không viết case có expected result | Dev bàn giao acceptance criteria riêng cho component này |
| 6 | **Đường vào "ghim" sự kiện** (Event tickets) — giới hạn số lượng, hành vi khi sự kiện đã ghim trôi qua/bị xoá | Chuyển Exploratory (EX-2, O-7) | Dev bàn giao đường vào + oracle số lượng |
| 7 | **Migration ngược** (app cũ mở wallpaper có component mới) | Chuyển Exploratory (EX-4, O-31) — không viết script cố định | Dev xác nhận hành vi mong đợi (suy giảm êm/band trống/crash) |
| 8 | **Đo hiệu năng định lượng** (fps, ngưỡng frame drop, thời gian render tối đa) | Chuyển Exploratory (EX-5) — không có tiêu chí đo khách quan (O-32) | Dev/design bàn giao ngưỡng + tập máy tối thiểu |
| 9 | **Xoá trắng tên mốc ngày đã tồn tại** (Milestones) | Chuyển Exploratory (EX-6, O-33) — test basis chỉ định nghĩa cho ngày mới | Dev xác nhận hành vi mong đợi (giữ "Untitled" hay xoá) |
| 10 | **Dán (paste)/đọc chính tả** vào ô emoji | Chuyển Exploratory (EX-7, O-33) | Dev bàn giao oracle cho nhánh paste |
| 11 | **Mức payload/network của share template** | = `SC-G8`, xem #4 | Xem #4 |
| 12 | **18 locale đầy đủ** ngoài VI + 1 ngôn ngữ thứ hai (§1.03) | Không có danh sách 18 locale cụ thể; chỉ kiểm "không lọt chuỗi tiếng Anh vào máy VI" cho ngôn ngữ đã chọn | Dev bàn giao danh sách 18 locale |
| 13 | **it/ru đầy đủ** cho SC-68/70 (chỉ bắt buộc DE **hoặc** JA theo §1.03) | Mâu thuẫn năng lực ngôn ngữ (TB-24) — cần người đọc hiểu cả 3 ngôn ngữ đó, vượt phạm vi tester hiện có | Có tester đọc hiểu de/it/ru, hoặc dev cung cấp chuỗi kỳ vọng để đối chiếu không cần hiểu nghĩa |
| 14 | **Danh mục component chính thức** (tên UI ↔ tên code ↔ knob riêng, kế thừa từ `tf-117` out-of-scope #9) | Chưa được bàn giao | Dev bàn giao danh mục |
| 15 | Automation/unit test | Test plan này là black-box thủ công, đúng quy ước repo | — |

### 3.1 Ảnh hưởng chéo tới flow khác

> Đối chiếu [screenshot-naming.md §7](../../../../.claude/rules/screenshot-naming.md#7-flow-map--ink-calendar-ios).

| Flow | Ảnh hưởng? | Lý do / condition liên quan |
|---|---|---|
| `14_edit-wallpaper` (chính nó) | **Trực tiếp** | Toàn bộ 87 condition; sheet Add có 6 mục mới + 1 (`Month heatmap`); chưa có screenshot/wireframe cho nội dung đã render (mục 1.4) |
| `10_lockscreen` | **Trực tiếp** | Nhóm **RGT** (SC-76, 79, 80) — kết quả cuối của mọi component mới trên màn khoá thật |
| `04_discover` | **Gián tiếp, có case tường minh** | Đường vào Discover → template → Edit; thumbnail "Your collection" cập nhật theo component mới (SC-78, nhóm RGT) |
| `05_calendar` | **Gián tiếp, có case tường minh** | Nguồn dữ liệu event cho Agenda, Event tickets, Today at a glance, Daily page, `Month heatmap`; "ghim" sự kiện (EX-2) có thể nằm ở đây — chưa xác nhận |
| `06_task` | **Gián tiếp, có case tường minh** | Nguồn dữ liệu Reminders cho "việc cần làm" của Today at a glance (SC-29) |
| `07_note`, `09_settings`, `01_onboarding`, `02_permission` | **Không** | Không có entry point/pipeline dữ liệu chung với 6 component mới |
| `11_share` | **Trực tiếp, nhưng ownership chưa chốt** | Nhóm **SHR** (SC-71/72/73/89) — xem 🚩 banner O-26: giao thoa với bộ `share-template-link` slug `1-2-19`, cùng build |
| `03_shortcut-setup` | **Không xác định — không có case tường minh** | Giống nhận xét của `tf-117`: wallpaper vẫn tự render mỗi sáng qua Shortcut automation, nhưng test basis `stack-components.md` không đặt điều kiện kiểm "sống sót qua đêm" cho 6 component mới → ghi coverage gap (mục 11), không tự thêm case |
| `08_paywall` | **Không xác định** | Test basis không nhắc gate Pro cho component mới; `component-editor.md` cũng không nêu — không đủ căn cứ viết case, không tự suy diễn |
| `12_ai-assistant`, `13_community` | **Không áp dụng** | 🚧 chưa build |

---

## 4. Test levels & test types

- **Level:** **System testing**, black-box, thủ công (ISTQB §2.2.1). Máy thật **bắt buộc** cho nhóm **RGT**
  (lock screen thật, Live Activity, widget — không mô phỏng được bằng simulator) và khuyến nghị cho **EMJ**
  (bàn phím emoji hệ thống, cài đặt "tắt bàn phím Emoji"). Nhóm **PRF** cần máy thật để cảm nhận mượt/giật.
- **Functional:** 13/15 test object (trừ LBL một phần, DLP/MLS một phần — có cả Usability/Portability).
- **Non-functional (ISO 25010 — §2.2.2):**

| Quality characteristic | Áp dụng cho | Condition tiêu biểu |
|---|---|---|
| **Usability** | Icon minh hoạ, mô tả sheet Add, trải nghiệm ngõ cụt nhập liệu emoji | INV (SC-04), EMJ (SC-61) |
| **Security** | Dữ liệu cá nhân không hiển thị cho người nhận khi share | SHR (SC-71, 72, 73, 89) — **chỉ mức UI**, xem điều kiện 3 |
| **Performance efficiency** | Canvas mượt khi nhiều band nặng dữ liệu; thời gian render/áp dụng | PRF (SC-83, 84) — phần lớn là 🔭 EX-5 do thiếu ngưỡng |
| **Compatibility** | Chrome iOS 18.x vs 26.x (kế thừa từ `component-editor.md`, không có trong test basis riêng) | Toàn bộ 15 nhóm, nhân đôi môi trường (mục 7) |
| **Portability** | Lunar date theo vùng, lịch Phật giáo (Thái), migration xuôi | DLP (SC-27), MLS (SC-44), MIG (SC-81) |
| **Reliability** | Không mất dữ liệu người dùng tự nhập qua Reset/Undo, mở lại template vẫn đúng | WKT (SC-23), RGT (SC-79, 80), MIG (SC-81) |
| Maintainability · Safety | **Không áp dụng** | Không có yêu cầu trong test basis |

- **Change-related (§2.2.3):**
  - **Confirmation testing:** không có danh sách "đã sửa" trong test basis (cùng tình trạng TB-27 của bộ
    `tf-117`). **SC-23** (Reset Workout) đóng vai trò tương đương confirmation-cho-quyết-định-Q2: kiểm hành vi
    **đảo ngược** so với suy luận gián tiếp từ `component-editor.md` (Content → Reset của Quote vốn xoá nội
    dung) — nếu build khớp với component-editor.md thay vì với test basis, đó là tín hiệu Q-2 cần xem lại.
  - **Regression testing — phạm vi rộng hơn test basis gốc, do điều kiện 1:**
    - Toàn nhóm **RGT** (5 condition) — lock screen thật/Live Activity/widget/thumbnail/mở lại template.
    - Toàn nhóm **MIG** phần xuôi (SC-81) — template cũ/mới cùng tồn tại sau khi thêm 7 component.
    - Toàn nhóm **NST** (4 condition) — component mới không phá vỡ hành vi container đã có từ `tf-117`/1.2.18.

---

## 5. Kỹ thuật thiết kế test case

> Kỹ thuật chỉ áp dụng nơi thật sự phù hợp (ISTQB §4.1). Mọi nhãn ⚠️/🔭 giữ nguyên như test-analysis mục 2/4B.

### 5.1 INV — Checklist-based + EP

**Checklist tồn kho:** 6 component mới có đúng tên trong sheet Add (SC-01); 23 mục/6 nhóm gồm nhóm **Fitness**
mới và `Month heatmap` trong nhóm Calendar (SC-02, ⚠️ oracle chỉ là ảnh batch 8); icon + mô tả 1 dòng (SC-04).
**EP theo cơ chế Add đã có sẵn** (tái sử dụng mạch Add/toast/Undo đã được `tf-117` kiểm — test-plan này **chỉ**
xác nhận 6 loại mới + `Month heatmap` dùng đúng mạch đó, không viết lại toàn bộ cơ chế Add): mỗi component mới
→ xuất hiện trên canvas, toast *"Added …"* kèm Undo (SC-03, SC-74).

### 5.2 AGD — EP + BVA (hạn chế) + Checklist

**EP/BVA Days & Events per day (⚠️ TB-08 — chỉ 2 điểm mẫu, không rõ min/max):** giá trị test khả dụng = **1**
và **14** (Days), **1** (Events per day) — đúng 2 điểm nêu trong test basis; **không** thiết kế thêm biên
ngoài 2 điểm này vì không biết trần thật (SC-06, SC-07). **Checklist:** bố cục mặc định 7 ngày, gom theo ngày
(SC-05) · tắt Show title/Date range (SC-09) · sự kiện cả ngày = "All day" (SC-10) · tràn chiều dọc bỏ ngày xa
nhất trước (SC-08, ⚠️ TB-09 — không rõ điều kiện kích hoạt, tester phải tự dựng tình huống tràn bằng cách
thêm nhiều sự kiện/ngày cho tới khi quan sát được, ghi lại cách dựng khi báo bug).

### 5.3 TKT — EP (4 Ticket style)

**EP:** {Classic | Admit | Side stub | Poster} × render đúng kiểu, không vỡ bố cục (SC-13). Đổi Color scheme
→ chữ đọc được (SC-14, ⚠️ TB-11 không có ngưỡng contrast — chỉ kiểm "không trùng hẳn màu nền"). Tắt
Cover/Location → gọn lại, không chừa khoảng trống (SC-15). Phóng cỡ chữ → vé cao theo, chữ không tràn (SC-16,
⚠️ TB-11). **SC-12 (chưa ghim → sự kiện sắp tới) = 🔭 EX-2** — xem mục 5.20, không viết script cố định.

### 5.4 WKT — State Transition (Weekly plan) + Checklist

**State Transition — Weekly plan:** {ngày trống} —chạm→ {sheet chọn môn} —chọn+đặt tên+chi tiết+Lưu→ {nội
dung hiện đúng trên band} (SC-17); {ngày trống} —chọn Rest→ {ngày mờ đi} (SC-18). **Checklist:** Style
List/Week strip (SC-19) · Icons Symbol/Emoji (SC-20, liên quan EMJ) · Fade past days với BVA quanh nửa đêm
(SC-21) · dòng Up next + tắt Decorative icons (SC-22).

**SC-23 (Reset) — viết theo đúng §4.05 (Q-2, user):** expected result = *"kế hoạch tập vẫn còn"*. **Mang
nguyên ô ghi chú:** nếu thực thi thấy kế hoạch tập bị xoá sau khi bấm Reset ⇒ **REPORT BUG NGAY**, không phải
lỗi thiết kế test case, không phải "hành vi cố ý nhất quán với Quote". Tester **không** được tự sửa expected
result cho khớp hành vi quan sát được trên build.

### 5.5 DLP — Decision Table + EP + Checklist

**Decision Table — loại ngày × hiển thị:**

| Rule | Loại ngày | Lịch ngày lễ bật? | Kỳ vọng | Condition |
|---|---|---|---|---|
| D1 | Thường, có sự kiện | — | Số ngày to + thứ + danh sách sự kiện hôm nay | SC-24 |
| D2 | **Rảnh** (⚠️ TB-12, chưa định nghĩa) | — | Câu trích dẫn thay danh sách sự kiện | SC-25 |
| D3 | Ngày lễ | Có | Tên lễ to, sự kiện bên dưới | SC-26 |

**EP theo vùng (Lunar date, ⚠️ TB-13):** {VN/CN (mặc định bật) | vùng rõ ràng ngoài tập (US, mặc định tắt)} —
**không** kiểm biên KR/TW/HK/SG/JP vì danh sách bỏ lửng (SC-27). **Checklist:** icon trăng/pháo giấy, tắt
Decorative icons (SC-28).

### 5.6 TAG — EP (4 phần độc lập) + Checklist

**EP:** mỗi phần {sự kiện chính | thanh giờ | việc cần làm | giờ rảnh} tắt độc lập → mất đúng phần đó, phần
còn lại dồn lên không chừa trống (SC-30). **Checklist:** 4 phần hiển thị đúng dữ liệu (SC-29) · icon nhãn, tắt
Decorative icons (SC-31) · DST không lệch 1 tiếng (SC-32, ⚠️ TB-14 — **chưa có phương tiện dựng tình huống
DST chuẩn**; ghi chú cho tester: nếu máy test không ở vùng có DST hoặc không có ngày DST sắp tới trong kỳ
test, ghi *"Not run — thiếu điều kiện dựng"*, không suy diễn) · giờ rảnh tính hợp lý thô (SC-33, ⚠️ TB-15 chỉ
kiểm "có khoảng trống đúng chỗ", không chốt đúng thuật toán).

### 5.7 MLS — BVA (mạnh nhất của đợt) + Decision Table + EP

**BVA — văn bản đếm ngày (SC-38), quanh ±1 và nửa đêm:**

| Mốc | Giá trị test | Kỳ vọng |
|---|---|---|
| Tương lai xa | ≥ 2 ngày nữa | *"còn N ngày"* |
| Ngày mai | +1 | dạng chữ ("Tomorrow"/tương đương) |
| **Hôm nay** (biên giữa) | 0 | **"Today"** |
| Hôm qua | −1 | dạng chữ ("Yesterday"/tương đương) |
| Quá khứ xa | ≤ −2 ngày | *"đã N ngày"* |
| Quanh nửa đêm | 23:59 → 00:01 cùng/khác ngày | mốc đổi đúng lúc sang ngày mới, không lệch theo giờ máy |

**Decision Table — Card palette xoay vòng màu (SC-41, ⚠️ TB-17 — chỉ phủ trường hợp có định nghĩa):**

| Rule | Có thẻ "hôm nay"? | Vị trí thẻ hôm nay | Kỳ vọng | Ghi chú |
|---|---|---|---|---|
| M1 | Có | Giữa danh sách | Thẻ hôm nay = màu nhấn; thẻ ngay sau = màu đầu bảng | SC-41 |
| M2 | Có | **Cuối** danh sách | ⚠️ Không có quy tắc — **không tự suy diễn** "thẻ ngay sau" là gì | Ghi nhận quan sát, báo dev (O-14) |
| M3 | **Không có** | — | ⚠️ Không có quy tắc điểm bắt đầu xoay vòng | Ghi nhận quan sát, báo dev (O-14) |

**EP còn lại:** Add a day mở ngay (SC-34) · đóng sheet chưa đặt tên (ngày mới) → tự biến mất (SC-35) · Every
year đếm tới lần kế, badge dịch theo ngôn ngữ (SC-39) · icon lịch + số ≥4 chữ số co lại (SC-40) · Card pattern
chỉ trên thẻ ngày, không trên thẻ nền (SC-42) · Birthdays & holidays tắt/bật (SC-43) · lịch Phật giáo lưu đúng
năm dương lịch (SC-44, cần máy/giả lập vùng Thái).

**SC-36 (xoá trắng tên ngày đã tồn tại) = 🔭 EX-6** — xem mục 5.20.

### 5.8 KNW — EP + BVA + Decision Table

**EP — Week events Style (3 giá trị, độc lập với `Month heatmap`):** {Bars | Dots | Heat map} — Dots: 4 chấm/
hàng (SC-47); Heat map: lửa khi ≥2 sự kiện, hoà thì mọi ngày bằng nhau đều có lửa (SC-48, ⚠️ TB-19 thiếu thang
độ đậm) · knob Block opacity/+N more chỉ hiện ở Bars (SC-49, ⚠️ TB-20 tên control lệch 2 tài liệu). **Ghi chú
bắt buộc cho tester:** đây là knob trên component **Week events** đã có sẵn, **khác** component `Month
heatmap` (INV #75, phạm vi tháng) và **khác** `Activity grid` (đã có từ trước) — ba thứ không được gộp nhầm.

**BVA 3-value — ngưỡng màu Month progress (SC-51):** 74/75 (cam) · 89/90 (đỏ) · công tắc tắt → giữ màu gốc.

**Decision Table — Date range × vị trí hôm nay:**

| Rule | Date range | Hôm nay so với khoảng | Kỳ vọng | Condition |
|---|---|---|---|---|
| K1 | This month (mặc định) | — | — | SC-50 |
| K2 | Custom | tự điền hôm nay + 90 ngày, có ô Title | ⚠️ TB-18(c): "+90" tính cả hôm nay hay không — chưa rõ | SC-50 |
| K3 | Custom | trước khoảng | 0% | SC-52 |
| K4 | Custom | sau khoảng | 100% | SC-52 |
| K5 | Custom | **end ≤ start** | = `SC-G3`, **không viết case** | GAP |

Priority matrix Each box 4 màu đè màu chung (SC-53) · Box pattern trên cả 4 ô (SC-54) · Strike out Drop box
mặc định tắt (SC-55) — Checklist-based, kế thừa Priority matrix đã có từ `tf-117`.

### 5.9 EMJ — State Transition + Decision Table

**State Transition — ô emoji:** {trống, placeholder mờ} —chạm→ {bàn phím mở thẳng trang emoji} —chọn emoji→
{lưu, bàn phím đóng} (SC-58); {đã có emoji} —phím xoá→ {về placeholder mờ, ⚠️ TB-22 không biết ký tự cụ thể}
(SC-59).

**Decision Table — trạng thái bàn phím × hành động:**

| Rule | Bàn phím Emoji (Cài đặt) | Hành động | Kỳ vọng | Condition |
|---|---|---|---|---|
| E1 | Bật (mặc định) | Gõ chữ qua bàn phím thường | Không nhận | SC-60 |
| E2 | **Tắt trong Cài đặt** | Chạm ô | Hiện bàn phím thường, **vẫn chỉ nhận emoji** | SC-61, ⚠️ TB-21 — không có oracle cho trải nghiệm ngõ cụt (không gợi ý/không thông báo theo test basis; **không tự thêm** mong đợi) |
| E3 | — | **Dán (paste)/đọc chính tả** | = 🔭 **EX-7**, không viết case | — |

**Checklist:** ô vuông, cao bằng ô tên bên cạnh, kiểm cả Milestones và Workout (SC-57).

### 5.10 LBL — Checklist-based + EP (localization)

**Checklist nhãn:** nhóm Backdrop = "Nền" (SC-63) · nhãn thẻ đúng cấp (SC-65) · Days shown Mon–Fri/Full week,
Day header (SC-66, ⚠️ TB-25 chưa rõ hành vi khi ngày đầu tuần là Chủ nhật) · Weekly plan = "Kế hoạch tuần"
(SC-67) · ô nhập tiêu đề căn trái (SC-69). **Không component nào trùng tên (SC-64, ⚠️ TB-23):** quét **có giới
hạn** — tester kiểm các component **đã nêu tên cụ thể** trong test basis (không quét cạn kiệt 23 component ×
mọi knob, vì phạm vi không xác định).

**EP — localization (§1.03):** {tiếng Việt | ngôn ngữ thứ hai: DE hoặc JA} × mọi chuỗi mới của 6 component +
knob mới → không lọt chuỗi tiếng Anh vào máy VI (SC-70, ⚠️ TB-07 thiếu bảng đối chiếu VI chính thức — tester
tự đối chiếu bằng ngữ cảnh). Ô Drop (Matrix) ở de/it/ru không còn nghĩa "giọt nước" (SC-68) — **chỉ chạy được
nếu có tester đọc hiểu đủ 3 ngôn ngữ** (out of scope #13 nếu không có).

> ⚠️ **TB-06 (O-3) chưa đóng — ảnh hưởng ma trận môi trường, không đổi tập condition:** "Light và Dark" ở
> §1.03 có thể là knob **Color tone** trong Customize (bằng chứng gián tiếp từ §12.01) hoặc chế độ sáng/tối
> **hệ điều hành**. Ghi chú ngữ cảnh (không phải kết luận thay test-analysis): theo ghi nhận hiện có của repo,
> app **hiện chưa hỗ trợ Dark Mode hệ điều hành** ở các luồng khác — nếu đúng cho cả Customize, điều này
> **ủng hộ thêm** cách hiểu A (knob Color tone), nhưng đây **vẫn là quan sát bổ trợ, không phải xác nhận của
> dev** — test-plan **không** tự chốt cách hiểu, giữ nguyên ⚠️ như test-analysis và nhân đôi ma trận môi
> trường ở mục 7 cho tới khi có câu trả lời.

### 5.11 SHR — Checklist-based theo loại dữ liệu — **UI-level only**

**Checklist (mỗi dòng = 1 loại dữ liệu cá nhân × kiểm trên máy người nhận sau khi mở link share):**

| Loại dữ liệu | Component | Kỳ vọng (UI người nhận) | Condition |
|---|---|---|---|
| Tên/ngày riêng của milestone người gửi | Milestones | **Không hiển thị** | SC-71 |
| Sự kiện đã ghim của người gửi | Event tickets | **Không hiển thị** | SC-72 |
| Ảnh thẻ chọn từ máy người gửi | (ảnh nền/thẻ) | **Không đi theo link** — có oracle đối chiếu `template-sharing-api.md` (`backgroundImagePath`/`backgroundSourcePath` = `null`) | SC-73 |
| Kế hoạch tập (tên môn, chi tiết, emoji) của người gửi | Workout | **Không hiển thị** | SC-89 |

⚠️ **Thiếu oracle cho "người nhận thấy gì thay thế"** (TB-03c) cho SC-71/72/89 — component rỗng/placeholder/dữ
liệu mẫu/biến mất đều chưa được định nghĩa; tester **chỉ xác nhận dữ liệu gốc không hiển thị**, ghi lại **cụ
thể cái gì thay vào chỗ đó** để dev phân loại đúng/sai sau.

**🔒 Nhắc lại bắt buộc (điều kiện 3):** 4 case trên **chỉ** kiểm mức UI của máy nhận. **Không** mở rộng sang
kiểm payload/network/log — đó là `SC-G8`, ngoài phạm vi đợt này.

### 5.12 RGT — Checklist-based theo bề mặt — **ngoài test basis**

**Checklist (mỗi bề mặt × cả 7 component mới, dùng template đã dựng ở nhóm trước):**

| Bề mặt | Kỳ vọng | Condition |
|---|---|---|
| Lock screen thật | Render đúng như preview Customize | SC-76 |
| Live Activity | Chạy, không vỡ layout | SC-77, ⚠️ O-30 không rõ component nào được hỗ trợ |
| Widget + thumbnail "Your collection" | Cập nhật theo bố cục mới | SC-78, ⚠️ O-30 |
| Template cũ (chưa động vào) | Render y như trước | SC-79 |
| Mở lại template đã sửa | Bố cục giữ nguyên, sửa tiếp được | SC-80 |

### 5.13 MIG — Checklist-based (xuôi) — **ngoài test basis**

Wallpaper lưu ở build cũ (chưa có component mới) mở ở build này → bố cục giữ nguyên, không mất band, sửa tiếp
được (SC-81). **SC-82 (migration ngược) = 🔭 EX-4** — xem mục 5.20, không viết script cố định.

### 5.14 PRF — Checklist-based (quan sát định tính) — **ngoài test basis**

Wallpaper có nhiều band nặng dữ liệu cùng lúc (Agenda 14 ngày + Milestones nhiều thẻ + Workout + Today at a
glance) → canvas chọn/kéo/cuộn **mượt theo quan sát định tính**, không đứng hình (SC-83 — **phần script**,
tách khỏi phần đo định lượng = 🔭 **EX-5**). Thời gian render & áp dụng không tăng **bất thường** so với
template thường — so sánh định tính, không có số (SC-84, ⚠️ O-32 thiếu ngưỡng).

### 5.15 NST — Decision Table + EP — **ngoài test basis**

**Decision Table — loại component mới × vị trí trong container (rủi ro nhất của nhóm P):**

| Rule | Loại component | Vị trí | Kỳ vọng | Condition |
|---|---|---|---|---|
| N1 | Bất kỳ trong 7 component mới | Ô trống của Row/Column (bấm +) | Lấp đúng ô đó, ô còn lại vẫn nguyên | SC-85 |
| N2 | Cao/nhiều dòng (Agenda, Milestones, Workout, Event tickets) | Trong **Row** (còn nửa bề rộng) | Nội dung xuống dòng/co lại hợp lý, không tràn, không bị cắt | SC-87 — **tổ hợp rủi ro nhất** |
| N3 | Bất kỳ trong 7 component mới | Trong Row/Column | Không có thanh Size (cố ý, kế thừa `component-editor.md` §10 #2); knob riêng vẫn chỉnh được | SC-86 |
| N4 | Bất kỳ trong 7 component mới | Cấp container thứ 3 | Nhóm Layout biến mất khỏi sheet Add | SC-88 |

### 5.16 Charter Exploratory (mục bổ sung, không thuộc kỹ thuật scripted)

> **Điều kiện 2 — bắt buộc.** 7 vùng dưới đây **không có expected result**; charter chỉ định hướng phiên khám
> phá, **không** chứng minh pass/fail. Mọi quan sát bất thường trên đường dẫn xoá/mất dữ liệu (EX-6, EX-4) PHẢI
> được ghi lại và báo cho dev, không tự kết luận "đúng thiết kế".

| # | Charter | Gắn với | Thời hộp gợi ý | Cách ghi nhận |
|---|---|---|---|---|
| **EX-1** | Khám phá chi tiết sâu 6 component mới (font, nguồn dữ liệu, tổ hợp knob) ngoài những gì checklist nêu | Nhóm B–G (AGD, TKT, WKT, DLP, TAG, MLS) | 30–45 phút/component | Ghi chú tự do + ảnh chụp, gửi dev như input cho acceptance criteria tương lai |
| **EX-2** | Tìm đường vào hành động "ghim" sự kiện; thử giới hạn số lượng, sự kiện đã ghim trôi qua/bị xoá | TKT (SC-12) | 20 phút | Ghi lại đường vào tìm được (nếu có) + hành vi quan sát |
| **EX-3** | Hành vi chi tiết `Month heatmap` — thang độ đậm, phạm vi tháng, khác biệt với Week events Heat map/Activity grid | INV (SC-74/75) | 20 phút | So sánh trực quan 3 thứ, ghi lại khác biệt quan sát được |
| **EX-4** | Migration ngược — mở wallpaper có component mới ở bản app cũ hơn (nếu có build cũ để test) | MIG (SC-82) | 20 phút | Ghi lại: suy giảm êm? band trống? mất band? crash? |
| **EX-5** | Cảm nhận hiệu năng định lượng (không có thước đo chính thức) — ước lượng fps bằng công cụ hệ thống nếu có | PRF (SC-83 phần đo) | 20 phút | Ghi số liệu thô nếu đo được (vd Instruments), nêu rõ "không có ngưỡng tham chiếu" |
| **EX-6** | Xoá trắng tên một mốc ngày **đã tồn tại** (Milestones) rồi đóng sheet — quan sát ngày đó còn/mất | MLS (SC-36, **P1** — đường dẫn xoá dữ liệu) | 10 phút | **Nếu thấy mốc ngày biến mất im lặng → ghi nhận và báo dev ngay**, không tự kết luận |
| **EX-7** | Dán (paste)/đọc chính tả vào ô emoji | EMJ (SC-62) | 10 phút | Ghi lại ô nhận gì (emoji/bị chặn/crash) |

---

## 6. Risk-based prioritization

### 6.1 Cơ sở

**Risk level = Risk likelihood × Risk impact** (ISTQB §5.2.1), lấy **nguyên** từ test-analysis mục 2, không
tính lại. Impact cao gắn với: (a) đường dẫn **mất dữ liệu người dùng tự nhập** (SC-23 Reset, SC-36 xoá mốc
ngày) — impact Cao bất kể likelihood; (b) **rò rỉ dữ liệu cá nhân** khi share (SC-71/72/73/89, loại Security)
— impact Cao theo ISO 25010; (c) **hỏng hiển thị trên bề mặt thật** (lock screen/Live Activity/widget, nhóm
RGT) — vì đây là kết quả cuối cùng người dùng thấy, không phải chỉ lỗi trong editor.

### 6.2 Severity mapping với `bugs/bug-log.md`

> Theo đúng quy ước đã dùng ở [test-plan-tf-117.md](test-plan-tf-117.md) mục 6.2 — `bugs/bug-log.md` dùng
> `Critical/High/Medium/Low`, khác P1/P2/P3 (độ ưu tiên **test**, không tự động là severity bug).

| Độ ưu tiên test | Severity gợi ý khi log bug | Ví dụ |
|---|---|---|
| P1 | **Critical** nếu mất dữ liệu không khôi phục được (SC-23 bị xoá, SC-36 mốc ngày biến mất, SC-71/72/89 rò rỉ dữ liệu cá nhân thật) · **High** nếu sai chức năng chính nhưng còn cách khôi phục | SC-23, SC-36, SC-71, SC-72, SC-89, SC-76 |
| P2 | **Medium** | SC-77, SC-78, SC-84 |
| P3 | **Low** | SC-09, SC-54, SC-63 |

Khi log bug: `Flow` = `14_edit-wallpaper` (hoặc `10_lockscreen`/`11_share` nếu lỗi chỉ thấy ở bề mặt đó theo
nhóm RGT/SHR), `Screen` = `customize` (chưa có trong danh sách `screen-name` hiện tại của
`screenshot-naming.md` §7.1 — cần bổ sung khi có ảnh baseline, mục 11 #6 kế thừa từ `tf-117`).

### 6.3 P1 — 44 condition theo nhóm, vì sao impact cao

| Nhóm | Số P1 | Vì sao impact cao (tiêu biểu) |
|---|---|---|
| INV | 2 | SC-03: thêm sai component gốc ⇒ mọi thao tác sau dựng trên dữ liệu sai; SC-74: `Month heatmap` là component mới hoàn toàn, sai tồn tại/thêm ⇒ chặn cả nhóm EX-3 |
| AGD | 2 | SC-05 bố cục mặc định sai ⇒ sai dữ liệu hiển thị chính; SC-08 cắt nửa ngày = mất thông tin sự kiện |
| TKT | 5 | SC-11/12/13/15/16 — vé sai sự kiện hoặc vé vỡ bố cục ảnh hưởng trực tiếp thông tin lịch quan trọng nhất của người dùng |
| WKT | 2 | SC-17 sheet lưu sai kế hoạch tập; **SC-23 — đường dẫn mất dữ liệu người dùng tự nhập, impact Cao bất kể mâu thuẫn với tài liệu đối chiếu** |
| DLP | 3 | SC-24/26/27 sai dữ liệu ngày/lễ/âm lịch hiển thị chính của band |
| TAG | 4 | SC-29/30/32/33 — 4 phần tổng hợp thông tin ngày, sai một phần làm người dùng ra quyết định nhầm (vd DST lệch giờ) |
| MLS | 6 | SC-35/38/39/41/44 — đếm ngày sai lệch niềm tin cốt lõi của component; **SC-36 — đường dẫn mất dữ liệu người dùng tự nhập (mốc ngày)** |
| KNW | 5 | SC-46/48/49/51/52 — knob đã tồn tại từ trước, sai ở đây là regression trên component cũ, ảnh hưởng rộng |
| EMJ | 3 | SC-58/60/61 — ô nhập liệu chính của Milestones/Workout, sai ⇒ không gắn được icon minh hoạ |
| LBL | 1 | SC-70 — chuỗi tiếng Anh lọt vào máy VI ảnh hưởng toàn bộ 6 component mới cùng lúc |
| SHR | 4 | SC-71/72/73/89 — rò rỉ dữ liệu cá nhân (Security), dù chỉ kiểm mức UI vẫn là impact cao nhất theo ISO 25010 |
| RGT | 3 | SC-76/79/80 — sai ở bề mặt thật/template cũ là kết quả cuối cùng người dùng thấy, không chỉ lỗi editor |
| MIG | 2 | SC-81/82 — sai migration có thể làm hỏng toàn bộ wallpaper đã lưu của người dùng |
| PRF | 1 | SC-83 — canvas đứng hình chặn hoàn toàn khả năng chỉnh sửa |
| NST | 1 | SC-87 — tổ hợp rủi ro nhất: component cao/nhiều dòng trong Row dễ tràn/cắt chữ |

**P2 — 24** (mất một phần chức năng/UX rõ nhưng có workaround): phần lớn hành vi phụ (BVA Days/Events per day,
knob phụ, Live Activity/widget của component mới). **P3 — 19** (cosmetic/label/hành vi cố ý): nhãn bảng chỉnh,
Card pattern, Strike out Drop box mặc định.

### 6.4 Nhãn ⚠️/🔭 — mang nguyên từ test-analysis, KHÔNG được bỏ

> Tóm tắt để `test-case` tra cứu nhanh — không thay thế nguồn gốc ở test-analysis mục 2/4B.

| Loại | Condition | Điều kiện thay đổi tóm tắt |
|---|---|---|
| **Ngoài test basis (điều kiện 1)** | SC-76…SC-88 (14) | Dev/PO nói 4 nhóm RGT/MIG/PRF/NST không thuộc đợt bàn giao ⇒ gỡ toàn bộ, không ảnh hưởng 73 condition còn lại |
| **Exploratory — không expected result (điều kiện 2)** | SC-12, SC-36, SC-62, SC-74/75 (phần sâu), SC-82, SC-83 (phần đo) (7) | Dev bàn giao oracle cho vùng tương ứng ⇒ chuyển lại thành condition scripted bình thường |
| **UI-level only (điều kiện 3)** | SC-71, SC-72, SC-89 | Dev/PO quyết định mở rộng kiểm payload/network ⇒ mở lại `SC-G8`, viết thêm condition mới |
| **Quyết định diễn giải của user, dev chưa xác nhận (điều kiện 4)** | SC-02, SC-23, SC-46…49, SC-71, SC-72, SC-74, SC-75 (7 nhóm quyết định) | Dev trả lời khác ⇒ chỉ condition tương ứng viết lại (xem Phụ lục A) |
| **Gap mở — chỉ giảm độ chính xác, không chặn** | SC-06, SC-07, SC-08, SC-14, SC-16, SC-25, SC-27, SC-32, SC-33, SC-41, SC-48, SC-49, SC-59, SC-61, SC-64, SC-66, SC-68, SC-70, SC-77, SC-78, SC-84 | Xem test-analysis mục 1B/4B — giá trị/ngưỡng/danh sách chưa bàn giao |

### 6.5 Product risk vs project risk (ISTQB §5.2)

| Loại | Rủi ro | Xử lý trong plan |
|---|---|---|
| **Project** | 4 điều kiện ở banner là quyết định của **user**, chưa có xác nhận kỹ thuật từ dev — nếu dev trả lời khác, có thể viết lại tới 14 condition (nhóm RGT/MIG/PRF/NST) hoặc đảo expected result của SC-23 | Giữ nhãn rõ ràng; chỉ các dòng liên quan phải sửa lại, không ảnh hưởng phần còn lại |
| Project | **Chưa có baseline ảnh render thật** cho bất kỳ component mới nào (O-23) | Entry criterion E2; risk/limitation ghi ở mục 11 |
| Project | **O-26 — ownership giữa nhóm SHR và bộ `share-template-link` chưa chốt** | Phải xác nhận trước khi thực thi để tránh test trùng/bỏ sót (mục 10) |
| Project | **O-30/O-32 chưa có câu trả lời** — ảnh hưởng trực tiếp khả năng phân loại pass/fail của SC-77/78 và thiết kế đo của SC-83/84 | Ghi rõ "theo giả định/chưa có ngưỡng" khi báo cáo kết quả, không tự đoán |
| Product | 7 vùng Exploratory **không chứng minh được pass** — rủi ro là người đọc báo cáo hiểu nhầm "đã test" | Exit criteria (mục 9) bắt buộc tách bạch scripted/exploratory |
| Product | Oracle của nhóm RGT/MIG/PRF/NST đến từ tài liệu khác flow (`component-editor.md`) — rủi ro oracle không khớp hoàn toàn với 7 component hoàn toàn mới | Ưu tiên chạy RGT sau khi các nhóm nội dung (AGD…MLS, KNW) đã pass, đúng thứ tự gợi ý ở mục 8.1 |

---

## 7. Test environment matrix

| Hạng mục | Yêu cầu |
|---|---|
| **Build** | Ghi nhận là **1.2.19** theo chú thích của QC trong `index.md` — **CHƯA xác nhận chính thức** (TB-05, test basis không có mã build/branch/PR). Trước khi test phải xác định đúng build; build khác ⇒ dừng, báo lại (entry E1) |
| **Thiết bị bắt buộc** | iPhone **iOS 18.x** + iPhone **iOS 26.x**, máy thật — ⚠️ **suy luận từ `component-editor.md` §1, không có trong `stack-components.md`** (mục 1.3) |
| **iPad** | "Nếu có", đặc biệt cho SHR (máy nhận có thể là iPad) và RGT | Không có ⇒ ghi *Not run* |
| **Ngôn ngữ máy** | Tiếng Việt bắt buộc + 1 trong {Đức, Nhật} theo §1.03; ⚠️ TB-06/O-3 — nhân đôi ma trận nếu "Light/Dark" hoá ra là OS appearance (mục 5.10) |
| **Ngôn ngữ mở rộng (nếu có tester)** | it, ru — chỉ cho SC-68/70 (out of scope #13 nếu không có người đọc hiểu) |
| **Vùng/region đặc biệt** | VN hoặc CN (Lunar date mặc định bật, SC-27); vùng có DST sắp xảy ra trong kỳ test (SC-32, ⚠️ TB-14 không có cách dựng chuẩn); vùng dùng lịch Phật giáo — Thái (SC-44) |
| **2 thiết bị** | 1 máy **gửi** + 1 máy **nhận** (khác Apple ID) — bắt buộc cho nhóm SHR |
| **Build cũ (nếu có)** | Cho MIG xuôi (SC-81) và EX-4 (migration ngược, nếu có build cũ hơn để cài) |
| **Không dùng** | Simulator cho nhóm RGT (lock screen thật/Live Activity/widget); ảnh 1.2.17/1.2.18/1.2.15 làm oracle hình ảnh cho nội dung component mới |

**Dữ liệu/test-data chuẩn bị trước:**

| # | Dữ liệu | Dùng cho |
|---|---|---|
| 1 | Lịch thật: vài sự kiện hôm nay, một ngày ≥3 sự kiện trong tuần, một sự kiện cả ngày, một lịch ngày lễ/sinh nhật bật | AGD, TKT, DLP, TAG, KNW |
| 2 | Reminders có vài việc, ít nhất một việc có giờ | TAG (SC-29) |
| 3 | Ngày **"rảnh"** (0 sự kiện, định nghĩa còn mở — thử nhiều cách hiểu) | DLP (SC-25) |
| 4 | Dữ liệu đủ dựng tình huống **tràn chiều dọc** cho Agenda (nhiều ngày, nhiều sự kiện/ngày) | AGD (SC-08) |
| 5 | Mốc ngày Milestones đã tồn tại **chưa đặt tên** ("Untitled") | MLS (EX-6) |
| 6 | ≥1 mốc ngày **Every year** đã qua trong năm | MLS (SC-39) |
| 7 | Bảng Card palette có **ít màu hơn số thẻ** (test lặp màu) | MLS (SC-41, nếu dev bổ sung quy tắc) |
| 8 | Wallpaper có **nhiều band mới nặng dữ liệu cùng lúc** (Agenda 14 ngày + Milestones nhiều thẻ + Workout + Today at a glance) | PRF (SC-83, 84) |
| 9 | Bố cục **Row/Column** có ô trống + Row 2 con chứa component cao/nhiều dòng | NST (SC-85, 87) |
| 10 | Container ở **cấp 3** (vd `Column > Row > Column`) | NST (SC-88) |
| 11 | Template chứa **cả 7 component mới** để test RGT (lock screen/Live Activity/widget) | RGT (SC-76…80) |
| 12 | Wallpaper lưu ở **build cũ** (chưa có component mới) | MIG (SC-81) |
| 13 | Template có **Milestones + Event tickets + Workout** để share | SHR (SC-71, 72, 89) |
| 14 | Template có **ảnh chọn từ máy** làm thẻ nền để share | SHR (SC-73) |
| 15 | Máy đã **tắt bàn phím Emoji** trong Cài đặt | EMJ (SC-61) |
| 16 | **Baseline screenshot trên build thật** của 6 component mới + `Month heatmap` đã render trên canvas — **hiện không có**, cần chụp trước (entry E2) | Oracle trực quan cho mọi nhóm nội dung |

---

## 8. Entry criteria

> Theo §5.1.3. Cột "Hiện trạng" phản ánh thực tế tại 2026-10-03.

| # | Tiêu chí | Hiện trạng |
|---|---|---|
| E1 | **Build/branch/PR chứa 6 component mới đã được xác định chính thức** (không chỉ ghi chú của QC trong `index.md`) | ⬜ **chưa có** — test basis không có mã định danh (TB-05) |
| E2 | **Baseline screenshot trên build thật** đã chụp cho 6 component mới + `Month heatmap` **đã render trên canvas** (không chỉ sheet Add) | ⬜ **chưa có** — chỉ có 3 ảnh sheet Add (O-23) |
| E3 | Test plan này = READY (có điều kiện) và `test-cases-stack-components.md` đã tạo + được duyệt *(orchestrator quyết định gọi `test-case`)* | ⬜ chưa có test-case |
| E4 | Test data mục 7 (đặc biệt #4, #8, #9, #11, #16) sẵn sàng | ⬜ chưa xác nhận |
| E5 | Thiết bị: ≥1 iPhone iOS 18.x **và** ≥1 iPhone iOS 26.x, máy thật; **2 thiết bị** (gửi/nhận) cho nhóm SHR | ⬜ chưa xác nhận |
| E6 | **O-26 đã có quyết định owner** cho SC-71/72/73/89 (đợt này hay bộ `share-template-link`) | ⬜ **chưa có** — xem banner 🚩 |
| E7 | **Smoke test pass:** mở sheet Add component thấy đủ 23 mục/6 nhóm (SC-02) + thêm được 1 component mới bất kỳ (SC-03). Fail ⇒ dừng, không chạy tiếp | ⬜ chưa chạy |
| E8 | `bugs/bug-log.md` rà soát — kiểm có bug nào gắn `Screen: customize` liên quan 6 component mới chưa | ⬜ chưa rà |
| E9 | Nhãn ⚠️/🔭/(ngoài test basis) đã được **giữ nguyên** trong test-case (kiểm chéo mục 12) | ⬜ chờ test-case |

## 8.1 Suspension & Resumption criteria

- **Dừng toàn bộ:** (a) mất dữ liệu **không phục hồi được** ở nhóm RGT/MIG (lock screen thật/Live Activity/
  widget hỏng vĩnh viễn, wallpaper gốc bị ghi đè); (b) phát hiện đang chạy **sai build** (quay lại xác nhận
  E1); (c) phát hiện **SC-23 bị xoá** hoặc **EX-6 mốc ngày biến mất** — dừng nhóm WKT/MLS để báo bug ngay vì
  đây là đường dẫn mất dữ liệu người dùng đã được cảnh báo trước.
- **Dừng cục bộ nhóm SHR** nếu phát hiện dữ liệu cá nhân **vẫn hiển thị** trên UI người nhận cho bất kỳ loại
  nào (Milestones/Event tickets/Workout) — đây là bug Security mức cao, cần escalate trước khi tiếp tục phần
  còn lại của nhóm.
- **Dừng cục bộ các condition ⚠️ "ngoài test basis"** (RGT/MIG/PRF/NST) nếu dev/PO xác nhận 4 nhóm này không
  thuộc đợt bàn giao ⇒ gỡ toàn bộ 14 condition, không ảnh hưởng 73 condition còn lại.
- **Resume:** chạy lại **từ đầu cụm đã suspend** sau khi có bản fix/xác nhận mới, không tiếp tục giữa chừng.

**Thứ tự thực thi gợi ý (§5.1.5):** ① E1–E2 xác nhận build + baseline → ② Smoke E7 → ③ INV (tồn kho nền) →
④ AGD/TKT/WKT/DLP/TAG/MLS (nội dung từng component, P1 trước) → ⑤ KNW (knob trên component cũ) → ⑥ EMJ →
⑦ LBL → ⑧ **SHR** (sau khi đã xác nhận E6 owner) → ⑨ **NST** (component mới trong container, cần nhóm trên đã
dựng được dữ liệu) → ⑩ **RGT** (sau cùng trong các nhóm nội dung — cần template đã có đủ 7 component) →
⑪ **MIG** → ⑫ **PRF** → ⑬ lặp toàn bộ trên iOS còn lại → ⑭ 7 phiên Exploratory (mục 5.16), có thể xen kẽ
giữa các cụm trên.

---

## 9. Exit criteria

**Đo lường:**
- Toàn bộ **44 test condition P1 scripted** đã chạy (trừ các condition thuộc Exploratory — xem dưới); **0 bug
  Critical/High còn mở** trong nhóm P1 (theo mapping mục 6.2).
- **P2 ≥ 90%** đã chạy (≥ 22/24); **P3** chạy đủ hoặc ghi lý do.
- **SHR: 4/4 đã chạy và 0 fail** (điều kiện Security cao, không chấp nhận "chạy một phần").
- **RGT: 5/5, MIG (phần xuôi) 1/1, NST 4/4 đã chạy** — nếu dev xác nhận 4 nhóm RGT/MIG/PRF/NST không thuộc
  phạm vi ⇒ loại khỏi exit, ghi rõ lý do thay vì tính "chưa chạy".
- Đã chạy trên **cả** iOS 18.x **và** iOS 26.x; VI **và** ngôn ngữ thứ hai đã chọn.
- **7 phiên Exploratory đã thực hiện** (hoặc ghi rõ lý do bỏ qua) — kết quả ghi nhận riêng, **không cộng vào**
  con số coverage scripted (điều kiện 2).

**Nhị phân:**
- **Regression RGT/MIG (xuôi)/NST đã chạy** — không rút gọn.
- **14 condition "ngoài test basis" (RGT/MIG/PRF/NST) đã chạy nhưng kết quả phải ghi rõ "oracle = tài liệu đối
  chiếu + quyết định user, chưa phải requirement của test basis"** — không được tuyên bố đây là xác nhận theo
  `stack-components.md`.
- **SC-23 và EX-6 đã chạy với kết quả rõ ràng** (kế hoạch tập còn/mất; mốc ngày còn/mất) — nếu phát hiện mất
  dữ liệu, bug **đã được log** trước khi tính exit, không được "pass cho qua" vì khớp mô tả cũ của tài liệu
  đối chiếu.
- **Phát biểu về privacy đúng theo điều kiện 3** trong báo cáo cuối: *"đã kiểm ở mức hiển thị UI phía người
  nhận; mức payload/network chưa nằm trong phạm vi đợt này"* — **cấm** phát biểu "đã test đầy đủ".
- **O-26 đã có quyết định owner bằng văn bản** trước khi tuyên bố SHR hoàn tất — nếu không, exit phải ghi rõ
  "chưa xác nhận owner, có rủi ro trùng/bỏ sót với bộ `share-template-link`".
- **Baseline screenshot (E2) đã chụp trên build thật** — nếu chưa chụp được trong đợt này, exit **phải** ghi
  rõ đây là limitation đã biết, không được im lặng bỏ qua.
- Mọi "Query → dev" từ nhãn ⚠️ (O-23, O-30, O-32, O-26, và các gap mở khác ở mục 6.4) có phản hồi hoặc được PO
  chấp nhận là known gap bằng văn bản.

---

## 10. Gap cần làm rõ trước khi execute

> Mục 10 = câu hỏi mà câu trả lời sẽ **đổi expected result hoặc scope**. Không dòng nào ở đây đang làm mất
> trạng thái READY (đã được user xử lý ở test-analysis hoặc là coordination gap mới của QC, không thuộc 5 lý
> do dừng bắt buộc của skill test-plan).

### 10A. Carried từ test-analysis — 3 câu ⚠️ không chặn

| # | Câu hỏi | Condition | Ghi chú |
|---|---|---|---|
| **O-23** | Có baseline ảnh render thật nào cho 6 component mới + `Month heatmap` không? | Toàn bộ nhóm nội dung (AGD…MLS, KNW) | **Là entry criterion E2** |
| **O-30** | Component mới nào được hỗ trợ ở Live Activity/widget/thumbnail? | SC-77, SC-78 | Không có oracle để phân loại pass/fail nếu component không xuất hiện |
| **O-32** | Ngưỡng hiệu năng định lượng + tập máy tối thiểu? | SC-83, SC-84, EX-5 | Hiện chỉ đánh giá cảm nhận định tính |

### 10B. Phát hiện mới ở mức test-plan — chưa có trong 3 câu ⚠️ trên

| # | Câu hỏi | Condition | Ghi chú |
|---|---|---|---|
| **O-26** | SC-71/72/73/89 thuộc bộ test nào — `stack-components` hay `share-template-link` slug `1-2-19`? | SC-71, SC-72, SC-73, SC-89 | **Là entry criterion E6** (mục 8) — QC đã đối chiếu và xác nhận 2 bộ không chồng nội dung, nhưng chưa ai nhận owner bằng văn bản |

### 10C. Các câu mở khác — giữ nguyên như test-analysis mục 4B, không lặp lại toàn bộ

Xem [test-analysis-stack-components.md](test-analysis-stack-components.md) mục 4B (O-2 … O-22, O-28) để tra
đầy đủ — **không lặp lại ở đây** để tránh lệch nguồn khi test-analysis cập nhật. Các câu này chỉ **giảm độ
chính xác** (giá trị biên, oracle định lượng, danh sách vùng/locale), đã được gắn nhãn ⚠️ trực tiếp trên từng
condition tương ứng ở mục 2/5 của file này.

---

## 11. Coverage gap — case chưa được test basis liệt kê

> Suy luận của **QC** (tách khỏi sự thật do test basis xác nhận). Không có expected result — chỉ dùng để ghi
> nhận quan sát hoặc bổ sung khi có oracle.

| # | Thiếu gì | Vì sao là gap | Ảnh hưởng đáng kể? |
|---|---|---|---|
| 1 | **Không có bất kỳ screenshot/wireframe baseline nào** cho nội dung đã render của 6 component mới + `Month heatmap` | TB-26/O-23 — chỉ có 3 ảnh sheet Add | **Cao** — entry criterion E2, chặn khả năng đối chiếu oracle trực quan cho mọi nhóm nội dung |
| 2 | **Không có mã build/branch/PR** | TB-05 | **Cao** — entry criterion E1 |
| 3 | **Ownership giữa SHR và bộ `share-template-link` chưa chốt** | O-26, QC phát hiện ở mức test-plan | **Cao** — rủi ro không bộ nào chạy case, hoặc chạy trùng |
| 4 | **`screen-name` mới trong flow `14_edit-wallpaper`** cho 6 component mới (nếu cần phân biệt khi chụp ảnh) chưa được thêm vào `screenshot-naming.md` §7.1 | Hệ quả của gap #1 | Thấp — chỉ là việc làm theo sau khi có build + baseline |
| 5 | **Regression "sống sót qua đêm" (Shortcut automation)** với 6 component mới | §11 của test basis không nhắc; `tf-117` cũng ghi nhận cùng loại gap cho cơ chế chung | Trung bình — đã ghi ở mục 3.1 (flow `03_shortcut-setup`), không tự thêm case vì test basis không đặt điều kiện |
| 6 | **Gate Pro cho 6 component mới** (có component nào thuộc Pro-only không?) | Test basis và `component-editor.md` đều không nêu | Trung bình — không đủ căn cứ viết case, không tự suy diễn |
| 7 | **Tổ hợp** nhiều knob mới cùng lúc trên cùng component (vd Fade past days + Icons Emoji + Style Week strip của Workout) | Mỗi knob được mô tả riêng lẻ trong test basis, chưa có tổ hợp | Trung bình — ứng viên bổ sung cho phiên Exploratory EX-1 |
| 8 | **Danh mục component chính thức** (tên UI ↔ tên code), kế thừa gap từ `tf-117` | Chưa được bàn giao | Trung bình |
| 9 | **Hành vi SHR khi người gửi và người nhận cùng dùng ngôn ngữ khác VI/EN** | Test basis §11 không nhắc tới tương tác này | Thấp — không có yêu cầu, chỉ ghi nhận nếu quan sát được bất thường |

---

## 12. Bảng tự kiểm — 4 điều kiện bắt buộc của việc duyệt READY

| # | Điều kiện | Được đáp ứng ở | Kết quả |
|---|---|---|---|
| 1 | Nhóm RGT/MIG/PRF/NST (SC-76…SC-88) ghi rõ **không có requirement trong test basis**, oracle = `component-editor.md` + quyết định user | Banner · mục 1.2 · mục 2 (cột Nguồn gốc + ghi chú cuối bảng) · mục 5.12–5.15 · mục 6.4 · Phụ lục A | ✅ |
| 2 | 7 vùng Exploratory (EX-1…EX-7) **không có expected result**, báo cáo phải tách bạch scripted/exploratory | Banner · mục 2 (ghi chú) · mục 5.16 (charter riêng) · mục 6.4 · mục 9 (exit) | ✅ |
| 3 | Privacy (SHR) chỉ kiểm **mức UI**, `SC-G8` giữ GAP, cấm phát biểu "đã test đầy đủ" | Banner · mục 2 (nhóm SHR) · mục 5.11 (🔒) · mục 6.4 · mục 9 (exit) | ✅ |
| 4 | Mọi quyết định diễn giải/mở-thu hẹp phạm vi của user **giữ nguyên trạng thái chưa xác nhận bởi dev**; SC-23 mang nguyên ô ghi chú report-bug-nếu-mất-dữ-liệu | Banner · mục 2 (WKT) · mục 5.4 (SC-23) · mục 6.4 | ✅ |

**Tự kiểm số liệu:** tổng **87** condition = INV 6 + AGD 6 + TKT 6 + WKT 7 + DLP 5 + TAG 5 + MLS 11 + KNW 10 +
EMJ 6 + LBL 8 + SHR 4 + RGT 5 + MIG 2 + PRF 2 + NST 4 = **87** ✓ · P1 44 · P2 24 · P3 19 ✓ (đối chiếu độc lập
với tổng test-analysis, khớp) · 2 `GAP` không sinh case (`SC-G3`, `SC-G8`) · 7 Exploratory lồng trong các
nhóm trên (không cộng dồn thêm vào 87).

---

## Phụ lục A — Traceability: Nguồn → Test condition → Nhóm test case dự kiến

> Chuỗi: Nguồn (test basis §N.MM, hoặc "spec đối chiếu + quyết định user" cho RGT/MIG/PRF/NST) → Test condition
> (SC-xx, test-analysis mục 2) → Nhóm test case (mã nhóm → `TC-<MÃ>-NN` do skill `test-case` cấp).

| Nguồn | Test condition | Nhóm | | Nguồn | Test condition | Nhóm |
|---|---|---|---|---|---|---|
| §1.04 + **Q-1=A** | 01–04, 74, 75 | INV | | §9.01–§9.05 | 57–62 | EMJ |
| §2.01–§2.04 | 05–10 | AGD | | §10.01–§10.06, §1.03 | 63–70 | LBL |
| §3.01–§3.04 | 11–16 | TKT | | §11.01–§11.02 + **Q-3** + **O-29** | 71–73, 89 | SHR |
| §4.01–§4.05 + **Q-2** | 17–23 | WKT | | **`component-editor.md` §11 + O-24** *(không map về test basis)* | **76–80** | **RGT** |
| §5.01–§5.04 | 24–28 | DLP | | **`component-editor.md` §11 + O-24** *(không map)* | **81, 82** | **MIG** |
| §6.01–§6.03 | 29–33 | TAG | | **`component-editor.md` §4.14 + O-24** *(không map)* | **83, 84** | **PRF** |
| §7.01–§7.09 | 34–44 | MLS | | **`component-editor.md` §5.07, §6.1, §6.2, §7, §10 #2 + O-25** *(không map)* | **85–88** | **NST** |
| §8.01–§8.04 + **Q-1=A** | 46–55 | KNW | | §11.01 (b/c chưa trả lời) + Q-3 | `SC-G3`, `SC-G8` | **không map** — GAP |

**Ngược lại:** mỗi condition trong test-analysis mục 2 được ánh xạ **đúng 1 nhóm** ở mục 2 của file này;
test-case tương lai phải trace `TC-<MÃ>-NN` → `SC-xx` → nguồn tương ứng (test basis §N.MM, hoặc "spec đối
chiếu + quyết định user" cho nhóm RGT/MIG/PRF/NST — **không** viết như thể đó là requirement của
`stack-components.md`).

---

**Bước tiếp theo:** báo cáo cho orchestrator. **Chỉ khi** orchestrator xác nhận Test Plan Status = `READY`
có điều kiện **và** entry criteria mục 8 đã đủ (đặc biệt **E1** build, **E2** baseline screenshot, **E6**
owner của nhóm SHR) → gọi skill `test-case` trên file này, với ràng buộc giữ nguyên toàn bộ nhãn ⚠️/🔭/(ngoài
test basis), không viết case có expected result cho 7 vùng Exploratory, và ghi rõ nhóm RGT/MIG/PRF/NST không
truy vết về test basis `stack-components.md`.
