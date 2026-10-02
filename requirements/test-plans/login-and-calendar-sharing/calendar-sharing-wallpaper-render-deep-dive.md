# Test Design (đào sâu) — Scope B / Capstone: Shared Events → Wallpaper Render

> **Thuộc:** [calendar-sharing-deep-dive.md](calendar-sharing-deep-dive.md) (index). Đây là **file gộp cuối
> cùng** của chuỗi phân tích Scope B — theo đúng mục tiêu đã nêu: toàn bộ Login (Scope A) + Owner/Receiver +
> Data Sync + Event-level Interaction đều là **chuẩn bị dữ liệu** cho giai đoạn quan trọng nhất — dùng event đã
> nhận qua share để **render ra wallpaper** trên Lock Screen của Receiver.
> **Test basis:** không có tài liệu sharing nào đề cập giai đoạn này (đã xác nhận ở
> [calendar-sharing-event-interaction-deep-dive.md](calendar-sharing-event-interaction-deep-dive.md) mục 1.7).
> File này đọc thêm [wallpaper-component-editor-prd.md](../../specs/wallpaper-editor/component-editor/wallpaper-component-editor-prd.md)
> (spec renderer/editor wallpaper) để xác nhận: tài liệu đó **cũng không** nhắc calendar nào cấp dữ liệu cho
> renderer — chỉ nói về layout/style của "band" (`monthGrid`, `weekEvents`, `todayList`, `hourTimeline`…).
> **Kết luận nền tảng:** đây là **pipeline chưa từng được thiết kế ở tầm sản phẩm** (không phải chỉ thiếu vài
> chi tiết như các file trước) — nên phần lớn nội dung dưới đây là **câu hỏi cần trả lời trước khi code**, không
> phải case sẵn sàng chạy trên build hiện tại.
> **Ngày lập:** 2026-09-18 · **Người lập:** QC

---

## 1. Cổng vào — phải xác nhận tính năng NÀY có tồn tại/được lên kế hoạch không

Trước khi đọc phần còn lại: **TC-EVT-16** (`calendar-sharing-event-interaction-deep-dive.md`) đã là case xác
nhận gốc — "lịch nhận qua share có xuất hiện trong danh sách nguồn khả dụng khi tạo wallpaper không". Mọi nội
dung từ mục 2 trở xuống **giả định câu trả lời là CÓ** để có cái phân tích; nếu câu trả lời thật là KHÔNG (Owner/
Receiver hoàn toàn tách biệt khỏi hệ thống wallpaper), toàn bộ mục 2–4 trở thành tài liệu tham khảo cho **lúc
tính năng này được đề xuất trong tương lai**, không phải backlog cần làm ngay.

## 2. Vì sao mỗi rủi ro đã tìm được trước đó trở nên NẶNG HƠN ở giai đoạn render

4 file deep-dive trước đều đã gắn P1/P2 cho từng rủi ro ở đúng ngữ cảnh của nó (list view, JSON payload, event
detail…). Khi dữ liệu đó tiếp tục đi vào renderer để in lên 1 **ảnh tĩnh trên Lock Screen** — bề mặt hiển thị
liên tục, dễ thấy nhất của cả chiếc điện thoại — mức độ nghiêm trọng của từng rủi ro tăng lên rõ rệt:

| Rủi ro gốc | Nguồn | Vì sao nặng hơn khi render thành wallpaper |
|---|---|---|
| Timezone/all-day sai giờ (mục 1.5, data-sync) | `calendar-sharing-data-sync-deep-dive.md` | Giờ sai bị **in cứng vào ảnh**, hiển thị liên tục trên Lock Screen tới lần render kế — không phải lỗi thoáng qua khi mở app |
| Recurring event propagate sai (mục 1.3, data-sync) | như trên | 1 event recurring sai có thể lặp lại **hàng tuần** trên wallpaper nếu không ai để ý sửa |
| Toggle privacy (Notes/Locations OFF) không được enforce đúng | test plan chung, mục 4 (Security) | Renderer có thể đọc từ 1 tầng dữ liệu **khác** tầng đã lọc theo toggle (xem mục 3.1) — rủi ro leak **hiển thị công khai trên Lock Screen**, ai cầm máy Receiver lên cũng thấy, không cần mở app |
| Field `url` không nằm trong toggle nào (mục 1.3, event-interaction) | `calendar-sharing-event-interaction-deep-dive.md` | Nếu 1 part wallpaper (vd `todayList`) in cả link họp lên ảnh, mức độ lộ còn công khai hơn cả webview |
| `window` rolling, event bị rơi khỏi payload (mục 1.2, data-sync) | `calendar-sharing-data-sync-deep-dive.md` | Wallpaper có thể **im lặng mất 1 sự kiện** khỏi hiển thị mà Receiver không có cách nào biết đã từng có |
| Trigger sync "opportunity" không định nghĩa (mục 1.1, data-sync) | như trên | Giờ có thêm **tầng thứ 3**: (1) Owner publish theo opportunity, (2) Receiver app refresh theo opportunity, (3) **wallpaper tự regenerate theo lịch trình riêng của nó** (chưa biết là gì) — 3 tầng không đồng bộ cộng dồn độ trễ, Lock Screen có thể hiển thị lịch của vài ngày trước |

