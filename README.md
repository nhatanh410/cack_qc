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
| Đọc test case chi tiết (ISTQB) cho feature không có UI baseline | [`test-cases/`](test-cases/) — case ID, tiền điều kiện, test data, expected result, traceability về test plan |
| Xem bằng chứng test đã chạy (screenshot đối chiếu từng case) + báo cáo giữa kỳ | [`requirements/test-plans/paywall-remote-config-payloads/screenshots/README.md`](requirements/test-plans/paywall-remote-config-payloads/screenshots/README.md) — log PASS/FAIL kèm ảnh, Interim Test Summary Report |
| Đọc change note / PRD gốc từ dev | [`requirements/specs/`](requirements/specs/) |
| Tra cứu quyền hệ thống app cần | [`references/permissions-matrix.md`](references/permissions-matrix.md) |
| Hiểu rủi ro xuyên suốt sản phẩm + mindset QC | [`references/exploratory-references.md`](references/exploratory-references.md) |
| Xem bug đang mở | [`bugs/bug-log.md`](bugs/bug-log.md) |
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
│   ├── exploratory/           ← checklist khám phá, 1 file / flow, ID dạng `<PREFIX>-H01`
│   ├── test-plans/            ← test plan ISTQB cho từng build/feature cụ thể, 1 file / PR hoặc / feature
│   │   └── paywall-remote-config-payloads/   ← bundle riêng cho feature không có UI baseline (xem mục dưới)
│   ├── specs/                 ← change note / PRD / runbook gốc từ dev (input, không phải QA tự viết)
│   └── mermaid-flowchart/     (chưa dùng)
├── test-cases/                 ← test case ISTQB chi tiết (ID, tiền điều kiện, test data, expected result,
│                                  traceability) — cho feature phức tạp/không có ảnh baseline, tách khỏi test-plans/
├── references/                ← tài liệu tham chiếu dùng chung mọi flow
│   ├── exploratory-references.md   ← khung 9 câu hỏi mindset QC + rủi ro xuyên suốt sản phẩm
│   ├── permissions-matrix.md       ← mọi quyền iOS app cần, ma trận hỏng khi bị từ chối
│   └── shortcut-flow-cases.md      ← đào sâu flow rủi ro nhất (Shortcut Setup)
├── bugs/
│   └── bug-log.md             ← 1 file duy nhất cho toàn bộ bug, sort theo ngày
└── .claude/
    ├── rules/screenshot-naming.md      ← quy tắc đặt tên file/folder screenshot
    └── skills/exploratory-checklist/   ← skill sinh checklist tự động từ wireframe
```

Hai thư mục đang **để trống** (`end-user-perspectives/`, `mermaid-flowchart/`) — dự trù cho sau, chưa có
nội dung.

### Bundle riêng cho feature dạng remote-config/content-layer

Feature không có UI baseline bằng ảnh (QC không có quyền vào code, logic decoder cố định trong binary, chỉ
data JSON đổi qua Firebase) đi theo một bộ tài liệu đầy đủ hơn, ví dụ **Paywall Remote Config**
(`pro_paywall_config_v1`):

```
requirements/specs/paywall-config.md                          ← runbook kỹ thuật chính thức (nguồn thẩm quyền cao nhất)
requirements/specs/paywall-qc-vi.md                            ← hướng dẫn setup Firebase RC + checklist thao tay
requirements/specs/paywall-config-builder.html                 ← tool dựng payload, mirror lại logic decoder
requirements/test-plans/paywall-remote-config-strategy.md      ← Test Strategy (ISTQB) — vì sao chọn cách tiếp cận này
requirements/test-plans/paywall-remote-config.md               ← Test Plan (ISTQB) — làm gì/khi nào/ai làm
test-cases/paywall-remote-config.md                             ← Test Case (ISTQB) — 75 case chi tiết
requirements/test-plans/paywall-remote-config-payloads/         ← test data: 32 file JSON dán thẳng vào Firebase Console
  └── screenshots/README.md                                     ← bằng chứng chạy thật + Interim Test Summary Report
requirements/test-plans/paywall-remote-config-questions-for-dev.md  ← câu hỏi vượt thẩm quyền QC, gộp gửi dev 1 lần
bugs/bug-log.md                                                  ← bug phát hiện được log kèm Flow `08_paywall`
```

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
Test plan theo build  (requirements/test-plans/<version>.md)
        │   — chuẩn ISTQB: test basis → scope → kỹ thuật thiết kế case → risk-based priority → entry/exit
        ▼
Bug log  (bugs/bug-log.md)
            — khi phát hiện sai khác, log kèm Flow/Screen theo đúng tên trong screenshot-naming.md
```

**Nguyên tắc xuyên suốt:** mọi kết luận phải truy được về bằng chứng (ảnh, change note, hoặc quan sát thật
trên máy) — không suy diễn khi thiếu dữ liệu, ghi rõ *coverage gap* thay vì đoán.

**Biến thể cho feature không có UI baseline** (remote-config/content layer, QC không có quyền vào code):
bỏ qua bước wireframe-từ-ảnh, thay bằng chuỗi
`spec/runbook → test strategy → test plan → test case chi tiết (test-cases/) → test data (fixture JSON) →
screenshot bằng chứng khi chạy thật → bug log`. Xem ví dụ đầy đủ ở mục "Bundle riêng cho feature dạng
remote-config/content-layer" phía trên.

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
