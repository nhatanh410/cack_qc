# 14 — Edit Wallpaper (Decorate)

**Mục tiêu:** trang trí wallpaper (vẽ tay, chữ, emoji, ảnh/cắt nền) ngay trong màn chỉnh wallpaper, trước khi lưu thành lock screen thật.

**Nguồn:** 16 screenshot trong [`screenshots/iphone/14_edit-wallpaper/`](../screenshots/iphone/14_edit-wallpaper/) — build TestFlight **1.2.15 (56)**, PR [#185](https://github.com/sfunvn/lockscreen-calendar/pull/185), change note [qc-wallpaper-decoration.md](../../../specs/wallpaper-decoration/qc-wallpaper-decoration.md).

> ⚠️ Flow **mới hoàn toàn**, chưa từng có wireframe trước đó — khác các file khác trong bộ này vốn đã có ít nhất 1 phiên bản cũ để đối chiếu. Mọi mô tả dưới đây dựng lần đầu, hoàn toàn từ ảnh.
> Bộ ảnh **iPad** (15 ảnh, cả 2 chiều) cũng tồn tại ở [`screenshots/ipad/14_edit-wallpaper/`](../screenshots/ipad/14_edit-wallpaper/) nhưng theo đúng quy ước của thư mục này (nguồn chính là iPhone), wireframe chính dựng từ iPhone — khác biệt/bổ sung quan sát được từ iPad gom riêng ở mục cuối.

---

## Flow

```mermaid
flowchart TD
    E1[Flow 04 Discover<br/>chọn/tạo template] --> S1[S01 Wallpaper editor]
    S1 -->|nút Decorate| S2T[S02 Decorate<br/>tooltip · lần đầu]
    S2T -->|Got it| S2[S02 Decorate · default]
    S2 -->|toggle 📅| S2CAL[S02 · calendar-shown]
    S2 -->|chọn bút ✎| S2BR[S02 · brush-toolbar]
    S2 -->|chọn Aa| S2TXT[S02 · text-editing]
    S2 -->|chọn 🙂| S2EMJ[S02 · emoji-picker]
    S2 -->|chọn 🖼| S2PH[S02 · photo-menu]
    S2PH -->|Cutout| CUT[❓ UI chọn + tách nền ảnh<br/>chưa có ảnh]
    S2PH -->|Photo| PHO[❓ UI chọn ảnh thường<br/>chưa có ảnh]
    CUT -.-> S2SEL
    PHO -.-> S2SEL
    S2BR -.->|vẽ xong, chạm nét| SELDRAW[❓ chọn 1 nét đã vẽ<br/>chưa có ảnh]
    S2TXT -.->|nhập xong, chạm ra ngoài| S2SEL
    S2EMJ -.->|chạm emoji| S2SEL[S02 · sticker-selected<br/>3 loại: emoji · cutout · ảnh thường]
    S2SEL -->|✕ góc trên| DELD[❓ sau khi xoá<br/>chưa có ảnh]
    S2SEL -->|kéo handle góc dưới| RESZ[❓ giữa lúc resize/xoay<br/>chưa có ảnh]
    S2SEL -->|double-tap| S2SET[S02 · sticker-settings<br/>Opacity + Delete]
    S2SET -->|Delete| DELD
    S2 -->|✓ Save| S1F[S01 · filled<br/>preview đã áp decoration]
    S2 -->|✕ khi có thay đổi| DISC[S02 · discard-dialog]
    DISC -->|Discard| S1
    DISC -->|Keep editing| S2
```

---

## S01 — Wallpaper editor · 2 state

### `14_edit-wallpaper_01_wallpaper-editor_default.png`

```
┌────────────────────────────────────────┐
│           Balance                  ┌──┐│ ← tên template
│  ✕      Mix ✓ Current              │…│ │ ← menu thêm, góc phải
│                                     └──┘│
│         ┌──────────────────┐           │
│         │                  │           │
│         │  [ wallpaper     │           │
│         │    preview +     │           │
│         │    1 nét vẽ mảnh │           │ ← đã có sẵn 1 decoration từ trước
│         │    trên lịch ]   │           │
│         │                  │           │
│         └──────────────────┘           │
│  ┌──────────┐                  ┌────┐  │
│  │✎ Decorate│                  │ ⛶ │  │ ← pill trái: vào Decorate
│  └──────────┘                  └────┘  │ ← icon phải: crop
│                                        │
│ ┌──────────┬──────────┬─────────────┐ │
│ │Background│ Calendar │    Style    │ │ ← 3 tab, Background đang chọn
│ └──────────┴──────────┴─────────────┘ │
│                                        │
│ Change daily                    (○──) │ ← toggle tắt
│ One photo from your set each day      │
│                                        │
│ Auto contrast                   (──●) │ ← toggle bật
│ Adapts colors to the photo behind them│
│                                        │
│ Intensity                              │
│ ●━━━━━━━━━━━━━━━○──────────────────── │ ← slider ~45%
│                                        │
│ ┌────────────────────────────────────┐│
│ │              Update                ││ ← CTA đen
│ └────────────────────────────────────┘│
└────────────────────────────────────────┘
```

**Đây là màn hình có sẵn từ trước**, không phải mới build — chỉ có **pill "Decorate"** ở góc dưới trái là bổ sung mới của build này (đường vào duy nhất tới S02).

### `14_edit-wallpaper_01_wallpaper-editor_filled.png`

```
┌────────────────────────────────────────┐
│           Balance                  ┌──┐│
│  ✕      Mix ✓ Current              │…│ │
│                                     └──┘│
│         ┌──────────────────┐           │
│         │  🤫  [heart nét   │           │
│         │       vẽ]         │           │
│         │  [cutout người]   │           │
│         │  [ảnh thường]     │           │
│         │  đè lên lịch      │           │ ← toàn bộ decoration đã lưu
│         └──────────────────┘           │
│  ┌──────────┐                  ┌────┐  │
│  │✎ Decorate│                  │ ⛶ │  │
│  └──────────┘                  └────┘  │
│                                        │
│ Darken                                 │ ← ⚠️ khác ảnh default — xem ghi chú
│ ●━━━━━━━━━━○───────────────────────── │
│                                        │
│ Change daily                    (○──) │
│ Auto contrast                   (──●) │
│ Intensity  (bị cắt dưới khung ảnh)     │
│ ┌────────────────────────────────────┐│
│ │              Update                ││
│ └────────────────────────────────────┘│
└────────────────────────────────────────┘
```

**Xác nhận trực tiếp giá trị cốt lõi của cả tính năng:** wallpaper preview ở đây **khớp đúng** với những gì đã trang trí trong S02 (mục 2.5 của change note) — emoji, cutout, ảnh, nét vẽ đều lưu lại đúng vị trí.

> ⚠️ **Khác biệt cần xác nhận:** ảnh này có thêm control **"Darken"** ở đầu panel mà ảnh `default` không thấy (ảnh `default` bắt đầu ngay từ tab Background/Calendar/Style). Có thể do 2 ảnh cuộn ở vị trí khác nhau trong cùng 1 panel dài (Darken nằm phía trên tab, đã cuộn qua ở ảnh kia), không chắc là 2 trạng thái khác nhau thật sự — cần xác nhận, không suy diễn là bug hay tính năng ẩn/hiện có điều kiện.

---

## S02 — Decorate canvas · 10 state có ảnh

Toolbar dọc bên phải xuất hiện xuyên suốt mọi state (trừ lúc đang vẽ, xem ghi chú `drawing`): 6 icon xếp dọc — **grid** (chưa rõ chức năng, xem *Possible missing screen*) · **lịch** (toggle Show calendar) · **bút** (Draw) · **Aa** (Text) · **mặt cười** (Emoji) · **ảnh** (Photo/Cutout).

### `14_edit-wallpaper_02_decorate_tooltip.png` — lần đầu mở

```
┌────────────────────────────────────────┐
│ ┌──┐        ┌──┐  ┌──┐            ┌──┐ │
│ │✕ │        │↶│  │↷│            │✓│ │ ← header: đóng · undo · redo · lưu
│ └──┘        └──┘  └──┘            └──┘ │
│         Saturday, 12 September          │
│               13:26                     │ ← lock screen preview mờ phía sau
│  ┌──────────────────────────┐    ┌──┐  │
│  │                          │    │▦│  │ ← toolbar mờ nhạt, chỉ icon bút
│  │                          │    ├──┤  │   sáng rõ + có tay chạm minh hoạ
│  │      Your toolbar        │    │✎│◄┼─ đang trỏ vào
│  │  Text, emoji, photos     │    ├──┤  │
│  │   and a pen. The top     │    │Aa│  │
│  │  two switches preview    │    ├──┤  │
│  │  the clock and calendar. │    │🙂│  │
│  │                          │    ├──┤  │
│  │      ┌────────┐         │    │🖼│  │
│  │      │ Got it │         │    └──┘  │
│  │      └────────┘         │           │
│  └──────────────────────────┘           │
└────────────────────────────────────────┘
```

**Coach mark chỉ xuất hiện đúng 1 lần** (lần đầu mở Decorate) — không thấy trong bất kỳ ảnh nào khác của bộ. Đây là **cơ hội duy nhất** người dùng học ý nghĩa 6 icon toolbar; các icon **không có label chữ** ở mọi state khác.

### `14_edit-wallpaper_02_decorate_default.png`

```
┌────────────────────────────────────────┐
│ ✕          ↶   ↷              ✓        │
│         Saturday, 12 September          │
│               13:26                     │
│ ┌────────────────────────────┐   ┌──┐  │
│ │                            │   │▦│  │
│ │   [ canvas trống, chỉ có   │   ├──┤  │
│ │     lưới safe-zone mờ ]    │   │📅│  │
│ │                            │   ├──┤  │
│ │                            │   │✎│  │
│ │                            │   ├──┤  │
│ │                            │   │Aa│  │
│ │                            │   ├──┤  │
│ │                            │   │🙂│  │
│ │                            │   ├──┤  │
│ │                            │   │🖼│  │
│ └────────────────────────────┘   └──┘  │
│  🔦                              📷    │ ← đèn pin · camera của lock screen thật
└────────────────────────────────────────┘
```

### `14_edit-wallpaper_02_decorate_calendar-shown.png`

Giống `default`, icon **📅** đang bật (nền đậm hơn) → canvas hiện thêm panel lịch tuần + heatmap tháng, đúng nội dung sẽ lên lock screen thật khi áp dụng template lịch.

### `14_edit-wallpaper_02_decorate_brush-toolbar.png` *(+ `-v2`, gần như giống hệt)*

```
┌────────────────────────────────────────┐
│ ✕          ↶   ↷              ✓        │
│  [ canvas: đang kéo thanh trượt cỡ nét, │
│    thấy hình dấu ! trắng đang vẽ dở ]   │
│                                    ┌──┐ │
│                                    │▦│ │
│                                    ├──┤ │
│                                    │📅│ │
│                                    └──┘ │
│ 💧 ⚪ ⚪ ⚫ ⚫ ⚫ 🟡 🟠 🔴 🩷           │ ← eyedropper + palette màu
│┌──┬────┬────┬────┬──┬──────────────┐  │
││𝒜 │ 🖌 │ ✏ │ ▢ │  │  ⌫            │✓│ ← 4 loại nét + | + eraser + save
│└──┴────┴────┴────┴──┴──────────────┘  │
└────────────────────────────────────────┘
```

**4 icon loại nét không có label** — thứ tự quan sát được: `𝒜` (chữ ký hoa, có lẽ = Pen) · brush = Marker · bút chì = Highlighter · ô vuông nét đứt = Dotted. **Suy luận theo thứ tự liệt kê trong change note (Pen · Marker · Highlighter · Dotted)**, chưa có cách nào xác nhận chắc chắn từ ảnh tĩnh vì 4 icon khá giống nhau.

### `14_edit-wallpaper_02_decorate_text-editing.png`

```
┌────────────────────────────────────────┐
│ ✕                                       │
│         Saturday, 12 September          │
│               13:27                     │
│ ┌────────────────────────────┐         │
│ │      Type something        │         │ ← placeholder, con trỏ nhấp nháy
│ └────────────────────────────┘         │
│ ⚪ Aa ☰ B AA ◐                    ✓    │ ← màu · font · canh lề · đậm · cỡ · tương phản
│ [ bàn phím QWERTY tiếng Anh ]          │
└────────────────────────────────────────┘
```

Header rút gọn còn mỗi nút ✕ khi đang gõ — undo/redo/toolbar bên phải **biến mất** trong lúc này (khác `drawing`, xem ghi chú iPad cuối file).

### `14_edit-wallpaper_02_decorate_emoji-picker.png`

Bottom-sheet kéo lên, tiêu đề **"Emoji · Smileys"**, lưới emoji 9 cột, thanh 7 tab nhóm ở đáy sheet (khớp đúng 7 nhóm change note liệt kê: Smileys · Hearts · Animals · Nature · Food · Travel · Objects — quan sát được icon nhưng **không thấy tên nhóm dịch tiếng Việt trong ảnh này**, máy đang để tiếng Anh).

### `14_edit-wallpaper_02_decorate_photo-menu.png`

Popup nhỏ nổi cạnh toolbar, 2 dòng: **"Cutout"** (icon người chấm nền) và **"Photo"** (icon khung ảnh). Bấm xong → **chưa có ảnh** cho bước chọn ảnh từ thư viện tiếp theo (xem *Possible missing screen*).

### `14_edit-wallpaper_02_decorate_sticker-selected.png` · 3 biến thể

```
┌────────────────────────────────────────┐
│ ✕          ↶   ↷              ✓        │
│         Saturday, 12 September          │
│               13:28                     │
│ ┌──────┐                          ┌──┐ │
│ │ 😗   │✕                        │▦│ │ ← ✕ xoá, góc trên phải khung chọn
│ │(emoji)│                        ├──┤ │
│ └──────┘                          │📅│ │
│           ⤡                       └──┘ │ ← handle resize+xoay, góc dưới phải
└────────────────────────────────────────┘
```

- **`sticker-selected.png`** — sticker **emoji** 😗 đang chọn, kèm 1 nét vẽ trái tim đã có sẵn trên canvas.
- **`sticker-selected-v2.png`** — cùng bố cục, nhưng sticker đang chọn là **ảnh cutout** (đã tách nền, chỉ còn hình người) thay vì emoji.
- **`sticker-selected-v3.png`** — cùng bố cục, sticker đang chọn là **ảnh thường** (còn nguyên khung chữ nhật, không cắt nền) — trên canvas lúc này đã có đủ cả 4 loại: emoji, nét vẽ, cutout, ảnh thường xếp chồng.

**Cả 3 biến thể dùng chung 1 kiểu khung chọn** (viền màu, ✕ góc trên phải, handle góc dưới phải) bất kể loại sticker — nhất quán tốt.

> ⚠️ **Kích thước tap target:** ước lượng bằng mắt trên ảnh, nút ✕ và handle đều khá nhỏ so với ngón tay thật — cần đo trực tiếp trên máy thật để xác nhận có đạt chuẩn 44×44pt hay không, ảnh tĩnh không đo chính xác được.

> **Đối chiếu Instagram Stories editor** (cùng thể loại: sticker đè lên khung ảnh cố định): Instagram cho pinch/xoay **tự do ở bất kỳ đâu trên sticker**, không cần trúng 1 handle, và không hiện khung/handle rõ như Ink. Khung viền + handle rõ ràng của Ink **dễ nhận biết hơn cho người mới** (điểm cộng), nhưng nếu Ink lại **bắt buộc** phải chạm đúng handle nhỏ mới scale/xoay được (khác Instagram cho phép pinch tự do) thì tap target nhỏ ở trên trở thành vấn đề nghiêm trọng hơn — chưa xác nhận được từ ảnh tĩnh, xem exploratory checklist `DEC-H28b`/`DEC-Q11`. Instagram cũng có affordance kéo-thả-vào-thùng-rác để xoá (không chỉ nút ✕) — Ink chưa thấy bằng chứng có tương tự, xem `DEC-H33b`.

### `14_edit-wallpaper_02_decorate_sticker-settings.png` · 2 biến thể

```
┌────────────────────────────────────────┐
│ ✕          ↶   ↷              ✓        │
│ [ canvas: sticker đang chọn (khung xanh│
│   + ✕), các sticker khác + nét vẽ ]    │
│┌────────────────────────────────────┐  │
││              ▔▔                    │  │ ← grabber
││              Emoji                 │  │ ← tiêu đề — đổi theo loại sticker
││                                    │  │
││ Opacity                            │  │
││ ●━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━○│  │ ← slider, đang ở 100%
││                                    │  │
││ ┌────────────────────────────────┐ │  │
││ │             Delete             │ │  │ ← chữ đỏ, nền xám nhạt — nút phụ chuẩn
││ └────────────────────────────────┘ │  │
│└────────────────────────────────────┘  │
└────────────────────────────────────────┘
```

- **`sticker-settings.png`** — tiêu đề sheet **"Emoji"** khi sticker đang chọn là emoji.
- **`sticker-settings-v2.png`** — cùng sheet, tiêu đề đổi thành **"Photo"** khi sticker đang chọn là ảnh — xác nhận **tiêu đề sheet đổi theo loại sticker đang chọn** (chưa có ảnh nào cho biến thể "Text").

**Cách mở sheet này: double-tap** trực tiếp vào sticker/ảnh (1 gesture nhấn đúp, không phải chạm 1 lần chọn rồi chạm rời rạc lần 2 như câu chữ change note "chạm lần 2" có thể gây hiểu lầm — xác nhận từ QA 2026-09-12).

> ✅ Nút **Delete** ở đây dùng đúng pattern chuẩn iOS cho hành động phá huỷ (chữ đỏ, nền nhạt, không nổi bật quá mức) — **khác hẳn** nút **Discard** ở popup kế tiếp (nền tối, chiếm vị trí chính). Cùng 1 tính năng nhưng 2 dialog xử lý hành động phá huỷ theo 2 pattern khác nhau — đáng để hỏi dev/design có phải chủ ý hay chỉ 2 người làm rời nhau không rà lại.

### `14_edit-wallpaper_02_decorate_discard-dialog.png`

```
┌────────────────────────────────────────┐
│ ✕          ↶   ↷              ✓        │
│         Saturday, 12 September          │
│               14:18                     │
│  [ canvas: nét vẽ nguệch ngoạc trắng +  │
│    đỏ, sticker emoji 😇 đè lên giữa ]   │
│┌────────────────────────────────────┐  │
││              ▔▔                    │  │ ← grabber
││          Discard changes?          │  │ ← tiêu đề
││   Your decorations won't be saved. │  │ ← subtitle
││                                    │  │
││ ┌────────────────────────────────┐ │  │
││ │            Discard             │ │  │ ← nút TỐI MÀU, nổi bật nhất
││ └────────────────────────────────┘ │  │
││ ┌────────────────────────────────┐ │  │
││ │          Keep editing          │ │  │ ← nút viền, phụ
││ └────────────────────────────────┘ │  │
│└────────────────────────────────────┘  │
└────────────────────────────────────────┘
```

> ⚠️ **Quan sát UX đáng chú ý:** nút **"Discard" (hành động phá huỷ, mất dữ liệu) được style là nút chính** —
> nền tối, chiếm vị trí trên cùng — trong khi **"Keep editing" (hành động an toàn) lại là nút phụ dạng viền**.
> Đây là **ngược** với khuyến nghị phổ biến cho dialog xác nhận huỷ (thường đặt hành động an toàn/mặc định làm
> nút nổi bật hơn, hành động phá huỷ làm nút phụ hoặc tô màu cảnh báo) — tăng khả năng bấm nhầm Discard theo
> phản xạ "nút đậm màu = nút nên bấm". Cần xác nhận đây có phải chủ ý thiết kế hay chưa được rà theo pattern
> chuẩn của app (so sánh với các dialog xác nhận khác trong app, nếu có).

---

## Tổng kết flow

| # | Màn hình | State có ảnh |
|---|----------|--------------|
| S01 | Wallpaper editor | default · filled |
| S02 | Decorate canvas | tooltip · default · calendar-shown · brush-toolbar (+v2) · text-editing · emoji-picker · photo-menu · sticker-selected (+v2, +v3) · sticker-settings (+v2) · discard-dialog |

**Vấn đề đã nhận diện**

Không có mục nào đủ bằng chứng để khẳng định là **lỗi (🔴)** — mọi quan sát bất thường ở trên đều dừng ở mức ⚠️ cần xác nhận, vì đây là build mới hoàn toàn và các note nguồn (`qc-wallpaper-decoration.md`) tự liệt kê phần lớn rủi ro dưới dạng "cần test", không phải "đã biết là sai".

**Possible missing screen**

- Chức năng của icon **▦ (grid)** đầu toolbar — xuất hiện xuyên suốt nhưng không thấy trạng thái nào cho biết nó dùng để làm gì (không khớp trực tiếp với mô tả "Toggle Lock screen" trong change note — cần xác nhận).
- UI chọn ảnh từ thư viện sau khi bấm **Cutout** hoặc **Photo** ở menu (chỉ có ảnh menu, chưa có ảnh bước kế tiếp).
- Trạng thái **giữa lúc** resize/xoay sticker (chỉ có ảnh trước và sau, không có ảnh đang kéo).
- Trạng thái **sau khi xoá** sticker (chỉ có ảnh trước khi xoá).
- **Eyedropper đang hút màu** — change note mục 2.2 mô tả nhưng không có ảnh.
- **Thông báo hết chỗ vẽ** (>50 nét, R6 trong change note) — không có ảnh.
- **Zoom/pan cấp canvas** (phóng to/cuộn cả bức tranh, khác pinch/kéo trên 1 sticker) — change note mục 2.2/2.3 chỉ mô tả pinch/kéo **trên sticker**, không nhắc gì tới thao tác ở cấp canvas. Không có ảnh nào cho thấy canvas zoom được. *(Instagram Stories — cùng thể loại khung cố định — cũng không có zoom/pan canvas, nên nhiều khả năng đây là đúng convention chứ không phải thiếu sót; vẫn cần xác nhận bằng lời, không mặc định.)*

> ✅ Không cần chụp **Dark Mode** — xác nhận 2026-09-12: app hiện **chưa hỗ trợ Dark Mode**, không phải gap.

---

## Ghi chú bổ sung từ bộ ảnh iPad

Bộ [`screenshots/ipad/14_edit-wallpaper/`](../screenshots/ipad/14_edit-wallpaper/) (15 ảnh, cả 2 chiều) không phải nguồn chính của wireframe này nhưng có vài quan sát đáng ghi lại vì **lấp được đúng chỗ trống ở trên**:

- **`filled` / `filled-landscape`** (không có sticker nào đang chọn) — cho thấy canvas ở trạng thái nghỉ sau khi trang trí xong, cả 2 chiều xoay. Vị trí sticker giữ nguyên khi xoay ngang.
- **`text-collapsed`** — cùng tool Text nhưng bàn phím đã tắt (chạm ra ngoài), thanh format vẫn còn hiện — trạng thái trung gian mà bộ iPhone chưa chụp.
- **`drawing`** (chỉ có ở iPad) — ⚠️ cho thấy **toàn bộ header (✕/↶/↷/✓) và toolbar biến mất hoàn toàn** trong lúc đang kéo nét vẽ, không chỉ ẩn brush bar. Chưa xác nhận đây là ẩn tạm chủ ý (hiện lại khi buông tay) hay là dấu hiệu của bug đã biết (toolbar kẹt cứng sau thao tác resize, ghi trong change note) — **cần verify trên máy thật trước tiên**, xem [test plan mục 11](../../../test-plans/decoration-inkai/1.2.15-decoration-inkai.md).
- **Emoji picker trên iPad landscape** không giãn theo chiều ngang — giữ nguyên bề rộng như bản portrait, nổi giữa màn hình rộng, hai bên trống trải.
- iPad **không có** state `tooltip`, `sticker-selected`, `sticker-settings`, hay `discard-dialog` trong bộ đã chụp — chưa rõ hành vi coach-mark, sheet cài đặt sticker, và popup Discard trên iPad có giống iPhone không (chưa chụp, không suy diễn).
