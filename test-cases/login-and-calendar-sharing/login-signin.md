# Test Cases — Ink Sign-in / Login Gate

> **Test strategy:** specification-based (Equivalence Partitioning/State Transition/Decision Table dựng từ
> [login-account-deep-dive.md](../../requirements/test-plans/login-and-calendar-sharing/login-account-deep-dive.md) mục 2–3) cho phần luồng
> chính · risk-based cho độ ưu tiên (test plan mục 6) · exploratory chỉ cho phần chưa tài liệu nào vẽ (Suite H).
> **Test basis:** [ink-account-login-management-spec-v1.4.md](../../requirements/specs/login-and-calendar-sharing/ink-account-login-management-spec-v1.4.md) §2–3, §5–6, §18
> **Test plan / test design:** [login-and-calendar-sharing.md](../../requirements/test-plans/login-and-calendar-sharing/login-and-calendar-sharing.md) → [login-account-deep-dive.md](../../requirements/test-plans/login-and-calendar-sharing/login-account-deep-dive.md)
> **Phạm vi:** chỉ nhóm **AC-A1–A6 "Login behavior"** + §18.1–18.3 (error state của chính hành động đăng nhập).
> **Không** gồm Sign out/Delete account (AC-A7–A19) — khác phạm vi "login"; xem `login-account-deep-dive.md`
> TC-A-12 trở đi nếu cần bộ case đó.
> **Priority:** P1 = chặn release (sai ownership/mất context/gate sai chỗ) · P2 = sai hành vi có workaround ·
> P3 = cosmetic/edge nhẹ — mapping y hệt [test plan mục 6](../../requirements/test-plans/login-and-calendar-sharing/login-and-calendar-sharing.md#6-risk-based-prioritization).
> **Quy ước ID:** `TC-<SUITE>-NN`, mỗi suite tự đánh số lại từ 01.
> **⚠️ Tiền điều kiện bắt buộc trước khi chạy BẤT KỲ case nào:** sandbox OAuth Apple + Google đã cấu hình; có
> sẵn account test `QA-Apple-1`, `QA-Google-1`, `QA-Google-2` (email `QA-Google-2` **trùng** `QA-Apple-1`, dùng
> cho Suite H); có ít nhất 1 lịch nguồn user sở hữu (iCloud), chưa từng share, để trigger gate.
> **⚠️ Copy chưa chốt:** 2 sheet trong bộ case này ("Sign in to share…" ở Suite B, CTA "Sign in to manage…" ở
> Suite B/D) có nhiều hơn 1 biến thể literal copy giữa các tài liệu nguồn (chi tiết:
> `login-account-deep-dive.md` mục 1.1–1.2). Case bên dưới verify **hành vi**, không hard-code chuỗi chữ chính
> xác cho 2 chỗ đó — ghi lại đúng copy thật đang chạy trên build vào Actual, không tự chọn 1 bản draft làm chuẩn.
> **Nguyên tắc phủ 2 method (Apple/Google):** v1 chỉ có đúng 2 provider (§2.1 login spec) — case nào hành vi có
> thể lệch theo provider (cơ chế OAuth khác nhau: Apple dùng Face ID/passcode native, Google dùng
> `ASWebAuthenticationSession`/web flow; cơ chế revoke session khác nhau: Apple ID settings vs Google Account
> "Third-party access") thì test **cả 2 provider riêng** (Suite F, Suite G, Suite I). Case nào provider không
> ảnh hưởng hành vi (trước khi chọn provider, logic Try again ở tầng app, base access không cần login) thì chỉ
> cần 1 provider làm đại diện, không nhân đôi vô ích.
> **Ngày lập:** 2026-09-16 · **Người lập:** QC (cập nhật 2026-09-16: bổ sung case Google song song ở Suite F/G/I/J)

---

## Suite A — Không cần đăng nhập cho thao tác thường (AC-A1, AC-A2)

| ID | Mục tiêu | Tiền điều kiện | Test data | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|---|
| TC-BASE-01 | Browse calendar không cần login | Cài mới, chưa từng đăng nhập | — | 1. Mở app lần đầu.<br>2. Xem danh sách Calendars.<br>3. Bật/tắt hiển thị (✓) 1 lịch bất kỳ. | Không có gate/màn login nào chặn; toggle hiển thị hoạt động bình thường | P1 |
| TC-BASE-02 | Mở Manage Calendar không cần login | Như trên | — | 1. Tap vào 1 dòng lịch (không tap ✓). | Vào thẳng Manage Calendar, không có gate login | P1 |
| TC-BASE-03 | Đổi Name/Color/Symbol không cần login (regression cho UI đã có sẵn) | Như trên, đang ở Manage Calendar | — | 1. Đổi Color.<br>2. Đổi Symbol.<br>3. Quay lại danh sách. | Đổi thành công ngay, không bị chặn bởi gate | P1 |
| TC-BASE-04 | Settings → Account hiện đủ 2 provider khi signed out | Chưa đăng nhập | — | 1. Settings → Account. | Hiện `Continue with Apple` và `Continue with Google`; có dòng "You can keep using Ink without signing in." | P2 |

## Suite B — Cổng đăng nhập theo ngữ cảnh (AC-A3, AC-A1a, AC-A6)

| ID | Mục tiêu | Tiền điều kiện | Test data | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|---|
| TC-GATE-01 | Gate chỉ xuất hiện đúng lúc bấm Share calendar | Signed out, ở Manage Calendar của lịch chưa share | — | 1. Quan sát màn Manage Calendar (chưa bấm gì).<br>2. Tap "Share calendar". | Bước 1: không có gate. Bước 2: gate "Sign in to share…" xuất hiện ngay | P1 |
| TC-GATE-02 | Gate Share Calendar đủ 2 nút provider | Từ TC-GATE-01, gate đang hiện | — | 1. Quan sát sheet. | Có `Continue with Apple` và `Continue with Google`, có 1 nút dismiss (ghi lại chữ thật: "Cancel" hay "Not now" — xem cảnh báo đầu file) | P1 |
| TC-GATE-03 | Gate không xuất hiện nếu calendar đã có active share | Signed_in, calendar đã share sẵn | — | 1. Mở Manage Calendar.<br>2. Tap vào thẻ "● Shared". | Vào thẳng Manage Sharing, **không** hiện gate login, không tạo link thứ 2 (liên hệ D5) | P1 |
| TC-GATE-04 | Gate Manage Sharing khi đã từng share nhưng đang signed out | Có local cache "calendar X từng được share", đang signed_out | — | 1. Mở Manage Calendar của X. | Hiện thẻ "Shared — Sign in to manage" + 1 nút Sign in; **không** có nút Copy link/Stop sharing khả dụng trực tiếp | P1 |

## Suite C — Google Calendar connection ≠ Ink account login (AC-A1b)

| ID | Mục tiêu | Tiền điều kiện | Test data | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|---|
| TC-GCAL-01 | Đã connect Google Calendar nhưng chưa Ink-login → vẫn bị gate | Google Calendar đã connect làm nguồn dữ liệu; Ink account đang signed_out | — | 1. Mở lịch iCloud (không phải Google).<br>2. Tap Share calendar. | Gate login vẫn xuất hiện — connection Google Calendar không được tính là đã đăng nhập Ink | P1 |
| TC-GCAL-02 | Ink-login bằng Google nhưng không connect Google Calendar → share được lịch khác | Đã Sign in Ink với `QA-Google-1`; **không** connect Google Calendar làm nguồn | — | 1. Share 1 lịch iCloud. | Share thành công bình thường, không bị yêu cầu connect Google Calendar | P1 |

## Suite D — Đăng nhập thành công → quay lại đúng context (AC-A4, AC-A6)

| ID | Mục tiêu | Tiền điều kiện | Test data | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|---|
| TC-RETURN-01 | Đăng nhập Apple thành công từ gate Share Calendar | Signed_out, gate Share Calendar đang hiện (TC-GATE-01) | `QA-Apple-1` | 1. Tap Continue with Apple.<br>2. Hoàn tất Face ID/passcode. | Trả thẳng về **Share Setup** của đúng calendar vừa chọn — không phải Calendars list, không phải Settings | P1 |
| TC-RETURN-02 | Đăng nhập Google thành công từ gate Share Calendar | Như trên | `QA-Google-1` | 1. Tap Continue with Google.<br>2. Hoàn tất OAuth. | Kết quả giống TC-RETURN-01 | P1 |
| TC-RETURN-03 | Đăng nhập thành công từ gate Manage Sharing | Từ TC-GATE-04, gate đang hiện | `QA-Apple-1` (account đã tạo share X) | 1. Tap Sign in.<br>2. Hoàn tất đăng nhập bằng đúng account chủ share. | Vào **Manage Sharing**, state (link/expiry/visibility) tải từ server, không phải từ cache cũ | P1 |
| TC-RETURN-04 | Đăng nhập chủ động từ Settings, không có action đang chờ | Signed_out, vào Settings → Account trực tiếp (không qua gate) | `QA-Apple-1` | 1. Tap Continue with Apple/Google.<br>2. Hoàn tất đăng nhập. | Ở lại màn Account (giờ hiện Signed in), **không** bị điều hướng sang bất kỳ màn sharing nào | P2 |

## Suite E — Cancel đăng nhập (AC-A5)

| ID | Mục tiêu | Tiền điều kiện | Test data | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|---|
| TC-CANCEL-01 | Cancel gate Share Calendar — không tạo share | Gate Share Calendar đang hiện | — | 1. Bấm nút dismiss (Cancel/Not now).<br>2. Mở lại Manage Calendar của đúng lịch đó. | Quay lại Manage Calendar; thẻ Sharing vẫn là "Share calendar" (not_shared) — verify bằng cách mở lại, không tin animation dismiss | P1 |
| TC-CANCEL-02 | Cancel gate Manage Sharing — không đổi trạng thái share | Gate Manage Sharing đang hiện (TC-GATE-04) | — | 1. Bấm dismiss. | Quay lại Manage Calendar; thẻ vẫn hiện "Shared — Sign in to manage" như cũ, không rơi vào trạng thái lỗi | P2 |

## Suite F — Đăng nhập thất bại / lỗi mạng (§18.1–18.2)

| ID | Mục tiêu | Tiền điều kiện | Test data | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|---|
| TC-FAIL-01 | OAuth bị người dùng huỷ giữa chừng (không phải lỗi hệ thống) | Gate đang hiện | — | 1. Tap Continue with Apple.<br>2. Ở màn hệ thống Apple, bấm Cancel. | Không hiện error banner nào (§18.1); quay lại context trước đó y như TC-CANCEL-01 | P2 |
| TC-FAIL-02 | Lỗi mạng khi đang xử lý đăng nhập | Gate đang hiện | — | 1. Tap Continue with Apple/Google.<br>2. Bật Airplane Mode ngay trong lúc xử lý. | Hiện "Couldn't sign in / Try again in a moment" kèm 2 nút Try again/Cancel | P1 |
| TC-FAIL-03 | Try again sau khi fail | Từ TC-FAIL-02, đã tắt Airplane Mode | `QA-Apple-1` | 1. Bấm Try again. | Thử lại đúng flow ban đầu, đăng nhập thành công → trả về đúng context (như TC-RETURN-01), không bắt đầu lại từ đầu app | P2 |
| TC-FAIL-04 | Cancel sau khi fail | Từ TC-FAIL-02 | — | 1. Bấm Cancel. | Quay lại context trước khi bấm Share calendar; không tạo share, không giữ trạng thái "đang chờ" | P2 |
| TC-FAIL-05 | OAuth bị người dùng huỷ giữa chừng — **Google** (song song TC-FAIL-01, cơ chế khác: `ASWebAuthenticationSession`/Safari view thay vì Face ID/passcode native) | Gate đang hiện | — | 1. Tap Continue with Google.<br>2. Ở màn web OAuth của Google, đóng view (nút ✕/vuốt xuống) trước khi hoàn tất. | Không hiện error banner nào (§18.1); quay lại context trước đó, hành vi giống hệt TC-FAIL-01 dù cơ chế native khác nhau | P2 |
| TC-FAIL-06 | Lỗi mạng khi đang xử lý đăng nhập — **Google** (song song TC-FAIL-02) | Gate đang hiện | — | 1. Tap Continue with Google.<br>2. Bật Airplane Mode ngay trong lúc trang OAuth Google đang load. | Hiện "Couldn't sign in / Try again in a moment" kèm 2 nút Try again/Cancel, không phải màn trắng/treo do web view không load được | P1 |

## Suite G — Session không còn hợp lệ (§3.3, §18.3)

| ID | Mục tiêu | Tiền điều kiện | Test data | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|---|
| TC-SESSION-01 | Session bị revoke — **Apple** (thu hồi qua Settings iOS → Apple ID → Sign in with Apple → Ink → Stop Using Apple ID), phát hiện khi thử owner-only action | Signed_in bằng `QA-Apple-1`, sở hữu 1 share | `QA-Apple-1` | 1. Thu hồi quyền Sign in with Apple cho Ink từ Settings hệ thống.<br>2. Mở Manage Sharing của share đang sở hữu.<br>3. Thử Stop sharing. | Hiện gate "Sign in again" (ghi lại đúng copy thật, đối chiếu 2 biến thể §3.3/§18.3 — không tự chọn bản nào làm chuẩn); **không** ngụ ý đã mất calendar/share | P1 |
| TC-SESSION-02 | Đăng nhập lại thành công sau session invalid | Từ TC-SESSION-01, gate "Sign in again" đang hiện | `QA-Apple-1` | 1. Tap provider, hoàn tất đăng nhập lại. | Quay về đúng action đang thực hiện (Manage Sharing, sẵn sàng bấm lại Stop sharing) — không bị đẩy về Settings | P1 |
| TC-SESSION-03 | Session bị revoke — **Google** (thu hồi qua Google Account → Security → Third-party apps with account access → xoá Ink), song song TC-SESSION-01 nhưng cơ chế/thời điểm phát hiện revoke có thể khác Apple (OAuth refresh token vs Sign-in-with-Apple token) | Signed_in bằng `QA-Google-1`, sở hữu 1 share | `QA-Google-1` | 1. Thu hồi quyền truy cập Ink từ trang Google Account của tài khoản test.<br>2. Mở Manage Sharing của share đang sở hữu.<br>3. Thử Stop sharing. | Hiện đúng gate "Sign in again" như TC-SESSION-01 — không bị trễ (vẫn cho thao tác owner-only bằng token đã hết hạn) và không crash khi refresh token thất bại | P1 |

## Suite H — Định danh account theo provider (§2.5, exploratory — chưa có mockup minh hoạ)

| ID | Mục tiêu | Tiền điều kiện | Test data | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|---|
| TC-IDENT-01 | Apple và Google cùng email không tự merge | Chưa từng đăng nhập bằng cả 2 | `QA-Apple-1`, `QA-Google-2` (email trùng nhau) | 1. Sign in bằng `QA-Apple-1`.<br>2. Sign out.<br>3. Sign in bằng `QA-Google-2`. | 2 account được coi là **khác nhau**; share/dữ liệu account-owned của Apple không xuất hiện dưới account Google | P1 |
| TC-IDENT-02 | Đổi provider trên cùng máy không thừa kế share cũ | `QA-Apple-1` đang sở hữu share cho lịch "Work" | `QA-Apple-1` → `QA-Google-2` | 1. Sign out khỏi `QA-Apple-1`.<br>2. Sign in bằng `QA-Google-2`.<br>3. Mở Manage Calendar "Work". | Thẻ Sharing hiện **"Share calendar"** (not_shared) từ góc nhìn `QA-Google-2` — không tự hiện lại share cũ của `QA-Apple-1` | P1 |

## Suite I — Owner mở link share của chính mình, đăng nhập là bước bắt buộc (AC-A12, liên quan D10 PRD)

| ID | Mục tiêu | Tiền điều kiện | Test data | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|---|
| TC-SELF-01 | Đăng nhập từ preview link của chính mình — **Apple** → route Manage Sharing, không phải Add to Ink | `QA-Apple-1` đang sở hữu share "Work"; mở app ở trạng thái signed_out | `QA-Apple-1` | 1. Mở link share "Work" (gửi từ máy/account khác).<br>2. Web preview → Open in Ink.<br>3. Bấm hành động cần ownership để trigger gate.<br>4. Sign in bằng `QA-Apple-1`. | Sau đăng nhập, vào thẳng **Manage Sharing** — ngoại lệ có chủ đích của AC-A4 (không "quay lại action đang làm" theo nghĩa đen là "mở link"); không hiện nút "Add to Ink" | P1 |
| TC-SELF-02 | Đăng nhập từ preview link của chính mình — **Google** (song song TC-SELF-01, đảm bảo D10 không chỉ đúng cho provider Apple) | `QA-Google-1` đang sở hữu share "Home"; mở app ở trạng thái signed_out | `QA-Google-1` | 1. Mở link share "Home" (gửi từ máy/account khác).<br>2. Web preview → Open in Ink.<br>3. Bấm hành động cần ownership để trigger gate.<br>4. Sign in bằng `QA-Google-1`. | Kết quả giống TC-SELF-01 | P2 |

## Suite J — Accessibility & Analytics (§19, §20)

| ID | Mục tiêu | Tiền điều kiện | Test data | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|---|
| TC-A11Y-01 | VoiceOver đọc được **cả 2 nút** đăng nhập | Bật VoiceOver | — | 1. Duyệt qua gate Share Calendar, focus lần lượt cả 2 nút provider.<br>2. Duyệt qua Settings → Account (signed out), focus lần lượt cả 2 nút provider. | Cả `Continue with Apple` **và** `Continue with Google` đều có accessible label riêng, đọc rõ tên provider (không chỉ đọc icon/"button"); không có trạng thái nào chỉ truyền đạt bằng màu/icon | P2 |
| TC-EVENT-01 | Đúng thứ tự analytics event cho 1 chuỗi login đầy đủ | Có công cụ xem analytics debug | `QA-Apple-1` | 1. Mở gate (Share calendar).<br>2. Cancel.<br>3. Mở gate lại.<br>4. Đăng nhập thành công. | Thứ tự: `share_login_gate_shown` → `account_sign_in_cancelled` → `share_login_gate_shown` (lần 2) → `account_sign_in_started` → `account_sign_in_completed`; không event nào chứa token/nội dung lịch | P3 |

---

## Traceability

| AC / nguồn | Test case |
|---|---|
| AC-A1 | TC-BASE-01 |
| AC-A1a | TC-BASE-04, TC-GATE-02 |
| AC-A1b | TC-GCAL-01, TC-GCAL-02 |
| AC-A2 | TC-BASE-02, TC-BASE-03 |
| AC-A3 | TC-GATE-01 |
| AC-A4 | TC-RETURN-01, TC-RETURN-02, TC-RETURN-03, TC-RETURN-04, TC-SESSION-02 |
| AC-A5 | TC-CANCEL-01, TC-CANCEL-02, TC-FAIL-04 |
| AC-A6 | TC-GATE-03, TC-GATE-04, TC-RETURN-03 |
| §18.1–18.2 | TC-FAIL-01, TC-FAIL-02, TC-FAIL-03, TC-FAIL-04, TC-FAIL-05, TC-FAIL-06 |
| §3.3 / §18.3 | TC-SESSION-01, TC-SESSION-02, TC-SESSION-03 |
| §2.5 (định danh account) | TC-IDENT-01, TC-IDENT-02 |
| AC-A12 / D10 | TC-SELF-01, TC-SELF-02 |
| §19 / §20 | TC-A11Y-01, TC-EVENT-01 |

31 test case, phủ đủ AC-A1–A6 + toàn bộ §18.1–18.3 + 2 case D10/AC-A12 (đăng nhập là bước bắt buộc trong flow
owner-self-share, test cả 2 provider) + 2 case định danh account theo §2.5 vốn chưa có mockup nào minh hoạ (đã
ghi nhận ở `login-account-deep-dive.md` mục 1.7) nhưng suy ra trực tiếp từ product rule nên vẫn viết được case
ngay, không cần chờ PM trả lời thêm. **4 case bổ sung 2026-09-16** (TC-FAIL-05/06, TC-SESSION-03, TC-SELF-02)
để đảm bảo phủ đúng cả 2 method login chính (Apple/Google) ở mọi nhánh hành vi có thể lệch theo provider — xem
nguyên tắc phủ 2 method ở đầu file.
