# Ink Calendar iOS — QA Workspace

Đây **không phải** repo chứa source code của app. Đây là workspace tài liệu QA cho **Ink: Lockscreen
Calendar, Note** (iOS) — nơi dựng wireframe từ screenshot thật, viết checklist khám phá, lập test plan, và
theo dõi bug — dùng làm đầu vào cho PRD, spec kỹ thuật, và các phiên kiểm thử.

---

## Bắt đầu từ đâu

| Muốn làm gì | Vào đây |
|---|---|
| Hiểu tổng quan sản phẩm hoạt động ra sao | [`requirements/ui/ux/wideframes/README.md`](requirements/ui/ux/wideframes/README.md) — bản đồ toàn app + kiến trúc sản phẩm |
| Xem UI thật của 1 màn hình / flow | [`requirements/ui/ux/screenshots/`](requirements/ui/ux/screenshots/) — ảnh gốc, tách theo `iphone/` · `ipad/` |
| Đọc phân tích UI đã dựng thành wireframe | [`requirements/ui/ux/wideframes/`](requirements/ui/ux/wideframes/) — 1 file / flow |
| Chạy 1 phiên khám phá (exploratory) | [`requirements/exploratory/`](requirements/exploratory/) — checklist theo flow, có ID trích dẫn khi báo bug |
| Lập test plan cho 1 build cụ thể | [`requirements/test-plans/`](requirements/test-plans/) — theo chuẩn ISTQB Foundation |
| Đọc test plan cho luồng Định danh/Chia sẻ/Đồng bộ/Sao lưu (Ink Login & Sharing) | [`requirements/test-plans/ink-identity-sync-flow/ink-identity-sync-flow-test-plan.md`](requirements/test-plans/ink-identity-sync-flow/ink-identity-sync-flow-test-plan.md) — kiến trúc backend + vòng hỏi-đáp dev + UI/UX thật đã lên `main`, gộp trong 1 tài liệu sống |
| Đọc test case chi tiết (ISTQB) cho feature không có UI baseline | [`test-cases/`](test-cases/) — case ID, tiền điều kiện, test data, expected result, traceability về test plan |
| Xem bằng chứng test đã chạy (screenshot đối chiếu từng case) + báo cáo giữa kỳ | [`requirements/test-plans/paywall-remote-config/paywall-remote-config-payloads/screenshots/README.md`](requirements/test-plans/paywall-remote-config/paywall-remote-config-payloads/screenshots/README.md) — log PASS/FAIL kèm ảnh, Interim Test Summary Report |
| Đọc change note / PRD gốc từ dev | [`requirements/specs/`](requirements/specs/) |
| Tra cứu quyền hệ thống app cần | [`references/permissions-matrix.md`](references/permissions-matrix.md) |
| Hiểu rủi ro xuyên suốt sản phẩm + mindset QC | [`references/exploratory-references.md`](references/exploratory-references.md) |
| Xem bug đang mở | [`bugs/bug-log.md`](bugs/bug-log.md) |
| Đẩy bug lên GitHub issue của repo source / đồng bộ trạng thái về bug log | [`docs/guides/bug-issue-automation-setup.md`](docs/guides/bug-issue-automation-setup.md) — skill `github-issue-bug` + `scripts/` |
| Dựng lại bộ khung QC này cho project khác | [`PORTING-GUIDE.md`](PORTING-GUIDE.md) |
| Đặt tên file khi thêm screenshot mới | [`.claude/rules/screenshot-naming.md`](.claude/rules/screenshot-naming.md) |

---

## Cấu trúc thư mục

