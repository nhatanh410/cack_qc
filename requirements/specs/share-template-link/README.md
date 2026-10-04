# Share Template as a Link — chờ spec từ dev

> Status: **chờ spec**. Folder này đang trống chủ ý — chuẩn bị sẵn để nhận spec thật từ dev, chưa
> có nội dung nào được suy diễn hoặc bịa ra.

## Bối cảnh đã xác nhận với user (2026-10-02)

- **Feature slug:** `share-template-link` — dùng xuyên suốt `requirements/specs/share-template-link/`,
  `requirements/test-plans/share-template-link/`, và `test-cases/share-template-link/` (nếu cần tách
  riêng) khi pipeline chạy tới các bước đó.
- **Không liên quan đến flow `11_share`** (share lịch / co-edit, Phase 2, chưa build — xem
  [`.claude/rules/screenshot-naming.md`](../../../.claude/rules/screenshot-naming.md) §7 và
  [`phase-2-feedback.md`](../phase-2-feedback/phase-2-feedback.md) P3). Đây là tính năng **share một
  wallpaper/template đã tạo ra ngoài qua link** — không phải share lịch co-edit — nên **không** đối
  chiếu chéo với `login-and-calendar-sharing/` hay `ink-identity-sync-flow/`.
- Chưa xác định tính năng này thuộc bundle shape nào trong 3 shape ở README.md gốc (chuẩn
  screenshot→wireframe, remote-config/content-layer, hay architecture-first) — sẽ quyết sau khi đọc
  spec thật từ dev. Không tự đoán trước.

## Việc cần làm khi có spec

1. Dev/PM thả file spec (PRD, dev note, v.v.) thẳng vào folder này — đặt tên file theo quy ước hiện có
   trong repo (vd. `<tên-tài-liệu>-v<version>.md`), không cần đổi tên feature/slug.
2. Chạy `/spec-intake` để pipeline ISTQB (test-analysis → test-plan → test-case) tự điều phối qua 3
   subagent `qc-test-analysis` / `qc-test-plan` / `qc-test-case`, tôn trọng các điểm dừng
   human-in-the-loop theo [`.claude/rules/testing.md`](../../../.claude/rules/testing.md).
3. Nếu spec có kèm screenshot thật → đặt vào
   `requirements/ui/ux/screenshots/<device>/` theo đúng
   [`.claude/rules/screenshot-naming.md`](../../../.claude/rules/screenshot-naming.md) (cần mint
   `flow-no` mới nếu đây là flow hoàn toàn mới, không chèn/đánh số lại flow cũ).
