# Test Cases — Xoá tài khoản, Quản lý member, Unlock, Xoá calendar (F12/F13/F15/F16/F17)

> **Test basis:** [test plan tổng](../../requirements/test-plans/ink-identity-sync-flow/ink-identity-sync-flow-test-plan.md) mục 10.8,
> 12.6, 12.7, 14.1, 14.2 · [login-backup-share-sync.md](../../requirements/specs/ink-identity-sync-flow/login-backup-share-sync.md) §2, §4.
> **Phạm vi:** 4 flow **ngoài phạm vi tài liệu kiến trúc gốc** `ink-identity-sync-flow.html` §0–§7 — chỉ lộ ra
> qua câu trả lời của dev (2026-09-18) và tài liệu hệ thống mới nhất (2026-09-20). Gồm: xoá tài khoản
> (`DELETE /account`), quản lý member qua route đặt tên rõ, unlock link có mật khẩu, và 2 loại xoá đã tách
> bạch (`DELETE /share/:id` vs `DELETE /calendars/:id`). Xem [00-README.md](00-README.md) cho quy ước.
> **Ngày lập:** 2026-09-20 · **Người lập:** QC

## Môi trường & thiết bị cần

> Cả 4 route ở đây **chưa có UI chính thức** (§7 tài liệu kiến trúc gốc xác nhận UI quản lý member chưa
> tồn tại) — bắt buộc test qua API trực tiếp cho phần lớn case, chỉ đối chiếu UI ở TC-F2-21 (Delete account).

| Cần | Bắt buộc | Dùng cho |
|---|---|---|
| Khả năng gọi API trực tiếp (Postman/curl): `PATCH`/`GET /share/:id/members/:uid`, `GET /share/:id/mine`, `POST /share/:id/unlock`, `DELETE /calendars/:id`, `DELETE /account` | ✅ | Toàn bộ file — không có UI cho các route này |
| **2 uid khác nhau** (owner A + member/uid B ở share của người khác) | ✅ | TC-F12-04/05 (Suite AC1) |
| D1 staging: đọc trực tiếp `share_members`/`calendars`/`calendar_events`/`shares` | ✅ | Verify không mồ côi (AC1), verify tombstone + hard-delete đúng bảng (AC4) |
| 1 iPhone (đối chiếu UI Delete account) | ✅ | TC-F2-21 ở [01-identity-login.md](01-identity-login.md), điểm vào UI thật của TC-F12-04 |
| Khả năng gửi nhiều request nhanh (script/Postman Runner) | ✅ | TC-F16-02 (rate limit 30/giờ/share · 60/giờ/IP) |
| Cả share **shared** và share **backup-only** | ✅ | TC-F17-02/03 — verify hành vi giống nhau ở cả 2 loại |
| iPad / iOS 26 | Không cần | — |

---

## Suite AC1 — Xoá tài khoản (F12)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F12-04 | login-backup-share-sync.md §2 | Uid sở hữu ít nhất 1 calendar có share active, có `calendar_events` | Gọi `DELETE /api/ink/account` | Dừng toàn bộ share uid này sở hữu; xoá uid khỏi mọi `share_members` row (cả 2 chiều: owner và joined-as-member) — verify D1 trực tiếp, không chỉ tin response | P1 |
| TC-F12-05 | login-backup-share-sync.md §2 (đã xác nhận 2026-09-20) | Uid A vừa gọi `DELETE /api/ink/account`; A trước đó có Join (là member, không phải owner) 1 share của uid B khác | Kiểm tra `share_members` của share thuộc uid B sau khi A xoá tài khoản | Dòng `share_members` của A trong share của B **bị dọn** — không mồ côi, xác nhận trực tiếp bởi tài liệu hệ thống | P2 |

