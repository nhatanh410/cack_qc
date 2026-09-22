# Test Design (đào sâu) — Scope B: Shared Calendars (index — chia theo Owner/Receiver)

> **Thuộc test plan chung:** [login-and-calendar-sharing.md](login-and-calendar-sharing.md) — file này là mục
> lục cho phần đào sâu Scope B, tách theo yêu cầu thành 2 side để test độc lập, dễ giao việc/chạy song song:
> - **[calendar-sharing-owner-deep-dive.md](calendar-sharing-owner-deep-dive.md)** — Owner: chủ của collection
>   lịch, người share lịch, full quyền tương tác với event của lịch nguồn. 28 test case (TC-OWNER-01…27, +19b —
>   19b bổ sung 2026-09-17: Stop sharing 1 calendar không được ảnh hưởng calendar khác đang share cùng lúc).
> - **[calendar-sharing-receiver-deep-dive.md](calendar-sharing-receiver-deep-dive.md)** — Receiver: bên nhận
>   lịch qua link, không có quyền sửa event nguồn, chỉ tuỳ biến hiển thị cục bộ. 22 test case (TC-RECV-00…19,
>   3 case đầu dạng `00a/00b/00c` xác nhận Receiver không cần đăng nhập Ink — xem mục 3 file đó, đây là giả định
>   nền tảng của cả file nhưng chỉ có 1 nguồn tài liệu mô tả, không phải AC chính thức).
> - **[calendar-sharing-data-sync-deep-dive.md](calendar-sharing-data-sync-deep-dive.md)** — **Data Sync**
>   (cross-cutting, không thuộc hẳn Owner hay Receiver): cơ chế đồng bộ Owner → backend → Receiver, cộng
>   online/offline. 26 test case (TC-SYNC-01…26). Phát hiện lớn nhất: trigger publish/refresh chưa định nghĩa,
>   `window` trong payload không có quy tắc rolling/fixed, **recurring events hoàn toàn chưa được đề cập ở bất
>   kỳ tài liệu nào**, timezone chỉ có 1 field cấp payload (không per-event), và **offline chỉ được xử lý ở
>   phía Receiver — toàn bộ action của Owner (Create/Stop/edit/Renew) khi offline chưa có tài liệu nào** — rủi
>   ro P1 cao nhất trong toàn bộ Scope B.
> - **[calendar-sharing-event-interaction-deep-dive.md](calendar-sharing-event-interaction-deep-dive.md)** —
>   **Event-level Interaction** (cross-cutting): 3 file kia đều dừng ở cấp **calendar**, không file nào phân
>   tích tương tác với **1 event cụ thể** bên trong lịch đã share. 17 test case (TC-EVT-01…17). Phát hiện lớn
>   nhất (mục 1.7): **lịch nhận qua share có được dùng làm nguồn wallpaper/widget/lock screen không — giá trị
>   cốt lõi của app (tên sản phẩm chính là "LockScreen Calendar") — 0 tài liệu nào trong toàn bộ 4 file sharing
>   lẫn các spec wallpaper/Discover khác từng nhắc tới nhau.** Ngoài ra: 0 mockup nào cho màn event-detail
>   trong ngữ cảnh shared calendar; không có cơ chế loại trừ riêng 1 event khỏi share (per-event privacy);
>   attendee/alarm/reminder vắng mặt khỏi payload; field `url` không nằm trong bất kỳ toggle privacy nào — rủi
>   ro leak link riêng tư (vd Zoom) dù đã tắt hết Notes/Locations.
> - **[calendar-sharing-wallpaper-render-deep-dive.md](calendar-sharing-wallpaper-render-deep-dive.md)** —
>   **🎯 Capstone: Shared Events → Wallpaper Render.** File gộp cuối cùng — đúng mục tiêu đã xác nhận: toàn bộ
>   Login + Owner/Receiver + Data Sync + Event Interaction đều là chuẩn bị dữ liệu cho giai đoạn quan trọng
>   nhất này. 10 test case (TC-RENDER-01…10), nhưng phần lớn nội dung là **câu hỏi cần trả lời trước khi thiết
>   kế** vì đây là pipeline **chưa từng được đặc tả ở tầm sản phẩm** (đã đọc thêm
>   `wallpaper-component-editor-prd.md` để xác nhận — file đó cũng không nói calendar nào cấp dữ liệu cho
>   renderer). Câu hỏi quan trọng nhất: renderer đọc dữ liệu shared calendar qua local EventKit container đã
>   lọc sẵn theo privacy toggle, hay qua tầng model riêng cần lọc lại — quyết định mức độ nghiêm trọng thật của
>   rủi ro leak lớn nhất toàn bộ chuỗi phân tích Scope B.
>
> Mỗi file tự chứa đủ để chạy độc lập (findings/state-transition/decision-table/test case riêng của side đó);
> phần precondition cần dữ liệu từ side kia được ghi rõ dạng "fixture: xem file kia" thay vì dựng lại từ đầu.
> **Ngày lập:** 2026-09-16 · **Cập nhật 2026-09-17:** tách theo Owner/Receiver theo yêu cầu · **Cập nhật
> 2026-09-18:** thêm Data Sync + Event-level Interaction + capstone Wallpaper Render · **Người lập:** QC

