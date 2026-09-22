# Câu hỏi cần Dev xác nhận — Ink: Định danh, Chia sẻ, Đồng bộ, Sao lưu

> **Nguồn:** phát hiện khi QC đọc chi tiết
> [ink-identity-sync-flow.html](../../specs/ink-identity-sync-flow/ink-share-last-update/ink-identity-sync-flow.html)
> (kiến trúc final trước release, worker PR #16–#20, cập nhật 2026-09-18) để lập test plan ISTQB.
> **Mục đích:** 17 câu hỏi dưới đây tài liệu không trả lời được — cần dev xác nhận trước khi QC chốt mức độ
> ưu tiên rủi ro và hoàn thiện test case. Các trích dẫn "§N" trỏ về đúng 8 mục (0–7) của tài liệu HTML gốc.
> **Test plan đầy đủ (nội bộ QC):** [ink-identity-sync-flow-test-plan.md](ink-identity-sync-flow-test-plan.md)
> **Trạng thái:** mục A–H (Q1–Q17) **đã được trả lời** ngày 2026-09-18 — xem
> [ink-identity-sync-flow-answers-from-dev.md](ink-identity-sync-flow-answers-from-dev.md). Mục **I (Q18–Q19)**
> ở cuối file là câu hỏi **mới, chưa trả lời** — gửi riêng phần này cho dev nếu chỉ muốn hỏi phần còn thiếu.

---

## A. Ưu tiên cao — ảnh hưởng trực tiếp đánh giá mức độ bảo mật/riêng tư, cần trả lời trước

### Q1. Phạm vi thật của "pull chưa bắt buộc token ở server" rộng tới đâu?

Chỉ người **từng là member** của 1 share (kể cả đã bị revoke) mới pull được dữ liệu, hay **bất kỳ ai** biết
đúng `share_id` — kể cả người **chưa từng Join** — cũng pull được?

Đi kèm: `shares.id` (giá trị lộ ra công khai trong link `inkcalendar.app/s/<id>`) là chuỗi **đoán được** (số
nguyên tự tăng) hay **UUID ngẫu nhiên**?

- **Vị trí trong tài liệu:** §3 — *"Thu hồi chặn GHI, chưa chặn ĐỌC. Pull hiện chưa bắt buộc token ở phía
  server, nên chưa lọc được theo người."* §6 không nói rõ kiểu dữ liệu của khoá `id`.
- **Vì sao cần biết:** nếu `share_id` vừa đoán được (số tự tăng) vừa pull không gate token, kết hợp với trang
  preview công khai không cần đăng nhập (§2) — đây là công thức đầy đủ cho việc dò quét toàn bộ dữ liệu share
  đang tồn tại trong hệ thống bằng cách duyệt tuần tự `/s/1`, `/s/2`... Mức độ rủi ro riêng tư thật có thể
  **rộng hơn nhiều** so với "chỉ người bị revoke vẫn đọc được".
- **Trả lời của dev:**

### Q2. Cơ chế "push tự ghi danh thành viên lần đầu gặp" áp dụng trong điều kiện nào?

Bất kỳ uid nào push dữ liệu cho 1 `share_id` hợp lệ đều tự động có dòng `share_members` (dù **chưa từng** gọi
Join qua §2), hay cơ chế này chỉ áp dụng riêng cho trường hợp owner tự seed dữ liệu của chính mình?

- **Vị trí trong tài liệu:** §3 — lý do đưa ra cho quyết định dùng tombstone (`revoked_at`) thay vì xoá hẳn
  dòng khi revoke: *"push tự ghi danh thành viên lần đầu gặp, xoá hẳn dòng thì ngay request sau nó được tạo
  lại"*.
- **Vì sao cần biết:** nếu áp dụng rộng cho mọi uid, đây có thể là 1 đường vào share **ngoài luồng Join chính
  thức** ở §2 — 1 uid chưa từng Join nhưng gọi thẳng API push cho 1 `share_id` đã biết có thể tự trở thành
  member (`role=NULL`, theo quyền của link).
- **Trả lời của dev:**

### Q3. Join lại bằng đúng uid đã bị revoke — endpoint Join có kiểm `revoked_at` trước khi ghi không?

1 uid đã bị owner revoke khỏi share (`revoked_at` có giá trị), vẫn còn giữ link, bấm lại nút **Join** tường
minh (dùng đúng uid cũ, không đăng nhập ẩn danh lại để lấy uid mới) — endpoint `POST
/api/ink/share/:id/join` có kiểm tra `revoked_at` hiện có trước khi upsert không, hay coi đây là "chưa có
dòng" và vô tình xoá/reset `revoked_at`?

- **Vị trí trong tài liệu:** §5 (ý nghĩa "vĩnh viễn" của mã `revoked`) + §2 (Join) + §3 (cơ chế tombstone) —
  không mục nào trong tài liệu mô tả tương tác giữa hành động Join và `revoked_at` đã tồn tại.
- **Vì sao cần biết:** nếu Join không kiểm, đây là 1 đường **tự-undo-revoke** — nguy hiểm hơn đường đã biết
  ở §3 (qua push ngầm) vì Join là action user **chủ động bấm bình thường qua UI**, không cần hiểu cơ chế kỹ
  thuật nào để vô tình (hoặc cố ý) kích hoạt.
- **Trả lời của dev:**

---

## B. Đăng nhập & định danh (uid)

### Q4. Firebase ID token hết hạn giữa phiên có được app tự refresh không?

Token Firebase thường hết hạn sau ~1 giờ — app có tự động refresh ngầm trong 1 phiên sử dụng dài hay không?

- **Vị trí trong tài liệu:** không được nhắc tới ở §1 lẫn §5 (chỉ có mã `app_check_failed` có quy tắc retry
  rõ ràng — 1 cơ chế khác, không phải Firebase Auth token).
- **Vì sao cần biết:** cần tách biệt case "token Firebase tự hết hạn" khỏi 2 mã lỗi `unauthorized`/
  `app_check_failed` đã có, để viết đúng test case.
- **Trả lời của dev:**

---

## C. Chia sẻ & Join (§2)

### Q5. "Bấm Join" trên trang preview (mở trong trình duyệt) lấy uid từ đâu?

Anonymous sign-in được thực hiện ngay trên trình duyệt (tạo 1 uid riêng, khác uid của app iOS), hay nút Join
deep-link mở app Ink để app dùng đúng uid của chính nó hoàn tất việc join?

- **Vị trí trong tài liệu:** §2 chỉ nói "Mở `inkcalendar.app/s/<id>` **trong trình duyệt**" rồi "Bấm Join →
  ghi `share_members`" — không mô tả cơ chế lấy uid ở bước trung gian này.
- **Vì sao cần biết:** nếu 2 luồng (web/app) không hợp nhất đúng, 1 người có thể vô tình có **2 uid khác
  nhau** cho cùng 1 lần join — ảnh hưởng trực tiếp việc họ có nhận được đồng bộ đúng trên app hay không.
- **Trả lời của dev:**

### Q6. 1 lịch có được phép có nhiều `shares` (nhiều link) active cùng lúc không?

- **Vị trí trong tài liệu:** §2 không đề cập giới hạn số lượng share cho 1 calendar.
- **Vì sao cần biết:** double-tap nút Share, hoặc share lại 1 lịch đã share trước đó — cần biết có tạo thêm
  1 link thứ 2 độc lập hay bị chặn/tái sử dụng link cũ.
- **Trả lời của dev:**

### Q7. Join đúng lúc share vừa bị Stop/xoá bởi owner (race giữa 2 người) — báo lỗi gì?

- **Vị trí trong tài liệu:** §2 không mô tả nhánh lỗi này.
- **Vì sao cần biết:** người nhận đang xem trang preview thì owner dừng share ngay lúc đó — cần biết hành vi
  lỗi cụ thể để đảm bảo không phải 1 lỗi kỹ thuật khó hiểu.
- **Trả lời của dev:**

---

## D. Đồng bộ push/pull (§3)

### Q8. Batch push nhiều dòng `isDirty` trong 1 request — granularity kiểm quyền thế nào?

Nếu 1 dòng trong batch bị từ chối quyền (vd uid đã bị revoked), các dòng khác trong cùng batch có tiếp tục
được ghi (kiểm quyền theo từng dòng), hay cả batch bị chặn theo (kiểm quyền ở mức cả request)?

- **Vị trí trong tài liệu:** §3 không mô tả chi tiết mức granularity này.
- **Vì sao cần biết:** ảnh hưởng cách viết test case cho toàn bộ luồng push — hiện đang giả định kiểm quyền
  theo từng dòng (per-row), chưa được xác nhận.
- **Trả lời của dev:**

---

## E. Mã lỗi (§5)

### Q9. Sau khi `app_check_failed` retry 1 lần vẫn thất bại, hành vi cuối cùng là gì?

Báo lỗi cho user, chặn hẳn tính năng đó, hay xử lý theo cách khác?

- **Vị trí trong tài liệu:** §5 chỉ nói "thử lại MỘT lần", không mô tả nhánh khi lần retry đó cũng thất bại.
- **Vì sao cần biết:** cần biết trạng thái kết thúc để viết đúng expected result cho test case.
- **Trả lời của dev:**

### Q10. Nếu App Check fail **và** không có token hợp lệ cùng lúc — mã trả về là gì?

`app_check_failed` hay `unauthorized`?

- **Vị trí trong tài liệu:** §5 không công bố thứ tự ưu tiên giữa 2 mã này (khác hẳn cặp `revoked`/
  `read_only` đã nói rõ thứ tự kiểm `revoked` trước).
- **Vì sao cần biết:** cần biết để viết đúng expected result khi cả 2 điều kiện lỗi cùng đúng.
- **Trả lời của dev:**

---

## F. Sao lưu & khôi phục (§4)

### Q11. Lịch `.ink` có bất kỳ cảnh báo nào cho user về rủi ro mất vĩnh viễn khi mất máy không?

- **Vị trí trong tài liệu:** §4 chỉ nói dữ liệu mất ("Có, mất vĩnh viễn"), không nhắc UI/copy cảnh báo nào.
- **Vì sao cần biết:** đây là rủi ro mất dữ liệu thật của người dùng — cần biết có cơ chế thông báo/cảnh báo
  nào trong sản phẩm hay chưa, trước khi release.
- **Trả lời của dev:**

### Q12. Lịch `.ink` chưa từng share hôm nay có được lưu nội dung lên D1 dưới bất kỳ hình thức nào không?

Hay hoàn toàn chỉ tồn tại local trên máy, không có bản sao nào ở server?

- **Vị trí trong tài liệu:** §4 ("mất vĩnh viễn") + §6 ("sắp chứa cả backup RIÊNG TƯ" — thì tương lai) gợi ý
  câu trả lời là KHÔNG, nhưng chưa có câu nào xác nhận tường minh 100%.
- **Vì sao cần biết:** ảnh hưởng cách đánh giá đúng mức độ rủi ro của việc backup `.ink` hôm nay là 0% hay đã
  có 1 phần nào đó âm thầm chạy.
- **Trả lời của dev:**

### Q13. Owner có thay đổi local chưa push, ngay lúc đó bấm Stop sharing — request push dở dang thất bại kiểu gì?

- **Vị trí trong tài liệu:** §4 không mô tả race condition này.
- **Vì sao cần biết:** cần biết hành vi cụ thể để viết test case cho race Stop-sharing-giữa-lúc-đang-push.
- **Trả lời của dev:**

### Q14. Member `.joined` offline dài, owner Stop sharing trong lúc đó — khi có mạng lại, member thấy gì?

"No longer shared" rõ ràng, hay lỗi kỹ thuật khó hiểu vì `calendar_id` phía server đã biến mất hoàn toàn
(khác việc chỉ đổi trạng thái share)?

- **Vị trí trong tài liệu:** §4 xác nhận `DELETE share` xoá hẳn `calendars`, không chỉ đổi cờ trạng thái.
- **Vì sao cần biết:** cần đảm bảo receiver nhận đúng thông báo dễ hiểu, không phải lỗi lạ do dữ liệu biến
  mất đột ngột.
- **Trả lời của dev:**

---

## G. Mô hình dữ liệu (§6)

### Q15. `calendar_events` có bị cascade-xoá ở tầng DB khi `calendars` row bị xoá không?

Hay trở thành dòng mồ côi (`calendar_id` trỏ vào chỗ không còn tồn tại, nhưng nội dung event vẫn còn nguyên
trên D1)?

- **Vị trí trong tài liệu:** §6 (cấu trúc khoá `(id, calendar_id)`) + §4 (`DELETE share` xoá `calendars`) —
  không mục nào xác nhận hành vi cascade.
- **Vì sao cần biết:** nếu là mồ côi, lời khẳng định "ngừng chia sẻ = xoá sạch" ở §4 **không đúng ở tầng dữ
  liệu thật** — đây là rủi ro data-retention/privacy chưa từng được ghi nhận (nội dung riêng tư tồn tại vĩnh
  viễn dù owner tin đã xoá).
- **Trả lời của dev:**

### Q16. Có tài liệu schema đầy đủ (danh sách cột) cho 4 bảng dữ liệu ở nơi khác không?

(`calendars`, `calendar_events`, `shares`, `share_members`)

- **Vị trí trong tài liệu:** §6 chỉ mô tả khái niệm + khoá chính, không liệt kê cột. Các cột như `owner_uid`,
  `updated_by` (§0), `link_role` (§3) nằm rải rác ở nhiều mục khác nhau.
- **Vì sao cần biết:** để QC viết thêm test case chi tiết hơn (EP/BVA theo từng cột) nếu cần, không bắt buộc
  cho phạm vi test hiện tại.
- **Trả lời của dev:**

---

## H. Khác

### Q17. Ngưỡng rate limit theo uid là bao nhiêu?

Tính theo endpoint nào, cửa sổ thời gian nào (vd bao nhiêu request/phút)?

- **Vị trí trong tài liệu:** §0 chỉ nói "đếm trần rate limit theo ai", không có con số cụ thể nào.
- **Vì sao cần biết:** không viết được test case boundary cụ thể cho rate limit nếu thiếu ngưỡng, chỉ xác
  nhận được nguyên tắc "đếm theo uid".
- **Trả lời của dev:**

---

## I. Vòng 2 (2026-09-19) — phát hiện backend + đối chiếu UI/UX thật (PR #260/#274)

> Q18–Q19: đọc lại câu trả lời vòng 1 lộ ra 2 endpoint backend **có thật, đang chạy**, nhưng **không nằm
> trong `ink-identity-sync-flow.html` gốc** (§0–§7) — chỉ xuất hiện như chi tiết phụ trong câu trả lời Q15/Q17.
> Q20: phát hiện khi tích hợp bàn giao QC cho PR #260/#274 (`qc-sharing-account-pro.md`) vào test plan — UI
> có 1 khái niệm mới ("Time range") hoàn toàn không khớp với bất kỳ mô tả sync nào ở vòng 1.

### Q18. `DELETE /api/ink/account` là gì trong sản phẩm, và ảnh hưởng gì tới share của NGƯỜI KHÁC?

Endpoint này khác Sign out ra sao (có xác nhận 2 bước không, UI nào dẫn tới nó)? Và cụ thể hơn: uid A gọi
`DELETE /api/ink/account` trong khi A đang là **member** (không phải owner) của 1 share thuộc về uid B khác
— dòng `share_members` của A trong share của B có bị dọn/tombstone theo không, hay trở thành **mồ côi** (uid
A không còn tồn tại nhưng dòng member vẫn còn nguyên trên D1)?

- **Vị trí trong tài liệu:** không có ở §0–§7. Chỉ được nhắc tới trong câu trả lời Q15 (answers-from-dev.md):
  *"`DELETE /api/ink/account` cũng cùng thứ tự: events → calendars → shares, quét theo `calendars.owner_uid`"*
  — câu trả lời đó chỉ nói về dữ liệu **uid đó sở hữu** (owner_uid), không nói về vai trò **member** của uid
  đó trong share của người khác.
- **Vì sao cần biết:** nếu mồ côi, đây là rủi ro data-integrity — dòng `share_members` trỏ tới 1 uid không
  còn tồn tại có thể gây lỗi khi owner B xem danh sách thành viên, hoặc khi hệ thống tính rate limit/quyền
  dựa trên uid đó.
- **Trả lời của dev:**

### Q19. `POST /share/:id/unlock` dùng để làm gì?

Ai gọi (owner hay member), gọi vào lúc nào trong luồng sản phẩm, có liên quan gì tới các mã lỗi
`read_only`/`revoked` đã có ở §5, hay tới `link_role`/`member.role` ở §3 không?

- **Vị trí trong tài liệu:** không có ở §0–§7. Chỉ xuất hiện đúng 1 lần, trong bảng rate limit ở câu trả lời
  Q17: *"`POST /share/:id/unlock` — 30/giờ mỗi share · 60/giờ mỗi IP"* — không có mô tả chức năng nào kèm theo.
- **Vì sao cần biết:** hiện chỉ viết được test case đo ranh giới rate limit (TC-F13-01/02 trong test plan),
  hoàn toàn không test được hành vi chức năng thật vì chưa biết endpoint này làm gì.
- **Trả lời của dev:**

### Q20. "Time range" (Next 3/6/12 months · All upcoming) ở màn Share hoạt động ở tầng nào của backend?

Đây là bộ lọc chỉ áp dụng **lúc seed ban đầu** (khi tạo share, quyết định event nào được đưa vào batch ghi
`calendar_events` lần đầu), hay là một ràng buộc **còn hiệu lực cho mọi lần sync sau đó**?

Cụ thể: owner tạo 1 event **mới** sau khi đã share (vd 13 tháng sau ngày share, với Time range đã chọn lúc
tạo là "12 months") — event đó có được đồng bộ sang receiver bình thường, hay bị chặn vĩnh viễn vì "ngoài
time range đã chốt lúc tạo link"?

- **Vị trí trong tài liệu:** không có ở `ink-identity-sync-flow.html` (§0–§7) — khái niệm "window"/khoảng thời
  gian giới hạn hoàn toàn không được nhắc tới trong bất kỳ câu trả lời nào ở vòng 1 (Q1–Q17); §3 mô tả cơ chế
  sync là push/pull row-level theo `isDirty` + cursor `since`, không có khái niệm bounded date range. "Time
  range" chỉ xuất hiện trong tài liệu UI/UX PR #260/#274 (`qc-sharing-account-pro.md` §3.2), không có trong
  tài liệu kiến trúc backend.
- **Vì sao cần biết:** nếu Time range chỉ áp dụng lúc seed và không ảnh hưởng sync về sau, thì lời hứa "đồng
  bộ sống động" của §3 vẫn đúng hoàn toàn. Nếu nó là 1 ràng buộc còn hiệu lực mãi mãi (giống khái niệm
  "window" ở phiên bản kiến trúc cũ hơn), đây là 1 giới hạn quan trọng chưa được tài liệu hoá ở bất kỳ đâu,
  ảnh hưởng trực tiếp cách viết test case cho TC-F3-19 (đổi Time range sau khi đã tạo link) và toàn bộ kỳ
  vọng về tính "sống động" của mọi share.
