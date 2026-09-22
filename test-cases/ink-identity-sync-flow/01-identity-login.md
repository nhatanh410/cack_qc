# Test Cases — Định danh & Đăng nhập ngầm (F1/F2)

> **Test basis:** [test plan tổng](../../requirements/test-plans/ink-identity-sync-flow/ink-identity-sync-flow-test-plan.md) mục
> 1.1, 10.1, 13.6 · [ink-identity-sync-flow.html](../../requirements/specs/ink-identity-sync-flow/ink-share-last-update/ink-identity-sync-flow.html) §0–§1 ·
> [qc-sharing-account-pro.md](../../requirements/test-plans/ink-identity-sync-flow/qc-sharing-account-pro.md) §7 (UI Account).
> **Phạm vi:** Ink không có màn đăng nhập bắt buộc — mọi máy có sẵn `uid` ẩn danh (Firebase) ngay từ lần mở app
> đầu tiên; đăng nhập Apple/Google chỉ là **nâng cấp** (`link(with:)`), không tạo tài khoản mới. Xem
> [00-README.md](00-README.md) cho quy ước ID/priority.
> **Ngày lập:** 2026-09-20 · **Người lập:** QC

## Môi trường & thiết bị cần

| Cần | Bắt buộc | Dùng cho |
|---|---|---|
| 1 iPhone | ✅ | Toàn bộ Suite ID1/ID2/ID3 — hầu hết case chỉ cần 1 máy |
| **2 thiết bị** (2 iPhone, hoặc 1 iPhone + 1 iPad) | Chỉ cho TC-F2-08 | Verify 2 máy cùng account resolve về 1 uid |
| Tài khoản **Apple** thật | ✅ | TC-F2-04, TC-F2-18 — Apple thường **không trả tên**, case hay vỡ nhất trong file này |
| Tài khoản **Google** thật | ✅ | TC-F2-05, TC-F2-09 (Suite ID2), TC-F2-14 (logo màu thật) |
| Khả năng gỡ app + cài lại (không chỉ tắt/mở) | ✅ | TC-F2-07 |
| Firebase test project (bật Anonymous Auth), khả năng reset `currentUser` giữa các lần chạy | ✅ | TC-F2-01/02/03 — cần test lại đúng nhánh "chưa có currentUser" |
| iPad | Không cần | Không có case nào trong file này phụ thuộc layout iPad |
| iOS 26 (Liquid Glass) | Không cần | Màn Account trong file này không dùng hiệu ứng kính — khác Discover header (ngoài phạm vi) |

---

## Suite ID1 — Vòng đời uid & Keychain (§1)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F2-01 | §1 | Cài mới, chưa từng mở app | Mở app lần đầu | Gọi đúng 1 lần `signInAnonymously()`, có uid mới, uid được lưu Keychain | P2 |
| TC-F2-02 | §1 | Đã có uid từ trước (không gỡ app, chỉ tắt/mở lại) | Mở lại app nhiều lần liên tiếp | `signInAnonymously()` KHÔNG được gọi lại; uid không đổi qua các lần mở | P1 |
| TC-F2-03 | §1, `.note.warn` | Giả lập/instrument code thiếu check `currentUser == nil` (hoặc kiểm qua log/network call thực tế) | Mở app nhiều lần | Nếu thiếu check: mỗi lần là 1 uid mới → verify KHÔNG xảy ra trên build thật; nếu xảy ra, mọi lịch sở hữu trước đó bị mồ côi (`owner_uid` cũ không còn ai truy cập) | P1 |
| TC-F2-04 | §1 | Có uid ẩn danh sẵn | Đăng nhập Apple qua `link(with:)` | uid **không đổi** trước/sau khi link; `calendars.owner_uid`/`share_members.uid` cũ vẫn hợp lệ, không mất quyền | P1 |
| TC-F2-05 | §1 | Có uid ẩn danh sẵn | Đăng nhập Google qua `link(with:)` | Tương tự TC-F2-04, uid không đổi | P1 |
| TC-F2-06 | §1 | Tài khoản ẩn danh chưa link | Kiểm tra trạng thái hiển thị trong app | Tài khoản ẩn danh vẫn được coi là "chưa đăng nhập" (`session(for:)` trả `.signedOut`), dù vẫn có uid hợp lệ để gọi API | P2 |
| TC-F2-07 | §1 | Uid đã tồn tại (ẩn danh hoặc đã link) | Gỡ app, cài lại, không đăng nhập lại thủ công | Keychain trả lại đúng uid cũ; lịch/quyền cũ vẫn còn nguyên khi gọi API | P1 |
| TC-F2-08 | §1 | 2 thiết bị, cùng 1 tài khoản Apple/Google đã link trước đó | Đăng nhập cùng tài khoản trên thiết bị thứ 2 | Cả 2 thiết bị cùng resolve về **1 uid** | P2 |
| TC-F2-09 | §0, §2 | Uid ẩn danh (chưa link Apple/Google) | Dùng uid ẩn danh để tạo share | Thành công — token hợp lệ không phụ thuộc đã "đăng nhập" theo nghĩa UI, chỉ cần uid ký hợp lệ. Xác nhận lại bằng `idToken()`/`syncIdToken()` (`login-backup-share-sync.md` §2): sharing luôn dùng `syncIdToken()`, không đòi tài khoản thật | P2 |
| TC-F2-10 | §0 | Gọi 3 endpoint AI: `/ink/help`, `/ink/chat`, `/suggest-event` | Gọi không kèm bất kỳ token nào | Thành công bình thường (endpoint cố ý không cần đăng nhập) — không bị nhầm áp dụng luật Bearer token của luồng share | P3 |

