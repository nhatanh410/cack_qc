# Test Cases — Tạo & Quản lý Share (F3)

> **Test basis:** [test plan tổng](../../requirements/test-plans/ink-identity-sync-flow-test-plan.md) mục 1.2,
> 10.2, 12.3, 13.2–13.4, 13.7 · [ink-identity-sync-flow.html](../../requirements/specs/Ink%20Login%20and%20sharing%20calendar%20docs/ink-share-last-update/ink-identity-sync-flow.html) §2 ·
> [qc-sharing-account-pro.md](../../requirements/test-plans/qc-sharing-account-pro.md) §3–§5.
> **Phạm vi:** owner tạo/quản lý share — từ backend (batch atomic 3 bảng, token bắt buộc) tới toàn bộ UI thật
> đã lên `main` (tên bắt buộc, Time range, màn Calendars, Manage sharing). Xem [00-README.md](00-README.md)
> cho quy ước ID/priority.
> **Ngày lập:** 2026-09-20 · **Người lập:** QC

## Môi trường & thiết bị cần

| Cần | Bắt buộc | Dùng cho |
|---|---|---|
| **2 thiết bị** (máy A = sender, máy B = receiver) | ✅ | TC-F3-19, TC-F3-42, TC-F3-43, TC-F3-44 — cần B thật để verify link/quyền chết/sống đúng phía nhận, không chỉ tin UI máy A |
| 1 iPhone (đủ cho phần còn lại) | ✅ | Suite SH2–SH6, phần không cross-device |
| iPad (dọc + ngang) | Nên có | Manage sharing (SH7) và màn Calendars (SH6) giới hạn bề ngang — cần đối chiếu layout |
| Tài khoản **Google** thật | ✅ | TC-F3-09 (tên tự điền) |
| Tài khoản **Apple** thật | ✅ | TC-F3-10 (ô trống, tự focus) |
| **Lịch mẫu lớn**: ≥600 event, ≥1 event lặp hằng ngày, ≥1 event xa hơn 12 tháng | ✅ | TC-F3-20 (Time range tăng dần), TC-F3-22/24 (giới hạn dung lượng, đã bỏ cap 500) |
| Máy **chưa đăng nhập** riêng (hoặc sign-out được) | ✅ | TC-F3-32/33, TC-F3-45 |
| Khả năng gọi API trực tiếp (Postman/curl) | Chỉ cho TC-F3-45 | Gọi thẳng `POST /api/ink/share` bằng token ẩn danh, bỏ qua UI |
| iOS 26 (Liquid Glass) | Không cần | Sheet Share/Manage sharing trong file này không phải trọng tâm hiệu ứng kính |

---

## Suite SH1 — Tạo share (backend, §2)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F3-01 | §2 | Có lịch sở hữu, có uid hợp lệ | Chọn lịch → bấm Share | Không hỏi thêm bước nào khác (không có màn hình chọn toggle); `POST /api/ink/share` được gọi kèm `Bearer <uid token>` | P2 |
| TC-F3-02 | §2 | Không có token / token rỗng | Gọi `POST /api/ink/share` | 401, share KHÔNG được tạo — verify D1: không có row mới ở cả 3 bảng | P1 |
| TC-F3-03 | §2 | Token hợp lệ | Tạo share, sau đó đọc trực tiếp D1 | Cả 3 bảng (`calendars`, `shares`, `calendar_events`) được ghi trong cùng 1 batch — không tồn tại trạng thái chỉ có 1–2 bảng có dữ liệu | P1 |
| TC-F3-04 | §2 | Share đã tồn tại, có event với địa điểm/ghi chú | Mở `inkcalendar.app/s/<id>` không đăng nhập, **inspect network response thô** | Response chỉ chứa tên, mô tả, SỐ LƯỢNG event — không có field nội dung event nào (title/location/notes từng event) | P1 |
| TC-F3-05 | §2 | Share đã tạo, đầy đủ field (location, notes) | Receiver join + sync đầy đủ | Receiver nhận đủ location/notes/liên kết — xác nhận đúng lời hứa "chia sẻ ĐẦY ĐỦ" | P2 |
| TC-F3-07 | §2, `.note` | Vừa tạo share xong (ngay lập tức, không thao tác sync thủ công) | Kiểm tra trang preview + `calendar_events` trên D1 ngay sau khi tạo | Preview đã hiện đúng số lượng event thật; `calendar_events` **không rỗng** — owner đã tự seed & push mà không cần hành động thêm | P1 |
| TC-F3-08 | Q6 (answers-from-dev.md) — tech debt xác nhận, chưa fix | Có lịch sở hữu, chưa share | Bấm Share 2 lần liên tiếp (double-tap thật hoặc 2 request riêng biệt) | Tạo ra **2 link độc lập**, mỗi link trỏ vào 1 hàng `calendars` riêng (server mint mới mỗi lần, không tái sử dụng) — xác nhận đúng hành vi hiện tại, không phải case "phải chặn" | P3 |

