# Trả lời câu hỏi làm rõ — Wallpaper Customize TF-117

> **Nguồn trả lời:** QC (người dùng repo) trả lời trực tiếp ngày 2026-09-29 qua hộp thoại chọn đáp án —
> **chưa có xác nhận từ dev**. Coi là *câu trả lời của QC*, không phải fact từ spec; nếu dev trả lời
> khác thì dev thắng.
> **Liên quan:** [test-analysis-tf-117.md](test-analysis-tf-117.md) mục 4A (Câu hỏi CHẶN). Mã Q-x
> trùng với file đó.

## Đã trả lời

| Q | Câu hỏi (rút gọn) | Trả lời | Ghi chú |
|---|---|---|---|
| **Q-1** [CHẶN] | §4.02 "vùng nội dung" là biên nào — giữ hành vi 1.2.18 (mép ảnh) hay thắt lại? | **A — giữ nguyên hành vi 1.2.18**: chặn ở **mép ảnh**, band đầu vẫn được kéo qua vạch trên grid | "Vùng nội dung" trong TF-117 là cách viết lại/chép chưa cập nhật câu chữ, **không phải** thắt lại giới hạn |
| **Q-2** [CHẶN] | Cụm snap dọc + chip gap âm + rung + Duplicate band gap âm — còn hay bỏ? | **A — vẫn giữ nguyên**, kế thừa từ 1.2.18 | TF-117 không nhắc lại vì cụm này không có gì đổi, **không phải** đã bỏ |
| **Q-3** [CHẶN] | Gap giữa 2 band cao-thấp khi đổi chỗ: giữ gap hay giữ đỉnh slot? | **A — giữ gap giữa các band** | Tiếp tục giả định QC đã chấp nhận ở Q-10 bộ 1.2.18 — **dev vẫn chưa xác nhận** ở cả 2 đợt liên tiếp |
| **Q-4** [CHẶN] | Sheet Add có nhóm Text hay không (§6 vs §7.29 mâu thuẫn)? | **A — không có nhóm Text** | §6 của TF-117 là đoạn chép lại lỗi thời; giữ đúng **16 mục / 5 nhóm** đã chốt bằng ảnh thật ở 1.2.18 |
| **Q-5** [CHẶN] | Vertical position: Fixed có control thật hay chỉ ở Quote (§7.03 vs §7.35)? | **A — chỉ ở Quote** | Band Fixed **không có** Vertical position hoạt động; §7.03 là câu mô tả chung chưa cập nhật theo danh sách đã rà soát ở §7.35 |
| **Q-6** [CHẶN] | Đổi ảnh nền / kéo Darken trong Layers có sinh bước Undo không? | **C — không sinh Undo** | Giống cơ chế **Sample events / Grid**: đổi tức thời, không vào lịch sử Undo, không ép đổi chế độ Layout/Decorate |
| **Q-7** [CHẶN] | Phạm vi Decorate: test lại toàn bộ nội dung bên trong hay chỉ phần mới của đợt gộp? | **B — test lại toàn bộ** nội dung bên trong Decorate (vẽ tay, sticker, emoji, opacity, Cutout...) trong ngữ cảnh màn Customize | Mở rộng phạm vi thêm **~20 condition** (nhóm M/N + TC117-107). Đường vào Cutout cụ thể **vẫn chưa rõ** — xem Q-7b bên dưới |

## Còn mở — chưa trả lời, chờ dev (không chặn, nhưng nên hỏi sớm)

| Q | Loại | Câu hỏi | Ghi chú |
|---|---|---|---|
| **Q-7b** | Phụ của Q-7 | **Cutout vào bằng đường nào?** Rail Decorate mới trong TF-117 chỉ liệt kê **Draw · Text · Emoji · Photo · Show calendar · Grid** — không có nút Cutout riêng — nhưng tài liệu vẫn dùng Cutout làm điều kiện hỏi Pro ở §8.1 | Có thể Cutout nằm trong menu con của **Photo**; cần dev xác nhận trước khi viết case cho đúng luồng Pro-gate của Cutout. QC đã chọn "test lại toàn bộ Decorate" (Q-7) nên câu này **phải** trả lời trước khi test-case chạm tới Cutout, dù không chặn toàn bộ test-plan |

## ASSUMPTION — giả định làm việc do QC chấp nhận (2026-09-29)

> **Không phải fact, không phải xác nhận của dev.** Mọi test condition/case dựa trên các giả định này
> phải gắn ⚠️ (gap-dependent). Nếu dev trả lời khác, chỉ các condition gắn ⚠️ tương ứng phải sửa. Khi
> dev xác nhận thì đổi nhãn từ ASSUMPTION sang FACT.

