# Test Analysis — Tạo vụ việc xử lý vi phạm (flow `03_case-create`)

> ⚠️ SUPERSEDED — không dùng tài liệu này làm test basis. Đã thay bằng [test-analysis-dac-ta-v2.1.md](test-analysis-dac-ta-v2.1.md) (2026-10-26) vì repo đã có đặc tả chính thức v2.1 ([dac-ta-chuc-nang-v2.1.md](../../specs/xu-ly-vi-pham-giao-viec/dac-ta-chuc-nang-v2.1.md)). Câu hỏi B1–B7, O1–O19 của tài liệu này được đối chiếu ở mục 6 của tài liệu mới.

> ⚠️ DRAFT — chờ xác nhận: 7 câu hỏi chặn (B1–B7, mục 4.1) — quyền tạo vụ việc của Cán bộ / Tổ phó chưa uỷ quyền; bước nào bắt buộc (text và ảnh nói khác nhau); vụ việc giao cho Đội hay cho cán bộ; kết quả sau khi gửi (tab Tiếp nhận của ai, trạng thái ban đầu, thông báo); nút "Xử lý tại chỗ và hoàn thành" chỉ có trong ghi chú trên ảnh; các chức năng chỉ thấy trong ảnh; lưu trữ dữ liệu cá nhân của đối tượng. **Analysis Status: BLOCKED — chưa được phép chạy test-plan.**

> **Test basis:** [mo-ta-chuc-nang-v1.md](../../specs/xu-ly-vi-pham-giao-viec/mo-ta-chuc-nang-v1.md) (mục "Các tính năng chính" 1 + mục "Giao diện và thao tác" 1, Hình 1–17) + [lam-ro-2026-10-26.md](../../specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-26.md) (L1, L2b, L3a(b), L4). Khi mâu thuẫn, file làm rõ thắng.
> **Phạm vi:** chỉ flow `03_case-create` (flow map `.claude/rules/screenshot-naming.md` §7, đã khoá theo L1). Các flow 04–09 chỉ nêu ở mức ảnh hưởng chéo.
> **Nền tảng:** chỉ iPhone (L4). Web quản trị chưa có mô tả (flow `09_web-admin` 🚧).
> **Chuẩn:** ISTQB Foundation Level v4.0.1 §1.4.1 (Test Analysis) + §3 (Static Testing) + §5.2 (Risk Management)
> **Bước tiếp theo:** [test-plan](../../../.claude/skills/test-plan/SKILL.md) sẽ dùng mục 2 (test condition) làm test object và mục 2 cột risk level làm cơ sở mục 6 (risk-based prioritization) — chỉ chạy sau khi mục 4.1 (câu hỏi chặn) đã được trả lời.
> **Ngày lập:** 2026-10-26 · **Người lập:** QC

### Quy ước dùng trong tài liệu

- **[Text]** = có trong text của spec hoặc file làm rõ. **[Ảnh Hn]** = chỉ quan sát được trên ảnh Hình n (build hiển thị ở Hình 1: "Phiên bản 1.0.0 (52) · 19/10/2026"), **không có trong text** — là quan sát hành vi hiện tại, chưa phải requirement đã xác nhận.
- **Dữ liệu cá nhân:** Hình 2, 9, 10, 11 chứa họ tên / số giấy tờ / ngày sinh; Hình 13–17 chứa email tài khoản. Tài liệu này **không chép** các giá trị đó — chỉ dùng tên trường. Dữ liệu ví dụ (nếu có) là dữ liệu giả.
- **Thang risk (định tính, ma trận §5.2):** Cao×Cao, Cao×Vừa, Vừa×Cao → **Cao (P1)** · Vừa×Vừa, Thấp×Cao, Cao×Thấp → **Vừa (P2)** · Vừa×Thấp, Thấp×Vừa, Thấp×Thấp → **Thấp (P3)**. "Chưa xếp hạng" = chưa đủ căn cứ cho ít nhất 1 trục → chờ câu hỏi ở mục 4, **không** gán mức trung bình cho có.

### Giả định (KHÔNG phải fact — cần user chấp nhận hoặc sửa)

| # | Giả định | Vì sao cần | Câu hỏi liên quan |
|---|---|---|---|
| A1 | **Risk likelihood** ở mục 2 là ước lượng của QC dựa trên độ phức tạp kỹ thuật (tích hợp camera/OCR, chọn nhiều, ràng buộc ngày giờ, đồng bộ nhiều tài khoản) và mức mơ hồ của spec — dự án mới, **không có lịch sử lỗi, không có thông tin kiến trúc**. | §5.2: likelihood cần căn cứ; hiện chỉ có căn cứ gián tiếp. | O18 |
| A2 | **Risk impact** suy từ mục đích hệ thống trong spec ("không bị thiếu thông tin trong quá trình giao nhận") và việc dữ liệu đối tượng được tái sử dụng ở biên bản (spec mục "Tạo và ký văn bản": "hệ thống đã tự điền các trường thông tin có sẵn") — chưa có thông tin business impact trực tiếp từ PO/đơn vị nghiệp vụ. | §5.2: impact cần căn cứ nghiệp vụ. | O18 |
| A3 | Nhãn UI, danh sách lựa chọn và trạng thái nút bật/tắt lấy từ ảnh build 1.0.0 (52) được dùng làm **mô tả test object hiện tại**, không phải expected result đã chốt. | Spec text không liệt kê trường/nhãn của từng bước. | O15 |

---

## 1. Đánh giá testability của test basis

