# Test Plan — Tạo vụ việc xử lý vi phạm (XL01, flow `03_case-create`) — theo đặc tả v2.1 + làm rõ 2026-10-27/28

> **Test Plan Status: READY (có điều kiện — đọc "Điều kiện đi kèm" ngay dưới)** · Ngày lập 2026-10-28.
> Căn cứ: không có banner DRAFT; test-analysis đầu vào ở trạng thái READY (không còn banner DRAFT ở đầu file — đã đối chiếu); mục 10 có 40 câu hỏi mở nhưng **không câu nào đổi scope hoặc ưu tiên của đợt này** — chỉ đổi kết quả mong đợi, và QC lead đã quyết định cho mang sang ("Mang sang, chạy tiếp", 2026-10-28). Không có gap nào trùng 5 lý do dừng bắt buộc ở mục 0 của skill. Hai điểm cần orchestrator/QC lead **nhìn lại** nếu câu trả lời bất ngờ: QO32 (bước 1, 3–7 của nhánh cán bộ có giống nhánh người giao không) và QO44 (nút "Hoàn tất xử lý") — xem mục 10.

> **Điều kiện đi kèm (không được bỏ khi thiết kế test case / chạy test):**
> 1. Test condition có trạng thái kết quả mong đợi **MỞ** hoặc phần **còn mở** (mục 2.1) → expected result ghi nguyên văn là *"còn mở — chỉ ghi lại hành vi quan sát được"*; **không** bịa giá trị, **không** chấm đạt/không đạt phần đó.
> 2. Các điểm **⚑ suy ra** — **QO25** (vụ việc do Trưởng/Phó trưởng CACK tạo hiện ở Tiếp nhận của ai) và **QO42** (Đội nhận khi quét QR = Đội của cán bộ được quét; đã chọn Đội rồi quét mã Đội khác) — **KHÔNG dùng làm tiêu chí đạt/không đạt**; chỉ ghi quan sát.
> 3. **QO44** ("Hoàn tất xử lý") phải được làm rõ **trước khi** phân tích/lập kế hoạch cho luồng tiếp nhận và xử lý vụ việc (bộ tài liệu khác). Ở XL01 chỉ kiểm **sự có mặt** của nút, không kiểm hành vi.
> 4. READY ở đây nghĩa là **đủ điều kiện để thiết kế test case**. Điều kiện **để chạy test** (model iPhone, iOS, build, tài khoản theo vai trò, Đội có/không có Phó trưởng phụ trách, giấy tờ mẫu giả, công cụ quan sát lưu lượng mạng…) **chưa có thông tin** — ghi là điều kiện chờ ở mục 7, 8, 10 (QO23) và 11; **không** được coi là đã sẵn sàng.
> 5. Phạm vi vai trò do QC lead chốt (F2): chỉ **2 nhóm** — người giao việc; người nhận việc (cán bộ hiện trường / Phòng Camera / Văn thư). Khác biệt giữa Tổ trưởng, Tổ phó, Phó Đội trưởng, cán bộ được uỷ quyền: **hoãn**. Kiểm tra hạn hoàn thành cho vụ việc do cán bộ tạo: **tạm bỏ** (E3). Chỉ iPhone (L4).

> **Test basis (thứ tự ưu tiên khi mâu thuẫn — QC lead chốt; câu trả lời sau thay câu trước, dòng ⚠️ chỉ để truy vết, điểm ⚑/❓ không phải fact):**
> 1. [lam-ro-2026-10-27.md](../../specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-27.md) — quyết định 2026-10-27/28 (L6, C2, C4–C8, D1–D7, E1–E9, F1–F8, G1–G6, H1–H5, trả lời QB4–QB6, quyết định "Mang sang, chạy tiếp" cho QO42–QO45). Còn mở: I1.
> 2. [lam-ro-2026-10-26.md](../../specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-26.md) — QB1(a)(b)(c), QB2, QB3 còn hiệu lực cho người giao; **QB1(d) phần cảnh báo Khẩn cấp đã bị G1 thay**.
> 3. [dac-ta-chuc-nang-v2.1.md](../../specs/xu-ly-vi-pham-giao-viec/dac-ta-chuc-nang-v2.1.md) — XL01 và các phần áp dụng: §1.2, §2.4 Tính năng 1, §3, §4, §8, §9, §10, CH07, Phụ lục A/B/C. Build/nhánh bàn giao: không nêu.
> 4. [mo-ta-chuc-nang-v1.md](../../specs/xu-ly-vi-pham-giao-viec/mo-ta-chuc-nang-v1.md) — chỉ khi các nguồn trên im lặng (lần này không cần dùng).
>
> **Bằng chứng giao diện (không phải test basis):** [iphone/index.md](../../ui/ux/screenshots/iphone/index.md), [wireframe 03_case-create](../../ui/ux/wideframes/03_case-create.md) (lập trước đặc tả v2.1, mọi ảnh bước 1–9 chụp bằng tài khoản Đội trưởng; riêng `03_case-create_09_assignee_qr-scan`, `04_case-handling_01_case-list_pending`, `04_case-handling_02_case-detail_pending` là ảnh QC lead gửi 2026-10-28, build chưa rõ).
> **Chuẩn:** ISTQB Foundation Level v4.0.1 (test basis → test object → kỹ thuật thiết kế → rủi ro → entry/exit)
> **Test analysis đầu vào:** [test-analysis-dac-ta-v2.1-lam-ro-10-28.md](test-analysis-dac-ta-v2.1-lam-ro-10-28.md) (Analysis Status READY, cập nhật lần 3; 79 test condition: P1 44 · P2 24 · P3 11). Mã `TC-nn` và `QOnn` trong tài liệu này **trích đúng** từ file đó — **không trùng nghĩa** với `TC-nn` của bộ cũ `*-dac-ta-v2.1.md`.
> **Test case cụ thể:** [test-cases-dac-ta-v2.1-lam-ro-10-28.md](test-cases-dac-ta-v2.1-lam-ro-10-28.md) — sẽ sinh bởi skill test-case sau khi orchestrator xác nhận test plan này.
> **Đối chiếu tài liệu đã có:** bộ cũ [test-plan-dac-ta-v2.1-SUPERSEDED.md](test-plan-dac-ta-v2.1-SUPERSEDED.md) (tham khảo cấu trúc/phương pháp, không phải test basis; chờ orchestrator đánh dấu SUPERSEDED); [exploratory/03_case-create.md](../../exploratory/03_case-create.md) và wireframe (lập trước đặc tả — chỉ làm nguồn gợi ý khi test basis im lặng); `bugs/bug-log.md` (chỉ có khung mẫu, **chưa có bug nào** → không có bug cũ cần regression).
> **Dữ liệu cá nhân:** chỉ dùng giấy tờ, dữ liệu đối tượng và tài khoản **mẫu giả**; tài liệu này chỉ nêu tên trường, không chép họ tên, email, số giấy tờ, số điện thoại, mã cán bộ.
> **Ngày lập:** 2026-10-28 · **Người lập:** QC

---

## 1. Phát hiện khi đối chiếu với tài liệu đã có

### 1.1 Bộ cũ → bộ mới

Bộ `*-dac-ta-v2.1.md` (lập 2026-10-26, trước L6/C–H) **không còn đủ làm nguồn** cho đợt này vì quyền tạo vụ việc đã đổi. Không sửa bộ cũ; orchestrator đánh dấu SUPERSEDED.

| # | Điểm | Bộ cũ | Bộ mới (theo lam-ro 2026-10-27/28) |
|---|---|---|---|
| 1 | Quyền tạo | Cán bộ thường và Phòng Camera **không** tạo được (TC-04, 05 cũ) | **Sai sau L6/C6:** cán bộ hiện trường và Phòng Camera **tạo được**; chỉ Văn thư không thấy nút (TC-02, 03, 04) |
| 2 | Vai trò người giao | 6 vai trò + cán bộ uỷ quyền + thu hồi uỷ quyền (TC-02, 03, 06 cũ) | **Hoãn theo F2** — chỉ 2 nhóm vai trò; bỏ các test condition đó |
| 3 | Nhánh cán bộ tạo | Không có | **Thêm mới:** bàn giao bắt buộc 1 Đội, chỉ định tối đa 1 cán bộ hiện trường (tuỳ chọn), quét mã QR, trạng thái Chờ tiếp nhận / Đang thực hiện, không có hạn (E1, E2, F1, F5, C4) |
| 4 | Cảnh báo Khẩn cấp | Theo QB1(d): Trưởng CACK, Phó trưởng CACK, Chỉ huy Đội | **G1 thay:** Phó trưởng CACK phụ trách Đội nhận; chưa có thì Đội trưởng và Đội phó; Trưởng CACK không nhận (TC-73) |
| 5 | Ai thấy vụ việc | Chỉ nhánh người giao (TC-58, 59 cũ) | Gộp thành TC-68; **thêm** TC-69 (ai thấy vụ việc do cán bộ tạo), TC-70 (người tạo không có thao tác) |
| 6 | Thông báo | Chỉ "Bạn có phần việc mới" | Thêm TC-72 (thông báo cho Đội trưởng khi cán bộ tạo, C8) |
| 7 | Số test condition | 65 (P1 34 · P2 20 · P3 11), 10 nhóm | **79** (P1 44 · P2 24 · P3 11), 12 nhóm (thêm ACB, NOTI) |

### 1.2 Mâu thuẫn giữa nguồn đã có quyết định (không phải điểm chặn)

| # | Nguồn bị thay | Nguồn thắng | Hệ quả |
|---|---|---|---|
| 1 | Đặc tả §3.1 ("Phòng Camera không có quyền tạo vụ việc" [Q31]), §3.3, §3.4 dòng XL01, BR01, [Q4] | L6, C6 | TC-02, 03 theo L6/C6; đề nghị sửa đặc tả (QO28) |
| 2 | Đặc tả XL01-B8, B9, BR04 (hạn và cán bộ bắt buộc) | E1, F1, C4, D2, E3 cho nhánh cán bộ; BR04 vẫn đúng cho nhánh người giao | TC-10 dạng bảng theo nhánh |
| 3 | Đặc tả [B7], BR16, CH07 (cảnh báo Khẩn cấp) và QB1(d) | G1 | TC-73 |
| 4 | Đặc tả XL01-B2, §3.2, BR36, [B25*] (giới hạn khu vực theo tài khoản) | QB2, QB3, C2, QB5 | Khu vực theo **Đội**, không theo tài khoản (TC-19–22) |
| 5 | Đặc tả CH05/[B19] (ô Chờ tiếp nhận, Chờ chỉ đạo, Đã đóng luôn bằng 0) | E6 (các trạng thái nay được dùng) | TC-77 |
| 6 | Đặc tả [B14] (nguồn Camera bỏ qua) ↔ ảnh `case-detail_pending` hiện "Nguồn phát hiện: Phòng Camera" | Chưa có quyết định | Giữ mở: QO26 (TC-64, 76) |
| 7 | Ghi chú màn bước 4 "Cảnh báo Lãnh đạo + BCH đội" ↔ G1 | Chưa có quyết định | Giữ mở: QO38 (TC-27, 73) |

---

## 2. Test object — In scope

Phạm vi: **XL01 trên ứng dụng iPhone** ở cả hai nhánh — **[NG]** người giao việc tạo, **[CB]** cán bộ tạo (hiện trường, Phòng Camera) — và hậu điều kiện trực tiếp (vụ việc xuất hiện ở đâu, trạng thái gì, thông báo, cảnh báo Khẩn cấp, nhật ký, thống kê). **79 test condition** chia thành **12 nhóm** (mã nhóm = tiền tố ID cho test-case, dạng `TC-<MÃ>-NN`).

