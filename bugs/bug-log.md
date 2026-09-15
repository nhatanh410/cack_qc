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
| BUG-003 | 2026-09-15 | 08_paywall | plan-list | default | Medium | `discount: 1` là giá trị invalid (`discount` phải nhỏ hơn 1) nhưng pill "SAVE 100%" vẫn hiện — thiếu 1 nhánh validate | Open |

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

---

## BUG-003 · `discount: 1` là giá trị invalid nhưng pill "SAVE 100%" vẫn hiện

| Field | Value |
|---|---|
| **Date** | 2026-09-15 |
| **Flow** | `08_paywall` |
| **Screen** | `plan-list` — danh sách gói trong paywall (screen-name mới, chưa có trong `.claude/rules/screenshot-naming.md` §7.1 — đề xuất bổ sung khi hợp nhất bộ ảnh UX) |
| **State** | `default` |
| **Severity** | Medium — không mất dữ liệu, không chặn luồng mua hàng, nhưng sai hành vi validate + có rủi ro giật giá nếu Remote Config bị cấu hình nhầm (xem mục Rủi ro) |
| **Status** | Open |
| **Device / Build** | ❓ chưa ghi nhận — cần bổ sung (test trên `dev`, xem `paywall-remote-config-payloads/screenshots/README.md` — TC-PLAN-12) |

### Steps to reproduce

1. Publish payload [`10-discount-boundary/04-discount-1-invalid.json`](../requirements/test-plans/paywall-remote-config-payloads/10-discount-boundary/04-discount-1-invalid.json) (gói **Lifetime** có `discount: 1`) vào Firebase Remote Config parameter `pro_paywall_config_v1` → **Publish changes**.
2. Kill app hoàn toàn → mở lại (trên `dev`, `minimumFetchInterval = 0` nên lấy giá trị mới ngay).
3. Mở paywall, quan sát hàng gói **Lifetime**.

### Expected

`discount` phải **nhỏ hơn 1** để hợp lệ — theo spec [`paywall-config.md`](../requirements/specs/paywall-config.md) (mục `plans`): *"`discount` (0…1) drives the "-60%" pill and the struck-through price"*, và theo công thức giá gạch ngang `price / (1 - discount)` (chia cho 0 tại `discount = 1`, không tính được). `discount: 1` do đó là **giá trị invalid**, nằm ngoài khoảng `(0,1)` mở — decoder phải bỏ qua toàn bộ field `discount`: **không hiện pill, không hiện giá gạch ngang**, giống hệt cách xử lý `discount = 0` hoặc âm (đã verify đúng ở TC-PLAN-09/13).

### Actual

Pill **"SAVE 100%" vẫn hiện** dù `discount = 1` là giá trị invalid — chỉ riêng giá gạch ngang không hiện (do chia cho 0 → `Infinity`/`NaN`, bị ẩn ở bước render). Decoder đang thiếu nhánh validate `discount < 1` cho pill, chỉ áp dụng nó cho phần tính giá gạch ngang.

Evidence: [`screenshots/10-discount-boundary/04-discount-1-invalid.png`](../requirements/test-plans/paywall-remote-config-payloads/screenshots/10-discount-boundary/04-discount-1-invalid.png).

### Rủi ro / vì sao đáng quan tâm

`discount = 1` = giảm 100% = tặng miễn phí vĩnh viễn — không phải giá trị người vận hành RC có lý do chính đáng để set thật, nhiều khả năng chỉ xảy ra do **gõ nhầm** (nhập `1` thay vì `0.1`, hoặc nhầm đơn vị %). Vì decoder hiện tại **chấp nhận** giá trị invalid này ở nhánh pill, một lỗi cấu hình RC có thể vô tình hiện "SAVE 100%" cho toàn bộ user thật mà không có lưới an toàn nào chặn lại — khác với `discount = 0` hoặc âm, vốn đã bị ẩn hoàn toàn cả pill đúng như thiết kế.

### Đề xuất

Sửa decoder: validate `discount ∈ (0,1)` **một lần**, dùng chung cho cả pill và giá gạch ngang (thay vì chỉ áp dụng riêng cho giá gạch ngang như hiện tại) — `discount ≥ 1` hoặc `≤ 0` phải bị coi là invalid toàn bộ, ẩn cả 2 UI element, nhất quán với `discount = 0`/âm.

### Cần dev xác nhận

- [ ] Điều kiện hiện **pill** trong code thật hiện đang là gì — xác nhận đúng là thiếu check `< 1` như QC suy luận?
- [ ] Điều kiện hiện **giá gạch ngang** có phải chủ đích validate `discount < 1`, hay chỉ là kết quả `Infinity`/`NaN` bị discard tự nhiên (không có validate riêng)?
- [ ] Timeline fix dự kiến — có cần patch RC payload nào đang live để né tạm case này trước khi fix không?

### Notes

- Liên quan trực tiếp tới câu hỏi #5 (mục "`discount = 1` vẫn hiện pill...") đã gửi trong [`paywall-remote-config-questions-for-dev.md`](../requirements/test-plans/paywall-remote-config-questions-for-dev.md) — bug report này là bản mở rộng kèm khuyến nghị cụ thể, không thay thế câu hỏi đó.
- TC-PLAN-12 trong [`test-cases/paywall-remote-config.md`](../test-cases/paywall-remote-config.md) đã cập nhật lại expected result theo Actual quan sát được — không đánh dấu Fail, chỉ ghi nhận deviation.
