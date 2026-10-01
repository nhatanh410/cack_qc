# Test Analysis — Wallpaper Component Editor (bàn giao 1.2.18 (111, rc3))

> ✅ **READY — CÓ ĐIỀU KIỆN** *(do **con người duyệt**, không phải agent tự kết luận)*
> **Duyệt bởi:** QC (người dùng repo, chủ sở hữu quyết định chuyển trạng thái) · **Ngày:** 2026-09-28 · **Phương án đã chọn (nguyên văn):** *"A. Cho phép chạy Test Plan ngay (READY có điều kiện)"* · **Hồ sơ câu trả lời/giả định:** [answers-1.2.18.md](answers-1.2.18.md).
>
> **Ba điều kiện bắt buộc kèm theo — test-plan PHẢI tuân thủ:**
> 1. **Q-7 · Q-10 · Q-12 vẫn là ASSUMPTION (giả định làm việc do QC chấp nhận), CHƯA có dev xác nhận.** Không được nâng thành fact. Dev trả lời khác → chỉ các condition ⚠️ tương ứng phải viết lại.
> 2. **TC18-99 và TC18-100 (Q-4) chính thức ra khỏi phạm vi thực thi** — giữ nhãn `GAP` (descope), **không** đưa vào test-plan, **không** suy diễn expected result. Q-4 **vẫn mở**.
> 3. **Test-plan phải mang nguyên **18 nhãn ⚠️ (gap-dependent)** kèm điều kiện thay đổi của từng nhãn** (danh sách ở mục 2 "Condition gắn ⚠️" và mục 5).
>
> ⚠️ **Các câu hỏi CHẶN cũ KHÔNG bị xoá và KHÔNG được coi là đã trả lời:** **Q-7** (§7.07 ↔ §7.08 — kéo slider vs cuộn bảng, mâu thuẫn **vẫn nằm nguyên trong tài liệu**) · **Q-10** (§3.08 "khoảng cách giữ nguyên" — giữ gap hay giữ đỉnh slot) · **Q-12** (§4.06 mốc gap = 0 của band đầu) → nay mang nhãn **"đã được QC chấp nhận giả định — chờ dev xác nhận (không chặn test-plan)"** · **Q-4** (§12 Year progress *"target date"* / Quote *"chữ – số dòng"*) → **vẫn GAP/mở**, đã descope 2 condition. Xem mục 4A và mục 5.
>
> **Cập nhật 2026-09-28 — đợt trả lời của QC** (nguồn duy nhất: [answers-1.2.18.md](answers-1.2.18.md) · **"QC trả lời", KHÔNG phải fact từ spec, chưa có dev xác nhận**):
> **Đã trả lời:** Q-1 · Q-2 · Q-6a/6b · Q-8 · Q-9a/9b · Q-11 · Q-17 · **Q-21 đã đóng** (sheet Add = **16 mục / 5 nhóm**, QC rút lại nhận định "19 mục").
> **Chuyển sang giả định làm việc ⚠️ (QC chấp nhận, chờ dev):** Q-7 · Q-10 · Q-12 · phần "screen vs ảnh" còn lại của Q-8 · (Q-4 có giả định nhưng **không** tạo condition trong phạm vi).
> **Đã cố ý bỏ, không chờ trả lời:** Q-3a · Q-14 · Q-15 · Q-16 · đơn vị chip gap (phần của Q-12) · ngưỡng góc/thời gian (phần của Q-7) → condition liên quan ghi **"không có ngưỡng — kiểm hành vi, không kiểm giá trị"**.
> **Còn mở, không chặn:** Q-3b · Q-13 · Q-18 (+ việc QC tự xử lý: Q-5, Q-19, Q-20).
>
> **Analysis Status: `READY` (có điều kiện)** · **Downstream Permission: `ALLOWED` (có điều kiện)** — **được phép chạy `test-plan`** cho slug `1.2.18` theo [`.claude/rules/testing.md`](../../../../.claude/rules/testing.md), **với đúng 3 điều kiện ở trên**. Trạng thái trước đó là `BLOCKED`; việc chuyển `BLOCKED → READY` là **quyết định của người review (QC, 2026-09-28)**, **không phải** kết luận của agent và **không** có nghĩa là Q-7/Q-10/Q-12/Q-4 đã hết chặn về mặt kỹ thuật — chúng vẫn là **giả định chưa được dev xác nhận** / **gap đã descope**. Lý do BLOCKED ban đầu được giữ nguyên ở mục 5 để truy vết.

> **Test basis:** [QC — Component Editor 1.2.18.md](../../../specs/wallpaper-editor/component-editor/QC%20—%20Component%20Editor%201.2.18.md) — chỉ **§0–§13** (nội dung do dev bàn giao). Phần "Ghi chú của QC" ở cuối file đó **không phải requirement**, chỉ dùng để đối chiếu.
> **Tài liệu đối chiếu (KHÔNG phải test basis):**
> - [diff-component-editor-1.2.17-vs-1.2.18.md](../../../specs/wallpaper-editor/component-editor/diff-component-editor-1.2.17-vs-1.2.18.md) — phân mức 🔴/🟠/🟡/🔵/⚪ cho từng mục, dùng để quyết định tái sử dụng hay viết lại test condition.
> - [QC — Component Editor 1.2-SUPERSEDED.md](../../../specs/wallpaper-editor/component-editor/QC%20—%20Component%20Editor%201.2-SUPERSEDED.md) — bản 1.2.17 (103), **đã SUPERSEDED**, chỉ dùng để hiểu method/số liệu cũ.
> - [test-analysis-component-editor-SUPERSEDED.md](test-analysis-component-editor-SUPERSEDED.md) — bộ 1.2.17 (TC-01…TC-73), giữ nguyên để truy vết; ánh xạ sang bộ này ở mục 3B.
> - [wireframe § S03](../../../ui/ux/wideframes/14_edit-wallpaper.md) · [screenshots iPhone § 03_component-editor](../../../ui/ux/screenshots/iphone/index.md) · [exploratory 14_edit-wallpaper.md](../../../exploratory/14_edit-wallpaper.md) — **bằng chứng ảnh chụp từ lứa 1.2.17, đã lệch so với 1.2.18** (xem TB-17).
> **Chuẩn:** ISTQB Foundation Level v4.0.1 §1.4.1 (Test Analysis) + §3 (Static Testing) + §5.2 (Risk Management) + §4.5.2 (Acceptance Criteria)
> **Bước tiếp theo:** [test-plan](../../../../.claude/skills/test-plan/SKILL.md) sẽ dùng mục 2 làm test object và cột Risk level làm cơ sở risk-based prioritization — **đã được người review cho phép chạy từ 2026-09-28 theo phương án A (READY có điều kiện)**, với ràng buộc: mang nguyên 18 nhãn ⚠️ (gap-dependent) + điều kiện thay đổi, và **loại TC18-99/TC18-100 khỏi phạm vi**.
> **Ngày lập:** 2026-09-28 · **Người lập:** QC
> **Mã traceability:** dùng mã `§N.M` do QC gán trong spec 1.2.18 (vd `§4.03`, `§7.09`, `§10 #8`).

---

## 1. Đánh giá testability của test basis

> Đây là "defect trong chính tài liệu" (ISTQB §3 — ambiguity / incompleteness / inconsistency), **không phải** defect của app.
> Cột "Mức" chỉ mức độ chặn: `CHẶN` = không viết được test condition/expected result nếu chưa có trả lời · `MỞ` = viết được nhưng giảm độ chính xác (thường là thiếu giá trị biên cho BVA ở bước sau).

