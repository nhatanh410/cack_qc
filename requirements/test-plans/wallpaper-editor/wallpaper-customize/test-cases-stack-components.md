# Test Case Specification — Component lịch mới & knob mới (stack) · slug `stack-components`

> Thiết kế case theo [test-plan-stack-components.md](test-plan-stack-components.md) (ISTQB Foundation) — bám
> đúng kỹ thuật đã chọn ở mục 5 test plan. Giữ nguyên toàn bộ nhãn ⚠️/🔭/(ngoài test basis) theo 4 điều kiện bắt
> buộc ở banner test plan — **không** viết lại nhãn cho "gọn hơn" hay bỏ bớt.
> **Test basis:** [stack-components.md](../../../specs/wallpaper-editor/wallpaper-customize/stack-components.md)
> §1–§12.
> **Tài liệu đối chiếu (KHÔNG phải test basis — chỉ dùng làm oracle cho nhóm RGT/MIG/PRF/NST):**
> [component-editor.md](../../../specs/wallpaper-editor/wallpaper-customize/component-editor.md).
> **Test analysis (nguồn SC-xx, risk level, nhãn ⚠️/🔭):**
> [test-analysis-stack-components.md](test-analysis-stack-components.md) mục 2.
> **Đối chiếu ownership chưa chốt (SHR):** [test-plan-1-2-19.md](../../share-template-link/test-plan-1-2-19.md)
> — xem banner 🚩 O-26 của test plan, chưa ảnh hưởng nội dung case ở đây.

## Quy ước

- **Ưu tiên:** P1 (chặn phát hành) · P2 · P3 — lấy nguyên từ cột Ưu tiên của test-analysis mục 2 / mục 6 test
  plan. Không tự đổi.
- **🔭 Exploratory** — case **không có expected result cố định**. Áp dụng cho 2 loại:
  1. 7 vùng charter EX-1…EX-7 (mục 13 dưới cùng) — không viết dưới dạng bảng case ID/bước/kết quả như các nhóm
     scripted, mà viết charter theo đúng mục 5.16 test plan.
  2. 2 rule Decision Table **không có quy tắc** mà test plan tự ghi "không tự suy diễn" (M2, M3 nhóm MLS) —
     vẫn giữ dạng bảng case (vì đến từ Decision Table đã chọn), nhưng cột "Kết quả mong đợi" ghi **"Phải quan
     sát/ghi lại"** thay vì PASS/FAIL, kèm ghi chú gửi dev (O-14).
- **⚠️ Phụ thuộc gap mở / oracle chưa đầy đủ** — case vẫn có kết quả mong đợi cụ thể (lấy đúng câu chữ test
  basis) nhưng độ chính xác giảm vì một TB-xx/O-xx còn mở (xem test-analysis mục 1B/4B). Chạy và ghi nhận thực
  tế, **không** tự đoán trước câu trả lời của dev.
- **🚫 Ngoài test basis (điều kiện 1 của test plan)** — 14 case thuộc nhóm **RGT/MIG/PRF/NST** (SC-76…SC-88)
  **không** truy được về `stack-components.md`; oracle = `component-editor.md` + quyết định phạm vi của user
  (O-24/O-25). Nếu dev/PO xác nhận 4 nhóm này **không** thuộc đợt bàn giao → gỡ toàn bộ 14 case, không ảnh
  hưởng các case còn lại.
- **🔒 UI-level only (điều kiện 3)** — 4 case nhóm **SHR** (SC-71/72/73/89) chỉ kiểm **mức hiển thị UI** của máy
  người nhận. **Cấm** mở rộng sang kiểm payload/network/log — đó là `SC-G8`, giữ `GAP`, không có case.
- **SC-23 (nhóm WKT, Reset Workout)** — mang nguyên ghi chú bắt buộc: nếu thực thi thấy kế hoạch tập **bị xoá**
  sau khi bấm Reset ⇒ **REPORT BUG NGAY**, không phải lỗi thiết kế test case, không tự "sửa" expected result
  cho khớp hành vi quan sát được trên build.
- **2 `GAP` không sinh case:** `SC-G3` (Month progress → Custom, end ≤ start — thiếu requirement) và `SC-G8`
  (audit payload/network khi share — descope có chủ đích của user). Ghi chú tại đúng vị trí Decision Table liên
  quan (nhóm KNW cho `SC-G3`), không viết case.
- **🆕** — không dùng trong file này; mọi case đều truy được về đúng 1 dòng ở mục 5 test plan, không có case
  error-guessing tự thêm ngoài phạm vi.
- **Môi trường mặc định mọi case** (không lặp lại trong từng case): build ghi nhận "1.2.19" — **CHƯA xác nhận
  chính thức** (entry E1 test plan, dừng lại xác nhận đúng build trước khi chạy thật); máy thật; chạy đủ **cả**
  iPhone iOS 18.x **và** iPhone iOS 26.x (trừ case ghi chú khác); ngôn ngữ máy **VI bắt buộc** + 1 trong {DE,
  JA} cho case liên quan localization; dữ liệu chuẩn bị theo mục 7 test plan (lịch thật, Reminders, test data
  riêng ghi ở từng nhóm bên dưới khi cần).
- **Ảnh bằng chứng:** lưu vào `screenshots/<mã nhóm>/`, quy ước đặt tên tại
  [screenshots/README.md](screenshots/README.md).

---

## 1 · INV — Sheet Add component & tồn kho · `TC-INV` (mục 5.1 test plan, SC-01…04, 74, 75)

