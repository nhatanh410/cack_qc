# Test Analysis — Shortcut wallpaper: Home Screen (iOS 26) và Automation (iOS 27) — bản V2-updated

> ⚠️ **SUPERSEDED — không dùng tài liệu này làm test basis.** Phân tích từ test basis nhánh
> `fix/ios27-shortcut-automation` (chưa vào `main`). PR #302 đã merge vào `main` 2026-09-24, đóng
> hầu hết câu hỏi từng mở ở đây bằng cách viết thẳng câu trả lời vào spec mới (action count,
> skip-unchanged cho Same mode...), đồng thời đổi nhiều chi tiết khác (tên chip, cách cài). Giữ
> file này lại chỉ để đối chiếu lịch sử — bảng đối chiếu §1.1 và phân tích 9 token ở §1.2 vẫn
> còn giá trị tham khảo khi phân tích spec mới.

> ⚠️ **DRAFT — chờ xác nhận.** **Q1, Q2, Q3, Q5, Q6 đã đóng hoàn toàn.** Q1 qua cross-check tay của user trên máy
> thật: đúng 7 Set/2 Switch. Q5: tài liệu triggers ([qc-shortcut-triggers-ios27.md](../../specs/shortcuts/qc-shortcut-triggers-ios27.md),
> gộp vào nhóm G, nay có 5 nhóm con G.1–G.5, +23 test condition mới bao gồm G.6 trigger-qua-notification) vẫn
> dùng **cùng 1 bản build**, chỉ test riêng được trên máy iOS 27 — không phải bản khác, kết luận mục 1.2 vẫn áp
> dụng nguyên cho nhóm G. Q6: trigger qua notification `update_lockscreen` là cơ chế **thật, có chủ đích**
> (automation = "theo giờ set sẵn HOẶC qua notification"), không phải hệ quả của bản sửa tay `43e6966e…`.
>
> **Còn mở:** **Q1b** đã xác nhận cấu trúc (Same+Blur không có `Otherwise`, bất đối xứng thật so với nhánh
> Pair) — chỉ còn chờ verify **hành vi runtime** (TC-25b, TC-25c — TC-25c nghiêm trọng hơn: mode Same có thể
> **không bao giờ hết mờ được** một khi đã bật Blur, xem mục 1.2). **Q4** (dev báo miệng: Same mode cũng có
> skip-unchanged, và có thể đã bỏ mốc 24h buộc ghi lại home mỗi ngày, mâu thuẫn với mục 5 test basis) — ảnh
> hưởng trực tiếp risk/scope của test condition **P1** (TC-29b, TC-38).
>
> **Chưa nên chạy test-plan** cho tới khi TC-25b/TC-25c được verify trên máy và Q4 có câu trả lời, hoặc user
> chấp nhận rõ ràng một hướng giả định để tiếp tục ở trạng thái DRAFT.

