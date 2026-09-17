# Test Design (đào sâu) — Scope B / Owner side

> **Thuộc:** [calendar-sharing-deep-dive.md](calendar-sharing-deep-dive.md) (index — đọc trước để biết 2 side
> tách ra sao và 4 case liên-side không tách được) → [login-and-calendar-sharing.md](login-and-calendar-sharing.md)
> (test plan chung). File song song: [calendar-sharing-receiver-deep-dive.md](calendar-sharing-receiver-deep-dive.md).
> **Định nghĩa Owner (theo yêu cầu):** chủ của collection lịch — người tạo share, có **full quyền tương tác**
> với event của lịch nguồn (thêm/sửa/xoá qua app lịch gốc, không phải qua Ink), và là người duy nhất thấy được
> các action quản lý share (Copy link, Stop sharing, Renew, đổi visibility/expiry).
> **Test basis:** [calendar-share-live-prd-v1.9.md](../specs/calendar-share-live-prd-v1.9.md) §2 (D1–D13), §3.1–3.4,
> §4.1–4.5, §4.9–4.12, §5, §6.1/§6.3/§6.4 · [ink-share-link-inapp-uiux-spec-v1.4.md](../specs/Ink%20Login%20and%20sharing%20calendar%20docs/ink-share-link-inapp-uiux-spec-v1.4.md) §4–25, §39.1–39.5
> **Phụ thuộc Scope A:** mọi action ở đây giả định owner đã đăng nhập — xem
> [login-signin.md](../../test-cases/login-signin.md) và [login-account-deep-dive.md](login-account-deep-dive.md)
> cho phần gate/login, không lặp lại ở đây.
> **Ngày lập:** 2026-09-17 · **Người lập:** QC

---

## 1. Phát hiện riêng phía Owner (từ `calendar-sharing-deep-dive.md` mục 1, chỉ giữ phần liên quan Owner)

### 1.1 "Refresh now" (PRD) vs "Check for updates" (in-app spec) — nút chỉ Owner nhìn thấy

PRD gọi nút fallback publish thủ công là **"Refresh now"** (D6 §2.6, Flow C §4.4, AC-S8, §5.1). In-app
spec — nơi duy nhất có mockup Manage Sharing thật — vẽ nút này là **"Check for updates"** (§12, §14, AC-I14).
Đây là nút chỉ Owner nhìn thấy (nằm trong Manage Sharing, không xuất hiện ở phía Receiver) nên thuộc hẳn về
side này. Chưa chốt tên → test hành vi (bấm có publish thật không), không assert literal string.

### 1.2 "Sharing unavailable" — lý do hiển thị chỉ khớp 1/4 nhóm D8

PRD dùng lý do chung: *"You can view this calendar, but you can't share it from Ink."* — khớp cả 4 nhóm không
share được. In-app spec ví dụ 1 lý do cụ thể: *"This calendar is managed by another owner."* — chỉ đúng cho
nhóm "read-only do người khác quản lý", **sai ngữ cảnh** nếu áp cho subscribed/public hoặc system-generated
calendar (không ai "quản lý" lịch Holiday). Đây thuần là màn hình Owner xem (Manage Calendar), không liên quan
Receiver.

### 1.3 Cơ chế Renew chưa rõ (2 điểm)

Không có mockup nào cho "Owner xem Manage Sharing khi share đã Expired". 2 câu hỏi cụ thể:
- Renew có hiện lại bộ chọn expiry (30/90/365) hay tự gia hạn 90 ngày mặc định?
- (Phần ảnh hưởng sang Receiver — xem file Receiver mục 1.1 — nhưng **hành động Renew** tự nó là thao tác của
  Owner nên case đặt ở đây.)

### 1.4 PRD tự đụng ID với login spec — nhắc lại quy ước

`AC-A1`–`AC-A4` của PRD §6.3 (nội dung: IA của Account, share screens không có Sign out/Delete account, dùng
local calendar không cần login, cảnh báo khi xoá account) **khác hoàn toàn** `AC-A1`–`AC-A4` của login spec.
Từ đây dùng `PRD-AC-A#` khi trích PRD §6.3, `AC-A#` (không tiền tố) mặc định là của login spec. Ảnh hưởng
trực tiếp Owner vì phần lớn PRD-AC-A1–A4 nói về màn hình Owner quản lý (Manage Sharing không có Sign out/Delete
account — PRD-AC-A2).

### 1.5 Stop Sharing 1 calendar có ảnh hưởng share của calendar khác không? — không có AC nào khẳng định, chỉ suy ra từ kiến trúc (bổ sung 2026-09-17)

Câu hỏi phát sinh từ thực tế: nếu Owner đang share nhiều **calendar khác nhau** cùng lúc (mỗi calendar 1 link
riêng, đúng D5 — v1 không có "nhiều link cho cùng 1 calendar"), bấm Stop sharing trong Manage Sharing của 1
calendar có dừng luôn share của các calendar khác không?

