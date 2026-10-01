# Bàn giao QC — Component Editor (sửa thành phần wallpaper lịch)

> **Test basis** cho Component Editor, TestFlight **1.2.18 (111)**.
> **Nguồn:** 10 ảnh chụp trang bàn giao QC mới nhất do dev gửi (footer trang: `docs/qc-component-editor.md`), chụp/tổng hợp lại ngày 2026-09-28. Đã đối chiếu từng mục với ảnh, giữ nguyên câu chữ và thứ tự của bản gốc; chỉ đổi định dạng sang Markdown.
> **Thay thế:** [QC — Component Editor 1.2-SUPERSEDED.md](QC%20—%20Component%20Editor%201.2-SUPERSEDED.md) (bản 1.2.17 (103)) — đã đổi tên `-SUPERSEDED` và thêm banner ngày 2026-09-28.
> **Quy ước:** §0–§13 đánh số **đúng theo trang gốc** để dễ đối chiếu. Mã `§N.M` là mã mục do QC gán thêm (thứ tự xuất hiện trong từng mục), **không có trong bản dev** — dùng làm khoá traceability cho test condition / test case.
> Phần **"Ghi chú của QC"** ở cuối là nhận xét của QC, **không phải nội dung do dev bàn giao**.

| Trường | Giá trị |
|---|---|
| Build | **1.2.18 (111)** |
| Tag | `v1.2.18-rc3` |
| PR | #226 · #325 · #326 |
| Tổng số mục tick trên trang gốc | 83 (bộ đếm `0 / 83`); bản chép này có 82 — xem ghi chú QC Q-5 |
| Ngôn ngữ test | Tiếng Việt + English (chuỗi mới đã dịch đủ 12 ngôn ngữ) |

> ⚠️ **rc1 và rc2 của 1.2.18 không lên TestFlight (lỗi build trên CI).** Build test là **111 (rc3)**. Nếu TestFlight hiện 1.2.18 với số build khác thì báo lại.

## Tổng quan tính năng

Một màn hình riêng để sửa **các thành phần (component/band)** của một wallpaper lịch dạng `stack` — thêm, xoá, đổi thứ tự, kéo đổi vị trí, kéo góc đổi bề rộng, và (mới nhất) xếp chúng vào **Row / Column** lồng nhau.

Trước đây người dùng chỉ đổi được màu/phông của wallpaper có sẵn. Bây giờ họ ráp được bố cục từ chính nó, nên **vùng ảnh hưởng là toàn bộ wallpaper lịch**: bản render thật trên màn khoá, Live Activity, widget và thumbnail đều ăn theo dữ liệu mà màn này ghi ra.

---

## §0. Điểm mới trong build này — test trước

Đợt này sửa theo danh sách QC gửi lần trước và thêm vài thay đổi về kéo. Những mục dưới đây là **khác so với build 1.2.17 (103)**, chi tiết nằm ở các mục sau:

- **Kéo tự do tới mép ảnh (mục 4):** band không còn bị chặn ở vạch trên/dưới của grid, chỉ bị chặn ở **mép ảnh**. Band **đầu tiên** kéo lên được qua vạch trên (giống Studio). Band vẫn **không đè lên band phía trên nó**.
- **Snap khi kéo dọc (mục 4):** hút vào **giữa màn**, vào **chỗ gap = 0** và vào **vạch dưới của grid**.
- **Số gap khi kéo** hiện cả **số âm** (vd `-115`), không còn luôn là 0, và không bao giờ hiện `-0`.
- **Đổi thứ tự ↑/↓ (mục 3):** không còn làm band **đè lên** band kia.
- **Duplicate band đầu:** bản sao không còn đè lên bản gốc.
- **Slider trong bảng thuộc tính (mục 7):** hết khựng khi kéo — kể cả qua kéo lại để chỉnh, tay hơi lệch dọc.
- Toàn bộ danh sách sửa theo QC lần trước (mục 7): vuốt xuống đóng bảng, ✕ bỏ chọn, đáy bảng không hở, giới hạn cỡ chữ, Bold+Italic, các mục phụ đưa ra ngoài, Reset màu, caption Countdown, Priority matrix, Month grid, Timetable, Timeline…

