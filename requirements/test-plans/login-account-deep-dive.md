# Test Design (đào sâu) — Scope A: Ink Login & Account

> **Thuộc test plan chung:** [login-and-calendar-sharing.md](login-and-calendar-sharing.md) — tài liệu này chỉ
> đào sâu Scope A (mục 2 "Scope A — Login & Account" của test plan chung), xuống tới mức Test Case Specification
> theo ISTQB. Không lặp lại mục 1, 3, 4, 7–9 của test plan chung — đọc file đó trước để có bối cảnh.
> **Test basis chính:** [ink-account-login-management-spec-v1.4.md](../specs/Ink%20Login%20and%20sharing%20calendar%20docs/ink-account-login-management-spec-v1.4.md)
> **Đối chiếu chéo với:** [calendar-share-live-prd-v1.9.md](../specs/calendar-share-live-prd-v1.9.md) §4.1, §4.4, §4.10–4.12; [ink-share-link-inapp-uiux-spec-v1.4.md](../specs/Ink%20Login%20and%20sharing%20calendar%20docs/ink-share-link-inapp-uiux-spec-v1.4.md) §6, §20, §24–25
> **Ngày lập:** 2026-09-16 · **Người lập:** QC

---

## 1. Phát hiện mới khi đọc sâu Scope A (chưa có trong test plan chung)

Đọc kỹ từng mockup ASCII + so khớp literal copy giữa 3 tài liệu vẽ cùng 1 màn hình (login spec, in-app spec,
PRD) — không chỉ đọc acceptance criteria — lộ ra các khác biệt sau. Tất cả đều **verify được ngay bằng cách đọc
tài liệu**, không cần chờ build.

### 1.1 Sheet "Sign in to share" — 2 điểm khác nhau giữa 2 tài liệu vẽ cùng 1 màn hình

| | Login spec §5 (dòng 284, 296) | In-app spec §6 (dòng 242, 254) |
|---|---|---|
| Tiêu đề sheet | "**Sign in to share this calendar**" | "**Sign in to share**" |
| Nút dismiss | "**Cancel**" | "**Not now**" |
| Body text | "Sign in to create a share link and manage it later from your Ink account." | *giống hệt* |
| 2 nút provider | Continue with Apple / Continue with Google | *giống hệt* |

→ Body text và hành vi (cancel = quay lại Manage Calendar, không tạo share) **giống nhau tuyệt đối** — chỉ
tiêu đề và nút dismiss khác. Đây là cùng 1 sheet (trigger: tap "Share calendar" lúc signed out), do 2 tài liệu
khác nhau vẽ, không có tài liệu nào tự nhận là bản cập nhật của tài liệu kia. AC-I5/AC-A3 chỉ mô tả hành vi
("presents login"), không có AC nào pin literal string — nên **không AC nào fail cả**, nhưng QC không thể viết
step "verify text = ..." chính xác tới khi PM chốt 1 bản.

### 1.2 CTA "Sign in to manage" khi Manage Sharing lúc signed out — 2–3 biến thể nút

| Nguồn | Body text | Nút bấm |
|---|---|---|
| Login spec §6 (dòng 334, 336) | "Sign in to manage this share." | `[ Sign in ]` |
| In-app spec §20 (dòng 666, 668) | "Sign in to manage this share." | `[ Sign in ]` |
| PRD Flow C §4.4 (dòng 623, 625) | "Sign in to manage the link." | `[ Sign in to manage sharing ]` |
| PRD D13 copy guideline §2.13 (dòng 405, trong danh sách "Prefer") | — (liệt kê như 1 cụm chuẩn) | "Sign in to manage this link" |