Suy luận từ kiến trúc: D4 khẳng định **calendar-first**, *"Calendar-first management is the only management
path in this version"*, và không có global Sharing overview ở v1 (Open Q#5 PRD tự trả lời "do not block v1" —
nghĩa là chưa có, không phải "có nhưng ẩn"). Vì mỗi share record gắn 1:1 với 1 calendar cụ thể (D9 — nhận diện
theo ID, không theo tên) và nút Stop sharing luôn nằm trong Manage Sharing của **đúng 1** calendar, hành vi hợp
lý duy nhất là **Stop chỉ ảnh hưởng calendar đang mở**, không có khái niệm "stop all".

Tuy nhiên: **không có AC-S# hay AC-I# nào khẳng định tường minh** hành vi cross-calendar này — toàn bộ AC-S9/
AC-S10/§18-19 in-app chỉ mô tả Stop sharing trong ngữ cảnh 1 calendar duy nhất, không có case nào có 2 calendar
active cùng lúc để verify tính độc lập. Đây là khoảng trống test coverage thật, đã thêm TC-OWNER-19b (mục 4) để
lấp — nếu build thật cho thấy Stop sharing ảnh hưởng chéo sang calendar khác, đây là **bug P1** (mất dữ liệu/
share ngoài ý muốn), không phải hành vi đúng theo bất kỳ tài liệu nào.

## 2. State Transition — Sender/Owner

| # | Từ | Sự kiện | Đến | Ghi chú / Guard |
|---|---|---|---|---|
| T1 | `not_shared` | Tap "Share calendar", qua Share Setup, Create share link | `shared` | Không tạo link nếu double-tap trong lúc loading (§9 in-app) |
| T2 | `shared` | Tap "Share calendar" lần nữa trên cùng calendar | vẫn `shared`, route Manage Sharing | Không tạo link thứ 2 (D5, AC-S7/AC-I10) |
| T3 | `shared` | Source (nguồn) tạm không đọc được | `source_unavailable` | Copy hiển thị chưa chốt — xem test plan chung Decision Table 3 |
| T4 | `source_unavailable` | Nguồn xuất hiện lại, match theo ID | `shared` | Publish tự động resume, không cần thao tác thủ công (§5.5 PRD) |
| T5 | `source_unavailable` | Nguồn xác nhận đã xoá vĩnh viễn | vẫn `source_unavailable` | **Không** tự chuyển `not_shared`; chỉ Owner chủ động Stop sharing mới đổi |
| T6 | `shared` | Tap "Stop sharing", xác nhận | `not_shared`, link **revoke vĩnh viễn** | Share lại sau đó = link MỚI |
| T7 | `shared` | Tới ngày expiry | `expired` | Từ góc nhìn Owner: share vẫn quản lý được, chỉ dừng publish |
| T8 | `expired` | Owner bấm Renew | `shared`, **cùng link cũ** | Chưa rõ expiry set lại thế nào (mục 1.3) — case exploratory, xem TC-OWNER-20 |
| T9 | `shared` (bất kỳ) | Đổi tên lịch nguồn | vẫn `shared`, không đổi link | UI cập nhật tên hiển thị (§22 in-app) |
| T10 | `shared`/`source_unavailable` | Sign out rồi sign in lại (khác account) | `not_shared` từ góc nhìn account mới | Liên hệ Scope A — `login-signin.md` TC-IDENT-02 |

## 3. Decision Table — Owner

### D8 (tái sử dụng từ test plan chung) — Điều kiện share theo loại lịch nguồn

| Loại lịch nguồn | Share qua Ink ở v1 |
|---|---:|
| iCloud/local/Google/Outlook do user sở hữu | Có |
| Read-only do người khác quản lý | Không |
| Subscribed/public | Không |
| System-generated (vd holiday) | Không |
| Đã nhận qua Ink sharing | Không (không re-share) |

### Decision Table 4 — Nút fallback publish: literal string chưa chốt

| Nguồn | Tên nút/action |
|---|---|
| PRD | "Refresh now" |
| In-app spec (có mockup thật) | "Check for updates" |

### Decision Table 5 — Lý do "Sharing unavailable" theo từng nhóm D8

| Nhóm | Lý do PRD (generic) khớp? | Lý do in-app spec (cụ thể) khớp? |
|---|---|---|
| Read-only do người khác quản lý | Khớp | Khớp |
| Subscribed/public | Khớp | **Không khớp** |
| System-generated | Khớp | **Không khớp** |
| Đã nhận qua Ink | Không áp dụng (dùng section Source riêng) | Không áp dụng |

## 4. Test Case Specification — Owner (TC-OWNER-01…27, +19b)

