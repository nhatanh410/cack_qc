# Test Plan — Shortcut wallpaper mới: Home Screen (iOS 26), Automation & Trigger (iOS 27) — bản V2-updated

> ⚠️ **SUPERSEDED — không dùng tài liệu này để chạy test.** Lập từ test basis nhánh
> `fix/ios27-shortcut-automation` (chưa vào `main`). PR #302 đã merge vào `main` 2026-09-24 với
> thay đổi đủ lớn (action count, tên chip, 2 luồng mới) nên test basis gốc không còn đúng. Xem
> test-plan mới lập từ
> [qc-shortcut-home-screen-ios26-27-V2.md](../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2.md)
> hiện hành. Giữ file này lại chỉ để đối chiếu lịch sử — kỹ thuật thiết kế (State Transition 9
> nhánh token, Decision Table) vẫn còn giá trị tham khảo cho test-plan mới.

> ⚠️ **Còn 2 gap ảnh hưởng scope/risk chưa đóng — xem mục 10, gap #1 và #2.** Theo đúng tiền lệ đã có ở
> [test-plan-ios26-27.md](test-plan-ios26-27.md) (từng ship với 9 gap mở ở mục 10), tài liệu này **không bị
> chặn** vì 2 gap đó — chúng được đưa vào mục 10 kèm mức ảnh hưởng cụ thể, và mục 8.1 (Suspension) có điều kiện
> dừng riêng nếu gap #1 hoá ra là bug thật khi execute. **Có thể dùng tài liệu này để chạy skill test-case.**

