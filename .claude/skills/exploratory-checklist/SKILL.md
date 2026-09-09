---
name: exploratory-checklist
description: Sinh exploratory checklist cho một flow của app Ink từ wireframe đã có. Dùng khi user nói "tạo checklist exploratory cho <flow>", "gen checklist cho onboarding/permission/calendar/...", "làm checklist kiểm thử cho flow X", hoặc muốn cập nhật lại checklist sau khi wireframe thay đổi. Đọc wireframe + references, xuất file vào requirements/exploratory/.
---

# Sinh Exploratory Checklist — Ink Calendar iOS

Chuyển wireframe của một flow thành **checklist kiểm thử khám phá** dùng được ngay trong phiên: mỗi mục là
một việc **quan sát được**, có ID để trích dẫn khi báo bug.

---

## 1 · Đầu vào bắt buộc — đọc hết trước khi viết

| Nguồn | Đọc để lấy gì |
|---|---|
| `requirements/ui/ux/wideframes/<NN>_<flow>.md` | Danh sách màn hình, state đã có ảnh, vấn đề đã nhận diện, *Possible missing screen* |
| `requirements/ui/ux/screenshots/iphone/index.md` | Đối chiếu số ảnh và state thực có |
| `references/exploratory-references.md` | Khung 9 câu hỏi mindset QC, rủi ro xuyên suốt, ngưỡng verdict |
| `references/permissions-matrix.md` | Quyền nào ảnh hưởng flow này |
| `references/shortcut-flow-cases.md` | **Mẫu chuẩn** về độ sâu và cách trình bày happy/negative/edge |

Nếu flow chưa có wireframe → **dừng lại**, báo user, không tự bịa.

---

## 2 · Đầu ra

**Đường dẫn:** `requirements/exploratory/<NN>_<flow>.md` — trùng số và tên với wireframe.
Ví dụ: `01_onboarding.md`, `05_calendar.md`.

**Tiền tố ID** theo flow, dùng trong mọi mục để trích dẫn khi báo bug:

| Flow | Tiền tố | | Flow | Tiền tố |
|---|---|---|---|---|
| 01 onboarding | `ONB` | | 06 task | `TSK` |
| 02 permission | `PRM` | | 07 note | `NOT` |
| 03 shortcut-setup | `SCT` | | 08 paywall | `PAY` |
| 04 discover | `DSC` | | 09 settings | `SET` |
| 05 calendar | `CAL` | | 10 lockscreen | `LCK` |

Đánh số: `ONB-H01` (happy) · `ONB-N01` (negative) · `ONB-E01` (edge) · `ONB-Q01` (câu hỏi cần PO/dev trả lời).
**Số đã cấp thì không tái sử dụng** — thêm mục mới lấy số tiếp theo, kể cả khi mục cũ bị bỏ.

---

## 3 · Cấu trúc file phải sinh

```markdown
# Exploratory Checklist — <NN> <Tên flow>

> Nguồn: [wireframe](../ui/ux/wideframes/<NN>_<flow>.md) · <N> screenshot
> Khung đánh giá: [exploratory-references](../../references/exploratory-references.md)
> Build: TestFlight 1.2.10 (27)

## 0 · Framing
Q1 mục tiêu user của riêng flow này (1 câu).
Q8 flow này phục vụ mục tiêu business nào.
Rủi ro xuyên suốt nào của sản phẩm chạm vào flow này (link sang §1 của references).

## 1 · Happy path — <tiền tố>-H
Bảng: ID · Việc làm · Phải quan sát được · Đo gì · ☐
Đi đúng thứ tự user thao tác, bám screen-no trong wireframe.

## 2 · Negative — <tiền tố>-N
Bảng: ID · Tình huống · Kỳ vọng · Rủi ro nếu sai · Mức · ☐
Nhóm theo: từ chối/nhập sai · bỏ dở giữa chừng · thao tác lặp/nhanh · gián đoạn (kill app, offline).

## 3 · Edge — <tiền tố>-E
Bảng: ID · Tình huống · Câu hỏi · Mức · ☐
Bắt buộc phủ: dữ liệu rỗng · dữ liệu cực lớn · chữ dài/emoji/tiếng Việt có dấu ·
Dynamic Type lớn · Dark Mode · máy màn hình nhỏ · VoiceOver · offline · vòng đời app.

## 4 · Coverage matrix
Bảng state × đã chạm, lấy từ mục *Possible missing screen* của wireframe.

## 5 · Câu hỏi cần PO/dev trả lời — <tiền tố>-Q
Những thứ **không kiểm được bằng cách bấm app**: chủ ý thiết kế, số liệu analytics, cách implement.

## 6 · Smoke 15 phút cho flow này
3–6 mục quan trọng nhất, có chia thời lượng.

## 7 · Kết luận phiên
Mẫu điền Q1–Q9 + verdict 🟢/🟡/🔴, copy từ §5 của exploratory-references.
```

---

## 4 · Quy tắc nội dung — quan trọng nhất

**Chỉ viết từ bằng chứng.** Mọi mục phải truy được về một màn hình/quan sát trong wireframe hoặc screenshot.
Không có bằng chứng → đưa vào §5 dưới dạng câu hỏi, **không** viết thành mục checklist như thể đã biết.

**Mỗi mục phải quan sát được.** Viết "đếm số bước từ slide 1 tới khi vào app", không viết "đánh giá xem
onboarding có tốt không". Ai đọc cũng làm được và cho ra cùng kết luận.

**Nêu rõ cách đo.** Thời gian → bấm giờ. Tương phản → đo giá trị màu. Giá → đọc từ sheet StoreKit, không đọc
từ UI app. Đồng bộ → mở Apple Calendar kiểm chứng.

**Kéo vấn đề đã biết vào.** Mục *Vấn đề đã nhận diện* trong wireframe phải thành mục checklist có ID, đánh
🔴, kèm link về wireframe. Không để người test tự phát hiện lại.

**Đừng lặp lại rủi ro xuyên suốt.** Những thứ đã nằm ở §1 của `exploratory-references` (chuỗi setup, lock
screen tĩnh, đồng bộ 2 chiều…) chỉ **link tới**, trừ khi flow này có biểu hiện riêng.

**Phân biệt 3 loại.** Bug = sai hành vi, có repro. Ma sát = đúng nhưng khó/chậm/rối. Coverage gap = chưa kiểm
được — ghi rõ lý do, tuyệt đối không suy diễn kết quả.

**Mức độ:** 🔴 chặn mục tiêu chính / mất tiền / mất dữ liệu · 🟠 mất một phần chức năng · 🟡 ma sát.

**Không bịa màn hình.** Bước nào wireframe ghi *chưa có ảnh* thì checklist ghi **coverage gap**, không viết
như thể đã biết nó trông ra sao.

**Số lượng hợp lý.** Flow nhỏ (1–2 màn) khoảng 15–25 mục. Flow lớn (8+ màn) khoảng 40–60. Nhiều mục vụn vặt
làm checklist không ai chạy hết.

---

## 5 · Sau khi sinh xong

1. Báo user: đường dẫn file · số mục theo từng loại · những mục 🔴 · những gì không viết được vì thiếu bằng chứng.
2. Nếu wireframe có *Possible missing screen* → nhắc user chụp bổ sung, nêu rõ mục nào đang bị chặn vì thiếu ảnh.
3. **Không** tự cập nhật wireframe hay index — skill này chỉ sinh checklist.