### Suite O1 — Entry & điều kiện được share (D8)

| ID | AC | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-OWNER-01 | AC-I2, PRD-AC-A3 | Signed_in hoặc signed_out | Mở Manage Calendar của 1 lịch bất kỳ | Không có gate login; Sharing section hiển thị đúng theo loại lịch (xem O1-02..06) | P1 |
| TC-OWNER-02 | D8, AC-S4 | Lịch iCloud user sở hữu, chưa share | Mở Manage Calendar | Section SHARING hiện "Share calendar › Create a link…"; lặp lại tương tự local/Google/Outlook owned (hành vi giống hệt, không cần case riêng) | P1 |
| TC-OWNER-03 | D8, §3.4 PRD | Lịch read-only do người khác quản lý | Mở Manage Calendar | "Sharing unavailable" — verify đúng copy đang chạy (Decision Table 5) | P2 |
| TC-OWNER-04 | D8 | Lịch subscribed/public | Mở Manage Calendar | "Sharing unavailable" — verify **không** dùng câu "managed by another owner" nếu build có (sai ngữ cảnh, mục 1.2) | P2 |
| TC-OWNER-05 | D8 | Lịch system-generated (Holidays) | Mở Manage Calendar | "Sharing unavailable" — cùng lưu ý như O1-04 | P2 |
| TC-OWNER-06 | D8, §3.4/§29 in-app | Lịch đã nhận qua Ink (receiver-side) | Mở Manage Calendar | Hiện section **SOURCE**, không phải Sharing unavailable: "Shared through Ink / Last updated…" + "Remove from Ink"; **không** có action Share | P1 |

### Suite O2 — Share Setup & tạo link (D5, D6)

| ID | AC | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-OWNER-07 | §4.2 PRD, §7 in-app | Lịch owned chưa share | Tap Share calendar | Share Setup hiện preview lịch trước, không yêu cầu nhập gì trước khi thấy preview | P2 |
| TC-OWNER-08 | §5.8, §8 in-app | Từ O2-07 | Quan sát 3 toggle | Mặc định: Event names ON, Locations ON, Notes OFF | P2 |
| TC-OWNER-09 | AC-S12, AC-I8 | Từ O2-07 | Quan sát trước khi bấm Create | Có dòng disclosure "New events will be included automatically while sharing is on." hiển thị **trước** khi tạo link | P2 |
| TC-OWNER-10 | AC-S11, AC-I9 | Từ O2-07 | 1. Quan sát Expiry mặc định.<br>2. Đổi sang 30/365 ngày. | Mặc định 90 ngày, đổi được ngay, **không** bắt buộc đổi mới tạo được link | P2 |
| TC-OWNER-11 | §9 in-app | Đang ở Share Setup, đã điền xong | Bấm "Create share link" nhiều lần liên tiếp thật nhanh | Chỉ tạo **đúng 1** active share; nút disable ngay sau lần bấm đầu hoặc loading chặn tap tiếp | P1 |
| TC-OWNER-12 | D5, AC-S7, AC-I10 | Calendar đã có active share | Tap "Share calendar" lần nữa | Route thẳng Manage Sharing của share hiện có, **không** tạo link thứ 2 | P1 |

### Suite O3 — Quản lý share đang active

