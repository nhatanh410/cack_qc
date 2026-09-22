# Test Plan — Ink Login & Shared Calendars (live sharing)

> **Test basis:**
> - [ink-account-login-management-spec-v1.4.md](../../specs/login-and-calendar-sharing/ink-account-login-management-spec-v1.4.md) — Status: Draft — **Scope A, tiền đề**
> - [calendar-share-live-prd-v1.9.md](../../specs/login-and-calendar-sharing/calendar-share-live-prd-v1.9.md) — Status: Draft, open questions §9 — **Scope B, PRD chính**
> - [ink-share-link-inapp-uiux-spec-v1.4.md](../../specs/login-and-calendar-sharing/ink-share-link-inapp-uiux-spec-v1.4.md) — Status: Draft — **Scope B, in-app UI/UX**
> - [calendar-share-webview-spec-v1.3.md](../../specs/login-and-calendar-sharing/calendar-share-webview-spec-v1.3.md) — Status: Draft — **Scope B, web view trước khi cài Ink**
> **Flow map:** [screenshot-naming.md §7](../../../.claude/rules/screenshot-naming.md) chỉ có `11_share` (🚧 Phase 2, chưa build, chưa có screenshot) và ánh xạ tới `FB-301` trong [phase-2-feedback.md](../../specs/phase-2-feedback/phase-2-feedback.md) — **nhưng `FB-301` mô tả "share lịch — co-edit hoặc lịch cố định", còn 4 tài liệu test basis ở đây mô tả một sản phẩm khác: share qua link, read-only, không co-edit.** Đăng nhập (Scope A) không có flow-no riêng, hiện đang nằm trong `09_settings` (chỉ có 1 screenshot `home`, chưa có sub-screen Account).
> **Chuẩn:** ISTQB Foundation Level
> **Ngày lập:** 2026-09-16 · **Người lập:** QC

> ⚠️ **Đây là test plan shift-left**, giống `ai-assistant-tab.md`, không phải test plan cho build đang chạy: cả 4
> tài liệu đều **Status: Draft**, chưa có screenshot nào trong `09_settings` (Account) hay `11_share` — xem
> mục 8 (Entry criteria), hiện **chắc chắn chưa đạt**. Tài liệu này gộp **2 scope lớn liên hệ mật thiết** theo
> đúng yêu cầu: **Login (Scope A) là tiền đề bắt buộc của Sharing (Scope B)** — mọi acceptance action của
> Scope B (tạo share, quản lý share) đều đi qua cổng đăng nhập của Scope A trước, nên tách 2 test plan riêng
> sẽ làm mất các case liên khu vực (vd. cancel login giữa chừng Share Calendar). Toàn bộ mâu thuẫn/khoảng
> trống phát hiện được khi đối chiếu chéo 4 tài liệu được gom về **mục 10**.

---

## 1. Test basis

- **Login & Account spec (v1.4)** — nguồn duy nhất cho quy tắc "Ink works without an account. Sign in only
  when an action needs an account." (§1). Toàn bộ Decision Table/State Transition của Scope A dựa vào đây.
- **Shared Calendars PRD (v1.9)** — nguồn quyết định sản phẩm (13 quyết định D1–D13, §2) và acceptance
  criteria chính (AC-S/AC-R/AC-A/AC-P, §6). Changelog tự ghi **1.6 đã bỏ subscriber counting khỏi v1**
  (dòng đầu file) — chi tiết này quan trọng vì 2 tài liệu vệ tinh bên dưới **chưa được dọn theo quyết định
  này** (xem mục 10).
- **In-app UI/UX spec (v1.4)** — hiện thực hoá PRD thành màn hình cụ thể (mockup ASCII), acceptance AC-I1–I30.
  Là nguồn tốt nhất cho state map sender/receiver (§34–35) — dùng trực tiếp cho State Transition Testing.
- **Web View spec (v1.3)** — riêng cho surface **không cần cài Ink** (public, unauthenticated), acceptance
  AC-W1–W17. Đây là nơi rủi ro privacy-leak dễ xảy ra nhất vì receiver có thể inspect network response trực
  tiếp mà không qua UI Ink.
- **Cảnh báo test-basis:** cả 3 tài liệu vệ tinh đều tự khai `Related docs` ở phiên bản **cũ hơn** phiên bản
  thật đang có trên đĩa — Login spec khai PRD "v1.8" (thật: v1.9), Web View "v1.2" (thật: v1.3); In-app spec
  khai PRD "v1.8", Web View "v1.2", Login "v1.3" (thật: v1.4). Tức là **không tài liệu vệ tinh nào chắc chắn
  đã đọc bản mới nhất của tài liệu kia** khi được cập nhật lần cuối — QC không dùng "Related docs" của một
  file để suy luận về nội dung file khác, luôn đối chiếu trực tiếp bản trên đĩa (xem mục 10).

