# Test Case Specification — Tạo vụ việc xử lý vi phạm (XL01, flow `03_case-create`) — theo đặc tả v2.1 + làm rõ 2026-10-27/28

> Thiết kế case theo [test-plan-dac-ta-v2.1-lam-ro-10-28.md](test-plan-dac-ta-v2.1-lam-ro-10-28.md) (ISTQB Foundation) — bám đúng kỹ thuật đã chọn ở mục 5 test plan (bảng quyết định, phân vùng, giá trị biên, chuyển trạng thái, khám phá, đoán lỗi có nguồn).
> Test analysis: [test-analysis-dac-ta-v2.1-lam-ro-10-28.md](test-analysis-dac-ta-v2.1-lam-ro-10-28.md) (79 test condition `TC-nn`). **Chú ý:** `TC-nn` ở cột "Truy vết" là mã test condition của test analysis mới; mã case ở cột ID có dạng `TC-<NHÓM>-nn` — hai loại mã không trùng nghĩa với `TC-nn` của bộ cũ `*-dac-ta-v2.1.md`.
> Test basis (câu trả lời sau thay câu trước): [lam-ro-2026-10-27.md](../../specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-27.md) > [lam-ro-2026-10-26.md](../../specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-26.md) > [dac-ta-chuc-nang-v2.1.md](../../specs/xu-ly-vi-pham-giao-viec/dac-ta-chuc-nang-v2.1.md) > [mo-ta-chuc-nang-v1.md](../../specs/xu-ly-vi-pham-giao-viec/mo-ta-chuc-nang-v1.md). Bằng chứng giao diện (không phải test basis): [iphone/index.md](../../ui/ux/screenshots/iphone/index.md).
> Test Plan Status khi thiết kế (đã tự kiểm tra lại): **READY (có điều kiện)**. Bộ cũ `*-dac-ta-v2.1.md` không dùng làm căn cứ kết quả mong đợi (quyền "cán bộ không tạo được vụ việc" của bộ cũ nay sai).

## Quy ước

- **Ưu tiên:** P1 (chặn phát hành) · P2 · P3 — kế thừa đúng mục 6 test plan (mỗi case lấy ưu tiên của test condition `TC-nn` mà nó phủ), không tự đổi.
- **🔭 Exploratory** — charter EXP-1…EXP-10 (mục 5.12 test plan). Cột "Kết quả mong đợi" ghi "**Phải quan sát/ghi lại**", không chấm đạt/không đạt; ghi vào biên bản phiên (mẫu ở [screenshots/README.md](screenshots/README.md)). Thời lượng phiên đề xuất 30–45 phút (chờ QC lead duyệt).
- **⚠️ Phụ thuộc câu hỏi mở (QOnn)** — chỉ phần ghi **"Còn mở — chỉ ghi lại hành vi quan sát được"** không chấm đạt/không đạt; phần **"Xác định"** của cùng case chấm bình thường. Không tự suy đoán câu trả lời.
- **⚑ QO25, QO42** — điểm suy ra, **không** dùng làm tiêu chí đạt/không đạt; chỉ ghi quan sát (mỗi chỗ có chữ "⚑ chỉ ghi quan sát").
- **QO44:** ở XL01 chỉ kiểm **sự có mặt/vắng mặt** của nút "Hoàn tất xử lý" (và nút "Thao tác", "Tiếp nhận"), **không** bấm thử để kiểm hành vi.
- **🆕** — case bổ sung ngoài mục 5 test plan (có ghi lý do). Bộ này **không có** case 🆕.
- **EG** — case đoán lỗi/checklist bám 1 nguồn cụ thể (wireframe V7, V12, checklist CRE-Q05 theo mục 5.6 test plan); nguồn chỉ gợi ý case, không phải kết quả mong đợi.
- **Phạm vi:** chỉ 2 nhóm vai trò (F2); khác biệt Tổ trưởng/Tổ phó/Phó Đội trưởng/cán bộ uỷ quyền: hoãn. Hạn hoàn thành của nhánh cán bộ: tạm bỏ (E3) — case [CB] **không** kiểm hạn, nhắc việc, quá hạn. Chỉ iPhone.
- **Nhánh:** **[NG]** = người giao việc tạo; **[CB]** = cán bộ (hiện trường, Phòng Camera) tạo.
- **Nhãn giao diện:** ưu tiên nhãn của đặc tả (nút "Giao việc và gửi" ở nhánh [NG]); chấp nhận "và"/"&", ghi lại dạng thật, không chấm lệch chữ này. Nhãn nút gửi của nhánh [CB] chưa có trong test basis (QO35) → trong bước ghi là "nút gửi".
- **Chi tiết vụ việc** = mở từ tab Của tôi / Tiếp nhận; các khối: Đầu trang (mã VV, trạng thái, loại · khu vực, mức độ, mô tả ngắn), Giao việc x/y, Biểu mẫu và chữ ký, Thông tin vụ việc, Thông tin liên quan, Đề xuất xử lý của cán bộ, Hình ảnh/Bằng chứng, Diễn biến xử lý.
- Ảnh bằng chứng: lưu `screenshots/<mã nhóm>/`, đặt tên theo [screenshots/README.md](screenshots/README.md) (README có sẵn của bộ cũ vẫn dùng được; bộ mới thêm thư mục nhóm `ACB`, `NOTI`; README không bị sửa trong lượt này). Chưa chụp ảnh thật.
- **Dữ liệu cá nhân:** chỉ dùng giấy tờ mẫu giả và dữ liệu giả (tiền tố `TEST`); không dùng/không chép họ tên, email, số giấy tờ, số điện thoại, mã cán bộ thật từ ảnh hay đặc tả.

### Môi trường mặc định (nêu 1 lần)

| Hạng mục | Giá trị |
|---|---|
| Nền tảng | iPhone (Android ngoài phạm vi). **Model iPhone, phiên bản iOS, build: chưa xác định (QO23)** — người chạy ghi vào bảng log |
| Thiết bị | Tối thiểu 2 iPhone: **M1** (người tạo), **M2** (người nhận/đối chiếu); một số case cần thêm máy hoặc đăng nhập tuần tự (ghi ở case) |
| Mạng / giờ | Wi-Fi và 4G, ngắt mạng được; múi giờ thiết bị = giờ Việt Nam (trừ EXP-8). Quyền thông báo iOS của app: bật |
| Điều kiện để chạy | **Chưa đạt** (test plan mục 8): model/iOS/build, tài khoản và dữ liệu nền bên dưới, bộ giấy tờ mẫu giả, công cụ quan sát lưu lượng mạng — case ghi rõ khi bị ảnh hưởng |

### Ký hiệu dữ liệu (quản trị viên ánh xạ sang tài khoản/khu vực thật; ký hiệu do test case đặt)

| Ký hiệu | Nội dung |
|---|---|
| DT-A, DT-B, DT-C | Người giao việc, Vai trò Đội trưởng/Chỉ huy Đội, thuộc **Đội A**, **Đội B**, **Đội C** (Đội C không liên quan tới vụ việc đang thử) |
| NG-A2 | Người giao việc thứ hai (Vai trò Đội trưởng/Chỉ huy Đội) cùng Đội A — **bổ sung so với mục 7 test plan**, cần cho TC-68 (xem mục "Gap mới") |
| TR-CACK | Trưởng CACK |
| PT-B | Phó trưởng CACK **được gán phụ trách Đội B** (Đội B "có Phó trưởng phụ trách") |
| PT-X | Phó trưởng CACK được gán phụ trách một Đội **khác** Đội nhận (vd Đội A) |
| Đội-N | Đội **chưa** có Phó trưởng phụ trách (có Đội trưởng và các cán bộ) |
| CB-A1, CB-A2 | Cán bộ hiện trường Đội A, **khác Tổ** nhau |
| CB-B1, CB-B2 | Cán bộ hiện trường Đội B, **cùng Tổ** nhau (bổ sung cho TC-76) |
| CAM-A | Cán bộ Phòng Camera thuộc Đội A (khu vực gán Đội A khác khu vực gán Đội nhận) |
| VT | Cán bộ Văn thư |
| DT-0, CB-0, CAM-0 | Đội trưởng / cán bộ hiện trường / Phòng Camera thuộc **Đội-0** (Đội chưa gán khu vực nào — QO27) |
| KV-A1, KV-A2 / KV-B1 | Khu vực chỉ gán cho Đội A (≥2 khu vực) / chỉ gán cho Đội B. **KV-0**: khu vực trong danh mục chưa gán Đội nào (QO31) |
| L-1 / L-2 (+L-2c) / L-CỜ / L-KHÁC | Loại không cờ biểu mẫu / loại hai cấp (L-2c là loại con của L-2) / loại có cờ "Phát hiện vật phẩm nguy hiểm" / loại "Khác" nhập tay |
| GT-1…GT-4 | Giấy tờ **mẫu giả**: CCCD gắn chip, CMND, hộ chiếu Việt Nam, hộ chiếu nước ngoài (mỗi loại có bản để quét camera và ảnh để chọn từ thư viện). Trước khi chạy, lập **bảng đối chiếu** các trường in trên mỗi giấy tờ giả |
| GT-X | Ảnh mờ / thiếu sáng / không phải giấy tờ / bị che |
| IMG-nhỏ, IMG-49, IMG-50a, IMG-50b, IMG-51 | Ảnh bằng chứng: nhỏ (≤ 5MB, không GPS); 49MB (≤ 49.000.000 byte); 50MB (50a = 50.000.000 byte; 50b = 52.428.800 byte); 51MB (≥ 53.477.376 byte). 49MB và 51MB nằm ngoài biên dù hiểu 1MB là 10⁶ hay 2²⁰ byte (G4) |
| IMG-GPS / IMG-noGPS, VID, FILE | Ảnh thư viện có / không có toạ độ GPS; 1 video; 1 tệp không phải ảnh |
| ĐT mẫu | Họ tên `TEST GIA <số>`, số giấy tờ là chuỗi số giả tự đặt, số hộ chiếu `TESTHC<số>`; ngày sinh tự đặt |
| QR-CB1, QR-CAM, QR-VT, QR-NG, QR-TỰ | "Mã QR của tôi" của CB-B1 (hiện trường), Phòng Camera, Văn thư, người giao việc, chính người đang tạo; thêm ảnh mã QR trong thư viện và 1 mã không hợp lệ |

### Luồng nền (dùng làm nền cho nhiều case)

- **LN-NG** ([NG], tối thiểu): đăng nhập DT-A → bấm + → Bước 1 bỏ qua → Bước 2 KV-A1 → Bước 3 L-1 → Bước 4 Bình thường → Bước 5 Mô tả `Mô tả thử nghiệm - vụ việc giả` → Bước 6, 7 bỏ qua → Bước 8 Đội A + CB-A1 → Bước 9 hạn = ngày mai 17:00 → **Giao việc và gửi**.
- **LN-CB** ([CB], tối thiểu): đăng nhập CB-A1 → bấm + → Bước 1 bỏ qua → Bước 2 một khu vực của Đội A → Bước 3 L-1 → Bước 4 Bình thường → Bước 5 Mô tả như trên → Bước 6, 7 bỏ qua → Bước 8 chọn **Đội B**, không chỉ định người → bước cuối → nút gửi.
- "Đi tiếp bằng LN-… từ bước n" = làm các bước còn lại như luồng nền.

---

## 1 · Quyền tạo vụ việc; mất mạng khi gửi · `TC-AUTH` (mục 2 #1, kỹ thuật 5.1 test plan)

