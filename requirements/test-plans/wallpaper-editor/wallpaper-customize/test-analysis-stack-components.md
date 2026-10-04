# Test Analysis — Component lịch mới & knob mới (stack) · slug `stack-components`

> ✅ **READY — CÓ ĐIỀU KIỆN** *(do **con người duyệt**, không phải agent tự kết luận)*
> **Duyệt bởi:** user / chủ repo · **Ngày:** **2026-10-03** (**đợt trả lời thứ 3**) · **Phương án đã chọn:** **O-33 = *"SC-36 và SC-62 → Exploratory 🔭, gỡ nhãn ⛔"*** · **O-31 = *"SC-82 (migration ngược) = EX-4, Exploratory, không viết script cố định"*** · **Hồ sơ câu trả lời:** mục **6**, phần *"Đợt trả lời thứ 3"*.
>
> **Việc chuyển `DRAFT → READY` là TUYÊN BỐ CỦA USER**, kèm xác nhận **chấp nhận đủ 4 điều kiện** ở mục **5.2**. Agent **không** tự nâng trạng thái và **không** coi đây là bằng chứng kỹ thuật từ dev.
>
> ### Bốn điều kiện bắt buộc — `test-plan` PHẢI mang theo, không được bỏ bớt
>
> 1. **Nhóm M · N · O · P (14 condition: SC-76 … SC-88) KHÔNG có requirement trong test basis.** Oracle là [`component-editor.md`](../../../specs/wallpaper-editor/wallpaper-customize/component-editor.md) (**tài liệu đối chiếu**) + **quyết định phạm vi của user**. Phải ghi rõ trong phần scope — **không** trình bày như requirement của `stack-components.md`. *(Tiền lệ: nhóm R/S của bộ [`tf-117`](test-analysis-tf-117.md).)*
> 2. **7 vùng Exploratory (EX-1 … EX-7) KHÔNG có expected result ⇒ KHÔNG chứng minh được pass.** Báo cáo kết quả **bắt buộc tách bạch** "scripted" và "exploratory"; **cấm** gộp thành một con số độ phủ duy nhất.
> 3. **Privacy chỉ kiểm ở mức UI người nhận** (Q-3 + O-29). Mức **payload / network** là **`SC-G8` — CHƯA TEST**. **Cấm** phát biểu "privacy đã test đầy đủ"; phát biểu đúng: *"đã kiểm ở mức hiển thị UI phía người nhận; mức payload/network chưa nằm trong phạm vi đợt này."*
> 4. **Q-1, Q-2, Q-3 và 8 quyết định của 2 đợt sau đều là quyết định của USER — dev CHƯA xác nhận.** Không nâng thành fact. Riêng **SC-23** phải mang nguyên ô ghi chú *"thấy kế hoạch tập bị xoá ⇒ report BUG"*.
>
> ⚠️ **Ba câu hỏi mở được mang sang `test-plan` dưới dạng nhãn ⚠️** (user chấp nhận, không chặn): **O-23** *(chưa có baseline ảnh render thật cho bất kỳ component mới nào)* · **O-30** *(component mới nào được hỗ trợ ở Live Activity / widget / thumbnail — SC-77/SC-78 chưa phân loại được pass/fail)* · **O-32** *(ngưỡng hiệu năng định lượng + tập máy tối thiểu cho SC-83/SC-84)*. Cộng các câu hỏi "giảm độ chính xác" ở mục 4B — **không câu nào bị coi là đã đóng**.
>
> 🚩 **Một điểm QC đã báo và vẫn giữ nguyên trong hồ sơ:** căn cứ user viện dẫn cho quyết định O-24/O-25 được mô tả là "câu mở đầu của chính `stack-components.md`", nhưng **QC kiểm chứng thì câu đó nằm ở `component-editor.md` (tài liệu đối chiếu), không có trong test basis**. Quyết định phạm vi của user **vẫn được áp dụng**; hệ quả đã được gói vào **điều kiện số 1** ở trên — chi tiết ở **mục 4A-2**.
>
> ### 🔄 Cập nhật 2026-10-02 — đợt trả lời của **user (chủ repo)**, không phải kết luận của agent
>
> Ba Blocking Question **Q-1 · Q-2 · Q-3** đã được **user quyết định** qua `AskUserQuestion`. Hồ sơ nguyên văn + hệ quả: **mục 4A** (chi tiết từng câu) và **mục 6** (bảng tổng hợp). Tóm tắt:
>
> | | Quyết định của user (2026-10-02) | Hệ quả |
> |---|---|---|
> | **Q-1** | **A** — `Month heatmap` là **component độc lập thứ 7** (nhóm Calendar), **tách biệt** với knob `Style` (Bars/Dots/Heat map) của Week events — knob này **giữ nguyên** đúng như §8.01 mô tả | Hết chặn SC-02, SC-46, SC-48, SC-49. **Thêm** SC-74, SC-75. Hành vi **chi tiết** của Month heatmap vẫn là **`GAP`** (SC-G1) — cần dev bổ sung mô tả |
> | **Q-2** | Theo **đúng câu chữ test basis** — Reset của Workout **GIỮ NGUYÊN** kế hoạch tập | Hết chặn SC-23; expected result viết theo §4.05. **Nếu thực thi thấy kế hoạch tập bị xoá → report BUG ngay**, không phải lỗi thiết kế case |
> | **Q-3** | **Giảm phạm vi có chủ đích** — chỉ kiểm **mức UI của người nhận**; **KHÔNG** kiểm payload/network | Hết chặn SC-71, SC-72 (thu hẹp còn UI-level). **Thêm SC-G8**: audit riêng tư mức payload = **phạm vi CHƯA TEST**, không được hiểu là "đã test đầy đủ privacy" |
>
> ### 🔄 Cập nhật 2026-10-02 — **đợt trả lời thứ 2** của user (6 câu hỏi mở)
>
> | | Quyết định của user | Hệ quả |
> |---|---|---|
> | **O-1** | Scripted bám **đúng checklist**; chi tiết sâu hơn → **Exploratory** | 🔭 **EX-1** |
> | **O-7** | **SC-12 → Exploratory** (thiếu dữ kiện ≠ ambiguity) | 🔭 **EX-2**, gỡ nhãn chặn |
> | **O-27** | **`Month heatmap` → Exploratory**, cùng lý do O-7 | 🔭 **EX-3**, đóng `GAP` SC-G1 |
> | **O-24** | Regression · migration · hiệu năng **CÓ** trong phạm vi | **+10 condition** (nhóm M, N, O) |
> | **O-25** | Component mới lồng **Row/Column** **CÓ** trong phạm vi | **+4 condition** (nhóm P) |
> | **O-29** | Workout plan **CÓ** ẩn khi share | **+1 condition** (SC-89), đóng `GAP` SC-G5 |
>
> ### 🔄 Cập nhật **2026-10-03** — **đợt trả lời thứ 3** của user (2 câu cuối + tuyên bố trạng thái)
>
> | | Quyết định của user | Hệ quả |
> |---|---|---|
> | **O-33** | **SC-36** (xoá trắng tên milestone đã tồn tại) và **SC-62** (paste/dictation vào ô emoji) → **Exploratory**, gỡ nhãn ⛔ | 🔭 **EX-6**, **EX-7** · **không còn dòng ⛔ nào** |
> | **O-31** | **SC-82** (migration ngược) = **EX-4**, Exploratory, **không** viết script cố định | 🔭 **EX-4 đã xác nhận** (trước đó là đề xuất của QC) |
> | **Trạng thái** | Chấp nhận **đủ 4 điều kiện** ở mục 5.2 → **tuyên bố `READY — có điều kiện`** | `DRAFT → READY`; O-23/O-30/O-32 mang sang test-plan dưới nhãn ⚠️ |
>
> **Số liệu cuối: 71 → 73 → 87 test condition** (P1 **44** · P2 **24** · P3 **19** · chưa rate được **0**) · `GAP` **2** · **Exploratory 🔭 7** · **dòng ⛔ 0**.
>
> **Analysis Status: `READY` (có điều kiện)** · **Downstream Permission: `ALLOWED` (có điều kiện)** — **được phép chạy `test-plan`** cho slug `stack-components` theo [`.claude/rules/testing.md`](../../../../.claude/rules/testing.md), **với đúng 4 điều kiện ở trên**.
>
> **Agent KHÔNG tự chọn cách hiểu nào** cho Q-1/Q-2/Q-3 lẫn O-1/O-7/O-24/O-25/O-27/O-29/O-31/O-33, và **không** tự chuyển trạng thái; mọi quyết định ở trên là **của user**, **dev chưa xác nhận**. Agent cũng **không** tự gán expected result cho 7 vùng Exploratory — theo định nghĩa chúng **không có** expected result.

> **Test basis (duy nhất):** [stack-components.md](../../../specs/wallpaper-editor/wallpaper-customize/stack-components.md) — toàn bộ §1–§12.
>
> **Tài liệu đối chiếu — KHÔNG phải test basis** (chỉ dùng để phát hiện mâu thuẫn/thiếu sót, không được dùng làm requirement của đợt này):
> - [component-editor.md](../../../specs/wallpaper-editor/wallpaper-customize/component-editor.md) — thao tác chung của bảng chỉnh; chính test basis trỏ sang đây cho "chọn, kéo, Undo, Card…".
> - [test-analysis-tf-117.md](test-analysis-tf-117.md) · [test-plan-tf-117.md](test-plan-tf-117.md) — bộ test **đã READY (có điều kiện)** cho màn Customize **trước** đợt component mới này. Dùng lại **method** và **bối cảnh nền**, **không** dùng lại kết luận.
> - [template-sharing-api.md](../../../specs/share-template-link/template-sharing-api.md) — hợp đồng API share template của **cùng build 1.2.19**; liên quan trực tiếp tới §11.
> - [screenshots iPhone · index.md](../../../ui/ux/screenshots/iphone/index.md) mục `04_customize` (batch 8) + 3 ảnh `add-component-v2 / -scrolled-v2 / -scrolled-v3`. **Bằng chứng quan sát, không phải requirement.**
>
> **Chuẩn:** ISTQB Foundation Level v4.0.1 [§1.4.1](../../../istqb-foundation/ISTQB_CTFL_Syllabus_v4.0.1.md) (Test Analysis) + §3 (Static Testing) + §5.2 (Risk Management) + §4.5.2 (Acceptance Criteria).
> **Bước tiếp theo:** `test-plan` sẽ dùng mục 2 làm test object và cột **Risk level** làm cơ sở risk-based prioritization — **chỉ sau khi** Q-1, Q-2, Q-3 ở mục 4A được người có thẩm quyền trả lời.
> **Ngày lập:** 2026-10-02 · **Người lập:** QC (agent `qc-test-analysis`)
>
> **Mã traceability:** `stack-components.md` là checklist **không có mã mục**. Mã `§N.MM` dưới đây **do QC gán** theo thứ tự ô tick trong từng mục (vd `§8.02` = ô tick thứ 2 của §8), kèm trích đoạn ngắn để tránh nhầm. Quy ước riêng của tài liệu này, **không có** trong test basis.

---

## 1. Đánh giá testability của test basis

> "Defect trong chính tài liệu" (ISTQB §3 — ambiguity / incompleteness / inconsistency), **không phải** defect của app.
> Cột **Mức**: `CHẶN` = không viết được test condition hoặc expected result nếu chưa có trả lời (thuộc mục 0 của skill) · `MỞ` = viết được nhưng giảm độ chính xác (thường là thiếu giá trị biên / thiếu oracle định lượng / thiếu phương tiện đo).

### 1A · Vấn đề **từng** ở mức CHẶN — đã được **user quyết định** 2026-10-02

> ⚠️ **Nguyên văn vấn đề dưới đây KHÔNG bị xoá và KHÔNG được coi là "đã hết".** Quyết định của user là quyết định **phạm vi / cách diễn giải**, không phải bằng chứng kỹ thuật từ dev: câu chữ của test basis vẫn mâu thuẫn/thiếu y như cũ. Giữ lại để truy vết, và để `test-case` biết vì sao một số expected result **ngược với suy luận gián tiếp** từ tài liệu đối chiếu.

