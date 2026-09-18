# Test Design (đào sâu) — Scope B / Data Sync (Owner ⇄ Receiver, cross-cutting)

> **Thuộc:** [calendar-sharing-deep-dive.md](calendar-sharing-deep-dive.md) (index) — file này tách riêng khỏi
> [calendar-sharing-owner-deep-dive.md](calendar-sharing-owner-deep-dive.md) và
> [calendar-sharing-receiver-deep-dive.md](calendar-sharing-receiver-deep-dive.md) vì **cơ chế đồng bộ dữ liệu
> không thuộc hẳn về 1 side** — nó là đường ống nối Owner → backend → Receiver, lỗi ở đây luôn biểu hiện ở cả
> 2 đầu cùng lúc. Đã cập nhật bảng "Suite liên-side" ở file index để trỏ vào đây.
> **Test basis:** [calendar-share-live-prd-v1.9.md](../specs/calendar-share-live-prd-v1.9.md) §1.1, §1.3, D6
> (§2.6), D9 (§2.9), §5.2, §5.3, §5.9, §7.1–7.3.
> **Vì sao tách riêng:** đọc kỹ §7.3 (JSON payload) và D6 (auto-publish) lộ ra **5 phát hiện lớn chưa từng được
> phân tích** ở 2 file Owner/Receiver trước đó — toàn bộ đều thuộc lớp lỗi kinh điển của mọi hệ thống đồng bộ
> lịch (Google Calendar, CalDAV, Outlook đều từng dính), nhưng **0 dòng tài liệu nào trong 4 file nguồn xử lý**.
> **Ngày lập:** 2026-09-18 · **Người lập:** QC

---

## 1. Phát hiện

### 1.1 Trigger đồng bộ ("khi Ink có cơ hội") — hoàn toàn chưa định nghĩa kỹ thuật

Cụm *"when it has a suitable opportunity"* / *"when Ink gets an opportunity to refresh"* xuất hiện **y hệt 4
lần** trong PRD (§1.3, D6 §2.6 ×2, AC-S8) — không một lần được định nghĩa: app foreground? Background App
Refresh budget của iOS? Silent push? Timer định kỳ? Chính PRD tự đặt câu hỏi này ở **Open Q#6** (§9) và tự trả
lời: *"Product requirement is automatic when reasonably possible; exact trigger is implementation-owned."* —
tức là ngay ở tầm PM cũng chưa cam kết cơ chế cụ thể, chỉ cam kết **kết quả** (tự động, không cần user bấm gì).

**Hệ quả cho test design:** không thể viết case dạng "chờ X giây rồi verify đã sync" với X cố định — bất kỳ
case nào phụ thuộc trigger đều phải chạy dạng **session-based/exploratory** (để app chạy nền/foreground trong
khoảng thời gian dài, quan sát), không phải scripted với timeout xác định. Điều này áp dụng cho **cả 2 chiều**:
Owner-side publish VÀ Receiver-side refresh đều dùng chung cụm "opportunity" mơ hồ này (dòng 70 nói về receiver
pull, dòng 231/1053 nói về sender publish) — nên không loại trừ khả năng 2 chiều dùng 2 cơ chế trigger khác
nhau hoàn toàn (implementation-owned, PM không phân biệt).

### 1.2 `window` trong JSON payload — 0 định nghĩa sản phẩm, chỉ có 1 ví dụ minh hoạ

`window` chỉ xuất hiện đúng 1 chỗ trong toàn văn payload shape (§7.3):

```jsonc
"window": { "start": "2026-09-10", "end": "2027-03-10" }
```

~6 tháng, không kèm bất kỳ đoạn văn nào giải thích quy tắc. Cụm liên quan duy nhất khác là ở §1.1, mô tả tính
năng **CŨ** (snapshot, pre-v1.9): *"Ink exports a future window as JSON"* — không rõ đây là khái niệm được kế
thừa y nguyên từ engine snapshot cũ hay đã được re-scope cho mô hình live-sync mới.

**3 câu hỏi cụ thể chưa có câu trả lời ở bất kỳ đâu:**
- Window có **lăn theo thời gian** (rolling — vd luôn là "hôm nay + 6 tháng tới") hay **cố định tại thời điểm
  tạo share** (vd luôn dừng ở 2027-03-10 dù đã qua nhiều tháng)?
- Khi 1 event rơi ra khỏi window ở lần publish kế tiếp (vd do window lăn tới, làm event cũ "quá khứ" so với
  `window.start` mới), payload publish đó có còn chứa event ấy không?
- Nếu không còn — Receiver đã nhận event đó ở lần sync trước có bị **xoá mất** khỏi bản local hay không, hay
  Ink chỉ áp window cho phần thêm mới (không hồi tố xoá dữ liệu Receiver đã có)?

**Vì sao đây là rủi ro P1 tiềm ẩn:** nếu window lăn và loại event khỏi payload publish tiếp theo mà backend
diff kiểu "payload mới không có event X → xoá event X khỏi bản Receiver", thì Receiver **mất dữ liệu qua 1 lần
refresh hoàn toàn bình thường**, không phải do lỗi mạng — đúng loại tình huống mà §5.2 PRD cố tình phòng tránh
theo hướng khác (*"Do not collapse ordinary connectivity failure into 'No longer shared'"*), nhưng ở đây là
mất dữ liệu do chính cơ chế window, không phải lỗi kết nối.