---

## §1. Môi trường test

| Máy | Bắt buộc | Lý do |
|---|---|---|
| iPhone **iOS 18.x** | ✅ | Nền chính |
| iPhone **iOS 26.x** | ✅ | Chrome của màn này là glass, iOS 26 vẽ khác |
| **iPad** (dọc + ngang) | Nếu có | Canvas đo theo cửa sổ, xoay máy phải không lệch bound |
| Máy **iOS 27** | ❌ | Shortcut đang lỗi sẵn trên iOS 27, không tính vào đợt này |

**Ngôn ngữ:** test chính bằng **Tiếng Việt** và **English**. Các chuỗi mới đã dịch đủ 12 ngôn ngữ — nếu thấy chuỗi tiếng Anh lọt vào máy tiếng Việt thì **report**.

---

## §2. Đường vào

**Discover → chọn một template lịch → Edit** (hoặc **Calendar tab → nút cập nhật wallpaper → Edit**) → trên header có **nút tròn hình chồng lớp** (`Components`), nằm **cạnh nút crop**.

> Nút này chỉ hiện với template dạng **stack** (template lịch đời mới). Template cũ không có nút — **không phải lỗi**.

Bấm vào → mở màn hình full-screen: wallpaper chiếm hết màn, các nút nổi lên trên.

- **Header:** ✕ (Cancel) · Undo · Redo · ✓ (Done).
- **Dưới đáy:** **+** (Add component) và nút **Show grid**.
- Lần đầu vào có một bước hướng dẫn: *"Tap to edit a piece"* — bấm để bỏ qua.

---

## §3. Chọn thành phần

- **§3.01** Chạm vào một thành phần → hiện **khung viền** quanh nó + một **pill có 2 mục**: **Edit component** và **Delete component**.
- **§3.02** Chạm ra vùng trống → bỏ chọn, pill biến mất.
- **§3.03** Với thành phần **nằm trong Row/Column**: chạm lần 1 chọn **cả container**, chạm tiếp vào đúng thành phần con → chọn **con** (đi sâu dần từng cấp).
- **§3.04** Khung viền phải **ôm đúng** thành phần, kể cả thành phần đã bị thu nhỏ (không được to hơn phần nội dung thật).
- **§3.05** **Edit component** → mở bảng thuộc tính (mục 7).
- **§3.06** **Delete component** → xoá, hiện toast *"Removed …"* kèm nút **Undo**; bấm Undo phải trả lại đúng chỗ cũ.
- **§3.07** **Đổi thứ tự:** pill có thêm mũi tên **↑ / ↓** (trong Row là **← / →**) — bấm thì thành phần đổi chỗ với thành phần kế bên; ở đầu/cuối thì mũi tên phía đó **ẩn đi**. Thành phần **Fixed** (neo vị trí) không có mũi tên và không bị tính là "kế bên" (nó nằm theo vị trí neo, đổi thứ tự không đổi gì trên màn). Mỗi lần bấm = **1 bước Undo**.
- **§3.08** Đổi thứ tự **không làm band nào đè lên band khác** — kể cả khi band đầu tiên đang được kéo lên cao (gap âm). Khoảng cách giữa các vị trí giữ nguyên, chỉ các band đổi chỗ cho nhau.
- **§3.09** **Duplicate** band đầu tiên đang có gap âm → bản sao nằm **dưới** bản gốc, có khoảng cách, không đè lên.

---

## §4. Di chuyển (kéo)

> Đây là chỗ đã sửa đi sửa lại nhiều nhất trong đợt này. **Test kỹ với template có Row lồng trong Column.**

