# Quy tắc Pipeline QC

## Quy tắc chung

* Không bao giờ tự bịa hoặc suy diễn các requirement còn thiếu.
* Không bao giờ biến assumption (giả định) thành fact (sự thật/đã được xác nhận).
* Không bao giờ tự ý giải quyết các điểm mơ hồ mà không có xác nhận.
* Luôn duy trì khả năng truy xuất nguồn gốc (traceability) giữa requirement và các tài liệu kiểm thử.
* Luôn tôn trọng các điểm dừng human-in-the-loop và yêu cầu review của con người.

## Pipeline

Luồng xử lý bắt buộc:

```text
SPEC
  ↓
TEST ANALYSIS (tùy chọn)
  ↓
TEST PLAN
  ↓
TEST CASE
```

`TEST ANALYSIS` có thể được bỏ qua nếu điều kiện của pipeline/skill cho phép.

Không được tự ý thay đổi thứ tự của pipeline.

## Test Analysis

Các trạng thái được phép:

* `DRAFT` — Đang soạn thảo, chưa hoàn tất.
* `READY` — Đã hoàn tất và đủ điều kiện để chuyển sang bước tiếp theo.
* `BLOCKED` — Đang bị chặn bởi gap, ambiguity hoặc vấn đề cần con người xử lý.

Chỉ khi:

```text
TEST ANALYSIS = READY
```

thì mới được phép tiếp tục thực hiện `TEST PLAN`.

Nếu `TEST ANALYSIS = DRAFT` hoặc `BLOCKED`:

```text
STOP
```

Không được tự động chuyển sang bước `TEST PLAN`.

## Test Plan

Các trạng thái được phép:

* `DRAFT` — Đang soạn thảo, chưa hoàn tất.
* `READY` — Đã hoàn tất và đủ điều kiện để thiết kế test case.
* `BLOCKED` — Đang bị chặn bởi gap, ambiguity hoặc vấn đề cần con người xử lý.

Chỉ được phép tạo test case khi:

```text
TEST PLAN = READY
```

Nếu:

```text
TEST PLAN = DRAFT
```

hoặc:

```text
TEST PLAN = BLOCKED
```

thì:

```text
STOP
```

Không được tạo test case để "hoàn thành pipeline" khi test plan chưa sẵn sàng.

## Human Review — Human-in-the-loop

Khi một skill yêu cầu xác nhận hoặc review từ con người:

```text
STOP
```

Phải dừng pipeline và chờ người dùng xử lý.

Không được:

* Tự động tiếp tục pipeline.
* Tự trả lời thay cho người dùng.
* Tự quyết định thay cho người dùng đối với các câu hỏi cần xác nhận.
* Tự chuyển trạng thái `DRAFT` → `READY`.
* Tự chuyển trạng thái `BLOCKED` → `READY`.
* Bỏ qua hoặc che giấu warning/cảnh báo.
* Bỏ qua các open questions/gap đang chờ xử lý.
* Suy diễn câu trả lời cho các câu hỏi mà spec chưa xác định rõ.

## Traceability — Khả năng truy xuất

Mọi test case phải có khả năng truy xuất ngược về nguồn gốc của nó theo chuỗi:

```text
Requirement
    ↓
Test Condition
    ↓
Test Objective
    ↓
Test Case
```

Không được tạo test case mà không xác định được nó đang kiểm thử requirement hoặc test condition nào.

### Nguyên tắc Traceability

```text
1 Requirement
    │
    ├── Test Condition A
    │       ├── Test Objective A1
    │       │       ├── Test Case A1.1
    │       │       └── Test Case A1.2
    │       │
    │       └── Test Objective A2
    │               └── Test Case A2.1
    │
    └── Test Condition B
            └── Test Objective B1
                    └── Test Case B1.1
```

Nếu không xác định được quan hệ:

```text
Requirement
    ↓
???
    ↓
Test Case
```

thì phải đánh dấu là `GAP` hoặc `BLOCKED`, không được tự suy diễn.
