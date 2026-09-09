# Exploratory Checklist — 05 Calendar

> **Nguồn:** [wireframe](../ui/ux/wideframes/05_calendar.md) · 11 screenshot ·
> [index screenshot](../ui/ux/screenshots/iphone/index.md#05_calendar--tab-calendar)
> **Khung đánh giá:** [exploratory-references](../../references/exploratory-references.md) ·
> [permissions-matrix](../../references/permissions-matrix.md)
> **Build:** TestFlight 1.2.10 (27) · **Thiết bị:** ____________ · **iOS:** ____________ · **Người test:** ____________

---

## 0 · Framing

**Q1 — Mục tiêu user:** xem lịch của mình theo nhiều cách, và **sửa được nó ngay tại đây** thay vì phải mở
Apple Calendar. Đây cũng là nơi user chọn calendar nào được đưa lên lock screen.

**Q8 — Mục tiêu business:** tab này quyết định Ink là **app quản lý lịch** hay chỉ là **công cụ trang trí lock
screen** — [câu hỏi Q1 chưa có lời đáp](../../references/exploratory-references.md#q1--user-mở-ink-để-làm-gì).
Nếu Ink chỉ đọc để vẽ wallpaper thì tab này là phụ. Nếu Ink muốn thay Apple Calendar thì mọi khiếm khuyết
dưới đây là chặn.

**Vì sao flow này khác mọi flow khác:**

> 🔴 **Đây là flow duy nhất Ink GHI vào dữ liệu gốc của người dùng.** Mọi flow khác chỉ đọc. Ở đây một thao
> tác sai làm **mất event thật trong Apple Calendar / iCloud / Google**, ảnh hưởng cả những người được mời
> trong event đó. Vùng rủi ro mất dữ liệu cao nhất toàn sản phẩm —
> [§1.4](../../references/exploratory-references.md#14--đồng-bộ-2-chiều-với-apple-calendar--reminders-có-làm-mất-dữ-liệu-không).

**Vấn đề đã nhận diện trong wireframe — đã chuyển thành item, không để người test tự phát hiện lại:**

| # | Vấn đề | Item |
|---|---|---|
| 1 | 🔴 Không mở được chi tiết event ở Day/Week/Month → mất luôn sửa & xoá | `CAL-N01`–`N05` |
| 2 | Nút "về hôm nay" ba kiểu khác nhau | `CAL-N06` |
| 3 | Week view quá tải — chữ cắt còn 1–2 ký tự, FAB che nội dung | `CAL-E18`, `CAL-E19` |
| 4 | Event nhiều ngày chiếm nguyên cột, không có hàng all-day riêng | `CAL-E06` |
| 5 | Màu nhấn picker ngày tháng là đỏ, lệch hệ màu tím/đen | `CAL-E20` |
| 6 | Thiếu trường Location khi tạo event | `CAL-N12`, `CAL-Q07` |

**Rủi ro xuyên suốt chạm vào flow này** *(chỉ link)*:
[§1.4 đồng bộ 2 chiều](../../references/exploratory-references.md#14--đồng-bộ-2-chiều-với-apple-calendar--reminders-có-làm-mất-dữ-liệu-không) ·
[§1.5 bốn cửa vào một dữ liệu](../../references/exploratory-references.md#15--bốn-cửa-vào-một-dữ-liệu-có-nhất-quán-không) ·
[§1.6 Google Calendar](../../references/exploratory-references.md#16--google-calendar-nguồn-dữ-liệu-duy-nhất-cần-mạng-và-tài-khoản) ·
[permissions-matrix §1.1 `Add Events Only`](../../references/permissions-matrix.md#-ba-trạng-thái-quyền--và-cái-ở-giữa-là-bẫy)

---

## 1 · Happy path — `CAL-H`

### 1.1 · Bốn view và điều hướng

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **CAL-H01** | Mở tab Calendar | Vào **List view** · tiêu đề `<Tháng>, <Năm>` · week strip có **dương + âm lịch** · icon ☰ và 📅 | View mặc định là gì, có nhớ view lần trước không | ☐ |
| **CAL-H02** | Bấm icon view (☰) | Menu 4 mục `List / Day / Week / Month`, mục đang bật có ✓ | — | ☐ |
| **CAL-H03** | Chọn **Day** | Lưới giờ 1 cột · **đường đỏ + chấm** đúng giờ hiện tại · block event có min-height | Đối chiếu đường đỏ với đồng hồ máy | ☐ |
| **CAL-H04** | Chọn **Week** | 7 cột × lưới giờ · **cột nền hồng** = ngày đang chọn | Week strip trên cùng có highlight ngày đó không *(wireframe ghi: không)* | ☐ |
| **CAL-H05** | Chọn **Month** | Tiêu đề chỉ còn **năm** · pill `Today` · lưới `M T W T F S S` dính khi cuộn · mỗi ô: dương + âm + tối đa 2 chip + `+N` | — | ☐ |
| **CAL-H06** | Cuộn Month xuống hết tháng | Sang tháng kế tiếp **liên tục**, không phân trang · tên tháng nằm trong luồng nội dung | Cuộn ngược lên tháng trước có mượt không | ☐ |
| **CAL-H07** | Mở menu chọn view **từ Day / Week / Month** | Menu hiện đúng, ✓ đúng view đang bật | ⚠️ **coverage gap** — chỉ có ảnh menu mở từ List | ☐ |
| **CAL-H08** | Đổi ngày ở week strip, rồi đổi view | Ngày đang chọn **giữ nguyên** khi chuyển qua lại 4 view | Mất ngày đang chọn = phải chọn lại mỗi lần đổi view | ☐ |
| **CAL-H09** | Ở Month bấm pill `Today` | Nhảy về tháng hiện tại, ngày 6 tô **đỏ** cả dương lẫn âm | — | ☐ |
| **CAL-H10** | Ở List bấm FAB `📅6` | Nhảy về hôm nay | So với H09: **hai cách khác nhau cho cùng một việc** — xem `CAL-N06` | ☐ |

### 1.2 · Sheet Calendars & tạo calendar

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **CAL-H11** | Bấm 📅 ở header | Bottom sheet `Calendars` · 4 nhóm `ICLOUD` / `OTHER` / `SUBSCRIBED CALENDARS` / `SUGGESTED` · nút `+` | Danh sách có khớp Apple Calendar → Calendars không | ☐ |
| **CAL-H12** | 🔴 Tắt một calendar *(vd `Công Việc`)* | Event của lịch đó biến khỏi **cả 4 view** | Kiểm đủ 4 view, không chỉ view đang mở — [§1.5](../../references/exploratory-references.md#15--bốn-cửa-vào-một-dữ-liệu-có-nhất-quán-không) | ☐ |
| **CAL-H13** | 🔴 Giữ nguyên calendar đã tắt → chạy shortcut → xem lock screen | **Wallpaper cũng phải tôn trọng** lựa chọn đó | Nếu wallpaper vẫn vẽ event của lịch đã tắt → hai nguồn sự thật khác nhau | ☐ |
| **CAL-H14** | Bấm `⊕` ở nhóm SUGGESTED *(vd `Class Schedule`)* | Calendar mới được tạo, xuất hiện ở nhóm nào? | Tạo ở tài khoản nào — iCloud, local, hay Google? *(xem `CAL-Q05`)* | ☐ |
| **CAL-H15** | Bấm `+` → sheet `New calendar` → chọn một preset | **Sheet chồng sheet** *(S06 đè lên S05)* · 6 preset + `Custom name…` · mỗi dòng có `›` | ⚠️ **coverage gap** — bước sau `›` chưa có ảnh. Ghi lại thấy gì *(chọn màu? nhập tên?)* | ☐ |

### 1.3 · Tạo event

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **CAL-H16** | Bấm FAB `+` ở bất kỳ view nào | Màn `Create new event` · nút `✓` **xám/disabled** | Ngày mặc định có bằng ngày đang chọn ở view không | ☐ |
| **CAL-H17** | Đọc form | 9 trường: `Title` `Notes` `URL` · `All day` `Start` `End` · `Color` `Calendar` `Repeat` `Reminder` · icon ⭐ cạnh Title | `Start` mặc định 9:00, `End` mặc định **+1 giờ** | ☐ |
| **CAL-H18** | Nhập Title | Nút `✓` chuyển **đen/enabled** — Title là trường bắt buộc duy nhất | — | ☐ |
| **CAL-H19** | Mở picker `Start` | Picker **inline accordion**, mở ngay trong form · chip giờ · lịch tháng | Đo chiều dài form: mỗi picker ≈ 1 màn hình | ☐ |
| **CAL-H20** | Mở tiếp picker `End` khi `Start` **vẫn đang mở** | Cả hai mở đồng thời, form dài gấp ~3 | 🟡 Đếm số lần cuộn để đi từ Title xuống `Reminder` | ☐ |
| **CAL-H21** | Bấm ⭐ cạnh Title | Ghi lại chức năng thật của nó | ⚠️ **coverage gap** — chưa xác định. Xem `CAL-Q06` | ☐ |
| **CAL-H22** | Mở lần lượt `Color` · `Calendar` · `Repeat` · `Reminder` | Ghi lại từng picker con | ⚠️ **coverage gap** — 4 picker này chưa có ảnh nào | ☐ |
| **CAL-H23** | Bật `All day` | 2 picker giờ **biến mất** hoặc chuyển thành picker ngày | ⚠️ **coverage gap** — chưa có ảnh trạng thái bật | ☐ |
| **CAL-H24** | 🔴 Bấm `✓` lưu | Event hiện ngay ở view vừa tạo · **mở Apple Calendar kiểm chứng** event có thật, đúng giờ, đúng calendar đích | **Không tin UI Ink** — phải mở app khác đối chiếu | ☐ |

### 1.4 · Chi tiết · sửa · xoá

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **CAL-H25** | Ở **List view** tap một event | S08 · icon tròn nhuộm màu calendar · tiêu đề lớn · ngày · khung giờ · quy tắc lặp dạng chữ · nút 🗑 và ✎ | Chỉ **3 thuộc tính** hiện ra — Notes/URL/Location đi đâu *(xem `CAL-E07`)* | ☐ |
| **CAL-H26** | Bấm nút chia sẻ ⤴ | Ghi lại share sheet chứa gì — file `.ics`? link? chữ? | ⚠️ **coverage gap** — chưa có ảnh | ☐ |
| **CAL-H27** | Bấm ✎ | Ghi lại: dùng lại form S07 hay form riêng? Các trường đã điền sẵn đúng chưa? | ⚠️ **coverage gap** — màn Edit event chưa có ảnh | ☐ |
| **CAL-H28** | Sửa giờ rồi lưu | Đổi đúng ở cả 4 view · **mở Apple Calendar kiểm chứng** | — | ☐ |
| **CAL-H29** | 🔴 Bấm 🗑 trên một event **không lặp** | Phải có **dialog xác nhận** trước khi xoá | ⚠️ **coverage gap** — dialog xác nhận chưa có ảnh. Không có xác nhận = mất dữ liệu 1 chạm | ☐ |
| **CAL-H30** | 🔴 Bấm 🗑 trên một event **lặp** *(vd `Uống Creatine` — Every day)* | Phải hỏi **xoá 1 lần hay cả chuỗi** *(Apple Calendar luôn hỏi)* | Không hỏi mà xoá cả chuỗi = **mất hàng loạt dữ liệu**, ngưỡng 🔴 của sản phẩm | ☐ |
| **CAL-H31** | Sau khi xoá, mở Apple Calendar | Event biến mất đúng phạm vi đã chọn, **không nhiều hơn** | Đếm số bản ghi trước/sau | ☐ |

---

## 2 · Negative — `CAL-N`

### 2.1 · 🔴 Chi tiết event ở Day / Week / Month — vấn đề số 1 của flow

> Wireframe đã kết luận đây là **lỗi, không phải chủ ý** với 6 bằng chứng —
> [xem phân tích](../ui/ux/wideframes/05_calendar.md#-phân-tích-chỉ-mở-được-chi-tiết-event-ở-list-view).
> Mục này để **xác nhận lại trên build hiện tại** và kiểm kịch bản duy nhất có thể lật ngược kết luận.

| ID | Việc làm | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **CAL-N01** | Tap event ở **Day view** | Mở S08 | Không mở → **mất hoàn toàn đường sửa và xoá event** ở view này. Tên còn đọc được nên chỉ mất chức năng chỉnh sửa | 🟠 | ☐ |
| **CAL-N02** | Tap event ở **Week view** | Mở S08 | Không mở → tên đã bị cắt còn `Te…`, `R…`, user **vĩnh viễn không biết đó là event gì** | 🔴 | ☐ |
| **CAL-N03** | Tap chip event ở **Month view** | Mở S08 | Không mở → cộng với `+N` không bấm được thì phần lớn event trong tháng **không có đường nào xem** | 🔴 | ☐ |
| **CAL-N04** | 🔴 Tap vào chỉ báo **`+5`** ở ô ngày Month | Mở danh sách đầy đủ event ngày đó | `+N` là chỉ báo số lượng **không dẫn tới đâu** — bằng chứng số 1 của wireframe | 🔴 | ☐ |
| **CAL-N05** | 🔴 **Phép thử quyết định:** tap vùng **trống** của ô ngày 13/8 *(ngày có `+4`)* ở Month view | Nhảy sang List view của ngày đó → có mô hình drill-down `tháng → ngày → danh sách → chi tiết` | **Nếu không có gì xảy ra → xác nhận ngõ cụt, giữ mức 🔴.** Nếu có nhảy → hạ xuống *khó khám phá* 🟡. Làm phép thử này **trước** khi viết bug | 🔴 | ☐ |
| **CAL-N05a** | Làm lại N05 ở **Week view** *(tap vùng trống của cột ngày)* | Như trên | — | 🟠 | ☐ |

### 2.2 · Nhập sai & validate form

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **CAL-N06** | Tìm nút "về hôm nay" ở **Day** và **Week view** | Có một cách thống nhất ở cả 4 view | Wireframe ghi: Month có pill, List có FAB, **Day/Week không có gì**. Ba kiểu cho cùng một hành động | 🟡 | ☐ |
| **CAL-N07** | 🔴 Đặt `End` **trước** `Start` rồi lưu | App chặn, báo lỗi rõ | Lưu event **âm thời lượng** → hiển thị vỡ ở 4 view, vỡ luôn trên wallpaper/widget | 🔴 | ☐ |
| **CAL-N08** | Nhập Title chỉ gồm **khoảng trắng** | `✓` vẫn disabled, hoặc trim rồi chặn | Event không tên trong Apple Calendar của user | 🟠 | ☐ |
| **CAL-N09** | Nhập Title **500+ ký tự** | Cắt hoặc chấp nhận, không crash · kiểm hiển thị ở 4 view + S08 + wallpaper | Vỡ layout dây chuyền sang cả lock screen | 🟡 | ☐ |
| **CAL-N10** | Nhập `URL` **sai định dạng** *(`abc`, `javascript:…`)* | Chặn hoặc lưu nguyên văn không thực thi | Không bao giờ mở link do user tự nhập mà không kiểm | 🟠 | ☐ |
| **CAL-N11** | 🔴 Tạo event vào calendar **chỉ đọc** *(`Ngày lễ Việt Nam` — SUBSCRIBED)* | Calendar này **không được xuất hiện** trong picker `Calendar`, hoặc báo lỗi rõ khi lưu | Lưu thất bại im lặng — user tưởng đã tạo, event không tồn tại ở đâu cả | 🔴 | ☐ |
| **CAL-N12** | Tìm trường **Location** trong form | — | **Không có.** Event tạo bằng Ink mất địa điểm, dù dialog xin quyền có nhắc *"…such as locations"*. Event sửa từ Ink có **xoá mất** Location sẵn có không? *(kiểm bằng cách sửa event có Location tạo từ Apple Calendar)* | 🔴 | ☐ |
| **CAL-N13** | Bật `Repeat` rồi bật `Reminder` | Cả hai lưu đúng · quy tắc lặp hiện dạng chữ ở S08 | — | 🟡 | ☐ |

### 2.3 · 🔴 Đồng bộ 2 chiều — vùng mất dữ liệu

> Mỗi item ở nhóm này **bắt buộc kiểm chứng bằng app khác** *(Apple Calendar / Google Calendar web)*.
> Không kết luận từ UI của Ink.

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **CAL-N14** | 🔴 Xoá event trong Ink → mở **Apple Calendar** | Biến mất đúng một event đó | Xoá nhiều hơn phạm vi user chọn | 🔴 | ☐ |
| **CAL-N15** | 🔴 Xoá **một lần xuất hiện** của event lặp | Chỉ ngày đó mất, các ngày khác còn | Xoá cả chuỗi = mất hàng loạt — [ngưỡng 🔴](../../references/exploratory-references.md#5--mẫu-kết-luận-phiên) | 🔴 | ☐ |
| **CAL-N16** | 🔴 Sửa event trong Ink **trong khi Apple Calendar đang mở cùng event** | Ai thắng phải xác định được, không mất dữ liệu bên nào | Ghi đè im lặng | 🔴 | ☐ |
| **CAL-N17** | Tạo event ở Ink vào một calendar **Google** → mở Google Calendar web | Đẩy lên thật, không chỉ nằm local | Event "ma" chỉ tồn tại trên máy — [§1.6](../../references/exploratory-references.md#16--google-calendar-nguồn-dữ-liệu-duy-nhất-cần-mạng-và-tài-khoản) | 🔴 | ☐ |
| **CAL-N18** | 🔴 Sửa **giờ** một event Google **có người tham dự** | App phải cảnh báo trước khi gửi lại lời mời | Một thao tác trong Ink **gửi email cho cả nhóm đồng nghiệp** | 🔴 | ☐ |
| **CAL-N19** | Xoá event Google từ Ink | Đồng bộ ngược đúng | **Mất dữ liệu trên cloud**, ảnh hưởng người khác | 🔴 | ☐ |
| **CAL-N20** | Tạo calendar mới từ Ink rồi **gỡ app** | Calendar và event trong đó còn nguyên trong iCloud | Gỡ app mất dữ liệu user — xem `CAL-Q05` | 🔴 | ☐ |
| **CAL-N21** | Sửa event ở Ink khi **offline** | Xếp hàng đồng bộ khi có mạng, hoặc báo rõ | Mất thay đổi im lặng | 🟠 | ☐ |

### 2.4 · Bỏ dở & gián đoạn

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **CAL-N22** | Nhập gần xong form tạo event rồi bấm `‹` back | Hỏi *"Bỏ thay đổi?"* trước khi thoát | Mất toàn bộ nội dung vừa nhập không cảnh báo | 🟠 | ☐ |
| **CAL-N23** | Đang nhập form thì **kill app** | Mở lại: hoặc khôi phục nháp, hoặc về sạch — miễn không tạo event nửa vời | Event thiếu trường được lưu ngầm | 🟠 | ☐ |
| **CAL-N24** | Bấm `✓` **2 lần thật nhanh** | Chỉ tạo **1** event | Event nhân đôi trong Apple Calendar | 🟠 | ☐ |
| **CAL-N25** | Bấm FAB `+` liên tiếp nhiều lần | Chỉ mở 1 màn tạo event | Stack màn hình rác | 🟡 | ☐ |
| **CAL-N26** | Mở sheet `New calendar` *(S06)* rồi vuốt xuống đóng | Về sheet `Calendars` *(S05)*, không đóng cả hai | Sheet chồng sheet đóng sai lớp | 🟡 | ☐ |
| **CAL-N27** | Bấm 🗑 rồi **huỷ** ở dialog xác nhận | Event còn nguyên ở cả Ink và Apple Calendar | Xoá dù đã bấm huỷ | 🔴 | ☐ |
| **CAL-N28** | Cuộn Month view rất nhanh liên tục | Không giật, không nhảy sai tháng, không crash | — | 🟡 | ☐ |

### 2.5 · Quyền

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **CAL-N29** | Từ chối quyền Calendar → mở tab | ✅ Đã có bằng chứng: có màn hình dẫn ra Settings *(Flow 02 · S03)* — xác nhận nút `Open Settings` mở thẳng trang **Ink** | Mở Settings gốc, user phải tự mò | 🟠 | ☐ |
| **CAL-N30** | 🔴 Đặt Calendar = **`Add Events Only`** → mở tab | Nội dung phải **gọi đúng tên** lựa chọn: cần `Full Access`, đang để `Add Events Only` | [Lần thứ 3 của cùng mẫu lỗi](../../references/permissions-matrix.md#đây-là-lần-thứ-ba-cùng-một-mẫu-lỗi-lặp-lại). 4 view trống trơn → user tưởng **mất sạch lịch của mình** | 🔴 | ☐ |
| **CAL-N31** | 🔴 Với `Add Events Only`, bấm 📅 mở sheet **Calendars** | Báo lỗi rõ | Liệt kê calendar **cũng cần quyền đọc** → sheet trống hoặc crash | 🔴 | ☐ |
| **CAL-N32** | 🔴 Với `Add Events Only`, bấm FAB `+` tạo event | — | **Nghịch lý:** cho phép ghi nhưng picker `Calendar` cần quyền đọc để liệt kê lịch đích. Xác định app rơi vào hành vi nào | 🔴 | ☐ |
| **CAL-N33** | Cấp quyền trong Settings rồi quay lại app | Tự refresh, không cần kill app | Phải kill mới thấy dữ liệu → user tưởng cấp quyền không ăn thua | 🟠 | ☐ |
| **CAL-N34** | **Rút quyền** Calendar khi đang mở tab Calendar | Degrade có giải thích, không crash, không màn trắng | Crash ở tab chính | 🔴 | ☐ |

---

## 3 · Edge — `CAL-E`

### 3.1 · Dữ liệu

| ID | Tình huống | Câu hỏi | Mức | ☐ |
|---|---|---|:---:|:---:|
| **CAL-E01** | Ngày **không có event** ở List view | ✅ Đã có ảnh: *"This day doesn't have any events yet"*. Câu chữ có đúng khi user **tắt hết calendar** không *(không phải "chưa có event" mà là "đã ẩn hết")* | 🟡 | ☐ |
| **CAL-E02** | Ngày trống ở **Day / Week / Month view** | Hiện gì? ⚠️ **coverage gap** — chưa có ảnh | 🟡 | ☐ |
| **CAL-E03** | **Tắt toàn bộ calendar** ở sheet Calendars | 4 view trống · wallpaper vẽ gì? Có phân biệt được với "mất quyền" không? | 🟠 | ☐ |
| **CAL-E04** | Ngày có **30+ event** | Month: `+N` đúng số chưa? Day/Week: chồng lấn thế nào? List: cuộn có mượt không *(🎞 đo FPS)* | 🟠 | ☐ |
| **CAL-E05** | Event **all-day** | Hiển thị thế nào ở từng view? Wireframe ghi Week view vẽ thành **cột dọc suốt lưới giờ**, **không có hàng all-day riêng** như Apple Calendar | 🟠 | ☐ |
| **CAL-E06** | Event **kéo dài nhiều ngày** | Cùng nhóm E05 — chiếm nguyên cột trong lưới giờ. Ở Month view thì sao? Có vẽ liền mạch qua các ô không? | 🟠 | ☐ |
| **CAL-E07** | Event **có Notes / URL / Location** *(tạo từ Apple Calendar)* | S08 chỉ hiện 3 thuộc tính — Notes/URL/Location hiện ở đâu? Sửa từ Ink có **làm mất** chúng không? ⚠️ **coverage gap** | 🔴 | ☐ |
| **CAL-E08** | Event **rất ngắn** *(5 phút)* và event **kéo dài 12 tiếng** | Day view có min-height *(event 10 phút cao gần 1 giờ)* — event dài có đúng tỉ lệ không? Hai event ngắn liền nhau có chồng lên nhau không | 🟡 | ☐ |
| **CAL-E09** | Event tên **rất dài** / emoji / **tiếng Việt có dấu** | Cắt chữ ở 4 view · vỡ font dấu · xuống dòng ở S08. *(App có data tiếng Việt thật: `Uống Creatine`, `Gia hạn Gym Membership ngày 6 hàng tháng`)* | 🟡 | ☐ |
| **CAL-E10** | Event **qua nửa đêm** *(23:30 → 00:30)* | Vẽ ở ngày nào? Cắt làm 2 block hay tràn xuống? | 🟠 | ☐ |

### 3.2 · Âm lịch & thời gian

| ID | Tình huống | Câu hỏi | Mức | ☐ |
|---|---|---|:---:|:---:|
| **CAL-E11** | 🔴 Kiểm **âm lịch** ở các mốc: **mùng 1** · **ngày rằm** · **tháng nhuận** · **Tết Nguyên đán** | Đối chiếu **nguồn độc lập**, không tin app. Đây là điểm bán hàng cho thị trường VN | 🔴 | ☐ |
| **CAL-E12** | Định dạng đặc biệt của mùng 1 | Wireframe ghi ngày 13/8 hiện **`1/7`** *(ngày/tháng âm)*, các ngày khác chỉ hiện số. Quy tắc này có nhất quán ở mọi mùng 1 không? Ở week strip có áp dụng không? | 🟡 | ☐ |
| **CAL-E13** | Cuộn Month view tới **năm nhuận** *(29/2/2028)* | Ô ngày 29/2 có đúng không? Âm lịch tương ứng đúng không? | 🟡 | ☐ |
| **CAL-E14** | Cuộn Month view **rất xa** *(2030 · 1990)* | Có giới hạn không? Có lag/crash không? Âm lịch còn tính đúng ở biên không? | 🟡 | ☐ |
| **CAL-E15** | **Đổi múi giờ** máy rồi mở lại tab | Giờ event có dịch đúng không? Đường đỏ "giờ hiện tại" ở Day view có đúng giờ mới không? | 🟠 | ☐ |
| **CAL-E16** | Để app mở ở Day view **qua nửa đêm** | Đường đỏ có nhảy sang ngày mới không? View có tự chuyển ngày không? | 🟡 | ☐ |
| **CAL-E17** | Đổi cài đặt hệ thống **24h ↔ 12h (AM/PM)** và **ngày đầu tuần** *(Mon ↔ Sun)* | App có theo cài đặt hệ thống không? Week strip hiện đang bắt đầu từ **Mon** | 🟡 | ☐ |

### 3.3 · Hiển thị & tiếp cận

| ID | Tình huống | Câu hỏi | Mức | ☐ |
|---|---|---|:---:|:---:|
| **CAL-E18** | 🔴 **Week view với data thật dày** | Tên event cắt còn `Te…`, `R…`, `Up…`. **Đếm số event trong màn hình mà user đọc được tên đầy đủ** — con số này là bằng chứng cho vấn đề #3 của wireframe | 🔴 | ☐ |
| **CAL-E19** | **FAB `+` che nội dung** | Ở Week view FAB che event khung 23:00 của Sat/Sun. Có cách nào chạm tới event bị che không? Ở Month view FAB có che ô ngày cuối tháng không? | 🟠 | ☐ |
| **CAL-E20** | **Màu nhấn picker ngày tháng là đỏ** | Chấm ngày hiện tại + mũi tên điều hướng màu **đỏ**, toàn app dùng **tím/đen**. Xác định: component hệ thống chưa theme, hay chủ ý? Có chỗ nào khác trong app cũng đỏ không? | 🟡 | ☐ |
| **CAL-E21** | **Tab bar trong suốt**, nội dung cuộn xuyên phía sau | Ở Day view có event bị tab bar che mà **không cuộn tới được** không? *(wireframe: `Uống Magie` nằm sau tab bar)* | 🟠 | ☐ |
| **CAL-E22** | **Dynamic Type** cỡ lớn nhất | Ô ngày Month có chiều cao **cố định** → chip event và `+N` có bị cắt mất không? Week strip 2 dòng số có vỡ không? | 🟠 | ☐ |
| **CAL-E23** | **Dark Mode** trên cả 8 màn | Cột hồng "ngày đang chọn" ở Week view còn phân biệt được không? Chip event nhuộm màu calendar còn đọc được chữ không — **đo tương phản bằng số** | 🟠 | ☐ |
| **CAL-E24** | Máy **màn hình nhỏ** *(SE / mini)* | Week view 7 cột còn dùng được không? Form tạo event với 2 picker mở cùng lúc phải cuộn bao nhiêu lần? | 🟠 | ☐ |
| **CAL-E25** | **VoiceOver** | Ô ngày Month đọc ra gì — có đọc âm lịch và số `+N` không? Event ở Week view *(tên bị cắt)* đọc tên đầy đủ hay đọc `Te…`? Đường đỏ giờ hiện tại có announce không? | 🟠 | ☐ |
| **CAL-E26** | Xoay ngang máy | 4 view có vỡ layout không *(nếu khoá portrait thì ghi lại là khoá)* | 🟡 | ☐ |

### 3.4 · Vòng đời & môi trường

| ID | Tình huống | Câu hỏi | Mức | ☐ |
|---|---|---|:---:|:---:|
| **CAL-E27** | Tạo event ở **Apple Calendar** trong lúc Ink đang mở ở background → quay lại Ink | Ink có tự cập nhật không, hay phải kill mới thấy? | 🟠 | ☐ |
| **CAL-E28** | Ink đang mở form tạo event → nhận **cuộc gọi đến** → quay lại | Nội dung form còn nguyên chứ? | 🟡 | ☐ |
| **CAL-E29** | Máy có **rất nhiều calendar** *(15+)* | Sheet Calendars cuộn được không? Picker `Calendar` trong form chọn được không? | 🟡 | ☐ |
| **CAL-E30** | Đổi **ngôn ngữ máy** sang tiếng Anh / tiếng Việt | Tên thứ trong tuần, tên tháng, định dạng ngày có đổi theo không? Âm lịch còn hiện không? | 🟡 | ☐ |

---

## 4 · Coverage matrix

| State / màn hình | Đã có ảnh | Đã chạm khi test |
|---|:---:|:---:|
| S01 List view · empty · dialog chọn view | ✅ | ☐ |
| S02 Day view · default | ✅ | ☐ |
| S03 Week view · default | ✅ | ☐ |
| S04 Month view · default | ✅ | ☐ |
| S05 Calendars · bottom-sheet | ✅ | ☐ |
| S06 New calendar · bottom-sheet | ✅ | ☐ |
| S07 Create event · default · editing · expanded | ✅ | ☐ |
| S08 Event detail · default | ✅ | ☐ |
| **Edit event** *(nút ✎ dẫn tới đâu)* | ❌ | ☐ |
| **Dialog xác nhận xoá** + xử lý event lặp | ❌ | ☐ |
| **Event detail có Notes / URL / Location** | ❌ | ☐ |
| **Picker con:** Color · Calendar · Repeat · Reminder | ❌ | ☐ |
| **Chức năng icon ⭐** cạnh ô Title | ❌ | ☐ |
| **Trạng thái `All day` bật** | ❌ | ☐ |
| **Bước sau khi chọn preset ở S06** *(sau dấu `›`)* | ❌ | ☐ |
| **Day / Week / Month ở trạng thái không có event** | ❌ | ☐ |
| **Menu chọn view mở từ Day / Week / Month** | ❌ | ☐ |
| Tab Calendar khi quyền = `denied` | ❌ *(có ở Flow 02 S03)* | ☐ |
| Tab Calendar khi quyền = **`Add Events Only`** | ❌ | ☐ |

> Các mục ❌ chặn: `CAL-H15`, `H21`, `H22`, `H23`, `H26`, `H27`, `H29`, `H30`, `E02`, `E07`.
> Đặc biệt **`H29`, `H30` là đường mất dữ liệu** mà chưa có ảnh nào — ưu tiên chụp bổ sung số 1.

---

## 5 · Câu hỏi cần PO / dev trả lời — `CAL-Q`

| ID | Câu hỏi | Vì sao cần |
|---|---|---|
| **CAL-Q01** | 🔴 **Không mở được chi tiết event ở Day/Week/Month là do phạm vi MVP hay có lý do khác?** Có nằm trong kế hoạch sửa không? | Wireframe đã kết luận là lỗi với 6 bằng chứng, chi phí sửa gần bằng 0 *(màn S08 đã chạy được)*. Cần xác nhận trước khi log 3 bug riêng hay 1 bug |
| **CAL-Q02** | 🔴 Xoá event **lặp** — code có phân biệt `.thisEvent` và `.futureEvents` không? | `CAL-H30`, `N15`. Đây là đường mất dữ liệu hàng loạt. Nếu code chỉ gọi xoá không span thì bug đã tồn tại sẵn, không cần test mới biết |
| **CAL-Q03** | 🔴 Sửa event từ Ink có **giữ nguyên** các trường Ink không hiển thị *(Location, Attendees, Attachments, Alarm)* không? | `CAL-N12`, `E07`. Nếu ghi đè bằng model nội bộ thiếu trường → **sửa tên event làm mất địa điểm và danh sách người tham dự**. Rủi ro âm thầm và nặng nhất flow này |
| **CAL-Q04** | 🔴 Sửa event Google có người tham dự — Ink có gửi lại lời mời không? Có cảnh báo user trước không? | `CAL-N18`. Một thao tác trong app gửi email cho đồng nghiệp user | 
| **CAL-Q05** | Calendar tạo từ Ink *(SUGGESTED / New calendar)* nằm ở **tài khoản nào** — iCloud, local, hay Google? | `CAL-H14`, `N20`. Nếu là local thì gỡ app hoặc đổi máy là mất | 
| **CAL-Q06** | Icon **⭐** cạnh ô Title làm gì? | `CAL-H21`. Chưa xác định được. Giả thuyết wireframe: chọn emoji cho event, hoặc đánh dấu quan trọng |
| **CAL-Q07** | Vì sao **không có trường Location** dù dialog xin quyền có nhắc tới? | `CAL-N12`. Là chủ ý cắt phạm vi hay bỏ sót |
| **CAL-Q08** | Nguồn dữ liệu **âm lịch** là gì — thư viện nào, tính tới năm nào? | `CAL-E11`–`E14`. Là điểm bán hàng cho thị trường VN, sai một mốc là mất uy tín |
| **CAL-Q09** | Nhóm **SUGGESTED** ở sheet Calendars lọc theo quy tắc nào? *(S05 có 3 mục, S06 có 6 preset)* | `CAL-H14`. Giả thuyết wireframe: đã lọc bỏ preset trùng với calendar user đang có |
| **CAL-Q10** | View mặc định khi mở tab, và app có **nhớ view lần trước** không? | `CAL-H01`. Ảnh hưởng cảm nhận "app nhớ mình" |
| **CAL-Q11** | Có kế hoạch **thống nhất nút "về hôm nay"** cho cả 4 view không? | `CAL-N06`. Vấn đề #2 của wireframe |
| **CAL-Q12** | Week view với data dày — có kế hoạch đổi cách hiển thị event nhiều ngày và vị trí FAB không? | `CAL-E18`, `E19`. Vấn đề #3, #4 của wireframe |

---

## 6 · Smoke 15 phút cho flow này

| # | Việc | ID | Thời lượng |
|:---:|---|---|:---:|
| 1 | 🔴 **Tạo → sửa → xoá 1 event**, mỗi bước mở **Apple Calendar** đối chiếu | `CAL-H24` `H28` `H31` `N14` | 4 phút |
| 2 | 🔴 **Xoá 1 lần xuất hiện của event lặp** *(`Uống Creatine` — Every day)* — có hỏi không, xoá đúng phạm vi không | `CAL-H30` `N15` | 3 phút |
| 3 | 🔴 **Tap event ở Month view**, rồi tap `+N`, rồi tap vùng trống ô ngày — ghi rõ cái nào mở được | `CAL-N03` `N04` `N05` | 2 phút |
| 4 | **Sửa tên một event có Location** *(tạo sẵn từ Apple Calendar)* → kiểm Location còn không | `CAL-N12` `Q03` | 2 phút |
| 5 | Đặt `End` **trước** `Start` rồi bấm lưu | `CAL-N07` | 1 phút |
| 6 | Đặt Calendar = `Add Events Only` → mở tab + mở sheet Calendars | `CAL-N30` `N31` | 3 phút |

---

## 7 · Kết luận phiên

```
Phiên: __________   Build: 1.2.10 (27)   iOS: ______   Thiết bị: __________

Q1 Mục tiêu user:            xem lịch nhiều cách + sửa được ngay trong Ink
Q8 Mục tiêu business:        tab quyết định Ink là app quản lý lịch hay đồ trang trí
— Chạy luồng chính —
Q2 Xong dễ lần đầu?          Có / Không — vì: __________
Q3 Điểm khựng/bối rối:       __________________________
   (tap event 3 view không mở? nút "về hôm nay" ở đâu? form 2 picker quá dài?)
Q4 Thao tác sai / gián đoạn: __________________________
Q5 State chưa test:          __________________________
   (Edit event · dialog xoá · picker con · All day · Notes/URL/Location)
— Đồng bộ (BẮT BUỘC đối chiếu app khác) —
Tạo/sửa/xoá có đúng ở Apple Calendar?   Có / Không
Xoá event lặp có hỏi phạm vi?           Có / Không
Sửa event có giữ Location/Attendees?    Có / Không / Chưa kiểm được
— Kết luận —
Q6 Rủi ro #1 nếu ship:       __________________________
Q7 Tự mình dùng hằng ngày?   Có / Không — vì: __________

=> Verdict: 🟢 / 🟡 / 🔴  — kèm bằng chứng
```

**Ngưỡng cho riêng flow này:**

| Verdict | Điều kiện |
|---|---|
| 🔴 | Xoá event lặp **không hỏi phạm vi** *(H30/N15)* · sửa event **làm mất** Location/Attendees *(N12/Q03)* · xoá không có xác nhận *(H29)* · **không sửa/xoá được event ở 3/4 view** *(N01–N05)* · `Add Events Only` cho ra 4 view trống không giải thích *(N30)* · lưu được event `End < Start` *(N07)* · sửa event Google âm thầm gửi lại lời mời *(N18)* |
| 🟡 | Week view khó đọc khi nhiều event *(E18)* · nút "về hôm nay" ba kiểu *(N06)* · form tạo event quá dài vì 2 picker mở cùng lúc *(H20)* · picker màu đỏ lệch theme *(E20)* · thiếu Location nhưng **không** làm mất dữ liệu sẵn có |
| 🟢 | Tạo/sửa/xoá đồng bộ đúng và **không mất trường nào** · xoá luôn có xác nhận và hỏi phạm vi với event lặp · mở được chi tiết event ở cả 4 view · âm lịch đúng ở các mốc đã kiểm |

---

## 8 · Ghi chú về giới hạn checklist này

- **Nhóm §2.3 là nhóm quan trọng nhất và cũng dễ bỏ qua nhất**, vì mọi item đều **pass giả** nếu chỉ nhìn UI
  của Ink. Bắt buộc mở Apple Calendar / Google Calendar web đối chiếu. Không có tài khoản Google → ghi
  `N17`–`N19` là **coverage gap**, không suy diễn.
- **`CAL-Q03` có thể trả lời bằng cách đọc code nhanh hơn test.** Nếu Ink map `EKEvent` sang model nội bộ rồi
  ghi ngược, câu trả lời nằm ở chỗ model đó có bao nhiêu trường. Hỏi dev trước, test sau.
- **10 màn hình / trạng thái chưa có ảnh** *(xem §4)*. Trong đó **dialog xác nhận xoá** và **màn Edit event**
  là hai chỗ nằm thẳng trên đường mất dữ liệu — chụp bổ sung trước khi chạy phiên đầy đủ.
- **`CAL-N05` phải chạy trước khi viết bug cho `N01`–`N04`.** Nếu tap ô ngày ở Month/Week **có** nhảy sang
  List view thì cả nhóm hạ từ 🔴 xuống 🟡 *(khó khám phá)*, và nội dung bug đổi hẳn.
- **`CAL-E11` cần nguồn âm lịch độc lập** *(lịch giấy, hoặc app âm lịch khác)*. Đối chiếu Ink với chính Ink
  không chứng minh được gì.
- **Cần data thật, dày** cho `E04`, `E18`, `E22`. Máy sạch với 3 event không tái hiện được vấn đề Week view —
  đó chính là lý do wireframe phải dùng data thật của user để phát hiện.
