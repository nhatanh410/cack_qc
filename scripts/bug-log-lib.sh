#!/usr/bin/env bash
# Hàm dùng chung để đọc/sửa bugs/bug-log.md. Được `source`, không chạy trực tiếp.
# Cần biến BUG_LOG (đường dẫn tuyệt đối tới bug-log).

# In nguyên section của một bug (từ "## BUG-NNN" tới "---" / "## " kế tiếp).
bug_section() {
  awk -v id="$1" '
    $0 ~ "^## " id " " { p = 1; print; next }
    /^## / { p = 0 }
    /^---$/ { p = 0 }
    p' "$BUG_LOG"
}

# Giá trị của một hàng bảng field: | **<field>** | <value> |
bug_field() {
  bug_section "$1" | awk -F'|' -v f="$2" '
    $2 ~ "^ *\\*\\*" f "\\*\\* *$" { v = $3; gsub(/^ +| +$/, "", v); print v; exit }'
}

# Nội dung dưới heading "### <prefix>…" (bỏ dòng trống đầu/cuối).
bug_sub() {
  bug_section "$1" | awk -v h="### $2" '
    index($0, h) == 1 { p = 1; next }
    /^### / { p = 0 }
    p' | sed '/./,$!d' | awk 'NF { last = NR } { l[NR] = $0 } END { for (i = 1; i <= last; i++) print l[i] }'
}

# Title đã duyệt: dòng **Issue title:** `...`
bug_issue_title() {
  bug_section "$1" | sed -n 's/^\*\*Issue title:\*\* `\(.*\)`[[:space:]]*$/\1/p' | head -1
}

# Danh sách ID bug trong bảng Tổng hợp.
bug_ids() {
  grep -oE '^\| BUG-[0-9]+ ' "$BUG_LOG" | tr -d '| '
}

# Ghi/đổi một hàng bảng field trong section của bug. Chèn cuối bảng đầu tiên nếu chưa có.
set_bug_field() {
  local id="$1" field="$2" value="$3" tmp
  tmp=$(mktemp)
  awk -v id="$id" -v f="$field" -v v="$value" '
    $0 ~ "^## " id " " { sec = 1; found = 0; intable = 0; ins = 0; print; next }
    /^## / { sec = 0 }
    sec && /^\|/ {
      intable = 1
      if ($0 ~ "^\\| \\*\\*" f "\\*\\* \\|") { print "| **" f "** | " v " |"; found = 1; next }
      print; next
    }
    sec && intable && !ins && !found { print "| **" f "** | " v " |"; ins = 1 }
    { print }' "$BUG_LOG" > "$tmp"
  mv "$tmp" "$BUG_LOG"
}

# Đổi Status của bug ở CẢ bảng Tổng hợp (ô cuối) và bảng chi tiết (hàng **Status**).
set_bug_status() {
  local id="$1" status="$2" tmp
  tmp=$(mktemp)
  awk -F'|' -v OFS='|' -v id="$id" -v s="$status" '
    $0 ~ "^## " id " " { sec = 1; print; next }
    /^## / { sec = 0 }
    $0 ~ "^\\| " id " \\|" { $(NF - 1) = " " s " "; print; next }
    sec && $2 ~ /^ *\*\*Status\*\* *$/ { $3 = " " s " "; print; next }
    { print }' "$BUG_LOG" > "$tmp"
  mv "$tmp" "$BUG_LOG"
}

# Thiếu giá trị thật? (rỗng hoặc còn dấu ❓)
is_missing() {
  [[ -z "${1// /}" || "$1" == *"❓"* ]]
}
