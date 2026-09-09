# Bug Log — Ink Calendar iOS

> Một file duy nhất cho toàn bộ bug của mọi flow, sort theo ngày phát hiện (mới nhất ở dưới).
> `Flow` / `Screen` dùng đúng tên trong [`.claude/rules/screenshot-naming.md`](../.claude/rules/screenshot-naming.md).

**Severity:** `Critical` chặn luồng chính / mất dữ liệu không khôi phục được · `High` mất dữ liệu hoặc sai chức năng chính · `Medium` sai hành vi phụ, có workaround · `Low` UI / cosmetic.
**Status:** `Open` · `Confirmed` · `Fixed` · `Won't fix` · `Need info`.

---

## Tổng hợp

| ID | Date | Flow | Screen | State | Severity | Summary | Status |
|---|---|---|---|---|---|---|---|
| BUG-001 | 2026-08-14 | 04_discover | create-note | editing | High | Nút ✓ đóng màn edit nhưng note không được lưu | Open |
| BUG-002 | 2026-08-14 | 04_discover | collection | default | Medium | Lockscreen dạng Note hiển thị tên `(Untitled)` trong Your collection | Open |

---

## BUG-001 · Nút ✓ đóng màn edit nhưng note không được lưu

| Field | Value |
|---|---|
| **Date** | 2026-08-14 |
| **Flow** | `04_discover` — note widget cho lock screen |
| **Screen** | `create-note` (lock screen style dạng Note) |
| **State** | `editing` |
| **Severity** | High — mất toàn bộ nội dung user vừa nhập |
| **Status** | Open |
| **Device / Build** | ❓ chưa ghi nhận — cần bổ sung |

### Steps to reproduce

1. Mở tab **Discover**.
2. Vào section **Lockscreen** —> Chọn **Note** category
3. Chọn một note template dạng giấy (paper / receipt style) → mở màn **Create new note**.
4. Nhập **Title** và thêm vài checklist item (`item 1`, `item 2`), con trỏ đang ở item thứ 3 còn trống.
5. Tap nút **✓** (nền đen, tròn) ở góc phải trên cùng.

### Expected

Note được lưu và một trong hai điều sau xảy ra:
- Quay về màn trước với note vừa tạo hiển thị trong list / collection, **hoặc**
- Hiện confirm (`applied` / `success`) rồi mới đóng.

### Actual

Màn edit đóng ngay lập tức, **không có gì xảy ra** — không toast, không confirm, note không xuất hiện ở đâu cả. Nội dung vừa nhập mất trắng, không phân biệt được với hành vi của nút `‹` (Back / huỷ).

### Evidence

Screenshot user cung cấp trong session 2026-08-14 (state `editing`, keyboard đang mở, mũi tên đỏ chỉ vào nút ✓).

> ⚠️ **Ảnh chưa được lưu vào repo.** Cần export và đặt vào [`requirements/ui/ux/screenshots/iphone/04_discover/`](../requirements/ui/ux/screenshots/iphone/04_discover/) theo rule naming — đề xuất `04_discover_09_create-note_editing.png` — rồi cập nhật `index.md`.

### Notes