## 3. Rủi ro MỚI, chỉ xuất hiện ở đúng giai đoạn render

### 3.1 Renderer đọc dữ liệu từ tầng nào — đã lọc theo privacy toggle hay chưa?

`wallpaper-component-editor-prd.md` xác nhận renderer là `StackWallpaperRenderer`, vẽ trực tiếp vào `CGContext`
từ dữ liệu model đã có sẵn khi gọi — **không nói gì về nguồn dữ liệu**. Với lịch **owned**, hợp lý là renderer
đọc thẳng EventKit (đầy đủ mọi field, vì Owner có full quyền xem chính lịch của họ). Với lịch **shared/received**,
2 khả năng:

- **(a)** Ink ghi dữ liệu đã nhận (đã qua lọc theo toggle của Owner) vào **1 local calendar container riêng**
  (kiểu EventKit calendar nội bộ), để mọi code renderer sẵn có "dùng được ngay" mà không cần sửa gì — nếu đúng
  vậy, việc lọc theo toggle đã xảy ra **trước đó** (ở tầng sync), renderer chỉ đọc lại đúng những gì đã lọc, an
  toàn.
- **(b)** Ink giữ dữ liệu shared calendar ở 1 tầng model **riêng**, và renderer (hoặc lớp binding giữa renderer
  và dữ liệu) phải tự biết cách lọc theo toggle **lần thứ hai** tại thời điểm render — nếu lớp này quên áp lại
  đúng rule (vd hiển thị `notes`/`location` dù Owner đã tắt), đây là rủi ro leak **độc lập** với rủi ro đã tìm
  ở webview/in-app, vì đường dữ liệu hoàn toàn khác.

Không tài liệu nào xác nhận (a) hay (b) — đây là câu hỏi kỹ thuật quan trọng nhất của toàn file này.

### 3.2 Refresh cadence của wallpaper — tầng trigger thứ 3, chưa ai biết là gì

Ngoài "Owner publish khi có opportunity" và "Receiver app refresh khi có opportunity" (đã nêu ở
`calendar-sharing-data-sync-deep-dive.md` mục 1.1), wallpaper Lock Screen của iOS thường tự cập nhật theo lịch
trình riêng (widget timeline, background refresh của chính tính năng wallpaper — không nằm trong phạm vi 4 tài
liệu sharing). Nếu tính năng dùng shared calendar làm nguồn được xác nhận tồn tại, cần làm rõ: wallpaper có tự
regenerate khi shared calendar có update mới không, hay chỉ regenerate theo lịch trình gốc (vd đổi ngày lúc nửa
đêm) — độc lập với việc dữ liệu bên dưới đã đổi từ bao giờ.

### 3.3 Wallpaper là ẢNH TĨNH — dữ liệu sai bị "đóng băng" cho tới lần render kế

Khác list view (tự làm mới khi mở lại), wallpaper là 1 file ảnh đã render sẵn. Bất kỳ lỗi nào ở mục 2 (giờ sai,
recurring sai, event bị rơi khỏi window) sẽ **giữ nguyên trên Lock Screen** liên tục tới lần regenerate kế tiếp
— không có cơ hội "tự sửa" khi user mở app như các bề mặt khác.

### 3.4 Không có attribution nào cho biết đây là lịch của người khác

