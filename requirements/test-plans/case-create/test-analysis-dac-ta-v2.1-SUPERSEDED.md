# Test Analysis — Tạo vụ việc xử lý vi phạm (XL01, flow `03_case-create`) — theo đặc tả v2.1

> ⚠️ SUPERSEDED — không dùng tài liệu này làm test basis.
> Thay bằng [test-analysis-dac-ta-v2.1-lam-ro-10-28.md](test-analysis-dac-ta-v2.1-lam-ro-10-28.md) (2026-10-28). Lý do: bản làm rõ [lam-ro-2026-10-27.md](../../specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-27.md) đổi nghiệp vụ lớn — cán bộ hiện trường / Phòng Camera được tạo vụ việc và bàn giao cho Đội (kể cả quét QR), không chọn hạn, trạng thái vụ việc mới, người nhận cảnh báo Khẩn cấp mới, phạm vi vai trò thu về 2 nhóm. Các kết luận về quyền "cán bộ không tạo được vụ việc" trong tài liệu này **đã sai**.

> **Analysis Status: READY** (cập nhật lần 4, 2026-10-26) — được phép chạy test-plan. Căn cứ: (1) QB1, QB2, QB3 đã được QC lead trả lời → không còn câu hỏi chặn; (2) **quyết định của QC lead ngày 2026-10-26** "Chấp nhận cả hai, chạy tiếp" ([lam-ro-2026-10-26.md](../../specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-26.md), mục "Quyết định của QC lead về trạng thái test-analysis-dac-ta-v2.1"): **chấp nhận căn cứ risk A1/A2 (QO24 đóng)** và **cho mang 29 câu hỏi mở còn lại sang test-plan** dưới dạng "kết quả mong đợi còn mở" → mục 4 không còn câu hỏi nào phải làm rõ *trước khi* lập test plan. Các câu hỏi mở **vẫn còn hiệu lực** và được liệt kê đầy đủ ở **mục 5** — test-plan phải mang theo, không coi là đã trả lời. **QO25 (⚑ suy ra) không dùng làm tiêu chí đạt/không đạt** cho tới khi được xác nhận.

> **Test basis (theo thứ tự ưu tiên khi mâu thuẫn — QC lead chốt 2026-10-26):**
> 1. [dac-ta-chuc-nang-v2.1.md](../../specs/xu-ly-vi-pham-giao-viec/dac-ta-chuc-nang-v2.1.md) — XL01 và các phần áp dụng cho XL01: §1.2, §2.4 Tính năng 1, §3, §4.1–4.2, §8, §9, §10, CH07, Phụ lục A/B/C.
> 2. [lam-ro-2026-10-26.md](../../specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-26.md) — đặc biệt mục "Đối chiếu với đặc tả v2.1": L2b đã thay theo đặc tả, L3a(a) đã bỏ, L3a(b) giữ, L4 giữ. **Cập nhật lần 2:** mục "Trả lời câu hỏi chặn của test-analysis-dac-ta-v2.1" (QB1(a)–(d), QB2) và "Quyết định cho QB1(d)". Riêng QB1(d) (người nhận cảnh báo Khẩn cấp) **khác đặc tả [B7]** — QC lead quyết định dùng câu trả lời này làm test basis (ngoại lệ có chủ đích với thứ tự ưu tiên ở trên).
> 3. [mo-ta-chuc-nang-v1.md](../../specs/xu-ly-vi-pham-giao-viec/mo-ta-chuc-nang-v1.md) (ảnh `images/hinh-NN.png`) — chỉ dùng khi đặc tả không nói.
>
> **Thay cho:** [test-analysis-mo-ta-v1-SUPERSEDED.md](test-analysis-mo-ta-v1-SUPERSEDED.md) (SUPERSEDED). Mã câu hỏi của đợt cũ được trích là "TA-mo-ta-v1 Bn/On"; mã quyết định của khách hàng trong đặc tả được trích là "đặc tả [Bn]".
> **Phạm vi:** XL01 và hậu điều kiện của nó (tab Tiếp nhận/Của tôi, phần việc Đã giao, thông báo, nhắc việc, nhật ký). XL02–XL05, GV, CH01–CH06 chỉ nêu **ảnh hưởng chéo**. Trang quản trị web ngoài phạm vi (§1.2, [Q37*]) — những gì XL01 cần từ đó (danh mục, uỷ quyền, khu vực phụ trách) chỉ là tiền điều kiện / dữ liệu kiểm thử.
> **Nền tảng:** chỉ iPhone (L4) — xem QO23 về chênh lệch với đặc tả §10.
> **Chuẩn:** ISTQB Foundation Level v4.0.1 §1.4.1 (Test Analysis) + §3 (Static Testing) + §5.2 (Risk Management)
> **Bước tiếp theo:** [test-plan](../../../.claude/skills/test-plan/SKILL.md) dùng mục 2 (test condition) làm test object và cột risk level làm cơ sở mục 6 — **sẵn sàng chạy**. Test-plan phải mang theo các câu hỏi mở ở **mục 5** dưới dạng expected result còn mở (theo quyết định QC lead 2026-10-26), và không dùng partition ⚑ suy ra (QO25) làm tiêu chí đạt/không đạt.
> **Ngày lập:** 2026-10-26 · **Cập nhật lần 2:** 2026-10-26 (áp dụng trả lời QB1, QB2) · **Cập nhật lần 3:** 2026-10-26 (áp dụng trả lời QB3) · **Cập nhật lần 4:** 2026-10-26 (quyết định QC lead: chấp nhận A1/A2, mang câu hỏi mở sang test-plan → READY) · **Người lập:** QC

### Quy ước dùng trong tài liệu

- **Ký hiệu nguồn:** `§n` = mục của đặc tả v2.1; `XL01-Bn` = bước n trong bảng "Các bước nhập" của XL01; `TN1-An` = bước n bảng A Tính năng 1 (§2.4); `BRnn` = quy tắc §9; `đặc tả [Qn]`/`[Bn]` = quyết định của khách hàng (Phụ lục A/B); `PL-C #n` = Phụ lục C; `L…` = file làm rõ; `[Ảnh Hn]` = ảnh của spec cũ.
- **`[B25*]`, `[B27*]`, `[Q37*]` là giả định chưa được khách hàng xác nhận** — không dùng như fact. Test condition phụ thuộc vào chúng được đánh dấu **⚑ phụ thuộc giả định**. **[B25*] đã được thay** bằng trả lời QB2 (khu vực gán cho Đội, áp dụng mọi vai trò người giao) — không còn test condition nào dựa vào [B25*].
- `QB1(x)` / `QB2` = câu trả lời của QC lead ở `lam-ro` (cập nhật lần 2). Điểm orchestrator ghi là "*suy ra, cần xác nhận khi chạy*" **không** dùng như fact — đánh dấu **⚑ suy ra**.
- Mục đặc tả ghi **(suy ra)** hoặc căn cứ "suy ra" (ví dụ BR09, một phần BR11) cần khách hàng xác nhận khi nghiệm thu (§1.4) — test condition dựa vào đó được ghi chú.
- **Dữ liệu cá nhân:** ảnh trong spec có dữ liệu thật — tài liệu này chỉ dùng tên trường, không chép họ tên, số giấy tờ, ngày sinh, email, mã cán bộ.
- **Thang risk (định tính, §5.2):** Cao×Cao, Cao×Vừa, Vừa×Cao → **Cao (P1)** · Vừa×Vừa, Thấp×Cao, Cao×Thấp → **Vừa (P2)** · Vừa×Thấp, Thấp×Vừa, Thấp×Thấp → **Thấp (P3)**. "Chưa xếp hạng" = phụ thuộc câu hỏi chặn ở mục 4.1 (cập nhật lần 3 trở đi: không còn test condition chưa xếp hạng).
- Mã test condition `TC-nn` của tài liệu này **đánh số lại từ đầu**, không trùng nghĩa với `TC-nn` của TA-mo-ta-v1.

### Giả định (KHÔNG phải fact)

> **Cập nhật lần 4:** QC lead đã **chấp nhận A1, A2 làm căn cứ risk** (2026-10-26, [lam-ro](../../specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-26.md) — QO24 đóng). A1, A2 vẫn là giả định đã được chấp thuận, không phải dữ liệu đo được; nếu sau này có lịch sử lỗi hoặc đánh giá business impact thì cần xếp hạng lại.

| # | Giả định | Vì sao cần | Câu hỏi liên quan |
|---|---|---|---|
| A1 | **Risk likelihood** ở mục 2 là ước lượng của QC theo độ phức tạp kỹ thuật (nhận dạng giấy tờ trên thiết bị, chọn nhiều, ràng buộc ngày giờ, phân quyền nhiều vai trò, đồng bộ nhiều tài khoản) — dự án chưa có lịch sử lỗi, chưa có thông tin kiến trúc. (Giữ nguyên A1 của TA-mo-ta-v1.) | §5.2 cần căn cứ likelihood. | QO24 |
| A2 | **Risk impact** suy từ mục tiêu nghiệp vụ §2.1 ("không thiếu thông tin trong quá trình giao nhận"), tính nhạy cảm của dữ liệu đối tượng (§8.1 "dữ liệu cá nhân nhạy cảm"), và việc dữ liệu XL01 được dùng lại ở biên bản (XL03), thống kê (CH05), báo cáo (CH06). Đặc tả v2.1 cho căn cứ impact tốt hơn spec cũ nhưng vẫn chưa có đánh giá business impact trực tiếp từ khách hàng. | §5.2 cần căn cứ impact. | QO24 |
| A3 | Phạm vi nền tảng của đợt test là **iPhone** theo L4 (do caller chốt), dù đặc tả §10/[Q32] ghi "iOS và Android". | Ảnh hưởng phạm vi môi trường test, không đổi test condition chức năng. | QO23 |
| A4 | Danh mục khu vực, loại vụ việc, đề xuất xử lý, tài khoản và uỷ quyền được quản trị viên chuẩn bị sẵn trên trang quản trị ([Q37*] — trang quản trị đặc tả riêng); QC coi đó là **tiền điều kiện / dữ liệu kiểm thử**, không kiểm trang quản trị. | XL01 phụ thuộc cấu hình nhưng web nằm ngoài phạm vi. | — |

---

## 1. Đánh giá testability của test basis

Đặc tả v2.1 đã trả lời phần lớn vấn đề của đợt cũ (xem **mục 6 — Đối chiếu với TA-mo-ta-v1**). Bảng dưới chỉ liệt kê những vấn đề **còn lại hoặc mới phát sinh** khi đọc đặc tả.