## 2. Test object — In scope

### Scope A — Login & Account (tiền đề)

| # | Feature | Nguồn |
|---|---|---|
| A1 | Không cần đăng nhập để dùng calendar cơ bản, mở Manage Calendar; chỉ hỏi login khi bắt đầu action cần ownership | §1–2, AC-A1, AC-A2 |
| A2 | Continue with Apple / Continue with Google — 2 phương thức cho **cùng 1 khái niệm Ink account**; Google Calendar connection ≠ Ink login | §2.1, §2.5, AC-A1a, AC-A1b |
| A3 | Cổng login theo ngữ cảnh (contextual sheet) tại Share Calendar / Manage Sharing, quay lại đúng action sau khi login thành công, không tạo gì nếu cancel | §2.2–2.3, §5–6, AC-A3–A6 |
| A4 | Sign out — chỉ dừng quyền quản lý trên máy này, **không** dừng share/xoá lịch nguồn/lịch đã nhận | §8, AC-A8, AC-A9 |
| A5 | Sign back in — nạp lại share do account sở hữu, đối chiếu với lịch nguồn hiện có trên máy | §9, AC-A10, AC-A11 |
| A6 | Delete account — khác Sign out, dừng toàn bộ share do account sở hữu, không đụng lịch nguồn ngoài Ink | §10–12, AC-A15–19 |
| A7 | Owner tự mở link share của chính mình khi đang signed out → sau khi login được route thẳng vào Manage Sharing, không tạo bản receiver trùng | §7, AC-A12–14 |
| A8 | Error state: sign-in cancelled / failed, session hết hạn giữa chừng một action cần ownership | §18 |
| A9 | Account IA: chỉ sống ở Settings → Account, không có "sharing account" riêng, không lặp control ở màn hình khác | §4, §15, AC-A7 |

### Scope B — Sharing Calendar (phụ thuộc Scope A)

| # | Feature | Nguồn |
|---|---|---|
| B1 | IA calendar-first: Calendars → Manage Calendar → Sharing; mở Manage Calendar không cần login | D4, AC-S1, AC-I2 |
| B2 | Điều kiện được share dựa trên quyền sở hữu nguồn, không dựa provider (bảng D8) | D8 (PRD §2.8), §5 in-app |
| B3 | Share setup: preview, 3 toggle visibility (Event names/Locations/Notes), expiry mặc định 90 ngày (30/90/365), disclosure sự kiện tương lai tự động thêm | §4.2 PRD, §5.8–5.9, §7–8 in-app |
| B4 | Tạo link — một calendar chỉ 1 active share; chống double-tap tạo nhiều link | D5, §9 in-app |
| B5 | Trạng thái sender: Shared / Source calendar unavailable (hay "Can't update this share" — xem mục 10) / Expired; Copy link / Share… / Refresh now (Check for updates) / Stop sharing / Renew | §3.3–3.5, §5.1, §5.5, §5.10 PRD; §11–23 in-app |
| B6 | Publish tự động "khi Ink có cơ hội"; Refresh now/Check for updates chỉ là fallback thủ công, không phải cơ chế publish chính | D6, §12 in-app |
| B7 | Nhận diện lịch nguồn không dựa vào tên — đúng qua rename, reconnect, đổi máy, login máy mới, xoá-tạo lại cùng tên | D9, §5.6, §22–23 in-app |
| B8 | Access policy v1 = `anyone_with_link`; UI không ngụ ý biết danh tính/số lượng subscriber | D11, D12, AC-P1–P4 |
| B9 | Web View: preview an toàn đúng theo visibility sender đã chọn, CTA Open in Ink/Get Ink, phân biệt rõ Expired/No longer shared/Invalid/Loading-fail/Temporary-connectivity | Toàn bộ webview spec, AC-W1–W17 |
| B10 | Receiver trong Ink: Add to Ink (không phải Import), read-only, tuỳ biến local (tên/màu/symbol) sống sót qua update từ sender, trạng thái Active/Stale/No longer shared/Expired | §4.6–4.9 PRD; §26–35 in-app |
| B11 | Stop sharing — xác nhận nêu rõ hậu quả, revoke vĩnh viễn; share lại sau đó tạo **link mới** (khác Renew) | §4.5 PRD, §18–19 in-app |

