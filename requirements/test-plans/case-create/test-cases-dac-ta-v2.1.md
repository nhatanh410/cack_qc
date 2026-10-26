# Test Case Specification — Tạo vụ việc xử lý vi phạm (XL01, flow `03_case-create`) — theo đặc tả v2.1

> Thiết kế case theo [test-plan-dac-ta-v2.1.md](test-plan-dac-ta-v2.1.md) (ISTQB Foundation) — bám đúng kỹ thuật đã chọn ở mục 5 test plan (Decision Table, Equivalence Partitioning, Boundary Value Analysis, State Transition, Exploratory, Checklist/Error guessing có nguồn).
> Test basis (thứ tự ưu tiên khi mâu thuẫn): [dac-ta-chuc-nang-v2.1.md](../../specs/xu-ly-vi-pham-giao-viec/dac-ta-chuc-nang-v2.1.md) > [lam-ro-2026-10-26.md](../../specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-26.md) > [mo-ta-chuc-nang-v1.md](../../specs/xu-ly-vi-pham-giao-viec/mo-ta-chuc-nang-v1.md). Nhãn giao diện tham khảo thêm [wireframe 03_case-create](../../ui/ux/wideframes/03_case-create.md) (lập trước đặc tả — chỉ để lấy nhãn, **không** dùng làm kết quả mong đợi).
> Test plan Status khi thiết kế: **READY (có điều kiện)** — điều kiện đi kèm được tôn trọng đầy đủ, xem mục "Quy ước".

## Quy ước

- **Ưu tiên:** P1 (chặn phát hành) · P2 · P3 — kế thừa đúng mục 6 test plan, không tự đổi. Case 🆕 ghi riêng lý do.
- **🔭 Exploratory** — charter EXP-1…EXP-8 (mục 5.11 test plan). Cột "Kết quả mong đợi" ghi "**Phải quan sát/ghi lại**", không đạt/không đạt; ghi vào biên bản phiên (mẫu ở [screenshots/README.md](screenshots/README.md)). Thời lượng phiên đề xuất 30–45 phút (chờ QC lead duyệt).
- **⚠️ Phụ thuộc câu hỏi mở** (QO…) — chỉ phần **ghi "Còn mở"** là không chấm đạt/không đạt; phần **"Xác định"** của cùng case vẫn chấm bình thường. Nguyên văn quy ước: *"Còn mở — chỉ ghi lại hành vi quan sát được"*. Không tự suy đoán câu trả lời.
- **⚑ QO25** — nhánh "vụ việc do Trưởng/Phó trưởng CACK tạo hiện ở tab Tiếp nhận của ai": chỉ ghi quan sát, **không** dùng làm tiêu chí đạt/không đạt.
- **🆕** — case bổ sung ngoài mục 5 test plan, có ghi lý do ngay tại case.
- **EG** — case Checklist/Error guessing bám 1 nguồn cụ thể có trích dẫn (wireframe V7, V12, CRE-Q05 theo mục 5.6 test plan). Nguồn chỉ gợi ý case, không phải kết quả mong đợi.
- **Tên thật trên giao diện:** ưu tiên nhãn của đặc tả (vd nút "Giao việc và gửi"). Bản wireframe cũ ghi "Giao việc & gửi", "Xem lại & gửi" — chấp nhận cả hai dạng chữ "và"/"&", ghi lại dạng thật, **không** chấm lệch chữ này.
- **Chi tiết vụ việc** = mở từ tab Của tôi hoặc Tiếp nhận; các khối: Đầu trang (mã VV, trạng thái, loại · khu vực, mức độ, mô tả ngắn), Giao việc x/y, Biểu mẫu và chữ ký, Thông tin vụ việc, Thông tin liên quan, Đề xuất xử lý của cán bộ, Hình ảnh/Bằng chứng, Diễn biến xử lý (đặc tả mục 5, XL02).
- Ảnh bằng chứng (nếu áp dụng): lưu vào `screenshots/<mã nhóm>/`, xem [screenshots/README.md](screenshots/README.md). Chưa chụp ảnh thật.
- **Dữ liệu cá nhân:** chỉ dùng giấy tờ mẫu giả và dữ liệu giả rõ ràng (tiền tố `TEST`); tuyệt đối không dùng giấy tờ/họ tên/số giấy tờ/ngày sinh/email thật và không chép từ ảnh trong spec.

### Môi trường mặc định (nêu 1 lần)

| Hạng mục | Giá trị |
|---|---|
| Nền tảng | iPhone (Android ngoài phạm vi đợt này). **Model iPhone, phiên bản iOS, build: chưa xác định (QO23)** — người chạy ghi vào bảng log |
| Thiết bị | Tối thiểu 2 iPhone: **M1** (người tạo), **M2** (người nhận/đối chiếu). Một số case cần thêm máy hoặc đăng nhập tuần tự (ghi ở case) |
| Mạng / giờ | Wi-Fi và 4G, ngắt mạng được; múi giờ thiết bị = giờ Việt Nam (trừ EXP-8). Quyền thông báo iOS của app: bật |
| Điều kiện để chạy | Chưa đạt: model/iOS/build, bộ giấy tờ mẫu giả, công cụ quan sát lưu lượng mạng (test plan mục 8) — case ghi rõ khi bị ảnh hưởng |

### Ký hiệu dữ liệu (quản trị viên ánh xạ sang tài khoản/khu vực thật; ký hiệu này do test case đặt)

| Ký hiệu | Nội dung |
|---|---|
| TK-DT-A, TK-TT-A, TK-TP-A, TK-PDT-A | Đội trưởng/Chỉ huy Đội, Tổ trưởng, Tổ phó, Phó đội trưởng — đều thuộc **Đội A** (mỗi vai trò 1 tài khoản riêng) |
| TK-PTC, TK-TC | Phó trưởng CACK, Trưởng CACK |
| TK-UQ / TK-UQ-TH | Cán bộ Đội A được uỷ quyền Tổ phó đang hiệu lực / đã bị thu hồi uỷ quyền |
| TK-CAM / TK-CAM-UQ | Cán bộ Phòng Camera chưa uỷ quyền / có uỷ quyền (chỉ khi QO2 cần) |
| TK-DT-B | Đội trưởng/Chỉ huy Đội của **Đội B** |
| TK-DT-0 | Đội trưởng của **Đội-0** (Đội chưa được gán khu vực nào — cho QO27) |
| CB-A1, CB-A2 | Cán bộ thường Đội A, **khác Tổ** nhau; CB-A1 dùng làm "TK-CB" (cán bộ thường chưa uỷ quyền) |
| CB-A3 | Cán bộ thường Đội A **cùng Tổ với CB-A1** (**bổ sung so với mục 7 test plan** — cần cho TC-POST-18; xem mục "Câu hỏi/gap mới") |
| CB-B1 | Cán bộ thường Đội B |
| KV-A1, KV-A2 / KV-B1 | Khu vực chỉ gán cho Đội A (≥2 khu vực) / chỉ gán cho Đội B. **KV-0**: khu vực trong danh mục chưa gán Đội nào (QO31) |
| L-1 / L-2 (+L-2c) / L-CỜ / L-KHÁC | Loại không cờ biểu mẫu / loại 2 cấp (L-2c là loại con của L-2) / loại "Phát hiện vật phẩm nguy hiểm" (có cờ biểu mẫu) / loại "Khác" nhập tay |
| GT-1…GT-4 | Giấy tờ **mẫu giả**: CCCD gắn chip, CMND, hộ chiếu Việt Nam, hộ chiếu nước ngoài (mỗi loại có bản để quét bằng camera và ảnh để chọn từ thư viện). Trước khi chạy, người chuẩn bị lập **bảng đối chiếu** 6 trường in trên mỗi giấy tờ giả |
| GT-X | Ảnh mờ / thiếu sáng / không phải giấy tờ |
| IMG-nhỏ, IMG-49, IMG-50a, IMG-50b, IMG-51 | Ảnh bằng chứng: nhỏ (≤ 5MB, không GPS); 49MB (≤ 49.000.000 byte); 50MB (50.000.000 byte = 50a; 52.428.800 byte = 50b); 51MB (≥ 53.477.376 byte). Hai mốc 49 và 51 nằm ngoài biên dù hiểu 1MB là 10⁶ hay 2²⁰ byte (G4) |
| IMG-GPS / IMG-noGPS, VID, FILE | Ảnh thư viện có / không có toạ độ GPS; 1 video; 1 tệp không phải ảnh |
| ĐT mẫu | Họ tên `TEST GIA <số>`, số giấy tờ là chuỗi số giả tự đặt (vd `99000000<số>`), số hộ chiếu `TESTHC<số>`; ngày sinh tự đặt |

### Luồng tối thiểu LN-TT (dùng làm "nền" cho nhiều case; kết thúc bằng gửi)

Bước 1 bỏ qua → Bước 2 chọn KV-A1 → Bước 3 chọn L-1 → Bước 4 chọn Bình thường → Bước 5 Mô tả `Mô tả thử nghiệm - vụ việc giả` → Bước 6, 7 bỏ qua → Bước 8 Đội mình + CB-A1 → Bước 9 hạn = ngày mai 17:00 → **Giao việc và gửi**. "Đi tiếp bằng LN-TT từ bước n" = làm các bước còn lại như trên.

---

## 1 · Quyền tạo vụ việc; mất mạng khi gửi · `TC-AUTH` (mục 2 #1, kỹ thuật 5.1 test plan)

