# Hướng dẫn: đẩy bug từ bug-log (Markdown) lên GitHub issue bằng script + skill

> File tự chứa để mang sang dự án khác: giải thích từng bước setup, kèm toàn bộ code ở phần Phụ lục.
> Được ghi nhận từ dự án Ink Calendar iOS (QC workspace), ngày 2026-10-11. Cập nhật bằng cách chạy lại script sinh file nếu code đổi.

---

## 1. Bài toán và ý tưởng

**Bài toán:** QC ghi bug ở một repo riêng (chỉ có tài liệu), còn dev theo dõi bug bằng GitHub issue ở repo source code
(thuộc chủ sở hữu khác). Dán tay từng bug vào web form thì lặp, dễ sai format, và trạng thái "đã sửa" của dev không quay về
bug-log của QC.

**Giải pháp:**

```
bugs/bug-log.md ──(QC duyệt)──► create-bug-issue.sh ──gh──► GitHub issue (repo dev)
        ▲                                                         │
        └────────────── sync-bug-status.sh ◄──────gh──────────────┘
```

- `bug-log.md` là **nguồn sự thật duy nhất** của QC.
- `create-bug-issue.sh` đọc một bug đã duyệt, dựng body đúng cấu trúc issue form, **dry-run mặc định**, chỉ tạo thật khi có `--submit`.
- `sync-bug-status.sh` đọc trạng thái issue trên GitHub rồi cập nhật cột **Status** trong bug-log (chỉ cột đó).
- **Skill** (file hướng dẫn cho Claude Code) giữ quy trình + các cổng xác nhận của con người.

**Vì sao dùng `gh` (GitHub CLI) đăng nhập tài khoản cá nhân:** đơn giản nhất, không phải lưu token trong repo, issue ghi tác giả
là chính bạn. Nếu sau này cần chạy trên CI thì thay bằng fine-grained token; script chỉ dựa vào `gh` nên ít phải sửa.

---

## 2. Yêu cầu

| Thứ | Để làm gì | Kiểm tra |
|---|---|---|
| macOS/Linux, `bash` ≥ 3.2 | chạy script (đã tránh tính năng bash 4 để chạy được trên macOS) | `bash --version` |
| `gh` (GitHub CLI) | gọi API GitHub, đăng nhập | `gh --version` (bản dùng khi viết: 2.87) |
| `awk`, `sed`, `grep`, `mktemp` | có sẵn trên macOS/Linux | — |
| Quyền **Triage hoặc Write** trên repo dev | tạo issue ở repo của người khác | hỏi chủ repo |

Không cần `jq`: phần lọc JSON dùng `gh ... -q` (jq tích hợp sẵn trong gh).

---

## 3. Setup từng bước (có giải thích)

### Bước 1 — Cài và đăng nhập `gh`

```bash
brew install gh          # macOS. Linux: xem https://github.com/cli/cli#installation
gh auth login
```

Trả lời các câu hỏi:

| Câu hỏi | Chọn | Giải thích |
|---|---|---|
| Where do you use GitHub? | `GitHub.com` | trừ khi dùng GitHub Enterprise |
| Preferred protocol | `SSH` (nếu bạn đã `git push` qua SSH) hoặc `HTTPS` | chỉ ảnh hưởng thao tác git, **không** ảnh hưởng việc tạo issue |
| Upload your SSH public key? | `Skip` nếu `ssh -T git@github.com` đã báo `Hi <tên>!` | SSH key chỉ để `git push/pull` không cần mật khẩu. Key đã có trên GitHub thì không cần upload lại |
| Authenticate Git with your GitHub credentials? | `Yes` | chỉ cấu hình git trên máy bạn, không đụng repo |
| How would you like to authenticate? | `Login with a web browser` | an toàn nhất, không phải dán token |

Terminal hiện mã 8 ký tự → Enter → trình duyệt mở → dán mã → đăng nhập **đúng tài khoản có quyền ở repo dev** → Authorize.

Kiểm tra:

```bash
gh auth status
gh repo view <owner>/<repo-dev>
```

Lỗi hay gặp: org bật **SAML SSO** → vào GitHub → Settings → Applications → Authorized OAuth Apps → `GitHub CLI` → **Grant** cho org.
Việc đăng nhập chỉ lưu thông tin trên máy bạn; nó **không** sửa code hay repo nào.