> Bảng quyết định R1–R6 + phân vùng kết nối mạng. Mỗi case đăng nhập tài khoản riêng trên M1 (đăng xuất giữa các case). Cách thoát khỏi "Bước 1/9" sau khi kiểm xong chưa được mô tả (QO4) — người chạy tự chọn và ghi lại, không chấm. Tổ trưởng, Tổ phó, Phó Đội trưởng, cán bộ uỷ quyền: hoãn (F2), không có case.
> **Trình tự gộp:** AUTH-01…07 chạy liền theo tài khoản; AUTH-08…11 chạy sau cùng, mỗi case lần lượt với DT-A rồi CB-A1.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-AUTH-01 ⚠️ | Đăng nhập DT-A. Ở Trang chủ tìm nút +, bấm. Về tab Của tôi tìm nút +. Mở tab Tiếp nhận, quan sát có nút + không | **Xác định:** có nút + ở Trang chủ và tab Của tôi; bấm mở "Bước 1/9". **Còn mở — chỉ ghi lại hành vi quan sát được:** nút + ở tab Tiếp nhận (QO3) | P1 | TC-01 · DT R1 · QO3 |
| TC-AUTH-02 ⚠️ | Như AUTH-01 với TR-CACK | Như AUTH-01 (Xác định: nút + ở Trang chủ, Của tôi, mở được "Bước 1/9"; còn mở: tab Tiếp nhận — QO3) | P1 | TC-01 · DT R2 · QO3 |
| TC-AUTH-03 ⚠️ | Như AUTH-01 với PT-B (Phó trưởng CACK) | Như AUTH-01 | P1 | TC-01 · DT R2 · QO3 |
| TC-AUTH-04 ⚠️ | Đăng nhập CB-A1. Tìm nút + ở Trang chủ và tab Của tôi; bấm +; đi hết LN-CB và gửi | **Xác định:** có nút + ở Trang chủ (L6); mở được "Bước 1/9"; gửi thành công, có mã VV + 6 chữ số. **Còn mở:** nút + ở tab Của tôi có hay không (QO3) | P1 | TC-02 · DT R3 · L6 · QO3 |
| TC-AUTH-05 ⚠️ | Như AUTH-04 với CAM-A (Phòng Camera) | Như AUTH-04 | P1 | TC-03 · DT R4 · L6 · QO3 |
| TC-AUTH-06 | Đăng nhập VT (Văn thư). Tìm nút + ở Trang chủ và tab Của tôi; thử mọi cách mở "Bước 1/9" mà giao diện cho phép | Không thấy nút + (cả hai nơi); không mở được màn tạo vụ việc | P1 | TC-04 · DT R5 · C6 |
| TC-AUTH-07 ⚠️ | **Phần A:** tài khoản VT, nhờ quản trị viên đổi Vai trò sang Cán bộ hiện trường; kiểm nút +. **Phần B:** đổi ngược lại Cán bộ Phòng Camera → Văn thư; kiểm nút +. **Phần C:** trên M1 cho CB-A1 đi đến Bước 5/9 đã nhập mô tả, nhờ quản trị viên đổi Vai trò sang Văn thư, bấm Tiếp tục đến Bước cuối và thử gửi; đăng xuất/đăng nhập lại kiểm nút + (đổi lại Vai trò sau khi chạy) | **Xác định:** nút + hiện/ẩn theo Vai trò mới (Văn thư → ẩn; hiện trường/Phòng Camera → hiện) — chấm theo trạng thái sau khi đăng nhập lại. **Còn mở — chỉ ghi lại:** quyền đổi ngay hay sau khi đăng nhập lại; hành vi khi đang giữa 9 bước (QO33) | P2 | TC-05 · DT R6 · QO33 |
| TC-AUTH-08 | Có mạng (Wi-Fi). Với DT-A rồi CB-A1: đi LN-NG / LN-CB và gửi | Gửi thành công; có mã VV + 6 chữ số; vụ việc hiện đúng tab (xem nhóm POST) | P1 | TC-06 · EP có mạng |
| TC-AUTH-09 ⚠️ | Đóng hẳn app; tắt Wi-Fi và 4G (hoặc máy bay); mở app, bấm nút + (nếu có). Bật lại mạng, kiểm tab Của tôi và tìm nháp | **Xác định:** không tạo được vụ việc khi mất mạng; sau khi có mạng lại không có vụ việc mới tự sinh, không có nháp ngoại tuyến. **Còn mở:** app mở được màn tạo khi mất mạng không, báo gì (QO18) | P1 | TC-06 · EP mất mạng trước khi mở màn · QO18 |
| TC-AUTH-10 ⚠️ | Có mạng, đi đến Bước 5/9 đã nhập mô tả; tắt mạng; bấm Tiếp tục đến bước cuối; thử gửi. Bật mạng, kiểm tab Của tôi | **Xác định:** không gửi được khi mất mạng; không có nháp ngoại tuyến; không vụ việc nào được tạo. **Còn mở:** app cho đi tiếp các bước không, báo gì, dữ liệu đã nhập còn không (QO18) | P1 | TC-06 · EP mất mạng giữa các bước · QO18 |
| TC-AUTH-11 ⚠️ | Đi đến bước cuối đã nhập đủ (và hạn hợp lệ với [NG]); tắt mạng; bấm gửi. Chờ 2 phút, bật mạng, kiểm tab Của tôi/Tiếp nhận (không bấm gửi lại) | **Xác định:** không gửi được; không vụ việc nào được tạo; không có hàng đợi gửi ngầm sau khi có mạng lại; không nháp ngoại tuyến. **Còn mở:** dữ liệu có được giữ để gửi lại không (QO18) | P1 | TC-06 · EP mất mạng đúng lúc gửi · QO18 |

---

## 2 · Điều hướng 9 bước, tính bắt buộc từng bước theo nhánh · `TC-NAV` (mục 2 #2, kỹ thuật 5.2)

> Bảng quyết định nút Tiếp tục/gửi (NAV-01…10, mỗi dòng bảng một case, **chạy cả hai nhánh** — bước 1–7 ở [CB] là lượt kiểm khói theo giả định A5/QO32) + chuyển trạng thái (NAV-12…17) + khám phá (NAV-18). "Mờ" = không bấm được/không đi tiếp; "sáng" = bấm được. Dùng DT-A ([NG]) và CB-A1 ([CB]) trên M1; bước chưa nói tới đi bằng luồng nền.
> **Trình tự gộp NAV-01…10:** một lượt Bước 1→cuối cho mỗi nhánh; ở mỗi bước ghi trạng thái nút khi để trống rồi khi nhập hợp lệ; ghi kết quả riêng theo ID.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-NAV-01 | Bước 1 (cả hai nhánh): không thêm ảnh, quan sát nút Tiếp tục; thêm 1 IMG-nhỏ, quan sát lại | Cả hai trạng thái: Tiếp tục **sáng** (bước tuỳ chọn, cả [CB] — A5) | P1 | TC-10 · bảng bước 1 |
| TC-NAV-02 ⚠️ | Bước 2: ghi lại có khu vực chọn sẵn không; nếu chưa, quan sát nút; chọn 1 khu vực, quan sát | **Xác định:** đã chọn 1 khu vực → sáng. **Còn mở:** để trống → mờ, nhưng nếu có khu vực chọn sẵn thì luôn sáng — chỉ ghi hành vi thật (QO7) | P1 | TC-10 · bảng bước 2 · QO7 |
| TC-NAV-03 ⚠️ | Bước 3: chưa chọn loại, quan sát; chọn L-1, quan sát; chọn "Khác" để trống tên, quan sát | **Xác định:** chưa chọn → mờ; chọn loại → sáng. **Còn mở:** "Khác" để trống tên (QO8) | P1 | TC-10 · bảng bước 3 · QO8 |
| TC-NAV-04 | Bước 4: chưa chọn mức độ, quan sát; chọn Bình thường, quan sát | Chưa chọn → mờ; đã chọn → sáng | P1 | TC-10 · bảng bước 4 |
| TC-NAV-05 ⚠️ | Bước 5: để trống "Mô tả vụ việc", quan sát; nhập `Mô tả thử nghiệm`, quan sát; xoá hết rồi chỉ nhập khoảng trắng, quan sát. Với Mô tả hợp lệ: để trống "Vị trí cụ thể" và "Hành động đã thực hiện", quan sát; nhập cả hai, quan sát | **Xác định:** Mô tả trống → mờ; có nội dung → sáng; hai ô còn lại trống hay có → sáng. **Còn mở:** Mô tả chỉ khoảng trắng (QO9) | P1 | TC-10 · bảng bước 5 · QO9 |
| TC-NAV-06 | Bước 6: không thêm đối tượng, để trống số lượng/biển số/đơn vị, quan sát nút; thêm 1 đối tượng thủ công và nhập các trường chung, quan sát. Bước 7: không chọn đề xuất, quan sát; chọn 1, quan sát | Mọi trạng thái ở bước 6 và 7: Tiếp tục **sáng** | P1 | TC-10 · bảng bước 6, 7 |
| TC-NAV-07 | **[NG]** Bước 8: chọn Đội A nhưng chưa chọn cán bộ, quan sát; chọn 1 cán bộ, quan sát | 0 cán bộ → mờ; từ 1 cán bộ → sáng | P1 | TC-10 · bảng bước 8 [NG] |
| TC-NAV-08 ⚠️ | **[CB]** Bước 8: chưa chọn Đội, chưa quét QR, quan sát; chọn Đội B (không chỉ định), quan sát; chỉ định 1 CB-B1, quan sát. Phần ⚑: tắt chọn Đội, dùng QR-CB1 của CB-B1 (xem ACB-08) rồi quan sát nút | **Xác định:** chưa có Đội → mờ; có Đội (có hoặc không chỉ định người) → sáng. **⚑ chỉ ghi quan sát (QO42):** nút khi chỉ có QR thay chọn Đội | P1 | TC-10 · bảng bước 8 [CB] · QO42 ⚑ |
| TC-NAV-09 | **[NG]** Bước cuối (Bước 9): ghi trạng thái ban đầu của hạn và nút "Giao việc và gửi"; đặt hạn là ngày đã qua; đặt hạn hợp lệ (ngày mai 17:00) | Hạn không hợp lệ → nút gửi **không sáng**; hạn hợp lệ → **sáng**. Trạng thái ban đầu (chưa chạm hạn): chỉ ghi lại | P1 | TC-10 · bảng bước 9 [NG] |
| TC-NAV-10 ⚠️ | **[CB]** Tới bước cuối sau khi chọn Đội: ghi có phần chọn hạn không; quan sát nút gửi | **Xác định:** không có phần chọn hạn; nút gửi **bật ngay** khi các bước trước hợp lệ. **Còn mở:** số bước/tên bước/nhãn nút (QO35) | P1 | TC-10 · bảng bước 9 [CB] · E3 · QO35 |
| TC-NAV-11 ⚠️ | Với mỗi nhánh đi Bước 1 → cuối, đọc thanh "Bước n/9" và tên bước | **Xác định ([NG]):** n đúng 1…9; tên bước theo đặc tả: 1 Hình ảnh/Bằng chứng, 2 Khu vực phát sinh, 3 Loại vụ việc, 4 Mức độ, 5 Mô tả, 6 Thông tin đối tượng, 7 Đề xuất xử lý, 8 Giao việc, 9 Xem lại và gửi (khác biệt "/", "&"/"và": ghi lại, không chấm). **Còn mở ([CB]):** số bước, tên bước, bước cuối còn là "Bước 9/9" không (QO35) | P3 | TC-07 · QO35 |
| TC-NAV-12 | Đi Bước 1 → cuối ở mỗi nhánh, mỗi bước nhập hợp lệ rồi Tiếp tục; ghi thanh hiển thị sau mỗi lần | Mỗi lần Tiếp tục chuyển Bước n → n+1 liên tiếp, không bỏ bước; thanh đúng sau mỗi lần | P2 | TC-08 · ST Tiếp tục S1→S9 |
| TC-NAV-13 | Nhập **đầy đủ** mọi bước (1 ảnh, KV-A1, L-1, Nghiêm trọng, 3 ô mô tả, 1 đối tượng thủ công, 2 đề xuất, Đội + người theo nhánh); từ bước cuối bấm Quay lại liên tiếp về Bước 1; đối chiếu dữ liệu từng bước | Mỗi lần Quay lại về đúng bước trước; dữ liệu đã nhập ở mọi bước **còn nguyên** | P2 | TC-08 · ST Quay lại |
| TC-NAV-14 | Sau NAV-13 đi tiến lại tới bước cuối (hạn hợp lệ với [NG]), bấm gửi | Chuyển sang Đã gửi: có mã VV; vụ việc hiện đúng tab (nhóm POST). Màn sau khi gửi: chỉ ghi lại | P2 | TC-08 · ST bước cuối→Đã gửi |
| TC-NAV-15 | Tới bước cuối, quay lại Bước 2 đổi KV-A1 sang KV-A2 (cán bộ: khu vực khác của Đội mình), sửa mô tả ở Bước 5 thành `Mô tả đã sửa`; đi tiếp, gửi; mở Chi tiết | Chi tiết hiện khu vực **mới** và mô tả **`Mô tả đã sửa`**, không phải giá trị cũ | P2 | TC-08 · ST đổi giá trị rồi đi tiếp |
| TC-NAV-16 | Ở Bước 4 chưa chọn mức độ; chạm nút Tiếp tục đang mờ (đúng 1 sự kiện không hợp lệ) | Vẫn ở "Bước 4/9"; dữ liệu các bước trước không đổi | P2 | TC-08 · ST không hợp lệ |
| TC-NAV-17 ⚠️ | Ở Bước 1 tìm nút Quay lại; nếu có, bấm | **Còn mở — chỉ ghi lại hành vi quan sát được:** Bước 1 có nút Quay lại không, bấm thì sao (test basis không nêu — plan 5.2: chỉ quan sát; QO35 với tên bước [CB]) | P2 | TC-08 · ST Quay lại ở Bước 1 |
| TC-NAV-18 🔭 | **Charter EXP-1** — đóng/vuốt thoát màn, chuyển nền, đóng hẳn app, khoá máy ở các bước khác nhau (vd Bước 1, 5, 6, cuối) **ở cả hai nhánh**: dữ liệu giữ hay mất, có hỏi xác nhận không, quay lại app ở bước nào. Tìm nút đóng sheet | **Phải quan sát/ghi lại** (QO4); không đạt/không đạt | P2 | TC-09 · EXP-1 · QO4 |

