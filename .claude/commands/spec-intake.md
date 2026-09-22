---
description: Chạy pipeline QC theo ISTQB Foundation Level khi vừa nhận 1 spec/tài liệu bàn giao cho tính năng mới — tự quyết định có cần test-analysis không, rồi lần lượt test-plan → test-case, tôn trọng mọi điểm dừng human-in-the-loop của từng skill.
argument-hint: <đường dẫn spec> hoặc <tên tính năng>
---

# Spec Intake — từ spec tính năng ra bộ tài liệu test ISTQB

Input từ user: $ARGUMENTS

Đây là command **điều phối** 3 skill đã có (`test-analysis`, `test-plan`, `test-case`) thành 1 luồng chạy khi
vừa nhận spec của một tính năng. Gọi qua Skill tool ở từng bước — **không tự bịa cấu trúc file thay cho skill**,
và **không được bỏ qua** bất kỳ điểm dừng human-in-the-loop nào mà từng skill đã quy định, kể cả khi điều đó có
nghĩa là dừng pipeline giữa chừng.

## Các bước thực hiện

1. **Xác định spec đầu vào (test basis)**
   - `$ARGUMENTS` là đường dẫn file tồn tại → dùng thẳng làm test basis.
   - `$ARGUMENTS` là tên/mô tả tính năng (không kèm path) → tìm trong `requirements/specs/` file khớp tên. Nếu
     không thấy, hoặc khớp nhiều file mơ hồ → hỏi user, không đoán đại 1 file.
   - `$ARGUMENTS` rỗng → hỏi user đường dẫn spec trước khi làm bất cứ gì tiếp theo.

2. **Đọc lướt spec, quyết định có cần chạy `test-analysis` trước `test-plan` không** — theo đúng tiêu chí đã
   nêu trong skill test-analysis: spec dài/nhiều mục, có nhiều version, có dấu hiệu mơ hồ/mâu thuẫn ngay từ lượt
   đọc đầu, hoặc nhiều bên liên quan → nên chạy. Spec ngắn, rõ ràng, 1 version → có thể bỏ qua, để `test-plan`
   tự phân tích tối thiểu. Đây là phán đoán của Claude dựa trên nội dung spec thật, **không hỏi user câu này**
   trừ khi thực sự lưỡng lự giữa hai lựa chọn.

3. **Chốt `<feature>` và `<slug>` dùng xuyên suốt cả 3 file**
   - `<feature>` = tên thư mục nghiệp vụ, kebab-case tiếng Anh — dùng lại thư mục đã có trong
     `requirements/test-plans/` nếu spec thuộc feature đã tồn tại, tạo mới nếu chưa.
   - `<slug>` = định danh ngắn cho đợt bàn giao này (version OS, số PR, ngày...) — suy từ nội dung spec.
   - Nếu tên feature có thể hiểu 2 cách, hoặc trùng lấp với 1 feature khác đã có → hỏi user trước khi tạo thư
     mục mới, tránh tạo trùng.

4. **Nếu bước 2 kết luận cần** → chạy skill **test-analysis** trên spec đã xác định, đúng `<feature>`/`<slug>`.
   - Nếu skill này dừng lại vì mục "0 · Bắt buộc dừng lại chờ người review" của nó → **dừng cả pipeline ở đây**,
     trình bày câu hỏi cho user. **Không** tự chạy tiếp test-plan khi test-analysis còn ở trạng thái DRAFT/chờ
     xác nhận.

5. **Chạy skill test-plan** trên cùng `<feature>`/`<slug>`. Nếu bước 4 đã chạy, test-plan phải dùng
   `test-analysis-<slug>.md` làm input cho mục 2/6 (test-plan tự biết làm việc này theo skill của nó).
   - Nếu test-plan dừng lại vì human-in-the-loop, hoặc tự báo còn gap ảnh hưởng scope/priority (mục 0/5 của
     skill đó) → **dừng pipeline ở đây**. Đây là gate quan trọng nhất, vì test-case dựa hoàn toàn vào test-plan
     — tuyệt đối không tự chạy test-case "cho xong việc" khi test-plan còn ở trạng thái chưa sẵn sàng.

6. **Chỉ khi test-plan đã thực sự sẵn sàng** (không còn gap chặn, không phải DRAFT) → chạy skill **test-case**
   trên cùng `<feature>`/`<slug>`.

7. **Tổng hợp báo cáo cuối cho user**, gộp từ cả 3 file (bỏ qua file nào không chạy):
   - Đường dẫn từng file đã tạo.
   - Tổng số test condition / test object / test case theo priority.
   - **Toàn bộ câu hỏi mở còn treo** cần dev/PO trả lời, gộp lại một chỗ thay vì rải rác theo từng file — kèm
     rõ câu nào đang chặn bước tiếp theo (nếu pipeline dừng giữa chừng ở bước 4 hoặc 5).
   - Bước tiếp theo cụ thể cho user (vd "chờ dev trả lời gap #X rồi chạy lại skill test-plan" hoặc "sẵn sàng
     đưa test-cases cho người thực thi").

8. **Nếu spec có nhắc tới UI/wireframe mới** (không chỉ hành vi backend/logic) → sau khi hoàn tất báo cáo, gợi ý
   riêng (không tự chạy) rằng có thể chạy thêm skill **exploratory-checklist** trên wireframe tương ứng — đây
   là nguồn khác (wireframe, không phải spec) và nhóm kỹ thuật khác (experience-based), **bổ sung** chứ không
   thay thế bộ test-analysis/test-plan/test-case.

## Quy tắc bắt buộc

- Không viết lại hay rút gọn logic của từng skill trong command này — luôn gọi qua Skill tool.
- Tôn trọng tuyệt đối mọi điểm dừng human-in-the-loop của 3 skill — không vì muốn chạy xong cả pipeline trong
  1 lượt mà bỏ qua cảnh báo, tự đoán câu trả lời, hoặc tự ý chuyển trạng thái DRAFT thành sẵn sàng.
- Không chạy test-case nếu test-plan tương ứng chưa tồn tại hoặc còn ở trạng thái DRAFT.
- Nếu spec đầu vào không tìm thấy hoặc không đọc được → dừng ngay từ bước 1, không tạo bất kỳ file nào.