### 1.3 Recurring events — 0 đề cập trong toàn bộ 4 tài liệu nguồn

Grep toàn văn `recurring`/`recurrence` trên cả 4 tài liệu → **0 kết quả**. JSON shape ở §7.3 chỉ có field
phẳng (`start_time`/`end_time`/`all_day`), **không có** `rrule`/`recurrence_id`/series-linkage nào — ngụ ý
recurring event bị **flatten thành từng occurrence riêng lẻ** trong window lúc export (hợp lý với mô hình
window bounded), nhưng đây thuần là suy luận từ việc thiếu field, không phải khẳng định của tài liệu nào.

Nếu đúng là flatten, đây là 3 câu hỏi hành vi **chưa ai trả lời**, thuộc đúng lớp bug đã từng xảy ra ở hầu hết
hệ thống calendar sync lớn (Google/CalDAV/Outlook):

- Owner sửa **cả series** (vd đổi giờ họp hàng tuần từ 9h → 10h, chọn "this and following events" trong
  EventKit) — occurrence nào trong window được cập nhật đúng giờ mới? Tất cả, hay chỉ occurrence Owner trực
  tiếp mở?
- Owner sửa/xoá **chỉ 1 occurrence cụ thể** (EventKit gọi là detached exception) — occurrence đó có tách đúng
  khỏi series trong payload, các occurrence khác có bị ảnh hưởng nhầm không?
- **UID ổn định** qua các loại edit này (mục 1.3 liên hệ trực tiếp mục 1.4 bên dưới) — occurrence giữ nguyên
  `uid` hay đổi, khiến Receiver thấy như "xoá 1 event + tạo 1 event mới" thay vì "cập nhật"?

### 1.4 `uid` mỗi event được gọi là "stable" nhưng không định nghĩa nguồn gốc

`"uid": "stable-event-id"` — tên field tự khẳng định "stable" (§7.3), và §7.1 nói payload *"must carry enough
stable identity for receiver-side updates and local customization to survive refreshes"* — nhưng không tài
liệu nào nói ID này lấy từ đâu (EventKit `eventIdentifier` trực tiếp? hash tự sinh? ID cấp bởi backend Ink lúc
export lần đầu rồi map ngược?). Rủi ro kỹ thuật thật: `eventIdentifier` của Apple EventKit **không được Apple
đảm bảo bất biến tuyệt đối** trong mọi tình huống (vd sau khi calendar đồng bộ lại với server CalDAV/Exchange ở
tầng hệ điều hành, identifier có thể đổi). Nếu Ink dùng trực tiếp `eventIdentifier` làm `uid` mà không có lớp
ánh xạ ổn định riêng, event có thể bị hiểu nhầm là "xoá + tạo mới" ở phía Receiver dù nội dung không đổi thật.
Mức độ nghiêm trọng phụ thuộc việc app có hiển thị chỉ báo "mới/đã đổi" dựa trên diff UID hay không (không tài
liệu nào xác nhận có tính năng này) — nên xếp P2 (rủi ro kỹ thuật thật nhưng tác động sản phẩm chưa xác nhận),
không phải P1 như mục 1.2/1.3.

### 1.5 Timezone — chỉ có 1 field `time_zone` ở CẤP TOÀN PAYLOAD, không phải per-event

`"time_zone": "Asia/Ho_Chi_Minh"` — xuất hiện **đúng 1 lần** trong toàn bộ 4 tài liệu, gắn ở cấp payload
(1 giá trị cho cả lịch), **không có** field timezone riêng cho từng event.

