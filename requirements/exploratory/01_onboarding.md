# Exploratory Checklist — 01 Onboarding

> **Nguồn:** [wireframe](../ui/ux/wideframes/01_onboarding.md) · 6 screenshot
> **Khung đánh giá:** [exploratory-references](../../references/exploratory-references.md)
> **Build:** TestFlight 1.2.10 (27) · **Thiết bị:** ____________ · **Người test:** ____________

---

## 0 · Framing

**Q1 — Mục tiêu user của flow này:** hiểu Ink làm gì và tin đủ để **cấp quyền lịch** — không phải để đọc hết
6 slide.

**Q8 — Mục tiêu business:** đây là **phễu duy nhất** dẫn tới quyền Calendar. Rơi ở đây là mất user vĩnh viễn,
vì iOS chỉ cho hỏi quyền **đúng một lần**. Mọi ma sát ở flow này quy đổi trực tiếp thành tỷ lệ kích hoạt.

**Rủi ro xuyên suốt chạm vào flow này:**
- [§1.0 Bản đồ phụ thuộc](../../references/exploratory-references.md#10--bản-đồ-phụ-thuộc-ngoài-app) — S06 chỉ
  render đúng khi đã có quyền.
- [§1.2 Lock screen là ảnh tĩnh](../../references/exploratory-references.md#12--lock-screen-là-ảnh-tĩnh-dữ-liệu-cũ-tới-mức-nào-là-chấp-nhận-được) —
  S06 hứa *"refreshes every morning, automatically"*, cần đối chiếu với thực tế.
- [permissions-matrix §1.1](../../references/permissions-matrix.md#-ba-trạng-thái-quyền--và-cái-ở-giữa-là-bẫy) —
  dialog ở S05 chỉ có 2 nút, nhưng quyền có 3 trạng thái.

---

## 1 · Happy path — `ONB-H`

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **ONB-H01** | Cài mới, mở app lần đầu | S01 hiện, không có màn trắng/loading kéo dài | Thời gian từ chạm icon tới thấy S01 | ☐ |
| **ONB-H02** | Đi hết 6 slide bằng `Next`, **không đọc trước tài liệu** | Tới được S06 | ⏱ tổng thời gian · số lần phải dừng lại suy nghĩ | ☐ |
| **ONB-H03** | Quan sát pager dot ở mỗi slide | Dot sáng khớp đúng slide đang xem, luôn 6 dot | — | ☐ |
| **ONB-H04** | Kiểm nút Back | **Không có** ở S01 · **có** từ S02 trở đi | — | ☐ |
| **ONB-H05** | Đọc nội dung S01, S02 | Số liệu + nguồn trích dẫn hiện đủ: *Reviews.org, 2026* và *Gloria Mark, UC Irvine, 2008* | — | ☐ |
| **ONB-H06** | Tới S05, đọc kỹ | Có mock dialog quyền + mũi tên chỉ vào `Allow Full Access` + câu *"Your data stays on your device"* | — | ☐ |
| **ONB-H07** | Bấm CTA ở S05 | Bắn **dialog Calendar** của iOS → xem [02_permission](../ui/ux/wideframes/02_permission.md) | Nhãn CTA thật là gì *(xem ONB-Q01)* | ☐ |
| **ONB-H08** | Cấp đủ 2 quyền | Về S06, wallpaper preview hiện **event thật của mình** | Đối chiếu với Apple Calendar xem có đúng event không | ☐ |
| **ONB-H09** | Bấm `Get started` | Vào app, dừng ở tab **Discover** | — | ☐ |
| **ONB-H10** | Đóng app rồi mở lại | **Không** hiện onboarding nữa, vào thẳng Discover | — | ☐ |
| **ONB-H11** | Dùng nút Back đi ngược từ S06 về S01 | Về được từng slide, nội dung không vỡ, không mất trạng thái | — | ☐ |

---

## 2 · Negative — `ONB-N`

### 2.1 · Từ chối / chọn sai

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **ONB-N01** | Bấm `Don't Allow` ở dialog **Calendar** | App phải cho biết hậu quả và còn đường quay lại | S06 hiện wallpaper trống mà không giải thích → user tưởng app hỏng | 🔴 | ☐ |
| **ONB-N02** | Bấm `Don't Allow` ở dialog **Reminders** | S06 vẫn render được *(chỉ thiếu mục to-do)* | Coi như từ chối hết, chặn cả flow | 🟠 | ☐ |
| **ONB-N03** | Từ chối cả 2 quyền rồi bấm `Get started` | Vào được app, các tab hiện màn hình phục hồi [S03/S04](../ui/ux/wideframes/02_permission.md) | Kẹt ở onboarding, không vào được app | 🔴 | ☐ |
| **ONB-N04** | Sau khi từ chối, tìm cách xin lại quyền **từ trong onboarding** | Có đường nào đó *(nút thử lại / link Settings)* | Không có → user phải tự mò, iOS đã không hỏi lại nữa | 🔴 | ☐ |

### 2.2 · Bỏ dở giữa chừng

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **ONB-N05** | Kill app ở **S03** rồi mở lại | Bắt đầu lại từ S01 *(chấp nhận được)* hoặc quay đúng S03 — miễn là **không kẹt** | Màn trắng, hoặc vào thẳng app mà chưa xin quyền | 🟠 | ☐ |
| **ONB-N06** | Kill app ở **S05 sau khi đã cấp quyền**, mở lại | Không bắn lại dialog *(iOS không hỏi lần 2)*, và không kẹt ở S05 chờ mãi | Kẹt vĩnh viễn ở S05 vì chờ callback không bao giờ tới | 🔴 | ☐ |
| **ONB-N07** | Ở S05, bấm CTA rồi **vuốt dialog đi** thay vì chọn | App xử lý như từ chối, có đường đi tiếp | Treo, disable nút, phải kill app | 🟠 | ☐ |
| **ONB-N08** | Muốn bỏ qua onboarding | *(Wireframe ghi: **không có nút Skip** ở bất kỳ slide nào)* — xác nhận và đo phản ứng người test | User sốt ruột thoát app luôn | 🟡 | ☐ |

### 2.3 · Thao tác lặp / nhanh

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **ONB-N09** | Bấm `Next` liên tục thật nhanh 10 lần | Chuyển từng slide một, dừng đúng ở S06 | Nhảy cóc slide, hoặc chồng nhiều màn hình | 🟠 | ☐ |
| **ONB-N10** | Bấm CTA ở S05 **hai lần liên tiếp** | Chỉ bắn **một** dialog | Bắn 2 lần, hoặc dialog thứ 2 chồng lên | 🟠 | ☐ |
| **ONB-N11** | Vuốt ngang trái/phải để chuyển slide | Hoặc chạy đúng, hoặc không phản ứng gì — **phải nhất quán** | Vuốt được nhưng pager không đồng bộ | 🟡 | ☐ |
| **ONB-N12** | Ở S01, vuốt ngược sang phải *(lùi khi không có gì để lùi)* | Không có gì xảy ra, không lỗi | Màn trắng / thoát app | 🟡 | ☐ |
| **ONB-N13** | Bấm `Back` và `Next` xen kẽ liên tục | Điều hướng ổn định, pager luôn khớp | Lệch pager, kẹt slide | 🟡 | ☐ |

### 2.4 · Gián đoạn

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **ONB-N14** | Bật chế độ máy bay từ đầu, chạy hết onboarding | Chạy bình thường *(6 slide nhiều khả năng là asset local)* | Ảnh minh hoạ trống, S06 không render | 🟠 | ☐ |
| **ONB-N15** | Có cuộc gọi đến giữa S05, xử lý xong quay về app | Về đúng chỗ, dialog quyền không mất | Mất trạng thái, phải làm lại | 🟠 | ☐ |
| **ONB-N16** | Chuyển app khác rồi quay lại giữa chừng | Giữ nguyên slide đang xem | Reset về S01 | 🟡 | ☐ |

---

## 3 · Edge — `ONB-E`

| ID | Tình huống | Câu hỏi | Mức | ☐ |
|---|---|---|:---:|:---:|
| **ONB-E01** | Máy **không có event nào** trong lịch | S06 hiện wallpaper trống? Có placeholder không? Onboarding vẫn thuyết phục chứ? | 🟠 | ☐ |
| **ONB-E02** | Máy có **1000+ event** *(dialog quyền báo 1.872 events)* | S06 render mất bao lâu? Có loading không? | 🟠 | ☐ |
| **ONB-E03** | Event có **tên rất dài** / nhiều emoji / **tiếng Việt có dấu** | Preview ở S06 xuống dòng đúng? Dấu tiếng Việt không bị vỡ? | 🟡 | ☐ |
| **ONB-E04** | **Dynamic Type** cỡ lớn nhất *(Settings → Accessibility)* | Chữ tràn khỏi màn hình? Nút `Next` bị đẩy khuất? Số `186`/`23 min` cỡ lớn còn vừa không? | 🟠 | ☐ |
| **ONB-E05** | **Dark Mode** | Toàn bộ 6 ảnh chụp đều nền sáng — app có hỗ trợ Dark Mode không? Chữ đen trên nền sáng có bị đảo thành khó đọc không? | 🟠 | ☐ |
| **ONB-E06** | Máy **màn hình nhỏ** (iPhone SE / mini) | S04 có 3 benefit row + illustration — có bị cắt hoặc phải cuộn không? | 🟠 | ☐ |
| **ONB-E07** | **VoiceOver** bật | Đọc được hết nội dung? Thứ tự đúng? Nút `Next`/`Back` có nhãn không? Illustration có mô tả không? | 🟠 | ☐ |
| **ONB-E08** | **Reduce Motion** bật | Animation chuyển slide có tôn trọng thiết lập không? | 🟡 | ☐ |
| **ONB-E09** | Ngôn ngữ máy là **tiếng Việt** | UI vẫn tiếng Anh hay có bản dịch? *(Nội dung app quan sát được đang là tiếng Anh trong khi data user là tiếng Việt)* | 🟠 | ☐ |
| **ONB-E10** | **Gỡ app rồi cài lại** | Onboarding hiện lại từ đầu? Quyền iOS còn giữ? Nếu quyền còn mà onboarding vẫn xin lại thì xử lý sao? | 🟠 | ☐ |
| **ONB-E11** | Máy **đã cấp sẵn quyền** từ lần cài trước, mở app mới | S05 có phát hiện quyền đã có để **bỏ qua** bước xin không, hay vẫn bắt bấm CTA rồi không có gì xảy ra? | 🟠 | ☐ |
| **ONB-E12** | Vào Settings đặt Calendar = **`Add Events Only`** trước khi mở app | S06 render ra gì? *(Hiện app coi trạng thái này như từ chối hoàn toàn — xem [permissions-matrix](../../references/permissions-matrix.md#-ba-trạng-thái-quyền--và-cái-ở-giữa-là-bẫy))* | 🔴 | ☐ |
| **ONB-E13** | **Pin yếu / Low Power Mode** | Animation và render S06 có giật không? | 🟡 | ☐ |

---

## 4 · Coverage matrix

| State | Đã có ảnh | Đã chạm khi test |
|---|:---:|:---:|
| S01–S06 · default | ✅ | ☐ |
| S05 · biến thể CTA `Sync my data` + `Skip for now` | ⚠️ chỉ thấy ở ảnh Flow 02 | ☐ |
| S06 khi **từ chối quyền** | ❌ chưa có ảnh | ☐ |
| S06 khi lịch **rỗng** | ❌ | ☐ |
| Dark Mode — mọi slide | ❌ | ☐ |
| Dynamic Type lớn — mọi slide | ❌ | ☐ |
| Onboarding lần 2 *(sau khi gỡ & cài lại)* | ❌ | ☐ |

---

## 5 · Câu hỏi cần PO / dev trả lời — `ONB-Q`

| ID | Câu hỏi | Vì sao cần |
|---|---|---|
| **ONB-Q01** | Nhãn CTA ở S05 là `See my lock screen` hay `Sync my data`? Ảnh Flow 02 cho thấy nền có nhãn khác kèm link `Skip for now`. Là **A/B test**, hay là **trạng thái sau khi từ chối lần đầu**? | Quyết định checklist có phải phủ 2 biến thể không |
| **ONB-Q02** | Có **analytics đo drop-off** từng slide không? Số thật là bao nhiêu? | Q2 của mindset không thể trả lời bằng cảm tính. Không có số → ghi là **gap về đo lường** |
| **ONB-Q03** | **Không có nút Skip** là chủ ý hay thiếu sót? | Quyết định ONB-N08 là bug hay design |
| **ONB-Q04** | Hai slide đầu chỉ là **số liệu thống kê**, chưa nói app làm gì. Có dữ liệu nào chứng minh cách mở đầu này giữ chân tốt hơn không? | Đây là 2/6 slide đầu tiên — nơi rơi rớt nhiều nhất |
| **ONB-Q05** | Câu *"Your data stays on your device"* ở S05 — còn đúng khi user bật **Google Calendar sync** không? | Đụng App Privacy Label, không chỉ là câu chữ marketing. Xem [01_onboarding wireframe](../ui/ux/wideframes/01_onboarding.md) |
| **ONB-Q06** | S06 hứa *"refreshes every morning, automatically"* — nhưng cần setup Shortcut ở [Flow 03](../ui/ux/wideframes/03_shortcut-setup.md) mới đúng. Onboarding có nên nói trước là **cần thêm một bước setup** không? | Kỳ vọng sai từ onboarding sẽ thành thất vọng ở Flow 03 |
| **ONB-Q07** | Wallpaper ở S06 là **render thật** từ data user hay là ảnh mẫu dựng sẵn? | Nếu là ảnh mẫu thì ONB-H08 và ONB-E01/E02 không áp dụng |

---

## 6 · Smoke 15 phút cho flow này

| Thứ tự | Việc | Thời lượng |
|:---:|---|:---:|
| 1 | **ONB-H01→H09** — đi hết happy path trên máy sạch, bấm giờ | 5 phút |
| 2 | **ONB-N01, N03** — từ chối quyền Calendar, xem có vào được app không | 3 phút |
| 3 | **ONB-N06** — kill app ngay sau khi cấp quyền, mở lại xem có kẹt không | 2 phút |
| 4 | **ONB-E12** — đặt `Add Events Only` rồi mở app | 2 phút |
| 5 | **ONB-E05** — bật Dark Mode, lướt lại 6 slide | 2 phút |
| 6 | **ONB-H10** — mở lại app lần 2, xác nhận không hiện onboarding | 1 phút |

---

## 7 · Kết luận phiên

```
Phiên: __________      Build: 1.2.10 (27)      Thiết bị: __________

Q1 Mục tiêu user:            hiểu app + cấp quyền lịch
Q8 Mục tiêu business:        phễu duy nhất dẫn tới quyền Calendar
— Chạy luồng chính —
Q2 Xong dễ lần đầu?          Có / Không — vì: __________
Q3 Điểm khựng/bối rối:       ______________________________
Q4 Thao tác sai / gián đoạn: ______________________________
Q5 State chưa test:          ______________________________
— Kết luận —
Q6 Rủi ro #1 nếu ship:       ______________________________
Q7 Tự mình dùng hằng ngày?   Có / Không — vì: __________
Q9 15 phút thì test gì:      §6 ở trên

=> Verdict: 🟢 / 🟡 / 🔴  — kèm bằng chứng
```

**Ngưỡng cho riêng flow này:**

| Verdict | Điều kiện |
|---|---|
| 🔴 | Từ chối quyền xong **không vào được app** · kẹt vĩnh viễn sau khi kill app ở S05 · `Add Events Only` cho ra màn hình vô nghĩa mà không có đường sửa |
| 🟡 | Đi hết được nhưng người mới khựng ≥2 chỗ · không có Skip và người test tỏ ra sốt ruột · Dark Mode/Dynamic Type vỡ layout |
| 🟢 | Người chưa từng thấy UI đi hết 6 slide và cấp quyền mà không cần hỏi ai · mọi đường từ chối đều có lối ra |

---

## Ghi chú về giới hạn checklist này

- **ONB-H08, ONB-E01, ONB-E02** phụ thuộc câu trả lời của **ONB-Q07** — nếu wallpaper ở S06 là ảnh mẫu dựng
  sẵn thì cả 3 mục này không áp dụng.
- **Đường từ chối quyền chưa có screenshot nào** ở flow này *(wireframe ghi rõ trong Possible missing screen)*.
  ONB-N01→N04 vì vậy là **khám phá thật**, không phải đối chiếu với thiết kế — ghi lại màn hình quan sát được
  để bổ sung vào wireframe sau.
- Chưa kiểm được **ONB-Q02** nếu không có quyền truy cập analytics → ghi là **coverage gap**, không suy đoán
  tỷ lệ rơi rớt.
