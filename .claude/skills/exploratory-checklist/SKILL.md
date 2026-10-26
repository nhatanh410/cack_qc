---
name: exploratory-checklist
description: Sinh exploratory checklist cho một flow của hệ thống Quản lý vụ việc CACK Nội Bài (app mobile + web quản trị) từ wireframe đã có. Dùng khi user nói "tạo checklist exploratory cho <flow>", "gen checklist cho login/case-create/record-signing/...", "làm checklist kiểm thử cho flow X", hoặc muốn cập nhật lại checklist sau khi wireframe thay đổi. Đọc wireframe + references, xuất file vào requirements/exploratory/.
---

# Sinh Exploratory Checklist — Hệ thống Quản lý vụ việc CACK Nội Bài

Chuyển wireframe của một flow thành **checklist kiểm thử khám phá** dùng được ngay trong phiên: mỗi mục là
một việc **quan sát được**, có ID để trích dẫn khi báo bug.

---

## 0 · Cơ sở ISTQB — skill này thực chất gộp 3 kỹ thuật experience-based, không phải 1

Theo [ISTQB CTFL v4.0.1 §4.4](../../../requirements/istqb-foundation/ISTQB_CTFL_Syllabus_v4.0.1.md), "kiểm thử
kinh nghiệm" (experience-based) gồm **3 kỹ thuật khác nhau**, không phải một khối "exploratory" duy nhất như tên
skill gợi ý. Phân biệt rõ chỗ này để không viết lẫn lộn:

| Kỹ thuật ISTQB | Trong skill này tương ứng phần nào | Đặc điểm bắt buộc theo syllabus |
|---|---|---|
| **Checklist-based testing** (§4.4.3) | §1 Happy path, phần lớn §2 Negative, §3 Coverage matrix | Case cố định, có đáp án đúng/sai rõ, suy ra thẳng từ wireframe/screenshot — **không** phải chỗ để đoán |
| **Error guessing** (§4.4.1) | §2 Negative, §3 Edge | Case suy luận từ *kinh nghiệm lỗi thường gặp*, không có bằng chứng trực tiếp trong wireframe — dùng khung 6 loại lỗi ở §2.1 dưới đây để sinh có hệ thống, không đoán tùy hứng |
| **Exploratory testing / session-based** (§4.4.2) | §6 Smoke → là 1 **test charter** thời gian cố định, §7 Kết luận phiên → là **debriefing** sau session | Tự thiết kế-thực thi-đánh giá **đồng thời** trong lúc chạy — không có đáp án viết sẵn, chỉ có mục tiêu quan sát |

Việc gọi tên đúng kỹ thuật khi viết từng mục giúp người đọc biết mục nào có đáp án cố định (Checklist-based —
sai là bug), mục nào là suy đoán có căn cứ (Error guessing — sai thì log, đúng thì thôi), và mục nào thực sự
chưa biết trước (Exploratory — chỉ ghi nhận, không kỳ vọng sẵn).

**Khi nào dùng skill này thay vì [test-plan](../test-plan/SKILL.md) + [test-case](../test-case/SKILL.md):**
dùng exploratory-checklist khi flow **chỉ có wireframe/screenshot**, chưa có tài liệu spec chính thức (test
basis) để làm black-box techniques (Equivalence Partitioning, BVA, Decision Table...) — đúng tinh thần
**shift left** (§2.1.5): kiểm sớm ngay khi có thiết kế, trước khi có spec đầy đủ. Khi flow đã có spec/bàn giao
chính thức → cân nhắc bổ sung test-plan + test-case (black-box, có entry/exit criteria) thay vì chỉ dựa vào
checklist kinh nghiệm này. Về mặt Testing Quadrants (§5.1.7), checklist này rơi vào **Quadrant Q3** (business
facing, critique the product) — thủ công, hướng người dùng, không thay thế được test tự động ở Q1/Q4.

---

## 1 · Đầu vào bắt buộc — đọc hết trước khi viết

