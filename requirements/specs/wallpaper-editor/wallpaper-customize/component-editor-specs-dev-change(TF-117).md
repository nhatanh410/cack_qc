# QC — Component Editor (sửa thành phần wallpaper lịch)

Màn hình sửa **các thành phần (component/band)** của một wallpaper lịch dạng `stack` —
thêm, xoá, đổi thứ tự, kéo đổi vị trí, kéo góc đổi bề rộng, và xếp chúng vào
**Row / Column** lồng nhau.

Người dùng ráp được bố cục của chính wallpaper, nên vùng ảnh hưởng là **toàn bộ
wallpaper lịch**: bản render thật trên màn khoá, Live Activity, widget và thumbnail đều
ăn theo dữ liệu mà màn này ghi ra.

---

## 1. Môi trường test

| Máy | Bắt buộc | Lý do |
|---|---|---|
| iPhone **iOS 18.x** | ✅ | Nền chính |
| iPhone **iOS 26.x** | ✅ | Chrome của màn này là glass, iOS 26 vẽ khác |
| **iPad** (dọc + ngang) | Nếu có | Canvas đo theo cửa sổ, xoay máy phải không lệch bound |

Ngôn ngữ: test chính bằng **Tiếng Việt** và **English**. Mọi chuỗi đều phải có đủ
18 ngôn ngữ — nếu thấy chuỗi tiếng Anh lọt vào máy tiếng Việt thì **report**.

---

## 2. Đường vào

**Discover → chọn một template lịch → Edit** (hoặc Calendar tab → nút cập nhật
wallpaper → Edit) → góc dưới bên trái canvas có chip **Customize** → mở màn
**Customize**, rồi chọn **Layout** ở công tắc dưới đáy.

> Màn Customize gộp hai editor cũ (nút `Components` và chip `Decorate`) thành hai
> chế độ **Layout | Decorate**. Template **không phải stack** mở thẳng Decorate
> và không có công tắc — **không phải lỗi**. Checklist riêng của phần gộp: mục 8.1.

Màn full-screen: wallpaper chiếm hết màn, các nút nổi lên trên.

Header của màn (chung cho cả hai chế độ): **✕ (Cancel) · [Undo | Redo] · ✓ (Done)** —
Undo và Redo chung **một viên** glass, có vạch ngăn giữa.
Góc phải dưới (Layout): rail dọc **+ (Add component) · Style · Show decorations ·
Sample events · Grid** đứng ngay trên nút **Layers** (Show decorations chỉ có khi wallpaper
đã có trang trí). Rail Decorate cùng chỗ: **Draw · Text · Emoji · Photo · Show calendar ·
Grid**. Dưới đáy: công tắc **Layout | Decorate** ở giữa · **Layers** sát lề phải.

Lần đầu vào có coach tour 2 bước: công tắc **Layout | Decorate**, rồi **rail** của chế
độ đang mở. Test lại: cài mới, hoặc chạy với cờ `-ink-debug-customize-coach`.

- [ ] Bước 1 soi viên công tắc, chữ nằm phía trên; **Next** → bước 2 soi rail, chữ nằm
      bên trái rail; **Got it** tắt tour. Bấm thẳng vào một tab ở bước 1 → đổi chế độ và
      sang bước 2 với rail + nội dung của chế độ vừa chọn
- [ ] Bấm một nút trên rail ở bước 2 → tour tắt, nút vẫn chạy
- [ ] Lần đầu mở ở Layout → sau đó sang Decorate lần đầu thì có riêng bước rail Decorate;
      lần đầu mở ở Decorate thì sang Layout **không** có gì. Mở lại màn → không hiện nữa
- [ ] Template không phải stack (không có công tắc) → chỉ một bước rail

---

## 3. Chọn thành phần

- [ ] Chạm vào một thành phần → hiện **khung viền** quanh nó + một **pill có 2 mục**:
      **Edit component** và **Delete component**
- [ ] Chạm ra vùng trống → bỏ chọn, pill biến mất
- [ ] Với thành phần **nằm trong Row/Column**: chạm lần 1 chọn **cả container**,
      chạm tiếp vào đúng thành phần con → chọn **con** (đi sâu dần từng cấp)
