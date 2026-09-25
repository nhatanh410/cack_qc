# QC — PR #314: 5 ngôn ngữ mới, paywall dùng chung, giới hạn Free

PR: [sfunvn/lockscreen-calendar#314](https://github.com/sfunvn/lockscreen-calendar/pull/314)

## Chuẩn bị

- Bản **dev** từ Firebase App Distribution. Test trên 1 máy **iOS 27** và 1 máy **iOS 26**.
- Dùng tài khoản **Free**. Settings của bản dev có nút **Grant Pro (dev)** / **Revoke Pro (dev)**:
  - bấm Grant để thành Pro;
  - bấm Grant rồi Revoke để giả lập user **hết hạn Pro**.
- Muốn đổi ngôn ngữ thì vào iOS Settings → Ink → Language, không cần đổi ngôn ngữ cả máy.

---

## 1. Ngôn ngữ mới: Đức, Ý, Nga, Thổ Nhĩ Kỳ, Ukraina

Làm cho từng ngôn ngữ:

- [ ] Onboarding, Home, Calendar, Notes, Settings, Paywall: không còn chữ tiếng Anh sót lại, không có chữ bị cắt hoặc tràn dòng.
- [ ] Luồng setup Shortcut: video hướng dẫn phát đúng ngôn ngữ, có tiếng.
- [ ] Tên nút và mục của iOS được nhắc trong hướng dẫn (Run Immediately, Next, When I get a notification from Ink…) khớp với chữ thật trên máy ở ngôn ngữ đó.
- [ ] Chữ trong "…" ở Guide và Setup được in đậm.
- [ ] Popup tắt nguồn lịch ("Turn off Google Calendar?"…) và luồng xoá tài khoản hiển thị đúng ngôn ngữ.
- [ ] Widget và Live Activity hiển thị đúng ngôn ngữ.
- [ ] Hộp xin quyền của iOS (lịch, thông báo, tracking) hiển thị đúng ngôn ngữ.

## 2. Paywall mở ngay tại chỗ

Trước đây màn hình đang mở phải đóng lại rồi paywall mới hiện ở Home. Giờ **paywall nổi lên trên màn hình đang mở, đóng paywall thì quay lại đúng màn hình đó**.

| Mở từ | Cách mở |
|---|---|
| Template editor | bấm font, màu Custom, ảnh nền hoặc mode Home Screen có vương miện |
| Template editor | popup "Photo set is full" / "Photo limit reached" → Go Pro |
| Note wallpaper | thêm ảnh khi thư viện đã đầy |
| Decorate | Cutout, hoặc style chữ Pro |
| Note → sticker | Remove background |
| Settings | hàng Pro; popup giới hạn tài khoản lịch → Go Pro |
| Ink AI | thêm quote khi lock screen đang dùng template Pro |
| Preview / editor của mẫu Pro đã lưu | Set as current / Update (user đã hết Pro) |

Mỗi chỗ trong bảng kiểm:

- [ ] Paywall hiện lên, đóng lại thì màn hình cũ vẫn còn và dữ liệu đang sửa vẫn giữ nguyên.
- [ ] Mua xong (hoặc Restore) thì vương miện biến mất ngay, không cần thoát màn hình.
- [ ] Bấm liên tục hai lần không mở ra hai paywall.
- [ ] Đóng paywall xong thì mở lại được bình thường, không bị kẹt.

## 3. Giới hạn "Your collection" (Free: 5 mẫu)

Wallpaper, note và Live Activity tính chung vào 5 mẫu.

- [ ] Khi đã có 5 mẫu, set thêm một mẫu mới sẽ hiện popup **"Collection is full"** và mẫu mới không được thêm. Thử với cả 3 loại:
  - [ ] wallpaper từ Templates;
  - [ ] note (set lên lock screen, widget hoặc Live Activity);
  - [ ] Live Activity lịch hoặc Live Activity trong catalog.
- [ ] Trong popup, bấm **Go Pro** → paywall mở. Bấm Cancel → popup đóng, không có gì thay đổi.
- [ ] Set lại một mẫu đã có trong collection thì **không bị chặn**.
- [ ] Đang chạy một Live Activity lịch, mở template cùng loại rồi đổi style → collection **không** tăng lên 6.
- [ ] Xoá bớt một mẫu (còn 4) → set mẫu mới được.
- [ ] User Pro: không bị giới hạn. User hết Pro mà đang có hơn 5 mẫu: giữ nguyên tất cả, chỉ bị chặn khi thêm mẫu mới.

## 4. Giới hạn tài khoản lịch (Free: 1 tài khoản)

- [ ] User Free đang bật Google, bật thêm Outlook (hoặc ngược lại) → popup **"Connect both calendars with Pro"**, công tắc vẫn ở trạng thái tắt.
- [ ] Popup → Go Pro → paywall.
- [ ] Apple Calendar luôn bật được.
- [ ] User hết Pro đang dùng cả hai tài khoản: cả hai vẫn chạy bình thường.

## 5. Template editor: tính năng Pro

User Free thấy **vương miện nhỏ** ở góc các lựa chọn Pro. Bấm vào thì mở paywall và **không** chọn lựa chọn đó.

- [ ] **Font:** 7 font Pro (Playfair Display, Merriweather, Oswald, Pacifico, Shadows, Snell Roundhand, Baskerville) có vương miện.
- [ ] **6 font mới** (Noteworthy, Marker Felt, Chalkboard, Snell Roundhand, American Typewriter, Baskerville):
  - [ ] hiện đúng mặt chữ trong editor và trên wallpaper sau khi set;
  - [ ] gõ tiếng Việt có dấu hiển thị đủ.
- [ ] **Màu event:** chọn Template và Calendar thoải mái, **Custom** là Pro.
- [ ] **Ảnh nền trong catalog** có đánh dấu Pro thì bị khoá.
- [ ] **Home Screen:** mode "No calendar" và "My photo" là Pro.
- [ ] **Bộ ảnh xoay vòng mỗi ngày:**
  - [ ] Free chọn được tối đa **2** ảnh, ảnh thứ 3 → popup "Photo set is full" → Go Pro;
  - [ ] Pro chọn được tối đa **7**.
- [ ] **Thư viện ảnh tải lên:**
  - [ ] Free giữ tối đa **3** ảnh, ảnh thứ 4 → popup "Photo limit reached" → Go Pro;
  - [ ] Pro giữ tối đa **10**, đến giới hạn thì popup chỉ có nút OK.

## 6. Hết Pro: những gì đã chọn vẫn giữ nguyên

Làm khi đang Pro: chọn font Pro, màu Custom, ảnh Pro trong catalog, mode Home Screen Pro, và bộ 5 ảnh xoay vòng. Sau đó **Revoke Pro**.

- [ ] Wallpaper vẫn hiển thị đúng như lúc đang Pro.
- [ ] Mở lại editor: các lựa chọn đang dùng không bị khoá, chỉ các lựa chọn Pro *khác* mới bị khoá.
- [ ] Tắt công tắc "New photo every day" (bộ ảnh tạm dừng): ảnh Pro trong bộ vẫn **bấm được**, không mở paywall.
- [ ] Bộ 5 ảnh vẫn xoay vòng đủ 5. Chỉ không thêm được ảnh mới.

## 7. Thông báo cập nhật wallpaper (chỉ iOS 27)

Cần: đã bật thông báo, cài shortcut V2 mới nhất, đã bật automation "When I get a notification from Ink".

- [ ] Mở rồi thoát Ink một lần trong ngày. Sửa một event hôm nay rồi thoát Ink → có thông báo và wallpaper được cập nhật.
- [ ] Lần thoát **đầu tiên** trong ngày không có thông báo. Đây là hành vi đúng.

## 8. Analytics (Firebase DebugView)

Bản dev cần bật debug (`-FIRDebugEnabled`) thì mới thấy trong DebugView. Nếu không bật được thì xem ở tab Realtime.

| Thao tác | Event | Param |
|---|---|---|
| Mở paywall từ các chỗ ở mục 2, 3, 4, 5 | `pro_paywall_viewed` | `source` theo bảng dưới |
| Mở Guide | `screen_view` | `how_to_guide` |
| Bấm nút trong một topic của Guide | `guide_action_tapped` | `action` = tên nút, `source` = id topic |
| Mục 7 có thông báo | `refresh_notification_posted` | — |
| Bấm nút chính của in-app message / announcement | các event `setup_*` | `source` = `in_app_message` / `announcement` |

Giá trị `source` của paywall:

| Chỗ mở | `source` |
|---|---|
| Popup "Collection is full" | `collection_limit` |
| Popup giới hạn tài khoản lịch | `calendar_sources` |
| Editor: font / màu Custom / ảnh catalog Pro | `wallpaper_font` / `wallpaper_event_colors` / `wallpaper_catalog_image` |
| Editor: popup "Photo limit reached" / "Photo set is full" | `wallpaper_photo_limit` / `wallpaper_photo_set` |
| Editor: Home Screen | `wallpaper_home_screen` |
| Thêm ảnh cho note wallpaper | `note_wallpaper_background` |
| Ink AI | `ink_ai_quote` |
| Deep link mở màn Pro | `deep_link` |
| Mẫu Pro ở Home / preview | `home` |

## Không phải bug

- Lần thoát Ink đầu tiên trong ngày không có thông báo cập nhật (mục 7).
- User hết Pro vẫn giữ những gì đã chọn lúc còn Pro. Chỉ bị chặn khi **thêm mới**.
- Apple Calendar không tính vào giới hạn tài khoản lịch.
- Font của Notes (không phải wallpaper editor) không bị khoá.
