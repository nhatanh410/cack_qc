# So sánh spec Component Editor — 1.2.17 (103) → 1.2.18 (111)

> **Bản cũ:** [QC — Component Editor 1.2-SUPERSEDED.md](QC%20—%20Component%20Editor%201.2-SUPERSEDED.md) (Sep 24, 2026)
> **Bản mới:** [QC — Component Editor 1.2.18.md](QC%20—%20Component%20Editor%201.2.18.md) (chép từ ảnh trang dev, 2026-09-28)
> **Ngày so sánh:** 2026-09-28 · So từng mục, từng dòng; mã `§N.M` là mã mục QC gán ở bản 1.2.18.

## Chú giải mức độ

| Ký hiệu | Nghĩa | Hệ quả cho bộ test |
|---|---|---|
| 🔴 **ĐẢO NGƯỢC / BỎ** | Hành vi cũ không còn đúng hoặc bị đảo | Test case cũ **sai** — phải sửa expected result, không chạy lại nguyên trạng |
| 🟠 **MỚI — quan trọng** | Hành vi/tính năng mới, rủi ro cao hoặc là trọng tâm của đợt này | Cần test condition + test case mới |
| 🟡 **MỚI — phụ / mở rộng** | Thêm chi tiết, knob, ghi chú; rủi ro thấp hơn | Bổ sung case P2/P3 |
| 🔵 **ĐỔI CÁCH DIỄN ĐẠT** | Cùng nội dung, chỉ tách/gộp/đổi chỗ/đổi câu chữ | Không cần case mới; cập nhật trace |
| ⚪ **GIỮ NGUYÊN** | Không đổi | Case cũ dùng lại được |

## 1. Tóm tắt nhanh

| | Số mục |
|---|---|
| 🔴 Đảo ngược / bỏ | **5** |
| 🟠 Mới — quan trọng | **11** |
| 🟡 Mới — phụ / mở rộng | **17** |
| 🔵 Đổi cách diễn đạt | 5 |
| ⚪ Giữ nguyên | ~40 mục tick + §1, §2, §11 |

**Ba thay đổi lớn nhất cần đọc trước:**