> INV-03…INV-08 là 6 case EP (mỗi component mới = 1 partition) cho cùng 1 condition **SC-03** — cơ chế Add
> dùng chung đã được `tf-117` kiểm riêng, ở đây chỉ xác nhận 6 loại mới đi đúng mạch đó. Có thể gộp chạy liên
> tục: mở sheet Add 1 lần, thêm lần lượt cả 6 component không cần đóng/mở lại sheet giữa các lần.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| INV-01 | Mở Customize → Layout → **Add**. Kiểm tên 6 component mới | Đủ 6 tên đúng chính tả: Agenda, Event tickets, Workout, Daily page, Today at a glance, Milestones (§1.04 + §2–§7 test basis) | P2 |
| INV-02 | Trong sheet Add, đếm tổng số mục, số nhóm, xác nhận nhóm **Fitness** (chứa Workout) và **Month heatmap** nằm trong nhóm Calendar | Kỳ vọng 23 mục / 6 nhóm. ⚠️ Oracle **chỉ là ảnh batch 8** (TB-05/TB-26) — ghi lại số thực tế quan sát được để đối chiếu, không tự làm tròn cho khớp số 23 nếu lệch | P2 ⚠️ |
| INV-03 | Thêm **Agenda** qua nút Add | Component xuất hiện trên canvas, toast *"Added …"* kèm **Undo**, rơi đúng chỗ theo quy tắc chèn hiện có | P1 |
| INV-04 | Thêm **Event tickets** qua nút Add | Như INV-03 | P1 |
| INV-05 | Thêm **Workout** qua nút Add | Như INV-03 | P1 |
| INV-06 | Thêm **Daily page** qua nút Add | Như INV-03 | P1 |
| INV-07 | Thêm **Today at a glance** qua nút Add | Như INV-03 | P1 |
| INV-08 | Thêm **Milestones** qua nút Add | Như INV-03 | P1 |
| INV-09 | Trong sheet Add, kiểm 6 component mới có icon minh hoạ + mô tả 1 dòng | Mỗi mục có icon + mô tả, không rỗng | P3 ⚠️ (TB-26 — chưa có text chuẩn để đối chiếu từng chữ, so sánh tương đối) |
| INV-10 | Trong nhóm Calendar, tìm **Month heatmap**, đọc mô tả, thêm qua Add | Có mặt, mô tả *"The month, each day shaded by how busy it is."*; thêm được → band xuất hiện trên canvas + toast *"Added …"* | P1 ⚠️ nguồn = **Q-1=A** (quyết định user), **không có trong test basis**; chỉ phủ "tồn tại & thêm được" — hành vi sâu = 🔭 **EX-3** |
| INV-11 | Quan sát icon minh hoạ của **Month heatmap** trong sheet Add | Ghi lại icon hiển thị gì — ⚠️ ảnh batch 8 cho thấy ô icon **trống** (O-28). **Không tự kết luận** đây là bug hay UI chưa xong, chỉ ghi nhận quan sát kèm ảnh để dev phân loại | P2 ⚠️ |

---

