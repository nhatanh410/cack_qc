# Screenshot evidence — bản V2-updated (Home Screen iOS 26/27, Automation & Trigger iOS 27)

Ảnh chụp màn hình thật khi thực thi từng test case trong
[test-cases-ios26-27-v2-updated.md](../../test-cases-ios26-27-v2-updated.md), dùng để đối chiếu với cột "Kết quả
mong đợi" đã viết sẵn.

**Tách riêng khỏi [`screenshots/`](../README.md) (phẳng, dùng cho bản V2 cũ)** để tránh trùng ID case giữa 2 bản
— ví dụ `HS-02` ở bản V2-updated không phải cùng 1 case với `HS-02` ở bản V2 cũ.

## Quy ước đặt tên

**Thư mục con = mã nhóm case** (khớp đúng tiêu đề mục trong test-cases-ios26-27-v2-updated.md): `INS`, `OLD`,
`TOAST`, `HS`, `OWN`, `WARN`, `AUTO`, `TRIG`, `DBG`. **Tên file = ID case + hậu tố mô tả màn hình/state:**

```
v2-updated/HS/HS-02-lock.png       ← Lock Screen của case HS-02 (Same+Blur tắt, xác nhận gap #1)
v2-updated/HS/HS-02-home.png       ← Home Screen của case HS-02
v2-updated/HS/HS-02b-before.png    ← Trước khi tắt Blur (case HS-02b)
v2-updated/HS/HS-02b-after.png     ← Sau khi tắt Blur, Update 1 lần
v2-updated/AUTO/AUTO-19-lock.png
v2-updated/AUTO/AUTO-19-home.png
```

- `PAIR` và nghĩa cũ của `TRIG` (Decision Table 4 — yêu cầu đổi tên) **không có thư mục riêng ở đây** — 2 nhóm
  đó dẫn chiếu thẳng case của bản V2 cũ (xem mục 10 test-cases-ios26-27-v2-updated.md), lưu ảnh vào
  [`screenshots/PAIR/`](../PAIR/) và [`screenshots/TRIG/`](../TRIG/) (thư mục phẳng gốc) như bình thường.
- Case cần nhiều ảnh (trước/sau, cả Lock lẫn Home) → thêm hậu tố rõ nghĩa, không dùng `copy`/`(1)`/`2`.
- Case 🔭 (exploratory) vẫn chụp bình thường — dùng làm bằng chứng điền vào bảng thăm dò mục 11 của
  [V2-updated](../../../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2-updated.md#11-bảng-ghi-kết-quả-thăm-dò)
  hoặc mục 8 của [triggers-ios27.md](../../../../specs/shortcuts/qc-shortcut-triggers-ios27.md#8-bảng-ghi-kết-quả).
- Case Blocked hoặc chưa chạy → không tạo file rỗng, chỉ để trống thư mục con.
- Ảnh chứa dữ liệu cá nhân thật → che trước khi lưu, nếu không cần thiết cho việc verify kết quả.

## Log kết quả

> Ghi lại đây mỗi khi thêm ảnh — không bắt buộc sửa lại bảng case chính trong
> `test-cases-ios26-27-v2-updated.md`, bảng dưới đây là nơi track thực thi thật.

| File | TC tương ứng | Ngày chụp | Kết quả | Ghi chú |
|---|---|---|---|---|
