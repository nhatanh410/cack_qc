# Exploratory Checklist — 14 Edit Wallpaper (Decorate)

> **Nguồn:** [wireframe](../ui/ux/wideframes/14_edit-wallpaper.md) · 16 screenshot ·
> [index screenshot iPhone](../ui/ux/screenshots/iphone/index.md#14_edit-wallpaper--editor-soạntrang-trí-wallpaper-decorate) ·
> [index screenshot iPad](../ui/ux/screenshots/ipad/index.md) (15 ảnh, cả 2 chiều — bổ sung, không phải nguồn chính)
> **Change note:** [qc-wallpaper-decoration.md](../specs/wallpaper-decoration/qc-wallpaper-decoration.md) · **Test plan:** [1.2.15-decoration-inkai.md](../test-plans/decoration-inkai/1.2.15-decoration-inkai.md)
> **Khung đánh giá:** [exploratory-references](../../references/exploratory-references.md) ·
> [permissions-matrix](../../references/permissions-matrix.md)
> **Build:** TestFlight 1.2.15 (56) · **Thiết bị:** ____________ · **iOS:** ____________ · **Người test:** ____________

> ⚠️ **Flow mới hoàn toàn** — khác các checklist khác trong bộ này, chưa có phiên khám phá nào trước đó để
> đối chiếu. Toàn bộ regression R1–R8 trong change note (mục 4) là **bug đã từng có ở bản build trước**, giờ
> quay lại như case negative bắt buộc — xem §2.4.

---

## 0 · Framing

**Q1 — Mục tiêu user:** biến 1 template wallpaper chung (đã chọn ở Flow 04) thành của riêng mình bằng vẽ
tay, chữ, emoji, ảnh cá nhân — trước khi lưu thành lock screen thật.

**Q8 — Mục tiêu business:** không thấy gate Free/Pro nào trong 16 ảnh hiện có — chưa rõ Decorate có tính phí
hay không (xem `DEC-Q02`). Nếu miễn phí hoàn toàn, đây nhiều khả năng là tính năng **giữ chân** (differentiation,
tăng lý do quay lại app mỗi ngày) hơn là tính năng bán hàng trực tiếp.

**Vì sao flow này khác mọi flow trước:** đây là **editor vẽ tay đầu tiên** trong toàn bộ app — mọi flow khác
đều là form/list/toggle. Không có kịch bản cố định nào đủ phủ hết tổ hợp gesture tự do (vẽ + sticker + xoay +
resize cùng lúc), nên phần lớn §1–§2 chỉ đủ để bắt lỗi **rõ ràng**, không thay được exploratory session tự do
trên canvas thật.

**Tham chiếu UX quen thuộc — Instagram Stories editor:** cùng thể loại editor (sticker/vẽ/chữ đè lên **1 khung
ảnh cố định**, không phải canvas tự do như Canva/CapCut). Dùng làm chuẩn đối chiếu để phân biệt "thiếu sót
thật" với "đúng convention của thể loại editor này":

| Thao tác | Instagram Stories | Ink Decorate (quan sát được từ ảnh) | Nhận xét |
|---|---|---|---|
| Chọn sticker | Chạm 1 lần, chỉ phóng to nhẹ, **không có khung/handle rõ** | Chạm 1 lần → khung viền + ✕ + handle góc rõ ràng | ✅ Ink **dễ nhận biết hơn** — ưu điểm cho người mới, không phải thiếu sót |
| Scale + xoay | Pinch/xoay **tự do ở bất kỳ đâu trên sticker**, không cần trúng 1 điểm | Change note mục 2.3 ghi cả "pinch tự do" lẫn "handle góc" — **chưa rõ có phải bấm đúng handle mới xoay/scale được, hay pinch tự do ở đâu cũng được như Instagram** | ⚠️ Cần xác nhận — xem `DEC-H28b` |
| Xoá sticker | Kéo sticker thả vào **icon thùng rác hiện ở đáy màn hình** khi đang kéo, kèm rung phản hồi | Chỉ thấy nút ✕ nhỏ cố định góc trên phải, không có ảnh nào cho thấy thùng rác xuất hiện khi kéo | ⚠️ Thiếu affordance quen thuộc — user quen Instagram có thể tìm thùng rác mà không thấy. Xem `DEC-H33b` |
| Zoom/pan **canvas** | **Không có** — khung khoá cứng theo tỉ lệ ảnh/video xuất ra | Không có bằng chứng (giống Instagram) | Nhiều khả năng đây là **hành vi đúng theo convention của thể loại editor này**, không phải thiếu sót — hạ bớt mức độ khẩn của `DEC-E09b/E09c`, nhưng vẫn cần hỏi dev để xác nhận chứ không mặc định |
| Double-tap reset scale/góc | Có ở một số phiên bản | Chưa có bằng chứng | Tiện ích nhỏ, không bắt buộc — `DEC-E09d` |
| Đường canh giữa khi kéo | Có (vạch vàng/hồng khi vào giữa hoặc thẳng hàng vật khác) | Có — "đường canh giữa" (change note mục 2.3) | ✅ Khớp convention |

**Câu hỏi mới, chưa flow nào từng đặt ra:**

- [ ] 🔴 **Wallpaper tự động tạo lại mỗi sáng qua Apple Shortcut** ([§1.1 chuỗi setup](../../references/exploratory-references.md#11--chuỗi-setup-có-sống-sót-qua-người-dùng-thật-không)).
      Decoration hôm nay có **sống sót qua lần automation chạy tiếp theo** không, hay bị ghi đè mất khi
      wallpaper render lại theo dữ liệu lịch mới? Đây là câu hỏi **quyết định giá trị cốt lõi** của cả tính
      năng — nếu mất, Decorate chỉ dùng được đúng 1 ngày. **Phải test qua đêm**, không rút ngắn được bằng đổi
      giờ hệ thống (cùng cảnh báo như [shortcut-flow-cases §10](../../references/shortcut-flow-cases.md)).

**Rủi ro xuyên suốt chạm vào flow này** *(chỉ link, không lặp lại)*:
[§1.0 bản đồ phụ thuộc ngoài app](../../references/exploratory-references.md#10--bản-đồ-phụ-thuộc-ngoài-app) ·
[§1.2 lock screen là ảnh tĩnh](../../references/exploratory-references.md#12--lock-screen-là-ảnh-tĩnh-dữ-liệu-cũ-tới-mức-nào-là-chấp-nhận-được) ·
[permissions-matrix §1.3 Photos](../../references/permissions-matrix.md#13--️-photos--nhiều-khả-năng-cần-chưa-thấy-dialog) — đây là flow **đầu tiên** có khả năng thật sự trigger dialog Photos, câu hỏi mở từ lâu của ma trận quyền có thể được trả lời dứt điểm ở đây.

---

## 1 · Happy path — `DEC-H`

### 1.1 · Vào Decorate lần đầu — S01 → S02

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **DEC-H01** | Từ Flow 04, mở 1 template → vào Wallpaper editor (S01) | Preview template · pill **"Decorate"** góc dưới trái · tab Background/Calendar/Style | — | ☐ |
| **DEC-H02** | Bấm **"Decorate"** | Sang S02, canvas full màn + lock screen preview thật (giờ/ngày) | ⏱ thời gian mở canvas | ☐ |
| **DEC-H03** | Lần đầu tiên mở Decorate của tài khoản | Coach mark **"Your toolbar"** hiện, trỏ đúng vào icon bút, có nút **"Got it"** | Coach mark chỉ hiện **đúng 1 lần** — mở lại Decorate lần 2 không còn | ☐ |
| **DEC-H04** | Bấm "Got it" | Coach mark biến mất, lộ canvas trống + toolbar 6 icon dọc bên phải | — | ☐ |
| **DEC-H05** | Gỡ app, cài lại, mở Decorate lại | Coach mark có **hiện lại** không (mục 10.12 test plan — chưa xác định, note không nhắc) | ⚠️ chưa có bằng chứng, ghi lại kết quả | ☐ |

### 1.2 · Toggle preview — S02

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **DEC-H06** | Bấm icon 📅 (toggle Show calendar) | Canvas hiện thêm panel lịch tuần + heatmap tháng, đúng dữ liệu thật của user | Đối chiếu với tab Calendar — dữ liệu có khớp không | ☐ |
| **DEC-H07** | Bấm lại icon 📅 | Panel lịch biến mất, về canvas trống | — | ☐ |
| **DEC-H08** | Bấm icon ▦ (đầu toolbar, chức năng chưa xác định) | Ghi lại chính xác nó làm gì | ⚠️ **coverage gap** — wireframe không xác định được từ ảnh tĩnh, xem `DEC-Q07` | ☐ |

### 1.3 · Vẽ tay — S02

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **DEC-H09** | Bấm icon ✎ (Draw) | Thanh brush hiện: eyedropper + palette màu + 4 icon loại nét + eraser | — | ☐ |
| **DEC-H10** | Vẽ lần lượt bằng cả 4 loại nét (thứ tự trái→phải trên thanh) | 4 nét **nhìn khác nhau rõ rệt** — đúng như đổi tên Pen/Marker/Highlighter/Dotted trong change note | Chụp lại đối chiếu 4 nét cạnh nhau | ☐ |
| **DEC-H11** | Kéo thanh trượt cỡ nét | Độ dày nét đổi theo thời gian thực khi đang vẽ | — | ☐ |
| **DEC-H12** | Chọn 1 màu trong palette rồi vẽ | Nét ra đúng màu đã chọn | — | ☐ |
| **DEC-H13** | Bấm eyedropper rồi rê lên **wallpaper nền** (không phải sticker) | Bút đổi sang đúng màu điểm ảnh nền vừa hút | ⚠️ chưa có ảnh cho state đang hút màu — ghi lại | ☐ |
| **DEC-H14** | Chọn Eraser, tẩy đúng phần nét vừa vẽ | Chỉ mất đúng phần dưới ngón tay, phần còn lại nguyên vẹn | Độ chính xác theo bán kính hay theo pixel — đo bằng cách tẩy 1 nửa 1 nét dài | ☐ |
| **DEC-H15** | 🔴 Vẽ xong 1 nét, **buông tay khỏi canvas** | Header (✕/↶/↷/✓) và toolbar phải **hiện lại đầy đủ**, bấm được ngay | Đây là điểm verify quan trọng nhất của cả session — ảnh `drawing.png` (iPad) cho thấy chúng biến mất lúc đang kéo; phải xác nhận **có hiện lại** khi buông tay, không kẹt như R1 trong change note mục 4 | ☐ |

### 1.4 · Text — S02

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **DEC-H16** | Bấm icon Aa | Ô nhập "Type something" hiện giữa canvas, bàn phím mở, thanh format bên dưới | — | ☐ |
| **DEC-H17** | Gõ text, đổi màu/font/canh lề/đậm/cỡ chữ qua thanh format | Mỗi control áp dụng đúng, thấy ngay trên canvas | — | ☐ |
| **DEC-H18** | Chạm ra ngoài ô nhập (không gõ gì) | Bàn phím tắt, thanh format **vẫn còn** (trạng thái `text-collapsed`, xem ảnh iPad) | — | ☐ |
| **DEC-H19** | Chạm lại vào sticker text vừa tạo | Mở lại đúng nội dung để sửa tiếp, không mất text đã gõ | — | ☐ |

### 1.5 · Emoji & Photo/Cutout — S02

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **DEC-H20** | Bấm icon 🙂 | Bottom-sheet Emoji, 7 tab nhóm ở đáy (Smileys/Hearts/Animals/Nature/Food/Travel/Objects) | Đếm đủ 7 nhóm | ☐ |
| **DEC-H21** | Cuộn danh sách emoji trong 1 nhóm | Tiêu đề sheet đổi tên nhóm đúng theo vị trí cuộn | — | ☐ |
| **DEC-H22** | Chạm 1 emoji | Sheet đóng, emoji xuất hiện trên canvas ở vị trí mặc định (giữa?) | — | ☐ |
| **DEC-H23** | Bấm icon 🖼 → chọn **Photo** | Ghi lại UI kế tiếp — chọn ảnh từ thư viện thế nào | ⚠️ **coverage gap** — chỉ có ảnh menu, chưa có ảnh bước chọn ảnh | ☐ |
| **DEC-H24** | 🔴 Bấm icon 🖼 → chọn **Cutout** lần đầu trên máy | Có dialog xin quyền **Photos** hiện ra không? Nếu có, đúng thời điểm này | Trả lời dứt điểm câu hỏi mở ở [permissions-matrix §1.3](../../references/permissions-matrix.md#13--️-photos--nhiều-khả-năng-cần-chưa-thấy-dialog) | ☐ |
| **DEC-H25** | Hoàn tất Cutout với 1 ảnh có người/vật thể rõ | Kết quả tách nền sạch, sticker chỉ còn chủ thể, nền trong suốt | Test thêm 1 ảnh nền phức tạp/không có chủ thể rõ — kết quả tách thế nào | ☐ |

### 1.6 · Thao tác trên sticker — S02

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **DEC-H26** | Chạm 1 lần vào sticker bất kỳ (chữ/emoji/ảnh) | Sticker được **chọn** — khung viền + ✕ góc trên + handle resize/xoay góc dưới | Đúng cho **cả 3 loại** sticker (emoji, cutout, ảnh thường) — xem 3 ảnh `sticker-selected*` | ☐ |
| **DEC-H27** | Kéo sticker gần chính giữa canvas | Đường canh giữa (guide line) hiện khi vào đúng tâm | — | ☐ |
| **DEC-H28** | Pinch 2 ngón để phóng to/thu nhỏ | Sticker scale mượt theo khoảng cách 2 ngón | — | ☐ |
| **DEC-H28b** | Pinch/xoay 2 ngón đặt **ở bất kỳ đâu trên sticker** (không nhắm đúng vào handle góc dưới phải) | So sánh với Instagram Stories: pinch/xoay tự do ở đâu trên sticker cũng ăn — xem quan sát ở §0. Ghi rõ Ink có giống vậy không, hay **bắt buộc phải chạm đúng handle** mới scale/xoay được | Nếu bắt buộc đúng handle → tap target nhỏ (đã ghi ở `DEC-E08`) ảnh hưởng nặng hơn, vì đó là **cách duy nhất** để scale | ☐ |
| **DEC-H29** | Xoay 2 ngón | Sticker xoay theo đúng góc tay, không giật | — | ☐ |
| **DEC-H30** | Kéo handle góc dưới phải | Vừa scale vừa xoay cùng lúc theo hướng kéo | — | ☐ |
| **DEC-H31** | **Double-tap** vào sticker (chọn hoặc chưa chọn đều thử) | Mở bottom-sheet cài đặt — tiêu đề đổi theo loại sticker ("Emoji"/"Photo", đã có ảnh; "Text" chưa có ảnh) — ✅ đã có ảnh `sticker-settings.png` (+v2) xác nhận | Thử double-tap khi sticker **chưa được chọn trước** — có mở thẳng sheet không, hay bắt buộc phải chọn (đơn chạm) trước rồi mới double-tap được | ☐ |
| **DEC-H32** | Trong sheet cài đặt, kéo slider Opacity | Độ trong suốt của sticker đổi theo thời gian thực | Ảnh hiện có chỉ chụp ở 100% — thử kéo về 0% và mức giữa, xác nhận range + preview realtime | ☐ |
| **DEC-H32b** | Trong sheet cài đặt, bấm **Delete** | Sticker bị xoá, sheet đóng | So sánh style nút Delete (chữ đỏ, nền nhạt — chuẩn) với nút Discard ở popup khác (nền tối, nổi bật) — 2 pattern khác nhau cho cùng loại hành động phá huỷ, xem `DEC-Q13` | ☐ |
| **DEC-H33** | Bấm ✕ trên sticker đang chọn | Sticker biến mất khỏi canvas ngay | — | ☐ |
| **DEC-H33b** | Chọn 1 sticker, kéo nó xuống **sát đáy màn hình** rồi giữ | So sánh Instagram Stories: có icon **thùng rác hiện ra ở đáy** để thả vào xoá không, hay chỉ có đúng 1 cách xoá là bấm ✕ nhỏ góc trên? Ghi lại quan sát, không giả định thiếu | Nếu không có, đây là 1 affordance quen thuộc bị thiếu so với chuẩn thể loại — mức độ nhẹ, không chặn chức năng vì ✕ vẫn xoá được | ☐ |

### 1.7 · Lưu — S02 → S01

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **DEC-H34** | 🔴 Trang trí đủ 4 loại (vẽ + chữ + emoji + ảnh), bấm **✓** | Quay về S01, preview wallpaper **khớp đúng 100%** những gì vừa trang trí | Đối chiếu từng phần tử 1-1 giữa canvas lúc lưu và preview S01 (`filled.png` đã xác nhận sơ bộ, cần lặp lại trên máy thật) | ☐ |
| **DEC-H35** | Từ S01 (đã filled), bấm lại "Decorate" | Mở lại đúng canvas đã lưu, không mất decoration cũ, sửa tiếp được | — | ☐ |
| **DEC-H36** | 🔴 Set wallpaper thật (qua Shortcut, Flow 03) rồi khoá máy xem lock screen | Lock screen thật **có đủ decoration** đã làm, không chỉ preview trong app | Đây là bước duy nhất xác nhận giá trị thật — preview trong app không tính | ☐ |

---

## 2 · Negative — `DEC-N`

### 2.1 · Huỷ / bỏ dở giữa chừng

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **DEC-N01** | 🔴 Trang trí xong, bấm **✕** (có thay đổi chưa lưu) | Hiện popup "Discard changes?" — ✅ đã có ảnh `discard-dialog.png`: đúng subtitle "Your decorations won't be saved." + 2 nút Discard/Keep editing | Mất decoration không cảnh báo — mất công sức người dùng vừa bỏ ra | 🔴 | ☐ |
| **DEC-N02** | Ở popup Discard, bấm **Keep editing** | Ở lại canvas, **giữ nguyên** mọi decoration đã làm | Mất nhầm dù chọn đúng ý "ở lại sửa tiếp" | 🔴 | ☐ |
| **DEC-N03** | Ở popup Discard, bấm **Discard** | Mất hết decoration, về S01 với preview **cũ** (trước khi vào Decorate lần này) | Xoá nhầm cả decoration cũ đã lưu trước đó, không chỉ phần vừa thêm | 🟠 | ☐ |
| **DEC-N03b** | ⚠️ 🟡 Quan sát từ ảnh: nút **Discard** (phá huỷ) được style **tối màu/nổi bật hơn** nút **Keep editing** (an toàn) | Xác nhận với dev/design đây có phải chủ ý, hay ngược pattern thường dùng cho dialog xác nhận huỷ (nút an toàn nên nổi bật hơn) | Tăng khả năng bấm nhầm Discard theo phản xạ "nút đậm = nút nên bấm" — xem ghi chú UX ở [wireframe](../ui/ux/wideframes/14_edit-wallpaper.md#14_edit-wallpaper_02_decorate_discard-dialogpng) | 🟡 | ☐ |
| **DEC-N04** | Bấm ✕ khi **chưa có thay đổi gì** (canvas y nguyên lúc mở) | Thoát thẳng, **không** hiện popup Discard | Popup thừa gây khó chịu dù không có gì để mất | 🟡 | ☐ |
| **DEC-N05** | Đang gõ Text, chưa gõ chữ nào, chạm ra ngoài | Không tạo ra 1 sticker text rỗng vô hình trên canvas | Sticker rỗng tồn tại ẩn, gây lệch layer/khó xoá về sau | 🟠 | ☐ |

### 2.2 · Undo/Redo — biên

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **DEC-N06** | Vẽ 1 nét → Undo → chạm chọn 1 sticker có sẵn | Nút **Redo vẫn sáng**, bấm được | Redo bị mất chỉ vì thao tác chọn không liên quan (R2, change note mục 4) | 🟠 | ☐ |
| **DEC-N07** | Chọn Eraser, quẹt vào **vùng trống** không có nét nào | Không sinh thêm bước Undo thừa; Redo không bị mất theo | Undo stack rác, bấm Undo nhiều lần không thấy gì đổi (R3) | 🟠 | ☐ |
| **DEC-N08** | Mở sheet cài đặt sticker → bấm xoá → bấm Undo **1 lần** | Sticker khôi phục ngay ở lần bấm Undo **đầu tiên** | Phải bấm Undo nhiều lần mới khôi phục = mất niềm tin vào Undo (R4) | 🟠 | ☐ |
| **DEC-N09** | Undo liên tục tới khi hết lịch sử | Nút Undo tự **disable**, không crash, không undo quá canvas trống ban đầu | — | 🟡 | ☐ |

### 2.3 · Giới hạn & xung đột thao tác

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **DEC-N10** | 🔴 Vẽ liên tục **hơn 50 nét** ngắn | Hiện thông báo hết chỗ, các nét **cũ không bị mất** | Mất nét cũ = mất dữ liệu người dùng đã làm, không phục hồi được (R6) — số 50 chỉ là ước lượng từ change note, xem `DEC-Q03` | 🔴 | ☐ |
| **DEC-N11** | Đang cầm bút, vẽ 1 đường đè ngang qua 1 sticker có sẵn | Nét vẽ ra bình thường, sticker **không bị kéo theo** theo tay | Sticker dịch chuyển ngoài ý muốn, phá layout đã sắp (R7) | 🟠 | ☐ |
| **DEC-N12** | Thêm 1 sticker ảnh → bật eyedropper → rê lên **đúng vị trí sticker đó** | Bút lấy màu của **ảnh sticker**, không phải màu wallpaper phía sau nó | Lấy nhầm màu nền thay vì màu ảnh — sai mục đích công cụ (R5) | 🟠 | ☐ |
| **DEC-N13** | Đặt quá nhiều sticker chồng lên nhau (10+) | Vẫn chọn được đúng từng cái khi chạm, không bị dính/nhầm layer | ⚠️ không có case nào trong note cho thứ tự lớp (z-order) — ghi coverage gap nếu không chọn được | 🟡 | ☐ |

### 2.4 · Gián đoạn — kill app, offline, quyền

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **DEC-N14** | 🔴 Đang trang trí (chưa lưu) → **kill app** → mở lại | Ghi rõ: mất hết, hay khôi phục được draft dở dang? | Mất công sức không cảnh báo trước — không có case nào trong note, coverage gap | 🔴 | ☐ |
| **DEC-N15** | Mở Decorate khi **hoàn toàn offline** | Toàn bộ tính năng (vẽ, text, emoji, ảnh máy) vẫn hoạt động — không có phần nào cần mạng | Nếu có phần phụ thuộc mạng (vd tải bộ emoji) mà không báo lỗi rõ, coverage gap | 🟡 | ☐ |
| **DEC-N16** | Bấm Cutout khi **từ chối quyền Photos** *(nếu app xin quyền — xem `DEC-H24`)* | Thông báo rõ ràng cần quyền, dẫn ra Settings | Im lặng không phản hồi khi bấm — user tưởng nút hỏng | 🟠 | ☐ |
| **DEC-N17** | Đưa app xuống background giữa lúc đang kéo/xoay 1 sticker → quay lại | Trạng thái sticker giữ nguyên vị trí lúc thả tay, không nhảy về vị trí cũ | Vị trí bị reset, phá công sức sắp xếp | 🟡 | ☐ |

---

## 3 · Edge — `DEC-E`

| ID | Tình huống | Câu hỏi | Mức | ☐ |
|---|---|---|:---:|:---:|
| **DEC-E01** | Lưu canvas **hoàn toàn trống** (không thêm gì) | Có cho lưu không, hay chặn vì "không có gì để lưu"? Nếu cho lưu, S01 có đổi gì không? | 🟡 | ☐ |
| **DEC-E02** | Chèn 1 ảnh **rất lớn** (vd ảnh gốc 12MP không nén) qua Photo/Cutout | Hiệu năng canvas có giật không? App có tự resize/nén không? Đo thời gian xử lý | 🟠 | ☐ |
| **DEC-E03** | Text sticker với câu **rất dài**, có dấu tiếng Việt, và emoji trộn lẫn | Xuống dòng đúng? Font dấu tiếng Việt hiển thị đúng không bị vỡ? | 🟡 | ☐ |
| **DEC-E04** | 🔴 **Dynamic Type** cỡ lớn nhất | Text sticker người dùng tự gõ có bị ảnh hưởng cỡ hệ thống không (hay giữ cỡ tự chọn)? Icon toolbar còn đủ chỗ không? | 🟠 | ☐ |
| ~~DEC-E05~~ | ~~Dark Mode toàn bộ S01 + S02~~ | ✅ **N/A — xác nhận 2026-09-12: app hiện chưa hỗ trợ Dark Mode.** Bỏ qua, không phải coverage gap | — | — |
| **DEC-E06** | Máy **màn hình nhỏ** (iPhone SE / mini) | Toolbar 6 icon dọc + thanh brush ngang (eyedropper + màu + 4 nét + eraser) có đủ chỗ không, hay phải cuộn/che khuất canvas? | 🟠 | ☐ |
| **DEC-E07** | 🔴 **VoiceOver** bật, thử thao tác sticker (chọn/di chuyển/resize/xoay) | Toàn bộ thao tác dựa vào gesture tự do (pinch/drag/rotate) — VoiceOver có cách nào thay thế không, hay **hoàn toàn không dùng được**? | 🔴 | ☐ |
| **DEC-E08** | Đo tap target của ✕ và handle trên sticker bằng thước/pixel thật | Có đạt tối thiểu 44×44pt theo Apple HIG không — quan sát bằng mắt ở mục 6 test plan nghi ngờ dưới chuẩn | 🟠 | ☐ |
| **DEC-E09** | Đặt sticker/emoji **đè trực tiếp lên vùng lịch** khi đã bật Show calendar | Có cảnh báo hay giới hạn vùng đặt không, hay cho che tự do làm mất khả năng đọc lịch? | 🟠 | ☐ |
| **DEC-E09b** | Pinch 2 ngón trên **vùng canvas trống** (không nhắm vào sticker nào) | Canvas có **zoom** (phóng to cả bức tranh để làm chi tiết) không, hay pinch ngoài sticker không có tác dụng gì? Instagram Stories (cùng thể loại: khung cố định, không phải canvas tự do) **cũng không có zoom cấp canvas** — nếu Ink cũng vậy thì nhiều khả năng là đúng convention, không phải thiếu sót | 🟡 *(hạ từ nghi vấn ban đầu — xem tham chiếu Instagram ở §0)* | ☐ |
| **DEC-E09c** | Sau khi (nếu) zoom được canvas, kéo 1 ngón trên vùng trống | Canvas có **pan** (cuộn khung nhìn) được không? Nếu không zoom được thì mục này tự động N/A, ghi lại rõ | 🟡 | ☐ |
| **DEC-E09d** | Double-tap (chạm nhanh 2 lần) vào 1 sticker đã scale/xoay lệch | Có reset về scale/góc mặc định không? Một số app cùng thể loại (Instagram bản mới) có tiện ích này | 🟡 — tiện ích nhỏ, không bắt buộc | ☐ |
| **DEC-E10** | Cross-device — lặp lại `DEC-H09`–`H33` trên **iPad**, đối chiếu với iPhone | Hành vi gesture có giống hệt không, hay iPad có khác biệt riêng? Chưa có xác nhận "dùng chung component" như đã có cho Matrix ở note 1.2.14 | 🟠 | ☐ |
| **DEC-E11** | iPad, mở Emoji picker ở **landscape** | Sheet có giữ nguyên bề rộng hẹp như portrait không (đã quan sát ở `emoji-picker-landscape.png`), hay đây là điều đã sửa | 🟡 | ☐ |
| **DEC-E12** | 🔴 **Qua đêm** — trang trí xong, chờ automation chạy sáng hôm sau | Xem framing ở §0 — decoration có còn trên lock screen thật không | 🔴 | ☐ |
| **DEC-E13** | **Gỡ app, cài lại** sau khi đã lưu decoration | Decoration đã set làm wallpaper có mất không? Wallpaper thật (đã set ở Settings iOS) độc lập với app nên nhiều khả năng còn — cần xác nhận | 🟡 | ☐ |

---

## 4 · Coverage matrix

| State / màn hình | Đã có ảnh | Đã chạm khi test |
|---|:---:|:---:|
| S01 Wallpaper editor · default · filled | ✅ | ☐ |
| S02 Decorate · tooltip · default · calendar-shown | ✅ | ☐ |
| S02 · brush-toolbar (+v2) | ✅ | ☐ |
| S02 · text-editing · text-collapsed *(iPad)* | ✅ | ☐ |
| S02 · emoji-picker (+ landscape iPad) | ✅ | ☐ |
| S02 · photo-menu | ✅ | ☐ |
| S02 · sticker-selected (emoji/cutout/ảnh thường) | ✅ | ☐ |
| S02 · filled / filled-landscape *(iPad)* | ✅ | ☐ |
| S02 · discard-dialog | ✅ | ☐ |
| S02 · sticker-settings (Emoji + Photo) | ✅ | ☐ |
| **Eyedropper đang hút màu** | ❌ | ☐ |
| **UI chọn ảnh sau khi bấm Photo/Cutout** | ❌ | ☐ |
| **Thông báo hết chỗ vẽ (>50 nét)** | ❌ | ☐ |
| **Trạng thái giữa lúc resize/xoay sticker** | ❌ | ☐ |
| **Trạng thái sau khi xoá sticker** | ❌ | ☐ |
| ~~Dark Mode~~ | N/A — app chưa hỗ trợ | — |
| **iPhone**: `filled` canvas riêng (chỉ có ở S01, chưa có ảnh canvas S02 dạng nghỉ không sticker nào chọn) | ❌ | ☐ |
| **Dialog quyền Photos** (nếu có) | ❌ | ☐ |
| **Zoom/pan cấp canvas** (khác pinch/kéo trên 1 sticker) | ❌ | ☐ |

> Các mục ❌ chặn trực tiếp: `DEC-H23`, `H24`, `N10`. `H31`/`H32` **đã hết chặn** — ảnh `sticker-settings`
> (+v2) bổ sung 2026-09-12 xác nhận đúng nội dung. Chưa chụp bổ sung thì ghi coverage gap khi
> chạy, không suy diễn kết quả từ tên gọi. `N01`–`N03` **đã hết chặn** — ảnh `discard-dialog` bổ sung
> 2026-09-12 đã xác nhận đúng nội dung dialog.

---

## 5 · Câu hỏi cần PO/dev trả lời — `DEC-Q`

| ID | Câu hỏi | Vì sao cần |
|---|---|---|
| **DEC-Q01** | 🔴 **Decoration có sống sót qua lần automation chạy tiếp theo không** (wallpaper tự render lại mỗi sáng)? | Nền tảng của toàn bộ §0/`DEC-E12`. Nếu không, giá trị sản phẩm chỉ tồn tại đúng 1 ngày — cần biết **trước khi** đánh giá mức độ nghiêm trọng của mọi bug khác trong flow này |
| **DEC-Q02** | Decorate có giới hạn Free/Pro không? Nếu có, giới hạn ở đâu (số sticker, loại nét, ảnh cutout...)? | Không thấy gate nào trong 16 ảnh — cần xác nhận đây là tính năng miễn phí hoàn toàn hay chưa chụp được màn `locked` |
| **DEC-Q03** | Số nét vẽ chính xác trước khi hiện thông báo hết chỗ (R6) là bao nhiêu? | Chặn `DEC-N10` — không viết được test biên chính xác nếu chỉ biết "hơn 50" |
| **DEC-Q04** | Icon **▦ (grid)** đầu toolbar dùng để làm gì? | `DEC-H08`, `DEC-Q07` — không khớp trực tiếp mô tả nào trong change note |
| **DEC-Q05** | Ảnh chọn qua Photo/Cutout dùng `PHPickerViewController` (không cần quyền) hay `PHPhotoLibrary` trực tiếp (cần quyền Photos)? | Quyết định `DEC-H24` có nên xuất hiện dialog quyền hay không — trả lời dứt điểm câu hỏi mở nhiều kỳ ở [permissions-matrix §1.3](../../references/permissions-matrix.md#13--️-photos--nhiều-khả-năng-cần-chưa-thấy-dialog) |
| **DEC-Q06** | Cutout dùng công nghệ gì (`VNGeneratePersonSegmentationRequest`, on-device hay gọi server)? | Ảnh hưởng khả năng offline (`DEC-N15`) và thời gian xử lý ảnh lớn (`DEC-E02`) |
| **DEC-Q07** | Decorate iPhone/iPad có dùng chung component không? | `DEC-E10` — chưa có xác nhận tương tự Matrix ở note 1.2.14, không tự suy diễn theo rule `screenshot-naming.md` §8.11 |
| **DEC-Q08** | Có giới hạn số lượng sticker tối đa trên 1 canvas không (ngoài giới hạn nét vẽ)? | Không đề cập trong change note — ảnh hưởng `DEC-N13` và hiệu năng máy yếu |
| **DEC-Q09** | Giới hạn ký tự cho Text sticker là bao nhiêu (nếu có)? | Không đề cập — ảnh hưởng `DEC-E03`, khác với Ink AI vốn có dòng đếm đỏ rõ ràng khi vượt giới hạn |
| **DEC-Q10** | Canvas có hỗ trợ **zoom/pan cấp toàn bộ bức tranh** không (khác pinch/kéo trên từng sticker)? | Change note hoàn toàn không nhắc. Instagram Stories (cùng thể loại khung cố định) cũng không có zoom/pan canvas — nhiều khả năng đây là chủ ý theo convention thể loại, không phải thiếu sót, nhưng cần **xác nhận bằng lời** thay vì suy diễn. `DEC-E09b`/`E09c` |
| **DEC-Q11** | Scale/xoay sticker có ăn khi pinch **ở bất kỳ đâu trên sticker** (như Instagram), hay bắt buộc phải chạm đúng handle góc dưới phải? | `DEC-H28b`. Nếu bắt buộc đúng handle, tap target nhỏ (`DEC-E08`) trở thành điểm nghẽn nghiêm trọng hơn vì không có cách thay thế |
| **DEC-Q12** | Có affordance **kéo-thả-vào-thùng-rác** để xoá sticker không (như Instagram/Snapchat), hay chỉ có nút ✕ cố định? | `DEC-H33b`. Không bắt buộc phải có, nhưng nên biết đây là quyết định thiết kế có chủ ý hay chưa nghĩ tới |
| **DEC-Q13** | Vì sao nút phá huỷ ở 2 nơi style khác nhau — **Delete** trong sheet cài đặt sticker (chữ đỏ, nền nhạt, chuẩn iOS) vs **Discard** trong popup thoát (nền tối, nổi bật nhất)? | `DEC-H32b`, `DEC-N03b`. Cùng 1 tính năng, 2 pattern khác nhau cho cùng loại hành động — cần biết có chủ ý phân biệt mức độ nghiêm trọng (xoá 1 sticker vs mất cả bản vẽ) hay chỉ là thiếu rà soát |
| **DEC-Q14** | Double-tap vào sticker **chưa được chọn trước** có mở thẳng sheet cài đặt không, hay bắt buộc phải chạm chọn (1 lần) trước? | `DEC-H31`. Change note viết "chạm lần 2 vào item **đang chọn**" — ngụ ý phải chọn trước, nhưng chưa xác nhận trên máy thật |

---

## 6 · Smoke 15 phút cho flow này

| # | Việc | ID | Thời lượng |
|:---:|---|---|:---:|
| 1 | Vẽ 1 nét → buông tay → xem header/toolbar có hiện lại ngay không | `DEC-H15` | 2 phút |
| 2 | Trang trí đủ 4 loại (vẽ/chữ/emoji/ảnh) → lưu → đối chiếu preview S01 khớp từng phần tử | `DEC-H34` | 4 phút |
| 3 | Trang trí xong → bấm ✕ → chọn Keep editing → xác nhận không mất gì | `DEC-N01`, `N02` | 2 phút |
| 4 | Vẽ liên tục qua ngưỡng ~50 nét → xem thông báo + nét cũ còn không | `DEC-N10` | 3 phút |
| 5 | Bấm Cutout lần đầu trên máy sạch → ghi lại có dialog quyền Photos không | `DEC-H24` | 2 phút |
| 6 | Bật VoiceOver, thử chọn + di chuyển 1 sticker | `DEC-E07` | 2 phút |

---

## 7 · Kết luận phiên

```
Phiên: __________   Build: 1.2.15 (56)   iOS: ______   Thiết bị: __________

Q1 Mục tiêu user:            cá nhân hoá wallpaper bằng vẽ/chữ/emoji/ảnh trước khi lưu
Q8 Mục tiêu business:        chưa rõ Free/Pro (DEC-Q02) — nhiều khả năng giữ chân, không bán hàng trực tiếp
— Chạy luồng chính —
Q2 Xong dễ lần đầu?          Có / Không — vì: __________
Q3 Điểm khựng/bối rối:       __________________________
   (icon toolbar không label? 4 loại nét khó phân biệt?)
Q4 Thao tác sai / gián đoạn: __________________________
Q5 State chưa test:          __________________________
   (sheet cài đặt sticker · eyedropper · Dark Mode · Discard dialog · limit-warning)
— Kết luận —
Q6 Rủi ro #1 nếu ship:       __________________________
Q7 Tự mình dùng hằng ngày?   Có / Không — vì: __________
Q9 15 phút thì test gì:      §6

=> Verdict: 🟢 / 🟡 / 🔴  — kèm bằng chứng
```

**Ngưỡng cho riêng flow này:**

| Verdict | Điều kiện |
|---|---|
| 🔴 | Header/toolbar kẹt cứng sau khi vẽ/resize *(H15, biến thể của R1)* · mất nét/sticker không phục hồi được *(N10, N14)* · decoration không sống sót qua automation *(Q01/E12)* · popup Discard mất dữ liệu không cảnh báo *(N01)* · wallpaper lưu không khớp editor *(H34, H36)* · VoiceOver hoàn toàn không dùng được *(E07)* |
| 🟡 | Icon toolbar khó đoán nghĩa vì không label · tap target sticker hơi nhỏ nhưng vẫn bấm được · Dark Mode chưa polish · landscape emoji picker chưa tối ưu không gian |
| 🟢 | Vẽ/thêm sticker mượt, không giật · undo/redo nhất quán qua mọi thao tác · lưu ra đúng 100% những gì đã trang trí, cả trong app lẫn lock screen thật · qua đêm decoration vẫn còn |

---

## 8 · Ghi chú về giới hạn checklist này

- **8 trạng thái vẫn chưa có ảnh** *(xem §4)* — `DEC-N10` (thông báo hết chỗ vẽ) là mục quan trọng nhất còn
  thiếu bằng chứng, nên chụp bổ sung sớm. `DEC-N01`–`N03` (popup Discard) và `DEC-H31`/`H32` (sheet cài đặt
  sticker) **đã hết coverage gap** — ảnh `discard-dialog.png` và `sticker-settings.png` (+v2) bổ sung
  2026-09-12 xác nhận đúng nội dung, kèm 2 phát hiện UX mới: nút Discard nổi bật hơn Keep editing (`DEC-N03b`),
  và 2 pattern khác nhau cho cùng loại hành động phá huỷ giữa 2 dialog (`DEC-Q13`). Zoom/pan cấp canvas mới
  thêm vào danh sách gap sau khi đối chiếu với Instagram Stories (`DEC-Q10`).
- **Dark Mode không còn là gap** — xác nhận 2026-09-12 app chưa hỗ trợ, loại khỏi `DEC-E05` và coverage matrix.
- **`DEC-Q01` chặn cách đọc kết quả của cả checklist.** Nếu decoration không sống sót qua automation, mọi bug
  khác trong §1–§3 giảm mức độ nghiêm trọng xuống (feature chỉ dùng 1 lần/ngày thì ít bug nào là 🔴 thật sự) —
  nhưng bản thân việc mất decoration lại trở thành bug 🔴 số 1. Trả lời câu này **trước tiên**.
- **`DEC-E12` cần qua đêm**, không rút ngắn được — giống cảnh báo đã có ở Flow 03.
- **`DEC-E07` (VoiceOver) cần người có kinh nghiệm dùng VoiceOver thật**, không phải người test tự bật rồi mò —
  kết luận "không dùng được" chỉ đáng tin nếu người test biết cách thao tác chuẩn.
- **`DEC-E10` (cross-device) tốn thời gian gấp đôi** vì phải lặp lại gần hết §1 trên iPad. Ưu tiên sau khi đã
  xác nhận xong hành vi trên iPhone.
- Toàn bộ R1–R8 trong change note mục 4 đã được kéo vào §2.2–§2.3 dưới dạng case cụ thể — nếu tái hiện lại bất
  kỳ cái nào, đây là **regression thật**, không phải bug mới, nhưng vẫn phải log vì đã từng "fixed".

---
---

# Phần 2 — S03: Component Editor

> **Nguồn:** [wireframe § S03](../ui/ux/wideframes/14_edit-wallpaper.md#s03--component-editor--15-ảnh--6-state-chính-bổ-sung-2026-09-24-cập-nhật-cùng-ngày) (15 ảnh) ·
> [index screenshot iPhone § 03_component-editor](../ui/ux/screenshots/iphone/index.md#03_component-editor--chỉnh-riêng-từng-band-batch-5-2026-09-24-chưa-có-build-number)
> **Test basis:** [QC — Component Editor 1.2.md](../specs/wallpaper-component/QC%20—%20Component%20Editor%201.2.md) (TestFlight 1.2.17 (103)) · **Test plan:** [test-plan-component-editor.md](../test-plans/component-editor/test-plan-component-editor.md) · [test-analysis-component-editor.md](../test-plans/component-editor/test-analysis-component-editor.md) (73 test condition)
> **Khung đánh giá:** [exploratory-references](../../references/exploratory-references.md) · [permissions-matrix](../../references/permissions-matrix.md)
> **Build:** TestFlight 1.2.17 (103) — **xác nhận lại trên máy trước khi chạy**, batch ảnh hiện có chưa chắc cùng build (xem test-analysis TB-7) · **Thiết bị:** ____________ · **iOS:** ____________ · **Người test:** ____________

> ⚠️ **Khác S01/S02 ở Phần 1** — S03 đã có **test basis chính thức** (QC spec 1.2.17) và **test plan/test-case riêng** (xem link trên). Checklist này **không thay thế** test plan — dùng để **thăm dò tự do phần gesture/lồng container** mà kỹ thuật black-box khó phủ hết (đúng lý do skill này đề xuất ở mục 11 của test plan), và để tester mới làm quen màn hình trước khi chạy case chính thức. Case nào đã có đáp án rõ từ test basis/test plan thì đánh dấu ✅ nguồn, không phải "chưa biết trước kết quả".
> ⚠️ **7 câu hỏi mở đã trả lời qua trao đổi trực tiếp với dev (2026-09-24)** — đã đưa thẳng vào §S03-1 (Happy path) dưới dạng kỳ vọng cụ thể thay vì để ở mục Câu hỏi: (1) bấm + khi chưa chọn gì → chèn giữa canvas, (2) Decorate & Component Editor độc lập nhưng wallpaper cuối phải gộp đủ cả 2, (3) bố cục **bắt buộc** sống sót qua automation Shortcut overnight, (4) **không có** dialog xác nhận khi bấm ✕ Cancel (đúng spec, nhưng QA khuyến nghị bổ sung — xem `CMP-Q07`).

---

## S03 · 0 — Framing

**Q1 — Mục tiêu user của riêng S03 (khác S02):** Decorate (S02) là **trang trí thêm** lên wallpaper có sẵn (thẩm mỹ). Component Editor (S03) là **kiểm soát nội dung/thông tin nào hiển thị** — gần với "tự dựng dashboard cá nhân" hơn là "làm đẹp". Hai mục tiêu khác hẳn nhau dù chung 1 màn gốc S01.

**Q8 — Mục tiêu business:** chưa thấy badge PRO trong 2 ảnh sheet Add component hiện có (xem `CMP-Q06`) — PRD §11 tự nhận đây là cơ chế **mới, chưa có tiền lệ** trong catalog. Chưa rõ đây là tính năng giữ chân miễn phí hay sẽ gate theo loại component.

**Vì sao S03 khác S02 dù cùng là "editor rủi ro cao":** S02 là editor vẽ tay tự do (freeform), S03 là editor **dàn trang theo khối** (block-based) — gần iOS Home Screen widget editor hơn là Instagram Stories.

**Tham chiếu UX quen thuộc — iOS Home Screen widget edit mode (jiggle mode):**

| Thao tác | iOS Home Screen | Ink Component Editor (quan sát từ ảnh) | Nhận xét |
|---|---|---|---|
| Vào chế độ sửa | Long-press vùng trống → jiggle, không cần tìm nút | Bấm icon **layers** riêng (cạnh crop) | Ink cần user **khám phá ra icon** — không dùng gesture hệ điều hành đã quen; đáng theo dõi mức độ dễ tìm |
| Resize | Kéo 1 handle, **size rời rạc** (nhỏ/vừa/lớn cố định) | Kéo 4 góc, **giá trị liên tục** (không preset) | Ink linh hoạt hơn nhưng dễ tạo bố cục xấu/lệch hơn — không có "snap to nice size" như iOS |
| Xoá | Nút (−) cố định góc trên trái mỗi widget | Icon trash trên pill mini nổi khi chọn | Khác vị trí, cùng ý tưởng — pill của Ink gọn hơn (đỡ chiếm diện tích canvas) |
| Thoát | Bấm Done hoặc chạm ra ngoài | Bấm ✓ (Done) | Khớp convention |
| Undo | **Không có Undo** trong jiggle mode gốc của iOS | Có Undo/Redo đầy đủ, đúng 1 bước/thao tác | Ink làm **tốt hơn** iOS ở điểm này — nên giữ vững, test kỹ (`CMP-H19`, `N05`) |

**Rủi ro xuyên suốt chạm vào S03** *(chỉ link, không lặp lại)*:
[§1.1 chuỗi setup có sống sót qua người dùng thật](../../references/exploratory-references.md#11--chuỗi-setup-có-sống-sót-qua-người-dùng-thật-không) — áp dụng trực tiếp cho `CMP-H38` (bố cục qua automation overnight) ·
[§1.2 lock screen là ảnh tĩnh](../../references/exploratory-references.md#12--lock-screen-là-ảnh-tĩnh-dữ-liệu-cũ-tới-mức-nào-là-chấp-nhận-được) — các component đọc dữ liệu thật (event, task, countdown) nên dữ liệu cũ ảnh hưởng cả preview trong editor lẫn wallpaper thật ·
[§1.6 Google Calendar](../../references/exploratory-references.md#16--google-calendar-nguồn-dữ-liệu-duy-nhất-cần-mạng-và-tài-khoản) — nếu có loại component đọc event Google (vd Timetable, Month grid), token hết hạn ảnh hưởng thế nào ngay trong lúc đang edit? Xem `CMP-E01`.

---

## S03 · 1 — Happy path — `CMP-H`  *(Checklist-based testing, §4.4.3)*

### 1.1 · Vào Component Editor — S01 → S03

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **CMP-H01** | Từ S01, template **dạng stack**, bấm icon layers (⧉) cạnh crop | Vào S03 full-screen, header đổi hẳn thành ✕/↶/↷/✓, không còn tên template | — | ☐ |
| **CMP-H02** | Từ S01, template **KHÔNG phải dạng stack** | Icon layers **không hiện** — không phải lỗi (QC spec dòng 18) | — | ☐ |
| **CMP-H03** | Lần đầu tài khoản vào S03 | Coach mark "Tap to edit a piece" hiện, bấm bỏ qua được | ⚠️ chưa có ảnh — ghi coverage gap nếu chưa chụp được | ☐ |

### 1.2 · Chọn thành phần — S03

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **CMP-H04** | Chạm 1 thành phần đơn (không trong container) | Khung viền **xanh lá** + pill mini nổi (icon sliders + trash) | — | ☐ |
| **CMP-H05** | Chạm ra vùng trống | Bỏ chọn, pill biến mất | — | ☐ |
| **CMP-H06** | Thành phần nằm trong Row/Column, chạm lần 1 | Chọn cả **container**, KHÔNG chọn thẳng con — hành vi cố ý (QC spec dòng 28/152) | — | ☐ |
| **CMP-H07** | Chạm tiếp vào đúng con bên trong container đã chọn | Chọn con, đi sâu đúng 1 cấp mỗi lần chạm | Test qua đủ 3 cấp nếu dựng được layout lồng tối đa | ☐ |
| **CMP-H08** | Bấm icon sliders trên pill | Mở Inspector đúng thành phần đang chọn | — | ☐ |
| **CMP-H09** | Bấm icon trash trên pill | Xoá thành phần, toast "Removed …" + Undo hiện | — | ☐ |
| **CMP-H10** | Bấm Undo trên toast Removed | Thành phần quay lại đúng vị trí cũ | — | ☐ |

### 1.3 · Inspector (bảng thuộc tính) — S03

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **CMP-H11** | Mở Inspector, cuộn từ đầu tới cuối | 1 sheet cuộn dọc, **không có tab** — thứ tự Position → Content → Text (đã xác nhận với Timetable) | Verify lại thứ tự này với ≥2 loại component khác | ☐ |
| **CMP-H12** | Đổi Placement Auto ↔ Fixed | Thành phần **không tự nhảy** vị trí ngay lúc đổi | — | ☐ |
| **CMP-H13** | Chọn Fixed, kéo thanh Vertical position | Thành phần chạy dọc theo đúng tỉ lệ ngón tay | — | ☐ |
| **CMP-H14** | Kéo thanh Width trong Inspector | Khớp giá trị với thao tác kéo góc trên canvas — đồng bộ 2 chiều | Kéo 1 bên, xem bên kia cập nhật theo ngay | ☐ |
| **CMP-H15** | So sánh thành phần ngoài cùng vs trong Row/Column | Thanh **Size** chỉ hiện với thành phần **ngoài cùng** | Test cả 2 trường hợp, không chỉ 1 | ☐ |
| **CMP-H16** | Đổi knob riêng theo loại (màu, phông, số dòng…) | Cập nhật ngay trên canvas, không cần đóng sheet mới thấy | — | ☐ |
| **CMP-H17** | Bấm Duplicate trên Inspector | Tạo bản sao ở vị trí hợp lý (không đè khít lên bản gốc gây khó chọn lại) | ⚠️ chưa có ảnh — verify + ghi coverage gap | ☐ |
| **CMP-H18** | Bấm ✓ (Done) | Quay lại S01, bố cục mới giữ nguyên trên preview | — | ☐ |

### 1.4 · Di chuyển (kéo) — S03 🔴 vùng rủi ro cao nhất

> QC spec tự xếp đây là *"chỗ đã sửa đi sửa lại nhiều nhất trong đợt này"* — test kỹ với template có Row lồng trong Column.

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **CMP-H19** | 🔴 Chạm chọn, giữ và kéo | Thành phần đi theo ngón tay **ngay lập tức**, không trễ | — | ☐ |
| **CMP-H20** | Kéo lên/xuống trong stack/column | Có chặn trên và dưới, không đè lên thành phần phía trên | — | ☐ |
| **CMP-H21** | Kéo ngang | Dịch trái/phải trong phạm vi cho phép | — | ☐ |
| **CMP-H22** | Chọn 1 Row/Column rồi kéo cả container | Toàn bộ con đi theo đúng 1 lần, không văng ra ngoài | — | ☐ |
| **CMP-H23** | 🔴 Nhả tay sau khi kéo | Render lại đúng 1 lần tại vị trí thả, **không** nhảy về chỗ cũ rồi nhảy lại | Đây là điểm verify quan trọng nhất của cả §1.4 | ☐ |

### 1.5 · Đổi bề rộng (kéo góc) — S03

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **CMP-H24** | Kéo thử cả 4 góc của 1 thành phần đang chọn | Cả 4 góc đều là vùng kéo hợp lệ dù không vẽ chỉ báo hình tròn | — | ☐ |
| **CMP-H25** | Kéo góc phải, rồi kéo góc trái | Kéo phải: chỉ mép phải chạy. Kéo trái: chỉ mép trái chạy, cạnh đối diện đứng yên | — | ☐ |
| **CMP-H26** | Quan sát bề rộng trong lúc đang kéo (chưa nhả tay) | Đổi **realtime** theo ngón tay | — | ☐ |
| **CMP-H27** | Trong Row **2 con**, kéo góc 1 phần tử | Phần tử liền kề co/giãn bù đúng bằng đó, tổng bề rộng Row không đổi | — | ☐ |

### 1.6 · Thêm thành phần / Row / Column — S03

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **CMP-H28** | Bấm + | Sheet Add component đủ 6 nhóm: Calendar, Events, Tasks, Progress, Text, Layout | — | ☐ |
| **CMP-H29** | Chọn 1 loại bất kỳ | Thêm thành công, toast "Added …" + Undo hiện, **KHÔNG** tự động chọn thành phần vừa thêm (đã xác nhận qua ảnh 2026-09-24) | — | ☐ |
| **CMP-H30** | Đang chọn 1 thành phần đơn, bấm + | Thành phần mới rơi **ngay dưới** thành phần đang chọn | — | ☐ |
| **CMP-H31** | Đang chọn 1 Row/Column, bấm + | Thành phần mới rơi vào **TRONG** container đó | — | ☐ |
| **CMP-H32** | ✅ **KHÔNG chọn gì**, bấm + | Thành phần mới chèn vào **giữa canvas (center)** — xác nhận qua dev 2026-09-24 | — | ☐ |
| **CMP-H33** | Thêm Row, rồi thêm Column | Row: 1 hàng 2 ô trống nét đứt cạnh nhau. Column: 2 ô trống xếp dọc — mỗi ô có nút + riêng | — | ☐ |
| **CMP-H34** | 🔴 Bấm + trong 1 ô trống của Row/Column | Chỉ ô đó được lấp, **ô còn lại giữ nguyên** — regression của lỗi vừa fix, verify kỹ | — | ☐ |
| **CMP-H35** | Lấp đủ cả 2 ô | Row/Column hiện đủ 2 thành phần, không còn ô trống thừa | — | ☐ |

### 1.7 · Lưu — S03 → S01 và ngoài app

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **CMP-H36** | 🔴 Vừa chỉnh bố cục S03, vừa trang trí S02 trên **cùng 1 template**, lưu cả hai | Wallpaper cuối (S01 `filled`) render **đầy đủ cả 2 phần**, không mất/đè lẫn nhau — xác nhận qua dev: 2 tính năng độc lập nhưng kết quả phải gộp đủ | — | ☐ |
| **CMP-H37** | 🔴 Đặt bố cục vừa chỉnh làm lock screen thật (qua Shortcut), khoá máy xem | Render đúng như preview trong editor, không chỉ đúng trên canvas | — | ☐ |
| **CMP-H38** | 🔴🔴 Set xong, **chờ qua đêm** để automation Shortcut chạy lại (không rút ngắn bằng đổi giờ hệ thống) | Bố cục **PHẢI còn nguyên và cập nhật đầy đủ** (event/data mới) — xác nhận **bắt buộc** qua dev, đây là case quan trọng nhất toàn bộ S03 | Cùng cảnh báo với `DEC-E12` — không dùng kết quả nếu rút ngắn bằng cách đổi giờ máy | ☐ |

---

## S03 · 2 — Negative — `CMP-N`  *(Checklist-based cho vấn đề đã biết + Error guessing cho phần suy luận)*

### 2.1 · Huỷ / bỏ dở giữa chừng

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **CMP-N01** | Bấm ✕ (Cancel) khi có thay đổi chưa lưu | ✅ Đã xác nhận (2026-09-24): **thoát thẳng ngay, KHÔNG có dialog xác nhận** — đúng spec, nhưng khác S02 (có Discard dialog). QA khuyến nghị bổ sung — xem `CMP-Q07` | Mất công sức không cảnh báo — nghịch lý so với S02 cùng flow | 🟠 | ☐ |
| **CMP-N02** | Sau khi Cancel, kiểm tra lại từng phần đã đổi trong phiên | Toàn bộ bị bỏ hết, **kể cả** thành phần vừa thêm mới — không sót lại 1 phần | Mất 1 phần niềm tin vào Cancel nếu chỉ hoàn tác 1 phần | 🟠 | ☐ |
| **CMP-N03** | Thêm Row/Column rồi không lấp gì, bấm **✓ (Done)** | Container rỗng tự bị xoá, toast "Removed the empty layout" + Undo | Để lại container rỗng vô hình trong dữ liệu, phá layout khi mở lại | 🟡 | ☐ |
| **CMP-N04** | Bấm Undo trên toast "Removed the empty layout" | Container rỗng quay lại đúng vị trí trong editor | Undo không hoạt động cho toast tự động (khác Undo cho thao tác tay) | 🟡 | ☐ |

### 2.2 · Undo/Redo — biên

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **CMP-N05** | Kéo 1 thành phần đi xa (nhiều pixel, nhiều lần đổi hướng trong 1 lần giữ ngón) rồi Undo | Chỉ hoàn tác **đúng 1 bước** — về lại vị trí trước khi bắt đầu kéo, không phải từng frame | Undo vô dụng nếu phải bấm hàng chục lần mới về đúng chỗ | 🟠 | ☐ |
| **CMP-N06** | Sau Undo, bấm Redo | Làm lại đúng thao tác vừa Undo | — | 🟡 | ☐ |
| **CMP-N07** | Undo liên tục tới khi hết lịch sử | Nút Undo tự **disable**, không crash, không Undo quá canvas gốc lúc mở S03 | — | 🟡 | ☐ |

### 2.3 · Giới hạn & xung đột lồng nhau

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **CMP-N08** | Ở cấp lồng thứ 3 (tối đa theo QC spec), mở sheet Add component | Nhóm **Layout** biến mất, các nhóm khác vẫn còn | User tưởng bị bug thay vì đã chạm giới hạn thiết kế | 🟡 | ☐ |
| **CMP-N09** | Ở cấp 1–2, mở sheet Add component | Nhóm Layout vẫn hiện đầy đủ | — | 🟡 | ☐ |
| **CMP-N10** | ⚠️ Thử thêm container thứ 4 (vượt giới hạn công bố) | Quan sát **chính xác** hệ thống chặn ở đâu — dùng kết quả này để tự trả lời câu hỏi #5 (test-plan mục 10, cách đếm cấp) nếu quan sát được rõ ràng | Chưa rõ cấp được đếm từ đâu — xem `CMP-Q04` | 🟠 | ☐ |
| **CMP-N11** | Bấm vào nền ô trống của Row/Column, trượt ra ngoài nút + | Chọn container, **KHÔNG** mở sheet Add component | Mở nhầm sheet gây gián đoạn thao tác đang định làm | 🟡 | ☐ |

### 2.4 · Gián đoạn

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **CMP-N12** | Đang kéo/resize 1 thành phần → đưa app xuống background → quay lại | Vị trí giữ nguyên như lúc thả tay gần nhất, không nhảy về chỗ cũ | Mất công sức sắp xếp | 🟡 | ☐ |
| **CMP-N13** | 🔴 Đang dựng bố cục (chưa lưu) → kill app → mở lại | Ghi rõ: mất hết, hay khôi phục được draft dở dang? Không có case nào trong test basis — error guessing, tương tự `DEC-N14` | Mất công sức không cảnh báo trước | 🔴 | ☐ |
| **CMP-N14** | Mở Component Editor khi hoàn toàn offline | Toàn bộ thao tác (chọn/kéo/resize/thêm) hoạt động bình thường — trừ phần đọc dữ liệu Google Calendar (nếu có) | Nếu có phần phụ thuộc mạng mà không báo lỗi rõ, coverage gap | 🟡 | ☐ |

---

## S03 · 3 — Edge — `CMP-E`  *(Error guessing, §4.4.1)*

| ID | Tình huống | Câu hỏi | Mức | ☐ |
|---|---|---|:---:|:---:|
| **CMP-E01** | Component đọc event Google Calendar (vd Timetable, Month grid) trong lúc token đã hết hạn/thu hồi | Canvas editor hiển thị gì — trống, lỗi rõ, hay âm thầm thiếu event? Liên quan [§1.6 Google Calendar](../../references/exploratory-references.md#16--google-calendar-nguồn-dữ-liệu-duy-nhất-cần-mạng-và-tài-khoản) | 🟠 | ☐ |
| **CMP-E02** | Layout có rất nhiều thành phần xếp chồng (10+ band) trong 1 template | Cuộn/thao tác có giật không? Chọn đúng từng cái, không bị dính layer? | 🟠 | ☐ |
| **CMP-E03** | Xoá hết mọi thành phần trong template | Canvas hiện gì — empty state có hướng dẫn, hay trắng trơn gây hoang mang? | 🟡 | ☐ |
| **CMP-E04** | Kéo 1 thành phần ra mép trên/dưới màn hình thật nhanh (fling gesture) | Có chặn đúng vị trí biên hay vọt qua? | 🟠 | ☐ |
| **CMP-E05** | Component có text/tên rất dài (Quote dài, tên event dài, tiếng Việt có dấu) trong lúc đang resize nhỏ lại | Nội dung tự co giãn hợp lý hay tràn ra ngoài khung? | 🟡 | ☐ |
| **CMP-E06** | 🔴 Dynamic Type cỡ lớn nhất | Inspector (nhiều dòng số liệu/nhãn) còn đọc được không, có cắt/chồng chữ không? | 🟠 | ☐ |
| **CMP-E07** | 🔴 VoiceOver bật, thử chọn + kéo di chuyển 1 thành phần | Gesture tự do (kéo, kéo góc) có cách thay thế bằng VoiceOver không, hay hoàn toàn không dùng được? Cùng mức rủi ro với `DEC-E07` vì cùng bản chất gesture-heavy | 🔴 | ☐ |
| **CMP-E08** | Máy màn hình nhỏ (iPhone SE/mini) | Pill mini + Inspector có đủ chỗ, hay che khuất canvas quá nhiều? | 🟠 | ☐ |
| **CMP-E09** | Xoay iPad (nếu có máy) | Khung viền chọn và ô trống Row/Column có khớp đúng khi xoay ngang/dọc? (TC-58 trong test-analysis) | 🟡 | ☐ |
| **CMP-E10** | Cross-device — lặp lại §S03-1 cơ bản trên iPad | Hành vi có giống iPhone không? **Chưa có ảnh iPad nào cho S03** | 🟠 | ☐ |
| **CMP-E11** | Thử thêm đủ **16 loại component** (không chỉ 4 loại đã có bằng chứng: Timetable, Year progress, Month grid, Mini month) | Có loại nào gây crash/lỗi hiển thị riêng không? Inspector của loại đó có nhóm/knob gì khác? | 🟠 | ☐ |

---

## S03 · 4 — Coverage matrix

| State / màn hình | Đã có ảnh | Đã chạm khi test |
|---|:---:|:---:|
| S01 · `component-editor-entry` (annotation, chưa phải UI thật) | ✅ | ☐ |
| S03 · `default` (+v2) — chưa chọn gì | ✅ | ☐ |
| S03 · `default-v3` (Month grid) · `default-v4` (Mini month) | ✅ | ☐ |
| S03 · `add-component` (+scrolled) — sheet 6 nhóm | ✅ | ☐ |
| S03 · `added` (Year progress) · `added-v2` (Timetable) — toast | ✅ | ☐ |
| S03 · `selected` — viền xanh lá + pill mini | ✅ | ☐ |
| S03 · `inspector` → `inspector-scrolled-v4` — 5 mốc cuộn (Timetable) | ✅ | ☐ |
| S03 · `resizing` — nhãn số + vạch dẫn | ✅ | ☐ |
| **Coach mark "Tap to edit a piece"** | ❌ | ☐ |
| **Đang kéo di chuyển** (giữa lúc drag, không phải resize) | ❌ | ☐ |
| **Đang kéo cả 1 Row/Column** | ❌ | ☐ |
| **Row/Column vừa thêm** (2 ô trống nét đứt) | ❌ | ☐ |
| **Container rỗng bị tự xoá** + toast "Removed the empty layout" | ❌ | ☐ |
| **Cấp lồng thứ 3** — sheet Add component ẩn nhóm Layout | ❌ | ☐ |
| **Cảnh báo tràn màn** "Part of this runs off the screen" | ❌ | ☐ |
| **Ẩn/hiện chrome** — 2 trạng thái | ❌ | ☐ |
| **Inspector của 15/16 loại component khác** ngoài Timetable | ❌ | ☐ |
| **Badge PRO** trong sheet Add component | ❌ | ☐ |
| Bản **iPad** cho toàn bộ S03 | ❌ | ☐ |

---

## S03 · 5 — Câu hỏi cần PO/dev trả lời — `CMP-Q`

> 4 câu đầu kế thừa từ [test-plan mục 10](../test-plans/component-editor/test-plan-component-editor.md#10-gap-cần-làm-rõ-trước-khi-execute) (câu #2–#5, vẫn mở) — giữ lại để tra cứu nhanh trong phiên, không cần mở file khác.

| ID | Câu hỏi | Vì sao cần |
|---|---|---|
| **CMP-Q01** | Trong 1 Row có 3+ thành phần con, kéo góc đổi bề rộng 1 phần tử thì các phần tử còn lại bù trừ thế nào? | Chặn `CMP-H27` biến thể 3+ con, và TC-27 (test-analysis) |
| **CMP-Q02** | Giá trị bề rộng tối thiểu cụ thể (pt hoặc %) khi kéo góc thu nhỏ là bao nhiêu? | Cần cho BVA chính xác ở test-case, hiện chỉ verify được "có chặn", chưa verify đúng ngưỡng |
| **CMP-Q03** | "Giống Studio" (QC spec dòng 77) nghĩa là gì, và giá trị lề 2 bên mặc định của thành phần mới thêm là bao nhiêu? | Không xác định được lề "đúng" hay "sai" nếu không có con số |
| **CMP-Q04** | "Tối đa 3 cấp container" — canvas gốc có tính là 1 cấp không, hay chỉ đếm số lớp Row/Column lồng nhau? | Chặn `CMP-N10` — chưa biết chính xác điểm hệ thống phải chặn |
| **CMP-Q05** | Nếu có loại component đọc Google Calendar, token hết hạn/thu hồi thì Component Editor hiển thị gì? | `CMP-E01` — cùng câu hỏi đã đặt ở [permissions-matrix §3](../../references/permissions-matrix.md#3--tầng-c--uỷ-quyền-google-calendar-oauth), chưa có câu trả lời riêng cho ngữ cảnh đang edit (khác lúc chỉ xem wallpaper) |
| **CMP-Q06** | Có giới hạn số lượng thành phần tối đa trên 1 canvas không? | Không đề cập trong test basis — ảnh hưởng `CMP-E02` và hiệu năng máy yếu, tương tự `DEC-Q08` đã hỏi cho sticker ở Decorate |
| **CMP-Q07** | Nên bổ sung dialog xác nhận khi bấm ✕ (Cancel) giống popup Discard ở S02 không? | `CMP-N01`. Hiện tại đúng spec (không có dialog) nhưng khác hẳn S02 cùng flow — QA đã khuyến nghị bổ sung (xem test-plan mục 10, câu #9), cần PO/design quyết định chính thức trước khi coi đây là việc bắt buộc |

---

## S03 · 6 — Smoke 15 phút cho S03

| # | Việc | ID | Thời lượng |
|:---:|---|---|:---:|
| 1 | Chọn 1 thành phần → kéo di chuyển → nhả tay, xem có giật/nhảy không | `CMP-H19`, `H23` | 2 phút |
| 2 | Kéo góc resize 1 thành phần trong Row 2 con, xem bù trừ đúng | `CMP-H27` | 2 phút |
| 3 | Thêm 1 Row, lấp 1 ô, xem ô còn lại có giữ nguyên không | `CMP-H34` (regression vừa fix) | 2 phút |
| 4 | Bấm ✕ Cancel sau khi đổi gì đó → xác nhận mất hết + không có dialog | `CMP-N01`, `N02` | 1 phút |
| 5 | Vừa chỉnh S03 vừa trang trí S02 trên cùng template, lưu, xem cả 2 lên wallpaper cuối | `CMP-H36` | 4 phút |
| 6 | Set làm lock screen thật, khoá máy xem đúng bố cục | `CMP-H37` | 2 phút |
| 7 | Undo liên tục 1 chuỗi thao tác (kéo + resize + thêm) tới hết lịch sử | `CMP-N05`, `N07` | 2 phút |

> 🔴🔴 **`CMP-H38` (sống sót qua automation overnight) KHÔNG nằm trong 15 phút này** — cần phiên riêng qua đêm, xem §S03-1.7. Đây là case quan trọng nhất của cả S03, nên bắt đầu chuỗi qua đêm **càng sớm càng tốt** trong lịch test, song song với các phiên 15 phút khác.

---

## S03 · 7 — Kết luận phiên

```
Phiên: __________   Build: 1.2.17 (103)   iOS: ______   Thiết bị: __________

Q1 Mục tiêu user:            kiểm soát nội dung/thông tin hiển thị trên wallpaper (khác Decorate — trang trí)
Q8 Mục tiêu business:        chưa rõ Free/Pro (CMP-Q06 tương tự) — PRD §11 tự nhận là cơ chế mới
— Chạy luồng chính —
Q2 Xong dễ lần đầu?          Có / Không — vì: __________
Q3 Điểm khựng/bối rối:       __________________________
   (icon layers khó tìm? chọn container trước con dễ hiểu nhầm là bug? Inspector cuộn dài không có tab?)
Q4 Thao tác sai / gián đoạn: __________________________
Q5 State chưa test:          __________________________
   (12/16 loại component · coach mark · đang kéo giữa chừng · container rỗng bị xoá · cấp lồng thứ 3)
— Kết luận —
Q6 Rủi ro #1 nếu ship:       __________________________
Q7 Tự mình dùng hằng ngày?   Có / Không — vì: __________
Q9 15 phút thì test gì:      §S03-6

=> Verdict: 🟢 / 🟡 / 🔴  — kèm bằng chứng
```

**Ngưỡng cho riêng S03:**

| Verdict | Điều kiện |
|---|---|
| 🔴 | Bố cục **không sống sót qua automation overnight** (`CMP-H38`) · mất dữ liệu khi kéo/resize không phục hồi được (`N05`, `N13`) · nhả tay sau kéo bị nhảy/giật (`H23`) · regression Row/Column ô trống tái phát (`H34`) · Decorate + Component Editor không gộp đủ vào wallpaper cuối (`H36`) · VoiceOver hoàn toàn không dùng được (`E07`) |
| 🟡 | Không có dialog xác nhận Cancel (đã biết, đang chờ PO — `N01`) · Inspector cuộn dài không có tab định hướng · icon layers khó tìm lần đầu · pill mini/Inspector chật trên máy nhỏ |
| 🟢 | Chọn/kéo/resize mượt, không giật · Undo/Redo nhất quán qua mọi thao tác · bố cục lưu đúng và sống sót qua automation qua đêm · wallpaper cuối gộp đủ cả Decorate lẫn Component Editor |

---

## S03 · 8 — Ghi chú về giới hạn checklist này

- **12/16 loại component chưa có bằng chứng ảnh** — chỉ Timetable, Year progress, Month grid, Mini month đã chụp (2026-09-24). Inspector, knob riêng, và hành vi resize của 12 loại còn lại **chưa biết chắc** — `CMP-E11` là điểm cần ưu tiên mở rộng coverage sớm.
- **Chưa có ảnh nào cho trạng thái đang kéo** (cả di chuyển lẫn cả container) — khác S02 vốn cũng thiếu tương tự (`DEC` coverage gap) nhưng ít nghiêm trọng hơn vì S02 đã verify được nhả tay đúng qua ảnh trước/sau; S03 rủi ro cao hơn vì test basis tự xếp đây là *"chỗ sửa đi sửa lại nhiều nhất"*.
- **`CMP-H38` (automation overnight) là case duy nhất không thể rút ngắn** — bắt buộc chờ thật, không đổi giờ hệ thống. Nên chạy **song song** với các phiên khác, không chờ làm xong hết mới bắt đầu.
- **`CMP-E07` (VoiceOver) cần người có kinh nghiệm dùng VoiceOver thật**, không phải người test tự bật rồi mò — giống lưu ý đã có ở `DEC-E07`.
- **Chưa có exploratory session nào chạy trước checklist này** — khác Phần 1 (Decorate) vốn đã qua ít nhất 1 vòng khám phá trước khi checklist hoá. Kết quả phiên đầu tiên trên S03 nên được đối chiếu kỹ với `CMP-Q` và test-plan mục 10 — nhiều khả năng phát sinh câu hỏi/case mới ngoài những gì liệt kê ở đây.
- **4 câu hỏi mở kế thừa từ test-plan** (`CMP-Q01`–`Q04`) nên hỏi dev **trước** khi coi kết quả `CMP-H27`/`N10` là pass/fail chính thức — nếu chưa có câu trả lời, chỉ ghi lại quan sát thực tế, không tự kết luận đúng/sai.
