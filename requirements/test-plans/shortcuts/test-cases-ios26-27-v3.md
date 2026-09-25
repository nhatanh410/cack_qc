# Test Case Specification — Shortcut wallpaper Home Screen + Automation iOS 27 (v3, sau merge PR #302)

> Thiết kế case theo [test-plan-ios26-27-v3.md](test-plan-ios26-27-v3.md) (ISTQB Foundation) — bám đúng kỹ thuật
> đã chọn ở mục 5 test plan, copy nguyên partition/rule/transition, không tự sáng tác kỹ thuật khác.
> Test basis: [qc-shortcut-home-screen-ios26-27-V2.md](../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2.md),
> [qc-shortcut-triggers-ios27.md](../../specs/shortcuts/qc-shortcut-triggers-ios27.md),
> [qc-notification-automation-ios27.md](../../specs/shortcuts/qc-notification-automation-ios27.md).
> Test condition nguồn: [test-analysis-ios26-27-v3.md](test-analysis-ios26-27-v3.md) (169 TC, mã `TC-A01`…`TC-L07`
> — dẫn chiếu trong ngoặc ở cột "Bước thực hiện" của mỗi case bên dưới để truy ngược).
> Đối chiếu case cũ: [test-cases-ios26-27.md](test-cases-ios26-27.md) — nhóm `OLD`/`PAIR` kế thừa phần lớn logic.
> **Ngày lập:** 2026-09-25 · **Người lập:** QC

## Quy ước

- **Ưu tiên:** P1 (chặn phát hành) · P2 · P3 — copy nguyên từ mục 6 test plan / test-analysis mục 2, **không tự
  nâng/hạ**. Case không có TC nguồn tương ứng (🆕) được gán priority kèm lý do tường minh ngay trong case.
- **🔭 Exploratory** — test basis tự khai không có đáp án đúng sẵn (§4.4.2). Cột "Kết quả mong đợi" ghi
  "**Phải quan sát/ghi lại**" + trỏ đúng bảng ghi kết quả nguồn (mục 11 spec chính / mục 8 `triggers-ios27.md` /
  mục 6 `notification-automation-ios27.md`), không phải PASS/FAIL.
- **⚠️ Phụ thuộc gap mở** — chỉ dùng cho case ứng với đúng 1 trong 3 gap ở mục 10 test-plan-v3 (thứ tự tab
  Automation trong Guide → ảnh hưởng `TC-SH-AUTO-04`; cửa sổ Update your shortcut không cảnh báo Don't change →
  `TC-SH-GATE-05`; UX xác nhận chạy thử V2 thất bại lặp lại → `TC-SH-MIG-11`). Chạy và ghi nhận hành vi thật,
  **không tự đoán câu trả lời** hay tự kết luận pass/fail.
- **🆕** — case bổ sung ngoài 169 TC của test-analysis: hoặc lấy từ **mục 11 test-plan-v3** (coverage gap QC đã
  liệt trước), hoặc error-guessing mới của người viết test case. Luôn ghi rõ nguồn ngay trong case, không trộn
  với case bám test basis như đã có tiền lệ.
- **Ảnh bằng chứng:** lưu vào `screenshots/<mã nhóm>/`, đặt tên `<ID case>-<hậu tố màn hình/state>.png` — xem
  [screenshots/README.md](screenshots/README.md) (đã cập nhật thêm mã nhóm v3: `GATE`, `MIG`, gộp `TRIG` vào
  `AUTO`).