- Wireframe [`07_note.md:139`](../requirements/ui/ux/wideframes/07_note.md#L139) đã ghi nhận điểm nghi ngờ ở đúng nút này: *"Nút ✓ enabled ngay cả khi note trống… Cần xác nhận app có chặn lưu note rỗng không."* Bug này xác nhận nút ✓ **không** hoạt động đúng ở trường hợp có nội dung.
- Màn hình trong screenshot **khác** `07_note_02_create-note_*.png` (bản wireframe là editor trắng trơn; bản này là template giấy có checklist + washi tape + barcode) → đây là **màn hình chưa có trong bộ screenshot**, thuộc nhánh note-widget của Flow 04, không phải Notes tab.
- Wireframe [`04_discover.md`](../requirements/ui/ux/wideframes/04_discover.md) đã liệt kê *"Màn hình Note trong Your collection (filter có nhưng chưa có item)"* ở mục **Possible missing screen** — rất có thể cùng gốc với bug này: note không lưu được nên collection luôn rỗng.

### Cần xác minh thêm

- [ ] Nút ✓ có lưu được không khi **chỉ nhập Title**, không có checklist item?
- [ ] Item checklist cuối cùng đang **trống** có phải nguyên nhân chặn save không?
- [ ] Note có xuất hiện ở tab **Notes** (Flow 07) hay ở **Your collection** filter `Note` không — hay mất hoàn toàn?
- [ ] Kill app rồi mở lại — note có được persist ngầm không?
- [ ] Nút `‹` (Back) hành vi khác gì nút ✓? Nếu giống hệt → xác nhận ✓ chưa được implement.

> 📌 **Làm rõ (2026-08-14):** note **chỉ** vào được `Your collection` khi user chọn **Set as wallpaper** ở bước sau. Nút ✓ vẫn không lưu gì → đường duy nhất để giữ note là phải áp nó lên wallpaper. Không có cách nào chỉ lưu nháp.

---

## BUG-002 · Lockscreen dạng Note hiển thị tên `(Untitled)` trong Your collection

| Field | Value |
|---|---|
| **Date** | 2026-08-14 |
| **Flow** | `04_discover` |
| **Screen** | `collection` — section *Your collection* trên Discover home |
| **State** | `default` |
| **Severity** | Medium — không mất dữ liệu, nhưng nhiều note sẽ trùng tên hoàn toàn, không phân biệt được |
| **Status** | Open |
| **Device / Build** | ❓ chưa ghi nhận — cần bổ sung |

### Steps to reproduce

1. Mở tab **Discover** → section **Lockscreen** → chọn category **Note**.
2. Chọn một note template dạng giấy, nhập nội dung (ví dụ checklist item `cdc`).
3. Chọn **Set as wallpaper** để lưu design vào collection.
4. Quay về **Discover** → xem section **Your collection**.

### Expected

Card note hiển thị một tên có ý nghĩa — do user tự đặt, hoặc fallback lấy từ nội dung note (ví dụ `cdc`), tương tự các item lockscreen khác đều có tên thật (`Week Timetable + Today`, `Progress…`).

### Actual

Card hiển thị đúng nội dung note ở thumbnail, nhưng label bên dưới là **`(Untitled)`**. Toàn bộ luồng tạo note không có bước nào cho phép đặt tên cho design → mọi note đã lưu đều sẽ mang cùng một label `(Untitled)`.

### Evidence

Screenshot user cung cấp trong session 2026-08-14 — Discover home, `Your collection (5)`, card giữa gắn badge `Note`, mũi tên đỏ chỉ vào label `(Untitled)`.

> ⚠️ **Ảnh chưa được lưu vào repo.** Đề xuất lưu thành `04_discover_02_collection_section-focused-v3.png` trong [`screenshots/iphone/04_discover/`](../requirements/ui/ux/screenshots/iphone/04_discover/) rồi cập nhật `index.md`.

### Notes

- Card `Note` có CTA là **`Edit`**, khác với card lockscreen (`Update` khi đang active, `Set as …` khi chưa) → note-type item được đối xử khác trong collection.
- Screenshot BUG-001 cho thấy editor note **có** ô `Title` (đang ở dạng placeholder xám). Cần xác định `Title` đó là **tiêu đề hiển thị trên wallpaper** hay **tên của design trong collection** — nếu chỉ là cái đầu thì đúng là toàn bộ luồng không có chỗ đặt tên, khớp mô tả của user.
- Wireframe [`04_discover.md`](../requirements/ui/ux/wideframes/04_discover.md) ghi nhận *"filter có mục `Note` → dự kiến lưu cả note widget vào collection, nhưng chưa có ảnh minh hoạ item loại Note"*. Screenshot này **là** ảnh còn thiếu đó — nên cập nhật wireframe cùng lúc.

### Cần xác minh thêm

- [ ] Nhập `Title` trong editor note → card trong collection có đổi tên theo không, hay vẫn `(Untitled)`?
- [ ] Lưu 2+ note khác nhau → cả hai đều là `(Untitled)`? Có phân biệt được không?
- [ ] Tap `Edit` trên card → có màn đặt/đổi tên không?
- [ ] Vào `Your collection ›` (màn full list, filter `Note`) → tên hiển thị ở đó có khác không?
- [ ] Các loại khác do user tạo (lockscreen tự chỉnh, live activity) có bị `(Untitled)` tương tự không, hay chỉ riêng Note?