- [ ] Khung viền phải **ôm đúng** thành phần, kể cả thành phần đã bị thu nhỏ
      (không được to hơn phần nội dung thật)
- [ ] **Edit component** → mở bảng thuộc tính (mục 7)
- [ ] **Delete component** → xoá, hiện toast *"Removed …"* kèm nút **Undo**;
      bấm Undo phải trả lại đúng chỗ cũ

- [ ] Pill chỉ còn **Edit · Delete** — không còn mũi tên ↑ / ↓ / ← / →
      (đổi thứ tự bằng cách nhấn giữ rồi kéo, xem mục 4)

---

## 4. Di chuyển (kéo)

- [ ] Chạm chọn rồi **giữ và kéo** một thành phần → nó đi theo ngón tay **ngay
      lập tức**, không trễ
- [ ] Kéo **lên/xuống** trong stack hoặc column: không được đè lên thành phần phía
      trên, không được ra khỏi vùng nội dung (có chặn trên và chặn dưới)
- [ ] Kéo **ngang**: dịch trái/phải trong phạm vi cho phép
- [ ] **Nhấn giữ để đổi chỗ**: giữ yên ngón tay trên một thành phần ~0,4 giây → rung
      nhẹ, thành phần **nổi lên** (to hơn chút, có bóng), khung chọn chuyển sang nó dù
      trước đó chưa chọn. Kéo nhẹ trước khi đủ 0,4 giây thì là kéo đổi vị trí như cũ
- [ ] Đang giữ: kéo **lên hoặc xuống** (trong Row: trái/phải) → thành phần đi theo
      ngón tay, các thành phần khác **trượt** nhường chỗ, mỗi lần qua một chỗ rung
      nhẹ; kéo qua nhiều chỗ một lần được. Khoảng cách (gap) không bị đổi
- [ ] Nhả tay → thành phần trượt vào chỗ mới, không nháy về chỗ cũ, không hiện 2
      lần; nhả tay ở chỗ cũ thì không đổi gì và **không** có bước Undo. Đổi qua
      nhiều chỗ → Undo **một lần** là về như trước. Nhả tay không bị hiểu là chạm
- [ ] Thành phần **Fixed** (neo vị trí) nhấn giữ không nổi lên, không bị tính là
      "kế bên" và đứng yên khi thành phần khác đổi chỗ. Thành phần là con **duy
      nhất** trong Row/Column: nhấn giữ thì nhấc cả container
- [ ] Kéo một **Row/Column** (container): **toàn bộ** thành phần con đi theo, đúng
      một lần, **không nhanh hơn** khung viền, không văng ra ngoài
- [ ] Trong lúc kéo **không được xuất hiện bản sao** (component hiện 2 lần đè lên
      nhau), cũng không được **mất** thành phần rồi hiện lại khi nhả tay
- [ ] Nhả tay → ảnh render lại một lần, vị trí đúng chỗ vừa thả, **không nhảy về
      chỗ cũ rồi nhảy lại**
- [ ] Trong lúc kéo, thành phần được **vẽ lại thật** chứ không phải kéo một tấm ảnh:
      các thành phần phía dưới dồn theo, **thẻ nền của Row/Column đi cùng** với con
      của nó
- [ ] Wallpaper có **sticker/nét vẽ trang trí**: sticker **không biến mất** khi đang
      kéo
- [ ] Khung viền chọn luôn **ôm đúng** thành phần đang được vẽ, kể cả khi kéo nhanh
- [ ] Kéo liên tục 5–10 giây, lên xuống nhiều lần: **không giật cục**, không đứng
      hình. Nếu thấy giật → report kèm **model máy**

> Đây là chỗ dễ vỡ nhất. Test kỹ với template có Row lồng trong Column.

---

## 5. Đổi bề rộng (kéo góc)

Khi đang chọn, 4 góc là vùng kéo (không vẽ vòng tròn — cố ý).

- [ ] Kéo **góc phải** → cạnh **trái đứng yên**, chỉ mép phải chạy theo ngón
- [ ] Kéo **góc trái** → cạnh **phải đứng yên**
- [ ] Bề rộng đổi **realtime** theo ngón tay, không phải chờ nhả tay
- [ ] Kéo hẹp một thành phần có chữ: chữ **xuống dòng lại** và **chiều cao đổi
      ngay trong lúc kéo** (không co giãn méo hình, không chờ nhả tay)