→ Body text: login spec/in-app spec khớp nhau ("share"), PRD Flow C lệch một chữ ("the link" thay vì "this
share") — khác biệt nhỏ, có thể chấp nhận được. Nhưng **nút bấm có tới 3 biến thể chữ khác nhau**
(`Sign in` / `Sign in to manage sharing` / `Sign in to manage this link`) cho cùng 1 hành động. AC-A6 chỉ nói
"offers Sign in to manage" — đủ mơ hồ để không AC nào literally fail, nhưng cũng đủ mơ hồ để 3 dev khác nhau
implement 3 kiểu khác nhau nếu không hỏi lại.

### 1.3 Copy "session hết hạn" — 2 câu khác nhau trong cùng 1 tài liệu

Login spec mô tả cùng một trigger ("user gặp owner-only action khi session không còn hợp lệ") ở 2 nơi với 2
câu khác nhau:

- §3.3 (dòng 183): *"Sign in again to continue managing this share."*
- §18.3 (dòng 705–707): tiêu đề "Sign in again", body *"Please sign in again to continue."*

Không rõ đây là 2 câu cho 2 tình huống khác nhau (vd. §3.3 là banner trạng thái, §18.3 là sheet full) hay đơn
giản là chưa đồng bộ khi viết. Mức độ thấp (P3) nhưng vẫn là điểm QC cần 1 câu trả lời rõ trước khi viết step
so khớp text.

### 1.4 Màn "Account — signed in" có 2 phiên bản khác nhau, không rõ khi nào dùng bản nào

So khớp §4.3 (Account — signed in, mockup "chuẩn") và §17 (Empty/first-time account state):

| | §4.3 | §17 |
|---|---|---|
| Body | "Your account is used for features that need ownership, such as managing shared calendars." | "You'll use it when a feature needs account ownership, such as sharing calendars." |
| Nút | `Sign out` | `Sign out` |
| **Section "ACCOUNT DATA / Delete account ›"** | **Có** | **Không có trong mockup** |

→ Đây là phát hiện quan trọng nhất của mục 1: **§17 hoàn toàn không vẽ mục Delete account**, trong khi §4.3 —
mô tả cùng trạng thái "Signed in" — luôn có. Tài liệu không có bất kỳ product rule nào nói Delete account bị
ẩn có điều kiện (ví dụ: "chỉ hiện sau khi user đã dùng ít nhất 1 feature cần ownership"). 2 khả năng:
1. §17 chỉ là mockup minh hoạ chưa vẽ đủ, Delete account luôn phải có mặt — cần hỏi lại người viết PRD để xác nhận.
2. §17 là chủ đích: Delete account bị ẩn cho tới khi có "account-owned data" gì đó để xoá — nếu đúng, đây là một
   **business rule chưa được viết thành AC nào**, và cần 1 AC mới trước khi test.

Không tự suy đoán theo đúng nguyên tắc AI Requirements của `screenshot-naming.md` §8.7 — xem test case
TC-A-scope-17 ở mục 4 và mục 5 (Open).

### 1.5 Không có trạng thái transient nào cho quá trình reconcile (owner self-follow)

Cả login spec §7, PRD §4.12/D10, in-app spec §24–25 đều chỉ vẽ flow ở mức node-to-node ("Sign in → Ink detects
owner → Manage Sharing"), không tài liệu nào mô tả **người dùng nhìn thấy gì trong lúc chuyển đổi** — ví dụ
nếu owner đã lỡ add bản receiver "Work · Shared" trước khi login, sau khi login thành công, dòng đó biến mất
khỏi Calendars list và dòng "Work" gốc đổi trạng thái sang Shared **ngay lập tức hay có hiệu ứng/loading nào**?
Nếu không có bất kỳ trạng thái trung gian nào, user có thể thấy danh sách Calendars "giật" (1 dòng biến mất đột
ngột) và nghi ngờ mất dữ liệu — đúng loại cảm giác mà PRD §4.9 (Flow H) cố tình tránh cho trường hợp receiver
("Do not silently make the calendar disappear"). Đây là gap về trải nghiệm khi reconcile, chưa có test case cụ
thể cho tới khi có quyết định UX (xem mục 5).

### 1.6 AC-A13 đã lỗi thời so với chính PRD (liên kết tới phát hiện subscriber-count ở test plan chung)

AC-A13 ("The owner is not counted as a receiver subscriber after ownership is known") giả định v1 **có** khái
niệm đếm subscriber để mà "không đếm owner vào". Nhưng PRD D12 (đã áp dụng từ bản 1.6) khẳng định **v1 không hề
track subscriber count dưới bất kỳ hình thức nào** — nghĩa là AC-A13 hiện tại **không thể fail theo nghĩa đen**
(không có gì để đếm), nhưng cũng không thể "pass" theo đúng tinh thần ban đầu của nó. Login spec (v1.4) chưa
được cập nhật theo quyết định 1.6 của PRD, giống hệt gap đã tìm thấy ở `ink-share-link-inapp-uiux-spec-v1.4.md`
trong test plan chung (mục 6/10). Khuyến nghị: test AC-A13 ở dạng phủ định rộng hơn — "không có bất kỳ UI/số
liệu nào ngụ ý owner là 1 trong các subscriber" — thay vì cố tìm một con số cụ thể để so sánh.

### 1.7 Case chưa có test rõ ràng: đổi provider đăng nhập trên cùng máy (Apple ⇄ Google)

Không tài liệu nào vẽ 1 flow "đổi provider" trực tiếp — chỉ có Sign out rồi Sign in lại. Nhưng theo §2.5 (login
spec), Apple và Google là **2 Ink account khác nhau** trong v1. Hệ quả cần test rõ: nếu máy đang Signed in với
Apple, sở hữu share cho calendar "Work", user Sign out rồi Continue with Google (dù trùng email) → theo đúng
model, Google-account này **không sở hữu** share "Work" đó. Không tài liệu nào có mockup cho case này, nhưng
suy ra trực tiếp từ §2.5 + D9 (PRD) — đây là hệ quả tất định, không phải giả thuyết cần chờ build (cùng loại
lý luận đã dùng ở Decision Table 3 của `ai-assistant-tab.md`). Xem TC-A-07 ở mục 4.

---

## 2. State Transition chi tiết — Account

| # | Từ trạng thái | Sự kiện | Đến trạng thái | Ghi chú / Guard |
|---|---|---|---|---|
| T1 | `signed_out` | Continue with Apple/Google — thành công | `signed_in(provider, account_id)` | `account_id` gắn với provider, không merge theo email (§2.5) |
| T2 | `signed_out` | Continue with Apple/Google — thất bại | `signed_out` | Hiện "Couldn't sign in" (§18.2), không đổi trạng thái |
| T3 | `signed_out` (đang ở gate) | Cancel / Not now | `signed_out`, quay lại context trước đó | AC-A5 — không tạo/đổi share |
| T4 | `signed_in(X)` | Sign out | `signed_out` | Share/lịch nguồn/lịch đã nhận **không đổi** (AC-A8, AC-A9) |
| T5 | `signed_in(X)` | Session bị revoke (server-side, ngoài tầm kiểm soát UI) | `session_invalid` | Phát hiện **lười** — chỉ lộ ra khi user thử 1 owner-only action tiếp theo (§3.3) |
| T6 | `session_invalid` | User thử 1 owner-only action | hiện gate "Sign in again" | Không được ngụ ý đã mất calendar/share (§3.3) |
| T7 | gate "Sign in again" | Sign in lại thành công | `signed_in(X)` | Quay lại đúng action đang thực hiện (kế thừa AC-A4) |
| T8 | `signed_in(X)` | Delete account — xác nhận | `signed_out` | Tất cả share do X sở hữu dừng ngay (AC-A18, AC-A19); local calendar/lịch đã nhận **không đổi** |
| T9 | `signed_in(Apple, id1)` | Sign out rồi Continue with Google (dù trùng email) | `signed_in(Google, id2)`, **id2 ≠ id1** | Không được thừa kế quyền sở hữu share của id1 — xem TC-A-07 |
| T10 | `signed_out`, có local cache "calendar X từng được share" | Mở Manage Calendar của X | Hiện thẻ "Shared — Sign in to manage" | Local cache chỉ để hiển thị gợi ý, **không cấp quyền owner** (AC-A6) |
| T11 | `signed_in(X)` sở hữu share, mất nguồn (source unavailable) trên máy hiện tại | Nguồn xuất hiện lại (reconnect provider) | Share quay lại `shared` bình thường | Match theo ID, không theo tên (D9) |

## 3. Decision Table — Entry point đăng nhập × trạng thái account × gate hiển thị

| Entry point | Trạng thái account | Gate hiện ra | Sau khi thành công |
|---|---|---|---|
| Mở Manage Calendar (bất kỳ) | signed_out / signed_in / session_invalid | **Không có gate nào** | N/A — không cần login (AC-A2) |
| Tap "Share calendar" | signed_out | Sheet "Sign in to share..." (§1.1) | Vào thẳng Share Setup (AC-A4) |
| Tap "Share calendar" | signed_in, **nhưng calendar đã có active share** | Không hiện gate — route thẳng Manage Sharing | N/A (D5, không tạo link thứ 2) |
| Tap "Share calendar" | session_invalid | Cư xử như signed_out (§3.3 quy định move-back-to-signed-out) | Vào Share Setup |
| Mở thẻ "Shared" trên calendar đã từng share | signed_out | Thẻ "Sign in to manage this share" (§1.2) | Manage Sharing, load state từ server |
| Mở thẻ "Shared" | signed_in **nhưng account khác** không sở hữu share này | **Không có mockup nào cho case này** | Xem TC-A-07/08 — cần xác nhận hành vi |
| Mở link share của chính mình (Web View → Open in Ink) | signed_out | Preview kiểu receiver trước, gate login chỉ xuất hiện khi bấm hành động cần ownership | Sau login → Manage Sharing, không phải "Add to Ink" (D10) |
| Settings → Account | signed_out | Không phải "gate" (không có action nào bị chặn) — chỉ là màn hình Sign in chủ động | Quay lại Settings, **không** bị đẩy sang bất kỳ action sharing nào (khác 2.3 chỉ áp dụng cho login theo ngữ cảnh) |

## 4. Test Case Specification (TC-A-01 … TC-A-30)

Ký hiệu ưu tiên theo mục 6 của test plan chung: **P1** chặn release · **P2** phải test trước GA · **P3** cosmetic.

| ID | AC | Precondition | Steps (rút gọn) | Expected Result | Ưu tiên |
|---|---|---|---|---|---|
| TC-A-01 | AC-A1, AC-A2 | Cài mới, chưa từng đăng nhập | Mở app, browse calendar, mở Manage Calendar của 1 lịch bất kỳ | Không có gate login nào xuất hiện; mọi thao tác xem/đổi tên/màu/symbol hoạt động bình thường | P1 |
| TC-A-02 | AC-A1a | Settings → Account, chưa đăng nhập | Quan sát 2 nút provider | Cả `Continue with Apple` và `Continue with Google` cùng hiển thị | P2 |
| TC-A-03a | AC-A1b | Đã kết nối Google Calendar làm nguồn dữ liệu, **chưa** Sign in Ink bằng Google | Tap "Share calendar" trên 1 lịch iCloud | Gate login vẫn xuất hiện (Google Calendar connection ≠ Ink login) | P1 |
| TC-A-03b | AC-A1b | Đã Sign in Ink bằng Google, **không** kết nối Google Calendar làm nguồn | Share 1 lịch iCloud | Share thành công bình thường, không yêu cầu kết nối Google Calendar | P1 |
| TC-A-04 | AC-A3 | Signed_out, đang ở Manage Calendar | Tap "Share calendar" | Gate login xuất hiện đúng lúc bấm, không xuất hiện sớm hơn (khi mới mở Manage Calendar) | P1 |
| TC-A-05a | AC-A4, §1.1 | Signed_out, tap Share calendar | Đăng nhập thành công (Apple) | Trả thẳng về Share Setup của đúng calendar vừa chọn (không phải Settings, không phải Calendars list) | P1 |
| TC-A-05b | AC-A4, §1.1 | Như trên, dùng Google | Đăng nhập thành công (Google) | Kết quả giống TC-A-05a | P1 |
| TC-A-06 | AC-A5, §1.1 | Signed_out, tap Share calendar, gate hiện ra | Bấm nút dismiss (Cancel/Not now — ghi log copy thật đang hiển thị) | Quay lại Manage Calendar, **không** có share nào được tạo; verify bằng cách mở lại Manage Calendar | P1 |
| TC-A-07 | §1.7, D9 | Signed_in(Apple), sở hữu share "Work", có nguồn iCloud | Sign out → Continue with Google (email trùng với Apple ID) → mở Manage Calendar "Work" | Thẻ Sharing hiện **"Share calendar"** (not_shared) từ góc nhìn account Google — **không** tự động thừa kế/hiện share cũ của account Apple | P1 |
| TC-A-08 | §1.7, T10 | Máy B, signed_in bằng account **khác** account đã tạo share, cùng có lịch "Work" (khác nguồn/ID) | Mở Manage Calendar "Work" trên máy B | Thẻ Sharing hiện not_shared/độc lập cho account hiện tại — không hiện share của account kia | P1 |
| TC-A-09 | AC-A6, T10 | Signed_out, calendar có local cache "đã từng share" | Mở Manage Calendar | Hiện thẻ "Shared — Sign in to manage", **không** có bất kỳ nút owner action nào (Copy link/Stop sharing) khả dụng trực tiếp từ cache | P1 |
| TC-A-10 | AC-A6 | Từ TC-A-09, bấm Sign in, đăng nhập thành công, account **đúng là chủ** share | — | Vào Manage Sharing với state tải từ server (không phải từ cache); state hiển thị khớp server (vd. Updated X phút trước theo server, không phải theo cache cũ) | P1 |
| TC-A-11 | AC-A6 | Từ TC-A-09, đăng nhập thành công nhưng account **không phải chủ** share (vd. cache sai/máy đổi chủ) | — | Không được cấp quyền owner action; hiển thị trạng thái phù hợp (không có mockup — ghi nhận là case cần hỏi PM, xem mục 5) | P2 |
| TC-A-12 | AC-A7 | Bất kỳ trạng thái account | Vào Manage Sharing / receiver Manage Calendar | Không có nút Sign out / Delete account nào xuất hiện ở các màn này (chỉ có ở Settings → Account) | P2 |
| TC-A-13 | AC-A8 | Signed_in, có 1 share đang active | Sign out | Mở lại (không cần signed in) — share vẫn hoạt động từ góc nhìn receiver (link vẫn add được ở máy khác) | P1 |
| TC-A-14 | AC-A9 | Signed_in, có lịch nguồn share + 1 lịch đã nhận (receiver) | Sign out | Cả 2 lịch vẫn còn nguyên trong Calendars list, dữ liệu iCloud/Google gốc không đổi (verify ở app nguồn) | P1 |
| TC-A-15 | AC-A10, AC-A11 | Đã Sign out ở TC-A-13, lịch nguồn vẫn có mặt trên máy | Sign in lại (cùng account) | Manage Sharing của "Work" trở lại bình thường, đúng link/expiry/visibility cũ | P1 |
| TC-A-16 | AC-A11, D9 | Sign out, sau đó **xoá** lịch nguồn khỏi provider (hoặc ngắt kết nối account provider) trước khi sign in lại | Sign in lại | Hiện "Source calendar unavailable" (hoặc copy đã chốt — xem test plan chung mục 5 Decision Table 3), **không** tự rebind sang lịch khác dù trùng tên | P1 |
| TC-A-17 | §18.2 | Signed_out, tap provider nào đó, giả lập lỗi mạng/OAuth | — | Hiện "Couldn't sign in / Try again in a moment" + 2 nút Try again/Cancel; Cancel quay lại đúng context trước đó (không rơi vào share dở dang) | P2 |
| TC-A-18 | §18.3, §3.3 | Signed_in, session bị revoke ở phía server (giả lập bằng cách thu hồi token) | Thử 1 owner-only action (vd Stop sharing) | Hiện gate "Sign in again", **ghi lại đúng copy thật hiển thị** (đối chiếu với 2 biến thể ở mục 1.3) | P2 |
| TC-A-19 | §4.3 vs §17 (mục 1.4) | Tài khoản **mới toanh**, chưa từng dùng bất kỳ action nào cần ownership | Settings → Account (chủ động sign in trước, không qua contextual gate) | Ghi nhận: màn Account có mục "ACCOUNT DATA / Delete account" hay không? So với sau khi đã tạo 1 share rồi quay lại Account | P2 |
| TC-A-20 | AC-A12, D10 | Signed_out, mở link share **của chính mình** (gửi từ máy khác/account khác) | Web preview → Open in Ink → Sign in bằng đúng account chủ | Route thẳng vào Manage Sharing, **không** hiện "Add to Ink" | P1 |
| TC-A-21 | AC-A13 | Như TC-A-20, sau khi vào Manage Sharing | Kiểm tra toàn màn hình Manage Sharing + calendar card | Không có bất kỳ số liệu/badge nào ngụ ý owner là 1 subscriber (xem §1.6 — test ở dạng phủ định, không tìm số cụ thể) | P2 |
| TC-A-22 | AC-A14 | Signed_out, mở link share của chính mình, **lỡ bấm Add to Ink** trước khi sign in (tạo bản receiver trùng "Work · Shared") | Sign in bằng đúng account chủ | Bản receiver trùng biến mất/merge; Calendars list chỉ còn 1 dòng "Work" (Shared, owner state), **không** còn dòng "Work · Shared" kiểu receiver | P1 |
| TC-A-23 | §1.5 | Như TC-A-22 | Quan sát khoảnh khắc reconcile (không background app) | Không có hiện tượng "giật"/dòng biến mất đột ngột không giải thích; nếu có, ghi nhận làm UX bug nhẹ (xem mục 5) | P3 |
| TC-A-24 | AC-A15 | Signed_in | Vào Settings → Account | Sign out và Delete account là 2 nút/entry **tách biệt rõ ràng**, không gộp/không dễ bấm nhầm | P1 |
| TC-A-25 | AC-A16, AC-A17 | Signed_in, có ít nhất 1 share active | Bấm Delete account | Sheet xác nhận nêu rõ: (a) active share links sẽ dừng, (b) lịch ở Apple/Google/Outlook **không** bị xoá — verify đúng 2 câu này có mặt | P1 |
| TC-A-26 | AC-A18 | Từ TC-A-25, xác nhận Delete account | — | App quay về trạng thái signed_out **nhưng vẫn dùng được bình thường** (không crash, không màn hình chặn) | P1 |
| TC-A-27 | AC-A19 | Từ TC-A-26, có receiver ở máy khác đang follow share đã bị dừng do xoá account | Máy receiver mở lại calendar đó (trigger refresh) | Receiver thấy "No longer shared", không bị xoá lịch đột ngột, không còn nhận update mới | P1 |
| TC-A-28 | §18.4 | Signed_in, bấm Delete account, giả lập lỗi mạng/server lúc xử lý | — | Hiện "Couldn't delete account / Nothing was deleted", **không** tự động sign out, không giả vờ đã xoá thành công | P1 |
| TC-A-29 | §19 (Accessibility) | Bật VoiceOver | Duyệt qua Settings → Account ở cả 2 trạng thái, và cả 2 gate login | Nút Continue with Apple có accessible label riêng; trạng thái Signed in/Signed out không chỉ dựa vào icon/màu; copy xoá tài khoản đọc rõ ràng qua screen reader | P2 |
| TC-A-30 | Analytics §20 | Bất kỳ | Thực hiện đủ chuỗi: mở gate → cancel → mở gate lại → sign in thành công → sign out → delete account | Đúng thứ tự event: `share_login_gate_shown`/`share_manage_login_gate_shown` → `account_sign_in_cancelled` → lặp lại gate → `account_sign_in_started` → `account_sign_in_completed` → `account_sign_out` → `account_delete_started` → `account_delete_completed`; không event nào chứa token/nội dung calendar | P3 |

## 5. Open — riêng Scope A (bổ sung cho mục 10 của test plan chung)

| # | Câu hỏi | Ảnh hưởng |
|---|---|---|
| 1 | Chốt 1 bản duy nhất cho sheet "Sign in to share..." — tiêu đề và nút dismiss (mục 1.1) | Chặn TC-A-05/06 ở mức verify literal string |
| 2 | Chốt 1 bản duy nhất cho nút CTA "Sign in to manage..." (mục 1.2) | Chặn TC-A-09/10 ở mức verify literal string |
| 3 | 2 câu "sign in again" ở §3.3 vs §18.3 có phải 2 UI khác nhau, hay cần gộp thành 1? (mục 1.3) | Chặn TC-A-18 ở mức verify literal string |
| 4 | Delete account có bị ẩn có điều kiện ở lần đầu signed-in chưa dùng feature nào không (§17 vs §4.3, mục 1.4)? Nếu có, cần 1 AC mới mô tả điều kiện chính xác | Chặn TC-A-19 |
| 5 | Có cần 1 trạng thái loading/transient khi reconcile bản receiver trùng của owner không (mục 1.5)? | Ảnh hưởng UX, không chặn functional test nhưng nên có quyết định trước khi polish |
| 6 | AC-A13 nên được viết lại thế nào cho khớp với quyết định D12 (bỏ subscriber counting) đã áp dụng ở PRD 1.6 nhưng chưa vào login spec? (mục 1.6) | Không chặn test (đã có hướng test âm ở TC-A-21), nhưng nên sửa văn bản AC gốc để tránh hiểu nhầm sau này |
| 7 | Hành vi chính xác khi account đang đăng nhập (signed_in) mở Manage Sharing của 1 calendar **thuộc account khác** — chưa có mockup nào (mục 1.7, Decision Table mục 3) | Chặn TC-A-11 ở mức chi tiết UI, hiện chỉ test được ở mức "không được cấp nhầm quyền owner" |