- **§4.01** Chạm chọn rồi **giữ và kéo** một thành phần → nó đi theo ngón tay **ngay lập tức**, không trễ.
- **§4.02** Kéo lên/xuống trong stack hoặc column: **không được đè lên thành phần phía trên**.
- **§4.03** Giới hạn kéo là **mép ảnh**, không phải vạch grid: kéo xuống được **quá vạch dưới của grid** tới mép dưới ảnh; không kéo tràn ra khỏi ảnh.
- **§4.04** **Band đầu tiên** kéo lên được **qua vạch trên của grid** tới mép trên ảnh (giống Studio). Các band khác thì dừng khi chạm band phía trên.
- **§4.05** Trong lúc kéo, chip hiện **gap** (khoảng cách tới band phía trên): kéo band đầu lên quá vạch thì hiện **số âm** (vd `-40`); tại đúng vị trí gap 0 phải hiện `0`, **không bao giờ** `-0`.
- **§4.06** **Snap dọc** — rung nhẹ 1 lần khi hút vào:
  - **Giữa màn** (có đường gióng ngang hiện ra).
  - **Chỗ gap = 0** (band đầu: chỗ khối bắt đầu; band khác: vừa chạm band trên) → nhả tay ở đó thì chip hiện `0`.
  - **Vạch dưới của grid** (đáy band khớp vạch).
- **§4.07** Band đang nằm **sẵn** trên một điểm snap thì chạm kéo **không bị giữ lại** — phải kéo ra khỏi đó rồi mới hút lại.
- **§4.08** Kéo **ngang**: dịch trái/phải trong phạm vi cho phép.
- **§4.09** Kéo một **Row/Column** (container): **toàn bộ** thành phần con đi theo, đúng một lần, **không nhanh hơn** khung viền, không văng ra ngoài.
- **§4.10** Trong lúc kéo **không được xuất hiện bản sao** (component hiện 2 lần đè nhau), cũng không được **mất** thành phần rồi hiện lại khi nhả tay.
- **§4.11** Nhả tay → ảnh render lại **một lần**, vị trí đúng chỗ vừa thả, **không nhảy về chỗ cũ rồi nhảy lại**.
- **§4.12** Trong lúc kéo, thành phần được **vẽ lại thật** chứ không phải kéo một tấm ảnh: các thành phần phía dưới dồn theo, **thẻ nền của Row/Column đi cùng** với con của nó.
- **§4.13** Wallpaper có **sticker/nét vẽ trang trí**: sticker **không biến mất** khi đang kéo (bản cũ bị mất sticker trong lúc kéo).
- **§4.14** Khung viền chọn luôn **ôm đúng** thành phần đang được vẽ, kể cả khi kéo nhanh.
- **§4.15** Kéo liên tục 5–10 giây, lên xuống nhiều lần: **không giật cục, không đứng hình**. Nếu thấy giật → report kèm **model máy**.

---

## §5. Đổi bề rộng (kéo góc)

Khi đang chọn, **4 góc là vùng kéo** (không vẽ vòng tròn — cố ý).

- **§5.01** Kéo **góc phải** → cạnh trái đứng yên, chỉ mép phải chạy theo ngón.
- **§5.02** Kéo **góc trái** → cạnh phải đứng yên.
- **§5.03** Bề rộng đổi **realtime** theo ngón tay, không phải chờ nhả tay.
- **§5.04** Kéo hẹp một thành phần có chữ: chữ **xuống dòng lại** và **chiều cao đổi ngay trong lúc kéo** (không co giãn méo hình, không chờ nhả tay).
- **§5.05** Nhả tay → không nhảy, không đổi kích thước lần nữa.
- **§5.06** Thành phần **ở ngoài cùng** (stack/column): kéo góc làm nó hẹp/rộng lại và **vẫn canh giữa**.
- **§5.07** Thành phần **trong một Row**: kéo góc = **kéo vách ngăn** — thành phần này rộng ra thì thành phần bên cạnh **hẹp lại đúng bằng đó**, tổng bề rộng của Row không đổi.
- **§5.08** Không kéo được nhỏ hơn mức tối thiểu (không được co về 0).

