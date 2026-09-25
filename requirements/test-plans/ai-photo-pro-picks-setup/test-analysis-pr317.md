# Test Analysis — Ink AI đọc ảnh, thử Pro trước khi mua, setup shortcut, badge Guide (PR #317)

> **Test basis:** [qc-ai-photo-pro-picks-setup-vi.md](../../specs/ai-photo-pro-picks-setup/qc-ai-photo-pro-picks-setup-vi.md) —
> PR [sfunvn/lockscreen-calendar#317](https://github.com/sfunvn/lockscreen-calendar/pull/317), 143 dòng, 11 mục,
> gộp **5 mảng nghiệp vụ khác nhau** trong cùng 1 PR: Ink AI đọc ảnh (mục 1-3), cơ chế thử Pro trước khi mua
> trong Editor + Decorate (mục 4-5), UI hàng ảnh nền/màn Backgrounds (mục 6-7), luồng setup shortcut + dòng
> trạng thái Settings (mục 8-9), badge Done/To do trong Guide (mục 10), và checklist hồi quy chung (mục 11).
> **Chuẩn:** ISTQB Foundation Level v4.0.1 §1.4.1 (Test Analysis) + §3 (Static Testing) + §5.2 (Risk Management)
> **Bước tiếp theo:** [test-plan](../../../.claude/skills/test-plan/SKILL.md) sẽ dùng mục 2 (test condition) làm
> test object và mục 2 cột risk level làm cơ sở mục 6 (risk-based prioritization) — chạy sau khi tài liệu này
> không còn câu hỏi mở quan trọng ở mục 4.
> **Ngày lập:** 2026-09-25 · **Người lập:** QC

> ✅ **Câu #8 đã đóng (2026-09-25, user xác nhận trực tiếp):** màn "Shortcut is working!"/"Check your lock
> screen shortcut." ở mục 8 PR #317 **chỉ áp dụng cho user đã có shortcut V2** — người còn dùng shortcut V1
> vẫn đi vào luồng update 3 bước (`MIG`) đã test ở PR #302 như `qc-shortcut-home-screen-ios26-27-V2.md` mô tả,
> **không** đá nhau. Đã bổ sung `SETUP-10` (P1) để test đúng việc phân nhánh V1/V2 này — xem nhóm `SETUP` và
> mục 4 câu #8. 10 câu hỏi còn lại (mục 4) **không chặn scope** — chỉ ảnh hưởng chi tiết BVA/case cụ thể, có
> thể chạy test-plan cho toàn bộ 6 nhóm ngay, đánh dấu case liên quan là ⚠️ phụ thuộc câu trả lời sau.

---

## 0. Đối chiếu với test basis khác đã có trong repo (không phải yêu cầu của skill, nhưng cần thiết cho PR này)

PR #317 **không phải** bộ QC shortcut vừa hoàn thành trước đó (PR #302, đã merge `main`,
[test-plan-ios26-27-v3.md](../shortcuts/test-plan-ios26-27-v3.md) + [test-analysis-ios26-27-v3.md](../shortcuts/test-analysis-ios26-27-v3.md)),
nhưng mục 8/9 của test basis PR #317 mô tả **cùng vùng UI** (Settings → Set up shortcut) với 3 test basis đã
merge trước đó của PR #302:
[qc-shortcut-home-screen-ios26-27-V2.md](../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2.md) (đặc biệt
mục 3.1, 13.1, 13.2), [test-plan-ios26-27-v3.md](../shortcuts/test-plan-ios26-27-v3.md) (`GATE`, `MIG`), và tài
liệu cũ hơn [exploratory/03_shortcut-setup.md](../../exploratory/03_shortcut-setup.md) (SCT-H08, SCT-N09,
SCT-Q08 — cho shortcut V1). Đã đọc cả 3 nguồn này để đối chiếu — kết quả nằm ở mục 1 (issue #8, #9) và mục 4
(câu hỏi #8, #9). **Không gộp 2 test basis, không coi 2 luồng là một** — chỉ ghi nhận điểm chồng lấn/mâu thuẫn
tiềm ẩn làm câu hỏi mở, giữ nguyên 2 tài liệu tách biệt.

Ngoài ra, phần Ink AI (mục 1-3) đối chiếu thêm với
[ai-assistant-tab.md](../ai-assistant/ai-assistant-tab.md) (flow `12_ai-assistant`, Phase 2, chưa build — xác
nhận **không liên quan**, chỉ trùng câu hỏi mở về số quota) và
[1.2.15-decoration-inkai.md](../decoration-inkai/1.2.15-decoration-inkai.md) (mục 10.10 — xác nhận **tab "Ink
AI"** ở mục 1-3 test basis này là **cùng 1 tab đã tồn tại trước PR #317**, không phải tab mới hoàn toàn; chỉ
riêng khả năng đọc ảnh + các state đi kèm là mới).

---

## 1. Đánh giá testability của test basis

| # | Trích đoạn/mục trong test basis | Vấn đề | Loại | Cần hỏi ai |
|---|---|---|---|---|
| 1 | Mục 1, dòng "Nút + bị ẩn khi... đã hết lượt hỏi trong ngày" | Không có con số cụ thể cho giới hạn "lượt hỏi trong ngày". Đây **không phải lần đầu** gap này xuất hiện: [ai-assistant-tab.md §10 câu hỏi #4](../ai-assistant/ai-assistant-tab.md) đã hỏi "Free quota 5 hay 3 lượt/ngày?" chưa có trả lời (khác flow, nhưng cùng khái niệm quota Ink AI); [1.2.15-decoration-inkai.md mục 10.10](../decoration-inkai/1.2.15-decoration-inkai.md) đã ghi nhận tab Ink AI **đang chạy quota thật trên production** nhưng chưa có case hiển thị/hết lượt. PR #317 giờ thêm hành vi UI phụ thuộc trực tiếp vào con số này (ẩn nút +) — gap cũ trở nên cấp thiết hơn | Thiếu | PO/dev — cần trả lời dứt điểm 1 lần, không phải hỏi lại theo từng note |
| 2 | Mục 1, "Tắt mạng rồi gửi ảnh: báo lỗi mạng" (dòng 30) so với dòng 26 "Không bị trừ lượt hỏi trong ngày" (chỉ nói cho case ảnh không có chữ) | Không nói rõ lần gửi bị lỗi mạng có bị tính là 1 lượt hỏi hay không. 2 cách hiểu: (a) giống case ảnh không có chữ — không tính vì chưa nhận được phản hồi hữu ích; (b) có tính — vì đã tốn 1 lần gọi API trước khi lỗi | Mơ hồ | Dev |
| 3 | Mục 3, "tới 1000 ký tự vẫn gửi được" | Không định nghĩa đơn vị đếm ký tự (grapheme cluster hiển thị vs UTF-16 code unit) — ảnh hưởng khi test với tiếng Việt có dấu, emoji, hoặc ngôn ngữ khác khi đổi ở iOS Settings → Ink → Language như chuẩn bị đầu bài yêu cầu | Thiếu | Dev |
| 4 | Mục 4, "Set without Pro: mọi lựa chọn Pro quay về như lúc mở editor" (dòng 69) so với case cụ thể duy nhất được nêu là ảnh nền (dòng 71) | Chỉ có 1 case xác nhận cụ thể (ảnh nền) cho phát biểu tổng quát "mọi lựa chọn". Không có case tường minh khi user chọn thử **đồng thời nhiều loại Pro** (font + màu + ảnh + mode) rồi mới bấm Set without Pro — có rollback đúng cả 4 cùng lúc không | Thiếu | Dev/PO |
| 5 | Mục 4, "Mở editor cho mẫu đã có sẵn lựa chọn Pro... không bị hỏi về những lựa chọn có sẵn đó" (dòng 73) | Không rõ khi mẫu có **nhiều** lựa chọn Pro có sẵn và user chỉ đổi **một** trong số đó sang giá trị Pro khác: popup lúc xác nhận chỉ liệt lựa chọn vừa đổi, hay liệt luôn cả lựa chọn cũ chưa đụng tới? 2 cách hiểu dẫn tới 2 kỳ vọng khác nhau cho nội dung popup | Mơ hồ | Dev/PO |
| 6 | Mục 4, dòng 68 "Unlock Pro: mở paywall... Mua xong thì nhãn PRO biến mất" | Chỉ mô tả nhánh mua **thành công**. Không nói user huỷ paywall hoặc thanh toán thất bại thì editor ở trạng thái nào (vẫn giữ preview Pro + nhãn PRO như trước khi bấm Unlock, hay bị reset) | Thiếu | Dev/PO |
| 7 | Mục 5, "Xoá cutout trước khi bấm ✓ thì không bị hỏi" (dòng 84) | Chỉ nêu cho Cutout. Không nói rõ hành vi tương tự khi user tự trả **style chữ Pro về mặc định** trước khi bấm ✓ — suy luận đối xứng hợp lý nhưng test basis không xác nhận | Thiếu | Dev |
| 8 | Mục 8 ("Setup lần đầu" và "Settings → Set up shortcut, khi đã có shortcut") đối chiếu [qc-shortcut-home-screen-ios26-27-V2.md dòng 506-508](../../specs/shortcuts/qc-shortcut-home-screen-ios26-27-V2.md) | Test basis PR #317 **không phân biệt** shortcut hiện có là bản cũ (V1) hay V2. Trong khi đó test basis đã merge của PR #302 khẳng định rõ: *"Mở từ lời mời, thẻ Guide, cửa sổ [GATE], Settings, banner Home, ⓘ trong editor, trang How updates work. Người đã có shortcut cũ luôn vào luồng **update** [3 bước, mục 13.2], không phải luồng cài lần đầu."* Nếu đúng vậy, 2 màn "Shortcut is working!"/"Check your lock screen shortcut." ở mục 8 PR #317 (dòng 113-118) **chỉ** áp dụng cho người đã có shortcut V2 — còn người vẫn dùng V1 phải được đưa vào luồng `MIG` 3 bước đã test ở PR #302. PR #317 không nói điều này, có thể là thiếu sót của chính spec, hoặc 2 luồng thật sự tách biệt theo cách khác chưa được mô tả | Mâu thuẫn tiềm ẩn (thiếu phân biệt giữa 2 test basis) | PO/dev — **quan trọng nhất, ảnh hưởng scope nhóm `SETUP`** |
| 9 | Mục 8, nút "I've added it — check now" (dòng 109/116) đối chiếu [exploratory/03_shortcut-setup.md SCT-H08](../../exploratory/03_shortcut-setup.md) | Tài liệu cũ (cho shortcut V1) mô tả overlay **tự động** "Shortcut is working!" hiện ngay sau khi user chọn "Always Allow" ở hộp xin quyền đặt wallpaper, không cần bấm nút gì. PR #317 mô tả cơ chế **bấm tay** ("I've added it — check now"). Không rõ đây là: (a) redesign thay hẳn cơ chế tự động cũ bằng cơ chế bấm tay, hay (b) 2 thời điểm khác nhau (ngay sau khi cấp quyền lần đầu vs khi quay lại Settings sau này) cùng tồn tại song song | Mơ hồ | Dev |
| 10 | Mục 9, "Automation đã chạy: vẫn là 'Refreshed automatically …' như cũ" | Đối chiếu 3 tài liệu đã đọc (V2 spec, test-plan/test-analysis v3, exploratory cũ) — **không tìm thấy** chuỗi này ở bất kỳ đâu để xác nhận baseline "như cũ" là gì. Không chặn scope, chỉ không tự đối chiếu được bằng tài liệu, cần chụp màn hình bản hiện tại trước khi bắt đầu test đợt này để có baseline | Không kiểm được (thiếu tài liệu đối chiếu) | Không cần hỏi ai — QC tự chụp baseline trước khi execute |
| 11 | Mục 11, "Đăng nhập tài khoản ở Settings → Account vẫn hoạt động (tài khoản giờ chỉ được khởi tạo khi cần)" | Câu trong ngoặc mô tả 1 thay đổi kiến trúc (lazy account creation) không được giải thích ở bất kỳ chỗ nào khác trong test basis này — không rõ đây có thực sự thuộc phạm vi PR #317, hay là dòng regression được chép nguyên từ 1 PR/spec khác (vd `login-and-calendar-sharing`). Nếu thuộc PR khác, QC cần test basis gốc của thay đổi đó để test đúng, không chỉ dựa vào 1 dòng mô tả ở đây | Thiếu (thiếu ngữ cảnh/nguồn) | Dev/PO |

---

## 2. Test condition đã ưu tiên hoá

> Risk level = Risk likelihood × Risk impact (Thấp/Vừa/Cao) → Ưu tiên: Risk Cao = **P1**, Risk Vừa = **P2**,
> Risk Thấp = **P3**. Mọi dòng Risk Cao đều có lý do cụ thể ở cột Impact (không dán nhãn cảm tính). ID = mã
> nhóm (dùng thẳng làm mã test object gợi ý ở mục 3).

### Nhóm `AI` — Ink AI đọc ảnh để tạo sự kiện (nguồn: mục 1-3 test basis)

| ID | Test condition | Nguồn | Loại | Likelihood | Impact | Risk | Ưu tiên |
|---|---|---|---|---|---|---|---|
| AI-01 | Bấm nút + mở thẳng thư viện ảnh iOS, **không** hiện hộp xin quyền truy cập ảnh | dòng 19 | Functional | Vừa | Thấp — UX thừa thao tác nếu sai, không chặn tính năng | Vừa | P2 |
| AI-02 | Chọn ảnh có chữ → ảnh hiện thành ô vuông → "Reading the photo…"/"Still going…" → chữ đọc được hiện dưới ảnh (thu gọn 3 dòng, mở/thu qua tap) → Ink trả lời + tạo event card như gõ tay | dòng 20-24 | Functional | Vừa — luồng nhiều bước hoàn toàn mới | Cao — happy path, là giá trị cốt lõi của cả tính năng | Cao | P1 |
| AI-03 | Bấm vào ảnh trong chat → mở full-screen, ✕ trên trái; kéo xuống đủ xa đóng, kéo ít bật lại | dòng 25 | Functional (gesture) | Vừa | Thấp | Vừa | P3 |
| AI-04 | Ảnh không có chữ: vẫn hiện ảnh, báo "No text found..."; không có Retry, có nút tạo thủ công; **không** trừ lượt hỏi | dòng 26 | Functional + cost control | Vừa | Vừa — trừ nhầm lượt ảnh hưởng trải nghiệm và COGS (xem mục 1 #1) | Vừa | P2 |
| AI-05 | Ảnh nhiều chữ (trang sách): Ink chỉ đọc phần đầu, thêm câu "That photo has a lot of text..." | dòng 27 | Functional | Vừa | Vừa | Vừa | P2 |
| AI-06 | Chọn lại đúng ảnh vừa gửi lần nữa vẫn gửi được (không bị chặn trùng) | dòng 28 | Functional | Thấp | Thấp | Thấp | P3 |
| AI-07 | Đang đọc ảnh (in-flight) mà bấm Clear chat → chat trống hẳn, không có ảnh cũ hiện lại | dòng 29 | Functional (race condition) | Vừa — response trả về sau khi đã clear là race condition thật | Vừa — leak dữ liệu cũ vào phiên chat mới nếu xử lý sai | Vừa | P2 |
| AI-08 | Tắt mạng gửi ảnh → báo lỗi mạng; bật mạng, bấm Retry → gửi lại **chữ**, **không đọc lại ảnh** | dòng 30 | Functional + cost control | Vừa | Cao — đọc ảnh 2 lần tốn chi phí thật kép; `ai-assistant-tab.md` đã xác nhận đây là tính năng duy nhất trong app có COGS trực tiếp theo lượt dùng | Cao | P1 |
| AI-09 | Tắt app, mở lại → ảnh và chữ trong lịch sử chat vẫn còn (persist) | dòng 31 | Functional (persistence) | Vừa | Vừa | Vừa | P2 |
| AI-10 | Nút + bị ẩn khi đang viết quote | dòng 32 | Functional | Thấp | Thấp | Thấp | P3 |
| AI-11 | Nút + bị ẩn khi đã hết lượt hỏi trong ngày | dòng 32 | Functional + cost control | Vừa | Cao — nếu không ẩn đúng lúc, user vẫn gửi được ngoài giới hạn kinh doanh đã định | Cao | P1 *(số biên cụ thể chưa có — xem mục 1 #1/mục 4 #1 trước khi viết BVA)* |
| AI-12 | Ô nhập đổi layout khi focus (chưa bấm: 1 hàng; bấm vào: chữ full ngang, nút xuống hàng dưới); bàn phím không tắt khi đổi qua lại | dòng 33 | Usability | Vừa | Thấp | Vừa | P3 |
| AI-13 | Màn Help không có nút + | dòng 34 | Functional (scope boundary) | Thấp | Thấp | Thấp | P3 |
| AI-14 | Tạo event trùng giờ qua Ink AI → thẻ hiện dòng cam "Overlaps with \<tên sự kiện\>" | dòng 40 | Functional | Vừa | Vừa | Vừa | P2 |
| AI-15 | Đổi giờ thẻ sang giờ trống → cảnh báo biến mất; đổi lại giờ trùng → cảnh báo hiện lại | dòng 41 | Functional (state toggle) | Vừa | Vừa | Vừa | P2 |
| AI-16 | Sự kiện liền kề (kết thúc = bắt đầu, vd 15-16h cạnh 16-17h) **không** bị báo trùng — biên của logic overlap | dòng 42 | Functional (BVA biên) | Vừa — lỗi off-by-one thường gặp ở logic khoảng thời gian | Vừa-Cao — sai biên gây báo nhầm hàng loạt, ảnh hưởng lòng tin vào tính năng lõi | Cao | P1 |
| AI-17 | Bấm Add lưu thẻ → dòng cảnh báo biến mất | dòng 43 | Functional | Thấp | Thấp | Thấp | P3 |
| AI-18 | Task, sự kiện cả ngày, thẻ chưa có giờ → không có cảnh báo trùng | dòng 44 | Functional (negative) | Vừa | Vừa | Vừa | P2 |
| AI-19 | Chưa cấp quyền lịch → không cảnh báo, không tự hiện hộp xin quyền; cấp quyền rồi quay lại app → cảnh báo hiện ra | dòng 45 | Functional (permission gating) | Vừa | Vừa | Vừa | P2 |
| AI-20 | Giữ tay trên bong bóng chat có chữ (mình/Ink/lỗi, cả màn Help) → menu Copy, dán đúng nội dung | dòng 49 | Functional | Thấp | Thấp | Thấp | P3 |
| AI-21 | Bong bóng chỉ có thẻ/danh sách: không có menu Copy | dòng 50 | Functional (negative) | Thấp | Thấp | Thấp | P3 |
| AI-22 | Giới hạn 1000 ký tự: gửi được tới đúng 1000; quá 1000 hiện "N of 1000 characters", khoá nút gửi (BVA 999/1000/1001) | dòng 51 | Functional (BVA) | Vừa | Vừa | Vừa | P2 *(đơn vị đếm ký tự chưa rõ với text có dấu/emoji — xem mục 1 #3)* |

### Nhóm `PRO` — Thử Pro trước khi mua, Editor + Decorate (nguồn: mục 4-5 test basis)

| ID | Test condition | Nguồn | Loại | Likelihood | Impact | Risk | Ưu tiên |
|---|---|---|---|---|---|---|---|
| PRO-01 | Mỗi loại lựa chọn Pro (font, màu Custom, ảnh nền Pro catalog, mode Home Screen Pro): chọn được, canvas đổi theo ngay (preview trước khi mua) | dòng 63-65 | Functional | Cao — 4 loại lựa chọn, cơ chế preview hoàn toàn mới | Cao — core mechanism của thay đổi lớn nhất PR, sai 1 trong 4 loại gãy toàn bộ trải nghiệm | Cao | P1 |
| PRO-02 | Nút xác nhận có thêm nhãn PRO khi có ≥1 lựa chọn Pro chưa xác nhận; chọn lại đúng giá trị lúc mở editor → nhãn biến mất | dòng 66 | Functional (state diff) | Cao — phải theo dõi đúng diff cho từng field trong 4 loại | Vừa — nhãn sai gây hiểu lầm, chưa mất dữ liệu trực tiếp | Cao | P1 |
| PRO-03 | Bấm nút xác nhận với ≥1 lựa chọn Pro chưa mua → popup "Keep your Pro picks?" liệt kê đúng từng lựa chọn + giá trị (tên font, chấm màu, tên mode, "×N" nếu nhiều ảnh) | dòng 67 | Functional | Cao — nội dung động theo tổ hợp lựa chọn | Cao — hiển thị sai giá trị khiến user hiểu nhầm mình sắp giữ/mất nội dung nào | Cao | P1 |
| PRO-04 | Unlock Pro → mở paywall, vẫn ở trong editor (không thoát, không mất state) | dòng 68 | Functional | Vừa | Vừa | Vừa | P2 |
| PRO-05 | Mua Pro thành công qua Unlock Pro → nhãn PRO biến mất; phải bấm xác nhận **lần nữa** mới thật sự set, **không** tự động set ngay sau khi mua | dòng 68 | Functional (business-critical) | Vừa | Cao — nếu tự set ngay sau thanh toán, có thể ghi đè wallpaper ngoài ý muốn ngay khi user chưa kịp xem lại | Cao | P1 |
| PRO-06 | Set without Pro → **mọi** lựa chọn Pro (không chỉ ảnh nền) quay về đúng giá trị lúc mở editor, rồi chạy luồng set bình thường với giá trị gốc | dòng 69 | Functional (business-critical) | Cao — rollback đồng thời nhiều field, dễ sót 1 field | Cao — sót rollback = mất lựa chọn gốc của user, hoặc vô tình set nội dung Pro chưa mua | Cao | P1 *(chỉ có case cụ thể cho ảnh nền — xem mục 1 #4)* |
| PRO-07 | **Case cụ thể:** wallpaper đang dùng ảnh riêng → chọn thử ảnh nền Pro → Set without Pro → wallpaper quay về **đúng** ảnh riêng ban đầu (không phải ảnh mặc định template); ảnh preview trong luồng set cũng không còn ảnh Pro | dòng 71 | Functional (business-critical) | Cao — phải nhớ đúng "ảnh gốc" qua nhiều bước chọn thử, code path mới | Cao — hậu quả là **mất/thay nội dung do chính user tạo** (ảnh cá nhân) mà không qua xác nhận mua, không phải chỉ lỗi hiển thị; nếu user không còn lưu ảnh gốc ở nơi khác, đây là mất dữ liệu thật | Cao | P1 |
| PRO-08 | **Case cụ thể:** chọn thử mode Home Screen Pro ("My photo"), thoát ra màn hình chính **không** bấm xác nhận, chạy shortcut → Home Screen **không** đổi theo mode Pro chưa xác nhận | dòng 72 | Functional (business-critical) | Cao — đường tắt né hoàn toàn popup xác nhận, nếu state preview bị lưu nhầm vào storage mà shortcut đọc, lỗi sẽ xảy ra | Cao — nếu lỗi, nghĩa là nội dung Pro được áp dụng **ngoài luồng thanh toán/xác nhận** — vi phạm trực tiếp cơ chế paywall, không chỉ là lỗi hiển thị | Cao | P1 |
| PRO-09 | Mở editor cho mẫu **đã có sẵn** lựa chọn Pro (case vừa hết Pro) → không bị hỏi lại về các lựa chọn có sẵn đó | dòng 73 | Functional | Vừa | Vừa-Cao — hỏi nhầm gây phiền; không hỏi nhầm trường hợp cần hỏi có thể set nhầm Pro content chưa mua | Vừa | P2 *(ranh giới "có sẵn" vs "mới chọn" khi trộn nhiều lựa chọn chưa rõ — xem mục 1 #5, tách case riêng nếu PO xác nhận hành vi)* |
| PRO-10 | User Pro: không thấy nhãn PRO trên nút xác nhận, không có popup dù chọn bất kỳ lựa chọn Pro nào | dòng 74 | Functional (negative/regression) | Thấp | Cao — nếu user đã trả tiền vẫn bị hỏi/chặn nhầm, ảnh hưởng trực tiếp trải nghiệm người đã mua | Cao | P1 |
| PRO-11 | Vuốt popup "Keep your Pro picks?" xuống → không có gì xảy ra, vẫn ở editor (không tự set nhánh nào) | dòng 70 | Functional | Vừa — iOS mặc định cho phép vuốt tắt sheet, cần chủ động tắt (`interactiveDismissDisabled`) | Vừa — vuốt tắt vô tình có thể set nhầm 1 trong 2 nhánh, mất lựa chọn hoặc set Pro ngoài ý muốn | Vừa-Cao | P2 |
| PRO-12 | Popup hiển thị đủ khi ≥4 dòng, cỡ chữ lớn (Dynamic Type), tiếng Đức/Nga — không tràn, không cắt mất nút | dòng 75 | Non-functional (Usability + Portability, ISO 25010) | Vừa | Vừa — không chặn logic nhưng chặn thao tác nếu nút bị cắt hẳn | Vừa | P2 |
| PRO-13 | Cutout (menu thêm, Decorate) có vương miện nhưng dùng thử được với user Free | dòng 79 | Functional | Vừa | Vừa | Vừa | P2 |
| PRO-14 | Style chữ Pro trong khung soạn có vương miện nhưng áp dụng thử được; nút ✓ của khung soạn có vương miện khi đang dùng style Pro | dòng 80 | Functional | Vừa | Vừa | Vừa | P2 |
| PRO-15 | Nút ✓ của Decorate có vương miện khi vừa thêm cutout hoặc style chữ Pro; bấm vào hiện cùng popup dạng "Keep your Pro picks?", nút thứ 2 là "Save without Pro" | dòng 81 | Functional | Vừa | Vừa | Vừa | P2 |
| PRO-16 | Go Pro (popup Decorate) → mở paywall, vẫn ở trong Decorate | dòng 82 | Functional | Thấp | Vừa | Vừa | P2 |
| PRO-17 | Save without Pro → cutout bị bỏ hoàn toàn, chữ giữ nguyên **nội dung** nhưng về style mặc định, rồi đóng Decorate | dòng 82-83 | Functional (business-critical) | Cao | Cao — nếu rollback sai làm mất luôn **nội dung chữ đã gõ** (không chỉ style), user mất công sức soạn thảo | Cao | P1 |
| PRO-18 | Xoá cutout trước khi bấm ✓ → không bị hỏi | dòng 84 | Functional (negative) | Vừa | Thấp | Vừa | P2 *(trường hợp tương tự với style chữ Pro chưa được xác nhận — xem mục 1 #7)* |

### Nhóm `BG` — Hàng ảnh nền + màn Backgrounds (nguồn: mục 6-7 test basis)

| ID | Test condition | Nguồn | Loại | Likelihood | Impact | Risk | Ưu tiên |
|---|---|---|---|---|---|---|---|
| BG-01 | Thứ tự hàng ảnh nền: ô thêm ảnh → ảnh template/Default → ảnh của mình → 15 ảnh catalog đầu → ô More (chỉ hiện khi catalog >15 ảnh) | dòng 90 | Functional (UI order) | Vừa | Thấp | Vừa | P2 |
| BG-02 | Ảnh đã chọn nằm ngoài 15 ảnh đầu vẫn hiện trong hàng (không bị ẩn khỏi tầm nhìn) | dòng 91 | Functional | Vừa | Vừa — user "mất dấu" lựa chọn hiện tại nếu sai | Vừa | P2 |
| BG-03 | Bấm More → màn Backgrounds full-screen: ✕/+, chip "All N"/"Your photos N" (nếu có ảnh riêng), từng danh mục kèm số lượng; lưới tự cuộn tới ảnh đang chọn | dòng 92 | Functional | Vừa | Vừa | Vừa | P2 |
| BG-04 | Tên danh mục hiển thị đúng ngôn ngữ (Cute, Doodle, Floral, Food, Minimal, Nature, Quotes, Wealth) | dòng 93 | Non-functional (Localizability) | Vừa | Thấp | Vừa | P3 |
| BG-05 | Màn Lock: wallpaper 1 ảnh → chọn xong tự đóng màn; bật "New photo every day" → chọn được nhiều ảnh, không tự đóng sau mỗi lần chọn | dòng 94 | Functional | Vừa | Vừa | Vừa | P2 |
| BG-06 | Màn Lock multi-select, chạm giới hạn Free → đóng màn rồi hiện popup giới hạn | dòng 94 | Functional (BVA số lượng) | Vừa | Vừa | Vừa | P2 *(đây là giới hạn SỐ LƯỢNG ảnh riêng — khác cơ chế thử-trước-khi-mua của nhóm `PRO`, cần phân biệt rõ khi thiết kế test-plan để không nhầm 2 luồng)* |
| BG-07 | Màn Home Screen: chọn hoặc thêm ảnh → tự đóng màn (khác hành vi multi-select của Lock) | dòng 95 | Functional | Thấp | Thấp | Thấp | P3 |
| BG-08 | Ảnh nền đang chọn có tick góc trên phải; với ảnh của mình, tick **thay cho** nút ✕ khi đang chọn — phải bỏ chọn mới xoá được | dòng 99 | Functional (tránh xoá nhầm) | Vừa | Vừa — nếu vẫn xoá được ảnh đang dùng làm wallpaper hiện tại, có thể mất ảnh nền đang áp dụng | Vừa | P2 |
| BG-09 | Ảnh Pro đang được chọn (đã set) → ẩn nhãn PRO | dòng 100 | Functional (UI) | Thấp | Thấp | Thấp | P3 |
| BG-10 | Khoảng cách giữa các ô ảnh hẹp lại 6pt, áp dụng cả màn chọn nền của Note | dòng 101 | Non-functional (UI, cross-flow `07_note`) | Thấp | Thấp | Thấp | P3 |
| BG-11 | Ảnh riêng lần đầu có thể nháy nền xám trước khi lên ảnh (chấp nhận được); crop lại 1 ảnh → ô ảnh trong hàng đổi theo khung mới **ngay**, không giữ khung cũ | dòng 102 | Functional (cache invalidation) | Vừa — bug cache thường gặp | Vừa | Vừa | P2 |
| BG-12 | Popup "Photo limit reached"/"Photo set is full" (Free) dùng hình vương miện mới, không bị cắt | dòng 103 | Non-functional (UI) | Thấp | Thấp | Thấp | P3 |

### Nhóm `SETUP` — Luồng setup shortcut + dòng trạng thái Settings (nguồn: mục 8-9 test basis)

> ✅ Câu hỏi #8 đã đóng — mục 8 PR #317 chỉ áp dụng cho user **đã có shortcut V2**. SETUP-01 → SETUP-09 dưới
> đây ngầm định tiền điều kiện "user đang ở shortcut V2" (đã cài V2, hoặc coi như setup lần đầu = cài thẳng
> V2). SETUP-10 (mới, 🆕) test riêng nhánh V1 để xác nhận không bị đá màn.

| ID | Test condition | Nguồn | Loại | Likelihood | Impact | Risk | Ưu tiên |
|---|---|---|---|---|---|---|---|
| SETUP-01 | Setup lần đầu: bấm "Tap to add shortcut" → thêm shortcut → quay lại app → nút "I've added it — check now" hiện, thành nút chính (to, tối, trên); nút add dưới đổi "Re-add shortcut" (nhạt) | dòng 109 | Functional | Cao — nhiều trạng thái nút chuyển đổi, UI mới | Cao — bước đầu tiên user cấp quyền để tính năng lõi hoạt động, sai sót chặn toàn bộ giá trị app | Cao | P1 *(xem mục 4 #8, #9)* |
| SETUP-02 | Kiểm tra không thấy shortcut → hiện câu báo lỗi, nút chính đổi "Re-add shortcut" (dấu +), "Try again" ở dưới | dòng 110 | Functional (negative) | Cao | Cao — user dễ bị kẹt ở bước này nếu message/nút sai | Cao | P1 |
| SETUP-03 | Lỗi do từ chối quyền đặt wallpaper: **không** có Re-add, Try again là nút chính (khác nhánh SETUP-02) | dòng 111 | Functional (phân nhánh theo nguyên nhân lỗi) | Cao — phải phân biệt đúng loại lỗi để hiện đúng bộ nút | Cao — hiện sai bộ nút khiến user không biết phải làm gì để sửa quyền wallpaper | Cao | P1 |
| SETUP-04 | Đã có shortcut, chạy thành công **trong 24 giờ qua** → trang mở ở trạng thái xong: "Shortcut is working!" ✅, "Now let's make it run every day.", chỉ có nút Next (không Re-add, không "step 1"); Next → sang automation, **không** mở Shortcuts | dòng 115 | Functional | Cao | Vừa | Cao | P1 *(xem mục 4 #8)* |
| SETUP-05 | Quá 24 giờ (hoặc chưa từng chạy) → "Check your lock screen shortcut.", nút "I've added it — check now"; bấm → mở Shortcuts chạy thử, quay về → kiểm tra rồi sang automation | dòng 116 | Functional (BVA biên 24h) | Cao — mốc 24h là biên cụ thể cần test đúng/sai biên | Vừa | Cao | P1 *(xem mục 4 #8)* |
| SETUP-06 | Kiểm tra thành công, bấm Back từ bước automation → trang shortcut về trạng thái xong (như SETUP-04); Next → sang lại automation mà **không** chạy shortcut lần nữa | dòng 117 | Functional (tránh side-effect trùng) | Vừa | Vừa | Vừa | P2 |
| SETUP-07 | Thoát ở bước automation → sau đó app **không** hiện lại lời mời setup automation | dòng 118 | Functional | Vừa | Thấp | Vừa | P3 |
| SETUP-08 | Shortcut đã cài nhưng automation chưa chạy lần nào → dòng dưới "Set up shortcut" ghi "Shortcut added · daily refresh not detected yet" (kiểm nhiều ngôn ngữ, vd vi: "Đã thêm phím tắt · chưa ghi nhận lần tự làm mới nào") | dòng 122 | Functional + Localizability | Vừa | Thấp | Vừa | P2 |
| SETUP-09 | Automation đã chạy → dòng trạng thái vẫn "Refreshed automatically …" như cũ | dòng 123 | Regression | Thấp | Thấp | Thấp | P3 *(không có tài liệu baseline để đối chiếu chuỗi cũ — xem mục 1 #10, tự chụp baseline trước khi execute)* |
| SETUP-10 🆕 | User còn dùng shortcut **V1** bấm bất kỳ nút "set up shortcut" nào (Home banner, Settings → Set up shortcut) → phải vào luồng update 3 bước (`MIG`, đã test ở `test-plan-ios26-27-v3.md`/`test-cases-ios26-27-v3.md`), **không** hiện 2 màn "Shortcut is working!"/"Check your lock screen shortcut." của mục 8 PR #317 (2 màn đó dành riêng cho V2) | Suy luận từ câu trả lời #8 (mục 4) + `qc-shortcut-home-screen-ios26-27-V2.md` dòng 506-508, không có trong test basis PR #317 | Functional (ranh giới giữa 2 test basis) | Cao — đúng chỗ 2 luồng dễ đá nhau nhất, vừa merge PR #302 gần đây | Cao — hiện sai màn khiến user V1 tưởng đã xong mà chưa migrate, mất tác dụng của luồng MIG | Cao | P1 |

### Nhóm `GUIDE` — Badge Done/To do trong tab Guide (nguồn: mục 10 test basis)

| ID | Test condition | Nguồn | Loại | Likelihood | Impact | Risk | Ưu tiên |
|---|---|---|---|---|---|---|---|
| GUIDE-01 | "Add the shortcut (once)": đã cài shortcut bản **mới nhất** (V2) → badge xanh Done (tick); chưa cài hoặc đang dùng bản **cũ** (V1) → badge To do | dòng 129 | Functional | Cao — phải phân biệt đúng V1/V2/trạng thái dở dang của luồng migration | Vừa-Cao — badge sai khiến user tưởng đã xong và bỏ dở migration; rủi ro tương tự đã từng được cảnh báo ở [exploratory/03_shortcut-setup.md SCT-N09](../../exploratory/03_shortcut-setup.md) cho overlay "Shortcut is working!" cũ | Cao | P1 |
| GUIDE-02 | "Allow calendar access": đã cấp quyền lịch → Done; chưa cấp → To do | dòng 130 | Functional | Thấp | Vừa | Vừa | P2 |
| GUIDE-03 | Bật/tắt quyền lịch ở iOS Settings rồi quay lại app → badge đổi ngay, không cần thao tác thêm | dòng 131 | Functional (sync real-time) | Vừa | Vừa | Vừa | P2 |
| GUIDE-04 | Setup shortcut ngay từ màn Guide xong → badge mục shortcut đổi sang Done | dòng 132 | Functional | Vừa | Vừa | Vừa | P2 |
| GUIDE-05 | Các mục khác (automation, design, note…) **không** có badge | dòng 133 | Functional (negative/scope) | Thấp | Thấp | Thấp | P3 |
| GUIDE-06 | Badge hiển thị đúng ngôn ngữ (vi: "Xong"/"Cần làm"), không đẩy tiêu đề dài bị cắt quá mức | dòng 134 | Non-functional (Localizability + UI) | Vừa | Thấp | Vừa | P2 |

### Nhóm `REG` — Hồi quy chung (nguồn: mục 11 test basis)

| ID | Test condition | Nguồn | Loại | Likelihood | Impact | Risk | Ưu tiên |
|---|---|---|---|---|---|---|---|
| REG-01 | Widget ngoài Home Screen cập nhật sau khi mở app, sau khi lịch Google/Outlook đồng bộ, sau khi lịch chia sẻ đồng bộ (có thể chậm ~1 giây) | dòng 138 | Regression + Performance efficiency (ISO 25010) | Thấp — đã hoạt động trước đó, chỉ hồi quy | Vừa — widget sai/chậm ảnh hưởng trải nghiệm hàng ngày | Vừa | P2 |
| REG-02 | Mở app nhiều lần liên tiếp: không giật; Home và thumbnail collection hiển thị bình thường | dòng 139 | Regression + Performance | Thấp | Vừa | Vừa | P2 |
| REG-03 | Đăng nhập tài khoản ở Settings → Account vẫn hoạt động (tài khoản giờ chỉ khởi tạo khi cần) | dòng 140 | Regression | Vừa — đổi cơ chế khởi tạo tài khoản có thể tạo race condition ở lần dùng đầu | Cao — đăng nhập hỏng chặn toàn bộ tính năng đồng bộ/chia sẻ | Cao | P1 *(nguồn thay đổi kiến trúc chưa rõ — xem mục 1 #11)* |
| REG-04 | Đang Pro, tắt app rồi mở lại: vẫn Pro, **không** hiện paywall lúc mở app | dòng 141 | Regression (business-critical) | Vừa | Cao — hiện paywall nhầm cho user đã mua là lỗi nghiêm trọng, ảnh hưởng trực tiếp lòng tin của người đã trả phí | Cao | P1 |
| REG-05 | Render wallpaper với nhiều sự kiện (#316): set wallpaper tuần/tháng nhiều sự kiện, không bị treo | dòng 142 | Regression + Reliability (ISO 25010) | Vừa — đã có bug #316 tham chiếu, tức từng có vấn đề thật | Cao — treo app khi set wallpaper là lỗi chặn, ảnh hưởng trực tiếp core flow | Cao | P1 |

**Tổng: 73 test condition** — AI 22 · PRO 18 · BG 12 · SETUP 10 · GUIDE 6 · REG 5.
**Theo ưu tiên:** P1 = 23 · P2 = 34 · P3 = 16.

---

## 3. Traceability nháp

| Mã nhóm | Mục test basis | Test condition | Ghi chú cho test-plan |
|---|---|---|---|
| `AI` | Mục 1-3 | AI-01 → AI-22 | Tính năng mới hoàn toàn trong tab Ink AI đã tồn tại (đối chiếu `1.2.15-decoration-inkai.md`). Số quota "lượt hỏi trong ngày" (AI-11, và ảnh hưởng BVA của AI-04/AI-22) treo chờ câu hỏi #1 — **không** thiết kế BVA cụ thể cho tới khi có số |
| `PRO` | Mục 4-5 | PRO-01 → PRO-18 | Mảng rủi ro cao nhất PR (9/18 condition là P1) — đổi hành vi paywall hiện có sang cơ chế thử-trước-khi-mua. Test-plan nên ưu tiên kỹ thuật Decision Table cho tổ hợp {loại lựa chọn Pro} × {Unlock Pro / Set without Pro / vuốt đóng} × {tier Free/Pro}, và State Transition cho vòng đời "chọn thử → xác nhận/huỷ" của từng lựa chọn |
| `BG` | Mục 6-7 | BG-01 → BG-12 | Rủi ro thấp hơn PRO/SETUP — chủ yếu UI/thứ tự hiển thị. BG-06 (giới hạn số ảnh Free) cần tách rõ khỏi cơ chế `PRO` khi thiết kế case dù cùng nằm 1 màn hình |
| `SETUP` | Mục 8-9 | SETUP-01 → SETUP-10 | **Câu hỏi #8 đã đóng** — mục 8 chỉ áp dụng cho user đã có shortcut V2 (SETUP-01→09 ngầm định tiền điều kiện này). SETUP-10 (🆕) test nhánh V1 → phải vào `MIG` của `test-plan-ios26-27-v3.md`, không hiện 2 màn của mục 8 |
| `GUIDE` | Mục 10 | GUIDE-01 → GUIDE-06 | GUIDE-01 liên hệ trực tiếp trạng thái `S1`-`S4` của luồng migration (`MIG`, `test-analysis-ios26-27-v3.md`) — test-plan nên cross-check badge tại từng state đó thay vì test độc lập |
| `REG` | Mục 11 | REG-01 → REG-05 | Checklist hồi quy ngắn nhưng REG-03/04/05 đều P1 — nên chạy sớm trong đợt test (không phải cuối cùng) vì có thể chặn cả app, không riêng feature mới |

---

## 4. Câu hỏi cần làm rõ trước khi lập test plan

1. **[Ảnh hưởng AI-04, AI-11, AI-22]** Giới hạn "lượt hỏi trong ngày" của Ink AI là bao nhiêu? Đây là câu hỏi
   lặp lại lần thứ 3 trong repo (sau `ai-assistant-tab.md` và `1.2.15-decoration-inkai.md` mục 10.10) — đề nghị
   PO/dev trả lời dứt điểm 1 lần cho toàn bộ tính năng Ink AI, không riêng PR này.
2. **[Ảnh hưởng AI-08]** Lần gửi ảnh bị lỗi mạng có bị tính là 1 lượt hỏi trong ngày không?
3. **[Ảnh hưởng AI-22]** "1000 ký tự" đếm theo đơn vị nào (grapheme hiển thị hay code unit) — quan trọng khi
   test với tiếng Việt có dấu/emoji/ngôn ngữ khác?
4. **[Ảnh hưởng PRO-06]** "Set without Pro" có rollback đúng **đồng thời** khi user chọn thử nhiều loại Pro
   cùng lúc (font + màu + ảnh + mode), hay chỉ được verify riêng lẻ từng loại?
5. **[Ảnh hưởng PRO-09]** Khi mẫu có nhiều lựa chọn Pro có sẵn và user chỉ đổi 1 trong số đó, popup "Keep your
   Pro picks?" có liệt kê luôn cả lựa chọn cũ chưa đổi không, hay chỉ liệt lựa chọn vừa đổi?
6. **[Ảnh hưởng PRO-04/PRO-05]** User huỷ paywall hoặc thanh toán thất bại sau khi bấm Unlock Pro thì editor ở
   trạng thái nào — vẫn giữ preview Pro + nhãn PRO như trước, hay bị reset về "Set without Pro"?
7. **[Ảnh hưởng PRO-18]** Trả style chữ Pro về mặc định trước khi bấm ✓ (Decorate) có được miễn hỏi giống xoá
   Cutout không?
8. ✅ **ĐÃ ĐÓNG (2026-09-25, user xác nhận trực tiếp).** Màn "Shortcut is working!"/"Check your lock screen
   shortcut." ở mục 8 PR #317 **chỉ áp dụng cho user đã có shortcut V2**. Người còn dùng shortcut V1 vẫn đi vào
   đúng luồng update 3 bước (`MIG`, PR #302) — không đá nhau. Đã bổ sung `SETUP-10` (P1, mục 2) test đúng việc
   phân nhánh V1/V2 tại điểm vào này, và SETUP-01/04/05 hiểu ngầm tiền điều kiện "user đang ở V2".
9. **[Ảnh hưởng SETUP-01]** Nút "I've added it — check now" (bấm tay) có thay thế hoàn toàn overlay tự động
   "Shortcut is working!" (hiện ngay sau khi cấp quyền "Always Allow", đã mô tả ở `exploratory/03_shortcut-setup.md`
   SCT-H08 cho V1), hay 2 cơ chế tồn tại song song ở 2 thời điểm khác nhau?
10. **[Ảnh hưởng SETUP-09, không chặn scope]** Chuỗi "Refreshed automatically …" hiện tại (trước PR #317) là gì
    — cần chụp baseline trên build trước khi test đợt này vì không tài liệu nào trong repo ghi lại chuỗi này.
11. **[Ảnh hưởng REG-03]** "Tài khoản giờ chỉ được khởi tạo khi cần" có thực sự thuộc phạm vi thay đổi của PR
    #317, hay là dòng regression được chép từ một PR/spec khác (vd `login-and-calendar-sharing`)? Nếu thuộc PR
    khác, cần test basis gốc của thay đổi đó.