> Decision Table (R1a–f, R2–R6) + Equivalence Partitioning kết nối mạng. Mỗi case đăng nhập tài khoản riêng trên M1 (đăng xuất giữa các case). Cách thoát khỏi "Bước 1/9" sau khi kiểm xong không được đặc tả mô tả (QO4) — người chạy tự chọn cách thoát và ghi lại, không chấm.
> **Trình tự gộp:** AUTH-01…11 chạy liền theo tài khoản; AUTH-12…15 chạy sau cùng với 1 tài khoản (TK-DT-A).

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-AUTH-01 ⚠️ | Đăng nhập TK-DT-A (Đội trưởng/Chỉ huy Đội). Ở Trang chủ tìm nút + (Tạo vụ việc), bấm. Quay lại tab Của tôi, tìm nút +. Mở tab Tiếp nhận, quan sát có nút + không | **Xác định:** có nút + ở Trang chủ và tab Của tôi; bấm mở sheet "Tạo vụ việc" ở "Bước 1/9". **Còn mở — chỉ ghi lại hành vi quan sát được:** tab Tiếp nhận có nút + hay không (QO3) | P1 | TC-01 · DT R1a · QO3 |
| TC-AUTH-02 | Như AUTH-01 với TK-TT-A (Tổ trưởng) — chỉ Trang chủ và tab Của tôi | Có nút +; mở được "Bước 1/9" | P1 | TC-01 · DT R1b |
| TC-AUTH-03 | Như AUTH-02 với TK-TP-A (Tổ phó), **không** cấp uỷ quyền gì thêm | Có nút +; mở được "Bước 1/9" (Tổ phó là vai trò người giao đầy đủ, không cần uỷ quyền) | P1 | TC-02 · DT R1c |
| TC-AUTH-04 | Như AUTH-02 với TK-PDT-A (Phó đội trưởng) | Có nút +; mở được "Bước 1/9" | P1 | TC-01 · DT R1d |
| TC-AUTH-05 | Như AUTH-02 với TK-PTC (Phó trưởng CACK) | Có nút +; mở được "Bước 1/9" | P1 | TC-01 · DT R1e |
| TC-AUTH-06 | Như AUTH-02 với TK-TC (Trưởng CACK) | Có nút +; mở được "Bước 1/9" | P1 | TC-01 · DT R1f |
| TC-AUTH-07 | Đăng nhập TK-UQ (cán bộ được uỷ quyền, đang hiệu lực). Kiểm nút + ở Trang chủ và tab Của tôi; bấm +; đi hết 9 bước bằng LN-TT và gửi | Có nút +; mở được "Bước 1/9"; gửi thành công, có mã dạng VV + 6 chữ số, vụ việc hiện ở tab Của tôi của TK-UQ | P1 | TC-03 · DT R2 |
| TC-AUTH-08 ⚠️ | Đăng nhập CB-A1 (cán bộ thường, không uỷ quyền). Tìm nút + ở tab Của tôi và ở Trang chủ; thử mọi cách vào "Bước 1/9" mà giao diện cho phép | **Xác định:** tab Của tôi không có nút +; cán bộ không vào được "Bước 1/9" bằng cách nào. **Còn mở — chỉ ghi lại hành vi quan sát được:** nút + ở Trang chủ bị ẩn, vô hiệu hay hiện thông báo lỗi (QO1) | P1 | TC-04 · DT R3 · QO1 |
| TC-AUTH-09 ⚠️ | Đăng nhập TK-CAM (Phòng Camera, chưa uỷ quyền). Làm như AUTH-08 | **Xác định:** không tạo được vụ việc (không vào được "Bước 1/9"). **Còn mở:** cách chặn (ẩn/vô hiệu/báo lỗi) — chỉ ghi lại (QO1) | P1 | TC-05 · DT R4 · QO1 |
| TC-AUTH-10 ⚠️ | Đăng nhập TK-CAM-UQ (Phòng Camera **có** uỷ quyền Tổ phó). Kiểm nút +; nếu mở được "Bước 1/9", đi LN-TT và gửi 1 vụ việc giả để quan sát | **Còn mở — chỉ ghi lại hành vi quan sát được:** có nút + không; mở được "Bước 1/9" không; gửi được không (đặc tả §3.3 và [Q31] chưa thống nhất — QO2) | P1 | TC-05 · DT R5 · QO2 |
| TC-AUTH-11 ⚠️ | **Phần A:** đăng nhập TK-UQ-TH (uỷ quyền đã thu hồi), kiểm nút + và cách vào "Bước 1/9". **Phần B:** dùng TK-UQ, mở M1 đến Bước 5/9 đã nhập mô tả; nhờ quản trị viên thu hồi uỷ quyền; trên M1 bấm Tiếp tục đến Bước 9 và thử "Giao việc và gửi"; sau đó đăng xuất, đăng nhập lại, kiểm nút + (cấp lại uỷ quyền cho TK-UQ sau khi chạy xong) | **Xác định (phần A):** TK-UQ-TH không tạo được vụ việc. **Còn mở — chỉ ghi lại hành vi quan sát được (phần B):** quyền mất ngay hay sau khi đăng nhập lại; bị chặn ở bước nào; gửi được hay không khi đang giữa 9 bước; vụ việc có được tạo không (QO2) | P1 | TC-06 · DT R6 · QO2 |
| TC-AUTH-12 | Đăng nhập TK-DT-A, **có mạng** (Wi-Fi). Đi LN-TT và gửi | Gửi thành công; có mã VV + 6 chữ số; vụ việc hiện ở tab Của tôi | P1 | TC-07 · EP có mạng |
| TC-AUTH-13 ⚠️ | Đóng hẳn app; tắt Wi-Fi và 4G (hoặc bật chế độ máy bay); mở app, bấm nút + (nếu có). Bật lại mạng, kiểm tab Của tôi và tìm nháp | **Xác định:** không tạo được vụ việc khi mất mạng; sau khi có mạng lại không có vụ việc mới tự sinh, không có nháp ngoại tuyến. **Còn mở:** app có mở được màn hình tạo khi mất mạng không, báo gì — chỉ ghi lại (QO18) | P1 | TC-07 · EP mất mạng trước khi mở màn · QO18 |
| TC-AUTH-14 ⚠️ | Có mạng, đi đến Bước 5/9 đã nhập mô tả; tắt mạng; thử bấm Tiếp tục đến Bước 9; thử gửi. Bật mạng, kiểm tab Của tôi | **Xác định:** không gửi được khi mất mạng; không có nháp ngoại tuyến; không có vụ việc nào được tạo cho tới khi gửi thành công. **Còn mở:** app cho đi tiếp các bước khi mất mạng không, báo gì, dữ liệu đã nhập có còn không — chỉ ghi lại (QO18) | P1 | TC-07 · EP mất mạng giữa các bước · QO18 |
| TC-AUTH-15 ⚠️ | Đi đến Bước 9 đã nhập đủ và chọn hạn hợp lệ; tắt mạng; bấm "Giao việc và gửi". Chờ 2 phút, bật mạng, kiểm tab Của tôi và Tiếp nhận (không bấm gửi lại) | **Xác định:** không gửi được; không có vụ việc nào được tạo; không có hàng đợi gửi ngầm sau khi có mạng lại; không lưu nháp ngoại tuyến. **Còn mở:** dữ liệu có được giữ để gửi lại không (QO18) — chỉ ghi lại | P1 | TC-07 · EP mất mạng đúng lúc gửi · QO18 |

---

## 2 · Điều hướng 9 bước, tính bắt buộc từng bước · `TC-NAV` (mục 2 #2, kỹ thuật 5.2)

> Decision Table BR04 (10 dòng → NAV-01…10), State Transition (NAV-11…16), TC-08 (NAV-17), Exploratory EXP-1 (NAV-18). "Mờ" = nút không bấm được/không đi tiếp; "sáng" = bấm được. Dùng TK-DT-A trên M1; các bước chưa nói đến đi bằng LN-TT.
> **Trình tự gộp NAV-01…10:** một lượt từ Bước 1 đến Bước 9; ở mỗi bước ghi trạng thái nút khi để trống rồi khi nhập hợp lệ. Nên chạy cùng lượt với EVD, CLS, DSC, SUBJ, ASG, SUB tương ứng nhưng ghi kết quả riêng theo ID.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-NAV-01 | Bước 1: không thêm ảnh, quan sát nút Tiếp tục; thêm 1 ảnh IMG-nhỏ, quan sát lại | Cả hai trạng thái: Tiếp tục **sáng** (bước không bắt buộc) | P1 | TC-11 · DT bước 1 |
| TC-NAV-02 ⚠️ | Bước 2: vào bước, ghi lại có khu vực chọn sẵn không; nếu chưa chọn sẵn, quan sát nút; chọn 1 khu vực, quan sát nút | **Xác định:** đã chọn 1 khu vực → Tiếp tục sáng. **Còn mở:** để trống → mờ, nhưng nếu có khu vực chọn sẵn thì luôn sáng — chỉ ghi lại hành vi thật (QO7) | P1 | TC-11 · DT bước 2 · QO7 |
| TC-NAV-03 ⚠️ | Bước 3: chưa chọn loại, quan sát nút; chọn L-1, quan sát; chọn "Khác" nhưng để trống tên, quan sát | **Xác định:** chưa chọn → mờ; chọn loại → sáng. **Còn mở:** "Khác" để trống tên — nút sáng hay mờ, chỉ ghi lại (QO8) | P1 | TC-11 · DT bước 3 · QO8 |
| TC-NAV-04 | Bước 4: chưa chọn mức độ, quan sát nút; chọn Bình thường, quan sát | Chưa chọn → mờ; đã chọn → sáng | P1 | TC-11 · DT bước 4 |
| TC-NAV-05 ⚠️ | Bước 5: để trống "Mô tả vụ việc", quan sát nút; nhập `Mô tả thử nghiệm`, quan sát; xoá hết rồi nhập chỉ khoảng trắng, quan sát | **Xác định:** trống → mờ; có nội dung → sáng. **Còn mở:** chỉ khoảng trắng — chỉ ghi lại (QO9) | P1 | TC-11 · DT bước 5 Mô tả · QO9 |
| TC-NAV-06 | Bước 5 với Mô tả hợp lệ: để trống "Vị trí cụ thể" và "Hành động đã thực hiện", quan sát nút; nhập nội dung vào cả hai, quan sát | Cả hai trạng thái: Tiếp tục **sáng** (2 ô tuỳ chọn) | P1 | TC-11 · DT bước 5 Vị trí/Hành động |
| TC-NAV-07 | Bước 6: không thêm đối tượng, để trống số lượng/biển số/đơn vị, quan sát nút; sau đó thêm 1 đối tượng thủ công và nhập số lượng, biển số, đơn vị, quan sát | Cả hai trạng thái: Tiếp tục **sáng** | P1 | TC-11 · DT bước 6 |
| TC-NAV-08 | Bước 7: không chọn đề xuất nào, quan sát nút; chọn 1 đề xuất, quan sát | Cả hai trạng thái: Tiếp tục **sáng** | P1 | TC-11 · DT bước 7 |
| TC-NAV-09 | Bước 8: chọn Đội nhưng chưa chọn cán bộ, quan sát nút; chọn 1 cán bộ, quan sát | 0 cán bộ → mờ; từ 1 cán bộ → sáng | P1 | TC-11 · DT bước 8 |
| TC-NAV-10 | Bước 9: ghi lại trạng thái ban đầu của hạn và nút "Giao việc và gửi"; thử đặt hạn không hợp lệ (ngày đã qua); sau đó đặt hạn hợp lệ (ngày mai 17:00) | Hạn không hợp lệ → "Giao việc và gửi" **không sáng**; hạn hợp lệ → **sáng**. Trạng thái ban đầu (chưa chạm vào hạn): chỉ ghi lại | P1 | TC-11 · DT bước 9 |
| TC-NAV-11 | Đi từ Bước 1 đến Bước 9, ở mỗi bước nhập dữ liệu hợp lệ rồi bấm Tiếp tục; sau mỗi lần ghi thanh hiển thị | 8 lần chuyển liên tiếp Bước n → Bước n+1; thanh hiển thị đúng "Bước n/9" sau mỗi lần; không bước nào bị bỏ qua | P2 | TC-09 · ST Tiếp tục S1→S9 |
| TC-NAV-12 | Với vụ việc đã nhập dữ liệu **đầy đủ** ở mọi bước (1 ảnh, KV-A1, L-1, Nghiêm trọng, 3 ô mô tả, 1 đối tượng thủ công, 2 đề xuất, Đội A + CB-A1), từ Bước 9 bấm Quay lại liên tiếp về Bước 1; ở mỗi bước đối chiếu dữ liệu | 8 lần Quay lại, mỗi lần về đúng bước trước; dữ liệu đã nhập ở mọi bước **còn nguyên** | P2 | TC-09 · ST Quay lại S9→S1 |
| TC-NAV-13 | Sau NAV-12 đi tiến lại đến Bước 9, chọn hạn hợp lệ, bấm "Giao việc và gửi" | Chuyển sang trạng thái Đã gửi: có mã VV; vụ việc hiện ở tab Của tôi và Tiếp nhận của TK-DT-A. Màn hình sau khi gửi: chỉ ghi lại | P2 | TC-09 · ST S9→Đã gửi |
| TC-NAV-14 | Đi đến Bước 9; quay lại Bước 2 đổi KV-A1 sang KV-A2; đến Bước 5 sửa mô tả thành `Mô tả đã sửa`; đi tiếp và gửi; mở Chi tiết vụ việc | Chi tiết hiển thị khu vực **KV-A2** và mô tả **`Mô tả đã sửa`**, không phải giá trị cũ | P2 | TC-09 · ST đổi giá trị rồi đi tiếp |
| TC-NAV-15 | Ở Bước 4 chưa chọn mức độ; chạm vào nút Tiếp tục đang mờ (đúng 1 sự kiện không hợp lệ) | Vẫn ở "Bước 4/9"; không sang bước khác; dữ liệu các bước trước không đổi | P2 | TC-09 · ST không hợp lệ: Tiếp tục khi nút mờ |
| TC-NAV-16 ⚠️ | Ở Bước 1 tìm nút Quay lại; nếu có, bấm | **Còn mở — chỉ ghi lại hành vi quan sát được:** Bước 1 có nút Quay lại không, bấm thì sao (test basis không nêu; wireframe cũ ghi Bước 1 chỉ có Tiếp tục) | P2 | TC-09 · ST Quay lại ở Bước 1 (plan: chỉ quan sát) |
| TC-NAV-17 | Đi qua 9 bước, đọc thanh "Bước n/9" và tên bước | n đúng từ 1 đến 9. Tên bước theo đặc tả: 1 Hình ảnh/Bằng chứng, 2 Khu vực phát sinh, 3 Loại vụ việc, 4 Mức độ, 5 Mô tả, 6 Thông tin đối tượng, 7 Đề xuất xử lý, 8 Giao việc, 9 Xem lại và gửi. Khác biệt nhỏ về dấu "/", "&"/"và": ghi lại, không chấm | P3 | TC-08 |
| TC-NAV-18 🔭 | **Charter EXP-1** — Khám phá đóng/vuốt thoát màn, chuyển nền, đóng hẳn app, khoá máy ở các bước khác nhau (vd Bước 1, 5, 6, 9): dữ liệu giữ hay mất, có hỏi xác nhận không, quay lại app thì ở bước nào. Tìm nút đóng của sheet | **Phải quan sát/ghi lại** (QO4); không đạt/không đạt | P2 | TC-10 · EXP-1 · QO4 |