- **Trả lời của dev:**

---

## J. Vòng 3 (2026-09-20) — phát hiện khi đối chiếu `login-backup-share-sync.md`

> Tài liệu tham chiếu hệ thống mới (`requirements/specs/login-backup-share-sync.md`, verified against `main`
> 2026-09-20) trả lời phần lớn Q18–Q20 ở vòng 2, nhưng mở ra 3 câu hỏi mới khi đọc kỹ — chủ yếu vì nó giới
> thiệu 2 tính năng hoàn toàn mới (Backup sync, Unlock mật khẩu) mà chưa mô tả đủ chi tiết vận hành.

### Q21. Mật khẩu cho 1 share được đặt ở đâu/khi nào? Unlock token dùng tiếp thế nào?

`POST /share/:id/unlock` đổi mật khẩu lấy unlock token (đã xác nhận, đóng Q19) — nhưng tài liệu không nói
mật khẩu được **đặt** ở route nào (một field trong `POST /share` lúc tạo? một route `PATCH` riêng sau đó?),
và unlock token nhận được dùng tiếp ra sao — có bắt buộc gửi kèm khi gọi `GET /share/:id` hoặc
`GET /share/:id/page` không, hay chỉ ảnh hưởng phía UI web?

- **Vị trí trong tài liệu:** `login-backup-share-sync.md` §4, dòng `POST /share/:id/unlock` — chỉ ghi "Password
  → unlock token", không mô tả luồng đặt mật khẩu hay cách dùng token sau đó.