```
.
├── requirements/
│   ├── ui/ux/
│   │   ├── screenshots/       ← ảnh gốc, nguồn của mọi thứ bên dưới
│   │   │   ├── iphone/        ← 1 folder / flow, index.md tra ngược IMG_xxxx
│   │   │   └── ipad/          ← cùng flow-no với iPhone, để đối chiếu song song
│   │   ├── wideframes/        ← wireframe dựng từ screenshot, 1 file / flow
│   │   └── end-user-perspectives/  (chưa dùng)
│   ├── exploratory/           ← checklist khám phá, 1 file / flow, ID dạng `<PREFIX>-H01`; thêm
│   │                             `release-<version>-checklist.md` (checklist chạy nhanh theo bản release)
│   ├── test-plans/            ← test plan ISTQB, 1 folder / feature — mỗi folder đặt tên trùng với
│   │   │                         folder cùng feature trong specs/ và test-cases/
│   │   ├── ai-assistant/
│   │   ├── ai-photo-pro-picks-setup/     ← bộ ISTQB đủ 3 file (slug `pr317`) + screenshots/
│   │   ├── share-template-link/          ← bộ ISTQB đủ 3 file (slug `1-2-19`) + answers dev + screenshots/
│   │   ├── wallpaper-editor/             ← bundle riêng, xem mục dưới (gộp component-editor + decoration cũ)
│   │   │   ├── component-editor/         ← phiên bản trước TF-117, giữ để ref (README banner trong folder)
│   │   │   ├── wallpaper-decoration/     ← trước đây `decoration-inkai/`, cùng lý do trên
│   │   │   └── wallpaper-customize/      ← bộ hiện hành, sau khi 2 editor gộp thành màn Customize
│   │   ├── ink-identity-sync-flow/       ← bundle riêng, xem mục dưới
│   │   ├── login-and-calendar-sharing/   ← bundle riêng, xem mục dưới
│   │   ├── matrix-guide-l10n/
│   │   ├── paywall-remote-config/        ← bundle riêng, xem mục dưới (kèm payloads/ test data)
│   │   ├── pr-218-225/
│   │   ├── shortcuts/
│   │   └── uiux-9sep/
│   ├── specs/                 ← change note / PRD / runbook gốc từ dev (input, không phải QA tự viết)
│   │                             — cùng bộ folder theo feature như test-plans/ ở trên. Một số spec chỉ là
│   │                             checklist QC chạy nhanh theo bản release (không có test-plan/test-case đi kèm):
│   │                             file lẻ `ink-1.2.20-vi.md`, `paywall-components-decorate-shortcut-vi.md`…,
│   │                             folder `five-languages-pro-gating/`, `home-widgets/`, và
│   │                             `wallpaper-editor/wallpaper-customize/{stack-components,day-brief-vi}.md`
│   └── mermaid-flowchart/     ← sơ đồ Mermaid minh hoạ riêng cho bundle `login-and-calendar-sharing`
│                                  (không phải nguồn sự thật độc lập, xem README trong đó)
├── test-cases/                 ← test case ISTQB chi tiết (ID, tiền điều kiện, test data, expected result,
│   │                              traceability) — cho feature phức tạp/không có ảnh baseline, tách khỏi test-plans/
│   ├── ink-identity-sync-flow/
│   ├── login-and-calendar-sharing/
│   ├── paywall-remote-config/
│   └── pr-218-225/
├── references/                ← tài liệu tham chiếu dùng chung mọi flow
│   ├── exploratory-references.md   ← khung 9 câu hỏi mindset QC + rủi ro xuyên suốt sản phẩm
│   ├── permissions-matrix.md       ← mọi quyền iOS app cần, ma trận hỏng khi bị từ chối
│   └── shortcut-flow-cases.md      ← đào sâu flow rủi ro nhất (Shortcut Setup)
├── bugs/
│   └── bug-log.md             ← 1 file duy nhất cho toàn bộ bug, sort theo ngày
├── scripts/                   ← đẩy bug-log → GitHub issue (`create-bug-issue.sh`, dry-run mặc định) và đồng bộ
│                                 trạng thái về (`sync-bug-status.sh`); cấu hình ở `bug-issue.conf`
├── docs/
│   ├── guides/                ← hướng dẫn setup (bug-issue-automation-setup.md)
│   └── proposals/             ← đề xuất gửi review (bản đã ẩn thông tin nội bộ)
├── PORTING-GUIDE.md           ← cách tái sử dụng bộ khung QC này cho project khác
├── CLAUDE.md                  ← hướng dẫn cho Claude Code ở gốc repo
└── .claude/
    ├── CLAUDE.md                       ← tóm tắt pipeline + trỏ tới rules/testing.md
    ├── rules/
    │   ├── testing.md                  ← governance toàn cục: pipeline, DRAFT/READY/BLOCKED, human-in-the-loop
    │   └── screenshot-naming.md        ← quy tắc đặt tên file/folder screenshot + flow map
    ├── agents/                         ← qc-test-analysis · qc-test-plan · qc-test-case (mỗi agent 1 skill, 1 loại artifact)
    ├── commands/spec-intake.md         ← `/spec-intake`: điều phối cả 3 agent cho spec mới
    └── skills/                         ← test-analysis · test-plan · test-case · exploratory-checklist · github-issue-bug
```