### Bước 2 — Đọc issue form thật của repo dev

Issue form là một file YAML trong repo dev. Không cần screenshot, lấy trực tiếp:

```bash
gh api repos/<owner>/<repo-dev>/contents/.github/ISSUE_TEMPLATE -q '.[].name'
gh api repos/<owner>/<repo-dev>/contents/.github/ISSUE_TEMPLATE/<file>.yml -q .content | base64 -d
```

Từ YAML, ghi lại: `labels:` mặc định, và với từng field: `label` (đây là heading trong body), `id`, `required`, và **nguyên văn các option** của dropdown.
Lý do: khi tạo issue qua CLI, form **không** được dùng; bạn chỉ gửi `title`, `body`, `labels`. Body phải mô phỏng đúng thứ GitHub tự sinh từ form:

```markdown
### <label của field 1>

<giá trị>

### <label của field 2>

<giá trị>
```

Field tuỳ chọn để trống → ghi `_No response_`. Dropdown phải điền **đúng nguyên văn** một option, nếu không dev/bot đọc sẽ lệch.

### Bước 3 — Tạo thư mục và file cấu hình

```bash
mkdir -p scripts bugs
```

Tạo `scripts/bug-issue.conf` (Phụ lục A). **Đây là file duy nhất phải sửa cho từng dự án**: `REPO`, `LABELS`, các `H_*` (heading = `label` của form),
và 3 mảng option (`INSTALL_OPTIONS`, `FREQ_OPTIONS`, `SEVERITY_OPTIONS`). Không đặt token vào file này.

### Bước 4 — Tạo thư viện đọc/sửa bug-log

Tạo `scripts/bug-log-lib.sh` (Phụ lục B). File này được `source` bởi hai script còn lại, gồm các hàm:

- `bug_section` / `bug_field` / `bug_sub`: cắt section, đọc hàng bảng field, đọc nội dung dưới một heading `###`.
- `bug_issue_title`: lấy dòng ``**Issue title:** `...` ``.
- `set_bug_field`: ghi/đổi một hàng bảng field (dùng để ghi URL issue).
- `set_bug_status`: đổi Status ở **cả** bảng Tổng hợp lẫn section chi tiết.

Script ghi file bằng cách tạo file tạm rồi `mv`, nên không bao giờ để file bị cắt dở.

### Bước 5 — Chuẩn hoá bug-log để script đọc được

Script **parse Markdown**, nên bug-log phải theo đúng cấu trúc (xem mục 4). Nếu lệch, script báo thiếu field thay vì đoán.

### Bước 6 — Tạo script tạo issue

Tạo `scripts/create-bug-issue.sh` (Phụ lục C) và `chmod +x scripts/*.sh`. Hành vi chính:

1. Kiểm tra bug tồn tại; nếu dòng `GitHub issue` đã là URL → dừng (tránh tạo trùng).
2. Nếu `gh` đã đăng nhập: tìm issue có mã `BUG-NNN` ở repo dev (`--state all`); có rồi → dừng (exit 4).
3. **4 field luôn do bạn nhập tay**: Build, Bản cài, Thiết bị và iOS, Tần suất (flag hoặc prompt khi có terminal). Không lấy từ bug-log để không dùng nhầm giá trị cũ.
4. Các field khác lấy từ bug-log; dropdown phải khớp option của form, không thì dừng (exit 3).
5. In title, labels, body. Mặc định **dry-run**; có `--submit` mới `gh issue create`.
6. Sau khi tạo: ghi URL vào dòng `GitHub issue` của bug; nhắc kéo ảnh/video vào issue thủ công (`gh` không upload được file đính kèm).
7. `--title-prefix "[TEST ...] "` thêm tiền tố vào title để dễ tìm/xoá issue thử.
8. **Chốt chặn cuối khi chạy tay:** nếu có terminal tương tác, trước khi tạo script bắt gõ lại đúng mã bug (`BUG-005`); gõ sai hoặc Enter → huỷ (exit 5), không tạo gì. Khi chạy không có terminal (ví dụ qua Claude Code) thì cổng xác nhận nằm ở skill.
9. `--allow-duplicate` bỏ qua kiểm tra trùng. Cần khi issue thử cũ (đã đóng) vẫn chứa mã bug và chặn việc đẩy bug thật. Chỉ dùng sau khi tự xem danh sách trùng.

