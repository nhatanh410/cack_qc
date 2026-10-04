# Answers / Decisions — Share Template as a Link (Ink Prod **1.2.19**) · slug `1-2-19`

> **Tài liệu này là gì:** nơi ghi lại **câu trả lời của con người** cho các câu hỏi CHẶN ở mục 4A của
> [test-analysis-1-2-19.md](test-analysis-1-2-19.md). Mỗi mục ghi: câu hỏi gốc · quyết định · lý do ·
> **nguồn** · hệ quả lên test condition.
>
> **Nguồn của **toàn bộ 10** quyết định dưới đây:** **User (QC/test lead của project), xác nhận trực
> tiếp trong hội thoại Claude Code, 2026-10-02.** Đây **không** phải câu trả lời của dev, **không** phải
> suy diễn của agent.
>
> **Phân loại 3 nhóm:**
> - **ASSUMPTION đã xác nhận** (8 câu: Q-2, Q-4, Q-7, Q-8, Q-9 — và **bổ sung đợt 2**: Q-1, Q-6, Q-10)
>   — là **giả định đã được QC/test lead chốt để test đi tiếp**, **KHÔNG** phải fact đã được dev/PM xác
>   nhận. Nếu sau này dev nói khác → phải sửa lại test-analysis/test-plan/test-case, không coi là
>   "spec đổi".
> - **OUT OF SCOPE đợt `1-2-19`** (2 câu: Q-3, Q-5) — quyết định **phạm vi**, không phải quyết định về
>   expected result. QC **không** viết oracle cho phần này trong đợt này; **dev tự test/verify**.
> - **VẪN CHỜ DEV** — **không còn câu nào** (trước 2026-10-02 đợt 2 là Q-1, Q-6, Q-10).
>
> ⚠️ **Mức tin cậy KHÔNG như nhau.** 3 quyết định bổ sung ở **mục C** được user chủ động chốt **để đi
> tiếp pipeline ngay, không chờ dev**, với mức tin cậy **CAO (Q-1)** · **TRUNG BÌNH (Q-10)** ·
> **THẤP (Q-6)**. Mức tin cậy phải được mang nguyên sang `test-plan`/`test-case` — **không** được viết
> như thể cả 3 đều chắc chắn ngang nhau.
>
> **Ngày:** 2026-10-02 · **Người ghi nhận:** agent `qc-test-analysis` (ghi lại quyết định của user)

---

## A · 5 ASSUMPTION đã xác nhận bởi QC/test lead

> Nhãn bắt buộc mang theo xuống test-plan/test-case:
> **"Assumption đã xác nhận bởi QC/test lead, 2026-10-02, không phải fact từ dev"**.

### A-Q2 · Phạm vi trang web `/t/<id>` → **APP-ONLY**

| | |
|---|---|
| **Câu hỏi gốc (Q-2)** | Trang web **`/t/<id>` có thuộc phạm vi đợt test slug `1-2-19`** không, và **thứ tự** thế nào? FE §Status nói trang là **điều kiện trước khi 1.2.19 lên App Store**; VI §0.6 / §KN.1 nói trang **chưa làm** và lỗi 404 **không cần báo**. Cần chốt: (a) 17 condition nhóm L do **ai** chạy; (b) exit criteria của 1.2.19 **có** bắt buộc trang live hay không; (c) luồng end-to-end thật (người nhận bấm link https trong chat) **có được coi là đã test** hay không. |
| **Quyết định** | **Phạm vi QC đợt `1-2-19` là APP-ONLY.** Trang web `/t/<id>` **không** thuộc phạm vi slug này. |
| **Lý do (nguyên văn theo user)** | VI (chính checklist QC đang dùng làm test basis cho đợt này) tự nói rõ trang web chưa làm và dặn "không cần báo lỗi" + cho cách test vòng qua bằng `ink://`. Đây là QC tự quyết phạm vi test của chính mình dựa trên checklist mình đang chạy, không phải đoán hành vi sản phẩm. |
| **Nguồn** | User (QC/test lead), xác nhận trong hội thoại Claude Code, 2026-10-02 |
| **Hệ quả lên condition** | Toàn **nhóm L — 17 condition TS-73 → TS-89** (nguồn FE) và **TS-69**, **TS-88** → **tạm hoãn khỏi phạm vi slug `1-2-19`**. **Không xoá** khỏi test-analysis — giữ nguyên, chỉ đổi trạng thái/ghi chú phạm vi. Sẽ chạy ở **đợt riêng (slug mới)** khi **FE xác nhận trang `/t/<id>` đã live**. |
| **Lưu ý rủi ro còn lại (QC chủ động ghi, không phải phần quyết định)** | Với APP-ONLY, **nhóm F** (TS-36 → TS-45) được test qua `ink://` — **không phải** đường vào thật của user (bấm link https trong chat). Luồng end-to-end thật vì vậy **chưa từng được chạy** trong đợt `1-2-19`; `test-plan` phải ghi điều này ở phần residual risk / exit criteria, không được im lặng. |

