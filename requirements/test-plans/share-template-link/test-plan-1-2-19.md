# Test Plan — Chia sẻ template bằng link (Ink Prod **1.2.19**) · slug `1-2-19`

> **Test basis (3 file, cùng một luồng end-to-end):**
> 1. [template-sharing-vi.md](../../specs/share-template-link/template-sharing-vi.md) — checklist QC tiếng
>    Việt, hành vi app nhìn từ user (máy A gửi / máy B nhận). Mã trích dẫn: `VI §N.MM`.
> 2. [fe-template-share-page.md](../../specs/share-template-link/fe-template-share-page.md) — spec dev cho
>    team web (fe-ink-calendar), trang `/t/<id>` trên `inkcalendar.app`. Mã: `FE §N`.
> 3. [template-sharing-api.md](../../specs/share-template-link/template-sharing-api.md) — API contract app ↔
>    Worker (live production). Mã: `API §3.x`.
>
> **Input chính (bắt buộc theo skill `test-plan` mục 1):**
> [test-analysis-1-2-19.md](test-analysis-1-2-19.md) — **Analysis Status: `READY`**, **Downstream
> Permission: `ALLOWED`** (chuyển bởi **User/QC-test-lead**, 2026-10-02 — đã tự kiểm lại banner đầu file,
> **không** phát hiện mâu thuẫn với lời orchestrator báo "đã READY"; đối chiếu thêm với
> [answers-1-2-19.md](answers-1-2-19.md) trước khi dùng — đã đọc toàn bộ cả hai file này trước khi viết
> test plan). 98 test condition đã ưu tiên hoá (mục 2 test-analysis) + 30 vấn đề testability (TB-01→TB-30,
> 0 còn CHẶN, 20 còn MỞ) + 24 câu hỏi mở (O-1→O-25, trừ O-21 đã chốt) + 10 quyết định của QC/test lead
> (8 assumption + 2 out-of-scope, mức tin cậy khác nhau) — **toàn bộ mang nguyên sang file này**, không
> được coi là đã đóng.
>
> **Chuẩn:** ISTQB Foundation Level v4.0.1 (test basis → test object → kỹ thuật thiết kế → rủi ro →
> entry/exit), [§5.1.3](../../istqb-foundation/ISTQB_CTFL_Syllabus_v4.0.1.md) (Entry/Exit),
> §5.2 (Risk Management), §4.1–4.2/4.4 (kỹ thuật thiết kế).
>
> **Test case cụ thể:** `test-cases-1-2-19.md` — sẽ sinh bởi skill `test-case` sau khi test plan này được
> duyệt bởi orchestrator (chỉ khi Test Plan Status dưới đây = READY).
>
> **Đối chiếu tài liệu đã có:** đây là **feature hoàn toàn mới** (chưa từng build trước 1.2.19) — **không
> có** test-plan/wireframe/exploratory checklist/bug-log cũ nào của chính feature này để đối chiếu. Cũng
> **không** có `flow-no` nào trong [`.claude/rules/screenshot-naming.md` §7](../../../.claude/rules/screenshot-naming.md#7-flow-map--ink-calendar-ios)
> cho "share template qua link" — xem mục 1 và mục 7 dưới đây. Đối chiếu duy nhất khả dụng là chính cặp
> test-analysis + answers ở trên.
>
> **Ngày lập:** 2026-10-02 · **Người lập:** QC (agent `qc-test-plan`)

---

## 0. Test Plan Status

> **`READY`** — 79/79 test condition trong phạm vi đợt `1-2-19` đã có oracle (kể cả 2 oracle TẠM, mức
> tin cậy THẤP, xem mục 6/10) và kỹ thuật thiết kế (mục 5). **Không có** gap nào ở mục 10 trùng 1 trong 5
> lý do dừng bắt buộc của skill `test-plan` mục 0 (test basis thiếu/mơ hồ/mâu thuẫn ảnh hưởng scope-risk ·
> nhiều version không rõ nguồn sự thật · không đủ info P1/P2-P3 · không chắc kỹ thuật thiết kế · scope rộng
> bất thường) — toàn bộ các câu hỏi còn mở (O-1→O-25 trừ O-21) chỉ ảnh hưởng **độ chi tiết của oracle**
> hoặc **khả năng thực thi** (thiếu mock/proxy, thiếu device matrix, thiếu baseline ảnh), **không** đổi
> **tập 79 condition** hay **mức ưu tiên P1/P2/P3** đã được phê chuẩn (O-21). 5 điểm (O-9, O-11, O-14,
> O-15, O-20) mà `test-analysis` chuyển giao cho bước này đã được **quyết định rõ ràng hoặc descope tường
> minh** ở mục 7/8/9 dưới đây — **không** để im lặng.
>
> **Điều kiện đi kèm (không đổi gì về status, nhưng bắt buộc mang xuống `test-case`):**
> mọi oracle dùng assumption của QC/test lead (18 condition) **phải** giữ đúng nhãn mức tin cậy
> (**CAO** / **TRUNG BÌNH** / **THẤP**) — **không** trình bày ngang hàng; đặc biệt **TS-14 (phần nền)** và
> **TS-15** dùng oracle **TẠM** (Q-6, tin cậy THẤP) phải được đánh dấu rõ trong mọi case sinh ra từ đó.
>
> **Cập nhật 2026-10-02 (sau khi `qc-test-case` phát hiện gap thật ở mục 5 `ST-D`):** bảng State
> Transition `ST-D` **thiếu transition** cho **TS-24** (P1, Rất cao). Đã bổ sung **đúng 1 transition
> (`T3b`)** — xem changelog ở cuối phần `ST-D` trong mục 5. Đây **không** phải gap loại ảnh hưởng
> scope/priority (TS-24 vốn đã nằm trong tập 79 condition và đã có P1/Rất cao từ `test-analysis`, chỉ
> thiếu phần ánh xạ sang state machine) — **không** trùng 1 trong 5 lý do dừng bắt buộc của skill
> `test-plan` mục 0. **Test Plan Status giữ nguyên `READY`** sau bổ sung này; `qc-test-case` có thể viết
> tiếp case cho TS-24 ngay.

---

## 1. Phát hiện khi đối chiếu với tài liệu đã có

Vì đây là feature mới, "đối chiếu tài liệu đã có" ở đây là đối chiếu **nội bộ 3 file test basis** (đã làm
ở `test-analysis`) và đối chiếu với **quy ước chung của repo**:

1. **Không có flow-no cho feature này.** [`screenshot-naming.md` §7](../../../.claude/rules/screenshot-naming.md#7-flow-map--ink-calendar-ios)
   liệt kê flow `01`→`14`; share template qua link không khớp flow nào (flow `11_share` là share **lịch**
   Phase 2, khác feature — đã xác nhận bởi A-8 ở test-analysis). Theo mục 2 của rule ("luôn lấy số tiếp
   theo, không chèn giữa"), số kế tiếp khả dụng hiện tại là **`15`**. **Đây là đề xuất của QC, không phải
   quyết định đã có hiệu lực** — việc mint flow-no chính thức và cập nhật `screenshot-naming.md` cần
   người giữ rule (chủ repo) xác nhận; agent `qc-test-plan` **không có quyền** sửa file rule đó. Xem mục 7
   (environment) và mục 10 (gap O-9) để biết cách xử lý khi chưa có quyết định chính thức.
2. **10 quyết định của QC/test lead ở `answers-1-2-19.md` thay thế kết luận "đang chờ dev"** của bản
   test-analysis gốc (trước 2026-10-02). Không có version cũ nào của chính `test-plan` này bị thay thế —
   đây là lần lập test plan **đầu tiên** cho slug `1-2-19`. Nếu dev trả lời khác ở **O-24**/**O-25** sau
   này, bản test-plan này phải được sửa lại tại chỗ (không mint slug mới chỉ vì sửa oracle, theo đúng quy
   ước "slug mới chỉ khi spec đổi thật", `.claude/CLAUDE.md`), **trừ khi** việc sửa đó kéo theo đổi hẳn
   scope (ví dụ Q-1 sai → mở lại UI "link của tôi"/"ngừng share" → khi đó mới cần slug mới theo đúng tiền
   lệ `ios26-27` → `ios26-27-v2`).
3. **Mâu thuẫn văn bản trong 3 file test basis vẫn CHƯA được dev sửa** (TB-01 API §Section numbers ↔ VI
   §KN.2; TB-04 API §3.2 ↔ FE §7; TB-06 "nền template hoặc catalog"; TB-10 API §3.9 ↔ §Account deletion).
   QC/test lead đã chọn cách hiểu để đi tiếp (xem mục 6), nhưng **văn bản gốc vẫn mâu thuẫn** — nếu dev sau
   này sửa tài liệu theo hướng khác, phải rà lại toàn bộ case bắt nguồn từ các TB này.

---

## 2. Test object — In scope

> Mã nhóm (`ST-A` → `ST-M`, bỏ `ST-L`) lấy theo gợi ý ở mục 3 (traceability nháp) của `test-analysis`, giữ
> nguyên để không lệch truy xuất nguồn gốc. Dùng làm tiền tố ID cho `test-case` (vd `STA-01`).

| # | Mã | Hạng mục | Test condition | Nguồn | Trong phạm vi |
|---|---|---|---|---|---|
| 1 | `ST-A` | Điểm vào nút Share | TS-01 → TS-06 | VI §1 | 6/6 |
| 2 | `ST-B` | Cổng đăng nhập (sign-in gate) | TS-07 → TS-11 | VI §2, API §Identity/§Errors | 5/5 |
| 3 | `ST-C` | Hộp thoại xin phép ảnh/chữ | TS-12 → TS-20 | VI §3, §4, §5 | 9/9 |
| 4 | `ST-D` | "Mỗi wallpaper một link" (link identity) | TS-21 → TS-26 | VI §6, API §3.2/§The model | 6/6 |
| 5 | `ST-E` | Vệ sinh payload & riêng tư khi publish | TS-27 → TS-35 | API §3.1, §3.2 | 9/9 *(TS-27: trừ phần `preview_url` công khai — out of scope)* |
| 6 | `ST-F` | Mở link / nhận (máy B) | TS-36 → TS-45 | VI §7, API §3.3/§Links | 10/10 *(vào qua `ink://`, không qua https thật)* |
| 7 | `ST-G` | Add to my collection (máy B) | TS-46 → TS-53 | VI §8, API §3.4 | 8/8 |
| 8 | `ST-H` | Set as current & Pro gate (máy B) | TS-54, TS-54b, TS-55 → TS-58 | VI §9, API §3.3 | 6/6 |
| 9 | `ST-I` | Lỗi, offline, hạn mức | TS-59 → TS-65 | VI §10, API §Errors/§Limits | 7/7 |
| 10 | `ST-J` | Xoá tài khoản (máy A) | TS-66 → TS-68 | VI §11, API §Account deletion | 3/3 *(TS-69 hoãn — xem mục 3)* |
| 11 | `ST-K` | Ngôn ngữ (app, không phải trang web) | TS-70 → TS-72 | VI §12, API §3.2 `lang` | 3/3 |
| 12 | `ST-M` | Xuyên suốt / phi chức năng | TS-90 → TS-97 | API §Basics/§Limits/§Ids/§Links | 7/8 *(TS-93 out of scope — xem mục 3)* |

**Tổng trong phạm vi: 79 condition — P1 = 34 · P2 = 37 · P3 = 8** (khớp đúng số của `test-analysis` mục
2 "Tổng hợp số lượng" — test-plan **không đổi** số này).

---

## 3. Out of scope

| Hạng mục | Lý do |
|---|---|
| **Nhóm `ST-L` — trang web `/t/<id>`** (17 condition TS-73 → TS-89, gồm TS-88) + **TS-69** | **Hoãn** khỏi slug `1-2-19` theo quyết định **Q-2** (APP-ONLY, assumption đã xác nhận bởi QC/test lead, không phải fact PM — xem A-10). Chạy ở **slug mới** khi FE xác nhận trang `/t/<id>` đã live (điều kiện tiền đề — **O-23**). **Không** được tính vào exit criteria của `1-2-19` (yêu cầu bắt buộc #2 của caller) |
| **TS-93** (App Check bắt buộc trên mọi call) | **Out of scope — dev tự verify** (quyết định **Q-3**, A-15). Môi trường QC đợt này chốt theo VI §0.1, không mở rộng sang kiểm App Check đa build |
| **Phần "ảnh preview công khai" của TS-14, TS-27** | **Out of scope — dev tự verify** (quyết định **Q-5**, A-16). QC **không** kết luận preview có/không chứa ảnh riêng — đây là **coverage gap đã biết**, không phải thiếu sót của QC (yêu cầu bắt buộc #2 của caller). Phần **design data** (`asset_ids = []`) của TS-14 **vẫn trong phạm vi ST-C** |
| **GAP-8 — nhánh `410` (moderation chưa build)** | **Parked** — TB-22, không có cách tạo dữ liệu (moderation chưa tồn tại). 1 condition P3, không tính vào coverage |
| **UI "link của tôi" (API §3.8) / "ngừng share" (API §3.9)** | Theo **Q-1 (tin cậy CAO)**: app 1.2.19 không có UI này ⇒ không sinh test case UI. Có thể kiểm bằng `curl` ở nhóm `ST-M` nếu còn thời gian, **tuỳ chọn, không bắt buộc** (xem mục 9) |
| **Flow `11_share` (share lịch/co-edit), `12_ai-assistant`, `13_community`** | Phase 2, chưa build (A-8) — không liên quan feature này |
| **Dark Mode** | Project chưa hỗ trợ Dark Mode (ghi nhận chuẩn của repo) — không tính là coverage gap |
| **Logic chọn event hiển thị trên wallpaper, thuật toán render lịch** | Không thuộc feature share — chỉ liên quan ở mức "dữ liệu nào được strip trước khi publish" (đã có trong `ST-E`), không kiểm thuật toán chọn event |

### 3.1 Ảnh hưởng chéo tới flow khác (regression impact ngoài phạm vi note)

> Đối chiếu [screenshot-naming.md §7](../../../.claude/rules/screenshot-naming.md#7-flow-map--ink-calendar-ios).

| Flow | Ảnh hưởng? | Lý do |
|---|---|---|
| `04_discover` | **Trực tiếp** | "Your collection" (nơi có nút Share, menu giữ tay, nút ⬆︎) nằm trong flow này (`screen-name: collection`) — mọi entry point của `ST-A` sống ở đây |
| `08_paywall` | **Trực tiếp** | `ST-H` (Pro gate) kích hoạt đúng màn paywall khi Set as current bị chặn (TS-54b, TS-55) — paywall không phải feature riêng của share, nhưng được **gọi lại** từ đây, phải đúng nội dung/hành vi paywall đã test ở flow đó |
| `14_edit-wallpaper` | **Gián tiếp** | 5 design mẫu dùng để test (VI §0.7: ảnh riêng, sticker, text sticker, Pro customization…) được tạo bằng editor của flow này; bug ở editor (vd sticker không tính là "ảnh riêng" đúng cách) sẽ lộ ra như false-negative ở `ST-C`, không phải bug của share |
| `03_shortcut-setup` | **Gián tiếp** | Wallpaper máy B áp dụng xong (`ST-H`, TS-58) lên màn khoá **thật** qua đúng cơ chế Shortcut đã QC ở [test-plan-ios26-27.md](../shortcuts/test-plan-ios26-27.md) — nếu Shortcut hỏng, TS-58 fail nhưng root cause có thể không liên quan share |
| `10_lockscreen` | **Gián tiếp** | Kết quả cuối của TS-58 hiện ở đây (ngoài app) — cần ảnh chụp màn khoá thật để kết luận pass/fail, không chỉ tin app báo "Applied" |
| `09_settings` | **Gián tiếp** | Xoá tài khoản (`ST-J`, TS-66 → TS-68) khởi động từ Settings; đăng xuất/đổi account (nhánh mới sinh từ Q-10, TS-26) cũng vậy |
| `07_note` | **Gián tiếp, nhẹ** | TS-04 verify item Note **không** có mục Share trong menu giữ tay — regression nhẹ cho menu giữ tay của Note, không phải nội dung note |
| `06_task` | **Không ảnh hưởng** | Không có entry point, không data pipeline dùng chung với share template |
| `01_onboarding`, `02_permission`, `05_calendar` | **Không ảnh hưởng** | Không entry point; lịch (calendar) chỉ xuất hiện gián tiếp qua "sự kiện mẫu" trong preview (đã strip dữ liệu thật — `ST-E`), không phải tương tác trực tiếp với flow Calendar |
| `11_share` (share lịch, Phase 2) | **Không áp dụng đợt này** | Khác feature; chỉ chạm nhau ở TS-88 (regression `/share/<id>`) — **đã hoãn** cùng nhóm `ST-L` |
| `12_ai-assistant`, `13_community` | **Không áp dụng** | Chưa build (Phase 2) |

---

## 4. Test levels & test types

- **Level:** System testing, black-box, trên **2 thiết bị iPhone thật**, chỉ cài **Ink Prod 1.2.19**
  (VI §0.1 — simulator/Dev **không** share được vì App Check + backend chỉ nhận Ink Prod). Gọi trực tiếp
  **API production** (`template-sharing-api.md` chỉ công bố 1 Base URL, không có staging) — không có
  integration test ở layer thấp hơn UI, trừ phần dùng `curl`/proxy ở `ST-E`/`ST-M` (xem mục 7).
- **Functional:** toàn bộ `ST-A` → `ST-D`, phần lớn `ST-F`/`ST-G`/`ST-H`/`ST-I`/`ST-J`/`ST-K` — hành vi
  quan sát được trực tiếp từ UI của 2 máy.
- **Non-functional (ISO 25010):**
  - **Security:** `ST-E` (payload hygiene — strip device state, strip EXIF, host allow-list), phần lớn
    `ST-F` (untrusted response — host allow-list, schema version, Pro flag không tin từ share), `ST-H`
    (TS-57 — không tin Pro flag), `ST-J` (TS-67 — ảnh chết sau xoá tài khoản), `ST-M` (TS-94 → TS-97 —
    Identity/Ids/share-sheet payload). Đây là nhóm **rủi ro cao nhất** của toàn bộ feature (dữ liệu công
    khai không chủ ý).
  - **Reliability:** `ST-B` (TS-11 — App Check retry), `ST-D` (TS-21/22/26 — publish không bao giờ làm hỏng
    link đang có), `ST-F` (TS-37 — deeplink sống sót qua cold start), `ST-G` (TS-49/53 — ảnh offline vẫn
    hiện / Add thất bại giữa đường không để lại item nửa vời), `ST-I` (toàn bộ — lỗi/offline/hạn mức).
  - **Performance efficiency:** `ST-M` (TS-90/91 — thời gian tạo link, design nặng) — **không có SLA định
    lượng trong test basis** (TB-24/O-15) → xem mục 9 (descope tường minh phần định lượng).
  - **Usability / Interaction capability:** `ST-K` (TS-70/71 — dịch đủ, không cắt chữ, RTL), `ST-F`
    (TS-36/40 — màn *Shared template* rõ ràng).
  - **Compatibility:** `ST-K` (TS-71 — RTL layout), `ST-M` (TS-92 — thiết bị/OS, xem mục 7 cho phạm vi đã
    descope).
  - **Portability:** `ST-K` (TS-71 — Arabic/RTL, có thể **không thực thi được** nếu Arabic chưa ship —
    TB-13/O-2, xem mục 9).
- **Change-related (confirmation/regression):** feature **mới hoàn toàn**, không có bug cũ của chính nó
  để confirm lại. Regression bắt buộc tối thiểu (mục 3.1): TS-04 (menu Note/Task/Widget không đổi), 1 lượt
  smoke "Set as current → Shortcut → lock screen thật" (nối với `03_shortcut-setup`/`10_lockscreen`, đã QC
  kỹ ở [test-plan-ios26-27.md](../shortcuts/test-plan-ios26-27.md), **không** chạy lại toàn bộ bộ đó).

---

## 5. Kỹ thuật thiết kế test case

### `ST-A` — Entry points (Equivalence Partitioning, Checklist-based)

- EP theo **loại item trong collection**: {wallpaper · Live Activity · Note · Widget} × **menu**
  {giữ tay trên Home → Your collection · giữ tay trong màn Your collection · nút ⬆︎ góc trên}.
  Partition hợp lệ: wallpaper ở cả 3 menu đều có Share. Partition không hợp lệ: 3 loại item khác ở menu
  giữ tay **không** có Share (TS-04); collection chỉ gồm 3 loại đó thì nút ⬆︎ **không hiện** (TS-05).
- Không cần BVA (không có ngưỡng số). Checklist-based trực tiếp từ VI §1 (6 ô tick nguyên văn).
- TS-03 (luồng sau khi bấm ⬆︎) còn hở (TB-25/O-18, luồng chọn nhiều/huỷ giữa danh sách chưa định nghĩa) —
  chỉ viết case được tới mức "mở danh sách, chọn 1 wallpaper, vào đúng luồng Share chuẩn"; phần mở rộng là
  **Exploratory charter**: *"Quan sát luồng chọn nhiều/huỷ giữa danh sách sau khi bấm ⬆︎ — ghi lại hành vi
  thực tế, không có đáp án đúng định sẵn"*.

### `ST-B` — Auth gate (State Transition)

| State | Mô tả |
|---|---|
| S0 | Signed-out |
| S1 | Sign-in sheet đang hiện ("Sign in to share this template") |
| S2 | Signed-in, share flow **tự resume** |
| S3 | Share bị huỷ (không tạo gì) |

| # | Từ | Event | Đến | Oracle | Nguồn |
|---|---|---|---|---|---|
| T1 | S0 | Bấm Share | S1 | Hiện đúng màn sign-in, **không** publish gì | TS-07 |
| T2 | S1 | Đăng nhập Apple/Google thành công | S2 | Share **tự chạy tiếp**, không cần bấm Share lại | TS-08 |
| T3 | S1 | Vuốt xuống đóng | S3 | Không share gì, không link nào được tạo | TS-09 |
| T4 | S1 | (giả định) phiên anonymous cố publish | S1 (chặn) | `sign_in_required`, app không dùng token anonymous | TS-10 |
| T5 | — | App Check thất bại giữa publish | — | Force-refresh token, retry **đúng 1 lần**, sau đó lỗi chung | TS-11 |

- **Exploratory charter (thật sự chưa biết trước kết quả — O-19, TB-30):** *"Sign-in thất bại (Apple/Google
  trả lỗi), mất mạng giữa lúc sign-in, user đổi ý ở dialog hệ thống Apple: ghi lại app về state nào, có giữ
  lựa chọn ảnh/chữ đã bấm trước T1 hay bắt đầu lại từ đầu — không suy diễn trước kết quả."*

### `ST-C` — Hộp thoại xin phép ảnh/chữ (Decision Table)

**Decision Table — 2 điều kiện, 4 rule, theo đúng VI §4/§5:**

| Rule | Có ảnh riêng? | Có chữ tự gõ? | Hộp thoại hiện | TS |
|---|---|---|---|---|
| R1 | Không | Không | Không hộp nào — thẳng share sheet | TS-12 |
| R2 | **Có** | Không | *"Share your photos too?"* (2 lựa chọn: *Use Ink backgrounds* / *Include my photos*) | TS-13 → TS-16 |
| R3 | Không | **Có** | *"Share this text?"* (cảnh báo ai có link cũng đọc được) | TS-17, TS-18 |
| R4 | **Có** | **Có** | **Chỉ** hộp ảnh (R2), nội dung nhắc cả chữ — **không** thêm hộp R3 | TS-19 |

Nhánh con của R2: *Use Ink backgrounds* → TS-14 (`asset_ids=[]`; **phần nền**: oracle TẠM — xem mục 6) ·
*Include my photos* → TS-15 (máy B thấy đúng ảnh máy A) · Cancel → TS-16 (không share gì). Chữ tự gõ
**luôn** đi theo link kể cả khi chọn *Use Ink backgrounds* (TS-20, cắt ngang R2/R4).

- **Error guessing / boundary chưa định nghĩa (TB-14/O-3)** — không có oracle, chỉ ghi nhận: ảnh
  cutout/tách nền, ảnh Ink AI sinh, quote catalog chưa sửa, tên wallpaper — cái nào tính "ảnh riêng"/"chữ
  tự gõ". **Charter:** *"Thử từng loại trên 1 design riêng, ghi lại hộp nào hiện ra — nếu khác 4 rule trên,
  báo như một ca mới, không coi là bug cho tới khi có câu trả lời của dev (O-3)."*

### `ST-D` — Link identity (State Transition)

| State (theo từng wallpaper) | Mô tả |
|---|---|
| L0 | Chưa từng share, không có id |
| L1 | Đã share, có id + cache thiết bị |
| L0' | Cache thiết bị bị xoá (logout/đổi account/xoá tài khoản — Q-10, TRUNG BÌNH) nhưng id cũ **vẫn tồn tại ở server** cho tới khi xoá tài khoản thật |

| # | Từ | Event | Đến | Oracle | TS |
|---|---|---|---|---|---|
| T1 | L0 | Share lần đầu | L1 | Tạo id mới | TS-21 (nhánh đầu) |
| T2 | L1 | Share lại, không đổi gì | L1 | **Cùng id** | TS-21, TS-25 |
| T3 | L1 | Sửa design, Share lại | L1 | **Cùng id**, nội dung đã cập nhật | TS-22 |
| T3b | L1 (`asset_ids=[...]`, có ảnh riêng — từ lần share chọn *Include my photos*) | Share lại **cùng wallpaper đó**, lần này chọn *Use Ink backgrounds* | L1 (`asset_ids=[]`, hết ảnh riêng) | **Cùng id** (link không đổi) **+** ảnh riêng của lần share trước phải **mất khỏi link** **+** gọi lại `GET /template-share/assets/<asset_id>` (asset_id của lần share đầu, cũ) phải trả **404** thật (ảnh bị xoá hẳn ở server, không chỉ ẩn khỏi response) — theo API §Flow ("the server deletes images the new version no longer lists") | TS-24 |
| T4 | L1 | Cài lại app, cùng account, Share lại cùng wallpaper | L1 | Server trả **cùng id cũ** | TS-26 (nhánh reinstall) |
| T5 | L1 | Đăng xuất / đổi account trên cùng máy | L0' | Cache bị xoá — account mới **không** thấy/tái dùng link account cũ | TS-26 (nhánh mới, Q-10) |
| T6 | L1 | Xoá tài khoản | link chết (404 cho người nhận) | — | TS-66, TS-67 |
| T7 | (sau T6) account mới, Share lại cùng wallpaper | L1 (id MỚI) | **Không** phát lại link đã chết | TS-66 |
| — | L0 (wallpaper khác) | Share | L1 khác | id khác, không nhầm chéo nội dung | TS-23 |

> ⚠️ T5, T7 dùng **assumption Q-10 (tin cậy TRUNG BÌNH)** — nếu app **không** xoá cache, T5/T7 sẽ fail và
> đó chính là bug cần báo (lỗi im lặng đã lường trước — xem mục 6/8.1).
- T2/T4 không quan sát được thuần từ UI độ "có tốn 1 publish/ngày hay không" — cần proxy (TB-17/O-8); nếu
  không có proxy, chỉ kiểm được **id giống nhau**, không kiểm được chi phí publish — ghi rõ khi báo kết quả.

> **Changelog `ST-D` — 2026-10-02 (bổ sung sau khi lập test plan):** skill `test-case` phát hiện **TS-24**
> (P1, risk **Rất cao** — nguồn: `test-analysis-1-2-19.md` mục 2, VI §6.04 + API §Flow) **chưa có
> transition tương ứng** trong bảng trên (bảng gốc chỉ có T1 → T7 + 1 dòng không số). Đã bổ sung **đúng 1
> transition `T3b`** (sub-case của `T3` — vẫn là state `L1`, chỉ khác ở việc `asset_ids` có/không có ảnh
> riêng, **không** tạo state mới ở mục state ở trên) để `test-case` có oracle đầy đủ, gồm cả bước verify
> asset cũ trả **404** thật. **Không** đổi T1–T7, không đổi priority/risk đã có của TS-24 (vẫn P1/Rất cao
> — xem mục 6, không viết lại ở đây), không đổi số lượng case của các TS-* khác trong `ST-D`. Đây là một
> **bổ sung cục bộ** để lấp gap test-case phát hiện, không phải lập lại test plan từ đầu.

### `ST-E` — Payload & privacy hygiene (Equivalence Partitioning + 3-value BVA)

- EP: `backgrounds[].path`/`sourcePath` {hợp lệ `catalog:https://assets.homebod.ai/…` · hợp lệ
  `shared:<asset_id>` · không hợp lệ (đường dẫn máy)} (TS-28); device state field {có strip đúng ·
  không strip (bug)} cho calendar/note id/album id/rotation clock (TS-29); ảnh upload {còn EXIF/GPS (bug) ·
  đã re-encode sạch} (TS-30); `layout_kind` {hợp lệ không phải `notes*` · `notes*` (phải không bao giờ xảy
  ra)} (TS-34); asset chưa claim {được tải sau 24h (bug) · bị xoá đúng hạn} (TS-35, chi phí cao — chờ 24h).
- **3-value BVA** cho các ngưỡng ở API §Limits (giá trị byte quy đổi từ MB/KB, **quy ước làm tròn do QC
  chọn — không có trong test basis, ghi rõ là quyết định thiết kế test**: `1 MB = 1,048,576 byte`,
  `1 KB = 1,024 byte`; boundary coi là **hợp lệ ở đúng giá trị limit**, chỉ vượt **quá** limit mới lỗi —
  assumption về tính "inclusive" này **chưa được dev xác nhận**, nêu ở mục 10 nếu cần):

  | Giới hạn | Dưới biên (hợp lệ) | Tại biên (hợp lệ) | Trên biên (lỗi) | Response kỳ vọng | TS |
  |---|---|---|---|---|---|
  | Ảnh | 2,097,151 byte | 2,097,152 byte (= 2 MB) | 2,097,153 byte | `413` khi vượt | TS-31 |
  | Publish body | 65,535 byte | 65,536 byte (= 64 KB) | 65,537 byte | `413` khi vượt | TS-32 |
  | `template.template` | 49,151 byte | 49,152 byte (= 48 KB) | 49,153 byte | `400 invalid_template` khi vượt | TS-32 |
  | Ảnh/share | 19 ảnh | 20 ảnh | 21 ảnh | `400 invalid_template` khi vượt | TS-33, TS-91 |

  Mọi nhánh lỗi quy về **cùng thông báo chung** *"Couldn't create a share link. Try again."* (API §Errors) —
  không phân biệt được bằng UI đâu là `413` hay `400` (TB-18) nếu không có proxy.
- TS-27, TS-28, TS-29, TS-30 **không kiểm được qua UI thuần** — cần proxy (Charles/mitmproxy) để xem payload
  thật, hoặc `curl` trực tiếp route public (`/template-share/:id`) để xem response. Nếu QC không có proxy
  khi execute, đây là **coverage gap tường minh** (xem mục 7/11), không phải case "pass ngầm định".

### `ST-F` — Mở link / nhận (Equivalence Partitioning, cần mock cho nhóm security)

- EP: id trong deeplink {hợp lệ & tồn tại · hợp lệ định dạng nhưng không tồn tại (404) · sai định dạng
  (regex `[A-Za-z0-9_-]{1,64}` fail) · kèm query param lạ} (TS-36, TS-44); app state khi mở link {đang chạy
  · cold start} (TS-36, TS-37); response field bất thường {`preview_url=null` · host lạ · `schema` quá cao ·
  `layout_kind` lạ} (TS-41, TS-42, TS-43) — **cần mock response độc hoặc proxy chỉnh sửa** (TB-23/O-11, xem
  mục 7 cho quyết định descope).
- Thứ tự parse deeplink (TS-45): link template trên `inkcalendar.app` phải được nhận diện **trước** link
  share lịch — kiểm bằng cách mở cả 2 loại link trên cùng máy, xem đúng màn nào hiện ra; không cần mock.
- TS-38/TS-39 (chưa đăng nhập, Pro badge) nối sang Decision Table của `ST-H` — xem dưới.

### `ST-G` — Add to my collection (Equivalence Partitioning + 2-value BVA + Error guessing)

- EP: account entitlement {Free · Pro} (TS-47, TS-48); số design hiện có trong collection của account Free
  {< 5 · = 5} — **2-value BVA** vì đây là ngưỡng chặn cứng, không phải dải liên tục:

  | Số design trước khi Add | Kỳ vọng |
  |---|---|
  | 4 (dưới ngưỡng) | Add thành công, thành 5 |
  | 5 (tại ngưỡng) | *"Collection is full"* + Go Pro/Cancel; xoá 1 rồi Add lại thì thành công |

  ⚠️ "5 design" đếm **cái gì** chưa rõ (TB-15/O-4 — chỉ wallpaper, hay cả Live Activity/Note/Widget) — case
  viết với **giả định tạm: chỉ đếm wallpaper** (nhất quán với việc chỉ wallpaper có Share) — nếu dev xác
  nhận khác, sửa lại bộ dữ liệu test, không đổi pass/fail logic của bảng trên.
- Bytes tải về {decode đúng PNG/JPEG ≤2MB · ảnh rác (decode fail hoặc >2MB)} (TS-50).
- **Error guessing (từ TB-29/O-16, không có acceptance criteria chi tiết):** *"Add mà mất mạng/ảnh 404 ở
  ảnh thứ n giữa chừng — quan sát: có item nửa vời trong collection không, có thông báo không. Oracle chắc
  duy nhất: KHÔNG được để lại item nửa vời; phần còn lại (rollback hay giữ item không ảnh) là quan sát, báo
  như tìm thấy, không giả định trước."* (TS-53)

### `ST-H` — Pro gate & applied wallpaper (Decision Table)

**Decision Table — theo quyết định Q-7 (2 nhánh không mâu thuẫn):**

| Rule | Template id nhận diện được ở catalog local máy B? | Có customization Pro thật? | Entitlement máy B | Set as current | TS |
|---|---|---|---|---|---|
| DT-H1 | Có | Không | Free | **Không** paywall | TS-54 |
| DT-H2 | **Không** (id lạ / design `stack` không `origin_template_id`) | *(không áp dụng — luôn coi Pro)* | Free | **Luôn** paywall | TS-54b |
| DT-H3 | Có | **Có** | Free | **Paywall** | TS-55 |
| DT-H4 | Có | Có | Pro | Không paywall, chạy bình thường | TS-56 |

- TS-57 (không tin Pro flag trong share — server-side flag không được honour, quyết định Pro **luôn** từ
  catalog local theo id, đúng 2 nhánh trên) — cần sửa response (mock) để chứng minh app bỏ qua cờ Pro giả;
  nếu không có mock, chỉ kiểm được gián tiếp qua DT-H1→H4 (không chứng minh được app *cố tình* bỏ qua cờ
  sai, chỉ chứng minh hành vi đúng trong điều kiện bình thường) — ghi là giới hạn coverage, không phải fail.
- TS-58 (oracle áp dụng, theo Q-8): wallpaper đã Add lên lock screen thật qua Shortcut — **giống preview về
  style/bố cục**, **dữ liệu sự kiện/calendar luôn của máy B**. Kiểm bằng ảnh chụp lock screen thật (nối
  `03_shortcut-setup`/`10_lockscreen`, mục 3.1) đối chiếu preview trong app.

### `ST-I` — Lỗi, offline, hạn mức (Equivalence Partitioning, BVA descope cho rate limit)

- EP: trạng thái mạng {online · offline} × wallpaper {chưa từng share · đã share, có cache} (TS-60, TS-61
  — nhánh "đã share" chưa có oracle rõ, TB-17, ghi là **mở**, không giả định); id {tồn tại · không tồn tại
  (404) · đã bị xoá do xoá tài khoản (404, nối `ST-J`)} (TS-59); mã lỗi server {`429 rate_limited` · `502`
  storage · asset `404`} (TS-62 → TS-65).
- **BVA cho rate limit (TS-62, 30 publish/ngày) — ghi rõ CHƯA chắc thực thi được (O-20, xem mục 7/9):**
  publish thứ 29 (thành công) / thứ 30 (thành công, tại biên) / thứ 31 (chặn `429`). Nếu không có
  script/seed tạo dữ liệu trước giờ execute, case này **descope tường minh**, không thử tay (tốn thời gian,
  khoá account tới 00:00 UTC — TB-27).
- TS-63 (publish lỗi không làm hỏng link cũ) và TS-65 (upload `502` giữa chừng không publish nửa vời) khó
  **chủ động tái lập** lỗi server thật — nếu không có cách ép lỗi (mock), chỉ kiểm được khi lỗi mạng tự
  nhiên xảy ra trong lúc test; ghi nhận "chưa thử được chủ động" thay vì coi là pass.

### `ST-J` — Xoá tài khoản (State Transition — dùng lại từ `ST-D`, xem T6/T7)

- TS-68 (bản copy máy B đã Add trước đó vẫn dùng được sau khi máy A xoá tài khoản) — kiểm bằng cách Add
  trước, xoá tài khoản máy A, rồi mở lại bản copy trên máy B (không qua link, qua chính "Your collection"
  của máy B).

### `ST-K` — Ngôn ngữ (Equivalence Partitioning, descope có điều kiện)

- EP: ngôn ngữ app {vi · en · ar (nếu có ship) · ngôn ngữ khác bất kỳ trong 18 ngôn ngữ, không kiểm hết}
  (TS-70, TS-71). **Trước khi chạy TS-71:** kiểm Settings → Language của build thật có **Arabic** hay
  không (TB-13/O-2 — bằng chứng đối chiếu bộ 1.2.15 trong repo **không có** Arabic). Nếu **không có** →
  **loại Arabic khỏi lần chạy này, hạ còn vi/en**, ghi nhận O-2 vẫn mở, **không** coi TS-71 là fail vì
  "không thực thi được" ≠ "fail".
- TS-72 (giá trị `lang` gửi lên publish = ngôn ngữ app; sai định dạng → server fallback `en`) — chỉ kiểm
  được nhánh chính (`lang` hợp lệ) qua UI; nhánh "sai định dạng" cần ép giá trị bất thường — không có cách
  nào từ UI chuẩn, **ghi là không thực thi được từ UI**, trừ khi có proxy sửa request.

### `ST-M` — Xuyên suốt / phi chức năng (hỗn hợp)

- TS-90 (thời gian tạo link): **không có SLA định lượng** (TB-24/O-15) → chỉ kiểm tiêu chí định tính "share
  sheet cuối cùng mở ra, UI không treo vô hạn trên mạng bình thường" — xem mục 9 cho quyết định descope
  phần định lượng.
- TS-91 (design nặng, tiến tới 20 ảnh/64KB) — kết hợp dữ liệu BVA của `ST-E` (bảng trên) ở mức "tại biên",
  chạy full luồng Share + Add end-to-end.
- TS-92 (compatibility thiết bị/OS) — phạm vi **đã descope iPad** (mục 7) — chỉ chạy trên 2 iPhone thật.
- TS-94 → TS-97: kiểm bằng `curl` trực tiếp (API §Testing có sẵn lệnh mẫu) cho phần **không cần App Check**
  (đọc share 3.3, tải ảnh 3.4) — phần **cần** App Check (publish, upload, list/stop) **không** curl được từ
  máy QC thường (thiếu token hợp lệ ngoài app) nên chỉ xác nhận gián tiếp qua hành vi app. TS-97 (nội dung
  share sheet) — mở share sheet thật, dùng tính năng "Copy"/xem preview của iOS để liệt kê đúng item được
  đưa vào share sheet (URL, có tiêu đề không, có ảnh/attachment nào không) — **không có oracle rõ "những gì
  khác URL" (TB-26/O-17)**, ghi nhận observation, chỉ fail chắc chắn nếu thấy ảnh/dữ liệu cá nhân kèm theo.

---

## 6. Risk-based prioritization

> **Risk level = risk likelihood × risk impact** (ISTQB §5.2.1). Ma trận dùng xuyên suốt — **đã được
> User/QC-test-lead phê chuẩn ngày 2026-10-02 (O-21), giữ nguyên, không tự đặt lại thang khác** (yêu cầu
> bắt buộc #5 của caller):
> `Cao×Cao = Rất cao → P1` · `Cao×Vừa / Vừa×Cao = Cao → P1` · `Vừa×Vừa = Vừa → P2` ·
> `Cao×Thấp / Thấp×Cao = Vừa → P2` · `Vừa×Thấp / Thấp×Vừa = Thấp–Vừa → P3` · `Thấp×Thấp = Thấp → P3`.
> **Likelihood/impact vẫn là phán đoán định tính của QC** (bundle không có số liệu business — A-2), nay
> **đã được phê chuẩn** (O-21), không phải đã có dữ liệu business thật.

**Tổng: P1 = 34 · P2 = 37 · P3 = 8 (79 condition trong phạm vi).**

### P1 — 34 condition, chặn phát hành nếu fail

| Nhóm | TS | Vì sao impact cao |
|---|---|---|
| `ST-A` | TS-04 | Item Note có mục Share nhầm ⇒ **rò nội dung Note** (riêng tư cá nhân) qua một feature không được thiết kế cho nó |
| `ST-B` | TS-07, TS-08, TS-09, TS-10 | Sai ở cổng đăng nhập = **chặn toàn bộ feature** (TS-07/09) hoặc **publish ngoài ý muốn** bằng token không hợp lệ (TS-09/10) — dữ liệu công khai hoá mà user không chủ ý |
| `ST-C` | TS-13, TS-14, TS-16, TS-17, TS-18, TS-19 | Đây là **cổng riêng tư duy nhất** trước khi dữ liệu (ảnh/chữ) trở thành công khai qua link; sai một nhánh = rò rỉ ảnh/chữ riêng tư mà user không được hỏi, hoặc share nhầm khi đã Cancel |
| `ST-D` | TS-21, TS-22, TS-24, TS-25(¹) | TS-24 **Rất cao**: ảnh cũ phải bị xoá **thật** (404) khi đổi sang *Use Ink backgrounds* — nếu không, ảnh riêng vẫn lộ công khai dù UI báo đã ẩn. TS-21/22: sai link identity làm **người nhận cũ bị bỏ rơi** hoặc nhận bản cũ sau khi đã sửa |
| `ST-E` | TS-27, TS-28, TS-29, TS-30 | Đường rò rỉ dữ liệu cá nhân (EXIF/GPS, calendar đã chọn, note id, album id) ra một link **công khai không cần đăng nhập** — impact cao nhất của toàn feature theo đúng thứ tự risk đã phê chuẩn (rò rỉ dữ liệu công khai > mất dữ liệu/paywall > lỗi hiển thị) |
| `ST-F` | TS-36, TS-37, TS-38 | TS-37 **Rất cao**: deeplink phải sống sót qua cold start — mất ở đây nghĩa là **mọi** người nhận cold-start đều hỏng; TS-36/38 là happy-path chính của luồng nhận |
| `ST-G` | TS-46, TS-47, TS-49, TS-52, TS-53 | TS-47 ảnh hưởng **doanh thu** (Pro gate) + chặn user vô cớ nếu sai; TS-49/52/53 ảnh hưởng **tính nguyên vẹn dữ liệu** của bản copy đã lưu (dữ liệu hỏng trong collection là lỗi khó phát hiện sau) |
| `ST-H` | TS-54, TS-54b, TS-55, TS-58 | Pro gate sai = **mất doanh thu** (hở paywall) hoặc **chặn sai** user Free; TS-58 là **điểm cuối cùng** của toàn bộ feature (wallpaper thật trên màn khoá) |
| `ST-J` | TS-66, TS-67 | TS-66 là nơi duy nhất kiểm được **hệ quả của Q-1 (không có đường thu hồi) + Q-10 (cache xoá)** cùng lúc — sai một trong hai là **lỗi im lặng về riêng tư** (link chết bị phát lại, hoặc ngược lại link sống phát nhầm); TS-67 đảm bảo ảnh thật biến mất sau xoá tài khoản |
| `ST-K` | TS-70 | Dịch sót/cắt chữ tiếng Việt — thị trường chính của app, impact UX cao trên toàn bộ 5+ màn mới |

> (¹) TS-25 được xếp P3 trong `test-analysis` (risk Vừa×Thấp) — không nằm trong danh sách P1, liệt kê ở
> đây là **nhầm nếu xuất hiện**; xác nhận lại: TS-25 **P3**, không phải P1 (đã sửa khi rà soát, xem bảng
> dưới P3).

### P2 — 37 condition, mất một phần chức năng, có workaround (liệt kê theo nhóm, không lặp lại toàn bộ lý do — xem test-analysis mục 2 cho risk level từng dòng)

`ST-A`: TS-01, TS-02, TS-03 · `ST-B`: TS-11 · `ST-C`: TS-12, TS-20 · `ST-D`: TS-23, TS-26 · `ST-E`: TS-31,
TS-32, TS-33, TS-34, TS-35 · `ST-F`: TS-39, TS-41, TS-42, TS-43, TS-44, TS-45 · `ST-G`: TS-48 · `ST-H`:
TS-56, TS-57 · `ST-I`: TS-59, TS-60, TS-61, TS-63, TS-65 · `ST-J`: TS-68 · `ST-K`: TS-71 *(hạ từ P1 vì chưa
xác nhận Arabic có ship — TB-13)* · `ST-M`: TS-91, TS-92, TS-94, TS-95, TS-96, TS-97.

### P3 — 8 condition, cosmetic/UX nhẹ

`ST-A`: TS-06 · `ST-D`: TS-25 · `ST-G`: TS-50, TS-51 · `ST-I`: TS-62, TS-64 · `ST-F`: TS-40 · `ST-K`:
TS-72.

### Mức tin cậy của assumption dùng trong risk/oracle (bắt buộc giữ nguyên — yêu cầu #1 của caller)

| Mức tin cậy | Q | Condition bị ảnh hưởng | Ghi chú |
|---|---|---|---|
| **CAO** | Q-1 | TS-21, TS-26, TS-66 | App 1.2.19 không có UI "link của tôi"/"ngừng share". Nguồn: VI §KN.2 (checklist QC riêng cho đợt này) |
| **CAO** | Q-4 | TS-72 *(TS-86 cũng CAO nhưng thuộc `ST-L`, hoãn)* | Trang web theo ngôn ngữ visitor — chỉ phần `lang` gửi từ app còn trong scope |
| **CAO** | Q-7 | TS-39, TS-54, TS-54b, TS-55, TS-57 | 2 nhánh Pro gate không mâu thuẫn |
| **CAO** | Q-8 | TS-27, TS-58 | Oracle wallpaper áp dụng = style/bố cục giống preview, dữ liệu của máy B |
| **CAO** | Q-9 | TS-31, TS-32, TS-33, TS-91 | API đã định nghĩa đủ mã lỗi/thông báo cho vượt giới hạn |
| **TRUNG BÌNH** | Q-10 | TS-21, TS-26, TS-66 | Cache thiết bị bị xoá khi xoá tài khoản/đăng xuất/đổi account |
| **THẤP ⚠️** | Q-6 | TS-14 (phần nền), TS-15 | Nền thay thế = nền mặc định chung hệ thống — **oracle TẠM**, suy luận kỹ thuật, không dòng nào trong test basis gợi ý trực tiếp. **Không được coi ngang hàng các mức trên.** Nếu dev xác nhận khác → sửa lại expected result của TS-14 (phần nền)/TS-15 khi có câu trả lời (O-24) |

---

## 7. Test environment matrix

| | Quyết định cho đợt `1-2-19` | Nguồn / lý do |
|---|---|---|
| **Build** | **Ink Prod 1.2.19**, cài qua App Store (hoặc TestFlight build tương đương 1.2.19 nếu App Store chưa publish) | VI §0.1. **Build number nội bộ cụ thể KHÔNG có trong test basis** (TB-19) — **quyết định của QC cho đợt này:** ghi nhận version "1.2.19" làm tham chiếu chính; nếu dev cấp build number cụ thể trước khi execute thì dùng số đó khi log bug, nếu không có thì ghi "build number: không xác định, app version 1.2.19" — **descope tường minh (O-14)**, không suy diễn số |
| **Thiết bị** | **2 iPhone thật** (máy A gửi, máy B nhận), chạy **bản iOS công khai mới nhất** tại thời điểm test trên cả 2 máy làm bộ chạy chính. Nếu có máy rảnh ở phiên bản iOS liền trước, thêm 1 lượt smoke (TS-36, TS-46, TS-58) — **không bắt buộc** chạy toàn bộ 79 condition trên phiên bản phụ | VI §0.1 chỉ nói "máy thật" không ghi version cụ thể (TB-19/O-14) — **quyết định của QC**, theo thói lệ repo (A-6 ở test-analysis) nhưng **không đoán số OS cụ thể** vì không có cơ sở; nếu test lead có số OS chính thức trước khi execute, cập nhật bảng này |
| **iPad** | **Không bắt buộc** đợt này — **descope tường minh** | Test basis chỉ nói "máy thật", không nhắc iPad; feature này không có UI riêng iPad được ghi trong 3 file. TS-92 (compatibility) chạy **chỉ trên iPhone** đợt `1-2-19`; iPad là **coverage gap đã biết** (mục 11), không phải bỏ sót |
| **Cài đặt máy** | Mỗi máy **chỉ cài Ink Prod** — không cài thêm Ink Dev (tránh iOS mở `ink://` nhầm app) | VI §0.1 |
| **Tài khoản** | Máy A: đăng nhập Apple **hoặc** Google. Máy B: tài khoản **Free** (bắt buộc) + 1 tài khoản **Pro** riêng để so sánh (`ST-H`). Chuẩn bị thêm 1 account phụ cho nhánh "đổi account trên cùng máy" (`ST-D` T5, TS-26) | VI §0 (Chuẩn bị) |
| **Dữ liệu — 5 design chuẩn** | (1) catalog để nguyên · (2) có ảnh riêng (nền/sticker) · (3) có text sticker/quote tự gõ, không ảnh riêng · (4) cả ảnh riêng lẫn chữ tự gõ · (5) có customization Pro | VI §0 — nguyên văn, dùng làm test data chính cho `ST-C`/`ST-H` |
| **Dữ liệu — bổ sung cho Q-6/Q-7** | Thêm 1 design dạng `stack` tự dựng, **không** `origin_template_id`, nền duy nhất là ảnh riêng — dùng để test nhánh "id lạ" (TS-54b, TS-39 nhánh b) và "nền thay thế" (TS-14 phần nền, TS-15, oracle TẠM) | Suy ra từ mô tả kỹ thuật ở TB-06/TB-07 (API §3.2, §3.3) — **QC tự dựng data**, không có trong VI §0 |
| **Môi trường API** | **Chỉ production** (`https://inkcalendar.app/api/ink`) — API không công bố base URL staging/mock nào khác | `template-sharing-api.md` §Basics — xác nhận lại O-11 |
| **Mock/proxy cho nhóm "untrusted response"** | **Không có môi trường mock/staging** trong test basis (TB-23/O-11). **Quyết định của QC cho đợt này:** nếu trước giờ execute **không** có Charles Proxy/mitmproxy sẵn sàng **và** dev **không** cung cấp cách tạo response độc (host lạ, `schema` cao, `layout_kind` lạ) trên 1 id test, thì **TS-41, TS-42, TS-57 (phần mock) descope tường minh** — ghi "không thực thi được — thiếu phương tiện (O-11)" trong kết quả, **không** tính là pass/đã phủ. TS-80 không áp dụng (thuộc `ST-L`, đã hoãn) | TB-23, O-11 — descope theo đúng điều kiện caller yêu cầu #3 |
| **Phương tiện tạo dữ liệu hạn mức** | **Không có script/seed** để chạm 500 link/account, 30 publish/ngày, 100 upload/ngày (TB-27/O-20). **Quyết định của QC:** TS-62 (429 rate limit), phần "chạm hạn mức thật" của TS-63/TS-91 **descope tường minh** nếu không có script trước giờ execute — không làm tay (tốn thời gian, khoá account tới 00:00 UTC) | TB-27, O-20 — descope theo điều kiện caller yêu cầu #3 |
| **Baseline ảnh/screenshot** | **Chưa có baseline** cho 5–7 màn mới (TB-12/O-9). **Quyết định của QC:** chụp **trong lúc execute** test case lần đầu, dùng làm baseline cho lần sau — **không chặn** việc bắt đầu test. Đề xuất `flow-no` mới `15_share-template-link` (xem mục 1) — **cần người giữ rule xác nhận**, QC không tự sửa `screenshot-naming.md` | TB-12, O-9 — descope theo điều kiện caller yêu cầu #3; việc mint flow-no là đề xuất, không phải quyết định có hiệu lực |
| **Ngưỡng hiệu năng** | **Không có SLA định lượng** (TB-24/O-15). **Quyết định của QC:** chỉ dùng tiêu chí định tính — "share sheet cuối cùng mở ra trên mạng bình thường, UI không treo vô hạn" — cho TS-90/91. Không log bug về tốc độ nếu không vượt ngưỡng định tính này | TB-24, O-15 — descope theo điều kiện caller yêu cầu #3 |
| **Diagnostic/log** | **Không có** cách phân biệt `error_code` từ UI thuần (TB-18/O-10) — nếu không có proxy, TS-11/TS-62/TS-63/TS-65 chỉ kiểm được **hành vi quan sát được** (thông báo chung, không crash), không kiểm được **đúng nhánh lỗi nào đã xảy ra** | TB-18, O-10 |

---

## 8. Entry criteria

1. **Test basis sẵn sàng:** 3 file test basis + [test-analysis-1-2-19.md](test-analysis-1-2-19.md)
   (Status `READY`) + [answers-1-2-19.md](answers-1-2-19.md) đã được người thực thi **đọc toàn bộ**,
   đặc biệt bảng mức tin cậy (CAO/TRUNG BÌNH/THẤP) trước khi coi bất kỳ expected result nào là chắc chắn.
2. **Build:** Ink Prod 1.2.19 (hoặc TestFlight tương đương) cài trên **2 iPhone thật**, chỉ cài Ink Prod
   (không kèm Ink Dev) — xem mục 7 cho quyết định build number.
3. **Thiết bị/OS:** đã chốt theo mục 7 (bản iOS công khai mới nhất trên cả 2 máy chính); nếu có máy phụ
   cho smoke bản liền trước, chuẩn bị sẵn.
4. **Tài khoản:** máy A đăng nhập Apple/Google; máy B có cả account Free **và** account Pro sẵn sàng để
   chuyển đổi; có sẵn 1 account phụ cho nhánh đổi account (`ST-D` T5).
5. **Test data:** 5 design chuẩn (VI §0) + 1 design `stack` không `origin_template_id` (cho Q-6/Q-7) đã
   được tạo sẵn trong "Your collection" của máy A **trước khi** bắt đầu — thiếu bước này làm hỏng baseline
   của cả `ST-C`/`ST-H`.
6. **Môi trường bảo mật (`ST-E`/`ST-F` phần mock):** đã xác nhận **có hoặc không có** proxy/mock response
   trước khi bắt đầu nhóm này — nếu không có, đã ghi nhận descope theo mục 7, **không** để tới giữa lúc
   test mới phát hiện thiếu phương tiện.
7. **Smoke pass trước khi chạy full:** TS-01 (entry point Share hiện đúng) và TS-36 (mở link `ink://` ra
   đúng màn *Shared template*) phải pass — nếu 1 trong 2 fail, dừng lại, không chạy tiếp toàn bộ 79
   condition (chất lượng ban đầu của test object quá thấp để tin tưởng kết quả sâu hơn).
8. **Người thực thi** đã đọc mục 5 (kỹ thuật thiết kế) và mục 6 (risk) của chính file này trước khi bắt
   đầu, để biết case nào dùng oracle TẠM (Q-6) cần xử lý khác với case thường.

## 8.1 Suspension & Resumption criteria

- **Suspend toàn cụm `ST-D`/`ST-J`** nếu phát hiện app **thực sự CÓ** gọi route API §3.8 (list mine) hoặc
  §3.9 (stop sharing) qua một UI nào đó (trái với **Q-1, tin cậy CAO**) — đây sẽ làm sai toàn bộ oracle của
  TS-21/TS-26/TS-66 **và** mở lại GAP-1/GAP-2 (thiếu ~10–12 condition). Dừng ngay, xác nhận lại với dev
  (O-25) trước khi tiếp tục ghi nhận case trong 2 cụm này.
- **Suspend cục bộ `ST-D` (nhánh T5/T7)** nếu phát hiện cache thiết bị **KHÔNG** bị xoá sau đăng xuất/đổi
  account/xoá tài khoản (trái với **Q-10, tin cậy TRUNG BÌNH**) — đây **là** lỗi im lặng đã lường trước
  (báo bug ngay), nhưng cũng dừng để xác nhận với dev liệu đây là "by design không xoá" hay thật sự là bug,
  trước khi viết thêm case dựa trên oracle TS-66 cũ.
- **Suspend cục bộ `ST-C` (phần nền của TS-14, TS-15)** nếu nền thay thế quan sát được **khác** "nền mặc
  định chung của hệ thống" (trái với **Q-6, tin cậy THẤP**) — **không** vội kết luận fail, dừng, đối chiếu
  kỹ (có thể là nền catalog khác hoặc publish fail mà QC chưa lường) trước khi kết luận, báo gấp O-24.
- **Suspend toàn cụm** nếu production bắt đầu trả `429 rate_limited` ngoài ý muốn trong lúc test bình
  thường (không phải lúc chủ động test TS-62) — account có thể bị khoá tới 00:00 UTC — chuyển sang account
  dự phòng hoặc dừng tới hôm sau.
- **Resume:** chạy lại từ đầu cụm đã suspend sau khi có xác nhận/patch, không tiếp tục giữa chừng (đúng
  quy ước chung của repo, xem [test-plan-ios26-27.md §8.1](../shortcuts/test-plan-ios26-27.md)).

## 9. Exit criteria

1. **79/79 condition trong phạm vi** đã có kết quả ghi nhận rõ: pass / fail (kèm severity) / **"không thực
   thi được — thiếu phương tiện"** (lý do cụ thể, tham chiếu đúng mục 7) — không để trống ô nào.
2. **0 bug P1 mở** trong 34 condition P1 (mục 6).
3. **TS-14 (phần nền) và TS-15** đã chạy, kết quả được ghi kèm nhãn **"oracle TẠM — Q-6, tin cậy THẤP,
   chờ O-24"** dù pass hay fail — không trình bày như kết luận chắc chắn.
4. **TS-21, TS-26, TS-66** đã chạy; nếu kết quả cho thấy cache **không** bị xoá (trái Q-10) hoặc app thực
   sự có UI thu hồi link (trái Q-1) → đã được báo ngay theo mục 8.1, không chờ hết cả cụm mới báo.
5. **Case bị descope do thiếu phương tiện** (TS-41/TS-42/TS-57 phần mock, TS-62/63 phần rate-limit thật,
   TS-92 phần iPad, TS-11/TS-63/TS-65 phần phân biệt error_code) được **liệt kê rõ** trong báo cáo cuối là
   **known coverage gap**, **trừ ra khỏi** % coverage đã phủ — không tính ngầm là đã test.
6. **Regression tối thiểu đã chạy:** TS-04 (menu Note/Task/Widget không đổi) + 1 lượt smoke "Set as current
   → Shortcut → lock screen thật" (TS-58, có ảnh chụp màn khoá thật, không chỉ tin app báo "Applied").
7. **24 câu hỏi mở** (O-1 → O-8, O-10, O-12, O-13, O-16 → O-20, O-22 → O-25; trừ O-9/O-11/O-14/O-15/O-20 đã
   được quyết/descope ở mục 7, và O-21 đã chốt) đã được **mang nguyên** sang mục 10 dưới — **không** cần
   "trả lời hết" mới được exit, nhưng **không được** biến mất khỏi tài liệu.
8. **5 residual risk** (xem banner mở đầu mục 10) đã được ghi vào báo cáo test summary cuối cùng cho
   PM/dev, không giấu — đặc biệt: luồng end-to-end thật (bấm link https trong chat) **chưa từng chạy**
   trong đợt `1-2-19` phải được nêu rõ là **giới hạn đã biết của phạm vi APP-ONLY**, không phải "đã test
   đầy đủ luồng gửi-nhận".
9. **(Tuỳ chọn, không bắt buộc)** nếu còn thời gian: xác minh bằng `curl` route API §3.8/§3.9 (nhóm `ST-M`)
   để có thêm 1 điểm dữ liệu cho O-25 — không bắt buộc để exit.

---

## 10. Gap cần làm rõ trước khi execute

> Toàn bộ 24 câu hỏi mở của `test-analysis` (O-1 → O-25, trừ O-21 đã chốt) được mang sang đây. Cột
> **Trạng thái ở test-plan** phân biệt: đã **quyết/descope** ở mục 7–9 (không cần dev trả lời để exit) vs
> **vẫn mở, mang sang `test-case`/báo cáo cuối**. **Không câu nào** ảnh hưởng tập 79 condition hay mức
> P1/P2/P3 — nếu có, đã được xử lý riêng ở mục 0 (Test Plan Status).

| # | Câu hỏi (rút gọn) | Trạng thái ở test-plan | Ảnh hưởng |
|---|---|---|---|
| O-1 | 4 tài liệu thiếu (runbook…) — nguồn duy nhất cho oracle nội bộ app | Vẫn mở — không có cách QC tự lấy được | Củng cố/bác bỏ Q-6/Q-8/Q-10 |
| O-2 | Danh sách 18 locale, Arabic có ship không | **Quyết định thực thi** ở mục 7 (`ST-K`): kiểm tại chỗ, descope Arabic nếu không thấy trong Settings | TS-70, TS-71 |
| O-3 | Biên bộ phát hiện "ảnh riêng"/"chữ tự gõ" (cutout, AI, quote catalog, tên wallpaper) | Vẫn mở — error guessing charter ở `ST-C` (mục 5) | TS-12 → TS-20 |
| O-4 | "5 design" đếm cái gì; chưa đăng nhập là Free/Pro | Vẫn mở — dùng giả định tạm "chỉ đếm wallpaper" (mục 5, `ST-G`) | TS-47, TS-48, TS-38 |
| O-5 | Tên wallpaper >80/rỗng/untrusted text trong app | Vẫn mở | TS-36 |
| O-6 | Card unfurl chat giữ ảnh/tiêu đề cũ — bug hay by design | Vẫn mở — không trong scope điều kiện này đợt `1-2-19` (TS-82 thuộc `ST-L`, hoãn) | TS-81 (nhóm L, hoãn) |
| O-7 | Huỷ share sheet sau khi link đã tạo — by design? | Vẫn mở — residual risk đã ghi (mục 6, không có đường thu hồi) | TS-16, TS-18 |
| O-8 | App có cache link per-wallpaper không; share lần 2 tốn publish không | Vẫn mở — ghi nhận giới hạn ở `ST-D` (mục 5) | TS-21, TS-25, TS-61, TS-62 |
| O-9 | Kế hoạch chụp screenshot, flow-no mới | **Quyết định/đề xuất** ở mục 1 + mục 7 (chụp trong lúc test, đề xuất flow `15`, cần người giữ rule xác nhận) | Visual oracle toàn bộ UI |
| O-10 | Proxy/log phân biệt error_code | Gắn với O-11 — xem dưới | TS-11, TS-62, TS-63, TS-65 |
| O-11 | Môi trường mock/staging cho nhóm bảo mật | **Descope tường minh** ở mục 7 nếu không có phương tiện trước giờ execute | TS-41, TS-42, TS-57 |
| O-12 | Dữ liệu cho nhánh `410` | GAP-8 — **parked**, không đổi | — |
| O-13 | TS-88 (`/share/<id>` regression) có thuộc phạm vi QC đợt web không | Vẫn mở — chỉ liên quan khi mint slug mới cho `ST-L` | TS-88 (hoãn) |
| O-14 | Device/OS matrix + build number | **Quyết định** ở mục 7 (2 iPhone thật, bản iOS công khai mới nhất, iPad descope, build number ghi "không xác định" nếu thiếu) | TS-92, entry criteria |
| O-15 | Ngưỡng thời gian "Creating link…" | **Descope tường minh** ở mục 7/9 — chỉ tiêu chí định tính | TS-90, TS-91 |
| O-16 | Add thất bại giữa đường — rollback hay giữ item lỗi | Vẫn mở — error guessing charter ở `ST-G` (mục 5) | TS-53 |
| O-17 | Share sheet mang theo gì ngoài URL | Vẫn mở — observation-only ở `ST-M` (mục 5) | TS-97 |
| O-18 | Luồng sau khi bấm ⬆︎ (chọn nhiều, huỷ giữa danh sách) | Vẫn mở — exploratory charter ở `ST-A` (mục 5) | TS-03 |
| O-19 | Nhánh sign-in thất bại/mất mạng giữa sign-in | Vẫn mở — exploratory charter ở `ST-B` (mục 5) | TS-07 → TS-10 |
| O-20 | Script/seed chạm hạn mức | **Descope tường minh** ở mục 7 nếu không có script trước giờ execute | TS-62, TS-63 |
| O-22 | Calendar nào của máy B được bind sau Add | Vẫn mở — không đổi pass/fail của TS-58 (đã có oracle ở mức style/bố cục) | TS-58 (độ chi tiết) |
| O-23 | Khi nào FE xác nhận trang `/t/<id>` live — điều kiện mint slug mới cho `ST-L` | Vẫn mở — điều kiện tiền đề cho đợt web riêng | `ST-L` (17 + TS-69, hoãn) |
| **O-24** | **Xác nhận lại với dev: nền mặc định chính xác là gì (Q-6, THẤP)** | **Vẫn mở — ưu tiên cao nhất để giải quyết song song với execute**, không chặn bắt đầu | **TS-14 (phần nền), TS-15** |
| **O-25** | **Xác nhận lại với dev Q-1 (CAO) + Q-10 (TRUNG BÌNH)**, đồng thời đề nghị dev sửa mâu thuẫn văn bản API ↔ VI | **Vẫn mở — ưu tiên cao, chạy song song**, không chặn bắt đầu | TS-21, TS-26, TS-66; có thể mở lại GAP-1/GAP-2 ở slug mới nếu Q-1 sai |

**Residual risk đã biết của phạm vi APP-ONLY (mang nguyên từ `test-analysis` mục 5, yêu cầu bắt buộc #4
của caller — không giấu):**

1. **Luồng end-to-end thật** (người nhận bấm link `https` trong chat) **chưa từng được QC chạy một lần
   nào** trước khi 1.2.19 lên App Store — nhóm `ST-F` chỉ vào qua `ink://` (VI §0.6.2).
2. **Đường rò rỉ "ảnh preview công khai"** (Q-5, `preview_url`/`og:image`) **không** được QC phủ trong đợt
   này — out of scope, dev tự verify (mục 3).
3. **Không có đường thu hồi link trong app** (Q-1 — route 3.8/3.9 không có UI): link công khai **chỉ mất
   khi xoá tài khoản**, kể cả khi user huỷ share sheet sau khi link đã tạo (O-7).
4. **Oracle nền thay thế là TẠM** (Q-6, tin cậy THẤP — O-24): TS-14 (phần nền)/TS-15 có thể phải viết lại
   expected result sau khi dev xác nhận.
5. **Q-10 tin cậy TRUNG BÌNH:** nếu app thực tế không xoá cache thiết bị, nhánh "phát link đã chết" là
   **lỗi im lặng** cần phát hiện ngay trong lúc chạy TS-66, không chờ tới cuối đợt.

---

## 11. Coverage gap — case chưa được test basis liệt kê

| # | Thiếu gì | Vì sao là gap |
|---|---|---|
| 1 | **iPad** cho toàn bộ feature | Test basis không nhắc iPad; QC descope tường minh (mục 7) — không phải bỏ sót, nhưng vẫn là **0% coverage** trên thiết bị này |
| 2 | **17 condition nhóm `ST-L`** (trang web) + TS-69 | Hoãn theo Q-2 (APP-ONLY) — không phải lỗi QC, nhưng tới khi mint slug mới, **toàn bộ trang `/t/<id>`** (điều kiện FE §Status coi là bắt buộc trước khi 1.2.19 lên store) **chưa được QC kiểm một dòng nào** |
| 3 | **TS-93** (App Check mọi call) | Out of scope, dev tự verify — QC không có oracle độc lập để đối chiếu |
| 4 | **Phần "ảnh preview công khai"** của TS-14/TS-27 (và TS-73/TS-82 thuộc `ST-L`, đã hoãn) | Out of scope, dev tự verify — đây là **đường rò rỉ riêng tư tiềm năng chưa được ai (QC) xác nhận an toàn** |
| 5 | **Nhánh `410` moderation** (GAP-8) | Chưa build, không tạo được dữ liệu — parked, 1 condition P3 |
| 6 | **Nhóm bảo mật "untrusted response"** (TS-41, TS-42, TS-57 phần mock) | Nếu không có proxy/mock sẵn sàng lúc execute (O-11) — case **thiết kế được trên giấy** (mục 5) nhưng **không chạy được**, risk cao nhất của feature lại là nhóm khó test nhất |
| 7 | **Hạn mức thật** (30 publish/ngày, 100 upload/ngày, 500 link/account) | Nếu không có script tạo dữ liệu (O-20) — chỉ test được "logic hiển thị lỗi chung", không test được **đúng ngưỡng số** |
| 8 | **Phân biệt error_code từ UI** (TB-18/O-10) | Mọi lỗi publish thu về 1 thông báo — nếu không có proxy, QC **không thể khẳng định** app đã rẽ đúng nhánh lỗi nào, chỉ biết "có thông báo, không crash" |
| 9 | **Baseline hình ảnh lần đầu** cho 5–7 màn mới | Chưa có ảnh đối chiếu (TB-12) — "chữ không bị cắt" (VI §12) đợt đầu vẫn là **đánh giá cảm tính** của người test, chưa có ảnh chuẩn để so sánh khách quan |
| 10 | **Nội dung chính xác của share sheet** ngoài URL (TS-97, TB-26) | Không có oracle rõ "những gì khác URL" — chỉ phát hiện được nếu thấy rõ dữ liệu cá nhân kèm theo, có thể bỏ lọt rò rỉ tinh vi hơn |

---

**Bước tiếp theo (không phải quyết định của agent này):** nếu orchestrator xác nhận Test Plan Status
`READY` ở mục 0 là chấp nhận được, bước kế tiếp là chạy skill **test-case** trên chính file này để sinh
`test-cases-1-2-19.md` cùng thư mục — giữ nguyên mã nhóm `ST-A` → `ST-M` làm tiền tố ID, và mang nguyên
toàn bộ nhãn mức tin cậy + gap ở mục 6/10 sang từng test case liên quan.
