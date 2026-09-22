# Bàn giao QC — Decorate + Ink AI

Branch `feat/background-decoration` · commit `7d9a934a` (đã merge `main` tới PR #185)

Hai mảng cần test:

1. **Editor trang trí wallpaper** (mới) — vẽ tay, chữ, emoji, ảnh, tách nền.
2. **Tab Ink AI** — thay gần hết phần UI, logic trả lời giữ nguyên.

---

## 1. Môi trường test

| Máy | Bắt buộc | Lý do |
|---|---|---|
| iPhone **iOS 26.x** | ✅ | Có 1 lỗi đã biết chỉ xảy ra trên iOS 26 (mục 6) |
| iPhone **iOS 18.x** | Nếu có | Đối chiếu với iOS 26 |
| **iPad** (cả dọc + ngang) | ✅ | Vừa fix lỗi toạ độ khi xoay ngang |

Đường vào: **Wallpaper editor → nút “Decorate”** (chip kính trên header).

---

## 2. Decorate — checklist chức năng

### 2.1 Thanh công cụ
- [ ] Toggle **Lock screen** — bật/tắt preview đồng hồ + nút màn hình khoá
- [ ] Toggle **Show calendar** — bật/tắt preview lịch
- [ ] **Draw** (bút), **Text**, **Emoji**
- [ ] Menu ảnh: **Photo** và **Cutout** (tách chủ thể khỏi ảnh)

### 2.2 Bút vẽ
- [ ] 4 loại nét: **Pen · Marker · Highlighter · Dotted** — mỗi loại nhìn phải khác nhau
- [ ] Thanh **brush size** đổi độ dày nét
- [ ] Chọn màu + **eyedropper** (hút màu từ canvas)
- [ ] **Eraser** — tẩy đúng phần nét dưới ngón tay, không xoá cả nét

### 2.3 Sticker (chữ / emoji / ảnh)
- [ ] Chạm 1 lần = chọn; chạm lần 2 vào item đang chọn = mở sheet cài đặt
- [ ] Kéo di chuyển, có **đường canh giữa** khi vào chính giữa
- [ ] Pinch phóng to / thu nhỏ, xoay 2 ngón
- [ ] Nút **✕** góc trên phải = xoá; **handle** góc dưới phải = vừa scale vừa xoay
- [ ] Sheet cài đặt: đổi **opacity**, xoá

### 2.4 Emoji picker
- [ ] 7 nhóm: Smileys · Hearts · Animals · Nature · Food · Travel · Objects
- [ ] Tên nhóm trên tiêu đề sheet đổi theo nhóm đang xem khi cuộn

### 2.5 Lưu / huỷ
- [ ] **✓** lưu → wallpaper thật phải có đúng phần trang trí vừa làm
- [ ] **✕** khi có thay đổi → hiện popup *“Discard changes?”* với 2 nút **Discard** / **Keep editing**
- [ ] Chọn **Discard** → mất hết trang trí; **Keep editing** → ở lại editor

---

## 3. Ink AI — phần UI đổi mới

Tab **Ink AI** thay gần hết phần vỏ. Logic trả lời không đổi.

### 3.1 Header
- [ ] Giữa header là công tắc **Assist / How to** (nền kính, co theo chữ) — gạt qua lại **không mất** nội dung chat
- [ ] Nút **ngôn ngữ nói**: icon là **lá cờ** của ngôn ngữ đang chọn; bấm ra menu, mỗi dòng có cờ + tên
- [ ] Nút **Clear chat** nằm chung một viên kính với nút cờ, có vạch ngăn ở giữa
- [ ] ⚠️ Clear chat **không có undo** — soi kỹ xem có dễ bấm nhầm sang nút cờ bên cạnh không

### 3.2 Thanh trên / dưới trong suốt
- [ ] Cuộn hội thoại: nội dung **chui xuống dưới** header và ô nhập rồi mờ dần, không bị cắt ngang bởi vạch kẻ
- [ ] Đúng ở **cả 2 mode**, cả mép trên lẫn mép dưới

### 3.3 Ô nhập
- [ ] Ô nhập nền kính, nổi đè lên hội thoại
- [ ] Chạm vào ô → ô **mở ra 2 dòng** ngay, chữ **không bị nhảy** vị trí
- [ ] Gõ dài → ô cao dần, **tối đa 4 dòng**; nút mic/gửi vẫn nằm góc dưới
- [ ] Nút **mic**: lúc nghỉ chỉ có icon, **đang thu thì thành hình tròn đặc**
- [ ] Ngôn ngữ máy mà Apple không hỗ trợ đọc → nút mic **ẩn hẳn** (không phải làm mờ)
- [ ] Gõ quá giới hạn ký tự → hiện dòng đếm màu đỏ phía trên ô
- [ ] **Chạm ra ngoài để tắt bàn phím** — test cả khi hội thoại **đang trống**, không chỉ khi đã có nội dung để cuộn

### 3.4 Tự cuộn xuống tin mới (merge từ PR #185)
- [ ] Gửi 1 câu dài (nhiều thẻ sự kiện) → transcript **tự cuộn xuống hết**, không dừng nửa chừng
- [ ] Gạt **Assist ↔ How to** khi cả 2 mode đã có hội thoại → mở ra ở **tin mới nhất**, không nhảy về tin cũ nhất

### 3.5 Gợi ý & lúc chờ
- [ ] Màn hình trống Assist: tiêu đề **"What's the plan?"** + dãy chip gợi ý
- [ ] **Vuốt dãy chip sang phải** → hiện ✕ → bấm ✕ thì ẩn gợi ý cho hết hội thoại đó
- [ ] Bấm ✕ phải **ăn ngay lần đầu** (không bị hiểu nhầm thành đóng vuốt)
- [ ] Lúc chờ trả lời: 3 chấm chạy + câu đổi dần **"Reading that…" → "Picking out the details…" → "Still going…"**, rồi **dừng** ở câu cuối (không lặp lại từ đầu)

### 3.6 Sheet quyền riêng tư
- [ ] Lần đầu bật Ink AI: sheet **"Before we start"** với 2 mục *What gets sent* / *What stays on this device*
- [ ] Hai nút **Turn on Ink AI** / **Not now**
- [ ] Chỉ còn **1 sheet dùng chung cho cả 2 mode** — chuyển sang How to **không hỏi lại**

### 3.7 Bong bóng chat & thẻ kết quả
- [ ] Tin người dùng: nền **tím**, chữ trắng, **bên phải**, rộng tối đa ~80% — câu ngắn phải ra bong bóng **ngắn**, không kéo dài hết dòng
- [ ] Trả lời của Ink: nền **xám**, bên trái; các thẻ sự kiện nằm gọn trong cùng khối xám
- [ ] Thẻ sự kiện: đổi lịch đích bằng chip, lịch đang chọn có **dấu tích**
- [ ] Nhiều sự kiện → nút **"Apply all (n)"**
- [ ] Mất mạng → *"You're offline. Your text is saved."*; quá lâu → *"That took too long."*

### 3.8 Trả lời chip ngay trên máy (merge từ `main`)
- [ ] Gõ **đúng nguyên văn tiêu đề một chip** (vd *Today's schedule*) rồi gửi → máy tự trả lời, **không trừ lượt** quota

---

## 4. Regression — vừa fix, test kỹ

Đây là các lỗi vừa được sửa trong commit `6d6d7088`. Ưu tiên cao nhất.

| # | Thao tác | Kỳ vọng |
|---|---|---|
| R1 | Chọn sticker → kéo **handle góc** để resize → thả tay | Thanh header (✕ / Undo / Redo / ✓) và thanh công cụ **hiện lại** và bấm được. *(Trước đây mất luôn, kẹt cứng)* |
| R2 | Vẽ 1 nét → **Undo** → chạm vào 1 sticker để chọn | Nút **Redo** vẫn còn sáng, bấm được |
| R3 | Chọn **Eraser** → chạm/quẹt vào **chỗ trống** (không có nét nào) | Không tạo thêm bước Undo thừa; Redo không bị mất |
| R4 | Mở sheet cài đặt của 1 sticker → bấm **xoá** → bấm **Undo** 1 lần | Sticker quay lại ngay lần bấm đầu tiên |
| R5 | Thêm 1 **sticker ảnh** → bật **eyedropper** → rê lên đúng sticker đó | Bút lấy **màu của ảnh**, không phải màu wallpaper phía sau |
| R6 | Vẽ liên tục **hơn 50 nét** ngắn | Hiện thông báo hết chỗ, các nét cũ **không bị mất** |
| R7 | Đang cầm **bút**, vẽ một đường **đè ngang qua** sticker | Nét vẽ được bình thường, sticker **không bị kéo theo** |
| R8 | **iPad xoay ngang** → đặt sticker gần mép trên → lưu → xem wallpaper thật | Sticker nằm **đúng chỗ** đã đặt |

---

## 5. Ngôn ngữ

35 chuỗi mới đã dịch đủ **10 ngôn ngữ** (vi, ja, ko, es, pt, zh, zh-Hant, th, ms, id).

- [ ] Đổi ngôn ngữ máy sang **vi / ja / ko / zh / th** → mở editor Decorate
- [ ] Toàn bộ tên công cụ, tên nhóm emoji, popup Discard **không còn tiếng Anh**
- [ ] Tab **Ink AI**: màn hình trống, sheet quyền riêng tư, dòng “đang xử lý” cũng đã dịch
- [ ] ⚠️ Tên shortcut **“Generate Latest Wallpaper”** phải **giữ nguyên tiếng Anh** ở mọi ngôn ngữ

---

## 6. Lỗi đã biết — KHÔNG cần report

**Emoji bị nhỏ và lệch trên iOS 26.**

Trên iOS 26, emoji đặt vào wallpaper render ra **nhỏ khoảng 1/3** kích thước đúng và **lệch sang trái**. Trong editor nhìn vẫn bình thường — chỉ sai ở wallpaper đã lưu. iOS 18 không bị.

Nguyên nhân đã xác định (iOS 26 đo chiều rộng emoji khác hẳn iOS 18), **chưa fix**. Có 2 unit test đang đỏ để giữ lỗi này ở trạng thái nhìn thấy được.

→ QC ghi nhận nếu thấy, nhưng **không tính là bug mới**.

---

## 7. Lưu ý khi chạy test tự động

Unit test phải chạy trên simulator **iOS 18.x** (theo `CLAUDE.md`). Chạy trên iOS 26 sẽ:
- **skip** 39 golden test của wallpaper, và
- **fail** 2 test emoji ở mục 6.
