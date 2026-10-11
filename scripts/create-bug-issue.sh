#!/usr/bin/env bash
# Tạo GitHub issue (repo source, form "QC bug") từ một bug đã được duyệt trong bugs/bug-log.md.
#
#   scripts/create-bug-issue.sh BUG-005 [--build V] [--install V] [--device V] [--lang V]
#                                       [--frequency V] [--severity V] [--title-prefix P] [--submit]
#
# Mặc định là dry-run: chỉ in title/labels/body. Chỉ tạo issue thật khi có --submit.
# 4 field PHẢI do người dùng nhập tay mỗi lần chạy, không lấy từ bug-log và không đoán: Build, Bản cài,
# Thiết bị và iOS, Tần suất. Truyền bằng flag; nếu chạy trong terminal tương tác mà thiếu thì script hỏi trực tiếp.
# Không có giá trị (vd chạy qua Claude Code, không có TTY) -> dừng exit 3 và liệt kê field cần nhập.
# Các field còn lại lấy từ bug-log; thiếu, còn ❓ (trừ Mong đợi) hoặc dropdown không khớp option -> dừng (exit 3).
#   --install   TestFlight (Prod) | Firebase App Distribution (Dev) | App Store | Build local từ Xcode
#   --frequency Luôn luôn | Thỉnh thoảng | Chỉ gặp một lần   (hoặc always | sometimes | once)
#   --allow-duplicate bỏ qua kiểm tra trùng (vd issue cũ chứa mã bug chỉ là issue thử đã đóng). Dùng khi đã tự xem danh sách trùng.
#   --title-prefix P  thêm P vào ĐẦU title (vd "[TEST script push issue] ") để dễ tìm và xoá issue thử
#   --severity  critical | major | minor   (mặc định suy từ Severity trong bug-log, xem map_severity)
set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
# shellcheck source=bug-issue.conf
source "$ROOT/scripts/bug-issue.conf"
BUG_LOG="$ROOT/$BUG_LOG"
# shellcheck source=bug-log-lib.sh
source "$ROOT/scripts/bug-log-lib.sh"

die() { echo "ERROR: $1" >&2; exit "${2:-1}"; }

# Trả về option nguyên văn nếu $1 khớp (đúng hoặc là tiền tố), rỗng nếu không. $2... = các option (bash 3.2: không dùng nameref).
pick_option() {
  local v="$1" o
  shift
  for o in "$@"; do
    if [[ "$o" == "$v" || "$o" == "$v "* ]]; then echo "$o"; return; fi
  done
}

# Severity trong bug-log (Critical/High/Medium/Low) -> mức của form. Quy ước tạm, user duyệt ở dry-run.
map_severity() {
  case "$(tr '[:upper:]' '[:lower:]' <<<"$1")" in
    critical*) echo "critical" ;;
    high* | medium*) echo "major" ;;
    low*) echo "minor" ;;
  esac
}

# Chuyển cách ghi tần suất tự do sang option của form.
map_frequency() {
  case "$(tr '[:upper:]' '[:lower:]' <<<"$1")" in
    always* | "luôn luôn"*) echo "Luôn luôn" ;;
    sometimes* | intermittent* | [0-9]*/[0-9]* | "thỉnh thoảng"*) echo "Thỉnh thoảng" ;;
    once* | "one time"* | "chỉ gặp một lần"*) echo "Chỉ gặp một lần" ;;
  esac
}

# Hỏi tay một field khi có terminal tương tác. $1 = tên field, $2.. = gợi ý (option).
prompt_field() {
  local name="$1" v
  shift
  [[ -t 0 && -t 2 ]] || return 0
  { echo; echo "Nhập $name (bắt buộc):"; [[ $# -eq 0 ]] || printf '  - %s\n' "$@"; } >&2
  read -r -p "> " v
  printf '%s' "$v"
}

ID="${1:-}"
[[ "$ID" =~ ^BUG-[0-9]+$ ]] || die "Usage: $0 BUG-NNN [--build V] [--install V] [--device V] [--lang V] [--frequency V] [--severity V] [--title-prefix P] [--allow-duplicate] [--submit]"
shift

BUILD="" INSTALL="" DEVICE="" LANG_APP="" FREQ="" SEVERITY="" TITLE_PREFIX="" ALLOW_DUP=0 SUBMIT=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    --build) BUILD="${2:?}"; shift 2 ;;
    --install) INSTALL="${2:?}"; shift 2 ;;
    --device) DEVICE="${2:?}"; shift 2 ;;
    --lang) LANG_APP="${2:?}"; shift 2 ;;
    --frequency) FREQ="${2:?}"; shift 2 ;;
    --severity) SEVERITY="${2:?}"; shift 2 ;;
    --title-prefix) TITLE_PREFIX="${2:?}"; shift 2 ;;
    --allow-duplicate) ALLOW_DUP=1; shift ;;
    --submit) SUBMIT=1; shift ;;
    *) die "Unknown option: $1" ;;
  esac
