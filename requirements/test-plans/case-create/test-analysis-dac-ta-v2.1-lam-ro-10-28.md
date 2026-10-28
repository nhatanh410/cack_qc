# Test Analysis — Tạo vụ việc xử lý vi phạm (XL01, flow `03_case-create`) — theo đặc tả v2.1 + làm rõ 2026-10-27/28

> **Analysis Status: READY** (cập nhật lần 3, 2026-10-28) — được phép chạy test-plan. Căn cứ: (1) không còn câu hỏi chặn (QB4–QB6 đã trả lời; 79/79 test condition đã xếp hạng risk); (2) QC lead chấp nhận căn cứ risk A1/A2 cho bộ này (QO41 đóng); (3) **quyết định trực tiếp của QC lead ngày 2026-10-28** — "Mang sang, chạy tiếp" cho QO42–QO45, cùng với quyết định trước đó cho các câu mở khác → mục 4 không còn câu hỏi nào phải làm rõ *trước khi* lập test plan. Các câu hỏi mở **vẫn còn hiệu lực** (mục 4.3) — test-plan phải mang theo dưới dạng "kết quả mong đợi còn mở", không coi là đã trả lời. Partition ⚑ (QO25, QO42) **không** dùng làm tiêu chí đạt/không đạt.
> **Downstream Permission: ALLOWED** — được phép chạy test-plan với điều kiện ở trên.
>
> **Lịch sử cập nhật:**
> - **Lần 1 (2026-10-28):** lập mới — BLOCKED (QB4, QB5, QB6 chặn; 4 test condition chưa xếp hạng).
> - **Lần 2 (2026-10-28):** áp dụng [trả lời QB4–QB6 và 2 quyết định của QC lead](../../specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-27.md) (mục "Trả lời câu hỏi chặn QB4–QB6 của test-analysis-dac-ta-v2.1-lam-ro-10-28"): (1) chấp nhận A1/A2 cho bộ này → QO41 đóng; (2) mang câu hỏi mở sang test plan dưới dạng "kết quả mong đợi còn mở". Xếp hạng TC-22, 50, 55, 69; viết lại TC-10, 51, 52, 66, 67, 70; thêm TC-78, TC-79 (QR); thêm vấn đề D51–D53 và câu hỏi QO42–QO45. Ảnh mới `03_case-create_09_assignee_qr-scan.png`. Trạng thái BLOCKED → **DRAFT** (QO42–QO45 chưa được QC lead cho mang sang).
> - **Lần 3 (2026-10-28):** áp dụng [quyết định của QC lead về QO42–QO45](../../specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-27.md) ("Mang sang, chạy tiếp") — chuyển QO42–QO45 từ mục 4.2 sang mục 4.3; bỏ banner DRAFT. Không đổi test condition, risk hay câu hỏi nào khác. Trạng thái DRAFT → **READY** chỉ vì QC lead đã quyết định trực tiếp — QC không tự trả lời hay tự hạ cấp câu hỏi nào.
>
> **Test basis (thứ tự ưu tiên khi mâu thuẫn — QC lead chốt):**
> 1. [lam-ro-2026-10-27.md](../../specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-27.md) — quyết định 2026-10-27/28; **câu trả lời sau thay câu trả lời trước**; dòng có ⚠️ đã bị thay (chỉ dùng truy vết); điểm có ⚑ / ❓ không phải fact. Hiện hành: L6, C2, C4 (phần không chọn hạn), C5–C8 (C8 phần Khẩn cấp đã thay), D1–D7, E1–E9, F1–F8, G1–G6, H1–H5, G3 (2026-10-28); **cập nhật lần 2:** trả lời QB4(a)–(d), QB5, QB6(a)–(d) và 2 quyết định (2026-10-28); **cập nhật lần 3:** quyết định "Mang sang, chạy tiếp" cho QO42–QO45 — QB6(a) có phần ⚑ suy ra, không dùng như fact. Còn mở: I1.
> 2. [lam-ro-2026-10-26.md](../../specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-26.md) — QB1(a)(b)(c), QB2, QB3 còn hiệu lực cho người giao việc; **QB1(d) phần cảnh báo Khẩn cấp đã bị G1 thay**.
> 3. [dac-ta-chuc-nang-v2.1.md](../../specs/xu-ly-vi-pham-giao-viec/dac-ta-chuc-nang-v2.1.md) — XL01 và các phần áp dụng: §1.2, §2.4 Tính năng 1, §3, §4, §8, §9, §10, CH07, Phụ lục A/B/C.
> 4. [mo-ta-chuc-nang-v1.md](../../specs/xu-ly-vi-pham-giao-viec/mo-ta-chuc-nang-v1.md) — chỉ khi các nguồn trên im lặng (lần này không cần dùng tới).
>
> **Bằng chứng giao diện (không phải test basis, chỉ đối chiếu):** [iphone/index.md](../../ui/ux/screenshots/iphone/index.md) (mô tả ảnh), [wireframe 03_case-create](../../ui/ux/wideframes/03_case-create.md) (lập trước đặc tả v2.1, mọi ảnh chụp bằng tài khoản Đội trưởng).
> **Tham khảo phương pháp (không phải test basis):** [test-analysis-dac-ta-v2.1-SUPERSEDED.md](test-analysis-dac-ta-v2.1-SUPERSEDED.md) (gọi tắt "TA-v2.1"; READY 2026-10-26, lập **trước** L6/C–H). Tái dùng cấu trúc, thang risk, câu hỏi mở QO còn hiệu lực. Các test condition dựa trên quyền cũ "cán bộ không tạo được vụ việc" đã bỏ hoặc viết lại.
> **Phạm vi:** XL01 và hậu điều kiện trực tiếp (vụ việc xuất hiện ở đâu, trạng thái gì, thông báo, cảnh báo Khẩn cấp, nhật ký, thống kê). Luồng tiếp nhận tại Đội (D4), Phê duyệt & đóng (G2), Huỷ phần việc (G3, I1): chỉ nêu **ảnh hưởng chéo** (mục 5). Ngoài phạm vi: trang quản trị web, tab Vật phẩm (H5), Yêu cầu bổ sung (E4), phần lãnh đạo xử lý Chờ chỉ đạo (F6), việc đặt hạn ở luồng cán bộ tạo / Đội trưởng phân công (E3).
> **Phạm vi vai trò (F2):** 2 nhóm — **người giao việc** (kiểm bằng tài khoản Đội trưởng/Chỉ huy Đội; Trưởng/Phó trưởng CACK khi nhánh cần) và **người nhận việc** (cán bộ hiện trường / Phòng Camera / Văn thư — vẫn tách vì quyền tạo khác nhau, L6/C6). Khác biệt giữa Tổ trưởng, Tổ phó, Phó Đội trưởng, cán bộ được uỷ quyền: **hoãn**, ghi ở mục 5, không thành câu hỏi chặn.
> **Nền tảng:** chỉ iPhone (L4).
> **Chuẩn:** ISTQB Foundation Level v4.0.1 §1.4.1 (Test Analysis) + §3 (Static Testing) + §5.2 (Risk Management)
> **Bước tiếp theo:** [test-plan](../../../.claude/skills/test-plan/SKILL.md) dùng mục 2 làm test object và cột risk level làm cơ sở mục 6 — **sẵn sàng chạy** (READY từ cập nhật lần 3). Test-plan phải mang theo các câu hỏi mở ở mục 4.3 dưới dạng expected result còn mở, và không dùng partition ⚑ (QO25, QO42) làm tiêu chí đạt/không đạt.
> **Ngày lập:** 2026-10-28 · **Cập nhật lần 2:** 2026-10-28 · **Cập nhật lần 3:** 2026-10-28 · **Người lập:** QC

### Quy ước dùng trong tài liệu

- **Ký hiệu nguồn:** `§n` = mục đặc tả v2.1; `XL01-Bn` = bước n bảng "Các bước nhập" của XL01; `TN1-An` = bước n bảng A Tính năng 1; `BRnn` = §9; `đặc tả [Qn]/[Bn]` = Phụ lục A/B; `PL-C #n` = Phụ lục C; `L6, C1…I1` = lam-ro-2026-10-27; `L2…L4, QB1…QB3` = lam-ro-2026-10-26.
- **Nhánh vai trò:** **[NG]** = người giao việc tạo vụ việc (Đội trưởng/Chỉ huy Đội; Trưởng/Phó trưởng CACK khi ghi rõ). **[CB]** = cán bộ tạo vụ việc (cán bộ hiện trường hoặc Phòng Camera). Không ghi = áp dụng cả hai.
- **"Đội nhận"** = Đội được chọn ở bước 8 (G1 "đội nhận vụ việc"). **"Đội người tạo"** = Đội của tài khoản tạo vụ việc.
- **⚑ suy ra** = QC suy từ nguồn, chưa được xác nhận → không dùng làm tiêu chí đạt/không đạt.
- **Dữ liệu cá nhân:** chỉ dùng tên trường; không chép họ tên, email, số giấy tờ, số điện thoại, mã cán bộ từ ảnh/spec.
- **Thang risk (định tính, §5.2, giữ như TA-v2.1):** Cao×Cao, Cao×Vừa, Vừa×Cao → **Cao (P1)** · Vừa×Vừa, Thấp×Cao, Cao×Thấp → **Vừa (P2)** · Vừa×Thấp, Thấp×Vừa, Thấp×Thấp → **Thấp (P3)**. "Chưa xếp hạng" = phụ thuộc câu hỏi chặn ở mục 4.1 (từ cập nhật lần 2: không còn test condition chưa xếp hạng).
- Mã `TC-nn`, `Dnn` của tài liệu này **đánh số riêng**; cột "TC cũ" ở mục 2 trỏ về mã của TA-v2.1. Câu hỏi mở giữ số QO của TA-v2.1 khi còn hiệu lực; câu mới đánh tiếp từ QO32; câu chặn mới đánh tiếp từ QB4.

### Giả định (KHÔNG phải fact)

> **Cập nhật lần 2:** QC lead đã **chấp nhận A1, A2 làm căn cứ risk cho bộ này** (2026-10-28 — QO41 đóng). A1, A2 vẫn là giả định đã được chấp thuận, không phải dữ liệu đo được.

| # | Giả định | Vì sao cần | Câu hỏi liên quan |
|---|---|---|---|
| A1 | **Risk likelihood** là ước lượng của QC theo độ phức tạp kỹ thuật và **độ ổn định của yêu cầu** (nhánh [CB] thay đổi 3 lần trong 2 ngày: L7 → L7a → E1/F1) — chưa có lịch sử lỗi. QC lead đã chấp nhận phương pháp này cho TA-v2.1 (QO24, 2026-10-26); việc **áp dụng cho các test condition mới** chưa được xác nhận riêng. | §5.2 cần căn cứ likelihood | QO41 |
| A2 | **Risk impact** suy từ §2.1 ("không thiếu thông tin trong quá trình giao nhận"), tính nhạy cảm dữ liệu đối tượng (§8.1, BR29), và việc vụ việc bị "kẹt" (không ai thấy / không ai xử lý) khi bàn giao sai. Cùng tình trạng chấp nhận như A1. | §5.2 cần căn cứ impact | QO41 |
| A3 | Phạm vi đợt test là **iPhone** (L4), dù đặc tả §10 ghi "iOS và Android". | Môi trường test | QO23 |
| A4 | Tài khoản theo **Vai trò** (C7), Đội của tài khoản, khu vực gán cho Đội (QB2), Phó trưởng CACK phụ trách Đội (D6, F3) được chuẩn bị sẵn trên trang quản trị — là **tiền điều kiện / dữ liệu kiểm thử**, không kiểm trang quản trị. | XL01 phụ thuộc cấu hình | — |
| A5 | Bước 1–7 của nhánh **[CB]** giống hệt nhánh [NG] (cùng trường, cùng quy tắc bắt buộc, cùng danh mục) — **trừ** bước 2 (C2 cho Phòng Camera; cán bộ hiện trường: QB5). Không nguồn nào nói khác, nhưng cũng không nguồn nào xác nhận. | Để không nhân đôi test condition bước 1–7 theo vai trò | QO32 |
| A6 | G1 chỉ thay **người nhận** cảnh báo Khẩn cấp; phần còn lại của đặc tả [B7]/BR16 ("thông báo đẩy ưu tiên cao, không bắt buộc xác nhận") vẫn giữ. | Expected của TC-73 | QO38 |

---

## 1. Đánh giá testability của test basis

### 1.1 Tình trạng các vấn đề của TA-v2.1 (D01–D33)

