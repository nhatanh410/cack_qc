# Paywall Remote Config — Hướng dẫn setup & checklist QC

Tài liệu này dành cho **hai người**:

- **Người set Remote Config** (Phần A) — dựng config trên Firebase Console, tạo
  variant A/B.
- **QC** (Phần B) — checklist kiểm thử.

> Tài liệu kỹ thuật (schema đầy đủ, quy tắc fallback từng field, lý do thiết kế)
> nằm ở [`paywall-config.md`](paywall-config.md). File này là bản thao tác.

---

## Nguyên tắc cần nắm trước

Màn paywall có **nội dung** điều khiển từ xa, nhưng **layout thì không**.

| Đổi được từ RC | Không đổi được từ RC |
|---|---|
| Tiêu đề, mô tả | Thứ tự các khối trên màn (hero → text → benefit → plan → CTA) |
| Danh sách benefit (icon, màu, chữ) | Benefit dạng carousel / cuộn ngang |
| Ảnh hero, hoặc bật animation dựng sẵn | Video, Lottie |
| Hiện/ẩn từng gói, thứ tự, gói chọn sẵn, badge | Số ngày dùng thử |
| Tiêu đề/mô tả từng dòng gói | Thời gian mới cho phép bấm nút ✕ |

**Ba luật quan trọng nhất:**

1. **Số ngày dùng thử luôn lấy từ StoreKit, không bao giờ từ RC.** Muốn dòng gói
   ghi "Dùng thử 3 ngày" thì viết `{trial}` vào `title`, app tự thay bằng con số
   thật từ App Store *và chỉ khi user đó thực sự còn đủ điều kiện dùng thử*. Gõ
   tay "3 ngày" vào RC là nói dối người dùng đã hết quyền dùng thử.
2. **Mọi field đều có fallback riêng.** Một dòng benefit sai cú pháp không làm
   mất tiêu đề. Nhưng nếu **envelope** sai (`schema_version`, `min_app_version`,
   kill switch) thì **bỏ nguyên payload**, không áp một nửa.
3. **Config làm paywall không còn gói nào mua được ⇒ app tự quay về gói mặc
   định trong bản build.** Đây là chốt chặn cuối, QC phải test (mục B6).

---

# Phần A — Setup Remote Config

## A0. Bản build nào mới đọc được key này

**Đặt key trên Console không làm gì cả nếu bản app không mang code đọc nó.**

`pro_paywall_config_v1` do commit `c711ceb4` mang lại. Kiểm tra một bản build
bất kỳ có đọc key này không:

```bash
git merge-base --is-ancestor c711ceb4 <ref> && echo "có đọc" || echo "KHÔNG đọc"
```

Bản đã phát hành mà chưa có commit đó chỉ đọc `pro_plan_config`. Nghĩa là:

- Sửa gói cho **người dùng đang cài bản cũ** ⇒ vẫn phải sửa `pro_plan_config`.
- Đặt `pro_paywall_config_v1` trên prod trước khi bản mới lên store là **vô
  hại nhưng vô tác dụng** — không có gì hỏng, cũng không có gì đổi.

Triệu chứng khi nhầm chỗ này giống hệt lúc payload sai: paywall hiện đúng bản
bundled, không báo lỗi gì.

## A1. Vào đúng project

| Môi trường | Firebase project | Bundle id | `minimumFetchInterval` |
|---|---|---|---|
| Dev | `workout-ai-1bdb1` | `com.silverai.calendar.lockscreen.dev` | `0` — đổi là thấy ngay |
| Prod | `lockscreencalendar-4477e` | `com.silverai.calendar.lockscreen` | `3600` — mỗi máy tối đa 1 lần/giờ |

Hai project **tách rời**, không dùng chung template: set ở dev xong vẫn phải set
lại ở prod bằng tay.

**Luôn thử ở dev trước.** Paywall là màn ra tiền và cũng là màn đầu tiên user
chưa mua nhìn thấy khi mở app.

## A2. Tạo parameter

Firebase Console → **Remote Config** → **Add parameter**

- **Parameter name:** `pro_paywall_config_v1`
- **Data type:** JSON
- **Default value:** dán payload ở A3

> ⚠️ Có một key cũ tên `pro_plan_config` — **đừng xoá**. Các bản app đã cài trên
> máy người dùng chỉ đọc key đó. Nó bị "đóng băng", chỉ sửa khi cần đổi gói cho
> các bản cũ.

