# Test Case Specification — Shortcut wallpaper: Home Screen (iOS 26), Automation & Trigger (iOS 27) — bản V2-updated

> ⚠️ **SUPERSEDED — không dùng tài liệu này để chạy test.** Thiết kế từ test-plan/test basis
> nhánh `fix/ios27-shortcut-automation` (chưa vào `main`), nay đã lỗi thời sau khi PR #302 merge
> vào `main` 2026-09-24. Chưa có case nào trong file này từng chạy trên máy (0 kết quả PASS/FAIL
> ghi nhận), nên không mất công việc thực thi nào khi bỏ. Giữ lại chỉ để đối chiếu lịch sử.

> Thiết kế case theo [test-plan-ios26-27-v2-updated.md](test-plan-ios26-27-v2-updated.md) (ISTQB Foundation) —
> bám đúng kỹ thuật đã chọn ở mục 5 test plan (State Transition 9 nhánh token, Decision Table 1–5, State
> Transition "closed", BVA, Exploratory, Error guessing).
> Test basis: [qc-shortcut-home-screen-ios26-27-V2-updated.md](../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2-updated.md)
> + [qc-shortcut-triggers-ios27.md](../../specs/shortcuts/qc-shortcut-triggers-ios27.md).
> File shortcut thật: [test-data/ink-shortcut-final-4/](../../test-data/ink-shortcut-final-4/) — chỉ dùng bản
> `Dev`. **Không đụng** [test-plan-ios26-27.md](test-plan-ios26-27.md) / [test-cases-ios26-27.md](test-cases-ios26-27.md)
> (bản V2 cũ).

## Quy ước

