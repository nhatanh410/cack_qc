# Test Cases — Đồng bộ & Ma trận quyền (F5/F6)

> **Test basis:** [test plan tổng](../../requirements/test-plans/ink-identity-sync-flow-test-plan.md) mục 1.3,
> 10.3, 12.3, 12.4, 14.4, 14.5 · [ink-identity-sync-flow.html](../../requirements/specs/Ink%20Login%20and%20sharing%20calendar%20docs/ink-share-last-update/ink-identity-sync-flow.html) §3 ·
> [login-backup-share-sync.md](../../requirements/specs/login-backup-share-sync.md) §5.
> **Phạm vi:** cơ chế push/pull, last-write-wins, ma trận quyền hiệu lực (`member.role ?? link_role`), giới
> hạn kỹ thuật cụ thể (BVA), và bảng terminal-vs-transient failure chính thức. Xem
> [00-README.md](00-README.md) cho quy ước ID/priority.
> **Ngày lập:** 2026-09-20 · **Người lập:** QC

## Môi trường & thiết bị cần

> Phần lớn Suite này là logic **backend/API** — nhiều case verify đúng và nhanh hơn qua gọi API trực tiếp
> (Postman/curl) hơn là qua UI, dù vẫn nên đối chiếu lại bằng UI thật ở các case P1.

| Cần | Bắt buộc | Dùng cho |
|---|---|---|
| **2 thiết bị/2 uid** (owner + ≥1 member) | ✅ | Suite SY2 (ma trận quyền) — cần owner đổi quyền và member thật thử push |
| Khả năng gọi API trực tiếp (Postman/curl) kèm chỉnh sửa payload thủ công | ✅ | TC-F5-04 (giả lập client tự khai `role`), TC-F6-08 (push không qua Join), toàn bộ Suite SY3 (BVA giới hạn 512KB/500 mutation) |
| Khả năng trì hoãn/đảo thứ tự request tới server | ✅ | TC-F5-01/02 (test LWW theo `updated_at`, không theo thứ tự đến) |
| D1 staging: đọc trực tiếp `calendar_events`/`share_members` | ✅ | Verify `updated_at`, `role`, `revoked_at` thật — không chỉ tin response |
| Khả năng giả lập lỗi D1 giữa vòng lặp ghi | Chỉ cho TC-F5-05 | Case P3, khó tái tạo qua UI thường |
| 1 iPhone (đủ cho case còn lại) | ✅ | Các case không yêu cầu 2 máy |
| iPad / iOS 26 | Không cần | — |

---

## Suite SY1 — Push/pull & last-write-wins (§3)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F5-01 | §3 | 2 client cùng sửa 1 dòng gần như đồng thời | Client A gửi với `updated_at=t1`, client B gửi với `updated_at=t2 > t1`, nhưng B **đến server trước** A (cố ý trì hoãn A) | Dòng có `updated_at` lớn hơn (B) thắng — không theo thứ tự đến server | P2 |
| TC-F5-02 | §3 | Từ TC-F5-01 | Client A (thua) nhận response của chính mutation A | Response trả về đúng dòng **đang thực sự lưu** (bản của B) — A thấy ngay bản thắng, không cần đợi pull riêng | P2 |
| TC-F5-03 | §3 | Có thay đổi mới trên server sau `cursor` hiện tại của client | Client pull với `since=<cursor cũ>` | Chỉ nhận đúng các dòng thay đổi sau cursor; gọi pull nhiều lần liên tiếp không tạo trùng lặp, không bỏ sót | P2 |
| TC-F5-04 | §3 | Payload push có field tự khai `role`/quyền (giả lập client bị sửa đổi) | Gửi push với client tự gắn `role: editor` trong body dù server-side thật là `viewer` | Server phải tự tra `member.role`/`link_role` thật, KHÔNG tin field client tự khai — vẫn trả `read_only`. Kiểm quyền diễn ra **1 lần cho cả request** (trước vòng lặp ghi từng mutation), không phải lại cho từng dòng | P1 |
| TC-F5-05 | login-backup-share-sync.md §5 | Batch push nhiều mutation, không nằm trong 1 transaction | Giả lập D1 lỗi giữa vòng lặp ghi (không liên quan tới quyền) | Các dòng ghi trước đó vẫn được giữ, dòng sau bị mất — client chịu được vì LWW theo `updated_at` (dòng mất tự đồng bộ lại ở lần push kế). Ghi nhận hành vi, không phải bug | P3 |