| Mã cũ | Tình trạng sau lam-ro-2026-10-27 | Mang sang |
|---|---|---|
| D01 (1 hay nhiều Đội) | Đã trả lời QB1(a) cho [NG]; [CB] chọn đúng 1 Đội (E1) | — |
| D02, D31 (Đội phụ trách, Tổ, Nguồn phát hiện) | Còn mở, mở rộng cho [CB] (D43) | QO26 |
| D03 ("được tạo trong Đội") | [NG] cấp Đội: đã trả lời QB1(c). Trưởng/Phó trưởng CACK: QO25 (⚑). **[CB] bàn giao Đội khác:** D35 → QB4 ✅ (lần 2) | QO25 |
| D04, D05, D30 (khu vực bước 2) | Đã trả lời QB2, QB3 cho [NG]; Phòng Camera: C2; cán bộ hiện trường: QB5 ✅ (lần 2) | — |
| D06 (người nhận Khẩn cấp) | QB1(d) **đã bị G1 thay** | D41 → QO38 |
| D07 (nút + ở đâu, cách chặn) | Văn thư "không thấy nút" (C6) → QO1 đóng. Nút + ở tab Tiếp nhận / Của tôi: còn mở (D48) | QO3 |
| D08 (thu hồi uỷ quyền; Phòng Camera được uỷ quyền) | **Hoãn** theo F2 (vai trò uỷ quyền chưa kiểm) | QO2 (hoãn) |
| D09–D25 | Không có câu trả lời mới; còn mở như TA-v2.1 | QO4–QO19 |
| D23 (hạn) | Chỉ còn áp dụng cho [NG]; [CB] không chọn hạn (C4, D2) | QO17 |
| D26, D27 | Không đổi | QO22, QO23 |
| D28 (trang quản trị) | GAP, không kiểm được | — |
| D29 (căn cứ risk) | Phương pháp đã chấp nhận; QC lead chấp nhận áp dụng cho bộ này (lần 2) | QO41 ✅ đóng |
| D32 (Đội chưa gán khu vực) | Còn mở, nay gồm cả Đội của cán bộ Phòng Camera | QO27 |
| D33 (sửa đặc tả) | Mở rộng thêm các điểm của L6/C–G (D34, D52) | QO28 |

### 1.2 Vấn đề mới khi đọc lam-ro-2026-10-27

| # | Trích đoạn / mục trong test basis | Vấn đề | Loại | Cần hỏi ai | → Câu hỏi |
|---|---|---|---|---|---|
| D34 | L6, C6: cán bộ hiện trường và Phòng Camera tạo được vụ việc ↔ đặc tả §3.1 ("Phòng Camera không có quyền tạo vụ việc" [Q31]), §3.3, §3.4 dòng XL01 ("Cán bộ được chỉ định: Không"), XL01 Tác nhân, BR01, [Q4] | Mâu thuẫn giữa nguồn, **đã có quyết định** của QC lead (lam-ro thắng). Không chặn; chỉ cần sửa đặc tả để khi nghiệm thu không còn hai nguồn nói khác nhau. | Mâu thuẫn giữa nguồn (đã có quyết định) | Người viết đặc tả | QO28 |
| D35 | Đặc tả XL01 Hậu điều kiện: "hiện ở tab Tiếp nhận và tab Của tôi **của người giao**, tab Của tôi của cán bộ được chỉ định"; BR35/[B24]: "Tiếp nhận: tất cả vụ việc **được tạo trong Đội**. Của tôi: vụ việc **tôi đã giao** hoặc được chỉ định làm"; D1: không chỉ định → "tab Tiếp nhận [của Đội trưởng Đội nhận]"; E2: có chỉ định → "Đang thực hiện"; C5: Đội trưởng **của cán bộ được phân công** có quyền gia hạn, phân công lại, hoàn thành; C8: **Đội trưởng Đội người tạo** nhận thông báo | Khi **[CB]** của Đội A bàn giao cho Đội B, nguồn không nói vụ việc hiện ở đâu với: **(1) chính cán bộ tạo** — cách hiểu (a) "đã giao" gồm "bàn giao" → thấy ở tab Của tôi; (b) không thấy ở đâu sau khi gửi (C5 "chỉ có quyền tạo"). **(2) Đội trưởng Đội A** (Đội người tạo) — (a) "được tạo trong Đội" = Đội người tạo → thấy ở tab Tiếp nhận; (b) chỉ nhận thông báo (C8), không thấy ở Tiếp nhận; khi đó bấm thông báo mở được vụ việc hay không? **(3) Đội trưởng Đội B khi đã chỉ định người** (vụ việc "Đang thực hiện" ngay, không qua Chờ tiếp nhận) — (a) thấy ở Tiếp nhận (⚑ suy ra từ C5: họ có quyền quản lý nên phải thấy); (b) chỉ nhận thông báo. Mỗi cách hiểu cho **tập người được xem vụ việc khác nhau**, mà vụ việc chứa dữ liệu cá nhân hiển thị đầy đủ (BR29, [B16]) → test condition kiểm soát truy cập khác hẳn nhau. | Mơ hồ (≥2 cách hiểu → tập test condition khác nhau; ảnh hưởng bảo mật) | QC lead | **QB4** → ✅ **Đã trả lời (lần 2):** (1) người tạo thấy ở tab Của tôi, không có thao tác; (2) Đội trưởng Đội A thấy ở tab Tiếp nhận, mở chi tiết, thao tác được "Hoàn tất xử lý"; (3) Đội trưởng Đội B (đã chỉ định) cũng thấy ở Tiếp nhận và thao tác được "Hoàn tất xử lý"; Đội A = Đội B không khác. Còn mở: D52, D53 |
| D36 | C2: "Ở bước 2, **phòng camera** thấy các khu vực của đội mình phụ trách"; QB2: "hiển thị các khu vực mà **đội đó** được chỉ định phụ trách" (trả lời cho người giao); E1: cán bộ chọn Đội nhận ở **bước 8**, sau bước 2 | Không nguồn nào nói **cán bộ hiện trường** thấy khu vực nào ở bước 2. Cách hiểu: (a) khu vực của **Đội mình** (như C2); (b) **toàn bộ** khu vực (như Trưởng/Phó trưởng CACK — QB3), vì cán bộ bàn giao được cho mọi Đội; (c) khu vực của **Đội nhận** — nhưng Đội nhận chọn ở bước 8, nên phải có kiểm tra nhất quán khu vực ↔ Đội ở bước 8 (giống cách hiểu (c) của D30 cũ). Cách (c) sinh thêm test condition kiểm nhất quán mà (a), (b) không có; (a) và (b) khác nhau về phạm vi dữ liệu hiển thị. | Mơ hồ (3 cách hiểu → tập test condition khác nhau) | QC lead | **QB5** → ✅ **Đã trả lời (lần 2):** cách hiểu (a) — khu vực được phân công cho Đội của cán bộ đó (giống C2). Không có kiểm tra nhất quán khu vực ↔ Đội nhận |
| D37 | F5: "Người tạo vụ việc sẽ quét mã của cán bộ hiện trường nhận vụ việc. Vụ việc chuyển qua trạng thái 'đang thực hiện'"; G4: Bàn giao bằng mã QR có ở "cả 2" (bước chỉ định người khi tạo vụ việc **và** bảng Bàn giao Đội khác); E1: **bắt buộc** chọn 1 Đội; F1: chỉ định tối đa 1 cán bộ hiện trường | Không có ảnh, không có mô tả màn QR ở bước tạo vụ việc. Chưa rõ: (1) QR **thay** việc chọn Đội (Đội lấy theo cán bộ được quét) hay **bổ sung** sau khi đã chọn Đội (phải khớp Đội đã chọn)? Hai cách hiểu cho 2 tập test condition khác nhau (cách 2 có thêm điều kiện từ chối mã của cán bộ khác Đội). (2) Quét mã của cán bộ **không phải** hiện trường (Phòng Camera, Văn thư, người giao), của **chính mình**, mã không hợp lệ: chặn hay chấp nhận? (3) "Người tạo vụ việc" ở F5 có gồm **người giao việc** không — tức bước 8 của [NG] có nút QR không (thêm/bớt một test condition)? (4) Ghi chú trên bảng Bàn giao Đội khác "không cần Đội trưởng/Phó của họ tiếp nhận. Chỉ huy Đội nhận vẫn nhận được thông báo" — có áp dụng cho QR lúc tạo vụ việc không? | Thiếu + mơ hồ (chức năng mới không có mô tả; cách hiểu đổi tập test condition) | QC lead / dev | **QB6** → ✅ **Đã trả lời (lần 2):** (1) quét QR **thay cho** chọn Đội được (Đội nhận = Đội của cán bộ được quét: **⚑ suy ra**); (2) mã của người không phải cán bộ hiện trường → thông báo lỗi "chỉ giao việc cho cán bộ hiện trường"; (3) người giao việc **không có** nút QR; (4) ảnh `03_case-create_09_assignee_qr-scan.png`: khung quét, "Đang tra cứu cán bộ...", nút "Chọn ảnh QR" / "Huỷ"; cán bộ nhận mở "Mã QR của tôi" từ Trang chủ. Còn mở: D51 |
| D38 | C4, D2: [CB] **không có bước chọn hạn**; đặc tả XL01-B9 "Xem lại và gửi": tóm tắt loại, mô tả, bằng chứng, người được giao + chọn ngày giờ hạn; PL-C #3 (tên bước theo ảnh) | Không nói bước 9 của [CB] trông thế nào: có còn là "Bước 9/9" không (hay 8 bước), tóm tắt có hiện **Đội nhận** khi không chỉ định người không, nhãn nút gửi là gì ("Giao việc và gửi" hay "Gửi tiếp nhận"…). Chỉ đổi expected result. | Thiếu | QC lead / dev | QO35 |
| D39 | E2: có chỉ định → "Đang thực hiện. **Không có hạn** hoàn thành"; E3: "tạm thời bỏ qua bước chọn hạn"; BR09–BR11 (đúng hạn / quá hạn / nhắc việc tính theo hạn); CH05 ô "Quá hạn" | Phần việc không có hạn → Hạn, NHẮC VIỆC, Kết quả "Hoàn thành đúng hạn / Không hoàn thành đúng hạn", nhãn "Quá hạn xử lý" **không xác định được**. E3 đã quyết định tạm bỏ kiểm phần đặt hạn → các hành vi phụ thuộc hạn ở nhánh [CB] là **GAP** (mục 3). Chỉ còn ghi nhận cách hiển thị khi chưa có hạn. Bộ đếm "Giao việc x/y" khi vụ việc Chờ tiếp nhận (chưa có phần việc) cũng không được nói. | Thiếu / không kiểm được (đã có quyết định tạm bỏ) | QC lead | QO36 |
| D40 | C8: thông báo gửi "Đội trưởng của cán bộ tạo vụ việc, Đội trưởng của cán bộ nhận vụ việc, cán bộ được chỉ định"; D1: không chỉ định → "Đội trưởng của đội đó sẽ nhận thông báo"; D6 (phần cuối "2 Đội trùng nhau thì mỗi người nhận 1 thông báo?") không được trả lời | (1) Đội người tạo = Đội nhận → Đội trưởng nhận 1 hay 2 thông báo? (2) Tiêu đề/nội dung thông báo cho Đội trưởng (đặc tả chỉ có "Bạn có phần việc mới" cho cán bộ được chỉ định). (3) "Đội trưởng" theo F2 kiểm bằng Đội trưởng/Chỉ huy Đội; E7 "Tổ phó được uỷ quyền" cũng xử lý Chờ tiếp nhận → hoãn. Chỉ đổi expected result. | Thiếu | QC lead | QO37 |
| D41 | G1: Khẩn cấp gửi "Phó trưởng CACK phụ trách Đội nhận"; "Chưa có phó trưởng phụ trách thì chỉ thông báo đến **đội trưởng, đội phó**"; F3/E8: Trưởng CACK không gán theo Đội; ghi chú trên màn bước 4 (ảnh, XL01-B4): "Cảnh báo Lãnh đạo + **BCH đội**" | (1) "Đội phó" có phải vai trò **Phó Đội trưởng** trong 11 vai trò (C7) không — F2 hoãn khác biệt của Phó Đội trưởng, nhưng ở đây là **người nhận**. (2) Ghi chú "Cảnh báo Lãnh đạo + BCH đội" trên màn không còn khớp quy tắc G1 (khi Đội có Phó trưởng phụ trách, BCH đội không nhận cảnh báo Khẩn cấp) — giữ, sửa câu chữ, hay là lỗi? (3) A6: tính chất "ưu tiên cao, không bắt buộc xác nhận" còn giữ không. | Mơ hồ nhẹ / mâu thuẫn ảnh ↔ quyết định | QC lead | QO38 |
| D42 | F1: "Cán bộ chỉ chỉ định được 1 cán bộ hiện trường"; E1: người xử lý thuộc Đội được bàn giao; C3 (cũ, ⚠️ đã thay) từng ghi "trừ chính mình" | Không nói: cán bộ hiện trường chọn Đội mình rồi **chỉ định chính mình** được không (C3 cũ loại trừ, nhưng C3 đã bị thay); đổi Đội ở bước 8 sau khi đã chỉ định thì người đã chọn bị bỏ hay chặn; tìm cán bộ theo **email** (như XL01-B8) hay theo **tên** (như bảng Phân công); danh sách Đội có loại trừ Đội nào không. Chỉ đổi expected result. | Thiếu | QC lead | QO34 |
| D43 | QB1(b): "Tên Đội/Tổ hiển thị trên thẻ vụ việc lấy từ đội của **người được giao việc**"; ảnh `04_case-handling_02_case-detail_pending`: chi tiết có "Đội phụ trách", "Tổ", "**Nguồn phát hiện: Phòng Camera**"; đặc tả §1.2/[B14]: nguồn Camera **bỏ qua** | Vụ việc Chờ tiếp nhận **không có người được giao** → Đội/Tổ trên thẻ lấy từ đâu (Đội nhận? Đội người tạo?). Ảnh cho thấy Nguồn phát hiện được ghi theo loại cán bộ tạo — trái với [B14] "bỏ qua nguồn Camera". Giá trị Nguồn phát hiện khi cán bộ hiện trường / người giao tạo? | Thiếu / mâu thuẫn ảnh ↔ đặc tả | QC lead | QO26 |
| D44 | QB1(d): "User ở đội nào thì sẽ hiện thống kê của đội đó"; CH05/[B19]: ô Chờ tiếp nhận, Chờ chỉ đạo, Đã đóng "gắn trạng thái chưa dùng nên hiện 0"; E6: các trạng thái này nay **được dùng** | (1) Vụ việc do cán bộ Đội A bàn giao Đội B được tính vào thống kê của Đội nào (A, B, hay cả hai)? (2) Ô Chờ tiếp nhận không còn luôn bằng 0 — câu chữ CH05/[B19] lỗi thời. | Mơ hồ / mâu thuẫn giữa nguồn (thời điểm) | QC lead | QO39 |
| D45 | Đặc tả XL01 Hậu điều kiện: "ghi nhật ký 'Giao việc'"; ảnh `case-detail_pending`: Diễn biến xử lý ghi "**Gửi tiếp nhận**" (vai trò + Đội + giờ) | Nhánh [CB] không chỉ định ghi "Gửi tiếp nhận" (quan sát ảnh, chưa có mô tả nghiệp vụ). Nhánh [CB] có chỉ định / quét QR ghi mốc gì? Lịch sử phần việc ghi "Giao việc" với người thực hiện là cán bộ tạo? (Mở rộng QO19.) | Thiếu | QC lead | QO40 |
| D46 | L6: cán bộ "thấy nút + Tạo vụ việc **ở Trang chủ**"; đặc tả XL01 Kích hoạt: "nút + ở Trang chủ **hoặc tab Của tôi**" | Không nói cán bộ hiện trường / Phòng Camera có nút + ở **tab Của tôi** không (tài khoản cán bộ không có tab Tiếp nhận — BR35). | Thiếu | QC lead | QO3 |
| D47 | C7: loại cán bộ là trường **Vai trò** đặt ở trang quản trị | Đổi Vai trò (Văn thư ↔ hiện trường) có hiệu lực ngay hay ở lần đăng nhập sau; đang ở giữa 9 bước thì gửi được không. | Thiếu | QC lead / dev | QO33 |
| D48 | E1/F1/C2 chỉ nói bước 2 và bước 8–9 của [CB] | Không nguồn nào nói bước 1, 3–7 của [CB] khác [NG] → đang dùng giả định A5. | Thiếu | QC lead | QO32 |
| D49 | E3 / C4 / D2 (không chọn hạn) ↔ đặc tả XL01-B9, BR04 ("hạn bắt buộc"); E1 (Đội bắt buộc, cán bộ tuỳ chọn) ↔ BR04 ("ít nhất một cán bộ"); C2/E1 (bàn giao mọi Đội) ↔ §3.2 | Mâu thuẫn giữa nguồn, **đã có quyết định** cho nhánh [CB]; nhánh [NG] vẫn theo BR04. Chỉ cần sửa đặc tả. | Mâu thuẫn giữa nguồn (đã có quyết định) | Người viết đặc tả | QO28 |
| D50 | G1 "Áp dụng cho cả vụ việc do người giao việc tạo"; QO30 của TA-v2.1 | Phó trưởng CACK tạo vụ việc Khẩn cấp cho chính Đội mình phụ trách → có tự nhận cảnh báo không. | Thiếu | QC lead | QO30 |

