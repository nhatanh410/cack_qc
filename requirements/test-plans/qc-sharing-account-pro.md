# Bàn giao QC — Chia sẻ lịch, Tài khoản, và header Discover

PR **#260** (commit `380bc6b2`) + PR **#274** (commit `ef996605`) · đều đã vào `main`

Bảy mảng cần test, xếp theo mức rủi ro giảm dần:

1. **Lịch join được không được xuất hiện nhầm chỗ** (bug riêng tư — rủi ro cao nhất).
2. **Chia sẻ lịch** — chọn khoảng thời gian, tên người gửi nay **bắt buộc**.
3. **Màn Calendars đổi cấu trúc** — hai lối vào sharing chuyển chỗ.
4. **Manage sharing** — viết lại thẻ, thêm nút tạo link.
5. **Tài khoản** — Settings row, màn Account, đăng nhập.
6. **Header Discover** — nền tím, wordmark to hơn, pill Pro hai trạng thái.
7. **Nút ✕ đổi sang cạnh trái** ở 4 màn + CTA trong sheet sát đáy hơn.

> ⚠️ `main` hiện cũng chứa các PR khác của session khác (#272, #273 — sync owner→joiner
> cho external share, `AppleShareIngest`). **Không thuộc tài liệu này.** Lỗi ở phần
> sync ngầm giữa 2 máy thì report theo PR đó.

---

## 1. Môi trường test

| Máy | Bắt buộc | Lý do |
|---|---|---|
| **2 iPhone** (hoặc 1 iPhone + 1 iPad) | ✅ | Gần như mọi mục sharing cần một máy gửi và một máy nhận |
| iPhone **iOS 26.x** | ✅ | Header + pill Pro dùng nền kính (Liquid Glass) |
| iPhone **iOS 18.x** | ✅ | Dưới 26 không có lens — pill Pro và header rơi về vật liệu khác, phải đối chiếu |
| **iPad** (dọc + ngang) | Nếu có | Manage sharing và màn Join đều giới hạn bề ngang |
| Tài khoản **Google** | ✅ | Tên người gửi tự điền từ đây; nút Google đổi sang màu thật |
| Tài khoản **Apple** | ✅ | Apple thường **không** trả tên/ảnh — đây là case hay vỡ |
| Máy **đã mua Pro** | ✅ | Pill Pro có 2 trạng thái khác hẳn nhau |
| Máy **chưa mua Pro** | ✅ | Trạng thái còn lại |

**Chuẩn bị:** máy A có sẵn 2–3 lịch Apple với kha khá sự kiện (ít nhất 1 lịch có sự kiện
lặp hằng ngày và sự kiện xa hơn 12 tháng). Máy B để join link.

---

## 2. Lịch đã join không được xuất hiện nhầm chỗ (mục rủi ro nhất)

**Bối cảnh:** khi máy B join một link chia sẻ, Ink tạo một lịch thật trong hệ thống tên
kiểu `Ink · <tên lịch>` để đẩy sự kiện sang app Lịch của Apple. Với iOS thì đó là một
lịch bình thường do Ink tạo — **không có gì phân biệt nó với lịch của chính người dùng**.
Trước đây nó lọt vào 4 danh sách mà nó không được phép có mặt.

Trên **máy B, sau khi đã join ít nhất 1 link**, kiểm tra cả 4:

- [ ] **Tạo sự kiện mới** → dòng chọn lịch: **không** có `Ink · …`
- [ ] **Ink AI** → chỗ chọn lịch đích: **không** có `Ink · …`
- [ ] **Calendars → danh sách bật/tắt hiện lịch**: lịch chia sẻ chỉ xuất hiện **một lần**
      (dưới dạng lịch được chia sẻ), **không** có thêm dòng `Ink · …` song song
- [ ] **Chia sẻ lịch → danh sách lịch chọn để chia sẻ**: **không** có `Ink · …`

> Mục cuối là nghiêm trọng nhất: nếu `Ink · …` xuất hiện ở đó và chọn được, người dùng sẽ
> **đăng lại lịch của người khác dưới tên mình**. Thấy là chặn ngay, không chờ.

- [ ] Máy **chưa join link nào** thì mọi danh sách trên phải **đầy đủ như cũ** — không bị
      lọc mất lịch nào

---

## 3. Chia sẻ lịch (máy A)

Đường vào: **Calendars → nút chia sẻ trên header** (biểu tượng mũi tên lên).

### 3.1 Tên người gửi — nay là bắt buộc

- [ ] Đăng nhập **Google** → ô "Your name" **tự điền sẵn** tên tài khoản, **không** bật
      bàn phím
- [ ] Đăng nhập **Apple** (thường không có tên) hoặc chưa đăng nhập → ô **trống** và
      **tự động focus** (bàn phím bật lên)
