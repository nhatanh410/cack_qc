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
| BUG-004 | 2026-09-16 | 10_lockscreen | lock-screen | default | High | Event tạo trên Google Calendar không xuất hiện trên wallpaper hôm sau dù Google Calendar sync đang bật | Need info |
| BUG-005 | 2026-10-09 | 04_discover | collection | default | Low | Lockscreen and Live Activity tab titles are stuck together on Your collection, in both vi and en (vi tab title truncated to "Màn hình k...") | Need info |

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

1. Publish payload [`10-discount-boundary/04-discount-1-invalid.json`](../requirements/test-plans/paywall-remote-config/paywall-remote-config-payloads/10-discount-boundary/04-discount-1-invalid.json) (gói **Lifetime** có `discount: 1`) vào Firebase Remote Config parameter `pro_paywall_config_v1` → **Publish changes**.
2. Kill app hoàn toàn → mở lại (trên `dev`, `minimumFetchInterval = 0` nên lấy giá trị mới ngay).
3. Mở paywall, quan sát hàng gói **Lifetime**.

### Expected

`discount` phải **nhỏ hơn 1** để hợp lệ — theo spec [`paywall-config.md`](../requirements/specs/paywall-remote-config/paywall-config.md) (mục `plans`): *"`discount` (0…1) drives the "-60%" pill and the struck-through price"*, và theo công thức giá gạch ngang `price / (1 - discount)` (chia cho 0 tại `discount = 1`, không tính được). `discount: 1` do đó là **giá trị invalid**, nằm ngoài khoảng `(0,1)` mở — decoder phải bỏ qua toàn bộ field `discount`: **không hiện pill, không hiện giá gạch ngang**, giống hệt cách xử lý `discount = 0` hoặc âm (đã verify đúng ở TC-PLAN-09/13).

### Actual

Pill **"SAVE 100%" vẫn hiện** dù `discount = 1` là giá trị invalid — chỉ riêng giá gạch ngang không hiện (do chia cho 0 → `Infinity`/`NaN`, bị ẩn ở bước render). Decoder đang thiếu nhánh validate `discount < 1` cho pill, chỉ áp dụng nó cho phần tính giá gạch ngang.

Evidence: [`screenshots/10-discount-boundary/04-discount-1-invalid.png`](../requirements/test-plans/paywall-remote-config/paywall-remote-config-payloads/screenshots/10-discount-boundary/04-discount-1-invalid.png).

### Rủi ro / vì sao đáng quan tâm

`discount = 1` = giảm 100% = tặng miễn phí vĩnh viễn — không phải giá trị người vận hành RC có lý do chính đáng để set thật, nhiều khả năng chỉ xảy ra do **gõ nhầm** (nhập `1` thay vì `0.1`, hoặc nhầm đơn vị %). Vì decoder hiện tại **chấp nhận** giá trị invalid này ở nhánh pill, một lỗi cấu hình RC có thể vô tình hiện "SAVE 100%" cho toàn bộ user thật mà không có lưới an toàn nào chặn lại — khác với `discount = 0` hoặc âm, vốn đã bị ẩn hoàn toàn cả pill đúng như thiết kế.

### Đề xuất

Sửa decoder: validate `discount ∈ (0,1)` **một lần**, dùng chung cho cả pill và giá gạch ngang (thay vì chỉ áp dụng riêng cho giá gạch ngang như hiện tại) — `discount ≥ 1` hoặc `≤ 0` phải bị coi là invalid toàn bộ, ẩn cả 2 UI element, nhất quán với `discount = 0`/âm.

### Cần dev xác nhận

- [ ] Điều kiện hiện **pill** trong code thật hiện đang là gì — xác nhận đúng là thiếu check `< 1` như QC suy luận?
- [ ] Điều kiện hiện **giá gạch ngang** có phải chủ đích validate `discount < 1`, hay chỉ là kết quả `Infinity`/`NaN` bị discard tự nhiên (không có validate riêng)?
- [ ] Timeline fix dự kiến — có cần patch RC payload nào đang live để né tạm case này trước khi fix không?

### Notes