---

## 1. Nguyên tắc chia side

- **Owner** = người tạo share, sở hữu source calendar, thấy được mọi UI quản lý (Manage Sharing, Stop sharing,
  Renew, đổi visibility/expiry, Copy link/Share…) và có toàn quyền sửa event ở app lịch gốc (ngoài Ink).
- **Receiver** = người mở link, `Add to Ink`, chỉ thấy bản read-only, chỉ sửa được hiển thị cục bộ (tên/màu/
  symbol trong Ink của chính họ).
- Case nào **chỉ cần 1 role** để verify trọn vẹn (vd Owner tạo share, hoặc Receiver xem Web View) → nằm hẳn
  trong 1 file, side kia chỉ xuất hiện dưới dạng "fixture" (dữ liệu tiền đề, không phải bước cần thực hiện lại).
- Case nào **buộc phải có cả 2 role hoạt động cùng lúc** để verify (vd Owner đổi lịch nguồn → Receiver phải
  thật sự nhận được update) → liệt kê ở mục 3 bên dưới, không nhân đôi vào cả 2 file.

## 2. Phát hiện dùng chung cả 2 side (không thuộc riêng Owner hay Receiver)

### PRD tự đụng ID với chính login spec: `AC-A1`–`AC-A4` bị dùng 2 lần cho 2 nội dung khác nhau

PRD §6.3 "Account UX" có `AC-A1`–`AC-A4` riêng:

```text
AC-A1  Account management lives in Settings → Account.
AC-A2  Share screens do not contain app-level Sign out or Delete account actions.
AC-A3  User can use local calendar features without signing in.
AC-A4  Deleting the account clearly warns that all active shares owned by the account will stop.
```

Login spec (test basis của `login-account-deep-dive.md`, `test-cases/login-signin.md`) cũng có `AC-A1`–`AC-A19`,
4 ID đầu **hoàn toàn khác nội dung** (vd `AC-A1` login spec = "Ink remains usable without an account", không
liên quan gì tới `AC-A1` của PRD). Đây là **đụng ID thật**, không phải trùng hợp diễn giải.

**Quy ước dùng từ đây trong mọi tài liệu QC:** `AC-A#` không kèm nguồn = của login spec; ACs riêng của PRD §6.3
gọi là **`PRD-AC-A#`**. Cả 2 file Owner/Receiver đã áp dụng quy ước này.

## 3. Suite liên-side (cần cả Owner + Receiver hoạt động cùng lúc, không tách được)

> **Data Sync đã có file riêng** — [calendar-sharing-data-sync-deep-dive.md](calendar-sharing-data-sync-deep-dive.md)
> — vì phạm vi đủ lớn (trigger, window, recurring, uid, timezone) để không còn là "vài dòng tham chiếu" như 4
> case dưới đây; TC-SYNC-01/15 mở rộng sâu hơn đúng case "Auto-publish" ở dòng đầu bảng này.

| Case | Owner làm gì | Receiver làm gì | Xem chi tiết |
|---|---|---|---|
| Auto-publish "khi Ink có cơ hội" | Đổi 1 sự kiện ở lịch nguồn, không bấm gì thủ công | Verify nhận được thay đổi mà không cần Owner bấm "Refresh now"/"Check for updates" | Owner: TC-OWNER-15 · Receiver: TC-RECV-11 · **đào sâu:** `calendar-sharing-data-sync-deep-dive.md` TC-SYNC-01…16 |
| Renew sau khi expired | Bấm Renew, quan sát expiry mới | Verify có tự chuyển `expired → active` không (mục 1.3 Owner / mục 1.1 Receiver — chưa rõ cơ chế) | Owner: TC-OWNER-20 · Receiver: TC-RECV-04b |
| Owner tự mở link của chính mình (self-follow, D10) | Signed out, mở link của chính mình, login → route Manage Sharing | (Owner đóng cả 2 vai tạm thời — không phải Receiver thật) | Đã có sẵn ở Scope A: `login-account-deep-dive.md` TC-A-20…23, `login-signin.md` TC-SELF-01/02 |
| Reconciliation đa thiết bị | Sign out/in trên máy A, share vẫn active | Không liên quan Receiver thật — đây thực ra là 2 "Owner instance" khác thiết bị, ghi nhận ở đây để tránh hiểu nhầm là case Owner/Receiver | Owner: TC-OWNER-26; xem thêm `login-account-deep-dive.md` mục 2 (State Transition Account) |

Không viết case riêng lặp lại 4 dòng trên ở cả 2 file con — mỗi file chỉ giữ đúng 1 nửa (phần side đó tự làm
được) và trỏ chéo sang nửa kia.
