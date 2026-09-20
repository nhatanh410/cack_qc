# Test Cases — Ink: Định danh, Chia sẻ, Đồng bộ, Sao lưu

Bộ test case ISTQB Foundation Level, tách theo flow từ 1 test plan chung để tiện review từng phần riêng.
Đây là bản **chốt hiện tại** (2026-09-20) — mọi case đã lỗi thời/bị thay thế trong quá trình phân tích đã
được **loại bỏ** ở đây (chỉ còn giữ làm lịch sử trong test plan gốc, mục 12/14).

## Test basis

1. [`ink-identity-sync-flow.html`](../../requirements/specs/Ink%20Login%20and%20sharing%20calendar%20docs/ink-share-last-update/ink-identity-sync-flow.html) — kiến trúc backend gốc (§0–§7).
2. [`qc-sharing-account-pro.md`](../../requirements/test-plans/qc-sharing-account-pro.md) — bàn giao QC cho UI/UX thật đã lên `main` (PR #260 `380bc6b2` + PR #274 `ef996605`).
3. [`login-backup-share-sync.md`](../../requirements/specs/login-backup-share-sync.md) — tài liệu tham chiếu hệ thống, verified against `main` 2026-09-20. **Nguồn thẩm quyền cao nhất khi có xung đột.**

Test plan đầy đủ (phân tích cơ chế, decision table, risk-based priority, câu hỏi mở, lịch sử các lần cập
nhật): [`ink-identity-sync-flow-test-plan.md`](../../requirements/test-plans/ink-identity-sync-flow-test-plan.md).

Câu hỏi còn mở gửi dev: [`ink-identity-sync-flow-open-questions-for-dev.md`](../../requirements/test-plans/ink-identity-sync-flow-open-questions-for-dev.md)
· câu trả lời đã nhận: [`ink-identity-sync-flow-answers-from-dev.md`](../../requirements/test-plans/ink-identity-sync-flow-answers-from-dev.md).

## Danh sách file

| File | Flow | Số case | Ghi chú |
|---|---|---|---|
| [01-identity-login.md](01-identity-login.md) | F1, F2 | 21 | Đăng nhập ngầm (uid/Keychain/link) + UI màn Account |
| [02-share-creation.md](02-share-creation.md) | F3 | 44 | Tạo share: tên bắt buộc, Time range, tạo link, màn Calendars/Manage sharing |
| [03-join-receive.md](03-join-receive.md) | F4 | 20 | Join qua preview, dán link, **chống lộ lịch `Ink · <tên>` vào sai chỗ (rủi ro cao nhất)** |
| [04-sync-permission.md](04-sync-permission.md) | F5, F6 | 20 | Push/pull, LWW, ma trận quyền, giới hạn BVA, terminal-failure |
| [05-revoke.md](05-revoke.md) | F7 | 6 | Thu hồi member, hành vi khi share bị Stop (đã viết lại 2026-09-20) |
| [06-error-codes.md](06-error-codes.md) | F10 | 9 | 4 mã lỗi, thứ tự kiểm, App Check vs Firebase Auth |
| [07-backup-restore.md](07-backup-restore.md) | F8, F9, F14 | 16 | Sao lưu theo loại nguồn, khôi phục, Backup sync mới ship |
| [08-data-model.md](08-data-model.md) | F11 | 3 | Mô hình dữ liệu, rủi ro rò `calendar_events` dùng chung |
| [09-account-member-unlock-delete.md](09-account-member-unlock-delete.md) | F12, F13, F15, F16, F17 | 13 | Xoá tài khoản, quản lý member qua route thật, unlock mật khẩu, 2 loại xoá calendar |
| [10-rate-limit.md](10-rate-limit.md) | cross-cutting | 3 | Ngưỡng rate limit theo endpoint |

**Tổng: 155 test case.**

## Quy ước

- **ID:** giữ nguyên `TC-Fxx-nn` từ test plan gốc để truy vết ngược — không đánh số lại. Số thứ tự có thể có
  khoảng trống (vd thiếu `TC-F3-06`) vì 1 số ID đã bị loại bỏ khi case đó lỗi thời; **không lấp khoảng trống**
  để tránh làm rối liên kết chéo với test plan.
- **Cột "Nguồn":** trỏ về đúng mục (§) của tài liệu kiến trúc gốc, hoặc mục UI (`§N.M`) của bàn giao QC PR
  #260/#274, hoặc `login-backup-share-sync.md §N` cho phần mới nhất.
- **Priority:**
  - **P1** — chặn release: mất dữ liệu, lộ riêng tư, quyền bị nới vĩnh viễn, đăng lại lịch của người khác.
  - **P2** — sai hành vi có workaround, hoặc case xác nhận hành vi đã biết (regression).
  - **P3** — cosmetic, tech debt đã biết (không phải case "phải chặn"), hoặc case cần thêm thông tin từ dev
    trước khi assert chi tiết hơn.
- **Trạng thái nguồn** (ghi trong cột Nguồn khi cần):
  - Không đánh dấu = xác nhận trực tiếp từ tài liệu/code, có thể chạy ngay.
  - ⚠️ = còn phụ thuộc câu hỏi mở gửi dev (xem file open-questions), chưa assert được kết quả cụ thể.
  - ✅ = vừa được xác nhận/đóng bởi `login-backup-share-sync.md` (2026-09-20), khác với hiểu biết trước đó.

## Case đã loại bỏ khỏi bộ này (lỗi thời, giữ làm lịch sử trong test plan)

| ID cũ | Lý do loại bỏ | Thay bằng |
|---|---|---|
| `TC-F8-03` (bản gốc: ".ink mất vĩnh viễn") | Đảo ngược hoàn toàn — Backup sync đã ship 2026-09-20 | `TC-F8-03` (viết lại), `TC-F8-03b`, `TC-F8-03c` — xem [07-backup-restore.md](07-backup-restore.md) |
| `TC-F9-05` (DELETE /share/:id xoá luôn `calendars`) | Hành vi đã đổi, xác nhận ship | `TC-F17-01` — xem [09-account-member-unlock-delete.md](09-account-member-unlock-delete.md) |
| `TC-F7-05` (bản 2026-09-18: 404 bị nuốt im lặng) | Có thể đã fix theo bảng terminal-failure mới | `TC-F7-05` (viết lại), `TC-F7-06` — xem [05-revoke.md](05-revoke.md) |

## Rủi ro ưu tiên đọc trước (P1 nổi bật nhất, không theo thứ tự file)

1. **TC-F4-08** ([03-join-receive.md](03-join-receive.md)) — lịch `Ink · <tên>` lộ vào danh sách chọn để chia
   sẻ, có thể đăng lại lịch của người khác dưới tên mình. Dev tự đánh giá là rủi ro cao nhất toàn PR #260/#274.
2. **TC-F11-03** ([08-data-model.md](08-data-model.md)) — rủi ro rò dữ liệu riêng tư `.ink` qua bảng
   `calendar_events` dùng chung, nay **sống thật** vì Backup sync đã ship.
3. **TC-F14-03/04** ([07-backup-restore.md](07-backup-restore.md)) — regression khoá 2 bug dữ liệu ma đã fix
   (server row "sống nhăn" sau khi xoá local; hồi sinh calendar đã tombstone qua thiết bị offline).

---

## Chiến lược test 5 giờ (release readiness)

**Phân bổ ưu tiên trong 155 case: 40 P1 · 75 P2 · 40 P3.** 5 giờ cho 155 case là **rất chặt** nếu chạy tuần
tự theo file — chiến lược dưới đây nhóm lại theo **môi trường cần thiết** (không theo thứ tự file) để không
phải setup/reinstall lại nhiều lần, và trong mỗi phase luôn làm **P1 → P2 → P3**. Giả định thật: **1 người,
4 thiết bị**, đã có quyền D1 staging + Postman.

**Nguyên tắc:** không bao giờ cắt P1. Nếu trễ giờ, cắt theo đúng thứ tự ở mục "Quy tắc cắt giảm" — không tự
quyết định cắt case nào ngoài danh sách đó.

### Ánh xạ 4 thiết bị thật → vai trò cố định suốt buổi

Vì chỉ có 1 người, **không có song song thật** — nhưng gán sẵn 1 vai trò cố định cho mỗi máy (không đổi tài
khoản/vai trò giữa các phase) để không tốn thời gian đăng nhập lại/switch account giữa các case, đúng thứ tự
cầm máy nào lên là biết máy đó đang "đóng vai" gì:

| Máy | Vai trò cố định | Vì sao chọn máy này cho vai đó |
|---|---|---|
| **iPhone 14 Pro Max — iOS 26** | **Máy A (Owner/driver chính)** — đăng nhập Apple thật, giữ lịch mẫu lớn (≥600 event, ≥1 lặp hằng ngày, ≥1 event xa >12 tháng) | Bản mới nhất, đại diện đúng nhất cho user thật đa số; driver chính cho mọi action "tạo/sửa/xoá share" |
| **iPhone 11 Pro Max — iOS 17** | **Máy B (Receiver/member cố định)** — đăng nhập Google thật, có 1 lịch riêng của B | iOS cũ nhất trong 4 máy — không có Liquid Glass, giúp lộ ra bug chỉ "chạy đúng nhờ ăn may vào hiệu ứng OS mới"; đồng thời phủ luôn provider Google (khác Apple ở máy A) |
| **iPhone 11 — iOS 27 beta** | **Máy C (ẩn danh / exploratory / mượn tạm)** — mặc định KHÔNG đăng nhập tài khoản thật, chỉ có uid ẩn danh | Dùng đúng cho case cần trạng thái "chỉ uid ẩn danh" (TC-F8-03b, TC-F14-05); ⚠️ **OS beta — nếu gặp bug lạ chỉ tái hiện trên máy này, nghi ngờ lỗi OS beta trước khi báo bug app**, verify lại trên máy A/B trước khi log |
| **iPad gen 9 — iOS 18** | **Máy D (layout/width + mượn tạm)** — không giữ fixture cố định | Dùng cho case ghi "iPad nên có" (Manage sharing, màn Calendars — Suite SH6/SH7 ở file 02); còn lại rảnh để mượn tạm làm uid thứ 2/thứ 3 khi cần (TC-F2-08, TC-F4-03) |

**Mượn tạm máy C/D cho 2 case đặc biệt** (không đổi vai trò lâu dài, làm xong trả lại đúng trạng thái gốc):
- **TC-F2-08** (2 thiết bị cùng account resolve về 1 uid): link tạm tài khoản Apple của máy A vào máy D
  (iPad) → verify cùng uid → **unlink lại ngay** để D không mất trạng thái "rảnh" cho vai trò chính của nó.
- **TC-F4-03** (2 uid khác nhau cùng join 1 share): dùng máy C hoặc D làm uid thứ 2 join cùng share máy B đã
  join — không cần đăng nhập tài khoản thật, uid ẩn danh sẵn có là đủ.

### Pre-flight — 15 phút (làm trước khi bấm giờ)

- [ ] Postman collection dựng sẵn cho toàn bộ case API-only (file 06, 08, 09, 10, phần API của 04) — gọi 1
      click thay vì dựng request thủ công giữa lúc chạy.
- [ ] Máy A (iPhone 14PM, iOS 26): đăng nhập Apple thật, đã có lịch mẫu lớn sẵn.
- [ ] Máy B (iPhone 11PM, iOS 17): đăng nhập Google thật, có 1 lịch riêng của B.
- [ ] Máy C (iPhone 11, iOS 27 beta): xác nhận đang ở trạng thái chỉ-uid-ẩn-danh (chưa link Apple/Google).
- [ ] Máy D (iPad gen 9, iOS 18): sẵn sàng, chưa cần đăng nhập gì trước.
- [ ] D1 staging: xác nhận đọc được trực tiếp `calendars`/`calendar_events`/`shares`/`share_members`.
- [ ] App Check: có token hợp lệ **và** cách tạo token không hợp lệ có chủ đích.

### Phase 1 — 45 phút · API/backend, không cần UI (48 case, 10 P1)

| File | Case | P1 cần làm trước |
|---|---|---|
| [06-error-codes.md](06-error-codes.md) | 9 | TC-F10-03, TC-F10-05 |
| [08-data-model.md](08-data-model.md) | 3 | TC-F11-03 |
| [09-account-member-unlock-delete.md](09-account-member-unlock-delete.md) | 13 | TC-F12-04, TC-F17-01, TC-F17-02, TC-F17-03 |
| [10-rate-limit.md](10-rate-limit.md) | 3 | — |
| [04-sync-permission.md](04-sync-permission.md) (chạy được qua API, không cần đợi UI) | 20 | TC-F5-04, TC-F6-05, TC-F6-07 |

### Phase 2 — 25 phút · Định danh & Login — chủ yếu Máy A, chạm B/D 1 lần (21 case, 7 P1)

| File | Case | Máy | P1 cần làm trước |
|---|---|---|---|
| [01-identity-login.md](01-identity-login.md) | 21 | A cho hầu hết; mượn D 1 lần cho TC-F2-08 | TC-F2-02, TC-F2-03, TC-F2-04, TC-F2-05, TC-F2-07, TC-F2-13, TC-F2-21 |

### Phase 3 — 100 phút · Share (Máy A) + Join (Máy B) (64 case, 15 P1 — phase nặng nhất)

> Chứa **TC-F4-08 — rủi ro cao nhất toàn bộ bộ test case**. Làm case này sớm trong phase, không để cuối. Vì
> A/B đã cố định vai trò từ Pre-flight, phase này chỉ còn thao tác cầm-máy-lên-làm, không tốn thời gian đăng
> nhập lại — đây là lý do rút được 10 phút so với ước tính ban đầu (110→100).

| File | Case | Máy | P1 cần làm trước |
|---|---|---|---|
| [02-share-creation.md](02-share-creation.md) | 44 | A tạo share; đối chiếu kết quả trên B ở TC-F3-19/42/43/44 | TC-F3-02, TC-F3-03, TC-F3-04, TC-F3-07, TC-F3-11, TC-F3-19, TC-F3-32, TC-F3-42, TC-F3-43 |
| [03-join-receive.md](03-join-receive.md) | 20 | B join link do A tạo; TC-F4-03 mượn thêm C/D làm uid thứ 2 | **TC-F4-08** (làm đầu tiên, trên B), TC-F4-05, TC-F4-06, TC-F4-07, TC-F4-20, TC-F4-02 |

### Phase 4 — 60 phút · Revoke + Backup/Restore, cần reinstall (22 case, 8 P1)

> Dồn **toàn bộ** case cần gỡ-cài-lại app vào 1 chu kỳ reinstall duy nhất (TC-F8 series, TC-F14-03/04,
> TC-F9 series) — không reinstall riêng cho từng case. TC-F14-04 (offline resurrection) cần A xoá lịch trong
> lúc B (hoặc C) đang Airplane Mode với mutation dirty sẵn — dựng sẵn trạng thái dirty ở B TRƯỚC khi bật
> Airplane Mode để không phải chờ giữa lúc đang chạy giờ.

| File | Case | Máy | P1 cần làm trước |
|---|---|---|---|
| [05-revoke.md](05-revoke.md) | 6 | A revoke, B chịu tác động | TC-F7-01, TC-F7-02, TC-F7-05 |
| [07-backup-restore.md](07-backup-restore.md) | 16 | A gỡ-cài-lại (chính); C giữ vai anonymous-only cho TC-F8-03b/TC-F14-05; B đóng vai "máy 2 offline" cho TC-F14-04 | TC-F8-03, TC-F8-03b, TC-F9-06, TC-F14-03, TC-F14-04 |

### Buffer — 55 phút

Triage bug vừa tìm, retest sau fix nhanh, và chốt Go/No-Go theo checklist dưới. Không dùng buffer để mở thêm
case mới ngoài kế hoạch.

**Tổng: 15 (pre-flight) + 45 + 25 + 100 + 60 + 55 (buffer) = 300 phút = 5 giờ.**

### Quy tắc cắt giảm khi trễ giờ (theo đúng thứ tự, không tự chọn khác)

1. **Không bao giờ cắt P1** (40 case, danh sách đầy đủ ở Go/No-Go dưới) — nếu tới đây vẫn trễ, xin thêm giờ
   thay vì bỏ P1.
2. Cắt trước: toàn bộ **P3** (40 case) — chuyển sang "chưa test, không phải P1/P2", ghi nợ kỹ thuật để chạy
   sau release.
3. Cắt tiếp: [10-rate-limit.md](10-rate-limit.md) toàn file (3 case, cross-cutting, rủi ro thấp nhất trong
   bộ) — hoãn hoàn toàn.
4. Cắt tiếp: rút gọn Suite SY2 (04, ma trận quyền DT1) — chỉ giữ 2 dòng đại diện (`viewer+NULL` và
   `editor+viewer` override) thay vì chạy đủ 8 tổ hợp, vì cơ chế test tương tự nhau.
5. **Không rút gọn** bất kỳ case nào ở Suite JN1 (03, chống lộ lịch `Ink · <tên>`) hay TC-F3-42/43 (cross-
   device quyền/revoke qua UI thật) — đây đúng là loại case dễ bị "coi như chắc đúng" khi vội mà không verify
   thật.

### Go/No-Go — 40 case P1, bắt buộc pass trước khi release

| File | P1 cần pass |
|---|---|
| [01-identity-login.md](01-identity-login.md) | TC-F2-02, -03, -04, -05, -07, -13, -21 |
| [02-share-creation.md](02-share-creation.md) | TC-F3-02, -03, -04, -07, -11, -19, -32, -42, -43 |
| [03-join-receive.md](03-join-receive.md) | TC-F4-02, -05, -06, -07, -08, -20 |
| [04-sync-permission.md](04-sync-permission.md) | TC-F5-04, TC-F6-05, TC-F6-07 |
| [05-revoke.md](05-revoke.md) | TC-F7-01, -02, -05 |
| [06-error-codes.md](06-error-codes.md) | TC-F10-03, -05 |
| [07-backup-restore.md](07-backup-restore.md) | TC-F8-03, TC-F8-03b, TC-F9-06, TC-F14-03, -04 |
| [08-data-model.md](08-data-model.md) | TC-F11-03 |
| [09-account-member-unlock-delete.md](09-account-member-unlock-delete.md) | TC-F12-04, TC-F17-01, -02, -03 |
| [10-rate-limit.md](10-rate-limit.md) | — (không có P1) |

**Release chỉ Go khi cả 40 case trên PASS.** Bug ở bất kỳ case nào trong danh sách này = No-Go, bất kể còn
bao nhiêu P2/P3 chưa chạy.

### Lưu ý khi chỉ có 1 người vận hành 4 máy

- **Không có song song thật** — thời gian tiết kiệm được không phải từ "làm 2 việc cùng lúc", mà từ việc mỗi
  máy giữ **nguyên trạng thái/vai trò** suốt buổi (Pre-flight ở trên) nên không tốn thời gian đăng nhập lại,
  đổi tài khoản, hay dựng lại fixture giữa các phase — đây là toàn bộ khoản tiết kiệm 10 phút ở Phase 3.
- **Thứ tự cầm máy trong Phase 3/4 nên đi theo action, không theo máy**: làm 1 action trên A → ngay lập tức
  cầm B lên verify kết quả → mới quay lại A cho action kế tiếp. Tránh dồn "làm hết trên A rồi mới cầm B lên
  verify 1 loạt" — dễ quên trạng thái nào đang chờ verify gì, và nếu có bug thì khó xác định đúng bước gây ra.
- **Máy C (iOS 27 beta) là máy rủi ro nhất về nhiễu môi trường** — chỉ dùng cho đúng 2 việc đã gán (anonymous-
  only, mượn tạm làm uid thứ 2/3). Không dùng máy C để verify bất kỳ case Go/No-Go (P1) nào một mình — nếu
  1 case P1 chỉ fail trên máy C, verify lại trên A hoặc B trước khi coi là bug thật.
- **Máy D (iPad) rảnh nhất** — ưu tiên cầm D lên trước cho 2 việc mượn tạm (TC-F2-08, TC-F4-03) để giữ máy C
  nguyên trạng thái anonymous-only cho tới đúng lúc cần ở Phase 4.