**Vấn đề phát sinh khi áp dụng trả lời QB4–QB6 (cập nhật lần 2):**

| # | Trích đoạn / mục trong test basis | Vấn đề | Loại | Cần hỏi ai | → Câu hỏi |
|---|---|---|---|---|---|
| D51 | QB6(a): "Quét thay cho chọn đội được" (kết luận ⚑ suy ra: Đội nhận = Đội của cán bộ được quét); QB6(b): "Show thông báo lỗi chỉ giao việc cho cán bộ hiện trường"; ảnh `qr-scan`: nút "Chọn ảnh QR", dòng "Đang tra cứu cán bộ..." | (1) Đội nhận khi dùng QR **chưa được nói thẳng** — đây là cách hiểu duy nhất khớp E1 (người xử lý thuộc Đội được bàn giao) nhưng vẫn là suy ra; nó quyết định Đội trưởng nào thấy vụ việc ở Tiếp nhận, ai nhận thông báo C8 / cảnh báo Khẩn cấp G1, thống kê Đội nào. (2) Đã chọn Đội ở bước 8 rồi mới quét mã cán bộ hiện trường của **Đội khác** thì sao (Đội bị thay, hay báo lỗi)? (3) Chưa trả lời: quét **mã của chính mình** (vd qua "Chọn ảnh QR"), mã **không hợp lệ** / không phải mã cán bộ, mất mạng khi "Đang tra cứu cán bộ". Các điểm này **không thêm/bớt test condition** (TC-55, TC-78 đã có) — chỉ đổi expected result → câu hỏi mở; partition ⚑ không dùng làm tiêu chí đạt/không đạt. | Mơ hồ nhẹ (⚑) / thiếu | QC lead | QO42, QO43 |
| D52 | QB4(b): Đội trưởng Đội A "có thể thao tác **Hoàn tất xử lý** vụ việc"; QB4(c): Đội trưởng Đội B "cũng có thể thao tác Hoàn tất xử lý"; C5: quyền "gia hạn, phân công lại hay **hoàn thành**" thuộc "đội trưởng của cán bộ được phân công xử lý"; đặc tả: nút "Hoàn thành" trên phần việc (XL02, [Q7]); E6 (câu hỏi cũ chưa trả lời): nút nhanh "Hoàn tất xử lý" trên thẻ ở tab Tiếp nhận | "Hoàn tất xử lý" là **tên nút nhanh trên thẻ** ở tab Tiếp nhận; **chưa rõ** quan hệ với nút "Hoàn thành" của phần việc và trạng thái "Đã hoàn thành"/"Đã xử lý" (có cần nhập kết quả, chuyển vụ việc sang trạng thái nào, áp dụng cho vụ việc Chờ tiếp nhận không). Nếu "Hoàn tất xử lý" = Hoàn thành thì QB4(b) **mở rộng** C5 (Đội trưởng Đội người tạo cũng hoàn thành được) — theo quy tắc "câu trả lời sau thay câu trước", QC không coi đây là mâu thuẫn chặn nhưng **không tự đồng nhất** hai nút. Cũng chưa rõ Đội trưởng Đội A có thấy các nút quản lý khác (Gia hạn, Phân công lại, Thao tác) không. Với XL01, chỉ cần kiểm **sự có mặt** của nút; hành vi của nút thuộc luồng tiếp nhận / xử lý (ảnh hưởng chéo). | Mơ hồ / thiếu | QC lead | QO44 |
| D53 | QB4(a): người tạo thấy ở tab Của tôi "Tuy nhiên sẽ không có thao tác gì"; đặc tả [Q7]: cán bộ không được chỉ định vẫn có nút **Lịch sử**; XL05/[B21]: thêm ảnh bằng chứng chỉ cho người giao và cán bộ được chỉ định | "Không có thao tác gì" có bao gồm việc **không có nút Lịch sử** và **không thêm được ảnh** (nút Chụp ảnh / Thư viện ở khối Hình ảnh/Bằng chứng) không? Chỉ đổi expected result của TC-70. | Mơ hồ nhẹ | QC lead | QO45 |

**Tổng: 20 vấn đề mới (D34–D53)**. Lần 1: 3 vấn đề chặn (D35, D36, D37 → QB4, QB5, QB6) — **đã trả lời ở lần 2**. Lần 2 thêm D51–D53 (chỉ đổi expected result, không chặn). 2 mâu thuẫn giữa nguồn đã có quyết định (D34, D49); còn lại là thiếu/mơ hồ chỉ đổi expected result.

---

## 2. Test condition đã ưu tiên hoá

### 2.A Quyền tạo vụ việc và điểm vào

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | TC cũ |
|---|---|---|---|---|---|---|---|---|
| TC-01 | [NG] Tài khoản Đội trưởng/Chỉ huy Đội và Trưởng/Phó trưởng CACK thấy nút + Tạo vụ việc ở Trang chủ và tab Của tôi, mở được "Tạo vụ việc" ở "Bước 1/9" (nút + ở tab Tiếp nhận: QO3). Các vai trò người giao khác: hoãn (F2) | XL01 Tác nhân, Kích hoạt; §3.1; TN1-A1; F2 | Functional + Security (kiểm soát truy cập) | Vừa | Cao | Cao | P1 | TC-01 |
| TC-02 | **Cán bộ hiện trường** thấy nút + Tạo vụ việc ở Trang chủ, mở được "Tạo vụ việc" và gửi được vụ việc (nút + ở tab Của tôi: QO3) | L6, C6 (thay §3.1, §3.3, [Q4]) | Functional + Security | Cao | Cao | Cao | P1 | (mới; thay TC-04 cũ) |
| TC-03 | **Cán bộ Phòng Camera** thấy nút + Tạo vụ việc ở Trang chủ, mở được và gửi được vụ việc (nút + ở tab Của tôi: QO3) | L6, C6 (thay [Q31]) | Functional + Security | Cao | Cao | Cao | P1 | (mới; thay TC-05 cũ) |
| TC-04 | **Cán bộ Văn thư** không thấy nút + Tạo vụ việc (Trang chủ, tab Của tôi) và không mở được màn "Tạo vụ việc" | C6 | Security | Vừa | Cao | Cao | P1 | TC-04 |
| TC-05 | Quyền tạo đi theo trường **Vai trò** của tài khoản: đổi Vai trò (Văn thư ↔ cán bộ hiện trường / Phòng Camera) thì nút + hiện/ẩn theo (thời điểm hiệu lực, đang giữa 9 bước: QO33) | C7 | Security | Vừa | Vừa | Vừa | P2 | (mới; thay TC-06 cũ — thu hồi uỷ quyền hoãn theo F2) |
| TC-06 | Mất kết nối mạng: không gửi được vụ việc, không lưu nháp ngoại tuyến (giữ dữ liệu để gửi lại hay không: QO18) | XL01 Tiền điều kiện, Luồng thay thế; BR17; [Q32] | Non-functional (Reliability) | Vừa | Cao | Cao | P1 | TC-07 |

