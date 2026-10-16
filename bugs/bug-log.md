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
| BUG-006 | 2026-10-12 | 04_discover | live-activity | editing | Low | Live Activity editor's Calendars tab has no option to choose Monday or Sunday as the first day of the week (user feedback) | Open |
| BUG-007 | 2026-10-12 | 04_discover | widget | editing | Low | Widget configuration's Calendars tab has no option to choose Monday or Sunday as the first day of the week (user feedback) | Open |
| BUG-008 | 2026-10-12 | 04_discover | lockscreen | editing | Low | Lockscreen editor's Calendars tab has the first-day-of-week option at the bottom, below the calendar list, so users can't find it (should be at the top) | Open |
| BUG-009 | 2026-10-12 | 04_discover | live-activity | default | Medium | On some devices (e.g. iPhone 15, iOS 18.5) Live Activity starts the week on Sunday while Calendar and Widget start on Monday | Open |
| BUG-010 | 2026-10-16 | 05_calendar | list-view | default | High | Nothing that happens in Google Calendar or Outlook (edit, delete, new event) reaches Ink: Calendar tab, Widget and wallpaper all keep the old data, even after killing the app and waiting; Ink → provider changes do sync | Open |

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
2. Set up a template as the wallpaper, so that the "Bộ sưu tập của bạn" (Your collection) section is shown.
3. Open the "Bộ sưu tập của bạn" (Your collection) screen.
4. Select the "Màn hình k..." (Lockscreen) tab and look at the tab bar above the list.
5. Set the app language to English, reopen "Your collection", select the "Lockscreen" tab and look again.

### Expected

The tabs have clear spacing between them and their titles are not truncated, on smaller-screen devices (non-Pro Max iPhones) as well. Check with both a short and a long app language.

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
- [x] Entry point to the *Your collection* screen — provided by the user 2026-10-11 (set up a template as wallpaper → the section appears).
- [ ] Do the "All" and "Widget" tabs also stick together?
- [x] Expected result — provided by the QC owner 2026-10-11 (no formal spec/design; still worth PM/design confirmation).
- [ ] Repro on a non-Pro Max iPhone and with another long language (device of the original screenshots is unknown).

---

## BUG-006 · Live Activity editor has no first-day-of-week option (Monday/Sunday) on the Calendars tab

| Field | Value |
|---|---|
| **Date** | 2026-10-12 |
| **Flow** | `04_discover` — Live Activity section, Live Activity editor |
| **Screen** | `live-activity` |
| **State** | `editing` (Calendars tab) |
| **Severity** | Low — missing feature requested by users, no data loss, main flow not blocked |
| **Status** | Open |
| **Device / Build** | iPhone 14 Pro Max, iOS 26 · 1.2.22 (147) · App Store |
| **App language** | ❓ not recorded |
| **Frequency** | Always |
| **GitHub issue** | https://github.com/sfunvn/lockscreen-calendar/issues/422 |

**Issue title:** `[QC] [Live Activity] Calendars tab has no first-day-of-week option (Monday/Sunday)`

### Steps to reproduce

1. Open the app and stay on the Discover tab.
2. Scroll down to the Live Activity section.
3. Tap a Live Activity item to open the Live Activity editor.
4. Tap the Calendars tab.
5. Look at the top of the tab: it only shows the list of calendars. There is no option to choose the first day of the week.

### Expected

At the top of the Calendars tab, above the list of calendars, there is an option to choose the first day of the week: Monday or Sunday.

### Actual

The Calendars tab shows only the list of calendars. There is no option to choose Monday or Sunday as the first day of the week, so users cannot change it. Users repeatedly request this in feedback.

### Evidence

No screenshot of the Calendars tab is saved in the repo. The existing editor screenshot [`04_discover_07_live-activity_editing.png`](../requirements/ui/ux/screenshots/iphone/04_discover/04_discover_07_live-activity_editing.png) is an older build that has no Calendars tab (only Display Time and Event Display).

