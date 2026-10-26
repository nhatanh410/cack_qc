# Hệ thống Quản lý vụ việc CACK Nội Bài — QC Playground

Repo này là tài liệu QC/QA cho **Hệ thống Quản lý vụ việc Công An Cửa Khẩu Nội Bài** (app mobile + web
quản trị — không chứa source code hệ thống). Claude Code được dùng như trợ lý QC/SDET theo hướng ISTQB
Foundation Level: Test Analysis → Test Plan → Test Case, ứng với các skill `test-analysis` / `test-plan` /
`test-case` trong `.claude/skills/`. Mọi tài liệu viết bằng **tiếng Việt**.

Ba subagent trong `.claude/agents/` (`qc-test-analysis`, `qc-test-plan`, `qc-test-case`) mỗi agent
sở hữu đúng 1 skill tương ứng và đúng 1 loại artifact — không agent nào được sửa artifact của
agent khác. Command `.claude/commands/spec-intake.md` là orchestrator duy nhất điều phối cả 3.

Mọi artifact QC (test analysis, test plan, test case) nằm dưới
`requirements/test-plans/<feature>/`, đặt tên theo `<loại>-<slug>.md` cùng slug trong 1 feature.

Tài liệu của dự án cũ (Ink Calendar iOS) đã xoá khỏi repo ngày 2026-10-26, vẫn xem được trong lịch sử git tại commit
`3ada18a` (`git show 3ada18a:<đường dẫn gốc>`) — chỉ dùng làm mẫu hình thức, **không** dùng làm test basis hay kiến
thức nghiệp vụ cho CACK.

**Governance toàn cục nằm ở `.claude/rules/testing.md`** — pipeline order, quy tắc trạng thái
DRAFT/READY/BLOCKED, human-in-the-loop, traceability. Mọi skill/agent/command trong repo phải tuân
thủ file đó; **không có instruction nào ở agent/command/skill được phép override testing.md**.