- Liên quan trực tiếp tới câu hỏi #5 (mục "`discount = 1` vẫn hiện pill...") đã gửi trong [`paywall-remote-config-questions-for-dev.md`](../requirements/test-plans/paywall-remote-config/paywall-remote-config-questions-for-dev.md) — bug report này là bản mở rộng kèm khuyến nghị cụ thể, không thay thế câu hỏi đó.
- TC-PLAN-12 trong [`test-cases/paywall-remote-config.md`](../test-cases/paywall-remote-config/paywall-remote-config.md) đã cập nhật lại expected result theo Actual quan sát được — không đánh dấu Fail, chỉ ghi nhận deviation.

---

## BUG-004 · Event tạo trên Google Calendar không xuất hiện trên wallpaper hôm sau

| Field | Value |
|---|---|
| **Date** | 2026-09-16 |
| **Flow** | `10_lockscreen` — triệu chứng quan sát ở đây, nhưng root cause khả năng nằm ở `09_settings` (Google Calendar sync) hoặc `03_shortcut-setup` (automation render) |
| **Screen** | `lock-screen` — wallpaper thật trên máy sau khi Ink render |
| **State** | `default` |
| **Severity** | High — mất dữ liệu event khỏi tính năng lõi (wallpaper hiển thị lịch), không có toast/cảnh báo nào cho user biết là đang thiếu dữ liệu — "hỏng im lặng" |
| **Status** | Need info — mới là báo cáo lời từ user, **chưa reproduce**, chưa có screenshot/log kèm theo |
| **Device / Build** | ❓ chưa ghi nhận — cần bổ sung |

### Steps to reproduce (theo lời user)

1. Bật Google Calendar sync trong Ink (`09_settings` → toggle *"Google Calendar — Sign in to sync..."*).
2. Tạo một event mới **trực tiếp trên Google Calendar** (app/web của Google, không qua Ink).
3. Đợi qua hôm sau (giả định automation "Time of Day" đã chạy ít nhất 1 lần).
4. Xem wallpaper (lock screen) đã render.

### Expected

Event vừa tạo trên Google Calendar xuất hiện trên wallpaper của ngày tương ứng, cùng với các event khác.

### Actual

Event không xuất hiện trên wallpaper, dù sync đang bật.

### Evidence

Chưa có — đây là báo cáo lời của user, chưa kèm screenshot của wallpaper thực tế hay của tab Calendar trong
Ink. Cần thu thập khi reproduce.

### Root cause hypotheses (đã đối chiếu với code thật)

> Cập nhật 2026-09-16: có tài liệu pipeline thật lấy trực tiếp từ code —
> [`references/pipeline.html`](../references/pipeline.html) ("Lịch tới màn khoá"). Toàn bộ phần dưới đã viết
> lại theo tài liệu này, thay cho phần suy đoán "2 tầng sync" ban đầu (sai — không có tầng sync tách rời).

Theo `pipeline.html`, **không có bước "sync" nào lưu bản sao Google Calendar cả** — mỗi lần render, app gọi
**trực tiếp Google Calendar API** (`calendar/v3`, `singleEvents=true`) ngay tại thời điểm vẽ wallpaper, không
qua cache/webhook. Hệ quả kiến trúc quan trọng: **fetch luôn trả về toàn bộ event trong khung thời gian được
hỏi (kể cả event vừa tạo) hoặc trả về rỗng** — không có cơ chế "chỉ lấy event mới" nên về nguyên tắc, không
event nào bị thiếu riêng lẻ nếu Google fetch thành công.

**Nhóm A — nếu TOÀN BỘ event Google hôm đó bị thiếu** (không riêng event mới), do render chạy trong App
Intent nền (Shortcuts automation, thường lúc máy khoá, không UI):

1. 🔴 **Refresh token đã bị thu hồi/hết hạn.** Phiên vẫn "khôi phục thành công" từ Keychain (SDK không chứng
   minh lại token còn sống), toggle vẫn hiện BẬT — nhưng fetch thật trả lỗi, bị quy tắc "mọi thất bại → `[]`"
   nuốt mất, không có tín hiệu gì cho user. Đúng khớp mục troubleshooting có sẵn trong `pipeline.html`:
   *"Toggle Google bật nhưng không có sự kiện nào → refresh token đã bị thu hồi... Đăng xuất rồi đăng nhập
   lại."*