| # | Mã nhóm | Hạng mục | TC (từ test-analysis) | Nguồn test basis | Ghi chú |
|---|---|---|---|---|---|
| 1 | **AUTH** | Quyền tạo vụ việc theo vai trò (Vai trò của tài khoản); mất mạng khi gửi | TC-01–06 | XL01 Tác nhân/Kích hoạt/Tiền điều kiện; §3.1; BR17; [Q32]; L6, C6, C7; F2 | Tài khoản: Đội trưởng, Trưởng CACK, Phó trưởng CACK, cán bộ hiện trường, Phòng Camera, Văn thư |
| 2 | **NAV** | Thanh bước, Quay lại, thoát giữa chừng, bảng bắt buộc theo nhánh | TC-07–10 | XL01; BR04; PL-C #3; L3a(b); E1, F1, C4, D2, E3; QB6(a) | TC-10 dạng bảng quyết định theo nhánh |
| 3 | **EVD** | Bước 1 — Hình ảnh/Bằng chứng | TC-11–17 | XL01-B1; BR20; [Q20, B12] | Chạy chính trên [NG], kiểm khói trên [CB] (A5) |
| 4 | **CLS** | Bước 2–4 — Khu vực (theo nhóm người tạo), Loại, Mức độ | TC-18–27 | XL01-B2/B3/B4; §8.2; BR21; QB2, QB3, QB5; C2; G1 (ghi chú bước 4) | TC-21, 22 cần cán bộ thuộc Đội có khu vực gán khác Đội nhận |
| 5 | **DSC** | Bước 5 — Mô tả | TC-28–30 | XL01-B5; §10; [B13]; L3a(b) | |
| 6 | **SUBJ** | Bước 6 — Thông tin đối tượng (quét, thư viện, thủ công) | TC-31–42 | XL01-B6; §8.1; BR18, BR19, BR29; [Q17, Q18, Q35, B13, B16] | Cần bộ giấy tờ **mẫu giả** 4 loại (QO23) |
| 7 | **PROP** | Bước 7 — Đề xuất xử lý | TC-43–44 | XL01-B7; §8.2 | |
| 8 | **ASG** | Bước 8 nhánh người giao [NG] — chọn Đội, cán bộ, phạm vi giao, không có QR | TC-45–50 | XL01-B8; §3.2, §3.4; BR02; PL-C #1; QB1(a)(c); F2; QB6(c) | TC-50 kiểm sự **vắng mặt** của QR |
| 9 | **ACB** | Bước 8 nhánh cán bộ tạo [CB] — chọn Đội, chỉ định tối đa 1 cán bộ hiện trường, bàn giao bằng mã QR | TC-51–55, 78, 79 | E1, E2, F1, F5, G4; C2; QB6(a)(b)(d) | Nhóm mới. TC-55 có phần ⚑ (QO42) |
| 10 | **SUB** | Bước 9 — Xem lại, hạn ([NG]), gửi, mã vụ việc, chống gửi trùng | TC-56–64 | XL01-B9, Hậu điều kiện; BR06, BR38; [B1, B8, Q4]; C4, D2, E3 | TC-57–59 chỉ [NG]; TC-60 chỉ [CB] |
| 11 | **POST** | Hậu điều kiện: trạng thái ban đầu, ai thấy vụ việc ở tab nào, quyền của người tạo | TC-65–70 | XL01 Hậu điều kiện; §4.1, §4.2; BR03, BR35; [B24]; QB1(c); D1, D4, E2, E5, E6, C5, G3; QB4 | TC-67 là điểm vào của luồng tiếp nhận tại Đội (ảnh hưởng chéo). TC-68 có phần ⚑ (QO25) |
| 12 | **NOTI** | Hậu điều kiện: thông báo, cảnh báo Khẩn cấp, nhắc việc, nhật ký, Đội/Tổ trên thẻ, thống kê | TC-71–77 | CH07; BR11, BR27, BR32; [Q14, B19]; C8, D1, D6, F3, E8, G1; QB1(b)(d) | TC-72, 73, 77 có phần ⚑ (QO42) |

### 2.1 Bảng 79 test condition: nhóm, ưu tiên, trạng thái kết quả mong đợi

Quy ước cột **KQ mong đợi** (QC phân loại dựa trên mục 4.3 test-analysis và quyết định QC lead 2026-10-28):
**XĐ** = xác định được từ test basis · **MỘT PHẦN** = phần chính xác định, phần chi tiết còn mở (ghi QO) · **MỞ** = chủ yếu còn mở → chỉ ghi lại hành vi quan sát được.
Cột **Nhánh**: NG = người giao việc · CB = cán bộ tạo · cả hai.

| TC | Nội dung rút gọn | Nhóm | Nhánh | Ưu tiên | KQ mong đợi | QO liên quan |
|---|---|---|---|---|---|---|
| 01 | Đội trưởng/Chỉ huy Đội, Trưởng/Phó trưởng CACK thấy nút +, mở "Bước 1/9" | AUTH | NG | P1 | MỘT PHẦN | QO3 |
| 02 | Cán bộ hiện trường thấy nút +, mở và gửi được | AUTH | CB | P1 | MỘT PHẦN | QO3 |
| 03 | Cán bộ Phòng Camera thấy nút +, mở và gửi được | AUTH | CB | P1 | MỘT PHẦN | QO3 |
| 04 | Cán bộ Văn thư không thấy nút +, không mở được màn tạo | AUTH | — | P1 | XĐ | — |
| 05 | Quyền đi theo trường Vai trò; đổi Vai trò thì nút hiện/ẩn theo | AUTH | — | P2 | MỘT PHẦN | QO33 |
| 06 | Mất mạng: không gửi, không lưu nháp ngoại tuyến | AUTH | cả hai | P1 | MỘT PHẦN | QO18 |
| 07 | Thanh "Bước n/9", tên bước đúng thứ tự cả 2 nhánh | NAV | cả hai | P3 | MỘT PHẦN | QO35 |
| 08 | Quay lại giữ dữ liệu; đổi giá trị bước trước thì lưu giá trị mới | NAV | cả hai | P2 | XĐ | — |
| 09 | Đóng/thoát/chuyển nền giữa chừng | NAV | cả hai | P2 | **MỞ** | QO4 |
| 10 | Nút Tiếp tục/gửi theo bảng bắt buộc theo nhánh | NAV | cả hai | P1 | MỘT PHẦN | QO7, QO34, QO42 (⚑ phần QR) |
| 11 | Đi tiếp khi chưa có ảnh | EVD | cả hai | P3 | XĐ | — |
| 12 | Thêm ảnh (chụp, thư viện); "Bằng chứng: n tệp"; lưu cùng vụ việc | EVD | cả hai | P1 | MỘT PHẦN | QO5 |
| 13 | Chỉ nhận ảnh | EVD | cả hai | P2 | XĐ | — |
| 14 | Giới hạn 50MB mỗi ảnh | EVD | cả hai | P2 | MỘT PHẦN | QO5 |
| 15 | Ảnh gắn thời gian | EVD | cả hai | P2 | MỘT PHẦN | QO5 |
| 16 | Ảnh lưu không có toạ độ GPS | EVD | cả hai | P2 | MỘT PHẦN | QO5 |
| 17 | Từ chối quyền Camera/Ảnh iOS (bước 1, 6) | EVD | cả hai | P2 | **MỞ** | QO6 |
| 18 | Bước 2 chọn 1 khu vực, lưu đúng | CLS | cả hai | P3 | MỘT PHẦN | QO7 |
| 19 | [NG] Đội trưởng/Chỉ huy Đội: khu vực của Đội người tạo | CLS | NG | P1 | MỘT PHẦN | QO27 |
| 20 | [NG] Trưởng/Phó trưởng CACK: khu vực mọi Đội, chọn Đội bất kỳ, không chặn lệch | CLS | NG | P2 | MỘT PHẦN | QO31 |
| 21 | [CB] Phòng Camera: khu vực của Đội mình | CLS | CB | P1 | MỘT PHẦN | QO27 |
| 22 | [CB] Cán bộ hiện trường: khu vực của Đội mình, không kiểm khớp với Đội nhận | CLS | CB | P1 | MỘT PHẦN | QO27 |
| 23 | Danh mục theo cấu hình quản trị | CLS | cả hai | P3 | XĐ | — |
| 24 | Loại hai cấp, lưu loại cha + con | CLS | cả hai | P1 | MỘT PHẦN | QO8 |
| 25 | Loại "Khác" nhập tay | CLS | cả hai | P2 | MỘT PHẦN | QO8 |
| 26 | Loại có cờ biểu mẫu → khối Biểu mẫu và chữ ký (cả vụ việc [CB]) | CLS | cả hai | P1 | MỘT PHẦN | QO8 |
| 27 | Mức độ 3 giá trị, lưu, lọc, ghi chú Khẩn cấp | CLS | cả hai | P2 | MỘT PHẦN | QO38 |
| 28 | Mô tả bắt buộc; 2 ô còn lại tuỳ chọn; lưu đúng | DSC | cả hai | P1 | XĐ | — |
| 29 | Khoảng trắng, độ dài, tiếng Việt có dấu/ký tự đặc biệt | DSC | cả hai | P2 | **MỞ** | QO9 |
| 30 | Nhập giọng nói ở 3 ô bước 5 | DSC | cả hai | P3 | MỘT PHẦN | QO6, QO21 |
| 31 | Không có đối tượng vẫn gửi được | SUBJ | cả hai | P3 | XĐ | — |
| 32 | "Số lượng đối tượng" không cần khớp | SUBJ | cả hai | P3 | MỘT PHẦN | QO12 |
| 33 | Quét giấy tờ tự điền đúng, 4 loại | SUBJ | cả hai | P1 | MỘT PHẦN | QO11, QO21 |
| 34 | Từ thư viện tự điền đúng, 4 loại | SUBJ | cả hai | P1 | MỘT PHẦN | QO11, QO21 |
| 35 | Trường tự điền sửa được; lưu giá trị đã sửa | SUBJ | cả hai | P1 | XĐ | — |
| 36 | Nhận dạng thất bại / điền thiếu | SUBJ | cả hai | P1 | **MỞ** | QO11 |
| 37 | Không lưu ảnh giấy tờ | SUBJ | cả hai | P1 | MỘT PHẦN | QO11 |
| 38 | Nhận dạng chạy trên thiết bị (ảnh không gửi lên máy chủ) | SUBJ | cả hai | P1 | XĐ | — (cần công cụ: mục 7, 11) |
| 39 | Thêm đối tượng thủ công, 6 trường lưu đúng | SUBJ | cả hai | P1 | XĐ | — |
| 40 | Quy tắc hợp lệ trường đối tượng | SUBJ | cả hai | P1 | **MỞ** | QO10 |
| 41 | Nhiều đối tượng, xoá; CCCD hiển thị đầy đủ | SUBJ | cả hai | P2 | XĐ | — |
| 42 | Biển số xe, Đơn vị liên quan | SUBJ | cả hai | P3 | MỘT PHẦN | QO13 |
| 43 | Đề xuất xử lý chọn 0/1/nhiều | PROP | cả hai | P3 | XĐ | — |
| 44 | Đề xuất "Khác": ô nhập nội dung | PROP | cả hai | P3 | **MỞ** | QO14 |
| 45 | [NG] Tìm theo email, chọn ≥1 cán bộ; bắt buộc ≥1 | ASG | NG | P1 | XĐ | — |
| 46 | [NG] Phạm vi giao: Đội trưởng chỉ Đội mình; Trưởng/Phó trưởng CACK Đội bất kỳ | ASG | NG | P1 | XĐ | — |
| 47 | [NG] Đúng 1 Đội; danh sách cán bộ lọc theo Đội | ASG | NG | P1 | MỘT PHẦN | QO29 |
| 48 | [NG] Tìm theo email: kết quả khớp, không kết quả | ASG | NG | P2 | MỘT PHẦN | QO15 |
| 49 | [NG] Tự giao cho mình / giao cho người giao khác | ASG | NG | P2 | **MỞ** | QO16 |
| 50 | [NG] Bước 8 không có nút/lựa chọn quét QR | ASG | NG | P2 | XĐ | — |
| 51 | [CB] Bắt buộc 1 Đội (danh sách mọi Đội hoặc QR); không có "không bàn giao" | ACB | CB | P1 | MỘT PHẦN | QO34, QO42 (⚑ phần QR) |
| 52 | [CB] Chỉ định tuỳ chọn, tối đa 1, chỉ cán bộ hiện trường thuộc Đội đã chọn | ACB | CB | P1 | MỘT PHẦN | QO34 |
| 53 | [CB] Không chỉ định vẫn đi tiếp và gửi được | ACB | CB | P1 | XĐ | — |
| 54 | [CB] Cán bộ hiện trường tự chỉ định chính mình | ACB | CB | P2 | **MỞ** | QO34 |
| 55 | [CB] QR mã hợp lệ → được chỉ định, vụ việc Đang thực hiện | ACB | CB | P1 | MỘT PHẦN | **QO42 ⚑** |
| 56 | [NG] Màn xem lại tóm tắt đúng | SUB | NG | P2 | XĐ | — |
| 57 | [NG] Chọn ngày giờ hạn; mặc định 17:00; lưu đúng | SUB | NG | P1 | MỘT PHẦN | QO17 |
| 58 | [NG] Hạn không ở quá khứ; không giới hạn tối đa | SUB | NG | P1 | MỘT PHẦN | QO17 |
| 59 | [NG] Hạn theo giờ Việt Nam khi thiết bị khác múi giờ | SUB | NG | P2 | **MỞ** | QO17 |
| 60 | [CB] Bước cuối không có hạn; nút gửi bật khi hợp lệ | SUB | CB | P1 | MỘT PHẦN | QO35 |
| 61 | Chỉ có nút gửi, không có "Xử lý tại chỗ và hoàn thành" | SUB | cả hai | P3 | XĐ | — |
| 62 | Gửi tạo đúng 1 vụ việc, mã VV + 6 chữ số, không trùng | SUB | cả hai | P1 | XĐ | — |
| 63 | Bấm gửi nhiều lần / mạng chập chờn / lỗi máy chủ: không tạo trùng | SUB | cả hai | P1 | **MỞ** | QO18 |
| 64 | Dữ liệu các bước, thời gian, người tạo lưu và hiện đúng ở Chi tiết | SUB | cả hai | P1 | MỘT PHẦN | QO19, QO26 |
| 65 | [NG] Trạng thái ban đầu Đang thực hiện; phần việc Đã giao/Chưa bắt đầu; "Giao việc 0/y" | POST | NG | P1 | XĐ | — |
| 66 | [CB] Có chỉ định → Đang thực hiện, không có hạn | POST | CB | P1 | MỘT PHẦN | QO36 |
| 67 | [CB] Không chỉ định → Chờ tiếp nhận, hiện ở Tiếp nhận của Đội trưởng Đội nhận | POST | CB | P1 | MỘT PHẦN | QO36, QO44 |
| 68 | [NG] Hiện ở tab nào cho ai | POST | NG | P1 | MỘT PHẦN | **QO25 ⚑** |
| 69 | [CB] Ai thấy vụ việc do cán bộ tạo (4 nhóm người) | POST | CB | P1 | MỘT PHẦN | QO44 |
| 70 | [CB] Người tạo chỉ có quyền tạo, không có thao tác | POST | CB | P1 | MỘT PHẦN | QO45 |
| 71 | [NG] Mỗi cán bộ được chỉ định nhận đúng 1 thông báo | NOTI | NG | P1 | XĐ | — |
| 72 | [CB] Thông báo cho Đội trưởng Đội người tạo, Đội trưởng Đội nhận, cán bộ được chỉ định | NOTI | CB | P1 | MỘT PHẦN | QO37, QO42 (⚑) |
| 73 | Cảnh báo Khẩn cấp theo G1 | NOTI | cả hai | P1 | MỘT PHẦN | QO38, QO30, QO42 (⚑) |
| 74 | [NG] Thời điểm nhắc việc = giao + 2/3 × (hạn − giao) | NOTI | NG | P2 | MỘT PHẦN | BR11 một phần "suy ra" (cần khách hàng xác nhận khi nghiệm thu) |
| 75 | Nhật ký / Diễn biến xử lý | NOTI | cả hai | P2 | MỘT PHẦN | QO40, QO19 |
| 76 | Đội/Tổ trên thẻ; Nguồn phát hiện | NOTI | cả hai | P2 | MỘT PHẦN | QO26 |
| 77 | Thống kê Trang chủ cập nhật theo Đội | NOTI | cả hai | P2 | MỘT PHẦN | QO39 |
| 78 | [CB] QR mã bị từ chối (không phải cán bộ hiện trường) | ACB | CB | P1 | MỘT PHẦN | QO43 |
| 79 | [CB] QR: "Chọn ảnh QR", "Huỷ" | ACB | CB | P2 | MỘT PHẦN | QO43, QO6 |

