# Đề xuất: tự động đẩy bug từ repo QC sang repo source code

> Bản dành cho mentor review. Tên repo, tổ chức, tài khoản, sản phẩm và đường dẫn nội bộ đã được thay bằng mô tả chung.

## 1. Bối cảnh
- Đội có **2 repo riêng biệt, thuộc 2 chủ sở hữu khác nhau**:
  - **Repo QC**: chỉ chứa tài liệu kiểm thử (test plan, test case, bug log dạng Markdown). Không có source app.
  - **Repo source** (private): code của ứng dụng iOS, nơi dev theo dõi issue. Dùng *issue form* của GitHub với các field cố định (Title, Build, Bản cài, Thiết bị và iOS, Ngôn ngữ app, Các bước tái hiện).
- Quy trình hiện tại: một công cụ hỗ trợ (skill của Claude Code) soạn nội dung bug theo từng field -> QC **dán tay** vào web form -> tự cập nhật bug log.
- Điểm đau: thao tác lặp, dễ sai/lệch format, và trạng thái "đã sửa" bên dev không quay về bug log của QC.

## 2. Mục tiêu
1. Sau khi QC duyệt nội dung, **tạo issue trực tiếp** trên repo source bằng script.
2. Lưu URL/số issue vào bug log (traceability).
3. **Đồng bộ trạng thái** (open/closed) từ GitHub về bug log để QC theo dõi resolve.

## 3. Phân tích
- **Xác thực**: cần một danh tính có quyền tạo issue ở repo của chủ sở hữu khác.
- **Issue form chỉ là UI**: qua CLI/API chỉ gửi được `title`, `body`, `labels`, `assignees`. Cần dựng `body` markdown trùng cấu trúc form tự sinh (heading theo từng field) để dev/bot đọc nhất quán.
- **Hai chiều**: tạo issue (QC -> dev) và nhận trạng thái (dev -> QC).
- **Rủi ro**: tạo issue là hành động nhìn thấy được bởi bên khác; cần cổng xác nhận và chống tạo trùng.

## 4. Các phương án
| | Cách | Ưu | Nhược |
|---|---|---|---|
| A (chọn) | GitHub CLI (`gh`) đăng nhập tài khoản cá nhân của QC, bọc trong script | Đơn giản, không lưu token trong repo, tác giả issue là QC | Phụ thuộc máy đã đăng nhập; cần quyền Triage/Write |
| B | Fine-grained token (chỉ quyền Issues) trong biến môi trường, gọi REST API | Chạy được trên CI/máy khác, quyền hẹp | Phải tạo/xoay token, cần chủ repo chấp thuận |
| C | GitHub Action ở repo QC gọi sang repo source | Tự động hoàn toàn, có audit | Quá nặng cho quy mô 1 QC; vẫn cần token/App |
| D | Giữ dán tay | Không rủi ro | Chính là điểm đau |

**Chọn A**, thiết kế để nâng lên B mà không phải viết lại (script chỉ dựa vào `gh`/biến môi trường).

## 5. Thiết kế
**Script 1 – tạo issue**
- Đầu vào: một bug đã được QC duyệt trong bug log (hoặc file markdown).
- Dựng `body` theo cấu trúc issue form; gắn label mặc định.
- Mặc định `--dry-run` (chỉ in kết quả); tạo thật khi có `--submit`.
- Chống trùng: tìm issue theo mã bug nội bộ trước khi tạo.
- Sau khi tạo: ghi số + URL vào bug log. File đính kèm (ảnh/video) kéo thủ công vì CLI không upload được.

**Script 2 – đồng bộ trạng thái**
- Chạy thủ công khi cần. Đọc trạng thái các issue đã liên kết, cập nhật **chỉ cột Status** trong bug log, in diff trước khi ghi.

**Skill (hướng dẫn cho trợ lý AI)**
- Quy trình: soạn -> QC duyệt -> ghi bug log -> dry-run -> QC xác nhận -> `--submit` -> cập nhật URL.
- Bước đầu tiên khi triển khai: đọc template issue form thật của repo source để khớp field, label, option dropdown.

## 6. An toàn / kiểm soát
- Không commit token; cấu hình repo đích tách riêng khỏi code.
- Luôn dry-run trước; chỉ submit khi con người xác nhận rõ.
- Chỉ sửa cột Status khi đồng bộ, không động tới nội dung bug.
- Mỗi issue một lỗi; không tự đóng/sửa issue của dev.

## 7. Kiểm thử
- Kiểm tra quyền truy cập repo đích và đăng nhập `gh`.
- Dry-run với một bug mẫu, so body với form thật.
- Tạo 1 issue thử (đã được cho phép), kiểm tra bug log được ghi URL, sau đó đóng issue và chạy đồng bộ để xác nhận Status đổi đúng.
- Chạy `shellcheck` cho script.

## 8. Câu hỏi muốn xin ý kiến mentor
1. Với quy mô 1 QC, hướng A (gh cá nhân) có đủ, hay nên đầu tư GitHub App/bot ngay từ đầu?
2. Nên đồng bộ trạng thái thủ công, hay chuyển sang lịch tự động/webhook?
3. Có nên để QC tự gắn label/severity, hay để dev triage?
4. Cách tốt nhất để quản lý ảnh/video đính kèm khi tạo issue bằng CLI?