| # | Trích đoạn / mục trong test basis | Vấn đề | Loại | Mức | Cần hỏi ai | Ảnh hưởng |
|---|---|---|---|---|---|---|
| TB-01 | **§4.12** "…thẻ nền của Row/Column **đi cùng** với con của nó" vs **§10 #8** "Kéo di chuyển một thành phần **bên trong** Row/Column mà container cha có thẻ nền: thẻ nền đó **tạm ẩn trong lúc kéo**, hiện lại khi nhả tay" | Hai câu nói khác nhau về cùng một đối tượng (thẻ nền container trong lúc kéo). **Cách hiểu A:** hai trường hợp tách biệt — kéo *container* thì thẻ nền đi cùng (§4.12), kéo *con bên trong* thì thẻ nền tạm ẩn (§10 #8). **Cách hiểu B:** mâu thuẫn thật, một trong hai câu là mô tả cũ chưa xoá. Hai cách hiểu cho **hai tập expected result khác hẳn nhau** và khác cả số lượng test condition (A cần 2 condition, B cần 1 condition + 1 bug report). | Mâu thuẫn nội bộ | **CHẶN** | Dev (implementer drag) | TC18-36 (TBD), ảnh hưởng phụ TC18-32, TC18-35 |
| TB-02 | **§12** "Year progress — *target date*: trong code **không có** tuỳ chọn…" và "Quote — *chữ / số dòng*: **chưa rõ lỗi cụ thể**" | Spec ghi rõ đây là **open question chưa có quyết định**, dev đang chờ QC phản hồi. Không có hành vi mong đợi nào để làm oracle. Chính spec yêu cầu đánh dấu `GAP`/`BLOCKED`. | Thiếu (không có acceptance criteria) | **CHẶN** | QC ↔ dev (QC phải gửi ảnh chụp / mô tả tái hiện trước) | TC18-99, TC18-100 — **nay là `GAP`, ngoài phạm vi thực thi** (xem cập nhật bên dưới) |
| TB-03 | **§7.13** "…nên tiêu đề giờ **đậm hơn** trước — đúng dữ liệu template" | Không có baseline định lượng hay ảnh so sánh với 1.2.17: "đậm hơn" so với mốc nào, ở template nào (chỉ nêu tên "month elegant script" và "priority matrix"), và "tiêu đề giờ" là phần tử nào trong 2 template đó. Không phân biệt được "đúng dữ liệu template" với "lỗi render đậm sai". Không gán được risk impact vì không biết lệch này là intended hay defect. | Không kiểm được (thiếu oracle) | **CHẶN** | Dev / design (cần ảnh baseline 1.2.17) | TC18-89 (TBD) |
| TB-04 | **§4.06** "Snap dọc — **rung nhẹ 1 lần** khi hút vào: Giữa màn… Chỗ gap = 0… Vạch dưới của grid" | (a) "1 lần" mơ hồ: **A** = rung 1 lần mỗi khi hút vào *mỗi* điểm snap (kéo qua 3 điểm = 3 lần rung), **B** = rung đúng 1 lần cho cả cú kéo. (b) Không nêu **bán kính hút** (ngưỡng px/pt) → không thiết kế được BVA quanh điểm snap. (c) Không nêu hành vi khi **2 điểm snap trùng/gần nhau** (vd band ngắn: gap 0 trùng vạch dưới grid) — hút vào điểm nào, rung mấy lần. (d) Không nêu có rung khi **rời khỏi** điểm snap không. | Mơ hồ + thiếu giá trị biên | **CHẶN** (mục a, c) · MỞ (b, d) | Dev | TC18-26 → TC18-30, đặc biệt TC18-29 |
| TB-05 | **§7.07** "…kéo **qua kéo lại** để chỉnh, tay **hơi lệch dọc** — trước đây đúng kiểu này bị khựng" vs **§7.08** "…**vuốt dọc** bắt đầu trên slider **vẫn cuộn bảng** bình thường" | Hai câu mô tả cùng một input (chạm bắt đầu **trên slider**, có thành phần chuyển động **dọc**) nhưng kỳ vọng ngược nhau: §7.07 ⇒ slider phải tiếp tục nhận cử chỉ (không khựng, không nhường cho scroll view); §7.08 ⇒ scroll view phải giành được cử chỉ. Không nêu **ngưỡng phân biệt** (góc lệch, khoảng cách dọc, thời gian). Không viết được expected result cho vùng biên giữa hai hành vi. | Mâu thuẫn tiềm ẩn / thiếu ngưỡng | **CHẶN** | Dev (gesture recognizer) | TC18-80, TC18-82 |
| TB-06 | **§4.03** "Giới hạn kéo là **mép ảnh**… không kéo tràn ra khỏi ảnh" + **§10 #10** "Band đầu nằm trên vạch trên grid là được phép" vs **§9.02** cảnh báo *"Part of this runs off the screen"* | "Mép **ảnh**" và "ra ngoài **màn**" không chắc là cùng một biên (ảnh wallpaper có thể lớn hơn/khác khung màn sau crop). **Cách hiểu A:** kéo tới sát mép ảnh là hợp lệ và **không** bật cảnh báo (vì vẫn trong ảnh). **Cách hiểu B:** phần vượt vùng hiển thị của màn khoá sẽ bật cảnh báo dù vẫn trong ảnh. Hai cách hiểu cho hai expected result trái ngược cho cùng thao tác. | Mơ hồ (2 cách hiểu) | **CHẶN** | Dev | TC18-23, TC18-24, TC18-106 |
| TB-07 | **§3.07** "Thành phần **Fixed**… **không bị tính là "kế bên"**" + **§10 #13** | Không nêu hành vi khi một band **Fixed nằm giữa** hai band Auto: bấm ↓ ở band Auto phía trên thì **A** = nhảy **qua** band Fixed, đổi chỗ với band Auto kế tiếp; hay **B** = coi như không có band nào kế bên, mũi tên **ẩn**/không làm gì. Cũng không nêu quy tắc ẩn mũi tên ở "đầu/cuối" được tính trên danh sách **có** hay **không có** band Fixed. Hai cách hiểu tạo ra **hai bảng quyết định khác hẳn nhau**. | Mơ hồ (2 cách hiểu) | **CHẶN** | Dev | TC18-15, TC18-16, TC18-17 |
| TB-08 | **§3.08** "Khoảng cách giữa các vị trí **giữ nguyên**, chỉ các band đổi chỗ cho nhau" | Với hai band **cao thấp khác nhau**, "vị trí" và "khoảng cách" chưa định nghĩa: **A** = giữ nguyên toạ độ đỉnh của từng slot (band cao đổi xuống slot thấp sẽ tràn xuống band dưới); **B** = giữ nguyên **gap** giữa các band (toạ độ đỉnh phải tính lại). Đây chính là vùng vừa sửa lỗi "đè band", nên expected result phải chính xác. | Mơ hồ (2 cách hiểu) | **CHẶN** | Dev | TC18-19, ảnh hưởng phụ TC18-20 |
| TB-09 | **§4.05** "chip hiện **gap**… hiện số âm (vd `-40`)" · **§0** dùng ví dụ `-115` · **§4.06** "band đầu: **chỗ khối bắt đầu**" | (a) Không nêu **đơn vị** của số trên chip (pt / px / % / điểm lưới) → không so sánh được giá trị đo với kỳ vọng. (b) "Chỗ **khối** bắt đầu" (điểm gap = 0 của band đầu) chưa định nghĩa: mép trên vùng nội dung stack, vạch trên grid, hay mép trên ảnh? §10 #10 nói grid "chỉ là đường gióng" càng làm mờ mốc này. Không có mốc thì không kiểm được cả TC snap gap 0 lẫn dấu của chip. | Mơ hồ + thiếu | **CHẶN** (mục b) · MỞ (a) | Dev | TC18-25, TC18-27 |
| TB-10 | **§5.08** "Không kéo được nhỏ hơn **mức tối thiểu** (không được co về 0)" | Không có giá trị cụ thể (pt hay %) — **câu hỏi mở từ 1.2.17, bản 1.2.18 không bổ sung**. Kiểm được "có chặn / không co về 0" nhưng không BVA được đúng ngưỡng. | Thiếu (giá trị biên) | MỞ | Dev / design | TC18-52 (kiểm một phần) |
| TB-11 | **§6.2** "Tối đa **3 cấp** container. Ví dụ hợp lệ: `Column > Row > Column`" | Không rõ cách đếm: canvas/stack gốc có tính 1 cấp không, hay chỉ đếm số lớp Row/Column lồng nhau — **câu hỏi mở từ 1.2.17, chưa bổ sung**. Ảnh hưởng điểm chính xác mà nhóm Layout biến mất. | Mơ hồ | MỞ | Dev | TC18-68, TC18-70 |
| TB-12 | **§5.07** "Thành phần **trong một Row**: kéo góc = kéo vách ngăn — thành phần bên cạnh hẹp lại đúng bằng đó" | Chỉ mô tả Row có **đúng 2 con**. Row **3+ con**: bù trừ chia đều cho tất cả, chỉ phần tử liền kề, hay phần tử cuối hấp thụ? — **câu hỏi mở từ 1.2.17, chưa bổ sung**. | Thiếu | MỞ | Dev | TC18-51 — **nay P2 ⚠️**, chỉ kiểm phần bất biến |
| TB-13 | **§6.02** "Thành phần mới **không chiếm hết bề rộng** — nó có lề hai bên sẵn (**giống Studio**)" | "Studio" là tham chiếu nội bộ không định nghĩa trong tài liệu; không có giá trị lề cụ thể — câu hỏi mở từ 1.2.17. Kiểm được "không full-width", không kiểm được "đúng lề". | Mơ hồ + thiếu | MỞ | Tác giả / design | TC18-58 |
| TB-14 | **Header bảng thông tin:** "Tổng số mục tick trên trang gốc: **83**; bản chép này có **82**" | Bản Markdown đang dùng làm test basis **có thể thiếu 1 mục** so với trang gốc `docs/qc-component-editor.md`. Rủi ro về **tính đầy đủ** của test basis: một requirement bị khuất giữa hai ảnh chụp sẽ không có test condition nào phủ. Chưa xác định được mục nào. | Thiếu (completeness chưa xác minh) | MỞ (rủi ro cao cho coverage) | Dev / người chụp trang gốc | Toàn bộ mục 2 (coverage) |
| TB-15 | **§4.15** "Kéo liên tục 5–10 giây… **không giật cục, không đứng hình**. Nếu thấy giật → report kèm model máy" | Không có tiêu chí đo khách quan (fps, ngưỡng frame drop) và không nêu tập máy tối thiểu phải chạy. Kết quả phụ thuộc cảm nhận tester → khó tái hiện, khó chốt pass/fail. | Không kiểm được (khách quan) | MỞ | Dev | TC18-39 |
| TB-16 | **§7.12** "Thanh Size: chữ chính tối đa **200**, chữ phụ… tối đa **60**" | Chỉ có biên **trên**; không có biên **dưới**, không có **đơn vị**, không nêu hành vi khi template có sẵn đang vượt giới hạn (clamp xuống hay giữ nguyên). BVA chỉ phủ được 1 phía. | Thiếu (giá trị biên) | MỞ | Dev | TC18-87 |
| TB-17 | Bộ ảnh [`§03_component-editor` (15 ảnh)](../../../ui/ux/screenshots/iphone/index.md) + [wireframe §S03](../../../ui/ux/wideframes/14_edit-wallpaper.md) | Chụp trên nhánh `feat/component-editor` ngày 2026-09-24, **cùng lứa 1.2.17**; wireframe ghi rõ *"6 nhóm quan sát được: Calendar · Events · Tasks · Progress · **Text** · Layout"*, trong khi 1.2.18 chỉ còn **5 nhóm** (bỏ Text — §6, §7.22). Dùng bộ ảnh này làm oracle cho 1.2.18 sẽ **báo sai**. Chưa có ảnh nào cho reorder ↑/↓, chip gap âm, snap, grabber, ✕. | Thiếu (baseline lỗi thời) | MỞ (phải ghi rõ trong test-plan) | Nội bộ QC — cần chụp lại trên build 111 | TC18-54, TC18-55; oracle của cả nhóm mới |
| TB-18 | Ba test condition cũ **TC-71 / TC-72 / TC-73** (thêm khi không chọn gì → chèn giữa canvas · Component Editor + Decorate gộp đủ 2 phần · bố cục sống sót qua automation overnight) | Cả ba **không có trong spec 1.2.18** (và cũng không có trong 1.2.17); nguồn là **trao đổi trực tiếp với dev ngày 2026-09-24**. Theo `.claude/rules/testing.md` đây là **assumption, không phải fact** — không được ghi như requirement của 1.2.18 mà chưa re-confirm cho build 111. | Thiếu (requirement ngoài tài liệu) | MỞ | Dev (re-confirm cho 1.2.18) | TC18-61 (TBD), TC18-115, TC18-116 |
| TB-19 | **§7.09** (✕ = bỏ chọn + đóng bảng) vs **§7.06** (nút **Deselect** cuối bảng) vs **§3.02** (chạm vùng trống) | Ba đường "bỏ chọn" cùng tồn tại; không nêu chúng có cho **cùng trạng thái cuối** không (bảng đóng? nút **+** hiện lại? khung viền mất?). §7.09 chỉ mô tả trạng thái cuối cho ✕. | Thiếu | MỞ | Dev | TC18-79, TC18-83, TC18-84 |
| TB-20 | **§1** bảng thiết bị: iPad "**Nếu có**" | Điều kiện môi trường phụ thuộc việc có máy hay không → phạm vi (và exit criteria) của nhóm iPad không xác định trước. Kế thừa nguyên trạng từ 1.2.17, không phải vấn đề mới. | Mơ hồ (scope) | MỞ | Test lead | TC18-108 |
| TB-21 | **§10 #6** "Card kính mờ (frosted) có sticker… **Wallpaper đã lưu thì đúng**. Chỉ report nếu thấy sai trên **lock screen thật**" | Không nêu cách kiểm trung gian; tester buộc phải áp wallpaper lên lock screen thật mới kết luận được → chi phí cao, dễ bị bỏ qua. Không nêu "đúng" nghĩa là sticker **được** làm mờ hay **không** được làm mờ trên bản đã lưu. | Mơ hồ | MỞ | Dev / design | TC18-117 |
| **TB-22** *(mới 2026-09-28)* | **§6 + §7.05 + §7.14 – §7.22** — danh mục loại component | **Không có danh mục component chính thức, đầy đủ từ dev.** Sheet Add (ảnh QC gửi, đã khớp §6/§7.22) có **16 mục / 5 nhóm**, nhưng spec chỉ nêu **knob riêng** cho ~10 tên: Month grid, Mini month, Today's events, Timeline *(chỉ còn trên template có sẵn)*, Week events, Year progress, Countdown, Priority matrix, Hour timeline, Timetable. **7 loại không có oracle cho knob riêng:** Lunar calendar, Week schedule, Month progress, Reminders, Activity grid, Almanac day, Quote — §7.05 chỉ nói chung chung "các knob riêng của từng loại… đổi được và ăn ngay", không liệt kê knob nào cho các loại này. Ngoài ra **ánh xạ tên UI → tên code** (Activity grid = `contributionGrid`, Reminders = `reminderList`, Timeline = `timelineCards`) hiện **chỉ là suy luận**, không có nguồn. | Thiếu (danh mục + oracle) | MỞ | Dev (đề nghị bàn giao danh mục chính thức: tên UI ↔ tên code ↔ knob riêng) | TC18-78, TC18-90 – TC18-97, **TC18-118, TC18-119** (mới) |

**Tổng: 22 vấn đề testability.**

#### Cập nhật trạng thái các vấn đề `CHẶN` sau đợt trả lời 2026-09-28

> Nguồn: [answers-1.2.18.md](answers-1.2.18.md). **Mọi dòng dưới đây là "QC trả lời", chưa có dev xác nhận** — nếu dev trả lời khác thì dev thắng và chỉ các condition tương ứng phải sửa.

| TB | Câu hỏi | Trạng thái 2026-09-28 | Hệ quả lên mục 2 |
|---|---|---|---|
| TB-01 | Q-1 | ✅ **Đã trả lời — cách hiểu A**: hai trường hợp tách biệt (kéo *container* → thẻ nền đi cùng; kéo *con bên trong* → thẻ nền tạm ẩn, hiện lại khi nhả tay). **Không** phải mâu thuẫn, không report. | TC18-36 **tách thành TC18-36a + TC18-36b**, cả hai đã gán risk |
| TB-02 | Q-4 | 🔶 **Vẫn GAP** — QC chưa gửi ảnh/mô tả, dev chưa chốt. Giả định làm việc (Year progress **không có** "target date"; ô *Lines* của Quote **phải có tác dụng**; sửa nội dung chữ quote **không** phải requirement) **không** được dùng làm oracle. | TC18-99, TC18-100 giữ **GAP**, **đưa ra ngoài phạm vi thực thi** |
| TB-03 | Q-2 | ✅ **Đã trả lời**: "đậm hơn" là **đúng dữ liệu template**, **không report**. Vẫn chưa chỉ rõ phần tử nào đậm hơn → khi chạy phải đối chiếu ảnh. | TC18-89 bỏ TBD, gán risk Thấp → **P3** |
| TB-04 | Q-6a/6b | ✅ **Đã trả lời**: (a) rung **1 lần mỗi điểm snap** (kéo qua 3 điểm = 3 lần) · (b) 2 điểm snap rất gần nhau → **hút vào điểm gần hơn, rung 1 lần**. Bán kính hút (b cũ) và "có rung khi rời điểm snap" (d cũ) vẫn **MỞ**, không chặn. | TC18-29 có expected result; TC18-26 – TC18-28 giữ nguyên |
| TB-05 | Q-7 | ⚠️ **CHƯA có trả lời của dev** — QC **chấp nhận giả định làm việc**: khoá hướng cử chỉ **một lần từ đầu**, giữ tới khi nhả tay (thiên ngang → slider chạy; gần thẳng dọc → bảng cuộn; đã khoá thì không đổi giữa chừng). **Ngưỡng góc/thời gian đã cố ý bỏ** → kiểm hành vi, không kiểm giá trị. **Mâu thuẫn §7.07 ↔ §7.08 vẫn còn nguyên trong tài liệu.** | TC18-80, TC18-82 gắn **⚠️ gap-dependent** |
| TB-06 | Q-8 | ✅/⚠️ **Đã trả lời một phần**: cảnh báo *"Part of this runs off the screen"* **chỉ bật khi kéo band ra khỏi cạnh screen**, kéo sát mép (vẫn bên trong) **không** bật. ⚠️ **Còn lẫn "screen" vs "ảnh"** — chưa xác nhận hai biên này có trùng nhau không → **ghi là giả định**. | TC18-23, TC18-24, TC18-106 có expected result nhưng gắn **⚠️** |
| TB-07 | Q-9a/9b | ✅ **Đã trả lời**: (a) Fixed nằm giữa 2 band Auto → bấm ↓ **nhảy qua** band Fixed, đổi chỗ với band Auto kế tiếp · (b) band Fixed **không tính** vào danh sách xác định đầu/cuối → band Auto cuối vẫn **ẩn ↓** dù còn Fixed phía sau. | TC18-15, TC18-16, TC18-17 có expected result đủ để dựng Decision Table |
| TB-08 | Q-10 | ⚠️ **CHƯA có trả lời của dev** — QC chấp nhận giả định: **giữ nguyên gap của từng vị trí** (tổng chiều cao stack không đổi, không band nào đè band khác); band đầu đang gap âm thì **gap âm ở lại vị trí đầu**, không đi theo band. | TC18-19, TC18-20 gắn **⚠️ gap-dependent** |
| TB-09 | Q-12 | ⚠️ **CHƯA có trả lời của dev** — QC chấp nhận giả định: mốc gap = 0 của band đầu là **vạch trên của grid** (suy từ §4.05). **Đơn vị chip gap đã cố ý bỏ** → không so sánh giá trị tuyệt đối, chỉ kiểm dấu (`0` / số âm / không bao giờ `-0`) và hành vi snap. | TC18-25, TC18-27 gắn **⚠️ gap-dependent** |
| TB-17 | Q-19/Q-21 | ✅ **Q-21 đóng**: ảnh sheet Add QC gửi 2026-09-28 **khớp spec 1.2.18** — 16 mục / 5 nhóm, không có nhóm Text, **không có Timeline trong EVENTS**; QC rút lại nhận định "19 mục". ⚠️ **Ảnh chưa hiện số build** → vẫn phải chụp lại kèm build 111 khi làm Q-19 (**không chặn**). Các oracle ảnh khác vẫn là lứa 1.2.17. | TC18-54, TC18-55, TC18-58 viết lại theo danh sách 16 mục |
| TB-18 | Q-11 | ✅ **Đã trả lời**: cả ba hành vi (a) bấm **+** khi không chọn gì → chèn **giữa canvas** · (b) Editor + Decorate gộp đủ hai phần khi lưu · (c) bố cục sống sót qua automation overnight — **đều còn đúng ở 1.2.18**. ⚠️ Nhưng **vẫn không có trong spec 1.2.18** → vẫn là requirement ngoài tài liệu; **đề nghị dev đưa vào tài liệu bàn giao chính thức**. | TC18-61 bỏ TBD (P2 ⚠️); TC18-115, TC18-116 giữ P1 ⚠️ |
| TB-19 | Q-17 | ✅ **Đã trả lời**: ba đường bỏ chọn (**✕** trong bảng / **Deselect** / chạm vùng trống) cho **cùng trạng thái cuối**: bảng đóng · khung viền mất · nút **+** hiện lại. | TC18-79, TC18-83, TC18-84 có expected result thống nhất |
| TB-10, TB-13, TB-15, TB-16 | Q-3a, Q-14, Q-15, Q-16 | ⏭️ **Đã cố ý bỏ** — không chờ trả lời. Condition liên quan ghi **"không có ngưỡng — kiểm hành vi, không kiểm giá trị"**. | TC18-52, TC18-58, TC18-39, TC18-87 thu hẹp oracle, **không** còn là câu hỏi mở |
| TB-11, TB-12, TB-21 | Q-3b, Q-13, Q-18 | 🔷 **Vẫn MỞ**, không chặn test-plan. | TC18-68, TC18-70, TC18-51, TC18-117 gắn **⚠️** (kiểm phần bất biến, chưa kiểm quy tắc chi tiết) |
| TB-14, TB-20 | Q-5, Q-20 | 🔷 **Việc QC tự xử lý**, chưa làm — rủi ro coverage (82/83 mục) và phạm vi iPad. Không chặn. | Ghi chú coverage ở test-plan |