| # | Trích đoạn / mục trong test basis | Vấn đề | Loại | Cần hỏi ai | → Câu hỏi |
|---|---|---|---|---|---|
| T1 | "Bao gồm 2 phân quyền cho user: 1. … giao việc/tạo vụ việc … 2. … nhận việc …: Cán bộ" | Không nói Cán bộ có **bị cấm** tạo vụ việc hay không, cũng không nói cách chặn (ẩn nút "+", vô hiệu hoá, hay báo lỗi khi gửi). Hai cách hiểu: (a) Cán bộ không có quyền tạo → cần test condition kiểm tra chặn; (b) danh sách chỉ mô tả vai trò chính, Cán bộ vẫn có thể tạo → test condition ngược lại. Suy luận "(i) cán bộ không được tạo" của orchestrator **chưa được xác nhận**. | Mơ hồ / thiếu | PO / QC lead | B1 |
| T2 | "Tổ phó được uỷ quyền" (spec) + L2b "chỉ Tổ phó đã được uỷ quyền" | L2b trả lời trong ngữ cảnh 4 chức năng ở L2 (gia hạn, phân công lại, huỷ, phân công tiếp). Chưa có xác nhận trực tiếp cho **Tạo vụ việc**; cơ chế uỷ quyền (ai uỷ quyền, ở đâu, có hiệu lực ngay/thu hồi được) không được mô tả. Suy luận "(ii) Tổ phó chưa uỷ quyền = không có quyền giao việc" **chưa được xác nhận** cho flow này. | Thiếu | PO / QC lead | B1 |
| T3 | Bước 1 "(không bắt buộc)"; L3a(b) "Mô tả ở bước 5 là bắt buộc"; các bước 2, 3, 4, 6, 7, 8, 9 không ghi gì | **Mâu thuẫn text ↔ ảnh** về tính bắt buộc. Cách hiểu (a) theo text: chỉ bước 1 được ghi "không bắt buộc" → các bước còn lại bắt buộc. Cách hiểu (b) theo ảnh: bước 7 ghi rõ "Tuỳ chọn — có thể chọn nhiều phương án" [Ảnh H12]; bước 6 nút "Tiếp tục" bật khi chưa có đối tượng nào [Ảnh H8]; bước 3, 4, 5, 8 nút "Tiếp tục" mờ khi chưa chọn/nhập [Ảnh H5, H6, H7, H13]; bước 9 "Giao việc & gửi" mờ khi chưa chọn hạn [Ảnh H15]. Bước 2 không xác định được vì ảnh đã có mục được chọn sẵn [Ảnh H4]. | Mâu thuẫn | PO | B2 |
| T4 | Bước 8 "Chọn cán bộ để giao việc - có thể chọn 1 hoặc nhiều người" | Ảnh cho thấy bước 8 có **hai** lựa chọn: "Đội nhận việc" (thẻ Đội, có dấu check) và "Cán bộ nhận việc" (tìm theo email) [Ảnh H13]; ghi chú bước 9: "'Gửi' sẽ chuyển vụ việc tới **Đội** tiếp nhận" [Ảnh H15]. Hai cách hiểu: (a) người nhận là các cán bộ được chọn (theo text); (b) vụ việc gửi tới Đội, cán bộ là người phụ trách trong Đội. Không rõ chọn được nhiều Đội không, danh sách cán bộ giới hạn theo Đội của người tạo hay toàn đơn vị, người tạo có tự giao cho mình được không, người có vai trò lãnh đạo (vd Tổ phó — có trong danh sách ở Ảnh H13) có nhận được không. | Mơ hồ / thiếu | PO | B3 |
| T5 | "→ Kết quả: Tạo thành công 1 vụ việc xử lý vi phạm mới, hiện các xử lý vi phạm được tạo ở tab Tiếp nhận" | Không nói tab Tiếp nhận **của ai** (người tạo, cán bộ được giao, mọi thành viên Đội) và **trạng thái ban đầu** của vụ việc. Thẻ vụ việc mới ở Hình 17 hiện "Đang thực hiện" + nhãn "Cần xử lý" [Ảnh H17], trong khi tab có bộ lọc "Chờ tiếp nhận" [Ảnh H17] và luồng chính nói cán bộ nhận việc mới "chuyển trạng thái sang đang thực hiện" [Text]. Ảnh H17 chụp lúc 16:48, vụ việc tạo 16:14 → không xác định được trạng thái đã đổi bởi cán bộ hay là trạng thái khởi tạo. | Mơ hồ / mâu thuẫn tiềm ẩn | PO | B4 |
| T6 | Mục "Các tính năng chính" 1, "→ Kết quả: … lưu log ở từng tài khoản, gửi thông báo đến người giao việc và cấp trên. Lưu kết quả vào trang quản trị hệ thống chung" | Đoạn này là kết quả khi vụ việc **hoàn thành** (sau phía nhận việc). Không nói khi **tạo** vụ việc thì: có ghi log không, có gửi thông báo cho cán bộ được giao không (mục 2 của "Giao diện" ngụ ý có, vì cán bộ "có thể chọn từ tab Thông báo" [Text]), "cấp trên" là ai. "Trang quản trị" chưa có mô tả → **không kiểm được** trong đợt này. | Mơ hồ / thiếu / không kiểm được | PO | B4 |
| T7 | Ghi chú bước 9 [Ảnh H15, H16]: "'Xử lý tại chỗ và hoàn thành' yêu cầu đủ biểu mẫu, chữ ký nếu loại vụ việc có cấu hình" | Spec text chỉ có một hành động "Giao việc và gửi". Ghi chú trên ảnh nhắc tới hành động thứ hai "Xử lý tại chỗ và hoàn thành" nhưng **không thấy nút** đó trên Hình 15/16, và nhắc "loại vụ việc có cấu hình" biểu mẫu — liên quan flow `05_record-signing`. Không rõ chức năng này có tồn tại/thuộc phạm vi không. | Mâu thuẫn (ảnh ↔ text) | PO / Dev | B5 |
| T8 | Các phần chỉ có trong ảnh: mức "Khẩn cấp — Cảnh báo Lãnh đạo + BCH đội" [Ảnh H6]; "Biển số xe" + nút "Tra biển số", "Đơn vị liên quan" [Ảnh H8, H11]; nút micro (nhập giọng nói) ở bước 5 [Ảnh H7]; "Vị trí cụ thể (tuỳ chọn)", "Hành động đã thực hiện (tuỳ chọn)" [Ảnh H7] | Không có trong text → không biết có thuộc phạm vi test basis không, expected result là gì (cảnh báo gửi tới ai, kênh nào; tra biển số tra ở nguồn nào), và business impact khi lỗi → **không đủ căn cứ risk impact**. | Thiếu | PO | B6 |
| T9 | Ghi chú bước 6 [Ảnh H8]: "Quét CCCD/hộ chiếu hoặc chọn ảnh để thêm từng đối tượng (lưu dạng văn bản)" | Hai cách hiểu: (a) chỉ lưu dữ liệu văn bản trích xuất, **ảnh giấy tờ tuỳ thân không được lưu** (trên máy/server); (b) "lưu dạng văn bản" chỉ mô tả cách điền trường, ảnh vẫn được lưu kèm vụ việc. Hai cách hiểu cho hai tập test condition bảo mật khác nhau. Spec cũng không nói ai được xem dữ liệu cá nhân của đối tượng. Hệ thống xử lý CCCD/hộ chiếu → impact cao nhưng chưa có yêu cầu bảo vệ dữ liệu cụ thể. | Mơ hồ / thiếu | PO / bộ phận an ninh dữ liệu | B7 |
| T10 | Bước 9 "Chọn thời gian đến hạn hoàn thành công việc" | Không nêu: hạn có được ở quá khứ / ngay hiện tại không; khoảng tối thiểu/tối đa; múi giờ ("Hạn hoàn thành · giờ Việt Nam" [Ảnh H15]) khi thiết bị đặt múi giờ khác. Ảnh H16 chọn hạn 17:00 cùng ngày với thời điểm tạo. | Thiếu | PO | O1 |
| T11 | Bước 1 "Thêm Hình ảnh/Bằng chứng" | Không nêu số lượng tối đa, dung lượng, định dạng (ảnh/video — ảnh H15 dùng đơn vị "tệp"), có xoá được ảnh đã thêm không. Ảnh H3 có 2 nguồn "Chụp ảnh" và "Thư viện". | Thiếu | PO | O2 |
| T12 | L3a(b) "Mô tả … là bắt buộc" | Không nêu: chuỗi chỉ có khoảng trắng có được coi là rỗng không; độ dài tối đa; cách báo lỗi (ảnh cho thấy nút "Tiếp tục" mờ [Ảnh H7], không có thông báo). | Thiếu | PO | O3 |
| T13 | Toàn bộ wizard 9 bước — nút "Quay lại" [Ảnh H4–H16], màn trình bày dạng sheet [Ảnh H3] | Không nêu dữ liệu có được giữ khi "Quay lại", khi đóng/thoát wizard giữa chừng có cảnh báo hay lưu nháp không. | Thiếu | PO | O4 |
| T14 | Bước 2 "Chọn khu vực phát sinh" | Không nêu nguồn danh sách khu vực (cố định hay cấu hình từ quản trị, theo Đội/nhà ga). Ảnh H4 có 8 mục, mục đầu đã được chọn khi vào bước (không rõ là mặc định hay người dùng đã chọn); Hình 17 có khu vực "SCQN_Sảnh C" không có trong danh sách H4. | Thiếu / mơ hồ | PO / Dev | O5 |
| T15 | Bước 3 "Chọn loại vụ việc" | Ảnh có tuỳ chọn "Khác (tự nhập loại vụ việc)" [Ảnh H5] — không có quy tắc nhập. Nguồn danh sách loại vụ việc không nêu; Hình 17 có loại "Phát hiện vật phẩm nguy hiểm" không có trong H5. | Thiếu | PO | O6 |
| T16 | Bước 6.1 / 6.2 "thông tin sau khi quét được điền tự động vào các trường" | Không nêu: loại giấy tờ được hỗ trợ (CCCD gắn chip, CMND cũ, hộ chiếu — ghi chú H8 nói "CCCD/hộ chiếu"); hành vi khi quét không được/ảnh mờ/không phải giấy tờ; người dùng có sửa được trường đã tự điền không. Hình 9 là màn camera dạng chụp ảnh ("PHOTO"), không phải quét trực tiếp [Ảnh H9]. Bước 6.2 không có ảnh minh hoạ. | Thiếu | PO / Dev | O7 |
| T17 | Bước 6.3 "Người giao việc tự điền các trường thông tin thủ công" | Spec không liệt kê trường. Ảnh cho thấy: Họ tên, Ngày sinh, Giới tính (Nam/Nữ/Khác), Quốc tịch (danh sách thả xuống), Số CCCD/CMND, Số hộ chiếu [Ảnh H10, H11]. Không có trường bắt buộc, định dạng ngày sinh, độ dài số CCCD/CMND, ràng buộc Quốc tịch ↔ loại giấy tờ (ảnh H11: quốc tịch nước ngoài nhưng nhập vào ô Số CCCD/CMND). | Thiếu | PO | O8 |
| T18 | [Ảnh H8] "Số lượng đối tượng" (VD: 04) + danh sách "Đã nhập N đối tượng" [Ảnh H10] | Không rõ quan hệ giữa số khai báo và số đối tượng thực nhập (có phải khớp không, có cảnh báo không). | Thiếu | PO | O9 |
| T19 | Bước 7 "Nhập Đề xuất xử lý" | Text dùng "Nhập", ảnh là danh sách checkbox chọn nhiều (Nhắc nhở, khuyến cáo / Đưa vào diện chú ý / Bàn giao / Phối hợp / Khác) [Ảnh H12]. Không rõ chọn "Khác" có kèm ô nhập không. | Mơ hồ nhẹ / thiếu | PO | O12 |
| T20 | Bước 8 "Tìm theo email…" [Ảnh H13] | Không nêu cách khớp (một phần, hoa/thường), hiển thị khi không có kết quả. | Thiếu | PO | O13 |
| T21 | Bước 9 trên app là "Xem lại & gửi" [Ảnh H15] | Màn xem lại chỉ hiện Loại vụ việc, Mô tả, Bằng chứng, Giao việc, Hạn hoàn thành — **không** hiện khu vực, mức độ, đối tượng, đề xuất xử lý. Không rõ đây là thiết kế chủ ý hay thiếu. | Thiếu | PO | O14 |
| T22 | Tên bước/nút trong spec ↔ app | Bước 8 spec "Chọn cán bộ" ↔ app "Giao việc"; bước 9 spec "Chọn thời gian đến hạn" ↔ app "Xem lại & gửi"; nút spec "Giao việc và gửi" ↔ app "Giao việc & gửi"; spec "Thềm" (lỗi chính tả). Không rõ nhãn nào là expected result. | Mâu thuẫn nhẹ (naming) | PO | O15 |
| T23 | "Click button Giao việc và gửi" | Không nêu hành vi khi mất mạng / lỗi server khi gửi, bấm nút hai lần (tạo trùng), quy tắc sinh mã vụ việc (Hình 17 có mã dạng "VV" + 6 chữ số [Ảnh H17]). | Thiếu | PO / Dev | O16 |
| T24 | Bước 1, 6.1, 6.2 dùng camera / thư viện ảnh | Không nêu hành vi khi người dùng từ chối quyền Camera / Ảnh (iOS system dialog). | Thiếu | PO | O17 |
| T25 | Toàn bộ spec | Không có thông tin business impact / mức độ nghiêm trọng khi từng phần sai, không có lịch sử lỗi → căn cứ risk chỉ gián tiếp (xem A1, A2). | Thiếu | QC lead / PO | O18 |
| T26 | (Project risk, không phải lỗi spec) Ảnh minh hoạ chứa dữ liệu cá nhân thật; `requirements/ui/ux/screenshots/iphone/index.md` chưa ghi model/iOS/build; spec gốc dừng giữa chừng ở "Ký lại biên bản" (không ảnh hưởng flow này). | Rủi ro dự án: dữ liệu test phải là dữ liệu giả (giấy tờ mẫu); chưa xác định thiết bị/iOS mục tiêu cho iPhone. | Thiếu (project) | QC lead | O19 |