---

## 3 · Bước 1 — Hình ảnh/Bằng chứng · `TC-EVD` (mục 2 #3, kỹ thuật 5.3)

> EP (loại tệp, nguồn, số ảnh, GPS) + BVA 3-value 50MB + Exploratory EXP-2. Dùng TK-DT-A trên M1; sau Bước 1 đi tiếp bằng LN-TT. Kiểm kết quả lưu ở Chi tiết vụ việc → khối Hình ảnh/Bằng chứng. Cách đọc siêu dữ liệu GPS của tệp đã lưu: nếu giao diện không cho xem, ghi "không kiểm được siêu dữ liệu qua giao diện" (không chấm).

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-EVD-01 | Bước 1: không thêm ảnh; bấm Tiếp tục; đi đến Bước 9 | Sang được Bước 2/9; màn xem lại hiện "Bằng chứng: 0 tệp"; gửi thành công | P3 | TC-12 · EP số ảnh = 0 |
| TC-EVD-02 | Bấm "Chụp ảnh" (cho phép quyền Camera nếu hỏi), chụp 1 ảnh; Tiếp tục; đến Bước 9; gửi; mở Chi tiết | Thấy 1 ảnh thu nhỏ ở Bước 1; màn xem lại "Bằng chứng: 1 tệp"; Chi tiết → Hình ảnh/Bằng chứng có đúng 1 ảnh khớp ảnh đã chụp | P1 | TC-13 · EP nguồn = chụp, số ảnh = 1 |
| TC-EVD-03 | Bấm "Thư viện", chọn IMG-nhỏ; làm tiếp như EVD-02 | "Bằng chứng: 1 tệp"; Chi tiết có đúng 1 ảnh khớp ảnh đã chọn | P1 | TC-13 · EP nguồn = thư viện |
| TC-EVD-04 ⚠️ | Thêm 3 ảnh trong cùng vụ việc (2 chụp, 1 từ thư viện). Thử xoá 1 ảnh (nếu có nút), rồi thêm lại để đủ 3. Đến Bước 9, gửi, mở Chi tiết | **Xác định:** "Bằng chứng: 3 tệp"; Chi tiết có đủ 3 ảnh khớp. **Còn mở — chỉ ghi lại:** có xoá được ảnh không, số ảnh tối đa (không đặt biên thử) (QO5) | P1 | TC-13 · EP số ảnh nhiều + nguồn cả hai · QO5 |
| TC-EVD-05 | Bước 1 → "Thư viện": cố chọn VID (video) | Không thêm được video vào Bằng chứng (không có ảnh thu nhỏ video; số tệp không tăng). Cách chặn (trình chọn không hiện video / báo lỗi): chỉ ghi lại | P2 | TC-14 · EP video (không hợp lệ) |
| TC-EVD-06 | Tìm mọi đường thêm tệp FILE (không phải ảnh) vào Bằng chứng | Không thêm được. Nếu giao diện chỉ mở Camera/Thư viện Ảnh nên không có cách chọn tệp khác: ghi "không thực hiện được do nguồn chọn chỉ có ảnh" (phù hợp "chỉ ảnh") | P2 | TC-14 · EP tệp khác (không hợp lệ) |
| TC-EVD-07 | Thêm IMG-49 từ thư viện | Thêm được; số tệp tăng 1 | P2 | TC-15 · BVA dưới biên |
| TC-EVD-08 ⚠️ | Lần lượt thêm IMG-50a rồi IMG-50b (hai cách hiểu 1MB) | **Còn mở — chỉ ghi lại hành vi quan sát được:** mỗi ảnh được thêm hay bị từ chối (đặc tả không định nghĩa 1MB — G4/QO5); không chấm | P2 | TC-15 · BVA đúng biên |
| TC-EVD-09 ⚠️ | Thêm IMG-51 | **Xác định:** không thêm được; số tệp không tăng. **Còn mở:** nội dung thông báo khi vượt 50MB — chỉ ghi lại (QO5) | P2 | TC-15 · BVA vượt biên · QO5 |
| TC-EVD-10 ⚠️ | Thêm 1 ảnh (chụp), gửi vụ việc; mở Chi tiết → Hình ảnh/Bằng chứng, tìm thông tin thời gian gắn với ảnh | **Còn mở — chỉ ghi lại hành vi quan sát được:** có hiển thị thời gian gắn với ảnh không, ở đâu, là giờ chụp hay giờ tải lên (QO5) | P2 | TC-16 · QO5 |
| TC-EVD-11 | Chụp ảnh mới bằng Camera của app (bật vị trí cho Camera trên iPhone), gửi vụ việc; xem ảnh trong Chi tiết | Không có toạ độ/vị trí nào hiện cùng ảnh; nếu có cách đọc siêu dữ liệu tệp đã lưu thì không còn GPS | P2 | TC-17 · EP GPS: ảnh chụp mới |
| TC-EVD-12 | Chọn IMG-noGPS từ thư viện, gửi, xem Chi tiết | Không có toạ độ/vị trí nào hiện cùng ảnh | P2 | TC-17 · EP GPS: thư viện không GPS |
| TC-EVD-13 ⚠️ | Chọn IMG-GPS (ảnh thư viện có toạ độ) từ thư viện, gửi, xem Chi tiết | **Xác định:** không toạ độ nào hiện cùng ảnh trong app (đặc tả: không lưu GPS). **Còn mở:** cách app xử lý (xoá siêu dữ liệu, cảnh báo, hay giữ) — chỉ ghi lại (QO5) | P2 | TC-17 · EP GPS: thư viện có GPS · QO5 |
| TC-EVD-14 🔭 | **Charter EXP-2** — Khám phá từ chối/cho phép quyền Camera, Ảnh ở Bước 1; Micro ở Bước 5; Camera/Ảnh ở Bước 6 (quét, thư viện): thông báo hiện ra, có dẫn tới Cài đặt không, luồng có tiếp tục được không. Ghi thêm (G6): khi tắt quyền Thông báo của app, có báo gì không | **Phải quan sát/ghi lại** (QO6); không đạt/không đạt | P2 | TC-18 (+TC-29) · EXP-2 · QO6 |

---

## 4 · Bước 2–4 — Khu vực, Loại, Mức độ; cảnh báo Khẩn cấp · `TC-CLS` (mục 2 #4, kỹ thuật 5.4)