- [ ] Ô trống → nút **Create link** phải **mờ/không bấm được**
- [ ] Gõ tên → nút sáng lên
- [ ] Nhập toàn dấu cách → nút vẫn phải **mờ**
- [ ] Tên đã nhập được nhớ cho lần chia sẻ sau; **mô tả lịch thì không** (mỗi lịch một mô tả)

### 3.2 Khoảng thời gian (mới)

Thẻ dưới danh sách lịch có dòng **"Time range"** với 4 lựa chọn:

- [ ] Mặc định là **"All upcoming"**
- [ ] Đủ 4 lựa chọn: *Next 3 months · Next 6 months · Next 12 months · All upcoming*
- [ ] Đổi lựa chọn → dòng tóm tắt bên trên đổi theo, dạng **"128 events · 18 thg 9 – 18 thg 3"**
- [ ] Với **"All upcoming"** thì phần sau dấu `·` hiện **chữ "All upcoming"**, *không* hiện
      một khoảng ngày (đúng — vì đó là mốc kỹ thuật, không phải lựa chọn của người dùng)
- [ ] Đã bấm **Create link** rồi mới đổi Time range → link cũ **biến mất**, phải tạo lại
      (đúng — link cũ mang khoảng thời gian cũ)
- [ ] Số sự kiện phải **tăng dần** theo 3 → 6 → 12 tháng → All upcoming

> **Lịch lớn + "All upcoming" có thể chậm vài giây** khi mở sheet hoặc đổi lựa chọn, vì nó
> quét 5 năm tới. Chậm là chấp nhận được; **treo hẳn / trắng màn** thì report.

### 3.3 Tạo link

- [ ] Lần chia sẻ đầu tiên trên máy → hiện popup xin xác nhận trước khi tải lên
- [ ] Tạo xong → có nút chia sẻ link
- [ ] Lịch quá lớn → dưới có dòng cảnh báo **"Only the first N events fit in the link"**,
      kèm **icon dấu chấm than** (không phải dấu tick)
- [ ] Các dòng ghi chú nằm ở **giữa sheet**, không nhảy lên đè nút CTA khi link vừa tạo xong

> **Đã bỏ giới hạn 500 sự kiện.** Giờ chỉ giới hạn theo dung lượng, nên lịch to hơn nhiều
> vẫn đi trọn. Nếu QC từng có case "chia sẻ lịch 600 sự kiện bị cắt còn 500" thì **kết quả
> mong đợi nay đã khác**.

### 3.4 Không còn toggle chi tiết

- [ ] Sheet **không còn** dòng bật/tắt *"Include location, notes and links"*
- [ ] Câu disclosure phải nói rõ là chia sẻ **gồm cả** location, notes và links

---

## 4. Màn Calendars đổi cấu trúc

- [ ] Mở Calendars → là **màn full screen** (không phải sheet kéo lên), có **✕ ở góc trái**
- [ ] Header có **2 nút tròn bên phải**: **chia sẻ** (mũi tên lên) và **+**
- [ ] Bấm **+** → popup "New calendar" có **2 nhóm thẻ tách rời**: nhóm mẫu lịch, và bên
      dưới là **"Add a shared calendar"**
- [ ] Trong thẻ sharing ở thân màn: **chỉ còn "Manage sharing"** — hai dòng
      *"Share a calendar"* và *"Add a shared calendar"* đã chuyển lên header/popup,
      **không được xuất hiện hai lần**
- [ ] Lịch đã join nằm **phía trên** dòng Manage sharing
- [ ] **Chưa đăng nhập** → bấm nút chia sẻ ra màn mời đăng nhập, không phải sheet chia sẻ
- [ ] **Join link thì không cần đăng nhập** — đây là chủ ý, không report

---

## 5. Manage sharing

Đường vào: **Calendars → Manage sharing**.