---

## 3 · Bước 1 — Hình ảnh/Bằng chứng · `TC-EVD` (mục 2 #3, kỹ thuật 5.3)

> Phân vùng (loại tệp, nguồn, số ảnh, GPS) + giá trị biên 3-value 50MB + khám phá EXP-2. Chạy chính trên [NG] (DT-A); lượt khói [CB] là EVD-05. Sau Bước 1 đi tiếp bằng LN-NG. Kiểm lưu ở Chi tiết → Hình ảnh/Bằng chứng. Nếu giao diện không cho xem siêu dữ liệu GPS/thời gian của tệp đã lưu: ghi "không kiểm được siêu dữ liệu qua giao diện", không chấm.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-EVD-01 | Bước 1: không thêm ảnh; Tiếp tục; đi tới bước cuối; gửi | Sang được Bước 2/9; màn xem lại "Bằng chứng: 0 tệp"; gửi thành công | P3 | TC-11 · EP số ảnh = 0 |
| TC-EVD-02 ⚠️ | "Chụp ảnh" (cho phép quyền Camera nếu hỏi), chụp 1 ảnh; Tiếp tục; tới bước cuối; gửi; mở Chi tiết | **Xác định:** thấy 1 ảnh thu nhỏ ở Bước 1; xem lại "Bằng chứng: 1 tệp"; Chi tiết → Hình ảnh/Bằng chứng có đúng 1 ảnh khớp. **Còn mở:** thao tác xoá ảnh (QO5) | P1 | TC-12 · EP nguồn chụp, số ảnh 1 · QO5 |
| TC-EVD-03 | "Thư viện", chọn IMG-nhỏ; làm tiếp như EVD-02 | "Bằng chứng: 1 tệp"; Chi tiết có đúng 1 ảnh khớp | P1 | TC-12 · EP nguồn thư viện |
| TC-EVD-04 ⚠️ | Thêm 3 ảnh trong cùng vụ việc (2 chụp, 1 thư viện). Thử xoá 1 ảnh (nếu có nút) rồi thêm lại đủ 3. Tới bước cuối, gửi, mở Chi tiết | **Xác định:** "Bằng chứng: 3 tệp"; Chi tiết có đủ 3 ảnh khớp. **Còn mở:** xoá được ảnh không; số ảnh tối đa (không đặt biên thử) (QO5) | P1 | TC-12 · EP nhiều ảnh, cả hai nguồn · QO5 |
| TC-EVD-05 | **Lượt khói [CB]:** CB-A1, Bước 1 thêm 1 IMG-nhỏ (thư viện), đi tiếp LN-CB, gửi, mở Chi tiết | Bước 1 hoạt động như [NG]: "Bằng chứng: 1 tệp"; Chi tiết có đúng 1 ảnh. Nếu khác [NG] → ghi lại và báo (QO32) | P1 | TC-12 · A5 · QO32 |
| TC-EVD-06 | Bước 1 → Thư viện: cố chọn VID | Không thêm được video (số tệp không tăng). Cách chặn: chỉ ghi lại | P2 | TC-13 · EP video |
| TC-EVD-07 | Tìm mọi đường thêm FILE (không phải ảnh) vào Bằng chứng | Không thêm được; nếu nguồn chọn chỉ có ảnh nên không có cách chọn tệp khác: ghi "không thực hiện được do nguồn chọn chỉ có ảnh" | P2 | TC-13 · EP tệp khác |
| TC-EVD-08 ⚠️ | Thêm IMG-49 từ thư viện; tới bước cuối; gửi; mở Chi tiết | **Xác định:** ảnh dưới biên thêm được và lưu, Chi tiết hiện đúng 1 ảnh. Chỉ ghi lại: thời gian tải/hiển thị | P2 | TC-14 · BVA dưới biên (49MB) |
| TC-EVD-09 ⚠️ | Thêm IMG-50a rồi riêng IMG-50b | **Còn mở — chỉ ghi lại hành vi quan sát được:** nhận hay từ chối từng ảnh (biên "50MB" chưa định nghĩa 10⁶ hay 2²⁰ byte — G4, QO5) | P2 | TC-14 · BVA đúng biên · G4/QO5 |
| TC-EVD-10 ⚠️ | Thêm IMG-51 | **Xác định:** không thêm được ảnh vượt 50MB (số tệp không tăng). **Còn mở:** nội dung thông báo khi vượt (QO5) — chỉ ghi lại | P2 | TC-14 · BVA vượt biên · QO5 |
| TC-EVD-11 ⚠️ | Thêm 1 ảnh chụp mới; gửi; mở ảnh ở Chi tiết, tìm thời gian gắn với ảnh | **Còn mở — chỉ ghi lại hành vi quan sát được:** ảnh có gắn thời gian không, hiển thị ở đâu/định dạng nào (QO5) | P2 | TC-15 · QO5 |
| TC-EVD-12 ⚠️ | Chụp ảnh mới tại nơi có GPS; gửi; kiểm ảnh đã lưu | **Xác định:** ảnh lưu không kèm toạ độ GPS (nếu không đọc được siêu dữ liệu qua giao diện: ghi rõ, không chấm) | P2 | TC-16 · EP ảnh chụp mới · B12 |
| TC-EVD-13 | Chọn IMG-noGPS từ thư viện; gửi; kiểm ảnh đã lưu | Ảnh lưu không có toạ độ GPS | P2 | TC-16 · EP thư viện không GPS |
| TC-EVD-14 ⚠️ | Chọn IMG-GPS từ thư viện; gửi; kiểm ảnh đã lưu | **Xác định:** ảnh lưu không có toạ độ GPS ("không GPS" theo đặc tả). **Còn mở:** app cắt GPS của ảnh thư viện hay không đọc (QO5) — chỉ ghi lại | P2 | TC-16 · EP thư viện có GPS · QO5 |
| TC-EVD-15 🔭 | **Charter EXP-2** — từ chối/cho phép quyền Camera, Ảnh, Micro ở Bước 1, Bước 5, Bước 6 và màn quét QR (xem thêm DSC-05, ACB-14): thông báo, dẫn tới Cài đặt không, luồng tiếp tục được không; thêm quyền Thông báo iOS (G6) | **Phải quan sát/ghi lại** (QO6); không đạt/không đạt | P2 | TC-17 · EXP-2 · QO6 |

---

## 4 · Bước 2–4 — Khu vực, Loại, Mức độ · `TC-CLS` (mục 2 #4, kỹ thuật 5.4)

> Bảng quyết định danh sách khu vực theo người tạo (K1–K6) + phân vùng loại/mức độ. Sau Bước 4 đi tiếp bằng luồng nền của nhánh. Khu vực "hiện ở Bước 2" = danh sách người dùng chọn được.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-CLS-01 ⚠️ | DT-A tới Bước 2; ghi có khu vực chọn sẵn không; chọn đúng 1 khu vực, đổi sang khu vực khác; gửi; mở Chi tiết | **Xác định:** chỉ chọn được 1 khu vực tại một thời điểm; Chi tiết hiện khu vực đã chọn sau cùng. **Còn mở:** chọn sẵn mặc định (QO7) | P3 | TC-18 · EP · QO7 |
| TC-CLS-02 | **K1** — DT-A tới Bước 2, ghi danh sách khu vực | Chỉ hiện khu vực gán cho **Đội A** (gồm KV-A1, KV-A2); khu vực chỉ gán Đội khác (KV-B1) **không hiện**; Bước 8 Đội = Đội A, không chọn được Đội khác | P1 | TC-19 · DT K1 |
| TC-CLS-03 | **K2** — Lần lượt TR-CACK và PT-B tới Bước 2; Bước 8 chọn Đội khác nhau (vd B rồi Đội-N), cố chọn khu vực chỉ gán Đội khác | Hiện khu vực của **mọi Đội**; chọn Đội bất kỳ ở Bước 8 **không bị chặn hay cảnh báo** dù khu vực lệch Đội | P2 | TC-20 · DT K2 |
| TC-CLS-04 | **K3** — CAM-A tới Bước 2; Bước 8 chọn lần lượt Đội A, Đội B, Đội-N | Bước 2 chỉ hiện khu vực của **Đội A** (Đội của CAM-A), không phụ thuộc Đội bàn giao; chọn được mọi Đội ở Bước 8 | P1 | TC-21 · DT K3 · C2 |
| TC-CLS-05 | **K4** — CB-A1 tới Bước 2; Bước 8 chọn Đội B (khu vực lệch Đội B) và tiếp tục | Bước 2 chỉ hiện khu vực của Đội A; **không** có kiểm khớp khu vực ↔ Đội nhận (không chặn, không cảnh báo); chọn được mọi Đội | P1 | TC-22 · DT K4 · QB5 |
| TC-CLS-06 ⚠️ | **K5 [NG]** — DT-0 (Đội-0 chưa gán khu vực) tới Bước 2 | **Còn mở — chỉ ghi lại hành vi quan sát được:** danh sách khu vực rỗng hay thông báo, có đi tiếp được không (QO27) | P1 | TC-19 · DT K5 · QO27 |
| TC-CLS-07 ⚠️ | **K5 [CB]** — lần lượt CB-0 và CAM-0 tới Bước 2 | **Còn mở:** như CLS-06, kể cả cán bộ Phòng Camera thuộc Đội-0 (QO27) | P1 | TC-21, TC-22 · DT K5 · QO27 |
| TC-CLS-08 ⚠️ | **K6** — TR-CACK tới Bước 2, tìm KV-0 (khu vực chưa gán Đội nào) | **Còn mở:** "khu vực của mọi Đội" có gồm KV-0 không (QO31) | P2 | TC-20 · DT K6 · QO31 |
| TC-CLS-09 | Đổi danh mục khu vực/loại/mức độ trên trang quản trị (thêm 1 mục thử), mở lại màn tạo | Danh sách ở app khớp danh mục đã cấu hình (mục mới hiện, mục bị tắt không hiện). Nếu không đổi được cấu hình: ghi "không thực hiện được" | P3 | TC-23 · cấu hình quản trị |
| TC-CLS-10 ⚠️ | Bước 3: chọn loại cha L-2 rồi loại con L-2c; gửi; mở Chi tiết | **Xác định:** lưu **loại cha + loại con**, hiện ở Đầu trang (loại · khu vực) và Thông tin vụ việc. **Còn mở:** cách chọn 2 cấp trên giao diện (QO8) — chỉ ghi lại | P1 | TC-24 · EP loại cha/con · QO8 |
| TC-CLS-11 ⚠️ | Bước 3: chọn L-KHÁC, nhập tên `Loại thử nghiệm`; gửi; mở Chi tiết | **Xác định:** có ô nhập tên loại; tên đã nhập hiện ở Chi tiết. **Còn mở:** độ dài tối đa, có gắn biểu mẫu không (QO8) | P2 | TC-25 · EP "Khác" có tên · QO8 |
| TC-CLS-12 ⚠️ | Bước 3: chọn L-KHÁC, để trống tên; quan sát nút Tiếp tục | **Còn mở — chỉ ghi lại hành vi quan sát được:** nút sáng hay mờ (QO8) | P2 | TC-25 · EP "Khác" để trống · QO8 |
| TC-CLS-13 ⚠️ | **[NG]** chọn L-CỜ; gửi; mở Chi tiết | **Xác định:** Chi tiết có khối "Biểu mẫu và chữ ký". **Còn mở:** các chi tiết khác của cờ (QO8) | P1 | TC-26 · EP có cờ × [NG] · QO8 |
| TC-CLS-14 ⚠️ | **[CB]** (CB-A1) chọn L-CỜ; gửi; mở Chi tiết bằng tài khoản được phép thấy (người tạo, DT-A hoặc DT-B) | **Xác định:** Chi tiết có khối "Biểu mẫu và chữ ký" cả với vụ việc do cán bộ tạo. **Còn mở:** như CLS-13 (QO8) | P1 | TC-26 · EP có cờ × [CB] · QO8 |
| TC-CLS-15 ⚠️ | **[NG]** chọn L-1 (không cờ); gửi; mở Chi tiết | **Xác định:** vụ việc không có biểu mẫu nào được gắn. **Còn mở:** khối "Biểu mẫu và chữ ký" ẩn hay rỗng — chỉ ghi lại (QO8) | P1 | TC-26 · EP không cờ × [NG] · QO8 |
| TC-CLS-16 ⚠️ | **[CB]** chọn L-1 (không cờ); gửi; mở Chi tiết (như CLS-14) | Như CLS-15 | P1 | TC-26 · EP không cờ × [CB] · QO8 |
| TC-CLS-17 | Bước 4: chọn Bình thường; gửi; mở Chi tiết, mở bộ lọc mức độ (nếu có) | Mức độ lưu = Bình thường, hiện ở Đầu trang; lọc theo Bình thường ra vụ việc này; không có cảnh báo Khẩn cấp | P2 | TC-27 · EP Bình thường |
| TC-CLS-18 | Bước 4: chọn Nghiêm trọng; gửi; mở Chi tiết, lọc | Mức độ lưu = Nghiêm trọng, hiện đúng; lọc ra vụ việc này; không có cảnh báo Khẩn cấp | P2 | TC-27 · EP Nghiêm trọng |
| TC-CLS-19 ⚠️ | Bước 4: chọn Khẩn cấp, ghi **nguyên văn** ghi chú hiện trên màn; gửi; mở Chi tiết, lọc | **Xác định:** mức lưu = Khẩn cấp, hiện đúng; lọc ra vụ việc này. **Còn mở — chỉ ghi lại:** câu chữ ghi chú (đặc tả ghi "Cảnh báo Lãnh đạo + BCH đội"; có đổi theo G1 không — QO38). Người nhận cảnh báo kiểm ở NOTI | P2 | TC-27 · EP Khẩn cấp · QO38 |

