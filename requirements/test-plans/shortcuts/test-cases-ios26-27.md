# Test Case Specification — Shortcut wallpaper mới: Home Screen (iOS 26) và Automation (iOS 27)

> Thiết kế case theo [test-plan-ios26-27.md](test-plan-ios26-27.md) (ISTQB Foundation) — bám đúng kỹ thuật đã
> chọn ở mục 5 của test plan (Equivalence Partitioning, BVA, Decision Table 1–4, State Transition, Exploratory).
> Test basis: [qc-shortcut-home-screen-ios26-27-V2.md](../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2.md)
> — **V2, nguồn sự thật duy nhất**; bản V1 đã bị thay thế do sai sót, xem "V2 thay thế V1" đầu file
> [test-plan-ios26-27.md](test-plan-ios26-27.md). File shortcut thật:
> [test-data/ink-shortcut-final/](../../test-data/ink-shortcut-final/) — **bộ file đã sửa** (dev gọi là
> `Ink Shortcut Final 2`), checksum khác hẳn bộ V1 cũ hiện nằm ở
> [test-data/ink-shortcut-final-v1-superseded/](../../test-data/ink-shortcut-final-v1-superseded/) (không dùng).

## Quy ước

- **Ưu tiên:** P1 (chặn phát hành) · P2 · P3 — theo đúng mục 6 test plan.
- **🔭 Exploratory** — V2 tự khai không biết trước kết quả đúng ở vài điểm cụ thể (chủ yếu mục 9/10 nguồn; mục
  7 — cặp wallpaper — V2 đã giải thích cơ chế nên phần lớn case ở đó **không còn** 🔭, xem nhóm PAIR bên dưới).
  Cột "Kết quả mong đợi" ghi thành "**Phải quan sát/ghi lại**" thay vì 1 đáp án cố định — ghi nguyên vào bảng
  thăm dò [mục 11 của V2](../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2.md#11-bảng-ghi-kết-quả-thăm-dò),
  không PASS/FAIL.
- **⚠️ Phụ thuộc gap mở** — case có thể đổi kết quả mong đợi sau khi dev trả lời gap tương ứng (mục 10 test
  plan). Chạy và ghi nhận thực tế, không tự suy đoán câu trả lời.
- **Ảnh bằng chứng khi chạy case:** lưu vào [`screenshots/`](screenshots/) (đã có sẵn thư mục con theo từng
  nhóm: INS/OLD/HS/OWN/PAIR/WARN/AUTO/XVER/TRIG) — xem quy ước đặt tên + bảng log kết quả ở
  [screenshots/README.md](screenshots/README.md).
- Mọi case mặc định chạy trên **Ink Dev** dựng từ nhánh `fix/ios27-shortcut-automation`, file `Dev` trong
  [test-data/ink-shortcut-final/](../../test-data/ink-shortcut-final/).

---

## 1 · Nền tảng — Cài đặt & chuyển đổi nhiều shortcut · `TC-SH-INS` (mục 3 nguồn)

> Chạy nhóm này **trước tiên** trên mỗi máy — nếu sai, kết quả mọi nhóm sau không đáng tin (test plan mục 2).

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| INS-01 | Máy iOS 26, cài `iOS 26/Dev` qua AirDrop → Add Shortcut | Tên đúng `Ink Refresh Lock Screen`; mở shortcut thấy **5 action "Set Wallpaper"** (1 cho Lock ở đầu, 4 cho Home trong khối If/Otherwise), không action nào màu đỏ | P1 |
| INS-02 | Máy iOS 27, cài `iOS 27/Dev` qua AirDrop → Add Shortcut → mở shortcut → ⓘ → Privacy → bật **Allow Running When Locked** | Như INS-01, thêm bước bật toggle thành công (toggle này không đi theo file) | P1 |
| INS-10 | 🔴 Sau INS-01/INS-02 — mở shortcut, tìm action **"Switch Between Wallpapers"** gần cuối | Ô cặp wallpaper hiện đúng biến **`Wallpaper`** (kết quả của action Set đầu tiên). Nếu ô **trống**, hoặc khi chạy shortcut **hiện popup bắt chọn wallpaper** → **báo ngay, lỗi chặn phát hành** | **P1** |
| INS-03 | Lần chạy đầu tiên (trigger từ app, xem TC-SH-TRIG-02) | Hộp thoại hỏi quyền đặt wallpaper → chọn **Always Allow** → shortcut chạy xong | P1 |
| INS-04 | Đổi tên shortcut A đang chạy (`Ink Refresh Lock Screen`) sang tên riêng theo bảng quy ước mục 3.2 → đổi tên shortcut B sang `Ink Refresh Lock Screen` → bấm **Update** trong app | Shortcut B chạy (phân biệt qua Home Screen mode nếu A/B khác loại) | P1 |
| INS-05 | **Không** đổi tên shortcut cũ trước → cài thêm 1 file mới khi đã có shortcut tên `Ink Refresh Lock Screen` | Ghi lại iOS hỏi **Replace** hay thêm bản số `1` — xem Decision Table 2 (mục 5 test plan) | P2, ⚠️ gap #6 |
| INS-06 | Đổi tên shortcut cũ trước (đúng quy trình mục 3.2 bước 1) → cài thêm 1 file mới | Không xung đột, 2 shortcut cùng tồn tại với tên khác nhau | P2 |
| INS-07 | 🔴 Cố tình để **2 shortcut cùng tên** `Ink Refresh Lock Screen` cùng lúc → bấm Update trong app | Ghi nhận app chạy shortcut nào (note tự nói "không đoán trước được") — **không log bug** dù không nhất quán; **dừng ngay mọi case khác** theo Suspension criteria (mục 8.1 test plan), đổi tên lại trước khi tiếp tục | P1 (an toàn quy trình) |
| INS-08 | Trên iOS 27, có ≥2 shortcut (1 cái không dùng còn giữ automation Sunrise bật) | Verify đã **tắt automation Sunrise của shortcut không dùng** (Edit → Automation) — tránh 2 automation ghi đè nhau | P2 |
| INS-09 | Sau INS-04, bấm Update trong app | Đúng shortcut vừa đổi tên chạy, verify qua Home Screen mode (shortcut production không hiểu mode này, shortcut mới thì có) | P1 |

---

## 2 · P1 — Luồng set wallpaper cũ không vỡ · `TC-SH-OLD` (mục 4 nguồn)

> Để Home Screen = **Off** cho toàn bộ nhóm này (theo đúng yêu cầu note gốc). Note tự xếp đây là mảng **rủi ro
> cao nhất**. 6 case dưới khớp đúng 6 dòng checklist mục 4 nguồn — không thêm/bớt.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| OLD-01 | Discover → chọn 1 template → **Set as current** | Shortcut chạy → lock đổi đúng template → app quay lại → template hiện nhãn đang dùng | P1 |
| OLD-02 | Mở template đang dùng → sửa nội dung → **Update** | Lock đổi theo đúng nội dung mới | P1 |
| OLD-03 | Lần chạy đầu, hộp thoại hỏi quyền → chọn **Don't Allow** → mở lại app | App **không** coi là đã set thành công (không hiện nhãn đang dùng cho template mới) | P1 |
| OLD-04 | Đổi tên shortcut `Ink Refresh Lock Screen` sang tên khác (coi như xoá) → bấm **Set** trong app | App nhận ra không còn shortcut, đưa vào luồng cài đặt, **không kẹt** ở màn Shortcuts. Đổi tên lại để tiếp tục | P1 |
| OLD-05 | Spotlight: gõ "Ink" → chọn **Refresh Lock Screen** | Wallpaper đổi, **không** mở app | P1 |
| OLD-06 | Lặp lại OLD-01/OLD-02 với template loại **Note** và template loại **lịch** | Cả 2 loại đều set được như OLD-01/02 | P1 |

---

## 3 · P2 — Bốn chế độ Home Screen × Blur · `TC-SH-HS` (mục 5 nguồn, Decision Table 1)

### Trình tự chạy 1 lượt hết cả 7 dòng (không cần vào/ra editor lại từ đầu mỗi lần)

**Chuẩn bị 1 lần:** đã xong nhóm INS (shortcut đúng tên, đã Always Allow — INS-03) · chọn **1 template có lịch**
dùng xuyên suốt cả 7 dòng (không đổi template giữa chừng, để không lẫn biến "đổi template") · Own photo đã
**chọn sẵn 1 ảnh từ trước** (như OWN-01) để không rơi vào case "chưa chọn ảnh" (đó là case OWN-06 riêng) · đếm
**số cặp wallpaper hiện tại** trước khi bắt đầu, ghi lại làm baseline N (dùng chung luôn cho PAIR-03).

1. Mở template → **Editor → tab Background → mục Home Screen**.
2. **DT1-01 (Off):** chọn Off → **Set as current** (lần đầu, chưa có gì để Update) → khoá máy, chụp Lock → mở
   khoá, chụp Home → đếm lại số cặp (kỳ vọng vẫn N).
3. Quay lại editor (không thoát app, chỉ mở lại) → chọn **Same, Blur tắt** → **Update** → khoá/mở khoá, chụp cả
   2 màn → **DT1-02**.
4. **Chỉ bấm toggle Blur** (không đổi mode) → **Update** → chụp cả 2 màn → **DT1-03**.
5. Chọn **Photo only, Blur tắt** → **Update** → chụp cả 2 màn → **DT1-04** (nhân tiện kéo thanh **Darken** của
   lock lên cao nhất trước khi Set ở bước này → gộp luôn HS-09 vào đây, không cần chạy riêng).
6. Bật Blur → **Update** → chụp cả 2 màn → **DT1-05**.
7. Chọn **Own photo** (ảnh đã chọn sẵn từ bước chuẩn bị), Blur tắt → **Update** → chụp cả 2 màn → **DT1-06**.
8. Bật Blur → **Update** → chụp cả 2 màn → **DT1-07** → đếm cặp lần cuối (kỳ vọng vẫn = N sau đủ 4 mode) —
   **đúng lúc này cũng chốt luôn kết quả PAIR-03** (test plan mục 6, TC-SH-A2), không cần chạy lại chuỗi riêng.

**Gộp thêm 3 case phụ ngay trong lúc chạy 8 bước trên, không cần lượt riêng:**
- **HS-08** (Blur chỉ hiện khi khác Off): quan sát ở bước 2 — toggle Blur phải **không** hiện khi đang Off; từ
  bước 3 trở đi phải **hiện**.
- **HS-09** (Darken không ảnh hưởng Home): đã gộp vào bước 5 ở trên.
- **HS-11** (đếm số lần hỏi quyền): không cần chạy thêm — chỉ cần **để ý đếm** mỗi lần bấm Set/Update ở cả 8
  bước, ghi vào bảng thăm dò mục 11 của V2.

**2 case KHÔNG gộp được, chạy riêng sau khi xong chuỗi 8 bước:**
- **HS-10** (multi-day template) — cần đổi sang 1 template khác có nhiều ảnh nền đổi theo ngày, không dùng
  chung template ở trên.
- **HS-12** (Cancel giữ nguyên state) — làm **sau cùng**: mở lại editor, đổi thử 1 mode khác, bấm ✕ thoát, mở
  lại — phải thấy mode quay về đúng Own photo + Blur bật (state cuối cùng đã Set ở bước 8).

**Mẹo chụp Home Screen:** icon app che 1 phần ảnh nền — gạt sang 1 trang Home Screen **trống icon** (hoặc
widget page) để nhìn rõ ảnh, thay vì chụp trang chính đầy icon.

| ID | Chế độ | Blur | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|---|---|:---:|
| HS-01 | Off | — | Editor → Background → Home Screen → chọn Off → Set/Update | Lock: wallpaper có lịch · Home: **không bị Ink set** | P1 |
| HS-02 | Same | Tắt | Chọn Same, Blur tắt → Set/Update | Lock: có lịch · Home: cùng ảnh có lịch, **nét** | P2 |
| HS-03 | Same | Bật | Chọn Same, Blur bật → Set/Update | Lock: có lịch, **vẫn nét** · Home: cùng ảnh có lịch, **mờ** | P2 |
| HS-04 | Photo only | Tắt | Chọn Photo only, Blur tắt → Set/Update | Lock: có lịch · Home: ảnh nền, không lịch, **không tối** dù Darken kéo cao | P2 |
| HS-05 | Photo only | Bật | Chọn Photo only, Blur bật → Set/Update | Lock: có lịch, **vẫn nét** · Home: ảnh nền không lịch, **mờ** | P2 |
| HS-06 | Own photo | Tắt | Chọn Own photo (đã có ảnh), Blur tắt → Set/Update | Lock: có lịch · Home: ảnh đã chọn | P2 |
| HS-07 | Own photo | Bật | Chọn Own photo, Blur bật → Set/Update | Lock: có lịch, **vẫn nét** · Home: ảnh đã chọn, **mờ** | P2 |
| HS-08 | — | — | Mở editor, thử từng mode | Toggle **Blur Home Screen** chỉ hiện khi mode **khác Off** | P2 |
| HS-09 | Photo only | — | Kéo thanh **Darken** của lock lên cao nhất | Home **không bị tối theo** — độc lập với Darken của lock | P2 |
| HS-10 | Photo only | — | Dùng template có **nhiều ảnh nền đổi theo ngày** | Photo only dùng đúng ảnh của **hôm nay**, trùng ảnh dưới lịch trên lock | P2 |
| HS-11 | Same / Photo only / Own photo | — | Chạy Set/Update, đếm số lần hộp thoại quyền xuất hiện | **Ghi lại** có bị hỏi quyền 2 lần không (2 action Set trong 1 lần chạy) — V2 mở rộng thêm mode Same so với bản trước | 🔭, ⚠️ gap #1 |
| HS-12 | Bất kỳ | — | Đổi mode trong editor → bấm **✕ (Cancel)** thoát → mở lại editor | Mode **quay về đúng trạng thái trước khi mở** editor | P3 |

---

## 4 · P1 — Own photo · `TC-SH-OWN` (mục 6 nguồn)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| OWN-01 | Chế độ Own photo → ô **Add** → chọn ảnh từ Photos | Ảnh được chọn cho home **và** xuất hiện ở hàng ảnh nền của lock phía trên | P2 |
| OWN-02 | Chọn 1 ảnh **đã tải lên trước đó** | Ảnh được chọn (có viền) | P2 |
| OWN-03 | Chọn 1 ảnh **catalog** | Hiện vòng xoay tải → được chọn → Set → home đúng ảnh đó | P2 |
| OWN-04 | Đã chọn ảnh A → đổi sang **template khác** → Set | Home **vẫn giữ** ảnh A (setting chung, không theo template) | P2 |
| OWN-05 | Chuyển sang Photo only rồi quay lại Own photo | Ảnh cũ (A) **vẫn được chọn sẵn**, không phải chọn lại | P2 |
| OWN-06 | Own photo nhưng **chưa chọn ảnh nào** → Set | Home nhận **ảnh nền của lock** (không lịch) — **không bao giờ** là màn trống/đen | P1 |
| OWN-07 | Đóng app hẳn, mở lại sau **1 ngày** → Set lại | Ảnh home **vẫn còn** (không bị dọn file "ảnh không dùng khi khởi động") | P1 |
| OWN-08 | Test với ảnh **dọc**, **ngang**, **vuông** | Home phủ kín màn, căn giữa, **không méo** ở cả 3 | P2 |

---

## 5 · Cặp wallpaper · `TC-SH-PAIR` (mục 7 nguồn — V2 đã giải thích cơ chế, không còn thuần thăm dò)

> **Cơ chế (V2):** action Set đầu tiên ghi ảnh lock vào **cặp riêng của Ink** (lần chạy đầu iOS tạo cặp mới, các
> lần sau ghi lại đúng cặp đó). Các action Set cho home ghi vào **cùng cặp đó** qua biến `Wallpaper`. Action
> **Switch** luôn chuyển màn khoá sang cặp đó — **mỗi lần chạy, màn khoá luôn hiện cặp của Ink**, kể cả khi
> trước đó đang ở cặp khác. Ink **không bao giờ ghi đè** lên cặp của user, chỉ chuyển màn khoá khỏi cặp đó.
> 🔧 **Đảo ngược so với V1 (đã superseded):** V1 từng liệt "Ink không tự kéo màn khoá về" là hành vi đúng — sai,
> xem PAIR-04 dưới đây.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| PAIR-01 | Chuyển lock sang 1 cặp **ảnh riêng** của bạn, đếm số cặp. Cài shortcut, bấm **Set** trong app | Màn khoá **chuyển sang cặp mới** và hiện lịch? Số cặp **tăng đúng một**? Chuyển lại cặp ảnh riêng: ảnh **vẫn nguyên**, **không** bị thay bằng lịch? — cả 3 ý đều kỳ vọng **Có** | **P1** |
| PAIR-02 | Bấm **Update 3 lần liên tiếp** (không đổi gì khác) | Số cặp **không đổi** sau cả 3 lần | P2 |
| PAIR-03 | Chạy lần lượt đủ 4 chế độ: Off → Same → Photo only → Own photo. Sau **mỗi lần**, đếm số cặp trong thư viện | **KHÔNG tăng cặp mới** — chỉ ghi vào đúng 1 cặp có sẵn của Ink. Chế độ nào tạo thêm 1 cặp mới → **báo ngay, lỗi chặn phát hành** | **P1** |
| PAIR-04 | 🔧 Chuyển màn khoá sang 1 cặp **khác** cặp của Ink → bấm **Update** | Màn khoá **tự quay về cặp của Ink** (không cần chuyển tay lại) — lịch là bản mới nhất. **Đã đảo ngược so với V1** | P2 |
| PAIR-05 | Xoá **chính** cặp của Ink (giữ tay màn khoá → vuốt lên → thùng rác) → bấm **Update** | iOS tạo cặp mới **và chuyển sang cặp đó luôn**, **không** báo lỗi "Unable to switch". Chạy thêm **2 lần** nữa → số cặp **không tăng tiếp** | P2 |
| PAIR-06 | *(spot-check, đã xác nhận trên máy — không cần test lại)* Xoá 1 cặp **khác** cặp Ink → chạy shortcut | Shortcut vẫn ghi đúng cặp của Ink (số hiển thị tự đổi, vd 6→5) | P3 |

> 🆕 **PAIR-07 đến PAIR-09 (bổ sung 2026-09-22) — chưa có trong V2 hay bất kỳ tài liệu nào đã dùng.** Khác
> PAIR-04 (chuyển sang **cặp khác**, tức đổi cả Lock+Home sang 1 wallpaper library entry khác), 3 case này test
> việc user **tự sửa nội dung Home Screen ngay trong CHÍNH cặp của Ink** — qua Settings → Wallpaper hoặc
> giữ tay Home Screen → Customize (không qua app Ink) — rồi chạy lại shortcut. Đây là đường **hoàn toàn khác**
> với việc đổi cặp: không có `Set` nào của Ink chạm tới nếu mode = Off (theo cây logic đã giải mã ở mục "Cấu
> trúc thật của shortcut" trong test plan), nhưng **sẽ bị ghi đè** nếu mode khác Off.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| PAIR-07 | Mode **Off** đã Set trước đó → vào **Settings → Wallpaper** (hoặc giữ tay Home Screen → Customize), đổi ảnh Home Screen sang ảnh **bất kỳ không qua Ink** → quay lại Ink, bấm **Update** (mode vẫn Off) | Home Screen **giữ nguyên ảnh user vừa tự chọn**, **không** bị Ink ghi đè — đúng lời hứa cốt lõi của mode Off (không có action Set nào chạy cho Home khi Off) | **P1** |
| PAIR-08 | Mode **Same/Photo only/Own photo** bất kỳ đã Set trước đó → tự đổi ảnh Home Screen qua Settings (không qua Ink) → quay lại Ink, bấm **Update** (không đổi mode) | Home Screen bị **ghi đè trở lại đúng nội dung theo mode đang chọn** (không phải ảnh user vừa tự chọn) — đúng thiết kế vì mode này Ink chủ động quản lý Home. Không lỗi, không dialog lạ, **Lock Screen không bị ảnh hưởng** | P2 |
| PAIR-09 | 🔴 Mode **Same/Photo only/Own photo**, iOS 27, automation Sunrise đã bật đúng (`Allow Running When Locked`) → buổi tối tự đổi Home Screen qua Settings → khoá máy qua đêm, **không mở app Ink** | Sáng hôm sau automation chạy → Home bị ghi đè **âm thầm** trở lại nội dung Ink, **không có bất kỳ cảnh báo nào** báo user biết Home vừa bị đổi lại. **Không tự log là bug** (đúng thiết kế theo mode đã chọn) — nhưng đây là nguồn phàn nàn thật tiềm ẩn ("wallpaper tự đổi qua đêm"), nên hỏi dev/PO có cần thông báo cho user trước khi automation ghi đè hay không | **P1** *(rủi ro UX cao, xảy ra âm thầm không qua tương tác nào của user)* |

---

## 6 · P2 — Cảnh báo "Needs the new Ink shortcut" · `TC-SH-WARN` (mục 8 nguồn, Decision Table 3)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| WARN-01 | Đổi tên để app chạy **shortcut production** (máy chưa từng chạy shortcut mới) → editor → chọn Same/Photo only/Own photo | Cảnh báo vàng **hiện** | P2 |
| WARN-02 | Đổi tên để app chạy **shortcut mới**, bấm Update **1 lần** → đóng rồi mở lại editor | Cảnh báo vàng **biến mất** | P2 |
| WARN-03 | Với shortcut production, chọn Photo only rồi Set | Production **không hiểu** mode này — vẫn set cả lock+home bằng ảnh lịch + blur như cũ. **Đúng dự kiến, không log bug** | P3 |
| WARN-04 | Bất kỳ shortcut nào, mode = **Off** | Cảnh báo **không áp dụng/không hiện** | P3 |

---

## 7 · Automation iOS 27 · `TC-SH-AUTO` (mục 9 nguồn — thăm dò, trừ case có kỳ vọng rõ)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| AUTO-01 | Sau khi cài `iOS 27/Dev` (INS-02) → mở shortcut → Edit → Automation | **Phải ghi lại:** có automation **Sunrise** không? Đang bật hay tắt? | 🔭 |
| AUTO-02 | Ngay sau khi cài, **trước khi** tự bật gì | **Phải ghi lại:** `Allow Running When Locked` đang bật hay tắt theo mặc định | 🔭 |
| AUTO-03 | Để automation Sunrise chạy lần đầu | **Phải ghi lại:** có xin quyền **vị trí** không? | 🔭 |
| AUTO-03b | Nếu AUTO-03 có xin quyền vị trí → chọn **từ chối** | **Phải ghi lại:** automation dừng hẳn hay fallback về giờ khác? | 🔭, ⚠️ gap #5 |
| AUTO-04 | `Allow Running When Locked` **đã bật** (đúng INS-02) → để máy **khoá** qua đêm | **Kỳ vọng rõ:** wallpaper **phải** tự đổi sáng hôm sau, **không** hỏi xác nhận gì — đây là mục tiêu cốt lõi của tính năng | **P1** |
| AUTO-04b | 🔴 Cố tình **để tắt** `Allow Running When Locked` (tái lập lỗ hổng cũ SCT-E01/BUG-004) → khoá máy qua đêm | **Kỳ vọng:** nếu wallpaper không đổi, Ink phải có cách phát hiện/cảnh báo — "hỏng im lặng" không cảnh báo gì là **bug thật**, không phải hành vi chấp nhận được | **P1** |
| AUTO-05 | *(chỉ khi cần rút ngắn — xem Suspension criteria mục 8.1 test plan)* Đổi tạm trigger sang Time of Day 2–3 phút tới → khoá máy → chờ → kiểm tra → đổi lại Sunrise | Dùng thay AUTO-04 khi không đợi được qua đêm; nếu nghi việc đổi giờ/trigger tự làm gãy automation → dừng, dùng lại AUTO-04 qua đêm thật | P2 |
| AUTO-06 | Sau khi automation chạy lúc khoá máy, mở app | **Không** hiện cảnh báo "automation không chạy" ở Home/Settings (vì đã chạy đúng) | P2 |
| AUTO-07 | Cài lại **cùng file** `iOS 27/Dev` lần nữa | **Phải ghi lại:** có sinh automation **trùng** không? | 🔭 |
| AUTO-08 | Máy thứ 2, **Apple Account khác** → cài file `iOS 27/Dev` | **Phải ghi lại:** có automation Sunrise không, bật hay tắt theo mặc định? | 🔭 |
| AUTO-09 | *(regression BUG-004)* Bật Google Calendar sync → tạo 1 event mới trực tiếp trên Google Calendar → chờ automation Sunrise chạy → xem wallpaper | Event mới **phải xuất hiện** trên wallpaper hôm sau — chạy lại kịch bản [BUG-004](../../../bugs/bug-log.md#bug-004--event-tạo-trên-google-calendar-không-xuất-hiện-trên-wallpaper-hôm-sau) trên trigger Sunrise mới, không coi là đã đóng | **P1** |

---

## 8 · Chéo phiên bản · `TC-SH-XVER` (mục 10 nguồn, đã cập nhật theo ghi chú dev)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| XVER-01 | Máy **iOS 27** (đã cài Ink) → cài thêm file `iOS 26/Dev` → chạy trực tiếp (TRIG-01) | Cài được, action chạy bình thường (tương thích ngược) — theo scope dev xác nhận | P2 |
| XVER-02 | Cùng máy iOS 27 → chạy file `iOS 27/Dev` (native) | Đối chiếu kết quả với XVER-01 — không có khác biệt bất thường ngoài phần automation (chỉ iOS 27 mới có) | P2 |
| XVER-03 | *(tuỳ chọn, không bắt buộc theo scope dev)* Máy **iOS 26** → thử cài file `iOS 27/Dev` | **Phải ghi lại:** cài được không? Nếu được, action có chạy bình thường không (automation mong đợi bị bỏ qua)? **Không log bug** nếu lỗi/không cài được — nghi vấn `MinimumClientVersionString` chặn hướng này (gap #7) | 🔭, ⚠️ gap #7 |

---

## 9 · Luồng kích hoạt & yêu cầu đổi tên · `TC-SH-TRIG` (Decision Table 4, cross-cutting)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TRIG-01 | Bấm **thẳng vào thẻ shortcut** trong app Shortcuts (không đổi tên trước) | Shortcut chạy đúng, **không phụ thuộc** tên hiện tại — dùng để cô lập lỗi (shortcut hay cơ chế dò tên của Ink) | P2 |
| TRIG-02 | Đổi tên shortcut muốn test về `Ink Refresh Lock Screen` → bấm **Set/Update trong Ink** | Đúng shortcut đó chạy — Ink gọi theo tên | P1 |
| TRIG-03 | Có shortcut **không** mang tên `Ink Refresh Lock Screen` (đã đổi đi test cái khác) → dùng **Spotlight** "Refresh Lock Screen" | **Phải ghi lại:** có chạy được không, chạy đúng shortcut nào? | 🔭, ⚠️ gap #8 |
| TRIG-04 | Shortcut đã bị đổi tên khỏi `Ink Refresh Lock Screen`, nhưng automation Sunrise của nó vẫn còn bật → để automation tự chạy theo giờ | **Phải ghi lại:** automation chạy đúng shortcut gốc (gắn theo ID, không theo tên) hay không chạy/chạy nhầm? | 🔭, ⚠️ gap #8 |

---

## 10 · Regression (tham chiếu, không viết lại case)

| Nhóm | Phạm vi | Nguồn |
|---|---|---|
| Happy path cũ | SCT-H01–H19 chạy lại **trên shortcut mới** | [exploratory/03_shortcut-setup.md §1](../../exploratory/03_shortcut-setup.md#1--happy-path--sct-h) |
| Permission cũ | SCT-N01–N05 (3-dialog D1/D2/D3) chạy lại **trên shortcut mới** — không kế thừa kết luận cũ vì số action đã đổi 1→5 (+1 Switch) | [exploratory/03_shortcut-setup.md §2](../../exploratory/03_shortcut-setup.md#2--negative--ba-dialog-quyền--sct-n01n05) |
| BUG-004 | Xem AUTO-09 ở trên — đã tích hợp vào nhóm Automation, không tách case riêng | [bugs/bug-log.md § BUG-004](../../../bugs/bug-log.md#bug-004--event-tạo-trên-google-calendar-không-xuất-hiện-trên-wallpaper-hôm-sau) |

---

## 11 · Traceability — đối chiếu với ID rủi ro P1 ở test plan (mục 6)

| ID rủi ro (test plan) | Case cụ thể ở đây |
|---|---|
| TC-SH-A1 | TC-SH-OLD-01 … OLD-06 |
| TC-SH-A2 | TC-SH-PAIR-03 |
| TC-SH-A3 | TC-SH-OWN-07, TC-SH-PAIR-06 |
| TC-SH-A4 | TC-SH-OWN-06 |
| TC-SH-A5 | TC-SH-AUTO-04, TC-SH-AUTO-04b |
| TC-SH-A6 | TC-SH-OLD-04 |
| TC-SH-A7 🔧 (mới, từ V2) | TC-SH-INS-10 |
| TC-SH-A8 🆕 (QC tự phát hiện) | TC-SH-PAIR-07 |
| TC-SH-A9 🆕 (QC tự phát hiện) | TC-SH-PAIR-09 |
