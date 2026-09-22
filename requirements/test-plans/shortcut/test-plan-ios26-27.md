# Test Plan — Shortcut wallpaper mới: Home Screen (iOS 26) và Automation (iOS 27)

> **Test basis:** [qc-shortcut-home-screen-ios26-27-V2.md](../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2.md)
> — bàn giao QC bản **V2** (nguồn sự thật duy nhất), nhánh `fix/ios27-shortcut-automation`, **chưa vào `main`**,
> test trên **Ink Dev** dựng từ nhánh này bằng Xcode — không phải bản TestFlight/App Store. Commit cụ thể
> **chưa được V2 xác nhận lại** (bản V1 từng ghi `abcd305a` nhưng V1 đã bị thay thế — không dùng số commit đó
> làm căn cứ, hỏi lại dev nếu cần chốt build chính xác).
> **⚠️ Bản V1 của tài liệu này đã bị thay thế do sai sót** — xem
> [qc-shortcut-home-screen-ios26-27-V1-SUPERSEDED.md](../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V1-SUPERSEDED.md)
> chỉ để biết lịch sử đã sai gì, **không dùng làm test basis**. Diễn giải đầy đủ các sai sót đã sửa — xem mục
> "V2 thay thế V1" ngay dưới đây.
> **Đối chiếu với tài liệu đã có (không liên quan sai sót V1, vẫn còn giá trị):**
> [exploratory/03_shortcut-setup.md](../../exploratory/03_shortcut-setup.md) (checklist SCT, build 1.2.10 (27),
> viết cho shortcut **cũ** — 1 action Set Wallpaper duy nhất, tên `Generate Latest Wallpaper`),
> [wideframes/03_shortcut-setup.md](../../ui/ux/wideframes/03_shortcut-setup.md),
> [references/shortcut-flow-cases.md](../../../references/shortcut-flow-cases.md) (10 mắt xích + cây chẩn
> đoán), [bugs/bug-log.md § BUG-004](../../../bugs/bug-log.md#bug-004--event-tạo-trên-google-calendar-không-xuất-hiện-trên-wallpaper-hôm-sau)
> (event Google Calendar thiếu trên wallpaper — root cause nghi ở automation chạy nền/máy khoá),
> [1.2.15-decoration-inkai.md](../1.2.15-decoration-inkai.md) (xác nhận tên shortcut cũ `Generate Latest
> Wallpaper` là ngoại lệ l10n giữ tiếng Anh).
> **File shortcut thật để cài lên máy test:**
> [test-data/ink-shortcut-final/](../../test-data/ink-shortcut-final/) — đủ 4 file đúng như mục 1 của V2
> (`iOS 26/Dev`, `iOS 26/Prod`, `iOS 27/Dev`, `iOS 27/Prod`, cùng tên `Ink Refresh Lock Screen.shortcut`). **Đây
> là bộ file đã sửa** (dev gọi là `Ink Shortcut Final 2`), khác hẳn bộ cũ về checksum/kích thước — bộ cũ hiện ở
> [test-data/ink-shortcut-final-v1-superseded/](../../test-data/ink-shortcut-final-v1-superseded/), **không dùng
> để cài lên máy test**. Đợt test này **chỉ dùng 2 file `Dev`** (xem mục 3, 7).
> **Chuẩn:** ISTQB Foundation Level (test basis → test object → kỹ thuật thiết kế → rủi ro → entry/exit)
> **Test case cụ thể:** [test-cases-ios26-27.md](test-cases-ios26-27.md) — thiết kế trực tiếp từ các kỹ thuật ở
> mục 5 dưới đây (Decision Table 1–4, BVA, Exploratory charter); **đang được cập nhật theo V2**, xem ghi chú ở
> đầu file đó.
> **Ngày lập:** 2026-09-21 · **Cập nhật theo V2:** 2026-09-21 · **Người lập:** QC

> ⚠️ Bản thân V2 tự khai mục 4, 5, 6 (theo thứ tự liệt kê "Bảy mảng cần test") là **thăm dò** — không ai biết
> trước kết quả đúng. Nhưng khác V1, V2 đã **giải thích cơ chế cặp wallpaper cụ thể** (mục 7) nên phần lớn case
> ở đó nay có kỳ vọng rõ ràng, chỉ còn vài điểm thật sự mở — xem mục 5 (Exploratory) và mục 6 (risk) cập nhật.

---

## V2 thay thế V1 — các sai sót đã sửa (bổ sung 2026-09-21)

> Dev bàn giao lại toàn bộ note vì V1 có sai sót — **cả tài liệu lẫn chính file `.shortcut`** (khác checksum,
> khác kích thước, xem [test-cases-ios26-27.md](test-cases-ios26-27.md) mục ghi chú đầu file). Bảng dưới đối
> chiếu từng điểm, để không ai vô tình quay lại dùng thông tin V1 đã sai.

| Chủ đề | V1 (sai, đã bỏ) | V2 (đúng, dùng từ giờ) |
|---|---|---|
| Số action Set Wallpaper | "6 action" | **5 action** (1 cho Lock, 4 cho Home) — **cộng thêm 1 action "Switch Between Wallpapers"** mà V1 hoàn toàn không nhắc tới |
| Cơ chế cặp wallpaper (mục 7) | "Một phần thăm dò — chưa ai biết trước kết quả đúng", không giải thích cơ chế | Giải thích rõ: action Set đầu ghi Lock vào **cặp riêng của Ink**; các action Set Home ghi vào **cùng cặp đó** qua biến `Wallpaper`; action **Switch** luôn chuyển màn khoá sang cặp đó |
| "Tự chuyển sang cặp khác rồi bấm Update" | Liệt ở mục 12 "**không phải bug**": *"Ink chỉ cập nhật cặp của nó và **không** tự kéo màn khoá về"* | **Đảo ngược hoàn toàn:** màn khoá **tự quay về cặp của Ink** sau mỗi lần chạy — đây mới là hành vi đúng thiết kế, kể cả khi chạy bằng automation lúc sáng |
| Vì sao Off không làm home đứng yên (mục 5) | Giải thích bằng "iOS tự ghép cặp lock+home" (lý thuyết, không có cơ chế cụ thể) | Giải thích bằng chính action Switch (mục 7) — Off vẫn chuyển màn khoá sang cặp Ink, home hiện ra phụ thuộc lịch sử set home của cặp đó, không phải "iOS tự ghép cặp" |
| Commit cụ thể | `abcd305a` | Không nhắc lại — coi là **chưa xác nhận**, không dùng số cũ |

**Case mới xuất hiện trong V2, không có ở V1:**
- Action **Switch Between Wallpapers**: sau khi cài, ô cặp wallpaper phải hiện biến `Wallpaper` (không trống,
  không popup bắt chọn) — **lỗi chặn phát hành nếu sai** (mục 3.1 V2).
- Bấm **Update 3 lần liên tiếp** (không đổi gì khác) → số cặp **không đổi**.
- **Xoá chính cặp của Ink** → bấm Update → iOS tạo cặp mới **và chuyển sang cặp đó luôn**, không báo lỗi
  "Unable to switch"; chạy thêm 2 lần → số cặp không tăng tiếp.

---

## Ghi chú làm rõ từ dev (bổ sung 2026-09-21)

> Dev tóm tắt 3 điểm qua trao đổi trực tiếp, ngoài nội dung note gốc. Ghi nguyên văn rồi diễn giải tác động —
> các mục liên quan trong test plan đã được cập nhật theo, đánh dấu 🔧 tại nơi thay đổi.

1. **"Test cài app trên iOS 26 → dùng shortcut của iOS 26, cài iOS 27 → chạy cả shortcut 26 và 27."** Diễn
   giải: ma trận thiết bị × file **không đối xứng** như note gốc mục 10 ngụ ý. Máy chạy **iOS 26** chỉ cần test
   với file `iOS 26/Dev`. Máy chạy **iOS 27** cần test với **cả 2 file** (`iOS 26/Dev` **và** `iOS 27/Dev`) —
   đây là hướng kiểm **tương thích ngược** (file cũ chạy trên OS mới), khác hẳn hướng note gốc mục 10 nêu ("cài
   file iOS 27 lên máy iOS 26" — tương thích xuôi, file mới trên OS cũ). 🔧 Cập nhật mục 2 (dòng #8), mục 4,
   mục 5 (Exploratory), mục 6 (P2), mục 7. Gián tiếp củng cố nghi vấn ở **gap #7** (mục 10) — nếu
   `MinimumClientVersionString` là ngưỡng version thật, hướng "file mới trên OS cũ" nhiều khả năng không chạy
   được, khớp với việc dev không đưa hướng đó vào scope test thực tế của mình.
2. **"Test click chạy shortcut trực tiếp thì không cần đổi tên."** Chạy shortcut bằng cách bấm thẳng vào thẻ
   shortcut trong app Shortcuts **không phụ thuộc** cơ chế dò theo tên (phát hiện #1, mục 1 dưới) — luồng này
   không cần rename shortcut về đúng tên `Ink Refresh Lock Screen` trước khi test.
3. **"Test trigger trong app thì đổi tên shortcut về `Ink Refresh Lock Screen` là được."** Ngược lại, khi test
   qua nút Set/Update **trong Ink** (Ink tự gọi shortcut), bắt buộc đổi tên đúng shortcut muốn test về
   `Ink Refresh Lock Screen` trước — đúng cơ chế đã nêu ở mục 3 note gốc và phát hiện #1 mục 1. 🔧 Cập nhật mục
   5 (Decision Table 4 mới), mục 8.1.

> ⚠️ **Chưa rõ Spotlight ("gõ 'Ink' → Refresh Lock Screen") và automation Sunrise có cần đúng tên hay không** —
> dev chỉ làm rõ 2 luồng "chạy trực tiếp" và "trigger trong app", chưa nói tới 2 luồng còn lại ở mục 4/9 note
> gốc. Ghi thành gap mới — xem mục 10, gap #8.

---

## Cấu trúc thật của shortcut — từ ảnh chụp Shortcuts app (bổ sung 2026-09-22)

> Nguồn: ảnh chụp màn hình editor thật của `Ink Refresh Lock Screen` (app Shortcuts), 4 ảnh nối tiếp khi cuộn
> hết shortcut. **Độ tin cậy cao hơn** phân tích nhị phân tĩnh ở phát hiện #8 (mục 1) — đây là nhìn trực tiếp
> vào cấu trúc thật, không phải suy đoán từ chuỗi byte. Vẫn có giới hạn: nhiều tên action bị Shortcuts cắt bớt
> (`...`), và **không có source code Swift** của Ink để đối chiếu — phần nào là suy đoán được đánh dấu rõ.

### A. Bốn action riêng của Ink — chưa từng được đặt tên trong V2 hay bất kỳ tài liệu nào trước đó

Icon lịch cam 📅 = App Intent riêng của Ink (không phải action hệ thống Shortcuts):

| Tên action | Vai trò suy ra |
|---|---|
| `Get Ink Wallpaper Mode` | Đọc chế độ Home Screen hiện tại → trả về **1 chuỗi text**, shortcut check bằng `contains` |
| `Generate Latest Wallpaper` | Sinh ảnh cho **Lock Screen** (có lịch) |
| `Generate Home Screen Wallpaper` | Sinh ảnh **riêng cho Home** (dùng cho Photo only/Own photo) |
| `Confirm Wallpaper Applied` | Action **cuối cùng**, chạy sau `Switch` — chưa hề được nhắc tới ở V2 |

### B. Luồng chạy đầy đủ (chắc chắn, đọc trực tiếp từ ảnh)

```
① Get Ink Wallpaper Mode          → Mode (chuỗi text)
② Generate Latest Wallpaper       → LockWallpaper
③ Set LockWallpaper cho Lock Screen        ← LUÔN chạy, không điều kiện (cặp "Wallpaper 9" trên máy chụp)

④ If Mode contains "pair":                 [suy đoán = Photo only HOẶC Own photo]
      Generate Home Screen Wallpaper → HomeWallpaper
      If Mode contains "blur":
          Set HomeWallpaper cho Home Screen   (mờ)
      Otherwise:
          Set HomeWallpaper cho Home Screen   (nét)
      End If
   Otherwise:
      If Mode contains "same":              [suy đoán = mode Same]
          If Mode contains "blur":
              Set LockWallpaper cho Home Screen   (mờ)
          Otherwise:
              Set LockWallpaper cho Home Screen   (nét)
          End If
      Otherwise:                            [suy đoán = Off — không pair, không same]
          (không action Set nào chạy cho Home)
      End If
   End If

⑤ Switch to Wallpaper             ← LUÔN chạy, kéo màn khoá về đúng cặp Ink
⑥ Confirm Wallpaper Applied       ← LUÔN chạy cuối
```

**Đối chiếu số lượng khớp chính xác với V2:** nhánh trên cho đúng **4 action Set cho Home** (2 dưới "pair" + 2
dưới "same") **+ 1 Set cho Lock = 5**, đúng số V2 công bố ở mục 1 ("5 action, 1 Lock + 4 Home") — không phải
trùng hợp, số đếm tự khớp là bằng chứng cấu trúc suy luận ở trên đúng.

### C. Mười bảy dòng ma trận V2 đi qua đúng những đường nào

| Mode UI | Blur | Đường đi (④) | Action Home thực thi | Kết quả Home (theo V2) |
|---|---|---|---|---|
| Off | — | not-pair → not-same | *(không có)* | Không bị Ink set |
| Same | Tắt | not-pair → same → not-blur | Set = LockWallpaper | Cùng ảnh lock, nét |
| Same | Bật | not-pair → same → blur | Set = LockWallpaper | Cùng ảnh lock, mờ |
| Photo only | Tắt | pair → not-blur | Generate Home Screen Wallpaper → Set | Ảnh nền riêng, nét |
| Photo only | Bật | pair → blur | Generate Home Screen Wallpaper → Set | Ảnh nền riêng, mờ |
| Own photo | Tắt | pair → not-blur | *(cùng 2 action với Photo only!)* | Ảnh đã chọn, nét |
| Own photo | Bật | pair → blur | *(cùng 2 action với Photo only!)* | Ảnh đã chọn, mờ |

### D. Phát hiện quan trọng nhất — Photo only và Own photo dùng chung 1 code path

Khác biệt giữa Photo only (ảnh nền template) và Own photo (ảnh user tự chọn) **không nằm ở tầng If/Otherwise
của shortcut** — cả hai đi qua **đúng 2 action Set** giống hệt nhau (nhánh `pair` × blur). Toàn bộ việc chọn
đúng ảnh nằm **bên trong** action `Generate Home Screen Wallpaper` (hộp đen phía Ink, tự biết mode con là gì).

**Hệ quả cho triage:** nếu 1 trong 2 mode (Photo only hoặc Own photo) hiển thị sai ảnh mà mode kia đúng, root
cause gần như chắc chắn nằm trong logic **chọn ảnh bên trong `Generate Home Screen Wallpaper`** (chọn nhầm
nguồn ảnh theo mode con), **không phải** ở cấu trúc If/Otherwise của shortcut (đã xác nhận 2 mode share chung).
Ngược lại, nếu **cả 2 mode cùng sai theo cùng 1 kiểu** (vd cả 2 đều không blur được dù đã bật) → nghi vấn nằm ở
action `Set` hoặc `LegibilityBlur` dùng chung, không phải logic chọn ảnh.

### E. Câu hỏi mở mới — giá trị chuỗi thật của `Get Ink Wallpaper Mode`

"pair", "blur", "same" là **chuỗi hardcode do người viết shortcut gõ tay** vào vế phải của `contains` — nhìn
thấy trực tiếp trên màn hình. Nhưng **vế trái** (giá trị Mode thật do `Get Ink Wallpaper Mode` trả về cho từng
1 trong 7 tổ hợp) do **code Swift bên trong app Ink** sinh ra — không có source code nên không đọc được, chỉ
suy ngược qua cách rẽ nhánh. Nếu format chuỗi sai/lẫn từ khoá giữa 2 mode (vd chuỗi vô tình chứa cả "same" lẫn
"pair"), nhiều nhánh có thể rẽ sai cùng lúc mà không action nào báo lỗi. → thêm **gap #9**, mục 10.

**Cách chốt chính xác 100% (2 hướng):**
1. Hỏi dev — họ có source code, biết ngay chuỗi thật.
2. Tự verify trên máy: thêm tạm 1 action `Show Result`/`Show Alert` ngay sau `Get Ink Wallpaper Mode`, chạy thử
   lần lượt cả 7 tổ hợp trong app Ink, ghi lại chuỗi thật mỗi lần → xoá action tạm trước khi dùng lại shortcut.

### F. Phân tích logic if/else thuần tuý (bổ sung 2026-09-22) — tách khỏi rủi ro runtime, chỉ xét cấu trúc

1. **Chỉ 3 nhánh thật, không phải 4.** If/else chỉ phân biệt `pair` / `same` / fallback — **không** tự phân biệt
   Photo only vs Own photo (cả 2 đi qua đúng nhánh `pair`, xem mục D). Nếu 1 trong 2 mode này hiển thị sai, cấu
   trúc rẽ nhánh **không có khả năng bắt lỗi đó** — chỉ phát hiện được bằng quan sát mắt.
2. **Thứ tự kiểm tra tạo ưu tiên ngầm, rủi ro nhiễm chéo bất đối xứng:** `pair` được check **trước** `same` →
   nếu chuỗi mode của **Same** vô tình chứa cả substring `"pair"`, Same sẽ **âm thầm** rơi vào nhánh Photo
   only/Own photo mà không action nào báo lỗi. Chiều ngược lại (chuỗi `pair` chứa `"same"`) **vô hại** vì `pair`
   được đọc trước. Rủi ro chỉ tồn tại **1 chiều**.
3. **Nhánh fallback (Off) là "ngầm định", không có điều kiện `contains "off"` tường minh.** Bất kỳ chuỗi nào
   **không chứa** `"pair"` và **không chứa** `"same"` đều rơi vào đây — gồm cả: đúng mode Off thật, chuỗi rỗng
   (`Get Ink Wallpaper Mode` lỗi/decode fail), hoặc chuỗi lạ hoàn toàn hỏng dữ liệu. **Cả 3 hiển thị giống hệt
   nhau** (Home không đổi) — không có tín hiệu nào phân biệt được "đúng là Off" với "lỗi đọc mode nhưng tình cờ
   trông giống Off".
4. **Câu hỏi chưa trả lời được:** nếu `Get Ink Wallpaper Mode` **throw lỗi** thay vì trả rỗng khi có sự cố, có
   thể toàn bộ shortcut dừng ngay từ bước ① — khi đó **Lock Screen cũng không được set**, nặng hơn nhiều so với
   giả định "tệ nhất chỉ Home không đổi" ở điểm 3.

**3 câu hỏi bổ sung vào gap #9 (mục 10), sắc hơn câu hỏi gốc:**
- Chuỗi mode của **Same** có bao giờ chứa substring `"pair"` không?
- `Get Ink Wallpaper Mode` khi lỗi thì **throw** hay **trả chuỗi rỗng**?
- Có cách nào phân biệt "Off thật" với "mode lỗi/rỗng" từ UI hoặc log không, hay 2 trường hợp **không thể**
  phân biệt được?

---

## 1. Phát hiện mới khi đối chiếu với tài liệu đã có

1. **Tên shortcut đổi hẳn — trả lời trực tiếp 1 câu hỏi mở cũ.** Shortcut cũ tên `Generate Latest Wallpaper`
   (ghi nhận ở [SCT-H03](../../exploratory/03_shortcut-setup.md), xác nhận lại ở
   [1.2.15-decoration-inkai.md](../1.2.15-decoration-inkai.md#8) là ngoại lệ l10n giữ tiếng Anh). Note mới đổi
   thành `Ink Refresh Lock Screen`, và tự nói rõ cơ chế: **app chạy shortcut theo tên khớp chính xác từng ký
   tự** (mục 3). Đây chính là câu trả lời cho **SCT-Q01** ("Ink dò shortcut bằng tên, ID, hay không dò gì cả?")
   — nhưng đồng thời **xác nhận rủi ro SCT-N27** (đổi tên shortcut → app mất dấu) là **có thật theo thiết kế**,
   không còn là giả thuyết. Hệ quả kéo theo: ngoại lệ l10n ở `1.2.15-decoration-inkai.md` đang neo vào tên cũ —
   cần xác nhận đã cập nhật sang `Ink Refresh Lock Screen` ở mọi ngôn ngữ, nếu chưa là doc nợ cần báo.
2. **Model 3-dialog quyền (D1/D2/D3, SCT-N01–N05) được xây cho 1 action Set Wallpaper — V2 có 5 action Set
   (1 Lock + 4 Home) cộng 1 action Switch Between Wallpapers, trong cùng 1 shortcut.** Toàn bộ kết luận
   permission cũ **không thể kế thừa nguyên trạng** — chính V2 cũng tự đặt câu hỏi này (mục 5, "mỗi lần chạy
   Same/Photo only/Own photo có bị hỏi quyền 2 lần không") và đưa vào bảng thăm dò mục 11. Bắt buộc re-run toàn
   bộ SCT-N01–N05 trên shortcut mới trước khi coi hành vi quyền là đã hiểu rõ.
3. **Automation đổi vị trí kiến trúc theo phiên bản iOS — không chỉ đổi giao diện.** Note mục 9: "Automation
   (iOS 26: trong tab Automation; iOS 27: nằm bên trong shortcut)". SCT-N21/N22 cũ ("xoá automation"/"tắt
   automation") giả định automation luôn là 1 thực thể tách rời trong tab riêng — với iOS 27, hành vi tương
   đương có thể là sửa chính file shortcut (Edit → Automation). **2 phiên bản cần 2 bộ case khác nhau** ở đúng
   điểm rủi ro nhất, không dùng chung 1 checklist như bản cũ.
4. **`Allow Running When Locked` (mục 3.1, chỉ iOS 27) là toggle hoàn toàn mới**, không có trong checklist SCT
   cũ. Nó nối thẳng vào **SCT-E01** (🔴 máy khoá lúc automation chạy — mức rủi ro cao nhất checklist cũ) và giả
   thuyết #3 của BUG-004 (Keychain `AfterFirstUnlockThisDeviceOnly` không đọc được nếu máy chưa mở khoá lần nào
   từ lúc khởi động lại). Toggle này nhiều khả năng **chính là** cơ chế sản phẩm giải quyết rủi ro đó — nhưng
   note tự cảnh báo "cài đặt này không đi theo file", nghĩa là mỗi lần cài mới đều phải bật tay, tạo nguy cơ
   tái lập đúng lỗ hổng cũ nếu quên bật. Phải test cả 2 chiều (xem TC-SH-A5 mục 6).
5. **Khái niệm "cặp wallpaper" (mục 7) chưa từng xuất hiện trong bất kỳ tài liệu SCT/wireframe/reference nào
   trước đó.** Model cũ coi wallpaper là "1 ảnh single set"; V2 lộ ra iOS quản lý theo **cặp** (lock + home), với
   cơ chế cụ thể: action Set đầu ghi Lock vào cặp riêng của Ink, action **Switch Between Wallpapers** luôn kéo
   màn khoá về đúng cặp đó sau mỗi lần chạy — giải thích lại đúng hiện tượng đã ghi nhận rời rạc trước đây ("Off
   vẫn làm home đổi theo lock") bằng một cơ chế xác định, không còn là quan sát ngẫu nhiên. 🔧 **Lưu ý quan
   trọng:** V1 (đã thay thế) từng liệt "Ink không tự kéo màn khoá về" vào mục "không phải bug" — **V2 đảo ngược
   hoàn toàn** kết luận này (màn khoá **có** tự quay về cặp Ink) — xem bảng đối chiếu ở đầu tài liệu ("V2 thay
   thế V1"). Không dùng lại câu kết luận cũ dưới bất kỳ hình thức nào.
6. **SCT-N09/N13 cũ (bỏ dở bước tạo automation, tưởng đã xong) có thể không còn áp dụng cho iOS 27.** File iOS
   27 "mang sẵn một automation: Sunrise" ngay khi cài — user không còn phải tự tạo automation qua S08→S09 như
   flow cũ. Nhưng file **iOS 26 vẫn "không có automation"** (mục 1 nguồn) — nghĩa là bước thủ công N09/N13
   **vẫn áp dụng nguyên cho iOS 26**, chỉ **biến mất cho iOS 27**. Đây là điểm dễ nhầm nhất khi viết case: 2
   phiên bản rẽ nhánh hẳn ở đúng bước rủi ro cao nhất của toàn flow.
7. **BUG-004 đáng được chạy lại, không coi là đã đóng.** Root cause nhóm A giả thuyết #1 (Google token bị thu
   hồi) không liên quan thay đổi lần này. Nhưng automation Sunrise (mục 9) đổi hẳn cơ chế trigger — "Time of
   Day" cố định → "lúc bình minh theo vị trí máy", **luôn chạy khi máy khoá** theo đúng mô tả note — cùng trục
   rủi ro với giả thuyết #3 (Keychain reboot) và toggle `Allow Running When Locked` mới. Khuyến nghị chạy lại
   nhanh kịch bản BUG-004 (tạo event Google Calendar, chờ Sunrise chạy) trên build này thay vì bỏ qua.
8. **Phân tích nhị phân tĩnh 4 file thật** (đọc byte, **không** mở/chạy qua `shortcuts` CLI của macOS — công cụ
   đó không phản ánh đúng hành vi vì đây là shortcut chỉ dành cho iOS). ⚠️ **Lần phân tích đầu tiên chạy trên bộ
   file V1 (nay đã superseded, checksum khác hẳn bộ V2 hiện dùng)** — 2 phát hiện dưới đây **đã re-verify lại
   trên bộ file V2 thật** (`test-data/ink-shortcut-final/`) và vẫn đúng; 1 phát hiện **không re-verify được**:
   - **Bundle ID Dev/Prod khác nhau thật (re-verify OK trên V2):** Dev = `com.silverai.calendar.lockscreen.dev`,
     Prod = `com.silverai.calendar.lockscreen` — vẫn thấy ở cả 2 file iOS 26 bản V2. Giải thích đúng cơ chế đứng
     sau câu "cài nhầm bản thì action hiện màu đỏ" (mục 1 V2) — action trỏ cứng vào bundle ID.
   - **Action Switch Between Wallpapers có dấu vết thật trong file (re-verify OK trên V2):** chuỗi `s.switch`
     (mảnh của identifier action Switch) xuất hiện ở cả 2 file iOS 26 bản V2 — khớp đúng phát hiện #5 và mục 7
     V2 (không có trong bộ V1 cũ).
   - **Không re-verify được trên V2:** khoá `MinimumClientVersionString` và trigger `sunrise` từng đọc được ở 2
     file iOS 27 bản V1 — thử lại trên 2 file iOS 27 bản V2 thì **không trích được chuỗi đọc được nào** (52
     token, toàn bộ thuộc phần chữ ký chứng chỉ). Đây **không phải bằng chứng** các khoá đó đã bị bỏ — chỉ là bộ
     nén nhị phân khác khiến kỹ thuật `strings` không còn may mắn bắt được đoạn text liền mạch. **Gap #7 (mục
     10) vì vậy vẫn mở, không thể tái khẳng định cũng không thể bác bỏ** bằng phương pháp này trên bộ file mới.

## 2. Test object — In scope

| # | Hạng mục | Nguồn (mục) | Ghi chú |
|---|---|---|---|
| 1 | Cài + chuyển qua lại nhiều shortcut bằng đổi tên | mục 3 | Nền tảng cho mọi mục khác — nếu sai, kết quả các mục sau không đáng tin |
| 2 | Luồng set wallpaper cũ không vỡ (Off mode) | mục 4 | Note tự xếp rủi ro cao nhất |
| 3 | 4 chế độ Home Screen × Blur (7 dòng ma trận) | mục 5 | Xem Decision Table 1, mục 6 |
| 4 | Own photo | mục 6 | Persist qua template, qua chế độ, qua restart |
| 5 | Cặp wallpaper 🔧 — V2 đã giải thích cơ chế (Set + Switch), phần lớn case nay có kỳ vọng rõ | mục 7 | Không còn thuần **thăm dò** như V1 — vẫn còn 1 dòng note tự đánh dấu "lỗi chặn phát hành" nếu sai (4 chế độ tạo thêm cặp) |
| 6 | Cảnh báo "Needs the new Ink shortcut" | mục 8 | |
| 7 | Automation iOS 27 (Sunrise) | mục 9 | **Thăm dò** |
| 8 | Chéo phiên bản 🔧 — máy **iOS 27** chạy cả file `iOS 26/Dev` **và** `iOS 27/Dev` (tương thích ngược) | mục 10 + ghi chú dev | **Thăm dò**; hướng "file iOS 27 trên máy iOS 26" mà note gốc mô tả không nằm trong scope dev xác nhận — xem gap #7 |

## 3. Out of scope

- **Shortcut production hiện tại** (link `199d89e6…`) — chỉ dùng để so sánh hành vi cũ ở mục 4/8, không test
  độc lập như một luồng riêng.
- **App Ink Prod trên App Store** — note tự xác nhận "chưa test được", bản Prod chưa có action mới.
- Nút **Add shortcut** trong luồng setup mở link production — note mục 12 đã xác nhận đây **không phải bug**.
- **Logic chọn event hiển thị trên wallpaper** (thuật toán chọn lịch) — chỉ liên quan việc *set đúng ảnh*, không
  phải *nội dung* ảnh, trừ phi để regression-check BUG-004 (mục 1, phát hiện #7).
- **Localization đầy đủ** cho chữ mới trong mục Home Screen — note mục 12 tự xác nhận "chỉ có tiếng Anh ở bản
  test, sẽ dịch trước khi phát hành" — không log gap l10n cho đợt test này.
- **Crop/căn khung ảnh Own photo** và **PRO gating cho ảnh catalog ở Home Screen** — note mục 12 xác nhận cả
  hai đều chưa làm ở bản test, không phải bug.

### 3.1 Ảnh hưởng chéo tới flow khác (regression impact ngoài phạm vi note)

> Đối chiếu [screenshot-naming.md §7](../../../.claude/rules/screenshot-naming.md#7-flow-map--ink-calendar-ios).

| Flow | Ảnh hưởng? | Lý do |
|---|---|---|
| `03_shortcut-setup` | **Trực tiếp** | Toàn bộ note nằm trong flow này |
| `04_discover` | **Gián tiếp** | Đường vào chỉnh Home Screen là editor của template (tab Background), và luồng "Set as current"/"Update" ở đây là thứ kích hoạt shortcut chạy |
| `10_lockscreen` | **Gián tiếp** | Kết quả cuối cùng (wallpaper thật) hiện ở đây; cần đối chiếu regression BUG-004 |
| `05_calendar` | **Gián tiếp** | Nguồn event cho wallpaper — regression BUG-004 chạm cả 2 flow |
| `09_settings` | **Gián tiếp** | Entry point "Set up shortcut" khác, cần verify đồng bộ ngưỡng/trạng thái với entry point từ Discover (theo đúng tiền lệ đã áp dụng ở [pr-218-225-test-plan.md §4.1](../pr-218-225-test-plan.md#41-ảnh-hưởng-chéo-tới-flow-khác-regression-impact-ngoài-phạm-vi-note)) |
| `08_paywall` | **Gián tiếp, nhẹ** | Ảnh catalog gắn nhãn PRO chọn được cho Home Screen dù chưa mua (note mục 12 xác nhận chưa chặn) — không log bug, chỉ ghi nhận |
| `06_task`, `07_note`, `01_onboarding`, `02_permission` | **Không ảnh hưởng** | Không entry point, không data pipeline dùng chung |
| `11_share`, `12_ai-assistant`, `13_community` | **Không áp dụng** | Chưa build (Phase 2) |

## 4. Test levels & types

- **Level:** System testing, black-box, trên **Ink Dev dựng từ Xcode** (branch `fix/ios27-shortcut-automation`)
  — **khác** entry criteria các test plan trước (thường dùng TestFlight); QC không có quyền vào code.
- **Functional:** 7 dòng ma trận Home Screen × Blur, persist Own photo, cảnh báo vàng đúng logic bật/tắt, chuỗi
  cài/đổi tên nhiều shortcut không đụng nhau.
- **Non-functional:**
  - **Compatibility:** iOS 26.x **và** iOS 27 bắt buộc cả hai. 🔧 Theo ghi chú dev: máy iOS 26 chỉ test file
    `iOS 26/Dev`; máy iOS 27 test **cả 2 file** `iOS 26/Dev` và `iOS 27/Dev` (tương thích ngược) — không phải
    hướng "file iOS 27 trên máy iOS 26" như note gốc mục 10 mô tả (xem gap #7). iPad nếu có sẵn máy (màn vuông,
    xoay ngang/dọc — xem gap #3 mục 11).
  - **Reliability:** automation Sunrise chạy đúng khi máy khoá qua đêm, không sinh automation trùng khi cài lại
    cùng file lần 2.
  - **Data integrity:** ảnh riêng của user (own photo lẫn cặp wallpaper riêng ngoài Ink) không bị ghi đè/xoá
    ngoài ý muốn — đây là loại risk **cao nhất** của toàn bộ mục 6/7.
  - **Multi-tenant/security nhẹ:** automation có "đi theo" đúng khi cài trên máy dùng Apple Account khác (mục 9
    cuối) — không rò automation của máy A sang máy B qua cùng 1 file.
  - **Usability:** chuỗi đổi tên qua lại giữa nhiều shortcut (mục 3.2) dễ gây nhầm lẫn với user không rành app
    Shortcuts — đánh giá độ rõ ràng của hướng dẫn.
- **Change-related (regression):** chạy lại tối thiểu phần happy-path và permission của checklist SCT cũ
  ([exploratory/03_shortcut-setup.md](../../exploratory/03_shortcut-setup.md) mục 1–2, tức SCT-H01–H19 và
  SCT-N01–N05) **trên shortcut mới**, không dựa vào kết luận cũ chưa re-verify (xem phát hiện #2, mục 1) +
  regression nhanh kịch bản BUG-004 trên automation Sunrise (phát hiện #7, mục 1).

## 5. Kỹ thuật thiết kế test case

- **Equivalence Partitioning:**
  - Chế độ Home Screen × Blur: {Off · Same+Blur off · Same+Blur on · Photo only+Blur off · Photo only+Blur on ·
    Own photo+Blur off · Own photo+Blur on} — 7 lớp hợp lệ, đúng bảng mục 5 nguồn (Off không có khái niệm Blur).
  - Trạng thái shortcut library khi cài mới: {chưa có shortcut nào tên `Ink Refresh Lock Screen` · đã có 1
    shortcut đang mang đúng tên đó · có nhiều shortcut khác tên (đã đổi tên theo mục 3.2)}.
  - Nguồn ảnh Own photo: {vừa chọn mới từ Photos · đã tải lên trước đó (có viền) · ảnh catalog (có vòng xoay
    tải)}.
  - Cặp wallpaper hiện tại khi cài mới: {đang ở cặp ảnh riêng của user · đang ở cặp của Ink · cặp của Ink đã bị
    xoá trước đó}.
- **Boundary Value Analysis:** phần lớn case ở đây là enum rời rạc, không có ngưỡng số cổ điển. 2 điểm áp dụng
  BVA (🔧 theo V2, mục 7):
  - **Số lượng cặp wallpaper sinh ra sau khi chạy lần lượt đủ 4 chế độ** (Off → Same → Photo only → Own photo)
    — kỳ vọng **+0** cặp mới (chỉ ghi vào đúng 1 cặp có sẵn của Ink), test đúng **before vs after** qua toàn bộ
    chuỗi 4 chế độ, không phải "6 lần" như V1 từng ghi nhầm (V2 tự đánh dấu "lỗi chặn phát hành" nếu sai).
  - **Số cặp sau khi bấm Update 3 lần liên tiếp** (không đổi chế độ) — kỳ vọng **+0**, before vs after quanh
    "N lần lặp cùng 1 thao tác" thay vì quanh 1 giá trị số.
- **Decision Table 1 — Home Screen × Blur (copy nguyên bảng mục 5 nguồn, dùng làm checklist thực thi trực tiếp)**

  | ID | Chế độ | Blur | Lock screen | Home screen |
  |---|---|---|---|---|
  | DT1-01 | Off | — | Wallpaper có lịch | Không bị Ink set |
  | DT1-02 | Same | Tắt | Wallpaper có lịch | Cùng ảnh có lịch, nét |
  | DT1-03 | Same | Bật | Wallpaper có lịch | Cùng ảnh có lịch, mờ |
  | DT1-04 | Photo only | Tắt | Wallpaper có lịch | Ảnh nền, không lịch, không tối |
  | DT1-05 | Photo only | Bật | Wallpaper có lịch | Ảnh nền, không lịch, mờ |
  | DT1-06 | Own photo | Tắt | Wallpaper có lịch | Ảnh đã chọn |
  | DT1-07 | Own photo | Bật | Wallpaper có lịch | Ảnh đã chọn, mờ |

  → 🔧 **Ghi chú triage (mục "Cấu trúc thật của shortcut" §D, đầu tài liệu):** DT1-04/05 (Photo only) và
  DT1-06/07 (Own photo) chạy qua **đúng cùng 2 action Set** trong shortcut — khác biệt nội dung ảnh nằm hoàn
  toàn bên trong action `Generate Home Screen Wallpaper`, không phải ở logic rẽ nhánh. Nếu chỉ 1 trong 2 cặp
  sai mà cặp kia đúng → root cause nằm trong logic chọn ảnh của action đó, không phải cấu trúc shortcut.

- **Decision Table 2 — Cài shortcut khi đã có shortcut trùng tên (mục 3.2)**

  | ID | iOS hỏi gì? | Hành động đúng | Kỳ vọng |
  |---|---|---|---|
  | DT2-01 | Hỏi thay thế (Replace) | Không chọn — đổi tên shortcut cũ trước (bước 1 mục 3.2) | Không mất shortcut cũ |
  | DT2-02 | Thêm bản mới, tự đặt số ở cuối (`… 1`) | Giữ cả hai, đổi tên theo bảng quy ước | Không có 2 shortcut cùng tên `Ink Refresh Lock Screen` |

  → **Note không nói trước iOS chọn nhánh nào** — chính là 1 ô của bảng thăm dò mục 11 nguồn, ghi lại thực tế
  quan sát được.

- **Decision Table 3 — Cảnh báo vàng "Needs the new Ink shortcut" (mục 8)**

  | ID | Shortcut đang chạy | Chế độ Home Screen | Cảnh báo hiện? |
  |---|---|---|---|
  | DT3-01 | Production (cũ) | Same/Photo only/Own photo | Có |
  | DT3-02 | Mới (iOS 26/27), chưa Update lần nào | Same/Photo only/Own photo | Có |
  | DT3-03 | Mới, đã Update ≥1 lần | Same/Photo only/Own photo | Không |
  | DT3-04 | Bất kỳ | Off | Không áp dụng |

- **Decision Table 4 🔧 — Có cần đổi tên shortcut theo luồng kích hoạt không (ghi chú dev, điểm 2–3)**

  | ID | Luồng kích hoạt | Cần rename về `Ink Refresh Lock Screen`? | Ghi chú |
  |---|---|---|---|
  | DT4-01 | Bấm thẳng thẻ shortcut trong app Shortcuts | **Không** | Dùng để test nhanh 1 shortcut cụ thể mà không đụng shortcut khác đang chạy |
  | DT4-02 | Nút Set/Update **trong Ink** | **Có** | Ink tự gọi theo tên — sai tên là gọi nhầm/không gọi được shortcut |
  | DT4-03 | Spotlight "Refresh Lock Screen" | **Chưa xác nhận** | Gap #8, mục 10 — dev chưa làm rõ |
  | DT4-04 | Automation Sunrise (iOS 27, tự chạy theo giờ) | **Chưa xác nhận** | Gap #8, mục 10 — automation gắn theo shortcut cụ thể (không theo tên) ở flow cũ, nhưng chưa confirm cho shortcut mới |

- **State Transition Testing:**
  - Chuỗi đổi tên qua lại giữa Production ⇄ `Ink · iOS 26` ⇄ `Ink · iOS 27` (mục 3.2) — tại **mọi thời điểm**
    chỉ đúng 1 shortcut được mang tên `Ink Refresh Lock Screen`; verify bằng nút **Update trong app** (luồng
    "trigger trong app", DT4-02) chạy đúng shortcut vừa đổi tên (phân biệt qua chế độ Home Screen — sản xuất
    không hiểu chế độ này). 🔧 Với luồng "chạy trực tiếp" (DT4-01), test song song bằng cách bấm thẳng shortcut
    muốn kiểm tra mà **không** cần đổi tên trước — dùng để cô lập lỗi nằm ở shortcut hay ở cơ chế dò tên của Ink.
  - Cảnh báo vàng: `production đang chạy [cảnh báo hiện] → đổi sang shortcut mới, chưa Update [cảnh báo vẫn
    hiện] → bấm Update 1 lần → đóng/mở lại editor [cảnh báo biến mất]`.
  - Own photo: `chưa chọn ảnh [set → dùng ảnh nền lock, không lịch] → chọn ảnh A [set → home = A] → đổi
    template khác [set → home vẫn = A] → chuyển Photo only rồi quay lại Own photo [A vẫn được chọn sẵn]`.
- **Exploratory testing (session-based, time-boxed)** — dùng nguyên bảng ghi kết quả ở
  [mục 11 của V2](../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2.md#11-bảng-ghi-kết-quả-thăm-dò) làm
  charter cho phần **thật sự** còn mở (🔧 sau khi V2 giải thích cơ chế mục 7, phần lớn case cặp wallpaper đã có
  kỳ vọng rõ — viết thành case pass/fail bình thường, xem TC-SH-PAIR trong test-cases-ios26-27.md — chỉ còn
  đúng 2 điểm dưới đây là thật sự exploratory):
  - Cặp wallpaper — **duy nhất còn mở:** con số cụ thể (số cặp tăng đúng 1, không tăng thêm khi lặp) ghi vào
    bảng mục 11, vì đây là hành vi runtime cần đo trên máy thật, không phải điểm chưa biết cơ chế.
  - Automation iOS 27 (mục 9 nguồn) — trạng thái automation sau cài, quyền vị trí, chạy qua đêm, cài lại lần 2,
    máy Apple Account khác.
  - Chéo phiên bản 🔧 — theo ghi chú dev: trên máy **iOS 27**, cài và chạy thử **cả file `iOS 26/Dev`** (tương
    thích ngược) lẫn file `iOS 27/Dev` gốc; đối chiếu 2 kết quả. Nếu vẫn muốn thử hướng note gốc mục 10 (file
    `iOS 27/Dev` lên máy iOS 26) để loại trừ khả năng user vô tình làm vậy ngoài đời — coi đây là 1 case riêng,
    kỳ vọng **có thể cài lỗi/không cài được** do gap #7 (`MinimumClientVersionString`), không phải lỗi nếu xảy
    ra đúng như vậy.

## 6. Risk-based prioritization

> Base theo đúng thứ tự rủi ro **note tự xếp** ("Bảy mảng cần test, xếp theo mức rủi ro giảm dần") + rủi ro
> bổ sung từ phát hiện đối chiếu ở mục 1.

**P1 — chặn phát hành:**
- **TC-SH-A1** — Luồng set wallpaper cũ (Off mode, mục 4) không vỡ: Set/Update/xoá shortcut/Spotlight/Don't
  Allow đều đúng như flow cũ. Note tự xếp rủi ro cao nhất.
- **TC-SH-A2** — 🔧 Chạy lần lượt đủ 4 chế độ (Off/Same/Photo only/Own photo) **không** tạo thêm cặp wallpaper
  mới (mục 7 V2, tự ghi "đây là lỗi chặn phát hành" nếu sai). Không phải "6 action" như V1 từng ghi nhầm.
- **TC-SH-A3** — Ảnh riêng của user (own photo lẫn cặp riêng ngoài Ink, mục 6/7) không bao giờ bị ghi đè/xoá
  ngoài ý muốn.
- **TC-SH-A4** — Own photo chưa chọn ảnh nào → set → home nhận ảnh nền lock (không lịch), **không bao giờ** là
  màn trống/đen (mục 6, V2 tự đánh dấu bằng chữ đậm).
- **TC-SH-A5** — Automation Sunrise chạy đúng khi máy khoá qua đêm (mục 9) — nối trực tiếp phát hiện #4/#7 mục
  1 (toggle `Allow Running When Locked` + BUG-004). Test cả 2 chiều: bật đúng toggle, và quên bật (tái lập
  triệu chứng "hỏng im lặng" đã biết).
- **TC-SH-A6** — Xoá shortcut đang chạy → app nhận ra, đưa vào luồng cài đặt, không kẹt ở màn Shortcuts (mục 4).
- **TC-SH-A7** — 🔧 **Mới, từ V2 (mục 3.1):** ngay sau khi cài, action Switch Between Wallpapers phải hiện đúng
  biến `Wallpaper` (không trống, không bật popup bắt chọn) — V2 tự ghi "báo ngay, lỗi chặn phát hành" nếu sai.
- **TC-SH-A8** — 🆕 **Mới, QC tự phát hiện (2026-09-22), không có trong V2:** mode **Off**, user tự sửa Home
  Screen qua Settings (không qua Ink) → chạy lại shortcut → Home **phải giữ nguyên** ảnh user vừa chọn, không bị
  ghi đè. Vi phạm case này đồng nghĩa lời hứa cốt lõi của mode Off ("Ink không đụng Home") sai trên thực tế
  (TC-SH-PAIR-07).
- **TC-SH-A9** — 🆕 **Mới, QC tự phát hiện (2026-09-22):** mode khác Off, user tự sửa Home qua Settings vào buổi
  tối → automation Sunrise (iOS 27) chạy qua đêm → Home bị ghi đè âm thầm, không cảnh báo (TC-SH-PAIR-09). Bản
  thân hành vi ghi đè **đúng thiết kế** theo mode đã chọn — nhưng xếp P1 vì đây là rủi ro UX **xảy ra hoàn toàn
  âm thầm, không qua tương tác nào của user**, dễ thành nguồn phàn nàn "wallpaper tự đổi qua đêm" nếu không có
  cảnh báo nào — cần hỏi dev/PO trước khi quyết định coi đây là bug hay chấp nhận được.

**P2:**
- 7 dòng Decision Table 1 (Home Screen × Blur) — hiển thị đúng nội dung/blur, không tối/không méo ảnh.
- Cảnh báo vàng (Decision Table 3) đúng logic bật/tắt.
- Cross-version 🔧 — trên máy iOS 27, file `iOS 26/Dev` cài và chạy đúng (tương thích ngược); nếu vẫn thử
  hướng note gốc (file iOS 27 trên máy iOS 26), không coi kết quả lỗi/không cài được là bug (gap #7).
- Automation không trùng khi cài lại lần 2 cùng file; automation theo đúng máy khi đổi Apple Account (mục 9).
- Own photo persist qua đổi template, qua restart app 1 ngày, qua đổi chế độ rồi quay lại (mục 6).
- 🔧 **Mới, từ V2 (mục 7):** bấm Update 3 lần liên tiếp → số cặp không đổi; xoá chính cặp của Ink → Update →
  tạo cặp mới **và** tự chuyển sang cặp đó, không báo lỗi "Unable to switch"; chạy thêm 2 lần → không tăng tiếp.
- 🔧 **Mới, từ V2 (mục 7):** chuyển sang cặp khác rồi bấm Update → màn khoá **tự quay về cặp của Ink** (hành vi
  đã đảo ngược so với V1 — xem "V2 thay thế V1" đầu tài liệu), lịch là bản mới nhất.

**P3:**
- Số lần hỏi quyền (1 hay 2 lần) cho Photo only/Own photo — ảnh hưởng UX, không chặn luồng.
- Đóng editor bằng Cancel → chế độ quay về đúng trạng thái trước khi mở (mục 5, dòng cuối).
- Toàn bộ 3 mục thăm dò thuần quan sát (mục 7/9/10) — có giá trị thiết kế nhưng **không phải** pass/fail có
  sẵn đáp án đúng; không xếp priority như bug thường.

## 7. Test environment matrix

- **Thiết bị bắt buộc** (theo mục 2 nguồn, 🔧 cập nhật theo ghi chú dev):
  - iPhone **iOS 26.x** — chỉ test file `iOS 26/Dev` (không automation trong file).
  - iPhone **iOS 27** — test **cả 2 file**: `iOS 27/Dev` (có automation Sunrise, cần bật
    `Allow Running When Locked`) **và** `iOS 26/Dev` (kiểm tương thích ngược) — theo đúng ghi chú dev, không
    phải chỉ test riêng file iOS 27.
  - **Máy thứ hai, Apple Account khác** — verify automation "đi theo" khi cài trên máy người khác (mục 9).
  - iPad — nếu có, cho ảnh home trên màn vuông + xoay ngang/dọc (không bắt buộc theo note, nhưng xem gap #3
    mục 9 dưới đây).
- **Dữ liệu chuẩn bị trên mỗi máy:** thư viện wallpaper (giữ tay trên lock screen) có **≥3 cặp**, trong đó
  **≥1 cặp là ảnh riêng của người test** — điều kiện bắt buộc để thấy rõ TC-SH-A3/A2.
- **File shortcut:** lấy từ [`requirements/test-data/ink-shortcut-final/`](../../test-data/ink-shortcut-final/)
  — chỉ dùng nhánh **Dev** của cả 2 phiên bản iOS (`iOS 26/Dev/Ink Refresh Lock Screen.shortcut`,
  `iOS 27/Dev/Ink Refresh Lock Screen.shortcut`) — bản `Prod` đã có sẵn trong cùng folder nhưng **chưa test
  được** (app Ink Prod trên store chưa có action mới), giữ lại chỉ để đối chiếu nếu cần.
- **Build:** Ink Dev dựng bằng **Xcode** từ nhánh `fix/ios27-shortcut-automation` — **không** cài qua
  TestFlight/App Store. 🔧 Commit cụ thể **chưa được V2 xác nhận** (V1 từng ghi `abcd305a`, không dùng lại).

## 8. Entry criteria

- Build Ink Dev dựng đúng từ nhánh `fix/ios27-shortcut-automation`, xác nhận bằng Xcode, không phải bản
  TestFlight. 🔧 Không có số commit cụ thể để đối chiếu (xem mục "V2 thay thế V1") — hỏi dev nếu cần chốt build
  chính xác trước khi execute.
- Đủ bộ 4 file trong [`test-data/ink-shortcut-final/`](../../test-data/ink-shortcut-final/) (`iOS 26/Dev`,
  `iOS 26/Prod`, `iOS 27/Dev`, `iOS 27/Prod`) — đưa vào máy test qua AirDrop từ 2 file `Dev`, không dùng `Prod`
  cho đợt test này.
- Mỗi máy test đã chuẩn bị thư viện wallpaper ≥3 cặp (≥1 cặp ảnh riêng) **trước khi** cài shortcut mới, để có
  baseline so sánh cho mục 7.
- Người test đã đọc mục 3 nguồn (quy tắc đổi tên) trước khi bắt đầu — sai bước này làm hỏng baseline của mọi
  case sau.

## 8.1 Suspension & Resumption criteria

- **Suspend toàn cụm** 🔧 nếu phát hiện app **KHÔNG** tự chuyển màn khoá về cặp của Ink sau mỗi lần chạy — V2
  xác nhận rõ đây **mới là** hành vi thiết kế đúng (mục 7 + mục 12 V2: "Mỗi lần shortcut chạy, màn khoá bị kéo
  về cặp của Ink... Đúng thiết kế"). **Đã đảo ngược so với điều kiện suspend cũ ở V1** (V1 từng suspend nếu app
  CÓ tự chuyển — sai, xem "V2 thay thế V1" đầu tài liệu). Nếu màn khoá KHÔNG tự quay về cặp Ink sau Update/chạy
  automation — dừng ngay, xác nhận với dev trước khi tiếp tục ghi bảng thăm dò mục 7, tránh chốt sai baseline.
- **Suspend toàn cụm** nếu phát hiện **2 shortcut cùng mang tên `Ink Refresh Lock Screen`** cùng lúc — note tự
  cảnh báo "kết quả không đoán trước được". Dừng, đổi tên lại đúng quy ước mục 3.2, coi mọi kết quả ghi nhận
  trong lúc trùng tên là **không đáng tin**, chạy lại từ đầu. 🔧 Rủi ro này chỉ áp dụng cho case dùng luồng
  "trigger trong app" (DT4-02, mục 5) — case dùng luồng "chạy trực tiếp" (DT4-01) không cần rename nên không
  bị ảnh hưởng bởi trùng tên.
- **Suspend cục bộ mục 9 (automation)** nếu phát hiện việc chờ tạm bằng cách đổi trigger sang "Time of Day,
  2–3 phút tới" (thay Sunrise) tự nó làm automation ngừng chạy hẳn — theo đúng tiền lệ cảnh báo đã có ở
  [exploratory/03_shortcut-setup.md §10](../../exploratory/03_shortcut-setup.md#10--smoke-cho-flow-này) ("Không
  rút ngắn bằng cách đổi giờ hệ thống"). Chuyển hoàn toàn sang chờ Sunrise thật (qua đêm) nếu nghi ngờ.
- **Resume:** sau khi có xác nhận/patch, chạy lại từ đầu cụm đã suspend, không tiếp tục giữa chừng.

## 9. Exit criteria

- 100% checklist mục 3, 4, 5, 6, 8 của note gốc đã tick pass hoặc có bug kèm severity.
- Bảng thăm dò [mục 11 của V2](../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2.md#11-bảng-ghi-kết-quả-thăm-dò) đã điền
  đủ cho cả cột iOS 26 và iOS 27 — kể cả ô đánh dấu "—" theo đúng thiết kế; "không chạy được" **cũng là** một
  kết quả hợp lệ, không phải ô để trống.
- 0 bug P1 mở (mục 6): luồng cũ không vỡ, đủ 4 chế độ không tạo cặp thừa, action Switch hiện đúng biến (không
  trống/không popup), ảnh riêng user không bị ghi đè, automation chạy đúng khi máy khoá, Own photo chưa chọn
  không bao giờ ra màn trống.
- Regression SCT checklist cũ (happy path H01–H19 + permission N01–N05) đã chạy lại **trên shortcut mới**,
  không dựa vào kết luận cũ chưa re-verify (mục 4, Change-related).
- Kịch bản BUG-004 đã được thử lại ít nhất 1 lần trên automation Sunrise mới, có ghi nhận kết quả (pass hoặc
  bug mới) thay vì bỏ qua vì "đã có bug ticket cũ".
- Toàn bộ câu hỏi mở ở mục 10 dưới đây đã có câu trả lời bằng văn bản từ dev, hoặc được ghi nhận rõ là gap đã
  biết trước khi sign-off.

## 10. Gap cần làm rõ trước khi execute

1. **5 action Set Wallpaper (+ 1 action Switch) có xin quyền D1–D3 riêng lẻ từng action, hay dùng chung 1 lần
   "Always Allow" cho cả shortcut?** Quyết định cách viết lại toàn bộ case SCT-N01–N05 (phát hiện #2, mục 1).
   V2 tự hỏi câu này ở mục 5 và đưa vào bảng thăm dò, nhưng chưa có câu trả lời.
2. **Ngoại lệ l10n cho tên shortcut** ([1.2.15-decoration-inkai.md](../1.2.15-decoration-inkai.md#8)) đã được
   cập nhật từ `Generate Latest Wallpaper` sang `Ink Refresh Lock Screen` chưa? Nếu chưa, đây là doc nợ hay bug
   l10n thật cần log.
3. **"Xoá automation" trên iOS 27 tương đương thao tác nào** — xoá cả shortcut, hay có cách tắt riêng automation
   trong Edit → Automation mà không đụng shortcut? Note không mô tả, nhưng đây chính là hành vi SCT-N21/N22 cũ
   cần viết lại cho kiến trúc mới (phát hiện #3, mục 1).
4. **Cây chẩn đoán SCT-D (9 mắt xích cũ)** có cần thêm mắt xích mới cho iOS 27 không — cụ thể
   "`Allow Running When Locked` đang tắt" — hay coi đây là mắt xích con của SCT-D07 (quyền Calendar bị rút)?
   Note không tự đối chiếu với bộ SCT-D đã có.
5. **Nếu user từ chối quyền vị trí cho automation Sunrise** — automation dừng hẳn, hay fallback về giờ mặc định
   nào đó? Note mục 9 chỉ hỏi "có xin quyền vị trí không", không mô tả nhánh từ chối.
6. **iOS chọn nhánh nào** khi cài file mới lúc đã có shortcut trùng tên (Decision Table 2) — Replace hay thêm
   bản số `1`? Note tự nói "ghi lại iOS hỏi kiểu nào vào mục 11" — chưa có kết quả tại thời điểm lập test plan.
7. **Giá trị thật của `MinimumClientVersionString`** — có tồn tại trong file iOS 27 bản V2 không, và nếu có thì
   bằng bao nhiêu? Lần đọc đầu (phát hiện #8, mục 1) tìm thấy khoá này ở file iOS 27 bản **V1 (đã superseded)**.
   🔧 Thử lại trên 2 file iOS 27 bản **V2** (file thật dùng để test) thì **không trích được chuỗi đọc được nào**
   — không đủ để khẳng định khoá này còn tồn tại hay đã bị bỏ trong bản sửa. Gap này **vẫn mở nguyên**, không
   nghiêng về hướng nào. Ghi chú dev (đầu tài liệu, điểm 1) vẫn không đưa hướng "file iOS 27 trên máy iOS 26"
   vào scope test thực tế của họ — nhưng nay không còn dựa được vào bằng chứng nhị phân nào để giải thích vì
   sao. Cần hỏi thẳng dev: (a) file V2 có còn ngưỡng version tối thiểu nào không, cụ thể là gì? (b) quyết định
   bỏ scope "file iOS 27 trên máy iOS 26" của dev dựa trên lý do gì — biết trước sẽ lỗi, hay chỉ mô tả luồng
   test phổ biến nhất (và case gốc mục 10 V2 vẫn cần thử)?
8. **Spotlight ("gõ 'Ink' → Refresh Lock Screen") và automation Sunrise (iOS 27) có cần đúng tên
   `Ink Refresh Lock Screen` để chạy đúng shortcut không** (DT4-03, DT4-04, mục 5)? Ghi chú dev (đầu tài liệu)
   chỉ làm rõ 2 trong 4 luồng kích hoạt (chạy trực tiếp, trigger trong app) — 2 luồng còn lại (Spotlight,
   automation) chưa được xác nhận, dù đều là case P1/P2 trong mục 4 và mục 9 nguồn.
9. **🔧 Mới — giá trị chuỗi thật của `Get Ink Wallpaper Mode` cho từng 1 trong 7 tổ hợp mode×blur** (mục "Cấu
   trúc thật của shortcut" §E/§F, đầu tài liệu) — chỉ đọc được **tên khoá so sánh** (`"pair"`, `"same"`, `"blur"`)
   từ ảnh chụp shortcut, không đọc được **giá trị thật** vì đó là output của code Swift bên trong app Ink,
   không có source code để đối chiếu. Nếu format chuỗi lẫn từ khoá giữa 2 mode, nhiều nhánh có thể rẽ sai cùng
   lúc mà không action nào báo lỗi — cần hỏi dev hoặc tự verify bằng `Show Result`/`Show Alert` tạm trong
   Shortcuts (xem cách làm ở §E). 🔧 **Bổ sung 2026-09-22, sau khi phân tích logic if/else thuần tuý (§F):**
   - Chuỗi mode của **Same** có bao giờ chứa substring `"pair"` không? (rủi ro nhiễm chéo chỉ tồn tại 1 chiều —
     `pair` được check trước `same` trong shortcut, nên Same "dính" `pair` sẽ âm thầm sai, chiều ngược lại vô hại)
   - `Get Ink Wallpaper Mode` khi lỗi thì **throw** hay **trả chuỗi rỗng**? Nếu throw, có thể cả Lock Screen
     cũng không được set (nặng hơn hẳn giả định "chỉ Home không đổi").
   - Có cách nào phân biệt "Off thật" với "mode lỗi/rỗng" từ UI hoặc log Ink không, hay 2 trường hợp **không
     thể** phân biệt được từ phía QC?

## 11. Coverage gap — case chưa được note liệt kê

| Thiếu | Vì sao là gap |
|---|---|
| Từ chối quyền vị trí cho automation Sunrise | Note chỉ hỏi "có xin quyền vị trí không", không test nhánh từ chối (gap #5 mục 10) |
| Regression đầy đủ SCT-N06–N27 (bỏ dở, cấu hình automation sai, phá vỡ sau setup) trên shortcut mới | Note chỉ tập trung phần thay đổi (Home Screen, automation, cặp wallpaper), không tự khai lại 22 case cũ này |
| iPad — 4 chế độ Home Screen trên màn vuông, xoay ngang/dọc | Note liệt "iPad nếu có" ở mục môi trường nhưng không có case riêng nào cho layout iPad ở mục 5 |
| 2 automation cùng gọi 1 shortcut (tương đương SCT-N19 cũ) trong bối cảnh automation-trong-shortcut của iOS 27 | Note không nhắc lại case này cho kiến trúc automation mới |
| Wallpaper hiện tại đang là Photo Shuffle trước khi cài/chạy shortcut mới (tương đương SCT-E24 cũ) | Không có trong 8 mục của note |
| Own photo bị dọn bởi cơ chế "dọn file ảnh không dùng khi khởi động" nếu không mở app lâu hơn "một ngày" (note chỉ test 1 ngày) | Ranh giới thật của cơ chế dọn file (vd 7 ngày, 30 ngày) không được note xác nhận |
| Cả 2 shortcut Dev và Prod cùng cài trên máy nhưng **không** đổi tên đúng quy trình mục 3.2 (thao tác sai của chính QC) | Note mô tả quy trình đúng, không có case "quy trình sai" để verify Ink phản ứng thế nào khi có 2 shortcut cùng tên (chỉ nói "kết quả không đoán trước được") |
| 🆕 **User tự sửa Home Screen qua Settings/Customize (không qua Ink), trong CHÍNH cặp của Ink, rồi chạy lại shortcut** (thấy trước bởi QC, không phải note) — xem TC-SH-PAIR-07/08/09 | V2 hoàn toàn không nhắc tới đường này — chỉ nói tới việc user chuyển sang **cặp khác** (mục 7), chưa từng xét trường hợp sửa nội dung ngay trong cặp Ink đang quản lý. Rủi ro cao nhất ở mode Off (lời hứa "không đụng Home" có thể bị vi phạm) và ở automation iOS 27 (ghi đè âm thầm qua đêm, không cảnh báo) |