| Nguồn | Đọc để lấy gì |
|---|---|
| `requirements/ui/ux/wideframes/<NN>_<flow>.md` | Danh sách màn hình, state đã có ảnh, vấn đề đã nhận diện, *Possible missing screen* |
| `requirements/ui/ux/screenshots/<mobile\|web>/index.md` | Đối chiếu số ảnh và state thực có |
| `requirements/specs/<feature>/...` (nếu có, vd `xu-ly-vi-pham-giao-viec/mo-ta-chuc-nang-v1.md`) | Vai trò được dùng flow, trường bắt buộc/không bắt buộc, kết quả mong đợi đã ghi trong spec |
| `references/exploratory-references.md` | ⚠️ **Chưa có cho dự án CACK.** Khung 9 câu hỏi mindset QC (Q1–Q9) + mẫu kết luận phiên lấy tạm từ §0 và §7 của `requirements/exploratory/03_case-create.md` (đã chuyển thể từ dự án cũ); phần "rủi ro xuyên suốt sản phẩm" (§1) của Ink **không áp dụng** — ghi vào §0 là chưa có, không tự bịa |
| Ma trận vai trò ↔ quyền (`.claude/rules/screenshot-naming.md` §7 cột Vai trò) | Vai trò nào được dùng flow này; ô ❓ = chưa xác nhận → đưa vào mục câu hỏi |
| `requirements/exploratory/03_case-create.md` | **Mẫu chuẩn về hình thức** (checklist đầu tiên của dự án CACK) — độ sâu và cách trình bày happy/negative/edge; nội dung chỉ đúng cho flow 03 |
| `bugs/bug-log.md` (nếu có) | Bug thật đã xảy ra ở flow này — nguồn ưu tiên cho Error guessing (§4.4.1), theo đúng cách app từng hỏng trong quá khứ |
| `requirements/istqb-foundation/ISTQB_CTFL_Syllabus_v4.0.1.md` §4.4 | Định nghĩa 3 kỹ thuật experience-based — xem bảng mục 0 ở trên |

Nếu flow chưa có wireframe → **dừng lại**, báo user, không tự bịa. Đây tương đương entry criteria chưa đạt
(ISTQB §5.1.3: testware chưa sẵn sàng) — không viết checklist "tạm" dựa trên phỏng đoán UI.

---

## 2 · Đầu ra

**Đường dẫn:** `requirements/exploratory/<NN>_<flow>.md` — trùng số và tên với wireframe.
Ví dụ: `01_login.md`, `03_case-create.md`.

**Tiền tố ID** theo flow, dùng trong mọi mục để trích dẫn khi báo bug:

| Flow | Tiền tố | | Flow | Tiền tố |
|---|---|---|---|---|
| 01 login | `LGN` | | 06 task-assign | `TSK` |
| 02 home | `HOM` | | 07 case-actions | `ACT` |
| 03 case-create | `CRE` | | 08 daily-report | `RPT` |
| 04 case-handling | `HDL` | | 09 web-admin | `WEB` |
| 05 record-signing | `REC` | | | |

Đánh số: `CRE-H01` (happy) · `CRE-N01` (negative) · `CRE-E01` (edge) · `CRE-Q01` (câu hỏi cần PO/dev trả lời).
**Số đã cấp thì không tái sử dụng** — thêm mục mới lấy số tiếp theo, kể cả khi mục cũ bị bỏ.

---

## 3 · Cấu trúc file phải sinh

