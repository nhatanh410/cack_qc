# Checklist nhanh — Ink 1.2.21 (PR #405 + #408 + #409)

> Rút gọn từ 1 nguồn: `paywall-components-decorate-shortcut-vi.md`. Chi tiết từng bước xem file nguồn.
> Đây là checklist tự check, không phải test plan ISTQB. Không có wireframe/ảnh cho UI mới của bản này.
> Máy: iOS 27 + iOS 26, Light/Dark. Phần 1–3 dùng bản dev (Debug → Grant/Revoke Pro). Phần Pro hết hạn cần Sandbox thật. Phần Shortcut cần máy thật, bản Prod, chỉ cài một bản Ink.
> "Mở app" = tắt hẳn rồi mở lại.

## 🔴 P0 — User Pro không bị hiện paywall nhầm (#405)
- [ ] Sandbox, mua gói tuần (tự gia hạn ~3 phút) → nền ~10 phút → mở lại → thêm ảnh nền thứ 4: không paywall
- [ ] Tắt hẳn, đợi qua 1 lần gia hạn → mở app: không paywall (splash có thể đứng tới ~3s, đúng thiết kế)
- [ ] Font Pro, component Pro, Home Screen modes: không vương miện, không hỏi Pro
- [ ] Máy khoá qua đêm (bật Background App Refresh) → sáng mở app: không paywall
- [ ] Huỷ gói, qua kỳ gia hạn cuối → mở app: thành Free, paywall hiện, ảnh nền thứ 4 bị chặn
- [ ] Mua mới trên paywall: đóng paywall, mở khoá ngay · Restore purchases: vẫn Pro

## 🔴 P0 — Shortcut "không tìm thấy" nhầm (#409)
- [ ] Máy từ 1.2.12–1.2.16 (có V1), thêm V2, xoá V1, update, Set + Home Screen "Don't change": Shortcuts mở rồi mở thêm lần nữa → lock screen đổi, không popup/toast lỗi
- [ ] Thư viện Shortcuts chỉ có 1 "Ink Refresh Lock Screen V2" (không có bản "… 1")
- [ ] Set lần nữa: Shortcuts mở 1 lần · Home Screen mode khác "Don't change": không còn sheet mời lấy shortcut mới
- [ ] Xoá cả V1 lẫn V2 rồi Set: Shortcuts mở 2 lần → popup "Shortcut not found" (chấp nhận)
- [ ] Luồng V1→V2: Get the new shortcut, đóng giữa chừng, tự xoá V1 → Set chạy thẳng V2, không popup, không trùng. Đi hết luồng cũng chạy bình thường
- [ ] Popup "Shortcut not found": hiện đè Customize, đúng nội dung, 2 nút Add again / Not now, không còn toast cũ
- [ ] Add again → hướng dẫn thêm → Set chạy, thư viện 1 bản V2 · Not now → Set sau đi luồng như máy mới
- [ ] Cancel/✕ trong Shortcuts khi V2 còn: không popup · popup không hiện trong hướng dẫn thêm shortcut
- [ ] Remote Config `wallpaper_shortcut_run_mode=plain` (dev): xoá V2 → Set → Shortcuts báo lỗi, tự mở lại Ink, popup vẫn hiện, không có bước tự chạy V2. Trả key về cũ sau test

## 🟠 Component Pro trong Customize (#408)
- [ ] Free: nút + có đúng 13 loại Pro có vương miện (Daily page, Month heatmap, Lunar calendar, Timetable, Week schedule, Today at a glance, Event tickets, Hour timeline, Week events, Activity grid, Workout, Priority matrix, Milestones); loại khác và Row/Column không có
- [ ] Thêm loại Pro: thêm và chỉnh được · bấm ✓ → "Keep your Pro picks?" liệt kê đúng component vừa thêm
- [ ] Unlock Pro → paywall · Set without Pro → hình nền không có component Pro đó
- [ ] Template vốn có component Pro, không thêm gì → ✓: không bị hỏi
- [ ] Giới hạn: template 1 component → thêm thứ 2 được, thứ 3 → "Component limit reached" ("holds 2"), Go Pro → paywall
- [ ] Template vốn 3 component: mở bình thường, đổi loại được, thêm thứ 4 → "holds 3"
- [ ] Row/Column không tính giới hạn · user Pro: không vương miện, không popup, không giới hạn
- [ ] Update từ bản cũ: design Your collection từng thêm component nay là Pro → set lại bị hỏi; design chỉ có component gốc → không hỏi
- [ ] Remote Config `template_editor_config` (tắt/mở app sau mỗi lần sửa): `{"max_components_free":3,"pro_component_types":["workout"]}` · `{"pro_component_types":[]}` · xoá 2 field → về 13 loại + giới hạn 2 · `max_uploads_free` vẫn chạy

