# Test Design (đào sâu) — Scope B / Event-level Interaction (Owner ⇄ Receiver)

> **Thuộc:** [calendar-sharing-deep-dive.md](calendar-sharing-deep-dive.md) (index) — tách riêng khỏi
> [calendar-sharing-owner-deep-dive.md](calendar-sharing-owner-deep-dive.md),
> [calendar-sharing-receiver-deep-dive.md](calendar-sharing-receiver-deep-dive.md) và
> [calendar-sharing-data-sync-deep-dive.md](calendar-sharing-data-sync-deep-dive.md) vì đây là **1 tầng hoàn
> toàn khác**: 3 file kia đều dừng ở mức **calendar** (Manage Sharing, Manage Calendar, payload JSON), không
> file nào phân tích việc **tương tác với 1 event cụ thể bên trong lịch đã share**.
> **Test basis:** toàn bộ 4 tài liệu nguồn — nhưng phần lớn phát hiện ở đây đến từ việc **các tài liệu này im
> lặng hoàn toàn**, không phải từ 1 đoạn văn cụ thể nào (khác các deep-dive trước, vốn dựa trên mâu thuẫn giữa
> các đoạn văn có sẵn).
> **Ngày lập:** 2026-09-18 · **Người lập:** QC

---

## 1. Phát hiện — vì sao cần file riêng

Grep toàn văn 4 tài liệu cho `event detail`, `attendee`, `alarm`, `reminder`, `notification`, `push`, `per-event`
→ gần như **0 kết quả có ý nghĩa**. Toàn bộ 4 tài liệu (PRD, login spec, in-app spec, webview spec) chỉ mô tả
tương tác ở **cấp calendar** (share/stop/manage/add/remove) — không tài liệu nào mô tả điều gì xảy ra khi
Owner hoặc Receiver **mở 1 event cụ thể** bên trong lịch đã share. Đây không phải 1 mâu thuẫn giữa các đoạn văn
(như các phát hiện trước) mà là **một tầng tương tác hoàn toàn chưa được viết**.

### 1.1 Không có mockup nào cho màn "chi tiết 1 event" trong ngữ cảnh shared calendar

`screenshot-naming.md` §7.1 đã có sẵn quy ước tên màn `event-detail` (dùng chung cho toàn app), nhưng **không
tài liệu sharing nào** (PRD/in-app/webview) vẽ màn này trong ngữ cảnh calendar đã share — dù cả 2 phía đều chắc
chắn cần nó:

- **Owner** mở 1 event trong lịch **đang được share** — có hiển thị khác gì so với event trong lịch chưa share
  không (vd 1 badge nhỏ "Shared" để nhắc Owner rằng sửa event này sẽ publish ra ngoài)? Hay hoàn toàn giống hệt
  UI event-detail bình thường, Owner không có bất kỳ tín hiệu nào tại chỗ rằng thay đổi sắp public? PRD chỉ nói
  chung chung *"The source calendar remains the source of truth for calendar content"* (D7 §2.7) — không đề
  cập UI cụ thể tại màn edit event.
- **Receiver** mở 1 event trong lịch **đã nhận** — D2 nói *"Receiver cannot edit source events"* nhưng không
  mockup nào cho thấy màn hình đó trông ra sao: có nút Edit bị disable/ẩn hẳn? Có label "Read-only" tại đúng
  event đó (không chỉ ở màn Manage Calendar cấp lịch)? Long-press/swipe-to-delete có bị chặn đúng cách không
  (defense-in-depth — D2 là 1 product rule, chưa chắc đã được enforce ở mọi gesture path của UI event-detail
  sẵn có, vốn được thiết kế cho lịch owned)?

### 1.2 Không có cơ chế loại trừ riêng 1 event khỏi share (per-event privacy)

Toàn bộ mô hình privacy ở v1 (§5.8 PRD, §8 in-app) là **3 toggle cấp CẢ LỊCH** (Event names/Locations/Notes
ON-OFF) — áp dụng đồng loạt cho mọi event trong window. Không có cơ chế nào để Owner nói "share hết lịch Work,
trừ đúng 1 cuộc hẹn riêng tư này". Đây là kỳ vọng khá phổ biến ở các sản phẩm chia sẻ lịch khác (Google/iCloud
Calendar sharing đều có per-event private flag) nhưng **0 dòng nào trong 4 tài liệu Ink nhắc tới khả năng này**
— kể cả ở dạng "Not in this version" (PRD §8 liệt kê khá kỹ những gì bị loại trừ, nhưng per-event exclusion
không nằm trong danh sách đó — nghĩa là nó chưa từng được cân nhắc, không phải bị cố tình cắt).