**Tổng: 26 vấn đề testability** (T1–T26), dẫn tới 7 câu hỏi chặn (B1–B7) và 17 câu hỏi mở không chặn (O1–O19, trong đó O10/O11 đã gộp vào B6).

---

## 2. Test condition đã ưu tiên hoá

Ký hiệu nguồn: **S-TN1** = spec mục "Các tính năng chính" 1 · **S-GD1** = spec mục "Giao diện và thao tác" 1 (kèm số bước) · **L…** = file làm rõ · **[Ảnh Hn]** = chỉ có trong ảnh.

### 2.A Quyền truy cập

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-01 | Người dùng thuộc 6 vai trò giao việc (Đội trưởng/chỉ huy Đội, Tổ trưởng, Tổ phó **đã** uỷ quyền, Phó đội trưởng, Phó trưởng CACK, Trưởng CACK) thấy nút "Tạo vụ việc" (nút "+") ở Trang chủ và mở được wizard "Tạo vụ việc" tại "Bước 1/9" | S "Bao gồm 2 phân quyền" mục 1; S-GD1; L2b; [Ảnh H2, H3] | Functional + Non-functional (Security — access control) | Vừa | Cao | Cao | P1 |
| TC-02 | Hành vi của chức năng Tạo vụ việc với tài khoản **Cán bộ** (bị chặn hay được phép; nếu chặn thì chặn ở đâu) | S "Bao gồm 2 phân quyền" mục 2 | Security | Chưa xác định | Cao | **Chưa xếp hạng — chờ B1** | — |
| TC-03 | Hành vi với **Tổ phó chưa được uỷ quyền**, và khi trạng thái uỷ quyền của Tổ phó thay đổi | S "Bao gồm 2 phân quyền" mục 1; L2b (ngữ cảnh khác) | Security | Chưa xác định | Cao | **Chưa xếp hạng — chờ B1** | — |

