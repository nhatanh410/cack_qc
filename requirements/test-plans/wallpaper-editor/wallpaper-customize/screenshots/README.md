# Screenshot evidence — Component lịch mới & knob mới (stack)

Ảnh chụp màn hình thật khi thực thi test case trong
[test-cases-stack-components.md](../test-cases-stack-components.md), dùng để đối chiếu với cột "Kết quả mong
đợi" đã viết sẵn — **không phải** bộ ảnh UX/wireframe, **không** theo rule
[`screenshot-naming.md`](../../../../.claude/rules/screenshot-naming.md) (rule đó dành cho
`requirements/ui/ux/screenshots/`, mục đích dựng wireframe/flow từ ảnh thiết kế — khác mục đích ở đây).

> ⚠️ Tại thời điểm viết file này, repo **chưa có baseline screenshot** nào cho nội dung đã render của 6
> component mới + `Month heatmap` (entry criterion E2 của test plan, O-23) — chỉ có 3 ảnh sheet Add ở
> [`ui/ux/screenshots/iphone/14_edit-wallpaper/`](../../../ui/ux/screenshots/iphone/14_edit-wallpaper/). Thư
> mục con dưới đây được tạo sẵn để nhận ảnh khi người thực thi chạy case thật — hiện đang **rỗng**.

## Quy ước đặt tên

**Thư mục con = mã nhóm case** (khớp đúng tiêu đề mục trong `test-cases-stack-components.md`):

```
screenshots/INV/   screenshots/AGD/   screenshots/TKT/   screenshots/WKT/
screenshots/DLP/   screenshots/TAG/   screenshots/MLS/   screenshots/KNW/
screenshots/EMJ/   screenshots/LBL/   screenshots/SHR/   screenshots/RGT/
screenshots/MIG/   screenshots/PRF/   screenshots/NST/   screenshots/EX/   ← 7 charter Exploratory
```

**Tên file = ID case + hậu tố mô tả màn hình/state**, ví dụ:

```
screenshots/INV/INV-10-month-heatmap-added.png
screenshots/WKT/WKT-08-reset-before.png
screenshots/WKT/WKT-08-reset-after.png
screenshots/MLS/MLS-08-m2-today-last.png
screenshots/SHR/SHR-01-recipient-ui.png
screenshots/EX/EX-6-untitled-day-before.png
screenshots/EX/EX-6-untitled-day-after.png
```

- Case cần nhiều ảnh (trước/sau, nhiều lần chạy, 2 máy gửi/nhận...) → thêm hậu tố rõ nghĩa
  (`-before`/`-after`, `-sender`/`-recipient`). Không dùng `copy`/`(1)`/`2`.
- **Nhóm SHR** (chia sẻ template, điều kiện 3 của test plan): chụp **trên máy người nhận**, chỉ chụp màn
  hình UI — không chụp log/network trace.
- Case 🔭 (charter Exploratory, EX-1…EX-7) vẫn chụp bình thường khi phát hiện điều gì đáng ghi — dùng làm
  bằng chứng gửi dev, không dùng để chấm pass/fail.
- Case Blocked hoặc chưa chạy → không tạo file rỗng, chỉ để trống thư mục con (`.gitkeep` nếu cần giữ thư
  mục rỗng trong git).
- Ảnh chứa dữ liệu cá nhân thật (tên event thật, số điện thoại trong lịch demo...) → che trước khi lưu nếu
  không cần thiết cho việc verify kết quả — đặc biệt lưu ý nhóm SHR vì bản chất case là kiểm tra dữ liệu cá
  nhân không bị lộ.

## Log kết quả

> Ghi lại đây mỗi khi thêm ảnh — không bắt buộc sửa lại bảng case chính trong
> `test-cases-stack-components.md`; bảng dưới đây là nơi track thực thi thật.

| File | TC tương ứng | Ngày chụp | Kết quả | Ghi chú |
|---|---|---|---|---|