| # | Trích đoạn / mục trong test basis | Vấn đề | Loại | Cần hỏi ai | → Câu hỏi |
|---|---|---|---|---|---|
| D01 | XL01-B8: "Chọn Đội, chọn 1 hoặc nhiều cán bộ"; TN1-A9: "chọn Đội nhận việc; tìm theo email và chọn một hoặc nhiều cán bộ"; §3.2: Phó trưởng, Trưởng CACK giao "toàn bộ các Đội"; §8.1 Vụ việc có **một** trường "Đội phụ trách", còn Phần việc có trường "Đội" riêng cho từng dòng | Không rõ một vụ việc chọn được **1 hay nhiều Đội**, và danh sách cán bộ có lọc theo Đội đã chọn không. Cách hiểu (a): 1 vụ việc = 1 Đội nhận việc, cán bộ phải thuộc Đội đó (khớp "Đội phụ trách" là 1 trường). Cách hiểu (b): chọn Đội chỉ để lọc tìm, người có phạm vi rộng (Trưởng/Phó trưởng CACK) chọn được cán bộ của nhiều Đội trong cùng vụ việc (khớp "Đội" trên từng phần việc). Hai cách hiểu cho hai tập test condition khác nhau về phạm vi giao. | Mơ hồ | Khách hàng / BA | QB1 → **Đã trả lời QB1(a)**: chỉ chọn 1 Đội; danh sách cán bộ lọc theo Đội đã chọn. Chỉ Trưởng/Phó trưởng CACK chọn được Đội (QB1(c)) |
| D02 | §8.1 Vụ việc có "nguồn phát hiện, Đội phụ trách, Tổ"; XL02 "Thông tin vụ việc: Đội phụ trách, Tổ, Nguồn phát hiện"; thẻ danh sách hiện "Tổ" | XL01 **không có bước nào** nhập Đội phụ trách, Tổ, Nguồn phát hiện → không biết hệ thống lấy giá trị từ đâu (Đội/Tổ của người tạo? Đội chọn ở bước 8? Tổ của cán bộ được giao?). Wireframe **V3** ghi nhận thẻ vụ việc hiện tên một Tổ khác với Đội đã chọn ở bước 8 — với đặc tả hiện tại vẫn không xác định được là lỗi hay đúng. Nguồn phát hiện: nguồn Camera, Chỉ đạo đã bỏ [B14] nhưng không nói giá trị mặc định. | Thiếu | Khách hàng / BA | QB1 → **Đã trả lời một phần QB1(b)**: Đội/Tổ **trên thẻ** lấy từ Đội của **người được giao** → V3 kiểm được. Còn mở: Tổ nào hiển thị khi các cán bộ được giao khác Tổ; "Đội phụ trách"/"Tổ" ở Chi tiết vụ việc có cùng quy tắc không; Nguồn phát hiện → QO26 |
| D03 | BR35 / [B24]: "Tiếp nhận: tất cả vụ việc **được tạo trong Đội**"; hậu điều kiện XL01: "hiện ở tab Tiếp nhận và tab Của tôi **của người giao**" | (1) Hậu điều kiện chỉ nêu Tiếp nhận của **người tạo**, còn BR35 ngụ ý **mọi người có quyền giao trong Đội** đều thấy. (2) "Được tạo trong Đội" có 2 cách hiểu: (a) theo Đội của **người tạo**; (b) theo **Đội phụ trách / Đội nhận việc**. Khác biệt lộ rõ khi Trưởng/Phó trưởng CACK tạo vụ việc giao cho Đội A: theo (a) người giao của Đội A **không** thấy ở Tiếp nhận, theo (b) thì thấy. (3) Không nói Tổ trưởng, Phó đội trưởng (bị giới hạn khu vực) có thấy ở Tiếp nhận vụ việc ngoài khu vực phụ trách không. Đây là quyền **xem dữ liệu cá nhân** của đối tượng (BR29: hiển thị đầy đủ cho người xem vụ việc) → impact bảo mật. | Mơ hồ / thiếu | Khách hàng / BA | QB1 → **Đã trả lời QB1(c)**: người giao (trừ Trưởng/Phó trưởng CACK) chỉ giao trong Đội của mình → Đội của vụ việc = Đội người tạo; (3) không còn vì khu vực gán theo Đội (QB2). Còn mở ⚑ suy ra: vụ việc do Trưởng/Phó trưởng CACK tạo hiện ở Tiếp nhận của Đội được chọn → QO25 |
| D04 | Phụ lục A **Q1**: "Tạo vụ việc xử lý vi phạm: tạo giao việc theo mẫu các vụ việc có sẵn **ở địa điểm cụ thể đã phân công cho Đội**"; XL01-B2: "Theo danh mục (mục 8.2). **Tổ trưởng, Phó đội trưởng** chỉ chọn trong các khu vực được phụ trách [B3]"; [B25*] (giả định): "Quản trị viên gán khu vực phụ trách cho **từng tài khoản**; chỉ giới hạn bước chọn khu vực của XL01" | Mâu thuẫn tiềm ẩn giữa quyết định Q1 và cách đặc tả triển khai. Cách hiểu (a) theo XL01 + [B25*]: mọi vai trò thấy toàn bộ danh mục khu vực, chỉ Tổ trưởng/Phó đội trưởng bị lọc theo khu vực gán cho tài khoản. Cách hiểu (b) theo Q1: danh sách khu vực ở bước 2 luôn giới hạn theo khu vực **đã phân công cho Đội** (mọi vai trò), Tổ trưởng/Phó đội trưởng bị lọc thêm. Cách hiểu (c) theo câu chữ [B3] "các thành viên trong Đội **và** các khu vực được phụ trách": khu vực giới hạn **người nhận** chứ không phải bước 2. Cách hiểu đang dùng (a) dựa trên giả định [B25*] chưa được xác nhận. | Mâu thuẫn / mơ hồ (phụ thuộc giả định) | Khách hàng | QB2 → **Đã trả lời QB2**: theo cách hiểu (b) — bước 2 chỉ hiện khu vực quản trị viên gán cho Đội, áp dụng mọi vai trò người giao; thay [B25*]. Còn mở: Đội chưa được gán khu vực → QO27; Trưởng/Phó trưởng CACK → **QB3** (D30) |
| D05 | §3.2: "Đội trưởng/Chỉ huy Đội, **Tổ phó** (và cán bộ uỷ quyền Tổ phó) → Cán bộ trong Đội mình phụ trách"; "**Tổ trưởng**, Phó đội trưởng → … chỉ ở các khu vực được phụ trách" | Tổ trưởng (cấp cao hơn Tổ phó) lại bị giới hạn khu vực còn Tổ phó thì không. Có thể đúng chủ ý, nhưng ngược trực giác; cùng với D04 cần xác nhận. Cũng không nói Tổ trưởng/Phó đội trưởng **chưa được gán khu vực nào** thì bước 2 hiển thị gì. | Mơ hồ / thiếu | Khách hàng | QB2 → **Không còn** (khu vực gán theo Đội, mọi vai trò như nhau). Câu chữ đặc tả XL01-B2, §3.2, BR36 cần cập nhật → QO28 |
| D06 | XL01 "Luồng thay thế": "Mức Khẩn cấp: gửi thông báo đẩy ưu tiên cao cho **Chỉ huy Đội và lãnh đạo trực tiếp**" [B7]; ghi chú trên màn "Cảnh báo Lãnh đạo + BCH đội" | "Lãnh đạo trực tiếp" không được định nghĩa (Phó trưởng/Trưởng CACK? Tổ trưởng? lãnh đạo của người tạo hay của Đội nhận việc?). "Chỉ huy Đội" của Đội nào phụ thuộc QB1. Người tạo chính là Chỉ huy Đội thì có nhận không. Test condition xác định được, nhưng **tập người nhận** (expected result) chưa xác định. | Mơ hồ | Khách hàng | QO20 (+ QB1) → **Đã giải quyết bởi quyết định QB1(d)**: gửi cho Trưởng CACK, Phó trưởng CACK **và** Chỉ huy Đội của vụ việc (khác đặc tả [B7] — QO28) |
| D07 | XL01 Kích hoạt: "nút + ở Trang chủ **hoặc tab Của tôi**"; §5 "Danh sách vụ việc (**tab Của tôi và Tiếp nhận**) … nút + để tạo vụ việc mới (chỉ người có quyền)" | Không rõ tab Tiếp nhận có nút + không. Với Cán bộ: §3.3 "không thấy các nút quản lý phần việc" và danh sách ghi "(chỉ người có quyền)", nhưng **nút + ở Trang chủ** với Cán bộ bị ẩn hay vô hiệu hoá thì không nói. | Mâu thuẫn nhẹ / thiếu | BA | QO1, QO3 |
| D08 | §3.3: uỷ quyền "cho cán bộ trong Đội"; [B2] quản trị viên thu hồi; [Q31] "Phòng Camera không có quyền tạo vụ việc" | (1) Thu hồi uỷ quyền có hiệu lực khi nào (ngay, hay lần đăng nhập sau); đang ở giữa 9 bước thì gửi được không. (2) Cán bộ Phòng Camera có thể được uỷ quyền Tổ phó không — nếu có thì [Q31] và §3.3 chồng nhau. | Thiếu / mâu thuẫn tiềm ẩn | Khách hàng / BA | QO2 |
| D09 | XL01: "nút Quay lại (giữ dữ liệu đã nhập)"; "không lưu nháp ngoại tuyến" [Q32] | Không nói khi **đóng màn / thoát giữa chừng / app bị đóng / chuyển nền** thì dữ liệu được giữ hay huỷ, có hỏi xác nhận không (wireframe V10: không thấy nút đóng). | Thiếu | BA | QO4 |
| D10 | XL01-B1, BR20, [B12]: "Chỉ ảnh, tối đa 50MB mỗi ảnh, **gắn thời gian**, không GPS" | Không nói số ảnh tối đa, xoá ảnh trước khi gửi, thông báo khi ảnh > 50MB. "Gắn thời gian" có 2 cách hiểu: (a) chèn dấu thời gian lên ảnh; (b) lưu thời gian chụp/tải lên dạng dữ liệu đi kèm — cách kiểm khác nhau. "Không GPS": ảnh có sẵn GPS chọn từ thư viện có bị loại bỏ toạ độ không. | Thiếu / mơ hồ | Khách hàng / Dev | QO5 |
| D11 | XL01-B1, B5, B6 dùng camera, thư viện ảnh, micro | Không nói hành vi khi người dùng **từ chối quyền** Camera / Ảnh / Micro của iOS (giữ từ TA-mo-ta-v1 O17). | Thiếu | BA | QO6 |
| D12 | XL01-B2 "Chọn 1, bắt buộc"; XL01 "Tiếp tục mờ cho đến khi bước hợp lệ"; [Ảnh H4] mục đầu đã có dấu chọn khi vào bước | Không rõ bước 2 có chọn sẵn mặc định không. Nếu có, bước 2 luôn "hợp lệ" → dễ gửi nhầm khu vực đầu danh sách (wireframe V9). | Thiếu / mâu thuẫn ảnh ↔ đặc tả | BA | QO7 |
| D13 | XL01-B3: "Theo danh mục **hai cấp**; mục 'Khác' cho nhập tên loại bằng tay" | Không nói giao diện chọn 2 cấp thế nào (chọn được loại cha không, hay bắt buộc loại con); tên loại nhập tay có bắt buộc nội dung, độ dài tối đa; loại "Khác" có cờ biểu mẫu không. [Ảnh H5] là danh sách 1 cấp. | Thiếu | BA | QO8 |
| D14 | XL01-B5: "Mô tả vụ việc (bắt buộc, nút Tiếp tục mờ khi để trống)" | Không nói chuỗi chỉ có khoảng trắng có tính là trống không; độ dài tối đa. | Thiếu | BA | QO9 |
| D15 | §10 "Xử lý trên thiết bị": nhận dạng giấy tờ và giọng nói "yêu cầu **độ chính xác cao** (chưa có ngưỡng cụ thể)" [B13]; "Hiệu năng (**đề xuất**) … Chờ khách hàng duyệt" | Không có ngưỡng → **không kiểm được** dưới dạng tiêu chí đạt/không đạt. Chỉ tiêu hiệu năng (thông báo < 10 giây…) chưa duyệt → không dùng làm expected result. | Không kiểm được | Khách hàng | QO21 |
| D16 | XL01-B6 bảng "Trường đối tượng" (6 trường, không ghi bắt buộc) | Không nói trường nào bắt buộc **trong một đối tượng đã thêm** (đối tượng rỗng có được lưu không); định dạng Ngày sinh; độ dài/định dạng số CCCD/CMND, số hộ chiếu; ràng buộc Quốc tịch ↔ loại giấy tờ (wireframe V7: quốc tịch nước ngoài nhập vào ô CCCD không bị chặn). §8.2: danh sách quốc tịch "chưa cung cấp" → thiếu dữ liệu kiểm thử. | Thiếu | BA / Khách hàng | QO10 |
| D17 | XL01-B6 "Quét giấy tờ … thông tin tự điền"; [Q18] "Ảnh giấy tờ chỉ dùng để quét, không lưu" | Không nói hành vi khi nhận dạng **thất bại** hoặc điền thiếu; quét hộ chiếu thì số giấy tờ vào ô nào; "không lưu" có bao gồm việc **không lưu ảnh chụp vào thư viện Ảnh của iPhone** không. | Thiếu | BA / Dev | QO11 |
| D18 | XL01-B6 "Các trường chung: **Số lượng đối tượng**; Biển số xe; Đơn vị liên quan"; §8.1 thực thể Vụ việc | §8.1 có biển số xe, đơn vị liên quan nhưng **không có "số lượng đối tượng"** → không biết trường này có được lưu và hiển thị ở đâu. | Thiếu / mâu thuẫn nhẹ | BA | QO12 |
| D19 | XL01-B6 "Biển số xe (nhập tay, chưa có tra cứu tự động [Q35])"; [Ảnh H8] có nút "Tra biển số" | Không nói nút "Tra biển số" đang có trên app phải ẩn hay giữ (khác với GV01 nói rõ "ẩn các tuỳ chọn này" cho loại tệp). | Thiếu | BA | QO13 |
| D20 | XL01-B7 đề xuất "… Khác" | "Khác" có ô nhập nội dung không (giữ từ TA-mo-ta-v1 O12). | Thiếu | BA | QO14 |
| D21 | XL01-B8 "Tìm cán bộ theo email" | Không nói cách khớp (một phần, hoa/thường) và hiển thị khi không có kết quả. | Thiếu | BA | QO15 |
| D22 | §3.4 ma trận tách cột "Người giao" và "Cán bộ được chỉ định"; Phụ lục C #1 "Tổ phó cũng nằm trong danh sách người nhận" | Không nói người giao có **tự giao cho chính mình** được không; chọn người có quyền giao khác (Tổ phó, Đội trưởng) làm người nhận được không, và khi đó nút trên phần việc hiển thị theo cột nào. | Thiếu | Khách hàng | QO16 |
| D23 | XL01-B9, BR06, [B8]: "không chọn quá khứ, không giới hạn tối đa, giờ mặc định 17:00 đổi được"; "giờ Việt Nam" | Không nói: hôm nay đã quá 17:00 thì giờ mặc định là gì; "quá khứ" kiểm lúc chọn hay lúc bấm gửi (hạn hợp lệ lúc chọn nhưng đã qua lúc gửi); độ chi tiết (phút); hiển thị khi thiết bị đặt múi giờ khác. | Thiếu | BA | QO17 |
| D24 | XL01 "Mất kết nối: không gửi được … không lưu nháp ngoại tuyến" | Không nói dữ liệu đã nhập có được giữ để gửi lại khi có mạng không; lỗi máy chủ; bấm "Giao việc và gửi" nhiều lần (tạo trùng). | Thiếu | BA / Dev | QO18 |
| D25 | §8.1 Phần việc có "nội dung"; XL02 khối "Giao việc · x/y" hiện "NỘI DUNG"; CH07 nhật ký "Giao việc"; XL02 "Diễn biến xử lý" ví dụ "**Phân công** – … · 14:35 20/10/2026" | Không nói NỘI DUNG của phần việc tạo từ XL01 lấy từ đâu (Mô tả vụ việc?). Hành động khởi tạo được gọi "Giao việc" (Lịch sử) và "Phân công" (Diễn biến xử lý) — không rõ là 2 bản ghi hay 1 bản ghi 2 tên. | Thiếu / mâu thuẫn nhẹ | BA | QO19 |
| D26 | §8.1 Vụ việc: "Tạo từ XL01; **sửa được**, không xoá (BR31)"; BR31, XL05: "thông tin đã nhập **không thể sửa**" | Mâu thuẫn nội bộ, nhưng **đặc tả đã tự nêu cách xử lý** (PL-C #13: theo [B21]; XL05 "Quy định này thay cho trả lời Q38"). Câu ở §8.1 là phần sót lại. Thuộc XL05 (ảnh hưởng chéo) — chỉ đề nghị sửa câu chữ. | Mâu thuẫn (đã có cách xử lý trong đặc tả) | BA | QO22 |
| D27 | §10 "Nền tảng: iOS và Android" [Q32]; L4 "Tạm thời chỉ chạy trên iphone"; bảng đối chiếu trong `lam-ro` dòng L4 ghi đặc tả "không nêu hệ điều hành" | Bảng đối chiếu trong `lam-ro` **chưa chính xác**: §10 và Phụ lục A Q32 có ghi "iOS và Android". Không đổi test condition chức năng, nhưng đổi phạm vi môi trường test. Model iPhone / phiên bản iOS tối thiểu vẫn chưa có ("phiên bản hệ điều hành tối thiểu chưa định"). | Mâu thuẫn giữa nguồn (phạm vi) / thiếu | QC lead | QO23 |
| D28 | Tính năng 1 "Kết quả": "kết quả lưu vào trang quản trị chung"; CH07 "nhật ký … đồng bộ về trang quản trị" | Trang quản trị ngoài phạm vi → **không kiểm được** trong đợt này. Không tạo test condition (GAP ở mục 3). | Không kiểm được | — | — |
| D29 | Toàn bộ test basis | Chưa có đánh giá business impact trực tiếp, chưa có lịch sử lỗi → căn cứ risk vẫn gián tiếp (A1, A2). | Thiếu | QC lead / khách hàng | QO24 |

**Vấn đề phát sinh khi áp dụng trả lời QB1, QB2 (cập nhật lần 2):**

| # | Trích đoạn / mục trong test basis | Vấn đề | Loại | Cần hỏi ai | → Câu hỏi |
|---|---|---|---|---|---|
| D30 | QB2: "Ở bước 2 … hiển thị các khu vực mà **đội đó** được chỉ định phụ trách"; QB1(c): "Nếu Trưởng CACK hoặc Phó trưởng CACK giao thì **mới có thể chọn đội**"; QB1(a): chọn Đội ở **bước 8**; XL01 thứ tự bước: khu vực (bước 2) **trước** Đội (bước 8) | Với Trưởng/Phó trưởng CACK, lúc ở bước 2 **chưa có Đội** của vụ việc → "đội đó" không xác định. Các cách hiểu: (a) hiện **toàn bộ** khu vực của mọi Đội; (b) hiện khu vực của **Đội mà Trưởng/Phó trưởng CACK thuộc về**; (c) hiện toàn bộ, rồi ở bước 8 chỉ cho chọn Đội **có phụ trách khu vực đã chọn** (hoặc báo lỗi khi không khớp). Cách (c) sinh thêm một test condition kiểm tính nhất quán khu vực ↔ Đội mà (a), (b) không có; cách (a) cho phép vụ việc của Đội X mang khu vực không thuộc Đội X (ảnh hưởng thống kê "Vụ việc theo khu vực" của Đội). | Mơ hồ (3 cách hiểu → tập test condition khác nhau) | QC lead / khách hàng | **QB3** → **Đã trả lời (cập nhật lần 3)**: cách hiểu (a) "Toàn bộ khu vực" — Trưởng/Phó trưởng CACK thấy khu vực của mọi Đội ở bước 2; bước 8 chọn Đội nào cũng được, **không cần khớp** khu vực. Còn mở: khu vực chưa gán cho Đội nào có hiện không → QO31 |
| D31 | QB1(b): "Tên Đội/Tổ hiển thị trên thẻ vụ việc lấy từ đội của **người được giao việc**" | Vụ việc giao nhiều cán bộ cùng Đội nhưng **khác Tổ** thì thẻ hiện Tổ nào (thẻ có dạng "· +2 cán bộ ·")? Trả lời chỉ nói **thẻ** — khối "Thông tin vụ việc" ở Chi tiết (Đội phụ trách, Tổ) có cùng quy tắc không? Nguồn phát hiện vẫn chưa có. | Thiếu | QC lead / BA | QO26 |
| D32 | QB2: "Admin là người có quyền được chọn khu vực cho đội" | Đội **chưa được gán khu vực nào** thì bước 2 hiển thị gì (danh sách rỗng → không tạo được vụ việc?). | Thiếu | QC lead / BA | QO27 |
| D33 | Quyết định QB1(d) ↔ đặc tả [B7], BR16, CH07; trả lời QB2 ↔ đặc tả XL01-B2, §3.2, BR36, [B25*] | Test basis mới **khác câu chữ** đặc tả v2.1 ở 2 chỗ (QC lead đã chốt dùng câu trả lời). Đặc tả cần được sửa để không còn hai nguồn nói khác nhau khi nghiệm thu. Không chặn phân tích. | Mâu thuẫn giữa nguồn (đã có quyết định) | Người viết đặc tả | QO28 |

**Tổng: 33 vấn đề testability (D01–D33)**. Sau cập nhật lần 2: QB1, QB2 đã trả lời; còn **1 câu hỏi chặn (QB3)** và 29 câu hỏi mở còn hiệu lực (QO1–QO19, QO21–QO30; QO20 đã giải quyết). **Sau cập nhật lần 3:** QB3 đã trả lời → **không còn câu hỏi chặn**; 30 câu hỏi mở còn hiệu lực (thêm QO31).

---

## 2. Test condition đã ưu tiên hoá

### 2.A Quyền tạo vụ việc

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-01 | Tài khoản thuộc 6 vai trò người giao (Đội trưởng/Chỉ huy Đội, Tổ trưởng, Tổ phó, Phó đội trưởng, Phó trưởng CACK, Trưởng CACK) thấy nút + ở Trang chủ và tab Của tôi, mở được màn "Tạo vụ việc" ở "Bước 1/9" (có nút + ở tab Tiếp nhận hay không: QO3) | XL01 Tác nhân, Kích hoạt; §3.1; BR01; TN1-A1 | Functional + Security (kiểm soát truy cập) | Vừa | Cao | Cao | P1 |
| TC-02 | **Tổ phó** có quyền tạo vụ việc mà **không cần** uỷ quyền (thay L2b của đợt cũ theo quyết định QC lead) | §3.1; lam-ro "Quyết định của QC lead" L2b | Security | Vừa | Cao | Cao | P1 |
| TC-03 | Cán bộ được quản trị viên **uỷ quyền Tổ phó** có quyền tạo vụ việc như người giao | §3.3; BR01; [Q2, Q4] | Security | Vừa | Cao | Cao | P1 |
| TC-04 | Cán bộ **không** được uỷ quyền (cán bộ hiện trường, cán bộ khác) không tạo được vụ việc: không có nút + ở tab Của tôi; nút + ở Trang chủ bị chặn (cách chặn: QO1) | §3.3; §5 danh sách "(chỉ người có quyền)"; [Q4] | Security | Vừa | Cao | Cao | P1 |
| TC-05 | Cán bộ **Phòng Camera** không tạo được vụ việc (kể cả khi được uỷ quyền — chờ QO2) | XL01 Tác nhân; [Q31] | Security | Vừa | Cao | Cao | P1 |
| TC-06 | Sau khi quản trị viên **thu hồi uỷ quyền**, cán bộ mất quyền tạo vụ việc; hành vi khi đang ở giữa 9 bước (expected: QO2) | §3.3; BR34; [B2] | Security | Vừa | Cao | Cao | P1 |
| TC-07 | Mất kết nối mạng: không gửi được vụ việc, không có lưu nháp ngoại tuyến (giữ dữ liệu để gửi lại hay không: QO18) | XL01 Tiền điều kiện, Luồng thay thế; BR17; [Q32] | Non-functional (Reliability) | Vừa | Cao | Cao | P1 |

### 2.B Điều hướng 9 bước

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-08 | Thanh tiến độ "Bước n/9" và tên bước hiển thị đúng thứ tự (bước 8 "Giao việc", bước 9 "Xem lại và gửi") | XL01; PL-C #3 | Non-functional (Usability) | Thấp | Thấp | Thấp | P3 |
| TC-09 | "Quay lại" giữ nguyên dữ liệu đã nhập ở mọi bước; đổi giá trị ở bước trước rồi đi tiếp thì vụ việc lưu giá trị mới | XL01 "Quay lại (giữ dữ liệu đã nhập)" | Functional | Vừa | Vừa | Vừa | P2 |
| TC-10 | Đóng màn / thoát giữa chừng / app chuyển nền hoặc bị đóng: dữ liệu giữ hay huỷ, có hỏi xác nhận không (expected: QO4) | XL01 (không nói) | Functional / Reliability | Vừa | Vừa | Vừa | P2 |
| TC-11 | Nút "Tiếp tục" / "Giao việc và gửi" chỉ sáng khi bước hợp lệ, đúng tập bắt buộc của BR04: bước 1, 6, 7 không bắt buộc (nút sáng khi để trống); bước 2, 3, 4, 5 (Mô tả vụ việc), 8 (Đội + ≥1 cán bộ), 9 (hạn) bắt buộc | XL01 bảng "Các bước nhập"; BR04; TN1 "Thiếu trường bắt buộc"; L3a(b) | Functional | Vừa | Cao | Cao | P1 |

### 2.C Bước 1 — Hình ảnh/Bằng chứng

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-12 | Đi tiếp khỏi bước 1 khi chưa có ảnh | XL01-B1 "Không"; BR04 | Functional | Thấp | Vừa | Thấp | P3 |
| TC-13 | Thêm ảnh bằng Chụp ảnh và Thư viện; màn xem lại hiện "Bằng chứng: n tệp" khớp số ảnh; mọi ảnh được lưu cùng vụ việc và hiện ở khối Hình ảnh/Bằng chứng của Chi tiết vụ việc | XL01-B1; TN1-A2 | Functional | Vừa | Cao | Cao | P1 |
| TC-14 | Chỉ nhận **ảnh**; không chọn được video hay tệp khác | XL01-B1; BR20; [Q20]; §1.2 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-15 | Giới hạn **50MB mỗi ảnh**: ảnh ≤ 50MB được nhận, ảnh > 50MB bị từ chối (thông báo: QO5) | XL01-B1; BR20; [B12] | Functional | Vừa | Vừa | Vừa | P2 |
| TC-16 | Ảnh được **gắn thời gian** (cách gắn: QO5) | XL01-B1; BR20; [B12] | Functional | Vừa | Vừa | Vừa | P2 |
| TC-17 | Ảnh lưu trên hệ thống **không chứa toạ độ GPS**, kể cả ảnh chọn từ thư viện vốn có GPS | XL01-B1; BR20; [B12] | Non-functional (Security — bảo mật dữ liệu) | Vừa | Vừa | Vừa | P2 |
| TC-18 | Hành vi khi từ chối quyền Camera / Ảnh của iOS (bước 1 và bước 6) (expected: QO6) | XL01-B1, B6 (không nói) | Non-functional (Usability / Compatibility) | Vừa | Vừa | Vừa | P2 |

### 2.D Bước 2–4 — Khu vực, loại vụ việc, mức độ

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-19 | Bước 2 chọn đúng **một** khu vực trong danh sách hiển thị và giá trị được lưu đúng (hiện ở thẻ "loại · khu vực" và "Vụ việc theo khu vực"); có chọn sẵn mặc định hay không: QO7 | XL01-B2; §8.2; BR04 | Functional | Thấp | Vừa | Thấp | P3 |
| TC-20 | **Danh sách khu vực theo Đội** (người giao cấp Đội: Đội trưởng/Chỉ huy Đội, Tổ trưởng, Tổ phó, Phó đội trưởng, cán bộ uỷ quyền Tổ phó): bước 2 chỉ hiện các khu vực quản trị viên đã gán cho **Đội của người tạo**; khu vực của Đội khác không hiện; như nhau cho mọi vai trò cấp Đội (không còn giới hạn riêng Tổ trưởng/Phó đội trưởng theo [B25*]). Đội chưa được gán khu vực: QO27 | QB2; Phụ lục A Q1; QB1(c); XL01-B2 (câu chữ cần sửa — QO28) | Functional + Security (kiểm soát truy cập) | Vừa | Cao | Cao | P1 |
| TC-21 | Danh mục khu vực, loại vụ việc, đề xuất xử lý trên app hiển thị theo cấu hình quản trị (thay đổi danh mục thì app hiển thị theo) | XL01 "tuỳ chọn cấu hình sẵn" [Q1, Q19]; §8.2 "Danh sách hiển thị theo cấu hình" | Functional | Thấp | Vừa | Thấp | P3 |
| TC-22 | Bước 3 chọn một loại theo danh mục **hai cấp**; vụ việc lưu đúng loại cha và loại con (dùng cho báo cáo "Theo loại (2 cấp)") — cách chọn 2 cấp: QO8 | XL01-B3; §8.1 "loại (cha, con)"; [Q19]; CH06 mục III | Functional | Vừa | Cao | Cao | P1 |
| TC-23 | Loại "**Khác**": nhập tên loại bằng tay và tên đó được lưu (bắt buộc nội dung, độ dài: QO8) | XL01-B3; Luồng thay thế; §8.1 "tên loại nhập tay" | Functional | Vừa | Vừa | Vừa | P2 |
| TC-24 | Loại có cờ yêu cầu biểu mẫu ("Phát hiện vật phẩm nguy hiểm") → vụ việc tạo ra có khối "Biểu mẫu và chữ ký"; loại không có cờ thì không — **ảnh hưởng chéo XL03** | §8.1 Danh mục "cờ yêu cầu biểu mẫu"; §8.2; BR21; [Q19] | Functional | Vừa | Cao | Cao | P1 |
| TC-25 | Bước 4 chọn một trong 3 mức (Bình thường, Nghiêm trọng, Khẩn cấp); mức được lưu đúng và lọc được ở danh sách vụ việc; chọn Khẩn cấp thì hiện ghi chú "Cảnh báo Lãnh đạo + BCH đội" | XL01-B4; TN1-A5; §8.2 | Functional | Thấp | Cao | Vừa | P2 |
| TC-26 | Vụ việc mức **Khẩn cấp**: sau khi gửi, thông báo đẩy **ưu tiên cao** tới **Trưởng CACK, Phó trưởng CACK và Chỉ huy Đội của vụ việc**, không bắt buộc xác nhận; người ngoài tập này (vd Chỉ huy Đội khác, Tổ trưởng) không nhận; mức Bình thường/Nghiêm trọng không gửi thông báo này | Quyết định QB1(d) (**thay** đặc tả [B7] "Chỉ huy Đội và lãnh đạo trực tiếp"); XL01 Luồng thay thế; BR16; CH07 | Functional | Vừa | Cao | Cao | P1 |

### 2.E Bước 5 — Mô tả

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-27 | "Mô tả vụ việc" bắt buộc (nút Tiếp tục mờ khi trống); "Vị trí cụ thể", "Hành động đã thực hiện" tuỳ chọn; cả ba được lưu đúng và hiện ở Chi tiết vụ việc (mô tả ngắn, Vị trí, Hành động đã thực hiện) | XL01-B5; BR04; L3a(b); XL02 "Màn Chi tiết vụ việc" | Functional | Vừa | Cao | Cao | P1 |
| TC-28 | Mô tả chỉ có khoảng trắng; độ dài tối đa; tiếng Việt có dấu và ký tự đặc biệt được lưu nguyên vẹn (quy tắc: QO9) | XL01-B5 (không nói); §10 "giao diện tiếng Việt" | Functional | Vừa | Vừa | Vừa | P2 |
| TC-29 | Nhập bằng giọng nói qua micro ở 3 ô của bước 5: văn bản nhận dạng được chèn vào đúng ô (xử lý trên thiết bị; ngưỡng chính xác không kiểm được — QO21; quyền Micro — QO6) | XL01-B5 "có micro"; §10 Khả dụng, Xử lý trên thiết bị; [B13] | Functional / Usability | Vừa | Thấp | Thấp | P3 |

### 2.F Bước 6 — Thông tin đối tượng

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-30 | Không thêm đối tượng nào vẫn đi tiếp và gửi được vụ việc | XL01-B6; BR18; [Q17] | Functional | Thấp | Vừa | Thấp | P3 |
| TC-31 | "Số lượng đối tượng" nhập độc lập, **không cần khớp** số đối tượng đã nhập, không bị chặn (được lưu ở đâu: QO12) | XL01-B6; BR18; [Q17] | Functional | Thấp | Thấp | Thấp | P3 |
| TC-32 | **Quét giấy tờ** bằng camera tự điền **đúng** các trường cho từng loại: CCCD gắn chip, CMND, hộ chiếu Việt Nam, hộ chiếu nước ngoài | XL01-B6 cách 1; BR19; [Q18] | Functional (độ chính xác chức năng) | Cao | Cao | Cao | P1 |
| TC-33 | **Từ thư viện**: chọn ảnh giấy tờ có sẵn, thông tin tự điền đúng (cùng 4 loại giấy tờ) | XL01-B6 cách 2; BR19 | Functional | Cao | Cao | Cao | P1 |
| TC-34 | Các trường tự điền **sửa được**; giá trị sau khi sửa là giá trị được lưu | XL01-B6 "Cán bộ phải kiểm tra lại"; TN1-A7 "người giao kiểm tra và sửa"; [Q18] | Functional | Vừa | Cao | Cao | P1 |
| TC-35 | Nhận dạng không thành công (ảnh mờ, thiếu sáng, không phải giấy tờ) hoặc điền thiếu: hành vi của app (expected: QO11) | XL01-B6 (không nói) | Functional / Reliability | Cao | Vừa | Cao | P1 |
| TC-36 | **Không lưu ảnh giấy tờ**: sau khi quét hoặc chọn từ thư viện, ảnh giấy tờ không có trong vụ việc (không vào Hình ảnh/Bằng chứng, không lưu lên hệ thống); chỉ lưu văn bản (có lưu vào thư viện Ảnh của iPhone hay không: QO11) | XL01-B6 "không lưu"; BR19; §8.1 Đối tượng; [Q18] | Non-functional (Security — bảo mật dữ liệu cá nhân) | Vừa | Cao | Cao | P1 |
| TC-37 | Nhận dạng giấy tờ **chạy trên thiết bị**: ảnh giấy tờ không được gửi lên máy chủ trong quá trình quét | §10 "Xử lý trên thiết bị"; [B13]; [Q18] | Non-functional (Security) | Vừa | Cao | Cao | P1 |
| TC-38 | "Thêm đối tượng thủ công": nhập 6 trường (Họ tên, Ngày sinh, Giới tính Nam/Nữ/Khác, Quốc tịch từ danh sách, Số CCCD/CMND, Số hộ chiếu) và dữ liệu được lưu đúng | XL01-B6 cách 3, bảng "Trường đối tượng" | Functional | Vừa | Cao | Cao | P1 |
| TC-39 | Quy tắc hợp lệ của trường đối tượng: trường bắt buộc trong một đối tượng, đối tượng rỗng, định dạng Ngày sinh, số CCCD/CMND, số hộ chiếu, Quốc tịch ↔ loại giấy tờ (quy tắc: QO10) | XL01-B6 (không nói) | Functional | Vừa | Cao | Cao | P1 |
| TC-40 | Nhiều đối tượng trong một vụ việc (kết hợp 3 cách thêm), xoá một đối tượng; mọi đối tượng còn lại được lưu và hiện "Đối tượng 1..n" ở Chi tiết vụ việc với số CCCD **hiển thị đầy đủ, không che** | XL01-B6 "Mỗi đối tượng có nút xoá"; XL02 khối "Thông tin liên quan"; BR29; [B16] | Functional | Vừa | Vừa | Vừa | P2 |
| TC-41 | Biển số xe (nhập tay) và Đơn vị liên quan: tuỳ chọn, được lưu đúng; không có tra cứu tự động (nút "Tra biển số": QO13) | XL01-B6 "Các trường chung"; §8.1; [Q35] | Functional | Thấp | Thấp | Thấp | P3 |

### 2.G Bước 7 — Đề xuất xử lý

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-42 | Chọn 0, 1 hoặc nhiều trong 5 đề xuất; tập lựa chọn được lưu và hiện ở khối "Đề xuất xử lý của cán bộ" | XL01-B7; §8.2; XL02 Chi tiết vụ việc | Functional | Thấp | Vừa | Thấp | P3 |
| TC-43 | Đề xuất "Khác": có/không có ô nhập nội dung và nội dung được lưu (QO14) | XL01-B7 | Functional | Thấp | Thấp | Thấp | P3 |

### 2.H Bước 8 — Giao việc

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-44 | Tìm theo email và chọn 1 hoặc nhiều cán bộ của Đội nhận việc; mỗi dòng hiện email, Đội, vai trò; bỏ chọn được; phải có ít nhất 1 cán bộ mới đi tiếp | XL01-B8; TN1-A9; BR04 | Functional | Vừa | Cao | Cao | P1 |
| TC-45 | **Phạm vi giao theo vai trò**: người giao cấp Đội (Đội trưởng/Chỉ huy Đội, Tổ trưởng, Tổ phó, Phó đội trưởng, cán bộ uỷ quyền Tổ phó) **không chọn được Đội khác** — Đội nhận việc là Đội của mình, chỉ thấy cán bộ trong Đội mình; Phó trưởng, Trưởng CACK **chọn được Đội** bất kỳ; người ngoài phạm vi **không hiển thị** | XL01-B8; XL01 Luồng thay thế; §3.2; BR02; QB1(c) | Functional + Security | Vừa | Cao | Cao | P1 |
| TC-46 | Mỗi vụ việc chỉ chọn được **đúng 1 Đội**; danh sách cán bộ **lọc theo Đội đã chọn**; đổi Đội (Trưởng/Phó trưởng CACK) thì danh sách cán bộ đổi theo, không thể có cán bộ của 2 Đội trong cùng vụ việc (cán bộ đã chọn trước khi đổi Đội xử lý thế nào: QO29) | QB1(a); XL01-B8; §8.1 "Đội phụ trách" | Functional + Security | Vừa | Cao | Cao | P1 |
| TC-47 | Tìm cán bộ theo email: kết quả khớp đúng, hiển thị khi không có kết quả (cách khớp: QO15) | XL01-B8 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-48 | Người giao tự giao cho chính mình / chọn người có quyền giao khác làm người nhận (được phép hay không, nút hiển thị: QO16) | §3.4; PL-C #1 | Functional + Security | Vừa | Vừa | Vừa | P2 |

### 2.I Bước 9 — Xem lại, hạn và gửi

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-49 | Màn xem lại tóm tắt đúng: loại, mô tả, bằng chứng (n tệp), người được giao | XL01-B9 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-50 | Chọn ngày và giờ hạn (giờ Việt Nam); giờ mặc định 17:00 và đổi được; hạn được lưu đúng là "Hạn" của từng phần việc và "Hạn xử lý" của vụ việc | XL01-B9; BR06; [B8]; XL02 Chi tiết vụ việc | Functional | Vừa | Cao | Cao | P1 |
| TC-51 | Hạn **không được ở quá khứ** (ngày đã qua; hôm nay giờ đã qua; mặc định 17:00 khi đã quá 17:00; hạn trở thành quá khứ giữa lúc chọn và lúc gửi — chi tiết: QO17); **không giới hạn tối đa** | XL01-B9; BR06; [B8] | Functional | Vừa | Cao | Cao | P1 |
| TC-52 | Hạn hiển thị và lưu theo giờ Việt Nam khi thiết bị đặt múi giờ khác (QO17) | BR06 "Mọi thời gian … theo giờ Việt Nam"; §10 | Functional | Thấp | Cao | Vừa | P2 |
| TC-53 | Bước 9 chỉ có nút "Giao việc và gửi", **không** có "Xử lý tại chỗ và hoàn thành" | XL01-B9; §1.2; [Q4] | Functional | Thấp | Vừa | Thấp | P3 |
| TC-54 | Gửi tạo **đúng một** vụ việc có mã dạng "VV" + 6 chữ số, không trùng; mã dùng chung một chuỗi với việc giao (tạo xen kẽ XL01 và GV01 không trùng mã) | XL01 Hậu điều kiện; BR38; [B1]; §8.1 | Functional | Vừa | Cao | Cao | P1 |
| TC-55 | Bấm "Giao việc và gửi" nhiều lần, mạng chập chờn hoặc lỗi máy chủ: không tạo trùng vụ việc, không tạo phần việc / thông báo trùng (expected: QO18) | XL01 (không nói); TN1-A10 | Non-functional (Reliability) | Vừa | Cao | Cao | P1 |
| TC-56 | Toàn bộ dữ liệu 9 bước, thời gian tạo và người tạo được lưu và hiện đúng ở Chi tiết vụ việc | XL01 Hậu điều kiện; §8.1 Vụ việc; XL02 "Màn Chi tiết vụ việc"; §2.1 "không thiếu thông tin" | Functional | Vừa | Cao | Cao | P1 |

### 2.J Hậu điều kiện (trạng thái, hiển thị, thông báo, nhắc việc, nhật ký)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên |
|---|---|---|---|---|---|---|---|
| TC-57 | Trạng thái ban đầu: vụ việc "Đang thực hiện"; mỗi cán bộ được chỉ định có **đúng một** phần việc với Tiến độ "Đã giao", Kết quả "Chưa bắt đầu"; bộ đếm "Giao việc 0/y" với y = số cán bộ | XL01 Hậu điều kiện; §4.1; §4.2; BR03; TN1-A10 | Functional | Vừa | Cao | Cao | P1 |
| TC-58 | Vụ việc hiện ở tab **Tiếp nhận** và **Của tôi** của người tạo; tab **Của tôi** của từng cán bộ được chỉ định; tài khoản cán bộ **không có** tab Tiếp nhận; cán bộ không được chỉ định không thấy vụ việc trong Của tôi | XL01 Hậu điều kiện; BR35; §3.4; [B24] | Functional + Security | Vừa | Cao | Cao | P1 |
| TC-59 | Vụ việc hiện ở tab Tiếp nhận của **mọi người có quyền giao trong Đội của vụ việc** (= Đội người tạo với người giao cấp Đội) và **không** hiện ở Tiếp nhận của người giao Đội khác. Partition vụ việc do Trưởng/Phó trưởng CACK tạo: hiện ở Tiếp nhận của Đội được chọn — **⚑ suy ra, chưa xác nhận (QO25)**, expected của partition này chưa dùng làm tiêu chí đạt/không đạt | BR35; [B24]; §3.4; QB1(c) | Functional + Security | Vừa | Cao | Cao | P1 |
| TC-60 | Mỗi cán bộ được chỉ định nhận **đúng một** thông báo "Bạn có phần việc mới" (tab Thông báo, chưa đọc in đậm), mở được phần việc từ thông báo; người không được chỉ định không nhận; không gửi qua SMS | XL01 Hậu điều kiện; CH07; BR17; [Q32] | Functional | Vừa | Cao | Cao | P1 |
| TC-61 | Thời điểm nhắc việc của từng phần việc = thời điểm giao + 2/3 × (hạn − giao), hiển thị ở "NHẮC VIỆC" (công thức có căn cứ [Q14]; cách tính chính xác "suy ra" từ ảnh — cần xác nhận khi nghiệm thu) | TN1-A10; BR11; CH07; [Q14] | Functional | Vừa | Vừa | Vừa | P2 |
| TC-62 | Nhật ký "Giao việc" được ghi cho từng phần việc (giờ · người thực hiện · hành động), xem được qua Lịch sử và Diễn biến xử lý; không sửa, không xoá (tên hành động: QO19) | XL01 Hậu điều kiện; CH07 Nhật ký; BR32 | Functional | Vừa | Vừa | Vừa | P2 |
| TC-63 | Tên **Đội/Tổ trên thẻ vụ việc** = Đội/Tổ của **cán bộ được giao** (kiểm được vấn đề V3 của wireframe). Trường hợp nhiều cán bộ khác Tổ, khối "Thông tin vụ việc" ở Chi tiết, và Nguồn phát hiện: QO26 | QB1(b); §8.1; §5 Danh sách vụ việc; XL02 Chi tiết vụ việc | Functional | Vừa | Vừa | Vừa | P2 |
| TC-64 | Thống kê Trang chủ cập nhật sau khi tạo (Tổng vụ việc, Khẩn cấp mở, Vụ việc theo khu vực) **cho người dùng thuộc Đội của vụ việc**; người dùng Đội khác không thấy thay đổi — **ảnh hưởng chéo CH05**. Theo QB3, vụ việc do Trưởng/Phó trưởng CACK tạo có thể mang khu vực không thuộc Đội của vụ việc → "Vụ việc theo khu vực" của Đội đó phải hiện cả khu vực này | QB1(d) "User ở đội nào thì sẽ hiện thống kê của đội đó"; QB3; TN1 "Kết quả"; CH05; BR27; [B19] | Functional | Vừa | Vừa | Vừa | P2 |
| TC-65 | Người tạo là **Trưởng/Phó trưởng CACK**: bước 2 hiện **khu vực của mọi Đội** (khác TC-20 của người giao cấp Đội); bước 8 chọn được **bất kỳ Đội nào**, hệ thống **không** chặn hay cảnh báo khi Đội đã chọn không phụ trách khu vực đã chọn ở bước 2; vụ việc lưu đúng khu vực và Đội đã chọn. Khu vực chưa gán cho Đội nào: QO31 | QB3 (cách hiểu (a)); QB2; QB1(a)(c) | Functional + Security (kiểm soát truy cập theo vai trò) | Vừa | Vừa | Vừa | P2 |

### Tổng hợp

| Ưu tiên | Số test condition | Danh sách |
|---|---|---|
| P1 | 34 | TC-01–07, 11, 13, 20, 22, 24, 26, 27, 32–39, 44, 45, 46, 50, 51, 54–60 |
| P2 | 20 | TC-09, 10, 14–18, 23, 25, 28, 40, 47, 48, 49, 52, 61, 62, 63, 64, 65 |
| P3 | 11 | TC-08, 12, 19, 21, 29, 30, 31, 41, 42, 43, 53 |
| Chưa xếp hạng | 0 | — |
| **Tổng** | **65** | |

**Thay đổi ở cập nhật lần 3:** TC-65 viết lại theo cách hiểu (a) của QB3 và xếp P2 (Vừa×Vừa — likelihood Vừa vì là nhánh riêng theo vai trò ở cả bước 2 và bước 8; impact Vừa vì Trưởng/Phó trưởng CACK vốn có phạm vi toàn đơn vị, hậu quả chủ yếu là phân loại/thống kê theo khu vực, không mở rộng quyền xem). TC-64 bổ sung hệ quả của QB3. TC-20 giữ nguyên (chỉ người giao cấp Đội).

**Thay đổi ở cập nhật lần 2:** TC-20 → P1 (Vừa×Cao), TC-46 → P1 (Vừa×Cao), TC-59 → P1 (Vừa×Cao, partition Trưởng/Phó trưởng CACK ⚑ suy ra), TC-63 → P2 (Vừa×Vừa — sau QB1(b) đây chỉ còn là hiển thị; quyền xem đã do TC-59 phủ). Viết lại TC-26 (người nhận theo QB1(d)), TC-44, TC-45, TC-64. Thêm TC-65 (chờ QB3).

Lưu ý: mọi risk level dựa trên giả định A1/A2 (QO24). Nhiều test condition P1 (TC-04, 06, 07, 35, 36, 39, 51, 55) đã xác định được **cái cần test** nhưng expected result còn chờ câu hỏi mở tương ứng.

---

## 3. Traceability nháp

| Test condition | Mục test basis | Ghi chú cho test-plan (gợi ý nhóm test object — test-plan chốt lại) |
|---|---|---|
| TC-01 – 07 | XL01 Tác nhân, Tiền điều kiện, Kích hoạt; §3.1, §3.3, §3.4; BR01, BR17, BR34; [Q2, Q4, Q31, Q32, B2]; lam-ro L2b (đã thay) | **AUTH** — quyền tạo. Tiền điều kiện: tài khoản cho đủ 6 vai trò + cán bộ uỷ quyền + cán bộ thường + Phòng Camera (cấu hình trên web — A4) |
| TC-08 – 11 | XL01 (Quay lại, Tiếp tục); BR04; PL-C #3; L3a(b) | **NAV** — điều hướng, tính bắt buộc từng bước. TC-11 có dạng bảng quyết định theo BR04 |
| TC-12 – 18 | XL01-B1; BR20; [Q20, B12] | **EVD** — bằng chứng. TC-18 dùng chung bước 6. Ảnh hưởng chéo XL05 (thêm ảnh sau khi tạo — cùng quy tắc ảnh) |
| TC-19 – 26 | XL01-B2, B3, B4; §8.2; BR16, BR21; [B3, Q19]; QB2 (thay [B25*]); QB1(d) (thay [B7]) | **CLS** — phân loại. TC-20 theo QB2 (tiền điều kiện: ≥2 Đội được gán bộ khu vực khác nhau trên web — A4). TC-24 ảnh hưởng chéo XL03. TC-26 theo quyết định QB1(d) |
| TC-27 – 29 | XL01-B5; §10; [B13]; L3a(b) | **DSC** — mô tả |
| TC-30 – 41 | XL01-B6; §8.1 Đối tượng; BR18, BR19, BR29; [Q17, Q18, Q35, B13, B16] | **SUBJ** — đối tượng. Dữ liệu đối tượng tự điền vào biên bản XL03 — ảnh hưởng chéo. Cần bộ giấy tờ **mẫu giả** cho 4 loại (QO23) |
| TC-42 – 43 | XL01-B7; §8.2 | **PROP** — đề xuất xử lý |
| TC-44 – 48 | XL01-B8; §3.2, §3.4; BR02; PL-C #1; QB1(a)(c) | **ASG** — giao cán bộ, phạm vi giao. Người được giao là đầu vào của XL02, CH02/CH03 (loại trừ người đang phụ trách) |
| TC-49 – 56 | XL01-B9, Hậu điều kiện; BR06, BR38; [B1, B8, Q4] | **SUB** — hạn, xem lại, gửi. Hạn ảnh hưởng chéo nhắc việc, quá hạn (BR10), Gia hạn (CH01). TC-54 ảnh hưởng chéo GV01 (chuỗi mã chung) |
| TC-57 – 64 | XL01 Hậu điều kiện; §4.1, §4.2; CH07; BR03, BR11, BR27, BR32, BR35; [B24, Q14]; QB1(b)(c)(d) | **POST** — hậu điều kiện. TC-59 có partition ⚑ suy ra (QO25). TC-63 kiểm vấn đề V3. TC-64 ảnh hưởng chéo CH05; vụ việc cũng vào báo cáo hằng ngày (CH06) — ngoài phạm vi đợt này |
| TC-65 | QB3; QB2; QB1(a)(c) | **CLS/ASG** — nhánh Trưởng/Phó trưởng CACK. Theo QB3 **không** có test condition kiểm nhất quán khu vực ↔ Đội (cách hiểu (c) đã bị loại) |
| — | TN1 "Kết quả lưu vào trang quản trị chung"; CH07 "đồng bộ về trang quản trị" | **GAP — không kiểm được** (trang quản trị ngoài phạm vi, [Q37*]). Không tạo test condition |
| — | §10 Hiệu năng (đề xuất, chờ duyệt); độ chính xác nhận dạng "cao" (không ngưỡng) | **GAP — không kiểm được** dưới dạng tiêu chí đạt/không đạt cho tới khi có ngưỡng (QO21) |

---

## 4. Câu hỏi cần làm rõ trước khi lập test plan

**Không còn câu hỏi nào phải làm rõ trước khi lập test plan** (cập nhật lần 4, 2026-10-26): câu hỏi chặn QB1–QB3 đã trả lời; QO24 đã được QC lead chấp nhận; các câu hỏi mở còn lại được QC lead cho mang sang test-plan — xem **mục 5**. Các bảng dưới chỉ giữ để truy vết.

### 4.1 Câu hỏi chặn (thuộc mục 0 của skill — phải trả lời trước khi chạy test-plan)

| # | Câu hỏi | Lý do dừng (mục 0) | Test condition bị ảnh hưởng |
|---|---|---|---|
| — | **Không còn câu hỏi chặn** (cập nhật lần 3, 2026-10-26). | — | — |

**Đã trả lời (giữ để truy vết):**

| # | Câu hỏi | Lý do dừng (mục 0) | Test condition bị ảnh hưởng |
|---|---|---|---|
| **QB3** ✅ — đã trả lời (cập nhật lần 3): cách hiểu (a) "Toàn bộ khu vực", bước 8 chọn Đội bất kỳ, không cần khớp khu vực; vai trò khác theo QB2 | **Khu vực ở bước 2 khi người tạo là Trưởng/Phó trưởng CACK.** Trả lời QB2: bước 2 hiện "các khu vực mà **đội đó** được chỉ định phụ trách"; trả lời QB1(a)(c): chỉ Trưởng/Phó trưởng CACK chọn Đội, và chọn ở **bước 8** — sau bước 2. Vậy ở bước 2, Trưởng/Phó trưởng CACK thấy: (a) toàn bộ khu vực của mọi Đội; (b) khu vực của Đội mà họ thuộc về; hay (c) toàn bộ, rồi bước 8 chỉ cho chọn Đội phụ trách khu vực đã chọn (hoặc báo lỗi khi không khớp)? Nếu (a): vụ việc của Đội X được phép mang khu vực không thuộc Đội X không? | Mơ hồ — 3 cách hiểu dẫn tới tập test condition khác nhau (cách (c) thêm điều kiện nhất quán khu vực ↔ Đội) (D30) | TC-65 (chưa xếp hạng); expected của TC-20 (partition CACK), 45, 64 |

**Đã trả lời (cập nhật lần 2 — giữ để truy vết):**

| # | Câu hỏi | Lý do dừng (mục 0) | Test condition bị ảnh hưởng |
|---|---|---|---|
| **QB1** ✅ — đã trả lời QB1(a)–(d) + quyết định QB1(d), xem `lam-ro` | **"Đội của vụ việc"** — (a) Ở bước 8, một vụ việc chọn được **1 hay nhiều Đội**? Danh sách cán bộ có lọc theo Đội đã chọn không? Trưởng/Phó trưởng CACK chọn được cán bộ của nhiều Đội trong cùng vụ việc không? (b) **Đội phụ trách, Tổ, Nguồn phát hiện** của vụ việc (§8.1, Chi tiết vụ việc, thẻ danh sách) lấy từ đâu: Đội/Tổ của người tạo, Đội chọn ở bước 8, hay Tổ của cán bộ được giao? (liên quan wireframe V3) (c) BR35 "Tiếp nhận: tất cả vụ việc **được tạo trong Đội**" tính theo **Đội của người tạo** hay **Đội phụ trách**? Vụ việc do Trưởng/Phó trưởng CACK tạo giao cho Đội A có hiện ở Tiếp nhận của người giao Đội A không? Tổ trưởng, Phó đội trưởng có thấy vụ việc ngoài khu vực phụ trách trong Tiếp nhận không? (d) "Chỉ huy Đội" nhận cảnh báo Khẩn cấp và thống kê Trang chủ được tính cho Đội nào? | Mơ hồ — 2 cách hiểu dẫn tới 2 tập test condition khác hẳn nhau về **ai được xem vụ việc** (kèm dữ liệu cá nhân đầy đủ của đối tượng, BR29) và phạm vi giao (D01, D02, D03) | TC-46, 59, 63 (chưa xếp hạng); expected của TC-26, 45, 58, 64 |
| **QB2** ✅ — đã trả lời: khu vực gán theo Đội, mọi vai trò người giao; thay [B25*] | **Giới hạn khu vực ở bước 2** — Phụ lục A **Q1** ghi vụ việc "ở địa điểm cụ thể **đã phân công cho Đội**", còn XL01 bước 2 + giả định **[B25*]** chỉ giới hạn **Tổ trưởng, Phó đội trưởng** theo khu vực gán cho từng tài khoản. Cách hiểu nào đúng: (a) mọi vai trò thấy toàn bộ danh mục, trừ Tổ trưởng/Phó đội trưởng; (b) mọi vai trò chỉ thấy khu vực đã phân công cho Đội, Tổ trưởng/Phó đội trưởng bị lọc thêm; (c) [B3] "các khu vực được phụ trách" giới hạn **người nhận**, không phải bước 2? Khách hàng đã xác nhận giả định [B25*] chưa? Tổ trưởng/Phó đội trưởng chưa được gán khu vực nào thì bước 2 hiển thị gì? Việc Tổ trưởng bị giới hạn khu vực còn Tổ phó thì không (§3.2) có đúng chủ ý không? | Mâu thuẫn tiềm ẩn giữa Phụ lục A Q1 và XL01 + mơ hồ nhiều cách hiểu; test condition phụ thuộc giả định chưa xác nhận [B25*] (D04, D05) | TC-20 (chưa xếp hạng); expected của TC-19, 45 |

---

## 5. Câu hỏi mở mang sang test-plan (expected result còn mở)

> **Quyết định của QC lead, 2026-10-26** ([lam-ro-2026-10-26.md](../../specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-26.md), mục "Quyết định của QC lead về trạng thái test-analysis-dac-ta-v2.1"): "Chấp nhận cả hai, chạy tiếp" — chấp nhận căn cứ risk A1/A2 (QO24) và mang các câu hỏi mở QO1–QO19, QO21–QO31 sang test-plan dưới dạng "kết quả mong đợi còn mở". QO25 (⚑ suy ra) vẫn không dùng làm tiêu chí đạt/không đạt cho tới khi được xác nhận.
>
> Các câu dưới đây **chưa được trả lời** — chúng không chặn test-plan nhưng test-plan/test-case phải ghi expected result tương ứng là "còn mở" (chỉ ghi nhận hành vi quan sát được), không tự suy diễn câu trả lời. QO1–QO23 có từ bản đầu, QO25–QO30 thêm ở cập nhật lần 2, QO31 ở cập nhật lần 3; QO20 đã giải quyết, QO24 đã đóng (cập nhật lần 4).

| # | Câu hỏi | Từ | Test condition bị ảnh hưởng |
|---|---|---|---|
| QO1 | Với tài khoản Cán bộ, nút + ở **Trang chủ** bị ẩn hay vô hiệu hoá (hay báo lỗi khi bấm)? | D07; TA-mo-ta-v1 B1(a) phần còn lại | TC-04, 05 |
| QO2 | Thu hồi uỷ quyền Tổ phó có hiệu lực ngay hay ở lần đăng nhập sau? Đang ở giữa 9 bước thì có gửi được không? Cán bộ Phòng Camera có được uỷ quyền Tổ phó không (nếu có thì [Q31] hay §3.3 thắng)? | D08; TA-mo-ta-v1 B1(c) | TC-05, 06 |
| QO3 | Tab Tiếp nhận có nút + không (Kích hoạt XL01 chỉ nêu Trang chủ và Của tôi)? | D07 | TC-01 |
| QO4 | Đóng màn / thoát giữa chừng / app chuyển nền hoặc bị đóng: dữ liệu giữ hay huỷ, có hỏi xác nhận không? | D09; TA-mo-ta-v1 O4 (phần còn lại); wireframe V10 | TC-10 |
| QO5 | Ảnh bằng chứng: số ảnh tối đa? Xoá ảnh trước khi gửi được không? Thông báo khi ảnh > 50MB? "Gắn thời gian" là chèn lên ảnh hay lưu kèm dạng dữ liệu? Ảnh từ thư viện có GPS có bị loại bỏ toạ độ không? | D10; TA-mo-ta-v1 O2 (phần còn lại) | TC-13, 15, 16, 17 |
| QO6 | Hành vi khi từ chối quyền Camera / Ảnh / Micro của iOS (thông báo, dẫn tới Cài đặt)? | D11; TA-mo-ta-v1 O17 | TC-18, 29 |
| QO7 | Bước 2 có chọn sẵn mục đầu tiên không (ảnh cho thấy có)? | D12; TA-mo-ta-v1 O5 (phần còn lại); wireframe V9 | TC-11, 19 |
| QO8 | Danh mục loại hai cấp hiển thị và chọn thế nào (chọn được loại cha không)? "Khác": bắt buộc nhập tên, độ dài tối đa; loại "Khác" có biểu mẫu không? | D13; TA-mo-ta-v1 O6 (phần còn lại) | TC-22, 23, 24 |
| QO9 | Mô tả chỉ có khoảng trắng có tính là trống không? Độ dài tối đa? | D14; TA-mo-ta-v1 O3 (phần còn lại) | TC-27, 28 |
| QO10 | Trường bắt buộc trong một đối tượng; đối tượng rỗng có được lưu không; định dạng Ngày sinh; độ dài/định dạng số CCCD/CMND, số hộ chiếu; ràng buộc Quốc tịch ↔ loại giấy tờ; danh sách quốc tịch? | D16; TA-mo-ta-v1 O8; wireframe V7 | TC-38, 39 |
| QO11 | Nhận dạng thất bại / điền thiếu thì app làm gì? Quét hộ chiếu thì số giấy tờ vào ô nào? Ảnh chụp khi quét có bị lưu vào thư viện Ảnh của iPhone không? | D17; TA-mo-ta-v1 O7 (phần còn lại); wireframe V12; CRE-Q03 (phần còn lại) | TC-32, 33, 35, 36 |
| QO12 | "Số lượng đối tượng" có được lưu không (§8.1 không có trường này) và hiển thị ở đâu? | D18 | TC-31 |
| QO13 | Nút "Tra biển số" đang có trên app phải ẩn hay giữ (không có tra cứu theo [Q35])? | D19; CRE-Q05 (phần còn lại) | TC-41 |
| QO14 | Đề xuất "Khác" có ô nhập nội dung không? | D20; TA-mo-ta-v1 O12 | TC-43 |
| QO15 | Tìm theo email: khớp một phần? Phân biệt hoa/thường? Hiển thị gì khi không có kết quả? | D21; TA-mo-ta-v1 O13 | TC-47 |
| QO16 | Người giao có tự giao cho chính mình được không? Chọn người có quyền giao khác (Tổ phó, Đội trưởng) làm người nhận được không, và khi đó phần việc hiện nút theo cột nào của ma trận §3.4? | D22; TA-mo-ta-v1 B3 (phần còn lại) | TC-48 |
| QO17 | Hạn: đã quá 17:00 hôm nay thì giờ mặc định là gì? "Quá khứ" kiểm lúc chọn hay lúc gửi? Độ chi tiết phút? Thiết bị đặt múi giờ khác thì hiển thị thế nào? | D23; TA-mo-ta-v1 O1 (phần còn lại) | TC-50, 51, 52 |
| QO18 | Mất mạng khi gửi: dữ liệu có được giữ để gửi lại không? Lỗi máy chủ thì báo gì? Có chống tạo trùng khi bấm gửi nhiều lần không? | D24; TA-mo-ta-v1 O16 (phần còn lại) | TC-07, 55 |
| QO19 | NỘI DUNG của phần việc tạo từ XL01 lấy từ đâu (Mô tả vụ việc?)? Nhật ký "Giao việc" (Lịch sử) và "Phân công" (Diễn biến xử lý) là một bản ghi hay hai? | D25 | TC-56, 62 |
| ~~QO20~~ | ✅ **Đã giải quyết** bởi quyết định QB1(d): cảnh báo Khẩn cấp gửi cho Trưởng CACK, Phó trưởng CACK và Chỉ huy Đội của vụ việc. (Chi tiết nhỏ còn lại — người tạo chính là một trong những người nhận thì có tự nhận không — chuyển vào QO30.) | D06; CRE-Q01 | TC-26 |
| QO21 | Có ngưỡng độ chính xác cho nhận dạng giấy tờ và giọng nói không? Chỉ tiêu hiệu năng đề xuất ở §10 đã được duyệt chưa? | D15 | TC-29, 32, 33 |
| QO22 | Đề nghị sửa câu §8.1 "sửa được, không xoá (BR31)" cho khớp BR31/XL05 ("không thể sửa") — đặc tả đã tự xử lý ở PL-C #13, chỉ là sửa câu chữ. | D26 | (ảnh hưởng chéo XL05) |
| QO23 | (Phạm vi / dự án) Đặc tả §10 và [Q32] ghi "iOS và Android"; L4 "tạm thời chỉ iPhone"; bảng đối chiếu trong `lam-ro` dòng L4 ghi đặc tả "không nêu hệ điều hành" — chưa chính xác. Xác nhận đợt này chỉ test iPhone (A3)? Model iPhone, phiên bản iOS tối thiểu, build mục tiêu? Bộ giấy tờ **mẫu giả** cho 4 loại giấy tờ lấy ở đâu? | D27; TA-mo-ta-v1 O19 | Môi trường test; TC-32, 33 |
| ~~QO24~~ | ✅ **Đã đóng (cập nhật lần 4):** QC lead chấp nhận căn cứ risk A1/A2 ngày 2026-10-26. Câu hỏi gốc: User có chấp nhận căn cứ risk ở A1 (likelihood theo độ phức tạp kỹ thuật) và A2 (impact theo §2.1 và tính nhạy cảm dữ liệu) không, hay có thông tin business impact để thay thế? | D29; TA-mo-ta-v1 O18 | Toàn bộ cột risk mục 2 |
| QO25 | **⚑ suy ra, cần xác nhận:** vụ việc do Trưởng/Phó trưởng CACK tạo có hiện ở tab Tiếp nhận của **mọi người giao trong Đội được chọn** không (và có hiện ở Tiếp nhận của chính Trưởng/Phó trưởng CACK theo hậu điều kiện XL01 không)? | D03; QB1(c) (ghi chú của orchestrator) | TC-59 (partition CACK) |
| QO26 | Vụ việc giao nhiều cán bộ cùng Đội nhưng khác Tổ: thẻ hiện Tổ nào? Khối "Thông tin vụ việc" ở Chi tiết (Đội phụ trách, Tổ) có cùng quy tắc "lấy từ người được giao" không? Nguồn phát hiện có giá trị gì (nguồn Camera, Chỉ đạo đã bỏ [B14])? | D02, D31; V3 | TC-63 |
| QO27 | Đội **chưa được gán khu vực nào** thì bước 2 hiển thị gì — có tạo được vụ việc không? | D32 | TC-20 |
| QO28 | (Tài liệu) Đề nghị người viết đặc tả sửa: [B7], BR16, CH07 theo quyết định QB1(d); XL01-B2, §3.2, BR36, [B25*] theo trả lời QB2 — để khi nghiệm thu không còn 2 nguồn nói khác nhau. | D05, D33 | TC-20, 26 |
| QO29 | Trưởng/Phó trưởng CACK đã chọn cán bộ rồi đổi Đội ở bước 8: cán bộ đã chọn bị xoá hay chặn đổi Đội? | QB1(a) | TC-46 |
| QO30 | Người tạo vụ việc Khẩn cấp chính là Trưởng/Phó trưởng CACK hoặc Chỉ huy Đội của vụ việc thì có tự nhận cảnh báo không? | QB1(d) | TC-26 |
| QO31 | (Cập nhật lần 3) Với Trưởng/Phó trưởng CACK, "khu vực của mọi Đội" có gồm khu vực trong danh mục **chưa gán cho Đội nào** không (tức là toàn bộ danh mục hay hợp các khu vực đã gán)? | D30; QB3 | TC-65 |

**Vì sao các câu hỏi trên không chặn (đối chiếu 4 lý do dừng ở mục 0 của skill):**
- *Mơ hồ đổi tập test condition:* các câu còn lại chỉ đổi **expected result** của một test condition đã có (quy tắc hợp lệ, thông báo lỗi, hành vi biên), không thêm/bớt test condition. QO25 là partition có expected **⚑ suy ra** của TC-59 — đã đánh dấu không dùng làm tiêu chí đạt/không đạt cho tới khi xác nhận.
- *Mâu thuẫn nội bộ:* D26 (§8.1 ↔ BR31) đặc tả tự xử lý ở PL-C #13; D33 ([B7], XL01-B2 ↔ trả lời QC lead) đã có quyết định của QC lead → QO22, QO28 chỉ là sửa câu chữ tài liệu.
- *Căn cứ risk:* mọi test condition đều đã có likelihood và impact kèm căn cứ (A1, A2 và nguồn ở cột "Nguồn"); QC lead đã chấp nhận A1/A2 (QO24 đóng, 2026-10-26).
- *Acceptance criteria:* test basis là đặc tả use case có quy tắc nghiệp vụ, không phải user story thiếu acceptance criteria.

**Lịch sử trạng thái:** cập nhật lần 3 là **DRAFT** vì mục 4 còn câu hỏi mở. Cập nhật lần 4 chuyển **READY** chỉ vì QC lead đã quyết định trực tiếp (đóng QO24, cho mang các câu còn lại sang test-plan) — QC không tự trả lời hay tự hạ cấp câu hỏi nào.

---

## 6. Đối chiếu với TA-mo-ta-v1 (truy vết câu hỏi đợt cũ)

> **Cập nhật lần 2:** những dòng dưới ghi "→ QB1" / "→ QB2" nay đã được QC lead trả lời (mục 4.1). Riêng TA-mo-ta-v1 B3/B4, V2, **V3**, CRE-Q02: đã trả lời bởi QB1(a)(b)(c); phần còn lại chuyển sang QO25, QO26, QO29. TA-mo-ta-v1 O5: phần giới hạn khu vực đã trả lời bởi QB2 và QB3 (cập nhật lần 3), còn QO7, QO27, QO31.

### 6.1 Câu hỏi chặn cũ (TA-mo-ta-v1 B1–B7)

| Mã cũ | Nội dung (tóm tắt) | Đặc tả v2.1 trả lời | Tình trạng | Mang sang |
|---|---|---|---|---|
| TA-mo-ta-v1 B1 | Cán bộ / Tổ phó chưa uỷ quyền có tạo vụ việc được không; cơ chế uỷ quyền | §3.1, §3.3, XL01 Tác nhân, [Q2, Q4, Q31, B2]; L2b đã thay theo đặc tả | **Đã trả lời** (Cán bộ không; Tổ phó luôn có quyền; "uỷ quyền Tổ phó" là cấp cho cán bộ; quản trị viên thu hồi). Còn chi tiết cách chặn, hiệu lực thu hồi | QO1, QO2 |
| TA-mo-ta-v1 B2 | Bước nào bắt buộc (text ↔ ảnh) | XL01 bảng "Các bước nhập"; BR04 | **Đã trả lời** | — (TC-11) |
| TA-mo-ta-v1 B3 | Giao cho Đội hay cán bộ; phạm vi danh sách; tự giao | XL01-B8, §3.2, [Q3, B3] | **Trả lời một phần**: giao cho cán bộ, có chọn Đội; phạm vi theo vai trò. Còn 1 hay nhiều Đội, Đội/Tổ của vụ việc, tự giao | **QB1**, QO16 |
| TA-mo-ta-v1 B4 | Tab Tiếp nhận của ai; trạng thái ban đầu; thông báo, nhật ký khi tạo | XL01 Hậu điều kiện, §4.1–4.2, BR35, CH07, [B24] | **Trả lời phần lớn** (trạng thái "Đang thực hiện"/"Đã giao"; thông báo cán bộ; nhật ký "Giao việc"; tab theo vai trò). Còn "được tạo trong Đội" tính theo Đội nào | **QB1** |
| TA-mo-ta-v1 B5 | Nút "Xử lý tại chỗ và hoàn thành" | §1.2, XL01-B9, [Q4] | **Đã trả lời** (ngoài phạm vi; chỉ có "Giao việc và gửi") | — (TC-53) |
| TA-mo-ta-v1 B6 | Các phần chỉ có trên ảnh: Khẩn cấp, Biển số xe/Tra biển số, Đơn vị liên quan, micro | XL01 Luồng thay thế, BR16, [B7]; XL01-B6, [Q35]; §10 Khả dụng, [B13] | **Đã trả lời** (đều thuộc phạm vi; không có tra cứu biển số). Còn "lãnh đạo trực tiếp", nút Tra biển số | QO20, QO13 |
| TA-mo-ta-v1 B7 | Ảnh giấy tờ có được lưu không; ai được xem dữ liệu đối tượng | XL01-B6, BR19, [Q18]; BR29, [B16]; §10 [B13] | **Đã trả lời** (không lưu ảnh giấy tờ; nhận dạng trên thiết bị; hiển thị đầy đủ cho người xem vụ việc). "Ai được xem" chuyển thành câu hỏi về tab Tiếp nhận | QB1 (phần ai xem), QO11 (thư viện Ảnh) |

### 6.2 Câu hỏi mở cũ (TA-mo-ta-v1 O1–O19)

| Mã cũ | Đặc tả v2.1 | Tình trạng | Mang sang |
|---|---|---|---|
| O1 Hạn | XL01-B9, BR06, [B8] | Trả lời phần lớn (không quá khứ, không giới hạn tối đa, 17:00 mặc định, giờ VN) | QO17 |
| O2 Bằng chứng | XL01-B1, BR20, [Q20, B12] | Trả lời một phần (chỉ ảnh, 50MB, gắn thời gian, không GPS) | QO5 |
| O3 Mô tả | XL01-B5 | Trả lời một phần (bắt buộc, nút mờ) | QO9 |
| O4 Quay lại / thoát | XL01 "Quay lại (giữ dữ liệu)" | Trả lời một phần (Quay lại giữ dữ liệu) | QO4 |
| O5 Nguồn danh sách khu vực | §8.2, [Q1, Q19] | Trả lời một phần (danh mục quản trị) | QO7, **QB2** |
| O6 Loại vụ việc, "Khác" | XL01-B3, §8.2, [Q19] | Trả lời một phần (2 cấp, "Khác" nhập tay) | QO8 |
| O7 Quét giấy tờ | XL01-B6, BR19, [Q18] | Trả lời một phần (4 loại giấy tờ; sửa được) | QO11 |
| O8 Hợp lệ trường đối tượng | XL01-B6 (chỉ liệt kê trường) | **Chưa trả lời** | QO10 |
| O9 Số lượng đối tượng | BR18, [Q17] | **Đã trả lời** (không cần khớp) | QO12 (chỗ lưu) |
| O10, O11 | (đã gộp vào B6 ở đợt cũ) | — | — |
| O12 Đề xuất "Khác" | XL01-B7 | **Chưa trả lời** | QO14 |
| O13 Tìm email | XL01-B8 | **Chưa trả lời** | QO15 |
| O14 Màn xem lại | XL01-B9 (liệt kê loại, mô tả, bằng chứng, người được giao) | **Đã trả lời** (nội dung tóm tắt do đặc tả chốt) | — (TC-49) |
| O15 Nhãn spec ↔ app | PL-C #3 (theo ảnh); đặc tả dùng "Giao việc và gửi" | **Đã trả lời** | — (TC-08) |
| O16 Lỗi gửi, tạo trùng, mã VV | XL01 Luồng thay thế (mất mạng); BR38, [B1] (mã) | Trả lời một phần (mất mạng không gửi; mã VV chung chuỗi) | QO18 |
| O17 Từ chối quyền | — | **Chưa trả lời** | QO6 |
| O18 Căn cứ risk | §2.1 cung cấp thêm căn cứ impact | Chưa trả lời | QO24 |
| O19 Thiết bị / giấy tờ mẫu | §10 (OS tối thiểu chưa định) | Chưa trả lời | QO23 |

### 6.3 Wireframe và checklist (lập trước đặc tả)

| Mã | Tình trạng theo đặc tả v2.1 | Mang sang |
|---|---|---|
| V1 (bắt buộc text ↔ app) | Đã trả lời — BR04 khớp hành vi trên ảnh (bước 6, 7 không bắt buộc) | TC-11 |
| V2 ("Đội nhận việc") | Đặc tả xác nhận có chọn Đội; câu hỏi 1/nhiều Đội còn mở | QB1 |
| **V3** (Tổ trên thẻ khác Đội ở bước 8) | Chưa trả lời — đặc tả không nói Tổ lấy từ đâu | **QB1**, TC-63 |
| V4 ("Xử lý tại chỗ") | Đã trả lời — ngoài phạm vi [Q4] | TC-53 |
| V5 (chức năng chỉ có trên ảnh) | Đã trả lời — đều thuộc phạm vi | TC-25, 26, 27, 29, 41 |
| V6 ("lưu dạng văn bản") | Đã trả lời — [Q18] | TC-36, 37 |
| V7 (quốc tịch nước ngoài ở ô CCCD) | Chưa trả lời | QO10 |
| V8 (màn xem lại thiếu thông tin) | Đặc tả chốt nội dung tóm tắt → không còn là vấn đề test basis | TC-49 |
| V9 (bước 2 chọn sẵn) | Chưa trả lời | QO7 |
| V10 (không có nút đóng) | Chưa trả lời | QO4 |
| V11 (tên bước/nút) | Đã trả lời — PL-C #3 | TC-08 |
| V12 (camera chụp thường) | Một phần — [B13] nhận dạng trên thiết bị | QO11 |
| CRE-Q01 (cảnh báo Khẩn cấp) | Một phần — [B7] (push ưu tiên cao, không SMS) | QO20 |
| CRE-Q02 (Tổ trên thẻ) | Chưa trả lời | QB1 |
| CRE-Q03 (camera iOS / nhận dạng ở đâu) | Một phần — [B13] trên thiết bị | QO11 |
| CRE-Q04 (2 kiểu icon khu vực) | Chưa trả lời — không ảnh hưởng test condition, không mang sang | — |
| CRE-Q05 (Tra biển số) | Một phần — [Q35] không có tra cứu | QO13 |