**Thống kê trạng thái KQ mong đợi (QC phân loại):** XĐ 21 · MỘT PHẦN 48 · MỞ 10 (tổng 79). Trong 10 điều kiện MỞ có **3 điều kiện P1** (TC-36, 40, 63). Điều kiện có phần ⚑ cần ghi quan sát, không chấm: TC-10, 51, 55, 68, 72, 73, 77.

---

## 3. Out of scope

| # | Hạng mục | Lý do |
|---|---|---|
| 1 | **Khác biệt quyền giữa Tổ trưởng, Tổ phó, Phó Đội trưởng, cán bộ được uỷ quyền** (kể cả "Tổ phó được uỷ quyền", thu hồi uỷ quyền, uỷ quyền cho Phòng Camera, giới hạn khu vực BR36) | **Hoãn** theo F2 của QC lead; không viết test cho tới khi QC lead cập nhật (QO2 hoãn) |
| 2 | **Hạn hoàn thành, nhắc việc, "quá hạn", kết quả "đúng hạn/không đúng hạn" cho vụ việc do cán bộ tạo** | Tạm bỏ theo E3 (chưa có màn đặt hạn ở nhánh này). Chỉ ghi nhận cách hiển thị khi chưa có hạn (QO36) |
| 3 | **Luồng tiếp nhận tại Đội** (Tiếp nhận, Phân công, Duyệt và giao xử lý, Thay đổi hình thức xử lý, Bàn giao Đội khác, Đề xuất lãnh đạo) và **hành vi** nút "Hoàn tất xử lý" | Thuộc bộ tài liệu riêng (D4, E4–E9); ở XL01 chỉ kiểm sự có mặt của nút và vụ việc xuất hiện đúng chỗ (TC-67, 69) |
| 4 | **Phê duyệt & đóng**; **Huỷ phần việc**; trạng thái vụ việc khi huỷ hết phần việc | Ngoài phạm vi XL01 (G2, G3, I1 còn mở); chỉ ghi ảnh hưởng chéo |
| 5 | **Trang quản trị web** (cấu hình Vai trò, Đội, khu vực, Phó trưởng phụ trách, danh mục; nơi "lưu kết quả vào trang quản trị chung") | Ngoài phạm vi; chỉ là **dữ liệu kiểm thử / tiền điều kiện** (A4). Việc kết quả có lưu về trang quản trị không kiểm được → mục 11 |
| 6 | **Tab Vật phẩm** (H5); **Yêu cầu bổ sung** (E4); phần lãnh đạo xử lý **Chờ chỉ đạo** (F6) | Ngoài phạm vi theo test-analysis |
| 7 | **Android** | QC lead chốt L4 "tạm thời chỉ chạy trên iPhone" — phạm vi **đợt test**, đặc tả §10 vẫn ghi iOS và Android |
| 8 | Nút "Xử lý tại chỗ và hoàn thành" | Đã bỏ khỏi bước 9 (§1.2, [Q4]); chỉ kiểm là **không có** (TC-61) |
| 9 | Tra cứu biển số tự động | [Q35]: chưa có; chỉ kiểm nhập tay (nút "Tra biển số": QO13) |
| 10 | Chỉ tiêu hiệu năng §10 ("đề xuất"); **ngưỡng** độ chính xác nhận dạng giấy tờ/giọng nói | Chưa duyệt/chưa có ngưỡng → không là tiêu chí đạt/không đạt (QO21). Chức năng nhận dạng **vẫn được test** |
| 11 | Màn "Mã QR của tôi" (Trang chủ, flow `02_home`) | Chỉ là tiền điều kiện của TC-55, 78, 79; chưa có mô tả/test condition riêng |
| 12 | Ký lại biên bản, bắt buộc lý do khi ký lại (L3a(a)) | Đã bỏ; thuộc flow `05_record-signing` |
| 13 | Sao lưu, lưu trữ, số người dùng đồng thời | Đặc tả §10 [B17]: bỏ qua giai đoạn này |
| 14 | Nghiệm thu với khách hàng (§1.4) | Bước sau test hệ thống; chỉ lưu ý vài điểm "suy ra" (BR11, BR09) |

### 3.1 Ảnh hưởng chéo tới flow khác (theo flow map `screenshot-naming.md` §7)

| Flow | Ảnh hưởng? | Lý do |
|---|---|---|
| `01_login` | Gián tiếp | Phiên đăng nhập, Vai trò, tài khoản do quản trị viên tạo là tiền điều kiện; đổi Vai trò có thể cần đăng nhập lại (QO33, TC-05) |
| `02_home` | **Trực tiếp** | Nút + ở Trang chủ (TC-01–04); thống kê Trang chủ cập nhật sau khi tạo (TC-77, CH05); "Mã QR của tôi" ở Trang chủ là điều kiện của TC-55, 78, 79 |
| `03_case-create` | — (flow đang test) | |
| `04_case-handling` | **Trực tiếp** | Tab Tiếp nhận/Của tôi/Thông báo, Chi tiết, Lịch sử hiển thị dữ liệu XL01 (TC-12, 28, 64–77). TC-67 là điểm vào của luồng tiếp nhận tại Đội; nút "Hoàn tất xử lý" (TC-69, QO44). Cần chạy lại khi flow này đổi |
| `05_record-signing` | **Trực tiếp** | Loại có cờ biểu mẫu quyết định khối "Biểu mẫu và chữ ký", kể cả vụ việc [CB] (TC-26); dữ liệu đối tượng dùng lại ở biên bản (TC-39–41) |
| `06_task-assign` | Gián tiếp | Chung chuỗi mã VV với GV01 (TC-62); phân biệt nút + tạo vụ việc với option Giao việc [Q1]; phạm vi giao dùng chung §3.2 |
| `07_case-actions` | **Trực tiếp** | Phần việc, hạn, người được giao do XL01 tạo là đầu vào của Gia hạn, Phân công lại/tiếp; người tạo [CB] **không** có các thao tác này (TC-70); vụ việc [CB] không có Huỷ phần việc (G3) |
| `08_daily-report` | Gián tiếp | Vụ việc mới vào báo cáo hằng ngày (CH06, theo loại hai cấp/khu vực) — ngoài phạm vi; TC-18, 24 là nguồn dữ liệu |
| `09_web-admin` | Gián tiếp (tiền điều kiện) | Vai trò, Đội, khu vực gán Đội, Phó trưởng phụ trách, danh mục cấu hình tại đây; ngoài phạm vi, không kiểm |

---

## 4. Test levels và test types

| Khía cạnh | Nội dung |
|---|---|
| **Test level** | **System test** trên ứng dụng iPhone (luồng 9 bước từ đầu đến cuối, 2 nhánh, nhiều vai trò). **Integration test (tích hợp hệ thống)** ở phần phụ thuộc dịch vụ nền: thông báo đẩy (TC-71–73), nhắc việc (TC-74), nhật ký (TC-75), đồng bộ giữa nhiều tài khoản/thiết bị (TC-67–69, 77), tra cứu cán bộ qua QR (TC-55, 78). Không có component/unit test (không có mã nguồn). Nghiệm thu khách hàng nằm ngoài kế hoạch này |
| **Functional** | Tính đúng của chức năng: quy tắc bắt buộc theo nhánh, lưu dữ liệu, hiển thị, giao việc/bàn giao, hậu điều kiện (đa số TC) |
| **Non-functional** (ISO 25010) | **Security** (kiểm soát truy cập, bảo mật dữ liệu cá nhân) — quyền tạo theo Vai trò (TC-01–05), khu vực theo Đội (TC-19–22), phạm vi giao và chỉ định (TC-46, 47, 50, 52, 78), ai thấy vụ việc (TC-67–70), ảnh giấy tờ không lưu/không gửi lên máy chủ (TC-16, 37, 38). **Reliability** — mất mạng, gửi trùng, nhận dạng thất bại (TC-06, 09, 36, 63). **Usability** — nhãn bước, giọng nói, màn QR (TC-07, 30, 79). **Compatibility** — quyền hệ thống iOS: Camera, Ảnh, Micro (TC-17, 30, 79). **Không** có performance (chỉ tiêu chưa duyệt — QO21) và portability (chỉ iPhone) |
| **Change-related** | **Confirmation:** chạy lại case khi bug sửa xong. **Regression:** không có bug cũ (bug-log chưa có bug). Khi có build mới: chạy lại P1 của nhóm bị ảnh hưởng + chuỗi hậu điều kiện POST/NOTI. Khi flow `02`/`04`/`05`/`07` đổi, hoặc khi QC lead cập nhật F2/E3/QO44: chạy lại TC-01–05, 26, 64–77 (xem 3.1). Khi các câu hỏi mở được trả lời: cập nhật expected, chạy lại đúng test condition liên quan |