### A-Q4 · Ngôn ngữ trang `/t/<id>` → **theo ngôn ngữ người xem (visitor)**

| | |
|---|---|
| **Câu hỏi gốc (Q-4)** | Trang `/t/<id>` hiển thị theo **ngôn ngữ của người xem** (FE §7) hay theo **`lang` của người gửi** (API §3.2 *"the web page is rendered in it"*)? |
| **Quyết định** | **Trang theo ngôn ngữ người xem (visitor).** `lang` của người gửi **chỉ là fallback** khi không xác định được ngôn ngữ visitor (sau đó mới tới English). |
| **Lý do (nguyên văn theo user)** | FE §7 nêu rõ thứ tự ưu tiên (URL segment/Accept-Language trước, fallback về `lang` của share sau, rồi English); câu của API chỉ là mô tả ngắn cho dev mobile, không phải spec ngôn ngữ chi tiết — FE có thẩm quyền cao hơn cho đúng topic này. |
| **Nguồn** | User (QC/test lead), xác nhận trong hội thoại Claude Code, 2026-10-02 |
| **Đối chiếu tài liệu** | FE §7 dòng 156–163: *"Use the same language logic as the `/share/` page (URL segment, `Accept-Language`…)"*, *"The site's language decides the page's own text"*, *"If the visitor's language can't be decided, you **may** fall back to the share's `lang`"* — khớp với quyết định. |
| **Hệ quả lên condition** | **TS-86**: gỡ nhãn "mâu thuẫn Q-4", oracle = text trang theo visitor, `name` hiển thị nguyên văn không dịch. **Nhưng TS-86 vẫn thuộc nhóm L ⇒ vẫn hoãn theo A-Q2.** **TS-72**: gỡ nhãn Q-4; `lang` gửi lên = ngôn ngữ app đang dùng, ý nghĩa của nó là **hint cho web**, không phải "khoá ngôn ngữ trang". |

### A-Q7 · Pro cho template id lạ → **không thực sự mâu thuẫn, là 2 nhánh khác nhau**