- **Môi trường mặc định mọi case** (không lặp lại trong từng case): build **Ink Dev** dựng từ `main` (đã merge
  PR #302, 2026-09-24) qua Xcode hoặc App Distribution — **không** phải bản App Store/TestFlight. Cài qua link
  iCloud Dev `https://www.icloud.com/shortcuts/007226dffb9240439830f196201a5ed6`. Thiết bị: iPhone iOS 26.x +
  iPhone iOS 27 (bắt buộc cả hai, trừ khi case tự ghi rõ chỉ 1 hệ), máy thứ hai Apple Account khác (bắt buộc cho
  `AUTO`/`PAIR`), máy "người dùng cũ" riêng cho `MIG` (xem mục 7 test-plan). Thư viện wallpaper ≥3 cặp (≥1 cặp
  ảnh riêng) đã chuẩn bị sẵn trên mỗi máy trước khi bắt đầu (entry criteria mục 8 test-plan).
- **Thứ tự chạy bắt buộc:** `TC-SH-INS-05` (đếm 11 Set/3 Switch) và `TC-SH-DBG-01` (Last shortcut run đúng số
  liệu) phải verify **sớm nhất** — là căn cứ nền tảng cho toàn bộ Decision Table/State Transition ở nhóm `HS` và
  mọi phép đo tốc độ. Nếu số Set/Switch lệch 11/3 → dừng theo Suspension criteria (mục 8.1 test-plan), không tin
  bất kỳ case `HS` nào khác cho tới khi cập nhật lại.

---

## 1 · Cài shortcut & giữ nhiều shortcut · `TC-SH-INS` (mục 1, 3 test basis — test-plan mục 5.3 EP)

> **EP nguồn (mục 5.3 test-plan):** 4 partition trạng thái thư viện shortcut khi cài mới — {chưa có shortcut nào
> tên đúng · đã có 1 shortcut đúng tên đó · có shortcut V1 đổi tên giả thành tên V2 (negative) · có nhiều
> shortcut khác tên hợp lệ}. Map: `INS-01`=partition 1, `INS-08`=partition 2, `INS-11`=partition 3,
> `INS-13`=partition 4 — đủ 4/4 partition.
> **Chạy `INS-05` đầu tiên trong toàn đợt test** (xem Quy ước).

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-INS-01 | Máy chưa có shortcut Ink nào (partition 1) — mở Ink → luồng setup (nút Set trên template, hoặc Settings → shortcut) → **Add shortcut** → Shortcuts mở link → **Add Shortcut** (TC-A01) | Shortcut được thêm đúng tên `Ink Refresh Lock Screen V2`, không action nào hiện màu đỏ | P1 |
| TC-SH-INS-02 | Trên máy Dev, cài nhầm link **Prod** (`dd5b40be…`) (TC-A02) | Các action của Ink hiện **màu đỏ** — xác nhận đây là do cài nhầm bản, không phải bug; không log bug | P3 |
| TC-SH-INS-03 | Không cài tay — dùng nút **Add shortcut** trong luồng setup app (TC-A03) | Mở đúng link của bản app đang chạy (Dev → link Dev), không cần chỉnh tay | P2 |
| TC-SH-INS-04 | Chỉ iOS 27: sau khi cài (INS-01), mở shortcut → ⓘ → Privacy → bật **Allow Running When Locked** (TC-A04) | Bật thành công; cờ này **không tự đi theo link**, phải bật tay mỗi máy — verify lại bằng cách cài shortcut ở máy khác, cờ mặc định tắt | P1 |
| TC-SH-INS-05 | 🔴 **Chạy đầu tiên** — mở shortcut vừa cài, đếm action (TC-A05) | Đúng **11 action "Set Wallpaper"** và **3 action "Switch"**, không action nào đỏ. Nhánh Same as Lock dùng action Lock+Home (1 lần ghi 2 màn); nhánh còn lại set Lock rồi mới set Home, đối chiếu khớp bảng "tra nhanh" mục 5.1 test-plan. Nếu số liệu lệch 11/3 → dừng theo Suspension criteria, báo dev | P1 |
| TC-SH-INS-06 | Mở lần lượt cả 3 action **"Switch Between Wallpapers"** (TC-A06) | Ô cặp wallpaper hiện đúng biến **"Wallpaper"** (kết quả action Set đầu). Ô **không trống**; chạy shortcut **không** hiện popup bắt chọn wallpaper — sai 1 trong 2 ý → báo ngay, lỗi chặn phát hành | P1 |
| TC-SH-INS-07 | Lần chạy đầu, dialog quyền đặt wallpaper → chọn **Always Allow** → chạy tiếp Set/Switch còn lại trong cùng lần chạy (TC-A07) | Không hỏi lại quyền cho các Set/Switch sau trong cùng 1 lần chạy | P2 |
| TC-SH-INS-08 | Partition 2 — máy đã có 1 shortcut đúng tên `Ink Refresh Lock Screen V2` → cài lại **cùng link** (TC-A08) | iOS hỏi **Replace** (không tự tạo bản `(1)`) — ghi nhận, **không** bấm Replace (huỷ), giữ nguyên bản gốc để không phá môi trường `HS`/`OWN`/`PAIR` | P2 |
| TC-SH-INS-09 | Đổi tên shortcut V2 đang chạy sang tên khác rồi đổi lại → verify automation vẫn còn (TC-A09) | Automation gắn với **chính shortcut**, không theo tên — automation của shortcut vẫn nguyên sau khi đổi tên qua lại | P1 |
| TC-SH-INS-10 | Xoá shortcut V2 (mang theo automation đã bật) (TC-A10) | Automation của shortcut đó **bị xoá theo**, không để sót automation mồ côi trong tab Automation | P1 |
| TC-SH-INS-11 | Partition 3 (negative) — đổi tên shortcut **cũ (V1)** thành đúng tên `Ink Refresh Lock Screen V2` (TC-A11) | App vẫn phân biệt đúng qua **hành vi action** (hỏi chế độ Home Screen trước khi vẽ = V2 thật; không hỏi = V1 giả danh), **không** dựa vào tên — bật nhắc "Two Ink shortcuts are running" (liên kết `TC-SH-MIG-17`). Đổi tên lại đúng sau khi test xong | P1 |
| TC-SH-INS-12 | Cài 1 shortcut khác (không phải V2) lần đầu → verify hỏi quyền Always Allow riêng (TC-A12) | Quyền "Always Allow" tính **riêng từng shortcut** — shortcut mới có thể hỏi quyền lại dù shortcut V2 đã Always Allow trước đó | P3 |
| TC-SH-INS-13 | Partition 4 — thư viện đã có ≥2 shortcut khác tên hợp lệ (đã đổi tên đúng quy ước mục 3.2) → cài thêm shortcut V2 mới (nguồn: mục 5.3 test-plan, partition 4, không có TC-A0x riêng) | Cài thành công, không xung đột tên; automation của từng shortcut không lẫn nhau — verify bằng cách chạy automation của 1 shortcut cũ, xác nhận không kích hoạt shortcut V2 mới | P2 |

---

## 2 · Luồng set wallpaper cũ không vỡ + Toast · `TC-SH-OLD` (mục 4 test basis — regression + DT2 Toast)

> `OLD-01`…`OLD-06` regression thuần, kế thừa logic từ `test-cases-ios26-27.md` nhóm `TC-SH-OLD-01…06` (không
> thiết kế lại) — chạy trên shortcut **V2 thật** (11 Set/3 Switch), không dựa kết luận cũ viết cho 1 Set. Để mode
> **Don't change** cho toàn bộ nhóm. `OLD-07`…`OLD-10` copy đúng 4 rule Decision Table 2 (mục 5.4 test-plan,
> hoàn toàn mới, không tiền lệ).

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-OLD-01 | Discover → chọn 1 template → **Set as current** (TC-B01) | Shortcut chạy → lock đổi đúng template → app quay lại → template hiện nhãn đang dùng | P1 |
| TC-SH-OLD-02 | Mở template đang dùng → sửa nội dung → **Update** (TC-B02) | Lock đổi theo đúng nội dung mới | P1 |
| TC-SH-OLD-03 | Lần chạy đầu, dialog quyền → chọn **Don't Allow** → mở lại app (TC-B03) | App **không** coi là đã set thành công — không hiện nhãn đang dùng cho template mới | P1 |
| TC-SH-OLD-04 | Đổi tên shortcut `Ink Refresh Lock Screen V2` sang tên khác (coi như xoá) → bấm **Set** trong app (TC-B04) | App nhận ra không còn shortcut, đưa vào luồng cài đặt, **không kẹt** ở màn Shortcuts. Đổi tên lại sau khi test | P1 |
| TC-SH-OLD-05 | Spotlight: gõ "Ink" → chọn **Refresh Lock Screen** (TC-B05) | Wallpaper đổi, **không** mở app | P2 |
| TC-SH-OLD-06 | Lặp lại OLD-01/02 với template loại **Note** và template loại **lịch** (TC-B06) | Cả 2 loại template set được như OLD-01/02 | P2 |
| TC-SH-OLD-07 (DT-TOAST-01) | Đang ở **màn edit template**, bấm **Update**, chạy thành công (TC-B07) | Toast **"Lock screen updated"** hiện **ngay trên màn edit**, không đợi thoát ra Home; không có toast thứ 2 chồng | P2 |
| TC-SH-OLD-08 (DT-TOAST-02) | Đổi tên shortcut để app không tìm thấy → bấm Update ở màn edit (TC-B08) | Toast lỗi hiện **ngay trên màn edit** đang mở (không phải ở Home) | P2 |
| TC-SH-OLD-09 (DT-TOAST-03) | Đang mở 1 sheet/popup trên màn edit (vd sheet chọn Blur) khi shortcut chạy xong (TC-B09) | Toast hiện đè lên **cả sheet**, **không chặn thao tác** — vẫn bấm được nút bên dưới sheet trong lúc toast đang hiện | P2 |
| TC-SH-OLD-10 (DT-TOAST-04) | Làm lỗi xảy ra trong **luồng cài shortcut lần đầu** (vd Don't Allow ở dialog quyền) (TC-B10) | Chỉ **1** thông báo lỗi của màn cài đặt — **không được** có thêm toast lỗi thứ 2 chồng lên | P3 |

---

## 3 · Bốn chế độ Home Screen × Blur · `TC-SH-HS` (mục 5 test basis — kỹ thuật chính: State Transition 9 token, mục 5.1 test-plan)

> **State nguồn (mục 5.1):** `lock` · `same` · `same-blur` · `same-redraw` · `same-blur-redraw` · `pair` ·
> `pair-blur` · `pair-redraw` · `pair-blur-redraw`. Valid transitions coverage: mỗi state ≥1 case. Decision Table
> 1 (mục 5.2, 7 dòng `DT1-01…07`) dùng làm checklist nội dung lock/home của 5 trong 9 state (không có redraw).
> Đo bằng `Settings → Debug → Last shortcut run` + console `[InkShortcut] token=…` (đã verify công cụ đo ở
> `TC-SH-DBG-01` trước).

### Trình tự chạy gộp — DT1 7 dòng (`HS-01`) + Blur redraw (`HS-11`/`HS-12`)

**Chuẩn bị 1 lần:** xong nhóm `INS` (đúng tên, đã Always Allow) · chọn **1 template có lịch** dùng xuyên suốt,
không đổi giữa chừng · My photo đã **chọn sẵn 1 ảnh** từ trước (như `OWN-02`) để không rơi vào case "chưa chọn
ảnh" (đó là `OWN-08` riêng) · đếm **số cặp wallpaper hiện tại**, ghi làm baseline N (dùng chung cho `PAIR-04`).

1. Editor → tab **Background** → mục **Home Screen**.
2. **DT1-01:** chọn **Don't change** → Set as current (lần đầu) → khoá máy chụp Lock, mở khoá chụp Home → đếm
   cặp (kỳ vọng vẫn N) → console `token=lock`.
3. Quay lại editor → **Same as Lock, Blur tắt** → Update → chụp 2 màn → console `token=same`, 1 lần Set.
4. **Chỉ bấm toggle Blur** (không đổi mode) → Update → chụp 2 màn → console `token=same-blur-redraw`, **2 lần
   Set**, home mờ **ngay** (không cần bấm lần 2) → đây là `HS-11` lượt 1/2 nhánh Same.
5. Tắt Blur lại → Update → chụp 2 màn → console `token=same-redraw`, 2 lần Set, home nét **ngay** → `HS-12` lượt
   1/2 nhánh Same.
6. Chọn **No calendar, Blur tắt** → Update → chụp 2 màn → console `token=pair`, 2 lần Set → **DT1-04** (nhân
   tiện kéo Darken của lock lên cao nhất trước khi Set bước này → gộp `HS-07` vào đây).
7. Bật Blur → Update → chụp 2 màn → console `token=pair-blur-redraw`, 3 lần Set, home mờ ngay → **DT1-05** +
   `HS-11` lượt 2/2 nhánh No calendar.
8. Tắt Blur → Update → chụp 2 màn → console `token=pair-redraw`, 3 lần Set, home nét ngay → `HS-12` lượt 2/2
   nhánh No calendar.
9. Chọn **My photo** (ảnh đã chọn sẵn), Blur tắt → Update → chụp 2 màn → console `token=pair` → **DT1-06**.
10. Bật Blur → Update → chụp 2 màn → console `token=pair-blur` → **DT1-07** → đếm cặp lần cuối (kỳ vọng vẫn = N
    sau đủ 4 mode) — chốt luôn kết quả `PAIR-04`.

**Gộp thêm trong lúc chạy, không cần lượt riêng:** `HS-05` (Blur toggle không hiện ở bước 2, hiện từ bước 3 trở
đi) · `HS-25` (đếm số lần hỏi quyền mỗi bước, ghi vào bảng mục 11 spec chính).

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-HS-01 | Chạy đủ trình tự gộp 10 bước trên (TC-C01, DT1-01…07 + 4/9 token: `lock`/`same`/`same-blur`/`pair`/`pair-blur`) | Mỗi dòng đúng nội dung lock/home theo bảng mục 5.2 test-plan **và** đúng token console theo bảng mục 5.1 — sai bất kỳ dòng nào → dừng, không tin Decision Table 1 cho case sau | P1 |
| TC-SH-HS-02 | Mở editor, quan sát 4 chip (TC-C02) | Đủ 4 chip **Don't change / Same as Lock / No calendar / My photo**, mỗi chip có 1 dòng giải thích ngắn bên dưới đúng chế độ đang chọn | P3 |
| TC-SH-HS-03 | Tài khoản **free**, bấm chip **No calendar** rồi **My photo** (TC-C03) | Hiện **paywall**, chip **không** được chọn. Mua Pro xong → chọn được ngay không cần mở lại editor | P1 |
| TC-SH-HS-04 | Đang ở No calendar/My photo (đã chọn ảnh + Blur bật) → tài khoản **hết Pro** (downgrade) (TC-C04) | Chế độ **tự về Don't change**; ảnh đã chọn và trạng thái Blur **vẫn giữ** — mua lại Pro thì dùng tiếp đúng ảnh/blur cũ, không phải chọn lại | P1 |
| TC-SH-HS-05 | Đã quan sát gộp ở bước 2/3 trình tự trên (TC-C05) | Toggle **Blur behind app icons** **không hiện** khi mode = Don't change; **hiện** ở 3 mode còn lại | P2 |
| TC-SH-HS-06 | Trong lúc chạy trình tự gộp, mọi lần Blur bật (bước 4, 7, 10) — chụp riêng Lock screen (TC-C06) | **Lock screen luôn nét**, kể cả khi Blur bật (Blur chỉ áp dụng cho Home) | P1 |
| TC-SH-HS-07 | Đã gộp ở bước 6 trình tự trên — kéo Darken lock lên cao nhất trước khi Set No calendar (TC-C07) | Home **không bị tối** dù Darken của lock kéo cao — độc lập hoàn toàn | P2 |
| TC-SH-HS-08 | Đổi sang template có **nhiều ảnh nền đổi theo ngày**, chọn No calendar → Set (TC-C08) | Home dùng đúng ảnh nền của **hôm nay**, trùng ảnh hiện dưới lịch trên lock | P2 |
| TC-SH-HS-09 | Same as Lock và No calendar, máy nguội, nghỉ ~1 phút giữa 2 lần bấm, đo `Last shortcut run` (TC-C09) | Same as Lock nhanh hơn No calendar (khi No calendar phải ghi home) khoảng **3–4 giây** | P3 |
| TC-SH-HS-10 | Đổi mode trong editor → bấm **✕ (Cancel)** thoát → mở lại editor (TC-C10) | Mode **quay về đúng trạng thái trước khi mở** editor lần này (không giữ thay đổi chưa Set) | P2 |
| TC-SH-HS-11 | Bật Blur (Same as Lock **và** No calendar, mỗi nhánh 2 lượt — đã gộp bước 4/7 trình tự trên) (TC-C11) | Update **một lần** → home mờ **ngay**, không cần bấm lần 2 — nếu phải bấm lần 2 mới đổi → báo lỗi. Token console phải có hậu tố `-blur-redraw` đúng cả 2 nhánh | P1 |
| TC-SH-HS-12 | Tắt Blur (Same as Lock **và** No calendar, mỗi nhánh 2 lượt — đã gộp bước 5/8 trình tự trên) (TC-C12) | Update **một lần** → home nét **ngay**. Token console phải có hậu tố `-redraw` (không `-blur`) đúng cả 2 nhánh | P1 |
| TC-SH-HS-13 | Setup — No calendar, Update lần 1, ghi thời gian ở Debug → Last shortcut run (TC-C13, tiền đề cho HS-14) | Ghi nhận số liệu làm baseline, không có kỳ vọng pass/fail riêng | — |
| TC-SH-HS-14 | Tiếp HS-13 — không đổi gì, Update lần 2 (nghỉ ~1 phút) (TC-C14) | **Nhanh hơn rõ** (gần bằng Don't change), home vẫn đúng ảnh nền, lock có lịch mới, console `home=skip-unchanged`, token `lock` | P1 |
| TC-SH-HS-15 | Tiếp HS-14 — thêm/sửa 1 sự kiện lịch → Update (TC-C15) | Vẫn nhanh (skip-unchanged giữ), home vẫn đúng ảnh, lock có event mới | P2 |
| TC-SH-HS-16 | Tiếp HS-15 — đổi ảnh nền (ảnh khác/crop lại/đổi template) → Update (TC-C16) | Home **đổi theo ngay lần đó**, console `home=set`, token `pair`/`pair-blur` (không phải `lock`) | P1 |
| TC-SH-HS-17 | Crop lại **cùng một ảnh** (không đổi ảnh nguồn) → Update (TC-C17) | Home đổi theo **khung crop mới** — hash phải nhạy với crop, không chỉ nguồn ảnh, console `home=set` | P2 |
| TC-SH-HS-18 | Ở No calendar/My photo đã skip-unchanged (HS-14) → đổi Blur → Update (TC-C18) | Home đổi Blur **ngay**, console `home=set` (hoặc `-redraw`) — **không bị** skip-unchanged bỏ qua nhầm dù ảnh không đổi | P1 |
| TC-SH-HS-19 | No calendar → chuyển **Don't change** → tự đổi ảnh home qua iOS (Customize → Home Screen) → quay lại **No calendar** → Update (TC-C19) | Home **về ảnh nền template**, **không giữ** ảnh vừa tự chọn qua iOS | P2 |
| TC-SH-HS-20 | Template nhiều ảnh theo ngày, để automation (Sunrise) chạy sáng hôm sau, chưa quá 24h kể từ lần chạy tay gần nhất (TC-C20) | Home là ảnh của **hôm nay** (đổi theo ngày), dù chưa quá mốc 24h skip-unchanged | P1 |
| TC-SH-HS-21 | BVA 3-value mốc 24h skip-unchanged (TC-C20b): (a) để 23h59 không đổi gì → Update; (b) để đúng 24h00 → Update; (c) để 24h01 → Update | (a) vẫn skip-unchanged, console `home=skip-unchanged`; (b) ranh giới — ghi nhận thực tế skip hay set; (c) ghi home **đầy đủ 1 lần**, console `home=set`, chậm lại đúng 1 lần | P2 |
| TC-SH-HS-22 | Set template có **thẻ bán trong suốt** đè ảnh nền → soi kỹ lock screen mép thẻ/vùng chuyển màu (TC-C21) | Quan sát: không vệt màu/sọc/mảng loang rõ rệt (không ngưỡng khách quan, xem test-analysis mục 1 #6) — nếu nghi ngờ, đối chiếu `HS-24` | P2 (quan sát) |
| TC-SH-HS-23 | Soi chữ nhỏ trên lịch (giờ, tên sự kiện) trên lock screen vừa set (TC-C22) | Quan sát: không nhoè viền rõ rệt do nén HEIC | P2 (quan sát) |
| TC-SH-HS-24 | Khi nghi ngờ ở HS-22/23 — Debug → Wallpaper format → **PNG**, set lại cùng template, chụp cả 2 bản so sánh (TC-C23) | Không tự kết luận pass/fail — chỉ làm bằng chứng đính kèm khi báo bug từ HS-22/23 | — |
| TC-SH-HS-25 | 🔭 Trong lúc chạy trình tự gộp, đếm số lần hộp thoại quyền xuất hiện ở No calendar (TC-C24) | **Phải ghi lại**: có bị hỏi quyền 2 lần trong 1 lần chạy không (2 action Set trong 1 lần chạy)? Log vào mục 11 spec chính | 🔭 |
| TC-SH-HS-26 | 🔭 Ghi số giây thực đo Same as Lock / No calendar (máy nguội, nghỉ 1 phút), tách iOS 26 và iOS 27 (TC-C25) | **Phải ghi lại** số liệu vào mục 11 spec chính, không kết luận pass/fail | 🔭 |
| TC-SH-HS-27 | 🔭 Ghi lại template nào (nếu có) bị vệt màu/chữ nhoè ở HS-22/23 (TC-C26) | **Phải ghi lại** danh sách template lỗi (nếu có) vào mục 11 spec chính | 🔭 |
| TC-SH-HS-28 | 🆕 Bắt đầu 1 lần chạy Update (No calendar/My photo, ảnh sắp đổi) → **huỷ giữa chừng** (vuốt tắt app khi đang chạy, hoặc bấm Cancel nếu Shortcuts hỏi) trước khi tới bước Confirm → chạy **Update lại bình thường** ngay sau đó (nguồn: mục 11 test-plan-v3 "lần chạy dở dang không được làm lần sau bỏ qua nhầm bằng skip-unchanged", suy luận trực tiếp từ state diagram mục 5.1 — chưa có TC nào trong test-analysis) | Lần chạy sau (bình thường) **phải ghi home đầy đủ** (console `home=set`), **không được** bị skip-unchanged bỏ qua nhầm chỉ vì lần dở dang trước đó đã kịp ghi tạm ảnh/blur — vì app chỉ chốt "đã giao" sau Confirm. Priority tự gán **P1**: ảnh hưởng trực tiếp core mechanism skip-unchanged đã xếp P1 ở `HS-14`/`HS-16`/`HS-18` | 🆕, P1 |

---

## 4 · Ảnh home riêng · `TC-SH-OWN` (mục 6 test basis)

> `OWN-02`…`OWN-08` chạy **liên tiếp trong cùng 1 phiên**, không tách rời (test-plan mục 5.3: "test theo đúng
> trình tự TC-D04→D07 liên tiếp"). Case `OWN-02` gộp 2 partition EP ("vừa chọn mới từ Photos" + "đã tải lên
> trước đó") vì test-plan gán chung 1 TC nguồn.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-OWN-01 | Chọn chip **My photo** (chưa chọn ảnh nào) → quan sát hàng ảnh (TC-D01) | Hiện ô **+** (mở Photos), hàng ảnh đã upload trước đó, hàng ảnh catalog | P3 |
| TC-SH-OWN-02 | (a) Bấm **+** → chọn 1 ảnh mới từ Photos → Update; (b) chọn lại 1 ảnh **đã tải lên trước đó** trong hàng ảnh → Update (TC-D02, 2 sub-partition EP) | (a) Home là đúng ảnh vừa chọn, lock vẫn có lịch; (b) Home đổi đúng theo ảnh đã tải lên được chọn lại, lock vẫn có lịch | P1 |
| TC-SH-OWN-03 | Chọn 1 ảnh **catalog** (có vòng xoay tải về) → Update (TC-D03) | Vòng xoay tải xong → home đúng ảnh catalog đó | P2 |
| TC-SH-OWN-04 | Tiếp OWN-02 — không đổi gì, Update lần 2 (TC-D04) | **Nhanh** (skip-unchanged), home giữ nguyên ảnh, console `home=skip-unchanged` | P1 |
| TC-SH-OWN-05 | Tiếp OWN-04 — đổi sang ảnh khác → Update (TC-D05) | Home **đổi theo ngay** lần đó, console `home=set` | P1 |
| TC-SH-OWN-06 | Tiếp OWN-05 — đổi sang **template khác**, giữ mode My photo → Update (TC-D06) | Home **vẫn là ảnh riêng** đã chọn (không theo ảnh nền của template mới) | P2 |
| TC-SH-OWN-07 | Tiếp OWN-06 — chuyển sang **No calendar** rồi quay lại **My photo** (không Update ở bước trung gian) (TC-D07) | Ảnh đã chọn ở OWN-06 **vẫn còn được chọn sẵn** khi quay lại My photo, không phải chọn lại | P2 |
| TC-SH-OWN-08 | My photo nhưng **chưa chọn ảnh nào** (chip mới, chưa từng chọn) → Update (TC-D08) | Home dùng **ảnh nền của lock** (không lịch) — **không bao giờ** để home trống/đen | P1 |
| TC-SH-OWN-09 | Sau OWN-02(a), mở hàng ảnh nền của **lock** phía trên editor (TC-D09) | Ảnh vừa chọn từ Photos cũng **xuất hiện** ở hàng ảnh nền của lock | P3 |
| TC-SH-OWN-10 | Setup — màn khoá đang ở cặp Ink → giữ tay → **Customize → Home Screen** → chọn 1 ảnh trong Photos → Done (TC-D10, tiền đề OWN-11) | Ảnh home của cặp Ink đổi thành ảnh vừa chọn qua iOS (ngoài Ink) | — |
| TC-SH-OWN-11 | Tiếp OWN-10 — về Ink, mode **Don't change**, bấm **Update** (TC-D11) | Lock đổi lịch mới, home **vẫn là ảnh vừa chọn qua iOS** ở OWN-10 — core promise của Don't change | P1 |
| TC-SH-OWN-12 | Tiếp OWN-11 — chạy thêm 2 lần Update (kể cả để automation sáng hôm sau chạy) (TC-D12) | Home **vẫn giữ nguyên** ảnh đã chỉnh qua iOS ở cả 2 lần chạy tiếp theo | P1 |
| TC-SH-OWN-13 | Tiếp OWN-12 — chuyển sang **Same as Lock** hoặc **No calendar** hoặc **My photo** rồi Update (TC-D13) | Home **bị thay** theo đúng mode mới chọn — xác nhận đây **không phải bug**, đúng ranh giới ngược của OWN-11/12 (Don't change không có tác dụng khi user tự đổi mode) | P2 |

---

## 5 · Cặp wallpaper · `TC-SH-PAIR` (mục 7 test basis — BVA 2-value, kế thừa cơ chế từ `test-cases-ios26-27.md`)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-PAIR-01 | Xoá 1 cặp wallpaper **khác** (không phải cặp Ink) → chạy shortcut (TC-E01) | Shortcut vẫn ghi đúng **cặp của Ink**, số hiển thị tự đổi đúng (vd 6→5). Ghi chú (không phải 1 trong 3 gap mở mục 10, không đánh dấu ⚠️): test basis đánh dấu "đã xác nhận, không cần test lại" nhưng không ghi rõ build/ngày (test-analysis mục 1 #3) — verify lại như case P1 bình thường cho build này, không coi kết luận cũ là đủ căn cứ | P1 |
| TC-SH-PAIR-02 | Chuyển màn khoá sang 1 cặp **ảnh riêng** của người test, đếm số cặp N → cài shortcut mới → bấm **Set** (TC-E02) | Màn khoá **chuyển sang cặp mới**, hiện lịch. Số cặp **tăng đúng 1** (N+1). Chuyển lại cặp ảnh riêng: ảnh **vẫn nguyên**, không bị thay bằng lịch | P1 |
| TC-SH-PAIR-03 (BVA 2-value) | Bấm **Update 3 lần liên tiếp**, không đổi gì khác, đếm số cặp trước/sau (TC-E03) | Số cặp **không đổi** (+0) sau cả 3 lần | P1 |
| TC-SH-PAIR-04 (BVA 2-value, gộp cùng `HS-01`) | Chạy đủ 4 mode: Don't change → Same as Lock → No calendar → My photo, đếm cặp sau **mỗi** lần (TC-E04) | Số cặp **không tăng** (+0) qua cả 4 mode — mode nào tạo thêm cặp mới → báo ngay, lỗi chặn phát hành | P1 |
| TC-SH-PAIR-05 | Tự chuyển màn khoá sang 1 cặp **khác** → bấm **Update** (TC-E05) | Màn khoá **tự quay về cặp của Ink** (không cần chuyển tay lại), lịch là bản mới nhất | P1 |
| TC-SH-PAIR-06 | Xoá **chính** cặp của Ink (giữ tay màn khoá → vuốt lên → thùng rác) → bấm **Update** → chạy thêm 2 lần nữa (TC-E06) | iOS tạo cặp mới **và chuyển sang cặp đó ngay**, **không** báo "Unable to switch". 2 lần chạy tiếp theo: số cặp **không tăng thêm** | P1 |
| TC-SH-PAIR-07 | Tổng hợp từ PAIR-01…06 — xác nhận Ink không bao giờ ghi đè cặp user, chỉ chuyển màn khoá khỏi đó (TC-E07) | Đối chiếu lại toàn bộ ảnh chụp PAIR-01…06: không lần nào nội dung cặp riêng của user bị sửa, chỉ có Lock screen (đang hiển thị cặp nào) bị chuyển | P1 |

---

## 6 · Cửa sổ "Update your shortcut" · `TC-SH-GATE` (mục 8 test basis — Decision Table 3, copy nguyên 6 rule)

> Máy đang dùng **shortcut cũ (V1)** cho toàn bộ nhóm này (chuẩn bị theo mục 7 test-plan, môi trường riêng cho
> `MIG`, dùng chung máy "người dùng cũ"). 6 case dưới khớp đúng 6 cột Decision Table 3 (mục 5.5 test-plan) —
> không thêm/bớt rule.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-GATE-01 (rule GATE-01) | Máy dùng shortcut cũ, chọn mode **khác Don't change** (vd Same as Lock) → bấm **Update** (TC-F01) | Cửa sổ **"Update your shortcut"** hiện, shortcut **chưa chạy** (chưa bấm gì tiếp) | P1 |
| TC-SH-GATE-02 (rule GATE-02) | Tiếp GATE-01 — bấm **"Just update my Lock Screen"** → bấm Update lần nữa (TC-F02) | Shortcut cũ chạy như trước: lock đổi, home **không** theo mode đã chọn. Update lần nữa → cửa sổ **hiện lại** | P1 |
| TC-SH-GATE-03 (rule GATE-03) | Tiếp GATE-01 (lượt mới) — bấm **"Get the new shortcut"** (TC-F03) | Mở đúng luồng update `TC-SH-MIG` (mục 13.2), không phải luồng cài lần đầu | P1 |
| TC-SH-GATE-04 (rule GATE-04) | Tiếp GATE-01 (lượt mới) — **vuốt đóng** cửa sổ → bấm Update lần nữa (TC-F05) | Vuốt đóng: không có gì chạy. Update lần nữa → cửa sổ **hiện lại** | P2 |
| TC-SH-GATE-05 (rule GATE-05) | ⚠️ Máy dùng shortcut cũ, chọn mode **Don't change** → bấm **Update** (TC-F04) | Test basis mô tả: **không** hiện cửa sổ, shortcut cũ chạy bình thường (home bị ghi đè bằng ảnh lịch, **không cảnh báo**). Verify đúng hành vi thật này trước — **không tự kết luận pass/fail** cho tới khi có câu trả lời gap #2 (mục 10 test-plan): là chủ ý chấp nhận được, hay gap UX thật vì "Don't change" lại là mode duy nhất không được cảnh báo dù kỳ vọng bị vi phạm rõ nhất | Chờ xác nhận Q2 |
| TC-SH-GATE-06 (rule GATE-06) | Sau khi hoàn tất `TC-SH-MIG` (đã chuyển hẳn V2) — thử **cả 4 mode**, mỗi mode bấm Update (TC-F06) | Mọi mode chạy **thẳng V2** theo đúng chế độ, **không** hiện cửa sổ Update your shortcut nữa — xác nhận migration hoàn tất | P1 |

---

## 7 · Chuyển từ shortcut cũ sang V2 · `TC-SH-MIG` (mục 13 test basis — State Transition hoàn toàn mới, mục 5.6 test-plan)

> **States (mục 5.6):** `S0` chưa bắt đầu → `S1` Add + chạy thử OK → `S2` xoá/bỏ qua xoá shortcut cũ → `S3`
> automation tạo lại/bật → `S4` hoàn tất (GATE-06). Sub-state "shortcut cũ vẫn còn chạy" (13.3) khi bỏ qua xoá.
> Theo §4.2.4: `MIG-11` là transition không hợp lệ DUY NHẤT được test riêng, không gộp thêm lỗi khác vào cùng
> case. Máy "người dùng cũ" riêng (mục 7 test-plan) — không dùng chung môi trường với `HS`/`OWN`/`PAIR`.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-MIG-01 | Mở app **lần đầu tiên** sau khi cập nhật lên bản mới (TC-J01) | **Không** hiện lời mời chuyển — không bao giờ hiện ở lần mở đầu tiên | P2 |
| TC-SH-MIG-02 | Mở app lần sau (TC-J02) | Hiện sheet mời chuyển đúng nội dung theo iOS: **iOS 26** "A better way to update your lock screen"; **iOS 27** "Ink is ready for iOS 27". Nút chính **"Get the new shortcut"** mở luồng update (`S0`→`S1`). Chữ mô tả dưới: "Takes about a minute. No rush, your lock screen keeps updating as usual." | P1 |
| TC-SH-MIG-03 (BVA 3-value trục ngày) | Đóng sheet lần 1 → chờ 2 ngày (kiểm tra chưa hiện lại) → chờ đủ **3 ngày** (kiểm tra hiện lại) → đóng lần 2 → chờ 4 ngày (không còn ý nghĩa test thêm, chỉ xác nhận vẫn hiện đúng chu kỳ) (TC-J03) | 2 ngày: chưa hiện lại. Đúng 3 ngày: hiện lại (ranh giới). 4 ngày: đã hiện ở mốc 3 ngày, không cần test thêm | P2 |
| TC-SH-MIG-04 | Tab **Guide** → thẻ lớn "See what's new" → mở bài **"Ink's new shortcut"** (TC-J04) | Ảnh đầu bài đúng theo iOS 26/27 (khác nhau). Mục **"What you get"**: iOS 27 có thêm dòng "Updates itself every morning". Mục **"How to switch"** 3 bước. Nút **"Get the new shortcut"** | P1 |
| TC-SH-MIG-05 | Máy **chưa có shortcut nào** (cài mới hoàn toàn, không phải máy "người dùng cũ") → mở thẻ "Ink's new shortcut" (TC-J05) | Thẻ vẫn hiện; bài viết có **"How to set it up"** chỉ **2 bước** (không có bước xoá shortcut cũ, vì không có gì để xoá), nút mở luồng **setup lần đầu** (không phải luồng update) | P2 |
| TC-SH-MIG-06 | Máy dùng shortcut cũ, chọn mode khác Don't change → bấm Update (TC-J06) | Cửa sổ "Update your shortcut" hiện — liên kết trực tiếp `TC-SH-GATE-01` | P1 |
| TC-SH-MIG-07 | Mở luồng update lần lượt từ **7 entry point**: (1) lời mời `MIG-02`, (2) thẻ Guide `MIG-04`, (3) cửa sổ GATE `GATE-03`, (4) Settings, (5) banner Home, (6) ⓘ trong editor, (7) trang "How updates work" (TC-J07) | Cả 7 entry point đều vào **đúng luồng update** (`S0`→`S1`, 3 bước), **không phải** luồng cài lần đầu — vì user đã có shortcut cũ | P1 |
| TC-SH-MIG-08 (`S0`→`S1`) | **Bước 1**: Add shortcut → Shortcuts mở link V2 → **Add Shortcut** (TC-J08) | Thư viện có **cả 2** shortcut (cũ + V2 tên đúng `Ink Refresh Lock Screen V2`), **không** có prompt Replace | P1 |
| TC-SH-MIG-09 (`S0`→`S1`, tiếp) | App tự chạy thử V2 để xác nhận (TC-J09) | Về app, **bước 1 đánh dấu xong** (dấu ✓) — chỉ khi lần chạy thử thật sự gọi shortcut V2 (không phải V1) | P1 |
| TC-SH-MIG-10 (`S1`, resume) | Bỏ dở sau bước 1 (đã xong), thoát hẳn app, mở lại từ thẻ Guide (TC-J14) | Vẫn ở `S1`: bước 1 hiện **đã xong** (dấu ✓), nút chính mở luồng update **tiếp tục từ bước 2** (không bắt làm lại bước 1) | P2 |
| TC-SH-MIG-11 | ⚠️ Transition không hợp lệ (giữ `S0`/`S1`, DUY NHẤT trong case này, không gộp lỗi khác) — lần chạy thử ở bước 1 **lại gọi shortcut cũ** (giả lập: chưa Add Shortcut xong, hoặc chọn nhầm shortcut khi Shortcuts hỏi) (TC-J10) | Bước 1 **không được tính là xong** (không có dấu ✓) — đúng như spec. Quan sát thêm và **ghi lại như phát hiện mới**: app có báo lỗi không, có hướng dẫn thử lại không, có giới hạn số lần thử không — spec không mô tả (test-analysis mục 1 #5), **không tự coi im lặng là đúng thiết kế**, cũng **không tự coi là bug** nếu chưa có kỳ vọng rõ để so sánh | Chờ xác nhận Q3 |
| TC-SH-MIG-12 (`S1`→`S2`) | **Bước 2**: theo đúng hướng dẫn (nêu đúng tên shortcut cũ) → xoá shortcut cũ trong app Shortcuts → về app (TC-J11) | Chuyển sang bước 3 (`S2`); hướng dẫn phải nêu **đúng tên** shortcut cũ `Ink Refresh Lock Screen` | P1 |
| TC-SH-MIG-13 (`S1`→`S2`, đường thay thế) | Ở bước 2, bấm nút **"bỏ qua"** thay vì xoá (TC-J11, đường thay thế) | Chuyển sang bước 3 (`S2`) luôn, không bắt buộc xoá shortcut cũ | P1 |
| TC-SH-MIG-14 (`S2`→`S3`) | **Bước 3** — trên máy iOS 26 và máy iOS 27 riêng biệt (TC-J12) | **iOS 26**: hướng dẫn **tạo lại automation** cho V2 (vì xoá shortcut cũ làm mất automation cũ theo). **iOS 27**: hướng dẫn **bật "At sunrise, daily"** có sẵn trong V2 | P1 |
| TC-SH-MIG-15 (`S3`→`S4`) | Xong luồng 3 bước → bấm **Update** với **Same as Lock** rồi lặp lại với **No calendar** (TC-J13) | Chạy thẳng **V2**, home theo đúng mode đã chọn — xác nhận migration hoàn tất, khớp `GATE-06` | P1 |
| TC-SH-MIG-16 | 🆕 BVA trên **trục số lần** (nguồn: mục 5.10 + mục 11 test-plan-v3 "chưa có test condition tường minh cho biên trên") — đóng sheet mời lần 1 → đợi đủ 3 ngày → sheet hiện lại (lần 2) → đóng → đợi đủ 3 ngày → hiện lại (lần 3) → đóng → đợi đủ 3 ngày nữa | Sau lần đóng thứ **3** (đã đạt trần "tối đa 3 lần"), sheet **KHÔNG hiện lại nữa** dù đã đủ 3 ngày kể từ lần đóng thứ 3 — verify không còn cách nào khác vào lại lời mời (ngoài thẻ Guide "See what's new" vẫn còn) | 🆕, P2 |
| TC-SH-MIG-17 (sub-state) | Bỏ qua bước xoá ở `MIG-13`, giữ automation cũ → sáng hôm sau (hoặc chạy tay shortcut cũ trong app Shortcuts) → mở Ink (TC-J15) | Hiện sheet **"Two Ink shortcuts are running"**, hướng dẫn giữ tay shortcut cũ → Delete, nút **"Open Shortcuts"** mở app Shortcuts | P1 |
| TC-SH-MIG-18 | Lần chạy của shortcut cũ ở MIG-17 (TC-J16) | Vẫn **đặt được wallpaper** bình thường, **không** hiện toast lỗi | P2 |
| TC-SH-MIG-19 | Sau khi sheet MIG-17 đã hiện — quan sát thẻ Guide (TC-J17) | Thẻ đổi tiêu đề thành **"Two Ink shortcuts are running"**, nút chính **"Open Shortcuts"** | P2 |
| TC-SH-MIG-20 (sub-state → `S2`→`S3`→`S4`) | Sau khi sheet MIG-17 đã hiện — xoá shortcut cũ → mở lại Ink (TC-J18) | Thẻ Guide **biến mất** (không còn lần chạy cũ nào sau lúc nhắc); nếu đang mở bài viết "Two Ink shortcuts" thì bài viết **tự đóng** khi quay lại app | P2 |
| TC-SH-MIG-21 (BVA 3-value trục ngày, sub-state) | **Không** xoá shortcut cũ → để chạy tiếp → nhắc lại theo mốc: 6 ngày không có lần chạy cũ nào (vẫn còn nhắc) / đúng **7 ngày** (ranh giới) / 8 ngày (đã tự hết) (TC-J19) | 6 ngày: nhắc vẫn còn active. Đúng 7 ngày không có lần chạy cũ nào: verify hành vi ranh giới. 8 ngày: nhắc **và** thẻ Guide **tự hết** hẳn | P2 |
| TC-SH-MIG-22 | Settings → Debug → **In-app messages** (TC-J20) | Dòng `old still running` đúng với thực tế hiện tại. Nút **Show iOS ≤26 / Show iOS 27 / Show remove old shortcut** xem trước đúng từng sheet. **Reset show history** cho hiện lại từ đầu | P3 |
| TC-SH-MIG-23 | 🔭 Sau khi hoàn tất `MIG-15` (đã chuyển xong V2 hoàn toàn), theo dõi thẻ "Ink's new shortcut" trong Guide qua vài lần mở app (TC-J21) | **Phải quan sát/ghi lại**: thẻ có tự biến mất khi đã chuyển xong hoàn toàn không? Spec không nêu rõ vòng đời thẻ này (khác thẻ "Two Ink shortcuts" đã rõ ở `MIG-20`). Log vào mục 11 spec chính | 🔭 |

---

## 8 · Automation iOS 27 · `TC-SH-AUTO` (mục 9 test basis + toàn bộ `triggers-ios27.md` + `notification-automation-ios27.md`)

> Nhóm lớn nhất (80 test condition nguồn). Chỉ test được trên **iOS 27**. Entry criteria riêng: **`AUTO-06`
> (máy sạch) phải chạy trước mọi case khác của nhóm này** — nếu bỏ qua, baseline không đáng tin (mục 8
> test-plan). Kỹ thuật: Decision Table 4 (5 automation, mục 5.8) · State Transition "app closed" (3 transition,
> mục 5.7, §4.2.4 — mỗi transition chưa rõ ràng viết case riêng, không gộp) · EP+BVA bộ lọc notification + trạng
> thái máy (mục 5.9) · Exploratory (mục 5.11) · Error guessing BUG-004/TC-G22 (mục 5.12).

### 8.1 — App setup UX (mục 9 spec chính, TC-G01–G05)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-AUTO-01 | Luồng setup trên iOS 27, tới bước automation (TC-G01) | Có **video** hướng dẫn (giọng Anh, dùng chung mọi ngôn ngữ) gạt **"At sunrise, daily"** rồi **"When I get a notification from Ink"**; tiêu đề đúng "Turn on the shortcut's automations."; sau video có **2 ảnh**, mỗi ảnh khoanh đúng 1 công tắc | P2 |
| TC-SH-AUTO-02 | Bấm **"Open Automations"** lần đầu (chưa từng trả lời quyền thông báo) (TC-G02) | iOS hỏi quyền thông báo **ngay trong Ink** → chọn gì cũng mở tab Automation của Shortcuts. Chọn **Allow** → rời Ink, Ink bắt đầu tự gửi thông báo (không cần vào Guide bấm thêm) | P1 |
| TC-SH-AUTO-03 | Ở dialog quyền thông báo tại AUTO-02, chọn **Don't Allow** (TC-G03) | Vẫn vào được tab Automation, bật **Sunrise** bình thường. Ink **không** gửi thông báo nào | P2 |
| TC-SH-AUTO-04 | ⚠️ Guide trên iOS 27, mục automation (TC-G04) | Các mục theo thứ tự **daily → notification → đóng Ink → đóng app lịch**, mỗi mục có ảnh chụp đúng dòng cần bật. Đối chiếu thứ tự này với thứ tự **thật** của tab Automation quan sát trực tiếp trên máy (không phụ thuộc tài liệu nào đúng — 2 tài liệu nguồn mâu thuẫn nhau, xem gap #1 mục 10 test-plan). Ghi lại thứ tự thật quan sát được, không cần chờ câu trả lời trước khi thực hiện case | Chờ xác nhận gap #1 |
| TC-SH-AUTO-05 | Guide trên **iOS 26** (TC-G05) | **Không** có mục notification; các mục automation vẫn hướng dẫn **tự tạo** automation như bản cũ | P2 |

### 8.2 — Baseline & Decision Table 4 (5 automation, mục 5.8, `triggers-ios27.md`)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-AUTO-06 | 🔴 **Chạy trước mọi case AUTO khác** — xoá mọi shortcut Ink cũ, xác nhận tab Automation không còn dòng nào của Ink (TC-G06) | Máy sạch xác nhận — nếu bỏ qua, cài đè bằng Replace có thể để automation cũ chạy song song, làm kết quả không đáng tin. Entry criteria riêng nhóm `AUTO` | P1 |
| TC-SH-AUTO-07 | Sau khi cài shortcut V2 mới (đúng theo AUTO-06) (TC-G07) | Cả **5 automation** đúng trạng thái **tắt** | P1 |
| TC-SH-AUTO-08 | 🔭 Bật đủ 4 dòng automation (trừ notification, test riêng ở AUTO-38…44) trực tiếp từ danh sách tab Automation (TC-G08) | **Phải ghi lại**: bật được trực tiếp từ list, hay phải vào Edit trước? Log vào mục 8 `triggers-ios27.md` | 🔭 |
| TC-SH-AUTO-09 | 🔭 Mở từng automation, xem mặc định **Run Immediately** hay **Run After Confirmation** (TC-G09) | **Phải ghi lại** mặc định của từng automation, sau đó chọn **Run Immediately** để tiếp tục test các case sau | 🔭 |
| TC-SH-AUTO-10 (DT-AUTO-01) | 🔭 Lần đầu bật/chạy Sunrise (TC-G10) | **Phải ghi lại**: iOS có xin quyền **vị trí** không? | 🔭 |
| TC-SH-AUTO-11 (DT-AUTO-01) | Tạo sự kiện `QC sunrise` cho ngày mai → khoá máy qua đêm → sáng hôm sau **chưa mở khoá** (TC-G11) | Màn khoá đã có `QC sunrise` đúng ngày mới, **không** hỏi xác nhận, **không** hiện "running your automation" | P1 |
| TC-SH-AUTO-12 | Sau khi Sunrise chạy (AUTO-11), mở Ink (TC-G12) | **Không** có cảnh báo kiểu "automation không chạy" ở Home/Settings | P2 |

### 8.3 — "App đã closed" (State Transition, mục 5.7, 3 transition riêng biệt)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-AUTO-13 (DT-AUTO-03, transition Foreground→Background/Home) | Thêm sự kiện mới trong **Lịch** → về Home (vuốt lên, không mở Ink) (TC-G13) | Automation "When Calendar is closed" chạy **trong vài giây**, wallpaper cập nhật | P1 |
| TC-SH-AUTO-14 (transition Foreground→Background/App Switcher, boundary chưa rõ) | Thêm sự kiện trong Lịch → chỉ **chuyển sang app khác** qua App Switcher, **không** về Home (TC-G14) | Verify thực tế, **ghi lại** kết quả quan sát được (Có/Không trigger) — spec tự để ngỏ, không giả định trước | P2 |
| TC-SH-AUTO-15 (transition →Terminated, boundary chưa rõ) | Thêm sự kiện trong Lịch → **vuốt tắt hẳn** Lịch trong App Switcher (TC-G15) | Verify thực tế, **ghi lại** kết quả quan sát được (Có/Không trigger) | P2 |
| TC-SH-AUTO-16 | Mở Lịch rồi thoát ngay, **không sửa gì** (TC-G16) | Automation vẫn chạy (đúng thiết kế, chỉ ghi nhận). Đo mất bao lâu, có làm máy khựng không | P3 |
| TC-SH-AUTO-17 (DT-AUTO-04, = regression BUG-004 trigger #2) | Lặp lại AUTO-13 với app **Google Calendar** (tài khoản đã kết nối Ink) — tạo event trực tiếp trên Google Calendar (TC-G17) | Automation "When Google Calendar is closed" chạy trong vài giây, wallpaper cập nhật đúng event mới — đây là regression [BUG-004](../../../bugs/bug-log.md#bug-004--event-tạo-trên-google-calendar-không-xuất-hiện-trên-wallpaper-hôm-sau) trên trigger thứ 2, ghi ngày/build khi test, **không** coi "Need info" cũ là đã đóng | P1 |
| TC-SH-AUTO-18 | Máy **không cài** Google Calendar → quan sát dòng automation "When Google Calendar is closed" (TC-G18) | Ghi lại: dòng automation hiện ra sao, có báo lỗi không (robustness, không có kỳ vọng "đúng" sẵn) | P2 |

### 8.4 — When Ink is closed (mục 5.8 DT-AUTO-02) + kiểm tra chung sau mỗi lần chạy

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-AUTO-19 | Đổi template/mode Home Screen trong Ink → rời Ink **mà không bấm Set/Update** (TC-G19) | Ghi lại: màn khoá có tự cập nhật theo lựa chọn mới không (nếu có, nghĩa là chỉ đổi setting rồi thoát cũng đủ trigger set — rủi ro set nhầm chỉ vì xem thử) | P1 |
| TC-SH-AUTO-20 | Rời Ink **ngay sau** khi bấm Update (TC-G20) | Ghi lại: shortcut có chạy **2 lần liên tiếp** không (1 do Update, 1 do automation Ink closed)? Có toast lỗi do đè nhau không? | P1 |
| TC-SH-AUTO-21 | Sau khi shortcut chạy xong (do Ink closed trigger), theo dõi có tự kích hoạt lại không (TC-G21) | **Không** bị vòng lặp — shortcut chạy xong (đóng Ink) không tự làm Ink "closed" thêm 1 lần nữa. Nếu phát hiện vòng lặp → **Suspend toàn cụm AUTO ngay** (mục 8.1 test-plan), không thử lại nhiều lần | P1 |
| TC-SH-AUTO-22 | 🔴 Regression bắt buộc (error guessing từ bug thật, mục 5.12) — sau mỗi lần automation chạy (AUTO-11/13/17/19-21), kiểm Lock/Home (TC-G22) | Lock phải có **lịch**, Home chỉ có **ảnh nền** (mode ≠ Don't change). Nếu 2 màn **đổi chỗ** (đã có báo cáo thật lúc 00:05) → ghi lại mode, blur, máy khoá/mở lúc đó, và thử tái hiện bằng thao tác tay. Nếu tái hiện được → **Suspend toàn cụm AUTO**, báo ngay (không cần lặp lại nhiều lần để xác nhận thêm) | P1 |
| TC-SH-AUTO-23 | Sau mỗi lần automation chạy (TC-G23) | Màn khoá vẫn đang dùng đúng **cặp wallpaper của Ink** (Switch chạy đúng) | P1 |
| TC-SH-AUTO-24 | Settings → Debug: Last shortcut run + In-app messages (TC-G24) | "Last shortcut run" có số liệu mới. Thẻ In-app messages có dòng `Runs Ink Refresh Lock Screen V2 · old still running false` — nếu `true`, một automation vẫn đang gọi shortcut cũ chồng lên (dùng làm bằng chứng chẩn đoán cho `AUTO-20`/`AUTO-22`) | P1 |

### 8.5 — Trường hợp biên (mục 6 `triggers-ios27.md`, TC-G25–G30)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-AUTO-25 | App tự cài shortcut qua luồng update trong app (không qua Replace) (TC-G25) | Không bao giờ để 2 dòng automation trùng nhau trong tab Automation | P1 |
| TC-SH-AUTO-26 | Cài lại **cùng link bằng Replace** (kịch bản KHÔNG nên xảy ra qua app, chỉ test để hiểu hậu quả) (TC-G26) | Ghi lại: tab Automation có bị trùng dòng không, dòng cũ còn bật không — điều tra hậu quả, không phải case cần "pass" | P2 |
| TC-SH-AUTO-27 | Xoá shortcut V2 (TC-G27) | Cả **5** dòng automation biến mất theo | P2 |
| TC-SH-AUTO-28 | 🔭 Máy thứ 2, Apple Account khác → cài link V2 (TC-G28) | **Phải ghi lại**: automation có về máy không, bật hay tắt theo mặc định | 🔭 |
| TC-SH-AUTO-29 | Bật Low Power Mode hoặc để máy nóng → chờ Sunrise tới giờ (TC-G29) | Ghi lại: automation Sunrise có bị iOS tự bỏ qua không (robustness edge OS) | P3 |
| TC-SH-AUTO-30 | Canh Sunrise và mở Lịch xảy ra **cùng lúc** (2 trigger gần nhau) (TC-G30) | Ghi lại có lỗi chồng chéo gì không — đối chiếu `AUTO-24` (`old still running`) | P2 |

### 8.6 — Automation qua Notification: Passive + Remove after run (`notification-automation-ios27.md` §4.1–4.2, TC-G31–G37)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-AUTO-31 (EP: máy khoá ngay) | Debug → Test notification automation, giữ mặc định (Passive bật), Delay 15s → bấm Send rồi **khoá máy ngay** (TC-G31) | Kịch bản quan trọng nhất — trigger vẫn chạy, wallpaper đổi dù máy khoá ngay sau khi gửi | P1 |
| TC-SH-AUTO-32 (EP: máy khoá lâu) | Delay **60s**, khoá máy, để yên (TC-G32) | Vẫn chạy đúng sau khi hết delay | P1 |
| TC-SH-AUTO-33 (EP: máy mở ngoài Ink) | Delay 15s, gửi rồi về Home (không mở Ink) (TC-G33) | Vẫn chạy đúng | P2 |
| TC-SH-AUTO-34 | So sánh — tắt **Passive**, gửi lại y hệt AUTO-31 (TC-G34) | Xác nhận có banner/âm thanh (khác AUTO-31) — chứng minh khác biệt thực sự do cờ Passive gây ra | P2 |
| TC-SH-AUTO-35 (EP: đang mở Ink) | Gửi thông báo trong khi đang **mở Ink** (TC-G35) | **Không** hiện banner, chỉ nằm trong danh sách Notification Center | P3 |
| TC-SH-AUTO-36 | Bật **Remove after the run** (Passive bật), Delay 15s, khoá máy → chờ wallpaper đổi → mở Notification Center (TC-G36) | Thông báo **không còn** trong Notification Center | P2 |
| TC-SH-AUTO-37 (negative) | Bật Remove nhưng **tắt** "Allow Running When Locked" (khiến lần chạy hỏng) → gửi và khoá máy (TC-G37) | Thông báo **vẫn còn lại** trong Notification Center — chỉ xoá khi shortcut chạy tới cuối (Confirm), không xoá nhầm khi lỗi | P2 |

### 8.7 — Bộ lọc Title/Body (EP + BVA, mục 5.9, TC-G38–G40)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-AUTO-38 (EP negative) | Title **không có** `·` (vd `Wednesday`), Body giữ mặc định → gửi (TC-G38) | **Không** được chạy | P1 |
| TC-SH-AUTO-39 (EP negative) | Body **không có** `Ink`, Title giữ mặc định → gửi (TC-G39) | **Không** được chạy | P1 |
| TC-SH-AUTO-40 (BVA hoa/thường) | Body có `ink` viết thường thay vì `Ink` → gửi (TC-G40) | Kết quả sơ bộ simulator: **không** chạy (bộ lọc phân biệt hoa/thường) — **verify lại trên máy thật**, không copy kết luận simulator làm kết luận cuối (test-analysis mục 1 #7) | P2 |

### 8.8 — Khi user đổi cài đặt thông báo (Exploratory, mục 5.9/5.11, TC-G41–G44)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-AUTO-41 | 🔭 Tắt hẳn thông báo Ink trong Settings hệ thống → gửi lại (Debug) (TC-G41) | **Phải ghi lại**: trigger có chạy không | 🔭 |
| TC-SH-AUTO-42 | 🔭 Tắt "Show on Lock Screen", giữ Notification Center → gửi khi máy khoá (TC-G42) | **Phải ghi lại**: có chạy không | 🔭 |
| TC-SH-AUTO-43 | 🔭 Bật Scheduled Summary cho Ink → gửi lại (TC-G43) | **Phải ghi lại**: chạy ngay hay đợi tới giờ tóm tắt | 🔭 |
| TC-SH-AUTO-44 | 🔭 Bật 1 Focus chặn Ink → gửi lại (TC-G44) | **Phải ghi lại**: có chạy không | 🔭 |

### 8.9 — Thông báo thật, không qua Debug (mục 4.5 `notification-automation-ios27.md`, TC-G45–G51)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-AUTO-45 (negative boundary) | Máy chưa từng bấm nút bật notification trong Guide/setup (vd setup từ bản cũ) — dù đã cho phép thông báo hệ thống (TC-G45) | Ink **không** tự gửi gì | P1 |
| TC-SH-AUTO-46 (recovery path) | Đã từ chối quyền thông báo trước đó → bấm nút trong Guide → app mở **Settings của Ink** (iOS không hỏi lần 2) → bật **Notifications** ở đó → rời Ink lần sau (TC-G46) | Ink bắt đầu gửi thông báo mà **không cần bấm lại nút** trong Guide | P1 |
| TC-SH-AUTO-47 (core) | Sửa (thêm/sửa/xoá) 1 sự kiện hôm nay **trong Ink** → về Home (TC-G47) | Sau ~2 giây có thông báo đúng nội dung (kiểu `Schedule updated · 4 events` / `Next up at 15:00. Ink refreshed your lock screen.`) → wallpaper đổi → thông báo **tự biến mất** khỏi Notification Center | P1 |
| TC-SH-AUTO-48 (negative) | Mở rồi đóng Ink **không sửa gì** (TC-G48) | **Không** có thông báo nào | P2 |
| TC-SH-AUTO-49 | Sửa event ở app **Calendar** (không phải trong Ink) → mở và đóng Ink (TC-G49) | Có thông báo như `AUTO-47` | P2 |
| TC-SH-AUTO-50 | Đổi giờ máy sang 04:59 ngày mai → chờ tới 05:00 (TC-G50) | Có thông báo đúng nội dung (`Thursday · 2 events` / `First at 9:00. Ink refreshed your lock screen.`) → wallpaper đổi. Thông báo **ở lại** trong Notification Center — khác `AUTO-47`, **không** tự xoá | P1 |
| TC-SH-AUTO-51 (l10n) | Đổi ngôn ngữ máy (vd Tiếng Việt) → để automation trigger 1 lần (TC-G51) | Nội dung thông báo **được dịch**, automation **vẫn chạy** đúng | P2 |

### 8.10 — Chạy nền qua BGTaskScheduler (chỉ máy thật + Xcode, TC-G52)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-AUTO-52 | Mở Ink rồi về Home → thêm 1 sự kiện qua app Calendar (không mở Ink) → trong Xcode: Pause, gõ `e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.silverai.calendar.lockscreen.calendar-store-refresh"]`, Continue (TC-G52) | Thông báo thay đổi tới → shortcut chạy → thông báo tự xoá. **Chỉ test được trên máy thật**, simulator không có BGTaskScheduler thật | P1 |

### 8.11 — Ảnh hưởng phần còn lại của app (TC-G53–G55)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-AUTO-53 | Sau mỗi lần automation (notification) chạy, mở Ink (TC-G53) | **Không** hiện cảnh báo "automation không chạy" | P2 |
| TC-SH-AUTO-54 | Sau khi automation chạy, kiểm tra wallpaper (TC-G54) | Đúng template và đúng mode Home Screen đang đặt | P1 |
| TC-SH-AUTO-55 | Sau khi các automation notification đã chạy nhiều lần, bấm nút **Update** trong app (TC-G55) | Vẫn chạy bình thường (regression) | P2 |

### 8.12 — Regression BUG-004 trigger #1 (Sunrise) + coverage gap 🆕

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-AUTO-56 (= regression BUG-004 trigger #1) | Bật Google Calendar sync → tạo 1 sự kiện mới trực tiếp trên Google Calendar → để automation **Sunrise** chạy qua đêm (không mở Ink) (nguồn: mục 5.12 test-plan + [bugs/bug-log.md § BUG-004](../../../bugs/bug-log.md#bug-004--event-tạo-trên-google-calendar-không-xuất-hiện-trên-wallpaper-hôm-sau)) | Sự kiện mới **phải xuất hiện** trên wallpaper hôm sau — chạy lại BUG-004 trên trigger Sunrise (khác trigger `AUTO-17`), không coi là đã đóng dù "Need info" cũ | P1 |
| TC-SH-AUTO-57 | 🆕 Nhận 1 thông báo passive khi máy khoá → **vuốt xoá thủ công** banner/thông báo đó khỏi Notification Center **ngay** trước khi hết delay (trước khi automation kịp đọc) (nguồn: mục 11 test-plan-v3 — không có test basis nào nhắc, ảnh hưởng độ tin cậy nhóm G3) | Ghi lại: automation có còn chạy được không nếu thông báo bị xoá trước khi hệ thống kịp trigger — nếu **không chạy**, đây là rủi ro độ tin cậy cần báo dev. Priority tự gán **P2**: ảnh hưởng độ tin cậy của core mechanism notification-trigger (đã P1 ở `AUTO-31`/`AUTO-47`) nhưng likelihood thấp hơn (cần thao tác tay đúng lúc) | 🆕, P2 |
| TC-SH-AUTO-58 | 🆕 Để máy **offline lâu** (chế độ máy bay) trong lúc có ≥2 sự kiện lịch thay đổi → bật lại mạng để nhận bù nhiều notification cùng lúc (nguồn: mục 11 test-plan-v3, suy luận rủi ro mới của QC) | Ghi lại: automation có chạy **nhiều lần** (1 lần/thông báo dồn) hay chỉ **1 lần** — không có kỳ vọng sẵn, chỉ log hành vi thật, không kết luận pass/fail nếu chưa rõ thiết kế đúng là gì. Priority tự gán **P3**: edge case hiếm gặp, không phải core promise | 🆕, P3 |
| TC-SH-AUTO-59 | 🆕 Đang chạy automation (vd Sunrise) xử lý dở (khoảng vài giây trong lúc Set) → đồng thời vào editor **đổi mode Home Screen bằng tay** rồi bấm Update ngay (nguồn: mục 11 test-plan-v3 — race condition mới, khác race đã lường ở `AUTO-20`/`AUTO-21`) | Ghi lại: có lỗi chồng chéo, mất đồng bộ mode, hoặc crash không — đối chiếu `AUTO-24` (`old still running`) làm bằng chứng. Priority tự gán **P2**: cùng nhóm rủi ro race condition đã P1/P2 ở `AUTO-20`/`AUTO-30`, nhưng đường race cụ thể này chưa được test basis lường trước nên hạ nhẹ hơn 1 bậc so với `AUTO-20` | 🆕, P2 |

---

## 9 · Chéo phiên bản · `TC-SH-XVER` (mục 10 test basis)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-XVER-01 | Máy **iOS 26** → cài link V2 → chạy đủ 4 mode Home Screen (TC-H01) | Shortcut chạy đúng cả 4 mode; tab Automation **không** có dòng nào tự thêm vào (iOS 26 không có automation loại này) | P2 |
| TC-SH-XVER-02 | Máy iOS 26 đã chuyển sang V2 (đã chạy `TC-SH-MIG` xong) rồi **lên iOS 27** (TC-H02) | App **không** mời cài lại link (tránh Replace); automation user tự tạo trên iOS 26 (nếu có) vẫn chạy bình thường | P2 |
| TC-SH-XVER-03 | 🔭 Thử cài file/link V2 lên máy khác dải iOS đã chốt hỗ trợ (nguồn: mục 5.11 test-plan, đối chiếu mục 10 spec chính) | **Phải ghi lại** hành vi thật (cài được không, action chạy không) — hướng phụ, không bắt buộc | 🔭 |

---

## 10 · Công cụ Debug · `TC-SH-DBG` (mục 12 test basis — chỉ bản Dev)

> **`DBG-01` phải verify sớm nhất** cùng `INS-05` — là căn cứ đo cho mọi case tốc độ ở nhóm `HS` (Quy ước).

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-DBG-01 | 🔴 Chạy trước mọi case đo tốc độ — Settings → Debug → **Last shortcut run**, đối chiếu số liệu với thời gian bấm giờ tay (TC-I01) | Hiển thị đúng **2 số liệu tách biệt**: *After render → confirm* (phần Set/Switch) và *total* (cả lần chạy) — sai lệch rõ so với bấm giờ tay → không tin bất kỳ case tốc độ nào (`HS-09`, `HS-14`…) cho tới khi xác nhận lại | P1 |
| TC-SH-DBG-02 | Debug → **Wallpaper format**, chọn lần lượt PNG/JPEG/HEIC 1.0 (TC-I02) | Chọn được cả 3, mặc định đúng **HEIC 1.0** | P3 |
| TC-SH-DBG-03 | So sánh mục Debug giữa bản **Dev** và bản **Prod** (TC-I03) | Mục Debug chỉ xuất hiện ở bản **Dev**, không có ở Prod | P3 |
| TC-SH-DBG-04 | Chạy app từ Xcode, gõ `Ink` vào ô lọc Debug console, thực hiện 1 lần Set (TC-I04) | Log đủ dòng `[InkShortcut] …` gồm: token chế độ, thời gian, mức nhiệt (`thermal=`), kết quả callback | P3 |

---

## 11 · Trang "How updates work" · `TC-SH-HOW` (mục 14 test basis)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-HOW-01 | iOS 27, **đã có shortcut** → Settings → How updates work (TC-K01) | Đoạn giải thích + nút **"How to set it up"** (icon chuông) → mở đúng mục Guide "Refresh the moment your schedule changes" | P3 |
| TC-SH-HOW-02 | iOS 27, **chưa có shortcut** → mở trang (TC-K02) | Chỉ có đoạn giải thích, **không** có nút | P3 |
| TC-SH-HOW-03 | **iOS 26** → mở trang (TC-K03) | Đoạn giải thích + dòng mờ "Needs iOS 27. Update your iPhone in Settings › General › Software Update to use it.", **không** có nút | P3 |
| TC-SH-HOW-04 | Cuộn trang bằng nút mũi tên xuống, tới cuối trang (TC-K04) | Nút mũi tên đi từng phần; nút **"I understand"** chỉ **sáng** khi đã cuộn tới cuối | P3 |
| TC-SH-HOW-05 (l10n) | Đổi ngôn ngữ máy (Tiếng Việt, rồi Arabic) → mở lại trang (TC-K05) | Mục mới được **dịch**; tiêu đề giữ đoạn tô màu — đây là màn **đã dịch trước đó**, chữ tiếng Anh ở đây **là bug** (khác ngoại lệ Home Screen chip/Blur/Debug ở mục 3 test-plan) | P3 |

---

## 12 · Event analytics · `TC-SH-ANA` (mục 15 test basis — Firebase DebugView/Realtime, project dev)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SH-ANA-01 | Lời mời update (IAM, `MIG-02`) hiện → bấm nút chính, rồi lặp lại vuốt tắt (TC-L01) | `in_app_message_shown` rồi `in_app_message_action` với `action` = `primary` (bấm nút) hoặc `dismiss` (vuốt tắt) | P3 |
| TC-SH-ANA-02 | Bấm nút chính IAM rồi đi hết luồng update (`MIG-08`…`MIG-15`) (TC-L02) | `setup_started` … `setup_completed`, `source` = `in_app_message`, `kind` = `setup_shortcut_update` | P3 |
| TC-SH-ANA-03 | Ở cửa sổ "Update your shortcut" (`GATE-03`), chọn **"Get the new shortcut"** (TC-L03) | `shortcut_upgrade_gate` với `action` = `install`, rồi các event `setup_*` với `source` = `upgrade_gate` | P2 |
| TC-SH-ANA-04 | Mở luồng setup lần lượt từ Guide / Settings / bài announcement (TC-L04) | Đúng `source` tương ứng (`guide`/`settings`/`announcement`) trong các event `setup_*` | P3 |
| TC-SH-ANA-05 | iOS 27, máy **chưa từng** trả lời hỏi quyền thông báo → bước automation → Open Automations (`AUTO-02`) → mở lại app lần sau (TC-L05) | `push_permission_result` đúng `status` theo lựa chọn, đúng `source` (`setup` trong luồng setup, hoặc `guide` nếu bấm từ Guide). Mở lại app lần sau **không** bắn thêm `push_permission_result` với `source` = `second_open` | P2 |
| TC-SH-ANA-06 | Mở Guide → bấm 1 nút trong 1 topic bất kỳ (TC-L06) | `screen_view` `how_to_guide` khi mở Guide; `guide_action_tapped` đúng `action` (tên nút, vd `open_notification_automation`) và `source` (id topic, vd `automation-notification`) | P3 |
| TC-SH-ANA-07 | iOS 27, đã bật thông báo, shortcut V2 mới nhất: mở/thoát Ink 1 lần trong ngày trước → sửa 1 sự kiện hôm nay → thoát Ink lần nữa (TC-L07) | `refresh_notification_posted` bắn đúng **1 lần** cho mỗi lần đổi lịch (khớp `AUTO-47`). Lần thoát **đầu tiên** trong ngày **không** gửi gì (app chỉ so với ảnh chụp lịch trước đó cùng ngày) | P2 |

---

## 13 · Regression checklist tham chiếu (không viết lại case) — mục 5.12 test-plan, Error guessing/Checklist-based

> Không sinh ID `TC-SH-` riêng cho các dòng dưới đây — đây là kỹ thuật **Checklist-based Testing (§4.4.3)**, trích
> thẳng nguồn có sẵn thay vì thiết kế lại. Bắt buộc chạy trong đợt test này, tính vào exit criteria (mục 9
> test-plan).

| Nhóm | Phạm vi | Nguồn | Chạy lại trên | Ghi chú |
|---|---|---|---|---|
| Happy path cũ | SCT-H01–H19 | [exploratory/03_shortcut-setup.md §1](../../exploratory/03_shortcut-setup.md#1--happy-path--sct-h) | Shortcut **V2 thật** (11 Set/3 Switch, đã verify ở `TC-SH-INS-05`) | Viết cho shortcut V1 (1 action Set) — không dựa kết luận cũ, số action đã đổi hẳn |
| Permission cũ | SCT-N01–N05 (3-dialog D1/D2/D3) | [exploratory/03_shortcut-setup.md §2](../../exploratory/03_shortcut-setup.md#2--negative--ba-dialog-quyền--sct-n01n05) | Shortcut V2 thật | Cùng lý do — không kế thừa kết luận cũ |
| BUG-004 (trigger #1 — Sunrise) | Xem `TC-SH-AUTO-56` | [bugs/bug-log.md § BUG-004](../../../bugs/bug-log.md#bug-004--event-tạo-trên-google-calendar-không-xuất-hiện-trên-wallpaper-hôm-sau) | — | Đã tích hợp vào nhóm `AUTO`, không tách case riêng ở đây |
| BUG-004 (trigger #2 — Google Calendar closed) | Xem `TC-SH-AUTO-17` | Như trên | — | Đã tích hợp vào nhóm `AUTO` |
| Bug Lock/Home đổi chỗ 00:05 | Xem `TC-SH-AUTO-22` | [triggers-ios27.md mục 5](../../specs/shortcuts/qc-shortcut-triggers-ios27.md#5-kiểm-tra-chung-sau-mỗi-lần-automation-chạy) | — | Regression bắt buộc, đã tích hợp vào nhóm `AUTO` |

> **Coverage gap đã biết, chưa test lại ở đợt này** (mục 11 test-plan-v3, không tự bổ sung case vì phạm vi quá
> rộng so với đợt test v3 hiện tại — báo lại nếu cần mở rộng): SCT-N06–N32 đầy đủ (bỏ dở, cấu hình automation
> sai, phá vỡ sau setup, edge case môi trường) của `exploratory/03_shortcut-setup.md` §5/§6 — chỉ SCT-H01–19 và
> SCT-N01–05 được chạy lại ở đợt v3 này theo đúng phạm vi test-plan mục 5.12 quy định, không phải toàn bộ file.

---

## Traceability — đối chiếu nhanh nhóm case ↔ mục test-plan

| Nhóm | Số case | Kỹ thuật (mục 5 test-plan) | Mục test-plan |
|---|---|---|---|
| `INS` | 13 | EP (4 partition) | 5.3 |
| `OLD` | 10 | Regression + Decision Table 2 (4 rule) | 5.4 |
| `HS` | 28 | State Transition (9 token) + Decision Table 1 (7 rule) + BVA 24h | 5.1, 5.2, 5.10 |
| `OWN` | 13 | EP + chuỗi sự kiện tuần tự | 5.3 |
| `PAIR` | 7 | BVA 2-value | 5.10 |
| `GATE` | 6 | Decision Table 3 (6 rule) | 5.5 |
| `MIG` | 23 | State Transition mới + BVA (3 ngày/3 lần, 7 ngày) | 5.6, 5.10 |
| `AUTO` | 59 | Decision Table 4 (5 rule) + State Transition (3 transition) + EP/BVA + Exploratory + Error guessing | 5.7, 5.8, 5.9, 5.11, 5.12 |
| `XVER` | 3 | Compatibility checklist | 5.13 (ngoài phạm vi số mục cụ thể) |
| `DBG` | 4 | Checklist | 5.13 |
| `HOW` | 5 | Checklist | 5.13 |
| `ANA` | 7 | Checklist đối chiếu event | 5.13 |
| Regression tham chiếu (mục 13, không có ID riêng) | 5 dòng tham chiếu | Checklist-based (§4.4.3) | 5.12 |

**Tổng:** 178 case có ID `TC-SH-*` (chưa tính 5 dòng regression tham chiếu không đánh ID riêng).

> **Lưu ý nhất quán nội bộ giữa mục 5.11 test-plan và test-analysis (phát hiện mới khi đối chiếu, không phải 1
> trong 3 gap đã biết ở mục 10):** bảng charter Exploratory ở mục 5.11 test-plan gộp chung `TC-C21`/`TC-C22`/
> `TC-C26` (cùng 1 charter "HEIC") và liệt `TC-G26` (Replace) như case Exploratory, nhưng test-analysis mục 2 lại
> gán `TC-C21`/`TC-C22`/`TC-G26` priority **P2 cụ thể** (không phải Exploratory thuần "—" như `TC-C26`/`TC-G08`/
> `TC-G09`/`TC-G10`/`TC-G28`/`TC-G41`–`44`/`TC-J21`). File case này đã xử lý theo **test-analysis** (nguồn ưu
> tiên hơn vì có risk assessment cụ thể): `HS-22`/`HS-23`/`AUTO-26` viết dạng case P2 "quan sát/điều tra hậu quả"
> có kết quả mong đợi mô tả rõ (không tag 🔭), chỉ `HS-27` (TC-C26) giữ 🔭 thuần. Không tự sửa test-plan — báo
> lại nếu cần chốt lại cách phân loại.