### 2.B Điều hướng và tính bắt buộc

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | TC cũ |
|---|---|---|---|---|---|---|---|---|
| TC-07 | Thanh tiến độ "Bước n/9" và tên bước đúng thứ tự cho cả 2 nhánh (nhánh [CB] có còn 9 bước, tên bước 8/9: QO35) | XL01; PL-C #3 | Non-functional (Usability) | Thấp | Thấp | Thấp | P3 | TC-08 |
| TC-08 | "Quay lại" giữ nguyên dữ liệu đã nhập ở mọi bước; đổi giá trị ở bước trước rồi đi tiếp thì vụ việc lưu giá trị mới | XL01 "Quay lại (giữ dữ liệu đã nhập)" | Functional | Vừa | Vừa | Vừa | P2 | TC-09 |
| TC-09 | Đóng màn / thoát giữa chừng / app chuyển nền hoặc bị đóng: dữ liệu giữ hay huỷ, có hỏi xác nhận không (QO4) | XL01 (không nói) | Functional / Reliability | Vừa | Vừa | Vừa | P2 | TC-10 |
| TC-10 | Nút "Tiếp tục"/gửi chỉ sáng khi bước hợp lệ, theo **bảng bắt buộc theo nhánh**: bước 1, 6, 7 tuỳ chọn; bước 2, 3, 4, 5 (Mô tả vụ việc) bắt buộc (cả 2 nhánh, A5); bước 8 — [NG]: Đội + ≥1 cán bộ; [CB]: **Đội bắt buộc (chọn trong danh sách, hoặc quét QR cán bộ hiện trường thay cho chọn Đội — QB6(a)), cán bộ chỉ định tuỳ chọn**; bước 9 — [NG]: hạn bắt buộc; [CB]: **không có hạn**, gửi được ngay | XL01 bảng "Các bước nhập"; BR04; L3a(b); E1, F1, C4, D2, E3; QB6(a) | Functional | Cao | Cao | Cao | P1 | TC-11 (viết lại) |

### 2.C Bước 1 — Hình ảnh/Bằng chứng (cả 2 nhánh, A5)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | TC cũ |
|---|---|---|---|---|---|---|---|---|
| TC-11 | Đi tiếp khỏi bước 1 khi chưa có ảnh | XL01-B1; BR04 | Functional | Thấp | Vừa | Thấp | P3 | TC-12 |
| TC-12 | Thêm ảnh bằng Chụp ảnh và Thư viện; màn xem lại hiện "Bằng chứng: n tệp"; mọi ảnh được lưu và hiện ở khối Hình ảnh/Bằng chứng của Chi tiết vụ việc | XL01-B1; TN1-A2 | Functional | Vừa | Cao | Cao | P1 | TC-13 |
| TC-13 | Chỉ nhận **ảnh**; không chọn được video hay tệp khác | XL01-B1; BR20; [Q20] | Functional | Vừa | Vừa | Vừa | P2 | TC-14 |
| TC-14 | Giới hạn 50MB mỗi ảnh (thông báo khi vượt: QO5) | XL01-B1; BR20; [B12] | Functional | Vừa | Vừa | Vừa | P2 | TC-15 |
| TC-15 | Ảnh được gắn thời gian (cách gắn: QO5) | XL01-B1; BR20; [B12] | Functional | Vừa | Vừa | Vừa | P2 | TC-16 |
| TC-16 | Ảnh lưu trên hệ thống không chứa toạ độ GPS, kể cả ảnh từ thư viện vốn có GPS | XL01-B1; BR20; [B12] | Non-functional (Security) | Vừa | Vừa | Vừa | P2 | TC-17 |
| TC-17 | Hành vi khi từ chối quyền Camera / Ảnh của iOS (bước 1 và bước 6) (QO6) | XL01-B1, B6 (không nói) | Non-functional (Usability / Compatibility) | Vừa | Vừa | Vừa | P2 | TC-18 |

### 2.D Bước 2–4 — Khu vực, loại vụ việc, mức độ

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | TC cũ |
|---|---|---|---|---|---|---|---|---|
| TC-18 | Bước 2 chọn đúng một khu vực và giá trị được lưu đúng (thẻ "loại · khu vực", "Vụ việc theo khu vực"); chọn sẵn mặc định: QO7 | XL01-B2; §8.2; BR04 | Functional | Thấp | Vừa | Thấp | P3 | TC-19 |
| TC-19 | [NG] Đội trưởng/Chỉ huy Đội: bước 2 chỉ hiện khu vực quản trị viên gán cho **Đội của người tạo**; khu vực của Đội khác không hiện (Đội chưa gán khu vực: QO27) | QB2; [Q1]; QB1(c) | Functional + Security | Vừa | Cao | Cao | P1 | TC-20 |
| TC-20 | [NG] Trưởng/Phó trưởng CACK: bước 2 hiện khu vực của mọi Đội; bước 8 chọn Đội bất kỳ, không chặn/cảnh báo khi Đội không phụ trách khu vực đã chọn (khu vực chưa gán Đội nào: QO31) | QB3; QB2; QB1(a)(c) | Functional + Security | Vừa | Vừa | Vừa | P2 | TC-65 |
| TC-21 | [CB] **Cán bộ Phòng Camera**: bước 2 chỉ hiện khu vực của **Đội của cán bộ đó** (không phụ thuộc Đội sẽ bàn giao ở bước 8); bước 8 vẫn chọn được mọi Đội; vụ việc lưu đúng khu vực đã chọn (Đội của Phòng Camera chưa gán khu vực: QO27) | C2; E1 | Functional + Security | Cao | Vừa | Cao | P1 | (mới) |
| TC-22 | [CB] **Cán bộ hiện trường**: bước 2 chỉ hiện khu vực được phân công cho **Đội của cán bộ đó**; khu vực của Đội khác không hiện; không phụ thuộc Đội sẽ bàn giao ở bước 8 (không có kiểm tra khớp khu vực ↔ Đội nhận); vụ việc lưu đúng khu vực đã chọn (Đội chưa gán khu vực: QO27) | QB5 (lần 2); C2; E1 | Functional + Security | Cao | Vừa | Cao | P1 | (mới) |
| TC-23 | Danh mục khu vực, loại vụ việc, đề xuất xử lý hiển thị theo cấu hình quản trị | XL01 [Q1, Q19]; §8.2 | Functional | Thấp | Vừa | Thấp | P3 | TC-21 |
| TC-24 | Bước 3 chọn loại theo danh mục hai cấp; vụ việc lưu đúng loại cha và loại con (cách chọn 2 cấp: QO8) | XL01-B3; §8.1; [Q19]; CH06 mục III | Functional | Vừa | Cao | Cao | P1 | TC-22 |
| TC-25 | Loại "Khác": nhập tên loại bằng tay và tên được lưu (bắt buộc nội dung, độ dài: QO8) | XL01-B3; §8.1 | Functional | Vừa | Vừa | Vừa | P2 | TC-23 |
| TC-26 | Loại có cờ yêu cầu biểu mẫu ("Phát hiện vật phẩm nguy hiểm") → vụ việc có khối "Biểu mẫu và chữ ký"; loại không có cờ thì không — cả vụ việc do [CB] tạo (ảnh hưởng chéo XL03) | §8.1, §8.2; BR21; [Q19] | Functional | Vừa | Cao | Cao | P1 | TC-24 |
| TC-27 | Bước 4 chọn một trong 3 mức; mức được lưu và lọc được ở danh sách vụ việc; chọn Khẩn cấp thì hiện ghi chú cảnh báo (câu chữ "Cảnh báo Lãnh đạo + BCH đội" có còn đúng sau G1: QO38) | XL01-B4; TN1-A5; §8.2 | Functional | Thấp | Cao | Vừa | P2 | TC-25 |

### 2.E Bước 5 — Mô tả

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | TC cũ |
|---|---|---|---|---|---|---|---|---|
| TC-28 | "Mô tả vụ việc" bắt buộc (Tiếp tục mờ khi trống); "Vị trí cụ thể", "Hành động đã thực hiện" tuỳ chọn; cả ba lưu đúng và hiện ở Chi tiết vụ việc | XL01-B5; BR04; L3a(b) | Functional | Vừa | Cao | Cao | P1 | TC-27 |
| TC-29 | Mô tả chỉ có khoảng trắng; độ dài tối đa; tiếng Việt có dấu, ký tự đặc biệt lưu nguyên vẹn (QO9) | XL01-B5 (không nói); §10 | Functional | Vừa | Vừa | Vừa | P2 | TC-28 |
| TC-30 | Nhập giọng nói ở 3 ô của bước 5: văn bản chèn đúng ô (ngưỡng chính xác: QO21; quyền Micro: QO6) | XL01-B5; §10; [B13] | Functional / Usability | Vừa | Thấp | Thấp | P3 | TC-29 |

### 2.F Bước 6 — Thông tin đối tượng

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | TC cũ |
|---|---|---|---|---|---|---|---|---|
| TC-31 | Không thêm đối tượng nào vẫn đi tiếp và gửi được | XL01-B6; BR18; [Q17] | Functional | Thấp | Vừa | Thấp | P3 | TC-30 |
| TC-32 | "Số lượng đối tượng" nhập độc lập, không cần khớp số đối tượng đã nhập (lưu ở đâu: QO12) | XL01-B6; BR18 | Functional | Thấp | Thấp | Thấp | P3 | TC-31 |
| TC-33 | Quét giấy tờ bằng camera tự điền đúng các trường cho 4 loại: CCCD gắn chip, CMND, hộ chiếu Việt Nam, hộ chiếu nước ngoài | XL01-B6; BR19; [Q18] | Functional | Cao | Cao | Cao | P1 | TC-32 |
| TC-34 | Từ thư viện: ảnh giấy tờ có sẵn tự điền đúng (4 loại) | XL01-B6; BR19 | Functional | Cao | Cao | Cao | P1 | TC-33 |
| TC-35 | Trường tự điền sửa được; giá trị sau khi sửa là giá trị được lưu | XL01-B6; [Q18] | Functional | Vừa | Cao | Cao | P1 | TC-34 |
| TC-36 | Nhận dạng thất bại hoặc điền thiếu: hành vi của app (QO11) | XL01-B6 (không nói) | Functional / Reliability | Cao | Vừa | Cao | P1 | TC-35 |
| TC-37 | Không lưu ảnh giấy tờ: ảnh không vào Hình ảnh/Bằng chứng, không lên hệ thống; chỉ lưu văn bản (thư viện Ảnh của iPhone: QO11) | XL01-B6; BR19; §8.1; [Q18] | Non-functional (Security) | Vừa | Cao | Cao | P1 | TC-36 |
| TC-38 | Nhận dạng chạy trên thiết bị: ảnh giấy tờ không gửi lên máy chủ khi quét | §10; [B13] | Non-functional (Security) | Vừa | Cao | Cao | P1 | TC-37 |
| TC-39 | Thêm đối tượng thủ công: 6 trường được lưu đúng | XL01-B6 | Functional | Vừa | Cao | Cao | P1 | TC-38 |
| TC-40 | Quy tắc hợp lệ trường đối tượng: bắt buộc trong một đối tượng, đối tượng rỗng, định dạng Ngày sinh, số giấy tờ, Quốc tịch ↔ loại giấy tờ (QO10) | XL01-B6 (không nói) | Functional | Vừa | Cao | Cao | P1 | TC-39 |
| TC-41 | Nhiều đối tượng (kết hợp 3 cách), xoá một đối tượng; còn lại được lưu, hiện "Đối tượng 1..n" ở Chi tiết, số CCCD không che | XL01-B6; XL02; BR29; [B16] | Functional | Vừa | Vừa | Vừa | P2 | TC-40 |
| TC-42 | Biển số xe, Đơn vị liên quan: tuỳ chọn, lưu đúng; không có tra cứu tự động (nút "Tra biển số": QO13) | XL01-B6; [Q35] | Functional | Thấp | Thấp | Thấp | P3 | TC-41 |

### 2.G Bước 7 — Đề xuất xử lý

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | TC cũ |
|---|---|---|---|---|---|---|---|---|
| TC-43 | Chọn 0, 1 hoặc nhiều trong 5 đề xuất; lưu và hiện ở "Đề xuất xử lý của cán bộ" | XL01-B7; §8.2 | Functional | Thấp | Vừa | Thấp | P3 | TC-42 |
| TC-44 | Đề xuất "Khác": có ô nhập nội dung không, nội dung được lưu (QO14) | XL01-B7 | Functional | Thấp | Thấp | Thấp | P3 | TC-43 |

