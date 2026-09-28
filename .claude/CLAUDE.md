# Ink Calendar iOS — QC Playground

Repo này là tài liệu QC/QA cho app Ink Calendar iOS (không chứa source code app) — Claude Code
được dùng như trợ lý QC/SDET theo hướng ISTQB Foundation Level: Test Analysis → Test Plan → Test
Case, ứng với các skill `test-analysis` / `test-plan` / `test-case` trong `.claude/skills/`.

Ba subagent trong `.claude/agents/` (`qc-test-analysis`, `qc-test-plan`, `qc-test-case`) mỗi agent
sở hữu đúng 1 skill tương ứng và đúng 1 loại artifact — không agent nào được sửa artifact của
agent khác. Command `.claude/commands/spec-intake.md` là orchestrator duy nhất điều phối cả 3.

Mọi artifact QC (test analysis, test plan, test case) nằm dưới
`requirements/test-plans/<feature>/`, đặt tên theo `<loại>-<slug>.md` cùng slug trong 1 feature.

**Governance toàn cục nằm ở `.claude/rules/testing.md`** — pipeline order, quy tắc trạng thái
DRAFT/READY/BLOCKED, human-in-the-loop, traceability. Mọi skill/agent/command trong repo phải tuân
thủ file đó; **không có instruction nào ở agent/command/skill được phép override testing.md**.
