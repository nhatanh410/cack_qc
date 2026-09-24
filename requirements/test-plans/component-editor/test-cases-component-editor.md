# Test Case Specification — Wallpaper Component Editor

> Thiết kế case theo [test-plan-component-editor.md](test-plan-component-editor.md) (ISTQB Foundation) — bám
> đúng kỹ thuật đã chọn ở mục 5 test plan (State Transition cho SEL, EP + Checklist cho DRG, Decision Table +
> BVA cho RSZ/NST, EP + Decision Table cho ADD, Compatibility matrix cho DEV, Checklist-based cho ENT/PRP/LOC/REG/INT).
> Test basis: [QC — Component Editor 1.2.md](../../specs/wallpaper-component/QC%20—%20Component%20Editor%201.2.md)
> (TestFlight 1.2.17 (103), bảng thiết bị/OS đã sửa khớp PDF gốc).

## Quy ước

- **Ưu tiên:** P1 (chặn phát hành) · P2 · P3 — theo đúng mục 6 test plan, kế thừa nguyên trạng từ test-analysis.
- **🔭 Exploratory** — không áp dụng cho bộ case này: test basis 1.2.17 không tự khai phần nào là thăm dò thuần
  (khác `test-plan-ios26-27.md`). Toàn bộ case dưới đây có kỳ vọng cụ thể.