### 2.B Điều hướng wizard

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-04 | Chỉ báo "Bước N/9", tiêu đề bước và thanh tiến trình hiển thị đúng thứ tự 9 bước | S-GD1 "bao gồm 9 bước"; [Ảnh H3–H16] | Non-functional (Usability) | Thấp | Thấp | Thấp | P3 |
| TC-05 | "Quay lại" về bước trước giữ nguyên dữ liệu đã nhập ở các bước (expected chờ O4) | [Ảnh H4–H16] | Functional | Vừa | Vừa | Vừa | P2 |
| TC-06 | Đóng/thoát wizard giữa chừng: dữ liệu bị huỷ hay giữ, có cảnh báo hay không (expected chờ O4) | [Ảnh H3 — dạng sheet] | Functional / Reliability | Vừa | Vừa | Vừa | P2 |
| TC-07 | Điều kiện để đi tiếp ("Tiếp tục" / "Giao việc & gửi") ở **từng** bước đúng theo tính bắt buộc của bước đó | S-GD1 bước 1 "(không bắt buộc)"; L3a(b); [Ảnh H5–H8, H12, H13, H15] | Functional | Vừa | Cao | **Chưa xếp hạng — chờ B2** (tập bước bắt buộc chưa thống nhất) | — |

### 2.C Bước 1 — Hình ảnh / bằng chứng

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-08 | Đi tiếp khỏi bước 1 khi chưa thêm bằng chứng nào | S-GD1 bước 1 "(không bắt buộc)"; [Ảnh H3] | Functional | Thấp | Vừa | Thấp | P3 |
| TC-09 | Thêm bằng chứng qua "Chụp ảnh" (camera) — ảnh được thêm vào vụ việc | S-GD1 bước 1; [Ảnh H3] | Functional | Vừa | Vừa | Vừa | P2 |
| TC-10 | Thêm bằng chứng qua "Thư viện" — ảnh được thêm vào vụ việc | S-GD1 bước 1; [Ảnh H3] | Functional | Vừa | Vừa | Vừa | P2 |
| TC-11 | Số bằng chứng hiển thị ở màn xem lại ("Bằng chứng: N tệp") khớp số đã thêm và toàn bộ bằng chứng được lưu cùng vụ việc sau khi gửi | S-TN1 "không bị thiếu thông tin" (mục đích); [Ảnh H15] | Functional | Vừa | Cao | Cao | P1 |
| TC-12 | Giới hạn số lượng / dung lượng / định dạng bằng chứng và xoá bằng chứng đã thêm (expected chờ O2) | S-GD1 bước 1 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-13 | Hành vi khi quyền Camera / Ảnh bị từ chối (áp dụng bước 1 và 6.1/6.2; expected chờ O17) | S-GD1 bước 1, 6.1, 6.2 | Non-functional (Usability / Compatibility — tương tác iOS) | Vừa | Vừa | Vừa | P2 |