## Suite SY2 — Ma trận quyền hiệu lực (§3, DT1)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F6-01 | §3, DT1-1 | `link_role=viewer`, `member.role=NULL` | Member push 1 thay đổi | Bị chặn, mã `read_only` | P2 |
| TC-F6-02 | §3, DT1-2 | `link_role=viewer`, `member.role=editor` (owner cấp riêng) | Member push 1 thay đổi | Ghi thành công | P2 |
| TC-F6-03 | §3, DT1-3 | `link_role=editor`, `member.role=viewer` (owner hạ riêng) | Member push 1 thay đổi | Bị chặn `read_only` — override hạ quyền thắng dù link đang `editor` | P2 |
| TC-F6-04 | §3, DT1-4 | `link_role=editor`, nhiều member `role=NULL` đang ghi được | Owner hạ cả link về `viewer` | TẤT CẢ member `role=NULL` mất quyền ghi ngay lần push kế tiếp, không có độ trễ | P2 |
| TC-F6-05 | §3, DT1-5 | Member bất kỳ role, đã bị `revoked_at` | Member push | Bị chặn, mã `revoked` (không phải `read_only`) | P1 |
| TC-F6-06 | §3, DT1-6 | Owner của lịch, bất kỳ `link_role`/`member.role` | Owner push | Luôn ghi được | P2 |
| TC-F6-07 | §3, `.note.warn` | Link đang `editor`; member A join & sync ít nhất 1 lần trong lúc link còn `editor` | Owner hạ link về `viewer` (không đổi riêng gì cho A) sau đó | A push lại: PHẢI bị `read_only` — verify `member.role` của A vẫn là `NULL`, không bị "đóng băng" thành `editor` từ lần sync trước đó | P1 |
| TC-F6-08 | Q2 (answers-from-dev.md) — tech debt xác nhận, chưa fix | Uid X chưa từng Join 1 share | X gọi thẳng API push cho `share_id` hợp lệ (biết được id, không qua Join) | `ensureMembership()` tạo dòng `share_members` cho X (`role=NULL`) TRƯỚC khi kiểm quyền — X vẫn bị 403 `read_only` như bình thường nếu link không phải `editor` (không giành thêm quyền), nhưng dòng member "rác" đã được tạo và còn lại vĩnh viễn trong danh sách của owner | P3 |

## Suite SY3 — Giới hạn cụ thể (BVA, login-backup-share-sync.md §5)

| Constant | Giá trị | Enforced |
|---|---|---|
| `MAX_SYNC_BODY_BYTES` | 512 KB | vượt → 413 |
| `MAX_MUTATIONS_PER_REQUEST` | 500 | vượt → 400 |
| `MAX_PULL_ROWS` | 500/trang | không có vòng lặp phân trang phía client — tự hồi phục qua nhiều lượt foreground |
| `pushBatchSize` (client, 2026-09-20) | 500 | dirty rows vượt mức tách thành nhiều request tuần tự |

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-SYNC2-01 | §5 | Push body đúng ngay dưới/trên 512 KB | Gửi 511 KB (qua) và 513 KB (không qua) | 511 KB → 200; 513 KB → 413 | P2 |
| TC-SYNC2-02 | §5 | Push đúng 500 và 501 mutation trong 1 request | Gửi lần lượt | 500 → 200 (hoặc theo per-mutation LWW); 501 → 400 | P2 |
| TC-SYNC2-03 | §5 | Pull khi server có >500 dòng thay đổi từ cursor | Gọi pull 1 lần | Chỉ nhận đúng 500 dòng đầu (theo `updated_at ASC`); gọi lại với cursor mới (= `updated_at` dòng cuối) để lấy tiếp — verify không trùng/không sót qua nhiều lần gọi | P2 |
| TC-SYNC2-04 | §5, "Client-side batching" | Có >500 dòng `isDirty` cần push | Trigger push | Client tự chia thành nhiều request tuần tự (500/batch); nếu 1 batch fail giữa chừng, **dừng vòng lặp** — các dòng CHƯA gửi vẫn giữ `isDirty` cho lần sau, không gửi sai thứ tự | P2 |
| TC-SYNC2-05 | §5 (biên đã biết trước — không phải bug) | 1 batch đúng 500 mutation nhỏ nhưng tổng > 512 KB (event có field dài) | Push | Vẫn nhận 413 dù đúng ≤500 mutation — giới hạn chưa xử lý (không chunk theo byte size), không phải bug lạ | P3 |
| TC-SYNC2-06 | §5, "Round shape" | Client vừa push xong 1 round | Pull ngay sau đó dùng cursor **trước khi push** (pre-push cursor) | Nhận lại đúng các dòng vừa tự push (idempotent, cùng `updated_at`) — không gây trùng lặp/lỗi hiển thị phía client | P3 |

## Suite SY4 — Terminal vs Transient failure (chính thức hoá)

```
Lỗi từ server          Ý nghĩa                          Hành động client
─────────────────────────────────────────────────────────────────────────
403 revoked        →   Owner hạ quyền member này    →   updateAccessLoss(.revoked)
                                                          UI hiện; TỰ XOÁ khi pull thành công lần sau
404 (bất kỳ code)  →   Share/calendar đã biến mất       →  dòng .joined  → xoá calendar+events+EventKit
                        server-side                         dòng khác    → chỉ clearShare (unlink), giữ calendar
429/500/403                                              →  no-op, giữ isDirty, tự retry lần sync sau
read_only/malformed
```

> Nhánh `404` chi tiết cho member `.joined` (xoá calendar+events+EventKit) nằm ở
> [05-revoke.md](05-revoke.md) TC-F7-05/06 — không lặp lại ở đây.

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-SYNC2-07 | §5 | Member đang bị `updateAccessLoss(.revoked)` hiện trên UI | Owner mở lại quyền (PATCH members set role hợp lệ) | Lần pull thành công **tiếp theo** tự xoá trạng thái lỗi trên UI — không cần user thao tác gì (vd mở lại app) | P2 |

---

**Tổng: 20 case** (SY1: 5 · SY2: 8 · SY3: 6 · SY4: 1).