```markdown
# Exploratory Checklist — <NN> <Tên flow>

> Nguồn: [wireframe](../ui/ux/wideframes/<NN>_<flow>.md) · <N> screenshot
> Khung đánh giá: [exploratory-references](../../references/exploratory-references.md)
> Kỹ thuật (ISTQB §4.4): Checklist-based (§1, phần lớn §2) · Error guessing (§2, §3) · Exploratory
> session-based (§6, §7)
> Build: <phiên bản> — <môi trường> · Tài khoản test: <vai trò>

## 0 · Framing
Q1 mục tiêu user của riêng flow này (1 câu).
Q8 flow này phục vụ mục tiêu business nào.
Rủi ro xuyên suốt nào của sản phẩm chạm vào flow này (link sang §1 của references).

## 1 · Happy path — <tiền tố>-H  *(Checklist-based testing, §4.4.3)*
Bảng: ID · Việc làm · Phải quan sát được · Đo gì · ☐
Đi đúng thứ tự user thao tác, bám screen-no trong wireframe. Mỗi mục = 1 test condition có sẵn đáp án đúng/sai
từ bằng chứng — không phải chỗ để suy đoán.

## 2 · Negative — <tiền tố>-N  *(Checklist-based cho vấn đề đã biết + Error guessing cho phần suy luận)*
Bảng: ID · Tình huống · Kỳ vọng · Rủi ro nếu sai · Mức · ☐
Nhóm theo: từ chối/nhập sai · bỏ dở giữa chừng · thao tác lặp/nhanh · gián đoạn (kill app, offline) · sai vai trò
(cán bộ thử thao tác chỉ dành cho người giao việc và ngược lại). Với phần
suy luận (không có bằng chứng trực tiếp trong wireframe) → sinh có hệ thống bằng khung 6 loại lỗi ở §2.1 dưới
đây, không đoán tùy hứng.

## 3 · Edge — <tiền tố>-E  *(Error guessing, §4.4.1)*
Bảng: ID · Tình huống · Câu hỏi · Mức · ☐
Bắt buộc phủ: dữ liệu rỗng · dữ liệu cực lớn · chữ dài/emoji/tiếng Việt có dấu ·
cỡ chữ hệ thống lớn · Dark Mode · máy màn hình nhỏ · trình đọc màn hình · offline/mạng yếu · vòng đời app ·
hai người cùng thao tác trên một vụ việc · thời hạn ở quá khứ/đúng biên.
Đây chính là loại lỗi **input** và **data** trong khung 6 loại ở §2.1 — nếu wireframe có gợi ý ranh giới số cụ
thể (vd giới hạn ký tự, số item tối đa) và đã có bằng chứng, có thể viết thêm case kiểu Boundary Value Analysis
(§4.2.2 — giá trị biên + 1 giá trị ngay sát) thay vì chỉ đoán "cực lớn" chung chung.

## 3.1 · Khung 6 loại lỗi (Error Guessing, ISTQB §4.4.1) — dùng để sinh §2/§3 có hệ thống
Với mỗi màn hình, rà qua 6 loại: **input** (đầu vào đúng bị từ chối, tham số sai/thiếu) · **output** (sai định
dạng, sai kết quả) · **logic** (thiếu case, rẽ nhánh sai) · **computation** (tính sai, sai toán tử) ·
**interfaces** (lệch tham số giữa 2 màn hình/API) · **data** (khởi tạo sai, sai kiểu dữ liệu). Không cần liệt
kê đủ 6 loại thành mục riêng trong file xuất ra — dùng làm checklist nội bộ khi soạn §2/§3 để không bỏ sót loại
lỗi nào.

## 4 · Coverage matrix
Bảng state × đã chạm, lấy từ mục *Possible missing screen* của wireframe.

## 5 · Câu hỏi cần PO/dev trả lời — <tiền tố>-Q
Những thứ **không kiểm được bằng cách bấm app**: chủ ý thiết kế, số liệu analytics, cách implement.

## 6 · Smoke 15 phút cho flow này  *(Exploratory testing / session-based, §4.4.2 — đây là 1 test charter)*
3–6 mục quan trọng nhất, có chia thời lượng. Viết như charter: nêu **mục tiêu quan sát** của phiên, không phải
danh sách thao tác có đáp án đúng/sai sẵn — người chạy vừa thiết kế vừa thực thi vừa đánh giá trong lúc làm.

## 7 · Kết luận phiên  *(Debriefing của session, §4.4.2)*
Mẫu điền Q1–Q9 + verdict 🟢/🟡/🔴, copy từ §5 của exploratory-references. Đây là bước debrief bắt buộc sau mỗi
session — ghi lại phát hiện mới, không chỉ tô màu verdict.
```

---

## 4 · Quy tắc nội dung — quan trọng nhất

**Chỉ viết từ bằng chứng.** Mọi mục phải truy được về một màn hình/quan sát trong wireframe hoặc screenshot.
Không có bằng chứng → đưa vào §5 dưới dạng câu hỏi, **không** viết thành mục checklist như thể đã biết.

**Mỗi mục phải quan sát được.** Viết "đếm số bước từ Tạo vụ việc tới khi vụ việc hiện ở tab Tiếp nhận", không
viết "đánh giá xem tạo vụ việc có tốt không". Ai đọc cũng làm được và cho ra cùng kết luận.

