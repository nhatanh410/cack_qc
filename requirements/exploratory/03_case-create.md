# Exploratory Checklist — 03 Case Create (Tạo vụ việc xử lý vi phạm)

> ⚠️ **Lập trước khi có [đặc tả v2.1](../specs/xu-ly-vi-pham-giao-viec/dac-ta-chuc-nang-v2.1.md)** (đưa vào repo 2026-10-26). Đặc tả đã trả lời nhiều điểm đang để `❓` (bước bắt buộc, giao Đội/cán bộ, trạng thái ban đầu, hạn quá khứ, lưu ảnh giấy tờ, nút "Xử lý tại chỗ"…) và định nghĩa lại "uỷ quyền Tổ phó". **Cần đối chiếu lại trước khi dùng.**

> Nguồn: [wireframe](../ui/ux/wideframes/03_case-create.md) · 14 screenshot flow 03 (+ 1 ảnh `02_home`, 1 ảnh `04_case-handling`)
> Khung đánh giá: ⚠️ dự án CACK **chưa có** `references/exploratory-references.md` — dùng tạm khung Q1–Q9 + mẫu
> kết luận của dự án cũ (`git show 3ada18a:references/exploratory-references.md`) (§2, §5); phần "rủi ro xuyên suốt" chưa có.
> Test basis đối chiếu: [mo-ta-chuc-nang-v1.md](../specs/xu-ly-vi-pham-giao-viec/mo-ta-chuc-nang-v1.md) ·
> [lam-ro-2026-10-26.md](../specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-26.md) ·
> test-analysis-mo-ta-v1-SUPERSEDED.md (đã xoá 2026-10-28, xem git `5fc75a6`) (mã `T`/`B`/`O`; đang **BLOCKED**)
> Kỹ thuật (ISTQB §4.4): Checklist-based (§1, phần lớn §2) · Error guessing (§2, §3) · Exploratory
> session-based (§6, §7)
> Build: 1.0.0 (52) — ❓ môi trường (TestFlight / dev) chưa ghi nhận · Tài khoản test: Đội trưởng / Chỉ huy Đội
> (+ 1 tài khoản Cán bộ, 1 Tổ phó chưa uỷ quyền cho §2 nhóm quyền) · Thiết bị: iPhone, ❓ model/iOS
> Ngày lập: 2026-10-26

**Chuẩn bị (entry criteria — không đánh ID):**
- 3 tài khoản test cùng 1 Đội: người giao việc (Đội trưởng), 2 Cán bộ; thêm 1 Cán bộ ở Đội khác nếu có; 1 Tổ phó
  chưa uỷ quyền nếu tạo được.
- 2 iPhone (hoặc 1 iPhone + đổi tài khoản) để kiểm phía người nhận.
- **Giấy tờ mẫu giả** (CCCD, hộ chiếu nước ngoài) — **không dùng giấy tờ thật** (O19). Ảnh giấy tờ mẫu có sẵn trong Ảnh.
- Ghi lại mã `VV…` của mọi vụ việc tạo ra để đối chiếu và dọn dữ liệu sau phiên.

**Quy ước cột Kỳ vọng:** chữ thường = có bằng chứng (spec / ảnh / làm rõ) · `❓ <mã>` = chưa có căn cứ, chỉ **ghi lại
hành vi quan sát được**, không kết luận pass/fail cho tới khi câu hỏi được trả lời.

---

## 0 · Framing

**Q1 — Mục tiêu user của flow này:** người giao việc ghi nhận một vụ việc vi phạm ngay tại hiện trường và giao
cho đúng cán bộ, đủ thông tin để họ xử lý mà không phải hỏi lại.

**Q8 — Mục tiêu business:** "không bị thiếu thông tin trong quá trình giao nhận và làm việc", "ít giấy tờ", quản lý
nhiều việc cùng lúc (spec, mục đích tổng quan). Dữ liệu đối tượng nhập ở đây được **tự điền lại vào biên bản**
(flow `05_record-signing`) → sai ở đây lan sang văn bản có chữ ký.