---

## 5 · Bước 5 — Mô tả · `TC-DSC` (mục 2 #5, kỹ thuật 5.5)

> Phân vùng. DSC-01…03 chạy ở cả hai nhánh (DT-A rồi CB-A1). Kiểm lưu ở Chi tiết (Đầu trang, Thông tin vụ việc).

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-DSC-01 | Bước 5: để trống cả 3 ô, quan sát nút Tiếp tục | Nút Tiếp tục **mờ** | P1 | TC-28 · EP Mô tả trống |
| TC-DSC-02 | Chỉ nhập `Mô tả thử nghiệm` vào "Mô tả vụ việc", hai ô còn lại trống; Tiếp tục; đi tiếp luồng nền; gửi; mở Chi tiết | Nút sáng; gửi được; Chi tiết hiện đúng mô tả; "Vị trí cụ thể", "Hành động đã thực hiện" để trống không báo lỗi | P1 | TC-28 · EP chỉ Mô tả |
| TC-DSC-03 | Nhập cả 3 ô (`Mô tả thử nghiệm`, `Vị trí thử nghiệm`, `Hành động thử nghiệm`); gửi; mở Chi tiết | Cả 3 giá trị lưu và hiện đúng ô tương ứng (Vị trí và Hành động trong Thông tin vụ việc), không lẫn ô | P1 | TC-28 · EP đủ 3 ô |
| TC-DSC-04 🔭 | **Charter EXP-6 (phần Mô tả)** — thử Mô tả chỉ khoảng trắng; rất dài (vd vài nghìn ký tự); tiếng Việt có dấu, emoji, ký tự đặc biệt; ghi nút Tiếp tục, có cắt/báo giới hạn không, Chi tiết hiển thị ra sao | **Phải quan sát/ghi lại** (QO9); không đạt/không đạt | P2 | TC-29 · EXP-6 · QO9 |
| TC-DSC-05 ⚠️ | Ở Bước 5 bấm micro ở lần lượt 3 ô, đọc một câu tiếng Việt ngắn (cho phép quyền Micro nếu hỏi); kiểm văn bản chèn vào | **Xác định:** văn bản nhận dạng được chèn vào **đúng ô** đang bấm micro (ngưỡng chính xác không chấm — QO21). **Còn mở:** xử lý khi từ chối quyền Micro (QO6) | P3 | TC-30 · EP nguồn nhập giọng nói · QO6/QO21 |

---

## 6 · Bước 6 — Thông tin đối tượng · `TC-SUBJ` (mục 2 #6, kỹ thuật 5.6)

> Phân vùng + ma trận 4 loại giấy tờ × 2 cách (8 ô) + đoán lỗi/khám phá. Chạy chính trên [NG]; trường tự điền đối chiếu **bảng đối chiếu** của giấy tờ giả. Mọi ô quét/thư viện cần bộ giấy tờ mẫu giả (QO23 — **điều kiện chờ**). Ngưỡng chính xác nhận dạng không là tiêu chí (QO21). Sau Bước 6 đi tiếp bằng LN-NG.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-SUBJ-01 | Bước 6: không thêm đối tượng, để trống các trường chung; đi tới cuối; gửi; mở Chi tiết | Gửi thành công; "Thông tin liên quan" không có đối tượng | P3 | TC-31 · EP 0 đối tượng |
| TC-SUBJ-02 ⚠️ | Nhập "Số lượng đối tượng" = 2 và thêm đúng 2 đối tượng thủ công; gửi; mở Chi tiết | **Xác định:** không bị chặn. **Còn mở:** giá trị "Số lượng đối tượng" lưu/hiển thị ở đâu (QO12) | P3 | TC-32 · EP khớp · QO12 |
| TC-SUBJ-03 ⚠️ | Nhập "Số lượng đối tượng" = 5 nhưng chỉ thêm 1 đối tượng; rồi số lượng = 0 và thêm 2 đối tượng; gửi | **Xác định:** cả hai lần không bị chặn (số lượng không cần khớp — Q17). **Còn mở:** nơi lưu/hiển thị (QO12) | P3 | TC-32 · EP không khớp · QO12 |
| TC-SUBJ-04 ⚠️ | Bấm "Quét giấy tờ" (cho phép Camera), quét **GT-1** (CCCD gắn chip) bản giả; không sửa; đối chiếu từng trường | **Xác định:** các trường tự điền khớp bảng đối chiếu GT-1 (Họ tên, Ngày sinh, Giới tính, Quốc tịch, Số CCCD/CMND). **Còn mở:** trường nào điền được ngoài các trường trên; độ chính xác không chấm (QO21, QO11) | P1 | TC-33 · ô quét × CCCD · QO11/QO21 |
| TC-SUBJ-05 ⚠️ | Như SUBJ-04 với **GT-2** (CMND) | Như SUBJ-04 (đối chiếu bảng GT-2) | P1 | TC-33 · ô quét × CMND |
| TC-SUBJ-06 ⚠️ | Như SUBJ-04 với **GT-3** (hộ chiếu Việt Nam) | **Xác định:** Họ tên, Ngày sinh, Giới tính, Quốc tịch tự điền khớp bảng đối chiếu. **Còn mở:** số hộ chiếu vào ô nào ("Số hộ chiếu" hay "Số CCCD/CMND") — chỉ ghi lại (QO11) | P1 | TC-33 · ô quét × HC VN · QO11 |
| TC-SUBJ-07 ⚠️ | Như SUBJ-04 với **GT-4** (hộ chiếu nước ngoài) | Như SUBJ-06 (kể cả Quốc tịch nước ngoài chọn từ danh sách; danh sách quốc tịch chưa cung cấp — §8.2) | P1 | TC-33 · ô quét × HC nước ngoài · QO11 |
| TC-SUBJ-08 ⚠️ | Bấm "Từ thư viện", chọn ảnh **GT-1**; đối chiếu trường tự điền | Như SUBJ-04 (đối chiếu bảng GT-1) | P1 | TC-34 · ô thư viện × CCCD · QO11/QO21 |
| TC-SUBJ-09 ⚠️ | Như SUBJ-08 với **GT-2** | Như SUBJ-05 | P1 | TC-34 · ô thư viện × CMND |
| TC-SUBJ-10 ⚠️ | Như SUBJ-08 với **GT-3** | Như SUBJ-06 | P1 | TC-34 · ô thư viện × HC VN · QO11 |
| TC-SUBJ-11 ⚠️ | Như SUBJ-08 với **GT-4** | Như SUBJ-07 | P1 | TC-34 · ô thư viện × HC nước ngoài · QO11 |
| TC-SUBJ-12 | Quét/chọn GT-1, **sửa 1 trường** (vd Họ tên thành `TEST GIA 01`), giữ nguyên các trường khác; gửi; mở Chi tiết | Chi tiết hiện giá trị **đã sửa** của trường đó; các trường còn lại giữ giá trị tự điền | P1 | TC-35 · EP sửa 1 |
| TC-SUBJ-13 | Như SUBJ-12 nhưng sửa **nhiều trường** (Họ tên, Ngày sinh, Giới tính, Số CCCD/CMND) | Chi tiết hiện đúng toàn bộ giá trị đã sửa, không còn giá trị tự điền cũ | P1 | TC-35 · EP sửa nhiều |
| TC-SUBJ-14 🔭 | **Charter EXP-3** (nguồn gợi ý: wireframe V12 — camera chụp thường) — quét/chọn GT-X (mờ, thiếu sáng, không phải giấy tờ, bị che): app báo gì, trường điền thiếu hay sai, số hộ chiếu vào ô nào, ảnh quét có vào thư viện Ảnh iPhone không | **Phải quan sát/ghi lại** (QO11); không đạt/không đạt | P1 | TC-36 · EXP-3 · QO11 |
| TC-SUBJ-15 ⚠️ | Quét GT-1 → xác nhận đối tượng → gửi; mở Chi tiết → Hình ảnh/Bằng chứng; mở thư viện Ảnh iPhone, tìm ảnh vừa quét | **Xác định:** ảnh giấy tờ **không** nằm trong Hình ảnh/Bằng chứng; hệ thống chỉ lưu văn bản. **Còn mở — chỉ ghi lại:** ảnh có vào thư viện Ảnh iPhone không (QO11) | P1 | TC-37 · cách quét × nơi kiểm · Q18 |
| TC-SUBJ-16 ⚠️ | Như SUBJ-15 nhưng dùng "Từ thư viện" với ảnh GT-1 | Như SUBJ-15; ảnh gốc trong thư viện Ảnh iPhone còn nguyên, không bị nhân bản | P1 | TC-37 · cách thư viện · Q18 |
| TC-SUBJ-17 ⚠️ | Dùng công cụ quan sát lưu lượng mạng (hoặc nhật ký máy chủ do dev cung cấp) trong lúc (a) quét GT-1 bằng camera và (b) chọn ảnh GT-1 từ thư viện; sau đó gửi vụ việc | **Xác định:** ảnh giấy tờ không được gửi lên máy chủ (không có yêu cầu mạng mang tải ảnh trong lúc nhận dạng); chỉ văn bản khi gửi vụ việc. **Điều kiện chờ:** chưa có công cụ (G5, mục 7/8 test plan) — nếu chưa có: ghi "không kiểm được", QC lead quyết định | P1 | TC-38 · B13 · G5 |
| TC-SUBJ-18 | Bấm "Thêm đối tượng thủ công"; nhập đủ 6 trường: Họ tên, Ngày sinh, Giới tính = **Nam**, Quốc tịch (chọn từ danh sách), Số CCCD/CMND, Số hộ chiếu; gửi; mở Chi tiết | 6 giá trị lưu đúng và hiện trong Thông tin liên quan | P1 | TC-39 · EP thủ công, giới tính Nam |
| TC-SUBJ-19 | Thêm 2 đối tượng thủ công với giới tính **Nữ** và **Khác**; gửi; mở Chi tiết | Hai đối tượng lưu đúng giới tính tương ứng | P1 | TC-39 · EP giới tính Nữ, Khác |
| TC-SUBJ-20 🔭 | **Charter EXP-4** — thử đối tượng rỗng; ngày sinh sai định dạng/tương lai; số giấy tờ chứa chữ/ký tự đặc biệt; quốc tịch nước ngoài; ghi chặn hay cho qua | **Phải quan sát/ghi lại** (QO10); không đạt/không đạt | P1 | TC-40 · EXP-4 · QO10 |
| TC-SUBJ-21 🔭 | **EG nguồn wireframe V7** — chọn quốc tịch nước ngoài rồi nhập số vào ô "Số CCCD/CMND"; lưu; xem Chi tiết | **Phải quan sát/ghi lại** (QO10): có bị chặn không (nguồn chỉ gợi ý case, không phải kết quả mong đợi) | P1 | TC-40 · EG V7 · QO10 |
| TC-SUBJ-22 | Thêm 3 đối tượng, mỗi đối tượng một cách (quét, thư viện, thủ công); gửi; mở Chi tiết | Chi tiết có đủ 3 đối tượng, dữ liệu từng đối tượng đúng và không lẫn nhau | P2 | TC-41 · EP ≥2 đối tượng |
| TC-SUBJ-23 | Với 3 đối tượng, bấm xoá đối tượng giữa; gửi; mở Chi tiết | Đối tượng đã xoá không còn; hai đối tượng còn lại giữ nguyên dữ liệu | P2 | TC-41 · xoá 1 trong nhiều |
| TC-SUBJ-24 | Thêm đối tượng có Số CCCD/CMND giả 12 chữ số; gửi; mở Chi tiết → Thông tin liên quan | Số CCCD hiển thị **đầy đủ, không che** (B16) | P2 | TC-41 · B16 |
| TC-SUBJ-25 ⚠️ | Nhập Biển số xe `TEST-0001` và Đơn vị liên quan `TEST ĐƠN VỊ`; gửi; mở Chi tiết | **Xác định:** hai giá trị nhập tay lưu và hiện đúng (Thông tin vụ việc). **Còn mở:** nút "Tra biển số" (QO13) | P3 | TC-42 · EP · QO13 |
| TC-SUBJ-26 🔭 | **EG nguồn checklist CRE-Q05** — tìm nút "Tra biển số"; nếu có, bấm và ghi hành vi | **Phải quan sát/ghi lại** (QO13): ẩn hay giữ; chưa có tra cứu tự động (Q35) | P3 | TC-42 · EG CRE-Q05 · QO13 |