> **Test basis:** [qc-shortcut-home-screen-ios26-27-V2-updated.md](../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2-updated.md)
> — bản **V2-updated** (mới nhất), nhánh `fix/ios27-shortcut-automation`, chưa vào `main`, test trên **Ink Dev**
> dựng từ Xcode. **Không đụng tới** [test-plan-ios26-27.md](test-plan-ios26-27.md) /
> [test-cases-ios26-27.md](test-cases-ios26-27.md) đã có (viết cho bản **V2**, không phải V2-updated) — 2 file đó
> giữ nguyên, không sửa.
> **Test basis thứ 2 (bổ sung 2026-09-23):** [qc-shortcut-triggers-ios27.md](../../specs/shortcuts/qc-shortcut-triggers-ios27.md)
> — riêng về **4 automation có sẵn trong shortcut** trên iOS 27 (Sunrise, When Ink/Calendar/Google Calendar
> closed). Gộp trực tiếp vào nhóm G (mục 2) thay vì tách file riêng, theo yêu cầu user. ⚠️ Tài liệu này dùng
> **file shortcut khác tên** — `Ink Refresh Lock Screen V2.shortcut` (từ `Ink Shortcut Final V2/`) — so với file
> đã cross-check tay ở mục 1 (`Ink Refresh Lock Screen.shortcut`, không có hậu tố "V2", từ `ink-shortcut-final-4/`).
> Chưa xác nhận đây là cùng 1 file đổi tên hay 2 bản build khác nhau — xem mục 1 vấn đề #7 (mới).
> **Tài liệu đối chiếu (không phải test basis, chỉ dùng để so sánh/đối chiếu mâu thuẫn):**
> [qc-shortcut-home-screen-ios26-27-V2.md](../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2.md) (bản
> trước, đã có test-plan/test-cases riêng), [test-plan-ios26-27.md](test-plan-ios26-27.md) (đặc biệt phần "Cấu
> trúc thật của shortcut" — giải mã từ ảnh chụp Shortcuts app thật, dùng để nhận diện mâu thuẫn ở mục 1 dưới đây).
> **Chuẩn:** ISTQB Foundation Level v4.0.1 §1.4.1 (Test Analysis) + §3 (Static Testing) + §5.2 (Risk Management)
> **Bước tiếp theo:** [test-plan](../../../.claude/skills/test-plan/SKILL.md) sẽ dùng mục 2 (test condition) làm
> test object và mục 2 cột risk level làm cơ sở mục 6 (risk-based prioritization) — **chỉ chạy sau khi** mục 4
> không còn câu hỏi ảnh hưởng risk/scope của test condition P1.
> **Ngày lập:** 2026-09-22 · **Người lập:** QC

---

## 1. Đánh giá testability của test basis

### #1 · Số action Set/Switch trong spec bị sai — ✅ ĐÃ ĐÓNG
- **Trích đoạn:** Mục 3.1 (checklist) công bố *"11 action Set Wallpaper và 3 action Switch"*.
- **Vấn đề:** Sai. User tự cross-check bằng tay toàn bộ shortcut thật (iOS 27, đối chiếu trực tiếp app Shortcuts) xác nhận đúng **7 Set / 2 Switch**, khớp chính xác với số đếm từ ảnh chụp trước đó. Cấu trúc iOS 26 giống hệt iOS 27 (chỉ khác khối automation ở đầu).
- **Loại:** Mâu thuẫn nội bộ — đã đóng bằng cross-check tay trên máy thật.
- **Cần hỏi ai:** Dev — chỉ còn việc sửa lại số "11/3" trong spec §3.1 thành "7/2".

### #1b · Same + Blur tắt có thể không Set gì cả — ✅ CẤU TRÚC ĐÃ XÁC NHẬN, chờ verify runtime
- **Trích đoạn:** Suy ra từ cấu trúc thật (mục 5), không phải câu chữ nào cụ thể trong spec.
- **Vấn đề:** Cross-check tay xác nhận khối `If Mode contains "blur"` lồng trong `same` **thật sự không có `Otherwise`** — khi Same + Blur tắt, khối đó bị bỏ qua hoàn toàn (không Set nào chạy) trước khi `Switch to Wallpaper`.
  - **Bằng chứng đối chứng:** nhánh `pair` (Photo only/Own photo) có đầy đủ `If blur {...} Otherwise {...} End If` — cùng tác giả, cùng điều kiện `contains "blur"`, chỉ nhánh `same` thiếu `Otherwise` → nghiêng về **sai sót khi build** hơn là chủ ý.
  - **Việc còn lại:** không còn là "đọc cấu trúc" mà là "xác nhận hậu quả runtime" — chạy thật Same + Blur tắt trên máy, xem Lock/Home có đổi ảnh mới hay giữ nguyên.
- **Loại:** Mâu thuẫn nội bộ — cấu trúc đã xác nhận, còn chờ verify hành vi thật + báo dev.
- **Cần hỏi ai:** Dev (đây là bug hay có lý do khác chưa lộ ra) — hoặc QC tự chạy thử trên máy trước để có bằng chứng runtime (TC-25b, P1).

### #2 · Own photo có còn là mode riêng không — ✅ ĐÃ TRẢ LỜI (xem #2b để biết diễn biến)
- **Trích đoạn:** Không có trích đoạn cụ thể — phát sinh từ hội thoại với dev.
- **Vấn đề:** Dev xác nhận ở bản build mới nhất, mode Own photo đã bị bỏ hẳn như 1 lựa chọn riêng vì chạy cùng nhánh if/else với Photo only (đúng phát hiện cũ ở [test-plan-ios26-27.md §D](test-plan-ios26-27.md#d-phát-hiện-quan-trọng-nhất--photo-only-và-own-photo-dùng-chung-1-code-path)).
- **Loại:** Đã trả lời.
- **Cần hỏi ai:** — (xem #2b, câu trả lời này bị đính chính ngay sau đó)

### #2b · Đính chính #2 — Own photo thực ra vẫn còn — ✅ ĐÃ SỬA LẠI
- **Vấn đề:** Cùng ngày, user đính chính: bản build đang nói tới **đã thêm lại Own photo** — vẫn đủ 4 chế độ như test basis mô tả. Vì Own photo dùng chung chính xác 1 nhánh code với Photo only, suy ra hợp lý (không phải xác nhận trực tiếp) là Own photo **thừa hưởng mọi hành vi** của Photo only — bao gồm cả câu hỏi gốc ở #3 (home-history cho Off).
- **Kết quả:** Nhóm D (mục 2, TC-42→54) giữ nguyên, không lỗi thời.
- **Loại:** Đã trả lời (đính chính).
- **Cần hỏi ai:** —

### #2c · 🆕 Cập nhật dev mới nhất — Same cũng có skip-unchanged, có thể bỏ mốc 24h — 🔴 CÒN MỞ (Q4)
- **Trích đoạn:** Không có trong bất kỳ bản spec nào kể cả V2-updated — dev báo miệng qua QC, 2026-09-22.
- **Vấn đề, 2 phần:**
  1. Từ **lần chạy thứ 2 trở đi**, nếu user không đổi gì, **Same / Own photo / Photo only đều nhanh hơn** — không chỉ riêng Photo only/Own photo như mục 5 test basis mô tả (Same trước giờ chỉ nhanh hơn nhờ gộp 1 action Lock+Home, chưa từng có cơ chế skip-unchanged).
  2. Dev "tìm được cách" để **không gen lại home mỗi ngày nữa** nếu user không đổi gì — mâu thuẫn trực tiếp với mục 5 test basis: *"Để qua hơn 24 giờ không đổi gì → lần chạy kế tiếp ghi home đầy đủ một lần"* (chính là hành vi TC-38 đang test). Không rõ mốc 24h đã bị bỏ hẳn hay chỉ đổi mốc dài hơn.
- **Loại:** Test basis (V2-updated) đã lỗi thời hơn bản dev đang mô tả — ảnh hưởng trực tiếp TC-29b (P1), TC-38 (P2).
- **Cần hỏi ai:** Dev, xin xác nhận bằng văn bản: (a) Same mode có skip-unchanged y hệt Photo only/Own photo không hay chỉ nhanh hơn do gộp action; (b) mốc 24 giờ còn tồn tại dưới dạng nào không, hay bỏ hẳn.

### #3 · Own photo có còn tính là "đã set home" cho Off không — ✅ ĐÃ ĐÓNG bằng suy luận
- **Trích đoạn:** Mục 5, ghi chú *"Off không có nghĩa là home đứng yên"*. Bản V2 liệt *"Same / Photo only / Own photo"* đều đủ điều kiện để Off giữ nguyên home; V2-updated đổi thành *"Same / Photo only, hoặc đã tự chỉnh home qua iOS"* (bỏ Own photo).
- **Vấn đề:** Do Own photo dùng chung nhánh code với Photo only (#2b), suy ra hợp lý Own photo **vẫn** đủ điều kiện như Photo only — coi như chỉ là gọn văn phong, không phải thay đổi hành vi.
- **Kết quả:** TC-52/TC-53 (mục 2) đã gỡ trạng thái "chờ xác nhận".
- **Loại:** Mơ hồ — đã đóng bằng suy luận hợp lý, **không phải** xác nhận trực tiếp cho đúng câu hỏi này.
- **Cần hỏi ai:** —

### #4 · Own photo crop/PRO-gating đã fix hay vẫn out-of-scope — ✅ ĐÃ TRẢ LỜI (Q3)
- **Trích đoạn:** Mục 13 "Không phải bug" — bản V2 (mục 12) có 2 dòng: *"Ảnh home ở Own photo chưa crop/căn khung được"* và *"Ảnh catalog có nhãn PRO vẫn chọn được cho home khi chưa mua Pro"*. Cả 2 dòng này biến mất khỏi mục 13 của V2-updated.
- **Vấn đề:** Không rõ là do đã fix hay chỉ rút gọn tài liệu (2 dòng khác về HEIC/tốc độ cũng được thêm cùng lúc).
- **Trả lời:** Vẫn **out of scope** — 2 hành vi này chưa được fix, tài liệu chỉ quên copy lại. Không cần test condition mới, giữ nguyên out-of-scope như [test-plan-ios26-27.md §3](test-plan-ios26-27.md#3-out-of-scope).
- **Loại:** Thiếu / Mơ hồ — đã đóng.
- **Cần hỏi ai:** —

### #5 · Own photo bị bỏ khỏi 2 câu hỏi kiểm thử nhỏ — Thiếu (nhẹ), không chặn
- **Trích đoạn:** Mục 8 (*"chọn Same/Photo only"*, trước là *"...Own photo"*) và bảng mục 11 (*"Photo only hỏi quyền mấy lần?"*, trước là *"Photo only / Own photo..."*).
- **Vấn đề:** Có thể giải thích hợp lý bằng phát hiện Photo only/Own photo dùng chung code path ([test-plan-ios26-27.md §D](test-plan-ios26-27.md#d-phát-hiện-quan-trọng-nhất--photo-only-và-own-photo-dùng-chung-1-code-path)), nhưng V2-updated không tự giải thích, nên vẫn là 1 điểm thiếu nhất quán nhẹ.
- **Loại:** Thiếu (nhẹ).
- **Cần hỏi ai:** Không bắt buộc — QC tự giữ Own photo trong TC-60, TC-28 cho chắc, ghi rõ là suy diễn của QC.

### #6 · Chất lượng ảnh HEIC không có ngưỡng khách quan — Không kiểm được, không chặn
- **Trích đoạn:** Mục 5 (*"Chất lượng ảnh HEIC"*): *"soi kỹ lock screen: có vệt màu, sọc, mảng loang... không?"*, *"chữ nhỏ... có nhoè viền không?"*
- **Vấn đề:** Không có ngưỡng khách quan (% diện tích, mức nhoè chấp nhận được). Đây là đánh giá thị giác thuần tuý, không phải lỗi thiếu sót — bản thân note cũng chỉ đưa cách so sánh (đổi format rồi chụp so sánh), không đưa ngưỡng pass/fail cứng.
- **Loại:** Không kiểm được bằng tiêu chí khách quan.
- **Cần hỏi ai:** Không chặn — xử lý như test condition dạng quan sát/so sánh (TC-39, TC-40), không gán risk theo kiểu pass/fail nhị phân.

### #7 · Tên file shortcut khác nhau giữa 2 test basis — ✅ ĐÃ ĐÓNG (Q5)
- **Trích đoạn:** Test basis 1 (V2-updated, mục 1): file `Ink Refresh Lock Screen.shortcut`. Test basis 2 (qc-shortcut-triggers-ios27.md, mục 2): file `Ink Refresh Lock Screen V2.shortcut`, tải từ thư mục `Ink Shortcut Final V2/`.
- **Trả lời (Q5, 2026-09-23):** Vẫn là **cùng 1 bản build hiện tại** — không phải bản mới/khác. Khác biệt chỉ là: phần automation (nhóm G) **chỉ test được trên máy chạy iOS 27**, và toàn bộ nội dung tài liệu triggers là **thông tin bổ sung ngoài spec gốc** (V2-updated), không phải mô tả 1 build khác. Kết luận mục 1/1.2 (7 Set/2 Switch, thiếu Otherwise ở "same") **vẫn áp dụng được** cho toàn bộ nhóm G, không cần cross-check lại riêng.
- **Loại:** Không rõ ràng về phiên bản test basis — đã đóng.
- **Cần hỏi ai:** —

### 1.1 Bảng đối chiếu: Spec (V2-updated, do dev cung cấp) vs Thực tế (cross-check tay của QC, 2026-09-22)

> Nguồn "thực tế": user tự tay vẽ lại toàn bộ cây if/else của shortcut **iOS 27**, đối chiếu trực tiếp với app
> Shortcuts trên máy thật (không phải suy đoán từ ảnh chụp hay từ nhị phân) — độ tin cậy cao nhất trong tất cả
> nguồn đã có cho tới nay.

| # | Nội dung | Spec (V2-updated) nói gì | Thực tế (cross-check tay) | Ảnh hưởng |
|---|---|---|---|---|
| a | Số action **Set Wallpaper** | Mục 3.1: **"11 action"** | **7 action** | TC-01 (P1) — sai lệch, cần dev sửa spec |
| b | Số action **Switch** | Mục 3.1: **"3 action"** | **2 action** | TC-03 (P1) — sai lệch, cần dev sửa spec |
| c | **Same + Blur TẮT có Set gì không** | Không nói trực tiếp, nhưng bảng "tra nhanh" mục 5 ngụ ý **Same luôn Set 1 lần (Lock+Home)** bất kể Blur bật/tắt (dòng "Same, bình thường → token `same`/`same-blur`, 1 lần Set") | Khối `If mode contains "blur"` (lồng trong `same`) **không có `Otherwise`** → khi Blur tắt, **không Set nào chạy**, nhảy thẳng tới `Switch` | 🔴 **Khác biệt quan trọng nhất** — TC-25b (P1), nghi vấn bug thật |
| d | **Đối xứng xử lý Blur giữa nhánh Same và nhánh Pair** | Không nói rõ, nhưng cách trình bày (2 sơ đồ mermaid, 1 bảng chung) ngụ ý cả 2 nhánh xử lý Blur đối xứng như nhau | **Không đối xứng**: nhánh `pair` (Photo only/Own photo) có đầy đủ `If blur {...} Otherwise {...}`; nhánh `same` chỉ có `If blur {...}`, thiếu hẳn `Otherwise` | Bằng chứng trực tiếp cho dòng (c) — cùng tác giả, cùng kiểu điều kiện, chỉ 1 nhánh bị thiếu → nghiêng về sai sót build hơn là chủ ý |
| e | 🆕 **Cơ chế Blur Home Screen thực chất là gì** | Mô tả ở mức UI: bật/tắt toggle "Blur Home Screen" | Mọi action Set đều có tham số hệ thống **"Legibility Blur"** bật/tắt đúng theo nhánh blur/không-blur — xác nhận blur dùng **tham số gốc của iOS** (`Set Wallpaper` action), không phải app tự làm mờ ảnh trước khi đưa vào Set | Thông tin mới, không phải sai lệch — hữu ích để hiểu tại sao Lock luôn nét (Lock không có nhánh nào bật Legibility Blur) |
| f | 🆕 **"Crop to Subject" và "Show Preview"** | Không nhắc tới trong spec | Toàn bộ 7 action Set đều để **"Crop to Subject" → off** và **"Show Preview" → off** | Xác nhận gián tiếp: không có auto-crop theo chủ thể ảnh (khớp với mục 13 "Own photo chưa crop/căn khung được" — Q3 đã đóng, đây là **bằng chứng kỹ thuật** giải thích vì sao), và automation không bao giờ bị chặn bởi màn hình xác nhận trước khi set |

**Kết luận ngắn:** 2/6 khác biệt (a, b) là **spec ghi sai số liệu**, cần dev sửa lại tài liệu. 1/6 khác biệt (c),
được củng cố bởi (d), là **khả năng cao một bug thật trong logic shortcut**, chưa có trong bất kỳ bản spec nào.
2 mục còn lại (e, f) là **thông tin mới bổ sung**, không mâu thuẫn với spec, chỉ là chi tiết spec chưa từng nói tới.

### 1.2 Toàn bộ 9 nhánh (token) shortcut thực sự xử lý — phân tích 2026-09-23

> Suy ra từ cấu trúc if/else đã xác nhận ở §1.1. Dùng bảng này làm nguồn cho Decision Table của test-plan sau
> này thay vì bảng "tra nhanh" ở mục 5 test basis (bảng đó **sai** ở đúng 2 dòng, xem cột "Số Set" và ghi chú).

| # | Token | Ứng với lựa chọn UI | Đường đi qua if/else | Số Set |
|---|---|---|---|---|
| 1 | *(không chứa "same"/"pair", vd `lock`)* | **Off**; hoặc Photo only/Own photo khi ảnh home **không đổi** (skip-unchanged) | same-if sai → `Otherwise`: Set Lock → pair-if sai → Switch | 1 (chỉ Lock) |
| 2 | `same` | **Same + Blur tắt từ đầu** | same-if đúng → blur-if **sai, không Otherwise** → bỏ qua hết → Switch | **0** ⚠️ = TC-25b |
| 3 | `same-redraw` | **Same, vừa TẮT Blur** (đang chuyển bật→tắt) | same-if đúng → blur-if sai (không chứa "blur") → bỏ qua hết (redraw nằm *trong* blur-if, không bao giờ chạy tới) → Switch | **0** ⚠️ = TC-25c |
| 4 | `same-blur` | Same + Blur bật, không vừa đổi | same-if đúng → blur-if đúng → Set(Lock+Home, mờ) → redraw-if sai → Switch | 1 |
| 5 | `same-blur-redraw` | Same + Blur bật, vừa BẬT | ...→ Set(Lock+Home, mờ) → redraw-if đúng → Set lần 2 → Switch | 2 |
| 6 | `pair` | Photo only/Own photo + Blur tắt, ảnh home có đổi | `Otherwise`: Set(Lock) → pair-if đúng → Generate Home → blur-if sai → `Otherwise`: Set(Home, nét) → redraw-if sai → Switch | 2 |
| 7 | `pair-redraw` | ...vừa tắt Blur | ...→ Set(Home, nét) → redraw-if đúng → Set lần 2 → Switch | 3 |
| 8 | `pair-blur` | Photo only/Own photo + Blur bật, ảnh home có đổi | ...→ blur-if đúng → Set(Home, mờ) → redraw-if sai → Switch | 2 |
| 9 | `pair-blur-redraw` | ...vừa bật Blur | ...→ Set(Home, mờ) → redraw-if đúng → Set lần 2 → Switch | 3 |

**Điểm mấu chốt khi nhìn cả 9 nhánh cùng lúc:** dòng #2 và #3 là 2 nhánh **duy nhất** không có Set nào — và
đúng 2 nhánh này gộp lại chính là **toàn bộ chiều "Blur tắt" của mode Same** (tắt từ đầu, hoặc vừa tắt). Vì
redraw-if bị lồng **bên trong** blur-if thay vì nằm độc lập, mode Same **không có cách nào** khiến Home hết mờ
một khi đã mờ — không chỉ là vấn đề trạng thái khởi tạo. Bảng "tra nhanh" mục 5 của spec giả định dòng #2 vẫn
có 1 Set (Lock+Home) — sai so với cấu trúc thật.

---

## 2. Test condition đã ưu tiên hoá

> Nhóm theo đúng thứ tự 9 mảng của test basis (mục đầu file, "xếp theo mức rủi ro giảm dần"). Cột **Risk level**
> ghi **"Chờ xác nhận Q#"** cho các condition bị ảnh hưởng trực tiếp bởi mục 1/mục 4 — không tự gán mức để có
> con số cho đủ.

### A. Cài shortcut & đổi tên (mục 1, 3)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-01 | ✅ Sau khi cài lần đầu, shortcut có đúng **7 action Set Wallpaper và 2 action Switch** (số thật, đã xác nhận qua cả ảnh chụp lẫn cross-check tay 2026-09-22, không phải "11/3" spec công bố ở mục 3.1 — QC dùng số thật để viết checklist thực thi, đã báo dev sửa lại spec), không action nào hiện đỏ | mục 3.1 + cross-check tay | Functional | Thấp | Cao (mục 3.1 tự đánh dấu phần Switch là "lỗi chặn phát hành") | Cao | P1 |
| TC-02 | Nhánh Same dùng đúng 1 action Set ghi Lock+Home cùng lúc (không phải 2 action Set riêng như nhánh khác) | mục 3.1 | Functional (structural) | Vừa | Vừa (ảnh hưởng kỳ vọng tốc độ TC-29) | Vừa | P2 |
| TC-03 | ✅ Cả **2** (không phải 3) action "Switch to Wallpaper" hiện đúng biến "Wallpaper" (không trống, không popup bắt chọn) ngay sau cài | mục 3.1 + cross-check tay | Functional | Thấp | Cao (note tự ghi "báo ngay, lỗi chặn phát hành") | Cao | P1 |
| TC-04 | Lần chạy đầu iOS hỏi quyền đặt wallpaper → chọn Always Allow → không hỏi lại các lần Set/Switch sau trong cùng lần chạy | mục 3.1 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-05 | (Chỉ iOS 27) Bật "Allow Running When Locked" — cài đặt không tự đi theo file, phải bật tay mỗi lần cài mới | mục 3.1 | Functional/Reliability | Cao (dễ quên) | Cao (liên quan BUG-004, automation chạy khi khoá máy) | Cao | P1 |
| TC-06 | Đổi tên qua lại giữa các shortcut theo đúng quy ước (mục 3.2) → bấm Update trong app chạy đúng shortcut vừa đổi tên (phân biệt qua chế độ Home Screen) | mục 3.2 | Functional/State | Vừa | Cao | Cao | P1 |
| TC-07 | Automation không theo tên — shortcut bị đổi tên vẫn chạy đúng automation gắn với chính nó (iOS 27) | mục 3.2 | Functional | Vừa | Cao (chạy nhầm/ghi đè automation) | Cao | P1 |
| TC-08 | Cài file mới khi đã có shortcut cùng tên → quan sát iOS hỏi Replace hay thêm bản số `1` (ghi vào bảng mục 11) | mục 3.2 | Exploratory (quan sát, không có đáp án đúng sẵn) | — | — | Không xếp priority như bug | — |
| TC-09 | Không bao giờ để 2 shortcut cùng tên "Ink Refresh Lock Screen" cùng lúc — nếu xảy ra, kết quả không đoán trước được (ghi nhận rủi ro, không kỳ vọng pass cụ thể) | mục 3.2 | Robustness (negative) | Thấp (chỉ xảy ra khi thao tác sai) | Cao (data integrity nếu chạy nhầm shortcut) | Vừa | P2 |
| TC-10 | Quyền "Always Allow" tính riêng từng shortcut — shortcut mới đổi tên có thể bị hỏi lại quyền lần đầu | mục 3.2 | Functional | Vừa | Thấp | Thấp | P3 |

### B. Luồng set wallpaper cũ không vỡ + Toast (mục 4)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-11 | Discover → chọn template → Set as current → lock đổi đúng template, nhãn "đang dùng" hiện đúng | mục 4 | Functional | Thấp (hồi quy, đã ổn định) | Cao (note tự xếp rủi ro cao nhất toàn tài liệu) | Cao | P1 |
| TC-12 | Sửa template đang dùng → Update → lock đổi theo | mục 4 | Functional | Thấp | Cao | Cao | P1 |
| TC-13 | Dialog quyền lần đầu chọn Don't Allow → mở lại app → app **không** coi là đã set thành công | mục 4 | Functional (negative) | Vừa | Cao | Cao | P1 |
| TC-14 | Đổi tên shortcut đi (coi như xoá) → bấm Set → app nhận ra không còn shortcut, vào luồng cài đặt, không kẹt màn Shortcuts | mục 4 | Robustness | Vừa | Cao | Cao | P1 |
| TC-15 | Spotlight gõ "Ink" → chạy "Refresh Lock Screen" → wallpaper đổi, không mở app | mục 4 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-16 | Template Note và template lịch đều set được như luồng chuẩn | mục 4 | Functional/regression | Thấp | Vừa | Vừa | P2 |
| TC-17 | 🆕 Bấm Update ở màn edit template → toast "Lock screen updated" hiện **ngay trên màn edit**, không đợi thoát ra Home | mục 4 | Functional/UX (mới hoàn toàn) | Vừa | Vừa | Vừa–Cao | P2 |
| TC-18 | 🆕 Shortcut lỗi (đổi tên để app không tìm thấy) → toast lỗi cũng hiện trên màn đang mở | mục 4 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-19 | 🆕 Toast hiện trên cả sheet/popup đang mở, không chặn thao tác (vẫn bấm được nút bên dưới) | mục 4 | Usability | Vừa | Vừa | Vừa | P2 |
| TC-20 | 🆕 Luồng cài shortcut lần đầu, nếu chạy lỗi → chỉ 1 thông báo lỗi (của màn cài đặt), không chồng thêm toast lỗi thứ hai | mục 4 | Functional/UX | Vừa | Thấp | Thấp | P3 |

### C. Bốn chế độ Home Screen + Blur + skip-unchanged + HEIC + tốc độ (mục 5)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-21 | Chạy đủ 7 dòng bảng Chế độ × Blur, đúng cả lock và home theo đúng mô tả | mục 5 | Functional (core) | Vừa | Cao | Cao | P1 |
| TC-22 | 4 chip Off/Same/Photo only/Own photo hiện đủ, chọn đúng | mục 5 | UI | Thấp | Thấp | Thấp | P3 |
| TC-23 | Toggle "Blur Home Screen" chỉ hiện khi chế độ khác Off | mục 5 | Functional (UI logic) | Vừa | Vừa | Vừa | P2 |
| TC-24 | Lock screen luôn nét kể cả khi Blur bật (blur chỉ áp dụng Home) | mục 5 | Functional | Thấp | Cao | Cao | P1 |
| TC-25 | ⚠️ **Chiều "tắt Blur" gần như chắc chắn fail — xem TC-25b/TC-25c.** Bật/Tắt Blur → Update **một lần** → home đổi mờ/nét **ngay** (cả 2 chiều, mỗi chiều 2 lượt) — không được cần bấm lần 2 | mục 5 | Functional (cơ chế redraw mới) | Cao | Cao (note tự nói "báo lỗi" nếu cần bấm 2 lần) | Cao | P1 |
| TC-25b | ✅🔍 **Cấu trúc đã xác nhận qua cross-check tay (mục 1 #1b) — chỉ còn verify hành vi runtime.** Chế độ **Same + Blur TẮT từ đầu** (chưa từng bật): token `same` — khối `If contains "blur"` không có `Otherwise` (đối chứng với nhánh `pair` có đầy đủ Otherwise cho cùng điều kiện) → **0 Set** chạy trước Switch (không đổi cả Lock lẫn Home). Verify: chọn Same, đảm bảo Blur tắt sẵn, bấm Update → lock/home có đổi sang lịch mới không? Ưu tiên chạy sớm nhất trong đợt test — nếu đúng là bug, ảnh hưởng toàn bộ Decision Table 1 (TC-21) | mục 5 + cross-check tay (spec gốc không nhắc) | Functional (bất đối xứng cấu trúc đã xác nhận) | Cao (bất đối xứng thật trong code) | Cao (nếu đúng, Same+Blur-off hoàn toàn không cập nhật wallpaper, kể cả Lock) | Cao | P1 |
| TC-25c | 🆕🔍 **Phân tích thêm khi liệt kê đủ 9 tổ hợp token (2026-09-23) — nghiêm trọng hơn TC-25b, chính là kịch bản TC-25 đang test.** Token `same-redraw` (Same, **vừa TẮT** Blur, trước đó đang bật): vì redraw-if nằm **lồng bên trong** blur-if, mà blur-if lại sai (token không chứa "blur") → redraw-if **không bao giờ chạy tới được**, dù mode đã đánh dấu "vừa đổi Blur, cần vẽ lại". Verify: bật Blur ở Same, Update xong (home đang mờ) → **tắt** Blur, Update **một lần** → home có về nét không, hay vẫn mờ (và Lock có đổi lịch không)? Đây chính là chiều "tắt Blur" của TC-25 — nếu đúng cấu trúc, **kỳ vọng home KHÔNG bao giờ hết mờ được** ở mode Same một khi đã mờ 1 lần | mục 5 + phân tích 9 nhánh token (spec gốc không nhắc) | Functional (hệ quả trực tiếp của #1b, không phải nghi vấn riêng) | Cao | Cao (nếu đúng, Same có 1 chiều Blur không bao giờ hoạt động — không chỉ trạng thái khởi tạo) | Cao | P1 |
| TC-26 | Photo only: home không bị tối dù Darken của lock kéo cao | mục 5 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-27 | Template nhiều ảnh nền theo ngày — Photo only dùng đúng ảnh hôm nay, khớp ảnh dưới lịch trên lock | mục 5 | Functional/data | Vừa | Vừa | Vừa | P2 |
| TC-28 | Photo only (và Own photo — QC bổ sung, xem mục 1 #4) có bị hỏi quyền 2 lần không (ghi vào bảng mục 11) | mục 5 | Exploratory | — | — | Không xếp priority như bug | — |
| TC-29 | Same nhanh hơn Photo only khi Photo only phải ghi home lần đầu (~3–4 giây, đo bằng Last shortcut run, nghỉ 1 phút giữa 2 lần bấm) — ⚠️ **so sánh này chỉ còn đúng ở lần chạy đầu/lần có thay đổi**, vì theo cập nhật mới nhất của dev (mục 1 #2c), từ lần 2 trở đi cả Same lẫn Photo only đều có thể vào nhánh "nhanh" nếu không đổi gì — cần verify lại khoảng chênh 3-4s có còn đúng ở MỌI lần chạy hay chỉ lần đầu | mục 5 + cập nhật dev #2c | Non-functional (Performance) | Vừa | Vừa | Vừa | P2 |
| TC-29b | 🆕 **Từ cập nhật dev #2c, chưa có trong bất kỳ bản spec nào:** Same mode — Update lần 1 ghi timing → không đổi gì, Update lần 2 (nghỉ 1 phút) → nhanh hơn rõ, tương tự cơ chế skip-unchanged của Photo only/Own photo (TC-31/TC-45) — trước đây Same chỉ được mô tả là nhanh nhờ gộp 1 action Lock+Home, chưa từng có cơ chế "bỏ qua nếu không đổi" | Cập nhật dev #2c (không có trong test basis viết tay) | Functional + Non-functional (core mechanism, dev vừa bổ sung) | Vừa–Cao | Vừa | Cao | P1 |
| TC-30 | Đổi chế độ trong editor rồi bấm Cancel thoát → mở lại → chế độ quay về đúng như trước khi mở | mục 5 | Functional/State | Vừa | Vừa | Vừa | P2 |
| TC-31 | 🆕 Photo only: Update lần 1 ghi timing → không đổi gì, Update lần 2 (nghỉ 1 phút) → **nhanh hơn rõ**, home vẫn đúng, console `home=skip-unchanged` | mục 5 | Functional + Non-functional (core mechanism mới) | Vừa–Cao | Vừa (không mất dữ liệu, nhưng là cơ chế trung tâm của bản update này) | Cao | P1 |
| TC-32 | Thêm/sửa 1 sự kiện lịch → Update → vẫn nhanh (ảnh nền không đổi), home vẫn đúng | mục 5 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-33 | Đổi ảnh nền (khác/crop lại/đổi template) → Update → home đổi theo **ngay lần đó**, console `home=set` | mục 5 | Functional | Vừa | Cao (core promise của Photo only) | Cao | P1 |
| TC-34 | Crop lại **cùng một ảnh** → Update → home đổi theo khung crop mới (hash phải nhạy với crop, không chỉ nguồn ảnh) | mục 5 | Functional (edge case của hash) | Vừa–Cao | Vừa | Vừa–Cao | P2 |
| TC-35 | Đổi Blur → Update → home đổi blur ngay, **không** bị skip-unchanged bỏ qua | mục 5 | Functional (giao 2 cơ chế mới) | Cao (2 cơ chế mới chồng nhau) | Cao | Cao | P1 |
| TC-36 | Photo only → Off → tự đổi ảnh home trong iOS → quay lại Photo only → Update → home về đúng ảnh nền template (không giữ ảnh tự chọn qua iOS) | mục 5 | Functional (edge case) | Vừa | Vừa | Vừa | P2 |
| TC-37 | Template nhiều ảnh theo ngày, automation chạy sáng hôm sau → home là ảnh hôm nay dù chưa quá 24h kể từ lần chạy trước | mục 5 | Functional (giao automation × skip-unchanged) | Vừa–Cao | Cao | Cao | P1 |
| TC-38 | ⚠️ **Mâu thuẫn — xem mục 1 #2c.** Test basis (mục 5): qua hơn 24 giờ không đổi gì → lần chạy kế tiếp ghi home đầy đủ 1 lần. Cập nhật miệng mới nhất của dev: đã "tìm được cách" để **không cần gen lại nữa** nếu user không đổi gì — không rõ mốc 24h còn áp dụng hay đã bỏ hẳn. **Verify cả 2 khả năng khi execute**: (a) qua 24h vẫn ghi lại 1 lần như test basis, hoặc (b) qua 24h (thử cả 48h/72h nếu có thời gian) vẫn tiếp tục nhanh, không ghi lại — ghi nhận kết quả thực tế thay vì giả định cái nào đúng | mục 5 (mâu thuẫn với cập nhật dev #2c) | Functional/Performance boundary | Vừa | Vừa | Vừa | P2 |
| TC-39 | 🆕 Template có thẻ bán trong suốt đè ảnh nền → set → soi lock screen tìm vệt màu/sọc/mảng loang | mục 5 | Non-functional (chất lượng ảnh — không ngưỡng khách quan, xem mục 1 #5) | — | Vừa | Vừa | P2 (exploratory) |
| TC-40 | 🆕 Chữ nhỏ trên lịch (giờ, tên sự kiện) không nhoè viền do nén HEIC | mục 5 | Non-functional | — | Vừa | Vừa | P2 (exploratory) |
| TC-41 | 🆕 Khi nghi ngờ chất lượng: đổi Debug → Wallpaper format → PNG, set lại cùng template, so sánh 2 bản làm bằng chứng đính kèm | mục 5, mục 12 | Hỗ trợ điều tra, không phải pass/fail độc lập | — | — | — | — |

### D. Ảnh home riêng — Own photo trong Ink (A) và tự chọn qua iOS (B) (mục 6)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-42 | Chọn Own photo → hiện hàng ảnh: ô + (Photos), ảnh đã upload, ảnh catalog | mục 6.A | UI | Thấp | Thấp | Thấp | P3 |
| TC-43 | Chọn ảnh từ Photos → Update → home đúng ảnh đó, lock vẫn có lịch | mục 6.A | Functional (core) | Vừa | Cao | Cao | P1 |
| TC-44 | Chọn ảnh catalog (vòng xoay tải) → Update → home đúng ảnh đó | mục 6.A | Functional | Vừa | Vừa | Vừa | P2 |
| TC-45 | 🆕 Update lần 2 không đổi gì → nhanh (skip-unchanged), home giữ nguyên, console `home=skip-unchanged` — test **riêng** cho Own photo, không mặc định giống Photo only | mục 6.A | Functional (core mechanism mới) | Vừa–Cao | Cao | Cao | P1 |
| TC-46 | Đổi sang ảnh khác trong Own photo → Update → home đổi theo ngay | mục 6.A | Functional (core) | Vừa | Cao | Cao | P1 |
| TC-47 | Đổi template khác trong khi giữ Own photo → Update → home vẫn là ảnh riêng (không theo template) | mục 6.A | Functional | Thấp | Vừa | Vừa | P2 |
| TC-48 | Chuyển Photo only rồi quay lại Own photo → ảnh đã chọn vẫn còn được chọn (persist qua đổi mode) | mục 6.A | Functional/State | Vừa | Vừa | Vừa | P2 |
| TC-49 | Own photo chưa chọn ảnh nào → Update → home dùng ảnh nền của lock (**không bao giờ** trống/đen) | mục 6.A | Functional (negative/edge case) | Vừa | Cao | Cao | P1 |
| TC-50 | Ảnh vừa chọn từ Photos cũng xuất hiện ở hàng ảnh nền của lock | mục 6.A | Functional phụ | Thấp | Thấp | Thấp | P3 |
| TC-51 | 🆕 Màn khoá ở cặp Ink → Customize → Home Screen (iOS) → chọn ảnh trong Photos → Done | mục 6.B | Setup step (tiền đề cho TC-52) | — | — | — | — |
| TC-52 | Về Ink, chế độ Off, bấm Update → lock đổi lịch mới, home **vẫn là ảnh vừa chọn qua iOS** (Ink không đụng home) | mục 6.B | Functional (core promise của Off, chính là kịch bản QC từng tự phát hiện — nay được spec xác nhận) | Vừa | Cao (vi phạm lời hứa "Off không đụng home" nếu sai) | Cao | P1 |
| TC-53 | Chạy thêm 2 lần (kể cả để automation sáng hôm sau chạy) → home vẫn giữ nguyên ảnh đã chỉnh qua iOS | mục 6.B | Functional, cùng nhóm TC-52 | Vừa | Cao | Cao | P1 |
| TC-54 | 🆕 Chuyển sang Same/Photo only/Own photo rồi Update → home **bị thay** (đúng, vì user tự chọn mode ghi đè) — xác nhận ranh giới đúng của TC-52/53 | mục 6.B | Functional (xác nhận không phải bug) | Thấp | Vừa | Vừa | P2 |

### E. Cặp wallpaper (mục 7)

> Cơ chế và Decision Table chi tiết đã có sẵn, không đổi so với V2 — xem
> [test-plan-ios26-27.md §"Cách shortcut làm"](test-plan-ios26-27.md#7-cặp-wallpaper-một-phần-thăm-dò). Liệt lại
> ở mức test condition để mục 3 (traceability) đầy đủ, **không** thiết kế lại case.

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-55 | Cài mới khi đang ở cặp riêng → màn khoá chuyển sang cặp mới của Ink, số cặp tăng đúng 1, ảnh cặp riêng cũ không đổi | mục 7 | Functional | Vừa | Cao (note tự đánh dấu lỗi chặn phát hành) | Cao | P1 |
| TC-56 | Bấm Update 3 lần liên tiếp → số cặp không đổi | mục 7 | Functional | Vừa | Cao | Cao | P1 |
| TC-57 | Chạy đủ 4 chế độ (Off→Same→Photo only→Own photo) → không chế độ nào tạo thêm cặp mới | mục 7 | Functional | Vừa | Cao (lỗi chặn phát hành) | Cao | P1 |
| TC-58 | Tự chuyển sang cặp khác rồi bấm Update → màn khoá tự quay về cặp Ink | mục 7 | Functional | Vừa | Cao | Cao | P1 |
| TC-59 | Xoá chính cặp của Ink → Update → iOS tạo cặp mới và chuyển sang cặp đó, không báo "Unable to switch"; chạy thêm 2 lần → số cặp không tăng tiếp | mục 7 | Functional | Vừa | Cao | Cao | P1 |

### F. Cảnh báo "Needs the new Ink shortcut" (mục 8)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-60 | Chạy shortcut production, chọn Same/Photo only (và Own photo — QC bổ sung, xem mục 1 #4) → cảnh báo hiện (máy chưa từng chạy shortcut mới) | mục 8 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-61 | Đổi tên chạy shortcut mới, Update 1 lần → đóng/mở lại editor → cảnh báo biến mất | mục 8 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-62 | Với shortcut production, chọn Photo only rồi set → không hiểu chế độ này, vẫn set cả lock+home bằng ảnh có lịch kèm blur như cũ (xác nhận, không phải bug) | mục 8 | Functional (xác nhận) | Thấp | Thấp | Thấp | P3 |

### G. Automation iOS 27 (mục 9 V2-updated + toàn bộ [qc-shortcut-triggers-ios27.md](../../specs/shortcuts/qc-shortcut-triggers-ios27.md))

> 🆕 **Mở rộng 2026-09-23:** V2-updated mục 9 chỉ mô tả **1 automation (Sunrise)**. Test basis thứ 2 tiết lộ
> shortcut thật mang sẵn **4 automation** (Sunrise, When Ink/Calendar/Google Calendar closed). TC-63→68 (Sunrise)
> giữ nguyên/mở rộng nhẹ; TC-74 trở đi là hoàn toàn mới, rút từ tài liệu thứ 2. ⚠️ Toàn bộ nhóm G phụ thuộc vào
> việc chốt mục 1 vấn đề #7 (file `V2` có phải cùng bản đã cross-check Home Screen không).

**G.1 — Sunrise (mục 4.1 + mục 9 V2-updated)**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-63 | Sau cài, automation Sunrise có mặt, đang bật hay tắt (mặc định phải là **tắt**, theo mục 7 tài liệu 2) | mục 9 + mục 7 (tài liệu 2) | Exploratory | — | Cao | Cao | P1 |
| TC-64 | Allow Running When Locked ngay sau cài (trước khi tự bật) đang bật hay tắt? | mục 9 | Exploratory | — | Cao | Cao | P1 |
| TC-65 | Sunrise có xin quyền vị trí không (lần đầu bật hoặc lần đầu chạy)? | mục 9 + mục 4.1 (tài liệu 2) | Functional | Vừa | Vừa | Vừa | P2 |
| TC-66 | Máy khoá qua đêm, **chưa mở khoá** → sáng hôm sau wallpaper đổi đúng ngày mới, không hỏi xác nhận, không hiện "running your automation" | mục 9 + mục 4.1 (tài liệu 2) | Functional (core, liên quan BUG-004) | Vừa | Cao | Cao | P1 |

**G.2 — When Calendar is closed / When Google Calendar is closed (🆕 mục 4.2, 4.3 tài liệu 2)**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-78 | 🆕 Thêm sự kiện mới trong Lịch → về Home (vuốt lên, không mở Ink) → automation chạy trong vài giây, wallpaper cập nhật | mục 4.2 | Functional (core, hoàn toàn mới) | Vừa | Cao | Cao | P1 |
| TC-79 | 🆕 Chỉ **chuyển sang app khác** (App Switcher), không về Home — có tính là "closed" để kích hoạt automation không? | mục 4.2 | Functional (ranh giới hành vi chưa rõ) | Không xác định | Vừa | Vừa | P2 |
| TC-80 | 🆕 **Vuốt tắt hẳn** Lịch trong App Switcher — có tính "closed" không? | mục 4.2 | Functional (ranh giới hành vi chưa rõ) | Không xác định | Vừa | Vừa | P2 |
| TC-81 | 🆕 Mở Lịch rồi thoát ngay, **không sửa gì** — automation vẫn chạy (đúng thiết kế theo tài liệu 2) — đo mất bao lâu, có làm máy khựng không | mục 4.2 | Non-functional (performance/UX) | Vừa | Thấp | Thấp | P3 |
| TC-82 | 🆕 Lặp lại TC-78 với **Google Calendar** (tài khoản đã kết nối Ink) | mục 4.3 | Functional (core) | Vừa | Cao | Cao | P1 |
| TC-83 | 🆕 Máy **không cài** Google Calendar — dòng automation "When Google Calendar is closed" hiện ra sao, có báo lỗi không? | mục 4.3 | Robustness (edge case) | Vừa | Vừa | Vừa | P2 |

**G.3 — When Ink is closed (🆕 mục 4.4 tài liệu 2 — rủi ro cao nhất nhóm G, trùng đúng 1 trong "7 rủi ro chạy ngầm" QC từng tự liệt kê trước đây)**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-84 | 🆕 Trong Ink, đổi template/chế độ Home Screen → rời Ink **mà không bấm Set/Update** → màn khoá **có** cập nhật theo lựa chọn mới không? (nếu có, nghĩa là chỉ cần đổi setting rồi thoát app cũng đủ trigger set — khác hẳn giả định cũ "chỉ Set/Update mới kích hoạt shortcut") | mục 4.4 | Functional (hành vi mới, tiềm ẩn rủi ro set nhầm khi mới đang xem thử) | Cao | Cao | Cao | P1 |
| TC-85 | 🆕 **Rủi ro race condition đã lường trước:** rời Ink **ngay sau khi** bấm Update — shortcut có chạy **2 lần liên tiếp** không (1 lần do Update, 1 lần do automation "Ink closed")? Có hiện toast lỗi (do đè lên nhau) không? | mục 4.4 | Functional (reliability, data integrity) | Cao (2 trigger cùng lúc) | Cao | Cao | P1 |
| TC-86 | 🆕 Không bị **vòng lặp**: shortcut chạy xong (đóng Ink) không tự làm Ink "closed" thêm 1 lần nữa (tránh spam chạy liên tục) | mục 4.4 | Robustness | Thấp | Cao (nếu xảy ra, spam automation liên tục) | Cao | P1 |

**G.4 — Kiểm tra chung sau MỌI lần automation chạy (🆕 mục 5 tài liệu 2 — áp dụng cho cả 4 automation)**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-87 | 🔴 **Regression cho bug đã có báo cáo thật (không phải giả thuyết):** Lock phải có lịch, Home chỉ có ảnh nền (chế độ khác Off). Nếu **2 màn bị đổi chỗ** (Lock chỉ có nền, Home có lịch) — tài liệu 2 xác nhận **đã từng xảy ra thật lúc 00:05** — ghi lại ngay: chế độ Home Screen, Blur, máy đang khoá hay mở, và chạy tay (không qua automation) có tái hiện được không | mục 5 (tài liệu 2) | Functional — **regression test cho bug đã biết**, không phải thăm dò | Cao (đã có tiền lệ thật) | Cao (Lock/Home đổi chỗ là lỗi hiển thị nghiêm trọng) | 🔴 Cao nhất nhóm G | P1 |
| TC-88 | Sau mỗi lần automation chạy, màn khoá vẫn đang dùng đúng **cặp wallpaper của Ink** (Switch chạy đúng, không lệch sang cặp khác) | mục 5 (tài liệu 2) | Functional | Vừa | Cao | Cao | P1 |
| TC-89 | 🆕 Settings → Debug: "Last shortcut run" có số liệu mới sau mỗi lần chạy; thẻ **In-app messages** có dòng `Runs Ink Refresh Lock Screen V2 · old still running false` — nếu thấy `true`, nghĩa là **1 automation vẫn đang gọi shortcut cũ chồng lên automation mới** (dấu hiệu trực tiếp của race condition, liên quan TC-85) | mục 5 (tài liệu 2) | Observability — dùng làm bằng chứng chẩn đoán cho TC-85/87 | Vừa | Cao (chỉ báo sớm cho race condition) | Cao | P1 |

**G.5 — Trường hợp biên / cài đặt (🆕 mục 3, 6 tài liệu 2)**

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-74 | 🆕 **Nền tảng cho cả nhóm G:** trước khi cài, xoá **hết** shortcut Ink cũ và xác nhận tab Automation không còn dòng nào của Ink — nếu bỏ qua bước này, cài đè bằng Replace có thể để automation cũ chạy song song với bản mới, làm mọi kết quả automation sau đó **không đáng tin** | mục 3 (tài liệu 2) | Entry criteria / Setup | Vừa (dễ bỏ qua nếu không đọc kỹ) | Cao (làm hỏng toàn bộ baseline nhóm G) | Cao | P1 |
| TC-75 | Bật **Allow Running When Locked** ngay sau khi cài (nếu có tuỳ chọn này) | mục 3 (tài liệu 2) | Setup, liên quan trực tiếp TC-66/BUG-004 | Vừa | Cao | Cao | P1 |
| TC-76 | Bật đủ **cả 4 dòng automation** trực tiếp từ danh sách tab Automation, không cần vào Edit từng dòng | mục 3 (tài liệu 2) | Functional (UX cài đặt) | Thấp | Vừa | Vừa | P2 |
| TC-77 | Mỗi automation mặc định là **Run Immediately** hay **Run After Confirmation**? Ghi nhận mặc định rồi đổi sang Run Immediately để test các case còn lại | mục 3 (tài liệu 2) | Functional/UX, ghi nhận | Thấp | Thấp | Thấp | P3 |
| TC-90 | 🆕 Chế độ nguồn điện thấp (Low Power Mode) hoặc máy nóng — automation Sunrise có bị iOS tự bỏ qua không? | mục 6 (tài liệu 2) | Robustness (edge case hệ điều hành) | Thấp | Vừa | Vừa | P3 |
| TC-91 | 🆕 Bình minh và mở Lịch xảy ra **cùng lúc** (2 automation trigger gần nhau) — có lỗi chồng chéo gì không (liên hệ trực tiếp cơ chế `old still running` ở TC-89) | mục 6 (tài liệu 2) | Robustness (concurrency) | Thấp | Cao (nếu xảy ra, đúng dạng race condition đã lo ngại) | Vừa | P2 |
| TC-67 | Cài lại **cùng file** (Replace) → tab Automation có bị **trùng dòng** cho cả 4 automation không? Dòng cũ còn bật không? | mục 6 (tài liệu 2), mở rộng từ mục 9 V2-updated | Functional | Vừa | Vừa | Vừa | P2 |
| TC-92 | 🆕 **Xoá shortcut** → cả 4 dòng automation có biến mất theo không (không để sót automation mồ côi) | mục 6 (tài liệu 2) | Functional | Vừa | Vừa | Vừa | P2 |
| TC-68 | Máy **Apple Account khác** → cài file → cả **4 automation** có về máy không, bật hay tắt (mở rộng từ chỉ-Sunrise sang cả 4) | mục 6 (tài liệu 2), mở rộng từ mục 9 V2-updated | Functional/Multi-tenant | Vừa | Vừa | Vừa | P2 |

> ⚠️ **Không dùng link `43e6966e…`** làm căn cứ test (tài liệu 2, mục 2 + mục 7): bản này bị sửa tay, chỉ còn
> 1 automation ở giờ cố định 00:05, tên không có "V2" — **không đại diện** cho hành vi 4-automation cần test,
> chỉ giữ lại để biết đây là nguồn phát sinh báo cáo bug TC-87 (Lock/Home đổi chỗ lúc 00:05).

**G.6 — 🆕 Trigger qua Notification (phát hiện qua ảnh chụp thực tế 2026-09-23, chưa có trong BẤT KỲ spec nào) — ✅ ĐÃ XÁC NHẬN LÀ THIẾT KẾ THẬT (Q6)**

> User chụp lại automation thật trên máy, thấy điều kiện kích hoạt là **"At 12:05 AM" HOẶC "When I receive a
> notification from Ink Dev, Title contains 'update_lockscreen'"** — 2 điều kiện nối bằng `or` trong cùng 1
> automation. Ảnh 1 cho thấy thông báo thật: tiêu đề `update_lockscreen`, nội dung "Your schedule changed." —
> app tự gửi 1 push/local notification với tiêu đề cố định, và automation bắt đúng tiêu đề đó để tự chạy
> shortcut, **không cần chờ tới giờ cố định hay đóng app nào cả**. Theo user, đây là khả năng **chỉ có từ iOS
> 27 trở đi**, iOS 26 trở về trước không có.
> ✅ **Trả lời (Q6, 2026-09-23):** User xác nhận đúng theo thiết kế của chính shortcut — điều kiện automation
> **luôn là "theo thời gian đã set sẵn HOẶC qua notification"**, đây là cấu trúc `or` có chủ đích, không phải
> hệ quả của việc sửa tay bản `43e6966e…`. Cơ chế notification-trigger là **thật và chính thức**, không phải
> tình cờ chỉ có ở bản bị sửa. (Riêng con số giờ cụ thể "12:05 AM" trong ảnh vẫn có thể là giờ test tạm trên
> máy này, không ảnh hưởng tới kết luận về notification-trigger.)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-93 | 🆕 App gửi notification tiêu đề `update_lockscreen` → automation tự bắt và chạy shortcut, **không cần** mở app, không cần đợi Sunrise/đóng app nào | Ảnh chụp thực tế (không có trong spec) | Functional (core, cơ chế trigger mới) | Cao | Cao (nếu đây là đường trigger chính thức mới, ảnh hưởng toàn bộ chiến lược update) | Cao | P1 |
| TC-94 | 🆕 Notification từ Ink Dev nhưng **tiêu đề khác** (không chứa `update_lockscreen`) → **không** trigger shortcut (negative test, tránh chạy nhầm khi có notification khác như nhắc lịch/task) | Suy luận từ điều kiện `Title contains` | Robustness (negative) | Vừa | Cao (nếu trigger nhầm, chạy shortcut ngoài ý muốn liên tục) | Cao | P1 |
| TC-95 | 🆕 Notification đến khi máy **đang khoá** → automation vẫn chạy được nếu đã bật Allow Running When Locked (liên hệ trực tiếp TC-75) | Suy luận | Functional | Vừa | Cao | Cao | P1 |
| TC-96 | 🆕 Notification đến gần cùng lúc với 1 trigger khác đang chạy (Sunrise/Calendar closed/Ink closed) → có bị chạy chồng/race không (liên hệ TC-89, cờ `old still running`) | Suy luận, cùng rủi ro concurrency đã nêu ở TC-91 | Robustness (concurrency) | Thấp | Cao | Vừa | P2 |
| TC-97 | 🆕 Notification `update_lockscreen` hiện ra **có phải nội dung user thật sự cần thấy không**, hay đây là tín hiệu nội bộ vô tình hiện ra ngoài (tên biến kỹ thuật `update_lockscreen` lộ ra UI, không phải văn bản thân thiện)? Nếu là tín hiệu nội bộ, có nên ẩn đi (silent notification) thay vì hiện banner cho user | Ảnh chụp thực tế | Usability | Vừa | Vừa (không chặn chức năng, nhưng lộ chi tiết kỹ thuật ra UI thật) | Vừa | P2 |

### H. Chéo phiên bản (mục 10) — kế thừa nguyên trạng gap cũ (`MinimumClientVersionString`, chưa đổi ở V2-updated)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-69 | Cài file `iOS 27/Dev` lên máy iOS 26 → cài được không, action chạy bình thường (automation bị bỏ qua)? | mục 10 | Compatibility/Exploratory | Không xác định (gap cũ, chưa được V2-updated làm rõ) | Vừa | Vừa | P2 |

### I. Công cụ Debug — mục hoàn toàn mới (mục 12)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-70 | 🆕 "Last shortcut run" hiển thị đúng 2 số liệu tách biệt (after-render→confirm, total) khớp với thời gian thực đo được — **là công cụ đo nền tảng cho TC-29/31/38** | mục 12 | Functional + Non-functional | Vừa | Cao (nếu sai, mọi case tốc độ mất căn cứ đo) | Cao | P1 |
| TC-71 | 🆕 "Wallpaper format" chọn được PNG/JPEG/HEIC 1.0, mặc định đúng HEIC 1.0 | mục 12 | Functional | Thấp | Thấp | Thấp | P3 |
| TC-72 | 🆕 Mục Debug chỉ xuất hiện ở bản Dev, không có ở Prod | mục 12, mục 13 | Functional (smoke) | Thấp | Vừa (lộ công cụ debug ra bản thật) | Vừa | P3 |
| TC-73 | 🆕 Log console lọc "Ink" hiện đủ dòng `[InkShortcut]` (token, thời gian, `thermal=`, kết quả callback) | mục 12 | Observability (hỗ trợ QC, không ảnh hưởng user cuối) | Thấp | Thấp | Thấp | P3 |

---

## 3. Traceability nháp

| Test condition # | Mục test basis | Ghi chú cho test-plan |
|---|---|---|
| TC-01 → TC-10 | mục 1, 3, 3.1, 3.2 | Nhóm nền tảng — nếu sai, mọi case sau không đáng tin (giữ nguyên nguyên tắc test-plan-ios26-27.md §2 #1). TC-01/03 chờ Q1 trước khi viết Decision Table đếm action cụ thể. |
| TC-11 → TC-20 | mục 4 | TC-11–16 là regression thuần (đã có sẵn Decision Table/case tương đương ở test-plan cũ, có thể tái dùng kỹ thuật, không cần thiết kế lại). TC-17–20 là nhóm case **hoàn toàn mới** (toast) — cần Decision Table riêng theo vị trí hiển thị (màn edit / sheet / lỗi cài đặt). |
| TC-21 → TC-41 | mục 5 | TC-21 tái dùng Decision Table 1 sẵn có. TC-25, 31–38 là nhóm case **mới, phức tạp nhất** của bản update — gợi ý test-plan dùng **State Transition Testing** cho tổ hợp (mode × blur-thay-đổi × hash-ảnh × mốc 24h) thay vì liệt bảng phẳng, vì các biến này tương tác lẫn nhau (xem TC-35, TC-37). TC-39–41 gợi ý xếp vào Exploratory (giống cách mục 7 V2 cũ từng được xử lý ở test-plan-ios26-27.md §5) vì không có ngưỡng pass/fail cứng. |
| TC-42 → TC-54 | mục 6 | TC-42–50 (Own photo trong Ink) phần lớn kế thừa được kỹ thuật EP/State Transition đã dùng ở test-plan cũ cho Own photo, chỉ thêm TC-45 (skip-unchanged). TC-51–54 (mục 6.B, hoàn toàn mới) chính thức hoá risk QC từng tự phát hiện (`TC-SH-A8/A9`, `TC-SH-PAIR-07/08/09` trong test-plan-ios26-27.md) — gợi ý test-plan **liên kết ngược** tới các case đó thay vì thiết kế lại từ đầu, chỉ bổ sung phần automation ghi đè qua đêm (tương đương TC-SH-A9 cũ) nếu Q2 xác nhận theo hướng (a). |
| TC-55 → TC-59 | mục 7 | Không thiết kế lại — dẫn chiếu thẳng Decision Table cặp wallpaper đã có ở test-plan-ios26-27.md (BVA "trước/sau 4 chế độ", "trước/sau 3 lần Update"). |
| TC-60 → TC-62 | mục 8 | Tái dùng Decision Table 3 (cảnh báo vàng) đã có, chỉ cân nhắc thêm dòng Own photo theo gợi ý mục 1 #4. |
| TC-63 → TC-68, TC-74 → TC-92 (nhóm G, cả 5 nhóm con G.1–G.5) | mục 9 V2-updated + toàn bộ [qc-shortcut-triggers-ios27.md](../../specs/shortcuts/qc-shortcut-triggers-ios27.md) | Sunrise (G.1) tái dùng charter Exploratory cũ + bảng thăm dò mục 11 V2-updated. 4 nhóm còn lại (G.2–G.5) hoàn toàn mới — gợi ý test-plan dùng **State Transition Testing** cho định nghĩa "closed" (App Switcher / vuốt tắt / về Home, TC-79/80) vì ranh giới hành vi chưa rõ, và xếp TC-87 (Lock/Home đổi chỗ) thành **regression case bắt buộc**, không phải case thăm dò, vì đã có báo cáo thật. ⚠️ Toàn bộ nhóm phụ thuộc câu trả lời mục 1 vấn đề #7 (file V2 có phải cùng bản đã cross-check Home Screen không) trước khi coi các số action/token ở mục 1.2 có áp dụng được cho file này không. |
| TC-69 | mục 10 | Gap `MinimumClientVersionString` (gap #7 cũ trong test-plan-ios26-27.md) **chưa được V2-updated làm rõ thêm** — kế thừa nguyên trạng câu hỏi cũ, không cần hỏi lại riêng ở đây. |
| TC-70 → TC-73 | mục 12 | Nhóm hoàn toàn mới, chưa có tiền lệ ở test-plan cũ — cần thiết kế case mới hoàn toàn, không tái dùng được gì. |

---

## 4. Câu hỏi cần làm rõ trước khi lập test plan

1. ✅ **(Q1 — ĐÃ ĐÓNG HOÀN TOÀN 2026-09-22.)** User tự cross-check tay toàn bộ shortcut thật, xác nhận đúng
   **7 Set / 2 Switch** (không phải 11/3 spec công bố). Chỉ còn việc báo dev sửa số trong spec §3.1.

   ✅ **(Q1b — ĐÃ XÁC NHẬN CẤU TRÚC 2026-09-22 qua chính cross-check trên, không còn là nghi vấn đọc ảnh.)**
   Nhánh `same` + `blur` **thật sự không có `Otherwise`**, trong khi nhánh `pair` (cùng điều kiện `contains
   "blur"`) **có đầy đủ** — bất đối xứng thật trong code, nhiều khả năng là sai sót build. Việc còn lại **không
   còn là "có tồn tại gap không"** mà là **"gap này gây hậu quả gì khi chạy thật"** — verify bằng cách chạy
   Same + Blur tắt trên máy (TC-25b, P1, ưu tiên chạy sớm nhất đợt test) trước khi chính thức báo bug cho dev.

2. ✅ **(Q2 — ĐÃ ĐÓNG 2026-09-22.)** Dev xác nhận Own photo vẫn tồn tại (đính chính sau phát biểu ban đầu là đã
   bỏ), dùng chung nhánh code với Photo only → suy ra hợp lý Own photo vẫn đủ điều kiện cho "home history" của
   Off giống Photo only. TC-52/53 đã gỡ trạng thái chờ. Xem mục 1 #2, #2b, #3.

3. ✅ **(Q3 — ĐÃ ĐÓNG 2026-09-22.)** User xác nhận: vẫn out-of-scope, 2 hành vi (crop Own photo, PRO-gating ảnh
   catalog cho Home) chưa được fix, tài liệu chỉ quên copy lại. Không mở lại thành in-scope. Xem mục 1 #4.

4. 🆕 **(Q4 — MỚI, từ cập nhật dev #2c, chặn TC-29/TC-29b/TC-38, mức P1/P2)** Dev báo miệng qua QC 2 thay đổi
   chưa có trong bất kỳ bản spec nào: (a) Same mode giờ cũng có cơ chế skip-unchanged như Photo only/Own photo
   (nhanh hơn từ lần chạy thứ 2 nếu không đổi gì); (b) đã tìm được cách để **không phải ghi lại home mỗi ngày**
   nếu user không đổi gì — mâu thuẫn trực tiếp với mục 5 test basis ("qua hơn 24 giờ vẫn ghi đầy đủ 1 lần").
   **Cần dev xác nhận bằng văn bản** (hoặc QC tự verify khi execute, đã ghi rõ cách verify ở TC-38): mốc 24h còn
   tồn tại dưới hình thức nào không, hay bỏ hẳn? Nếu bỏ hẳn, cần cập nhật lại chính spec V2-updated (không chỉ
   tài liệu test) vì đây là hành vi user-facing quan trọng.

5. ✅ **(Q5 — ĐÃ ĐÓNG 2026-09-23.)** User xác nhận vẫn là **cùng 1 bản build hiện tại**, không phải bản mới/khác
   — chỉ khác là phần automation (nhóm G) chỉ test được trên máy chạy iOS 27, và nội dung tài liệu triggers là
   thông tin bổ sung ngoài spec gốc chứ không mô tả 1 build riêng. Kết luận mục 1/1.2 vẫn áp dụng cho nhóm G,
   không cần cross-check lại. Xem mục 1 #7.

6. ✅ **(Q6 — ĐÃ ĐÓNG 2026-09-23.)** User xác nhận cấu trúc automation **luôn là "theo thời gian đã set sẵn HOẶC
   qua notification"** theo đúng thiết kế của chính shortcut — không phải hệ quả của việc sửa tay bản
   `43e6966e…`. Cơ chế trigger qua notification (nhóm G.6) là thật và chính thức. Xem mục 1 §G.6.

> Q1b và Q4 vẫn **ảnh hưởng trực tiếp risk level hoặc phạm vi của ít nhất 1 test condition P1** (TC-25b/c,
> TC-29b) — theo quy tắc mục 0 của skill test-analysis, **vẫn dừng ở đây** cho 2 câu này, chưa chạy test-plan
> cho tới khi có câu trả lời hoặc user tự verify xong (Q1 gốc đang được user tự verify), hoặc user xác nhận rõ
> một hướng giả định để tiếp tục ở trạng thái DRAFT.
