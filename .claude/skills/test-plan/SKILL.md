---
name: test-plan
description: Sinh Test Plan theo chuẩn ISTQB Foundation Level (CTFL v4.0.1) từ tài liệu bàn giao QC / spec (test basis) của một feature/flow Ink Calendar iOS. Dùng khi user nói "viết test plan cho <feature>", "lập test plan theo ISTQB cho...", "cập nhật test plan sau khi spec đổi version". Đọc test basis + đối chiếu tài liệu đã có, xuất file vào requirements/test-plans/<feature>/.
---

# Sinh Test Plan (ISTQB Foundation Level) — Ink Calendar iOS

Chuyển một tài liệu bàn giao QC/spec (**test basis**) thành **Test Plan** đúng cấu trúc ISTQB Foundation Level:
xác định phạm vi, kỹ thuật thiết kế case, độ ưu tiên theo rủi ro, tiêu chí vào/ra — làm nền để skill
[test-case](../test-case/SKILL.md) thiết kế case cụ thể ngay sau đó.

**Nếu đã có [test-analysis](../test-analysis/SKILL.md)** (`test-analysis-<slug>.md` cùng thư mục) → dùng luôn
danh sách test condition đã ưu tiên hoá ở đó cho mục 2 (test object) và mục 6 (risk) thay vì phân tích lại từ
đầu. Nếu chưa có (spec nhỏ/rõ ràng) → skill này tự làm phần phân tích tối thiểu ngay trong mục 2/5/6 dưới đây.

---

## 0 · Bắt buộc dừng lại chờ người review (human-in-the-loop)

Test plan quyết định toàn bộ phạm vi và độ ưu tiên test — sai ở đây thì **mọi test case sinh ra sau đều sai
theo**. Vì vậy, ở các điểm dưới đây **không được tự đoán một cách hiểu rồi viết tiếp như thể đã chắc chắn** — phải
dừng lại, trình bày rõ vướng mắc, và **chờ user (hoặc dev/PO qua user) xác nhận** trước khi viết tiếp:

- Test basis **thiếu, mơ hồ, hoặc mâu thuẫn nội bộ** ở một điểm ảnh hưởng scope hoặc risk level.
- Test basis có **nhiều version** mà không rõ version nào là nguồn sự thật hiện tại.
- Một hạng mục **không đủ thông tin để xếp P1 hay P2/P3** (thiếu business impact rõ ràng).
- Không chắc **kỹ thuật thiết kế nào áp dụng được** cho một test object (vd không đủ dữ liệu để biết đây là
  partition hay chỉ là 1 giá trị đơn lẻ).
- Phạm vi test basis **rộng bất thường**, có dấu hiệu nên tách thành nhiều test plan riêng.

**Cách dừng:** đặt câu hỏi cụ thể — nêu rõ đang vướng ở đâu, các lựa chọn khả dĩ, và ảnh hưởng của mỗi lựa chọn
tới scope/priority. Ưu tiên dùng công cụ hỏi trực tiếp (vd AskUserQuestion) nếu có sẵn; nếu không, dừng và hỏi
bằng text **trước khi** tạo file — không âm thầm chọn 1 phương án rồi viết cả file xong mới báo.

**Nếu vẫn cần một bản nháp trước khi có câu trả lời** (vd để user dễ hình dung câu hỏi hơn): được phép viết, nhưng
đầu file phải có dòng `> ⚠️ DRAFT — chờ xác nhận: <câu hỏi cụ thể>`, và khi báo cáo lại user (mục 5) phải nói rõ
đây là **bản nháp chưa thể dùng để chạy test-case**, không được báo như thể đã hoàn tất.

---

## 1 · Đầu vào bắt buộc — đọc hết trước khi viết

