# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A **documentation-only QA workspace** for the iOS app **Ink: Lockscreen Calendar, Note** — not the app's
source code. There is no build, lint, or test command: every file is Markdown (plus a few standalone HTML
tools and image assets). "Testing" in this repo means writing/executing ISTQB-style test documentation, not
running an automated suite. See [README.md](README.md) for full navigation and the product architecture
summary.

## Architecture: how a feature's documentation set fits together

Every feature has a matching folder name repeated across `requirements/specs/<feature>/` (input from dev/PM,
authoritative "test basis"), `requirements/test-plans/<feature>/` (QC-authored), and sometimes a top-level
`test-cases/<feature>/` (only for features complex enough to need test cases split out from the test plan).
Three documentation bundle shapes exist depending on what evidence is available — see README.md §"Bundle
riêng..." for the two special-cased ones (remote-config/content-layer features with no UI baseline, and
architecture-first features whose UI lands on `main` later). Don't invent a fourth shape; extend one of the
three.

**Screenshot → wireframe → exploratory checklist → test plan → bug log** is the standard pipeline for any
feature with real UI. Screenshot filenames are the source of truth for flow/screen naming everywhere else in
the repo — see `.claude/rules/screenshot-naming.md` (also holds the canonical flow map, §7, including which
flows are 🚧 not yet built).

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

**Naming convention that ties the three together:** all three outputs for one delivery share one `<slug>`
in the same folder — `test-analysis-<slug>.md`, `test-plan-<slug>.md`, `test-cases-<slug>.md` — so they're
easy to find as a set and trace between. When a feature gets re-tested from a materially different spec
(not just a typo-level correction), mint a new slug rather than overwriting the old trio in place; see
`requirements/test-plans/shortcuts/` for the current example chain (`ios26-27` → `ios26-27-v2-updated` →
`ios26-27-v3`, each transition triggered by a real spec change — chip renames, action-count changes, brand
new flows).

**Superseded docs are archived, never deleted or silently overwritten.** Rename with a `-SUPERSEDED` suffix
and add a `> ⚠️ SUPERSEDED — không dùng tài liệu này làm test basis.` banner right under the title,
explaining what replaced it and why (see any `*-SUPERSEDED.md` file in `requirements/specs/shortcuts/` for
the pattern). This preserves the reasoning trail — a later re-analysis often reuses a superseded doc's
*method* (e.g. a token/branch enumeration, a Decision Table shape) even when its specific numbers are stale.

## Specs that stay checklist-only

Not every spec goes through the ISTQB pipeline. Quick release-QC checklists (e.g.
`requirements/specs/ink-1.2.20-vi.md`, `five-languages-pro-gating/`, and under
`requirements/specs/wallpaper-editor/wallpaper-customize/`: `stack-components.md`, `day-brief-vi.md`) are
run by hand and have no test-plan/test-case counterpart — don't generate one unless asked. The
`wallpaper-editor/` bundle has three generations (`component-editor/` and `wallpaper-decoration/` are
pre-TF-117 reference only); new Customize-screen docs go in `wallpaper-customize/`.

## Bug log → GitHub issue

`bugs/bug-log.md` is the single bug log. Pushing a bug to the dev source repo's issue tracker goes through
the `github-issue-bug` skill and `scripts/create-bug-issue.sh` (dry-run by default; `--submit` only after
the user approves). **Build, Bản cài, Thiết bị và iOS and Tần suất must be typed by the user every run —
never infer them.** `scripts/sync-bug-status.sh` pulls open/closed status back. Setup:
`docs/guides/bug-issue-automation-setup.md`. Read the skill's `SKILL.md` before running either script.

## Memory

This project uses Claude's cross-session memory (see the system prompt's "auto memory" section when
present) to track in-progress QC work, standing user feedback, and project context that isn't derivable from
the repo itself — check it before assuming a feature's QC status from file listings alone, since a living
test-plan's own header is the fastest way to check current status but memory tracks *why* things are where
they are.