---

## 7 · Bước 7 — Đề xuất xử lý · `TC-PROP` (mục 2 #7, kỹ thuật 5.7)

> Phân vùng + biên số lựa chọn (0, 1, 4, 5). 5 mục: Nhắc nhở, khuyến cáo · Đưa vào diện chú ý · Bàn giao · Phối hợp · Khác. Kiểm lưu ở Chi tiết → "Đề xuất xử lý của cán bộ".

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-PROP-01 | Không chọn đề xuất nào; Tiếp tục; gửi; mở Chi tiết | Tiếp tục sáng; gửi được; mục Đề xuất xử lý không có lựa chọn | P3 | TC-43 · biên 0 |
| TC-PROP-02 | Chọn đúng 1 đề xuất (Phối hợp); gửi; mở Chi tiết | Hiện đúng 1 đề xuất "Phối hợp" | P3 | TC-43 · biên 1 |
| TC-PROP-03 | Chọn 4 đề xuất (trừ Khác); gửi; mở Chi tiết | Hiện đúng 4 đề xuất đã chọn | P3 | TC-43 · biên 4 |
| TC-PROP-04 | Chọn cả 5 đề xuất; gửi; mở Chi tiết | Hiện đúng cả 5 | P3 | TC-43 · biên 5 |
| TC-PROP-05 🔭 | **Charter EXP-6 (phần Đề xuất "Khác")** — chọn "Khác": có ô nhập nội dung không, bắt buộc không, nội dung hiện ở Chi tiết thế nào | **Phải quan sát/ghi lại** (QO14); không đạt/không đạt | P3 | TC-44 · EXP-6 · QO14 |

---

## 8 · Bước 8 nhánh người giao [NG] — Giao việc · `TC-ASG` (mục 2 #8, kỹ thuật 5.8)

> Bảng quyết định phạm vi giao (A1–A4) + biên số cán bộ + chuyển trạng thái đổi Đội. Chỉ nhánh [NG]. Đi tới Bước 8 bằng LN-NG. Mỗi dòng cán bộ hiển thị email, Đội, vai trò.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-ASG-01 | DT-A ở Bước 8: chọn Đội A, không chọn cán bộ | Nút Tiếp tục mờ (0 cán bộ → không đi tiếp) | P1 | TC-45 · biên 0 |
| TC-ASG-02 | Chọn đúng 1 cán bộ (CB-A1); Tiếp tục; gửi | Đi tiếp được; gửi được; Chi tiết có 1 phần việc | P1 | TC-45 · biên 1 |
| TC-ASG-03 | Chọn 3 cán bộ Đội A, bỏ chọn 1, rồi gửi | Còn 2 cán bộ được chọn; Chi tiết có đúng 2 phần việc, cho đúng 2 người còn lại | P1 | TC-45 · nhiều, bỏ chọn |
| TC-ASG-04 | **A1** — DT-A ở Bước 8: thử chọn Đội khác; xem danh sách cán bộ | Đội = Đội A, **không chọn được** Đội khác; danh sách chỉ có cán bộ Đội A | P1 | TC-46 · DT A1 |
| TC-ASG-05 | **A2** — TR-CACK ở Bước 8: chọn Đội B; xem danh sách; gửi | Chọn được **đúng 1** Đội bất kỳ; danh sách chỉ cán bộ Đội B; gửi được | P1 | TC-46 · DT A2 (Trưởng CACK) |
| TC-ASG-06 | **A2** — PT-B ở Bước 8: chọn Đội A (không phải Đội mình phụ trách); gửi | Như ASG-05, chọn được Đội bất kỳ | P1 | TC-46 · DT A2 (Phó trưởng CACK) |
| TC-ASG-07 | **A3** — DT-A tìm theo email của CB-B1 (Đội B) và của CAM-A khi Đội A đang chọn | Cán bộ ngoài phạm vi **không hiển thị** ở danh sách/kết quả tìm; không có cán bộ của 2 Đội trong cùng vụ việc | P1 | TC-46, TC-47 · DT A3 |
| TC-ASG-08 ⚠️ | TR-CACK chọn Đội B, chọn CB-B1; mở lại danh sách Đội, thử chọn thêm Đội A | **Xác định:** chỉ 1 Đội tại một thời điểm; danh sách cán bộ lọc theo Đội đã chọn. **Còn mở:** cách xử lý khi chọn thêm Đội thứ hai (chỉ ghi lại; QO29 liên quan) | P1 | TC-47 · đúng 1 Đội |
| TC-ASG-09 ⚠️ | TR-CACK chọn Đội A + CB-A1, rồi **đổi sang Đội B**; quan sát danh sách và người đã chọn; gửi | **Xác định:** danh sách đổi theo Đội B. **Còn mở — chỉ ghi lại:** CB-A1 đã chọn còn giữ hay bị bỏ; gửi được hay chặn (QO29) | P1 | TC-47 · ST đổi Đội · QO29 |
| TC-ASG-10 ⚠️ | Ở ô tìm theo email, nhập email **khớp đúng** một cán bộ giả | **Xác định:** hiện đúng cán bộ đó (email, Đội, vai trò) và chọn được. **Còn mở:** cách so khớp nâng cao (QO15) — ghi ở ASG-12 | P2 | TC-48 · EP khớp đúng · QO15 |
| TC-ASG-11 ⚠️ | Nhập chuỗi **không khớp** email nào | **Còn mở — chỉ ghi lại hành vi quan sát được:** nội dung hiển thị khi không có kết quả (QO15). **Xác định:** không có cán bộ nào hiện | P2 | TC-48 · EP không khớp · QO15 |
| TC-ASG-12 ⚠️ | Xoá hết ô tìm (rỗng); thử khớp một phần (nửa email) và đổi hoa/thường | **Còn mở — chỉ ghi lại:** danh sách khi rỗng; khớp một phần; phân biệt hoa/thường (QO15) | P2 | TC-48 · EP rỗng · QO15 |
| TC-ASG-13 🔭 | **Charter EXP-7** — DT-A thử tự giao cho chính mình; giao cho người giao khác (NG-A2) | **Phải quan sát/ghi lại** (QO16); không đạt/không đạt | P2 | TC-49 · EXP-7 · QO16 |
| TC-ASG-14 | Với DT-A và TR-CACK, tìm trong Bước 8 mọi nút/lựa chọn quét QR hoặc "Bàn giao bằng mã QR" | **Không có** nút/lựa chọn QR (QB6(c)) | P2 | TC-50 · DT A4 · QB6(c) |

---

## 9 · Bước 8 nhánh cán bộ tạo [CB] — Bàn giao cho Đội, chỉ định, mã QR · `TC-ACB` (mục 2 #9, kỹ thuật 5.9)