### 2.D Bước 2–4 — Khu vực, loại vụ việc, mức độ

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-14 | Chọn một khu vực phát sinh và giá trị được lưu đúng vào vụ việc (hiển thị trên thẻ vụ việc tab Tiếp nhận) | S-GD1 bước 2; [Ảnh H4, H17] | Functional | Thấp | Vừa | Thấp | P3 |
| TC-15 | Danh sách khu vực đúng nguồn dữ liệu và trạng thái chọn mặc định khi vào bước (expected chờ O5) | [Ảnh H4, H17] | Functional | Thấp | Vừa | Thấp | P3 |
| TC-16 | Chọn một loại vụ việc từ danh sách và giá trị được lưu đúng (loại vụ việc quyết định việc phải lập biên bản ở flow 05) | S-GD1 bước 3; S mục "Tạo và ký văn bản" (ví dụ vật phẩm nguy hiểm); [Ảnh H5, H17] | Functional | Thấp | Cao | Vừa | P2 |
| TC-17 | Tuỳ chọn "Khác (tự nhập loại vụ việc)": nhập và lưu loại vụ việc tự do (quy tắc chờ O6) | [Ảnh H5] | Functional | Vừa | Vừa | Vừa | P2 |
| TC-18 | Chọn một trong 3 mức độ (Bình thường / Nghiêm trọng / Khẩn cấp) và mức độ được lưu đúng, hiển thị đúng trên thẻ vụ việc và lọc được theo mức độ ở tab Tiếp nhận | S-GD1 bước 4; [Ảnh H6, H17] | Functional | Thấp | Cao | Vừa | P2 |
| TC-19 | Chọn "Khẩn cấp" kích hoạt "Cảnh báo Lãnh đạo + BCH đội" | [Ảnh H6] — không có trong text | Functional | Chưa xác định | Chưa xác định | **Chưa xếp hạng — chờ B6** | — |

### 2.E Bước 5 — Mô tả

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-20 | Trường "Mô tả" bắt buộc: không thể đi tiếp / không thể tạo vụ việc khi Mô tả rỗng | L3a(b); S-GD1 bước 5; [Ảnh H7] | Functional | Vừa | Cao | Cao | P1 |
| TC-21 | Mô tả chỉ chứa khoảng trắng, độ dài tối đa, tiếng Việt có dấu / ký tự đặc biệt được lưu đúng (quy tắc chờ O3) | L3a(b) | Functional | Vừa | Vừa | Vừa | P2 |
| TC-22 | "Vị trí cụ thể (tuỳ chọn)" và "Hành động đã thực hiện (tuỳ chọn)" để trống vẫn đi tiếp được; khi nhập thì được lưu đúng | [Ảnh H7] — nhãn "(tuỳ chọn)" có trên ảnh | Functional | Thấp | Thấp | Thấp | P3 |
| TC-23 | Nhập bằng giọng nói qua nút micro ở các ô bước 5 (kèm quyền Micro) | [Ảnh H7] — không có trong text | Functional | Chưa xác định | Chưa xác định | **Chưa xếp hạng — chờ B6** | — |

### 2.F Bước 6 — Thông tin đối tượng

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-24 | 6.1 Quét CCCD bằng camera: các trường Họ tên, Ngày sinh, Giới tính, Quốc tịch, Số CCCD/CMND được tự điền **đúng** với giấy tờ | S-GD1 bước 6.1; [Ảnh H9, H10] | Functional (functional correctness) | Cao | Cao | Cao | P1 |
| TC-25 | 6.1 Quét các loại giấy tờ khác (hộ chiếu, CMND cũ…) — loại nào được hỗ trợ, trường nào được điền (chờ O7) | S-GD1 bước 6.1 "giấy tờ"; [Ảnh H8 "CCCD/hộ chiếu"] | Functional | Cao | Cao | Cao | P1 |
| TC-26 | 6.1/6.2 Quét không thành công (ảnh mờ, thiếu sáng, không phải giấy tờ, giấy tờ hết hạn): hành vi của app (expected chờ O7) | S-GD1 bước 6.1, 6.2 | Functional / Reliability | Cao | Vừa | Cao | P1 |
| TC-27 | 6.2 Chọn ảnh giấy tờ từ thư viện: thông tin được tự điền đúng vào các trường | S-GD1 bước 6.2 (không có ảnh minh hoạ) | Functional | Cao | Cao | Cao | P1 |
| TC-28 | Sửa được (hoặc không) các trường đã tự điền sau khi quét; giá trị sau sửa là giá trị được lưu (chờ O7) | [Ảnh H10 — trường hiển thị dạng ô nhập] | Functional | Vừa | Cao | Cao | P1 |
| TC-29 | 6.3 "Thêm đối tượng thủ công": nhập đủ các trường của một đối tượng và dữ liệu được lưu đúng | S-GD1 bước 6.3; [Ảnh H11] | Functional | Vừa | Cao | Cao | P1 |
| TC-30 | Quy tắc hợp lệ của trường đối tượng: trường bắt buộc, định dạng Ngày sinh, Số CCCD/CMND, Số hộ chiếu, ràng buộc Quốc tịch ↔ loại giấy tờ (quy tắc chờ O8) | S-GD1 bước 6.3; [Ảnh H10, H11] | Functional | Vừa | Cao | Cao | P1 |
| TC-31 | Nhiều đối tượng trong một vụ việc: thêm nhiều đối tượng (kết hợp 6.1/6.2/6.3), đánh số "Đối tượng N", đếm "Đã nhập N đối tượng", xoá một đối tượng | S-GD1 bước 6 ("từng đối tượng" trong ghi chú ảnh); [Ảnh H10, H11] | Functional | Vừa | Vừa | Vừa | P2 |
| TC-32 | Quan hệ giữa "Số lượng đối tượng" khai báo và số đối tượng thực nhập (chờ O9) | [Ảnh H8] | Functional | Vừa | Thấp | Thấp | P3 |
| TC-33 | "Biển số xe" + "Tra biển số" và "Đơn vị liên quan" | [Ảnh H8, H11] — không có trong text | Functional | Chưa xác định | Chưa xác định | **Chưa xếp hạng — chờ B6** | — |
| TC-34 | Bảo vệ dữ liệu cá nhân của đối tượng: ảnh giấy tờ tuỳ thân có/không được lưu (trên thiết bị, trên server), ai được xem dữ liệu đối tượng | [Ảnh H8 "(lưu dạng văn bản)"]; bản chất dữ liệu CCCD/hộ chiếu | Non-functional (Security — confidentiality) | Chưa xác định | Cao | **Chưa xếp hạng — chờ B7** | — |

