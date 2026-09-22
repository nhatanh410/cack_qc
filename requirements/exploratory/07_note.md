# Exploratory Checklist — 07 Note

> **Nguồn:** [wireframe](../ui/ux/wideframes/07_note.md) · 4 screenshot (S01 list + S02 create, editor **trắng trơn**)
> — ⚠️ wireframe **không có** màn chọn template ảnh, chế độ sắp xếp khối chữ, font picker, hay preview panel
> mới. Mọi mục liên quan mục 3–5 của [QC-uiux-9sep.md](../specs/uiux-9sep/QC-uiux-9sep.md) dưới đây dùng **trực tiếp mô
> tả text của change note làm bằng chứng thay thế** — chưa có ảnh nào xác nhận hình dạng UI thật. Xem cảnh
> báo đầy đủ ở §0.
> **Khung đánh giá:** [exploratory-references](../../references/exploratory-references.md)
> **Bug đã biết cùng khu vực:** [BUG-001](../../bugs/bug-log.md#bug-001--nút--đóng-màn-edit-nhưng-note-không-được-lưu) · [BUG-002](../../bugs/bug-log.md#bug-002--lockscreen-dạng-note-hiển-thị-tên-untitled-trong-your-collection)
> **Risk/priority:** đối chiếu [test plan 1.2.15](../test-plans/uiux-9sep/1.2.15-uiux-9sep.md) mục 6 — case đánh P1 gắn 🔴 ở đây.
> **Build:** TestFlight 1.2.15, PR #179 (build number chưa xác định) · **Thiết bị:** ____________ · **Người test:** ____________

---

## 0 · Framing

**Q1 — Mục tiêu user của flow này:** ghi chú nhanh, và (mới từ 1.2.15) **biến note thành hình nền cá nhân
hoá** bằng cách đặt/kéo/xoay khối chữ lên một template ảnh, rồi đưa lên lock screen / widget / Live Activity.

**Q8 — Mục tiêu business:** Note trở thành **nguồn wallpaper thứ 2** ngoài Calendar/Matrix — mở rộng đúng giá
trị cốt lõi "biến dữ liệu cá nhân thành lock screen" sang một loại dữ liệu mới.

**Rủi ro xuyên suốt chạm vào flow này:**
- [exploratory-references §1.2](../../references/exploratory-references.md#12--lock-screen-là-ảnh-tĩnh-dữ-liệu-cũ-tới-mức-nào-là-chấp-nhận-được) — note dùng làm wallpaper chịu chung rủi ro dữ liệu cũ
- [exploratory-references §1.5](../../references/exploratory-references.md#15--bốn-cửa-vào-một-dữ-liệu-có-nhất-quán-không) — giờ có **4 cửa** cho cùng 1 note đã sắp xếp: card danh sách, lock screen, widget, Live Activity — note 3.7 chỉ nói 3 cửa, xem NOT-Q06

**⚠️ Cảnh báo nguồn — đọc trước khi chạy, đây là điểm chặn quan trọng nhất của checklist này:**

1. **Entry point thật của tính năng mục 3–5 chưa xác định.** Theo [bug-log.md](../../bugs/bug-log.md), đã từng
   có 1 màn hình "note dùng template giấy (paper/receipt style, có checklist/washi tape/barcode)" được chụp
   qua luồng **Discover → Lockscreen → chọn category Note** — khác hoàn toàn với S02 (editor trắng trơn) của
   wireframe 07_note. Rất có thể change note mục 3 ("mở note dùng template ảnh") đang nói **đúng màn hình đó**,
   nghĩa là **entry point có thể nằm ở Flow 04_discover, không phải bấm `+` trong tab Notes**. Xem **NOT-Q01**
   — cần trả lời trước khi chạy bất kỳ case nào ở §1–§3 bên dưới.
2. **2 bug đang Open cùng khu vực UI:** BUG-001 (nút ✓ không lưu note dạng template, mất trắng nội dung) và
   BUG-002 (note lưu vào collection luôn hiện tên `(Untitled)`). Change note PR #179 không nhắc tới 2 bug
   này dù sửa rất nhiều ở đúng khu vực đó — **bắt buộc regression lại cả hai**, xem NOT-N01/N02.
3. Toàn bộ ảnh gốc của BUG-001/002 **chưa được lưu vào repo** (ghi trong bug-log) — nếu chụp lại được lúc
   test, nên export theo đúng tên đề xuất trong bug-log và cập nhật `04_discover` index, không phải `07_note`.

---

## 1 · Happy path — `NOT-H`

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **NOT-H01** | Mở tab Notes lần đầu, chưa có note | S01 empty: *"Click '+' to create your first note"* | — | ☐ |
| **NOT-H02** | Bấm `+`, gõ Title + nội dung | S02 editing — nút ✓ **luôn enabled** kể cả note rỗng (khác Task, vốn bắt buộc Title) | — | ☐ |
| **NOT-H03** | Lưu note (bấm ✓) từ editor **trắng trơn** (S02, không phải template ảnh) | Note xuất hiện ở S01 filled | — | ☐ |
| **NOT-H04** | Chọn 1 template ảnh cho note *(note 4.1)* | Chỉ còn **một** màn chọn duy nhất (màn quick-pick cũ đã bỏ), áp dụng template đúng | — | ☐ |
| **NOT-H05** | Vào chế độ sắp xếp trên note dùng template ảnh, chạm chọn khối, kéo di chuyển *(note 3.1)* | Khối di chuyển theo tay | — | ☐ |
| **NOT-H06** | Chụm 2 ngón phóng to/thu nhỏ khối *(note 3.1)* | Khối scale theo | — | ☐ |
| **NOT-H07** | 2 ngón xoay khối *(note 3.1)* | Khối xoay theo | — | ☐ |
| **NOT-H08** | Kéo góc khối để scale bằng 1 tay *(note 3.1)* | Khối scale theo, không cần 2 ngón | — | ☐ |
| **NOT-H09** | Trong chế độ sắp xếp, chạm vào chữ *(note 3.2)* | **Không** hiện bàn phím — chế độ sắp xếp tạm ngưng gõ chữ | — | ☐ |
| **NOT-H10** | Chạm vùng ảnh trống *(note 3.3)* | Bỏ chọn khối đang chọn | — | ☐ |
| **NOT-H11** | Thu nhỏ khối tiêu đề *(note 3.5, lỗi cũ vừa sửa)* | Chữ co lại theo khung, không tràn ra ngoài | — | ☐ |
| **NOT-H12** | Thu nhỏ khối nội dung *(note 3.6)* | Hành xử giống khối tiêu đề | — | ☐ |
| **NOT-H13** | Sắp xếp xong, thoát, mở lại note *(note 3.7)* | Khối nằm đúng chỗ đã đặt | — | ☐ |
| **NOT-H14** | Xem note đã sắp xếp ở **card danh sách**, **hình nền khoá**, **Live Activity** *(note 3.7, P1)* | Khối nằm đúng chỗ ở **cả 3 nơi** — xem decision table ở [test plan §5](../test-plans/uiux-9sep/1.2.15-uiux-9sep.md#5-kỹ-thuật-thiết-kế-test-case) | — | ☐ |
| **NOT-H15** | Mở danh sách font *(note 4.3)* | Mỗi tên font hiển thị **bằng chính font đó** | — | ☐ |
| **NOT-H16** | So font ở editor note và editor hình nền *(note 4.4)* | Cùng 1 font trông giống nhau ở cả 2 nơi | — | ☐ |
| **NOT-H17** | Mở preview hình nền từ 1 note *(note 5.1)* | Header giống các màn preview khác, không tự vẽ riêng | — | ☐ |
| **NOT-H18** | Xem bảng điều khiển preview *(note 5.2)* | Panel **cố định 2 tab** (Background/Layout), không còn sheet kéo lên/xuống | — | ☐ |

---

## 2 · Negative — `NOT-N`

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **NOT-N01** | *(Kéo từ BUG-001)* Nhập Title + checklist item vào note dạng template ảnh, bấm nút ✓ | Note được lưu — quay về với note hiện trong list/collection, hoặc có confirm trước khi đóng | Màn đóng ngay, không lưu gì, mất trắng nội dung — **BUG-001 đang Open**, bắt buộc test lại vì PR #179 đổi nhiều ở đúng khu vực này | 🔴 | ☐ |
| **NOT-N02** | *(Kéo từ BUG-002)* Lưu note dạng template vào collection | Tên hiển thị có ý nghĩa (do user đặt hoặc fallback từ nội dung) | Hiện `(Untitled)` — **BUG-002 đang Open** | 🟠 | ☐ |
| **NOT-N03** | Xoay nghiêng khối tiêu đề, kéo về sát góc ảnh *(note 3.4, P1)* | Góc khối **không thò ra ngoài ảnh** (tính theo khung bao sau khi xoay) | Khối tràn biên, xuất hiện cắt xấu trên wallpaper thật | 🔴 | ☐ |
| **NOT-N04** | Mở lại note **tạo từ trước bản 1.2.15** (trước fix cỡ chữ +1pt) *(note 3.8, P1)* | Chữ to hơn 1pt so với bản cũ — đúng — nhưng **không bị cắt/tràn khung** ở cả 3 nơi (card/hình nền/Live Activity) | Note cũ bị cắt chữ hàng loạt — cần chuẩn bị note cũ **trước khi update** app, xem [test plan §7](../test-plans/uiux-9sep/1.2.15-uiux-9sep.md#7-test-environment-matrix) | 🔴 | ☐ |
| **NOT-N05** | Trong màn chọn template đã hợp nhất *(note 4.1)*, tìm lại thao tác "chọn nhanh" kiểu cũ | Không còn tồn tại, không có nút chết/đường cụt sót lại từ màn cũ | Nút cũ vẫn còn nhưng dẫn tới màn hỏng | 🟡 | ☐ |
| **NOT-N06** | Ở màn preview mới *(note 5.2)*, thử kéo panel lên/xuống như thói quen cũ (sheet kéo được) | Không phản ứng — giờ là panel cố định, không phải cử chỉ thừa gây nhầm | Panel phản ứng nửa vời, trông như bug | 🟡 | ☐ |

---

## 3 · Edge — `NOT-E`

| ID | Tình huống | Câu hỏi | Mức | ☐ |
|---|---|---|:---:|:---:|
| **NOT-E01** | Kéo/xoay/scale sai, tìm nút Undo | Có Undo không? *(coverage gap — không có trong note, xem NOT-Q)* | 🟡 | ☐ |
| **NOT-E02** | 2 khối chữ chồng lên nhau sau khi kéo | Khối nào nhận chạm trước (z-order)? *(coverage gap)* | 🟡 | ☐ |
| **NOT-E03** | Bật VoiceOver, thử thao tác chế độ sắp xếp | Có cách nào thay thế thao tác đa chạm (kéo/xoay/scale) cho user khiếm thị không, hay tính năng này **hoàn toàn không dùng được** qua VoiceOver? *(coverage gap)* | 🟠 | ☐ |
| **NOT-E04** | Bật Dynamic Type cỡ chữ **lớn nhất**, tạo note mới dùng template ảnh (chưa từng sắp xếp) | Khối mặc định có tràn khung ngay từ đầu không? *(coverage gap)* | 🟠 | ☐ |
| **NOT-E05** | Kill app giữa lúc đang kéo/xoay 1 khối (chưa thoát chế độ sắp xếp) | Thao tác dở dang có mất không, hay giữ nguyên? | 🟡 | ☐ |
| **NOT-E06** | Bật Dark Mode, mở màn preview mới *(note 5)* | Panel 2 tab, header còn đủ tương phản chữ? *(coverage gap)* | 🟡 | ☐ |
| **NOT-E07** | Font đã dùng trong note cũ không còn khả dụng trên máy *(nếu giả lập được)* | Note cũ hiển thị fallback gì? *(coverage gap, cần hỏi dev cách giả lập)* | 🟡 | ☐ |
| **NOT-E08** | Nhập ký tự đặc biệt/emoji/tiếng Việt có dấu dài trong khối chữ đã sắp xếp | Không vỡ layout, không tràn khung? | 🟡 | ☐ |
| **NOT-E09** | **iPad** — mở preview *(note 5.3, bug đã biết, P2)*, xoay ngang/dọc **nhiều lần liên tiếp** | Ảnh vẽ lại đúng theo chiều mới mỗi lần, không kẹt layout cũ? Bắt buộc test trên máy thật | 🟠 | ☐ |
| **NOT-E10** | Header kính *(từ note 1.2.15 mục 1)* hiện trên màn preview/editor note | Nút tròn cùng chất liệu kính, không có nút trắng lạc giữa hàng? *(liên hệ chéo — cùng màn hình nên tiện test luôn)* | 🟡 | ☐ |

---

## 4 · Coverage matrix

| Vùng | State cần phủ | Đã chạm |
|------|---------------|:-------:|
| Note cơ bản (editor trắng trơn) | list empty · filled · create default · editing *(đã có ảnh)* | ☐ |
| Xem/sửa note đã tạo (tap vào card) | **chưa có ảnh** — wireframe tự ghi "Possible missing screen" | ☐ |
| Xoá note | **chưa có ảnh** | ☐ |
| Note list khi có nhiều note (1 cột hay 2 cột) | **chưa có ảnh** | ☐ |
| Template ảnh cho note | màn chọn template · chế độ sắp xếp · chọn/kéo/xoay/scale khối | **hoàn toàn chưa có ảnh** |
| Font picker | danh sách font | **chưa có ảnh** |
| Preview panel mới | 2 tab Background/Layout | **chưa có ảnh** |
| iPad | toàn bộ mục 3/4, và mục 5.3 (orientation) | **chưa có ảnh** |
| Dark Mode | toàn bộ flow | **chưa có ảnh** |
| BUG-001 / BUG-002 | ảnh gốc | **chưa lưu vào repo** (ghi trong bug-log) |

---

## 5 · Câu hỏi cần PO/dev trả lời — `NOT-Q`

| ID | Câu hỏi |
|---|---|
| **NOT-Q01** | 🔴 **Chặn toàn bộ checklist này:** tính năng "kéo/xoay khối chữ trên template ảnh" (mục 3) vào từ đâu — trực tiếp trong tab Notes (Flow 07), hay vẫn qua Discover → Lockscreen → chọn category Note (như BUG-001/002 mô tả)? |
| **NOT-Q02** | BUG-001 và BUG-002 đã được sửa trong PR #179 chưa? Change note không nhắc tới 2 bug này dù cùng khu vực UI. |
| **NOT-Q03** | Giới hạn scale min/max cho khối chữ là bao nhiêu? (đã hỏi ở [test plan §10.2](../test-plans/uiux-9sep/1.2.15-uiux-9sep.md#10-gap-cần-làm-rõ-trước-khi-execute)) |
| **NOT-Q04** | Rotation có snap về góc cố định (0/90/180/270°) không, hay xoay tự do hoàn toàn? |
| **NOT-Q05** | Khi khối chạm biên ảnh — snap lại vị trí hợp lệ, chặn cứng, hay cho phép rồi tự sửa khi buông tay? |
| **NOT-Q06** | Notes có Home Screen widget riêng không? Vì sao note 3.7 chỉ liệt kê 3 bề mặt (card/lock screen/Live Activity) mà không có widget? |
| **NOT-Q07** | Nút ✓ ở S02 (editor trắng trơn) — wireframe tự hỏi note rỗng có lưu được không, đã có câu trả lời chưa? |
| **NOT-Q08** | Nút phụ bên phải toolbar ở S02 (icon khác nhau giữa `default`/`editing`) — 1 nút đổi ngữ cảnh hay 2 nút khác nhau? *(wireframe tự flag, chưa có câu trả lời)* |

---

## 6 · Smoke 15 phút cho flow này

1. Xoay khối tiêu đề sát góc ảnh, kiểm tra không thò ra ngoài. *(3 phút, 🔴 P1)*
2. Sắp xếp 1 khối, xem lại ở cả 3 nơi (card/lock screen/Live Activity), khớp vị trí không. *(4 phút, 🔴 P1)*
3. Mở 1 note tạo từ bản cũ (trước 1.2.15), kiểm tra không bị cắt chữ sau khi tăng cỡ +1pt. *(3 phút, 🔴 P1)*
4. Lặp lại repro BUG-001 (note dạng template, nhập nội dung, bấm ✓) — xác nhận còn lỗi hay đã sửa. *(3 phút, 🔴)*
5. Thu nhỏ khối nội dung, xác nhận chữ co theo khung không tràn. *(2 phút)*

---

## 7 · Kết luận phiên

```
Phiên: __________            Build: 1.2.15 (____)      Thiết bị: __________

Q1 Mục tiêu user:            ______________________________
Q8 Mục tiêu business:        ______________________________
— Chạy luồng chính —
Q2 Xong dễ lần đầu?          Có / Không — vì: __________
Q3 Điểm khựng/bối rối:       ______________________________
Q4 Thao tác sai / gián đoạn: ______________________________
Q5 State chưa test:          ______________________________
— Kết luận —
Q6 Rủi ro #1 nếu ship:       ______________________________
Q7 Tự mình dùng hằng ngày?   Có / Không — vì: __________
Q9 15 phút thì test gì:      ______________________________

=> Verdict: 🟢 ship được / 🟡 ship có điều kiện / 🔴 chưa nên ship
   Bằng chứng: ______________________________
```
