> ⚠️ **SUPERSEDED — không dùng tài liệu này làm test basis.** Dev xác nhận bản này có sai sót và đã bàn giao
> lại bằng [qc-shortcut-home-screen-ios26-27-V2.md](qc-shortcut-home-screen-ios26-27-V2.md) — **nguồn sự thật
> duy nhất** cho flow này. File `.shortcut` đi kèm bản V1 (từng ở `test-data/ink-shortcut-final/`) cũng đã bị
> thay bằng file mới đúng (kích thước/checksum khác hẳn) — bản cũ hiện nằm ở
> `test-data/ink-shortcut-final-v1-superseded/`, chỉ giữ để đối chiếu lịch sử, **không cài lên máy test**.
> Giữ file này lại chỉ để biết **đã sai chỗ nào** — xem đối chiếu đầy đủ ở
> [test-plan-ios26-27.md § V2 thay thế V1](../../test-plans/shortcut/test-plan-ios26-27.md#v2-thay-thế-v1--các-sai-sót-đã-sửa-bổ-sung-2026-09-21).
>
> **Các sai sót đã biết (V1 → V2):**
> - Số action "Set Wallpaper": ghi nhầm **6** (thật ra **5** — 1 cho Lock, 4 cho Home) và **bỏ sót hẳn** action
>   "Switch Between Wallpapers" — chính action này quyết định hành vi cặp wallpaper ở mục 7.
> - Mục 7 (cặp wallpaper): V1 liệt là "chưa ai biết trước kết quả", V2 giải thích rõ cơ chế và **đảo ngược**
>   1 kết luận quan trọng — xem mục 12 hai bản đối lập nhau ở đúng điểm "tự chuyển cặp rồi bấm Update".
> - Mục 5 (vì sao Off không làm home đứng yên): lý do V1 đưa ra ("iOS tự ghép cặp lock+home") **sai** — lý do
>   thật là action Switch luôn kéo màn khoá về cặp của Ink, không liên quan cơ chế ghép cặp nào của iOS.

---

# Bàn giao QC — Shortcut wallpaper mới: Home Screen (iOS 26) và Automation (iOS 27) [V1 — SUPERSEDED]

Nhánh **`fix/ios27-shortcut-automation`** (commit `abcd305a`) · **chưa vào `main`** ·
test trên bản **Ink Dev** dựng từ nhánh này bằng Xcode, không phải bản TestFlight/App Store.

Bảy mảng cần test, xếp theo mức rủi ro giảm dần:

1. **Luồng set wallpaper cũ không được vỡ** — nút Set/Update, xác nhận đã set, shortcut bị xoá.
2. **Bốn chế độ Home Screen** — Off / Same / Photo only / Own photo, có và không có Blur.
3. **Own photo** — chọn ảnh riêng cho home, giữ qua các template.
4. **Cặp wallpaper** — shortcut ghi vào cặp nào trong thư viện wallpaper của iOS.
5. **Automation iOS 27** — automation Sunrise đi kèm shortcut, chạy khi máy khoá.
6. **Chéo phiên bản** — file iOS 27 cài lên iOS 26.
7. **Cảnh báo "Needs the new Ink shortcut"** trong editor.

> ⚠️ Mục 4, 5, 6 có phần **thăm dò**: chưa ai biết trước kết quả đúng. Ghi lại **chính xác**
> những gì thấy vào bảng ở mục 11 — kết quả đó quyết định thiết kế bản phát hành, nên
> "không chạy" cũng là một kết quả có giá trị.

---

## 1. File shortcut

Thư mục **`Ink Shortcut Final`** (lấy từ người bàn giao, gửi qua AirDrop):

```
iOS 26/Dev/Ink Refresh Lock Screen.shortcut     22 action, không có automation
iOS 26/Prod/Ink Refresh Lock Screen.shortcut
iOS 27/Dev/Ink Refresh Lock Screen.shortcut     22 action + automation Sunrise
iOS 27/Prod/Ink Refresh Lock Screen.shortcut
```

- **Dev / Prod** là bản app mà shortcut gọi tới. Máy cài **Ink Dev** thì dùng file trong
  `Dev/`. Cài nhầm bản thì các action của Ink hiện **màu đỏ** — do cài nhầm, không phải bug.
- **Bản Prod chưa test được**: bản Ink Prod trên store chưa có các action mới. Chỉ dùng
  `Dev/` trong đợt này.
- Để so sánh với hành vi cũ, **shortcut production hiện tại** cài từ link
  `https://www.icloud.com/shortcuts/199d89e6742143cea54c2f4bc2268fd2` — nó set cả lock lẫn
  home bằng một ảnh có lịch, kèm blur, và **không** hiểu các chế độ Home Screen.

---

## 2. Môi trường test

| Máy | Bắt buộc | Lý do |
|---|---|---|
| iPhone **iOS 26.x** | ✅ | Shortcut iOS 26 (mục 3–8) |
| iPhone **iOS 27** | ✅ | Shortcut iOS 27 có automation (mục 9) |
| Máy thứ hai, **Apple Account khác** | ✅ | Automation có đi theo khi cài trên máy người khác |
| iPad | Nếu có | Ảnh home trên màn vuông, xoay ngang/dọc |

**Chuẩn bị trên mỗi máy:** thư viện wallpaper (giữ tay trên màn khoá) có **ít nhất 3 cặp**,
trong đó ít nhất 1 cặp là **ảnh riêng của bạn** — để thấy rõ Ink có ghi đè lên nó không.

---

## 3. Cài shortcut và chuyển qua lại giữa nhiều shortcut

**Quy tắc duy nhất cần nhớ:** app chạy shortcut **theo tên**. Shortcut nào tên **đúng từng
ký tự** là `Ink Refresh Lock Screen` thì app chạy cái đó. Các shortcut khác tên không bị
đụng tới.

Vì vậy có thể **cài nhiều shortcut cùng lúc** và đổi qua lại bằng cách đổi tên, không cần
xoá rồi cài lại.

### 3.1 Cài lần đầu

1. Mở file bằng AirDrop → **Add Shortcut**. Shortcut được thêm với tên
   `Ink Refresh Lock Screen`.
2. Lần chạy đầu iOS hỏi quyền đặt wallpaper → chọn **Always Allow**.
3. **Chỉ iOS 27:** mở shortcut → **ⓘ → Privacy → bật "Allow Running When Locked"**.
   Cài đặt này **không** đi theo file.

- [ ] Mở shortcut: có đủ các khối **If / Otherwise** lồng nhau và **6 action
      "Set Wallpaper"**, không action nào hiện màu đỏ

### 3.2 Giữ nhiều shortcut, đổi bằng tên

Đặt tên các shortcut **không dùng** theo một quy ước dễ đọc, ví dụ:

| Tên trong app Shortcuts | Là gì |
|---|---|
| `Ink Refresh Lock Screen` | **Shortcut app đang chạy** — chỉ một cái được mang tên này |
| `Ink · Production` | Shortcut production cũ (link `199d89e6…`) |
| `Ink · iOS 26` | File `iOS 26/Dev` |
| `Ink · iOS 27` | File `iOS 27/Dev` |

**Đổi sang shortcut khác:**

1. Đổi tên shortcut đang mang tên `Ink Refresh Lock Screen` → tên của nó trong bảng
   (giữ tay trên shortcut → **Rename**).
2. Đổi tên shortcut muốn test → **`Ink Refresh Lock Screen`**.
3. Vào app bấm **Update** — app sẽ chạy shortcut vừa đổi tên.

**Cài thêm một file khi đã có shortcut tên `Ink Refresh Lock Screen`:** an toàn nhất là
**đổi tên shortcut đang có trước** (bước 1 ở trên), rồi mới cài file mới. Nếu cài luôn,
iOS có thể hỏi **thay thế** shortcut cũ hoặc thêm bản mới với số ở cuối
(`Ink Refresh Lock Screen 1`) — chọn giữ cả hai, rồi đổi tên theo bảng. Ghi lại iOS hỏi
kiểu nào vào mục 11.

**Ba điều dễ nhầm:**

- **Không bao giờ để hai shortcut cùng tên `Ink Refresh Lock Screen`.** App không chọn
  được cái nào, kết quả không đoán trước được.
- **Automation không theo tên.** Automation (iOS 26: trong tab Automation; iOS 27: nằm
  bên trong shortcut) gắn với **chính shortcut đó**, không phải với cái tên. Shortcut
  bị đổi tên vẫn chạy automation của nó. Trên iOS 27, **tắt automation Sunrise của các
  shortcut không dùng** (mở shortcut → Edit → Automation), nếu không sáng ra nhiều
  shortcut cùng chạy và ghi đè nhau.
- **Quyền "Always Allow" tính riêng từng shortcut.** Shortcut mới đổi tên sang lần đầu
  chạy có thể hỏi quyền lại — chọn Always Allow như bước 3.1.

- [ ] Sau khi đổi tên, bấm Update: đúng shortcut vừa đổi tên chạy (kiểm tra bằng chế độ
      Home Screen — shortcut production **không** làm theo chế độ, shortcut mới thì có)

---

## 4. Luồng set wallpaper cũ không được vỡ (mục rủi ro nhất)

Để chế độ Home Screen ở **Off** cho toàn bộ mục này.

- [ ] Discover → chọn một template → **Set as current** → shortcut chạy → lock screen đổi
      đúng template, app quay lại, template hiện nhãn đang dùng
- [ ] Mở template đang dùng → sửa gì đó → **Update** → lock screen đổi theo
- [ ] Lần chạy đầu, ở hộp thoại hỏi quyền chọn **Don't Allow** → mở lại app: app **không**
      được coi là đã set thành công (không hiện nhãn đang dùng cho template mới)
- [ ] Đổi tên shortcut `Ink Refresh Lock Screen` sang tên khác (coi như xoá) → bấm Set trong
      app → app phải nhận ra không còn shortcut và đưa vào luồng cài đặt, **không** kẹt
      ở màn Shortcuts. Đổi tên lại để tiếp tục.
- [ ] Spotlight: gõ "Ink" → **Refresh Lock Screen** → wallpaper đổi, **không** mở app
- [ ] Template **note** (Notes) và template **lịch** đều set được như trên

---

## 5. Bốn chế độ Home Screen

Đường vào: mở một template → editor → tab **Background** → mục **Home Screen** (dưới
phần ảnh nền). Chọn chế độ → bấm **Set as current / Update** để shortcut chạy.

| Chế độ | Blur | Lock screen | Home screen |
|---|---|---|---|
| **Off** (mặc định) | — | Wallpaper có lịch | **Không bị Ink set** (xem lưu ý bên dưới) |
| **Same** | Tắt | Wallpaper có lịch | **Cùng ảnh** có lịch, nét |
| **Same** | Bật | Wallpaper có lịch | Cùng ảnh có lịch, **mờ** |
| **Photo only** | Tắt | Wallpaper có lịch | **Ảnh nền của template, không có lịch**, không tối đi |
| **Photo only** | Bật | Wallpaper có lịch | Ảnh nền không lịch, **mờ** |
| **Own photo** | Tắt | Wallpaper có lịch | **Ảnh đã chọn** ở mục 6 |
| **Own photo** | Bật | Wallpaper có lịch | Ảnh đã chọn, **mờ** |

- [ ] Chạy đủ **7 dòng** của bảng trên, mỗi dòng xem cả lock và home
- [ ] Toggle **Blur Home Screen** chỉ hiện khi chế độ **khác Off**
- [ ] Lock screen **luôn nét** kể cả khi Blur bật
- [ ] Photo only: home **không bị tối** dù thanh **Darken** của lock kéo cao
- [ ] Template có **nhiều ảnh nền đổi theo ngày**: Photo only dùng đúng ảnh của **hôm nay**,
      trùng với ảnh dưới lịch trên lock
- [ ] Mỗi lần chạy Photo only / Own photo có **bị hỏi quyền 2 lần** không (có 2 action set
      wallpaper trong một lần chạy)? Ghi vào mục 11
- [ ] Đổi chế độ rồi bấm **✕ (Cancel)** thoát editor → mở lại: chế độ phải **quay về như
      trước khi mở** editor

> **Off không có nghĩa là home đứng yên — đây không phải bug.** iOS giữ lock và home
> thành một cặp. Nếu home đang **đi theo lock** (ví dụ shortcut production đã set cả hai
> màn bằng một ảnh), thì set lock xong iOS **tự đổi luôn home**. Chỉ sau một lần chạy
> Photo only / Own photo (set home riêng) thì Off mới để home yên. Shortcuts không có
> action nào tách hay nối lại cặp này.

---

## 6. Own photo — ảnh home riêng

Chọn chế độ **Own photo** → hiện thêm một hàng ảnh.

- [ ] Ô **Add** → chọn ảnh từ Photos → ảnh được chọn cho home, **và** xuất hiện ở hàng ảnh
      nền của lock phía trên
- [ ] Chọn một ảnh **đã tải lên trước đó** → được chọn (có viền)
- [ ] Chọn một ảnh **catalog** → có vòng xoay tải → được chọn → set → home đúng ảnh đó
- [ ] Đổi sang **template khác** → set → home **vẫn giữ** ảnh đã chọn (đây là setting chung,
      không theo template)
- [ ] Chuyển sang Photo only rồi quay lại Own photo → ảnh cũ **vẫn được chọn**, không phải
      chọn lại
- [ ] Own photo nhưng **chưa chọn ảnh nào** → set → home nhận **ảnh nền của lock** (không
      lịch), **không bao giờ** là màn trống/đen
- [ ] Đóng app hẳn, mở lại sau một ngày → set lại → ảnh home **vẫn còn** (app có dọn file
      ảnh không dùng khi khởi động — ảnh home không được bị dọn mất)
- [ ] Ảnh dọc, ảnh ngang, ảnh vuông: home **phủ kín màn**, căn giữa, không méo

---

## 7. Cặp wallpaper (một phần thăm dò)

**Bối cảnh:** action "Set Wallpaper" không ghi vào "cái đang hiện" mà vào **một cặp cụ
thể** trong thư viện wallpaper ("Wallpaper 6"). File shortcut **không** chọn sẵn cặp nào;
iOS tự gán. Bản phát hành **không** tự chuyển về cặp của Ink — đã chốt, xem mục 12.

**Đã xác nhận trên máy (không cần test lại):**

- Xoá một cặp **khác** → shortcut vẫn ghi đúng cặp của Ink (số hiển thị tự đổi, ví dụ 6 → 5).
- Xoá **chính cặp của Ink** → lần chạy sau tự tạo cặp mới, vẫn chạy bình thường.

**Cần test:**

- [ ] **Cài mới khi đang ở cặp của bạn:** chuyển màn khoá sang một cặp **ảnh riêng**, ghi
      lại số cặp. Cài shortcut, **chưa chạy**, mở shortcut xem **từng action Set trong 6
      action** đang ghi "Wallpaper mấy". Rồi bấm Set trong app:
      - Màn khoá có đổi không?
      - Ảnh riêng của bạn có bị thay bằng lịch không?
      - Số cặp có **tăng thêm một** không?
- [ ] **Sáu action Set có cùng một cặp không:** chạy lần lượt Off → Same → Photo only →
      Own photo. Sau mỗi lần, đếm số cặp trong thư viện và xem màn khoá có đổi không.
      Nếu mỗi chế độ **tạo thêm một cặp mới** → báo ngay, đây là lỗi chặn phát hành.
- [ ] **Chuyển sang cặp khác rồi bấm Update:** lịch **không hiện** trên cặp đang xem — đúng
      như thiết kế. Chuyển lại cặp của Ink → lịch **là bản mới nhất**.

---

## 8. Cảnh báo "Needs the new Ink shortcut"

Dòng chữ **vàng** trong mục Home Screen, khi chế độ khác Off.

- [ ] Đổi tên để app chạy **shortcut production** (mục 3.2) → chọn Same/Photo only/Own photo
      → cảnh báo **hiện** (với máy chưa từng chạy shortcut mới)
- [ ] Đổi tên để app chạy **shortcut mới**, bấm Update **một lần** → **đóng rồi mở lại**
      editor → cảnh báo **biến mất**
- [ ] Với shortcut production, chọn Photo only rồi set: nó **không** hiểu chế độ này — vẫn
      set cả lock và home bằng ảnh có lịch kèm blur như trước. Đúng như dự kiến

---

## 9. Automation iOS 27

File `iOS 27/Dev` mang sẵn **một** automation: **Sunrise** (lúc bình minh, hằng ngày).
Bình minh tính theo vị trí từng máy nên không phụ thuộc múi giờ.

Sau khi cài (mục 3.1, nhớ bật Allow Running When Locked), mở shortcut → **Edit → Automation**:

- [ ] Có automation **Sunrise** không? Đang **bật hay tắt**?
- [ ] **Allow Running When Locked** ngay sau khi cài (trước khi tự bật) đang bật hay tắt?

Chạy thật:

- [ ] **Sunrise** có xin **quyền vị trí** không?
- [ ] Để máy **khoá** qua đêm → sáng hôm sau wallpaper có đổi không? Có bị hỏi xác nhận không?
- [ ] Muốn khỏi chờ tới sáng: tạm đổi automation sang **Time of Day, 2–3 phút tới** →
      khoá máy → chờ → kiểm tra như trên. Test xong đổi lại Sunrise.
- [ ] Sau khi automation chạy lúc khoá máy, mở app: **không** hiện cảnh báo "automation
      không chạy" ở Home/Settings
- [ ] Cài lại **cùng file lần nữa**: có sinh **automation trùng** không?
- [ ] Máy **Apple Account khác**: cài file → có automation Sunrise không, bật hay tắt?

---

## 10. Chéo phiên bản

- [ ] Cài file **`iOS 27/Dev`** lên máy **iOS 26**: có cài được không? Nếu được, các action có
      chạy bình thường không (phần automation mong đợi là bị bỏ qua)?

Nếu iOS 26 cài được và chạy đúng, bản phát hành chỉ cần **một link cho cả hai phiên bản**.

---

## 11. Bảng ghi kết quả thăm dò

| Câu hỏi | iOS 26 | iOS 27 | Ghi chú |
|---|---|---|---|
| Photo only / Own photo hỏi quyền mấy lần? | | | |
| Cài file khi đã có shortcut cùng tên: iOS hỏi thay thế hay thêm bản số 1? | | | |
| Cài mới khi đang ở cặp riêng: màn khoá có đổi? | | | |
| Cài mới: ảnh riêng có bị thay bằng lịch? | | | |
| Cài mới: số cặp có tăng thêm một? | | | |
| 6 action Set trỏ cùng một cặp? (đổi chế độ có tạo cặp mới?) | | | |
| Sau khi cài, automation Sunrise bật hay tắt? | — | | |
| Allow Running When Locked sau khi cài? | — | | |
| Sunrise có xin quyền vị trí? | — | | |
| Automation chạy khi khoá máy, không hỏi? | — | | |
| Cài lại lần 2 có automation trùng? | — | | |
| Account khác: automation có về máy? | — | | |
| File iOS 27 cài được trên iOS 26? | | — | |

---

## 12. Không phải bug (đừng report)

- Chữ trong mục Home Screen **chỉ có tiếng Anh**, ở mọi ngôn ngữ máy — bản test, sẽ dịch
  trước khi phát hành.
- Ảnh home ở Own photo **chưa crop/căn khung được** — chỉ phủ kín, căn giữa.
- Ảnh catalog có nhãn **PRO** vẫn chọn được cho home khi chưa mua Pro — chưa chặn ở bản test.
- **Off** vẫn làm home đổi theo lock khi home đang đi theo lock — xem lưu ý ở mục 5.
- **Tự chuyển sang cặp wallpaper khác rồi bấm Update → lịch không hiện.** Ink chỉ cập nhật
  cặp của nó và **không** tự kéo màn khoá về (đã cân nhắc và bỏ: action chuyển cặp của
  Shortcuts phải chọn tay trên từng máy, và làm kẹt automation nếu chưa chọn). Chuyển lại
  cặp của Ink là thấy bản mới nhất.
- Nút **Add shortcut** trong luồng setup của app vẫn mở **link production** — shortcut mới
  chưa có link phát hành. Test bằng file ở mục 1.

## 13. Khi report lỗi, ghi kèm

- Phiên bản iOS, iPhone hay iPad
- **Tên shortcut nào đang mang tên `Ink Refresh Lock Screen`** lúc lỗi (production, iOS 26
  hay iOS 27)
- Chế độ Home Screen + Blur bật/tắt lúc lỗi
- Chạy từ đâu: nút trong app, Spotlight, automation, hay bấm trong app Shortcuts
- Cảnh báo vàng lúc đó có hiện không
- Số cặp wallpaper trước và sau khi chạy
- Ảnh chụp **lock screen và home screen**, và nếu nghi shortcut: ảnh chụp màn **Edit** của
  shortcut (các khối If và action Set Wallpaper)