`end-user-perspectives/` đang **để trống** (cũng như `test-cases/component-editor/` và `specs/component-editor/`
ở gốc — folder cũ trước khi gộp vào `wallpaper-editor/`, chưa dọn) — dự trù cho sau, chưa có nội dung.

Mỗi feature có 1 folder cùng tên lặp lại ở `specs/`, `test-plans/`, `test-cases/` (khi có) — kể cả feature
chỉ có 1 file vẫn nằm trong folder riêng, để tên feature luôn khớp nhau ở cả 3 nơi.

**Lưu ý khi thêm feature login/sharing mới:** `login-and-calendar-sharing/` và `ink-identity-sync-flow/`
là **2 thế hệ tài liệu độc lập, không thay thế nhau** — thế hệ đầu dựa trên Draft PRD viết theo kiểu
shift-left trước khi feature build, thế hệ sau viết từ kiến trúc backend thật đã ship và **chủ động không**
đối chiếu thế hệ trước. Đừng gộp 2 bundle này khi thêm tài liệu mới — thêm vào folder tương ứng, và hỏi
dev/PM nếu chưa rõ thế hệ nào còn hiệu lực cho phần bạn đang viết.

**Lưu ý khi thêm tài liệu cho `wallpaper-editor/`:** đây là 1 folder cha gộp **3 thế hệ** của cùng 1 màn
hình sửa wallpaper — `component-editor/` (nút Components, trước TF-117) và `wallpaper-decoration/` (chip
Decorate, trước TF-117, tên cũ `decoration-inkai`) là **tài liệu cũ, chỉ dùng để tham khảo** (method, số
liệu, bug đã fix) kể từ khi dev gộp 2 editor thành 1 màn **Customize** (Layout | Decorate) ở TF-117; mỗi
folder cũ có README banner ghi rõ điều này. Bộ tài liệu **đang chạy** cho màn Customize nằm ở
`wallpaper-customize/` — thêm test-analysis/test-plan/test-case mới cho spec TF-117 (và các đợt sau) vào
đây, **không** viết tiếp vào 2 folder cũ. Spec/checklist QC cho component mới thêm qua nút **+** (ví dụ
`stack-components.md`, `day-brief-vi.md`) cũng đặt cạnh nhau ở `specs/wallpaper-editor/wallpaper-customize/`.

### Bundle riêng cho feature dạng remote-config/content-layer

Feature không có UI baseline bằng ảnh (QC không có quyền vào code, logic decoder cố định trong binary, chỉ
data JSON đổi qua Firebase) đi theo một bộ tài liệu đầy đủ hơn, ví dụ **Paywall Remote Config**
(`pro_paywall_config_v1`):

```
requirements/specs/paywall-remote-config/paywall-config.md              ← runbook kỹ thuật chính thức (nguồn thẩm quyền cao nhất)
requirements/specs/paywall-remote-config/paywall-qc-vi.md               ← hướng dẫn setup Firebase RC + checklist thao tay
requirements/specs/paywall-remote-config/paywall-config-builder.html    ← tool dựng payload, mirror lại logic decoder
requirements/test-plans/paywall-remote-config/paywall-remote-config-strategy.md   ← Test Strategy (ISTQB) — vì sao chọn cách tiếp cận này
requirements/test-plans/paywall-remote-config/paywall-remote-config.md            ← Test Plan (ISTQB) — làm gì/khi nào/ai làm
test-cases/paywall-remote-config/paywall-remote-config.md                          ← Test Case (ISTQB) — 75 case chi tiết
requirements/test-plans/paywall-remote-config/paywall-remote-config-payloads/      ← test data: 32 file JSON dán thẳng vào Firebase Console
  └── screenshots/README.md                                             ← bằng chứng chạy thật + Interim Test Summary Report
requirements/test-plans/paywall-remote-config/paywall-remote-config-questions-for-dev.md  ← câu hỏi vượt thẩm quyền QC, gộp gửi dev 1 lần
bugs/bug-log.md                                                          ← bug phát hiện được log kèm Flow `08_paywall`
```

### Bundle riêng cho luồng cần đối chiếu ngược nhiều vòng với dev + UI thật ra sau

Feature mà QC chỉ có **tài liệu kiến trúc** (backend, chưa/đang có UI) — không có screenshot để dựng wireframe
theo quy trình chuẩn, và cần vòng hỏi-đáp trực tiếp với dev (đối chiếu code thật) trước khi UI lên `main`. Ví
dụ **Ink Identity, Sharing, Sync, Backup** (kiến trúc final trước release):

