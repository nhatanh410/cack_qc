# Mermaid — Login Gate Decision Flows (Scope A)

> Minh hoạ cho Decision Table "Entry point đăng nhập × trạng thái account × gate hiển thị" ở
> [../test-plans/login-account-deep-dive.md](../test-plans/login-and-calendar-sharing/login-account-deep-dive.md) mục 3. Test case tương
> ứng: [../../test-cases/login-signin.md](../../test-cases/login-and-calendar-sharing/login-signin.md) Suite B/D/E/F/G/I.
> Node màu vàng = còn câu hỏi mở (copy chưa chốt hoặc hành vi chưa có mockup) — xem chi tiết ở deep-dive tương ứng.

## Flow 1 — Tap "Share calendar"

```mermaid
flowchart TD
    A["User tap Share calendar"] --> B{"Signed in?"}
    B -- "Không / session invalid" --> C["Hiện gate 'Sign in to share…'\n(tiêu đề/nút dismiss chưa chốt — mục 1.1 deep-dive)"]
    B -- "Có, chưa có active share" --> F["Vào Share Setup"]
    B -- "Có, calendar ĐÃ có active share" --> G["Route thẳng Manage Sharing\n(không tạo link thứ 2, D5)"]

    C --> D{"User chọn gì?"}
    D -- "Cancel/Not now" --> E["Quay lại Manage Calendar\nKhông tạo share (AC-A5)"]
    D -- "Continue with Apple/Google" --> H{"OAuth kết quả?"}
    H -- "Thành công" --> F
    H -- "User tự huỷ giữa chừng" --> E
    H -- "Lỗi mạng/hệ thống" --> I["'Couldn't sign in'\nTry again / Cancel"]
    I -- "Try again" --> H
    I -- "Cancel" --> E

    F --> J["Create share link"]
    J --> G

    class C openQuestion
    classDef openQuestion fill:#fff3cd,stroke:#d97706,color:#7c2d12
```

## Flow 2 — Mở Manage Calendar của lịch đã từng/đang share

```mermaid
flowchart TD
    A["Mở Manage Calendar\ncó local cache 'từng được share'"] --> B{"Signed in?"}
    B -- "Không" --> C["Thẻ 'Shared — Sign in to manage'\n+ nút Sign in\n(KHÔNG cấp owner action từ cache — AC-A6)"]
    B -- "Có, ĐÚNG account chủ share" --> F["Manage Sharing\n(load state từ server, không phải cache)"]
    B -- "Có, KHÁC account (không phải chủ)" --> X["❓ Chưa có mockup — chưa rõ hiển thị gì\n(deep-dive mục 3, Decision Table)"]

    C --> D{"User bấm gì?"}
    D -- "Dismiss" --> E["Quay lại Manage Calendar\nThẻ giữ nguyên trạng thái cache"]
    D -- "Sign in, thành công" --> G{"Ink xác định\nai là chủ share?"}
    G -- "Đúng account đang login" --> F
    G -- "Khác account" --> X

    class X openQuestion
    classDef openQuestion fill:#fff3cd,stroke:#d97706,color:#7c2d12
```

## Flow 3 — Owner mở link share của chính mình (D10, cross Scope A/B)

```mermaid
flowchart TD
    A["Mở link share (Messages/Mail/QR...)"] --> B["Web View: preview kiểu receiver\n(chưa biết ai đang mở link)"]
    B --> C["Bấm 'Open in Ink'"]
    C --> D{"Ink: signed in?"}
    D -- "Chưa" --> E["Preview trong Ink,\nvẫn kiểu receiver"]
    E --> F{"User trigger action\ncần ownership / đăng nhập"}
    F -- "Cancel" --> E
    F -- "Sign in thành công" --> G{"Ink account hiện tại\ncó sở hữu share này không?"}
    D -- "Rồi" --> G

    G -- "Không sở hữu" --> H["Flow receiver bình thường\n'Add to Ink'"]
    G -- "Có sở hữu" --> I{"Trước đó đã lỡ\nbấm Add to Ink chưa?\nvd 'Work · Shared' đã tồn tại"}
    I -- "Chưa" --> J["Route thẳng Manage Sharing\nKHÔNG hiện 'Add to Ink' (AC-A12)"]
    I -- "Rồi (có bản receiver trùng)" --> K["❓ Reconcile: xoá/merge bản receiver trùng\n(cơ chế transient chưa rõ — deep-dive mục 1.5)"]
    K --> J

    class K openQuestion
    classDef openQuestion fill:#fff3cd,stroke:#d97706,color:#7c2d12
```