2. 🔴 **Timeout 10 giây/nhà cung cấp.** Cả chuỗi khôi phục phiên → làm mới token → gọi calendar list → gọi
   events phải xong trong 10s, chạy trong tiến trình nền hạn chế tài nguyên. Quá hạn thì bị huỷ, bỏ mặc,
   render tiếp chỉ với lịch Apple. Lỗi dạng này **không ổn định theo ngày** (chập chờn theo mạng/tải máy).
3. 🟠 **Keychain không đọc được vì máy chưa mở khoá lần nào kể từ khi khởi động lại** (Keychain class
   `AfterFirstUnlockThisDeviceOnly`). Nếu máy reboot (update iOS, hết pin qua đêm...) đúng lúc automation chạy
   trước khi user mở khoá máy lần đầu, app coi như Google đang TẮT — tự hết sau khi mở khoá máy 1 lần.

**Nhóm B — wallpaper không thực sự được render/áp dụng lại sáng hôm đó** (không liên quan gì Google):

4. 🟡 **Shortcut trả file nhưng không set được wallpaper** — do tên shortcut và link chia sẻ iCloud lệch
   nhau. Nếu đúng nguyên nhân này, **toàn bộ** wallpaper là ảnh cũ (ngày cũ, event Apple cũng sai theo) chứ
   không riêng thiếu 1 event Google — kiểm ngày hiển thị trên wallpaper để loại trừ.

**Nhóm C — không khớp kiến trúc hiện tại, cần dev xác nhận riêng:**

5. Nếu xác nhận được **các event Google khác cùng ngày vẫn hiện đúng**, chỉ riêng event mới tạo bị thiếu, và
   ngày trên wallpaper đúng là hôm nay → **không khớp bất kỳ cơ chế nào trong pipeline hiện tại** (vì fetch
   luôn lấy full window, không có đường "chỉ lấy event mới" để mà lỗi riêng nó). Cần dev xác nhận trực tiếp —
   khả năng: event nằm trên 1 lịch Google chưa được bật trong danh sách lịch của Ink, edge case
   recurring/exception event, hoặc độ trễ lan truyền phía server Google — nằm ngoài phạm vi tài liệu pipeline.

### Notes

