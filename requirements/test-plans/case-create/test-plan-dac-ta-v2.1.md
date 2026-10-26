# Test Plan — Tạo vụ việc xử lý vi phạm (XL01, flow `03_case-create`) — theo đặc tả v2.1

> **Test Plan Status: READY (có điều kiện — đọc mục "Điều kiện đi kèm" ngay dưới)** · Ngày lập 2026-10-26.
> Căn cứ: không có banner DRAFT; mục 10 có 29 câu hỏi mở nhưng **không câu nào đổi scope hoặc priority** — chỉ đổi kết quả mong đợi (QC lead đã quyết định ngày 2026-10-26 cho mang sang dưới dạng "còn mở"; QO24 đã đóng, căn cứ risk A1/A2 đã được chấp nhận). Chưa có gap nào trùng 5 lý do dừng bắt buộc ở mục 0 của skill.

> **Điều kiện đi kèm (không được bỏ khi thiết kế test case / chạy test):**
> 1. Test condition có trạng thái kết quả mong đợi **"MỞ"** hoặc phần **"còn mở"** (mục 2.1) → expected result ghi nguyên văn là *"còn mở — chỉ ghi lại hành vi quan sát được"*; **không** bịa giá trị, **không** chấm đạt/không đạt phần đó.
> 2. Nhánh **⚑ suy ra QO25** (vụ việc do Trưởng/Phó trưởng CACK tạo hiện ở tab Tiếp nhận của Đội được chọn — và, theo cách QC đọc QO25, cả ở tab Tiếp nhận của chính người tạo) **KHÔNG dùng làm tiêu chí đạt/không đạt**; chỉ ghi quan sát.
> 3. READY ở đây nghĩa là **đủ điều kiện để thiết kế test case**. Điều kiện **để chạy test** (model iPhone, iOS, build, giấy tờ mẫu giả, công cụ quan sát lưu lượng mạng…) còn thiếu — xem mục 8, mục 10 (QO23) và mục 11.

> **Test basis (thứ tự ưu tiên khi mâu thuẫn — QC lead chốt 2026-10-26):**
> 1. [dac-ta-chuc-nang-v2.1.md](../../specs/xu-ly-vi-pham-giao-viec/dac-ta-chuc-nang-v2.1.md) — XL01 và các phần áp dụng: §1.2, §2.4 Tính năng 1, §3, §4.1–4.2, §5 (XL01), §8, §9, §10, CH07, Phụ lục A/B/C. Ngày bàn giao: đưa vào repo 2026-10-26; build/nhánh: không nêu.
> 2. [lam-ro-2026-10-26.md](../../specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-26.md) — quyết định của QC lead, gồm QB1(a)–(d), QB2, QB3. **Riêng cảnh báo Khẩn cấp (QB1(d)) khác đặc tả [B7]** — QC lead chọn dùng quyết định này (ngoại lệ có chủ đích với thứ tự ưu tiên).
> 3. [mo-ta-chuc-nang-v1.md](../../specs/xu-ly-vi-pham-giao-viec/mo-ta-chuc-nang-v1.md) — chỉ dùng khi đặc tả không nói.
>
> **Chuẩn:** ISTQB Foundation Level v4.0.1 (test basis → test object → kỹ thuật thiết kế → rủi ro → entry/exit)
> **Test analysis đầu vào:** [test-analysis-dac-ta-v2.1.md](test-analysis-dac-ta-v2.1.md) (Analysis Status READY, 65 test condition: P1 34 · P2 20 · P3 11). Mã `TC-nn` và `QOnn` trong tài liệu này **trích đúng** từ file đó; `QBn` = câu hỏi chặn đã trả lời.
> **Test case cụ thể:** [test-cases-dac-ta-v2.1.md](test-cases-dac-ta-v2.1.md) — sẽ sinh bởi skill test-case sau khi orchestrator xác nhận test plan này.
> **Đối chiếu tài liệu đã có:** wireframe [03_case-create.md](../../ui/ux/wideframes/03_case-create.md) và checklist [03_case-create.md](../../exploratory/03_case-create.md) (cả hai lập **trước** đặc tả, có banner cảnh báo — không phải test basis); [test-analysis-mo-ta-v1-SUPERSEDED.md](test-analysis-mo-ta-v1-SUPERSEDED.md) (đã thay thế); `bugs/bug-log.md` (hiện **rỗng** → không có bug cũ cần regression); chưa có test plan nào khác của dự án CACK (hình thức tham khảo từ `3ada18a:.../test-plan-ios26-27.md`, không lấy nội dung).
> **Dữ liệu cá nhân:** chỉ dùng giấy tờ và dữ liệu đối tượng **mẫu giả**; không chép dữ liệu thật từ ảnh trong spec.
> **Người lập:** QC

---

## 1. Phát hiện khi đối chiếu với tài liệu đã có

Không có test plan cũ của feature này (không có gì để đánh dấu superseded; không cần sửa file nào khác).

| # | Tài liệu cũ | Điểm đối chiếu | Kết luận cho test plan này |
|---|---|---|---|
| 1 | `test-analysis-mo-ta-v1-SUPERSEDED.md` (dựa mô tả v1, **đã bị thay thế**) | Bản v1 có 7 câu hỏi chặn (B1–B7) + 19 câu hỏi mở (O1–O19). Đặc tả v2.1 trả lời phần lớn; phần còn lại chuyển thành QB1–QB3 (đã trả lời) và QO1–QO31 | Dùng test-analysis v2.1 làm nguồn. Không dùng lại mã câu hỏi cũ |
| 2 | `lam-ro` L2b ("chỉ Tổ phó đã được uỷ quyền") | Mâu thuẫn đặc tả §3.1/§3.3 | QC lead chọn **theo đặc tả**: Tổ phó là vai trò người giao đầy đủ; "uỷ quyền Tổ phó" cấp cho một **cán bộ** → TC-02, TC-03 |
| 3 | `lam-ro` L3a(a) (ký lại bắt buộc lý do) | Đặc tả XL04 không nhắc | **Bỏ**; thuộc flow `05_record-signing`, không có test condition ở đây |
| 4 | `lam-ro` bảng đối chiếu dòng L4 | Ghi đặc tả "không nêu hệ điều hành" — **sai**; §10 và [Q32] ghi "iOS và Android" | Đã sửa trong `lam-ro`. Đợt này chỉ iPhone (L4); Android ngoài phạm vi (mục 3) |
| 5 | Đặc tả [B7] (cảnh báo Khẩn cấp → "Chỉ huy Đội và lãnh đạo trực tiếp") | Khác quyết định QB1(d) | **Dùng QB1(d):** Trưởng CACK, Phó trưởng CACK **và** Chỉ huy Đội của vụ việc (TC-26). Đề nghị sửa đặc tả (QO28) |
| 6 | Đặc tả XL01-B2, §3.2, BR36, giả định [B25*] (giới hạn khu vực theo tài khoản, chỉ Tổ trưởng/Phó đội trưởng) | Khác trả lời QB2 | **Dùng QB2/QB3:** khu vực theo **Đội**, mọi người giao cấp Đội như nhau; Trưởng/Phó trưởng CACK thấy khu vực của mọi Đội (TC-20, TC-65). Không còn test condition nào dựa vào [B25*] |
| 7 | Wireframe V1–V12, checklist CRE-Q01–Q05 | Lập trước đặc tả; nhiều điểm đã được đặc tả/QB trả lời (xem test-analysis mục 6.3) | Chỉ dùng làm **nguồn cho error guessing / checklist** khi test basis im lặng (V3, V7, V9, V10, V12, CRE-Q05), có trích nguồn ở mục 5. Không dùng làm kết quả mong đợi |
| 8 | Test analysis — số câu hỏi mở | Caller và test-analysis ghi 29 câu (QO1–QO19, QO21–QO23, QO25–QO31); `lam-ro` ghi "30 câu hỏi (QO1–QO19, QO21–QO31)" — chênh 1 do tính cả QO24 (đã đóng) | Dùng **29 câu**. Chênh lệch chỉ là cách đếm, không đổi nội dung; đề nghị sửa `lam-ro` khi có dịp (không chặn) |

---

## 2. Test object — In scope

Phạm vi: **XL01 trên ứng dụng di động iPhone** và hậu điều kiện của nó (tab Tiếp nhận/Của tôi, phần việc Đã giao, thông báo, nhắc việc, nhật ký, thống kê Trang chủ). 65 test condition chia thành **10 nhóm** (mã nhóm = tiền tố ID cho test-case, dạng `TC-<MÃ>-NN`).