- **Vì sao cần biết:** TC-F16-01 (đặt mật khẩu để test unlock) và TC-F16-03 (share không đặt mật khẩu thì
  `/unlock` làm gì) hiện chưa viết được đầy đủ.
- **Trả lời của dev:**

### Q22. `identity-model.md` (device-vs-account grant tiering) — xin file này, và `subject_type` có gì ngoài uid?

`share_members` đã đổi khoá chính thành `(share_id, subject_type, subject_id)` thay vì `(share_id, uid)` như
tài liệu kiến trúc cũ (§6, `ink-identity-sync-flow.html`). `login-backup-share-sync.md` trỏ tới 1 companion
doc `identity-model.md` mô tả "device-vs-account grant tiering" nhưng QC chưa có file này.

- **Vị trí trong tài liệu:** `login-backup-share-sync.md`, bảng companion docs (đầu file) + §1 (định nghĩa khoá
  `share_members`).
- **Vì sao cần biết:** nếu `subject_type` có giá trị khác ngoài "uid" (vd "device_id" như 1 trục cấp quyền
  song song), ma trận quyền DT1 (mục 5.4 test plan, dựa hoàn toàn vào `member.role`/`link_role` theo uid) có
  thể **chưa đầy đủ** — cần xin file `identity-model.md` để đọc trực tiếp, không suy đoán thêm.