| # | Trích đoạn / mục trong test basis | Vấn đề | Loại | Mức | Cần hỏi ai | Ảnh hưởng |
|---|---|---|---|---|---|---|
| **TB-01** | **§8.01** "**Week events → Style**: Bars / Dots / **Heat map**. … Heat map: ô đậm theo số sự kiện, ngày bận nhất có **ngọn lửa**" ↔ bằng chứng ảnh [`add-component-v2.png`](../../../ui/ux/screenshots/iphone/14_edit-wallpaper/14_edit-wallpaper_04_customize_add-component-v2.png) | Test basis mô tả **Heat map là một GIÁ TRỊ** của knob `Style` trên component **Week events** (phạm vi **tuần**). Ảnh build 1.2.19 (QC đã tự đối chiếu trực tiếp, không chỉ đọc `index.md`) cho thấy trong nhóm **CALENDAR** của sheet Add component có một **component độc lập** tên **"Month heatmap"**, mô tả *"The month, each day shaded by how busy it is."* (phạm vi **tháng**) — và nhóm **EVENTS** vẫn còn **"Activity grid"** *("How busy each day has been.")*. Tức build có tới **ba** cách hiển thị độ bận, test basis chỉ nói về **một**. **Cách hiểu A:** đây là **hai tính năng khác nhau** (Heat map = style tuần của Week events; Month heatmap = component tháng mới) → đợt này thực tế có **7** component mới, trong đó **Month heatmap KHÔNG có một dòng acceptance criteria nào** trong test basis (và cũng không nằm trong §12 "chưa làm"), nên không biết nên test gì và icon rỗng của nó trong ảnh là bug hay UI chưa xong. **Cách hiểu B:** §8.01 **ghi nhầm chỗ** — thứ thực sự ship là component `Month heatmap`, Week events **không** có giá trị `Heat map` → khi chạy mà chỉ thấy `Bars / Dots` thì đó là **đúng**, không phải bug; và các condition `Heat map` phải **xoá khỏi phạm vi**. Hai cách hiểu cho **hai tập test condition khác hẳn và hai expected result trái ngược** trên cùng một ô tick. | Mâu thuẫn giữa test basis và build + mơ hồ (2 cách hiểu) | ~~CHẶN~~ → **ĐÃ QUYẾT ĐỊNH (user, 2026-10-02): Q-1 = A** — hai tính năng **khác nhau**. Phần "hành vi chi tiết của `Month heatmap`" **vẫn là `GAP`** | Dev (bổ sung spec cho `Month heatmap`) | SC-02, SC-46, SC-47, SC-48, SC-49 (**hết chặn**) · SC-74, SC-75 (**mới**) · SC-G1 (**vẫn `GAP`**) |
| **TB-02** | **§4.05** "Bấm **Reset** của thành phần → kế hoạch tập **vẫn còn**." | Bảng chỉnh **không có một nút Reset duy nhất** — theo tài liệu đối chiếu [component-editor.md](../../../specs/wallpaper-editor/wallpaper-customize/component-editor.md) §7 có Reset **theo từng nhóm** ("Position không có Reset… chỉnh rồi Reset → về đúng như lúc thêm"; **"Reset của Content trả lại đúng các câu gốc"** cho Quote). Với Quote, **Content → Reset CÓ xoá nội dung người dùng tự nhập**. Vậy với Workout: **Cách hiểu A:** "Reset của thành phần" = **mọi** Reset, kể cả Content → kế hoạch tập luôn sống sót; nếu Content → Reset xoá kế hoạch thì **report bug mất dữ liệu**. **Cách hiểu B:** chỉ Reset ở nhóm **Position/Text** mới được bảo đảm; Content → Reset xoá kế hoạch là **đúng thiết kế** (nhất quán với Quote) → **không** report. Hai expected result **trái ngược** trên đúng một đường dẫn tới **mất dữ liệu người dùng tự nhập**, nên không thể chọn hộ. Cách hiểu "bảo thủ" (A) **không an toàn** vì tài liệu đối chiếu chứng minh Content → Reset vốn có quyền xoá nội dung. | Mơ hồ (2 cách hiểu) trên đường dẫn mất dữ liệu | ~~CHẶN~~ → **ĐÃ QUYẾT ĐỊNH (user, 2026-10-02): Q-2 = theo đúng câu chữ §4.05** — Reset **giữ nguyên** kế hoạch tập. Căn cứ: `stack-components.md` là **test basis trực tiếp**, mạnh hơn suy luận gián tiếp từ `component-editor.md`. **Dev vẫn CHƯA xác nhận** | Dev | SC-23 (**hết chặn**, expected result = kế hoạch **còn**; thấy bị xoá ⇒ **report BUG**) |
| **TB-03** | **§11.01** "Share template có **Milestones** → người nhận **không** thấy ngày riêng (tên, ngày) của người gửi; có **Event tickets** → không thấy sự kiện đã ghim." ↔ [template-sharing-api.md](../../../specs/share-template-link/template-sharing-api.md) (**cùng build 1.2.19**) "**Strip device state first: selected calendars, note id, album id, rotation clock.**" | (a) **Cơ chế không xác định — hai cách hiểu cho hai tập test condition khác hẳn:** **A** = dữ liệu bị **lược bỏ khỏi payload lúc publish** → test condition là kiểm **nội dung payload / link** (dữ liệu không tồn tại ở phía nhận, kể cả khi dựng lại bằng tay); **B** = dữ liệu **vẫn đi theo** nhưng **ẩn lúc render** ở máy người nhận → test condition là kiểm **UI phía nhận**, và payload vẫn chứa dữ liệu cá nhân (**vẫn là rò rỉ**, chỉ là không nhìn thấy trên UI). Mức nghiêm trọng của defect khác hẳn nhau giữa hai cách. (b) **Mâu thuẫn với tài liệu đã bàn giao:** danh sách strip của hợp đồng API cùng build **không** có milestone days lẫn pinned events — không rõ API spec cũ/thiếu hay §11 mới chỉ là ý định chưa thực thi. (c) **Thiếu oracle phía nhận:** người nhận thấy **gì** thay cho dữ liệu đã bỏ (component rỗng? placeholder? dữ liệu mẫu? component biến mất?) — không có câu nào định nghĩa. Đây là đường dẫn **rò rỉ dữ liệu cá nhân**, không được suy diễn. | Mơ hồ (2 cách hiểu) + mâu thuẫn liên tài liệu + thiếu oracle | ~~CHẶN~~ → **ĐÃ GIẢM PHẠM VI CÓ CHỦ ĐÍCH (user, 2026-10-02): Q-3 = chỉ kiểm mức UI người nhận**. Ý (b) *(API spec có thiếu không)* và ý (d) *(Workout plan)* **chưa được trả lời** → vẫn mở | Dev (owner share template) + owner bộ test [share-template-link](../../share-template-link/) | SC-71, SC-72 (**hết chặn**, thu hẹp còn UI-level) · SC-G5 (**vẫn `GAP`**) · SC-G8 (**mới** — mức payload **CHƯA TEST**) |

### 1B · Vấn đề mức MỞ

| # | Trích đoạn / mục trong test basis | Vấn đề | Loại | Mức | Cần hỏi ai | Ảnh hưởng |
|---|---|---|---|---|---|---|
| TB-04 | Header: "spec từng component ở [docs/components/](../components/new-components.md)" | **Liên kết hỏng** — đường dẫn `requirements/specs/wallpaper-editor/components/new-components.md` **không tồn tại** trong repo (đã kiểm bằng glob toàn bộ `requirements/specs/**`). Test basis **tự khai** rằng spec chi tiết của từng component nằm ở tài liệu khác, nghĩa là chính tác giả coi 4–9 ô tick/component ở đây là **chưa đủ**. Hệ quả: với 6 component **hoàn toàn mới**, oracle duy nhất khả dụng là checklist này — đủ để quan sát "có/không", **không** đủ để chốt pass/fail cho giá trị, biên, thuật toán (xem TB-05 … TB-12 bên dưới, phần lớn là hệ quả trực tiếp của việc thiếu tài liệu này). | Thiếu (tài liệu tham chiếu không tồn tại) | MỞ **(rất cao)** — nếu `docs/components/` mới là acceptance criteria thật thì **phải** có trước `test-case` | Người bàn giao | Toàn bộ nhóm B–G |
| TB-05 | Header + §1 | **Không có định danh build/version/ticket**, không có bảng máy & phiên bản iOS (TF-117 §1 từng có bảng này), không có mục "điểm mới so với bản trước". Bằng chứng ảnh duy nhất được gán nhãn "TestFlight 1.2.19" là **do QC tự ghi trong `index.md`, chưa xác nhận bằng công cụ**. → Không viết được entry criteria, không gắn được bug vào build, và các condition phụ thuộc nền tảng (DST §6.03, lịch Phật giáo §7.09, bàn phím emoji §9.05) **không biết chạy trên iOS nào**. | Thiếu (định danh + môi trường) | MỞ (cao — ảnh hưởng entry criteria của test-plan) | Dev / người bàn giao | SC-01 … SC-74 (toàn bộ, qua môi trường) |
| TB-06 | **§1.03** "Test cả **tiếng Việt** và một ngôn ngữ khác (Đức hoặc Nhật), cả **Light và Dark**." | "Light và Dark" có **2 cách hiểu**: **A** = knob **Color tone** Light/Dark của Global style trong Customize (tồn tại theo [component-editor.md](../../../specs/wallpaper-editor/wallpaper-customize/component-editor.md) §7) · **B** = chế độ sáng/tối của **hệ điều hành**. Bằng chứng gián tiếp ủng hộ **A**: §12.01 dùng đúng cụm *"**Color tone** Light/Dark **trong Customize**"*. **Đây chỉ là bằng chứng gián tiếp, không phải khẳng định — không tự chốt.** Ảnh hưởng: nhân đôi/không nhân đôi **ma trận môi trường** của mọi condition ở mục 2 (chi phí thực thi), chứ không đổi *tập* condition → xếp MỞ. | Mơ hồ (2 cách hiểu) — ảnh hưởng ma trận môi trường, không ảnh hưởng tập condition | MỞ | Người bàn giao | Ma trận môi trường của toàn bộ mục 2 |
| TB-07 | **§1 / §2 … §10** — tên knob | Mọi tên knob đều ghi **tiếng Anh** (Days, Events per day, Show title, Date range, Ticket style, Color scheme, Cover, Location, Weekly plan, Fade past days, Decorative icons, Lunar date, Add a day, Every year, Card palette, Card pattern, Birthdays & holidays, Each box, Box pattern, Strike out the Drop box, Days shown, Day header…), trong khi §1.03 **bắt buộc test bằng tiếng Việt**. Chỉ **2/22+** knob có bản VI đối chiếu (§10.01 Backdrop → "Nền", §10.04 Weekly plan → "Kế hoạch tuần"). Tester chạy máy tiếng Việt **không ánh xạ được** phần lớn knob → phải tự đoán, nguy cơ test nhầm control. | Thiếu (bảng đối chiếu chuỗi VI) | MỞ (cao — ảnh hưởng khả năng thực thi) | Localization / dev | Mọi condition có thao tác knob |
| TB-08 | **§2.02** "**Days** 1 và 14; **Events per day** 1 → ngày nhiều hơn hiện dòng **+N more**" | Chỉ cho **2 điểm mẫu** của `Days`, **không** nêu min/max/bước nhảy của thanh → không biết 14 có phải trần hay không, không thiết kế được BVA (không biết điểm ngay ngoài biên). `Events per day` cũng chỉ có 1 điểm mẫu, không nêu trần. | Thiếu (giá trị biên) | MỞ | Dev | SC-06, SC-07 |
| TB-09 | **§2.03** "**Hết chỗ dọc** → bỏ ngày **xa nhất** trước, không cắt nửa ngày" | "Hết chỗ dọc" **không có điều kiện kích hoạt**: phụ thuộc chiều cao band (thanh Size/Width), số sự kiện, hay chiều cao wallpaper? Tester phải tự dựng tình huống tràn bằng cách mò → tái lập không ổn định, khó chốt fail. | Thiếu (điều kiện kích hoạt) | MỞ | Dev | SC-08 |
| TB-10 | **§3.01** "Chưa ghim gì → hiện sự kiện sắp tới; **ghim (từ lịch)** → chỉ hiện sự kiện đã ghim" | Hành động **"ghim"** nằm **ngoài** màn Customize và **không được mô tả ở đâu**: không có vị trí UI, không có số lượng ghim tối đa, không có hành vi khi sự kiện đã ghim **trôi qua / bị xoá / bị sửa giờ**. Cũng không nêu **bao nhiêu** "sự kiện sắp tới" hiện khi chưa ghim. → Viết được condition nhưng **chưa chạy được** (không biết đường vào) — cùng loại với Q-7b của bộ `tf-117`. | Thiếu (đường vào + oracle số lượng) | MỞ (cao — **phải** trả lời trước khi `test-case` chạm SC-12) | Dev | SC-11, SC-12 |
| TB-11 | **§3.02** "…vé đổi kiểu, **chữ luôn đọc được**" · **§3.04** "chữ **không tràn** ra ngoài vé" | "Đọc được" không có **ngưỡng tương phản** (vd WCAG contrast ratio) và không có ảnh nền mẫu → không có oracle khách quan cho một hành vi tự động (4 Ticket style × N Color scheme × ảnh nền bất kỳ). Kiểm được "chữ không trùng hẳn màu nền"; không chốt được pass/fail chặt. Cùng họ với TB-18 của bộ `tf-117`. | Không kiểm được (thiếu oracle định lượng) | MỞ | Dev / design | SC-14, SC-16 |
| TB-12 | **§5.01** "ngày **rảnh** → hiện một câu trích dẫn" | Không định nghĩa **"ngày rảnh"**: 0 sự kiện có giờ? sự kiện cả ngày có tính không? nhắc việc (Reminders) có tính không? Và **nguồn câu trích dẫn** là gì (cùng kho với component Quote? có dịch không? có xoay vòng không?). Không có oracle cho cả điều kiện lẫn nội dung. | Thiếu (định nghĩa + nguồn dữ liệu) | MỞ | Dev | SC-25 |
| TB-13 | **§5.03** "**Lunar date**: máy vùng **VN/CN/…** mặc định bật, vùng khác mặc định tắt" | Danh sách vùng **bỏ lửng bằng "…"** → không biết KR/TW/HK/SG/JP có nằm trong tập bật hay không, nên **không kiểm được biên** (chỉ kiểm được VN = bật và một vùng chắc chắn ngoài tập, vd US). Thêm nữa, "máy vùng" là **Region**, **Language**, hay **calendar identifier**? — ba thiết lập khác nhau, cho ba cách dựng môi trường khác nhau. | Thiếu (danh sách) + mơ hồ (thiết lập nào) | MỞ | Dev | SC-27 |
| TB-14 | **§6.03** "Ngày đổi giờ mùa hè (nếu máy ở vùng có DST): thanh giờ không lệch một tiếng" | Không nêu **cách dựng**: đổi giờ hệ thống thường làm hỏng dữ liệu lịch và không tái lập được trên TestFlight; không nêu vùng/ngày DST mẫu. Hành vi thì quan sát được, **phương tiện** để tới được tình huống thì không có. | Không kiểm được (thiếu phương tiện) | MỞ | Dev | SC-32 |
| TB-15 | **§6.01** "…**giờ rảnh** — mỗi phần tắt được riêng" | "Giờ rảnh" là một **giá trị tính toán** nhưng không có thuật toán: tính trong khoảng giờ nào (cả ngày? giờ làm việc?), sự kiện cả ngày có chiếm chỗ không, khoảng trống nhỏ bao nhiêu thì bị bỏ qua. Kiểm được "có hiển thị"; **không** kiểm được "hiển thị **đúng**". | Thiếu (thuật toán/oracle) | MỞ | Dev | SC-33 |
| TB-16 | **§7.01** "đóng mà **chưa đặt tên** → ngày đó tự biến mất" ↔ **§7.02** "chưa tên thì **'New day' (mới) / 'Untitled' (cũ)**" | Quy tắc tự-xoá được phát biểu **chỉ cho luồng Add a day** (ngày **mới**). Trường hợp **xoá trắng tên của một ngày đã tồn tại rồi đóng sheet** **không được định nghĩa ở đâu** — mà chính sự tồn tại của nhãn *"Untitled" (cũ)* cho thấy trạng thái "ngày cũ không tên" **là có thật**. Đây là **trường hợp thiếu**, không phải mâu thuẫn → **không được tự suy ra** expected result (giữ lại hay xoá) vì cả hai đều dẫn tới hành vi dữ liệu khác nhau. | Thiếu (trường hợp chưa định nghĩa) | MỞ (cao — đường dẫn xoá dữ liệu) | Dev | SC-36 (giữ nhãn `GAP`) |
| TB-17 | **§7.06** "**Card palette** khác Plain → các thẻ tô **xoay vòng màu**; thẻ **hôm nay** luôn màu nhấn và thẻ **ngay sau nó** lấy **màu đầu** của bảng" | Quy tắc chỉ định nghĩa điểm bắt đầu xoay vòng **khi có thẻ "hôm nay"**. Không nêu: danh sách **không có** mốc nào rơi đúng hôm nay thì xoay vòng bắt đầu từ đâu; thẻ hôm nay là thẻ **cuối** thì "thẻ ngay sau" là gì; số màu trong bảng ít hơn số thẻ thì lặp thế nào. | Thiếu (biên/điểm khởi đầu) | MỞ | Dev / design | SC-41 |
| TB-18 | **§8.02** "Thanh chuyển **cam từ 75%**, **đỏ từ 90%** … **Chọn Custom → tự điền hôm nay và +90 ngày**" | (a) Ngưỡng 75/90 rõ, BVA được — tốt. (b) **Không** nêu hành vi khi người dùng đặt **khoảng không hợp lệ** (ngày kết thúc ≤ ngày bắt đầu, hoặc khoảng 1 ngày) → không có expected result cho nhánh âm. (c) "+90 ngày" không rõ **tính cả hay không tính** ngày hôm nay (lệch 1 ngày). | Thiếu (nhánh âm + biên ±1) | MỞ | Dev | SC-50, SC-52, SC-G3 |
| TB-19 | **§8.01** "**Heat map**: ô **đậm theo số sự kiện**" | Không có **thang ánh xạ** số sự kiện → độ đậm (mấy mức? trần ở mấy sự kiện? 0 sự kiện là màu gì?). Kiểm được "ngày nhiều hơn thì đậm hơn"; **không** chốt được từng mức. *(Toàn bộ dòng này còn phụ thuộc kết quả **TB-01**.)* | Thiếu (thang định lượng) | MỞ | Dev | SC-48 |
| TB-20 | **§8.01** "Knob của thanh (**Block opacity**, **+N more**) chỉ hiện ở Bars" ↔ [component-editor.md](../../../specs/wallpaper-editor/wallpaper-customize/component-editor.md) §7 "**Week events**: **Show +N**… **Fill opacity** nằm trong More options" | **Tên control lệch nhau giữa hai tài liệu cùng bộ**: `Block opacity` ↔ `Fill opacity`; `+N more` ↔ `Show +N`. Tester không phân biệt được "control bị đổi tên" với "control bị thiếu / control lạ" → ảnh hưởng cả §10.02 ("không component nào có hai dòng trùng tên"). Thêm: component-editor.md xếp `Show +N` **trong More options**, §8.01 lại nói tới nó như knob hiện cùng nhóm thanh. | Không nhất quán (định danh control) | MỞ | Dev | SC-49, SC-64 |
| TB-21 | **§9.05** "Máy đã **tắt bàn phím Emoji** trong Cài đặt → hiện bàn phím thường, **vẫn chỉ nhận emoji**" | Ghép với §9.02 ("chạm → mở thẳng trang emoji") và §9.04 ("gõ chữ → không nhận"), tình huống này là **ngõ cụt nhập liệu**: người dùng không có cách nào nhập được gì. Test basis **không nói** nên hiện gì (gợi ý? thông báo? nút mở Cài đặt?) → kiểm được "không nhận chữ", **không** kiểm được trải nghiệm là đúng hay sai. Cũng **không nêu** đường vào khác (dán/paste, đọc chính tả) có được chấp nhận không. Thuộc nhóm **usability — operability** (ISO 25010). | Thiếu (oracle trải nghiệm + nhánh paste) | MỞ | Dev / design | SC-61, SC-62 |
| TB-22 | **§9.03** "ô hiện **emoji mặc định mờ**" | Không nêu **emoji mặc định là ký tự nào** cho Milestones và cho Workout (có thể khác nhau) → không có oracle chính xác, chỉ kiểm được "có placeholder mờ". | Thiếu (giá trị cụ thể) | MỞ | Design | SC-59 |
| TB-23 | **§10.02** "**Không component nào** có hai dòng trùng tên" | Phát biểu **lượng từ phổ quát** trên **23 component × toàn bộ knob** (sheet Add đã tăng 16 → 23 mục theo ảnh batch 8) mà **không** khoanh vùng component nghi ngờ, không có danh sách tên chuẩn. Quét cạn kiệt là một khối công việc **không xác định được khối lượng** và rất dễ bỏ sót → không kiểm được triệt để. | Không kiểm được (phạm vi không xác định) | MỞ | Dev / design | SC-64 |
| TB-24 | **§10.05** "Ô **Drop** của Matrix (cả **widget** và **form nhắc nhở**) bằng tiếng **Đức/Ý/Nga** không còn nghĩa 'giọt nước'" | (a) **Không nêu chuỗi kỳ vọng** cho de/it/ru → tester chỉ biết chuỗi cũ sai, không biết chuỗi mới **đúng** là gì. (b) **Mâu thuẫn năng lực với §1.03**: §1 chỉ yêu cầu test "tiếng Việt + Đức **hoặc Nhật**"; chọn Nhật thì ô tick này **không chạy được**, chọn Đức thì vẫn thiếu **it/ru**. (c) Cần người đọc hiểu 3 ngôn ngữ đó. | Thiếu (oracle chuỗi) + mâu thuẫn phạm vi ngôn ngữ | MỞ (cao) | Localization | SC-68, SC-70 |
| TB-25 | **§10.03** "Week schedule: **Days shown** = **Mon – Fri** / **Full week**" | Nhãn "Mon – Fri" **cố định tiếng Anh và cố định thứ Hai**, trong khi ngày đầu tuần phụ thuộc locale (một số vùng bắt đầu Chủ nhật). Không nêu nhãn/hành vi khi máy có ngày đầu tuần là Chủ nhật → không có expected result cho cấu hình đó. | Thiếu (tương tác với locale) | MỞ | Dev / localization | SC-66 |
| TB-26 | **§12.02** "Ảnh so sánh (**golden**) chỉ chạy trên **iOS 18.6** qua CI đêm" + bằng chứng ảnh trong repo | Tester thủ công **không có baseline hình ảnh** cho **bất kỳ** component mới nào: 3 ảnh batch 8 trong repo chỉ chụp **sheet Add component**, **không có một ảnh nào** của Agenda / Event tickets / Workout / Daily page / Today at a glance / Milestones **đã render trên canvas**. → Mọi condition dạng "vé gọn lại, không chừa khoảng trống", "chữ không tràn", "thẻ tô xoay vòng màu", "ô đậm theo số sự kiện" **không có oracle hình ảnh**, chỉ dựa vào mô tả chữ. Cùng họ với TB-27 của bộ `tf-117`. | Thiếu (baseline hình ảnh) | MỞ (phải ghi rõ trong test-plan) | Nội bộ QC — chụp bổ sung trên build 1.2.19 | Mọi condition về bố cục/màu ở nhóm B–H |
| TB-27 | Toàn bộ tài liệu | **Không có mục Regression**, khác hẳn TF-117 (§11) và component-editor.md (§11) vốn luôn có. Đợt này **thêm 7 loại band mới vào engine render wallpaper**, nhưng không có một ô tick nào cho: lock screen thật, **Live Activity**, **widget**, thumbnail "Your collection", mở lại template đã sửa, template cũ không bị ảnh hưởng, **migration** (wallpaper chứa component mới mở ở bản app cũ hơn và ngược lại). Cũng **không có** tiêu chí hiệu năng cho các component nặng dữ liệu (Agenda 14 ngày, Milestones nhiều thẻ). | Thiếu (phạm vi regression + hiệu năng) | MỞ (cao) | Dev / test lead | SC-G2, SC-G4, SC-G6, SC-G7 |