> **Test basis:**
> [qc-shortcut-home-screen-ios26-27-V2-updated.md](../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2-updated.md)
> (Home Screen, iOS 26 + 27) và
> [qc-shortcut-triggers-ios27.md](../../specs/shortcuts/qc-shortcut-triggers-ios27.md) (4 automation + trigger
> qua notification, **chỉ iOS 27**) — cùng 1 bản build hiện tại (đã xác nhận qua Q5, xem
> [test-analysis §1 #7](test-analysis-ios26-27-v2-updated.md#7--tên-file-shortcut-khác-nhau-giữa-2-test-basis--đã-đóng-q5)),
> nhánh `fix/ios27-shortcut-automation`, chưa vào `main`, test trên **Ink Dev** dựng từ Xcode.
> **Không đụng tới** [test-plan-ios26-27.md](test-plan-ios26-27.md) / [test-cases-ios26-27.md](test-cases-ios26-27.md)
> đã có (viết cho bản **V2** cũ) — 2 file đó giữ nguyên, không sửa.
> **Test condition đã ưu tiên hoá:** [test-analysis-ios26-27-v2-updated.md](test-analysis-ios26-27-v2-updated.md)
> — 97 test condition, dùng thẳng cho mục 2/6 dưới đây, không phân tích lại từ đầu.
> **Chuẩn:** ISTQB Foundation Level (test basis → test object → kỹ thuật thiết kế → rủi ro → entry/exit)
> **Test case cụ thể:** `test-cases-ios26-27-v2-updated.md` — sẽ sinh bởi skill test-case sau khi test plan này
> được duyệt, thiết kế trực tiếp từ các kỹ thuật ở mục 5 dưới đây.
> **Đối chiếu tài liệu đã có:** [test-plan-ios26-27.md](test-plan-ios26-27.md) (bản trước, style/mã nhóm case
> tái dùng ở đây: `INS/OLD/HS/OWN/PAIR/WARN/AUTO/XVER`, thêm mới `TOAST/TRIG/DBG`),
> [exploratory/03_shortcut-setup.md](../../exploratory/03_shortcut-setup.md),
> [bugs/bug-log.md § BUG-004](../../../bugs/bug-log.md#bug-004--event-tạo-trên-google-calendar-không-xuất-hiện-trên-wallpaper-hôm-sau).
> **File shortcut thật:** [test-data/ink-shortcut-final-4/](../../test-data/ink-shortcut-final-4/) (đã cross-check
> tay, xem test-analysis §1.2) — file `ink-shortcut-final/` (cũ, dùng cho bản V2) hiện **rỗng**, đã bị xoá khỏi
> ổ đĩa 2026-09-22, không dùng cho đợt test này.
> **Ngày lập:** 2026-09-23 · **Người lập:** QC

---

## 1. Phát hiện khi đối chiếu với tài liệu đã có

1. **Số action Set/Switch của spec sai, đã xác nhận bằng cross-check tay trên máy thật.** Mục 3.1 test basis
   công bố "11 action Set Wallpaper và 3 action Switch"; thực tế là **7 Set / 2 Switch**. Không dùng số của spec
   để viết checklist đếm action — dùng số thật (xem [test-analysis §1.1](test-analysis-ios26-27-v2-updated.md#11-bảng-đối-chiếu-spec-v2-updated-do-dev-cung-cấp-vs-thực-tế-cross-check-tay-của-qc-2026-09-22)).
2. **Bất đối xứng cấu trúc thật giữa nhánh Same và nhánh Pair khi xử lý Blur — nghi vấn bug nghiêm trọng nhất
   đợt này.** Nhánh `pair` (Photo only/Own photo) có đầy đủ `If blur {...} Otherwise {...}`; nhánh `same` chỉ có
   `If blur {...}`, **thiếu hẳn `Otherwise`**. Hệ quả suy ra được (chưa verify runtime): mode **Same + Blur tắt**
   — dù tắt từ đầu hay vừa tắt — **không Set gì cả** trước khi Switch, tức Home (và có thể cả Lock) không đổi.
   Đây là gap #1 ở mục 10, ảnh hưởng trực tiếp toàn bộ Decision Table 1 (nhóm HS).
3. **Dev báo miệng 2 thay đổi chưa có trong spec:** (a) Same mode giờ cũng có cơ chế skip-unchanged như Photo
   only/Own photo; (b) có thể đã bỏ mốc "24 giờ vẫn ghi đầy đủ 1 lần". Cả 2 mâu thuẫn với mục 5 test basis. Đây
   là gap #2 ở mục 10.
4. **Phạm vi automation mở rộng gấp 4 lần so với V2-updated tự mô tả.** V2-updated mục 9 chỉ nhắc 1 automation
   (Sunrise). Test basis thứ 2 tiết lộ shortcut thật mang sẵn **4 automation** (Sunrise, When Ink/Calendar/Google
   Calendar closed) — kéo theo 1 bug **đã có báo cáo thật** (Lock/Home đổi chỗ lúc 00:05, nay là TC-87/`AUTO`)
   và 1 rủi ro race condition đã lường trước (automation "Ink closed" đua với Update thủ công, TC-84–86).
5. **Cơ chế trigger thứ 5, chưa từng có trong bất kỳ tài liệu nào trước đây — trigger qua Notification.** Phát
   hiện từ ảnh chụp thật (không phải từ spec): automation có thể được kích hoạt bởi **"When I receive a
   notification, Title contains 'update_lockscreen'"**, song song với trigger theo giờ. Đã xác nhận đây là thiết
   kế thật (Q6), không phải hệ quả của bản test bị sửa tay. Toàn bộ nhóm `TRIG` (mục 2) là case hoàn toàn mới.
6. **"Own photo" suýt bị hiểu nhầm là đã gỡ bỏ.** Dev ban đầu báo Own photo đã bị bỏ (do share code path với
   Photo only), sau đính chính lại vẫn còn — chỉ là 1 hiểu lầm giữa "share code" và "gỡ UI". Không có thay đổi
   scope thật, nhưng đáng ghi lại vì đã suýt làm sai lệch toàn bộ nhóm `OWN`.

---

## 2. Test object — In scope

| # | Mã nhóm | Hạng mục | Nguồn (mục) | Ghi chú |
|---|---|---|---|---|
| 1 | `INS` | Cài shortcut + chuyển qua lại nhiều shortcut bằng đổi tên | mục 1, 3 (V2-updated) | Nền tảng cho mọi mục khác — số action đúng (7 Set/2 Switch) phải verify trước tiên |
| 2 | `OLD` | Luồng set wallpaper cũ không vỡ (Off mode) | mục 4 (V2-updated) | Regression thuần, note tự xếp rủi ro cao nhất |
| 3 | `TOAST` | 🆕 Toast báo kết quả hiện ngay trên màn đang mở | mục 4 (V2-updated) | Hoàn toàn mới, chưa có tiền lệ ở test-plan V2 |
| 4 | `HS` | 4 chế độ Home Screen × Blur, skip-unchanged, HEIC, tốc độ | mục 5 (V2-updated) | **Phụ thuộc gap #1 (mục 10)** — Same+Blur tắt nghi vấn không hoạt động |
| 5 | `OWN` | Own photo trong Ink (A) + tự chọn qua iOS, Ink Off (B) | mục 6 (V2-updated) | B hoàn toàn mới — chính thức hoá risk QC từng tự phát hiện trước V2-updated |
| 6 | `PAIR` | Cặp wallpaper | mục 7 (V2-updated) | Không đổi so với V2 — dẫn chiếu thẳng Decision Table cũ |
| 7 | `WARN` | Cảnh báo "Needs the new Ink shortcut" | mục 8 (V2-updated) | Không đổi so với V2 |
| 8 | `AUTO` | 4 automation có sẵn (Sunrise, Ink/Calendar/Google Calendar closed) + kiểm tra chung sau mỗi lần chạy | mục 9 (V2-updated) + toàn bộ [triggers-ios27.md](../../specs/shortcuts/qc-shortcut-triggers-ios27.md) | **Chỉ test được trên máy iOS 27.** Bao gồm regression bắt buộc cho bug đã biết (Lock/Home đổi chỗ) |
| 9 | `TRIG` | 🆕 Trigger automation qua Notification (`update_lockscreen`) | Ảnh chụp thực tế (Q6) | **Chỉ iOS 27.** Không có trong bất kỳ spec nào, suy ra từ hành vi thật |
| 10 | `XVER` | Chéo phiên bản (file iOS 27 trên máy iOS 26) | mục 10 (V2-updated) | Gap `MinimumClientVersionString` kế thừa nguyên trạng từ V2, chưa được làm rõ thêm |
| 11 | `DBG` | 🆕 Công cụ Debug (Last shortcut run, Wallpaper format, log console) | mục 12 (V2-updated) | Hoàn toàn mới — là công cụ đo nền tảng cho nhóm `HS` (tốc độ) |

---

## 3. Out of scope

- **Shortcut production hiện tại** (link `199d89e6…`) — chỉ dùng để so sánh hành vi cũ ở `OLD`/`WARN`, không
  test độc lập.
- **App Ink Prod trên App Store** — chưa có action mới, note tự xác nhận "chưa test được".
- **Link `43e6966e…`** ([triggers-ios27.md](../../specs/shortcuts/qc-shortcut-triggers-ios27.md) mục 2, 7) — bản
  bị sửa tay, chỉ còn 1 automation giờ cố định, **không đại diện** cho hành vi 4-automation — chỉ dùng để biết
  nguồn gốc báo cáo bug `AUTO`/Lock-Home-đổi-chỗ, không dùng làm căn cứ test bất kỳ case nào khác.
- **Crop/căn khung ảnh Own photo** và **PRO gating cho ảnh catalog ở Home Screen** — đã đóng qua Q3
  ([test-analysis §1 #4](test-analysis-ios26-27-v2-updated.md#4--own-photo-croppro-gating-đã-fix-hay-vẫn-out-of-scope--đã-trả-lời-q3)):
  vẫn chưa làm, vẫn không phải bug.
- **Localization đầy đủ** cho chữ mới trong mục Home Screen/Debug — chỉ tiếng Anh ở bản test, sẽ dịch trước khi
  phát hành.
- **Logic chọn event hiển thị trên wallpaper** — chỉ liên quan việc *set đúng ảnh*, không phải *nội dung* ảnh,
  trừ phi regression BUG-004 (đã đưa vào `AUTO`, TC-66 tương đương).

### 3.1 Ảnh hưởng chéo tới flow khác (regression impact ngoài phạm vi note)

> Đối chiếu [screenshot-naming.md §7](../../../.claude/rules/screenshot-naming.md#7-flow-map--ink-calendar-ios). Không đổi so với đánh giá ở [test-plan-ios26-27.md §3.1](test-plan-ios26-27.md#31-ảnh-hưởng-chéo-tới-flow-khác-regression-impact-ngoài-phạm-vi-note), chỉ thêm dòng cho `03_shortcut-setup` do nhóm `TRIG`/`AUTO` mới mở rộng.

| Flow | Ảnh hưởng? | Lý do |
|---|---|---|
| `03_shortcut-setup` | **Trực tiếp** | Toàn bộ note nằm trong flow này; nhóm `AUTO`/`TRIG` mở rộng thêm bước bật 4 automation trong luồng setup |
| `04_discover` | **Gián tiếp** | Đường vào chỉnh Home Screen; "Set as current"/"Update" kích hoạt shortcut |
| `10_lockscreen` | **Gián tiếp** | Kết quả cuối (wallpaper thật) hiện ở đây; đối chiếu regression BUG-004 và bug Lock/Home đổi chỗ |
| `05_calendar` | **Gián tiếp** | Nguồn event cho wallpaper; regression BUG-004 và automation "Calendar closed"/"Google Calendar closed" chạm trực tiếp flow này |
| `09_settings` | **Gián tiếp** | Entry point "Set up shortcut" + mục Debug mới nằm ở Settings |
| `08_paywall` | **Gián tiếp, nhẹ** | Ảnh catalog PRO chọn được cho Home Screen dù chưa mua — đã xác nhận không phải bug (Q3) |
| `06_task`, `07_note`, `01_onboarding`, `02_permission` | **Không ảnh hưởng** | Không entry point, không data pipeline dùng chung |
| `11_share`, `12_ai-assistant`, `13_community` | **Không áp dụng** | Chưa build (Phase 2) |

---

## 4. Test levels & test types

- **Level:** System testing, black-box, trên **Ink Dev dựng từ Xcode** (branch `fix/ios27-shortcut-automation`)
  — QC không có quyền vào code, mọi kết luận cấu trúc if/else dựa trên cross-check tay + ảnh chụp thật, không
  phải đọc source.
- **Functional:** 9 nhánh token × mode/blur/redraw (nhóm `HS`), persist Own photo (`OWN`), cặp wallpaper
  (`PAIR`), cảnh báo vàng đúng logic (`WARN`), 4 automation + trigger qua notification (`AUTO`/`TRIG`), toast
  hiện đúng vị trí (`TOAST`).
- **Non-functional:**
  - **Compatibility:** iOS 26.x (chỉ `INS`/`OLD`/`HS`/`OWN`/`PAIR`/`WARN`, không có automation) **và** iOS 27
    (đầy đủ mọi nhóm, bắt buộc cho `AUTO`/`TRIG`). iPad nếu có sẵn máy — không bắt buộc.
  - **Performance:** cơ chế skip-unchanged (`HS`, dùng `DBG` để đo) — cả Photo only/Own photo lẫn Same (nếu gap
    #2 xác nhận), mốc 24h (nghi vấn đã đổi, gap #2).
  - **Reliability:** automation chạy đúng khi máy khoá qua đêm (`AUTO`), không sinh automation trùng khi cài
    lại (`AUTO`/`INS`), không vòng lặp tự trigger (`AUTO` TC-86), không race giữa nhiều trigger cùng lúc
    (`AUTO`/`TRIG`).
  - **Data integrity:** ảnh riêng của user không bị ghi đè ngoài ý muốn (`PAIR`, `OWN`) — risk cao nhất toàn bộ
    tài liệu.
  - **Usability:** nội dung notification `update_lockscreen` có lộ chi tiết kỹ thuật ra UI thật không (`TRIG`
    TC-97); chuỗi đổi tên nhiều shortcut dễ nhầm lẫn (`INS`).
- **Change-related (regression):**
  - Regression **bắt buộc** cho bug **đã có báo cáo thật** (Lock/Home đổi chỗ lúc 00:05) — không phải case
    thăm dò, xem `AUTO` TC-87 và mục 8.1 (Suspension).
  - Regression BUG-004 trên automation Sunrise/Calendar closed (`AUTO`).
  - Regression nhanh phần happy-path + permission của checklist SCT cũ
    ([exploratory/03_shortcut-setup.md](../../exploratory/03_shortcut-setup.md) mục 1–2), **trên shortcut mới**
    (7 Set/2 Switch), không dựa vào kết luận cũ (5 Set/1 Switch, viết cho bản V2).

---

## 5. Kỹ thuật thiết kế test case

### 5.1 State Transition Testing — 9 nhánh token (nhóm `HS`, kỹ thuật chính, thay cho bảng phẳng)

> Dùng thẳng bảng [test-analysis §1.2](test-analysis-ios26-27-v2-updated.md#12-toàn-bộ-9-nhánh-token-shortcut-thực-sự-xử-lý--phân-tích-2026-09-23)
> làm test basis kỹ thuật — **không phải** bảng "tra nhanh" mục 5 test basis gốc (sai ở 2 dòng). Mỗi token là 1
> "state" của biến `Mode`; sự kiện chuyển state là (đổi UI mode) × (bật/tắt Blur) × (ảnh home đổi hay không) ×
> (đã quá 24h hay chưa). Lý do chọn State Transition thay vì Decision Table phẳng: các biến này **phụ thuộc lẫn
> nhau theo thời gian** (redraw chỉ xuất hiện khi Blur *vừa* đổi so với *lần chạy trước*, không phải trạng thái
> tĩnh) — Decision Table không biểu diễn được yếu tố "so với lần trước".

| ID | Token | Điều kiện chuyển vào state này | Kỳ vọng | Ghi chú |
|---|---|---|---|---|
| HS-T1 | *(không same/pair)* | Chọn Off; hoặc Photo only/Own photo mà ảnh home không đổi trong <24h | 1 Set (Lock) | |
| HS-T2 | `same` | Chọn Same, Blur đang tắt (chưa từng bật) | ⚠️ **0 Set theo cấu trúc — gap #1, verify thật** | Nếu bug thật: Lock+Home đều không đổi |
| HS-T3 | `same-redraw` | Đang ở Same+Blur bật, vừa **tắt** Blur | ⚠️ **0 Set theo cấu trúc — gap #1, chính là chiều "tắt Blur" của case Blur bật/tắt** | Ưu tiên chạy **trước tiên** trong nhóm `HS` |
| HS-T4 | `same-blur` | Same, Blur bật, không vừa đổi | 1 Set (Lock+Home, mờ) | |
| HS-T5 | `same-blur-redraw` | Same, vừa **bật** Blur | 2 Set (Lock+Home, mờ ×2) | |
| HS-T6 | `pair` | Photo only/Own photo, Blur tắt, ảnh home đổi hoặc >24h | 2 Set (Lock, rồi Home nét) | |
| HS-T7 | `pair-redraw` | ...vừa tắt Blur | 3 Set | |
| HS-T8 | `pair-blur` | Photo only/Own photo, Blur bật, ảnh home đổi hoặc >24h | 2 Set (Lock, rồi Home mờ) | |
| HS-T9 | `pair-blur-redraw` | ...vừa bật Blur | 3 Set | |

Đo số Set thật bằng `DBG` (Last shortcut run + log console `[InkShortcut]`), không đoán qua thời gian chạy đơn thuần.

### 5.2 Decision Table 1 — Home Screen × Blur (bảng gốc mục 5, dùng làm checklist thực thi)

| ID | Chế độ | Blur | Lock screen | Home screen | Token tương ứng (§5.1) |
|---|---|---|---|---|---|
| DT1-01 | Off | — | Wallpaper có lịch | Không bị Ink set | HS-T1 |
| DT1-02 | Same | Tắt (từ đầu) | Wallpaper có lịch | ⚠️ Theo spec: cùng ảnh, nét — theo cấu trúc thật: **không đổi gì** | HS-T2 |
| DT1-03 | Same | Bật | Wallpaper có lịch | Cùng ảnh, mờ | HS-T4/T5 |
| DT1-04 | Photo only | Tắt | Wallpaper có lịch | Ảnh nền, không lịch, không tối | HS-T6/T7 |
| DT1-05 | Photo only | Bật | Wallpaper có lịch | Ảnh nền, mờ | HS-T8/T9 |
| DT1-06 | Own photo | Tắt | Wallpaper có lịch | Ảnh đã chọn | HS-T6/T7 |
| DT1-07 | Own photo | Bật | Wallpaper có lịch | Ảnh đã chọn, mờ | HS-T8/T9 |

→ DT1-04/05 và DT1-06/07 dùng chung đúng 2 action Set (khác biệt nằm trong `Generate Home Screen Wallpaper`,
không phải if/else) — nếu 1 trong 2 cặp sai mà cặp kia đúng, root cause nằm trong logic chọn ảnh, không phải
cấu trúc rẽ nhánh (kế thừa nguyên phát hiện §D của [test-plan-ios26-27.md](test-plan-ios26-27.md#d-phát-hiện-quan-trọng-nhất--photo-only-và-own-photo-dùng-chung-1-code-path)).

### 5.3 Decision Table 2 — Cài shortcut khi đã có shortcut trùng tên (`INS`, không đổi so với V2)

| ID | iOS hỏi gì? | Hành động đúng | Kỳ vọng |
|---|---|---|---|
| DT2-01 | Hỏi thay thế (Replace) | Không chọn — đổi tên shortcut cũ trước | Không mất shortcut cũ |
| DT2-02 | Thêm bản mới, tự đặt số ở cuối (`… 1`) | Giữ cả hai, đổi tên theo quy ước | Không có 2 shortcut cùng tên |

### 5.4 Decision Table 3 — Vị trí hiển thị Toast (`TOAST`, hoàn toàn mới)

| ID | Ngữ cảnh khi shortcut chạy xong | Toast hiện ở đâu | Có chồng 2 toast không |
|---|---|---|---|
| DT-TOAST-01 | Đang ở màn edit template, bấm Update | Ngay trên màn edit | Không |
| DT-TOAST-02 | Shortcut lỗi khi đang ở màn edit | Ngay trên màn edit (toast lỗi) | Không |
| DT-TOAST-03 | Đang mở sheet/popup trên màn edit | Toast hiện trên cả sheet, không chặn thao tác | Không |
| DT-TOAST-04 | Lỗi trong **luồng cài shortcut lần đầu** | Chỉ thông báo lỗi của màn cài đặt | **Không được** có thêm toast lỗi thứ 2 |

### 5.5 Decision Table 4 — Cảnh báo "Needs the new Ink shortcut" (`WARN`, không đổi so với V2)

| ID | Shortcut đang chạy | Chế độ Home Screen | Cảnh báo hiện? |
|---|---|---|---|
| WARN-01 | Production (cũ) | Same/Photo only/Own photo | Có |
| WARN-02 | Mới, chưa Update lần nào | Same/Photo only/Own photo | Có |
| WARN-03 | Mới, đã Update ≥1 lần | Same/Photo only/Own photo | Không |
| WARN-04 | Bất kỳ | Off | Không áp dụng |

### 5.6 Decision Table 5 — Điều kiện trigger automation (`AUTO`/`TRIG`, mới)

| ID | Loại trigger | Điều kiện | Kỳ vọng |
|---|---|---|---|
| DT-AUTO-01 | Thời gian | Sunrise (bình minh theo vị trí máy) | Chạy đúng lúc bình minh |
| DT-AUTO-02 | Ứng dụng đóng | Rời Ink Dev | Chạy trong vài giây |
| DT-AUTO-03 | Ứng dụng đóng | Rời Calendar (Apple) | Chạy trong vài giây |
| DT-AUTO-04 | Ứng dụng đóng | Rời Google Calendar | Chạy trong vài giây (nếu có cài app) |
| DT-AUTO-05 | Notification | Nhận notification title chứa `update_lockscreen` | Chạy ngay, không cần chờ trigger khác |
| DT-AUTO-06 (negative) | Notification | Nhận notification title **khác** `update_lockscreen` | **Không** chạy |

### 5.7 State Transition Testing — Định nghĩa "App đã closed" (`AUTO`, ranh giới chưa rõ, mục 10 gap kế thừa mới)

> Test basis không định nghĩa rõ "closed" tương ứng state nào của app lifecycle — cần verify thực tế cả 3 state
> chuyển tiếp, ghi nhận state nào thật sự trigger automation, không giả định trước.

| State hiện tại | Chuyển sang | Có tính "closed" (trigger automation) không? |
|---|---|---|
| Foreground (đang mở) | Background — về Home Screen (vuốt lên) | Theo test basis: **Có** (case cơ bản) |
| Foreground | Background — chuyển app khác (App Switcher, không về Home) | **Chưa xác định** — verify |
| Foreground/Background | Terminated — vuốt tắt hẳn trong App Switcher | **Chưa xác định** — verify |

### 5.8 Boundary Value Analysis

- **Số cặp wallpaper** (kế thừa nguyên từ V2, không đổi) — trước/sau chạy đủ 4 chế độ: kỳ vọng **+0**; trước/sau
  bấm Update 3 lần liên tiếp: kỳ vọng **+0**.
- **Mốc 24 giờ cho skip-unchanged** (`HS`) — 🆕 do gap #2 (mục 10), test **cả 2 giả thuyết**: (a) đúng 24h vẫn
  ghi lại 1 lần đầy đủ như test basis mô tả; (b) qua 24h/48h/72h vẫn tiếp tục nhanh, không ghi lại — ghi nhận
  kết quả thật, không giả định giả thuyết nào đúng trước.

### 5.9 Exploratory testing (session-based, time-boxed)

- **`PAIR` — thăm dò còn lại duy nhất:** con số cụ thể (số cặp tăng đúng 1, không tăng thêm khi lặp) — hành vi
  runtime cần đo trên máy thật, cơ chế đã biết rõ (kế thừa nguyên trạng từ V2).
- **`XVER` — chéo phiên bản:** cài `iOS 27/Dev` lên máy iOS 26 (hướng chính, dev có test); cân nhắc thử thêm
  `iOS 27/Dev` lên máy iOS 26 kiểu ngược lại nếu còn thời gian, không coi lỗi/không cài được là bug (gap
  `MinimumClientVersionString` kế thừa từ V2, vẫn mở).
- **`HS` — chất lượng ảnh HEIC:** không có ngưỡng pass/fail khách quan (test-analysis §1 #6) — charter: soi
  template có thẻ bán trong suốt, chữ nhỏ trên lịch; nếu nghi ngờ, so sánh với bản PNG qua `DBG`.
- **`AUTO`/`TRIG` — concurrency:** Sunrise và "Calendar closed" (hoặc notification) xảy ra gần nhau — charter:
  cố tình tạo tình huống trùng thời điểm, quan sát cờ `old still running` ở `DBG`, ghi nhận có lỗi chồng chéo
  không.

### 5.10 Error guessing / Checklist-based

- Regression checklist cũ SCT-H01–H19, SCT-N01–N05
  ([exploratory/03_shortcut-setup.md](../../exploratory/03_shortcut-setup.md)) — chạy lại trên shortcut mới (7
  Set/2 Switch), không dựa kết luận cũ (5 Set/1 Switch).
- BUG-004 (event Google Calendar không xuất hiện trên wallpaper hôm sau) — chạy lại trên automation Sunrise
  **và** automation "Google Calendar closed" mới (2 đường trigger khác nhau, cùng 1 nghi vấn root cause).

---

## 6. Risk-based prioritization

> Risk level = risk likelihood × risk impact (đã tính sẵn trong [test-analysis mục 2](test-analysis-ios26-27-v2-updated.md#2-test-condition-đã-ưu-tiên-hoá)
> theo từng test condition). Danh sách dưới đây nhóm các TC theo chủ đề, không lặp lại nguyên văn từng dòng.

**P1 — chặn phát hành (31 test condition từ test-analysis, các cụm chính):**
- **Nghi vấn bug nghiêm trọng nhất đợt này:** `HS-T2`/`HS-T3` (TC-25b, TC-25c) — Same+Blur tắt có thể không cập
  nhật gì cả. **Chạy trước tiên** trong toàn bộ đợt test, vì nếu đúng là bug, toàn bộ Decision Table 1 (`HS`
  TC-21) không dùng được kết quả kỳ vọng gốc của test basis.
- **Regression cho bug đã có báo cáo thật:** `AUTO` TC-87 (Lock/Home đổi chỗ) — không phải giả thuyết, đã từng
  xảy ra lúc 00:05.
- **Race condition đã lường trước:** `AUTO` TC-84/85/86 (automation "Ink closed" đua với Update thủ công, nguy
  cơ chạy 2 lần hoặc vòng lặp) + `AUTO` TC-89 (cờ chẩn đoán `old still running`).
- **Cơ chế trigger mới hoàn toàn:** `TRIG` TC-93/94/95 (notification trigger đúng/không trigger nhầm/hoạt động
  khi khoá máy).
- **Nền tảng cài đặt:** `INS` TC-01/03/05/06/07 (đúng 7 Set/2 Switch, Allow Running When Locked, đổi tên đúng
  shortcut, automation theo shortcut không theo tên); `AUTO` TC-74/75 (máy sạch trước khi cài, Allow Running
  When Locked) — sai ở đây làm hỏng baseline mọi case automation sau.
- **Luồng cũ không vỡ:** `OLD` TC-11/12/13/14 (note tự xếp rủi ro cao nhất toàn tài liệu).
- **Cơ chế mới trung tâm của bản update:** `HS` TC-31/33/35/37 (skip-unchanged Photo only/Own photo, đổi ảnh
  nền/Blur không bị bỏ qua nhầm), `HS` TC-29b (skip-unchanged mở rộng sang Same, theo dev báo miệng — gap #2).
- **Data integrity:** `OWN` TC-43/45/46/49 (Own photo core promise), `OWN` TC-52/53 (Off không đụng home đã tự
  chỉnh qua iOS), `PAIR` TC-55–59 (không tạo cặp thừa, không ghi đè ảnh riêng của user — note tự đánh dấu lỗi
  chặn phát hành).
- **Automation nền tảng:** `AUTO` TC-63/64/66 (Sunrise bật/tắt đúng mặc định, chạy đúng khi khoá máy qua đêm),
  `AUTO` TC-78/82 (Calendar/Google Calendar closed chạy đúng cơ bản).
- **Công cụ đo nền tảng:** `DBG` TC-70 (Last shortcut run đúng số liệu — nếu sai, mọi case tốc độ ở `HS` mất
  căn cứ).
- **Lock luôn nét:** `HS` TC-24 (blur không bao giờ áp dụng cho Lock).

**P2 (29 test condition, các cụm chính):**
- 7 dòng Decision Table 1 hiển thị đúng (`HS` TC-21, phụ thuộc kết quả gap #1).
- Toast mới (`TOAST` TC-17/18/19), cảnh báo vàng (`WARN` TC-60/61), cross-version (`XVER` TC-69).
- Automation không trùng khi cài lại, đúng máy khi đổi account (`AUTO` TC-67/68), ranh giới "closed" chưa rõ
  (`AUTO` TC-79/80), Google Calendar chưa cài (`AUTO` TC-83).
- Own photo persist qua đổi template/mode (`OWN` TC-44/47/48), cặp wallpaper (`PAIR` đã liệt P1 ở trên, phần
  còn lại thuộc P1 hết do note tự đánh dấu lỗi chặn phát hành).
- Mốc 24h skip-unchanged (`HS` TC-38, phụ thuộc gap #2), tốc độ Same vs Photo only (`HS` TC-29, cần verify lại
  do gap #2).
- Race concurrency nhẹ (`AUTO` TC-91, `TRIG` TC-96), notification UX (`TRIG` TC-97).

**P3 (9 test condition + case thăm dò):**
- Số lần hỏi quyền (`HS` TC-28, `WARN`), Cancel đóng editor giữ đúng trạng thái (`HS` TC-30), UI phụ (`HS`
  TC-22, `OWN` TC-42/50), Run Immediately mặc định (`AUTO` TC-77), Debug tool phụ (`DBG` TC-71/72/73).
- Toàn bộ case thăm dò thuần quan sát (`PAIR`, HEIC ở `HS`, `XVER`) — không xếp priority như bug thường.

---

## 7. Test environment matrix

- **Thiết bị bắt buộc:**
  - iPhone **iOS 26.x** — test `INS`/`OLD`/`TOAST`/`HS`/`OWN`/`PAIR`/`WARN` (không có automation trên iOS 26).
  - iPhone **iOS 27** — test **toàn bộ**, bắt buộc cho `AUTO`/`TRIG` (bật Allow Running When Locked trước).
  - **Máy thứ hai, Apple Account khác** — verify `AUTO` TC-68 (4 automation "đi theo" máy khác).
  - iPad — nếu có, không bắt buộc.
- **Dữ liệu chuẩn bị trên mỗi máy:**
  - Thư viện wallpaper ≥3 cặp, ≥1 cặp ảnh riêng của người test (bắt buộc cho `PAIR`/`OWN`).
  - App **Lịch** (Apple Calendar) và **Google Calendar** đã cài, tài khoản Google đã kết nối Ink (bắt buộc cho
    `AUTO` TC-78/82/83) — cần thêm 1 máy **không cài** Google Calendar để test riêng TC-83.
  - Notification cho Ink Dev đang **bật** ở Settings hệ thống (bắt buộc cho `TRIG` — nếu tắt, không nhận được
    notification `update_lockscreen` để trigger).
- **File shortcut:** [test-data/ink-shortcut-final-4/](../../test-data/ink-shortcut-final-4/) — chỉ dùng bản
  `Dev` của iOS 26 và iOS 27. **Không dùng** link `43e6966e…` cho bất kỳ mục đích test nào ngoài đối chiếu lịch
  sử bug `AUTO` TC-87.
- **Build:** Ink Dev dựng bằng Xcode từ nhánh `fix/ios27-shortcut-automation` — không cài qua TestFlight/App Store.

---

## 8. Entry criteria

- Build Ink Dev dựng đúng từ nhánh `fix/ios27-shortcut-automation`, xác nhận bằng Xcode.
- File `ink-shortcut-final-4/` đầy đủ (`iOS 26/Dev`, `iOS 27/Dev`) — đã cross-check tay khớp 7 Set/2 Switch.
- **Máy sạch trước khi cài** (`AUTO` TC-74): xoá hết shortcut Ink cũ, xác nhận tab Automation trống — làm trước
  khi bắt đầu bất kỳ case nào trong `AUTO`/`TRIG`, nếu không baseline sẽ không đáng tin.
- Mỗi máy test đã chuẩn bị thư viện wallpaper ≥3 cặp (≥1 cặp ảnh riêng), app Lịch + Google Calendar theo đúng
  mục 7, **trước khi** cài shortcut mới.
- Notification cho Ink Dev đã bật ở Settings hệ thống (cho `TRIG`).
- Người test đã đọc mục 3 nguồn V2-updated (quy tắc đổi tên shortcut) — sai bước này làm hỏng baseline mọi case
  sau.

## 8.1 Suspension & Resumption criteria

- **Suspend cục bộ `HS`** nếu `HS-T2`/`HS-T3` (TC-25b/TC-25c) xác nhận đúng là bug (Same+Blur tắt không cập
  nhật gì) — dừng chạy tiếp Decision Table 1 các dòng liên quan Same, báo dev ngay, chờ xác nhận trước khi tiếp
  tục coi các dòng Same+Blur khác của Decision Table 1 là đáng tin.
- **Suspend toàn cụm `AUTO`** nếu phát hiện **vòng lặp** ở automation "Ink closed" (TC-86) — nguy cơ spam
  chạy liên tục, tiêu pin/dữ liệu — dừng ngay, không thử lại nhiều lần để "xem nó tự dừng không".
- **Suspend toàn cụm `AUTO`** nếu tái hiện được bug Lock/Home đổi chỗ (TC-87) — đây là bug đã biết, không cần
  lặp lại nhiều lần để xác nhận thêm, ghi nhận đủ bằng chứng (mode/blur/khoá-mở/chạy tay) rồi báo ngay.
- **Suspend toàn cụm** nếu phát hiện app **KHÔNG** tự chuyển màn khoá về cặp của Ink sau mỗi lần chạy (kế thừa
  nguyên trạng từ V2 — vẫn là hành vi thiết kế đúng theo V2-updated mục 7/13).
- **Suspend toàn cụm** nếu phát hiện **2 shortcut cùng mang tên** `Ink Refresh Lock Screen` (kế thừa từ V2) —
  chỉ áp dụng luồng "trigger trong app", không áp dụng luồng "chạy trực tiếp" hay `TRIG`.
- **Suspend cục bộ Sunrise** nếu đổi trigger sang "Time of Day, 2–3 phút" để rút ngắn thời gian chờ tự làm
  automation ngừng chạy hẳn (kế thừa cảnh báo từ [exploratory/03_shortcut-setup.md §10](../../exploratory/03_shortcut-setup.md#10--smoke-cho-flow-này)).
- **Resume:** chạy lại từ đầu cụm đã suspend sau khi có xác nhận/patch, không tiếp tục giữa chừng.

## 9. Exit criteria

- 100% checklist các mục nguồn tương ứng (V2-updated mục 3–9, 12; triggers-ios27.md mục 3–6) đã tick pass hoặc
  có bug kèm severity.
- `HS-T2`/`HS-T3` (TC-25b/TC-25c) đã có kết quả runtime ghi nhận rõ ràng — pass, hoặc bug đã báo dev — **không
  được để trống**, vì đây là gap #1 (mục 10) ảnh hưởng cả Decision Table 1.
- Bảng thăm dò [mục 11 của V2-updated](../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2-updated.md#11-bảng-ghi-kết-quả-thăm-dò)
  và [mục 8 của triggers-ios27.md](../../specs/shortcuts/qc-shortcut-triggers-ios27.md#8-bảng-ghi-kết-quả) đã
  điền đủ cho cả iOS 26 và iOS 27 — "không chạy được" cũng là kết quả hợp lệ.
- 0 bug P1 mở, đặc biệt: `HS-T2`/`T3`, `AUTO` TC-87 (Lock/Home đổi chỗ), `AUTO` TC-86 (vòng lặp automation),
  `PAIR` (không tạo cặp thừa/ghi đè ảnh riêng), `OWN` TC-49/52/53.
- Regression SCT-H01–19/N01–05 đã chạy lại trên shortcut mới (7 Set/2 Switch), BUG-004 đã thử lại trên cả
  Sunrise và Google Calendar closed.
- Toàn bộ câu hỏi mở ở mục 10 dưới đây đã có câu trả lời bằng văn bản từ dev, hoặc được ghi nhận rõ là gap đã
  biết trước khi sign-off.

## 10. Gap cần làm rõ trước khi execute

1. **(Kế thừa test-analysis Q1b/TC-25b/TC-25c, P1)** Same + Blur tắt (từ đầu hoặc vừa tắt) có thật sự không Set
   gì cả trước khi Switch không? Cấu trúc if/else đã xác nhận bằng cross-check tay (bất đối xứng với nhánh
   Pair), chỉ còn thiếu bằng chứng chạy thật trên máy. **Đây là gap quan trọng nhất tài liệu này** — verify
   ngay khi bắt đầu execute nhóm `HS`, trước khi tin bất kỳ kết quả nào khác của Decision Table 1.
2. **(Kế thừa test-analysis Q4, P1/P2)** Dev báo miệng: Same mode có skip-unchanged như Photo only/Own photo
   không, và mốc "24 giờ ghi lại đầy đủ" còn tồn tại hay đã bỏ hẳn? Chưa có xác nhận văn bản. Verify cả 2 khả
   năng khi chạy `HS` TC-29b/TC-38 (đã ghi rõ cách verify), đồng thời xin dev xác nhận song song.
3. **(Kế thừa nguyên trạng từ V2, gap #7 cũ)** Giá trị thật của `MinimumClientVersionString` trong file iOS 27 —
   ảnh hưởng `XVER` (chéo phiên bản theo chiều ngược, file mới trên OS cũ). Không có bằng chứng nhị phân nào
   xác nhận/bác bỏ trên bộ file hiện tại (AEA-encrypted, không đọc được string).
4. **(Mới, phát sinh từ nhóm `AUTO` mở rộng)** "Xoá automation" trên iOS 27 tương đương thao tác nào — xoá cả
   shortcut hay có cách tắt riêng từng dòng automation (Edit → Automation) mà không đụng 3 automation còn lại?
   Ảnh hưởng cách viết case cho `AUTO` TC-92 (xoá shortcut → 4 automation biến mất theo).
5. **(Mới, `AUTO`/`TRIG`)** Notification `update_lockscreen` do app tự lên lịch cố định hay do server push theo
   sự kiện thật (lịch đổi)? Ảnh hưởng cách chuẩn bị điều kiện test cho `TRIG` TC-93 (không thể ép app gửi
   notification theo ý muốn nếu không biết điều kiện kích hoạt thật).

## 11. Coverage gap — case chưa được note liệt kê

| Thiếu | Vì sao là gap |
|---|---|
| iPad — 4 chế độ Home Screen trên màn vuông, xoay ngang/dọc | Cả 2 test basis không có case riêng nào cho layout iPad |
| Regression đầy đủ SCT-N06–N27 (bỏ dở, cấu hình automation sai, phá vỡ sau setup) trên shortcut mới | Cả 2 test basis chỉ tập trung phần thay đổi, không tự khai lại 22 case cũ này |
| Wallpaper hiện tại đang là Photo Shuffle trước khi cài/chạy shortcut mới | Không có trong test basis nào |
| Own photo bị dọn bởi cơ chế "dọn file ảnh không dùng" nếu không mở app lâu hơn "một ngày" | Ranh giới thật (7 ngày? 30 ngày?) không được xác nhận |
| 2 automation khác nhau cùng gọi 1 shortcut trong bối cảnh 4-automation mới (vd Sunrise + Calendar closed cùng lúc) | Đã đưa vào `AUTO` TC-91 nhưng chỉ ở mức exploratory, chưa có case pass/fail cụ thể do chưa biết hành vi đúng |
| **Notification `update_lockscreen` bị user tự xoá/tắt trước khi automation kịp bắt** (vuốt xoá banner) | Cả 2 test basis không nhắc — ảnh hưởng trực tiếp độ tin cậy của `TRIG` nếu banner bị xoá quá nhanh |
| **Nhiều notification `update_lockscreen` dồn lại** (vd máy offline lâu, nhận bù nhiều notification cùng lúc khi có mạng lại) — automation có chạy nhiều lần hay chỉ 1 lần? | Suy luận rủi ro mới của QC, không có trong bất kỳ tài liệu nào |