1. 🔴 **Giới hạn kéo dọc đã đổi bản chất**: từ "chặn ở vùng nội dung/vạch grid" sang "chặn ở **mép ảnh**", band đầu qua được vạch trên grid (§4.03, §4.04, §10 #10).
2. 🔴 **Hành vi "cố ý" #1 của bản cũ bị đảo ngược ở resize**: chữ **xuống dòng lại ngay lúc kéo góc** (§5.04) — bản cũ khẳng định chữ **không** xuống dòng lại lúc kéo.
3. 🟠 **Snap dọc + chip gap số âm + reorder ↑/↓** là hành vi hoàn toàn mới trong màn Di chuyển/Chọn (§3.07–§3.09, §4.05–§4.07).

---

## 2. Thông tin build & môi trường

| Mục | 1.2.17 | 1.2.18 | Mức |
|---|---|---|---|
| Build | TestFlight 1.2.17 (103) | **1.2.18 (111)**, tag `v1.2.18-rc3`, PR #226 · #325 · #326 | 🟠 **Cần xác nhận build 111 trước khi test** — rc1/rc2 không lên TestFlight |
| Cảnh báo build | — | rc1, rc2 lỗi build CI, không lên TestFlight | 🟠 |
| Bảng thiết bị (iOS 18.x ✅, 26.x ✅, iPad nếu có, iOS 27 ❌) | Có | Y hệt | ⚪ |
| Ngôn ngữ (VI + EN chính; 12 ngôn ngữ) | Có | Y hệt | ⚪ |
| Đường vào (§2) | Discover/Calendar → Edit → nút Components; chỉ template stack | Y hệt | ⚪ |
| Header ✕/Undo/Redo/✓, đáy +/Show grid, coach mark | Có | Y hệt | ⚪ |
| §0 "Điểm mới trong build này" | Không có | **Mới** — danh sách 7 điểm test trước | 🟡 (là mục lục thay đổi, không thêm hành vi mới ngoài các mục dưới) |

---

## 3. So sánh theo mục

### §3 Chọn thành phần (bản cũ: 6 mục → bản mới: 9 mục)

| Mã mới | Nội dung | Mức | Ghi chú |
|---|---|---|---|
| §3.01 | Chạm → khung viền + pill Edit/Delete | ⚪ | |
| §3.02 | Chạm vùng trống → bỏ chọn | ⚪ | |
| §3.03 | Đi sâu từng cấp trong Row/Column | ⚪ | |
| §3.04 | Khung viền ôm đúng, kể cả đã thu nhỏ | ⚪ | |
| §3.05 | Edit component → bảng thuộc tính | ⚪ | |
| §3.06 | Delete → toast "Removed…" + Undo | ⚪ | |
| **§3.07** | **Đổi thứ tự ↑/↓ (← → trong Row); mũi tên ẩn ở đầu/cuối; Fixed không có mũi tên & không tính là "kế bên"; mỗi lần bấm = 1 Undo** | 🟠 **MỚI** | Tính năng mới hoàn toàn. Có hành vi loại trừ (Fixed) dễ sai — cần Decision Table/State Transition |
| **§3.08** | **Đổi thứ tự không làm band đè lên band khác, kể cả khi band đầu gap âm; khoảng cách giữ nguyên** | 🟠 **MỚI** | Sửa lỗi thực (liệt kê ở §0). Tương tác với gap âm §4.05 |
| **§3.09** | **Duplicate band đầu đang gap âm → bản sao nằm dưới, không đè** | 🟠 **MỚI** | Sửa lỗi thực (§0). Tương tác với gap âm |

### §4 Di chuyển (kéo) (bản cũ: 6 mục → bản mới: 15 mục)

| Mã mới | Nội dung | Mức | Ghi chú |
|---|---|---|---|
| §4.01 | Đi theo ngón tay ngay lập tức | ⚪ | |
| §4.02 | Không đè lên thành phần phía trên | 🔵 | Bản cũ gộp thêm "không ra khỏi vùng nội dung (chặn trên + chặn dưới)" — phần đó bị thay bằng §4.03/§4.04 |
| **§4.03** | **Giới hạn kéo là mép ảnh, không phải vạch grid; kéo xuống quá vạch dưới grid tới mép dưới ảnh** | 🔴 **ĐẢO NGƯỢC** | Bản cũ: "có chặn trên và chặn dưới, không ra khỏi vùng nội dung". Case cũ kỳ vọng dừng ở vùng nội dung → **sai** |
| **§4.04** | **Band đầu kéo lên qua vạch trên grid tới mép trên ảnh (giống Studio); band khác dừng khi chạm band trên** | 🔴 **ĐẢO NGƯỢC** + 🟠 | Phân biệt band đầu / band khác — điểm biên mới, cần BVA |
| **§4.05** | **Chip gap hiện số âm (`-40`); tại gap 0 hiện `0`, không bao giờ `-0`** | 🟠 **MỚI** | Có giá trị biên cụ thể (0, âm, `-0`) — kỹ thuật BVA |
| **§4.06** | **Snap dọc + rung 1 lần: giữa màn / gap 0 / vạch dưới grid** | 🟠 **MỚI** | 3 điểm snap; cần kiểm cả đường gióng lẫn haptic (haptic: thử trên máy thật) |
| **§4.07** | **Band nằm sẵn trên điểm snap: chạm kéo không bị giữ lại** | 🟠 **MỚI** | Hành vi ngược trực giác dễ nhầm là lỗi |
| §4.08 | Kéo ngang trong phạm vi cho phép | ⚪ | |
| §4.09 | Kéo Row/Column: con đi theo đúng một lần | ⚪ | |
| §4.10 | Không bản sao, không mất thành phần | ⚪ | |
| §4.11 | Nhả tay → render 1 lần, không nhảy | ⚪ | |
| **§4.12** | **Trong lúc kéo vẽ lại thật; thành phần dưới dồn theo; thẻ nền Row/Column đi cùng con** | 🔴 **ĐẢO NGƯỢC** (đối chiếu "cố ý" #2 cũ) | ⚠️ **Xung đột với §10 #8 — xem Q-1** |
| **§4.13** | **Sticker/nét vẽ trang trí không biến mất khi kéo** | 🟠 **MỚI** | Sửa lỗi thực (bản cũ mất sticker) |
| §4.14 | Khung viền ôm đúng cả khi kéo nhanh | 🟡 **MỚI** | Mở rộng §3.04 sang trạng thái đang kéo |
| §4.15 | Kéo liên tục 5–10 giây, không giật; giật → báo model máy | 🟡 **MỚI** | Kiểm tra hiệu năng — cần thiết bị đa dạng |

### §5 Đổi bề rộng (kéo góc) (bản cũ: 7 mục → bản mới: 8 mục)

| Mã mới | Nội dung | Mức | Ghi chú |
|---|---|---|---|
| §5.01 – §5.03 | Kéo góc phải / trái / realtime | ⚪ | |
| **§5.04** | **Kéo hẹp thành phần có chữ: chữ xuống dòng lại + chiều cao đổi NGAY trong lúc kéo** | 🔴 **ĐẢO NGƯỢC** | Bản cũ ("Hành vi cố ý" #1): *"Trong lúc đang kéo, chữ … không xuống dòng lại và chiều cao không đổi … Nhả tay ra mới có một bước chỉnh lại"* → **ngược hoàn toàn**. TC-66 / INT-01 cũ sẽ báo sai |
| §5.05 | Nhả tay không nhảy, không đổi kích thước lần nữa | ⚪ | |
| §5.06 | Ngoài cùng: kéo góc, vẫn canh giữa | ⚪ | |
| §5.07 | Trong Row: kéo góc = kéo vách ngăn, tổng không đổi | ⚪ | |
| §5.08 | Không nhỏ hơn mức tối thiểu | ⚪ | Câu hỏi mở "mức tối thiểu cụ thể" từ bản cũ vẫn chưa có số |

### §6 Thêm thành phần (bản cũ: 4 mục → bản mới: 4 mục)

| Mã mới | Nội dung | Mức | Ghi chú |
|---|---|---|---|
| Danh sách nhóm sheet Add | Cũ: Calendar · Events · Tasks · Progress · **Text** · Layout (6 nhóm) → Mới: Calendar · Events · Tasks · Progress · Layout (**5 nhóm**, bỏ Text) | 🔴 **BỎ** | Case "đủ 6 nhóm" (TC-29 / ADD-01) **sai** |
| §6.01 | Quote/Almanac day/Timeline chỉ sửa được trên template có sẵn, **không thêm mới** | 🟠 **MỚI** | Là hệ quả của việc bỏ nhóm Text (cũng xuất hiện ở §7.22) |
| §6.01 – §6.04 | Thêm loại bất kỳ → toast + Undo; không full-width; rơi dưới cái đang chọn; rơi vào container đang chọn | ⚪ | |

### §6.1 Row / Column · §6.2 Giới hạn lồng nhau · §6.3 Container rỗng

| Nội dung | Mức | Ghi chú |
|---|---|---|
| §6.1.01 – §6.1.05 (2 ô trống Row/Column, + lấp đúng ô, chạm nền chọn container, lấp nốt ô 2) | ⚪ | Lỗi "ô số 2 biến mất" vẫn là mục regression đã fix |
| §6.1.05 / §6.1.06 (cũ gộp 1 mục "lấp nốt ô 2 … container đủ con không còn ô trống thừa" → mới tách 2 mục) | 🔵 | Nội dung không đổi |
| §6.2 (tối đa 3 cấp; Layout biến mất ở cấp 3; cấp 1–2 còn; sibling được) | ⚪ | |
| §6.3 (rỗng + ✓ → bỏ + toast "Removed the empty layout" + Undo) | ⚪ | |
| Cấu trúc heading: cũ gộp "Giới hạn lồng nhau và container rỗng" → mới tách §6.2 và §6.3; Row/Column từ heading riêng thành §6.1 | 🔵 | |

### §7 Bảng thuộc tính (Edit component) (bản cũ: 6 mục trong "Bảng thuộc tính, Undo và lưu" → bản mới: 22 mục)

| Mã mới | Nội dung | Mức | Ghi chú |
|---|---|---|---|
| §7.01 – §7.06 | Position Auto↔Fixed; Vertical position; Width; Size (chỉ ngoài cùng); knob riêng; Duplicate/Delete/Deselect | ⚪ | |
| **§7.07** | **Slider nhóm Position mượt, không khựng, kể cả kéo qua kéo lại tay hơi lệch dọc; nhả tay = 1 Undo** | 🟠 **MỚI** | Sửa lỗi thực (§0) — cần thao tác cụ thể (lệch dọc) để tái hiện |
| §7.08 | Kéo slider không cuộn bảng; vuốt dọc bắt đầu trên slider vẫn cuộn bảng | 🟠 **MỚI** | Xung đột cử chỉ — dễ hồi quy |
| **§7.09** | **Grabber: vuốt xuống đóng bảng (vẫn chọn); nút ✕ trong bảng = bỏ chọn + đóng bảng → nút + hiện lại** | 🟠 **MỚI** | Thêm 2 đường đóng bảng với trạng thái chọn khác nhau — State Transition |
| §7.10 | Bảng che thành phần → canvas tự đẩy lên; đóng thì về chỗ cũ | 🟠 **MỚI** | |
| §7.11 | Đáy bảng không hở (có/không có home indicator) | 🟡 **MỚI** | Kiểm trên nhiều dòng máy |
| §7.12 | Size: chữ chính tối đa 200, chữ phụ tối đa 60 | 🟡 **MỚI** | Có giá trị biên cụ thể — BVA |
| §7.13 | Bold + Italic bật cùng lúc → vừa đậm vừa nghiêng; 2 template có sẵn (month "elegant script", priority matrix) tiêu đề giờ đậm hơn | 🟡 **MỚI** | Cần baseline so sánh — xem Q-2 |
| §7.14 | Mục phụ đưa ra ngoài (không còn trong More options) với tiêu đề: Weekday / Time / Date / Caption | 🟡 **MỚI** | Thay đổi bố cục bảng — kiểm từng loại thành phần |
| §7.15 | Nút ↺ Reset màu → về mặc định (vd Priority matrix về 4 màu) | 🟡 **MỚI** | |
| §7.16 | Countdown: sửa chữ caption; xoá trống = ẩn; áp khi Done/ra ngoài ô (1 Undo) | 🟡 **MỚI** | |
| §7.17 | Priority matrix: màu chữ ghi chú/công việc/giờ riêng, Blur nền ô; bỏ "Layout" | 🟡 **MỚI** | |
| §7.18 | Month grid: màu ngày quá khứ/tương lai; căn phải tiêu đề tháng | 🟡 **MỚI** | |
| §7.19 | Hour timeline: Elapsed color | 🟡 **MỚI** | |
| §7.20 | Timetable: đổi cỡ chữ ngày & màu giờ | 🟡 **MỚI** | |
| §7.21 | Timeline: Blur nền thẻ có tác dụng; bỏ "Cards per day" | 🟡 **MỚI** | |
| §7.22 | Danh sách Add không còn Quote, Almanac day, Timeline | 🟠 **MỚI** (trùng ý §6) | |

### §8 Undo / Redo / Lưu (cũ: nằm trong mục "Bảng thuộc tính, Undo và lưu" → mới: mục riêng)

| Mã mới | Nội dung | Mức |
|---|---|---|
| §8.01 – §8.03 | Undo = 1 thao tác; Redo; ✓ Done giữ bố cục | ⚪ |
| §8.04 | ✕ Cancel bỏ mọi thay đổi trong phiên; bản mới thêm "wallpaper trở về đúng như lúc mở màn" | 🔵 (làm rõ, không đổi hành vi) |
| Vị trí mục | Tách khỏi "Bảng thuộc tính" | 🔵 |

### §9 Chrome phụ (cũ: nằm trong cùng mục → mới: mục riêng, 4 mục)

| Nội dung | Mức |
|---|---|
| §9.01 Show grid; §9.02 cảnh báo "Part of this runs off the screen"; §9.03 nút ẩn/hiện chrome; §9.04 xoay iPad | ⚪ (chỉ tách mục — 🔵) |

### §10 Hành vi cố ý — không cần report (cũ: 7 mục → mới: 13 mục)

| # bản mới | Nội dung | # bản cũ | Mức |
|---|---|---|---|
| — | *Chữ không xuống dòng lại + chiều cao không đổi lúc kéo* | **#1** | 🔴 **BỎ** (đảo ngược ở resize — §5.04; còn lại ở move là "chữ hơi mềm" #7 mới) |
| — | *Thẻ nền container không đổi theo từng frame khi kéo* | **#2** | 🔴 **ĐỔI** (thành §4.12 "đi cùng" + §10 #8 "tạm ẩn" — mâu thuẫn, Q-1) |
| #1 | Row/Column 1 con vẫn chiếm chỗ như 2 con | #3 | ⚪ |
| #2 | Con trong Row/Column không có thanh Size | #4 | ⚪ (đổi câu chữ nhẹ — 🔵) |
| #3 | Không vẽ vòng tròn ở 4 góc | #5 | ⚪ |
| #4 | Chạm 1 lần chỉ chọn container | #6 | ⚪ |
| #5 | Template không phải stack không có nút Components | #7 | ⚪ |
| **#6** | **Card kính mờ (frosted) có sticker phía dưới: editor chỉ làm mờ ảnh nền, không mờ sticker; chỉ report nếu sai trên lock screen thật** | — | 🟠 **MỚI** |
| **#7** | **Lúc kéo, chữ hơi mềm (vẽ 2/3 độ phân giải); nhả tay là nét lại** | — | 🟠 **MỚI** — thay thế một phần "cố ý" #1 cũ |
| **#8** | **Kéo con trong Row/Column có thẻ nền: thẻ nền tạm ẩn lúc kéo, hiện lại khi nhả** | — | 🟠 **MỚI** — ⚠️ mâu thuẫn §4.12 (Q-1) |
| #9 | Vừa nhả tay chạm kéo ngay: chờ ~0.1 giây mới bắt đầu | — | 🟡 **MỚI** |
| #10 | Band đầu nằm trên vạch trên grid là được phép (một số template có sẵn vốn đã cao hơn vạch) | — | 🟠 **MỚI** — đi cùng §4.04 |
| #11 | Band có card: thẻ nhô lên, viền có thể nằm trên vạch grid dù gap 0 | — | 🟡 **MỚI** |
| #12 | Số bên slider Position chỉ cập nhật khi nhả tay; lúc kéo xem bong bóng | — | 🟡 **MỚI** |
| #13 | Band Fixed không có ↑/↓, không bị tính "kế bên" | — | 🟡 **MỚI** (lặp ý §3.07) |
| Dòng giới thiệu "Bảy điểm dưới đây nhìn hệt lỗi…" | có | bỏ | 🔵 |

### §11 Regression · §13 Cách report

| Mục | Mức | Ghi chú |
|---|---|---|
| §11 (6 mục regression: màn khoá thật, Live Activity, widget/thumbnail, mở lại template, template cũ, wallpaper note) | ⚪ | Giữ nguyên nội dung, nhưng phạm vi thay đổi rộng hơn ở bản 1.2.18 (snap, gap âm, reorder, kéo tới mép ảnh) nên **rủi ro ghi sai dữ liệu wallpaper cao hơn** — nên chạy đầy đủ, không rút gọn |
| §13 Cách report | ⚪ | Bản cũ bị cắt cụt ở cuối câu ("…lỗi") — bản mới đầy đủ. |

### §12 Cần QC làm rõ (chưa sửa) — mới hoàn toàn

| Nội dung | Mức |
|---|---|
| Year progress "target date": trong code không có tuỳ chọn (Countdown thì có) → gửi ảnh chụp chỗ QC thấy mục này | 🟠 **MỚI — open question, đang chờ QC** |
| Quote "chữ / số dòng": chưa rõ lỗi cụ thể → mô tả bước làm/thấy/mong đợi | 🟠 **MỚI — open question, đang chờ QC** |

---

## 4. Danh sách điểm quan trọng (ưu tiên đọc)

### 🔴 Đảo ngược / bỏ — tài liệu test cũ sẽ **sai**

| # | Thay đổi | Bản cũ | Bản mới |
|---|---|---|---|
| R-1 | Giới hạn kéo dọc | Chặn trên/dưới trong vùng nội dung | Chặn ở **mép ảnh**; band đầu qua vạch trên grid (§4.03, §4.04, §10 #10) |
| R-2 | Chữ khi kéo góc | **Không** xuống dòng lại lúc kéo (cố ý) | **Xuống dòng lại + đổi chiều cao ngay lúc kéo** (§5.04) |
| R-3 | Thẻ nền container khi kéo | Không đổi theo từng frame (cố ý) | Đi cùng con (§4.12) **và** tạm ẩn (§10 #8) — mâu thuẫn |
| R-4 | Nhóm sheet Add | 6 nhóm gồm **Text** | 5 nhóm, **bỏ Text** (§6) |
| R-5 | Quote / Almanac day / Timeline | Thêm được qua nhóm Text | **Chỉ sửa được trên template có sẵn**, không thêm mới (§6, §7.22) |

### 🟠 Mới — quan trọng (cần test condition mới)

| # | Nội dung | Mục |
|---|---|---|
| N-1 | Đổi thứ tự ↑/↓ (← → trong Row), loại trừ Fixed, 1 Undo/lần bấm | §3.07 |
| N-2 | Đổi thứ tự / Duplicate không đè band với gap âm | §3.08, §3.09 |
| N-3 | Chip gap số âm; `0` không `-0` | §4.05 |
| N-4 | Snap dọc 3 điểm (giữa màn / gap 0 / vạch dưới grid) + rung + không "dính" khi đã ở điểm snap | §4.06, §4.07 |
| N-5 | Sticker không mất khi kéo | §4.13 |
| N-6 | Slider không khựng khi kéo qua kéo lại tay lệch dọc; không cuộn bảng khi kéo slider | §7.07, §7.08 |
| N-7 | Grabber vuốt xuống đóng bảng vs ✕ bỏ chọn + đóng bảng | §7.09 |
| N-8 | Canvas tự đẩy lên khi bảng che thành phần | §7.10 |
| N-9 | Frosted card + sticker (chỉ đúng khi lưu; sai trên lock screen thật mới report) | §10 #6 |
| N-10 | Chữ mềm khi kéo (2/3 độ phân giải), nét lại khi nhả | §10 #7 |
| N-11 | Hai open question §12 (Year progress target date; Quote chữ/số dòng) | §12 |

### 🟡 Mới — phụ (case P2/P3)

Kéo liên tục 5–10 giây (§4.15) · khung viền khi kéo nhanh (§4.14) · đáy bảng không hở (§7.11) · Size max 200/60 (§7.12) · Bold+Italic (§7.13) · mục phụ ra ngoài (§7.14) · Reset màu (§7.15) · caption Countdown (§7.16) · knob riêng Priority matrix / Month grid / Hour timeline / Timetable / Timeline (§7.17–§7.21) · chờ 0.1s sau khi nhả (§10 #9) · card nhô lên vạch grid (§10 #11) · số Position chỉ cập nhật khi nhả (§10 #12).

---

## 5. Ảnh hưởng tới tài liệu test đang có (`requirements/test-plans/component-editor/`)

Các dòng dưới **sai theo bản 1.2.18** (đã đối chiếu bằng tìm kiếm nội dung; nên rà lại toàn bộ khi chạy pipeline với slug `1.2.18`, không chỉ các dòng này):

| Tài liệu | Mục | Nội dung cũ | Vì sao sai |
|---|---|---|---|
| test-analysis | **TC-14** | "…có chặn trên và dưới đúng vùng nội dung" | R-1 |
| test-analysis | **TC-29** | "Sheet Add component hiện đủ **6 nhóm**… Text…" | R-4 |
| test-analysis | **TC-66** | "Trong lúc kéo, chữ **không xuống dòng lại**, chiều cao không đổi…" | R-2 |
| test-cases | **DRG-01** | "chặn đúng trên/dưới trong vùng nội dung" | R-1 |
| test-cases | **ADD-01** | "đủ 6 nhóm: …Text, Layout" | R-4 |
| test-cases | **INT-01** | "Chữ **không** xuống dòng lại, chiều cao **không đổi**…" | R-2 |

Các mục hoàn toàn mới (N-1…N-11) **chưa có** test condition/test case nào.

## 6. Điểm phải hỏi dev trước khi viết expected result (human-in-the-loop)

- **Q-1 (R-3):** §4.12 "thẻ nền Row/Column đi cùng với con" vs §10 #8 "thẻ nền tạm ẩn trong lúc kéo" — hai trường hợp khác nhau (kéo *container* vs kéo *con*) hay mâu thuẫn thật?
- **Q-2:** §7.13 "tiêu đề giờ đậm hơn trước" — cần baseline cụ thể để phân biệt với lỗi.
- **Q-3:** Mức tối thiểu bề rộng (§5.08) và ranh giới "cấp 3" (§6.2) — vẫn chưa có số cụ thể (câu hỏi mở từ bản cũ).
- **Q-4:** Hai open question §12 đang chờ QC (Year progress, Quote).
- **Q-5:** Trang gốc `0 / 83` tick, bản chép có 82 — cần đối chiếu để chắc không thiếu mục.
