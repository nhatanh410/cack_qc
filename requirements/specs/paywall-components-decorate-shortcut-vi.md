# QC — Paywall nhầm với user Pro, component Pro, tab Decorate, shortcut "không tìm thấy"

Ba PR trong bản 1.2.21 (bản này còn các bản sửa khác, có checklist riêng): user Pro bị hiện paywall nhầm (PR #405),
component Pro trong Customize và tab Decorate (#408), app báo "không tìm thấy shortcut" nhầm và tạo shortcut trùng (#409).

## Chuẩn bị

- Phần 2 và 3: bản **dev** từ Firebase App Distribution. Test trên 1 máy **iOS 27** và 1 máy **iOS 26**, cả **light** lẫn **dark mode**.
- Settings của bản dev, mục **Debug**, có nút **Grant Pro (dev)** / **Revoke Pro (dev)** để đổi nhanh giữa Free và Pro.
- Phần 1 phải **mua thật bằng tài khoản Sandbox**. Nút Grant Pro (dev) không thay được, vì nó cấp Pro không có ngày hết hạn, nên không bao giờ "tới kỳ gia hạn".
- Phần 4 chạy trên **máy thật**, bản **Prod** (TestFlight), và máy **chỉ cài một bản Ink** (gỡ Ink Dev). Lý do: hai bản dùng chung đường dẫn `ink://`, Shortcuts có thể trả kết quả về nhầm bản kia. Simulator cũng không test được phần này vì cùng lý do.
- "Mở app" là **tắt hẳn app** (vuốt khỏi app switcher) rồi mở lại. "Đưa app xuống nền" là vuốt về Home, **không** tắt.

---

## 1. User Pro không bị hiện paywall nhầm (#405)

**Lỗi cũ:** user đang trả tiền thỉnh thoảng bị chặn bởi paywall khi thêm ảnh nền, hoặc thấy paywall khi mở app. Ba nguyên nhân:

- App không nghe được lần gia hạn khi đang chạy nền. Qua ngày hết hạn tính theo máy, user thành Free cho tới lần mở app sau.
- App bị iOS đánh thức lúc **máy đang khoá** thì không đọc được trạng thái Pro.
- Màn splash cắt ngang lúc app đang hỏi App Store.

**Chuẩn bị:** bản dev, đăng nhập tài khoản Sandbox, mua **gói tuần**. Trong Sandbox, gói tuần tự gia hạn khoảng **3 phút một lần**.

- [ ] Mua gói tuần → đưa app xuống nền khoảng **10 phút** (qua vài lần gia hạn) → mở lại từ nền → Customize → thêm ảnh nền thứ **4** (Free chỉ được 3) → **không** hiện paywall.
- [ ] Tắt hẳn app, đợi qua ít nhất một lần gia hạn → mở app → **không** hiện paywall lúc mở app.
  - Lúc này splash có thể đứng lâu hơn một chút (tối đa khoảng 3 giây) vì app đang hỏi App Store. Đúng thiết kế.
- [ ] Vẫn ở trạng thái đó: các thứ Pro khác (font Pro, component Pro, Home Screen modes) **không** hiện vương miện, không hỏi Pro.
- [ ] **Máy khoá:** đang Pro, bật Background App Refresh cho Ink, khoá máy để qua đêm. Sáng mở khoá → mở app → không paywall, thêm ảnh nền không bị chặn.
- [ ] **Hết hạn thật:** huỷ gói trong Sandbox, đợi qua kỳ gia hạn cuối → mở app → app thành Free: paywall hiện lúc mở app, ảnh nền thứ 4 bị chặn. (Kiểm rằng bản sửa không giữ Pro cho người đã thôi trả tiền.)
- [ ] Mua mới ngay trên paywall: paywall đóng, mở khoá Pro ngay.
- [ ] Restore purchases (cài lại app, hoặc máy khác cùng tài khoản Sandbox): vẫn là Pro.

---

## 2. Customize: component Pro (#408)

**Chuẩn bị:** Debug → **Revoke Pro (dev)** để thành user Free.

**13 loại component Pro** (tên trong sheet Add):

| Nhóm | Loại Pro |
|---|---|
| Calendar | Daily page, Month heatmap, Lunar calendar, Timetable, Week schedule |
| Events | Today at a glance, Event tickets, Hour timeline, Week events, Activity grid |
| Fitness | Workout |
| Tasks | Priority matrix |
| Progress | Milestones |

### 2.1 Vương miện và hỏi Pro khi lưu

- [ ] Customize → nút **+** (Add): đúng 13 loại trên có **vương miện**. Các loại khác và Row / Column thì không.
- [ ] Thêm một loại có vương miện: thêm được, chỉnh được như bình thường (Free được dùng thử).
- [ ] Bấm **✓**: popup **"Keep your Pro picks?"** liệt kê component vừa thêm.
  - **Unlock Pro** → mở paywall.
  - **Set without Pro** → đặt hình nền **không có** component Pro đó.
- [ ] Mở một template **vốn đã có** component Pro (vd. có Daily page) → không thêm gì → ✓: **không** bị hỏi về component đó.
- [ ] User Pro (Grant Pro): không có vương miện, không bị hỏi.

### 2.2 Giới hạn số component

- [ ] Template 1 component → thêm cái thứ 2 được → thêm cái thứ 3: popup **"Component limit reached"**, nội dung ghi "holds **2** components". **Go Pro** → paywall.
- [ ] Template vốn có **3** component: mở bình thường, không bị chặn. Đổi một component sang loại khác được. Thêm cái thứ 4: popup ghi "holds **3** components".
- [ ] **Row / Column** không tính vào giới hạn.
- [ ] User Pro: thêm bao nhiêu cũng được, không có popup.

### 2.3 Design đã lưu từ bản cũ

- [ ] Máy update từ bản cũ, có design trong **Your collection** từng **thêm** một component nay đã là Pro (template gốc không có) → set lại design đó: bị hỏi Pro.
- [ ] Design chỉ giữ đúng các component của template gốc → set lại: **không** bị hỏi.

### 2.4 Remote Config (project dev)

Key `template_editor_config` (JSON). Sửa xong thì tắt hẳn app rồi mở lại.

- [ ] `{"max_components_free": 3, "pro_component_types": ["workout"]}` → chỉ **Workout** có vương miện, popup giới hạn ghi "holds 3 components".
- [ ] `{"pro_component_types": []}` → không loại nào có vương miện.
- [ ] Xoá hai field đó → trở lại 13 loại và giới hạn 2.
- [ ] Các field khác trong cùng key (`max_uploads_free`…) vẫn chạy như cũ.

---

## 3. Customize: tab Decorate (#408)

Customize → tab **Decorate**.

### 3.1 Lịch mờ để canh vị trí

- [ ] Vào Decorate khi **Show calendar** đang tắt: lịch vẫn hiện nhưng **mờ** (khoảng 30%), đủ để canh chỗ đặt sticker.
- [ ] Bật Show calendar → lịch **đậm** như thật, toast **"Calendar shown"**. Tắt → mờ lại, toast **"Calendar faded"**.
- [ ] Kiểm lịch mờ trên nền tối, nền sáng và ảnh nhiều chi tiết: vẫn nhìn ra để canh.
- [ ] Nút này chỉ đổi **preview trong Decorate**: lưu xong, hình nền thật vẫn có lịch như design.

### 3.2 Kéo sticker

- [ ] Kéo nhanh một sticker: sticker **đuổi theo ngón tay** với độ trễ nhẹ (khoảng 0,2 giây). Dừng tay thì sticker trôi tới đúng chỗ ngón tay. Không giật, không văng quá.
- [ ] Sticker nhỏ, kéo nhanh: vẫn thấy sticker đang ở đâu.
- [ ] Bật **Reduce Motion** (Settings → Accessibility → Motion): sticker bám sát ngón tay, không trễ.
- [ ] Đường canh giữa vẫn hiện khi kéo vào chính giữa.

### 3.3 Kéo vào thùng rác để xoá

- [ ] Bắt đầu kéo một item: **thùng rác tròn** hiện ở đáy màn hình. Thả tay thì nó ẩn.
- [ ] Kéo lại gần: thùng rác **to dần** theo khoảng cách, chưa cần chạm tới.
- [ ] Đè lên thùng rác: chuyển **đỏ**, nảy to hơn và **rung nhẹ** một cái. Kéo ra lại thì về bình thường.
- [ ] Thả tay khi đang đè: item bị xoá. Bấm **Undo** một lần: item quay lại đúng chỗ cũ.
- [ ] Thả tay ngoài thùng rác: item nằm ở chỗ mới, không bị xoá.
- [ ] Đang kéo mà bị ngắt (kéo Notification Center hoặc Control Center xuống, có cuộc gọi đến): thùng rác **biến mất**, không kẹt lại trên màn.
- [ ] Làm được với chữ, emoji, ảnh, cutout, và sticker của template (mục 3.6).
- [ ] Thanh nút (pill) trên item đang chọn **không còn nút xoá**. Xoá vẫn còn trong sheet cài đặt (thùng rác góc phải).

### 3.4 Sheet cài đặt của item

Mở: chọn item, rồi chạm vào nó lần nữa (hoặc nút cài đặt trên pill).

- [ ] Sheet là **một thẻ**, mỗi hàng có tên bên trái, điều khiển bên phải, có đường kẻ giữa các hàng (giống sheet cài đặt của component). Thứ tự: **Anchored to** (chỉ khi design có component), **Opacity**, **Flip & rotate**, **Arrange**.
- [ ] Sheet cao vừa nội dung, không thừa khoảng trống phía dưới.
- [ ] **Flip & rotate**, 5 nút:
  - lật ngang (soi gương trái/phải; bấm lần nữa thì trở lại);
  - lật dọc (lộn ngược);
  - xoay trái 90°, xoay phải 90°;
  - **Reset**: thẳng lại 0° và bỏ lật, giữ nguyên vị trí, cỡ, opacity.
- [ ] **Undo** sau mỗi thao tác trên quay lại đúng bước trước.
- [ ] **Arrange**, 2 nút: chồng hai item lên nhau; nút **đưa lên trên cùng** đặt item lên trên, nút **đưa xuống dưới cùng** đặt xuống dưới. Sheet **không đóng** khi bấm.
- [ ] Item đã lật hoặc xoay: lưu, set hình nền → lock screen hiện đúng như trong Decorate. Mở lại design: vẫn giữ.

### 3.5 Duplicate

- [ ] Pill trên item đang chọn có nút **Duplicate**: bản sao nằm lệch xuống dưới bên phải một chút, **nằm trên** bản gốc, và được **chọn sẵn**. Giữ nguyên cỡ, xoay, lật, opacity.
- [ ] **Undo** một lần: bản sao biến mất.

### 3.6 Sticker của template

Cách có sticker của template: thêm một emoji → sheet cài đặt → **Anchored to** → chọn một component. Item thành sticker của component đó, đi theo component. (Hoặc dùng template trên catalog đã có sẵn sticker.)

- [ ] Kéo vào thùng rác: xoá được, Undo lấy lại được.
- [ ] Duplicate trên pill: bản sao vẫn thuộc cùng component.
- [ ] Sheet cài đặt: **Flip & rotate** và **Arrange** chạy như mục 3.4; bấm Arrange **không** đóng sheet.
- [ ] Lật sticker → lưu → set hình nền: lock screen hiện bản lật.

### 3.7 Ngôn ngữ và VoiceOver

- [ ] Đổi ngôn ngữ (vd. Tiếng Việt, Deutsch, Arabic): toast "Calendar faded" / "Calendar shown" và tên hàng "Flip & rotate", "Arrange" đã dịch, không bị cắt chữ. Arabic: hàng xếp từ phải sang trái.
- [ ] Bật VoiceOver: 7 nút icon trong sheet đọc đúng tên (Flip horizontal, Flip vertical, Rotate left, Rotate right, Reset, Bring to front, Send to back).

---

## 4. Shortcut: báo "không tìm thấy" nhầm (#409)

**Lỗi cũ:** sau khi update lên 1.2.20, shortcut **V2** ("Ink Refresh Lock Screen V2") vẫn chạy bình thường, nhưng bấm Set thì app báo không tìm thấy shortcut và hướng dẫn thêm lại. Thêm lại thì thư viện có **hai** V2.
Nguyên nhân: app vẫn nhớ tên shortcut cũ **V1** ("Ink Refresh Lock Screen") và gọi V1, trong khi user đã xoá V1.

**Bản này:**
1. Shortcut chạy xong thì app ghi đúng tên vừa chạy.
2. Tên cũ không còn thì app tự chạy V2 một lần.
3. Không tìm thấy thật thì hiện **popup** (thay cho toast) có nút **Add again**.

**Chuẩn bị:** máy thật, bản Prod (TestFlight), chỉ cài một bản Ink. Một số mục cần bản cũ dùng V1: TestFlight → Ink → **Previous Builds** → một bản từ **1.2.12 đến 1.2.16**.

### 4.1 Máy đã dính lỗi tự chữa được

1. Cài một bản 1.2.12–1.2.16. Trong app, làm theo hướng dẫn thêm shortcut (bản này thêm V1). Set một hình nền, chạy được.
2. Mở app Shortcuts: thêm V2 bằng link Prod `https://www.icloud.com/shortcuts/dd5b40be467c4ed2aecd38316471b2d7`, rồi **xoá V1**.
3. Cập nhật Ink lên bản mới (TestFlight).
4. Set một hình nền, chọn Home Screen **"Don't change"**.

- [ ] Shortcuts mở, quay lại Ink, rồi **mở thêm lần nữa** (lần này chạy V2) → lock screen đổi. **Không** có popup hay toast lỗi.
- [ ] Thư viện Shortcuts chỉ có **một** "Ink Refresh Lock Screen V2", không có bản "… 1".
- [ ] Set lần nữa: Shortcuts chỉ mở **một lần**.
- [ ] Set với Home Screen mode khác "Don't change": **không** còn sheet mời lấy shortcut mới.
- [ ] Làm lại 1–3 nhưng ở bước 2 xoá **cả V2**, rồi Set: Shortcuts mở **hai lần**, sau đó popup "Shortcut not found" hiện (mục 4.3). Hai lần mở là chấp nhận được.

### 4.2 Luồng cập nhật V1 → V2 không còn sinh lỗi

1. Cài một bản 1.2.12–1.2.16 và thêm V1 như bước 1 ở trên, rồi cập nhật thẳng lên bản mới.
2. Set với Home Screen mode khác "Don't change" → sheet mời lấy shortcut mới → **Get the new shortcut** → thêm V2, cho chạy thử.
3. Chạy thử xong thì **đóng luồng giữa chừng** (trước bước xoá shortcut cũ). Tự vào app Shortcuts xoá V1.

- [ ] Set: chạy thẳng V2 (Shortcuts mở **một lần**), lock screen đổi, không popup, không có shortcut trùng.
- [ ] Làm lại, lần này đi **hết** luồng (gồm bước xoá V1): Set chạy V2 bình thường.

### 4.3 Không tìm thấy thật: popup "Shortcut not found"

1. Máy đang chạy V2 bình thường. Vào app Shortcuts xoá V2.
2. Mở Customize một design → **Set**.

- [ ] Shortcuts mở rồi quay về Ink. Popup **"Shortcut not found"** hiện **đè lên màn Customize**, ghi: "Ink's shortcut may have been deleted or renamed. Add it again to keep your Lock Screen updating." Hai nút **Add again** và **Not now**. Không còn toast cũ.
- [ ] **Add again** → mở hướng dẫn thêm shortcut. Thêm xong → Set chạy được; thư viện chỉ có một V2.
- [ ] **Not now** → popup đóng. Set lần sau: app coi như chưa có shortcut và đi theo luồng thêm shortcut như máy mới.
- [ ] Dừng shortcut giữa chừng trong Shortcuts (bấm Cancel / ✕) khi V2 **vẫn còn**: **không** hiện popup.
- [ ] Popup **không** hiện khi đang ở trong hướng dẫn thêm shortcut; luồng đó có câu báo lỗi riêng.
- [ ] Đổi ngôn ngữ: tiêu đề, nội dung và hai nút của popup đã dịch, không bị cắt chữ.

### 4.4 Tắt callback bằng Remote Config (bản dev)

Máy chỉ cài Ink Dev. Project dev: `wallpaper_shortcut_run_mode` = `plain`, rồi tắt hẳn app mở lại.

- [ ] Xoá V2 → Set → Shortcuts báo lỗi và **không** tự quay về Ink → tự mở lại Ink: popup "Shortcut not found" vẫn hiện.
- [ ] Ở chế độ này **không có** bước tự chạy V2 của mục 4.1. Đúng thiết kế.
- [ ] Trả `wallpaper_shortcut_run_mode` về như cũ sau khi test.

---

## Đã biết

- Tool tạo template trên web (Studio) **chưa hỗ trợ lật** sticker. Sticker lật trong app, nếu template đó mở bằng Studio, sẽ hiện không lật.
- Design có item lật, mở trên bản app **cũ hơn 1.2.21**: item hiện không lật. Những thứ khác vẫn đúng.
