# Mermaid — Sharing End-to-End Flow (Owner ⇄ Receiver, toàn cảnh)

> Ghép Owner + Receiver + login vào 1 bức tranh để thấy chỗ nào 2 side thật sự giao nhau. Chi tiết từng nhánh
> nằm ở 4 file kia trong thư mục này; xem
> [../test-plans/calendar-sharing-deep-dive.md](../test-plans/login-and-calendar-sharing/calendar-sharing-deep-dive.md) mục "Suite liên-side"
> cho danh sách case buộc phải chạy đồng thời cả 2 role.

```mermaid
flowchart TD
    subgraph OWNER["OWNER (calendar-sharing-owner-deep-dive.md)"]
        O1["Manage Calendar\n(không cần login — AC-I2)"] --> O2{"Đủ điều kiện share?\nD8: owned vs read-only/\nsubscribed/system/received"}
        O2 -- "Không" --> O2x["'Sharing unavailable'\n❓ copy theo lý do — mục 1.2 owner deep-dive"]
        O2 -- "Có" --> O3["Tap Share calendar"]
        O3 --> O4{"Signed in?\n(xem login-gate-decision-flows.md Flow 1)"}
        O4 -- "Không" --> O5["Gate đăng nhập"] --> O6["Share Setup"]
        O4 -- "Có" --> O6
        O6 --> O7["Create share link"]
        O7 --> O8(("Shared\nsee sharing-owner-state-diagram.md"))
        O8 --> O9["Copy link / Share…"]
    end

    O9 -.->|"Link được gửi qua Messages/Mail/QR"| R1

    subgraph RECEIVER["RECEIVER (calendar-sharing-receiver-deep-dive.md)"]
        R1["Mở link → Web View preview\n(privacy-safe, đúng toggle Owner đã set)"] --> R2{"Ink đã cài?"}
        R2 -- "Chưa" --> R2a["'Get Ink' fallback"] --> R2
        R2 -- "Rồi" --> R3["Open in Ink"]
        R3 --> R4{"Là chính Owner\nmở link của mình?\n(xem login-gate-decision-flows.md Flow 3)"}
        R4 -- "Có" --> O8
        R4 -- "Không" --> R5["Receiver preview trong Ink\nKHÔNG cần đăng nhập — mục 1.0 receiver deep-dive"]
        R5 --> R6["Add to Ink"]
        R6 --> R7(("Active\nsee sharing-receiver-state-diagram.md"))
    end

    O8 -.->|"AUTO-PUBLISH khi Ink có cơ hội\n❓ cần Receiver thật verify — TC-OWNER-15 / TC-RECV-11"| R7
    O8 -.->|"Stop sharing"| R7d["Receiver: No longer shared\n(giữ nguyên, không tự xoá)"]
    R7 --> R7d

    classDef openQuestion fill:#fff3cd,stroke:#d97706,color:#7c2d12
    class O2x openQuestion
```

## Ghi chú đọc sơ đồ

- **Đường nét đứt (`-.->`)** = điểm giao nhau thật sự giữa 2 side, cần cả Owner lẫn Receiver cùng hoạt động để
  verify trọn vẹn — khớp đúng bảng "Suite liên-side" ở file mục lục `calendar-sharing-deep-dive.md`.
- **Node vàng** = còn câu hỏi mở, chưa chốt copy/hành vi — tra cứu chi tiết ở deep-dive tương ứng trước khi viết
  assertion literal-string.
- Sơ đồ này **không thay thế** 4 file state-diagram/flow chi tiết — dùng để định hướng, khi cần drill-down thì
  mở đúng file nhánh đó.