| ID | AC | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-OWNER-13 | AC-S5, §3.3 PRD | Vừa tạo share thành công | Mở lại Manage Calendar | Thẻ "● Shared" hiện link rút gọn/Updated X/Expires ngày, có Copy link + Share… | P1 |
| TC-OWNER-14 | AC-S6, AC-I11 | Share đang active | Vào Manage Sharing nhiều lần khác nhau | Link **luôn lấy lại được** y hệt, không đổi | P2 |
| TC-OWNER-15 | AC-S8, D6 | Share active, đổi 1 sự kiện ở lịch nguồn | Không bấm gì thủ công, chờ Ink có "cơ hội" publish tiếp theo | Ghi lại lần publish tự động xảy ra — **cần 1 Receiver thật để verify đã nhận được** (xem `calendar-sharing-receiver-deep-dive.md` R-04); ở đây Owner chỉ verify KHÔNG cần bấm gì | P1 |
| TC-OWNER-16 | AC-S8, AC-I14 (Decision Table 4) | Share active | 1. Ghi lại đúng label nút fallback đang hiển thị.<br>2. Bấm nút đó. | Trigger re-publish thật; **không** assert literal string tới khi PM chốt tên | P2 |
| TC-OWNER-17 | AC-I13, §15 in-app | Share active | Đổi 1 toggle visibility hoặc đổi expiry trong Manage Sharing | Link **không đổi**, chỉ setting cập nhật | P1 |
| TC-OWNER-18 | AC-S9, §18 in-app | Share active | Bấm "Stop sharing" | Sheet xác nhận nêu rõ hậu quả cho người dùng link | P1 |
| TC-OWNER-19 | AC-S10, §19 in-app | Từ O3-18, xác nhận Stop sharing | 1. Quan sát Manage Calendar.<br>2. Share lại cùng calendar. | Bước 1: về "Share calendar" (not_shared). Bước 2: **link mới hoàn toàn**, khác link cũ | P1 |
| TC-OWNER-19b | D4, D5, D9 — không có AC nào khẳng định tường minh, suy ra từ kiến trúc calendar-first (mục 1.5, mới thêm) | 2 calendar khác nhau đang active share cùng lúc (vd "Work" và "Home") | 1. Vào Manage Sharing của "Work".<br>2. Bấm Stop sharing, xác nhận.<br>3. Mở Manage Sharing/Manage Calendar của "Home". | "Home" **vẫn** Shared, link không đổi — chỉ "Work" chuyển `not_shared`. Không có action "stop all"; không có global Sharing overview (Open Q#5 PRD) | P1 |
| TC-OWNER-20 | §5.10 PRD, §16 in-app, mục 1.3 | Share đã `expired` | 1. Mở Manage Sharing, bấm Renew.<br>2. Quan sát expiry mới được set thế nào. | Link **giữ nguyên**; ghi lại hành vi thật của expiry (exploratory, chưa có kỳ vọng chốt) — escalate nếu bất thường, không tự kết luận pass/fail | P2 |
| TC-OWNER-21 | AC-S13, AC-I16 | Share active | Đổi tên lịch nguồn | Share/link **không đổi**; tên hiển thị trong Manage Sharing cập nhật | P2 |

### Suite O4 — Nhận diện nguồn & reconciliation (D9)

| ID | AC | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-OWNER-22 | AC-S14, AC-I17 | Share active | Ngắt kết nối provider chứa lịch nguồn | Owner thấy trạng thái "không đọc được nguồn" (verify copy thật — Decision Table 3 test plan chung); share **không** tự động revoke | P1 |
| TC-OWNER-23 | §5.5 PRD | Từ O4-22 | Kết nối lại provider | Share tự quay lại `shared`, publish resume, **không cần** thao tác thủ công | P1 |
| TC-OWNER-24 | Open Q#8 PRD, §23 in-app | Nguồn bị xoá vĩnh viễn | Mở Manage Sharing | Vẫn "unavailable", có prompt Stop sharing; **không** tự revoke, **không** tự rebind | P1 |
| TC-OWNER-25 | AC-S15, D9 | Share active cho "Work" (nguồn A) | 1. Xoá "Work" (nguồn A).<br>2. Tạo lịch mới tên cũng "Work" (nguồn B, ID khác). | Share **không** tự bind sang nguồn B dù trùng tên — vẫn unavailable hoặc cần Owner xác nhận thủ công | P1 |
| TC-OWNER-26 | AC-S16 | Sign out rồi sign in lại | Xem `login-signin.md` TC-RETURN-03, `login-account-deep-dive.md` TC-A-15/16 | Active shares đối chiếu lại với lịch nguồn hiện có, đúng theo T1–T10 (mục 2) | P1 |

### Suite O5 — Không lộ thông tin subscriber trên màn hình Owner (D12, AC-P2)

| ID | AC | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-OWNER-27 | AC-P1, AC-P2, AC-P4, PRD-AC-A2 | Share active | Rà toàn bộ Manage Sharing + calendar card (không xem Web View — thuộc file Receiver) | Chỉ thấy "Anyone with the link"; **không** có số liệu/badge ngụ ý biết danh tính/số người đã add — đối chiếu ngược P1 test plan chung (copy subscriber-count không được xuất hiện); **không** có Sign out/Delete account trên màn này (PRD-AC-A2) | P1 |

---

## 5. Open — riêng Owner side

| # | Câu hỏi | Ảnh hưởng |
|---|---|---|
| 1 | Chốt 1 tên cho nút fallback publish — "Refresh now" hay "Check for updates"? | Chặn TC-OWNER-16 ở mức literal string |
| 2 | Copy "Sharing unavailable" — 1 câu chung hay 4 câu riêng theo D8? | Chặn TC-OWNER-03/04/05 ở mức literal string |
| 3 | Renew có hiện lại bộ chọn expiry không? | Chặn TC-OWNER-20 ở mức kỳ vọng cụ thể |

Case cần phối hợp cả Owner + Receiver (không tách được — xem
[calendar-sharing-deep-dive.md](calendar-sharing-deep-dive.md) mục "Suite liên-side"): TC-OWNER-15 (auto-publish,
cần Receiver verify), toàn bộ flow Owner tự follow link của chính mình (đã có ở Scope A,
`login-account-deep-dive.md` TC-A-20…23).