---

## 5. Kỹ thuật thiết kế test case

Kỹ thuật chọn cho **từng nhóm**. Nguồn "suy luận QC" được đánh dấu rõ. Kết quả mong đợi còn mở ghi **[MỞ]**; điểm suy ra ghi **[⚑]** — test case chỉ ghi nhận quan sát.

### 5.1 AUTH — Bảng quyết định (quyền tạo) + phân vùng (mạng)

Lý do: quyền là **tổ hợp** Vai trò × nhánh → bảng quyết định (nguồn L6, C6, C7). Mất mạng chỉ là phân vùng có/không mạng.

| Rule | Tài khoản (Vai trò) | Nút + Trang chủ | Nút + tab Của tôi | Mở/gửi được | TC |
|---|---|---|---|---|---|
| R1 | Đội trưởng/Chỉ huy Đội | Có | Có | Có | TC-01 |
| R2 | Trưởng CACK; Phó trưởng CACK (kiểm riêng từng vai trò) | Có | Có | Có | TC-01 |
| R3 | Cán bộ hiện trường | Có | **[MỞ QO3]** | Có (nhánh [CB]) | TC-02 |
| R4 | Cán bộ Phòng Camera | Có | **[MỞ QO3]** | Có (nhánh [CB]) | TC-03 |
| R5 | Cán bộ Văn thư | Không thấy | Không thấy | Không mở được | TC-04 |
| R6 | Đổi Vai trò (Văn thư ↔ hiện trường/Phòng Camera) | Hiện/ẩn theo Vai trò mới; thời điểm hiệu lực, đang giữa 9 bước **[MỞ QO33]** | | | TC-05 |

Nút + ở tab Tiếp nhận của người giao: **[MỞ QO3]**. Tổ trưởng, Tổ phó, Phó Đội trưởng, cán bộ uỷ quyền: **hoãn (F2)** — không có rule.
Mất mạng (TC-06), phân vùng: {có mạng · mất mạng trước khi mở màn · mất mạng giữa các bước · mất mạng đúng lúc bấm gửi}. Kỳ vọng xác định: không gửi được, không lưu nháp ngoại tuyến; giữ dữ liệu để gửi lại **[MỞ QO18]**. *(Các thời điểm mất mạng là gợi ý của QC.)*

### 5.2 NAV — Bảng quyết định (bắt buộc theo nhánh) + chuyển trạng thái

**Bảng quyết định nút Tiếp tục/gửi (TC-10)** — mỗi dòng kiểm 2 phân vùng {để trống · hợp lệ}, theo nhánh:

| Bước | Trường | [NG] | [CB] | Để trống → nút | Ghi chú |
|---|---|---|---|---|---|
| 1 | Hình ảnh/Bằng chứng | Tuỳ chọn | Tuỳ chọn (A5) | Sáng | |
| 2 | Khu vực | Bắt buộc | Bắt buộc | Mờ | Chọn sẵn mặc định: **[MỞ QO7]** |
| 3 | Loại vụ việc | Bắt buộc | Bắt buộc | Mờ | Loại "Khác" để trống tên: **[MỞ QO8]** |
| 4 | Mức độ | Bắt buộc | Bắt buộc | Mờ | |
| 5 | Mô tả vụ việc | Bắt buộc | Bắt buộc | Mờ | Chỉ khoảng trắng: **[MỞ QO9]**. Vị trí cụ thể, Hành động đã thực hiện: tuỳ chọn |
| 6, 7 | Đối tượng; Đề xuất xử lý | Tuỳ chọn | Tuỳ chọn | Sáng | |
| 8 | Đội + cán bộ | Đội + ≥1 cán bộ | **Đội bắt buộc** (chọn danh sách hoặc QR); cán bộ chỉ định tuỳ chọn, tối đa 1 | Mờ khi thiếu phần bắt buộc | QR thay chọn Đội: **[⚑ QO42]**; tự chỉ định, tìm theo email/tên: **[MỞ QO34]** |
| 9 | Hạn | **Bắt buộc** | **Không có bước chọn hạn** | [NG] gửi mờ nếu hạn không hợp lệ; [CB] gửi bật ngay | Số bước, nhãn nút [CB]: **[MỞ QO35]** |

**Chuyển trạng thái (TC-07, TC-08):** trạng thái S1…S9 (Bước 1…9) và Đã gửi. Hợp lệ: Tiếp tục khi bước hợp lệ → S(n+1); Quay lại → S(n−1) **giữ dữ liệu**; gửi ở S9 → Đã gửi. Không hợp lệ: nút mờ → ở nguyên bước. Quay lại ở Bước 1 và tên/số bước nhánh [CB] **không được test basis nêu** → chỉ quan sát (QO35). Kiểm thêm: đổi giá trị ở bước trước rồi đi tiếp → lưu giá trị mới.

**Khám phá (TC-09):** EXP-1 (5.12).

### 5.3 EVD — Phân vùng + Phân tích giá trị biên 50MB (cả 2 nhánh, A5)

| Biến | Phân vùng |
|---|---|
| Loại tệp (TC-13) | Ảnh (hợp lệ) · video (không hợp lệ) · tệp khác (không hợp lệ) |
| Nguồn ảnh (TC-12) | Chụp ảnh · thư viện · cả hai trong cùng vụ việc |
| Số ảnh (TC-11, 12) | 0 (đi tiếp) · 1 · nhiều (số tối đa **[MỞ QO5]** — không đặt biên) |
| GPS (TC-16) | Ảnh chụp mới · ảnh thư viện **không** GPS · ảnh thư viện **có** GPS |

**Biên 50MB (TC-14) — 3-value:** {dưới biên · đúng biên · vượt biên} = 49MB, 50MB, 51MB. **Suy luận QC:** đặc tả không nói 1MB = 10⁶ hay 2²⁰ byte; ảnh đúng biên chỉ ghi quan sát, 49MB và 51MB chấm đạt/không đạt (mục 11, G4). Thông báo khi vượt: **[MỞ QO5]**. "Gắn thời gian" (TC-15): cách gắn **[MỞ QO5]**.
Quyền iOS (TC-17) → EXP-2. Chạy chính trên [NG]; trên [CB] chỉ kiểm khói bước này (giả định A5, QO32).

### 5.4 CLS — Bảng quyết định (khu vực theo người tạo; Khẩn cấp) + phân vùng

**Bảng quyết định danh sách khu vực ở bước 2 (TC-19–22; nguồn QB2, QB3, C2, QB5):**

| Rule | Người tạo | Khu vực hiện ở bước 2 | Bước 8 | TC |
|---|---|---|---|---|
| K1 | [NG] Đội trưởng/Chỉ huy Đội | Chỉ khu vực gán cho **Đội của người tạo**; khu vực chỉ gán Đội khác không hiện | Đội = Đội mình | TC-19 |
| K2 | [NG] Trưởng CACK / Phó trưởng CACK | Khu vực của **mọi Đội** | Chọn Đội bất kỳ, **không** chặn/cảnh báo khi lệch khu vực | TC-20 |
| K3 | [CB] Phòng Camera | Chỉ khu vực của **Đội của cán bộ đó**; không phụ thuộc Đội bàn giao | Chọn được mọi Đội | TC-21 |
| K4 | [CB] Cán bộ hiện trường | Như K3 (QB5); **không có** kiểm khớp khu vực ↔ Đội nhận | Chọn được mọi Đội | TC-22 |
| K5 | K1/K3/K4 mà Đội **chưa gán khu vực** | **[MỞ QO27]** | | TC-19, 21, 22 |
| K6 | K2 mà khu vực **chưa gán Đội nào** | **[MỞ QO31]** | | TC-20 |

Phân vùng bổ sung: bước 2 (TC-18) {1 khu vực được chọn · chưa chọn}, chọn sẵn mặc định **[MỞ QO7]**. Bước 3 (TC-24, 25): {loại cha/con theo danh mục 2 cấp · loại "Khác" có tên · "Khác" để trống}, cách chọn 2 cấp **[MỞ QO8]**. **Không áp biên cho độ dài tên "Khác"** (chưa có giới hạn). TC-26: 2 phân vùng {loại có cờ "Phát hiện vật phẩm nguy hiểm" · loại không cờ} × {nhánh [NG] · [CB]}. TC-27: 3 mức {Bình thường · Nghiêm trọng · Khẩn cấp}; câu chữ ghi chú Khẩn cấp **[MỞ QO38]**. TC-23: danh mục theo cấu hình — một giá trị duy nhất, không cần kỹ thuật riêng.

### 5.5 DSC — Phân vùng

Bước 5 (TC-28, 29): "Mô tả vụ việc" {trống (mờ) · có nội dung · chỉ khoảng trắng **[MỞ QO9]** · rất dài **[MỞ QO9]** · tiếng Việt có dấu/ký tự đặc biệt}; "Vị trí cụ thể", "Hành động đã thực hiện" {trống · có nội dung}. Không biên độ dài (chưa có giới hạn). TC-30: phân vùng nguồn nhập {gõ · giọng nói} × 3 ô — chỉ kiểm văn bản được chèn đúng ô; ngưỡng chính xác không kiểm (QO21); quyền Micro **[MỞ QO6]**.

### 5.6 SUBJ — Phân vùng (ma trận) + Checklist/Đoán lỗi + Khám phá

| Biến | Phân vùng |
|---|---|
| Số đối tượng (TC-31, 41) | 0 · 1 · ≥2 (kết hợp 3 cách thêm); xoá 1 trong nhiều |
| Cách thêm (TC-33, 34, 39) | Quét giấy tờ · từ thư viện · thủ công |
| Loại giấy tờ (TC-33, 34) | CCCD gắn chip · CMND · hộ chiếu Việt Nam · hộ chiếu nước ngoài → **ma trận 4 loại × 2 cách = 8 ô**; mỗi ô kiểm các trường tự điền (hộ chiếu: số giấy tờ vào ô nào **[MỞ QO11]**) |
| Giới tính (TC-39) | Nam · Nữ · Khác |
| Quốc tịch (TC-39) | Chọn từ danh sách (danh sách **chưa được cung cấp** — §8.2) |
| Sửa trường tự điền (TC-35) | Không sửa · sửa 1 · sửa nhiều — giá trị lưu = giá trị đã sửa |
| Số lượng đối tượng (TC-32) | Khớp · không khớp số đối tượng đã nhập → đều không bị chặn (nơi lưu **[MỞ QO12]**) |

TC-37, 38 (không lưu ảnh giấy tờ / xử lý trên thiết bị): phân vùng **cách quét** {quét · thư viện} × **nơi kiểm** {Hình ảnh/Bằng chứng của Chi tiết · thư viện Ảnh iPhone **[MỞ QO11]** · lưu lượng mạng khi quét}. TC-38 cần công cụ quan sát (mục 7, 11).
**Đoán lỗi / checklist** (nguồn cụ thể, giữ từ bộ cũ): wireframe **V7** (quốc tịch nước ngoài nhập vào ô CCCD không bị chặn) và **V12** (camera chụp thường) cho TC-40, TC-36; checklist **CRE-Q05** (nút "Tra biển số") cho TC-42. Đây là nguồn gợi ý case, **không** phải kết quả mong đợi.
**Khám phá:** EXP-3 (TC-36), EXP-4 (TC-40).

### 5.7 PROP — Phân vùng + biên số lựa chọn

Bước 7 chọn nhiều trong 5 mục (TC-43): biên 2-value theo số lựa chọn {0 · 1} và {4 · 5 (tất cả)}; lưu tập đúng và hiện ở "Đề xuất xử lý của cán bộ". TC-44 "Khác": **[MỞ QO14]** → EXP-6.

### 5.8 ASG — Bảng quyết định (phạm vi giao) + biên số cán bộ + chuyển trạng thái (đổi Đội)

| Rule | Người tạo | Chọn Đội | Cán bộ hiển thị |
|---|---|---|---|
| A1 | Đội trưởng/Chỉ huy Đội | **Không** chọn được Đội khác (= Đội mình) | Chỉ cán bộ trong Đội mình |
| A2 | Phó trưởng CACK, Trưởng CACK | Chọn **đúng 1** Đội bất kỳ | Chỉ cán bộ của Đội đã chọn |
| A3 | Mọi [NG] | — | Cán bộ ngoài phạm vi **không hiển thị**; không có cán bộ của 2 Đội trong cùng vụ việc |
| A4 | Mọi [NG] | — | **Không có** nút/lựa chọn quét QR (TC-50) |