- [ ] Là **màn full screen**, ✕ ở góc trái
- [ ] Có **nút "Share a calendar" ghim đáy màn** (mới ở PR #274) — nội dung cuộn **xuống
      dưới** nút đó và mờ dần, không bị cắt cụt
- [ ] Bấm nút đó → mở sheet chia sẻ; tạo xong link, đóng sheet → **thẻ mới xuất hiện ngay**
      trong danh sách
- [ ] Chưa chia sẻ gì → màn trống chỉ có 1 dòng chữ, **không** có nút CTA riêng ở giữa
      (vì nút đã ghim ở đáy — không được mời cùng một hành động hai lần)

Mỗi thẻ:

- [ ] Dòng **"Shared"** hiện **"42 events · 8 thg 9 – 1 thg 3"** — **không còn** hiện
      URL và **không còn** hiện ngày tạo link
- [ ] Nút copy nay ghi **"Copy link"** (trước là "Copy"), nằm cạnh nhãn **Access**
- [ ] Bấm copy → đổi thành **"Copied"** khoảng 1 giây rồi trở lại; copy thẻ khác không làm
      thẻ này đổi theo
- [ ] Link copy được dán ra ngoài và mở được
- [ ] **Access** đổi giữa xem/sửa → máy B nhận đúng quyền
- [ ] **Stop sharing** → hỏi xác nhận → link chết ở máy B

> **Case cần thử riêng:** xoá app rồi cài lại, mở Manage sharing. Danh sách link vẫn còn
> nhưng dữ liệu sự kiện thì không — lúc đó dòng "Shared" **quay về hiện ngày tạo link**.
> Đó là hành vi đúng, không phải bug.

---

## 6. Nhận link chia sẻ (máy B)

### 6.1 Dán link — "Add a shared calendar"

Đường vào: **Calendars → + → Add a shared calendar**.

- [ ] Ô dán link có **nút paste bên trong ô**, mờ đi khi clipboard không có chữ
- [ ] Dán link **hợp lệ** → hiện thẻ tóm tắt lịch (tên, **"42 events · khoảng ngày"**)
- [ ] Dán link **không phải của Ink** (vd `https://example.com/…`) → báo lỗi **ngay**,
      không gọi mạng
- [ ] Dán link **Ink nhưng đã chết** → câu lỗi dưới ô, ô vẫn **sửa được** (không văng ra
      màn hình lỗi riêng)
- [ ] Mất mạng → câu lỗi tương ứng, thử lại được
- [ ] Sửa lại link → lỗi cũ **biến mất** ngay khi gõ

### 6.2 Màn xem trước rồi Join

Mở thẳng link https trên máy B (hoặc bấm Continue từ sheet trên).

- [ ] Thẻ tóm tắt đầu màn, và **ngay dưới thẻ** là câu ghi chú "tên và mô tả là lời của
      người gửi… lịch này cũng xuất hiện trong app Lịch của Apple"
- [ ] Đáy màn **chỉ còn nút "Join calendar"** — đoạn chữ dài 4 dòng trước đây đã chuyển lên trên
- [ ] Link của người gửi ẩn danh (không có tên/mô tả) → các dòng đó **biến mất**, không để trống
- [ ] Join xong → lịch hiện trong Calendars **và** trong app Lịch của Apple
- [ ] Quay lại mục **2** ở trên và kiểm tra lại 4 danh sách

---

## 7. Tài khoản

### 7.1 Khi chưa đăng nhập

- [ ] **Cài đặt** → dòng tài khoản có **mascot Ink** và một câu mời, **không** còn ghi
      "Account · Not signed in"
- [ ] Mở màn Account → có **hình minh hoạ** + **3 dòng lợi ích**
- [ ] 3 dòng đó chỉ hứa những gì tài khoản thật sự mở ra (tạo link chia sẻ) — **không**
      được hứa việc join link (việc đó miễn phí)
- [ ] Nút **Google** dùng **logo màu thật**, không phải chữ G xám
- [ ] Màn mời đăng nhập (login gate) **không còn nút Cancel** — vuốt xuống để thoát

### 7.2 Khi đã đăng nhập

- [ ] Thẻ tài khoản trong Cài đặt là **MỘT dòng**: ảnh đại diện · tên trên, email dưới ·
      mũi tên. **Không** còn 3 dòng riêng, **không** còn dòng "Signed in with Google"
- [ ] Cạnh tên có **logo nhà cung cấp** (Apple/Google) cỡ nhỏ
- [ ] Tài khoản **Apple không có tên** → chỗ tên hiện **"Apple Account"**, và ảnh đại diện
      là **icon người trên nền tròn** (không phải vòng tròn trống)
- [ ] Trong màn Account: **Sign out** và **Delete account** nằm **cùng kiểu nút ở chân
      màn**, chỉ khác màu — Sign out màu chữ thường, Delete màu đỏ/coral
- [ ] Bấm Sign out → thoát đúng; Delete account → hỏi xác thực lại rồi mới xoá

---

## 8. Header Discover (PR #274)

- [ ] Đỉnh màn Discover có **nền tím nhạt** loang xuống rồi tắt hẳn khoảng ngang tiêu đề
      mục đầu tiên — **không** loang xuống tận danh sách template
- [ ] **Kéo xuống quá đà (overscroll)** ở đầu feed → **không** lộ vạch trắng cứng phía trên
      vùng màu
- [ ] Nền tím **không cuộn theo** feed — nó thuộc về đỉnh màn hình
- [ ] Chữ **"Ink"** to hơn trước (32pt). Đây là chủ ý, chỉ tab Discover mới vậy — 3 tab kia
      giữ nguyên cỡ cũ

Pill Pro cạnh chữ "Ink":

- [ ] **Chưa mua Pro** → pill **nền gradient tím**, chữ **PRO** trắng in hoa, icon **vương miện**,
      và có **các đốm sao nhỏ trôi chậm** ngang qua pill
- [ ] **Đã mua Pro** → pill **nền kính trong**, icon đổi thành **dấu tick có viền (seal)**,
      chữ PRO đổi sang **màu gradient tím**, **không còn sao**
- [ ] Cả hai trạng thái đều **bấm được** và mở màn Pro
- [ ] **Bật Reduce Motion** (Cài đặt → Trợ năng → Chuyển động) → sao **vẫn hiện** nhưng
      **đứng yên**. Sao biến mất hẳn là **sai**
- [ ] Chuyển sang tab khác rồi quay lại Discover → sao **vẫn chạy**, không bị đứng hình
- [ ] Đối chiếu **iOS 18 vs iOS 26**: trên 18 không có hiệu ứng kính thật, pill phải vẫn
      đọc được rõ, không bị chìm vào nền

> 🔋 **Nhờ QC để ý giúp:** mở Discover rồi để máy ở tab **khác** khoảng 30 phút, xem pin có
> tụt bất thường không. Hiệu ứng sao chạy liên tục khi Discover còn trong bộ nhớ, và
> chuyện nó có thật sự dừng khi sang tab khác hay không thì **chưa ai đo trên máy thật**.

---

## 9. Nút ✕ đổi sang cạnh trái + CTA sát đáy

Quy ước mới toàn app: **thoát thì bên trái, xác nhận thì bên phải**.

- [ ] **Màn Pro (paywall)** — ✕ ở góc **trên trái**
- [ ] **Chọn màu sự kiện** — ✕ bên trái
- [ ] **Chọn nhắc nhở (trong soạn ghi chú)** — ✕ bên trái
- [ ] **Màn giải thích cập nhật màn hình khoá** — ✕ bên trái
- [ ] Rà qua các sheet có nút CTA ở đáy: nút nay **sát mép dưới** hơn trước, không lơ lửng.
      Chữ/nút **không được bị che** hay tràn ra ngoài
- [ ] Cỡ chữ lớn nhất (Cài đặt → Màn hình → Cỡ chữ, kéo hết) → CTA trong các popup xác nhận
      **không bị đẩy xuống dưới màn**

---

## 10. Collection → tab Widget

- [ ] Đặt widget **ghi chú** ra màn hình chính, chọn 1 ghi chú cho nó
- [ ] Vào **Your collection → tab Widget** → thẻ widget đó hiển thị **đúng ghi chú đã chọn**
- [ ] Widget ghi chú **chưa chọn ghi chú nào** → **không** hiện trong danh sách
- [ ] Đặt thêm widget rồi quay lại app → danh sách **tự cập nhật** (không cần khởi động lại)
- [ ] Hướng dẫn thêm widget mở **chồng lên** màn collection, **không** làm đóng màn đó

---

## 11. Đã biết trước — không cần report

| Hiện tượng | Ghi chú |
|---|---|
| Chữ **"Manage sharing"** hiện **tiếng Anh** ở cả 11 ngôn ngữ | Thiếu bản dịch, có từ trước 2 PR này. Đã ghi nhận, sẽ bổ sung sau |
| Mở sheet chia sẻ với **"All upcoming"** trên lịch lớn hơi chậm | Quét 5 năm tới. Chỉ report nếu **treo hẳn** |
| Lịch join được **cũng xuất hiện trong app Lịch của Apple** | Đúng thiết kế |
| Sửa sự kiện trong app **Lịch của Apple** với lịch join được thì không được giữ | Đúng thiết kế — chưa có chữ nào trong app nói điều này, đã ghi nhận |
| Trên **iOS 18** pill Pro và header trông khác iOS 26 | Dưới 26 không có Liquid Glass |

---

## 12. Vùng cần rà hồi quy

Hai PR này động vào component dùng chung, nên rà lướt cả các màn **không** nằm trong danh
sách trên:

- [ ] Các sheet/popup khác trong app — kiểm tra nút đáy không bị tràn hay lơ lửng
      (`InkPopupScaffold` đổi padding đáy)
- [ ] Các ô nhập liệu khác — `InkTextField` được thêm nút trong ô và dòng báo lỗi
- [ ] Các nhãn **PRO** trên thẻ template ở Discover — đổi khoảng cách chữ, phải vẫn cân
      giữa trong viên nang, không lệch phải
- [ ] Header của các tab **Calendar / Tasks / Notes** — phải **giữ nguyên** cỡ chữ cũ, chỉ
      Discover mới to lên
