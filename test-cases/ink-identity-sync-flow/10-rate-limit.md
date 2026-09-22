# Test Cases — Rate limit (cross-cutting)

> **Test basis:** [test plan tổng](../../requirements/test-plans/ink-identity-sync-flow/ink-identity-sync-flow-test-plan.md) mục
> 12.6 · trả lời Q17 trong [answers-from-dev.md](../../requirements/test-plans/ink-identity-sync-flow/ink-identity-sync-flow-answers-from-dev.md).
> **Phạm vi:** ngưỡng rate limit cụ thể theo từng endpoint — cross-cutting, không thuộc riêng 1 flow F nào nên
> tách file riêng (ID `TC-RATE-xx`, không dùng `TC-F12-xx` để tránh trùng với flow F12 "Xoá tài khoản").
> **Ngày lập:** 2026-09-20 · **Người lập:** QC

## Môi trường & thiết bị cần

> Suite này không cần thiết bị iOS thật — cần **công cụ gửi request theo lô** (script/Postman Runner/`ab`/
> `hey`) để đạt đủ số lượng request trong 1 khung giờ, việc thao tác tay trên app không thực tế.

| Cần | Bắt buộc | Dùng cho |
|---|---|---|
| Script hoặc Postman Runner gửi được N request liên tiếp trong 1 khung giờ | ✅ | Toàn bộ file |
| 1 IP cố định (hoặc control được IP nguồn) | ✅ | TC-RATE-03, cột "đếm theo IP" |
| 1 `(share, uid)` cố định | ✅ | TC-RATE-01 |
| Khả năng giả lập D1 lỗi (staging) | Chỉ cho TC-RATE-02 | Verify hành vi fail-open |
| Thiết bị iOS thật | Không cần | — |

---

## Bảng ngưỡng đầy đủ

| Endpoint | Ngưỡng | Đếm theo | Hằng số |
|---|---|---|---|
| `POST /api/ink/share` | 20/giờ | IP | `CREATE_LIMIT` |
| `POST /share/:id/sync` | 120/giờ | **(share, uid)** | `SYNC_PUSH_LIMIT_PER_USER` |
| `POST /share/:id/unlock` | 30/giờ/share · 60/giờ/IP | share / IP | `UNLOCK_LIMIT_PER_*` |
| `/ink/help`, `/suggest-event` | 10/phút · 60/giờ | deviceId (đã băm) | `src/ink-help.ts` |
| Lưới trên endpoint AI | 30/phút · 200/giờ | IP | `src/quota.ts` |
| Quota ngày `/suggest-event` | 1000/ngày | deviceId | `src/quota.ts` |

## Suite RL1 — Boundary Value Analysis theo ngưỡng

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-RATE-01 | Q17 | Có 1 share active, 1 uid | Gửi sync đúng 120 request/giờ cho 1 `(share, uid)` | Request thứ 120 thành công, thứ 121 bị rate-limit trong cùng khung giờ | P2 |
| TC-RATE-02 | Q17 | Giả lập D1 lỗi khi tính rate limit | Gửi request bất kỳ vào endpoint có rate limit | Request **vẫn được đi tiếp** (`hitRateLimit` trả `count ?? 1`, fail-open) — đây là hàng rào chi phí, KHÔNG phải điều kiện đúng đắn; không kỳ vọng bị chặn khi D1 hỏng | P3 |
| TC-RATE-03 | Q17 | — | Gửi `POST /api/ink/share` đúng 20 request/giờ từ 1 IP | Request thứ 20 thành công, thứ 21 bị chặn — verify đếm theo **IP**, không phải uid (khác hẳn sync) | P3 |

**Lưu ý khi thiết kế thêm case:** ngưỡng sync (120/giờ) tính theo **từng lịch**, không phải theo tài khoản —
1 uid có 10 lịch có thể đạt 1.200 request/giờ tổng, không có trần tổng nào.

---

**Tổng: 3 case.**
