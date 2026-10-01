# ⚠️ Phiên bản cũ — component-editor (trước TF-117)

> Không dùng tài liệu trong folder này làm test basis cho đợt test mới. Chỉ dùng để tham khảo
> method (Decision Table, BVA...), số liệu cũ, và trace lại lịch sử khi cần.

Folder này chứa toàn bộ bộ test ISTQB (test-analysis / test-plan / test-cases) của màn **Component
Editor** — mở bằng nút **Components** trên header — qua 2 thế hệ:

- `*-component-editor-SUPERSEDED.md` — spec **1.2.17 (103)**.
- `*-1.2.18.md` (+ `answers-1.2.18.md`) — spec **1.2.18 (111, rc3)**, trạng thái cuối cùng:
  `READY` (có điều kiện, xem banner đầu file `test-analysis-1.2.18.md`).

**Kể từ spec TF-117** (`component-editor-specs-dev-change(TF-117).md`), màn Components và chip
**Decorate** ([`../wallpaper-decoration/`](../wallpaper-decoration/)) được dev gộp thành 1 màn
**Customize** (công tắc **Layout | Decorate**). Bộ 1.2.18 trong folder này là **bản cuối cùng trước khi
gộp** — nhiều test condition ở đây (chọn/xoá/kéo/resize/bảng thuộc tính...) vẫn còn giá trị tham khảo cho
chế độ **Layout** của Customize, nhưng **không** copy nguyên trạng: phải đối chiếu lại với spec TF-117 vì
đường vào, chrome (rail/header), Undo/Redo history và Layers đã đổi khác.

Bộ tài liệu **đang chạy** cho màn Customize (Layout + Decorate gộp) nằm ở
[`../wallpaper-customize/`](../wallpaper-customize/).