Mã thoát: `0` ổn · `1` lỗi chung · `3` thiếu/không hợp lệ field · `4` nghi trùng · `5` người dùng huỷ ở bước gõ lại mã.

### Bước 7 — Tạo script đồng bộ trạng thái

Tạo `scripts/sync-bug-status.sh` (Phụ lục D). Ánh xạ: `CLOSED + COMPLETED → Fixed`, `CLOSED + NOT_PLANNED → Won't fix`, `OPEN →` giữ nguyên
(nếu log đang Fixed mà issue mở lại → chỉ cảnh báo). Mặc định chỉ **in đề xuất**; có `--write` mới ghi, và chỉ sửa cột Status.

### Bước 8 — Tạo skill cho Claude Code

Đặt template ở Phụ lục E vào `.claude/skills/github-issue-bug/SKILL.md` và sửa các chỗ `<...>`.
Skill không thực thi gì; nó là hướng dẫn để Claude: soạn bản nháp → chờ bạn duyệt → ghi bug-log → **hỏi bạn 4 field** → dry-run → chờ xác nhận rõ → `--submit`.
Các cổng "chờ con người" là phần quan trọng nhất, vì tạo issue là hành động nhìn thấy được bởi dev.

### Bước 9 — Kiểm thử an toàn (theo thứ tự)

```bash
bash -n scripts/*.sh                       # kiểm tra cú pháp
shellcheck scripts/*.sh                    # nếu đã cài (brew install shellcheck)

# 1) Dry-run: chưa gửi gì
scripts/create-bug-issue.sh BUG-005 --build "1.2.22 (500)" --install "TestFlight (Prod)" \
  --device "iPhone 15 Pro, iOS 26" --frequency "Luôn luôn"

# 2) Tạo 1 issue thử, có tiền tố để dễ xoá
scripts/create-bug-issue.sh BUG-005 ... --title-prefix "[TEST script push issue] " --submit

# 3) Chạy lại lệnh trên: phải bị chặn vì đã có issue (kiểm tra chống trùng)
# 4) Đóng issue thử trên GitHub, rồi:
scripts/sync-bug-status.sh                 # xem đề xuất
scripts/sync-bug-status.sh --write         # ghi
```

Dọn dẹp sau khi thử: đóng/xoá issue thử (`gh issue close <n>`; xoá hẳn `gh issue delete <n>` cần quyền admin), và **đặt lại dòng `GitHub issue` của bug
trong bug-log về `❓ not created yet`**, nếu không script sẽ báo bug đã có issue.

---

## 4. Cấu trúc bug-log bắt buộc

Mỗi bug có một dòng ở bảng Tổng hợp và một section chi tiết:

```markdown
## Tổng hợp

| ID | Date | Flow | Screen | State | Severity | Summary | Status |
|---|---|---|---|---|---|---|---|
| BUG-001 | 2026-10-09 | ... | ... | ... | Low | mô tả ngắn | Open |

## BUG-001 · Tiêu đề ngắn

| Field | Value |
|---|---|
| **Date** | 2026-10-09 |
| **Severity** | Low — UI / cosmetic |
| **Status** | Open |
| **App language** | Vietnamese and English |
| **GitHub issue** | ❓ not created yet |

**Issue title:** `[QC] [Where] What when When`

### Steps to reproduce
1. ...

### Expected
...

### Actual
...
```

Quy ước script dựa vào:
- Heading section đúng dạng `## BUG-NNN · ...`; section kết thúc ở `---` hoặc `## ` kế tiếp.
- Hàng bảng field: `| **Tên field** | giá trị |`. Status là ô **cuối** của dòng ở bảng Tổng hợp.
- Dòng `GitHub issue`: `❓ not created yet` hoặc URL `https://github.com/<owner>/<repo>/issues/<n>`. Nếu bug chưa có dòng này, script tự chèn ở cuối bảng field.
- Dòng `Frequency: ...` (nếu có) trong *Actual* chỉ là ghi chú nháp: bị loại khỏi body và **không** dùng làm field Tần suất.
- Dấu `❓` = chưa xác nhận. Field bắt buộc còn `❓` → script chặn. Riêng *Mong đợi* và *Các bước tái hiện* chỉ cảnh báo (vì có thể chưa có spec).