- [ ] Nhả tay → không nhảy, không đổi kích thước lần nữa
- [ ] Thành phần **ở ngoài cùng (stack/column)**: kéo góc làm nó hẹp/rộng lại và
      **vẫn canh giữa**
- [ ] Thành phần **trong một Row**: kéo góc = **kéo vách ngăn** — thành phần này
      rộng ra thì thành phần bên cạnh **hẹp lại đúng bằng đó**, tổng bề rộng của
      Row không đổi
- [ ] Không kéo được nhỏ hơn mức tối thiểu (không được co về 0)

---

## 6. Thêm thành phần

Bấm **+** → sheet **Add component**, chia nhóm:
**Calendar · Events · Tasks · Progress · Text · Layout**

- [ ] Chọn một loại bất kỳ → thành phần được thêm, toast *"Added …"* + **Undo**
- [ ] Thành phần mới **không chiếm hết bề rộng** — nó có lề hai bên sẵn (giống
      Studio). Nếu nó full-width thì **report**
- [ ] Đang chọn một thành phần rồi bấm + → thành phần mới rơi **ngay dưới** cái
      đang chọn
- [ ] Đang chọn một **Row/Column** rồi bấm + → thành phần mới rơi **vào trong**
      container đó
- [ ] Lịch đã **tràn qua đáy** wallpaper (thêm/duplicate tới khi band cuối ra ngoài)
      → bấm + : sheet hiện dòng *"Your calendar already fills the wallpaper…"* trên
      cùng, mọi loại trong danh sách **mờ và không bấm được**. Xoá/thu nhỏ bớt cho vừa
      lại → mở lại + là chọn được. Band chỉ tràn ra **lề trái/phải** thì vẫn thêm được.
      **Không** chặn khi: chỉ có band **Fixed** (neo) tràn đáy; đang bật **Sample
      events**; bấm + ở **ô trống** của Row/Column hoặc đang chọn một container

### 6.1 Row / Column (nhóm **Layout**)

- [ ] Thêm **Row** → hiện một hàng gồm **2 ô trống** nét đứt, mỗi ô có nút **+**
      ở giữa, nằm **cạnh nhau**
- [ ] Thêm **Column** → 2 ô trống nét đứt **xếp dọc**
- [ ] Bấm **+** trong một ô trống → mở sheet, chọn loại → thành phần lấp **đúng ô
      đó**, ô còn lại **vẫn còn nguyên** (nếu ô số 2 biến mất hoặc thành phần vừa
      thêm chiếm hết hàng thì **report**)
- [ ] Bấm vào **nền** ô trống (không trúng nút +) → **chọn container**, không mở
      sheet
- [ ] Lấp nốt ô thứ 2 → Row/Column hiện đủ 2 thành phần, chia đôi
- [ ] Container đã đủ con thì **không còn ô trống** nào thừa ra

### 6.2 Giới hạn lồng nhau

Tối đa **3 cấp container**. Ví dụ hợp lệ: `Column > Row > Column`.

- [ ] Ở cấp thứ 3, mở sheet Add component → nhóm **Layout** **biến mất**
      (không cho thêm Row/Column nữa), các nhóm khác vẫn còn
- [ ] Ở cấp 1–2, nhóm **Layout** vẫn hiện bình thường
- [ ] Thêm một container **ngang hàng** (sibling) ở cấp còn cho phép → vẫn được

### 6.3 Container rỗng

- [ ] Thêm Row/Column rồi **không lấp gì**, bấm **✓ (Done)** → container rỗng bị
      **bỏ đi**, hiện toast *"Removed the empty layout"* kèm **Undo**
- [ ] Bấm **Undo** trên toast đó → container rỗng quay lại màn editor

---

## 7. Bảng thuộc tính (Edit component)

- [ ] Thứ tự nhóm: **Content → Text → Background → Position** (Position cuối vì
      kéo trên canvas đã làm phần lớn việc của nó)
- [ ] **Position**: chuyển **Auto ↔ Fixed** — đổi qua lại mà thành phần **không
      tự nhảy chỗ**
