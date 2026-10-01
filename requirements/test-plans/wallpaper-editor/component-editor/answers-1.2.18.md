# Trả lời câu hỏi làm rõ — Component Editor 1.2.18 (111)

> **Nguồn trả lời:** QC (người dùng repo) trả lời trực tiếp ngày 2026-09-28 qua hộp thoại chọn đáp án — **chưa có xác nhận từ dev**. Coi là *câu trả lời của QC*, không phải fact từ spec; nếu dev trả lời khác thì dev thắng.
> **Liên quan:** [test-analysis-1.2.18.md](test-analysis-1.2.18.md) §4 (Câu hỏi CHẶN / MỞ). Mã Q-x trùng với file đó.
> **Trạng thái test-analysis (cập nhật 2026-09-28): `READY` CÓ ĐIỀU KIỆN**, do QC (người) duyệt phương án "A. Cho phép chạy Test Plan ngay". Q-7/Q-10/Q-12 vẫn là **ASSUMPTION chưa dev xác nhận**; Q-4 vẫn mở, TC18-99/100 descope. Chi tiết: test-analysis-1.2.18.md §5.1.

## Đã trả lời

| Q | Câu hỏi (rút gọn) | Trả lời | Ghi chú |
|---|---|---|---|
| **Q-1** [CHẶN] | §4.12 "thẻ nền đi cùng con" vs §10 #8 "thẻ nền tạm ẩn" | **A — hai trường hợp khác nhau**: kéo cả container → thẻ đi cùng; kéo 1 con bên trong → thẻ tạm ẩn, hiện lại khi nhả tay | Tách TC18-36 thành 2 condition (kéo container / kéo con) |
| **Q-8** [CHẶN] | Kéo sát mép ảnh (vẫn trong ảnh) có bật cảnh báo "Part of this runs off the screen"? | *Free text:* "Cảnh báo khi user kéo band ra khỏi cạnh screen" | Suy ra: cảnh báo chỉ khi tràn ra ngoài, không phải khi sát mép. ⚠️ Còn lẫn từ "screen" vs "ảnh" — chưa nói rõ "cạnh screen" và "mép ảnh" có trùng nhau không; nên ghi lại là giả định |
| **Q-6a** [CHẶN] | Haptic snap tính thế nào | **A — 1 lần mỗi điểm snap** | |
| **Q-6b** [CHẶN] | 2 điểm snap rất gần nhau | **A — hút điểm gần hơn, rung 1 lần** | |
| **Q-9a** [CHẶN] | Fixed nằm giữa 2 band Auto, bấm ↓ | **A — nhảy qua band Fixed**, đổi chỗ với band Auto kế tiếp | |
| **Q-9b** [CHẶN] | Band Auto cuối có tính là "cuối" khi Fixed nằm sau nó | **A — có, ẩn ↓** (band Fixed không tính vào danh sách xác định đầu/cuối) | |
| **Q-2** [CHẶN] | §7.13 "tiêu đề giờ đậm hơn" | **A — đúng, không report** | Chưa chỉ rõ phần tử nào đậm hơn; vẫn nên đối chiếu ảnh khi chạy |
| **Q-17** [MỞ] | 3 đường bỏ chọn (✕ / Deselect / chạm vùng trống) | **A — cùng kết quả cuối** (bảng đóng, khung viền mất, nút + hiện lại) | |
| **Q-11** [MỞ] | 3 hành vi từ trao đổi miệng 2026-09-24 | **a, b, c đều còn đúng ở 1.2.18**: (a) bấm + khi không chọn gì → chèn giữa canvas; (b) Editor + Decorate gộp đủ hai phần khi lưu; (c) bố cục sống sót qua automation overnight | Nên đề nghị dev đưa vào tài liệu bàn giao chính thức (hiện vẫn không có trong spec 1.2.18) |

## Chưa rõ — giữ nguyên là câu hỏi mở, chờ dev

| Q | Loại | Câu hỏi | Ghi chú |
|---|---|---|---|
| **Q-7** | **CHẶN** | Bắt đầu chạm trên slider rồi kéo chéo → slider chạy hay bảng cuộn | §7.07 ↔ §7.08 vẫn mâu thuẫn |
| **Q-10** | **CHẶN** | Đổi chỗ 2 band cao thấp khác nhau: giữ gap hay giữ đỉnh "ô" | Là điều kiện "không đè band" vừa fix |
| **Q-12** | **CHẶN** | Band đầu snap gap 0 tại mốc nào (mép trên vùng nội dung / vạch trên grid / mép trên ảnh) | Không có mốc thì không kiểm được snap gap 0 |
| Q-3b | MỞ | "Tối đa 3 cấp" đếm từ đâu | |
| Q-13 | MỞ | Row 3+ con: bù trừ thế nào khi kéo góc | |
| Q-18 | MỞ | Card kính mờ + sticker trên wallpaper đã lưu: "đúng" nghĩa là gì | |

