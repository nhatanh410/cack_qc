---
name: test-analysis
description: Phân tích test basis theo ISTQB Foundation Level (§1.4.1 Test Analysis + §3 Static Testing + §5.2 Risk Management) trước khi lập test plan — rà soát testability của tài liệu bàn giao (mơ hồ/thiếu/mâu thuẫn), trích xuất và ưu tiên hoá test condition. Dùng khi user nói "phân tích test basis cho <feature>", "review testability của spec X", "trích test condition cho <feature>", hoặc trước khi chạy skill test-plan trên một spec mới/dài/nhiều bên liên quan. Xuất file vào requirements/test-plans/<feature>/test-analysis-<slug>.md.
---

# Sinh Test Analysis (ISTQB Foundation Level) — Hệ thống Quản lý vụ việc CACK Nội Bài

Theo [ISTQB CTFL v4.0.1 §1.4.1](../../../requirements/istqb-foundation/ISTQB_CTFL_Syllabus_v4.0.1.md), test
process gồm các nhóm hoạt động: **Test Planning → Monitoring & Control → Test Analysis → Test Design → Test
Implementation → Test Execution → Test Completion**. Ba skill hiện có chia nhau đúng các bước này:

| Bước ISTQB | Skill phụ trách | Câu hỏi trả lời |
|---|---|---|
| Test Analysis | **test-analysis** (skill này) | "**Cái gì** cần test?" — testable feature nào, test condition nào, ưu tiên ra sao |
| Test Planning | [test-plan](../test-plan/SKILL.md) | Phạm vi, kỹ thuật thiết kế, entry/exit criteria |
| Test Design | [test-case](../test-case/SKILL.md) | "**Test như thế nào**?" — case cụ thể |

Skill này đọc **test basis** (chưa cần đã có test plan), đánh giá **testability** của chính tài liệu đó (tìm
mơ hồ/thiếu/mâu thuẫn — góc nhìn static testing, §3), rồi rút ra danh sách **test condition đã ưu tiên hoá**
(§5.2) để test-plan dùng trực tiếp cho mục 2 (test object) và mục 6 (risk-based prioritization).

**Khi nào cần chạy skill này riêng thay vì để test-plan tự phân tích gộp:** test basis dài, nhiều version, có
dấu hiệu mơ hồ/mâu thuẫn, hoặc nhiều bên liên quan cần thấy rõ bằng chứng review testability trước khi cam kết
scope. Với spec nhỏ/rõ ràng, có thể bỏ qua bước này — chạy thẳng test-plan (skill đó vẫn tự làm phần phân tích
tối thiểu ở mục 2/5/6 của nó).

---

## 0 · Bắt buộc dừng lại chờ người review (human-in-the-loop)

Test condition sai hoặc thiếu ở bước này sẽ kéo theo scope sai ở test-plan và case sai ở test-case — đây là
điểm đòn bẩy cao nhất trong cả 3 skill. Ở các điểm dưới đây **không được tự chọn một cách hiểu rồi viết tiếp**:

- Một câu/đoạn trong test basis **mơ hồ đến mức 2 cách hiểu dẫn tới 2 tập test condition khác hẳn nhau** — đưa
  cả hai cách hiểu vào mục 1 (testability issues), **không tự chọn 1 cách hiểu** để viết tiếp mục 2.
- Test basis **mâu thuẫn nội bộ** (hai đoạn nói khác nhau về cùng một hành vi) — dừng, hỏi user/nêu rõ trong
  mục 1, không tự "hoà giải" bằng suy đoán của mình.
- Không đủ căn cứ để gán **risk likelihood hoặc risk impact** cho một test condition (thiếu thông tin business
  impact) — liệt vào mục 4 (câu hỏi cần làm rõ) **và** hỏi trực tiếp user, không mặc định risk level trung bình
  cho xong.
- Test basis là **user story không có acceptance criteria rõ** — không tự bịa acceptance criteria; nêu rõ đây
  là gap cần PO bổ sung trước (đúng tinh thần §4.5.2: acceptance criteria là một dạng test condition, không phải
  thứ QC tự đặt ra).