| # | Mã nhóm | Hạng mục | TC (từ test-analysis) | Nguồn test basis | Ghi chú |
|---|---|---|---|---|---|
| 1 | **AUTH** | Quyền tạo vụ việc theo vai trò; mất mạng khi gửi | TC-01–07 | XL01 Tác nhân/Tiền điều kiện/Kích hoạt; §3.1, §3.3, §3.4; BR01, BR17, BR34; [Q2, Q4, Q31, Q32, B2] | Cần tài khoản đủ 6 vai trò + cán bộ uỷ quyền + thường + Phòng Camera (quản trị viên chuẩn bị) |
| 2 | **NAV** | Điều hướng 9 bước, tính bắt buộc từng bước | TC-08–11 | XL01 (Quay lại, Tiếp tục); BR04; PL-C #3; L3a(b) | TC-11 dạng bảng quyết định |
| 3 | **EVD** | Bước 1 — Hình ảnh/Bằng chứng | TC-12–18 | XL01-B1; BR20; [Q20, B12] | TC-18 dùng chung bước 6. Ảnh hưởng chéo XL05 |
| 4 | **CLS** | Bước 2–4 — Khu vực, Loại, Mức độ; cảnh báo Khẩn cấp; nhánh Trưởng/Phó trưởng CACK | TC-19–26, **TC-65** | XL01-B2/B3/B4; §8.2; BR16, BR21; QB1(d), QB2, QB3 | TC-65 vừa liên quan bước 8 (ASG) nhưng gán vào CLS vì là đối ứng của TC-20 |
| 5 | **DSC** | Bước 5 — Mô tả | TC-27–29 | XL01-B5; §10; [B13]; L3a(b) | |
| 6 | **SUBJ** | Bước 6 — Thông tin đối tượng | TC-30–41 | XL01-B6; §8.1; BR18, BR19, BR29; [Q17, Q18, Q35, B13, B16] | Cần bộ giấy tờ **mẫu giả** cho 4 loại |
| 7 | **PROP** | Bước 7 — Đề xuất xử lý | TC-42–43 | XL01-B7; §8.2 | |
| 8 | **ASG** | Bước 8 — Giao việc, phạm vi giao | TC-44–48 | XL01-B8; §3.2, §3.4; BR02; PL-C #1; QB1(a)(c) | |
| 9 | **SUB** | Bước 9 — Hạn, xem lại, gửi | TC-49–56 | XL01-B9, Hậu điều kiện; BR06, BR38; [B1, B8, Q4] | TC-54 ảnh hưởng chéo GV01 |
| 10 | **POST** | Hậu điều kiện: trạng thái, hiển thị tab, thông báo, nhắc việc, nhật ký, Đội/Tổ trên thẻ, thống kê | TC-57–64 | XL01 Hậu điều kiện; §4.1–4.2; CH07; BR03, BR11, BR27, BR32, BR35; [B24, Q14]; QB1(b)(c)(d) | TC-59 có partition ⚑ QO25 |

### 2.1 Bảng 65 test condition: nhóm, ưu tiên, trạng thái kết quả mong đợi

Quy ước cột **KQ mong đợi** (QC phân loại theo mục 5 test-analysis và quyết định 2026-10-26):
**XĐ** = xác định được từ test basis · **MỘT PHẦN** = phần chính xác định, phần chi tiết còn mở (ghi QO) · **MỞ** = chủ yếu còn mở → chỉ ghi lại hành vi quan sát được.

| TC | Nội dung rút gọn | Nhóm | Ưu tiên | KQ mong đợi | QO liên quan |
|---|---|---|---|---|---|
| 01 | 6 vai trò thấy nút +, mở "Bước 1/9" | AUTH | P1 | MỘT PHẦN | QO3 (nút + ở tab Tiếp nhận) |
| 02 | Tổ phó tạo được, không cần uỷ quyền | AUTH | P1 | XĐ | — |
| 03 | Cán bộ được uỷ quyền Tổ phó tạo được | AUTH | P1 | XĐ | — |
| 04 | Cán bộ thường không tạo được | AUTH | P1 | MỘT PHẦN | QO1 (cách chặn nút + Trang chủ) |
| 05 | Phòng Camera không tạo được | AUTH | P1 | MỘT PHẦN | QO2 (Camera + uỷ quyền) |
| 06 | Thu hồi uỷ quyền → mất quyền | AUTH | P1 | MỘT PHẦN | QO2 (hiệu lực, đang giữa chừng) |
| 07 | Mất mạng: không gửi, không lưu nháp | AUTH | P1 | MỘT PHẦN | QO18 (giữ dữ liệu để gửi lại) |
| 08 | Thanh "Bước n/9", tên bước | NAV | P3 | XĐ | — |
| 09 | Quay lại giữ dữ liệu; đổi giá trị lưu giá trị mới | NAV | P2 | XĐ | — |
| 10 | Đóng/thoát/chuyển nền giữa chừng | NAV | P2 | **MỞ** | QO4 |
| 11 | Nút Tiếp tục/Giao việc và gửi theo BR04 | NAV | P1 | MỘT PHẦN | QO7 (bước 2 chọn sẵn?) |
| 12 | Đi tiếp khi chưa có ảnh | EVD | P3 | XĐ | — |
| 13 | Thêm ảnh (chụp/thư viện), "Bằng chứng: n tệp", lưu cùng vụ việc | EVD | P1 | MỘT PHẦN | QO5 (số ảnh tối đa, xoá ảnh) |
| 14 | Chỉ nhận ảnh | EVD | P2 | XĐ | — |
| 15 | Giới hạn 50MB mỗi ảnh | EVD | P2 | MỘT PHẦN | QO5 (thông báo khi vượt) |
| 16 | Ảnh gắn thời gian | EVD | P2 | MỘT PHẦN | QO5 (cách gắn) |
| 17 | Ảnh lưu không có toạ độ GPS | EVD | P2 | MỘT PHẦN | QO5 (ảnh thư viện có GPS) |
| 18 | Từ chối quyền Camera/Ảnh iOS | EVD | P2 | **MỞ** | QO6 |
| 19 | Bước 2 chọn 1 khu vực, lưu đúng | CLS | P3 | MỘT PHẦN | QO7 |
| 20 | Khu vực theo Đội của người tạo (người giao cấp Đội) | CLS | P1 | MỘT PHẦN | QO27 (Đội chưa gán khu vực), QO28 (câu chữ) |
| 21 | Danh mục theo cấu hình quản trị | CLS | P3 | XĐ | — |
| 22 | Loại hai cấp, lưu loại cha + con | CLS | P1 | MỘT PHẦN | QO8 |
| 23 | Loại "Khác" nhập tay | CLS | P2 | MỘT PHẦN | QO8 |
| 24 | Loại có cờ biểu mẫu → khối Biểu mẫu và chữ ký | CLS | P1 | MỘT PHẦN | QO8 (loại "Khác" có biểu mẫu?) |
| 25 | Mức độ 3 giá trị, lưu, lọc, ghi chú Khẩn cấp | CLS | P2 | XĐ | — |
| 26 | Khẩn cấp: thông báo ưu tiên cao đúng người nhận | CLS | P1 | MỘT PHẦN | QO30 (người tạo trùng người nhận); QO28 (câu chữ đặc tả) |
| 27 | Mô tả bắt buộc; 2 ô còn lại tuỳ chọn; lưu đúng | DSC | P1 | MỘT PHẦN | QO9 (chỉ khoảng trắng) |
| 28 | Khoảng trắng, độ dài, tiếng Việt có dấu/ký tự đặc biệt | DSC | P2 | **MỞ** | QO9 |
| 29 | Nhập giọng nói ở 3 ô bước 5 | DSC | P3 | MỘT PHẦN | QO6 (quyền Micro), QO21 (ngưỡng — không kiểm) |
| 30 | Không có đối tượng vẫn gửi được | SUBJ | P3 | XĐ | — |
| 31 | "Số lượng đối tượng" không cần khớp | SUBJ | P3 | MỘT PHẦN | QO12 (lưu/hiển thị ở đâu) |
| 32 | Quét giấy tờ tự điền đúng, 4 loại | SUBJ | P1 | MỘT PHẦN | QO11, QO21 (ngưỡng chính xác không kiểm) |
| 33 | Từ thư viện tự điền đúng, 4 loại | SUBJ | P1 | MỘT PHẦN | QO11, QO21 |
| 34 | Trường tự điền sửa được; lưu giá trị đã sửa | SUBJ | P1 | XĐ | — |
| 35 | Nhận dạng thất bại / điền thiếu | SUBJ | P1 | **MỞ** | QO11 |
| 36 | Không lưu ảnh giấy tờ | SUBJ | P1 | MỘT PHẦN | QO11 (thư viện Ảnh iPhone) |
| 37 | Nhận dạng chạy trên thiết bị (ảnh không gửi lên máy chủ) | SUBJ | P1 | XĐ | — (cần công cụ kiểm: mục 8, 11) |
| 38 | Thêm đối tượng thủ công, 6 trường lưu đúng | SUBJ | P1 | XĐ | — |
| 39 | Quy tắc hợp lệ trường đối tượng | SUBJ | P1 | **MỞ** | QO10 |
| 40 | Nhiều đối tượng, xoá; CCCD hiển thị đầy đủ | SUBJ | P2 | XĐ | — |
| 41 | Biển số xe, Đơn vị liên quan | SUBJ | P3 | MỘT PHẦN | QO13 (nút "Tra biển số") |
| 42 | Đề xuất xử lý chọn 0/1/nhiều | PROP | P3 | XĐ | — |
| 43 | Đề xuất "Khác": ô nhập nội dung | PROP | P3 | **MỞ** | QO14 |
| 44 | Tìm và chọn ≥1 cán bộ; bắt buộc ≥1 | ASG | P1 | XĐ | — |
| 45 | Phạm vi giao theo vai trò | ASG | P1 | XĐ | — |
| 46 | Đúng 1 Đội; danh sách cán bộ lọc theo Đội | ASG | P1 | MỘT PHẦN | QO29 (đổi Đội khi đã chọn cán bộ) |
| 47 | Tìm cán bộ theo email | ASG | P2 | MỘT PHẦN | QO15 |
| 48 | Tự giao cho mình / giao cho người có quyền giao | ASG | P2 | **MỞ** | QO16 |
| 49 | Màn xem lại tóm tắt đúng | SUB | P2 | XĐ | — |
| 50 | Chọn hạn; mặc định 17:00; lưu đúng | SUB | P1 | MỘT PHẦN | QO17 (quá 17:00 hôm nay) |
| 51 | Hạn không ở quá khứ; không giới hạn tối đa | SUB | P1 | MỘT PHẦN | QO17 (kiểm lúc chọn hay lúc gửi, độ chi tiết phút) |
| 52 | Hạn theo giờ Việt Nam khi thiết bị khác múi giờ | SUB | P2 | **MỞ** | QO17 |
| 53 | Bước 9 chỉ có "Giao việc và gửi" | SUB | P3 | XĐ | — |
| 54 | Tạo đúng 1 vụ việc, mã VV+6 chữ số, không trùng, chung chuỗi với GV01 | SUB | P1 | XĐ | — |
| 55 | Bấm gửi nhiều lần / mạng chập chờn / lỗi máy chủ | SUB | P1 | **MỞ** | QO18 |
| 56 | Toàn bộ dữ liệu 9 bước, thời gian, người tạo hiện đúng ở Chi tiết | SUB | P1 | MỘT PHẦN | QO19 (nguồn NỘI DUNG phần việc) |
| 57 | Trạng thái ban đầu; bộ đếm "Giao việc 0/y" | POST | P1 | XĐ | — |
| 58 | Hiển thị tab Tiếp nhận / Của tôi theo vai trò | POST | P1 | MỘT PHẦN | QO25 (partition người tạo là Trưởng/Phó trưởng CACK — ⚑ không chấm) |
| 59 | Tiếp nhận của mọi người giao trong Đội của vụ việc | POST | P1 | MỘT PHẦN | **QO25 ⚑** (partition Trưởng/Phó trưởng CACK — không chấm) |
| 60 | Thông báo "Bạn có phần việc mới" đúng người, đúng 1 lần | POST | P1 | XĐ | — |
| 61 | Thời điểm nhắc việc = giao + 2/3 × (hạn − giao) | POST | P2 | MỘT PHẦN | Căn cứ BR11 một phần "suy ra" — cần khách hàng xác nhận khi nghiệm thu (§1.4) |
| 62 | Nhật ký "Giao việc" từng phần việc | POST | P2 | MỘT PHẦN | QO19 (tên hành động, 1 hay 2 bản ghi) |
| 63 | Đội/Tổ trên thẻ = của cán bộ được giao | POST | P2 | MỘT PHẦN | QO26 |
| 64 | Thống kê Trang chủ cập nhật theo Đội | POST | P2 | XĐ | — |
| 65 | Trưởng/Phó trưởng CACK: khu vực mọi Đội, chọn Đội bất kỳ, không chặn lệch khu vực | CLS | P2 | MỘT PHẦN | QO31 (khu vực chưa gán Đội nào) |

