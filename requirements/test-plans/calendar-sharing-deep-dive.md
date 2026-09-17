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
>
> Mỗi file tự chứa đủ để chạy độc lập (findings/state-transition/decision-table/test case riêng của side đó);
> phần precondition cần dữ liệu từ side kia được ghi rõ dạng "fixture: xem file kia" thay vì dựng lại từ đầu.
> **Ngày lập:** 2026-09-16 · **Cập nhật 2026-09-17:** tách theo Owner/Receiver theo yêu cầu · **Người lập:** QC

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

| Case | Owner làm gì | Receiver làm gì | Xem chi tiết |
|---|---|---|---|
| Auto-publish "khi Ink có cơ hội" | Đổi 1 sự kiện ở lịch nguồn, không bấm gì thủ công | Verify nhận được thay đổi mà không cần Owner bấm "Refresh now"/"Check for updates" | Owner: TC-OWNER-15 · Receiver: TC-RECV-11 |
| Renew sau khi expired | Bấm Renew, quan sát expiry mới | Verify có tự chuyển `expired → active` không (mục 1.3 Owner / mục 1.1 Receiver — chưa rõ cơ chế) | Owner: TC-OWNER-20 · Receiver: TC-RECV-04b |
| Owner tự mở link của chính mình (self-follow, D10) | Signed out, mở link của chính mình, login → route Manage Sharing | (Owner đóng cả 2 vai tạm thời — không phải Receiver thật) | Đã có sẵn ở Scope A: `login-account-deep-dive.md` TC-A-20…23, `login-signin.md` TC-SELF-01/02 |
| Reconciliation đa thiết bị | Sign out/in trên máy A, share vẫn active | Không liên quan Receiver thật — đây thực ra là 2 "Owner instance" khác thiết bị, ghi nhận ở đây để tránh hiểu nhầm là case Owner/Receiver | Owner: TC-OWNER-26; xem thêm `login-account-deep-dive.md` mục 2 (State Transition Account) |

Không viết case riêng lặp lại 4 dòng trên ở cả 2 file con — mỗi file chỉ giữ đúng 1 nửa (phần side đó tự làm
được) và trỏ chéo sang nửa kia.