**Còn `CHẶN` sau cập nhật: 4** — TB-05 (Q-7), TB-08 (Q-10), TB-09 (Q-12) *(chờ **dev** xác nhận giả định QC đã chấp nhận)* và TB-02 (Q-4) *(chờ **QC** gửi bằng chứng + **dev** chốt; đã descope TC18-99/100)*.

---

## 2. Test condition đã ưu tiên hoá

> **Risk level = Risk likelihood × Risk impact** (ISTQB §5.2). Quy đổi ưu tiên: Risk **Cao → P1** · **Vừa → P2** · **Thấp → P3**.
> Cột **Δ** = mức thay đổi so với bộ 1.2.17 theo [bản diff](../../../specs/wallpaper-editor/component-editor/diff-component-editor-1.2.17-vs-1.2.18.md): 🔴 đảo ngược/bỏ (condition cũ **sai**, viết lại) · 🟠 mới quan trọng · 🟡 mới phụ · 🔵 đổi diễn đạt (trace lại, nội dung giữ) · ⚪ giữ nguyên (tái sử dụng).
> ~~Dòng **TBD** chưa gán được risk~~ — **sau cập nhật 2026-09-28 không còn dòng TBD nào**: 4 dòng đã gán risk nhờ câu trả lời của QC, 2 dòng (TC18-99, TC18-100) chuyển thành **`GAP` ngoài phạm vi thực thi**.
>
> **Nhãn nguồn expected result (mới 2026-09-28):**
> - **(QC)** = expected result lấy từ **câu trả lời của QC** ngày 2026-09-28 ([answers-1.2.18.md](answers-1.2.18.md)), **không phải câu chữ trong spec, chưa có dev xác nhận**. Dev trả lời khác → sửa đúng condition đó.
> - **⚠️ (gap-dependent)** = expected result dựa trên **giả định làm việc** (ASSUMPTION do QC chấp nhận) hoặc trên **requirement không có trong spec**, hoặc chỉ kiểm được **phần bất biến** vì câu hỏi liên quan còn mở. **Test-plan bắt buộc mang nhãn này sang** và ghi rõ điều kiện thay đổi; **không** được nâng thành fact.
> - **GAP (ngoài phạm vi)** = không có oracle, **không đưa vào phạm vi thực thi** (TC18-99, TC18-100).

### A. Môi trường, đường vào, build (§1, §2) — 8 condition

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk | Ưu tiên | Δ |
|---|---|---|---|---|---|---|---|---|
| TC18-01 | TestFlight cài đúng build **1.2.18 (111)** tag `v1.2.18-rc3`; build khác (rc1/rc2 không lên TestFlight) → dừng và báo lại | §header ⚠️ | Điều kiện vào (project risk) | Vừa | Cao | Cao | P1 | 🟠 |
| TC18-02 | Nút **Components** (icon chồng lớp, cạnh nút crop) chỉ hiện với template dạng **stack**; template cũ không có nút | §2, §10 #5 | Functional | Vừa | Cao | Cao | P1 | ⚪ |
| TC18-03 | Nút Components đặt đúng vị trí trên header (cạnh crop) | §2 | Usability | Thấp | Thấp | Thấp | P3 | ⚪ |
| TC18-04 | Màn full-screen mở đủ chrome: header ✕ · Undo · Redo · ✓; đáy **+** và **Show grid** | §2 | Functional | Thấp | Cao | Vừa | P2 | ⚪ |
| TC18-05 | Lần đầu vào: coach mark *"Tap to edit a piece"* hiện và bấm để bỏ qua được | §2 | Usability | Thấp | Thấp | Thấp | P3 | ⚪ |
| TC18-06 | Toàn luồng chạy đúng trên **iPhone iOS 18.x** (nền chính, bắt buộc) | §1 | Compatibility | Thấp | Cao | Vừa | P2 | ⚪ |
| TC18-07 | Toàn luồng chạy đúng trên **iPhone iOS 26.x**, chrome dạng **glass** render đúng | §1 | Compatibility | Vừa | Cao | Cao | P1 | ⚪ |
| TC18-08 | Chuỗi mới hiển thị đúng ngôn ngữ máy (VI + EN bắt buộc; khai báo đủ 12 ngôn ngữ); không lọt chuỗi tiếng Anh vào máy tiếng Việt | §1 | Internationalization | Vừa | Vừa | Vừa | P2 | ⚪ |

### B. Chọn thành phần & đổi thứ tự (§3) — 12 condition

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk | Ưu tiên | Δ |
|---|---|---|---|---|---|---|---|---|
| TC18-09 | Chạm một thành phần → hiện khung viền + pill 2 mục **Edit component / Delete component** | §3.01 | Functional | Vừa | Cao | Cao | P1 | ⚪ |
| TC18-10 | Chạm vùng trống → bỏ chọn, pill biến mất | §3.02 | Functional | Vừa | Vừa | Vừa | P2 | ⚪ |
| TC18-11 | Thành phần trong Row/Column: chạm lần 1 chọn **container**, chạm tiếp chọn **con** (đi sâu từng cấp) | §3.03, §10 #4 | Functional | Cao | Cao | Cao | P1 | ⚪ |
| TC18-12 | Khung viền **ôm đúng** thành phần, kể cả thành phần đã thu nhỏ (không to hơn nội dung thật) | §3.04 | Functional | Vừa | Vừa | Vừa | P2 | ⚪ |
| TC18-13 | **Edit component** mở đúng bảng thuộc tính của thành phần đang chọn | §3.05 | Functional | Thấp | Cao | Vừa | P2 | ⚪ |
| TC18-14 | **Delete component** xoá thành phần + toast *"Removed …"* kèm **Undo**; Undo trả lại **đúng chỗ cũ** | §3.06 | Functional / Reliability | Vừa | Cao | Cao | P1 | ⚪ |
| TC18-15 | Pill có **↑ / ↓** (trong Row là **← / →**); bấm → thành phần đổi chỗ với thành phần kế bên | §3.07 | Functional | Cao | Cao | Cao | P1 | 🟠 |
| TC18-16 | Ở **đầu / cuối** danh sách, mũi tên phía đó **ẩn đi**. **(QC · Q-9b)** Band **Fixed không được tính** vào danh sách xác định đầu/cuối → band **Auto cuối cùng vẫn là "cuối"** và **ẩn ↓** dù còn band Fixed nằm **sau** nó | §3.07, §10 #13 | Functional | Vừa | Vừa | Vừa | P2 | 🟠 |
| TC18-17 | Thành phần **Fixed**: **không có** mũi tên ↑/↓ và **không bị tính là "kế bên"**. **(QC · Q-9a)** Fixed nằm **giữa** 2 band Auto → bấm **↓** ở band Auto phía trên thì **nhảy qua** band Fixed, đổi chỗ với **band Auto kế tiếp**; band Fixed **đứng yên** | §3.07, §10 #13 | Functional | Cao | Cao | Cao | P1 | 🟠 |
| TC18-18 | Mỗi lần bấm mũi tên đổi thứ tự = **đúng 1 bước Undo** | §3.07 | Reliability | Vừa | Vừa | Vừa | P2 | 🟠 |
| TC18-19 | ⚠️ Đổi thứ tự **không làm band nào đè lên band khác**, kể cả khi band đầu đang có **gap âm**. **Giả định làm việc (Q-10, QC chấp nhận — chờ dev):** giữ nguyên **gap của từng vị trí** → tổng chiều cao stack **không đổi**; gap âm **ở lại vị trí đầu**, không đi theo band. *Nếu dev nói "giữ đỉnh ô/slot" thì expected result của dòng này đổi* | §3.08 | Functional | Cao | Cao | Cao | P1 ⚠️ | 🟠 |
| TC18-20 | ⚠️ **Duplicate** band đầu đang có gap âm → bản sao nằm **dưới** bản gốc, có khoảng cách, **không đè** *(cùng giả định Q-10 về cách tính gap)* | §3.09 | Functional | Cao | Cao | Cao | P1 ⚠️ | 🟠 |

