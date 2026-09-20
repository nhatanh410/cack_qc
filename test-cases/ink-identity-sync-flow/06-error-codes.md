# Test Cases — Mã lỗi (F10)

> **Test basis:** [test plan tổng](../../requirements/test-plans/ink-identity-sync-flow-test-plan.md) mục 1.5,
> 10.6, 12.4 · [ink-identity-sync-flow.html](../../requirements/specs/Ink%20Login%20and%20sharing%20calendar%20docs/ink-share-last-update/ink-identity-sync-flow.html) §5.
> **Phạm vi:** 4 mã lỗi (`unauthorized`, `read_only`, `revoked`, `app_check_failed`) — mỗi mã dẫn tới 1 hành
> động khác nhau ở client; 2 cặp mã dùng chung HTTP status (401, 403) nên client phải rẽ nhánh theo field
> `code`, không theo status. Xem [00-README.md](00-README.md) cho quy ước ID/priority.
> **Ngày lập:** 2026-09-20 · **Người lập:** QC

## Môi trường & thiết bị cần

> Đây là suite **thuần API** — 1 thiết bị là đủ cho toàn bộ file, quan trọng hơn là công cụ giả lập lỗi.

| Cần | Bắt buộc | Dùng cho |
|---|---|---|
| 1 iPhone | ✅ | Verify hành vi UI (ẩn nút sửa, snackbar, thông báo) tương ứng mỗi mã |
| Khả năng gọi API trực tiếp (Postman/curl) với token/App Check tuỳ chỉnh | ✅ | Toàn bộ file — dựng chính xác từng điều kiện lỗi (thiếu token, role sai, revoked, App Check invalid) |
| App Check: có debug/test token hợp lệ **và** khả năng tạo token **không hợp lệ** có chủ đích | ✅ | TC-F10-04, TC-F10-07, TC-F10-09 |
| Khả năng giả lập mất mạng để quan sát hành vi push im lặng | Nên có | TC-F10-04 (nhánh push nuốt lỗi qua `try?`) |
| 2 thiết bị/2 uid | Không bắt buộc | Đa số case dựng được bằng 1 uid + API calls |
| iPad / iOS 26 | Không cần | — |

---

## Suite EC1 — 4 mã lỗi & thứ tự kiểm

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F10-01 | §5 | Không gửi token / token rỗng | Gọi bất kỳ API sharing/sync nào | 401, mã `unauthorized`; client lấy token mới rồi tự thử lại | P2 |
| TC-F10-02 | §5 | Member `read_only` (theo ma trận quyền) | Thử ghi | 403, mã `read_only`; UI ẩn nút sửa nhưng **vẫn tiếp tục** pull/đọc bình thường, không dừng sync | P2 |
| TC-F10-03 | §5 | Member đã `revoked` | Thử ghi | 403, mã `revoked`; UI mời gỡ lịch khỏi máy, **không** tự động retry | P1 |
| TC-F10-04 | §5 | App Check attestation không hợp lệ (giả lập) | Gọi API bất kỳ thuộc luồng share | 401, mã `app_check_failed`; client retry **đúng 1 lần** với token vừa attest lại. Nếu lần retry đó cũng fail — không có xử lý đặc biệt, 401 đi theo đường lỗi bình thường của từng call site: **push** nuốt lỗi qua `try?` (im lặng, dòng ở lại `isDirty`, thử lại lần sync sau); **join** rơi vào `catch` (hiện snackbar); **createShare** ném lỗi (UI báo lỗi trực tiếp cho user) | P2 |
| TC-F10-05 | §5, `.note.warn` | Member vừa bị revoke, `member.role` trước đó là `editor` | Member push | Mã trả về phải là `revoked`, **không được** là `read_only` dù role lưu trước đó là editor — xác nhận đúng thứ tự kiểm "revoked TRƯỚC" | P1 |
| TC-F10-06 | §5 | So sánh copy/hành vi UI của cả 4 mã | Kích hoạt lần lượt cả 4 mã | Mỗi mã có message/hành động UI **khác biệt rõ ràng**, không có 2 mã nào dùng chung 1 copy/1 hành vi UI | P2 |
| TC-F10-07 | §5 (2 cặp mã dùng chung HTTP status) | Có thể kích hoạt riêng biệt `unauthorized` và `app_check_failed` (cả 2 đều 401) | Kích hoạt lần lượt 2 mã | Client phải rẽ nhánh theo **field `code`** trong response body, không theo status 401 chung chung — 2 hành vi (lấy token thường vs retry-attest-1-lần) phải khác nhau rõ ràng trên thực tế | P2 |
| TC-F10-08 | §5 + §2 (Join) + §3 (revoke) | Uid X đã bị owner revoke khỏi 1 share (`revoked_at` có giá trị), X vẫn còn giữ link | X bấm lại nút **Join** trên trang preview (dùng đúng uid X cũ, KHÔNG đăng nhập ẩn danh lại) | `revoked_at` của dòng `share_members` cũ **không được** bị xoá/reset bởi chính hành động Join — đã xác nhận an toàn: Join kiểm `revoked_at` trước khi upsert, upsert chỉ đổi `display_name`. Giữ làm regression test | P2 |
| TC-F10-09 | Q10 (answers-from-dev.md) — App Check chạy trong router, **trước** khi handler được gọi | Request thiếu cả token hợp lệ **lẫn** App Check attestation hợp lệ, gửi đồng thời | Gọi API bất kỳ thuộc luồng share | Mã trả về phải là `app_check_failed` (401), **không phải** `unauthorized` — vì App Check chặn ở router trước khi request chạm tới bước verify Firebase token | P2 |

---

**Tổng: 9 case.**