| Q | Giả định (expected làm việc) | Điều kiện thay đổi |
|---|---|---|
| Q-1 | Biên kéo dọc = **mép ảnh** (không đổi so với 1.2.18); band đầu vẫn được vượt vạch trên grid | Dev nói TF-117 cố ý thắt lại về đúng "vùng nội dung" |
| Q-2 | Cụm snap dọc + chip gap âm + rung + Duplicate band gap âm **vẫn còn nguyên** như 1.2.18 | Dev nói cụm này đã bị bỏ ở bản gộp |
| Q-3 | **Giữ nguyên gap giữa các band** khi đổi chỗ (kế thừa giả định Q-10 bộ 1.2.18) | Dev nói giữ toạ độ đỉnh của từng slot |
| Q-4 | Sheet Add **không có** nhóm Text — giữ đúng 16 mục / 5 nhóm đã chốt ở 1.2.18 | Dev nói nhóm Text quay lại, cần thêm danh mục cụ thể loại nào |
| Q-5 | Band Fixed **không có** Vertical position hoạt động; control này chỉ có ở Quote | Dev nói Fixed vẫn có Vertical position thật |
| Q-6 | Đổi ảnh nền / kéo Darken **không** sinh bước Undo | Dev nói có sinh Undo — cần hỏi thêm nó chuyển màn sang chế độ nào |
| Q-7 | Phạm vi TF-117 **bao gồm** test lại toàn bộ nội dung Decorate trong ngữ cảnh màn gộp | Đây là lựa chọn rõ ràng của QC (không phải giả định chờ đổi), nhưng đường vào cụ thể của Cutout vẫn mở — xem Q-7b |

## Đợt trả lời thứ 2 (2026-09-29, sau khi qc-test-analysis phát sinh Q-8/Q-9 từ chính đợt 1)

> Cùng nguồn/điều kiện như đợt 1 ở trên: QC trả lời qua hộp thoại chọn đáp án, **chưa có xác nhận dev**.

| Q | Câu hỏi (rút gọn) | Trả lời | Ghi chú |
|---|---|---|---|
| **Q-8** [CHẶN, phát sinh từ TB-30] | Ở chế độ **Decorate**, band lịch có tương tác được không (chạm/kéo/resize/nhấn giữ)? Vẽ bút đè qua band thì sao? | **A — band KHÔNG tương tác được** ở Decorate; mọi chạm thuộc về công cụ vẽ/sticker. Vẽ đè qua band ra nét bình thường, không bị "giành" cử chỉ | Nhất quán với thiết kế tách 2 chế độ riêng — mở khoá TC117-168, **đóng** cụm GAP G6 (không cần thêm condition gesture-arbitration band↔Decorate) |
| **Q-9** [CHẶN, phát sinh từ TB-31] | Phiên chỉ đổi ảnh nền/Darken rồi bấm ✕: có hỏi "Discard changes?" không? | **Descope — loại nhánh này khỏi phạm vi thực thi đợt TF-117** | Không viết/chạy case riêng cho trường hợp "chỉ đổi nền/Darken rồi ✕"; vẫn giữ nguyên test case ✕/Discard bình thường cho các phiên có đổi Layout/Decorate kèm theo (không descope toàn bộ §8.04). Giữ nhãn `GAP` cho riêng nhánh hẹp này, ghi rõ lý do descope là "chưa có acceptance criteria vì nền/Darken ra khỏi lịch sử Undo" — nếu dev xác nhận sau này, mở lại thành condition bình thường |

## Không còn chặn Test Plan (READY có điều kiện) — nhưng còn chờ xác nhận

Q-1 → Q-6, Q-8 đã có giả định làm việc do QC chấp nhận ngày 2026-09-29, **dev chưa xác nhận**. Q-7 đã
chọn hướng rõ ràng (mở rộng phạm vi test lại toàn bộ Decorate), nhưng câu hỏi phụ **Q-7b** (đường vào
Cutout) vẫn mở — không chặn toàn bộ test-plan nhưng cần trả lời trước khi test-case chạm tới nhóm
Cutout/Pro-gate. **Q-9 đã descope** (nhánh hẹp "chỉ đổi nền/Darken rồi ✕" ra khỏi phạm vi thực thi, giữ
`GAP` cho riêng nhánh đó). Việc chuyển trạng thái test-analysis vẫn do `qc-test-analysis` đánh giá và báo
lại; chưa ai tự nâng `BLOCKED → READY` ở đây.

## Wrap-up 2026-10-02 — tính năng đã release

QC xác nhận: tính năng (màn Customize, TF-117) **đã release**. QC tự thực hiện **manual verification**
trên build thật (không theo đúng 171 test condition đã thiết kế ở test-analysis, vì `test-cases-tf-117.md`
chưa được hoàn tất — xem lý do ở banner WRAP-UP của `test-analysis-tf-117.md`/`test-plan-tf-117.md`).
**Kết quả QC tự báo cáo: đạt toàn bộ, không phát hiện bug nào.**

Đây là **quyết định/kết quả do QC tự báo cáo**, không phải kết luận từ việc chạy case có traceability cụ
thể. Toàn bộ câu trả lời Q-1…Q-9 ở trên **vẫn giữ nguyên nhãn ASSUMPTION/Descope như đã ghi** — việc
release **không** tự động biến chúng thành FACT hay thành "đã dev xác nhận".