### 2.H Bước 8 — nhánh người giao việc [NG]

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | TC cũ |
|---|---|---|---|---|---|---|---|---|
| TC-45 | Tìm theo email, chọn 1 hoặc nhiều cán bộ của Đội nhận; mỗi dòng hiện email, Đội, vai trò; bỏ chọn được; phải có ≥1 cán bộ mới đi tiếp | XL01-B8; TN1-A9; BR04 | Functional | Vừa | Cao | Cao | P1 | TC-44 |
| TC-46 | Phạm vi giao: Đội trưởng/Chỉ huy Đội không chọn được Đội khác (Đội nhận = Đội mình); Trưởng/Phó trưởng CACK chọn được Đội bất kỳ; người ngoài phạm vi không hiển thị (vai trò người giao khác: hoãn — F2) | XL01-B8; §3.2; BR02; QB1(c); F2 | Functional + Security | Vừa | Cao | Cao | P1 | TC-45 |
| TC-47 | Mỗi vụ việc đúng 1 Đội; danh sách cán bộ lọc theo Đội đã chọn; không có cán bộ của 2 Đội trong cùng vụ việc (đổi Đội sau khi chọn cán bộ: QO29) | QB1(a); §8.1 | Functional + Security | Vừa | Cao | Cao | P1 | TC-46 |
| TC-48 | Tìm theo email: kết quả khớp đúng, hiển thị khi không có kết quả (QO15) | XL01-B8 | Functional | Vừa | Vừa | Vừa | P2 | TC-47 |
| TC-49 | Người giao tự giao cho chính mình / chọn người giao khác làm người nhận (QO16) | §3.4; PL-C #1 | Functional + Security | Vừa | Vừa | Vừa | P2 | TC-48 |
| TC-50 | [NG] Bước 8 của người giao việc (Đội trưởng/Chỉ huy Đội, Trưởng/Phó trưởng CACK) **không có** nút / lựa chọn quét mã QR | QB6(c) (lần 2) | Functional + Security (không mở đường giao ngoài phạm vi §3.2) | Vừa | Vừa | Vừa | P2 | (mới) |

### 2.I Bước 8 — nhánh cán bộ tạo vụ việc [CB]

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | TC cũ |
|---|---|---|---|---|---|---|---|---|
| TC-51 | [CB] **Bắt buộc có đúng 1 Đội nhận**: chọn trong danh sách gồm **mọi Đội** (kể cả Đội của người tạo), **hoặc** quét QR cán bộ hiện trường thay cho việc chọn Đội (TC-55); chưa có Đội (và chưa quét QR hợp lệ) thì không đi tiếp; **không** có lựa chọn "không bàn giao" | E1 (thay L7, L7a, C1, C4, D9); C2; QB6(a) | Functional | Cao | Cao | Cao | P1 | (mới) |
| TC-52 | [CB] Chỉ định người xử lý là **tuỳ chọn, tối đa 1 người**; danh sách chỉ gồm **cán bộ hiện trường thuộc Đội đã chọn** — không có cán bộ Phòng Camera, Văn thư, người giao việc, cán bộ Đội khác; không chọn được người thứ hai (tìm theo email hay tên, tự chỉ định chính mình, đổi Đội sau khi chỉ định: QO34) | E1; F1 | Functional + Security | Cao | Cao | Cao | P1 | (mới) |
| TC-53 | [CB] Không chỉ định người: vẫn đi tiếp và gửi được khi đã chọn Đội | E1; E2; D1 | Functional | Vừa | Cao | Cao | P1 | (mới) |
| TC-54 | [CB] Cán bộ hiện trường chọn Đội mình rồi chỉ định **chính mình** (được phép hay bị loại khỏi danh sách: QO34) | F1; C3 (⚠️ đã thay) | Functional | Vừa | Vừa | Vừa | P2 | (mới) |
| TC-55 | [CB] **Bàn giao bằng mã QR — mã hợp lệ**: ở bước 8, người tạo mở màn quét, quét "Mã QR của tôi" của một **cán bộ hiện trường** (hiển thị "Đang tra cứu cán bộ...") → người đó được chỉ định làm người xử lý mà **không cần chọn Đội trước**; sau khi gửi vụ việc "Đang thực hiện". Đội nhận = Đội của cán bộ được quét: **⚑ suy ra (QO42)**, không dùng làm tiêu chí đạt/không đạt; đã chọn Đội rồi quét mã cán bộ Đội khác: QO42 | F5; G4; QB6(a), (d) (lần 2); ảnh `03_case-create_09_assignee_qr-scan` | Functional + Security | Cao | Cao | Cao | P1 | (mới) |
| TC-78 | [CB] **Bàn giao bằng mã QR — mã bị từ chối**: quét mã của người **không phải cán bộ hiện trường** (cán bộ Phòng Camera, Văn thư, người giao việc) → hiện thông báo lỗi chỉ giao việc cho cán bộ hiện trường, người đó **không** được chỉ định. Quét mã của chính mình, mã không hợp lệ / không phải mã cán bộ, mất mạng khi tra cứu: QO43 | QB6(b) (lần 2); F1 | Functional + Security | Vừa | Cao | Cao | P1 | (mới, lần 2) |
| TC-79 | [CB] Màn quét QR: **"Chọn ảnh QR"** chọn ảnh mã QR từ thư viện và tra cứu được cán bộ như khi quét camera; **"Huỷ"** quay lại bước 8, không thay đổi Đội/người đã chọn trước đó (quyền Camera/Ảnh: QO6, QO43) | QB6(d) (lần 2); ảnh `03_case-create_09_assignee_qr-scan` | Functional / Usability | Vừa | Vừa | Vừa | P2 | (mới, lần 2) |

### 2.J Bước 9 — Xem lại và gửi

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | TC cũ |
|---|---|---|---|---|---|---|---|---|
| TC-56 | [NG] Màn xem lại tóm tắt đúng: loại, mô tả, bằng chứng (n tệp), người được giao | XL01-B9 | Functional | Vừa | Vừa | Vừa | P2 | TC-49 |
| TC-57 | [NG] Chọn ngày và giờ hạn (giờ Việt Nam); mặc định 17:00, đổi được; lưu đúng là "Hạn" của từng phần việc và "Hạn xử lý" của vụ việc | XL01-B9; BR06; [B8] | Functional | Vừa | Cao | Cao | P1 | TC-50 |
| TC-58 | [NG] Hạn không ở quá khứ (các biên: QO17); không giới hạn tối đa | XL01-B9; BR06; [B8] | Functional | Vừa | Cao | Cao | P1 | TC-51 |
| TC-59 | [NG] Hạn hiển thị và lưu theo giờ Việt Nam khi thiết bị đặt múi giờ khác (QO17) | BR06; §10 | Functional | Thấp | Cao | Vừa | P2 | TC-52 |
| TC-60 | [CB] Bước cuối **không có** chọn ngày/giờ hạn; nút gửi bật khi các bước bắt buộc trước đó hợp lệ; tóm tắt hiển thị Đội nhận và người được chỉ định nếu có (nội dung tóm tắt, nhãn nút, số bước: QO35) | C4; D2; E2; E3 | Functional | Vừa | Cao | Cao | P1 | (mới) |
| TC-61 | Chỉ có nút gửi, **không** có "Xử lý tại chỗ và hoàn thành" (cả 2 nhánh) | XL01-B9; §1.2; [Q4] | Functional | Thấp | Vừa | Thấp | P3 | TC-53 |
| TC-62 | Gửi tạo **đúng một** vụ việc có mã "VV" + 6 chữ số, không trùng; dùng chung chuỗi mã với GV01 (cả 2 nhánh) | XL01 Hậu điều kiện; BR38; [B1] | Functional | Vừa | Cao | Cao | P1 | TC-54 |
| TC-63 | Bấm gửi nhiều lần, mạng chập chờn, lỗi máy chủ: không tạo trùng vụ việc / phần việc / thông báo (QO18) | XL01 (không nói); TN1-A10 | Non-functional (Reliability) | Vừa | Cao | Cao | P1 | TC-55 |
| TC-64 | Toàn bộ dữ liệu các bước, thời gian tạo và người tạo được lưu và hiện đúng ở Chi tiết vụ việc — cả vụ việc [CB] ở trạng thái Chờ tiếp nhận (Đội phụ trách, Tổ, Nguồn phát hiện: QO26) | XL01 Hậu điều kiện; §8.1; XL02 Chi tiết; §2.1 | Functional | Vừa | Cao | Cao | P1 | TC-56 |

### 2.K Hậu điều kiện — trạng thái, hiển thị, quyền sau khi tạo

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | TC cũ |
|---|---|---|---|---|---|---|---|---|
| TC-65 | [NG] Trạng thái ban đầu "Đang thực hiện"; mỗi cán bộ được chỉ định có đúng một phần việc Tiến độ "Đã giao", Kết quả "Chưa bắt đầu"; "Giao việc 0/y" với y = số cán bộ | XL01 Hậu điều kiện; §4.1, §4.2; BR03; E6 | Functional | Vừa | Cao | Cao | P1 | TC-57 |
| TC-66 | [CB] **Có chỉ định** (chọn trong danh sách hoặc quét QR — TC-55): vụ việc vào thẳng "**Đang thực hiện**", **không có hạn**; người được chỉ định có đúng một phần việc (hiển thị Hạn / Nhắc việc khi chưa có hạn: QO36) | E2; E6; F5 | Functional | Cao | Cao | Cao | P1 | (mới) |
| TC-67 | [CB] **Không chỉ định**: vụ việc ở trạng thái "**Chờ tiếp nhận**", hiện ở **tab Tiếp nhận của Đội trưởng Đội nhận** với nhãn "Chờ tiếp nhận", "Cần xử lý", nút nhanh "Tiếp nhận"; Chi tiết có nút "Thao tác"; Đội trưởng của Đội không liên quan (khác Đội nhận và Đội người tạo) không thấy ở tab Tiếp nhận; Đội trưởng Đội người tạo: TC-69 (bộ đếm "Giao việc x/y": QO36) | D1; D4; E6; QB4(b) (lần 2); ảnh `04_case-handling_01_case-list_pending` | Functional + Security | Cao | Cao | Cao | P1 | (mới) |
| TC-68 | [NG] Vụ việc hiện ở tab Tiếp nhận và Của tôi của người tạo, tab Tiếp nhận của người giao trong Đội của vụ việc, tab Của tôi của từng cán bộ được chỉ định; tài khoản cán bộ không có tab Tiếp nhận; cán bộ không được chỉ định không thấy trong Của tôi; người giao Đội khác không thấy. Partition Trưởng/Phó trưởng CACK tạo: ⚑ suy ra (QO25), không dùng làm tiêu chí đạt/không đạt | XL01 Hậu điều kiện; BR35; [B24]; QB1(c) | Functional + Security | Vừa | Cao | Cao | P1 | TC-58 + TC-59 |
| TC-69 | [CB] **Ai thấy vụ việc do cán bộ tạo** (cán bộ Đội A tạo, bàn giao Đội B; cả trường hợp Đội A = Đội B — không khác biệt): **người tạo** thấy ở tab **Của tôi**; **Đội trưởng Đội A** thấy ở tab **Tiếp nhận**, mở được Chi tiết vụ việc, có nút **"Hoàn tất xử lý"**; **Đội trưởng Đội B** — khi đã chỉ định người — thấy ở tab Tiếp nhận và có nút "Hoàn tất xử lý" (khi không chỉ định: TC-67); **cán bộ được chỉ định** thấy ở tab Của tôi; Đội trưởng Đội không liên quan và cán bộ khác (kể cả cán bộ khác của Đội A, B không được chỉ định) **không** thấy trong Tiếp nhận/Của tôi. Hành vi của "Hoàn tất xử lý", các nút khác của Đội trưởng Đội A, nhãn/nút nhanh trên thẻ: QO44 — chỉ kiểm **sự có mặt** của nút ở XL01 | QB4(a)–(d) (lần 2); XL01 Hậu điều kiện; BR35; E5 | Functional + Security (dữ liệu cá nhân — BR29) | Cao | Cao | Cao | P1 | (mới) |
| TC-70 | [CB] Cán bộ tạo **chỉ có quyền tạo**: mở vụ việc của mình từ tab Của tôi thì **không có thao tác nào** — không có Gia hạn, Phân công lại, Phân công tiếp, Huỷ phần việc, Hoàn thành, Hoàn tất xử lý, Thao tác (nút Lịch sử, thêm ảnh bằng chứng: QO45); các quyền xử lý thuộc Đội trưởng (kiểm ở bộ tài liệu luồng tiếp nhận — ảnh hưởng chéo) | C5; G3; QB4(a) (lần 2) | Security | Vừa | Cao | Cao | P1 | (mới) |

