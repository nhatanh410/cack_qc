# Test Cases — Join & Nhận link chia sẻ (F4)

> **Test basis:** [test plan tổng](../../requirements/test-plans/ink-identity-sync-flow/ink-identity-sync-flow-test-plan.md) mục 1.2,
> 10.2, 13.1, 13.5 · [ink-identity-sync-flow.html](../../requirements/specs/ink-identity-sync-flow/ink-share-last-update/ink-identity-sync-flow.html) §2 ·
> [qc-sharing-account-pro.md](../../requirements/test-plans/ink-identity-sync-flow/qc-sharing-account-pro.md) §2, §6.
> **Phạm vi:** phía người nhận (máy B) — từ backend Join tới toàn bộ UI thật (dán link, màn preview). Suite
> JN1 chứa **rủi ro cao nhất trong toàn bộ bộ test case này** — xem [00-README.md](00-README.md).
> **Ngày lập:** 2026-09-20 · **Người lập:** QC

## Môi trường & thiết bị cần

| Cần | Bắt buộc | Dùng cho |
|---|---|---|
| **2 thiết bị** (máy A = sender đã có share, máy B = receiver/joiner) | ✅ | Toàn bộ file — Suite JN1/JN2/JN4 đều cần 1 share thật do máy A tạo sẵn (dùng fixture từ [02-share-creation.md](02-share-creation.md)) |
| Máy B **đồng thời sở hữu ≥1 lịch riêng** của chính nó | ✅ | TC-F4-08 — case P1 cao nhất, cần lịch riêng để thử chọn nhầm `Ink · <tên>` khi share |
| App **Lịch của Apple** (Calendar.app) trên máy B, có cấp quyền EventKit | ✅ | TC-F4-05, TC-F4-19 — verify `Ink · <tên>` không lộ và lịch join có xuất hiện đúng trong app Lịch |
| Ink AI đã bật/khả dụng trên máy B | ✅ | TC-F4-06 |
| Trình duyệt mobile Safari trên máy B | ✅ | TC-F4-16-19 — mở link https trực tiếp |
| Khả năng giả lập mất mạng (Airplane Mode) trên máy B | ✅ | TC-F4-14 |
| Clipboard có sẵn nội dung để test paste | Nên có | TC-F4-10 |
| iPad | Không cần | Không có case layout riêng cho iPad trong file này |
| iOS 26 (Liquid Glass) | Không cần | — |

---

## Suite JN1 — ⚠️ Lịch join bị lộ sai chỗ (rủi ro cao nhất)

**Cơ chế:** khi máy B join 1 link, Ink tạo một **lịch EventKit thật** tên `Ink · <tên lịch>` để đẩy sự kiện
sang app Lịch của Apple. Ở tầng OS, đây là **một lịch bình thường** — không có cách nào phân biệt nó với lịch
tự tạo của chính người dùng. Nếu nó lọt vào danh sách chọn lịch để **chia sẻ** (TC-F4-08), người dùng có thể
**đăng lại lịch của người khác dưới tên mình**.

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F4-05 | §2 (bàn giao QC) | Máy B đã join ít nhất 1 link | Tạo sự kiện mới → mở dòng chọn lịch | **Không** có `Ink · …` trong danh sách chọn | P1 |
| TC-F4-06 | §2 | Máy B đã join ít nhất 1 link | Mở Ink AI → chỗ chọn lịch đích | **Không** có `Ink · …` | P1 |
| TC-F4-07 | §2 | Máy B đã join ít nhất 1 link | Calendars → danh sách bật/tắt hiện lịch | Lịch chia sẻ xuất hiện **đúng 1 lần** (dạng lịch được chia sẻ) — không có thêm dòng `Ink · …` song song | P1 |
| TC-F4-08 | §2 (dev tự đánh giá **nghiêm trọng nhất** toàn PR) | Máy B đã join ít nhất 1 link, đồng thời cũng sở hữu lịch riêng | Mở Chia sẻ lịch → danh sách lịch để chọn chia sẻ | **Không** có `Ink · …` — không thể chọn lịch của người khác để tự publish lại dưới tên mình | **P1 — ưu tiên cao nhất trong toàn bộ bộ test case này** |
| TC-F4-09 | §2 (regression) | Máy **chưa join link nào** | Kiểm tra cả 4 danh sách trên | Đầy đủ như cũ — không bị lọc mất lịch hợp lệ nào của chính người dùng | P2 |
| TC-F4-20 | §6.2 (regression, nối JN1) | Vừa join qua đường paste-link (Suite JN3) — khác đường mở trực tiếp link web | Chạy lại 4 case TC-F4-05/06/07/08 | Kết quả phải giống hệt dù join qua đường nào — cả 2 entry point (paste-link và mở trực tiếp) đều phải an toàn như nhau | P1 |