> Decision Table khu vực (D1–D4) và cảnh báo Khẩn cấp (E1–E7), EP loại/mức độ. Thứ tự khu vực trong danh sách và biểu tượng của mục khu vực không được đặc tả — không chấm.
> **Cảnh báo Khẩn cấp (CLS-21…27):** người tạo là **TK-TT-A** (không phải người trong nhóm nhận) trừ CLS-27. Tạo vụ việc Khẩn cấp bằng LN-TT (Bước 4 chọn Khẩn cấp), giao CB-A1. Người nhận cần đăng nhập, bật thông báo, trên máy riêng. **Nếu chỉ có 2 máy:** chạy tuần tự, mỗi lần một người nhận đăng nhập trên M2 trước khi gửi. **Nếu có ≥3 máy:** đăng nhập sẵn TK-TC, TK-PTC, TK-DT-A, TK-DT-B, TK-TP-A và gửi 1 vụ việc Khẩn cấp phục vụ CLS-21…25 cùng lúc. "Nhận cảnh báo" = nhận thông báo đẩy của vụ việc Khẩn cấp; **nội dung/âm báo/kiểu "ưu tiên cao" không được test basis mô tả → ghi lại nguyên văn, không chấm**. Chờ ít nhất 2 phút sau khi người nhận đối chứng đã nhận trước khi kết luận "không nhận".

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-CLS-01 | Đăng nhập TK-DT-A; vào Bước 2; ghi danh sách khu vực hiển thị; so với cấu hình khu vực của Đội A | Chỉ hiện khu vực gán cho **Đội A** (KV-A1, KV-A2…); **không** hiện KV-B1 hay khu vực chỉ gán cho Đội khác; chọn được 1 khu vực | P1 | TC-20 · DT D1 (Đội trưởng/Chỉ huy Đội) |
| TC-CLS-02 | Như CLS-01 với TK-TT-A (Tổ trưởng) | Như CLS-01 | P1 | TC-20 · DT D1 (Tổ trưởng) |
| TC-CLS-03 | Như CLS-01 với TK-TP-A (Tổ phó) | Như CLS-01 | P1 | TC-20 · DT D1 (Tổ phó) |
| TC-CLS-04 | Như CLS-01 với TK-PDT-A (Phó đội trưởng) | Như CLS-01 | P1 | TC-20 · DT D1 (Phó đội trưởng) |
| TC-CLS-05 | Như CLS-01 với TK-UQ (cán bộ uỷ quyền Tổ phó) | Như CLS-01 | P1 | TC-20 · DT D1 (cán bộ uỷ quyền) |
| TC-CLS-06 ⚠️ | Đăng nhập TK-DT-0 (Đội chưa gán khu vực nào); vào Bước 2 | **Còn mở — chỉ ghi lại hành vi quan sát được:** danh sách khu vực rỗng, báo gì, có đi tiếp được không (QO27) | P1 | TC-20 · DT D2 · QO27 |
| TC-CLS-07 | Lần lượt đăng nhập TK-TC rồi TK-PTC. Bước 2: ghi danh sách. Chọn KV-A1; đến Bước 8 chọn **Đội B** và CB-B1 (lệch khu vực); gửi; mở Chi tiết | Bước 2 hiện khu vực của **mọi Đội** (có cả KV-A1 và KV-B1); chọn Đội B ở Bước 8 **không** bị chặn/cảnh báo lệch khu vực; Chi tiết lưu đúng khu vực **KV-A1** và Đội phụ trách **Đội B** (cả hai tài khoản) | P2 | TC-65 · DT D3 |
| TC-CLS-08 ⚠️ | Đăng nhập TK-TC; vào Bước 2, tìm KV-0 (chưa gán Đội nào); nếu chọn được, đi tiếp đến Bước 8 chọn Đội bất kỳ | **Còn mở — chỉ ghi lại hành vi quan sát được:** "khu vực của mọi Đội" có gồm KV-0 không; nếu chọn được thì lưu thế nào (QO31) | P2 | TC-65 · DT D4 · QO31 |
| TC-CLS-09 | Bước 2: chọn KV-A1 (quan sát dấu chọn), rồi chọn KV-A2; đi tiếp và gửi; mở Chi tiết | Chỉ 1 khu vực được chọn tại một thời điểm (chọn KV-A2 thì KV-A1 bỏ chọn); Tiếp tục sáng; Chi tiết (loại · khu vực) hiển thị **KV-A2** | P3 | TC-19 · EP đã chọn 1 |
| TC-CLS-10 ⚠️ | Vào Bước 2 lần đầu, không chạm gì; ghi lại có khu vực nào chọn sẵn không và trạng thái nút Tiếp tục | **Còn mở — chỉ ghi lại hành vi quan sát được:** có chọn sẵn mục đầu danh sách hay không; nếu không chọn sẵn thì nút Tiếp tục mờ (QO7) | P3 | TC-19 · EP chưa chọn · QO7 |
| TC-CLS-11 🆕 | Đối chiếu tập giá trị hiển thị ở Bước 2 (khu vực), Bước 3 (loại), Bước 4 (mức độ), Bước 7 (đề xuất xử lý) với danh mục quản trị viên cung cấp (thêm/ẩn một mục thử nếu quản trị viên làm được) | Tập mục hiển thị = tập cấu hình (không thiếu, không thừa); mục bị ẩn không hiện; thứ tự không chấm. **Lý do 🆕:** TC-21 (P3) không có dòng nào ở mục 5 test plan — case viết theo EP "giá trị trong danh mục" để vẫn phủ TC-21; đề nghị bổ sung dòng vào test plan khi chạy lại | P3 | TC-21 · không có dòng mục 5 |
| TC-CLS-12 ⚠️ | Bước 3: mở danh mục 2 cấp, chọn loại cha L-2 rồi loại con L-2c; gửi; mở Chi tiết | **Xác định:** Chi tiết hiển thị loại đã chọn (loại con thuộc đúng loại cha). **Còn mở:** cách chọn 2 cấp, cách hiển thị cha/con — chỉ ghi lại (QO8) | P1 | TC-22 · EP loại con · QO8 |
| TC-CLS-13 ⚠️ | Bước 3: chỉ chọn loại cha L-2, không chọn loại con; quan sát nút Tiếp tục | **Còn mở — chỉ ghi lại hành vi quan sát được:** chọn được loại cha không, nút sáng hay mờ (QO8) | P1 | TC-22 · EP loại cha · QO8 |
| TC-CLS-14 ⚠️ | Bước 3: chọn "Khác (tự nhập loại vụ việc)", nhập `Loại thử nghiệm - giả`; đi tiếp, gửi; mở Chi tiết, xem khối "Biểu mẫu và chữ ký" | **Xác định:** ô nhập tay xuất hiện; Tiếp tục sáng; Chi tiết hiển thị tên loại đã nhập. **Còn mở:** bắt buộc nhập, độ dài tối đa, loại "Khác" có biểu mẫu không (khối "Biểu mẫu và chữ ký" có hiện không) — chỉ ghi lại (QO8) | P2 | TC-23 · EP Khác có tên · QO8 |
| TC-CLS-15 ⚠️ | Bước 3: chọn "Khác", để trống tên; quan sát nút Tiếp tục | **Còn mở — chỉ ghi lại hành vi quan sát được:** nút sáng hay mờ (QO8) | P2 | TC-23 · EP Khác để trống · QO8 |
| TC-CLS-16 | Tạo vụ việc LN-TT với loại L-CỜ (Phát hiện vật phẩm nguy hiểm), giao CB-A1; đăng nhập CB-A1 trên M2, mở Chi tiết | Chi tiết có khối **"Biểu mẫu và chữ ký"** (có nút Mở biểu mẫu) | P1 | TC-24 · EP loại có cờ |
| TC-CLS-17 | Tạo vụ việc LN-TT với L-1 (không cờ), giao CB-A1; mở Chi tiết trên M2 | Không có khối "Biểu mẫu và chữ ký" (chỉ loại có cờ mới cần biểu mẫu — BR21) | P1 | TC-24 · EP loại không cờ |
| TC-CLS-18 | Bước 4 chọn **Bình thường**; gửi. Xem thẻ ở tab Tiếp nhận; chọn bộ lọc "Bình thường" rồi "Nghiêm trọng" | Chi tiết và thẻ hiện mức Bình thường; lọc "Bình thường" thấy thẻ; lọc "Nghiêm trọng" không thấy | P2 | TC-25 · EP Bình thường |
| TC-CLS-19 | Như CLS-18 với **Nghiêm trọng** (lọc "Nghiêm trọng" thấy; "Khẩn cấp" không thấy) | Mức Nghiêm trọng lưu và lọc đúng | P2 | TC-25 · EP Nghiêm trọng |
| TC-CLS-20 | Như CLS-18 với **Khẩn cấp**; đọc ghi chú dưới lựa chọn Khẩn cấp ở Bước 4 | Mức Khẩn cấp lưu và lọc đúng; dưới lựa chọn Khẩn cấp có ghi chú "Cảnh báo Lãnh đạo + BCH đội" | P2 | TC-25 · EP Khẩn cấp |
| TC-CLS-21 | Tạo vụ việc Khẩn cấp (TK-TT-A, Đội A). Người nhận: TK-TC. Ghi thông báo nhận được; đọc xem có bắt buộc xác nhận không; nếu máy có SIM, kiểm không có tin nhắn SMS | TK-TC **nhận** cảnh báo Khẩn cấp (thông báo đẩy); **không** bắt buộc xác nhận; không có SMS | P1 | TC-26 · DT E1 |
| TC-CLS-22 | Như CLS-21, người nhận TK-PTC | TK-PTC **nhận** cảnh báo Khẩn cấp; không bắt buộc xác nhận; không SMS | P1 | TC-26 · DT E2 |
| TC-CLS-23 | Như CLS-21, người nhận TK-DT-A (Chỉ huy Đội **của vụ việc**, không phải người tạo) | TK-DT-A **nhận** cảnh báo Khẩn cấp; không bắt buộc xác nhận; không SMS | P1 | TC-26 · DT E3 |
| TC-CLS-24 | Như CLS-21, người đối chứng TK-DT-B (Chỉ huy **Đội khác**); đồng thời có người nhận đối chứng (TK-TC) đã nhận | TK-DT-B **không** nhận cảnh báo Khẩn cấp | P1 | TC-26 · DT E4 |
| TC-CLS-25 | Như CLS-21, người đối chứng TK-TP-A (Tổ phó, không được giao) và CB-A1 (được giao việc) | Cả hai **không** nhận cảnh báo Khẩn cấp. CB-A1 chỉ nhận "Bạn có phần việc mới" như bình thường (ghi lại nguyên văn mọi thông báo nhận được) | P1 | TC-26 · DT E5 |
| TC-CLS-26 | Tạo 2 vụ việc: một **Bình thường**, một **Nghiêm trọng** (TK-TT-A, Đội A, giao CB-A1); TK-TC, TK-PTC, TK-DT-A đều đăng nhập, chờ 2 phút sau mỗi lần gửi | Không ai trong ba người nhận cảnh báo Khẩn cấp cho hai vụ việc này (CB-A1 chỉ nhận thông báo phần việc mới) | P1 | TC-26 · DT E6 |
| TC-CLS-27 ⚠️ | Tạo vụ việc Khẩn cấp lần lượt bởi TK-TC, TK-PTC, TK-DT-A (mỗi lần giao CB-A1; Đội của TK-TC/TK-PTC chọn là Đội A); ghi lại chính người tạo có nhận cảnh báo của mình không | **Còn mở — chỉ ghi lại hành vi quan sát được:** người tạo trùng người nhận có nhận cảnh báo cho chính vụ việc mình tạo không (QO30). Không chấm | P1 | TC-26 · DT E7 · QO30 |

---

## 5 · Bước 5 — Mô tả · `TC-DSC` (mục 2 #5, kỹ thuật 5.5)

> EP. Dùng TK-DT-A trên M1; các bước khác đi LN-TT. Kiểm lưu ở Chi tiết (Đầu trang: mô tả ngắn; Thông tin vụ việc: Vị trí, Hành động đã thực hiện).

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-DSC-01 | Bước 5: để trống cả 3 ô, quan sát nút | "Mô tả vụ việc" trống → Tiếp tục **mờ** | P1 | TC-27 · EP Mô tả trống |
| TC-DSC-02 | Chỉ nhập `Mô tả thử nghiệm` vào "Mô tả vụ việc" | Tiếp tục **sáng**; 2 ô còn lại ghi nhãn tuỳ chọn | P1 | TC-27 · EP Mô tả có nội dung |
| TC-DSC-03 | Mô tả hợp lệ, "Vị trí cụ thể" và "Hành động đã thực hiện" để trống; đi tiếp và gửi; mở Chi tiết | Gửi được; Chi tiết lưu mô tả; hai trường để trống không gây lỗi | P1 | TC-27 · EP Vị trí/Hành động trống |
| TC-DSC-04 | Nhập đủ 3 ô (`Mô tả thử nghiệm`, `Vị trí thử nghiệm - cổng giả`, `Đã báo trực ban - thử nghiệm`); gửi; mở Chi tiết | Mô tả hiện ở Đầu trang; Vị trí và Hành động đã thực hiện hiện ở Thông tin vụ việc, đúng nguyên văn | P1 | TC-27 · EP Vị trí/Hành động có nội dung |
| TC-DSC-05 ⚠️ | Mô tả chỉ gồm 5 dấu cách; ghi nút Tiếp tục; nếu đi tiếp được thì gửi và xem Chi tiết | **Còn mở — chỉ ghi lại hành vi quan sát được:** nút sáng/mờ, Chi tiết hiển thị gì (QO9) | P2 | TC-28 · EP chỉ khoảng trắng · QO9 |
| TC-DSC-06 ⚠️ | Dán văn bản dài dần (mốc thử của người chạy: khoảng 500, 2.000, 10.000 ký tự — **không phải biên của spec**); ghi lại ở mốc nào app dừng/cảnh báo/treo | **Còn mở — chỉ ghi lại hành vi quan sát được** (QO9: độ dài tối đa); ghi cả cách Chi tiết hiển thị văn bản dài | P2 | TC-28 · EP rất dài · QO9 |
| TC-DSC-07 ⚠️ | Nhập vào Mô tả `Hành khách ồn ào, quá khích tại cổng số 5` và chuỗi ký tự đặc biệt `& < > " ' / \ % # @`; gửi; so Chi tiết với văn bản đã nhập | **Còn mở — chỉ ghi lại hành vi quan sát được** (QO9): có giữ nguyên dấu tiếng Việt và ký tự đặc biệt không. Nếu mất dấu/đổi ký tự rõ ràng: ghi lại và hỏi QC lead có coi là lỗi không | P2 | TC-28 · EP tiếng Việt có dấu/ký tự đặc biệt · QO9 |
| TC-DSC-08 🔭 | **Charter EXP-6 (phần Bước 5)** — Khám phá ô nhập tự do: Mô tả chỉ khoảng trắng, rất dài, ký tự đặc biệt, dán nội dung, emoji, xuống dòng nhiều; chuyển qua lại giữa 3 ô | **Phải quan sát/ghi lại** (QO9); không đạt/không đạt. Phần "Đề xuất Khác" của EXP-6: xem TC-PROP-05 | P2 | TC-28 · EXP-6 · QO9 |
| TC-DSC-09 ⚠️ | Bấm micro ở ô "Mô tả vụ việc" (lần đầu có thể hỏi quyền Micro), đọc 1 câu mẫu; kiểm chỗ văn bản xuất hiện | **Xác định:** văn bản nhận dạng chèn vào ô **Mô tả** (không vào ô khác). Độ chính xác không chấm (QO21). **Còn mở:** hộp thoại xin quyền Micro — chỉ ghi lại (QO6) | P3 | TC-29 · EP giọng nói × ô Mô tả · QO6/QO21 |
| TC-DSC-10 | Như DSC-09 ở ô "Vị trí cụ thể" | Văn bản chèn vào ô **Vị trí cụ thể**; độ chính xác không chấm | P3 | TC-29 · EP giọng nói × ô Vị trí |
| TC-DSC-11 | Như DSC-09 ở ô "Hành động đã thực hiện" | Văn bản chèn vào ô **Hành động đã thực hiện**; độ chính xác không chấm | P3 | TC-29 · EP giọng nói × ô Hành động |

