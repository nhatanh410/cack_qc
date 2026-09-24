## QC — Component Editor 1.2.17

Sep 24, 2026 · @Someone

> *Ghi chú 2026-09-24: bảng "Máy / Bắt buộc / Lý do" và tiêu đề "Hành vi cố ý" bên dưới đã được sửa lại theo đúng [bản PDF gốc](QC%20—%20Component%20Editor%201.2.17.pdf) — bản markdown trước đó bị vỡ định dạng khi copy (bảng dính chữ thành 1 dòng, tiêu đề mất khoảng trắng). Nội dung không đổi, chỉ sửa format.*

Bản TestFlight 1.2.17 (103) mở một màn hình mới để ráp các thành phần của wallpaper lịch — thêm, xoá, kéo đổi chỗ, kéo góc đổi bề rộng, và xếp chúng vào Row / Column lồng nhau. Vì màn này ghi thẳng vào dữ liệu wallpaper nên vùng ảnh hưởng là toàn bộ wallpaper lịch: màn khoá thật, Live Activity, widget và thumbnail.

## Môi trường và đường vào

Test trên TestFlight 1.2.17 (103). Chạy chính bằng Tiếng Việt và English — chuỗi mới đã dịch đủ 12 ngôn ngữ, thấy tiếng Anh lọt vào máy tiếng Việt thì report.

| Máy | Bắt buộc | Lý do |
| --- | --- | --- |
| iPhone iOS 18.x | Có | Nền chính |
| iPhone iOS 26.x | Có | Chrome của màn này là glass, iOS 26 vẽ khác |
| iPad (dọc + ngang) | Nếu có | Canvas đo theo cửa sổ, xoay máy phải không lệch bound |
| iPhone iOS 27 | Không | Shortcut đang lỗi sẵn trên iOS 27, không tính vào đợt này |

Đường vào: Discover → chọn một template lịch → Edit (hoặc Calendar tab → nút cập nhật wallpaper → Edit) → trên header có nút tròn hình chồng lớp (Components), nằm cạnh nút crop.

Nút này chỉ hiện với template dạng stack (template lịch đời mới). Template cũ không có nút — không phải lỗi.

Bấm vào mở màn full-screen: wallpaper chiếm hết màn, các nút nổi lên trên. Header có ✕ · Undo · Redo · ✓; dưới đáy có + và Show grid. Lần đầu vào có một bước hướng dẫn "Tap to edit a piece" — bấm để bỏ qua.

## Chọn thành phần

- Chạm vào một thành phần → hiện khung viền quanh nó + một pill có 2 mục: Edit component và Delete component

- Chạm ra vùng trống → bỏ chọn, pill biến mất

- Thành phần nằm trong Row/Column: chạm lần 1 chọn cả container, chạm tiếp vào đúng thành phần con → chọn con (đi sâu dần từng cấp)

- Khung viền ôm đúng thành phần, kể cả thành phần đã bị thu nhỏ — không được to hơn phần nội dung thật

- Edit component mở bảng thuộc tính

- Delete component xoá được, hiện toast "Removed …" kèm Undo; bấm Undo phải trả lại đúng chỗ cũ

## Di chuyển (kéo)

Đây là chỗ đã sửa đi sửa lại nhiều nhất trong đợt này — test kỹ với template có Row lồng trong Column.

- Chạm chọn rồi giữ và kéo → thành phần đi theo ngón tay ngay lập tức, không trễ

- Kéo lên/xuống trong stack hoặc column: không đè lên thành phần phía trên, không ra khỏi vùng nội dung (có chặn trên và chặn dưới)

- Kéo ngang: dịch trái/phải trong phạm vi cho phép

- Kéo một Row/Column: toàn bộ thành phần con đi theo, đúng một lần, không nhanh hơn khung viền, không văng ra ngoài

- Trong lúc kéo không xuất hiện bản sao (component hiện 2 lần đè nhau), cũng không mất thành phần rồi hiện lại khi nhả tay

- Nhả tay → ảnh render lại một lần, đúng chỗ vừa thả, không nhảy về chỗ cũ rồi nhảy lại

## Đổi bề rộng (kéo góc)


Khi đang chọn, 4 góc là vùng kéo — không vẽ vòng tròn, đó là cố ý.

- Kéo góc phải → cạnh trái đứng yên, chỉ mép phải chạy theo ngón

- Kéo góc trái → cạnh phải đứng yên

- Bề rộng đổi realtime theo ngón tay, không phải chờ nhả tay

- Nhả tay → không nhảy, không đổi kích thước lần nữa

- Thành phần ở ngoài cùng (stack/column): kéo góc làm nó hẹp/rộng lại và vẫn canh giữa

- Thành phần trong một Row: kéo góc = kéo vách ngăn — cái này rộng ra thì cái bên cạnh hẹp lại đúng bằng đó, tổng bề rộng của Row không đổi

- Không kéo được nhỏ hơn mức tối thiểu (không co về 0)

## Thêm thành phần, Row và Column

Bấm + → sheet Add component, chia nhóm: Calendar · Events · Tasks · Progress · Text · Layout.

- Chọn một loại bất kỳ → thêm được, toast "Added …" + Undo