- **⚠️ Phụ thuộc gap mở** — case có thể đổi kết quả mong đợi sau khi dev trả lời 4 câu hỏi còn mở ở
  [test-plan mục 10](test-plan-component-editor.md#10-gap-cần-làm-rõ-trước-khi-execute) (câu #2–#5). Chạy và ghi
  nhận thực tế, **không tự suy đoán câu trả lời** — chỉ 4 case dưới đây bị đánh dấu (`RSZ-04`, `RSZ-08`, `ADD-03`,
  `NST-03`).
- **Ảnh bằng chứng khi chạy case:** lưu vào [`screenshots/`](screenshots/) (thư mục con theo mã nhóm: ENT/DEV/
  SEL/DRG/RSZ/ADD/NST/PRP/LOC/REG/INT) — xem quy ước đặt tên ở [screenshots/README.md](screenshots/README.md).
- Mọi case mặc định chạy trên **TestFlight 1.2.17 (103)** — **xác nhận lại build trên máy trước khi chạy**
  (test-plan mục 1, phát hiện #6). Thiết bị bắt buộc: iPhone iOS 18.x + iOS 26.x. iPad chỉ nếu có máy.
- Dữ liệu chuẩn bị trước (dùng chung cho nhiều nhóm, không lặp lại trong từng case): 1 template dạng stack ·
  1 template không phải stack · 1 template có sẵn (hoặc tự dựng) layout **Column > Row(A, B) > C** để có đủ
  top-level / container / con lồng trong 1 lượt setup.

---

## 1 · Entry & gating · `ENT` (mục 2 #1 test plan)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| ENT-01 | Mở template **dạng stack** → nhìn header cạnh icon crop | Icon **layers** (⧉) hiện | P1 |
| ENT-02 | Mở template **KHÔNG phải dạng stack** → nhìn header | Icon layers **không hiện** — không phải lỗi (test basis dòng 18) | P1 |
| ENT-03 | Quan sát vị trí icon layers | Nằm đúng cạnh icon crop | P3 |
| ENT-04 | Bấm icon layers | Vào S03 full-screen — header đủ ✕/Undo/Redo/✓, đáy đủ nút + và Show grid | P2 |
| ENT-05 | Lần đầu tài khoản vào S03 | Bước hướng dẫn "Tap to edit a piece" hiện, bấm để bỏ qua được | P3 |

---

## 2 · Phạm vi thiết bị/OS · `DEV` (mục 2 #2 test plan)

> Không phải EP/BVA — chạy **toàn bộ nhóm ENT–INT** một lượt trên mỗi thiết bị dưới đây, không phải case riêng.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| DEV-01 | Chạy toàn bộ luồng Component Editor trên **iPhone iOS 18.x** (baseline) | Không có sai lệch nào so với kỳ vọng chung của các nhóm khác | P2 |
| DEV-02 | Chạy toàn bộ luồng Component Editor trên **iPhone iOS 26.x**, chú ý riêng phần chrome (glass) | Không sai lệch; chrome dạng glass render đúng, không vỡ layout header/đáy màn | P1 |

---

## 3 · Chọn thành phần · `SEL` (mục 2 #3 test plan — State Transition Testing)

> Bao phủ đủ các transition hợp lệ đã liệt kê ở mục 5 test plan + 1 transition không hợp lệ (double-tap nhanh).

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| SEL-01 | *[Không chọn gì]* → chạm 1 thành phần đơn (không trong container) | *[→ Đã chọn thành phần đó]* Khung viền xanh lá + pill mini (sliders + trash) nổi | P1 |
| SEL-02 | *[Đã chọn bất kỳ]* → chạm ra vùng trống | *[→ Không chọn gì]* Bỏ chọn, pill biến mất | P2 |
| SEL-03 | *[Không chọn gì]* → chạm vào container Row/Column (dùng template Column>Row(A,B)>C, chạm vào Row qua A) | *[→ Đã chọn container cấp 1]* Chọn cả Row, **không** chọn thẳng A | P1 |
| SEL-04 | *[Đã chọn container cấp 1]* → chạm tiếp đúng vào A | *[→ Đã chọn con cấp 2]* Chọn A, đi sâu đúng 1 cấp | P1 |
| SEL-05 | *[Đã chọn bất kỳ]* → chạm sang 1 thành phần/container khác (vd C) | *[→ Đã chọn cái mới]* Không cộng dồn lựa chọn cũ | P2 |
| SEL-06 | Chọn 1 thành phần đã bị thu nhỏ (resize xuống mức nhỏ) | Khung viền ôm đúng kích thước thật, không to hơn nội dung | P2 |
| SEL-07 | Trên pill mini, bấm icon sliders | Mở đúng Inspector của thành phần đang chọn | P2 |
| SEL-08 | Trên pill mini, bấm icon trash | Xoá thành phần, toast "Removed …" + Undo hiện | P1 |
| SEL-09 | Bấm Undo trên toast Removed | Thành phần quay lại đúng vị trí cũ | P1 |
| SEL-10 | *(transition không hợp lệ, error guessing — mục 5 test plan)* Đã chọn container cấp 1 → chạm **rất nhanh 2 lần liên tiếp** vào cùng 1 con bên trong | Chọn đúng con đó ở lần chạm hợp lệ đầu tiên trong chuỗi — không nhảy vượt cấp, không double-select gây lỗi trạng thái | P3 |

---

## 4 · Di chuyển (kéo) · `DRG` (mục 2 #4 test plan — EP + Checklist-based) 🔴

> Test basis tự xếp đây là vùng rủi ro cao nhất. **Trình tự chạy gộp** — dùng chung template
> `Column > Row(A, B) > C` đã dựng ở phần chuẩn bị, phủ đủ 3 partition (đơn lẻ / cả container / con bên trong)
> trong 1 lượt, không cần dựng lại layout giữa các case:
> 1. Chọn **C** (top-level) → giữ kéo lên/xuống rồi ngang → `DRG-01`.
> 2. Chạm vào **Row** (qua A, theo đúng SEL-03) → giữ kéo cả Row → `DRG-02`.
> 3. Chạm tiếp vào **A** (đã chọn Row) → giữ kéo A → `DRG-03`.
> 4. Sau **mỗi lần** nhả tay ở 3 bước trên → verify `DRG-04` ngay lúc đó, không gộp thành 1 lần kiểm ở cuối.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| DRG-01 | *(EP: đơn lẻ)* Giữ và kéo C lên/xuống rồi ngang | Đi theo ngón **ngay lập tức**, không trễ; chặn đúng trên/dưới trong vùng nội dung; kéo ngang trong phạm vi cho phép; **không** xuất hiện bản sao chồng lên nhau; **không** mất rồi hiện lại giữa chừng | P1 |
| DRG-02 | *(EP: cả container)* Giữ và kéo cả Row (đã chọn qua A) | Toàn bộ A + B đi theo **đúng 1 lần**, không nhanh hơn khung viền, **không** văng ra ngoài | P1 |
| DRG-03 | *(EP: con bên trong container)* Giữ và kéo A (đã chọn con) | A di chuyển trong phạm vi Row, **không** kéo theo B, **không** thoát khỏi khung Row cha | P1 |
| DRG-04 | Sau mỗi lần kéo ở DRG-01/02/03, nhả tay | Ảnh render lại **đúng 1 lần** tại vị trí thả, **không** nhảy về chỗ cũ rồi nhảy lại | P1 |

---

## 5 · Đổi bề rộng (kéo góc) · `RSZ` (mục 2 #5 test plan — Decision Table + BVA)

> **Trình tự chạy gộp:** dùng lại Row(A, B) đã dựng — thêm tạm 1 thành phần C' để có Row 3 con cho `RSZ-04`
> (xoá C' sau khi xong, không ảnh hưởng case khác). Test lần lượt kéo 4 góc trên C (top-level) trước
> (`RSZ-05`/`06`/`07`), rồi mới sang Row.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| RSZ-01 | *(RSZ-DT1)* Thành phần top-level (C), kéo góc **phải** | Chỉ mép phải chạy theo ngón, cạnh trái đứng yên, thành phần vẫn canh giữa | P1 |
| RSZ-02 | *(RSZ-DT2)* Thành phần top-level (C), kéo góc **trái** | Chỉ mép trái chạy theo ngón, cạnh phải đứng yên | P1 |
| RSZ-03 | *(RSZ-DT3)* Row **2 con** (A, B), kéo góc A về 1 phía | B co/giãn bù đúng bằng đó, **tổng bề rộng Row không đổi** | P1 |
| RSZ-04 | ⚠️ *(RSZ-DT4, chờ câu hỏi #2 test-plan)* Row **3+ con**, kéo góc 1 phần tử | **Chưa xác định trước** — ghi lại chính xác quan sát được (chia đều? chỉ ảnh hưởng phần tử liền kề? phần tử cuối hấp thụ chênh lệch?), dùng làm bằng chứng trả lời câu hỏi #2, **không tự kết luận đúng/sai** | P2 (tạm, chờ chốt risk chính xác) |
| RSZ-05 | Kéo thử cả 4 góc của 1 thành phần đang chọn | Cả 4 góc đều là vùng kéo hợp lệ dù không vẽ chỉ báo hình tròn | P2 |
| RSZ-06 | Quan sát bề rộng trong lúc đang kéo (chưa nhả tay) | Đổi **realtime** theo ngón tay, không chờ nhả tay mới cập nhật | P2 |
| RSZ-07 | Nhả tay sau khi kéo góc | Không nhảy, không đổi kích thước thêm lần nữa | P2 |
| RSZ-08 | ⚠️ *(BVA, chờ câu hỏi #3 test-plan)* Kéo góc thu nhỏ hết cỡ | Có **chặn**, không co về 0 — ghi lại **giá trị đo được** tại điểm chặn (pt hoặc %) làm bằng chứng đối chiếu khi có câu trả lời chính thức | P2 |

---

## 6 · Thêm thành phần / Row / Column · `ADD` (mục 2 #6 test plan — EP + Decision Table)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| ADD-01 | Bấm + | Sheet Add component hiện đủ 6 nhóm: Calendar, Events, Tasks, Progress, Text, Layout | P3 |
| ADD-02 | Chọn 1 loại bất kỳ trong sheet | Thêm thành công, toast "Added …" + Undo hiện; thành phần vừa thêm **KHÔNG** tự động được chọn (đã xác nhận qua ảnh 2026-09-24) | P2 |
| ADD-03 | ⚠️ *(chờ câu hỏi #4 test-plan)* Quan sát thành phần vừa thêm | Có lề 2 bên mặc định, không chiếm full-width — ghi lại **giá trị lề đo được** làm bằng chứng đối chiếu; nếu full-width thì **báo ngay** (test basis: "Nếu full-width thì report") | P3 |
| ADD-04 | *(EP a)* Đang chọn 1 thành phần đơn (không phải container), bấm + | Thành phần mới rơi **ngay dưới** thành phần đang chọn | P2 |
| ADD-05 | *(EP b)* Đang chọn 1 Row/Column, bấm + | Thành phần mới rơi vào **TRONG** container đó | P2 |
| ADD-06 | *(EP c)* **Không chọn gì**, bấm + | Thành phần mới chèn vào **giữa canvas (center)** — xác nhận qua dev 2026-09-24 | P2 |
| ADD-07 | Thêm Row, rồi thêm Column (case riêng) | Row: 1 hàng gồm 2 ô trống nét đứt, mỗi ô có nút +, nằm cạnh nhau. Column: 2 ô trống nét đứt xếp dọc | P3 |
| ADD-08 | 🔴 *(ADD-DT1, regression lỗi vừa fix)* Bấm **đúng nút +** giữa 1 ô trống của Row/Column | Thành phần lấp **đúng ô đó**, ô còn lại **giữ nguyên** — nếu ô số 2 biến mất hoặc thành phần chiếm hết hàng thì **báo ngay** | P1 |
| ADD-09 | *(ADD-DT2)* Bấm vào **nền** ô trống (trượt ra ngoài nút +) | Chọn container, **KHÔNG** mở sheet Add component | P2 |
| ADD-10 | Lấp đủ cả 2 ô của Row/Column | Hiện đủ 2 thành phần, chia đôi; **không còn** ô trống thừa | P3 |

---

## 7 · Giới hạn lồng nhau & container rỗng · `NST` (mục 2 #7 test plan — Boundary Value Analysis)

> **Trình tự chạy gộp:** dựng dần độ sâu 1 → 2 → 3 → (thử) 4 trên cùng 1 nhánh container, không phá layout giữa
> chừng — mỗi lần thêm 1 cấp, mở sheet Add component kiểm tra nhóm Layout trước khi lồng thêm cấp tiếp theo.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| NST-01 | Ở cấp lồng **1** rồi **2**, mở sheet Add component ở mỗi cấp | Nhóm Layout hiện đầy đủ ở cả 2 cấp | P3 |
| NST-02 | *(biên trên hợp lệ)* Ở cấp lồng **thứ 3** (tối đa công bố), mở sheet Add component | Nhóm **Layout biến mất**, các nhóm khác vẫn còn | P2 |
| NST-03 | ⚠️ *(biên vượt, chờ câu hỏi #5 test-plan)* Thử thêm container thứ **4** | **Chưa xác định trước** — ghi lại chính xác hệ thống chặn ở đâu (dùng làm bằng chứng trả lời câu hỏi #5), **không tự kết luận** đây có đúng là "cấp 4" theo cách đếm của hệ thống hay không | P2 |
| NST-04 | Ở cấp còn cho phép, thêm 1 container **ngang hàng** (sibling, không lồng thêm) | Vẫn thêm được bình thường, không bị tính dồn vào độ sâu | P2 |
| NST-05 | Thêm Row/Column, không lấp gì, bấm **✓ (Done)** | Container rỗng tự bị xoá, toast "Removed the empty layout" + Undo | P2 |
| NST-06 | Bấm Undo trên toast "Removed the empty layout" | Container rỗng quay lại đúng vị trí trong editor | P2 |

---

## 8 · Bảng thuộc tính, Undo, lưu · `PRP` (mục 2 #8 test plan — Checklist + State Transition)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| PRP-01 | *[Placement = Auto]* → đổi sang **Fixed** | *[→ Placement = Fixed]* Thanh Vertical position hiện; thành phần **không tự nhảy** vị trí ngay lúc đổi | P1 |
| PRP-02 | *[Placement = Fixed]* → đổi lại **Auto** | *[→ Placement = Auto]* Thành phần **không tự nhảy** vị trí | P1 |
| PRP-03 | Ở Fixed, kéo thanh Vertical position | Thành phần chạy dọc theo đúng tỉ lệ ngón tay | P2 |
| PRP-04 | Kéo thanh Width trong Inspector, đối chiếu với kéo góc trên canvas | Khớp giá trị 2 chiều — kéo 1 bên, bên kia cập nhật theo ngay | P2 |
| PRP-05 | So sánh Inspector của thành phần ngoài cùng vs trong Row/Column | Thanh **Size** chỉ hiện với thành phần **ngoài cùng** | P3 |
| PRP-06 | Xác nhận thành phần trong Row/Column | **Không có** thanh Size — đúng thiết kế, không phải thiếu | P3 |
| PRP-07 | Đổi knob riêng theo loại (màu, phông, số dòng…) | Cập nhật ngay trên canvas | P2 |
| PRP-08 | Bấm Duplicate / Delete / Deselect trên Inspector | Cả 3 chạy đúng chức năng | P2 |
| PRP-09 | Kéo 1 thành phần đi xa (đổi hướng nhiều lần trong 1 lần giữ ngón), sau đó Undo | Hoàn tác **đúng 1 bước** — về lại vị trí trước khi bắt đầu kéo | P1 |
| PRP-10 | Sau Undo, bấm Redo | Làm lại đúng thao tác vừa Undo | P2 |
| PRP-11 | Bấm **✓ (Done)** | Quay lại S01, bố cục mới **được giữ** trên preview | P1 |
| PRP-12 | Bấm **✕ (Cancel)** khi có thay đổi chưa lưu (kể cả thành phần vừa thêm mới) | Toàn bộ thay đổi trong phiên bị bỏ hết; **KHÔNG có dialog xác nhận** (đã kiểm tra thực tế 2026-09-24 — đúng spec, khác S02) | P1 |
| PRP-13 | Bật/tắt **Show grid** trong lúc đang thao tác kéo | Lưới canh hiện/ẩn đúng; **không** cản trở thao tác kéo (hit-testing) | P2 |
| PRP-14 | Kéo 1 thành phần ra ngoài khung màn | Cảnh báo "Part of this runs off the screen" hiện; kéo về trong thì cảnh báo **tự mất** | P2 |
| PRP-15 | Bấm nút ẩn/hiện chrome | Ẩn hết control để xem wallpaper sạch; chạm lại → hiện lại đầy đủ | P3 |
| PRP-16 | *(chỉ nếu có máy iPad)* Xoay iPad dọc ↔ ngang khi đang chọn 1 thành phần / có ô trống Row-Column | Khung viền chọn và các ô trống vẫn khớp đúng vị trí, không lệch | P2 |

---

## 9 · Bản địa hoá · `LOC` (mục 2 #9 test plan — Equivalence Partitioning)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| LOC-01 | *(EP: máy tiếng Việt)* Đặt ngôn ngữ máy = Tiếng Việt, đi qua toàn bộ string mới trong S03 (header, sheet, Inspector, toast) | Không lọt chuỗi tiếng Anh nào | P2 |
| LOC-02 | *(EP: máy tiếng Anh)* Đặt ngôn ngữ máy = English, lặp lại | Toàn bộ hiển thị đúng tiếng Anh | P2 |

---

## 10 · Regression ngoài màn editor · `REG` (mục 2 #10 test plan — Checklist-based, chạy sau cùng) 🔴

> Chạy **sau khi** nhóm SEL/DRG/RSZ/ADD/NST/PRP đã pass — regression kiểm kết quả **đã lưu**, không có ý nghĩa
> nếu bố cục lưu vào còn sai từ bước dựng.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| REG-01 | Đặt bố cục vừa sửa làm lock screen thật (qua Shortcut) | Wallpaper render **đúng bố cục vừa sửa**, không chỉ đúng trên preview trong editor | P1 |
| REG-02 | Kiểm Live Activity của template vừa sửa | Vẫn chạy đúng, không vỡ layout | P1 |
| REG-03 | Kiểm Widget và thumbnail trong "Your collection" | Cập nhật theo bố cục mới | P1 |
| REG-04 | Mở lại template đã sửa | Bố cục giữ nguyên đúng như đã lưu, sửa tiếp được | P1 |
| REG-05 | Mở 1 template lịch **cũ**, chưa từng dùng Component Editor | Render **y như trước**, không bị ảnh hưởng ngoài ý muốn | P2 |
| REG-06 | Mở 1 wallpaper dạng **Note** (không phải lịch) | Không bị ảnh hưởng bởi tính năng Component Editor | P3 |
| REG-07 | 🔴 Vừa chỉnh bố cục ở Component Editor (S03), vừa trang trí ở Decorate (S02) trên **cùng 1 template**, lưu cả hai | Wallpaper cuối (S01 `filled` / lock screen thật) render **đầy đủ cả 2 phần**, không mất/đè lẫn nhau — xác nhận qua dev: 2 tính năng độc lập nhưng kết quả phải gộp đủ | P1 |
| REG-08 | 🔴🔴 Set bố cục Component Editor xong → **chờ qua đêm thật** để automation Shortcut chạy lại (không rút ngắn bằng đổi giờ hệ thống, cùng nguyên tắc với `AUTO-04` của Flow 03) | Bố cục **PHẢI còn nguyên và cập nhật đầy đủ** (event/data mới) — xác nhận **bắt buộc** qua dev, đây là case quan trọng nhất toàn bộ test suite | **P1** |

---

## 11 · Hành vi cố ý — xác nhận, không phải tìm lỗi · `INT` (mục 2 #11 test plan — Checklist-based)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| INT-01 | Trong lúc đang kéo 1 thành phần có chữ | Chữ **không** xuống dòng lại, chiều cao **không đổi** (chỉ co giãn theo hình) — nhả tay ra mới chỉnh lại đúng. **Đây là đánh đổi có chủ đích, không log bug** | P3 |
| INT-02 | Trong lúc đang kéo 1 Row/Column | Thẻ nền của container **không đổi** theo từng frame, chỉ thành phần con đổi. **Không log bug** | P3 |
| INT-03 | Quan sát 1 Row/Column chỉ có **1 con** | Vẫn chiếm chỗ như đang có 2 con — ô trống thứ 2 vẫn giữ chỗ. **Không log bug** | P3 |

---

## 12 · Traceability — đối chiếu với các bullet P1 ở test plan (mục 6)

| Bullet P1 (test plan mục 6) | Case cụ thể ở đây |
|---|---|
| Chọn/Xoá/Undo cốt lõi (TC-05,07,08,11,12) | SEL-01, SEL-03, SEL-08, SEL-09 |
| Toàn bộ nhóm kéo — DRG (TC-13,14,16,17,18,19) | DRG-01 … DRG-04 |
| Resize theo đúng hướng (TC-21,22,26) | RSZ-01, RSZ-02, RSZ-03 |
| Regression thêm component trong ô trống (TC-36) | ADD-08 |
| Auto/Fixed không nhảy, Undo trọn vẹn, Done/Cancel đúng (TC-44,51,53,54) | PRP-01, PRP-02, PRP-09, PRP-11, PRP-12 |
| Baseline thiết bị iOS 26.x (TC-70) | DEV-02 |
| Toàn bộ nhóm REG (TC-60–63) | REG-01 … REG-04 |
| 🆕 Gộp Decorate + Component Editor (TC-72) | REG-07 |
| 🆕 Sống sót qua automation overnight (TC-73) | REG-08 |

---

## 13 · Câu hỏi còn treo — ảnh hưởng trực tiếp 4 case đã đánh ⚠️

Không chặn việc chạy toàn bộ bộ case còn lại. 4 case sau **chạy được ngay** nhưng kết quả mong đợi ghi ở dạng
"quan sát/ghi lại làm bằng chứng", chưa phải PASS/FAIL cố định — chờ dev trả lời [test-plan mục 10](test-plan-component-editor.md#10-gap-cần-làm-rõ-trước-khi-execute)
câu #2–#5 để chốt lại thành kỳ vọng cụ thể:

- `RSZ-04` — chờ câu #2 (bù trừ bề rộng Row 3+ con)
- `RSZ-08` — chờ câu #3 (giá trị min-width)
- `ADD-03` — chờ câu #4 (giá trị lề mặc định)
- `NST-03` — chờ câu #5 (cách đếm cấp lồng)