**Rủi ro xuyên suốt chạm vào flow này** (chưa có file references riêng — ghi tạm, cần QC lead duyệt):
quyền theo vai trò · dữ liệu cá nhân (CCCD/hộ chiếu) · giao đúng người / đúng đơn vị · hạn hoàn thành (ảnh hưởng
"Quá hạn" ở Trang chủ và Gia hạn ở flow 07).

---

## 1 · Happy path — CRE-H  *(Checklist-based testing, §4.4.3)*

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|---|
| CRE-H01 | Đăng nhập Đội trưởng, ở Trang chủ bấm FAB "+" | Sheet "Tạo vụ việc" mở ở "Bước 1/9 · Hình ảnh / bằng chứng" (S00 → S01) | Số lần chạm từ Trang chủ tới Bước 1 | ☐ |
| CRE-H02 | Bước 1 không thêm ảnh, bấm "Tiếp tục" | Sang "Bước 2/9"; dòng "Chưa có hình ảnh…" đã hiện trước đó (S01) — spec: bước 1 không bắt buộc | Nút bật/tắt | ☐ |
| CRE-H03 | Bước 1 thêm 1 ảnh bằng "Chụp ảnh" và 1 ảnh bằng "Thư viện" | Cả 2 ảnh hiện trong bước 1; ở Bước 9 "Bằng chứng: 2 tệp" | Đếm ảnh ở bước 1 = số ở Bước 9 | ☐ |
| CRE-H04 | Bước 2 chọn một khu vực **không phải** mục đầu ("Sân đỗ tàu bay") | Chỉ mục vừa chọn có ✔, mục đầu bỏ ✔ (S02) | Số mục có ✔ = 1 | ☐ |
| CRE-H05 | Bước 3 chọn "Gây rối trật tự" | "Tiếp tục" từ mờ → bật (S03) | Trạng thái nút trước/sau | ☐ |
| CRE-H06 | Bước 4 chọn "Nghiêm trọng" | "Tiếp tục" từ mờ → bật (S04) | Trạng thái nút | ☐ |
| CRE-H07 | Bước 5 nhập Mô tả "Khách gây rối tại cửa 5"; để trống 2 ô tuỳ chọn | "Tiếp tục" bật; xoá hết Mô tả → mờ lại (L3a-b, S05) | Trạng thái nút theo nội dung Mô tả | ☐ |
| CRE-H08 | Bước 6 "Quét giấy tờ" với **CCCD mẫu** | Quay về Bước 6, "Đã nhập 1 đối tượng"; Họ tên, Ngày sinh, Giới tính, Quốc tịch, Số CCCD/CMND tự điền (S06 `_filled`) | Đối chiếu **từng trường** với giấy tờ mẫu: số trường đúng / 5 | ☐ |
| CRE-H09 | Bước 6 "Từ thư viện" chọn ảnh CCCD mẫu | Thêm "Đối tượng 2" với các trường tự điền (spec bước 6.2 — **chưa có ảnh minh hoạ**) | Như H08 | ☐ |
| CRE-H10 | Bước 6 "Thêm đối tượng thủ công" | Thêm thẻ "Đối tượng N" với Họ tên, Ngày sinh, Giới tính (Nam/Nữ/Khác), Quốc tịch, Số CCCD/CMND, Số hộ chiếu (S06 `_filled-v2`) | Đủ 6 trường | ☐ |
| CRE-H11 | Có 3 đối tượng, bấm 🗑 ở "Đối tượng 2" | Còn 2 thẻ; dòng đếm "Đã nhập 2 đối tượng"; đánh số lại hay giữ số? (ghi lại) | Số đếm = số thẻ | ☐ |
| CRE-H12 | Bước 7 chọn "Nhắc nhở, khuyến cáo" + "Bàn giao" | Cả 2 checkbox giữ dấu chọn (S08) | Số ô được chọn = 2 | ☐ |
| CRE-H13 | Bước 8 chọn 1 cán bộ trong danh sách | Hiện chip "<email> · <Đội> ✕"; người đó biến khỏi danh sách; nhãn đổi thành "Thêm cán bộ nhận việc"; "Tiếp tục" bật (S09) | Trạng thái nút, số dòng danh sách giảm 1 | ☐ |
| CRE-H14 | Bước 8 chọn thêm cán bộ thứ 2 | 2 chip; danh sách còn lại giảm tiếp | Số chip = 2 | ☐ |
| CRE-H15 | Bước 8 gõ một phần email vào "Tìm theo email..." | Danh sách chỉ còn người khớp | Số kết quả, có phân biệt hoa/thường không (ghi lại) | ☐ |
| CRE-H16 | Sang Bước 9 | "Xem lại & gửi" hiện đúng Loại vụ việc, Mô tả, số Bằng chứng, danh sách Giao việc vừa nhập (S10) | Đối chiếu từng dòng | ☐ |
| CRE-H17 | Bước 9 chọn ngày mai, 09:00 | Nút hiện "dd/mm/yyyy" và "09:00"; "Giao việc & gửi" từ mờ → bật (S10 `_filled`) | Trạng thái nút | ☐ |
| CRE-H18 | Bấm "Giao việc & gửi" | Có phản hồi thành công; vụ việc mới xuất hiện ở tab **Tiếp nhận** với mã "VV" + 6 số, đúng loại, khu vực, mô tả, mức độ, giờ tạo (spec "→ Kết quả"; ảnh R) | Bấm giờ từ lúc gửi tới khi thấy thẻ; ghi mã VV | ☐ |
| CRE-H19 | Mở chi tiết vụ việc vừa tạo | Đủ **toàn bộ** dữ liệu 9 bước: bằng chứng, khu vực, loại, mức độ, mô tả + 2 ô tuỳ chọn, các đối tượng, đề xuất, cán bộ, hạn | Số trường khớp / tổng số trường đã nhập | ☐ |
| CRE-H20 | Đăng nhập tài khoản Cán bộ được giao (máy 2) | Vụ việc có ở tab "Của tôi" và/hoặc "Thông báo" (spec mục "Giao diện" 2) | Thời gian từ lúc gửi tới khi máy 2 thấy | ☐ |
| CRE-H21 | Tạo vụ việc giao 2 cán bộ | Thẻ ở tab Tiếp nhận có "+N cán bộ" (ảnh R); cả 2 cán bộ đều thấy vụ việc | N hiển thị đúng; số người thấy = 2 | ☐ |
| CRE-H22 | Ở Trang chủ trước và sau khi tạo 1 vụ việc "Khẩn cấp" | Ô "Tổng vụ việc" +1, "Khẩn cấp mở" +1 (S00) | Chênh lệch số liệu | ☐ |