## 🟠 Decorate: lịch mờ + kéo sticker + thùng rác (#408)
- [ ] Vào Decorate khi Show calendar tắt: lịch mờ (~30%) · bật → đậm + toast "Calendar shown" · tắt → toast "Calendar faded"
- [ ] Lịch mờ vẫn nhìn ra trên nền tối, sáng, ảnh nhiều chi tiết · lưu xong hình nền thật vẫn có lịch như design
- [ ] Kéo nhanh: sticker đuổi theo ngón tay trễ ~0,2s, không giật/văng · sticker nhỏ vẫn thấy · đường canh giữa vẫn hiện
- [ ] Reduce Motion bật: sticker bám sát, không trễ
- [ ] Thùng rác tròn hiện ở đáy khi kéo, ẩn khi thả · to dần khi lại gần · đè lên: đỏ, nảy, rung nhẹ 1 lần, kéo ra về bình thường
- [ ] Thả khi đang đè: xoá, Undo 1 lần quay lại đúng chỗ · thả ngoài: không xoá
- [ ] Kéo bị ngắt (Notification/Control Center, cuộc gọi): thùng rác biến mất, không kẹt
- [ ] Làm được với chữ, emoji, ảnh, cutout, sticker của template · pill không còn nút xoá, xoá còn trong sheet cài đặt

## 🟠 Decorate: sheet cài đặt + Duplicate (#408)
- [ ] Sheet là 1 thẻ, thứ tự Anchored to (chỉ khi có component) · Opacity · Flip & rotate · Arrange · cao vừa nội dung
- [ ] Flip & rotate: lật ngang (bấm lại trở lại), lật dọc, xoay trái/phải 90°, Reset (0° + bỏ lật, giữ vị trí/cỡ/opacity) · Undo mỗi thao tác đúng 1 bước
- [ ] Arrange: đưa lên trên cùng / dưới cùng đúng, sheet không đóng khi bấm
- [ ] Item lật/xoay: lưu, set → lock screen đúng như Decorate · mở lại design vẫn giữ
- [ ] Duplicate trên pill: bản sao lệch xuống dưới phải, nằm trên bản gốc, được chọn sẵn, giữ cỡ/xoay/lật/opacity · Undo 1 lần mất bản sao
- [ ] Sticker của template (Anchored to một component): thùng rác + Undo, Duplicate vẫn thuộc cùng component, Flip/Arrange như trên, lật → lưu → lock screen hiện bản lật

## 🟡 Ngôn ngữ + VoiceOver
- [ ] vi / de / ar: toast "Calendar faded/shown", hàng "Flip & rotate", "Arrange" đã dịch, không cắt chữ · Arabic hàng xếp phải sang trái
- [ ] Popup "Shortcut not found" (tiêu đề, nội dung, 2 nút) đã dịch, không cắt chữ
- [ ] VoiceOver đọc đúng 7 nút: Flip horizontal, Flip vertical, Rotate left, Rotate right, Reset, Bring to front, Send to back

## 🟡 Đã biết (không log thành bug)
- Studio (web) chưa hỗ trợ lật sticker: sticker lật trong app, mở bằng Studio sẽ hiện không lật
- Design có item lật mở trên app cũ hơn 1.2.21: item hiện không lật, phần còn lại đúng

## 🟡 Hồi quy chung
- [ ] Customize: thêm/xoá/sắp xếp component, Layers, Undo/Redo, lưu · tạo/Update wallpaper bằng shortcut · Your collection · paywall Pro · mở lạnh, kill/mở nhiều lần không crash
