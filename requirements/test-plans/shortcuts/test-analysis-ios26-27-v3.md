# Test Analysis — Shortcut V2: Home Screen, automation iOS 27 và chuyển từ shortcut cũ (v3)

> ⚠️ **DRAFT cục bộ — chờ xác nhận Q2, Q3 (mục 4).** Tuyệt đại đa số tài liệu (167/169 test condition) không có
> câu hỏi mở nào ảnh hưởng risk/scope, dùng được ngay cho test-plan. Riêng **TC-F04** (cửa sổ "Update your shortcut"
> có nên cảnh báo cho chế độ Don't change không) và **TC-J09/TC-J10** (UX khi xác nhận chạy thử V2 thất bại lặp
> lại, bước 1 luồng update) đang để trống Risk level/Ưu tiên (`Chờ xác nhận Q2`/`Q3`) vì thiếu căn cứ gán risk —
> theo đúng quy tắc mục 0 của skill test-analysis, không tự đoán. Xem mục 4 để biết chi tiết 2 câu hỏi.
>
> **Test basis (3 file, đã vào `main` qua PR #302, 2026-09-24):**
> 1. [qc-shortcut-home-screen-ios26-27-V2.md](../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2.md) — spec
>    chính, 17 mục.
> 2. [qc-shortcut-triggers-ios27.md](../../specs/shortcuts/qc-shortcut-triggers-ios27.md) — chi tiết từng automation
>    trong 5 automation đi kèm shortcut.
> 3. [qc-notification-automation-ios27.md](../../specs/shortcuts/qc-notification-automation-ios27.md) — automation
>    kích hoạt qua notification passive, cơ chế "Remove after the run".
>
> **KHÔNG dùng làm test basis** (chỉ tham khảo phương pháp phân tích, số liệu đã lỗi thời vì viết cho một nhánh
> chưa merge khác — `fix/ios27-shortcut-automation`):
> [test-analysis-ios26-27-v2-updated-SUPERSEDED.md](test-analysis-ios26-27-v2-updated-SUPERSEDED.md). Vẫn còn giá
> trị tham khảo cho **cách** làm bảng đối chiếu spec-vs-thực-tế và cách liệt kê từng token if/else — không tham
> khảo **con số** (7 Set/2 Switch, 9 token cụ thể) vì đó là kết quả cross-check tay trên một bản build khác.
> [test-plan-ios26-27.md](test-plan-ios26-27.md) và [test-cases-ios26-27.md](test-cases-ios26-27.md) — bản gốc cho
> luồng "set wallpaper cũ không vỡ", vẫn còn giá trị (chưa archive) vì luồng đó ít đổi — đọc lướt để biết độ chi
> tiết đã có, không chép lại case.
>
> **Chuẩn:** ISTQB Foundation Level v4.0.1 §1.4.1 (Test Analysis) + §3 (Static Testing) + §5.2 (Risk Management)
> **Bước tiếp theo:** [test-plan](../../../.claude/skills/test-plan/SKILL.md) dùng mục 2 (test condition) làm test
> object và mục 2 cột risk level làm cơ sở mục 6 (risk-based prioritization) — chạy sau khi mục 4 không còn câu
> hỏi ảnh hưởng risk/scope của test condition quan trọng.
> **Ngày lập:** 2026-09-25 · **Người lập:** QC

---

## 0. Cách đọc tài liệu này

Test basis tự xếp 9 mảng theo **mức rủi ro giảm dần** ngay ở đầu file chính (mục đầu file, trước mục 1): (1) luồng
set cũ không vỡ, (2) chuyển từ shortcut cũ sang V2, (3) bốn chế độ Home Screen, (4) ảnh home riêng, (5) cặp
wallpaper, (6) automation iOS 27, (7) ảnh HEIC, (8) tốc độ, (9) trang "How updates work". Thứ tự này được dùng
làm **căn cứ chính cho cột Impact** ở mục 2 bên dưới thay vì tự đoán — đây là risk ranking do chính người viết
spec (dev/PM) đưa ra, không phải QC tự gán.

Test basis cũng tự đánh dấu **mục 5 và mục 9 (Bốn chế độ Home Screen, Automation)** là "một phần thăm dò" có chủ
đích — có bảng ghi kết quả riêng ở mục 11, và câu văn "'Không chạy' cũng là một kết quả có giá trị". Đây **không
phải** ambiguity/thiếu sót của tài liệu — mục 1 dưới đây **không** liệt các câu hỏi thăm dò này vào bảng testability
issues. Chúng xuất hiện ở mục 2 với **Loại = Exploratory**, cột Risk level/Ưu tiên để trống, đúng quy ước ISTQB
(§5.2: risk-based prioritization áp dụng cho test condition có thể đánh giá pass/fail, không áp dụng cho charter
thăm dò thuần quan sát).

---

## 1. Đánh giá testability của test basis

### #1 · Số action Set/Switch (11 Set/3 Switch) — chưa có nguồn độc lập xác nhận

- **Trích đoạn:** Mục 3.1: *"Mở shortcut: có **11 action "Set Wallpaper"** và **3 action "Switch"**, không action
  nào hiện màu đỏ. Nhánh Same as Lock dùng action Lock + Home (một lần ghi cho cả hai màn); nhánh còn lại set Lock
  rồi mới set Home"*.
- **Vấn đề:** Con số này **chỉ có trong lời spec**, chưa được QC cross-check tay trên chính bản build đã merge
  (`main`, PR #302). Khác với đợt trước — lúc đó QC **đã** cross-check tay và **chứng minh được** spec sai (7/2
  thay vì 11/3 spec cũ công bố, xem file SUPERSEDED §1.1) — đợt này **chưa có bằng chứng độc lập nào theo chiều
  nào cả**. Không tự tin con số 11/3 là đúng, cũng không tự nghi ngờ nó sai chỉ vì đợt trước từng sai.
- **Loại:** Không kiểm được bằng nguồn độc lập (chưa phải mơ hồ/mâu thuẫn — chỉ là "chưa verify").
- **Cần hỏi ai:** Không cần hỏi — đây là việc QC tự làm khi execute (xem TC-A05, P1). Chỉ escalate cho dev nếu
  cross-check tay cho ra con số khác spec.

### #2 · Thứ tự thật của "Tab Automation" mâu thuẫn giữa 2 tài liệu

- **Trích đoạn:**
  - `qc-shortcut-triggers-ios27.md` mục 1, câu mở đầu bảng: *"Tab Automation xếp theo thứ tự của iOS"* → bảng liệt
    thứ tự: **Sunrise → notification from Ink → Ink closed → Calendar closed → Google Calendar closed**.
  - `qc-notification-automation-ios27.md` mục 2, cũng mở đầu: *"Tab Automation xếp theo thứ tự của iOS, không theo
    file"* → khối ASCII liệt thứ tự: **Sunrise → Calendar closed → Google Calendar closed → Ink Dev closed →
    notification from Ink Dev** (notification đứng **cuối**, không phải thứ 2).
- **Vấn đề:** Cả 2 tài liệu cùng tự nhận đang mô tả **cùng một sự thật** (thứ tự hiển thị thật trong tab Automation
  của iOS, không phải thứ tự Guide gợi ý bật) nhưng đưa ra **2 thứ tự khác nhau**, đặc biệt vị trí của "notification
  from Ink" (thứ 2 vs cuối cùng). Đây không phải khác biệt giữa "thứ tự Guide nên bật" và "thứ tự tab thật" (2 khái
  niệm khác nhau tài liệu 1 tự phân biệt rõ) — cả 2 trích đoạn trên **đều tự nhận là thứ tự tab thật**.
- **Loại:** Mâu thuẫn nội bộ giữa 2 test basis.
- **Cần hỏi ai:** Không chặn tiến độ test chức năng (chỉ ảnh hưởng 1 test condition mô tả thứ tự hiển thị, ưu tiên
  thấp) — nhưng nên hỏi dev/QC khác đã viết 2 tài liệu để chốt lại 1 thứ tự đúng, tránh dùng nhầm khi build case chi
  tiết. Xem câu hỏi mở #1 ở mục 4.

### #3 · Mục 7 (cặp wallpaper): "Đã xác nhận trên máy — không cần test lại" không ghi rõ build/ngày

- **Trích đoạn:** Mục 7: *"**Đã xác nhận trên máy (không cần test lại):** xoá một cặp **khác** → shortcut vẫn ghi
  đúng cặp của Ink (số hiển thị tự đổi, ví dụ 6 → 5)."*
- **Vấn đề:** Không ghi ngày hay bản build nào đã xác nhận. Given 2 đợt phân tích trước đó đã archive vì test trên
  nhánh khác (`fix/ios27-shortcut-automation`) rồi bị thay bằng bản merge, không loại trừ khả năng dòng "đã xác
  nhận" này cũng kế thừa từ một đợt test cũ hơn, trên build khác với `main` hiện tại.
- **Loại:** Thiếu (thiếu ngữ cảnh ngày/build của xác nhận).
- **Cần hỏi ai:** Không chặn — QC coi đây là "chưa chắc còn đúng cho build này", xử lý như 1 test condition P2 cần
  verify lại thay vì bỏ qua hẳn (xem TC-E01).

