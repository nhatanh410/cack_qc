# Câu hỏi cần Dev xác nhận — Ink: Định danh, Chia sẻ, Đồng bộ, Sao lưu

> **Nguồn:** phát hiện khi QC đọc chi tiết
> [ink-identity-sync-flow.html](../specs/Ink%20Login%20and%20sharing%20calendar%20docs/ink-share-last-update/ink-identity-sync-flow.html)
> (kiến trúc final trước release, worker PR #16–#20, cập nhật 2026-09-18) để lập test plan ISTQB.
> **Mục đích:** 17 câu hỏi dưới đây tài liệu không trả lời được — cần dev xác nhận trước khi QC chốt mức độ
> ưu tiên rủi ro và hoàn thiện test case. Các trích dẫn "§N" trỏ về đúng 8 mục (0–7) của tài liệu HTML gốc.
> **Test plan đầy đủ (nội bộ QC):** [ink-identity-sync-flow-test-plan.md](ink-identity-sync-flow-test-plan.md)

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

**Không đoán được.** `generateShareId()` (`src/ids.ts`) sinh 24 ký tự từ `crypto.getRandomValues` trên bảng 62 ký tự ≈ **143 bit entropy**. Không phải số tự tăng, không tuần tự. Duyệt `/s/1`, `/s/2` là bất khả thi — kịch bản quét toàn hệ thống trong câu hỏi **không tồn tại**.

**Nhưng phạm vi đọc đúng là "bất kỳ ai biết id"**, không chỉ member cũ. Pull hôm nay không kiểm token nào cả (`handleInkShareSyncPull` thậm chí không nhận `request`). Nên ai có link — kể cả người bị revoke, kể cả người được forward link — đều pull được.

Đây là hành vi **cố ý từ đầu** của link sharing ("có link là xem được"), không phải lỗ hổng mới. Cái *mới* là nó khiến việc revoke chỉ chặn ghi. Đang sửa: server sắp bắt buộc token trên pull + kiểm membership, chặn sau bản build tới.


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

**Áp dụng cho mọi uid, không riêng owner** — và thứ tự kiểm đúng như QC nghi ngờ:

```
ink-share-sync.ts:239   ensureMembership(...)      ← ghi danh ở đây
ink-share-sync.ts:247   if (effectiveRole !== "editor") → 403 read_only
```

Nên một uid **chưa từng Join**, push thẳng vào một `share_id` hợp lệ, **sẽ có dòng `share_members`** — rồi mới bị từ chối nếu link là viewer.

**Họ không giành thêm quyền gì**: `role = NULL` nghĩa là theo link, y hệt người Join bình thường. Nhưng nó **làm bẩn danh sách thành viên của owner** bằng những người chưa bao giờ bấm Join. Đây là phát hiện hợp lệ, tôi ghi nhận là nợ kỹ thuật (xem phần cuối file).


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

**Có kiểm.** `handleInkShareJoin` đọc `revoked_at` **trước** khi upsert:

```ts
if (existing !== null && existing.revoked_at !== null) {
  return json({ ..., error_code: "revoked" }, 403);
}
```

Và câu upsert khi join **không đụng tới cột `role` lẫn `revoked_at`** (`DO UPDATE SET display_name = ...` thôi). Không có đường tự-undo-revoke qua Join.

Đó chính là lý do revoke dùng tombstone: nếu xoá hẳn dòng thì `ensureMembership` ở Q2 sẽ tạo lại ngay request sau.


---

## B. Đăng nhập & định danh (uid)

### Q4. Firebase ID token hết hạn giữa phiên có được app tự refresh không?

Token Firebase thường hết hạn sau ~1 giờ — app có tự động refresh ngầm trong 1 phiên sử dụng dài hay không?

- **Vị trí trong tài liệu:** không được nhắc tới ở §1 lẫn §5 (chỉ có mã `app_check_failed` có quy tắc retry
  rõ ràng — 1 cơ chế khác, không phải Firebase Auth token).
- **Vì sao cần biết:** cần tách biệt case "token Firebase tự hết hạn" khỏi 2 mã lỗi `unauthorized`/
  `app_check_failed` đã có, để viết đúng test case.
- **Trả lời của dev:**

**Có, Firebase SDK tự refresh.** App gọi `Auth.auth().currentUser?.getIDToken()` trước mỗi request; hàm này tự đổi token mới khi cái cũ sắp/đã hết hạn. App không cache token thủ công.

Nên "token hết hạn giữa phiên" **không phải một case người dùng gặp được** trong điều kiện bình thường. `unauthorized` chỉ xảy ra khi: không có mạng lúc refresh, tài khoản bị xoá/vô hiệu phía Firebase, hoặc `FIREBASE_AUTH_PROJECT_IDS` sai cấu hình.


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

**App làm việc join, bằng đúng uid của app. Không có uid nào sinh ra trên trình duyệt.**

Trang web chỉ render preview rồi đưa một deep link `ink://share?url=<json endpoint>` (`src/share-view.ts:73`). Bấm Join mở app Ink, app đọc payload rồi gọi `POST /api/ink/share/:id/join` với token của chính nó.

Trang web **không có Firebase Auth**, không gọi API nào có token. Rủi ro "2 uid cho một lần join" không tồn tại.


### Q6. 1 lịch có được phép có nhiều `shares` (nhiều link) active cùng lúc không?

- **Vị trí trong tài liệu:** §2 không đề cập giới hạn số lượng share cho 1 calendar.
- **Vì sao cần biết:** double-tap nút Share, hoặc share lại 1 lịch đã share trước đó — cần biết có tạo thêm
  1 link thứ 2 độc lập hay bị chặn/tái sử dụng link cũ.
- **Trả lời của dev:**

**Được, không có giới hạn nào cả** — cả server lẫn client.

`POST /api/ink/share` mint một share id mới mỗi lần gọi, không kiểm calendar đó đã có share chưa. Client cũng không chặn: mỗi lần bấm Share là một link độc lập, trỏ vào một hàng `calendars` **mới** (server tự mint calendar id).

Nên double-tap = 2 link, 2 calendar, 2 bản sao event trên server. Đây là nợ kỹ thuật thật, chưa xử lý.


### Q7. Join đúng lúc share vừa bị Stop/xoá bởi owner (race giữa 2 người) — báo lỗi gì?

- **Vị trí trong tài liệu:** §2 không mô tả nhánh lỗi này.
- **Vì sao cần biết:** người nhận đang xem trang preview thì owner dừng share ngay lúc đó — cần biết hành vi
  lỗi cụ thể để đảm bảo không phải 1 lỗi kỹ thuật khó hiểu.
- **Trả lời của dev:**

**404 `Share not found`.** Cả `handleInkShareJoin` lẫn `readShare` đều trả 404 khi hàng `shares` không còn.

Phía client, `ImportSharedCalendarViewModel.failure(for:)` map `InkShareApiError.notFound` → `.unavailable`, hiện thông báo "link không còn khả dụng" chứ không phải lỗi kỹ thuật.


---

## D. Đồng bộ push/pull (§3)

### Q8. Batch push nhiều dòng `isDirty` trong 1 request — granularity kiểm quyền thế nào?

Nếu 1 dòng trong batch bị từ chối quyền (vd uid đã bị revoked), các dòng khác trong cùng batch có tiếp tục
được ghi (kiểm quyền theo từng dòng), hay cả batch bị chặn theo (kiểm quyền ở mức cả request)?

- **Vị trí trong tài liệu:** §3 không mô tả chi tiết mức granularity này.
- **Vì sao cần biết:** ảnh hưởng cách viết test case cho toàn bộ luồng push — hiện đang giả định kiểm quyền
  theo từng dòng (per-row), chưa được xác nhận.
- **Trả lời của dev:**

**Kiểm quyền ở mức CẢ REQUEST, không phải từng dòng.** Giả định per-row của QC không đúng.

Trình tự trong `handleInkShareSyncPush`: verify token → đọc share → `ensureMembership` → tính `effectiveRole` → **403 và return** nếu không phải editor → *sau đó mới* vào vòng lặp `for (const mutation of mutations)`.

Nên: một uid bị revoked → **cả batch bị chặn**, không dòng nào ghi. Không có trạng thái ghi một phần vì lý do quyền.

(Ghi một phần *vẫn có thể xảy ra* vì lý do khác: vòng lặp ghi từng mutation một, không trong transaction. Một lỗi D1 giữa chừng để lại các dòng trước đó đã ghi. Client chịu được điều này vì LWW theo `updated_at`.)


---

## E. Mã lỗi (§5)

### Q9. Sau khi `app_check_failed` retry 1 lần vẫn thất bại, hành vi cuối cùng là gì?

Báo lỗi cho user, chặn hẳn tính năng đó, hay xử lý theo cách khác?

- **Vị trí trong tài liệu:** §5 chỉ nói "thử lại MỘT lần", không mô tả nhánh khi lần retry đó cũng thất bại.
- **Vì sao cần biết:** cần biết trạng thái kết thúc để viết đúng expected result cho test case.
- **Trả lời của dev:**

`sendAttested` thử lại đúng một lần với token vừa attest lại. Lần hai hỏng thì **không có xử lý đặc biệt** — 401 được trả về như một lỗi HTTP bình thường và đi theo đường lỗi của từng call site:

- **push**: `SharedCalendarSyncEngine` nuốt lỗi (`try?`) → **im lặng**, dòng ở lại `isDirty`, thử lại ở lần sync sau
- **join**: rơi vào `catch` → hiện snackbar
- **createShare**: ném `InkShareApiError.httpStatus(401)` → UI báo lỗi

Không có chỗ nào "chặn hẳn tính năng". Trạng thái kết thúc là: thao tác đó thất bại, lần sau thử lại.


### Q10. Nếu App Check fail **và** không có token hợp lệ cùng lúc — mã trả về là gì?

`app_check_failed` hay `unauthorized`?

- **Vị trí trong tài liệu:** §5 không công bố thứ tự ưu tiên giữa 2 mã này (khác hẳn cặp `revoked`/
  `read_only` đã nói rõ thứ tự kiểm `revoked` trước).
- **Vì sao cần biết:** cần biết để viết đúng expected result khi cả 2 điều kiện lỗi cùng đúng.
- **Trả lời của dev:**

**`app_check_failed` thắng.** App Check chạy trong router (`src/index.ts`) **trước khi** handler được gọi:

```ts
const notFromApp = await checkAppCheck(request, env, "ink-share-sync");
if (notFromApp) return notFromApp;      // ← return luôn
return handleInkShareSyncPush(...);      // ← verifyFirebaseIdToken ở trong này
```

Nên khi cả hai điều kiện lỗi cùng đúng, request không bao giờ chạm tới phần kiểm token. Expected result: **401 `app_check_failed`**.


---

## F. Sao lưu & khôi phục (§4)

### Q11. Lịch `.ink` có bất kỳ cảnh báo nào cho user về rủi ro mất vĩnh viễn khi mất máy không?

- **Vị trí trong tài liệu:** §4 chỉ nói dữ liệu mất ("Có, mất vĩnh viễn"), không nhắc UI/copy cảnh báo nào.
- **Vì sao cần biết:** đây là rủi ro mất dữ liệu thật của người dùng — cần biết có cơ chế thông báo/cảnh báo
  nào trong sản phẩm hay chưa, trước khi release.
- **Trả lời của dev:**

**Chưa có cảnh báo nào.** Không có copy, banner hay dialog nào nói với người dùng rằng lịch `.ink` chỉ tồn tại trên máy họ.

Đây là khoảng trống sản phẩm có thật, và nó tồn tại vì backup được thiết kế để đóng nó — kho chứa phía server đã có, nhưng đường đưa dữ liệu lên thì chưa (xem Q12). Trước khi backup xong, đây là rủi ro mất dữ liệu **không được thông báo**.


### Q12. Lịch `.ink` chưa từng share hôm nay có được lưu nội dung lên D1 dưới bất kỳ hình thức nào không?

Hay hoàn toàn chỉ tồn tại local trên máy, không có bản sao nào ở server?

- **Vị trí trong tài liệu:** §4 ("mất vĩnh viễn") + §6 ("sắp chứa cả backup RIÊNG TƯ" — thì tương lai) gợi ý
  câu trả lời là KHÔNG, nhưng chưa có câu nào xác nhận tường minh 100%.
- **Vì sao cần biết:** ảnh hưởng cách đánh giá đúng mức độ rủi ro của việc backup `.ink` hôm nay là 0% hay đã
  có 1 phần nào đó âm thầm chạy.
- **Trả lời của dev:**

**Không. 0%. Hoàn toàn chỉ local.**

Chỉ có đúng hai chỗ ghi vào `calendar_events`:
- `ink-share.ts` — seed lúc `POST /api/ink/share` (tức là lúc CHIA SẺ)
- `ink-share-sync.ts` — `POST .../sync` (tức là sync của một share)

Không có đường nào đẩy một calendar chưa từng share lên server. Bảng `calendars` cũng chỉ được ghi trong `handleInkShareCreate`.

Câu "sắp chứa cả backup RIÊNG TƯ" ở §6 là **thì tương lai** và tài liệu nói đúng — đó là lý do bảng được đổi tên trước, để khi dữ liệu riêng tư vào thì tên bảng đã không còn nói dối.


### Q13. Owner có thay đổi local chưa push, ngay lúc đó bấm Stop sharing — request push dở dang thất bại kiểu gì?

- **Vị trí trong tài liệu:** §4 không mô tả race condition này.
- **Vì sao cần biết:** cần biết hành vi cụ thể để viết test case cho race Stop-sharing-giữa-lúc-đang-push.
- **Trả lời của dev:**

Push và Stop sharing là hai request độc lập, không có khoá nào giữa chúng. Ba khả năng:

1. Push tới trước → ghi thành công → DELETE xoá luôn cả những dòng vừa ghi
2. DELETE tới trước → push nhận **404** → `SharedCalendarSyncEngine` nuốt lỗi, thay đổi ở lại `isDirty` trên máy owner vĩnh viễn (share đã không còn để đẩy lên)
3. Chạy song song → hành vi tuỳ thứ tự D1 xử lý

Không mất dữ liệu **local** ở cả ba: thay đổi vẫn nằm trên máy owner. Cái mất là thay đổi đó không bao giờ tới được người khác — nhưng share đã bị dừng nên không ai còn nhận nữa.


### Q14. Member `.joined` offline dài, owner Stop sharing trong lúc đó — khi có mạng lại, member thấy gì?

"No longer shared" rõ ràng, hay lỗi kỹ thuật khó hiểu vì `calendar_id` phía server đã biến mất hoàn toàn
(khác việc chỉ đổi trạng thái share)?

- **Vị trí trong tài liệu:** §4 xác nhận `DELETE share` xoá hẳn `calendars`, không chỉ đổi cờ trạng thái.
- **Vì sao cần biết:** cần đảm bảo receiver nhận đúng thông báo dễ hiểu, không phải lỗi lạ do dữ liệu biến
  mất đột ngột.
- **Trả lời của dev:**

Member nhận **404** ở cả pull lẫn push.

Client hiện **không xử lý riêng** case này trên đường sync: `SharedCalendarSyncEngine.pull/push` dùng `try?` nên 404 bị nuốt im lặng. Lịch ở lại trên máy member, hiển thị dữ liệu cũ **mãi mãi**, không có thông báo nào.

Đây là khoảng trống UX thật và tài liệu chưa nói. Nó khác `revoked` (có mã lỗi riêng, client xử lý) — "share bị xoá hẳn" chưa có đường báo cho member.

Liên quan: tôi đang sửa `DELETE /share/:id` để **thôi xoá hàng `calendars`** (chuẩn bị cho backup). Sau thay đổi đó, câu hỏi này cần trả lời lại.


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

**Không mồ côi, và không cần cascade** — thứ tự xoá đã lo việc đó. `handleInkShareDelete` chạy một batch ba câu, **events trước**:

```ts
DELETE FROM calendar_events WHERE calendar_id = ?   // 480
DELETE FROM calendars       WHERE id = ?            // 481
DELETE FROM shares          WHERE id = ?            // 482
```

Cùng một batch nên không có trạng thái nửa vời. Lời khẳng định "ngừng chia sẻ = xoá sạch" ở §4 **đúng ở tầng dữ liệu thật**.

Bổ sung: D1 **có bật foreign key** (tôi đã xác minh bằng thực nghiệm hôm 2026-09-18 trên một D1 tạm — `FOREIGN KEY constraint failed` thật sự được ném). Nên nếu thứ tự bị đảo, D1 sẽ **từ chối** chứ không tạo ra dòng mồ côi. Hai lớp bảo vệ.

`DELETE /api/ink/account` cũng cùng thứ tự: events → calendars → shares, quét theo `calendars.owner_uid`.


### Q16. Có tài liệu schema đầy đủ (danh sách cột) cho 4 bảng dữ liệu ở nơi khác không?

(`calendars`, `calendar_events`, `shares`, `share_members`)

- **Vị trí trong tài liệu:** §6 chỉ mô tả khái niệm + khoá chính, không liệt kê cột. Các cột như `owner_uid`,
  `updated_by` (§0), `link_role` (§3) nằm rải rác ở nhiều mục khác nhau.
- **Vì sao cần biết:** để QC viết thêm test case chi tiết hơn (EP/BVA theo từng cột) nếu cần, không bắt buộc
  cho phạm vi test hiện tại.
- **Trả lời của dev:**

**Có.** Schema đầy đủ nằm ở chính các file migration, có comment giải thích từng quyết định:

- `migrations/0008_calendar_store.sql` — `calendars`, `calendar_events`, và bản dựng lại của `shares`
- `migrations/0009_share_members.sql` — `share_members`

Đây là nguồn chuẩn (repo `worker-ink-lockscreen-calendar`, nhánh `main`). Tài liệu HTML cố ý chỉ mô tả khái niệm để không phải đồng bộ hai nơi.

Lưu ý khi đọc: `shares` **không có** ba cột `shares_location/notes/url` như bản thiết kế §3b — đã bỏ khi chốt "chia sẻ là chia sẻ đầy đủ".


---

## H. Khác

### Q17. Ngưỡng rate limit theo uid là bao nhiêu?

Tính theo endpoint nào, cửa sổ thời gian nào (vd bao nhiêu request/phút)?

- **Vị trí trong tài liệu:** §0 chỉ nói "đếm trần rate limit theo ai", không có con số cụ thể nào.
- **Vì sao cần biết:** không viết được test case boundary cụ thể cho rate limit nếu thiếu ngưỡng, chỉ xác
  nhận được nguyên tắc "đếm theo uid".
- **Trả lời của dev:**

Toàn bộ ngưỡng, theo endpoint:

| Endpoint | Ngưỡng | Đếm theo | Hằng số |
|---|---|---|---|
| `POST /api/ink/share` | **20/giờ** | IP | `CREATE_LIMIT` |
| `POST /share/:id/sync` | **120/giờ** | **(share, uid)** | `SYNC_PUSH_LIMIT_PER_USER` |
| `POST /share/:id/unlock` | 30/giờ mỗi share · 60/giờ mỗi IP | share / IP | `UNLOCK_LIMIT_PER_*` |
| `/ink/help`, `/suggest-event` | 10/phút · 60/giờ | deviceId (đã băm) | `src/ink-help.ts` |
| Lưới trên cùng (endpoint AI) | 30/phút · 200/giờ | IP | `src/quota.ts` |
| Quota ngày `/suggest-event` | 1000/ngày địa phương | deviceId | `src/quota.ts` |

Ba điểm cho việc viết boundary test:

1. **Chỉ sync đếm theo uid.** Các endpoint còn lại vẫn theo IP hoặc deviceId.
2. **Sync là 120/giờ cho MỖI lịch**, không phải mỗi tài khoản — 10 lịch = 1.200 lượt/giờ. Không có trần tổng.
3. **Toàn bộ fail-open**: D1 lỗi thì request **được đi tiếp** (`hitRateLimit` trả `count ?? 1`). Đây là hàng rào chi phí, không phải điều kiện đúng đắn — test case không nên kỳ vọng bị chặn khi D1 hỏng.


---

*File này trích xuất từ phần "Open" của test plan nội bộ QC để tiện gửi trực tiếp cho dev. Sau khi có câu trả
lời, cập nhật ngược lại vào
[ink-identity-sync-flow-test-plan.md](ink-identity-sync-flow-test-plan.md) mục 11.*


---

## Phát hiện từ chính lượt trả lời này (dev tự ghi nhận)

QC không hỏi trực tiếp, nhưng việc tra code để trả lời làm lộ ra ba nợ kỹ thuật:

1. **Q2 — ghi danh trước khi kiểm quyền.** Một uid chưa từng Join, push thẳng vào share id hợp lệ, vẫn để lại dòng `share_members` rồi mới bị 403. Không giành thêm quyền, nhưng làm bẩn danh sách của owner. Sửa: đảo thứ tự, chỉ ghi danh sau khi qua kiểm quyền.
2. **Q6 — một lịch share được vô số lần.** Mỗi lần bấm là một link + một hàng `calendars` mới. Chưa có gì chặn double-tap.
3. **Q14 — share bị xoá không báo cho member.** 404 bị nuốt im lặng, lịch đứng yên hiển thị dữ liệu cũ mãi mãi. Cần một mã lỗi riêng như `revoked` đã có.

Ngoài ra, hai việc đã biết và đang làm: **pull sắp bắt buộc token** (đóng Q1) và **`DELETE` sắp thôi xoá `calendars`** (làm Q14/Q15 phải trả lời lại).

*Trả lời bởi dev 2026-09-18, đối chiếu trực tiếp với `worker-ink-lockscreen-calendar@main` và `lockscreen-calendar@main`.*