**3 rủi ro cụ thể, thuộc lớp bug kinh điển nhất của mọi app lịch:**
- Nếu lịch nguồn của Owner có 1 event được set timezone khác timezone chính của lịch (vd họp online "9h sáng
  giờ Mỹ" trong khi Owner đang ở VN — hoàn toàn bình thường trong EventKit) → field `time_zone` cấp payload
  duy nhất **không đủ chỗ chứa** ngoại lệ này, event đó có nguy cơ xuất ra sai giờ.
- **Receiver ở timezone khác Owner** — không đoạn văn nào mô tả cơ chế convert giờ hiển thị theo timezone máy
  Receiver so với `time_zone` trong payload. Đây là bug lệch-N-giờ kinh điển nhất của mọi calendar sync.
- `"all_day": false` — field boolean duy nhất cho all-day, không có xử lý riêng. All-day event thường là
  "floating date" (không gắn timezone cụ thể) ở hầu hết calendar engine; nếu implementation áp nhầm
  `time_zone` payload lên all-day event, ngày hiển thị có thể **lùi/tiến 1 ngày** tuỳ vị trí Receiver so với
  Owner (vd Owner ở châu Á, Receiver ở châu Mỹ — chênh lệch đủ để nhảy ngày).

Vì `time_zone` dùng IANA zone name (không phải fixed UTC offset), **nếu** implementation convert đúng chuẩn
IANA, hệ thống tự động xử lý đúng DST (giờ mùa hè) theo ngày cụ thể — đây là thiết kế field đúng hướng, nhưng
chưa có gì xác nhận implementation thực sự làm vậy thay vì cache 1 offset cố định lúc export.

### 1.6 Không có giới hạn/độ lớn payload nào được tài liệu hoá

Không đoạn văn nào nói số lượng event tối đa trong 1 window, dung lượng payload tối đa, hay hành vi khi lịch
nguồn có rất nhiều event (lịch công việc dày đặc, hàng trăm event/6 tháng). Rủi ro performance/timeout khi
publish hoặc khi Receiver tải payload lần đầu — mức độ thấp hơn 5 mục trên (P2/P3, không phải data-loss) nhưng
vẫn đáng 1 case boundary vì payload hiện tại là **full-replace mỗi lần publish** (§7.1 nói "latest JSON
payload" — số ít, không phải incremental diff), nên chi phí/độ trễ tăng tuyến tính theo số event mỗi lần sync,
không chỉ theo phần thay đổi.

### 1.7 Online/Offline — chỉ có Receiver được xử lý tường minh, Owner-side gần như 0 tài liệu (bổ sung 2026-09-18)

Grep toàn văn `offline` trên cả 4 tài liệu → **đúng 1 kết quả**, và đó là mô tả trạng thái `stale` phía
**Receiver** (§5.2 PRD: *"Keep showing the latest cached version with a clear stale/offline indication"*).
Grep `network`/`connectivity` cũng chỉ ra đúng 1 khu vực có xử lý thật: Web View (§13 webview spec, AC-W14 —
*"Temporary network failure is not shown as expired or revoked"*) và receiver in-app refresh-fail (§5.2 PRD,
đã có case ở `calendar-sharing-receiver-deep-dive.md` TC-RECV-12, `calendar-share-webview-spec` TC-RECV-08b).

**Quan trọng — phân biệt 2 khái niệm hay bị nhầm:**

| Khái niệm | Đã có xử lý tài liệu? | Case đã có |
|---|---|---|
| **Source-provider disconnect** (Owner ngắt kết nối Google/Outlook account làm nguồn lịch) | Có — D-Source-unavailable, §5.5 PRD | TC-OWNER-22/23 |
| **Network/internet offline** (thiết bị mất mạng hoàn toàn, ảnh hưởng MỌI cuộc gọi API, không riêng gì nguồn lịch) | **Chỉ có phía Receiver** (Web View + refresh) | TC-RECV-08b, TC-RECV-12 |

**Owner-side action nào cần network mà chưa có case/tài liệu xử lý offline:**

- **Create share link** (Share Setup → Create) — bấm khi máy đang offline thì sao? Không đoạn văn nào nói.
  Khác với TC-OWNER-11 (double-tap khi CÓ mạng) — đây là network hoàn toàn không có, chưa test.
- **Stop sharing** — xác nhận khi offline. Đây là action rủi ro nhất trong nhóm này: nếu app hiện Owner "đã
  stop thành công" (optimistic UI) trong khi request thật sự chưa gửi được do offline, share **vẫn active**
  trên server nhưng Owner tưởng đã dừng — rủi ro riêng tư (Owner nghĩ đã ngừng chia sẻ nhưng thực ra chưa).
- **Đổi visibility/expiry** trong Manage Sharing khi offline — optimistic UI hay chặn/báo lỗi?
- **Renew** khi offline.
- **Refresh now / Check for updates** khi offline — hợp lý nhất là phải báo lỗi rõ ràng, nhưng chưa có mockup
  nào cho trạng thái lỗi của riêng nút này (khác hẳn trạng thái nguồn-unavailable đã có mockup ở §21 in-app).

**Receiver-side còn thiếu:**

- **Add to Ink** khi offline (Web View đã load sẵn lúc còn mạng — vd cache trình duyệt — nhưng lúc bấm "Add to
  Ink" thì mất mạng giữa chừng). Khác với TC-RECV-08b (mở link ngay từ đầu lúc offline).

**Cả 2 side đều thiếu:**

- **Không có giá trị timeout nào được công bố** cho bất kỳ network call nào liên quan sharing — chỉ có nút
  "Retry" (§13 webview, không kèm số giây). Không phân biệt được "offline hẳn" (fail ngay lập tức, hợp lý) với
  "mạng chậm/chập chờn" (có thể treo loading vô thời hạn nếu không có timeout) — 2 tình huống UX nên khác nhau
  nhưng tài liệu không nói.
- **Không có cơ chế retry-khi-có-mạng-lại nào được mô tả** — nếu 1 action fail vì offline, sau khi có mạng trở
  lại, app có tự động thử lại không, hay bắt buộc user tự bấm lại? Không đoạn văn nào trả lời cho bất kỳ action
  nào (Owner lẫn Receiver).

### 1.8 Hành vi của CHÍNH DỮ LIỆU đồng bộ qua các lần chuyển online ⇄ offline (bổ sung 2026-09-18, mở rộng mục 1.7)

Mục 1.7 tập trung vào **từng action UI** (Create/Stop/Renew/Add to Ink) fail thế nào khi offline. Câu hỏi ở đây
hẹp hơn nhưng sâu hơn: **bản thân dữ liệu lịch** (event, payload) đi qua các lần mất/có mạng thì đúng/sai ra
sao. 4 điểm cụ thể:

**a) Điểm mạnh có sẵn từ kiến trúc — full-replace giúp hội tụ đúng khi có mạng lại.** §7.1 PRD nói payload là
*"latest JSON payload"* (số ít) — tức mỗi lần publish thành công là **thay thế toàn bộ**, không phải áp từng
diff tuần tự. Đây là 1 thiết kế **tốt** cho bài toán offline: nếu Owner sửa nhiều event trong lúc Receiver mất
mạng dài, khi Receiver có mạng lại và fetch thành công, họ nhận đúng **trạng thái mới nhất tại thời điểm đó**,
không cần áp đúng thứ tự từng thay đổi trung gian (khác hệ thống incremental-diff, vốn dễ lỗi thứ tự khi mạng
chập chờn). Đây là điểm nên được **xác nhận bằng test thật** (mục đích để đảm bảo hành vi thực tế khớp thiết kế
suy ra từ tài liệu — không phải giả định suông), không phải chỉ suy luận lý thuyết.

**b) Rủi ro nặng hơn TC-SYNC-18: action offline bị "quên" nếu app bị force-quit trước khi có mạng lại.**
TC-SYNC-18/22 (mục 1.7) mới test trường hợp mạng có lại trong khi app **vẫn đang chạy**. Chưa có case cho: nếu
UI là optimistic (Open Q#7 — chưa xác nhận) và Owner **force-quit app hoàn toàn** trong lúc vẫn offline (trước
khi có mạng lại), action đang "chờ retry" có được lưu bền (persist ra đĩa) để tiếp tục khi mở lại app, hay chỉ
nằm trong memory và **biến mất vĩnh viễn** khi app bị kill? Nếu biến mất: Owner tin đã Stop sharing thành công
(UI đã báo success), mở lại app sau đó **không** thấy gì bất thường (vì action bị mất, không phải đang chờ) —
share **vẫn sống mãi** mà không ai biết cần retry. Đây là kịch bản tệ hơn TC-SYNC-18 vì không có tín hiệu lỗi
nào còn sót lại để user nhận ra.

**c) Trạng thái `stale` có tự động hết hạn thành `no_longer_shared` sau 1 khoảng offline dài không?** §5.2 PRD
cấm rõ *"Do not collapse ordinary connectivity failure into 'No longer shared'"* — nhưng không nói **có giới
hạn thời gian** cho lệnh cấm này không (vd offline 1 ngày vẫn `stale`, nhưng offline 6 tháng thì sao — vẫn giữ
nguyên `stale` vô thời hạn, hay có 1 ngưỡng nào đó tự chuyển sang trạng thái khác?). Không tài liệu nào định
nghĩa ngưỡng, nên theo đúng chữ hiện tại, `stale` phải giữ **vô thời hạn** tới khi refresh thành công trở lại.