---

## §6. Thêm thành phần

Bấm **+** → sheet **Add component**, chia nhóm: **Calendar · Events · Tasks · Progress · Layout**
(nhóm *Text* đã bỏ: **Quote, Almanac day và Timeline chỉ sửa được trên template có sẵn, không thêm mới**).

- **§6.01** Chọn một loại bất kỳ → thành phần được thêm, toast *"Added …"* + **Undo**.
- **§6.02** Thành phần mới **không chiếm hết bề rộng** — nó có lề hai bên sẵn (giống Studio). Nếu full-width thì **report**.
- **§6.03** Đang chọn một thành phần rồi bấm **+** → thành phần mới rơi **ngay dưới** cái đang chọn.
- **§6.04** Đang chọn một **Row/Column** rồi bấm **+** → thành phần mới rơi **vào trong** container đó.

### §6.1 Row / Column (nhóm Layout)

- **§6.1.01** Thêm **Row** → hiện một hàng gồm **2 ô trống** nét đứt, mỗi ô có nút **+** ở giữa, nằm **cạnh nhau**.
- **§6.1.02** Thêm **Column** → 2 ô trống nét đứt **xếp dọc**.
- **§6.1.03** Bấm **+** trong một ô trống → mở sheet, chọn loại → thành phần lấp **đúng ô đó**, ô còn lại **vẫn còn nguyên**. *(Đây là lỗi đã fix — nếu ô số 2 biến mất hoặc thành phần vừa thêm chiếm hết hàng thì **report**.)*
- **§6.1.04** Bấm vào **nền** ô trống (không trúng nút +) → **chọn container**, không mở sheet.
- **§6.1.05** Lấp nốt ô thứ 2 → Row/Column hiện đủ 2 thành phần, chia đôi.
- **§6.1.06** Container đã đủ con thì **không còn ô trống** nào thừa ra.

### §6.2 Giới hạn lồng nhau

Tối đa **3 cấp container**. Ví dụ hợp lệ: `Column > Row > Column`.

- **§6.2.01** Ở **cấp thứ 3**, mở sheet Add component → nhóm **Layout biến mất** (không cho thêm Row/Column nữa), các nhóm khác vẫn còn.
- **§6.2.02** Ở cấp 1–2, nhóm **Layout** vẫn hiện bình thường.
- **§6.2.03** Thêm một container **ngang hàng (sibling)** ở cấp còn cho phép → vẫn được.

### §6.3 Container rỗng

- **§6.3.01** Thêm Row/Column rồi **không lấp gì**, bấm **✓ (Done)** → container rỗng bị bỏ, hiện toast *"Removed the empty layout"* kèm **Undo**.
- **§6.3.02** Bấm **Undo** trên toast đó → container rỗng quay lại màn editor.

---

## §7. Bảng thuộc tính (Edit component)