## Đã cố ý bỏ (giá trị xử lý bên dưới, không cần trả lời)

Q-3a (bề rộng tối thiểu) · Q-14 (lề "giống Studio") · Q-15 (tiêu chí fps) · Q-16 (biên dưới/đơn vị Size) · đơn vị chip gap (phần của Q-12) · ngưỡng góc/thời gian (phần của Q-7). Condition liên quan ghi "không có ngưỡng — kiểm hành vi, không kiểm giá trị".

## Việc QC tự xử lý (chưa làm)

- **Q-4 [CHẶN]:** gửi ảnh chụp chỗ thấy "target date" ở Year progress; mô tả bước / thấy gì / mong đợi gì cho Quote "chữ / số dòng".
- **Q-5:** đối chiếu trang gốc `0 / 83` với bản chép 82 mục.
- **Q-19:** chụp lại screenshot baseline trên build 111.
- **Q-20:** xác nhận đợt này có máy iPad không.

## ASSUMPTION — giả định làm việc do QC chấp nhận (2026-09-28)

> **Không phải fact, không phải xác nhận của dev.** Đây là đề xuất của Claude (tối ưu trải nghiệm người dùng) được QC **chấp nhận làm giả định làm việc** để tiếp tục pipeline. Mọi test condition/case dựa trên các giả định này phải gắn ⚠️ (gap-dependent). **Nếu dev trả lời khác, chỉ các condition gắn ⚠️ tương ứng phải sửa.** Khi dev xác nhận thì đổi nhãn từ ASSUMPTION sang FACT ở đây.

