# Screenshot evidence — Shortcut wallpaper mới (Home Screen iOS 26 / Automation iOS 27)

Ảnh chụp màn hình thật khi thực thi từng test case trong [test-cases-ios26-27.md](../test-cases-ios26-27.md),
dùng để đối chiếu với cột "Kết quả mong đợi" đã viết sẵn — **không phải** bộ ảnh UX/wireframe, **không** theo
rule [`screenshot-naming.md`](../../../../.claude/rules/screenshot-naming.md) (rule đó dành cho
`requirements/ui/ux/screenshots/`, mục đích dựng wireframe/flow từ ảnh thiết kế, khác mục đích ở đây).

## Quy ước đặt tên

**Thư mục con = tên nhóm case** (khớp đúng tiêu đề mục trong test-cases-ios26-27.md): `INS`, `OLD`, `HS`,
`OWN`, `PAIR`, `WARN`, `AUTO`, `XVER`, `TRIG`. **Tên file = ID case + hậu tố mô tả màn hình/state:**

```
screenshots/HS/HS-01-lock.png     ← Lock Screen của case HS-01
screenshots/HS/HS-01-home.png     ← Home Screen của case HS-01
screenshots/PAIR/PAIR-01-lock.png
screenshots/AUTO/AUTO-04-lock.png
```

- Case cần nhiều ảnh (cả Lock lẫn Home, nhiều lần chạy, trước/sau...) → thêm hậu tố rõ nghĩa, vd
  `HS-09-home-darken-max.png`, `PAIR-03-before.png` / `PAIR-03-after.png`. Không dùng `copy`/`(1)`/`2`.
- Case 🔭 (exploratory, chưa có đáp án đúng/sai định sẵn) vẫn chụp bình thường — dùng làm bằng chứng điền vào
  bảng thăm dò mục 11 của [V2](../../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2.md#11-bảng-ghi-kết-quả-thăm-dò).
- Case Blocked hoặc chưa chạy → không tạo file rỗng, chỉ để trống thư mục con.
- Ảnh chứa dữ liệu cá nhân thật (tên event, số điện thoại trong lịch demo...) → che trước khi lưu, nếu không
  cần thiết cho việc verify kết quả.
- Ảnh chụp màn hình **editor trong app Ink** (không phải Lock/Home Screen thật) → vẫn lưu chung cách này nếu là
  bằng chứng cho 1 case cụ thể (vd `INS-10-switch-variable.png` cho case verify action Switch không trống).

## Log kết quả

> Ghi lại đây mỗi khi thêm ảnh — không bắt buộc sửa lại bảng case chính trong `test-cases-ios26-27.md`, bảng
> dưới đây là nơi track thực thi thật.

| File | TC tương ứng | Ngày chụp | Kết quả | Ghi chú |
|---|---|---|---|---|
