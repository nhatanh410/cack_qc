# Test Case Specification — Chia sẻ template bằng link (Ink Prod **1.2.19**) · slug `1-2-19`

> Thiết kế case theo [test-plan-1-2-19.md](test-plan-1-2-19.md) (ISTQB Foundation) — bám đúng kỹ thuật thiết
> kế đã chọn ở mục 5 test plan (EP, BVA, Decision Table, State Transition, Exploratory, Error guessing).
> Test basis: [template-sharing-vi.md](../../specs/share-template-link/template-sharing-vi.md) (`VI §N`) ·
> [fe-template-share-page.md](../../specs/share-template-link/fe-template-share-page.md) (`FE §N`, **không**
> dùng cho đợt này — xem mục 3 test plan, nhóm `ST-L` hoãn) ·
> [template-sharing-api.md](../../specs/share-template-link/template-sharing-api.md) (`API §3.x`).
> Input bắt buộc: [test-analysis-1-2-19.md](test-analysis-1-2-19.md) (mục 2 — 79 test condition) +
> [answers-1-2-19.md](answers-1-2-19.md) (nguồn mọi assumption, mức tin cậy CAO/TRUNG BÌNH/THẤP).

## Quy ước

- **Ưu tiên:** P1 (chặn phát hành) · P2 · P3 — theo đúng mục 6 test plan, **không tự đổi**. 3 condition
  (`TS-05`, `TS-15`, `TS-90`) bị thiếu khỏi danh sách liệt kê theo tên ở mục 6 test plan (lỗi đánh máy khi
  gộp nhóm, không phải đổi priority) — ưu tiên dùng ở đây lấy **trực tiếp từ mục 2 test-analysis** (công
  thức risk đã tính sẵn: cả 3 đều **P2**), xem "Ghi chú đối soát" ở cuối file.
- **🔭 Exploratory** — case chưa có đáp án đúng/sai định sẵn. Cột "Kết quả mong đợi" ghi "**Phải quan
  sát/ghi lại**", không phải PASS/FAIL — ghi vào phần "Charter" của case đó, không coi fail nếu kết quả
  khác dự kiến.
- **⚠️ Phụ thuộc gap/assumption** — case dùng oracle do QC/test lead tự chốt (không phải fact dev), **mức
  tin cậy ghi ngay trong "Kết quả mong đợi"**:
  - **(Assumption QC/test lead, tin cậy CAO — Q-x)** — Q-1, Q-4, Q-7, Q-8, Q-9.
  - **(Assumption QC/test lead, tin cậy TRUNG BÌNH — Q-10)**.
  - **⚠️ Oracle TẠM — tin cậy THẤP, dựa trên suy luận kỹ thuật của QC (Q-6), chưa xác nhận với dev — nếu
    dev trả lời khác thì expected result này phải viết lại.** — chỉ dùng cho TS-14 (phần nền)/TS-15.
- **🆕 Error guessing bổ sung** — case QC tự nghĩ thêm ngoài test plan, ghi rõ lý do, không trộn với case
  bám test basis.
- **Descope lúc chạy (không phải lúc thiết kế)** — case ghi rõ "nếu không có [phương tiện] → **không thực
  thi được — thiếu phương tiện**, không tính pass" theo đúng mục 7/9 test plan (proxy/mock bảo mật, script
  hạn mức, iPad, baseline ảnh, device/OS matrix) — **không viết case giả vờ** cho phần chắc chắn không chạy
  được (TS-69, TS-93 — xem ghi chú ở nhóm `ST-J`/`ST-M`).
- **Ảnh bằng chứng:** lưu vào `screenshots/<mã nhóm>/`, quy ước ở [screenshots/README.md](screenshots/README.md).
- **Môi trường mặc định mọi case (nêu 1 lần, không lặp lại):** Ink Prod 1.2.19 (hoặc TestFlight tương
  đương), 2 iPhone thật (máy A gửi, máy B nhận), bản iOS công khai mới nhất, chỉ cài Ink Prod. Máy A đăng
  nhập Apple/Google. Máy B: account Free (mặc định) — case cần Pro sẽ ghi rõ đổi account. 5 design chuẩn
  (1–5, VI §0) + 1 design bổ sung (6, QC tự dựng — `stack`, không `origin_template_id`, nền duy nhất là
  ảnh riêng) đã có sẵn trong "Your collection" của máy A trước khi bắt đầu:
  1. catalog để nguyên (không ảnh riêng, không chữ tự gõ) · 2. có ảnh riêng (nền/sticker) · 3. có text
  sticker/quote tự gõ, không ảnh riêng · 4. có cả ảnh riêng lẫn chữ tự gõ · 5. có tuỳ chỉnh Pro · 6. `stack`
  tự dựng, không `origin_template_id`, nền = ảnh riêng (cho `ST-C`/`ST-H` nhánh "id lạ"/Q-6).
  Mở link bằng cách đổi `https://inkcalendar.app/t/<id>` → `ink://template?id=<id>` (trang web `/t/<id>`
  ngoài phạm vi đợt này — nhóm `ST-L` hoãn).