## A3. Payload tối thiểu (để thử cho nhanh)

```json
{
  "schema_version": 1,
  "variant": "smoke_test",
  "headline": { "en": "Everything, unlocked", "vi": "Mở khoá toàn bộ" }
}
```

Chỉ đổi tiêu đề, mọi thứ còn lại giữ nguyên như bản build. Dùng payload này để
xác nhận đường truyền RC → app đã thông, trước khi làm gì phức tạp hơn.

## A4. Payload đầy đủ

```json
{
  "schema_version": 1,
  "min_app_version": "1.2.16",
  "use_bundled_paywall": false,
  "variant": "hero_matrix_vi",

  "headline": { "en": "Your week, on your lock screen", "vi": "Cả tuần của bạn, ngay trên màn khoá" },
  "subtitle": { "en": "Unlimited wallpapers, widgets and calendars.", "vi": "Không giới hạn hình nền, widget và lịch." },

  "hero": { "animation": "matrix_lock_screen" },

  "benefits": [
    { "icon": "calendar", "tint": "accentBlue",
      "title": { "en": "Unlimited calendars", "vi": "Không giới hạn lịch" } },
    { "icon": "sparkles", "tint": "accentPink",
      "title": { "en": "All premium templates", "vi": "Toàn bộ mẫu cao cấp" } },
    { "icon": "bolt.fill", "tint": "accentAmber",
      "title": { "en": "Live Activities", "vi": "Live Activity" } }
  ],

  "plans": [
    { "product_id": "com.silverai.calendar.lockscreen.pro.annual",
      "period": "annual", "type": "subscription",
      "show": true, "preselected": true, "badge": "best_value",
      "title": { "en": "Try {trial} free", "vi": "Dùng thử {trial} miễn phí" } },
    { "product_id": "com.silverai.calendar.lockscreen.pro.weekly",
      "period": "weekly", "type": "subscription",
      "show": true, "badge": "popular" },
    { "product_id": "com.silverai.calendar.lockscreen.pro.lifetime",
      "period": "lifetime", "type": "lifetime",
      "show": true }
  ]
}
```

> **Hai field im lặng nhất khi gõ sai — kiểm lại trước khi publish:**
>
> - **`min_app_version` cao hơn bản đang chạy ⇒ bỏ NGUYÊN payload**, không áp
>   một phần nào. So sánh theo từng số, với `CFBundleShortVersionString`
>   (`MARKETING_VERSION`, hiện tại **1.2.16**). Đặt `"1.9.0"` khi app là 1.2.16
>   là tắt sạch config mà màn hình trông vẫn bình thường. Không chắc thì **bỏ
>   hẳn field này** — vắng mặt nghĩa là mọi bản đều nhận.
> - **`period` chỉ nhận `weekly` · `annual` · `lifetime`.** Không có `yearly`.
>   Gõ sai ⇒ **dòng gói đó bị loại**, các dòng khác vẫn hiện, nên rất dễ tưởng
>   là quên khai báo. Product id gói năm cũng là `…pro.annual`.
>
> Cả hai đều để lại log ở Console, category `paywall-config`.

### Giá trị hợp lệ (ngoài danh sách này là bị bỏ qua, dùng mặc định)

| Field | Giá trị cho phép |
|---|---|
| `hero.animation` | `tidy_timetable` · `phone_assemble` · `matrix_lock_screen` |
| `hero.image_url` | chỉ **https** |
| `tint` | `accentPink` `accentMint` `accentCoral` `accentAmber` `accentCyan` `accentBlue` `accentGreen` `brandViolet` |
| `badge` | `best_value` · `popular` |
| `icon` | tên SF Symbol có thật; sai tên → tự đổi thành `sparkles` |

**Số benefit tối đa là 5.** Thừa sẽ bị cắt.

- `benefits` **không khai báo** → dùng 3 dòng mặc định trong app.
- `benefits: []` (mảng rỗng) → **ẩn hẳn** khối benefit.
- `subtitle` để chuỗi rỗng → ẩn dòng mô tả.
- Thứ tự gói hiển thị = **thứ tự trong mảng `plans`**.

## A5. Tạo variant A/B

Trong Firebase Console → **A/B Testing** → **Create experiment** → Remote
Config, chọn parameter `pro_paywall_config_v1`, mỗi nhánh dán một payload.

