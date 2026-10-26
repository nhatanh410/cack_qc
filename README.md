# CACK QC — Hệ thống Quản lý vụ việc Công An Cửa Khẩu Nội Bài

Đây **không phải** repo chứa source code. Đây là workspace tài liệu QA cho **Hệ thống Quản lý vụ việc Công An
Cửa Khẩu Nội Bài** (app mobile + web quản trị) — nơi lưu spec, dựng wireframe từ screenshot, viết checklist
khám phá, lập test plan / test case theo ISTQB Foundation Level và theo dõi bug.

> ⚠️ Hệ thống xử lý dữ liệu cá nhân (CCCD/hộ chiếu, họ tên, chữ ký). Chỉ dùng dữ liệu test trong mọi tài liệu,
> bug và ảnh. Repo GitHub hiện đang **public** — ảnh spec/screenshot đang bị `.gitignore` chặn.

---

## Bắt đầu từ đâu

| Muốn làm gì | Vào đây |
|---|---|
| Đặc tả chính thức (cơ sở kiểm thử chính) | [`dac-ta-chuc-nang-v2.1.md`](requirements/specs/xu-ly-vi-pham-giao-viec/dac-ta-chuc-nang-v2.1.md) — use case, ma trận quyền, trạng thái, quy tắc nghiệp vụ |
| Hiểu hệ thống làm gì (spec tổng quan) | [`mo-ta-chuc-nang-v1.md`](requirements/specs/xu-ly-vi-pham-giao-viec/mo-ta-chuc-nang-v1.md) + bản làm rõ [`lam-ro-2026-10-26.md`](requirements/specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-26.md) |
| Xem danh sách flow + vai trò dùng từng flow | [`.claude/rules/screenshot-naming.md`](.claude/rules/screenshot-naming.md) §7 (đã xác nhận 2026-10-26) |
| Xem UI thật của 1 màn hình / flow | [`requirements/ui/ux/screenshots/`](requirements/ui/ux/screenshots/) — tách theo `iphone/` · `web/` |
| Đọc wireframe dựng từ screenshot | [`requirements/ui/ux/wideframes/`](requirements/ui/ux/wideframes/) — 1 file / flow |
| Chạy 1 phiên khám phá (exploratory) | [`requirements/exploratory/`](requirements/exploratory/) — skill `exploratory-checklist` |
| Phân tích spec → test plan → test case | Chạy `/spec-intake <đường dẫn spec>` — kết quả ở [`requirements/test-plans/<feature>/`](requirements/test-plans/) |
| Xem bug đang mở | [`bugs/bug-log.md`](bugs/bug-log.md) |
| Đẩy bug lên GitHub issue | [`docs/guides/bug-issue-setup.md`](docs/guides/bug-issue-setup.md) — skill `github-issue-bug` + `scripts/` |
| Quy tắc chung của pipeline QC | [`.claude/rules/testing.md`](.claude/rules/testing.md) |
| Tài liệu dự án cũ (Ink Calendar iOS) — chỉ làm mẫu hình thức | Đã xoá khỏi repo (2026-10-26); xem trong lịch sử git: `git show 3ada18a:<đường dẫn gốc>` |

---

## Hệ thống gồm gì (tóm tắt từ spec)

- **Vai trò:** người giao việc (Đội trưởng/Chỉ huy Đội, Tổ trưởng, Tổ phó, Phó đội trưởng, Phó trưởng CACK, Trưởng
  CACK, và cán bộ được uỷ quyền Tổ phó) và cán bộ (nhận việc).
- **App mobile (hiện chỉ chạy trên iPhone):** tạo vụ việc xử lý vi phạm (9 bước, có quét giấy tờ), tiếp nhận & xử lý vụ việc, lập và ký biên
  bản trên thiết bị (xuất PDF), giao việc, gia hạn / phân công lại / huỷ phần việc / phân công tiếp, thống kê ở
  Trang chủ, báo cáo hằng ngày.
- **Web quản trị:** nơi lưu kết quả — 🚧 chưa có mô tả.

## Cấu trúc thư mục

```text
.claude/            skill, agent, command, rule cho Claude Code (pipeline ISTQB)
requirements/
  specs/<feature>/       test basis từ dev/PM
  test-plans/<feature>/  test-analysis / test-plan / test-cases cùng <slug>
  exploratory/           checklist khám phá theo flow
  ui/ux/screenshots/     ảnh thật, đặt tên theo screenshot-naming.md
  ui/ux/wideframes/      wireframe theo flow
  istqb-foundation/      syllabus ISTQB CTFL v4.0.1 (tham chiếu)
test-cases/         test case tách riêng cho feature phức tạp
bugs/bug-log.md     bug log duy nhất
scripts/            bug-log → GitHub issue
```
