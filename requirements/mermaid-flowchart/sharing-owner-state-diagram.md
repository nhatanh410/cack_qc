# Mermaid — Sharing State Diagram, Owner side (Scope B)

> Minh hoạ cho bảng "State Transition — Sender/Owner" (T1–T10) ở
> [../test-plans/calendar-sharing-owner-deep-dive.md](../test-plans/calendar-sharing-owner-deep-dive.md) mục 2.
> Test case tương ứng: file đó, Suite O2–O4 (TC-OWNER-07…26).
> Đây là state của **1 calendar cụ thể** dưới góc nhìn Owner — không nhầm với Account state (xem
> [login-account-state-diagram.md](login-account-state-diagram.md), đã tách riêng vì 2 state machine độc lập
> nhau: 1 calendar có thể `not_shared` dù account đang `signed_in`, và ngược lại.

```mermaid
stateDiagram-v2
    [*] --> NotShared: Lịch owned, chưa từng share

    NotShared --> Shared: Share calendar\n→ Share Setup → Create link (T1)
    Shared --> Shared: Tap Share calendar lần nữa\n→ route Manage Sharing,\nKHÔNG tạo link thứ 2 (T2, D5)
    Shared --> Shared: Đổi tên lịch nguồn\nLink không đổi (T9)
    Shared --> Shared: Đổi visibility/expiry\ntrong Manage Sharing, cùng link (AC-I13)

    Shared --> SourceUnavailable: Nguồn tạm không đọc được\n(mất kết nối provider...) (T3)
    SourceUnavailable --> Shared: Nguồn xuất hiện lại,\nmatch theo ID — KHÔNG theo tên (T4)
    SourceUnavailable --> SourceUnavailable: Nguồn xác nhận xoá vĩnh viễn\nKHÔNG tự chuyển NotShared,\nchỉ prompt Stop sharing (T5)

    Shared --> NotShared: Stop sharing, xác nhận\nLink REVOKE VĨNH VIỄN (T6)
    NotShared --> Shared: Share lại sau Stop\n→ LINK MỚI hoàn toàn (khác T1 lặp lại)

    Shared --> Expired: Tới ngày expiry (T7)
    Expired --> Shared: Owner bấm Renew\nCÙNG LINK CŨ (T8)

    note right of Expired
        ❓ Không có mockup UI cho màn này.
        ❓ Renew có hiện lại bộ chọn
        30/90/365 hay tự gia hạn 90 ngày?
        Xem deep-dive mục 1.3, TC-OWNER-20.
    end note

    note right of SourceUnavailable
        ❓ Copy hiển thị chưa chốt:
        PRD = "Source calendar unavailable"
        In-app spec = "Can't update this share"
        Xem test plan chung, Decision Table 3.
    end note

    note left of NotShared
        Sign out rồi sign in account KHÁC
        (kể cả trùng email, khác provider)
        → calendar quay về NotShared
        từ góc nhìn account mới (T10) —
        xem login-account-state-diagram.md.
    end note
```
