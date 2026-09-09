# Phase 2 — Feedback & Priority

> Ghi nhận từ team sau khi hoàn thành **Phase 1**. Nguồn: feedback thô do team tổng hợp, ngày 2026-09-07.
> `Flow` tham chiếu theo [`.claude/rules/screenshot-naming.md`](../../.claude/rules/screenshot-naming.md) §7 khi xác định được; để trống nếu feedback không map rõ vào 1 flow cụ thể.
> Mục đích: input cho việc lên scope/backlog Phase 2, **chưa phải PRD** — cần làm rõ thêm trước khi đưa vào spec chi tiết.

**Priority:** `P1` (cao nhất) → `P6`, thứ tự đúng theo team đã chốt.
**Status:** `Raw` (feedback thô, chưa breakdown) · `Needs clarification` (thiếu thông tin để scope) · `Ready` (đủ rõ để lên task).

---

## Tổng hợp priority

| Priority | Chủ đề | Loại | Status |
|---|---|---|---|
| P1 | Improve UI/UX, fix bug | Bug + UX | Raw |
| P2 | Bổ sung component template, sửa template portal | Feature + Bug | Raw |
| P3 | Share lịch, tạo lịch, GSS | Feature | Needs clarification |
| P4 | Tích hợp AI assistant vào calendar/event; Improve home hiển thị theo category | Feature | Raw |
| P5 | Editor đa dạng hơn / tuỳ biến | Feature | Raw |
| P6 | Build community (co-edit); Lịch âm - tâm linh | Feature | Raw |

---

## P1 · Improve UI/UX, fix bug

Các vấn đề tồn đọng từ Phase 1, ảnh hưởng trực tiếp đến trải nghiệm hiện tại.

| ID | Vấn đề | Flow liên quan | Ghi chú |
|---|---|---|---|
| FB-101 | Chưa tối ưu hiển thị **list template** | `04_discover` | Chưa rõ tối ưu theo hướng nào (tốc độ load / bố cục / filter) — cần hỏi lại người báo |
| FB-102 | **Note vs Widget** không rõ ràng — user khó phân biệt 2 loại item trong collection/list | `04_discover` | Liên quan đến việc note-type item đang khác biệt CTA so với widget/lockscreen item |
| FB-103 | **Live activity** chưa đa dạng | `04_discover` (screen `live-activity`) | Cần làm rõ: thiếu template, hay thiếu tuỳ chọn cấu hình |
| FB-104 | Flow **edit note** chưa tối ưu | `07_note` | Có thể liên quan bug đã ghi nhận ở [`bugs/bug-log.md`](../../bugs/bug-log.md) — BUG-001 (nút ✓ không lưu note), BUG-002 (`(Untitled)` label) |
| FB-105 | Setup **không tự động** — nhiều bước thủ công, không tự sync | `03_shortcut-setup` | Xem thêm P2 (FB-201) — case liên quan trực tiếp đến việc tự sync wallpaper |

---

## P2 · Bổ sung component template, sửa template portal

| ID | Vấn đề / Đề xuất | Flow liên quan | Ghi chú |
|---|---|---|---|
| FB-201 | User đổi wallpaper của máy (ngoài app Ink) → **calendar phải tự động update lên wallpaper mới** thay vì giữ wallpaper cũ | `03_shortcut-setup`, `10_lockscreen` | Case kỹ thuật — phụ thuộc giới hạn của Shortcuts/Automation API trên iOS, cần audit khả thi trước khi commit |
| FB-202 | Bổ sung **component template** mới, sửa **template portal** | `04_discover` (screen `template`) | Ghép với đề xuất template mới bên dưới (thể dục, sport event, concert…) |

### Idea template mới (gom từ mục "Idea tính năng mới")

- Template **thể dục / sport event / concert...**
- **Lịch âm — cung hoàng đạo — tâm linh** (idea này cũng map vào P6, xem ghi chú ở đó)

---

## P3 · Share lịch, tạo lịch, GSS