**Biên số cán bộ chọn (TC-45), 2-value:** {0 → không đi tiếp · 1 → đi tiếp}, thêm "nhiều" để kiểm chọn nhiều và bỏ chọn.
**Chuyển trạng thái đổi Đội (TC-47, Trưởng/Phó trưởng CACK):** {chưa chọn Đội · đã chọn Đội A, chưa chọn cán bộ · đã chọn Đội A + cán bộ · đã đổi sang Đội B}. Hợp lệ: chọn Đội, chọn cán bộ, đổi Đội → danh sách đổi theo Đội B. Đã chọn cán bộ Đội A rồi đổi sang B: **[MỞ QO29]**.
TC-48: phân vùng kết quả tìm {khớp đúng · không khớp · rỗng}; khớp một phần/hoa-thường/hiển thị khi không có kết quả **[MỞ QO15]**. TC-49 → EXP-7. TC-50: kiểm sự vắng mặt — một giá trị, không cần kỹ thuật riêng.

### 5.9 ACB — Bảng quyết định (bàn giao) + phân vùng QR + Khám phá

**Bảng quyết định bước 8 nhánh [CB] (TC-51–55, 78):**

| Rule | Cách chọn Đội | Chỉ định người | Kỳ vọng | TC |
|---|---|---|---|---|
| B1 | Chọn trong danh sách (mọi Đội, kể cả Đội mình) | Không | Đi tiếp, gửi được; vụ việc **Chờ tiếp nhận** | TC-51, 53, 67 |
| B2 | Chọn trong danh sách | 1 cán bộ hiện trường thuộc Đội đã chọn | Đi tiếp; vụ việc **Đang thực hiện** | TC-52, 66 |
| B3 | Chọn trong danh sách | Người thứ 2 / Phòng Camera / Văn thư / người giao / cán bộ Đội khác | **Không** chọn được (danh sách chỉ gồm cán bộ hiện trường thuộc Đội đã chọn; tối đa 1) | TC-52 |
| B4 | Chọn trong danh sách | Chính mình (hiện trường) | **[MỞ QO34]** — chỉ ghi quan sát | TC-54 |
| B5 | Chưa chọn Đội, chưa quét QR | — | Không đi tiếp; không có "không bàn giao" | TC-51 |
| B6 | Quét QR mã **cán bộ hiện trường** | (chính người được quét) | Được chỉ định; vụ việc Đang thực hiện; **không cần chọn Đội trước**. Đội nhận = Đội của người được quét **[⚑ QO42]** | TC-55 |
| B7 | Quét QR mã **không phải cán bộ hiện trường** (Phòng Camera, Văn thư, người giao) | — | Thông báo lỗi chỉ giao việc cho cán bộ hiện trường; người đó **không** được chỉ định | TC-78 |
| B8 | Quét QR mã chính mình / mã không hợp lệ / mất mạng khi tra cứu | — | **[MỞ QO43]** | TC-78 |
| B9 | Đã chọn Đội rồi quét mã cán bộ Đội khác | — | **[⚑ MỞ QO42]** — chỉ ghi quan sát | TC-55 |
| B10 | "Chọn ảnh QR" (ảnh mã trong thư viện) / "Huỷ" | — | Chọn ảnh tra cứu được như quét camera; Huỷ quay lại bước 8, không đổi Đội/người đã chọn; quyền Camera/Ảnh **[MỞ QO6, QO43]** | TC-79 |

Phân vùng loại tài khoản có mã QR để thử TC-55/78: {cán bộ hiện trường · Phòng Camera · Văn thư · người giao việc · chính mình}. Tìm cán bộ theo email hay tên; đổi Đội sau khi đã chỉ định; Đội không có cán bộ hiện trường/Đội trưởng: **[MỞ QO34]**.
**Khám phá:** EXP-9 (QR, QO42/QO43), EXP-10 (TC-54, QO34).

### 5.10 SUB — Biên hạn + phân vùng + Khám phá

**Biên thời điểm hạn ([NG], TC-57, 58)** — biên là "thời điểm hiện tại" (T). Độ chi tiết của "quá khứ" và lúc kiểm tra **[MỞ QO17]** nên **không** khẳng định đạt/không đạt sát biên:

| Giá trị | Kỳ vọng | Trạng thái |
|---|---|---|
| Ngày hôm qua | Không chọn được | XĐ (BR06) |
| Hôm nay, giờ < T | Không chọn được | XĐ (BR06) |
| Hôm nay, giờ sát T | Quan sát | **[MỞ QO17]** |
| Hôm nay, giờ > T | Chọn được | XĐ |
| Mặc định 17:00 khi hôm nay còn trước 17:00 | Giờ mặc định 17:00, đổi được | XĐ ([B8]) |
| Mặc định khi hôm nay đã quá 17:00 | Quan sát | **[MỞ QO17]** |
| Ngày rất xa trong tương lai | Chọn được, không giới hạn tối đa | XĐ (BR06) |
| Hạn hợp lệ lúc chọn nhưng đã qua lúc bấm gửi | Quan sát | **[MỞ QO17]** |

Hạn đã chọn → lưu thành "Hạn" của từng phần việc và "Hạn xử lý" của vụ việc. TC-59: phân vùng múi giờ thiết bị {UTC+7 · múi giờ khác} — **[MỞ QO17]** → EXP-8.
TC-56, 64: phân vùng bộ dữ liệu {**tối thiểu**: chỉ trường bắt buộc theo nhánh · **đầy đủ**: mọi trường tuỳ chọn có dữ liệu} × {[NG] · [CB]} → dữ liệu hiện đúng ở màn xem lại và Chi tiết. TC-60 ([CB]): kiểm không có chọn hạn; tóm tắt hiện Đội nhận và người được chỉ định (nếu có); nội dung tóm tắt/nhãn nút **[MỞ QO35]**. TC-61: một giá trị (chỉ có nút gửi). TC-62: phân vùng {1 lần gửi · xen kẽ XL01 và GV01} × {[NG] · [CB]} → mã VV + 6 chữ số, không trùng (BR38). TC-63 → EXP-5.

### 5.11 POST và NOTI — Bảng quyết định (ai thấy gì, ai nhận gì) + phân vùng + chuẩn tính nhắc việc

**Trạng thái ban đầu và nơi hiển thị (TC-65–70):**

| Rule | Nhánh / điều kiện | Trạng thái ban đầu | Ai thấy ở đâu | TC |
|---|---|---|---|---|
| V1 | [NG] | Đang thực hiện; mỗi cán bộ chỉ định 1 phần việc Đã giao/Chưa bắt đầu; "Giao việc 0/y" | Người tạo: Tiếp nhận + Của tôi; người giao khác cùng Đội của vụ việc: Tiếp nhận; từng cán bộ chỉ định: Của tôi; cán bộ không chỉ định, người giao Đội khác: không thấy; tài khoản cán bộ không có tab Tiếp nhận. Trưởng/Phó trưởng CACK tạo: **[⚑ QO25]** | TC-65, 68 |
| V2 | [CB] có chỉ định | Đang thực hiện, **không có hạn** (hiển thị Hạn/Nhắc việc: **[MỞ QO36]**) | **Người tạo**: Của tôi, không có thao tác; **Đội trưởng Đội người tạo (A)**: Tiếp nhận, mở được Chi tiết, có nút "Hoàn tất xử lý"; **Đội trưởng Đội nhận (B)**: Tiếp nhận, có nút "Hoàn tất xử lý"; **cán bộ chỉ định**: Của tôi; Đội trưởng Đội không liên quan và cán bộ khác (kể cả cùng Đội A/B nhưng không được chỉ định): **không thấy** | TC-66, 69 |
| V3 | [CB] không chỉ định | **Chờ tiếp nhận** | Đội trưởng Đội nhận: Tiếp nhận với nhãn "Chờ tiếp nhận", "Cần xử lý", nút nhanh "Tiếp nhận"; Chi tiết có nút "Thao tác"; Đội trưởng Đội người tạo: như V2; Đội trưởng Đội không liên quan: không thấy; bộ đếm "Giao việc x/y": **[MỞ QO36]**; thẻ/nút nhanh của Đội trưởng Đội A: **[MỞ QO44]** | TC-67, 69 |
| V4 | Đội A = Đội B | Không khác (QB4(d)) | Gộp vai trò Đội trưởng A/B | TC-69 |
| V5 | [CB] người tạo mở vụ việc của mình | — | **Không có thao tác**: không Gia hạn, Phân công lại, Phân công tiếp, Huỷ phần việc, Hoàn thành, Hoàn tất xử lý, Thao tác. Nút Lịch sử, thêm ảnh bằng chứng: **[MỞ QO45]** | TC-70 |

XL01 chỉ kiểm **sự có mặt/vắng mặt** của nút; hành vi nút thuộc luồng xử lý (QO44).

**Bảng quyết định thông báo ([CB], TC-72; nguồn C8, D1):**

| Rule | Người | Nhận? | Ghi chú |
|---|---|---|---|
| N1 | Đội trưởng Đội người tạo | Có | Đội người tạo = Đội nhận: 1 hay 2 thông báo, tiêu đề **[MỞ QO37]** |
| N2 | Đội trưởng Đội nhận (kể cả khi không chỉ định, D1) | Có | Đội nhận khi dùng QR: **[⚑ QO42]** |
| N3 | Cán bộ được chỉ định | Có ("Bạn có phần việc mới") | |
| N4 | Mọi người khác | Không | |

**[NG] (TC-71):** mỗi cán bộ chỉ định nhận **đúng 1** thông báo "Bạn có phần việc mới" (tab Thông báo, chưa đọc in đậm), mở được phần việc; người không chỉ định không nhận; không qua SMS (BR17).

**Bảng quyết định cảnh báo Khẩn cấp (TC-73; nguồn G1, F3, E8):**

| Rule | Mức độ | Điều kiện Đội nhận | Người nhận cảnh báo |
|---|---|---|---|
| E1 | Khẩn cấp | Có Phó trưởng CACK phụ trách | Phó trưởng CACK phụ trách Đội nhận |
| E2 | Khẩn cấp | **Chưa có** Phó trưởng phụ trách | Đội trưởng và Đội phó của Đội nhận ("Đội phó" là vai trò nào: **[MỞ QO38]**) |
| E3 | Khẩn cấp | Mọi | **Trưởng CACK không nhận**; Phó trưởng CACK phụ trách Đội khác (kể cả Đội người tạo khi khác Đội nhận) không nhận |
| E4 | Bình thường / Nghiêm trọng | Mọi | Không gửi cảnh báo Khẩn cấp |
| E5 | Khẩn cấp, người tạo là chính người nhận (vd Phó trưởng CACK tạo cho Đội mình phụ trách) | | **[MỞ QO30]** |

Áp dụng cả hai nhánh; "ưu tiên cao, không bắt buộc xác nhận" giữ theo A6 (**[MỞ QO38]**). Đội nhận khi dùng QR: **[⚑ QO42]**.

**Chuẩn tính nhắc việc ([NG], TC-74):** thời điểm nhắc = giao + 2/3 × (hạn − giao). Ví dụ BR11: giao 14:15 ngày 21/10, hạn 17:00 ngày 22/10 → nhắc khoảng 08:05 ngày 22/10 (sai số cho phép theo ví dụ ≤ 10 giây). Phân vùng khoảng cách hạn−giao {ngắn trong ngày · qua đêm · nhiều ngày}. Công thức "suy ra" từ ảnh — cần khách hàng xác nhận khi nghiệm thu. **[CB] không có hạn → không áp dụng (E3), không kiểm.**

**Nhật ký (TC-75):** [NG] mỗi phần việc 1 dòng "Giao việc" (giờ · người thực hiện · hành động), không sửa/xoá; [CB] không chỉ định có mốc "Gửi tiếp nhận" kèm vai trò và Đội người tạo (quan sát ảnh, chưa có mô tả nghiệp vụ); [CB] có chỉ định/quét QR ghi mốc gì: **[MỞ QO40]**; 1 hay 2 bản ghi: **[MỞ QO19]**.
**Đội/Tổ trên thẻ (TC-76):** phân vùng {1 cán bộ · nhiều cùng Tổ · nhiều khác Tổ · vụ việc Chờ tiếp nhận chưa có người được giao}; Nguồn phát hiện theo người tạo: **[MỞ QO26]**.
**Thống kê (TC-77):** phân vùng {người dùng Đội của vụ việc · Đội không liên quan} × {Tổng vụ việc · Chờ tiếp nhận (nay có thể ≠ 0) · Khẩn cấp mở · Vụ việc theo khu vực}; [CB] Đội A → Đội B tính cho Đội nào: **[MỞ QO39]**; Đội nhận qua QR **[⚑ QO42]**.