- Thành phần mới không chiếm hết bề rộng — nó có lề hai bên sẵn (giống Studio). Nếu full-width thì report

- Đang chọn một thành phần rồi bấm + → cái mới rơi ngay dưới cái đang chọn

- Đang chọn một Row/Column rồi bấm + → cái mới rơi vào trong container đó

## Row / Column (nhóm Layout)

- Thêm Row → một hàng gồm 2 ô trống nét đứt, mỗi ô có nút + ở giữa, nằm cạnh nhau

- Thêm Column → 2 ô trống nét đứt xếp dọc

- Bấm + trong một ô trống → thành phần lấp đúng ô đó, ô còn lại vẫn còn nguyên. Lỗi này vừa fix: nếu ô số 2 biến mất hoặc thành phần vừa thêm chiếm hết hàng thì report

- Bấm vào nền ô trống (không trúng nút +) → chọn container, không mở sheet

- Lấp nốt ô thứ 2 → Row/Column hiện đủ 2 thành phần, chia đôi; container đã đủ con thì không còn ô trống thừa

## Giới hạn lồng nhau và container rỗng

Tối đa 3 cấp container. Ví dụ hợp lệ: Column > Row > Column.

- Ở cấp thứ 3, mở sheet Add component → nhóm Layout biến mất, các nhóm khác vẫn còn

- Ở cấp 1–2, nhóm Layout vẫn hiện bình thường

- Thêm một container ngang hàng (sibling) ở cấp còn cho phép → vẫn được

- Thêm Row/Column rồi không lấp gì, bấm ✓ → container rỗng bị bỏ, toast "Removed the empty layout" kèm Undo

- Bấm Undo trên toast đó → container rỗng quay lại màn editor

## Bảng thuộc tính, Undo và lưu

- Position: chuyển Auto ↔ Fixed mà thành phần không tự nhảy chỗ

- Chọn Fixed → hiện thanh Vertical position, kéo thì thành phần chạy dọc theo

- Thanh Width kéo được, khớp với kéo góc ở mục trên

- Thanh Size chỉ có với thành phần ngoài cùng; thành phần nằm trong Row/Column thì không có (cố ý)

- Các knob riêng của từng loại (màu, phông, số dòng…) đổi được và ăn ngay

- Duplicate · Delete · Deselect chạy đúng

- Undo hoàn lại đúng một thao tác — một lần kéo là một bước, không phải từng frame của cú kéo đó; Redo làm lại được

- ✓ (Done) → quay lại màn editor, bố cục mới được giữ

- ✕ (Cancel) → mọi thay đổi trong phiên bị bỏ, kể cả thành phần vừa thêm

- Show grid bật/tắt lưới canh; lưới không được đè lên thao tác kéo

- Thành phần tràn ra ngoài màn → hiện cảnh báo "Part of this runs off the screen"; kéo về trong thì cảnh báo mất

- Nút ẩn/hiện chrome: ẩn hết nút để xem wallpaper sạch, chạm lại thì hiện lại

- Xoay iPad → khung viền và các ô trống vẫn khớp, không lệch

## Hành vi cố ý — không cần report


Bảy điểm dưới đây nhìn hệt lỗi với người lần đầu dùng màn này, nhưng đều là đánh đổi có chủ đích.

- 1. Trong lúc đang kéo, chữ trong thành phần không xuống dòng lại và chiều cao không đổi — nó chỉ co giãn theo hình. Nhả tay ra mới có một bước chỉnh lại cho đúng. Đây là đánh đổi để kéo được mượt.

- 2. Thẻ nền của container (Row/Column) không đổi theo từng frame khi đang kéo, chỉ các thành phần con đổi.

- 3. Row/Column chỉ có 1 con vẫn chiếm chỗ như đang có 2 con — vì ô trống thứ 2 vẫn giữ chỗ.

- 4. Thành phần bên trong Row/Column không có thanh Size — bề rộng của nó do container chia.

- 5. Không vẽ vòng tròn ở 4 góc — vùng kéo vẫn nằm ở góc, chỉ là không vẽ ra.

- 6. Chạm một lần vào thành phần trong container chỉ chọn container; phải chạm tiếp mới vào được con.

- 7. Template không phải dạng stack thì không có nút Components.

## Regression cần rà lại

Màn này ghi thẳng vào dữ liệu wallpaper, nên sau khi sửa bố cục phải kiểm tiếp ngoài màn editor.

- Đặt làm màn khoá thật → wallpaper render đúng bố cục vừa sửa, không phải chỉ đúng trên preview

- Live Activity của template đó vẫn chạy, không vỡ layout

- Widget và thumbnail trong "Your collection" cập nhật theo

- Mở lại template đã sửa → bố cục giữ nguyên, sửa tiếp được

- Các template lịch cũ (chưa động vào) render y như trước

- Wallpaper note (không phải lịch) không bị ảnh hưởng

## Cách report

Ghi kèm: máy + phiên bản iOS, tên template, bố cục đang dựng (ví dụ Column > Row(monthGrid, todayList) > quote), và video quay màn hình nếu là lỗi lúc kéo — lỗi