### C. Di chuyển — kéo (§4 + các mục "cố ý" liên quan §10) — 24 condition *(TC18-36 tách đôi sau trả lời Q-1)*

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk | Ưu tiên | Δ |
|---|---|---|---|---|---|---|---|---|
| TC18-21 | Giữ và kéo → thành phần đi theo ngón tay **ngay lập tức**, không trễ cảm nhận được | §4.01 | Performance efficiency | Cao | Cao | Cao | P1 | ⚪ |
| TC18-22 | Kéo lên/xuống trong stack hoặc column: **không đè lên thành phần phía trên** | §4.02 | Functional | Cao | Cao | Cao | P1 | 🔵 (thay phần "chặn vùng nội dung" của TC-14 cũ) |
| TC18-23 | ⚠️ Giới hạn kéo là **mép ảnh**, không phải vạch grid: kéo xuống **quá vạch dưới grid** tới mép dưới ảnh; **không** tràn ra khỏi ảnh. **(QC · Q-8)** Kéo **sát mép mà vẫn bên trong** → **KHÔNG** bật cảnh báo *"Part of this runs off the screen"*. ⚠️ *Giả định còn lại: "cạnh screen" ≡ "mép ảnh" — chưa xác nhận* | §4.03, §9.02 | Functional | Cao | Cao | Cao | P1 ⚠️ | 🔴 **viết lại** (TC-14 cũ sai) |
| TC18-24 | ⚠️ **Band đầu tiên** kéo lên được **qua vạch trên grid** tới mép trên ảnh; **band khác** dừng khi chạm band phía trên (điểm biên phân biệt band đầu / band khác); phần nằm trên vạch grid nhưng **vẫn trong ảnh** → **không** cảnh báo **(QC · Q-8)** ⚠️ *cùng giả định "screen ≡ ảnh"* | §4.04, §10 #10 | Functional | Cao | Cao | Cao | P1 ⚠️ | 🔴 + 🟠 |
| TC18-25 | ⚠️ Chip **gap** trong lúc kéo hiện **số âm** khi band đầu lên quá vạch (vd `-40`); tại đúng gap 0 hiện `0`; **không bao giờ** hiện `-0`. **Đơn vị đã cố ý bỏ** → chỉ kiểm **dấu và hành vi**, không so sánh giá trị tuyệt đối. **Giả định làm việc (Q-12, chờ dev):** mốc gap = 0 của band đầu là **vạch trên của grid** | §4.05 | Functional | Cao | Vừa | Cao | P1 ⚠️ | 🟠 |
| TC18-26 | **Snap — giữa màn:** hút vào giữa màn, **đường gióng ngang** hiện ra | §4.06 | Functional | Cao | Vừa | Cao | P1 | 🟠 |
| TC18-27 | ⚠️ **Snap — gap = 0:** band đầu hút vào "chỗ khối bắt đầu", band khác hút khi vừa chạm band trên; nhả tay ở đó → chip hiện `0` (không phải `-0`), rung **1 lần**. **Giả định làm việc (Q-12, chờ dev):** "chỗ khối bắt đầu" = **vạch trên của grid** (bật **Show grid** để kiểm); qua vạch → số âm. *Dev nêu mốc khác (mép trên vùng nội dung / mép trên ảnh) → sửa dòng này* | §4.06, §4.05 | Functional | Cao | Vừa | Cao | P1 ⚠️ | 🟠 |
| TC18-28 | **Snap — vạch dưới của grid:** đáy band khớp vạch | §4.06 | Functional | Vừa | Vừa | Vừa | P2 | 🟠 |
| TC18-29 | **Haptic (QC · Q-6a/6b):** rung nhẹ **1 lần cho MỖI điểm snap** hút vào — kéo qua 3 điểm trong một cú kéo = **3 lần rung**; khi **2 điểm snap rất gần nhau** thì **hút vào điểm gần hơn và chỉ rung 1 lần** (không rung kép). Phải test trên **máy thật**. *(bán kính hút và "có rung khi rời điểm snap" vẫn mở — không chặn)* | §4.06 | Usability (haptic feedback) | Vừa | Vừa | Vừa | P2 | 🟠 |
| TC18-30 | Band đang nằm **sẵn** trên một điểm snap → chạm kéo **không bị giữ lại**, phải ra khỏi đó mới hút lại | §4.07 | Functional | Vừa | Vừa | Vừa | P2 | 🟠 |
| TC18-31 | Kéo **ngang**: dịch trái/phải trong phạm vi cho phép | §4.08 | Functional | Vừa | Vừa | Vừa | P2 | ⚪ |
| TC18-32 | Kéo một **Row/Column**: toàn bộ con đi theo **đúng một lần**, không nhanh hơn khung viền, không văng ra ngoài | §4.09 | Functional | Cao | Cao | Cao | P1 | ⚪ |
| TC18-33 | Trong lúc kéo **không xuất hiện bản sao** (component hiện 2 lần đè nhau) và **không mất** thành phần rồi hiện lại khi nhả | §4.10 | Reliability | Vừa | Cao | Cao | P1 | ⚪ |
| TC18-34 | Nhả tay → ảnh render lại **một lần**, đúng chỗ vừa thả, không nhảy về chỗ cũ rồi nhảy lại | §4.11 | Reliability | Cao | Cao | Cao | P1 | ⚪ |
| TC18-35 | Trong lúc kéo, thành phần được **vẽ lại thật**: các thành phần phía dưới **dồn theo** (không phải kéo ảnh tĩnh) | §4.12 | Functional | Vừa | Vừa | Vừa | P2 | 🔴 (đảo "cố ý" cũ) |
| TC18-36a | **Kéo cả container Row/Column** (chọn đúng container) → **thẻ nền (card) đi cùng** với con của nó, không bị bỏ lại, không nhấp nháy **(QC · Q-1, cách hiểu A)** | §4.12 | Functional | Vừa | Cao | Cao | P1 | 🔴 → tách từ TC18-36 |
| TC18-36b | **Kéo một con BÊN TRONG** Row/Column mà container cha có thẻ nền → thẻ nền đó **tạm ẩn trong lúc kéo** và **hiện lại khi nhả tay** — **đúng thiết kế, KHÔNG report** **(QC · Q-1, cách hiểu A)** | §10 #8 | Functional (xác nhận cố ý) | Vừa | Vừa | Vừa | P2 | 🔴 → tách từ TC18-36 |
| TC18-37 | Wallpaper có **sticker / nét vẽ trang trí**: sticker **không biến mất** trong lúc kéo (lỗi cũ) | §4.13 | Functional | Vừa | Cao | Cao | P1 | 🟠 |
| TC18-38 | Khung viền chọn luôn ôm đúng thành phần đang được vẽ, **kể cả khi kéo nhanh** | §4.14 | Functional | Vừa | Vừa | Vừa | P2 | 🟡 |
| TC18-39 | Kéo liên tục **5–10 giây**, lên xuống nhiều lần: không giật cục, không đứng hình. **Q-15 đã cố ý bỏ → không có ngưỡng fps/frame-drop: kiểm hành vi (giật rõ mắt / đứng hình), không kiểm giá trị**; thấy giật thì report kèm model máy | §4.15 | Performance efficiency | Vừa | Vừa | Vừa | P2 | 🟡 |
| TC18-40 | **Cố ý:** lúc kéo chữ hơi **mềm** (vẽ ở 2/3 độ phân giải); **nhả tay là nét lại** — chỉ là lỗi nếu vẫn mờ sau khi nhả | §10 #7 | Functional (xác nhận cố ý) | Vừa | Vừa | Vừa | P2 | 🟠 |
| TC18-41 | **Cố ý:** vừa nhả tay chạm kéo tiếp ngay → chờ ~**0.1 giây** mới bắt đầu đi theo ngón | §10 #9 | Functional (xác nhận cố ý) | Thấp | Thấp | Thấp | P3 | 🟡 |
| TC18-42 | **Cố ý:** band đầu nằm **trên vạch trên grid** (lấn vùng đồng hồ) là hợp lệ; 4 template `mix-class-schedule`, `mix-daily-brief`, `mix-focus-today`, `mix-mindful-month` vốn đã cao hơn vạch → không report | §10 #10 | Functional (xác nhận cố ý) | Vừa | Vừa | Vừa | P2 | 🟠 |
| TC18-43 | **Cố ý:** band có **thẻ nền** — thẻ nhô lên trên band, ở gap 0 viền thẻ vẫn có thể nằm **trên** vạch grid | §10 #11 | Functional (xác nhận cố ý) | Thấp | Thấp | Thấp | P3 | 🟡 |

### D. Đổi bề rộng — kéo góc (§5, §10 #3) — 10 condition

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk | Ưu tiên | Δ |
|---|---|---|---|---|---|---|---|---|
| TC18-44 | Kéo **góc phải** → cạnh trái đứng yên, chỉ mép phải chạy theo ngón | §5.01 | Functional | Vừa | Cao | Cao | P1 | ⚪ |
| TC18-45 | Kéo **góc trái** → cạnh phải đứng yên | §5.02 | Functional | Vừa | Cao | Cao | P1 | ⚪ |
| TC18-46 | Bề rộng đổi **realtime** theo ngón tay, không chờ nhả tay | §5.03 | Performance efficiency | Vừa | Vừa | Vừa | P2 | ⚪ |
| TC18-47 | Kéo hẹp thành phần có chữ: chữ **xuống dòng lại** và **chiều cao đổi ngay trong lúc kéo** (không co giãn méo, không chờ nhả tay) | §5.04 | Functional | Cao | Cao | Cao | P1 | 🔴 **viết lại** (TC-66 cũ nói ngược) |
| TC18-48 | Nhả tay → không nhảy, không đổi kích thước thêm lần nữa | §5.05 | Reliability | Vừa | Vừa | Vừa | P2 | ⚪ |
| TC18-49 | Thành phần **ngoài cùng**: kéo góc làm hẹp/rộng và **vẫn canh giữa** | §5.06 | Functional | Vừa | Vừa | Vừa | P2 | ⚪ |
| TC18-50 | Thành phần **trong Row (2 con)**: kéo góc = kéo **vách ngăn** — con bên cạnh hẹp lại đúng bằng đó, tổng bề rộng Row **không đổi** | §5.07 | Functional | Cao | Cao | Cao | P1 | ⚪ |
| TC18-51 | ⚠️ Thành phần trong Row có **3+ con**, kéo góc 1 phần tử: chỉ kiểm **phần bất biến quan sát được** — không con nào bị co về 0 (§5.08), không con nào bị đẩy ra ngoài Row / đè lên nhau, thao tác = **1 bước Undo**. **KHÔNG kiểm quy tắc phân bổ bù trừ** (chia đều / chỉ liền kề / phần tử cuối hấp thụ) vì **Q-13 còn mở — không suy diễn** | §5.07 (thiếu), §5.08 | Functional | Vừa | Vừa | Vừa | P2 ⚠️ | ⚪ (câu hỏi mở kế thừa) |
| TC18-52 | Không kéo được nhỏ hơn **mức tối thiểu** — xác nhận **có chặn / không co về 0**. **Q-3a đã cố ý bỏ → không có ngưỡng: kiểm hành vi, không kiểm giá trị** | §5.08 | Functional | Vừa | Vừa | Vừa | P2 | ⚪ |
| TC18-53 | **Cố ý:** 4 góc là vùng kéo hợp lệ dù **không vẽ vòng tròn** chỉ báo | §10 #3 | Usability | Vừa | Vừa | Vừa | P2 | ⚪ |

### E. Thêm thành phần, Row/Column, lồng nhau (§6, §10 #1) — 20 condition

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk | Ưu tiên | Δ |
|---|---|---|---|---|---|---|---|---|
| TC18-54 | Sheet **Add component** chia đúng **5 nhóm / tổng 16 mục**, đúng thứ tự: **CALENDAR (5)** Month grid · Mini month · Lunar calendar · Timetable · Week schedule — **EVENTS (4)** Today's events · Hour timeline · Week events · Activity grid — **TASKS (2)** Reminders · Priority matrix — **PROGRESS (3)** Year progress · Month progress · Countdown — **LAYOUT (2)** Row · Column. **Không còn nhóm Text.** Mỗi mục có **một dòng mô tả** bên dưới (dùng làm oracle chuỗi UI) | §6, §7.22 + ảnh sheet Add QC gửi 2026-09-28 (Q-21 đã đóng) | Functional | Vừa | Vừa | Vừa | P2 | 🔴 **viết lại** (TC-29 cũ "6 nhóm" sai) |
| TC18-55 | **Quote · Almanac day · Timeline KHÔNG** xuất hiện trong danh sách Add — đặc biệt **EVENTS chỉ có 4 mục**, không có Timeline (bản 1.2.17 có 5); không có nhóm Text nên không có Quote/Almanac day. Tên hiển thị đúng là **"Timetable"** (không phải "Week timetable"), **"Activity grid"**, **"Reminders"** | §6, §7.22 + ảnh sheet Add | Functional | Vừa | Vừa | Vừa | P2 | 🔴 / 🟠 |
| TC18-56 | 3 loại trên **vẫn sửa được** trên template đã có sẵn chúng (chỉ mất khả năng thêm mới) | §6, §7.22 | Functional | Vừa | Vừa | Vừa | P2 | 🟠 |
| TC18-57 | Chọn một loại bất kỳ → thành phần được thêm, toast *"Added …"* + **Undo** | §6.01 | Functional | Thấp | Cao | Vừa | P2 | ⚪ |
| TC18-58 | Thành phần mới **không chiếm hết bề rộng** — có lề hai bên sẵn; kiểm cho **cả 14 mục không thuộc Layout** trong danh sách 16 mục ở TC18-54 (full-width → report). **Q-14 đã cố ý bỏ → không có giá trị lề: kiểm hành vi ("không full-width"), không kiểm giá trị ("đúng lề giống Studio")** | §6.02 + danh sách 16 mục | Functional | Vừa | Thấp | Thấp | P3 | ⚪ |
| TC18-59 | Đang chọn một thành phần rồi bấm **+** → thành phần mới rơi **ngay dưới** cái đang chọn | §6.03 | Functional | Vừa | Vừa | Vừa | P2 | ⚪ |
| TC18-60 | Đang chọn một **Row/Column** rồi bấm **+** → thành phần mới rơi **vào trong** container đó | §6.04 | Functional | Vừa | Vừa | Vừa | P2 | ⚪ |
| TC18-61 | ⚠️ **Không chọn gì** rồi bấm **+** → thành phần mới **chèn vào giữa canvas** **(QC · Q-11a — còn đúng ở 1.2.18)**. ⚠️ Hành vi này **vẫn KHÔNG có trong spec 1.2.18** → là requirement ngoài tài liệu, cần dev đưa vào bản bàn giao chính thức | — (gap, TB-18) | Functional | Vừa | Vừa | Vừa | P2 ⚠️ | ⚠️ assumption kế thừa |
| TC18-62 | Thêm **Row** → một hàng gồm **2 ô trống nét đứt** nằm cạnh nhau, mỗi ô có nút **+** ở giữa | §6.1.01 | Functional | Thấp | Vừa | Thấp | P3 | ⚪ |
| TC18-63 | Thêm **Column** → 2 ô trống nét đứt **xếp dọc** | §6.1.02 | Functional | Thấp | Vừa | Thấp | P3 | ⚪ |
| TC18-64 | Bấm **+** trong một ô trống → thành phần lấp **đúng ô đó**, ô còn lại **vẫn còn nguyên** (regression của lỗi đã fix) | §6.1.03 | Functional | Cao | Cao | Cao | P1 | ⚪ |
| TC18-65 | Bấm vào **nền** ô trống (không trúng nút +) → **chọn container**, không mở sheet | §6.1.04 | Functional | Vừa | Vừa | Vừa | P2 | ⚪ |
| TC18-66 | Lấp nốt ô thứ 2 → Row/Column hiện đủ 2 thành phần, **chia đôi** | §6.1.05 | Functional | Thấp | Vừa | Thấp | P3 | 🔵 |
| TC18-67 | Container đã đủ con → **không còn ô trống** nào thừa ra | §6.1.06 | Functional | Thấp | Vừa | Thấp | P3 | 🔵 |
| TC18-68 | ⚠️ Ở **cấp thứ 3**, mở sheet Add → nhóm **Layout biến mất** (còn **14 mục / 4 nhóm**), các nhóm khác vẫn còn *(cách đếm cấp chưa chốt — **Q-13/Q-3b còn mở**: kiểm bằng cách lồng thực tế `Column > Row > Column` như ví dụ §6.2, không suy diễn mốc đếm)* | §6.2.01 | Functional | Vừa | Vừa | Vừa | P2 ⚠️ | ⚪ |
| TC18-69 | Ở **cấp 1–2**, nhóm **Layout** vẫn hiện bình thường | §6.2.02 | Functional | Thấp | Vừa | Thấp | P3 | ⚪ |
| TC18-70 | ⚠️ Thêm container **ngang hàng (sibling)** ở cấp còn cho phép → vẫn được (không bị tính dồn vào độ sâu) *(phụ thuộc cách đếm cấp — **Q-3b còn mở**)* | §6.2.03 | Functional | Vừa | Vừa | Vừa | P2 ⚠️ | ⚪ |
| TC18-71 | Thêm Row/Column rồi **không lấp gì**, bấm **✓** → container rỗng bị bỏ + toast *"Removed the empty layout"* kèm Undo | §6.3.01 | Functional | Vừa | Vừa | Vừa | P2 | ⚪ |
| TC18-72 | Bấm **Undo** trên toast đó → container rỗng **quay lại** màn editor | §6.3.02 | Reliability | Vừa | Vừa | Vừa | P2 | ⚪ |
| TC18-73 | **Cố ý:** Row/Column chỉ có **1 con** vẫn chiếm chỗ như đang có 2 con (ô trống thứ 2 giữ chỗ) | §10 #1 | Functional (xác nhận cố ý) | Thấp | Thấp | Thấp | P3 | ⚪ |