---

## 5. Dùng hằng ngày

1. Mô tả lỗi cho Claude → Claude soạn bản nháp theo form (skill).
2. Bạn duyệt → Claude ghi vào bug-log.
3. Claude hỏi bạn 4 field (Build, Bản cài, Thiết bị+iOS, Tần suất) → chạy dry-run → bạn xem body.
4. Bạn nói "submit" → Claude chạy lại với `--submit` → URL được ghi vào bug-log.
5. Kéo ảnh/video vào issue trên web.
6. Khi dev xử lý xong: `scripts/sync-bug-status.sh` → xem → `--write`.

Map Severity dùng ở dự án gốc (bug-log 4 mức → form 3 mức): `Critical→critical`, `High→major`, `Medium→major`, `Low→minor`.

---

## 6. Mang sang dự án khác: những chỗ phải đổi

| Chỗ | Đổi thành |
|---|---|
| `REPO`, `LABELS` trong `bug-issue.conf` | repo dev và label mặc định của form |
| `H_*` | `label` của từng field trong form mới |
| `INSTALL_OPTIONS`, `FREQ_OPTIONS`, `SEVERITY_OPTIONS` | option nguyên văn của dropdown tương ứng |
| Danh sách field trong `create-bug-issue.sh` (đoạn dựng body, danh sách `MISSING`) | thêm/bớt field theo form |
| `map_severity`, `map_frequency` | quy ước của dự án |
| Cấu trúc bug-log | giữ đúng mục 4, hoặc sửa hàm trong `bug-log-lib.sh` |
| Skill (Phụ lục E) | ngôn ngữ report, quy tắc title, map severity |

Nếu form là template `.md` cũ (không phải `.yml`), form không có dropdown/required; bạn chỉ cần dựng body theo các heading của template.

---

## 7. Xử lý sự cố

| Triệu chứng | Nguyên nhân / cách xử lý |
|---|---|
| `You are not logged into any GitHub hosts` | chạy `gh auth login` |
| `gh repo view` báo không tìm thấy repo | sai tài khoản, chưa có quyền, hoặc chưa Grant SAML SSO cho GitHub CLI |
| `--submit` bị từ chối (403) | cần quyền Triage/Write; nhờ chủ repo |
| Label không gắn được / lỗi label | label trong `LABELS` phải tồn tại ở repo dev (kiểm tra bằng `gh label list -R <repo>`) |
| Exit 3 `BLOCKED` | thiếu field bắt buộc hoặc dropdown không khớp option; làm theo danh sách script in ra |
| Exit 4 `Possible duplicate` | đã có issue chứa `BUG-NNN`; kiểm tra rồi sửa dòng `GitHub issue` thủ công nếu cần |
| `local: -n: invalid option` | đang dùng bash 3.2 (macOS) với code cần bash 4; bản trong file này đã tránh việc đó |
| `already has an issue` sau khi xoá issue thử | đặt lại dòng `GitHub issue` về `❓ not created yet` |
| Ảnh không có trong issue | `gh` không upload được file; kéo thả thủ công vào issue |

---

## 8. An toàn và giới hạn

- Tạo issue là hành động **công khai với dev** (họ nhận thông báo). Luôn dry-run trước và chỉ `--submit` khi người dùng xác nhận rõ.
- Không commit token; script không cần token vì dùng đăng nhập của `gh`.
- Script chỉ ghi ở hai chỗ: dòng `GitHub issue` và cột `Status` trong bug-log. Không sửa code, không đụng nhánh/commit/PR của repo dev.
- Không tự đóng hay sửa issue của dev.
- Việc parse Markdown dễ vỡ nếu bug-log đổi format: luôn dry-run sau khi đổi cấu trúc.
- Map Severity 4→3 mức là quy ước của QC, dev chưa xác nhận.

---

## Phụ lục A — `scripts/bug-issue.conf`

