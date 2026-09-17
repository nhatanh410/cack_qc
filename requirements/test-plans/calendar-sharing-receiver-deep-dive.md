# Test Design (đào sâu) — Scope B / Receiver side

> **Thuộc:** [calendar-sharing-deep-dive.md](calendar-sharing-deep-dive.md) (index — đọc trước để biết 2 side
> tách ra sao và 4 case liên-side không tách được) → [login-and-calendar-sharing.md](login-and-calendar-sharing.md)
> (test plan chung). File song song: [calendar-sharing-owner-deep-dive.md](calendar-sharing-owner-deep-dive.md).
> **Định nghĩa Receiver (theo yêu cầu):** bên nhận lịch share qua link — **không** có quyền sửa event nguồn,
> chỉ tuỳ biến được cách hiển thị cục bộ (tên/màu/symbol) trong Ink của chính họ.
> **Test basis:** [calendar-share-webview-spec-v1.3.md](../specs/Ink%20Login%20and%20sharing%20calendar%20docs/calendar-share-webview-spec-v1.3.md) (toàn bộ) · [calendar-share-live-prd-v1.9.md](../specs/calendar-share-live-prd-v1.9.md) §2.1–2.2, §4.6–4.9, §5.2–5.3, §6.2 · [ink-share-link-inapp-uiux-spec-v1.4.md](../specs/Ink%20Login%20and%20sharing%20calendar%20docs/ink-share-link-inapp-uiux-spec-v1.4.md) §26–35, §39.6
> **Tiền điều kiện chung của mọi suite dưới đây:** cần 1 share **đã tồn tại** do Owner tạo sẵn — dùng
> [calendar-sharing-owner-deep-dive.md](calendar-sharing-owner-deep-dive.md) Suite O2 (TC-OWNER-07…12) làm
> fixture, không dựng lại từ đầu ở đây. Receiver không cần đăng nhập cho bất kỳ case nào trong file này —
> **nhưng đây là suy luận gián tiếp, không phải 1 AC chính thức**: nguồn duy nhất nói thẳng điều này là
> `ink-account-login-management-spec-v1.4.md` §2.2 (dòng 76, "Do not require login to: ... add a received
> shared calendar when anonymous access is allowed") + Open Question #8 (§22, "Not in v1"). Không AC-A/AC-R/
> AC-W/AC-I nào khẳng định tường minh; PRD/in-app/webview spec hoàn toàn im lặng về login ở phía Receiver
> (không phải bằng chứng loại trừ). Xem TC-RECV-00 (mục 4, Suite R0) — case mới thêm để test rõ đúng giả định
> nền tảng này thay vì chỉ ngầm định.
> **Ngày lập:** 2026-09-17 · **Người lập:** QC

---

## 1. Phát hiện riêng phía Receiver (từ `calendar-sharing-deep-dive.md` mục 1, chỉ giữ phần liên quan Receiver)

### 1.0 "Receiver không cần đăng nhập" — chỉ có 1 nguồn mô tả, không phải AC chính thức

Toàn bộ giả định nền tảng của file này ("Receiver không bao giờ cần Ink account để mở link/Add to Ink") chỉ
được nói thẳng **đúng 1 lần**, không phải trong phần acceptance criteria của bất kỳ tài liệu nào:

- `ink-account-login-management-spec-v1.4.md` §2.2 (dòng 76), nằm trong danh sách "Do not require login to:":
  *"add a received shared calendar when anonymous access is allowed"* — có điều kiện ("when anonymous access
  is allowed"), không phải khẳng định tuyệt đối. Vì D11 (PRD) chốt v1 chỉ có 1 access policy là
  `anyone_with_link`, điều kiện này **luôn đúng ở v1** — nhưng câu chữ tự nó đã hé lộ đây có thể đổi khi
  access policy thay đổi (invite-only, xem §5.4 PRD: *"This future model may require the receiver to sign in
  before access can be granted."*).
- Cùng tài liệu, §22 Open Question #8 (dòng 805) tự hỏi đúng câu này và tự trả lời "Not in v1; revisit only for
  invite/access-control phase."

PRD, in-app spec, webview spec — 3 tài liệu còn lại — **không hề nhắc tới sign-in ở bất kỳ đoạn nào mô tả flow
Receiver** (đã grep toàn văn, 0 kết quả). Đây là im lặng, không phải khẳng định loại trừ — về nguyên tắc QC
không nên đối xử "không nhắc tới" như "chắc chắn không cần" nếu không có ít nhất 1 câu xác nhận rõ, nên case
TC-RECV-00 (mục 4, Suite R0) được thêm để test tường minh đúng giả định này trên build thật, thay vì chỉ tin
vào suy luận từ D1/D2/D11.

### 1.1 Cơ chế Renew — phần ảnh hưởng tới Receiver

Hành động Renew là của Owner (xem file Owner mục 1.3), nhưng **hệ quả phía Receiver chưa được định nghĩa**:
sau khi Owner Renew, Receiver có tự động chuyển từ `expired` về `active` mà không cần thao tác gì, hay cần mở
lại app/refresh thủ công? PRD chỉ nói "updates may resume on the same link" — không định nghĩa transition cụ
thể phía Receiver. Xem TC-RECV-04b.

### 1.2 Định dạng "Updated X ago" không nhất quán

Web View dùng dạng đầy đủ: *"Updated 12 minutes ago"* (§4, §9 webview spec). In-app spec (màn Owner) dùng dạng
viết tắt: *"Updated 5 min ago"*. Vì đây là copy Receiver nhìn thấy trực tiếp trên Web View, đáng ghi nhận ở
side này dù mức độ chỉ P3.

### 1.3 CTA "Open Ink" (thiếu chữ "in") ở 2/3 trạng thái lỗi Web View

CTA trang hợp lệ luôn là **"Open in Ink"** (§4, §5.1, §9 webview — khớp nhau tuyệt đối). Nhưng ở **Expired**
(§10) và **Invalid/unavailable** (§12), nút lại ghi **"Open Ink"** (thiếu "in"). Trạng thái Temporary loading
(§13) dùng nút khác ("Retry") nên không tính. Có thể là lỗi đánh máy, nhưng vì đây là literal string khác nhau
thật, Receiver-facing, cần verify đúng bản build đang chạy.

### 1.4 "Owner stopped sharing" (§11 webview) không có CTA nào cả

Khác với Expired/Invalid (đều có nút "Open Ink"), mockup "Owner stopped sharing" **không vẽ nút nào**. Chưa rõ
là chủ đích (không còn gì để làm) hay thiếu sót. Đây là trạng thái duy nhất trong Web View không cho Receiver
lối thoát nào — đáng hỏi lại trước khi coi là đúng.

## 2. State Transition — Receiver

| # | Từ | Sự kiện | Đến | Ghi chú / Guard |
|---|---|---|---|---|
| R1 | (chưa add) | Mở link, xem preview, Add to Ink | `active` | Không tạo record subscriber/member nào (AC-W10, AC-I22) |
| R2 | `active` | Refresh thất bại tạm thời (mạng/API lỗi) | `stale` | Giữ nguyên dữ liệu cache cũ, có nhãn "Couldn't refresh" |
| R3 | `stale` | Refresh thành công trở lại | `active` | Không cần hành động thủ công từ Receiver |
| R4 | `active`/`stale` | Owner Stop sharing | `no_longer_shared` | **Không** tự xoá khỏi Calendars list; Receiver tự Remove |
| R5 | `active`/`stale` | Tới ngày expiry | `expired` | Khác `no_longer_shared` — copy phải phân biệt (test plan chung Decision Table 3) |
| R6 | `expired` | Owner Renew (phía Owner) | ? | **Chưa xác định** — xem mục 1.1, TC-RECV-04b |
| R7 | `no_longer_shared`/`expired` | Receiver bấm "Remove calendar" | (đã xoá khỏi Ink) | Không ảnh hưởng ngược share record phía Owner (đã revoke từ trước) |

## 3. Decision Table — Receiver

### Decision Table 2 (tái sử dụng từ test plan chung, đóng khung lại theo góc nhìn "Receiver thấy gì")

| Event names (Owner set) | Locations | Notes | Receiver thấy gì |
|---|---|---|---|
| ON | ON | OFF | Đúng mockup mặc định — tên + địa điểm, không note |
| OFF | OFF | OFF | Đúng mockup §8.2 webview — chỉ "Busy" theo khung giờ |
| ON | OFF | ON/OFF | **Không có mockup** — cần PM xác nhận layout |
| OFF | ON | ON/OFF | **Không có mockup** — địa điểm bật nhưng tên ẩn, có lộ ngữ cảnh riêng tư gián tiếp không? |
| ON/OFF | ON/OFF | ON | **Không có mockup nào bật Notes** |

→ 6/8 tổ hợp chưa có mockup; chỉ viết case chi tiết cho 2 tổ hợp đã minh hoạ (TC-RECV-01, TC-RECV-02), giữ 1
case exploratory cho phần còn lại (TC-RECV-03).

## 4. Test Case Specification — Receiver (TC-RECV-01…19)

### Suite R0 — Xác nhận Receiver không cần đăng nhập Ink (mục 1.0, giả định nền tảng của cả file)

| ID | AC | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-RECV-00a | §2.2 login spec (dòng 76) | Máy **chưa từng đăng nhập Ink account nào** (signed_out tuyệt đối, không phải chỉ sign out tạm) | 1. Mở link share hợp lệ.<br>2. Web preview → Open in Ink.<br>3. Bấm "Add to Ink". | Toàn bộ flow chạy trót lọt, **không có bất kỳ gate/sheet login nào** xuất hiện ở bất kỳ bước nào; lịch được add thành công vào Ink | P1 |
| TC-RECV-00b | Open Q#8 login spec | Từ TC-RECV-00a, đã add thành công | Mở Manage Calendar của lịch vừa nhận, đổi tên/màu cục bộ | Đổi được bình thường, không bị chặn bởi gate login nào | P1 |
| TC-RECV-00c | §5.4 PRD (Future invite/access extension) — exploratory, không phải bug nếu fail | Từ TC-RECV-00a | Ghi nhận: nếu tương lai đổi sang access policy `invited_people`/`hybrid`, đây chính là case sẽ phải viết lại — không cần test ở v1, chỉ ghi chú để không quên khi access policy đổi | — | P3 |

### Suite R1 — Privacy-aware viewing (Owner đã cấu hình sẵn, Receiver chỉ xem)

| ID | AC | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-RECV-01 | §5.8 PRD, §8.1 webview | Share đã tạo với Event names ON / Locations ON / Notes OFF (mặc định — fixture từ TC-OWNER-08) | Mở Web View bằng link | Preview hiện tên + địa điểm sự kiện, **không** hiện note | P1 |
| TC-RECV-02 | §8.2 webview | Share đã tạo với cả 3 toggle OFF (fixture: Owner tự chỉnh trong Share Setup) | Mở Web View | Preview chỉ hiện khung giờ "Busy", không tên/địa điểm/note | P1 |
| TC-RECV-03 | Decision Table 2 | Share chỉ bật riêng Event names (Locations OFF, Notes OFF) | Mở Web View | **Chưa có mockup xác nhận layout** — ghi nhận hành vi thật; nếu lộ ngược field đã tắt → P1 ngay; nếu chỉ layout chưa polish → P3 | P2 |

### Suite R2 — Web View (trước khi cài Ink)

| ID | AC | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-RECV-04a | AC-W1, AC-W3 | Link share hợp lệ | Mở link trên trình duyệt mobile | Hiện tên lịch, preview an toàn theo đúng visibility đã set, giải thích "read-only, stays updated by owner" | P1 |
| TC-RECV-04b | Mục 1.1, R6 | Share đã `expired`, Owner vừa Renew (fixture: TC-OWNER-20) | Mở lại Web View/app phía Receiver | Ghi lại: tự chuyển về `active` hay cần thao tác gì — exploratory, escalate nếu không rõ ràng | P2 |
| TC-RECV-05 | AC-W5 (Security) | Share đã tắt Notes/Locations | 1. Mở Web View.<br>2. Inspect trực tiếp network response (không qua UI). | UI **và** response API đều không chứa field đã ẩn — nếu response trả full payload dù UI ẩn, đây là **lỗ hổng bảo mật P1** (client-only filtering) | P1 |
| TC-RECV-06 | AC-W7, §7 webview | Ink đã cài, link **không phải** của owner đang mở máy | Bấm "Open in Ink" | Vào Ink, hiện receiver preview (không phải Manage Sharing) | P1 |
| TC-RECV-07 | AC-W8 | Ink **chưa** cài | Mở link | CTA "Get Ink" nổi bật hơn hẳn; có "Already have Ink? Open app" phụ | P2 |
| TC-RECV-08a | AC-W11, AC-W12, AC-W13, mục 1.3–1.4 | 3 link riêng: 1 expired, 1 đã stop, 1 sai/không tồn tại | Mở lần lượt cả 3 | 3 trạng thái **khác nhau rõ rệt về copy**; verify literal nút CTA thật — "Open Ink" hay "Open in Ink" (mục 1.3); riêng "owner stopped sharing" verify có CTA nào không (mục 1.4) | P2 |
| TC-RECV-08b | AC-W14 | Bật Airplane Mode khi mở Web View | Mở link | Hiện "Can't load this calendar / Retry" — **không** bị hiểu nhầm là expired/revoked | P1 |
| TC-RECV-09 | AC-W6, AC-W10 | Link hợp lệ | 1. Mở Web View (không bấm gì thêm).<br>2. Đóng lại, không Add to Ink. | Không tạo bất kỳ subscriber/member record nào (verify qua backend nếu có quyền, không chỉ tin UI) | P2 |

### Suite R3 — Receiver trong Ink (sau khi Add to Ink)

| ID | AC | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-RECV-10 | AC-R2, AC-R3, AC-I23 | Từ Web View, bấm Open in Ink, không phải owner | Bấm "Add to Ink" | Tạo lịch **read-only** trong Ink; không có UI nào cho phép sửa event nguồn; copy dùng "Add to Ink", không phải "Import" | P1 |
| TC-RECV-11 | AC-R4, AC-R5, AC-I25, AC-I26 | Đã add 1 shared calendar | 1. Đổi Name in Ink → "Alex's Schedule", đổi màu.<br>2. Chờ Owner update 1 sự kiện (fixture: TC-OWNER-15), trigger refresh. | Tên/màu tuỳ biến **giữ nguyên** sau khi refresh, không bị ghi đè bởi update từ Owner | P1 |
| TC-RECV-12 | AC-R6, §31 in-app | Đã add, đang `active` | Giả lập refresh fail liên tục (chặn network tới backend share, giữ app foreground) | Hiện "Couldn't refresh · Showing the version from [ngày]" — **không** hiện "No longer shared" | P1 |
| TC-RECV-13 | AC-R7, AC-R8, §32 in-app | Owner Stop sharing (fixture: TC-OWNER-18/19) | Mở lại calendar phía Receiver | Hiện "No longer shared", **giữ nguyên** trong Calendars list tới khi Receiver tự bấm "Remove calendar" | P1 |
| TC-RECV-14 | AC-R9, AC-I27 | Đã add 1 shared calendar | Mở Manage Calendar của lịch đã nhận | **Không có** action "Share calendar" nào — xác nhận không re-share được lịch đã nhận qua Ink | P1 |

### Suite R4 — Không lộ thông tin subscriber phía Receiver (D12, AC-W10)

| ID | AC | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-RECV-15 | AC-P2, AC-W10 | Đã add 1 shared calendar | Rà toàn bộ Manage Calendar (receiver-side) + Web View | Không có bất kỳ messaging nào kiểu "bạn là 1 trong N người theo dõi" hoặc badge ngụ ý danh tính — đối chiếu ngược P1 test plan chung | P2 |

---

## 5. Open — riêng Receiver side

| # | Câu hỏi | Ảnh hưởng |
|---|---|---|
| 0 | Xin 1 câu xác nhận chính thức (dạng AC, không phải bullet mô tả) rằng Receiver không bao giờ cần Ink account ở v1 — hiện chỉ có §2.2 (điều kiện hoá) + Open Q#8 của login spec (mục 1.0) | Không chặn test (đã có TC-RECV-00 test được ngay), nhưng nên chốt thành AC chính thức để tránh sau này bị hiểu nhầm là "chưa quyết định" |
| 1 | Sau khi Owner Renew, Receiver tự chuyển `expired → active` hay cần thao tác gì? (mục 1.1) | Chặn TC-RECV-04b |
| 2 | "Owner stopped sharing" trên Web View có cố tình không có CTA nào không? (mục 1.4) | Chặn 1 phần TC-RECV-08a |
| 3 | Nút "Open Ink" (thiếu "in") ở 2 trạng thái lỗi — lỗi đánh máy hay chủ đích? (mục 1.3) | Chặn 1 phần TC-RECV-08a |
| 4 | Thống nhất định dạng "Updated X ago" giữa Web View và app? (mục 1.2) | P3, không chặn test |

Case cần phối hợp cả Owner + Receiver (không tách được — xem
[calendar-sharing-deep-dive.md](calendar-sharing-deep-dive.md) mục "Suite liên-side"): TC-RECV-04b, TC-RECV-11
(cả 2 cần Owner thực hiện hành động trước — Renew / sửa event nguồn), TC-OWNER-15 (auto-publish, chốt ở file
Owner nhưng verify bằng chính TC-RECV-11).