## Suite ID2 — Màn Account, chưa đăng nhập (UI PR #260/#274 §7.1)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F2-11 | §7.1 | Chưa đăng nhập | Mở Cài đặt | Dòng tài khoản có mascot Ink + câu mời, **không còn** ghi "Account · Not signed in" | P3 |
| TC-F2-12 | §7.1 | — | Mở màn Account | Có hình minh hoạ + 3 dòng lợi ích | P3 |
| TC-F2-13 | §7.1 | — | Đọc 3 dòng lợi ích | Chỉ hứa những gì tài khoản thật sự mở ra (**tạo** link chia sẻ) — **không** hứa việc **join** link (việc đó miễn phí) | **P1** |
| TC-F2-14 | §7.1 | — | Xem nút đăng nhập Google | Dùng logo màu thật, không phải chữ G xám | P3 |
| TC-F2-15 | §7.1 | — | Mở màn mời đăng nhập (login gate) | **Không còn** nút Cancel — chỉ thoát bằng vuốt xuống | P2 |

## Suite ID3 — Màn Account, đã đăng nhập (UI PR #260/#274 §7.2)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F2-16 | §7.2 | Đã đăng nhập | Mở Cài đặt | Thẻ tài khoản là MỘT dòng (ảnh đại diện · tên/email · mũi tên) — không còn 3 dòng riêng, không còn "Signed in with Google" | P3 |
| TC-F2-17 | §7.2 | — | — | Cạnh tên có logo nhà cung cấp (Apple/Google) cỡ nhỏ | P3 |
| TC-F2-18 | §7.2 (case hay vỡ — Apple thường không trả tên) | Đăng nhập Apple, tài khoản không có tên | — | Chỗ tên hiện **"Apple Account"**; ảnh đại diện là **icon người trên nền tròn**, không phải vòng tròn trống | P2 |
| TC-F2-19 | §7.2 | — | Mở màn Account | Sign out và Delete account **cùng kiểu nút ở chân màn**, chỉ khác màu (thường vs đỏ/coral) | P2 |
| TC-F2-20 | §7.2 | — | Bấm Sign out | Thoát đúng, không ảnh hưởng dữ liệu đã share/joined | P2 |
| TC-F2-21 | §7.2 (= điểm vào UI thật của TC-F12-04, xem [09-account-member-unlock-delete.md](09-account-member-unlock-delete.md)) | — | Bấm Delete account | Hỏi xác thực lại **trước** khi xoá — sau khi xác thực, kích hoạt đúng `DELETE /api/ink/account` | **P1** |

---

**Tổng: 21 case** (10 backend/định danh nền + 5 UI chưa đăng nhập + 6 UI đã đăng nhập).

**Câu hỏi mở liên quan** (xem [open-questions-for-dev.md](../../requirements/test-plans/ink-identity-sync-flow/ink-identity-sync-flow-open-questions-for-dev.md)):
Firebase ID token hết hạn giữa phiên — đã trả lời (Q4, vòng 1): SDK tự refresh qua `getIDToken()` trước mỗi
request, "hết hạn giữa phiên" gần như không phải case người dùng gặp được trong điều kiện bình thường.