---

## 6 · Bước 6 — Thông tin đối tượng · `TC-SUBJ` (mục 2 #6, kỹ thuật 5.6)

> EP (ma trận 4 loại giấy tờ × 2 cách), Error guessing có nguồn, Exploratory EXP-3/EXP-4. Dùng TK-DT-A trên M1; các bước khác đi LN-TT; kiểm lưu ở Chi tiết → khối "Thông tin liên quan" (họ tên, ngày sinh, giới tính, quốc tịch, CCCD hiển thị đầy đủ). **Lưu ý:** đặc tả liệt kê khối này **không có "Số hộ chiếu"** — nơi hiển thị số hộ chiếu đã lưu là câu hỏi mới (xem mục "Câu hỏi/gap mới"): các case có kiểm số hộ chiếu ghi lại, không chấm.
> **Quét giấy tờ:** Bước 6 → "Quét giấy tờ" → camera → chụp giấy tờ mẫu giả (bản in). **Từ thư viện:** "Từ thư viện" → chọn ảnh giấy tờ mẫu giả. Đối chiếu từng trường tự điền với bảng đối chiếu của giấy tờ mẫu; sai lệch ký tự do nhận dạng: ghi lại từng trường, không chấm (không có ngưỡng chính xác — QO21); chỉ chấm lỗi khi trường hoàn toàn không điền hoặc điền sai ô.
> **Trình tự gộp:** SUBJ-04…11 có thể chạy liên tiếp trong cùng 1 phiên Bước 6 (thêm lần lượt nhiều đối tượng), nhưng ghi kết quả riêng theo từng ID.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-SUBJ-01 | Bước 6: không thêm đối tượng, để trống số lượng/biển số/đơn vị; đi tiếp và gửi; mở Chi tiết | Tiếp tục sáng; gửi được; vụ việc không có đối tượng nào (khối "Thông tin liên quan" trống hoặc ẩn — chỉ ghi lại dạng nào) | P3 | TC-30 · EP 0 đối tượng |
| TC-SUBJ-02 ⚠️ | Nhập "Số lượng đối tượng" = 2, thêm đúng 2 đối tượng thủ công; gửi | **Xác định:** gửi được, không bị chặn. **Còn mở:** số lượng lưu/hiển thị ở đâu — chỉ ghi lại (QO12) | P3 | TC-31 · EP số lượng khớp · QO12 |
| TC-SUBJ-03 ⚠️ | Nhập "Số lượng đối tượng" = 5, chỉ thêm 2 đối tượng; gửi; mở Chi tiết | **Xác định:** không bị chặn; gửi được; Chi tiết có đúng 2 đối tượng. **Còn mở:** số lượng 5 lưu/hiển thị ở đâu (QO12) | P3 | TC-31 · EP số lượng không khớp · QO12 |
| TC-SUBJ-04 ⚠️ | Quét GT-1 (CCCD gắn chip) bằng camera; đối chiếu 6 trường; sửa không; ghi lại | 1 đối tượng được thêm ("Đã nhập 1 đối tượng"); Họ tên, Ngày sinh, Giới tính, Quốc tịch, **Số CCCD/CMND** tự điền khớp bảng đối chiếu. **Còn mở:** ô "Số hộ chiếu"; ngưỡng chính xác (QO21) — chỉ ghi lại | P1 | TC-32 · EP quét × CCCD · QO11/QO21 |
| TC-SUBJ-05 ⚠️ | Như SUBJ-04 với GT-2 (CMND) | Như SUBJ-04: số CMND vào ô **Số CCCD/CMND**; các trường khác khớp | P1 | TC-32 · EP quét × CMND |
| TC-SUBJ-06 ⚠️ | Như SUBJ-04 với GT-3 (hộ chiếu Việt Nam) | Họ tên, Ngày sinh, Giới tính, Quốc tịch khớp. **Còn mở:** số hộ chiếu vào ô nào (Số hộ chiếu hay Số CCCD/CMND) — chỉ ghi lại (QO11) | P1 | TC-32 · EP quét × hộ chiếu VN · QO11 |
| TC-SUBJ-07 ⚠️ | Như SUBJ-04 với GT-4 (hộ chiếu nước ngoài) | Họ tên, Ngày sinh, Giới tính, **Quốc tịch nước ngoài** khớp. **Còn mở:** số hộ chiếu vào ô nào — chỉ ghi lại (QO11) | P1 | TC-32 · EP quét × hộ chiếu NN · QO11 |
| TC-SUBJ-08 ⚠️ | "Từ thư viện" chọn ảnh GT-1; đối chiếu 6 trường | Như SUBJ-04 (đường thư viện) | P1 | TC-33 · EP thư viện × CCCD · QO11/QO21 |
| TC-SUBJ-09 ⚠️ | Như SUBJ-08 với GT-2 | Như SUBJ-05 | P1 | TC-33 · EP thư viện × CMND |
| TC-SUBJ-10 ⚠️ | Như SUBJ-08 với GT-3 | Như SUBJ-06 | P1 | TC-33 · EP thư viện × hộ chiếu VN · QO11 |
| TC-SUBJ-11 ⚠️ | Như SUBJ-08 với GT-4 | Như SUBJ-07 | P1 | TC-33 · EP thư viện × hộ chiếu NN · QO11 |
| TC-SUBJ-12 | Quét GT-1, **không sửa** trường nào; đi tiếp, gửi; mở Chi tiết | Giá trị lưu = giá trị tự điền (khớp Chi tiết) | P1 | TC-34 · EP không sửa |
| TC-SUBJ-13 | Quét GT-1, sửa **1 trường** (Họ tên thành `TEST GIA SUA`); gửi; mở Chi tiết | Chi tiết hiển thị `TEST GIA SUA`, không phải giá trị nhận dạng ban đầu; các trường còn lại không đổi | P1 | TC-34 · EP sửa 1 trường |
| TC-SUBJ-14 | Quét GT-1, sửa **nhiều trường** (Họ tên, Ngày sinh, Giới tính, Số CCCD/CMND) sang giá trị giả khác; gửi; mở Chi tiết | Mọi trường đã sửa lưu theo giá trị **đã sửa** | P1 | TC-34 · EP sửa nhiều trường |
| TC-SUBJ-15 🔭 | **Charter EXP-3** — Khám phá nhận dạng thất bại: quét/chọn GT-X (ảnh mờ, thiếu sáng, không phải giấy tờ, giấy tờ bị che); ghi app báo gì, trường nào điền thiếu, có thêm đối tượng rỗng không, có thử lại được không, ảnh quét có vào thư viện Ảnh không | **Phải quan sát/ghi lại** (QO11); không đạt/không đạt | P1 | TC-35 (+TC-36) · EXP-3 · QO11 |
| TC-SUBJ-16 | Sau SUBJ-04 (quét GT-1) không thêm ảnh bằng chứng nào; gửi; mở Chi tiết → Hình ảnh/Bằng chứng; màn xem lại | Không có ảnh giấy tờ trong Hình ảnh/Bằng chứng; màn xem lại "Bằng chứng: 0 tệp"; chỉ có dữ liệu văn bản của đối tượng | P1 | TC-36 · EP quét × Chi tiết vụ việc |
| TC-SUBJ-17 | Như SUBJ-16 nhưng thêm đối tượng bằng "Từ thư viện" (GT-1) | Như SUBJ-16 | P1 | TC-36 · EP thư viện × Chi tiết vụ việc |
| TC-SUBJ-18 ⚠️ | Ghi số ảnh trong Ảnh của iPhone; quét GT-1 bằng camera trong app; mở Ảnh của iPhone | **Còn mở — chỉ ghi lại hành vi quan sát được:** có ảnh giấy tờ mới xuất hiện trong thư viện Ảnh không (QO11) | P1 | TC-36 · EP quét × thư viện Ảnh · QO11 |
| TC-SUBJ-19 ⚠️ | Ghi số ảnh trong Ảnh; thêm đối tượng bằng "Từ thư viện" (GT-1); mở lại Ảnh | **Còn mở — chỉ ghi lại hành vi quan sát được:** ảnh gốc còn 1 bản hay xuất hiện bản sao/bị xoá (QO11) | P1 | TC-36 · EP thư viện × thư viện Ảnh · QO11 |
| TC-SUBJ-20 | Dùng công cụ quan sát lưu lượng mạng (hoặc nhật ký máy chủ do dev cung cấp), quét GT-1 bằng camera rồi gửi vụ việc | Không có yêu cầu mạng chứa ảnh giấy tờ trong lúc quét/nhận dạng; khi gửi chỉ dữ liệu văn bản. **Nếu không có công cụ:** ghi "không kiểm được" theo quyết định QC lead (G5) | P1 | TC-37 · EP quét × lưu lượng mạng |
| TC-SUBJ-21 | Như SUBJ-20 với đường "Từ thư viện" (GT-1) | Như SUBJ-20 | P1 | TC-37 · EP thư viện × lưu lượng mạng |
| TC-SUBJ-22 ⚠️ | "Thêm đối tượng thủ công": Họ tên `TEST GIA 22`, ngày sinh tự đặt, Giới tính **Nam**, Quốc tịch chọn 1 mục, Số CCCD/CMND `99000000022`, Số hộ chiếu `TESTHC022`; gửi; mở Chi tiết | **Xác định:** Họ tên, Ngày sinh, Giới tính, Quốc tịch, CCCD hiển thị đầy đủ, đúng giá trị nhập. **Còn mở:** nơi hiển thị Số hộ chiếu — chỉ ghi lại | P1 | TC-38 · EP giới tính Nam |
| TC-SUBJ-23 ⚠️ | Như SUBJ-22 với Giới tính **Nữ** (`TEST GIA 23`) | Như SUBJ-22, giới tính hiển thị Nữ | P1 | TC-38 · EP giới tính Nữ |
| TC-SUBJ-24 ⚠️ | Như SUBJ-22 với Giới tính **Khác** (`TEST GIA 24`) | Như SUBJ-22, giới tính hiển thị Khác | P1 | TC-38 · EP giới tính Khác |
| TC-SUBJ-25 ⚠️ | Mở danh sách Quốc tịch; ghi số mục, có ô tìm không; chọn 1 mục Việt Nam (nếu có) rồi 1 nước khác; gửi; mở Chi tiết | **Xác định:** chọn được từ danh sách; quốc tịch đã chọn lưu đúng. **Còn mở:** nội dung và độ dài danh sách (đặc tả chưa cung cấp — QO10) | P1 | TC-38 · EP quốc tịch · QO10 |
| TC-SUBJ-26 🔭 | **Charter EXP-4** — Khám phá quy tắc hợp lệ trường đối tượng: đối tượng để trống toàn bộ, định dạng ngày sinh (tương lai, sai ngày), độ dài/ký tự chữ trong số CCCD, quốc tịch nước ngoài nhập vào ô CCCD | **Phải quan sát/ghi lại** (QO10); không đạt/không đạt | P1 | TC-39 · EXP-4 · QO10 |
| TC-SUBJ-27 ⚠️ | **EG (nguồn: wireframe V7, ảnh `03_case-create_06_subject-info_filled-v2`)** — Thêm đối tượng có quốc tịch nước ngoài, nhập số hộ chiếu giả vào ô "Số CCCD/CMND", để trống "Số hộ chiếu"; đi tiếp | **Phải quan sát/ghi lại:** app có chặn/cảnh báo không (QO10); không đạt/không đạt | P1 | TC-39 · EG V7 · QO10 |
| TC-SUBJ-28 ⚠️ | **EG (nguồn: wireframe V12, màn S07)** — Bấm "Quét giấy tờ", quan sát giao diện camera: có khung căn/hướng dẫn của app không, hay là camera chụp thông thường; chụp xong có màn xác nhận/đang nhận dạng không | **Phải quan sát/ghi lại** (QO11); không đạt/không đạt | P1 | TC-35 · EG V12 · QO11 |
| TC-SUBJ-29 | Thêm 3 đối tượng (1 quét GT-1, 1 từ thư viện GT-2, 1 thủ công); dùng nút xoá của đối tượng giữa; gửi; mở Chi tiết | Hiển thị "Đã nhập 3 đối tượng" rồi còn 2 sau khi xoá; đối tượng bị xoá biến mất, hai đối tượng còn lại đúng dữ liệu; Chi tiết có đúng 2 đối tượng; số CCCD hiển thị **đầy đủ, không che** | P2 | TC-40 · EP ≥2 đối tượng, xoá 1 |
| TC-SUBJ-30 ⚠️ | Nhập "Biển số xe" `00A-000.00` (giả) và "Đơn vị liên quan" `Đơn vị thử nghiệm`; không bấm tra cứu; gửi; tìm nơi hiển thị trong Chi tiết | **Xác định:** nhập tay được, không bị chặn, gửi được. **Còn mở:** màn nào hiển thị biển số/đơn vị (Chi tiết không liệt kê); nút "Tra biển số" còn hiện hay ẩn — chỉ ghi lại (QO13) | P3 | TC-41 · EP biển số/đơn vị · QO13 |
| TC-SUBJ-31 ⚠️ | **EG (nguồn: checklist `requirements/exploratory/03_case-create.md` CRE-Q05)** — Nếu nút "Tra biển số" còn hiện: nhập biển số giả, bấm; ghi nguồn tra, kết quả, ô nào được tự điền | **Phải quan sát/ghi lại** (QO13; đặc tả [Q35]: chưa có tra cứu tự động); không đạt/không đạt. Nếu nút ẩn: ghi "không có nút" | P3 | TC-41 · EG CRE-Q05 · QO13 |