### 2.L Hậu điều kiện — thông báo, cảnh báo Khẩn cấp, nhật ký, thống kê

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | TC cũ |
|---|---|---|---|---|---|---|---|---|
| TC-71 | [NG] Mỗi cán bộ được chỉ định nhận **đúng một** thông báo "Bạn có phần việc mới" (tab Thông báo, chưa đọc in đậm), mở được phần việc; người không được chỉ định không nhận; không qua SMS | XL01 Hậu điều kiện; CH07; BR17 | Functional | Vừa | Cao | Cao | P1 | TC-60 |
| TC-72 | [CB] Thông báo khi cán bộ tạo: **Đội trưởng Đội người tạo**, **Đội trưởng Đội nhận**, **cán bộ được chỉ định** (nếu có) nhận; không chỉ định → Đội trưởng Đội nhận vẫn nhận (D1); người ngoài tập này không nhận (Đội người tạo = Đội nhận: 1 hay 2 thông báo; tiêu đề: QO37; Đội nhận khi dùng QR: ⚑ QO42) | C8 (phần còn hiệu lực); D1; F2 | Functional | Cao | Cao | Cao | P1 | (mới) |
| TC-73 | Cảnh báo **Khẩn cấp** (cả 2 nhánh): gửi **Phó trưởng CACK phụ trách Đội nhận**; Đội nhận chưa có Phó trưởng phụ trách → **Đội trưởng và Đội phó của Đội nhận**; **Trưởng CACK không nhận**; Phó trưởng CACK phụ trách Đội khác (kể cả Đội người tạo khi khác Đội nhận) không nhận; mức Bình thường/Nghiêm trọng không gửi (thông báo đẩy ưu tiên cao, không bắt buộc xác nhận — A6; "Đội phó" là vai trò nào; người tạo tự nhận: QO38, QO30; Đội nhận khi dùng QR: ⚑ QO42) | G1 (thay QB1(d), C8 phần Khẩn cấp, đặc tả [B7]); F3; E8; D6 | Functional | Cao | Cao | Cao | P1 | TC-26 (viết lại) |
| TC-74 | [NG] Thời điểm nhắc việc = giao + 2/3 × (hạn − giao), hiển thị ở "NHẮC VIỆC". Nhánh [CB] không có hạn → **không áp dụng** (E3, GAP mục 3) | TN1-A10; BR11; CH07; [Q14]; E3 | Functional | Vừa | Vừa | Vừa | P2 | TC-61 |
| TC-75 | Nhật ký / Diễn biến xử lý: [NG] ghi "Giao việc" cho từng phần việc (giờ · người thực hiện · hành động), không sửa, không xoá; [CB] không chỉ định ghi mốc "Gửi tiếp nhận" kèm vai trò và Đội người tạo (quan sát ảnh — tên mốc chưa có mô tả nghiệp vụ); [CB] có chỉ định: QO40 | XL01 Hậu điều kiện; CH07; BR32; ảnh `case-detail_pending` | Functional | Vừa | Vừa | Vừa | P2 | TC-62 (mở rộng) |
| TC-76 | Đội/Tổ trên thẻ vụ việc = Đội/Tổ của cán bộ được giao (QB1(b), kiểm vấn đề V3); vụ việc [CB] Chờ tiếp nhận (chưa có người được giao), nhiều cán bộ khác Tổ, khối "Thông tin vụ việc", **Nguồn phát hiện** (ảnh hiện "Phòng Camera"): QO26 | QB1(b); §8.1; XL02 Chi tiết; ảnh `case-detail_pending` | Functional | Vừa | Vừa | Vừa | P2 | TC-63 (mở rộng) |
| TC-77 | Thống kê Trang chủ cập nhật sau khi tạo (Tổng vụ việc, **Chờ tiếp nhận** — nay có thể khác 0, Khẩn cấp mở, Vụ việc theo khu vực) cho người dùng thuộc Đội của vụ việc; người dùng Đội không liên quan không thấy thay đổi (vụ việc [CB] Đội A → Đội B tính cho Đội nào: QO39) — ảnh hưởng chéo CH05 | QB1(d) phần thống kê; QB3; CH05; BR27; [B19]; E6 | Functional | Vừa | Vừa | Vừa | P2 | TC-64 (mở rộng) |

### Tổng hợp

| Ưu tiên | Số test condition | Danh sách |
|---|---|---|
| P1 | 44 | TC-01–04, 06, 10, 12, 19, 21, 22, 24, 26, 28, 33–40, 45–47, 51–53, 55, 57, 58, 60, 62–73, 78 |
| P2 | 24 | TC-05, 08, 09, 13–17, 20, 25, 27, 29, 41, 48, 49, 50, 54, 56, 59, 74–77, 79 |
| P3 | 11 | TC-07, 11, 18, 23, 30, 31, 32, 42, 43, 44, 61 |
| Chưa xếp hạng | 0 | — |
| **Tổng** | **79** | |

**Thay đổi ở cập nhật lần 2 (áp dụng QB4–QB6):** TC-22 → P1 (Cao×Vừa, như TC-21 — cùng quy tắc với Phòng Camera, likelihood Cao vì nhánh mới chưa có ảnh); TC-50 → P2 (Vừa×Vừa — kiểm sự **vắng mặt** của nút QR ở nhánh người giao; nếu lọt thì mở đường chỉ định ngoài phạm vi §3.2); TC-55 → P1 (Cao×Cao — cơ chế mới, chỉ có 1 ảnh, quyết định Đội nhận và người xử lý); TC-69 → P1 (Cao×Cao — quyền xem dữ liệu cá nhân của 4 nhóm người, quy tắc khác đặc tả BR35). Thêm TC-78 (P1, Vừa×Cao — kiểm soát ai được chỉ định qua QR) và TC-79 (P2, Vừa×Vừa — Chọn ảnh QR / Huỷ). Viết lại TC-10, 51, 52 (gián tiếp qua TC-55), 66, 67, 70, 72, 73.

**Thay đổi so với TA-v2.1 (65 test condition):** bỏ TC-02, TC-03, TC-06 cũ (Tổ phó / cán bộ uỷ quyền / thu hồi uỷ quyền — hoãn theo F2) và TC-05 cũ (Phòng Camera không tạo được — sai sau L6); viết lại TC-04 cũ thành Văn thư (TC-04), TC-11 cũ thành bảng bắt buộc theo nhánh (TC-10), TC-26 cũ theo G1 (TC-73); gộp TC-58 + TC-59 cũ (TC-68); thêm 17 test condition cho nhánh cán bộ và các thay đổi mới (TC-02, 03, 05, 21, 22, 50–55, 60, 66, 67, 69, 70, 72) ở lần 1, và 2 test condition QR (TC-78, 79) ở lần 2 → tổng 79.

**Căn cứ xếp likelihood "Cao" cho các test condition mới của nhánh [CB]:** quy tắc bàn giao đổi 3 lần trong 2 ngày (L7 → L7a → E1/F1), mâu thuẫn trực tiếp với câu chữ đặc tả hiện hành (D34, D49), và chưa có ảnh màn hình nào của nhánh này ở flow 03 (A1).

---

## 3. Traceability nháp

| Test condition | Mục test basis | Ghi chú cho test-plan (gợi ý nhóm test object — test-plan chốt lại) |
|---|---|---|
| TC-01 – 06 | XL01 Tác nhân, Kích hoạt; §3.1; BR17; [Q32]; L6, C6, C7; F2 | **AUTH** — quyền tạo theo Vai trò. Dữ liệu test: Đội trưởng, Trưởng CACK, Phó trưởng CACK, cán bộ hiện trường, Phòng Camera, Văn thư (A4) |
| TC-07 – 10 | XL01; BR04; PL-C #3; L3a(b); E1, F1, C4, D2, E3 | **NAV** — TC-10 dạng bảng quyết định theo nhánh [NG]/[CB] |
| TC-11 – 17 | XL01-B1; BR20; [Q20, B12] | **EVD** — chạy chính trên [NG], kiểm khói trên [CB] (A5) |
| TC-18 – 27 | XL01-B2–B4; §8.2; BR21; QB2, QB3, QB5; C2; G1 (ghi chú bước 4) | **CLS** — TC-21, TC-22 cần cán bộ thuộc Đội có khu vực gán khác Đội nhận |
| TC-28 – 30 | XL01-B5; §10; [B13] | **DSC** |
| TC-31 – 42 | XL01-B6; §8.1; BR18, BR19, BR29; [Q17, Q18, Q35, B13, B16] | **SUBJ** — cần bộ giấy tờ mẫu giả (QO23) |
| TC-43 – 44 | XL01-B7; §8.2 | **PROP** |
| TC-45 – 50 | XL01-B8; §3.2; BR02; QB1(a)(c); F2; QB6(c) | **ASG-NG** — TC-50 kiểm không có nút QR |
| TC-51 – 55, 78, 79 | E1, E2, F1, F5, G4; C2; QB6(a)(b)(d) | **ASG-CB** — nhóm mới. Dữ liệu test: ≥2 Đội, mỗi Đội có cán bộ hiện trường, Phòng Camera, Văn thư, Đội trưởng; mã QR ("Mã QR của tôi") của từng loại tài khoản, ảnh mã QR trong thư viện. TC-55 có partition ⚑ (QO42) |
| TC-56 – 64 | XL01-B9, Hậu điều kiện; BR06, BR38; [B1, B8, Q4]; C4, D2, E3 | **SUB** — TC-57–59 chỉ nhánh [NG]; TC-60 chỉ nhánh [CB] |
| TC-65 – 70 | XL01 Hậu điều kiện; §4.1, §4.2; BR03, BR35; [B24]; QB1(c); D1, D4, E2, E5, E6, C5, G3 | **POST-STATE/VIS** — TC-67 là điểm vào của luồng tiếp nhận tại Đội (ảnh hưởng chéo). TC-68 partition ⚑ (QO25). TC-69 theo QB4 — chỉ kiểm sự có mặt của nút "Hoàn tất xử lý", hành vi thuộc luồng xử lý (QO44) |
| TC-71 – 77 | CH07; BR11, BR27, BR32; [Q14, B19]; C8, D1, D6, F3, E8, G1; QB1(b)(d) | **POST-NOTI** — TC-73 cần Đội có và Đội không có Phó trưởng CACK phụ trách (A4) |
| — | TN1 "Kết quả lưu vào trang quản trị chung"; CH07 "đồng bộ về trang quản trị" | **GAP — không kiểm được** (trang quản trị ngoài phạm vi). Không tạo test condition |
| — | §10 Hiệu năng (đề xuất); độ chính xác nhận dạng "cao" | **GAP — không kiểm được** dưới dạng tiêu chí đạt/không đạt (QO21) |
| — | E3: vụ việc [CB] không có hạn → nhắc việc, quá hạn, Kết quả đúng hạn/không đúng hạn, ô "Quá hạn" | **GAP — tạm bỏ theo quyết định QC lead** (E3, D3 hoãn). Không tạo test condition cho tới khi có màn chọn hạn |
| — | Các vai trò Tổ trưởng, Tổ phó, Phó Đội trưởng, cán bộ được uỷ quyền (§3.1–3.3, [B2], BR34, BR36; E7) | **Hoãn theo F2** — không tạo test condition |

---

## 4. Câu hỏi cần làm rõ trước khi lập test plan

### 4.1 Câu hỏi chặn (thuộc mục 0 của skill — phải trả lời trước khi chạy test-plan)

| # | Câu hỏi | Lý do dừng (mục 0) | Test condition bị ảnh hưởng |
|---|---|---|---|
| — | **Không còn câu hỏi chặn** (cập nhật lần 2, 2026-10-28). | — | — |

**Đã trả lời ở cập nhật lần 2 (giữ để truy vết — trả lời nguyên văn ở [lam-ro-2026-10-27.md](../../specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-27.md), mục "Trả lời câu hỏi chặn QB4–QB6…"):**

| # | Kết luận áp dụng | Phần còn lại → câu hỏi mới |
|---|---|---|
| QB4 ✅ | (a) Người tạo thấy ở tab Của tôi, không có thao tác; (b) Đội trưởng Đội A thấy ở Tiếp nhận, mở chi tiết, có "Hoàn tất xử lý"; (c) Đội trưởng Đội B (đã chỉ định) cũng vậy; (d) Đội A = Đội B không khác → TC-67, 69, 70 | QO44 ("Hoàn tất xử lý"), QO45 ("không có thao tác gì") |
| QB5 ✅ | Cán bộ hiện trường: khu vực của Đội mình → TC-22 | — |
| QB6 ✅ | (a) QR thay cho chọn Đội; (b) mã không phải cán bộ hiện trường → thông báo lỗi; (c) người giao không có QR; (d) ảnh `qr-scan` → TC-10, 50, 51, 55, 78, 79 | QO42 (Đội nhận ⚑, đã chọn Đội rồi quét mã Đội khác), QO43 (mã của chính mình, mã không hợp lệ) |

**Câu hỏi chặn của lần 1 (nguyên văn, giữ để truy vết):**

