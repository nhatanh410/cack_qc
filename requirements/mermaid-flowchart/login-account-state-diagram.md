# Mermaid — Account State Diagram (Scope A)

> Minh hoạ trực quan cho bảng "State Transition chi tiết — Account" (T1–T11) ở
> [../test-plans/login-account-deep-dive.md](../test-plans/login-and-calendar-sharing/login-account-deep-dive.md) mục 2. Test case tương
> ứng nằm ở [../../test-cases/login-signin.md](../../test-cases/login-and-calendar-sharing/login-signin.md).
> Ký hiệu: `❓` trên nhãn cạnh = hành vi chưa được tài liệu nào xác nhận rõ, xem "Open" ở deep-dive.

```mermaid
stateDiagram-v2
    [*] --> SignedOut: Cài app lần đầu

    SignedOut --> SignedOut: Cancel/Not now gate (T3)\nhoặc sign-in fail (T2)

    SignedOut --> SignedIn_Apple: Continue with Apple\nthành công (T1)
    SignedOut --> SignedIn_Google: Continue with Google\nthành công (T1)

    SignedIn_Apple --> SignedOut: Sign out (T4)\nshare/lịch không đổi
    SignedIn_Google --> SignedOut: Sign out (T4)\nshare/lịch không đổi

    SignedIn_Apple --> SessionInvalid: Session bị revoke\n(Apple ID settings, phát hiện lười) (T5)
    SignedIn_Google --> SessionInvalid: Session bị revoke\n(Google Account access, phát hiện lười) (T5)

    SessionInvalid --> SessionInvalid: Thử owner-only action\n→ hiện gate "Sign in again" (T6)
    SessionInvalid --> SignedIn_Apple: Sign in lại thành công,\nquay về đúng action (T7)
    SessionInvalid --> SignedIn_Google: Sign in lại thành công,\nquay về đúng action (T7)

    SignedIn_Apple --> SignedOut: Delete account, xác nhận (T8)\ntất cả share dừng ngay
    SignedIn_Google --> SignedOut: Delete account, xác nhận (T8)\ntất cả share dừng ngay

    note right of SignedIn_Apple
        Apple và Google LUÔN là 2 Ink account
        khác nhau (§2.5), kể cả trùng email.
        Không có cạnh trực tiếp Apple ⇄ Google —
        phải qua SignedOut (T9).
        Sign out khỏi Apple rồi Sign in Google
        KHÔNG thừa kế share/lịch của account Apple.
    end note

    note right of SessionInvalid
        Local cache có thể vẫn hiện gợi ý
        "Shared — Sign in to manage" (T10),
        nhưng KHÔNG cấp quyền owner action
        nào cho tới khi đăng nhập lại thành công.
    end note
```
