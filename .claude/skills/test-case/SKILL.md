---
name: test-case
description: Sinh Test Case Specification theo chuẩn ISTQB Foundation Level (CTFL v4.0.1) từ một Test Plan đã có của hệ thống Quản lý vụ việc CACK Nội Bài. Dùng khi user nói "viết test case cho <feature>", "thiết kế test case theo test plan X", "sinh case theo EP/BVA/Decision Table cho <feature>". Bắt buộc đã có test-plan-*.md (chạy skill test-plan trước nếu chưa có). Đọc mục 5 (kỹ thuật thiết kế) + mục 6 (risk) của test plan, xuất file test-cases-*.md cùng thư mục.
---

# Sinh Test Case Specification (ISTQB Foundation Level) — Hệ thống Quản lý vụ việc CACK Nội Bài

Chuyển **kỹ thuật thiết kế** đã chọn trong Test Plan (mục 5) thành **bảng test case chạy được ngay**: mỗi case
có ID, bước thực hiện, kết quả mong đợi truy được về đúng partition/rule/transition, và độ ưu tiên kế thừa từ
Test Plan mục 6.

---

## 0 · Bắt buộc dừng lại chờ người review (human-in-the-loop)

Test case được thực thi trực tiếp — kết quả mong đợi sai hoặc case dựa trên hiểu nhầm sẽ dẫn tới đánh giá sai
pass/fail thật khi test thủ công. Ở các điểm dưới đây **không được tự đoán rồi viết tiếp** — phải dừng, trình bày
rõ vướng mắc, và chờ user xác nhận:

- Test plan chính nó **còn gap ở mục 10 chưa có câu trả lời**, và gap đó ảnh hưởng trực tiếp tới **kỹ thuật thiết
  kế hoặc kết quả mong đợi** của nhóm case sắp viết → hỏi user muốn (a) chờ dev trả lời trước khi viết nhóm case
  đó, hay (b) viết tạm dạng ⚠️ (phụ thuộc gap) rồi review lại sau. **Không tự chọn (b) làm mặc định** — phải hỏi.
- Test basis **không đủ chi tiết** để điền giá trị cụ thể cho 1 case (số, chuỗi, tên state, ngưỡng) → nêu rõ
  thiếu gì và hỏi, không tự bịa số liệu để bảng "trông đầy đủ".
- Phát hiện Decision Table/State Transition trong test plan **mâu thuẫn hoặc thiếu rule** khi đối chiếu lại test
  basis → dừng, báo cho user (khả năng cần sửa test plan trước bằng skill test-plan). **Không tự sửa âm thầm**
  rồi viết case theo bảng đã tự sửa mà không nói lại.
- Trước khi báo file test case là "xong": nếu số case 🔭/⚠️ chiếm tỷ trọng lớn, hoặc có case mà chính người viết
  cũng không chắc kết quả mong đợi đúng → nói rõ với user, đừng báo "hoàn tất" như các case còn lại.

**Cách dừng:** đặt câu hỏi cụ thể (đang vướng nhóm case nào, vì sao, ảnh hưởng gì nếu đoán sai). Ưu tiên dùng
công cụ hỏi trực tiếp nếu có sẵn; nếu không, dừng bằng text trước khi viết tiếp nhóm case đang vướng — các nhóm
case khác không bị chặn vẫn có thể viết bình thường trong lúc chờ.

---

## 1 · Đầu vào bắt buộc — đọc hết trước khi viết

| Nguồn | Đọc để lấy gì |
|---|---|
| `requirements/test-plans/<feature>/test-plan-<slug>.md` | **Bắt buộc phải tồn tại.** Mục 2 (test object + mã nhóm), mục 5 (kỹ thuật thiết kế — nguồn trực tiếp để suy case), mục 6 (risk → priority), mục 10/11 (gap, coverage gap) |
| Tài liệu **test basis** gốc mà test plan trích dẫn | Giá trị cụ thể (chuỗi, số, tên màn hình thật) để viết bước thực hiện chính xác, không suy đoán |
| `requirements/istqb-foundation/ISTQB_CTFL_Syllabus_v4.0.1.md` | Cách tính coverage đúng cho từng kỹ thuật — xem bảng mục 1.1 |
| `requirements/test-plans/case-create/test-cases-dac-ta-v2.1.md` | **Mẫu chuẩn về hình thức** (bộ test case đầu tiên của dự án CACK — học cách trình bày; nội dung chỉ đúng cho XL01) — cách viết "Quy ước" đầu file, cách gộp nhiều case vào 1 trình tự chạy, cách đánh dấu 🔭/⚠️ |
| `requirements/test-plans/case-create/screenshots/README.md` | Mẫu quy ước đặt tên ảnh bằng chứng nếu feature cần chụp màn hình khi chạy case |