| Nguồn | Đọc để lấy gì |
|---|---|
| Tài liệu **test basis** (spec/QC handoff của feature, thường ở `requirements/specs/<feature>/...`) | Nguồn sự thật duy nhất để suy ra scope, hành vi kỳ vọng, câu hỏi mở |
| `requirements/test-plans/<feature>/test-analysis-<slug>.md` (nếu đã chạy skill test-analysis) | Danh sách test condition **đã ưu tiên hoá** — dùng thẳng cho mục 2/6, không phân tích lại |
| `requirements/istqb-foundation/ISTQB_CTFL_Syllabus_v4.0.1.md` | Định nghĩa chuẩn cho mọi khái niệm dùng trong test plan — xem bảng mục 2 dưới đây để biết đọc mục nào |
| `requirements/test-plans/<feature khác gần nhất>/test-plan-*.md` đã có (đặc biệt `shortcuts/test-plan-ios26-27.md`) | **Mẫu chuẩn** về độ sâu, cách trình bày, cách viết mục risk/entry-exit/gap |
| `.claude/rules/screenshot-naming.md` §7 (flow map) | Liệt kê toàn bộ flow của app để điền bảng "Ảnh hưởng chéo tới flow khác" (mục 3.1) |
| `requirements/exploratory/<NN>_<flow>.md`, wireframe cùng flow (nếu có) | Đối chiếu case/checklist cũ — phát hiện điểm mâu thuẫn hoặc case cần chạy lại (regression) |
| `bugs/bug-log.md` (nếu có bug liên quan) | Bug cũ cần regression lại trong test plan mới |

Nếu **không có test basis** → dừng lại, hỏi user đường dẫn tài liệu, không tự bịa phạm vi.
Nếu test basis có **nhiều version** (V1, V2…) → chỉ dùng version **mới nhất được xác nhận** làm nguồn sự thật,
nhưng vẫn phải viết bảng đối chiếu "V-cũ thay thế V-mới" nếu có sai sót đã sửa (xem mục 3 bên dưới) — không lặng
lẽ ghi đè kết luận cũ.

### 1.1 Tra cứu ISTQB theo từng phần cần viết

| Phần test plan cần viết | Đọc mục nào trong syllabus |
|---|---|
| Test levels & test types (mục 4) | §2.2 Test Levels and Test Types, §2.2.3 Confirmation/Regression Testing |
| Kỹ thuật thiết kế test case (mục 5) | §4.1 Test Techniques Overview, §4.2 Black-box (EP/BVA/Decision Table/State Transition), §4.4 Experience-based (Error guessing/Exploratory/Checklist-based) |
| Risk-based prioritization (mục 6) | §5.2 Risk Management (risk likelihood × impact = risk level, product risk vs project risk) |
| Entry/Exit/Suspension criteria (mục 8, 9) | §5.1.3 Entry Criteria and Exit Criteria |
| Test case prioritization / thứ tự chạy | §5.1.5 Test Case Prioritization |