### 1C · Phạm vi được test basis loại trừ tường minh (§12 — "chưa làm, không report")

Ghi lại để `test-plan` **mang nguyên sang phần scope** — đây là **loại trừ do test basis tuyên bố**, không phải quyết định của QC:

1. **§12.01** — Màu chữ tiêu đề **Priority matrix** chưa đổi theo **Color tone** Light/Dark trong Customize → **không report**.
2. **§12.02** — So sánh ảnh golden chỉ chạy trên **iOS 18.6 qua CI đêm** → **không** phải việc của test thủ công (nhưng xem **TB-26**: hệ quả là tester không có baseline).

---

## 2. Test condition đã ưu tiên hoá

> **Quy ước risk level** (ISTQB §5.2 — risk level = risk likelihood × risk impact, tiếp cận định tính):
> Cao×Cao = **Rất cao** → P1 · Cao×Vừa / Vừa×Cao = **Cao** → P1 · Cao×Thấp / Vừa×Vừa / Thấp×Cao = **Vừa** → P2 · Vừa×Thấp / Thấp×Vừa = **Thấp** → P3 · Thấp×Thấp = **Rất thấp** → P3.
> **Loại:** F = Functional suitability · U = Usability · S = Security · P = Performance efficiency · C = Compatibility · Po = Portability (ISO 25010).
> **Nhãn:** 🔭 = **Exploratory** — **không có expected result**, không chứng minh được pass (xem Sổ Exploratory) · ⚠️ = viết được nhưng **độ chính xác giảm** vì một vấn đề MỞ ở mục 1B · ⛔ = *(đã hết hiệu lực từ 2026-10-03 — **không còn dòng nào** mang nhãn này)*.

### Nhóm A — Sheet Add component & tồn kho (§1)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | Nhãn |
|---|---|---|---|---|---|---|---|---|
| SC-01 | 6 component mới có mặt trong sheet **Add component** với **đúng tên** test basis (Agenda, Event tickets, Workout, Daily page, Today at a glance, Milestones) | §1.04 + §2–§7 | F | Thấp | Cao | Vừa | **P2** | — |
| SC-02 | Tồn kho sheet Add: **23 mục / 6 nhóm**, có nhóm **Fitness** mới (chứa Workout) và **Month heatmap** trong nhóm Calendar | §1.04 + **Q-1 = A** | F | Vừa | Vừa | Vừa | **P2** | ⚠️ oracle **chỉ là ảnh batch 8**, test basis không nêu cấu trúc nhóm/số mục (TB-05, TB-26) |
| SC-03 | Thêm **từng** component mới qua nút **Add** → component xuất hiện trên canvas, toast *"Added …"* kèm **Undo**, rơi đúng chỗ theo quy tắc chèn hiện có | §1.04 | F | Vừa | Cao | **Cao** | **P1** | — |
| SC-04 | Mỗi component mới có icon minh hoạ + mô tả 1 dòng trong sheet | §1.04 (ngầm) | U | Thấp | Thấp | Rất thấp | **P3** | ⚠️ TB-26 · xem SC-75 cho trường hợp `Month heatmap` |
| SC-74 | **`Month heatmap`** (component thứ **7**) có mặt trong nhóm **CALENDAR**, mô tả *"The month, each day shaded by how busy it is."*; thêm được → band xuất hiện trên canvas + toast *"Added …"* | **Q-1 = A** *(không có mục nào trong test basis)* | F | Vừa | Cao | **Cao** | **P1** | ⚠️ chỉ phủ phần **tồn tại & thêm được**; **hành vi bên trong vẫn là `GAP` SC-G1** |
| SC-75 | Icon minh hoạ của **`Month heatmap`** trong sheet Add — ảnh batch 8 cho thấy ô icon **trống** | quan sát ảnh *(không có nguồn trong test basis)* | U | Cao | Thấp | Vừa | **P2** | ⚠️ **O-28** — §12 không liệt kê `Month heatmap` nên **không phân loại được** bug hay UI chưa xong; **không tự kết luận** |

### Nhóm B — Agenda (§2)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | Nhãn |
|---|---|---|---|---|---|---|---|---|
| SC-05 | Bố cục mặc định: **7 ngày tới**, gom theo ngày, cột trái thứ + số ngày to, mỗi sự kiện là khối màu có vạch trái, tên đậm, giờ bên phải | §2.01 | F | Vừa | Cao | **Cao** | **P1** | ⚠️ TB-26 |
| SC-06 | Knob **Days** ở 1 và 14 → số ngày hiển thị đổi đúng theo giá trị | §2.02 | F | Vừa | Vừa | Vừa | **P2** | ⚠️ TB-08 (không BVA được biên) |
| SC-07 | Knob **Events per day** = 1 → ngày có nhiều hơn 1 sự kiện hiện dòng **+N more** với **N đúng** (số sự kiện bị ẩn) | §2.02 | F | Vừa | Vừa | Vừa | **P2** | ⚠️ TB-08 |
| SC-08 | Tràn chiều dọc → **bỏ ngày xa nhất trước**, **không** cắt một ngày làm đôi | §2.03 | F | Cao | Vừa | **Cao** | **P1** | ⚠️ TB-09 (thiếu điều kiện kích hoạt) |
| SC-09 | Tắt **Show title** / **Date range** → mất **đúng** phần đó ở đầu band, phần còn lại không xô lệch | §2.04 | F | Vừa | Thấp | Thấp | **P3** | — |
| SC-10 | Sự kiện **cả ngày** hiển thị **"All day"** thay cho giờ | §2.01 | F | Vừa | Vừa | Vừa | **P2** | — |

### Nhóm C — Event tickets (§3)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | Nhãn |
|---|---|---|---|---|---|---|---|---|
| SC-11 | Chưa ghim gì → vé hiện **sự kiện sắp tới** (theo thứ tự thời gian) | §3.01 | F | Vừa | Cao | **Cao** | **P1** | ⚠️ TB-10 (không rõ số lượng) |
| SC-12 | Đã ghim sự kiện từ lịch → vé **chỉ** hiện sự kiện đã ghim | §3.01 | F | Cao | Cao | **Rất cao** | **P1** | 🔭 **EX-2** *(O-7, user 2026-10-02)* — chuyển sang **Exploratory**: thiếu dữ kiện thật (đường vào "ghim"), **không** phải ambiguity 2 cách hiểu; tester tự tìm đường vào trong lúc test thay vì chạy script cố định |
| SC-13 | 4 **Ticket style** (Classic, Admit, Side stub, Poster) đều render đúng kiểu, không vỡ bố cục | §3.02 | F | Cao | Vừa | **Cao** | **P1** | ⚠️ TB-26 |
| SC-14 | Đổi **Color scheme** → vé đổi màu, chữ vẫn đọc được trên mọi scheme | §3.02 | U | Vừa | Vừa | Vừa | **P2** | ⚠️ TB-11 (thiếu ngưỡng tương phản) |
| SC-15 | Tắt **Cover** / **Location** → vé **gọn lại**, **không chừa khoảng trống** chỗ phần đã tắt | §3.03 | F | Cao | Vừa | **Cao** | **P1** | — |
| SC-16 | Phóng cỡ chữ (Style → cỡ chữ) → **vé cao lên theo**, chữ **không tràn** ra ngoài vé | §3.04 | F | Cao | Vừa | **Cao** | **P1** | ⚠️ TB-11 |

### Nhóm D — Workout (§4)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | Nhãn |
|---|---|---|---|---|---|---|---|---|
| SC-17 | **Weekly plan**: chạm một ngày → sheet chọn môn / đặt tên / chi tiết; lưu → nội dung hiện đúng trên band | §4.01 | F | Vừa | Cao | **Cao** | **P1** | — |
| SC-18 | Chọn **Rest** cho một ngày → ngày đó **mờ đi** trên band | §4.01 | F | Vừa | Thấp | Thấp | **P3** | — |
| SC-19 | Style **List** / **Week strip** → hai kiểu render khác nhau, cùng dữ liệu | §4.03 | F | Vừa | Vừa | Vừa | **P2** | ⚠️ TB-26 |
| SC-20 | Icons **Symbol** / **Emoji** → nguồn icon đổi đúng theo lựa chọn (liên quan ô emoji, SC-57…SC-61) | §4.03 | F | Vừa | Vừa | Vừa | **P2** | — |
| SC-21 | **Fade past days** → ngày **đã qua** mờ; ranh giới "hôm nay" tính đúng (BVA quanh nửa đêm) | §4.03 | F | Vừa | Vừa | Vừa | **P2** | — |
| SC-22 | Ngày kế tiếp có dòng **Up next** + icon mũi tên; tắt **Decorative icons** → **mất icon**, dòng Up next vẫn còn | §4.04 | F | Vừa | Thấp | Thấp | **P3** | — |
| SC-23 | Bấm **Reset** của thành phần Workout → **kế hoạch tập VẪN CÒN** (không mất dữ liệu người dùng tự nhập) | §4.05 + **Q-2** | F | Cao | Cao | **Rất cao** | **P1** | ✅ **hết chặn** — xem ô ghi chú ngay dưới bảng |

> ### ⚠️ Ghi chú bắt buộc mang sang `test-plan` và `test-case` — **SC-23**
>
> **Expected result viết theo đúng câu chữ §4.05: bấm Reset → kế hoạch tập vẫn còn.** (Quyết định **Q-2 của user**, 2026-10-02 — căn cứ: `stack-components.md` là **test basis trực tiếp**, mạnh hơn suy luận gián tiếp từ tài liệu đối chiếu.)
>
> **Có một mâu thuẫn ĐÃ BIẾT, không được xoá:** [component-editor.md](../../../specs/wallpaper-editor/wallpaper-customize/component-editor.md) §7 cho thấy **Content → Reset vốn XOÁ nội dung người dùng tự nhập** (trường hợp Quote: *"Reset của Content trả lại đúng các câu gốc"*). Vì vậy:
>
> - Khi thực thi, nếu thấy **kế hoạch tập bị xoá** sau khi bấm Reset ⇒ **REPORT BUG NGAY**. Đây **không** phải lỗi thiết kế test case, cũng **không** phải "hành vi cố ý nhất quán với Quote".
> - Tester **không được tự "sửa" expected result** cho khớp hành vi quan sát được trên build.
> - **Dev vẫn CHƯA xác nhận** điều này — đây là quyết định diễn giải của user, không phải fact kỹ thuật.