Nếu **chưa có test-plan-*.md** cho feature này → dừng lại, báo user chạy skill **test-plan** trước. Không tự suy
ra kỹ thuật thiết kế từ đầu — test-case luôn thiết kế **dựa trên** test plan đã duyệt, không thay thế nó.

### 1.1 Ánh xạ kỹ thuật ISTQB → cách viết case (bắt buộc theo, không tự sáng tác cách khác)

| Kỹ thuật (theo mục 5 test plan) | Cách suy ra case | Coverage 100% nghĩa là gì (theo syllabus) |
|---|---|---|
| **Equivalence Partitioning** (§4.2.1) | Mỗi partition (kể cả partition không hợp lệ) → ít nhất 1 case | Mọi partition đã có ≥1 case chạy qua (Each Choice coverage nếu nhiều biến) |
| **Boundary Value Analysis** (§4.2.2) | Case tại đúng giá trị biên; nếu test plan ghi rõ 3-value BVA thì thêm case ở 2 hàng xóm | Mọi giá trị biên (và hàng xóm nếu 3-value) đã có case |
| **Decision Table** (§4.2.3) | **Copy đúng từng cột/rule** đã có trong test plan thành 1 case — không tự thêm/bớt rule | Mọi cột khả thi trong bảng đã có case |
| **State Transition** (§4.2.4) | Case là 1 chuỗi sự kiện đi qua nhiều transition; ưu tiên phủ **valid transitions coverage** trước, mỗi case invalid transition chỉ chèn **đúng 1** transition không hợp lệ (tránh defect masking) | Mọi transition hợp lệ đã có case; nếu test plan yêu cầu all-transitions thì thêm case cho transition không hợp lệ |
| **Exploratory (session-based)** (§4.4.2) | **Không** viết pass/fail cố định — viết charter (mục tiêu quan sát) + cột "Kết quả mong đợi" ghi "Phải quan sát/ghi lại", trỏ về bảng ghi kết quả của test basis nếu có | Không áp dụng khái niệm coverage % — chỉ cần chạy đủ charter |
| **Error guessing / Checklist-based** (§4.4.1, §4.4.3) | Case bám sát 1 nguồn cụ thể (bug-log, checklist cũ) — **trích link nguồn** ngay trong case, không viết như case tự nghĩ ra | Không có công thức coverage — số lượng hợp lý theo kinh nghiệm |

---

## 2 · Đầu ra

**Đường dẫn:** `requirements/test-plans/<feature>/test-cases-<slug>.md` — **cùng `<slug>`** với file test plan
tương ứng, để 2 file luôn đi cặp và dễ tra ngược.

Nếu case cần bằng chứng ảnh khi chạy thật → tạo thêm `requirements/test-plans/<feature>/screenshots/README.md`
theo đúng mẫu ở `requirements/test-plans/case-create/screenshots/README.md` (thư mục con = mã nhóm case, tên file = ID case + hậu tố màn
hình/state).

---

## 3 · Cấu trúc file phải sinh

