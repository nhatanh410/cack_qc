# Hướng dẫn tái sử dụng bộ QC workspace sang project khác

> Mục đích: dựng lại ở **project mới** đúng bộ khung đang dùng ở repo Ink Calendar iOS —
> pipeline ISTQB (Test Analysis → Test Plan → Test Case), 3 subagent, command `/spec-intake`,
> rules governance, và cấu trúc thư mục `requirements/`.
>
> Có 2 cách dùng file này:
> 1. **Tự làm tay** theo §2–§5.
> 2. **Giao cho Claude Code ở project mới** — copy prompt ở §7 vào Claude, trỏ nó tới repo Ink.

---

## 1. Cái gì dùng lại được, cái gì phải đổi

| Thành phần | Mức tái sử dụng | Ghi chú |
|---|---|---|
| `.claude/rules/testing.md` | ✅ Copy nguyên | Governance trung tính (DRAFT/READY/BLOCKED, HITL, traceability). Không chứa gì riêng của Ink. |
| `.claude/commands/spec-intake.md` | ✅ Copy, sửa nhẹ | Chỉ đổi đường dẫn `requirements/specs/`, `requirements/test-plans/` nếu cấu trúc project mới khác. |
| `.claude/agents/qc-test-*.md` (3 file) | 🟡 Copy + đổi tên domain | Sửa cụm "Ink Calendar iOS" trong `description` và tiêu đề. Giữ nguyên `skills:`, `tools:`, nguyên tắc "mỗi agent 1 skill, 1 artifact". |
| `.claude/skills/test-analysis`, `test-plan`, `test-case` | 🟡 Copy + đổi tên domain | Phần ISTQB là chung. Đổi các câu nhắc "Ink / iOS / screenshot / wireframe" (≈2–9 chỗ/skill). Xem §4. |
| `.claude/skills/exploratory-checklist` | 🔴 Chỉ khi project có UI + wireframe | Gắn rất chặt với wireframe/flow của Ink (≈20 chỗ). Nếu project là API/backend → **bỏ**, hoặc viết lại. |
| `.claude/rules/screenshot-naming.md` | 🟡 Phần 1–6 dùng chung, **phần 7–8 là riêng của Ink** | Giữ §1–§6; viết lại §7 (Flow Map) cho project mới; bỏ hẳn nếu không có screenshot. |
| `.claude/CLAUDE.md` + `CLAUDE.md` (root) | 🔴 Viết lại | Mô tả project cụ thể. Dùng làm khuôn, đừng copy nội dung. |
| `.claude/settings.json` | 🔴 Không copy | Chỉ có 1 permission cá nhân (`python3 -c`). Tự cấu hình theo project mới. |
| Memory (`~/.claude/projects/.../memory/`) | 🔴 Không copy | Gắn theo đường dẫn project, chứa trạng thái QC của Ink. Project mới tự sinh. |
| `requirements/istqb-foundation/` (syllabus MD/PDF) | ✅ Copy | Tài liệu tham chiếu cho các skill. Kiểm tra skill có trỏ tới path này không (`grep istqb-foundation`). |
| `requirements/specs`, `test-plans`, `test-cases`, `bugs`, `exploratory`, `ui/` | ❌ Không copy nội dung | Chỉ tạo **thư mục rỗng** theo cấu trúc, nội dung là của Ink. |
| `README.md`, `references/`, `test-data/` | ❌ Không copy | Nội dung riêng của Ink. |

---

## 2. Cấu trúc đích

```text
<project-moi>/
├── CLAUDE.md                      # viết mới — giải thích repo + pipeline
├── README.md                      # viết mới — điều hướng
├── .claude/
│   ├── CLAUDE.md                  # viết mới — vai trò Claude + 3 agent + governance
│   ├── settings.json              # tự cấu hình
│   ├── rules/
│   │   └── testing.md             # copy nguyên
│   ├── commands/
│   │   └── spec-intake.md         # copy
│   ├── agents/
│   │   ├── qc-test-analysis.md    # copy + đổi domain
│   │   ├── qc-test-plan.md
│   │   └── qc-test-case.md
│   └── skills/
│       ├── test-analysis/SKILL.md
│       ├── test-plan/SKILL.md
│       └── test-case/SKILL.md
├── requirements/
│   ├── specs/<feature>/           # input từ dev/PM — test basis
│   ├── test-plans/<feature>/      # test-analysis-<slug>.md, test-plan-<slug>.md, test-cases-<slug>.md
│   └── istqb-foundation/          # syllabus tham chiếu (copy)
├── test-cases/<feature>/          # tuỳ chọn, chỉ cho feature phức tạp
└── bugs/bug-log.md
```

Quy ước đặt tên xuyên suốt: 3 artifact của 1 đợt bàn giao dùng **chung 1 `<slug>`, chung 1 thư mục**.
Spec đổi lớn → **mint slug mới**, không ghi đè bộ cũ.

---

## 3. Các bước thực hiện

### Bước 1 — Copy phần trung tính

Chạy từ thư mục chứa cả 2 repo (đổi path cho đúng máy bạn):