### 5.12 Khám phá (session-based) — chỉ cho phần test basis **thừa nhận chưa biết** kết quả

Mỗi charter ứng với câu hỏi mở đã được QC lead cho mang sang. Kết quả phiên chỉ ghi **hành vi quan sát được** (kèm ảnh/video), không chấm đạt/không đạt. *(Thời lượng phiên: QC đề xuất 30–45 phút, QC lead duyệt.)*

| Charter | Mục tiêu phiên | TC | QO | Gợi ý nguồn |
|---|---|---|---|---|
| EXP-1 | Đóng màn, vuốt thoát, chuyển nền, đóng app giữa 9 bước ở các bước khác nhau, cả 2 nhánh: dữ liệu giữ hay mất, có hỏi xác nhận không | TC-09 | QO4 | Wireframe V10 |
| EXP-2 | Từ chối/cho phép quyền Camera, Ảnh, Micro ở bước 1, 5, 6 và màn quét QR: thông báo, dẫn tới Cài đặt, luồng có tiếp tục được không (thêm: quyền Thông báo iOS — mục 11 G6) | TC-17 (+30, 79) | QO6 | — |
| EXP-3 | Nhận dạng giấy tờ thất bại (ảnh mờ, thiếu sáng, không phải giấy tờ, bị che): app báo gì, trường điền thiếu, số hộ chiếu vào ô nào, ảnh quét có vào thư viện Ảnh không | TC-36 (+37) | QO11 | Wireframe V12 |
| EXP-4 | Quy tắc hợp lệ trường đối tượng: đối tượng rỗng, định dạng ngày sinh, ký tự số giấy tờ, quốc tịch nước ngoài ở ô CCCD | TC-40 | QO10 | Wireframe V7 |
| EXP-5 | Bấm gửi nhiều lần, mạng chập chờn, lỗi máy chủ (cả 2 nhánh): có tạo trùng vụ việc/phần việc/thông báo không; dữ liệu giữ để gửi lại không | TC-63 (+06) | QO18 | — |
| EXP-6 | Ô nhập tự do: mô tả chỉ khoảng trắng, rất dài, ký tự đặc biệt; đề xuất "Khác" có ô nhập không | TC-29, 44 | QO9, QO14 | — |
| EXP-7 | Người giao tự giao cho mình, giao cho người giao khác: có được không | TC-49 | QO16 | — |
| EXP-8 | Hạn khi thiết bị đặt múi giờ khác: hiển thị, lưu, so với giờ Việt Nam | TC-59 | QO17 | — |
| EXP-9 | Bàn giao bằng QR: Đội nhận là Đội nào; đã chọn Đội rồi quét mã Đội khác; quét mã chính mình, mã không hợp lệ, mất mạng khi "Đang tra cứu cán bộ…"; nội dung thông báo lỗi; ảnh hưởng tới thông báo Đội trưởng, cảnh báo Khẩn cấp, thống kê | TC-55, 78 (+72, 73, 77) | QO42, QO43 | Ảnh `03_case-create_09_assignee_qr-scan` |
| EXP-10 | Bước 8 [CB]: tìm cán bộ theo email hay tên; hiện trường tự chỉ định chính mình; đổi Đội sau khi đã chỉ định; Đội không có cán bộ hiện trường / không có Đội trưởng (vụ việc có bị "kẹt" không); ghi nhận nút nào hiện ở chi tiết vụ việc của người tạo và Đội trưởng Đội A/B (Lịch sử, thêm ảnh, Hoàn tất xử lý, Thao tác) — **chỉ ghi nhận có mặt/vắng mặt** | TC-54, 52, 69, 70 | QO34, QO44, QO45 | Ảnh `case-list_pending`, `case-detail_pending` |

### 5.13 Kỹ thuật **không** dùng và vì sao

- Không dùng bảng quyết định cho TC-23, 43, 50, 61 — chỉ 1–2 biến độc lập hoặc một giá trị.
- Không dùng biên cho độ dài văn bản (mô tả, tên loại "Khác", biển số, số giấy tờ) — test basis chưa nêu giới hạn.
- Không dùng chuyển trạng thái cho vòng đời phần việc sau khi tạo (Đang làm, Hoàn thành…) — thuộc flow `04`, `07`.
- Không dùng chuyển trạng thái cho luồng tiếp nhận tại Đội của vụ việc [CB] — ngoài phạm vi; XL01 chỉ kiểm **trạng thái ban đầu** (bảng V1–V3).
- Không dùng kỹ thuật nào cho nhắc việc/quá hạn của nhánh [CB] — GAP (E3), không có hạn để kiểm.

---

## 6. Risk-based prioritization

**Cách tính (ISTQB §5.2.1):** risk level = risk likelihood × risk impact. Thang: Cao×Cao, Cao×Vừa, Vừa×Cao → **P1**; Vừa×Vừa, Thấp×Cao, Cao×Thấp → **P2**; Vừa×Thấp, Thấp×Vừa, Thấp×Thấp → **P3**. Nhãn lấy **nguyên** từ test-analysis, không xếp lại.

**Căn cứ (QC lead đã chấp nhận ngày 2026-10-28, QO41 đóng):**
- **A1 — likelihood:** ước lượng của QC theo độ phức tạp kỹ thuật và **độ ổn định của yêu cầu** (nhánh [CB] đổi 3 lần trong 2 ngày: L7 → L7a → E1/F1; mâu thuẫn trực tiếp với câu chữ đặc tả hiện hành; chưa có ảnh nhánh [CB] ở nhiều bước). Dự án chưa có lịch sử lỗi → là giả định đã được chấp thuận, **không phải số liệu đo**.
- **A2 — impact:** suy từ mục tiêu §2.1 ("không thiếu thông tin trong quá trình giao nhận"), tính nhạy cảm dữ liệu đối tượng (§8.1, BR29) và việc vụ việc bị "kẹt" (không ai thấy/không ai xử lý) khi bàn giao sai. Cùng tình trạng chấp thuận.
- Nếu sau này có lịch sử lỗi hoặc đánh giá business impact của khách hàng → xếp hạng lại.
- Đây là **product risk** (lỗi chức năng/an ninh ảnh hưởng người dùng); **project risk** ở mục 7–11.

**Phân bố ưu tiên (tổng 79 test condition):**

| Nhóm | P1 | P2 | P3 | Tổng |
|---|---|---|---|---|
| AUTH | 5 | 1 | 0 | 6 |
| NAV | 1 | 2 | 1 | 4 |
| EVD | 1 | 5 | 1 | 7 |
| CLS | 5 | 3 | 2 | 10 |
| DSC | 1 | 1 | 1 | 3 |
| SUBJ | 8 | 1 | 3 | 12 |
| PROP | 0 | 0 | 2 | 2 |
| ASG | 3 | 3 | 0 | 6 |
| ACB | 5 | 2 | 0 | 7 |
| SUB | 6 | 2 | 1 | 9 |
| POST | 6 | 0 | 0 | 6 |
| NOTI | 3 | 4 | 0 | 7 |
| **Cộng** | **44** | **24** | **11** | **79** |

Danh sách: **P1** = TC-01–04, 06, 10, 12, 19, 21, 22, 24, 26, 28, 33–40, 45–47, 51–53, 55, 57, 58, 60, 62–73, 78 · **P2** = TC-05, 08, 09, 13–17, 20, 25, 27, 29, 41, 48–50, 54, 56, 59, 74–77, 79 · **P3** = TC-07, 11, 18, 23, 30, 31, 32, 42, 43, 44, 61.

**Vì sao mỗi P1 có impact cao (không chỉ dán nhãn):**

| TC | Likelihood | Risk | Impact cao vì |
|---|---|---|---|
| 01 | Vừa | Cao | Người giao không vào được luồng chính tạo vụ việc → vỡ luồng chính |
| 02, 03 | Cao | Cao | Quyền mới theo L6 (đảo ngược đặc tả); sai thì cán bộ hiện trường/Phòng Camera không tạo được vụ việc hiện trường hoặc ngược lại |
| 04 | Vừa | Cao | Văn thư vượt quyền tạo vụ việc chứa dữ liệu cá nhân nhạy cảm |
| 06 | Vừa | Cao | Mất mạng mà mất/ghi sai dữ liệu vụ việc trong ca trực liên tục |
| 10 | Cao | Cao | Nút sáng sai theo nhánh (hạn, Đội, cán bộ) → gửi thiếu trường bắt buộc, hoặc bắt buộc thừa chặn cán bộ bàn giao |
| 12 | Vừa | Cao | Mất bằng chứng ảnh của vụ việc |
| 19 | Vừa | Cao | Người giao thấy/chọn khu vực của Đội khác → sai phạm vi quyền |
| 21, 22 | Cao | Vừa | Cán bộ thấy sai khu vực (Phòng Camera: C2; hiện trường: QB5) → vụ việc gắn sai khu vực, sai thống kê và báo cáo; nhánh mới, likelihood cao |
| 24 | Vừa | Cao | Sai loại → sai báo cáo theo loại (CH06) và cờ biểu mẫu |
| 26 | Vừa | Cao | Sai cờ → thiếu/thừa biểu mẫu và chữ ký (XL03), kể cả vụ việc [CB] |
| 28 | Vừa | Cao | Mô tả bắt buộc bị mất/lưu sai → vụ việc thiếu thông tin |
| 33, 34 | Cao | Cao | Nhận dạng sai → dữ liệu đối tượng sai (nhạy cảm, dùng lại ở biên bản) |
| 35 | Vừa | Cao | Giá trị lưu khác giá trị người dùng đã sửa → sai dữ liệu đối tượng |
| 36 | Cao | Vừa | Nhận dạng thất bại gây dữ liệu sai hoặc treo luồng |
| 37 | Vừa | Cao | Lưu ảnh giấy tờ trái [Q18] → vi phạm bảo mật dữ liệu cá nhân |
| 38 | Vừa | Cao | Ảnh giấy tờ gửi lên máy chủ trái [B13] → lộ dữ liệu cá nhân |
| 39, 40 | Vừa | Cao | Đối tượng lưu sai/không kiểm hợp lệ → dữ liệu nhạy cảm sai |
| 45 | Vừa | Cao | Giao nhầm hoặc không giao được → vụ việc không tới người nhận |
| 46 | Vừa | Cao | Giao ngoài phạm vi §3.2 → vượt quyền |
| 47 | Vừa | Cao | Vụ việc lẫn cán bộ 2 Đội → sai Đội phụ trách, sai quyền xem |
| 51 | Cao | Cao | Đội nhận sai/thiếu → vụ việc [CB] không tới đúng Đội, bị "kẹt"; quy tắc đổi 3 lần |
| 52 | Cao | Cao | Chỉ định sai người (Phòng Camera, Văn thư, Đội khác, hơn 1 người) → giao ngoài phạm vi |
| 53 | Vừa | Cao | Chặn gửi khi không chỉ định → cán bộ không bàn giao được vụ việc, vỡ luồng chính của nhánh [CB] |
| 55 | Cao | Cao | Cơ chế mới, 1 ảnh, quyết định Đội nhận và người xử lý; Đội nhận còn ⚑ |
| 78 | Vừa | Cao | Chỉ định nhầm người không phải cán bộ hiện trường qua QR → giao ngoài phạm vi |
| 57, 58 | Vừa | Cao | Hạn lưu sai/hạn quá khứ lọt qua → sai nhắc việc, quá hạn ngay khi tạo |
| 60 | Vừa | Cao | Nhánh [CB] hiện/chặn nhầm bước hạn → không gửi được hoặc gửi sai |
| 62 | Vừa | Cao | Mã trùng/vụ việc trùng → mất khả năng truy xuất |
| 63 | Vừa | Cao | Gửi nhiều lần/lỗi mạng tạo trùng vụ việc, phần việc, thông báo |
| 64 | Vừa | Cao | Mất dữ liệu 9 bước → trái mục tiêu §2.1 |
| 65 | Vừa | Cao | Trạng thái ban đầu sai → vỡ vòng đời phần việc |
| 66 | Cao | Cao | Vụ việc [CB] có chỉ định sai trạng thái/phần việc → người được chỉ định không thấy việc |
| 67 | Cao | Cao | Vụ việc Chờ tiếp nhận không tới đúng Đội trưởng → không ai xử lý; Đội trưởng Đội khác thấy dữ liệu cá nhân |
| 68 | Vừa | Cao | Sai người thấy vụ việc → lộ dữ liệu cá nhân đầy đủ của đối tượng (BR29) |
| 69 | Cao | Cao | Quyền xem dữ liệu cá nhân của 4 nhóm người, quy tắc khác đặc tả BR35 |
| 70 | Vừa | Cao | Người tạo [CB] có thao tác quản lý vượt quyền (C5) |
| 71 | Vừa | Cao | Cán bộ không nhận thông báo → bỏ sót phần việc |
| 72 | Cao | Cao | Đội trưởng không nhận thông báo → vụ việc [CB] không được xử lý; gửi nhầm người |
| 73 | Cao | Cao | Cảnh báo Khẩn cấp sai người hoặc không gửi → chậm xử lý vụ việc nghiêm trọng; quy tắc G1 mới thay QB1(d) |