**d) Owner sửa lịch nguồn hoàn toàn OFFLINE (không mở Ink, chỉ sửa trực tiếp trong Apple Calendar/Google
Calendar app) rồi mới mở Ink khi có mạng lại** — khác TC-SYNC-01 (vốn không chỉ định rõ trạng thái mạng lúc
sửa). Cần xác nhận Ink phát hiện đúng thay đổi đã xảy ra "ngoài tầm quan sát" của nó (không có cơ hội nào để
publish trong lúc sửa vì cả Ink app không hề mở), không bị bỏ sót khi cuối cùng cũng có 1 "opportunity" xảy ra.

## 2. Data flow (tổng quát, đánh dấu đúng chỗ chưa rõ)

```text
Owner sửa event ở app lịch gốc (EventKit/Google/Outlook)
        │
        ▼
   Ink chờ "opportunity" để publish        ❓ mục 1.1 — trigger không định nghĩa
        │
        ▼
   Export JSON:
     - áp window (bounded date range)      ❓ mục 1.2 — rolling hay fixed, event rơi khỏi window bị gì?
     - flatten recurring → occurrence rời  ❓ mục 1.3 — series-edit/single-occurrence-edit propagate đúng không?
     - gắn uid ổn định mỗi occurrence      ❓ mục 1.4 — nguồn gốc uid, có thật ổn định qua edit không?
     - gắn time_zone 1 giá trị/payload     ❓ mục 1.5 — event khác timezone, all-day, Receiver khác timezone?
        │
        ▼
   Backend lưu "latest JSON payload"        (full-replace, không incremental — mục 1.6)
        │
        ▼
   Receiver "gets an opportunity" để refresh ❓ mục 1.1 — cùng câu hỏi trigger, có thể khác cơ chế owner-side
        │
        ▼
   Ink hiển thị theo timezone máy Receiver,  ❓ mục 1.5
   GIỮ local customization (tên/màu/symbol)  đã verify ở TC-RECV-11, không lặp lại ở đây
```

## 3. Decision Table / Equivalence Partition — Data Sync

### DT-SYNC-1 — Loại chỉnh sửa recurring event × kỳ vọng propagate (mục 1.3, exploratory — chưa có kỳ vọng chốt)