```markdown
# Test Case Specification — <Tên feature/đợt test>

> Thiết kế case theo [test-plan-<slug>.md](test-plan-<slug>.md) (ISTQB Foundation) — bám đúng kỹ thuật đã chọn
> ở mục 5 test plan.
> Test basis: <link test basis gốc>.

## Quy ước
- **Ưu tiên:** P1 (chặn phát hành) · P2 · P3 — theo đúng mục 6 test plan, không tự đổi.
- **🔭 Exploratory** — case chưa có đáp án đúng/sai định sẵn (test plan tự khai ở mục 5/10). Cột "Kết quả mong
  đợi" ghi "**Phải quan sát/ghi lại**", không phải PASS/FAIL.
- **⚠️ Phụ thuộc gap mở** — case có thể đổi kết quả mong đợi sau khi dev trả lời gap tương ứng (mục 10 test
  plan). Chạy và ghi nhận thực tế, không tự suy đoán câu trả lời.
- Ảnh bằng chứng (nếu áp dụng): lưu vào `screenshots/<mã nhóm>/`, xem quy ước trong `screenshots/README.md`.
- Môi trường mặc định mọi case (build, nhánh, thiết bị) — nêu 1 lần ở đây, không lặp lại trong từng case.

---

## <N> · <Tên nhóm> · `TC-<MÃ>` (mục <X> test plan)

> (Nếu nhóm case có thể gộp thành 1 trình tự chạy liên tục để đỡ tốn thời gian setup — vd đổi lần lượt qua các
> giá trị của cùng 1 tổ hợp Decision Table — viết phần "Trình tự chạy gộp" trước bảng, liệt kê case nào gộp
> được/không gộp được, theo cách trình bày ở mục "Quy ước" của `requirements/test-plans/case-create/test-cases-dac-ta-v2.1.md`.)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|

(Thêm cột **Precondition** nếu các case trong nhóm không dùng chung 1 tiền điều kiện.)
```

Mỗi nhóm (`## <N> · ...`) ứng với đúng 1 hạng mục ở mục 2 test plan, dùng đúng mã nhóm đã cấp ở đó làm tiền tố
ID (`TC-<MÃ>-NN`, số 2 chữ số, không tái sử dụng số đã cấp).

---

## 4 · Quy tắc nội dung — quan trọng nhất

**Case phải truy được về đúng 1 dòng trong mục 5 test plan** (1 partition, 1 hàng Decision Table, 1 transition,
1 charter). Không viết case "cho chắc" nằm ngoài kỹ thuật đã chọn — nếu thấy thiếu, đó là việc phải quay lại bổ
sung ở **test plan**, không tự vá bằng cách nhồi thêm case ở đây.

**Copy nguyên Decision Table, không diễn giải lại.** Nếu test plan có bảng Decision Table N cột, test case phải
có đúng N case tương ứng — sai lệch số lượng là dấu hiệu đọc nhầm test plan.

**State Transition — không gộp 2 transition không hợp lệ vào 1 case.** Theo đúng syllabus §4.2.4: trộn nhiều
lỗi trong 1 case có thể che lấp lẫn nhau (defect masking), làm sai kết quả chẩn đoán.

**Kết quả mong đợi phải cụ thể, đo được.** "Hiển thị đúng" là không đủ — ghi rõ giá trị/trạng thái/vị trí cụ thể
lấy từ test basis. Nếu test basis không nói rõ → đánh ⚠️, không tự đoán số liệu.

**Không tự nâng/hạ priority so với test plan.** Priority của case = priority của hạng mục nó thuộc về ở mục 6
test plan, trừ khi case đó tự thân có rủi ro khác hẳn phần còn lại của nhóm (khi đó ghi rõ lý do lệch).

**Gộp case để tiết kiệm thời gian chạy được, nhưng bảng case đầy đủ vẫn phải giữ nguyên** — trình tự chạy gộp
chỉ là hướng dẫn thực thi, không thay thế việc mỗi case có ID/expected result riêng để trích dẫn khi báo bug.

**Case suy luận thêm ngoài test plan (error guessing của chính người viết test case) phải đánh dấu 🆕 và ghi rõ
lý do**, không trộn lẫn với case bám test basis như thể đã có nguồn.

---

## 5 · Sau khi sinh xong

1. Báo user: đường dẫn file · tổng số case theo từng nhóm · số case P1 · số case 🔭 (exploratory) · số case ⚠️
   (phụ thuộc gap).
2. **Liệt kê rõ mọi câu hỏi còn treo** từ mục 0 (nhóm case nào bị chặn/viết tạm chờ dev trả lời) — không gộp
   chung vào câu "đã xong", phải tách riêng thành mục cần user xác nhận trước khi đưa file cho người thực thi.
3. Đối chiếu ngược với mục 5 test plan: nếu có kỹ thuật/hạng mục nào **chưa có case tương ứng** → báo rõ, không
   im lặng bỏ qua.
4. Nếu cần bằng chứng ảnh khi chạy case → nhắc user đã tạo `screenshots/README.md` theo mẫu, chưa chụp ảnh thật
   (đó là việc của người thực thi, không phải của skill này).
5. **Không** tự sửa lại test plan trong lượt chạy này — phát hiện gì cần sửa test plan thì báo user, để chạy lại
   skill test-plan riêng.
