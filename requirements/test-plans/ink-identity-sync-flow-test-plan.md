# Test Plan — Ink: Định danh, Chia sẻ, Đồng bộ, Sao lưu (kiến trúc final trước release)

> **Test basis:**
> 1. [ink-identity-sync-flow.html](../specs/Ink%20Login%20and%20sharing%20calendar%20docs/ink-share-last-update/ink-identity-sync-flow.html)
>    — kiến trúc backend, tự khai mô tả hệ thống **sau** loạt thay đổi 2026-09-18 (worker PR #16–#20), nguồn:
>    `docs/superpowers/plans/2026-09-18-unified-calendar-store.md` §3b. Đọc **độc lập**, không đối chiếu spec
>    sharing nào khác có trước trong repo (mục 1–12 dưới đây). Mọi trích dẫn "§N" trỏ về đúng 8 mục (0–7) của
>    tài liệu HTML này.
> 2. [qc-sharing-account-pro.md](qc-sharing-account-pro.md) — bàn giao QC cho **UI/UX thật đã lên `main`**:
>    PR **#260** (`380bc6b2`) + PR **#274** (`ef996605`), bổ sung 2026-09-19. Đây là **lớp UI/UX** dựng trên
>    đúng backend đã phân tích ở nguồn 1 — tích hợp vào **mục 13**, đối chiếu ngược lại F1–F13 đã có thay vì
>    tách file riêng, để toàn bộ vòng đời tính năng (backend → UI thật) nằm trong 1 tài liệu liền mạch.
> **Chuẩn:** ISTQB Foundation Level
> **Ngày lập:** 2026-09-18 · **Cập nhật:** 2026-09-19 · **Người lập:** QC

---

## 1. Bối cảnh & mô hình hệ thống (tóm tắt từ chính tài liệu)

Tài liệu mô tả 4 luồng treo chung vào một khái niệm: **uid** (Firebase, server-verify được) thay cho khái niệm
cũ **device_id** (tự khai, không xác thực được — §0).

| Thành phần | Vai trò | Nguồn |
|---|---|---|
| App (iOS) | Sinh/giữ uid, gọi API kèm Bearer token, push/pull dữ liệu | §1, §3 |
| Worker (Cloudflare) | Xác thực token, kiểm quyền, ghi D1, sinh label mặc định | §2, §3, §5 |
| D1 | Lưu `calendars` / `calendar_events` / `shares` / `share_members` | §6 |
| Firebase | Ký uid (anonymous + Apple/Google link) | §1 |
| App Check | Chặn caller không phải app thật | §5 |

**4 endpoint AI** (`/ink/help`, `/ink/chat`, `/suggest-event`) **cố ý không cần đăng nhập** — đây là nơi duy
nhất `device_id` còn tồn tại, vì không có uid nào để đếm (§0).

### 1.1 Cơ chế đăng nhập ngầm (§1) — phân tích chi tiết

Ink **không có màn hình đăng nhập bắt buộc**. Mọi máy, kể cả người dùng chưa bao giờ bấm "Sign in" lần nào,
đều có sẵn một `uid` — vì Ink tự động tạo một tài khoản Firebase **ẩn danh** (anonymous) ngay từ lần mở app
đầu tiên. `uid` này là "chứng minh thư" server dùng để biết ai sở hữu lịch nào, ai được đồng bộ vào share nào.

**Luồng từng bước:**

```
App khởi động, cần gọi API (tạo share / sync)
        │
        ▼
InkAccountService.currentUser == nil ?
        │
   ┌────┴────┐
  CÓ rồi      CHƯA có
   │            │
dùng lại      Firebase.signInAnonymously()
   │            │
   │         tạo uid MỚI, không cần email/password,
   │         hoàn toàn im lặng, user không thấy gì
   │            │
   └─────┬──────┘
         ▼
   Keychain lưu uid
   (sống sót qua gỡ-cài-lại app)
```

**Điểm kỹ thuật cần hiểu đúng để thiết kế test:**

- **`signInAnonymously()` là "tạo mới", không phải "lấy lại"** — mỗi lần gọi, Firebase backend tạo một tài
  khoản hoàn toàn mới với `uid` mới. Hàm này **không tự biết** máy đã từng có tài khoản chưa; đó là lý do bắt
  buộc phải tự kiểm `currentUser == nil` **trước** khi gọi, chứ không phải Firebase tự lo việc đó.
- **Keychain, không phải UserDefaults** — Firebase SDK mặc định lưu trạng thái đăng nhập vào Keychain của
  iOS. Keychain **sống sót qua việc gỡ app rồi cài lại** (khác UserDefaults, khác hầu hết local storage khác)
  — đây là cơ chế nền cho phần "khôi phục sau khi cài lại" ở §4. Nó chỉ mất khi user "Erase All Content" cả
  máy hoặc xoá Keychain thủ công.
- **`link(with:)` là "gắn thêm", không phải "chuyển tài khoản"** — điểm hay bị hiểu nhầm nhất. `link(with:)`
  lấy đúng tài khoản ẩn danh **đang có** và gắn thêm credential Apple/Google vào nó, `uid` giữ nguyên y hệt.
  Khác hẳn việc gọi `signIn(with:)` (không phải `link`), vốn sẽ **chuyển sang một tài khoản khác** (uid khác)
  nếu Apple ID/Google đó đã từng đăng nhập ở nơi khác trước đây. Toàn bộ lời hứa "đăng nhập không làm mất gì"
  phụ thuộc vào việc code dùng đúng `link()`, không lỡ dùng `signIn()`.
- **`isAnonymous` ≠ "chưa có uid"** — tài khoản ẩn danh vẫn có `uid` hợp lệ, vẫn gọi API sharing/sync bình
  thường được, nhưng ở tầng UI, app cố ý coi `isAnonymous == true` là "chưa đăng nhập" (`session(for:)` trả
  `.signedOut`). Đây là 2 khái niệm tách biệt: "có định danh để server tin" (luôn đúng ngay từ đầu) vs "đã có
  tài khoản Apple/Google gắn vào" (chỉ đúng sau khi link).

**Vì sao "Enable Auto clean-up" trong Firebase Console nguy hiểm:** đây là tính năng có sẵn của Firebase
Console — tự động **xoá tài khoản ẩn danh không hoạt động quá 30 ngày** ở tầng backend. Nếu bật: user không
mở app 30+ ngày → Firebase âm thầm xoá tài khoản đó ở server → lần mở lại, Keychain vẫn còn `uid` cũ trên
máy nhưng tài khoản đó **không còn tồn tại phía Firebase** → phải tạo tài khoản ẩn danh mới → `uid` mới →
mọi `calendars.owner_uid`/`share_members.uid` từng gắn với `uid` cũ trở thành mồ côi vĩnh viễn, không có
đường khôi phục. Đây không phải bug code mà là **cấu hình hạ tầng** — QC cần xác nhận với backend/infra công
tắc này đang **tắt**, không kỳ vọng test được bằng thao tác trên app.

**Bảng case cụ thể (đối chiếu với test case ở mục 10.1):**

| Tình huống | Điều gì xảy ra theo đúng thiết kế | Case liên quan |
|---|---|---|
| Mở app lần đầu, máy hoàn toàn mới | `currentUser == nil` → `signInAnonymously()` → uid mới, lưu Keychain | TC-F2-01 |
| Mở/tắt app nhiều lần, cùng 1 lượt cài đặt | `currentUser` đã có → **không** gọi lại `signInAnonymously()`, uid giữ nguyên | TC-F2-02 |
| **Bug pattern**: code thiếu check `currentUser == nil` | Mỗi lần mở app = 1 uid mới → mất quyền sở hữu lịch, mất tư cách thành viên đã join trước đó — rủi ro nghiêm trọng nhất trong toàn bộ §1 | TC-F2-03 (P1) |
| Ẩn danh → bấm "Sign in with Apple" | `link(with:)` → uid **không đổi**, chỉ thêm Apple credential | TC-F2-04 |
| Ẩn danh → bấm "Sign in with Google" | Tương tự, uid không đổi | TC-F2-05 |
| Tài khoản ẩn danh, chưa link gì | UI vẫn hiện "chưa đăng nhập" dù uid đã hoạt động được với API | TC-F2-06 |
| Gỡ app, cài lại (không đăng nhập lại thủ công) | Keychain trả lại đúng uid cũ → toàn bộ lịch/quyền cũ còn nguyên | TC-F2-07 |
| Đăng nhập cùng 1 tài khoản Apple/Google trên máy thứ 2 | Cả 2 máy resolve về **cùng 1 uid** | TC-F2-08 |
| Dùng uid ẩn danh (chưa link) để tạo share | Vẫn thành công — server chỉ cần uid hợp lệ, không đòi "đã đăng nhập" theo nghĩa UI | TC-F2-09 |
| Gọi 3 endpoint AI (`/ink/help`, `/ink/chat`, `/suggest-event`) | Không cần token/uid gì cả — nằm ngoài toàn bộ cơ chế này | TC-F2-10 |
| Không mở app 30+ ngày, "Auto clean-up" lỡ bật | Tài khoản ẩn danh bị Firebase xoá ở backend → lần mở lại tạo uid mới → mồ côi dữ liệu cũ | Case hạ tầng, không có TC riêng — xác nhận qua Firebase Console, không test qua app |

**Case chưa được tài liệu trả lời rõ** (đã có ở mục 11, Open #5): Firebase ID token thường hết hạn sau ~1 giờ
— tài liệu không nói app có tự refresh ngầm trong một phiên dài hay không, tách biệt với cơ chế retry của
`app_check_failed`. Cần hỏi dev trước khi viết case cho kịch bản "token Firebase tự hết hạn giữa phiên".

### 1.2 Cơ chế chia sẻ (§2) — phân tích chi tiết: "link là cửa, không phải chìa"

Đây là ẩn dụ trung tâm của §2, nối thẳng sang §3 (quyền/revoke):

- **Link = cái cửa.** Ai cầm được link (`inkcalendar.app/s/<id>`) đều đi tới được cửa — mở trang preview
  công khai, thấy tên/mô tả/số lượng event, và bấm được nút Join. Link **không chứng minh danh tính** ai
  đang cầm nó — không gắn với một uid cụ thể nào.
- **Quyền thật (chìa khoá) = tư cách thành viên (`share_members`, gắn với uid).** Chỉ khi **Join** xong, một
  uid cụ thể mới có "chìa" — một dòng `share_members` với `role` riêng.

Hệ quả trực tiếp (rõ hơn ở §3): **revoke chỉ lấy lại "chìa" của một người, không đập bỏ "cửa".** Link vẫn
đứng nguyên — ai còn giữ link vẫn Join lại được với uid mới. Đây là lý do §3 tự nhận "không phải hàng rào
kín" (đã ghi ở TC-F7-04).

**Luồng 5 bước:**

```
Người gửi                 App → Worker              Worker → D1
Chọn lịch → Share    →    POST /api/ink/share   →   1 batch, 3 bảng:
(không hỏi gì thêm)       + Bearer <uid token>       calendars · shares · calendar_events
                          (thiếu token → 401)         (atomic — không thể tạo share
                                                        mà thiếu calendar/event tương ứng)
                                                              │
                                                              ▼
Người nhận                                          Người nhận
Mở inkcalendar.app/s/<id>  ←──────────────────────  Bấm Join
trong trình duyệt                                    → POST /api/ink/share/:id/join
(chỉ thấy tên·mô tả·SỐ                               → ghi 1 dòng share_members
 LƯỢNG event, KHÔNG BAO                               label = "<tên lịch> · <ngày>"
 GIỜ hiện nội dung event)                             (KHÔNG dùng tên thiết bị)
```

**Điểm kỹ thuật cần hiểu đúng để thiết kế test:**

- **Share = share ĐẦY ĐỦ, không còn toggle từng phần** — mọi field (địa điểm, ghi chú, liên kết) đi hết vào
  payload. Không còn ma trận tổ hợp toggle cần test — chỉ cần xác nhận receiver nhận **đủ** mọi field sau
  sync, không thiếu field nào.
- **Token bắt buộc ngay từ bước tạo share** — thiếu Bearer token thì 401, không tạo share. Nối trực tiếp với
  §1: vì mọi máy luôn có sẵn uid ẩn danh, bước này chỉ fail khi chính luồng lấy token bị lỗi tại thời điểm
  bấm Share.
- **Batch atomic — 3 bảng cùng lúc** — 1 transaction ghi `calendars`+`shares`+`calendar_events`; nếu 1 phần
  thất bại, không phần nào được ghi. Chặn đúng loại bug "share mồ côi" (trỏ vào calendar không có thật). Loại
  lỗi này chỉ lộ ra khi có gián đoạn giữa chừng (mất mạng, app bị kill, server timeout) — cần test chủ động
  ngắt kết nối đúng lúc request đang chạy, không chỉ happy path.
- **Trang preview công khai — ranh giới riêng tư rõ nhất của §2** — không cần đăng nhập/cài Ink, chỉ hiện
  tên/mô tả/số lượng event. Vì là trang public không qua app, **phải verify ở tầng network response thô**
  (không chỉ nhìn UI) — response dư field nội dung event dù UI không hiển thị vẫn là rò rỉ dữ liệu thật.
- **Join sinh label mặc định, không dùng tên thiết bị** — `"<tên lịch> · <ngày>"` do server sinh, cố ý không
  lấy tên thiết bị (thứ gần như luôn lộ tên thật, vd "John's iPhone"). Verify bằng cách đối chiếu label sinh
  ra không chứa bất kỳ phần nào của tên thiết bị.
- **Owner tự seed — race condition đáng chú ý nhất của §2** — owner cũng là một client đồng bộ của chính
  mình; máy owner phải tự seed dữ liệu local rồi push lên như một receiver bình thường. Nếu bước này không
  tự động xảy ra ngay: `shares`/`calendars` đã có (ghi trong batch) nên preview có thể đã hiện tên/mô tả,
  nhưng `calendar_events` vẫn rỗng — cảm giác "đã share xong" trong khi chưa có nội dung event nào. Phải test
  **ngay lập tức** sau khi tạo share, không đợi một chu kỳ sync nào trôi qua.

**Bảng case cụ thể (đối chiếu với test case ở mục 10.2):**

| Tình huống | Điều gì xảy ra theo đúng thiết kế | Case liên quan |
|---|---|---|
| Có lịch sở hữu, bấm Share | Không hỏi gì thêm, gọi ngay `POST /api/ink/share` kèm Bearer token | TC-F3-01 |
| Bấm Share nhưng token null/rỗng | 401, không tạo gì ở D1 (cả 3 bảng) | TC-F3-02 |
| Tạo share thành công | Cả 3 bảng ghi trong cùng 1 batch — không có trạng thái "chỉ 1–2 bảng có" | TC-F3-03 |
| Mở link công khai, không đăng nhập, inspect response thô | Chỉ có tên/mô tả/số lượng — không có field nội dung event nào | TC-F3-04 (P1) |
| Bấm Join lúc chưa có uid | Anonymous sign-in được kích hoạt trước (nối với §1), rồi mới join thành công | TC-F4-01 |
| Join thành công | Label đúng `"<tên lịch> · <ngày>"`, không chứa tên thiết bị | TC-F4-02 |
| Vừa tạo share xong, kiểm tra ngay (không đợi sync) | Preview đã có tên/mô tả; verify `calendar_events` không rỗng — owner đã tự seed & push | TC-F3-07 (P1) |
| 2 uid khác nhau cùng join 1 share | Mỗi uid có 1 dòng `share_members` độc lập | TC-F4-03 |
| Cùng 1 uid bấm Join 2 lần liên tiếp | Không tạo 2 dòng trùng cho `(share_id, uid)` | TC-F4-04 |
| Share có đủ location/notes | Receiver join + sync nhận đủ, không thiếu field nào | TC-F3-05 |

**3 câu hỏi mở mới phát hiện khi đọc sâu §2** (bổ sung vào mục 11):

1. **"Bấm Join" xảy ra ở đâu?** §2 nói mở link "trong trình duyệt", nhưng Join lại tạo `share_members` gắn
   với **uid** — mà cơ chế uid (§1) dựa hoàn toàn vào Firebase SDK + Keychain **trong app iOS**, không phải
   trình duyệt. Nút Join trên web có tự anonymous sign-in ngay trên trình duyệt (uid riêng, khác uid app) hay
   deep-link mở app Ink để app tự gọi API bằng uid của chính nó? Đây là điểm mơ hồ quan trọng nhất của §2 —
   nếu hợp nhất sai, một người có thể vô tình có **2 uid khác nhau** (1 từ web, 1 từ app).
2. **1 lịch có được nhiều share (link) active cùng lúc không?** Không được nói tới. Double-tap Share có tạo 2
   dòng `shares` độc lập (2 link khác nhau cho cùng 1 lịch) hay bị chặn?
3. **Join đúng lúc share vừa bị Stop/xoá (race).** Người nhận đang xem preview thì owner dừng share ngay lúc
   đó — Join thất bại kiểu gì, có báo lỗi rõ ràng không? Không được mô tả.

### 1.3 Cơ chế đồng bộ (§3) — phân tích chi tiết: "push rồi pull, ai đến sau thắng"

**Lưu ý cách đọc tên mục:** "ai đến sau thắng" **không phải** "ai gửi request tới server sau thì thắng" (thứ
tự đến server) — mà là **ai có `updated_at` lớn hơn thì thắng**, bất kể request đó đến server trước hay sau
về mặt thời gian thật. Câu SQL upsert **tự nó** là luật LWW (`WHERE excluded.updated_at >
calendar_events.updated_at`) — không đọc dữ liệu cũ ra rồi so sánh bằng code, mà để chính câu UPDATE có điều
kiện đó quyết định trong 1 lệnh SQL duy nhất.

**Luồng 4 bước:**

```
1 · App                2 · Worker              3 · D1                    4 · App
push                    Kiểm quyền               Upsert LWW                 pull theo cursor
Gửi các dòng    →       revoked → read_only  →   Chỉ ghi đè khi      →      Nhận mọi thay đổi
`isDirty`                → ghi (thứ tự kiểm      `updated_at` mới hơn       sau `since`
                          CỐ Ý theo thứ tự này)   (1 câu SQL, không
                                                   đọc-rồi-so)
```

**Lưu ý:** bước 2 (kiểm quyền) chỉ áp dụng cho **PUSH** (ghi), **không** áp dụng cho **PULL** (đọc) — đây là
gốc của "2 giới hạn" nêu dưới đây.

**Điểm kỹ thuật cần hiểu đúng để thiết kế test:**

- **Server trả lại "bản đang thực sự lưu", không chỉ trả "đã nhận"** — với mọi mutation, kể cả cái vừa
  **thua** trong LWW, server trả về đúng dòng đang lưu thật, không phải dữ liệu client vừa gửi. Máy thua thấy
  ngay bản thắng trong response của chính request đó, không cần đợi 1 lần `pull` riêng. Client chỉ tin "2xx =
  dữ liệu của tôi đã lưu" mà không đọc lại response body là sai.
- **"Ai được ghi" — link là mặc định, membership là ngoại lệ** — `quyền thật = member.role ?? shares.link_role`
  (owner luôn ghi được). `role = NULL` nghĩa là "theo link", không phải "không có quyền". Nếu code lỡ **chụp
  lại** `link_role` vào `member.role` ngay lúc join thay vì để `NULL`, quyền bị nới **vĩnh viễn** khi owner hạ
  quyền link sau này — bug pattern nghiêm trọng nhất của §3 (TC-F6-07, đã lên P1).
- **Revoke = tombstone, và một cơ chế ẩn vừa lộ ra: push tự ghi danh thành viên lần đầu gặp** — không chỉ
  hành động Join tường minh (§2) mới tạo dòng `share_members`; **push cũng tự động tạo dòng này lần đầu gặp
  1 uid** (đây chính là cơ chế đứng sau "owner tự seed" ở §2). Nếu revoke xoá hẳn dòng thay vì tombstone, lần
  push kế tiếp của đúng người bị revoke sẽ bị hiểu là "lần đầu gặp" → tự tạo lại dòng sạch → **hành động thu
  hồi tự huỷ chính nó**. Tombstone là cách duy nhất chặn vòng lặp tự-undo này.
- **Hai giới hạn tự thừa nhận:**
  - *Thu hồi chặn GHI, chưa chặn ĐỌC* — pull hiện chưa bắt buộc token ở server. Đọc kỹ câu này, phạm vi rủi ro
    có thể **rộng hơn** "chỉ người bị revoke vẫn đọc được": nếu pull hoàn toàn chưa đòi token, về nguyên tắc
    **bất kỳ ai** gọi đúng endpoint pull với đúng `share_id` — kể cả người **chưa từng** Join — cũng có thể
    lấy được dữ liệu. Mức độ rủi ro thật phụ thuộc `share_id` có đoán được không (sequential hay UUID), điều
    tài liệu không nói. ⚠️ **Xem Open #9 — cần confirm với dev trước khi đánh giá mức độ nghiêm trọng thật.**
  - *Không phải hàng rào kín* — ai còn giữ link (§2, "cửa") thì đăng nhập ẩn danh lại (uid mới) là Join lại
    được. Cắt thật = đổi link.

**Bảng case cụ thể (đối chiếu với test case đã có ở mục 10.3–10.4, không cần thêm TC mới):**

| Tình huống | Điều gì xảy ra theo đúng thiết kế | Case liên quan |
|---|---|---|
| `link_role=viewer`, `member.role=NULL` | Push bị chặn, mã `read_only` | TC-F6-01 |
| `link_role=viewer`, `member.role=editor` (owner cấp riêng) | Push thành công | TC-F6-02 |
| `link_role=editor`, `member.role=viewer` (owner hạ riêng) | Push bị chặn `read_only` — override thắng dù link đang `editor` | TC-F6-03 |
| Owner hạ cả link về `viewer` | Mọi member `role=NULL` mất quyền ghi ngay, không độ trễ | TC-F6-04 |
| Member đã `revoked_at` | Push bị chặn, mã `revoked` (không phải `read_only`) | TC-F6-05 |
| Owner | Luôn ghi được bất kể trạng thái nào | TC-F6-06 |
| Member join lúc link còn `editor`, owner hạ link sau đó | Member phải bị `read_only` ngay — `member.role` không được "đóng băng" thành `editor` | TC-F6-07 (P1) |
| 2 client ghi gần như đồng thời, `updated_at` khác nhau, thứ tự đến server ngược lại | Dòng có `updated_at` lớn hơn thắng, không theo thứ tự đến server | TC-F5-01 |
| Client thua trong LWW nhận response của chính mutation đó | Response trả đúng bản đang lưu thật (bản thắng) | TC-F5-02 |
| Pull với `since=<cursor cũ>` | Chỉ nhận đúng dòng thay đổi sau cursor, không trùng/không sót | TC-F5-03 |
| Client tự khai `role` trong payload push | Server phải tự tra quyền thật, không tin client tự gắn | TC-F5-04 |
| Owner revoke 1 member | `revoked_at` set, dòng `share_members` vẫn còn (tombstone) | TC-F7-01 (P1) |
| Member vừa bị revoke, push lại | `revoked_at` không bị xoá/reset — vẫn bị chặn `revoked` ở lần push kế | TC-F7-02 (P1) |
| Member vừa bị revoke, pull | Theo đúng giới hạn đã công bố: vẫn đọc được hôm nay | TC-F7-03 |
| Member bị revoke, còn giữ link cũ | Đăng nhập ẩn danh lại (uid mới) → Join lại được | TC-F7-04 |
| Member `role=editor` trước đó, bị revoke, rồi push | Mã trả về phải là `revoked`, không phải `read_only` | TC-F10-05 (P1) |

### 1.4 Cơ chế sao lưu (§4) — phân tích chi tiết: "chỉ lịch `.ink` mới thật sự cần"

Đọc kỹ §4 lộ ra 2 lớp: **Lớp 1** mô tả hành vi HIỆN TẠI (bảng ma trận + luồng khôi phục); **Lớp 2** là một
cái bẫy cho TƯƠNG LAI (`.note.warn` cuối mục) — cảnh báo rằng hành vi hôm nay sẽ **trở nên SAI** ngay khi
tính năng backup thật cho `.ink` được xây. Nói cách khác: **backup thật cho `.ink` chưa tồn tại hôm nay**,
§4 chỉ là bước dọn nền trước khi làm.

Tiêu đề giải thích vì sao chỉ 1/4 loại cần backup: `.apple`/`.google`/`.outlook`/`.joined` đều có "nguồn sự
thật" nằm **ở nơi khác** (iCloud, provider, hoặc share của người khác) — Ink chỉ cần giữ con trỏ (tên, màu).
Chỉ `.ink` (tạo thẳng trong app, không backing bởi provider nào) mới có Ink là nguồn sự thật **duy nhất**.

**Ma trận nguồn:**

| Nguồn | Vì sao "Không mất" hoặc "Mất vĩnh viễn" |
|---|---|
| `.apple` | iCloud là nguồn sự thật thật sự — Ink chỉ đọc/hiển thị. Gỡ Ink không đụng dữ liệu gốc. |
| `.google` / `.outlook` | Đăng nhập lại provider là dữ liệu về đủ, không phụ thuộc Ink còn giữ gì. |
| `.ink` | Ink **là** nguồn sự thật duy nhất — không có nơi thứ 2. Mất máy = mất thật nếu Ink không tự backup. |
| `.joined` | Không phải dữ liệu của máy này — thuộc về share của người khác. Chỉ cần nhớ tư cách thành viên, nội dung luôn kéo lại được (miễn share còn sống). |

**Vì sao Ink cố tình KHÔNG giữ nội dung `.apple`/`.google`/`.outlook`** dù kỹ thuật hoàn toàn đọc được: giữ
thêm không mua được thêm khả năng khôi phục nào (đã có iCloud/Google lo), nhưng lại phải khai báo thu thập dữ
liệu (Privacy Nutrition Label) và ôm thêm mặt phơi nhiễm. Đây là quyết định **data-minimization** có chủ ý.

**Luồng khôi phục sau khi cài lại:**

```
Keychain              App                          Worker                    App
uid còn nguyên   →    GET /api/ink/calendars   →    calendars + memberships   →   Dựng lại store
(§1.1)                 "Endpoint DUY NHẤT trả         KÈM quyền ĐANG SỐNG          Rồi sync từng lịch
                        lời tôi với tới được gì"       của từng membership          như bình thường (§3)
```

Toàn bộ luồng này **phụ thuộc hoàn toàn** vào §1.1 (uid sống qua cài lại) — nếu Keychain mất uid (vd "Auto
clean-up" lỡ bật), luồng khôi phục không có điểm bắt đầu.

**Bug ẩn được fix kèm theo — lệch quyền (permission drift):** hôm nay, quyền hiển thị trên máy 1 member chỉ
cập nhật khi tình cờ có 1 lượt sync chạy (§3). Owner hạ quyền → nếu máy member chưa sync, UI vẫn tưởng sửa
được → member mở form, bấm Save, rồi mới ăn 403. Gọi `GET /api/ink/calendars` lúc khởi động chốt lại quyền
thật **trước khi** UI sửa được hiển thị, không đợi 1 chu kỳ sync ngẫu nhiên.

**Bẫy cho slice backup sau này:** hành vi hiện tại `DELETE /api/ink/share/:id` xoá luôn `calendars` — hợp lý
hôm nay vì 1 lịch `.ink` chưa từng có server copy độc lập nếu chưa từng share. Nhưng khi backup thật cho
`.ink` được xây (server copy độc lập với việc có đang publish hay không), cascade-delete này sẽ **xoá nhầm
bản backup** chỉ vì owner muốn "ngừng công khai", không phải "xoá lịch".

**Liên hệ Privacy — nối trực tiếp với §6 (quan trọng, xem thêm mục 6 risk và 10.7):** câu trong §6 —
*"Bảng đó sắp chứa cả backup RIÊNG TƯ của lịch `.ink` chưa từng được chia sẻ... chỉ cách một câu query ẩu là
rò"* — **xác nhận trực tiếp** rằng backup `.ink` sắp dùng **chung 1 bảng vật lý** (`calendar_events`) với dữ
liệu đã share công khai. Đây là rủi ro privacy cụ thể nhất của §4: nội dung riêng tư chưa từng đồng ý chia sẻ
sẽ nằm cùng chỗ với dữ liệu đang share công khai — chỉ cần 1 query không lọc đúng `calendar_id`/`share_id` là
rò dữ liệu chưa từng đồng ý chia sẻ. Rủi ro này càng nặng hơn khi ghép với Open #9 (§3 — pull chưa gate token):
2 lớp phòng thủ cùng yếu chồng lên đúng chỗ nhạy cảm nhất. → **TC-F11-03 nâng từ P2 lên P1** (xem mục 6, 10.7).

Ngoài ra, `GET /api/ink/calendars` (endpoint restore) tự nó cũng là dữ liệu nhạy cảm — nó tiết lộ **bạn đang
là thành viên của những share nào**, gián tiếp lộ mối quan hệ với người mời bạn. Tài liệu không nói endpoint
này có đảm bảo chỉ trả đúng dữ liệu của **chính uid gọi request** hay không (rủi ro access-control kiểu IDOR)
→ thêm **TC-F9-06** (mục 10.5).

**Phân biệt 2 khái niệm hay bị gộp nhầm:**

| Khái niệm | Thuộc về gì | Case |
|---|---|---|
| `.ink` mất vĩnh viễn khi mất máy | Availability/Integrity (mất dữ liệu), KHÔNG phải lộ dữ liệu | TC-F8-03 |
| Dữ liệu riêng tư `.ink` chung bảng với dữ liệu đã share, có thể bị query lộ | Confidentiality/Privacy thật sự | TC-F11-03 (P1) |
| `GET /api/ink/calendars` có leak chéo giữa các uid không | Access control / Privacy | TC-F9-06 (mới) |

**Bảng case cụ thể (đối chiếu mục 10.5, không đổi số TC hiện có):**

| Tình huống | Điều gì xảy ra theo đúng thiết kế | Case liên quan |
|---|---|---|
| Lịch `.apple`, gỡ+cài lại app | Lịch xuất hiện lại qua iCloud, không qua Ink | TC-F8-01 |
| Lịch `.google`/`.outlook`, gỡ+cài lại | Khôi phục qua đăng nhập lại provider | TC-F8-02 |
| Lịch `.ink` (chưa từng share), gỡ hẳn máy | Dữ liệu mất vĩnh viễn — xác nhận đúng hành vi; kiểm tra có cảnh báo UI nào cho user không | TC-F8-03 (P1) |
| Lịch `.joined`, share vẫn active | Lịch xuất hiện lại — chỉ cần tư cách thành viên còn sống | TC-F8-04 |
| Vừa cài lại, có uid cũ | `GET /api/ink/calendars` được gọi — network call đầu tiên | TC-F9-01 |
| Gọi `GET /api/ink/calendars` | Trả về cả lịch owned lẫn joined, kèm quyền đang sống | TC-F9-02 |
| Owner hạ quyền member lúc máy member không chạy, member mở lại app | Quyền chốt lại trước khi member thao tác | TC-F9-03 |
| Cold start bình thường (không phải sau cài lại) | `GET /api/ink/calendars` cũng được gọi ở mọi lần khởi động lạnh | TC-F9-04 |
| Owner gọi `DELETE /api/ink/share/:id` | Hành vi HIỆN TẠI: `calendars` row bị xoá theo — verify đúng cho release này; phải viết lại khi backup thật lên sóng | TC-F9-05 |
| 2 uid khác nhau, mỗi uid có lịch owned/joined riêng | Gọi `GET /api/ink/calendars` với token của uid A | Chỉ trả đúng dữ liệu của uid A — không lẫn/lộ dữ liệu của uid B | TC-F9-06 (mới) |

### 1.5 Mã lỗi (§5) — phân tích chi tiết: "mỗi mã dẫn tới một hành động khác nhau"

**Ý tưởng cốt lõi:** mã lỗi là tín hiệu điều khiển hành vi client, không chỉ là HTTP status. Điểm quan trọng
nhất, dễ bị bỏ qua nếu chỉ nhìn bảng: **2 cặp mã dùng chung 1 HTTP status**, client không được chỉ rẽ nhánh
theo status code mà phải đọc đúng field `code` trong response body:

| HTTP status | 2 mã dùng chung status này | Hành động khác nhau hoàn toàn |
|---|---|---|
| **401** | `unauthorized` vs `app_check_failed` | `unauthorized` → lấy token mới rồi thử lại (bình thường, im lặng); `app_check_failed` → thử lại **đúng 1 lần** với token vừa attest lại |
| **403** | `read_only` vs `revoked` | `read_only` → **tạm thời**, ẩn nút sửa nhưng vẫn tiếp tục đọc; `revoked` → **vĩnh viễn** (theo mọi bằng chứng hiện có), mời gỡ lịch khỏi máy, không tự retry |

Nếu client chỉ rẽ nhánh theo status (`if 401 { getNewToken() }`), nó có thể lấy token mới rồi lặp lại đúng
request đã bị App Check từ chối — sai hướng xử lý, vì vấn đề thật nằm ở tính hợp lệ của app, không phải token.

**Vì sao thứ tự kiểm `revoked` TRƯỚC `read_only` không phải chi tiết vặt:** đây là hệ quả bắt buộc từ đúng 1
quyết định kiến trúc duy nhất ở §3 (mục 1.3) — `revoked_at` luôn override `role`. Nếu server kiểm `read_only`
trước (chỉ nhìn `role`), người bị revoke nhưng `role` cũ còn `editor` sẽ vô tình nhận mã `read_only` — sai
bản chất (ngồi chờ 1 quyền không ai còn "mở lại" cho họ). §3 và §5 phải luôn nhất quán; sửa 1 bên mà quên
đồng bộ bên kia sẽ tự sinh bug này.

**`app_check_failed` là lớp phòng thủ khác hẳn 3 mã còn lại:** 3 mã kia nói về danh tính/quyền của **một uid
cụ thể** (Firebase Auth — "đây có đúng là người này không?"). `app_check_failed` nói về **chính cái app đang
gọi có phải bản Ink thật, chưa bị sửa đổi hay không** (App Check — "đây có đúng là app thật không?"), độc lập
với uid gửi kèm hợp lệ hay không. Retry đúng 1 lần hợp lý vì token App Check hết hạn là tình huống bình
thường/tạm thời, nhưng không lặp vô hạn — nếu app thật sự không hợp lệ (bị tamper), lặp lại vô ích.

**Phát hiện mới — một đường "hồi sinh" revoke khác, chưa được cover ở §3:** ở §3 đã ghi nhận rủi ro "push tự
ghi danh lần đầu gặp" có thể vô tình hồi sinh 1 dòng bị revoke (TC-F7-02). Đọc lại §5 cùng §2 lộ ra **một
đường thứ 2 hoàn toàn khác, chưa test**: nếu 1 uid đã bị revoke **vẫn còn giữ link** và bấm lại nút **Join**
tường minh (§2) — không đổi uid, không cần đăng nhập ẩn danh mới — endpoint `POST /api/ink/share/:id/join`
xử lý ra sao? Nếu code Join chỉ "tạo dòng nếu chưa có, không kiểm `revoked_at`", nó có thể vô tình xoá/reset
`revoked_at` — nguy hiểm hơn đường đã biết vì Join là action **user chủ động bấm dễ dàng qua UI bình thường**,
không cần hiểu cơ chế push ngầm để kích hoạt.

**Bảng case cụ thể (đối chiếu mục 10.6, kèm 2 case mới):**

| Tình huống | Điều gì xảy ra theo đúng thiết kế | Case liên quan |
|---|---|---|
| Không gửi token / token rỗng | 401, mã `unauthorized`; client lấy token mới rồi tự thử lại | TC-F10-01 |
| Member `read_only` cố ghi | 403, mã `read_only`; UI ẩn nút sửa nhưng vẫn tiếp tục pull/đọc | TC-F10-02 |
| Member đã `revoked` cố ghi | 403, mã `revoked`; UI mời gỡ lịch, không tự retry | TC-F10-03 |
| App Check attestation không hợp lệ | 401, mã `app_check_failed`; client retry đúng 1 lần với token vừa attest lại | TC-F10-04 |
| Member `role=editor` trước đó, bị revoke, rồi push | Mã trả về là `revoked`, không phải `read_only` | TC-F10-05 (P1) |
| So sánh copy/hành vi UI của cả 4 mã | Mỗi mã có message/hành động khác biệt rõ ràng | TC-F10-06 |
| Client nhận `401 unauthorized` và `401 app_check_failed` ở 2 lần gọi riêng biệt | Verify client rẽ nhánh theo field `code`, không theo status 401 chung chung | TC-F10-07 (mới, P2) |
| Uid đã bị revoke, còn giữ link, bấm lại nút **Join** (không đổi uid) | Verify `revoked_at` **không bị xoá/reset** bởi chính hành động Join | TC-F10-08 (mới, P1) |

**Câu hỏi mở mới (bổ sung vào mục 11):**

1. Nếu App Check fail **và** không có token hợp lệ cùng lúc — mã trả về là `app_check_failed` hay
   `unauthorized`? Không có thứ tự ưu tiên nào được công bố.
2. ⚠️ **Join lại bằng đúng uid đã bị revoke** — tài liệu hoàn toàn không mô tả nhánh này. Đây có thể là lỗ
   hổng nghiêm trọng ngang TC-F7-02 nhưng qua 1 con đường khác (Join thay vì push) — cần dev xác nhận Join
   endpoint có kiểm `revoked_at` của uid đang gọi trước khi upsert hay không.

### 1.6 Bảng dữ liệu (§6) — phân tích chi tiết

**Chủ đề thật của §6:** không đơn thuần là liệt kê schema — đây là tường thuật lại **2 cuộc tách đôi kiến
trúc**, cả 2 để lại dấu vết ngôn ngữ rõ trong mô tả:

- **Tách 1 — "Lịch" tách khỏi "hành động công bố lịch":** `shares` được mô tả là "Bản ghi *công bố* một lịch.
  **Không còn LÀ** cái lịch." Chữ "không còn" ngụ ý trước đây `shares`/`calendars` từng là 1 khái niệm gộp
  chung. Giờ tách ra: `calendars` là thực thể độc lập, `shares` chỉ là "1 lần công bố" gắn vào thực thể đó —
  điều kiện kỹ thuật cho phép "Tồn tại được dù chưa từng chia sẻ".
- **Tách 2 — "Nội dung event" tách khỏi "đã được share hay chưa":** lý do bắt buộc đổi tên `shared_events` →
  `calendar_events`. Tên cũ gắn chết "là event" với "đã share" — hợp lý khi bảng chỉ chứa dữ liệu đã share.
  Nhưng bảng này sắp chứa thêm backup riêng tư của lịch `.ink` chưa từng share (mục 1.4) — tên cũ trở thành
  lời nói dối trong chính tên bảng, là cái bẫy tự nhiên cho query mới tin vào tên bảng thay vì đọc kỹ điều
  kiện lọc.

**4 khoá chính — mỗi khoá kể 1 câu chuyện ràng buộc dữ liệu:**

| Bảng | Khoá | Ý nghĩa |
|---|---|---|
| `calendars` | `id` (đơn) | Danh tính độc lập — không phụ thuộc gì vào share |
| `calendar_events` | `(id, calendar_id)` (ghép) | `id` event không cần unique toàn cục — chỉ cần unique trong phạm vi 1 calendar |
| `shares` | `id` (đơn) | Danh tính 1 lần công bố — chính là giá trị lộ công khai trong link `inkcalendar.app/s/<id>` |
| `share_members` | `(share_id, uid)` (ghép) | 1 uid chỉ có đúng 1 dòng quyền **cho mỗi share** — khoá gắn theo `share_id`, không phải `calendar_id`, nên nếu 1 calendar có nhiều `shares` (Open #7, §2), cùng 1 uid có thể có quyền khác nhau ở mỗi share cho cùng 1 lịch |

**`shares.id` — điểm nối trực tiếp với Open #9 (§3):** mức độ nghiêm trọng thật của "pull chưa gate token"
phụ thuộc hoàn toàn vào việc `share_id` có đoán được không. §6 lẽ ra là nơi trả lời (kiểu dữ liệu của khoá)
nhưng không nói — chỉ ghi khoá là `id`, không nói UUID hay số tự tăng. Nếu là số tự tăng, kết hợp với trang
preview không cần đăng nhập (§2) + pull chưa gate token (§3) = công thức đầy đủ cho dò quét toàn bộ share
trong hệ thống bằng cách duyệt tuần tự `/s/1`, `/s/2`... → **gộp chung mức độ quan trọng với Open #9**, không
tách thành câu hỏi riêng.

**Phát hiện mới — "ngừng chia sẻ = xoá sạch" có thật sự sạch ở tầng `calendar_events`?** §4 nói `DELETE
/api/ink/share/:id` xoá hàng `calendars`. `calendar_events` khoá theo `(id, calendar_id)`, phụ thuộc
`calendar_id` còn tồn tại. Chưa rõ khi `calendars` bị xoá, `calendar_events` tương ứng có bị cascade xoá
theo, hay trở thành **mồ côi** (dòng vẫn còn, chỉ `calendar_id` trỏ vào chỗ không tồn tại) — nếu mồ côi, nội
dung event riêng tư vẫn tồn tại vĩnh viễn trên D1 dù owner tin đã xoá sạch.

**Bảng case cụ thể (đối chiếu mục 10.7, kèm 1 case mới):**

| Tình huống | Điều gì xảy ra theo đúng thiết kế | Case liên quan |
|---|---|---|
| Lịch `.ink` mới tạo, chưa từng share | `calendars` row tồn tại hợp lệ dù không có `shares` row nào | TC-F11-01 |
| 2 lịch khác nhau, cùng giá trị event `id` | Không xung đột — khoá chính là composite `(id, calendar_id)` | TC-F11-02 |
| Lịch `.ink` chưa từng share, có thể lẫn với dữ liệu shared | Không lộ qua bất kỳ đường nào dành cho "shared" | TC-F11-03 (P1) |
| Owner gọi `DELETE /api/ink/share/:id` | Verify toàn bộ `calendar_events` có `calendar_id` tương ứng cũng biến mất khỏi D1 — không còn dòng mồ côi chứa nội dung event cũ | TC-F11-04 (mới, P1) |

**Câu hỏi mở mới (bổ sung vào mục 11):**

1. `shares.id` (và các id khác) có phải chuỗi đoán được (số tự tăng) hay UUID ngẫu nhiên? — gộp chung nhóm
   "quan trọng, cần confirm với dev" với Open #9 (§3), vì cùng 1 vấn đề nhìn từ 2 góc.
2. `calendar_events` có bị cascade-xoá khi `calendars` bị xoá không, hay trở thành mồ côi? Ảnh hưởng trực
   tiếp tính đúng của TC-F11-04 và lời khẳng định "ngừng chia sẻ = xoá sạch" ở §4.
3. Có schema đầy đủ (danh sách cột) cho 4 bảng này ở tài liệu khác không? §6 chỉ mô tả khái niệm + khoá,
   không liệt kê cột — các cột như `owner_uid`, `updated_by` (§0), `link_role` (§3) nằm rải rác nhiều mục,
   chưa có 1 bảng schema đầy đủ trong tài liệu này.

---

## 2. Test object — In scope

| # | Flow | Nội dung | Nguồn |
|---|---|---|---|
| F1 | Định danh nền (uid) | uid trả lời được: chủ lịch, người sửa, ai được đồng bộ, đếm rate limit; device_id chỉ còn ở 3 endpoint AI | §0 |
| F2 | Đăng nhập ngầm | Anonymous sign-in có điều kiện (`currentUser == nil`), Keychain giữ uid qua cài lại, link Apple/Google giữ nguyên uid, phân biệt ẩn danh ≠ đã đăng nhập. **+ UI thật:** Settings/Account screen, Sign out/Delete account (mục 13.6) | §1, mục 13.6 |
| F3 | Tạo & mở share | Share full (không toggle từng phần), batch ghi 3 bảng, trang preview công khai giới hạn thông tin, owner tự seed dữ liệu. **+ UI thật:** tên bắt buộc, Time range, màn Calendars/Manage sharing (mục 13.2–13.4) | §2, mục 13.2–13.4 |
| F4 | Join | Ghi `share_members`, label mặc định server-sinh không dùng tên thiết bị. **+ UI thật:** paste-link, màn preview-join, **chống lộ lịch `Ink · <tên>` vào 4 danh sách sai** (rủi ro cao nhất toàn PR, mục 13.1/13.5) | §2, mục 13.1, 13.5 |
| F5 | Đồng bộ push/pull | Kiểm quyền theo thứ tự revoked → read_only → ghi; upsert LWW theo `updated_at`; trả lại dòng đang lưu thật cho mọi mutation | §3 |
| F6 | Ma trận quyền | `member.role ?? shares.link_role`, owner luôn ghi được, 6 tổ hợp trong bảng gốc | §3 |
| F7 | Thu hồi (revoke) | Tombstone `revoked_at`, không xoá dòng; 2 giới hạn tự thừa nhận (chưa chặn đọc, không phải hàng rào kín) | §3 |
| F8 | Sao lưu theo loại nguồn | Ma trận `.apple`/`.google`+`.outlook`/`.ink`/`.joined` × mất máy có mất dữ liệu | §4 |
| F9 | Khôi phục sau cài lại | `GET /api/ink/calendars`, kèm fix ngầm lỗi lệch quyền (linkRole chỉ đổi khi tình cờ sync) | §4 |
| F10 | Mã lỗi | 4 mã: `unauthorized`, `read_only`, `revoked`, `app_check_failed` — thứ tự kiểm `revoked` TRƯỚC | §5 |
| F11 | Mô hình dữ liệu | 4 bảng, đổi tên `shared_events` → `calendar_events`, rationale chống rò dữ liệu riêng tư | §6 |
| F12 | Xoá tài khoản | `DELETE /api/ink/account` — cascading xoá events→calendars→shares theo `owner_uid`. **Ngoài phạm vi §0–§7 gốc**, chỉ lộ ra qua câu trả lời Q15 của dev (mục 12.1) | Q15 (answers-from-dev.md), **không có trong tài liệu HTML gốc** |
| F13 | Unlock | `POST /share/:id/unlock` — tồn tại thật (có rate limit riêng: 30/giờ/share · 60/giờ/IP), nhưng **chức năng chưa được phân tích** vì không xuất hiện ở bất kỳ đâu ngoài bảng rate limit (Q17). **Ngoài phạm vi §0–§7 gốc** | Q17 (answers-from-dev.md), **không có trong tài liệu HTML gốc** |

⚠️ **F12/F13 khác các F1–F11 khác ở một điểm quan trọng:** test plan này tuyên bố ở đầu tài liệu là đọc
**độc lập, chỉ dựa trên** `ink-identity-sync-flow.html` (§0–§7). F12/F13 phá vỡ giả định đó — chúng là backend
thật, đang chạy, nhưng nằm **ngoài** phạm vi 8 mục của tài liệu kiến trúc được giao ban đầu. Giữ nguyên tắc
"không tự suy đoán nội dung chưa được xác nhận": xem mục 10.8 và Open (mục 12.7) cho chi tiết.

## 3. Out of scope (tự khai trong chính tài liệu, §7 "Còn chưa làm")

- **Luật provider** (`link_role='editor'` + `provider!='ink'` → phải 403) — **chưa build**, mọi hàng hôm nay
  đều là `ink` nên viết case chi tiết bây giờ là code chết. Chỉ giữ 1 case smoke: xác nhận hành vi hiện tại
  KHÔNG bị ảnh hưởng gì (no-op) vì chưa có provider nào khác `ink` trong hệ thống.
- **Pull bắt buộc token ở server** — **chưa build**. Đây là điều kiện để "thu hồi" chặn được cả đọc, không chỉ
  ghi. Không viết case kỳ vọng "revoke chặn đọc" — chỉ viết case **xác nhận đúng giới hạn đã công bố** (mục
  6, TC-F7).
- **Màn hình quản lý thành viên (UI)** — API đã có (`DELETE /api/ink/share/:id/members/:uid`), UI **chưa có**.
  Test API trực tiếp (qua request thủ công), không test qua UI vì chưa tồn tại.
- Bất kỳ hành vi nào tài liệu không mô tả (vd. ngưỡng rate limit cụ thể, timeout, retry logic ngoài
  `app_check_failed`) → không suy đoán, đưa vào mục 10 Open.

## 4. Test levels & types

- **Test levels:**
  - *Component:* upsert LWW (`WHERE excluded.updated_at > calendar_events.updated_at`), batch write 3 bảng,
    sinh label join mặc định, permission resolver (`member.role ?? link_role`).
  - *Integration:* App ↔ Firebase (anonymous + link) ↔ Keychain; App ↔ Worker (Bearer token, App Check) ↔ D1;
    Worker ↔ D1 transaction/batch atomicity.
  - *System:* toàn bộ vòng đời share (tạo → join → sync → revoke → sao lưu/khôi phục) trên build thật, không
    giả lập.
  - *Acceptance:* đúng đúng lời hứa tự khai của tài liệu — mỗi `.note`/`.note.warn`/`.note.ok` trong file HTML
    là một tuyên bố hành vi có thể verify được (xem cột "Nguồn" trong mục 9).
- **Functional:** F1–F11 ở mục 2.
- **Non-functional:**
  - *Security:* token giả/không có phải bị chặn (401); App Check bypass; IDOR qua `share_members`/`calendars`
    id; client không tự khai được `role` trong payload push (server phải tự tra, không tin client).
  - *Privacy:* trang preview công khai chỉ lộ tên/mô tả/số lượng — verify bằng network response thô, không
    chỉ nhìn UI (§2 nói rõ "Không bao giờ hiện nội dung event").
  - *Reliability:* batch 3 bảng atomic (không có share mồ côi); LWW hội tụ đúng khi 2 client ghi gần như đồng
    thời; owner self-seed không tạo ra "share có preview nhưng rỗng dữ liệu".
  - *Data integrity:* tombstone revoke không tự bị "hồi sinh" bởi lần push kế tiếp của chính người bị revoke.
- **Change-related (regression):** đây là **thay backend nền tảng** (đổi cách xác thực toàn bộ luồng share) —
  bất kỳ hành vi nào trước đây dựa vào `device_id` phải được verify là **không còn hoạt động** (không phải chỉ
  "không cần nữa" mà phải chủ động test rằng request chỉ mang `device_id`, không mang Bearer token hợp lệ, bị
  từ chối) ở mọi endpoint sharing/sync — ngoại trừ đúng 3 endpoint AI (§0).

## 5. Kỹ thuật thiết kế test case

### 5.1 State Transition — Định danh (uid), theo §1

```
(chưa có currentUser) --signInAnonymously()--> anonymous uid (Keychain)
anonymous uid --link(Apple)--> uid KHÔNG ĐỔI, có Apple credential
anonymous uid --link(Google)--> uid KHÔNG ĐỔI, có Google credential
bất kỳ trạng thái nào --cài lại app--> Keychain trả lại đúng uid cũ (không tạo mới)
```
Nhánh lỗi cố ý test: gọi `signInAnonymously()` **mà không kiểm `currentUser == nil` trước** → phải tạo uid
MỚI mỗi lần — đây là bug pattern chính tài liệu cảnh báo nặng nhất (§1, "Một dòng `if` là toàn bộ câu chuyện
liên tục").

### 5.2 State Transition — Share (owner), theo §2–§3

```
(chưa share) --Share button, 1 tap--> shared (batch: calendars+shares+calendar_events)
shared --owner tự seed & push--> calendar_events có dữ liệu thật (không rỗng)
shared --DELETE /share/:id (Stop sharing)--> calendars row bị xoá theo (hành vi HIỆN TẠI, xem TC-F9-05)
```

### 5.3 State Transition — Member permission (theo §3, bảng gốc)

```
join --> share_members(role=NULL)  // "theo link", KHÔNG phải "không có quyền"
role=NULL --owner cấp riêng quyền--> role=editor  (ghi được, bất kể link_role)
role=editor --owner hạ riêng người này--> role=viewer  (read_only, bất kể link_role)
bất kỳ role --owner revoke--> revoked_at set (tombstone) --> mọi ghi bị chặn (mã revoked, ưu tiên trên read_only)
revoked --push lần nữa của chính người bị revoke--> PHẢI vẫn giữ revoked_at (không được tự tạo lại dòng "sạch")
```

### 5.4 Decision Table 1 — Ma trận quyền (nguyên bảng gốc §3, dùng trực tiếp)

| # | link_role | member.role | Kết quả | Test case |
|---|---|---|---|---|
| DT1-1 | `viewer` | `NULL` | read_only | TC-F6-01 |
| DT1-2 | `viewer` | `editor` | ghi được | TC-F6-02 |
| DT1-3 | `editor` | `viewer` | read_only (override hạ quyền thắng) | TC-F6-03 |
| DT1-4 | `viewer` (owner vừa hạ cả link) | `NULL` | tất cả bị hạ ngay lập tức | TC-F6-04 |
| DT1-5 | bất kỳ | — (đã `revoked_at`) | revoked | TC-F6-05 |
| DT1-6 | bất kỳ | — (là owner) | luôn ghi được | TC-F6-06 |

### 5.5 Decision Table 2 — Mã lỗi × hành động client (nguyên bảng gốc §5)

| Mã | HTTP | Ý nghĩa | Hành động client kỳ vọng | Test case |
|---|---|---|---|---|
| `unauthorized` | 401 | Không có token hợp lệ | Lấy token mới, thử lại | TC-F10-01 |
| `read_only` | 403 | Chưa được quyền sửa — **tạm thời** | Ẩn nút sửa, vẫn tiếp tục sync đọc | TC-F10-02 |
| `revoked` | 403 | Đã bị gỡ — **trạng thái cuối** | Mời gỡ lịch khỏi máy, KHÔNG tự retry | TC-F10-03 |
| `app_check_failed` | 401 | App Check từ chối | Retry đúng **1 lần** với token vừa attest lại | TC-F10-04 |

### 5.6 Equivalence Partitioning

- **Nguồn lịch (§4):** {`.apple` · `.google`/`.outlook` · `.ink` · `.joined`}.
- **Trạng thái member:** {chưa join · `role=NULL` (theo link) · `role=viewer` · `role=editor` · `revoked`}.
- **Trạng thái mạng lúc mutation:** {online ổn định · mất mạng giữa chừng · token hết hạn giữa chừng}.
- **Người gọi trang preview:** {chưa cài Ink, không đăng nhập · đã có uid ẩn danh · đã login Apple/Google}.

### 5.7 Boundary Value Analysis

- LWW: 2 request ghi cùng 1 dòng với `updated_at` **rất gần nhau** (chênh vài mili-giây) — verify dòng có
  `updated_at` lớn hơn thắng dù đến server **sau** dòng kia (test bằng cách cố ý trì hoãn request "mới hơn"
  để nó tới server trễ hơn — server vẫn phải chọn đúng theo `updated_at`, không theo thứ tự tới).
- `revoked_at`: verify đúng ngay tại **request ghi kế tiếp sau khi bị revoke** — không có độ trễ/cache nào
  cho phép 1 lần ghi "lọt lưới" ngay sau khi bị thu hồi.

## 6. Risk-based prioritization

Ưu tiên bám sát đúng các đoạn `.note.warn` mà chính tài liệu tự đánh dấu là rủi ro cao — đây là tín hiệu tác
giả tài liệu đã tự nhận diện, không phải suy diễn của QC.

**P1 — mất dữ liệu / lộ riêng tư / quyền bị nới vĩnh viễn:**
- **TC-F4-08 (mới nhất, ưu tiên cao nhất toàn tài liệu, mục 13.1)** — lịch `Ink · <tên>` (tạo khi join) lộ vào
  danh sách chọn lịch để **chia sẻ**: nếu chọn được, người dùng đăng lại lịch của người khác dưới tên mình.
  Dev tự đánh giá đây là mục rủi ro cao nhất trong PR #260/#274.
- **TC-F4-05/06/07/20 (mục 13.1/13.5)** — cùng 1 lịch `Ink · <tên>` lộ vào 3 danh sách khác (tạo event mới,
  Ink AI chọn lịch đích, danh sách bật/tắt hiện lịch) — mức độ nhẹ hơn TC-F4-08 nhưng vẫn là rò danh tính/dữ
  liệu qua UI không kiểm soát.
- **TC-F2-03** — thiếu check `currentUser == nil` → mỗi lần mở app là 1 uid khác → mồ côi toàn bộ
  `owner_uid`/`share_members`. Tài liệu tự gọi đây là "toàn bộ câu chuyện liên tục" (§1).
- **TC-F6-07** — join-time snapshot `link_role` vào `member.role`: nếu code sai theo đúng cách tài liệu cảnh
  báo, quyền bị "nới vĩnh viễn bởi một thao tác không ai coi là cấp quyền" (§3) — owner hạ link mà không gỡ
  được ai nữa.
- **TC-F7-01/02** — tombstone tự bị "hồi sinh" bởi push của chính người bị revoke (§3 tự thừa nhận đây là rủi
  ro thiết kế: "xoá hẳn dòng thì ngay request sau nó được tạo lại và việc thu hồi tự huỷ chính nó").
- **TC-F3-04** — trang preview công khai lộ nội dung event (tên/địa điểm/note) thay vì chỉ tên+mô tả+số lượng
  — vi phạm trực tiếp câu "Không bao giờ hiện nội dung event" (§2).
- **TC-F3-07** — owner self-seed race: share vừa tạo có preview nhưng `calendar_events` rỗng thật (§2 tự nêu
  đây là hệ quả nếu thiếu bước seed).
- **TC-F8-03** — `.ink` calendar mất vĩnh viễn khi mất máy (§4 tự nói "Có, mất vĩnh viễn") — P1 vì đây là mất
  dữ liệu thật của người dùng, cần xác nhận có cảnh báo nào trong UI không (tài liệu không đề cập — mục 10).
- **TC-F10-05** — nhầm `revoked` với `read_only`: tài liệu tự nói sai lệch ở đây khiến "người dùng ngồi đợi
  một quyền không bao giờ quay lại" (§5) — đây là lý do server phải kiểm `revoked` TRƯỚC, phải verify đúng thứ
  tự này bằng test, không chỉ đọc code.
- **TC-F11-03 (mới nâng lên P1)** — dữ liệu riêng tư của lịch `.ink` chưa từng share có nguy cơ nằm **chung 1
  bảng vật lý** (`calendar_events`) với dữ liệu đã share công khai, theo đúng lời cảnh báo tự thân ở §6 ("chỉ
  cách một câu query ẩu là rò"). Đây không còn là giả thuyết — §6 xác nhận đây là kế hoạch đã định cho backup
  `.ink` sắp tới (xem mục 1.4).
- **TC-F9-06 (mới)** — `GET /api/ink/calendars` (endpoint restore) có thể lộ chéo dữ liệu giữa các uid nếu
  access-control sai — endpoint này tiết lộ cả lịch owned lẫn joined, tức gián tiếp lộ quan hệ với người mời
  nếu trả nhầm dữ liệu của uid khác (xem mục 1.4).
- ~~**TC-F10-08** — đường tự-undo-revoke qua Join~~ **✅ ĐÃ ĐÓNG (2026-09-18, xem mục 12/Q3).** Dev xác nhận
  Join kiểm `revoked_at` TRƯỚC khi upsert, và câu upsert không đụng cột `role`/`revoked_at`. Không có đường
  tự-undo qua Join. Giữ lại làm **regression test P2** (verify đúng code path này không đổi ở release sau),
  không còn là rủi ro treo.
- ~~**TC-F11-04** — nguy cơ `calendar_events` mồ côi~~ **✅ ĐÃ ĐÓNG (2026-09-18, xem mục 12/Q15).** Dev xác
  nhận batch xoá theo đúng thứ tự `calendar_events` → `calendars` → `shares`, cộng thêm D1 đã bật foreign key
  (2 lớp bảo vệ, đã verify thực nghiệm). "Ngừng chia sẻ = xoá sạch" đúng ở tầng dữ liệu thật. ⚠️ **Nhưng sắp
  đổi** — dev đang sửa `DELETE /share/:id` để **thôi xoá `calendars`** (chuẩn bị cho backup thật) — khi đổi
  xong, hành vi này KHÔNG còn áp dụng, phải viết lại expected result và test lại toàn bộ luồng. Xem mục 12.
- **MỚI, P1 — TC-F7-05 (từ Q14, dev tự phát hiện):** khi owner Stop sharing, member `.joined` đang hoạt động
  bình thường nhận 404 ở cả pull/push nhưng client hiện **nuốt lỗi im lặng** (`try?`) — lịch đứng yên hiển thị
  dữ liệu cũ **vĩnh viễn trên máy member, không có bất kỳ thông báo nào**. Khác hẳn `revoked` (có mã lỗi
  riêng, client xử lý đàng hoàng) — "share bị owner xoá hẳn" hiện **không có đường báo cho member**. Dev tự
  xếp đây là khoảng trống UX thật, chưa có mã lỗi riêng. Xem mục 12/Q14.

**P2 — đúng hành vi nhưng ảnh hưởng vừa, hoặc phụ thuộc gap đã tự công bố:**
- Ma trận quyền đầy đủ 6 dòng DT1 (mục 5.4) ngoài 2 dòng đã lên P1.
- LWW hội tụ đúng theo `updated_at`, không theo thứ tự tới server (mục 5.7).
- `GET /api/ink/calendars` fix lệch quyền lúc khởi động (§4) — nếu không gọi đúng lúc khởi động, member vẫn
  thấy form sửa được trước khi ăn 403 — trải nghiệm xấu nhưng không mất dữ liệu.
- `app_check_failed` retry đúng 1 lần, không lặp vô hạn.
- ~~Revoke chưa chặn đọc~~ **✅ ĐÃ ĐÓNG (2026-09-18, xem mục 12/Q1).** Dev xác nhận `share_id` là chuỗi 24 ký
  tự ngẫu nhiên (~143 bit entropy, `crypto.getRandomValues`), KHÔNG đoán được/không tuần tự — kịch bản dò quét
  toàn hệ thống ở Open #9 **không tồn tại**. Phạm vi thật đúng như đã nghi ngờ (bất kỳ ai biết link — kể cả bị
  revoke, kể cả người được forward link — vẫn pull được), nhưng đây là hành vi **cố ý** của link sharing, dev
  xác nhận đang sửa để pull bắt buộc token ở bản build tới. Giữ P2, theo dõi lại khi bản đó ra (mục 12).
- **MỚI, P3 (Q2, tech debt dev tự ghi nhận):** `ensureMembership()` ghi danh **trước khi** kiểm quyền —
  1 uid chưa từng Join, push thẳng vào 1 `share_id` hợp lệ, vẫn để lại dòng `share_members` (role=NULL) rồi
  mới bị 403 nếu không đủ quyền. Không giành thêm quyền gì (role=NULL giống hệt Join bình thường), nhưng làm
  bẩn danh sách thành viên của owner. Dev ghi nhận là nợ kỹ thuật, dự định đảo thứ tự để sửa.
- **MỚI, P3 (Q6, tech debt dev tự ghi nhận):** không có giới hạn số `shares` cho 1 calendar — mỗi lần bấm
  Share (kể cả double-tap) mint 1 link + 1 hàng `calendars` **hoàn toàn mới**, không tái sử dụng/chặn gì. Dev
  xác nhận đây là nợ kỹ thuật thật, chưa xử lý.

**P3 — cosmetic / chưa đủ thông tin để viết case chi tiết:**
- Định dạng label mặc định lúc join (`"<tên lịch> · <ngày>"`) với tên lịch rất dài/ký tự đặc biệt.
- ~~Ngưỡng rate limit~~ **✅ ĐÃ ĐÓNG (2026-09-18).** Dev cung cấp bảng đầy đủ theo endpoint — xem mục 12/Q17,
  đã đủ để viết BVA cụ thể (không còn P3 "thiếu thông tin", chuyển thành case BVA thật ở mục 12).

## 7. Test environment

- Firebase test project: bật Anonymous Auth + Apple/Google Sign-In sandbox, khả năng xoá/reset trạng thái
  currentUser giữa các lần chạy test (để test lại đúng nhánh "chưa có currentUser").
- App Check: có debug/test token hợp lệ VÀ khả năng tạo token App Check **không hợp lệ** có chủ đích (để test
  `app_check_failed`).
- D1 staging: khả năng đọc trực tiếp 4 bảng (`calendars`, `calendar_events`, `shares`, `share_members`) để
  verify atomicity/tombstone — không chỉ tin qua UI/API response.
- Khả năng inspect network response thô (proxy/devtools) của trang preview công khai — bắt buộc cho TC-F3-04,
  không được verify chỉ bằng mắt nhìn UI.
- Tối thiểu 2 uid khác nhau (2 tài khoản/2 thiết bị) để test join, revoke, permission override giữa các
  member khác nhau trên cùng 1 share.
- Khả năng gửi request thủ công (Postman/curl) tới các endpoint chưa có UI: `DELETE
  /api/ink/share/:id/members/:uid`, `GET /api/ink/calendars` — vì §7 tự xác nhận UI quản lý thành viên chưa
  tồn tại.

**Bổ sung cho mục 13 (UI/UX thật, theo đúng ma trận của qc-sharing-account-pro.md §1):**

| Máy/tài khoản | Bắt buộc | Lý do |
|---|---|---|
| 2 iPhone (hoặc 1 iPhone + 1 iPad) | ✅ | Gần như mọi case ở mục 13 cần 1 máy gửi + 1 máy nhận |
| iPhone iOS 26.x | ✅ | Header Discover + pill Pro dùng Liquid Glass (13.8, ngoài scope chính nhưng cùng build) |
| iPhone iOS 18.x | ✅ | Đối chiếu fallback khi không có Liquid Glass |
| iPad (dọc + ngang) | Nếu có | Manage sharing và màn Join giới hạn bề ngang |
| Tài khoản Google | ✅ | TC-F3-09, TC-F2-14 (tên/nút tự điền từ Google) |
| Tài khoản Apple | ✅ | TC-F3-10, TC-F2-18 — Apple thường **không** trả tên, case hay vỡ nhất nhóm Account |
| Máy đã mua Pro / chưa mua Pro | Nếu test 13.8 | Không bắt buộc cho scope chính (identity/share/sync/backup) |
| Lịch mẫu: 2–3 lịch Apple, ≥1 lịch có event lặp hằng ngày + event xa hơn 12 tháng | ✅ | Cần cho TC-F3-15…20 (Time range) và TC-F3-24 (bỏ cap 500 event) |

## 8. Entry criteria

- Staging phản ánh đúng schema D1 sau PR #16–#20 (4 bảng ở §6, đã đổi tên `shared_events` →
  `calendar_events`).
- Đã xác nhận với dev/PM (bằng văn bản) rằng 3 gap ở §7 ("Còn chưa làm") — luật provider, pull chưa gate
  token, UI quản lý thành viên — là **cố ý nằm ngoài phạm vi** của lần release này, không phải sót. Nếu không
  xác nhận được, không tự suy đoán mức độ chấp nhận được của gap "revoke chưa chặn đọc" (rủi ro riêng tư thật).
- Có sẵn tài khoản Apple ID + Google account sạch (chưa từng link) cho test link identity.
- Có công cụ trì hoãn/đảo thứ tự request tới server (để test LWW theo `updated_at`, không theo thứ tự đến).

## 9. Exit criteria

- 0 bug P1 mở, đặc biệt 6 case liệt kê ở mục 6 (P1).
- Đã verify bằng dữ liệu D1 thật (không chỉ UI) rằng: (a) không tồn tại `shares` row mồ côi không có
  `calendars` tương ứng; (b) `revoked_at` không bị xoá/reset bởi bất kỳ push nào sau đó của người đã bị revoke.
- Đã verify bằng network capture thật rằng trang preview công khai không trả field nội dung event nào ngoài
  tên/mô tả/số lượng.
- Toàn bộ 6 dòng Decision Table 1 (mục 5.4) và 4 mã lỗi (mục 5.5) đã có bằng chứng test pass, không chỉ đọc
  code.
- Đã có xác nhận rõ ràng (ghi lại) về việc `.ink` calendar mất vĩnh viễn nếu mất máy — có cảnh báo gì cho
  người dùng hay chấp nhận rủi ro này ở bản release này.

## 10. Test Case Specification

> Cột **Nguồn** trỏ về đúng mục (§) của tài liệu HTML gốc để truy vết. Case đánh dấu **(P1)** trùng với mục 6.

### 10.1 F1/F2 — Định danh & đăng nhập ngầm

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F2-01 | §1 | Cài mới, chưa từng mở app | Mở app lần đầu | Gọi đúng 1 lần `signInAnonymously()`, có uid mới, uid được lưu Keychain | P2 |
| TC-F2-02 | §1 | Đã có uid từ trước (không gỡ app, chỉ tắt/mở lại) | Mở lại app nhiều lần liên tiếp | `signInAnonymously()` KHÔNG được gọi lại; uid không đổi qua các lần mở | P1 |
| TC-F2-03 (P1) | §1, `.note.warn` | Giả lập/instrument code thiếu check `currentUser == nil` (hoặc kiểm qua log/network call thực tế) | Mở app nhiều lần | Nếu thiếu check: mỗi lần là 1 uid mới → verify KHÔNG xảy ra trên build thật; nếu xảy ra, mọi lịch sở hữu trước đó bị mồ côi (`owner_uid` cũ không còn ai truy cập) | P1 |
| TC-F2-04 | §1 | Có uid ẩn danh sẵn | Đăng nhập Apple qua `link(with:)` | uid **không đổi** trước/sau khi link; `calendars.owner_uid`/`share_members.uid` cũ vẫn hợp lệ, không mất quyền | P1 |
| TC-F2-05 | §1 | Có uid ẩn danh sẵn | Đăng nhập Google qua `link(with:)` | Tương tự TC-F2-04, uid không đổi | P1 |
| TC-F2-06 | §1 | Tài khoản ẩn danh chưa link | Kiểm tra trạng thái hiển thị trong app | Tài khoản ẩn danh vẫn được coi là "chưa đăng nhập" (không hiện như đã có tài khoản), dù vẫn có uid hợp lệ để gọi API | P2 |
| TC-F2-07 | §1 | Uid đã tồn tại (ẩn danh hoặc đã link) | Gỡ app, cài lại, không đăng nhập lại thủ công | Keychain trả lại đúng uid cũ; lịch/quyền cũ vẫn còn nguyên khi gọi API | P1 |
| TC-F2-08 | §1 | 2 thiết bị, cùng 1 tài khoản Apple/Google đã link trước đó | Đăng nhập cùng tài khoản trên thiết bị thứ 2 | Cả 2 thiết bị cùng resolve về **1 uid** | P2 |
| TC-F2-09 | §0, §2 | Uid ẩn danh (chưa link Apple/Google) | Dùng uid ẩn danh để tạo share (F3) | Thành công — token hợp lệ không phụ thuộc đã "đăng nhập" theo nghĩa UI, chỉ cần uid ký hợp lệ | P2 |
| TC-F2-10 | §0 | Gọi 3 endpoint AI: `/ink/help`, `/ink/chat`, `/suggest-event` | Gọi không kèm bất kỳ token nào | Thành công bình thường (endpoint cố ý không cần đăng nhập) — không bị nhầm áp dụng luật Bearer token của luồng share | P3 |

### 10.2 F3/F4 — Tạo share & Join

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F3-01 | §2 | Có lịch sở hữu, có uid hợp lệ | Chọn lịch → bấm Share | Không hỏi thêm bước nào khác (không có màn hình chọn toggle); `POST /api/ink/share` được gọi kèm `Bearer <uid token>` | P2 |
| TC-F3-02 | §2 | Không có token / token rỗng | Gọi `POST /api/ink/share` | 401, share KHÔNG được tạo — verify D1: không có row mới ở cả 3 bảng | P1 |
| TC-F3-03 | §2 | Token hợp lệ | Tạo share, sau đó đọc trực tiếp D1 | Cả 3 bảng (`calendars`, `shares`, `calendar_events`) được ghi trong cùng 1 batch — không tồn tại trạng thái chỉ có 1–2 bảng có dữ liệu | P1 |
| TC-F3-04 (P1) | §2 | Share đã tồn tại, có event với địa điểm/ghi chú | Mở `inkcalendar.app/s/<id>` không đăng nhập, **inspect network response thô** | Response chỉ chứa tên, mô tả, SỐ LƯỢNG event — không có field nội dung event nào (title/location/notes từng event) | P1 |
| TC-F4-01 | §2 | Đang ở trang preview, chưa có uid | Bấm Join | Anonymous sign-in được kích hoạt trước (nếu chưa có uid), sau đó `POST /api/ink/share/:id/join` thành công | P2 |
| TC-F4-02 | §2 | Join thành công | Đọc `share_members` vừa tạo | Label đúng format `"<tên lịch> · <ngày>"`; **không** chứa tên thiết bị dưới bất kỳ hình thức nào | P1 |
| TC-F3-07 (P1) | §2, `.note` | Vừa tạo share xong (ngay lập tức, không thao tác sync thủ công) | Kiểm tra trang preview + `calendar_events` trên D1 ngay sau khi tạo | Preview đã hiện đúng số lượng event thật; `calendar_events` **không rỗng** — owner đã tự seed & push mà không cần hành động thêm | P1 |
| TC-F4-03 | §2 | 2 uid khác nhau cùng join 1 share | Join lần lượt | Mỗi uid có 1 row `share_members` độc lập, label riêng, không ảnh hưởng lẫn nhau | P2 |
| TC-F4-04 | §2 | Cùng 1 uid | Bấm Join 2 lần liên tiếp (double-tap) | Không tạo 2 row `share_members` trùng cho cùng `(share_id, uid)` — verify qua khoá chính composite ở §6 | P2 |
| TC-F3-05 | §2 | Share đã tạo, đầy đủ field (location, notes) | Receiver join + sync đầy đủ | Receiver nhận đủ location/notes/liên kết — xác nhận đúng lời hứa "chia sẻ ĐẦY ĐỦ" (§2) | P2 |

### 10.3 F5/F6 — Đồng bộ & ma trận quyền

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F6-01 | §3, DT1-1 | `link_role=viewer`, `member.role=NULL` | Member push 1 thay đổi | Bị chặn, mã `read_only` | P2 |
| TC-F6-02 | §3, DT1-2 | `link_role=viewer`, `member.role=editor` (owner cấp riêng) | Member push 1 thay đổi | Ghi thành công | P2 |
| TC-F6-03 | §3, DT1-3 | `link_role=editor`, `member.role=viewer` (owner hạ riêng) | Member push 1 thay đổi | Bị chặn `read_only` — override hạ quyền thắng dù link đang `editor` | P2 |
| TC-F6-04 | §3, DT1-4 | `link_role=editor`, nhiều member `role=NULL` đang ghi được | Owner hạ cả link về `viewer` | TẤT CẢ member `role=NULL` mất quyền ghi ngay lần push kế tiếp, không có độ trễ | P2 |
| TC-F6-05 | §3, DT1-5 | Member bất kỳ role, đã bị `revoked_at` | Member push | Bị chặn, mã `revoked` (không phải `read_only`) | P1 |
| TC-F6-06 | §3, DT1-6 | Owner của lịch, bất kỳ `link_role`/`member.role` | Owner push | Luôn ghi được | P2 |
| TC-F6-07 (P1) | §3, `.note.warn` | Link đang `editor`; member A join & sync ít nhất 1 lần trong lúc link còn `editor` | Owner hạ link về `viewer` (không đổi riêng gì cho A) sau đó | A push lại: PHẢI bị `read_only` — verify `member.role` của A vẫn là `NULL`, không bị "đóng băng" thành `editor` từ lần sync trước đó | P1 |
| TC-F5-01 | §3 | 2 client cùng sửa 1 dòng gần như đồng thời | Client A gửi với `updated_at=t1`, client B gửi với `updated_at=t2 > t1`, nhưng B **đến server trước** A (cố ý trì hoãn A) | Dòng có `updated_at` lớn hơn (B) thắng — không theo thứ tự đến server | P2 |
| TC-F5-02 | §3 | Từ TC-F5-01 | Client A (thua) nhận response của chính mutation A | Response trả về đúng dòng **đang thực sự lưu** (bản của B) — A thấy ngay bản thắng, không cần đợi pull riêng | P2 |
| TC-F5-03 | §3 | Có thay đổi mới trên server sau `cursor` hiện tại của client | Client pull với `since=<cursor cũ>` | Chỉ nhận đúng các dòng thay đổi sau cursor; gọi pull nhiều lần liên tiếp không tạo trùng lặp, không bỏ sót | P2 |
| TC-F5-04 | §3 | Payload push có field tự khai `role`/quyền (giả lập client bị sửa đổi) | Gửi push với client tự gắn `role: editor` trong body dù server-side thật là `viewer` | Server phải tự tra `member.role`/`link_role` thật, KHÔNG tin field client tự khai — vẫn trả `read_only` | P1 |

### 10.4 F7 — Thu hồi (revoke)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F7-01 (P1) | §3, `.note.warn` | Member đang có quyền ghi | Owner gọi `DELETE /api/ink/share/:id/members/:uid` | `revoked_at` được set; verify là **tombstone** (row vẫn tồn tại trên D1, không bị xoá hẳn) | P1 |
| TC-F7-02 (P1) | §3, `.note.warn` | Từ TC-F7-01, member đã bị revoke | Member (bị revoke) thực hiện 1 lần **push** bất kỳ (kể cả push hợp lệ về mặt dữ liệu) | `revoked_at` của dòng `share_members` cũ **không bị xoá/reset** — request push tiếp theo vẫn phải bị chặn với mã `revoked`, không được "hồi sinh" thành member sạch | P1 |
| TC-F7-03 | §3, `.note.warn` (giới hạn tự khai #1) | Member đã bị revoke | Member (bị revoke) thực hiện **pull** | Theo đúng giới hạn đã công bố: pull **vẫn thành công** hôm nay (chưa bị chặn ở server) — xác nhận đúng gap đã biết, không phải mới phát sinh; nếu hành vi này đã đổi (pull đã bị chặn) → báo lại vì tài liệu chưa cập nhật | P2 |
| TC-F7-04 | §3, `.note.warn` (giới hạn tự khai #2) | Member đã bị revoke, vẫn còn giữ link cũ | Member đăng nhập ẩn danh lại (uid mới) rồi mở lại đúng link | Vào lại được (đúng như giới hạn đã công bố: "không phải hàng rào kín") — ghi nhận lại làm bằng chứng cho PM, không coi là bug ngoài dự kiến | P2 |
| TC-F10-05 (P1) | §5, `.note.warn` | Member vừa bị revoke, `member.role` trước đó là `editor` | Member push | Mã trả về phải là `revoked`, **không được** là `read_only` dù role lưu trước đó là editor — xác nhận đúng thứ tự kiểm "revoked TRƯỚC" | P1 |

### 10.5 F8/F9 — Sao lưu & khôi phục

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F8-01 | §4 | Lịch loại `.apple`, có sự kiện | Gỡ app, cài lại, đăng nhập lại đúng uid | Lịch xuất hiện lại (qua iCloud, không qua Ink) — verify server chỉ từng giữ con trỏ (tên/màu), không phải nội dung | P2 |
| TC-F8-02 | §4 | Lịch loại `.google`/`.outlook` | Tương tự TC-F8-01, đăng nhập lại provider | Lịch khôi phục qua đăng nhập lại provider, không qua dữ liệu Ink | P2 |
| TC-F8-03 (P1) | §4, `.note` (không có mockup cảnh báo nào được nêu) | Lịch loại `.ink` (tạo trong Ink, không share), có sự kiện | Gỡ app HẲN (không có backup ngoài), cài lại, đăng nhập lại đúng uid | Theo đúng tài liệu: dữ liệu **mất vĩnh viễn** — xác nhận đúng hành vi; đồng thời kiểm tra xem có bất kỳ cảnh báo nào cho user trước khi mất (tài liệu không đề cập UI cảnh báo — ghi nhận làm câu hỏi mở, mục 11) | P1 |
| TC-F8-04 | §4 | Lịch loại `.joined` (đã nhận qua share, share vẫn active) | Gỡ app, cài lại, đăng nhập lại | Lịch xuất hiện lại vì chỉ cần tư cách thành viên còn sống — dữ liệu pull lại từ share | P2 |
| TC-F9-01 | §4 | Vừa cài lại, có uid cũ (Keychain) | Mở app, quan sát network call đầu tiên | `GET /api/ink/calendars` được gọi — đây phải là endpoint xác định "tôi với tới được gì" | P2 |
| TC-F9-02 | §4 | Có cả lịch owned lẫn lịch joined | Gọi `GET /api/ink/calendars` | Trả về đầy đủ cả 2 loại, mỗi membership kèm quyền **đang sống hiện tại** (không phải quyền cache cũ) | P2 |
| TC-F9-03 (P2) | §4, `.note` | Member đang có quyền edit; owner hạ quyền member này xuống `viewer` trong lúc máy member KHÔNG chạy/không sync | Member mở lại app (trigger `GET /api/ink/calendars` lúc khởi động) | Quyền được chốt lại **trước khi** member thao tác — member không còn thấy được mở form sửa rồi mới nhận 403; form sửa phải bị ẩn/khoá ngay từ đầu | P2 |
| TC-F9-04 | §4 | App đang chạy bình thường (không phải sau cài lại) | Cold start app | Xác nhận `GET /api/ink/calendars` cũng được gọi ở mọi lần khởi động lạnh, không chỉ riêng sau khi cài lại — để quyền luôn được làm mới | P3 |
| TC-F9-05 | §4, `.note.warn` ("Bẫy cho slice backup sau này") | Owner có 1 share đang active | Owner gọi `DELETE /api/ink/share/:id` | Hành vi HIỆN TẠI (được tài liệu xác nhận là cố ý, tạm thời): `calendars` row bị xoá theo luôn — verify đúng hành vi này cho release này; đánh dấu rõ **case này phải viết lại** ngay khi tính năng backup thật lên sóng (không được giữ nguyên expected result này mãi) | P2 |
| TC-F9-06 (mới, P1) | §4 (suy luận từ chức năng endpoint restore) | 2 uid khác nhau, mỗi uid có ít nhất 1 lịch owned và/hoặc joined riêng biệt | Gọi `GET /api/ink/calendars` bằng token của uid A | Response chỉ chứa đúng lịch owned/joined của uid A — không lẫn, không lộ bất kỳ dữ liệu/tên lịch nào của uid B (access-control/IDOR check cho endpoint restore) | P1 |

### 10.6 F10 — Mã lỗi

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F10-01 | §5 | Không gửi token / token rỗng | Gọi bất kỳ API sharing/sync nào | 401, mã `unauthorized`; client lấy token mới rồi tự thử lại | P2 |
| TC-F10-02 | §5 | Member `read_only` (theo DT1) | Thử ghi | 403, mã `read_only`; UI ẩn nút sửa nhưng **vẫn tiếp tục** pull/đọc bình thường, không dừng sync | P2 |
| TC-F10-03 | §5 | Member đã `revoked` | Thử ghi | 403, mã `revoked`; UI mời gỡ lịch khỏi máy, **không** tự động retry | P1 |
| TC-F10-04 | §5 | App Check attestation không hợp lệ (giả lập) | Gọi API bất kỳ thuộc luồng share | 401, mã `app_check_failed`; client retry **đúng 1 lần** với token vừa attest lại; nếu lần retry đó cũng fail → ghi nhận hành vi cuối cùng thực tế (tài liệu không nói rõ, xem mục 11) | P2 |
| TC-F10-06 | §5 | So sánh toàn bộ 4 mã với UI copy tương ứng | Kích hoạt lần lượt cả 4 mã | Mỗi mã có message/hành động UI **khác biệt rõ ràng**, không có 2 mã nào dùng chung 1 copy/1 hành vi UI | P2 |
| TC-F10-07 (mới) | §5 (suy luận: 2 cặp mã dùng chung HTTP status) | Có thể kích hoạt riêng biệt `unauthorized` và `app_check_failed` (cả 2 đều 401) | Kích hoạt lần lượt 2 mã | Client phải rẽ nhánh theo **field `code`** trong response body, không theo status 401 chung chung — 2 hành vi (lấy token thường vs retry-attest-1-lần) phải khác nhau rõ ràng trên thực tế, không chỉ trên giấy | P2 |
| TC-F10-08 (mới, P1) | §5 + §2 (Join) + §3 (revoke) | Uid X đã bị owner revoke khỏi 1 share (`revoked_at` có giá trị), X vẫn còn giữ link | X bấm lại nút **Join** trên trang preview (dùng đúng uid X cũ, KHÔNG đăng nhập ẩn danh lại để lấy uid mới) | `revoked_at` của dòng `share_members` cũ **không được** bị xoá/reset bởi chính hành động Join — nếu bị xoá, đây là đường tự-undo-revoke thứ 2 (qua Join), độc lập với TC-F7-02 (qua push) | P1 |
| TC-F10-09 (mới) | Q10 (answers-from-dev.md) — App Check chạy trong router `src/index.ts`, **trước** khi handler được gọi | Request thiếu cả token hợp lệ **lẫn** App Check attestation hợp lệ, gửi đồng thời | Gọi API bất kỳ thuộc luồng share | Mã trả về phải là `app_check_failed` (401), **không phải** `unauthorized` — vì App Check chặn ở router trước khi request chạm tới bước verify Firebase token; verify đúng bằng test thật, không chỉ đọc code | P2 |

### 10.7 F11 — Mô hình dữ liệu

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F11-01 | §6 | Lịch `.ink` mới tạo, chưa từng share | Kiểm tra D1 | `calendars` row tồn tại hợp lệ dù **không có** `shares` row nào tương ứng — xác nhận "Tồn tại được dù chưa từng chia sẻ" | P3 |
| TC-F11-02 | §6 | 2 lịch khác nhau | Tạo event có cùng giá trị `id` ở 2 `calendar_id` khác nhau | Không xung đột — khoá chính đúng là composite `(id, calendar_id)` | P3 |
| TC-F11-03 | §6, `.note.warn` (rationale đổi tên bảng) | Lịch `.ink` **chưa từng share** (private) | Gọi bất kỳ endpoint nào có mục đích trả "dữ liệu đã share" (vd trang preview, hoặc API liệt kê theo `shares`) | Không được trả về event của lịch private này qua bất kỳ đường nào dành cho "shared" — **lưu ý:** vì backup riêng cho `.ink` chưa thật sự lưu nội dung hôm nay (TC-F8-03 xác nhận mất vĩnh viễn), case này hiện có thể chưa áp dụng được đầy đủ — phải chạy lại bắt buộc ngay khi tính năng backup `.ink` được bật | **P1** (nâng từ P2 — xem mục 1.4/mục 6: §6 tự xác nhận bảng này "sắp chứa cả backup RIÊNG TƯ của lịch `.ink` chưa từng share", cùng chỗ với dữ liệu đã share công khai — không còn là giả thuyết xa vời) |
| TC-F11-04 (mới, P1) | §6 (suy luận từ cấu trúc khoá `calendar_events`) + §4 | Lịch `.ink` đang active share, có `calendar_events` với nội dung thật (địa điểm, ghi chú) | Owner gọi `DELETE /api/ink/share/:id` (Stop sharing), sau đó kiểm tra trực tiếp D1 | Toàn bộ `calendar_events` có `calendar_id` tương ứng với `calendars` row vừa bị xoá cũng phải **biến mất theo** — không còn dòng mồ côi nào chứa nội dung event cũ, đúng như lời khẳng định "ngừng chia sẻ = xoá sạch" ở §4 | P1 |

### 10.8 F12/F13 — Xoá tài khoản & Unlock (ngoài phạm vi §0–§7 gốc, phát hiện qua dev Q&A)

> ⚠️ 2 flow này **không nằm trong tài liệu kiến trúc HTML gốc** (§0–§7) — chỉ được biết tới qua câu trả lời
> của dev (Q15, Q17). Case dưới đây viết ở mức **suy luận từ những gì đã biết** (tên endpoint + hành vi
> tương tự đã xác nhận cho các endpoint khác + số rate limit) — không tự suy đoán thêm phần chưa biết. Xem
> mục 12.7 cho câu hỏi mở cần dev làm rõ trước khi viết case chi tiết hơn.

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F12-04 (mới) | Q15 — dev xác nhận cùng thứ tự xoá `events → calendars → shares`, quét theo `calendars.owner_uid` | Uid sở hữu ít nhất 1 calendar có share active, có `calendar_events` | Gọi `DELETE /api/ink/account` | Toàn bộ `calendar_events`/`calendars`/`shares` mà uid này **sở hữu** (owner_uid) bị xoá theo đúng thứ tự đã xác nhận cho share-delete (mục 1.6/Q15) — verify D1 trực tiếp, không chỉ tin response | P1 |
| TC-F12-05 (mới) | Suy luận — chưa xác nhận | Uid A vừa gọi `DELETE /api/ink/account` (xoá tài khoản của A); uid A trước đó có Join (là member, không phải owner) 1 share của uid B khác | Kiểm tra `share_members` của share thuộc uid B sau khi A xoá tài khoản | **Chưa rõ hành vi** — dòng `share_members` của A trong share của B có bị xoá/tombstone theo không, hay còn "mồ côi" (uid A không còn tồn tại nhưng dòng member vẫn còn)? Xem Open mới ở mục 12.7 — không assert kết quả cụ thể tới khi dev xác nhận | P2 (cần xác nhận trước khi coi là P1/P2 chính thức) |
| TC-F13-01 (mới) | Q17 — chỉ biết rate limit, chưa biết chức năng | Có 1 `share_id` hợp lệ | Gọi `POST /share/:id/unlock` đúng 30 lần/giờ cho 1 share | Request thứ 30 thành công (theo nghĩa "không bị rate-limit" — **chức năng thật của response** chưa xác định), thứ 31 bị chặn bởi rate limit — **chỉ verify được ranh giới rate limit**, không verify được hành vi chức năng vì chưa biết endpoint này làm gì | P3 |
| TC-F13-02 (mới) | Q17 | — | Gọi `POST /share/:id/unlock` 60 lần/giờ từ cùng 1 IP (khác share) | Request thứ 61 bị chặn theo ngưỡng IP, độc lập với ngưỡng theo share | P3 |

## 11. Open — chỉ từ chính tài liệu này, không suy đoán thêm

> ✅ **Toàn bộ 17 câu hỏi (18 dòng, #4/#11 trùng nhau) đã được dev trả lời ngày 2026-09-18** — xem nguyên văn
> ở [ink-identity-sync-flow-answers-from-dev.md](ink-identity-sync-flow-answers-from-dev.md) và bản tóm tắt
> tác động lên test plan ở **mục 12** ngay dưới đây. Bảng dưới giữ lại nguyên trạng câu hỏi gốc (giá trị lịch
> sử — cho thấy QC đã suy luận đúng/sai ở đâu trước khi có câu trả lời thật), mỗi dòng đánh dấu ✅ kèm 1 dòng
> tóm tắt kết luận.

| # | Câu hỏi | Vị trí | Kết luận (✅ đã trả lời — chi tiết ở mục 12) |
|---|---|---|---|
| 1 | Ngưỡng rate limit theo uid là bao nhiêu? | §0 không có số | ✅ Có bảng đầy đủ theo endpoint (Q17, mục 12) — đủ viết BVA thật |
| 2 | Sau khi `app_check_failed` retry 1 lần vẫn thất bại, hành vi cuối cùng là gì? | §5 không nói nhánh này | ✅ Không xử lý đặc biệt — 401 đi theo đường lỗi bình thường của từng call site, khác nhau giữa push/join/createShare (Q9, mục 12) |
| 3 | `.ink` calendar có cảnh báo nào cho user về mất vĩnh viễn không? | §4 không nhắc UI | ✅ **Chưa có cảnh báo nào** — dev xác nhận đây là khoảng trống sản phẩm có thật (Q11, mục 12) |
| 4 | Batch push: 1 dòng bị từ chối quyền, các dòng khác có ghi tiếp không? | §3 không mô tả granularity | ✅ Kiểm quyền ở mức **CẢ REQUEST**, không phải per-row — giả định ban đầu của QC **sai** (Q8, mục 12) |
| 5 | Firebase ID token hết hạn giữa phiên có tự refresh không? | Không nhắc ở §1/§5 | ✅ Có, SDK tự refresh qua `getIDToken()` — "hết hạn giữa phiên" gần như không phải case người dùng gặp được (Q4, mục 12) |
| 6 | "Bấm Join" trên web lấy uid từ đâu — web hay app? | §2 không mô tả | ✅ App làm việc join bằng uid của chính nó qua deep link `ink://`; web không có Firebase Auth — rủi ro 2 uid **không tồn tại** (Q5, mục 12) |
| 7 | 1 lịch có nhiều `shares` active cùng lúc được không? | §2 không đề cập | ✅ **Được, không giới hạn** — mỗi lần Share mint link + `calendars` row mới. Tech debt thật, chưa xử lý (Q6, mục 12) |
| 8 | Join đúng lúc share vừa bị Stop — báo lỗi gì? | §2 không mô tả | ✅ 404 "Share not found", client map đúng thành "link không còn khả dụng" (Q7, mục 12) |
| 9 | ⚠️ Pull chưa gate token rộng tới đâu? `shares.id` đoán được không? | §3/§6 không nói rõ | ✅ `share_id` **không đoán được** (~143 bit entropy) — kịch bản dò quét không tồn tại. Phạm vi "ai biết link cũng pull được" đúng như nghi ngờ nhưng là hành vi **cố ý**, đang sửa để pull gate token (Q1, mục 12) |
| 10 | ⚠️ Push tự ghi danh áp dụng cho mọi uid hay chỉ owner? | §3 không nói rõ | ✅ Áp dụng **mọi uid** — ghi danh trước khi kiểm quyền. Không giành thêm quyền, nhưng làm bẩn danh sách member — tech debt thật (Q2, mục 12) |
| 11 | (trùng #4) |||
| 12 | `.ink` chưa share có được lưu gì trên server hôm nay không? | §4/§6 gợi ý KHÔNG | ✅ **0%, hoàn toàn local** — chỉ 2 chỗ ghi `calendar_events`: seed-lúc-share và sync-của-share (Q12, mục 12) |
| 13 | Race: local chưa push + Stop sharing cùng lúc? | §4 không mô tả | ✅ Không mất dữ liệu local (vẫn `isDirty` trên máy owner), nhưng thay đổi không bao giờ tới người khác — chấp nhận được (Q13, mục 12) |
| 14 | Race: member offline dài + share bị xoá hẳn? | §4 không mô tả | ✅ **404 bị nuốt im lặng** — lịch đứng yên hiển thị dữ liệu cũ vĩnh viễn, KHÔNG có thông báo nào. Gap UX thật, P1 mới (Q14, mục 12) |
| 15 | `app_check_failed` hay `unauthorized` thắng khi cả 2 đúng? | §5 không công bố thứ tự | ✅ `app_check_failed` thắng — App Check chạy ở router, trước cả bước verify token (Q10, mục 12) |
| 16 | ⚠️ Join lại bằng uid đã revoke có xoá `revoked_at` không? | Không mục nào mô tả | ✅ **Không** — Join kiểm `revoked_at` trước khi upsert, upsert không đụng cột `role`/`revoked_at`. Không có đường tự-undo qua Join (Q3, mục 12) |
| 17 | `calendar_events` cascade-xoá hay mồ côi khi `calendars` bị xoá? | Không mục nào xác nhận | ✅ **Không mồ côi** — batch xoá đúng thứ tự events→calendars→shares + D1 có FK constraint (2 lớp bảo vệ). ⚠️ Nhưng sắp đổi — xem mục 12/Q15 | 
| 18 | Có schema đầy đủ ở nơi khác không? | §6 chỉ có khái niệm + khoá | ✅ Có — `migrations/0008_calendar_store.sql`, `0009_share_members.sql` (Q16, mục 12) |

---

## 12. Cập nhật sau khi dev trả lời (2026-09-18)

> Nguồn: [ink-identity-sync-flow-answers-from-dev.md](ink-identity-sync-flow-answers-from-dev.md), đối chiếu
> trực tiếp với `worker-ink-lockscreen-calendar@main` và `lockscreen-calendar@main`. Mục này là bản tóm tắt
> **hành động cần làm** trong test plan — đọc file answers để có đầy đủ trích dẫn code.

### 12.1 Đóng 3 rủi ro P1 nghi ngờ trước đó

- **TC-F11-04 (mồ côi `calendar_events`) → ĐÓNG, an toàn.** Batch xoá đúng thứ tự (`calendar_events` →
  `calendars` → `shares`), cộng D1 có FK constraint làm lớp bảo vệ thứ 2 (verify thực nghiệm bởi dev,
  2026-09-18). ⚠️ **Nhưng dev đang sửa `DELETE /share/:id` để thôi xoá `calendars`** (chuẩn bị cho backup
  thật) — khi đổi xong, toàn bộ TC-F9-05/TC-F11-04 phải viết lại expected result, không giữ nguyên được.
- **TC-F10-08 (tự-undo-revoke qua Join) → ĐÓNG, an toàn.** Join kiểm `revoked_at` trước khi upsert; upsert
  chỉ đổi `display_name`, không đụng `role`/`revoked_at`. Giữ làm regression test, hạ từ "rủi ro treo" xuống
  P2 (verify code path không đổi ở release sau).
- **Open #9 (phạm vi pull-không-gate-token) → ĐÓNG phần "dò quét toàn hệ thống", MỞ phần "ai biết link đều
  đọc được".** `share_id` là chuỗi 24 ký tự ngẫu nhiên thật (~143 bit entropy từ `crypto.getRandomValues`),
  không phải số tự tăng — không dò quét được. Nhưng đúng là bất kỳ ai giữ link (kể cả người bị revoke, kể cả
  người được forward lại link) vẫn pull được hôm nay — dev xác nhận đây là hành vi **cố ý** của link sharing
  ("có link là xem được"), không phải lỗ hổng mới phát sinh, và đang sửa: **pull sắp bắt buộc token + kiểm
  membership ở bản build tới.** → Giữ TC-F7-03 nguyên trạng làm regression cho hành vi hiện tại; thêm ghi chú
  "test lại toàn bộ khi bản build gate-token ra".

### 12.2 1 rủi ro P1 MỚI phát hiện (dev tự báo, QC không hỏi trực tiếp)

**TC-F7-05 (mới) — share bị Stop, member không được thông báo, dữ liệu cũ hiển thị vĩnh viễn.**

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F7-05 | Q14 (answers-from-dev.md) | Member `.joined` đang hoạt động bình thường, share active | Owner Stop sharing; member tiếp tục pull/push bình thường sau đó | **Hành vi HIỆN TẠI (bug thật, chưa fix):** request nhận 404, `SharedCalendarSyncEngine` nuốt lỗi qua `try?` — lịch trên máy member đứng yên, hiển thị dữ liệu cũ, **không có bất kỳ thông báo nào** cho tới khi user tự nhận ra. Khác hẳn xử lý của mã `revoked` (có UI riêng). Verify đúng hành vi này tồn tại; đây là gap cần PM/dev ưu tiên sửa (thêm mã lỗi riêng như `revoked`), không phải case "phải pass" | P1 |

⚠️ Dev đang sửa `DELETE /share/:id` để thôi xoá `calendars` (mục 12.1) — sau khi đổi, **TC-F7-05 phải hỏi lại
từ đầu** vì cơ chế 404 hiện tại dựa trên việc `calendars` bị xoá hẳn.

### 12.3 2 rủi ro P3 mới (tech debt dev tự ghi nhận, không phải bug khai thác được)

**TC-F6-08 (mới) — push tự ghi danh làm bẩn danh sách member:**

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F6-08 | Q2 | Uid X chưa từng Join 1 share | X gọi thẳng API push cho `share_id` hợp lệ (biết được id, không qua Join) | `ensureMembership()` tạo dòng `share_members` cho X (`role=NULL`) TRƯỚC khi kiểm quyền — nếu link không phải `editor`, X vẫn bị 403 `read_only` như bình thường (không giành thêm quyền), nhưng dòng member "rác" đã được tạo và còn lại vĩnh viễn trong danh sách của owner | P3 |

**TC-F3-08 (mới) — không giới hạn số share cho 1 calendar:**

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F3-08 | Q6 | Có lịch sở hữu, chưa share | Bấm Share 2 lần liên tiếp (double-tap thật hoặc 2 request riêng biệt) | Tạo ra **2 link độc lập**, mỗi link trỏ vào **1 hàng `calendars` riêng** (server tự mint calendar mới mỗi lần, không tái sử dụng) — xác nhận đúng hành vi hiện tại (tech debt đã biết, chưa fix, không phải case "phải chặn") | P3 |

### 12.4 Cập nhật kỹ thuật cho case đã có

- **TC-F5-04** — giữ nguyên expected result (server không tin `role` client tự khai), nhưng bổ sung: kiểm tra
  diễn ra **1 lần cho cả batch** (trước vòng lặp ghi từng mutation), không phải kiểm lại cho từng dòng.
- **TC-F5-05 (mới)** — ghi 1 phần vì lý do **KHÁC** quyền: vòng lặp ghi từng mutation **không nằm trong 1
  transaction**. Nếu D1 lỗi giữa chừng vòng lặp (không liên quan quyền), các dòng ghi trước đó vẫn được giữ,
  dòng sau bị mất. Client chịu được vì LWW theo `updated_at` (dòng mất sẽ được đồng bộ lại ở lần push kế). P3
  — ghi nhận hành vi, không phải bug.
- **TC-F4-01** — cập nhật mô tả cơ chế đúng thật: web chỉ render preview + đưa deep link `ink://share?url=...`;
  app đọc payload rồi tự gọi Join bằng uid của chính nó. Không có bước "anonymous sign-in trên web".
- **TC-F10-04** — tách theo call site khi retry `app_check_failed` thất bại lần 2 (không có xử lý đặc biệt
  chung): **push** → nuốt lỗi qua `try?`, dòng ở lại `isDirty`, tự thử lại lần sync sau (im lặng, không báo
  user); **join** → rơi vào `catch`, hiện snackbar; **createShare** → ném lỗi, UI báo lỗi trực tiếp cho user.
- **TC-F11-03** — bỏ phần hedge "cần dev xác nhận trạng thái backup `.ink` hôm nay" — đã xác nhận **0%**, chỉ
  2 đường ghi `calendar_events` (seed-lúc-share, sync-của-share), không có đường nào cho calendar chưa share.

### 12.5 2 thay đổi sắp ra mắt — cần lên lịch test lại khi ship

| Thay đổi | Ảnh hưởng | Case cần test lại |
|---|---|---|
| **Pull sẽ bắt buộc token + kiểm membership** | Đóng hoàn toàn phần còn mở của Open #9/TC-F7-03 | TC-F7-03, TC-F7-04 (verify sau khi đổi, revoke chặn được cả đọc) |
| **`DELETE /share/:id` sẽ thôi xoá `calendars`** (chuẩn bị cho backup thật) | TC-F9-05, TC-F11-04, TC-F7-05 đều dựa trên hành vi cũ (xoá hẳn `calendars`) | Viết lại cả 3 case theo hành vi mới ngay khi thay đổi này lên production — **không** giữ nguyên expected result hiện tại |

### 12.6 Rate limit — bảng đầy đủ, đủ để viết BVA thật (đóng Open #1/#17 cũ)

| Endpoint | Ngưỡng | Đếm theo | Hằng số |
|---|---|---|---|
| `POST /api/ink/share` | 20/giờ | IP | `CREATE_LIMIT` |
| `POST /share/:id/sync` | 120/giờ | **(share, uid)** | `SYNC_PUSH_LIMIT_PER_USER` |
| `POST /share/:id/unlock` | 30/giờ/share · 60/giờ/IP | share / IP | `UNLOCK_LIMIT_PER_*` |
| `/ink/help`, `/suggest-event` | 10/phút · 60/giờ | deviceId (đã băm) | `src/ink-help.ts` |
| Lưới trên endpoint AI | 30/phút · 200/giờ | IP | `src/quota.ts` |
| Quota ngày `/suggest-event` | 1000/ngày | deviceId | `src/quota.ts` |

> **Lưu ý ID:** 3 case rate limit dưới đây đặt tên `TC-RATE-xx` (không dùng `TC-F12-xx`) để tránh trùng với
> nhóm `TC-F12-xx` của flow F12 "Xoá tài khoản" thêm ở mục 10.8 — rate limit là cross-cutting, không thuộc
> riêng 1 flow F nào.

**TC-RATE-01 (mới, BVA)** — sync đúng 120 request/giờ cho 1 `(share, uid)`: request thứ 120 thành công, thứ
121 bị rate-limit trong cùng khung giờ. **Lưu ý:** ngưỡng tính theo **từng lịch**, không phải theo tài khoản
— 1 uid có 10 lịch có thể đạt 1.200 request/giờ tổng, không có trần tổng nào. P2.

**TC-RATE-02 (mới)** — verify rate limit **fail-open**: khi D1 lỗi, request vẫn được đi tiếp
(`hitRateLimit` trả `count ?? 1`) — đây là hàng rào chi phí, KHÔNG phải điều kiện đúng đắn. Test case không
được kỳ vọng request bị chặn khi giả lập D1 lỗi. P3.

**TC-RATE-03 (mới, BVA)** — `POST /api/ink/share` đúng 20 request/giờ theo IP: request thứ 20 thành công, thứ
21 bị chặn — verify đếm theo **IP**, không phải uid (khác hẳn sync). P3.

### 12.7 Phát hiện backend ngoài phạm vi tài liệu gốc — cần dev làm rõ (vòng 2, 2026-09-19)

Kiểm tra lại toàn bộ file `answers-from-dev.md` để rà xem có phần backend nào bị bỏ sót lộ ra 2 endpoint
**hoàn toàn không có trong `ink-identity-sync-flow.html` gốc (§0–§7)**, chỉ xuất hiện như chi tiết phụ trong
câu trả lời của dev:

- **`DELETE /api/ink/account`** — nhắc tới trong Q15 (đối chiếu cùng thứ tự xoá với share-delete), nhưng
  không có mô tả UX/product nào đi kèm (khác Sign out/Delete account thế nào, có xác nhận 2 bước không, ảnh
  hưởng gì tới các share mà uid đó **đang là member** của người khác — không phải owner).
- **`POST /share/:id/unlock`** — chỉ xuất hiện trong bảng rate limit ở Q17. Không rõ chức năng, không rõ khi
  nào client gọi endpoint này, không rõ liên quan gì tới `read_only`/`revoked`/`link_role` hay không.

Đã thêm case suy luận ở mức tối thiểu (mục 10.8, TC-F12-04/05, TC-F13-01/02) nhưng **2 câu hỏi dưới đây cần
dev trả lời** trước khi viết case chi tiết hơn — đã bổ sung vào
[ink-identity-sync-flow-open-questions-for-dev.md](ink-identity-sync-flow-open-questions-for-dev.md) mục
"Vòng 2":

| # | Câu hỏi | Vì sao cần biết |
|---|---|---|
| Q18 | `DELETE /api/ink/account` là gì trong sản phẩm — khác Sign out ra sao? Uid A xoá tài khoản trong khi A đang là **member** (không phải owner) của 1 share thuộc uid B — dòng `share_members` của A trong share của B có bị dọn theo không, hay trở thành mồ côi (uid không còn tồn tại nhưng dòng member vẫn còn)? | TC-F12-05 hiện không assert được kết quả cụ thể; nếu mồ côi, đây là rủi ro data-integrity tương tự nhóm đã tìm thấy ở mục 1.6 |
| Q19 | `POST /share/:id/unlock` dùng để làm gì? Ai gọi (owner hay member), gọi khi nào, liên quan gì tới các mã lỗi `read_only`/`revoked` đã có ở §5 không? | TC-F13-01/02 hiện chỉ test được ranh giới rate limit, hoàn toàn không test được hành vi chức năng vì chưa biết endpoint làm gì |

## 13. Tích hợp UI/UX thật — PR #260 (`380bc6b2`) + PR #274 (`ef996605`)

> Nguồn: [qc-sharing-account-pro.md](qc-sharing-account-pro.md), bàn giao QC 2026-09-19. Đây là **lớp UI/UX
> thật đã lên `main`**, dựng trên đúng backend đã phân tích ở mục 1–12 (F1–F13). Mỗi mục con dưới đây nối
> thẳng vào 1 flow đã có — TC mới tiếp tục đúng dãy số ID của flow đó, không mở flow song song. 3 mục cuối
> (Discover header, quy ước nút ✕, Widget) **không thuộc phạm vi Định danh/Chia sẻ/Đồng bộ/Sao lưu** — liệt
> kê ở 13.8 để không mất thông tin, nhưng không mở rộng scope chính của test plan này.

### 13.1 Lịch join bị lộ sai chỗ — rủi ro cao nhất, nối vào F4

**Cơ chế:** khi máy B join 1 link, Ink tạo một **lịch EventKit thật** tên `Ink · <tên lịch>` để đẩy sự kiện
sang app Lịch của Apple. Ở tầng OS, đây là **một lịch bình thường** — không có cách nào phân biệt nó với lịch
tự tạo của chính người dùng. Trước bản fix này, nó lọt vào 4 danh sách không nên có mặt — nghiêm trọng nhất
là danh sách #4 (bên dưới): nếu chọn được ở đó, người dùng **đăng lại lịch của người khác dưới tên mình**.

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F4-05 | qc-sharing-account-pro §2 | Máy B đã join ít nhất 1 link | Tạo sự kiện mới → mở dòng chọn lịch | **Không** có `Ink · …` trong danh sách chọn | P1 |
| TC-F4-06 | qc-sharing-account-pro §2 | Máy B đã join ít nhất 1 link | Mở Ink AI → chỗ chọn lịch đích | **Không** có `Ink · …` | P1 |
| TC-F4-07 | qc-sharing-account-pro §2 | Máy B đã join ít nhất 1 link | Calendars → danh sách bật/tắt hiện lịch | Lịch chia sẻ xuất hiện **đúng 1 lần** (dạng lịch được chia sẻ) — không có thêm dòng `Ink · …` song song | P1 |
| TC-F4-08 | qc-sharing-account-pro §2 (dev tự đánh giá **nghiêm trọng nhất**) | Máy B đã join ít nhất 1 link, đồng thời cũng sở hữu lịch riêng | Mở Chia sẻ lịch → danh sách lịch để chọn chia sẻ | **Không** có `Ink · …` — không thể chọn lịch của người khác để tự publish lại dưới tên mình | **P1 — ưu tiên cao nhất trong toàn bộ mục 13** |
| TC-F4-09 | qc-sharing-account-pro §2 (regression) | Máy **chưa join link nào** | Kiểm tra cả 4 danh sách trên | Đầy đủ như cũ — không bị lọc mất lịch hợp lệ nào của chính người dùng | P2 |

### 13.2 Chia sẻ lịch (owner) — tên bắt buộc, Time range, tạo link — nối vào F3

**Tên người gửi nay bắt buộc:**

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F3-09 | §3.1 | Đăng nhập Google | Mở sheet Share | Ô "Your name" tự điền tên tài khoản, **không** bật bàn phím | P2 |
| TC-F3-10 | §3.1 | Đăng nhập Apple (không tên) hoặc chưa đăng nhập | Mở sheet Share | Ô trống, **tự động focus** (bàn phím bật) | P2 |
| TC-F3-11 | §3.1 | Ô tên trống | Quan sát nút Create link | Nút **mờ/không bấm được** | P1 |
| TC-F3-12 | §3.1 | — | Gõ tên | Nút Create link sáng lên | P2 |
| TC-F3-13 | §3.1 (BVA — dễ sai nếu code chỉ check `.isEmpty`) | — | Nhập toàn dấu cách vào ô tên | Nút **vẫn mờ** — không được coi chuỗi toàn space là hợp lệ | P2 |
| TC-F3-14 | §3.1 | Đã share 1 lần với tên X | Share lịch khác | Tên X được nhớ lại; **mô tả lịch thì không** (mỗi lịch 1 mô tả riêng) | P3 |

**Time range (khái niệm mới — xem thêm 13.7 về câu hỏi mở nối với §3 backend):**

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F3-15 | §3.2 | Mở sheet Share | — | Time range mặc định **"All upcoming"** | P2 |
| TC-F3-16 | §3.2 | — | Mở picker Time range | Đủ 4 lựa chọn: Next 3/6/12 months, All upcoming | P3 |
| TC-F3-17 | §3.2 | — | Đổi lựa chọn Time range | Dòng tóm tắt đổi theo dạng "128 events · 18 thg 9 – 18 thg 3" | P2 |
| TC-F3-18 | §3.2 | Chọn "All upcoming" | — | Phần sau dấu `·` hiện chữ **"All upcoming"**, không hiện khoảng ngày cụ thể | P3 |
| TC-F3-19 | §3.2 | Đã bấm Create link | Đổi lại Time range | Link cũ **biến mất**, phải tạo lại — verify link cũ thật sự chết ở máy B (không chỉ ẩn trên UI máy A), cross-ref F7 revoke | P1 |
| TC-F3-20 | §3.2 | — | Thử lần lượt 3/6/12 tháng/All upcoming trên cùng 1 lịch | Số sự kiện **tăng dần** đúng thứ tự | P2 |

**Tạo link:**

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F3-21 | §3.3 | Lần chia sẻ đầu tiên trên máy (chưa từng share) | Bấm Create link | Hiện popup xin xác nhận trước khi tải lên | P2 |
| TC-F3-22 | §3.3 | Lịch quá lớn so với giới hạn dung lượng | Tạo link | Dòng cảnh báo "Only the first N events fit in the link", kèm **icon dấu chấm than** (không phải tick) | P3 |
| TC-F3-23 | §3.3 | Link vừa tạo xong | — | Dòng ghi chú nằm giữa sheet, không đè lên nút CTA | P3 |
| TC-F3-24 | §3.3 (đã bỏ cap 500 event — regression quan trọng nếu có case cũ nào giả định cap 500) | Lịch có 600+ event | Share toàn bộ | Đi trọn theo giới hạn dung lượng mới, **không** còn bị cắt cứng ở mốc 500 — nếu có test case cũ nào kỳ vọng "cắt còn 500" thì expected result đó **đã lỗi thời** | P2 |

**Không còn toggle chi tiết (xác nhận lại đúng những gì §2 kiến trúc gốc đã nói ở mục 1.2 — không phải phát hiện mới, chỉ verify UI khớp đúng backend):**

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F3-25 | §3.4 | Mở sheet Share | — | **Không còn** dòng bật/tắt "Include location, notes and links" | P3 |
| TC-F3-26 | §3.4 | — | Đọc câu disclosure | Nói rõ chia sẻ **gồm cả** location, notes, links | P3 |

### 13.3 Màn Calendars — điểm vào sharing đổi cấu trúc — nối vào F3

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F3-27 | §4 | — | Mở Calendars | Màn **full screen** (không phải sheet), ✕ ở góc trái | P3 |
| TC-F3-28 | §4 | — | — | Header có 2 nút tròn bên phải: chia sẻ (mũi tên lên) và + | P3 |
| TC-F3-29 | §4 | — | Bấm + | Popup "New calendar" có 2 nhóm tách rời: mẫu lịch, và "Add a shared calendar" bên dưới | P3 |
| TC-F3-30 | §4 | — | Xem thẻ sharing trong thân màn | Chỉ còn "Manage sharing" — 2 dòng "Share a calendar"/"Add a shared calendar" đã chuyển lên header/popup, **không xuất hiện trùng lặp** ở cả 2 nơi | P2 |
| TC-F3-31 | §4 | Có lịch đã join | — | Lịch đã join nằm **phía trên** dòng Manage sharing | P3 |
| TC-F3-32 | §4 (điểm nối quan trọng — xem 13.7) | **Chưa đăng nhập** | Bấm nút chia sẻ trên header | Ra màn **mời đăng nhập**, không phải mở sheet chia sẻ trực tiếp | **P1** |
| TC-F3-33 | §4 (đã biết, không report nếu khác) | Chưa đăng nhập | Join 1 link | Join thành công **không cần đăng nhập** — đây là chủ ý sản phẩm | P3 |

### 13.4 Manage sharing (owner) — nối vào F3, chạm trực tiếp F6 (quyền) và F7 (revoke)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F3-34 | §5 | — | Vào Manage sharing | Full screen, ✕ góc trái | P3 |
| TC-F3-35 | §5 (mới ở PR #274) | Có ≥1 share | — | Nút "Share a calendar" **ghim đáy màn**; nội dung cuộn xuống dưới nút và mờ dần, không bị cắt cụt | P2 |
| TC-F3-36 | §5 | — | Bấm nút ghim đáy → tạo link → đóng sheet | Thẻ mới xuất hiện **ngay** trong danh sách, không cần thao tác refresh | P2 |
| TC-F3-37 | §5 | Chưa chia sẻ gì | Mở Manage sharing | Màn trống chỉ 1 dòng chữ, **không** có CTA riêng ở giữa (tránh mời cùng 1 hành động 2 lần vì nút đã ghim đáy) | P3 |
| TC-F3-38 | §5 | Có ≥1 share active | Xem thẻ | Dòng "Shared" hiện "42 events · 8 thg 9 – 1 thg 3" — **không còn** hiện URL, **không còn** hiện ngày tạo link | P2 |
| TC-F3-39 | §5 | — | Xem nút copy | Ghi **"Copy link"** (trước là "Copy"), nằm cạnh nhãn Access | P3 |
| TC-F3-40 | §5 | — | Bấm copy | Đổi thành "Copied" ~1 giây rồi trở lại; copy thẻ khác không làm thẻ này đổi theo | P3 |
| TC-F3-41 | §5 | — | Dán link đã copy ra ngoài app | Dán được và mở được | P2 |
| TC-F3-42 | §5 (= verify F6 qua UI thật) | Có member đã join | Đổi Access giữa xem/sửa cho 1 người | Máy B nhận đúng quyền tương ứng — cross-ref TC-F6-01/02 | **P1** |
| TC-F3-43 | §5 (= verify F7 qua UI thật) | Có share active | Bấm Stop sharing, xác nhận | Link chết ở máy B — cross-ref TC-F7-01 | **P1** |
| TC-F3-44 | §5 (= verify F8/F9 qua UI thật, quan trọng) | Có share active với event thật | Xoá app, cài lại, mở Manage sharing | Danh sách link **vẫn còn** nhưng dữ liệu sự kiện **thì không** — dòng "Shared" **quay về hiện ngày tạo link** thay vì "N events · khoảng ngày". Dev xác nhận đây là hành vi ĐÚNG, không phải bug — chính là triệu chứng UI-quan-sát-được của việc `calendar_events` cache local rỗng sau cài lại tới khi sync lần đầu chạy lại (mục 1.4) | P2 |

### 13.5 Nhận link chia sẻ (máy B) — nối vào F4

**Dán link — "Add a shared calendar":**

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F4-10 | §6.1 | — | Mở "Add a shared calendar" | Ô dán link có nút paste **bên trong ô**, mờ khi clipboard rỗng | P3 |
| TC-F4-11 | §6.1 | — | Dán link hợp lệ | Hiện thẻ tóm tắt (tên, "42 events · khoảng ngày") | P2 |
| TC-F4-12 | §6.1 | — | Dán URL không phải Ink (vd `https://example.com/…`) | Báo lỗi **ngay**, không gọi mạng | P2 |
| TC-F4-13 | §6.1 | Link Ink hợp lệ nhưng đã chết | Dán link | Câu lỗi hiện dưới ô, ô **vẫn sửa được** (không văng màn lỗi riêng) — cross-ref khái niệm expired/revoked ở F7/F10 nhưng ở tầng UI | P2 |
| TC-F4-14 | §6.1 | Mất mạng | Dán link | Báo lỗi tương ứng, thử lại được | P2 |
| TC-F4-15 | §6.1 | Đang hiện lỗi từ link cũ | Sửa lại link | Lỗi cũ **biến mất ngay** khi gõ | P3 |

**Màn xem trước rồi Join:**

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F4-16 | §6.2 | Mở link https trực tiếp hoặc bấm Continue | — | Thẻ tóm tắt đầu màn + ngay dưới là ghi chú "tên/mô tả là lời người gửi… lịch cũng xuất hiện trong app Lịch của Apple" | P3 |
| TC-F4-17 | §6.2 | — | — | Đáy màn chỉ còn nút "Join calendar" — đoạn chữ dài trước đây đã chuyển lên trên | P3 |
| TC-F4-18 | §6.2 | Link của người gửi ẩn danh (không tên/mô tả) | — | Các dòng tên/mô tả **biến mất hẳn**, không để trống | P2 |
| TC-F4-19 | §6.2 | — | Bấm Join calendar | Lịch hiện trong Calendars **và** trong app Lịch của Apple — cross-ref cơ chế 13.1 | P2 |
| TC-F4-20 | §6.2 (regression, nối 13.1) | Vừa join qua đường paste-link (khác đường mở trực tiếp link web) | Chạy lại 4 case ở 13.1 | Kết quả phải giống hệt dù join qua đường nào — cả 2 entry point (paste-link và mở trực tiếp) đều phải an toàn như nhau | P1 |

### 13.6 Tài khoản (UI) — nối vào F2

**Chưa đăng nhập:**

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F2-11 | §7.1 | Chưa đăng nhập | Mở Cài đặt | Dòng tài khoản có mascot Ink + câu mời, **không còn** ghi "Account · Not signed in" | P3 |
| TC-F2-12 | §7.1 | — | Mở màn Account | Có hình minh hoạ + 3 dòng lợi ích | P3 |
| TC-F2-13 | §7.1 (điểm nối quan trọng — xem 13.7) | — | Đọc 3 dòng lợi ích | Chỉ hứa những gì tài khoản thật sự mở ra (**tạo** link chia sẻ) — **không** hứa việc **join** link (việc đó miễn phí) | **P1** |
| TC-F2-14 | §7.1 | — | Xem nút đăng nhập Google | Dùng logo màu thật, không phải chữ G xám | P3 |
| TC-F2-15 | §7.1 | — | Mở màn mời đăng nhập (login gate) | **Không còn** nút Cancel — chỉ thoát bằng vuốt xuống | P2 |

**Đã đăng nhập:**

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F2-16 | §7.2 | Đã đăng nhập | Mở Cài đặt | Thẻ tài khoản là MỘT dòng (ảnh đại diện · tên/email · mũi tên) — không còn 3 dòng riêng, không còn "Signed in with Google" | P3 |
| TC-F2-17 | §7.2 | — | — | Cạnh tên có logo nhà cung cấp (Apple/Google) cỡ nhỏ | P3 |
| TC-F2-18 | §7.2 (case hay vỡ theo chính dev cảnh báo — Apple thường không trả tên) | Đăng nhập Apple, tài khoản không có tên | — | Chỗ tên hiện **"Apple Account"**; ảnh đại diện là **icon người trên nền tròn**, không phải vòng tròn trống | P2 |
| TC-F2-19 | §7.2 | — | Mở màn Account | Sign out và Delete account **cùng kiểu nút ở chân màn**, chỉ khác màu (thường vs đỏ/coral) | P2 |
| TC-F2-20 | §7.2 | — | Bấm Sign out | Thoát đúng, không ảnh hưởng dữ liệu đã share/joined | P2 |
| TC-F2-21 | §7.2 (= điểm vào UI thật của TC-F12-04) | — | Bấm Delete account | Hỏi xác thực lại **trước** khi xoá — sau khi xác thực, kích hoạt đúng `DELETE /api/ink/account` (TC-F12-04, mục 10.8) | **P1** |

### 13.7 Đối chiếu ngược UI thật với backend — 2 câu hỏi mở mới

**1. "Time range" (3/6/12 tháng · All upcoming) hoạt động ở tầng nào của backend?** Khái niệm này **không hề
xuất hiện** ở `ink-identity-sync-flow.html` (§0–§7) lẫn trong toàn bộ câu trả lời của dev (§3 xác nhận cơ chế
sync là push/pull row-level theo `isDirty` + cursor `since` — không có khái niệm "chỉ đồng bộ N tháng tới").
Giả thuyết hợp lý nhất: Time range chỉ là bộ lọc áp dụng **lúc seed ban đầu** (§2, batch ghi `calendar_events`
lần đầu khi tạo share), không phải một ràng buộc còn hiệu lực cho các lần sync sau. Nếu đúng vậy: 1 event
owner tạo **sau** khi share (vd 13 tháng sau, với Time range đã chọn là "12 months") có được đồng bộ sang
receiver hay bị chặn vĩnh viễn vì "ngoài time range lúc tạo"? Ảnh hưởng trực tiếp lời hứa "đồng bộ sống động"
của toàn bộ §3. → **Thêm vào round 2** của
[ink-identity-sync-flow-open-questions-for-dev.md](ink-identity-sync-flow-open-questions-for-dev.md) (Q20).

**2. UI gate "chưa đăng nhập → màn mời đăng nhập" (TC-F3-32) không mâu thuẫn với backend cho phép uid ẩn danh
tạo share (TC-F2-09), nhưng cần 1 case bảo mật xác nhận rõ:** nếu gọi thẳng `POST /api/ink/share` bằng token
ẩn danh (bỏ qua UI), backend có tạo share thành công không? Nếu có — đúng như thiết kế linh hoạt đã xác nhận,
không phải bug — nhưng QC cần biết trước để không báo nhầm khi test trực tiếp bằng Postman/curl thấy hành vi
"khác" so với UI.

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F3-45 (mới) | Đối chiếu TC-F3-32 (UI gate) với TC-F2-09 (backend permissive) | Có uid ẩn danh hợp lệ (chưa link Apple/Google) | Gọi thẳng `POST /api/ink/share` bằng token ẩn danh, không qua UI | Xác nhận: tạo share thành công (đúng thiết kế linh hoạt của backend) — nếu bị chặn, đây là điểm KHÔNG khớp với TC-F2-09 đã verify trước đó, cần báo lại | P2 |

### 13.8 Ngoài phạm vi Định danh/Chia sẻ/Đồng bộ/Sao lưu — cùng PR nhưng khác feature area

Không mở rộng scope chính của test plan này — liệt kê để không mất thông tin từ bàn giao gốc, tham chiếu trực
tiếp [qc-sharing-account-pro.md](qc-sharing-account-pro.md) khi cần test:

- **§8 Header Discover** — nền tím, wordmark to hơn, pill Pro 2 trạng thái (chưa mua/đã mua), hiệu ứng sao
  trôi + Reduce Motion + pin drain khi để Discover chạy nền lâu. Thuộc feature Discover/Pro, không phải
  identity/share/sync.
- **§9 Quy ước nút ✕ sang trái + CTA sát đáy** — quy ước UI áp dụng toàn app (Pro paywall, chọn màu event,
  chọn nhắc nhở, màn giải thích lock screen). Cross-cutting UI convention, không riêng sharing.
- **§10 Collection → tab Widget** — hiển thị đúng ghi chú đã chọn cho widget note. Thuộc feature
  Discover/Widget, không liên quan identity/share/sync/backup.

**Ghi chú hữu ích rút ra từ §11–12 của bàn giao gốc, đáng giữ lại dù không viết thành TC riêng:**

- "Manage sharing" chưa dịch ở 11 ngôn ngữ — đã biết, không report.
- Sửa event trực tiếp trong app Lịch Apple cho 1 lịch đã join **không được giữ lại** — đúng thiết kế, nhưng
  **không có copy nào trong app nói điều này**. Đáng chú ý về mặt kỹ thuật: enforcement "read-only" của F6/§3
  chỉ chặn được ở tầng **sync** (push bị từ chối + lần pull sau ghi đè lại đúng bản server) — **không** chặn
  được việc user tự sửa trực tiếp qua EventKit ở tầng OS, vì đó là 1 lịch thật, không có cơ chế khoá nào của
  Apple Calendar biết tới khái niệm "read_only" của Ink. Không phải bug, nhưng nên hiểu đúng ranh giới enforcement thật (chỉ ở lớp sync, không ở lớp OS) khi review case liên quan.
- Rà hồi quy thêm: `InkPopupScaffold` (padding đáy), `InkTextField` (nút trong ô + dòng lỗi) — 2 component
  dùng chung, ảnh hưởng nhiều sheet/form khác ngoài phạm vi sharing — nên rà lướt nhanh các màn hình khác
  dùng chung 2 component này dù không phải trọng tâm test plan.

---

Nguồn gốc của test plan này: [ink-identity-sync-flow.html](../specs/Ink%20Login%20and%20sharing%20calendar%20docs/ink-share-last-update/ink-identity-sync-flow.html) —
worker PR #16–#20 · cập nhật 2026-09-18. Không đối chiếu với bất kỳ tài liệu sharing nào khác trong repo theo
đúng yêu cầu ban đầu. **Mục 12 (2026-09-18)** bổ sung câu trả lời trực tiếp từ dev, đối chiếu code thật ở
`worker-ink-lockscreen-calendar@main`/`lockscreen-calendar@main` — xem đầy đủ ở
[ink-identity-sync-flow-answers-from-dev.md](ink-identity-sync-flow-answers-from-dev.md). **Mục 13
(2026-09-19)** tích hợp UI/UX thật từ PR #260/#274 — xem đầy đủ ở
[qc-sharing-account-pro.md](qc-sharing-account-pro.md).