| Q | Giả định (expected làm việc) | Điều kiện thay đổi |
|---|---|---|
| **Q-7** | Khoá hướng cử chỉ một lần từ đầu, giữ tới khi nhả tay. Bắt đầu trên slider: thiên về ngang → slider chạy (lệch dọc nhẹ vẫn mượt, khớp §7.07); gần thẳng dọc → bảng cuộn (khớp §7.08). Đã khoá thì không đổi giữa chừng (slider chạy thì bảng không cuộn; bảng cuộn thì giá trị slider không đổi). Không ghi ngưỡng góc — kiểm hành vi, không kiểm giá trị. | Dev nêu quy tắc khác |
| **Q-10** | Giữ nguyên **gap của từng vị trí**: hai band đổi chỗ, khoảng trống giữa các band như cũ, tổng chiều cao stack không đổi, không band nào đè band khác. Band đầu đang gap âm: gap âm ở lại **vị trí đầu**, không đi theo band. | Dev nói giữ đỉnh "ô" |
| **Q-12** | Mốc gap = 0 của band đầu = **vạch trên của grid** (căn cứ suy luận từ §4.05 "kéo band đầu lên quá vạch thì hiện số âm"). Template có sẵn nằm cao hơn vạch (§10 #10) mở ra chip hiện số âm là đúng. Kiểm: Show grid bật, kéo band đầu sát vạch → chip `0` (không `-0`), rung 1 lần; qua vạch → số âm. | Dev nêu mốc khác (mép trên vùng nội dung / mép trên ảnh) |
| **Q-4** | **Year progress:** không có tuỳ chọn "target date" (đúng như code; Countdown mới có). **Quote:** (a) ô *Lines* phải có tác dụng — Lines lớn hơn số dòng thật thì không thừa khoảng trống, nhỏ hơn thì quote bị cắt đúng số dòng; (b) sửa nội dung chữ quote trong màn này **không** phải requirement, ghi là câu hỏi sản phẩm. **Phần "chờ ảnh chụp/mô tả của QC" vẫn mở** — TC18-99/TC18-100 giữ GAP, không đưa vào phạm vi thực thi cho tới khi QC gửi bằng chứng và dev chốt. | QC gửi ảnh/mô tả; dev chốt |

## Q-21: danh sách component / sheet Add — ✅ ĐÃ ĐÓNG (QC rút lại nhận định; spec 1.2.18 đúng)

- **QC nói (2026-09-28):** "tổng loại và sheet Add vẫn giữ nguyên như bản cũ" — tức 19 mục như ảnh 1.2.17: Calendar 5 · Events 5 (gồm Timeline) · Tasks 2 · Progress 3 · **Text 2 (Quote, Almanac day)** · Layout 2 (Row, Column).
- **Spec 1.2.18 (do dev bàn giao) nói ngược lại:** §6 "nhóm *Text* đã bỏ: Quote, Almanac day và Timeline chỉ sửa được trên template có sẵn, không thêm mới"; §7.22 "Danh sách Add không còn Quote, Almanac day, Timeline". Hai điểm này trước đó được ghi là 🔴 (bỏ) trong bản so sánh 1.2.17 → 1.2.18.
- **Không phải suy diễn của Claude:** cả hai phía đều là câu chữ trực tiếp. Chưa có ảnh sheet Add trên build 111 làm bằng chứng.
- **Xử lý:** giữ nguyên spec (test basis) — **không sửa spec theo lời QC**. Ghi là mâu thuẫn `[CHẶN]` cho các condition về sheet Add (TC18-54, TC18-55, TC18-58 và các condition liên quan Quote/Almanac day/Timeline). Cách rẻ nhất để chốt: QC chụp sheet Add (cả hai đoạn cuộn) trên **build 111** và dev xác nhận; ảnh + dev thắng cả spec lẫn lời QC.
- **Đã nằm sẵn trong spec, không đổi:** tổng số loại component (khoảng 19, gồm cả các loại chỉ có trên template có sẵn) — hai phía không mâu thuẫn ở điểm này; chỉ mâu thuẫn ở việc *thêm mới được hay không* qua sheet Add.

### Cập nhật Q-21 — ảnh sheet "Add component" QC gửi (2026-09-28, 15:30; 2 ảnh: đầu sheet + cuộn xuống)

> 📁 **Đã lưu vào repo (2026-09-28):** `requirements/ui/ux/screenshots/iphone/14_edit-wallpaper/14_edit-wallpaper_03_component-editor_add-component-v2.png` và `…_add-component-scrolled-v2.png` — ghi trong `iphone/index.md` batch 6. Số build vẫn chưa xác nhận (Q-19).

Nội dung sheet **thấy trên ảnh: 16 mục, 5 nhóm, KHÔNG có nhóm Text**:

| Nhóm | Mục (đúng thứ tự trên ảnh) | Số mục |
|---|---|---|
| CALENDAR | Month grid · Mini month · Lunar calendar · Timetable · Week schedule | 5 |
| EVENTS | Today's events · Hour timeline · Week events · Activity grid | 4 |
| TASKS | Reminders · Priority matrix | 2 |
| PROGRESS | Year progress · Month progress · Countdown | 3 |
| LAYOUT | Row · Column | 2 |

- **QC xác nhận (2026-09-28): "tôi nhầm, theo tài liệu mới chuẩn"** → Q-21 đóng, dùng spec 1.2.18 làm nguồn cho sheet Add (16 mục, 5 nhóm, không có Text/Timeline).
- **Kết luận:** ảnh **khớp spec 1.2.18** (§6, §7.22): nhóm Text bỏ, Quote / Almanac day không có, **Timeline không còn trong EVENTS** (bản 1.2.17 có 5 mục ở EVENTS). Ảnh **không ủng hộ** nhận định "sheet Add giữ nguyên 19 mục như bản cũ". Bản so sánh mục D-6 và §6 spec **giữ nguyên, không cần sửa**.
- **Lưu ý còn lại (không chặn):** ảnh **không hiện số build** — vẫn nên chụp lại kèm số build 111 khi làm Q-19 (screenshot baseline).
- **Xác nhận từ ảnh (thay cho suy luận trước đó):** mô tả một dòng dưới từng mục là chuỗi UI thực tế, dùng làm oracle cho TC18-54/55/58 sau khi build được xác nhận. Tên hiển thị "Timetable" (không phải "Week timetable") và "Activity grid", "Reminders" là tên thật trên UI.
- **Vẫn là suy luận, chưa có nguồn:** ánh xạ tên UI → tên code (Activity grid = `contributionGrid`, Reminders = `reminderList`).

## Không còn chặn Test Plan (READY có điều kiện) — nhưng còn chờ xác nhận

Sau đợt trả lời này, 4 câu sau vẫn **chưa được dev/QC giải quyết** (trước đây xếp là CHẶN; ngày 2026-09-28 QC duyệt tiếp tục với giả định, xem test-analysis §5.1): **Q-7, Q-10, Q-12** (chờ dev), **Q-4** (chờ QC) (Q-21 đã đóng.) Ngày 2026-09-28 QC **chấp nhận 4 giả định ở mục ASSUMPTION** làm cơ sở làm việc. Việc chuyển trạng thái test-analysis vẫn do `qc-test-analysis` đánh giá và báo lại; chưa ai tự nâng BLOCKED → READY.