## 3. Out of scope

- **ICS/webcal, Subscribe in Apple/Google/Outlook Calendar, ICS parser Swift** — PRD §8 loại trừ tường minh, D1.
- **Receiver edit sự kiện nguồn, two-way sync** — D2, PRD §8.
- **Nhiều active link cho 1 calendar, nhiều calendar trong 1 link, re-share lịch đã nhận từ Ink khác** — D5, D8, PRD §8.
- **Login bắt buộc toàn app, login chỉ để mở Manage Calendar, "sharing account" riêng** — PRD §8, §2.2 login spec.
- **Invite-by-email, invite-only/hybrid access, subscriber/member identity, subscriber count** — D11–D12, PRD §8. Quan trọng: đây là loại trừ **tường minh và nhấn mạnh nhiều lần**, nhưng 2 trong 4 tài liệu vệ tinh vẫn còn sót copy guideline ngược lại — xem mục 6 (P1) và mục 10, **không viết acceptance case cho subscriber count trong scope này** dù văn bản có nhắc tới.
- **Flow co-edit/GSS (FB-301, phase-2-feedback.md §P3)** — đây là một sản phẩm sharing **khác**, chưa có spec chi tiết, chưa nên gộp chung test design với 4 tài liệu ở đây dù `screenshot-naming.md` đang tạm gán cả hai vào cùng flow-no `11_share`. Cần làm rõ với team trước khi chụp screenshot đầu tiên của Scope B (xem mục 10).
- **Background-sync real-time đảm bảo tức thời, đo lường latency chính xác của "khi Ink có cơ hội"** — PRD §8 tự nhận là không cam kết.

## 4. Test levels & types

- **Test levels (đủ 4 cấp vì có backend riêng — share record, publish trigger, OAuth):**
  - Component: OAuth Apple/Google token exchange; share record CRUD; expiry job (30/90/365 ngày); publish-on-opportunity trigger.
  - Integration: Ink ↔ backend ↔ EventKit/Google Calendar/Outlook provider; Ink ↔ Web View (deep link `Open in Ink`); account service ↔ share ownership reconciliation.
  - System: toàn bộ flow sender/receiver trên TestFlight + Web View thật (không giả lập), black-box.
  - Acceptance: theo đúng ngôn ngữ user-facing quy định ở §14 login spec và §36 in-app spec (không dùng thuật ngữ nội bộ owner/receiver/subscription khi verify copy).
- **Functional:** đúng 11 acceptance nhóm A + 11 nhóm B ở mục 2; đặc biệt verify **share ID không đoán được**
  (không phải sequential/incremental) vì Web View là surface public không cần đăng nhập — ai có link là xem
  được preview.
- **Non-functional:**
  - *Security:* OAuth token không lộ trong log/analytics (§20 login spec: "Do not put authentication
    credentials or private calendar content into analytics"); **visibility filtering (Event names/Locations/
    Notes) phải enforce ở server**, không chỉ ẩn ở client — vì Web View public không qua app nên client-side
    filter vô nghĩa nếu API trả full payload; deep link `inkcalendar.app/s/...` không cho phép IDOR sang share
    khác bằng cách đoán/tăng ID.
  - *Privacy:* AC-W5, §8 webview spec — hidden field không bao giờ xuất hiện trong response lẫn UI.
  - *Usability:* 5 trạng thái "tại sao tôi không quản lý/cập nhật được share này" (session hết hạn / source
    unavailable / expired / stopped / network) phải phân biệt được bằng copy, không rely màu sắc (AC-W accessibility,
    §37 in-app).
  - *Reliability:* tạo share phải idempotent khi double-tap (§9 in-app); reconciliation dedupe khi owner tự
    follow chính mình không được tạo state rác vĩnh viễn.
  - *Accessibility:* §19 login spec, §19 webview spec, §37 in-app spec — dấu chấm màu ("● Shared") không được
    là cách duy nhất truyền đạt trạng thái; Sign in with Apple phải có accessible label riêng.
- **Change-related (regression):** Sharing section được **chèn thêm** vào màn Manage Calendar đã tồn tại sẵn
  (Name/Color/Symbol editing) — phải test lại đường cũ (đổi tên/màu/symbol của calendar không share) không bị
  ảnh hưởng bởi UI mới; tương tự Settings → Account là section mới chèn vào Settings đã có (chỉ có
  `09_settings_01_home` hiện tại).

