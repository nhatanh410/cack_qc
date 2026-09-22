# Test Cases — Ink Calendar Sharing (Owner + Receiver)

> **Test strategy:** specification-based (Equivalence Partitioning/State Transition/Decision Table dựng từ
> [calendar-sharing-owner-deep-dive.md](../../requirements/test-plans/login-and-calendar-sharing/calendar-sharing-owner-deep-dive.md) và
> [calendar-sharing-receiver-deep-dive.md](../../requirements/test-plans/login-and-calendar-sharing/calendar-sharing-receiver-deep-dive.md))
> cho phần luồng chính · risk-based cho độ ưu tiên (test plan chung mục 6) · exploratory cho phần chưa tài liệu
> nào vẽ (Renew mechanics, tổ hợp visibility chưa có mockup).
> **Test basis:** [calendar-share-live-prd-v1.9.md](../../requirements/specs/login-and-calendar-sharing/calendar-share-live-prd-v1.9.md) ·
> [ink-share-link-inapp-uiux-spec-v1.4.md](../../requirements/specs/login-and-calendar-sharing/ink-share-link-inapp-uiux-spec-v1.4.md) ·
> [calendar-share-webview-spec-v1.3.md](../../requirements/specs/login-and-calendar-sharing/calendar-share-webview-spec-v1.3.md)
> **Test design / deep-dive:** [calendar-sharing-deep-dive.md](../../requirements/test-plans/login-and-calendar-sharing/calendar-sharing-deep-dive.md) (mục lục, nguyên tắc chia side + Suite liên-side) →
> [calendar-sharing-owner-deep-dive.md](../../requirements/test-plans/login-and-calendar-sharing/calendar-sharing-owner-deep-dive.md) ·
> [calendar-sharing-receiver-deep-dive.md](../../requirements/test-plans/login-and-calendar-sharing/calendar-sharing-receiver-deep-dive.md)
> **Sơ đồ trực quan:** [requirements/mermaid-flowchart/](../../requirements/mermaid-flowchart/README.md)
> **Phạm vi:** gộp Owner + Receiver vào **1 file "share"** theo đúng yêu cầu (2 file tổng: login riêng, share
> riêng). Bên trong vẫn giữ nguyên 2 phần tách biệt để test độc lập — **Phần I** dùng ID `TC-OWNER-*`, **Phần
> II** dùng ID `TC-RECV-*`, không đánh số chung để 1 người có thể chạy riêng 1 phần mà không lẫn.
> **Không** gồm login/account (AC-A1–A19, gate, sign out, delete account) — xem
> [login-signin.md](login-signin.md) (file song song, riêng cho login).
> **Priority:** P1 = chặn release (mất quyền owner, lộ riêng tư, sai ownership, mất dữ liệu) · P2 = sai hành vi
> có workaround · P3 = cosmetic/edge nhẹ — mapping y hệt [test plan chung mục 6](../../requirements/test-plans/login-and-calendar-sharing/login-and-calendar-sharing.md#6-risk-based-prioritization).
> **Quy ước ID:** `TC-OWNER-NN` (Phần I) / `TC-RECV-NN` (Phần II), hậu tố chữ (`a`/`b`/`c`) cho các case tách
> nhánh của cùng 1 kịch bản gốc.
> **⚠️ Copy chưa chốt (5 chỗ, không assert literal string tới khi PM quyết định):**
> 1. "Source calendar unavailable" (PRD) vs "Can't update this share" (in-app spec).
> 2. "Refresh now" (PRD) vs "Check for updates" (in-app spec) — nút fallback publish.
> 3. "Sharing unavailable" — 1 câu chung (PRD) hay 4 câu riêng theo lý do (D8)?
> 4. "Open Ink" (thiếu "in") vs "Open in Ink" — 2 trạng thái lỗi Web View.
> 5. Sheet/nút liên quan tới login gate (Share Calendar / Manage Sharing) — xem `login-signin.md`.
> **Ngày lập:** 2026-09-17 · **Người lập:** QC

---

# Phần I — Owner (TC-OWNER-01…27, +19b — 28 case)

> Owner = chủ của collection lịch, người tạo share, full quyền tương tác với event của lịch nguồn (qua app
> lịch gốc, không phải qua Ink). Mọi action ở đây giả định đã đăng nhập — xem `login-signin.md` cho phần gate.

## Suite O1 — Entry & điều kiện được share (D8)

| ID | AC | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-OWNER-01 | AC-I2, PRD-AC-A3 | Signed_in hoặc signed_out | Mở Manage Calendar của 1 lịch bất kỳ | Không có gate login; Sharing section hiển thị đúng theo loại lịch (xem O1-02..06) | P1 |
| TC-OWNER-02 | D8, AC-S4 | Lịch iCloud user sở hữu, chưa share | Mở Manage Calendar | Section SHARING hiện "Share calendar › Create a link…"; lặp lại tương tự local/Google/Outlook owned (hành vi giống hệt, không cần case riêng) | P1 |
| TC-OWNER-03 | D8, §3.4 PRD | Lịch read-only do người khác quản lý | Mở Manage Calendar | "Sharing unavailable" — verify đúng copy đang chạy (câu chung PRD hay câu riêng theo lý do — chưa chốt) | P2 |
| TC-OWNER-04 | D8 | Lịch subscribed/public | Mở Manage Calendar | "Sharing unavailable" — verify **không** dùng câu "managed by another owner" nếu build có (sai ngữ cảnh cho nhóm này) | P2 |
| TC-OWNER-05 | D8 | Lịch system-generated (Holidays) | Mở Manage Calendar | "Sharing unavailable" — cùng lưu ý như O1-04 | P2 |
| TC-OWNER-06 | D8, §3.4/§29 in-app | Lịch đã nhận qua Ink (receiver-side) | Mở Manage Calendar | Hiện section **SOURCE**, không phải Sharing unavailable: "Shared through Ink / Last updated…" + "Remove from Ink"; **không** có action Share | P1 |

## Suite O2 — Share Setup & tạo link (D5, D6)

| ID | AC | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-OWNER-07 | §4.2 PRD, §7 in-app | Lịch owned chưa share | Tap Share calendar | Share Setup hiện preview lịch trước, không yêu cầu nhập gì trước khi thấy preview | P2 |
| TC-OWNER-08 | §5.8, §8 in-app | Từ O2-07 | Quan sát 3 toggle | Mặc định: Event names ON, Locations ON, Notes OFF | P2 |
| TC-OWNER-09 | AC-S12, AC-I8 | Từ O2-07 | Quan sát trước khi bấm Create | Có dòng disclosure "New events will be included automatically while sharing is on." hiển thị **trước** khi tạo link | P2 |
| TC-OWNER-10 | AC-S11, AC-I9 | Từ O2-07 | 1. Quan sát Expiry mặc định.<br>2. Đổi sang 30/365 ngày. | Mặc định 90 ngày, đổi được ngay, **không** bắt buộc đổi mới tạo được link | P2 |
| TC-OWNER-11 | §9 in-app | Đang ở Share Setup, đã điền xong | Bấm "Create share link" nhiều lần liên tiếp thật nhanh | Chỉ tạo **đúng 1** active share; nút disable ngay sau lần bấm đầu hoặc loading chặn tap tiếp | P1 |
| TC-OWNER-12 | D5, AC-S7, AC-I10 | Calendar đã có active share | Tap "Share calendar" lần nữa | Route thẳng Manage Sharing của share hiện có, **không** tạo link thứ 2 | P1 |

## Suite O3 — Quản lý share đang active

| ID | AC | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-OWNER-13 | AC-S5, §3.3 PRD | Vừa tạo share thành công | Mở lại Manage Calendar | Thẻ "● Shared" hiện link rút gọn/Updated X/Expires ngày, có Copy link + Share… | P1 |
| TC-OWNER-14 | AC-S6, AC-I11 | Share đang active | Vào Manage Sharing nhiều lần khác nhau | Link **luôn lấy lại được** y hệt, không đổi | P2 |
| TC-OWNER-15 | AC-S8, D6 | Share active, đổi 1 sự kiện ở lịch nguồn | Không bấm gì thủ công, chờ Ink có "cơ hội" publish tiếp theo | Ghi lại lần publish tự động xảy ra — **cần 1 Receiver thật để verify đã nhận được** (xem Phần II, TC-RECV-11); ở đây Owner chỉ verify KHÔNG cần bấm gì thủ công | P1 |
| TC-OWNER-16 | AC-S8, AC-I14 | Share active | 1. Ghi lại đúng label nút fallback đang hiển thị ("Refresh now" hay "Check for updates").<br>2. Bấm nút đó. | Trigger re-publish thật; **không** assert literal string tới khi PM chốt tên | P2 |
| TC-OWNER-17 | AC-I13, §15 in-app | Share active | Đổi 1 toggle visibility hoặc đổi expiry trong Manage Sharing | Link **không đổi**, chỉ setting cập nhật | P1 |
| TC-OWNER-18 | AC-S9, §18 in-app | Share active | Bấm "Stop sharing" | Sheet xác nhận nêu rõ hậu quả cho người dùng link | P1 |
| TC-OWNER-19 | AC-S10, §19 in-app | Từ O3-18, xác nhận Stop sharing | 1. Quan sát Manage Calendar.<br>2. Share lại cùng calendar. | Bước 1: về "Share calendar" (not_shared). Bước 2: **link mới hoàn toàn**, khác link cũ | P1 |
| TC-OWNER-19b | D4, D5, D9 — **không có AC nào khẳng định tường minh, suy ra từ kiến trúc calendar-first** | 2 calendar KHÁC NHAU đang active share cùng lúc (vd "Work" và "Home", mỗi lịch 1 link riêng theo đúng D5) | 1. Vào Manage Sharing của "Work".<br>2. Bấm Stop sharing, xác nhận.<br>3. Mở Manage Sharing/Manage Calendar của "Home". | "Home" **vẫn** ở trạng thái Shared, link "Home" **không đổi**, không bị stop theo — chỉ "Work" chuyển `not_shared`. Không có action "stop all" nào tồn tại (không có global Sharing overview — Open Q#5 PRD) | P1 |
| TC-OWNER-20 | §5.10 PRD, §16 in-app | Share đã `expired` | 1. Mở Manage Sharing, bấm Renew.<br>2. Quan sát expiry mới được set thế nào. | Link **giữ nguyên**; ghi lại hành vi thật của expiry (exploratory, chưa có kỳ vọng chốt) — escalate nếu bất thường | P2 |
| TC-OWNER-21 | AC-S13, AC-I16 | Share active | Đổi tên lịch nguồn | Share/link **không đổi**; tên hiển thị trong Manage Sharing cập nhật | P2 |

## Suite O4 — Nhận diện nguồn & reconciliation (D9)

| ID | AC | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-OWNER-22 | AC-S14, AC-I17 | Share active | Ngắt kết nối provider chứa lịch nguồn | Owner thấy trạng thái "không đọc được nguồn" (verify copy thật đang chạy); share **không** tự động revoke | P1 |
| TC-OWNER-23 | §5.5 PRD | Từ O4-22 | Kết nối lại provider | Share tự quay lại `shared`, publish resume, **không cần** thao tác thủ công | P1 |
| TC-OWNER-24 | Open Q#8 PRD, §23 in-app | Nguồn bị xoá vĩnh viễn | Mở Manage Sharing | Vẫn "unavailable", có prompt Stop sharing; **không** tự revoke, **không** tự rebind | P1 |
| TC-OWNER-25 | AC-S15, D9 | Share active cho "Work" (nguồn A) | 1. Xoá "Work" (nguồn A).<br>2. Tạo lịch mới tên cũng "Work" (nguồn B, ID khác). | Share **không** tự bind sang nguồn B dù trùng tên — vẫn unavailable hoặc cần Owner xác nhận thủ công | P1 |
| TC-OWNER-26 | AC-S16 | Sign out rồi sign in lại | Xem `login-signin.md` TC-RETURN-03 | Active shares đối chiếu lại với lịch nguồn hiện có trên máy | P1 |

## Suite O5 — Không lộ thông tin subscriber trên màn hình Owner (D12, AC-P2)

| ID | AC | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-OWNER-27 | AC-P1, AC-P2, AC-P4, PRD-AC-A2 | Share active | Rà toàn bộ Manage Sharing + calendar card (không xem Web View — thuộc Phần II) | Chỉ thấy "Anyone with the link"; **không** có số liệu/badge ngụ ý biết danh tính/số người đã add; **không** có Sign out/Delete account trên màn này | P1 |

---

# Phần II — Receiver (TC-RECV-00…15)

> Receiver = bên nhận lịch qua link, không có quyền sửa event nguồn, chỉ tuỳ biến hiển thị cục bộ (tên/màu/
> symbol). Tiền điều kiện chung: cần 1 share đã tồn tại do Owner tạo sẵn — dùng Suite O2 (Phần I) làm fixture.

## Suite R0 — Xác nhận Receiver không cần đăng nhập Ink

> Đây là giả định nền tảng của cả Phần II nhưng chỉ có **1 nguồn tài liệu mô tả** (login spec §2.2 dòng 76 +
> Open Q#8, không phải AC chính thức) — xem `calendar-sharing-receiver-deep-dive.md` mục 1.0.

| ID | AC | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-RECV-00a | §2.2 login spec | Máy **chưa từng đăng nhập Ink account nào** (signed_out tuyệt đối) | 1. Mở link share hợp lệ.<br>2. Web preview → Open in Ink.<br>3. Bấm "Add to Ink". | Toàn bộ flow chạy trót lọt, **không có bất kỳ gate/sheet login nào**; lịch được add thành công | P1 |
| TC-RECV-00b | Open Q#8 login spec | Từ R0-00a, đã add thành công | Mở Manage Calendar của lịch vừa nhận, đổi tên/màu cục bộ | Đổi được bình thường, không bị chặn bởi gate login nào | P1 |
| TC-RECV-00c | §5.4 PRD (Future invite/access extension) | Từ R0-00a | Ghi nhận: đây chính là case sẽ phải viết lại nếu tương lai đổi sang access policy `invited_people`/`hybrid` — không cần test ở v1, chỉ ghi chú | — | P3 |

## Suite R1 — Privacy-aware viewing (Owner đã cấu hình sẵn, Receiver chỉ xem)

| ID | AC | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-RECV-01 | §5.8 PRD, §8.1 webview | Share đã tạo với Event names ON / Locations ON / Notes OFF (fixture: TC-OWNER-08) | Mở Web View bằng link | Preview hiện tên + địa điểm sự kiện, **không** hiện note | P1 |
| TC-RECV-02 | §8.2 webview | Share đã tạo với cả 3 toggle OFF | Mở Web View | Preview chỉ hiện khung giờ "Busy", không tên/địa điểm/note | P1 |
| TC-RECV-03 | Decision Table 2 (test plan chung) | Share chỉ bật riêng Event names (Locations OFF, Notes OFF) | Mở Web View | **Chưa có mockup xác nhận layout** — ghi nhận hành vi thật; nếu lộ ngược field đã tắt → P1 ngay; nếu chỉ layout chưa polish → P3 | P2 |

## Suite R2 — Web View (trước khi cài Ink)

| ID | AC | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-RECV-04a | AC-W1, AC-W3 | Link share hợp lệ | Mở link trên trình duyệt mobile | Hiện tên lịch, preview an toàn theo đúng visibility đã set, giải thích "read-only, stays updated by owner" | P1 |
| TC-RECV-04b | Mục 1.1 receiver deep-dive | Share đã `expired`, Owner vừa Renew (fixture: TC-OWNER-20) | Mở lại Web View/app phía Receiver | Ghi lại: tự chuyển về `active` hay cần thao tác gì — exploratory, escalate nếu không rõ ràng | P2 |
| TC-RECV-05 | AC-W5 (Security) | Share đã tắt Notes/Locations | 1. Mở Web View.<br>2. Inspect trực tiếp network response (không qua UI). | UI **và** response API đều không chứa field đã ẩn — nếu response trả full payload dù UI ẩn → **lỗ hổng bảo mật P1** | P1 |
| TC-RECV-06 | AC-W7, §7 webview | Ink đã cài, link **không phải** của owner đang mở máy | Bấm "Open in Ink" | Vào Ink, hiện receiver preview (không phải Manage Sharing) | P1 |
| TC-RECV-07 | AC-W8 | Ink **chưa** cài | Mở link | CTA "Get Ink" nổi bật hơn hẳn; có "Already have Ink? Open app" phụ | P2 |
| TC-RECV-08a | AC-W11, AC-W12, AC-W13 | 3 link riêng: 1 expired, 1 đã stop, 1 sai/không tồn tại | Mở lần lượt cả 3 | 3 trạng thái **khác nhau rõ rệt về copy**; verify literal nút CTA thật — "Open Ink" hay "Open in Ink"; riêng "owner stopped sharing" verify có CTA nào không | P2 |
| TC-RECV-08b | AC-W14 | Bật Airplane Mode khi mở Web View | Mở link | Hiện "Can't load this calendar / Retry" — **không** bị hiểu nhầm là expired/revoked | P1 |
| TC-RECV-09 | AC-W6, AC-W10 | Link hợp lệ | 1. Mở Web View (không bấm gì thêm).<br>2. Đóng lại, không Add to Ink. | Không tạo bất kỳ subscriber/member record nào (verify qua backend nếu có quyền) | P2 |

## Suite R3 — Receiver trong Ink (sau khi Add to Ink)

| ID | AC | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-RECV-10 | AC-R2, AC-R3, AC-I23 | Từ Web View, bấm Open in Ink, không phải owner | Bấm "Add to Ink" | Tạo lịch **read-only** trong Ink; không có UI nào cho phép sửa event nguồn; copy dùng "Add to Ink", không phải "Import" | P1 |
| TC-RECV-11 | AC-R4, AC-R5, AC-I25, AC-I26 | Đã add 1 shared calendar | 1. Đổi Name in Ink → "Alex's Schedule", đổi màu.<br>2. Chờ Owner update 1 sự kiện (fixture: TC-OWNER-15), trigger refresh. | Tên/màu tuỳ biến **giữ nguyên** sau khi refresh, không bị ghi đè | P1 |
| TC-RECV-12 | AC-R6, §31 in-app | Đã add, đang `active` | Giả lập refresh fail liên tục (chặn network, giữ app foreground) | Hiện "Couldn't refresh · Showing the version from [ngày]" — **không** hiện "No longer shared" | P1 |
| TC-RECV-13 | AC-R7, AC-R8, §32 in-app | Owner Stop sharing (fixture: TC-OWNER-18/19) | Mở lại calendar phía Receiver | Hiện "No longer shared", **giữ nguyên** tới khi Receiver tự bấm "Remove calendar" | P1 |
| TC-RECV-14 | AC-R9, AC-I27 | Đã add 1 shared calendar | Mở Manage Calendar của lịch đã nhận | **Không có** action "Share calendar" nào | P1 |

## Suite R4 — Không lộ thông tin subscriber phía Receiver (D12, AC-W10)

| ID | AC | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-RECV-15 | AC-P2, AC-W10 | Đã add 1 shared calendar | Rà toàn bộ Manage Calendar (receiver-side) + Web View | Không có messaging kiểu "bạn là 1 trong N người theo dõi" hoặc badge ngụ ý danh tính | P2 |

---

## Suite liên-side (tham chiếu — không tính ID mới, cần cả Owner + Receiver cùng lúc)

| Case | Owner | Receiver |
|---|---|---|
| Auto-publish "khi Ink có cơ hội" | TC-OWNER-15 | TC-RECV-11 |
| Renew sau khi expired | TC-OWNER-20 | TC-RECV-04b |
| Owner tự mở link của chính mình (D10) | `login-signin.md` TC-SELF-01/02 | — (Owner đóng cả 2 vai tạm thời) |

## Traceability

| Nguồn | Test case |
|---|---|
| D8 (điều kiện share) | TC-OWNER-02…06 |
| D5/D6 (1 link/calendar, auto-publish) | TC-OWNER-11, TC-OWNER-12, TC-OWNER-15, TC-OWNER-16 |
| D9 (nhận diện nguồn không theo tên) | TC-OWNER-21…25 |
| D10 (owner self-follow) | `login-signin.md` TC-SELF-01/02, `login-account-deep-dive.md` TC-A-20…23 |
| D11/D12 (access policy, không subscriber count) | TC-OWNER-27, TC-RECV-15 |
| AC-S1…S17 | TC-OWNER-01…26 (mapping chi tiết: xem `calendar-sharing-owner-deep-dive.md` mục 4) |
| AC-R1…R11 | TC-RECV-01…14 (mapping chi tiết: xem `calendar-sharing-receiver-deep-dive.md` mục 4) |
| AC-P1…P4 | TC-OWNER-27, TC-RECV-15 |
| AC-W1…W17 | TC-RECV-01…09 |
| AC-I1…I30 | Trải khắp cả 2 phần — xem cột AC ở từng dòng |
| PRD-AC-A1…A4 (§6.3, khác `AC-A#` của login spec) | TC-OWNER-27 (PRD-AC-A2) |

48 test case (28 Owner + 20 Receiver), phủ đủ acceptance criteria của PRD/in-app spec/webview spec cho Scope B,
cộng 3 case case mới (TC-RECV-00a/b/c) test tường minh giả định "Receiver không cần đăng nhập" thay vì chỉ ngầm
định. 3 case liên-side không nhân đôi ID — dùng chung TC-OWNER-15/20 và TC-RECV-04b/11 đã có sẵn.