**Bắt buộc:** mỗi nhánh phải có `"variant"` khác nhau. Chuỗi này là **do bạn tự
đặt**, app không kiểm tra danh sách cố định — nhưng nó chính là thứ đi vào
analytics, nên đặt sai/trùng là mất luôn khả năng đọc kết quả.

Quy ước đề xuất: `<thứ-đang-test>_<nhánh>`, ví dụ `benefit_a`, `benefit_b`,
`icon_only_c`. Tối đa **36 ký tự**.

### Một bước trong GA4 mà thiếu là mất kết quả

`variant` đi ra analytics theo **hai** đường, và đường quan trọng hơn cần khai
báo tay một lần cho mỗi project:

| Đường | Đo được gì | Cần làm gì |
|---|---|---|
| Param của event `pro_paywall_viewed` | chỉ bước **xem** paywall | không cần gì |
| User property `paywall_variant` | **toàn bộ phễu**, tới lượt mua | phải đăng ký |

GA4 → **Admin → Custom definitions → Custom dimensions → Create** →
scope **User**, user property `paywall_variant`. Không đăng ký thì property vẫn
được ghi nhưng **không hiện ra ở báo cáo nào**, nên `pro_plan_selected` /
`pro_purchase_succeeded` không chia được theo nhánh — tức là chạy A/B xong
không kết luận được gì.

Làm riêng cho từng project: đăng ký ở dev không kéo sang prod.

GA4 chỉ dựng dimension từ **thời điểm đăng ký trở đi**, không hồi tố. Đăng ký
trước khi bật experiment, đừng để chạy vài ngày rồi mới nhớ ra.

## A6. Publish và làm sao app lấy được config mới

Sau khi **Publish changes**, app không cập nhật ngay lập tức — và **dev với prod
chờ khác nhau rất nhiều**.

**Trên dev** (`minimumFetchInterval = 0`):

1. Kill app hoàn toàn (vuốt khỏi app switcher).
2. Mở lại. Thấy ngay.

**Trên prod** (`minimumFetchInterval = 3600`): mỗi máy chỉ fetch lại **tối đa 1
lần mỗi giờ**, và chỉ vào lần mở app nguội sau khi hết cửa sổ đó. Kill rồi mở
lại trong vòng một tiếng sẽ **không** lấy được giá trị mới. Khi QC bản prod,
cách chắc chắn duy nhất là **gỡ app rồi cài lại** — cài mới không có cửa sổ nào
để chờ.

Con số 1 tiếng là mức sàn Firebase khuyến nghị cho prod để không vượt quota
fetch; đừng hạ nó xuống chỉ để test cho nhanh.

> ⚠️ **Không dùng `firebase deploy --only remoteconfig`** trừ khi bạn cố ý muốn
> vậy — lệnh đó **thay thế toàn bộ template**, xoá sạch các parameter khác.

---

# Phần B — Checklist QC

## Chuẩn bị

- Xác nhận bản đang test **có đọc key này** — xem A0. Thiếu bước này thì mọi mục
  dưới đây đều "không thấy gì đổi" vì cùng một lý do.
- Tài khoản Apple ID **chưa từng mua** gói nào của app.
- Có thêm một tài khoản **đã hết hạn dùng thử** (để test luật `{trial}`).
- Test cả **tiếng Việt** và **tiếng Anh** (đổi trong Cài đặt máy).
- Biết cách mở paywall: Settings → Upgrade, biểu tượng vương miện ở Discover, và
  màn paywall tự bật khi mới mở app.

> **Trước khi test `{trial}` (mục B7), kiểm tra App Store Connect có offer
> thật.** `{trial}` chỉ hiện khi StoreKit báo có **free trial** mà tài khoản đó
> **còn quyền dùng** — RC không tạo ra được trial. File `Pro.storekit` trong
> repo hiện **không khai introductory offer nào** cho cả weekly lẫn annual, nên
> nếu ASC cũng chưa có thì mọi `title` chứa `{trial}` sẽ rơi về
> `title_no_trial` rồi tên gói mặc định — đúng thiết kế, không phải bug. Lưu ý
> offer **trả phí** ("0.99$ tháng đầu") cũng là introductory offer, nhưng chỉ
> `paymentMode == .freeTrial` mới được quảng cáo là miễn phí.

---

### B1. Paywall mặc định (chưa có RC)