## 5. Kỹ thuật thiết kế test case

- **Equivalence Partitioning:**
  - Trạng thái account: {signed out · signed in · session invalid/revoked}.
  - Provider đăng nhập: {Apple · Google} × thiết bị {máy A · máy B cùng account}.
  - Loại lịch nguồn (bảng D8, PRD §2.8): {iCloud/local/Google/Outlook do user sở hữu (share được) · read-only
    của người khác · subscribed/public · system-generated (holiday) · đã nhận qua Ink (không re-share được)}.
  - Trạng thái share phía sender: {not_shared · shared · source unavailable · expired}.
  - Trạng thái share phía receiver: {active · stale (refresh fail tạm thời) · no longer shared · expired}.
  - Ink đã cài hay chưa khi mở Web View: {đã cài · chưa cài}.
- **Boundary Value Analysis:**
  - Expiry: {30, 90, 365} ngày — test tại chính giá trị và ±1 ngày quanh mốc hết hạn thực tế (vd còn 1 ngày,
    đúng ngày hết hạn, quá hạn 1 ngày) để verify đúng lúc chuyển sang **Expired**.
  - Preview Web View "roughly 3–6 upcoming events" (§16 webview spec) — test với lịch có 0, 1, 3, 6, 7 sự kiện
    sắp tới để verify ngưỡng hiển thị và copy "+N upcoming events".
  - Renew ngay trước/ngay sau mốc hết hạn — verify Renew giữ nguyên link (§5.10 PRD) còn Stop sharing luôn tạo
    link mới, không nhầm lẫn 2 action ở boundary hết hạn.
- **Decision Table 1 — Điều kiện share theo loại lịch nguồn (PRD D8, tái sử dụng nguyên bảng gốc):**

  | Loại lịch nguồn | Share qua Ink ở v1 |
  |---|---:|
  | iCloud calendar do user sở hữu | Có |
  | Local calendar do user sở hữu | Có |
  | Google calendar do user sở hữu | Có |
  | Outlook calendar do user sở hữu | Có |
  | Read-only calendar do người khác quản lý | Không |
  | Subscribed/public calendar | Không |
  | System-generated (vd holiday) | Không |
  | Calendar đã nhận qua Ink sharing | Không (không re-share) |

- **Decision Table 2 — Tổ hợp 3 toggle visibility × nội dung receiver thấy được (GAP — chỉ 2/8 tổ hợp có mockup minh hoạ, xem mục 10):**

  | Event names | Locations | Notes | Receiver thấy gì (theo tài liệu) |
  |---|---|---|---|
  | ON | ON | OFF | Đúng mockup mặc định §7 in-app spec — tên + địa điểm, không note |
  | OFF | OFF | OFF | Đúng mockup §8.2 webview — chỉ "Busy" theo khung giờ |
  | ON | OFF | ON/OFF | **Không có mockup** — tên sự kiện hiển thị nhưng địa điểm ẩn, cần PM xác nhận layout |
  | OFF | ON | ON/OFF | **Không có mockup** — nếu tên ẩn nhưng location bật, có lộ ngữ cảnh riêng tư gián tiếp qua địa điểm không? |
  | ON/OFF | ON/OFF | ON | **Không có mockup nào bật Notes cả** — PRD default set Notes OFF; chưa rõ preview trông thế nào khi Notes ON |

  → Không viết case chi tiết cho 6 tổ hợp còn thiếu tới khi có xác nhận từ PM (mục 10); chỉ giữ ở mức test
  design để không phải viết lại nếu layout đổi.

- **Decision Table 3 — Lý do "không quản lý/cập nhật được share này" × copy hiển thị (mâu thuẫn thuật ngữ, xem mục 6/10):**

  | Nguyên nhân | PRD gọi state là | In-app spec hiển thị UI text là | Rủi ro |
  |---|---|---|---|
  | Source tạm không đọc được (mất kết nối provider, đổi máy...) | **Source calendar unavailable** (D9 §2.9, §5.5, AC-S14/S15) | **"Can't update this share"** (§21, AC-I17) | 🔴 AC-S14/AC-S15 dùng đúng cụm "Source calendar unavailable" làm tiêu chí pass/fail bằng chữ, nhưng chính PRD §2.13 (D13, copy guideline) lại liệt kê "Can't update this share" vào danh sách **Prefer** — QC không thể verify literal string của AC-S14/S15 cho tới khi PM chốt 1 cụm duy nhất |
  | Session đăng nhập hết hạn | "Sign in again to continue" (§3.3, §18.3 login spec) | Không nhắc lại trong in-app spec | Cần đảm bảo 2 nguyên nhân này (source lỗi vs session hết hạn) không bị gộp chung 1 UI, vì hành động khắc phục khác nhau (sign in lại vs chờ/stop sharing) |
  | Share hết hạn (expiry) | "Expired" | "Expired" (§33) | Nhất quán |
  | Owner bấm Stop sharing | "Not shared" (sender) / "No longer shared" (receiver) | "No longer shared" (§32) | Nhất quán |
  | Mất mạng tạm thời | Không set state = expired/revoked (§5.2 PRD) | "Couldn't refresh · Showing version from..." (§31) | Nhất quán, phải test không bị lẫn với "No longer shared" |

