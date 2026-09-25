# Test Plan — Shortcut wallpaper Home Screen + Automation iOS 27 (bản v3, sau merge PR #302)

> **Test basis (3 file, đã vào `main` qua PR #302, 2026-09-24):**
> 1. [qc-shortcut-home-screen-ios26-27-V2.md](../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2.md) — spec
>    chính, 17 mục, gồm 2 sơ đồ Mermaid mô tả token/branching (mục 5) dùng làm nguồn cho mục 5.1/5.2 dưới đây.
> 2. [qc-shortcut-triggers-ios27.md](../../specs/shortcuts/qc-shortcut-triggers-ios27.md) — chi tiết 5 automation
>    đi kèm shortcut.
> 3. [qc-notification-automation-ios27.md](../../specs/shortcuts/qc-notification-automation-ios27.md) — automation
>    kích hoạt qua notification passive, cơ chế "Remove after the run".
>
> Build: **Ink Dev** dựng từ `main` (Xcode hoặc App Distribution) — **không** phải bản App Store.
>
> **Chuẩn:** ISTQB Foundation Level v4.0.1 (test basis → test object → kỹ thuật thiết kế → rủi ro → entry/exit)
> **Test condition đã ưu tiên hoá:** [test-analysis-ios26-27-v3.md](test-analysis-ios26-27-v3.md) — 169 test
> condition (nhóm A–L), dùng thẳng cho mục 2/6 dưới đây, **không phân tích lại từ đầu**.
> **Test case cụ thể:** [test-cases-ios26-27-v3.md](test-cases-ios26-27-v3.md) — sẽ sinh bởi skill test-case sau
> khi test plan này được duyệt, thiết kế trực tiếp từ các kỹ thuật ở mục 5.
> **Đối chiếu tài liệu đã có:**
> [exploratory/03_shortcut-setup.md](../../exploratory/03_shortcut-setup.md) (checklist SCT cho shortcut **cũ**,
> vẫn dùng lại phần happy-path/permission làm regression),
> [bugs/bug-log.md § BUG-004](../../../bugs/bug-log.md#bug-004--event-tạo-trên-google-calendar-không-xuất-hiện-trên-wallpaper-hôm-sau)
> (regression bắt buộc cho nhóm `AUTO`),
> [test-plan-ios26-27.md](test-plan-ios26-27.md) (mẫu chuẩn về độ sâu/cách trình bày, feature gần nhất),
> [test-plan-ios26-27-v2-updated-SUPERSEDED.md](test-plan-ios26-27-v2-updated-SUPERSEDED.md) (kỹ thuật thiết kế
> cũ — State Transition 9 nhánh token, Decision Table 1–5 — **chỉ tham khảo cách làm, KHÔNG copy nguyên số liệu**
> vì cấu trúc if/else nền tảng đã đổi, xem mục 1 bên dưới),
> [test-cases-ios26-27.md](test-cases-ios26-27.md) (case cụ thể cho bản V2 cũ — nhóm `OLD`/`PAIR` phần lớn còn
> tái dùng được).
> **Ngày lập:** 2026-09-25 · **Người lập:** QC

> **Về trạng thái DRAFT của test-analysis:** [test-analysis-ios26-27-v3.md](test-analysis-ios26-27-v3.md) tự đánh
> dấu `⚠️ DRAFT cục bộ` vì còn 2 câu hỏi ảnh hưởng risk của 2 test condition cụ thể (TC-F04, TC-J09/TC-J10) và 1
> câu hỏi về thứ tự hiển thị (P3). Test plan này **chủ động chạy tiếp** theo đúng xác nhận trực tiếp của
> user/QA — cả 3 câu hỏi được giữ nguyên làm gap mở ở **mục 10**, không chặn phạm vi hay entry criteria (mục 8)
> của tài liệu này. Chi tiết lý do không chặn: xem mục 10.

---

## 1. Phát hiện khi đối chiếu với tài liệu đã có

1. **Cấu trúc if/else nền tảng đã đổi hẳn so với bản trước — không kế thừa được Decision Table/State Transition
   cũ.** [test-plan-ios26-27-v2-updated-SUPERSEDED.md](test-plan-ios26-27-v2-updated-SUPERSEDED.md) mô tả **7
   action Set / 2 action Switch**, đã cross-check tay xác nhận đúng cho nhánh `fix/ios27-shortcut-automation`.
   Bản merge (`main`, PR #302) test basis mới công bố **11 Set / 3 Switch** — con số này **chưa được QC cross-
   check tay trên chính build đã merge** (test-analysis mục 1 #1). Toàn bộ mục 5.1/5.2 dưới đây được thiết kế lại
   từ 2 sơ đồ Mermaid của test basis mới, không copy bảng cũ. TC-A05 (đếm action thật) phải chạy **trước tiên**
   trong đợt test — nếu số thật lệch khỏi 11/3, toàn bộ Decision Table 1 và State Transition ở mục 5.1/5.2 phải
   viết lại trước khi tin bất kỳ case nào khác của nhóm `HS`.
2. **Nghi vấn "Same + Blur tắt không Set gì cả" của bản trước (gap #1, v2-updated) không còn xuất hiện trong test
   basis mới.** Bảng "tra nhanh" mục 5 của spec hiện hành liệt **Same as Lock, bình thường → token `same`/
   `same-blur`, 1 lần Set (Lock + Home cùng lúc)** — tức Same **luôn** ghi Home dù Blur tắt hay bật, khác hẳn cấu
   trúc bất đối xứng nghi ngờ trước đó. Không coi đây là "đã fix" một cách mặc định — verify lại bằng TC-C02
   (test-analysis) như một dòng bình thường của Decision Table 1, không phải regression case riêng cho bug cũ.
3. **`exploratory/03_shortcut-setup.md`** viết cho shortcut **V1** (`Generate Latest Wallpaper`, 1 action Set duy
   nhất) — phần lớn case cụ thể (SCT-H, SCT-N liên quan số lượng action) không áp dụng được nguyên trạng cho
   V2 (11 Set/3 Switch). Vẫn tái dùng được: khung 3-dialog quyền (D1/D2/D3) làm cơ sở tư duy cho quyền đặt
   wallpaper (dù V2 gộp nhiều action Set hơn), và toàn bộ mục §5/§6 (SCT-N20–N32, SCT-E) làm nguồn coverage gap
   ở mục 11 vì test basis mới không tự lặp lại các case "phá vỡ sau khi setup xong" đó.
4. **`test-cases-ios26-27.md`** (case cho bản V2 cũ, trước khi có toast/migration/GATE mới) — nhóm `TC-SH-OLD`
   (mục 4 nguồn, luồng cũ không vỡ) và phần lớn `TC-SH-PAIR` (mục 7, cặp wallpaper) **về cơ bản không đổi** giữa
   V2 cũ và bản merge hiện tại (test-analysis xác nhận mục 4 và mục 7 test basis mới không đổi kỳ vọng so với
   trước) — mục 5.3/5.10 dưới đây dẫn chiếu thẳng case cũ thay vì thiết kế lại. Nhóm `TC-SH-WARN` cũ (cảnh báo
   vàng) đã bị **thay thế hoàn toàn** bởi cửa sổ "Update your shortcut" (`GATE`, mục 8 test basis mới) — không
   còn cảnh báo vàng trong editor, case cũ không dùng lại được, phải thiết kế mới (mục 5.5).
5. **`bugs/bug-log.md § BUG-004`** (event Google Calendar thiếu trên wallpaper hôm sau, "Need info", chưa
   reproduce) — vẫn mở, và automation "When Google Calendar is closed" (nhóm `AUTO`, mới hoàn toàn trong mục 9
   test basis) là một đường trigger **khác** với Sunrise từng dùng để test bug này trước đây. Đưa vào regression
   bắt buộc ở cả 2 đường trigger (TC-G17 và Sunrise) thay vì coi 1 đường là đủ.
6. **Mục 13 (chuyển từ shortcut cũ sang V2) là hoàn toàn mới — không có tiền lệ ở bất kỳ test-plan/test-case nào
   trước đó.** Đây là mảng rủi ro #2 theo chính thứ tự spec tự xếp (chỉ sau "luồng cũ không vỡ"), với 7 entry
   point hội tụ về cùng 1 luồng update 3 bước (TC-J07) — thiết kế bằng State Transition Testing (mục 5.6), không
   có bảng cũ để đối chiếu.

---

## 2. Test object — In scope

> Mã nhóm dùng làm tiền tố ID khi skill test-case sinh case cụ thể (vd `TC-SH-INS-01`).

| # | Mã nhóm | Hạng mục | Nguồn (mục test basis) | Ghi chú |
|---|---|---|---|---|
| 1 | `INS` | Cài shortcut & giữ nhiều shortcut cùng lúc | mục 1, 3 (spec chính) | Nền tảng — TC-A05 (đếm 11 Set/3 Switch) phải chạy **đầu tiên**, xem mục 1 #1 |
| 2 | `OLD` | Luồng set wallpaper cũ không vỡ + Toast báo kết quả | mục 4 (spec chính) | Regression thuần (Set/Update/xoá shortcut/Spotlight/2 loại template) + nhóm Toast hoàn toàn mới (vị trí hiển thị) |
| 3 | `HS` | Bốn chế độ Home Screen × Blur, skip-unchanged, HEIC, tốc độ | mục 5 (spec chính) | Trung tâm bản update — State Transition 9 token (mục 5.1) + Decision Table 7 dòng (mục 5.2) |
| 4 | `OWN` | Ảnh home riêng — My photo trong Ink (A) và tự chọn qua iOS, giữ Don't change (B) | mục 6 (spec chính) | B là "core promise" của Don't change — TC-D11/D12 |
| 5 | `PAIR` | Cặp wallpaper | mục 7 (spec chính) | Cơ chế đã có tiền lệ ở `test-cases-ios26-27.md` — chỉ đổi tên 4 chip |
| 6 | `GATE` | Cửa sổ "Update your shortcut" | mục 8 (spec chính) | Thay thế hoàn toàn cảnh báo vàng cũ. TC-F04 (nhánh Don't change) treo chờ gap #2 mục 10 |
| 7 | `MIG` | Chuyển từ shortcut cũ sang V2 (lời mời, luồng update 3 bước, "Two Ink shortcuts") | mục 13 (spec chính) | **Hoàn toàn mới**, rủi ro #2 theo spec. TC-J10 treo chờ gap #3 mục 10. Cần môi trường máy "người dùng cũ" riêng (mục 7/8) |
| 8 | `AUTO` | Automation iOS 27 — phần app + 5 automation chi tiết + trigger qua notification | mục 9 (spec chính), toàn bộ `qc-shortcut-triggers-ios27.md`, toàn bộ `qc-notification-automation-ios27.md` | Nhóm lớn nhất (80 test condition: G, G2, G3). Chỉ test được trên **iOS 27** |
| 9 | `XVER` | Chéo phiên bản (1 link cho mọi iOS) | mục 10 (spec chính) | Ngắn — compatibility thuần |
| 10 | `DBG` | Công cụ Debug (Last shortcut run, Wallpaper format, log console) | mục 12 (spec chính) | Công cụ đo nền tảng cho `HS` (tốc độ) — verify sớm |
| 11 | `HOW` | Trang "How updates work" | mục 14 (spec chính) | Rủi ro thấp nhất theo spec tự xếp (#9/9) |
| 12 | `ANA` | Event analytics | mục 15 (spec chính) | Quan sát nội bộ qua Firebase DebugView, không chặn UX người dùng |

---

## 3. Out of scope

- **Shortcut Production hiện tại** (link `dd5b40be…`) — chỉ dùng để đối chiếu hành vi trong `OLD`/`GATE`/`MIG`,
  không test độc lập như một luồng riêng.
- **App Ink Prod trên App Store** — chưa có action mới, test basis tự xác nhận build test là **Ink Dev**.
- **Localization đầy đủ** cho chữ mới trong mục Home Screen/Debug — test basis mục 16 tự xác nhận "chỉ tiếng
  Anh ở bản test, sẽ dịch trước khi phát hành" — **không** log gap l10n cho các mục này (Home Screen chip, Blur,
  Debug). Ngoại lệ: các màn **đã dịch** trước đó (Guide, sheet mời chuyển, trang How updates work — TC-K05, TC-
  G51) vẫn phải test l10n vì test basis không liệt các màn này vào ngoại lệ.
- **Logic chọn event hiển thị trên wallpaper** (thuật toán chọn lịch nào hiện) — chỉ liên quan việc *set đúng
  ảnh*, không phải *nội dung* ảnh, trừ khi regression BUG-004 (đưa vào nhóm `AUTO`).
- **Link `43e6966e…`** (bản bị sửa tay, chỉ 1 automation giờ cố định 00:05, không có "V2" trong tên) — không
  dùng để test bất kỳ case chức năng nào, chỉ dùng để hiểu nguồn gốc lịch sử của bug Lock/Home đổi chỗ (TC-G22).

### 3.1 Ảnh hưởng chéo tới flow khác (regression impact ngoài phạm vi note)

> Đối chiếu [screenshot-naming.md §7](../../../.claude/rules/screenshot-naming.md#7-flow-map--ink-calendar-ios) —
> chỉ liệt đúng flow có trong bảng flow map đó.

| Flow | Ảnh hưởng? | Lý do |
|---|---|---|
| `03_shortcut-setup` | **Trực tiếp** | Toàn bộ 12 test object nằm trong flow này |
| `04_discover` | **Gián tiếp** | Đường vào chỉnh Home Screen là tab Background của editor template; "Set as current"/"Update" ở đây kích hoạt shortcut chạy |
| `14_edit-wallpaper` | **Gián tiếp, nhẹ** | Mục Home Screen (`HS`) nằm trong cùng tab Background của editor — không chạm phần vẽ tay/chữ/emoji/tách nền (Decorate) mà `14_edit-wallpaper` mô tả, chỉ dùng chung màn hình cha |
| `10_lockscreen` | **Gián tiếp** | Kết quả cuối cùng (wallpaper thật) hiện ở đây; đối chiếu quan sát HEIC (`HS`) và regression BUG-004 |
| `05_calendar` | **Gián tiếp** | Nguồn event cho wallpaper; automation "Calendar closed"/"Google Calendar closed" (`AUTO`) chạm trực tiếp flow này |
| `09_settings` | **Gián tiếp** | Entry point "Set up shortcut" khác Discover, mục Debug (`DBG`) và trang How updates work (`HOW`) đều nằm ở Settings |
| `08_paywall` | **Gián tiếp** | No calendar / My photo là Pro — chặn bằng paywall (`HS`, TC-C03/C04) |
| `06_task`, `07_note`, `01_onboarding`, `02_permission` | **Không ảnh hưởng** | Không entry point, không data pipeline dùng chung |
| `11_share`, `12_ai-assistant`, `13_community` | **Không áp dụng** | Chưa build (Phase 2) |

---

## 4. Test levels & test types

- **Level:** System testing, black-box, trên **Ink Dev dựng từ `main`** (Xcode hoặc App Distribution) — QC không
  có quyền vào code; mọi kết luận cấu trúc token dựa trên đọc trực tiếp test basis (2 sơ đồ Mermaid) + cross-
  check tay khi execute, không phải đọc source.
- **Functional:** 9 nhánh token × mode/blur/redraw (`HS`), skip-unchanged (`HS`), persist Own photo (`OWN`), cặp
  wallpaper (`PAIR`), cửa sổ Update your shortcut (`GATE`), luồng update 3 bước (`MIG`), 5 automation + trigger
  qua notification (`AUTO`), toast đúng vị trí (`OLD`).
- **Non-functional (ISO 25010, §2.2.2):**
  - **Performance efficiency:** skip-unchanged nhanh hơn rõ rệt so với ghi đầy đủ (`HS`, đo bằng `DBG`); Same as
    Lock nhanh hơn No calendar khi No calendar phải ghi home (`HS` TC-C09).
  - **Compatibility:** iOS 26.x (không automation) và iOS 27 (đầy đủ) bắt buộc cả hai (`XVER`); iPad nếu có sẵn
    máy, không bắt buộc.
  - **Reliability:** automation chạy đúng khi máy khoá qua đêm (`AUTO`), không tự trigger vòng lặp (`AUTO` TC-
    G21), không set 2 lần chồng nhau khi 2 trigger gần nhau (`AUTO` TC-G20/G30).
  - **Usability:** toast không chặn thao tác khi đang mở sheet (`OLD` TC-B09); nội dung notification tự động
    không lộ chi tiết kỹ thuật (`AUTO` G3).
  - **Reliability/Data integrity (không thuộc danh mục ISO 25010 riêng nhưng là risk cao nhất tài liệu):** ảnh
    riêng của user (own photo lẫn cặp wallpaper riêng ngoài Ink) không bao giờ bị ghi đè/xoá ngoài ý muốn
    (`PAIR`, `OWN`).
- **Change-related (§2.2.3 — confirmation + regression testing cụ thể):**
  - **Regression bắt buộc, không phải case thăm dò:** bug Lock/Home đổi chỗ lúc 00:05 (`AUTO` TC-G22) — đã có
    báo cáo thật, không phải giả thuyết.
  - **Regression BUG-004** (event Google Calendar thiếu) trên **cả 2** đường trigger: Sunrise và "Google Calendar
    closed" (`AUTO`).
  - **Regression checklist cũ:** happy path (SCT-H01–H19) và permission (SCT-N01–N05) của
    [exploratory/03_shortcut-setup.md](../../exploratory/03_shortcut-setup.md) chạy lại **trên shortcut V2 thật**
    (11 Set/3 Switch), không dựa vào kết luận cũ (viết cho 1 action Set duy nhất).

---

## 5. Kỹ thuật thiết kế test case

### 5.1 State Transition Testing — 9 token của shortcut (`HS`, kỹ thuật chính)

> Lấy trực tiếp từ 2 sơ đồ Mermaid ở mục 5 test basis chính (Bước 1: app chọn token · Bước 2: shortcut chạy theo
> token) + bảng "tra nhanh" đi kèm. Chọn State Transition thay vì Decision Table phẳng vì các biến **phụ thuộc
> lẫn nhau theo thời gian** — nhánh `redraw` chỉ xuất hiện khi Blur *vừa* đổi so với *lần chạy xong gần nhất*,
> không phải trạng thái tĩnh; và nhánh `pair` vs `lock` phụ thuộc **hash ảnh so với lần chạy trước** + mốc 24
> giờ. Đây đúng là điều Decision Table không biểu diễn được (thiếu yếu tố "so với lần trước").

| ID | Token | Điều kiện chuyển vào state này | Số lần Set | Home bị ghi? |
|---|---|---|---|---|
| HS-lock | `lock` | Don't change (mọi lần); hoặc No calendar/My photo mà ảnh home không đổi, blur không đổi, và chưa quá 24h | 1 (Lock) | Không |
| HS-same | `same` | Same as Lock, blur tắt, không vừa đổi so với lần chạy trước | 1 (Lock+Home cùng lúc) | Có, nét |
| HS-same-blur | `same-blur` | Same as Lock, blur bật, không vừa đổi | 1 (Lock+Home cùng lúc) | Có, mờ |
| HS-same-redraw | `same-redraw` | Same as Lock, blur *vừa* đổi (tắt) so với lần chạy trước | 2 | Có, nét (ghi lại để iOS vẽ lại) |
| HS-same-blur-redraw | `same-blur-redraw` | Same as Lock, blur *vừa* đổi (bật) | 2 | Có, mờ (ghi lại) |
| HS-pair | `pair` | No calendar/My photo, ảnh home đổi hoặc lần đầu hoặc >24h, blur tắt, không vừa đổi | 2 (Lock, rồi Home) | Có, nét |
| HS-pair-blur | `pair-blur` | Như trên, blur bật, không vừa đổi | 2 (Lock, rồi Home) | Có, mờ |
| HS-pair-redraw | `pair-redraw` | Như HS-pair, blur *vừa* đổi (tắt) | 3 | Có, nét (ghi lại) |
| HS-pair-blur-redraw | `pair-blur-redraw` | Như HS-pair, blur *vừa* đổi (bật) | 3 | Có, mờ (ghi lại) |

**Test theo valid transitions coverage (§4.2.4):** mỗi dòng trên phải được exercise ít nhất 1 lần (TC-C01, TC-
C11/C12 gộp cả 2 chiều bật/tắt Blur × 2 lượt mỗi chiều theo đúng yêu cầu test basis). Đo số Set thật bằng `DBG`
(Last shortcut run + log console `[InkShortcut] token=…`), không đoán qua thời gian chạy đơn thuần — TC-I01 (đo
đúng số liệu) phải verify **trước** khi tin bất kỳ phép đo tốc độ nào.

**Trạng thái toàn cục của 1 lần chạy** (theo state diagram thứ 2 của test basis): `Mode → Render → Sets →
Switch → Confirm → Success`, với `Failed` có thể nhánh ra ở bất kỳ bước nào trước Confirm. Điểm quan trọng nhất
cho case negative: **app chỉ ghi nhận blur/ảnh home "đã giao" sau Confirm** — một lần chạy dở dang (bị iOS kill,
user huỷ, hoặc lỗi) **không được** làm lần chạy sau bỏ qua nhầm bằng skip-unchanged. Đây là case negative bắt
buộc, không có trong 7 dòng bảng tra nhanh — xem mục 11 (coverage gap).

### 5.2 Decision Table 1 — Home Screen × Blur (bảng gốc mục 5 test basis, dùng làm checklist thực thi)

| ID | Chế độ | Blur | Lock screen | Home screen | Token tương ứng (§5.1) |
|---|---|---|---|---|---|
| DT1-01 | Don't change | — | Wallpaper có lịch | Không bị Ink set | `lock` |
| DT1-02 | Same as Lock | Tắt | Wallpaper có lịch | Cùng ảnh có lịch, nét | `same` |
| DT1-03 | Same as Lock | Bật | Wallpaper có lịch | Cùng ảnh có lịch, mờ | `same-blur` |
| DT1-04 | No calendar | Tắt | Wallpaper có lịch | Ảnh nền template, không lịch, không tối | `pair` |
| DT1-05 | No calendar | Bật | Wallpaper có lịch | Ảnh nền, mờ | `pair-blur` |
| DT1-06 | My photo | Tắt | Wallpaper có lịch | Ảnh người dùng chọn, nét | `pair` |
| DT1-07 | My photo | Bật | Wallpaper người dùng chọn, mờ | Ảnh người dùng chọn, mờ | `pair-blur` |

→ **Ghi chú triage (kế thừa phát hiện từ bản trước, vẫn đúng cấu trúc):** DT1-04/05 (No calendar) và DT1-06/07
(My photo) dùng chung nhánh token `pair`/`pair-blur` — khác biệt nội dung ảnh nằm hoàn toàn trong action
`Generate Home Screen Wallpaper` (No calendar: ảnh nền template; My photo: ảnh user chọn), không phải ở logic
rẽ nhánh của shortcut. Nếu chỉ 1 trong 2 mode sai mà mode kia đúng, root cause nằm trong logic chọn ảnh bên
trong action đó, không phải cấu trúc token.

### 5.3 Equivalence Partitioning — `INS`, `OWN`

- **Trạng thái thư viện shortcut khi cài mới (`INS`):** {chưa có shortcut nào tên `Ink Refresh Lock Screen V2` ·
  đã có 1 shortcut đang mang đúng tên đó · có shortcut V1 (cũ) đã bị đổi tên giả thành tên V2 để test negative
  (TC-A11) · có nhiều shortcut khác tên hợp lệ (đã đổi theo mục 3.2)}.
- **Nguồn ảnh My photo (`OWN`, nhóm D.A):** {vừa chọn mới từ Photos (TC-D02) · đã tải lên trước đó (TC-D02) ·
  ảnh catalog có vòng xoay tải (TC-D03) · chưa chọn ảnh nào (TC-D08, edge case P1)}.
- **Cặp wallpaper hiện tại khi cài mới hoặc khi Update (`PAIR`, `OWN` nhóm D.B):** {đang ở cặp ảnh riêng của
  user · đang ở cặp của Ink · cặp của Ink đã bị xoá trước đó (TC-E06) · cặp của Ink đã bị user tự chỉnh Home qua
  iOS, không qua Ink (TC-D10/D11, "core promise" của Don't change)}.
- **State của Own photo qua các thao tác khác (`OWN`):** {đổi template khác giữ nguyên mode (TC-D06, ảnh vẫn
  giữ) · chuyển sang No calendar rồi quay lại My photo (TC-D07, ảnh vẫn được chọn sẵn) · chuyển hẳn sang mode
  khác rồi Update (TC-D13, ảnh bị thay — đúng ranh giới ngược của TC-D11)}. Việc "state không đổi khi chuyển
  qua nhiều thao tác trung gian" phù hợp mô tả bằng chuỗi sự kiện State Transition đơn giản hơn là bằng bảng —
  test theo đúng trình tự TC-D04→D07 liên tiếp trên cùng 1 phiên, không tách rời từng bước.

### 5.4 Decision Table 2 — Vị trí hiển thị Toast (`OLD`, hoàn toàn mới)

| ID | Ngữ cảnh khi shortcut chạy xong | Toast hiện ở đâu | Có chồng 2 toast không |
|---|---|---|---|
| DT-TOAST-01 | Đang ở màn edit template, bấm Update, thành công | Ngay trên màn edit ("Lock screen updated") | Không |
| DT-TOAST-02 | Shortcut lỗi khi đang ở màn edit (đổi tên shortcut để app không tìm thấy) | Toast lỗi ngay trên màn edit | Không |
| DT-TOAST-03 | Đang mở sheet/popup trên màn edit khi shortcut chạy xong | Toast hiện trên cả sheet, **không chặn** thao tác (vẫn bấm được nút bên dưới) | Không |
| DT-TOAST-04 | Lỗi trong **luồng cài shortcut lần đầu** | Chỉ 1 thông báo lỗi của màn cài đặt | **Không được** có thêm toast lỗi thứ 2 |

Map trực tiếp TC-B07–B10 (test-analysis). Đây là 4 test condition duy nhất chưa từng có tiền lệ trong bất kỳ
test-plan/test-case nào trước — không có case cũ để đối chiếu.

### 5.5 Decision Table 3 — Cửa sổ "Update your shortcut" (`GATE`, thay thế hoàn toàn cảnh báo vàng cũ)

| ID | Máy đang dùng | Chế độ Home Screen chọn | Cửa sổ hiện? | Hành động | Kết quả |
|---|---|---|---|---|---|
| GATE-01 | Shortcut cũ (V1) | Khác Don't change | Có | (chưa bấm gì) | Shortcut **chưa** chạy |
| GATE-02 | Shortcut cũ | Khác Don't change | Có | "Just update my Lock Screen" | Shortcut cũ chạy như trước: lock đổi, home **không** theo chế độ đã chọn. Update lần nữa → cửa sổ hiện lại |
| GATE-03 | Shortcut cũ | Khác Don't change | Có | "Get the new shortcut" | Mở đúng luồng update `MIG` (mục 13.2) |
| GATE-04 | Shortcut cũ | Khác Don't change | Có | Vuốt đóng | Không có gì chạy; Update lần nữa → cửa sổ hiện lại |
| GATE-05 | Shortcut cũ | **Don't change** | ⚠️ **Không hiện** — treo chờ gap #2 (mục 10) | (không cần bấm) | Shortcut cũ chạy bình thường, home bị ghi đè bằng ảnh lịch, **không cảnh báo** — verify hành vi thật, **không tự kết luận pass/fail** cho tới khi có câu trả lời |
| GATE-06 | Đã chuyển hẳn sang V2 | Bất kỳ | **Không** hiện nữa | Update | Chạy thẳng V2 theo đúng chế độ |

### 5.6 State Transition Testing — Luồng chuyển từ shortcut cũ sang V2 (`MIG`, hoàn toàn mới)

> Test basis mô tả 3 bước tuần tự, hội tụ từ **7 entry point khác nhau** (lời mời, thẻ Guide, cửa sổ `GATE`,
> Settings, banner Home, ⓘ editor, trang `HOW`) — đúng kịch bản State Transition Testing: nhiều event dẫn vào
> cùng 1 tập state, và state phải **persist** qua việc thoát giữa chừng (TC-J14, resume).

**States:**
- `S0` — Chưa bắt đầu luồng update.
- `S1` — Bước 1 xong: đã Add shortcut V2 **và** chạy thử xác nhận thành công (không gọi nhầm shortcut cũ).
- `S2` — Bước 2 xong/bỏ qua: đã xoá shortcut cũ, hoặc bấm nút bỏ qua bước này.
- `S3` — Bước 3 xong: automation đã được tạo lại (iOS 26) hoặc đã bật Sunrise có sẵn (iOS 27).
- `S4` — Hoàn tất: mọi Update chạy thẳng V2, cửa sổ `GATE` không còn hiện (khớp GATE-06).

**Transitions chính (valid transitions coverage):**

| Từ state | Event | Đến state | Ghi chú |
|---|---|---|---|
| `S0` | Add shortcut → Shortcuts mở link V2 → Add Shortcut → app chạy thử V2 thành công | `S1` | TC-J08/J09. Thư viện có **cả 2** shortcut, **không** có Replace |
| `S0`/`S1` | Chạy thử **vẫn gọi shortcut cũ** | vẫn ở `S0`/`S1` (không tính xong) | ⚠️ TC-J09/J10 — UX khi thất bại lặp lại **chưa được spec mô tả**, treo chờ gap #3 (mục 10) |
| `S1` | Bỏ dở, thoát app, mở lại từ thẻ Guide | vẫn `S1` (dấu ✓ hiện cho bước 1) | TC-J14 — test khả năng resume, nút chính vẫn mở đúng luồng update tiếp tục từ bước 2 |
| `S1` | Xoá shortcut cũ đúng tên hướng dẫn → về app | `S2` | TC-J11 |
| `S1` | Bấm nút "bỏ qua" bước 2 | `S2` | TC-J11 (đường thay thế) |
| `S2` | Tạo lại automation (iOS 26) / bật Sunrise có sẵn (iOS 27) | `S3` | TC-J12 |
| `S3` | Bấm Update với Same as Lock/No calendar | `S4` | TC-J13 — xác nhận migration hoàn tất, home theo đúng chế độ |
| `S2`/`S3` (bỏ qua xoá) | Automation cũ chạy lại (sáng hôm sau hoặc chạy tay) | Sub-flow "Two Ink shortcuts" (13.3) | TC-J15–J20, xem sub-state bên dưới |

**Sub-state "shortcut cũ vẫn còn chạy" (13.3, chỉ khi bỏ qua bước xoá):**

| State | Event | Đến | Ghi chú |
|---|---|---|---|
| Bình thường (đã bỏ qua xoá) | Shortcut cũ chạy lần đầu kể từ lúc bỏ qua | Sheet "Two Ink shortcuts are running" hiện | TC-J15 |
| Cảnh báo đã hiện | Xoá shortcut cũ | Trở về `S2`→`S3`→`S4` bình thường, thẻ Guide biến mất | TC-J18 |
| Cảnh báo đã hiện | Không xoá, shortcut cũ tiếp tục chạy | Nhắc lại mỗi 3 ngày, tối đa 3 lần (BVA, mục 5.10) | TC-J19 |
| Cảnh báo đã hiện | Không có lần chạy cũ nào trong 7 ngày | Nhắc và thẻ Guide **tự hết** | TC-J19 (BVA, mục 5.10) |

### 5.7 State Transition Testing — Định nghĩa "App đã closed" (`AUTO`, ranh giới spec tự để ngỏ)

> Test basis tự đặt câu hỏi này (mục 4.2 `triggers-ios27.md`), không có đáp án sẵn — verify thực tế cả 3
> chuyển tiếp, ghi nhận state nào thật sự trigger automation "When Calendar is closed"/"When Google Calendar is
> closed"/"When Ink is closed", không giả định trước.

| State hiện tại | Chuyển sang | Có trigger automation "closed" không? |
|---|---|---|
| Foreground (đang mở app) | Background — về Home Screen (vuốt lên) | Theo test basis: **Có** (case cơ bản, TC-G13/G17) |
| Foreground | Background — chuyển sang app khác (App Switcher, không về Home) | **Chưa xác định** — TC-G14, verify |
| Foreground/Background | Terminated — vuốt tắt hẳn trong App Switcher | **Chưa xác định** — TC-G15, verify |

### 5.8 Decision Table 4 — 5 automation × điều kiện trigger (`AUTO`)

| ID | Automation | Điều kiện trigger | Kỳ vọng |
|---|---|---|---|
| DT-AUTO-01 | At sunrise, daily | Bình minh theo vị trí máy, máy khoá | Chạy đúng lúc, không hỏi xác nhận (TC-G11) |
| DT-AUTO-02 | When Ink is closed | Rời app Ink (kể cả không bấm Set/Update) | Chạy — nguy cơ set nhầm chỉ vì xem thử (TC-G19), và nguy cơ chạy đúp nếu rời ngay sau Update (TC-G20) |
| DT-AUTO-03 | When Calendar is closed | Rời app Lịch Apple sau khi sửa lịch | Chạy trong vài giây (TC-G13) |
| DT-AUTO-04 | When Google Calendar is closed | Rời app Google Calendar sau khi sửa lịch | Chạy trong vài giây, nếu có cài app (TC-G17); nếu **không cài** app → robustness case (TC-G18) |
| DT-AUTO-05 | When I get a notification from Ink | Nhận notification hợp lệ (xem EP mục 5.9) | Chạy ngay, kể cả máy khoá/passive (TC-G31/G32) |

Tất cả 5 dòng dùng chung điều kiện tiên quyết **TC-G06/G07** (máy sạch trước khi test, cả 5 automation đúng
trạng thái tắt khi mới cài) — đây là entry criteria riêng cho nhóm `AUTO`, xem mục 8.

### 5.9 Equivalence Partitioning + Boundary Value Analysis — Bộ lọc notification & trạng thái máy (`AUTO`, nhóm G3)

- **Bộ lọc Title/Body (EP):** {Title có `·` (hợp lệ) · Title không có `·` (TC-G38, negative)} × {Body có `Ink`
  (hợp lệ) · Body không có `Ink` (TC-G39, negative) · Body có `ink` viết thường (TC-G40, boundary hoa/thường)}.
  TC-G40 là biên giữa 2 partition case-sensitive, kết quả sơ bộ từ simulator là "không chạy" — cần verify lại
  trên máy thật, không copy làm kết luận cuối (test basis mục 1 #7).
- **Trạng thái máy khi notification tới (EP):** {máy khoá ngay lập tức (TC-G31, kịch bản quan trọng nhất) · máy
  khoá lâu, để yên (TC-G32) · máy mở, ở ngoài Ink (TC-G33) · đang mở chính Ink (TC-G35, không hiện banner)}.
- **Cài đặt thông báo của user khi trigger tới (EP, nhóm G3.4 — Exploratory vì spec không có đáp án sẵn):** {tắt
  hẳn thông báo Ink · tắt "Show on Lock Screen" giữ Notification Center · bật Scheduled Summary · bật Focus chặn
  Ink}.

### 5.10 Boundary Value Analysis — Cặp wallpaper, mốc thời gian

- **Số cặp wallpaper (2-value BVA, kế thừa nguyên cơ chế từ `test-cases-ios26-27.md`, không đổi):** trước/sau
  chạy đủ 4 chế độ (TC-E04): kỳ vọng **+0**; trước/sau bấm Update 3 lần liên tiếp (TC-E03): kỳ vọng **+0**.
- **Mốc 24 giờ cho skip-unchanged (`HS`, 3-value BVA):** 23h59 (vẫn skip, TC-C14) · đúng 24h00 (ranh giới, TC-
  C20b) · 24h01 (ghi lại đầy đủ 1 lần, TC-C20b). Test basis khẳng định rõ mốc này (khác bản trước từng có gap
  nghi ngờ đã bỏ mốc) — dùng nguyên giá trị test basis công bố, không cần hỏi lại.
- **Mốc "3 ngày / tối đa 3 lần" cho lời mời chuyển (`MIG`, 3-value BVA trên cả 2 trục thời gian và số lần):**
  đóng sheet lần 1 → chờ 2 ngày (chưa hiện lại) / đúng 3 ngày (hiện lại, TC-J03) / 4 ngày (đã hiện, không còn ý
  nghĩa test thêm) — lặp tới lần đóng thứ 2 và thứ 3 → sau lần đóng thứ **3**, không hiện lại nữa dù đã đủ 3
  ngày (boundary trên trục "số lần", cần test riêng, chưa có test condition tường minh trong test-analysis —
  xem mục 11, coverage gap).
- **Mốc "7 ngày không có lần chạy cũ nào" cho sheet "Two Ink shortcuts" (`MIG`, 3-value BVA):** 6 ngày (vẫn còn
  nhắc) / đúng 7 ngày (ranh giới) / 8 ngày (đã tự hết, TC-J19).

### 5.11 Exploratory testing (session-based, time-boxed)

> Chỉ dùng cho phần test basis **tự thừa nhận** không biết trước kết quả đúng (§4.4.2) — không dùng nhãn này cho
> case chưa kịp thiết kế kỹ. Charter cụ thể theo từng bảng thăm dò của 3 test basis (mục 11 spec chính, mục 8
> `triggers-ios27.md`, mục 6 `notification-automation-ios27.md`).

| Charter | Nhóm | Nguồn |
|---|---|---|
| No calendar có hỏi quyền đặt wallpaper 2 lần trong 1 lượt chạy không? | `HS` | TC-C24 |
| Số giây thực đo Same as Lock / No calendar, tách theo iOS 26/27 | `HS` | TC-C25 |
| Template nào bị vệt màu/chữ nhoè do nén HEIC (không ngưỡng khách quan) | `HS` | TC-C21/C22/C26 |
| Bật automation từ danh sách tab Automation trực tiếp hay phải vào Edit? | `AUTO` | TC-G08 |
| Mặc định mỗi automation là Run Immediately hay Run After Confirmation? | `AUTO` | TC-G09 |
| Sunrise có xin quyền vị trí lần đầu không? | `AUTO` | TC-G10 |
| Máy Apple Account khác cài link → automation có về máy, bật hay tắt? | `AUTO` | TC-G28 |
| Cài lại cùng link bằng Replace (kịch bản KHÔNG nên xảy ra qua app) → automation trùng dòng? | `AUTO` | TC-G26 |
| Tắt hẳn thông báo Ink / Scheduled Summary / Focus chặn Ink → trigger còn chạy? | `AUTO` | TC-G41–G44 |
| Thẻ "Ink's new shortcut" có tự biến mất khi đã chuyển xong V2 hoàn toàn không? (spec không nêu vòng đời) | `MIG` | TC-J21 |
| Thử cài file lên máy khác dải iOS đã chốt (chéo phiên bản hướng phụ) | `XVER` | Đối chiếu mục 10 spec chính |

### 5.12 Error guessing / Checklist-based Testing (§4.4.1/§4.4.3 — trích nguồn cụ thể, không đoán chung chung)

- **Regression checklist cũ SCT-H01–H19, SCT-N01–N05** — [exploratory/03_shortcut-setup.md](../../exploratory/03_shortcut-setup.md)
  §1–2 — chạy lại **trên shortcut V2 thật** (11 Set/3 Switch), không dựa kết luận cũ viết cho 1 action Set.
- **BUG-004** ([bugs/bug-log.md](../../../bugs/bug-log.md#bug-004--event-tạo-trên-google-calendar-không-xuất-hiện-trên-wallpaper-hôm-sau))
  — chạy lại trên **cả 2** đường trigger mới: Sunrise và "Google Calendar closed" (`AUTO`).
  Ghi ngày/build khi test lại, không coi "Need info" cũ là đã đóng.
  - **TC-G22 (bug Lock/Home đổi chỗ lúc 00:05, đã có báo cáo thật, nhóm `triggers-ios27.md` mục 5)** — đây là
    **regression case bắt buộc**, không phải case thăm dò. Error guessing dựa trên chính báo cáo lỗi thật đã
    biết: thử tái hiện đúng điều kiện đã báo (giờ 00:05, mode, blur, khoá/mở máy), ghi lại có tái hiện được
    bằng thao tác tay không.

### 5.13 `DBG`, `HOW`, `ANA` — checklist thực thi trực tiếp, không cần kỹ thuật phức tạp

Test basis đã tự liệt các dòng checklist rõ ràng, không có tổ hợp điều kiện phức tạp:
- **`DBG`:** verify "Last shortcut run" đúng 2 số liệu tách biệt (nền tảng đo cho `HS`), "Wallpaper format" đổi
  đúng PNG/JPEG/HEIC 1.0, log console lọc "Ink" đủ dòng `[InkShortcut]`, mục Debug chỉ có ở bản Dev.
- **`HOW`:** checklist theo 5 trạng thái (iOS 27 có/chưa có shortcut, iOS 26, scroll + nút I understand, l10n).
- **`ANA`:** đối chiếu tên event/tham số đúng bảng mục 15 spec chính qua Firebase DebugView/Realtime — kiểm tra
  đối chiếu chuỗi, không cần EP/BVA/Decision Table.

---

## 6. Risk-based prioritization

> Risk level = risk likelihood × risk impact (§5.2.1), đã tính sẵn theo từng test condition ở
> [test-analysis mục 2](test-analysis-ios26-27-v3.md#2-test-condition-đã-ưu-tiên-hoá). Danh sách dưới đây nhóm
> theo chủ đề, không lặp lại nguyên văn 169 dòng — dẫn theo mã TC của test-analysis.

**P1 — chặn phát hành (~72 test condition, các cụm chính):**
- **Nền tảng cài đặt (`INS`):** TC-A01, A04–A06, A09–A11 — sai ở đây làm mọi case sau không đáng tin. TC-A05
  (đếm 11 Set/3 Switch) chạy **trước tiên** trong toàn đợt test.
- **Luồng cũ không vỡ (`OLD`):** TC-B01–B04 — test basis tự xếp rủi ro #1 toàn tài liệu.
- **Trung tâm bản update (`HS`):** TC-C01, C03/C04 (Pro gating), C06 (Lock luôn nét), C11/C12 (redraw đổi ngay
  sau 1 lần), C14/C16/C18/C20 (skip-unchanged core mechanism + giao với Blur/automation).
- **Data integrity (`OWN`, `PAIR`):** TC-D02/D05/D08 (My photo core), D11/D12 (Don't change giữ ảnh tự chọn qua
  iOS — core promise), E01–E07 (toàn bộ nhóm cặp wallpaper — test basis tự đánh dấu "lỗi chặn phát hành" cho
  phần lớn dòng này).
- **`GATE`:** TC-F01/F02/F03/F06 — điểm vào chính của luồng migration (TC-F04 nhánh Don't change treo chờ gap
  #2, chưa gán risk, xem mục 10).
- **`MIG` (rủi ro #2 toàn tài liệu):** TC-J02/J04/J06–J09/J11–J13/J15 — luồng 3 bước + lời mời chuyển + "Two Ink
  shortcuts" (TC-J10 nhánh lỗi lặp lại treo chờ gap #3).
- **`AUTO` (nhóm lớn nhất, ~32 P1):** nền tảng máy sạch (TC-G06/G07), core promise Sunrise chạy khi khoá máy
  (TC-G11), race condition đã lường trước (TC-G19–G21), **regression bug đã có báo cáo thật** (TC-G22), công cụ
  chẩn đoán `old still running` (TC-G24), bộ lọc notification (TC-G38/G39), passive notification khi máy khoá
  (TC-G31/G32), recovery path quyền thông báo (TC-G45–G47/G50), chạy nền thật qua `BGTaskScheduler` (TC-G52),
  automation không theo tên khi đổi tên shortcut (TC-A09), kết quả sau mỗi lần automation (TC-G54).
- **`DBG`:** TC-I01 — công cụ đo nền tảng, sai thì mọi case tốc độ ở `HS` mất căn cứ.

**P2 (~65 test condition):**
- 7 dòng Decision Table 1 hiển thị đúng nội dung/blur (`HS` TC-C05/C07/C08/C10/C15/C17/C19), toast (`OLD` TC-
  B05/B06/B07–B09), cửa sổ `GATE` nhánh phụ (TC-F05), automation content/UX (`AUTO` TC-G01/G03–G05/G12), ranh
  giới "closed" chưa rõ (TC-G14/G15/G18), chéo phiên bản (`XVER` TC-H01/H02), analytics liên quan trực tiếp
  funnel migration (`ANA` TC-L03/L05/L07).

**P3 (~32 test condition + case thăm dò không xếp priority như bug thường):**
- UI phụ (`HS` TC-C02, `OWN` TC-D01/D09), số lần hỏi quyền (`INS` TC-A12, `HS` TC-C24 — exploratory), `HOW`
  (toàn bộ TC-K01–K05, rủi ro thấp nhất theo spec), `DBG` phụ (TC-I02–I04), `ANA` phụ (TC-L01/L02/L04/L06), toàn
  bộ case Exploratory ở mục 5.11 (không có đáp án đúng sẵn, không xếp priority như bug thường).

**Chờ xác nhận, chưa gán risk (mục 10):** TC-F04 (Q2), TC-J09/J10 (Q3) — không tự đoán pass/fail cho tới khi có
câu trả lời; verify hành vi thật và ghi lại khi execute.

---

## 7. Test environment matrix

- **Thiết bị bắt buộc:**
  - iPhone **iOS 26.x** — test `INS`/`OLD`/`HS`/`OWN`/`PAIR`/`GATE`/`MIG`/`XVER`/`DBG`/`HOW`/`ANA` (không có
    automation trên iOS 26).
  - iPhone **iOS 27** — test **toàn bộ**, bắt buộc cho `AUTO` (bật "Allow Running When Locked" ngay sau cài,
    TC-A04).
  - **Máy thứ hai, Apple Account khác** — bắt buộc cho `AUTO` (automation "đi theo" đúng máy, TC-G28) và `PAIR`
    (đối chiếu độc lập).
  - iPad — nếu có, cho ảnh home trên màn vuông + xoay ngang/dọc (không bắt buộc theo test basis — xem mục 11
    coverage gap).
  - **Máy "người dùng cũ" riêng cho `MIG`** — chuẩn bị theo đúng hướng dẫn đầu mục 13 test basis: cài bản Ink cũ
    (App Store hoặc bản Dev trước V2) → setup shortcut cũ (link `199d89e6…`), bật automation hằng ngày, bấm Set
    vài lần → **cài đè** bản Ink mới lên, **không xoá app**. **Không dùng chung môi trường** với `HS`/`OWN`/
    `PAIR` (vốn đã cài sẵn V2) — nhóm `MIG` cần bắt đầu từ trạng thái "đang dùng shortcut cũ" thật.
- **Dữ liệu chuẩn bị trên mỗi máy:**
  - Thư viện wallpaper (giữ tay trên màn khoá) ≥3 cặp, trong đó ≥1 cặp là ảnh riêng của người test — bắt buộc để
    thấy rõ `PAIR`/`OWN` không bị ghi đè ngoài ý muốn.
  - App **Lịch** (Apple Calendar) và **Google Calendar** đã cài, tài khoản Google đã kết nối Ink — bắt buộc cho
    `AUTO` (TC-G17). Cần thêm 1 máy **không cài** Google Calendar để test riêng TC-G18.
  - Notification cho Ink Dev đang **bật** ở Settings hệ thống — bắt buộc để nhận notification tự động của `AUTO`
    nhóm G3 (test qua mục Debug "Test notification automation" không cần bật trước, nhưng nhóm G3.5 "thông báo
    thật" thì cần).
- **File shortcut:** cài trực tiếp qua link iCloud (mục 1 spec chính) — `Ink Dev`:
  `https://www.icloud.com/shortcuts/007226dffb9240439830f196201a5ed6`. Không dùng link `43e6966e…` cho bất kỳ
  mục đích test chức năng nào.
- **Công cụ phụ trợ:** Xcode (chạy bản Dev, đọc log console `[InkShortcut]`, chỉ máy thật mới simulate được
  `BGTaskScheduler` cho TC-G52), Firebase Console project dev (DebugView/Realtime cho `ANA`).
- **Build:** Ink Dev dựng từ `main` (đã merge PR #302, 2026-09-24) — qua Xcode hoặc App Distribution, **không**
  phải bản TestFlight/App Store.

---

## 8. Entry criteria

- Build Ink Dev xác nhận dựng đúng từ `main` sau PR #302 (2026-09-24), qua Xcode hoặc App Distribution.
- Mỗi máy test đã chuẩn bị thư viện wallpaper ≥3 cặp (≥1 cặp ảnh riêng), app Lịch + Google Calendar theo đúng
  mục 7, **trước khi** cài shortcut mới.
- Máy "người dùng cũ" cho `MIG` đã chuẩn bị đúng quy trình mục 7 (cài shortcut cũ, có automation, đã Set vài
  lần) **trước khi** cài đè bản Ink mới.
- **Máy sạch trước khi bắt đầu `AUTO`** (TC-G06): xoá hết shortcut Ink cũ, xác nhận tab Automation không còn
  dòng nào của Ink — làm trước khi chạy bất kỳ case nào trong nhóm `AUTO`, nếu không baseline không đáng tin.
- Người test đã đọc mục 3 test basis chính (quy tắc app chạy shortcut theo tên khớp chính xác) trước khi bắt
  đầu — sai bước này làm hỏng baseline của `INS`/`OLD`/`GATE`.
- **Khuyến nghị chạy trước (smoke thứ tự thực thi, không phải điều kiện cứng):** TC-A05 (đếm 11 Set/3 Switch) và
  TC-I01 (Last shortcut run đúng số liệu) nên verify **sớm nhất** trong đợt test — cả hai là căn cứ cho toàn bộ
  Decision Table 1/State Transition (mục 5.1/5.2) và mọi phép đo tốc độ ở `HS`.

## 8.1 Suspension & Resumption criteria

- **Suspend toàn cụm** nếu phát hiện **2 shortcut cùng mang tên `Ink Refresh Lock Screen V2`** cùng lúc — test
  basis tự cảnh báo "kết quả không đoán trước được". Dừng, đổi tên lại đúng quy ước mục 3.2, coi mọi kết quả ghi
  nhận trong lúc trùng tên là **không đáng tin**, chạy lại từ đầu.
- **Suspend cục bộ `HS`** nếu TC-A05 cho ra số Set/Switch **khác** 11/3 test basis công bố — dừng ngay, không
  tiếp tục Decision Table 1/State Transition (mục 5.1/5.2) cho tới khi cập nhật lại đúng cấu trúc thật, báo dev
  nếu số lệch so với spec.
- **Suspend toàn cụm `AUTO`** nếu phát hiện **vòng lặp** ở automation "Ink is closed" (TC-G21) — nguy cơ spam
  chạy liên tục, tiêu pin/dữ liệu — dừng ngay, không thử lại nhiều lần để "xem nó tự dừng không".
- **Suspend toàn cụm `AUTO`** nếu tái hiện được bug Lock/Home đổi chỗ (TC-G22) — bug đã biết, không cần lặp lại
  nhiều lần để xác nhận thêm; ghi đủ bằng chứng (mode/blur/khoá-mở/chạy tay) rồi báo ngay, tiếp tục các case
  automation khác bình thường (không phải bug chặn toàn bộ nhóm, chỉ cần ghi nhận).
- **Suspend toàn cụm** nếu phát hiện app **KHÔNG** tự chuyển màn khoá về cặp của Ink sau mỗi lần chạy (`PAIR`) —
  test basis xác nhận đây là hành vi thiết kế đúng (mục 7, mục 16 "không phải bug"). Nếu không tự quay về, dừng
  ngay, xác nhận với dev trước khi tiếp tục.
- **Suspend cục bộ `MIG`** nếu vô tình cài đè shortcut V2 bằng **Replace** (cùng tên) khi máy "người dùng cũ" đã
  có shortcut cùng tên — test basis cảnh báo hậu quả không thể khôi phục (automation cũ vẫn gọi bản đã ẩn khỏi
  thư viện). Dừng, chuẩn bị lại máy "người dùng cũ" từ đầu.
- **Suspend cục bộ Sunrise (`AUTO`)** nếu đổi tạm trigger sang "Time of Day, 2–3 phút" để rút ngắn thời gian chờ
  tự làm automation ngừng chạy hẳn — theo đúng cảnh báo đã có ở
  [exploratory/03_shortcut-setup.md §10](../../exploratory/03_shortcut-setup.md#10--smoke-cho-flow-này) ("Không
  rút ngắn bằng cách đổi giờ hệ thống"). Chuyển hẳn sang chờ Sunrise thật (qua đêm) nếu nghi ngờ.
- **Resume:** chạy lại từ đầu cụm đã suspend sau khi có xác nhận/patch, không tiếp tục giữa chừng.

## 9. Exit criteria

- 100% checklist các mục nguồn tương ứng (spec chính mục 1, 3–10, 12–15; `triggers-ios27.md` mục 3–6;
  `notification-automation-ios27.md` mục 4–5) đã tick pass hoặc có bug kèm severity.
- TC-A05 (đếm 11 Set/3 Switch) và TC-I01 (Last shortcut run đúng số liệu) đã có kết quả runtime ghi nhận rõ ràng
  — không được để trống, vì cả hai là căn cứ nền tảng cho `HS`.
- Bảng thăm dò [mục 11 spec chính](../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2.md#11-bảng-ghi-kết-quả-thăm-dò),
  [mục 8 `triggers-ios27.md`](../../specs/shortcuts/qc-shortcut-triggers-ios27.md#8-bảng-ghi-kết-quả) và
  [mục 6 `notification-automation-ios27.md`](../../specs/shortcuts/qc-notification-automation-ios27.md#6-bảng-trả-lời)
  đã điền đủ cho cả iOS 26 và iOS 27 (nếu áp dụng) — "không chạy được"/"—" cũng là kết quả hợp lệ, không phải ô
  bỏ trống.
- 0 bug P1 mở — đặc biệt: nhóm `PAIR` (không tạo cặp thừa/ghi đè ảnh riêng), `OWN` TC-D08/D11/D12, `AUTO` TC-
  G21/G22 (vòng lặp, Lock/Home đổi chỗ), `MIG` TC-J08/J09/J15.
- Regression SCT-H01–19/N01–05 đã chạy lại trên shortcut V2 thật; BUG-004 đã thử lại trên **cả** Sunrise và
  Google Calendar closed.
- Cả 3 câu hỏi ở mục 10 đã có câu trả lời bằng văn bản từ dev/PM, **hoặc** được ghi nhận rõ là gap đã biết trước
  khi sign-off (đã được user xác nhận chấp nhận theo đúng ghi chú đầu tài liệu này — không tự động chặn exit nếu
  vẫn ở trạng thái "đã biết, chưa trả lời" khi tới hạn release, nhưng phải nêu rõ trong test summary report).

---

## 10. Gap cần làm rõ trước khi execute

> **Cả 3 gap dưới đây KHÔNG chặn entry criteria (mục 8) của test plan này** — user đã xác nhận trực tiếp chạy
> tiếp test-plan ngay, giữ nguyên 3 câu hỏi này làm gap mở. Case liên quan vẫn viết được ở bước test-case, chỉ
> đánh dấu "⚠️ kết quả phụ thuộc câu trả lời gap #N" ngay trong case đó.

1. **Thứ tự thật của tab Automation** — `qc-shortcut-triggers-ios27.md` mục 1 ghi thứ tự **Sunrise → notification
   from Ink → Ink closed → Calendar closed → Google Calendar closed**; `qc-notification-automation-ios27.md` mục
   2 ghi **Sunrise → Calendar closed → Google Calendar closed → Ink Dev closed → notification from Ink Dev**
   (notification đứng **cuối**, không phải thứ 2) — cả 2 tài liệu đều tự nhận đang mô tả cùng 1 sự thật (thứ tự
   tab thật của iOS, không phải thứ tự Guide gợi ý bật). **Ảnh hưởng:** đúng 1 test condition P3 duy nhất (nội
   dung mô tả thứ tự hiển thị trong Guide, nhóm `AUTO` TC-G04) — không chặn bất kỳ case chức năng nào khác của
   `AUTO`. Cách xử lý khi execute: verify trực tiếp trên máy thật (đây là sự thật quan sát được, không phụ thuộc
   tài liệu nào đúng), ghi lại thứ tự thật quan sát được, không cần chờ câu trả lời trước khi bắt đầu.

2. **Cửa sổ "Update your shortcut" không cảnh báo cho chế độ Don't change** (ảnh hưởng `GATE`, TC-F04/GATE-05) —
   2 cách hiểu: (a) **chủ ý, chấp nhận được** — Don't change trên shortcut cũ vốn không có tác dụng gì đặc biệt
   (shortcut cũ không hiểu chế độ này), hệ quả home bị ghi đè bằng ảnh lịch là hành vi mặc định đã biết trước,
   không cần cảnh báo riêng; (b) **gap UX thật** — "Don't change" (nghĩa "đừng đụng vào Home") lại chính là
   trường hợp kỳ vọng bị vi phạm rõ nhất (home bị ghi đè dù user chọn "đừng đổi"), nhưng là chế độ **duy nhất**
   trong 4 chế độ không được cảnh báo. **Ảnh hưởng:** quyết định TC-F04/GATE-05 là **pass** (đúng thiết kế) hay
   **fail** (báo bug/feature gap) — cần câu trả lời PM/dev trước khi kết luận case này, nhưng **không** cần trả
   lời trước khi bắt đầu execute — verify hành vi thật trước (nó có đúng như spec mô tả "không hiện cửa sổ,
   shortcut cũ chạy bình thường" không), giữ pass/fail của case này **treo** cho tới khi có câu trả lời, tiếp
   tục các case `GATE`/`MIG` khác bình thường.

3. **UX khi xác nhận chạy thử V2 thất bại lặp lại ở bước 1 luồng update** (ảnh hưởng `MIG`, TC-J09/TC-J10) — spec
   mục 13.2 chỉ nói "nếu lần chạy thử lại gọi shortcut cũ → không được tính là xong", không mô tả app có báo
   lỗi, hướng dẫn thử lại, hay giới hạn số lần thử không. **Ảnh hưởng:** cần câu trả lời để thiết kế case cho
   đường lỗi (negative path) của bước 1 với kỳ vọng cụ thể — nếu không có câu trả lời trước khi execute, QC sẽ tự
   quan sát hành vi thực tế trên máy khi chạy TC-J10 và **báo lại như một phát hiện mới** (không tự coi im lặng
   là "đúng thiết kế", cũng không tự coi là bug nếu chưa có kỳ vọng rõ để so sánh).

---

## 11. Coverage gap — case chưa được test basis liệt kê

| Thiếu | Vì sao là gap |
|---|---|
| Lần chạy shortcut **dở dang** (bị iOS kill, user huỷ, hoặc lỗi giữa chừng) không được làm lần chạy **sau** bỏ qua nhầm bằng skip-unchanged | Test basis mô tả cơ chế "chỉ ghi nhận đã giao sau Confirm" (mục 5.1 test plan này, từ state diagram) nhưng không có checklist cụ thể nào test negative case này — suy luận trực tiếp từ chính cơ chế test basis mô tả, cần verify thật |
| iPad — 4 chế độ Home Screen trên màn vuông, xoay ngang/dọc | Test basis chỉ liệt "iPad nếu có" ở môi trường, không có case riêng cho layout iPad ở mục 5 |
| Regression đầy đủ SCT-N06–N32 (bỏ dở, cấu hình automation sai, phá vỡ sau setup, edge case môi trường) của `exploratory/03_shortcut-setup.md` | Test basis mới chỉ tập trung phần thay đổi (Home Screen, migration, GATE, automation), không tự khai lại toàn bộ case cũ này cho shortcut V2 |
| Sau lần đóng sheet mời chuyển thứ **3** (đã đạt trần "tối đa 3 lần"), có còn cách nào khác vào lại lời mời không (ngoài thẻ Guide "See what's new")? | Test basis chỉ nói "tối đa 3 lần tổng cộng", không mô tả trạng thái cuối cùng sau khi đạt trần — biên trên của BVA mục 5.10 chưa có test condition tường minh trong test-analysis |
| Notification `update_lockscreen`/notification tự động bị user **tự xoá/vuốt tắt** banner trước khi automation kịp bắt | Cả 3 test basis không nhắc — ảnh hưởng trực tiếp độ tin cậy của nhóm G3 nếu banner bị xoá quá nhanh trước khi hệ thống trigger kịp đọc |
| Nhiều notification tự động dồn lại (máy offline lâu, nhận bù nhiều notification cùng lúc khi có mạng lại) — automation có chạy nhiều lần hay chỉ 1 lần? | Suy luận rủi ro mới của QC, không có trong bất kỳ tài liệu nào trong 3 test basis |
| User đã hoàn tất `MIG` (state `S4`) rồi **cài lại thủ công** shortcut V1 (undo migration ngoài ý muốn) — app phản ứng thế nào? | Test basis chỉ mô tả chiều chuyển tiếp thuận (V1→V2), không có case nào cho chiều ngược lại |
| Đổi chế độ Home Screen **trong lúc** automation đang chạy (race giữa thao tác tay đổi mode và 1 lần chạy automation đang xử lý dở) | Test basis có race condition cho "Ink closed đua với Update" (TC-G19/G20) nhưng không có case race cho riêng hành động đổi mode UI trong khi automation khác đang chạy |
| Xoá **toàn bộ** cặp wallpaper trong thư viện (không còn cặp nào, kể cả cặp riêng của user) rồi Update | Cả 3 test basis chỉ mô tả xoá "1 cặp khác" hoặc "chính cặp của Ink" — chưa có case "thư viện trống hoàn toàn" |

---

**Bước tiếp theo:** chạy skill **test-case** trên chính file này (`test-plan-ios26-27-v3.md`) để sinh
`test-cases-ios26-27-v3.md`, dùng trực tiếp các bảng/dữ liệu ở mục 5 làm nguồn thiết kế case cụ thể.