| # | Câu hỏi | Lý do dừng (mục 0) | Test condition bị ảnh hưởng |
|---|---|---|---|
| **QB4** ✅ | **Vụ việc do cán bộ tạo hiện ở đâu, với ai?** Ví dụ: cán bộ hiện trường (hoặc Phòng Camera) Đội A tạo vụ việc, bàn giao cho Đội B. (a) **Cán bộ tạo** sau khi gửi có thấy vụ việc ở tab **Của tôi** không (BR35 "Của tôi: vụ việc tôi **đã giao**…" — "bàn giao" có tính là "đã giao")? (b) **Đội trưởng Đội A** nhận thông báo (C8) — có thấy vụ việc ở tab **Tiếp nhận** của mình không (BR35 "vụ việc **được tạo trong Đội**" — Đội người tạo hay Đội nhận)? Nếu không, bấm vào thông báo có mở được chi tiết vụ việc không? (c) Khi cán bộ **có chỉ định** người xử lý (vụ việc vào thẳng "Đang thực hiện", không qua "Chờ tiếp nhận"), **Đội trưởng Đội B** có thấy vụ việc ở tab Tiếp nhận không (C5 cho họ quyền gia hạn/phân công lại/hoàn thành, nên QC **đoán** là có — chưa xác nhận)? (d) Trường hợp Đội A = Đội B có gì khác không? | Mơ hồ — mỗi cách hiểu cho **tập người được xem vụ việc khác nhau**; vụ việc hiển thị đầy đủ dữ liệu cá nhân của đối tượng (BR29, [B16]) → test condition kiểm soát truy cập khác hẳn nhau, và impact bảo mật không xếp được khi chưa biết ai được phép xem (D35) | TC-69 (chưa xếp hạng); expected của TC-67, TC-68, TC-70, TC-72 |
| **QB5** ✅ | **Cán bộ hiện trường thấy khu vực nào ở bước 2?** C2 chỉ trả lời cho Phòng Camera ("khu vực của đội mình"). Với cán bộ hiện trường: (a) khu vực của **Đội mình** (giống Phòng Camera); (b) **toàn bộ** khu vực (giống Trưởng/Phó trưởng CACK — QB3), vì cán bộ bàn giao được cho mọi Đội; hay (c) khu vực của **Đội nhận** — khi đó Đội nhận chọn ở bước 8 (sau bước 2), hệ thống có chặn/cảnh báo khi Đội chọn ở bước 8 không phụ trách khu vực đã chọn không? | Mơ hồ — 3 cách hiểu dẫn tới tập test condition khác nhau (cách (c) thêm điều kiện nhất quán khu vực ↔ Đội; (a)/(b) khác phạm vi dữ liệu hiển thị) (D36) | TC-22 (chưa xếp hạng); expected của TC-18, TC-77 (thống kê "Vụ việc theo khu vực") |
| **QB6** ✅ | **Bàn giao bằng mã QR lúc tạo vụ việc (F5, G4) hoạt động thế nào?** (a) Nút QR nằm ở bước 8; quét QR **thay cho** việc chọn Đội (Đội lấy theo cán bộ được quét) hay chỉ dùng **sau khi** đã chọn Đội (mã của cán bộ khác Đội bị từ chối)? (b) Quét mã của cán bộ **không phải** cán bộ hiện trường (Phòng Camera, Văn thư, người giao), mã của **chính mình**, mã không hợp lệ thì app làm gì? (c) "Người tạo vụ việc" ở F5 có gồm **người giao việc** không — tức bước 8 của Đội trưởng / Trưởng, Phó trưởng CACK có nút QR không? (d) Có ảnh chụp màn QR ở bước tạo vụ việc không? | Thiếu + mơ hồ — chức năng mới chưa có mô tả màn hình hay quy tắc; cách hiểu (a) và (c) **thêm/bớt test condition** (D37) | TC-50, TC-55 (chưa xếp hạng); expected của TC-52, TC-66 |

**Đã trả lời (từ TA-v2.1 — giữ để truy vết):** QB1 (a)(b)(c) ✅ còn hiệu lực cho [NG]; QB1(d) phần cảnh báo Khẩn cấp ✅ **đã bị G1 thay**; QB2 ✅; QB3 ✅.

### 4.2 Câu hỏi mở phải làm rõ trước khi lập test plan

**Không còn** (cập nhật lần 3, 2026-10-28). Ở cập nhật lần 2, mục này chứa QO42–QO45 (lý do tài liệu ở DRAFT); QC lead đã chọn "**Mang sang, chạy tiếp**" → chuyển xuống mục 4.3. Các câu này **vẫn chưa được trả lời**.

### 4.3 Câu hỏi mở đã được QC lead cho mang sang test-plan (expected result còn mở)

> **Quyết định của QC lead, 2026-10-28** ([lam-ro-2026-10-27.md](../../specs/xu-ly-vi-pham-giao-viec/lam-ro-2026-10-27.md)): (1) "Chấp nhận 2 quyết định trên" — mang các câu hỏi mở của bộ này sang test plan dưới dạng "kết quả mong đợi còn mở"; (2) "Mang sang, chạy tiếp" — áp dụng cả cho QO42–QO45. Các câu dưới **chưa được trả lời** — test-plan/test-case chỉ ghi nhận hành vi quan sát được, không tự suy diễn; partition ⚑ (QO25, QO42) không dùng làm tiêu chí đạt/không đạt. QO44 phải được làm rõ **trước khi** phân tích luồng tiếp nhận/xử lý (ảnh hưởng chéo, mục 5.1).

**Mới ở cập nhật lần 2 (cho mang sang ở cập nhật lần 3):**

| # | Câu hỏi | Từ | Test condition bị ảnh hưởng |
|---|---|---|---|
| QO42 | **⚑ Đội nhận khi quét QR:** QB6(a) "Quét thay cho chọn đội được" — Đội nhận có phải **Đội của cán bộ hiện trường được quét** không (QC suy ra từ E1, chưa xác nhận)? Nếu người tạo **đã chọn Đội** rồi mới quét mã cán bộ hiện trường của **Đội khác** thì: Đội bị thay theo người được quét, hay báo lỗi? Thông báo C8 / cảnh báo Khẩn cấp G1 / thống kê tính theo Đội đó? | D51; QB6(a) | TC-55 (partition ⚑), 72, 73, 77 |
| QO43 | **QR — trường hợp QB6(b) chưa trả lời:** quét **mã của chính mình** (vd qua "Chọn ảnh QR" với ảnh mã của mình) — chấp nhận (tự chỉ định) hay báo lỗi? Mã **không hợp lệ** / không phải mã cán bộ / tài khoản đã khoá? Mất mạng khi "Đang tra cứu cán bộ..."? Nội dung chính xác của thông báo lỗi? Từ chối quyền Camera khi mở màn quét? | D51; QB6(b) | TC-78, 79; liên quan QO34 (tự chỉ định qua danh sách) |
| QO44 | **"Hoàn tất xử lý"** (nút nhanh trên thẻ ở tab Tiếp nhận — QB4(b)(c)): quan hệ thế nào với nút **"Hoàn thành"** của phần việc và trạng thái **"Đã hoàn thành" / "Đã xử lý"**? Có bắt buộc nhập kết quả/lý do không? Có dùng được khi vụ việc còn "Chờ tiếp nhận" không? Nếu tương đương Hoàn thành thì Đội trưởng **Đội người tạo** cũng hoàn thành được — mở rộng C5 ("đội trưởng của cán bộ được phân công")? Ngoài "Hoàn tất xử lý", Đội trưởng Đội A có thấy nút Thao tác / Gia hạn / Phân công lại không? Thẻ ở Tiếp nhận của Đội trưởng Đội A hiện nhãn và nút nhanh nào khi vụ việc Chờ tiếp nhận ở Đội B? (Hành vi của nút thuộc bộ tài liệu luồng xử lý; ở XL01 chỉ kiểm sự có mặt.) | D52; QB4(b)(c); C5; E6 (câu cũ chưa trả lời) | TC-67, 69 |
| QO45 | QB4(a) "không có thao tác gì" với người tạo: có bao gồm **không có nút Lịch sử** (đặc tả [Q7] cho cán bộ không được chỉ định xem Lịch sử) và **không thêm được ảnh bằng chứng** không? | D53; QB4(a) | TC-70 |

**Mang từ TA-v2.1 (còn hiệu lực):**

| # | Câu hỏi | Từ | Test condition bị ảnh hưởng |
|---|---|---|---|
| QO3 | Tab Tiếp nhận có nút + không? **Mở rộng:** cán bộ hiện trường / Phòng Camera có nút + ở tab Của tôi không (L6 chỉ nói Trang chủ)? | D07, D46 | TC-01, 02, 03 |
| QO4 | Thoát giữa chừng / chuyển nền / đóng app: dữ liệu giữ hay huỷ, có hỏi xác nhận không? | D09 | TC-09 |
| QO5 | Ảnh bằng chứng: số ảnh tối đa, xoá ảnh, thông báo > 50MB, "gắn thời gian" là gì, ảnh có GPS? | D10 | TC-12, 14, 15, 16 |
| QO6 | Từ chối quyền Camera / Ảnh / Micro? | D11 | TC-17, 30 |
| QO7 | Bước 2 có chọn sẵn mục đầu không? | D12 | TC-10, 18 |
| QO8 | Danh mục loại hai cấp chọn thế nào; "Khác" bắt buộc tên, độ dài; có biểu mẫu không? | D13 | TC-24, 25, 26 |
| QO9 | Mô tả chỉ khoảng trắng; độ dài tối đa? | D14 | TC-28, 29 |
| QO10 | Hợp lệ trường đối tượng; danh sách quốc tịch? | D16 | TC-39, 40 |
| QO11 | Nhận dạng thất bại; số hộ chiếu vào ô nào; ảnh quét có vào thư viện Ảnh iPhone không? | D17 | TC-33, 34, 36, 37 |
| QO12 | "Số lượng đối tượng" lưu và hiển thị ở đâu? | D18 | TC-32 |
| QO13 | Nút "Tra biển số" ẩn hay giữ? | D19 | TC-42 |
| QO14 | Đề xuất "Khác" có ô nhập nội dung không? | D20 | TC-44 |
| QO15 | Tìm theo email: khớp một phần, hoa/thường, không có kết quả? | D21 | TC-48 |
| QO16 | [NG] tự giao cho chính mình; chọn người giao khác làm người nhận? | D22 | TC-49 |
| QO17 | [NG] Hạn: quá 17:00 hôm nay thì mặc định gì; "quá khứ" kiểm lúc chọn hay lúc gửi; độ chi tiết phút; múi giờ khác? | D23 | TC-57, 58, 59 |
| QO18 | Mất mạng khi gửi; lỗi máy chủ; chống tạo trùng? | D24 | TC-06, 63 |
| QO19 | NỘI DUNG phần việc lấy từ đâu; "Giao việc" (Lịch sử) và "Phân công" (Diễn biến xử lý) là 1 hay 2 bản ghi? | D25 | TC-64, 75 |
| QO21 | Ngưỡng độ chính xác nhận dạng giấy tờ, giọng nói; chỉ tiêu hiệu năng §10 đã duyệt chưa? | D15 | TC-30, 33, 34 |
| QO22 | (Tài liệu) Sửa câu §8.1 "sửa được, không xoá" cho khớp BR31/XL05 | D26 | (ảnh hưởng chéo XL05) |
| QO23 | Model iPhone, phiên bản iOS tối thiểu, build mục tiêu; bộ giấy tờ mẫu giả? | D27 | Môi trường test; TC-33, 34 |
| QO25 | ⚑ Vụ việc do Trưởng/Phó trưởng CACK tạo có hiện ở Tiếp nhận của người giao trong Đội được chọn (và của chính người tạo) không? | D03 | TC-68 (partition) |
| QO26 | Đội/Tổ trên thẻ khi nhiều cán bộ khác Tổ; khối "Thông tin vụ việc"; **mở rộng:** vụ việc [CB] Chờ tiếp nhận (chưa có người được giao) hiện Đội/Tổ nào; **Nguồn phát hiện** nhận giá trị gì theo người tạo (ảnh hiện "Phòng Camera", trái [B14] "bỏ qua nguồn Camera")? | D02, D31, D43 | TC-64, 76 |
| QO27 | Đội chưa được gán khu vực thì bước 2 hiện gì — áp dụng cả Đội của cán bộ Phòng Camera (C2) | D32 | TC-19, 21 |
| QO28 | (Tài liệu) Đề nghị sửa đặc tả: [B7], BR16, CH07 theo **G1**; XL01-B2, §3.2, BR36, [B25*] theo QB2; **thêm:** §3.1, §3.3, §3.4, XL01 Tác nhân, BR01, [Q4], [Q31] theo L6/C6; XL01-B8, B9, BR04 theo E1/F1/C4/D2/E3; §4.2, CH05, [B4], [B19], [Q5] theo E6/F4 | D33, D34, D49 | TC-02, 03, 10, 60, 73, 77 |
| QO29 | Trưởng/Phó trưởng CACK đổi Đội ở bước 8 sau khi đã chọn cán bộ? | QB1(a) | TC-47 |
| QO30 | (Cập nhật theo G1) Phó trưởng CACK tạo vụ việc Khẩn cấp cho Đội mình phụ trách có tự nhận cảnh báo không? | D50 | TC-73 |
| QO31 | Trưởng/Phó trưởng CACK: "khu vực của mọi Đội" có gồm khu vực chưa gán Đội nào? | QB3 | TC-20 |