```bash
# Cấu hình cho create-bug-issue.sh / sync-bug-status.sh (được `source` bởi bash). KHÔNG đặt token ở đây.
# Nguồn: issue form "QC bug" (.github/ISSUE_TEMPLATE) của repo source, đọc ngày 2026-10-11.

# Repo source nhận issue (owner/name).
REPO="sfunvn/lockscreen-calendar"

# Bug log nguồn (đường dẫn tương đối từ gốc repo QC).
BUG_LOG="bugs/bug-log.md"

# Label mà form tự gắn (labels: trong form). Cách nhau bằng dấu phẩy.
LABELS="qc-bug,needs-triage"

# Heading trong body = `label` của từng field trong form (GitHub render thành "### <label>").
H_BUILD="Build"
H_INSTALL="Bản cài"
H_DEVICE="Thiết bị và iOS"
H_LANG="Ngôn ngữ app"
H_STEPS="Các bước tái hiện"
H_EXPECTED="Mong đợi"
H_ACTUAL="Thực tế"
H_FREQ="Tần suất"
H_SEVERITY="Mức độ"
H_ATTACH="Ảnh, video, log"

# Option của các dropdown — phải khớp NGUYÊN VĂN với form (một option mỗi phần tử).
INSTALL_OPTIONS=(
  "TestFlight (Prod)"
  "Firebase App Distribution (Dev)"
  "App Store"
  "Build local từ Xcode"
)
FREQ_OPTIONS=("Luôn luôn" "Thỉnh thoảng" "Chỉ gặp một lần")
SEVERITY_OPTIONS=(
  "critical — crash, mất dữ liệu, chặn luồng chính"
  "major — sai chức năng, có cách né"
  "minor — lỗi hiển thị, chữ, chi tiết nhỏ"
)
```

## Phụ lục B — `scripts/bug-log-lib.sh`

```bash
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
```

## Phụ lục C — `scripts/create-bug-issue.sh`

```bash
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
```

## Phụ lục D — `scripts/sync-bug-status.sh`

```bash
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
```

## Phụ lục E — template `.claude/skills/github-issue-bug/SKILL.md`

````markdown
---
name: github-issue-bug
description: Soạn bug report theo issue form của team rồi đẩy lên GitHub bằng script có cổng xác nhận. Dùng khi user nói "log bug", "tạo issue bug", "báo bug lên GitHub".
---

# Soạn và đẩy GitHub issue (template — sửa các chỗ <...>)

## Quy tắc cứng
- Một issue = một lỗi. Report viết bằng <ngôn ngữ report, vd tiếng Anh>.
- **Bốn field luôn do user nhập tay mỗi lần: Build, Bản cài, Thiết bị và iOS, Tần suất.** Không lấy từ bug-log,
  không dùng lại bug trước, không đoán từ ảnh/ghi chú. Hỏi user đủ cả 4, chờ trả lời rồi mới chạy script.
- Không bao giờ tự thêm `--submit`. Chỉ submit khi user nói rõ ("submit", "tạo đi").
- Không tự sửa hay đóng issue của dev.

## Quy trình
1. Đọc mô tả lỗi → soạn bản nháp theo từng field của form (xem bảng field trong file hướng dẫn).
2. User duyệt → ghi vào `bugs/bug-log.md` (ID `BUG-NNN` = số lớn nhất + 1; có dòng `**Issue title:**`).
3. Hỏi user 4 field nhập tay → chạy dry-run:
   `scripts/create-bug-issue.sh BUG-NNN --build V --install V --device V --frequency V [--lang V] [--severity V]`
   Exit 3 = còn thiếu field → quay lại hỏi, không đoán.
4. **Cổng xác nhận bắt buộc trước `--submit`:** hiển thị repo đích, title, labels, 4 field đã nhập, Mức độ đã map, và nói rõ
   "issue hiện công khai với dev, họ nhận thông báo". Chỉ coi là xác nhận khi user nói rõ ý đẩy lên ("submit", "tạo issue đi"…);
   "ok", "được", việc duyệt bản nháp, hay im lặng **không** tính. Xác nhận chỉ có hiệu lực cho đúng bản dry-run vừa xem —
   có thay đổi gì thì dry-run lại và xin xác nhận lại. Mỗi bug một xác nhận. Chỉ sau đó mới chạy lại với `--submit`.
5. Script tự ghi URL vào dòng `GitHub issue` của bug. Nhắc user kéo ảnh/video vào issue thủ công.
6. Đồng bộ trạng thái khi user yêu cầu: `scripts/sync-bug-status.sh` (xem đề xuất) → `--write`.

## Map Severity bug-log → Mức độ của form
<sửa theo dự án; ví dụ: Critical→critical · High/Medium→major · Low→minor>

````