**Thứ tự chạy gợi ý (§5.1.5, gợi ý của QC):** AUTH → NAV (TC-10) → ASG → ACB → SUB (TC-62, 63) → POST → NOTI → EVD → SUBJ → CLS → còn lại. P1 trước; P1 có KQ mong đợi XĐ/MỘT PHẦN trước P1 **MỞ** (TC-36, 40, 63).

**Ước lượng test case:** các nhóm có ma trận (AUTH 6 vai trò, SUBJ 8 ô giấy tờ, POST/NOTI nhiều người xem, ACB 10 rule) cho số test case cao hơn số test condition; số chính xác chốt ở bước test-case.

---

## 7. Test environment matrix

Tất cả hạng mục chưa có thông tin đều ghi là **điều kiện chờ** — không bịa.

| Hạng mục | Yêu cầu | Trạng thái |
|---|---|---|
| Nền tảng | **iPhone** (L4). Android ngoài phạm vi | Chốt |
| Model iPhone | Chưa xác định | **Chờ** (QO23) |
| Phiên bản iOS | Chưa xác định (đặc tả: "phiên bản tối thiểu chưa định") | **Chờ** (QO23) |
| Build mục tiêu | Chưa xác định. Ảnh QC lead gửi 2026-10-28 ghi build ❓ | **Chờ** |
| Số thiết bị | ≥ 2 thiết bị chạy đồng thời; nhiều tài khoản (người tạo, cán bộ được chỉ định, Đội trưởng Đội người tạo, Đội trưởng Đội nhận, người không liên quan) — số thiết bị thực tế **chờ QC lead** | **Chờ** |
| Mạng | Wi-Fi và 4G; ngắt/chập chờn mạng có kiểm soát (TC-06, 63, 78) | Cần |
| Thông báo | Quyền thông báo iOS của app bật (tắt/bật: mục 11 G6) | Cần |
| Quyền iOS | Camera, Ảnh, Micro: kiểm cả cho phép và từ chối (EXP-2) | Cần |
| Múi giờ | Đổi được múi giờ thiết bị (EXP-8) | Cần |
| Công cụ | Quan sát lưu lượng mạng khi quét giấy tờ (TC-38) hoặc nhật ký máy chủ do dev cung cấp | **Chưa có** (mục 11, G5) |

**Dữ liệu cần quản trị viên chuẩn bị trước (baseline) — chưa có xác nhận là đã chuẩn bị:**

| Nhóm | Nội dung |
|---|---|
| Tài khoản theo Vai trò | Đội trưởng/Chỉ huy Đội (≥1 ở **Đội A**, ≥1 ở **Đội B**); Trưởng CACK; Phó trưởng CACK (≥1 phụ trách Đội nhận, ≥1 phụ trách Đội khác); cán bộ hiện trường (≥2 mỗi Đội A, B; trong đó ≥2 cùng Đội khác Tổ); cán bộ Phòng Camera (thuộc 1 Đội, kèm 1 Đội mà khu vực khác Đội nhận); cán bộ Văn thư; 1 tài khoản Đội **không liên quan** (Đội C) |
| Đội/Khu vực | ≥2–3 Đội, mỗi Đội gán **bộ khu vực khác nhau**; 1 Đội **chưa gán khu vực** (QO27); 1 khu vực **chưa gán Đội nào** (QO31) |
| Phó trưởng CACK phụ trách | Đội **có** và Đội **không có** Phó trưởng phụ trách (TC-73; G1) — **chưa có thông tin về cấu hình hiện có** |
| Đội đặc biệt | Đội không có cán bộ hiện trường; Đội không có Đội trưởng (QO34, EXP-10) — nếu quản trị viên dựng được |
| Mã QR | "Mã QR của tôi" của từng loại tài khoản (hiện trường, Phòng Camera, Văn thư, người giao, chính người tạo); ảnh mã QR trong thư viện; mã không hợp lệ |
| Danh mục | Loại vụ việc 2 cấp, có "Khác"; 1 loại có cờ biểu mẫu "Phát hiện vật phẩm nguy hiểm" và ≥1 loại không cờ; 5 đề xuất xử lý; danh sách quốc tịch (**chưa cung cấp** — §8.2) |
| Ảnh bằng chứng | Ảnh 49MB, ~50MB, 51MB; ảnh có GPS, không GPS; 1 video và 1 tệp không phải ảnh |
| Giấy tờ **mẫu giả** | 4 loại: CCCD gắn chip, CMND, hộ chiếu Việt Nam, hộ chiếu nước ngoài (bản để quét camera và ảnh để chọn từ thư viện); thêm ảnh mờ, thiếu sáng, không phải giấy tờ. **Nguồn bộ mẫu giả chưa xác định (QO23)**; tuyệt đối không dùng giấy tờ thật |
| Dữ liệu đối tượng giả | Họ tên, ngày sinh, số giấy tờ do QC bịa, không trùng người thật |

---

## 8. Entry criteria

Theo §5.1.3 (áp dụng cho **bước chạy test**; bước thiết kế test case chỉ cần test plan READY).

| Nhóm | Tiêu chí | Trạng thái hiện tại |
|---|---|---|
| Tài nguyên | iPhone + iOS + **build mục tiêu** đã xác định và cài được | **Chờ** (QO23) |
| Tài nguyên | Tài khoản theo Vai trò, Đội, khu vực, Phó trưởng CACK phụ trách (có/không có), mã QR, danh mục ở mục 7 đã được quản trị viên chuẩn bị; QC xác nhận đăng nhập được | **Chờ** — chưa có thông tin |
| Tài nguyên | Bộ giấy tờ mẫu giả + ảnh thử đã có | **Chờ** (QO23) |
| Tài nguyên | Công cụ/nhật ký để kiểm TC-38, hoặc có quyết định chuyển TC-38 sang "không kiểm được" | **Chờ** (mục 11, G5) |
| Testware | Test plan READY (đạt, có điều kiện) và `test-cases-dac-ta-v2.1-lam-ro-10-28.md` được duyệt | Plan đạt; test-case chưa có |
| Testware | Mỗi test case ghi rõ trạng thái KQ mong đợi (XĐ/MỘT PHẦN/MỞ), các điểm ⚑ và QO liên quan | Yêu cầu cho test-case |
| Testware | QC lead duyệt ngưỡng exit criteria (mục 9) và thời lượng phiên khám phá | **Chờ QC lead** |
| Chất lượng test object | Smoke: đăng nhập được; [NG] đi hết 9 bước và gửi được 1 vụ việc tối thiểu; [CB] đi hết các bước và gửi được 1 vụ việc không chỉ định | Chưa chạy |
| Quản trị | Không có mâu thuẫn mới của test basis chưa được QC lead quyết định (điều kiện dừng ở 8.1) | Đạt tại thời điểm lập |
| Quản trị | Nếu chạy luồng tiếp nhận/xử lý của vụ việc [CB] ngoài XL01: QO44 đã được làm rõ | **Chờ** |

### 8.1 Suspension và Resumption

| Điều kiện dừng | Phạm vi dừng | Điều kiện chạy lại |
|---|---|---|
| Smoke fail: không gửi được vụ việc tối thiểu ở một nhánh | Nhánh đó (hoặc toàn bộ nếu cả hai) | Build mới pass smoke; chạy lại từ đầu |
| Sai nghiêm trọng quyền: Văn thư tạo được vụ việc; người ngoài phạm vi (Đội trưởng Đội không liên quan, cán bộ không được chỉ định) thấy dữ liệu đối tượng; chỉ định được người không phải cán bộ hiện trường | Dừng AUTH, ASG, ACB, POST | Bug sửa; chạy lại **từ đầu cụm đã dừng**, không tiếp giữa chừng |
| Ảnh giấy tờ bị lưu hoặc gửi lên máy chủ (TC-37/38 fail) | Dừng SUBJ; **báo ngay** | Bug sửa; chạy lại SUBJ từ đầu |
| Thông báo đẩy không tới (hạ tầng thông báo hỏng) hoặc mất dữ liệu baseline (tài khoản, Đội, khu vực, mã QR) | Dừng NOTI, POST và các nhóm phụ thuộc | Baseline dựng lại và xác nhận |
| Phát hiện mâu thuẫn **mới** của test basis ảnh hưởng scope/priority, hoặc QC lead trả lời một câu hỏi mở theo hướng đổi scope (vd QO32, QO44) | Dừng nhóm liên quan, báo orchestrator/QC lead | Có xác nhận bằng văn bản; cập nhật test plan (slug mới nếu đổi vật chất) |

---

## 9. Exit criteria

*(Ngưỡng là **đề xuất của QC**, đang chờ QC lead duyệt.)*

**Đo lường:**
- 100% test case P1 đã chạy; 100% P2 đã chạy; P3: đã chạy hoặc có ghi chú lý do hoãn.
- Số bug **P1 mở = 0**; mọi bug P2 mở có quyết định chấp nhận hoặc kế hoạch sửa.
- Mọi test condition **XĐ** và phần xác định của **MỘT PHẦN**: có kết quả đạt/không đạt.
- Mọi test condition **MỞ** và phần **còn mở**: có **ghi nhận hành vi quan sát** (ảnh/video) — **không** tính là "đạt" hay "không đạt"; báo cáo cuối liệt kê riêng.
- Các phần ⚑ (QO25, QO42): đã ghi quan sát; **không** tính vào tỷ lệ đạt.
- Coverage: mọi TC-01–79 được ánh xạ tới ≥1 test case (traceability); 10 charter EXP đã chạy.

**Nhị phân:**
- Regression theo 3.1 đã chạy trên build cuối.
- Mọi câu hỏi ở mục 10 có trong báo cáo cuối: đã có trả lời (và expected cập nhật) **hoặc** được QC lead chấp nhận là gap đã biết.
- QO44 có trả lời (hoặc chấp nhận là gap) **trước** khi lập kế hoạch luồng tiếp nhận/xử lý.
- Điểm mục 11 (G1–G12) đã có quyết định (kiểm, hoãn, hoặc chấp nhận).

---

## 10. Gap cần làm rõ trước khi execute

Tất cả 40 câu mở dưới đây **mang sang đúng theo quyết định QC lead 2026-10-26 và 2026-10-28** ("Mang sang, chạy tiếp", gồm QO42–QO45): chỉ đổi **kết quả mong đợi**, không thêm/bớt test condition, không đổi ưu tiên → **không chặn READY**. Test case **không** được tự suy ra câu trả lời. QO1, QO20, QO24, QO41 đã đóng; QO2 hoãn (F2).