**Mới ở tài liệu này (lần 1):**

| # | Câu hỏi | Từ | Test condition bị ảnh hưởng |
|---|---|---|---|
| QO32 | Bước 1, 3–7 khi **cán bộ** tạo vụ việc có giống hệt khi người giao tạo không (giả định A5)? | D48 | TC-11–18, 23–44 |
| QO33 | Đổi **Vai trò** tài khoản (C7) có hiệu lực ngay hay ở lần đăng nhập sau; đang giữa 9 bước thì gửi được không? | D47 | TC-05 |
| QO34 | [CB] bước 8: tìm cán bộ theo email hay theo tên; cán bộ hiện trường **tự chỉ định chính mình** được không; đổi Đội sau khi đã chỉ định thì người đã chọn bị bỏ hay chặn đổi; danh sách Đội có loại trừ Đội nào không (Đội không có cán bộ hiện trường, Đội không có Đội trưởng)? | D42 | TC-51, 52, 54 |
| QO35 | [CB] bước cuối: còn là "Bước 9/9" không; tóm tắt hiện những gì (có Đội nhận không); nhãn nút gửi là gì? | D38 | TC-07, 60 |
| QO36 | Vụ việc không có hạn (E2): phần việc hiển thị "Hạn", "NHẮC VIỆC", "KẾT QUẢ" thế nào; "Hạn xử lý" ở Thông tin vụ việc hiện gì; vụ việc Chờ tiếp nhận hiện bộ đếm "Giao việc x/y" thế nào? | D39 | TC-66, 67 |
| QO37 | Thông báo khi cán bộ tạo (C8): Đội người tạo = Đội nhận thì Đội trưởng nhận 1 hay 2 thông báo; tiêu đề thông báo cho Đội trưởng là gì? | D40 | TC-72 |
| QO38 | Khẩn cấp (G1): "Đội phó" có phải vai trò **Phó Đội trưởng** không; ghi chú "Cảnh báo Lãnh đạo + BCH đội" ở bước 4 có cần đổi theo G1 không (hay là lỗi câu chữ); vẫn là thông báo đẩy ưu tiên cao, không bắt buộc xác nhận (A6)? | D41 | TC-27, 73 |
| QO39 | Vụ việc do cán bộ Đội A bàn giao Đội B được tính vào thống kê Trang chủ của Đội nào? | D44 | TC-77 |
| QO40 | [CB] có chỉ định / quét QR: Diễn biến xử lý ghi mốc gì ("Gửi tiếp nhận", "Giao việc", "Phân công"…); Lịch sử phần việc ghi người thực hiện là cán bộ tạo? | D45 | TC-75 |

### 4.4 Câu hỏi đã đóng hoặc hoãn

| # | Tình trạng |
|---|---|
| QO1 | ✅ **Đóng** — C6: cán bộ Văn thư "không thấy nút + Tạo vụ việc" (ẩn). Cán bộ hiện trường / Phòng Camera nay thấy nút (L6) |
| QO2 | ⏸ **Hoãn** theo F2 (thu hồi uỷ quyền, uỷ quyền cho Phòng Camera — vai trò uỷ quyền chưa kiểm) |
| QO20 | ✅ Đã đóng ở TA-v2.1; nội dung QB1(d) nay **bị G1 thay** |
| QO24 | ✅ Đóng ở TA-v2.1 (A1/A2 chấp nhận) |
| QO41 | ✅ **Đóng (lần 2)** — QC lead chấp nhận áp dụng căn cứ risk A1/A2 cho bộ `dac-ta-v2.1-lam-ro-10-28` (2026-10-28) |
| QB4, QB5, QB6 | ✅ **Đã trả lời (lần 2)** — xem 4.1 |

### 4.5 Đối chiếu 4 lý do dừng ở mục 0 của skill (cập nhật lần 2)

- *Mơ hồ đổi tập test condition:* QB4–QB6 đã trả lời. Điểm ⚑ của QB6(a) (Đội nhận = Đội của cán bộ được quét — QO42) là **cách hiểu duy nhất khớp E1** ("người xử lý thuộc Đội được bàn giao"); cách hiểu khác không sinh test condition mới mà chỉ đổi Đội trong expected result của TC-55, 72, 73, 77 → **không chặn**, partition đánh dấu ⚑ và không dùng làm tiêu chí đạt/không đạt (như QO25). Trường hợp mã của chính mình / mã không hợp lệ (QO43) là partition của TC-78 đã có → chỉ đổi expected → **không chặn**. "Hoàn tất xử lý" (QO44): ở XL01 chỉ kiểm sự có mặt của nút; hành vi thuộc bộ tài liệu luồng xử lý → **không chặn** XL01 (nhưng **phải** làm rõ trước khi phân tích luồng xử lý).
- *Mâu thuẫn nội bộ:* QB4(b) có thể mở rộng C5 nếu "Hoàn tất xử lý" = Hoàn thành — theo quy tắc của test basis, câu trả lời sau thay câu trước, và QC chưa đồng nhất hai nút → ghi QO44, không coi là mâu thuẫn chặn. D34, D49 đã có quyết định (QO28).
- *Căn cứ risk:* mọi test condition đã xếp hạng (79/79); A1/A2 được QC lead chấp nhận cho bộ này (QO41 đóng).
- *Acceptance criteria:* QR nay có quy tắc (QB6) và ảnh màn hình → không còn trường hợp thiếu tiêu chí chấp nhận.
- **Kết luận trạng thái:** không còn câu hỏi trùng 4 lý do dừng → không BLOCKED. Lần 2: mục 4.2 còn 4 câu mở chưa được QC lead cho mang sang → DRAFT. **Lần 3:** QC lead quyết định trực tiếp "Mang sang, chạy tiếp" cho QO42–QO45 → mục 4.2 rỗng, không còn banner → **READY**. Các câu ở 4.3 vẫn còn hiệu lực, test-plan phải mang theo.

---

## 5. Ảnh hưởng chéo, hoãn và ngoài phạm vi

### 5.1 Ảnh hưởng chéo (sẽ có bộ tài liệu riêng — chỉ ghi nhận, không tạo test condition ở đây)

| Chức năng | Liên hệ với XL01 | Nguồn |
|---|---|---|
| **Luồng tiếp nhận tại Đội** (Tiếp nhận, Phân công, Duyệt và giao xử lý, Thay đổi hình thức xử lý, Bàn giao Đội khác, Đề xuất lãnh đạo) | Vụ việc [CB] không chỉ định (TC-67) là điểm vào duy nhất của luồng này; quyền quản lý phần việc của Đội trưởng Đội nhận (C5) kiểm ở đó. Ứng viên lỗi mức thấp đã ghi ở lam-ro: tiêu đề "Duyệt & giao thực hiện" dùng chung cho 2 nút | D1, D4, E4–E9, F7, F8, G5, G6 |
| **Nút "Hoàn tất xử lý"** (lần 2) | Đội trưởng Đội người tạo và Đội trưởng Đội nhận (đã chỉ định) có nút này với vụ việc do cán bộ tạo (TC-69). Hành vi, quan hệ với "Hoàn thành"/"Đã hoàn thành" và với C5 phải làm rõ (QO44) **trước khi** phân tích luồng xử lý | QB4(b)(c); C5 |
| **"Mã QR của tôi"** ở Trang chủ (flow 02, lần 2) | Cán bộ hiện trường mở mã QR của mình để người tạo quét (TC-55) — màn này thuộc flow 02, chỉ là tiền điều kiện ở XL01 | QB6(d); ảnh `qr-scan` |
| **Phê duyệt & đóng** | Vụ việc tạo từ XL01 kết thúc ở "Đã đóng" (Trưởng CACK, mọi Phó trưởng CACK); "Đã xử lý" (thẻ) = "Đã hoàn thành" (chi tiết) — ứng viên lỗi câu chữ | E6, F4, G2, H1–H4 |
| **Huỷ phần việc (CH04)** | Chỉ có ở vụ việc do Đội trưởng / người được uỷ quyền tạo; vụ việc [CB] tạo **không** có Huỷ phần việc. Trạng thái vụ việc khi huỷ hết phần việc: **I1 còn mở** | G3, I1, F4 |
| **Trạng thái vụ việc** | Bộ trạng thái mới: Chờ tiếp nhận, Đang xử lý tại Đội, Đang thực hiện, Chờ chỉ đạo, Đã hoàn thành (= "Đã xử lý" trên thẻ), Đã đóng; không còn "Đã huỷ" cấp vụ việc | E6, F4, H1, I1 |
| **Thống kê (CH05), Báo cáo hằng ngày (CH06)** | Ô "Chờ tiếp nhận", "Chờ chỉ đạo", "Đã đóng" không còn luôn bằng 0 | E6; D44 |
| **XL03 (biên bản)** | Vụ việc [CB] loại "Phát hiện vật phẩm nguy hiểm" vẫn có khối Biểu mẫu (TC-26) | §8.1; BR21 |

### 5.2 Hoãn (F2) và ngoài phạm vi

- **Hoãn theo F2:** khác biệt quyền của Tổ trưởng, Tổ phó, Phó Đội trưởng, cán bộ được uỷ quyền (kể cả "Tổ phó được uỷ quyền" ở E7, thu hồi uỷ quyền [B2], giới hạn khu vực BR36). Không viết test cho tới khi QC lead cập nhật.
- **Ngoài phạm vi:** trang quản trị web (Vai trò, Đội, khu vực, Phó trưởng phụ trách — chỉ là dữ liệu test, A4); tab Vật phẩm (H5); Yêu cầu bổ sung (E4); phần lãnh đạo xử lý Chờ chỉ đạo (F6); đặt hạn ở luồng cán bộ tạo / Đội trưởng phân công (E3).

---

## 6. Đối chiếu test condition với TA-v2.1

| TC cũ (TA-v2.1) | Tình trạng | TC mới |
|---|---|---|
| TC-01 | Giữ, thu hẹp vai trò theo F2 | TC-01 |
| TC-02 (Tổ phó không cần uỷ quyền), TC-03 (cán bộ uỷ quyền Tổ phó), TC-06 (thu hồi uỷ quyền) | **Hoãn** theo F2 | — |
| TC-04 (cán bộ không được uỷ quyền không tạo được) | **Sai sau L6** với cán bộ hiện trường; viết lại cho Văn thư (C6) | TC-04; thêm TC-02 |
| TC-05 (Phòng Camera không tạo được) | **Sai sau L6** | Thay bằng TC-03 |
| TC-07 | Giữ | TC-06 |
| TC-08 – TC-10 | Giữ | TC-07 – TC-09 |
| TC-11 | Viết lại theo nhánh | TC-10 |
| TC-12 – TC-25 | Giữ (TC-20 cũ = TC-19 mới; TC-65 cũ = TC-20 mới) | TC-11 – TC-27 |
| TC-26 (Khẩn cấp theo QB1(d)) | **Viết lại theo G1** | TC-73 |
| TC-27 – TC-48 | Giữ | TC-28 – TC-49 |
| TC-49 – TC-56 | Giữ; TC-50–52 chỉ áp dụng [NG] | TC-56 – TC-59, TC-61 – TC-64 |
| TC-57 | Giữ cho [NG] | TC-65 |
| TC-58, TC-59 | Gộp | TC-68 |
| TC-60 | Giữ cho [NG] | TC-71 |
| TC-61 | Giữ cho [NG]; nhánh [CB] GAP (E3) | TC-74 |
| TC-62, TC-63, TC-64 | Mở rộng cho [CB] | TC-75, TC-76, TC-77 |
| TC-65 | Giữ | TC-20 |