| Loại edit ở nguồn (EventKit) | Occurrence trong window bị ảnh hưởng | Kỳ vọng hợp lý (CHƯA xác nhận bởi tài liệu) |
|---|---|---|
| Đổi 1 field, áp dụng "This event" (chỉ occurrence hiện tại) | 1 occurrence | Chỉ đúng 1 occurrence trong payload đổi, các occurrence khác giữ nguyên |
| Đổi 1 field, áp dụng "This and following events" | Occurrence hiện tại + tương lai trong window | Tất cả occurrence từ mốc trở đi trong window đổi theo, occurrence quá khứ (nếu còn trong window) giữ nguyên |
| Đổi 1 field, áp dụng "All events" | Toàn bộ occurrence trong window | Toàn bộ occurrence trong window đổi theo |
| Xoá 1 occurrence cụ thể | 1 occurrence | Occurrence đó biến mất khỏi payload lần publish kế, các occurrence khác không đổi `uid` |
| Xoá cả series | Toàn bộ occurrence trong window | Toàn bộ occurrence biến mất, Receiver không còn thấy các sự kiện đó (khác hẳn Stop sharing — đây là xoá nội dung, share vẫn `shared`) |

### DT-SYNC-2 — Tổ hợp timezone Owner × Receiver × loại event (mục 1.5)

| Owner timezone | Receiver timezone | Loại event | Rủi ro cần verify |
|---|---|---|---|
| Giống nhau (vd cả 2 `Asia/Ho_Chi_Minh`) | Giống nhau | Event giờ cụ thể | Baseline — phải đúng tuyệt đối, dùng để đối chứng các dòng dưới |
| Khác nhau, cùng offset hiện tại (vd `Asia/Ho_Chi_Minh` UTC+7 vs 1 zone khác cũng UTC+7 quanh năm) | — | Event giờ cụ thể | Giờ hiển thị phải giống baseline dù tên zone khác nhau |
| Khác nhau, lệch offset (vd VN vs US) | — | Event giờ cụ thể | Giờ hiển thị ở Receiver phải convert đúng theo chênh lệch offset thật, không hiện nguyên giờ của Owner |
| Owner ở zone có DST (vd `America/New_York`), event nằm **ngay trước/sau mốc chuyển DST** | Receiver ở zone không có DST (vd VN) | Event giờ cụ thể | Giờ hiển thị phải tính đúng offset tại **ngày của event**, không dùng offset cố định lúc export |
| Bất kỳ | Bất kỳ | All-day event | Ngày hiển thị **không được lệch ±1 ngày** dù Owner/Receiver khác timezone xa nhau |
| 1 event set timezone khác lịch chính (vd họp "giờ Mỹ" trong lịch VN) | Bất kỳ | Event giờ cụ thể | Giờ hiển thị phải đúng theo timezone **của chính event đó**, không bị field `time_zone` cấp payload ghi đè sai |

