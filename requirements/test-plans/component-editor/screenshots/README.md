# Screenshot evidence — Wallpaper Component Editor

Ảnh chụp màn hình thật khi thực thi từng test case trong [test-cases-component-editor.md](../test-cases-component-editor.md),
dùng để đối chiếu với cột "Kết quả mong đợi" đã viết sẵn — **không phải** bộ ảnh UX/wireframe, **không** theo
rule [`screenshot-naming.md`](../../../../.claude/rules/screenshot-naming.md) (rule đó dành cho
`requirements/ui/ux/screenshots/`, mục đích dựng wireframe/flow, khác mục đích ở đây).

## Quy ước đặt tên

**Thư mục con = mã nhóm case** (khớp đúng tiêu đề mục trong test-cases-component-editor.md): `ENT`, `DEV`,
`SEL`, `DRG`, `RSZ`, `ADD`, `NST`, `PRP`, `LOC`, `REG`, `INT`. **Tên file = ID case + hậu tố mô tả trạng thái:**

```
screenshots/DRG/DRG-01-before.png     ← trước khi kéo C
screenshots/DRG/DRG-01-after.png      ← sau khi nhả tay
screenshots/RSZ/RSZ-04-3-con.png      ← Row 3 con, đang kéo góc (case ⚠️ chờ câu hỏi #2)
screenshots/REG/REG-08-morning.png    ← wallpaper thật sáng hôm sau, sau automation
```

- Case cần nhiều ảnh (trước/sau, nhiều bước) → thêm hậu tố rõ nghĩa, không dùng `copy`/`(1)`/`2`.
- 4 case đánh ⚠️ (`RSZ-04`, `RSZ-08`, `ADD-03`, `NST-03`) **vẫn chụp bình thường** — ảnh dùng làm bằng chứng khi
  hỏi lại dev, không phải PASS/FAIL.
- `REG-08` (automation overnight) bắt buộc có **ảnh trước khi khoá máy** và **ảnh sáng hôm sau** để so sánh —
  không kết luận "sống sót" nếu chỉ có 1 ảnh.
- Case Blocked hoặc chưa chạy → không tạo file rỗng, chỉ để trống thư mục con.
- Ảnh chứa dữ liệu cá nhân thật (tên event, task...) → che trước khi lưu nếu không cần thiết để verify.

## Log kết quả

> Ghi lại đây mỗi khi thêm ảnh — không bắt buộc sửa lại bảng case chính trong `test-cases-component-editor.md`,
> bảng dưới đây là nơi track thực thi thật.

| File | TC tương ứng | Ngày chụp | Kết quả | Ghi chú |
|---|---|---|---|---|