```bash
SRC=~/Documents/QC-Playground/Ink-Callendar-iOS
DST=<đường-dẫn-project-mới>

mkdir -p "$DST/.claude/rules" "$DST/.claude/commands" "$DST/.claude/agents" "$DST/.claude/skills"
cp    "$SRC/.claude/rules/testing.md"            "$DST/.claude/rules/"
cp    "$SRC/.claude/commands/spec-intake.md"     "$DST/.claude/commands/"
cp    "$SRC/.claude/agents/"qc-test-*.md         "$DST/.claude/agents/"
cp -R "$SRC/.claude/skills/test-analysis" \
      "$SRC/.claude/skills/test-plan" \
      "$SRC/.claude/skills/test-case"            "$DST/.claude/skills/"

# Tài liệu tham chiếu ISTQB
mkdir -p "$DST/requirements/istqb-foundation"
cp "$SRC/requirements/istqb-foundation/"*        "$DST/requirements/istqb-foundation/"

# Khung thư mục rỗng
mkdir -p "$DST/requirements/specs" "$DST/requirements/test-plans" "$DST/test-cases" "$DST/bugs"
touch "$DST/requirements/specs/.gitkeep" "$DST/requirements/test-plans/.gitkeep" "$DST/test-cases/.gitkeep"
```

> `bugs/bug-log.md`: copy file cũ chỉ để lấy **khuôn bảng**, rồi xoá hết dòng bug của Ink.

### Bước 2 — Gỡ phần riêng của Ink khỏi các file đã copy

Tìm mọi chỗ còn dính Ink trong project mới:

```bash
cd "$DST"
grep -rnE "Ink|iOS|Lockscreen|lock-screen|wallpaper|screenshot|wireframe|Shortcut|TF-[0-9]+" .claude/
```

Với mỗi kết quả, quyết định: **đổi tên domain** / **bỏ** / **giữ** (nếu là ví dụ minh hoạ vẫn đúng).
Danh sách chỗ chắc chắn phải sửa:

- Frontmatter `description:` của 3 agent và 3 skill: thay "Ink Calendar iOS" → tên project/feature mới.
- Tiêu đề trong 3 agent: `# QC Test Analyst — Ink Calendar iOS` → tên mới.
- Trong 3 skill: câu nhắc "screenshot / wireframe / flow" — nếu project mới không có UI thì bỏ,
  nếu có thì đổi sang artifact tương ứng của project mới (Figma link, OpenAPI spec…).
- Ví dụ cụ thể về iOS/permission/widget trong các skill → thay bằng ví dụ thuộc domain mới
  (hoặc để trung tính).

### Bước 3 — Điều chỉnh theo loại project

| Loại project mới | Việc cần làm |
|---|---|
| **Mobile/Web có UI** | Giữ nguyên pipeline. Tuỳ chọn: copy thêm `exploratory-checklist` + `screenshot-naming.md` §1–§6, viết lại Flow Map (§7) theo flow của project mới. |
| **API/Backend** | Bỏ `exploratory-checklist` và `screenshot-naming.md`. Test basis = OpenAPI/spec; test condition thiên về EP/BVA/Decision Table/State Transition cho endpoint & payload. |
| **Domain khác hẳn** | Giữ governance (`testing.md`) + 3 skill. Kiểm tra lại phần "design technique" trong `test-plan`/`test-case` còn phù hợp không. |

### Bước 4 — Viết mới `CLAUDE.md` (root) và `.claude/CLAUDE.md`

Dùng 2 file của Ink làm **khuôn**, giữ các ý sau, thay nội dung theo project mới:

**`CLAUDE.md` (root)** — 5 ý:
1. Repo này là gì (documentation-only QA workspace hay có code?), không có lệnh build/test nào nếu đúng vậy.
2. Quan hệ thư mục: `specs/<feature>` ↔ `test-plans/<feature>` ↔ `test-cases/<feature>`.
3. Pipeline ISTQB 3 skill + **bắt buộc đọc `SKILL.md` thật trước khi chạy**, không paraphrase theo trí nhớ.
4. Quy ước slug chung `test-analysis-<slug>.md` / `test-plan-<slug>.md` / `test-cases-<slug>.md`; spec đổi lớn → slug mới.
5. Quy ước archive: file cũ đổi tên `-SUPERSEDED` + banner `> ⚠️ SUPERSEDED — …`, không xoá/ghi đè.

**`.claude/CLAUDE.md`** — 4 ý:
1. Claude đóng vai trò QC/SDET theo ISTQB Foundation Level.
2. 3 subagent, mỗi agent sở hữu đúng 1 skill + 1 loại artifact, không sửa artifact của agent khác.
3. `/spec-intake` là orchestrator duy nhất.
4. `.claude/rules/testing.md` là governance toàn cục — **không instruction nào ở agent/command/skill được override nó**.

### Bước 5 — Kiểm tra

