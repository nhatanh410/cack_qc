# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A **documentation-only QA workspace** for **Hệ thống Quản lý vụ việc Công An Cửa Khẩu Nội Bài (CACK)** — a
case-management system with two platforms: a **mobile app** (assigners create violation cases / tasks, officers
receive and handle them, sign records on the device) and a **web admin** ("trang quản trị hệ thống chung", not yet
described). It is not the system's source code. There is no build, lint, or test command: every file is Markdown
(plus image assets and a few shell scripts for bug → GitHub issue). "Testing" in this repo means writing/executing
ISTQB-style test documentation, not running an automated suite. All documentation is written in **Vietnamese**.
See [README.md](README.md) for navigation.

The repo was seeded from an earlier QC workspace (Ink Calendar iOS). That content was deleted from the working tree
on 2026-10-26 but is still in git history at commit `3ada18a` (original paths, e.g.
`git show 3ada18a:requirements/test-plans/shortcuts/test-plan-ios26-27.md`). Skills cite a few of those files as
**format references** only (how a test plan / test case / checklist is laid out) — never as test basis or domain
knowledge for CACK.

## Product facts that shape every test

- **Two roles** (spec v2.1 §3): *người giao việc* (Đội trưởng/Chỉ huy Đội, Tổ trưởng, Tổ phó, Phó đội trưởng, Phó
  trưởng CACK, Trưởng CACK, plus any *cán bộ được uỷ quyền Tổ phó* granted by an admin) and *cán bộ* (receives work). Since 2026-10-27 *cán bộ Phòng Camera* and *cán bộ hiện trường* can also create
  cases (QC lead decision overriding spec [Q4]/[Q31] — see
  [lam-ro-2026-10-27.md](requirements/specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-27.md), C1–C8, D1–D8, E1–E9, F1–F8, G1–G6, H1–H5 answered; I1 open; officers must hand cases to a team; states Chờ tiếp nhận / Đang xử lý tại Đội /
  Đang thực hiện / Chờ chỉ đạo / Đã hoàn thành / Đã đóng (no Đã huỷ). Current test scope = 2 role groups only
  (assigner vs receiver); sub-role differences (Tổ trưởng, Tổ phó…) deferred by the QC lead (F2)). Officer types are
  *hiện trường*, *Phòng Camera*, *Văn thư* (Văn thư cannot create), set as the account role in the web admin.
  Role/permission is a cross-cutting risk.
- **Personal data**: CCCD/passport scanning, names, dates of birth, passenger flight/seat, signatures. Never put
  real personal data in docs, bug reports or committed images — test data only.
- **Primary test basis:** [dac-ta-chuc-nang-v2.1.md](requirements/specs/xu-ly-vi-pham-giao-viec/dac-ta-chuc-nang-v2.1.md)
  (customer-review spec v2.1, 22/10/2026: use cases XL01–XL05, GV01–GV03, CH01–CH07, permission matrix, state
  model, business rules). It supplements the overview below and **wins on conflict** (QC lead, 2026-10-26). Its
  `[Bn]` codes are the spec's Appendix B, not the test-analysis blocking questions; `[Bn*]` are unconfirmed.
- The overview spec is
  [requirements/specs/xu-ly-vi-pham-giao-viec/mo-ta-chuc-nang-v1.md](requirements/specs/xu-ly-vi-pham-giao-viec/mo-ta-chuc-nang-v1.md)
  (exported from Google Doc 2026-10-26; the source doc stops mid-section at "Ký lại biên bản"). Always read it together
  with [lam-ro-2026-10-26.md](requirements/specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-26.md) — the QC lead's answers
  (case-action roles, re-signing, iPhone-only, mandatory fields) and its "Đối chiếu với đặc tả v2.1" section, which
  records where those answers differ from spec v2.1 — plus
  [lam-ro-2026-10-27.md](requirements/specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-27.md) (officers may create cases).