## Suite SH2 — Tên người gửi bắt buộc (UI §3.1)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F3-09 | §3.1 | Đăng nhập Google | Mở sheet Share | Ô "Your name" tự điền tên tài khoản, **không** bật bàn phím | P2 |
| TC-F3-10 | §3.1 | Đăng nhập Apple (không tên) hoặc chưa đăng nhập | Mở sheet Share | Ô trống, **tự động focus** (bàn phím bật) | P2 |
| TC-F3-11 | §3.1 | Ô tên trống | Quan sát nút Create link | Nút **mờ/không bấm được** | P1 |
| TC-F3-12 | §3.1 | — | Gõ tên | Nút Create link sáng lên | P2 |
| TC-F3-13 | §3.1 (BVA — dễ sai nếu code chỉ check `.isEmpty`) | — | Nhập toàn dấu cách vào ô tên | Nút **vẫn mờ** — không được coi chuỗi toàn space là hợp lệ | P2 |
| TC-F3-14 | §3.1 | Đã share 1 lần với tên X | Share lịch khác | Tên X được nhớ lại; **mô tả lịch thì không** (mỗi lịch 1 mô tả riêng) | P3 |

## Suite SH3 — Time range (UI §3.2, khái niệm mới)

> ⚠️ Cơ chế backend của "Time range" chưa được xác nhận đầy đủ — xem Open Q20 trong
> [open-questions-for-dev.md](../../requirements/test-plans/ink-identity-sync-flow-open-questions-for-dev.md).
> TC-F3-19 dưới đây là case quan trọng nhất để verify hành vi thật khi chưa có câu trả lời.

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F3-15 | §3.2 | Mở sheet Share | — | Time range mặc định **"All upcoming"** | P2 |
| TC-F3-16 | §3.2 | — | Mở picker Time range | Đủ 4 lựa chọn: Next 3/6/12 months, All upcoming | P3 |
| TC-F3-17 | §3.2 | — | Đổi lựa chọn Time range | Dòng tóm tắt đổi theo dạng "128 events · 18 thg 9 – 18 thg 3" | P2 |
| TC-F3-18 | §3.2 | Chọn "All upcoming" | — | Phần sau dấu `·` hiện chữ **"All upcoming"**, không hiện khoảng ngày cụ thể | P3 |
| TC-F3-19 | §3.2 (⚠️ xem Open Q20) | Đã bấm Create link | Đổi lại Time range | Link cũ **biến mất**, phải tạo lại — verify link cũ thật sự chết ở máy B (không chỉ ẩn trên UI máy A), cross-ref [05-revoke.md](05-revoke.md) TC-F7-01 | P1 |
| TC-F3-20 | §3.2 | — | Thử lần lượt 3/6/12 tháng/All upcoming trên cùng 1 lịch | Số sự kiện **tăng dần** đúng thứ tự | P2 |

## Suite SH4 — Tạo link, giới hạn dung lượng (UI §3.3)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F3-21 | §3.3 | Lần chia sẻ đầu tiên trên máy (chưa từng share) | Bấm Create link | Hiện popup xin xác nhận trước khi tải lên | P2 |
| TC-F3-22 | §3.3 | Lịch quá lớn so với giới hạn dung lượng | Tạo link | Dòng cảnh báo "Only the first N events fit in the link", kèm **icon dấu chấm than** (không phải tick) | P3 |
| TC-F3-23 | §3.3 | Link vừa tạo xong | — | Dòng ghi chú nằm giữa sheet, không đè lên nút CTA | P3 |
| TC-F3-24 | §3.3 (đã bỏ cap 500 event — regression) | Lịch có 600+ event | Share toàn bộ | Đi trọn theo giới hạn dung lượng mới (512 KB — xem [04-sync-permission.md](04-sync-permission.md) Suite SY3), **không** còn bị cắt cứng ở mốc 500 | P2 |

## Suite SH5 — Không còn toggle chi tiết (UI §3.4, verify khớp backend)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F3-25 | §3.4 | Mở sheet Share | — | **Không còn** dòng bật/tắt "Include location, notes and links" | P3 |
| TC-F3-26 | §3.4 | — | Đọc câu disclosure | Nói rõ chia sẻ **gồm cả** location, notes, links | P3 |