---

## 7 · Bước 7 — Đề xuất xử lý · `TC-PROP` (mục 2 #7, kỹ thuật 5.7)

> BVA 2-value số lựa chọn {0, 1} và {4, 5}. Năm mục: Nhắc nhở, khuyến cáo · Đưa vào diện chú ý · Bàn giao · Phối hợp · Khác. Dùng TK-DT-A trên M1; kiểm ở Chi tiết → khối "Đề xuất xử lý của cán bộ".

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-PROP-01 | Bước 7: không chọn mục nào; Tiếp tục; gửi; mở Chi tiết | Tiếp tục sáng; gửi được; khối "Đề xuất xử lý của cán bộ" không liệt kê mục nào (ẩn hay rỗng: chỉ ghi lại dạng nào) | P3 | TC-42 · BVA 0 lựa chọn |
| TC-PROP-02 | Chọn đúng 1 mục (Nhắc nhở, khuyến cáo); gửi; mở Chi tiết | Chi tiết liệt kê đúng 1 mục đã chọn | P3 | TC-42 · BVA 1 lựa chọn |
| TC-PROP-03 | Chọn 4 mục (trừ "Khác"); gửi; mở Chi tiết | Chi tiết liệt kê đúng 4 mục đã chọn, không có mục thứ 5 | P3 | TC-42 · BVA 4 lựa chọn |
| TC-PROP-04 ⚠️ | Chọn cả 5 mục (gồm "Khác"); nếu "Khác" làm hiện ô nhập, ghi lại và điền `Đề xuất thử nghiệm` để đi tiếp; gửi; mở Chi tiết | **Xác định:** Chi tiết liệt kê đủ 5 mục đã chọn. **Còn mở:** "Khác" có ô nhập không, ảnh hưởng nút Tiếp tục không (QO14) | P3 | TC-42 · BVA 5 lựa chọn · QO14 |
| TC-PROP-05 🔭 | **Charter EXP-6 (phần Bước 7)** — Khám phá mục "Khác": chọn "Khác" có ô nhập tự do không, nhập gì được, bỏ trống thì sao, hiển thị ở Chi tiết thế nào | **Phải quan sát/ghi lại** (QO14); không đạt/không đạt | P3 | TC-43 · EXP-6 · QO14 |

---

## 8 · Bước 8 — Giao việc, phạm vi giao · `TC-ASG` (mục 2 #8, kỹ thuật 5.8)

> Decision Table phạm vi giao (A1–A3), BVA số cán bộ, State Transition đổi Đội, EP tìm kiếm, Exploratory EXP-7. Các bước 1–7 đi LN-TT. Đội A có ≥3 cán bộ, Đội B có CB-B1.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-ASG-01 | TK-DT-A, Bước 8: chọn/giữ Đội A, không chọn cán bộ nào; thử bấm Tiếp tục | 0 cán bộ → Tiếp tục mờ, không sang Bước 9 | P1 | TC-44 · BVA 0 |
| TC-ASG-02 | Tìm theo email CB-A1 và chọn đúng 1 cán bộ; Tiếp tục; hoàn tất và gửi; mở Chi tiết | Chip cán bộ hiện; Tiếp tục sáng; Chi tiết có đúng 1 phần việc cho CB-A1 | P1 | TC-44 · BVA 1 |
| TC-ASG-03 | Chọn CB-A1 và CB-A2, rồi thêm CB-A3 (tất cả); bỏ chọn 1 người bằng nút ✕ trên chip; bỏ hết, quan sát nút | Chọn nhiều được; người đã chọn hiện dạng chip; bỏ chọn được; bỏ hết thì Tiếp tục mờ lại | P1 | TC-44 · BVA nhiều/bỏ chọn |
| TC-ASG-04 | Bước 8 với TK-DT-A: ghi mục Đội và danh sách cán bộ | Đội = **Đội A** (cố định), không chọn được Đội khác; danh sách chỉ gồm thành viên Đội A, không có CB-B1 | P1 | TC-45 · DT A1 (Đội trưởng/Chỉ huy Đội) |
| TC-ASG-05 | Như ASG-04 với TK-TT-A | Như ASG-04 | P1 | TC-45 · DT A1 (Tổ trưởng) |
| TC-ASG-06 | Như ASG-04 với TK-TP-A | Như ASG-04 | P1 | TC-45 · DT A1 (Tổ phó) |
| TC-ASG-07 | Như ASG-04 với TK-PDT-A | Như ASG-04 | P1 | TC-45 · DT A1 (Phó đội trưởng) |
| TC-ASG-08 | Như ASG-04 với TK-UQ | Như ASG-04 | P1 | TC-45 · DT A1 (cán bộ uỷ quyền) |
| TC-ASG-09 | Lần lượt TK-TC rồi TK-PTC. Bước 8: ghi mục Đội; chọn Đội A → danh sách; chọn Đội B → danh sách; thử chọn cả hai Đội | Chọn được **đúng 1** Đội bất kỳ (chọn Đội thứ hai thì thay thế, không cộng thêm); danh sách cán bộ chỉ gồm thành viên của Đội đang chọn (cả hai tài khoản) | P1 | TC-45/TC-46 · DT A2 |
| TC-ASG-10 | TK-DT-A: tìm email CB-B1 ở ô tìm. TK-TC: chọn Đội A và CB-A1, tìm email CB-B1 | CB-B1 **không** hiện với TK-DT-A; với TK-TC (Đội A đang chọn) cũng không hiện — không thể có cán bộ của 2 Đội trong cùng 1 vụ việc. Cách hiển thị khi tìm không có kết quả: chỉ ghi lại (QO15) | P1 | TC-45/TC-46 · DT A3 |
| TC-ASG-11 ⚠️ | TK-TC vào Bước 8, ghi trạng thái ban đầu của mục Đội; chọn Đội A → ghi danh sách; chọn CB-A1 | **Xác định:** chọn Đội A → danh sách = thành viên Đội A; chọn CB-A1 → chip hiện, Tiếp tục sáng. **Còn mở:** có Đội chọn sẵn từ đầu không (test basis không nêu) — chỉ ghi lại | P1 | TC-46 · ST chọn Đội → chọn cán bộ |
| TC-ASG-12 | TK-TC: chọn Đội A (chưa chọn cán bộ), đổi sang Đội B | Danh sách cán bộ đổi theo Đội B; không còn cán bộ Đội A | P1 | TC-46 · ST đổi Đội khi chưa chọn cán bộ |
| TC-ASG-13 ⚠️ | TK-TC: chọn Đội A + CB-A1, rồi đổi sang Đội B; ghi chip CB-A1 còn hay mất, có cảnh báo không, nút Tiếp tục; nếu đi tiếp được, hoàn tất và gửi, mở Chi tiết | **Xác định:** danh sách đổi theo Đội B; vụ việc đã gửi không chứa cán bộ của 2 Đội (mọi phần việc thuộc cùng 1 Đội). **Còn mở:** cách xử lý cán bộ đã chọn khi đổi Đội — chỉ ghi lại (QO29) | P1 | TC-46 · ST đổi Đội sau khi chọn cán bộ · QO29 |
| TC-ASG-14 | TK-DT-A: gõ nguyên email CB-A1 vào ô "Tìm theo email" | Danh sách thu về CB-A1; chọn được | P2 | TC-47 · EP khớp đúng |
| TC-ASG-15 ⚠️ | Gõ email không tồn tại; sau đó gõ phần đầu email và gõ email viết HOA | **Còn mở — chỉ ghi lại hành vi quan sát được:** hiển thị khi không có kết quả; khớp một phần có ra kết quả không; phân biệt hoa/thường không (QO15) | P2 | TC-47 · EP không khớp · QO15 |
| TC-ASG-16 | Xoá sạch ô tìm | Danh sách trở về đầy đủ thành viên trong phạm vi giao | P2 | TC-47 · EP rỗng |
| TC-ASG-17 🔭 | **Charter EXP-7** — Khám phá người giao tự chọn mình làm cán bộ nhận việc, hoặc chọn người cũng có quyền giao (vd Tổ phó, Đội trưởng khác): có hiện trong danh sách không, chọn và gửi được không, vụ việc hiện thế nào ở tab Của tôi | **Phải quan sát/ghi lại** (QO16); không đạt/không đạt | P2 | TC-48 · EXP-7 · QO16 |