- **State Transition Testing:**
  - **Sender share state:** `not_shared → (Share calendar) → shared → (source mất) → source_unavailable → (source
    tìm lại được) → shared`; `shared → (Stop sharing) → not_shared → (Share lại) → shared (link MỚI)`;
    `shared → (hết hạn) → expired → (Renew) → shared (link CŨ, không đổi)`. Test riêng đường Renew vs đường
    Stop-rồi-share-lại để verify link identity đúng như D9 mô tả.
  - **Receiver share state (state map §35 in-app spec):** `(chưa add) → preview → Add to Ink → active`;
    `active ⇄ stale` (refresh fail rồi phục hồi, không được rơi vào no_longer_shared); `active → no_longer_shared`
    (sender Stop) hoặc `active → expired` (hết hạn) — 2 nhánh cuối phải hiển thị khác nhau (Decision Table 3).
  - **Account state:** `signed_out → signed_in → session_invalid → signed_out` (không mất share); `signed_in →
    (Delete account) → signed_out`, kèm toàn bộ share do account sở hữu chuyển sang dừng, nhưng app vẫn dùng
    được bình thường (§10.3 login spec).
  - **Owner self-follow reconciliation (case đặc biệt, nhiều biến số nhất):** `signed_out + mở link của chính
    mình + đã lỡ Add to Ink → sign in → Ink detect owner → merge/remove bản receiver trùng → route Manage
    Sharing`. Test cả 2 nhánh: (a) owner CHƯA lỡ add bản receiver trước khi login — không được tạo bản mới; (b)
    owner ĐÃ lỡ add — bản trùng phải biến mất và owner **không được** còn giữ 1 bản lịch read-only của chính
    lịch mình sở hữu (nếu sai, đây là user bị mất quyền edit chính lịch của họ — xem P1 mục 6).
- **Security testing:** thử đoán/tăng dần share ID để truy cập share khác (IDOR); tắt Notes/Locations rồi
  inspect trực tiếp network response của Web View (không qua UI) để verify server không trả field đã ẩn — client-
  side-only filtering sẽ fail test này; verify token Apple/Google không xuất hiện trong analytics event theo
  đúng cấm ở §20 login spec.
- **Exploratory testing** (session-based): double-tap "Create share link" liên tục lúc mạng chậm (§9 in-app cảnh
  báo rõ); bật airplane mode ngay giữa OAuth flow; background app giữa chừng Sign in with Apple rồi quay lại;
  mở deep link share khi app đã đang mở sẵn ở màn khác vs cold-launch từ Messages/Mail; đổi ngôn ngữ hệ thống
  giữa lúc đang ở Share Setup (chưa rõ app có hỗ trợ đủ ngôn ngữ cho khu vực này — xem mục 10); sign out ở máy A
  trong lúc máy B đang mở Manage Sharing cho cùng 1 share, quan sát hành vi máy B.

## 6. Risk-based prioritization

**P1 — mất dữ liệu / lộ riêng tư / xây sai scope / vi phạm cam kết cốt lõi:**
- **Owner self-follow reconciliation sai (D10, §25 in-app spec)** — nếu reconciliation xoá nhầm bản gốc thay vì
  bản receiver trùng, owner mất quyền edit chính lịch của mình, chỉ còn bản read-only. Đây là rủi ro nghiêm
  trọng nhất trong toàn bộ Scope B vì không thể tự khôi phục từ trong Ink.
- **D9 — rebind share sang lịch khác chỉ vì trùng tên (§5.6, §22–23 in-app)** — nếu sai, dữ liệu của một lịch
  hoàn toàn khác có thể bị publish nhầm ra link share cũ, lộ nội dung riêng tư cho người không liên quan.