## Suite AC2 — Quản lý member qua route đặt tên rõ (F15)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F15-01 | §4 | Owner, link đang `viewer` | `PATCH /share/:id/members/:uid` set `role=editor` cho 1 member | Member đó ghi được — khớp đúng [04-sync-permission.md](04-sync-permission.md) TC-F6-02 (đã test qua UI ở [02-share-creation.md](02-share-creation.md) TC-F3-42), lần này qua route đặt tên chính thức | P2 |
| TC-F15-02 | §4 | — | `GET /share/:id/members` | Trả đúng danh sách member hiện có, kèm role hiệu lực | P3 |
| TC-F15-03 | §4 | Owner mở đúng link của chính mình | `GET /share/:id/mine` | Trả `true`; với link KHÔNG phải của mình → `false` | P2 |

## Suite AC3 — Unlock link có mật khẩu (F13/F16)

> ⚠️ Cách đặt mật khẩu cho 1 share chưa được xác nhận đầy đủ — xem Open Q21 trong
> [open-questions-for-dev.md](../../requirements/test-plans/ink-identity-sync-flow/ink-identity-sync-flow-open-questions-for-dev.md).
> TC-F16-01/03 phụ thuộc câu trả lời này.

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F16-01 | §4 (⚠️ xem Open Q21) | Share có đặt mật khẩu (cách đặt — chưa rõ) | `POST /share/:id/unlock` với mật khẩu đúng | Nhận unlock token | P2 |
| TC-F16-02 | §4 | — | `POST /share/:id/unlock` với mật khẩu sai | Từ chối; verify có bị rate-limit đúng 30/giờ/share · 60/giờ/IP (xem [10-rate-limit.md](10-rate-limit.md)) | P2 |
| TC-F16-03 | §4 (⚠️ xem Open Q21) | Share **không** đặt mật khẩu | Gọi `/unlock` | **Chưa biết hành vi** — lỗi rõ ràng hay no-op? Không assert cụ thể tới khi có câu trả lời | P3 |
| TC-F13-01 | Q17 (answers-from-dev.md) — chỉ biết rate limit, chưa biết chức năng đầy đủ | Có 1 `share_id` hợp lệ | Gọi `POST /share/:id/unlock` đúng 30 lần/giờ cho 1 share | Request thứ 30 thành công (theo nghĩa "không bị rate-limit"), thứ 31 bị chặn bởi rate limit | P3 |
| TC-F13-02 | Q17 | — | Gọi `POST /share/:id/unlock` 60 lần/giờ từ cùng 1 IP (khác share) | Request thứ 61 bị chặn theo ngưỡng IP, độc lập với ngưỡng theo share | P3 |

## Suite AC4 — Xoá calendar hẳn vs Dừng share (F17)

> `DELETE /share/:id` (dừng share) và `DELETE /calendars/:id` (xoá hẳn lịch) đã được **tách bạch** — thay thế
> hoàn toàn case gốc `TC-F9-05` (2026-09-18), vốn giả định `DELETE /share/:id` xoá luôn `calendars`.

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F17-01 | §4 — xác nhận đã ship | Owner có 1 share đang active, có `calendar_events` nội dung thật | `DELETE /share/:id` | `shares` + `share_members` bị xoá; `calendars`/`calendar_events` **GIỮ NGUYÊN** — verify D1 trực tiếp | P1 |
| TC-F17-02 | §4 | Owner có 1 calendar (bất kỳ loại: shared hoặc backup-only) | `DELETE /calendars/:id` | Hard-delete `share_members`/`calendar_events`/`shares` liên quan; `calendars` row **tombstone** (`deleted_at`), không hard-delete | P1 |
| TC-F17-03 | §4 + §5 (terminal-failure) | Từ TC-F17-02, calendar đã tombstone | Bất kỳ device nào push/pull tới `calendar_id` đó (share-sync lẫn backup-sync) | 404 `calendar_deleted` ở **cả 2 route** (`/calendars/:id/sync` và `/share/:id/sync`) — không được resurrect | P1 |

---

**Tổng: 13 case** (AC1: 2 · AC2: 3 · AC3: 5 · AC4: 3).