- **Ưu tiên:** P1 (chặn phát hành) · P2 · P3 — theo đúng mục 6 test plan, không tự đổi.
- **🔭 Exploratory** — chưa có đáp án đúng/sai định sẵn. Cột "Kết quả mong đợi" ghi "**Phải quan sát/ghi lại**",
  ghi vào bảng thăm dò mục 11 của [V2-updated](../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2-updated.md#11-bảng-ghi-kết-quả-thăm-dò)
  hoặc mục 8 của [triggers-ios27.md](../../specs/shortcuts/qc-shortcut-triggers-ios27.md#8-bảng-ghi-kết-quả).
- **⚠️ Phụ thuộc gap mở (mục 10 test plan)** — case có thể đổi kết quả mong đợi sau khi dev trả lời. Chạy và ghi
  nhận thực tế, **không** tự suy đoán câu trả lời trước.
- **🔴 Case xác nhận/bác bỏ nghi vấn cấu trúc (gap #1)** — nhóm `HS-T2`/`HS-T3`: cấu trúc if/else đã xác nhận
  qua cross-check tay (không có `Otherwise` cho nhánh Same+Blur), nhưng **chưa verify runtime**. Chạy **đầu
  tiên** trong nhóm HS, trước mọi case khác của Decision Table 1 — nếu xác nhận đúng là bug, các case DT1 liên
  quan Same phải ghi "Fail, xem HS-02b/HS-03" thay vì tự suy ra pass/fail theo mô tả cũ của test basis.
- **⚠️ Mã nhóm `TRIG` trong file này khác nghĩa với `TRIG` ở [test-cases-ios26-27.md](test-cases-ios26-27.md)
  (bản V2 cũ):** ở đây là **Trigger automation qua Notification** (phát hiện mới, chưa có ở bản V2); nội dung
  cũ của `TRIG` (Decision Table 4 — yêu cầu đổi tên theo từng luồng kích hoạt) **không đổi**, xem mục 10
  (Regression, tham chiếu).
- **Ảnh bằng chứng khi chạy case:** lưu vào `screenshots/v2-updated/<mã nhóm>/` (thư mục **mới**, tách khỏi
  `screenshots/` phẳng của bản V2 cũ để tránh trùng ID case giữa 2 bản) — xem quy ước đặt tên ở
  [screenshots/v2-updated/README.md](screenshots/v2-updated/README.md).
- Mọi case mặc định chạy trên **Ink Dev** dựng từ nhánh `fix/ios27-shortcut-automation`, file `Dev` trong
  [test-data/ink-shortcut-final-4/](../../test-data/ink-shortcut-final-4/). Nhóm `AUTO`/`TRIG` **chỉ chạy trên
  máy iOS 27** — ghi rõ lại ở đầu mỗi nhóm đó, không lặp lại trong từng case.

---

## 1 · Nền tảng — Cài đặt & chuyển đổi nhiều shortcut · `INS` (mục 3 V2-updated, Decision Table 2)

> Chạy **trước tiên** trên mỗi máy — nếu sai, kết quả mọi nhóm sau không đáng tin.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| INS-01 | Máy iOS 26, cài `iOS 26/Dev` qua AirDrop → Add Shortcut | Tên đúng `Ink Refresh Lock Screen`; mở shortcut thấy đúng **7 action "Set Wallpaper"** và **2 action "Switch to Wallpaper"** (số thật đã cross-check tay, không phải "11/3" spec ghi sai), không action nào màu đỏ | P1 |
| INS-02 | Máy iOS 27, cài `iOS 27/Dev` → mở shortcut → ⓘ → Privacy → bật **Allow Running When Locked** | Như INS-01 (7 Set/2 Switch), thêm bước bật toggle thành công (không đi theo file, phải bật tay mỗi máy) | P1 |
| INS-10 | 🔴 Sau INS-01/02 — mở shortcut, tìm cả **2** action "Switch to Wallpaper" | Cả 2 ô cặp wallpaper hiện đúng biến `Wallpaper`. Nếu **trống**, hoặc chạy shortcut **hiện popup bắt chọn** → **báo ngay, lỗi chặn phát hành** | **P1** |
| INS-03 | Lần chạy đầu tiên (trigger từ app) | Hộp thoại hỏi quyền đặt wallpaper → chọn **Always Allow** → shortcut chạy xong | P1 |
| INS-04 | Đổi tên shortcut A đang chạy sang tên riêng → đổi tên shortcut B sang `Ink Refresh Lock Screen` → bấm **Update** trong app | Shortcut B chạy (phân biệt qua Home Screen mode) | P1 |
| INS-05 | **Không** đổi tên shortcut cũ trước → cài thêm 1 file mới khi đã có shortcut tên `Ink Refresh Lock Screen` | Ghi lại iOS hỏi **Replace** hay thêm bản số `1` — Decision Table 2, DT2-01/02 | 🔭 |
| INS-06 | Đổi tên shortcut cũ trước (đúng quy trình) → cài thêm 1 file mới | Không xung đột, 2 shortcut cùng tồn tại tên khác nhau | P2 |
| INS-07 | 🔴 Cố tình để **2 shortcut cùng tên** `Ink Refresh Lock Screen` → bấm Update trong app | Ghi nhận app chạy shortcut nào — **không log bug**; **dừng ngay mọi case khác** theo Suspension (mục 8.1 test plan), đổi tên lại trước khi tiếp tục | P1 (an toàn quy trình) |
| INS-08 | Trên iOS 27, có ≥2 shortcut, 1 cái không dùng còn giữ **cả 4 automation** bật | Verify đã tắt cả 4 automation của shortcut không dùng (Edit → Automation) — tránh nhiều automation ghi đè nhau | P2 |
| INS-09 | Sau INS-04, bấm Update trong app | Đúng shortcut vừa đổi tên chạy, verify qua Home Screen mode | P1 |

---

## 2 · Luồng set wallpaper cũ không vỡ · `OLD` (mục 4 V2-updated)

> Để Home Screen = **Off** cho toàn bộ nhóm này. Note tự xếp rủi ro cao nhất. Không đổi so với V2 (mục 4 test
> basis không thay đổi nội dung phần này, chỉ thêm phần Toast — xem nhóm `TOAST`).

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| OLD-01 | Discover → chọn 1 template → **Set as current** | Shortcut chạy → lock đổi đúng template → app quay lại → template hiện nhãn đang dùng | P1 |
| OLD-02 | Mở template đang dùng → sửa nội dung → **Update** | Lock đổi theo đúng nội dung mới | P1 |
| OLD-03 | Lần chạy đầu, hộp thoại hỏi quyền → chọn **Don't Allow** → mở lại app | App **không** coi là đã set thành công | P1 |
| OLD-04 | Đổi tên shortcut đi (coi như xoá) → bấm **Set** trong app | App nhận ra không còn shortcut, đưa vào luồng cài đặt, **không kẹt** ở màn Shortcuts. Đổi tên lại để tiếp tục | P1 |
| OLD-05 | Spotlight: gõ "Ink" → chọn **Refresh Lock Screen** | Wallpaper đổi, **không** mở app | P1 |
| OLD-06 | Lặp lại OLD-01/02 với template loại **Note** và loại **lịch** | Cả 2 loại đều set được như OLD-01/02 | P1 |

---

## 3 · Toast báo kết quả · `TOAST` (mục 4 V2-updated, hoàn toàn mới — Decision Table 3)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TOAST-01 | Đang ở màn edit template → bấm **Update** → shortcut chạy xong | Toast **"Lock screen updated"** hiện **ngay trên màn edit**, không đợi thoát ra Home | P2 |
| TOAST-02 | Làm shortcut lỗi (đổi tên để app không tìm thấy) → bấm Update ở màn edit | Toast lỗi cũng hiện **trên màn đang mở** | P2 |
| TOAST-03 | Mở 1 sheet/popup trên màn edit → bấm Update từ đó | Toast hiện trên cả sheet, **không chặn thao tác** — vẫn bấm được nút bên dưới trong lúc toast hiện | P2 |
| TOAST-04 | Trong **luồng cài shortcut lần đầu**, cố tình làm chạy lỗi | Chỉ **1** thông báo lỗi (của màn cài đặt) — **không** chồng thêm toast lỗi thứ 2 | P3 |

---

## 4 · Bốn chế độ Home Screen × Blur, skip-unchanged, HEIC, tốc độ · `HS` (mục 5 V2-updated)

> **Trình tự chạy gộp** — chuẩn bị 1 lần: đã xong nhóm INS · chọn 1 template có lịch dùng xuyên suốt · Own photo
> đã chọn sẵn 1 ảnh · đếm số cặp wallpaper hiện tại làm baseline N (dùng chung với `PAIR-03`, xem mục 10).
>
> **Chạy HS-02/HS-02b (Same+Blur) trước tiên, tách biệt khỏi chuỗi 8 bước còn lại** — đây là case xác nhận
> nghi vấn nghiêm trọng nhất tài liệu (gap #1). Sau khi có kết quả 2 case này, mới chạy tiếp chuỗi Photo
> only/Own photo (không phụ thuộc gap #1).

### 4.1 · State Transition — nhánh Same (ưu tiên tuyệt đối, chạy đầu tiên)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| HS-02 | 🔴 Chọn **Same**, đảm bảo Blur đang **tắt sẵn từ đầu** (chưa từng bật ở template này) → **Set as current** | Theo cấu trúc thật (token `same`, không `Otherwise` cho blur-if): **nghi ngờ 0 Set chạy** — Lock **và** Home đều **không đổi**. Nếu Lock/Home vẫn đổi đúng như test basis mô tả (cùng ảnh có lịch, nét) → gap #1 coi như bị bác bỏ, ghi rõ "Bác bỏ — cấu trúc đọc sai hoặc có cơ chế khác chưa lộ" | **P1** |
| HS-02b | 🔴 Tiếp theo HS-02 (hoặc bắt đầu từ Same+Blur **bật**, Update xong) → **tắt** Blur → **Update một lần** | Đây là chiều "tắt Blur" của test basis (kỳ vọng gốc: home đổi mờ→nét ngay). Theo cấu trúc thật (token `same-redraw`, redraw-if lồng trong blur-if): **nghi ngờ 0 Set chạy** — Home **vẫn giữ nguyên trạng thái mờ cũ**, Lock cũng không đổi lịch mới. Đây là case **quan trọng nhất toàn bộ tài liệu** — kết quả quyết định có báo bug ngay cho dev hay không | **P1** |
| HS-03 | Chọn Same, Blur **bật** (không vừa đổi) → Update | Lock: có lịch, nét · Home: cùng ảnh có lịch, **mờ** (token `same-blur`, 1 Set) | P2 |
| HS-03b | Từ Same+Blur tắt (không vừa đổi) → **bật** Blur → Update một lần | Home đổi **mờ ngay** (token `same-blur-redraw`, 2 Set) — chiều "bật Blur" của test basis, kỳ vọng vẫn đúng như spec vì đây **không** phải chiều bị nghi vấn ở HS-02b | P1 |

### 4.2 · Decision Table 1 — Photo only / Own photo × Blur (không phụ thuộc gap #1)

| ID | Chế độ | Blur | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|---|---|:---:|
| HS-01 | Off | — | Chọn Off → Set/Update | Lock: có lịch · Home: **không bị Ink set** | P1 |
| HS-04 | Photo only | Tắt | Chọn Photo only, Blur tắt → Update | Lock: có lịch · Home: ảnh nền, không lịch, **không tối** dù Darken kéo cao | P2 |
| HS-05 | Photo only | Bật | Bật Blur → Update | Lock: vẫn nét · Home: ảnh nền, **mờ** | P2 |
| HS-06 | Own photo | Tắt | Chọn Own photo (đã có ảnh), Blur tắt → Update | Lock: có lịch · Home: ảnh đã chọn, nét | P2 |
| HS-07 | Own photo | Bật | Bật Blur → Update | Lock: vẫn nét · Home: ảnh đã chọn, **mờ** | P2 |
| HS-08 | — | — | Mở editor, thử từng mode | Toggle **Blur Home Screen** chỉ hiện khi mode **khác Off** | P2 |
| HS-09 | Photo only | — | Kéo thanh **Darken** của lock lên cao nhất trước khi Set | Home **không bị tối theo** | P2 |
| HS-10 | Photo only | — | Dùng template có **nhiều ảnh nền đổi theo ngày** | Photo only dùng đúng ảnh **hôm nay**, khớp ảnh dưới lịch trên lock | P2 |
| HS-11 | Photo only + Own photo | — | Chạy Set/Update, đếm số lần hộp thoại quyền xuất hiện | **Ghi lại** có bị hỏi quyền 2 lần không (2 action Set trong 1 lần chạy) — QC giữ thêm Own photo dù spec chỉ hỏi Photo only, xem test-analysis §1 #5 | 🔭 |
| HS-12 | Bất kỳ | — | Đổi mode trong editor → bấm **✕ (Cancel)** thoát → mở lại | Mode **quay về đúng trạng thái trước khi mở** editor | P3 |

### 4.3 · Skip-unchanged (Photo only/Own photo — mới hoàn toàn, không phụ thuộc gap #1)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| HS-13 | Photo only, Update lần 1 → ghi timing ở `DBG` (Last shortcut run) → **không đổi gì**, Update lần 2 (nghỉ 1 phút) | Lần 2 **nhanh hơn rõ**, gần bằng Off. Home vẫn đúng ảnh, lock có lịch mới. Console `[InkShortcut]` ghi `home=skip-unchanged` | P1 |
| HS-14 | Thêm/sửa 1 sự kiện lịch → Update | Vẫn nhanh (ảnh nền không đổi), home vẫn đúng | P2 |
| HS-15 | Đổi ảnh nền (khác/crop lại/đổi template) → Update | Home đổi theo **ngay lần đó**, console `home=set` | P1 |
| HS-16 | **Crop lại cùng một ảnh** (không đổi ảnh nguồn) → Update | Home đổi theo khung crop mới — hash phải nhạy với crop, không chỉ nguồn ảnh | P2 |
| HS-17 | Đổi Blur (không đổi ảnh nền) → Update | Home đổi blur **ngay**, **không** bị skip-unchanged bỏ qua | P1 |
| HS-18 | Photo only → **Off** → tự đổi ảnh home qua iOS → quay lại **Photo only** → Update | Home **về đúng ảnh nền template** — không giữ ảnh tự chọn qua iOS | P2 |
| HS-19 | Template nhiều ảnh theo ngày, để automation chạy sáng hôm sau (không sửa gì tay) | Home là ảnh **hôm nay**, dù chưa quá 24h kể từ lần chạy trước | P1 |
| HS-20 | ⚠️ **Phụ thuộc gap #2.** Để qua **hơn 24 giờ** không đổi gì → lần chạy kế tiếp | Verify **cả 2 khả năng**, ghi nhận thực tế: (a) ghi home đầy đủ 1 lần (chậm lại đúng 1 lần, đúng test basis mô tả), hoặc (b) vẫn nhanh, không ghi lại (đúng cập nhật miệng của dev) — **không giả định trước** cái nào đúng | P2 |
| HS-21 | ⚠️ **Phụ thuộc gap #2.** **Same mode** — Update lần 1 ghi timing → không đổi gì → Update lần 2 (nghỉ 1 phút) | Theo dev báo miệng: kỳ vọng **nhanh hơn rõ** giống Photo only (skip-unchanged mở rộng sang Same) — nhưng test basis **không** mô tả cơ chế này cho Same. Ghi nhận kết quả thật, đối chiếu lại với HS-02/02b (nếu Same+Blur tắt đã xác nhận là bug 0-Set, case này cần chạy ở **Same+Blur bật** để tránh nhiễu với gap #1) | P1 |

### 4.4 · Chất lượng ảnh HEIC (🔭 exploratory, không ngưỡng khách quan)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| HS-22 | Chọn template có **thẻ bán trong suốt** đè ảnh nền → Set → soi kỹ lock screen | **Phải quan sát/ghi lại:** có vệt màu, sọc, mảng loang ở mép thẻ/vùng chuyển màu không | 🔭 |
| HS-23 | Soi chữ nhỏ trên lịch (giờ, tên sự kiện) sau khi set | **Phải quan sát/ghi lại:** có nhoè viền do nén HEIC không | 🔭 |
| HS-24 | Khi nghi ngờ HS-22/23: `DBG` → Wallpaper format → **PNG**, set lại cùng template, chụp cả 2 bản | Dùng làm bằng chứng đính kèm báo lỗi — không phải case pass/fail độc lập | — |

---

## 5 · Own photo trong Ink (A) + tự chọn qua iOS, Ink Off (B) · `OWN` (mục 6 V2-updated)

### 5.1 · Own photo trong Ink (A)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| OWN-01 | Chế độ Own photo → chọn ảnh từ **Photos** | Home đúng ảnh đó, lock vẫn có lịch. Ảnh cũng xuất hiện ở hàng ảnh nền của lock | P1 |
| OWN-02 | Chọn 1 ảnh **catalog** (vòng xoay tải) | Được chọn → Set → home đúng ảnh đó | P2 |
| OWN-03 | 🆕 Update lần 2 **không đổi gì** (nghỉ 1 phút) | **Nhanh** (skip-unchanged), home giữ nguyên, console `home=skip-unchanged` — test **riêng** cho Own photo, không mặc định giống Photo only dù chia sẻ code path | P1 |
| OWN-04 | Đổi sang ảnh khác trong Own photo → Update | Home đổi theo **ngay** | P1 |
| OWN-05 | Đổi **template khác** trong khi giữ Own photo → Update | Home **vẫn là ảnh riêng** (không theo template) | P2 |
| OWN-06 | Chuyển sang Photo only rồi quay lại Own photo | Ảnh đã chọn **vẫn còn được chọn**, không phải chọn lại | P2 |
| OWN-07 | Own photo nhưng **chưa chọn ảnh nào** → Update | Home dùng ảnh nền của lock — **không bao giờ** trống/đen | P1 |
| OWN-08 | Test với ảnh **dọc / ngang / vuông** | Home phủ kín màn, căn giữa, không méo ở cả 3 | P2 |

### 5.2 · Tự chọn qua iOS, Ink để Off (B) — hoàn toàn mới, chính thức hoá risk QC từng tự phát hiện trước V2-updated

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| OWN-09 | Màn khoá ở cặp Ink → giữ tay → **Customize → Home Screen** → chọn 1 ảnh trong Photos → Done | Setup step — không phải pass/fail riêng | — |
| OWN-10 | Về Ink, chế độ **Off**, bấm **Update** | Lock đổi lịch mới · Home **vẫn là ảnh vừa chọn qua iOS** (Ink không đụng home) | **P1** |
| OWN-11 | Chạy thêm **2 lần** (kể cả để automation sáng hôm sau chạy, trên iOS 27) | Home **vẫn giữ nguyên** ảnh đã chỉnh qua iOS | **P1** |
| OWN-12 | Chuyển sang Same/Photo only/Own photo rồi Update | Home **bị thay** — đúng, vì user tự chọn mode ghi đè (xác nhận ranh giới đúng của OWN-10/11, không phải bug) | P2 |

---

## 6 · Cặp wallpaper · `PAIR` (mục 7 V2-updated — không đổi so với V2, dẫn chiếu)

> Cơ chế và Decision Table **không đổi** so với bản V2 — dẫn chiếu thẳng
> [test-cases-ios26-27.md §5](test-cases-ios26-27.md#5--cặp-wallpaper--tc-sh-pair-mục-7-nguồn--v2-đã-giải-thích-cơ-chế-không-còn-thuần-thăm-dò),
> **không thiết kế lại**. Chạy nguyên `PAIR-01, 02, 03, 04, 05, 06` như đã viết ở đó, trên file shortcut mới
> (7 Set/2 Switch) — chỉ số action đếm được khác, hành vi kỳ vọng giữ nguyên.
> ⚠️ **Không chạy lại `PAIR-07/08/09` ở đây** — 3 case đó (user tự sửa Home qua iOS trong chính cặp Ink) đã được
> **viết lại đầy đủ hơn** thành `OWN-09` → `OWN-12` ở mục 5.2 trên, vì V2-updated nay chính thức mô tả kịch bản
> này ở mục 6.B của test basis (không còn là risk QC tự phát hiện ngoài spec).

| PAIR-01 | PAIR-02 | PAIR-03 | PAIR-04 | PAIR-05 | PAIR-06 |
|---|---|---|---|---|---|
| Cài mới khi đang ở cặp riêng | Update 3 lần liên tiếp | Chạy đủ 4 chế độ, đếm cặp | Chuyển cặp khác rồi Update | Xoá cặp Ink rồi Update | Spot-check (đã xác nhận, không cần lặp lại) |

---

## 7 · Cảnh báo "Needs the new Ink shortcut" · `WARN` (mục 8 V2-updated, Decision Table 5.5)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| WARN-01 | Đổi tên để app chạy **shortcut production** → editor → chọn Same/Photo only | Cảnh báo vàng **hiện** | P2 |
| WARN-02 | 🆕 Tương tự WARN-01 nhưng chọn **Own photo** (QC bổ sung, test-analysis §1 #5) | Cảnh báo vàng **hiện** — suy diễn từ việc Own photo/Photo only dùng chung code path, chưa được spec tự xác nhận | 🔭 |
| WARN-03 | Đổi tên để app chạy **shortcut mới**, bấm Update 1 lần → đóng/mở lại editor | Cảnh báo vàng **biến mất** | P2 |
| WARN-04 | Với shortcut production, chọn Photo only rồi Set | Production **không hiểu** mode này — vẫn set cả lock+home bằng ảnh lịch + blur như cũ. **Đúng dự kiến, không log bug** | P3 |
| WARN-05 | Bất kỳ shortcut nào, mode = **Off** | Cảnh báo **không áp dụng** | P3 |

---

## 8 · Automation (4 loại có sẵn) · `AUTO` — **chỉ máy iOS 27** (mục 9 V2-updated + toàn bộ triggers-ios27.md)

### 8.1 · Chuẩn bị (mục 3 triggers-ios27.md — nền tảng cho cả nhóm AUTO/TRIG)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| AUTO-01 | **Trước khi cài:** xoá hết shortcut Ink cũ trong app Phím tắt → mở tab Automation, xác nhận **không còn dòng nào** của Ink | Nếu bỏ qua bước này, cài đè bằng Replace có thể để automation cũ chạy song song — làm mọi kết quả automation sau **không đáng tin**. Đây là entry criteria, không phải case pass/fail thông thường | **P1** |
| AUTO-02 | Sau khi cài (INS-02), mở shortcut → ⓘ/Settings → bật **Allow Running When Locked** nếu có | Toggle bật thành công | P1 |
| AUTO-03 | Mở Ink → chạy setup shortcut tới bước **Open Automations** → trong tab Automation, bật **cả 4 dòng** | Cả 4 automation chuyển sang **bật** | P2 |
| AUTO-04 | Mở từng dòng automation vừa bật | **Ghi lại** mặc định là **Run Immediately** hay **Run After Confirmation** → chọn **Run Immediately** cho cả 4 (để test các case sau không bị chặn bởi hộp thoại xác nhận); bật **Notify When Run** để dễ quan sát | 🔭 (ghi mặc định) rồi P3 (đổi setting) |

### 8.2 · Sunrise

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| AUTO-05 | Ngay sau AUTO-03, chưa để automation tự chạy | **Ghi lại:** automation Sunrise có mặt, đang bật hay tắt theo mặc định (tài liệu 2 khẳng định mặc định phải **tắt**) | 🔭 |
| AUTO-06 | Để Sunrise chạy lần đầu (hoặc lần đầu bật) | **Ghi lại:** iOS có xin quyền **vị trí** không | P2 |
| AUTO-07 | Tối trước: tạo sự kiện `QC sunrise` cho ngày mai → khoá máy qua đêm, **không mở khoá** sáng hôm sau | Màn khoá đã có `QC sunrise` đúng ngày mới, **không** hỏi xác nhận, **không** hiện "running your automation" | **P1** |
| AUTO-08 | Mở Ink sau AUTO-07 | **Không** có cảnh báo "automation không chạy" ở Home/Settings | P2 |
| AUTO-08b | *(rút ngắn thời gian chờ, xem Suspension mục 8.1 test plan)* Đổi tạm Sunrise sang **Time of Day, 2–3 phút tới** → khoá máy → chờ → kiểm tra như AUTO-07 → **test xong xoá shortcut, cài lại từ file**, không đổi giờ ngược lại | Dùng thay AUTO-07 khi không đợi được qua đêm | P2 |
| AUTO-09 | *(regression BUG-004)* Tạo event mới trên **Google Calendar** → chờ Sunrise chạy qua đêm | Event mới **phải xuất hiện** trên wallpaper hôm sau — chạy lại [BUG-004](../../../bugs/bug-log.md#bug-004--event-tạo-trên-google-calendar-không-xuất-hiện-trên-wallpaper-hôm-sau) trên trigger Sunrise mới | **P1** |

### 8.3 · When Calendar is closed / When Google Calendar is closed

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| AUTO-10 | Mở **Lịch** → thêm sự kiện `QC calendar` hôm nay → về Home (vuốt lên), không mở Ink | Trong vài giây, automation chạy → khoá máy xem `QC calendar` đã hiện | **P1** |
| AUTO-11 | Chỉ **chuyển sang app khác** (App Switcher), không về Home | **Ghi lại:** có tính là "closed" để kích hoạt automation không (ranh giới chưa rõ, xem test plan mục 5.7) | 🔭 |
| AUTO-12 | **Vuốt tắt hẳn** Lịch trong App Switcher | **Ghi lại:** có tính "closed" không | 🔭 |
| AUTO-13 | Mở Lịch rồi thoát ngay, **không sửa gì** | Automation vẫn chạy (đúng thiết kế) — đo mất bao lâu, có làm máy khựng không | P3 |
| AUTO-14 | Lặp lại AUTO-10 với **Google Calendar** (tài khoản đã kết nối Ink) | Event mới xuất hiện trên wallpaper trong vài giây | **P1** |
| AUTO-15 | Trên máy **không cài** Google Calendar | **Ghi lại:** dòng automation "When Google Calendar is closed" hiện ra sao, có báo lỗi không | P2 |

### 8.4 · When Ink is closed — rủi ro cao nhất nhóm AUTO

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| AUTO-16 | Trong Ink, đổi template/chế độ Home Screen → rời Ink **mà không bấm Set/Update** | **Ghi lại:** màn khoá có cập nhật theo lựa chọn mới không — nếu có, nghĩa là chỉ cần đổi setting rồi thoát cũng đủ trigger set (khác giả định cũ "chỉ Set/Update mới kích hoạt") | **P1** |
| AUTO-17 | 🔴 Rời Ink **ngay sau khi** bấm Update | **Ghi lại:** shortcut có chạy **2 lần liên tiếp** không (1 lần Update, 1 lần automation "Ink closed")? Có toast lỗi do đè lên nhau không? | **P1** |
| AUTO-18 | Sau khi automation "Ink closed" chạy xong | Không bị **vòng lặp** — không tự làm Ink "closed" thêm 1 lần nữa | **P1** |

### 8.5 · Kiểm tra chung sau MỌI lần automation chạy

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| AUTO-19 | 🔴 Sau **mỗi** lần automation chạy (cả 4 loại) | Lock có lịch, Home chỉ có ảnh nền (mode khác Off). Nếu **2 màn bị đổi chỗ** — **đã có báo cáo thật lúc 00:05** — ghi ngay: mode, blur, khoá/mở máy, chạy tay có tái hiện được không. **Đây là regression cho bug đã biết**, không phải thăm dò | **P1** |
| AUTO-20 | Sau mỗi lần automation chạy | Màn khoá vẫn đang dùng đúng **cặp wallpaper của Ink** (Switch chạy đúng) | P1 |
| AUTO-21 | Sau mỗi lần automation chạy → `DBG` → Settings → Debug | "Last shortcut run" có số liệu mới; thẻ **In-app messages** có dòng `... old still running false` — nếu `true`, đánh dấu ngay là dấu hiệu race condition (liên hệ AUTO-17) | P1 |

### 8.6 · Trường hợp biên

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| AUTO-22 | Cài lại **cùng file** (Replace) | Tab Automation **không** bị trùng dòng cho cả 4 automation, dòng cũ còn bật | P2 |
| AUTO-23 | **Xoá shortcut** | Cả 4 dòng automation **biến mất theo** | P2 |
| AUTO-24 | Máy **Apple Account khác** → cài file | **Ghi lại:** cả 4 automation có về máy không, bật hay tắt theo mặc định | 🔭 |
| AUTO-25 | **Low Power Mode** hoặc máy nóng, để Sunrise tới giờ chạy | **Ghi lại:** automation có bị iOS tự bỏ qua không | 🔭 |
| AUTO-26 | Cố tình canh Sunrise và "Calendar closed" xảy ra **gần nhau** | Quan sát cờ `old still running` ở AUTO-21 — ghi nhận có lỗi chồng chéo không | P2 |

---

## 9 · Trigger automation qua Notification · `TRIG` — **chỉ máy iOS 27**, hoàn toàn mới (phát hiện qua ảnh chụp thực tế, Q6)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TRIG-01 | Kích hoạt app gửi notification tiêu đề `update_lockscreen` (vd qua luồng chạy tay khiến app tự lên lịch notification — xem gap #5 mục 10 test plan nếu chưa rõ cách tạo điều kiện) | Automation tự bắt và chạy shortcut — **không cần** mở app, không cần đợi Sunrise/đóng app nào | **P1** |
| TRIG-02 | 🔴 Notification từ Ink Dev nhưng **tiêu đề khác** (không chứa `update_lockscreen`, vd nhắc lịch thường) | **Không** trigger shortcut (negative test — tránh chạy nhầm khi có notification khác) | **P1** |
| TRIG-03 | Notification `update_lockscreen` đến khi máy **đang khoá** (đã bật Allow Running When Locked ở AUTO-02) | Automation vẫn chạy được | **P1** |
| TRIG-04 | Cố tình canh notification đến **gần cùng lúc** với 1 trigger khác (Sunrise/Calendar closed/Ink closed) | Quan sát cờ `old still running` (AUTO-21) — ghi nhận có chạy chồng/race không | P2 |
| TRIG-05 | Quan sát nội dung notification thật (`update_lockscreen` / "Your schedule changed.") xuất hiện trên màn khoá | **Ghi lại:** nội dung này có phải điều user thật sự cần thấy không, hay là tín hiệu nội bộ vô tình lộ ra UI — cân nhắc đề xuất ẩn (silent notification) nếu là tín hiệu nội bộ | 🔭 |

---

## 10 · Regression & tham chiếu (không viết lại case)

| Nhóm | Phạm vi | Nguồn |
|---|---|---|
| Chéo phiên bản `XVER` | Không đổi so với V2 — chạy nguyên `XVER-01, 02, 03` ở [test-cases-ios26-27.md §8](test-cases-ios26-27.md#8--chéo-phiên-bản--tc-sh-xver-mục-10-nguồn-đã-cập-nhật-theo-ghi-chú-dev) trên file mới (7 Set/2 Switch) | [test-cases-ios26-27.md](test-cases-ios26-27.md) |
| Luồng kích hoạt & yêu cầu đổi tên (`TRIG` nghĩa cũ, Decision Table 4) | Không đổi — chạy nguyên `TRIG-01…04` ở [test-cases-ios26-27.md §9](test-cases-ios26-27.md#9--luồng-kích-hoạt--yêu-cầu-đổi-tên--tc-sh-trig-decision-table-4-cross-cutting). **Không nhầm với nhóm `TRIG` (notification) ở mục 9 phía trên của file này** | [test-cases-ios26-27.md](test-cases-ios26-27.md) |
| Happy path cũ | SCT-H01–H19 chạy lại **trên shortcut mới** (7 Set/2 Switch) | [exploratory/03_shortcut-setup.md §1](../../exploratory/03_shortcut-setup.md#1--happy-path--sct-h) |
| Permission cũ | SCT-N01–N05 chạy lại **trên shortcut mới** — không kế thừa kết luận cũ, số action đã đổi | [exploratory/03_shortcut-setup.md §2](../../exploratory/03_shortcut-setup.md#2--negative--ba-dialog-quyền--sct-n01n05) |
| BUG-004 | Đã tích hợp vào `AUTO-09` (Sunrise) và `AUTO-14` (Google Calendar closed) — 2 đường trigger khác nhau, cùng 1 nghi vấn root cause | [bugs/bug-log.md § BUG-004](../../../bugs/bug-log.md#bug-004--event-tạo-trên-google-calendar-không-xuất-hiện-trên-wallpaper-hôm-sau) |

---

## 11 · Công cụ Debug · `DBG` (mục 12 V2-updated, hoàn toàn mới)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| DBG-01 | Chạy Update, bấm dừng đồng hồ tay song song → Settings → Debug → **Last shortcut run** | 2 số liệu tách biệt (*After render → confirm*, *total*) khớp với thời gian đo tay — đây là công cụ đo nền tảng cho `HS-13/20/21` | **P1** |
| DBG-02 | Mở **Wallpaper format** | Chọn được PNG/JPEG/**HEIC 1.0**, mặc định đúng HEIC 1.0 | P3 |
| DBG-03 | Kiểm tra bản **Prod** (nếu có build) | Mục Debug **không** xuất hiện — chỉ có ở bản Dev | P3 |
| DBG-04 | Chạy app từ Xcode, gõ `Ink` vào ô lọc Debug console | Hiện đủ dòng `[InkShortcut] …`: token chế độ, thời gian, `thermal=`, kết quả callback | P3 |

---

## 12 · Traceability — đối chiếu với cụm rủi ro P1 ở test plan (mục 6)

| Cụm rủi ro (test plan mục 6) | Case cụ thể ở đây |
|---|---|
| Nghi vấn bug nghiêm trọng nhất (`HS-T2`/`HS-T3`) | `HS-02`, `HS-02b` |
| Regression bug đã có báo cáo thật (Lock/Home đổi chỗ) | `AUTO-19` |
| Race condition "Ink closed" | `AUTO-17`, `AUTO-18`, `AUTO-21` |
| Cơ chế trigger mới (notification) | `TRIG-01`, `TRIG-02`, `TRIG-03` |
| Nền tảng cài đặt | `INS-01`, `INS-03`, `INS-05`…`07`, `AUTO-01`, `AUTO-02` |
| Luồng cũ không vỡ | `OLD-01`…`04` |
| Skip-unchanged trung tâm bản update | `HS-13`, `HS-15`, `HS-17`, `HS-19`, `HS-21` |
| Data integrity Own photo / cặp wallpaper | `OWN-01`, `OWN-03`, `OWN-04`, `OWN-07`, `OWN-10`, `OWN-11`, `PAIR-01…05` (tham chiếu) |
| Automation nền tảng | `AUTO-05`, `AUTO-06`, `AUTO-07` |
| Công cụ đo nền tảng | `DBG-01` |
| Lock luôn nét | `HS-03`, `HS-05`, `HS-07` |