## Suite SH6 — Màn Calendars (UI §4)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F3-27 | §4 | — | Mở Calendars | Màn **full screen** (không phải sheet), ✕ ở góc trái | P3 |
| TC-F3-28 | §4 | — | — | Header có 2 nút tròn bên phải: chia sẻ (mũi tên lên) và + | P3 |
| TC-F3-29 | §4 | — | Bấm + | Popup "New calendar" có 2 nhóm tách rời: mẫu lịch, và "Add a shared calendar" bên dưới | P3 |
| TC-F3-30 | §4 | — | Xem thẻ sharing trong thân màn | Chỉ còn "Manage sharing" — 2 dòng "Share a calendar"/"Add a shared calendar" đã chuyển lên header/popup, **không xuất hiện trùng lặp** ở cả 2 nơi | P2 |
| TC-F3-31 | §4 | Có lịch đã join | — | Lịch đã join nằm **phía trên** dòng Manage sharing | P3 |
| TC-F3-32 | §4 | **Chưa đăng nhập** | Bấm nút chia sẻ trên header | Ra màn **mời đăng nhập**, không phải mở sheet chia sẻ trực tiếp — đây là gate ở tầng UI/product, không phải giới hạn backend (xem TC-F3-45, Suite SH9) | **P1** |
| TC-F3-33 | §4 (đã biết, không report nếu khác) | Chưa đăng nhập | Join 1 link | Join thành công **không cần đăng nhập** — đây là chủ ý sản phẩm | P3 |

## Suite SH7 — Manage sharing (UI §5, chạm F6/F7/F9)

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F3-34 | §5 | — | Vào Manage sharing | Full screen, ✕ góc trái | P3 |
| TC-F3-35 | §5 | Có ≥1 share | — | Nút "Share a calendar" **ghim đáy màn**; nội dung cuộn xuống dưới nút và mờ dần, không bị cắt cụt | P2 |
| TC-F3-36 | §5 | — | Bấm nút ghim đáy → tạo link → đóng sheet | Thẻ mới xuất hiện **ngay** trong danh sách, không cần thao tác refresh | P2 |
| TC-F3-37 | §5 | Chưa chia sẻ gì | Mở Manage sharing | Màn trống chỉ 1 dòng chữ, **không** có CTA riêng ở giữa (tránh mời cùng 1 hành động 2 lần) | P3 |
| TC-F3-38 | §5 | Có ≥1 share active | Xem thẻ | Dòng "Shared" hiện "42 events · 8 thg 9 – 1 thg 3" — **không còn** hiện URL, **không còn** hiện ngày tạo link | P2 |
| TC-F3-39 | §5 | — | Xem nút copy | Ghi **"Copy link"** (trước là "Copy"), nằm cạnh nhãn Access | P3 |
| TC-F3-40 | §5 | — | Bấm copy | Đổi thành "Copied" ~1 giây rồi trở lại; copy thẻ khác không làm thẻ này đổi theo | P3 |
| TC-F3-41 | §5 | — | Dán link đã copy ra ngoài app | Dán được và mở được | P2 |
| TC-F3-42 | §5 (= verify F6 qua UI thật) | Có member đã join | Đổi Access giữa xem/sửa cho 1 người | Máy B nhận đúng quyền tương ứng — cross-ref [04-sync-permission.md](04-sync-permission.md) TC-F6-01/02 | **P1** |
| TC-F3-43 | §5 (= verify F7 qua UI thật) | Có share active | Bấm Stop sharing, xác nhận | Link chết ở máy B — cross-ref [05-revoke.md](05-revoke.md) TC-F7-01 | **P1** |
| TC-F3-44 | §5 (= verify F8/F9 qua UI thật) | Có share active với event thật | Xoá app, cài lại, mở Manage sharing | Danh sách link **vẫn còn** nhưng dữ liệu sự kiện **thì không** — dòng "Shared" **quay về hiện ngày tạo link** thay vì "N events · khoảng ngày". Đây là hành vi ĐÚNG, không phải bug — triệu chứng UI-quan-sát-được của `calendar_events` cache local rỗng sau cài lại tới khi sync lần đầu chạy lại | P2 |

## Suite SH8 — Đối chiếu UI gate với backend

| ID | Nguồn | Precondition | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-F3-45 | Đối chiếu TC-F3-32 (UI gate) với [01-identity-login.md](01-identity-login.md) TC-F2-09 (backend permissive) | Có uid ẩn danh hợp lệ (chưa link Apple/Google) | Gọi thẳng `POST /api/ink/share` bằng token ẩn danh, không qua UI | Xác nhận: tạo share thành công (đúng thiết kế linh hoạt của backend) — nếu bị chặn, đây là điểm KHÔNG khớp với TC-F2-09 đã verify trước đó, cần báo lại | P2 |

---

**Tổng: 44 case** (SH1: 7 · SH2: 6 · SH3: 6 · SH4: 4 · SH5: 2 · SH6: 7 · SH7: 11 · SH8: 1).
