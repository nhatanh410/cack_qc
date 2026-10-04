# Screenshot evidence — Chia sẻ template bằng link (Ink Prod 1.2.19) · slug `1-2-19`

Ảnh chụp màn hình thật khi thực thi từng test case trong
[test-cases-1-2-19.md](../test-cases-1-2-19.md), dùng để đối chiếu với cột "Kết quả mong đợi" đã viết sẵn
— **không phải** bộ ảnh UX/wireframe, **không** theo rule
[`screenshot-naming.md`](../../../../.claude/rules/screenshot-naming.md) (rule đó dành cho
`requirements/ui/ux/screenshots/`, mục đích dựng wireframe/flow; khác mục đích ở đây). Đây cũng là
**baseline ảnh lần đầu** cho feature này (TB-12/O-9 — chưa có baseline trước khi chạy đợt `1-2-19`), dùng
làm đối chiếu cho các đợt chạy lại sau.

## Quy ước đặt tên

**Thư mục con = mã nhóm case** (khớp đúng phần `TC-<MÃ>` ở từng mục của `test-cases-1-2-19.md`): `STA`,
`STB`, `STC`, `STD`, `STE`, `STF`, `STG`, `STH`, `STI`, `STJ`, `STK`, `STM`. Không có thư mục `STL` (nhóm
trang web `/t/<id>` đã hoãn khỏi slug này, xem mục 3 test plan).

**Tên file = ID case + hậu tố mô tả màn hình/state:**

```
screenshots/STA/STA-04-note-no-share.png
screenshots/STC/STC-03-use-ink-backgrounds-machine-b.png
screenshots/STD/STD-01-same-id-first-share.png
screenshots/STD/STD-01-same-id-second-share.png
screenshots/STH/STH-06-lock-screen-real.png
screenshots/STJ/STJ-01-template-unavailable.png
```

- Case cần nhiều ảnh (trước/sau, máy A/máy B, nhiều lần chạy...) → thêm hậu tố rõ nghĩa, vd
  `STD-01-machine-a-copy-link.png` / `STD-01-machine-b-open.png`. Không dùng `copy`/`(1)`/`2`.
- Case 🔭 (exploratory) vẫn chụp bình thường — dùng làm bằng chứng cho phần "Phải quan sát/ghi lại" của
  case đó, không phải pass/fail.
- Case bị descope vì thiếu phương tiện (không có proxy/mock, không có script hạn mức, iPad, Arabic chưa
  ship...) → **không tạo file**, chỉ ghi vào bảng log dưới đây là "không thực thi được — thiếu phương
  tiện", kèm lý do.
- Ảnh chứa dữ liệu cá nhân thật (tên event thật, số điện thoại...) → che trước khi lưu nếu không cần thiết
  cho việc verify kết quả. Ảnh `curl`/proxy (payload JSON) có thể lưu dạng `.txt`/`.json` thay vì `.png`
  trong cùng thư mục con, vẫn theo quy ước tên file.
- `STH-06` (lock screen thật sau khi Set as current qua Shortcut) → chụp **cả 2 máy nếu có thể**, đối
  chiếu với preview trong app như test case yêu cầu.

## Log kết quả

> Ghi lại đây mỗi khi thêm ảnh — không bắt buộc sửa lại bảng case chính trong `test-cases-1-2-19.md`, bảng
> dưới đây là nơi track thực thi thật, bao gồm cả case descope (không có ảnh nhưng vẫn cần dòng log).

| File / Case | TC tương ứng | Ngày chụp | Kết quả | Ghi chú |
|---|---|---|---|---|