| | |
|---|---|
| **Câu hỏi gốc (Q-7)** | Với share mà **template id không có trong catalog local** của máy nhận: áp dụng API §3.3 (*"treat an unknown template as Pro"* ⇒ máy Free **thấy paywall** dù design không có tuỳ chỉnh Pro) hay VI §9.01 (**không** paywall)? |
| **Quyết định** | **Không phải mâu thuẫn.** Hai câu nói về **hai tình huống khác nhau, không loại trừ nhau**: <br>• **Nhánh 1 — id đã biết trong catalog:** VI §9.01 áp dụng ⇒ Pro gate theo **cờ Pro thật của template** trong catalog local; design thuộc catalog đã biết mà **không** có Pro customization ⇒ **không paywall**. <br>• **Nhánh 2 — id lạ / không nhận diện được** (app máy B cũ hơn, hoặc design `stack` **không** `origin_template_id`): API §3.3 áp dụng ⇒ **luôn coi là Pro**, **Set as current luôn paywall** bất kể design có customization hay không. |
| **Lý do (nguyên văn theo user)** | VI §9.01 nói về design **thuộc catalog đã biết** (id nhận diện được) không có Pro customization; API "unknown id ⇒ Pro" chỉ áp dụng khi máy B **không nhận ra id** (app cũ hơn / design `stack` không `origin_template_id`). Hai tình huống khác nhau, không loại trừ nhau. |
| **Nguồn** | User (QC/test lead), xác nhận trong hội thoại Claude Code, 2026-10-02 |
| **Hệ quả lên condition** | **GAP-4 đóng.** Cập nhật **TS-54 → TS-57** và **TS-39**: tách rõ 2 nhánh trên trong test condition (⇒ `test-plan` nên dùng **Decision Table**: `id nhận diện được?` × `template có cờ Pro?` × `entitlement máy B`). Gỡ nhãn ⚠️ Q-7. |

### A-Q8 · Oracle wallpaper đã áp dụng → **giống về style/bố cục; dữ liệu là của máy B**

| | |
|---|---|
| **Câu hỏi gốc (Q-8)** | Sau khi máy B **Add + Set as current**, wallpaper trên màn khoá lấy **sự kiện/calendar nào**? VI §9.04 nói "**đúng như bản xem trước**" nhưng bản xem trước là **sự kiện mẫu** (VI §3.04) và `selected calendars` đã bị **strip** (API §3.2). |
| **Quyết định** | **"Giống bản xem trước" = giống về style/bố cục.** **Dữ liệu sự kiện/calendar luôn là của máy B (máy nhận)**, **không bao giờ** là dữ liệu từ máy A. ⇒ Nếu wallpaper áp dụng trên máy B hiện **sự kiện mẫu** hoặc **sự kiện của máy A** ⇒ **bug**. |
| **Lý do (nguyên văn theo user)** | Đây là cách mọi template trong app vốn hoạt động (preview luôn render sự kiện mẫu, áp dụng thật luôn dùng lịch thật của máy đang dùng) — không phải hành vi riêng của feature share. |
| **Nguồn** | User (QC/test lead), xác nhận trong hội thoại Claude Code, 2026-10-02 |
| **Hệ quả lên condition** | **GAP-5 đóng.** **TS-58**: oracle = style/bố cục giống preview **+** dữ liệu sự kiện là lịch của máy B. **TS-27**: giữ nguyên "preview = sự kiện mẫu, không bao giờ là sự kiện thật của máy A" — nay nhất quán, không còn mâu thuẫn với VI §9.04. Gỡ nhãn ⚠️ Q-8. |
| **Phần vẫn hở (không chặn)** | *Calendar nào* của máy B được bind sau khi Add (tất cả? mặc định của app?) — chi tiết này **không** đổi pass/fail của TS-58 nữa (oracle đã rõ ở mức "lịch của máy B"), nên hạ xuống **câu hỏi MỞ**. |

### A-Q9 · Vượt giới hạn publish → **API đã định nghĩa đủ, không còn ambiguity ở mức test-analysis**