---

## 9 · Bước 9 — Hạn, xem lại, gửi · `TC-SUB` (mục 2 #9, kỹ thuật 5.9)

> EP bộ dữ liệu (tối thiểu / đầy đủ), BVA hạn quanh thời điểm hiện tại T, EP mã vụ việc, Exploratory EXP-5/EXP-8. Giờ đặt hạn theo giờ Việt Nam. Độ chi tiết "quá khứ" tính theo phút hay giây chưa rõ (QO17) nên quanh T chỉ ghi lại.
> **Dữ liệu tối thiểu:** KV-A1, L-1, Bình thường, mô tả, Đội A + CB-A1, hạn. **Dữ liệu đầy đủ:** thêm 2 ảnh, Khu vực/Loại/Mức độ Nghiêm trọng, 3 ô mô tả, 2 đối tượng (1 quét, 1 thủ công), biển số, đơn vị liên quan, 3 đề xuất, 2 cán bộ (CB-A1, CB-A2), hạn.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-SUB-01 | Nhập **dữ liệu tối thiểu** đến Bước 9, đọc màn xem lại (chưa gửi) | Tóm tắt hiện đúng loại, mô tả, "Bằng chứng: 0 tệp", người được giao (email · Đội) và hạn đã chọn. Các mục khác (khu vực, mức độ, đối tượng, đề xuất) hiện hay không: chỉ ghi lại (đặc tả không bắt buộc) | P2 | TC-49 · EP bộ tối thiểu |
| TC-SUB-02 | Nhập **dữ liệu đầy đủ** đến Bước 9, đọc màn xem lại | "Bằng chứng: 2 tệp"; loại, mô tả, 2 người được giao và hạn đúng với đã nhập. Các mục khác: chỉ ghi lại | P2 | TC-49 · EP bộ đầy đủ |
| TC-SUB-03 ⚠️ | Gửi vụ việc **dữ liệu tối thiểu**; mở Chi tiết và đọc mọi khối | **Xác định:** Đầu trang có mã VV, trạng thái "Đang thực hiện", loại · khu vực, mức độ, mô tả; "Giao việc 0/1" với Đội · cán bộ; Thông tin vụ việc có Đội phụ trách, Hạn xử lý, Thời gian tạo (sát giờ gửi); Vị trí và Hành động trống; Diễn biến xử lý có dòng giao việc của người tạo. **Còn mở:** nội dung "NỘI DUNG" của phần việc lấy từ đâu (QO19) — chỉ ghi lại | P1 | TC-56 · EP bộ tối thiểu · QO19 |
| TC-SUB-04 ⚠️ | Gửi vụ việc **dữ liệu đầy đủ**; mở Chi tiết và đọc mọi khối | **Xác định:** mọi giá trị nhập hiện đúng: loại, khu vực, mức độ, mô tả, Vị trí, Hành động, Hạn xử lý, Thời gian tạo, 2 phần việc (CB-A1, CB-A2) "Giao việc 0/2", 2 đối tượng (CCCD hiển thị đầy đủ), Đề xuất xử lý đủ 3 mục, 2 ảnh. **Còn mở:** nơi hiển thị biển số, đơn vị liên quan, số lượng đối tượng; nguồn "NỘI DUNG" phần việc (QO12/QO19) — chỉ ghi lại | P1 | TC-56 · EP bộ đầy đủ · QO19 |
| TC-SUB-05 | Bước 9: chọn ngày **hôm qua** (nếu bộ chọn cho phép) | Không có hạn quá khứ hợp lệ: bộ chọn không cho chọn hoặc nút "Giao việc và gửi" không sáng | P1 | TC-51 · BVA ngày hôm qua |
| TC-SUB-06 | Chọn **hôm nay**, giờ sớm hơn hiện tại ít nhất 1 giờ (chạy khi sau 01:00) | Không chọn được hoặc nút "Giao việc và gửi" không sáng | P1 | TC-51 · BVA hôm nay giờ < T |
| TC-SUB-07 ⚠️ | Chọn hôm nay, giờ = T−1 phút rồi T+1 phút (T là giờ hiện tại); ghi từng lần | **Còn mở — chỉ ghi lại hành vi quan sát được:** hành vi sát giờ hiện tại (độ chi tiết phút/giây, kiểm lúc chọn hay lúc gửi — QO17) | P1 | TC-51 · BVA hôm nay sát T · QO17 |
| TC-SUB-08 | Chọn hôm nay, giờ muộn hơn hiện tại ≥ 30 phút (nếu qua 23:30 thì chạy lại vào ngày khác) | Chọn được; nút "Giao việc và gửi" sáng; gửi được | P1 | TC-51 · BVA hôm nay giờ > T |
| TC-SUB-09 | Chạy **trước 17:00**. Bước 9: chọn ngày hôm nay, đọc giờ mặc định; đổi sang 18:30 | Giờ mặc định là **17:00**; đổi được sang giờ khác | P1 | TC-50 · BVA mặc định 17:00 |
| TC-SUB-10 ⚠️ | Chạy **sau 17:00**. Bước 9: chọn ngày hôm nay; ghi giờ mặc định, trạng thái nút | **Còn mở — chỉ ghi lại hành vi quan sát được:** giờ mặc định hiển thị gì, 17:00 đã qua có bị chặn không (QO17) | P1 | TC-50 · BVA mặc định khi quá 17:00 · QO17 |
| TC-SUB-11 | Chọn hạn rất xa: 31/12 của 5 năm sau, 17:00 (mốc thử, không phải biên của spec); gửi; mở Chi tiết | Chọn được, không có giới hạn tối đa; gửi được; Chi tiết hiển thị đúng hạn đã chọn | P1 | TC-51 · BVA hạn xa tương lai |
| TC-SUB-12 ⚠️ | Chọn hạn = hôm nay, T+3 phút (nếu bộ chọn tính theo phút); đứng yên ở Bước 9 đến khi hạn đã qua; bấm "Giao việc và gửi"; nếu vụ việc được tạo, xem Chi tiết (nhãn "Quá hạn xử lý"?) | **Còn mở — chỉ ghi lại hành vi quan sát được:** bị chặn lúc gửi hay vẫn tạo vụ việc có hạn đã qua (QO17) | P1 | TC-51 · BVA hạn qua lúc gửi · QO17 |
| TC-SUB-13 | Nhập vụ việc giao 2 cán bộ (CB-A1, CB-A2), hạn ngày mai 18:30; gửi; mở Chi tiết | "Hạn xử lý" của vụ việc = 18:30 ngày mai; mỗi phần việc có "Hạn" bằng đúng 18:30 ngày mai; định dạng giờ Việt Nam | P1 | TC-50 · lưu hạn |
| TC-SUB-14 🔭 | **Charter EXP-8** — Khám phá hạn khi đặt múi giờ thiết bị khác (vd UTC−5, UTC+9): bộ chọn ngày giờ hiển thị gì, nhãn "giờ Việt Nam", hạn lưu và hiển thị ở Chi tiết, so với giờ Việt Nam; đặt lại múi giờ sau phiên | **Phải quan sát/ghi lại** (QO17); không đạt/không đạt | P2 | TC-52 · EXP-8 · QO17 |
| TC-SUB-15 | Ở Bước 9 tìm mọi nút/lựa chọn; đọc dòng chữ hướng dẫn | Chỉ có nút "Giao việc và gửi" (và Quay lại); **không** có nút/lựa chọn "Xử lý tại chỗ và hoàn thành". Nếu còn dòng chữ hướng dẫn nhắc đến phần này: ghi lại nguyên văn (nghi sót nội dung — báo QC lead) | P3 | TC-53 |
| TC-SUB-16 | Gửi 1 vụ việc LN-TT; đọc mã trên Chi tiết và thẻ | Mã dạng **VV + 6 chữ số**; ghi lại mã | P1 | TC-54 · EP 1 lần gửi |
| TC-SUB-17 | TK-DT-A tạo xen kẽ: vụ việc (XL01) → giao việc (GV01, option Giao việc) → vụ việc → giao việc; ghi 4 mã | Cả 4 mã dạng VV + 6 chữ số; **đôi một khác nhau** (không trùng giữa hai loại). Thứ tự tăng dần: chỉ ghi lại, không chấm | P1 | TC-54 · EP xen kẽ XL01/GV01 |
| TC-SUB-18 🆕 | TK-DT-A trên M1 và TK-TT-A trên M2 cùng đi đến Bước 9 với dữ liệu tối thiểu; đếm "3-2-1" rồi cùng bấm "Giao việc và gửi"; lặp 3 lần | Mỗi lần mỗi máy tạo đúng 1 vụ việc; 6 mã khác nhau, dạng VV + 6 chữ số. **Lý do 🆕:** nguồn G8 mục 11 test plan ("bổ sung case nếu có thể chạy 2 thiết bị"); không có dòng ở mục 5 → ghi P2, không nâng lên P1 | P2 | TC-54 (mở rộng) · G8 |
| TC-SUB-19 🔭 | **Charter EXP-5** — Khám phá bấm "Giao việc và gửi" nhiều lần liên tiếp, mạng chập chờn (ngắt/bật khi đang gửi), mạng yếu, lỗi máy chủ nếu giả lập được: có tạo trùng vụ việc/phần việc/thông báo không; dữ liệu có giữ để gửi lại không; thông báo lỗi | **Phải quan sát/ghi lại** (QO18); không đạt/không đạt | P1 | TC-55 (+TC-07) · EXP-5 · QO18 |

---

## 10 · Hậu điều kiện: trạng thái, hiển thị, thông báo, nhắc việc, nhật ký, thống kê · `TC-POST` (mục 2 #10, kỹ thuật 5.10)