- [ ] Chọn **Fixed** → hiện thanh **Vertical position**, kéo thì thành phần chạy
      dọc theo
- [ ] Thanh **Width** — kéo thì bề rộng đổi theo, khớp với kéo góc ở mục 5
- [ ] Thanh **Size** — chỉ có với thành phần **ngoài cùng**; thành phần **nằm
      trong Row/Column thì KHÔNG có** thanh này (cố ý, xem mục 10)
- [ ] Các knob riêng của từng loại (màu, phông, số dòng…) đổi được và ăn ngay
- [ ] Bật **card** (Background → Card, hoặc chọn màu card) cho một thành phần đang
      chạy sát hai mép màn → thành phần tự thu vào, card **cách mép** hai bên như
      card của template có sẵn. Thành phần vốn đã có lề rộng hơn thì giữ nguyên;
      đã có card rồi, thu hẹp lề bằng tay thì không bị nới lại
- [ ] **Duplicate** · **Delete** · **Deselect** ở cuối bảng chạy đúng
- [ ] Bảng là **sheet native**: vuốt xuống ở grabber / thanh tiêu đề, hoặc cuộn
      nội dung lên **tới đỉnh** rồi vuốt tiếp → đóng bảng (thành phần vẫn được
      chọn). Nút **✕** trong bảng = bỏ chọn **và** đóng bảng → nút **+ (Add)**
      hiện lại
- [ ] Khi bảng đang mở: canvas, **Undo/Redo** vẫn bấm được; bấm **+** ở ô trống
      của Row/Column, **✕** (có thay đổi) hoặc **✓** (có Pro) → bảng đóng trước
      rồi sheet Add / Discard / Pro mới hiện
- [ ] Khi bảng mở mà che thành phần đang chọn → **canvas tự đẩy lên** cho thấy
      thành phần; đóng bảng thì canvas về chỗ cũ
- [ ] Đáy bảng **không hở** trên mọi máy (có/không có home indicator)
- [ ] Thanh Size: chữ chính tối đa **200**, chữ phụ (caption, giờ, thứ…) tối đa **60**.
      Chưa chỉnh thì thanh nằm **đúng cỡ đang vẽ** (không nằm ở 12); template có cỡ
      vượt thanh (tiêu đề tháng script 130) → chạm vào **không bị thu nhỏ**
- [ ] Nút **B** sáng sẵn trên band vốn vẽ đậm (số Countdown, tiêu đề tháng, Today's
      events, Reminders, Priority matrix…); bấm một lần là **bỏ đậm**
- [ ] Band **vừa thêm / vừa nhân bản**: chưa chỉnh gì thì Position **không có Reset**;
      chỉnh rồi Reset → về đúng như lúc thêm (không bị tràn full chiều ngang)
- [ ] **Bold + Italic** bật cùng lúc → chữ vừa đậm vừa nghiêng. 2 template có sẵn ghi
      cả bold+italic (month "elegant script" và priority matrix), nên tiêu đề của chúng
      đậm và nghiêng — đúng dữ liệu template
- [ ] Các mục phụ nằm **ngoài** More options, có tiêu đề nhỏ riêng: Weekday (Month grid, Mini month), Time (Today's events,
      Timeline), Date (Week events), Caption (Year progress, Countdown)
- [ ] Hàng **màu** có ô **Auto** đầu tiên (sáng khi chưa chỉnh) → bấm là trả về màu
      tự động của thành phần (ví dụ Priority matrix về lại bộ **4 màu** theo từng ô),
      không phải Reset cả nhóm
- [ ] Dải **Font** có chip **Default** đầu tiên (sáng khi chưa chọn font) → bấm là về
      font gốc của thành phần. Khi đã đặt font chung trong **Style**: dải font mờ,
      không bấm được, có dòng *"Using the wallpaper font from Style"*
- [ ] Bật cỡ chữ lớn (Accessibility): tên dòng xuống 2 dòng thay vì bị "…"; tiêu đề
      nhóm dài xuống dòng; các hàng trong **Layers** cao lên theo chữ, không tràn
- [ ] Xoá thành phần trong lúc bảng đang mở → bảng trượt xuống **vẫn còn nội dung**,
      không trắng trơn
