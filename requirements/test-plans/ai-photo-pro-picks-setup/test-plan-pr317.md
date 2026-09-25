# Test Plan — Ink AI đọc ảnh, thử Pro trước khi mua, setup shortcut, badge Guide (PR #317)

> **Test basis:** [qc-ai-photo-pro-picks-setup-vi.md](../../specs/ai-photo-pro-picks-setup/qc-ai-photo-pro-picks-setup-vi.md) —
> PR [sfunvn/lockscreen-calendar#317](https://github.com/sfunvn/lockscreen-calendar/pull/317), 143 dòng, 11 mục.
> Build: **Ink Dev** qua Firebase App Distribution — **không** phải bản App Store.
> **Chuẩn:** ISTQB Foundation Level v4.0.1 (test basis → test object → kỹ thuật thiết kế → rủi ro → entry/exit)
> **Test condition đã ưu tiên hoá:** [test-analysis-pr317.md](test-analysis-pr317.md) — **73 test condition**, 6
> nhóm (`AI` 22 · `PRO` 18 · `BG` 12 · `SETUP` 10 · `GUIDE` 6 · `REG` 5), dùng thẳng cho mục 2/6 dưới đây,
> **không phân tích lại từ đầu**.
> **Test case cụ thể:** [test-cases-pr317.md](test-cases-pr317.md) — sẽ sinh bởi skill test-case sau khi test
> plan này được duyệt, thiết kế trực tiếp từ các kỹ thuật ở mục 5.
> **Đối chiếu tài liệu đã có:**
> [test-plan-ios26-27-v3.md](../shortcuts/test-plan-ios26-27-v3.md) §5.6 (`MIG`, State Transition — nguồn tham
> chiếu bắt buộc cho `SETUP-10`, không thiết kế lại),
> [qc-shortcut-home-screen-ios26-27-V2.md](../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2.md) dòng
> 506-508 (định nghĩa ranh giới V1/V2 dùng cho câu hỏi #8, đã đóng),
> [exploratory/03_shortcut-setup.md](../../exploratory/03_shortcut-setup.md) (SCT-H08/N09/Q08, cơ chế overlay tự
> động cũ của shortcut V1 — nguồn cho gap #8 mục 10 dưới đây),
> [ai-assistant-tab.md](../ai-assistant/ai-assistant-tab.md) (flow `12_ai-assistant`, Phase 2 **chưa build**, xác
> nhận không liên quan — chỉ trùng câu hỏi mở về quota),
> [1.2.15-decoration-inkai.md](../decoration-inkai/1.2.15-decoration-inkai.md) mục 10.10 (xác nhận tab "Ink AI" đã
> tồn tại trước PR #317),
> [bugs/bug-log.md § BUG-003](../../../bugs/bug-log.md#bug-003--discount-1-là-giá-trị-invalid-nhưng-pill-save-100-vẫn-hiện)
> (bug mở ở màn `plan-list` của `08_paywall` — theo dõi cơ hội khi nhóm `PRO` mở paywall trong đợt test này, xem
> mục 11).
> **Ngày lập:** 2026-09-25 · **Người lập:** QC

> ✅ **Câu hỏi #8 (test-analysis mục 4) đã đóng, xác nhận trực tiếp bởi user (2026-09-25):** 2 màn "Shortcut is
> working!" / "Check your lock screen shortcut." ở mục 8 test basis **chỉ** áp dụng cho user đã có shortcut V2.
> User còn dùng shortcut V1 vẫn đi vào đúng luồng update 3 bước (`MIG`, PR #302, đã test kỹ ở
> `test-plan-ios26-27-v3.md`) — 2 luồng **không** đá nhau. `SETUP-01`→`SETUP-09` trong tài liệu này ngầm định tiền
> điều kiện "user đang ở V2"; `SETUP-10` (mục 2/5.9) test riêng ranh giới V1 tại đúng điểm vào này.
>
> **10 câu hỏi còn lại** (mục 10 dưới đây) **không chặn scope hay entry criteria (mục 8)** của test plan này —
> chỉ ảnh hưởng chi tiết BVA/expected result của case cụ thể, đánh dấu ⚠️ ngay tại case liên quan khi viết
> test-case.

---

## 1. Phát hiện khi đối chiếu với tài liệu đã có

1. **Mục 8/9 test basis PR #317 mô tả cùng vùng UI (Settings → Set up shortcut) với luồng đã merge ở PR #302,
   nhưng chỉ đúng cho nhánh V2.** Đây là phát hiện quan trọng nhất khi đối chiếu 2 test basis — đã được user xác
   nhận đóng (banner đầu tài liệu) và cụ thể hoá thành `SETUP-10` (P1). Toàn bộ Decision Table ở mục 5.8 (SETUP-
   01→09) chỉ mô tả đúng nhánh V2; mục 5.9 xử lý riêng nhánh V1 bằng cách tham chiếu thẳng State Transition `MIG`
   đã có, **không** thiết kế lại state diagram đó.
2. **Câu hỏi quota "lượt hỏi trong ngày" là lần lặp lại thứ 3 trong repo** (sau `ai-assistant-tab.md` §10 câu #4
   và `1.2.15-decoration-inkai.md` mục 10.10) — không phải vấn đề mới của riêng PR #317. `1.2.15-decoration-
   inkai.md` xác nhận tab Ink AI **đang chạy quota thật trên production**, nghĩa là hành vi ẩn nút + khi hết lượt
   (AI-11) là verify được trên số thật hiện tại của production dù chưa biết con số đó có phải là số "chính thức"
   PO muốn chốt hay không — QC vẫn test được, chỉ không tự suy ra BVA chính xác cho tới khi có câu trả lời (gap
   #1 mục 10).
3. **Tab "Ink AI" (mục 1-3 test basis) không phải tính năng mới hoàn toàn** — `1.2.15-decoration-inkai.md` xác
   nhận đây là tab đã tồn tại trước PR #317; chỉ riêng khả năng đọc ảnh + các state đi kèm (AI-01→AI-09, AI-11,
   AI-22) là mới. Phần cảnh báo trùng lịch (mục 2 test basis, AI-14→19) và copy/độ dài tin nhắn (mục 3, AI-20→22)
   nhiều khả năng đã có sẵn trước PR317 và chỉ được liệt lại làm regression — không có tài liệu gốc nào xác nhận
   rõ ranh giới "mới" vs "regression" bên trong nhóm `AI`, nhưng không ảnh hưởng cách test (test basis đã liệt
   rõ từng dòng cần verify).
4. **`test-plan-ios26-27-v3.md` không hề nhắc tới cơ chế "thử Pro trước khi mua"** — nghĩa là toàn bộ nhóm `PRO`
   (mục 4-5 test basis) là vùng hoàn toàn mới, không có tiền lệ test-plan/test-case nào để đối chiếu hay tái sử
   dụng, khác với `SETUP`/`GUIDE` (có giao điểm trực tiếp với PR #302).
5. **Flow map (`screenshot-naming.md` §7) chưa có mục dành riêng cho tab "Ink AI" (chat đọc ảnh, mục 1-3 test
   basis) và tab "Guide" (mục 10 test basis).** Cả hai đều được xác nhận là màn hình **đã tồn tại** trong app
   (không phải Phase 2 — `ai-assistant-tab.md` mô tả flow `12_ai-assistant` là một tính năng **khác**, trợ lý AI
   tự lên lịch, chưa build), nhưng không map được vào bất kỳ `flow-no` nào trong 14 flow đã liệt ở §7. Đây là
   **phát hiện mới**, không nằm trong 10 câu hỏi đã biết của test-analysis mục 4 — không ảnh hưởng scope hay
   priority của bất kỳ test condition nào (mọi test condition đều đã có nguồn dòng cụ thể trong test basis), chỉ
   ảnh hưởng cách điền bảng 3.1 dưới đây (đánh dấu "không xác định flow-no" thay vì tự đặt tên) — không dừng lại
   theo mục 0 SKILL vì không đổi kết quả test nào, chỉ ghi nhận để người duy trì `screenshot-naming.md` cân nhắc
   bổ sung khi có bộ ảnh UX chính thức cho 2 tab này.

---

## 2. Test object — In scope

> Mã nhóm dùng làm tiền tố ID khi skill test-case sinh case cụ thể (vd `PRO-05`, giữ nguyên mã đã dùng ở
> test-analysis).

| # | Mã nhóm | Hạng mục | Nguồn (test basis) | Ghi chú |
|---|---|---|---|---|
| 1 | `AI` | Ink AI đọc ảnh để tạo sự kiện + cảnh báo trùng lịch + copy/độ dài tin | Mục 1-3 (22 test condition) | Nút + ẩn khi hết lượt (AI-11) và giới hạn 1000 ký tự (AI-22) treo chờ gap #1/#3 mục 10 — case vẫn viết được, đánh dấu ⚠️ |
| 2 | `PRO` | Thử Pro trước khi mua — Editor (font/màu/ảnh nền/Home Screen) + Decorate (Cutout/style chữ) | Mục 4-5 (18 test condition) | **Rủi ro cao nhất PR** (9/18 P1) — Decision Table + State Transition, xem mục 5.4-5.6 |
| 3 | `BG` | Hàng ảnh nền + màn Backgrounds full-screen | Mục 6-7 (12 test condition) | Chủ yếu UI/thứ tự hiển thị; BG-06 (giới hạn ảnh Free) phát hiện thêm 1 con số biên chưa công bố — gap mới #11 mục 10 |
| 4 | `SETUP` | Luồng setup shortcut (setup lần đầu + Settings, đã có shortcut) | Mục 8 (10 test condition, gồm `SETUP-10` 🆕) | `SETUP-01`→`09` ngầm định tiền điều kiện "đang ở V2"; `SETUP-10` test ranh giới V1 tại đúng điểm vào — tham chiếu `MIG` của `test-plan-ios26-27-v3.md`, không thiết kế lại |
| 5 | `GUIDE` | Badge Done/To do trong tab Guide | Mục 10 (6 test condition) | `GUIDE-01` cross-check trực tiếp state `S1`-`S4` của `MIG` — xem mục 5.10 |
| 6 | `REG` | Hồi quy chung (widget, mở app liên tiếp, account, Pro persist, render nhiều event) | Mục 11 (5 test condition) | 3/5 là P1 — chạy sớm, không để cuối đợt test (theo đúng khuyến nghị test-analysis) |

---

## 3. Out of scope

- **Flow `12_ai-assistant`** (trợ lý AI dạng chat, tự lên schedule, Phase 2) — chưa build, `ai-assistant-tab.md`
  và test-analysis mục 0 đã xác nhận đây là tính năng **khác** với tab "Ink AI" của PR #317, dù trùng khái niệm
  quota.
- **Giá trị $ COGS/đơn giá thật của mỗi lượt hỏi Ink AI** — QC không verify số tiền, chỉ verify hành vi đếm
  lượt/ẩn nút; theo dõi chi phí thật thuộc vận hành, không thuộc phạm vi black-box UI testing này.
- **Cơ chế enforce quota phía server** (client có thể bị bypass hay không) — test basis PR #317 không mô tả kiến
  trúc backend của tính năng này (khác `ai-assistant-tab.md` mục 5.5 nơi có yêu cầu rõ "enforce ở server"); nếu
  cần, đây là phạm vi của test basis Ink AI gốc, không phải PR #317.
- **Localization đầy đủ mọi ngôn ngữ app hỗ trợ** — chỉ test đúng các ngôn ngữ được nêu cụ thể trong test basis:
  Đức/Nga cho popup Pro (PRO-12), tiếng Việt (và "vài ngôn ngữ" không nêu tên) cho dòng trạng thái shortcut
  (SETUP-08) và badge Guide (GUIDE-06), ngôn ngữ hiển thị tên danh mục Backgrounds (BG-04) — không tự mở rộng
  sang toàn bộ ngôn ngữ app hỗ trợ.
- **Build App Store/Production** — test basis tự xác nhận build test là **Ink Dev qua Firebase App
  Distribution**.
- **Toàn bộ luồng `INS`/`OLD`/`HS`/`OWN`/`PAIR`/`GATE`/`AUTO`/`XVER`/`DBG`/`HOW`/`ANA` của PR #302** — đã test kỹ
  ở [test-plan-ios26-27-v3.md](../shortcuts/test-plan-ios26-27-v3.md), không nằm trong test basis PR #317. Chỉ
  tham chiếu đúng 1 điểm giao (`SETUP-10`, mục vào luồng `MIG`) — không thiết kế lại bất kỳ case nào của bộ đó.
- **Thuật toán chọn/xếp hạng nội dung trong catalog ảnh nền Pro** — chỉ test đúng thứ tự hiển thị theo mục 6 test
  basis (mục 5.7), không test logic nghiệp vụ nào quyết định ảnh nào được đưa vào catalog.

### 3.1 Ảnh hưởng chéo tới flow khác (regression impact ngoài phạm vi note)

> Đối chiếu [screenshot-naming.md §7](../../../.claude/rules/screenshot-naming.md#7-flow-map--ink-calendar-ios) —
> chỉ liệt đúng flow có trong bảng flow map đó; 2 dòng cuối bảng đánh dấu "không xác định" thay vì tự đặt tên
> (xem mục 1 #5).

| Flow / màn hình | Ảnh hưởng? | Lý do |
|---|---|---|
| `14_edit-wallpaper` | **Trực tiếp** | Toàn bộ nhóm `PRO` (Editor: tab Style/Background + menu Decorate) và `BG` (hàng ảnh nền, màn Backgrounds) là các tab/màn bên trong Editor — đúng nghiệp vụ "soạn/sửa" mà flow này mô tả, không phải "browse/collection" |
| `08_paywall` | **Trực tiếp** | Cơ chế mở paywall bị thay đổi hẳn (Unlock Pro/Go Pro mở paywall **từ trong** Editor/Decorate thay vì chặn ngay khi chạm lựa chọn Pro) — `PRO-04/05/16`. Đã có `BUG-003` mở trên chính màn `plan-list` của flow này — theo dõi cơ hội (mục 11) |
| `03_shortcut-setup` | **Trực tiếp** | Toàn bộ `SETUP` nằm trong flow này; `SETUP-10` là điểm giao trực tiếp với luồng `MIG` (PR #302, cùng flow) |
| `04_discover` | **Gián tiếp** | Entry point mở Editor (chọn template từ collection); sau khi set Pro thành công, thumbnail trong collection cần hiển thị đúng (không thuộc test condition nào của PR #317, chỉ là hệ quả tự nhiên cần quan sát khi execute `PRO`) |
| `05_calendar` | **Gián tiếp** | Event card do Ink AI tạo (nhóm `AI`) ghi thẳng vào Calendar thật; cảnh báo trùng lịch (AI-14→19) đối chiếu dữ liệu Calendar, nhưng UI test nằm trong tab Ink AI, không phải màn hình Calendar |
| `02_permission` | **Gián tiếp** | AI-19 (chưa cấp quyền lịch → không tự hiện hộp xin quyền) và GUIDE-02/03 (badge đồng bộ theo quyền lịch bật/tắt ở iOS Settings) đều phụ thuộc trạng thái quyền do flow này quản lý |
| `09_settings` | **Trực tiếp** | Entry point "Set up shortcut" khác Discover/Guide/banner nằm ở đây; `REG-03` (Settings → Account) cũng thuộc flow này |
| `10_lockscreen` | **Gián tiếp** | Kết quả cuối (wallpaper thật) hiện ở đây — đối chiếu `PRO-07` (ảnh riêng không bị mất) và `REG-05` (render nhiều event không treo) |
| `07_note` | **Gián tiếp, nhẹ** | `BG-10` (khoảng cách ô ảnh 6pt) áp dụng cả màn chọn nền của Note, theo đúng test basis tự nêu |
| `06_task`, `01_onboarding` | **Không ảnh hưởng** | Không entry point, không data pipeline dùng chung với bất kỳ test condition nào ở mục 2 |
| `11_share`, `13_community` | **Không áp dụng** | Chưa build (Phase 2) |
| `12_ai-assistant` | **Không áp dụng** | Chưa build (Phase 2) — xem mục 1 #5 để phân biệt với tab "Ink AI" (đã build, thuộc PR #317) |
| Tab "Ink AI" (mục 1-3 test basis) | **Không xác định flow-no** | Đã build, không phải `12_ai-assistant` (Phase 2) — §7 chưa có mục riêng cho tab này, xem mục 1 #5 |
| Tab "Guide" (mục 10 test basis) | **Không xác định flow-no** | Đã build (xác nhận qua `qc-shortcut-home-screen-ios26-27-V2.md`), không nằm trong 14 flow của §7 — xem mục 1 #5 |

---

## 4. Test levels & test types

- **Level:** System testing, black-box, trên **Ink Dev** (Firebase App Distribution) — 1 máy iOS 27, 1 máy iOS
  26, tài khoản **Free** (đổi qua **Pro** bằng nút dev "Grant Pro (dev)"/"Revoke Pro (dev)" trong Settings).
- **Functional:**
  - `AI`: pipeline đọc ảnh (idle → reading → still going → done/error), cảnh báo trùng lịch (toggle theo giờ),
    copy tin nhắn, giới hạn ký tự.
  - `PRO`: preview trước khi mua cho 4 loại lựa chọn (font/màu/ảnh/mode), popup xác nhận, rollback, gating theo
    tier.
  - `BG`: thứ tự hiển thị, màn Backgrounds full-screen, hành vi đóng màn theo mode.
  - `SETUP`: máy trạng thái setup shortcut theo tiền sử (chưa có/đã có, trong 24h/quá 24h, loại lỗi).
  - `GUIDE`: badge đồng bộ theo state shortcut + quyền lịch.
  - `REG`: widget, hiệu năng mở app, account init, Pro persist, render nhiều event.
- **Non-functional (ISO 25010, §2.2.2):**
  - **Usability:** ô nhập Ink AI đổi layout khi focus (AI-12); popup "Keep your Pro picks?" không tràn/không cắt
    nút ở Dynamic Type lớn (PRO-12); dòng cảnh báo trùng lịch không gây hiểu nhầm khi task/all-day (AI-18).
  - **Localizability/Portability:** popup Pro ở tiếng Đức/Nga (PRO-12), dòng trạng thái shortcut + badge Guide đa
    ngôn ngữ (SETUP-08, GUIDE-06), tên danh mục Backgrounds (BG-04).
  - **Performance efficiency:** widget cập nhật chậm chấp nhận được ~1 giây (REG-01); mở app liên tiếp không
    giật (REG-02).
  - **Reliability:** không treo khi render wallpaper nhiều sự kiện (REG-05, đã có bug tham chiếu #316); pipeline
    đọc ảnh xử lý đúng race condition khi Clear chat giữa chừng (AI-07).
  - **Security/Data integrity (không có mục ISO 25010 riêng nhưng là rủi ro cao nhất tài liệu này):** rollback
    "Set/Save without Pro" không bao giờ làm mất nội dung do chính user tạo (ảnh riêng — PRO-07, chữ đã gõ —
    PRO-17) và không set/lưu nội dung Pro **ngoài** luồng xác nhận/thanh toán (PRO-08, "đường tắt" thoát ra Home
    Screen rồi chạy shortcut).
- **Change-related (§2.2.3 — confirmation + regression testing cụ thể):**
  - **Confirmation testing:** toàn bộ 73 test condition là tính năng/thay đổi mới trong PR #317, chưa từng được
    test trước đó.
  - **Regression bắt buộc, không phải case thăm dò:** nhóm `REG` (widget, mở app, account init, Pro persist,
    render nhiều event — 3/5 là P1); `SETUP-10` (regression **ranh giới**, không phải regression nội dung, với
    luồng `MIG` đã test ở PR #302); dòng "Refreshed automatically …" phải khớp baseline chụp trước đợt test này
    (SETUP-09, gap #9 mục 10).
  - **Regression cơ hội (không phải test condition chính thức):** quan sát `BUG-003` (pill "SAVE 100%" sai với
    `discount: 1`) mỗi lần màn `plan-list` của paywall được mở trong nhóm `PRO` — không cần setup payload riêng
    cho bug này, chỉ ghi nhận nếu vẫn tái hiện bằng dữ liệu remote config hiện tại.

---

## 5. Kỹ thuật thiết kế test case

### 5.1 State Transition Testing — Vòng đời gửi ảnh trong Ink AI (`AI`, kỹ thuật chính của nhóm)

> Chọn State Transition vì hành vi phụ thuộc **trình tự** thao tác (đang đọc ảnh mà Clear chat, gửi lại sau lỗi
> mạng không đọc lại ảnh) — Decision Table không biểu diễn được yếu tố "đang ở bước nào" này.

**States:** `Idle` (chưa gửi ảnh) → `Reading` ("Reading the photo…") → `StillGoing` ("Still going…", ảnh nhiều
chữ) → `Done` (chữ hiện dưới ảnh + Ink đã trả lời) / `NoText` (báo "No text found…") / `NetworkError` (báo lỗi
mạng) → `Cleared` (Clear chat, chat trống hẳn).

| Từ state | Event | Đến state | Ghi chú |
|---|---|---|---|
| `Idle` | Chọn ảnh có chữ | `Reading` → `Done` | AI-02, happy path — giá trị cốt lõi |
| `Idle` | Chọn ảnh không chữ | `Reading` → `NoText` | AI-04. **Không** trừ lượt hỏi — verify được ngay cả khi chưa có số quota chính thức (gap #1) |
| `Idle` | Chọn ảnh nhiều chữ | `Reading` → `StillGoing` → `Done` (kèm câu "That photo has a lot of text…") | AI-05 |
| `Reading`/`StillGoing` | Bấm **Clear chat** | `Cleared` | AI-07 — race condition: response trả về **sau** khi đã Cleared **không** được làm ảnh cũ hiện lại |
| `Idle` | Tắt mạng, gửi ảnh | `NetworkError` | AI-08 |
| `NetworkError` | Bật mạng, bấm **Retry** | `Done` (gửi lại **chữ**, không gọi lại API đọc ảnh) | AI-08 — case cost-control quan trọng nhất nhóm, P1 |
| `Done` | Tắt app, mở lại | vẫn `Done` (persist) | AI-09 |
| `Done` (đúng ảnh vừa gửi) | Chọn lại đúng ảnh đó | `Reading` → `Done` mới | AI-06 — không bị chặn trùng |

**Valid transitions coverage (§4.2.4):** mỗi dòng trên phải được exercise ít nhất 1 lần. Ưu tiên chạy `AI-08`
(transition `NetworkError → Done` qua Retry) **sớm** trong đợt test nhóm `AI` — đây là case cost-control duy nhất
có COGS kép nếu sai (đọc ảnh 2 lần).

### 5.2 Boundary Value Analysis — Độ dài tin nhắn & biên cảnh báo trùng lịch (`AI`)

- **Giới hạn 1000 ký tự (AI-22):** 3-value BVA quanh biên 1000 — `999` (hợp lệ, gửi được) · `1000` (hợp lệ, biên
  đúng) · `1001` (không hợp lệ, khoá nút gửi, hiện "N of 1000 characters"). ⚠️ Đơn vị đếm (grapheme hiển thị vs
  UTF-16 code unit) chưa xác định (gap #3 mục 10) — chạy BVA bằng ký tự ASCII trước (không phụ thuộc đơn vị đếm),
  case riêng cho tiếng Việt có dấu/emoji đánh dấu ⚠️ chờ câu trả lời.
- **Biên overlap lịch (AI-16), 2-value BVA trên trục thời gian:** sự kiện nền cố định 15:00–16:00 (theo chuẩn bị
  đầu bài). Test thẻ mới với giờ bắt đầu `15:59` (chồng 1 phút, phải báo overlap) và `16:00` (liền kề đúng biên,
  **không** báo overlap — AI-16). Đây là lỗi off-by-one điển hình ở logic khoảng thời gian, risk cao dù effort
  thấp.

### 5.3 Equivalence Partitioning — Giới hạn "lượt hỏi trong ngày" (`AI`, treo chờ gap #1)

- Partition trạng thái quota: {còn nhiều lượt · còn đúng 1 lượt (biên) · vừa hết lượt (nút + vừa ẩn) · đã hết từ
  trước (mở lại app, nút + đã ẩn sẵn)}. **Không** tự suy ra con số biên cụ thể — verify hành vi **định tính**
  (nút ẩn đúng lúc hết, không ẩn nhầm khi còn lượt) trên số quota thật của production trước, ghi lại số quan sát
  được, đối chiếu lại khi có câu trả lời chính thức (gap #1).
- Case cụ thể AI-11 (P1) chạy được ngay theo cách trên — **không** chặn scope, chỉ chặn việc viết BVA 3 giá trị
  chính xác cho tới khi có số.

### 5.4 Decision Table — Xác nhận lựa chọn Pro trong Editor (`PRO`, kỹ thuật chính của cả PR)

> Conditions: **Tier** (Free/Pro) × **có ≥1 lựa chọn Pro chưa xác nhận khi bấm nút xác nhận** (Y/N) × **hành động
> tại popup**. Decision Table phù hợp vì đây đúng là "tổ hợp điều kiện → hành động" mà spec mô tả (dòng 66-70 test
> basis), không phải chuỗi sự kiện phụ thuộc thời gian như `MIG`.

| ID | Tier | ≥1 lựa chọn Pro pending | Hành động | Nhãn PRO trên nút | Popup hiện? | Kết quả |
|---|---|---|---|---|---|---|
| ER1 | Free | Không (0 pending, kể cả mẫu **đã có sẵn** Pro chưa đụng tới) | Bấm xác nhận | Không | Không | Set thẳng với giá trị hiện tại — **không** hỏi lại về lựa chọn Pro có sẵn (PRO-09, ⚠️ gap #5 nếu mẫu có **nhiều** lựa chọn có sẵn và chỉ đổi 1) |
| ER2 | Free | Có | Bấm xác nhận (chưa chọn nhánh) | Có | Có, liệt đúng từng lựa chọn + giá trị | PRO-02/03 |
| ER3 | Free | Có | Từ ER2 → **Unlock Pro** → mua thành công | Biến mất | — | Vẫn ở editor; **phải** bấm xác nhận **lần nữa** mới set thật, không tự set (PRO-05) |
| ER4 | Free | Có | Từ ER2 → **Unlock Pro** → huỷ/lỗi thanh toán | ⚠️ chưa rõ | — | **Treo chờ gap #6** — verify hành vi thật (giữ nguyên preview Pro như trước khi bấm Unlock, hay reset?), không tự đoán kỳ vọng khi viết test-case |
| ER5 | Free | Có | Từ ER2 → **Set without Pro** | — | — | **Mọi** lựa chọn Pro rollback về đúng giá trị lúc mở editor, chạy set bình thường với giá trị gốc (PRO-06/07/08) |
| ER6 | Free | Có | Từ ER2 → **Vuốt đóng** | Giữ nguyên (vẫn Có) | Đóng, không set nhánh nào | PRO-11 — vẫn ở editor, iOS mặc định cho vuốt tắt sheet nên phải chủ động chặn |
| ER7 | Pro | Có (chọn bất kỳ lựa chọn Pro nào) | Bấm xác nhận | Không (không bao giờ hiện) | Không (không bao giờ hiện) | Set thẳng, không gating — PRO-10, regression cho user đã mua |
| ER8 🆕 | Free | Có, **đồng thời cả 4 loại** (font + màu + ảnh + mode) | Từ trạng thái đó → **Set without Pro** | — | — | Rollback **đồng thời cả 4 field** — case bổ sung để verify tường minh cho phát biểu tổng quát "mọi lựa chọn" (dòng 69), ⚠️ **gap #4**: chỉ có case cụ thể xác nhận cho ảnh nền, chưa có case tổ hợp 4 loại cùng lúc trong test basis |

### 5.5 State Transition Testing — Vòng đời "chọn thử → xác nhận/huỷ" của 1 lựa chọn Pro (`PRO`)

> Bổ sung góc nhìn theo thời gian mà Decision Table 5.4 không thể hiện: canvas phải đổi **ngay** khi chọn thử
> (trước khi có bất kỳ popup nào), và trạng thái "đã mua nhưng chưa set" (`T3`) là điểm dễ bị lập trình sai nhất
> (nguy cơ tự set ngay sau thanh toán — PRO-05 cảnh báo rõ).

**States:** `T0` (giá trị mặc định/đã mua sẵn lúc mở editor) → `T1` (đang chọn thử, canvas preview Pro, nhãn PRO
hiện) → `T2` (popup đang mở) → `T3` (vừa mua Pro qua Unlock, popup đã đóng, nhãn PRO đã biến mất, **chưa** set) →
`T4` (đã set thật với giá trị Pro).

| Từ | Event | Đến | Ghi chú |
|---|---|---|---|
| `T0` | Chọn 1 trong 4 loại lựa chọn Pro | `T1` | Canvas đổi **ngay**, chưa có popup nào — PRO-01 |
| `T1` | Chọn lại đúng giá trị lúc mở editor | `T0` | Nhãn PRO biến mất — PRO-02, nửa còn lại của việc theo dõi diff |
| `T1` | Bấm nút xác nhận | `T2` | — |
| `T2` | Unlock Pro → mua thành công | `T3` | PRO-05 |
| `T3` | Bấm xác nhận **lần nữa** | `T4` | Đây là transition **bắt buộc phải có sự kiện riêng** — nếu code tự nhảy `T2→T4` bỏ qua `T3` là bug nghiêm trọng nhất của toàn nhóm `PRO` |
| `T2` | Set without Pro | `T0` rồi set với giá trị gốc | PRO-06/07/08 |
| `T2` | Vuốt đóng | `T1` | Không mất trạng thái đang chọn thử |
| `T4` | Thoát ra Home Screen **không** qua `T3`→`T4` (đường tắt) | — | Test negative: từ `T1`, thoát thẳng ra ngoài **không** bấm xác nhận → chạy shortcut → Home Screen **không** được đổi (PRO-08, "đường tắt né hoàn toàn popup xác nhận") |

### 5.6 Decision Table — Xác nhận Cutout/style chữ Pro trong Decorate (`PRO`)

> Cùng cơ chế 5.4 nhưng UI khác (nút ✓ của Decorate thay cho nút xác nhận Editor, "Save without Pro" thay "Set
> without Pro") — tách bảng riêng để không lẫn 2 bộ label.

| ID | Có Cutout/style Pro chưa xác nhận? | Hành động tại ✓ | Kết quả |
|---|---|---|---|
| DR1 | Không | Bấm ✓ | Đóng Decorate bình thường, không popup |
| DR2 | Có (vừa thêm Cutout hoặc style chữ Pro) | Bấm ✓ | Nút ✓ có vương miện, popup hiện với nút 2 là **"Save without Pro"** — PRO-15 |
| DR3 | Có | Từ DR2 → **Go Pro** → mở paywall | Vẫn ở Decorate sau khi đóng paywall — PRO-16 |
| DR4 | Có | Từ DR2 → **Save without Pro** | Cutout bị bỏ **hoàn toàn**; chữ giữ nguyên **nội dung**, chỉ về style **mặc định**; đóng Decorate — PRO-17, risk cao nhất nhóm này (nếu rollback sai làm mất luôn nội dung chữ đã gõ) |
| DR5 | Có Cutout, nhưng **xoá Cutout trước khi bấm ✓** | Bấm ✓ | Không bị hỏi — PRO-18. ⚠️ **Gap #7**: chưa rõ trả style chữ Pro về mặc định trước khi bấm ✓ có được miễn hỏi tương tự không — thiết kế thêm 1 case đối xứng, đánh dấu ⚠️ |

### 5.7 Equivalence Partitioning + Boundary Value Analysis — Hàng ảnh nền & màn Backgrounds (`BG`)

- **Số ảnh trong catalog:** BVA tại biên hiện ô More — `15` ảnh (không có ô More) · `16` ảnh (có ô More, BG-01).
- **Vị trí ảnh đã chọn:** partition {trong 15 ảnh đầu · ngoài 15 ảnh đầu (BG-02, vẫn phải hiện trong hàng)}.
- **Số ảnh riêng khi multi-select ("New photo every day"):** partition {dưới giới hạn Free · đúng giới hạn (biên,
  đóng màn + hiện popup giới hạn — BG-06)}. ⚠️ **Gap mới #11 (mục 10)** — test basis **không nêu con số cụ thể**
  của "giới hạn Free" này, khác cơ chế thử-trước-khi-mua của `PRO` (đây là giới hạn **số lượng**, không phải
  giới hạn **loại nội dung**) — xử lý tương tự cách xử lý AI-11 ở mục 5.3: verify định tính trên số thật, không
  tự đoán biên chính xác.
- **Chế độ đóng màn theo màn hình:** EP {màn Lock, single wallpaper → tự đóng sau 1 lần chọn (BG-05) · màn Lock,
  multi-select bật → không tự đóng, chọn nhiều lần · màn Home Screen → luôn tự đóng (BG-07, khác hành vi Lock)}.

### 5.8 Decision Table — Trạng thái màn setup shortcut, tiền điều kiện "đang ở V2" (`SETUP-01`→`09`)

> Tách 2 bảng nhỏ theo đúng 2 màn hình khác nhau của test basis (mục 8 dòng 107 vs dòng 113) — không gộp chung vì
> UI, nút, tiêu đề hoàn toàn khác nhau.

**Bảng A — "Setup lần đầu" (SETUP-01/02/03):**

| ID | Sự kiện | Hiện gì | Nút chính | Nút phụ |
|---|---|---|---|---|
| A1 | Bấm "Tap to add shortcut" → thêm xong → quay lại app | (không lỗi) | "I've added it — check now" (to, tối, trên) | "Re-add shortcut" (nhạt, dưới) |
| A2 | Bấm nút chính, kiểm tra **không thấy** shortcut (lỗi chung) | Câu báo lỗi chung | "Re-add shortcut" (có dấu +) | "Try again" |
| A3 | Bấm nút chính, kiểm tra **không thấy** do **từ chối quyền đặt wallpaper** | Câu báo lỗi quyền wallpaper | "Try again" (không Re-add) | (không có) |

**Bảng B — "Settings → Set up shortcut, đã có V2" (SETUP-04/05/06):**

| ID | Điều kiện | Tiêu đề/mô tả | Nút | Bấm Next → |
|---|---|---|---|---|
| B1 | Chạy thành công **trong 24h qua** | "Shortcut is working!" ✅ / "Now let's make it run every day." | Chỉ Next (không Re-add, không "step 1") | Sang automation, **không** mở Shortcuts |
| B2 | Quá 24h hoặc chưa từng chạy | "Check your lock screen shortcut." | "I've added it — check now" | Mở Shortcuts chạy thử → quay về → kiểm tra → sang automation |
| B3 | Đã kiểm tra thành công (từ B1 hoặc B2), bấm **Back** từ automation | Về như B1 | Next | Sang lại automation, **không** chạy shortcut lần nữa (SETUP-06, tránh side-effect trùng) |

**BVA biên 24 giờ (B1 vs B2):** test tại thời điểm vừa qua mốc 24h (vd 23h59 → vẫn B1, 24h01 → chuyển B2) — đo
bằng đồng hồ thật hoặc đổi giờ hệ thống có kiểm soát, không rút ngắn bằng cách giả lập nếu chưa xác nhận công cụ
đo có sẵn (tương tự cảnh báo đã có ở `exploratory/03_shortcut-setup.md` cho Sunrise).

**SETUP-07/08/09 (checklist, không cần kỹ thuật phức tạp):** SETUP-07 verify bằng 1 case negative (thoát ở bước
automation → mở lại app → lời mời setup automation **không** hiện lại). SETUP-08/09 là 2 partition của cùng 1
dòng trạng thái: {automation chưa chạy lần nào → "Shortcut added · daily refresh not detected yet"} vs
{automation đã chạy → "Refreshed automatically …", ⚠️ gap #9 — chưa có baseline chuỗi cũ để đối chiếu, tự chụp
trước khi execute}.

### 5.9 Boundary case — Điểm vào `SETUP-10`, xác nhận ranh giới với `MIG` (`SETUP`)

> **Không** thiết kế lại toàn bộ `MIG` (đã có ở
> [test-plan-ios26-27-v3.md §5.6](../shortcuts/test-plan-ios26-27-v3.md#56-state-transition-testing--luồng-chuyển-từ-shortcut-cũ-sang-v2-mig-hoàn-toàn-mới)).
> Chỉ 2 case xác nhận đúng **điểm vào** (entry point), tái dùng state `S0`-`S4` đã định nghĩa ở tài liệu đó.

| ID | Tiền điều kiện | Sự kiện | Kỳ vọng |
|---|---|---|---|
| SETUP-10a | Máy "người dùng cũ" (chuẩn bị đúng [mục 7 test-plan-ios26-27-v3.md](../shortcuts/test-plan-ios26-27-v3.md#7-test-environment-matrix) — cài shortcut V1, có automation, đã Set vài lần), **chưa từng** bắt đầu luồng update (state `S0`) | Bấm bất kỳ nút "Set up shortcut" nào (Settings) | Vào đúng **bước 1** của luồng update 3 bước (transition `S0`→ bắt đầu, tương ứng `TC-J08/J09` của `MIG`) — **không** được thấy tiêu đề "Shortcut is working!"/"Check your lock screen shortcut." (2 màn của Bảng B mục 5.8, chỉ dành V2) |
| SETUP-10b | Cùng máy trên, đã dở dang ở state `S1` (đã Add shortcut V2 + chạy thử xác nhận, **chưa** xoá shortcut cũ) | Thoát app, mở lại, bấm "Set up shortcut" từ **entry point khác** (vd Home banner thay vì Settings) | **Resume** đúng vị trí dở dang (bước 2, giống `TC-J14` của `MIG` — dấu ✓ ở bước 1, không bắt đầu lại từ đầu) — **vẫn không** được thấy 2 màn của Bảng B dù đã gần hoàn tất |

### 5.10 Decision Table — Badge Done/To do trong Guide (`GUIDE`)

> Cross-check trực tiếp với state `S0`-`S4` của `MIG` theo đúng gợi ý traceability của test-analysis — không test
> độc lập badge shortcut mà không biết state migration thật đang ở đâu.

| ID | State shortcut (theo `MIG`) | Quyền lịch | Badge "Add the shortcut" | Badge "Allow calendar access" |
|---|---|---|---|---|
| G1 | Chưa cài, hoặc V1, hoặc dở dang `S1`-`S3` | — | **To do** | — |
| G2 | Hoàn tất `S4` (hoặc setup thẳng V2 lần đầu thành công) | — | **Done** (tick xanh) | — |
| G3 | — | Đã cấp | — | **Done** |
| G4 | — | Chưa cấp | — | **To do** |
| G5 | — | Bật/tắt qua iOS Settings rồi quay lại app | — | Đổi **ngay**, không cần thao tác thêm (GUIDE-03) |

Mục khác (automation, design, note…) **không** có badge (GUIDE-05, negative/scope check). Badge hiển thị đúng
ngôn ngữ, không đẩy tiêu đề dài bị cắt (GUIDE-06, cùng nhóm ngôn ngữ với SETUP-08).

### 5.11 Error guessing / Checklist-based Testing — Hồi quy (`REG`, trích nguồn cụ thể)

- **REG-05** (render nhiều event không treo) — trích nguồn trực tiếp bug **#316** đã có báo cáo thật (test basis
  tự tham chiếu), không phải giả thuyết — chạy sớm, không phải case thăm dò cuối đợt.
- **REG-04** (Pro persist, không hiện nhầm paywall) — error guessing kinh điển cho mọi thay đổi liên quan
  IAP/paywall: tắt app đột ngột ngay sau khi mua Pro qua `PRO`, mở lại kiểm tra ngay.
- **REG-03** (account chỉ khởi tạo khi cần) — checklist tối thiểu: đăng nhập/đăng xuất, đăng nhập lại nhiều lần
  liên tiếp (race condition cổ điển cho lazy-init) — ⚠️ nguồn gốc thay đổi kiến trúc này chưa rõ (gap #10 mục
  10), verify hành vi quan sát được, không tự suy diễn nguyên nhân.
- **Cơ hội, không phải test condition chính thức:** thử tái hiện `BUG-003` (pill "SAVE 100%" với `discount: 1`)
  mỗi lần mở `plan-list` trong nhóm `PRO` — theo dõi bằng dữ liệu remote config hiện tại, không publish payload
  riêng cho việc này.

---

## 6. Risk-based prioritization

> Risk level = risk likelihood × risk impact (§5.2.1), đã tính sẵn theo từng test condition ở
> [test-analysis mục 2](test-analysis-pr317.md#2-test-condition-đã-ưu-tiên-hoá). Tổng **73** test condition —
> **P1 = 23 · P2 = 34 · P3 = 16**. Danh sách dưới đây nhóm theo chủ đề, không lặp lại nguyên văn — dẫn theo mã ID
> của test-analysis.

**P1 — chặn phát hành (23 test condition):**
- **`PRO` (9/18 — mảng rủi ro cao nhất PR):** PRO-01/02/03 (nền tảng cơ chế preview + nhãn PRO + popup — sai 1
  trong 3 gãy toàn bộ trải nghiệm mới), PRO-05 (không tự set ngay sau thanh toán — tránh ghi đè ngoài ý muốn),
  PRO-06/07/08 (rollback data integrity — mất ảnh riêng của user hoặc set nội dung Pro ngoài luồng xác nhận là
  **mất dữ liệu thật**, không chỉ lỗi hiển thị), PRO-10 (regression cho user đã trả tiền), PRO-17 (rollback làm
  mất **nội dung chữ đã gõ**, không chỉ style).
- **`AI` (4/22):** AI-02 (happy path, giá trị cốt lõi cả tính năng), AI-08 (đọc ảnh 2 lần = COGS kép thật, tính
  năng duy nhất trong app có chi phí trực tiếp theo lượt), AI-11 (ẩn nút đúng lúc hết lượt — nếu sai, user vẫn
  dùng được ngoài giới hạn kinh doanh), AI-16 (biên overlap sai gây báo nhầm hàng loạt, ảnh hưởng lòng tin vào
  tính năng lõi).
- **`SETUP` (6/10):** SETUP-01/02/03 (bước đầu tiên user cấp quyền để tính năng lõi hoạt động — sai chặn toàn bộ
  giá trị app), SETUP-04/05 (đúng chỗ 2 luồng V1/V2 dễ đá nhau nhất), SETUP-10 (chính là điểm giao 2 test basis —
  hiện sai màn khiến user V1 tưởng đã xong mà chưa migrate, mất tác dụng của cả luồng `MIG`).
- **`GUIDE` (1/6):** GUIDE-01 — badge sai khiến user tưởng đã xong và bỏ dở migration, rủi ro tương tự đã từng
  được cảnh báo ở `exploratory/03_shortcut-setup.md` (SCT-N09) cho overlay cũ.
- **`REG` (3/5):** REG-03 (đăng nhập hỏng chặn toàn bộ đồng bộ/chia sẻ), REG-04 (hiện paywall nhầm cho user đã
  mua — vỡ lòng tin trực tiếp), REG-05 (treo app khi set wallpaper — bug đã có báo cáo thật, #316).
- **`BG`:** không có test condition nào được test-analysis xếp P1 — nhóm rủi ro thấp nhất trong 6 nhóm.

**P2 (34 test condition):** phần lớn `AI` (cảnh báo trùng lịch không-biên, persistence, gating theo quyền —
AI-01/04/05/07/09/14/15/18/19/22), `PRO` phụ (PRO-04/09/11/12/13/14/15/16/18 — mở paywall giữ state, ranh giới
"có sẵn" chờ gap #5, vuốt đóng, Dynamic Type/l10n, Cutout/style chữ dùng thử), hầu hết `BG` (thứ tự hiển thị,
giới hạn Free — BG-01/02/03/05/06/08/11), `SETUP-06/08` (tránh side-effect trùng khi Back, dòng trạng thái +
l10n), `GUIDE-02/03/04/06`.

**P3 (16 test condition):** UI phụ không ảnh hưởng luồng chính (AI-03/06/10/12/13/17/20/21, BG-04/07/09/10/12,
SETUP-07/09, GUIDE-05).

**Chờ xác nhận, chưa gán risk cụ thể (mục 10):** AI-11/AI-22 (BVA đúng số, đã P1/P2 theo hành vi định tính),
PRO-04 nhánh huỷ thanh toán (ER4 mục 5.4), PRO-09 nhánh nhiều lựa chọn có sẵn (ER1 mục 5.4), PRO-18 nhánh style
chữ mặc định (DR5 mục 5.6) — verify hành vi thật khi execute, không tự đoán pass/fail cho tới khi có câu trả lời.

---

## 7. Test environment matrix

- **Thiết bị bắt buộc (theo đúng mục "Chuẩn bị" test basis):** 1 iPhone **iOS 27**, 1 iPhone **iOS 26** — cả 2
  test **toàn bộ 6 nhóm**, test basis không phân biệt hành vi theo iOS version cho PR #317.
- **Máy "người dùng cũ" riêng cho `SETUP-10`** — dùng lại đúng máy/quy trình chuẩn bị đã có ở
  [mục 7 test-plan-ios26-27-v3.md](../shortcuts/test-plan-ios26-27-v3.md#7-test-environment-matrix): cài shortcut
  V1, bật automation, đã Set vài lần, **không** cài đè hết luồng `MIG` tới `S4` — cần 1 bản giữ nguyên ở `S0` (cho
  SETUP-10a) và 1 bản đã dừng ở `S1` (cho SETUP-10b, có thể dùng cùng máy, chạy 10a trước rồi đưa lên `S1` cho
  10b).
- **Tài khoản/Tier:** mặc định **Free**; dùng nút dev **Grant Pro (dev)** / **Revoke Pro (dev)** trong Settings
  để chuyển qua lại khi test `PRO`, `REG-04` (Pro persist), `GUIDE` (không liên quan tier nhưng cần verify không
  đổi hành vi).
- **Dữ liệu ảnh chuẩn bị trước (theo đúng test basis):**
  - 1 ảnh có chữ rõ (thời khoá biểu/poster) — cho AI-02.
  - 1 ảnh **không có chữ** (phong cảnh) — cho AI-04.
  - 1 ảnh trang sách **rất nhiều chữ** — cho AI-05.
  - ≥1 ảnh riêng đã đặt làm wallpaper Lock — cho PRO-07 (xác nhận rollback không mất ảnh gốc).
  - Thư viện catalog Pro có ≥16 ảnh để test biên More (BG-01, mục 5.7) — quan sát thật, không tự thêm ảnh vào
    catalog (thuộc remote content, ngoài phạm vi QC can thiệp).
- **Dữ liệu lịch:** ít nhất 1 sự kiện Calendar vào ngày mai **15:00–16:00** (theo đúng test basis) — dùng cho
  toàn bộ BVA overlap ở mục 5.2.
- **Ngôn ngữ:** đổi qua **iOS Settings → Ink → Language** — bắt buộc verify tiếng Đức và tiếng Nga cho PRO-12,
  tiếng Việt cho SETUP-08/GUIDE-06/BG-04.
- **Baseline bắt buộc chụp TRƯỚC khi bắt đầu đợt test này:** màn Settings dòng "Refreshed automatically …" trên
  build **hiện tại trước PR #317** (không có tài liệu nào trong repo ghi lại chuỗi cũ để đối chiếu — gap #9 mục
  10). Nếu không còn build cũ để chụp, ghi rõ "không chụp được baseline" trong test summary thay vì bỏ qua case.
- **Build:** Ink Dev qua Firebase App Distribution, đúng bản đã merge PR #317 — không dùng bản TestFlight/App
  Store.

---

## 8. Entry criteria

- Build Ink Dev xác nhận đúng bản đã merge PR #317, cài qua Firebase App Distribution trên cả 2 máy iOS 26/27.
- Đã chuẩn bị đủ dữ liệu ảnh (3 loại), sự kiện Calendar ngày mai 15:00–16:00, và catalog Pro có ≥16 ảnh (mục 7).
- Máy "người dùng cũ" cho `SETUP-10` đã chuẩn bị đúng quy trình `MIG` (mục 7) — cài shortcut V1, có automation,
  đã Set vài lần, **trước khi** chạy bất kỳ case nào của nhóm `SETUP`.
- **Baseline chuỗi "Refreshed automatically …"** đã chụp trên build trước PR #317 (mục 7) — làm trước khi bắt đầu
  nhóm `SETUP`, nếu không có sẵn build cũ thì ghi nhận rõ trong test summary, không chặn toàn bộ entry criteria
  vì đây chỉ là 1 test condition P3 (SETUP-09).
- Nút dev "Grant Pro (dev)"/"Revoke Pro (dev)" đã verify hoạt động đúng (chuyển tier thành công, có thể quan sát
  ngay trên UI) — sai ở đây làm toàn bộ nhóm `PRO`/`REG-04` không đáng tin.
- **Khuyến nghị chạy sớm (thứ tự thực thi, không phải điều kiện cứng):**
  - `ER1`/`ER2`/`ER3` (mục 5.4, PRO-01/02/03/05) — nền tảng của toàn bộ Decision Table + State Transition `PRO`,
    nếu cơ chế preview/nhãn PRO/popup sai thì mọi case Pro khác không đáng tin.
  - `SETUP-10a`/`SETUP-10b` — xác nhận ranh giới V1/V2 trước khi tin bất kỳ case nào của Bảng A/B mục 5.8 (nếu
    ranh giới sai, cách hiểu toàn bộ nhóm `SETUP` cần xem lại).
  - `REG-03/04/05` — chạy sớm trong đợt test, không để cuối cùng, vì có thể chặn cả app chứ không riêng tính
    năng mới (đúng khuyến nghị traceability của test-analysis).

## 8.1 Suspension & Resumption criteria

- **Suspend toàn cụm `PRO`** nếu phát hiện nội dung Pro được **set/lưu thật** mà **không** qua bước xác nhận lần
  2 sau khi mua (transition `T3`→`T4` mục 5.5 bị bỏ qua), hoặc nếu "đường tắt" thoát ra Home Screen rồi chạy
  shortcut làm áp dụng mode Pro chưa xác nhận (PRO-08) — đây là vi phạm trực tiếp cơ chế paywall, không phải lỗi
  hiển thị đơn thuần. Dừng ngay, báo dev, không tiếp tục các case `PRO` khác cho tới khi xác nhận phạm vi ảnh
  hưởng.
- **Suspend cục bộ `PRO`** nếu "Set without Pro"/"Save without Pro" làm **mất nội dung do user tự tạo** (ảnh
  riêng — PRO-07, hoặc nội dung chữ đã gõ — PRO-17), không chỉ mất style/preview Pro — đây là mất dữ liệu thật,
  không phải rollback đúng thiết kế. Dừng, ghi đủ bằng chứng (ảnh gốc trước/sau), báo dev ngay.
- **Suspend toàn cụm `SETUP`** nếu `SETUP-10a`/`SETUP-10b` **fail** (user V1 bị đưa nhầm vào 2 màn "Shortcut is
  working!"/"Check your lock screen shortcut." thay vì `MIG`) — vì khi đó cách hiểu tiền điều kiện "đang ở V2"
  của toàn bộ Bảng A/B mục 5.8 không còn đúng, mọi case `SETUP-01`→`09` đã chạy trước đó cần chạy lại sau khi
  xác nhận lại ranh giới thật.
- **Suspend cục bộ `AI`** nếu tái hiện được việc đọc ảnh **2 lần** cho cùng 1 lần gửi khi Retry sau lỗi mạng
  (AI-08 fail) — COGS kép là rủi ro nghiêm trọng, dừng, báo ngay, không lặp lại nhiều lần để "xem có ổn định
  không".
- **Suspend toàn cụm `REG`** nếu tái hiện được app **hiện nhầm paywall** cho user đang là Pro sau khi mở lại app
  (REG-04) — vỡ lòng tin trực tiếp của người đã trả phí, ghi đủ bằng chứng rồi báo ngay.
- **Resume:** chạy lại từ đầu cụm đã suspend sau khi có xác nhận/patch từ dev, không tiếp tục giữa chừng.

## 9. Exit criteria

- 100% checklist 11 mục test basis (`qc-ai-photo-pro-picks-setup-vi.md`) đã tick pass hoặc có bug kèm severity.
- 0 bug P1 mở — đặc biệt: toàn bộ nhóm `PRO` liên quan data integrity (PRO-05/06/07/08/17), `SETUP-10`
  (a **và** b), `REG-03/04/05`.
- `SETUP-10a`/`SETUP-10b` đã chạy và **pass** — nếu không, không được sign-off cho toàn bộ nhóm `SETUP` (xem
  suspension criteria mục 8.1).
- Regression `REG` đã chạy đủ 5/5 test condition; cơ hội tái hiện `BUG-003` đã ghi nhận (pass hoặc vẫn mở, không
  bỏ qua).
- Baseline "Refreshed automatically …" đã có kết quả đối chiếu (pass/khác/không chụp được đều là kết quả hợp lệ,
  không phải ô bỏ trống) cho `SETUP-09`.
- 10 gap ở mục 10 (+ gap mới #11) đã có câu trả lời bằng văn bản từ dev/PO, **hoặc** được ghi nhận rõ là gap đã
  biết trước khi sign-off — không tự động chặn exit nếu vẫn ở trạng thái "đã biết, chưa trả lời" khi tới hạn
  release, nhưng phải nêu rõ toàn bộ danh sách trong test summary report kèm case nào đang treo theo từng gap.

---

## 10. Gap cần làm rõ trước khi execute

> Cả 10 gap dưới đây **không chặn entry criteria (mục 8)** — theo đúng chỉ đạo user đã xác nhận (banner đầu tài
> liệu). Case liên quan vẫn viết và chạy được ở bước test-case, chỉ đánh dấu "⚠️ kết quả phụ thuộc câu trả lời gap
> #N" ngay trong case đó. Câu hỏi #8 gốc (test-analysis mục 4) đã **đóng** — xem `SETUP-10` mục 2/5.9, không liệt
> lại ở đây.

| # | Câu hỏi | Ảnh hưởng case |
|---|---|---|
| 1 | Giới hạn "lượt hỏi trong ngày" của Ink AI là bao nhiêu? — lặp lại lần thứ 3 trong repo, đề nghị PO/dev trả lời dứt điểm 1 lần cho toàn bộ tính năng Ink AI | ⚠️ AI-04, AI-11 (mục 5.3), AI-22 |
| 2 | Lần gửi ảnh bị lỗi mạng có bị tính là 1 lượt hỏi trong ngày không? | ⚠️ AI-08 (mục 5.1) |
| 3 | "1000 ký tự" đếm theo đơn vị nào (grapheme hiển thị hay UTF-16 code unit)? | ⚠️ AI-22 (mục 5.2, case tiếng Việt có dấu/emoji) |
| 4 | "Set without Pro" có rollback đúng **đồng thời** khi user chọn thử nhiều loại Pro cùng lúc (font+màu+ảnh+mode), hay chỉ verify riêng lẻ từng loại? | ⚠️ PRO-06, case `ER8` (mục 5.4) |
| 5 | Khi mẫu có nhiều lựa chọn Pro có sẵn và user chỉ đổi 1 trong số đó, popup "Keep your Pro picks?" có liệt luôn cả lựa chọn cũ chưa đổi không? | ⚠️ PRO-09, case `ER1` (mục 5.4) |
| 6 | User huỷ paywall hoặc thanh toán thất bại sau khi bấm Unlock Pro thì editor ở trạng thái nào? | ⚠️ PRO-04/05, case `ER4` (mục 5.4) |
| 7 | Trả style chữ Pro về mặc định trước khi bấm ✓ (Decorate) có được miễn hỏi giống xoá Cutout không? | ⚠️ PRO-18, case `DR5` (mục 5.6) |
| 8 | Nút "I've added it — check now" (bấm tay) có thay thế **hoàn toàn** overlay tự động cũ "Shortcut is working!" (hiện ngay sau "Always Allow", theo `exploratory/03_shortcut-setup.md` SCT-H08 cho V1), hay 2 cơ chế tồn tại song song ở 2 thời điểm khác nhau? | ⚠️ SETUP-01 (mục 5.8, Bảng A) |
| 9 | Chuỗi "Refreshed automatically …" hiện tại (trước PR #317) là gì — không tài liệu nào trong repo ghi lại | ⚠️ SETUP-09 (mục 5.8) — QC tự chụp baseline trước khi execute (mục 7/8), không cần chờ câu trả lời để bắt đầu |
| 10 | "Tài khoản giờ chỉ được khởi tạo khi cần" có thực sự thuộc phạm vi PR #317, hay chép từ 1 PR/spec khác (vd `login-and-calendar-sharing`)? Nếu thuộc PR khác, cần test basis gốc | ⚠️ REG-03 (mục 5.11) |

---

## 11. Coverage gap — case chưa được test basis liệt kê

| # | Thiếu | Vì sao là gap |
|---|---|---|
| 11 🆕 | "Chạm giới hạn Free" khi multi-select ảnh Lock (BG-06) — test basis **không nêu con số cụ thể** của giới hạn này | **Phát hiện mới, ngoài 10 câu đã biết trước ở mục 4 test-analysis.** Tương tự gap #1 (quota Ink AI) nhưng ở một cơ chế hoàn toàn khác (số lượng ảnh riêng, không phải lượt hỏi AI) — không có tài liệu nào trong repo (kể cả `1.2.15-decoration-inkai.md`, `ai-assistant-tab.md`) ghi lại con số này. Không chặn scope — verify định tính theo mục 5.7, hỏi PO/dev khi có dịp chốt cùng lúc với gap #1 |
| — | Kill app / bị iOS thu hồi giữa lúc đang **"chọn thử"** ≥1 lựa chọn Pro (trước khi bấm nút xác nhận, state `T1` mục 5.5) | Test basis chỉ mô tả rõ hành vi khi thoát **có chủ đích** ra Home Screen (PRO-08) mà không đề cập app bị kill hẳn — chính test basis tự cảnh báo rủi ro "state preview bị lưu nhầm vào storage" (PRO-08), nên trường hợp kill app giữa `T1` là mở rộng hợp lý của đúng lo ngại đó, QC tự suy luận thêm |
| — | Đổi tier Free ↔ Pro qua nút dev **ngay khi** đang có lựa chọn Pro pending chưa xác nhận trong Editor (race giữa dev toggle và state UI) | Không thuộc hành vi người dùng thật (chỉ xảy ra trên bản Dev), nhưng là cách nhanh nhất để lộ bug nếu state Pro-pending được tính toán sai theo tier tại thời điểm render thay vì tại thời điểm chọn — QC tự phát hiện khi thiết kế mục 5.4/5.5 |
| — | iPad — test basis mục "Chuẩn bị" chỉ nêu 1 máy iOS 27 + 1 máy iOS 26 (iPhone), không nhắc iPad | Test basis không yêu cầu, nhưng `14_edit-wallpaper`/`08_paywall` (mục 3.1) đều có biến thể iPad theo flow map — xử lý giống cách `test-plan-ios26-27-v3.md` mục 11 đã làm: ghi nhận là coverage gap, không tự thêm vào scope |
| — | Nhiều ảnh Pro catalog được chọn thử liên tiếp (đổi qua đổi lại) rồi **force-quit** app trước khi bấm bất kỳ nút nào | Test basis chỉ mô tả 1 lựa chọn thử tại 1 thời điểm cho mỗi case cụ thể (PRO-07, PRO-08) — chưa có case cho việc đổi ý nhiều lần liên tiếp trong cùng 1 phiên trước khi thoát đột ngột |
| — | Dữ liệu tiếng Việt có dấu trong nội dung sự kiện do Ink AI tạo (tên sự kiện, mô tả) khi hiển thị trong dòng cảnh báo "Overlaps with \<tên sự kiện\>" (AI-14) | Test basis chỉ cho ví dụ tiếng Anh ("gym tomorrow 3pm") — chưa có case xác nhận tên sự kiện tiếng Việt có dấu hiển thị đúng trong dòng cảnh báo cam, dù đây là app có UI tiếng Việt |

---

**Bước tiếp theo:** chạy skill **test-case** trên chính file này (`test-plan-pr317.md`) để sinh
`test-cases-pr317.md`, dùng trực tiếp các bảng/dữ liệu ở mục 5 làm nguồn thiết kế case cụ thể.