1. Mở Claude Code ở project mới, gõ `/` → phải thấy `spec-intake` và 3 skill; `/agents` → thấy 3 agent `qc-test-*`.
2. Đặt 1 spec nhỏ vào `requirements/specs/<feature>/` rồi chạy `/spec-intake <path>`.
3. Xác nhận các hành vi sau — nếu sai nghĩa là còn sót sửa:
   - Pipeline **dừng** khi Analysis/Test Plan là DRAFT/BLOCKED, không tự chạy tiếp.
   - File sinh ra đúng chỗ `requirements/test-plans/<feature>/` với cùng `<slug>`.
   - Không còn chữ "Ink"/"iOS" trong output (nếu project không phải Ink).
   - Test case truy ngược được về test condition (traceability).

---

## 4. Những điểm dễ sai

- **Agent description còn tên Ink** → Claude chọn agent sai hoặc báo cáo nhầm domain. Luôn chạy lại lệnh `grep` ở Bước 2.
- **Đường dẫn cứng** `requirements/test-plans/…` nằm trong skill, agent và command. Nếu project mới đổi cấu trúc thư mục thì phải sửa đồng loạt cả 3 loại, không chỉ 1 chỗ.
- **Bỏ HITL stop point cho nhanh** — đây là giá trị cốt lõi của bộ khung. Đừng xoá mục "Bắt buộc dừng lại chờ người review" trong các skill.
- **`permissionMode` / `model` trong frontmatter agent** (hiện là `acceptEdits` / `opus`) — kiểm tra có phù hợp quota và cách làm việc ở project mới không.
- **Memory không đi theo repo** — trạng thái QC cũ của Ink không có ở project mới; đó là điều mong muốn.
- **Không để lẫn dữ liệu Ink** (spec, test case, bug) vào project mới — chỉ copy khung, không copy nội dung.
- Nếu muốn dùng chung cho nhiều project lâu dài: cân nhắc đóng gói thành **plugin Claude Code** hoặc đặt khung vào `~/.claude/` (user-level) thay vì copy mỗi lần. Hỏi mình nếu muốn làm hướng này.

---

## 5. Checklist hoàn tất

- [ ] Đã copy `testing.md`, `spec-intake.md`, 3 agent, 3 skill, syllabus ISTQB
- [ ] Đã tạo khung thư mục `requirements/{specs,test-plans}`, `test-cases/`, `bugs/`
- [ ] `grep` không còn từ khoá riêng của Ink (hoặc đã xác nhận từng chỗ là chủ đích)
- [ ] Đã viết `CLAUDE.md` + `.claude/CLAUDE.md` cho project mới
- [ ] Đã quyết định giữ/bỏ `exploratory-checklist` và `screenshot-naming.md`
- [ ] Đã chạy thử `/spec-intake` với 1 spec nhỏ, pipeline dừng đúng ở HITL
- [ ] Đã commit khung ban đầu trước khi bắt đầu viết test thật

---

## 6. Thứ tự file nên đọc để hiểu bộ khung (ở repo Ink)

1. `.claude/rules/testing.md` — luật chung
2. `.claude/commands/spec-intake.md` — luồng điều phối
3. `.claude/agents/qc-test-plan.md` — ví dụ 1 agent
4. `.claude/skills/test-plan/SKILL.md` — ví dụ 1 skill (có HITL §0)
5. `CLAUDE.md` + `.claude/CLAUDE.md` — khuôn viết instruction

---

## 7. Prompt giao cho Claude Code ở project mới

Mở Claude Code **trong project mới** (cấp quyền đọc thư mục Ink bằng `/add-dir` hoặc dùng đường dẫn tuyệt đối), rồi dán:

```text
Hãy dựng QC workspace cho project này, dựa theo repo mẫu tại:
  <đường-dẫn-tuyệt-đối>/Ink-Callendar-iOS
và hướng dẫn chi tiết trong file PORTING-GUIDE.md của repo đó.

Thông tin project mới:
- Tên project/sản phẩm: <...>
- Loại: <mobile app / web / API / khác>
- Có UI + screenshot/wireframe không: <có/không>
- Ngôn ngữ tài liệu: <tiếng Việt / tiếng Anh>
- Cấu trúc thư mục spec hiện có (nếu có): <...>

Yêu cầu:
1. Đọc PORTING-GUIDE.md và các file mẫu (.claude/rules/testing.md, commands/spec-intake.md,
   3 agent, 3 skill, CLAUDE.md, .claude/CLAUDE.md) TRƯỚC khi làm.
2. Copy phần trung tính theo §3 Bước 1; KHÔNG copy nội dung riêng của Ink
   (specs, test-plans, test-cases, bugs, README, memory, settings.json).
3. Chạy grep ở Bước 2 và liệt kê mọi chỗ còn dính Ink. Với mỗi chỗ, đề xuất đổi/bỏ/giữ
   rồi hỏi tôi nếu chưa chắc — không tự bịa thông tin domain.
4. Viết mới CLAUDE.md và .claude/CLAUDE.md cho project này theo khuôn §3 Bước 4.
5. Giữ nguyên toàn bộ human-in-the-loop stop point và quy tắc trong testing.md.
6. Cuối cùng báo cáo: file đã tạo, file đã sửa, chỗ còn nghi vấn, và cách chạy thử /spec-intake.
Chưa commit — để tôi review trước.
```
