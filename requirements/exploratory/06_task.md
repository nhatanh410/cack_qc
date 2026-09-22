# Exploratory Checklist — 06 Task

> **Nguồn:** [wireframe](../ui/ux/wideframes/06_task.md) · 8 screenshot iPhone (S01–S04 + `05_task-matrix`:
> `default`, `completed-empty`, `customize`, `customize-scrolled` — mới bổ sung 2026-09-09) + 2 screenshot iPad
> — ⚠️ wireframe **chưa cover Matrix mode (S05)**, dùng trực tiếp
> [screenshots/iphone/06_task/index](../ui/ux/screenshots/iphone/index.md#06_task--tab-tasks) +
> [QC-matrix-guide-l10n.md](../specs/matrix-guide-l10n/QC-matrix-guide-l10n.md) mục 1–2 làm nguồn thay thế — xem cảnh báo ở §0.
> 4 state đã có ảnh iPhone thật; các state còn lại (đang kéo task giữa ô, đã reset, banner→preview, ô đã
> có tên/màu/icon custom) **vẫn chỉ có mô tả text từ change note, chưa có ảnh** — không suy diễn hình dạng.
> **Khung đánh giá:** [exploratory-references](../../references/exploratory-references.md)
> **Quyền liên quan:** [permissions-matrix §1.2 Reminders](../../references/permissions-matrix.md#-12--reminders)
> **Risk/priority:** đối chiếu [test plan 1.2.14](../test-plans/matrix-guide-l10n/1.2.14-matrix-guide-l10n.md) mục 6 — case đánh
> P1 trong test plan được gắn 🔴 ở đây.
> **Build:** TestFlight 1.2.14 (build number chưa xác định) · **Thiết bị:** ____________ · **Người test:** ____________

---

## 0 · Framing

**Q1 — Mục tiêu user của flow này:** quản lý to-do hằng ngày, và (mới từ 1.2.14) sắp xếp task theo **ma trận
Eisenhower tự tuỳ biến** để đưa lên lock screen — không chỉ xem list phẳng.

**Q8 — Mục tiêu business:** Matrix mode là bề mặt wallpaper **mới** để đẩy user quay lại app thường xuyên hơn
(thêm 1 loại lock screen ngoài calendar) — xem [test plan §6](../test-plans/matrix-guide-l10n/1.2.14-matrix-guide-l10n.md#6-risk-based-prioritization).

**Rủi ro xuyên suốt chạm vào flow này:**
- [exploratory-references §1.4](../../references/exploratory-references.md#14--đồng-bộ-2-chiều-với-apple-calendar--reminders-có-làm-mất-dữ-liệu-không) — task nguồn Reminder/Ink, xoá/sửa 2 chiều
- [exploratory-references §1.2](../../references/exploratory-references.md#12--lock-screen-là-ảnh-tĩnh-dữ-liệu-cũ-tới-mức-nào-là-chấp-nhận-được) — mục "push matrix lên lock screen" chịu chung rủi ro dữ liệu cũ của mọi wallpaper
- [permissions-matrix §Reminders](../../references/permissions-matrix.md#-12--reminders) — từ chối Reminders chặn cả tab Tasks (đã quan sát ở S04 wireframe cũ); chưa rõ Matrix mode có bị chặn theo cùng cách không

**⚠️ Lưu ý nguồn — đọc trước khi chạy:** `06_task.md` (wireframe) chỉ mô tả S01–S04 (task list/create/detail/edit)
từ trước bản 1.2.14, **không có S05 Matrix**. Từ 2026-09-09 đã có 4 ảnh iPhone thật cho S05 (`default`,
`completed-empty`, `customize`, `customize-scrolled`) — xác nhận layout 4 ô, banner mục 2.1, popup mở rộng
(note 1.1), và UI thật của sheet Customize. Các state còn lại (đang kéo task giữa ô, đã reset, banner→preview,
ô đã có tên/màu/icon custom) **vẫn chỉ có mô tả text từ change note, chưa có ảnh** — không suy diễn hình dạng.
Cần cập nhật wireframe chính thức (thêm S05) sau đợt QC này; skill này không tự sửa wireframe.

**Phát hiện mới từ 3 ảnh bổ sung 2026-09-09 (không có trong change note):**
- Banner mục 2.1 có copy chính xác: *"Put your matrix on the lock screen"*.
- Header Tasks có **3 nút tròn** (`?` help/guide, `List`, filter) — ảnh iPad batch cùng ngày chỉ có 2 nút,
  chưa rõ là khác biệt device thật hay khác version app *(TSK-Q07)*.
- Popup của 1 ô (note 1.1) có sẵn **sub-tab Completed riêng cho ô đó**, và icon **✎** trong popup mới là lối
  vào sheet **Customize** — note không mô tả 2 chi tiết này *(TSK-H21, TSK-H23)*.
- Sheet Customize sửa **tên + subtitle + màu + icon trong cùng một chỗ**, có nút **Save** riêng ở cuối sheet
  và nút **✕** riêng ở popup nền — 2 điểm thoát khác nhau, chưa rõ hành vi lưu/huỷ của từng nút *(TSK-N08)*.
- Icon mặc định là trạng thái **"no icon"** (dấu cấm), không phải bỏ trống danh sách — chưa rõ có bấm lại
  được để xoá icon đã chọn không *(TSK-E12)*.

---

## 1 · Happy path — `TSK-H`

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **TSK-H01** | Mở tab Tasks lần đầu, chưa có task | S01 empty: *"Today doesn't have any tasks yet"* + *"Click '+' to create your first task"* | — | ☐ |
| **TSK-H02** | Bấm `+`, chỉ điền Title | S02, nút `✓` chuyển từ xám (disabled) sang đen (enabled) | — | ☐ |
| **TSK-H03** | Lưu task | Về S01 filled — task xuất hiện ở **cả hai** section "Today" và "Plan tasks" | — | ☐ |
| **TSK-H04** | Tap vào task | Mở S03 Task detail đúng thông tin đã nhập | — | ☐ |
| **TSK-H05** | Bấm `✎` | Mở S04 Edit task, mọi trường điền sẵn đúng dữ liệu | — | ☐ |
| **TSK-H06** | Chuyển segmented `All → Reminder → Ink` | Danh sách lọc đúng theo nguồn task | — | ☐ |
| **TSK-H07** | Bấm icon chuyển chế độ Matrix (góc phải header) | Hiện đúng 4 ô Do now/Plan/Delegate/Drop mặc định — đối chiếu [06_task_05_task-matrix_default.png](../ui/ux/screenshots/ipad/06_task/06_task_05_task-matrix_default.png) | — | ☐ |
| **TSK-H08** | Chạm vào 1 ô | Ô phóng to thành popup giữa màn hình, nền mờ + tối *(note 1.1)* — đã xác nhận qua [`06_task_05_task-matrix_completed-empty.png`](../ui/ux/screenshots/iphone/06_task/06_task_05_task-matrix_completed-empty.png) | — | ☑ |
| **TSK-H09** | Xem mép dưới màn hình lúc popup mở | Tab bar bị che **hoàn toàn** — không còn dải sáng ở đáy *(note 1.2)* | — | ☐ |
| **TSK-H10** | Đổi tên ô trong popup, lưu | Tên mới hiện đồng thời: card, popup, chip task trong list *(note 1.3)* | — | ☐ |
| **TSK-H11** | Đổi subtitle ô | Subtitle đổi theo *(note 1.4)* | — | ☐ |
| **TSK-H12** | Đổi màu ô | Card đổi màu — task thuộc ô đó trong list cũng đổi màu theo *(note 1.5)* | — | ☐ |
| **TSK-H13** | Chọn icon cho ô | Icon hiện trước tên ô *(note 1.6)* | — | ☐ |
| **TSK-H14** | Kéo 1 task từ ô A sang ô B | Task cập nhật đúng ô mới, cả 2 ô hiển thị đúng ngay | — | ☐ |
| **TSK-H15** | Bấm nút Reset khi ô đã sửa | Ô về nguyên bản tên + màu + icon *(note 1.9)* | — | ☐ |
| **TSK-H16** | Kill app, mở lại | Toàn bộ tuỳ biến matrix (tên/màu/icon) còn nguyên *(note 1.11)* | — | ☐ |
| **TSK-H17** | Ở tab Tasks/Matrix, wallpaper hiện tại **không** phải matrix | Banner 1 dòng, copy đúng *"Put your matrix on the lock screen"* — đã xác nhận trên ảnh iPhone thật *(note 2.1)* | — | ☑ |
| **TSK-H18** | Bấm banner | Nhảy sang Discover, mở **đúng** template matrix đó *(note 2.2)* | — | ☐ |
| **TSK-H19** | Sau khi áp matrix làm wallpaper, quay lại tab Tasks | Banner biến mất, nút tròn Update nổi hiện thay *(note 2.3)* | — | ☐ |
| **TSK-H20** | Bấm Update | Mở màn preview wallpaper hiện tại *(note 2.4)* | — | ☐ |
| **TSK-H21** | Trong popup ô, bấm icon ✎ cạnh tên ô | Mở bottom sheet **Customize** — field tên + field subtitle + Color (11 màu) + Choose an icon *(chi tiết mới, note không mô tả UI cụ thể)* — đã xác nhận qua [`06_task_05_task-matrix_customize.png`](../ui/ux/screenshots/iphone/06_task/06_task_05_task-matrix_customize.png) | — | ☑ |
| **TSK-H22** | Trong sheet Customize, cuộn xuống | Header thu gọn dính trên cùng, lộ thêm icon + nút **Save** ở cuối — đã xác nhận qua [`06_task_05_task-matrix_customize-scrolled.png`](../ui/ux/screenshots/iphone/06_task/06_task_05_task-matrix_customize-scrolled.png) | — | ☑ |
| **TSK-H23** | Trong popup ô, chuyển sang sub-tab **Completed** | Hiện danh sách task đã hoàn thành **của riêng ô đó**, rỗng thì hiện *"No completed tasks yet"* *(chi tiết mới, note không mô tả)* — đã xác nhận qua [`06_task_05_task-matrix_completed-empty.png`](../ui/ux/screenshots/iphone/06_task/06_task_05_task-matrix_completed-empty.png) | — | ☑ |

---

## 2 · Negative — `TSK-N`

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **TSK-N01** | Xoá trắng tên ô rồi lưu | Quay về tên mặc định, card **không** để trống *(note 1.7)* | Card trống, vỡ layout | 🟠 | ☐ |
| **TSK-N02** | Nhập tên toàn dấu cách rồi lưu | Như N01, về mặc định *(note 1.8)* | Tên hiện toàn khoảng trắng, card trông "trống" | 🟠 | ☐ |
| **TSK-N03** | Sửa ô A, kiểm tra ô B/C/D | 3 ô kia **không** bị ảnh hưởng *(note 1.10)* | Lỗi lan, mất tuỳ biến ô khác | 🔴 | ☐ |
| **TSK-N04** | Tạo vài task, kéo vào các ô, **đổi tên cả 4 ô**, kill app, mở lại | Task **vẫn nằm đúng ô cũ** — đổi tên chỉ là hiển thị *(note 1.12, P1 theo test plan)* | Task rơi ra ngoài / nhảy ô — mất dữ liệu phân loại | 🔴 | ☐ |
| **TSK-N05** | Đổi tên 1 ô, rồi đổi ngôn ngữ máy | Ô **đã đặt tên** giữ tên user; ô **chưa đặt tên** đổi theo ngôn ngữ mới *(note 1.13, P1)* | Tên custom bị ghi đè bởi bản dịch, hoặc ô mặc định không dịch | 🔴 | ☐ |
| **TSK-N06** | Chỉ đổi **màu** 1 ô (không đổi tên), rồi đổi ngôn ngữ máy | Tên ô đó **vẫn dịch** theo ngôn ngữ mới — chỉ màu là custom *(note 1.14, P1)* | Tên bị đóng băng theo tiếng cũ dù chưa từng custom tên | 🔴 | ☐ |
| **TSK-N07** | Bấm khu vực nút Reset khi ô **chưa** bị sửa gì | Nút Reset **không được hiện** — không có gì để bấm *(đảo ngược note 1.9)* | Reset hiện sẵn, user bấm nhầm mất mặc định (vô hại nhưng gây nhiễu) | 🟡 | ☐ |
| **TSK-N08** | Trong sheet Customize, sửa tên/màu/icon xong bấm nút **✕** đóng popup nền (không cuộn xuống bấm **Save**) | *(2 nút khác nhau đã xác nhận qua ảnh: ✕ ở popup ô, Save ở cuối sheet Customize — chưa rõ ✕ có huỷ luôn thay đổi trong Customize chưa lưu không)* | Mất thao tác vừa làm, hoặc ngược lại lưu nhầm dù chưa bấm Save | 🟠 | ☐ |
| **TSK-N09** | Đổi tên/màu ô rồi bấm Update ở mục 2 ngay khi popup vẫn đang mở | Không crash, không mất dữ liệu vừa nhập | Race condition giữa lưu popup và mở preview | 🟠 | ☐ |
| **TSK-N10** | Từ preview (H20) đổi sang wallpaper **khác** (không phải matrix) rồi thoát | Nút Update **biến mất**, banner ở H17 quay lại *(note 2.5)* | Update vẫn hiện dù wallpaper đã đổi khác — nhầm lẫn user | 🟠 | ☐ |
| **TSK-N11** | Tài khoản **chưa từng** áp bất kỳ wallpaper nào | Banner mời (H17) hiện đúng dù chưa có wallpaper nào trước đó | Banner không hiện vì code giả định luôn có wallpaper cũ | 🟡 | ☐ |
| **TSK-N12** | Từ chối quyền Reminders khi đang ở chế độ Matrix | *(Chưa rõ — permissions-matrix cho biết Reminders denied chặn cả tab Tasks kiểu List; kiểm xem Matrix mode có bị chặn tương tự hay chỉ mất task nguồn Reminder)* | Toàn bộ Matrix biến mất dù task nguồn `Ink` không cần quyền này | 🟠 | ☐ |
| **TSK-N13** | Ở S04 Edit task (task nguồn Reminder), bấm **`Delete reminder`** | Xoá **đúng bản ghi Reminder** đó — mở Apple Reminders kiểm chứng đã mất; task cũng biến mất khỏi list Ink *(xác nhận: hành vi chủ ý, không phải lỗi copy — xem [wireframe](../ui/ux/wideframes/06_task.md))* | Xoá nhầm task khác, hoặc chỉ ẩn ở Ink mà Reminder gốc vẫn còn (dữ liệu lệch 2 nguồn) | 🟠 | ☐ |

---

## 3 · Edge — `TSK-E`

| ID | Tình huống | Câu hỏi | Mức | ☐ |
|---|---|---|:---:|:---:|
| **TSK-E01** | Tên ô nhập ký tự đặc biệt / emoji / tiếng Việt có dấu, chuỗi dài | Hiển thị đúng trên card/popup/chip, không vỡ layout? Giới hạn ký tự là bao nhiêu? *(coverage gap — xem TSK-Q01)* | 🟡 | ☐ |
| **TSK-E02** | 1 ô có rất nhiều task (20+) | Popup cuộn được, không tràn màn hình? | 🟡 | ☐ |
| **TSK-E03** | Cả 4 ô đều trống (0 task) | *"No reminders"* hiện đúng ở cả 4, không lệch layout? *(đối chiếu ảnh default)* | 🟡 | ☐ |
| **TSK-E04** | Bật Dynamic Type cỡ chữ **lớn nhất** | Tên ô / chip task trong popup có bị cắt/đè nhau không? *(note không có case Dynamic Type cho Matrix — coverage gap)* | 🟠 | ☐ |
| **TSK-E05** | Bật **Dark Mode** | Màu ô custom + card, popup còn đủ tương phản chữ? *(note không có case Dark Mode — coverage gap)* | 🟠 | ☐ |
| **TSK-E06** | VoiceOver đọc tên ô đã custom | Đọc đúng tên mới, không đọc tên mặc định cũ? *(coverage gap)* | 🟡 | ☐ |
| **TSK-E07** | Xoay iPad ngang/dọc trong lúc popup đang mở | Layout không vỡ, popup vẫn đúng vị trí? *(liên hệ [06_task_05_task-matrix_landscape.png](../ui/ux/screenshots/ipad/06_task/06_task_05_task-matrix_landscape.png))* | 🟠 | ☐ |
| **TSK-E08** | **iPad** — mở popup ô, mở sheet Customize, xem cả 4 ô ở portrait + landscape | Layout không vỡ (không cắt chữ, không tràn, popup/sheet căn giữa đúng)? *(Quyết định 2026-09-09: iPhone/iPad dùng chung component — **không cần lặp lại toàn bộ TSK-H07→H16 trên iPad**, chỉ verify hiển thị không vỡ, không phải hành vi)* | 🟡 | ☐ |
| **TSK-E09** | Offline khi bấm banner (H17) | Điều hướng sang Discover lỗi gì không, hay chỉ chặn phần render template? | 🟡 | ☐ |
| **TSK-E10** | Đặt tên ô A **trùng hệt** tên ô B | App có validate/chặn không, hay cho phép trùng? *(coverage gap)* | 🟡 | ☐ |
| **TSK-E11** | App bị kill giữa lúc đang gõ tên ô trong popup (chưa lưu) | Tên có mất không? | 🟡 | ☐ |
| **TSK-E12** | Trong sheet Customize, đã chọn 1 icon, bấm lại icon "no icon" (dấu cấm ở đầu danh sách, mặc định đang chọn theo ảnh) | Có xoá được icon về trạng thái không-icon không, hay đây chỉ là icon hiển thị mặc định không bấm được? *(coverage gap, chưa thấy ảnh state đã chọn icon khác)* | 🟡 | ☐ |
| **TSK-E13** | Sheet Customize sửa **subtitle** (không chỉ tên) — đổi ngôn ngữ máy sau khi chỉ sửa subtitle, không sửa tên | Subtitle có theo luật riêng (giữ nguyên nếu custom) hay luôn dịch theo tên? *(coverage gap mới phát sinh sau khi thấy subtitle nằm chung sheet với tên — liên hệ TSK-Q03)* | 🟠 | ☐ |
| **TSK-E14** | Kéo task giữa 2 ô, quan sát **drag preview** lúc đang giữ tay (chưa thả) | Preview hiện dạng pill chữ nhật, nền trắng trơn, shadow cứng — **không kế thừa màu ô nguồn**, lệch tông so với phần còn lại của Matrix (ô/checkbox luôn theo màu, note 1.5). Ma sát thẩm mỹ, không phải lỗi hành vi — cần phân biệt với việc màu có đổi đúng **sau khi thả** (đó mới là bug nếu sai) | 🟡 | ☐ |

---

## 4 · Coverage matrix

| Vùng | State cần phủ | Đã chạm |
|------|---------------|:-------:|
| Task list (cũ) | empty · filled · **đã hoàn thành** *(chưa có ảnh)* · **dialog xoá** *(chưa có ảnh)* | ☐ |
| Matrix — customization | default · đã đổi tên · đã đổi màu · đã đổi icon · đã reset | ☐ |
| Matrix — Reset button | ẩn khi chưa sửa · hiện khi đã sửa | ☐ |
| Matrix — ngôn ngữ | mặc định EN · đã đổi ngôn ngữ máy (ô có custom) · đã đổi ngôn ngữ máy (ô không custom) | ☐ |
| Push lock screen | banner · nút Update · màn preview · quay lại banner sau khi đổi wallpaper khác | ☐ |
| Device | iPhone (hành vi + layout) · iPad portrait/landscape (**chỉ layout**, hành vi dùng chung component — quyết định 2026-09-09) | ☐ |
| Theme | Light · Dark | ☐ |
| Quyền | Reminders granted · denied (ảnh hưởng tới Matrix — chưa rõ) | ☐ |

---

## 5 · Câu hỏi cần PO/dev — `TSK-Q`

| ID | Câu hỏi |
|---|---|
| **TSK-Q01** | Giới hạn ký tự tên/subtitle ô là bao nhiêu? Cần trước khi viết Boundary Value case (xem [test plan §10.3](../test-plans/matrix-guide-l10n/1.2.14-matrix-guide-l10n.md#10-gap-cần-làm-rõ-trước-khi-execute)). |
| ~~**TSK-Q02**~~ | ✅ **Đã trả lời:** nút *"Delete reminder"* là chủ ý, không phải lỗi copy — nút xoá đúng bản ghi Reminder gốc của task đó. Xem [wireframe cập nhật](../ui/ux/wideframes/06_task.md). Cần chuyển thành case xác nhận hành vi thay vì câu hỏi mở — xem TSK-N13 mới. |
| **TSK-Q03** | Subtitle của ô có theo cùng luật custom/localize như tên (note 1.13/1.14) không, hay luôn dịch theo ngôn ngữ máy? |
| **TSK-Q04** | Trùng tên giữa các ô có bị chặn/validate không? |
| ~~**TSK-Q05**~~ | ✅ **Đã trả lời 2026-09-09:** mục 1 (Matrix — tên/màu/icon/reset/persistence) dùng chung component iPhone/iPad, **không cần retest hành vi trên iPad**, chỉ verify layout không vỡ (xem TSK-E08). Câu hỏi này **vẫn còn mở cho mục 3–6** (header, guide, explainer, l10n) — chưa có xác nhận tương tự cho các màn hình đó trên iPad. |
| **TSK-Q06** | Build number TestFlight cho batch ảnh iPad 2026-09-09 là gì? (`ipad/index.md` còn để trống.) |
| **TSK-Q07** | Header Tasks trên iPhone (ảnh `05_task-matrix_default`) có 3 nút tròn (`?`, `List`, filter); ảnh iPad cùng ngày chỉ có 2 nút. Đây là khác biệt **device thật**, hay 2 ảnh chụp ở **version app khác nhau**? Nếu là chủ ý, `?` help/guide xuất hiện ở Tasks có mâu thuẫn với note mục 3.4 (chỉ nhắc nút Guide ở Discover) không? |

---

## 6 · Smoke 15 phút cho flow này

1. Chuyển sang Matrix, đổi tên + màu 1 ô, kill app, mở lại — xác nhận còn nguyên. *(4 phút, 🔴 P1)*
2. Kéo 1 task sang ô khác, đổi tên cả 4 ô, kill app, mở lại — task còn đúng ô. *(4 phút, 🔴 P1)*
3. Đổi ngôn ngữ máy sau khi đã custom 1 ô — xác nhận đúng luật giữ tên/dịch tên. *(3 phút, 🔴 P1)*
4. Bấm banner đưa matrix lên lock screen, xác nhận mở đúng template và nút Update xuất hiện. *(2 phút)*
5. Mở popup 1 ô matrix — xác nhận tab bar bị che hoàn toàn. *(2 phút)*

---

## 7 · Kết luận phiên

```
Phiên: __________            Build: 1.2.14 (____)      Thiết bị: __________

Q1 Mục tiêu user:            ______________________________
Q8 Mục tiêu business:        ______________________________
— Chạy luồng chính —
Q2 Xong dễ lần đầu?          Có / Không — vì: __________
Q3 Điểm khựng/bối rối:       ______________________________
Q4 Thao tác sai / gián đoạn: ______________________________
Q5 State chưa test:          ______________________________
— Kết luận —
Q6 Rủi ro #1 nếu ship:       ______________________________
Q7 Tự mình dùng hằng ngày?   Có / Không — vì: __________
Q9 15 phút thì test gì:      ______________________________

=> Verdict: 🟢 ship được / 🟡 ship có điều kiện / 🔴 chưa nên ship
   Bằng chứng: ______________________________
```