> Bảng quyết định bước 8 [CB] (B1–B10) + phân vùng loại mã QR + khám phá. Dùng CB-A1 (hiện trường) trên M1; trừ khi nói khác, Bước 1–7 đi bằng LN-CB. Case có QR: thiết bị **M2** đăng nhập người được quét và mở "Mã QR của tôi" (Trang chủ), M1 quét; hoặc dùng ảnh mã trong thư viện M1. **⚑ QO42** = Đội nhận khi quét QR chưa xác nhận → chỉ ghi quan sát.
> Hạn hoàn thành của nhánh [CB]: tạm bỏ (E3), không có case.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-ACB-01 ⚠️ | **B5** — Ở Bước 8 chưa chọn Đội, chưa quét QR; tìm lựa chọn "không bàn giao"; quan sát nút Tiếp tục. Phần ⚑: so với trường hợp chỉ có QR | **Xác định:** không đi tiếp được; **không có** lựa chọn "không bàn giao" (E1). **⚑ chỉ ghi quan sát (QO42):** nút khi chỉ có QR thay chọn Đội | P1 | TC-51 · DT B5 · QO34/QO42 ⚑ |
| TC-ACB-02 ⚠️ | **B1** — Mở danh sách Đội ở Bước 8, ghi các Đội hiện; chọn Đội B; lần khác chọn Đội A (Đội mình) | **Xác định:** danh sách có **mọi Đội, kể cả Đội mình**; chọn 1 Đội thì Tiếp tục sáng (không chỉ định người vẫn đi tiếp). **Còn mở:** — tìm Đội/cách hiển thị (QO34) | P1 | TC-51 · DT B1 · C2/E1 · QO34 |
| TC-ACB-03 | **B1** — Chọn Đội B, **không** chỉ định ai; đi tiếp; gửi | Gửi thành công, có mã VV + 6 chữ số; vụ việc là **Chờ tiếp nhận** (kiểm tiếp ở POST-09) | P1 | TC-53 · DT B1 |
| TC-ACB-04 ⚠️ | **B2** — Chọn Đội B; mở danh sách chỉ định người, ghi các dòng (email/Đội/vai trò); chọn CB-B1; đi tiếp; gửi | **Xác định:** danh sách chỉ gồm **cán bộ hiện trường thuộc Đội B**; chọn 1 người đi tiếp được; gửi được; vụ việc **Đang thực hiện** (kiểm tiếp ở POST-08). **Còn mở:** tìm theo email hay tên (QO34) | P1 | TC-52 · DT B2 · F1 · QO34 |
| TC-ACB-05 | **B3** — Chọn Đội B; tìm trong danh sách chỉ định: cán bộ Phòng Camera, Văn thư, người giao (DT-B), cán bộ hiện trường Đội A | **Không** chọn được/không xuất hiện: Phòng Camera, Văn thư, người giao, cán bộ Đội khác | P1 | TC-52 · DT B3 |
| TC-ACB-06 ⚠️ | **B3** — Chọn Đội B, chọn CB-B1, rồi thử chọn thêm CB-B2 (người thứ 2) | **Xác định:** tổng số người được chỉ định **không vượt quá 1** sau thao tác. **Còn mở:** giao diện xử lý (thay người cũ hay chặn) — chỉ ghi lại | P1 | TC-52 · DT B3 (tối đa 1) |
| TC-ACB-07 🔭 | **Charter EXP-10** — (a) hiện trường tự chỉ định chính mình (đổi Đội sang Đội A, tìm CB-A1); (b) đổi Đội sau khi đã chỉ định; (c) Đội không có cán bộ hiện trường / không có Đội trưởng (nếu dựng được); (d) ghi nút nào hiện ở Chi tiết cho người tạo và Đội trưởng Đội A/B — **chỉ có mặt/vắng mặt** | **Phải quan sát/ghi lại** (QO34, QO44, QO45); không đạt/không đạt | P2 | TC-54, TC-52, TC-69, TC-70 · EXP-10 · B4 · QO34 |
| TC-ACB-08 ⚠️ | **B6** — Ở Bước 8 bấm quét QR; quét QR-CB1 (CB-B1, hiện trường) từ M2; quan sát (không chọn Đội trước); đi tiếp; gửi | **Xác định:** CB-B1 được chỉ định; **không cần chọn Đội trước**; gửi được; vụ việc **Đang thực hiện** (kiểm ở POST-08). **⚑ chỉ ghi quan sát (QO42):** Đội nhận có phải Đội của CB-B1 không | P1 | TC-55 · DT B6 · F5/QB6(a) · QO42 ⚑ |
| TC-ACB-09 🔭 | **B9** — Chọn Đội A, rồi quét QR-CB1 (cán bộ Đội B): ghi đổi Đội hay báo lỗi; Đội và người hiển thị ở màn xem lại | **⚑ Phải quan sát/ghi lại** (QO42); không đạt/không đạt | P1 | TC-55 · DT B9 · QO42 ⚑ |
| TC-ACB-10 | **B7** — Quét QR-CAM (Phòng Camera) | Hiện thông báo lỗi **chỉ giao việc cho cán bộ hiện trường**; người đó **không** được chỉ định (chip/dòng người chỉ định không có người đó) | P1 | TC-78 · DT B7 · QB6(b) |
| TC-ACB-11 | **B7** — Quét QR-VT (Văn thư) | Như ACB-10 | P1 | TC-78 · DT B7 |
| TC-ACB-12 | **B7** — Quét QR-NG (người giao việc) | Như ACB-10 | P1 | TC-78 · DT B7 |
| TC-ACB-13 🔭 | **Charter EXP-9** — **B8**: quét QR-TỰ (chính mình), mã không hợp lệ, ảnh QR không hợp lệ; mất mạng ngay lúc "Đang tra cứu cán bộ…"; ghi nội dung thông báo; thêm: ảnh hưởng tới thông báo Đội trưởng, cảnh báo Khẩn cấp, thống kê. Ghi quan sát bảo mật mã QR (G11) | **Phải quan sát/ghi lại** (QO43, QO42 ⚑); không đạt/không đạt | P1 | TC-78 · EXP-9 · B8 · QO43 |
| TC-ACB-14 ⚠️ | **B10** — Ở màn quét bấm "Chọn ảnh QR", chọn ảnh QR-CB1 trong thư viện (cho phép quyền Ảnh nếu hỏi) | **Xác định:** tra cứu và chỉ định được CB-B1 như quét camera. **Còn mở:** xử lý khi từ chối quyền Camera/Ảnh (QO6, QO43) | P2 | TC-79 · DT B10 · QO43 |
| TC-ACB-15 | **B10** — Ở màn quét bấm "Huỷ" (khi đã chọn sẵn Đội B và chưa chỉ định ai) | Quay lại Bước 8; Đội B và người đã chọn **không đổi** | P2 | TC-79 · DT B10 |

---

## 10 · Bước 9 — Xem lại, hạn, gửi, mã vụ việc · `TC-SUB` (mục 2 #10, kỹ thuật 5.10)

> Giá trị biên thời điểm hạn (chỉ [NG]; T = thời điểm hiện tại, ghi giờ chạy), phân vùng bộ dữ liệu, mã vụ việc. SUB-03…12 dùng DT-A; hạn của [CB]: tạm bỏ (E3). "Bộ tối thiểu" = chỉ trường bắt buộc theo nhánh; "bộ đầy đủ" = mọi trường tuỳ chọn có dữ liệu (ảnh, vị trí, hành động, đối tượng, đề xuất).

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-SUB-01 | **[NG]** Gửi bộ tối thiểu; ở Bước 9 đọc màn xem lại | Tóm tắt đúng loại, mô tả, "Bằng chứng: 0 tệp", người được giao; chỉ có nút "Giao việc và gửi" | P2 | TC-56 · EP bộ tối thiểu |
| TC-SUB-02 | **[NG]** Nhập bộ đầy đủ (2 ảnh, 3 ô mô tả, 1 đối tượng, 2 đề xuất); đọc màn xem lại | Tóm tắt đúng: loại, mô tả, "Bằng chứng: 2 tệp", người được giao | P2 | TC-56 · EP bộ đầy đủ |
| TC-SUB-03 | Chọn hạn = **ngày hôm qua** | Không chọn được/không hợp lệ; nút "Giao việc và gửi" không sáng | P1 | TC-58 · BVA hôm qua · BR06 |
| TC-SUB-04 | Chọn hạn = hôm nay, giờ **trước T** | Không chọn được/không hợp lệ | P1 | TC-58 · BVA hôm nay < T |
| TC-SUB-05 ⚠️ | Chọn hạn = hôm nay, giờ **sát T** (T + 1 phút) | **Còn mở — chỉ ghi lại hành vi quan sát được:** chọn được hay không (QO17) | P1 | TC-58 · BVA sát T · QO17 |
| TC-SUB-06 | Chọn hạn = hôm nay, giờ **sau T** (T + vài giờ, cùng ngày) | Chọn được; nút gửi sáng | P1 | TC-58 · BVA hôm nay > T |
| TC-SUB-07 | Mở Bước 9 vào lúc hôm nay còn **trước 17:00**; đọc giờ mặc định; đổi giờ sang 09:00 hôm sau | Giờ mặc định **17:00**; đổi được; giá trị mới giữ | P1 | TC-57 · B8 |
| TC-SUB-08 ⚠️ | Mở Bước 9 vào lúc hôm nay **đã quá 17:00** (hoặc đặt giờ thiết bị) | **Còn mở — chỉ ghi lại:** ngày/giờ mặc định (QO17) | P1 | TC-57 · QO17 |
| TC-SUB-09 | Chọn hạn = ngày rất xa (vd 10 năm sau); gửi | Chọn được (không giới hạn tối đa); gửi được; Chi tiết hiện đúng hạn | P1 | TC-58 · BR06 (không tối đa) |
| TC-SUB-10 ⚠️ | Đặt hạn hợp lệ sát T (T + 2 phút), chờ qua hạn rồi bấm gửi | **Còn mở — chỉ ghi lại:** gửi bị chặn hay lọt; app kiểm hạn lúc chọn hay lúc gửi (QO17) | P1 | TC-58 · hạn qua lúc gửi · QO17 |
| TC-SUB-11 | Chọn hạn ngày mai 17:00 (có thể bằng giờ khác); gửi; mở Chi tiết | Hạn lưu thành "Hạn" của **từng phần việc** và "Hạn xử lý" của vụ việc, đúng ngày giờ đã chọn | P1 | TC-57 · lưu hạn |
| TC-SUB-12 🔭 | **Charter EXP-8** — đặt múi giờ thiết bị khác UTC+7; chọn hạn; ghi hiển thị, giá trị lưu, so với giờ Việt Nam | **Phải quan sát/ghi lại** (QO17); không đạt/không đạt | P2 | TC-59 · EXP-8 · QO17 |
| TC-SUB-13 ⚠️ | **[CB]** Đi tới bước cuối (LN-CB); ghi nội dung tóm tắt, có phần chọn hạn không, nhãn nút gửi; gửi | **Xác định:** **không có** phần chọn hạn; nút gửi bật khi hợp lệ; gửi thành công. **Còn mở:** nội dung tóm tắt (có hiện Đội nhận và người được chỉ định không), nhãn nút (QO35) | P1 | TC-60 · E3 · QO35 |
| TC-SUB-14 | Ở bước cuối của cả hai nhánh tìm nút "Xử lý tại chỗ và hoàn thành" | **Không có**; chỉ có nút gửi | P3 | TC-61 · Q4 |
| TC-SUB-15 | **[NG]** Gửi 1 vụ việc; ghi mã | Đúng **1** vụ việc được tạo; mã dạng **VV + 6 chữ số**, không trùng mã nào đã có | P1 | TC-62 · EP 1 lần gửi · BR38 |
| TC-SUB-16 | **[CB]** Như SUB-15 | Như SUB-15 | P1 | TC-62 · EP 1 lần gửi |
| TC-SUB-17 | **[NG]** Xen kẽ: tạo vụ việc XL01, tạo 1 giao việc (option Giao việc), tạo thêm vụ việc XL01; ghi 3 mã | Mã VV của cả ba **không trùng** (dùng chung chuỗi VV) | P1 | TC-62 · EP xen kẽ XL01/GV01 [NG] |
| TC-SUB-18 | **[CB]** Xen kẽ như SUB-17 (cán bộ tạo vụ việc XL01 — option Giao việc theo quyền của tài khoản; nếu tài khoản không có quyền tạo giao việc thì dùng DT-A tạo 1 giao việc xen giữa) | Mã VV các lần **không trùng** | P1 | TC-62 · EP xen kẽ [CB] |
| TC-SUB-19 🔭 | **Charter EXP-5** — ở cả hai nhánh: bấm gửi nhiều lần liên tiếp; mạng chập chờn lúc gửi; lỗi máy chủ (nếu tạo được); ghi có tạo trùng vụ việc/phần việc/thông báo không, dữ liệu có giữ để gửi lại không | **Phải quan sát/ghi lại** (QO18); không đạt/không đạt | P1 | TC-63 · EXP-5 · QO18 |
| TC-SUB-20 ⚠️ | **[NG], bộ tối thiểu:** gửi; mở Chi tiết | **Xác định:** các giá trị bắt buộc hiện đúng; thời gian tạo và người tạo hiện đúng. **Còn mở:** nội dung phần việc lấy từ đâu (QO19); Nguồn phát hiện (QO26) | P1 | TC-64 · EP tối thiểu × [NG] |
| TC-SUB-21 ⚠️ | **[NG], bộ đầy đủ:** gửi; mở Chi tiết, đối chiếu từng khối (Đầu trang, Thông tin vụ việc, Thông tin liên quan, Đề xuất, Hình ảnh) | **Xác định:** mọi dữ liệu đã nhập hiện đúng khối, không lẫn, không mất. **Còn mở:** QO19, QO26 | P1 | TC-64 · EP đầy đủ × [NG] |
| TC-SUB-22 ⚠️ | **[CB], bộ tối thiểu** (Đội B không chỉ định): gửi; mở Chi tiết bằng DT-B hoặc người tạo | **Xác định:** như SUB-20; Chi tiết **không có hạn** (hiển thị Hạn: QO36). **Còn mở:** QO19, QO26 | P1 | TC-64 · EP tối thiểu × [CB] |
| TC-SUB-23 ⚠️ | **[CB], bộ đầy đủ** (chỉ định CB-B1): gửi; mở Chi tiết, đối chiếu như SUB-21 | **Xác định:** như SUB-21. **Còn mở:** QO19, QO26, QO36 | P1 | TC-64 · EP đầy đủ × [CB] |

---

## 11 · Hậu điều kiện: trạng thái ban đầu, ai thấy ở đâu, quyền của người tạo · `TC-POST` (mục 2 #11, kỹ thuật 5.11)