**Thống kê trạng thái KQ mong đợi:** XĐ 22 · MỘT PHẦN 34 · MỞ 9 (tổng 65). Trong 9 điều kiện MỞ có **3 điều kiện P1** (TC-35, TC-39, TC-55).

---

## 3. Out of scope

| # | Hạng mục | Lý do |
|---|---|---|
| 1 | **Android** | Đặc tả §10/[Q32] nói iOS và Android, nhưng QC lead chốt L4 "tạm thời chỉ chạy trên iPhone" — phạm vi **đợt test**, không phải phạm vi sản phẩm |
| 2 | **Trang quản trị web** (cấu hình danh mục, tài khoản, uỷ quyền, gán khu vực cho Đội; nơi "lưu kết quả vào trang quản trị chung", đồng bộ nhật ký) | Đặc tả §1.2, [Q37*]: ngoài phạm vi. Chỉ là **tiền điều kiện / dữ liệu kiểm thử** do quản trị viên chuẩn bị (A4). Việc kết quả có lưu về trang quản trị không kiểm được → mục 11 |
| 3 | Nút "Xử lý tại chỗ và hoàn thành" | Đặc tả §1.2, [Q4]: đã bỏ khỏi bước 9 (chỉ kiểm là **không có** — TC-53) |
| 4 | Tra cứu biển số tự động | [Q35]: chưa có (chỉ kiểm nhập tay; nút "Tra biển số": QO13) |
| 5 | Chỉ tiêu hiệu năng §10 ("đề xuất", chờ khách hàng duyệt); **ngưỡng** độ chính xác nhận dạng giấy tờ/giọng nói | Chưa duyệt / chưa có ngưỡng → không dùng làm tiêu chí đạt/không đạt (QO21). Chức năng nhận dạng **vẫn được test** (TC-29, 32, 33) |
| 6 | Ký lại biên bản, bắt buộc lý do khi ký lại (L3a(a)) | Đã bỏ theo quyết định QC lead |
| 7 | Xử lý, hoàn thành, biên bản, báo cáo hằng ngày, thao tác điều phối | Thuộc flow khác (XL02–XL05, CH01–CH06) — chỉ ghi **ảnh hưởng chéo** ở 3.1 |
| 8 | Phần "sửa được" ở §8.1 | Mâu thuẫn nội bộ với BR31/XL05 đã được đặc tả tự xử lý (PL-C #13); thuộc XL05; chỉ đề nghị sửa câu chữ (QO22) |
| 9 | Sao lưu, lưu trữ, số người dùng đồng thời | Đặc tả §10 [B17]: bỏ qua giai đoạn này |
| 10 | Nghiệm thu với khách hàng (§1.4) | Là bước sau test hệ thống; chỉ lưu ý vài điểm "suy ra" cần khách hàng xác nhận (BR11, BR09) |

### 3.1 Ảnh hưởng chéo tới flow khác (theo flow map `screenshot-naming.md` §7)

| Flow | Ảnh hưởng? | Lý do |
|---|---|---|
| `01_login` | Gián tiếp | Phiên đăng nhập, vai trò, tài khoản do quản trị viên tạo là tiền điều kiện; quyền uỷ quyền/thu hồi (TC-06) có thể cần đăng nhập lại (QO2) |
| `02_home` | **Trực tiếp** | Nút + ở Trang chủ (TC-01, 04); thống kê Trang chủ cập nhật sau khi tạo (TC-64, CH05) |
| `03_case-create` | — (flow đang test) | |
| `04_case-handling` | **Trực tiếp** | Tab Tiếp nhận/Của tôi/Thông báo, Chi tiết vụ việc, Lịch sử hiển thị dữ liệu XL01 (TC-13, 27, 56–63). Cần chạy lại khi flow này đổi |
| `05_record-signing` | **Trực tiếp** | Loại có cờ biểu mẫu quyết định khối "Biểu mẫu và chữ ký" (TC-24); dữ liệu đối tượng được dùng lại ở biên bản (TC-38, 39, 40) |
| `06_task-assign` | Gián tiếp | Chung chuỗi mã VV với GV01 (TC-54); phải phân biệt nút + tạo vụ việc với option Giao việc [Q1]; Đội/phạm vi giao dùng chung §3.2 |
| `07_case-actions` | **Trực tiếp** | Phần việc, hạn, người được giao do XL01 tạo là đầu vào của Gia hạn, Phân công lại/tiếp (loại trừ cán bộ đang phụ trách), Huỷ; hạn đổi → nhắc việc tính lại |
| `08_daily-report` | Gián tiếp | Vụ việc mới vào báo cáo hằng ngày (CH06, theo loại hai cấp/khu vực) — ngoài phạm vi đợt này; TC-22, TC-19 là nguồn dữ liệu |
| `09_web-admin` | Gián tiếp (tiền điều kiện) | Danh mục, tài khoản, uỷ quyền, khu vực gán cho Đội cấu hình tại đây; nơi nhận kết quả đồng bộ — ngoài phạm vi, không kiểm |

---

## 4. Test levels và test types

| Khía cạnh | Nội dung |
|---|---|
| **Test level** | **System test** trên ứng dụng iPhone (luồng 9 bước từ đầu đến cuối, nhiều vai trò). **Integration test (tích hợp hệ thống)** ở phần phụ thuộc dịch vụ nền: thông báo đẩy (TC-26, 60), nhắc việc (TC-61), nhật ký (TC-62), đồng bộ giữa nhiều tài khoản/thiết bị (TC-58, 59, 64). Không có component/unit test (không có mã nguồn). Acceptance (nghiệm thu khách hàng) nằm ngoài kế hoạch này |
| **Functional** | Tính đúng của chức năng: quy tắc bắt buộc/hợp lệ, lưu dữ liệu, hiển thị, giao việc, hậu điều kiện (đa số TC) |
| **Non-functional** (ISO 25010) | **Security** — kiểm soát truy cập theo vai trò (TC-01–06, 20, 45, 46, 58, 59, 65), bảo mật dữ liệu cá nhân (TC-17, 36, 37); **Reliability** — mất mạng, gửi trùng, nhận dạng thất bại (TC-07, 35, 55, 10); **Usability** — nhãn bước, giọng nói (TC-08, 29); **Compatibility** — quyền hệ thống iOS (TC-18). **Không** có performance (chỉ tiêu chưa duyệt — QO21), portability (chỉ iPhone) |
| **Change-related** | **Confirmation:** chạy lại case khi bug sửa xong. **Regression:** không có bug cũ (bug-log rỗng). Khi có bản build mới: chạy lại P1 của nhóm bị ảnh hưởng + chuỗi hậu điều kiện POST; khi flow `04`/`05`/`07` đổi: chạy lại TC-24, 38–40, 56–63 (xem 3.1) |

---

## 5. Kỹ thuật thiết kế test case

Kỹ thuật chọn cho **từng nhóm**. Nguồn "suy luận QC" được đánh dấu rõ. Kết quả mong đợi còn mở ghi **[MỞ]** — test case chỉ ghi nhận quan sát.

### 5.1 AUTH — Decision Table (quyền tạo vụ việc) + EP (kết nối mạng)

Lý do: quyền là **tổ hợp** vai trò × trạng thái uỷ quyền × phòng ban → Decision Table. Mất mạng chỉ là phân vùng có/không mạng → EP.

| Rule | Tài khoản | Uỷ quyền Tổ phó | Phòng Camera | Kỳ vọng | TC |
|---|---|---|---|---|---|
| R1a–f | Mỗi vai trò trong 6 vai trò người giao (Đội trưởng/Chỉ huy Đội, Tổ trưởng, Tổ phó, Phó đội trưởng, Phó trưởng CACK, Trưởng CACK) — **6 tài khoản riêng** | Không cần (Tổ phó: R1c) | Không | Có nút + (Trang chủ, tab Của tôi), mở được "Bước 1/9" | TC-01, TC-02 |
| R2 | Cán bộ | Có, đang hiệu lực | Không | Được tạo | TC-03 |
| R3 | Cán bộ thường | Không | Không | Không có nút + ở tab Của tôi; nút + Trang chủ: **[MỞ QO1]** | TC-04 |
| R4 | Cán bộ | Không | Có | Không tạo được | TC-05 |
| R5 | Cán bộ | Có | Có | **[MỞ QO2]** ([Q31] hay §3.3 thắng) | TC-05 |
| R6 | Cán bộ | Đã bị thu hồi | Không | Không tạo được; thời điểm hiệu lực và trường hợp đang giữa 9 bước **[MỞ QO2]** | TC-06 |

EP kết nối (TC-07): {có mạng · mất mạng trước khi mở màn · mất mạng giữa các bước · mất mạng đúng lúc bấm "Giao việc và gửi"}. Kỳ vọng xác định: không gửi được, không lưu nháp ngoại tuyến; giữ dữ liệu để gửi lại **[MỞ QO18]**. *(Các thời điểm mất mạng là gợi ý của QC.)*

### 5.2 NAV — Decision Table (BR04) + State Transition (9 bước) + Exploratory

**Decision Table nút Tiếp tục theo BR04** (TC-11): mỗi dòng kiểm 2 phân vùng {để trống / hợp lệ}.

| Bước | Trường | Bắt buộc | Để trống → nút | Hợp lệ → nút |
|---|---|---|---|---|
| 1 | Hình ảnh/Bằng chứng | Không | Sáng | Sáng |
| 2 | Khu vực | Có | Mờ (nếu có chọn sẵn mặc định thì luôn sáng **[MỞ QO7]**) | Sáng |
| 3 | Loại vụ việc | Có | Mờ (loại "Khác" để trống tên **[MỞ QO8]**) | Sáng |
| 4 | Mức độ | Có | Mờ | Sáng |
| 5 | Mô tả vụ việc | Có | Mờ | Sáng; chỉ khoảng trắng **[MỞ QO9]** |
| 5 | Vị trí cụ thể; Hành động đã thực hiện | Không | Sáng | Sáng |
| 6 | Đối tượng, số lượng, biển số, đơn vị | Không | Sáng | Sáng |
| 7 | Đề xuất xử lý | Không | Sáng | Sáng |
| 8 | Đội + cán bộ | Có (Đội, ≥1 cán bộ) | Mờ nếu 0 cán bộ | Sáng nếu ≥1 |
| 9 | Hạn | Có | "Giao việc và gửi" mờ nếu hạn không hợp lệ | Sáng |

**State Transition (TC-09, TC-08):** trạng thái S1…S9 (Bước 1…9) và Đã gửi.
- Hợp lệ: Tiếp tục khi bước hợp lệ → S(n+1); Quay lại → S(n−1) **giữ dữ liệu**; Giao việc và gửi ở S9 → Đã gửi.
- Không hợp lệ: bấm Tiếp tục khi bước không hợp lệ (nút mờ) → ở nguyên bước. Hành vi Quay lại ở Bước 1 **không được test basis nêu** → chỉ quan sát.
- Kiểm thêm: đổi giá trị ở bước trước rồi đi tiếp → vụ việc lưu giá trị mới.

**Exploratory — EXP-1 (TC-10):** xem 5.11.

### 5.3 EVD — EP + BVA 50MB + EP quyền iOS

| Biến | Phân vùng (EP) |
|---|---|
| Loại tệp (TC-14) | Ảnh (hợp lệ) · video (không hợp lệ) · tệp khác (không hợp lệ) |
| Nguồn ảnh (TC-13) | Chụp ảnh · thư viện · cả hai trong cùng vụ việc |
| Số ảnh (TC-12, 13) | 0 (hợp lệ, đi tiếp) · 1 · nhiều (số tối đa **[MỞ QO5]** — không đặt biên) |
| GPS (TC-17) | Ảnh chụp mới · ảnh thư viện **không** GPS · ảnh thư viện **có** GPS |

**BVA kích thước ảnh (TC-15) — 3-value:** biên 50MB → {dưới biên · đúng biên · vượt biên}. Giá trị cụ thể: 49MB, đúng 50MB, 51MB. **Lưu ý (suy luận QC):** đặc tả không nói 1MB = 1.000.000 hay 1.048.576 byte; ảnh "đúng biên" chỉ ghi lại quan sát, 49MB và 51MB mới chấm đạt/không đạt (mục 11, G4). Thông báo khi vượt: **[MỞ QO5]**.

EP quyền iOS (TC-18) → **Exploratory EXP-2** (5.11).

### 5.4 CLS — Decision Table + EP

**Decision Table danh sách khu vực ở bước 2 (TC-20, TC-65, nguồn QB2/QB3):**

| Rule | Người tạo | Khu vực hiện ở bước 2 | TC |
|---|---|---|---|
| D1 | Người giao cấp Đội (Đội trưởng/Chỉ huy Đội, Tổ trưởng, Tổ phó, Phó đội trưởng, cán bộ uỷ quyền Tổ phó) — **kiểm từng vai trò** | Chỉ khu vực gán cho **Đội của người tạo**; không hiện khu vực chỉ gán cho Đội khác | TC-20 |
| D2 | Người giao cấp Đội, Đội **chưa gán khu vực nào** | **[MỞ QO27]** | TC-20 |
| D3 | Trưởng CACK hoặc Phó trưởng CACK | Khu vực của **mọi Đội**; chọn Đội bất kỳ ở bước 8, **không** chặn/cảnh báo khi lệch khu vực; lưu đúng khu vực và Đội | TC-65 |
| D4 | Trưởng/Phó trưởng CACK, khu vực **chưa gán Đội nào** | **[MỞ QO31]** | TC-65 |

EP bổ sung: Bước 2 (TC-19): {1 khu vực được chọn · chưa chọn}; chọn sẵn mặc định **[MỞ QO7]**. Bước 3 (TC-22, 23): {loại cha/loại con theo danh mục 2 cấp · loại "Khác" có tên · "Khác" để trống} — cách chọn 2 cấp, chọn được loại cha hay không **[MỞ QO8]**. **Không áp BVA cho độ dài tên loại "Khác"** (chưa có giới hạn — không đủ dữ liệu để biết biên). TC-24: EP 2 phân vùng {loại có cờ "Phát hiện vật phẩm nguy hiểm" · loại không cờ}. TC-25: EP 3 mức {Bình thường · Nghiêm trọng · Khẩn cấp}.

**Decision Table cảnh báo Khẩn cấp (TC-26, nguồn QB1(d)):**

| Rule | Mức độ | Người nhận | Nhận thông báo đẩy ưu tiên cao? |
|---|---|---|---|
| E1 | Khẩn cấp | Trưởng CACK | Có |
| E2 | Khẩn cấp | Phó trưởng CACK | Có |
| E3 | Khẩn cấp | Chỉ huy Đội **của vụ việc** | Có |
| E4 | Khẩn cấp | Chỉ huy Đội **khác** | Không |
| E5 | Khẩn cấp | Tổ trưởng/Cán bộ/người ngoài tập nhận | Không |
| E6 | Bình thường / Nghiêm trọng | Bất kỳ ai | Không gửi thông báo Khẩn cấp |
| E7 | Khẩn cấp, người tạo chính là một người trong E1–E3 | **[MỞ QO30]** | — |

Kiểm thêm: không bắt buộc xác nhận; không qua SMS (BR17).

### 5.5 DSC — EP

Bước 5 (TC-27, 28): với "Mô tả vụ việc" {trống (mờ) · có nội dung · chỉ khoảng trắng **[MỞ QO9]** · rất dài **[MỞ QO9]** · tiếng Việt có dấu/ký tự đặc biệt}; "Vị trí cụ thể", "Hành động đã thực hiện" {trống · có nội dung}. Không BVA độ dài (chưa có giới hạn). TC-29: EP nguồn nhập {gõ · giọng nói} × 3 ô — chỉ kiểm văn bản được chèn đúng ô; ngưỡng chính xác không kiểm (QO21); quyền Micro **[MỞ QO6]**.

### 5.6 SUBJ — EP (ma trận) + Checklist/Error guessing + Exploratory

| Biến | Phân vùng |
|---|---|
| Số đối tượng (TC-30, 40) | 0 · 1 · ≥2 (kết hợp 3 cách thêm); xoá 1 trong nhiều |
| Cách thêm (TC-32, 33, 38) | Quét giấy tờ · từ thư viện · thủ công |
| Loại giấy tờ (TC-32, 33) | CCCD gắn chip · CMND · hộ chiếu Việt Nam · hộ chiếu nước ngoài → **ma trận 4 loại × 2 cách (quét, thư viện) = 8 ô**, mỗi ô kiểm 6 trường tự điền (hộ chiếu: số giấy tờ vào ô nào **[MỞ QO11]**) |
| Giới tính (TC-38) | Nam · Nữ · Khác |
| Quốc tịch (TC-38) | Chọn từ danh sách (danh sách **chưa được cung cấp** — §8.2; cần quản trị viên cấp) |
| Sửa trường tự điền (TC-34) | Không sửa · sửa 1 trường · sửa nhiều trường — giá trị lưu = giá trị đã sửa |
| Số lượng đối tượng (TC-31) | Khớp · không khớp số đối tượng đã nhập → đều không bị chặn (nơi lưu **[MỞ QO12]**) |

TC-36, 37 (không lưu ảnh giấy tờ / xử lý trên thiết bị): EP theo **cách quét** {quét · thư viện} × **nơi kiểm** {Hình ảnh/Bằng chứng của Chi tiết vụ việc · thư viện Ảnh iPhone **[MỞ QO11]** · lưu lượng mạng khi quét}. TC-37 cần công cụ quan sát (mục 8, 11).

**Error guessing / Checklist-based** (nguồn cụ thể): wireframe **V7** (quốc tịch nước ngoài nhập vào ô CCCD không bị chặn) và **V12** (camera chụp thường) cho TC-39, TC-35; **CRE-Q05** (nút "Tra biển số") cho TC-41. Đây là nguồn gợi ý case, **không** phải kết quả mong đợi.

**Exploratory — EXP-3 (TC-35), EXP-4 (TC-39):** xem 5.11.

### 5.7 PROP — EP + BVA số lựa chọn

Bước 7 chọn nhiều trong 5 mục (TC-42): BVA 2-value theo số lựa chọn {0 · 1} và giá trị trên {4 · 5 (tất cả)}; lưu tập đúng và hiện ở "Đề xuất xử lý của cán bộ". TC-43 "Khác": **[MỞ QO14]** → EXP-6.

### 5.8 ASG — Decision Table + BVA + State Transition

**Decision Table phạm vi giao (TC-45, 46; nguồn QB1(a)(c), §3.2):**

| Rule | Người tạo | Chọn Đội | Cán bộ hiển thị |
|---|---|---|---|
| A1 | Đội trưởng/Chỉ huy Đội, Tổ trưởng, Tổ phó, Phó đội trưởng, cán bộ uỷ quyền Tổ phó (kiểm từng vai trò) | **Không** chọn được Đội khác — Đội = Đội của mình | Chỉ cán bộ trong Đội mình |
| A2 | Phó trưởng CACK, Trưởng CACK | Chọn **đúng 1** Đội bất kỳ | Chỉ cán bộ của Đội đã chọn (lọc theo Đội) |
| A3 | Mọi người giao | — | Cán bộ ngoài phạm vi **không hiển thị**; không thể có cán bộ của 2 Đội trong cùng vụ việc |

**BVA số cán bộ chọn (TC-44), 2-value:** {0 → bước 8 bắt buộc, không đi tiếp · 1 → đi tiếp}, thêm giá trị "nhiều (2 và tất cả)" để kiểm chọn nhiều và bỏ chọn.

**State Transition đổi Đội (TC-46, người tạo Trưởng/Phó trưởng CACK):** trạng thái {chưa chọn Đội · đã chọn Đội A, chưa chọn cán bộ · đã chọn Đội A + cán bộ · đã đổi sang Đội B}. Sự kiện hợp lệ: chọn Đội, chọn cán bộ, đổi Đội → danh sách cán bộ đổi theo Đội B. Đã chọn cán bộ của Đội A rồi đổi sang B: **[MỞ QO29]**.

TC-47 EP: kết quả tìm {khớp đúng · không khớp · rỗng}; khớp một phần/hoa-thường/hiển thị khi không có kết quả **[MỞ QO15]**. TC-48 → EXP-7.

### 5.9 SUB — BVA hạn + EP + Exploratory

**BVA thời điểm hạn (TC-50, 51)** — biên là "thời điểm hiện tại" (T). Độ chi tiết của "quá khứ" (phút/giây) và lúc kiểm tra **[MỞ QO17]** nên **không** khẳng định đạt/không đạt tại giá trị sát biên:

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

Hạn đã chọn → lưu thành "Hạn" của từng phần việc và "Hạn xử lý" của vụ việc (TC-50). EP múi giờ thiết bị (TC-52): {Việt Nam (UTC+7) · múi giờ khác} — **[MỞ QO17]** → EXP-8.

TC-49, 56: EP bộ dữ liệu {**tối thiểu**: chỉ trường bắt buộc BR04 · **đầy đủ**: mọi trường tuỳ chọn có dữ liệu} → mọi dữ liệu hiện đúng ở màn xem lại và Chi tiết vụ việc.
TC-53: kiểm bước 9 chỉ có "Giao việc và gửi". TC-54: EP {1 lần gửi · tạo xen kẽ XL01 và GV01} → mã dạng VV+6 chữ số, không trùng (BR38). TC-55 → EXP-5.

### 5.10 POST — Decision Table (ai thấy gì) + EP + oracle công thức

**Decision Table hiển thị và thông báo (TC-57–60, 63, 64):**

| Rule | Người xem | Tab Của tôi | Tab Tiếp nhận | Thông báo "Bạn có phần việc mới" | Thống kê Trang chủ |
|---|---|---|---|---|---|
| P1 | Người tạo cấp Đội | Hiện | Hiện | — | Cập nhật (Đội của vụ việc) |
| P2 | Người giao khác **trong Đội của vụ việc** | Không (nếu không được chỉ định) | **Hiện** | Không | Cập nhật |
| P3 | Người giao thuộc **Đội khác** | Không | **Không hiện** | Không | Không đổi |
| P4 | Cán bộ được chỉ định | Hiện | Không có tab | **Đúng 1 thông báo** | Cập nhật nếu cùng Đội |
| P5 | Cán bộ không được chỉ định | Không hiện | Không có tab | Không | — |
| P6 | Người tạo là Trưởng/Phó trưởng CACK: vụ việc ở Tiếp nhận của Đội được chọn / của chính người tạo | Hiện (Của tôi) | **⚑ [QO25] — không chấm**, chỉ ghi quan sát | — | Đội được chọn: theo QB1(d)/QB3 |

Thông báo không qua SMS. TC-57 EP số cán bộ {1 · 2 · nhiều} → mỗi người đúng 1 phần việc "Đã giao"/"Chưa bắt đầu"; bộ đếm "Giao việc 0/y", y = số cán bộ. TC-62: mỗi phần việc 1 dòng nhật ký (tên hành động, 1 hay 2 bản ghi: **[MỞ QO19]**), không sửa/xoá được.

**Oracle nhắc việc (TC-61):** thời điểm nhắc = giao + 2/3 × (hạn − giao). Ví dụ trong BR11 (VV000161): giao 14:15 21/10, hạn 17:00 22/10 → khoảng 26 giờ 45 phút → nhắc 08:05 22/10 (sai số cho phép theo ví dụ ≤ 10 giây). EP khoảng cách hạn−giao {ngắn trong ngày · qua đêm · nhiều ngày}. Cách tính "suy ra" từ ảnh — cần khách hàng xác nhận khi nghiệm thu.

**TC-63 EP (nguồn QB1(b)):** {1 cán bộ · nhiều cán bộ cùng Tổ · nhiều cán bộ cùng Đội khác Tổ **[MỞ QO26]**}; thẻ hiện Đội/Tổ của cán bộ được giao (kiểm vấn đề V3 của wireframe: Tổ khác Đội ở bước 8). TC-64 EP {người cùng Đội của vụ việc · người Đội khác} × {Tổng vụ việc · Khẩn cấp mở · Vụ việc theo khu vực}; khi người tạo là Trưởng/Phó trưởng CACK, khu vực ngoài Đội vẫn hiện ở "Vụ việc theo khu vực" của Đội (QB3).

### 5.11 Exploratory testing (session-based) — chỉ cho phần test basis **thừa nhận chưa biết** kết quả

Mỗi charter tương ứng 1 câu hỏi mở đã được QC lead cho mang sang. Kết quả phiên chỉ ghi **hành vi quan sát được** (kèm ảnh/video), không chấm đạt/không đạt. *(Thời lượng phiên: QC đề xuất 30–45 phút, QC lead duyệt.)*

| Charter | Mục tiêu phiên | TC | QO | Gợi ý nguồn |
|---|---|---|---|---|
| EXP-1 | Khám phá việc đóng màn, vuốt thoát, chuyển nền, đóng app giữa 9 bước ở các bước khác nhau: dữ liệu giữ hay mất, có hỏi xác nhận không | TC-10 | QO4 | Wireframe V10 (không thấy nút đóng) |
| EXP-2 | Khám phá từ chối/cho phép quyền Camera, Ảnh, Micro ở bước 1, 5, 6: thông báo, dẫn tới Cài đặt, luồng có tiếp tục được không | TC-18 (+TC-29) | QO6 | — |
| EXP-3 | Khám phá nhận dạng giấy tờ thất bại (ảnh mờ, thiếu sáng, không phải giấy tờ, giấy tờ bị che): app báo gì, trường điền thiếu, số hộ chiếu vào ô nào, ảnh quét có vào thư viện Ảnh không | TC-35 (+36) | QO11 | Wireframe V12 |
| EXP-4 | Khám phá quy tắc hợp lệ trường đối tượng: đối tượng rỗng, định dạng ngày sinh, độ dài/ký tự số giấy tờ, quốc tịch nước ngoài ở ô CCCD | TC-39 | QO10 | Wireframe V7 |
| EXP-5 | Khám phá bấm gửi nhiều lần, mạng chập chờn, lỗi máy chủ: có tạo trùng vụ việc/phần việc/thông báo không; dữ liệu giữ để gửi lại không | TC-55 (+TC-07 phần giữ dữ liệu) | QO18 | — |
| EXP-6 | Khám phá ô nhập tự do: mô tả chỉ khoảng trắng, rất dài, ký tự đặc biệt; đề xuất "Khác" có ô nhập không | TC-28, TC-43 | QO9, QO14 | — |
| EXP-7 | Khám phá người giao tự giao cho mình, giao cho người có quyền giao khác: có được không, nút hiển thị theo cột nào của ma trận §3.4 | TC-48 | QO16 | — |
| EXP-8 | Khám phá hạn khi thiết bị đặt múi giờ khác: hiển thị, lưu, so với giờ Việt Nam | TC-52 | QO17 | — |

### 5.12 Kỹ thuật **không** dùng và vì sao

- Không dùng Decision Table cho TC-24, TC-25, TC-42 — chỉ 1–2 biến độc lập.
- Không dùng BVA cho độ dài văn bản (mô tả, tên loại "Khác", biển số, số giấy tờ) — test basis chưa nêu giới hạn nào.
- Không dùng State Transition cho vòng đời phần việc sau khi tạo (Đang làm, Hoàn thành…) — thuộc flow `04`, `07`.

---

## 6. Risk-based prioritization

**Cách tính (ISTQB §5.2.1):** risk level = risk likelihood × risk impact. Thang: Cao×Cao, Cao×Vừa, Vừa×Cao → **P1**; Vừa×Vừa, Thấp×Cao, Cao×Thấp → **P2**; Vừa×Thấp, Thấp×Vừa, Thấp×Thấp → **P3**. Nhãn lấy **nguyên** từ test-analysis, không xếp lại.

**Căn cứ (đã được QC lead chấp nhận ngày 2026-10-26, QO24 đóng):**
- **A1 — likelihood:** ước lượng của QC theo độ phức tạp kỹ thuật (nhận dạng giấy tờ trên thiết bị, chọn nhiều, ràng buộc ngày giờ, phân quyền nhiều vai trò, đồng bộ nhiều tài khoản). Dự án chưa có lịch sử lỗi → là giả định đã được chấp thuận, **không phải số liệu đo**.
- **A2 — impact:** suy từ mục tiêu §2.1 ("không thiếu thông tin trong giao nhận"), tính nhạy cảm dữ liệu đối tượng (§8.1), và việc dữ liệu XL01 được dùng lại ở biên bản (XL03), thống kê (CH05), báo cáo (CH06).
- Nếu sau này có lịch sử lỗi hoặc đánh giá business impact của khách hàng → xếp hạng lại.
- Đây là **product risk** (lỗi chức năng/an ninh ảnh hưởng người dùng); **project risk** ở mục 8–11.

**Phân bố ưu tiên trong phạm vi (tổng 65 test condition):**

| Nhóm | P1 | P2 | P3 | Tổng |
|---|---|---|---|---|
| AUTH | 7 | 0 | 0 | 7 |
| NAV | 1 | 2 | 1 | 4 |
| EVD | 1 | 5 | 1 | 7 |
| CLS | 4 | 3 | 2 | 9 |
| DSC | 1 | 1 | 1 | 3 |
| SUBJ | 8 | 1 | 3 | 12 |
| PROP | 0 | 0 | 2 | 2 |
| ASG | 3 | 2 | 0 | 5 |
| SUB | 5 | 2 | 1 | 8 |
| POST | 4 | 4 | 0 | 8 |
| **Cộng** | **34** | **20** | **11** | **65** |

Danh sách: **P1** = TC-01–07, 11, 13, 20, 22, 24, 26, 27, 32–39, 44, 45, 46, 50, 51, 54–60 · **P2** = TC-09, 10, 14–18, 23, 25, 28, 40, 47, 48, 49, 52, 61–65 · **P3** = TC-08, 12, 19, 21, 29, 30, 31, 41, 42, 43, 53.

**Vì sao mỗi P1 có impact cao (không chỉ dán nhãn):**

| TC | Likelihood | Impact cao vì |
|---|---|---|
| 01 | Vừa | Người giao không vào được luồng chính tạo vụ việc → vỡ luồng chính |
| 02 | Vừa | Quyết định L2b đã đổi; sai → Tổ phó bị chặn hoặc quyền cấp sai |
| 03 | Vừa | Cán bộ được uỷ quyền không tạo được, hoặc người không uỷ quyền tạo được |
| 04 | Vừa | Cán bộ vượt quyền tạo vụ việc có dữ liệu cá nhân nhạy cảm |
| 05 | Vừa | Phòng Camera vượt quyền ([Q31]) |
| 06 | Vừa | Quyền đã thu hồi còn hiệu lực → vượt quyền kéo dài |
| 07 | Vừa | Mất mạng mà mất/ghi sai dữ liệu vụ việc trong ca trực liên tục |
| 11 | Vừa | Nút sáng sai → gửi thiếu trường bắt buộc hoặc không gửi được |
| 13 | Vừa | Mất bằng chứng ảnh của vụ việc |
| 20 | Vừa | Lộ/chọn sai khu vực của Đội khác → sai phạm vi quyền |
| 22 | Vừa | Sai loại → sai báo cáo theo loại (CH06) và cờ biểu mẫu |
| 24 | Vừa | Sai cờ → thiếu/thừa biểu mẫu và chữ ký (XL03) |
| 26 | Vừa | Cảnh báo Khẩn cấp sai người hoặc không gửi → chậm xử lý vụ việc nghiêm trọng; gửi nhầm người |
| 27 | Vừa | Mô tả bắt buộc bị mất/lưu sai → vụ việc thiếu thông tin |
| 32, 33 | Cao | Nhận dạng sai → dữ liệu đối tượng sai (nhạy cảm, dùng lại ở biên bản) |
| 34 | Vừa | Giá trị lưu khác giá trị người giao đã sửa → sai dữ liệu đối tượng |
| 35 | Cao | Nhận dạng thất bại gây dữ liệu sai/treo luồng |
| 36 | Vừa | Lưu ảnh giấy tờ trái [Q18] → vi phạm bảo mật dữ liệu cá nhân |
| 37 | Vừa | Ảnh giấy tờ gửi lên máy chủ trái [B13] → lộ dữ liệu cá nhân |
| 38, 39 | Vừa | Đối tượng lưu sai/không kiểm hợp lệ → dữ liệu nhạy cảm sai |
| 44 | Vừa | Giao nhầm hoặc không giao được → vụ việc không tới người nhận |
| 45 | Vừa | Giao ngoài phạm vi → vượt quyền §3.2 |
| 46 | Vừa | Vụ việc lẫn cán bộ 2 Đội → sai Đội phụ trách, sai quyền xem |
| 50 | Vừa | Hạn lưu sai → sai nhắc việc, sai quá hạn |
| 51 | Vừa | Hạn quá khứ lọt qua → vụ việc quá hạn ngay khi tạo |
| 54 | Vừa | Mã trùng/vụ việc trùng → mất khả năng truy xuất |
| 55 | Vừa | Gửi nhiều lần/lỗi mạng tạo trùng vụ việc, phần việc, thông báo |
| 56 | Vừa | Mất dữ liệu 9 bước → trái mục tiêu §2.1 |
| 57 | Vừa | Trạng thái ban đầu sai → vỡ vòng đời phần việc |
| 58, 59 | Vừa | Sai người thấy vụ việc → lộ dữ liệu cá nhân đầy đủ của đối tượng (BR29) |
| 60 | Vừa | Cán bộ không nhận thông báo → bỏ sót phần việc |

**Thứ tự chạy gợi ý (§5.1.5):** AUTH → NAV (TC-11) → ASG → SUB (TC-54, 55) → POST → EVD → SUBJ → CLS → còn lại; P1 trước, P1 có KQ mong đợi XĐ/MỘT PHẦN trước P1 **MỞ** (TC-35, 39, 55). *(Gợi ý của QC.)*

**Ước lượng test case P1:** các nhóm có ma trận (AUTH 6 vai trò, SUBJ 8 ô giấy tờ, ASG/POST nhiều vai trò) cho số test case cao hơn số test condition; số chính xác chốt ở bước test-case.

---

## 7. Test environment matrix

| Hạng mục | Yêu cầu | Trạng thái |
|---|---|---|
| Nền tảng | **iPhone** (L4). Android ngoài phạm vi | Chốt |
| Model iPhone | Chưa xác định | **Còn thiếu** (QO23) |
| Phiên bản iOS | Chưa xác định (đặc tả: "phiên bản tối thiểu chưa định") | **Còn thiếu** (QO23) |
| Build mục tiêu | Chưa xác định. Build **quan sát được trên ảnh** trong spec: 1.0.0 (52) — chỉ để tham khảo, **không** coi là build mục tiêu | **Còn thiếu** |
| Số thiết bị | ≥ 2 thiết bị/tài khoản chạy đồng thời (người tạo + cán bộ nhận việc) để kiểm thông báo đẩy, nhắc việc, đồng bộ tab | Cần |
| Mạng | Wi-Fi và 4G; khả năng ngắt/chập chờn mạng có kiểm soát (TC-07, 55) | Cần |
| Thông báo | Quyền thông báo iOS của app bật; (QC lưu ý: spec không nói hành vi khi tắt — mục 11, G6) | Cần |
| Quyền iOS | Camera, Ảnh, Micro: kiểm cả cho phép và từ chối (EXP-2) | Cần |
| Múi giờ | Đổi được múi giờ thiết bị (EXP-8) | Cần |
| Công cụ | Quan sát lưu lượng mạng khi quét giấy tờ (TC-37) hoặc nhật ký máy chủ do dev cung cấp | **Chưa có** (mục 11, G5) |

**Dữ liệu cần quản trị viên chuẩn bị trước (baseline):**

| Nhóm | Nội dung |
|---|---|
| Tài khoản | 6 vai trò người giao (1 tài khoản mỗi vai trò, riêng Đội trưởng/Tổ trưởng/Tổ phó/Phó đội trưởng thuộc **Đội A**); Trưởng CACK; Phó trưởng CACK; ≥1 Đội trưởng/Chỉ huy Đội và 1 người giao thuộc **Đội B**; cán bộ được uỷ quyền Tổ phó (1 đang hiệu lực, 1 đã bị thu hồi); cán bộ thường ≥3 (≥2 cùng Đội A khác Tổ, ≥1 Đội B); cán bộ Phòng Camera (và 1 cán bộ Phòng Camera có uỷ quyền nếu QO2 cần) |
| Đội/Khu vực | ≥2 Đội, mỗi Đội được gán **bộ khu vực khác nhau**; 1 Đội **chưa gán khu vực** (QO27); 1 khu vực trong danh mục **chưa gán Đội nào** (QO31) |
| Danh mục | Loại vụ việc 2 cấp, có loại "Khác"; 1 loại có cờ biểu mẫu "Phát hiện vật phẩm nguy hiểm" và ≥1 loại không cờ; 5 đề xuất xử lý; danh sách quốc tịch (**chưa cung cấp** — §8.2) |
| Ảnh bằng chứng | Ảnh 49MB, ~50MB, 51MB; ảnh có GPS, ảnh không GPS; 1 video và 1 tệp không phải ảnh (để thử bị từ chối) |
| Giấy tờ **mẫu giả** | 4 loại: CCCD gắn chip, CMND, hộ chiếu Việt Nam, hộ chiếu nước ngoài (cả bản để quét bằng camera và ảnh để chọn từ thư viện); thêm ảnh mờ, thiếu sáng, không phải giấy tờ. **Nguồn bộ mẫu giả chưa xác định (QO23)**; tuyệt đối không dùng giấy tờ thật |
| Dữ liệu đối tượng giả | Họ tên, ngày sinh, số giấy tờ do QC bịa, không trùng người thật |

---

## 8. Entry criteria

Theo §5.1.3 (áp dụng cho **bước chạy test**; bước thiết kế test case chỉ cần test plan READY).

| Nhóm | Tiêu chí | Trạng thái hiện tại |
|---|---|---|
| Tài nguyên | iPhone + iOS + **build mục tiêu** đã được xác định và cài được | **Chưa đạt** (QO23) |
| Tài nguyên | Tài khoản, Đội, khu vực, danh mục ở mục 7 đã được quản trị viên chuẩn bị và QC xác nhận đăng nhập được | Chưa kiểm |
| Tài nguyên | Bộ giấy tờ mẫu giả + ảnh thử đã có | **Chưa đạt** (QO23) |
| Tài nguyên | Công cụ/nhật ký để kiểm TC-37 hoặc có quyết định bỏ TC-37 khỏi đợt này | **Chưa đạt** (mục 11, G5) |
| Testware | Test plan READY (đạt) và `test-cases-dac-ta-v2.1.md` đã được duyệt | Plan đạt; test-case chưa có |
| Testware | Mỗi test case ghi rõ trạng thái KQ mong đợi (XĐ/MỘT PHẦN/MỞ) và QO liên quan | Yêu cầu cho test-case |
| Chất lượng test object | Smoke: đăng nhập được, mở được "Bước 1/9", đi hết 9 bước và gửi được 1 vụ việc tối thiểu | Chưa chạy |
| Quản trị | Không có mâu thuẫn mới của test basis chưa được QC lead quyết định (xem điều kiện dừng ở 8.1) | Đạt tại thời điểm lập |

### 8.1 Suspension và Resumption

| Điều kiện dừng | Phạm vi dừng | Điều kiện chạy lại |
|---|---|---|
| Smoke fail: không gửi được vụ việc tối thiểu | Toàn bộ | Build mới pass smoke; chạy lại từ đầu |
| Sai nghiêm trọng quyền: cán bộ không uỷ quyền/Phòng Camera tạo được vụ việc, hoặc người ngoài phạm vi thấy dữ liệu đối tượng | Dừng AUTH, ASG, POST (nhóm liên quan) | Bug sửa; chạy lại **từ đầu cụm đã dừng**, không tiếp giữa chừng |
| Ảnh giấy tờ bị lưu hoặc gửi lên máy chủ (TC-36/37 fail) | Dừng SUBJ; **báo ngay** | Bug sửa; chạy lại SUBJ từ đầu |
| Mất tài khoản/dữ liệu baseline hoặc môi trường không ổn định (thông báo đẩy không tới) | Dừng nhóm phụ thuộc | Baseline dựng lại và xác nhận |
| Phát hiện mâu thuẫn **mới** của test basis ảnh hưởng scope/priority | Dừng nhóm liên quan, báo orchestrator/QC lead | Có xác nhận bằng văn bản |

---

## 9. Exit criteria

*(Ngưỡng là **đề xuất của QC**, QC lead duyệt.)*

**Đo lường:**
- 100% test case P1 đã chạy; 100% P2 đã chạy; P3: đã chạy hoặc có ghi chú lý do hoãn.
- Số bug **P1 mở = 0**; mọi bug P2 mở có quyết định chấp nhận hoặc kế hoạch sửa.
- Mọi test condition **XĐ** và phần xác định của **MỘT PHẦN**: có kết quả đạt/không đạt.
- Mọi test condition **MỞ** và phần **còn mở**: có **ghi nhận hành vi quan sát** (ảnh/video) — **không** tính là "đạt" hay "không đạt". Báo cáo cuối liệt kê riêng các ca này.
- Nhánh ⚑ QO25: đã ghi quan sát; **không** tính vào tỷ lệ đạt.
- Coverage: mọi TC-01–65 đã được ánh xạ tới ≥1 test case (traceability); 8 charter EXP đã chạy.

**Nhị phân:**
- Regression theo 3.1 đã chạy trên build cuối.
- Mọi câu hỏi ở mục 10 có trong báo cáo cuối: đã có trả lời (và expected cập nhật) **hoặc** được QC lead chấp nhận là gap đã biết.
- Điểm mục 11 (G1–G7) đã có quyết định (kiểm, hoãn, hoặc chấp nhận).

---

## 10. Gap cần làm rõ trước khi execute

Tất cả 29 câu mở dưới đây **mang sang đúng theo quyết định QC lead 2026-10-26**: chỉ đổi **kết quả mong đợi**, không thêm/bớt test condition, không đổi priority → **không chặn READY**. Test case **không** được tự suy ra câu trả lời.

| QO | Câu hỏi (rút gọn) | TC | Ảnh hưởng scope/priority? |
|---|---|---|---|
| QO1 | Cán bộ: nút + Trang chủ ẩn, vô hiệu hay báo lỗi? | 04, 05 | Không (chỉ expected) |
| QO2 | Thu hồi uỷ quyền hiệu lực khi nào; giữa chừng có gửi được; Camera được uỷ quyền? | 05, 06 | Không |
| QO3 | Tab Tiếp nhận có nút +? | 01 | Không |
| QO4 | Thoát/chuyển nền giữa chừng: giữ hay huỷ, có hỏi? | 10 | Không (EXP-1) |
| QO5 | Số ảnh tối đa; xoá ảnh; thông báo >50MB; "gắn thời gian" thế nào; GPS ảnh thư viện | 13, 15, 16, 17 | Không |
| QO6 | Từ chối quyền Camera/Ảnh/Micro | 18, 29 | Không (EXP-2) |
| QO7 | Bước 2 chọn sẵn mục đầu? | 11, 19 | Không |
| QO8 | Loại 2 cấp chọn thế nào; "Khác": bắt buộc, độ dài, có biểu mẫu? | 22, 23, 24 | Không |
| QO9 | Mô tả chỉ khoảng trắng; độ dài tối đa | 27, 28 | Không (EXP-6) |
| QO10 | Quy tắc hợp lệ trường đối tượng; danh sách quốc tịch | 38, 39 | Không (EXP-4) |
| QO11 | Nhận dạng thất bại; hộ chiếu vào ô nào; ảnh quét vào thư viện Ảnh? | 32, 33, 35, 36 | Không (EXP-3) |
| QO12 | "Số lượng đối tượng" lưu/hiển thị ở đâu | 31 | Không |
| QO13 | Nút "Tra biển số" ẩn hay giữ | 41 | Không |
| QO14 | Đề xuất "Khác" có ô nhập? | 43 | Không (EXP-6) |
| QO15 | Tìm email: khớp một phần, hoa/thường, không kết quả | 47 | Không |
| QO16 | Tự giao cho mình; giao cho người có quyền giao | 48 | Không (EXP-7) |
| QO17 | Hạn: quá 17:00; kiểm lúc chọn hay lúc gửi; phút; múi giờ | 50, 51, 52 | Không (EXP-8 cho TC-52) |
| QO18 | Mất mạng: giữ dữ liệu; lỗi máy chủ; chống trùng | 07, 55 | Không (EXP-5) |
| QO19 | NỘI DUNG phần việc từ đâu; "Giao việc" vs "Phân công" | 56, 62 | Không |
| QO21 | Ngưỡng chính xác nhận dạng; chỉ tiêu hiệu năng | 29, 32, 33 | Không — đã loại khỏi tiêu chí (mục 3 #5, mục 11 G2) |
| QO22 | Sửa câu §8.1 "sửa được" | (XL05) | Không — chỉ câu chữ tài liệu |
| QO23 | Xác nhận chỉ iPhone; model, iOS, build; nguồn giấy tờ mẫu giả | Môi trường; 32, 33 | Không với scope test (A3 đã chốt bởi caller/QC lead); **chặn entry criteria để chạy test** |
| QO25 | ⚑ Vụ việc do Trưởng/Phó trưởng CACK tạo hiện ở Tiếp nhận của ai | 58, 59 | Không — QC lead đã quyết định không dùng làm tiêu chí đạt/không đạt |
| QO26 | Thẻ hiện Tổ nào khi cán bộ khác Tổ; Chi tiết có cùng quy tắc; Nguồn phát hiện | 63 | Không |
| QO27 | Đội chưa gán khu vực: bước 2 hiện gì | 20 | Không |
| QO28 | Sửa [B7], BR16, CH07, XL01-B2, §3.2, BR36, [B25*] cho khớp quyết định | 20, 26 | Không — câu chữ tài liệu |
| QO29 | Đổi Đội sau khi chọn cán bộ | 46 | Không |
| QO30 | Người tạo trùng người nhận cảnh báo Khẩn cấp | 26 | Không |
| QO31 | "Khu vực của mọi Đội" có gồm khu vực chưa gán | 65 | Không |

**Đối chiếu 5 lý do dừng ở mục 0 của skill:** (1) thiếu/mơ hồ/mâu thuẫn ảnh hưởng scope-risk — không còn (mọi mâu thuẫn đã có quyết định QC lead; các QO chỉ đổi expected); (2) nhiều version — đã chốt thứ tự ưu tiên 3 nguồn; (3) không đủ info P1 vs P2/P3 — mọi test condition có likelihood/impact kèm căn cứ A1/A2 đã được chấp nhận; (4) không chắc kỹ thuật — mỗi nhóm đã chọn được kỹ thuật (nơi chưa biết đáp án dùng exploratory); (5) phạm vi quá rộng — 1 use case 9 bước, 65 test condition, không cần tách plan.

---

## 11. Coverage gap — case chưa được test basis liệt kê (QC tự phát hiện, **suy luận của QC**)

| # | Thiếu gì | Vì sao là gap | Đề xuất |
|---|---|---|---|
| G1 | Kết quả có **lưu vào trang quản trị chung** và nhật ký đồng bộ về đó | Tính năng 1 "Kết quả" và CH07 nói có; trang quản trị ngoài phạm vi → không kiểm | Không tạo test; ghi rõ trong báo cáo cuối |
| G2 | Hiệu năng; ngưỡng độ chính xác nhận dạng giấy tờ/giọng nói | §10 "đề xuất, chờ duyệt"/chưa có ngưỡng (QO21) | Chỉ kiểm chức năng; không tiêu chí đạt/không đạt về ngưỡng |
| G3 | Android | Ngoài phạm vi đợt (L4) | Cần plan riêng khi có bản Android |
| G4 | Biên "50MB" chưa định nghĩa (1MB = 10⁶ hay 2²⁰ byte) | BVA TC-15: ảnh đúng biên có kết quả mơ hồ | Chỉ chấm 49MB và 51MB; đúng biên ghi quan sát; hỏi khách hàng cùng QO5 |
| G5 | Cách **kiểm TC-37** (ảnh giấy tờ không gửi lên máy chủ) | Cần công cụ quan sát lưu lượng mạng hoặc nhật ký máy chủ; chưa có. P1 | Entry criteria; nếu không có, QC lead quyết định TC-37 chuyển "không kiểm được" |
| G6 | Quyền **Thông báo** của iOS (tắt/bật), app chạy nền/đã đóng khi nhận thông báo Khẩn cấp, "Bạn có phần việc mới" | QO6 chỉ nêu Camera/Ảnh/Micro; TC-26, 60 phụ thuộc thông báo đẩy | Cân nhắc thêm vào EXP-2; hỏi dev (không đổi priority hiện có) |
| G7 | Số lượng lớn ảnh/đối tượng/cán bộ trong một vụ việc | Test basis không nêu giới hạn (QO5 chỉ hỏi ảnh) → rủi ro treo/chậm | Đề xuất 1 phiên exploratory tuỳ chọn sau EXP; không thuộc 65 TC |
| G8 | Hai người giao tạo vụ việc đồng thời (mã VV không trùng) | BR38 nói chung chuỗi; TC-54 chỉ xen kẽ XL01/GV01 tuần tự | Bổ sung case nếu có thể chạy 2 thiết bị cùng lúc |

---

## 12. Báo cáo tóm tắt cho orchestrator

- **Trạng thái:** READY (có điều kiện: KQ mong đợi "còn mở" và ⚑ QO25 không chấm; chưa đủ điều kiện **chạy** test — thiếu model/iOS/build/giấy tờ mẫu/công cụ TC-37).
- 10 nhóm (AUTH, NAV, EVD, CLS, DSC, SUBJ, PROP, ASG, SUB, POST); 65 test condition: **P1 34 · P2 20 · P3 11**; KQ mong đợi XĐ 22 · MỘT PHẦN 34 · MỞ 9.
- Bước tiếp theo: orchestrator quyết định gọi skill **test-case** trên `test-plan-dac-ta-v2.1.md`.