## 4. Test Case Specification — TC-SYNC-01…26

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-SYNC-01 | Mục 1.1, D6, AC-S8 | Share active, Owner + Receiver cùng chạy | Sửa 1 event ở nguồn, **không** bấm nút fallback thủ công nào, để app chạy nền tự nhiên (không force), quan sát trong 1 phiên dài (vd vài giờ, nhiều lần mở/đóng app) | Receiver nhận được thay đổi tại **một thời điểm nào đó** mà không cần thao tác thủ công — ghi lại khoảng thời gian thực tế quan sát được (không có SLA để assert pass/fail theo thời gian cố định) | P1 |
| TC-SYNC-02 | Mục 1.2 (window) | Share active, window mặc định ~90 ngày (theo expiry mặc định, không phải window 6 tháng ví dụ — verify window thật app dùng là bao nhiêu, tài liệu không nói rõ số này áp cho window hay chỉ cho expiry) | 1. Ghi lại `window.end` thật đang publish (nếu có cách xem qua debug/API).<br>2. Chờ thời gian trôi qua đáng kể (vd nhiều tuần nếu khả thi trong thời gian test, hoặc giả lập đổi ngày hệ thống nếu công cụ cho phép).<br>3. Verify publish tiếp theo. | Ghi nhận: `window.end` có tăng theo (rolling) hay giữ nguyên (fixed)? Đây là case khám phá, chưa có kỳ vọng đúng/sai cố định — báo cáo phát hiện cho PM quyết định | P1 |
| TC-SYNC-03 | Mục 1.2 | Từ TC-SYNC-02, đã xác định window có rolling | Tạo 1 event ở đúng mép ngoài window cũ (event sẽ rơi khỏi window ở lần publish sau khi window lăn) | Verify: event đã Receiver nhận trước đó có bị xoá khỏi bản local không, hay vẫn giữ nguyên (chỉ payload publish mới không chứa, không đồng nghĩa xoá dữ liệu cũ) — nếu bị xoá mất → **bug P1 mất dữ liệu** | P1 |
| TC-SYNC-04 | DT-SYNC-1 dòng 1 | Share active, lịch nguồn có 1 recurring event (vd họp hàng tuần) | Sửa giờ **chỉ 1 occurrence** ("This event only") | Chỉ đúng occurrence đó đổi giờ ở Receiver; các occurrence khác trong series giữ nguyên giờ cũ | P1 |
| TC-SYNC-05 | DT-SYNC-1 dòng 3 | Như trên | Sửa giờ **toàn bộ series** ("All events") | Toàn bộ occurrence trong window đổi theo giờ mới ở Receiver | P1 |
| TC-SYNC-06 | DT-SYNC-1 dòng 4 | Như trên | Xoá **1 occurrence cụ thể** | Occurrence đó biến mất ở Receiver sau lần sync kế; các occurrence khác **không** biến mất theo (không bị nhầm là xoá cả series) | P1 |
| TC-SYNC-07 | DT-SYNC-1 dòng 5 | Như trên | Xoá **toàn bộ series** | Toàn bộ occurrence trong window biến mất ở Receiver; share **vẫn** ở trạng thái `shared` (khác Stop sharing — đây là xoá nội dung, không phải dừng share) | P1 |
| TC-SYNC-08 | Mục 1.3/1.4 | Từ TC-SYNC-04, sau khi sync | Kiểm tra occurrence đã sửa: có bị Ink hiển thị như "1 event bị xoá + 1 event mới thêm" (nếu app có bất kỳ chỉ báo mới/đổi nào) thay vì "1 event được cập nhật" | Nếu app có chỉ báo trạng thái mới/đổi: phải đúng "đã cập nhật", không phải "xoá+thêm" — xác nhận `uid` thực sự ổn định qua edit | P2 |
| TC-SYNC-09 | DT-SYNC-2 dòng 3 | Owner timezone VN (UTC+7), Receiver timezone US (vd `America/Los_Angeles`) | Owner tạo event "09:00 thứ Hai" theo giờ VN | Receiver thấy đúng giờ đã convert theo chênh lệch offset thật (không phải "09:00" y nguyên số) | P1 |
| TC-SYNC-10 | DT-SYNC-2 dòng 4 (DST) | Owner timezone có DST (vd `America/New_York`), event nằm ngay quanh mốc chuyển DST (đầu tháng 3 hoặc đầu tháng 11) | Tạo event trước mốc DST, verify giờ hiển thị ở Receiver (VN, không DST) cả trước và sau khi mốc DST của Owner đã qua | Offset áp dụng phải đúng theo **ngày cụ thể của event**, không dùng offset cố định tại thời điểm export — event trước/sau mốc DST lệch nhau đúng 1 giờ so với Receiver | P1 |
| TC-SYNC-11 | DT-SYNC-2 dòng 5 (all-day) | Owner VN, Receiver ở timezone chênh lệch xa (vd US, hướng ngày âm) | Owner tạo 1 all-day event ngày cụ thể (vd "15 tháng 9") | Receiver thấy **đúng ngày 15 tháng 9**, không bị lùi thành 14 do convert timezone sai cho all-day | P1 |
| TC-SYNC-12 | Mục 1.5, event lệch timezone riêng | Owner ở VN, tạo 1 event set **riêng** timezone khác (vd họp lúc "09:00 America/New_York" dù Owner đang ở VN) | Verify Receiver (bất kỳ timezone nào) thấy đúng giờ quy đổi từ `America/New_York`, không bị field `time_zone` cấp payload (giả sử là VN) ghi đè sai | P1 |
| TC-SYNC-13 | Mục 1.6 (payload size) | Lịch nguồn có nhiều event dày đặc trong window (vd ≥200 event/90 ngày, mô phỏng lịch công việc bận) | Share calendar, quan sát thời gian tạo link + thời gian Receiver Add to Ink lần đầu | Không timeout, không crash; ghi lại thời gian thực tế nếu chậm bất thường để tham khảo hiệu năng | P3 |
| TC-SYNC-14 | Mục 1.1 (2 chiều trigger độc lập) | Share active | Sửa event ở nguồn trong khi Receiver app đang ở **background hoàn toàn** (không mở lại) trong thời gian dài, sau đó mở lại Receiver app | Verify Receiver có tự refresh khi mở lại app (foreground = 1 "opportunity" hợp lý), hay vẫn cần chờ thêm — ghi nhận hành vi thật | P2 |
| TC-SYNC-15 | Cross-check TC-OWNER-15/TC-RECV-11 (đã có ở 2 file kia) | Share active | Không lặp lại case cũ — chỉ verify: khi auto-publish xảy ra (TC-SYNC-01), local customization Receiver (tên/màu/symbol, đã set trước) **vẫn giữ nguyên** qua đúng lần sync đó | Không bị ghi đè — xác nhận §5.3 PRD đúng cả trong kịch bản sync thật (không phải chỉ lý thuyết) | P1 |
| TC-SYNC-16 | Mục 1.2 + 1.3 kết hợp | Recurring event có occurrence nằm **đúng mép window** | Verify occurrence ở biên window (vừa trong, vừa ngoài 1 ngày) có xuất hiện/biến mất đúng theo window, không bị lỗi off-by-one ngày do quy đổi timezone kết hợp window cutoff | P2 |
| TC-SYNC-17 | Mục 1.7 — Owner Create share link khi offline | Lịch owned chưa share, bật Airplane Mode | 1. Vào Share Setup, điền xong.<br>2. Bấm "Create share link" khi đang offline. | Báo lỗi rõ ràng (không phải loading vô thời hạn); **không** tạo share ở trạng thái nửa vời (không share record rác phía backend khi có mạng lại); UI quay lại đúng Share Setup để thử lại | P1 |
| TC-SYNC-18 | Mục 1.7 — Owner Stop sharing khi offline (rủi ro cao nhất nhóm offline) | Share active, bật Airplane Mode | 1. Vào Manage Sharing, bấm Stop sharing, xác nhận khi đang offline.<br>2. Tắt Airplane Mode, verify lại trạng thái thật (không chỉ tin UI ngay sau bước 1). | UI **không được** hiện "đã stop thành công" nếu request chưa gửi được — nếu hiện optimistic-success trong khi share vẫn active trên server, đây là **bug P1** (Owner tưởng đã ngừng chia sẻ nhưng Receiver vẫn nhận update) | P1 |
| TC-SYNC-19 | Mục 1.7 — Đổi visibility/expiry khi offline | Share active, bật Airplane Mode | Đổi 1 toggle visibility trong Manage Sharing khi offline | Verify: chặn + báo lỗi ngay, hay đổi cục bộ rồi đồng bộ khi có mạng lại (optimistic)? Ghi lại hành vi thật; nếu optimistic, verify đồng bộ đúng khi có mạng lại (không mất thay đổi, không lặp/ghi đè sai) | P2 |
| TC-SYNC-20 | Mục 1.7 — Renew khi offline | Share `expired`, bật Airplane Mode | Bấm Renew khi offline | Báo lỗi rõ ràng, share vẫn ở `expired` (không chuyển nhầm sang `shared` khi request chưa thành công) | P2 |
| TC-SYNC-21 | Mục 1.7 — Receiver Add to Ink khi mất mạng giữa chừng | Web View đã load lúc còn mạng, bật Airplane Mode ngay trước khi bấm | Bấm "Add to Ink" khi đang offline | Báo lỗi rõ ràng; **không** tạo record lịch nửa vời (không có customization mặc định bị lưu sai) ở phía Receiver; thử lại được ngay khi có mạng | P1 |
| TC-SYNC-22 | Mục 1.7 — Retry tự động khi có mạng lại | Từ TC-SYNC-18 hoặc TC-SYNC-19 (action đã fail do offline) | Tắt Airplane Mode, **không** tự thao tác gì thêm, quan sát 1 khoảng thời gian | Ghi lại: app có tự retry action đã fail không, hay vẫn treo ở trạng thái lỗi tới khi user tự bấm lại — không có tài liệu nào cam kết retry tự động, đây là case khám phá | P2 |
| TC-SYNC-23 | Mục 1.8a — full-replace hội tụ đúng sau offline dài | Receiver offline kéo dài (vd bật Airplane Mode nhiều giờ) | Trong lúc Receiver offline, Owner sửa **nhiều** event khác nhau (thêm 1, sửa 1, xoá 1) qua nhiều lần publish riêng biệt. Sau đó Receiver có mạng lại, refresh. | Receiver nhận **đúng trạng thái cuối cùng** (1 event mới có mặt, 1 event đã sửa đúng nội dung mới, 1 event đã xoá biến mất) trong **đúng 1 lần** refresh — không cần nhiều lần refresh mới "bắt kịp", không có event nào bị áp sai thứ tự/thiếu | P1 |
| TC-SYNC-24 | Mục 1.8b — rủi ro nặng hơn TC-SYNC-18: force-quit khi đang offline | Owner bấm Stop sharing lúc offline (như TC-SYNC-18), nhưng **trước khi có mạng lại**, force-quit hẳn app (không chỉ background) | 1. Force-quit app khi vẫn offline.<br>2. Mở lại app, bật mạng.<br>3. Verify trạng thái share thật (không chỉ tin UI). | Nếu action bị mất hoàn toàn (không có gì retry, không có cảnh báo nào nhắc lại), và share **vẫn active** trên server trong khi Owner tin đã dừng → **bug P1 nghiêm trọng nhất trong toàn bộ file này** (mất dữ liệu trạng thái, không phải chỉ mất event) | P1 |
| TC-SYNC-25 | Mục 1.8c — `stale` không tự hết hạn thành `no_longer_shared` chỉ vì offline lâu | Receiver `active`, sau đó offline **rất dài** (vd mô phỏng nhiều ngày nếu công cụ cho phép đổi ngày hệ thống, hoặc ít nhất vài giờ liên tục trong phạm vi thời gian test khả thi) | Không thao tác gì, chỉ để app ở trạng thái mất mạng kéo dài | Vẫn hiển thị `stale`/"Couldn't refresh", **không** tự chuyển sang "No longer shared" chỉ vì thời gian offline dài — đúng chữ §5.2 PRD (không có ngưỡng thời gian nào được định nghĩa để làm điều này) | P2 |
| TC-SYNC-26 | Mục 1.8d — Owner sửa lịch hoàn toàn ngoài Ink rồi mới mở Ink khi có mạng | Ink app **đóng hẳn** (không chạy nền), Owner sửa 1 event trực tiếp trong Apple Calendar/Google Calendar app | Mở lại Ink app (có mạng), chờ 1 "opportunity" xảy ra | Thay đổi được phát hiện và publish đúng dù Ink không hề mở trong lúc sửa — không bị bỏ sót vì "không có cơ hội quan sát" tại đúng thời điểm thay đổi xảy ra | P1 |

