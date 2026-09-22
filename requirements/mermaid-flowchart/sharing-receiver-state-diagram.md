# Mermaid — Sharing State Diagram, Receiver side (Scope B)

> Minh hoạ cho bảng "State Transition — Receiver" (R1–R7) ở
> [../test-plans/calendar-sharing-receiver-deep-dive.md](../test-plans/login-and-calendar-sharing/calendar-sharing-receiver-deep-dive.md)
> mục 2. Test case tương ứng: file đó, Suite R0/R2/R3 (TC-RECV-00…14).

```mermaid
stateDiagram-v2
    [*] --> NotAdded: Nhận link (Messages/Mail/QR...)

    NotAdded --> Active: Web preview → Open in Ink\n→ Add to Ink (R1)\nKHÔNG cần đăng nhập Ink (mục 1.0 — chỉ 1 nguồn xác nhận, xem TC-RECV-00)\nKHÔNG tạo subscriber/member record nào

    Active --> Stale: Refresh thất bại tạm thời\n(mạng/API lỗi) (R2)
    Stale --> Active: Refresh thành công trở lại\nKhông cần thao tác thủ công (R3)

    Active --> NoLongerShared: Owner Stop sharing (R4)
    Stale --> NoLongerShared: Owner Stop sharing (R4)

    Active --> Expired: Tới ngày expiry (R5)
    Stale --> Expired: Tới ngày expiry (R5)

    Expired --> Active: Owner Renew (phía Owner) (R6)

    NoLongerShared --> [*]: Receiver bấm 'Remove calendar' (R7)
    Expired --> [*]: Receiver bấm 'Remove calendar' (R7)

    note right of Expired
        ❓ Owner Renew có tự động đưa
        Receiver về Active không, hay cần
        Receiver tự mở lại app/refresh?
        Không tài liệu nào định nghĩa transition
        này — xem deep-dive mục 1.1, TC-RECV-04b.
    end note

    note right of Stale
        Copy: "Couldn't refresh · Showing
        the version from [ngày]" — KHÔNG
        được nhầm với NoLongerShared/Expired
        (test plan chung, Decision Table 3).
    end note

    note left of NoLongerShared
        Không tự xoá khỏi Calendars list —
        giữ nguyên + dữ liệu cũ tới khi
        Receiver tự bấm Remove (AC-R7/R8).
    end note
```
