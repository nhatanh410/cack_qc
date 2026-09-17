# Test Plan — PR #218 + PR #225

> **Test basis:** [QC-PR-218-225.md](../specs/QC-PR-218-225.md) — change note, PR #218 merge `main` 16/09/2026,
> PR #225 merge `main` 17/09/2026. Test trên build dựng từ `main` từ commit `78dec0aa` trở đi.
> **Không có PRD chính thức** — chỉ có change note dạng checklist (giống pattern `QC-uiux-9sep.md`,
> `qc-wallpaper-decoration.md`), acceptance criteria mô tả ngắn, nhiều chỗ chỉ có "kỳ vọng" chứ không có số
> chính xác — gom vào mục 11.
> **Đối chiếu với tài liệu đã có:** wireframe [04_discover.md](../ui/ux/wideframes/04_discover.md),
> [03_shortcut-setup.md](../ui/ux/wideframes/03_shortcut-setup.md),
> [07_note.md](../ui/ux/wideframes/07_note.md); exploratory
> [04_discover.md](../exploratory/04_discover.md), [03_shortcut-setup.md](../exploratory/03_shortcut-setup.md),
> [07_note.md](../exploratory/07_note.md); [bugs/bug-log.md](../../bugs/bug-log.md) (BUG-001, BUG-002).
> **Chuẩn:** ISTQB Foundation Level (test basis → test object → kỹ thuật thiết kế → rủi ro → entry/exit)
> **Ngày lập:** 2026-09-17 · **Người lập:** QC

---

## 1. Test basis — tín hiệu tự thân của note

- Note tự chia 8 mục độc lập, mỗi mục map tới đúng 1 flow đã có (`04_discover`, `03_shortcut-setup`,
  `07_note`) — không có mục nào tạo flow mới.
