# Exploratory Checklist — 03 Shortcut Setup & Automation

> **Nguồn:** [wireframe](../ui/ux/wideframes/03_shortcut-setup.md) · 9 screenshot ·
> [phân tích case đầy đủ](../../references/shortcut-flow-cases.md)
> **Khung đánh giá:** [exploratory-references](../../references/exploratory-references.md)
> **Build:** TestFlight 1.2.10 (27) · **Thiết bị:** ____________ · **iOS:** ____________ · **Người test:** ____________

---

## 0 · Framing

**Q1 — Mục tiêu user:** làm **một lần duy nhất** để từ đó mỗi sáng lock screen tự đổi — user không muốn hiểu
Shortcuts, họ muốn "cài xong rồi quên".

**Q8 — Mục tiêu business:** đây là **điều kiện sống của sản phẩm**. User không hoàn tất flow này thì Ink chỉ
còn là một app lịch tầm thường, không có lý do trả tiền. Mọi rơi rớt ở đây là mất doanh thu trực tiếp.

**Vì sao flow này khác mọi flow khác:**
- **4/9 màn hình nằm ngoài app** — Ink không kiểm soát UI, không đọc được trạng thái, không sửa được.
- **10 mắt xích điều kiện**, chỉ 2 nằm trong Ink. Xem
  [chuỗi điều kiện](../../references/shortcut-flow-cases.md#1--chuỗi-điều-kiện--thứ-phải-đúng-để-wallpaper-đổi-mỗi-sáng).
- **Phần lớn kiểu đứt không phát ra tín hiệu nào.** 7 nguyên nhân khác nhau cho ra **cùng một triệu chứng**
  user nhìn thấy: "wallpaper không đổi".

> ⚠️ **Quy tắc bắt buộc của flow này:** setup xong **không** có nghĩa là pass.
> **Chỉ ngày thứ 2 mới chứng minh được automation chạy.** Mọi kết luận trước đó là vô giá trị.

> ⚠️ **Về hành vi iOS:** các mục liên quan `E3`, `E10`, `E11`, `E20` phụ thuộc phiên bản iOS. Phải test trên
> **đúng dải iOS app hỗ trợ**, không suy từ tài liệu, không suy từ máy khác.

---

## 1 · Happy path — `SCT-H`

### 1.1 · Ngày 1 — setup

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **SCT-H01** | Máy sạch đã cấp quyền Calendar. Mở guide từ onboarding | S01 · modal 2 bước · pager `● ○` · CTA `Tap to add shortcut` | — | ☐ |
| **SCT-H02** | Bấm CTA | Rời Ink → app Shortcuts mở đúng trang shortcut · banner `◀ Ink` góc trái | ⏱ độ trễ deep link | ☐ |
| **SCT-H03** | Đọc trang shortcut | Tên **Generate Latest Wallpaper** · ngày chia sẻ · mô tả About | Tên có khớp với tên Ink dò không *(xem SCT-Q03)* | ☐ |
| **SCT-H04** | Bấm `Add Shortcut` | Về **All Shortcuts**, shortcut mới nằm **đầu** danh sách | — | ☐ |
| **SCT-H05** | Bấm card shortcut để chạy lần đầu | Dialog **D1** *"…run actions from Ink?"* | — | ☐ |
| **SCT-H06** | `Allow` | Dialog **D2** *"…set a wallpaper?"* | — | ☐ |
| **SCT-H07** | `Allow` | Dialog **D3** *"…output 1 wallpaper?"* **kèm preview wallpaper** | Preview có đúng template đã chọn không | ☐ |
| **SCT-H08** | **`Always Allow`** ⚠️ | Tự quay về Ink · overlay ✓ **"Shortcut is working!"** | ⏱ tổng thời gian từ H05 | ☐ |
| **SCT-H09** | Xem tiếp | S08 · guide 2/2 · pager `○ ●` · CTA `Open Automations` | — | ☐ |
| **SCT-H10** | Bấm CTA | App Shortcuts · màn **Personal Automation** · `Time of Day` ở đầu | — | ☐ |
| **SCT-H11** | Chọn `Time of Day` → đặt giờ → `Next` | Màn chọn shortcut | ⚠️ **coverage gap** — không có ảnh, ghi lại màn hình thấy được | ☐ |
| **SCT-H12** | Tìm và chọn `Generate Latest Wallpaper` | Automation tạo xong | Số bước user phải **tự mò** không có hướng dẫn | ☐ |
| **SCT-H13** | Kiểm `Run Immediately` | Phải **BẬT** | Mặc định của iOS là gì? *(xem SCT-N14)* | ☐ |
| **SCT-H14** | Vào tab Automation kiểm lại | Automation hiện trong danh sách, đúng giờ, đúng shortcut | — | ☐ |
| **SCT-H15** | Khoá máy, xem lock screen | Wallpaper hiện lịch **đúng ngày hôm nay** | — | ☐ |

**Đo cho cả đoạn ngày 1:** ⏱ tổng thời gian H01→H14 với người **chưa từng dùng Shortcuts** · số lần rời/quay
lại giữa 2 app *(kỳ vọng: 2)* · số lần user hỏi "giờ làm gì tiếp".

### 1.2 · Ngày 2 trở đi — **đây mới là phép thử thật**

| ID | Việc làm | Phải quan sát được | ☐ |
|---|---|---|:---:|
| **SCT-H16** | Hôm sau, **sau giờ hẹn**, khoá máy xem lock screen | Wallpaper **tự đổi** sang lịch ngày mới, **không thao tác gì** | ☐ |
| **SCT-H17** | Đối chiếu nội dung wallpaper với app Calendar | Trùng khớp event của đúng ngày hôm đó | ☐ |
| **SCT-H18** | Ngày thứ 3 | Vẫn tự đổi — loại trừ khả năng ngày 2 chỉ là dư âm | ☐ |
| **SCT-H19** | Kiểm có **thông báo lạ** nào mỗi sáng không | iOS không hỏi gì, không banner "Automation ran" bắt bấm | ☐ |

---

## 2 · Negative — ba dialog quyền · `SCT-N01`–`N05`

Chỉ có **5 đường đi có nghĩa** *(từ chối sớm thì dừng chuỗi)*. Test đủ cả 5, mỗi lần làm lại trên máy sạch
hoặc xoá shortcut đi làm lại.

| ID | D1 run actions | D2 set wallpaper | D3 output | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|---|---|:---:|:---:|
| **SCT-N01** | ❌ Don't Allow | — | — | Shortcut dừng · **Ink biết chưa xong**, không hiện ✓ thành công | Ink vẫn báo thành công, user tưởng xong | 🔴 | ☐ |
| **SCT-N02** | ✅ | ❌ Don't Allow | — | Báo lỗi rõ · Ink không hiện ✓ | Chạy tới cuối, Ink báo ✓, wallpaper **không bao giờ** đổi | 🔴 | ☐ |
| **SCT-N03** | ✅ | ✅ | ❌ Don't Allow | Báo lỗi rõ · Ink không hiện ✓ | Như trên — đây là dialog **cuối**, dễ lọt nhất nếu Ink chỉ dựa vào "shortcut chạy xong" | 🔴 | ☐ |
| **SCT-N04** | ✅ | ✅ | ⚠️ **Allow Once** | Ink **phát hiện** và cảnh báo phải chọn `Always Allow` | 🔴 **Mọi thứ trông như thành công.** Wallpaper đổi ngay, Ink hiện ✓. **Hôm sau automation chết im lặng** | 🔴 | ☐ |
| **SCT-N05** | ✅ | ✅ | ✅ Always Allow | = happy path | — | — | ☐ |

### SCT-N04 — quy trình kiểm bắt buộc *(rủi ro số 1 toàn sản phẩm)*

| ID | Bước | Phải ghi lại | ☐ |
|---|---|---|:---:|
| **SCT-N04a** | Chọn `Allow Once` → so sánh màn hình Ink với luồng `Always Allow` | Có **khác gì không**? Chụp cả 2 để đối chiếu | ☐ |
| **SCT-N04b** | Chờ **qua đêm**, tới giờ hẹn hôm sau | Wallpaper có đổi không? Có notification lỗi không, hay im lặng? | ☐ |
| **SCT-N04c** | Mở lại Ink sau khi automation đã fail | App có **tự phát hiện** wallpaper chưa cập nhật không? Có nhắc gì không? | ☐ |
| **SCT-N04d** | Chạy shortcut **tay** lại | Có hỏi lại dialog D3 không? Nếu có, đây là đường phục hồi — user có được chỉ đường không? | ☐ |
| **SCT-N04e** | Đọc lại toàn bộ nội dung guide S01 và S08 | Có **một chữ nào** nhắc tới `Always Allow` không? *(Quan sát hiện tại: không)* | ☐ |

---

## 3 · Negative — bỏ dở & điều hướng · `SCT-N06`–`N13`

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **SCT-N06** | Ở S02, thoát về Ink **không bấm** `Add Shortcut` | Ink biết chưa thêm, vẫn ở guide 1/2 | Nhảy sang bước 2/2 hoặc báo ✓ | 🔴 | ☐ |
| **SCT-N07** | Đóng modal guide bằng ✕ ở bước 1/2 | Ink nhắc lại sau, hoặc Discover hiện trạng thái "chưa setup" | Im lặng, user không biết còn dở | 🟠 | ☐ |
| **SCT-N08** | Thêm shortcut xong nhưng **không quay lại Ink** vài giờ | Mở lại Ink → nhớ đang ở giữa flow | Bắt đầu lại từ đầu → dễ tạo shortcut trùng | 🟠 | ☐ |
| **SCT-N09** | 🔴 Sau S07 ✓ "Shortcut is working!", **đóng guide, không tạo automation** | Ink phân biệt *"đã thêm shortcut"* vs *"đã tự động hoá"* và nhắc tiếp | App coi như hoàn tất. **Rất dễ xảy ra** vì dấu ✓ đặt trước bước 2 tạo cảm giác đã xong | 🔴 | ☐ |
| **SCT-N10** | Ở S08, bấm `Back` | Về S01 đúng chứ? Trạng thái shortcut đã thêm còn giữ? | Mất tiến trình, phải thêm shortcut lại | 🟡 | ☐ |
| **SCT-N11** | Vào Settings → `Set up shortcut` **sau khi đã setup xong** | Ink phát hiện đã có, không tạo trùng, hoặc hỏi trước | Thư viện có **2 shortcut trùng tên** → automation gán bản nào? | 🟠 | ☐ |
| **SCT-N12** | Bấm `Tap to add shortcut` **2 lần liên tiếp** | Chỉ mở 1 lần | Mở 2 tab Shortcuts / thêm 2 bản | 🟡 | ☐ |
| **SCT-N13** | Ở màn Personal Automation, bấm ✕ thoát không tạo gì | Quay về Ink, Ink biết automation chưa tạo | Ink coi như xong | 🔴 | ☐ |

---

## 4 · Negative — cấu hình automation sai · `SCT-N14`–`N19`

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **SCT-N14** | 🔴 Tạo automation **không bật** `Run Immediately` *(để `Ask Before Running`)* | Guide phải nhắc bật · Ink phát hiện được thì càng tốt | Mỗi sáng iOS gửi thông báo **hỏi** — không bấm thì wallpaper không đổi. Guide **không nhắc một chữ nào** | 🔴 | ☐ |
| **SCT-N14a** | Ghi lại **mặc định của iOS** cho `Run Immediately` trên đúng bản iOS đang test | Bật hay tắt sẵn? | Quyết định mức nghiêm trọng của N14 | — | ☐ |
| **SCT-N15** | Chọn trigger **khác** `Time of Day` — thử `Alarm` | Wallpaper đổi theo báo thức. Hành vi có hợp lý không? | Ink không biết, coi như đã setup đúng | 🟠 | ☐ |
| **SCT-N16** | Chọn trigger **không bao giờ xảy ra** *(vd `Airplane Mode`)* | Automation im luôn | Ink không có cách nào biết | 🟠 | ☐ |
| **SCT-N17** | Gán **nhầm shortcut khác** cho automation | Automation chạy việc khác | Ink không phát hiện được | 🟠 | ☐ |
| **SCT-N18** | Đặt giờ hẹn vào lúc **đêm khuya / user đang ngủ** *(máy khoá)* | Xem [SCT-E01](#61--thời-điểm-automation-chạy) — đây là **kịch bản mặc định** mà guide gợi ý | Nếu Set Wallpaper không chạy khi máy khoá → automation vô dụng với **mọi user** | 🔴 | ☐ |
| **SCT-N19** | Tạo **2 automation** cùng gọi shortcut này ở 2 giờ khác nhau | Cả 2 chạy được, không xung đột | Xung đột, hoặc wallpaper nhấp nháy | 🟡 | ☐ |

---

## 5 · Negative — phá vỡ sau khi đã setup xong · `SCT-N20`–`N27`

Chạy sau khi happy path đã pass ngày 2. Mỗi mục: phá → chờ tới giờ hẹn → quan sát.

| ID | Phá cái gì | Câu hỏi phải trả lời | Mức | ☐ |
|---|---|---|:---:|:---:|
| **SCT-N20** | **Xoá shortcut** khỏi thư viện | Automation thành mồ côi? Ink có phát hiện không? Mở Ink có nhắc setup lại không? | 🔴 | ☐ |
| **SCT-N21** | **Xoá automation** | Ink có biết không? Có nhắc tạo lại không? | 🔴 | ☐ |
| **SCT-N22** | **Tắt automation** *(không xoá)* | Như trên | 🔴 | ☐ |
| **SCT-N23** | **Rút quyền Calendar** của Ink | ⚠️ Shortcut chạy nhưng Ink không đọc được lịch → vẽ wallpaper **trống** và **ghi đè mất wallpaper đang có**? Hay dừng an toàn? | 🔴 | ☐ |
| **SCT-N24** | Đặt Calendar = **`Add Events Only`** | Cùng nhóm N23 — app mù nhưng vẫn "có quyền". Wallpaper ra gì? | 🔴 | ☐ |
| **SCT-N25** | **Gỡ app Shortcuts** | Deep link `Tap to add shortcut` đi đâu? Crash? Mở App Store? | 🟠 | ☐ |
| **SCT-N26** | **Gỡ và cài lại Ink** | Shortcut + automation còn nguyên nhưng trỏ tới app đã mất dữ liệu. Chạy ra gì? Ink có nhận ra shortcut cũ để **khỏi bắt setup lại** không? | 🟠 | ☐ |
| **SCT-N27** | **Đổi tên shortcut** trong Shortcuts | Ink dò theo **tên** hay **ID**? Nếu theo tên thì mất dấu | 🟡 | ☐ |

---

## 6 · Edge — thời điểm & môi trường · `SCT-E`

### 6.1 · Thời điểm automation chạy

| ID | Tình huống | Câu hỏi | Mức | ☐ |
|---|---|---|:---:|:---:|
| **SCT-E01** | 🔴 Máy **đang khoá** lúc tới giờ hẹn | Action *Set Wallpaper* có chạy được không? **Guide gợi ý mặc định "At 8:00 AM, weekdays"** — chính là lúc user còn ngủ, máy khoá. Nếu không chạy được thì automation vô dụng với gần như mọi user | 🔴 | ☐ |
| **SCT-E02** | Máy **tắt nguồn** lúc tới giờ | Chạy bù khi bật lại, hay bỏ luôn ngày đó? | 🟠 | ☐ |
| **SCT-E03** | **Low Power Mode** | Automation bị hoãn/bỏ? | 🟠 | ☐ |
| **SCT-E04** | **Ink bị force-quit** *(vuốt khỏi app switcher)* trước giờ hẹn | Shortcut có gọi được App Intent của app đã bị đóng cứng không? *(Nhiều user có thói quen vuốt tắt app)* | 🔴 | ☐ |
| **SCT-E05** | **Đổi múi giờ** — bay sang nước khác | Automation chạy theo giờ mới hay giờ cũ? Event trên wallpaper có đúng giờ địa phương không? | 🟠 | ☐ |
| **SCT-E06** | Automation đặt **00:00–01:00** | Vẽ lịch của ngày nào — ngày vừa qua hay ngày mới? | 🟡 | ☐ |
| **SCT-E07** | **Focus / Do Not Disturb** đang bật | Có ảnh hưởng automation không? | 🟡 | ☐ |
| **SCT-E08** | Chạy **tay** đúng lúc automation đang chạy | Race condition? Wallpaper hỏng? | 🟡 | ☐ |
| **SCT-E09** | **Offline** hoàn toàn lúc automation chạy | ⚠️ Ink có event từ **Google Calendar** không? Nếu có → vẽ thiếu event Google mà **không báo**. Dừng lại an toàn hơn nhiều so với vẽ dữ liệu thiếu | 🔴 | ☐ |
| **SCT-E10** | Mạng **chập chờn** lúc chạy | Chờ bao lâu rồi bỏ cuộc? Shortcut có bị iOS kill vì chạy quá lâu không? | 🟠 | ☐ |

### 6.2 · Dữ liệu

| ID | Tình huống | Câu hỏi | Mức | ☐ |
|---|---|---|:---:|:---:|
| **SCT-E11** | Ngày **không có event nào** | Wallpaper vẽ panel trống? Có ẩn panel đi không? Có giữ nguyên wallpaper cũ không? | 🟡 | ☐ |
| **SCT-E12** | **50+ event** trong ngày | Render bao lâu? Shortcut có bị iOS timeout không? Panel cắt thế nào? | 🟠 | ☐ |
| **SCT-E13** | Event tên **rất dài** / emoji / tiếng Việt có dấu | Xuống dòng đúng? Tràn panel? Dấu tiếng Việt vỡ font? | 🟡 | ☐ |
| **SCT-E14** | **Tắt hết calendar** ở sheet Calendars | Wallpaper vẽ trống hay giữ nguyên cái cũ? | 🟠 | ☐ |
| **SCT-E15** | **Xoá template** đang dùng khỏi collection | Automation vẫn chạy → vẽ bằng gì? Fallback về template mặc định hay lỗi? | 🟠 | ☐ |
| **SCT-E16** | **Đổi template** trong app sau khi setup | Lần chạy kế tiếp có dùng template mới không? *(Kiểm mối nối giữa Flow 04 và 03)* | 🟠 | ☐ |
| **SCT-E17** | **Bộ nhớ máy đầy** | Không lưu được ảnh → shortcut lỗi im lặng? Wallpaper cũ giữ nguyên? | 🟡 | ☐ |

### 6.3 · Vòng đời máy, tài khoản & **di trú**

| ID | Tình huống | Câu hỏi | Mức | ☐ |
|---|---|---|:---:|:---:|
| **SCT-E18** | 🔴 **Ink phát hành shortcut phiên bản mới** | Shortcut là **bản sao local** trong máy user — họ giữ **bản cũ vĩnh viễn**. Có cơ chế nào thông báo/di trú không? Bản cũ chạy với app mới có lỗi không? **Đây là nợ kỹ thuật tích luỹ theo thời gian** | 🔴 | ☐ |
| **SCT-E19** | 🔴 **Link iCloud của shortcut bị thu hồi / hết hạn** | Shortcut chia sẻ qua link iCloud *(Shared 18 May 2026)*. Link chết → **mọi user mới không setup được**. Đây là rủi ro **phía server**, một điểm hỏng ảnh hưởng toàn bộ. Có giám sát không? | 🔴 | ☐ |
| **SCT-E20** | **Khôi phục máy từ backup** | Shortcut còn? Automation còn? Quyền còn? Nếu chỉ mất 1 trong 3 → hỏng im lặng | 🟠 | ☐ |
| **SCT-E21** | **Đổi sang máy mới** | Phải setup lại toàn bộ? Ink có nhận ra và hướng dẫn, hay im lặng để user tưởng vẫn chạy? | 🟠 | ☐ |
| **SCT-E22** | **Cập nhật iOS lớn** | Automation/shortcut có bị vô hiệu không? *(Đã từng xảy ra với nhiều app dùng Shortcuts)* | 🟠 | ☐ |
| **SCT-E23** | User có **nhiều lock screen theo Focus** | *Set Wallpaper* ghi đè cái nào — cái đang hiển thị hay tất cả? | 🟠 | ☐ |
| **SCT-E24** | Wallpaper hiện tại là **Photo Shuffle** | Ghi đè được không? iOS chặn? | 🟡 | ☐ |
| **SCT-E25** | User dùng **app wallpaper khác** cũng đặt lock screen | Hai automation tranh nhau — ai chạy sau thắng. Có xung đột rõ rệt không? | 🟡 | ☐ |
| **SCT-E26** | Máy đã có shortcut **trùng tên** từ trước | Thêm vào thành 2 bản? iOS tự đổi tên? | 🟡 | ☐ |
| **SCT-E27** | **Screen Time / MDM** chặn Shortcuts | Deep link dẫn tới đâu? Có thông báo phù hợp không? | 🟡 | ☐ |
| **SCT-E28** | Chưa đăng nhập **iCloud** | Thêm shortcut qua link iCloud có cần đăng nhập không? | 🟡 | ☐ |
| **SCT-E29** | **Đổi ngôn ngữ máy** | Nếu Ink dò shortcut theo tên tiếng Anh — đổi ngôn ngữ có mất dấu không? | 🟡 | ☐ |

### 6.4 · Giao với mô hình kinh doanh

| ID | Tình huống | Câu hỏi | Mức | ☐ |
|---|---|---|:---:|:---:|
| **SCT-E30** | 🔴 Chọn **template Pro** trong lúc dùng thử → **hết hạn dùng thử** | Automation vẫn vẽ template Pro mỗi sáng? Nếu có → **user không có lý do trả tiền**, rò doanh thu ngay trong mô hình giá | 🔴 | ☐ |
| **SCT-E31** | **Huỷ subscription** sau khi setup | Wallpaper có hạ về template free không? Có báo cho user không? | 🔴 | ☐ |
| **SCT-E32** | Shortcut chạy khi **subscription hết hạn** | Vẽ template free? Watermark? Hay dừng hẳn giữ wallpaper cũ? | 🟠 | ☐ |

> Kiểm tra quyền Pro phải xảy ra **bên trong shortcut / app extension** vì automation chạy ngoài app — đây là
> chỗ rất dễ bị bỏ sót khi implement.

---

## 7 · Khả năng tự chẩn đoán của app · `SCT-D`

7 nguyên nhân khác nhau cho ra **cùng một triệu chứng**. Mục này kiểm: Ink có phát hiện được mắt xích nào đứt
không — hay để user tự mò.

| ID | Mắt xích bị đứt | Ink có phát hiện? | Ink có báo cho user? | Ink có chỉ cách sửa? | ☐ |
|---|---|:---:|:---:|:---:|:---:|
| **SCT-D01** | Shortcut chưa được thêm | ☐ | ☐ | ☐ | ☐ |
| **SCT-D02** | Shortcut đã bị xoá | ☐ | ☐ | ☐ | ☐ |
| **SCT-D03** | Quyền D3 chỉ là `Allow Once` | ☐ | ☐ | ☐ | ☐ |
| **SCT-D04** | Automation chưa được tạo | ☐ | ☐ | ☐ | ☐ |
| **SCT-D05** | Automation bị xoá / tắt | ☐ | ☐ | ☐ | ☐ |
| **SCT-D06** | `Ask Before Running` đang bật | ☐ | ☐ | ☐ | ☐ |
| **SCT-D07** | Quyền Calendar bị rút | ☐ | ☐ | ☐ | ☐ |
| **SCT-D08** | Lần chạy gần nhất **thất bại** | ☐ | ☐ | ☐ | ☐ |
| **SCT-D09** | Wallpaper **quá cũ** *(>24h chưa cập nhật)* | ☐ | ☐ | ☐ | ☐ |

**Câu hỏi bao trùm:** có **một chỗ duy nhất** nào trong app cho biết *"mọi thứ đang hoạt động / có gì đó
hỏng"* không? Nếu không → user và cả support đều không có cách chẩn đoán.

> Tham chiếu [cây chẩn đoán](../../references/shortcut-flow-cases.md#5--cây-chẩn-đoán-khi-wallpaper-không-đổi)
> — đây chính là quy trình mà **app nên tự làm thay user**.

---

## 8 · Coverage matrix

| State | Đã có ảnh | Đã chạm khi test |
|---|:---:|:---:|
| S01–S09 · happy path | ✅ | ☐ |
| Bước đặt giờ + gán shortcut *(H11, H12)* | ❌ **không có ảnh** — chỗ user tự mò nhiều nhất | ☐ |
| Automation đã tạo xong *(màn xác nhận)* | ❌ | ☐ |
| Đường từ chối D1 / D2 / D3 | ❌ | ☐ |
| `Allow Once` — trạng thái Ink sau đó | ❌ | ☐ |
| Ink khi setup **đã hoàn tất** *(vào lại từ Settings)* | ❌ | ☐ |
| Ink khi phát hiện automation hỏng | ❌ *(có thể không tồn tại)* | ☐ |
| Ngày 2 · ngày 3 · sau 1 tuần | ❌ | ☐ |

---

## 9 · Câu hỏi cần PO / dev trả lời — `SCT-Q`

| ID | Câu hỏi | Vì sao cần |
|---|---|---|
| **SCT-Q01** | 🔴 **Ink dò shortcut bằng cơ chế nào** — tên, ID, hay không dò gì cả? | Quyết định N20, N27, E29 có kiểm được không. Nếu không dò gì thì toàn bộ mục `SCT-D` đều fail sẵn |
| **SCT-Q02** | 🔴 App có **ghi lại thời điểm chạy gần nhất** của shortcut không? | Là điều kiện tối thiểu để làm được D08, D09 — và để support chẩn đoán từ xa |
| **SCT-Q03** | Shortcut có cần quyền **Photos** không? *(ghi ảnh trước khi set wallpaper)* | Chưa thấy dialog Photos nào trong 57 ảnh |
| **SCT-Q04** | 🔴 **Kế hoạch cập nhật shortcut** khi logic đổi? User cũ giữ bản cũ vĩnh viễn — có versioning không? | E18 — nợ kỹ thuật tích luỹ, càng nhiều user càng khó gỡ |
| **SCT-Q05** | 🔴 **Link iCloud shortcut có được giám sát** không? Ai sở hữu? Hết hạn khi nào? | E19 — một điểm hỏng chặn **toàn bộ user mới** |
| **SCT-Q06** | Kiểm quyền **Pro** nằm ở đâu — trong app hay trong shortcut/extension? | E30–E32. Nếu chỉ kiểm trong app thì automation lách được hoàn toàn |
| **SCT-Q07** | Có **analytics đo rơi rớt** từng bước H01→H14 không? | Không có → **gap về đo lường**. Đây là flow cần số nhất |
| **SCT-Q08** | Vì sao đặt màn ✓ **"Shortcut is working!"** trước bước automation? | N09 — dấu ✓ tạo cảm giác đã xong. Đề xuất đổi thành *"Bước 1/2 xong"* |
| **SCT-Q09** | Có kế hoạch bổ sung hướng dẫn **`Always Allow`** và **`Run Immediately`** vào guide không? | N04, N14 — lần thứ 1 và 2 của cùng mẫu lỗi *(lần 3 là `Full Access`)* |
| **SCT-Q10** | Dải **iOS** nào được hỗ trợ chính thức? | E01, E22 và mặc định `Run Immediately` đổi theo phiên bản — không chốt được dải thì không kết luận được |

---

## 10 · Smoke cho flow này

> ⚠️ Flow này **không có smoke 15 phút thật sự** — mọi thứ quan trọng đều cần **chờ qua đêm**.
> Dưới đây là bộ tối thiểu, chia 2 đợt.

**Đợt 1 — 15 phút, làm ngay**

| # | Việc | Thời lượng |
|:---:|---|:---:|
| 1 | **SCT-H01→H15** — setup đầy đủ, bấm giờ, đếm số lần tự mò | 8 phút |
| 2 | **SCT-N09** — bỏ bước automation, xem app có nhắc không | 3 phút |
| 3 | **SCT-N23** — rút quyền Calendar, chạy shortcut tay, xem có ghi đè wallpaper trống không | 3 phút |
| 4 | **SCT-D01→D09** — rà nhanh app có chỗ nào báo trạng thái không | 1 phút |

**Đợt 2 — cần chờ thật, không rút ngắn được**

| # | Việc | Thời gian chờ |
|:---:|---|:---:|
| 5 | **SCT-H16→H18** — xác nhận automation chạy ngày 2 và ngày 3 | 2 đêm |
| 6 | **SCT-N04b** — máy khác, chọn `Allow Once`, chờ qua đêm | 1 đêm |
| 7 | **SCT-E01** — đặt giờ lúc chắc chắn máy đang khoá | 1 đêm |
| 8 | **SCT-E04** — force-quit Ink rồi chờ automation | 1 đêm |

> 🔴 **Không rút ngắn bằng cách đổi giờ hệ thống.** Đổi giờ hệ thống có thể **chính nó** làm automation không
> chạy, dẫn tới kết luận sai. Phải chờ thời gian thực.

---

## 11 · Kết luận phiên

```
Phiên: __________   Build: 1.2.10 (27)   iOS: ______   Thiết bị: __________
Ngày bắt đầu: ______   Ngày xác nhận ngày-2: ______

Q1 Mục tiêu user:            cài một lần rồi quên, mỗi sáng lock screen tự đổi
Q8 Mục tiêu business:        điều kiện sống của sản phẩm
— Ngày 1 —
Setup xong trong bao lâu:    ______ phút · số lần tự mò: ______
Q3 Điểm khựng/bối rối:       ______________________________
— Ngày 2 (BẮT BUỘC) —
Wallpaper có tự đổi?         Có / Không
Nếu không, nguyên nhân:      ______________________________
— Kết luận —
Q6 Rủi ro #1 nếu ship:       ______________________________
Q7 Tự mình dùng hằng ngày?   Có / Không — vì: __________
Q5 State chưa test:          ______________________________

=> Verdict: 🟢 / 🟡 / 🔴  — kèm bằng chứng
```

**Ngưỡng cho riêng flow này:**

| Verdict | Điều kiện |
|---|---|
| 🔴 | Ngày 2 wallpaper **không tự đổi** · `Allow Once` hỏng im lặng mà app không cảnh báo · Set Wallpaper không chạy khi máy khoá · rút quyền Calendar làm **ghi đè wallpaper trống** · template Pro vẫn chạy sau khi hết hạn |
| 🟡 | Ngày 2 chạy đúng nhưng người mới **không tự setup nổi** nếu không có người chỉ · app không phát hiện được bất kỳ mắt xích đứt nào · guide không nhắc `Always Allow` / `Run Immediately` |
| 🟢 | Người chưa từng dùng Shortcuts setup xong không cần hỏi ai · ngày 2 và ngày 3 tự đổi · ít nhất phát hiện được các mắt xích đứt phổ biến và chỉ được cách sửa |

---

## 12 · Ghi chú về giới hạn checklist này

- **Không mục nào ở §5, §6.1, §6.3 kết luận được trong một phiên.** Chúng cần chờ qua đêm, có mục cần vài ngày.
  Lên lịch trước, đừng để tới cuối sprint.
- **§7 `SCT-D` phụ thuộc `SCT-Q01` và `SCT-Q02`.** Nếu app không dò shortcut và không ghi log lần chạy cuối
  thì toàn bộ 9 mục đó fail sẵn — khi đó ghi **một** finding về khả năng chẩn đoán, không ghi 9 bug rời rạc.
- **Mọi phát biểu về hành vi iOS phải kiểm trên máy thật.** Đặc biệt E01 *(máy khoá)*, E04 *(force-quit)*,
  N14a *(mặc định Run Immediately)* — chúng đổi theo phiên bản iOS và là nền của nhiều kết luận khác.
- **E18, E19 không kiểm được bằng cách bấm app** — cần hỏi dev/PO, đưa vào `SCT-Q04`, `SCT-Q05`.
- Cần **ít nhất 2 máy** để test song song `Always Allow` và `Allow Once`, vì mỗi máy chỉ hỏi dialog một lần.