> Bảng quyết định V1–V5. Cần ≥2 thiết bị. Mọi case gửi 1 vụ việc mới ngay trước khi kiểm. "Thấy ở tab X" = mở tab và tìm đúng mã VV vừa tạo. Case [CB] dùng người tạo CB-A1 (Đội A), Đội nhận Đội B. **QO44:** chỉ kiểm có mặt/vắng mặt nút "Hoàn tất xử lý", "Thao tác", "Tiếp nhận"; **không bấm** để kiểm hành vi. Bộ đếm/thẻ ⚠ ghi nguyên trạng.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-POST-01 | **V1 [NG]** DT-A gửi bằng LN-NG (CB-A1 và CB-A2 được giao); mở Chi tiết | Vụ việc **Đang thực hiện**; mỗi cán bộ có 1 phần việc **Đã giao / Chưa bắt đầu**; bộ đếm "Giao việc 0/2" | P1 | TC-65 · V1 |
| TC-POST-02 | **V1** — Người tạo DT-A | Vụ việc hiện ở cả **Tiếp nhận** và **Của tôi** | P1 | TC-68 · V1 người tạo |
| TC-POST-03 | **V1** — NG-A2 (người giao khác cùng Đội A) | Hiện ở tab **Tiếp nhận** | P1 | TC-68 · V1 người giao cùng Đội |
| TC-POST-04 | **V1** — CB-A1 và CB-A2 (cán bộ được chỉ định) | Mỗi người thấy vụ việc ở tab **Của tôi** | P1 | TC-68 · V1 cán bộ chỉ định |
| TC-POST-05 | **V1** — Cán bộ Đội A **không** được chỉ định (CB trong Đội nhưng không được giao), DT-B (người giao Đội khác) | **Không thấy** vụ việc ở bất kỳ tab nào | P1 | TC-68 · V1 không thấy |
| TC-POST-06 | **V1** — Đăng nhập một tài khoản cán bộ; tìm tab Tiếp nhận | Tài khoản cán bộ **không có** tab Tiếp nhận | P1 | TC-68 · V1 · B24 |
| TC-POST-07 🔭 | **V1 ⚑** — TR-CACK rồi PT-B tạo vụ việc cho Đội B; ghi vụ việc hiện ở Tiếp nhận của ai (người tạo? Đội trưởng Đội nhận? Đội trưởng khác?) | **⚑ Phải quan sát/ghi lại** (QO25); không đạt/không đạt | P1 | TC-68 · V1 Trưởng/Phó trưởng CACK · QO25 ⚑ |
| TC-POST-08 ⚠️ | **V2 [CB] có chỉ định** — CB-A1 gửi chỉ định CB-B1 (hoặc ACB-08 qua QR); mở Chi tiết bằng CB-B1 và DT-B | **Xác định:** trạng thái **Đang thực hiện**; **không có hạn hoàn thành** đặt khi tạo. **Còn mở — chỉ ghi lại:** cách hiển thị Hạn/Nhắc việc/Kết quả và "Hạn xử lý" khi không có hạn (QO36) | P1 | TC-66 · V2 · E2 · QO36 |
| TC-POST-09 ⚠️ | **V3 [CB] không chỉ định** — CB-A1 gửi, Đội B, không chỉ định (ACB-03); DT-B mở tab Tiếp nhận, mở Chi tiết | **Xác định:** trạng thái **Chờ tiếp nhận**; thẻ ở Tiếp nhận của DT-B có nhãn "Chờ tiếp nhận", "Cần xử lý" và nút nhanh "Tiếp nhận"; Chi tiết có nút "Thao tác" (chỉ kiểm có mặt, **không bấm**). **Còn mở:** bộ đếm "Giao việc x/y" khi chờ tiếp nhận (QO36); chi tiết về nút "Hoàn tất xử lý"/thẻ nhanh (QO44) | P1 | TC-67 · V3 · D1/D4 · QO36/QO44 |
| TC-POST-10 | **V2** — Người tạo CB-A1 (sau khi gửi chỉ định CB-B1) | Thấy vụ việc ở tab **Của tôi** | P1 | TC-69 · V2 người tạo |
| TC-POST-11 ⚠️ | **V2** — DT-A (Đội trưởng Đội người tạo) | **Xác định:** thấy ở tab **Tiếp nhận**; mở được Chi tiết; **có** nút "Hoàn tất xử lý" (chỉ kiểm có mặt, không bấm). **Còn mở:** ý nghĩa/hành vi nút (QO44) | P1 | TC-69 · V2 Đội trưởng Đội A · QB4(b) · QO44 |
| TC-POST-12 ⚠️ | **V2** — DT-B (Đội trưởng Đội nhận) | **Xác định:** thấy ở **Tiếp nhận**; **có** nút "Hoàn tất xử lý" (chỉ có mặt). **Còn mở:** QO44 | P1 | TC-69 · V2 Đội trưởng Đội B · QB4(c) · QO44 |
| TC-POST-13 | **V2** — CB-B1 (cán bộ được chỉ định) | Thấy ở tab **Của tôi** | P1 | TC-69 · V2 cán bộ chỉ định |
| TC-POST-14 | **V2** — DT-C (Đội trưởng Đội không liên quan); CB-B2 (cùng Đội B, không được chỉ định); một cán bộ Đội A khác không liên quan (CB-A2) | **Không thấy** vụ việc ở bất kỳ tab nào | P1 | TC-69 · V2 không thấy |
| TC-POST-15 ⚠️ | **V4** — CB-A1 tạo, bàn giao **chính Đội A** (không chỉ định); DT-A kiểm | **Xác định:** DT-A thấy vụ việc ở **Tiếp nhận** (gộp vai trò Đội trưởng A/B, không khác biệt — QB4(d)); trạng thái Chờ tiếp nhận. **Còn mở:** thẻ/nút nhanh của DT-A (QO44) | P1 | TC-69 · V4 · QB4(d) · QO44 |
| TC-POST-16 ⚠️ | **V5** — Người tạo CB-A1 mở Chi tiết vụ việc của mình (cả khi Đang thực hiện và Chờ tiếp nhận); tìm các nút: Gia hạn, Phân công lại, Phân công tiếp, Huỷ phần việc, Hoàn thành, Hoàn tất xử lý, Thao tác; ghi thêm Lịch sử, thêm ảnh bằng chứng | **Xác định:** **không có** các nút Gia hạn, Phân công lại, Phân công tiếp, Huỷ phần việc, Hoàn thành, Hoàn tất xử lý, Thao tác. **Còn mở — chỉ ghi lại:** Lịch sử, thêm ảnh bằng chứng có hay không (QO45) | P1 | TC-70 · V5 · C5/QB4(a) · QO45 |

---

## 12 · Hậu điều kiện: thông báo, cảnh báo Khẩn cấp, nhắc việc, nhật ký, thẻ Đội/Tổ, thống kê · `TC-NOTI` (mục 2 #12, kỹ thuật 5.11)

> Bảng quyết định thông báo N1–N4, cảnh báo Khẩn cấp E1–E5 + chuẩn nhắc việc + phân vùng. Cần thiết bị nhận thông báo đẩy (quyền Thông báo bật; app ở nền/đóng — G6 ghi quan sát). Hạn/nhắc việc của [CB]: tạm bỏ (E3).

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên | Truy vết |
|---|---|---|:---:|---|
| TC-NOTI-01 | **[NG]** DT-A giao việc cho CB-A1 và CB-A2; mỗi cán bộ mở tab Thông báo | Mỗi người nhận **đúng 1** thông báo "Bạn có phần việc mới" (chưa đọc in đậm); mở thông báo vào được phần việc; **không qua SMS** (BR17) | P1 | TC-71 · BR17 |
| TC-NOTI-02 | **[NG]** Cán bộ khác không được giao (CB-B1) kiểm tab Thông báo | Không nhận thông báo "Bạn có phần việc mới" của vụ việc này | P1 | TC-71 · người không chỉ định |
| TC-NOTI-03 ⚠️ | **N1 [CB]** CB-A1 gửi vụ việc bàn giao Đội B; DT-A kiểm Thông báo | **Xác định:** DT-A (Đội trưởng Đội người tạo) **nhận** thông báo. **Còn mở:** tiêu đề/nội dung (QO37) | P1 | TC-72 · N1 · C8 |
| TC-NOTI-04 ⚠️ | **N2 [CB]** Như NOTI-03 không chỉ định; DT-B kiểm Thông báo | **Xác định:** DT-B (Đội trưởng Đội nhận) **nhận** thông báo (kể cả khi không chỉ định — D1). **⚑ chỉ ghi quan sát (QO42):** khi Đội nhận bằng QR | P1 | TC-72 · N2 · D1 · QO42 ⚑ |
| TC-NOTI-05 | **N3 [CB]** CB-A1 gửi chỉ định CB-B1; CB-B1 kiểm Thông báo | CB-B1 nhận thông báo "Bạn có phần việc mới" | P1 | TC-72 · N3 |
| TC-NOTI-06 | **N4 [CB]** Cùng vụ việc NOTI-05: DT-C, CB-B2, CB-A2, VT kiểm Thông báo | **Không** ai trong nhóm này nhận thông báo của vụ việc | P1 | TC-72 · N4 |
| TC-NOTI-07 ⚠️ | **N1 = N2** CB-A1 bàn giao chính Đội A không chỉ định; DT-A kiểm Thông báo | **Còn mở — chỉ ghi lại:** DT-A nhận 1 hay 2 thông báo, tiêu đề (QO37) | P1 | TC-72 · N1/N2 trùng Đội · QO37 |
| TC-NOTI-08 🔭 | **N2 ⚑** CB-A1 bàn giao bằng QR-CB1 (cán bộ Đội B), có/không chọn Đội trước; ghi Đội trưởng nào nhận thông báo | **⚑ Phải quan sát/ghi lại** (QO42); không đạt/không đạt | P1 | TC-72 · EXP-9 · QO42 ⚑ |
| TC-NOTI-09 ⚠️ | **E1 [NG]** TR-CACK tạo vụ việc mức **Khẩn cấp**, giao cho Đội B (Đội B có PT-B phụ trách) và CB-B1; PT-B kiểm Thông báo | **Xác định:** PT-B (phụ trách Đội nhận) nhận cảnh báo Khẩn cấp. **Còn mở:** "ưu tiên cao, không bắt buộc xác nhận" có còn không (QO38) | P1 | TC-73 · E1 · G1 · QO38 |
| TC-NOTI-10 ⚠️ | **E1 [CB]** CB-A1 tạo Khẩn cấp, bàn giao Đội B; PT-B kiểm | Như NOTI-09 | P1 | TC-73 · E1 · QO38 |
| TC-NOTI-11 ⚠️ | **E2 [NG]** TR-CACK tạo Khẩn cấp giao Đội-N (chưa có Phó trưởng phụ trách); Đội trưởng Đội-N và các vai trò khác trong Đội-N kiểm | **Xác định:** Đội trưởng của Đội-N nhận cảnh báo. **Còn mở:** "Đội phó" là vai trò nào, ai nhận (QO38) | P1 | TC-73 · E2 · G1 · QO38 |
| TC-NOTI-12 ⚠️ | **E2 [CB]** CB-A1 tạo Khẩn cấp, bàn giao Đội-N | Như NOTI-11 | P1 | TC-73 · E2 · QO38 |
| TC-NOTI-13 | **E3** CB-A1 (Đội A) tạo Khẩn cấp bàn giao Đội B (Đội B có PT-B; Đội A do PT-X phụ trách); TR-CACK và PT-X kiểm Thông báo | **Trưởng CACK không nhận**; PT-X (phụ trách Đội khác, kể cả Đội người tạo) **không nhận** | P1 | TC-73 · E3 · E8/F3 |
| TC-NOTI-14 | **E4** Tạo vụ việc mức Bình thường rồi Nghiêm trọng bàn giao Đội B; PT-B kiểm | PT-B **không** nhận cảnh báo Khẩn cấp | P1 | TC-73 · E4 |
| TC-NOTI-15 🔭 | **E5** PT-B tạo vụ việc Khẩn cấp cho Đội B (Đội mình phụ trách); ghi PT-B có tự nhận cảnh báo không | **Phải quan sát/ghi lại** (QO30); không đạt/không đạt | P1 | TC-73 · E5 · QO30 |
| TC-NOTI-16 🔭 | **QR ⚑** CB-A1 tạo Khẩn cấp, bàn giao bằng QR-CB1; ghi PT nào nhận cảnh báo | **⚑ Phải quan sát/ghi lại** (QO42); không đạt/không đạt | P1 | TC-73 · QO42 ⚑ |
| TC-NOTI-17 ⚠️ | **[NG]** Phân vùng **ngắn trong ngày:** giao lúc giờ G, hạn = G + 6 giờ cùng ngày; mở Chi tiết, đọc "Nhắc việc"; tính G + 2/3 × (hạn − G) | **Xác định (công thức BR11):** thời điểm Nhắc việc = giao + 2/3 × (hạn − giao), sai số ≤ 10 giây theo ví dụ BR11. **Lưu ý:** công thức "suy ra" từ ảnh — cần khách hàng xác nhận khi nghiệm thu | P2 | TC-74 · BR11 · EP ngắn trong ngày |
| TC-NOTI-18 ⚠️ | Như NOTI-17, hạn = ngày kế tiếp 17:00 (qua đêm) — ví dụ BR11: giao 14:15 ngày 21/10, hạn 17:00 22/10 → nhắc ≈ 08:05 ngày 22/10 | Như NOTI-17 | P2 | TC-74 · EP qua đêm |
| TC-NOTI-19 ⚠️ | Như NOTI-17, hạn = 5 ngày sau lúc 17:00 | Như NOTI-17 | P2 | TC-74 · EP nhiều ngày |
| TC-NOTI-20 ⚠️ | **[NG]** Gửi giao việc cho 2 cán bộ; mở Diễn biến xử lý (và Lịch sử mỗi phần việc); thử sửa/xoá dòng | **Xác định:** mỗi phần việc có 1 dòng "Giao việc" (giờ · người thực hiện · hành động); không sửa/xoá được dòng. **Còn mở:** 1 hay 2 bản ghi cho "Giao việc" và "Phân công" (QO19) | P2 | TC-75 · [NG] · QO19 |
| TC-NOTI-21 ⚠️ | **[CB] không chỉ định:** CB-A1 gửi; DT-B mở Diễn biến xử lý | **Còn mở — chỉ ghi lại hành vi quan sát được:** mốc "Gửi tiếp nhận" kèm vai trò và Đội người tạo (quan sát từ ảnh, chưa có mô tả nghiệp vụ — QO40) | P2 | TC-75 · [CB] không chỉ định · QO40 |
| TC-NOTI-22 ⚠️ | **[CB] có chỉ định / quét QR:** CB-A1 gửi chỉ định CB-B1 (rồi lần khác quét QR-CB1); xem Diễn biến xử lý và người thực hiện ở Lịch sử | **Còn mở — chỉ ghi lại:** mốc nào được ghi; người thực hiện (QO40); 1 hay 2 bản ghi (QO19) | P2 | TC-75 · [CB] chỉ định/QR · QO40/QO19 |
| TC-NOTI-23 | **Thẻ Đội/Tổ — 1 cán bộ:** giao cho CB-A1; mở thẻ và Chi tiết, đọc Đội/Tổ | **Xác định:** thẻ/Chi tiết hiện Đội và Tổ của cán bộ được giao (đối chiếu dữ liệu quản trị). | P2 | TC-76 · EP 1 cán bộ |
| TC-NOTI-24 ⚠️ | **Nhiều cùng Tổ:** giao cho CB-B1 và CB-B2 (cùng Tổ) | Thẻ/Chi tiết hiện Đội và Tổ đúng, không lặp thừa/không thiếu (cách rút gọn: chỉ ghi lại) | P2 | TC-76 · EP nhiều cùng Tổ |
| TC-NOTI-25 ⚠️ | **Nhiều khác Tổ:** giao cho CB-A1 và CB-A2 (khác Tổ) | Thẻ/Chi tiết hiện cả hai Tổ đúng (cách hiển thị: chỉ ghi lại) | P2 | TC-76 · EP nhiều khác Tổ |
| TC-NOTI-26 ⚠️ | **Chờ tiếp nhận:** [CB] không chỉ định (ACB-03); DT-B đọc Đội/Tổ trên thẻ và Chi tiết | **Còn mở — chỉ ghi lại hành vi quan sát được:** Đội/Tổ khi chưa có người được giao (QO26) | P2 | TC-76 · EP chờ tiếp nhận · QO26 |
| TC-NOTI-27 ⚠️ | Đọc "Nguồn phát hiện" ở Chi tiết cho vụ việc do (a) DT-A, (b) CB-A1 hiện trường, (c) CAM-A tạo | **Còn mở — chỉ ghi lại:** giá trị Nguồn phát hiện theo người tạo (ảnh hiện "Phòng Camera" trái B14 — QO26) | P2 | TC-76 · Nguồn phát hiện · QO26 |
| TC-NOTI-28 | **Thống kê [NG]:** ghi số liệu Trang chủ (Tổng vụ việc, Chờ tiếp nhận, Khẩn cấp mở, Vụ việc theo khu vực) của DT-A trước và sau khi DT-A tạo 1 vụ việc Khẩn cấp cho Đội A | **Xác định:** Tổng vụ việc +1, Khẩn cấp mở +1, theo khu vực của vụ việc +1 (Chờ tiếp nhận không đổi) | P2 | TC-77 · EP Đội của vụ việc × [NG] |
| TC-NOTI-29 ⚠️ | **Thống kê [CB] Chờ tiếp nhận:** ghi số liệu Trang chủ của DT-B trước/sau khi CB-A1 gửi vụ việc không chỉ định bàn giao Đội B | **Xác định:** ô **Chờ tiếp nhận** của Trang chủ DT-B tăng (nay có thể khác 0 — E6); Tổng vụ việc phản ánh vụ việc mới. **Còn mở:** CB-A1 Đội A → Đội B tính cho Đội nào ở các ô còn lại (QO39) | P2 | TC-77 · EP Đội của vụ việc × [CB] · QO39 |
| TC-NOTI-30 | **Thống kê Đội không liên quan:** ghi số liệu Trang chủ của DT-C trước/sau NOTI-29 | Không đổi | P2 | TC-77 · EP Đội không liên quan |
| TC-NOTI-31 🔭 | **Thống kê ⚑ QR:** CB-A1 bàn giao bằng QR-CB1; ghi số liệu Trang chủ của DT-A, DT-B | **⚑ Phải quan sát/ghi lại** (QO42/QO39); không đạt/không đạt | P2 | TC-77 · QO42 ⚑ |

