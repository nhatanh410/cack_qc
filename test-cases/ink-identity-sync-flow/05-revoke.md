# Test Cases — Thu hồi (Revoke) & Share bị Stop (F7)

> **Test basis:** [test plan tổng](../../requirements/test-plans/ink-identity-sync-flow-test-plan.md) mục 1.3,
> 10.4, 12.2, 14.3 · [ink-identity-sync-flow.html](../../requirements/specs/Ink%20Login%20and%20sharing%20calendar%20docs/ink-share-last-update/ink-identity-sync-flow.html) §3 ·
> [login-backup-share-sync.md](../../requirements/specs/login-backup-share-sync.md) §5.
> **Phạm vi:** thu hồi 1 member cụ thể (tombstone, không xoá dòng) và hành vi khi share bị Stop hẳn — Suite
> RV2 đã được **viết lại 2026-09-20** theo bảng terminal-failure mới, thay bản 2026-09-18 (xem
> [00-README.md](00-README.md), mục "Case đã loại bỏ").
> **Ngày lập:** 2026-09-20 · **Người lập:** QC

## Môi trường & thiết bị cần

| Cần | Bắt buộc | Dùng cho |
|---|---|---|
| **2 thiết bị** (máy owner + máy member bị revoke/Stop) | ✅ | Toàn bộ file — cần thấy đúng trạng thái thật trên máy member, không chỉ tin action ở máy owner |
| App **Lịch của Apple** trên máy member, đã cấp quyền EventKit | ✅ | TC-F7-05 — verify calendar + events + EventKit projection thật sự bị xoá khỏi máy member |
| Khả năng đăng nhập ẩn danh lại (xoá Keychain hoặc dùng máy/simulator sạch) | ✅ | TC-F7-04 |
| D1 staging: đọc trực tiếp `share_members.revoked_at` | ✅ | TC-F7-01/02 — verify tombstone, không chỉ tin response |
| Khả năng gọi API trực tiếp (Postman/curl) | Nên có | TC-F7-06 (dựng case owner/backup-only nhận 404) |
| iPad / iOS 26 | Không cần | — |

---

## Suite RV1 — Thu hồi 1 member (§3)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F7-01 | §3, `.note.warn` | Member đang có quyền ghi | Owner gọi `DELETE /api/ink/share/:id/members/:uid` | `revoked_at` được set; verify là **tombstone** (row vẫn tồn tại trên D1, không bị xoá hẳn) | P1 |
| TC-F7-02 | §3, `.note.warn` | Từ TC-F7-01, member đã bị revoke | Member (bị revoke) thực hiện 1 lần **push** bất kỳ (kể cả push hợp lệ về mặt dữ liệu) | `revoked_at` của dòng `share_members` cũ **không bị xoá/reset** — request push tiếp theo vẫn phải bị chặn với mã `revoked`, không được "hồi sinh" thành member sạch | P1 |
| TC-F7-03 | §3 (⚠️ xem Open Q23 — chưa chắc đã đóng hẳn) | Member đã bị revoke | Member (bị revoke) thực hiện **pull** | Theo giới hạn đã biết: pull **vẫn thành công** hôm nay (chưa lọc theo quyền/subject ở server) — nếu hành vi này đã đổi (pull đã bị chặn), báo lại vì cần re-test theo tài liệu hệ thống mới nhất | P2 |
| TC-F7-04 | §3 (giới hạn tự khai — "không phải hàng rào kín") | Member đã bị revoke, vẫn còn giữ link cũ | Member đăng nhập ẩn danh lại (uid mới) rồi mở lại đúng link | Vào lại được — đúng như giới hạn đã công bố; cắt thật = đổi link | P2 |

## Suite RV2 — Share bị Stop hẳn (viết lại 2026-09-20 — thay bản 2026-09-18)

> Bản gốc (2026-09-18): member `.joined` nhận 404 nhưng client nuốt lỗi im lặng, lịch đứng yên hiển thị dữ
> liệu cũ vô thời hạn, không có thông báo — coi là bug thật lúc đó. `login-backup-share-sync.md` §5 (bảng
> terminal-failure) cho thấy hành vi này **có thể đã fix** theo hướng tốt hơn — 2 case dưới đây verify đúng
> hành vi MỚI.

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F7-05 | login-backup-share-sync.md §5, bảng terminal-failure | Member `.joined` đang hoạt động bình thường, share active | Owner Stop sharing (`DELETE /share/:id`); member tiếp tục pull/push sau đó | Member nhận 404 → app phải **xoá calendar + events + EventKit projection** hoàn toàn khỏi máy member, KHÔNG đứng yên hiển thị dữ liệu cũ vô thời hạn. Regression test xác nhận fix — không còn phải "báo bug" nếu đúng hành vi này | P1 |
| TC-F7-06 | §5 | Owner (không phải member) hoặc calendar backup-only, có `calendar_id` bị 404 (vd bị xoá) | Device đó pull/push | Chỉ chạy `clearShare` (unlink) — **KHÔNG** xoá calendar/events local, vì đây "hàng của chính mình" (owner hoặc backup), khác hẳn nhánh `.joined` ở TC-F7-05. Verify đúng 2 nhánh không bị lẫn nhau | P2 |

---

**Tổng: 6 case** (RV1: 4 · RV2: 2).

**Ghi chú quan trọng:** dev đang sửa `DELETE /share/:id` để **thôi xoá `calendars`** (đã xác nhận **ship**
2026-09-20 — xem [09-account-member-unlock-delete.md](09-account-member-unlock-delete.md) TC-F17-01). TC-F7-05
ở trên dựa trên hành vi MỚI này; nếu có thay đổi thêm ở cơ chế 404, cần rà lại cả 2 case trong suite RV2.
