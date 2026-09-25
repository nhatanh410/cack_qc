# Screenshot evidence — Shortcut wallpaper Home Screen (iOS 26) / Automation (iOS 27)

Ảnh chụp màn hình thật khi thực thi từng test case trong [test-cases-ios26-27.md](../test-cases-ios26-27.md)
(bản V2 cũ) hoặc [test-cases-ios26-27-v3.md](../test-cases-ios26-27-v3.md) (bản hiện hành, sau merge PR #302),
dùng để đối chiếu với cột "Kết quả mong đợi" đã viết sẵn — **không phải** bộ ảnh UX/wireframe, **không** theo
rule [`screenshot-naming.md`](../../../../.claude/rules/screenshot-naming.md) (rule đó dành cho
`requirements/ui/ux/screenshots/`, mục đích dựng wireframe/flow từ ảnh thiết kế, khác mục đích ở đây).

## Quy ước đặt tên

**Thư mục con = tên nhóm case.** Hai bộ case dùng chung thư mục `screenshots/` này (feature `shortcuts` không
đổi), phân biệt bằng ID case (mỗi bộ có tiền tố ID riêng, không trùng nhau):

- **`test-cases-ios26-27.md`** (bản V2 cũ, trước PR #302): `INS`, `OLD`, `HS`, `OWN`, `PAIR`, `WARN`, `AUTO`,
  `XVER`, `TRIG`. ID dạng `<MÃ>-NN` (vd `HS-01`).
- **`test-cases-ios26-27-v3.md`** (bản sau merge PR #302, hiện hành): `INS`, `OLD`, `HS`, `OWN`, `PAIR`, `GATE`,
  `MIG`, `AUTO`, `XVER`, `DBG`, `HOW`, `ANA`. ID dạng `TC-SH-<MÃ>-NN` (vd `TC-SH-HS-01`). `GATE` thay thế hoàn
  toàn `WARN` (cảnh báo vàng đã bỏ); `MIG` là nhóm hoàn toàn mới (mục 13); `TRIG` của bản cũ đã gộp vào `AUTO`
  (không tạo thư mục `TRIG` riêng cho bộ v3); `DBG`/`HOW`/`ANA` là 3 nhóm mới không có ở bộ case cũ.

**Tên file = ID case + hậu tố mô tả màn hình/state** (ID đầy đủ kể cả tiền tố `TC-SH-` của bộ v3, để không lẫn
với ID cùng tên ở bộ cũ):

```
screenshots/HS/HS-01-lock.png                  ← bộ cũ, Lock Screen của case HS-01
screenshots/HS/TC-SH-HS-01-lock.png            ← bộ v3, Lock Screen của case TC-SH-HS-01
screenshots/PAIR/PAIR-01-lock.png              ← bộ cũ
screenshots/GATE/TC-SH-GATE-05-dont-change.png ← bộ v3, nhóm mới không có ở bộ cũ
screenshots/MIG/TC-SH-MIG-17-two-shortcuts.png ← bộ v3, nhóm hoàn toàn mới (mục 13)
screenshots/AUTO/TC-SH-AUTO-04-guide-order.png ← bộ v3, gồm cả phần trước đây thuộc thư mục TRIG
```

- Case cần nhiều ảnh (cả Lock lẫn Home, nhiều lần chạy, trước/sau...) → thêm hậu tố rõ nghĩa, vd
  `HS-09-home-darken-max.png`, `PAIR-03-before.png` / `PAIR-03-after.png`. Không dùng `copy`/`(1)`/`2`.
- Case 🔭 (exploratory, chưa có đáp án đúng/sai định sẵn) vẫn chụp bình thường — dùng làm bằng chứng điền vào
  bảng thăm dò tương ứng: [mục 11 spec chính](../../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2.md#11-bảng-ghi-kết-quả-thăm-dò)
  (nhóm `HS`/`MIG`/`XVER`/`AUTO` phần app), [mục 8 `triggers-ios27.md`](../../../specs/shortcuts/qc-shortcut-triggers-ios27.md#8-bảng-ghi-kết-quả)
  (nhóm `AUTO` phần trigger app khác), [mục 6 `notification-automation-ios27.md`](../../../specs/shortcuts/qc-notification-automation-ios27.md#6-bảng-trả-lời)
  (nhóm `AUTO` phần notification) — bộ case cũ chỉ dùng nguồn đầu tiên (V2).
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