**Nêu rõ cách đo.** Thời gian → bấm giờ. Tương phản → đo giá trị màu. Quyền → đăng nhập tài khoản vai trò khác để kiểm
chứng. Thông báo → kiểm trên máy người nhận. Lưu trữ → đối chiếu trang quản trị, không chỉ tin UI app.

**Kéo vấn đề đã biết vào.** Mục *Vấn đề đã nhận diện* trong wireframe phải thành mục checklist có ID, đánh
🔴, kèm link về wireframe. Không để người test tự phát hiện lại.

**Đừng lặp lại rủi ro xuyên suốt.** Những thứ đã nằm ở §1 của `exploratory-references` (nếu dự án đã có
file references riêng) chỉ **link tới**, trừ khi flow này có biểu hiện riêng.

**Phân biệt 3 loại.** Bug = sai hành vi, có repro. Ma sát = đúng nhưng khó/chậm/rối. Coverage gap = chưa kiểm
được — ghi rõ lý do, tuyệt đối không suy diễn kết quả.

**Mức độ:** 🔴 chặn mục tiêu chính / mất dữ liệu / lộ dữ liệu cá nhân / sai quyền · 🟠 mất một phần chức năng · 🟡 ma sát.

**Không bịa màn hình.** Bước nào wireframe ghi *chưa có ảnh* thì checklist ghi **coverage gap**, không viết
như thể đã biết nó trông ra sao.

**Số lượng hợp lý.** Flow nhỏ (1–2 màn) khoảng 15–25 mục. Flow lớn (8+ màn) khoảng 40–60. Nhiều mục vụn vặt
làm checklist không ai chạy hết.

**Không đưa vào checklist những gì không phải test condition thật (ISTQB §4.4.3).** Ba loại cần loại bỏ:
- Việc **kiểm tự động được** (vd so khớp version string, snapshot test UI) — để dành cho automation, không tốn
  slot của người test thủ công.
- Việc thực chất là **entry criteria**, không phải case (vd "app đã cài đặt xong", "đã đăng nhập" — đây là điều
  kiện tiên quyết để bắt đầu, viết vào phần chuẩn bị/tiền điều kiện, không đánh số ID riêng).
- Mục **quá chung chung** không tách được thành 1 quan sát cụ thể (vd "kiểm tra UX ổn" — đã bị chặn bởi nguyên
  tắc "mỗi mục phải quan sát được" ở trên, nhắc lại ở đây vì đây đúng là lý do ISTQB đưa ra, không phải quy ước
  riêng của dự án).

**Checklist "mòn" theo thời gian (Testing Principle #5 — Tests wear out).** Một mục chạy đúng nhiều lần liên
tiếp mà không còn tìm ra lỗi mới có thể đã hết tác dụng vì dev đã học cách tránh lỗi đó. Khi cập nhật checklist
sau khi có bug mới trong `bugs/bug-log.md` liên quan flow này → thêm mục Error guessing mới tương ứng bug đó
(không chỉ dựa mãi vào bộ mục cũ). Không tự ý xoá mục cũ chỉ vì "chưa từng thấy fail" — chỉ đề xuất xem lại với
user, vì im lặng lâu cũng có thể do chưa ai chạy đúng cách.

---

## 5 · Sau khi sinh xong

1. Báo user: đường dẫn file · số mục theo từng loại (Happy/Negative/Edge/Q) · những mục 🔴 · những gì không viết
   được vì thiếu bằng chứng.
2. Nếu wireframe có *Possible missing screen* → nhắc user chụp bổ sung, nêu rõ mục nào đang bị chặn vì thiếu ảnh.
3. Nếu số câu hỏi ở §5 (`<tiền tố>-Q`) nhiều hoặc có câu **ảnh hưởng cách hiểu cả flow** (vd chưa rõ job-to-be-
   done, chưa rõ vai trò nào được dùng chức năng) → nêu rõ với user đây là điểm cần review trước khi coi checklist đã dùng
   được đầy đủ, không chỉ liệt kê lẫn vào danh sách chung.
4. **Không** tự cập nhật wireframe hay index — skill này chỉ sinh checklist.