- [ ] **iPad** (màn rộng): bảng thuộc tính là **cột bên phải** cạnh canvas, không phải
      popup giữa màn; canvas không bị đẩy lên
- [ ] **Countdown**: sửa được **chữ caption** (Content → Caption); xoá trống =
      ẩn caption. Gõ xong bấm Done/ra ngoài ô mới áp (1 bước Undo)
- [ ] **Priority matrix**: chữ công việc / ghi chú / giờ chỉnh riêng (cỡ, màu; font và
      đậm trong More options); **Card opacity**, **Border opacity** kéo về 0 thì mất
      nền / mất viền ô; **không** còn Blur và "Layout"; tối đa 4 việc mỗi ô
- [ ] **Month grid**: màu ngày quá khứ / tương lai (trong mục **Day**), căn phải
      tiêu đề tháng chạy đúng
- [ ] **Hour timeline**: có **Elapsed color** (màu phần đã qua)
- [ ] **Timetable**: đổi cỡ chữ ngày và màu giờ có tác dụng
- [ ] **Timeline**: Blur và **viền** (More options) của card ngoài đều có tác dụng; bỏ
      "Cards per day" và căn lề tiêu đề (không có tác dụng); chỉnh được Header / Subheader
- [ ] Danh sách **Add** không còn Quote, Almanac day, Timeline (chỉ sửa được
      trên template có sẵn)
- [ ] **Quote**: Content → **Quotes** liệt kê các câu theo thứ tự xoay vòng; chạm
      một câu để sửa, ✕ để xoá (câu cuối không xoá được), **Add quote** thêm câu.
      Mỗi lần sửa/thêm/xoá là **1 bước Undo**; Reset của Content trả lại đúng các
      câu gốc. Quote kiểu âm lịch (tự sinh chữ) **không** có danh sách
- [ ] Band có sự kiện (Today list, Timetable, Week schedule, Week events, Hour
      timeline, Mini month, Matrix…) có dòng **Event colors · <nguồn>** ở cuối
      thẻ Content (cùng thẻ, không tách riêng); bấm → đóng bảng thuộc tính, mở **Style**. Band không có sự kiện
      (Quote, Progress, Countdown) không có dòng này
- [ ] **Week schedule**: chỉnh được chữ tên sự kiện (font, cỡ, màu), cỡ/màu chữ
      **Day** và **Hours**, bật/tắt **Event titles**, **Today color**; trong More
      options: màu vạch hiện tại, màu kẻ, số sự kiện trùng giờ
- [ ] **Week events**: **Show +N**, **Today color**; Fill opacity nằm trong More
      options. **Hour timeline**: **Event titles**, cỡ/màu chữ **Event**; Label
      every, số sự kiện trùng giờ, Elapsed color nằm trong More options
- [ ] Nằm trong **More options** (không hiện sẵn): Month grid — Use event colors,
      màu ngày quá khứ/tương lai; Mini month — Dots per day, màu ngày quá khứ/tương lai;
      Reminder list — Checkbox color; Matrix — Checkbox shape, màu viền ô; Today list,
      Timeline — Time icon; Week events — Show +N; Hour timeline, Week schedule — Line
      color, Block color; font và đậm của mọi chữ phụ; Inset, Blur, viền của card
- [ ] **Không** còn control nào kéo mà không đổi gì: không có **Rotation** ở đâu cả;
      **Vertical position** chỉ ở Quote (More options); không có Day shape (Month
      grid), Color from event (Today list), căn lề số (Countdown), Distribute (Column)
- [ ] Month grid kiểu thường **không** hiện Events per day / Use event colors / chữ
      chip; kiểu **Event chips** mới hiện. Có **Month name**: English / Device language
- [ ] **Mọi** thành phần đều bật được **Card** (Background). Today list, Reminder list,
      Mini month, Lunar, Hour timeline, Week schedule, Timetable, Matrix: bật Card →
      hiện card sau thành phần, đổi màu / bo góc / viền đều ăn
- [ ] Mở inspector lần đầu, các nút/ thanh nằm đúng như đang vẽ: Quote căn **giữa**;
      Almanac, Lunar, Timeline tiêu đề **đậm**; Hour timeline **6–22h**; Today list
      Time icon **bật**