| | |
|---|---|
| **Câu hỏi gốc (Q-9)** | App làm gì khi design **vượt giới hạn** publish (ảnh >2 MB, >20 ảnh, body >64 KB, `template` >48 KB): tự hạ kích thước/tự cắt, chặn trước với thông báo riêng, hay để lỗi và hiện thông báo chung? Và **ngưỡng nào trên UI** là "vượt"? |
| **Quyết định** | **Hành vi đã được định nghĩa đủ bởi API — không còn là ambiguity ở mức test-analysis.** API §Limits đã chốt mã lỗi cho từng loại vượt ngưỡng, và API §Errors đã chốt thông báo người dùng. Phần còn lại (giá trị biên cụ thể để viết test case) là **quyết định thiết kế test ở bước `test-plan`/`test-case`**, không phải gap cần dev trả lời. |
| **Lý do (nguyên văn theo user)** | API đã có bảng Limits (413 khi vượt size ảnh/body, 400 invalid_template khi vượt design/photos) + bảng error-code (`invalid_template` → thông báo chung "Couldn't create a share link. Try again."). Phần còn lại (giá trị biên cụ thể để viết test case) là quyết định thiết kế test ở bước `test-plan`/`test-case`, không phải gap cần dev trả lời. |
| **Nguồn** | User (QC/test lead), xác nhận trong hội thoại Claude Code, 2026-10-02 |
| **Đối chiếu tài liệu** | API §Limits dòng 325–328: ảnh 2 MB ⇒ `413` · publish body 64 KB ⇒ `413` · `template.template` 48 KB ⇒ `400 invalid_template` · 20 ảnh/share ⇒ `400 invalid_template`. API §Errors dòng 45–46: `invalid_template` và `rate_limited` ⇒ cùng thông báo chung *"Couldn't create a share link. Try again."* |
| **Hệ quả lên condition** | **GAP-6 đóng.** **TS-31 / TS-32 / TS-33 / TS-91**: bỏ nhãn chờ Q-9. Thêm note: **giá trị biên cụ thể** (bao nhiêu ảnh / kích thước nào để đạt sát ngưỡng) **do `test-plan`/`test-case` quyết định** (EP/BVA), không chờ dev. |

---

## B · 2 câu NGOÀI PHẠM VI QC đợt `1-2-19` (dev tự verify)

> Đây là quyết định **phạm vi**, **không** phải quyết định về expected result. QC **không** viết oracle
> cho phần này trong đợt `1-2-19`.

### B-Q3 · App Check chấp nhận build nào → **Out of scope, dev tự verify**

| | |
|---|---|
| **Câu hỏi gốc (Q-3)** | **App Check chấp nhận build nào** cho (a) publish/upload (3.1/3.2) và (b) đọc share (3.3)? VI §0.1: chỉ **Ink Prod**. FE §10: *"1.2.19 **or a TestFlight build**"*. API §Testing: gợi ý **simulator** `simctl openurl`. |
| **Quyết định** | **Out of scope đợt `1-2-19` — dev tự test/verify.** Không đưa vào bộ test case QC đợt này. |
| **Lý do** | Quyết định phạm vi của QC/test lead: đây là cấu hình hạ tầng (App Check) do dev sở hữu và tự xác minh, không phải hành vi sản phẩm mà QC cần oracle. Vòng tròn phụ thuộc với Q-2 cũng tự tan vì đợt này đã chốt **APP-ONLY** (A-Q2). |
| **Nguồn** | User (QC/test lead), xác nhận trong hội thoại Claude Code, 2026-10-02 |
| **Hệ quả lên condition** | **TS-93** giữ nguyên trong file, đổi trạng thái thành **"Out of scope đợt `1-2-19` — dev tự verify"** (thay vì chờ trả lời). **Môi trường test của QC** đợt này = đúng **VI §0.1** (Ink Prod 1.2.19, máy thật, 2 máy A/B) vì VI là checklist đang chạy — biến thể TestFlight (FE §10) và simulator (API §Testing) thuộc dev/FE. |

### B-Q5 · Ảnh preview công khai có rò ảnh riêng → **Out of scope, dev tự verify**

