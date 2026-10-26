# Screenshot index — iphone

> **Thiết bị:** iPhone — ❓ model và phiên bản iOS chưa ghi nhận (ảnh 925×1999 px)
> **Build:** 1.0.0 (52) · 19/10/2026 (đọc từ chân màn đăng nhập)
> **Nguồn:** ảnh minh hoạ trong [mo-ta-chuc-nang-v1.md](../../../specs/xu-ly-vi-pham-giao-viec/mo-ta-chuc-nang-v1.md), chụp 20/10/2026.
> Tên gốc `hinh-NN` = file `requirements/specs/xu-ly-vi-pham-giao-viec/images/hinh-NN.png`.
>
> ⚠️ **Dữ liệu cá nhân:** ảnh có 🔒 chứa họ tên / số giấy tờ / ngày sinh / ảnh chân dung / email tài khoản.
> File `.png` bị `.gitignore` chặn. Không chép các giá trị đó vào wireframe, checklist hay bug.

| Tên file | Tên gốc | Mô tả |
|---|---|---|
| `01_login/01_login_01_login-form_default.png` | hinh-01 | Màn Đăng nhập "Tài khoản cán bộ": Email, Mật khẩu, nút Đăng nhập; chân trang ghi phiên bản 🔒 |
| `02_home/02_home_01_statistics_default.png` | hinh-02 | Trang chủ của Đội trưởng: lối vào Giao việc, bộ lọc thời gian, 6 ô thống kê, biểu đồ Xu hướng, nút "+" Tạo vụ việc (ảnh có mũi tên chú thích màu đỏ) 🔒 |
| `03_case-create/03_case-create_01_evidence_empty.png` | hinh-03 | Bước 1/9 Hình ảnh / bằng chứng — chưa có ảnh, nút Chụp ảnh / Thư viện |
| `03_case-create/03_case-create_02_area_selected.png` | hinh-04 | Bước 2/9 Khu vực phát sinh — 8 khu vực, mục đầu đang được chọn |
| `03_case-create/03_case-create_03_case-type_default.png` | hinh-05 | Bước 3/9 Loại vụ việc — 3 loại + "Khác (tự nhập loại vụ việc)", Tiếp tục mờ |
| `03_case-create/03_case-create_04_severity_default.png` | hinh-06 | Bước 4/9 Mức độ — Bình thường / Nghiêm trọng / Khẩn cấp, Tiếp tục mờ |
| `03_case-create/03_case-create_05_description_default.png` | hinh-07 | Bước 5/9 Mô tả — 3 ô có nút micro, Tiếp tục mờ |
| `03_case-create/03_case-create_06_subject-info_default.png` | hinh-08 | Bước 6/9 Thông tin đối tượng — chưa có đối tượng, Tiếp tục bật |
| `03_case-create/03_case-create_06_subject-info_filled.png` | hinh-10 | Bước 6/9 sau khi quét giấy tờ — "Đã nhập 1 đối tượng", trường đã tự điền 🔒 |
| `03_case-create/03_case-create_06_subject-info_filled-v2.png` | hinh-11 | Bước 6/9 nhập thủ công — đối tượng quốc tịch nước ngoài, có Biển số xe / Đơn vị liên quan 🔒 |
| `03_case-create/03_case-create_07_document-scan_default.png` | hinh-09 | Camera quét giấy tờ (giao diện chụp ảnh "PHOTO", có thể là camera của iOS) 🔒 |
| `03_case-create/03_case-create_08_proposal_default.png` | hinh-12 | Bước 7/9 Đề xuất xử lý — "Tuỳ chọn", 5 checkbox, Tiếp tục bật |
| `03_case-create/03_case-create_09_assignee_default.png` | hinh-13 | Bước 8/9 Giao việc — Đội nhận việc đã chọn, chưa chọn cán bộ, Tiếp tục mờ 🔒 |
| `03_case-create/03_case-create_09_assignee_selected.png` | hinh-14 | Bước 8/9 — đã chọn 1 cán bộ (thẻ có nút ✕), Tiếp tục bật 🔒 |
| `03_case-create/03_case-create_10_review_default.png` | hinh-15 | Bước 9/9 Xem lại & gửi — chưa chọn hạn, "Giao việc & gửi" mờ 🔒 |
| `03_case-create/03_case-create_10_review_filled.png` | hinh-16 | Bước 9/9 — đã chọn ngày + giờ, "Giao việc & gửi" bật 🔒 |
| `04_case-handling/04_case-handling_01_case-list_default.png` | hinh-17 | Tab Tiếp nhận — ô tìm kiếm, lọc trạng thái + mức độ, danh sách thẻ vụ việc, nút Hoàn thành |

**Ghi chú đặt tên:** `screen-no` của flow 03 không trùng số bước trên app — bước 6 có thêm màn camera
(`07_document-scan`), nên bước 7/8/9 trên app = `08_proposal` / `09_assignee` / `10_review`.

## Possible missing screen

Flow `03_case-create` (chi tiết ở [wireframe 03](../../wideframes/03_case-create.md#possible-missing-screen)):

- Bước 1 sau khi đã thêm ảnh (danh sách ảnh, xoá ảnh) · màn Chụp ảnh / Thư viện của bước 1
- Bước 2–5 ở trạng thái đã chọn / đã nhập (`selected`, `filled`) — chỉ có trạng thái ban đầu
- Bước 3 khi chọn "Khác (tự nhập loại vụ việc)"
- Bước 4 khi chọn "Khẩn cấp"
- Bước 5 khi đã nhập Mô tả (nút Tiếp tục có bật không)
- Bước 6.2 chọn ảnh giấy tờ từ thư viện; quét lỗi / ảnh mờ; dialog quyền Camera / Ảnh (`system-dialog`)
- Bước 6 nhiều đối tượng cùng lúc; form "Thêm đối tượng thủ công" lúc vừa mở (trống)
- Bước 7 khi chọn "Khác"
- Bước 8 khi tìm email không có kết quả; khi chọn nhiều cán bộ
- Bước 9 date picker / time picker; trạng thái sau khi bấm "Giao việc & gửi" (loading, success, error)
- Thoát wizard giữa chừng (dialog xác nhận?)
- Mọi màn khi đăng nhập bằng tài khoản Cán bộ (nút "+" có hiện không)

Flow `01_login`, `02_home`, `04_case-handling`: mới có 1 ảnh mỗi flow — chưa liệt kê thiếu, vì chưa phân tích các flow này.