### #4 · Cửa sổ "Update your shortcut" không cảnh báo cho chế độ Don't change, dù shortcut cũ vẫn ghi đè Home

- **Trích đoạn:** Mục 1: *"Nó [shortcut cũ] set cả lock lẫn home bằng một ảnh có lịch, kèm blur, và **không** hiểu
  các chế độ Home Screen."* Mục 8: *"Chế độ **Don't change** → bấm Update → **không** hiện cửa sổ, shortcut cũ
  chạy bình thường."*
- **Vấn đề — 2 cách hiểu khả dĩ:**
  1. **Chủ ý, chấp nhận được:** trước khi migrate, "Don't change" vốn không có tác dụng gì trên shortcut cũ (shortcut
     cũ không đọc được chế độ này) — hệ quả home vẫn bị ghi đè bằng ảnh lịch là điều đã biết trước, không cần cảnh
     báo riêng vì người dùng "Don't change" trên bản cũ về bản chất đang dùng đúng hành vi mặc định của shortcut cũ.
  2. **Gap UX thật:** đúng mục đích cửa sổ "Update your shortcut" là cảnh báo trước khi hành vi Home Screen không
     như kỳ vọng — nhưng "Don't change" (nghĩa là "đừng đụng vào Home") lại chính là trường hợp **kỳ vọng bị vi phạm
     rõ nhất** (home bị ghi đè bởi ảnh lịch dù user chọn "đừng đổi"), mà lại là chế độ **duy nhất không được cảnh
     báo** trong 4 chế độ.
- **Loại:** Mơ hồ — 2 cách hiểu dẫn tới 2 kỳ vọng test khác nhau (chạy Don't change trên shortcut cũ, home bị ghi đè
  không cảnh báo là **pass** theo cách hiểu 1, hoặc là **bug cần báo** theo cách hiểu 2).
- **Cần hỏi ai:** PM/dev — xem câu hỏi mở #2 ở mục 4. Không tự chọn cách hiểu, không tự gán risk cho test condition
  liên quan (TC-F04) cho tới khi có câu trả lời.

### #5 · Mục 13.2 bước 1: không mô tả UX khi xác nhận chạy thử thất bại

- **Trích đoạn:** *"App chạy thử V2 để xác nhận → về app, bước này đánh dấu xong. Nếu lần chạy thử lại gọi shortcut
  cũ → **không** được tính là xong."*
- **Vấn đề:** Không nói app làm gì tiếp theo khi xác nhận thất bại — có thông báo lỗi không, có hướng dẫn user thử
  lại không, có giới hạn số lần thử không, hay bước 1 chỉ đơn giản "không tích xong" và im lặng chờ user tự thử lại.
- **Loại:** Thiếu.
- **Cần hỏi ai:** Dev/PM — xem câu hỏi mở #3 ở mục 4. Ảnh hưởng scope của test condition về đường lỗi (negative
  path) trong luồng update.

### #6 · Chất lượng ảnh HEIC không có ngưỡng khách quan

- **Trích đoạn:** Mục 5: *"soi kỹ lock screen: có **vệt màu, sọc, mảng loang** ở mép thẻ hay vùng chuyển màu không?"*,
  *"Chữ nhỏ trên lịch... có **nhoè viền** không?"*
- **Vấn đề:** Không có ngưỡng khách quan (% diện tích lỗi, mức nhoè chấp nhận được). Bản thân note cũng chỉ đưa cách
  so sánh (đổi format sang PNG, set lại, chụp so sánh), không đưa ngưỡng pass/fail cứng — đây là đặc điểm cố hữu của
  đánh giá thị giác, không phải lỗi tài liệu.
- **Loại:** Không kiểm được bằng tiêu chí khách quan.
- **Cần hỏi ai:** Không chặn — xử lý như test condition dạng quan sát/so sánh (TC-C21, TC-C22), không gán risk theo
  kiểu pass/fail nhị phân.

### #7 · `qc-notification-automation-ios27.md` mục 6 đã điền sẵn kết quả — chỉ từ simulator, chưa phải máy thật

- **Trích đoạn:** Mục 6: *"Đã chạy trên **simulator iOS 27.0** (2026-09-24, bản Prod)... **Máy thật vẫn cần xác
  nhận toàn bộ**, nhất là với Focus / Scheduled Summary."*
- **Vấn đề:** Không phải ambiguity — tài liệu tự nói rõ đây là kết quả sơ bộ, chưa phải kết luận cuối. Ghi vào đây để
  nhắc: khi viết test condition cho nhóm G.3 (notification trigger), không được coi các ô đã điền sẵn là "đã pass",
  chỉ dùng làm gợi ý kỳ vọng ban đầu.
- **Loại:** Cần lưu ý khi thiết kế case (không phải defect của tài liệu).
- **Cần hỏi ai:** —

---

## 2. Test condition đã ưu tiên hoá

> Nhóm theo đúng thứ tự mục của test basis. Cột **Impact** dùng thứ tự rủi ro 9 mảng mà chính spec tự liệt ở đầu
> file làm căn cứ chính (mục 0 ở trên) — không tự đoán. Test condition **Loại = Exploratory** để trống cột
> Likelihood/Impact/Risk level/Ưu tiên đúng quy ước ISTQB cho charter quan sát thuần tuý.