| | |
|---|---|
| **Câu hỏi gốc (Q-5)** | Khi người gửi chọn **Use Ink backgrounds**, ảnh **preview công khai** (`preview_url`, cũng là `og:image` trong card chat) **có bắt buộc** được render lại **không chứa ảnh riêng** hay không? |
| **Quyết định** | **Out of scope đợt `1-2-19` — dev tự test/verify.** Phần "ảnh preview công khai" không nằm trong bộ test case QC đợt này. |
| **Lý do** | Quyết định phạm vi của QC/test lead cho đợt này. **Không** phải kết luận rằng hành vi đó đúng/sai — QC **không** khẳng định preview có hay không chứa ảnh riêng. |
| **Nguồn** | User (QC/test lead), xác nhận trong hội thoại Claude Code, 2026-10-02 |
| **Hệ quả lên condition** | Đổi nhãn thành **"Out of scope đợt `1-2-19` — dev tự verify"** cho đúng **phần liên quan ảnh preview công khai** của: **TS-14** (phần preview), **TS-27**, **TS-73** (cũng đã hoãn theo A-Q2), **TS-82** (phần ảnh; cũng đã hoãn theo A-Q2). Phần **design data** của TS-14 (`asset_ids = []`, máy B không thấy ảnh riêng trong thiết kế) **vẫn trong phạm vi**. |
| **GAP-3 không đóng** | **GAP-3 tách làm 2:** **GAP-3a** (ảnh preview công khai — **Q-5**) → **đóng vì out of scope**. **GAP-3b** (nền thay thế khi design không có template gốc — **Q-6**) → **vẫn MỞ, vẫn CHẶN**. |

---

## C · 3 câu **đã được QC/test lead CHỦ ĐỘNG CHỐT** (2026-10-02, đợt 2) — mức tin cậy khác nhau

> **Trạng thái trước đó:** cả 3 câu (Q-1, Q-6, Q-10) là **câu hỏi CHẶN** thuộc mục 0 của skill
> `test-analysis`, đang **chờ dev**. **Không có dev nào trả lời.**
>
> **Nguồn mới (áp dụng cho cả 3 câu):** **User (QC/test lead), chủ động chốt để đi tiếp pipeline, xác
> nhận trong hội thoại Claude Code, 2026-10-02 — KHÔNG phải câu trả lời từ dev, độ tin cậy khác nhau
> theo từng câu như ghi dưới đây.**
>
> ⚠️ Vì đây **không** phải fact từ dev, mỗi quyết định dưới đây đi kèm **mức tin cậy** phải được
> `test-plan`/`test-case` mang theo nguyên văn. Mức tin cậy **THẤP** (Q-6) đặc biệt phải được coi là
> expected result **tạm**, có thể phải sửa.

| # | Mức tin cậy | Tóm tắt quyết định |
|---|---|---|
| **Q-1** | **CAO** | App 1.2.19 **không có** UI "link của tôi" / "ngừng share" |
| **Q-10** | **TRUNG BÌNH** | Cache link thiết bị **bị xoá** khi xoá tài khoản **và** khi đăng xuất / đổi account |
| **Q-6** | **THẤP** | Nền thay thế = **nền mặc định chung của hệ thống** (suy luận kỹ thuật, không có dòng nào trong 3 tài liệu gợi ý trực tiếp) |

### C-Q1 · UI "link của tôi" / "ngừng share" trong app 1.2.19 → **KHÔNG CÓ** · tin cậy **CAO**

