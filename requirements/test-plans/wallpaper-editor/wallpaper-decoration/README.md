# ⚠️ Phiên bản cũ — wallpaper-decoration (trước TF-117)

> Không dùng tài liệu trong folder này làm test basis cho đợt test mới. Chỉ dùng để tham khảo
> method, số liệu cũ, và trace lại lịch sử khi cần.

Tên cũ của folder này là `decoration-inkai/`. Chứa bộ test ISTQB cho màn **Decorate** — mở bằng chip
**Decorate** (vẽ tay, chữ, emoji, ảnh, tách nền) — spec **1.2.15**: `1.2.15-decoration-inkai.md`.

**Kể từ spec TF-117** (`component-editor-specs-dev-change(TF-117).md`), chip Decorate và nút
**Components** ([`../component-editor/`](../component-editor/)) được dev gộp thành 1 màn **Customize**
(công tắc **Layout | Decorate**). Nhiều hành vi ở đây (vẽ tay, sticker, ống hút màu, Layers của riêng
Decorate...) vẫn còn giá trị tham khảo cho chế độ **Decorate** của Customize, nhưng **không** copy nguyên
trạng: mục 8.1/8.2 của spec TF-117 đổi cách Undo/Redo dùng chung lịch sử với Layout, và Layers gộp cả 2
nhóm Layout + Decorate vào 1 sheet.

Bộ tài liệu **đang chạy** cho màn Customize (Layout + Decorate gộp) nằm ở
[`../wallpaper-customize/`](../wallpaper-customize/).