### Nhóm E — Daily page (§5)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | Nhãn |
|---|---|---|---|---|---|---|---|---|
| SC-24 | Ngày thường: số ngày to + thứ + danh sách sự kiện hôm nay đúng dữ liệu máy | §5.01 | F | Vừa | Cao | **Cao** | **P1** | ⚠️ TB-26 |
| SC-25 | Ngày **rảnh** → hiện một câu trích dẫn thay cho danh sách sự kiện | §5.01 | F | Vừa | Vừa | Vừa | **P2** | ⚠️ TB-12 (chưa định nghĩa "rảnh" + nguồn câu) |
| SC-26 | Ngày lễ (từ lịch ngày lễ đã bật) → **tên lễ to**, sự kiện của ngày đó liệt kê **bên dưới** | §5.02 | F | Cao | Vừa | **Cao** | **P1** | — |
| SC-27 | **Lunar date** mặc định **bật** trên máy vùng VN (và CN), **tắt** trên vùng ngoài tập | §5.03 | Po | Cao | Vừa | **Cao** | **P1** | ⚠️ TB-13 (danh sách vùng bỏ lửng, không rõ Region/Language) |
| SC-28 | Dòng âm lịch có icon trăng, ngày lễ có icon pháo giấy; tắt **Decorative icons** → mất icon | §5.04 | F | Vừa | Thấp | Thấp | **P3** | — |

### Nhóm F — Today at a glance (§6)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | Nhãn |
|---|---|---|---|---|---|---|---|---|
| SC-29 | 4 phần (sự kiện chính · thanh giờ · việc cần làm · giờ rảnh) hiển thị đúng dữ liệu lịch + Reminders của máy | §6.01 | F | Vừa | Cao | **Cao** | **P1** | ⚠️ TB-26 |
| SC-30 | **Mỗi phần tắt được riêng** → tắt phần nào mất đúng phần đó, các phần còn lại dồn lên, không chừa khoảng trống | §6.01 | F | Cao | Vừa | **Cao** | **P1** | — |
| SC-31 | Nhãn có icon (mặt trời, checklist), giờ rảnh có icon lá; tắt **Decorative icons** → mất icon | §6.02 | F | Vừa | Thấp | Thấp | **P3** | — |
| SC-32 | Ngày chuyển **DST** → thanh giờ **không lệch một tiếng** | §6.03 | F | Cao | Vừa | **Cao** | **P1** | ⚠️ TB-14 — **chưa có phương tiện dựng tình huống** |
| SC-33 | "**Giờ rảnh**" tính đúng từ khoảng trống giữa các sự kiện trong ngày | §6.01 | F | Cao | Vừa | **Cao** | **P1** | ⚠️ TB-15 (thiếu thuật toán → chỉ kiểm được tính hợp lý thô) |

### Nhóm G — Milestones (§7)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | Nhãn |
|---|---|---|---|---|---|---|---|---|
| SC-34 | **Add a day** → sheet mở **ngay** (không chờ, không phải 2 bước) | §7.01 | U | Thấp | Cao | Vừa | **P2** | — |
| SC-35 | Đóng sheet của một ngày **mới** khi **chưa đặt tên** → ngày đó **tự biến mất**, không để lại thẻ rỗng | §7.01 | F | Vừa | Cao | **Cao** | **P1** | — |
| SC-36 | Xoá trắng tên của một ngày **đã tồn tại** rồi đóng sheet → ngày đó còn hay mất? | — *(không có nguồn trong test basis)* | F | Vừa | Cao | **Cao** | **P1** | 🔭 **EX-6** *(O-33, user 2026-10-03)* — **không có expected result**; đường dẫn **xoá dữ liệu**, quan sát và báo lại điều bất thường, **không tự kết luận pass** |
| SC-37 | Tiêu đề sheet = **tên ngày**; chưa có tên → **"New day"** (ngày mới) / **"Untitled"** (ngày cũ) | §7.02 | U | Vừa | Thấp | Thấp | **P3** | — |
| SC-38 | Văn bản đếm ngày đúng theo mốc: tương lai → *"còn N ngày"* · hôm nay → **"Today"** · ngày mai/hôm qua → dạng chữ · quá khứ → *"đã N ngày"*. **BVA quanh ±1 ngày và quanh nửa đêm** | §7.03 | F | Cao | Cao | **Rất cao** | **P1** | — |
| SC-39 | **Every year** → đếm tới **lần kế tiếp** (kể cả khi mốc trong năm đã qua); badge số năm cạnh tên (*"6 years"*) **dịch theo ngôn ngữ máy** | §7.04 | F | Cao | Vừa | **Cao** | **P1** | — |
| SC-40 | Dòng ngày có icon lịch phía trước; số **≥ 4 chữ số** co lại, **không tràn thẻ** | §7.05 | F | Vừa | Vừa | Vừa | **P2** | — |
| SC-41 | **Card palette** ≠ Plain → thẻ tô **xoay vòng màu**; thẻ **hôm nay** luôn **màu nhấn**; thẻ **ngay sau** lấy **màu đầu** bảng | §7.06 | F | Cao | Vừa | **Cao** | **P1** | ⚠️ TB-17 (thiếu quy tắc khi không có thẻ "hôm nay") |
| SC-42 | **Card pattern** in hoạ tiết lên **từng thẻ ngày**; **thẻ nền** (card ngoài band) **không có** mục hoạ tiết/ảnh | §7.07 | F | Vừa | Thấp | Thấp | **P3** | — |
| SC-43 | **Birthdays & holidays** tắt → chỉ còn ngày tự thêm; bật → có thêm sinh nhật/lễ từ lịch hệ thống | §7.08 | F | Vừa | Vừa | Vừa | **P2** | — |
| SC-44 | Máy dùng **lịch Phật giáo (Thái)** → thêm ngày **lưu đúng năm dương lịch** và **đếm đúng** (không lệch 543 năm) | §7.09 | Po | Cao | Cao | **Rất cao** | **P1** | — |

### Nhóm H — Knob mới trên component cũ (§8)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | Nhãn |
|---|---|---|---|---|---|---|---|---|
| SC-46 | **Week events → Style** tồn tại và có đủ **3 giá trị** Bars / Dots / Heat map — **knob giữ nguyên như §8.01**, độc lập với component `Month heatmap` | §8.01 + **Q-1 = A** | F | Vừa | Cao | **Cao** | **P1** | ✅ hết chặn |
| SC-47 | Style = **Dots** → mỗi sự kiện một chấm, **4 chấm một hàng**, ngày nhiều hơn 4 sự kiện xuống hàng | §8.01 | F | Vừa | Vừa | Vừa | **P2** | ✅ hết chặn |
| SC-48 | Style = **Heat map** (phạm vi **tuần**) → ô đậm theo số sự kiện; ngày bận nhất có **ngọn lửa** khi **≥ 2 sự kiện**; **hoà** thì mọi ngày bằng nhau đều có; **< 2** thì không có lửa | §8.01 | F | Cao | Vừa | **Cao** | **P1** | ✅ hết chặn · ⚠️ TB-19 (thiếu thang độ đậm) · ⚠️ **không nhầm với** `Month heatmap` (phạm vi **tháng**, SC-74) **và** `Activity grid` |
| SC-49 | Knob của thanh (**Block opacity**, **+N more**) **chỉ hiện ở Bars**, **ẩn** ở Dots / Heat map | §8.01 | F | Cao | Vừa | **Cao** | **P1** | ✅ hết chặn · ⚠️ TB-20 (tên control lệch giữa 2 tài liệu) |
| SC-50 | **Month progress → Date range**: mặc định **This month**; chọn **Custom** → tự điền **hôm nay** và **+90 ngày**, hiện thêm ô **Title** | §8.02 | F | Vừa | Vừa | Vừa | **P2** | ⚠️ TB-18(c) ("+90" tính cả hôm nay?) |
| SC-51 | Ngưỡng màu thanh: **cam từ 75%**, **đỏ từ 90%** — **BVA tại 74/75 và 89/90**; công tắc ngưỡng **tắt được** → thanh giữ màu gốc | §8.02 | F | Cao | Vừa | **Cao** | **P1** | — |
| SC-52 | Khoảng **Custom**: hôm nay **trước** khoảng → **0%**; **sau** khoảng → **100%**; đúng biên đầu/cuối khoảng | §8.02 | F | Cao | Vừa | **Cao** | **P1** | — |
| SC-53 | **Priority matrix → Each box**: 4 màu riêng (Do now · Plan · Delegate · Drop) **đè màu chung**; tắt → quay về màu chung | §8.03 | F | Vừa | Vừa | Vừa | **P2** | — |
| SC-54 | **Box pattern** in hoạ tiết lên **cả 4 ô**; **thẻ nền** của Matrix **không còn** hoạ tiết/ảnh | §8.03 | F | Vừa | Thấp | Thấp | **P3** | — |
| SC-55 | **Strike out the Drop box** mặc định **TẮT**; bật → việc trong ô **Drop** bị **gạch ngang** | §8.04 | F | Vừa | Thấp | Thấp | **P3** | — |

### Nhóm I — Ô emoji (Milestones, Workout) (§9)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | Nhãn |
|---|---|---|---|---|---|---|---|---|
| SC-57 | Ô emoji là **hình vuông**, **cao bằng** ô tên bên cạnh (kiểm ở **cả** Milestones và Workout) | §9.01 | U | Vừa | Thấp | Thấp | **P3** | — |
| SC-58 | Chạm ô → bàn phím mở **thẳng trang emoji**; chọn một emoji → **lưu** và bàn phím **đóng** | §9.02 | F | Cao | Vừa | **Cao** | **P1** | — |
| SC-59 | Phím **xoá** → bỏ emoji, ô trở về **emoji mặc định mờ** (placeholder) | §9.03 | F | Vừa | Vừa | Vừa | **P2** | ⚠️ TB-22 (không biết emoji mặc định là gì) |
| SC-60 | Đổi sang bàn phím chữ (quả địa cầu) rồi gõ chữ → **không nhận** ký tự chữ | §9.04 | F | Cao | Vừa | **Cao** | **P1** | — |
| SC-61 | Máy **đã tắt bàn phím Emoji** trong Cài đặt → hiện bàn phím thường, ô **vẫn chỉ nhận emoji** | §9.05 | U | Cao | Vừa | **Cao** | **P1** | ⚠️ TB-21 (ngõ cụt nhập liệu, không có oracle cho trải nghiệm) |
| SC-62 | **Dán (paste)** / đọc chính tả vào ô emoji → ô nhận gì? | — *(không có nguồn trong test basis)* | F | Vừa | Thấp | Thấp | **P3** | 🔭 **EX-7** *(O-33, user 2026-10-03)* — **không có expected result**; §9 chỉ nói về gõ phím |

### Nhóm J — Nhãn bảng chỉnh & localization (§10 + §1.03)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | Nhãn |
|---|---|---|---|---|---|---|---|---|
| SC-63 | Nhóm **thứ ba** của bảng chỉnh tên **Backdrop** ("**Nền**"), **không** phải "Hình nền" | §10.01 | F | Vừa | Thấp | Thấp | **P3** | — |
| SC-64 | **Không component nào** có hai dòng trùng tên trong bảng chỉnh | §10.02 | U | Vừa | Vừa | Vừa | **P2** | ⚠️ TB-23 (phạm vi quét không xác định) · TB-20 |
| SC-65 | Nhãn thẻ đúng cấp: thẻ sau **cả band** = *Thẻ nền / Màu thẻ nền / Lề thẻ nền*; thẻ **con** của band: Matrix = "ô", Timeline = "thẻ sự kiện", Milestones = "thẻ" | §10.02 | U | Vừa | Thấp | Thấp | **P3** | — |
| SC-66 | **Week schedule**: **Days shown** = *Mon – Fri* / *Full week*; chữ đầu cột gọi là **Day header** | §10.03 | U | Vừa | Thấp | Thấp | **P3** | ⚠️ TB-25 (chưa nêu hành vi khi ngày đầu tuần là Chủ nhật) |
| SC-67 | **Workout**: nhãn nhóm là **Weekly plan** ("**Kế hoạch tuần**") | §10.04 | U | Thấp | Thấp | Rất thấp | **P3** | — |
| SC-68 | Ô **Drop** của Matrix — **cả widget và form nhắc nhở** — ở **de / it / ru** không còn mang nghĩa "giọt nước" | §10.05 | U | Cao | Thấp | Vừa | **P2** | ⚠️ TB-24 (không có chuỗi kỳ vọng; §1.03 không bắt buộc it/ru) |
| SC-69 | Ô nhập tiêu đề trong bảng chỉnh căn **trái** | §10.06 | U | Vừa | Thấp | Thấp | **P3** | — |
| SC-70 | **Toàn bộ chuỗi mới** của 6 component + knob mới có bản dịch **tiếng Việt** và ngôn ngữ thứ hai — không lọt chuỗi tiếng Anh vào máy VI | §1.03 | U | Cao | Vừa | **Cao** | **P1** | ⚠️ TB-07 (chưa có bảng đối chiếu VI) · TB-24 |

### Nhóm K — Chia sẻ template (§11)

> **Phạm vi nhóm K đã được user thu hẹp có chủ đích (Q-3, 2026-10-02): chỉ kiểm ở mức UI của người nhận.** Xem ô cảnh báo 🔒 ngay dưới bảng — **không** được hiểu là "privacy đã được test đầy đủ".

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | Nhãn |
|---|---|---|---|---|---|---|---|---|
| SC-71 | Share template có **Milestones** → **trên UI của máy người nhận** không hiển thị ngày riêng (tên, ngày) của người gửi | §11.01 + **Q-3** | **S** | Vừa | Cao | **Cao** | **P1** | ✅ hết chặn · **UI-level only** · ⚠️ không có oracle cho "người nhận thấy gì thay thế" (TB-03c) |
| SC-72 | Share template có **Event tickets** → **trên UI của máy người nhận** không hiển thị sự kiện đã ghim của người gửi | §11.01 + **Q-3** | **S** | Vừa | Cao | **Cao** | **P1** | ✅ hết chặn · **UI-level only** · ⚠️ TB-03c |
| SC-73 | **Ảnh thẻ chọn từ máy** không đi theo link share | §11.02 | **S** | Vừa | Cao | **Cao** | **P1** | — *(có oracle đối chiếu: `template-sharing-api.md` yêu cầu `backgroundImagePath`/`backgroundSourcePath` = `null`, "No file paths")* |
| SC-89 | Share template có **Workout** → **trên UI của máy người nhận** không hiển thị kế hoạch tập của người gửi (tên môn, chi tiết, **emoji**) | **O-29 = CÓ** *(user 2026-10-02 — §11 **không** nhắc tới Workout)* | **S** | Vừa | Cao | **Cao** | **P1** | ⚠️ **mở rộng phạm vi do user quyết định, KHÔNG phải requirement của test basis** · **UI-level only** (Q-3) · ⚠️ TB-03c (không có oracle cho "người nhận thấy gì thay thế") |