## 2 · AGD — Agenda · `TC-AGD` (mục 5.2 test plan, SC-05…10)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| AGD-01 | Thêm Agenda, không đổi knob nào | Bố cục mặc định: **7 ngày tới**, gom theo ngày, cột trái thứ + số ngày to, mỗi sự kiện là khối màu có vạch trái, tên đậm, giờ bên phải (§2.01) | P1 ⚠️ TB-26 (chưa có ảnh baseline) |
| AGD-02 | Knob **Days** = **1** | Hiển thị đúng 1 ngày | P2 ⚠️ TB-08 — chỉ 2 điểm mẫu test basis cho biết, **không** BVA thêm biên ngoài 2 điểm này vì không rõ min/max |
| AGD-03 | Knob **Days** = **14** | Hiển thị đúng 14 ngày | P2 ⚠️ TB-08 |
| AGD-04 | Knob **Events per day** = **1**, chọn ngày có nhiều hơn 1 sự kiện | Dòng **+N more** hiện, N = đúng số sự kiện bị ẩn | P2 ⚠️ TB-08 |
| AGD-05 | Dựng dữ liệu đủ nhiều ngày/sự kiện để Agenda tràn chiều dọc (test data #4 mục 7 test plan) | Bỏ **ngày xa nhất trước**, **không** cắt một ngày làm đôi | P1 ⚠️ TB-09 — test basis không nêu điều kiện kích hoạt tràn; tester tự dựng tình huống bằng cách tăng dần Days/Events per day tới khi quan sát được, **ghi lại cách dựng** khi báo bug |
| AGD-06 | Tắt **Show title** | Mất đúng phần title ở đầu band, phần còn lại không xô lệch | P3 |
| AGD-07 | Tắt **Date range** | Mất đúng phần date range ở đầu band, phần còn lại không xô lệch | P3 |
| AGD-08 | Có sự kiện **cả ngày** trong khoảng hiển thị | Hiện **"All day"** thay cho giờ | P2 |

---

## 3 · TKT — Event tickets · `TC-TKT` (mục 5.3 test plan, SC-11, 13…16 — SC-12 = 🔭 EX-2, không viết case ở đây)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TKT-01 | Thêm Event tickets, **chưa ghim** sự kiện nào từ lịch | Hiện **sự kiện sắp tới** theo thứ tự thời gian | P1 ⚠️ TB-10 — không rõ số lượng vé hiển thị tối đa |
| TKT-02 | Ticket style = **Classic** | Render đúng kiểu Classic, không vỡ bố cục | P1 ⚠️ TB-26 |
| TKT-03 | Ticket style = **Admit** | Render đúng kiểu Admit, không vỡ bố cục | P1 ⚠️ TB-26 |
| TKT-04 | Ticket style = **Side stub** | Render đúng kiểu Side stub, không vỡ bố cục | P1 ⚠️ TB-26 |
| TKT-05 | Ticket style = **Poster** | Render đúng kiểu Poster, không vỡ bố cục | P1 ⚠️ TB-26 |
| TKT-06 | Đổi lần lượt các **Color scheme** có sẵn | Vé đổi màu theo từng scheme, chữ **vẫn đọc được** trên mọi scheme | P2 ⚠️ TB-11 — không có ngưỡng contrast, chỉ kiểm "không trùng hẳn màu nền" |
| TKT-07 | Tắt **Cover** | Vé gọn lại, **không chừa khoảng trống** chỗ Cover | P1 |
| TKT-08 | Tắt **Location** | Vé gọn lại, **không chừa khoảng trống** chỗ Location | P1 |
| TKT-09 | Tăng cỡ chữ (Style → cỡ chữ) lên mức cao nhất | Vé **cao lên theo**, chữ **không tràn** ra ngoài vé | P1 ⚠️ TB-11 |

---

## 4 · WKT — Workout · `TC-WKT` (mục 5.4 test plan, SC-17…23)

> **State Transition** WKT-01/02 chỉ chèn đúng 1 transition hợp lệ mỗi case (không trộn với case khác) theo
> đúng nguyên tắc tránh defect masking (§4.2.4 syllabus).

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| WKT-01 | {Ngày trống của Weekly plan} → chạm → {sheet chọn môn} → chọn môn + đặt tên + chi tiết → **Lưu** | {Nội dung hiện đúng trên band} | P1 |
| WKT-02 | {Ngày trống} → chọn **Rest** | {Ngày đó mờ đi trên band} | P3 |
| WKT-03 | Chuyển Style **List** → **Week strip** (cùng dữ liệu kế hoạch tập) | Hai kiểu render **khác nhau rõ rệt**, cùng đúng dữ liệu | P2 ⚠️ TB-26 |
| WKT-04 | Đổi Icons **Symbol** ↔ **Emoji** | Nguồn icon đổi đúng theo lựa chọn (liên quan ô emoji — xem nhóm EMJ) | P2 |
| WKT-05 | Bật **Fade past days**, kiểm ngày **23:59** (chưa qua nửa đêm) | Ngày hôm nay **chưa** bị coi là "đã qua" — chưa fade | P2 |
| WKT-06 | Cùng case trên, kiểm ngay sau **00:01** của ngày kế tiếp | Ngày vừa qua **đã** fade đúng ranh giới nửa đêm, không lệch theo giờ máy | P2 |
| WKT-07 | Có ngày kế tiếp gần nhất với kế hoạch → kiểm dòng **Up next**; tắt **Decorative icons** | Dòng Up next có icon mũi tên khi bật; tắt Decorative icons → **mất icon**, dòng Up next vẫn còn | P3 |
| WKT-08 | Đặt tên/chi tiết cho 1 ngày kế hoạch tập → bấm **Reset** của thành phần Workout | **Kế hoạch tập vẫn còn** (expected result theo đúng §4.05, quyết định **Q-2** của user). **Nếu thấy kế hoạch tập bị xoá ⇒ REPORT BUG NGAY** — không phải lỗi test case, không tự "sửa" expected result cho khớp hành vi Reset của Content→Quote ở `component-editor.md` §7 (mâu thuẫn đã biết, dev **chưa** xác nhận) | **P1** ⚠️ |

---

## 5 · DLP — Daily page · `TC-DLP` (mục 5.5 test plan, SC-24…28)

> Decision Table copy nguyên 3 rule D1–D3 từ mục 5.5 test plan — không thêm/bớt rule.

| ID | Rule/Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| DLP-01 (D1) | Daily page ở ngày **thường, có sự kiện** | Số ngày to + thứ + danh sách sự kiện hôm nay đúng dữ liệu máy | P1 ⚠️ TB-26 |
| DLP-02 (D2) | Daily page ở ngày **"rảnh"** (test data #3 mục 7 test plan — thử nhiều cách hiểu "rảnh") | Hiện **một câu trích dẫn** thay cho danh sách sự kiện | P2 ⚠️ TB-12 — chưa định nghĩa "rảnh" và nguồn câu trích dẫn; ghi lại cách hiểu đã dùng khi báo kết quả |
| DLP-03 (D3) | Daily page ở ngày **lễ** (lịch ngày lễ đã bật) | **Tên lễ to**, sự kiện của ngày đó liệt kê **bên dưới** | P1 |
| DLP-04 | Máy vùng **VN** (hoặc CN), bật Daily page | **Lunar date mặc định bật** | P1 ⚠️ TB-13 |
| DLP-05 | Máy vùng **US** (ngoài tập VN/CN), bật Daily page | **Lunar date mặc định tắt**. **Không** kiểm biên KR/TW/HK/SG/JP — danh sách bỏ lửng, out of scope | P1 ⚠️ TB-13 |
| DLP-06 | Có cả dòng âm lịch và ngày lễ hiển thị; tắt **Decorative icons** | Icon trăng (âm lịch) + icon pháo giấy (ngày lễ) hiện khi bật; tắt Decorative icons → **mất icon** | P3 |

---

## 6 · TAG — Today at a glance · `TC-TAG` (mục 5.6 test plan, SC-29…33)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TAG-01 | Thêm Today at a glance, tắt riêng **sự kiện chính** | Mất đúng phần sự kiện chính, 3 phần còn lại dồn lên, không chừa khoảng trống | P1 |
| TAG-02 | Tắt riêng **thanh giờ** | Mất đúng phần thanh giờ, phần còn lại dồn lên | P1 |
| TAG-03 | Tắt riêng **việc cần làm** | Mất đúng phần việc cần làm, phần còn lại dồn lên | P1 |
| TAG-04 | Tắt riêng **giờ rảnh** | Mất đúng phần giờ rảnh, phần còn lại dồn lên | P1 |
| TAG-05 | Bật đủ 4 phần, dùng data chuẩn bị (lịch + Reminders mục 7 test plan) | 4 phần hiển thị đúng dữ liệu lịch + Reminders của máy | P1 ⚠️ TB-26 |
| TAG-06 | Kiểm nhãn có icon (mặt trời, checklist), icon lá ở giờ rảnh; tắt **Decorative icons** | Icon hiện khi bật; tắt → mất icon | P3 |
| TAG-07 | Trên máy ở vùng có DST, test đúng ngày chuyển DST sắp tới trong kỳ test | Thanh giờ **không lệch một tiếng** | P1 ⚠️ TB-14 — **chưa có phương tiện dựng chuẩn**; nếu máy/kỳ test không có điều kiện DST phù hợp, ghi **"Not run — thiếu điều kiện dựng"**, không suy diễn |
| TAG-08 | Có khoảng trống giữa các sự kiện trong ngày, kiểm phần giờ rảnh | Giờ rảnh thể hiện đúng vị trí khoảng trống ở mức **hợp lý thô** | P1 ⚠️ TB-15 — chỉ kiểm "có khoảng trống đúng chỗ", không chốt đúng thuật toán |

---

## 7 · MLS — Milestones · `TC-MLS` (mục 5.7 test plan, SC-34, 35, 37…44 — SC-36 = 🔭 EX-6, không viết case ở đây)

> ⚠️ **Lưu ý khi đối chiếu mục 5.7 test plan:** mục 2/Phụ lục A test plan xếp **11** condition cho nhóm MLS
> (SC-34…SC-44), nhưng phần narrative mục 5.7 chỉ liệt tên tường minh **10/11** — thiếu **SC-37** (*"Tiêu đề
> sheet = tên ngày; chưa có tên → 'New day' (mới) / 'Untitled' (cũ)"*) trong danh sách "EP còn lại". Đây là một
> condition đơn giản, có nguồn trực tiếp §7.02 test basis, cùng loại Checklist/EP với các dòng đã có trong cùng
> bucket "EP còn lại" của đúng nhóm này (không phải kỹ thuật khác, không có ambiguity) — case **MLS-04** dưới
> đây được viết dựa trên §7.02 trực tiếp. **Ghi rõ cho người review:** đây là một khoảng hở biên tập ở mục 5.7
> test plan (bỏ sót liệt kê, không phải thiếu kỹ thuật hay mâu thuẫn Decision Table), nên không dừng pipeline,
> nhưng nên được xác nhận lại ở `qc-test-plan` lần tới.

**BVA — văn bản đếm ngày (SC-38), quanh ±1 ngày và nửa đêm:**

| ID | Mốc / Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| MLS-01 | Milestone ở **tương lai xa** (≥ 2 ngày nữa) | *"còn N ngày"* | P1 |
| MLS-02 | Milestone **ngày mai** (+1) | Dạng chữ ("Tomorrow"/tương đương) | P1 |
| MLS-03 | Milestone **hôm nay** (biên giữa, 0) | **"Today"** | P1 |
| MLS-04 | Milestone **hôm qua** (−1) | Dạng chữ ("Yesterday"/tương đương) | P1 |
| MLS-05 | Milestone **quá khứ xa** (≤ −2 ngày) | *"đã N ngày"* | P1 |
| MLS-06 | Quan sát đúng lúc đồng hồ máy chuyển từ **23:59 → 00:01** ngày kế | Mốc đổi đúng lúc sang ngày mới, **không lệch theo giờ múi/giờ máy** | P1 |

**Decision Table — Card palette xoay vòng màu (SC-41), copy nguyên 3 rule M1–M3:**

| ID (Rule) | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| MLS-07 (M1) | Card palette ≠ Plain, có thẻ "hôm nay" ở **giữa** danh sách | Thẻ hôm nay = **màu nhấn**; thẻ ngay sau = **màu đầu** bảng | P1 |
| MLS-08 (M2) | Card palette ≠ Plain, có thẻ "hôm nay" ở **cuối** danh sách | **Phải quan sát/ghi lại** — test basis **không có quy tắc** cho vị trí này, **không tự suy diễn** "thẻ ngay sau" là gì. Ghi nhận quan sát, báo dev (O-14) | P1 🔭 |
| MLS-09 (M3) | Card palette ≠ Plain, **không có** thẻ "hôm nay" nào trong danh sách | **Phải quan sát/ghi lại** — test basis **không có quy tắc** cho điểm bắt đầu xoay vòng màu khi không có mốc "hôm nay". Ghi nhận quan sát, báo dev (O-14) | P1 🔭 |

**EP còn lại (checklist):**

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| MLS-10 | Bấm **Add a day** | Sheet mở **ngay** (không chờ, không qua bước trung gian) | P2 |
| MLS-11 | Thêm ngày mới, **không đặt tên**, đóng sheet | Ngày đó **tự biến mất**, không để lại thẻ rỗng | P1 |
| MLS-12 | Mở sheet của 1 ngày **mới** chưa đặt tên; mở sheet của 1 ngày **cũ** đã tồn tại chưa đặt tên | Tiêu đề sheet = tên ngày khi đã có tên; chưa có tên → **"New day"** (ngày mới) / **"Untitled"** (ngày cũ) | P3 ⚠️ case bổ sung từ §7.02 trực tiếp — xem lưu ý đầu nhóm MLS về khoảng hở mục 5.7 test plan |
| MLS-13 | Milestone **Every year**, có ≥1 mốc đã qua trong năm (test data #6 mục 7) | Đếm tới **lần kế tiếp** (kể cả khi mốc trong năm đã qua); badge số năm cạnh tên (*"6 years"*) **dịch theo ngôn ngữ máy** | P1 |
| MLS-14 | Milestone có số ngày đếm **≥ 4 chữ số** | Icon lịch phía trước vẫn còn; số co lại, **không tràn thẻ** | P2 |
| MLS-15 | Bật **Card pattern** | In hoạ tiết lên **từng thẻ ngày**; **thẻ nền** (card ngoài band) **không có** mục hoạ tiết/ảnh | P3 |
| MLS-16 | Tắt **Birthdays & holidays** | Chỉ còn ngày tự thêm, mất sinh nhật/lễ từ lịch hệ thống; bật lại → có thêm | P2 |
| MLS-17 | Máy dùng **lịch Phật giáo (Thái)**, thêm 1 ngày | Lưu đúng **năm dương lịch**, đếm đúng (không lệch 543 năm) | P1 |

---

## 8 · KNW — Knob mới trên component cũ · `TC-KNW` (mục 5.8 test plan, SC-46…55; `SC-G3` = GAP, không viết case)

> **Ghi chú bắt buộc cho tester:** đây là knob trên component **Week events** đã có sẵn, **khác** component
> `Month heatmap` (nhóm INV, SC-74, phạm vi tháng) và **khác** `Activity grid` (đã có từ trước) — ba thứ không
> được gộp nhầm khi báo cáo.

**EP — Week events Style (3 giá trị, độc lập với `Month heatmap`):**

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| KNW-01 | Week events → Style, xác nhận đủ 3 giá trị **Bars / Dots / Heat map** tồn tại | Cả 3 giá trị chọn được, knob giữ nguyên như §8.01 | P1 |
| KNW-02 | Style = **Dots**, có ngày > 4 sự kiện | Mỗi sự kiện 1 chấm, **4 chấm/hàng**, ngày nhiều hơn 4 sự kiện **xuống hàng** | P2 |
| KNW-03 | Style = **Heat map** (phạm vi tuần), có ngày ≥2 sự kiện và trường hợp hoà | Ô đậm theo số sự kiện; ngày bận nhất có **ngọn lửa** khi **≥2** sự kiện; **hoà** → mọi ngày bằng nhau đều có lửa | P1 ⚠️ TB-19 — thiếu thang độ đậm, chỉ kiểm điều kiện lửa; **không nhầm** với `Month heatmap` (tháng) hay `Activity grid` |
| KNW-04 | Style = **Bars** | Knob **Block opacity** và **+N more** **hiện** | P1 ⚠️ TB-20 — tên control lệch giữa 2 tài liệu, ghi lại tên thực tế thấy trên UI |
| KNW-05 | Style = **Dots** hoặc **Heat map** | Knob **Block opacity** và **+N more** **ẩn** | P1 ⚠️ TB-20 |

**BVA 3-value — ngưỡng màu Month progress (SC-51):**

| ID | Giá trị test (%) | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| KNW-06 | 74% | Chưa đổi màu (chưa cam) | P1 |
| KNW-07 | 75% | Đổi **cam** | P1 |
| KNW-08 | 89% | Vẫn cam, chưa đỏ | P1 |
| KNW-09 | 90% | Đổi **đỏ** | P1 |
| KNW-10 | Tắt công tắc ngưỡng màu | Thanh **giữ màu gốc**, không đổi theo % | P1 |

**Decision Table — Date range × vị trí hôm nay, copy nguyên K1–K4; K5 (end ≤ start) = `SC-G3`, GAP, không viết case:**

| ID (Rule) | Date range | Hôm nay so với khoảng | Kết quả mong đợi | Ưu tiên |
|---|---|---|---|:---:|
| KNW-11 (K1) | **This month** (mặc định) | — | Hiển thị đúng % theo tháng hiện tại | P2 |
| KNW-12 (K2) | **Custom**, vừa chọn | — | Tự điền **hôm nay** + **90 ngày**; hiện thêm ô **Title** | P2 ⚠️ TB-18(c) — "+90" có tính cả hôm nay hay không, chưa rõ; ghi lại ngày cuối thực tế quan sát được |
| KNW-13 (K3) | **Custom** | Hôm nay **trước** khoảng | **0%** | P1 |
| KNW-14 (K4) | **Custom** | Hôm nay **sau** khoảng | **100%** | P1 |
| — (K5) | **Custom**, end ≤ start | — | **= `SC-G3`, GAP — không viết case.** Thiếu requirement cho nhánh âm (TB-18b); nếu tester vô tình dựng được tình huống này trong lúc chạy K1–K4, ghi nhận quan sát riêng, không chấm pass/fail | — |

**Checklist — Priority matrix (kế thừa từ `tf-117`, chỉ kiểm phần knob mới):**

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| KNW-15 | Bật **Each box**, đổi màu riêng 4 ô (Do now/Plan/Delegate/Drop) | 4 màu riêng **đè** màu chung; tắt → quay về màu chung | P2 |
| KNW-16 | Bật **Box pattern** | In hoạ tiết lên **cả 4 ô**; thẻ nền Matrix **không còn** hoạ tiết/ảnh | P3 |
| KNW-17 | Kiểm trạng thái mặc định của **Strike out the Drop box**, rồi bật thử | Mặc định **TẮT**; bật → việc trong ô **Drop** bị **gạch ngang** | P3 |

---

## 9 · EMJ — Ô emoji (Milestones, Workout) · `TC-EMJ` (mục 5.9 test plan, SC-57…61 — SC-62 = 🔭 EX-7, không viết case ở đây)

> **State Transition** EMJ-01/02 chỉ chèn 1 transition mỗi case. **Decision Table** copy nguyên E1/E2; rule E3
> (dán/đọc chính tả) = 🔭 EX-7, không viết ở đây.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| EMJ-01 | {Ô emoji trống, placeholder mờ} → chạm | {Bàn phím mở **thẳng trang emoji**} → chọn 1 emoji → {lưu, bàn phím đóng} | P1 |
| EMJ-02 | {Ô emoji đã có emoji} → phím **xoá** | {Về **placeholder mờ**} — ⚠️ TB-22, không biết ký tự cụ thể của placeholder, ghi lại ký tự/hình thực tế quan sát được | P2 ⚠️ |
| EMJ-03 (E1) | Bàn phím Emoji **bật** (mặc định, Cài đặt hệ thống) → gõ chữ qua bàn phím thường | **Không nhận** ký tự chữ | P1 |
| EMJ-04 (E2) | Bàn phím Emoji **tắt** trong Cài đặt (test data #15 mục 7) → chạm ô | Hiện **bàn phím thường**, **vẫn chỉ nhận emoji**. ⚠️ TB-21 — không có oracle cho trải nghiệm ngõ cụt (không gợi ý/không thông báo theo test basis); **không tự thêm** mong đợi về UX, chỉ xác nhận hành vi nhận input | P1 ⚠️ |
| EMJ-05 | Kiểm ô emoji ở **Milestones** | Ô **vuông**, **cao bằng** ô tên bên cạnh | P3 |
| EMJ-06 | Kiểm ô emoji ở **Workout** | Ô **vuông**, **cao bằng** ô tên bên cạnh | P3 |

---

## 10 · LBL — Nhãn bảng chỉnh & localization · `TC-LBL` (mục 5.10 test plan, SC-63…70)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| LBL-01 | Mở bảng chỉnh, kiểm nhóm thứ ba | Tên **"Nền"** (Backdrop), **không** phải "Hình nền" | P3 |
| LBL-02 | Kiểm nhãn thẻ ở Matrix, Timeline, Milestones và thẻ sau cả band | Thẻ sau cả band = *Thẻ nền / Màu thẻ nền / Lề thẻ nền*; thẻ con: Matrix = "ô", Timeline = "thẻ sự kiện", Milestones = "thẻ" | P3 |
| LBL-03 | Week schedule → kiểm **Days shown** và nhãn chữ đầu cột | **Days shown** = *Mon – Fri* / *Full week*; chữ đầu cột = **Day header**. ⚠️ TB-25 — chưa rõ hành vi khi ngày đầu tuần là Chủ nhật, ghi lại quan sát nếu máy đặt vậy | P3 ⚠️ |
| LBL-04 | Mở bảng chỉnh Workout | Nhãn nhóm = **"Kế hoạch tuần"** (Weekly plan) | P3 |
| LBL-05 | Kiểm ô nhập tiêu đề trong bảng chỉnh bất kỳ component mới | Căn **trái** | P3 |
| LBL-06 | Quét các component **đã nêu tên cụ thể** trong test basis, tìm dòng trùng tên | Không có 2 dòng trùng tên trong cùng 1 component. ⚠️ TB-23 — quét **có giới hạn**, không quét cạn kiệt 23 component × mọi knob (phạm vi không xác định) | P2 ⚠️ |
| LBL-07 | Máy ngôn ngữ **Tiếng Việt**, mở bảng chỉnh đủ 6 component mới + knob mới | Không chuỗi nào lọt tiếng Anh vào máy VI. ⚠️ TB-07 — thiếu bảng đối chiếu VI chính thức, tester tự đối chiếu bằng ngữ cảnh | P1 ⚠️ |
| LBL-08 | Máy ngôn ngữ **thứ hai** (DE hoặc JA, theo thiết bị test có), mở bảng chỉnh đủ 6 component mới + knob mới | Không chuỗi nào lọt tiếng Anh. ⚠️ TB-07 | P1 ⚠️ |
| LBL-09 | **Chỉ chạy nếu có tester đọc hiểu DE hoặc JA** — mở ô **Drop** của Matrix (widget và form nhắc nhở) | Không còn mang nghĩa "giọt nước". Nếu không có tester phù hợp → ghi **"Not run — thiếu tester ngôn ngữ"** (it/ru ngoài phạm vi, xem out of scope #13 test plan) | P2 ⚠️ TB-24 |

---

## 11 · SHR — Chia sẻ template (UI-level only) · `TC-SHR` (mục 5.11 test plan, SC-71, 72, 73, 89)

> 🔒 **Nhắc lại bắt buộc:** 4 case dưới đây **chỉ** kiểm mức UI của máy người nhận. **Không** mở rộng sang
> payload/network/log — đó là `SC-G8`, giữ `GAP`. Cần **2 thiết bị** (gửi/nhận, khác Apple ID — mục 7 test
> plan). Phát biểu kết quả đúng duy nhất: *"đã kiểm ở mức hiển thị UI phía người nhận; mức payload/network
> chưa nằm trong phạm vi đợt này."*

| ID | Bước thực hiện | Kết quả mong đợi (mức UI người nhận) | Ưu tiên |
|---|---|---|:---:|
| SHR-01 | Máy gửi: tạo template có **Milestones** với tên/ngày riêng → Share link → máy nhận mở link | Trên UI máy nhận, **không hiển thị** tên/ngày riêng của người gửi. ⚠️ TB-03c — chưa có oracle cho "thấy gì thay thế" (rỗng/placeholder/mẫu) — ghi lại **cụ thể cái gì hiện ra thay vào chỗ đó** | P1 🔒 |
| SHR-02 | Máy gửi: template có **Event tickets** đã ghim sự kiện → Share link → máy nhận mở link | Trên UI máy nhận, **không hiển thị** sự kiện đã ghim của người gửi. ⚠️ TB-03c | P1 🔒 |
| SHR-03 | Máy gửi: template có **ảnh chọn từ máy** làm thẻ nền (test data #14 mục 7) → Share link → máy nhận mở link | Ảnh **không đi theo link** — đối chiếu `template-sharing-api.md`: `backgroundImagePath`/`backgroundSourcePath` = `null`, "No file paths" | P1 🔒 |
| SHR-04 | Máy gửi: template có **Workout** với kế hoạch tập (tên môn, chi tiết, emoji) → Share link → máy nhận mở link | Trên UI máy nhận, **không hiển thị** kế hoạch tập của người gửi (tên môn/chi tiết/emoji). ⚠️ mở rộng phạm vi theo quyết định **O-29** của user — §11 test basis **không** nhắc Workout, đây **không** phải requirement gốc. ⚠️ TB-03c | P1 🔒 |

---

## 12 · RGT — Regression render thật 🚫 ngoài test basis · `TC-RGT` (mục 5.12 test plan, SC-76…80)

> 🚫 **Toàn nhóm này không truy được về `stack-components.md`.** Oracle = `component-editor.md` §11 + quyết
> định phạm vi **O-24** của user. Nếu dev/PO xác nhận nhóm M (RGT) không thuộc đợt bàn giao → gỡ 5 case này,
> không ảnh hưởng case khác. Cần template chứa **cả 7 component mới** (test data #11 mục 7 test plan). Máy
> thật bắt buộc, **không** dùng simulator.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| RGT-01 | Đặt template (đủ 7 component mới) làm **lock screen thật** | Render **đúng như preview** trong Customize, kiểm trên cả 7 component mới | P1 🚫 |
| RGT-02 | Có **Live Activity** đang chạy, mở lock screen đã đặt | Live Activity **chạy**, **không vỡ layout**. ⚠️ **O-30** — không rõ component mới nào được hỗ trợ ở Live Activity; nếu component không xuất hiện, ghi nhận và không tự chấm fail | P2 🚫 ⚠️ |
| RGT-03 | Vào Discover → "Your collection", kiểm thumbnail + widget | Widget và thumbnail cập nhật theo bố cục có component mới. ⚠️ **O-30** | P2 🚫 ⚠️ |
| RGT-04 | Mở 1 template lịch **cũ** (chưa động vào, tạo trước đợt này) | Render **y như trước**, không bị ảnh hưởng bởi việc thêm 7 component mới | P1 🚫 |
| RGT-05 | Mở lại template **đã sửa** (có component mới) từ đợt trước, sửa tiếp 1 chi tiết | Bố cục **giữ nguyên**, sửa tiếp được bình thường | P1 🚫 |

---

## 13 · MIG — Migration dữ liệu template 🚫 ngoài test basis · `TC-MIG` (mục 5.13 test plan, SC-81 — SC-82 = 🔭 EX-4, không viết case ở đây)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| MIG-01 | Mở wallpaper lưu ở **build cũ** (chưa có component mới, test data #12 mục 7) bằng build đợt này | Bố cục **giữ nguyên**, **không mất band**, sửa tiếp được bình thường | P1 🚫 |

---

## 14 · PRF — Hiệu năng (quan sát định tính) 🚫 ngoài test basis · `TC-PRF` (mục 5.14 test plan, SC-83 phần script, 84 — phần đo định lượng = 🔭 EX-5, không viết case ở đây)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| PRF-01 | Dùng template có **nhiều band mới nặng dữ liệu cùng lúc** (Agenda 14 ngày + Milestones nhiều thẻ + Workout + Today at a glance, test data #8 mục 7) → chọn/kéo/cuộn trong canvas Customize | Canvas **mượt theo quan sát định tính**, không đứng hình. Không có số đo — chỉ ghi "mượt / giật / đứng hình" | P1 🚫 |
| PRF-02 | So sánh thời gian render & áp dụng wallpaper nặng (trên) với 1 template thường | Không tăng **bất thường** so với template thường — so sánh định tính, không có số. ⚠️ **O-32** — thiếu ngưỡng định lượng, chỉ ghi nhận cảm nhận | P2 🚫 ⚠️ |

---

## 15 · NST — Component mới lồng Row/Column 🚫 ngoài test basis · `TC-NST` (mục 5.15 test plan, SC-85…88)

> Decision Table copy nguyên 4 rule N1–N4. Cần test data #9, #10 mục 7 test plan (Row/Column có ô trống, Row
> chứa component cao/nhiều dòng, container cấp 3).

| ID (Rule) | Loại component | Vị trí | Kết quả mong đợi | Ưu tiên |
|---|---|---|---|:---:|
| NST-01 (N1) | Bất kỳ trong 7 component mới | Ô trống của Row/Column (bấm **+**) | Lấp đúng ô đó, ô còn lại **vẫn nguyên** | P2 🚫 |
| NST-02 (N2) | **Cao/nhiều dòng** (Agenda, Milestones, Workout, Event tickets) | Trong **Row** (còn nửa bề rộng) | Nội dung **xuống dòng/co lại hợp lý**, **không tràn**, **không bị cắt** — tổ hợp rủi ro nhất của nhóm | **P1** 🚫 |
| NST-03 (N3) | Bất kỳ trong 7 component mới | Trong Row/Column | **Không có thanh Size** (cố ý, kế thừa `component-editor.md` §10 #2); knob riêng vẫn chỉnh được | P3 🚫 |
| NST-04 (N4) | Bất kỳ trong 7 component mới | Cấp container thứ 3 | Nhóm **Layout biến mất** khỏi sheet Add | P3 🚫 |

---

## 16 · Charter Exploratory — EX-1…EX-7 (mục 5.16 test plan)

> **Không viết dưới dạng bảng case ID/bước/kết quả.** 7 vùng dưới đây **không có expected result** — chỉ
> charter định hướng phiên khám phá. Mọi quan sát bất thường trên đường dẫn xoá/mất dữ liệu (EX-6, EX-4) **phải**
> được ghi lại và báo dev, không tự kết luận "đúng thiết kế". Kết quả các phiên này **không** được cộng vào
> con số coverage scripted khi báo cáo (điều kiện 2 của test plan).

| Charter | Gắn với | Thời hộp | Mục tiêu quan sát | Cách ghi nhận |
|---|---|---|---|---|
| **EX-1** | Nhóm AGD, TKT, WKT, DLP, TAG, MLS | 30–45 phút/component | Khám phá chi tiết sâu 6 component mới (font, nguồn dữ liệu, tổ hợp knob) ngoài những gì checklist ở mục 2–8 nêu | Ghi chú tự do + ảnh chụp, gửi dev làm input cho acceptance criteria tương lai |
| **EX-2** | TKT (SC-12) | 20 phút | Tìm đường vào hành động "ghim" sự kiện; thử giới hạn số lượng, sự kiện đã ghim trôi qua/bị xoá | Ghi lại đường vào tìm được (nếu có) + hành vi quan sát |
| **EX-3** | INV (SC-74/75) | 20 phút | Hành vi chi tiết `Month heatmap` — thang độ đậm, phạm vi tháng, khác biệt với `Week events → Heat map` (tuần, KNW-03) và `Activity grid` | So sánh trực quan 3 thứ, ghi lại khác biệt quan sát được |
| **EX-4** | MIG (SC-82) | 20 phút | Migration ngược — mở wallpaper có component mới ở bản app cũ hơn (nếu có build cũ để cài) | Ghi lại: suy giảm êm? band trống? mất band? crash? |
| **EX-5** | PRF (SC-83 phần đo) | 20 phút | Cảm nhận hiệu năng định lượng (không có thước đo chính thức) — ước lượng fps bằng công cụ hệ thống nếu có | Ghi số liệu thô nếu đo được (vd Instruments), nêu rõ "không có ngưỡng tham chiếu" |
| **EX-6** | MLS (SC-36, **P1** — đường dẫn xoá dữ liệu) | 10 phút | Xoá trắng tên một mốc ngày **đã tồn tại** (Milestones) rồi đóng sheet — quan sát ngày đó còn/mất | **Nếu thấy mốc ngày biến mất im lặng → ghi nhận và báo dev ngay**, không tự kết luận |
| **EX-7** | EMJ (SC-62) | 10 phút | Dán (paste)/đọc chính tả vào ô emoji | Ghi lại ô nhận gì (emoji/bị chặn/crash) |

---

## 17 · Sổ GAP — không sinh test case (tham chiếu, không phải nhóm case)

| GAP | Nội dung | Vì sao không có case ở file này |
|---|---|---|
| **`SC-G3`** | Month progress → Custom với khoảng không hợp lệ (end ≤ start) | Xem dòng K5 ở nhóm KNW (mục 8) — không có requirement, không có expected result cho nhánh âm (TB-18b) |
| **`SC-G8`** | Audit riêng tư mức payload/network khi share (Milestones, Event tickets, Workout) | Descope có chủ đích của user (Q-3) — xem ghi chú 🔒 đầu nhóm SHR (mục 11); không phải thiếu sót |

---

**Tổng số case scripted trong file này: 115** (INV 11 · AGD 8 · TKT 9 · WKT 8 · DLP 6 · TAG 8 · MLS 17 · KNW 17
· EMJ 6 · LBL 9 · SHR 4 · RGT 5 · MIG 1 · PRF 2 · NST 4) + **7 charter Exploratory** (không chấm pass/fail) +
**2 `GAP`** không sinh case. Số case > số test condition (87) vì một số condition được triển khai thành nhiều
case theo kỹ thuật EP/BVA/Decision Table (ví dụ SC-03 → 6 case theo 6 component, SC-38 → 6 case BVA, SC-41 → 3
case theo 3 rule Decision Table…) — đây là cách tính coverage đúng theo kỹ thuật, không phải case thừa. Case
`MLS-12` (SC-37) là bổ sung có nguồn trực tiếp §7.02 test basis để lấp một khoảng hở biên tập ở mục 5.7 test
plan — xem ghi chú đầu nhóm MLS (mục 7).