### 2.G Bước 7 — Đề xuất xử lý

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-35 | Chọn 0, 1 hoặc nhiều phương án đề xuất xử lý và tập lựa chọn được lưu đúng (bắt buộc hay không — chờ B2) | S-GD1 bước 7; [Ảnh H12] | Functional | Thấp | Vừa | Thấp | P3 |
| TC-36 | Phương án "Khác": có/không kèm nội dung nhập và nội dung được lưu (chờ O12) | [Ảnh H12] | Functional | Thấp | Vừa | Thấp | P3 |

### 2.H Bước 8 — Chọn cán bộ (Giao việc)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-37 | Chọn 1 cán bộ: cán bộ hiện thành thẻ đã chọn, được loại khỏi danh sách gợi ý, và là người được giao của vụ việc sau khi gửi | S-GD1 bước 8 "1 hoặc nhiều người"; [Ảnh H13, H14] | Functional | Vừa | Cao | Cao | P1 |
| TC-38 | Chọn nhiều cán bộ: tất cả cán bộ đã chọn đều được giao vụ việc sau khi gửi | S-GD1 bước 8; [Ảnh H17 — thẻ có "+2 cán bộ"] | Functional | Vừa | Cao | Cao | P1 |
| TC-39 | Bỏ chọn cán bộ (nút "x" trên thẻ đã chọn): cán bộ trở lại danh sách; khi không còn cán bộ nào thì không đi tiếp được | [Ảnh H13, H14] | Functional | Vừa | Vừa | Vừa | P2 |
| TC-40 | Tìm cán bộ "Tìm theo email…" trả về đúng kết quả (cách khớp chờ O13) | [Ảnh H13] | Functional | Vừa | Vừa | Vừa | P2 |
| TC-41 | "Đội nhận việc" và phạm vi danh sách cán bộ được phép giao (theo Đội, toàn đơn vị, tự giao cho mình, vai trò lãnh đạo nhận việc) | [Ảnh H13, H15 ghi chú "tới Đội tiếp nhận"] | Functional + Security | Chưa xác định | Cao | **Chưa xếp hạng — chờ B3** | — |

### 2.I Bước 9 — Hạn hoàn thành, xem lại & gửi

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-42 | Chọn ngày ("Chọn ngày") và giờ ("Chọn giờ") đến hạn; giá trị đã chọn hiển thị trên nút và được lưu là hạn hoàn thành của vụ việc | S-GD1 bước 9; [Ảnh H15, H16] | Functional | Vừa | Cao | Cao | P1 |
| TC-43 | Ràng buộc hạn hoàn thành: hạn ở quá khứ / bằng hiện tại, giới hạn xa nhất, múi giờ "giờ Việt Nam" khi thiết bị khác múi giờ (expected chờ O1) — hạn sai làm sai trạng thái "Quá hạn" ở Trang chủ | S-GD1 bước 9; [Ảnh H2 thẻ "Quá hạn", H15] | Functional | Vừa | Cao | Cao | P1 |
| TC-44 | Màn "Xem lại & gửi" hiển thị đúng dữ liệu đã nhập ở các bước trước (phạm vi các mục hiển thị chờ O14) | [Ảnh H15, H16] | Functional | Vừa | Vừa | Vừa | P2 |
| TC-45 | Bấm "Giao việc & gửi" tạo **đúng một** vụ việc mới, có mã vụ việc, chứa đầy đủ và đúng dữ liệu của 9 bước | S-GD1 "Click button Giao việc và gửi → Tạo thành công 1 vụ việc"; [Ảnh H16, H17] | Functional | Vừa | Cao | Cao | P1 |
| TC-46 | Vụ việc vừa tạo xuất hiện ở tab "Tiếp nhận" của đúng (các) tài khoản, với đúng trạng thái ban đầu | S-GD1 "→ Kết quả … ở tab Tiếp nhận"; [Ảnh H17] | Functional | Chưa xác định | Cao | **Chưa xếp hạng — chờ B4** | — |
| TC-47 | Khi tạo vụ việc: ghi log, gửi thông báo tới (các) cán bộ được giao / người giao việc / "cấp trên" | S-TN1 "→ Kết quả"; S mục "Giao diện" 2 ("chọn từ tab Thông báo") | Functional | Chưa xác định | Cao | **Chưa xếp hạng — chờ B4** | — |
| TC-48 | Gửi khi mất mạng / lỗi server, và bấm "Giao việc & gửi" nhiều lần liên tiếp — không mất dữ liệu đã nhập, không tạo trùng vụ việc (expected chờ O16) | S-GD1 "Click button Giao việc và gửi" | Non-functional (Reliability — fault tolerance) | Vừa | Cao | Cao | P1 |
| TC-49 | Hành động "Xử lý tại chỗ và hoàn thành" (tồn tại hay không, điều kiện biểu mẫu/chữ ký theo cấu hình loại vụ việc) | [Ảnh H15, H16 — chỉ có trong ghi chú] | Functional | Chưa xác định | Chưa xác định | **Chưa xếp hạng — chờ B5** | — |