Xoá parameter `pro_paywall_config_v1` (hoặc để trống) rồi mở paywall.

- [ ] Màn hiển thị đầy đủ: hero, tiêu đề, mô tả, 3 benefit, các gói, nút mua.
- [ ] Không có khoảng trống lạ, không có dòng nào trống.

### B2. Đổi chữ

Dùng payload A3.

- [ ] Tiêu đề đổi theo RC.
- [ ] Máy tiếng Việt hiện bản `vi`, máy tiếng Anh hiện bản `en`.
- [ ] Nếu payload **thiếu** ngôn ngữ máy đang dùng → hiện bản `en`, **không**
      hiện chuỗi rỗng.

### B3. Benefit

- [ ] Đổi chữ + icon + màu → hiện đúng.
- [ ] Khai báo 7 dòng → **chỉ hiện 5**.
- [ ] `benefits: []` → khối benefit **biến mất**, các khối khác không xô lệch.
- [ ] Icon gõ sai tên (vd `"khong_co_that"`) → hiện icon `sparkles`, **không
      crash, không ô trống**.
- [ ] Chữ benefit dài (tiếng Đức/tiếng Việt dài) → xuống tối đa 2 dòng, không
      tràn, không bị cắt cụt giữa chữ.

### B4. Hero

- [ ] `hero.animation` = `tidy_timetable` → hiện bảng tuần, các thẻ bay vào rồi
      xáo chỗ, sau đó gập thành dạng timeline có thanh chạy, rồi mở lại.
- [ ] `hero.animation` = `phone_assemble` → các thành phần lịch bay vào khung
      điện thoại.
- [ ] `hero.animation` = `matrix_lock_screen` → task bay vào ma trận 4 ô, ma
      trận thu vào điện thoại, rồi tách thành 2 điện thoại.
- [ ] **Cả 3 animation phải cao bằng nhau.** Bấm đổi qua lại giữa chúng, phần
      bên dưới (giá, nút mua) **không được nhích lên/xuống**.
- [ ] `hero.image_url` (https) → hiện ảnh. Mạng chậm → hiện ảnh mặc định trước,
      **không được để trống trắng**.
- [ ] `image_url` dùng `http://` (không phải https) → **bỏ qua**, dùng ảnh mặc
      định.
- [ ] Nút ✕ góc trên phải **luôn bấm được**, không bị hình che.

### B5. Gói

- [ ] `show: false` → gói đó biến mất.
- [ ] `preselected: true` → gói đó được chọn sẵn khi mở màn.
- [ ] Đổi thứ tự trong mảng → thứ tự trên màn đổi theo.
- [ ] `badge` hiện đúng (`best_value` / `popular`).
- [ ] Đủ 3 gói → gói cuối (Lifetime) vẫn **nhìn thấy được không cần cuộn**, trên
      cả máy màn nhỏ (iPhone SE / iPhone 13 mini).

### B6. ⭐ Fallback — quan trọng nhất

Đây là lỗi nghiêm trọng nhất mà tính năng này phải chống được: paywall trống,
không mua được gì.

- [ ] Set **tất cả** gói `show: false` → app **vẫn hiện các gói mặc định**,
      không hiện màn trống.
- [ ] Điền `product_id` sai/không tồn tại cho tất cả gói → tương tự, **vẫn hiện
      gói mặc định**.
- [ ] `schema_version: 99` → **bỏ toàn bộ payload**, hiện paywall mặc định
      (không hiện nửa nọ nửa kia).
- [ ] `min_app_version` cao hơn bản đang test → bỏ toàn bộ payload.
- [ ] `use_bundled_paywall: true` → hiện paywall mặc định của bản build.
- [ ] JSON sai cú pháp → hiện paywall mặc định, **không crash**.
- [ ] Bật chế độ máy bay rồi mở paywall → hiện paywall mặc định, không treo,
      không màn trắng.

### B7. Dùng thử (trial) — luật StoreKit

- [ ] Tài khoản **chưa dùng thử bao giờ**, `title` có `{trial}` → hiện đúng số
      ngày App Store cấu hình (vd "Dùng thử 3 ngày miễn phí").
- [ ] Tài khoản **đã hết quyền dùng thử** → dòng đó **không** được ghi "dùng
      thử". Phải rơi về `title_no_trial` hoặc tiêu đề mặc định.
