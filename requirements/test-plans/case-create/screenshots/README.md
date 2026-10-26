# Ảnh bằng chứng — Tạo vụ việc xử lý vi phạm (XL01, `03_case-create`)

Ảnh chụp màn hình thật khi thực thi từng case trong [test-cases-dac-ta-v2.1.md](../test-cases-dac-ta-v2.1.md), dùng để
đối chiếu với cột "Kết quả mong đợi" — **không phải** bộ ảnh giao diện/wireframe ở `requirements/ui/ux/screenshots/`
(bộ đó theo [screenshot-naming.md](../../../../.claude/rules/screenshot-naming.md), mục đích khác). Chưa có ảnh nào
được chụp; việc chụp là của người thực thi.

## Quy ước đặt tên

**Thư mục con = mã nhóm case:** `AUTH`, `NAV`, `EVD`, `CLS`, `DSC`, `SUBJ`, `PROP`, `ASG`, `SUB`, `POST`
(chỉ tạo thư mục khi có ảnh đầu tiên).

**Tên file = ID case đầy đủ + hậu tố mô tả màn hình/trạng thái**, viết thường phần hậu tố, nối bằng `-`:

```
screenshots/AUTH/TC-AUTH-08-home-no-plus.png
screenshots/EVD/TC-EVD-09-over-50mb-error.png
screenshots/CLS/TC-CLS-21-urgent-push-tc.png
screenshots/SUBJ/TC-SUBJ-04-scan-result.png
screenshots/SUB/TC-SUB-12-deadline-past-at-send.png
```

- Case cần nhiều ảnh (trước/sau, nhiều thiết bị): thêm hậu tố rõ nghĩa (`-before`, `-after`, `-m2`). Không dùng
  `copy`, `(1)`, `2`.
- Case 🔭 (charter EXP-1…EXP-8) vẫn chụp/quay bình thường — làm bằng chứng cho **biên bản phiên** (mẫu bên dưới).
- Case bị chặn hoặc chưa chạy → không tạo file rỗng.

## Dữ liệu cá nhân

- Chỉ chụp giấy tờ **mẫu giả** và dữ liệu đối tượng giả (`TEST …`). Tuyệt đối không chụp giấy tờ thật.
- Che email, họ tên, số giấy tờ thật của tài khoản/thiết bị nếu xuất hiện (thông báo, thanh trạng thái) trừ khi cần
  để kiểm kết quả.

## Mẫu biên bản phiên khám phá (EXP-1…EXP-8)

| Charter | Ngày | Người chạy | Model iPhone / iOS / build | Thời lượng | Hành vi quan sát được (mô tả, kèm tên ảnh/video) | Điểm lạ/nghi lỗi | Câu hỏi mới |
|---|---|---|---|---|---|---|---|

Biên bản phiên **không** ghi "đạt/không đạt". Mọi điểm "Còn mở" (⚠️) ghi vào cùng bảng này kèm mã QO.

## Log kết quả

> Ghi lại mỗi khi thêm ảnh.

| File | Case tương ứng | Ngày chụp | Kết quả | Ghi chú |
|---|---|---|---|---|
