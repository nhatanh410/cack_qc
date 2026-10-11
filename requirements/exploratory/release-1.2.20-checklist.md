# Checklist nhanh — Ink 1.2.20 (PR #394 + #397/#398/#399)

> Rút gọn từ 3 nguồn: `ink-1.2.20-vi.md`, `QC-merge PR #394 vào main.md`, `in-app-messages.md`.
> Đây là checklist tự check, không phải test plan ISTQB. Chi tiết từng bước xem file nguồn.
> Máy: iPhone thật iOS 26 + iOS 27 (+ iOS 17/18 cho bóng đổ), Light/Dark, vi/en/ar.

## 🔴 P0 — Ảnh nền không bị xoá nhầm (#394)
- [ ] Chọn ảnh thư viện → lưu → Update; chỉnh ngày máy +2 ngày; kill/mở 3 lần → ảnh còn nguyên (editor + màn khoá)
- [ ] Bộ 3 ảnh xoay ngày: đủ 3 ảnh · ảnh crop: đúng khung · sticker Decorate: còn
- [ ] Home Screen / note / wallpaper đã lưu có ảnh riêng: còn
- [ ] Ảnh đã bỏ chọn được dọn (Console: `AssetSweep`, `deleted 0 photo`)
- [ ] Nhớ trả giờ máy về tự động

## 🔴 P0 — Nhắc chọn lại ảnh bị mất (#397)
- [ ] Ảnh riêng bị mất → mở app (không phải lần đầu) → popup hiện; **Pick a photo** → editor, tab Background
- [ ] Chưa có wallpaper hiện tại → dừng ở Discover, không lỗi
- [ ] Chọn ảnh mới → popup không hiện lại · ảnh catalog mất → KHÔNG nhắc
- [ ] Home Screen chế độ ảnh riêng mà mất ảnh → chạy shortcut: chỉ Lock đổi
- [ ] Tối đa 1 lần/ngày, không hiện ở lần mở đầu

## 🟠 Default tab + tour (#394/1.2.20)
- [ ] Máy mới: Discover; menu có Most used/Discover/Calendar/Tasks/Notes/Assistant, icon + dấu tích
- [ ] Chọn từng tab → kill/mở → vào đúng tab; icon Assistant đúng cỡ; "Most used" gọn 1 dòng
- [ ] Most used: <10 lần bấm → Discover; ≥10 → tab nhiều nhất; hoà → tab bên trái
- [ ] Chỉ đếm bấm tab bar (push, Quick Action, link, "Ask Ink AI" không đếm)
- [ ] Tour: vòng sáng đúng nút tab (cả 5 tab, cả RTL); Start here → set Default tab; Not now → không hỏi lại tab đó
- [ ] Chạm vùng tối = Not now · tối đa 1 lần/lần mở · đã tự chọn Default tab → không hỏi nữa
- [ ] Tour không hiện khi có paywall/Settings/sheet/tour Discover che
- [ ] Tour thật (bấm 10 lần, không dùng Debug) — Debug bỏ qua điều kiện
- [ ] Update từ bản cũ: vào Discover, không mất dữ liệu

## 🟠 Onboarding (#394/#398)
- [ ] Splash: logo nhỏ + tên sản phẩm · bước 1–4: chuyển động, số đếm, gạch chân (Light/Dark)
- [ ] Bước 3 tường mockup đọc rõ chữ · bước 4 thẻ không bị CTA che
- [ ] Preview: 3 template, card đầu sát lề trái, đứng yên ~1,5s rồi trôi; vuốt tay → đi theo, thả → trôi tiếp
- [ ] Đi chậm / quay lại bước trước → vẫn bắt đầu từ card đầu
- [ ] Reduce Motion: đi hết được · Arabic RTL không vỡ · máy cũ không giật/nóng

## 🟠 Nút glass + nút phụ (#394/#399)
- [ ] Delete/Edit ở Event/Task/Template: glass, đúng chức năng, Delete vẫn hỏi xác nhận
- [ ] Empty state (Calendar, Tasks, Notes, Assistant/Help, Discover, lịch chia sẻ, import, template chia sẻ): nút đúng chữ, bấm được
- [ ] Nút Update đọc rõ mọi wallpaper · bóng: CÓ ở iOS 17/18, KHÔNG ở iOS 26
- [ ] Nút phụ: Light xám nhẹ, Dark xám tối chữ sáng (không trùng nút chính); Save as task trong card: trắng phẳng
- [ ] Nút Crop, Next/Got it/Start here: trắng chữ đen ở cả 2 mode
- [ ] Discover cuộn mượt trên máy thật; bóng Your collection còn; gợi ý khoá tắt khi tự cuộn, không tắt khi tour tự cuộn

## 🟡 Tasks matrix picker (#394)
- [ ] Lưới 3 cột đúng tỉ lệ; Pro có tag → chưa Pro ra paywall; chọn ô → áp đúng; đóng không đổi gì; SE/mini + Dynamic Type lớn không vỡ

## 🟡 Share template QR (#394)
- [ ] Thẻ QR có đúng thumbnail; quét máy khác mở đúng template; ảnh xuất không bị cắt; QR lịch chia sẻ không lẫn thumbnail

## 🟡 Calendar title + hồi quy lịch phụ (#394)
- [ ] Day/Week: tháng đậm + năm nhạt, không dấu phẩy · Month: chỉ năm đậm · đổi tháng → tiêu đề đổi theo
- [ ] VoiceOver đọc "Oct 2026" · vi/en/ar không cắt
- [ ] Lịch phụ (7 loại): picker, ngày âm ở tuần/tháng, công tắc, bộ chọn tháng, Home, Daily page, mặc định theo vùng

## 🟡 Hồi quy chung
- [ ] CRUD event + task · tạo/lưu/Update wallpaper bằng shortcut · paywall Pro · lịch chia sẻ · mở lạnh nhanh, kill/mở nhiều lần không crash

---

## ⚠️ Điểm cần xác nhận với dev/PM (phát hiện khi đối chiếu)
1. **Máy test lệch nhau:** #394 yêu cầu iOS 26 + iOS 17/18; 1.2.20 yêu cầu iOS 26 + iOS 27. Bóng đổ chỉ có ở iOS <26, iOS 27 chưa được #394 nhắc. → Cần cả iOS 17/18, 26, 27?
2. **Số ngôn ngữ:** 1.2.20 §5 ghi popup dịch "17 ngôn ngữ", runbook IAM ghi "12 languages". Con số nào đúng?
3. **Cách tạo "ảnh bị mất" trên máy thật:** runbook chỉ có script cho simulator (sửa plist), trong khi P0 #394 nói simulator không tái hiện được. Cần cách tái hiện trên máy thật (gợi ý chưa xác nhận: cài rc6 → mất ảnh → update lên bản mới).
4. **Thứ tự ưu tiên giữa tour Default tab và IAM:** chuỗi foreground trong runbook (proposal → push → IAM → rating) không nhắc tour tab. Nếu cùng đủ điều kiện thì cái nào hiện trước/cùng lúc?
5. **Phạm vi IAM shortcut-update:** runbook có checklist riêng (update_home_screen, update_ios27, remove_old) nhưng không nằm trong danh sách thay đổi 1.2.20. Có cần test lần này không, hay chỉ hồi quy?
6. **Số build:** #394 nói "TestFlight kế tiếp từ c426ddbb"; 1.2.20 nói "bản dev Firebase". Xác nhận build nào là test basis.
