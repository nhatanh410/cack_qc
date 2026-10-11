#!/usr/bin/env bash
# Đồng bộ Status trong bugs/bug-log.md theo trạng thái issue trên GitHub.
#
#   scripts/sync-bug-status.sh            # chỉ in thay đổi đề xuất
#   scripts/sync-bug-status.sh --write    # ghi vào bug-log (chỉ cột Status, ở bảng Tổng hợp + section chi tiết)
#
# Ánh xạ: CLOSED+COMPLETED -> Fixed · CLOSED+NOT_PLANNED -> Won't fix · OPEN -> giữ nguyên
# (nếu log đang Fixed/Won't fix mà issue OPEN lại -> chỉ cảnh báo, không tự đổi).
set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
# shellcheck source=bug-issue.conf
source "$ROOT/scripts/bug-issue.conf"
BUG_LOG="$ROOT/$BUG_LOG"
# shellcheck source=bug-log-lib.sh
source "$ROOT/scripts/bug-log-lib.sh"

WRITE=0
[[ "${1:-}" == "--write" ]] && WRITE=1

command -v gh >/dev/null || { echo "ERROR: gh is not installed" >&2; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "ERROR: gh is not logged in (run: gh auth login)" >&2; exit 1; }

CHANGES=0
for id in $(bug_ids); do
  link=$(bug_field "$id" "GitHub issue")
  [[ "$link" =~ ^https://github\.com/ ]] || continue

  cur=$(bug_field "$id" "Status")
  read -r state reason < <(gh issue view "$link" --json state,stateReason -q '"\(.state) \(.stateReason // "-")"')

  new="$cur"
  case "$state/$reason" in
    CLOSED/COMPLETED) new="Fixed" ;;
    CLOSED/NOT_PLANNED) new="Won't fix" ;;
    CLOSED/*) echo "WARN  $id: closed with unmapped reason '$reason' — left as '$cur'" >&2 ;;
    OPEN/*) [[ "$cur" == "Fixed" || "$cur" == "Won't fix" ]] && echo "WARN  $id: issue is OPEN again but log says '$cur' — review manually" >&2 ;;
  esac

  if [[ "$new" != "$cur" ]]; then
    echo "$id: $cur -> $new  ($link)"
    CHANGES=$((CHANGES + 1))
    [[ $WRITE -eq 1 ]] && set_bug_status "$id" "$new"
  fi
done

if [[ $CHANGES -eq 0 ]]; then
  echo "No status changes."
elif [[ $WRITE -eq 0 ]]; then
  echo "$CHANGES change(s) proposed. Re-run with --write to apply."
else
  echo "$CHANGES change(s) written to $BUG_LOG."
fi