---

## 2 · Negative — CRE-N  *(Checklist-based cho vấn đề đã biết + Error guessing cho phần suy luận)*

**Sai vai trò / quyền**

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|---|---|
| CRE-N01 | Đăng nhập tài khoản **Cán bộ**, tìm FAB "+" ở Trang chủ | ❓ B1 — ghi lại: có nút không, bấm được không, gửi được không | Cán bộ tự tạo và giao việc cho người khác | 🔴 | ☐ |
| CRE-N02 | Đăng nhập **Tổ phó chưa được uỷ quyền** | ❓ B1 — ghi lại như N01 | Sai quyền | 🔴 | ☐ |
| CRE-N03 | Bước 8 kiểm danh sách người nhận: có Cán bộ ở **Đội khác** không, có chính người tạo không, có lãnh đạo (Tổ phó…) không | ❓ B3 — ghi lại danh sách | Giao nhầm đơn vị | 🔴 | ☐ |

**Bỏ trống / nhập sai**

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|---|---|
| CRE-N04 | 🔴 Bước 6 không thêm đối tượng nào, bấm "Tiếp tục" ([V1](../ui/ux/wideframes/03_case-create.md#vấn-đề-đã-nhận-diện)) | ❓ B2 — ảnh cho đi tiếp, spec ngụ ý bắt buộc. Ghi lại và gửi được vụ việc 0 đối tượng không | Vụ việc thiếu đối tượng → biên bản flow 05 không tự điền được | 🔴 | ☐ |
| CRE-N05 | 🔴 Bước 7 không chọn phương án nào, bấm "Tiếp tục" (V1) | ❓ B2 — ảnh ghi "Tuỳ chọn" | Thiếu đề xuất xử lý | 🟠 | ☐ |
| CRE-N06 | Bước 5 Mô tả chỉ gồm dấu cách / xuống dòng | Không đi tiếp được (Mô tả bắt buộc, L3a-b) — ❓ O3 khoảng trắng có tính là rỗng | Vụ việc không có mô tả | 🔴 | ☐ |
| CRE-N07 | Bước 3 chọn "Khác (tự nhập loại vụ việc)" rồi để trống | ❓ O6 — ghi lại nút Tiếp tục | Vụ việc không có loại | 🟠 | ☐ |
| CRE-N08 | Bước 8 bấm ✕ trên chip đến khi hết cán bộ | "Tiếp tục" mờ lại; người bị bỏ quay lại danh sách (S09 `_default`) | Gửi vụ việc không người nhận | 🔴 | ☐ |
| CRE-N09 | Bước 9 chỉ chọn ngày, không chọn giờ (và ngược lại) | ❓ O1 — ghi lại trạng thái "Giao việc & gửi" | Hạn không đầy đủ | 🟠 | ☐ |
| CRE-N10 | Bước 9 chọn hạn ở **quá khứ** (hôm qua; hôm nay giờ đã qua) | ❓ O1 — ghi lại: có chặn không; nếu gửi được thì vụ việc có vào "Quá hạn" ngay không | Vụ việc quá hạn từ lúc tạo | 🔴 | ☐ |
| CRE-N11 | Thêm đối tượng quốc tịch nước ngoài, nhập số hộ chiếu vào ô "Số CCCD/CMND" ([V7](../ui/ux/wideframes/03_case-create.md#vấn-đề-đã-nhận-diện)) | ❓ O8 — ảnh cho thấy không bị chặn | Sai loại giấy tờ trên biên bản | 🟠 | ☐ |
| CRE-N12 | Nhập Ngày sinh sai định dạng / ở tương lai / chữ cái | ❓ O8 — ghi lại | Dữ liệu đối tượng sai | 🟠 | ☐ |
| CRE-N13 | Thêm đối tượng thủ công nhưng để trống tất cả các trường, đi tiếp | ❓ O8 — ghi lại: đối tượng rỗng có được lưu không | Đối tượng "ma" trong vụ việc | 🟠 | ☐ |
| CRE-N14 | Bước 8 tìm email không tồn tại | ❓ O13 — ghi lại empty state | Người dùng tưởng danh sách lỗi | 🟡 | ☐ |

**Quyền hệ thống / quét giấy tờ**

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|---|---|
| CRE-N15 | Từ chối quyền **Camera** khi bấm "Chụp ảnh" (bước 1) và "Quét giấy tờ" (bước 6) | ❓ O17 — ghi lại: thông báo, có dẫn ra Cài đặt không, wizard có bị kẹt không | Không ghi được bằng chứng/đối tượng tại hiện trường | 🟠 | ☐ |
| CRE-N16 | Từ chối quyền **Ảnh** khi bấm "Thư viện" / "Từ thư viện" | ❓ O17 — như N15 | Như N15 | 🟠 | ☐ |
| CRE-N17 | Quét: ảnh mờ, thiếu sáng, chụp nghiêng, ảnh không phải giấy tờ | ❓ O7 — ghi lại: báo lỗi hay điền **sai im lặng** | Dữ liệu đối tượng sai mà không ai biết | 🔴 | ☐ |
| CRE-N18 | Quét CCCD mẫu rồi **sửa** Họ tên tự điền, gửi vụ việc | ❓ O7 — ghi lại giá trị lưu là giá trị sửa hay giá trị quét | Biên bản dùng sai tên | 🔴 | ☐ |
| CRE-N19 | Quét **hộ chiếu** mẫu | ❓ O7 — ghi lại trường nào được điền, có vào ô "Số hộ chiếu" không | Giấy tờ phổ biến nhất ở sân bay không dùng được | 🔴 | ☐ |

**Gián đoạn / thao tác lặp**

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|---|---|
| CRE-N20 | Bật chế độ máy bay rồi bấm "Giao việc & gửi" | ❓ O16 — có báo lỗi, giữ nguyên dữ liệu, không tạo vụ việc nửa vời | Mất toàn bộ 9 bước vừa nhập | 🔴 | ☐ |
| CRE-N21 | Bấm "Giao việc & gửi" 2–3 lần thật nhanh | Chỉ **1** vụ việc mới (spec: "tạo thành công **1** vụ việc") | Vụ việc trùng, cán bộ nhận 2 lần | 🔴 | ☐ |
| CRE-N22 | Vuốt xuống đóng sheet ở bước 6 ([V10](../ui/ux/wideframes/03_case-create.md#vấn-đề-đã-nhận-diện)) | ❓ O4 — ghi lại: đóng được không, có hỏi xác nhận không, mở lại còn dữ liệu không | Mất dữ liệu đã nhập | 🟠 | ☐ |
| CRE-N23 | Kill app ở bước 8, mở lại | ❓ O4 — ghi lại | Như N22 | 🟠 | ☐ |
| CRE-N24 | Từ Bước 9 bấm "Quay lại" về Bước 2, đổi khu vực, đi tiếp tới gửi | Vụ việc lưu **khu vực mới**; các bước khác giữ nguyên (❓ O4 việc giữ dữ liệu) | Lưu giá trị cũ | 🟠 | ☐ |
| CRE-N25 | Đối chiếu đơn vị hiển thị trên thẻ vụ việc vừa tạo với Đội đã chọn ở bước 8 ([V3](../ui/ux/wideframes/03_case-create.md#vấn-đề-đã-nhận-diện)) | ❓ B3/B4 — ghi lại tên Tổ/Đội trên thẻ và mã VV | Vụ việc gán sai đơn vị | 🟠 | ☐ |

---

## 3 · Edge — CRE-E  *(Error guessing, §4.4.1)*

| ID | Tình huống | Câu hỏi | Mức | ☐ |
|---|---|---|---|---|
| CRE-E01 | Mô tả ~2.000 ký tự, tiếng Việt có dấu, emoji, xuống dòng | Lưu đủ không? Thẻ ở tab Tiếp nhận cắt gọn thế nào? Có giới hạn (O3)? | 🟠 | ☐ |
| CRE-E02 | Họ tên đối tượng nước ngoài rất dài / có dấu tiếng Việt | Hiển thị và lưu nguyên vẹn? | 🟡 | ☐ |
| CRE-E03 | Thêm 15–20 ảnh bằng chứng | Có giới hạn không (O2)? Bước 9 đếm đúng? Gửi có chậm/lỗi? | 🟠 | ☐ |
| CRE-E04 | 10 đối tượng trong 1 vụ việc | Cuộn được không, đếm đúng, nút dưới còn bấm được? | 🟡 | ☐ |
| CRE-E05 | "Số lượng đối tượng" = 4 nhưng chỉ nhập 1 đối tượng (và ngược lại) | Có cảnh báo không, lưu số nào (O9)? | 🟡 | ☐ |
| CRE-E06 | Hạn = đúng giờ hiện tại, và hiện tại + 1 phút (BVA) | Giá trị biên nào bị chặn (O1)? | 🟠 | ☐ |
| CRE-E07 | Đặt múi giờ iPhone sang Tokyo (+2 giờ so với VN), chọn hạn 17:00 | Lưu và hiển thị theo "giờ Việt Nam" đúng không (S10)? | 🟠 | ☐ |
| CRE-E08 | Tạo vụ việc lúc 23:58, gửi lúc 00:01 | Thống kê "Hôm nay" ở Trang chủ tính vào ngày nào? | 🟡 | ☐ |
| CRE-E09 | Cỡ chữ hệ thống lớn nhất | "Soi chiếu an ninh quốc nội", tên loại dài, chip email có bị cắt / đè nút không? | 🟡 | ☐ |
| CRE-E10 | Dark Mode | Nút "Tiếp tục" mờ và bật còn phân biệt được không (đo màu)? | 🟡 | ☐ |
| CRE-E11 | iPhone màn nhỏ (SE) ở bước 6 khi bàn phím mở | Bàn phím che "Tiếp tục" hay ô đang nhập? | 🟡 | ☐ |
| CRE-E12 | VoiceOver | Đọc được "Bước N/9", trạng thái ✔ của khu vực/Đội, nút mờ có đọc là "không khả dụng"? | 🟡 | ☐ |
| CRE-E13 | Mạng yếu (Network Link Conditioner "3G"/"Very Bad Network") khi gửi và khi tìm email | Có trạng thái loading không? Bấm lại trong lúc chờ thì sao (liên quan N21)? | 🟠 | ☐ |
| CRE-E14 | Đưa app xuống nền khi đang mở camera quét, 5 phút sau quay lại | Wizard còn ở bước 6 với dữ liệu cũ? | 🟠 | ☐ |
| CRE-E15 | Có cuộc gọi đến giữa bước 5 khi đang nhập Mô tả | Nội dung đang gõ còn không? | 🟡 | ☐ |
| CRE-E16 | Hai người giao việc gửi vụ việc gần như cùng lúc (2 máy) | Hai mã VV khác nhau, không đè dữ liệu nhau? | 🟠 | ☐ |
| CRE-E17 | Người giao việc vừa tạo vụ việc thì bị đổi vai trò / mất uỷ quyền (Tổ phó) giữa wizard | Gửi được không (B1)? | 🟠 | ☐ |

---

## 4 · Coverage matrix

| Màn / state | Có ảnh | Mục checklist chạm | Ghi chú |
|---|---|---|---|
| S00 Trang chủ — Đội trưởng | ✅ | H01, H22 | |
| S00 Trang chủ — Cán bộ / Tổ phó chưa uỷ quyền | ❌ | N01, N02 | coverage gap tới khi có tài khoản test |
| S01 trống / đã có ảnh | ✅ / ❌ | H02, H03, E03 | |
| S01 dialog quyền Camera / Ảnh | ❌ | N15, N16 | |
| S02 đã chọn | ✅ | H04, N24 | mục đầu chọn sẵn (V9) |
| S03 / S04 mặc định / đã chọn | ✅ / ❌ | H05, H06, N07 | |
| S04 "Khẩn cấp" | ❌ | H22, Q01 | |
| S05 trống / đã nhập | ✅ / ❌ | H07, N06, E01, E15 | |
| S06 trống / sau quét / thủ công | ✅ | H08–H11, N04, N11–N13, N17–N19, E04, E05 | |
| S06 chọn từ thư viện (6.2) | ❌ | H09 | spec có, không có ảnh |
| S07 camera / xác nhận ảnh / lỗi nhận dạng | ✅ / ❌ / ❌ | H08, N17, E14 | |
| S08 chưa chọn / đã chọn / "Khác" | ✅ / ❌ / ❌ | H12, N05 | |
| S09 chưa chọn / 1 người / ≥2 người / không kết quả | ✅ / ✅ / ❌ / ❌ | H13–H15, N03, N08, N14 | |
| S10 chưa chọn hạn / đã chọn | ✅ | H16, H17, N09, N10, E06, E07 | |
| S10 date/time picker | ❌ | H17 | |
| Sau khi gửi: loading / thành công / lỗi | ❌ | H18, N20, N21, E13 | |
| R tab Tiếp nhận — người tạo | ✅ | H18, H21, N25 | |
| Phía cán bộ nhận (Của tôi / Thông báo) | ❌ (flow 04) | H20, H21 | |
| Đóng sheet giữa chừng | ❌ | N22, N23 | |

---

## 5 · Câu hỏi cần PO/dev trả lời — CRE-Q

Phần lớn câu hỏi đã có trong test-analysis — **không lặp lại**, chỉ liên kết:
B1–B7 (chặn) (đã xoá 2026-10-28, xem git `5fc75a6`) ·
O1–O19 (đã xoá 2026-10-28, xem git `5fc75a6`).
Câu hỏi **mới** phát sinh khi dựng wireframe:

| ID | Câu hỏi | Liên quan |
|---|---|---|
| CRE-Q01 | Chọn "Khẩn cấp": "Cảnh báo Lãnh đạo + BCH đội" gửi tới **ai cụ thể**, qua kênh nào (push, SMS), ngay khi gửi hay khi chọn? | B6 · H22 |
| CRE-Q02 | Thẻ vụ việc ở tab Tiếp nhận hiển thị tên **Tổ** — đó là Tổ của người tạo hay của cán bộ được giao? Có khớp Đội đã chọn ở bước 8 không? | V3 · N25 · B3 |
| CRE-Q03 | Màn camera ở bước 6.1 là camera của iOS hay màn của app? Nhận dạng chữ chạy trên máy hay gửi ảnh lên server? | V12 · B7 · O7 |
| CRE-Q04 | Hai kiểu icon ở danh sách khu vực (📍 và ⑂) khác nhau ở đâu? | S02 |
| CRE-Q05 | "Tra biển số" tra ở nguồn dữ liệu nào? Kết quả tra có tự điền vào đâu? | B6 |

---

## 6 · Smoke 15 phút cho flow này  *(Exploratory testing / session-based, §4.4.2 — test charter)*

> **Charter:** dùng tài khoản Đội trưởng và giấy tờ mẫu, khám phá xem một vụ việc tạo qua wizard có tới **đúng
> người**, với **đúng và đủ** dữ liệu không — tập trung vào đối tượng (quét giấy tờ) và người nhận.

| Thời lượng | Mục tiêu quan sát |
|---|---|
| 4 phút | Đi trọn 9 bước với dữ liệu tối thiểu (không ảnh, 1 đối tượng quét CCCD mẫu, 1 cán bộ, hạn ngày mai) → gửi. Thẻ ở tab Tiếp nhận và chi tiết có đúng những gì đã nhập không? (H18, H19) |
| 4 phút | Quét CCCD mẫu và hộ chiếu mẫu: bao nhiêu trường điền đúng? Sửa một trường rồi gửi — giá trị nào được lưu? (H08, N18, N19) |
| 3 phút | Trên máy cán bộ được giao: vụ việc có tới không, sau bao lâu, ở tab nào? Cán bộ không được giao có thấy không? (H20, B4) |
| 2 phút | Bấm "Giao việc & gửi" nhiều lần và gửi khi mất mạng: có vụ việc trùng hoặc mất dữ liệu không? (N20, N21) |
| 2 phút | Đăng nhập Cán bộ: có tạo được vụ việc không? (N01) |

---

## 7 · Kết luận phiên  *(Debriefing của session, §4.4.2)*

```
Phiên: __________     Build: 1.0.0 (52)     Thiết bị / iOS: __________     Tài khoản: __________

Q1 Mục tiêu user:            ghi nhận vụ việc tại hiện trường và giao đúng cán bộ, đủ thông tin
Q8 Mục tiêu business:        không thiếu thông tin khi giao nhận, bớt giấy tờ
— Chạy luồng chính —
Q2 Xong dễ lần đầu?          Có / Không — vì: __________
Q3 Điểm khựng/bối rối:       ______________________________
Q4 Thao tác sai / gián đoạn: ______________________________
Q5 State chưa test:          ______________________________ (đối chiếu §4)
— Kết luận —
Q6 Rủi ro #1 nếu ship:       ______________________________
Q7 Người giao việc có muốn dùng thay giấy tờ không? Có / Không — vì: __________
Q9 15 phút thì test gì:      ______________________________

=> Verdict: 🟢 ship được / 🟡 ship có điều kiện / 🔴 chưa nên ship
   Bằng chứng (mã VV, ảnh, BUG-…): ______________________________
```

**Ngưỡng đề xuất cho flow này** *(QC đề xuất — chờ QC lead duyệt, chưa phải tiêu chí chính thức):*

| Verdict | Điều kiện |
|---|---|
| 🔴 | Vai trò không có quyền vẫn tạo được vụ việc · vụ việc tới sai người / sai đơn vị · mất dữ liệu đã nhập khi gửi lỗi · tạo trùng vụ việc · quét giấy tờ điền **sai im lặng** · dữ liệu đối tượng mất hoặc sai sau khi gửi |
| 🟡 | Tính bắt buộc của các bước chưa thống nhất nhưng không mất dữ liệu · thiếu thông báo khi từ chối quyền Camera/Ảnh · màn xem lại thiếu thông tin |
| 🟢 | Đi trọn 9 bước lần đầu không cần hướng dẫn · vụ việc tới đúng cán bộ với đủ dữ liệu · không có đường mất dữ liệu |