### Tổng hợp

| Ưu tiên | Số test condition | Danh sách |
|---|---|---|
| P1 | 16 | TC-01, 11, 20, 24, 25, 26, 27, 28, 29, 30, 37, 38, 42, 43, 45, 48 |
| P2 | 14 | TC-05, 06, 09, 10, 12, 13, 16, 17, 18, 21, 31, 39, 40, 44 |
| P3 | 8 | TC-04, 08, 14, 15, 22, 32, 35, 36 |
| Chưa xếp hạng (chờ câu hỏi chặn) | 11 | TC-02, 03, 07, 19, 23, 33, 34, 41, 46, 47, 49 |
| **Tổng** | **49** | |

Lưu ý: toàn bộ risk level ở trên dựa trên giả định A1/A2 — nếu user điều chỉnh căn cứ likelihood/impact (O18), xếp hạng có thể đổi. Một số test condition P1 (TC-25, 26, 28, 30, 43, 48) đã xác định được **cái cần test**, nhưng expected result còn chờ câu hỏi mở tương ứng.

---

## 3. Traceability nháp

| Test condition | Mục test basis | Ghi chú cho test-plan (gợi ý nhóm test object — test-plan chốt lại) |
|---|---|---|
| TC-01, 02, 03 | S "Bao gồm 2 phân quyền"; L2b | Nhóm **AUTH** (quyền tạo vụ việc). TC-02/03 chờ B1 |
| TC-04, 05, 06, 07 | S-GD1 "9 bước"; L3a(b) | Nhóm **NAV** (điều hướng wizard). TC-07 chờ B2 |
| TC-08 – 13 | S-GD1 bước 1 | Nhóm **EVD** (bằng chứng). TC-13 dùng chung cho bước 6 |
| TC-14 – 19 | S-GD1 bước 2, 3, 4 | Nhóm **CLS** (phân loại: khu vực/loại/mức độ). TC-19 chờ B6. TC-16 ảnh hưởng chéo flow `05_record-signing` |
| TC-20 – 23 | S-GD1 bước 5; L3a(b) | Nhóm **DSC** (mô tả). TC-23 chờ B6 |
| TC-24 – 34 | S-GD1 bước 6, 6.1, 6.2, 6.3 | Nhóm **SUBJ** (đối tượng). TC-33 chờ B6, TC-34 chờ B7. Dữ liệu đối tượng tái sử dụng ở biên bản (flow 05) — ảnh hưởng chéo |
| TC-35, 36 | S-GD1 bước 7 | Nhóm **PROP** (đề xuất xử lý) |
| TC-37 – 41 | S-GD1 bước 8 | Nhóm **ASG** (giao cán bộ). TC-41 chờ B3. Người được giao là đầu vào của flow `04_case-handling` và `07_case-actions` (Phân công lại/tiếp) |
| TC-42 – 49 | S-GD1 bước 9 + "→ Kết quả"; S-TN1 "→ Kết quả" | Nhóm **SUB** (hạn, xem lại, gửi, kết quả). TC-46/47 chờ B4, TC-49 chờ B5. Hạn hoàn thành ảnh hưởng chéo flow `07_case-actions` (Gia hạn) và thống kê Trang chủ (flow `02_home`) |
| — | S-TN1 "Lưu kết quả vào trang quản trị" | **GAP — không kiểm được**: flow `09_web-admin` chưa có mô tả/screenshot. Không tạo test condition |

---

## 4. Câu hỏi cần làm rõ trước khi lập test plan

### 4.1 Câu hỏi chặn (thuộc mục 0 của skill — phải trả lời trước khi chạy test-plan)

| # | Câu hỏi | Lý do dừng (mục 0) | Test condition bị ảnh hưởng |
|---|---|---|---|
| **B1** | (a) Tài khoản **Cán bộ** có được tạo vụ việc không? Nếu không, app chặn bằng cách nào (ẩn nút "+", vô hiệu hoá, báo lỗi khi mở/gửi)? (b) Câu trả lời L2b "chỉ Tổ phó đã được uỷ quyền" có áp dụng cho **Tạo vụ việc** không, và Tổ phó chưa uỷ quyền bị chặn thế nào? (c) Uỷ quyền cho Tổ phó được cấp/thu hồi ở đâu, có hiệu lực ngay không? | Mơ hồ, 2 cách hiểu → 2 tập test condition khác nhau (T1, T2) | TC-01, 02, 03 |
| **B2** | Bước nào **bắt buộc**? Text chỉ ghi bước 1 "không bắt buộc" (ngụ ý các bước còn lại bắt buộc), nhưng ảnh cho thấy bước 7 "Tuỳ chọn" và bước 6 cho đi tiếp khi chưa có đối tượng. Cụ thể từng bước 2, 3, 4, 6, 7, 8, 9: bắt buộc hay tuỳ chọn? Bước 2 có giá trị chọn sẵn mặc định không? | Mâu thuẫn text ↔ ảnh (T3) | TC-07, 15, 31, 35 (và điều kiện đi tiếp của mọi bước) |
| **B3** | Vụ việc được giao cho **Đội** hay cho **cán bộ** (ghi chú bước 9: "'Gửi' sẽ chuyển vụ việc tới Đội tiếp nhận")? Chọn được bao nhiêu Đội? Danh sách cán bộ giới hạn trong Đội của người tạo hay toàn đơn vị? Người tạo có tự giao cho mình được không? Người có vai trò lãnh đạo (vd Tổ phó) có được chọn làm người nhận không? | Mơ hồ, 2 cách hiểu (T4); thiếu căn cứ risk likelihood cho phạm vi giao việc | TC-37, 38, 39, 41 |
| **B4** | Sau "Giao việc & gửi": (a) vụ việc hiện ở tab Tiếp nhận của **ai** (người tạo / cán bộ được giao / cả Đội)? (b) **trạng thái ban đầu** là gì ("Chờ tiếp nhận" hay "Đang thực hiện" như thẻ ở Hình 17)? (c) có ghi log và gửi thông báo **ngay khi tạo** không, tới ai; "cấp trên" là vai trò nào? | Mơ hồ / mâu thuẫn tiềm ẩn ảnh ↔ text (T5, T6) | TC-45, 46, 47 |
| **B5** | Hành động "**Xử lý tại chỗ và hoàn thành**" (ghi chú ở Hình 15/16) có tồn tại trong flow Tạo vụ việc không? Nếu có: hiện khi nào, điều kiện "biểu mẫu, chữ ký nếu loại vụ việc có cấu hình" là gì, có thuộc đợt test này không? | Mâu thuẫn ảnh ↔ text, ảnh hưởng phạm vi (T7) | TC-49 (và có thể phát sinh thêm test condition) |
| **B6** | Các phần **chỉ có trong ảnh** có thuộc test basis không, expected result là gì và mức ảnh hưởng nghiệp vụ khi lỗi: (a) "Khẩn cấp — Cảnh báo Lãnh đạo + BCH đội" (gửi tới ai, kênh nào); (b) "Biển số xe" + "Tra biển số" (tra ở nguồn nào), "Đơn vị liên quan"; (c) nhập giọng nói (micro) ở bước 5? | Thiếu căn cứ risk likelihood và impact (T8) | TC-19, 23, 33 |
| **B7** | "(lưu dạng văn bản)" ở bước 6 nghĩa là ảnh giấy tờ tuỳ thân **không được lưu** (trên thiết bị và server) hay ảnh vẫn được lưu kèm vụ việc? Ai được xem dữ liệu cá nhân của đối tượng (người tạo, cán bộ được giao, cả Đội, cấp trên)? Có yêu cầu bảo vệ dữ liệu cá nhân cụ thể nào phải kiểm không? | Mơ hồ 2 cách hiểu + thiếu căn cứ risk likelihood (T9) | TC-34 (và TC-24, 27 nếu ảnh được lưu) |