**Cách dừng:** đặt câu hỏi cụ thể (đoạn nào, hai cách hiểu là gì, ảnh hưởng thế nào tới scope/risk). Ưu tiên
dùng công cụ hỏi trực tiếp nếu có sẵn; nếu không, dừng bằng text trước khi hoàn tất mục 2/3. Nếu vẫn cần viết
bản nháp để user dễ hình dung câu hỏi, đánh dấu `> ⚠️ DRAFT — chờ xác nhận: <câu hỏi>` ở đầu file, và khi báo
cáo (mục 5) phải nói rõ đây là nháp, **không** báo "sẵn sàng chạy test-plan".

---

## 1 · Đầu vào bắt buộc — đọc hết trước khi viết

| Nguồn | Đọc để lấy gì |
|---|---|
| Tài liệu **test basis** (spec/QC handoff, thường ở `requirements/specs/<feature>/...`) | Nguồn duy nhất để rút test condition — chưa cần test plan đã tồn tại |
| `requirements/istqb-foundation/ISTQB_CTFL_Syllabus_v4.0.1.md` §1.4.1 | Định nghĩa test condition, test analysis, traceability |
| … §3 (Static Testing) | Cách nhìn ra defect trong chính tài liệu: ambiguity, incompleteness, inconsistency — không phải lỗi phần mềm mà lỗi của spec |
| … §5.2 (Risk Management) | Risk level = risk likelihood × risk impact; phân biệt product risk (ISO 25010: functional suitability, performance, compatibility, usability, reliability, security, maintainability, portability) vs project risk |
| … §4.5.2 (Acceptance Criteria) | Nếu test basis là user story — dùng acceptance criteria có sẵn làm test condition, không viết lại |
| `requirements/test-plans/<feature khác>/test-plan-*.md` đã có | Đối chiếu cách một test-plan trước đã diễn giải test condition thành test object — tham khảo độ chi tiết cần có |
| Tài liệu liên quan khác (exploratory checklist, wireframe, bug-log cùng feature) | Đối chiếu mâu thuẫn với hiểu biết đã có, không bắt buộc nhưng nên đọc nếu tồn tại |

Nếu không có test basis → dừng lại, hỏi user đường dẫn tài liệu, không tự suy ra phạm vi từ tên feature.

---

## 2 · Đầu ra

**Đường dẫn:** `requirements/test-plans/<feature>/test-analysis-<slug>.md` — cùng thư mục và cùng `<slug>` sẽ
được test-plan/test-case dùng tiếp (`test-plan-<slug>.md`, `test-cases-<slug>.md`), để 3 file luôn đi thành bộ
và tra ngược dễ dàng.

---

## 3 · Cấu trúc file phải sinh

```markdown
# Test Analysis — <Tên feature/đợt test>

> **Test basis:** [<tên file>](<path>).
> **Chuẩn:** ISTQB Foundation Level v4.0.1 §1.4.1 (Test Analysis) + §3 (Static Testing) + §5.2 (Risk Management)
> **Bước tiếp theo:** [test-plan](../test-plan/SKILL.md) sẽ dùng mục 2 (test condition) làm test object và mục
> 2 cột risk level làm cơ sở mục 6 (risk-based prioritization) — chạy sau khi tài liệu này không còn câu hỏi
> mở quan trọng ở mục 4.
> **Ngày lập:** <ngày> · **Người lập:** QC

## 1. Đánh giá testability của test basis
Bảng: # · Trích đoạn/mục trong test basis · Vấn đề · Loại (mơ hồ / thiếu / mâu thuẫn / không kiểm được) · Cần
hỏi ai. Đây là "defect trong chính tài liệu", không phải defect của app — mục tiêu là làm sạch test basis
trước khi tin vào nó.

## 2. Test condition đã ưu tiên hoá
Bảng: # · Test condition (1 tính năng/hành vi/thuộc tính chất lượng đo được, KHÔNG phải cả 1 màn hình chung
chung) · Nguồn (mục nào test basis) · Loại (Functional / Non-functional — ghi rõ quality characteristic theo
ISO 25010 nếu non-functional) · Risk likelihood (Thấp/Vừa/Cao) · Risk impact (Thấp/Vừa/Cao) · Risk level (suy
ra từ 2 cột trên) · Ưu tiên gợi ý (P1/P2/P3 — cùng thang sẽ dùng ở test plan mục 6).

## 3. Traceability nháp
Bảng: Test condition # ↔ mục test basis ↔ ghi chú cho test-plan (gợi ý mã nhóm test object nếu thấy rõ, để
trống nếu chưa chắc — test-plan sẽ chốt lại).

## 4. Câu hỏi cần làm rõ trước khi lập test plan
Câu hỏi phát sinh trực tiếp từ mục 1 (testability issues) mà câu trả lời **sẽ đổi risk level hoặc phạm vi** của
một hay nhiều test condition ở mục 2 — đánh số, nêu rõ test condition nào bị ảnh hưởng.
```