- **§7.01** **Position:** chuyển **Auto ↔ Fixed** — đổi qua lại mà thành phần **không tự nhảy chỗ**.
- **§7.02** Chọn **Fixed** → hiện thanh **Vertical position**, kéo thì thành phần chạy dọc theo.
- **§7.03** Thanh **Width** — kéo thì bề rộng đổi theo, khớp với kéo góc ở mục 5.
- **§7.04** Thanh **Size** — chỉ có với thành phần **ngoài cùng**; thành phần **nằm trong Row/Column thì KHÔNG có** thanh này (cố ý, xem mục 10).
- **§7.05** Các **knob riêng** của từng loại (màu, phông, số dòng…) đổi được và ăn ngay.
- **§7.06** **Duplicate · Delete · Deselect** ở cuối bảng chạy đúng.
- **§7.07** Các slider nhóm **Position** (Vertical position, Width, Horizontal offset, Size): kéo **mượt, không khựng**, thành phần trên canvas chạy theo **ngay**. Test kiểu **kéo qua kéo lại** để chỉnh, tay **hơi lệch dọc** — trước đây đúng kiểu này bị khựng. Nhả tay = 1 bước Undo.
- **§7.08** Đang kéo slider thì **bảng không bị cuộn theo**; nhưng **vuốt dọc** bắt đầu trên slider vẫn cuộn bảng bình thường.
- **§7.09** Bảng có **thanh kéo (grabber)** trên đầu: **vuốt xuống** để đóng bảng (thành phần vẫn được chọn). Nút **✕** trong bảng = **bỏ chọn và đóng bảng** → nút **+ (Add)** hiện lại.
- **§7.10** Khi bảng mở mà che thành phần đang chọn → **canvas tự đẩy lên** cho thấy thành phần; đóng bảng thì canvas về chỗ cũ.
- **§7.11** Đáy bảng **không hở** trên mọi máy (có/không có home indicator).
- **§7.12** Thanh **Size**: chữ chính tối đa **200**, chữ phụ (caption, giờ, thứ…) tối đa **60**.
- **§7.13** **Bold + Italic** bật cùng lúc → chữ vừa đậm vừa nghiêng (trước chỉ ăn 1). Lưu ý: 2 template có sẵn cả bold+italic (month "elegant script" và priority matrix) nên tiêu đề giờ **đậm hơn** trước — đúng dữ liệu template.
- **§7.14** Các **mục phụ đã đưa ra ngoài** (không còn nằm trong *More options*), có tiêu đề nhỏ riêng: **Weekday** (Month grid, Mini month) · **Time** (Today's events, Timeline) · **Date** (Week events) · **Caption** (Year progress, Countdown).
- **§7.15** Hàng **màu** đã từng chỉnh có nút **↺ Reset** → trả về màu mặc định của thành phần (ví dụ Priority matrix về lại bộ **4 màu** theo từng ô).
- **§7.16** **Countdown:** sửa được **chữ caption** (Content → Caption); xoá trống = ẩn caption. Gõ xong bấm Done/ra ngoài ô mới áp (1 bước Undo).
- **§7.17** **Priority matrix:** màu chữ **ghi chú / công việc / giờ** riêng, **Blur** cho nền ô; **không còn "Layout"** (không có renderer nào vẽ dạng list).
- **§7.18** **Month grid:** màu ngày **quá khứ / tương lai** (trong mục **Day**), căn phải tiêu đề tháng chạy đúng.
- **§7.19** **Hour timeline:** có **Elapsed color** (màu phần đã qua).
- **§7.20** **Timetable:** đổi cỡ chữ ngày và màu giờ có tác dụng.
- **§7.21** **Timeline:** **Blur** nền thẻ có tác dụng; bỏ "Cards per day" (không có tác dụng).
- **§7.22** Danh sách **Add** không còn Quote, Almanac day, Timeline (chỉ sửa được trên template có sẵn).

---

## §8. Undo / Redo / Lưu

- **§8.01** **Undo** hoàn lại **đúng một thao tác** — một lần kéo = một bước (không phải hoàn lại từng frame của cú kéo đó).
- **§8.02** **Redo** làm lại được.
- **§8.03** **✓ (Done)** → quay lại màn editor, bố cục mới được giữ.
- **§8.04** **✕ (Cancel)** → quay lại, **mọi** thay đổi trong phiên bị bỏ (kể cả thành phần vừa thêm), wallpaper trở về đúng như lúc mở màn.

---

## §9. Chrome phụ

- **§9.01** **Show grid** bật/tắt lưới căn — lưới không được đè lên thao tác kéo.
- **§9.02** Khi một thành phần **tràn ra ngoài màn**, hiện cảnh báo *"Part of this runs off the screen"*; kéo nó về trong thì cảnh báo mất.
- **§9.03** Nút ẩn/hiện chrome: ẩn hết nút để xem wallpaper "sạch", chạm lại thì hiện lại.
- **§9.04** Xoay iPad → khung viền và các ô trống vẫn khớp với thành phần, không lệch.

---

## §10. Hành vi CỐ Ý — không cần report

1. **Row/Column chỉ có 1 con** vẫn chiếm chỗ như đang có 2 con — vì ô trống thứ 2 vẫn giữ chỗ.
2. Thành phần **bên trong** Row/Column **không có thanh Size** — bề rộng của nó do container chia, không phải tự phóng to thu nhỏ.
3. **Không vẽ vòng tròn ở 4 góc** — vùng kéo vẫn nằm ở góc, chỉ là không vẽ ra.
4. Chạm **1 lần** vào thành phần trong container chỉ chọn **container**; phải chạm tiếp mới vào được con. Đây là cách đi sâu từng cấp, không phải lỗi.
5. Template **không phải dạng stack** thì không có nút Components.
6. Card **kính mờ (frosted)** có sticker nằm ngay dưới: **trong editor** card chỉ làm mờ ảnh nền, không làm mờ sticker. Wallpaper **đã lưu** thì đúng. Chỉ report nếu thấy sai trên **lock screen thật**.
7. **Trong lúc đang kéo**, chữ của thành phần hơi **mềm** hơn một chút (vẽ ở 2/3 độ phân giải cho kịp tốc độ ngón tay); **nhả tay ra là nét lại**. Chỉ report nếu vẫn mờ sau khi nhả tay.
8. Kéo di chuyển một thành phần **bên trong** Row/Column mà container cha có **thẻ nền (card)**: thẻ nền đó **tạm ẩn trong lúc kéo**, hiện lại khi nhả tay. Row/Column mặc định không có thẻ nền. *(Xem ghi chú QC Q-1 — có điểm cần đối chiếu với §4.12.)*
9. **Vừa nhả tay xong mà chạm kéo tiếp ngay:** thành phần **chờ khoảng 0.1 giây** rồi mới bắt đầu đi theo ngón tay (đợi layout mới vẽ xong, để không đáp sai chỗ).
10. **Band đầu tiên nằm trên vạch trên của grid** (lấn vào vùng đồng hồ) là **được phép** — giống Studio. Một số template có sẵn (`mix-class-schedule`, `mix-daily-brief`, `mix-focus-today`, `mix-mindful-month`) vốn đã nằm hơi cao hơn vạch. Grid chỉ là đường gióng, không phải giới hạn.
11. Band có **thẻ nền (card)**: thẻ nhô lên trên band một chút, nên kể cả ở gap 0, viền thẻ có thể nằm **trên** vạch grid. Đây là thiết kế đã duyệt trên phone.
12. Con số cạnh tên slider **Position** (vd `259`) **chỉ cập nhật khi nhả tay**; trong lúc kéo, xem giá trị ở **bong bóng** trên núm slider.
13. Band **Fixed** không có mũi tên ↑/↓ và không bị tính là "kế bên" khi đổi thứ tự.

---

## §11. Regression — cần rà lại

Màn này ghi thẳng vào dữ liệu wallpaper, nên sau khi sửa bố cục phải kiểm tra tiếp ngoài màn editor:

- **§11.01** **Đặt làm màn khoá thật** → wallpaper render ra đúng bố cục vừa sửa (không phải chỉ đúng trên preview).
- **§11.02** **Live Activity** của template đó vẫn chạy, không vỡ layout.
- **§11.03** **Widget** / thumbnail trong "Your collection" cập nhật theo.
- **§11.04** Mở lại template **đã sửa** → bố cục giữ nguyên, sửa tiếp được.
- **§11.05** Các **template lịch cũ** (chưa động vào) render y như trước.
- **§11.06** Wallpaper **note** (không phải lịch) không bị ảnh hưởng.

---

## §12. Cần QC làm rõ (chưa sửa)

> ⚠️ **Open questions — dev đang chờ QC phản hồi, chưa có quyết định.** Không suy diễn hành vi mong đợi cho hai mục này khi viết test case; đánh dấu `GAP` / `BLOCKED` cho đến khi có trả lời.

- **Year progress — "target date":** trong code **không có** tuỳ chọn target date cho Year progress (Countdown thì có). Gửi **ảnh chụp** chỗ QC thấy mục này.
- **Quote — "chữ / số dòng":** chưa rõ lỗi cụ thể. Mô tả giúp: QC làm gì, thấy gì, mong đợi gì (ví dụ: ô *Lines* đang để 2 mà quote chỉ 1 dòng; hay muốn sửa được chữ của quote ngay trong màn này).

---

## §13. Cách report

Ghi kèm: **máy + phiên bản iOS**, **tên template**, **bố cục đang dựng** (ví dụ `Column > Row(monthGrid, todayList) > quote`), và **video quay màn hình** nếu là lỗi lúc kéo — lỗi kéo gần như không mô tả bằng chữ được.

> *Tick lưu trên trình duyệt của riêng mỗi người (không đồng bộ giữa người/máy). Nguồn: `docs/qc-component-editor.md`.*

---

# Ghi chú của QC (không thuộc tài liệu dev)

## A. So với bản 1.2.17 (103) — thay đổi cần cập nhật test analysis / test plan / test case

Đối chiếu [bản 1.2.17](QC%20—%20Component%20Editor%201.2-SUPERSEDED.md) với bản này. Đây là điểm tham chiếu để quyết định slug mới cho bộ test (xem "Việc còn lại"); **chưa** phải test condition.

| # | Khu vực | 1.2.17 (103) | 1.2.18 (111) |
|---|---|---|---|
| D-1 | Giới hạn kéo dọc | Chặn trên/dưới "vùng nội dung" | Chặn ở **mép ảnh**; band đầu qua được vạch trên grid (§4.03, §4.04) |
| D-2 | Snap dọc + chip gap | Không đề cập | **Mới:** snap giữa màn / gap 0 / vạch dưới grid + rung; chip gap hiện số âm (§4.05–§4.07) |
| D-3 | Chữ khi kéo/resize | "Cố ý": chữ **không** xuống dòng lại, chiều cao không đổi lúc kéo; nhả tay mới chỉnh | **Đảo ngược ở resize:** chữ xuống dòng lại + đổi chiều cao **ngay lúc kéo** (§5.04). Khi *move* chỉ còn "chữ hơi mềm 2/3 độ phân giải" (§10 #7) — **mục "cố ý" cũ #1 không còn** |
| D-4 | Thẻ nền container khi kéo | "Cố ý": thẻ nền không đổi theo từng frame | Vẽ lại thật, thẻ nền đi cùng con (§4.12) — nhưng §10 #8 nói thẻ tạm ẩn (xem Q-1). **Mục "cố ý" cũ #2 đã đổi** |
| D-5 | Đổi thứ tự ↑/↓ (← → trong Row), Fixed loại trừ, Duplicate | Không có | **Mới** (§3.07–§3.09) |
| D-6 | Nhóm sheet Add | Calendar · Events · Tasks · Progress · **Text** · Layout | Bỏ **Text**; Quote/Almanac day/Timeline không thêm mới được (§6, §7.22) |
| D-7 | Bảng thuộc tính | Position, Width, Size, knob, Duplicate/Delete/Deselect | Thêm: slider mượt, grabber + vuốt đóng, ✕ bỏ chọn, canvas đẩy lên, đáy không hở, giới hạn Size 200/60, Bold+Italic, mục phụ ra ngoài, Reset màu, caption Countdown, knob riêng Priority matrix / Month grid / Hour timeline / Timetable / Timeline (§7.07–§7.21) |
| D-8 | Trong lúc kéo: sticker/nét vẽ | Không đề cập | Sticker không được biến mất (§4.13) |
| D-9 | Kéo liên tục 5–10 giây (hiệu năng) | Không đề cập | **Mới**, yêu cầu ghi model máy nếu giật (§4.15) |
| D-10 | Hành vi cố ý | 7 mục | 13 mục (§10) — có mục đã bỏ/đổi, có mục mới |
| D-11 | Mục "Cần QC làm rõ" | Không có | **Mới** (§12) — 2 open question |
| D-12 | Thông tin build | 1.2.17 (103) | 1.2.18 (111, rc3); rc1/rc2 không lên TestFlight; PR #226 · #325 · #326 |

Các mục còn lại của 1.2.17 (chọn, kéo ngang, resize góc trái/phải, Row/Column, giới hạn 3 cấp, container rỗng, Undo/Cancel/Done, regression §11, môi trường §1) **giữ nguyên nội dung**.

## B. Điểm cần xác nhận với dev

- **Q-1 — §4.12 vs §10 #8 (có vẻ mâu thuẫn).** §4.12: trong lúc kéo, "**thẻ nền của Row/Column đi cùng với con**". §10 #8: khi kéo thành phần bên trong Row/Column có thẻ nền, thẻ nền đó "**tạm ẩn trong lúc kéo**". Chưa rõ hai câu áp dụng cho hai trường hợp khác nhau (kéo *container* vs kéo *con*) hay là mâu thuẫn thật. → Hỏi dev trước khi viết expected result cho case kéo Row/Column có card.
- **Q-2 — §7.13 ("tiêu đề giờ đậm hơn trước").** Chưa nêu template/giá trị đậm mong đợi cụ thể; chỉ nói "đúng dữ liệu template". Cần baseline (ảnh/so sánh với 1.2.17) để xác nhận không phải lỗi.
- **Q-3 — Mức tối thiểu bề rộng (§5.08) và thời điểm "cấp 3" (§6.2).** Giữ nguyên câu hỏi mở từ bản 1.2.17 — bản 1.2.18 không bổ sung số cụ thể.
- **Q-4 — §12 Year progress "target date" và Quote "chữ / số dòng"**: chờ QC trả lời (ảnh chụp / mô tả bước tái hiện). Chưa có expected result.
- **Q-5 — Số mục tick.** Trang gốc hiển thị bộ đếm `0 / 83`; khi chép từ ảnh, QC đếm được **82** ô tick (§3: 9 · §4: 15 · §5: 8 · §6: 14 [4 + 5 + 3 + 2] · §7: 22 · §8: 4 · §9: 4 · §11: 6). Lệch 1 mục có thể do cách đếm sub-bullet (3 gạch con của snap ở §4.06) hoặc một mục bị khuất giữa hai ảnh chụp; **nên đối chiếu lại với trang gốc** trước khi coi bộ spec này là đầy đủ 100%.

## C. Việc còn lại

1. ✅ **Đã đánh dấu bản 1.2.17 là `-SUPERSEDED`** (2026-09-28): đổi tên file, thêm banner, và cập nhật link trỏ tới file này ở test-analysis / test-plan / test-cases `component-editor`, `exploratory/14_edit-wallpaper.md`, `wideframes/14_edit-wallpaper.md`, `screenshots/iphone/index.md`. Chỉ đổi đường dẫn link, không đổi nội dung các tài liệu đó.
2. **Chạy lại pipeline** (`/spec-intake`) với slug mới (đề xuất `1.2.18`) thay vì ghi đè bộ test 1.2.17 — thay đổi D-1…D-9 đủ lớn (đảo ngược hành vi cố ý, thêm snap, thêm reorder) để theo quy tắc "mint slug mới". Test analysis phải dừng ở Q-1 và §12 (human-in-the-loop) cho tới khi có trả lời.
