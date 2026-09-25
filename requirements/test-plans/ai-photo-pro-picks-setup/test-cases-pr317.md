# Test Case Specification — Ink AI đọc ảnh, thử Pro trước khi mua, setup shortcut, badge Guide (PR #317)

> Thiết kế case theo [test-plan-pr317.md](test-plan-pr317.md) (ISTQB Foundation) — bám đúng kỹ thuật đã chọn ở
> mục 5 test plan, copy nguyên partition/rule/transition, không tự sáng tác kỹ thuật khác.
> Test basis: [qc-ai-photo-pro-picks-setup-vi.md](../../specs/ai-photo-pro-picks-setup/qc-ai-photo-pro-picks-setup-vi.md).
> Test condition nguồn: [test-analysis-pr317.md](test-analysis-pr317.md) (73 TC, mã `AI-01`…`REG-05` — dẫn chiếu
> trong ngoặc ở cột "Bước thực hiện" của mỗi case bên dưới để truy ngược).
> Đối chiếu `SETUP-10`: [test-plan-ios26-27-v3.md §5.6](../shortcuts/test-plan-ios26-27-v3.md#56-state-transition-testing--luồng-chuyển-từ-shortcut-cũ-sang-v2-mig-hoàn-toàn-mới)
> (state `S0`-`S4` của `MIG`, PR #302) — chỉ tham chiếu điểm vào, không thiết kế lại.
> **Ngày lập:** 2026-09-25 · **Người lập:** QC

## Quy ước

- **Ưu tiên:** P1 (chặn phát hành) · P2 · P3 — copy nguyên từ mục 6 test plan / test-analysis mục 2, **không tự
  nâng/hạ**. Khi 1 test condition sinh ra nhiều case ở nhiều góc kỹ thuật (vd Decision Table + State Transition
  cùng verify `PRO-06`), mọi case đều giữ priority gốc của test condition đó.
- **⚠️ Phụ thuộc gap mở** — case có thể đổi kết quả mong đợi sau khi dev/PO trả lời đúng 1 trong 11 gap ở mục
  10/11 `test-plan-pr317.md` (10 gap đã biết + gap 🆕 #11 `BG-06`). Chạy và ghi nhận hành vi thật, **không tự
  đoán câu trả lời**. Số gap được ghi rõ ngay trong case (vd "⚠️ gap #1").
- **🔭 Exploratory** — không dùng trong file này: mọi test condition của PR #317 đều có kết quả mong đợi định
  tính rõ ràng (kể cả các case treo chờ số liệu — mục 5.3/5.7 test plan tự nêu rõ "verify hành vi định tính",
  không phải "chưa có đáp án đúng/sai" theo §4.4.2). Nếu khi thực thi phát sinh case cần quan sát/ghi lại thuần
  tuý, bổ sung sau bằng skill test-case, không tự thêm ở bước này.
- **Ảnh bằng chứng:** lưu vào `screenshots/<mã nhóm>/`, đặt tên `<ID case>-<hậu tố màn hình/state>.png` — xem
  [screenshots/README.md](screenshots/README.md).
- **Cơ hội (không phải test condition chính thức):** mỗi lần màn `plan-list` của paywall được mở trong nhóm
  `PRO` (case nào có bước "Unlock Pro"/"Go Pro"), tiện thể quan sát lại
  [BUG-003](../../../bugs/bug-log.md#bug-003--discount-1-là-giá-trị-invalid-nhưng-pill-save-100-vẫn-hiện) (pill
  "SAVE 100%" sai với `discount: 1`) — không cần setup payload riêng, chỉ ghi nhận nếu vẫn tái hiện. Case
  `TC-REG-06` ở cuối file gom lại việc này thành 1 dòng track chính thức.
- **Môi trường mặc định mọi case** (không lặp lại trong từng case): build **Ink Dev** qua Firebase App
  Distribution, đúng bản đã merge PR #317 — **không** phải App Store/TestFlight. Thiết bị: iPhone **iOS 27** +
  iPhone **iOS 26** (bắt buộc cả hai cho cả 6 nhóm, trừ khi case tự ghi rõ chỉ 1 hệ). Tài khoản mặc định
  **Free**, dùng nút dev **Grant Pro (dev)** / **Revoke Pro (dev)** trong Settings để đổi tier khi case yêu cầu.
  Dữ liệu chuẩn bị sẵn (mục 7 test-plan): 1 ảnh có chữ rõ, 1 ảnh không chữ, 1 ảnh rất nhiều chữ, ≥1 ảnh riêng đã
  đặt làm wallpaper Lock, catalog Pro ≥16 ảnh, 1 sự kiện Calendar ngày mai 15:00–16:00. Máy "người dùng cũ"
  riêng cho `SETUP-10` (chuẩn bị theo [mục 7 test-plan-ios26-27-v3.md](../shortcuts/test-plan-ios26-27-v3.md#7-test-environment-matrix)).
  **Baseline bắt buộc chụp trước khi bắt đầu:** dòng "Refreshed automatically …" trên build trước PR #317 (dùng
  cho `TC-SETUP-10`).
- **Thứ tự chạy khuyến nghị** (theo mục 8 test-plan, không phải điều kiện cứng): `TC-PRO-01`→`TC-PRO-03` (nền
  tảng Decision Table + State Transition `PRO`) → `TC-SETUP-11`/`TC-SETUP-12` (ranh giới V1/V2) → `TC-REG-03`/
  `04`/`05` (regression P1, chạy sớm) → phần còn lại.

---

## 1 · Ink AI — gửi ảnh, cảnh báo trùng lịch, copy/độ dài tin · `TC-AI` (mục 2 test plan #1, mục 5.1-5.3)

> **State Transition (5.1, `TC-AI-01`→`07`):** copy nguyên 8 dòng transition của bảng "Vòng đời gửi ảnh". Ưu
> tiên chạy `TC-AI-05` (transition `NetworkError→Done` qua Retry) sớm — cost-control quan trọng nhất nhóm.
> **BVA (5.2, `TC-AI-08`/`09` cho biên 1000 ký tự; `TC-AI-10` cho biên overlap 15:59/16:00).**
> **EP (5.3, `TC-AI-11` cho quota "lượt hỏi/ngày", ⚠️ gap #1).**
> **Còn lại (`TC-AI-12`→`23`):** checklist-based, mỗi case trích thẳng 1 dòng test basis (mục 1-3), không có kỹ
> thuật thiết kế riêng vì bản thân là assertion đơn, không phụ thuộc trình tự/tổ hợp.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-AI-01 | State `Idle`→`Reading`→`Done`. Ở tab Ink AI, bấm **+**, chọn ảnh có chữ rõ (thời khoá biểu/poster) (AI-02) | Ảnh hiện ngay bên phải thành ô vuông; dòng chờ "Reading the photo…" rồi "Still going…"; chữ đọc được hiện dưới ảnh, thu gọn 3 dòng (bấm mở/thu lại được); sau đó Ink trả lời và tạo thẻ sự kiện như khi gõ tay | P1 |
| TC-AI-02 | State `Idle`→`Reading`→`NoText`. Chọn ảnh **không có chữ** (phong cảnh) (AI-04) | Ảnh vẫn hiện, sau đó báo "No text found in that photo…"; **không** có nút Retry, có nút tạo thủ công; **không** trừ lượt hỏi trong ngày | P2 |
| TC-AI-03 | State `Idle`→`Reading`→`StillGoing`→`Done`. Chọn ảnh trang sách **rất nhiều chữ** (AI-05) | Ink chỉ đọc phần đầu, trả lời xong kèm câu "That photo has a lot of text, so I only read the first part…" | P2 |
| TC-AI-04 | State `Reading`/`StillGoing`→`Cleared`. Gửi 1 ảnh có chữ, ngay khi đang "Reading the photo…" bấm **Clear chat** (AI-07) | Chat trống hẳn ngay; sau đó response đọc ảnh trả về (nếu vẫn tới) **không** được làm ảnh/chữ cũ hiện lại (race condition — response tới sau khi đã Clear phải bị bỏ) | P2 |
| TC-AI-05 | 🔴 Chạy sớm. State `Idle`→`NetworkError`→`Done`. Tắt mạng, gửi 1 ảnh có chữ → báo lỗi mạng → bật mạng lại → bấm **Retry** (AI-08) | Báo lỗi mạng đúng lúc tắt mạng; sau Retry: gửi lại **chữ** đã đọc trước đó, **không gọi lại API đọc ảnh** (verify bằng cách đổi ảnh khác trong Photos ngay sau khi tắt mạng — nếu Retry vẫn ra đúng chữ ảnh gốc là đúng, không đọc ảnh mới) | P1, ⚠️ gap #2 (lần lỗi mạng này có tính 1 lượt hỏi/ngày không — verify hành vi, không tự kết luận) |
| TC-AI-06 | State `Done`→ tắt app, mở lại → vẫn `Done`. Sau `TC-AI-01`, tắt hẳn app rồi mở lại (AI-09) | Ảnh và chữ trong lịch sử chat vẫn còn nguyên (persist qua restart) | P2 |
| TC-AI-07 | State `Done` (đúng ảnh vừa gửi)→`Reading`→`Done` mới. Sau `TC-AI-01`, chọn lại **đúng ảnh vừa gửi** lần nữa (AI-06) | Vẫn gửi được, không bị chặn trùng — chạy lại đủ luồng Reading→Done | P3 |
| TC-AI-08 | BVA 3-value biên 1000 ký tự, ký tự ASCII (không phụ thuộc đơn vị đếm). Gõ tin nhắn: (a) **999** ký tự → gửi thử; (b) đúng **1000** ký tự → gửi thử; (c) **1001** ký tự (AI-22) | (a) 999: gửi được bình thường. (b) 1000: vẫn gửi được (biên đúng, hợp lệ). (c) 1001: hiện "N of 1000 characters", nút gửi **bị khoá** | P2 |
| TC-AI-09 | Lặp lại BVA `TC-AI-08` (999/1000/1001) nhưng gõ bằng **tiếng Việt có dấu** và **emoji** (AI-22) | ⚠️ **Phải quan sát/ghi lại** cách đếm thực tế đối với ký tự có dấu (1 grapheme) và emoji (có thể nhiều UTF-16 code unit) tại đúng biên — không tự kết luận số hiển thị nào là "đúng"/"sai" cho tới khi có câu trả lời gap #3 (đơn vị đếm) | P2, ⚠️ gap #3 |
| TC-AI-10 | BVA 2-value biên overlap lịch. Có sẵn sự kiện nền 15:00–16:00 (chuẩn bị đầu bài). Gõ tin tạo thẻ mới: (a) giờ bắt đầu **15:59** (chồng 1 phút); (b) giờ bắt đầu **16:00** (liền kề đúng biên) (AI-16) | (a) 15:59: thẻ hiện dòng cam "Overlaps with \<tên sự kiện nền\>". (b) 16:00: **không** báo overlap (liền kề đúng, không phải chồng lấn) | P1 |
| TC-AI-11 | EP quota "lượt hỏi trong ngày", 4 partition, trên số quota **thật của production** hiện tại: (a) còn nhiều lượt — nút + hiện bình thường; (b) còn đúng 1 lượt (biên) — nút + vẫn hiện, gửi được; (c) vừa gửi hết lượt cuối — nút + **ẩn ngay** sau khi gửi xong; (d) mở lại app sau khi đã hết từ trước — nút + **ẩn sẵn** ngay khi mở màn (AI-11) | ⚠️ Verify **định tính**: nút + không bao giờ ẩn khi còn lượt (a)(b), ẩn đúng lúc vừa hết (c), và ẩn sẵn khi mở lại app lúc đã hết (d) — ghi lại số lượt quan sát được trên production, **không tự suy ra** con số biên "chính thức" cho tới khi có câu trả lời gap #1 | P1, ⚠️ gap #1 |
| TC-AI-12 | Bấm **+** ở ô nhập Ink AI (AI-01) | Thư viện ảnh iOS mở ra ngay, **không** có hộp xin quyền truy cập ảnh | P2 |
| TC-AI-13 | Sau `TC-AI-01`, bấm vào ảnh trong bong bóng chat (AI-03) | Ảnh mở toàn màn hình, có nút ✕ góc trên trái; kéo xuống đủ xa thì đóng, kéo ít thì ảnh bật lại | P3 |
| TC-AI-14 | Đang gõ **quote** trong ô nhập (AI-10) | Nút **+** bị ẩn trong lúc đang viết quote | P3 |
| TC-AI-15 | Bấm vào ô nhập (chưa gõ gì) rồi bấm ra ngoài, lặp lại vài lần (AI-12) | Chưa bấm: ô nhập nằm trên 1 hàng. Bấm vào: chữ chiếm cả chiều ngang, các nút xuống hàng dưới. Bàn phím **không** bị tắt khi đổi qua lại giữa 2 trạng thái | P3 |
| TC-AI-16 | Mở màn **Help** (hỏi đáp) trong tab Ink AI (AI-13) | Màn Help **không** có nút + | P3 |
| TC-AI-17 | Đã cấp quyền lịch. Gõ "gym tomorrow 3pm" (trùng sự kiện nền 15:00–16:00) (AI-14) | Thẻ sự kiện hiện dòng cam **"Overlaps with \<tên sự kiện\>"** | P2 |
| TC-AI-18 | Tiếp `TC-AI-17`, đổi giờ thẻ sang giờ trống rồi đổi lại giờ trùng (AI-15) | Đổi sang giờ trống: dòng cảnh báo biến mất. Đổi lại giờ trùng: dòng cảnh báo hiện lại | P2 |
| TC-AI-19 | Tiếp `TC-AI-17`, bấm **Add** để lưu thẻ (AI-17) | Dòng cảnh báo biến mất sau khi lưu | P3 |
| TC-AI-20 | Tạo thẻ dạng **task**, thẻ **cả ngày**, và thẻ **chưa có giờ** — mỗi loại trùng khung giờ sự kiện nền (AI-18) | Cả 3 loại: **không** có cảnh báo trùng lịch nào | P2 |
| TC-AI-21 | **Chưa** cấp quyền lịch, gõ tin tạo thẻ trùng giờ → sau đó cấp quyền lịch rồi quay lại app (AI-19) | Chưa cấp quyền: không có cảnh báo, **không** tự hiện hộp xin quyền. Cấp quyền xong quay lại: cảnh báo hiện ra | P2 |
| TC-AI-22 | Giữ tay trên bong bóng chat có chữ (của mình, của Ink, và bong bóng lỗi), thử cả ở màn Help (AI-20) | Hiện menu **Copy**; dán ra app khác (vd Notes) đúng nội dung | P3 |
| TC-AI-23 | Giữ tay trên bong bóng chỉ có thẻ sự kiện hoặc danh sách (không có chữ) (AI-21) | Không có menu Copy hiện ra | P3 |

---

## 2 · Editor — thử Pro trước khi mua · `TC-PRO` (mục 2 test plan #2, mục 5.4-5.5)

> **Decision Table (5.4, `TC-PRO-01`→`08`):** copy nguyên 8 rule `ER1`→`ER8` (Tier × ≥1 lựa chọn Pro pending ×
> hành động tại popup). Chạy `TC-PRO-01`→`03` sớm nhất — nền tảng cho toàn bộ nhóm `PRO`.
> **Case cụ thể business-critical (`TC-PRO-09`/`10`):** 2 case đích danh test basis nêu riêng (dòng 71/72),
> không gộp vào `ER5` chung vì có chuẩn bị dữ liệu riêng (ảnh riêng đã đặt Lock).
> **State Transition (5.5, `TC-PRO-11`/`12`):** chỉ 2 transition **chưa** được Decision Table phủ (`T0→T1` đổi
> canvas ngay TRƯỚC popup, `T1→T0` nhãn PRO biến mất khi chọn lại giá trị gốc) — các transition còn lại của
> bảng 5.5 (`T2→T3→T4`, `T2→T0`, `T2→T1`, `T1→` thoát không xác nhận) đã trùng nội dung nghiệp vụ với
> `ER3`/`ER5`/`ER6`/`TC-PRO-10`, không viết lại để tránh case trùng lặp.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-PRO-01 (`ER1`) | Free. Mở editor cho mẫu **đã có sẵn** lựa chọn Pro (0 pending mới, kể cả mẫu đã có sẵn Pro chưa đụng tới) → bấm nút xác nhận ngay, không đổi gì (PRO-09) | **Không** hỏi lại về lựa chọn Pro có sẵn đó — set thẳng với giá trị hiện tại, không popup | P2, ⚠️ gap #5 (nếu mẫu có **nhiều** lựa chọn có sẵn và chỉ đổi 1 cái — verify nội dung popup thật, không tự đoán liệt hay không liệt lựa chọn cũ chưa đổi) |
| TC-PRO-02 (`ER2`) | Free. Chọn thử 1 lựa chọn Pro (vd font Pro) → bấm nút xác nhận, chưa chọn nhánh nào (PRO-02/PRO-03) | Nút xác nhận có nhãn **PRO**. Popup **"Keep your Pro picks?"** hiện, liệt đúng lựa chọn vừa chọn kèm giá trị (tên font) | P1 |
| TC-PRO-03 (`ER3`) | Free. Từ `TC-PRO-02` → bấm **Unlock Pro** → mua Pro thành công (PRO-05) | Mở paywall, vẫn ở trong editor. Mua xong: nhãn PRO **biến mất**, popup đã đóng, **vẫn ở editor**, **chưa** set — phải bấm nút xác nhận **lần nữa** mới set thật; nếu set ngay không cần bấm lần 2 → bug nghiêm trọng nhất nhóm `PRO` | P1 |
| TC-PRO-04 (`ER4`) | Free. Từ `TC-PRO-02` → bấm **Unlock Pro** → **huỷ paywall** (vuốt đóng paywall) hoặc làm **thanh toán thất bại** (PRO-04/PRO-05) | ⚠️ Verify hành vi thật: editor giữ nguyên preview Pro + nhãn PRO như trước khi bấm Unlock, hay bị reset? Ghi lại đúng thực tế quan sát được, **không tự kết luận pass/fail** cho tới khi có câu trả lời gap #6 | Chờ xác nhận gap #6 (P2 theo `PRO-04`) |
| TC-PRO-05 (`ER5`) | Free. Chọn thử ≥1 lựa chọn Pro (vd font Pro) → từ popup → bấm **Set without Pro** (PRO-06) | Lựa chọn Pro rollback về **đúng giá trị lúc mở editor**, chạy luồng set bình thường với giá trị gốc đó (không phải giá trị Pro vừa chọn thử) | P1 |
| TC-PRO-06 (`ER6`) | Free. Từ `TC-PRO-02` → **vuốt đóng** popup (PRO-11) | Không có gì xảy ra, vẫn ở editor; **không** set nhánh nào; nhãn PRO trên nút **vẫn giữ nguyên** (vẫn Có) | P2 |
| TC-PRO-07 (`ER7`) | **Pro**. Chọn bất kỳ lựa chọn Pro nào (font/màu/ảnh/mode) → bấm nút xác nhận (PRO-10) | Set thẳng, **không** gating: không thấy nhãn PRO trên nút, **không** có popup nào hiện ra dù chọn bất kỳ lựa chọn Pro nào | P1 |
| TC-PRO-08 (`ER8`) | Free. Chọn thử **đồng thời cả 4 loại** Pro (font + màu Custom + ảnh nền Pro + mode Home Screen Pro) → bấm nút xác nhận → từ popup bấm **Set without Pro** (PRO-06) | Rollback **đồng thời cả 4 field** về đúng giá trị lúc mở editor — không sót field nào | P1, ⚠️ gap #4 (test basis chỉ có case cụ thể xác nhận riêng cho ảnh nền — verify rollback tổ hợp 4 loại cùng lúc là mở rộng hợp lý theo đúng mục 5.4 test plan, không tự suy diễn thêm ngoài phạm vi này) |
| TC-PRO-09 | **Case cụ thể — ảnh riêng.** Free, wallpaper Lock đang dùng **ảnh riêng** đã chuẩn bị sẵn → mở editor → chọn thử 1 ảnh nền **Pro** trong catalog → từ popup bấm **Set without Pro** (PRO-07) | Wallpaper phải quay về **đúng ảnh riêng ban đầu**, **không phải** ảnh mặc định của template. Ảnh preview trong luồng set cũng **không** còn ảnh Pro. Đính kèm ảnh chụp trước/sau làm bằng chứng (data integrity — mất ảnh riêng là mất dữ liệu thật, không phải lỗi hiển thị) | P1 |
| TC-PRO-10 | **Case cụ thể — mode Home Screen Pro chưa xác nhận.** Free. Mở editor → tab Background → Home Screen → chọn thử **"My photo"** (mode Pro) → thoát ra màn hình chính **không** bấm nút xác nhận → chạy shortcut (PRO-08) | Home Screen **không** được đổi theo mode Pro chưa xác nhận — xác nhận "đường tắt" thoát ra ngoài rồi chạy shortcut không áp dụng được nội dung Pro ngoài luồng xác nhận/thanh toán | P1 |
| TC-PRO-11 (`T0→T1`) | Free. Mở editor (giá trị mặc định = `T0`) → chọn 1 trong 4 loại lựa chọn Pro (vd màu Custom) — quan sát canvas **ngay khi vừa chọn**, TRƯỚC khi bấm bất kỳ nút nào khác (PRO-01) | Canvas đổi theo **ngay lập tức** khi vừa chọn thử, **chưa có bất kỳ popup nào** xuất hiện tại thời điểm này (state `T1`) | P1 |
| TC-PRO-12 (`T1→T0`) | Tiếp `TC-PRO-11` (đang ở `T1`, nhãn PRO đang hiện) → chọn lại **đúng giá trị lúc mở editor** (PRO-02) | Nhãn PRO trên nút xác nhận **biến mất** (quay về `T0`) — xác nhận theo dõi diff đúng cả chiều "huỷ chọn thử", không chỉ chiều "vừa chọn" | P1 |
| TC-PRO-13 | Decorate, `DR1`. Chưa có Cutout/style chữ Pro nào chưa xác nhận → bấm **✓** | Đóng Decorate bình thường, **không** hiện popup nào (baseline, hỗ trợ đối chứng cho `TC-PRO-14`) | P3 |
| TC-PRO-14 (`DR2`) | Decorate. Vừa thêm **Cutout** (hoặc style chữ Pro) → bấm **✓** (PRO-15) | Nút ✓ có **vương miện** ngay từ lúc vừa thêm. Bấm ✓: hiện cùng popup "Keep your Pro picks?" dạng Decorate, nút thứ 2 là **"Save without Pro"** | P2 |
| TC-PRO-15 (`DR3`) | Tiếp `TC-PRO-14` → bấm **Go Pro** (PRO-16) | Mở paywall, vẫn ở trong Decorate sau khi đóng paywall (không thoát ra ngoài) | P2 |
| TC-PRO-16 (`DR4`) | Tiếp `TC-PRO-14` (lượt mới) → bấm **Save without Pro** (PRO-17) | Cutout bị bỏ **hoàn toàn**; chữ giữ nguyên **nội dung** đã gõ, chỉ về style **mặc định**; đóng Decorate. Verify kỹ: **không** mất nội dung chữ (chỉ mất style) — nếu mất cả nội dung chữ đã gõ → risk cao nhất nhóm `PRO` | P1 |
| TC-PRO-17 (`DR5`) | Decorate. Đang có Cutout Pro chưa xác nhận → **xoá Cutout trước khi bấm ✓** → bấm ✓ (PRO-18) | Không bị hỏi (không popup) — nhánh Cutout đã xác nhận đúng theo test basis. ⚠️ Đồng thời thử thêm nhánh đối xứng: trả **style chữ Pro** về mặc định trước khi bấm ✓ — verify có được miễn hỏi tương tự không, ghi lại đúng thực tế, không tự đoán cho tới khi có câu trả lời gap #7 | P2, ⚠️ gap #7 |
| TC-PRO-18 | Popup "Keep your Pro picks?" với **≥4 dòng** (chọn thử đủ 4 loại Pro cùng lúc) → đổi Dynamic Type lên cỡ chữ lớn nhất → đổi ngôn ngữ app sang **tiếng Đức** rồi **tiếng Nga** (PRO-12) | Popup hiển thị đủ ở cả 2 ngôn ngữ và cỡ chữ lớn — không tràn, không bị cắt mất nút nào | P2 |
| TC-PRO-19 | Free. Mở Decorate → menu thêm → **Cutout** (PRO-13) | Cutout có **vương miện** nhưng vẫn dùng thử được (áp dụng lên canvas) với user Free | P2 |
| TC-PRO-20 | Free. Mở khung soạn chữ trong Decorate → chọn 1 **style chữ Pro** (PRO-14) | Style chữ Pro có vương miện nhưng áp dụng thử được; nút ✓ của **khung soạn chữ** (không phải nút ✓ Decorate) cũng có vương miện khi đang dùng style Pro | P2 |

---

## 3 · Hàng ảnh nền + màn Backgrounds · `TC-BG` (mục 2 test plan #3, mục 5.7)

> **EP + BVA (5.7):** `TC-BG-01`/`02` = BVA biên More (15/16 ảnh); `TC-BG-03` = EP vị trí ảnh đã chọn (trong/
> ngoài 15 đầu); `TC-BG-04`/`05` = EP số ảnh riêng multi-select (dưới giới hạn / đúng giới hạn Free, gap 🆕 #11);
> `TC-BG-06`→`08` = EP chế độ đóng màn theo mode. `TC-BG-09`→`15` = checklist còn lại (mục 7 test basis).

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-BG-01 | BVA biên More. Catalog đúng **15 ảnh** (không hơn) → mở hàng ảnh nền (BG-01) | Thứ tự: ô thêm ảnh → ảnh template/Default → ảnh của mình → 15 ảnh catalog. **Không** có ô More | P2 |
| TC-BG-02 | BVA biên More. Catalog **16 ảnh** (thêm 1 so với `TC-BG-01`) → mở hàng ảnh nền (BG-01) | Có ô **More (›)** hiện ở cuối hàng | P2 |
| TC-BG-03 | EP vị trí ảnh đã chọn. (a) Chọn 1 ảnh **trong** 15 ảnh đầu — baseline. (b) Chọn 1 ảnh **ngoài** 15 ảnh đầu (qua màn Backgrounds) rồi quay lại hàng ảnh nền (BG-02) | (a) Hiện trong hàng như bình thường. (b) Ảnh vừa chọn (ngoài 15 đầu) **vẫn hiện** trong hàng ảnh nền, không bị ẩn khỏi tầm nhìn | P2 |
| TC-BG-04 | Free. Màn Lock, bật "New photo every day" (multi-select) → chọn nhiều ảnh riêng, **dưới** giới hạn Free | Chọn được nhiều ảnh liên tiếp, màn **không** tự đóng sau mỗi lần chọn | P2 |
| TC-BG-05 | Free. Tiếp `TC-BG-04` → tiếp tục chọn tới khi **chạm giới hạn Free** (BG-06) | ⚠️ Màn đóng lại rồi hiện popup giới hạn ("Photo limit reached"/"Photo set is full") — test basis **không nêu con số cụ thể** của giới hạn này, ghi lại số ảnh thật quan sát được tại thời điểm chạm giới hạn, không tự đoán số cho tới khi có câu trả lời gap #11 | P2, ⚠️ gap 🆕 #11 |
| TC-BG-06 | Màn Lock, wallpaper **1 ảnh** (không bật multi-select) → chọn 1 ảnh trong hàng (BG-05) | Chọn xong **tự đóng màn** ngay | P2 |
| TC-BG-07 | Màn Lock, bật "New photo every day" → chọn 1 ảnh (BG-05) | Màn **không** tự đóng, cho phép chọn tiếp nhiều ảnh (đối lập `TC-BG-06`) | P2 |
| TC-BG-08 | Màn **Home Screen** → chọn hoặc thêm 1 ảnh (BG-07) | Chọn/thêm xong **luôn tự đóng màn** — khác hành vi multi-select của Lock (`TC-BG-07`) | P3 |
| TC-BG-09 | Bấm **More** để mở màn Backgrounds full-screen (BG-03) | Có ✕ và +; chip "All N", "Your photos N" (nếu có ảnh riêng), từng danh mục kèm số lượng; lưới **tự cuộn** tới đúng ảnh đang chọn | P2 |
| TC-BG-10 | Ở màn Backgrounds, đổi ngôn ngữ app (vd tiếng Việt) → quan sát tên danh mục (BG-04) | Tên danh mục hiển thị đúng ngôn ngữ (Cute, Doodle, Floral, Food, Minimal, Nature, Quotes, Wealth dịch đúng) | P3 |
| TC-BG-11 | Ảnh của mình đang được **chọn** trong hàng → quan sát góc trên phải (BG-08) | Dấu **tick** hiện ở góc trên phải; với ảnh của mình, tick **thay cho nút ✕** trong lúc đang chọn — phải **bỏ chọn** trước mới bấm ✕ xoá được | P2 |
| TC-BG-12 | Chọn 1 ảnh Pro làm wallpaper (đã set) → quan sát ô ảnh đó trong hàng (BG-09) | Nhãn PRO trên ô ảnh đó **bị ẩn** khi đang được chọn | P3 |
| TC-BG-13 | Đo khoảng cách giữa các ô ảnh ở hàng ảnh nền (cả màn chọn nền của **Note**) (BG-10) | Khoảng cách hẹp lại **6pt**, áp dụng cả 2 nơi | P3 |
| TC-BG-14 | Thêm 1 ảnh riêng mới từ Photos, quan sát lúc load; sau đó **crop lại** ảnh đó qua Photos rồi quay lại hàng ảnh nền (BG-11) | Ảnh riêng lần đầu có thể nháy nền xám trước khi lên ảnh (chấp nhận được). Sau khi crop lại: ô ảnh trong hàng **đổi theo khung crop mới ngay**, không giữ khung cũ (cache phải invalidate đúng) | P2 |
| TC-BG-15 | Tại thời điểm hiện popup "Photo limit reached"/"Photo set is full" (từ `TC-BG-05`, user Free) — quan sát hình minh hoạ (BG-12) | Popup dùng **hình vương miện mới**, không bị cắt | P3 |

---

## 4 · Luồng setup shortcut · `TC-SETUP` (mục 2 test plan #4, mục 5.8-5.9)

> Tiền điều kiện chung `TC-SETUP-01`→`10`: **user đang ở shortcut V2** (câu hỏi #8 đã đóng — xem banner đầu
> test-plan). `TC-SETUP-11`/`12` dùng máy "người dùng cũ" riêng, test đúng ranh giới V1 tại điểm vào.
> **Decision Table Bảng A (5.8, `TC-SETUP-01`→`03`):** copy nguyên `A1`→`A3` ("Setup lần đầu").
> **Decision Table Bảng B (5.8, `TC-SETUP-04`→`06`):** copy nguyên `B1`→`B3` ("Settings → Set up shortcut, đã
> có V2"). **BVA biên 24h (`TC-SETUP-07`):** case riêng do test plan yêu cầu tường minh, không gộp vào `B1`/`B2`.
> **`TC-SETUP-08`→`10`:** checklist (dòng trạng thái Settings, mục 9 test basis). **Boundary case (5.9,
> `TC-SETUP-11`/`12`):** 2 case xác nhận điểm vào `MIG`, không thiết kế lại state diagram đó.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-SETUP-01 (`A1`) | Chưa có shortcut nào (hoặc setup lần đầu = cài thẳng V2). Bấm **"Tap to add shortcut"** → thêm shortcut xong → quay lại app (SETUP-01) | ⚠️ Nút **"I've added it — check now"** hiện lên, trở thành nút chính (to, tối, nằm trên). Nút add phía dưới đổi thành **"Re-add shortcut"** (nhạt) — verify thêm: overlay tự động "Shortcut is working!" kiểu cũ (V1, theo `exploratory/03_shortcut-setup.md` SCT-H08) có còn xuất hiện song song với cơ chế bấm tay này không, ghi lại đúng thực tế, không tự kết luận cho tới khi có câu trả lời gap #8 | P1, ⚠️ gap #8 |
| TC-SETUP-02 (`A2`) | Từ `TC-SETUP-01`, bấm nút chính, giả lập **không thấy shortcut** (lỗi chung — vd xoá shortcut trước khi bấm check) (SETUP-02) | Hiện câu báo lỗi chung; nút **"Re-add shortcut"** (có dấu +) là nút chính; **"Try again"** ở dưới | P1 |
| TC-SETUP-03 (`A3`) | Từ `TC-SETUP-01`, bấm nút chính, giả lập lỗi do **từ chối quyền đặt wallpaper** (Don't Allow ở dialog quyền) (SETUP-03) | Hiện câu báo lỗi quyền wallpaper; **"Try again"** là nút chính, **không** có nút Re-add (khác nhánh `TC-SETUP-02`) | P1 |
| TC-SETUP-04 (`B1`) | Đã có shortcut V2, đã chạy thành công **trong 24 giờ qua** → Settings → Set up shortcut (SETUP-04) | Trang mở ở trạng thái xong: tiêu đề **"Shortcut is working!" ✅**, mô tả "Now let's make it run every day."; **chỉ** có nút **Next** (không Re-add, không "step 1"). Bấm Next → sang bước automation, **không** mở Shortcuts | P1 |
| TC-SETUP-05 (`B2`) | Đã có shortcut V2, **quá 24 giờ** kể từ lần chạy thành công gần nhất (hoặc chưa từng chạy) → Settings → Set up shortcut (SETUP-05) | Tiêu đề "Check your lock screen shortcut.", nút chính **"I've added it — check now"**. Bấm vào: app mở Shortcuts chạy thử → quay về → kiểm tra → sang bước automation | P1 |
| TC-SETUP-06 (`B3`) | Từ `TC-SETUP-04` hoặc `TC-SETUP-05` (đã kiểm tra thành công) → sang automation → bấm **Back** (SETUP-06) | Về lại trạng thái như `TC-SETUP-04` (Shortcut is working!); bấm Next → sang lại automation mà **không** chạy shortcut lần nữa (tránh side-effect trùng) | P2 |
| TC-SETUP-07 | BVA 2-value biên 24 giờ (ranh giới `B1` vs `B2`). Set đồng hồ thật (hoặc đổi giờ hệ thống có kiểm soát) tới đúng **23h59** kể từ lần chạy thành công gần nhất → mở Settings → Set up shortcut; sau đó tới **24h01** → mở lại | 23h59: vẫn ở trạng thái `B1` ("Shortcut is working!"). 24h01: chuyển sang `B2` ("Check your lock screen shortcut.") — sai lệch ở biên này là bug logic BVA điển hình | P1 |
| TC-SETUP-08 | Sau bước automation trong luồng setup (`TC-SETUP-04`/`05`), thoát app ngay tại bước automation → mở lại app (SETUP-07) | App **không** hiện lại lời mời setup automation nữa | P3 |
| TC-SETUP-09 | Shortcut đã cài nhưng automation hằng ngày **chưa chạy lần nào** → xem dòng trạng thái dưới "Set up shortcut" ở Settings (SETUP-08) | Dòng ghi **"Shortcut added · daily refresh not detected yet"**; đổi ngôn ngữ sang tiếng Việt → "Đã thêm phím tắt · chưa ghi nhận lần tự làm mới nào" | P2 |
| TC-SETUP-10 | Để automation chạy ít nhất 1 lần (qua đêm hoặc chạy tay) → xem lại dòng trạng thái (SETUP-09) | ⚠️ Dòng vẫn là **"Refreshed automatically …"** như cũ — đối chiếu với baseline đã chụp trước PR #317 (chuẩn bị ở Quy ước đầu file). Nếu không còn build cũ để chụp baseline, ghi rõ "không chụp được baseline" trong test summary thay vì bỏ case | P3, ⚠️ gap #9 |
| TC-SETUP-11 (`SETUP-10a`) | Máy "người dùng cũ" (đã cài shortcut V1, có automation, đã Set vài lần), **chưa từng** bắt đầu luồng update (state `S0` của `MIG`) → bấm bất kỳ nút "Set up shortcut" nào (Settings) | Vào đúng **bước 1** của luồng update 3 bước — Add shortcut → Shortcuts mở link V2 → Add Shortcut, tương ứng `TC-SH-MIG-08`/`09` của [test-plan-ios26-27-v3.md §5.6](../shortcuts/test-plan-ios26-27-v3.md#56-state-transition-testing--luồng-chuyển-từ-shortcut-cũ-sang-v2-mig-hoàn-toàn-mới) (`MIG`) — **không** được thấy tiêu đề "Shortcut is working!" hay "Check your lock screen shortcut." (2 màn Bảng B mục 5.8, chỉ dành V2). Không thiết kế lại case `MIG`, chỉ xác nhận đúng điểm vào | P1 |
| TC-SETUP-12 (`SETUP-10b`) | Cùng máy trên, đã dở dang ở state `S1` của `MIG` (đã Add shortcut V2 + chạy thử xác nhận xong, dấu ✓ ở bước 1, **chưa** xoá shortcut cũ) → thoát app, mở lại, bấm "Set up shortcut" từ **entry point khác** Settings (vd Home banner) | **Resume** đúng vị trí dở dang (bước 2, giống `TC-SH-MIG-10` của `MIG`) — bước 1 vẫn hiện dấu ✓, **không** bắt đầu lại từ đầu — **vẫn không** được thấy 2 màn của Bảng B dù đã gần hoàn tất | P1 |

---

## 5 · Badge Done/To do trong Guide · `TC-GUIDE` (mục 2 test plan #5, mục 5.10)

> **Decision Table (5.10, `TC-GUIDE-01`→`05`):** copy nguyên 5 rule `G1`→`G5`, cross-check trực tiếp state
> `S0`-`S4` của `MIG` như test plan yêu cầu — không test độc lập badge mà không biết state migration thật.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-GUIDE-01 (`G1`) | Máy **chưa cài** shortcut, hoặc đang ở **V1**, hoặc dở dang state `S1`-`S3` của `MIG` → mở tab Guide, xem mục "Add the shortcut (once)" (GUIDE-01) | Badge **To do** | P1 |
| TC-GUIDE-02 (`G2`) | Máy đã hoàn tất `MIG` (state `S4`), hoặc setup thẳng V2 lần đầu thành công → mở tab Guide (GUIDE-01) | Badge **Done** (tick xanh) | P1 |
| TC-GUIDE-03 (`G3`) | Đã cấp quyền Calendar → mở tab Guide, xem mục "Allow calendar access" (GUIDE-02) | Badge **Done** | P2 |
| TC-GUIDE-04 (`G4`) | **Chưa** cấp quyền Calendar → mở tab Guide (GUIDE-02) | Badge **To do** | P2 |
| TC-GUIDE-05 (`G5`) | Vào iOS Settings → bật/tắt quyền Calendar → quay lại app, mở tab Guide ngay (GUIDE-03) | Badge đổi **ngay**, không cần thao tác thêm gì trong app | P2 |
| TC-GUIDE-06 | Từ tab Guide, bấm setup shortcut ngay tại đây, hoàn tất luồng (GUIDE-04) | Badge mục shortcut đổi sang **Done** ngay sau khi hoàn tất | P2 |
| TC-GUIDE-07 | Mở tab Guide, quan sát các mục khác (automation, design, note…) (GUIDE-05) | Các mục này **không** có badge nào (negative/scope check) | P3 |
| TC-GUIDE-08 | Đổi ngôn ngữ sang tiếng Việt, quan sát badge; thử với tiêu đề mục dài nhất trong Guide (GUIDE-06) | Badge hiển thị đúng ngôn ngữ ("Xong"/"Cần làm"), **không** đẩy tiêu đề dài bị cắt quá mức | P2 |

---

## 6 · Hồi quy chung · `TC-REG` (mục 2 test plan #6, mục 5.11)

> **Error guessing / Checklist-based (5.11):** mỗi case trích thẳng 1 nguồn cụ thể — `TC-REG-05` trích bug
> **#316** đã có báo cáo thật; `TC-REG-04` là error-guessing kinh điển cho thay đổi IAP/paywall; `TC-REG-03`
> checklist tối thiểu cho lazy-init (⚠️ gap #10). Chạy sớm trong đợt test, không để cuối cùng.

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| TC-REG-01 | Quan sát widget ngoài Home Screen: mở app, đồng bộ lịch Google/Outlook, đồng bộ lịch chia sẻ (REG-01) | Widget cập nhật đúng sau cả 3 sự kiện trên (có thể chậm chấp nhận được **~1 giây**) | P2 |
| TC-REG-02 | Mở app nhiều lần liên tiếp (≥10 lần) (REG-02) | **Không** bị giật; Home và thumbnail trong collection hiển thị bình thường | P2 |
| TC-REG-03 | 🔴 Chạy sớm. Đăng nhập tài khoản ở Settings → Account → đăng xuất → đăng nhập lại **nhiều lần liên tiếp** (race condition cổ điển cho lazy-init) (REG-03) | ⚠️ Đăng nhập/đăng xuất hoạt động đúng ở mọi lần, không crash, không kẹt trạng thái — verify hành vi quan sát được, **không tự suy diễn nguyên nhân** kiến trúc cho tới khi có câu trả lời gap #10 (thay đổi này có thực sự thuộc PR #317 hay không) | P1, ⚠️ gap #10 |
| TC-REG-04 | 🔴 Chạy sớm. Đang là **Pro** (qua `TC-PRO-03` hoặc Grant Pro (dev)) → tắt app **đột ngột** ngay sau khi mua/chuyển Pro → mở lại ngay (REG-04) | Vẫn là Pro; **không** hiện paywall nhầm lúc mở app | P1 |
| TC-REG-05 | 🔴 Chạy sớm. Set wallpaper **tuần** hoặc **tháng** có nhiều sự kiện (tham chiếu bug #316) (REG-05) | Không bị **treo** app khi set wallpaper | P1 |
| TC-REG-06 | Cơ hội, không phải test condition chính thức. Mỗi lần màn `plan-list` của paywall được mở trong nhóm `PRO` (`TC-PRO-03`/`04`/`07`/`15`/`18`) → quan sát pill giảm giá | Ghi nhận có tái hiện [BUG-003](../../../bugs/bug-log.md#bug-003--discount-1-là-giá-trị-invalid-nhưng-pill-save-100-vẫn-hiện) (pill "SAVE 100%" sai với `discount: 1`) không, dùng dữ liệu remote config hiện tại, không publish payload riêng | — |

---

**Bước tiếp theo:** thực thi theo đúng "Thứ tự chạy khuyến nghị" ở Quy ước; ghi bằng chứng ảnh vào
`screenshots/<mã nhóm>/` theo [screenshots/README.md](screenshots/README.md); tổng hợp kết quả case ⚠️ vào test
summary report kèm rõ case nào đang treo theo từng gap (mục 10/11 `test-plan-pr317.md`).