> ⚠️ **Screenshot not saved in the repo yet.** Capture the Calendars tab and place it in [`requirements/ui/ux/screenshots/iphone/04_discover/`](../requirements/ui/ux/screenshots/iphone/04_discover/) following the naming rule, then update `index.md`.

### Notes

- This is a user-feedback item (feature request) logged to serve user needs, not a regression.
- Default value (Monday, Sunday, or follow iOS setting) is not specified — needs PM/design confirmation.
- Whether the option applies to the Live Activity only or app-wide is not decided here.

### To verify

- [x] Build, install type, device and iOS — provided by the QC owner 2026-10-12.
- [x] Frequency — provided by the QC owner (always).
- [ ] Feedback source (channel, count) — not provided.
- [ ] Default value and scope (Live Activity only vs app-wide) — PM/design.
- [ ] Screenshot of the Calendars tab.

---

## BUG-007 · Widget configuration has no first-day-of-week option (Monday/Sunday) on the Calendars tab

| Field | Value |
|---|---|
| **Date** | 2026-10-12 |
| **Flow** | `04_discover` — Widget section, widget configuration screen |
| **Screen** | `widget` |
| **State** | `editing` (Calendars tab) |
| **Severity** | Low — missing feature requested by users, no data loss, main flow not blocked |
| **Status** | Open |
| **Device / Build** | iPhone 14 Pro Max, iOS 26 · 1.2.22 (147) · App Store |
| **App language** | ❓ not recorded |
| **Frequency** | Always |
| **GitHub issue** | https://github.com/sfunvn/lockscreen-calendar/issues/423 |

**Issue title:** `[QC] [Widget] Calendars tab has no first-day-of-week option (Monday/Sunday)`

### Steps to reproduce

1. Open the app and stay on the Discover tab.
2. Scroll down to the Widget section.
3. Tap the Calendar widget item to open the widget configuration screen.
4. Tap the Calendars tab.
5. Look at the top of the tab: it only shows the list of calendars. There is no option to choose the first day of the week.

### Expected

At the top of the Calendars tab, above the list of calendars, there is an option to choose the first day of the week: Monday or Sunday.

### Actual

The Calendars tab shows only the list of calendars. There is no option to choose Monday or Sunday as the first day of the week, so users cannot change it. Users repeatedly request this in feedback.

### Evidence

Screenshot of the Calendar widget configuration screen, Calendars tab selected: [`04_discover_09_widget_editing.png`](../requirements/ui/ux/screenshots/iphone/04_discover/04_discover_09_widget_editing.png) (build 1.2.22 (147)). The preview shows the week starting on Monday (M T W T F S S).

### Notes