> Decision Table hiển thị (P1–P6), EP số cán bộ/khoảng hạn/Đội-Tổ/thống kê. Vụ việc mẫu: tạo bởi **TK-TT-A** (Đội A, KV-A1) trừ khi ghi khác. Người đối chiếu đăng nhập trên M2 (kéo làm mới/đăng nhập lại để thấy dữ liệu mới); thống kê chọn khoảng "Hôm nay", ghi số trước/sau.
> **Thống kê (cột cuối của DT hiển thị)** được kiểm riêng ở POST-10…12 (TC-64), không lặp lại ở POST-04…09.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-POST-01 | TK-TT-A giao 1 cán bộ (CB-A1); mở Chi tiết | 1 phần việc của CB-A1: TIẾN ĐỘ "Đã giao", KẾT QUẢ "Chưa bắt đầu"; bộ đếm "Giao việc 0/1"; trạng thái vụ việc "Đang thực hiện" | P1 | TC-57 · EP 1 cán bộ |
| TC-POST-02 | Giao 2 cán bộ (CB-A1, CB-A2 khác Tổ); mở Chi tiết | 2 phần việc, mỗi người đúng 1, đều "Đã giao"/"Chưa bắt đầu"; bộ đếm "Giao việc 0/2" | P1 | TC-57 · EP 2 cán bộ |
| TC-POST-03 | Giao 3 cán bộ (CB-A1, CB-A2, CB-A3); mở Chi tiết | 3 phần việc, mỗi người đúng 1; bộ đếm "Giao việc 0/3" | P1 | TC-57 · EP nhiều cán bộ |
| TC-POST-04 | TK-TT-A tạo và giao CB-A1; xem tab Của tôi và Tiếp nhận của TK-TT-A | Vụ việc hiện ở **cả** Của tôi và Tiếp nhận của người tạo | P1 | TC-58 · DT P1 |
| TC-POST-05 | Vụ việc ở POST-04 (Đội A); đăng nhập TK-TP-A (người giao khác trong Đội A, không được chỉ định) xem tab Của tôi, Tiếp nhận, Thông báo | Tiếp nhận **hiện** vụ việc; Của tôi **không** hiện; không có thông báo "Bạn có phần việc mới" | P1 | TC-59 · DT P2 |
| TC-POST-06 | Vụ việc ở POST-04; đăng nhập TK-DT-B (người giao Đội B); xem tab Tiếp nhận, Của tôi, tìm theo mã VV | Tiếp nhận **không** hiện; Của tôi không hiện; tìm theo mã không ra; không có thông báo | P1 | TC-59 · DT P3 |
| TC-POST-07 | Vụ việc ở POST-04; đăng nhập CB-A1 (được chỉ định) trên M2 (đã đăng nhập sẵn lúc gửi); xem thanh tab, Của tôi, Thông báo | Của tôi **hiện** vụ việc; **không** có tab Tiếp nhận; tab Thông báo có **đúng 1** thông báo "Bạn có phần việc mới" và chỉ nhận 1 thông báo đẩy (không lặp); không SMS | P1 | TC-60 · DT P4 |
| TC-POST-08 | Vụ việc ở POST-04 (chỉ giao CB-A1); đăng nhập CB-A2 (không được chỉ định) xem Của tôi và Thông báo | Của tôi **không** hiện vụ việc; không có tab Tiếp nhận; không có thông báo "Bạn có phần việc mới" | P1 | TC-60/TC-58 · DT P5 |
| TC-POST-09 ⚠️ | TK-TC tạo vụ việc, chọn Đội A, giao CB-A1. Xem tab Của tôi và Tiếp nhận của TK-TC; tab Tiếp nhận của TK-TP-A (Đội A) và của TK-DT-B (Đội B) | **Xác định:** tab Của tôi của TK-TC **hiện** vụ việc. **⚑ QO25 — không chấm, chỉ ghi quan sát:** vụ việc có hiện ở Tiếp nhận của Đội A, của chính TK-TC, hay của ai | P1 | TC-58/TC-59 · DT P6 · ⚑ QO25 |
| TC-POST-10 | Đăng nhập TK-TP-A (Đội A) và CB-A1, ghi thống kê Trang chủ (Tổng vụ việc, Khẩn cấp mở, Vụ việc theo khu vực tại KV-A1). TK-TT-A tạo 1 vụ việc **Khẩn cấp** tại KV-A1 giao CB-A1. Làm mới và ghi lại | Cả hai tài khoản (cùng Đội A): Tổng vụ việc **+1**, Khẩn cấp mở **+1**, Vụ việc theo khu vực tại KV-A1 **+1**; hai tài khoản thấy số giống nhau | P2 | TC-64 · EP người cùng Đội × 3 chỉ số |
| TC-POST-11 | Ghi thống kê Trang chủ của TK-DT-B và CB-B1 (Đội B) trước và sau POST-10 | Không có chỉ số nào đổi (vụ việc không thuộc Đội B) | P2 | TC-64 · EP người Đội khác |
| TC-POST-12 | TK-TC tạo vụ việc **Khẩn cấp**: Bước 2 chọn KV-A1, Bước 8 chọn Đội B giao CB-B1. Ghi thống kê Trang chủ của TK-DT-B trước/sau, và của TK-TP-A (Đội A) | Thống kê **Đội B**: Tổng vụ việc +1, Khẩn cấp mở +1, "Vụ việc theo khu vực" có KV-A1 (khu vực ngoài Đội B) +1. Thống kê Đội A **không** đổi. Thống kê của chính TK-TC: chỉ ghi lại | P2 | TC-64 · EP Trưởng/Phó trưởng CACK, khu vực ngoài Đội (QB3) |
| TC-POST-13 ⚠️ | CB-A1 đăng nhập M2 với thông báo bật. Tạo vụ việc giao CB-A1 có hạn = **giao + 1 giờ**; ghi giờ giao (Diễn biến xử lý/Lịch sử), tính nhắc = giao + 2/3 × (hạn − giao) (= giao + 40 phút); đọc trường NHẮC VIỆC của phần việc; chờ đến giờ nhắc | **Xác định theo công thức BR11:** trường NHẮC VIỆC và thông báo nhắc trong ứng dụng khớp thời điểm tính (sai số ≤ 10 giây theo ví dụ BR11; nếu giờ giao chỉ có đến phút thì ≤ 1 phút — ghi lại); nhắc **đúng 1 lần**. **Ghi chú:** công thức là "suy ra" từ ảnh, cần khách hàng xác nhận khi nghiệm thu | P2 | TC-61 · EP hạn−giao ngắn trong ngày · BR11 |
| TC-POST-14 ⚠️ | Tạo vụ việc giao CB-A1 vào buổi chiều (vd 14:15) với hạn 17:00 **ngày hôm sau**; ghi giờ giao, tính nhắc, đọc trường NHẮC VIỆC (chờ đến giờ nhắc nếu thực hiện được) | Trường NHẮC VIỆC khớp công thức (với giao 14:15:00 → 08:05 ngày hôm sau, như ví dụ BR11); sai số như POST-13; nhắc đúng 1 lần nếu chờ | P2 | TC-61 · EP qua đêm · BR11 |
| TC-POST-15 ⚠️ | Tạo vụ việc giao CB-A1 với hạn 17:00 sau **3 ngày**; ghi giờ giao, tính nhắc (ví dụ giao 10:00 ngày D → hạn 17:00 D+3: nhắc 14:40 ngày D+2); đọc trường NHẮC VIỆC | Trường NHẮC VIỆC khớp công thức; sai số như POST-13 | P2 | TC-61 · EP nhiều ngày · BR11 |
| TC-POST-16 ⚠️ | Vụ việc giao 2 cán bộ; với mỗi phần việc bấm "Lịch sử"; tìm nút sửa/xoá dòng nhật ký | **Xác định:** mỗi phần việc có dòng nhật ký việc giao (giờ · người thực hiện là người giao · hành động) sát giờ gửi; không có cách sửa/xoá dòng. **Còn mở:** tên hành động ("Giao việc" hay "Phân công") và số bản ghi mỗi phần việc (QO19) — chỉ ghi lại | P2 | TC-62 · QO19 |
| TC-POST-17 | Giao 1 cán bộ CB-A1 (Tổ của CB-A1 khác Tổ của người tạo); xem thẻ ở tab Tiếp nhận và Đội phụ trách/Tổ ở Chi tiết | Thẻ hiện Đội/Tổ của **cán bộ được giao**, không phải của người tạo | P2 | TC-63 · EP 1 cán bộ (QB1(b)) |
| TC-POST-18 | Giao CB-A1 và CB-A3 (cùng Tổ); xem thẻ ở Tiếp nhận | Thẻ hiện đúng Đội/Tổ chung của hai cán bộ | P2 | TC-63 · EP nhiều cán bộ cùng Tổ |
| TC-POST-19 ⚠️ | Giao CB-A1 và CB-A2 (cùng Đội A, **khác Tổ**); xem thẻ ở Tiếp nhận và Chi tiết | **Còn mở — chỉ ghi lại hành vi quan sát được:** thẻ hiện Tổ nào (một Tổ, cả hai, hay chỉ Đội); Chi tiết có cùng quy tắc không (QO26) | P2 | TC-63 · EP nhiều cán bộ khác Tổ · QO26 |

---

## Tổng hợp

### Số case theo nhóm và ưu tiên

| Nhóm | Số case | P1 | P2 | P3 | 🔭 | ⚠️ | 🆕 |
|---|---:|---:|---:|---:|---:|---:|---:|
| AUTH | 15 | 15 | 0 | 0 | 0 | 8 | 0 |
| NAV | 18 | 10 | 7 | 1 | 1 | 4 | 0 |
| EVD | 14 | 3 | 10 | 1 | 1 | 5 | 0 |
| CLS | 27 | 17 | 7 | 3 | 0 | 8 | 1 |
| DSC | 11 | 4 | 4 | 3 | 1 | 4 | 0 |
| SUBJ | 31 | 25 | 1 | 5 | 2 | 20 | 0 |
| PROP | 5 | 0 | 0 | 5 | 1 | 1 | 0 |
| ASG | 17 | 13 | 4 | 0 | 1 | 3 | 0 |
| SUB | 19 | 14 | 4 | 1 | 2 | 5 | 1 |
| POST | 19 | 9 | 10 | 0 | 0 | 6 | 0 |
| **Cộng** | **176** | **110** | **47** | **19** | **9** | **64** | **2** |

*(9 case 🔭 thuộc 8 charter: EXP-6 tách thành TC-DSC-08 và TC-PROP-05. Case EG SUBJ-27/28/31 tính vào ⚠️, không tính 🔭.)*

### Ma trận truy vết TC (test plan) → case

| TC | Case | TC | Case | TC | Case |
|---|---|---|---|---|---|
| 01 | AUTH-01,02,04,05,06 | 23 | CLS-14,15 | 45 | ASG-04…10 |
| 02 | AUTH-03 | 24 | CLS-16,17 | 46 | ASG-09…13 |
| 03 | AUTH-07 | 25 | CLS-18,19,20 | 47 | ASG-14,15,16 |
| 04 | AUTH-08 | 26 | CLS-21…27 | 48 | ASG-17 |
| 05 | AUTH-09,10 | 27 | DSC-01…04 | 49 | SUB-01,02 |
| 06 | AUTH-11 | 28 | DSC-05…08 | 50 | SUB-09,10,13 |
| 07 | AUTH-12…15 | 29 | DSC-09,10,11 | 51 | SUB-05…08,11,12 |
| 08 | NAV-17 | 30 | SUBJ-01 | 52 | SUB-14 |
| 09 | NAV-11…16 | 31 | SUBJ-02,03 | 53 | SUB-15 |
| 10 | NAV-18 | 32 | SUBJ-04…07 | 54 | SUB-16,17,18 |
| 11 | NAV-01…10 | 33 | SUBJ-08…11 | 55 | SUB-19 |
| 12 | EVD-01 | 34 | SUBJ-12,13,14 | 56 | SUB-03,04 |
| 13 | EVD-02,03,04 | 35 | SUBJ-15,28 | 57 | POST-01,02,03 |
| 14 | EVD-05,06 | 36 | SUBJ-16…19 | 58 | POST-04,08,09 |
| 15 | EVD-07,08,09 | 37 | SUBJ-20,21 | 59 | POST-05,06,09 |
| 16 | EVD-10 | 38 | SUBJ-22…25 | 60 | POST-07,08 |
| 17 | EVD-11,12,13 | 39 | SUBJ-26,27 | 61 | POST-13,14,15 |
| 18 | EVD-14 | 40 | SUBJ-29 | 62 | POST-16 |
| 19 | CLS-09,10 | 41 | SUBJ-30,31 | 63 | POST-17,18,19 |
| 20 | CLS-01…06 | 42 | PROP-01…04 | 64 | POST-10,11,12 |
| 21 | CLS-11 🆕 | 43 | PROP-05 | 65 | CLS-07,08 |
| 22 | CLS-12,13 | 44 | ASG-01,02,03 | | |

Mọi TC-01…65 đều có ≥1 case. Ngoại lệ về truy vết: **TC-21** không có dòng ở mục 5 test plan (case CLS-11 đánh 🆕); **SUB-18** (🆕) bám G8 mục 11, không bám mục 5.