- [ ] Đặt font chung trong Style + chữ **nghiêng** → vẫn nghiêng
- [ ] Card đặc màu tối, chữ để Auto → chữ sáng; card trắng → chữ tối. Card mỏng
      (mặc định) + bật "Match colors to photo": chữ khó đọc trên nền card+ảnh thì
      tự đổi, chữ trắng đọc được trên card mờ thì giữ trắng

---

## 8. Undo / Redo / Lưu

- [ ] **Undo** hoàn lại **đúng một thao tác** — một lần kéo = một bước
      (không phải hoàn lại từng frame của cú kéo đó)
- [ ] **Redo** làm lại được
- [ ] **✓ (Done)** → quay lại màn editor, bố cục mới được giữ
- [ ] **✕ (Cancel)** khi có thay đổi → hỏi *"Discard changes?"* / *"Your changes
      won't be saved."*; chọn **Discard** → **mọi** thay đổi trong phiên bị bỏ (cả
      Layout lẫn Decorate, kể cả thành phần vừa thêm), wallpaper trở về đúng như
      lúc mở màn. Không có thay đổi (hoặc đã undo hết) → đóng luôn, không hỏi
- [ ] ✕ → Discard → mở lại Customize → **Undo bị mờ**: không lấy lại được thay
      đổi vừa huỷ

### 8.1 Hai chế độ Layout | Decorate

- [ ] Lần đầu mở → vào **Layout**. Chuyển sang Decorate, đóng, mở lại → vào
      **Decorate** (nhớ chế độ dùng lần trước)
- [ ] **Undo chung một lịch sử**: kéo một thành phần ở Layout → sang Decorate vẽ
      một nét → Undo lần 1 mất nét vẽ, **vẫn ở Decorate** → Undo lần 2 trả thành
      phần về chỗ cũ **và tự chuyển sang Layout**
- [ ] Redo đi ngược lại đúng thứ tự, cũng tự chuyển chế độ theo bước vừa làm lại
- [ ] Sửa bố cục ở Layout rồi sang Decorate → bật **Show calendar** → lịch vẽ
      đúng bố cục mới (không phải bố cục lúc mở màn)
- [ ] Công tắc chế độ **ẩn** khi: đang kéo, đang mở bảng thuộc tính, đang cầm bút /
      tẩy / eyedropper, đang gõ chữ
- [ ] Có sticker cutout hoặc chữ font Pro (tài khoản free) → ✓ hỏi Pro, ở **cả hai**
      chế độ

### 8.2 Layers (nút chồng lớp sát lề phải, dưới đáy)

- [ ] Bấm nút **Layers** → sheet liệt kê hai nhóm **Layout** (các band lịch) và
      **Decorate** (sticker, chữ, ảnh; nét vẽ tay là một dòng "Drawing" cố định)
- [ ] Nhóm Layout: **nhấn giữ một dòng rồi kéo** (dòng có biểu tượng ≡) sang chỗ mới
      → canvas đổi thứ tự band. Kéo qua nhiều band một lần vẫn chỉ 1 bước Undo. Band
      đang **Fixed** (neo vị trí) không có ≡ và không kéo được
- [ ] Nhóm Decorate: dòng trên cùng là item nằm **trước nhất**; kéo thả đổi item
      nào đè item nào, thấy ngay trên canvas
- [ ] Không kéo được một dòng từ nhóm này sang nhóm kia; không còn mũi tên
      lên/xuống ở từng dòng
- [ ] Khi kéo: dòng nhấc lên (nổi, có bóng), các dòng khác trượt nhường chỗ;
      **card và góc bo đứng yên** — kéo dòng đầu/cuối không kéo theo góc bo;
      đường kẻ giữa các dòng không nhảy. Sheet không cuộn, không bị vuốt đóng
      trong lúc kéo. Thả tay → dòng hạ xuống đúng chỗ, không giật
- [ ] VoiceOver: dòng kéo được có action **Move up / Move down**
- [ ] Tiêu đề **cả hai** nhóm đều có mũi tên: nhóm đang ở trên chỉ **xuống**, nhóm ở dưới
      chỉ **lên**; bấm cái nào cũng đổi chỗ hai nhóm