- Mục 4 (Setup shortcut) là mục **dài nhất, nhiều nhánh nhất**, chính note cũng ghi "PR #218 + #225" (2 PR
  cùng chạm) — coi đây là mục rủi ro merge cao nhất, tương tự nguyên tắc đã dùng ở
  [1.2.15-decoration-inkai.md mục 4](1.2.15-decoration-inkai.md#4-test-levels--types) cho 2 điểm merge PR
  #185/`main`.
- Note tự flag 1 case "**không log bug**" (mục 4, "Xoá shortcut nhưng mới chạy trong 48 giờ → vẫn cho qua...
  thiết kế có chủ đích") — tín hiệu hiếm, dev chủ động xác nhận hành vi trước khi QC test, tránh log nhầm.
- Note yêu cầu bật lại Set Automatically cho giờ máy sau khi test (mục 4) — bản thân dev cũng biết thao tác
  chỉnh giờ hệ thống là can thiệp có tác dụng phụ; xem mục 2.3 về xung đột với khuyến nghị đã có trong
  `exploratory/03_shortcut-setup.md`.
- Thiết bị yêu cầu: iOS 17 **và** iOS 26, iPhone màn nhỏ **và** Pro Max, 3 nhóm ngôn ngữ (English, Tiếng Việt,
  1 CJK) — ma trận rộng hơn các note trước, không thiết bị/ngôn ngữ nào được note miễn trừ.

## 2. Phát hiện mới khi đối chiếu với tài liệu đã có

### 2.1 Tab "Note" trong collection không mất — nó đổi tên/gộp, và đây đúng là thứ đang được test

Wireframe [04_discover.md](../ui/ux/wideframes/04_discover.md) (screen S03, "Your collection" full-list) mô tả
tab set **cũ**: `All · Lockscreen · Live Activity · Note` — không có tab `Widget`. Note đổi thành
`All · Lockscreen · Live Activity · Widget`, dời item Note vào trong tab Lockscreen. Đây **không phải mâu
thuẫn tài liệu** — đây chính xác là nội dung PR đang thay đổi, và cross-reference xác nhận đúng 1 thứ: **CTA
của tile Note cũng đổi theo cùng lúc**. Wireframe ghi Note item có CTA `Edit`; note nói tile Note không active
có CTA `"Set as current"` — hai tài liệu khớp nhau nếu đọc là "trước: Edit, sau PR này: Set as current". Case
mục 2 dòng 4 (`06_task_02...` — nhầm, đúng là mục 2 bullet 4 của note) cần verify rõ: **CTA `Edit` không còn
xuất hiện ở đâu nữa** cho tile Note chưa active, không chỉ verify CTA mới xuất hiện đúng.

### 2.2 Hai cách phân loại "Note" khác nhau, dễ nhầm khi log bug

Mục 1 của note (skeleton) liệt kê **4 hàng riêng biệt** trên Discover home: `Lockscreen`, `Note Lockscreen`,
`Live Activities`, `Widgets` — "Note Lockscreen" là **hàng riêng**, không gộp vào `Lockscreen`. Mục 2 (collection)
lại nói item Note **nằm trong** tab `Lockscreen`, không có tab riêng. Hai taxonomy này đang tồn tại song song:
Discover home phân loại theo **nguồn nội dung** (Note Lockscreen là 1 loại nội dung riêng), còn collection
phân loại theo **nơi lưu** (mọi thứ dùng làm lock screen, kể cả Note, đều vào tab Lockscreen). Về mặt sản phẩm
có thể hợp lý (2 màn khác mục đích), nhưng **không có trong bất kỳ tài liệu nào** — cần verify đây là chủ ý,
không phải 2 đội làm 2 phần khác nhau ra 2 taxonomy lệch nhau. Ghi ở mục 11 gap #1.

### 2.3 "Chỉnh giờ máy tiến 3 ngày" — đúng phương pháp note đề xuất, nhưng đã có cảnh báo trước đó

`exploratory/03_shortcut-setup.md` cảnh báo rõ (SCT, mục phương pháp test automation): *"Không rút ngắn bằng
cách đổi giờ hệ thống. Đổi giờ hệ thống có thể chính nó làm automation không chạy, dẫn tới kết luận sai."* Note
lại chính thức yêu cầu QC làm đúng việc đó ("Chỉnh giờ máy tiến 3 ngày rồi mở lại"). Đây là **xung đột phương
pháp thật**, không phải lỗi đánh máy — dev có thể đã chấp nhận rủi ro này vì không có cách nào khác để test
nhanh ngưỡng 48h. QC cần chạy case này **2 lượt độc lập**: (a) đúng theo note (đổi giờ hệ thống) để khớp cách
dev tự test, và (b) nếu có thể, chờ thời gian thật ≥48h ít nhất 1 lần để loại trừ khả năng bản thân việc đổi
giờ làm automation gãy (false fail/false pass). Xem BVA mục 4.

### 2.4 Ngưỡng "48 giờ" mới xuất hiện lần đầu — có thể trùng khái niệm với ngưỡng "24 giờ" đã ghi nhận trước đó

`exploratory/03_shortcut-setup.md` (bảng chẩn đoán SCT-D08/D09) từng đặt câu hỏi Ink có phát hiện được
"Wallpaper quá cũ (>**24h** chưa cập nhật)" không — một ngưỡng khác, thấp hơn, cho một mục đích khác (cảnh báo
wallpaper cũ). Note lần này nói "shortcut đã chạy thành công trong **48 giờ**" — ngưỡng cho việc bỏ qua bước
verify khi mở lại hướng dẫn. Hai ngưỡng có thể độc lập hoàn toàn (1 cái cảnh báo dữ liệu cũ, 1 cái quyết định
có cần re-verify shortcut hay không) nhưng **cùng đơn vị đo (giờ kể từ lần chạy/cập nhật gần nhất)**, rủi ro
nhầm lẫn khi implement/QA nếu 2 con số dùng chung 1 timestamp nguồn. Ghi vào mục 11 gap #2, không tự suy diễn
là cùng 1 cơ chế.

### 2.5 BUG-001/BUG-002 nằm khác vùng — không đương nhiên regression, nhưng cùng entry point cần làm rõ

BUG-001 (nút ✓ không lưu note) và BUG-002 (label `(Untitled)`) đều xảy ra ở **note-làm-lock-screen** (Discover
→ Lockscreen → Note category → editor dạng giấy, S09/04_discover.md) — khác với "Notes" ở mục 5 của note này,
vốn mô tả layout grid/list + đổi kiểu bullet/số/checklist, khớp với tab **Notes** trong app (07_note.md, S02,
editor phẳng, toolbar 5 icon). Đây **có thể là 2 màn hình khác nhau dùng chung tên "note"**. Wireframe
`07_note.md` (dòng ~140) tự đặt câu hỏi mở tương tự: nút ✓ lỗi (BUG-001) có phải bug dùng chung component hay
chỉ riêng nhánh lock-screen-note? Note PR #218/#225 không nói gì về nút ✓ hay label `(Untitled)` — nhưng vì
mục 5 chạm đúng vùng lân cận (Notes tab), theo đúng tiền lệ đã áp dụng ở
`exploratory/07_note.md` (NOT-N01/NOT-N02 bắt regression BUG-001/002 dù PR #179 gốc không nhắc tới hai bug này)
— **khuyến nghị regression-check nhanh cả 2 bug tại Notes tab** dù out-of-scope chính thức của note.

### 2.6 Carousel demo-clip → screenshot là pattern UI hoàn toàn mới

Wireframe `03_shortcut-setup.md` mô tả từng bước hướng dẫn (S01, S08) là **1 ảnh tĩnh duy nhất**, không có
carousel hay video demo. Note yêu cầu mỗi bước giờ là "carousel: clip demo trước, rồi tới ảnh chụp màn hình" —
đây là thay đổi UI pattern hoàn toàn mới, chưa từng có bản trước để so sánh hồi quy — nên coi toàn bộ hành vi
vuốt/tự phát/dừng video là **chức năng mới cần test từ đầu**, không phải "vuốt mượt hơn bản cũ".

## 3. Test object — In scope

| # | Feature | Nguồn note | Ghi chú |
|---|---|---|---|
| 1 | Discover: skeleton loading (4 hàng, tile/description theo đúng ma trận, transition sang feed thật, VoiceOver, Larger Text) | mục 1 | Cần chuẩn bị máy sạch (xoá cài lại) + Network Link Conditioner |
| 2 | Discover: collection 4-tab mới (All/Lockscreen/Live Activity/Widget), tab Widget chỉ liệt kê widget thật trên Home Screen, tile Active + time-ago, CTA Note đổi Edit→Set as current | mục 2 | Xem mục 2.1 — verify cả chiều "Edit không còn xuất hiện" |
| 3 | Banner "Lock screen not updating live" + màn giải thích (nút đóng bên trái, nút *I understand* ghim đáy, nút mũi tên cuộn) | mục 3 | |
| 4 | Setup shortcut — carousel từng bước (mới hoàn toàn, mục 2.6); re-open hướng dẫn khi đã cài theo ngưỡng 48h (4 nhánh: còn hạn / hết hạn-còn shortcut / hết hạn-đã xoá shortcut / đã xoá nhưng còn hạn); flow từ collection (Set as current/Update, không áp ngưỡng 48h) | mục 4 | Rủi ro merge cao nhất (mục 1); xung đột phương pháp test giờ hệ thống (mục 2.3) |
| 5 | Notes: toggle grid/list (persist qua restart), đổi kiểu text↔bullet↔số↔checklist giữ nguyên nội dung, giữ bàn phím mở khi đổi kiểu | mục 5 | Xem mục 2.5 — regression BUG-001/002 khuyến nghị dù ngoài phạm vi chính thức |
| 6 | Widget Home Screen — Today/Agenda/Up Next đúng event giữa/cuối tháng, event nhiều ngày còn hiện | mục 6 | Cần chuẩn bị lịch >60 event |
| 7 | Live Activity — cập nhật sang ngày mới không biến mất/hiện lại | mục 7 | |
| 8 | Localization — bold tên shortcut không lộ `**`; toàn bộ chuỗi mới dịch đủ ở ngôn ngữ ngoài English | mục 8 | |

## 4. Out of scope

- **Logic quyết định event nào hiển thị trên wallpaper/widget** (thuật toán chọn lịch, không phải UI hiển thị)
  — note chỉ sửa bug "sai event hiển thị", không đổi logic chọn lịch nói chung; nếu phát hiện sai lệch khác
  không khớp mô tả mục 6/7, đây là bug mới, không phải mở rộng scope.
- **Toàn bộ Ink AI / Decorate editor** — thuộc PR #185, đã có test plan riêng
  [1.2.15-decoration-inkai.md](1.2.15-decoration-inkai.md), không liên quan PR #218/#225.
- **Nội dung/độ chính xác câu trả lời note-widget khác** (Timeline/Timetable template, ngoài phạm vi Note
  lock-screen của mục 2) — không đổi theo note này.
- **Toàn bộ luồng tạo shortcut lần đầu cho user chưa từng cài** ngoài phần carousel mới (mục 4 note tự nói
  "luôn phải kiểm tra như bản cũ") — chỉ verify carousel mới, không viết lại toàn bộ case cũ đã có ở
  `exploratory/03_shortcut-setup.md`.
- Bug đã biết ngoài phạm vi note này (BUG-003 paywall, BUG-004 Google Calendar) — không liên quan PR này.

## 4.1 Ảnh hưởng chéo tới flow khác (regression impact ngoài phạm vi note)

> Note chỉ tự khai 3 flow trực tiếp (`04_discover`, `03_shortcut-setup`, `07_note`). Bảng dưới đánh giá thêm
> các flow khác trong flow map ([screenshot-naming.md §7](../../.claude/rules/screenshot-naming.md#7-flow-map--ink-calendar-ios))
> có khả năng bị ảnh hưởng gián tiếp, để quyết định có cần spot-check ngoài phạm vi note hay không.

| Flow | Ảnh hưởng? | Lý do |
|---|---|---|
| `03_shortcut-setup`, `04_discover`, `07_note` | **Trực tiếp** | Đúng 3 flow note tự khai (mục 1–5, 8) |
| `09_settings` | **Gián tiếp** | 2 điểm entry point dùng chung UI với bản trong Discover/Guide: "Settings → dòng mở màn giải thích" (mục 3) và "Settings → Set up shortcut" (mục 4). Cần verify 2 entry point này **đồng bộ cùng 1 trạng thái** — vd ngưỡng 48h phải tính giống nhau dù mở từ Settings hay từ Guide, không có đường tắt nào bỏ qua logic mới do lỗi wiring khác nhau giữa 2 entry point. |
| `05_calendar` | **Gián tiếp** | Widget Today/Agenda/Up Next (mục 6) và Live Activity timeline (mục 7) đọc cùng nguồn event với tab Calendar. Nếu fix nằm ở tầng lấy dữ liệu (không chỉ tầng render widget), nên spot-check nhanh Day/Week/Month view trong Calendar không bị lệch event theo hướng ngược lại (regression ẩn ngoài ý muốn của fix). |
| `10_lockscreen` | **Gián tiếp** | Wallpaper thật sau khi áp dụng phụ thuộc trực tiếp vào đúng event hiển thị (mục 6/7). Cùng vùng rủi ro đã ghi nhận ở [BUG-004](../../bugs/bug-log.md#bug-004--event-tạo-trên-google-calendar-không-xuất-hiện-trên-wallpaper-hôm-sau) (event Google Calendar thiếu trên wallpaper, root cause nghi ở tầng fetch lúc render) — khuyến nghị **thử lại nhanh kịch bản BUG-004** trên build này, vì mục 6/7 chạm đúng logic hiển thị event mà BUG-004 đang nghi vấn, có thể vô tình fix hoặc vô tình lộ rõ hơn. |
| `06_task`, `08_paywall`, `01_onboarding`, `02_permission`, `14_edit-wallpaper` | **Không ảnh hưởng** | Không entry point, không data pipeline nào dùng chung với mục 1–8 của note. |
| `11_share`, `12_ai-assistant`, `13_community` | **Không áp dụng** | Chưa build (Phase 2), không có gì để ảnh hưởng. |
| Localization (cross-cutting) | **Chỉ trong phạm vi 3 flow trực tiếp** | Note liệt kê rõ danh sách chuỗi mới (banner explainer, tag Active, "now", "No widgets yet", "Scroll down", "Note Lockscreen", "Switch to grid view") — toàn bộ nằm trong `04_discover`/`03_shortcut-setup`/`07_note`, không có chuỗi nào lộ sang flow khác — **không cần** quét l10n ở các flow "Không ảnh hưởng" phía trên. |

## 5. Test levels & types

- **Level:** System testing (black-box, TestFlight/build từ `main`) — QC không có quyền vào code.
- **Functional:** đúng 4 hàng skeleton + ma trận title/description, đúng 4 tab collection + scoping Widget tab,
  đúng banner/explainer UI, đúng 4 nhánh re-open shortcut theo ngưỡng 48h, đúng persist layout Notes, đúng
  event hiển thị trên widget/live activity.
- **Non-functional:**
  - **Usability:** nút mũi tên cuộn trong màn giải thích banner phải đủ rõ ràng để user hiểu cần cuộn hết mới
    bấm được *I understand*; carousel demo clip không được tự phát âm thanh gây khó chịu (note không nói rõ có
    âm thanh không — xem mục 11 gap #4).
  - **Accessibility:** VoiceOver đọc đúng "Loading templates"/"Đang tải mẫu" theo ngôn ngữ hệ thống (mục 1);
    VoiceOver đọc "Scroll down" trên nút mũi tên (mục 8); Larger Text mức lớn nhất không giật layout skeleton→
    feed thật (mục 1).
  - **Localization:** English, Tiếng Việt, 1 ngôn ngữ CJK bắt buộc cho mọi case; riêng mục 8 mở rộng thêm
    ja/ko/zh/zh-Hant cho popup đặt hình nền (4 biến thể CJK, không chỉ 1).
  - **Compatibility:** iOS 17 vs iOS 26 (không có ghi chú khác biệt cụ thể trong note — coi là ma trận đầy đủ,
    không suy diễn tắt); iPhone màn nhỏ vs Pro Max (đặc biệt cho banner "câu tối đa 2 dòng ở mọi ngôn ngữ" —
    rủi ro tràn dòng cao nhất ở màn nhỏ + CJK).
  - **Reliability:** skeleton hiện tối đa ~5 giây dưới Very Bad Network — verify đúng ngưỡng thời gian, không
    chỉ "có hiện skeleton".
  - **Performance/timing:** transition skeleton→feed thật không giật vị trí tiêu đề/hàng tile — cả điều kiện
    thường và Larger Text.
- **Change-related (regression):** mục 4 là điểm 2 PR cùng chạm (#218 + #225) — test carousel (mới từ #225?)
  và logic 48h (mới từ #218?) **riêng biệt trước**, sau đó test lại **cả chuỗi liền mạch** (mở Guide → xem
  carousel → cài → mở lại sau 48h) để bắt lỗi tại đúng điểm giao 2 PR, theo đúng nguyên tắc đã dùng cho
  3.4/3.8 ở [1.2.15-decoration-inkai.md](1.2.15-decoration-inkai.md#4-test-levels--types).

## 6. Kỹ thuật thiết kế test case

- **Equivalence Partitioning:**
  - Thời điểm mở Discover: {máy chưa có dữ liệu mẫu (skeleton hiện) · đã có dữ liệu (không skeleton)}.
  - Mạng khi tải Discover: {bình thường · Very Bad Network · offline hoàn toàn (note không cover — mục 11 gap
    #3)}.
  - Số item trong 1 hàng skeleton: không có case biên nào trong note — mặc định coi skeleton cố định 3-4 tile
    giả, không phụ thuộc dữ liệu thật (vì lúc này chưa có dữ liệu) — verify giả định này đúng.
  - Ngày trong tháng khi test widget (mục 6): {đầu tháng · **giữa tháng** (note yêu cầu) · **cuối tháng** (note
    yêu cầu) · qua tháng mới (không có trong note, xem mục 11)}.
  - Trạng thái shortcut khi mở lại hướng dẫn (mục 4): {chưa từng cài · đã cài, còn hạn 48h · đã cài, hết hạn
    48h, còn trong Shortcuts app · đã cài, hết hạn 48h, đã xoá khỏi Shortcuts app · đã cài, đã xoá, còn hạn
    48h}.
- **Boundary Value Analysis:**
  - Ngưỡng 48 giờ (mục 4): test tại 47h59, 48h00, 48h01 — note chỉ nói "chỉnh giờ tiến 3 ngày", không có ca
    tại đúng biên; **cần bổ sung case biên chính xác**, không chỉ test 1 điểm xa biên (3 ngày) như note gợi ý.
  - Thời lượng hiện skeleton dưới Very Bad Network: "tối đa ~5 giây" — test tại ~4s (phải còn hiện được nếu
    mạng thực sự rất chậm) và tại điểm skeleton biến mất (phải đúng lúc feed thật đã sẵn sàng, không phải hết
    giờ đếm ngược).
  - Multi-day event (mục 6): event bắt đầu **đúng ranh giới** — hôm qua tới hôm nay, và hôm nay tới ngày mai —
    cả 2 đều phải hiện trên widget hôm nay.
- **Decision Table 1 — Skeleton: title/description theo hàng (mục 1)**

  | Hàng | Có title tile? | Có dòng mô tả? |
  |---|---|---|
  | Lockscreen | Không | Không |
  | Note Lockscreen | Không | Không |
  | Live Activities | Có | Có |
  | Widgets | Có | Có |

  → Đây là ma trận **bất đối xứng theo đúng thiết kế của note**, không phải lỗi — nếu Lockscreen/Note
  Lockscreen vô tình hiện title/description (hoặc ngược lại), đó là bug, không phải "cải thiện thừa".

- **Decision Table 2 — Re-open Setup shortcut theo ngưỡng 48h (mục 4)**

  | Đã cài trước đó? | Chạy thành công trong 48h? | Còn tồn tại trong Shortcuts app? | Kết quả kỳ vọng |
  |---|---|---|---|
  | Không | – | – | Luôn kiểm tra đầy đủ như user mới |
  | Có | Có | Có | Nút "I've added the shortcut" → thẳng Automation, không mở Shortcuts |
  | Có | Có | **Không** (đã xoá) | **Vẫn cho qua** — thiết kế chủ đích, không log bug |
  | Có | Không | Có | Nút "I've added it — check now" → chạy Shortcuts → "Shortcut is working!" → Automation |
  | Có | Không | **Không** (đã xoá) | Lỗi "We couldn't confirm the shortcut ran…", có Try again/Re-add, **không** tự sang Automation |

  → 5 dòng, khớp đúng 5 bullet của mục 4 note — dùng bảng này làm checklist thực thi trực tiếp, không cần
  diễn giải lại.

- **Decision Table 3 — CTA tile trong collection theo loại + trạng thái (mục 2, đối chiếu mục 2.1)**

  | Loại tile | Đang active? | CTA kỳ vọng |
  |---|---|---|
  | Lockscreen/Live Activity/Widget | Có | Không nêu rõ trong note — quan sát thực tế, khả năng "Update" theo pattern cũ |
  | Lockscreen/Live Activity/Widget | Không | "Set as..." (pattern cũ, note không đổi) |
  | Note | Có | Note không nói rõ — verify không còn là "Edit" (mục 2.1) |
  | Note | Không | **"Set as current"** (đổi từ "Edit" cũ) |

- **State Transition Testing:**
  - Banner: `chưa bấm gì → bấm ✕ [ẩn banner, không hiện lại phiên này] | bấm banner [mở màn giải thích] →
    chưa cuộn hết [I understand mờ, không bấm được] → cuộn hết [mũi tên ẩn, I understand sáng] → cuộn ngược lên
    [I understand vẫn sáng] → bấm I understand [đóng màn, banner không hiện lại vĩnh viễn]`.
  - Setup shortcut (đã cài, còn hạn 48h): `mở lại hướng dẫn → bấm "I've added the shortcut" → [Automation]`.
  - Setup shortcut (đã cài, hết hạn, còn shortcut): `mở lại hướng dẫn → bấm "check now" → Shortcuts chạy →
    quay lại Ink → ["Shortcut is working!"] → [Automation]` — nhánh phụ: iOS hỏi quyền đặt hình nền giữa chừng,
    chọn Allow → tiếp tục transition bình thường; chọn Don't Allow → **note không mô tả nhánh này** (mục 11).
  - Collection tile Note: `không active + CTA "Set as current" → bấm → [lock screen đổi sang note, giữ ảnh nền
    note, tile chuyển active]`.
  - Notes style switcher: `text → bullet → số → checklist → text → [nội dung chữ không đổi qua toàn bộ chuỗi]`
    — test đúng chuỗi vòng tròn note mô tả, không chỉ 1 lần đổi.
- **Exploratory testing (session-based, time-boxed):**
  - Xoay máy đúng lúc skeleton đang chuyển sang feed thật (note chỉ gợi ý "quay màn hình nếu cần" như 1 cách
    quan sát, chưa chắc đã test kỹ transition giữa 2 orientation).
  - Thoát app / kill app giữa lúc đang ở màn giải thích banner (đã cuộn một phần) — mở lại có giữ vị trí cuộn
    không, *I understand* có đúng trạng thái không.
  - Đổi kiểu text trong Notes liên tục rất nhanh (bullet→số→bullet→checklist...) trong khi bàn phím đang gõ dở
    — note chỉ test đổi kiểu tuần tự có dừng gõ, không test đổi dồn dập.
  - Widget Home Screen với lịch **rất ít event** (đối lập với chuẩn bị ">60 event" của note) — không có case
    nào cho trường hợp ngược lại (calendar gần trống).

## 7. Risk-based prioritization

> **Mapping severity** ([bugs/bug-log.md](../../bugs/bug-log.md)): P1 → Critical/High, P2 → Medium, P3 → Low.
> Đây là độ ưu tiên **test**, không phải severity bug tự động.

**P1 — chặn luồng chính / sai dữ liệu hiển thị cốt lõi:**
- Mục 4, Decision Table 2 — toàn bộ 5 nhánh re-open shortcut, đặc biệt nhánh "đã xoá + hết hạn" phải báo lỗi
  đúng (không được im lặng tự cho qua, cũng không được crash/kẹt).
- Mục 6 — widget hiện sai/thiếu event hôm nay, đặc biệt giữa/cuối tháng (bug gốc note đang fix, phải xác nhận
  hết hẳn, không chỉ giảm tần suất).
- Mục 7 — Live Activity biến mất rồi hiện lại khi qua ngày mới (regression của đúng bug note nói đã sửa).
- Mục 2.1 — CTA `Edit` cũ của tile Note **không được sót lại** ở bất kỳ trạng thái nào (rủi ro nửa vời: đổi
  UI mới nhưng code cũ vẫn có đường gọi tới hành vi Edit).
- Điểm giao 2 PR ở mục 4 (carousel #225 × logic 48h #218 chạy chung 1 luồng) — theo đúng nguyên tắc merge-risk
  đã dùng ở note trước.

**P2:**
- Mục 1 — skeleton→feed thật giật vị trí (đặc biệt Larger Text) — ảnh hưởng usability, không mất dữ liệu.
- Mục 2 — tab Widget hiện sai widget (không đúng "đang thật sự đặt trên Home Screen") — sai thông tin nhưng
  không phá luồng chính.
- Mục 3 — banner/explainer sai trạng thái nút (mờ/sáng nhầm lúc) — cản trở nhưng có thể thoát ra được.
- Mục 5 — Notes: mất nội dung khi đổi kiểu text — nếu xảy ra, đây thực chất là **data loss cùng lớp với
  BUG-001** dù ở màn khác, nên nâng lên theo dõi sát dù note không tự xếp priority.
- Mục 8 — sót chuỗi chưa dịch, hoặc lộ `**` — cosmetic nhưng lặp ở nhiều ngôn ngữ.
- Nghi vấn 48h vs 24h (mục 2.4) — nếu 2 ngưỡng dùng chung nguồn dữ liệu sai, ảnh hưởng cả 2 tính năng.

**P3:**
- Taxonomy "Note Lockscreen" (home) vs "Note trong tab Lockscreen" (collection) (mục 2.2) — không phải bug
  chức năng, chỉ là điểm dễ gây nhầm lẫn khi log bug/viết tài liệu, cần hỏi rõ 1 lần.
- Định dạng mốc thời gian "now → 3m → 2h → 2d" — cosmetic, verify đúng chuỗi format nhưng không chặn luồng.

## 8. Test environment matrix

- **Device:** iOS 17.x **và** iOS 26.x bắt buộc cả 2 — note không miễn trừ; iPhone màn nhỏ (SE-class) **và**
  Pro Max bắt buộc cả 2 (rủi ro cao nhất ở banner 2-dòng, mục 3).
- **Ngôn ngữ:** English, Tiếng Việt, 1 ngôn ngữ CJK (ja/ko/zh) cho toàn bộ case; riêng mục 8 (popup đặt hình
  nền) mở rộng đủ **4 biến thể CJK**: ja, ko, zh, zh-Hant.
- **Dữ liệu chuẩn bị trước:**
  - Máy sạch (xoá app, cài lại) — bắt buộc cho mục 1, không thể tái dùng máy đã có dữ liệu mẫu.
  - Network Link Conditioner — Very Bad Network, cho mục 1.
  - Lịch có >60 event trong tháng, test đúng giữa/cuối tháng theo lịch thật của ngày chạy test — cho mục 6.
  - Ít nhất 1 Live Activity mẫu dạng timeline đang chạy qua nửa đêm — cho mục 7.
  - Shortcut đã cài + kịch bản đổi giờ hệ thống (nhớ tắt/bật lại Set Automatically, note tự nhắc) — cho mục 4;
    xem mục 2.3 về rủi ro phương pháp.
- **Entry point cần xác nhận trước khi test mục 5:** Notes tab (`07_note` S02) hay 1 màn khác — xem mục 11 gap
  #6, không giả định.

## 9. Entry criteria

- Build dựng từ `main`, xác nhận chứa **cả 2** commit merge của PR #218 (16/09) và PR #225 (17/09), tính từ
  `78dec0aa` trở đi — verify hash thật, không giả định theo ngày merge.
- Máy sạch sẵn sàng cho mục 1 (chưa cài Ink hoặc đã xoá dữ liệu mẫu).
- Lịch test đã có ≥60 event, đúng thời điểm giữa/cuối tháng khi bắt đầu mục 6.
- Có sẵn tối thiểu: 1 máy iOS 17.x, 1 máy iOS 26.x, 1 máy màn nhỏ, 1 máy Pro Max (có thể trùng nếu đủ 4 tổ hợp
  qua nhiều máy).

## 9.1 Suspension & Resumption criteria

- **Suspend cục bộ mục 4:** nếu phát hiện việc chỉnh giờ hệ thống làm automation ngừng chạy hẳn (không chỉ
  ngưỡng 48h mà toàn bộ shortcut không tự chạy nữa) → dừng ngay nhánh test dùng đồng hồ hệ thống, chuyển hoàn
  toàn sang chờ thời gian thật hoặc escalate hỏi dev cách mock ngưỡng 48h an toàn hơn (mục 2.3). Đây là rủi ro
  đã được cảnh báo trước trong `exploratory/03_shortcut-setup.md`, không phải phát hiện bất ngờ.
- **Suspend toàn cụm mục 6/7:** nếu event hiển thị sai một cách không nhất quán giữa các lần mở app (không lặp
  lại được) → khả năng cao là vấn đề fetch/cache nguồn dữ liệu (đối chiếu class lỗi đã ghi ở BUG-004), tạm dừng
  để tránh log trùng, chuyển hướng điều tra sang đúng root cause đã biết trước khi tiếp tục script case mới.
- **Resume:** sau khi có xác nhận/patch, chạy lại từ đầu cụm đã suspend, không tiếp tục giữa chừng.
- Mục 1/2/3/5/8 không có điều kiện suspend riêng — bug ở đây log bình thường theo severity, không chặn khả
  năng test các mục khác.

## 10. Exit criteria

- 100% checklist mục 1–8 của note gốc đã tick pass hoặc có bug kèm severity.
- 0 bug P1 mở, đặc biệt: cả 5 nhánh Decision Table 2 (mục 4) đã verify đúng, event widget/live-activity đã hết
  sai lệch tại giữa/cuối tháng và qua nửa đêm (mục 6, 7).
- CTA `Edit` cũ của tile Note xác nhận không còn sót ở bất kỳ trạng thái nào (mục 2.1).
- L10n sạch cho English/Tiếng Việt/1 CJK ở mọi case, và đủ 4 biến thể CJK riêng cho popup đặt hình nền (mục 8).
- Các câu hỏi mở ở mục 11 #1 (taxonomy Note), #2 (48h vs 24h), #6 (entry point Notes) đã có câu trả lời bằng
  văn bản từ dev/PO trước khi sign-off; nếu chưa, ghi nhận là gap đã biết, không tự coi là pass.

## 11. Gap cần làm rõ trước khi execute

1. **Taxonomy "Note Lockscreen" (home) vs "Note trong tab Lockscreen" (collection)** (mục 2.2) — 2 cách phân
   loại khác nhau cho cùng loại nội dung, chưa xác nhận là chủ ý.
2. **Ngưỡng 48h (mục 4) có liên quan gì tới ngưỡng 24h đã ghi nhận trước đó** cho "wallpaper quá cũ" không
   (mục 2.4) — cùng đơn vị đo, khác mục đích, chưa rõ có dùng chung nguồn timestamp hay không.
3. **Hành vi Discover khi offline hoàn toàn** (không chỉ Very Bad Network) — note chỉ test mạng chậm, không có
   case mất mạng hẳn trong lúc tải skeleton.
4. **Carousel demo clip có âm thanh không, có tự phát không khi vào màn** — note không mô tả, ảnh hưởng cách
   viết case usability (mục 5, Test levels & types).
5. **Nhánh iOS từ chối quyền đặt hình nền giữa lúc re-verify shortcut** (mục 4, khi "check now" đang chạy) —
   note chỉ nói "nếu iOS hỏi quyền đặt hình nền, chọn cho phép", không mô tả nếu user chọn từ chối.
6. **Entry point chính xác của mục 5 (Notes: grid/list, đổi kiểu text)** — cần xác nhận đây là tab Notes
   (`07_note` S02, editor phẳng) chứ không phải note-làm-lock-screen (`04_discover` S09, nơi có BUG-001) — 2
   màn cùng tên "note" nhưng khác hẳn (mục 2.5).
7. **CTA mặc định của tile Lockscreen/Live Activity/Widget đang active** — note mục 2 chỉ mô tả rõ ràng cho
   Note tile; 3 loại còn lại suy đoán theo pattern cũ ("Update") nhưng không được note xác nhận lại (Decision
   Table 3).

## 12. Coverage gap — case chưa được note liệt kê

| Thiếu | Vì sao là gap |
|---|---|
| Skeleton khi mất mạng hoàn toàn (không phải chỉ chậm) | Note chỉ chuẩn bị Very Bad Network, không có kịch bản offline thật |
| Test case tại đúng biên 48h (47h59/48h00/48h01) | Note chỉ đề xuất test tại điểm xa biên (chỉnh giờ tiến 3 ngày) |
| Qua tháng mới khi đang xem widget (31 → 1) | Note chỉ yêu cầu test giữa/cuối tháng, không có case xuyên qua ranh giới tháng |
| Regression BUG-001/BUG-002 tại Notes tab | Không nằm trong phạm vi chính thức của note, nhưng cùng vùng code lân cận theo tiền lệ `07_note.md` (mục 2.5) |
| VoiceOver cho toàn bộ carousel demo-clip mới (mục 4) | Note chỉ có case VoiceOver cho skeleton (mục 1), không có cho carousel |
| Hành vi khi từ chối quyền đặt hình nền lúc re-verify shortcut | Note chỉ mô tả nhánh "chọn cho phép" (gap #5 ở mục 11) |
| Nhiều Live Activity chạy đồng thời qua nửa đêm | Note chỉ test 1 Live Activity mẫu, không rõ hành vi khi có ≥2 cái |
| Notes: đổi kiểu dồn dập liên tục trong lúc gõ | Note chỉ test đổi kiểu tuần tự, có dừng gõ giữa mỗi lần |
