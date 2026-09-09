# Exploratory Checklist — 04 Discover

> **Nguồn:** [wireframe](../ui/ux/wideframes/04_discover.md) · 13 screenshot ·
> [index screenshot](../ui/ux/screenshots/iphone/index.md#04_discover--tab-discover)
> **Khung đánh giá:** [exploratory-references](../../references/exploratory-references.md) ·
> [permissions-matrix](../../references/permissions-matrix.md)
> **Build:** TestFlight 1.2.10 (27) · **Thiết bị:** ____________ · **iOS:** ____________ · **Người test:** ____________

---

## 0 · Framing

**Q1 — Mục tiêu user:** tìm và chọn được một thiết kế lock screen / live activity / widget hợp gu, rồi **đưa
nó lên máy mình**. User đến đây để *chọn*, nhưng giá trị chỉ thành hiện thực khi nội dung **hiện ra ngoài app**.

**Q8 — Mục tiêu business:** Discover là **tab mặc định** — màn hình đầu tiên user thấy mỗi lần mở app, và là
nơi duy nhất đặt nút 👑 dẫn sang paywall. Đây vừa là cửa hàng nội dung vừa là phễu bán hàng. Nội dung Pro nằm
ở đâu trong 93 widget · 28 lockscreen · 5 live activity thì **chưa có bằng chứng nào** — xem `DSC-Q01`.

**Vì sao flow này khác:** Discover **không tự hoàn tất được việc gì**. Cả 3 loại nội dung đều kết thúc bằng
một thao tác **ngoài app**:

| Loại | Nút | Kết thúc ở đâu | Ink kiểm chứng được? |
|---|---|---|:---:|
| Lock screen | `Use` | app Shortcuts *(Flow 03)* | Không |
| Live Activity | `Use` / `Open` | user khoá máy rồi bấm `Allow` | Không |
| Widget | `Add` | Home Screen, user tự thêm | **Không — user tự khai** |

→ Rủi ro trung tâm của flow này là **app tưởng đã xong trong khi ngoài đời chưa xảy ra gì**. Toàn bộ §2 xoay
quanh chuyện đó.

**Rủi ro xuyên suốt chạm vào flow này** *(chỉ link, không lặp lại)*:
[§1.0 bản đồ phụ thuộc ngoài app](../../references/exploratory-references.md#10--bản-đồ-phụ-thuộc-ngoài-app) ·
[§1.1 chuỗi setup](../../references/exploratory-references.md#11--chuỗi-setup-có-sống-sót-qua-người-dùng-thật-không) ·
[§1.5 bốn cửa vào một dữ liệu](../../references/exploratory-references.md#15--bốn-cửa-vào-một-dữ-liệu-có-nhất-quán-không) ·
[permissions-matrix §1.1 `Add Events Only`](../../references/permissions-matrix.md#-ba-trạng-thái-quyền--và-cái-ở-giữa-là-bẫy) ·
[permissions-matrix §4 công tắc Live Activities](../../references/permissions-matrix.md#4--tầng-d--công-tắc-ios-không-phải-quyền-nhưng-chặn-tính-năng)

---

## 1 · Happy path — `DSC-H`

### 1.1 · S01 Discover home

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **DSC-H01** | Mở app *(đã cấp quyền Calendar)* | Vào thẳng tab **Discover** · header `Discover` + 👑 + ⚙ | ⏱ thời gian tới lúc nội dung hiện đủ | ☐ |
| **DSC-H02** | Đọc 3 section header | `Lockscreen (28)` · `Live Activities (5)` · `Widgets (93)` — mỗi cái có mô tả 1 dòng và `›` | Số đếm có khớp số item thật khi mở màn "xem tất cả" không | ☐ |
| **DSC-H03** | Vuốt ngang carousel Lockscreen | Cuộn mượt, card tràn viền phải gợi ý còn nữa | 🎞 FPS khi vuốt nhanh — **đo, không đoán** | ☐ |
| **DSC-H04** | Cuộn dọc xuống section Widgets | Header `Discover` **dính** ở trên · 3 nhóm widget có caption `Calendar` · `Tasks` · `Up…` | Caption thứ 3 bị cắt — tên đầy đủ là gì *(xem `DSC-E15`)* | ☐ |
| **DSC-H05** | Bấm 👑 | Sang paywall — [Flow 08](../ui/ux/wideframes/08_paywall.md) | — | ☐ |
| **DSC-H06** | Bấm ⚙ | Sang settings — [Flow 09](../ui/ux/wideframes/09_settings.md) | — | ☐ |

### 1.2 · Đường lock screen — S04 → S05 → S02

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **DSC-H07** | Bấm `Lockscreen ›` | S04 · grid **2 cột** cuộn dọc · filter chip cuộn ngang `All / Timeline / Timetable / Today's…` | Đếm đủ **28** template không | ☐ |
| **DSC-H08** | Chọn lần lượt từng filter | Grid lọc đúng theo **kiểu bố cục** · chip đang chọn có highlight | Tổng số item của các filter cộng lại vs 28 | ☐ |
| **DSC-H09** | Bấm một template | S05 · title = tên template · subtitle `Lockscreen` · nút `i` · preview lớn · CTA `+ Add to lock screen` | ⏱ thời gian render preview | ☐ |
| **DSC-H10** | 🔴 Đối chiếu preview với tab Calendar | Preview render **event thật của user**, đúng ngày, đúng tên | Mở tab Calendar so từng dòng — [§1.5](../../references/exploratory-references.md#15--bốn-cửa-vào-một-dữ-liệu-có-nhất-quán-không) | ☐ |
| **DSC-H11** | Kiểm logic `+N more` | Ngày nhiều event hiện `… +5 more` | Số N có khớp số event thật bị ẩn không | ☐ |
| **DSC-H12** | Bấm nút `i` | Ghi lại nội dung hiện ra | ⚠️ **coverage gap** — chưa có ảnh, ghi lại thấy gì | ☐ |
| **DSC-H13** | Bấm `+ Add to lock screen` | Ghi rõ app đi đâu tiếp: về S01? hiện tooltip? sang Shortcuts? | ⚠️ **coverage gap** — wireframe chỉ ghi "→ S02", chưa có ảnh màn trung gian | ☐ |
| **DSC-H14** | Về S01, tìm section `Your collection` | Section **xuất hiện** *(trước đó không có)* · count `(1)` · card có badge xanh `✓ Active Lockscreen` · nút **`Update`** | Nhãn nút là `Update`, **không** phải `Use` | ☐ |

### 1.3 · Cơ chế `Use` → tooltip → Shortcut

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **DSC-H15** | 🔴 Bấm `Use` trên một card lockscreen ở S01 | Tooltip **`Set current wallpaper`** · mũi tên trỏ đúng card vừa bấm · CTA `Open Shortcut` | Wallpaper thật **chưa đổi** ở bước này | ☐ |
| **DSC-H16** | Đọc nguyên văn tooltip | *"Open Shortcuts to run 'Generate Latest Wallpaper' and refresh your Lock Screen image."* | Người lần đầu đọc xong **có hiểu vì sao phải làm vậy không** — hỏi người thật, đừng tự chấm | ☐ |
| **DSC-H17** | Bấm `Open Shortcut` | Rời Ink → app Shortcuts · shortcut chạy · Dynamic Island hiện ✓ | ⏱ độ trễ deep link · bàn giao sang [Flow 03](03_shortcut-setup.md) | ☐ |
| **DSC-H18** | Khoá máy kiểm chứng | Lock screen **đã đổi** đúng template vừa chọn | Đây là **điểm duy nhất** chứng minh `Use` có tác dụng thật | ☐ |

### 1.4 · Your collection — S03

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **DSC-H19** | Bấm `Your collection ›` | S03 · filter chip `All / Lockscreen / Live Activity / Note` · `All` đang chọn | — | ☐ |
| **DSC-H20** | Chọn từng filter | Lọc đúng loại · `Note` — có item nào không? | ⚠️ Filter `Note` có mà **chưa có bằng chứng item loại Note tồn tại** — xem `DSC-Q08` | ☐ |
| **DSC-H21** | Lưu thêm 1 live activity rồi quay lại S01 | Section collection count `(2)` · **2 loại badge khác nhau**: `✓ Live` vs `✓ Active Lockscreen` · **2 nhãn nút khác nhau**: `Open` vs `Update` | Người dùng có phân biệt được `Open` với `Update` không | ☐ |

### 1.5 · Live Activity — S06 → S07

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **DSC-H22** | Từ S01 bấm một card Live Activity | S06 · title `Weekly Schedule` + subtitle `Live Activity` · preview lịch tuần | — | ☐ |
| **DSC-H23** | Đọc tooltip `Lock your phone to see it live` | Có nút ✕ đóng được | Đóng rồi mở lại màn — tooltip còn hiện lại không | ☐ |
| **DSC-H24** | Đọc hướng dẫn 2 bước | ① *Turn it on, then go to your lock screen* ② *Tap Allow to let it show* | Bước ② nói tới dialog nào — của iOS hay của Ink? | ☐ |
| **DSC-H25** | 🔴 Khoá máy, làm đúng 2 bước | Live Activity **thật sự hiện** trên lock screen sau khi bấm `Allow` | Đây là điểm duy nhất chứng minh live activity chạy | ☐ |
| **DSC-H26** | Về S06 | Nút là **`■ Stop Live Activity`** *(trạng thái đang chạy)* + nút `✎` | — | ☐ |
| **DSC-H27** | Bấm `✎` | S07 · header nền đen · nút `✓` · preview ở trên · `Display Time` toggle · `Event Display` segmented `Block / List` | — | ☐ |
| **DSC-H28** | Đổi `Event Display` sang `List`, tắt `Display Time` | Preview trên cùng **cập nhật realtime** theo từng thay đổi | ⏱ độ trễ preview | ☐ |
| **DSC-H29** | Bấm `✓` rồi khoá máy | Live Activity trên lock screen **đổi đúng theo config vừa chỉnh** | Config có thật sự tới được lock screen không | ☐ |

### 1.6 · Widget — S08

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **DSC-H30** | Bấm `Widgets ›` | ⚠️ **coverage gap** — wireframe ghi màn "xem tất cả 93 widget" **chưa có ảnh**. Ghi lại thấy gì | Có ô tìm kiếm không? Có filter không? | ☐ |
| **DSC-H31** | 🔴 Tìm một widget cụ thể trong 93 cái | — | ⏱ **bấm giờ** thời gian tìm ra · số lần cuộn · người thật, không phải người đã biết trước | ☐ |
| **DSC-H32** | Bấm `Add` trên một card widget | S08 · modal `Add widget` · nút `✕` · mockup điện thoại · pager `● ○ ○` | Nút là `Add`, khác `Use` — user có thấy khác biệt là có chủ ý không | ☐ |
| **DSC-H33** | Vuốt qua 3 bước | Mockup đổi theo bước: ① lưới app trống + ngón tay giữ ② nút `+` tím ③ widget Ink tím đã đặt | Hướng dẫn có khớp iOS đang test không *(vị trí nút `+` / `Edit` đổi theo phiên bản)* | ☐ |
| **DSC-H34** | Làm thật trên Home Screen theo hướng dẫn | Thêm được widget Ink · widget hiện **dữ liệu thật**, không phải placeholder | ⏱ thời gian · số lần phải quay lại đọc lại hướng dẫn | ☐ |
| **DSC-H35** | Quay lại bấm `I've added the widget` | Ghi rõ app làm gì tiếp: đóng modal? đổi trạng thái gì? | Nút dạng **outline**, không phải primary — app **không kiểm chứng được** *(xem `DSC-N09`)* | ☐ |

---

## 2 · Negative — `DSC-N`

### 2.1 · Bỏ dở giữa chừng — app có tưởng là đã xong không

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **DSC-N01** | 🔴 Bấm `Use` → tooltip hiện → **đóng tooltip, không mở Shortcuts** | Ink biết chưa áp dụng · collection **không** gắn badge `✓ Active Lockscreen` | Badge nói "Active" trong khi lock screen thật **chưa hề đổi**. User tin badge, không tin mắt mình | 🔴 | ☐ |
| **DSC-N02** | 🔴 Bấm `Use` → `Open Shortcut` → sang Shortcuts nhưng **không chạy**, vuốt về Ink ngay | Như trên — Ink phải phân biệt *"đã chọn"* vs *"đã áp dụng"* | Cùng kiểu hỏng N01, đường đi phổ biến hơn nhiều | 🔴 | ☐ |
| **DSC-N03** | Ở S05, bấm `Add to lock screen` rồi **back** ngay | Trạng thái collection nhất quán với việc vừa làm | Item nửa vời trong collection | 🟠 | ☐ |
| **DSC-N04** | Đóng modal `Add widget` bằng `✕` ở **bước 2** | Mở lại vào bước 1 hay nhớ bước 2? Trạng thái nào cũng được, miễn **nhất quán** | Modal nhớ sai bước, user tưởng đã làm xong bước 1–2 | 🟡 | ☐ |
| **DSC-N05** | Vào S06 Live Activity, **không** khoá máy, thoát ra ngay | Collection **không** gắn badge `✓ Live` khi user chưa bấm `Allow` trên lock screen | Badge `Live` cho một live activity chưa bao giờ hiện | 🔴 | ☐ |
| **DSC-N06** | Ở S07 đang sửa config, bấm **back** thay vì `✓` | Huỷ thay đổi, hoặc hỏi trước. Phải rõ ràng | Lưu ngầm thay đổi user đã bỏ, hoặc mất config im lặng | 🟠 | ☐ |

### 2.2 · Trạng thái ngoài app bị phá — Ink có phát hiện không

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **DSC-N07** | 🔴 Đã `Use` template A → sau đó **đổi wallpaper bằng tay** trong iOS Settings | Badge `✓ Active Lockscreen` phải mất, hoặc app thừa nhận không biết | Badge khẳng định một điều **sai sự thật** về máy user | 🔴 | ☐ |
| **DSC-N08** | Đã bật live activity → **tắt công tắc Live Activities** trong Settings → Ink | Ink phát hiện và báo · nút đổi trạng thái | Tầng D — [Ink không đọc được](../../references/permissions-matrix.md#4--tầng-d--công-tắc-ios-không-phải-quyền-nhưng-chặn-tính-năng). Badge `Live` sai, không có đường chẩn đoán | 🔴 | ☐ |
| **DSC-N09** | 🔴 Bấm `I've added the widget` **mà chưa thêm widget nào** | App không dựa vào lời khai này để kết luận đã xong · hoặc có cách kiểm chứng khác | App tin lời khai. User bấm nhầm/bấm bừa → không ai biết widget chưa tồn tại. **Không có API kiểm chứng** — xem `DSC-Q05` | 🔴 | ☐ |
| **DSC-N10** | Xoá widget Ink khỏi Home Screen sau khi đã khai đã thêm | Ink có nhận ra không? | Như N09 | 🟠 | ☐ |
| **DSC-N11** | Xoá shortcut `Generate Latest Wallpaper` rồi bấm `Use` ở Discover | Tooltip `Open Shortcut` dẫn đi đâu? Có báo shortcut không tồn tại không? | Deep link vào hư không, user kẹt không hiểu vì sao — giao với [SCT-N20](03_shortcut-setup.md) | 🔴 | ☐ |

### 2.3 · Quyền

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **DSC-N12** | 🔴 **Từ chối quyền Calendar** rồi mở S05 template preview | Có màn hình giải thích + nút `Open Settings`, **không** hiện preview trống không lời | Preview trống trơn → user tưởng template hỏng, không nghĩ tới quyền. Flow 02 **có** màn phục hồi cho tab Calendar — Discover có không? *(chưa có bằng chứng)* | 🔴 | ☐ |
| **DSC-N13** | 🔴 Đặt Calendar = **`Add Events Only`** trong Settings → Ink → mở S05 | Nội dung phải **gọi đúng tên** lựa chọn: cần `Full Access`, đang để `Add Events Only` | [Lần thứ 3 của cùng một mẫu lỗi](../../references/permissions-matrix.md#đây-là-lần-thứ-ba-cùng-một-mẫu-lỗi-lặp-lại). User đã cấp quyền rồi mà preview vẫn trống | 🔴 | ☐ |
| **DSC-N14** | Từ chối quyền **Reminders**, mở template có to-do *(vd "timetable + to-do")* | Preview vẽ phần lịch, thiếu to-do — có nói rõ đang thiếu gì không | Vẽ thiếu dữ liệu mà **không báo** — kiểu hỏng nguy hiểm nhất theo [§1.0](../../references/exploratory-references.md#10--bản-đồ-phụ-thuộc-ngoài-app) | 🟠 | ☐ |
| **DSC-N15** | Rút quyền Calendar **sau khi** đã lưu template vào collection | Card trong collection hiện gì — preview cũ cache, hay trống, hay crash? | Crash / màn trắng ở tab mặc định = user không vào được app | 🔴 | ☐ |

### 2.4 · Thao tác lặp / nhanh · gián đoạn

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **DSC-N16** | Bấm `Use` **2 lần liên tiếp** trên cùng card | 1 tooltip, 1 item trong collection | 2 tooltip chồng nhau / 2 item trùng | 🟡 | ☐ |
| **DSC-N17** | Bấm `Use` template A rồi ngay lập tức `Use` template B | Chỉ **một** cái mang badge `✓ Active`. Cái nào? | 2 item cùng khai "Active" → mâu thuẫn hiển nhiên | 🟠 | ☐ |
| **DSC-N18** | Bấm nhanh nhiều card khác nhau khi màn preview đang mở | Không mở chồng nhiều màn preview | Stack màn hình rác, back nhiều lần mới thoát được | 🟡 | ☐ |
| **DSC-N19** | Bật/tắt `Display Time` liên tục 10 lần ở S07 | Preview theo kịp, không kẹt, không nhấp nháy | — | 🟡 | ☐ |
| **DSC-N20** | **Kill app** khi đang ở S05 preview / S07 editing → mở lại | Vào lại Discover ở trạng thái sạch, không mất item đã lưu | Mất item trong collection | 🟠 | ☐ |
| **DSC-N21** | **Offline** hoàn toàn rồi mở Discover | Ghi rõ: 28 template + 93 widget còn hiện không? Ảnh preview còn không? | Nếu nội dung tải từ server → **tab mặc định trống khi mất mạng**. Xem `DSC-Q02` | 🔴 | ☐ |
| **DSC-N22** | Mạng chập chờn khi cuộn tới section Widgets | Có skeleton/placeholder, không trống trơn không lời | — | 🟡 | ☐ |

### 2.5 · Giao với paywall

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **DSC-N23** | 🔴 Tìm template / widget / live activity **Pro** trong Discover khi **chưa mua** | Có dấu hiệu khoá rõ ràng · bấm vào → paywall | ⚠️ **Chưa có ảnh nào** cho trạng thái `locked` — không xác định được ranh giới Free/Pro thì **không đánh giá được có rò rỉ nội dung trả phí hay không**. Xem `DSC-Q01` | 🔴 | ☐ |
| **DSC-N24** | 🔴 Lưu template Pro vào collection **trong lúc dùng thử** → chờ hết hạn | Item Pro bị khoá lại | Rò doanh thu — giao với [SCT-E30](03_shortcut-setup.md) | 🔴 | ☐ |

---

## 3 · Edge — `DSC-E`

### 3.1 · Dữ liệu

| ID | Tình huống | Câu hỏi | Mức | ☐ |
|---|---|---|:---:|:---:|
| **DSC-E01** | 🔴 `Your collection` khi **chưa lưu gì** | Section có **ẩn hẳn** không *(bằng chứng: `home_default` không có nó)*? Vào S03 qua đường nào khác thì hiện empty state gì? ⚠️ **chưa có ảnh** | 🟠 | ☐ |
| **DSC-E02** | Collection có **20+ item** | Section ngang ở S01 cuộn nổi không? S03 có phân trang/lazy load không? | 🟡 | ☐ |
| **DSC-E03** | Mở S05 preview vào **ngày không có event nào** | Panel trống trơn? Có placeholder? User có phân biệt được "hôm nay rảnh" với "app hỏng" không? | 🟠 | ☐ |
| **DSC-E04** | Mở S05 preview vào ngày có **20+ event** | Logic `+N more` đúng chứ? Panel tràn hay cắt? ⏱ thời gian render | 🟠 | ☐ |
| **DSC-E05** | Event tên **rất dài** / emoji / **tiếng Việt có dấu** | Xuống dòng đúng? Vỡ font dấu? Tràn khỏi khung preview? *(app có data tiếng Việt thật)* | 🟡 | ☐ |
| **DSC-E06** | Tắt hết calendar ở sheet Calendars rồi mở S05 | Preview có tôn trọng lựa chọn đó không, hay vẫn vẽ event của calendar đã tắt — [§1.5](../../references/exploratory-references.md#15--bốn-cửa-vào-một-dữ-liệu-có-nhất-quán-không) | 🟠 | ☐ |
| **DSC-E07** | So preview S05 · widget trên Home Screen · live activity · wallpaper thật | 4 bề mặt có hiện **cùng một tập event** không? | 🟠 | ☐ |

### 3.2 · Hiển thị & tiếp cận

| ID | Tình huống | Câu hỏi | Mức | ☐ |
|---|---|---|:---:|:---:|
| **DSC-E08** | **Dynamic Type** cỡ lớn nhất | Section header, caption dưới card, chip filter — cắt chữ hay xuống dòng? Nút `Use` / `Add` còn bấm được? | 🟠 | ☐ |
| **DSC-E09** | **Dark Mode** trên cả 8 màn | Preview template có bị lẫn nền không? Badge xanh còn đọc được? **Đo tương phản bằng số** | 🟡 | ☐ |
| **DSC-E10** | Máy **màn hình nhỏ** *(SE / mini)* | Grid 2 cột ở S04 còn đọc được tên template không? Modal S08 có phải cuộn không? | 🟠 | ☐ |
| **DSC-E11** | **VoiceOver** | Card có label mô tả được template không, hay chỉ đọc "image"? Nút `Use`/`Add`/`Update`/`Open` đọc ra gì? Tooltip có được focus không? Pager 3 chấm ở S08 có announce bước không? | 🟠 | ☐ |
| **DSC-E12** | 🟡 Ba động từ `Use` · `Open` · `Add` cho 3 loại nội dung | Đưa cho **người chưa dùng app**: hỏi họ đoán mỗi nút làm gì. Ghi lại nguyên văn câu trả lời | 🟡 | ☐ |
| **DSC-E13** | Cuộn danh sách **93 widget** | 🎞 **Đo FPS**, không đoán. Có drop frame khi ảnh preview load không? | 🟠 | ☐ |
| **DSC-E14** | Xoay ngang máy | Grid/carousel vỡ layout không? *(nếu app khoá portrait thì ghi lại là khoá)* | 🟡 | ☐ |
| **DSC-E15** | Caption nhóm widget thứ 3 hiện `Up…` **bị cắt** | Tên đầy đủ là gì? Cắt là do Dynamic Type hay do layout cứng? Có phải bug hiển thị không | 🟡 | ☐ |

### 3.3 · Thời gian & vòng đời

| ID | Tình huống | Câu hỏi | Mức | ☐ |
|---|---|---|:---:|:---:|
| **DSC-E16** | Mở S05 preview **qua nửa đêm** *(để app mở, chờ qua 00:00)* | Preview có tự nhảy sang ngày mới không, hay giữ ngày cũ? | 🟡 | ☐ |
| **DSC-E17** | **Đổi múi giờ** rồi mở lại preview | Giờ event trên preview có đúng giờ địa phương mới không? | 🟠 | ☐ |
| **DSC-E18** | Đưa app **xuống background** ở S06 rồi quay lại | Trạng thái nút `Stop`/`Start` còn đúng với thực tế không? | 🟠 | ☐ |
| **DSC-E19** | 🔴 **Đổi template** ở Discover **sau khi** đã setup automation | Lần automation chạy kế tiếp có dùng template mới không? Đây là **mối nối giữa Flow 04 và Flow 03** — giao với [SCT-E16](03_shortcut-setup.md) | 🔴 | ☐ |
| **DSC-E20** | **Gỡ app rồi cài lại** | `Your collection` còn không? Lưu local hay cloud — xem `DSC-Q04` | 🟠 | ☐ |
| **DSC-E21** | Máy có **nhiều lock screen theo Focus** | Bấm `Use` ghi đè cái nào? — giao với [SCT-E23](03_shortcut-setup.md) | 🟠 | ☐ |

---

## 4 · Coverage matrix

| State / màn hình | Đã có ảnh | Đã chạm khi test |
|---|:---:|:---:|
| S01 home · default · scrolled · tooltip | ✅ | ☐ |
| S02 collection section · 1 item · 2 item | ✅ | ☐ |
| S03 Your collection full · filter `All` | ✅ | ☐ |
| S04 Lockscreen list · filter `All` | ✅ | ☐ |
| S05 Template preview | ✅ | ☐ |
| S06 Live Activity · **đang chạy** | ✅ | ☐ |
| S07 Live Activity · editing | ✅ | ☐ |
| S08 Add widget · step 1–3 | ✅ | ☐ |
| **Màn "Widgets" xem tất cả (93 widget)** | ❌ | ☐ |
| **Template Pro trạng thái `locked` + điểm chạm paywall** | ❌ | ☐ |
| **Live Activity trạng thái chưa chạy (nút `Start`?)** | ❌ | ☐ |
| **Item loại `Note` trong Your collection** | ❌ | ☐ |
| **`Your collection` trạng thái `empty`** | ❌ | ☐ |
| Màn hình sau khi bấm `Add to lock screen` *(H13)* | ❌ | ☐ |
| Nội dung nút `i` ở S05 *(H12)* | ❌ | ☐ |
| Discover khi **từ chối quyền Calendar** | ❌ | ☐ |
| S04 / S03 với filter **khác `All`** | ❌ | ☐ |

> Các mục ❌ ở trên **chặn** những item tương ứng: `DSC-H30`, `DSC-H31`, `DSC-N23`, `DSC-N12`, `DSC-E01`,
> `DSC-H20`. Chưa chụp bổ sung thì ghi **coverage gap**, không suy diễn kết quả.

---

## 5 · Câu hỏi cần PO / dev trả lời — `DSC-Q`

| ID | Câu hỏi | Vì sao cần |
|---|---|---|
| **DSC-Q01** | 🔴 **Ranh giới Free / Pro trong Discover nằm ở đâu?** Template nào, widget nào, live activity nào là Pro? | Chặn `DSC-N23`, `DSC-N24`. Không biết ranh giới thì **không thể kết luận có rò rỉ nội dung trả phí hay không** — mà đây là tab đặt nút 👑 |
| **DSC-Q02** | 🔴 **28 template + 93 widget + 5 live activity đến từ đâu** — bundle trong app hay tải từ server? | Quyết định hành vi offline (`DSC-N21`), dung lượng app, và có cần giám sát endpoint không |
| **DSC-Q03** | 🔴 Badge **`✓ Active Lockscreen`** dựa trên cái gì — trạng thái wallpaper thật của máy, hay chỉ là "template được bấm `Use` gần nhất"? | Là gốc của `DSC-N01`, `N02`, `N07`. Nếu chỉ là cái sau thì badge **về bản chất có thể sai**, và đó là một finding về thiết kế chứ không phải bug lẻ |
| **DSC-Q04** | `Your collection` lưu ở đâu — local, iCloud, hay backend? | `DSC-E20`. Gỡ app có mất bộ sưu tập không |
| **DSC-Q05** | Có cách nào **kiểm chứng widget đã được thêm** thật không *(WidgetKit có API đọc cấu hình widget đang đặt)*? | `DSC-N09`, `N10`. Nếu có mà không dùng thì nút "tự khai" là lựa chọn thiết kế cần xem lại |
| **DSC-Q06** | Ba động từ `Use` / `Open` / `Add` — và `Update` trong collection — là chủ ý hay do 3 team viết rời? | `DSC-E12`. Ảnh hưởng trực tiếp tới khả năng hiểu của user lần đầu |
| **DSC-Q07** | Có kế hoạch **tìm kiếm / sắp xếp** cho 93 widget không? | `DSC-H31`. Số lượng lệch quá lớn (93 vs 28 vs 5) mà cùng một kiểu duyệt |
| **DSC-Q08** | Filter **`Note`** trong Your collection sinh ra từ loại nội dung nào? Hiện có tạo được item Note không? | `DSC-H20`. Nếu chưa có thì đây là **filter chết** hiển thị cho user |
| **DSC-Q09** | Live Activity có cần quyền **Notifications** không? Xin lúc nào? | Chưa thấy dialog nào trong 55 ảnh — [permissions-matrix §1.4](../../references/permissions-matrix.md#14--notifications--chắc-chắn-cần-chưa-thấy-dialog) |
| **DSC-Q10** | Có **analytics đo phễu** `mở Discover → bấm Use → mở Shortcut → wallpaper đổi thật` không? | Đây là phễu chuyển đổi chính của sản phẩm. Không có số → **gap về đo lường** |
| **DSC-Q11** | Bấm `Use` template khác **sau khi** đã setup automation — template mới có tự áp dụng cho lần chạy sau không, hay phải chạy shortcut tay lại? | `DSC-E19`. Quyết định user hiểu "đổi template" là thao tác 1 bước hay 2 bước |

---

## 6 · Smoke 15 phút cho flow này

| # | Việc | ID | Thời lượng |
|:---:|---|---|:---:|
| 1 | Mở app → `Use` một template → **đóng tooltip, không mở Shortcuts** → xem collection có gắn badge `✓ Active Lockscreen` không | `DSC-N01` | 3 phút |
| 2 | Đặt Calendar = `Add Events Only` trong Settings → mở template preview S05 → xem hiện gì | `DSC-N13` | 3 phút |
| 3 | Bấm `I've added the widget` **mà không thêm widget** → xem app kết luận gì | `DSC-N09` | 2 phút |
| 4 | Rà toàn bộ Discover tìm dấu hiệu nội dung **Pro / locked** — có hay không, chụp lại | `DSC-N23` | 3 phút |
| 5 | Bật **Airplane Mode** → kill app → mở lại Discover → 3 section còn nội dung không | `DSC-N21` | 2 phút |
| 6 | Mở S05 preview → đối chiếu từng dòng với tab Calendar | `DSC-H10` | 2 phút |

---

## 7 · Kết luận phiên

```
Phiên: __________   Build: 1.2.10 (27)   iOS: ______   Thiết bị: __________

Q1 Mục tiêu user:            chọn được thiết kế hợp gu và đưa được nó lên máy mình
Q8 Mục tiêu business:        tab mặc định + phễu duy nhất dẫn sang paywall
— Chạy luồng chính —
Q2 Xong dễ lần đầu?          Có / Không — vì: __________
Q3 Điểm khựng/bối rối:       __________________________
   (3 động từ Use/Open/Add?  vì sao bấm Use mà wallpaper không đổi?)
Q4 Thao tác sai / gián đoạn: __________________________
Q5 State chưa test:          __________________________
   (locked · empty collection · màn 93 widget · live activity chưa chạy · item Note)
— Kết luận —
Q6 Rủi ro #1 nếu ship:       __________________________
Q7 Tự mình dùng hằng ngày?   Có / Không — vì: __________
Q9 15 phút thì test gì:      §6

=> Verdict: 🟢 / 🟡 / 🔴  — kèm bằng chứng
```

**Ngưỡng cho riêng flow này:**

| Verdict | Điều kiện |
|---|---|
| 🔴 | Badge `✓ Active Lockscreen` khẳng định sai trạng thái thật của máy *(N01/N02/N07)* · preview trống không lời giải thích khi thiếu quyền *(N12/N13)* · nội dung Pro dùng được mà không trả tiền *(N23/N24)* · Discover trống khi offline *(N21)* · crash/màn trắng ở tab mặc định |
| 🟡 | Ba động từ gây hiểu nhầm nhưng vẫn làm được *(E12)* · tìm widget trong 93 cái quá lâu vì không có tìm kiếm *(H31)* · nút `I've added the widget` tự khai nhưng có đường sửa sai · caption bị cắt *(E15)* |
| 🟢 | Người lần đầu hiểu vì sao bấm `Use` chưa đổi wallpaper ngay và đi được tới cuối *(H15→H18)* · preview khớp dữ liệu thật *(H10)* · mọi trạng thái badge phản ánh đúng thực tế · thiếu quyền có màn giải thích gọi đúng tên lựa chọn |

---

## 8 · Ghi chú về giới hạn checklist này

- **5 màn hình / trạng thái chưa có ảnh** *(xem §4)*. Sáu item `DSC-H12`, `H13`, `H20`, `H30`, `H31`,
  `N23`, `E01` đang bị chặn một phần — chạy được nhưng **không đối chiếu được với thiết kế**. Cần chụp bổ sung
  trước khi kết luận đúng/sai.
- **`DSC-Q01` chặn cả nhóm paywall.** Chưa biết template nào là Pro thì `N23`, `N24` chỉ dừng ở mức khảo sát,
  không kết luận được là rò rỉ hay đúng thiết kế.
- **`DSC-Q03` chặn cả nhóm badge.** Nếu badge chỉ phản ánh "template bấm gần nhất" thì `N01`, `N02`, `N07`
  là **một finding về thiết kế**, không phải 3 bug rời rạc — viết chung một cái.
- **`DSC-H18`, `H25`, `H29`, `E19` không kết luận được nếu chưa xong Flow 03.** Ba loại nội dung đều chỉ
  chứng minh được ở ngoài app. Chạy Flow 03 trước, hoặc ghi là gap.
- **`DSC-E19` cần chờ qua đêm** — không rút ngắn bằng cách đổi giờ hệ thống, xem cảnh báo ở
  [03_shortcut-setup §10](03_shortcut-setup.md#10--smoke-cho-flow-này).
- **Cần người chưa từng dùng app** cho `DSC-H16`, `H31`, `E12`. Người đã đọc wireframe không đo được mấy mục này.
