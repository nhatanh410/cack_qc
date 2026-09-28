---
description: Chạy pipeline QC theo ISTQB Foundation Level khi vừa nhận 1 spec/tài liệu bàn giao cho tính năng mới — điều phối 3 subagent chuyên trách (qc-test-analysis, qc-test-plan, qc-test-case) theo đúng thứ tự SPEC → TEST ANALYSIS (tùy chọn) → TEST PLAN → TEST CASE, tôn trọng mọi điểm dừng human-in-the-loop mà từng agent tự báo cáo.
argument-hint: <đường dẫn spec> hoặc <tên tính năng>
allowed-tools: Agent, Read, Glob, Grep, AskUserQuestion
---

# Spec Intake — từ spec tính năng ra bộ tài liệu test ISTQB

Input từ user: $ARGUMENTS

Đây là command **điều phối thuần tuý** (orchestration only). Command này **không** tự chạy bất
kỳ skill nào và **không** tự viết bất kỳ artifact QC nào — mọi việc phân tích/lập kế
hoạch/thiết kế case đều do 3 subagent chuyên trách đảm nhận, gọi qua tool **Agent**
(`subagent_type` = tên agent tương ứng):

| Bước ISTQB | Subagent (`subagent_type`) | Sở hữu file |
|---|---|---|
| Test Analysis | `qc-test-analysis` | `test-analysis-<slug>.md` |
| Test Planning | `qc-test-plan` | `test-plan-<slug>.md` |
| Test Design | `qc-test-case` | `test-cases-<slug>.md` |

Vai trò của command chỉ gồm: xác định input → chốt feature/slug → gọi từng agent với đủ ngữ cảnh
→ **đọc lại trường trạng thái mà agent tự báo cáo** → quyết định dừng hay tiếp tục → tổng hợp báo
cáo cuối. Command **không được** tự suy ra Analysis/Test Plan Status thay agent, không được tự
đoán câu trả lời cho open question, và không được gọi agent kế tiếp khi agent trước báo trạng thái
không phải READY.

## Các bước thực hiện

1. **Xác định spec đầu vào (test basis)**
   - `$ARGUMENTS` là đường dẫn file tồn tại → dùng thẳng làm test basis.
   - `$ARGUMENTS` là tên/mô tả tính năng (không kèm path) → `Glob`/`Grep` trong
     `requirements/specs/` tìm file khớp tên.
     - 0 khớp → hỏi user đường dẫn, không đoán đại.
     - 1 khớp → dùng file đó.
     - >1 khớp mơ hồ → dùng `AskUserQuestion` để user chọn đúng file, không tự chọn hộ.
   - `$ARGUMENTS` rỗng → `AskUserQuestion` hỏi đường dẫn spec trước khi làm bất cứ gì tiếp theo.
   - Không đọc được file đã chọn → dừng ngay từ đây, không tạo bất kỳ thứ gì, báo lỗi cho user.

2. **Đọc lướt spec (chỉ để ra quyết định điều phối, không phân tích domain)**, quyết định có cần
   gọi `qc-test-analysis` trước `qc-test-plan` không — theo đúng tiêu chí mô tả trong skill
   `test-analysis`: spec dài/nhiều mục, nhiều version, có dấu hiệu mơ hồ/mâu thuẫn ngay từ lượt
   đọc đầu (kể cả bảng câu hỏi còn bỏ trống), hoặc nhiều bên liên quan → nên chạy. Spec ngắn, rõ
   ràng, 1 version → có thể bỏ qua, để `qc-test-plan` tự phân tích tối thiểu. Đây là phán đoán của
   Claude dựa trên nội dung spec thật — **không hỏi user câu này** trừ khi thực sự lưỡng lự.

3. **Chốt `<feature>` và `<slug>` dùng xuyên suốt cả 3 file** (command tự làm bước này, không
   giao cho agent, vì agent cần nhận sẵn 2 giá trị này để không tự đoán lệch nhau giữa 3 lần gọi):
   - `<feature>` = tên thư mục nghiệp vụ, kebab-case tiếng Anh — `Glob` `requirements/test-plans/`
     để tái sử dụng thư mục đã có nếu spec thuộc feature đã tồn tại, tạo tên mới nếu chưa.
   - `<slug>` = định danh ngắn cho đợt bàn giao này (version OS, số PR, ngày...) — suy từ nội dung
     spec, không tự bịa.
   - Feature tên có thể hiểu 2 cách, hoặc trùng lấp feature đã có → `AskUserQuestion` trước khi
     tạo thư mục mới, tránh tạo trùng.

4. **Nếu bước 2 kết luận cần Test Analysis** → gọi tool `Agent` với `subagent_type: qc-test-analysis`,
   truyền trong prompt: đường dẫn test basis đã resolve, `<feature>`, `<slug>`.
   - Đọc báo cáo cuối mà agent trả về, lấy đúng 2 trường **Analysis Status** và **Downstream
     Permission**.
   - **Downstream Permission = ALLOWED (Analysis Status = READY)** → tiếp tục bước 5, dùng
     `test-analysis-<slug>.md` vừa tạo làm input cho `qc-test-plan`.
   - **Ngược lại (DRAFT/BLOCKED)** → **dừng cả pipeline ở đây**. Dùng `AskUserQuestion` (hoặc
     trình bày rõ bằng text nếu câu hỏi cần nhiều ngữ cảnh) để đưa Open/Blocking Questions của
     agent cho user. **Không** gọi `qc-test-plan`.

   > **Lưu ý về 2 lớp duyệt riêng biệt:** `qc-test-analysis` chạy `permissionMode: plan`, nghĩa là
   > việc người dùng duyệt `ExitPlanMode` bên trong lượt chạy của agent đó **chỉ cho phép agent ghi
   > file test-analysis** — nó **không** tự động là sự cho phép để command tiếp tục sang Test Plan.
   > Sự cho phép tiếp tục pipeline chỉ tới từ việc command đọc thấy Downstream Permission = ALLOWED
   > ở bước này. Hai lần "approve" này độc lập nhau và **đều bắt buộc**.

