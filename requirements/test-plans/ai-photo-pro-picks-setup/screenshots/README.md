# Screenshot evidence — Ink AI / Pro picks / Setup shortcut / Guide (PR #317)

Ảnh chụp màn hình thật khi thực thi từng test case trong
[test-cases-pr317.md](../test-cases-pr317.md), dùng để đối chiếu với cột "Kết quả mong đợi" đã viết sẵn —
**không phải** bộ ảnh UX/wireframe, **không** theo rule
[`screenshot-naming.md`](../../../../.claude/rules/screenshot-naming.md) (rule đó dành cho
`requirements/ui/ux/screenshots/`, mục đích dựng wireframe/flow từ ảnh thiết kế, khác mục đích ở đây).

## Quy ước đặt tên

**Thư mục con = mã nhóm case** (khớp đúng 6 nhóm test object của [test-plan-pr317.md](../test-plan-pr317.md)
mục 2): `AI`, `PRO`, `BG`, `SETUP`, `GUIDE`, `REG`. ID case dạng `TC-<MÃ>-NN` (vd `TC-AI-05`, `TC-PRO-09`).

**Tên file = ID case đầy đủ + hậu tố mô tả màn hình/state:**

```
screenshots/AI/TC-AI-05-network-error.png        ← lỗi mạng, trước khi bấm Retry
screenshots/AI/TC-AI-05-retry-done.png            ← sau Retry, chữ hiện lại không đọc ảnh
screenshots/PRO/TC-PRO-09-before.png              ← wallpaper ảnh riêng trước khi chọn thử ảnh Pro
screenshots/PRO/TC-PRO-09-after.png               ← sau Set without Pro, xác nhận rollback đúng ảnh gốc
screenshots/SETUP/TC-SETUP-11-mig-step1.png       ← điểm vào MIG, bước 1 (SETUP-10a)
screenshots/GUIDE/TC-GUIDE-01-todo.png            ← badge To do, state S1-S3 của MIG
```

- Case cần nhiều ảnh (before/after, nhiều bước, nhiều ngôn ngữ...) → thêm hậu tố rõ nghĩa, vd
  `TC-PRO-18-german.png` / `TC-PRO-18-russian.png`, `TC-AI-08-999.png` / `TC-AI-08-1000.png` /
  `TC-AI-08-1001.png`. Không dùng `copy`/`(1)`/`2`.
- Case ⚠️ (phụ thuộc gap mở) vẫn chụp bình thường — ảnh là bằng chứng ghi lại **hành vi thật quan sát được**,
  dùng để đối chiếu lại khi dev/PO trả lời gap tương ứng (mục 10/11 `test-plan-pr317.md`), không phải để tự kết
  luận pass/fail ngay.
- Case Blocked hoặc chưa chạy → không tạo file rỗng, chỉ để trống thư mục con.
- Ảnh chứa dữ liệu cá nhân thật (tên event, số điện thoại trong lịch demo...) → che trước khi lưu, nếu không
  cần thiết cho việc verify kết quả.
- Ảnh chụp màn hình **editor/Decorate trong app Ink** (không phải Lock/Home Screen thật) → vẫn lưu chung cách
  này nếu là bằng chứng cho 1 case cụ thể (vd `TC-PRO-16-decorate-rollback.png`).

## Log kết quả

> Ghi lại đây mỗi khi thêm ảnh — không bắt buộc sửa lại bảng case chính trong `test-cases-pr317.md`, bảng dưới
> đây là nơi track thực thi thật.

| File | TC tương ứng | Ngày chụp | Kết quả | Ghi chú |
|---|---|---|---|---|