- [ ] Mũi tên ở tiêu đề nhóm **Decorate** → cả nhóm lên **trên lịch**: sticker
      đè lên ngày/sự kiện, ở **cả** Layout lẫn Decorate và trên **màn khoá thật**
      sau khi set
- [ ] Decorate nằm trên lịch → kéo một band trong Layout: band đi **dưới**
      sticker suốt cú kéo, không nháy lên trên
- [ ] Card **kính mờ** nằm dưới sticker khi decoration ở trên: card làm mờ ảnh
      nền, **không** làm mờ sticker đè lên nó
- [ ] Mỗi lần đổi thứ tự = 1 bước Undo; Undo một bước của nhóm kia thì màn tự
      chuyển chế độ (như mục 8.1)
- [ ] Template không phải stack: nhóm Layout chỉ có một dòng "Calendar", vẫn
      đổi tầng được cho nhóm Decorate
- [ ] Cuối panel Layers luôn có nhóm **Background** — cùng hàng ảnh nền như tab
      Background ở màn editor ngoài (Default · ảnh của bạn · ảnh có sẵn · thêm ảnh · More);
      bên dưới chỉ có thanh **Darken** — không có New photo every day, Match colors to
      photo hay Home Screen. Chọn ảnh khác → canvas đổi ngay (Layout lẫn Decorate),
      không cần đóng panel. Ảnh Pro vẫn chọn thử được, hỏi Pro ở bước xác nhận
      ngoài. Bấm ✕ Discard ở Customize → nền về như lúc mở
- [ ] Kéo **Darken** → nền tối/sáng theo ngón tay ngay lập tức, ở cả Layout lẫn
      Decorate; sticker (dưới hay trên lịch) **không** tối theo. Đặt wallpaper xong → độ
      tối trên màn khoá khớp với canvas. Bật *Match colors to photo* ở tab ngoài → thả tay
      Darken thì màu chữ lịch có thể đổi (đúng thiết kế). Eyedropper bên Decorate lấy màu
      đã tính độ tối

---

## 9. Chrome phụ

- [ ] **Grid** (cuối rail) bật/tắt lưới căn — lưới không được đè lên thao tác kéo
- [ ] Rail: khoảng cách giữa các icon bằng lề trong của viên (4pt), cả Layout lẫn Decorate
- [ ] Bật **Sample events** rồi bật **Grid** ngay → chỉ **một** toast (cái sau thay cái
      trước), không hai toast chồng nhau; ở Decorate cũng vậy
- [ ] **Ống hút màu** (Decorate): đổi background trong Layers rồi hút → lấy màu của nền
      **mới**; decorations nằm trên lịch → hút chỗ sticker đè lên chữ lấy màu **sticker**
- [ ] **Style** mở sheet Font · Event colors · Day colors · Position; đổi gì thấy ngay
      trên canvas. Đóng sheet → **Undo một lần** trả lại toàn bộ những gì đã đổi trong
      lần mở đó; mở rồi đóng mà không đổi gì thì không sinh bước undo và **Redo vẫn
      còn**. Đang mở sheet mà bấm Undo ở header → trả lại thay đổi vừa làm trong sheet
      (không có lần bấm "hụt")
- [ ] **Style → Font → Text size** (80%–130%): chữ của **mọi** thành phần to/nhỏ theo,
      khung giãn theo — ở 130% không chữ nào bị cắt hay đè nhau (miniMonth, todayList,
      reminderList, weekTimetable, progress). Lịch âm: chỉ tiêu đề và hàng thứ to lên,
      số trong vòng tròn giữ nguyên. Caption ở Decorate **không** đổi. Kéo về 100% thì
      như chưa chỉnh; lưu rồi mở lại vẫn giữ
- [ ] Toggle **Match colors to photo** có trong Style, kèm một dòng mô tả bên dưới
- [ ] Đang mở **Layers / Style / bảng thuộc tính** mà bấm **✕** (có thay đổi), **✓**
      (có Pro), chọn band rồi bấm **Edit**, hay bấm **+** ở ô trống → sheet đang mở
      đóng lại trước, rồi cái mới hiện ra; không có nút nào "bấm không ăn"
- [ ] **Show decorations** tắt → sticker/chữ/nét vẽ biến mất khỏi canvas Layout (cả lớp
      nằm trên lẫn dưới lịch); bật lại hiện lại. Không lưu vào wallpaper, không có bước undo