```
requirements/specs/ink-identity-sync-flow/ink-share-last-update/
  ink-identity-sync-flow.html                                  ← kiến trúc backend (nguồn duy nhất, đọc độc lập — không đối chiếu spec sharing cũ khác trong repo, xem `login-and-calendar-sharing/`)
requirements/test-plans/ink-identity-sync-flow/ink-identity-sync-flow-test-plan.md    ← Test Plan (ISTQB) — phân tích cơ chế từng phần, decision table,
                                                                   state transition, risk-based priority; SỐNG THEO THỜI GIAN:
                                                                   mục 1–11 = phân tích thuần từ tài liệu kiến trúc,
                                                                   mục 12 = cập nhật sau khi dev trả lời (code thật),
                                                                   mục 13 = tích hợp UI/UX thật khi feature lên `main`
requirements/test-plans/ink-identity-sync-flow/ink-identity-sync-flow-open-questions-for-dev.md  ← câu hỏi vượt phạm vi tài liệu, gộp gửi dev — nhiều vòng, đánh số tiếp nối (Q1–Q17 vòng 1, Q18+ vòng 2)
requirements/test-plans/ink-identity-sync-flow/ink-identity-sync-flow-answers-from-dev.md        ← câu trả lời trực tiếp từ dev, trích code thật (file/line), phát hiện thêm nợ kỹ thuật ngoài câu hỏi
requirements/test-plans/ink-identity-sync-flow/qc-sharing-account-pro.md                         ← bàn giao QC cho UI/UX thật đã lên `main` (PR cụ thể) — tích hợp thẳng vào mục 13 của test plan, không tách file riêng
requirements/specs/ink-identity-sync-flow/login-backup-share-sync.md                             ← tài liệu tham chiếu hệ thống, verified against `main` — nguồn thẩm quyền cao nhất khi có xung đột, tích hợp vào mục 14
test-cases/ink-identity-sync-flow/                                        ← Test Case (ISTQB) chốt tại 1 thời điểm — tách theo flow (10 file + README), rút ra từ đúng test plan sống ở trên; không tự sống theo thời gian như test plan — khi test plan đổi mạnh, quay lại sinh lại bộ này
```

**Nguyên tắc riêng của bundle này:** test plan là **tài liệu sống**, không viết 1 lần rồi đóng băng — mỗi
vòng hỏi-đáp hoặc mỗi lần UI thật lên `main` đều **quay lại sửa đúng file test plan gốc** (thêm mục mới, đóng
câu hỏi cũ, nâng/hạ mức ưu tiên rủi ro theo bằng chứng mới), giữ toàn bộ vòng đời tính năng — từ kiến trúc tới
UI thật — trong 1 nơi duy nhất, có thể lần lại lịch sử suy luận. Bộ test case (`test-cases/ink-identity-sync-flow/`)
là ảnh chụp **thực thi được** của test plan tại 1 mốc thời gian — chỉ giữ bản chốt hiện tại của mỗi case (case
lỗi thời bị loại, xem mục "Case đã loại bỏ" trong `00-README.md` của bộ đó), không mang theo lịch sử suy luận
như test plan.

---

## Quy trình làm việc

```
Screenshot thật (iphone/ + ipad/)
        │
        ▼
Wireframe  (requirements/ui/ux/wideframes/<NN>_<flow>.md)
        │   — chỉ mô tả những gì NHÌN THẤY trong ảnh, thiếu thì ghi "Possible missing screen", không bịa
        ▼
Exploratory checklist  (requirements/exploratory/<NN>_<flow>.md)
        │   — mỗi mục phải quan sát được, có ID để trích dẫn khi báo bug
        │   — sinh bằng skill `/exploratory-checklist`, hoặc tay theo cùng chuẩn
        ▼
Test plan theo build  (requirements/test-plans/<feature>/test-plan-<slug>.md)
        │   — chuẩn ISTQB: test basis → scope → kỹ thuật thiết kế case → risk-based priority → entry/exit
        ▼
Bug log  (bugs/bug-log.md)
            — khi phát hiện sai khác, log kèm Flow/Screen theo đúng tên trong screenshot-naming.md
        │
        ▼
GitHub issue  (repo source, form "QC bug")  — skill `github-issue-bug` soạn nội dung, `scripts/create-bug-issue.sh`
            đẩy lên sau khi người dùng duyệt; `scripts/sync-bug-status.sh` kéo trạng thái đóng/mở về bug-log
```

**Nguyên tắc xuyên suốt:** mọi kết luận phải truy được về bằng chứng (ảnh, change note, hoặc quan sát thật
trên máy) — không suy diễn khi thiếu dữ liệu, ghi rõ *coverage gap* thay vì đoán.