| | |
|---|---|
| **Câu hỏi gốc (Q-1)** | App **1.2.19 có** màn "link của tôi" (API §3.8) và nút **"ngừng share một link"** (API §3.9) **hay không**? VI §KN.2 nói **chưa có**; API §Section numbers nói **"the app calls 3.1–3.4 and 3.8–3.9"** và API §3.9 còn mô tả hành vi **của app** (xoá cache `ink.template.share.links.v1` sau khi delete). |
| **Quyết định** | **App 1.2.19 KHÔNG có UI này** (không có danh sách "link của tôi", không có nút ngừng share/xoá một link). ⇒ **Cách hiểu A** của TB-01. |
| **Mức tin cậy** | **CAO** |
| **Lý do (nguyên văn theo user)** | VI (chính checklist QC viết riêng cho đợt test 1.2.19, phần *"Đã biết, không cần báo lỗi"*) khẳng định trực tiếp "chưa có cách xoá riêng một link, chưa có danh sách 'link của tôi'" — đây là nguồn mô tả **hiện trạng UI** đáng tin hơn so với câu liệt kê route trong API doc (API doc liệt kê đầy đủ protocol/route đã có ở backend, kể cả phần 3.8/3.9 có thể chưa lộ ra UI app đợt này). |
| **Nguồn** | User (QC/test lead), chủ động chốt để đi tiếp pipeline, hội thoại Claude Code, 2026-10-02 — **không** phải câu trả lời từ dev |
| **Hệ quả lên condition** | **GAP-1 và GAP-2 ĐÓNG** — **không** sinh condition UI cho "list my shares" (3.8) / "stop sharing" (3.9) trong app ở đợt `1-2-19`. Route **3.8/3.9 coi như ngoài phạm vi UI test đợt này**, **chỉ** test bằng `curl` nếu cần, ở nhóm NF (tuỳ chọn, không bắt buộc). **TS-26: gỡ nhãn chờ Q-1.** TS-21, TS-66 cũng gỡ nhãn Q-1. |
| **Rủi ro còn lại (QC chủ động ghi)** | Nếu dev sau này xác nhận app **có** gọi 3.8/3.9 thì thiếu ~10–12 condition (có 2–3 P1 về **thu hồi link công khai**) ⇒ phải bổ sung ở slug mới. Ngoài ra: **không có đường thu hồi link trong app** là **residual risk về riêng tư** (link đã tạo chỉ mất khi xoá tài khoản — VI §KN.2) ⇒ `test-plan` phải ghi, không im lặng. |

### C-Q10 · Cache link thiết bị khi logout / đổi account / xoá tài khoản → **BỊ XOÁ** · tin cậy **TRUNG BÌNH**

| | |
|---|---|
| **Câu hỏi gốc (Q-10)** | Cache link thiết bị `ink.template.share.links.v1` **có bị xoá** khi **xoá tài khoản** và khi **đăng xuất / đổi account** không? Nếu không, lần Share tiếp theo phát **link đã chết** mà người gửi không biết (API §3.9 cảnh báo đúng rủi ro này, nhưng §Account deletion **không** nhắc). |
| **Quyết định** | **Cache bị xoá trong CẢ HAI trường hợp:** (a) **xoá tài khoản** · (b) **đăng xuất / đổi account**. ⇒ **Cách hiểu A** của TB-10. |
| **Mức tin cậy** | **TRUNG BÌNH** |
| **Lý do (nguyên văn theo user)** | (a) Nhất quán với việc **server xoá hết share khi xoá account** (API §Account deletion) — giữ cache sau đó chỉ có thể phát ra link đã chết. (b) Nguyên tắc: cache này **gắn theo account đang đăng nhập**; không xoá sẽ là **rủi ro** — account B có thể vô tình **thấy / tái dùng link cache của account A** trên cùng một máy. |
| **Nguồn** | User (QC/test lead), chủ động chốt để đi tiếp pipeline, hội thoại Claude Code, 2026-10-02 — **không** phải câu trả lời từ dev |
| **Hệ quả lên condition** | **GAP-7 ĐÓNG.** Oracle cho **TS-66** (sau khi xoá tài khoản + đăng nhập lại + Share lại cùng wallpaper ⇒ app tạo **link mới**, không phát lại link chết) · **TS-21 / TS-26** gỡ nhãn chờ Q-10 (cache không còn là ẩn số đổi pass/fail). `test-plan` nên sinh thêm case cho **2 nhánh**: *đăng xuất → đăng nhập lại cùng account* và *đổi sang account khác trên cùng máy* (không thấy/không tái dùng link của account cũ). |
| **Rủi ro còn lại** | Tin cậy **TRUNG BÌNH**: nhánh xấu (cache **không** bị xoá) là **lỗi im lặng** — nếu app thực tế không xoá cache thì case sẽ **fail** và đó chính là bug cần báo; nhưng nếu dev khẳng định "by design không xoá" thì expected result của TS-66 phải viết lại. |