---

## 4 · Quy tắc nội dung — quan trọng nhất

**Test condition phải cụ thể và đo được** — "1 chức năng, 1 giao dịch, 1 thuộc tính chất lượng, hay 1 phần tử
cấu trúc" (định nghĩa ISTQB). "Toàn bộ màn hình Settings" không phải 1 test condition — phải tách thành từng
hành vi/thuộc tính cụ thể trong màn đó.

**Risk level luôn tính bằng likelihood × impact**, không dán nhãn P1/P2/P3 cảm tính. Nếu thiếu căn cứ cho 1
trong 2 trục → đây là câu hỏi mở (mục 4), không phải chỗ để đoán cho có số.

**Không tự sửa nghĩa mơ hồ của test basis.** Mọi chỗ mơ hồ/mâu thuẫn phải vào mục 1 nguyên văn, kèm **cả hai (hoặc
nhiều) cách hiểu khả dĩ** nếu có — không chọn sẵn 1 cách hiểu rồi chỉ liệt kê cách đó trong mục 2.

**Acceptance criteria có sẵn thì dùng thẳng, không viết lại.** Nếu test basis là user story đã có acceptance
criteria (§4.5.2), coi đó là test condition có sẵn — chỉ cần đối chiếu đủ đo được chưa, không tự diễn giải khác.

**Không lẫn Test Analysis với Test Design.** Mục 2 chỉ trả lời "cái gì cần test", **không** viết bước thực hiện
cụ thể hay kỹ thuật thiết kế (EP/BVA/Decision Table...) — đó là việc của test-plan (chọn kỹ thuật) rồi test-case
(thiết kế case). Nhầm lẫn ở đây làm tài liệu vừa thiếu vừa thừa.

**Số lượng vừa đủ để dùng được.** Test condition nên gộp ở mức "một hành vi có thể kiểm được", không vụn tới
từng pixel cũng không gộp tới mức mất chi tiết rủi ro — nếu phân vân, nghiêng về mức chi tiết mà một dòng trong
Decision Table hoặc một partition ở test-plan mục 5 có thể dùng ngay.

---

## 5 · Sau khi sinh xong

1. Báo user: đường dẫn file · số test condition theo priority · số vấn đề testability tìm thấy ở mục 1.
2. **Kiểm tra lại mục 4:** nếu còn câu hỏi ảnh hưởng risk level/scope của test condition quan trọng → dừng ở
   đây, liệt kê rõ cho user, **không** báo "sẵn sàng chạy test-plan".
3. Khi đã thực sự sẵn sàng: nhắc user bước tiếp theo là chạy skill **test-plan**, dùng chính file này làm input
   cho mục 2 (test object) và mục 6 (risk-based prioritization) — không cần phân tích lại từ đầu.
4. **Không** tự viết tiếp sang test plan hay test case trong cùng lượt chạy này — skill này dừng lại ở test
   analysis.
