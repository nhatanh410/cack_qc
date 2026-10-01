# PRD: Wallpaper Component Editor

**Document Version:** 1.0
**Status:** Draft — chặn bởi §11 (Open Questions)
**Product:** Ink (iOS / LockScreen Calendar)
**Màn hình gốc:** [`TemplateEditorScreen.swift`](../ios/Ink/UI/Wallpaper/TemplateEditorScreen.swift)
**Wireframe:** [`wallpaper-component-editor-wireframe.html`](wallpaper-component-editor-wireframe.html)
**Viết cho:** AI agent triển khai + người review sản phẩm

---

## 1. Tóm tắt & định vị

### 1.1. Vấn đề

Editor wallpaper hiện tại cho user đúng **~15 control**, toàn bộ là **global** (áp cho cả
wallpaper) hoặc **theo loại band** (áp cho "cái quote band", "cái month band") — xem
`CalendarTemplateEditorPanel.Tab` ([CalendarTemplateEditorPanel.swift:65](../ios/Ink/UI/Wallpaper/CalendarTemplateEditorPanel.swift#L65)).
Không có control nào nhắm vào **một thành phần cụ thể mà user đang nhìn**.

Trong khi đó renderer đã đọc được, cho **từng khối chữ của từng band**: font, size, color,
bold, italic, align, valign, rotate (`TextStyleDTO`); và cho từng band: container
(card/màu/bo góc/inset), cộng knob riêng của 16 loại part. Knob đi qua dạng
`[String: JSONValue]` không định kiểu ([CalendarStackComponent.swift:33](../ios/Ink/Domain/CalendarTemplate/CalendarStackComponent.swift#L33)),
nên renderer **nhận bất kỳ key nào** mà không cần sửa model, DTO hay encoder.

> **Kết luận định hướng: đây không phải bài toán renderer, mà là bài toán UI editor.**
> Năng lực đã nằm sẵn dưới pipeline; thứ thiếu là (a) một cách để user **chỉ vào** một
> thành phần, và (b) một cách để UI **tự sinh** control cho thành phần đó thay vì viết tay.

### 1.2. Số liệu nền

Đo ngày 2026-09-14 trên [`CalendarWallpaperTemplates.json`](../ios/Ink/Resources/CalendarWallpaperTemplates.json)
(bundle mặc định, chưa tính Remote Config override):

| Chỉ số | Giá trị | Hệ quả thiết kế |
|---|---|---|
| Template dùng `layout: stack` | **19/19 (100%)** | Không cần migration từ layout cũ. Tính năng phủ mọi template đang ship. |
| Số band mỗi template | **1–3** (median 2) | **Không làm layers list.** Chọn bằng chạm là đủ; 2 band không có gì để "quản lý". |
| Tổng band instance | 38 | |
| Knob key distinct toàn hệ | **22** | Bề mặt inspector nhỏ hơn nhiều so với cảm giác ban đầu (16 part × N knob). |
| `container` xuất hiện ở | **13/38 band** | Spec dùng chung gánh phần lớn công việc, không phải 16 spec viết tay. |
| Knob key distinct / part | 1–6 | |
| `is_pro: true` trong bundle | **0** | Gate Pro theo part là cơ chế **mới**, chưa có tiền lệ trong catalog → §11. |

Phân bố part type (38 instance): `quote` 5 · `todayList` 4 · `monthGrid` 4 ·
`contributionGrid` 4 · `weekEvents` 3 · `hourTimeline` 3 · `miniMonth` 3 ·
`yearProgress` 2 · `countdown` 2 · `reminderList` 2 · và 6 loại còn lại mỗi loại 1.

> **Vì sao KHÔNG rollout spec từng phần:** làm spec cho top-4 part phủ 74% band nhưng chỉ
> **11% template được phủ trọn vẹn**. Nghĩa là phần lớn template sẽ có band này sửa được,
> band kia không — user đọc ra đó là lỗi, không phải lộ trình. Cùng tổng chi phí, làm đủ
> 16 part một lượt cho 100% phủ là lựa chọn đúng.

### 1.3. Bốn nguyên tắc bất biến

**NT-1 — Không biến canvas thành mặt phẳng 2D tự do.**
`CalendarStackComponent` cố tình 1D: `y` (neo tuyệt đối) **hoặc** `gap` (trôi sau band
trước), cộng `inset` (bề rộng) và `offsetX` (nhích ngang). Không có width/height/rotation/
z-order, và comment đầu file nói rõ lý do: phần lớn part **tự đo chiều cao theo dữ liệu
user**, nên fixed height buộc mỗi part phải tự bịa chính sách giấu overflow
([CalendarStackComponent.swift:3-13](../ios/Ink/Domain/CalendarTemplate/CalendarStackComponent.swift#L3-L13)).
Thêm width/height là phá hợp đồng đó, phá parity với `ink-template-studio`, và phá 39
golden test. **Thay vào đó: làm 4 trục sẵn có thành thao tác trực tiếp, cộng đúng một
trục mới (`scale`).**

**NT-2 — Preview vẫn là bitmap.**
Không dựng lại wallpaper bằng SwiftUI view. Renderer vẽ thẳng vào `CGContext`
([StackWallpaperRenderer.swift:45](../ios/Ink/Core/Wallpaper/StackWallpaperRenderer.swift#L45));
dựng lại bằng view là viết lại toàn bộ 16 part, mất pixel parity với ảnh wallpaper thật và
với Studio. Cơ chế chọn/chạm là **hit-test hình chữ nhật phủ lên ảnh**, không phải view
hierarchy.

**NT-3 — Không làm user ngợp.**
Đây là ràng buộc sản phẩm cứng, không phải lời khuyên. Cụ thể hoá thành luật ở §5.5.

**NT-4 — Không đổi một pixel nào của golden hiện có.**
Mọi field/knob mới phải có mặc định = hành vi hiện tại (`scale` vắng mặt ⇒ 1.0 ⇒ no-op).
AC bắt buộc: sau toàn bộ 7 tính năng, **0 golden test cũ phải regenerate**.

---

## 2. Phạm vi

### 2.1. Trong phạm vi — 7 tính năng

| # | Tính năng | RICE | Đợt |
|---|---|---:|---|
| 1 | Phóng to / thu nhỏ từng thành phần | 112 | 1 |
| 2 | Chạm vào preview để chọn thành phần, chỉnh vị trí & bề rộng | 77 | 1 |
| 3 | Sửa chữ, màu, khung nền và nội dung của mọi thành phần | 72 | 2 |
| 4 | Hoàn tác / làm lại từng bước | 50 | 2 |
| 5 | Khoá một số thành phần cho bản Pro | 30 | 3 |
| 6 | Thêm thành phần mới, xoá và nhân bản | 27 | 3 |
| 7 | Kéo thả thành phần trực tiếp trên preview | 20 | 3 |

Tổng effort ước tính: **14.5 person-week**.

### 2.2. Ngoài phạm vi (và lý do)

| Không làm | Lý do |
|---|---|
| Width/height/rotation/z-order cho band | NT-1 |
| Danh sách layers để sắp xếp thứ tự | Median 2 band/template — không có gì để quản lý. Xem lại **sau** khi #6 chạy và có số liệu user tạo ≥5 band. |
| Chuyển template `layout` cũ sang `stack` | 19/19 đã là `stack`. |
| Dựng lại preview bằng SwiftUI view | NT-2 |
| Đổi thứ tự band bằng kéo thả | Kéo dọc đã có nghĩa khác (`gap`). Nếu cần, làm bằng menu ⋯ "Move up / Move down". |
| Sửa trực tiếp trên `WallpaperDecorEditorScreen` | Trình trang trí là layer **riêng**, không phải band. Giữ nguyên. |

---

## 3. Từ vựng

| Từ dùng với user (VI) | Từ dùng với user (EN) | Trong code |
|---|---|---|
| Thành phần | Component | `CalendarStackComponent`, một "band" |
| Vị trí **Tự động** | **Automatic** | `gap` — band trôi sau band phía trên |
| Vị trí **Cố định** | **Fixed** | `y` — band neo tuyệt đối theo % chiều cao canvas |
| Bề rộng | Width | `inset` (px cắt đều hai bên) |
| Lệch ngang | Nudge | `offset_x` |
| Cỡ | Size | `scale` — **knob mới**, §6.4 |

> **Bắt buộc:** không bao giờ hiện chữ `y`, `gap`, `inset`, `offset_x`, `knob`, `band`,
> `part` lên UI. Đó là từ vựng wire, không phải từ vựng sản phẩm.

---

## 4. Core user flows

### Flow A — Chọn một thành phần rồi sửa (tính năng #1, #2, #3)

```
Editor mở (chưa chọn gì)  → panel = 4 tab global như hiện tại
  │
  └─ user chạm vào "lịch tháng" trên preview
        → viền chọn quanh lịch tháng + chip tên "Month grid"
        → panel MORPH thành inspector của thành phần đó
        → inspector mở ở nhóm khả dụng đầu tiên (thứ tự cố định: Nội dung → Chữ → Nền → Vị trí)
        │
        ├─ user đổi font/màu/cỡ chữ           → render lại (debounce 300ms) → preview đổi
        ├─ user kéo slider "Cỡ"               → scale
        ├─ user kéo slider "Bề rộng"          → inset
        └─ user chạm vùng trống trên preview  → bỏ chọn → panel về 4 tab global
```

### Flow B — Thêm thành phần (tính năng #6)

```
user chạm "+" trên thanh công cụ canvas
  → sheet "Add to your wallpaper" — 16 loại chia 5 NHÓM (§5.6)
  → chọn một loại
       ├─ loại khoá Pro & user chưa Pro → paywall (source "wallpaper_add_component")
       └─ ngược lại
             → chèn NGAY SAU thành phần đang chọn (hoặc cuối nếu không chọn gì)
             → tự động chọn nó + mở inspector
             → toast "Added Month grid" kèm nút UNDO
```

### Flow C — Kéo thả trực tiếp (tính năng #7)

```
user đặt ngón lên một thành phần đã chọn
  → chrome editor mờ đi (chỉ còn canvas)     [tái dùng WorkingTheCanvas của decor editor]
  → KÉO: vẽ ảnh proxy (crop pixel của band) theo ngón, KHÔNG render lại
       ├─ kéo dọc  → thay đổi "Vị trí"  — badge sống hiện giá trị
       └─ kéo ngang → thay đổi "Lệch ngang" — snap về giữa, có vạch dẫn + haptic
  → PINCH: scale, cũng bằng proxy
  → THẢ TAY
       → ghi giá trị thật → render MỘT lần → chrome hiện lại
       → ghi ĐÚNG MỘT bước undo cho cả cử chỉ
```

### Flow D — Hoàn tác (tính năng #4)

```
Mọi thao tác ghi một bước undo tại ranh giới COMMIT, không phải mỗi tick:
  · thả tay khỏi slider (không phải mỗi lần giá trị đổi)
  · kết thúc một cử chỉ kéo/pinch
  · thêm / xoá / nhân bản thành phần
  · đổi Tự động ↔ Cố định
KHÔNG ghi bước undo khi: chỉ chạm để chọn, đổi nhóm inspector, đóng/mở panel.
```

---

## 5. UI/UX Spec

### 5.1. Bố cục — giữ nguyên shell, chỉ đổi panel

Shell hiện tại **không đổi**: `topBar / [rail nền | canvas] / panel(30% chiều cao) / confirmBar`
([TemplateEditorScreen.swift:129-149](../ios/Ink/UI/Wallpaper/TemplateEditorScreen.swift#L129-L149)).

| Vùng | Đổi gì |
|---|---|
| `topBar` | Thêm **undo / redo** vào giữa, qua `InkScreenHeader.controls(leading:center:trailing:)`, style `.bare`. Design system ghi rõ đây đúng là chỗ decor editor đã dùng cho undo/redo. |
| canvas | Chạm = **chọn thành phần** (không còn toggle panel). Vẽ viền chọn + chip tên. |
| thanh công cụ canvas | Thêm **`+`** (thêm thành phần) và **nút ẩn/hiện panel** (thay cho cử chỉ chạm đã bị lấy mất). Giữ Decorate + Reframe. |
| `panel` | **Hai chế độ**: *Global* (4 tab như hiện tại) khi không chọn gì · *Inspector* khi đang chọn một thành phần. |
| `confirmBar` | Không đổi. |

> **BẮT BUỘC — cử chỉ chạm canvas đang bị chiếm chỗ.** Hiện `onTapGesture` trên canvas
> toggle ẩn/hiện panel ([TemplateEditorScreen.swift:277](../ios/Ink/UI/Wallpaper/TemplateEditorScreen.swift#L277)).
> Chạm giờ là cử chỉ **chọn**, nên không được overload. Hành vi ẩn panel phải chuyển sang
> **một nút riêng** trên thanh công cụ canvas. Không dùng double-tap (không ai đi tìm), không
> dùng long-press.

### 5.2. Trạng thái chọn

| Yếu tố | Spec |
|---|---|
| Viền | `InkColors.accentSelection`, 2pt, bao đúng rect của thành phần. Token này định nghĩa sẵn là "selection chrome on a canvas object being edited". |
| Nhãn | Chip nhỏ ở cạnh trên viền, ghi tên thành phần ("Month grid"). Dùng `AppBadge` — nó **được đọc**, không bấm được. |
| Bỏ chọn | Chạm vùng canvas không thuộc thành phần nào. |
| Thành phần chồng nhau | Chạm lấy thành phần **trên cùng** (index lớn nhất) chứa điểm chạm. Chạm lại đúng chỗ đó → luân phiên xuống thành phần phía dưới. |
| Rect quá nhỏ | Rect < 44pt theo chiều nào thì **nới hit area** ra 44pt (không nới viền vẽ). |
| Sau khi render lại | Giữ nguyên lựa chọn theo **`id`**, không theo index — xoá/thêm làm index trượt. |

### 5.3. Inspector — 4 nhóm, không hơn

`InkSegmentedTabs` với tối đa 4 nhóm. **Chỉ hiện nhóm mà thành phần đó thực sự có.**

| Nhóm | Nội dung | Ví dụ |
|---|---|---|
| **Nội dung** | Knob riêng của loại part | Quote: danh sách câu · Countdown: ngày đích · TodayList: số dòng tối đa · MonthGrid: hiện event chip |
| **Chữ** | `TextStyleDTO` của từng khối chữ trong band | Font · Cỡ chữ · Màu · Đậm/nghiêng · Căn lề |
| **Nền** | `ContainerDTO` | Bật/tắt khung · Màu nền · Bo góc · Đệm trong |
| **Vị trí** | Trục hình học | Vị trí (Tự động/Cố định) · Bề rộng · Lệch ngang · **Cỡ** |

Header của inspector: `[← Back]  Tên thành phần  [⋯]`
— `←` bỏ chọn về Global · `⋯` = Duplicate / Delete (chỉ khi #6 đã ship).

### 5.4. "Vị trí: Tự động / Cố định" — điểm khó nhất

`y` và `gap` loại trừ nhau và user không có khái niệm đó. Phơi ra thành một
`InkSegmentedTabs` hai lựa chọn:

| Lựa chọn | Nghĩa với user | Control đi kèm | Code |
|---|---|---|---|
| **Tự động** (mặc định) | "Nằm ngay dưới thành phần phía trên" | slider *Khoảng cách phía trên* | `gap`, `y = nil` |
| **Cố định** | "Ghim ở một chỗ cố định trên màn" | slider *Vị trí dọc* | `y`, `gap = nil` |

> **AC cứng: đổi qua lại KHÔNG được làm thành phần nhảy.**
> Tự động → Cố định: seed `y` = vị trí **đang đo được** của band (từ band frame, §6.1).
> Cố định → Tự động: seed `gap` = khoảng cách thực tế giữa nó và band phía trên (clamp ≥ 0).
> Đây là cái biến tính năng này từ "khó hiểu" thành "hiển nhiên" — làm sai là hỏng cả nhóm.

Thành phần **đầu tiên** trong stack không có "phía trên" để trôi theo → ẩn lựa chọn Tự
động, luôn là Cố định (hoặc hiện Tự động nhưng nhãn là "Theo canh lề của template").

### 5.5. Luật chống ngợp (cụ thể hoá NT-3)

| Luật | Chi tiết |
|---|---|
| **L1** | Inspector tối đa **4 nhóm**, mỗi nhóm tối đa **6 control** nhìn thấy ngay. |
| **L2** | Knob còn lại nằm sau một dòng mở rộng **"More options"** (`CollapsibleSectionCard`), mặc định đóng. Mỗi `InkKnobSpec` tự khai `isAdvanced`. |
| **L3** | **Không hiện nhóm rỗng.** Part không có container thì không có nhóm "Nền" — không hiện nhóm xám. |
| **L4** | Inspector luôn mở ở **nhóm khả dụng đầu tiên theo thứ tự cố định** (Nội dung → Chữ → Nền → Vị trí). Dễ đoán hơn là nhớ nhóm vừa dùng. |
| **L5** | Bảng thêm thành phần **chia nhóm**, không phải lưới phẳng 16 ô (§5.6). |
| **L6** | Trên canvas chỉ có **hai** cử chỉ: **kéo = di chuyển**, **pinch = đổi cỡ**. Bề rộng, lệch ngang tinh chỉnh… chỉ nằm trong inspector. Thêm cử chỉ thứ ba là bắt đầu ngợp. |
| **L7** | Mọi slider phải có **giá trị hiện số** khi đang kéo, và nút **Reset về mặc định** khi giá trị ≠ mặc định. |

### 5.6. Bảng thêm thành phần — 5 nhóm

Sheet `InkPopupScaffold(size: .medium)`. Mỗi ô: icon + tên + một dòng mô tả + thumbnail nhỏ.

| Nhóm | Part types |
|---|---|
| **Lịch** | `monthGrid` · `miniMonth` · `lunarMonth` · `weekEvents` · `weekSchedule` · `weekTimetable` · `timelineCards` |
| **Hôm nay** | `todayList` · `hourTimeline` |
| **Việc cần làm** | `reminderList` · `reminderMatrix` |
| **Tiến độ & đếm ngược** | `yearProgress` · `monthProgress` · `countdown` · `contributionGrid` |
| **Chữ** | `quote` |

Loại khoá Pro đeo `ProBadge`. Chạm vào → paywall, không phải thông báo lỗi.

### 5.7. Tràn nội dung — edge case bắt buộc xử lý

Thêm thành phần vào template chỉ có 1–3 band là chuyện rất dễ làm nội dung **vượt quá
chiều cao canvas**. Renderer hiện âm thầm bỏ band có width ≤ 0 và để nội dung chạy khỏi
mép ([StackWallpaperRenderer.swift:188-199](../ios/Ink/Core/Wallpaper/StackWallpaperRenderer.swift#L188-L199)).

> **AC:** khi tổng chiều cao đo được vượt canvas, hiện một chip cảnh báo trên canvas —
> *"Content runs off the screen"* — và trong inspector của thành phần bị tràn. **Không**
> tự động chặn thêm, **không** tự co lại: user có thể đang cố ý và sẽ tự sửa. Chỉ cần nói
> cho họ biết.

### 5.8. Ánh xạ design system

| Chỗ | Dùng | Tuyệt đối không |
|---|---|---|
| Header + undo/redo | `InkScreenHeader.controls(center:)`, `InkCircularIconButton(.bare)` | Tự dựng `HStack` header |
| Nút trên canvas | `InkChip(ground: .glass)`, `InkCircularIconButton(.glass)` | `.plain` (đó là chrome của bottom action row) |
| Nhóm inspector | `InkSegmentedTabs` | Tự vẽ tab |
| Hàng control | `InkFormRow` trong `InkGroupedCard` | Tự dựng `HStack` |
| Slider | `InkSlider` (dùng `fillsFromCenter: true` cho Lệch ngang) | `Slider` gốc |
| Swatch màu | `InkColorSwatch` — **`hitTarget: .overflowing(gap:)`** cho dải inline | `.padded` mặc định — xem GR-6 |
| Toast | `inkSnackbar` với `InkToast.Action` cho UNDO | |
| Sheet thêm thành phần | `InkPopupScaffold(size: .medium)` | |
| Dạy chạm-để-chọn lần đầu | `View.inkCoachTour(_:)` — 1 bước, nhắm vào canvas | |

---

## 6. Kiến trúc kỹ thuật

### 6.1. Enabler — renderer trả khung từng thành phần *(tính năng #2)*

`StackWallpaperRenderer.layout()` đã tính đủ hình học và **vứt đi**: `Band` là
`private struct` với `topY/left/width/height`
([StackWallpaperRenderer.swift:27-43](../ios/Ink/Core/Wallpaper/StackWallpaperRenderer.swift#L27-L43),
[:161](../ios/Ink/Core/Wallpaper/StackWallpaperRenderer.swift#L161)).

Thêm một API đo-không-vẽ:

```swift
/// Khung của mỗi band trong ảnh đã render, chuẩn hoá 0–1 theo cạnh ảnh.
struct InkBandFrame: Sendable, Equatable {
  let componentIndex: Int
  let id: String?
  let type: String
  /// Chuẩn hoá theo ảnh render, KHÔNG phải theo content space.
  let rect: CGRect
}

extension StackWallpaperRenderer {
  static func bandFrames(
    template: CalendarWallpaperTemplate,
    context: WallpaperRenderContext
  ) -> [InkBandFrame]
}
```

`layout()` chỉ `measure`, không vẽ → gọi lại rẻ. Chuẩn hoá 0–1 để rect dùng được ở mọi
tỉ lệ (preview render ở ~1/3 kích thước thật).

> **🔴 RỦI RO SỐ 1 — chuyển hệ toạ độ.** `layout()` trả toạ độ trong **content space**
> của canvas. `renderInContentColumn` áp một transform (scale + offset của content column)
> lên `CGContext` trước khi các part vẽ
> ([WallpaperRenderer.swift:38-99](../ios/Ink/Core/Wallpaper/WallpaperRenderer.swift#L38-L99)).
> Band rect **phải đi qua đúng transform đó** mới rơi đúng lên pixel ảnh. Bỏ qua bước này
> thì viền chọn sẽ lệch — và lệch theo kiểu "gần đúng" nên rất dễ lọt review. Phải có unit
> test đối chiếu rect với vị trí pixel thật (§10).

### 6.2. Enabler — `id` cố định

`CalendarStackComponent.id` đang là `String?`
([:17](../ios/Ink/Domain/CalendarTemplate/CalendarStackComponent.swift#L17)). Lựa chọn,
undo và thao tác xoá/nhân bản đều cần handle ổn định.

- Khi nạp template vào editor: band nào `id == nil` thì **backfill** `"\(type)-\(index)"`.
- Band do user thêm: `id = UUID().uuidString`.
- `id` phải được ghi ra trong `raw` — đã có sẵn ([:70](../ios/Ink/Domain/CalendarTemplate/CalendarStackComponent.swift#L70)).
- Backfill chỉ xảy ra **trong bộ nhớ khi mở editor**; không viết ngược vào catalog bundle.

### 6.3. Knob spec registry — trừu tượng lõi *(tính năng #3)*

Đây là phần quyết định tính năng #3 tốn 3 tuần hay 3 tháng. **Inspector tự sinh UI từ spec,
không viết tay 16 lần.**

```swift
enum InkInspectorGroup: String, CaseIterable { case content, text, container, placement }

enum InkKnobControl {
  case slider(range: ClosedRange<Double>, step: Double?)
  case toggle
  case colorSwatches([UInt32])          // + ColorPicker cho màu tuỳ ý
  case pick([InkKnobChoice])            // hàng InkChip
  case intStepper(range: ClosedRange<Int>)
  case text(limit: Int)
  case stringList(limit: Int)           // danh sách quote
  case font
}

struct InkKnobSpec {
  let path: [String]                    // ["quote","style","size"] — đường vào knobs
  let title: String.LocalizationValue
  let group: InkInspectorGroup
  let control: InkKnobControl
  let defaultValue: JSONValue           // dùng cho nút "Reset" (L7) và cho #6
  var isAdvanced: Bool = false          // nằm sau "More options" (L2)
}
```

Mở rộng protocol đã có
([CalendarStackPart.swift:81](../ios/Ink/Core/Wallpaper/Parts/CalendarStackPart.swift#L81)):

```swift
protocol CalendarStackPart {
  // … đã có: measure / draw / topOverhang
  static var displayName: String.LocalizationValue { get }
  static var paletteIcon: String { get }        // SF Symbol cho bảng thêm
  static var paletteGroup: InkPaletteGroup { get }
  static var editorSpec: [InkKnobSpec] { get }
  static var defaultKnobs: [String: JSONValue] { get }   // dùng khi user thêm mới (#6)
}
```

**Spec dùng chung gánh phần lớn việc** — đây là chỗ số liệu §1.2 trả cổ tức:

```swift
enum InkSharedSpecs {
  /// font · size · color · bold · italic · align — dùng cho MỌI khối chữ.
  static func textStyle(_ path: [String], title: String.LocalizationValue) -> [InkKnobSpec]
  /// style · color · corner · inset — `container` có mặt ở 13/38 band.
  static func container(_ path: [String] = ["container"]) -> [InkKnobSpec]
}
```

Một part điển hình khi đó chỉ còn:

```swift
extension QuotePart {
  static var editorSpec: [InkKnobSpec] {
    [
      .init(path: ["quote","items"], title: "Quotes", group: .content,
            control: .stringList(limit: 20), defaultValue: .array([])),
      .init(path: ["quote","lines"], title: "Lines", group: .content,
            control: .intStepper(range: 1...4), defaultValue: .number(2)),
      .init(path: ["quote","marks"], title: "Quotation marks", group: .content,
            control: .toggle, defaultValue: .bool(true)),
    ]
    + InkSharedSpecs.textStyle(["quote","style"], title: "Text")
    + InkSharedSpecs.container()
  }
}
```

> **Spec này ĐỒNG THỜI là hợp đồng parity với `ink-template-studio`.** Hiện
> `stackPartConfigs.tsx` bên web và panel bên iOS được maintain tay **hai lần**. Sau thay
> đổi này, spec là nguồn sự thật duy nhất cho "part này sửa được gì" — xem §9.

### 6.4. Knob `scale` *(tính năng #1)*

**Một chỗ sửa trong renderer, phục vụ cả 16 part.** Trong vòng lặp vẽ band
([StackWallpaperRenderer.swift:69-93](../ios/Ink/Core/Wallpaper/StackWallpaperRenderer.swift#L69-L93)),
nơi đã có `saveGState` + `translateBy` cho `offsetX`, bọc thêm một phép scale quanh **tâm
ngang của box band và cạnh trên của nó**:

```
saveGState()
translate(x: bandCenterX, y: band.topY)
scale(x: s, y: s)
translate(x: -bandCenterX, y: -band.topY)
… draw …
restoreGState()
```

| Yêu cầu | Giá trị |
|---|---|
| Key | `scale` — **knob của band**, nằm cạnh `inset`/`offset_x`, không phải knob riêng part |
| Dải | 0.5 … 2.0, step 0.05 |
| Mặc định | Vắng mặt ⇒ `1.0` ⇒ **no-op tuyệt đối** (NT-4) |
| Không hữu hạn | Đọc như vắng mặt — giống cách `inset`/`offsetX` đã xử lý ([:176-186](../ios/Ink/Core/Wallpaper/StackWallpaperRenderer.swift#L176-L186)) |

> **⚠️ Ẩn số đã biết (nguồn của confidence 80%):** các part **tự cap theo chiều cao còn
> lại** — `TimelineCardsPart` là ví dụ, và `StackWallpaperRenderer.safeTopFraction` được
> chia sẻ chính vì việc đó ([:19-25](../ios/Ink/Core/Wallpaper/StackWallpaperRenderer.swift#L19-L25)).
> Scale bằng CTM **không** đổi `availableHeight` mà part nhận, nên một part cap-theo-chỗ sẽ
> đo như chưa scale rồi bị phóng to ra ngoài. Hai lựa chọn, phải chốt bằng thử nghiệm:
> (a) chấp nhận — scale là hiệu ứng thị giác thuần, hoặc (b) chia `availableHeight` cho
> `s` trước khi gọi `measure`. **Ưu tiên (a)** cho đơn giản; nếu QA thấy sai rõ ràng ở
> `timelineCards`/`todayList` thì chuyển (b) và thêm golden cho cả hai.

### 6.5. Undo / redo *(tính năng #4)*

Bê nguyên mô hình đã chạy của trình trang trí
([WallpaperDecorHistory.swift](../ios/Ink/UI/Wallpaper/Decoration/WallpaperDecorHistory.swift)):
hai stack, snapshot **nguyên trạng thái**, cap 30, edit mới xoá stack redo.

Khác biệt: đơn vị snapshot ở đây là cặp
`(InkLayoutWallpaperSettings, CalendarWallpaperTemplate)` — đúng thứ
`viewModel.currentState()` / `restore(_:)` đã dùng cho nút Cancel
([TemplateEditorScreen.swift:57](../ios/Ink/UI/Wallpaper/TemplateEditorScreen.swift#L57),
[:429](../ios/Ink/UI/Wallpaper/TemplateEditorScreen.swift#L429)). Tức là hạ tầng
snapshot/restore **đã có**, chỉ thiếu stack.

### 6.6. Kéo proxy *(tính năng #7)*

Vấn đề: mọi mutation đi qua `scheduleRender()` với debounce 300ms
([CalendarTemplateEditorViewModel.swift:1269](../ios/Ink/UI/Wallpaper/CalendarTemplateEditorViewModel.swift#L1269)),
preview render ở ~1/3 kích thước. Kéo mà render mỗi tick thì thành slideshow.

Cách làm:
1. **Bắt đầu kéo:** crop vùng pixel của band ra khỏi `previewImage` hiện tại (dùng band
   rect chuẩn hoá từ §6.1).
2. **Đang kéo:** vẽ ảnh crop đó theo ngón, cộng một mảng mờ che chỗ cũ. **Không** đụng
   view model.
3. **Thả tay:** ghi giá trị thật → gọi `renderNow()` (không debounce) → bỏ proxy khi ảnh
   mới về.

Toán hình học tái dùng đúng pattern của decor editor: toạ độ chuẩn hoá, hàm thuần
trong [`WallpaperDecorGeometry.swift`](../ios/Ink/Core/Utilities/WallpaperDecorGeometry.swift),
snap về giữa ở [:103-119](../ios/Ink/Core/Utilities/WallpaperDecorGeometry.swift#L103-L119).

> **Spike 2 ngày trước khi cam kết 3 tuần.** Confidence của #7 đang là 50% vì bước (1)–(2)
> chưa có tiền lệ (decor editor kéo **view thật**, không kéo pixel đã render). Nếu proxy
> nhìn tệ (band có bóng, nền trong suốt, chồng lấn band khác), phương án B là **vẽ khung
> viền rỗng** chạy theo ngón thay vì ảnh crop — kém đã mắt hơn nhưng chắc chắn chạy.

### 6.7. Gate Pro theo part *(tính năng #5)*

Không có tiền lệ trong catalog (`is_pro` = 0 ở cả 19 template). Đề xuất **cơ chế rẻ nhất**:
một khoá Remote Config `pro_part_types` chứa mảng string, mặc định bundle là `[]`.

```
pro_part_types = ["contributionGrid", "reminderMatrix", "timelineCards"]
```

- Chỉ chặn ở **bảng thêm thành phần** (#6). Template catalog đã chứa sẵn part đó thì **vẫn
  render bình thường** cho user free — không bao giờ khoá ngược thứ user đang dùng.
- Đọc qua `ProAccessPolicy.entitlement.isActive` như mọi chỗ khác.
- Xem §11 Q3 — đây là quyết định kinh doanh, không phải kỹ thuật.

---

## 7. Acceptance Criteria

### AC#1 — Phóng to / thu nhỏ từng thành phần
- [ ] 1.1 Inspector nhóm **Vị trí** có slider *Cỡ*, dải 0.5–2.0, step 0.05, mặc định 1.0.
- [ ] 1.2 Đổi slider làm thành phần đó (và **chỉ** thành phần đó) đổi kích thước trên preview.
- [ ] 1.3 `scale` vắng mặt ⇒ render **y hệt** bản trước thay đổi. **0 golden cũ bị đổi.**
- [ ] 1.4 `scale` không hữu hạn (NaN/∞) từ Remote Config ⇒ đọc như 1.0, không crash.
- [ ] 1.5 Có golden mới cho `scale = 0.5` và `scale = 2.0` trên ít nhất 2 part khác loại.
- [ ] 1.6 Nút Reset đưa về 1.0 và biến mất khi đang là 1.0.

### AC#2 — Chạm chọn + chỉnh vị trí, bề rộng
- [ ] 2.1 Chạm lên vùng một thành phần trên preview ⇒ thành phần đó được chọn (viền + chip tên).
- [ ] 2.2 Viền khớp **chính xác** vùng vẽ thật của thành phần (sai số ≤ 2pt ở kích thước preview).
- [ ] 2.3 Chạm vùng trống ⇒ bỏ chọn, panel về 4 tab global.
- [ ] 2.4 Thành phần chồng nhau: lấy cái trên cùng; chạm lại luân phiên xuống cái dưới.
- [ ] 2.5 Thành phần có rect nhỏ hơn 44pt vẫn chạm được (hit area nới, viền vẽ không nới).
- [ ] 2.6 Sau render lại, lựa chọn giữ theo `id`, không trượt khi thêm/xoá thành phần khác.
- [ ] 2.7 Inspector nhóm **Vị trí** có: Tự động/Cố định, slider vị trí tương ứng, Bề rộng, Lệch ngang.
- [ ] 2.8 **Đổi Tự động ↔ Cố định không làm thành phần dịch chuyển trên preview** (§5.4).
- [ ] 2.9 Thành phần đầu stack không chào mời "Tự động" theo nghĩa vô nghĩa.
- [ ] 2.10 Nút ẩn/hiện panel đã chuyển ra thanh công cụ canvas; chạm canvas **không** còn ẩn panel.
- [ ] 2.11 Lần đầu mở editor sau update: coach tour 1 bước dạy chạm-để-chọn, chỉ hiện một lần.

### AC#3 — Sửa chữ, màu, nền, nội dung
- [ ] 3.1 **Cả 16 part** đều có `editorSpec` và `defaultKnobs`; test liệt kê `CalendarStackParts.byType` và fail nếu thiếu.
- [ ] 3.2 Inspector sinh UI từ spec, không có `switch` theo `type` trong tầng view.
- [ ] 3.3 Nhóm rỗng không hiện (L3).
- [ ] 3.4 Knob `isAdvanced` nằm sau "More options", mặc định đóng (L2).
- [ ] 3.5 Mỗi nhóm ≤ 6 control nhìn thấy ngay (L1).
- [ ] 3.6 Sửa knob ghi đúng vào `knobs` theo `path`, giữ nguyên mọi key lạ (round-trip an toàn — hợp đồng ở [CalendarStackComponent.swift:10-13](../ios/Ink/Domain/CalendarTemplate/CalendarStackComponent.swift#L10-L13)).
- [ ] 3.7 Không có chuỗi `y`/`gap`/`inset`/`offset_x`/`knob`/`band`/`part` nào lộ lên UI.
- [ ] 3.8 Mọi chuỗi mới nằm trong `Localizable.xcstrings`, đủ 11 ngôn ngữ.

### AC#4 — Hoàn tác / làm lại
- [ ] 4.1 Undo/redo ở giữa header, `.bare`, disabled thể hiện bằng màu glyph.
- [ ] 4.2 Một cử chỉ kéo/pinch = **đúng một** bước undo.
- [ ] 4.3 Kéo slider = một bước undo khi **thả tay**, không phải mỗi tick.
- [ ] 4.4 Chạm để chọn **không** ghi bước undo (bẫy GR-3).
- [ ] 4.5 Cap 30 bước; edit mới xoá stack redo.
- [ ] 4.6 Nút Cancel vẫn revert về trạng thái lúc vào, độc lập với stack undo.

### AC#5 — Gate Pro theo part
- [ ] 5.1 Part trong `pro_part_types` đeo `ProBadge` trong bảng thêm.
- [ ] 5.2 User chưa Pro chọn part khoá ⇒ paywall (`source: "wallpaper_add_component"`), không phải alert.
- [ ] 5.3 Mua xong trong editor ⇒ entitlement tới được view model (đã có tiền lệ ở [TemplateEditorScreen.swift:175](../ios/Ink/UI/Wallpaper/TemplateEditorScreen.swift#L175)).
- [ ] 5.4 Template catalog đã chứa part khoá ⇒ **vẫn render** cho user free.
- [ ] 5.5 `pro_part_types` rỗng/thiếu/hỏng ⇒ không khoá gì.

### AC#6 — Thêm / xoá / nhân bản
- [ ] 6.1 `+` mở sheet 16 loại chia **5 nhóm**, mỗi ô có icon + tên + mô tả một dòng.
- [ ] 6.2 Thêm ⇒ chèn ngay sau thành phần đang chọn (hoặc cuối), tự chọn, mở inspector.
- [ ] 6.3 Toast *"Added …"* kèm nút **UNDO**.
- [ ] 6.4 Thành phần mới dùng `defaultKnobs` của part, render ra **cái nhìn thấy được ngay** (không phải band rỗng).
- [ ] 6.5 Xoá có bước xác nhận **hoặc** toast UNDO — không được mất dữ liệu lặng lẽ.
- [ ] 6.6 Nhân bản đặt bản sao ngay dưới bản gốc, `id` mới.
- [ ] 6.7 Nội dung tràn canvas ⇒ chip cảnh báo (§5.7). Không tự chặn, không tự co.
- [ ] 6.8 Xoá hết thành phần ⇒ canvas trống + trạng thái rỗng mời thêm lại, không phải màn hình hỏng.

### AC#7 — Kéo thả trực tiếp
- [ ] 7.1 Kéo một thành phần đã chọn → di chuyển; pinch → đổi cỡ. **Không có cử chỉ thứ ba** (L6).
- [ ] 7.2 Trong lúc kéo, chrome editor mờ đi; hiện lại khi thả (có debounce chống nháy).
- [ ] 7.3 Kéo hiển thị badge sống với giá trị đang đổi.
- [ ] 7.4 Kéo ngang snap về giữa, có vạch dẫn + `InkHaptics.selection` đúng một lần khi chạm mốc.
- [ ] 7.5 Trong lúc kéo **không** gọi render; thả tay gọi `renderNow()` đúng **một** lần.
- [ ] 7.6 Kéo dọc quá mức làm `gap < 0` ⇒ clamp về 0, **không** tự chuyển sang Cố định (§5.4).
- [ ] 7.7 Kéo mượt ≥ 55fps trên iPhone 12.

---

## 8. Guardrails — bẫy đã biết, đừng ship lại

Rút từ trình trang trí và `docs/DESIGN.md` §6. Mỗi dòng là một lỗi **đã từng lên production**.

| # | Bẫy | Cách tránh |
|---|---|---|
| **GR-1** | `clipShape` **không** cắt vùng chạm. Subview quá khổ ăn tap của tile bên cạnh. | `.contentShape(Rectangle())` trên label của mọi vùng chạm được. |
| **GR-2** | Layer trang trí vẽ ngoài frame vẫn nuốt tap/scroll ⇒ "màn hình đơ mà không thấy gì sai". | Viền chọn, vạch dẫn, badge: `.allowsHitTesting(false)`. |
| **GR-3** | Ghi bước undo ngay lúc chạm-xuống ⇒ chạm để chọn cũng đẻ một bước rỗng và xoá stack redo. | Chốt "base" của cử chỉ **sau** khi vượt ngưỡng kéo, không phải lúc touch-down ([WallpaperDecorItemView.swift:284-291](../ios/Ink/UI/Wallpaper/Decoration/WallpaperDecorItemView.swift#L284-L291)). |
| **GR-4** | Kéo dùng `.local` coordinate space ⇒ mọi tỉ lệ khoảng cách về ~1, scale hỏng. | Dùng **named coordinate space** dùng chung, như [`WallpaperDecorItemView.layerSpace`](../ios/Ink/UI/Wallpaper/Decoration/WallpaperDecorItemView.swift#L60-L65). |
| **GR-5** | `InkScreenHeader` tự mang gutter; lồng trong container đã padding ⇒ inset **hai lần**, cả bar đi vào trong. | Cho nó làm con trực tiếp của `VStack(spacing: 0)`. |
| **GR-6** | `InkColorSwatch` mặc định `hitTarget: .padded` ⇒ dải 6 swatch chiếm 288pt, đẩy **cả màn** rộng 429pt trên máy 393pt và cắt mất ✕/✓ ở header. | Dải inline trong inspector **bắt buộc** `hitTarget: .overflowing(gap:)`, và **không** đặt trong ancestor có clip. |
| **GR-7** | `.frame(minHeight:)` không có trần ⇒ control phình ra lấp cả ô. | Luôn đi kèm `.fixedSize(horizontal: false, vertical: true)`. |
| **GR-8** | `InkSymbolGrid` không tự mang inset ngang. | Host bleed tới mép phải truyền `contentInset:`, không padding từ ngoài. |
| **GR-9** | Halo của `InkColorSwatch` nằm **ngoài** swatch ⇒ hàng trong `ScrollView` bị cắt phẳng khi chọn. | Cho hàng ít nhất `haloGap` padding dọc. |
| **GR-10** | Ảnh `scaledToFill` khai frame quá khổ ⇒ đẩy cả hàng ra khỏi mép. | Artwork đặt trong `.overlay` trên `Color.clear` đã `.aspectRatio(contentMode: .fit)`. |

---

## 9. Parity với `ink-template-studio`

Studio (repo `Sfund/Web/ink-template-studio`) publish JSON vào **cùng** khoá Remote Config
và phải render pixel-identical. Mọi thứ PRD này thêm đều là thay đổi **hai phía**:

| Thêm gì ở iOS | Phải làm gì ở Studio |
|---|---|
| Knob `scale` cấp band | Cùng phép biến đổi trong `stackPartLayers.tsx`, cùng dải/step/mặc định |
| `InkKnobSpec` cho mỗi part | `stackPartConfigs.tsx` sinh form từ **cùng** danh sách knob |
| `defaultKnobs` cho mỗi part | `PALETTE_ITEMS` trong `stackParts.ts` dùng đúng bộ mặc định đó |
| Backfill `id` | Không đổi (Studio đã ghi `id`) |

> Trước khi merge bất kỳ đợt nào: chạy **parity check** — xuất golden PNG từ cả hai phía
> cho cùng JSON và so sánh, theo đúng quy trình ở
> [`docs/adding-a-calendar-stack-component.md`](adding-a-calendar-stack-component.md).
> Spec knob là nguồn sự thật duy nhất; hai bên lệch nghĩa là chưa xong.

---

## 10. Test plan

| Tầng | Test | Chặn merge |
|---|---|---|
| Golden | **0 golden hiện có bị đổi** sau cả 7 tính năng | ✅ |
| Golden | `scale` 0.5 / 1.0 / 2.0 trên ≥ 2 part khác loại | ✅ |
| Unit | `bandFrames` khớp vị trí pixel thật — render một template, so rect với vùng có ink (đây là test giữ RỦI RO SỐ 1, §6.1) | ✅ |
| Unit | Đổi Tự động ↔ Cố định: rect **trước và sau** lệch ≤ 1px (AC 2.8) | ✅ |
| Unit | Mọi key trong `CalendarStackParts.byType` có `editorSpec` + `defaultKnobs` (AC 3.1) | ✅ |
| Unit | `defaultKnobs` của mỗi part decode được bằng chính `Knobs: Decodable` của part đó | ✅ |
| Unit | Ghi knob theo `path` giữ nguyên key lạ (AC 3.6) | ✅ |
| Unit | Undo stack: cap 30, redo bị xoá bởi edit mới, chọn không ghi bước | ✅ |
| UI test | chọn → sửa → undo → redo trên template 2 band | ✅ |
| UI test | thêm thành phần → toast UNDO → thành phần biến mất | |
| Thủ công | Kéo ≥ 55fps trên iPhone 12 (AC 7.7) | |
| Thủ công | Dynamic Type AX3: inspector không cắt chữ, header không vỡ hàng | ✅ |

> Chạy test theo lệnh trong `CLAUDE.md`, **giữ nguyên `OS=18.6`** — thả qualifier là 39
> golden test lặng lẽ bị SKIP.

---

## 11. Open Questions — chốt trước khi vào code

| # | Câu hỏi | Ai chốt | Mặc định nếu không chốt |
|---|---|---|---|
| **Q1** | `scale` xử lý part tự-cap-theo-chỗ theo phương án (a) hay (b)? (§6.4) | Eng, bằng thử nghiệm | (a) — scale thuần thị giác |
| **Q2** | Kéo proxy bằng **ảnh crop** hay **khung viền rỗng**? (§6.6) | Eng, sau spike 2 ngày | Khung viền rỗng (chắc chắn chạy) |
| **Q3** | Part nào khoá Pro — hay **không khoá part nào**, giữ Pro ở tầng template? (§6.7) | Product / kinh doanh | Không khoá part nào; #5 hoãn |
| **Q4** | Có trần số thành phần mỗi wallpaper không? | Product | Không trần cứng; chỉ cảnh báo tràn (§5.7) |
| **Q5** | Thành phần user tự thêm có xuất hiện trong "Your collection" như một template riêng không? | Product | Không — vẫn là bản sửa của template gốc, đúng cơ chế snapshot hiện tại |
| **Q6** | Đổi thứ tự thành phần: làm bằng menu ⋯ Move up/down, hay hoãn hẳn? | Product | Hoãn — median 2 band, chưa đáng |

---

## 12. Việc kèm theo khi ship

- [ ] Cập nhật [`docs/ux/03-wallpaper.html`](ux/03-wallpaper.html) mục **WP-EDIT** — bắt buộc **cùng commit** với thay đổi UI (luật ở [`docs/ux/README.md`](ux/README.md)).
- [ ] Đăng ký component dùng chung mới (nếu có) vào [`.claude/rules/swift/design-system.md`](../.claude/rules/swift/design-system.md) **cùng commit**.
- [ ] Ghi vào `docs/DESIGN.md` §6 mọi quyết định hình học đáng nhớ.
- [ ] Cập nhật [`docs/adding-a-calendar-stack-component.md`](adding-a-calendar-stack-component.md): thêm part mới giờ phải kèm `editorSpec` + `defaultKnobs` + `paletteIcon` + `paletteGroup`.
- [ ] Bổ sung chuỗi mới vào `ios/Ink/Localizable.xcstrings` đủ 11 ngôn ngữ.
