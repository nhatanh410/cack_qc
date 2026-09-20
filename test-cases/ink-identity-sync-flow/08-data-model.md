# Test Cases — Mô hình dữ liệu (F11)

> **Test basis:** [test plan tổng](../../requirements/test-plans/ink-identity-sync-flow-test-plan.md) mục 1.6,
> 10.7, 14.0 · [ink-identity-sync-flow.html](../../requirements/specs/Ink%20Login%20and%20sharing%20calendar%20docs/ink-share-last-update/ink-identity-sync-flow.html) §6 ·
> [login-backup-share-sync.md](../../requirements/specs/login-backup-share-sync.md) §1, §3.
> **Phạm vi:** 4 bảng dữ liệu (`calendars`, `calendar_events`, `shares`, `share_members`) và rủi ro rò dữ liệu
> riêng tư khi backup dùng chung bảng với dữ liệu đã share công khai. **TC-F11-03 là case khẩn nhất trong file
> này** — rủi ro không còn là giả thuyết vì Backup sync đã ship (xem
> [07-backup-restore.md](07-backup-restore.md)).
> **Ngày lập:** 2026-09-20 · **Người lập:** QC

## Môi trường & thiết bị cần

> Suite này thuần **backend/dữ liệu** — thiết bị vật lý chỉ cần để tạo fixture (1 lịch `.ink`, 1 share khác),
> phần verify chính nằm ở D1, không phải UI.

| Cần | Bắt buộc | Dùng cho |
|---|---|---|
| 1 iPhone (tạo fixture: 1 lịch `.ink` có backup, 1 share khác không liên quan) | ✅ | Toàn bộ file |
| D1 staging: đọc trực tiếp `calendars`/`calendar_events`/`shares` | ✅ | TC-F11-01/02 (khoá chính), TC-F11-03 (verify không rò dữ liệu) |
| Khả năng gọi API trực tiếp (Postman/curl): `GET /share/:id/page`, `GET /share/:id/sync` của share KHÔNG liên quan | ✅ | TC-F11-03 — case P1 khẩn nhất, phải verify bằng network response thô |
| Tài khoản đã đăng nhập thật + backup đang bật | ✅ | TC-F11-03 cần lịch backup-only có nội dung thật qua `POST /calendars/:id/sync` |
| 2 thiết bị / iPad / iOS 26 | Không cần | — |

---

## Suite DM1 — Khoá dữ liệu & rủi ro rò riêng tư

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F11-01 | §6 | Lịch `.ink` mới tạo, chưa từng share | Kiểm tra D1 | `calendars` row tồn tại hợp lệ dù **không có** `shares` row nào tương ứng — xác nhận "Tồn tại được dù chưa từng chia sẻ" | P3 |
| TC-F11-02 | §6 | 2 lịch khác nhau | Tạo event có cùng giá trị `id` ở 2 `calendar_id` khác nhau | Không xung đột — khoá chính đúng là composite `(id, calendar_id)` | P3 |
| TC-F11-03 | §6 + login-backup-share-sync.md §3 (Backup sync ghi thật vào `calendar_events` cho lịch `shareId == nil`) | Lịch `.ink` **chưa từng share**, đã bật backup, có nội dung thật qua `POST /calendars/:id/sync` | Gọi `GET /share/:id/page`, `GET /share/:id/sync` của **bất kỳ share KHÁC** (không liên quan) | Không được trả về bất kỳ event nào của lịch backup-only này — rủi ro rò dữ liệu riêng tư qua bảng `calendar_events` dùng chung, **sống thật** (không còn giả thuyết) vì Backup sync đã ship | **P1 — khẩn** |
---

**Tổng: 3 case.**

**TC-F11-04 đã merge vào TC-F17-01:** case gốc (verify `calendar_events` không mồ côi sau
`DELETE /share/:id`) trùng hẳn với TC-F17-01 sau khi hành vi đổi (`DELETE /share/:id` nay giữ nguyên
`calendars`/`calendar_events`) — xem [09-account-member-unlock-delete.md](09-account-member-unlock-delete.md).
Câu hỏi "mồ côi hay cascade" gốc giờ áp dụng cho `DELETE /calendars/:id` (F17) thay vì `DELETE /share/:id` —
xem TC-F17-02/03 trong cùng file đó.