5. **Gọi tool `Agent` với `subagent_type: qc-test-plan`**, truyền: `<feature>`, `<slug>`, đường dẫn test
   basis, và — nếu bước 4 đã chạy và ALLOWED — đường dẫn `test-analysis-<slug>.md`.
   - Đọc báo cáo cuối, lấy trường **Test Plan Status**.
   - **READY** → tiếp tục bước 6.
   - **DRAFT/BLOCKED** → **dừng pipeline ở đây** (gate quan trọng nhất — test-case phụ thuộc hoàn
     toàn vào test-plan). Dùng `AskUserQuestion`/text trình bày Open Questions/Blocking Gaps agent
     đã báo. **Không** gọi `qc-test-case` "cho xong việc".

6. **Chỉ khi bước 5 báo Test Plan Status = READY** → gọi tool `Agent` với `subagent_type: qc-test-case`,
   truyền: `<feature>`, `<slug>`, đường dẫn `test-plan-<slug>.md`, Test Plan Status = READY (để
   agent đối chiếu, nhưng agent vẫn tự kiểm tra lại độc lập theo thiết kế của chính nó — command
   không bỏ qua bước đó dù đã tự kiểm tra ở đây).
   - Nếu agent tự phát hiện bất đồng (Status tự suy ra ≠ READY dù command đã báo READY) → dừng lại
     ngay khi đọc thấy điều đó trong báo cáo, coi đây là lỗi nghiêm trọng cần user xem xét trước
     khi tin bất kỳ tài liệu nào trong đợt chạy này.

7. **Tổng hợp báo cáo cuối cho user**, đúng khuôn dưới đây, gộp từ agent nào đã chạy (bỏ qua agent
   không chạy, ghi rõ "không chạy" thay vì để trống mập mờ):

   ```text
   ==================================================
    SPEC INTAKE — BÁO CÁO PIPELINE QC
   ==================================================
   Spec       : <path spec gốc>
   Feature    : <feature>
   Slug       : <slug>
   Pipeline   : SPEC -> [TEST ANALYSIS] -> TEST PLAN -> TEST CASE
   Status     : <HOÀN TẤT / DỪNG Ở BƯỚC ...>

   --------------------------------------------------
   ARTIFACTS
   --------------------------------------------------
   - Test Analysis : <path hoặc "không chạy">   (Status: DRAFT/READY/BLOCKED/—)
   - Test Plan     : <path hoặc "chưa tạo">     (Status: DRAFT/READY/BLOCKED/—)
   - Test Case     : <path hoặc "chưa tạo">     (Status: COMPLETED/BLOCKED/—)

   --------------------------------------------------
   SUMMARY
   --------------------------------------------------
   Test Condition  : <tổng>   (P1: n · P2: n · P3: n)
   Test Case       : <tổng>   (P1: n · P2: n · P3: n)
   Marker          : Exploratory 🔭 n · Gap-dependent ⚠️ n · Bổ sung 🆕 n

   --------------------------------------------------
   OPEN QUESTIONS (không chặn bước tiếp theo)
   --------------------------------------------------
   1. ...

   --------------------------------------------------
   BLOCKING QUESTIONS (đang chặn bước tiếp theo, nếu pipeline dừng giữa chừng)
   --------------------------------------------------
   1. [Chặn: TEST PLAN] ...

   --------------------------------------------------
   NEXT STEP
   --------------------------------------------------
   - <vd: "Chờ dev trả lời câu hỏi #1 rồi chạy lại /spec-intake cho cùng slug"
     hoặc "Test case đã sẵn sàng, đưa cho người thực thi.">
   ==================================================
   ```

   Ưu tiên P1/P2/P3 (không có P0 — đây là thang ưu tiên duy nhất mà các skill trong repo này
   dùng).

8. **Nếu spec có nhắc tới UI/wireframe mới** (không chỉ hành vi backend/logic) → sau khi hoàn tất
   báo cáo, gợi ý riêng (không tự chạy) rằng có thể chạy thêm skill **exploratory-checklist** trên
   wireframe tương ứng — nguồn khác (wireframe, không phải spec), nhóm kỹ thuật khác
   (experience-based), **bổ sung** chứ không thay thế bộ test-analysis/test-plan/test-case.

## Quy tắc bắt buộc

- Command này **không** gọi Skill tool trực tiếp và **không** viết/sửa bất kỳ artifact QC nào —
  toàn bộ việc đó thuộc về `qc-test-analysis`/`qc-test-plan`/`qc-test-case`. `allowed-tools` ở
  frontmatter đã cố tình không có `Write`/`Edit`/`Skill` để ép cấu trúc này.
- Tôn trọng tuyệt đối trạng thái mà từng agent tự báo cáo — không tự đoán, không tự nâng
  DRAFT/BLOCKED thành READY, không tự trả lời open question thay user.
- Không gọi `qc-test-case` nếu `qc-test-plan` chưa từng chạy hoặc báo trạng thái khác READY.
- Nếu spec đầu vào không tìm thấy hoặc không đọc được → dừng ngay từ bước 1, không gọi bất kỳ
  agent nào.