### C-Q6 · Nền thay thế khi chọn *Use Ink backgrounds* mà design không có template gốc → **nền mặc định chung của hệ thống** · tin cậy **THẤP**

| | |
|---|---|
| **Câu hỏi gốc (Q-6)** | Khi bỏ ảnh riêng ra (*Use Ink backgrounds*), **nền thay thế** chính xác là gì — nền catalog của template gốc, nền mặc định của app, hay publish **thất bại `400 invalid_template`** — trong trường hợp design tự dựng (`stack`, **không** `origin_template_id`) mà nền duy nhất là ảnh riêng? |
| **Quyết định (TẠM)** | App thay bằng **nền mặc định chung của hệ thống** — **không** phải một nền catalog cụ thể nào, vì design dạng `stack` tự dựng **không có catalog để tham chiếu**. ⇒ gần **Cách hiểu B** của TB-06 (không phải A, không phải C). |
| **Mức tin cậy** | **THẤP — ghi rõ.** Đây là **suy luận kỹ thuật hợp lý nhất** khi **không có dòng nào trong 3 tài liệu test basis gợi ý trực tiếp**. **KHÔNG phải fact**, và **độ tin cậy thấp hơn mọi assumption trước đó** (Q-2/Q-4/Q-7/Q-8/Q-9). |
| **Lý do (nguyên văn theo user)** | Design dạng `stack` tự dựng không có catalog để tham chiếu, nên nền thay thế hợp lý nhất là nền mặc định chung của hệ thống; không tài liệu nào nói khác, cũng không tài liệu nào xác nhận. |
| **Nguồn** | User (QC/test lead), chủ động chốt để đi tiếp pipeline, hội thoại Claude Code, 2026-10-02 — **không** phải câu trả lời từ dev |
| **Hệ quả lên condition** | **GAP-3b đóng TẠM THỜI.** **TS-14** (phần nền) và **TS-15** gỡ nhãn chặn, dùng expected result tạm nêu trên. |
| **Open Question MỚI (không chặn) — bắt buộc giữ** | **O-24:** *"Xác nhận lại với dev nền mặc định chính xác là gì khi có cơ hội — nếu sai sẽ đổi expected result của TS-14 (phần nền) và TS-15."* Phải xuất hiện trong mục 4B của test-analysis và được `test-plan` mang sang. |

---

## D · Tóm tắt trạng thái sau khi ghi nhận **10/10** quyết định (2026-10-02, đợt 2)

| | |
|---|---|
| **Câu CHẶN ban đầu** | 10 (Q-1 → Q-10) |
| **Đã chốt bằng assumption có xác nhận của QC/test lead** | **8** — đợt 1: Q-2, Q-4, Q-7, Q-8, Q-9 · **đợt 2:** Q-1 *(tin cậy CAO)*, Q-10 *(TRUNG BÌNH)*, Q-6 *(THẤP)* |
| **Chuyển thành out of scope (dev tự verify)** | 2 — Q-3, Q-5 |
| **Còn CHẶN** | **0** |
| **GAP đã đóng** | GAP-3a (out of scope) · GAP-4 · GAP-5 · GAP-6 · **GAP-1, GAP-2** (Q-1 — route 3.8/3.9 ngoài phạm vi UI đợt này) · **GAP-3b** (Q-6 — đóng **TẠM**, tin cậy THẤP) · **GAP-7** (Q-10) |
| **GAP còn mở** | **GAP-8** duy nhất — ⏸ **parked** (nhánh `410` moderation chưa build, không tạo được dữ liệu; không tính vào coverage) |
| **Open Question mới sinh ra ở đợt 2** | **O-24** (xác nhận nền mặc định với dev — hệ quả của Q-6 tin cậy THẤP) · **O-25** (xác nhận lại Q-1/Q-10 với dev khi có dịp — do 2 câu này do QC tự chốt, không phải dev) |
| **Analysis Status của `test-analysis-1-2-19.md`** | **`READY`** *(cập nhật 2026-10-02 — xem §E bên dưới)*. Trạng thái trước đó: `DRAFT` — **0 câu CHẶN** ở mục 4A nhưng mục 4 còn **25 câu MỞ (O-1 → O-25)**, trong đó **O-21** là điều kiện cuối cùng. Agent **không** tự chuyển `DRAFT → READY` (`.claude/rules/testing.md`) — việc chuyển do **con người** quyết. |
| **Downstream Permission** | **`ALLOWED`** *(cập nhật 2026-10-02 — xem §E)*. Trước đó: `BLOCKED`. |
| **Ai được chuyển `DRAFT → READY`** | **Chỉ con người (QC/test lead).** Điều kiện tối thiểu: (1) phê chuẩn **thang risk / ưu tiên P1-P2-P3** ở mục 2 (**O-21**) · (2) xác nhận các O-* còn lại là **quyết định ở bước `test-plan`** (môi trường/mock **O-11**, device matrix **O-14**, baseline ảnh **O-9**, ngưỡng hiệu năng **O-15**, phương tiện tạo dữ liệu hạn mức **O-20**) chứ không phải gap chặn phân tích. Sau đó sửa banner + mục 5 của test-analysis. ⇒ **Đã thoả đủ 3/3 ngày 2026-10-02, xem §E.** |