- **Visibility toggle không được enforce ở server (mục 4, Security)** — Web View là surface public không cần
  đăng nhập; nếu chỉ ẩn Notes/Locations ở client, bất kỳ ai biết cách gọi API trực tiếp đều xem được nội dung
  đã tắt — vi phạm trực tiếp AC-W5 và lời hứa privacy xuyên suốt 4 tài liệu.
- **Sign out / Delete account vô tình dừng share hoặc xoá lịch nguồn ngoài dự kiến (AC-A8, AC-A9, AC-A17)** —
  PRD/login spec nhấn rất mạnh 2 action này phải tách biệt; test phải verify bằng dữ liệu thật (mở lại Apple/
  Google Calendar bên ngoài Ink), không tin UI báo "đã xoá xong".
- **Double-tap tạo nhiều active link cho 1 calendar (D5, §9 in-app)** — vi phạm mô hình 1-calendar-1-link, có
  thể để lại link "mồ côi" không quản lý được từ Manage Sharing.
- **Dư copy "subscriber count" trái với quyết định đã chốt (D12)** — `ink-share-link-inapp-uiux-spec-v1.4.md`
  §11 ("The subscriber number is an anonymous active-subscription count... Use: 12 subscribers") và §36 (liệt
  "subscribers" vào nhóm "Use consistently") **mâu thuẫn trực tiếp với chính §17 cùng file** ("v1 does not
  display subscriber count") và với AC-I12, D12, AC-P2, AC-P4 của PRD. Xếp P1 vì nếu dev implement theo §11/§36
  theo nghĩa đen, sản phẩm sẽ build ra đúng loại UI + hạ tầng tracking mà D12 liệt kê tường minh vào "Not in
  this version" — sai scope ở mức phải làm lại, không phải bug UI nhỏ. Không phải giả thuyết: có thể chỉ ra
  chính xác 2 vị trí văn bản ngược nhau trong cùng 1 file mà không cần chờ build.

**P2:**
- **Decision Table 3 (mục 5) — "Source calendar unavailable" vs "Can't update this share"** — chưa chốt cụm
  nào là copy user-facing thật, chặn khả năng verify literal-string của AC-S14/AC-S15/AC-A11.
- **6/8 tổ hợp visibility toggle chưa có mockup (Decision Table 2)** — chặn viết acceptance case chi tiết cho
  Share Setup preview.
- **Reconciliation lịch nguồn qua rename/reconnect/đổi máy/xoá-tạo-lại-cùng-tên (D9, §5.6)** — đúng logic
  nhưng không đến mức lộ dữ liệu nếu dedupe layer hoạt động đúng; vẫn cần test đầy đủ vì đây là nơi dễ tạo state
  rác (2 dòng "Work" trùng nhau) làm user hoang mang.
- **Cross-device consistency (§16 login spec)** — máy A có lịch nguồn, máy B cùng account nhưng không có lịch
  nguồn đó, phải thấy đúng "Source calendar unavailable"/tương đương, không được để máy B hiện sai trạng thái.
- **Thiếu mockup cho "owner xem Manage Sharing khi chính share đó đã Expired", bao gồm vị trí nút Renew** — cả
  4 tài liệu chỉ mô tả Renew bằng lời (PRD §5.10, in-app §16), không có ASCII mockup nào cho màn hình này dù có
  mockup riêng cho share đang active (§11–12 in-app) và cho receiver-side expired (§33 in-app, §10 webview).
  Theo đúng nguyên tắc "possible missing screen" ở `screenshot-naming.md` §8.7 — không tự vẽ thêm, chỉ ghi nhận.
- **OAuth error/cancel flow (§18 login spec)** — Sign-in cancelled/failed/session expired giữa một action cần
  ownership, đặc biệt khi cancel xảy ra ngay giữa Share Setup (đã nhập visibility/expiry chưa lưu).
- **Destructive copy cho Delete account/Stop sharing phải rõ ràng, đọc được bằng VoiceOver (§19 login spec,
  §37 in-app)** — liên quan trực tiếp phòng user xoá nhầm, không chỉ là polish.

**P3:**
- Copy/UI cosmetic không ảnh hưởng hành vi (icon, khoảng cách, toast "Copied" vs "Share link copied").
- Lỗi đánh máy trong tài liệu (login spec §14: "Sign in to share this calendar this calendar." lặp cụm) —
  không cần case test, chỉ cần báo lại cho người viết PRD.

## 7. Test environment matrix

- **Device:** iPhone + iPad, ở cả 2 trạng thái Ink đã cài / chưa cài (cho Web View handoff, §5 webview spec).
- **Account/Provider:** Apple và Google, mỗi provider test riêng {tài khoản mới toanh · tài khoản đã từng
  Delete account trước đó · 2 thiết bị cùng 1 account}; test rõ case **email trùng nhau giữa Apple và Google
  không được tự merge** (§2.5 login spec, "Account identity continuity").
- **Nguồn lịch:** đủ 8 loại trong Decision Table 1 (mục 5) — cần chuẩn bị sẵn ít nhất 1 calendar mỗi loại
  trước khi test (đặc biệt read-only/subscribed/system-generated vì không tự tạo được trong app).
- **Mạng:** online ổn định · offline · timeout/flaky (test refresh-fail → stale, không lẫn với no-longer-shared).
- **Trạng thái share cần chuẩn bị trước:** share đang active còn hạn lâu · share sắp hết hạn (test BVA) · share
  đã hết hạn · share đã Stop · share có source đã bị unavailable (ngắt kết nối provider) · share do owner tự
  add làm receiver trước khi login (test reconciliation).
- **Web View:** test cả trực tiếp trên trình duyệt mobile Safari (link thật share ra Messages) lẫn desktop,
  theo đúng mobile-first requirement (§17 webview spec).

## 8. Entry criteria

- Cả 4 tài liệu phải thoát trạng thái Draft, hoặc ít nhất các câu hỏi ở mục 10 liên quan tới Entry/Exit phải có
  quyết định bằng văn bản — hiện tại **chưa đạt**.
- Đã chốt 1 cụm copy duy nhất cho trạng thái "source không đọc được" (Decision Table 3, mục 5/6) — nếu chưa
  chốt, AC-S14/AC-S15/AC-A11 chỉ test được ở mức hành vi, không test được ở mức literal string.
- Đã xác nhận bằng văn bản rằng **subscriber count KHÔNG được build ở v1** bất kể §11/§36 của in-app spec nói
  gì (mục 6, P1) — cần một dòng sign-off rõ ràng để tránh QC/dev tranh cãi khi review.
- Backend: share record CRUD + expiry job + publish-on-opportunity trigger đã deploy tới môi trường test,
  tách biệt khỏi production; sandbox OAuth Apple/Google đã cấu hình.
- Đã có ít nhất 1 calendar mẫu cho mỗi dòng trong Decision Table 1 (mục 5) trên tài khoản test.

## 9. Exit criteria

- 0 bug P1 mở, đặc biệt nhóm owner self-follow reconciliation, rebind-theo-tên, và enforce visibility ở server.
- Đã xác nhận server thực sự lọc field ẩn (không chỉ client) bằng bằng chứng network capture, không tin UI.
- Delete account / Sign out đã verify bằng dữ liệu thật ở Apple Calendar/Google Calendar bên ngoài Ink — không
  bị xoá nhầm lịch nguồn.
- Copy cho 5 trạng thái "không cập nhật được" (Decision Table 3) đã thống nhất và khớp với chữ hiển thị thật
  trên build, không còn khác biệt giữa PRD/in-app spec.
- Không có UI/copy nào liên quan tới subscriber count xuất hiện trên build (đối chiếu ngược với P1 mục 6).

## 10. Open

### 10.1 Từ chính 4 tài liệu (nguyên văn/rút gọn từ bảng Open questions của mỗi file)

**Login & Account spec §22:**

| # | Câu hỏi | Khuyến nghị trong doc |
|---|---|---|
| 1 | Settings có nên cho sign-in chủ động trước khi có feature nào yêu cầu không? | Có, nhưng không ép |
| 3 | Account có nên hiện email/tên Apple không? | Chỉ khi Ink chủ động lưu và dùng chúng |
| 6 | Account deletion có nên hiện số share đang active sẽ dừng không? | Nên, nếu có sẵn dữ liệu |

**PRD §9:**

| # | Câu hỏi | Khuyến nghị trong doc |
|---|---|---|
| 2 | Visibility model: toggle từng field hay 1 công tắc gộp? | Ưu tiên field riêng nếu màn hình còn đơn giản |
| 6 | App opportunity nào trigger auto-publish? | Yêu cầu sản phẩm là tự động khi có thể; trigger cụ thể do kỹ thuật quyết |
| 8 | Source calendar bị xoá vĩnh viễn thì sao? | Giữ share ở trạng thái paused, nhắc owner Stop sharing, không tự rebind |
| 9 | Có nên giữ receiver-local color/name sau reconciliation self-share không? | Chỉ giữ khi match rõ ràng, ưu tiên lịch nguồn nếu không chắc |

**Web View spec §22:**

| # | Câu hỏi | Khuyến nghị trong doc |
|---|---|---|
| 6 | Desktop có nên có QR code để mở trên iPhone không? | Có thể cải tiến sau, không bắt buộc v1 |

**In-app spec §40:**

| # | Câu hỏi | Khuyến nghị trong doc |
|---|---|---|
| 3 | Owner có nên rotate/regenerate link công khai không? | Không cần ở v1 |
| 6 | "Can't update this share" có nên hiện mốc thời gian publish cuối không? | Nên, hữu ích |

### 10.2 Phát hiện khi đối chiếu chéo 4 tài liệu (không có trong bảng Open gốc của file nào)

| # | Phát hiện | Vị trí | Ảnh hưởng |
|---|---|---|---|
| 1 | Mâu thuẫn thuật ngữ "Source calendar unavailable" (PRD D9/§5.5/AC-S14/S15, login spec §9/AC-A11) vs "Can't update this share" (in-app §21/AC-I17, và cũng nằm trong chính PRD §2.13 "Prefer") | Xem Decision Table 3, mục 5 | Chặn test literal-string của AC-S14/S15/A11 tới khi chốt 1 cụm |
| 2 | Copy "subscriber count" còn sót trong in-app spec §11 và §36 dù §17/AC-I12/D12/AC-P2/AC-P4 đã loại trừ tường minh; webview spec §18 cũng còn dòng "For counts, use: 12 subscribers" dù §14/AC-W6/AC-W10 cùng loại trừ | in-app spec §11, §36; webview spec §18 | Rủi ro build sai scope — xem P1 mục 6 |
| 3 | PRD §5.4 có placeholder rỗng: "For the metric, use: >" (dòng để trống, không điền giá trị), ngay trước "Avoid: Shared with 12 people" | PRD dòng ~884–889 | Củng cố giả thuyết đây là đoạn văn còn sót lại từ trước quyết định 1.6 (bỏ subscriber counting) — không được vô tình copy nguyên đoạn này vào bản dịch/case test |
| 4 | Không tài liệu nào trong 4 file nêu scope localization/ngôn ngữ cho copy mới (login gate, share states, web view) — khác với các feature khác trong dự án vốn đi qua `QC-matrix-guide-l10n.md` | Toàn bộ 4 file — 0 lần nhắc "language/locale/l10n" | Không tự suy đoán số ngôn ngữ cần test; cần hỏi PM xem copy khu vực này có nằm trong `Localizable.xcstrings` đủ 11 ngôn ngữ như các feature khác không |
| 5 | Thiếu mockup UI cho "owner xem Manage Sharing khi share đã Expired" (kèm nút Renew) | Xem mục 6, P2 | "Possible missing screen" theo đúng quy tắc §8.7 `screenshot-naming.md` |
| 6 | 6/8 tổ hợp toggle visibility (Event names/Locations/Notes) không có mockup minh hoạ | Decision Table 2, mục 5 | Chặn viết acceptance case chi tiết cho Share Setup preview |
| 7 | `screenshot-naming.md` §7 gán `11_share` cho FB-301 (co-edit/lịch cố định) — khác sản phẩm với 4 tài liệu test basis ở đây (share qua link, read-only). Chưa rõ feature này dùng chung flow-no `11_share` hay cần flow-no mới | `screenshot-naming.md` §7, `phase-2-feedback.md` §P3 | Cần xác nhận với người giữ rule trước khi chụp screenshot đầu tiên, để không phải renumber sau này (quy tắc mục 2: "không chèn giữa, không đánh số lại flow cũ") |
| 8 | App Store Privacy Nutrition Label — v1 lần đầu để lộ dữ liệu calendar cá nhân qua link public không cần đăng nhập (Web View); không tài liệu nào trong 4 file nhắc tới việc cập nhật khai báo privacy | Suy luận từ D1/D11 PRD, chưa có trong doc | Cần hỏi PM/dev xem đã đánh giá tác động Privacy Nutrition Label chưa, tương tự lưu ý đã có ở `ai-assistant-tab.md` §9 cho tính năng khác |

**Khuyến nghị chung:** không viết acceptance test case chi tiết (mức kịch bản cụ thể) cho các dòng #1, #2, #6
trong bảng 10.2 tới khi có quyết định bằng văn bản — giữ ở mức test design (mục 5) để triển khai ngay khi câu
hỏi được trả lời, tránh viết case rồi phải bỏ.