- [ ] **Sample events** (rail Layout): máy không có sự kiện nào → bật lên, lịch trên canvas
      hiện sự kiện/nhắc việc mẫu (cả khi sang Decorate); tắt đi về lịch thật. Thoát
      Customize → card ở màn editor ngoài luôn là lịch thật; wallpaper set ra không bao
      giờ có sự kiện mẫu
- [ ] Bật grid ở Layout rồi chuyển sang Decorate → lưới vẫn bật (một công tắc chung);
      đồng hồ, tai thỏ vẫn luôn hiện dù tắt grid; rail Decorate không còn nút *Lock screen*
- [ ] Khi một thành phần **tràn ra ngoài màn**, hiện cảnh báo
      *"Part of this runs off the screen"*; kéo nó về trong thì cảnh báo mất
- [ ] Nút ẩn/hiện chrome: ẩn hết nút để xem wallpaper "sạch", chạm lại thì hiện lại
- [ ] Xoay iPad → khung viền và các ô trống vẫn khớp với thành phần, không lệch

---

## 10. Hành vi CỐ Ý — không cần report

1. **Row/Column chỉ có 1 con** vẫn chiếm chỗ như đang có 2 con — vì ô trống thứ 2
   vẫn giữ chỗ.
2. Thành phần **bên trong** Row/Column **không có thanh Size** — bề rộng của nó do
   container chia, không phải tự phóng to thu nhỏ.
3. **Không vẽ vòng tròn ở 4 góc** — vùng kéo vẫn nằm ở góc, chỉ là không vẽ ra.
4. Chạm **1 lần** vào thành phần trong container chỉ chọn **container**; phải chạm
   tiếp mới vào được con. Đây là cách đi sâu từng cấp, không phải lỗi.
5. Template **không phải dạng stack** thì Customize mở thẳng Decorate, không có
   công tắc Layout.
6. Card **kính mờ** (frosted) có sticker nằm ngay dưới: **trong editor** card chỉ
   làm mờ ảnh nền, không làm mờ sticker. Wallpaper **đã lưu** thì đúng. Chỉ report
   nếu thấy sai trên **lock screen thật**.
7. **Trong lúc đang kéo**, chữ của thành phần hơi **mềm** hơn một chút (vẽ ở 2/3 độ
   phân giải cho kịp tốc độ ngón tay); **nhả tay ra là nét lại**. Chỉ report nếu
   vẫn mờ sau khi nhả tay.
8. Kéo di chuyển một thành phần **bên trong** Row/Column mà container cha có **thẻ
   nền (card)**: thẻ nền đó **tạm ẩn trong lúc kéo**, hiện lại khi nhả tay. Row/Column
   mặc định không có thẻ nền.
9. **Vừa nhả tay xong** mà chạm kéo tiếp ngay: thành phần **chờ khoảng 0.1 giây** rồi
   mới bắt đầu đi theo ngón tay (đợi layout mới vẽ xong, để không đáp sai chỗ).

---

## 11. Regression — cần rà lại

Màn này ghi thẳng vào dữ liệu wallpaper, nên sau khi sửa bố cục phải kiểm:

- [ ] **Đặt làm màn khoá thật** → wallpaper render ra đúng bố cục vừa sửa
      (không phải chỉ đúng trên preview)
- [ ] **Live Activity** của template đó vẫn chạy, không vỡ layout
- [ ] **Widget** / thumbnail trong "Your collection" cập nhật theo
- [ ] Mở lại template **đã sửa** → bố cục giữ nguyên, sửa tiếp được
- [ ] Các **template lịch cũ** (chưa động vào) render y như trước
- [ ] Wallpaper **note** (không phải lịch) không bị ảnh hưởng
- [ ] Wallpaper **đã có decoration từ trước** (tạo ở bản cũ) mở lên → decoration
      vẫn nằm dưới lịch như cũ

---

## 12. Cách report

Ghi kèm: **máy + phiên bản iOS**, **tên template**, **bố cục đang dựng**
(ví dụ: `Column > Row(monthGrid, todayList) > quote`), và **video quay màn hình**
nếu là lỗi lúc kéo — lỗi kéo gần như không mô tả bằng chữ được.
