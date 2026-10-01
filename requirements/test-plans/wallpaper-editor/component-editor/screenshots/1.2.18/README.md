# Screenshot evidence — Component Editor 1.2.18 (111, rc3)

Ảnh/video khi thực thi từng case trong [test-cases-1.2.18.md](../../test-cases-1.2.18.md). **Chưa có ảnh thật** — việc chụp là của người thực thi.
Không phải bộ ảnh UX/wireframe, **không** theo [`screenshot-naming.md`](../../../../../../.claude/rules/screenshot-naming.md).
Bộ 1.2.17 nằm ở [`../`](../README.md) (giữ nguyên, ID dạng `DRG-01`); bộ này tách thư mục `1.2.18/` để không lẫn ID.

## Quy ước đặt tên

**Thư mục con = mã nhóm:** `ENT`, `DEV`, `LOC`, `SEL`, `ROD`, `DRG`, `SNP`, `RSZ`, `ADD`, `NST`, `PRP`, `PUX`, `KNB`, `UND`, `CHR`, `REG`, `INT`, `EXP`, và `BASELINE` (ảnh oracle Q-19).
**Tên file = ID case + hậu tố mô tả:**

```
screenshots/1.2.18/DRG/TC-DRG-04_before.png        <- trước khi kéo quá vạch dưới grid
screenshots/1.2.18/DRG/TC-DRG-16_release.mov       <- video nhả tay (soi từng frame)
screenshots/1.2.18/REG/TC-REG-08_night-before.png  <- ảnh trước khi khoá máy
screenshots/1.2.18/REG/TC-REG-08_morning.png       <- ảnh sáng hôm sau (bắt buộc đủ 2 ảnh)
```

- Nhiều ảnh cho 1 case → hậu tố rõ nghĩa, không dùng `copy` / `(1)` / `2`. Ghi **model máy + iOS** trong log bên dưới.
- Lỗi lúc kéo: **quay video** (test basis §13).
- Case ⚠️ (theo giả định) và 🔭 (quan sát): **vẫn chụp/quay đầy đủ** — làm bằng chứng cho "Query → dev", không phải PASS/FAIL.
- `TC-REG-09` (card frosted): ảnh editor + ảnh wallpaper đã lưu (+ lock screen thật) — chỉ ghi nhận cho tới khi Q-18 được chốt.
- Case Blocked / Not run (vd `TC-DEV-03` không có iPad) → không tạo file rỗng.
- Che dữ liệu cá nhân (tên event/task thật) trước khi lưu nếu không cần để verify.

## `BASELINE/` — entry criterion E2 (Q-19)

Chụp **trên build 111, có hiện số build**: sheet Add (16 mục / 5 nhóm, 2 đoạn cuộn) · pill ↑/↓ · chip gap âm · đường gióng snap · grabber + ✕ · trạng thái nút **+** sau grabber (TB-19) · bộ 4 màu mặc định Priority matrix. Bộ ảnh S03 lứa 1.2.17 **không** dùng làm oracle.

## Log kết quả

| File | Case | Ngày chụp | Máy / iOS | Kết quả | Ghi chú |
|---|---|---|---|---|---|