Không tài liệu nào (cả 4 file sharing lẫn wallpaper PRD) nói wallpaper có hiển thị "Shared by Alex" hay bất kỳ
dấu hiệu nào cho biết dữ liệu đang hiển thị **không phải lịch của chính Receiver**. Nếu render y hệt lịch sở
hữu, Receiver (hoặc người khác nhìn vào Lock Screen của họ) có thể hiểu nhầm đây là lịch trình cá nhân của
Receiver, không phải của Owner họ đang follow.

### 3.5 Lỗ hổng re-share gián tiếp qua ảnh chụp màn hình

AC-R9/AC-I27 cấm re-share **calendar object** trong Ink. Nhưng nếu shared calendar dùng được để render wallpaper,
Receiver hoàn toàn có thể **chụp màn hình Lock Screen** (hành vi bình thường của iOS, ngoài tầm kiểm soát của
Ink) rồi gửi ảnh đó cho bất kỳ ai — nội dung lịch của Owner (tên event, giờ, địa điểm nếu Owner đã bật hiện) đi
ra ngoài mà không qua bất kỳ cơ chế nào Ink kiểm soát được. Đây không phải bug kỹ thuật (không cách nào ngăn
chụp màn hình trên iOS), nhưng là **điều Owner nên được biết trước khi share** — hiện chưa có cảnh báo nào ở
Share Setup (§7 in-app spec) đề cập khả năng dữ liệu có thể "thoát" khỏi Ink theo đường này.

## 4. Test Case Specification — TC-RENDER-01…10

> Toàn bộ case dưới đây có precondition ngầm: **TC-EVT-16 đã xác nhận tính năng này tồn tại**. Nếu chưa, coi
> cả bảng này là **case chờ sẵn** cho khi tính năng được triển khai, không phải backlog hiện tại.

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-RENDER-01 | Mục 3.1 (a)/(b) | Đã Add to Ink 1 shared calendar với Notes OFF, Locations OFF | Tạo wallpaper dùng part `todayList`/`weekEvents`/`hourTimeline` với nguồn là lịch đã nhận | Wallpaper **không** in ra notes/location đã bị Owner tắt — nếu leak, đây là **bug P1 nghiêm trọng nhất session** (lộ công khai trên Lock Screen, không cần mở app) | P1 |
| TC-RENDER-02 | Mục 2, timezone | Owner/Receiver khác timezone (fixture: `calendar-sharing-data-sync-deep-dive.md` TC-SYNC-09/10/11) | Render wallpaper `weekSchedule`/`hourTimeline` từ shared calendar | Giờ in trên ảnh đúng theo timezone máy Receiver, không phải giờ nguyên bản của Owner; all-day event không lệch ngày | P1 |
| TC-RENDER-03 | Mục 2, recurring | Shared calendar có recurring event, Owner sửa 1 occurrence (fixture: TC-SYNC-04) | Render `monthGrid`/`weekSchedule`, sau đó Owner sửa, chờ sync, regenerate wallpaper | Wallpaper phản ánh đúng occurrence đã sửa, không hiện dữ liệu cũ dai dẳng | P2 |
| TC-RENDER-04 | Mục 3.2 (refresh cadence) | Wallpaper đã tạo từ shared calendar, đang hiển thị Lock Screen | Owner sửa event, chờ qua cả 3 tầng trigger (publish → Receiver app refresh → wallpaper regenerate), quan sát thời điểm Lock Screen thật sự đổi | Ghi lại độ trễ thực tế tổng cộng — exploratory, chưa có SLA để assert; nếu độ trễ quá dài tới mức vô dụng thực tế (vd vài ngày), báo cáo làm risk sản phẩm, không chỉ bug | P2 |
| TC-RENDER-05 | Mục 3.3 (window rơi khỏi) | Shared calendar có event gần rơi khỏi window (fixture: TC-SYNC-02/03) | Render wallpaper trước và sau khi window "lăn" qua event đó | Verify wallpaper không hiện dữ liệu sai/thiếu bất thường khi event rơi khỏi window — đặc biệt không crash renderer vì thiếu dữ liệu đột ngột | P2 |
| TC-RENDER-06 | Mục 3.4 (attribution) | Wallpaper đã render từ shared calendar | Quan sát toàn bộ ảnh wallpaper | Ghi lại: có bất kỳ dấu hiệu nào cho biết đây là lịch người khác không — exploratory, chưa có kỳ vọng cố định, nhưng nên báo cáo cho PM nếu hoàn toàn không có (rủi ro nhầm lẫn quyền sở hữu) | P3 |
| TC-RENDER-07 | Mục 3.1, D2 | Shared calendar, Receiver không có quyền edit | Trong flow tạo wallpaper, thử tìm đường sửa nội dung event (title/giờ) từ trong wallpaper editor | Không có đường nào cho phép sửa nội dung event nguồn qua ngả wallpaper editor — mở rộng D2 (read-only) sang đúng bề mặt này, tránh lỗ hổng đi vòng | P1 |
| TC-RENDER-08 | Mục 2, offline | Shared calendar `stale` (offline dài, fixture TC-SYNC-25) | Render/regenerate wallpaper trong lúc calendar đang `stale` | Wallpaper dùng đúng dữ liệu cache cuối cùng, không crash, không hiện màn trống — nhất quán với nguyên tắc "giữ bản cache cuối" đã áp dụng ở mọi bề mặt khác | P2 |
| TC-RENDER-09 | Mục 2, Stop sharing | Owner Stop sharing (fixture TC-OWNER-18/19), Receiver đã có wallpaper dùng calendar đó | Quan sát wallpaper sau khi share bị dừng | Wallpaper giữ nguyên dữ liệu cuối cùng đã nhận (không tự xoá đột ngột), nhất quán với "No longer shared" giữ nguyên dữ liệu ở mọi nơi khác — nhưng nên có cách Receiver biết nguồn đã ngừng để tự xử lý (đổi wallpaper khác) | P2 |
| TC-RENDER-10 | Mục 3.5 (re-share qua screenshot) | Wallpaper đã render, Notes/Locations đang ON | Vào Share Setup (§7 in-app spec) khi Owner đang cấu hình chia sẻ | Ghi lại: có bất kỳ cảnh báo nào cho Owner biết dữ liệu có thể bị chụp màn hình/redistribute ngoài tầm kiểm soát Ink nếu Receiver dùng để tạo wallpaper không — hiện chắc chắn chưa có (đã xác nhận ở mục 3.5), case này để làm bằng chứng cụ thể khi đề xuất bổ sung copy cảnh báo | P3 |