### F. Bảng thuộc tính — Edit component (§7, §10 #2, §10 #12, §12) — 27 condition trong phạm vi *(25 cũ + TC18-118, TC18-119 mới từ TB-22)* + **2 GAP ngoài phạm vi** (TC18-99, TC18-100)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk | Ưu tiên | Δ |
|---|---|---|---|---|---|---|---|---|
| TC18-74 | **Position:** chuyển **Auto ↔ Fixed** mà thành phần **không tự nhảy chỗ** | §7.01 | Functional | Vừa | Cao | Cao | P1 | ⚪ |
| TC18-75 | Chọn **Fixed** → hiện thanh **Vertical position**; kéo thì thành phần chạy dọc theo | §7.02 | Functional | Vừa | Vừa | Vừa | P2 | ⚪ |
| TC18-76 | Thanh **Width** khớp với thao tác **kéo góc** ở §5 (đồng bộ hai chiều) | §7.03 | Functional | Vừa | Vừa | Vừa | P2 | ⚪ |
| TC18-77 | **Cố ý:** thanh **Size** chỉ có với thành phần **ngoài cùng**; con trong Row/Column **không có** thanh này | §7.04, §10 #2 | Functional (xác nhận cố ý) | Thấp | Vừa | Thấp | P3 | ⚪ |
| TC18-78 | Các **knob riêng** theo loại (màu, phông, số dòng…) đổi được và **ăn ngay** trên canvas — **chỉ kiểm giá trị cho ~10 loại spec có nêu knob** (§7.14 – §7.21: Month grid, Mini month, Today's events, Timeline, Week events, Year progress, Countdown, Priority matrix, Hour timeline, Timetable). Các loại còn lại xem **TC18-118** *(không có oracle — TB-22)* | §7.05, §7.14 – §7.21 | Functional | Vừa | Vừa | Vừa | P2 | ⚪ |
| TC18-79 | **Duplicate · Delete · Deselect** ở cuối bảng chạy đúng. **(QC · Q-17)** **Deselect** cho **cùng trạng thái cuối** với **✕** và với chạm vùng trống: bảng **đóng** · khung viền **mất** · nút **+ (Add)** **hiện lại** | §7.06, §7.09, §3.02 | Functional | Vừa | Vừa | Vừa | P2 | ⚪ |
| TC18-80 | ⚠️ Slider nhóm **Position** (Vertical position, Width, Horizontal offset, Size) kéo **mượt, không khựng**, kể cả **kéo qua kéo lại, tay hơi lệch dọc**; canvas chạy theo ngay. **Giả định làm việc (Q-7, QC chấp nhận — chờ dev):** hướng cử chỉ được **khoá một lần từ đầu** và giữ tới khi nhả tay → bắt đầu trên slider mà thiên về **ngang** thì **slider chạy**, lệch dọc nhẹ **không** làm khựng. **Ngưỡng góc/thời gian đã cố ý bỏ → kiểm hành vi, không kiểm giá trị** | §7.07 | Performance efficiency | Cao | Cao | Cao | P1 ⚠️ | 🟠 |
| TC18-81 | Nhả tay sau khi kéo slider = **đúng 1 bước Undo** | §7.07 | Reliability | Vừa | Vừa | Vừa | P2 | 🟠 |
| TC18-82 | ⚠️ Đang kéo slider thì **bảng không cuộn theo**; nhưng **vuốt dọc gần thẳng đứng** bắt đầu trên slider **vẫn cuộn bảng**. **Giả định làm việc (Q-7, chờ dev):** đã khoá hướng thì **không đổi giữa chừng** — slider chạy ⇒ bảng đứng yên; bảng cuộn ⇒ **giá trị slider không đổi**. **Mâu thuẫn §7.07 ↔ §7.08 vẫn nằm trong tài liệu** — dev trả lời khác thì sửa dòng này và TC18-80 | §7.08, §7.07 | Functional (gesture conflict) | Cao | Vừa | Cao | P1 ⚠️ | 🟠 |
| TC18-83 | **Grabber**: vuốt xuống để **đóng bảng**, thành phần **vẫn được chọn** (khác hẳn ✕/Deselect — khung viền **còn**, nút **+** **chưa** hiện lại) **(QC · Q-17, đối chiếu)** | §7.09 | Functional | Vừa | Cao | Cao | P1 | 🟠 |
| TC18-84 | Nút **✕** trong bảng = **bỏ chọn + đóng bảng** → khung viền **mất**, nút **+ (Add)** hiện lại — **cùng trạng thái cuối** với **Deselect** và với **chạm vùng trống** **(QC · Q-17)** | §7.09, §7.06, §3.02 | Functional | Vừa | Cao | Cao | P1 | 🟠 |
| TC18-85 | Bảng mở che thành phần đang chọn → **canvas tự đẩy lên**; đóng bảng thì canvas **về chỗ cũ** | §7.10 | Usability | Vừa | Vừa | Vừa | P2 | 🟠 |
| TC18-86 | **Đáy bảng không hở** trên máy có và không có home indicator | §7.11 | Usability / Compatibility | Vừa | Vừa | Vừa | P2 | 🟡 |
| TC18-87 | Thanh **Size**: chữ chính **tối đa 200**, chữ phụ (caption, giờ, thứ…) **tối đa 60** — chỉ BVA **biên trên**. **Q-16 đã cố ý bỏ → không có biên dưới/đơn vị: kiểm hành vi (không vượt được trần), không kiểm giá trị biên dưới**; trường hợp template có sẵn vượt trần: **ghi nhận quan sát, không kết luận pass/fail** | §7.12 | Functional (giá trị biên) | Vừa | Vừa | Vừa | P2 | 🟡 |
| TC18-88 | **Bold + Italic** bật cùng lúc → chữ **vừa đậm vừa nghiêng** (trước chỉ ăn 1) | §7.13 | Functional | Vừa | Vừa | Vừa | P2 | 🟡 |
| TC18-89 | 2 template có sẵn cả bold+italic (month *"elegant script"*, priority matrix): tiêu đề giờ **đậm hơn trước** là **đúng dữ liệu template** → **KHÔNG report** **(QC · Q-2)**. Vẫn chưa chỉ rõ **phần tử nào** đậm hơn và chưa có ảnh baseline 1.2.17 → khi chạy **đối chiếu ảnh, chỉ ghi nhận quan sát**, không mở bug | §7.13 | Functional (xác nhận cố ý) | Vừa | Thấp | Thấp | P3 | 🟡 |
| TC18-90 | Các **mục phụ đã đưa ra ngoài** *More options*, có tiêu đề nhỏ riêng: **Weekday** (Month grid, Mini month) · **Time** (Today's events, Timeline) · **Date** (Week events) · **Caption** (Year progress, Countdown) | §7.14 | Functional | Vừa | Vừa | Vừa | P2 | 🟡 |
| TC18-91 | Hàng **màu** đã chỉnh có nút **↺ Reset** → trả về màu mặc định (Priority matrix về lại bộ **4 màu** theo từng ô) | §7.15 | Functional | Vừa | Vừa | Vừa | P2 | 🟡 |
| TC18-92 | **Countdown:** sửa được **chữ caption** (Content → Caption); để trống = **ẩn caption**; áp khi Done/ra ngoài ô = **1 bước Undo** | §7.16 | Functional | Vừa | Vừa | Vừa | P2 | 🟡 |
| TC18-93 | **Priority matrix:** màu chữ **ghi chú / công việc / giờ** riêng biệt + **Blur** nền ô; **không còn** mục "Layout" | §7.17 | Functional | Vừa | Vừa | Vừa | P2 | 🟡 |
| TC18-94 | **Month grid:** màu ngày **quá khứ / tương lai** (trong mục **Day**); căn phải tiêu đề tháng chạy đúng | §7.18 | Functional | Vừa | Vừa | Vừa | P2 | 🟡 |
| TC18-95 | **Hour timeline:** có **Elapsed color** (màu phần đã qua) và có tác dụng | §7.19 | Functional | Thấp | Vừa | Thấp | P3 | 🟡 |
| TC18-96 | **Timetable:** đổi **cỡ chữ ngày** và **màu giờ** có tác dụng | §7.20 | Functional | Thấp | Vừa | Thấp | P3 | 🟡 |
| TC18-97 | **Timeline:** **Blur** nền thẻ có tác dụng; **bỏ** "Cards per day" | §7.21 | Functional | Thấp | Vừa | Thấp | P3 | 🟡 |
| TC18-98 | **Cố ý:** con số cạnh tên slider **Position** chỉ cập nhật **khi nhả tay**; lúc kéo xem giá trị ở **bong bóng** trên núm | §10 #12 | Functional (xác nhận cố ý) | Thấp | Thấp | Thấp | P3 | 🟡 |
| TC18-118 | ⚠️ **Loại component KHÔNG có oracle cho knob riêng** — **Lunar calendar · Week schedule · Month progress · Reminders · Activity grid** (5/14 mục thêm mới được): chỉ kiểm **vòng đời chung** — thêm từ sheet Add (toast *"Added …"* + Undo) · hiện đúng trên canvas · **chọn** (khung viền + pill) · **kéo** di chuyển · **đổi bề rộng** · **Duplicate/Delete + Undo**. **KHÔNG kiểm knob riêng, không suy diễn knob** (spec chỉ có §7.05 chung chung — TB-22) | §6, §6.01, §3, §4, §5 + TB-22 | Functional | Vừa | Vừa | Vừa | P2 ⚠️ | 🟠 mới (TB-22) |
| TC18-119 | ⚠️ **Quote · Almanac day** (chỉ tồn tại trên **template có sẵn**, không thêm mới được): chọn / kéo / đổi bề rộng / Duplicate / Delete + Undo chạy đúng; bảng thuộc tính **mở được**. **KHÔNG kiểm knob riêng** — không có oracle (TB-22). *Riêng ô **Lines** của Quote nằm trong Q-4 → xem **GAP** bên dưới* | §6, §7.22, §3, §4, §5 + TB-22 | Functional | Vừa | Vừa | Vừa | P2 ⚠️ | 🟠 mới (TB-22) |

#### GAP — đưa ra ngoài phạm vi thực thi (không có oracle, chờ Q-4)

> Theo §12 chính spec ghi "cần QC làm rõ, **chưa sửa**" → **không viết expected result, không suy diễn**. Giả định làm việc của QC (Year progress **không có** "target date"; ô *Lines* của Quote **phải có tác dụng**; sửa chữ quote **không** phải requirement) được ghi lại ở mục 1 (TB-02) **nhưng không dùng làm oracle**. Test-plan **không** đưa hai dòng này vào phạm vi cho tới khi QC gửi ảnh/mô tả và **dev chốt**.

| # | Test condition | Nguồn | Trạng thái |
|---|---|---|---|
| TC18-99 | **Year progress — "target date"**: hành vi mong đợi? (code không có tuỳ chọn này; Countdown thì có) | §12 | **GAP — ngoài phạm vi thực thi** (chặn bởi Q-4) |
| TC18-100 | **Quote — "chữ / số dòng"**: hành vi mong đợi? (ô *Lines* vs số dòng thật; có sửa được chữ quote trong màn này không) | §12 | **GAP — ngoài phạm vi thực thi** (chặn bởi Q-4) |

### G. Undo / Redo / Lưu (§8) — 4 condition

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk | Ưu tiên | Δ |
|---|---|---|---|---|---|---|---|---|
| TC18-101 | **Undo** hoàn lại **đúng một thao tác** — một lần kéo = một bước (không hoàn từng frame) | §8.01 | Reliability | Cao | Cao | Cao | P1 | ⚪ |
| TC18-102 | **Redo** làm lại đúng thao tác vừa Undo | §8.02 | Reliability | Vừa | Vừa | Vừa | P2 | ⚪ |
| TC18-103 | **✓ (Done)** → quay lại màn editor, bố cục mới được giữ | §8.03 | Functional | Vừa | Cao | Cao | P1 | ⚪ |
| TC18-104 | **✕ (Cancel)** → **mọi** thay đổi trong phiên bị bỏ (kể cả thành phần vừa thêm), wallpaper trở về **đúng như lúc mở màn** | §8.04 | Functional | Vừa | Cao | Cao | P1 | 🔵 (làm rõ) |

### H. Chrome phụ (§9) — 4 condition

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk | Ưu tiên | Δ |
|---|---|---|---|---|---|---|---|---|
| TC18-105 | **Show grid** bật/tắt lưới căn; lưới **không đè lên** thao tác kéo (hit-testing) | §9.01 | Functional | Vừa | Vừa | Vừa | P2 | ⚪ |
| TC18-106 | ⚠️ Cảnh báo *"Part of this runs off the screen"* **chỉ bật khi kéo band RA KHỎI cạnh screen**; kéo **sát mép mà vẫn bên trong → KHÔNG** cảnh báo; kéo về trong thì cảnh báo mất **(QC · Q-8)**. ⚠️ *Giả định còn lại: "cạnh screen" ≡ "mép ảnh" (§4.03) — chưa xác nhận; nếu hai biên khác nhau thì phải thêm condition cho vùng giữa hai biên* | §9.02, §4.03 | Functional | Vừa | Vừa | Vừa | P2 ⚠️ | ⚪ |
| TC18-107 | Nút **ẩn/hiện chrome**: ẩn hết nút để xem wallpaper "sạch", chạm lại hiện lại | §9.03 | Usability | Thấp | Thấp | Thấp | P3 | ⚪ |
| TC18-108 | **Xoay iPad** → khung viền và các ô trống vẫn khớp với thành phần, không lệch *(chỉ khi có máy iPad — TB-20)* | §9.04, §1 | Portability | Vừa | Vừa | Vừa | P2 | ⚪ |

### I. Regression ngoài màn editor (§11, §10 #6) — 9 condition

> Màn này **ghi thẳng vào dữ liệu wallpaper**; phạm vi thay đổi 1.2.18 (snap, gap âm, reorder, kéo tới mép ảnh) rộng hơn 1.2.17 → **rủi ro ghi sai dữ liệu cao hơn**, không rút gọn nhóm này.

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk | Ưu tiên | Δ |
|---|---|---|---|---|---|---|---|---|
| TC18-109 | **Đặt làm màn khoá thật** → wallpaper render đúng bố cục vừa sửa (không chỉ đúng trên preview) | §11.01 | Reliability | Vừa | Cao | Cao | P1 | ⚪ |
| TC18-110 | **Live Activity** của template đó vẫn chạy, không vỡ layout | §11.02 | Functional | Vừa | Cao | Cao | P1 | ⚪ |
| TC18-111 | **Widget / thumbnail** trong "Your collection" cập nhật theo | §11.03 | Functional | Vừa | Cao | Cao | P1 | ⚪ |
| TC18-112 | Mở lại template **đã sửa** → bố cục giữ nguyên, sửa tiếp được | §11.04 | Reliability | Vừa | Cao | Cao | P1 | ⚪ |
| TC18-113 | Các **template lịch cũ** (chưa động vào) render y như trước | §11.05 | Reliability | Thấp | Cao | Vừa | P2 | ⚪ |
| TC18-114 | Wallpaper **note** (không phải lịch) không bị ảnh hưởng | §11.06 | Functional | Thấp | Vừa | Thấp | P3 | ⚪ |
| TC18-115 | ⚠️ Sửa bố cục ở Component Editor (S03) **+** trang trí ở Decorate (S02) trên **cùng template** → wallpaper cuối render **đủ cả hai phần** — **(QC · Q-11b) còn đúng ở 1.2.18**. ⚠️ **Vẫn không có trong spec 1.2.18** (nguồn gốc: trao đổi miệng 2026-09-24) → requirement ngoài tài liệu, **đề nghị dev đưa vào bản bàn giao chính thức** | — (gap, TB-18) | Reliability | Vừa | Cao | Cao | P1 ⚠️ | ⚠️ assumption |
| TC18-116 | ⚠️ Bố cục đã lưu **sống sót qua automation Shortcut chạy lại qua đêm** (wallpaper tự render mỗi sáng), không reset về bố cục gốc — **phải chờ qua đêm thật, không đổi giờ hệ thống** — **(QC · Q-11c) còn đúng ở 1.2.18**. ⚠️ **Vẫn không có trong spec 1.2.18** → requirement ngoài tài liệu, cần đưa vào tài liệu chính thức | — (gap, TB-18) | Reliability | Vừa | Cao | Cao | P1 ⚠️ | ⚠️ assumption |
| TC18-117 | ⚠️ **Cố ý:** card **kính mờ (frosted)** có sticker nằm dưới — trong editor card chỉ làm mờ ảnh nền, không mờ sticker; **wallpaper đã lưu thì đúng**; chỉ report nếu sai trên **lock screen thật** *(**Q-18 còn mở**: "đúng" = sticker **được** hay **không được** làm mờ → chỉ ghi nhận quan sát kèm ảnh, không kết luận pass/fail cho tới khi dev chốt)* | §10 #6 | Functional (xác nhận cố ý) | Vừa | Vừa | Vừa | P2 ⚠️ | 🟠 |

### Tổng hợp số lượng

| Ưu tiên | Trước 2026-09-28 | **Sau đợt trả lời 2026-09-28** | Giải thích thay đổi |
|---|---|---|---|
| **P1** | 40 | **41** | +1: TC18-36a (tách từ TC18-36, hết TBD) |
| **P2** | 53 | **58** | +5: TC18-36b (tách), TC18-51 (hết TBD), TC18-61 (hết TBD), TC18-118 + TC18-119 (mới, từ TB-22) |
| **P3** | 18 | **19** | +1: TC18-89 (Q-2 đã trả lời → risk Thấp) |
| **TBD** (chưa gán được risk) | 6 | **0** | −6: 4 dòng đã gán risk, 2 dòng chuyển sang GAP |
| **GAP — ngoài phạm vi thực thi** | — | **2** | TC18-99, TC18-100 (chặn bởi Q-4, không có oracle) |
| **Tổng trong phạm vi** | 111 (+ 6 TBD) | **118** | 41 + 58 + 19 |
| **Tổng cả GAP** | 117 | **120** | +1 (tách TC18-36) +2 (TB-22) |

**Condition gắn ⚠️ (gap-dependent) — 18 dòng, test-plan BẮT BUỘC mang nhãn sang:**
TC18-19, TC18-20 *(Q-10)* · TC18-23, TC18-24, TC18-106 *(Q-8 — "screen" vs "ảnh")* · TC18-25, TC18-27 *(Q-12)* · TC18-80, TC18-82 *(Q-7)* · TC18-51 *(Q-13 mở)* · TC18-68, TC18-70 *(Q-3b mở)* · TC18-117 *(Q-18 mở)* · TC18-61, TC18-115, TC18-116 *(Q-11 — requirement ngoài spec)* · TC18-118, TC18-119 *(TB-22 — không có oracle knob)*.

**Condition mang nhãn (QC) — expected result từ câu trả lời của QC, chưa có dev xác nhận:**
TC18-16, TC18-17 *(Q-9)* · TC18-23, TC18-24, TC18-106 *(Q-8)* · TC18-29 *(Q-6)* · TC18-36a, TC18-36b *(Q-1)* · TC18-54, TC18-55 *(Q-21)* · TC18-61, TC18-115, TC18-116 *(Q-11)* · TC18-79, TC18-83, TC18-84 *(Q-17)* · TC18-89 *(Q-2)*.

Phân bố theo mức thay đổi: 🔴 viết lại **4** (TC18-23, TC18-24, TC18-47, TC18-54, cộng TC18-35/36a/36b là hệ quả đảo "hành vi cố ý" cũ) · 🟠 mới quan trọng **26** (thêm TC18-118, TC18-119) · 🟡 mới phụ **18** · 🔵 trace lại **4** · ⚪ tái sử dụng **~65**.

---

## 3. Traceability nháp

### 3A. Test condition ↔ mục test basis 1.2.18

| Test condition # | Mục test basis (mã §N.M) | Ghi chú cho test-plan |
|---|---|---|
| TC18-01 | §header (bảng build + cảnh báo rc1/rc2) | Gợi ý **TO-ENTRY**. Nên là **entry criteria** của cả đợt, không phải test case thường: sai build thì mọi kết quả khác vô nghĩa. |
| TC18-02 – TC18-05 | §2, §10 #5 | **TO-ENTRY**. TC18-02 là smoke test gate cho mọi nhóm khác. |
| TC18-06 – TC18-07 | §1 (bảng thiết bị) | **TO-DEVICE-MATRIX**. iOS 27 **ngoài phạm vi** đợt này (lý do: bug Shortcut riêng). |
| TC18-08 | §1 (ngôn ngữ) | **TO-L10N**. Có thể gộp với bộ localization chung của app nếu đã có. |
| TC18-09 – TC18-14 | §3.01 – §3.06, §10 #4 | **TO-SELECT**. TC18-11 nên có Decision Table theo cấp lồng (0/1/2/3) — hành vi cố ý dễ bị report nhầm. |
| TC18-15 – TC18-20 | §3.07 – §3.09, §10 #13 | **TO-REORDER** (nhóm **mới hoàn toàn**). Decision Table cho tổ hợp {vị trí đầu/giữa/cuối} × {Auto/Fixed} × {stack/Row} **đã dựng được** nhờ Q-9a/9b **(QC)**: Fixed **bị loại khỏi** danh sách tính đầu/cuối và bị **nhảy qua** khi đổi chỗ. TC18-19/TC18-20 **⚠️ gap-dependent (Q-10)** — test-plan phải ghi rõ nhãn và điều kiện thay đổi. Tương tác chặt với gap âm (TC18-25). |
| TC18-21 – TC18-24, TC18-30 – TC18-34 | §4.01 – §4.04, §4.07 – §4.11 | **TO-DRAG**. Toàn nhóm risk Cao → bắt buộc **máy thật**, không simulator; test với layout **Row lồng trong Column** đúng yêu cầu §4. |
| TC18-25 – TC18-29 | §4.05, §4.06 | **TO-SNAP** (nhóm **mới**). BVA chỉ trên **dấu** (`0` / số âm / không `-0`) — **không BVA giá trị tuyệt đối** vì đơn vị chip đã cố ý bỏ. Haptic (TC18-29) có expected result rõ từ Q-6a/6b **(QC)**, phải kiểm trên **máy thật**. TC18-25/TC18-27 **⚠️ gap-dependent (Q-12 — mốc gap 0 = vạch trên grid là giả định)**. |
| TC18-35, TC18-36a, TC18-36b | §4.12 và §10 #8 | **TO-DRAG**. Q-1 **đã trả lời (QC — cách hiểu A)**: §4.12 và §10 #8 là **hai trường hợp khác nhau**, **không** phải mâu thuẫn → TC18-36 tách thành **TC18-36a** (kéo container, P1) và **TC18-36b** (kéo con bên trong, P2 — hành vi cố ý, không report). Test-plan phải ghi rõ hai trường hợp này ở **hai test case tách biệt**, cùng template có Row/Column gắn thẻ nền. |
| TC18-37 – TC18-43 | §4.13 – §4.15, §10 #7, #9, #10, #11 | **TO-DRAG** + **TO-INTENDED**. TC18-39 cần tập máy đa dạng; TC18-42 cần đúng 4 template `mix-*` được nêu tên. |
| TC18-44 – TC18-53 | §5.01 – §5.08, §10 #3 | **TO-RESIZE**. TC18-47 là **đảo ngược** — phải ghi rõ "expected result đã đổi so với 1.2.17" để tester cũ không báo nhầm. TC18-51/TC18-52 chờ Q-3. |
| TC18-54 – TC18-61 | §6, §6.01 – §6.04, §7.22 + **ảnh sheet Add 2026-09-28** | **TO-ADD**. TC18-54/55 là **regression của việc gỡ nhóm Text + gỡ Timeline khỏi EVENTS** — oracle nay là **danh sách 16 mục / 5 nhóm** (Q-21 đã đóng, ảnh khớp spec). Dùng chính ảnh này để cập nhật lại wireframe §S03 + `index.md` (TB-17), **nhưng ảnh chưa hiện số build → chụp lại kèm build 111 khi làm Q-19 (không chặn)**. TC18-61 **⚠️** (Q-11a: chèn giữa canvas — ngoài spec). |
| TC18-62 – TC18-73 | §6.1.01 – §6.1.06, §6.2.01 – §6.2.03, §6.3.01 – §6.3.02, §10 #1 | **TO-NEST**. TC18-64 ghi chú "regression — lỗi cũ vừa fix". TC18-68/70 **⚠️** (Q-3b còn mở — kiểm bằng cấu trúc lồng thật `Column > Row > Column`, không suy diễn mốc đếm cấp). Ở cấp 3, sheet Add còn **14 mục / 4 nhóm**. |
| TC18-74 – TC18-79, TC18-98 | §7.01 – §7.06, §10 #2, §10 #12 | **TO-PROPS** (phần nền, tái sử dụng từ 1.2.17). |
| TC18-80 – TC18-86 | §7.07 – §7.11 | **TO-PROPS-UX** (nhóm **mới**: slider, cử chỉ, grabber). TC18-83/84 nên là State Transition (trạng thái {bảng mở/đóng} × {đang chọn/không chọn} × {nút + hiện/ẩn}) — **Q-17 (QC)** đã chốt: ✕ / Deselect / chạm vùng trống **cùng một trạng thái cuối**, còn **grabber** thì **giữ selection** ⇒ đúng 2 trạng thái cuối khác nhau. TC18-80/82 **⚠️ gap-dependent (Q-7)** — mâu thuẫn §7.07 ↔ §7.08 **chưa được dev gỡ**. |
| TC18-87 – TC18-98 | §7.12 – §7.21 | **TO-PROPS-KNOB**. TC18-87 BVA **chỉ biên trên** (Q-16 đã bỏ). TC18-90 – TC18-97 phải kiểm **theo từng loại thành phần được nêu tên**, không kiểm chung. |
| **TC18-118, TC18-119** | §6, §7.05 + **TB-22** | **TO-PROPS-KNOB / TO-ADD**. Nhóm loại **không có oracle knob** (Lunar calendar, Week schedule, Month progress, Reminders, Activity grid + Quote, Almanac day chỉ-sửa): test-plan **chỉ được thiết kế case vòng đời chung**, **cấm suy diễn knob**. Ánh xạ tên UI → tên code (`contributionGrid`, `reminderList`, `timelineCards`) **là suy luận — không dùng làm expected result**. |
| TC18-99 – TC18-100 | §12 | **Không gán test object** — `GAP`, **ngoài phạm vi thực thi**, theo đúng yêu cầu của chính §12 và Q-4 chưa đóng. |
| TC18-101 – TC18-104 | §8.01 – §8.04 | **TO-UNDO**. Cần đối chiếu chéo: mọi thao tác mới (reorder TC18-18, slider TC18-81, caption TC18-92) đều phải = 1 bước Undo. |
| TC18-105 – TC18-108 | §9.01 – §9.04 | **TO-CHROME**. TC18-106 có expected result từ Q-8 **(QC)** nhưng **⚠️** vì còn giả định "cạnh screen ≡ mép ảnh". |
| TC18-109 – TC18-117 | §11.01 – §11.06, §10 #6 | **TO-REGRESSION**. Chạy **sau** khi TO-DRAG/TO-RESIZE/TO-ADD pass. TC18-116 nên khởi động sớm nhất (cần chờ qua đêm thật). TC18-115/116 **⚠️**: QC xác nhận **còn đúng ở 1.2.18 (Q-11b/11c)** nhưng **vẫn nằm ngoài spec** → test-plan ghi rõ "requirement ngoài tài liệu, chờ dev đưa vào bản bàn giao". TC18-117 **⚠️** (Q-18 mở). |

### 3B. Ánh xạ sang bộ test 1.2.17 (tái sử dụng / viết lại / mới)

| Bộ 1.2.17 | Bộ 1.2.18 | Trạng thái |
|---|---|---|
| TC-01…TC-13, TC-15…TC-26, TC-30, TC-32…TC-38, TC-40…TC-65, TC-67*, TC-68…TC-70 | tương ứng trong mục 2 | ⚪ **Tái dùng** nội dung, chỉ đổi nguồn trace sang mã `§N.M` của 1.2.18 |
| **TC-14** ("có chặn trên và dưới đúng **vùng nội dung**") | TC18-22 + **TC18-23** + **TC18-24** | 🔴 **SAI theo 1.2.18** — giới hạn nay là **mép ảnh**; tách thành 3 condition, viết lại expected result |
| **TC-29** ("sheet Add đủ **6 nhóm**… Text") | **TC18-54** (+ TC18-55, TC18-56) | 🔴 **SAI** — chỉ còn **5 nhóm**, bỏ Text |
| **TC-66** ("trong lúc kéo chữ **không** xuống dòng lại, chiều cao không đổi") | **TC18-47** (resize) + TC18-40 (move) | 🔴 **SAI/đảo ngược** — resize nay reflow **ngay lúc kéo**; phần còn lại của hành vi cũ chỉ còn là "chữ hơi mềm 2/3 độ phân giải" khi *move* |
| **TC-67** ("thẻ nền container không đổi theo từng frame") | **TC18-36a + TC18-36b** | 🔴 **Không còn đúng nguyên trạng** — thay bằng **hai** condition theo Q-1 **(QC, cách hiểu A)**: kéo container → thẻ đi cùng; kéo con → thẻ tạm ẩn rồi hiện lại (cố ý, không report) |
| TC-27 (Row 3+ con), TC-28 (ngưỡng min width) | TC18-51, TC18-52 | ⚪ 1.2.18 không bổ sung. **TC18-52**: Q-3a **đã cố ý bỏ** → kiểm hành vi, không kiểm giá trị. **TC18-51**: Q-13 **vẫn mở** → chỉ kiểm phần bất biến, gắn **⚠️** |
| TC-71, TC-72, TC-73 | TC18-61, TC18-115, TC18-116 | ⚠️ **Assumption** (trao đổi miệng, 1.2.17) — QC xác nhận **còn đúng ở 1.2.18 (Q-11)** nhưng **vẫn ngoài spec**: giữ nhãn ⚠️, **không** nâng thành requirement |
| — (không có ở 1.2.17) | TC18-01, TC18-15…TC18-20, TC18-25…TC18-30, TC18-37…TC18-43, TC18-55, TC18-56, TC18-80…TC18-98 (phần 🟠/🟡), TC18-117, **TC18-118, TC18-119** | 🟠/🟡 **Mới** — chưa có condition/case nào ở bộ cũ. TC18-118/119 là **mới hoàn toàn từ TB-22** (danh mục component chưa có oracle knob) |

---

## 4. Câu hỏi cần làm rõ trước khi lập test plan

> `[CHẶN]` = thuộc nhóm "bắt buộc dừng" của skill test-analysis (mâu thuẫn nội bộ / mơ hồ 2 cách hiểu đổi tập test condition / không đủ căn cứ gán risk / thiếu acceptance criteria). Theo mặc định, còn `[CHẶN]` chưa trả lời thì **không** được chạy `test-plan`.
> **Ngoại lệ đã được người duyệt quyết định (QC, 2026-09-28 — phương án A):** 4 câu hỏi ở mục 4A **vẫn chưa được trả lời bởi dev**, nhưng người review chấp nhận cho `test-plan` chạy trên **giả định làm việc** + **descope**. Vì vậy nhãn của chúng đổi thành **"đã được QC chấp nhận giả định — chờ dev xác nhận (không chặn test-plan)"**. **Đây không phải là câu trả lời** — nội dung câu hỏi giữ nguyên, không xoá.
> `[MỞ]` = không chặn test-plan, nhưng giảm độ chính xác; cần trả lời trước khi thiết kế BVA/expected result ở `test-case`.

### 4A. Câu hỏi CHẶN **còn lại** (4) — nhãn hiện tại: **đã được QC chấp nhận giả định — chờ dev xác nhận (không chặn test-plan)**

> Nguồn mọi câu trả lời: [answers-1.2.18.md](answers-1.2.18.md) — **QC trả lời, chưa có dev xác nhận**.
> **Điều kiện để chuyển từ GIẢ ĐỊNH → FACT: dev trả lời.** Khi dev trả lời: (1) đổi nhãn ASSUMPTION → FACT trong `answers-1.2.18.md` trước, (2) rồi mới gỡ ⚠️ của đúng các condition tương ứng ở tài liệu này và ở test-plan/test-case. Dev trả lời khác giả định → **dev thắng**, viết lại đúng các dòng ⚠️ đó.
> Bốn câu dưới đây vẫn giữ nguyên mã `[CHẶN]` về **bản chất kỹ thuật** (mâu thuẫn/mơ hồ/thiếu acceptance criteria chưa được gỡ trong test basis); chúng **không còn chặn `test-plan`** chỉ vì **quyết định duyệt của con người**, xem mục 5.

1. **[Q-7 · TC18-80, TC18-82 ⚠️ · TB-05] — đã được QC chấp nhận giả định — chờ DEV xác nhận (không chặn test-plan)**
   §7.07 (kéo qua kéo lại, **tay hơi lệch dọc**, slider phải không khựng) vs §7.08 (**vuốt dọc** bắt đầu trên slider **vẫn cuộn bảng**) — **mâu thuẫn này vẫn nằm nguyên trong tài liệu**, chưa ai sửa spec.
   → **Giả định làm việc QC đã chấp nhận:** khoá hướng cử chỉ **một lần từ đầu**, giữ tới khi nhả tay (thiên ngang → slider; gần thẳng dọc → cuộn bảng; đã khoá thì không đổi giữa chừng). Ngưỡng góc/thời gian **đã cố ý bỏ**.
   → **Vẫn cần dev xác nhận** quy tắc này đúng với gesture recognizer thật.
   *Ảnh hưởng nếu dev trả lời khác:* chỉ TC18-80, TC18-82 phải sửa expected result (đã gắn ⚠️).
2. **[Q-10 · TC18-19, TC18-20 ⚠️ · TB-08] — đã được QC chấp nhận giả định — chờ DEV xác nhận (không chặn test-plan)**
   §3.08 "**khoảng cách giữa các vị trí giữ nguyên**" — với hai band cao thấp khác nhau: giữ **gap** hay giữ **đỉnh slot**?
   → **Giả định làm việc QC đã chấp nhận:** giữ nguyên **gap từng vị trí**, tổng chiều cao stack không đổi, gap âm ở lại **vị trí đầu**.
   → **Vẫn cần dev xác nhận** vì đây đúng vùng vừa fix lỗi "đè band".
   *Ảnh hưởng nếu dev trả lời khác:* TC18-19, TC18-20 (⚠️) đổi expected result; có thể phải thêm condition cho trường hợp band cao đổi xuống slot thấp.
3. **[Q-12 · TC18-25, TC18-27 ⚠️ · TB-09] — đã được QC chấp nhận giả định — chờ DEV xác nhận (không chặn test-plan)**
   §4.06 "band đầu: **chỗ khối bắt đầu**" là mốc nào?
   → **Giả định làm việc QC đã chấp nhận:** mốc = **vạch trên của grid**. **Đơn vị chip gap đã cố ý bỏ** — không kiểm giá trị.
   → **Vẫn cần dev xác nhận**; nếu mốc là "mép trên vùng nội dung" hoặc "mép trên ảnh" thì điểm snap gap 0 nằm chỗ khác.
   *Ảnh hưởng nếu dev trả lời khác:* TC18-25, TC18-27 (⚠️).
4. **[Q-4 · TC18-99, TC18-100 (GAP, đã descope — ngoài phạm vi) · TB-02] — câu hỏi VẪN MỞ, chờ QC gửi bằng chứng rồi DEV chốt (không chặn test-plan vì 2 condition đã descope)**
   §12 Year progress *"target date"* và Quote *"chữ / số dòng"* — dev ghi rõ **chưa có quyết định, đang chờ QC**.
   → **Việc QC phải làm:** gửi **ảnh chụp** chỗ thấy mục "target date" ở Year progress; mô tả *làm gì / thấy gì / mong đợi gì* cho Quote. Sau đó **dev chốt**.
   → Giả định làm việc (Year progress **không có** target date; ô *Lines* **phải có tác dụng**; sửa chữ quote **không** phải requirement) **đã được ghi lại ở TB-02 nhưng KHÔNG dùng làm oracle**.
   *Xử lý hiện tại:* **TC18-99, TC18-100 giữ `GAP` và nằm NGOÀI phạm vi thực thi** — test-plan không đưa vào, không suy diễn expected result.

### 4B. Câu hỏi CHẶN **đã được xử lý** trong đợt này (chỉ để truy vết)

| Q | Trạng thái | Nguồn | Condition đã cập nhật |
|---|---|---|---|
| Q-1 | ✅ Trả lời — cách hiểu **A** (hai trường hợp, không mâu thuẫn) | QC | TC18-36a, TC18-36b *(tách đôi)* |
| Q-2 | ✅ Trả lời — "đậm hơn" là **đúng dữ liệu template**, không report | QC | TC18-89 → **P3** |
| Q-6a/6b | ✅ Trả lời — rung **1 lần/điểm snap**; 2 điểm gần nhau → hút điểm gần hơn, **rung 1 lần** | QC | TC18-29 |
| Q-8 | ✅/⚠️ Trả lời một phần — cảnh báo **chỉ khi ra khỏi cạnh screen**; **còn giả định "screen ≡ ảnh"** | QC | TC18-23, TC18-24, TC18-106 *(⚠️)* |
| Q-9a/9b | ✅ Trả lời — **nhảy qua** band Fixed; Fixed **không tính** vào đầu/cuối → ẩn ↓ | QC | TC18-15, TC18-16, TC18-17 |
| Q-11 | ✅ Trả lời — a, b, c **còn đúng ở 1.2.18**; ⚠️ vẫn **ngoài spec**, cần dev đưa vào tài liệu chính thức | QC | TC18-61, TC18-115, TC18-116 *(⚠️)* |
| Q-17 | ✅ Trả lời — ba đường bỏ chọn **cùng trạng thái cuối** | QC | TC18-79, TC18-83, TC18-84 |
| Q-21 | ✅ **Đóng** — sheet Add = **16 mục / 5 nhóm**, QC rút lại nhận định "19 mục"; ảnh khớp spec §6/§7.22 | Spec + ảnh QC gửi | TC18-54, TC18-55, TC18-58 |

### 4C. Đã **cố ý bỏ** — không chờ trả lời

**Q-3a** (bề rộng tối thiểu) · **Q-14** (lề "giống Studio") · **Q-15** (tiêu chí fps) · **Q-16** (biên dưới / đơn vị Size) · **đơn vị chip gap** (phần của Q-12) · **ngưỡng góc/thời gian** (phần của Q-7).
Condition liên quan (TC18-52, TC18-58, TC18-39, TC18-87, TC18-25, TC18-80) ghi thống nhất: **"không có ngưỡng — kiểm hành vi, không kiểm giá trị"**. Đây là **quyết định phạm vi của QC**, không phải gap chưa xử lý.

### 4D. Câu hỏi MỞ còn lại (không chặn test-plan, cần trước khi viết test case)

5. **[MỞ — Q-3b · TC18-68, TC18-70 ⚠️ · TB-11]** "Tối đa **3 cấp** container" đếm từ đâu — canvas/stack gốc có tính 1 cấp không? *(kế thừa từ 1.2.17, chưa trả lời)*
6. **[MỞ — Q-13 · TC18-51 ⚠️ · TB-12]** Row có **3+ con**: kéo góc 1 phần tử thì phần còn lại bù trừ thế nào — chia đều, chỉ phần tử liền kề, hay phần tử cuối hấp thụ? *(kế thừa từ 1.2.17, chưa trả lời)*
7. **[MỞ — Q-18 · TC18-117 ⚠️ · TB-21]** §10 #6: trên **wallpaper đã lưu**, "đúng" nghĩa là sticker **được** làm mờ bởi card hay **không** được làm mờ? Có cách kiểm nào rẻ hơn việc áp lên lock screen thật không? *(chưa trả lời)*
8. **[MỞ — Q-22 (mới) · TC18-78, TC18-90 – TC18-97, TC18-118, TC18-119 · TB-22]** **Danh mục component chính thức**: dev có thể bàn giao bảng **tên UI ↔ tên code ↔ knob riêng** cho **toàn bộ 16 mục sheet Add + các loại chỉ có trên template sẵn** (Quote, Almanac day, Timeline) không? Hiện 7 loại **không có oracle knob** và ánh xạ tên code (`contributionGrid`, `reminderList`, `timelineCards`) **chỉ là suy luận**. *(không chặn — đã xử lý bằng TC18-118/119 chỉ kiểm vòng đời chung)*

### 4E. Việc QC tự xử lý (không chặn test-plan)

9. **[Q-5 · toàn bộ mục 2 · TB-14]** Trang gốc hiển thị bộ đếm **`0 / 83`**, bản Markdown test basis chỉ có **82** mục tick → đối chiếu lại với `docs/qc-component-editor.md` xem **có mục nào bị khuất**. *Rủi ro coverage: một requirement không được condition nào phủ.* **Chưa làm.**
10. **[Q-19 · TC18-54, TC18-55 + oracle chung · TB-17]** Chụp lại screenshot baseline **trên build 111**: sheet Add **16 mục / 5 nhóm** (ảnh QC gửi 2026-09-28 **chưa hiện số build**), pill có ↑/↓, chip gap âm, đường gióng snap, grabber + ✕. **Chưa làm — không chặn.**
11. **[Q-20 · TC18-108 · TB-20]** iPad ghi "**Nếu có**" — đợt này **có** máy iPad không? Nếu không, TC18-108 ghi nhận là *not run* hay *out of scope*? **Chưa xác nhận.**

---

## 5. Kết luận trạng thái

### 5.0 Trạng thái hiện hành

| Trường | Giá trị |
|---|---|
| **Analysis Status** | **`READY` (có điều kiện)** — chuyển từ `BLOCKED` ngày **2026-09-28** bằng **quyết định của con người**, xem §5.1. **Không phải** kết luận của agent: nếu chỉ xét nội dung tài liệu thì 4 điểm `[CHẶN]` ở mục 4A vẫn chưa được chủ sở hữu requirement (dev) gỡ, và agent sẽ giữ `BLOCKED` (§5.2 lưu nguyên lý do cũ để truy vết). |
| **Downstream Permission** | **`ALLOWED` (có điều kiện)** — `test-plan-1.2.18.md` **được phép chạy**, ràng buộc bởi đúng 3 điều kiện ở §5.1. Vi phạm bất kỳ điều kiện nào (nâng giả định thành fact, bỏ nhãn ⚠️, đưa TC18-99/100 vào phạm vi) ⇒ test-plan **không hợp lệ**. |
| **Điều gì KHÔNG thay đổi** | Q-7, Q-10, Q-12 **vẫn là ASSUMPTION chưa có dev xác nhận** (không phải fact, không phải "đã trả lời"). Q-4 **vẫn là câu hỏi mở / GAP**, chỉ khác là 2 condition liên quan đã được **descope** chính thức. Toàn bộ nhãn ⚠️ và Open Question ở mục 1/2/4 **giữ nguyên, không xoá, không che**. |
| **Mục 2 không bị đụng tới** | Danh sách test condition, risk level và ưu tiên **giữ nguyên 100%** trong lần cập nhật trạng thái này: **118/118** condition trong phạm vi (**P1 41 · P2 58 · P3 19**) + **2 GAP ngoài phạm vi**. |

### 5.1 Quyết định duyệt (human-in-the-loop)

| Trường | Nội dung |
|---|---|
| **Ngày** | **2026-09-28** |
| **Người duyệt** | **QC — người dùng repo**, chủ sở hữu quyết định chuyển trạng thái (không phải agent; agent `qc-test-analysis` chỉ là bên **ghi lại** thay đổi trạng thái này). |
| **Phương án đã chọn (nguyên văn)** | **"A. Cho phép chạy Test Plan ngay (READY có điều kiện)"** |
| **Điều kiện 1 — giả định** | QC **chấp nhận 3 giả định Q-7, Q-10, Q-12 làm cơ sở làm việc**. Chúng **vẫn là ASSUMPTION, chưa được dev xác nhận** → cấm ghi như fact ở bất kỳ tài liệu downstream nào. **Chuyển giả định → fact chỉ khi dev trả lời**: đổi nhãn ở [answers-1.2.18.md](answers-1.2.18.md) trước, rồi mới gỡ ⚠️ tương ứng. Dev trả lời khác ⇒ **dev thắng**, viết lại đúng các dòng ⚠️ đó (không ảnh hưởng các condition còn lại). |
| **Điều kiện 2 — descope** | **TC18-99** (§12 Year progress *"target date"*) và **TC18-100** (§12 Quote *"chữ / số dòng"*) **chính thức ra khỏi phạm vi thực thi** — giữ nhãn `GAP`, test-plan **không** đưa vào, **không** suy diễn expected result. **Q-4 vẫn mở** (QC gửi ảnh/mô tả → dev chốt); khi Q-4 đóng thì mới xét đưa lại vào phạm vi bằng một quyết định mới. |
| **Điều kiện 3 — nhãn** | Test-plan **bắt buộc mang nguyên 18 nhãn ⚠️** (gap-dependent) **kèm điều kiện thay đổi của từng nhãn**, và gắn nhãn **gap-dependent** cho các test object tương ứng. Không được "làm gọn" bằng cách bỏ nhãn. |
| **Điều kiện 4 — ghi nhận** | Agent `qc-test-analysis` là bên **ghi** thay đổi trạng thái kèm ghi chú duyệt này. Không agent nào được tự lặp lại thao tác `BLOCKED → READY` cho slug khác mà không có quyết định tương tự của con người. |

#### 18 condition gắn ⚠️ (gap-dependent) — test-plan BẮT BUỘC mang sang

| Condition | Nguồn giả định / gap | Điều kiện thay đổi |
|---|---|---|
| **TC18-19, TC18-20** | Q-10 (giữ **gap từng vị trí** khi đổi chỗ band) — ASSUMPTION | Dev nói "giữ đỉnh ô/slot" ⇒ viết lại expected result, có thể phải thêm condition cho band cao đổi xuống slot thấp |
| **TC18-23, TC18-24, TC18-106** | Q-8 — còn giả định **"cạnh screen ≡ mép ảnh"** | Dev xác nhận hai biên này khác nhau ⇒ viết lại điều kiện bật cảnh báo *"Part of this runs off the screen"* |
| **TC18-25, TC18-27** | Q-12 (mốc gap = 0 của band đầu = **vạch trên grid**) — ASSUMPTION | Dev nêu mốc khác (mép trên vùng nội dung / mép trên ảnh) ⇒ điểm snap gap 0 đổi chỗ |
| **TC18-80, TC18-82** | Q-7 (khoá hướng cử chỉ **một lần từ đầu**) — ASSUMPTION; **mâu thuẫn §7.07 ↔ §7.08 vẫn nằm nguyên trong test basis** | Dev nêu quy tắc gesture khác ⇒ viết lại expected result |
| **TC18-51** | Q-13 **còn mở** (Row 3+ con bù trừ thế nào) | Chỉ kiểm phần bất biến tới khi dev trả lời |
| **TC18-68, TC18-70** | Q-3b **còn mở** ("tối đa 3 cấp" đếm từ đâu) | Chỉ kiểm bằng cấu trúc lồng thật, không suy diễn mốc đếm cấp |
| **TC18-117** | Q-18 **còn mở** (sticker dưới card frosted: "đúng" là gì) | Chỉ ghi nhận quan sát kèm ảnh, **không** kết luận pass/fail |
| **TC18-61, TC18-115, TC18-116** | Q-11 — requirement **ngoài spec 1.2.18** (nguồn: trao đổi miệng 2026-09-24, QC xác nhận còn đúng) | Dev đưa vào tài liệu bàn giao chính thức ⇒ gỡ ⚠️; dev phủ nhận ⇒ bỏ condition |
| **TC18-118, TC18-119** | TB-22 — **không có oracle knob** cho 7 loại component; ánh xạ tên UI ↔ tên code là suy luận | Dev bàn giao danh mục chính thức (tên UI ↔ tên code ↔ knob riêng) |

#### 2 condition đã descope — test-plan KHÔNG đưa vào phạm vi

| Condition | Mục test basis | Lý do | Điều kiện đưa lại |
|---|---|---|---|
| **TC18-99** | §12 — Year progress *"target date"* | `GAP`: spec ghi rõ **chưa có quyết định**, không có oracle (TB-02 / Q-4) | QC gửi ảnh/mô tả → **dev chốt** → quyết định mới về phạm vi |
| **TC18-100** | §12 — Quote *"chữ / số dòng"* | `GAP`: *"chưa rõ lỗi cụ thể"*, không có acceptance criteria (TB-02 / Q-4) | như trên |

### 5.2 Lý do BLOCKED ban đầu — **giữ nguyên để truy vết** (không xoá, không sửa)

> Đây là phân tích của agent **trước** quyết định duyệt ngày 2026-09-28. Nó vẫn **đúng về mặt kỹ thuật**: các điểm dưới đây **chưa được dev gỡ**. Quyết định duyệt chỉ **cho phép đi tiếp bất chấp** các điểm này, **không** làm chúng biến mất.

| Trường | Giá trị (nguyên trạng trước khi duyệt) |
|---|---|
| **Analysis Status (trước duyệt)** | **`BLOCKED`** *(cập nhật 2026-09-28 — tiến triển lớn so với bản trước, nhưng chưa đủ điều kiện `READY` nếu chỉ xét nội dung tài liệu)* |
| **Lý do BLOCKED** | Mục 4A còn **4 câu hỏi `[CHẶN]`** thuộc đúng nhóm "bắt buộc dừng" của skill `test-analysis`: **(1) Q-7** — mâu thuẫn nội bộ §7.07 ↔ §7.08 **vẫn nằm nguyên trong tài liệu**, chưa ai sửa spec; **(2) Q-10** và **(3) Q-12** — mơ hồ **2 cách hiểu làm đổi expected result**; **(4) Q-4** — §12 **không có acceptance criteria**, chính spec yêu cầu đánh dấu GAP. |
| **Vì sao giả định QC đã chấp nhận vẫn chưa đủ** | (a) Chính [answers-1.2.18.md](answers-1.2.18.md) — **nguồn trả lời duy nhất** — vẫn xếp Q-7, Q-10, Q-12 vào nhóm *"Chưa rõ — giữ nguyên là câu hỏi mở, **chờ dev**"*, loại **CHẶN**, và kết luận *"Còn chặn Test Plan: Q-7, Q-10, Q-12, Q-4"*. Tài liệu này **không được nói ngược lại nguồn**. (b) Bốn giả định do Claude đề xuất, QC **chấp nhận làm giả định làm việc**, **chưa phải xác nhận của chủ sở hữu requirement (dev)** — `.claude/rules/testing.md`: *"không bao giờ biến assumption thành fact"*, *"không tự ý giải quyết điểm mơ hồ mà không có xác nhận"*. (c) Q-4 vẫn thiếu bằng chứng từ QC **và** quyết định của dev. |
| **Downstream Permission (trước duyệt)** | **`BLOCKED`** — chưa được phép chạy `test-plan` cho slug `1.2.18`. Theo `.claude/rules/testing.md`, chỉ `TEST ANALYSIS = READY` mới được đi tiếp. *(**Đã thay thế bởi §5.0: `ALLOWED` có điều kiện**, do người review chuyển trạng thái sang `READY` có điều kiện ngày 2026-09-28.)* |
| **Đã hết chặn (khác bản trước)** | Q-1, Q-2, Q-6a/6b, Q-8 *(phần chính)*, Q-9a/9b, Q-11, Q-17 **đã có trả lời của QC**; **Q-21 đã đóng** (16 mục / 5 nhóm). **0 condition còn TBD** — 4 dòng TBD cũ đã gán risk, 2 dòng chuyển thành **GAP ngoài phạm vi**. |
| **Điều kiện để chuyển sang READY (nêu trước khi duyệt)** | (1) **Dev xác nhận (hoặc sửa) 3 giả định**: Q-7 (khoá hướng cử chỉ), Q-10 (giữ gap từng vị trí), Q-12 (mốc gap 0 = vạch trên grid) → cập nhật 6 condition ⚠️: TC18-80, TC18-82, TC18-19, TC18-20, TC18-25, TC18-27. (2) **Q-4**: QC gửi ảnh/mô tả → dev chốt → bỏ GAP cho TC18-99/TC18-100; **hoặc** người review **chính thức chấp nhận descope** hai dòng này khỏi đợt test. (3) **Người review (QC/test lead) xác nhận chuyển trạng thái** — agent **không** tự chuyển `BLOCKED → READY`. |
| **Điều kiện nào đã được đáp ứng ngày 2026-09-28** | ✅ **(2) qua nhánh descope** — người review chính thức chấp nhận descope TC18-99/TC18-100. ✅ **(3)** — người review (QC) xác nhận chuyển trạng thái (phương án A). ❌ **(1) CHƯA đáp ứng** — dev **vẫn chưa xác nhận** Q-7/Q-10/Q-12; người review chọn đi tiếp trên **giả định** thay vì chờ dev. Đây chính là lý do trạng thái mới là **`READY` có điều kiện**, không phải `READY` trọn vẹn. |
| **Nếu người review vẫn muốn chạy test-plan ngay** *(nhánh đã được chọn — xem §5.1)* | Đây là **quyết định của con người**, không phải của agent, và phải ghi rõ trong test-plan: mọi condition **⚠️ (18 dòng)** giữ nhãn **gap-dependent** + điều kiện thay đổi; **TC18-99/TC18-100 ngoài phạm vi**; nếu dev trả lời khác thì **chỉ** các dòng ⚠️ tương ứng phải viết lại (không ảnh hưởng 100 condition còn lại). |
| **Không bị ảnh hưởng** | **118/118** condition trong phạm vi đã có risk level và ưu tiên đầy đủ (**P1 41 · P2 58 · P3 19**); phần lớn nhóm ⚪ tái sử dụng nguyên từ bộ 1.2.17 sau khi đổi mã trace. |

> **Lưu ý cho người review:** bộ test 1.2.17 (`test-analysis-component-editor-SUPERSEDED.md`, `test-plan-component-editor-SUPERSEDED.md`, `test-cases-component-editor-SUPERSEDED.md`) **giữ nguyên, không sửa** — dùng để truy vết. Các mục **TC-14 · TC-29 · TC-66 · TC-67** của bộ đó **đã sai theo 1.2.18** và đã được thay bằng TC18-22/23/24 · TC18-54/55 · TC18-47 · **TC18-36a + TC18-36b** ở tài liệu này (xem mục 3B).
>
> **Lưu ý thứ hai:** mọi expected result mang nhãn **(QC)** trong mục 2 đến từ [answers-1.2.18.md](answers-1.2.18.md) ngày 2026-09-28 — **câu trả lời của QC, chưa có dev xác nhận**. Nếu dev trả lời khác thì **dev thắng** và phải sửa đúng các dòng mang nhãn đó; khi dev xác nhận, đổi nhãn ASSUMPTION → FACT ở answers file **trước**, rồi mới gỡ ⚠️ ở tài liệu này.
>
> **Lưu ý thứ ba (về `READY` có điều kiện):** trạng thái `READY` ở §5.0 **không** có nghĩa là test basis đã hết mơ hồ. Mâu thuẫn **§7.07 ↔ §7.08** vẫn nằm nguyên trong spec 1.2.18; mốc gap 0 (§4.06) và quy tắc "giữ khoảng cách" (§3.08) vẫn chưa được dev định nghĩa; §12 vẫn không có acceptance criteria. Khi dev trả lời, **quay lại tài liệu này trước** (cập nhật mục 1, 4A và §5.1), rồi mới lan xuống test-plan/test-case theo đúng chuỗi traceability của [`.claude/rules/testing.md`](../../../../.claude/rules/testing.md).
