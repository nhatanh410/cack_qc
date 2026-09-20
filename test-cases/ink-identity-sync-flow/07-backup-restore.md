# Test Cases — Sao lưu & Khôi phục (F8/F9/F14)

> **Test basis:** [test plan tổng](../../requirements/test-plans/ink-identity-sync-flow-test-plan.md) mục 1.4,
> 10.5, 14.0, 14.1, 14.2 · [ink-identity-sync-flow.html](../../requirements/specs/Ink%20Login%20and%20sharing%20calendar%20docs/ink-share-last-update/ink-identity-sync-flow.html) §4 ·
> [login-backup-share-sync.md](../../requirements/specs/login-backup-share-sync.md) §3, §6.
> **⚠️ Đảo ngược lớn nhất trong toàn bộ bộ test case này:** Backup cho lịch `.ink` chưa share **đã ship đầy
> đủ** 2026-09-20 (PR #283–286 iOS + Worker backup-endpoints). Suite BK1 dưới đây dùng bản **đã viết lại**,
> KHÔNG dùng bản gốc "mất vĩnh viễn" — xem [00-README.md](00-README.md), mục "Case đã loại bỏ".
> **Ngày lập:** 2026-09-20 · **Người lập:** QC

## Môi trường & thiết bị cần

| Cần | Bắt buộc | Dùng cho |
|---|---|---|
| Khả năng **gỡ app hẳn + cài lại** (không phải chỉ tắt/mở) | ✅ | Toàn bộ Suite BK1 — đây là điều kiện tiên quyết để test đúng "mất máy" |
| **2 thiết bị cùng 1 tài khoản** (máy A đã xoá lịch backup, máy B offline có mutation dirty) | ✅ | TC-F14-04 — case P1 chống hồi sinh lịch đã tombstone |
| Tài khoản **Apple** thật, đã đăng nhập thật (không phải ẩn danh) | ✅ | TC-F8-03/03c, TC-F14-01..03 |
| Tài khoản **Google** thật | Có thể dùng thay Apple | Tương đương TC-F8-03 |
| Máy **chỉ có uid ẩn danh** (chưa từng link Apple/Google) | ✅ | TC-F8-03b, TC-F14-05 — trường hợp duy nhất backup không cứu được |
| Khả năng bật/tắt Settings → Backup toggle | ✅ | TC-F8-03c, TC-F14-01/02 |
| Khả năng giả lập mất mạng (Airplane Mode) trên 1 trong 2 máy | ✅ | TC-F14-04 |
| Lịch `.apple`/`.google`/`.outlook` có sẵn sự kiện | ✅ | TC-F8-01/02 |
| D1 staging: đọc trực tiếp `calendars`/`calendar_events` (kiểm tra server row còn/mất) | ✅ | TC-F14-03/04 — không được chỉ tin local, phải verify server thật |
| iPad / iOS 26 | Không cần | — |

---

## Suite BK1 — Sao lưu theo loại nguồn (§4, viết lại theo Backup sync mới)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F8-01 | §4 | Lịch loại `.apple`, có sự kiện | Gỡ app, cài lại, đăng nhập lại đúng uid | Lịch xuất hiện lại (qua iCloud, không qua Ink) — verify server chỉ từng giữ con trỏ (tên/màu), không phải nội dung | P2 |
| TC-F8-02 | §4 | Lịch loại `.google`/`.outlook` | Tương tự TC-F8-01, đăng nhập lại provider | Lịch khôi phục qua đăng nhập lại provider, không qua dữ liệu Ink | P2 |
| TC-F8-03 | login-backup-share-sync.md §6 (viết lại — đảo ngược hoàn toàn so với bản gốc) | Lịch `.ink` chưa share, có sự kiện, **đã đăng nhập thật** (Apple/Google), backup toggle mặc định BẬT | Gỡ app, cài lại, đăng nhập lại đúng tài khoản | Dữ liệu **KHÔNG mất** — `SharedCalendarReconcile` phát hiện qua `GET /calendars`, tạo lại calendar + pull đầy đủ. Regression test cho tính năng mới ship, không còn là case "xác nhận mất vĩnh viễn" | P1 |
| TC-F8-03b | login-backup-share-sync.md §3 | Lịch `.ink` chưa share, **chưa từng đăng nhập thật** (chỉ có uid ẩn danh) | Gỡ app, cài lại | Dữ liệu **mất vĩnh viễn** — trường hợp DUY NHẤT còn đúng như mô tả kiến trúc cũ, giờ có lý do rõ ràng và chủ đích (anonymous không có "thiết bị khác" để khôi phục về), không còn là gap âm thầm | P1 |
| TC-F8-03c | login-backup-share-sync.md §6 (toggle) | Lịch `.ink` chưa share, đã đăng nhập thật, **tắt Settings → Backup** trước khi gỡ app | Gỡ app, cài lại | Dữ liệu mất — đúng thiết kế: tắt toggle dừng cả 3 call site ghi, tự nhận hậu quả | P2 |
| TC-F8-04 | §4 | Lịch loại `.joined` (đã nhận qua share, share vẫn active) | Gỡ app, cài lại, đăng nhập lại | Lịch xuất hiện lại vì chỉ cần tư cách thành viên còn sống — dữ liệu pull lại từ share | P2 |

## Suite BK2 — Khôi phục sau cài lại (§4)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F9-01 | §4 | Vừa cài lại, có uid cũ (Keychain) | Mở app, quan sát network call đầu tiên | `GET /api/ink/calendars` được gọi — endpoint duy nhất xác định "tôi với tới được gì" (nay bao gồm cả lịch owned backup + shared, theo `login-backup-share-sync.md` §4) | P2 |
| TC-F9-02 | §4 | Có cả lịch owned lẫn lịch joined | Gọi `GET /api/ink/calendars` | Trả về đầy đủ cả 2 loại, mỗi membership kèm quyền **đang sống hiện tại** (không phải quyền cache cũ) | P2 |
| TC-F9-03 | §4, `.note` | Member đang có quyền edit; owner hạ quyền member này xuống `viewer` trong lúc máy member KHÔNG chạy/không sync | Member mở lại app (trigger `GET /api/ink/calendars` lúc khởi động) | Quyền được chốt lại **trước khi** member thao tác — member không còn thấy được mở form sửa rồi mới nhận 403; form sửa phải bị ẩn/khoá ngay từ đầu | P2 |
| TC-F9-04 | §4 | App đang chạy bình thường (không phải sau cài lại) | Cold start app | Xác nhận `GET /api/ink/calendars` cũng được gọi ở mọi lần khởi động lạnh, không chỉ riêng sau khi cài lại — để quyền luôn được làm mới | P3 |
| TC-F9-06 | §4 (suy luận từ chức năng endpoint restore) | 2 uid khác nhau, mỗi uid có ít nhất 1 lịch owned và/hoặc joined riêng biệt | Gọi `GET /api/ink/calendars` bằng token của uid A | Response chỉ chứa đúng lịch owned/joined của uid A — không lẫn, không lộ bất kỳ dữ liệu/tên lịch nào của uid B (access-control/IDOR check cho endpoint restore) | P1 |

## Suite BK3 — Backup sync cho `.ink` chưa share (F14, mới ship 2026-09-20)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F14-01 | §6, "Toggle" | Backup đang BẬT, có lịch `.ink` chưa share | Tắt Settings → Backup | Server row **không bị xoá**; 3 call site (foreground loop, post-edit hook, reconcile) dừng chạy | P2 |
| TC-F14-02 | §6 | Từ TC-F14-01 | Bật lại Backup | Resume từ đúng `syncCursor` cũ — **không** full re-sync lại từ đầu | P2 |
| TC-F14-03 | §6 "Delete-gate fix (Phase 2)" — regression khoá bug đã fix | Lịch `.ink` chưa share, đã đăng nhập thật, backup đã từng chạy (có server row) | `confirmDelete()` xoá lịch (không share, `isOwnCalendar && signedIn`) | Phải gọi `DELETE /calendars/:id` — verify server row **cũng biến mất** (KHÔNG chỉ xoá local). Trước fix Phase 2: xoá 100% local, server row "sống nhăn" mãi — đây chính là bug ma đã fix, khoá lại bằng regression test | **P1** |
| TC-F14-04 | §6 "Soft-delete (2026-09-20)" — anti-resurrection | Lịch backup bị xoá ở máy A (tombstoned); máy B (cùng account) đang **offline**, có sẵn 1 mutation dirty cho đúng lịch đó | Máy B có mạng lại, tự động push | Push phải nhận `calendar_deleted` (404), **không** hồi sinh lịch đã tombstone | **P1** |
| TC-F14-05 | §3 (real-sign-in required) | Chỉ có uid ẩn danh (chưa link Apple/Google) | Verify cả 3 call site backup KHÔNG BAO GIỜ chạy | Không có request nào tới `/calendars/:id/sync` được kích hoạt cho tài khoản ẩn danh — cross-ref TC-F8-03b | P2 |

---

**Tổng: 16 case** (BK1: 6 · BK2: 5 · BK3: 5).

**Câu hỏi mở liên quan** — xem [open-questions-for-dev.md](../../requirements/test-plans/ink-identity-sync-flow-open-questions-for-dev.md):
đã đóng Q11/Q12 (2026-09-18: chưa có cảnh báo UI nào cho rủi ro mất dữ liệu `.ink` khi chưa đăng nhập thật;
0% backup trước khi ship — nay đã ship, TC-F8-03b là trường hợp còn lại đúng nghĩa).