- This is a user-feedback item (feature request) logged to serve user needs, not a regression.
- Reproduced on the **Calendar** widget only (the one in the screenshot). Other widgets that have a Calendars tab (Agenda, Today Timeline, Up Next, Today's Schedule, Calendar & Matrix, Date & Matrix) were not checked.
- Same request as [BUG-006](#bug-006--live-activity-editor-has-no-first-day-of-week-option-mondaysunday-on-the-calendars-tab) but on a different screen; kept as a separate issue (one issue per bug).
- Default value (Monday, Sunday, or follow iOS setting) is not specified — needs PM/design confirmation.
- Whether the option applies to this widget only or app-wide is not decided here.

### To verify

- [x] Build, install type, device and iOS — provided by the QC owner 2026-10-12 (same as BUG-006).
- [x] Frequency — provided by the QC owner (always).
- [ ] Feedback source (channel, count) — not provided.
- [ ] Other widgets with a Calendars tab — same missing option?
- [ ] Default value and scope (this widget only vs app-wide) — PM/design.

---

## BUG-008 · First-day-of-week option is at the bottom of the Calendars tab in the Lockscreen editor and hard to find

| Field | Value |
|---|---|
| **Date** | 2026-10-12 |
| **Flow** | `04_discover` — Lockscreen section, Lockscreen editor (template editor, bottom panel under the canvas — TF-117) |
| **Screen** | `lockscreen` |
| **State** | `editing` (Calendars tab) |
| **Severity** | Low — the option works, only hard to discover (UI/UX), no data loss |
| **Status** | Open |
| **Device / Build** | iPhone 14 Pro Max, iOS 26 · 1.2.22 (147) · App Store |
| **App language** | ❓ not recorded |
| **Frequency** | Always |
| **GitHub issue** | https://github.com/sfunvn/lockscreen-calendar/issues/424 |

**Issue title:** `[QC] [Lockscreen] First-day-of-week option is buried at the bottom of Calendars tab`

### Steps to reproduce

1. Open the app and stay on the Discover tab.
2. Scroll to the Lockscreens section.
3. Tap a Lockscreen item to open the Lockscreen editor.
4. Tap the Calendars tab.
5. Look at the tab: the first-day-of-week option is not visible at the top. It is placed at the bottom, below the list of calendars, and users have to scroll past the whole list to find it.

### Expected

The first-day-of-week option is shown at the top of the Calendars tab, above the list of calendars, so users can find it easily.

### Actual

The first-day-of-week option exists, but it is placed at the bottom of the Calendars tab, below the list of calendars. Users have to scroll past the whole list to find it and often do not notice it.

### Evidence

No screenshot of this tab is saved in the repo yet. The spec [template-editor.md](../requirements/specs/wallpaper-editor/wallpaper-customize/template-editor.md) §2 (Calendar tab) lists the order as calendar list → divider → **First day of week**, which matches the reported layout.

> ⚠️ **Screenshot not saved in the repo yet.** Capture the Calendars tab of the Lockscreen editor scrolled to the option, place it in [`requirements/ui/ux/screenshots/iphone/04_discover/`](../requirements/ui/ux/screenshots/iphone/04_discover/) following the naming rule, then update `index.md`.

### Notes

- This is a UX improvement based on user feedback (users cannot find the option), not a regression.
- Related to [BUG-006](#bug-006--live-activity-editor-has-no-first-day-of-week-option-mondaysunday-on-the-calendars-tab) and [BUG-007](#bug-007--widget-configuration-has-no-first-day-of-week-option-mondaysunday-on-the-calendars-tab): those two screens have no option at all; this screen has it, at the bottom. Kept as a separate issue (one issue per bug). If dev moves the option to the top of all three, the placement should be the same.
- Option values were not recorded here; take them from the real screenshot.

### To verify

- [x] Build, install type, device and iOS — provided by the QC owner 2026-10-12 (same as BUG-006/007).
- [x] Frequency — provided by the QC owner (always).
- [x] Entry path and screen (template editor) — provided by the QC owner 2026-10-12.
- [ ] Screenshot of the Calendars tab scrolled to the option (also gives the option values).
- [ ] Exact tab label on this screen: "Calendars" per the QC owner; spec text says "Calendar".

---

## BUG-009 · Live Activity starts the week on Sunday while Calendar and Widget start on Monday

| Field | Value |
|---|---|
| **Date** | 2026-10-12 |
| **Flow** | `04_discover` — Live Activity section |
| **Screen** | `live-activity` |
| **State** | `default` (Live Activity showing a week) |
| **Severity** | Medium — week is shown inconsistently with the rest of the app, users can misread days |
| **Status** | Open |
| **Device / Build** | iPhone 15, iOS 18.5 · 1.2.22 (147) · App Store |
| **App language** | ❓ not recorded |
| **Frequency** | Always (on the affected device; not every device is affected) |
| **GitHub issue** | https://github.com/sfunvn/lockscreen-calendar/issues/425 |

**Issue title:** `[QC] [Live Activity] Week starts on Sunday but Calendar and Widget start on Monday`

### Steps to reproduce

1. On iPhone 15 (iOS 18.5), open the app and go to the Calendar tab, Week view. Note that the week starts on Monday.
2. Add the Calendar widget to the Home Screen. Note that the week starts on Monday.
3. Open the Discover tab, scroll down to the Live Activity section, tap a Live Activity that shows a week (e.g. Weekly Schedule) and start it.
4. Look at the week shown in the Live Activity.
5. Compare the first day of the week of the Live Activity with the Calendar tab and the Widget.

### Expected

The Live Activity starts the week on the same day as the Calendar tab and the Widget (Monday). The Live Activity takes the first day of the week from the device setting, the same way the Calendar tab and the Widget do.

### Actual

On iPhone 15 (iOS 18.5), the Calendar tab and the Widget start the week on Monday, but the Live Activity starts the week on Sunday. This happens every time a Live Activity that shows a week is used on this device.

Not every device is affected: it does not reproduce on iPhone 14 Pro Max (iOS 26) with the same setting.

### Evidence

- iOS Calendar app setting on the affected iPhone 15: *Start Week On* = **System Setting (Monday)** — [`04_discover_10_ios-calendar-settings_default.png`](../requirements/ui/ux/screenshots/iphone/04_discover/04_discover_10_ios-calendar-settings_default.png) (external iOS screen).

> ⚠️ **No screenshot of the Live Activity (Sunday-first) or of the Calendar tab / Widget (Monday-first) on the iPhone 15 is saved in the repo yet.** Capture them, place them in [`requirements/ui/ux/screenshots/iphone/04_discover/`](../requirements/ui/ux/screenshots/iphone/04_discover/) following the naming rule, then update `index.md`.

### Notes

- Reproduces on iPhone 15 / iOS 18.5; does not reproduce on iPhone 14 Pro Max / iOS 26 with the same setting (reported by the QC owner).
- Any Live Activity that shows a week is affected (reported by the QC owner).
- The cause is not known and is not assumed here. The screenshot above only shows the iOS Calendar app setting (Monday), not Settings → General → Language & Region.

### To verify

- [x] Build, install type, device and iOS — provided by the QC owner 2026-10-12.
- [x] Frequency, comparison device and Live Activity scope — provided by the QC owner 2026-10-12.
- [ ] Screenshots of the Live Activity and of the Calendar tab / Widget on the iPhone 15.
- [ ] Settings → General → Language & Region → First Day of Week and Region on the iPhone 15.
- [ ] Does the Live Activity on the Lock Screen and in the Dynamic Island both show Sunday first, or only one of them?

---

## BUG-010 · Nothing that changes in Google Calendar or Outlook (edit, delete, new event) reaches Ink

| Field | Value |
|---|---|
| **Date** | 2026-10-16 |
| **Flow** | `05_calendar` |
| **Screen** | `list-view` — seen in the Calendar tab; also seen in the Widget and on the wallpaper (see Actual) |
| **State** | `default` |
| **Severity** | High — data coming from Google / Outlook is permanently stale on every surface (Calendar tab, Widget, wallpaper) and deletions and new events do not arrive, so the user can act on events that no longer exist or are missing, with no warning |
| **Status** | Open |
| **Device / Build** | iPhone 14 Pro Max, iOS 26 · 1.2.24 (152) · TestFlight |
| **App language** | All languages |
| **Frequency** | Always |
| **GitHub issue** | not created yet |

**Issue title:** `[QC] [Calendar] Google Calendar / Outlook changes never reach Ink (Calendar tab, Widget, wallpaper)`

### Steps to reproduce

1. Connect Google Calendar (and, separately, Outlook) in Ink.
2. In the Ink Calendar tab, find an event on the connected calendar. Do this once with an event **created in Ink** and once with an event **not created in Ink**.
3. In Google Calendar (app or web) / Outlook (app or web), edit that event: change the title, time, date or any other field.
4. Go back to the Ink Calendar tab and look at the event.
5. Kill the app, reopen it, look at the event again. Wait a few minutes and look again.
6. In Google Calendar / Outlook, delete one of the events. Look at it in Ink the same way.

### Expected

The Calendar tab shows the latest version of the event (all fields), and an event deleted in Google Calendar / Outlook disappears from Ink.

### Actual

- No field of the event changes in Ink: Ink keeps showing the old version, for both Google and Outlook.
- Killing and reopening the app does not help. Waiting a few minutes does not help.
- An event deleted in Google Calendar / Outlook is **not** removed from Ink.
- An event **created** in Google Calendar / Outlook after the connection does **not** show up in Ink at all.
- The **Widget and the wallpaper** also show the old version, so the data is stale at the source, not only in the Calendar tab.
- Reproduces with events created in Ink and with events not created in Ink.
- Reproduces in all app languages.
- The other direction works: an update made in Ink shows up in Google Calendar and Outlook.

### Evidence

Screenshots of the same event in Ink and in Google Calendar / Outlook after the change will be added by the QC owner directly in git.

### Notes

- Reported for both Google Calendar and Outlook with the same symptom, so the cause may be in a layer shared by both rather than in one provider. This is not assumed here.
- **Regression:** on the previous build **1.2.23**, which did not yet have creating events from Ink to Google / Outlook, changes made in the provider did come through to Ink. They stop coming through on 1.2.24 (152), the build that adds event creation (provided by the QC owner 2026-10-16). The link to the new write feature is a likely suspect, not confirmed.
- **Signing out and signing in again** to Google / Outlook makes the events come through (provided by the QC owner 2026-10-16). So the provider data is reachable; the problem is more likely the session or token Ink holds than the provider or the display. Not confirmed with dev.
- Because new events do not arrive either, this is wider than "updates are not applied": Ink may not be reading from the providers at all (for example an expired or revoked session, or reading only a stored copy). Not confirmed. Compare with [BUG-004](#bug-004--event-tạo-trên-google-calendar-không-xuất-hiện-trên-wallpaper-hôm-sau) (Google events missing on the wallpaper), which may be the same cause.
- [`references/pipeline.html`](../references/pipeline.html) describes the **wallpaper render** path (a live fetch with a 10 s limit, and a 120 s cache for the editor preview). It does not describe how the in-app Calendar tab loads Google / Outlook events, so nothing there explains this bug. A restart and a wait of several minutes also rule out the 120 s cache as the only cause.
- Related checklist items: [`CAL-N53`–`N60`](../requirements/exploratory/05_calendar.md) (provider → Ink direction), `CAL-Q23`–`Q25`.

### To verify

- [x] Build, install type, device and iOS — provided by the QC owner 2026-10-16.
- [x] Frequency, and that it affects events created in Ink and not created in Ink — provided by the QC owner 2026-10-16.
- [ ] Screenshots: the same event in Ink vs Google Calendar / Outlook after the edit, and after the delete (QC owner will add in git).
- [x] Wallpaper and Widget show the old version too — provided by the QC owner 2026-10-16.
- [x] New events created in Google Calendar / Outlook do not appear in Ink — provided by the QC owner 2026-10-16.
- [x] App language: reproduces in all languages — provided by the QC owner 2026-10-16.
- [ ] Do the other views (Day, Week, Month) show the old version too, or only List?
- [ ] Settings → Google Calendar / Outlook: does it still show Connected while the data is stale (no sign-in prompt)?
- [x] Signing out and in again brings the latest events — provided by the QC owner 2026-10-16.
- [ ] How long after signing in does the data go stale again (minutes, hours, a day)? Does it go stale after a token lifetime (about 1 hour) or after the app is killed?
- [x] Works on 1.2.23, broken on 1.2.24 (152) — regression, provided by the QC owner 2026-10-16.
- [ ] Does it reproduce on a **clean install** of 1.2.24 (152), or only on a device that was connected on 1.2.23 and then updated? This tells whether the problem is the update path (old session kept) or the build itself.