**Bước "Test plan theo build" ở trên thực chất là 3 skill ISTQB riêng, chạy nối tiếp:**
[test-analysis](.claude/skills/test-analysis/SKILL.md) ("cái gì cần test" — testability + test condition đã
ưu tiên hoá) → [test-plan](.claude/skills/test-plan/SKILL.md) (scope, kỹ thuật thiết kế, risk-based priority,
entry/exit) → [test-case](.claude/skills/test-case/SKILL.md) (case cụ thể chạy được ngay). Với spec mới nhận,
chạy `/spec-intake` để tự điều phối cả 3 thay vì gọi tay từng skill — lệnh này tôn trọng đúng mọi điểm dừng
human-in-the-loop mà từng skill quy định, không tự đoán khi test basis mơ hồ/mâu thuẫn hay thiếu căn cứ risk.

3 file đầu ra dùng chung **1 `<slug>`** trong cùng thư mục — `test-analysis-<slug>.md`,
`test-plan-<slug>.md`, `test-cases-<slug>.md` — để luôn tra ngược được thành bộ. Khi spec đổi đủ lớn (đổi tên
UI, đổi hành vi cốt lõi, thêm luồng mới — không phải chỉ sửa lỗi chính tả), lập `<slug>` mới thay vì ghi đè bộ
cũ; **file cũ bị thay thế thì đổi tên thêm hậu tố `-SUPERSEDED` + banner giải thích ở đầu file, không xoá** —
xem `requirements/test-plans/shortcuts/` (chuỗi `ios26-27` → `ios26-27-v2-updated` → `ios26-27-v3`) làm ví dụ.

**Biến thể cho feature không có UI baseline** (remote-config/content layer, QC không có quyền vào code):
bỏ qua bước wireframe-từ-ảnh, thay bằng chuỗi
`spec/runbook → test strategy → test plan → test case chi tiết (test-cases/) → test data (fixture JSON) →
screenshot bằng chứng khi chạy thật → bug log`. Xem ví dụ đầy đủ ở mục "Bundle riêng cho feature dạng
remote-config/content-layer" phía trên.

**Biến thể cho feature chỉ có tài liệu kiến trúc, UI ra sau** (backend đổi trước, cần đối chiếu ngược nhiều
vòng với dev): bỏ qua cả bước screenshot lẫn spec/runbook chính thức, thay bằng chuỗi
`tài liệu kiến trúc (đọc độc lập) → test plan ISTQB phân tích cơ chế + risk-based priority → câu hỏi vượt
phạm vi tài liệu, gộp gửi dev → câu trả lời dev (đối chiếu code thật) cập nhật NGƯỢC vào test plan gốc →
(khi UI lên `main`) bàn giao QC cho UI thật → tích hợp thẳng vào cùng test plan → bug log`. Test plan trong
biến thể này là **tài liệu sống**, sửa liên tục qua nhiều vòng thay vì viết 1 lần. Xem ví dụ đầy đủ ở mục
"Bundle riêng cho luồng cần đối chiếu ngược nhiều vòng với dev + UI thật ra sau" phía trên.

---

## Quy ước đặt tên & flow map

Toàn bộ screenshot theo format `<flow-no>_<flow-name>_<screen-no>_<screen-name>_<state>.png`, chi tiết đầy đủ
ở [`.claude/rules/screenshot-naming.md`](.claude/rules/screenshot-naming.md) — file này cũng giữ **flow map
chính thức** của cả app (flow nào đã build, flow nào còn 🚧 Phase 2).

`flow-no` **không bao giờ đánh số lại** sau khi đã dùng — cấp flow mới luôn lấy số tiếp theo.

---

## Sản phẩm đang test

**Ink: Lockscreen Calendar, Note** — biến lịch/to-do của user thành hình nền lock screen tự cập nhật mỗi
sáng qua Apple Shortcut + Personal Automation (iOS không cho app tự đổi wallpaper trực tiếp). Chi tiết kiến
trúc và điểm rủi ro cốt lõi nằm ở [wideframes/README.md § Cách hoạt động của sản phẩm](requirements/ui/ux/wideframes/README.md#cách-hoạt-động-của-sản-phẩm).

Repo này lưu trên GitHub tại `ngochando/ink-calendar-ios` — chỉ chứa tài liệu QA (`requirements/`,
`test-cases/`, `bugs/`, `references/`), không chứa source code Xcode/Swift của app.