| ID | Vấn đề / Đề xuất | Flow liên quan | Ghi chú |
|---|---|---|---|
| FB-301 | **Share lịch** — co-edit hoặc lịch cố định (view-only) | `05_calendar` (flow mới, chưa có screen) | Idea gốc: "Share lịch (co-edit / lịch cố định)" |
| FB-302 | **Tạo lịch** | `05_calendar` | Chưa rõ khác gì so với tạo event hiện tại — cần làm rõ scope (tạo lịch riêng/lịch nhóm?) |
| FB-303 | **GSS** | ❓ | **Cần làm rõ** — viết tắt không rõ nghĩa trong feedback gốc, không tự suy đoán. Cần hỏi lại team trước khi đưa vào spec |

> ⚠️ Priority P3 có mục **GSS** chưa rõ nghĩa — đã đánh dấu `Needs clarification`, không tự bổ sung nội dung theo đúng nguyên tắc AI Requirements của rule naming (§8.8, áp dụng tinh thần tương tự cho feedback không rõ).

---

## P4 · AI assistant vào calendar/event; Improve home theo category

| ID | Vấn đề / Đề xuất | Flow liên quan | Ghi chú |
|---|---|---|---|
| FB-401 | Tích hợp **AI assistant** vào calendar và event — tham khảo **Trace**: trợ lý AI dạng chat, nhập tự nhiên → tự lên schedule | `05_calendar` | Idea gốc: "Tham khảo Trace: trợ lý AI, nhập dạng chat > tự lên schedule" |
| FB-402 | Improve **home** — hiển thị theo **category** | `04_discover` | Idea gốc: "Chia category" — gom vào cùng mục vì cùng hướng tổ chức lại home theo category |

---

## P5 · Editor đa dạng hơn / tuỳ biến

| ID | Vấn đề / Đề xuất | Flow liên quan | Ghi chú |
|---|---|---|---|
| FB-501 | Customize wallpaper: **thêm sticker, emoji, vẽ lên lock screen** | `04_discover` (screen `template`/`lock-screen`) | |
| FB-502 | **Guide từng bước** dễ hiểu hơn | `03_shortcut-setup` | Có overlap với FB-105 (P1) — cả hai đều nói về việc setup phức tạp; FB-502 tập trung vào chất lượng hướng dẫn, FB-105 tập trung vào việc tự động hoá |
| FB-503 | **Matrix**: cho edit title, cho user biết có thể add content vào template dạng matrix | `04_discover` (screen `template`) | Chưa rõ "Matrix" là tên loại template cụ thể hay khái niệm chung — cần hỏi lại |

---

## P6 · Build community (co-edit); Lịch âm - tâm linh

| ID | Vấn đề / Đề xuất | Flow liên quan | Ghi chú |
|---|---|---|---|
| FB-601 | **Build community** — calendar riêng của Ink | Flow mới, chưa có | Overlap với FB-301 (share lịch/co-edit ở P3) — co-edit có thể là nền tảng kỹ thuật dùng chung cho cả 2, nhưng ưu tiên implement khác nhau (P3 trước, P6 sau) |
| FB-602 | **Lịch âm — cung hoàng đạo — tâm linh** | `05_calendar` hoặc template mới (`04_discover`) | Trùng với idea template ở P2 (FB-202) — nội dung lịch âm/tâm linh có thể triển khai dưới dạng template (P2, ưu tiên sớm) hoặc dưới dạng tính năng lịch đầy đủ (P6, ưu tiên sau); cần team quyết định hướng nào trước khi breakdown |

---

## Việc cần làm tiếp theo

- [ ] Làm rõ **FB-303 (GSS)** — hỏi lại người viết feedback gốc.
- [ ] Quyết định hướng triển khai **Lịch âm - tâm linh**: template (P2) hay flow riêng (P6) — tránh làm 2 lần.
- [ ] Audit khả thi kỹ thuật cho **FB-201** (auto-sync wallpaper khi user đổi wallpaper hệ thống) trước khi commit vào sprint.
- [ ] Breakdown P1 thành task cụ thể, đối chiếu với bug đang mở trong [`bugs/bug-log.md`](../../bugs/bug-log.md).
- [ ] Sau khi scope rõ hơn, convert từng mục `Ready` sang wireframe/PRD riêng trong [`requirements/ui/ux/wideframes/`](../ui/ux/wideframes/).