- **Trả lời của dev:**

### Q23. `GET /share/:id/sync` (pull) hôm nay có thật sự check quyền/`revoked` theo subject không?

Route table mới ghi pull nhận "anonymous OR Bearer (owner-device bypass via `X-Device-Id`)" — khác hẳn mô tả
cũ (`handleInkShareSyncPull` không nhận `request`, tức hoàn toàn không có auth check nào). Đây có phải là
phần fix "pull sắp bắt buộc token" đã được dev nhắc ở vòng 1 (đóng 1 phần Open #9), hay chỉ là chấp nhận thêm
1 loại auth mà vẫn trả full data không lọc theo quyền?

- **Vị trí trong tài liệu:** `login-backup-share-sync.md` §4, dòng `GET /share/:id/sync?since=<cursor>`.
- **Vì sao cần biết:** quyết định trực tiếp TC-F7-03/TC-F7-04 (mục 10.4) có cần viết lại theo hành vi mới hay
  giữ nguyên như hành vi cũ (revoke chỉ chặn ghi, chưa chặn đọc).
- **Trả lời của dev:**

---

*File này trích xuất từ phần "Open" của test plan nội bộ QC để tiện gửi trực tiếp cho dev. Vòng 1 (Q1–Q17) đã
được trả lời đầy đủ ngày 2026-09-18 — xem
[ink-identity-sync-flow-answers-from-dev.md](ink-identity-sync-flow-answers-from-dev.md). Vòng 2 (Q18–Q20)
phần lớn đã được trả lời gián tiếp qua tài liệu `login-backup-share-sync.md` (2026-09-20) — xem mục 14.2 của
test plan. Sau khi có câu trả lời cho Vòng 3 (Q21–Q23), cập nhật ngược lại vào
[ink-identity-sync-flow-test-plan.md](ink-identity-sync-flow-test-plan.md) mục 14.6.*