## 5. Open — riêng Data Sync

| # | Câu hỏi | Ảnh hưởng |
|---|---|---|
| 1 | Trigger publish/refresh cụ thể là gì (foreground? Background App Refresh? push?) — có giống nhau giữa Owner-side publish và Receiver-side refresh không? (mục 1.1) | Chặn mọi case sync ở mức "assert theo thời gian cố định"; toàn bộ TC-SYNC-01/14 phải chạy dạng exploratory |
| 2 | Window có rolling không? Event rơi khỏi window có bị xoá khỏi bản Receiver đã nhận không? (mục 1.2) | Chặn TC-SYNC-02/03 ở mức kỳ vọng cụ thể — hiện tại chỉ chạy được dạng khám phá |
| 3 | Recurring event được flatten hay giữ nguyên rrule? 3 loại edit (this/this-and-following/all) propagate đúng thế nào? (mục 1.3) | Chặn TC-SYNC-04…07 ở mức kỳ vọng cụ thể (bảng DT-SYNC-1 hiện là suy luận hợp lý, chưa xác nhận) |
| 4 | `uid` mỗi event lấy từ đâu, có lớp ánh xạ ổn định riêng ngoài `EventKit eventIdentifier` không? (mục 1.4) | Ảnh hưởng mức độ nghiêm trọng thật của TC-SYNC-08 |
| 5 | Timezone có xử lý per-event khi event set khác timezone lịch chính không? Receiver-side convert theo timezone máy thật hay hiển thị nguyên giờ Owner? (mục 1.5) | Chặn toàn bộ DT-SYNC-2/TC-SYNC-09…12 ở mức kỳ vọng — đây là nhóm rủi ro P1 cao nhất của cả file này, nên ưu tiên hỏi PM/dev trước |
| 6 | Có giới hạn số event/dung lượng payload nào được cam kết không? (mục 1.6) | Chặn TC-SYNC-13 ở mức xác định ngưỡng pass/fail cụ thể, hiện chỉ quan sát |
| 7 | Owner-side action (Create/Stop/edit/Renew) khi offline: chặn + báo lỗi ngay, hay optimistic UI rồi đồng bộ sau? (mục 1.7) | Chặn TC-SYNC-17…20 ở mức kỳ vọng cụ thể — **đặc biệt TC-SYNC-18 (Stop sharing)**, vì optimistic-fail ở đúng action này là rủi ro riêng tư thật |
| 8 | Có giá trị timeout nào được định nghĩa cho network call của sharing không, hay vô thời hạn tới khi OS tự huỷ? (mục 1.7) | Không chặn test (vẫn quan sát được hành vi thật), nhưng không có ngưỡng để assert pass/fail cụ thể cho "quá lâu" |
| 9 | App có tự động retry action đã fail do offline khi mạng có lại không? (mục 1.7) | Chặn TC-SYNC-22 ở mức kỳ vọng — hiện chỉ ghi nhận hành vi thật, không có tài liệu nào cam kết |
| 10 | Action optimistic (nếu có, theo câu #7) có được **persist ra đĩa** để chờ retry, hay chỉ giữ trong memory và mất khi app bị force-quit? (mục 1.8b) | Chặn TC-SYNC-24 ở mức kỳ vọng — nếu mất, đây là bug nghiêm trọng nhất toàn file (mất trạng thái, không chỉ mất 1 event), cần xác nhận cơ chế lưu trữ phía dev |
| 11 | Có ngưỡng thời gian nào khiến `stale` tự chuyển sang trạng thái khác không (vd sau X ngày offline)? (mục 1.8c) | Chặn TC-SYNC-25 ở mức xác định ngưỡng — hiện theo chữ tài liệu phải là vô thời hạn |

**Khuyến nghị ưu tiên hỏi:** mục #5 (timezone), mục #7 (offline cho Stop sharing), và mục #10 (persist optimistic
action) trước tiên — cả 3 đều là rủi ro **riêng tư/mất trạng thái thật**, không phải cosmetic. Mục #5 vì đây là
nhóm rủi ro duy nhất trong file này có khả năng gây lỗi **thấy được ngay ở mọi lần test cơ bản** (không cần chờ
edge case hiếm như DST hay recurring), ảnh hưởng trực tiếp giá trị cốt lõi "share 1 lịch sống động". Mục #7 và
#10 đi cùng nhau vì #10 chính là kịch bản **tệ nhất** của #7: nếu optimistic UI không persist state chờ retry,
Owner force-quit app lúc offline sẽ mất luôn dấu vết rằng Stop sharing chưa thực sự thành công — share sống mãi
mà không còn tín hiệu lỗi nào sót lại để user nhận ra (mục 1.8b, TC-SYNC-24).