Trích đúng khái niệm, **không dùng thuật ngữ ISTQB sai nghĩa** (vd đừng gọi Equivalence Partitioning là "chia
case theo cảm tính" — phải là chia theo *partition* dữ liệu/đầu vào có ranh giới rõ).

---

## 2 · Đầu ra

**Đường dẫn:** `requirements/test-plans/<feature>/test-plan-<slug>.md`.
- `<feature>` = tên thư mục feature (dùng lại nếu đã tồn tại, tạo mới nếu chưa — đặt tên theo nghiệp vụ, tiếng
  Anh, kebab-case, giống quy tắc flow-name của [screenshot-naming.md](../../rules/screenshot-naming.md) §2).
- `<slug>` = định danh ngắn cho đợt test này (vd version OS, số PR, tên bản spec) — **giữ nguyên slug đó** khi
  skill test-case sinh file `test-cases-<slug>.md` cùng thư mục, để 2 file luôn đi cặp.

Nếu feature đã có test plan cũ (version trước) → **tạo file mới với slug mới**, không ghi đè — test plan cũ vẫn
còn giá trị lịch sử, viết bảng đối chiếu ngắn ở đầu file mới nếu có thay đổi lớn.

---

## 3 · Cấu trúc file phải sinh

```markdown
# Test Plan — <Tên feature/đợt test bằng tiếng Việt>

> **Test basis:** [<tên file>](<path>) — build/nhánh/commit cụ thể, ngày bàn giao.
> **Chuẩn:** ISTQB Foundation Level v4.0.1 (test basis → test object → kỹ thuật thiết kế → rủi ro → entry/exit)
> **Test case cụ thể:** [test-cases-<slug>.md](test-cases-<slug>.md) — sẽ sinh bởi skill test-case sau khi test
> plan này được duyệt.
> **Đối chiếu tài liệu đã có:** liệt kê exploratory checklist / wireframe / test-plan flow liên quan / bug-log.
> **Ngày lập:** <ngày> · **Người lập:** QC

## 1. Phát hiện khi đối chiếu với tài liệu đã có
Những điểm test basis mới **mâu thuẫn, bổ sung, hoặc đảo ngược** kết luận trong tài liệu cũ (checklist,
wireframe, test plan trước). Nếu test basis có version cũ bị thay thế → bảng đối chiếu "V-cũ → V-mới" ở đây.

## 2. Test object — In scope
Bảng: # · Hạng mục · Nguồn (mục nào của test basis) · Ghi chú. Đây cũng là nơi cấp **mã nhóm case** (2–4 chữ,
in hoa) mà skill test-case sẽ dùng làm tiền tố ID — vd `INS`, `HS`, `PAIR`.

## 3. Out of scope
Mỗi mục out-of-scope phải có **lý do** (đã xác nhận không phải bug, ngoài phạm vi bàn giao, chưa build...).

### 3.1 Ảnh hưởng chéo tới flow khác (regression impact ngoài phạm vi note)
Bảng: Flow (theo đúng flow-no/flow-name của [screenshot-naming.md §7](../../rules/screenshot-naming.md#7-flow-map--ink-calendar-ios))
· Ảnh hưởng? (Trực tiếp/Gián tiếp/Không) · Lý do.

## 4. Test levels & test types
Level (System/Integration/... — §2.2.1) · Functional / Non-functional (chỉ rõ quality characteristic theo
ISO 25010 nêu ở §2.2.2: performance, compatibility, usability, reliability, security, maintainability,
portability, safety) · Change-related (confirmation + regression testing cụ thể sẽ chạy lại — §2.2.3).

## 5. Kỹ thuật thiết kế test case
Với **mỗi** test object ở mục 2, chọn kỹ thuật phù hợp và giải thích ngắn vì sao (không áp dụng tất cả kỹ thuật
cho mọi case). Trình bày trực tiếp thành bảng/dữ liệu dùng được ngay (không chỉ nói tên kỹ thuật):
- **Equivalence Partitioning:** liệt kê từng tập partition (hợp lệ + không hợp lệ) cho từng biến.
- **Boundary Value Analysis:** nêu rõ dùng 2-value hay 3-value BVA (§4.2.2), giá trị biên cụ thể.
- **Decision Table:** bảng đủ điều kiện × action, đánh số rule/cột.
- **State Transition:** state diagram/table dạng liệt kê states + events + transition hợp lệ/không hợp lệ.
- **Exploratory testing (session-based):** ghi rõ charter (mục tiêu phiên) cho phần **thật sự** chưa biết trước
  kết quả — không dùng nhãn "exploratory" cho case đã có đáp án rõ từ test basis.
- **Error guessing / Checklist-based:** chỉ dùng khi có nguồn cụ thể (bug cũ, checklist cũ) — trích nguồn.

## 6. Risk-based prioritization
Giải thích risk level = risk likelihood × risk impact (§5.2.1) trước khi xếp nhãn. Nhóm theo:
**P1 — chặn phát hành** (impact cao: mất tiền/mất dữ liệu/vỡ luồng chính) · **P2** (mất một phần chức năng,
có workaround) · **P3** (cosmetic/UX nhẹ). Mỗi case P1 phải nêu rõ vì sao impact cao, không chỉ dán nhãn.

## 7. Test environment matrix
Thiết bị/OS bắt buộc · dữ liệu cần chuẩn bị trước (baseline) · file/test-data cần cài đặt · build cụ thể.

## 8. Entry criteria
Theo đúng §5.1.3: tài nguyên sẵn sàng (người, tool, môi trường, test data), testware sẵn sàng (test basis, test
case), chất lượng ban đầu của test object (smoke test đã pass).

## 8.1 Suspension & Resumption criteria
Điều kiện dừng toàn cụm/dừng cục bộ khi phát hiện sai lệch nghiêm trọng so với kỳ vọng của test basis — nêu rõ
điều kiện resume (chạy lại từ đầu cụm đã suspend, không tiếp tục giữa chừng).

## 9. Exit criteria
Theo đúng §5.1.3: đo lường độ đầy đủ (coverage, số bug P1 mở = 0, case đã chạy hết) + tiêu chí nhị phân
(regression đã chạy, câu hỏi mở đã có trả lời hoặc được chấp nhận là gap đã biết).

## 10. Gap cần làm rõ trước khi execute
Câu hỏi **cần dev/PO trả lời bằng văn bản** trước khi tin vào kết quả test — đánh số, có thể ảnh hưởng case nào.

## 11. Coverage gap — case chưa được test basis liệt kê
Bảng: Thiếu gì · Vì sao là gap (test basis không nhắc, hoặc suy luận thấy rủi ro mới QC tự phát hiện).
```

---

## 4 · Quy tắc nội dung — quan trọng nhất

**Test basis là nguồn sự thật duy nhất.** Mọi scope, hành vi kỳ vọng phải truy được về một mục cụ thể của test
basis. Suy luận thêm (vd từ phân tích binary, đối chiếu tài liệu cũ) phải đánh dấu rõ là **suy luận của QC**,
tách biệt với **sự thật do test basis xác nhận**.

**Không xếp priority tùy cảm tính.** Mỗi P1/P2/P3 phải giải thích được bằng risk likelihood × impact (§5.2.1) —
nếu không giải thích được thì hạ xuống P2/P3 thay vì mặc định P1.

**Không dùng kỹ thuật cho có.** Chỉ liệt kê kỹ thuật thiết kế thực sự áp dụng được cho test object đó. Một flow
toàn state đơn giản, không có tổ hợp điều kiện, không cần Decision Table.

**Đừng nhầm exploratory với "chưa nghĩ ra case".** Exploratory chỉ dùng khi test basis **tự thừa nhận** không
biết trước kết quả đúng (thăm dò thật), không phải nơi vứt các case chưa kịp thiết kế kỹ.

**Cross-flow impact bắt buộc đối chiếu flow map thật**, không đoán flow nào bị ảnh hưởng — dùng đúng danh sách
flow ở screenshot-naming.md §7.

**Version cũ bị thay thế → không xoá, chỉ đánh dấu superseded** và giải thích rõ sai ở đâu, đúng ở đâu (xem cách
làm ở `shortcuts/test-plan-ios26-27.md` mục "V2 thay thế V1").

**Gap (mục 10) khác Coverage gap (mục 11).** Mục 10 = câu hỏi mà **câu trả lời sẽ đổi kết quả mong đợi** của case
đã viết. Mục 11 = case **hoàn toàn chưa được nghĩ tới** trong test basis, QC tự bổ sung.

---

## 5 · Sau khi sinh xong

1. Báo user: đường dẫn file · số hạng mục in-scope · số case P1 dự kiến (ước lượng từ mục 5) · số gap mở (mục 10).
2. **Kiểm tra lại mục 10 (Gap):** nếu còn gap **ảnh hưởng trực tiếp scope hoặc priority** (không phải chi tiết
   nhỏ) chưa có câu trả lời → dừng ở đây, liệt kê rõ từng câu hỏi đó cho user, và **không** báo là "test plan đã
   sẵn sàng". Chỉ báo sẵn sàng khi không còn gap loại này, hoặc user đã xác nhận chấp nhận rủi ro/chọn hướng xử lý.
3. Khi đã thực sự sẵn sàng: nhắc user bước tiếp theo là chạy skill **test-case** trên chính file vừa sinh.
4. Nếu phát hiện scope quá rộng cho 1 test plan (nhiều test object không liên quan nhau) → đề nghị tách thành
   nhiều test plan riêng thay vì nhồi vào 1 file.
5. **Không** tự sinh test case trong cùng lượt chạy này — skill này dừng lại ở test plan.