## Suite JN2 — Join qua trang preview (backend, §2)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F4-01 | §2 | Đang ở trang preview, chưa có uid | Bấm Join | App (không phải trình duyệt) thực hiện Join bằng uid của chính app — trang web chỉ render preview + đưa deep link `ink://share?url=...`, không có Firebase Auth trên web | P2 |
| TC-F4-02 | §2 | Join thành công | Đọc `share_members` vừa tạo | Label đúng format `"<tên lịch> · <ngày>"`; **không** chứa tên thiết bị dưới bất kỳ hình thức nào | P1 |
| TC-F4-03 | §2 | 2 uid khác nhau cùng join 1 share | Join lần lượt | Mỗi uid có 1 row `share_members` độc lập, label riêng, không ảnh hưởng lẫn nhau | P2 |
| TC-F4-04 | §2 | Cùng 1 uid | Bấm Join 2 lần liên tiếp (double-tap) | Không tạo 2 row `share_members` trùng cho cùng `(share_id, uid)` — verify qua khoá chính composite | P2 |

## Suite JN3 — Dán link, "Add a shared calendar" (UI §6.1)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F4-10 | §6.1 | — | Mở "Add a shared calendar" | Ô dán link có nút paste **bên trong ô**, mờ khi clipboard rỗng | P3 |
| TC-F4-11 | §6.1 | — | Dán link hợp lệ | Hiện thẻ tóm tắt (tên, "42 events · khoảng ngày") | P2 |
| TC-F4-12 | §6.1 | — | Dán URL không phải Ink (vd `https://example.com/…`) | Báo lỗi **ngay**, không gọi mạng | P2 |
| TC-F4-13 | §6.1 | Link Ink hợp lệ nhưng đã chết | Dán link | Câu lỗi hiện dưới ô, ô **vẫn sửa được** (không văng màn lỗi riêng) | P2 |
| TC-F4-14 | §6.1 | Mất mạng | Dán link | Báo lỗi tương ứng, thử lại được | P2 |
| TC-F4-15 | §6.1 | Đang hiện lỗi từ link cũ | Sửa lại link | Lỗi cũ **biến mất ngay** khi gõ | P3 |

## Suite JN4 — Màn xem trước rồi Join (UI §6.2)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F4-16 | §6.2 | Mở link https trực tiếp hoặc bấm Continue | — | Thẻ tóm tắt đầu màn + ngay dưới là ghi chú "tên/mô tả là lời người gửi… lịch cũng xuất hiện trong app Lịch của Apple" | P3 |
| TC-F4-17 | §6.2 | — | — | Đáy màn chỉ còn nút "Join calendar" — đoạn chữ dài trước đây đã chuyển lên trên | P3 |
| TC-F4-18 | §6.2 | Link của người gửi ẩn danh (không tên/mô tả) | — | Các dòng tên/mô tả **biến mất hẳn**, không để trống | P2 |
| TC-F4-19 | §6.2 | — | Bấm Join calendar | Lịch hiện trong Calendars **và** trong app Lịch của Apple — cross-ref Suite JN1 | P2 |

---

**Tổng: 20 case** (JN1: 6 · JN2: 4 · JN3: 6 · JN4: 4).