---

## 13 · Đối chiếu phủ test condition (truy vết ngược 79 TC → case)

Mỗi case ở trên truy về đúng 1 dòng của mục 5 test plan (cột "Truy vết": phân vùng, rule bảng quyết định, giá trị biên, transition hoặc charter). Chuỗi truy vết: yêu cầu (nguồn nêu ở đầu từng nhóm và cột Truy vết: L6, C2, E1, F1, QB4–QB6, G1, BR…) → test condition `TC-nn` → mục tiêu (dòng mục 5) → case.

| Nhóm | TC (test analysis) → case |
|---|---|
| AUTH | 01→AUTH-01,02,03 · 02→04 · 03→05 · 04→06 · 05→07 · 06→08,09,10,11 |
| NAV | 07→NAV-11 · 08→NAV-12…17 · 09→NAV-18 · 10→NAV-01…10 |
| EVD | 11→EVD-01 · 12→02,03,04,05 · 13→06,07 · 14→08,09,10 · 15→11 · 16→12,13,14 · 17→15 |
| CLS | 18→CLS-01 · 19→02,06 · 20→03,08 · 21→04,07 · 22→05,07 · 23→09 · 24→10 · 25→11,12 · 26→13…16 · 27→17,18,19 |
| DSC | 28→DSC-01,02,03 · 29→04 · 30→05 |
| SUBJ | 31→SUBJ-01 · 32→02,03 · 33→04…07 · 34→08…11 · 35→12,13 · 36→14 · 37→15,16 · 38→17 · 39→18,19 · 40→20,21 · 41→22,23,24 · 42→25,26 |
| PROP | 43→PROP-01…04 · 44→05 |
| ASG | 45→ASG-01,02,03 · 46→04,05,06,07 · 47→07,08,09 · 48→10,11,12 · 49→13 · 50→14 |
| ACB | 51→ACB-01,02 · 52→04,05,06,07 · 53→03 · 54→07 · 55→08,09 · 78→10,11,12,13 · 79→14,15 |
| SUB | 56→SUB-01,02 · 57→07,08,11 · 58→03,04,05,06,09,10 · 59→12 · 60→13 · 61→14 · 62→15…18 · 63→19 · 64→20…23 |
| POST | 65→POST-01 · 66→08 · 67→09 · 68→02…07 · 69→10…15 (và ACB-07) · 70→16 |
| NOTI | 71→NOTI-01,02 · 72→03…08 · 73→09…16 · 74→17,18,19 · 75→20,21,22 · 76→23…27 · 77→28…31 |

**Kết quả:** 79/79 test condition có ít nhất 1 case; không có test condition nào chưa có case.

## 14 · Tổng hợp

| Nhóm | Số case | P1 | P2 | P3 |
|---|---:|---:|---:|---:|
| AUTH | 11 | 10 | 1 | 0 |
| NAV | 18 | 10 | 7 | 1 |
| EVD | 15 | 4 | 10 | 1 |
| CLS | 19 | 10 | 7 | 2 |
| DSC | 5 | 3 | 1 | 1 |
| SUBJ | 26 | 18 | 3 | 5 |
| PROP | 5 | 0 | 0 | 5 |
| ASG | 14 | 9 | 5 | 0 |
| ACB | 15 | 12 | 3 | 0 |
| SUB | 23 | 19 | 3 | 1 |
| POST | 16 | 16 | 0 | 0 |
| NOTI | 31 | 16 | 15 | 0 |
| **Cộng** | **198** | **127** | **55** | **16** |

Marker: 🔭 = 19 · ⚠️ = 94 · 🆕 = 0. **Lệch ưu tiên có lý do:** TC-ACB-07 (charter EXP-10) để P2 theo TC-54 là test condition chính của charter; các test condition P1 còn lại của charter (TC-52, 69, 70) đã có case P1 riêng (ACB-04…06, POST-10…16). Tỷ lệ 🔭 + ⚠️ = 113/198 (khoảng 57%): phần lớn là case **có phần Xác định chấm được** kèm phần Còn mở; case chỉ-quan-sát hoàn toàn là 19 case 🔭 cộng vài case ⚠️ không có phần xác định (xem mục Gap).

## 15 · Câu hỏi và gap mới phát hiện (không tự trả lời)

1. **Dữ liệu nền chưa có ở mục 7 test plan** — cần quản trị viên dựng thêm: NG-A2 (người giao thứ hai cùng Đội A, cho TC-68); CB-B1/CB-B2 **cùng Tổ** (cho TC-76 "nhiều cùng Tổ"; mục 7 chỉ nêu "khác Tổ"); Đội-N (chưa có Phó trưởng phụ trách), PT-X; tài khoản DT-0/CB-0/CAM-0 trong Đội chưa gán khu vực (mục 7 chỉ nêu Đội chưa gán khu vực, chưa nêu tài khoản).
2. **TC-26 (L-1 không cờ):** test basis chỉ nói loại có cờ → khối "Biểu mẫu và chữ ký"; chưa nói loại **không** cờ thì khối ẩn hay rỗng → CLS-15, 16 chỉ ghi lại phần này (đã gắn QO8). Đề nghị bổ sung vào QO8.
3. **TC-62 nhánh [CB] (SUB-18):** chưa rõ cán bộ có tạo được "Giao việc" (GV01) hay không (đặc tả §3.4 giữ quyền tạo Giao việc cho cán bộ "theo đặc tả" nhưng không nêu rõ) → case cho phép dùng DT-A tạo giao việc xen giữa.
4. **TC-65 "Giao việc 0/y":** case POST-01 hiểu y = số cán bộ được chỉ định (đối chiếu Chi tiết thật).
5. **Case có phần xác định rất ít hoặc hầu như chỉ quan sát (ngoài 19 case 🔭):** CLS-06, 07, 08; ASG-11, 12; ACB-09 (là 🔭); EVD-09; SUB-05, 08, 10; NOTI-07, 21, 26, 27 — đã nêu "Còn mở"; không coi là "xong" như các case khác.
6. **Mục 0 skill:** test plan mục 10 còn 40 câu mở; theo yêu cầu của caller và quyết định "Mang sang, chạy tiếp" của QC lead (2026-10-28) các câu này được viết dạng ⚠️ (không dừng hỏi thêm). Không phát hiện mâu thuẫn hay thiếu rule trong bảng quyết định/chuyển trạng thái của test plan khi đối chiếu test basis; không cần chạy lại test-plan vì lý do này.
7. **Chưa đủ điều kiện chạy test:** model/iOS/build (QO23), dữ liệu nền mục 1 trên, bộ giấy tờ giả, công cụ cho SUBJ-17 (G5), thiết bị ≥2.