- [ ] Số ngày trên paywall **khớp** với số ngày ở màn Settings.
- [ ] Số ngày **khớp với App Store Connect**, không khớp với con số gõ trong RC.

### B8. Ngôn ngữ & khả năng tiếp cận

- [ ] Bật **Cài đặt → Trợ năng → Chuyển động → Giảm chuyển động**: hero hiện ở
      trạng thái hoàn chỉnh, **đứng yên**, không lặp. Không có gì nhấp nháy.
- [ ] Tăng cỡ chữ lên mức lớn nhất: nút mua không phình ra, chữ không tràn.
- [ ] Kiểm tra ít nhất 3 ngôn ngữ, gồm 1 ngôn ngữ chữ dài (vd tiếng Đức) và 1
      ngôn ngữ CJK.
- [ ] Trên iPad: nội dung không kéo giãn hết chiều ngang, canh giữa hợp lý.

### B9. Analytics (cần người có quyền xem Firebase)

- [ ] Mở paywall → có event `pro_paywall_viewed`, kèm `variant` đúng chuỗi đã
      đặt trong RC.
- [ ] Có **user property** `paywall_variant` = đúng chuỗi đó.
- [ ] Không có RC / dùng bản mặc định → `paywall_variant` = `bundled`.

> Vì sao cần cả hai: `variant` trong event chỉ đo được **bước xem paywall**. User
> property mới cho phép chia nhóm **toàn bộ phễu**, tới tận lượt mua.

---

## Bảng lỗi thường gặp

| Hiện tượng | Nguyên nhân thường gặp |
|---|---|
| Đổi RC mà app không đổi gì | Bản build **không mang commit `c711ceb4`** nên không đọc key (A0); chưa **Publish**; chưa kill app; **trên prod chưa qua 1 tiếng** kể từ lần fetch trước (A6); `schema_version` ≠ 1; `min_app_version` cao hơn bản đang chạy |
| Thiếu đúng **một** dòng gói, các dòng khác vẫn đủ | `period` gõ sai — chỉ nhận `weekly` · `annual` · `lifetime`, **không có `yearly`**; hoặc `product_id` sai; hoặc thiếu `type` |
| Set ở dev chạy, lên prod không chạy | Hai Firebase project tách rời, phải set lại bằng tay ở `lockscreencalendar-4477e` (A1) |
| Chạy A/B xong không chia được phễu theo nhánh | Chưa đăng ký `paywall_variant` làm custom dimension user-scope trong GA4 (A5) |
| Cả prod đột nhiên rơi về paywall bundled | Có người bật **App Check enforcement** cho Remote Config, hoặc vượt quota fetch. Kiểm tra Console trước khi nghi payload |
| Paywall trống / không có gói nào | Config không tạo ra gói mua được — **đúng ra app phải tự quay về gói mặc định**. Nếu vẫn trống ⇒ **lỗi nặng, báo ngay** |
| Benefit hiện icon ✨ dù đã set icon khác | Tên SF Symbol sai |
| Hero không đổi | Tên animation sai (phải đúng 1 trong 3 chuỗi ở A4), hoặc `image_url` không phải https |
| Dòng gói ghi "dùng thử" cho tài khoản hết hạn | **Lỗi nặng** — báo ngay, kèm Apple ID test và ảnh chụp màn |
| Gói Lifetime bị khuất dưới màn | Lỗi layout, báo kèm tên máy + cỡ chữ đang dùng |
| Chữ hiện tiếng Anh trên máy tiếng Việt | Payload thiếu key `vi` cho field đó |

## Khi báo lỗi, gửi kèm

1. Ảnh/video màn hình.
2. **Toàn bộ JSON** đang đặt trong RC (copy nguyên văn).
3. Môi trường: dev hay prod.
4. Tên máy + phiên bản iOS + ngôn ngữ máy.
5. Apple ID test đang dùng, và tài khoản đó đã từng mua/dùng thử chưa.

---

## Ghi chú cho dev

- Ép hiện một hero cụ thể khi chạy từ Xcode (chỉ bản DEBUG):
  thêm launch argument `-ink-debug-paywall-hero matrix_lock_screen`.
- Xem nhanh từng hero không cần chạy app: mở các `#Preview` trong
  `ios/Ink/UI/Pro/Hero/`, và `#Preview("Hero animations")` trong
  `ProHeroSlot.swift` có picker chọn cả 3.