## Architecture: how a feature's documentation set fits together

Every feature has a matching folder name repeated across `requirements/specs/<feature>/` (input from dev/PM,
authoritative "test basis"), `requirements/test-plans/<feature>/` (QC-authored), and sometimes a top-level
`test-cases/<feature>/` (only for features complex enough to need test cases split out from the test plan).

**Screenshot → wireframe → exploratory checklist → test plan → bug log** is the standard pipeline for any
feature with real UI. Screenshot filenames are the source of truth for flow/screen naming everywhere else in
the repo — see `.claude/rules/screenshot-naming.md` (device folders `iphone/` and `web/` — the app currently runs on iPhone only; §7 holds the flow map,
confirmed 2026-10-26, and marks with 🚧 the flows not yet described).

## The ISTQB skill pipeline (test-analysis → test-plan → test-case)

Three skills in `.claude/skills/` implement the ISTQB Foundation Level test process end to end:
`test-analysis` ("what needs testing" — testability review + prioritized test conditions) →
`test-plan` (scope, design techniques, risk-based priority, entry/exit criteria) → `test-case` (concrete,
runnable cases). `.claude/commands/spec-intake.md` orchestrates all three for a newly-received spec — invoke
it as `/spec-intake` rather than re-deriving its logic by hand.

**Do not paraphrase these skills from memory — read the actual `SKILL.md` before running one**, they change
independently of this file. The single most important rule shared by all three: each has an explicit
**human-in-the-loop stop point** (test basis is ambiguous/contradictory, a risk level can't be justified, a
design technique doesn't fit) where the skill must stop and ask rather than silently guessing. Never skip
these stops to finish a pipeline run in one pass, even under time pressure — a wrong guess at test-analysis
propagates wrong risk levels into test-plan and wrong expected results into test-case.

The overview spec covers the whole module; split it per feature (one `requirements/specs/<feature>/` per flow in
the flow map, citing back to the overview) before running `/spec-intake`, so each pipeline run has a focused
test basis.

**Naming convention that ties the three together:** all three outputs for one delivery share one `<slug>`
in the same folder — `test-analysis-<slug>.md`, `test-plan-<slug>.md`, `test-cases-<slug>.md` — so they're
easy to find as a set and trace between. When a feature gets re-tested from a materially different spec
(not just a typo-level correction), mint a new slug rather than overwriting the old trio in place.

**Superseded docs are archived, never deleted or silently overwritten.** Rename with a `-SUPERSEDED` suffix
and add a `> ⚠️ SUPERSEDED — không dùng tài liệu này làm test basis.` banner right under the title,
explaining what replaced it and why. This preserves the reasoning trail — a later re-analysis often reuses a
superseded doc's *method* even when its specific numbers are stale.

## Bug log → GitHub issue

`bugs/bug-log.md` is the single bug log (content in Vietnamese; section headings/field keys stay English because
the scripts parse them). Issues go to **this repo** (`nhatanh410/cack_qc`) via the `github-issue-bug` skill and
`scripts/create-bug-issue.sh` (dry-run by default; `--submit` only after the user approves). **Phiên bản, Nền
tảng, Thiết bị / Trình duyệt and Tần suất must be typed by the user every run — never infer them.**
`scripts/sync-bug-status.sh` pulls open/closed status back. Setup: `docs/guides/bug-issue-setup.md`. Read the
skill's `SKILL.md` before running either script.

⚠️ As of 2026-10-26 the GitHub repo is **public** — spec images and screenshots are git-ignored for that reason.
Remind the user before any push or `--submit` until it is private.

## Memory

This project uses Claude's cross-session memory (see the system prompt's "auto memory" section when
present) to track in-progress QC work, standing user feedback, and project context that isn't derivable from
the repo itself — check it before assuming a feature's QC status from file listings alone, since a living
test-plan's own header is the fastest way to check current status but memory tracks *why* things are where
they are.