> ### 🔒 Ghi chú bắt buộc mang sang `test-plan` và `test-case` — giới hạn phạm vi privacy (SC-71, SC-72)
>
> **Đây là quyết định GIẢM PHẠM VI CÓ CHỦ ĐÍCH của user (Q-3, 2026-10-02) — KHÔNG phải gap, không phải oversight, không phải thiếu sót của bản phân tích.**
>
> - **Trong phạm vi:** dữ liệu riêng tư (tên/ngày của Milestones, sự kiện đã ghim của Event tickets) **không hiển thị trên UI của người nhận**.
> - **NGOÀI phạm vi (CHƯA TEST):** **payload / network** có thực sự chứa dữ liệu đó hay không. Nếu app **vẫn gửi** dữ liệu đi nhưng chỉ **ẩn lúc render**, thì đó **vẫn là rò rỉ dữ liệu cá nhân** mà bộ test này **sẽ không phát hiện được** → xem **SC-G8**.
> - **Hệ quả cho traceability:** khi báo cáo kết quả, **không** được phát biểu rằng "yêu cầu riêng tư §11 đã được kiểm thử đầy đủ". Phát biểu đúng là: *"đã kiểm ở mức hiển thị UI phía người nhận; mức payload/network chưa nằm trong phạm vi đợt này."*
> - **Khuyến nghị (không chặn):** nếu sau này cần audit riêng tư thật sự (yêu cầu pháp lý, báo cáo bảo mật, hoặc có bug report về rò rỉ), **mở lại SC-G8** và bổ sung kiểm payload — đồng thời làm rõ ý **(b)** của Q-3 (vì sao `template-sharing-api.md` **không** liệt kê 2 mục strip này trong khi §11 yêu cầu).

### Nhóm M–P — Phạm vi **do user mở rộng** 2026-10-02 (O-24 / O-25)