- **Smoke bắt buộc trước khi chạy full bộ (entry criteria #7 test plan):** `STA-01` (TS-01) và `STF-01`
  (TS-36) phải **pass** trước khi chạy tiếp — fail 1 trong 2 → dừng, không chạy tiếp.

---

## 1 · Điểm vào nút Share · `TC-STA` (mục 2 test plan, nguồn VI §1 — checklist-based + EP)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| STA-01 | Home → "Your collection": giữ tay trên 1 **wallpaper** (design 1) | Menu context có mục **Share** | P2 |
| STA-02 | Vào màn "Your collection" (bấm tiêu đề) → giữ tay trên wallpaper | Menu có mục **Share**, giống STA-01 | P2 |
| STA-03 | Màn "Your collection" → bấm nút **⬆︎** góc trên phải → danh sách mở ra → chọn **1** wallpaper | Danh sách mở ra, chọn được 1 wallpaper, sau khi chọn **vào đúng luồng Share chuẩn** (như STA-01/02). *Chỉ phủ tới mức này — luồng chọn nhiều/huỷ giữa danh sách chưa định nghĩa (TB-25/O-18), xem charter STA-07* | P2 |
| STA-04 | Giữ tay riêng từng item: **(a)** Live Activity · **(b)** Note · **(c)** Widget trong "Your collection" | Cả 3 loại: menu context **không** có mục Share. Riêng (b) Note — fail ở đây = rò nội dung Note qua feature không thiết kế cho nó | **P1** |
| STA-05 | Dựng 1 collection **chỉ** chứa Live Activity/Note/Widget (không wallpaper nào) → mở màn "Your collection" | **Không** có nút ⬆︎ ở góc trên phải | P2 |
| STA-06 | Mở nút Share **không** bật cờ Remote Config nào (trạng thái mặc định của app, không cần cấu hình đặc biệt) | Nút Share hiện bình thường, gửi và nhận đều không bị gate bởi flag | P3 |
| STA-07 🔭 | **Charter:** sau khi bấm ⬆︎ (STA-03), thử chọn **nhiều** wallpaper nếu UI cho phép; thử **huỷ** giữa lúc danh sách đang mở (back/swipe) | **Phải quan sát/ghi lại**: có chọn được nhiều không (nếu có, tạo mấy link, share sheet nhận gì); huỷ giữa đường có để lại trạng thái lỡ dở không. Không có đáp án đúng định sẵn (TB-25/O-18) — không log bug nếu hành vi chỉ "lạ", chỉ log nếu crash/mất dữ liệu | — |

---

## 2 · Cổng đăng nhập (sign-in gate) · `TC-STB` (mục 2 test plan, nguồn VI §2 + API §Identity/§Errors — State Transition)

> States: S0 Signed-out · S1 Sign-in sheet hiện · S2 Signed-in, share tự resume · S3 Share bị huỷ.
> Mỗi case dưới đây chèn **đúng 1** transition — không gộp 2 lỗi trong 1 case (tránh defect masking, §4.2.4).

| ID | Transition | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|---|:---:|
| STB-01 | T1 (S0→S1) | Máy A **đăng xuất** → bấm Share trên design 1 | Hiện đúng màn **"Sign in to share this template"**; **không** publish gì (không có id mới sinh ra) | **P1** |
| STB-02 | T2 (S1→S2) | Từ S1 (STB-01) → đăng nhập **Apple hoặc Google** | Luồng share **tự chạy tiếp** (không phải bấm Share lại) — tiếp tục đúng luồng của design đang share (hộp ảnh/chữ nếu có). ⚠️ Nếu design đã chọn ảnh/chữ **trước** khi vào S1: **chưa có oracle rõ liệu lựa chọn đó có được giữ qua resume hay không** (TB-30) — ghi nhận thực tế quan sát được, không coi khác dự kiến là fail | **P1** |
| STB-03 | T3 (S1→S3) | Từ S1 → **vuốt xuống đóng** màn đăng nhập | **Không** share gì, **không** có link nào được tạo (kiểm bằng cách thử Share lại ngay sau — phải ra "Creating link…" như lần đầu, không phải trả link cũ) | **P1** |
| STB-04 | T4 (giả định) | Thử tạo trạng thái "phiên **anonymous**" (không phải Apple/Google) rồi cố publish | App coi là `sign_in_required`, **không** publish bằng token anonymous — ❓ **Testability gap mới phát hiện khi viết test case (chưa có trong mục 7/10 test plan):** test basis không nói **cách nào từ UI chuẩn để đưa máy vào trạng thái "anonymous đang đăng nhập publish"** (khác signed-out thường — S0). Nếu không có cách tái lập (qua proxy đổi Bearer token, hoặc 1 state nội bộ app mà QC không biết) → ghi **"không thực thi được — thiếu phương tiện, gap mới"**, không tính pass. **Không tự đoán cách tái lập** | **P1** |
| STB-05 | T5 | Giữa lúc publish, ép App Check thất bại (cần mock/proxy đổi token hoặc bắt gói tin — nếu không có, chỉ quan sát khi lỗi tự phát sinh) | App **force-refresh token và retry đúng 1 lần**, sau đó mới hiện lỗi chung — không treo, không retry vô hạn. TB-18: **không phân biệt được** từ UI đây có đúng là App Check fail hay lỗi khác nếu không có proxy/log — nếu thiếu phương tiện, ghi "không thực thi được chủ động — thiếu phương tiện" | P2 |
| STB-06 🔭 | — | **Charter:** thử sign-in Apple/Google **thất bại** (sai mật khẩu/huỷ ở dialog hệ thống), hoặc **mất mạng giữa lúc** đang ở màn đăng nhập | **Phải quan sát/ghi lại**: app về state nào (S0? S1? S3?), có giữ lựa chọn ảnh/chữ đã bấm trước T1 hay bắt đầu lại từ đầu. Không suy diễn trước kết quả (O-19/TB-30) | — |

---

## 3 · Hộp thoại xin phép ảnh/chữ · `TC-STC` (mục 2 test plan, nguồn VI §3/§4/§5 — Decision Table 4 rule)

> **Decision Table — copy đúng 4 rule của test plan, không tự thêm/bớt.** Dùng design 2 (ảnh riêng),
> design 3 (chữ tự gõ), design 4 (cả hai), design 1 (không gì), design 6 (`stack`, không
> `origin_template_id`, nền = ảnh riêng — cho nhánh Q-6). **Trình tự chạy gộp gợi ý:** Share design 1 →
> STC-01; Share design 2 ba lần liên tiếp (1 lần mỗi lựa chọn) → STC-02/03/05, rồi lần thứ 4 chọn Include
> my photos để giữ trạng thái "có ảnh" cho STC-04; Share design 3 hai lần (Share/Cancel) → STC-06/07; Share
> design 4 → STC-08, trong đúng hộp đó chọn Use Ink backgrounds → STC-09; Share design 6 chọn Use Ink
> backgrounds → phần oracle TẠM của STC-03/04 (nhánh "nền thay thế").

| ID | Rule | Precondition/Data | Kết quả mong đợi | Ưu tiên |
|---|---|---|---|:---:|
| STC-01 | R1 | Design 1 (không ảnh riêng, không chữ tự gõ) → Share | **Không** hộp thoại nào — thẳng "Creating link…" rồi share sheet iOS | P2 |
| STC-02 | R2 | Design 2 (có ảnh riêng) → Share | Hộp **"Share your photos too?"** với **đúng 2** lựa chọn: *Use Ink backgrounds* / *Include my photos* | **P1** |
| STC-03 | R2 nhánh a | Từ hộp ở STC-02 → chọn **Use Ink backgrounds** → mở trên máy B | **Phần design data (trong phạm vi):** thiết kế đã publish **không chứa ảnh riêng** (`asset_ids = []`, không `shared:` nào trỏ ảnh của user), máy B không thấy ảnh riêng trong thiết kế. **Phần nền thay thế** (lặp lại với design 6, không `origin_template_id`): nền hiển thị là **nền mặc định chung của hệ thống**. **⚠️ Oracle TẠM — tin cậy THẤP, dựa trên suy luận kỹ thuật của QC (Q-6), chưa xác nhận với dev — nếu dev trả lời khác thì expected result này phải viết lại.** ⛔ **Known gap, dev tự verify:** phần **ảnh preview công khai** (`preview_url`/card chat) có còn chứa ảnh riêng hay không — out of scope đợt này (Q-5), QC không kết luận | **P1** |
| STC-04 | R2 nhánh b | Share lại design 2, chọn **Include my photos** → mở trên máy B | Máy B thấy **đúng** ảnh của máy A. Dùng làm đối chứng với STC-03 (cùng design 2, khác lựa chọn ⇒ khác nền) — **phần đối chứng với nhánh nền thay thế** mang theo **⚠️ Oracle TẠM — tin cậy THẤP (Q-6)** như STC-03, nhưng oracle chính của case này (thấy đúng ảnh máy A) không phụ thuộc Q-6 | P2 |
| STC-05 | R2 nhánh c | Từ hộp "Share your photos too?" → **vuốt xuống đóng** | **Không** share gì, **không** share sheet, **không** link, **không** asset nào bị claim (kiểm: id chưa từng tồn tại cho wallpaper này, hoặc không đổi so với trước) | **P1** |
| STC-06 | R3 | Design 3 (chỉ chữ tự gõ) → Share | Hộp **"Share this text?"**, nội dung nói rõ **ai có link cũng đọc được chữ**; bấm **Share** → share bình thường (ra share sheet) | **P1** |
| STC-07 | R3 nhánh Cancel | Hộp "Share this text?" → **Cancel** | **Không** share gì | **P1** |
| STC-08 | R4 | Design 4 (ảnh riêng + chữ) → Share | Hiện **đúng MỘT** hộp (hộp ảnh "Share your photos too?", nội dung nhắc cả chữ đi kèm) — **không** hiện thêm hộp "Share this text?" | **P1** |
| STC-09 | Cross-cutting | Trong hộp ở STC-08, chọn **Use Ink backgrounds** → mở trên máy B | Chữ tự gõ **vẫn** đi theo link dù đã chọn Use Ink backgrounds (cắt ngang R2/R4) | P2 |
| STC-10 🆕🔭 | Error guessing | Dựng từng loại trên 1 design riêng: ảnh **cutout/tách nền**, ảnh **Ink AI** sinh, **quote catalog chưa sửa**, **tên wallpaper** → Share | **Phải quan sát/ghi lại** hộp nào hiện ra (R1/R2/R3/R4 hay khác). Nếu khác 4 rule trên → báo như **ca mới**, không coi là bug cho tới khi dev trả lời (O-3/TB-14) | — |

---

## 4 · "Mỗi wallpaper một link" · `TC-STD` (mục 2 test plan, nguồn VI §6 + API §3.2/§The model — State Transition)

> States: L0 chưa share · L1 đã share, có id + cache · L0' cache bị xoá (logout/đổi account), id cũ còn
> trên server. Mỗi case chèn đúng 1 transition.

| ID | Transition | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|---|:---:|
| STD-01 | T1+T2 | Share design 1 lần đầu (L0→L1) → ghi lại `id` → Share lại **ngay**, không đổi gì (L1→L1) | Lần đầu tạo id mới; lần 2 **cùng một `id`/link** (so link copy từ share sheet cả 2 lần). **(Assumption QC/test lead, tin cậy CAO — Q-1: không có UI thu hồi link nên không có nhánh "link bị xoá rồi share lại"; tin cậy TRUNG BÌNH — Q-10: liên quan cache, xem chi tiết ở `STD-06`.)** | **P1** |
| STD-02 | T3 | Từ L1 (STD-01) → **sửa design** (đổi màu/nền) → Share lại | Link **giữ nguyên** (cùng id), mở trên máy B thấy **bản đã sửa** | **P1** |
| STD-07 | T3b | Design 2, đang ở L1 với `asset_ids=[...]` (đã share lần trước, chọn **Include my photos** — tái dùng kết quả `STC-04`). **(1)** Ghi lại `id`/link hiện tại và `asset_id` của ảnh riêng đã publish (lấy từ payload/response publish trước đó, hoặc từ URL ảnh hiển thị ở máy B). **(2)** Trên máy A, Share lại **đúng cùng** design 2, lần này chọn **Use Ink backgrounds**. **(3)** Mở lại **cùng link** đó trên máy B. **(4)** Gọi `GET /template-share/assets/<asset_id>` với `asset_id` đã ghi ở bước (1) | **(a)** `id`/link **không đổi** so với bước (1) — so khớp chuỗi id. **(b)** Máy B mở lại link: thiết kế **không còn** ảnh riêng (`asset_ids=[]`) — ảnh riêng của lần share trước **biến mất** khỏi link, thay bằng nền/catalog thay thế. **(c)** `GET /template-share/assets/<asset_id>` (asset_id **cũ**, của lần share đầu) phải trả **404 thật** — ảnh đã bị **xoá hẳn ở server**, không chỉ ẩn khỏi response (API §Flow: "the server deletes images the new version no longer lists"). Cả 3 ý (a)(b)(c) đều phải đúng — fail bất kỳ ý nào = fail case. **Không** dùng assumption/oracle TẠM (TS-24 không thuộc 18 condition dùng assumption ở mục 6 test plan — oracle lấy trực tiếp từ VI §6.04 + API §Flow) | **P1** |
| STD-03 | — (không nhầm chéo) | Share 1 wallpaper **khác** (chưa từng share, L0 riêng) | **Id khác** với id của STD-01/02 — mở link mới không ra nội dung của wallpaper cũ | P2 |
| STD-04 | T2 (biến thể) | Từ L1 → Share lại khi **không đổi gì** (lặp thêm 1 lần nữa so với STD-01) | **Cùng id** (quan sát được từ UI). Phần "có sinh request thứ hai hay request bị bỏ qua / `updated_at` có bump" **không quan sát được từ UI thuần** (TB-17) — nếu không có proxy/log, chỉ ghi nhận "id giống nhau", **không** kết luận được chi phí publish | P3 |
| STD-05 | T4 | Cài lại app (hoặc dùng máy khác, cùng account) → Share lại **cùng** wallpaper đã share trước đó | Server trả **cùng id cũ** (không sinh id mới cho cùng wallpaper). **(Assumption QC/test lead, tin cậy CAO — Q-1; tin cậy TRUNG BÌNH — Q-10 — xem chi tiết lý do ở `STD-06`, không phải fact từ dev.)** | P2 |
| STD-06 | T5 | Từ L1 → **đăng xuất rồi đăng nhập lại** (nhánh 1) **và riêng** đăng nhập **account phụ khác** trên cùng máy (nhánh 2) → thử Share lại **đúng wallpaper** đó (nếu account mới có quyền truy cập cùng wallpaper — ví dụ qua iCloud) hoặc quan sát cache | Cache thiết bị **bị xoá**: account mới **không** thấy/tái dùng link cache của account cũ. **(Assumption QC/test lead, tin cậy CAO — Q-1: không có UI 3.8/3.9 nên không có nhánh "list/stop sharing"; tin cậy TRUNG BÌNH — Q-10: cache bị xoá khi logout/đổi account, không phải fact từ dev.)** Nếu cache **không** bị xoá → đây là **lỗi im lặng đã lường trước**, báo ngay theo mục 8.1 test plan, dừng cụm `ST-D`/`ST-J` để xác nhận lại với dev (O-25) trước khi tiếp tục | P2 |

> ✅ **Gap đã đóng (2026-10-02):** `qc-test-plan` đã bổ sung transition **T3b** vào bảng State Transition
> của `ST-D` ở mục 5 test plan (chèn giữa T3 và T4, xem changelog cuối phần `ST-D` trong test plan) — dành
> riêng cho **TS-24** (P1, risk **Rất cao**). Case `STD-07` ở trên viết theo đúng `T3b`, không còn bị chặn
> bởi mục 0 skill `test-case`. Test Plan Status vẫn `READY` sau bổ sung (bổ sung cục bộ, không đổi
> scope/priority) — xem mục 0 test plan.

---

## 5 · Vệ sinh payload & riêng tư khi publish · `TC-STE` (mục 2 test plan, nguồn API §3.1/§3.2 — EP + 3-value BVA)

> **5 case TS-27/28/29/30 cần proxy/mitmproxy (hoặc `curl` route public) để xem payload thật** (TB-23) —
> nếu không có lúc execute, ghi "**không thực thi được — thiếu phương tiện**", không tính pass. 12 case
> BVA cần test data được **chuẩn bị trước** đúng byte-size (resize/pad ảnh, hoặc dựng design với số
> sticker/ký tự tương ứng ngoài app) — quy ước làm tròn `1 MB = 1,048,576 byte`, `1 KB = 1,024 byte` do QC
> chọn (mục 5 test plan, chưa dev xác nhận "inclusive" tại đúng giá trị limit).

### 5.1 · Equivalence Partitioning

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| STE-01 | Mở màn "Shared template" trên máy B cho mọi design đã share | Ảnh **preview** là bản render trên **sự kiện mẫu**, **không bao giờ** chứa sự kiện thật của máy A. **(Assumption QC/test lead, tin cậy CAO — Q-8.)** ⛔ Known gap, dev tự verify: `preview_url` **công khai**/`og:image` ngoài phạm vi (Q-5) | **P1** |
| STE-02 | (Cần proxy) Share design 2 với Include my photos → bắt payload publish | Mọi `backgrounds[].path`/`sourcePath` là `catalog:https://assets.homebod.ai/…` hoặc `shared:<asset_id>`; `backgroundImagePath`/`backgroundSourcePath` = `null`; **không** đường dẫn file máy nào | **P1** |
| STE-03 | (Cần proxy) Cùng payload ở STE-02 | **Không** có calendar đã chọn, **note id**, **album id**, **rotation clock** nào trong payload (device state đã bị strip) | **P1** |
| STE-04 | (Cần proxy hoặc tải lại ảnh từ URL công khai) Tải ảnh đã publish, soi metadata | **Không còn EXIF/GPS** — ảnh đã được re-encode trước khi upload | **P1** |
| STE-05 | (Cần proxy) Payload publish của mọi design | `layout_kind` gửi lên **không bao giờ** là layout `notes*` (nhất quán TS-04) | P2 |
| STE-06 | Upload 1 ảnh (kind=photo) rồi **bỏ dở**, không publish, chờ >24h | Ảnh **không ai tải được** trong lúc chờ, và bị **xoá sau 24 giờ** — *(chi phí cao, có thể dời sang cuối lịch chạy)* | P2 |

### 5.2 · 3-value BVA — các ngưỡng API §Limits (copy đúng bảng mục 5 test plan)

| ID | Ngưỡng | Giá trị test data | Kết quả mong đợi | Ưu tiên |
|---|---|---|---|:---:|
| STE-07 | Ảnh — dưới biên | Ảnh 2,097,151 byte | Upload/publish **thành công**. **(Assumption QC/test lead, tin cậy CAO — Q-9: mã lỗi/ngưỡng đã do API định nghĩa đủ, giá trị biên cụ thể là quyết định thiết kế test của QC.)** | P2 |
| STE-08 | Ảnh — tại biên | Ảnh 2,097,152 byte (= 2 MB) | Upload/publish **thành công** (biên coi là hợp lệ — quy ước QC, chưa dev xác nhận). **(Assumption QC/test lead, tin cậy CAO — Q-9.)** | P2 |
| STE-09 | Ảnh — trên biên | Ảnh 2,097,153 byte | `413`; app hiện thông báo chung *"Couldn't create a share link. Try again."* — **không phân biệt được** từ UI đây là `413` hay lỗi khác nếu không có proxy (TB-18). **(Assumption QC/test lead, tin cậy CAO — Q-9.)** | P2 |
| STE-10 | Publish body — dưới biên | Body ~65,535 byte | Publish **thành công**. **(Assumption QC/test lead, tin cậy CAO — Q-9.)** | P2 |
| STE-11 | Publish body — tại biên | Body ~65,536 byte (= 64 KB) | Publish **thành công**. **(Assumption QC/test lead, tin cậy CAO — Q-9.)** | P2 |
| STE-12 | Publish body — trên biên | Body ~65,537 byte | `413`; thông báo chung, không phân biệt được là `413` nếu không có proxy. **(Assumption QC/test lead, tin cậy CAO — Q-9.)** | P2 |
| STE-13 | `template.template` — dưới biên | JSON string ~49,151 byte | Publish **thành công**. **(Assumption QC/test lead, tin cậy CAO — Q-9.)** | P2 |
| STE-14 | `template.template` — tại biên | JSON string ~49,152 byte (= 48 KB) | Publish **thành công**. **(Assumption QC/test lead, tin cậy CAO — Q-9.)** | P2 |
| STE-15 | `template.template` — trên biên | JSON string ~49,153 byte | `400 invalid_template`; thông báo chung, không phân biệt được nếu không có proxy. **(Assumption QC/test lead, tin cậy CAO — Q-9.)** | P2 |
| STE-16 | Ảnh/share — dưới biên | Design có 19 ảnh `shared:` | Publish **thành công**, máy B thấy đủ 19 ảnh (không thiếu) — ứng với TS-33. **(Assumption QC/test lead, tin cậy CAO — Q-9.)** | P2 |
| STE-17 | Ảnh/share — tại biên | Design có 20 ảnh `shared:` | Publish **thành công**, máy B thấy đủ 20 ảnh. **(Assumption QC/test lead, tin cậy CAO — Q-9.)** *Dùng chung data này cho `STM-02` (TS-91 — end-to-end design nặng), không cần dựng lại* | P2 |
| STE-18 | Ảnh/share — trên biên | Design có 21 ảnh `shared:` | `400 invalid_template`; thông báo chung, không phân biệt được nếu không có proxy. **(Assumption QC/test lead, tin cậy CAO — Q-9.)** | P2 |

---

## 6 · Mở link / nhận (máy B) · `TC-STF` (mục 2 test plan, nguồn VI §7 + API §3.3/§Links — EP)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| STF-01 | Máy B: app **đang chạy**, mở `ink://template?id=<id hợp lệ, tồn tại>` | Màn **"Shared template"**: ảnh xem trước, **tên design**, nút **Add to my collection** | **P1** |
| STF-02 | Máy B: **tắt hẳn app** (cold start) → mở cùng link | Qua splash/paywall rồi **vẫn** hiện màn "Shared template" (deeplink không bị mất) | **P1** |
| STF-03 | Máy B **chưa đăng nhập** → mở link → bấm Add | Mở và **thêm được**, **không** hiện yêu cầu tài khoản. ⚠️ Free/Pro của máy chưa đăng nhập: xem nhánh entitlement ở `STG-02/03` (TB-15) | **P1** |
| STF-04 | Mở link của design có id **đã biết trong catalog** máy B, template có **tuỳ chỉnh Pro** thật | Badge **PRO** hiện đúng theo cờ Pro thật. **(Assumption QC/test lead, tin cậy CAO — Q-7.)** | P2 |
| STF-05 | Mở link của design có id **đã biết**, template **không** có tuỳ chỉnh Pro | **Không** có badge PRO. **(Assumption QC/test lead, tin cậy CAO — Q-7.)** | P2 |
| STF-06 | Mở link của design 6 (`stack`, **không** `origin_template_id` — id lạ với máy B) | Badge **luôn** hiện **PRO**, bất kể design có tuỳ chỉnh Pro hay không. **(Assumption QC/test lead, tin cậy CAO — Q-7.)** | P2 |
| STF-07 | Màn "Shared template" → bấm **✕** | Đóng màn, **không** thêm gì vào collection | P3 |
| STF-08 | (Cần mock/proxy đổi response — nếu không có, descope) Ép `preview_url`/`assets` trả về host **lạ** (không phải `inkcalendar.app`/`assets.homebod.ai`) | Host lạ bị **drop/reject**, không hiển thị/nạp ảnh từ host đó. Nếu không có mock sẵn sàng lúc execute → **không thực thi được — thiếu phương tiện (TB-23/O-11)** | P2 |
| STF-09 | (Cần mock/proxy) Ép `data.schema` cao hơn build hỗ trợ, hoặc `layout_kind` lạ | Hiện **"Update Ink"**, không crash/không màn trắng. Nếu không có mock → **không thực thi được — thiếu phương tiện (TB-23/O-11)** | P2 |
| STF-10 | Mở link của 1 share có `preview_url = null` (ví dụ share chưa kịp upload preview) | **Fallback về artwork catalog** của `data.template`, không ảnh hỏng | P2 |
| STF-11 | Mở `ink://template?id=<sai định dạng>` kèm **query param lạ** (ví dụ `&foo=bar`) | *Template unavailable*; app **không** honour param nào khác ngoài `id` đã validate | P2 |
| STF-12 | Trên cùng máy, mở lần lượt 1 link template `inkcalendar.app` và 1 link share **lịch** (cùng host, khác dạng) | Link template được **parse trước**, vào đúng màn "Shared template", **không** bị luồng calendar-share bắt nhầm | P2 |

---

## 7 · Add to my collection (máy B) · `TC-STG` (mục 2 test plan, nguồn VI §8 + API §3.4 — EP + 2-value BVA + Error guessing)

| ID | Precondition | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|---|:---:|
| STG-01 | Máy B Free, collection trống/ít | Mở link, bấm **Add to my collection** | Toast *"Added to your collection"*, design xuất hiện **đầu** "Your collection" | **P1** |
| STG-02 | Máy B Free, collection đã có **4** design *(⚠️ giả định tạm: chỉ đếm wallpaper, chưa xác nhận với dev — TB-15/O-4)* | Add 1 design nữa | Thành công, collection thành **5** | **P1** |
| STG-03 | Máy B Free, collection đã có **5** design (tại biên) *(cùng giả định tạm TB-15/O-4)* | Add 1 design nữa | *"Collection is full"* kèm **Go Pro**/**Cancel**; xoá bớt 1 design rồi Add lại → **thành công** | **P1** |
| STG-04 | Máy B đổi sang account **Pro**, collection đã **>5** design | Add 1 design nữa | Add được, **không** bị chặn dù đã hơn 5 | P2 |
| STG-05 | Máy B Free, design có ảnh riêng, đã Add | **Tắt mạng** sau khi Add, mở lại item | Ảnh **vẫn hiện** (bytes đã lưu vào storage app, không tham chiếu URL) | **P1** |
| STG-06 | (Cần mock/can thiệp bytes nếu muốn ép ảnh rác thật) | Add design có ảnh tải về **không decode được PNG/JPEG đúng** hoặc >2MB | Ảnh rác bị **loại**, item **không hỏng** vì ảnh rác đó | P3 |
| STG-07 | Máy B mở **cùng 1 link** 2 lần | Add cả 2 lần | Có **2 bản copy riêng** trong collection | P3 |
| STG-08 | Máy B đã Add design 2 | Máy A **sửa và share lại** design 2 | Bản máy B **đã Add trước đó không đổi** (bản copy là bất biến) | **P1** |
| STG-09 🔭⚠️ | Máy B đang Add design nhiều ảnh | Giữa lúc tải ảnh (ảnh thứ n), **tắt mạng** hoặc ép ảnh 404 | Oracle **chắc** duy nhất: **KHÔNG** được để lại item nửa vời trong collection, có thông báo rõ. Phần còn lại (rollback hay giữ item không ảnh) — **phải quan sát/ghi lại**, không giả định trước (TB-29/O-16) | **P1** |

---

## 8 · Set as current & Pro gate (máy B) · `TC-STH` (mục 2 test plan, nguồn VI §9 + API §3.3 — Decision Table)

> **Decision Table — copy đúng 4 rule DT-H1→DT-H4 của test plan.** `Có customization Pro thật?` chỉ áp
> dụng khi id nhận diện được; id lạ **luôn** coi là Pro bất kể nội dung.

| ID | Rule | Id nhận diện được ở catalog local? | Có customization Pro thật? | Entitlement máy B | Kết quả mong đợi | Ưu tiên |
|---|---|---|---|---|---|:---:|
| STH-01 | DT-H1 | Có | Không | Free | Set as current chạy bình thường, **không** paywall. **(Assumption QC/test lead, tin cậy CAO — Q-7.)** | **P1** |
| STH-02 | DT-H2 | **Không** (dùng design 6) | *(không áp dụng — luôn coi Pro)* | Free | Set as current **luôn** hiện **paywall**, bất kể design có customization hay không. **(Assumption QC/test lead, tin cậy CAO — Q-7.)** | **P1** |
| STH-03 | DT-H3 | Có | **Có** (design 5) | Free | **Add** vẫn được, nhưng **Set as current** hiện **paywall**. **(Assumption QC/test lead, tin cậy CAO — Q-7.)** | **P1** |
| STH-04 | DT-H4 | Có | Có (design 5) | **Pro** | Set as current chạy bình thường, **không** paywall | P2 |
| STH-05 | — | Có/Không | — | Free | (Cần mock/proxy sửa cờ Pro trong response) Ép response trả cờ Pro **sai** (vd báo Free khi template Pro, hoặc ngược lại) | App **không tin** cờ Pro trong share — quyết định Pro **luôn** từ catalog local theo id (đúng STH-01→03). **(Assumption QC/test lead, tin cậy CAO — Q-7.)** Nếu không có mock → chỉ kiểm được **gián tiếp** qua STH-01→03 (không chứng minh được app *cố tình* bỏ qua cờ sai, chỉ chứng minh hành vi đúng trong điều kiện bình thường) — ghi là **giới hạn coverage**, không phải fail | P2 |
| STH-06 | — | — | — | Free hoặc Pro (đã Set as current xong) | Add + Set as current → chạy Shortcut → khoá máy, chụp ảnh **lock screen thật** | Giống bản xem trước về **style/bố cục**; **dữ liệu sự kiện/calendar là của máy B** — **không bao giờ** sự kiện mẫu của preview hay dữ liệu máy A. **(Assumption QC/test lead, tin cậy CAO — Q-8.)** Đối chiếu ảnh lock screen thật với preview trong app (nối `03_shortcut-setup`/`10_lockscreen`). *Calendar nào của máy B được bind cụ thể — không ảnh hưởng pass/fail, chỉ ghi chú (O-22)* | **P1** |

---

## 9 · Lỗi, offline, hạn mức · `TC-STI` (mục 2 test plan, nguồn VI §10 + API §Errors — EP, BVA descope cho rate limit)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| STI-01 | Mở `ink://template?id=abc123` (id không tồn tại) | *"Template unavailable"* / *"This template was removed, or the link is incomplete."* | P2 |
| STI-02 | **Tắt mạng** rồi mở link đúng của 1 design đã share | *"Couldn't load this template. Check your connection and try again."*; **bật mạng rồi thử lại** → mở được | P2 |
| STI-03 | **Tắt mạng** rồi bấm Share trên wallpaper **chưa từng** share | *"Couldn't create a share link. Try again."*, **không** share sheet. ⚠️ Nhánh "wallpaper **đã** share, có cache" khi offline (expected result khác — có thể phát lại link cũ từ cache, TB-17) **chưa có oracle rõ, không viết case cho nhánh đó** — chỉ ghi nhận nếu gặp | P2 |
| STI-04 | (Cần script/seed tạo đủ 29 publish trước) Thực hiện publish thứ **30** rồi thứ **31** trong ngày | Thứ 30: thành công (tại biên). Thứ 31: `429 rate_limited`, thông báo chung, không crash. Nếu **không có script** trước giờ execute → **không thực thi được — thiếu phương tiện (TB-27/O-20)**, không làm tay (khoá account tới 00:00 UTC) | P3 |
| STI-05 | (Khó chủ động — cần mock lỗi `502`/`400` giữa chừng) Sau 1 lần publish lỗi, mở lại bản cũ trên máy B | Máy B vẫn mở được **bản cũ** (publish lỗi không làm hỏng link đang có). Nếu không ép lỗi được chủ động → chỉ ghi nhận khi lỗi mạng **tự nhiên** xảy ra trong lúc test, ghi "chưa thử được chủ động", không tính pass | P2 |
| STI-06 | Mở link có 1 asset trả **404** (ảnh đã bị xoá/chưa attach — có thể dựng bằng cách xoá asset qua cách hợp lệ nếu có, hoặc quan sát tự nhiên) | Màn "Shared template" vẫn dùng được với fallback, **không treo** | P3 |
| STI-07 | (Cần mock `502` storage giữa chừng upload) Ép upload lỗi `502` khi đang publish nhiều ảnh | App **không** publish nửa vời (không ra link thiếu ảnh), hiện lỗi chung, cho thử lại. Nếu không ép được → ghi "chưa thử được chủ động" | P2 |

---

## 10 · Xoá tài khoản (máy A) · `TC-STJ` (mục 2 test plan, nguồn VI §11 + API §Account deletion — dùng lại State Transition của `ST-D`, T6/T7)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| STJ-01 | Máy A: Settings → xoá tài khoản (sau khi đã share ≥1 wallpaper, L1) → mở link cũ trên máy B → sau đó máy A tạo/đăng nhập **account mới** và Share lại **cùng** wallpaper | Mở link cũ: **"Template unavailable"**. Share lại: app phát **link MỚI** (id khác), **không** phát lại link đã chết. **(Assumption QC/test lead, tin cậy TRUNG BÌNH — Q-10, kết hợp Q-1 — tin cậy CAO — app không có đường thu hồi link khác ngoài xoá tài khoản.)** Nếu app **vẫn** phát lại link cũ → **bug (lỗi im lặng)**, báo ngay theo mục 8.1 test plan trước khi tiếp tục cụm `ST-D`/`ST-J` | **P1** |
| STJ-02 | Sau STJ-01, thử tải ảnh của share cũ qua URL asset đã ghi lại trước đó | URL asset trả **`404`** — ảnh thật sự không tải được nữa | **P1** |
| STJ-03 | Máy B đã **Add** design từ máy A **trước khi** máy A xoá tài khoản | Sau khi máy A xoá tài khoản | Bản copy trên máy B (mở từ chính "Your collection" của máy B, không qua link) **vẫn còn** và **vẫn dùng được** | P2 |

> ⏸ **Không viết case cho TS-69** (trang web `/t/<id>` chuyển sang unavailable ≤60s) — thuộc nhóm `ST-L`,
> **hoãn khỏi slug `1-2-19`** theo Q-2 (APP-ONLY), chạy ở slug mới khi FE xác nhận trang live (O-23).

---

## 11 · Ngôn ngữ (app, không phải trang web) · `TC-STK` (mục 2 test plan, nguồn VI §12 + API §3.2 `lang` — EP, descope có điều kiện)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| STK-01 | Đổi app sang **Tiếng Việt** → đi qua đủ 5 màn mới: Share, "Share your photos too?", "Share this text?", "Shared template", "Template unavailable" | Dịch đủ, **không sót** chuỗi tiếng Anh, **không bị cắt chữ**. ⚠️ Chưa có baseline ảnh để đối chiếu bố cục khách quan (TB-12) — đánh giá "không bị cắt" vẫn là cảm tính ở lần chạy đầu, dùng ảnh chụp lần này làm baseline cho lần sau | **P1** |
| STK-02 | **Trước khi chạy:** kiểm Settings → Language của build thật có **Arabic** hay không | Nếu **có** Arabic: đổi sang Arabic, kiểm 5 màn trên hiển thị đúng chiều phải→trái, không cắt chữ, không lệch icon. Nếu **không có** Arabic trong Settings → **loại Arabic khỏi lần chạy này**, ghi nhận "không thực thi được — Arabic chưa ship (O-2/TB-13)", **không** coi là fail | P2 |
| STK-03 | Đổi app sang 1 ngôn ngữ cụ thể (vd `vi`) → Share 1 design → (cần proxy để xem request) kiểm `lang` gửi lên publish | `lang` = ngôn ngữ app đang dùng. **(Assumption QC/test lead, tin cậy CAO — Q-4 — `lang` chỉ là hint/fallback cho trang web, không "khoá" ngôn ngữ trang.)** Nhánh "giá trị sai định dạng → server fallback `en`" **không kiểm được từ UI chuẩn** — chỉ kiểm được nếu có proxy sửa request, nếu không → ghi "không thực thi được từ UI" | P3 |

---

## 12 · Xuyên suốt / phi chức năng · `TC-STM` (mục 2 test plan, nguồn API §Basics/§Limits/§Ids/§Links — hỗn hợp)

| ID | Bước thực hiện | Kết quả mong đợi | Ưu tiên |
|---|---|---|:---:|
| STM-01 | Share 1 design trên mạng bình thường, bấm Share, đo cảm quan thời gian tới khi share sheet mở | **Chỉ tiêu chí định tính** (không có SLA định lượng — TB-24/O-15): share sheet cuối cùng **mở ra**, UI **không treo vô hạn**. Không log bug về tốc độ nếu không vượt ngưỡng định tính này | P2 |
| STM-02 | Dùng data tại biên của `STE-17` (design 20 ảnh, body gần 64 KB) → Share đầy đủ rồi Add trên máy B | Share + Add **thành công end-to-end** với design nặng. **(Assumption QC/test lead, tin cậy CAO — Q-9.)** | P2 |
| STM-03 | Chạy lại smoke tối thiểu (TS-36, TS-46, TS-58) trên **2 iPhone thật**, bản iOS công khai mới nhất | Hành vi đúng như case tương ứng (`STF-01`, `STG-01`, `STH-06`) trên cả 2 máy. **iPad: descope tường minh** (mục 7 test plan) — **không** chạy, ghi là coverage gap đã biết, không phải bỏ sót | P2 |
| STM-04 | `curl` route **cần** App Check nhưng **thiếu** Bearer (publish/upload/list/stop) và route **không cần** Bearer (đọc share 3.3, tải ảnh 3.4) theo lệnh mẫu API §Testing | Route cần Bearer: lỗi xác thực tương ứng (không phải `401 app_check_failed` nếu App Check hợp lệ nhưng thiếu Bearer — ghi nhận đúng lỗi quan sát được). Route không cần Bearer: trả dữ liệu bình thường (`200`) không cần header đặc biệt | P2 |
| STM-05 | `curl` gọi route đọc share với id **sai định dạng** (không khớp `[A-Za-z0-9_-]{1,64}`) | App (và route public) từ chối/validate đúng trước khi dùng id để dựng link hay gọi tiếp — không crash, không hiện dữ liệu của id khác | P2 |
| STM-06 | Sau khi publish, so sánh link mà app build (share sheet) với `page_url` trả về trong response `201/200` | App build link **đúng** `https://inkcalendar.app/t/<id>` **tự dựng** từ `id` đã validate, **bỏ qua** `page_url` của server (kể cả khi 2 giá trị có vẻ giống nhau, không dùng trực tiếp field đó) | P2 |
| STM-07 🔭 | Share 1 design → mở share sheet iOS → dùng "Copy"/xem preview của share sheet để liệt kê đầy đủ nội dung | **Phải quan sát/ghi lại**: share sheet chỉ gồm link (và tiêu đề nếu có), hay có kèm gì khác (ảnh/attachment/dữ liệu cá nhân). **Không có oracle rõ "những gì khác URL"** (TB-26/O-17) — chỉ **log bug chắc chắn** nếu thấy ảnh/dữ liệu cá nhân kèm theo, phần còn lại chỉ ghi nhận | P2 |

> ⛔ **Không viết case cho TS-93** (App Check bắt buộc trên mọi call) — **out of scope đợt `1-2-19`, dev tự
> verify** theo Q-3 (answers §B-Q3). Giữ nguyên ngoài bộ test case này.

---

## Ghi chú đối soát với test plan (không tự sửa test plan, chỉ ghi nhận để báo cáo)

1. **TS-05, TS-15, TS-90 bị thiếu khỏi danh sách liệt kê theo tên ở mục 6 test plan** (cả 3 named-list P1/P2/P3
   không nhắc tới chúng, trong khi mục 2 test-plan khẳng định tổng P1=34/P2=37/P3=8 và test-analysis mục 2 đã
   tính risk cho cả 3 là **P2**). Case ở đây (`STA-05`, `STC-04` phần chính, `STM-01`) dùng **P2** lấy từ
   test-analysis — không tự đặt priority mới, chỉ điền vào chỗ bị bỏ sót khi liệt kê theo nhóm.
2. **TS-24 (ST-D) — gap đã đóng 2026-10-02.** Bảng State Transition của `ST-D` ban đầu thiếu transition
   cho TS-24; `qc-test-plan` đã bổ sung **T3b** (xem changelog cuối phần `ST-D` trong test plan). Case
   `STD-07` đã được viết theo đúng `T3b`, chèn giữa `STD-02` (T3) và `STD-03` trong bảng mục 4. 79/79
   condition trong phạm vi nay đã có case tương ứng (trước đó 78/79, thiếu TS-24).
3. Không có case nào khác bị bỏ ngoài 79 condition trong phạm vi, trừ điểm #1 ở trên (đã xử lý bằng P2 lấy
   từ test-analysis, không phải case bị thiếu).