### 1.3 Attendees, alarms, reminders — hoàn toàn vắng mặt khỏi JSON payload và mọi đoạn văn

Grep `attendee`/`alarm`/`reminder` trên cả 4 tài liệu → **0 kết quả**. Payload shape ví dụ (§7.3 PRD) chỉ có:
`uid, event_name, start_time, end_time, all_day, color, symbol, location, notes, url` — **không có** field nào
cho attendee list hay alarm/reminder. Về mặt riêng tư đây là điều **tốt** (không leak email người tham dự hay
cấu hình nhắc nhở cá nhân của Owner), nhưng kéo theo 2 câu hỏi chưa ai trả lời:

- Đây có phải **chủ đích thiết kế** (đã quyết định không bao giờ đồng bộ attendee/alarm) hay chỉ đơn giản là
  **chưa được cân nhắc** khi viết payload shape minh hoạ? Không đoạn văn nào xác nhận.
- **Receiver có tự đặt được reminder/alert riêng của chính họ** trên 1 event đã nhận không (vd "nhắc tôi trước
  15 phút" dù không sở hữu event)? Đây là kỳ vọng hợp lý — Receiver "theo dõi" lịch người khác vẫn nên tự quản
  được nhắc nhở cho bản thân — nhưng không tài liệu nào xác nhận có hỗ trợ.

### 1.4 Không có cơ chế thông báo (notification/push) khi có event mới/thay đổi

Grep `notification`/`push` trên cả 4 tài liệu → **0 kết quả**. Kết hợp với phát hiện "opportunity" ở
`calendar-sharing-data-sync-deep-dive.md` mục 1.1 (trigger sync không định nghĩa), Receiver hoàn toàn không có
cách nào biết "có gì mới" ngoài việc tự mở app và thấy đã refresh — không badge, không banner "3 sự kiện mới",
không push. Có thể đây là chủ đích (giữ v1 đơn giản, đúng tinh thần "không real-time delivery guarantee" — PRD
§8), nhưng cũng có thể chỉ là chưa được viết — cần hỏi lại để phân biệt 2 khả năng.

### 1.5 Precedence màu/symbol: cấp calendar (Receiver set) vs cấp event (trong payload)

Payload event object có field `color`/`symbol` **riêng cho từng event** (§7.3), đồng thời Receiver có thể đổi
`color`/`symbol` **cấp cả lịch** (§4.9 PRD Flow G, §30 in-app — chỉ liệt "color"/"symbol" cấp calendar, không
nói gì tới field color/symbol cấp event trong payload). 2 nguồn màu này chưa được phân định thứ tự ưu tiên ở
bất kỳ đâu:

- Receiver đổi màu lịch "Work" từ đỏ (mặc định) sang tím — các event bên trong (mỗi event tự mang `color` riêng
  từ payload, vd Owner đã tự đặt 1 event màu xanh để phân biệt) hiển thị theo màu **lịch** (tím, ghi đè) hay
  màu **event** (giữ nguyên từ Owner, payload)?
- Nếu màu event luôn thắng, đổi màu lịch ở Receiver gần như vô nghĩa nếu mọi event đều tự mang màu riêng.

### 1.6 Không xác nhận rõ liệu Owner có biết Receiver đã "xem" 1 event cụ thể không

D12 (PRD) đã cấm subscriber count/identity **cấp lịch**. Không đoạn văn nào mở rộng nguyên tắc này xuống **cấp
event** một cách tường minh (vd "seen"/"viewed" status của từng event) — hợp lý là cùng nguyên tắc áp dụng
(không track), nhưng đáng có 1 case xác nhận thay vì chỉ suy luận từ nguyên tắc cấp cao hơn.

### 1.7 Lịch đã nhận có nạp vào tính năng wallpaper/widget/lock screen — giá trị cốt lõi của app — không? 0 tài liệu nào xác nhận (bổ sung 2026-09-18, phát hiện lớn nhất của file này)

Grep `wallpaper`/`widget`/`lock screen`/`lockscreen`/`template` trên cả 4 tài liệu sharing → **đúng 1 kết quả**,
và đó chỉ là dòng metadata đầu PRD: *"Product: Ink (iOS / LockScreen Calendar)"* — không phải mô tả chức năng.
Grep chéo ngược lại (`share` trong `wallpaper-component-editor-prd.md` và các spec Discover/wallpaper khác) chỉ
ra 1 kết quả duy nhất, và đó là tên biến code nội bộ `InkSharedSpecs` (helper dựng UI style, không liên quan
calendar sharing). Tức là: **2 mảng tính năng — Calendar Sharing và Wallpaper/Widget/Discover — được viết hoàn
toàn tách biệt, không hề tham chiếu chéo nhau ở bất kỳ tài liệu nào.**

Đây là câu hỏi trọng tâm nhất mà câu hỏi gốc của bạn chạm tới: bản thân tên sản phẩm là "**LockScreen
Calendar**", và toàn bộ giá trị cốt lõi khác của Ink (theo `screenshot-naming.md` §7, flow `04_discover`) xoay
quanh việc biến dữ liệu lịch thành wallpaper/widget/live activity trên Lock Screen. Vậy khi Receiver nhận 1
lịch qua share, **lịch đó có dùng được làm nguồn dữ liệu cho wallpaper/widget của chính Receiver không** — vd
Receiver có thể tạo 1 wallpaper Lock Screen hiển thị lịch trình của Owner mà họ đang follow? Hay lịch nhận qua
share **chỉ tồn tại trong danh sách Calendars**, hoàn toàn không tương tác được với hệ thống template/wallpaper?

**Không tài liệu nào trong 4 file trả lời câu này — kể cả ở dạng "Not in this version".** Đây khác các phát
hiện khác trong file này (vốn là khoảng trống nhỏ, cục bộ) — đây là câu hỏi **kiến trúc/scope ở tầm sản phẩm**,
ảnh hưởng tới định hướng toàn bộ tính năng sharing: nếu lịch nhận qua share **không** nạp được vào wallpaper,
thì "share 1 lịch sống động" (§1.3 PRD) chỉ mang lại giá trị xem lịch thuần tuý, không chạm được lý do người
dùng chọn Ink thay vì Google/Apple Calendar ngay từ đầu.

## 2. Test Case Specification — TC-EVT-01…17

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-EVT-01 | Mục 1.1 — Receiver event detail | Đã Add to Ink 1 shared calendar, có ít nhất 1 event | Mở event-detail của 1 event trong lịch đã nhận | Không có nút Edit/Delete khả dụng (ẩn hoặc disable rõ ràng, không chỉ ẩn nút chính rồi vẫn sửa được qua đường khác); có tín hiệu "Read-only" tại đúng màn này (không chỉ ở Manage Calendar cấp lịch) | P1 |
| TC-EVT-02 | Mục 1.1 — defense-in-depth gesture | Như trên | Thử long-press, swipe-to-delete, hoặc bất kỳ gesture sửa/xoá nhanh nào UI event-detail thường hỗ trợ cho lịch owned | Không gesture nào cho phép sửa/xoá event của lịch đã nhận — D2 phải được enforce ở **mọi** đường dẫn UI, không chỉ nút chính | P1 |
| TC-EVT-03 | Mục 1.1 — Owner event detail | Owner mở 1 event trong lịch **đang** share | Quan sát UI event-detail | Ghi lại: có tín hiệu nào (badge/label) cho biết event này đang thuộc 1 calendar đã share không, hay hoàn toàn giống lịch chưa share — đây là exploratory, không có kỳ vọng đúng/sai cố định vì tài liệu không nói | P3 |
| TC-EVT-04 | Mục 1.2 — per-event privacy không tồn tại | Share 1 calendar có Notes ON, có 1 event nhạy cảm trong đó (vd "Khám bệnh", note riêng tư) | Mở Web View/Receiver xem lịch | Event nhạy cảm **vẫn hiện đầy đủ** theo đúng toggle cấp lịch (Notes ON) — xác nhận không có cách nào loại trừ riêng 1 event, đây là giới hạn sản phẩm cần Owner biết trước khi share (không phải bug, nhưng QC nên xác nhận UI có cảnh báo gì trước khi share không) | P2 |
| TC-EVT-05 | Mục 1.3 — attendee không leak | Event nguồn có đính kèm attendee (email người khác) | Xem event đó qua Web View và qua Receiver trong Ink | Không hiện attendee/email nào ở bất kỳ đâu phía Receiver — nếu leak, đây là **bug P1 vi phạm riêng tư nghiêm trọng** (lộ email người thứ 3 không liên quan tới việc share) | P1 |
| TC-EVT-06 | Mục 1.3 — alarm/reminder của Owner không leak | Event nguồn có đặt reminder cá nhân (vd "nhắc trước 30 phút") | Xem event đó phía Receiver | Không hiện thông tin reminder của Owner ở phía Receiver | P2 |
| TC-EVT-07 | Mục 1.3 — Receiver tự đặt reminder riêng | Đã add 1 shared calendar | Mở 1 event trong lịch đã nhận, thử tìm cách đặt reminder/alert riêng cho bản thân | Ghi lại: có hỗ trợ không — exploratory, chưa có kỳ vọng cố định | P3 |
| TC-EVT-08 | Mục 1.4 — không có notification khi có event mới | Share active, Receiver đã add | Owner thêm 1 event mới vào lịch nguồn, Receiver app đang background hoàn toàn (không mở) | Ghi lại: Receiver có nhận được bất kỳ push/badge nào không, hay chỉ thấy khi tự mở app và đã sync xong — exploratory | P3 |
| TC-EVT-09 | Mục 1.5 — precedence màu event vs màu calendar | Owner đặt 1 event màu xanh trong lịch "Work" (payload event có `color` riêng) | Receiver add lịch, đổi màu lịch "Work" (cấp calendar) sang tím | Verify: event đó hiển thị màu xanh (theo payload event) hay tím (theo override cấp lịch của Receiver) — ghi lại hành vi thật, đối chiếu với mục 1.5 vì chưa có quy tắc precedence nào được công bố | P2 |
| TC-EVT-10 | Mục 1.6 — Owner không biết Receiver đã xem event nào | Receiver đã mở/xem 1 vài event cụ thể trong lịch đã nhận | Owner xem lại đúng những event đó ở phía nguồn | Không có bất kỳ chỉ báo "đã xem"/"seen by X" nào — mở rộng đúng nguyên tắc D12 xuống cấp event | P2 |
| TC-EVT-11 | Cross-check D8 — không re-share từng event | Đã add 1 shared calendar | Mở event-detail của 1 event trong lịch đã nhận, tìm bất kỳ action "Share"/"Forward" nào (nếu app có tính năng share event nói chung, ngoài phạm vi sharing calendar) | Không có đường nào để re-share/forward riêng 1 event của lịch đã nhận ra ngoài — mở rộng đúng AC-R9/AC-I27 (cấm re-share cả lịch) xuống cấp event, tránh lỗ hổng đi vòng | P2 |
| TC-EVT-12 | Location field per-event khi toggle Locations OFF | Share có Locations OFF | Xem 1 event có location trong nguồn, qua cả Web View lẫn Receiver in-app | Location không hiện ở cả 2 nơi — đối chiếu nhất quán giữa 2 surface (đã có case tương tự ở webview, đây là verify chéo với event-detail cụ thể thay vì chỉ preview danh sách) | P1 |
| TC-EVT-13 | URL field — có bị lọc theo toggle nào không? | Event nguồn có gắn `url` (link cuộc họp online, vd Zoom link) | Xem qua Web View/Receiver với Notes OFF, Locations OFF | `url` không nằm trong 3 field được liệt kê ở toggle (Event names/Locations/Notes) — verify field này ẩn/hiện theo quy tắc nào, vì không thuộc nhóm nào đã định nghĩa; nếu luôn hiện dù toggle khác đã tắt hết, có thể vô tình leak thông tin nhạy cảm (link họp riêng tư) không qua kiểm soát nào | P1 |
| TC-EVT-14 | Owner sửa event → Receiver's local "đã xem" (nếu có) có reset không | Nếu TC-EVT-07/10 xác nhận app có bất kỳ khái niệm "đã xem"/tuỳ biến per-event nào phía Receiver | Owner sửa nội dung event đó | Verify trạng thái cục bộ phía Receiver (nếu tồn tại) không bị mất/reset sai cách qua 1 lần sync bình thường | P3 |
| TC-EVT-15 | Symbol per-event tương tự màu (mục 1.5) | Tương tự TC-EVT-09 nhưng với `symbol` thay vì `color` | Đổi symbol cấp calendar ở Receiver, so với symbol cấp event trong payload (nếu event có gắn symbol riêng) | Ghi lại hành vi thật, cùng precedence chưa rõ như màu | P3 |
| TC-EVT-16 | Mục 1.7 — lịch nhận qua share có nạp vào wallpaper/widget không | Đã Add to Ink 1 shared calendar | Vào flow tạo wallpaper/widget (Discover tab hoặc tương đương), thử chọn lịch vừa nhận qua share làm nguồn dữ liệu | Ghi lại: lịch xuất hiện trong danh sách nguồn khả dụng hay không — exploratory, đây là câu hỏi scope sản phẩm chưa có tài liệu nào trả lời, không phải bug nếu KHÔNG hỗ trợ (miễn có xác nhận đây là quyết định có chủ đích) | P2 |
| TC-EVT-17 | Mục 1.7 — nếu TC-EVT-16 xác nhận CÓ hỗ trợ | Từ TC-EVT-16, lịch nhận qua share đã dùng để tạo 1 wallpaper/widget | Owner sửa/xoá event đã dùng trong wallpaper đó, chờ sync | Verify wallpaper/widget cập nhật đúng theo dữ liệu mới, hoặc ít nhất không hiển thị sai/crash khi dữ liệu nguồn đổi — nếu CÓ hỗ trợ, đây trở thành đường dữ liệu 2 tầng (share sync + wallpaper render) cần test riêng | P2 |

## 3. Open — riêng Event-level Interaction

| # | Câu hỏi | Ảnh hưởng |
|---|---|---|
| 1 | Có mockup/spec nào cho màn event-detail trong ngữ cảnh shared calendar (cả Owner lẫn Receiver) không? (mục 1.1) | Chặn TC-EVT-01…03 ở mức xác định UI cụ thể — hiện chỉ test được ở mức nguyên tắc (D2 không được vi phạm) |
| 2 | Có kế hoạch nào cho per-event privacy exclusion (loại 1 event khỏi share) không, hay đây là giới hạn v1 chấp nhận được? (mục 1.2) | Không chặn test (hành vi hiện tại rõ ràng — share hết theo toggle cấp lịch), nhưng nên xác nhận đây là quyết định có chủ đích để không bị báo nhầm là bug |
| 3 | Attendee/alarm/reminder bị lược bỏ khỏi payload có phải chủ đích không? Receiver có được tự đặt reminder riêng không? (mục 1.3) | Chặn TC-EVT-07 ở mức kỳ vọng; TC-EVT-05/06 vẫn test được ngay (âm tính — verify KHÔNG leak) vì đây là rủi ro 1 chiều rõ ràng |
| 4 | Có notification/push nào cho event mới/thay đổi không, hay đây là quyết định có chủ đích giữ v1 đơn giản? (mục 1.4) | Không chặn test, chỉ ảnh hưởng khung kỳ vọng của TC-EVT-08 |
| 5 | Precedence màu/symbol cấp event (payload) vs cấp calendar (Receiver override) — cái nào thắng? (mục 1.5) | Chặn TC-EVT-09/15 ở mức kỳ vọng cụ thể |
| 6 | Field `url` trong payload được lọc theo quy tắc privacy nào, hay luôn hiện bất kể toggle? (mục 1.3, liên hệ TC-EVT-13) | Rủi ro leak P1 nếu không có quy tắc nào — cần xác nhận sớm, độc lập với các câu hỏi khác |
| 7 | Lịch nhận qua share có được phép dùng làm nguồn dữ liệu cho wallpaper/widget/lock screen không? (mục 1.7) | **Câu hỏi scope sản phẩm, không chỉ test case** — quyết định hướng nào cũng hợp lệ, nhưng cần 1 câu trả lời rõ ràng bằng văn bản; nếu không ai hỏi, rất có thể sẽ bị bỏ sót hoàn toàn cho tới khi user thật hỏi sau khi ra mắt |

**Khuyến nghị ưu tiên hỏi:** câu **#7 (wallpaper/widget)** trước tiên — dù không phải rủi ro kỹ thuật cấp bách
như #6, đây là câu hỏi duy nhất trong toàn bộ 5 file deep-dive (Owner/Receiver/Data Sync/Event Interaction)
chạm tới **định hướng sản phẩm ở tầm cao nhất**, và có nguy cơ bị bỏ sót vĩnh viễn nếu không ai chủ động nêu ra
— khác các câu hỏi kỹ thuật khác vốn sẽ tự lộ ra khi build/test. Sau đó tới câu #6 (`url` field) vì là rủi ro
leak cụ thể, dễ kiểm chứng nhất.