> ### ⚠️ Cảnh báo nguồn gốc — bắt buộc mang sang phần **scope** của `test-plan`
>
> User quyết định **4 mục này NẰM TRONG phạm vi** đợt test, và viện dẫn câu: *"vùng ảnh hưởng là **toàn bộ wallpaper lịch**: bản render thật trên màn khoá, Live Activity, widget và thumbnail đều ăn theo dữ liệu mà màn này ghi ra."*
>
> **QC đã kiểm chứng: câu này KHÔNG có trong test basis `stack-components.md`** (đã grep toàn file — không khớp "vùng ảnh hưởng", "Live Activity", "thumbnail"). Câu đó nằm ở **[component-editor.md](../../../specs/wallpaper-editor/wallpaper-customize/component-editor.md) dòng 7–9** — tức **tài liệu đối chiếu**, không phải test basis.
>
> **Hệ quả bắt buộc ghi nhận (không làm đổi quyết định của user — phạm vi là quyền của user):**
> - **Toàn bộ nhóm M, N, O, P KHÔNG có requirement trong test basis.** Oracle = **tài liệu đối chiếu** `component-editor.md` (§11 Regression, §4.14, §6.1–§6.2, §7, §10 #2) **+ quyết định phạm vi của user**.
> - Phải ghi rõ điều này trong phần scope của `test-plan` — **không** được trình bày như requirement của `stack-components.md`.
> - Đây **đúng tiền lệ nhóm R/S của bộ [`tf-117`](test-analysis-tf-117.md)** (điều kiện số 3 ở banner tài liệu đó).
> - Nếu dev/PO sau này nói 4 mục này **không** thuộc đợt bàn giao → chỉ các condition SC-76 … SC-88 phải gỡ, phần còn lại không ảnh hưởng.

#### Nhóm M — Regression render thật (O-24)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | Nhãn |
|---|---|---|---|---|---|---|---|---|
| SC-76 | Đặt wallpaper chứa component mới làm **màn khoá thật** → render **đúng như preview** trong Customize (kiểm trên **cả 7** component mới) | `component-editor.md` §11 + **O-24** | F | Cao | Cao | **Rất cao** | **P1** | ⚠️ ngoài test basis |
| SC-77 | **Live Activity** của template chứa component mới vẫn chạy, **không vỡ layout** | `component-editor.md` §11 + **O-24** | F | Vừa | Vừa | Vừa | **P2** | ⚠️ ngoài test basis · ⚠️ **O-30** — không rõ component mới nào **được hỗ trợ** trong Live Activity |
| SC-78 | **Widget** và **thumbnail** trong "Your collection" cập nhật theo bố cục có component mới | `component-editor.md` §11 + **O-24** | F | Vừa | Vừa | Vừa | **P2** | ⚠️ ngoài test basis · ⚠️ **O-30** |
| SC-79 | **Template lịch cũ** (chưa động vào) render **y như trước** — đợt thêm 7 component không làm hỏng template sẵn có | `component-editor.md` §11 + **O-24** | F | Vừa | Cao | **Cao** | **P1** | ⚠️ ngoài test basis |
| SC-80 | Mở lại template **đã sửa** (có component mới) → bố cục **giữ nguyên**, sửa tiếp được | `component-editor.md` §11 + **O-24** | F | Vừa | Cao | **Cao** | **P1** | ⚠️ ngoài test basis |

#### Nhóm N — Migration dữ liệu template (O-24)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | Nhãn |
|---|---|---|---|---|---|---|---|---|
| SC-81 | Wallpaper lưu **ở build cũ** (chưa có component mới) mở ở build đợt này → bố cục giữ nguyên, **không mất band**, sửa tiếp được | `component-editor.md` §11 + **O-24** | Po | Vừa | Cao | **Cao** | **P1** | ⚠️ ngoài test basis |
| SC-82 | Wallpaper chứa component mới mở ở **bản app CŨ hơn** (migration ngược) | **O-24** | Po | Cao | Cao | **Rất cao** | **P1** | 🔭 **EX-4 — ĐÃ XÁC NHẬN** *(O-31, user 2026-10-03)*: Exploratory, **không viết script cố định**. **Không có expected result** (suy giảm êm? band trống? mất band? crash?) — quan sát và báo lại, **không tự kết luận pass** |

#### Nhóm O — Hiệu năng (O-24)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | Nhãn |
|---|---|---|---|---|---|---|---|---|
| SC-83 | Wallpaper có **nhiều band mới nặng dữ liệu cùng lúc** (vd Agenda 14 ngày + Milestones nhiều thẻ + Workout + Today at a glance) → canvas Customize vẫn chọn/kéo/cuộn **mượt**, không đứng hình | `component-editor.md` §4.14 + **O-24** | **P** | Cao | Vừa | **Cao** | **P1** | ⚠️ ngoài test basis · 🔭 **EX-5** phần đo — ⚠️ **O-32** (không có fps/ngưỡng/tập máy tối thiểu; kế thừa đúng vấn đề TB-17 của `tf-117`) |
| SC-84 | Thời gian **render & áp dụng** wallpaper nặng ra màn khoá không tăng bất thường so với template thường | **O-24** | **P** | Vừa | Vừa | Vừa | **P2** | ⚠️ ngoài test basis · ⚠️ **O-32** (không có ngưỡng) |

#### Nhóm P — Component mới lồng trong Row / Column (O-25)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | Nhãn |
|---|---|---|---|---|---|---|---|---|
| SC-85 | **Mỗi** component mới thêm được vào **ô trống của Row/Column** (nút + trong ô) → lấp **đúng ô đó**, ô còn lại **vẫn còn nguyên** | `component-editor.md` §6.1 + **O-25** | F | Vừa | Vừa | Vừa | **P2** | ⚠️ ngoài test basis |
| SC-86 | Component mới nằm **trong** Row/Column → **không có thanh Size** (hành vi cố ý `component-editor.md` §10 #2); các knob riêng của nó **vẫn chỉnh được** | `component-editor.md` §7, §10 #2 + **O-25** | F | Vừa | Thấp | Thấp | **P3** | ⚠️ ngoài test basis |
| SC-87 | Component mới **cao / nhiều dòng** (Agenda, Milestones, Workout, Event tickets) đặt trong **Row** nên chỉ còn **nửa bề rộng** → nội dung xuống dòng/co lại hợp lý, **không tràn, không bị cắt** | `component-editor.md` §5.07 + **O-25** | F | Cao | Vừa | **Cao** | **P1** | ⚠️ ngoài test basis · ⚠️ đây là tổ hợp **rủi ro nhất** của nhóm P |
| SC-88 | Giới hạn **3 cấp container** vẫn đúng khi lồng component mới (ở cấp 3, nhóm **Layout** biến mất khỏi sheet Add) | `component-editor.md` §6.2 + **O-25** | F | Thấp | Thấp | Rất thấp | **P3** | ⚠️ ngoài test basis · regression thuần của `tf-117` |

### Nhóm L — Sổ `GAP` *(đặt cuối cùng vì là sổ theo dõi, không phải nhóm test object)*

> Các dòng dưới đây **không có nguồn trong test basis**. Sau 2 đợt trả lời, **5/8 dòng đã được user xử lý** (gạch ngang = đã đóng, kèm nơi chuyển đến). **Chỉ còn 2 dòng là `GAP` thật.** Các dòng còn `GAP` **không** sinh test case và **không** tự viết expected result.

| # | Khoảng trống | Vì sao đáng quan tâm | Nguồn gốc |
|---|---|---|---|
| ~~SC-G1~~ | ~~`Month heatmap` — hành vi chi tiết~~ | ✅ **ĐÃ XỬ LÝ (user, O-27 = Exploratory)** → chuyển thành **🔭 EX-3** (xem bảng Exploratory dưới). Vẫn **0 dòng acceptance criteria**; scripted chỉ phủ SC-74/SC-75 | TB-01 · O-27 |
| ~~SC-G2~~ | ~~Regression render thật~~ | ✅ **ĐÃ ĐƯA VÀO PHẠM VI (user, O-24)** → **SC-76 … SC-80** (nhóm M) | TB-27 · O-24 |
| **SC-G3** | **Month progress → Custom** với khoảng **không hợp lệ** (end ≤ start) | **VẪN LÀ `GAP`** — không có expected result cho nhánh âm; chưa được hỏi/trả lời | TB-18(b) · O-15 |
| ~~SC-G4~~ | ~~Migration~~ | ✅ **ĐÃ ĐƯA VÀO PHẠM VI (user, O-24)** → **SC-81** (xuôi) + **SC-82** (ngược, 🔭 EX-4, chờ O-31) | TB-27 · O-24 |
| ~~SC-G5~~ | ~~Workout weekly plan khi share~~ | ✅ **ĐÃ QUYẾT ĐỊNH (user, O-29 = CÓ ẩn)** → **SC-89** (nhóm K), UI-level theo Q-3 | TB-03 · O-29 |
| ~~SC-G6~~ | ~~Hiệu năng~~ | ✅ **ĐÃ ĐƯA VÀO PHẠM VI (user, O-24)** → **SC-83, SC-84** (nhóm O); phần **đo định lượng** vẫn thiếu ngưỡng → 🔭 EX-5 / O-32 | TB-27 · O-24 |
| ~~SC-G7~~ | ~~Component mới trong Row / Column~~ | ✅ **ĐÃ ĐƯA VÀO PHẠM VI (user, O-25)** → **SC-85 … SC-88** (nhóm P) | TB-27 · O-25 |
| **SC-G8** | **Audit riêng tư mức payload / network** khi share template (Milestones, Event tickets, **và Workout plan**) | **VẪN LÀ `GAP` — do user DESCOPE có chủ đích** (Q-3), **không phải thiếu sót**. Hệ quả: nếu dữ liệu cá nhân **vẫn đi theo payload** mà chỉ bị ẩn lúc render, bộ test đợt này **không phát hiện được**. O-29 mở rộng phạm vi ẩn sang Workout **nhưng vẫn chỉ ở mức UI** → SC-G8 nay phủ **cả 3** loại dữ liệu | TB-03 · Q-3 · O-29 |

**Còn lại đúng 2 `GAP`:** **SC-G3** (thiếu requirement) và **SC-G8** (descope có chủ đích). *(SC-36 và SC-62 — trước đây mang nhãn ⛔ — đã được user chuyển sang Exploratory 🔭 EX-6 / EX-7 ở đợt trả lời thứ 3.)*

### 🔭 Sổ Exploratory — vùng test **không có script**, tester tự khám phá

> **Căn cứ: quyết định của user ngày 2026-10-02** (O-1, O-7, O-27). Nguyên tắc user đặt ra: **thiếu dữ kiện thật ≠ ambiguity 2 cách hiểu** → không chặn pipeline, chuyển sang Exploratory thay vì viết script cố định hoặc tự bịa expected result.
>
> ⚠️ **Exploratory KHÔNG phải "đã test".** Không có expected result ⇒ **không chứng minh được pass**; chỉ phát hiện được điều bất thường đập vào mắt. Khi báo cáo kết quả phải tách bạch "scripted" và "exploratory".

| # | Vùng khám phá | Vì sao không scripted | Gắn với | Nguồn quyết định |
|---|---|---|---|---|
| **EX-1** | **Chi tiết sâu của 6 component mới** — font, nguồn dữ liệu, giá trị biên, tổ hợp knob… tức phần lẽ ra nằm trong `docs/components/new-components.md` | Tài liệu đó **không tồn tại**; scripted chỉ bám đúng checklist `stack-components.md` | Toàn nhóm **B–G** | **O-1** (user) |
| **EX-2** | **Đường vào hành động "ghim" sự kiện** + hành vi Event tickets theo trạng thái ghim (giới hạn số ghim, sự kiện đã ghim trôi qua/bị xoá) | Thiếu dữ kiện thật về đường vào — không phải ambiguity | **SC-12** (P1) | **O-7** (user) |
| **EX-3** | **Hành vi chi tiết `Month heatmap`** — thang độ đậm, phạm vi tháng, knob riêng, khác biệt với `Week events → Heat map` (tuần) và `Activity grid` | Component **có thật** (Q-1 = A) nhưng **0 dòng acceptance criteria** | SC-74, SC-75 | **O-27** (user) |
| **EX-4** | **Migration ngược** — template chứa component mới mở ở bản app **cũ hơn** | Không có expected result (suy giảm êm? band trống? crash?) | **SC-82** (P1) | ✅ **O-31** (user 2026-10-03) — đã xác nhận |
| **EX-5** | **Đo hiệu năng định lượng** — fps, ngưỡng frame drop, tập máy tối thiểu | Test basis lẫn tài liệu đối chiếu đều **không có tiêu chí đo khách quan** | SC-83, SC-84 | **O-24** (phạm vi) + **O-32** (thiếu ngưỡng) |
| **EX-6** | **Xoá trắng tên một mốc ngày đã tồn tại** (Milestones) rồi đóng sheet — ngày đó còn hay mất | Test basis **chỉ** định nghĩa cho ngày **mới** (§7.01); trường hợp ngày **cũ** bị bỏ trống | **SC-36** (P1) | ✅ **O-33** (user 2026-10-03) |
| **EX-7** | **Dán (paste) / đọc chính tả** vào ô emoji | §9 **chỉ** mô tả nhánh gõ phím | **SC-62** (P3) | ✅ **O-33** (user 2026-10-03) |

> **EX-6 nằm trên đường dẫn xoá dữ liệu người dùng** — tuy là exploratory, nếu quan sát thấy mốc ngày **biến mất im lặng** thì phải **ghi nhận và báo lại** để dev phân xử, **không** tự kết luận "đúng thiết kế".

### Tổng hợp số lượng

*(Chốt **2026-10-03** — sau **đợt trả lời thứ 3** và tuyên bố `READY — có điều kiện` của user.)*

| | P1 | P2 | P3 | Chưa risk-rate được | **Tổng** |
|---|---|---|---|---|---|
| **Test condition (SC-xx)** | **44** | **24** | **19** | **0** | **87** |
| **`GAP` (SC-Gx)** — không sinh test case | — | — | — | **2** | **2** |
| **Exploratory (EX-x)** — **không có expected result** | — | — | — | **7** | **7** |

> ⚠️ **87 condition KHÔNG đồng nghĩa 87 case có thể chấm pass/fail.** Trong đó **7 condition thuộc vùng Exploratory** (SC-12, SC-36, SC-62, SC-74/SC-75 *(phần sâu)*, SC-82, SC-83 *(phần đo)*) — có risk rating để xếp ưu tiên, nhưng **không có expected result**. Phần **scripted thật sự chấm được pass/fail** là **~80 condition**.

**Diễn biến qua 4 mốc:**

| | Lần lập đầu | Sau đợt 1 *(Q-1/2/3)* | Sau đợt 2 *(O-1/7/24/25/27/29)* | **Sau đợt 3 *(O-31/33)*** |
|---|---|---|---|---|
| P1 | 33 | 35 | 43 | **44** |
| P2 | 18 | 20 | 24 | **24** |
| P3 | 16 | 16 | 18 | **19** |
| Chưa rate được | 4 | 2 | 2 | **0** |
| **Tổng condition** | 71 | 73 | 87 | **87** |
| Dòng ⛔ | 8 | 2 | 2 | **0** |
| `GAP` | 7 | 8 | 2 | **2** |
| Exploratory 🔭 | 0 | 0 | 5 | **7** |
| **Analysis Status** | `BLOCKED` | `DRAFT` | `DRAFT` | **`READY` (có điều kiện)** |

**14 condition mới của đợt 2** — toàn bộ **nằm ngoài test basis**, oracle là `component-editor.md` + quyết định phạm vi của user:

| Nhóm | Mã | P1 | P2 | P3 |
|---|---|---|---|---|
| **M** — Regression render thật (O-24) | SC-76 … SC-80 | SC-76, SC-79, SC-80 | SC-77, SC-78 | — |
| **N** — Migration (O-24) | SC-81, SC-82 | SC-81, SC-82 🔭 | — | — |
| **O** — Hiệu năng (O-24) | SC-83, SC-84 | SC-83 🔭 | SC-84 | — |
| **P** — Lồng Row/Column (O-25) | SC-85 … SC-88 | SC-87 | SC-85 | SC-86, SC-88 |
| **K** — Privacy Workout (O-29) | SC-89 | SC-89 | — | — |

**✅ Không còn dòng ⛔ nào** — 2 dòng cuối (SC-36, SC-62) đã được user chuyển sang Exploratory 🔭 EX-6 / EX-7 ở đợt trả lời thứ 3 (**O-33**, 2026-10-03), và nay đã được risk-rate để xếp ưu tiên khám phá: **SC-36 = P1** *(đường dẫn xoá dữ liệu)* · **SC-62 = P3**.

⚠️ **Nhưng lỗ oracle gốc KHÔNG biến mất cùng với nhãn ⛔** — chỉ đổi cách xử lý:

| Condition | Lỗ oracle vẫn còn nguyên trong test basis | Câu hỏi gốc **chưa có câu trả lời từ dev** |
|---|---|---|
| **SC-36** 🔭 EX-6 | Xoá trắng tên một ngày **đã tồn tại** (Milestones) rồi đóng sheet — test basis im lặng; giữ lại hay xoá là **hai hành vi dữ liệu khác nhau** | **O-13** |
| **SC-62** 🔭 EX-7 | **Dán (paste)** / đọc chính tả vào ô emoji — §9 chỉ nói về gõ phím | **O-18** |

> **Ghi chú đánh số:** mã **SC-45** và **SC-56** **cố ý bỏ trống** (dòng dự thảo đã gộp vào nhóm khác trong lúc soạn). Không renumber để mọi tham chiếu chéo trong tài liệu giữ nguyên hiệu lực. **SC-74, SC-75** là hai mã **mới thêm** sau đợt trả lời Q-1.

---

## 3. Traceability nháp

| Test condition | Mục test basis | Ghi chú cho `test-plan` |
|---|---|---|
| SC-01 … SC-04 | §1.04 | Nhóm "tồn kho & thêm component" — gộp chung một test object với phần Add component của `tf-117` |
| SC-74, SC-75 | *(không có — căn cứ là **Q-1 = A**, user 2026-10-02)* | Test object mới **`Month heatmap`**; **chỉ** phủ "tồn tại & thêm được" + icon. **Không** viết case về hành vi bên trong khi SC-G1 còn là `GAP` |
| SC-05 … SC-10 | §2.01 – §2.04 | Test object riêng **Agenda**; SC-06/SC-07 là ứng viên **EP + BVA** nếu TB-08 được bổ sung biên |
| SC-11 … SC-16 | §3.01 – §3.04 | Test object riêng **Event tickets**; SC-13 là ứng viên **EP theo 4 Ticket style**; SC-12 **chưa chạy được** tới khi TB-10 có trả lời |
| SC-17 … SC-23 | §4.01 – §4.05 | Test object riêng **Workout**; **SC-23 viết case theo đúng §4.05** (Q-2) — mang theo nguyên ô ghi chú "thấy kế hoạch bị xoá ⇒ report BUG" |
| SC-24 … SC-28 | §5.01 – §5.04 | Test object riêng **Daily page**; SC-27 cần ma trận **Region/Language** → liên quan TB-13 |
| SC-29 … SC-33 | §6.01 – §6.03 | Test object riêng **Today at a glance**; SC-32 cần phương tiện dựng DST (TB-14) trước khi lên lịch chạy |
| SC-34 … SC-44 | §7.01 – §7.09 | Test object riêng **Milestones**; SC-38 là ứng viên **BVA mạnh nhất của đợt** (mốc ngày ±1, nửa đêm); SC-44 cần máy/giả lập lịch Phật giáo |
| SC-46 … SC-49 | §8.01 | Gộp vào test object **Week events** đã có ở `tf-117`; ứng viên **EP theo 3 giá trị Style**. **Q-1 = A** ⇒ knob này **độc lập** với component `Month heatmap` (SC-74) — test-plan phải nói rõ để tester không gộp nhầm hai thứ |
| SC-50 … SC-52 | §8.02 | Ứng viên **BVA** (74/75, 89/90, biên khoảng Custom) + **Decision Table** cho tổ hợp *This month / Custom × trước / trong / sau khoảng* |
| SC-53 … SC-55 | §8.03 – §8.04 | Gộp vào test object **Priority matrix** đã có ở `tf-117` — tránh trùng, chỉ thêm knob mới |
| SC-57 … SC-62 | §9.01 – §9.05 | Test object dùng chung cho **2** component (Milestones + Workout) → test-plan phải nhân đôi hoặc nêu rõ chỉ chạy trên 1 và lý do |
| SC-63 … SC-70 | §10.01 – §10.06 + §1.03 | Nhóm **localization & nhãn** — cần bảng đối chiếu chuỗi VI (TB-07) trước khi viết case |
| SC-71 … SC-73 | §11.01 – §11.02 | **Phạm vi = UI-level only** (Q-3). Test-plan **bắt buộc** mang theo ô cảnh báo 🔒 ở nhóm K + **SC-G8**. Vẫn **giao thoa với bộ [share-template-link](../../share-template-link/)** (slug `1-2-19`, cùng build) → phải chốt **ai sở hữu**, tránh test hai lần hoặc không ai test |
| **SC-76 … SC-80** | *(không có — oracle: `component-editor.md` §11 + **O-24**)* | Test object **Regression render thật**. Test-plan **phải** ghi trong scope rằng nhóm này không có requirement trong test basis |
| **SC-81, SC-82** | *(không có — oracle: `component-editor.md` §11 + **O-24**)* | Test object **Migration**. SC-82 là **🔭 EX-4**, không viết case có expected result khi O-31 chưa trả lời |
| **SC-83, SC-84** | *(không có — oracle: `component-editor.md` §4.14 + **O-24**)* | Test object **Hiệu năng**. Phần đo định lượng là **🔭 EX-5**; test-plan nên chốt tập máy tối thiểu (O-32) |
| **SC-85 … SC-88** | *(không có — oracle: `component-editor.md` §5.07, §6.1, §6.2, §7, §10 #2 + **O-25**)* | Test object **Component mới lồng Row/Column**. SC-87 là tổ hợp rủi ro nhất — ứng viên **Decision Table** (loại component × vị trí trong container) |
| **SC-89** | *(không có — **O-29**)* | Gộp vào test object **Chia sẻ template** cùng SC-71/SC-72; **UI-level only** |
| SC-G3, SC-G8 | *(không có)* | Giữ nhãn `GAP` theo [`.claude/rules/testing.md`](../../../../.claude/rules/testing.md) — **không** sinh test case khi chưa truy được về requirement. **SC-G8 là `GAP` do descope có chủ đích**, khác loại với SC-G3 (thiếu requirement) |
| EX-1 … EX-5 | *(không có)* | **Không sinh test case có expected result.** Test-plan nên cấp **charter exploratory** (mục tiêu, thời hộp, cách ghi nhận) thay vì case scripted |
| *(loại trừ)* | §12.01 – §12.02 | Mang nguyên sang phần **scope / out-of-scope** của test-plan |

---

## 4. Câu hỏi cần làm rõ trước khi lập test plan

### 4A · Câu hỏi **từng** CHẶN — ✅ đã được **user (chủ repo)** trả lời ngày **2026-10-02**

> **Nguồn quyết định:** user trả lời trực tiếp qua `AskUserQuestion` trong phiên `/spec-intake` ngày 2026-10-02.
> **Đây là quyết định của người review, KHÔNG phải kết luận tự thân của agent.** Dev **chưa xác nhận** bất kỳ điểm nào trong số này.
> Nguyên văn câu hỏi được giữ lại bên dưới (không xoá) để truy vết; **quyết định** ghi ngay dưới mỗi câu.

**Q-1 — "Month heatmap" là gì so với `Week events → Style → Heat map`?** *(từ TB-01)*
Build 1.2.19 có component độc lập **Month heatmap** trong nhóm Calendar (*"The month, each day shaded by how busy it is."*), trong khi §8.01 mô tả **Heat map** là giá trị của knob `Style` trên **Week events**. Xin chọn **một**:
- **A** — Hai tính năng **khác nhau**: Week events **có** style `Heat map` (phạm vi tuần) **và** `Month heatmap` là component mới (phạm vi tháng). → Đợt này có **7** component mới; cần bổ sung acceptance criteria cho `Month heatmap` (SC-G1), và cho biết **icon rỗng** của nó là bug hay UI chưa xong.
- **B** — §8.01 **ghi nhầm**: thứ ship là component `Month heatmap`, Week events **không** có giá trị `Heat map`. → **Xoá** SC-48 khỏi phạm vi, SC-46 đổi thành "Style chỉ có Bars / Dots", và việc **không** thấy `Heat map` trên Week events là **đúng**, không report.
- **C** — Khác (xin mô tả).

**Ảnh hưởng:** SC-02, SC-46, SC-47, SC-48, SC-49, SC-G1 — thay đổi cả **tập condition** lẫn **expected result**.

> ✅ **QUYẾT ĐỊNH CỦA USER (2026-10-02): phương án A.**
> `Month heatmap` là **component độc lập thứ 7** (nhóm Calendar), **tách biệt** với knob `Style` (Bars / Dots / Heat map) của Week events — knob này **giữ nguyên** đúng như §8.01 mô tả.
> **Hệ quả đã áp dụng vào mục 2:** SC-46/SC-47/SC-48/SC-49 **hết chặn**, viết theo đúng §8.01 · SC-02 rate được (23 mục / 6 nhóm) · **thêm SC-74, SC-75** cho component thứ 7.
> **Phần CHƯA giải quyết:** `Month heatmap` vẫn **không có một dòng acceptance criteria nào** trong test basis → giữ **`GAP` SC-G1**, **cần dev bổ sung mô tả hành vi chi tiết** (→ **O-27**). Trạng thái icon rỗng vẫn chưa phân loại được (→ **O-28**).

**Q-2 — "Reset của thành phần" ở Workout là Reset nào?** *(từ TB-02)*
§4.05 nói *"Bấm **Reset** của thành phần → kế hoạch tập **vẫn còn**"*, nhưng bảng chỉnh có **Reset theo từng nhóm**, và với Quote thì **Content → Reset vốn xoá nội dung người dùng** ([component-editor.md](../../../specs/wallpaper-editor/wallpaper-customize/component-editor.md) §7). Xin chọn:
- **A** — **Mọi** Reset (kể cả Content) **phải giữ** kế hoạch tập → Content → Reset xoá kế hoạch là **bug mất dữ liệu**, report.
- **B** — Chỉ Reset **Position/Text** được bảo đảm; **Content → Reset xoá kế hoạch là đúng thiết kế** → không report.
- **C** — Khác (xin nêu rõ Reset nào bảo đảm điều gì).

**Ảnh hưởng:** SC-23 — hai expected result **trái ngược** trên đường dẫn **mất dữ liệu người dùng tự nhập**.

> ✅ **QUYẾT ĐỊNH CỦA USER (2026-10-02): theo đúng câu chữ §4.05 — Reset GIỮ NGUYÊN kế hoạch tập.**
> **Căn cứ user nêu:** `stack-components.md` là **test basis trực tiếp** của đợt này, **mạnh hơn** suy luận gián tiếp từ `component-editor.md` (tài liệu đối chiếu).
> **Hệ quả đã áp dụng vào mục 2:** SC-23 hết chặn, giữ **P1 / risk Rất cao**, expected result = *"kế hoạch tập vẫn còn"*.
> **Mâu thuẫn đã biết KHÔNG bị xoá:** `component-editor.md` §7 cho thấy Content → Reset vốn **xoá** nội dung tự nhập (case Quote). Vì vậy **nếu thực thi thấy kế hoạch tập bị xoá ⇒ REPORT BUG NGAY**, không được coi là "hành vi cố ý nhất quán với Quote" và **không** được sửa expected result cho khớp build. **Dev vẫn chưa xác nhận.**

**Q-3 — Yêu cầu riêng tư §11 được thực thi ở đâu, và vì sao không có trong hợp đồng API?** *(từ TB-03)*
§11.01 yêu cầu người nhận **không thấy** ngày riêng (Milestones) và sự kiện đã ghim (Event tickets), nhưng [template-sharing-api.md](../../../specs/share-template-link/template-sharing-api.md) của **cùng build 1.2.19** chỉ liệt kê strip *"selected calendars, note id, album id, rotation clock"*. Xin trả lời cả 3 ý:
- **(a) Cơ chế:** dữ liệu bị **lược bỏ khỏi payload lúc publish** (→ test bằng kiểm payload/link), hay **vẫn gửi đi nhưng ẩn lúc render** (→ test bằng UI phía nhận, và payload **vẫn chứa** dữ liệu cá nhân)?
- **(b)** `template-sharing-api.md` có **thiếu** hai mục strip này không — nếu có thì bộ test [share-template-link](../../share-template-link/) (đã READY) có cần cập nhật không?
- **(c) Oracle phía nhận:** người nhận thấy **gì** thay cho dữ liệu đã bỏ — component rỗng / placeholder / dữ liệu mẫu / component biến mất?
- **(d)** Kế hoạch tập của **Workout** (tên môn, chi tiết, emoji) cũng là dữ liệu cá nhân tự nhập — có nằm trong danh sách phải bỏ không? (§11 **không** nhắc tới — SC-G5.)

**Ảnh hưởng:** SC-71, SC-72, SC-G5 — đổi **loại** test condition (payload ↔ UI), đổi **mức nghiêm trọng** của defect, và đây là đường dẫn **rò rỉ dữ liệu cá nhân** (ISO 25010 — Security).

> ✅ **QUYẾT ĐỊNH CỦA USER (2026-10-02): chọn mức phạm vi THẤP HƠN khuyến nghị của bản phân tích — chỉ kiểm mức UI.**
> - **(a) Cơ chế → chốt phạm vi kiểm:** chỉ yêu cầu dữ liệu riêng tư **không hiển thị trên UI của người nhận**. **KHÔNG** yêu cầu kiểm payload/network có chứa dữ liệu đó hay không.
> - **(b)** *(vì sao `template-sharing-api.md` không liệt kê 2 mục strip này)* — **CHƯA trả lời**, vẫn mở.
> - **(c)** *(người nhận thấy gì thay thế)* — **CHƯA trả lời**, giữ nhãn ⚠️ trên SC-71/SC-72 (TB-03c).
> - **(d)** *(Workout weekly plan có phải bỏ không)* — **CHƯA trả lời**, giữ **`GAP` SC-G5** (→ **O-29**).
>
> **Đây là GIẢM PHẠM VI CÓ CHỦ ĐÍCH, không phải gap hay oversight.** Hệ quả đã áp dụng: SC-71/SC-72 hết chặn và thu hẹp còn **UI-level only**; **thêm `GAP` SC-G8** ghi rõ mức payload/network là **phạm vi CHƯA TEST**, để traceability **không bị hiểu nhầm** là "privacy đã test đầy đủ". Chi tiết ở ô cảnh báo 🔒 cuối nhóm K (mục 2).

### 4A-2 · Đợt trả lời thứ **2** — ✅ 6 câu hỏi mở đã được **user** quyết định **2026-10-02**

> **Nguồn:** user trả lời qua `AskUserQuestion`. **Quyết định của người review — KHÔNG phải kết luận của agent, KHÔNG phải xác nhận kỹ thuật từ dev.**

| # | Quyết định của user | Loại quyết định | Hệ quả đã áp dụng |
|---|---|---|---|
| **O-1** | Test theo **đúng checklist hiện có**; phần chi tiết sâu hơn (font, dữ liệu, giá trị biên) **ngoài phạm vi scripted** → Exploratory | Chốt độ sâu phạm vi | **🔭 EX-1**; nhóm B–G giữ nguyên mức chi tiết hiện tại |
| **O-7** | **SC-12 → Exploratory**, gỡ nhãn chặn. Lý do: **thiếu dữ kiện thật**, không phải ambiguity 2 cách hiểu | Đổi cách tiếp cận test | **🔭 EX-2**; SC-12 giữ **P1** nhưng không có script cố định |
| **O-27** | **`Month heatmap` → Exploratory**, cùng lý do O-7 | Đổi cách tiếp cận test | **🔭 EX-3**; **`GAP` SC-G1 đóng**; scripted vẫn giữ SC-74/SC-75 |
| **O-24** | Regression · migration · hiệu năng **CÓ** nằm trong phạm vi | **Mở rộng phạm vi** | **+10 condition**: nhóm **M** (SC-76…80), **N** (SC-81, 82), **O** (SC-83, 84) |
| **O-25** | Component mới lồng **Row/Column** **CÓ** nằm trong phạm vi | **Mở rộng phạm vi** | **+4 condition**: nhóm **P** (SC-85…88) |
| **O-29** | Workout plan **CÓ** ẩn khi share, giống Milestones/Event tickets | **Mở rộng phạm vi** | **+1 condition**: **SC-89** (UI-level theo Q-3); **`GAP` SC-G5 đóng** |

> ### 🚩 Điều QC **phải** báo lại, không được im lặng chấp nhận
>
> Căn cứ user viện dẫn cho O-24/O-25 — *"vùng ảnh hưởng là toàn bộ wallpaper lịch: bản render thật trên màn khoá, Live Activity, widget và thumbnail đều ăn theo dữ liệu mà màn này ghi ra"* — được mô tả là **"câu mở đầu của chính `stack-components.md`"**.
>
> **QC đã kiểm chứng và điều này KHÔNG đúng:** câu đó nằm ở **[`component-editor.md`](../../../specs/wallpaper-editor/wallpaper-customize/component-editor.md) dòng 7–9** (tài liệu **đối chiếu**), **không** có trong test basis. Câu mở đầu thật của `stack-components.md` chỉ liệt kê phạm vi *"6 component mới … knob mới … icon trang trí, nhãn bảng chỉnh, ô emoji"* — **không nhắc** lock screen, Live Activity, widget hay thumbnail.
>
> **QC VẪN ÁP DỤNG quyết định phạm vi của user** (phạm vi là quyền của user), nhưng ghi đúng nguồn gốc: **nhóm M–P không có requirement trong test basis**, oracle là tài liệu đối chiếu + quyết định của user. Đây đúng tiền lệ **nhóm R/S của bộ `tf-117`**. Nếu user dựa vào một tiền đề sai mà đáng lẽ sẽ quyết định khác, xin **xem lại** — QC không tự đảo quyết định.

### 4B · Câu hỏi MỞ (33 câu) — không thuộc nhóm "bắt buộc dừng", nhưng **vẫn giữ tài liệu ở `DRAFT`**

> **Cập nhật 2026-10-02 — đợt trả lời thứ 2 của user:** ✅ **O-1 · O-7 · O-24 · O-25 · O-27 · O-29 đã được trả lời** (chi tiết: mục 4A-2). Phát sinh **4 câu mới: O-30 … O-33**.
>
> ⚠️ **Các câu còn lại KHÔNG được coi là đã đóng.** Phân mức:
> - **Còn làm đổi ORACLE / expected result** → **O-30** *(component nào được hỗ trợ trong Live Activity/widget)* · **O-31** *(xác nhận EX-4)* · **O-32** *(ngưỡng hiệu năng)* · **O-33** *(SC-36/SC-62 có chuyển Exploratory không)* · **O-23** *(chưa có baseline ảnh)*.
> - **Chỉ làm giảm ĐỘ CHÍNH XÁC** (thiếu giá trị biên, thiếu oracle định lượng, thiếu chuỗi VI…) → mang sang `test-plan` dưới dạng nhãn ⚠️ trên condition tương ứng: các câu còn lại.

| # | Câu hỏi | Từ | Ảnh hưởng |
|---|---|---|---|
| **O-1** ✅ | Tài liệu `docs/components/new-components.md` ở đâu? Liên kết trong test basis **hỏng** (không có file trong repo). Checklist này có phải acceptance criteria **đầy đủ** không? | TB-04 | ✅ **ĐÃ TRẢ LỜI (user 2026-10-02):** scripted **bám đúng checklist `stack-components.md`**; phần chi tiết sâu hơn (font, dữ liệu, giá trị biên) → **ngoài phạm vi scripted**, chuyển **🔭 EX-1**. **Không chặn pipeline.** |
| **O-2** | **Build / version / ticket** nào là đối tượng test? Bảng máy & phiên bản iOS bắt buộc? | TB-05 | Entry criteria của test-plan |
| **O-3** | "**Light và Dark**" ở §1.03 là knob **Color tone** trong Customize, hay chế độ sáng/tối của **hệ điều hành**? | TB-06 | Ma trận môi trường của **toàn bộ** mục 2 |
| **O-4** | Bảng đối chiếu **tên knob tiếng Việt** cho 22+ knob mới? | TB-07 | Khả năng thực thi mọi condition có thao tác knob |
| **O-5** | **Dải giá trị** của `Days` (Agenda) và `Events per day` — min / max / bước nhảy? | TB-08 | SC-06, SC-07 (thiết kế BVA) |
| **O-6** | Điều kiện nào kích hoạt "**hết chỗ dọc**" của Agenda (chiều cao band? số sự kiện?) | TB-09 | SC-08 (tái lập được hay không) |
| **O-7** ✅ | Hành động "**ghim**" sự kiện nằm ở đâu? Giới hạn số lượng? Sự kiện đã ghim **trôi qua / bị xoá** thì vé hiện gì? | TB-10 | ✅ **ĐÃ TRẢ LỜI (user 2026-10-02):** chuyển **SC-12 → 🔭 EX-2**, gỡ nhãn chặn. Lý do: **thiếu dữ kiện thật, không phải ambiguity 2 cách hiểu** — tester tự tìm đường vào trong lúc test. |
| **O-8** | Ngưỡng "**chữ đọc được**" trên vé (contrast ratio?) + ảnh nền mẫu để chạy? | TB-11 | SC-14, SC-16 |
| **O-9** | Định nghĩa "**ngày rảnh**" (Daily page) và **nguồn** câu trích dẫn? | TB-12 | SC-25 |
| **O-10** | **Danh sách đầy đủ** các vùng mặc định bật `Lunar date`, và căn cứ là **Region / Language / calendar identifier**? | TB-13 | SC-27 |
| **O-11** | Cách dựng tình huống **DST** trên máy test (vùng + ngày mẫu, có được đổi giờ hệ thống không)? | TB-14 | SC-32 |
| **O-12** | Thuật toán tính "**giờ rảnh**" (khoảng giờ xét, sự kiện cả ngày, ngưỡng khoảng trống tối thiểu)? | TB-15 | SC-33 |
| **O-13** | Xoá trắng tên một ngày **đã tồn tại** (Milestones) rồi đóng sheet → giữ lại dạng "Untitled" hay **xoá**? | TB-16 | SC-36 (`GAP`) |
| **O-14** | **Card palette**: xoay vòng bắt đầu từ đâu khi **không có** thẻ "hôm nay", hoặc thẻ hôm nay là thẻ **cuối**? | TB-17 | SC-41 |
| **O-15** | **Month progress → Custom**: hành vi khi `end ≤ start`? "+90 ngày" có tính cả hôm nay? | TB-18 | SC-50, SC-52, SC-G3 |
| **O-16** | **Thang ánh xạ** số sự kiện → độ đậm ô ở Heat map (mấy mức, trần, màu khi 0 sự kiện)? | TB-19 | SC-48 |
| **O-17** | Tên đúng của control là **Block opacity** hay **Fill opacity**, **+N more** hay **Show +N**? Nó nằm trong **More options** hay ngoài? | TB-20 | SC-49, SC-64 |
| **O-18** | Máy tắt bàn phím Emoji → người dùng **nhập bằng cách nào**? Có hiện gợi ý/thông báo không? **Dán (paste)** có được chấp nhận? | TB-21 | SC-61, SC-62 |
| **O-19** | **Emoji mặc định** (placeholder) của Milestones và của Workout là ký tự nào? | TB-22 | SC-59 |
| **O-20** | §10.02 "không hai dòng trùng tên" — khoanh vùng component nào cần quét, hay có danh sách tên chuẩn? | TB-23 | SC-64 |
| **O-21** | **Chuỗi kỳ vọng** cho ô Drop ở de / it / ru? Có bắt buộc test đủ **3** ngôn ngữ này không (§1.03 chỉ yêu cầu DE **hoặc** JA)? | TB-24 | SC-68, SC-70 |
| **O-22** | **Days shown** trên máy có ngày đầu tuần là **Chủ nhật** — nhãn và hành vi? | TB-25 | SC-66 |
| **O-23** | Có **baseline hình ảnh** nào cho 6 component mới đã render không (hiện repo chỉ có 3 ảnh sheet Add)? Nếu không, QC cần chụp bổ sung trước khi chạy. | TB-26 | Mọi condition về bố cục/màu |
| **O-24** ✅ | **Regression & migration & hiệu năng** có nằm trong phạm vi đợt này không? | TB-27 | ✅ **ĐÃ TRẢ LỜI (user 2026-10-02): CÓ** → sinh **nhóm M** (SC-76…80), **N** (SC-81, 82), **O** (SC-83, 84). ⚠️ Căn cứ user viện dẫn **nằm ở `component-editor.md`, KHÔNG phải test basis** — xem cảnh báo nguồn gốc ở đầu nhóm M–P |
| **O-25** ✅ | Component mới đặt **trong Row / Column** có thuộc phạm vi đợt này không? | TB-27 | ✅ **ĐÃ TRẢ LỜI (user 2026-10-02): CÓ** → sinh **nhóm P** (SC-85 … SC-88) |
| **O-26** | 3 condition §11 (share) thuộc **bộ test nào** — đợt này hay bộ [share-template-link](../../share-template-link/) slug `1-2-19` (cùng build)? | TB-03 | SC-71, SC-72, SC-73 — tránh test trùng hoặc bỏ sót |
| **O-27** ✅ | **Hành vi chi tiết của `Month heatmap`**: thang ánh xạ số sự kiện → độ đậm ô, phạm vi tháng, knob riêng, **khác gì** so với `Week events → Heat map` (tuần) và `Activity grid`? | Q-1 = A | ✅ **ĐÃ TRẢ LỜI (user 2026-10-02):** chuyển **🔭 EX-3**, cùng lý do O-7 (thiếu dữ kiện, không phải ambiguity). Scripted giữ nguyên SC-74/SC-75; **SC-G1 đóng** |
| **O-28** 🆕 | **Icon của `Month heatmap` đang trống** trong sheet Add (ảnh batch 8) — là **bug** hay **UI chưa xong**? §12 "chưa làm — không report" **không** liệt kê component này. | Q-1 = A | SC-75 — quyết định report hay không |
| **O-29** ✅ | **Ý (d) của Q-3:** kế hoạch tập của **Workout** (tên môn, chi tiết, emoji) có phải **không hiển thị** cho người nhận khi share không? | Q-3 (chưa trọn) | ✅ **ĐÃ TRẢ LỜI (user): CÓ** → **SC-89** |
| **O-30** 🆕 | **Component mới nào được hỗ trợ trong Live Activity / widget / thumbnail?** Cả 7, hay chỉ một số? `Event tickets`, `Workout`, `Milestones` có render được ở các bề mặt đó không — và nếu **không** xuất hiện thì đó là đúng hay là bug? | O-24 (phạm vi mới) | **SC-77, SC-78** — thiếu oracle để phân loại pass/fail |
| **O-31** ✅ | **SC-82 (migration ngược)** — xử lý như **Exploratory 🔭 EX-4**? | O-24 (phạm vi mới) | ✅ **ĐÃ TRẢ LỜI (user 2026-10-03): XÁC NHẬN** — EX-4, **không viết script cố định**. Expected result vẫn **không có** → không chứng minh được pass |
| **O-32** 🆕 | **Tiêu chí hiệu năng định lượng** (fps, ngưỡng frame drop, thời gian render tối đa) và **tập máy tối thiểu** phải chạy? | O-24 (phạm vi mới) | **SC-83, SC-84** — hiện chỉ đánh giá cảm nhận |
| **O-33** ✅ | **SC-36** và **SC-62** có áp dụng **cùng cách xử lý Exploratory 🔭** để gỡ nốt 2 nhãn ⛔ cuối cùng không? | O-13, O-18 | ✅ **ĐÃ TRẢ LỜI (user 2026-10-03): CÓ** → **🔭 EX-6** (SC-36, P1) và **🔭 EX-7** (SC-62, P3); **0 dòng ⛔ còn lại**. Lỗ oracle gốc (O-13, O-18) **vẫn còn nguyên** |

---

## 5. Trạng thái

### 5.1 · Trạng thái hiện tại *(chốt 2026-10-03, sau **đợt trả lời thứ 3** + tuyên bố của user)*

| | |
|---|---|
| **Analysis Status** | ✅ **`READY` — CÓ ĐIỀU KIỆN** |
| **Downstream Permission** | ✅ **`ALLOWED` — CÓ ĐIỀU KIỆN** — **được phép chạy `test-plan`** cho slug `stack-components`, **với đúng 4 điều kiện** ở mục 5.2 |
| **Ai quyết định** | **User / chủ repo**, tuyên bố ngày **2026-10-03**, kèm xác nhận **chấp nhận đủ 4 điều kiện**. Theo [`.claude/rules/testing.md`](../../../../.claude/rules/testing.md), đây là **quyền của người review**; agent **không** tự nâng trạng thái và **không** coi đây là bằng chứng kỹ thuật từ dev. |
| **Vì sao không còn `BLOCKED`** | Không còn câu hỏi nào thuộc **4 lý do dừng bắt buộc** của skill: không có ambiguity 2 cách hiểu làm đổi tập condition · không có mâu thuẫn nội bộ chưa xử lý về cùng một hành vi · **mọi** condition đã gán được risk likelihood × impact (0 dòng chưa rate) · test basis **có** acceptance criteria (là checklist, không phải user story trống). |
| **Vì sao không còn `DRAFT`** | **Không còn dòng ⛔ nào.** Toàn bộ vùng "thiếu dữ kiện" đã được user xử lý tường minh — hoặc **đưa vào phạm vi** (O-24, O-25, O-29), hoặc **chuyển Exploratory** (O-1, O-7, O-27, O-31, O-33), hoặc **descope có chủ đích** (Q-3). Ba câu còn làm đổi oracle (**O-23, O-30, O-32**) được user **chấp nhận mang sang `test-plan` dưới nhãn ⚠️** — đúng mô hình bộ [`tf-117`](test-analysis-tf-117.md). |
| **"Có điều kiện" nghĩa là gì** | **KHÔNG** có nghĩa mọi câu hỏi đã hết. Nghĩa là: 4 điều kiện ở **5.2** là **ràng buộc bắt buộc** đi kèm quyền chạy `test-plan`; bỏ bớt bất kỳ điều kiện nào thì quyền này **không còn hiệu lực**. |

### 5.2 · ✅ 4 điều kiện của trạng thái `READY` — **user đã chấp nhận 2026-10-03**, `test-plan` PHẢI mang theo đủ

1. **Nhóm M · N · O · P (14 condition: SC-76 … SC-88) KHÔNG có requirement trong test basis** — oracle là [`component-editor.md`](../../../specs/wallpaper-editor/wallpaper-customize/component-editor.md) (tài liệu **đối chiếu**) + quyết định phạm vi của user. Phải ghi rõ trong phần scope của test-plan. Xem 🚩 cảnh báo nguồn gốc ở mục **4A-2**.
2. **7 vùng Exploratory (EX-1 … EX-7) KHÔNG có expected result** ⇒ **KHÔNG chứng minh được pass**. Báo cáo kết quả **bắt buộc tách bạch** "scripted" và "exploratory"; **cấm** gộp thành một con số độ phủ duy nhất. Liên quan **7 condition**: SC-12, SC-36, SC-62, SC-74/75 *(phần sâu)*, SC-82, SC-83 *(phần đo)*.
3. **Privacy chỉ ở mức UI** (Q-3 + O-29) — mức payload/network là **`SC-G8`, CHƯA TEST**. **Cấm** phát biểu "privacy đã test đầy đủ".
4. **Q-1, Q-2, Q-3 + 8 quyết định của đợt 2 và 3 đều là quyết định của USER, dev CHƯA xác nhận** — không nâng thành fact. Riêng **SC-23** phải mang theo nguyên ô ghi chú *"thấy kế hoạch tập bị xoá ⇒ report BUG"*.

> **Nếu `test-plan` bỏ bớt bất kỳ điều kiện nào ở trên, quyền chạy downstream không còn hiệu lực** — phải quay lại hỏi người review.

### 5.3 · Lịch sử trạng thái *(giữ để truy vết)*

| Ngày | Trạng thái | Lý do |
|---|---|---|
| 2026-10-02 (lần lập đầu) | **`BLOCKED`** | Q-1 *(Month heatmap: component độc lập hay giá trị knob — 2 tập condition khác nhau)* · Q-2 *(Reset Workout — 2 expected result trái ngược trên đường dẫn mất dữ liệu)* · Q-3 *(riêng tư §11 — 2 cách hiểu + mâu thuẫn với `template-sharing-api.md` + thiếu oracle, đường dẫn rò rỉ dữ liệu cá nhân)*. |
| 2026-10-02 (đợt trả lời **1**) | **`DRAFT`** | 3 câu chặn đã được user quyết định (Q-1 = A · Q-2 = theo câu chữ test basis · Q-3 = descope xuống UI-level). Còn **29 câu hỏi mở** và **8 `GAP`**, trong đó O-1/O-7/O-24/O-25/O-27 còn làm đổi **phạm vi và oracle**. |
| 2026-10-02 (đợt trả lời **2**) | **`DRAFT`** *(giữ nguyên)* | 6 câu mở đã được user quyết định (O-1, O-7, O-24, O-25, O-27, O-29): phạm vi **mở rộng +14 condition** (71 → 87), `GAP` **8 → 2**, thêm **5 vùng Exploratory**. **Vẫn `DRAFT`** vì: (a) agent **bị cấm tự chuyển `DRAFT → READY`** và người review chưa tuyên bố đổi trạng thái; (b) phát sinh **O-30 … O-33** còn làm đổi oracle/expected result. |
| **2026-10-03 (đợt trả lời 3)** | ✅ **`DRAFT` → `READY` (có điều kiện)** | **Lần đầu tiên trạng thái đổi sang `READY`.** **Chuyển bởi USER / chủ repo bằng tuyên bố tường minh — KHÔNG phải agent tự nâng** (agent bị cấm theo [`.claude/rules/testing.md`](../../../../.claude/rules/testing.md)). Căn cứ: **O-33** *(SC-36, SC-62 → Exploratory, gỡ nốt 2 nhãn ⛔)* + **O-31** *(xác nhận SC-82 = EX-4)* + **user chấp nhận đủ 4 điều kiện** ở mục 5.2. Ba câu **O-23 / O-30 / O-32** được user đồng ý mang sang `test-plan` dưới nhãn ⚠️ thay vì chặn — đúng mô hình bộ [`tf-117`](test-analysis-tf-117.md). Kết quả: **0 dòng ⛔**, 87 condition (P1 44 · P2 24 · P3 19), 2 `GAP`, 7 Exploratory. |

### 5.4 · Trạng thái của giả định *(assumption ≠ fact)*

**Tài liệu này KHÔNG tạo assumption nào từ phía agent.** Tuy nhiên sau đợt trả lời 2026-10-02 đã xuất hiện **3 quyết định của user** — chúng là **quyết định diễn giải / phạm vi**, **KHÔNG phải xác nhận kỹ thuật từ dev:

| | Nội dung | Trạng thái |
|---|---|---|
| **Q-1 = A** | `Month heatmap` là component độc lập thứ 7 | **Quyết định của user** — dev **chưa** xác nhận |
| **Q-2** | Reset Workout giữ nguyên kế hoạch tập | **Quyết định của user** — dev **chưa** xác nhận; **mâu thuẫn với `component-editor.md` vẫn còn nguyên** |
| **Q-3** | Privacy chỉ kiểm mức UI | **Descope có chủ đích của user** — mức payload **chưa test** (SC-G8) |
| **O-1 · O-7 · O-27** | Thiếu dữ kiện → Exploratory thay vì chặn | **Quyết định cách tiếp cận test của user** — các vùng này **vẫn không có oracle** |
| **O-24 · O-25** | Regression · migration · hiệu năng · lồng Row/Column **nằm trong phạm vi** | **Mở rộng phạm vi của user** — ⚠️ căn cứ viện dẫn **nằm ở `component-editor.md`, không phải test basis** (xem 🚩 mục 4A-2) |
| **O-29** | Workout plan ẩn khi share | **Mở rộng phạm vi của user** — §11 **không** nhắc tới Workout; dev chưa xác nhận |
| **O-31 · O-33** | SC-82, SC-36, SC-62 → Exploratory | **Quyết định cách tiếp cận test của user** — 3 vùng này **vẫn không có oracle**; "không có ⛔" ≠ "đã có câu trả lời" |
| **Trạng thái `READY`** | Chấp nhận 4 điều kiện, chuyển `DRAFT → READY` | **Tuyên bố của user 2026-10-03** — **không** phải kết luận của agent, **không** phải xác nhận kỹ thuật từ dev |

**Không được nâng bất kỳ mục nào ở trên thành fact.** Nếu dev trả lời khác → chỉ các condition tương ứng phải viết lại:
Q-1 → SC-02/46/47/48/49/74/75 · Q-2 → SC-23 · Q-3 → SC-71/72/G8 · O-1/O-7/O-27 → EX-1/EX-2/EX-3 · **O-24/O-25 → gỡ toàn bộ SC-76 … SC-88** · O-29 → SC-89 · O-31/O-33 → EX-4/EX-6/EX-7 *(SC-82, SC-36, SC-62 quay lại thành condition scripted nếu dev cấp expected result)*.

Bối cảnh nền từ bộ `tf-117` (bao gồm các giả định A-1 … A-16 **dev vẫn chưa xác nhận**) **không** được kế thừa như fact vào tài liệu này.

---

## 6. Hồ sơ câu trả lời — đợt 2026-10-02

> Slug này **không có file `answers-*.md` riêng**; hồ sơ câu trả lời được ghi **ngay trong tài liệu này** (mục 4A + bảng dưới) để test-analysis vẫn là nguồn duy nhất cho `test-plan`.

| # | Câu hỏi | Quyết định (user, 2026-10-02) | Loại quyết định | Condition bị ảnh hưởng | Phần CHƯA được giải quyết |
|---|---|---|---|---|---|
| **Q-1** | `Month heatmap` vs `Week events → Heat map` | **A** — hai tính năng **khác nhau**; `Month heatmap` là component **độc lập thứ 7** (nhóm Calendar); knob `Style` của Week events **giữ nguyên** 3 giá trị | Diễn giải test basis | SC-02, SC-46, SC-47, SC-48, SC-49 *(hết chặn)*; SC-74, SC-75 *(mới)* | **Hành vi chi tiết** của `Month heatmap` → `GAP` **SC-G1** / **O-27**; icon rỗng → **O-28** |
| **Q-2** | "Reset của thành phần" ở Workout | **Theo đúng câu chữ §4.05** — kế hoạch tập **giữ nguyên**. Căn cứ: test basis trực tiếp > suy luận gián tiếp từ tài liệu đối chiếu | Diễn giải test basis | SC-23 *(hết chặn, P1)* | Mâu thuẫn với `component-editor.md` **vẫn còn**; dev chưa xác nhận → thấy kế hoạch bị xoá thì **report BUG** |
| **Q-3** | Riêng tư §11 khi share | **Giảm phạm vi có chủ đích** — chỉ kiểm **UI của người nhận**, **không** kiểm payload/network | **Descope phạm vi** *(thấp hơn khuyến nghị của bản phân tích)* | SC-71, SC-72 *(hết chặn, thu hẹp)* | Ý **(b)** API spec thiếu? · ý **(c)** người nhận thấy gì thay thế? — **vẫn mở**. Ý **(d)** đã trả lời ở đợt 2 (→ O-29) |

### Đợt trả lời **2** — 2026-10-02 *(6 câu hỏi mở)*

| # | Câu hỏi | Quyết định (user) | Loại quyết định | Condition bị ảnh hưởng | Phần CHƯA được giải quyết |
|---|---|---|---|---|---|
| **O-1** | `new-components.md` không tồn tại | Scripted bám **đúng checklist**; chi tiết sâu hơn → **Exploratory** | Chốt độ sâu phạm vi | 🔭 **EX-1** (nhóm B–G) | Tài liệu vẫn **không tồn tại**; EX-1 **không có oracle** |
| **O-7** | Đường vào "ghim" (Event tickets) | **SC-12 → Exploratory**; thiếu dữ kiện ≠ ambiguity | Đổi cách tiếp cận test | 🔭 **EX-2** / SC-12 (P1) | Đường vào vẫn chưa biết; **không chứng minh được pass** |
| **O-27** | Hành vi `Month heatmap` | **→ Exploratory**, cùng lý do O-7 | Đổi cách tiếp cận test | 🔭 **EX-3** / SC-74, SC-75 | Vẫn **0 dòng acceptance criteria**; **O-28** (icon rỗng) vẫn mở |
| **O-24** | Regression · migration · hiệu năng | **CÓ** trong phạm vi | **Mở rộng phạm vi** | **SC-76 … SC-84** (nhóm M, N, O) | 🚩 **căn cứ viện dẫn sai nguồn** (mục 4A-2) · **O-30** (bề mặt nào hỗ trợ) · **O-31** (EX-4) · **O-32** (ngưỡng hiệu năng) |
| **O-25** | Component mới lồng Row/Column | **CÓ** trong phạm vi | **Mở rộng phạm vi** | **SC-85 … SC-88** (nhóm P) | Không có criteria riêng cho component mới trong container |
| **O-29** | Workout plan khi share | **CÓ** ẩn, giống Milestones/Event tickets | **Mở rộng phạm vi** | **SC-89** (P1, UI-level) | Vẫn **UI-level only**; mức payload → **SC-G8** |

### Đợt trả lời **3** — 2026-10-03 *(2 câu cuối + tuyên bố trạng thái)*

| # | Câu hỏi | Quyết định (user) | Loại quyết định | Condition bị ảnh hưởng | Phần CHƯA được giải quyết |
|---|---|---|---|---|---|
| **O-33** | SC-36, SC-62 có chuyển Exploratory không | **CÓ** — gỡ nhãn ⛔ | Đổi cách tiếp cận test | 🔭 **EX-6** (SC-36, P1) · 🔭 **EX-7** (SC-62, P3) | **Lỗ oracle gốc vẫn còn**: O-13 (xoá trắng tên mốc ngày đã tồn tại) và O-18 (paste/dictation) **chưa có câu trả lời từ dev** |
| **O-31** | SC-82 (migration ngược) = EX-4? | **XÁC NHẬN** — Exploratory, không script cố định | Đổi cách tiếp cận test | 🔭 **EX-4** / SC-82 (P1) | Vẫn **không có expected result** cho migration ngược |
| **Trạng thái** | Chuyển `DRAFT → READY`? | ✅ **`READY` — CÓ ĐIỀU KIỆN**, kèm **chấp nhận đủ 4 điều kiện** ở mục 5.2 | **Tuyên bố trạng thái của người review** | Toàn tài liệu · mở khoá `test-plan` | **O-23** (thiếu baseline ảnh) · **O-30** (bề mặt nào hỗ trợ component mới) · **O-32** (ngưỡng hiệu năng) — mang sang test-plan dưới nhãn ⚠️, **không** coi là đã đóng |

> ### 📌 Ghi nhớ cho mọi tài liệu downstream
>
> `READY — có điều kiện` ở đây **không** có nghĩa là test basis đã sạch. Nó có nghĩa: **người review đã quyết định rằng phần chưa rõ còn lại là chấp nhận được**, với **4 điều kiện ràng buộc** (mục 5.2) và **3 câu hỏi ⚠️ mang theo** (O-23, O-30, O-32).
> **27 vấn đề testability ở mục 1 vẫn còn nguyên trong test basis** — không vấn đề nào được "sửa", chúng chỉ được **quyết định cách xử lý**.