done

command -v gh >/dev/null || die "gh is not installed"

[[ -n "$(bug_section "$ID")" ]] || die "$ID not found in $BUG_LOG"

HAS_AUTH=1
gh auth status >/dev/null 2>&1 || HAS_AUTH=0
if [[ $SUBMIT -eq 1 && $HAS_AUTH -eq 0 ]]; then die "gh is not logged in (run: gh auth login)"; fi

# Đã tạo rồi?
CURRENT_LINK=$(bug_field "$ID" "GitHub issue")
if [[ "$CURRENT_LINK" =~ ^https://github\.com/ ]]; then
  die "$ID already has an issue: $CURRENT_LINK"
fi

# Chống trùng theo mã bug (chỉ kiểm được khi đã đăng nhập).
if [[ $HAS_AUTH -eq 1 ]]; then
  DUP=$(gh issue list -R "$REPO" --state all --search "$ID in:title,body" --json number,title,url -q '.[] | "#\(.number) \(.title) \(.url)"')
  if [[ -n "$DUP" && $ALLOW_DUP -eq 1 ]]; then
    echo "WARN: --allow-duplicate: ignoring existing issue(s):"$'\n'"$DUP" >&2
  elif [[ -n "$DUP" ]]; then
    die "Possible duplicate on $REPO:"$'\n'"$DUP"$'\n'"(If these are only closed test issues, re-run with --allow-duplicate.)" 4
  fi
else
  echo "WARN: gh not logged in — duplicate check skipped." >&2
fi

TITLE=$(bug_issue_title "$ID")
[[ -n "$TITLE" ]] || die "$ID has no '**Issue title:** \`...\`' line — approve a report through the github-issue-bug skill first." 3
[[ "$TITLE" == "[QC] "* ]] || TITLE="[QC] $TITLE"
TITLE="${TITLE_PREFIX}${TITLE}"

# Build / Bản cài / Thiết bị / Tần suất: chỉ từ flag hoặc nhập tay (prompt). Ngôn ngữ app (tuỳ chọn) lấy từ bug-log.
[[ -n "$BUILD" ]] || BUILD=$(prompt_field "$H_BUILD")
[[ -n "$INSTALL" ]] || INSTALL=$(prompt_field "$H_INSTALL" "${INSTALL_OPTIONS[@]}")
[[ -n "$DEVICE" ]] || DEVICE=$(prompt_field "$H_DEVICE")
[[ -n "$FREQ" ]] || FREQ=$(prompt_field "$H_FREQ" "${FREQ_OPTIONS[@]}")
[[ -n "$LANG_APP" ]] || LANG_APP=$(bug_field "$ID" "App language")

STEPS=$(bug_sub "$ID" "Steps to reproduce")
EXPECTED=$(bug_sub "$ID" "Expected")
ACTUAL_RAW=$(bug_sub "$ID" "Actual")

# Dòng "Frequency: ..." trong phần Actual của bug-log chỉ là ghi chú nháp -> bỏ khỏi Thực tế, KHÔNG dùng làm Tần suất.
ACTUAL=$(grep -ivE '^Frequency:' <<<"$ACTUAL_RAW" | sed '/./,$!d' || true)

MISSING=()

is_missing "$BUILD" && MISSING+=("$H_BUILD (--build) — user must enter it")

INSTALL_OPT=""
if is_missing "$INSTALL"; then MISSING+=("$H_INSTALL (--install) — user must enter it")
else
  INSTALL_OPT=$(pick_option "$INSTALL" "${INSTALL_OPTIONS[@]}")
  [[ -n "$INSTALL_OPT" ]] || MISSING+=("$H_INSTALL: '$INSTALL' is not a form option (${INSTALL_OPTIONS[*]/#/| })")
fi

is_missing "$DEVICE" && MISSING+=("$H_DEVICE (--device) — user must enter it")
[[ -n "$STEPS" ]] || MISSING+=("$H_STEPS")
# Mong đợi: cho phép nội dung ❓ (chưa có spec) nhưng không được rỗng.
[[ -n "$EXPECTED" ]] || MISSING+=("$H_EXPECTED")
[[ -n "$ACTUAL" ]] || MISSING+=("$H_ACTUAL")

FREQ_OPT=""
if is_missing "$FREQ"; then
  MISSING+=("$H_FREQ (--frequency) — user must enter it")
else
  FREQ_OPT=$(pick_option "$FREQ" "${FREQ_OPTIONS[@]}")
  [[ -n "$FREQ_OPT" ]] || FREQ_OPT=$(pick_option "$(map_frequency "$FREQ")" "${FREQ_OPTIONS[@]}")
  [[ -n "$FREQ_OPT" ]] || MISSING+=("$H_FREQ: '$FREQ' does not map to a form option (--frequency)")
fi

SEV_KEY="${SEVERITY:-$(map_severity "$(bug_field "$ID" "Severity")")}"
SEV_OPT=""
if [[ -z "$SEV_KEY" ]]; then MISSING+=("$H_SEVERITY (--severity critical|major|minor)")
else
  SEV_OPT=$(pick_option "$SEV_KEY" "${SEVERITY_OPTIONS[@]}")
  [[ -n "$SEV_OPT" ]] || MISSING+=("$H_SEVERITY: '$SEV_KEY' is not critical|major|minor")
fi

# ❓ trong Steps/Mong đợi không chặn (đúng quy tắc skill) nhưng phải để user thấy trước khi submit.
for pair in "$H_STEPS:$STEPS" "$H_EXPECTED:$EXPECTED"; do
  [[ "${pair#*:}" != *"❓"* ]] || echo "WARN: '${pair%%:*}' still contains ❓ — confirm with the user before --submit." >&2
done

BODY=$(mktemp)
trap 'rm -f "$BODY"' EXIT
field() { printf '### %s\n\n%s\n\n' "$1" "${2:-_No response_}"; }
{
  field "$H_BUILD" "$BUILD"
  field "$H_INSTALL" "${INSTALL_OPT:-$INSTALL}"
  field "$H_DEVICE" "$DEVICE"
  if is_missing "$LANG_APP"; then field "$H_LANG" ""; else field "$H_LANG" "$LANG_APP"; fi
  field "$H_STEPS" "$STEPS"
  field "$H_EXPECTED" "$EXPECTED"
  field "$H_ACTUAL" "$ACTUAL"
  field "$H_FREQ" "${FREQ_OPT:-$FREQ}"
  field "$H_SEVERITY" "${SEV_OPT:-$SEV_KEY}"
  field "$H_ATTACH" ""
  printf '<!-- QC-ID: %s -->\n' "$ID"
} > "$BODY"

echo "=== $ID → $REPO ($([[ $SUBMIT -eq 1 ]] && echo SUBMIT || echo DRY-RUN)) ==="
echo "Title : $TITLE"
echo "Labels: ${LABELS:-<none>}"
echo "-------- body --------"
cat "$BODY"
echo "----------------------"

if [[ ${#MISSING[@]} -gt 0 ]]; then
  echo "BLOCKED — missing or unconfirmed (❓):" >&2
  printf '  - %s\n' "${MISSING[@]}" >&2
  exit 3
fi

if [[ $SUBMIT -ne 1 ]]; then
  echo "Dry-run only. Severity maps from bug-log '$(bug_field "$ID" "Severity")' -> '$SEV_KEY' unless --severity was given; confirm with the user, then re-run with --submit."
  exit 0
fi

# Chốt chặn cuối cho lần chạy tay: nếu có terminal tương tác, phải gõ lại đúng mã bug mới tạo issue.
# (Khi chạy không có terminal, ví dụ qua Claude Code, cổng xác nhận nằm ở skill — xem SKILL.md.)
if [[ -t 0 ]]; then
  echo "About to create a PUBLIC-to-dev issue on $REPO. Type $ID to confirm (anything else cancels):" >&2
  read -r -p "> " CONFIRM || CONFIRM=""
  [[ "$CONFIRM" == "$ID" ]] || die "Cancelled — nothing was created." 5
fi

ARGS=(-R "$REPO" -t "$TITLE" -F "$BODY")
[[ -z "$LABELS" ]] || ARGS+=(-l "$LABELS")
URL=$(gh issue create "${ARGS[@]}")
set_bug_field "$ID" "GitHub issue" "$URL"

echo "Created: $URL"
echo "Recorded in $BUG_LOG ($ID → GitHub issue)."
echo "TODO (manual): drag the screenshots/videos into the issue's '$H_ATTACH' section — gh cannot upload attachments."