---

## E · Xác nhận cuối — chuyển `DRAFT → READY` (**2026-10-02**)

| | |
|---|---|
| **Ngày** | **2026-10-02** |
| **Người xác nhận** | **User — QC/test lead của project**, xác nhận trực tiếp trong **hội thoại Claude Code** (ghi nhận qua orchestrator `/spec-intake`). **Không** phải dev, **không** phải suy diễn của agent. |
| **Quyết định** | **`test-analysis-1-2-19.md`: Analysis Status `DRAFT` → `READY`** · **Downstream Permission `BLOCKED` → `ALLOWED`** ⇒ `test-plan` cho slug `1-2-19` **được phép chạy**. |
| **3 điều kiện đã được xác nhận** | **(1)** **Phê chuẩn thang risk & ưu tiên P1/P2/P3** ở mục 2 của test-analysis (**O-21** — thang do QC tự đặt vì bundle không có số liệu business). **(2)** Các Open Question còn lại về **baseline ảnh/screenshot (O-9)**, **device matrix (O-14)**, **môi trường mock/staging (O-11)**, **ngưỡng hiệu năng (O-15)**, **cách tạo dữ liệu rate-limit (O-20)** là **việc thuộc bước `test-plan`** — **descope tường minh** nếu thiếu phương tiện — **không** phải gap chặn phân tích. **(3)** **O-24** (nền thay thế — thay cho Q-6, tin cậy **THẤP**) và **O-25** (xác nhận lại Q-1 **CAO** + Q-10 **TRUNG BÌNH** với dev) tiếp tục chạy **song song, không chặn**. |
| **Điều kiện kèm theo (bắt buộc, không được bỏ)** | `test-plan` và `test-case` **phải mang theo đúng mức tin cậy của từng assumption** (**CAO** / **TRUNG BÌNH** / **THẤP**) — **không được tô đều ngang hàng**. Riêng **Q-6 (THẤP)** phải được viết như **oracle TẠM** cho TS-14 (phần nền) và TS-15. |
| **Những gì KHÔNG đổi** | **Không** sửa bất kỳ test condition / risk level / assumption nào. **10 quyết định ở §A–§C vẫn là assumption của QC/test lead, KHÔNG phải fact từ dev.** **24 câu MỞ còn lại (O-1 → O-25, trừ O-21) giữ nguyên**, phải được `test-plan` mang sang. **20 vấn đề testability mức `MỞ` (TB-11 → TB-30) vẫn tồn tại.** **GAP-8 vẫn ⏸ parked.** |
| **Ghi nhận bởi** | Agent `qc-test-analysis` — **chỉ ghi lại** quyết định của con người, không tự chuyển trạng thái. |
