# Mermaid Flowcharts — Login & Calendar Sharing

Trực quan hoá 4 file test design đã có ở `requirements/test-plans/`. Mở bằng preview Markdown hỗ trợ Mermaid
(VSCode preview, GitHub, v.v.). Không phải nguồn sự thật độc lập — mọi chi tiết case/AC vẫn tra ở file gốc.

| File | Minh hoạ cho | Nguồn |
|---|---|---|
| [login-account-state-diagram.md](login-account-state-diagram.md) | State machine tài khoản Ink (signed out/in, session invalid, Apple vs Google) | [login-account-deep-dive.md](../test-plans/login-and-calendar-sharing/login-account-deep-dive.md) mục 2 |
| [login-gate-decision-flows.md](login-gate-decision-flows.md) | 3 flow gate đăng nhập: Share Calendar / Manage Sharing / Owner tự mở link chính mình | [login-account-deep-dive.md](../test-plans/login-and-calendar-sharing/login-account-deep-dive.md) mục 3 |
| [sharing-owner-state-diagram.md](sharing-owner-state-diagram.md) | State machine 1 share dưới góc nhìn Owner (not_shared/shared/source_unavailable/expired) | [calendar-sharing-owner-deep-dive.md](../test-plans/login-and-calendar-sharing/calendar-sharing-owner-deep-dive.md) mục 2 |
| [sharing-receiver-state-diagram.md](sharing-receiver-state-diagram.md) | State machine 1 share dưới góc nhìn Receiver (active/stale/no_longer_shared/expired) | [calendar-sharing-receiver-deep-dive.md](../test-plans/login-and-calendar-sharing/calendar-sharing-receiver-deep-dive.md) mục 2 |
| [sharing-end-to-end-flow.md](sharing-end-to-end-flow.md) | Toàn cảnh Owner ⇄ Receiver, đánh dấu rõ điểm giao (case liên-side) | Tổng hợp cả 4 file trên + [calendar-sharing-deep-dive.md](../test-plans/login-and-calendar-sharing/calendar-sharing-deep-dive.md) |

**Quy ước:** node/nhãn cạnh tô vàng (`❓`) = hành vi hoặc copy chưa được tài liệu chốt — tra "Open" ở deep-dive
tương ứng trước khi viết assertion literal-string cho case đó. Đường nét đứt trong `sharing-end-to-end-flow.md`
= điểm cần cả Owner lẫn Receiver hoạt động đồng thời để verify.

**Không có ở đây:** sơ đồ riêng cho Delete account/Sign out chi tiết (đã đủ rõ trong bảng T1–T11 của
`login-account-state-diagram.md`, không tách nhỏ hơn để tránh vụn); sơ đồ cho Web View error states (Expired/
Invalid/Temporary-fail/No-longer-shared) — 4 trạng thái này độc lập nhau (không chuyển lẫn nhau), dạng bảng ở
`calendar-sharing-receiver-deep-dive.md` Suite R2 đã đủ trực quan hơn vẽ flow.