| QO | Câu hỏi (rút gọn) | TC | Ảnh hưởng scope/ưu tiên? |
|---|---|---|---|
| QO3 | Tab Tiếp nhận có nút +? Cán bộ hiện trường/Phòng Camera có nút + ở tab Của tôi? | 01, 02, 03 | Không (chỉ expected) |
| QO4 | Thoát/chuyển nền giữa chừng: giữ hay huỷ, có hỏi? | 09 | Không (EXP-1) |
| QO5 | Số ảnh tối đa; xoá ảnh; thông báo >50MB; "gắn thời gian"; GPS ảnh thư viện | 12, 14, 15, 16 | Không |
| QO6 | Từ chối quyền Camera/Ảnh/Micro | 17, 30, 79 | Không (EXP-2) |
| QO7 | Bước 2 chọn sẵn mục đầu? | 10, 18 | Không |
| QO8 | Loại 2 cấp chọn thế nào; "Khác": bắt buộc, độ dài, có biểu mẫu? | 24, 25, 26 | Không |
| QO9 | Mô tả chỉ khoảng trắng; độ dài tối đa | 28, 29 | Không (EXP-6) |
| QO10 | Quy tắc hợp lệ trường đối tượng; danh sách quốc tịch | 39, 40 | Không (EXP-4) |
| QO11 | Nhận dạng thất bại; hộ chiếu vào ô nào; ảnh quét vào thư viện Ảnh? | 33, 34, 36, 37 | Không (EXP-3) |
| QO12 | "Số lượng đối tượng" lưu/hiển thị ở đâu | 32 | Không |
| QO13 | Nút "Tra biển số" ẩn hay giữ | 42 | Không |
| QO14 | Đề xuất "Khác" có ô nhập? | 44 | Không (EXP-6) |
| QO15 | Tìm email: khớp một phần, hoa/thường, không kết quả | 48 | Không |
| QO16 | [NG] tự giao cho mình; giao cho người giao khác | 49 | Không (EXP-7) |
| QO17 | Hạn: quá 17:00; kiểm lúc chọn hay lúc gửi; phút; múi giờ | 57, 58, 59 | Không (EXP-8 cho TC-59) |
| QO18 | Mất mạng: giữ dữ liệu; lỗi máy chủ; chống trùng | 06, 63 | Không (EXP-5) |
| QO19 | Nội dung phần việc lấy từ đâu; "Giao việc" vs "Phân công" là 1 hay 2 bản ghi | 64, 75 | Không |
| QO21 | Ngưỡng chính xác nhận dạng; chỉ tiêu hiệu năng | 30, 33, 34 | Không — đã loại khỏi tiêu chí (mục 3 #10, mục 11 G2) |
| QO22 | (Tài liệu) Sửa câu §8.1 "sửa được, không xoá" | (XL05) | Không — chỉ câu chữ |
| QO23 | Model iPhone, iOS, build; nguồn giấy tờ mẫu giả | Môi trường; 33, 34 | Không với scope test; **chặn entry criteria để chạy test** |
| QO25 | ⚑ Vụ việc do Trưởng/Phó trưởng CACK tạo hiện ở Tiếp nhận của ai | 68 | Không — không dùng làm tiêu chí |
| QO26 | Đội/Tổ trên thẻ (kể cả Chờ tiếp nhận chưa có người được giao); Nguồn phát hiện (ảnh hiện "Phòng Camera", trái [B14]) | 64, 76 | Không |
| QO27 | Đội chưa gán khu vực: bước 2 hiện gì (kể cả Đội của Phòng Camera) | 19, 21, 22 | Không |
| QO28 | (Tài liệu) Sửa [B7], BR16, CH07, XL01-B2/B8/B9, §3.1–3.4, BR01, BR04, BR36, [Q4], [Q31], [B25*], §4.2, CH05, [B4], [B19], [Q5] cho khớp quyết định | 02, 03, 10, 60, 73, 77 | Không — chỉ câu chữ tài liệu |
| QO29 | Trưởng/Phó trưởng CACK đổi Đội sau khi chọn cán bộ | 47 | Không |
| QO30 | Phó trưởng CACK tạo Khẩn cấp cho Đội mình phụ trách có tự nhận cảnh báo không | 73 | Không |
| QO31 | "Khu vực của mọi Đội" có gồm khu vực chưa gán Đội | 20 | Không |
| QO32 | Bước 1, 3–7 khi cán bộ tạo có giống người giao (giả định A5)? | 11–18, 23–44 | **Theo dõi:** plan chạy chính trên [NG], kiểm khói trên [CB]. Nếu trả lời "khác" → phát sinh test condition mới → cần bổ sung plan. QC lead đã cho mang sang |
| QO33 | Đổi Vai trò có hiệu lực ngay hay lần đăng nhập sau; đang giữa 9 bước | 05 | Không |
| QO34 | [CB] bước 8: tìm theo email hay tên; hiện trường tự chỉ định chính mình; đổi Đội sau khi chỉ định; Đội không có cán bộ hiện trường/Đội trưởng | 51, 52, 54 | Không (EXP-10) |
| QO35 | [CB] bước cuối: còn "Bước 9/9"; tóm tắt hiện gì; nhãn nút gửi | 07, 10, 60 | Không |
| QO36 | Vụ việc không có hạn: hiển thị Hạn/NHẮC VIỆC/KẾT QUẢ; Hạn xử lý; bộ đếm "Giao việc x/y" khi Chờ tiếp nhận | 66, 67 | Không |
| QO37 | Đội người tạo = Đội nhận: Đội trưởng nhận 1 hay 2 thông báo; tiêu đề | 72 | Không |
| QO38 | Khẩn cấp: "Đội phó" là vai trò nào; ghi chú "Cảnh báo Lãnh đạo + BCH đội" có đổi; còn "ưu tiên cao, không bắt buộc xác nhận"? | 27, 73 | Không |
| QO39 | Vụ việc [CB] Đội A → Đội B tính thống kê cho Đội nào | 77 | Không |
| QO40 | [CB] có chỉ định/quét QR: Diễn biến xử lý ghi mốc gì; người thực hiện ở Lịch sử | 75 | Không |
| QO42 | ⚑ Đội nhận khi quét QR = Đội của cán bộ được quét? Đã chọn Đội rồi quét mã Đội khác: đổi Đội hay báo lỗi? Ảnh hưởng thông báo C8, cảnh báo G1, thống kê | 10, 51, 55, 72, 73, 77 | Không — partition ⚑ không dùng làm tiêu chí |
| QO43 | QR: mã chính mình, mã không hợp lệ, mất mạng khi tra cứu, nội dung thông báo lỗi, từ chối quyền Camera | 78, 79 | Không (EXP-9) |
| QO44 | "Hoàn tất xử lý" = "Hoàn thành"/"Đã hoàn thành"? Có nhập kết quả? Dùng được khi Chờ tiếp nhận? Mở rộng C5? Đội trưởng Đội A có thêm nút nào? Thẻ/nút nhanh hiện gì? | 67, 69 | **Không đổi scope XL01** (chỉ kiểm sự có mặt). **Phải làm rõ trước khi** lập kế hoạch luồng tiếp nhận/xử lý |
| QO45 | Người tạo "không có thao tác gì": gồm Lịch sử, thêm ảnh bằng chứng? | 70 | Không |

**Đối chiếu 5 lý do dừng ở mục 0 của skill:** (1) thiếu/mơ hồ/mâu thuẫn ảnh hưởng scope-risk — mọi mâu thuẫn nguồn đã có quyết định QC lead (mục 1.2); các QO chỉ đổi expected. QO32 là điểm sát nhất (nếu trả lời "khác" sẽ đổi scope) nhưng QC lead đã cho mang sang và plan đã thiết kế theo A5 → ghi "Theo dõi", không chặn; (2) nhiều version — đã chốt thứ tự ưu tiên 4 nguồn, câu sau thay câu trước; (3) không đủ info P1 vs P2/P3 — 79/79 test condition có likelihood/impact kèm căn cứ A1/A2 đã được chấp nhận; (4) không chắc kỹ thuật — mỗi nhóm đã chọn kỹ thuật, nơi chưa biết đáp án dùng khám phá (EXP-1…10); (5) phạm vi quá rộng — một use case 9 bước, 79 test condition, 12 nhóm, chạy trên iPhone; luồng tiếp nhận/duyệt/đóng/huỷ phần việc đã loại khỏi phạm vi → không cần tách plan.

---

## 11. Coverage gap — case chưa được test basis liệt kê (QC tự phát hiện, **suy luận của QC**)

| # | Thiếu gì | Vì sao là gap | Đề xuất |
|---|---|---|---|
| G1 | Kết quả có **lưu vào trang quản trị chung** và nhật ký đồng bộ về đó | Tính năng 1 "Kết quả" và CH07 nói có; trang quản trị ngoài phạm vi → không kiểm | Không tạo test; ghi trong báo cáo cuối |
| G2 | Hiệu năng; ngưỡng độ chính xác nhận dạng giấy tờ/giọng nói | §10 "đề xuất, chờ duyệt"/chưa có ngưỡng (QO21) | Chỉ kiểm chức năng; không tiêu chí về ngưỡng |
| G3 | Android | Ngoài phạm vi đợt (L4) | Cần plan riêng khi có bản Android |
| G4 | Biên "50MB" chưa định nghĩa (1MB = 10⁶ hay 2²⁰ byte) | Biên TC-14: ảnh đúng biên mơ hồ | Chỉ chấm 49MB và 51MB; đúng biên ghi quan sát; hỏi cùng QO5 |
| G5 | Cách **kiểm TC-38** (ảnh giấy tờ không gửi lên máy chủ) | Cần công cụ quan sát lưu lượng mạng hoặc nhật ký máy chủ; chưa có. P1 | Entry criteria; nếu không có, QC lead quyết định TC-38 chuyển "không kiểm được" |
| G6 | Quyền **Thông báo** của iOS (tắt/bật), app chạy nền/đã đóng khi nhận "Bạn có phần việc mới", thông báo cho Đội trưởng, cảnh báo Khẩn cấp | QO6 chỉ nêu Camera/Ảnh/Micro; TC-71–73 phụ thuộc thông báo đẩy | Thêm vào EXP-2; hỏi dev (không đổi ưu tiên hiện có) |
| G7 | Số lượng lớn ảnh/đối tượng trong một vụ việc | Test basis không nêu giới hạn (QO5 chỉ hỏi ảnh) → rủi ro treo/chậm | Một phiên khám phá tuỳ chọn; không thuộc 79 TC |
| G8 | Hai người tạo vụ việc đồng thời (mã VV không trùng) | BR38 nói chung chuỗi; TC-62 chỉ xen kẽ XL01/GV01 tuần tự | Bổ sung case nếu chạy được 2 thiết bị cùng lúc |
| G9 | **Hạn, nhắc việc, quá hạn, kết quả đúng hạn của vụ việc [CB]** | E3 tạm bỏ; không có màn đặt hạn | Không tạo test cho tới khi QC lead mở lại E3 |
| G10 | Khác biệt quyền Tổ trưởng/Tổ phó/Phó Đội trưởng/uỷ quyền; vai trò uỷ quyền với nhánh [CB] | Hoãn theo F2 | Không tạo test; plan bổ sung khi F2 đổi |
| G11 | **Bảo mật mã QR** ("Mã QR của tôi"): mã có hết hạn/đổi theo phiên không; mã chứa gì; chụp màn hình rồi dùng lại | Test basis chỉ nói "mã định danh"; bàn giao QR quyết định người xử lý (QO42, QO43) | Hỏi dev cùng QO43; EXP-9 ghi quan sát |
| G12 | **Vụ việc [CB] "kẹt"**: Chờ tiếp nhận ở Đội không có Đội trưởng, hoặc Đội chỉ có cán bộ Văn thư/Phòng Camera; Đội trưởng nghỉ/đổi Đội | A2 (vụ việc kẹt) nhưng test basis không nói ai thấy | EXP-10 ghi quan sát; hỏi QC lead nếu thấy kẹt |

---

## 12. Báo cáo tóm tắt cho orchestrator

- **Test Plan Status: READY (có điều kiện)** — 40 câu mở chỉ đổi expected, không đổi scope/ưu tiên; ⚑ QO25, QO42 không chấm; QO44 phải làm rõ trước khi lập kế hoạch luồng tiếp nhận/xử lý. **Chưa đủ điều kiện chạy test**: thiếu model/iOS/build, tài khoản theo Vai trò, Đội có/không có Phó trưởng phụ trách, mã QR, giấy tờ mẫu giả, công cụ TC-38.
- 12 nhóm (AUTH, NAV, EVD, CLS, DSC, SUBJ, PROP, ASG, ACB, SUB, POST, NOTI); 79 test condition: **P1 44 · P2 24 · P3 11**; KQ mong đợi XĐ 21 · MỘT PHẦN 48 · MỞ 10.
- Bước tiếp theo: orchestrator quyết định gọi skill **test-case** trên `test-plan-dac-ta-v2.1-lam-ro-10-28.md`; đánh dấu SUPERSEDED bộ cũ `*-dac-ta-v2.1.md` (cần đổi tên thủ công nếu áp dụng hậu tố `-SUPERSEDED`).