## 5. Open — capstone, cần trả lời trước khi thiết kế pipeline này

| # | Câu hỏi | Ảnh hưởng |
|---|---|---|
| 1 | **Câu hỏi gốc:** lịch nhận qua share có được phép dùng làm nguồn wallpaper/widget/lock screen không? (đã nêu ở event-interaction mục 1.7) | Chặn toàn bộ file này — nếu câu trả lời là KHÔNG, cả mục 2–4 chuyển thành tài liệu tham khảo tương lai |
| 2 | Nếu CÓ: renderer đọc dữ liệu shared calendar qua local EventKit container (đã lọc sẵn) hay qua tầng model riêng (cần lọc lại)? (mục 3.1) | Quyết định mức độ rủi ro leak thật của TC-RENDER-01 — đây là câu hỏi kỹ thuật quan trọng nhất file |
| 3 | Wallpaper có tự regenerate khi shared calendar có update mới không, hay chỉ theo lịch trình gốc? (mục 3.2) | Chặn TC-RENDER-04 ở mức kỳ vọng cụ thể |
| 4 | Có cần attribution "Shared by X" trên wallpaper dùng dữ liệu người khác không? (mục 3.4) | Quyết định sản phẩm, không chặn test kỹ thuật nhưng ảnh hưởng trải nghiệm/nhận thức quyền sở hữu |
| 5 | Có cần cảnh báo Owner về rủi ro screenshot/redistribute khi cho phép Receiver render wallpaper từ dữ liệu của họ không? (mục 3.5) | Quyết định UX/pháp lý nhẹ, không chặn kỹ thuật |

**Khuyến nghị:** câu #1 và #2 là 2 câu **bắt buộc phải hỏi trước tiên**, theo đúng thứ tự — #1 quyết định file
này có cần làm gì ngay không, #2 quyết định mức độ nghiêm trọng thật của rủi ro leak riêng tư lớn nhất đã tìm
được trong toàn bộ chuỗi phân tích Scope B. Không nên bắt đầu code tính năng này (nếu được duyệt) mà chưa có
câu trả lời cho #2.