### A. Cài shortcut & giữ nhiều shortcut (mục 1, 3)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-A01 | Cài shortcut Dev qua đúng link iCloud của mục 1 → thêm thành công tên `Ink Refresh Lock Screen V2`, không action nào hiện đỏ | mục 1 | Functional | Thấp | Cao (nền tảng cho mọi test khác) | Cao | P1 |
| TC-A02 | Cài nhầm link Prod trên máy Dev (hoặc ngược lại) → action của Ink hiện màu đỏ (xác nhận đây không phải bug, chỉ là cài nhầm bản) | mục 1 | Functional (negative, xác nhận) | Vừa | Thấp | Thấp | P3 |
| TC-A03 | Luồng setup trong app (nút Add shortcut) mở đúng link của bản app đang chạy, không cần cài tay | mục 1 | Functional | Thấp | Vừa | Vừa | P2 |
| TC-A04 | Chỉ iOS 27: sau khi cài, mở ⓘ → Privacy → bật "Allow Running When Locked" thành công; cờ này không tự đi theo link, phải bật tay mỗi máy | mục 3.1 | Functional/Reliability | Cao (dễ quên) | Cao (chặn mọi automation chạy khi khoá máy) | Cao | P1 |
| TC-A05 | ⚠️ Chưa có nguồn độc lập (mục 1 #1) — Cross-check tay: mở shortcut vừa cài, đếm đúng **11 action Set Wallpaper và 3 action Switch**, không action nào đỏ, đối chiếu với bảng "tra nhanh" 7 dòng ở mục 5 xem số Set mỗi nhánh có khớp | mục 3.1 | Functional (structural) | Không xác định (chưa verify) | Cao (nếu sai, toàn bộ Decision Table ở nhóm C dùng sai căn cứ) | Cao | P1 |
| TC-A06 | Cả 3 action "Switch Between Wallpapers": ô cặp wallpaper hiện đúng biến "Wallpaper" (kết quả Set đầu tiên), không trống, không hiện popup bắt chọn khi chạy | mục 3.1 | Functional | Thấp | Cao (spec tự đánh dấu "lỗi chặn phát hành") | Cao | P1 |
| TC-A07 | Lần chạy đầu, iOS hỏi quyền đặt wallpaper → chọn Always Allow → không hỏi lại các lần Set/Switch sau trong cùng lần chạy | mục 3.1 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-A08 | Không bao giờ để 2 shortcut cùng tên `Ink Refresh Lock Screen V2` cùng lúc — cài lại cùng tên thì iOS hỏi Replace (ghi nhận cảnh báo ở mục 13, xem TC-J-warn) | mục 3.2 | Robustness (negative, cảnh báo) | Thấp (chỉ xảy ra khi thao tác sai) | Cao (kết quả không đoán trước được) | Vừa | P2 |
| TC-A09 | Automation gắn với chính shortcut, không theo tên — đổi tên shortcut V2 vẫn giữ nguyên automation của nó | mục 3.2 | Functional | Vừa | Cao | Cao | P1 |
| TC-A10 | Xoá shortcut → automation của nó bị xoá theo (không để sót automation mồ côi) | mục 3.2 | Functional | Vừa | Cao | Cao | P1 |
| TC-A11 | Đổi tên shortcut cũ (V1) thành đúng tên V2 để "giả" test → app vẫn phân biệt đúng shortcut cũ qua hành vi action (hỏi chế độ Home Screen trước khi vẽ), không bằng tên → bật nhắc "Two Ink shortcuts are running" | mục 3.2 | Functional (negative, edge case cố ý gây nhầm) | Vừa | Cao | Cao | P1 |
| TC-A12 | Quyền "Always Allow" tính riêng từng shortcut — shortcut mới cài lần đầu có thể hỏi quyền lại | mục 3.2 | Functional | Vừa | Thấp | Thấp | P3 |

### B. Luồng set wallpaper cũ không vỡ + Toast (mục 4 — rủi ro cao nhất theo spec)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-B01 | Discover → chọn template → Set as current → lock đổi đúng template, app quay lại, nhãn "đang dùng" hiện đúng | mục 4 | Functional (regression) | Thấp | Cao (spec tự xếp rủi ro #1 toàn tài liệu) | Cao | P1 |
| TC-B02 | Mở template đang dùng → sửa gì đó → Update → lock đổi theo | mục 4 | Functional (regression) | Thấp | Cao | Cao | P1 |
| TC-B03 | Lần chạy đầu, dialog quyền chọn Don't Allow → mở lại app → app **không** coi là đã set thành công (không hiện nhãn đang dùng) | mục 4 | Functional (negative) | Vừa | Cao | Cao | P1 |
| TC-B04 | Đổi tên shortcut V2 sang tên khác (coi như xoá) → bấm Set trong app → app nhận ra không còn shortcut, vào luồng cài đặt, **không** kẹt ở màn Shortcuts | mục 4 | Robustness | Vừa | Cao | Cao | P1 |
| TC-B05 | Spotlight gõ "Ink" → chạy "Refresh Lock Screen" → wallpaper đổi, **không** mở app | mục 4 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-B06 | Template Note và template lịch đều set được như luồng chuẩn | mục 4 | Functional (regression) | Thấp | Vừa | Vừa | P2 |
| TC-B07 | 🆕 Bấm Update ở **màn edit template** → toast "Lock screen updated" hiện **ngay trên màn edit**, không đợi thoát ra Home | mục 4 | Functional/UX (mới hoàn toàn) | Vừa | Vừa | Vừa | P2 |
| TC-B08 | 🆕 Làm shortcut lỗi (đổi tên để app không tìm thấy) → toast lỗi cũng hiện trên màn đang mở | mục 4 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-B09 | 🆕 Toast hiện trên cả sheet/popup đang mở, **không chặn** thao tác — vẫn bấm được nút bên dưới trong lúc toast hiện | mục 4 | Usability | Vừa | Vừa | Vừa | P2 |
| TC-B10 | 🆕 Luồng cài shortcut lần đầu, nếu chạy lỗi → chỉ 1 thông báo lỗi (của màn cài đặt), **không** chồng thêm toast lỗi thứ 2 | mục 4 | Functional/UX | Vừa | Thấp | Thấp | P3 |

### C. Bốn chế độ Home Screen + Blur + skip-unchanged + HEIC + tốc độ (mục 5)

**C.1 — Decision Table 7 dòng + UI chip + Pro gating**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-C01 | Chạy đủ **7 dòng** bảng Chế độ × Blur (mục 5) đúng cả lock và home theo đúng mô tả | mục 5 | Functional (core) | Vừa | Cao (spec xếp rủi ro #3) | Cao | P1 |
| TC-C02 | Có đủ 4 chip Don't change / Same as Lock / No calendar / My photo, mỗi chip có dòng giải thích ngắn bên dưới đúng chế độ đang chọn | mục 5 | UI | Thấp | Thấp | Thấp | P3 |
| TC-C03 | No calendar và My photo là Pro: tài khoản free bấm vào → hiện paywall, chip không được chọn; mua xong → chọn được ngay | mục 5 | Functional | Vừa | Cao (chặn tính năng trả phí) | Cao | P1 |
| TC-C04 | Đang ở No calendar/My photo mà hết Pro → chế độ tự về Don't change, ảnh đã chọn và blur vẫn giữ để mua lại dùng tiếp | mục 5 | Functional (edge case downgrade) | Vừa | Cao | Cao | P1 |
| TC-C05 | Toggle "Blur behind app icons" chỉ hiện khi chế độ khác Don't change | mục 5 | Functional (UI logic) | Vừa | Vừa | Vừa | P2 |
| TC-C06 | Lock screen luôn nét kể cả khi Blur bật (blur chỉ áp dụng Home) | mục 5 | Functional | Thấp | Cao | Cao | P1 |
| TC-C07 | No calendar: home **không** bị tối dù thanh Darken của lock kéo cao | mục 5 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-C08 | Template nhiều ảnh nền đổi theo ngày: No calendar dùng đúng ảnh **hôm nay**, trùng ảnh dưới lịch trên lock | mục 5 | Functional/data | Vừa | Vừa | Vừa | P2 |
| TC-C09 | Same as Lock nhanh hơn No calendar (khi No calendar phải ghi home lần đầu/sau khi đổi ảnh) khoảng 3–4 giây, đo bằng Last shortcut run, nghỉ 1 phút giữa 2 lần bấm | mục 5 | Non-functional (Performance) — spec xếp rủi ro #8 (thấp nhất trong 9 mảng, nhưng vẫn có checklist rõ) | Vừa | Thấp | Thấp–Vừa | P3 |
| TC-C10 | Đổi chế độ trong editor rồi bấm ✕ (Cancel) thoát → mở lại editor → chế độ quay về đúng như trước khi mở | mục 5 | Functional/State | Vừa | Vừa | Vừa | P2 |

**C.2 — Blur đổi ngay sau 1 lần chạy (redraw)**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-C11 | Same as Lock hoặc No calendar: bật Blur → Update **một lần** → home mờ ngay (không cần bấm lần 2). Làm cả 2 chiều (bật/tắt), mỗi chiều 2 lượt | mục 5 (mermaid Bước 1+2, bảng tra nhanh) | Functional (cơ chế redraw) | Vừa (kiến trúc mới đã mô tả symmetric giữa nhánh same/pair, chưa verify độc lập — xem TC-A05) | Cao (spec tự nói "nếu phải bấm lần 2 → báo lỗi") | Cao | P1 |
| TC-C12 | Tắt Blur → Update một lần → home nét ngay (chiều ngược lại của TC-C11) | mục 5 | Functional | Vừa | Cao | Cao | P1 |

**C.3 — Skip-unchanged (No calendar/My photo bỏ qua ghi home khi ảnh không đổi)**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-C13 | No calendar, Update lần 1 ghi timing (Settings → Debug → Last shortcut run) | mục 5 | Setup, tiền đề cho TC-C14 | — | — | — | — |
| TC-C14 | Không đổi gì, Update lần 2 (nghỉ ~1 phút) → **nhanh hơn rõ** (gần bằng Don't change), home vẫn đúng ảnh nền, lock có lịch mới, console `home=skip-unchanged` | mục 5 | Functional + Non-functional (core mechanism) | Vừa | Cao (core promise của bản update) | Cao | P1 |
| TC-C15 | Thêm/sửa một sự kiện lịch → Update → vẫn nhanh, home vẫn đúng | mục 5 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-C16 | Đổi ảnh nền (ảnh khác, crop lại, hoặc đổi template) → Update → home **đổi theo ngay lần đó**, console `home=set` | mục 5 | Functional | Vừa | Cao | Cao | P1 |
| TC-C17 | Crop lại **cùng một ảnh** → Update → home đổi theo khung crop mới (hash phải nhạy với crop, không chỉ nguồn ảnh) | mục 5 | Functional (edge case của hash) | Vừa–Cao | Vừa | Vừa–Cao | P2 |
| TC-C18 | Đổi Blur → Update → home đổi blur ngay, **không** bị skip-unchanged bỏ qua (giao 2 cơ chế mới) | mục 5 | Functional | Cao (2 cơ chế mới chồng nhau) | Cao | Cao | P1 |
| TC-C19 | No calendar → Don't change → tự đổi ảnh home trong iOS → quay lại No calendar → Update → home **về ảnh nền template**, không giữ ảnh tự chọn qua iOS | mục 5 | Functional (edge case) | Vừa | Vừa | Vừa | P2 |
| TC-C20 | Template nhiều ảnh theo ngày, automation chạy sáng hôm sau → home là ảnh hôm nay, dù chưa quá 24h kể từ lần chạy trước | mục 5 | Functional (giao automation × skip-unchanged) | Vừa–Cao | Cao | Cao | P1 |
| TC-C20b | Để qua hơn 24 giờ không đổi gì → lần chạy kế tiếp ghi home đầy đủ **một lần** (chậm lại đúng 1 lần) | mục 5 | Functional/Performance boundary | Vừa | Vừa | Vừa | P2 |

**C.4 — Chất lượng HEIC (không ngưỡng khách quan, xem mục 1 #6)**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-C21 | Template có thẻ bán trong suốt đè ảnh nền → set → soi lock screen tìm vệt màu/sọc/mảng loang ở mép thẻ/vùng chuyển màu | mục 5 | Non-functional (quan sát, spec xếp rủi ro #7) | — | Vừa | Vừa | P2 (quan sát) |
| TC-C22 | Chữ nhỏ trên lịch (giờ, tên sự kiện) không nhoè viền do nén HEIC | mục 5 | Non-functional (quan sát) | — | Vừa | Vừa | P2 (quan sát) |
| TC-C23 | Khi nghi ngờ: Debug → Wallpaper format → PNG, set lại cùng template, chụp cả 2 bản để so sánh làm bằng chứng | mục 5, mục 12 | Hỗ trợ điều tra — không phải pass/fail độc lập | — | — | — | — |

**C.5 — Bảng thăm dò mục 11 liên quan Home Screen (Exploratory, không trùng với các TC có pass/fail rõ ở trên)**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-C24 | No calendar: mỗi lần chạy có bị hỏi quyền đặt wallpaper **2 lần** không (có 2 action Set trong 1 lần chạy)? Ghi vào bảng mục 11 | mục 5, mục 11 | Exploratory (quan sát, không có đáp án đúng sẵn) | — | — | — | — |
| TC-C25 | Ghi số giây thực đo của Same as Lock và No calendar (máy nguội, nghỉ 1 phút) vào bảng mục 11, tách riêng theo iOS 26/27 | mục 11 | Exploratory (ghi số liệu thô) | — | — | — | — |
| TC-C26 | Ghi lại template nào bị vệt màu/chữ nhoè do HEIC (nếu có) vào bảng mục 11 | mục 11 | Exploratory | — | — | — | — |

> TC-C11/TC-C12 (Blur đổi ngay) và TC-A06 (Switch hiện biến Wallpaper) đã có pass/fail rõ ở nơi khác trong spec —
> kết quả của các case này **cũng cần** được log lại vào bảng mục 11 theo cột iOS 26/iOS 27 khi execute, không tạo
> thêm test condition Exploratory riêng cho chúng.

### D. Ảnh home riêng (mục 6)

**D.A — My photo (chọn trong Ink)**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-D01 | Chọn My photo → hiện hàng ảnh: ô + (mở Photos), ảnh đã upload, ảnh catalog | mục 6.A | UI | Thấp | Thấp | Thấp | P3 |
| TC-D02 | Chọn ảnh từ Photos → Update → home là đúng ảnh đó, lock vẫn có lịch | mục 6.A | Functional (core) | Vừa | Cao (spec xếp rủi ro #4) | Cao | P1 |
| TC-D03 | Chọn ảnh catalog (có vòng xoay tải về) → Update → home đúng ảnh đó | mục 6.A | Functional | Vừa | Vừa | Vừa | P2 |
| TC-D04 | Update lần 2 không đổi gì → nhanh (skip-unchanged), home giữ nguyên, console `home=skip-unchanged` | mục 6.A | Functional (core mechanism) | Vừa | Cao | Cao | P1 |
| TC-D05 | Đổi sang ảnh khác → Update → home đổi theo ngay lần đó | mục 6.A | Functional | Vừa | Cao | Cao | P1 |
| TC-D06 | Đổi template khác trong khi giữ My photo → Update → home **vẫn là ảnh riêng** (không theo template) | mục 6.A | Functional | Thấp | Vừa | Vừa | P2 |
| TC-D07 | Chuyển sang No calendar rồi quay lại My photo → ảnh đã chọn **vẫn còn được chọn** (persist qua đổi mode) | mục 6.A | Functional/State | Vừa | Vừa | Vừa | P2 |
| TC-D08 | My photo nhưng chưa chọn ảnh nào → Update → home dùng ảnh nền của lock (**không bao giờ** trống) | mục 6.A | Functional (edge case) | Vừa | Cao | Cao | P1 |
| TC-D09 | Ảnh vừa chọn từ Photos cũng xuất hiện ở hàng ảnh nền của lock | mục 6.A | Functional phụ | Thấp | Thấp | Thấp | P3 |

**D.B — Tự chọn trong iOS, Ink để Don't change**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-D10 | Màn khoá ở cặp Ink → Customize → Home Screen → chọn ảnh trong Photos → Done | mục 6.B | Setup, tiền đề cho TC-D11 | — | — | — | — |
| TC-D11 | Về Ink, chế độ Don't change, bấm Update → lock đổi lịch mới, home **vẫn là ảnh vừa chọn qua iOS** | mục 6.B | Functional (core promise của Don't change) | Vừa | Cao (vi phạm lời hứa "Don't change không đụng home" nếu sai) | Cao | P1 |
| TC-D12 | Chạy thêm 2 lần (kể cả để automation sáng hôm sau chạy) → home vẫn giữ nguyên ảnh đã chỉnh qua iOS | mục 6.B | Functional, cùng nhóm TC-D11 | Vừa | Cao | Cao | P1 |
| TC-D13 | Chuyển sang Same as Lock/No calendar/My photo rồi Update → home **bị thay** (đúng, vì user tự chọn mode ghi đè — xác nhận ranh giới đúng của TC-D11/D12) | mục 6.B | Functional (xác nhận không phải bug) | Thấp | Vừa | Vừa | P2 |

### E. Cặp wallpaper (mục 7 — "một phần thăm dò" theo tiêu đề, nhưng phần lớn checklist có pass/fail rõ)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-E01 | ⚠️ Chưa rõ build/ngày xác nhận (mục 1 #3) — Xoá một cặp **khác** (không phải cặp Ink) → shortcut vẫn ghi đúng cặp của Ink, số hiển thị tự đổi đúng | mục 7 | Functional | Vừa | Cao (spec xếp rủi ro #5) | Cao | P1 |
| TC-E02 | Cài mới khi đang ở cặp riêng: chuyển màn khoá sang một cặp ảnh riêng, đếm số cặp; cài shortcut, bấm Set → màn khoá chuyển sang cặp mới và hiện lịch, số cặp tăng đúng 1, chuyển lại cặp ảnh riêng thì ảnh vẫn nguyên | mục 7 | Functional | Vừa | Cao (spec tự đánh dấu "báo ngay, lỗi chặn phát hành" cho các dòng liên quan) | Cao | P1 |
| TC-E03 | Bấm Update 3 lần liên tiếp → số cặp **không đổi** | mục 7 | Functional | Vừa | Cao | Cao | P1 |
| TC-E04 | Chạy đủ 4 chế độ (Don't change → Same as Lock → No calendar → My photo) → không chế độ nào tạo thêm cặp mới | mục 7 | Functional | Vừa | Cao (lỗi chặn phát hành nếu sai) | Cao | P1 |
| TC-E05 | Tự chuyển sang cặp khác rồi bấm Update → màn khoá **tự quay về** cặp của Ink, lịch là bản mới nhất | mục 7 | Functional | Vừa | Cao | Cao | P1 |
| TC-E06 | Xoá chính cặp của Ink (giữ tay → vuốt lên → thùng rác) → bấm Update → iOS tạo cặp mới **và chuyển sang cặp đó**, không báo "Unable to switch"; chạy thêm 2 lần → số cặp không tăng tiếp | mục 7 | Functional | Vừa | Cao | Cao | P1 |
| TC-E07 | 🆕 Ink **không bao giờ ghi đè** lên cặp của user — chỉ chuyển màn khoá khỏi cặp đó (xác nhận phát biểu tổng quát của mục 7, cắt lớp qua các case trên) | mục 7 | Functional (tổng hợp) | Vừa | Cao | Cao | P1 |

### F. Cửa sổ "Update your shortcut" (mục 8)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-F01 | Máy đang dùng shortcut cũ, chọn Same as Lock → Update → hiện cửa sổ "Update your shortcut", shortcut **chưa** chạy | mục 8 | Functional | Vừa | Cao (thuộc mảng rủi ro #2 của spec — chuyển từ shortcut cũ) | Cao | P1 |
| TC-F02 | "Just update my Lock Screen" → shortcut cũ chạy như trước: lock đổi, home **không** theo chế độ đã chọn. Bấm Update lần nữa → cửa sổ hiện lại | mục 8 | Functional | Vừa | Cao | Cao | P1 |
| TC-F03 | "Get the new shortcut" → mở đúng luồng update (mục 13.2) | mục 8 | Functional | Vừa | Cao | Cao | P1 |
| TC-F04 | ⚠️ Mơ hồ (mục 1 #4) — Chế độ **Don't change** → bấm Update → **không** hiện cửa sổ, shortcut cũ chạy bình thường (ghi đè home bằng ảnh lịch mà không cảnh báo) — verify hành vi thực tế, **không** tự kết luận pass/fail cho tới khi có câu trả lời câu hỏi mở #2 (mục 4) | mục 8, mục 1 | Functional — chờ xác nhận | Không xác định | Chờ xác nhận Q2 | Chờ xác nhận Q2 | Chờ xác nhận Q2 |
| TC-F05 | Vuốt đóng cửa sổ → không có gì chạy; bấm Update lần nữa → cửa sổ hiện lại | mục 8 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-F06 | Sau khi chuyển xong sang V2 → mọi chế độ bấm Update đều chạy thẳng, **không** hiện cửa sổ nữa | mục 8 | Functional | Vừa | Cao (xác nhận migration đã hoàn tất đúng) | Cao | P1 |

### G. Automation iOS 27 — phần app (mục 9, spec chính)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-G01 | Luồng setup trên iOS 27: bước automation có video hướng dẫn (giọng Anh, mọi ngôn ngữ dùng chung bản này) gạt "At sunrise, daily" rồi "When I get a notification from Ink"; tiêu đề đúng "Turn on the shortcut's automations."; sau video có 2 ảnh, mỗi ảnh khoanh 1 công tắc | mục 9 | Functional/Content | Vừa | Vừa (spec xếp rủi ro #6 cho cả mảng automation) | Vừa | P2 |
| TC-G02 | Bấm "Open Automations" lần đầu → iOS hỏi quyền thông báo **ngay trong Ink** → chọn gì cũng mở tab Automation của Shortcuts; cho phép → rời Ink, Ink bắt đầu tự gửi thông báo (không cần vào Guide bấm thêm) | mục 9 | Functional (core) | Vừa | Cao | Cao | P1 |
| TC-G03 | Từ chối quyền thông báo → vẫn vào được tab Automation, bật Sunrise bình thường; Ink **không** gửi thông báo nào | mục 9 | Functional (negative) | Vừa | Vừa | Vừa | P2 |
| TC-G04 | Guide trên iOS 27: mục automation theo đúng thứ tự **daily → notification → đóng Ink → đóng app lịch**, mỗi mục có ảnh chụp đúng dòng cần bật | mục 9 | Functional/Content | Vừa | Vừa | Vừa | P2 |
| TC-G05 | Guide trên iOS 26: **không** có mục notification, các mục automation vẫn hướng dẫn tự tạo automation như trước | mục 9 | Functional (compatibility) | Vừa | Vừa | Vừa | P2 |

### G2. Automation iOS 27 — từng automation, chi tiết (qc-shortcut-triggers-ios27.md)

**G2.1 — Chuẩn bị/nền tảng cho cả nhóm**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-G06 | Trước khi test nhóm G2/G3: máy sạch, xoá mọi shortcut Ink cũ, xác nhận tab Automation không còn dòng nào của Ink — nếu bỏ qua, cài đè bằng Replace có thể để automation cũ chạy song song, làm kết quả automation không đáng tin | mục 3 (triggers.md) | Entry criteria / Setup | Vừa (dễ bỏ qua) | Cao (làm hỏng toàn bộ baseline nhóm G) | Cao | P1 |
| TC-G07 | Sau khi cài, cả **5 automation** đúng trạng thái **tắt** | mục 1 (triggers.md), mục 9 spec chính | Functional | Thấp | Cao | Cao | P1 |
| TC-G08 | Bật đủ 4 dòng automation (trừ notification, test riêng ở G3) trực tiếp từ danh sách tab Automation | mục 3 (triggers.md) | Exploratory (bật được từ list hay phải vào Edit — không có kỳ vọng "đúng" sẵn, chỉ là hành vi thật của iOS) | — | — | — | — |
| TC-G09 | Mỗi automation mặc định **Run Immediately** hay **Run After Confirmation**? Ghi lại mặc định, sau đó chọn Run Immediately để test tiếp | mục 3 (triggers.md) | Exploratory | — | — | — | — |

**G2.2 — At sunrise, daily**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-G10 | Lần đầu bật/chạy automation Sunrise, iOS có xin quyền vị trí không? | mục 4.1 (triggers.md) | Exploratory | — | — | — | — |
| TC-G11 | Tạo sự kiện `QC sunrise` cho ngày mai, khoá máy qua đêm → sáng hôm sau **chưa mở khoá**: màn khoá đã có sự kiện và đúng ngày mới, **không** hỏi xác nhận, **không** hiện "running your automation" | mục 4.1 (triggers.md) | Functional (core, chạy khi khoá máy) | Vừa | Cao | Cao | P1 |
| TC-G12 | Sau khi Sunrise chạy, mở Ink: **không** có cảnh báo kiểu "automation không chạy" ở Home/Settings | mục 4.1 (triggers.md) | Functional | Vừa | Vừa | Vừa | P2 |

**G2.3 — When Calendar is closed / When Google Calendar is closed**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-G13 | Thêm sự kiện mới trong Lịch → về Home (vuốt lên, không mở Ink) → automation chạy trong vài giây, wallpaper cập nhật | mục 4.2 (triggers.md) | Functional (core) | Vừa | Cao | Cao | P1 |
| TC-G14 | ⚠️ Ranh giới hành vi chưa rõ — chỉ **chuyển sang app khác** (App Switcher), không về Home, có tính là "closed" để trigger automation không? | mục 4.2 (triggers.md) | Functional (boundary, spec tự hỏi không có đáp án sẵn) | Không xác định | Vừa | Vừa | P2 |
| TC-G15 | ⚠️ Ranh giới hành vi chưa rõ — **vuốt tắt hẳn** Lịch trong App Switcher có tính "closed" không? | mục 4.2 (triggers.md) | Functional (boundary) | Không xác định | Vừa | Vừa | P2 |
| TC-G16 | Mở Lịch rồi thoát ngay, không sửa gì → automation vẫn chạy (đúng thiết kế, chỉ ghi nhận), đo mất bao lâu, có làm máy khựng không | mục 4.2 (triggers.md) | Non-functional | Vừa | Thấp | Thấp | P3 |
| TC-G17 | Lặp lại TC-G13 với app Google Calendar (tài khoản đã kết nối Ink) | mục 4.3 (triggers.md) | Functional (core) | Vừa | Cao | Cao | P1 |
| TC-G18 | Máy **không cài** Google Calendar → dòng automation "When Google Calendar is closed" hiện ra sao, có báo lỗi không (robustness) | mục 4.3 (triggers.md) | Robustness (edge case, không có kỳ vọng "đúng" sẵn) | Không xác định | Vừa | Vừa | P2 |

**G2.4 — When Ink is closed**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-G19 | Trong Ink, đổi template/chế độ Home Screen → rời Ink **mà không bấm Set/Update** → màn khoá có cập nhật theo lựa chọn mới không (nếu có, nghĩa là chỉ đổi setting rồi thoát cũng đủ trigger set) | mục 4.4 (triggers.md) | Functional (hành vi mới, tiềm ẩn set nhầm khi mới xem thử) | Cao | Cao | Cao | P1 |
| TC-G20 | Rời Ink **ngay sau** khi bấm Update: shortcut có chạy **2 lần liên tiếp** không (1 do Update, 1 do automation Ink closed)? Có toast lỗi do đè nhau không? | mục 4.4 (triggers.md) | Functional (reliability, race condition) | Cao (2 trigger cùng lúc) | Cao | Cao | P1 |
| TC-G21 | Không bị vòng lặp: shortcut chạy xong (đóng Ink) không tự làm Ink "closed" thêm 1 lần nữa | mục 4.4 (triggers.md) | Robustness | Thấp | Cao (nếu xảy ra, spam automation liên tục) | Cao | P1 |

**G2.5 — Kiểm tra chung sau mỗi lần automation chạy**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-G22 | 🔴 **Regression cho bug đã có báo cáo thật:** Lock phải có lịch, Home chỉ có ảnh nền (chế độ khác Don't change). Nếu 2 màn **đổi chỗ** (đã từng xảy ra thật lúc 00:05, theo mục 5 triggers.md) → ghi lại chế độ, blur, khoá/mở máy, và chạy tay có tái hiện được không | mục 5 (triggers.md) | Functional — regression cho bug đã biết | Cao (đã có tiền lệ thật) | Cao | Cao | P1 |
| TC-G23 | Sau mỗi lần automation chạy, màn khoá vẫn đang dùng đúng cặp wallpaper của Ink (Switch chạy đúng) | mục 5 (triggers.md) | Functional | Vừa | Cao | Cao | P1 |
| TC-G24 | Settings → Debug: "Last shortcut run" có số liệu mới; thẻ In-app messages có dòng `Runs Ink Refresh Lock Screen V2 · old still running false` — nếu `true`, một automation vẫn đang gọi shortcut cũ chồng lên | mục 5 (triggers.md) | Observability — bằng chứng chẩn đoán cho TC-G20/G22 | Vừa | Cao (chỉ báo sớm race condition) | Cao | P1 |

**G2.6 — Trường hợp biên**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-G25 | App tự cài (qua luồng update trong app, không qua Replace) không bao giờ để 2 dòng automation trùng nhau | mục 3.2 (spec chính), mục 13 cảnh báo Replace | Functional/Robustness | Vừa | Cao | Cao | P1 |
| TC-G26 | ⚠️ Nếu cài lại **cùng link bằng Replace** (kịch bản KHÔNG nên xảy ra qua luồng app, chỉ test để hiểu hậu quả khi user tự làm) → tab Automation có bị trùng dòng không, dòng cũ còn bật không | mục 6 (triggers.md), mục 13 cảnh báo | Functional (điều tra hậu quả, không phải case cần "pass") | Vừa | Vừa | Vừa | P2 |
| TC-G27 | Xoá shortcut → cả **5** dòng automation biến mất theo | mục 6 (triggers.md) | Functional (regression) | Vừa | Vừa | Vừa | P2 |
| TC-G28 | Máy Apple Account khác → cài link → automation có về máy không, bật hay tắt | mục 6 (triggers.md) | Exploratory (không có kỳ vọng sẵn — bản chất câu hỏi khám phá cơ chế iCloud) | — | — | — | — |
| TC-G29 | Chế độ nguồn điện thấp (Low Power Mode) / máy nóng — automation Sunrise có bị iOS tự bỏ qua không | mục 6 (triggers.md) | Robustness (edge case hệ điều hành) | Thấp | Vừa | Thấp–Vừa | P3 |
| TC-G30 | Bình minh và mở Lịch xảy ra **cùng lúc** (2 automation trigger gần nhau) → có lỗi chồng chéo gì không (liên hệ TC-G24, `old still running`) | mục 6 (triggers.md) | Robustness (concurrency) | Thấp | Cao (nếu xảy ra, đúng dạng race condition đã lo ngại) | Vừa | P2 |

### G3. Automation qua Notification (qc-notification-automation-ios27.md)

**G3.1 — Passive (không kêu, không sáng màn)**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-G31 | Passive + máy khoá: Delay 15s, gửi rồi khoá máy ngay → trigger vẫn chạy, wallpaper đổi (kịch bản quan trọng nhất của tài liệu này) | mục 4.1 (notification-automation.md) | Functional (core, đã có kết quả sơ bộ từ simulator — cần xác nhận máy thật, xem mục 1 #7) | Vừa | Cao | Cao | P1 |
| TC-G32 | Passive + máy khoá lâu: Delay 60s, khoá máy, để yên → vẫn chạy | mục 4.1 | Functional | Vừa | Cao | Cao | P1 |
| TC-G33 | Passive + máy mở, ở ngoài Ink: Delay 15s, về Home → vẫn chạy | mục 4.1 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-G34 | So sánh: tắt Passive, gửi lại như TC-G31 → xác nhận khác biệt (banner/âm thanh) thực sự do cờ Passive gây ra | mục 4.1 | Functional (baseline so sánh) | Vừa | Vừa | Vừa | P2 |
| TC-G35 | Đang mở Ink khi thông báo tới → **không** hiện banner, chỉ nằm trong danh sách | mục 4.5 | Functional | Vừa | Thấp | Thấp | P3 |

**G3.2 — Remove after the run**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-G36 | Bật Remove after the run (Passive bật), Delay 15s, khoá máy → chờ wallpaper đổi → mở Notification Center → thông báo **không còn** | mục 4.2 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-G37 | Bật Remove nhưng **tắt** "Allow Running When Locked" (khiến lần chạy hỏng) → thông báo **vẫn còn lại** (chỉ xoá khi chạy tới cuối) | mục 4.2 | Functional (negative, xác nhận không xoá nhầm khi lỗi) | Vừa | Vừa | Vừa | P2 |

**G3.3 — Bộ lọc Title/Body**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-G38 | Title **không** có `·` → **không** được chạy | mục 4.3 | Functional (negative) | Vừa | Cao (tránh chạy nhầm khi có thông báo khác) | Cao | P1 |
| TC-G39 | Body **không** có `Ink` → **không** được chạy | mục 4.3 | Functional (negative) | Vừa | Cao | Cao | P1 |
| TC-G40 | Body có `ink` viết thường thay vì `Ink` — có chạy hay không (bộ lọc phân biệt hoa/thường)? Kết quả sơ bộ từ simulator: **không** chạy — cần xác nhận lại trên máy thật | mục 4.3, mục 1 #7 | Functional (đã có gợi ý kết quả, cần verify) | Vừa | Vừa | Vừa | P2 |

**G3.4 — Khi user đổi cài đặt thông báo**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-G41 | Tắt hẳn thông báo của Ink → gửi lại → trigger có chạy không | mục 4.4 | Exploratory (không có kỳ vọng sẵn — phụ thuộc cơ chế iOS silent notification) | — | — | — | — |
| TC-G42 | Tắt "Show on Lock Screen", giữ Notification Center → gửi khi máy khoá → có chạy | mục 4.4 | Exploratory | — | — | — | — |
| TC-G43 | Bật Scheduled Summary cho Ink → gửi lại → chạy ngay hay đợi tới giờ tóm tắt | mục 4.4 | Exploratory | — | — | — | — |
| TC-G44 | Bật một Focus chặn Ink → gửi lại → có chạy | mục 4.4 | Exploratory | — | — | — | — |

**G3.5 — Thông báo thật (không qua mục Debug)**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-G45 | Chưa bấm nút bật notification trong Guide/setup (vd máy đã setup từ bản cũ) → Ink **không** tự gửi gì, kể cả đã cho phép thông báo hệ thống | mục 4.5 | Functional (negative, boundary rõ) | Vừa | Cao | Cao | P1 |
| TC-G46 | Đã từ chối quyền thông báo trước đó → bấm nút trong Guide → app mở trang Settings của Ink (iOS không hỏi lần 2) → bật Notifications ở đó → lần rời Ink sau, Ink bắt đầu gửi mà **không** cần bấm lại nút | mục 4.5 | Functional (recovery path) | Vừa | Cao | Cao | P1 |
| TC-G47 | Sửa trong Ink (thêm/sửa/xoá sự kiện hôm nay) → về Home → sau ~2 giây có thông báo đúng nội dung → wallpaper đổi → thông báo tự biến mất khỏi Notification Center | mục 4.5 | Functional (core) | Vừa | Cao | Cao | P1 |
| TC-G48 | Mở rồi đóng Ink mà **không** sửa gì → **không** có thông báo | mục 4.5 | Functional (negative) | Vừa | Vừa | Vừa | P2 |
| TC-G49 | Sửa ở app Calendar, rồi mở và đóng Ink → có thông báo như TC-G47 | mục 4.5 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-G50 | Buổi sáng: đổi giờ máy sang 04:59 ngày mai → 05:00 có thông báo đúng nội dung → wallpaper đổi; thông báo này **ở lại** trong Notification Center (khác TC-G47, không tự xoá) | mục 4.5 | Functional | Vừa | Cao | Cao | P1 |
| TC-G51 | Đổi ngôn ngữ máy (vd Tiếng Việt) → nội dung thông báo được dịch, automation vẫn chạy | mục 4.5 | Functional (l10n) | Vừa | Vừa | Vừa | P2 |

**G3.6 — Chạy nền (chỉ máy thật, cần Xcode)**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-G52 | Mở Ink rồi về Home (để app gửi yêu cầu chạy nền) → thêm sự kiện qua app Calendar (không mở Ink) → simulate `BGTaskScheduler` từ Xcode → thông báo tới, shortcut chạy, thông báo tự xoá | mục 4.6 | Functional (không test được trên simulator, chỉ máy thật) | Vừa | Cao (đường trigger chạy nền thật, không phải qua Debug) | Cao | P1 |

**G3.7 — Ảnh hưởng phần còn lại của app**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-G53 | Sau mỗi lần automation (notification) chạy, mở Ink: **không** hiện cảnh báo "automation không chạy" | mục 5 (notification-automation.md) | Functional | Vừa | Vừa | Vừa | P2 |
| TC-G54 | Wallpaper đúng template và đúng chế độ Home Screen đang đặt sau khi automation chạy | mục 5 (notification-automation.md) | Functional | Vừa | Cao | Cao | P1 |
| TC-G55 | Nút Update trong app vẫn chạy bình thường sau khi các automation notification đã chạy nhiều lần | mục 5 (notification-automation.md) | Functional (regression) | Thấp | Vừa | Vừa | P2 |

### H. Chéo phiên bản (mục 10)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-H01 | iOS 26: cài link V2 → shortcut chạy đủ 4 chế độ Home Screen, tab Automation **không** có dòng nào tự thêm | mục 10 | Compatibility | Vừa | Vừa | Vừa | P2 |
| TC-H02 | Máy iOS 26 đã chuyển sang V2 rồi lên iOS 27: app **không** mời cài lại link (tránh Replace); automation user tự tạo trên iOS 26 vẫn chạy | mục 10 | Compatibility | Vừa | Vừa | Vừa | P2 |

### I. Công cụ Debug (mục 12, chỉ bản Dev)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-I01 | "Last shortcut run" hiển thị đúng 2 số liệu tách biệt (after-render→confirm, total) — công cụ đo nền tảng cho các case tốc độ (TC-C09, TC-C14...) | mục 12 | Functional + Non-functional | Vừa | Cao (nếu sai, mọi case tốc độ mất căn cứ đo) | Cao | P1 |
| TC-I02 | "Wallpaper format" chọn được PNG/JPEG/HEIC 1.0, mặc định đúng HEIC 1.0 | mục 12 | Functional | Thấp | Thấp | Thấp | P3 |
| TC-I03 | Mục Debug chỉ xuất hiện ở bản Dev, không có ở Prod | mục 12 | Functional (smoke) | Thấp | Vừa (lộ công cụ debug ra bản thật) | Vừa | P3 |
| TC-I04 | Log console lọc "Ink" hiện đủ dòng `[InkShortcut]` (token, thời gian, `thermal=`, kết quả callback) | mục 12 | Observability (hỗ trợ QC) | Thấp | Thấp | Thấp | P3 |

### J. Chuyển từ shortcut cũ sang V2 (mục 13 — hoàn toàn mới, rủi ro #2 theo spec)

**J.1 — Lời mời chuyển (13.1)**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-J01 | Mở app **lần đầu** sau khi cập nhật → **không** hiện lời mời (không bao giờ hiện ở lần mở đầu tiên) | mục 13.1 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-J02 | Lần mở sau: hiện sheet mời chuyển, đúng nội dung theo iOS (26: "A better way to update your lock screen"; 27: "Ink is ready for iOS 27"), nút chính "Get the new shortcut" mở luồng update, đúng chữ mô tả bên dưới | mục 13.1 | Functional/Content | Vừa | Cao (điểm vào chính của toàn bộ luồng migration) | Cao | P1 |
| TC-J03 | Đóng sheet → trong **3 ngày** không hiện lại; tối đa **3 lần** tổng cộng | mục 13.1 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-J04 | Tab Guide mở đầu bằng thẻ lớn "See what's new" → mở bài "Ink's new shortcut": ảnh đầu bài đúng theo iOS 26/27, mục "What you get" (iOS 27 có thêm "Updates itself every morning"), "How to switch" 3 bước, nút "Get the new shortcut" | mục 13.1 | Functional/Content | Vừa | Cao | Cao | P1 |
| TC-J05 | Máy **chưa có shortcut** nào (cài mới): thẻ vẫn hiện; bài viết có "How to set it up" chỉ **2 bước** (không có bước xoá shortcut cũ), nút mở luồng setup lần đầu | mục 13.1 | Functional (edge case: user hoàn toàn mới) | Vừa | Vừa | Vừa | P2 |
| TC-J06 | Chọn chế độ Home Screen khác Don't change rồi Update trên máy đang dùng shortcut cũ → cửa sổ "Update your shortcut" hiện (liên kết trực tiếp nhóm F) | mục 13.1, mục 8 | Functional | Vừa | Cao | Cao | P1 |

**J.2 — Luồng update 3 bước (13.2)**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-J07 | Mở luồng update từ **bất kỳ** entry point nào (lời mời, thẻ Guide, cửa sổ mục 8, Settings, banner Home, ⓘ editor, trang How updates work) đều vào đúng luồng **update** (không phải luồng cài lần đầu) cho user đã có shortcut cũ | mục 13.2 | Functional | Vừa | Cao | Cao | P1 |
| TC-J08 | Bước 1 — Add shortcut → Shortcuts mở link V2 → Add Shortcut → thư viện có **cả 2** shortcut (V2 tên đúng `Ink Refresh Lock Screen V2`), **không** có Replace | mục 13.2 | Functional (core, phải luôn tránh Replace) | Vừa | Cao | Cao | P1 |
| TC-J09 | App chạy thử V2 để xác nhận → về app, bước 1 đánh dấu xong. Nếu lần chạy thử **lại gọi shortcut cũ** → **không** được tính là xong | mục 13.2 | Functional | Vừa | Cao | Cao | P1 |
| TC-J10 | ⚠️ Thiếu mô tả UX khi xác nhận thất bại (mục 1 #5) — Verify hành vi thực tế khi bước 1 liên tục thất bại (chạy thử vẫn gọi shortcut cũ): có thông báo lỗi, hướng dẫn thử lại không, hay chỉ im lặng không tích xong? | mục 13.2, mục 1 | Functional — chờ xác nhận Q3 | Không xác định | Chờ xác nhận Q3 | Chờ xác nhận Q3 | Chờ xác nhận Q3 |
| TC-J11 | Bước 2 — hướng dẫn nêu **đúng tên** shortcut cũ; xoá trong Shortcuts → về app → sang bước sau; có nút bỏ qua bước này | mục 13.2 | Functional | Vừa | Cao | Cao | P1 |
| TC-J12 | Bước 3 — iOS 26 hướng dẫn tạo lại automation cho V2 (vì xoá shortcut cũ làm mất automation cũ); iOS 27 hướng dẫn bật "At sunrise, daily" có sẵn | mục 13.2 | Functional | Vừa | Cao | Cao | P1 |
| TC-J13 | Xong luồng: bấm Update với Same as Lock/No calendar → chạy thẳng V2, home theo đúng chế độ | mục 13.2 | Functional (xác nhận migration hoàn tất) | Vừa | Cao | Cao | P1 |
| TC-J14 | Bỏ dở giữa chừng (sau bước 1) → mở lại từ thẻ Guide: bước 1 hiện **đã xong** (dấu ✓), nút chính vẫn mở luồng update (tiếp tục từ bước 2) | mục 13.2 | Functional/State (resume) | Vừa | Vừa | Vừa | P2 |

**J.3 — Shortcut cũ vẫn còn chạy (13.3)**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-J15 | Bỏ qua bước xoá, giữ automation cũ → sáng hôm sau (hoặc chạy tay shortcut cũ) → mở Ink: hiện sheet "Two Ink shortcuts are running", hướng dẫn giữ tay shortcut cũ → Delete, nút Open Shortcuts mở app Shortcuts | mục 13.3 | Functional (core) | Vừa | Cao | Cao | P1 |
| TC-J16 | Lần chạy của shortcut cũ **vẫn đặt được wallpaper**, không hiện toast lỗi | mục 13.3 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-J17 | Thẻ Guide lúc này đổi tiêu đề thành "Two Ink shortcuts are running", nút chính "Open Shortcuts" | mục 13.3 | Functional/Content | Vừa | Vừa | Vừa | P2 |
| TC-J18 | Sau khi sheet nhắc đã hiện, xoá shortcut cũ → mở lại Ink: thẻ Guide **biến mất** (không còn lần chạy cũ nào sau lúc nhắc); bài viết đang mở tự đóng khi quay lại app | mục 13.3 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-J19 | **Không** xoá → shortcut cũ chạy tiếp → nhắc hiện lại sau 3 ngày, tối đa 3 lần; không có lần chạy cũ nào trong 7 ngày → nhắc và thẻ Guide tự hết | mục 13.3 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-J20 | Settings → Debug → In-app messages: dòng `old still running` đúng với thực tế; nút Show iOS ≤26/Show iOS 27/Show remove old shortcut xem trước từng sheet đúng; Reset show history cho hiện lại từ đầu | mục 13.3 | Functional (debug tooling) | Thấp | Thấp | Thấp | P3 |

**J.4 — Bảng thăm dò mục 11 liên quan migration**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-J21 | Thẻ "Ink's new shortcut" trong Guide có tự biến mất khi đã chuyển xong V2 hoàn toàn không? Spec không nêu rõ vòng đời thẻ này sau khi migrate xong (khác thẻ "Two Ink shortcuts" đã được xác nhận rõ ở TC-J18) | mục 11, mục 13.1 | Exploratory (không có đáp án đúng sẵn trong spec) | — | — | — | — |

> Kết quả TC-J15/J18 (xoá shortcut cũ xong, nhắc "Two Ink shortcuts" có tự hết) cũng cần log vào bảng mục 11 khi
> execute — không tạo thêm test condition Exploratory riêng vì đã có pass/fail rõ ở mục 13.3.

### K. Trang "How updates work" (mục 14 — rủi ro thấp nhất trong 9 mảng, nhưng vẫn có checklist rõ)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-K01 | iOS 27, đã có shortcut: đoạn giải thích + nút "How to set it up" (icon chuông) → mở đúng mục Guide "Refresh the moment your schedule changes" | mục 14 | Functional | Vừa | Thấp (spec xếp rủi ro #9, thấp nhất) | Thấp | P3 |
| TC-K02 | iOS 27, chưa có shortcut: chỉ có đoạn giải thích, **không** có nút | mục 14 | Functional | Vừa | Thấp | Thấp | P3 |
| TC-K03 | iOS 26: đoạn giải thích + dòng mờ "Needs iOS 27..." **không** có nút | mục 14 | Functional | Vừa | Thấp | Thấp | P3 |
| TC-K04 | Nút mũi tên cuộn xuống đi từng phần; nút "I understand" chỉ sáng khi đã cuộn tới cuối trang | mục 14 | Functional/UX | Vừa | Thấp | Thấp | P3 |
| TC-K05 | Đổi ngôn ngữ máy (vd Tiếng Việt, Arabic): mục mới được dịch; tiêu đề giữ đoạn tô màu | mục 14 | Functional (l10n) | Vừa | Thấp | Thấp | P3 |

### L. Event analytics (mục 15 — quan sát nội bộ, không chặn UX người dùng)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-L01 | Lời mời update (IAM) hiện, bấm nút/vuốt tắt → bắn đúng `in_app_message_shown` rồi `in_app_message_action` (`action` = `primary`/`dismiss`) | mục 15 | Non-functional (Observability) | Vừa | Thấp (chỉ ảnh hưởng báo cáo nội bộ, không chặn UX) | Thấp | P3 |
| TC-L02 | Bấm nút chính IAM rồi đi hết luồng → `setup_started` … `setup_completed`, `source`=`in_app_message`, `kind`=`setup_shortcut_update` | mục 15 | Non-functional | Vừa | Thấp | Thấp | P3 |
| TC-L03 | Cửa sổ "Update your shortcut", chọn cài → `shortcut_upgrade_gate` `action`=`install`, rồi các event `setup_*` với `source`=`upgrade_gate` | mục 15 | Non-functional | Vừa | Thấp–Vừa (liên quan trực tiếp funnel migration, mảng rủi ro #2) | Vừa | P2 |
| TC-L04 | Mở luồng setup từ Guide/Settings/announcement → đúng `source` tương ứng trong các event `setup_*` | mục 15 | Non-functional | Vừa | Thấp | Thấp | P3 |
| TC-L05 | iOS 27, máy chưa từng trả lời hỏi thông báo: bước automation → Open Automations → `push_permission_result` đúng `status`, đúng `source` (`setup`/`guide`); mở lại app lần sau **không** bắn thêm `push_permission_result` với `source`=`second_open` | mục 15 | Non-functional | Vừa | Thấp–Vừa | Vừa | P2 |
| TC-L06 | Mở Guide → `screen_view` `how_to_guide`; bấm nút trong 1 topic → `guide_action_tapped` đúng `action`/`source` | mục 15 | Non-functional | Vừa | Thấp | Thấp | P3 |
| TC-L07 | iOS 27, đã bật thông báo, shortcut V2 mới nhất: mở/thoát Ink 1 lần trong ngày trước, sau đó sửa event hôm nay rồi thoát lần nữa → `refresh_notification_posted` bắn đúng 1 lần cho mỗi lần đổi lịch; lần thoát **đầu tiên** trong ngày không gửi gì | mục 15 | Non-functional | Vừa | Vừa (liên quan trực tiếp cơ chế notification-trigger ở nhóm G3) | Vừa | P2 |

---

## 3. Traceability nháp

| Test condition # | Mục test basis | Ghi chú cho test-plan |
|---|---|---|
| TC-A01 → TC-A12 | mục 1, 3, 3.1, 3.2 | Nhóm nền tảng — nếu sai, mọi case sau không đáng tin. TC-A05 (đếm action) nên chạy **đầu tiên** trong đợt test, trước khi thiết kế Decision Table chi tiết cho nhóm C — nếu số Set/Switch lệch so với 11/3 spec công bố, cần cập nhật lại toàn bộ Decision Table nhóm C trước khi viết case. Gợi ý mã test object: `TC-SH-INS` (đã dùng ở test-plan cũ cho luồng cài đặt). |
| TC-B01 → TC-B10 | mục 4 | TC-B01–06 là regression thuần — test-plan/test-cases cũ (`TC-SH-OLD`) đã có Decision Table/case tương đương, có thể tái dùng kỹ thuật, không cần thiết kế lại. TC-B07–10 là nhóm case hoàn toàn mới (toast) — cần Decision Table riêng theo vị trí hiển thị (màn edit/sheet/lỗi cài đặt). |
| TC-C01 → TC-C26 | mục 5, mục 11 (phần liên quan) | TC-C01 dùng Decision Table 7 dòng có sẵn trong chính spec (mục 5, bảng "tra nhanh") — **đã tự nhất quán** với 2 sơ đồ mermaid khi đối chiếu tay (không phát hiện mâu thuẫn nội bộ ở phần này, khác hẳn tình huống bản cũ). TC-C11–C20b là nhóm phức tạp nhất (tổ hợp mode × blur-thay-đổi × hash-ảnh × mốc 24h) — gợi ý test-plan dùng **State Transition Testing** thay vì bảng phẳng. TC-C21–23 xếp Exploratory/quan sát (không ngưỡng khách quan). TC-C24–26 là Exploratory thuần, dùng để điền bảng mục 11 của spec. |
| TC-D01 → TC-D13 | mục 6 | TC-D01–09 (My photo trong Ink) và TC-D10–13 (tự chọn qua iOS, Don't change giữ nguyên) là 2 nhóm tương đối độc lập — có thể thiết kế 2 bộ case riêng, dùng chung kỹ thuật EP/State Transition. |
| TC-E01 → TC-E07 | mục 7 | Cơ chế cặp wallpaper: Decision Table/BVA "trước/sau 4 chế độ", "trước/sau 3 lần Update" đã có tiền lệ ở `TC-SH-PAIR` (test-cases-ios26-27.md) — tái dùng kỹ thuật, không thiết kế lại từ đầu, chỉ đổi tên 4 chip theo spec mới (Don't change/Same as Lock/No calendar/My photo). |
| TC-F01 → TC-F06 | mục 8 | TC-F04 (Don't change không cảnh báo) treo chờ câu hỏi mở #2 (mục 4) — **không** viết Decision Table cho nhánh Don't change của cửa sổ update cho tới khi có câu trả lời. |
| TC-G01 → TC-G05 | mục 9 (spec chính) | Nhóm ngắn, chủ yếu content/UI — gợi ý gộp chung 1 Test Suite "Automation setup UX" với TC-G06–09. |
| TC-G06 → TC-G30 | qc-shortcut-triggers-ios27.md | Nhóm hoàn toàn mới, không có tiền lệ ở test-plan cũ. TC-G14/G15/G18 (ranh giới "closed") gợi ý **State Transition Testing** cho định nghĩa "closed" (App Switcher/vuốt tắt/về Home) vì spec tự để ngỏ. TC-G22 là **regression case bắt buộc**, không phải case thăm dò, vì đã có báo cáo thật (Lock/Home đổi chỗ lúc 00:05). |
| TC-G31 → TC-G55 | qc-notification-automation-ios27.md | Nhóm lớn nhất, mới hoàn toàn. TC-G31/32/36/37/52 nên chạy trên **máy thật** (một số không test được trên simulator — mục 4.6). Kết quả sơ bộ từ simulator (mục 6 tài liệu gốc) chỉ dùng làm gợi ý, không copy làm kết luận cuối. |
| TC-H01 → TC-H02 | mục 10 | Compatibility — case ngắn, không cần kỹ thuật thiết kế phức tạp. |
| TC-I01 → TC-I04 | mục 12 | Công cụ hỗ trợ đo — TC-I01 nên verify **trước** khi chạy các case tốc độ (TC-C09, TC-C14...) vì nó là công cụ đo nền tảng. |
| TC-J01 → TC-J21 | mục 13 (toàn bộ) | Mảng lớn thứ 2 theo rủi ro spec tự xếp. Cần chuẩn bị máy "người dùng cũ" riêng (theo hướng dẫn đầu mục 13) trước khi chạy nhóm này — coi đây là entry criteria riêng cho nhóm J, không dùng chung môi trường với nhóm C/D/E (đã cài V2 sẵn). TC-J10 treo chờ câu hỏi mở #3. Gợi ý **State Transition Testing** cho luồng 3 bước (mỗi bước là 1 state, TC-J14 test khả năng resume). |
| TC-K01 → TC-K05 | mục 14 | Case ngắn, rủi ro thấp nhất — có thể gộp vào 1 Test Suite nhỏ, không cần ưu tiên thời gian test nhiều. |
| TC-L01 → TC-L07 | mục 15 | Cần Firebase DebugView/Realtime làm môi trường phụ trợ (ghi rõ ở mục 7 test-plan "Test environment matrix"). Không cần kỹ thuật thiết kế case phức tạp — chủ yếu là kiểm tra đối chiếu tên event/tham số. |

---

## 4. Câu hỏi cần làm rõ trước khi lập test plan

1. **Thứ tự thật của "Tab Automation"** (mục 1 #2) — `qc-shortcut-triggers-ios27.md` và `qc-notification-automation-ios27.md` đưa ra 2 thứ tự khác nhau cho cùng 5 automation, đặc biệt vị trí của "When I get a notification from Ink" (thứ 2 vs cuối). Cần hỏi người viết 2 tài liệu (có thể là 2 đợt viết khác nhau của cùng 1 QC) để chốt lại 1 thứ tự đúng trước khi viết test condition mô tả thứ tự hiển thị trong tab Automation. **Ảnh hưởng:** chỉ 1 test condition (P3, nội dung thứ tự hiển thị) — không chặn các test condition chức năng khác của nhóm G, có thể tiếp tục test-plan song song và hỏi lại khi rảnh.

2. **Cửa sổ "Update your shortcut" không cảnh báo cho chế độ Don't change** (mục 1 #4, ảnh hưởng TC-F04) — 2 cách hiểu: (a) chủ ý, shortcut cũ vốn không hiểu Don't change nên không cần cảnh báo riêng; (b) gap UX thật, vì "Don't change" chính là trường hợp kỳ vọng "không đụng home" bị vi phạm rõ nhất nhưng lại không được cảnh báo như 3 chế độ kia. **Ảnh hưởng:** quyết định TC-F04 là **pass** (đúng thiết kế) hay **fail** (cần báo bug/feature gap) — cần hỏi PM/dev trước khi viết case cho nhánh Don't change của cửa sổ update.

3. **UX khi xác nhận chạy thử V2 thất bại lặp lại ở bước 1 luồng update** (mục 1 #5, ảnh hưởng TC-J09/J10) — spec chỉ nói "không được tính là xong", không mô tả app có báo lỗi, hướng dẫn thử lại, hay giới hạn số lần thử không. **Ảnh hưởng:** cần câu trả lời để thiết kế case cho đường lỗi (negative path) của bước 1 — nếu không có, QC sẽ phải tự quan sát hành vi thực tế trên máy và báo lại như 1 phát hiện mới, không tự coi im lặng là "đúng thiết kế".

> Không câu hỏi nào ở trên **chặn hoàn toàn** việc chạy test-plan — cả 3 chỉ ảnh hưởng phạm vi/risk của một vài test
> condition cụ thể (TC-F04, TC-J09/J10, và 1 case P3 về thứ tự tab). Câu hỏi #2 và #3 là lý do tài liệu này được
> đánh dấu `⚠️ DRAFT cục bộ` ở đầu file — theo đúng mục 5 của skill test-analysis ("nếu còn câu hỏi ảnh hưởng risk
> level/scope của test condition quan trọng → dừng ở đây, không báo sẵn sàng chạy test-plan"). Phần còn lại của
> tài liệu (167/169 test condition, gồm cả 3 mảng rủi ro cao nhất: luồng cũ không vỡ — nhóm B, migration — nhóm J
> trừ TC-J09/J10, bốn chế độ Home Screen — nhóm C) đã có đủ căn cứ risk rõ ràng, dùng được ngay cho test-plan song
> song trong lúc chờ câu trả lời cho câu hỏi #2/#3.