- Xem thêm cây chẩn đoán mới [§5.1 "Wallpaper hôm nay đổi đúng ngày nhưng thiếu event Google Calendar"](../references/shortcut-flow-cases.md#51--cây-chẩn-đoán-khi-wallpaper-hôm-nay-đổi-đúng-ngày-nhưng-thiếu-event-google-calendar) trong `shortcut-flow-cases.md` — case `N21`-`N25` map trực tiếp với các hypothesis ở trên.
- [`references/pipeline.html`](../references/pipeline.html) là nguồn thật lấy từ code (`WallpaperDataProvider`, `WallpaperRemoteEventSource`, `GenerateLatestWallpaperIntent`...) — ưu tiên đối chiếu tài liệu này trước khi suy đoán thêm về kiến trúc.
- [`references/permissions-matrix.md`](../references/permissions-matrix.md) §3 đã cảnh báo trước đúng case token revoked (hypothesis #1) như một risk item, trước khi có tài liệu pipeline xác nhận — nay đã có bằng chứng code khớp với cảnh báo đó.
- Pipeline xác nhận Google Calendar **đã được nối thật** vào renderer (không phải tích hợp dở dang) — loại bỏ hoàn toàn hypothesis "integration chưa từng hoạt động" trong bản phân tích trước đó.

### Cần xác minh thêm

- [ ] **Quan trọng nhất:** các event Google **khác** cùng ngày (tạo từ trước) có hiện đúng trên wallpaper
      không, hay **toàn bộ** event Google đều thiếu? → phân biệt Nhóm A (mất hết, lỗi đã biết) với Nhóm C
      (chỉ thiếu đúng 1 event, bất thường, cần dev xác nhận riêng).
- [ ] Ngày hiển thị trên wallpaper có đúng là **hôm nay** không, hay là ảnh render từ hôm trước? (loại trừ
      Nhóm B — wallpaper cũ do shortcut không set được, không liên quan Google).
- [ ] Trong Ink có màn nào hiển thị "lần cuối automation chạy" không (pipeline có ghi log
      `InkWallpaperRunLog`/`InkAutomationRunLog`) — xem automation có thực sự chạy sáng nay không.
- [ ] `Settings → Google Calendar` còn hiện **Connected** hay đòi đăng nhập lại?
- [ ] Mở **tab Calendar trong Ink** (app đang mở, không bị giới hạn 10s như lúc chạy nền) → event có hiện
      không? Có → loại trừ token revoked, nghiêng về timeout/keychain-reboot (đặc thù chạy nền). Không hiện
      dù app đang mở có mạng → gần như chắc chắn token bị revoke (hypothesis #1).
- [ ] Thử **đăng xuất rồi đăng nhập lại** Google Calendar trong Settings, sau đó chạy tay Shortcut → event có
      xuất hiện không? (test trực tiếp hypothesis #1).
- [ ] Máy có bị khởi động lại (update iOS, hết pin...) đêm trước khi phát hiện bug không? (test hypothesis #3).
- [ ] Thu thập screenshot: wallpaper thực tế + tab Calendar trong Ink + màn `Settings → Google Calendar`.

---

## BUG-005 · Lockscreen and Live Activity tab titles are stuck together on Your collection

| Field | Value |
|---|---|
| **Date** | 2026-10-09 |
| **Flow** | `04_discover` — *Your collection* screen ("Bộ sưu tập của bạn") |
| **Screen** | `collection` |
| **State** | `default` (Lockscreen tab selected) |
| **Severity** | Low — UI / cosmetic, no functional impact |
| **Status** | Need info |
| **Device / Build** | ❓ not recorded — needs confirmation (screenshots are from an iPhone with Dynamic Island; model, iOS and build unknown) |
| **App language** | Vietnamese and English (reproduces in both) |
| **GitHub issue** | ❓ not created yet |

**Issue title:** `[QC] [Your collection] Lockscreen and Live Activity tab titles are stuck together, in both Vietnamese and English`

### Steps to reproduce

1. Set the app language to Vietnamese.
2. ❓ Open "Bộ sưu tập của bạn" (Your collection) — entry point not recorded yet.
3. Select the "Màn hình k..." (Lockscreen) tab and look at the tab bar above the list.
4. Set the app language to English, open "Your collection" again, select the "Lockscreen" tab and look again.

### Expected

❓ No spec/design — needs PM/design confirmation. Suggestion: tabs have clear spacing and titles are not truncated.

### Actual

- Vietnamese: the selected "Màn hình k..." tab sits right against the "Live Activity" tab with almost no gap. The tab title is truncated to "Màn hình k...".
- English: the selected "Lockscreen" tab is also right against "Live Activity" — same stuck-together layout.

Frequency: ❓ not retested.

### Evidence

2 screenshots provided in the 2026-10-09 session: Vietnamese (15:31, "Bộ sưu tập của bạn", tab "Màn hình k...") and English (15:26, "Your collection", tab "Lockscreen").

> ⚠️ **Images are not saved in the repo yet.** Export and place them in [`requirements/ui/ux/screenshots/iphone/04_discover/`](../requirements/ui/ux/screenshots/iphone/04_discover/) following the naming rule, then update `index.md`.

### Notes

- "Title" is interpreted as the tab labels (per the screenshots), not the screen title — needs confirmation.
- "Stuck together" and "Vietnamese tab title truncated" are kept in one issue because both are on the same tab bar; split if dev finds they are two separate defects.
- Same screen as [BUG-002](#bug-002--lockscreen-dạng-note-hiển-thị-tên-untitled-trong-your-collection).

### To verify

- [ ] Build, install type, device model and iOS version.
- [ ] Entry point to the *Your collection* screen.
- [ ] Do the "All" and "Widget" tabs also stick together?
- [ ] Spec/design for tab spacing and handling of long tab titles.