### 4.2 Câu hỏi mở (không chặn — ảnh hưởng expected result / chi tiết, trả lời được song song với test-plan sau khi B1–B7 xong)

| # | Câu hỏi | Test condition bị ảnh hưởng |
|---|---|---|
| O1 | Hạn hoàn thành: cho phép quá khứ / bằng hiện tại không? Khoảng tối thiểu/tối đa? Lưu theo giờ Việt Nam khi thiết bị đặt múi giờ khác thì hiển thị thế nào? | TC-42, 43 |
| O2 | Bằng chứng: số lượng tối đa, dung lượng, định dạng (có video không), xoá được không? | TC-11, 12 |
| O3 | Mô tả: chuỗi chỉ có khoảng trắng có hợp lệ không? Độ dài tối đa? Có thông báo lỗi hay chỉ vô hiệu hoá nút? | TC-20, 21 |
| O4 | "Quay lại" có giữ dữ liệu không? Thoát wizard giữa chừng có cảnh báo / lưu nháp không? | TC-05, 06 |
| O5 | Nguồn danh sách khu vực (cố định / cấu hình quản trị / theo nhà ga hay Đội)? Mục đầu tiên có được chọn sẵn không? | TC-14, 15 |
| O6 | Nguồn danh sách loại vụ việc? Quy tắc nhập "Khác (tự nhập loại vụ việc)" (bắt buộc nội dung, độ dài)? | TC-16, 17 |
| O7 | Loại giấy tờ được hỗ trợ khi quét/chọn ảnh (CCCD gắn chip, CMND cũ, hộ chiếu, giấy tờ nước ngoài)? Hành vi khi quét không được? Có cho sửa trường đã tự điền không? | TC-24, 25, 26, 27, 28 |
| O8 | Trường bắt buộc của một đối tượng; định dạng Ngày sinh; độ dài Số CCCD/CMND, Số hộ chiếu; ràng buộc Quốc tịch ↔ loại giấy tờ; nguồn danh sách Quốc tịch? | TC-29, 30 |
| O9 | "Số lượng đối tượng" có phải khớp với số đối tượng đã nhập không? | TC-32 |
| O10 | (gộp vào B6 — giữ số để tham chiếu) | — |
| O11 | (gộp vào B6 — giữ số để tham chiếu) | — |
| O12 | Bước 7 chọn "Khác" có kèm ô nhập nội dung không? | TC-36 |
| O13 | "Tìm theo email": khớp một phần, không phân biệt hoa/thường? Hiển thị gì khi không có kết quả? | TC-40 |
| O14 | Màn "Xem lại & gửi" chỉ tóm tắt Loại vụ việc / Mô tả / Bằng chứng / Giao việc / Hạn — có cần hiện khu vực, mức độ, đối tượng, đề xuất xử lý không? | TC-44 |
| O15 | Expected result dùng nhãn nào khi spec và app khác nhau (bước 8 "Chọn cán bộ" ↔ "Giao việc"; bước 9 "Chọn thời gian đến hạn" ↔ "Xem lại & gửi"; "Giao việc và gửi" ↔ "Giao việc & gửi")? Nhãn/danh sách trên ảnh build 1.0.0 (52) có được coi là requirement không (A3)? | TC-04, 44, 45 |
| O16 | Hành vi khi gửi lỗi mạng/server; chống tạo trùng khi bấm nhiều lần; quy tắc sinh mã vụ việc (dạng "VV" + 6 số)? | TC-45, 48 |
| O17 | Hành vi khi từ chối quyền Camera / Ảnh (thông báo, đường dẫn tới Cài đặt)? | TC-13 |
| O18 | User có chấp nhận căn cứ risk ở giả định A1 (likelihood ước lượng theo độ phức tạp kỹ thuật) và A2 (impact suy từ mục đích hệ thống) không, hay có thông tin business impact/ưu tiên nghiệp vụ để thay thế? | Toàn bộ cột risk mục 2 |
| O19 | (Project) Model iPhone / phiên bản iOS / build mục tiêu? Bộ giấy tờ mẫu (dữ liệu giả) để test quét CCCD/hộ chiếu lấy ở đâu? | TC-24 – 27; môi trường test |
