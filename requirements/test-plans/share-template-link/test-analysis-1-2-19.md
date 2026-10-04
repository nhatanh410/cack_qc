# Test Analysis — Share Template as a Link (Ink Prod **1.2.19**) · slug `1-2-19`

> ✅ **READY — do con người chốt, 2026-10-02.** **0 câu CHẶN** (10/10 câu đã xử lý) và **cả 3 điều kiện
> tối thiểu** để mở cổng `test-plan` đã được xác nhận: (1) **phê chuẩn thang risk & ưu tiên P1/P2/P3** ở
> mục 2 (**O-21**) · (2) các Open Question còn lại về **baseline ảnh (O-9), môi trường mock/staging
> (O-11), device matrix (O-14), ngưỡng hiệu năng (O-15), phương tiện tạo dữ liệu hạn mức (O-20)** là
> **việc quyết ở bước `test-plan`** (descope tường minh nếu thiếu phương tiện), **không** phải gap chặn
> phân tích · (3) **O-24** (nền thay thế — Q-6, tin cậy **THẤP**) và **O-25** (xác nhận lại Q-1 **CAO** +
> Q-10 **TRUNG BÌNH** với dev) chạy **song song, không chặn**, **với điều kiện** `test-plan`/`test-case`
> mang theo **đúng mức tin cậy từng assumption**, **không** tô đều ngang hàng.
> **Nguồn xác nhận:** **User (QC/test lead), xác nhận cả 3 điều kiện trong hội thoại Claude Code,
> 2026-10-02.** (Chuyển trạng thái do **con người** quyết, agent chỉ ghi nhận — theo
> [`.claude/rules/testing.md`](../../../.claude/rules/testing.md); ghi nhận qua orchestrator
> `/spec-intake`.) **24 câu MỞ (O-1 → O-25, trừ O-21 đã chốt) KHÔNG bị xoá** — mang nguyên sang
> `test-plan`.
>
> ⚠️ **READY KHÔNG có nghĩa test basis đã sạch:** 20 vấn đề testability mức `MỞ` (TB-11 → TB-30) **vẫn
> tồn tại**, 10 quyết định ở [answers-1-2-19.md](answers-1-2-19.md) **vẫn là assumption của QC/test
> lead, KHÔNG phải fact từ dev**, và **2 condition dùng oracle TẠM** (TS-14 phần nền, TS-15).
>
> **Cập nhật 2026-10-02 (đợt 2) — 3 câu CHẶN cuối cùng đã được QC/test lead CHỦ ĐỘNG CHỐT để đi tiếp
> pipeline, KHÔNG chờ dev** — nguồn + lý do đầy đủ ở [answers-1-2-19.md §C](answers-1-2-19.md).
> **Mức tin cậy KHÔNG như nhau — bắt buộc mang nguyên sang `test-plan`/`test-case`:**
> - **Q-1 · tin cậy CAO:** app 1.2.19 **không có** UI "link của tôi"/"ngừng share". Nguồn mạnh nhất là
>   **VI §KN.2** (checklist QC viết riêng cho đợt 1.2.19, mô tả **hiện trạng UI**) — đáng tin hơn câu
>   liệt kê route ở API doc. ⇒ **GAP-1, GAP-2 đóng**; route **3.8/3.9 ngoài phạm vi UI test** đợt này
>   (chỉ `curl` nếu cần, nhóm NF, tuỳ chọn). **Residual risk:** app **không có đường thu hồi link** —
>   link chỉ mất khi xoá tài khoản.
> - **Q-10 · tin cậy TRUNG BÌNH:** cache `ink.template.share.links.v1` **bị xoá** khi **xoá tài khoản**
>   *và* khi **đăng xuất/đổi account** (cache gắn theo account đang đăng nhập; không xoá thì account B
>   có thể thấy/tái dùng link của account A trên cùng máy). ⇒ **GAP-7 đóng**.
> - **Q-6 · tin cậy THẤP (ghi rõ, không tô hồng):** nền thay thế = **nền mặc định chung của hệ thống**
>   (design `stack` tự dựng không có catalog để tham chiếu). Đây là **suy luận kỹ thuật**, **không**
>   phải fact, **không có dòng nào trong 3 tài liệu gợi ý trực tiếp** ⇒ **GAP-3b đóng TẠM**, kèm
>   **Open Question mới O-24** (xác nhận lại với dev; nếu sai thì đổi expected result **TS-14** phần nền
>   và **TS-15**).
>
> **Đã xử lý trước đó (đợt 1, 2026-10-02):** **Đã chốt (assumption có xác nhận của QC/test lead, KHÔNG
> phải fact từ dev):** **Q-2** (phạm vi đợt này = **APP-ONLY**, trang web `/t/<id>` hoãn sang đợt riêng)
> · **Q-4** (trang theo ngôn ngữ **visitor**) · **Q-7** (**id đã biết** ⇒ theo cờ Pro thật; **id lạ** ⇒
> luôn coi là Pro) · **Q-8** (wallpaper áp dụng giống preview về **style/bố cục**, dữ liệu sự kiện luôn
> là **của máy B**) · **Q-9** (giới hạn publish đã đủ định nghĩa ở API §Limits + §Errors).
> **Out of scope đợt `1-2-19` — dev tự verify:** **Q-3** (App Check chấp nhận build nào) · **Q-5** (ảnh
> **preview công khai** có rò ảnh riêng khi chọn *Use Ink backgrounds*).
>
> **Analysis Status: `READY`** · **Downstream Permission: `ALLOWED`** (chuyển từ `DRAFT`/`BLOCKED` ngày
> **2026-10-02**) — theo [`.claude/rules/testing.md`](../../../.claude/rules/testing.md) chỉ `READY` mới
> được chạy `test-plan`, và **chỉ con người** được chuyển `DRAFT → READY`: việc chuyển này là **quyết
> định của User (QC/test lead), xác nhận cả 3 điều kiện trong hội thoại Claude Code, 2026-10-02**, agent
> chỉ **ghi nhận**. Agent cũng **không** tự trả lời câu nào: toàn bộ 10 quyết định đều do **con người
> (QC/test lead)** đưa ra và được ghi nguồn ở `answers-1-2-19.md`.
>
> **Phạm vi sau quyết định Q-2:** **79/98 condition** nằm trong phạm vi đợt `1-2-19` (P1 = 34 · P2 = 37
> · P3 = 8) — **số lượng không đổi** sau đợt 2 (Q-1 **không** sinh condition mới vì 3.8/3.9 ra ngoài
> phạm vi UI; Q-6/Q-10 chỉ **cấp oracle** cho condition đã có). **Hoãn (18):** 17 condition nhóm L
> (TS-73 → TS-89, gồm TS-88) + TS-69. **Out of scope (1):** TS-93 (+ phần "ảnh preview công khai" của
> TS-14/TS-27). **Mới sinh ra từ quyết định Q-7:** TS-54b.
> **Không còn condition nào bị CHẶN** — TS-14, TS-15, TS-21, TS-26, TS-66 đã có oracle (kèm mức tin cậy
> của Q-1/Q-6/Q-10).

> **Test basis (3 file, 3 đối tượng, cùng một luồng end-to-end):**
> 1. [template-sharing-vi.md](../../specs/share-template-link/template-sharing-vi.md) — checklist QC
>    tiếng Việt, **hành vi app nhìn từ user** (máy A gửi / máy B nhận). Mã trích dẫn: `VI §N.MM`.
> 2. [fe-template-share-page.md](../../specs/share-template-link/fe-template-share-page.md) — spec dev
>    cho **team web** (fe-ink-calendar) build trang `/t/<id>` trên `inkcalendar.app`. Mã: `FE §N`.
> 3. [template-sharing-api.md](../../specs/share-template-link/template-sharing-api.md) — **API
>    contract** app ↔ Worker (live production). Mã: `API §3.x`.
>
> **Tài liệu được 3 file trên tham chiếu nhưng KHÔNG có trong bundle** (⇒ coi là **thiếu**, không suy
> diễn nội dung): `runbooks/template-sharing.md` (product behaviour + app internals — nguồn duy nhất
> cho nội bộ app), `template-sharing.md` (backend rationale, gốc của cách đánh số §3),
> `template-sharing-history.md` (gốc của §3.8–3.9), `template-sharing-web-page.md` (API §Not available
> yet — *giả định* là chính file FE đã nhận, **chưa xác nhận**). Xem TB-11, TB-28.
>
> **Chuẩn:** ISTQB Foundation Level v4.0.1
> [§1.4.1](../../istqb-foundation/ISTQB_CTFL_Syllabus_v4.0.1.md) (Test Analysis) + §3 (Static Testing)
> + §5.2 (Risk Management: risk level = risk likelihood × risk impact) + §4.5.2 (Acceptance Criteria).
> **Bước tiếp theo:** `test-plan` sẽ dùng **mục 2** làm test object và cột **Risk level / Ưu tiên** làm
> cơ sở risk-based prioritization — **đã được phép chạy** từ 2026-10-02 (`READY`, xem banner + mục 5).
> **Ngày lập:** 2026-10-02 · **Người lập:** QC (agent `qc-test-analysis`)
>
> **Quy ước mã traceability (do QC gán, KHÔNG có trong test basis):** checklist VI không có mã cho
> từng ô tick → `VI §N.MM` = ô tick thứ `MM` của mục `N` (vd `VI §4.02` = ô tick thứ 2 của mục 4), kèm
> trích đoạn ngắn để tránh nhầm. `VI §0.x` = mục **Chuẩn bị**. `VI §KN.x` = mục *"Đã biết, không cần
> báo lỗi"*.
>
> **Phạm vi đã xác nhận với user (không phải suy diễn):** build target **Ink Prod 1.2.19** trên **máy
> thật** (simulator/Dev không share được) · feature **không** liên quan flow `11_share` (share lịch /
> co-edit, Phase 2) → **không** đối chiếu `login-and-calendar-sharing/` hay `ink-identity-sync-flow/` ·
> chưa có screenshot/UI thật nào kèm bundle.

---

## 1. Đánh giá testability của test basis

> "Defect trong chính tài liệu" (ISTQB §3 — ambiguity / incompleteness / inconsistency), **không phải**
> defect của app.
> Cột **Mức**: `CHẶN` = thuộc mục 0 của skill `test-analysis` (2 cách hiểu cho 2 tập test condition /
> expected result trái ngược, mâu thuẫn nội bộ, hoặc thiếu acceptance criteria) → **không viết được**
> condition/oracle khi chưa có trả lời · `MỞ` = viết được condition nhưng giảm độ chính xác (thiếu giá
> trị biên, thiếu oracle định lượng, thiếu phương tiện đo, hoặc chỉ ảnh hưởng **triage** pass/fail).

### 1A · Vấn đề **từng** ở mức `CHẶN` — **0 còn CHẶN / 10 ban đầu**

> **Cập nhật 2026-10-02 (đợt 2):** cột **Mức** đã đổi cho **cả 10 dòng**. `ĐÃ CHỐT` = đã có
> **assumption được QC/test lead xác nhận** (không phải fact từ dev) · `OUT OF SCOPE` = đã chuyển ra
> khỏi phạm vi QC đợt `1-2-19`, dev tự verify. **Không còn dòng nào mức `CHẶN`.**
>
> ⚠️ **Vấn đề trong tài liệu VẪN TỒN TẠI** — việc nó không còn chặn đợt này **không** có nghĩa là test
> basis đã sạch. Mỗi dòng `ĐÃ CHỐT` ghi kèm **mức tin cậy**; dòng tin cậy **THẤP/TRUNG BÌNH** (TB-06 /
> TB-10) phải được coi là **oracle tạm** và sửa lại ngay khi dev trả lời khác.
> **Quy ước mức tin cậy:** `CAO` = có nguồn văn bản trực tiếp trong test basis đứng về phía quyết định ·
> `TRUNG BÌNH` = suy ra từ nguyên tắc nhất quán với tài liệu, không có câu trực tiếp · `THẤP` = **suy
> luận kỹ thuật**, không tài liệu nào gợi ý trực tiếp.

| # | Trích đoạn / mục trong test basis | Vấn đề | Loại | Mức | Cần hỏi ai | Ảnh hưởng |
|---|---|---|---|---|---|---|
| TB-01 | **VI §KN.2** "Chưa có cách **xoá riêng một link**, chưa có **danh sách 'link của tôi'**, chưa có nút báo cáo. **Link chỉ mất khi xoá tài khoản**." ↔ **API §Section numbers** "3.8–3.9 are the owner calls requested in `template-sharing-history.md`. **The app calls 3.1–3.4 and 3.8–3.9**"; **API §3.9** còn mô tả hành vi **của app**: "Drop the device link cache entry for that wallpaper (`ink.template.share.links.v1`) after a successful delete, or the next Share hands out the dead link" | **Mâu thuẫn nội bộ trực tiếp** về việc app 1.2.19 có gọi *list mine* (3.8) và *stop sharing* (3.9) hay không. **Cách hiểu A:** route 3.8/3.9 live ở backend nhưng app 1.2.19 **chưa có UI** → cả cụm ra ngoài phạm vi test app, chỉ kiểm được bằng `curl`; checklist VI đúng. **Cách hiểu B:** app **có** gọi (đúng câu chữ API) → tồn tại một bề mặt UI "link của tôi"/"ngừng share" mà checklist VI **không nhắc một chữ** → thiếu nguyên một cụm ~10 condition (paging `limit`/`cursor`, thứ tự `updated_at` desc, `has_photos`, host-check `preview_url`, delete → 404, recipient không ảnh hưởng, publish lại sinh **id mới**, xoá cache thiết bị, delete lần 2 = 404, rate limit 60/ngày và 60/giờ). Hai cách hiểu cho **hai phạm vi khác hẳn nhau** → không được tự chọn. | Mâu thuẫn nội bộ | **ĐÃ CHỐT · tin cậy CAO** (2026-10-02, đợt 2) — chọn **Cách hiểu A: app 1.2.19 KHÔNG có UI "link của tôi"/"ngừng share"**. Lý do: **VI §KN.2** là checklist QC viết riêng cho đợt 1.2.19, mô tả **hiện trạng UI**, đáng tin hơn câu liệt kê route của API doc (API doc liệt kê đủ protocol/route backend, kể cả phần chưa lộ ra UI). Xem [answers §C-Q1](answers-1-2-19.md). *Quyết định của QC/test lead, 2026-10-02 — **không** phải câu trả lời từ dev.* **Mâu thuẫn văn bản API ↔ VI vẫn chưa được dev sửa** | Test lead *(đã quyết)* / dev *(xác nhận lại sau — **O-25**)* | **GAP-1, GAP-2 → đóng** (3.8/3.9 **ngoài phạm vi UI** đợt này, chỉ `curl` nếu cần ở nhóm NF); TS-21, TS-26, TS-66 **gỡ nhãn Q-1**. **Residual risk:** không có đường thu hồi link trong app |
| TB-02 | **VI §0.6** "trang web `inkcalendar.app/t/<id>` **chưa làm**, nên bấm link https sẽ ra trang lỗi. Đây là **lỗi đã biết, không cần báo**" + **VI §KN.1** ↔ **FE §Status** "**needed before** the Ink app **1.2.19** goes to the App Store" + **FE §1** "Today that URL returns **404** … **Every link a user sends lands on an error page**" + **FE §10** (checklist 12 ô, giả định trang **đã** live, có cả id mẫu `/t/A4k373Bks0Wo`) ↔ **API §Not available yet** "The `/t/<id>` web page (fe-ink-calendar)" | Không xác định được **phạm vi và thứ tự phụ thuộc** của đợt test slug `1-2-19`. **Cách hiểu A:** đợt này **chỉ** test app; trang web là delivery riêng của team web, 17 condition nhóm L ra ngoài phạm vi; exit criteria của 1.2.19 **không** bao gồm trang web (nhưng khi đó **toàn bộ luồng end-to-end thật** — người nhận bấm link https trong chat — **chưa từng được test một lần nào** trước khi lên App Store). **Cách hiểu B:** trang web nằm trong phạm vi (đúng FE §Status) → phải chờ deploy mới chạy được nhóm L + chạy lại nhóm F qua đúng đường vào thật, và entry criteria phải có "trang `/t/` đã live". Hai cách hiểu đổi **phạm vi 17 condition + exit criteria + lịch chạy**. Thêm nữa: hiện trạng "đổi thủ công `https` → `ink://`" (VI §0.6.2) nghĩa là **mọi** condition nhóm F đang được test qua **đường vào không phải đường vào thật của user**. | Mơ hồ (phạm vi) + thứ tự phụ thuộc giữa 2 delivery | **ĐÃ CHỐT** (2026-10-02) — chọn **Cách hiểu A: APP-ONLY**, xem [answers-1-2-19.md §A-Q2](answers-1-2-19.md). *Assumption đã xác nhận bởi QC/test lead, 2026-10-02, không phải fact từ dev.* **Rủi ro còn lại được ghi nhận, không bị xoá:** luồng end-to-end thật (bấm link https trong chat) **chưa từng chạy** trong đợt này | Test lead *(đã quyết)* | Toàn **nhóm L** (TS-73 → TS-89) + TS-69 ⇒ **hoãn khỏi phạm vi `1-2-19`**; **nhóm F** (TS-36 → TS-45) vào qua `ink://` (không phải đường vào thật của user) |
| TB-03 | **VI §0.1** "Bản **Ink Prod 1.2.19** trên **máy thật**. Simulator và bản Dev **không** share được (**App Check** và backend chỉ nhận Ink Prod)" ↔ **FE §10** "iPhone with Ink (**1.2.19 or a TestFlight build**)" ↔ **API §Testing** "Open a share in the simulator without the web page: `xcrun simctl openurl booted \"ink://template?id=<id>\"`" | Ba tài liệu nói **ba môi trường test khác nhau** cho cùng một luồng. Chưa biết App Check chấp nhận **những build nào** (App Store Prod / TestFlight / Dev) và cho **những call nào** — lưu ý `GET /template-share/:id` (3.3, đường **nhận**) cũng **cần App Check** (API §3.3 "App Check only, no Bearer"), nên nếu App Check chỉ nhận Prod thì gợi ý `simctl openurl` của API §Testing **không chạy được quá màn lỗi**, và checklist FE §10 **không thể thực thi** bằng TestFlight → sinh vòng tròn phụ thuộc với TB-02 (trang web phải test xong **trước** khi app lên store, nhưng chỉ app **trên store** mới qua được App Check). Không có câu trả lời thì **không viết được entry criteria** và không biết nhóm L/F chạy được bằng gì. | Mâu thuẫn nội bộ (môi trường test) | **OUT OF SCOPE đợt `1-2-19` — dev tự verify** (2026-10-02, xem [answers §B-Q3](answers-1-2-19.md)). Vòng tròn phụ thuộc với TB-02 tự tan vì đợt này đã chốt **APP-ONLY**. Môi trường QC đợt này = đúng **VI §0.1** (Ink Prod 1.2.19, máy thật, 2 máy A/B); biến thể TestFlight (FE §10) / simulator (API §Testing) thuộc dev/FE | Dev *(tự verify)* | **TS-93 → out of scope**; entry criteria đợt này chốt theo **VI §0.1**; nhóm L đã hoãn (TB-02) |
| TB-04 | **API §3.2** "`lang`: the app's resolved language (`vi`, `en`, `zh-Hant`…) — **the web page is rendered in it**" ↔ **FE §7** "**The site's language decides the page's own text**… Use it [`lang`] only as a **hint**… you **may** fall back to the share's `lang` when the visitor's language can't be decided, then English" | Mâu thuẫn nội bộ về **ngôn ngữ của trang `/t/<id>`**. Case thật: người gửi dùng app tiếng Việt (`lang=vi`), người nhận mở link bằng browser tiếng Anh. **Cách hiểu A (API):** trang hiện **tiếng Việt** (theo `lang` của người gửi) · **Cách hiểu B (FE):** trang hiện **tiếng Anh** (theo người nhận), `lang` chỉ dùng khi không đoán được. **Expected result trái ngược** cho cùng một test. | Mâu thuẫn nội bộ | **ĐÃ CHỐT** (2026-10-02) — chọn **Cách hiểu B (FE thắng): trang theo ngôn ngữ visitor**, `lang` người gửi chỉ là **fallback** khi không xác định được ngôn ngữ visitor, rồi English. Lý do: FE §7 nêu rõ thứ tự ưu tiên; câu của API chỉ là mô tả ngắn cho dev mobile, FE có thẩm quyền cao hơn cho đúng topic này. Xem [answers §A-Q4](answers-1-2-19.md). *Assumption đã xác nhận bởi QC/test lead, 2026-10-02, không phải fact từ dev.* | Test lead *(đã quyết)* | TS-86 (gỡ nhãn mâu thuẫn — **vẫn hoãn** theo TB-02 vì thuộc nhóm L); TS-72 (gỡ nhãn) |
| TB-05 | **VI §4.02** "Chọn **Use Ink backgrounds**, mở link trên máy B: **không có ảnh riêng** của máy A" ↔ **API §3.1** `kind=preview` = "**The design rendered over sample events**, never the user's calendar" (chỉ loại trừ **calendar**, **không** nói gì về ảnh riêng) ↔ **FE §9** `og:image = {preview_url}` (ảnh này **xuất hiện trong card unfurl** ở iMessage/Zalo/Messenger) | **Thiếu acceptance criteria** cho đúng chỗ riêng tư nhất của feature: khi người gửi chọn *Use Ink backgrounds*, **ảnh preview JPEG** (công khai, không cần App Check — API §3.4 — và được chat app hiển thị) có bắt buộc được **render lại không chứa ảnh riêng** hay không? **Cách hiểu A:** có → preview không còn ảnh riêng; nếu thấy ảnh riêng ⇒ **bug rò rỉ P1**. **Cách hiểu B:** không → preview vẫn là bản render đầy đủ (có ảnh riêng), chỉ *design data* bị bỏ ảnh; khi đó "không có ảnh riêng" của VI §4.02 chỉ đúng với **thiết kế**, còn ảnh thật vẫn công khai qua `preview_url` + card chat ⇒ **không phải bug**. Hai cách hiểu cho **pass/fail trái ngược** trên một đường rò rỉ dữ liệu người dùng. Không có quyền chọn hộ. | Thiếu (acceptance criteria) → 2 cách hiểu, expected result trái ngược | **OUT OF SCOPE đợt `1-2-19` — dev tự verify** (2026-10-02, xem [answers §B-Q5](answers-1-2-19.md)). **QC KHÔNG kết luận** cách hiểu nào đúng — chỉ chuyển phần "ảnh preview công khai" ra khỏi phạm vi đợt này. **Vấn đề trong tài liệu vẫn chưa được đóng về mặt nội dung** | Dev *(tự verify)* + PM/privacy | **GAP-3a → đóng (out of scope)**; phần preview của TS-14, TS-27 → out of scope; TS-73, TS-82 đã hoãn theo TB-02. Phần **design data** của TS-14 (`asset_ids = []`) **vẫn trong phạm vi** |
| TB-06 | **VI §4.02** "…**chỉ còn nền của template hoặc catalog**" ↔ **API §3.2** `asset_ids` "`[]` when the user chose *Use Ink backgrounds*"; `backgrounds[].path` phải là `catalog:https://assets.homebod.ai/…` hoặc `shared:<asset_id>`; `backgroundImagePath`/`backgroundSourcePath` **phải null**; `origin_template_id` là **Optional** | "Nền của template **hoặc** catalog" là **hai thứ khác nhau** và tài liệu không nói chọn cái nào theo điều kiện gì. Case không có oracle: design người dùng tự dựng (`layout_kind: stack`, **không** có `origin_template_id`) mà **nền duy nhất là ảnh riêng** → bỏ ảnh riêng ra thì `backgrounds` còn **gì**? **Cách hiểu A:** quay về nền catalog của template gốc (không có template gốc thì…?) · **Cách hiểu B:** nền mặc định/trơ của app · **Cách hiểu C:** publish fail `400 invalid_template` vì `backgrounds` rỗng/không hợp lệ. Ba nhánh cho ba expected result khác nhau ở một partition **chắc chắn gặp** (design 2 trong VI §0.7 có thể đúng dạng này). | Thiếu (acceptance criteria cho nhánh fallback) | **ĐÃ CHỐT TẠM · tin cậy THẤP** (2026-10-02, đợt 2) — gần **Cách hiểu B**: nền thay thế = **nền mặc định chung của hệ thống** (không phải nền catalog cụ thể nào, vì design `stack` tự dựng **không có catalog để tham chiếu**). ⚠️ Đây là **suy luận kỹ thuật hợp lý nhất**, **KHÔNG** phải fact — **không một dòng nào trong 3 tài liệu test basis gợi ý trực tiếp**; độ tin cậy **thấp hơn mọi assumption khác** trong tài liệu này. Xem [answers §C-Q6](answers-1-2-19.md). *Quyết định của QC/test lead, 2026-10-02 — không phải câu trả lời từ dev.* | Test lead *(đã quyết tạm)* / **dev (phải xác nhận lại — O-24)** | **GAP-3b → đóng TẠM**; TS-14 (phần nền), TS-15 có oracle **tạm**. **Nếu dev trả lời khác ⇒ đổi expected result TS-14 + TS-15** (**O-24**, không chặn) |
| TB-07 | **API §3.3** "**Never trust a Pro flag from the share**: decide Pro from the local catalog by template id, and **treat an unknown template as Pro**" ↔ **VI §9.01** "Free + design **không** có tuỳ chỉnh Pro: **Set as current** chạy bình thường, **không có paywall**" | Mâu thuẫn ở nhánh **template id không có trong catalog local của máy B**: xảy ra rất dễ (người gửi ở catalog mới hơn; hoặc design tự dựng `stack` **không có** `origin_template_id`; hoặc `template` body rỗng). **Cách hiểu A (API thắng):** mọi design "lạ" ⇒ coi là Pro ⇒ máy B Free bấm Set as current **phải** thấy paywall, **kể cả** khi design không có một tuỳ chỉnh Pro nào ⇒ VI §9.01 sai với nhóm design này. **Cách hiểu B (VI thắng):** chỉ design có tuỳ chỉnh Pro thật mới bị gate ⇒ nếu thấy paywall trên design "sạch" thì **report bug**. Expected result **ngược nhau** trên 4 condition P1 của nhóm Pro, và sai hướng nào cũng hỏng: hoặc chặn user Free vô cớ, hoặc hở paywall. | ~~Mâu thuẫn nội bộ~~ → **2 nhánh phân biệt được bằng điều kiện** | **ĐÃ CHỐT** (2026-10-02) — **không thực sự mâu thuẫn**: VI §9.01 nói về design **thuộc catalog đã biết** (id nhận diện được) không có Pro customization; API "unknown id ⇒ Pro" chỉ áp dụng khi máy B **không nhận ra id** (app cũ hơn / design `stack` không `origin_template_id`). Hai tình huống khác nhau, không loại trừ nhau. Xem [answers §A-Q7](answers-1-2-19.md). *Assumption đã xác nhận bởi QC/test lead, 2026-10-02, không phải fact từ dev.* | Test lead *(đã quyết)* | **GAP-4 → đóng**; TS-54 → TS-57 và TS-39 được **tách nhánh** (xem mục 2) |
| TB-08 | **VI §9.04** "**Wallpaper hiện lên màn khoá đúng như bản xem trước**, qua Shortcut như mọi wallpaper khác" ↔ **VI §3.04** "Bản xem trước **không** chứa sự kiện thật của máy A. Nó **chỉ hiện sự kiện mẫu**" ↔ **API §3.2** "**Strip device state first: selected calendars**, note id, album id, rotation clock" | Không có oracle cho kết quả cuối cùng của cả luồng. Nếu preview là **sự kiện mẫu** và payload đã **xoá danh sách calendar đã chọn**, thì wallpaper của máy B **không thể** "đúng như bản xem trước": **A** = giống về **style/bố cục**, còn dữ liệu là **lịch của máy B** (calendar nào? tất cả? mặc định nào?) · **B** = giống y hệt kể cả sự kiện ⇒ tức wallpaper áp dụng vẫn hiện **sự kiện mẫu** (gần như chắc chắn là bug) · **C** = trống rỗng vì không calendar nào được chọn. Ba nhánh, ba kết luận pass/fail khác nhau ở **điểm cuối** của toàn bộ feature. Tài liệu `runbooks/template-sharing.md` — nơi duy nhất có thể định nghĩa chỗ này — **không có trong bundle** (TB-11). | ~~Thiếu (acceptance criteria cho kết quả cuối)~~ → đã có oracle | **ĐÃ CHỐT** (2026-10-02) — chọn **Cách hiểu A**: *"giống bản xem trước"* = giống về **style/bố cục**; **dữ liệu sự kiện/calendar luôn là của máy B (máy nhận)**, **không bao giờ** là dữ liệu từ máy A. Lý do: đây là cách mọi template trong app vốn hoạt động (preview luôn render sự kiện mẫu, áp dụng thật luôn dùng lịch thật của máy đang dùng) — không phải hành vi riêng của feature share. Xem [answers §A-Q8](answers-1-2-19.md). *Assumption đã xác nhận bởi QC/test lead, 2026-10-02, không phải fact từ dev.* | Test lead *(đã quyết)* | **GAP-5 → đóng**; TS-58 + TS-27 có oracle rõ (xem mục 2). Còn hở **không chặn**: *calendar nào* của máy B được bind sau Add ⇒ hạ xuống **O-22** |
| TB-09 | **API §Limits**: ảnh 2 MB · publish body **64 KB** · `template.template` **48 KB** · **20** ảnh/share · 100 upload + 50 MB/ngày · **30 publish/ngày** · 500 link/account; **API §3.1/§3.2** "check before sending" | **Thiếu acceptance criteria phía app** cho nhánh "design vượt giới hạn" — nhánh này **hiện thực tế** với design trang trí nặng (nhiều sticker ảnh, stack nhiều band): **A** = app tự hạ kích thước / tự cắt bớt để luôn vừa (user không bao giờ thấy lỗi) · **B** = app chặn trước và hiện lỗi (lỗi gì? API nói `invalid_template` → *"Couldn't create a share link. Try again."* — thông báo **không** nói lý do, user không biết phải làm gì) · **C** = gửi đi rồi nhận `413`/`400` và hiện cùng thông báo chung. Ba nhánh cho ba expected result; cũng không có **giá trị biên** nào trên UI (bao nhiêu ảnh/bao nhiêu trang trí là "vượt") để thiết kế BVA. Checklist VI **không có một ô tick nào** cho nhóm này. | ~~Thiếu (acceptance criteria + giá trị biên)~~ → hành vi đã đủ định nghĩa; phần còn lại là **việc thiết kế test** | **ĐÃ CHỐT** (2026-10-02) — **không còn là ambiguity ở mức test-analysis**: API §Limits đã chốt mã lỗi cho từng loại vượt ngưỡng (ảnh 2 MB ⇒ `413` · publish body 64 KB ⇒ `413` · `template.template` 48 KB ⇒ `400 invalid_template` · 20 ảnh/share ⇒ `400 invalid_template`) + API §Errors chốt thông báo người dùng (`invalid_template` ⇒ *"Couldn't create a share link. Try again."*). **Giá trị biên cụ thể** để viết case là **quyết định thiết kế test ở `test-plan`/`test-case`** (EP/BVA), không phải gap cần dev trả lời. Xem [answers §A-Q9](answers-1-2-19.md). *Assumption đã xác nhận bởi QC/test lead, 2026-10-02, không phải fact từ dev.* | Test lead *(đã quyết)* | **GAP-6 → đóng**; TS-31, TS-32, TS-33, TS-91 bỏ nhãn chờ |
| TB-10 | **API §3.9** "**Drop the device link cache entry** for that wallpaper (`ink.template.share.links.v1`) after a successful delete, **or the next Share hands out the dead link**" ↔ **API §Account deletion** "`DELETE /api/ink/v2/account` now also deletes **every** template share of the account and its images. Their links return `404`" (**không** nói gì về cache thiết bị) ↔ **VI §11** chỉ kiểm link cũ trên máy B và bản copy của máy B | Khoảng trống oracle ở đúng đường "xoá tài khoản rồi dùng lại app": cache `ink.template.share.links.v1` trên máy A có bị xoá khi **xoá tài khoản** (và khi **đăng xuất**) không? **Cách hiểu A:** có → sau khi đăng nhập lại và Share lại cùng wallpaper, app tạo link **mới** (`201`), link hoạt động. **Cách hiểu B:** không → app phát lại **link đã chết**, người nhận thấy *"Template unavailable"* mà người gửi **không hề biết**. Pass/fail ngược nhau, và nhánh B là lỗi im lặng khó phát hiện nếu không có condition tường minh. Tương tự cho đăng xuất → đăng nhập **account khác** trên cùng máy (link của account cũ còn trong cache?). | Thiếu (acceptance criteria) → 2 cách hiểu, expected result trái ngược | **ĐÃ CHỐT · tin cậy TRUNG BÌNH** (2026-10-02, đợt 2) — chọn **Cách hiểu A: cache BỊ XOÁ** cả khi **xoá tài khoản** (nhất quán với việc server xoá hết share khi xoá account) **và** khi **đăng xuất / đổi account** (cache gắn theo account đang đăng nhập; không xoá ⇒ account B có thể thấy/tái dùng link của account A trên cùng máy). Xem [answers §C-Q10](answers-1-2-19.md). *Quyết định của QC/test lead, 2026-10-02 — không phải câu trả lời từ dev.* **API §Account deletion vẫn không nhắc cache thiết bị** — khoảng trống văn bản chưa được đóng | Test lead *(đã quyết)* / dev *(xác nhận lại — **O-25**)* | **GAP-7 → đóng**; TS-66 có oracle (Share lại sau khi tạo account mới ⇒ **link mới**, không phát lại link chết); TS-21, TS-26 **gỡ nhãn Q-10**. `test-plan` sinh thêm 2 nhánh: *đăng xuất → đăng nhập lại* và *đổi account trên cùng máy* |

### 1B · Vấn đề mức `MỞ` (20)

| # | Trích đoạn / mục trong test basis | Vấn đề | Loại | Mức | Cần hỏi ai | Ảnh hưởng |
|---|---|---|---|---|---|---|
| TB-11 | **VI** dòng 5 "Chi tiết kỹ thuật: [runbook](../runbooks/template-sharing.md)" · **API** header "Product behaviour and app internals: `runbooks/template-sharing.md`. Backend rationale: `template-sharing.md`" · **API §Section numbers** "`template-sharing-history.md`" | **4 tài liệu được tham chiếu không có trong bundle.** Hệ quả: checklist VI tự khai mình là lớp mỏng phía trên runbook, nên **mọi hành vi nội bộ app** (preview render thế nào, bộ phát hiện ảnh/chữ, cache link, binding calendar sau khi Add) **không có oracle** — đây chính là gốc của TB-05, TB-06, TB-08, TB-10. **Im lặng ở các file thiếu KHÔNG được coi là "giữ nguyên"/"không có gì"**. | Thiếu (tài liệu nguồn) | MỞ (**gốc của 4 vấn đề từng CHẶN** — TB-05/06/08/10; nay đã có quyết định của QC/test lead thay cho runbook, **tài liệu vẫn thiếu**) | Dev / người bàn giao | Toàn bộ oracle nội bộ app; **O-1**, **O-24**, **O-25** |
| TB-12 | Toàn bundle + repo: **không có screenshot nào**, không wireframe, không exploratory checklist cho feature này; `.claude/rules/screenshot-naming.md` §7 **chưa có flow-no** cho "share template qua link" (flow `11_share` là share **lịch**, Phase 2 — **không** phải feature này) | **Không có baseline hình ảnh** cho 5 màn mới: *Sign in to share this template*, hộp *Share your photos too?*, hộp *Share this text?*, *Shared template*, *Template unavailable* (+ toast *Added to your collection*, *Collection is full*). Hệ quả: (a) **VI §12** yêu cầu "chữ **không bị cắt**" nhưng không có ảnh đối chiếu → phán xét cảm tính; (b) không kiểm được bố cục/đúng iPad; (c) test-plan không trace được tới ảnh; (d) chưa quyết `flow-no`/`screen-name` cho đợt chụp sắp tới (màn này mọc ra từ *Your collection* ⇒ thuộc `04_discover` hay mint flow mới? Theo rule §2 thì **không chèn giữa**, phải lấy số tiếp theo). | Thiếu (baseline/visual oracle) | MỞ (cao — phải ghi rõ trong test-plan) | Nội bộ QC (chụp trên build 1.2.19) + chủ repo | TS-70, TS-71, TS-73; độ chắc của mọi condition UI |
| TB-13 | **VI §12** "Đổi sang **Tiếng Việt** và **Arabic** (chữ phải sang trái)" ↔ **FE §7** "**Vietnamese is the minimum** besides English; the app ships **18 languages**" ↔ **API §3.2** ví dụ `vi`, `en`, `zh-Hant` | Không có **danh sách locale** nào trong bundle. Bằng chứng **đối chiếu** trong repo (không phải test basis): bộ 1.2.15 ghi 10 locale *(vi, ja, ko, es, pt, zh, zh-Hant, th, ms, id)* — **không có Arabic**; bộ TF-117 ghi "18 ngôn ngữ" cũng **không kèm danh sách**. ⇒ không xác nhận được Arabic **có** là ngôn ngữ app hay không, nên condition RTL có thể **không thực thi được**; và "đủ 18 ngôn ngữ" không kiểm được. Kiểm được chắc: **VI + EN**. | Thiếu (danh sách locale) | MỞ | Dev / localization | TS-70, TS-71, TS-86 |
| TB-14 | **VI §0.7** 5 design mẫu ("ảnh riêng làm nền **hoặc** sticker ảnh", "**text sticker** hoặc quote **tự gõ**") + **VI §4/§5** (quy tắc chọn hộp thoại) | Quy tắc chính rõ (bảng 2 điều kiện: *có ảnh riêng* × *có chữ tự gõ*), nhưng **biên của bộ phát hiện** không định nghĩa: ảnh từ **cutout/tách nền** có tính là "ảnh riêng"? ảnh do **Ink AI** sinh? quote **của catalog mà user không sửa** có tính "tự gõ"? **tên wallpaper** (VI §KN.3 nói tên cũng công khai) có kích hoạt hộp "Share this text?" không? Không trả lời thì các design biên không có expected dialog → chỉ phủ chắc 4 tổ hợp của design 1–4. | Thiếu (biên của quy tắc) | MỞ | Dev (app) | TS-12 → TS-20 |
| TB-15 | **VI §8.02** "Tài khoản **Free** đã đủ **5** design: hiện **Collection is full**" + **VI §1.05** (collection có thể chỉ gồm Live Activity / Note / Widget) + **VI §7.03** "Mở link khi **chưa đăng nhập**: vẫn xem và **thêm được**" | (a) "Đủ 5" đếm **cái gì** — chỉ wallpaper, hay cả Live Activity/Note/Widget trong *Your collection*? Không có BVA được nếu không biết đơn vị đếm. (b) Con số 5 không có nguồn nào khác xác nhận (không có trong API/FE). (c) Người nhận **chưa đăng nhập** được tính Free hay Pro (entitlement IAP thường theo máy, không theo account) → hạn mức 5 áp dụng thế nào? | Thiếu (đơn vị đếm + trạng thái entitlement) | MỞ | Dev + PM | TS-47, TS-48 |
| TB-16 | **API §3.2** `template.name` "String, **≤ 80 characters** (trim first)" · **FE §4** `name` "**Typed by the sender.** Up to 80 characters, any language, may contain emoji. Treat it as **untrusted text**" | Không có hành vi cho các biên phía **app**: tên wallpaper **dài hơn 80** (app tự cắt, hay publish fail `400` → thông báo chung?), tên **rỗng/chỉ khoảng trắng** (màn *Shared template* và `<h1>` của trang hiện gì?), tên chứa `<script>`/emoji/RTL — FE §8 có quy tắc cho **web**, nhưng **không tài liệu nào** nói màn *Shared template* **trong app** phải xử lý untrusted text thế nào. | Thiếu (giá trị biên + oracle phía app) | MỞ | Dev (app) | TS-36, TS-79, TS-99 → ghi chú ở TS-36 |
| TB-17 | **VI §6.01** "Share design 1 **hai lần liên tiếp**: **cùng một link**. Lần hai ra share sheet **nhanh** vì **không tạo lại**" ↔ **API §3.2** "**Caching** the link per wallpaper is **optional**… After a reinstall the server still returns the same link" + **API §3.8** "Every publish **bumps `updated_at`, even one that changed nothing**" | VI khẳng định "không tạo lại" (tức app **có** cache và **bỏ qua** request), API nói cache là **tuỳ chọn**. Hệ quả không quyết được: (a) lần share thứ 2 có **tốn 1 trong 30 publish/ngày** không; (b) "nhanh hơn" **không phải oracle khách quan** từ UI; (c) ảnh hưởng trực tiếp **VI §10.03** (tắt mạng rồi Share): nếu wallpaper **đã** có link trong cache thì share offline có thể **thành công** (phát lại link cũ) thay vì hiện *"Couldn't create a share link"* — mà VI không nói ô tick này dùng wallpaper **đã share** hay **chưa share**. | Mơ hồ + không quan sát được từ UI | MỞ (cần proxy/log; ảnh hưởng expected result của TS-61) | Dev (app) | TS-21, TS-25, TS-61, TS-62 |
| TB-18 | **API §Errors** bảng `error_code`: `invalid_template` và `rate_limited` ⇒ "**Same generic message**" (*"Couldn't create a share link. Try again."*) | Nhiều nhánh lỗi khác nhau **thu về đúng một thông báo** ⇒ từ UI **không phân biệt được** app đã rơi vào nhánh nào ⇒ không xác minh được "app xử lý đúng error_code" mà **không có proxy/log**. Test basis cũng không nói app có log gì, hay có cách bật diagnostic nào. | Không kiểm được (từ UI) | MỞ (cần Charles/proxy hoặc log) | Dev | TS-11, TS-62, TS-63, TS-65 |
| TB-19 | **VI §0** (Chuẩn bị) — chỉ có "**Ink Prod 1.2.19**, máy thật, chỉ cài Ink Prod, hai máy A/B" | **Không có device/OS matrix** (khác hẳn các spec trước trong repo, vốn có bảng iPhone 18.x / 26.x / iPad), không có build number/commit/PR, không có mục "điểm mới trong build này". Hệ quả: không viết được entry criteria về thiết bị, không biết **iPad** có trong phạm vi, và bug tìm được không gắn được build cụ thể. | Thiếu (định danh build + phạm vi thiết bị) | MỞ (cao cho entry criteria) | Dev / test lead | TS-92; coverage toàn đợt |
| TB-20 | **FE §5** "Page data: revalidate every **60 seconds** or less" + **FE §10** "Sender re-shares after an edit: the same URL shows the **new preview within a minute**" + **FE §9** `og:image` | Không nói gì về **cache unfurl của chat app**: card đã gửi trong iMessage/Zalo/Messenger giữ **ảnh/tiêu đề cũ** sau khi người gửi sửa và share lại (các nền tảng này cache og:image rất lâu, `preview_url` lại **đổi** mỗi lần publish + `immutable`). Quan sát được, nhưng **không có oracle** để kết luận bug/không. | Thiếu (hành vi ngoài tầm kiểm soát, không có triage) | MỞ (triage) | PM + team web | TS-82, TS-81 |
| TB-21 | **VI §3.01** "Bấm Share: hiện *Creating link…*, sau đó **mở share sheet** của iOS" + **VI §4.04/§5.01.2** (chỉ nói huỷ **trước** share sheet thì không share gì) | Không nói gì về việc **huỷ share sheet của iOS sau khi link đã được tạo**: lúc đó publish **đã xảy ra**, link **đã công khai** dù user không gửi cho ai. Quan sát được (mở link vẫn ra design), nhưng không biết đây là **by design** (và 3.9 là cách thu hồi — lại vướng TB-01) hay là lỗi. Không tự kết luận. | Thiếu (triage) | MỞ (triage) | PM / dev | TS-16, TS-18, GAP-2 |
| TB-22 | **API §3.3** "`410` Reserved for taken-down shares (**moderation, not built yet**)" + **FE §4** "410 isn't used today, but **treat 410 like 404** if it ever comes" | Nhánh 410 **không tạo ra được** hôm nay ⇒ condition tương ứng **không thực thi được** (trừ khi mock). Đây là hành vi phòng xa, không phải gap của spec, nhưng phải ghi rõ để không bị tính là "đã phủ". | Không kiểm được (thiếu phương tiện) | MỞ | Dev | **GAP-8** |
| TB-23 | **API §3.3** "**Treat the whole response as untrusted** — anyone with an account can write a share" (host allow-list, `schema` quá cao ⇒ *Update Ink*, `layout_kind` lạ, không tin Pro flag) · **FE §4/§8** (503, preview host allow-list) | Đây là nhóm condition **bảo mật quan trọng nhất** của feature, nhưng muốn chạy phải **tự dựng response độc** (sửa host `preview_url`, bơm `schema: 99`, `layout_kind` lạ) hoặc **fault injection** 500 ⇒ cần **mock/proxy hoặc môi trường staging**, mà bundle **không nêu** môi trường nào (API chỉ live production, không có base URL staging). Không có phương tiện thì các condition này chỉ **thiết kế được trên giấy**. | Không kiểm được (thiếu môi trường/phương tiện) | MỞ (cao — ảnh hưởng exit criteria nhóm bảo mật) | Dev backend + test lead | TS-41, TS-42, TS-57, TS-77, TS-80 |
| TB-24 | **VI §3.01** "*Creating link…*" · **API** không có SLA/thời gian nào | Không có **ngưỡng định lượng** cho thời gian tạo link (upload nhiều ảnh 2 MB + publish), cũng không có tiêu chí "không treo UI". Kiểm được "cuối cùng có ra share sheet", **không** chốt được pass/fail về thời gian. | Thiếu (oracle định lượng) | MỞ | Dev / PM | TS-90, TS-91 |
| TB-25 | **VI §1.03** "Màn *Your collection* có **nút share (⬆︎)** ở góc trên phải. Bấm vào thì **mở danh sách để chọn một wallpaper**" | Luồng sau khi chọn **không được mô tả**: chọn 1 cái rồi có chạy đúng luồng Share chuẩn (hỏi ảnh/chữ, share sheet) không? có **chọn nhiều** được không (nếu có thì tạo mấy link, share sheet nhận gì)? huỷ giữa danh sách thì sao? Chỉ viết được condition ở mức "danh sách mở ra và chọn được 1 wallpaper". | Thiếu | MỞ | Dev (app) | TS-03 |
| TB-26 | **API §3.2** "The link goes into a **share sheet under the user's name**" | Câu này không rõ nghĩa: "under the user's name" = share sheet có **tiêu đề/attribution tên người dùng**, hay chỉ nói link được gửi dưới danh nghĩa user? Không biết **share sheet mang theo những gì** (chỉ URL? kèm text? kèm ảnh preview?) ⇒ không viết được oracle cho nội dung payload share sheet, mà đây là chỗ dễ lọt dữ liệu (vd kèm luôn ảnh riêng dưới dạng attachment). | Mơ hồ | MỞ | Dev (app) | TS-97 |
| TB-27 | **API §Limits** + "**Daily windows reset at 00:00 UTC**" | Không có cách **tạo dữ liệu** để chạm các hạn mức: 500 link/account, 30 publish/ngày, 100 upload/ngày, 60 list/giờ, 60 delete/ngày — làm tay thì tốn và **khoá account cả ngày** (reset 00:00 UTC) ⇒ ảnh hưởng lịch chạy; không có script/seed nào được nêu. Condition hạn mức vì vậy **tốn cao, dễ bị cắt** khỏi phạm vi — phải nói rõ ở test-plan thay vì im lặng bỏ. | Thiếu (phương tiện tạo dữ liệu) | MỞ | Dev backend | TS-62, TS-63; nhóm M |
| TB-28 | **API §Not available yet** "The `/t/<id>` web page (fe-ink-calendar): `template-sharing-web-page.md`" ↔ file thực nhận: **`fe-template-share-page.md`** | Tên tài liệu tham chiếu **khác** tên file trong bundle. *Giả định* hai file là một (A-5 hệ quả), **chưa xác nhận** ⇒ rủi ro đang đọc **bản khác/cũ hơn** của spec web. Không có version/ngày trên cả hai file. | Thiếu (định danh tài liệu) | MỞ | Dev / team web | Toàn **nhóm L** |
| TB-29 | **VI §8.04** "Design có ảnh riêng: **tắt mạng sau khi thêm**, ảnh **vẫn hiện**, vì **đã tải về máy**" + **API §3.4** "Keep a picture only if it decodes as PNG/JPEG and ≤ 2 MB; save it into the app's own storage" | Không có acceptance criteria cho **thất bại giữa đường**: Add mà tải được 3/5 ảnh rồi mất mạng/ảnh 404 → bản copy nửa vời có vào collection không? có rollback? có thông báo gì? Đây là nhánh gặp thường xuyên trên mạng kém, và hậu quả là **dữ liệu hỏng trong collection**. | Thiếu (acceptance criteria) | MỞ (đã viết được condition "không có item nửa vời", nhưng oracle chi tiết còn hở) | Dev (app) | TS-53 |
| TB-30 | **VI §2** (3 ô tick) + **API §Errors** `sign_in_required` "Show the sign-in sheet, **resume the share after sign-in**" | Chỉ phủ 2 nhánh: đăng nhập thành công (tự chạy tiếp) và vuốt xuống đóng. **Không** nói gì khi: sign-in **thất bại** (Apple/Google trả lỗi), user đổi ý ở dialog hệ thống của Apple, mất mạng **trong lúc** sign-in, hoặc account **anonymous** đang tồn tại. Không rõ "resume" giữ lại cả **lựa chọn ảnh/chữ** đã bấm trước đó hay bắt đầu lại từ đầu. | Thiếu | MỞ | Dev (app) | TS-07 → TS-10 |

---

## 2. Test condition đã ưu tiên hoá

> **Quy ước cột:** *Loại* — `F` = Functional · `NF` = Non-functional kèm **quality characteristic theo
> ISO 25010** (Security, Reliability, Performance efficiency, Compatibility, Interaction capability/
> Usability, Portability, Maintainability).
> **Risk level = likelihood × impact** (ISTQB §5.2), ma trận dùng xuyên suốt tài liệu:
> `Cao×Cao = Rất cao → P1` · `Cao×Vừa / Vừa×Cao = Cao → P1` · `Vừa×Vừa = Vừa → P2` ·
> `Cao×Thấp / Thấp×Cao = Vừa → P2` · `Vừa×Thấp / Thấp×Vừa = Thấp–Vừa → P3` · `Thấp×Thấp = Thấp → P3`.
> **Mọi giá trị likelihood/impact ở đây là phán đoán của QC** dựa trên tính chất tài liệu hoá được
> (mức công khai của dữ liệu, khả năng mất dữ liệu, dính paywall/doanh thu, tần suất người dùng gặp) —
> **KHÔNG** phải fact từ spec; bundle **không** cung cấp số liệu business (lượng share dự kiến, tỷ lệ
> chuyển đổi Pro). Xem **A-2**.
> **Cột ⚠️** = condition **gap-dependent**: câu trả lời cho câu hỏi ghi trong ô sẽ **đổi expected
> result hoặc phạm vi** của chính condition đó → `test-plan` **phải mang nguyên nhãn này sang**.
>
> **Cập nhật 2026-10-02 — 3 loại nhãn mới trong cột ⚠️** (nguồn: [answers-1-2-19.md](answers-1-2-19.md)):
> - **`✅ Q-x đã chốt`** — đã có **assumption được QC/test lead xác nhận** (2026-10-02), **không phải fact
>   từ dev**. Condition **vẫn trong phạm vi**, oracle đã viết được. `test-plan` phải mang theo cảnh báo:
>   nếu dev trả lời khác thì expected result phải sửa.
> - **`⛔ Out of scope 1-2-19`** — dev tự verify, QC **không** viết oracle cho phần đó trong đợt này.
> - **`⏸ Hoãn khỏi 1-2-19`** — giữ nguyên trong tài liệu, chạy ở **đợt riêng/slug mới** khi điều kiện
>   tiền đề được xác nhận (nhóm L: trang `/t/<id>` đã live).
>
> **Cập nhật 2026-10-02 (đợt 2) — không còn nhãn `VẪN CHẶN` nào.** Q-1 / Q-6 / Q-10 đã được QC/test lead
> chốt; nhãn của chúng đổi thành `✅ Q-x đã chốt` **kèm mức tin cậy**:
> - **`✅ Q-1 đã chốt (CAO)`** · **`✅ Q-10 đã chốt (TRUNG BÌNH)`** · **`⚠️ Q-6 đã chốt TẠM (THẤP)`**.
> - Nhãn **`⚠️ … (THẤP)`** nghĩa là **oracle tạm**: `test-plan`/`test-case` được viết tiếp, nhưng phải
>   ghi rõ expected result này **có thể đổi** (xem **O-24**).

### Nhóm A · Điểm vào nút Share (nguồn: VI §1)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | ⚠️ |
|---|---|---|---|---|---|---|---|---|
| TS-01 | Nhấn giữ một **wallpaper** ở *Home → Your collection* → menu có mục **Share** | VI §1.01 | F | Vừa | Vừa | Vừa | P2 | |
| TS-02 | Nhấn giữ một wallpaper **trong màn** *Your collection* → menu có mục **Share** | VI §1.02 | F | Vừa | Vừa | Vừa | P2 | |
| TS-03 | Nút **⬆︎** góc trên phải màn *Your collection* mở danh sách chọn **một** wallpaper và chọn xong thì vào đúng luồng Share | VI §1.03 | F | Vừa | Vừa | Vừa | P2 | TB-25 (luồng sau khi chọn chưa định nghĩa) |
| TS-04 | Item **Live Activity / Note / Widget** **không** có mục Share (kiểm riêng từng loại) | VI §1.04; API §3.2 (`layout_kind` never `notes*`) | F | Vừa | Cao (rò nội dung Note) | Cao | **P1** | |
| TS-05 | Collection **chỉ** chứa Live Activity/Note/Widget → **không** có nút ⬆︎ ở góc trên | VI §1.05 | F | Vừa | Vừa | Vừa | P2 | |
| TS-06 | Nút Share hiển thị **không cần** bật cờ Remote Config nào (gửi và nhận đều không bị gate) | VI §1.06; API §Testing ("Neither sending nor receiving is gated by a flag") | F | Thấp | Vừa | Thấp–Vừa | P3 | |

### Nhóm B · Cổng đăng nhập (nguồn: VI §2, API §Identity + §Errors)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | ⚠️ |
|---|---|---|---|---|---|---|---|---|
| TS-07 | Đang **đăng xuất** + bấm Share → hiện màn **"Sign in to share this template"** (không publish gì) | VI §2.01; API `sign_in_required` | F | Vừa | Cao (chặn cả feature) | Cao | **P1** | |
| TS-08 | Đăng nhập **Apple** hoặc **Google** xong → luồng share **tự chạy tiếp**, không phải bấm Share lại | VI §2.02 | F | Cao (logic resume dễ hỏng) | Vừa | Cao | **P1** | TB-30 (resume có giữ lựa chọn ảnh/chữ không) |
| TS-09 | **Vuốt xuống đóng** màn đăng nhập → **không** share gì, **không** có link nào được tạo | VI §2.03 | F | Vừa | Cao (publish ngoài ý muốn = công khai dữ liệu) | Cao | **P1** | |
| TS-10 | Phiên **anonymous** (không phải Apple/Google) → bị coi là `sign_in_required`, app **không** publish bằng token anonymous | API §Identity; §Errors | F · NF-Security | Vừa | Cao | Cao | **P1** | |
| TS-11 | App Check thất bại → app **force-refresh token và retry đúng 1 lần**, sau đó mới hiện lỗi chung (không treo, không retry vô hạn) | API §Basics; §Errors `app_check_failed` | NF-Reliability | Vừa | Vừa | Vừa | P2 | TB-18 (không phân biệt được từ UI — cần proxy/log) |

### Nhóm C · Hộp thoại xin phép ảnh / chữ (nguồn: VI §3, §4, §5)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | ⚠️ |
|---|---|---|---|---|---|---|---|---|
| TS-12 | Design **không** ảnh riêng, **không** chữ tự gõ (design 1) → *"Creating link…"* rồi **share sheet iOS** có link `inkcalendar.app`, **không** hộp thoại nào | VI §3.01, §3.02 | F | Vừa | Vừa | Vừa | P2 | TB-14 (biên "ảnh riêng/chữ tự gõ") |
| TS-13 | Design **có ảnh riêng** (design 2) → hộp **"Share your photos too?"** với **đúng 2** lựa chọn *Use Ink backgrounds* / *Include my photos* | VI §4.01 | F | Vừa | Cao (cổng riêng tư) | Cao | **P1** | |
| TS-14 | Chọn **Use Ink backgrounds** → thiết kế đã publish **không chứa ảnh riêng** (`asset_ids = []`, không `shared:` nào trỏ ảnh của user) và máy B **không** thấy ảnh riêng **trong thiết kế**; với design `stack` **không** `origin_template_id`, nền hiển thị là **nền mặc định chung của hệ thống** | VI §4.02; API §3.2 (`[]` when "Use Ink backgrounds") | F · NF-Security | Vừa | Cao | Cao | **P1** | **Phần design data: trong phạm vi.** · ⛔ **Out of scope 1-2-19** cho phần **ảnh preview công khai** (Q-5 — dev tự verify) · ⚠️ **Q-6 đã chốt TẠM (tin cậy THẤP)** cho phần **nền thay thế** = nền mặc định hệ thống ⇒ oracle **tạm**, có thể đổi (**O-24**) |
| TS-15 | Chọn **Include my photos** → máy B thấy **đúng** ảnh của máy A (đối chứng với nhánh *Use Ink backgrounds* của TS-14: cùng design, khác lựa chọn ⇒ khác nền) | VI §4.03 | F | Vừa | Vừa | Vừa | P2 | ⚠️ **Q-6 đã chốt TẠM (tin cậy THẤP)** — phần so sánh với nền thay thế dùng oracle tạm (**O-24**) |
| TS-16 | **Vuốt xuống đóng** hộp hỏi ảnh → **không** share gì, **không** share sheet, **không** link, **không** asset nào bị claim | VI §4.04 | F · NF-Security | Vừa | Cao | Cao | **P1** | TB-21 |
| TS-17 | Design **chỉ có chữ tự gõ** (design 3) → hộp **"Share this text?"**, nội dung nói rõ **ai có link cũng đọc được chữ**; bấm **Share** → share bình thường | VI §5.01, §5.01.1 | F | Vừa | Cao (cảnh báo riêng tư) | Cao | **P1** | |
| TS-18 | Hộp **"Share this text?"** → **Cancel** → **không** share gì | VI §5.01.2 | F | Vừa | Cao | Cao | **P1** | TB-21 |
| TS-19 | Design **có cả ảnh riêng lẫn chữ** (design 4) → hiện **đúng MỘT** hộp (hộp ảnh, nội dung nhắc cả chữ), **không** hiện thêm hộp *"Share this text?"* | VI §5.02 | F | Cao (luồng 2 điều kiện dễ sai) | Vừa | Cao | **P1** | TB-14 |
| TS-20 | Chữ tự gõ **luôn** đi theo link, **kể cả** khi chọn *Use Ink backgrounds* | VI §5.03 | F | Vừa | Vừa | Vừa | P2 | |

### Nhóm D · "Mỗi wallpaper một link" (nguồn: VI §6, API §3.2 + §The model)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | ⚠️ |
|---|---|---|---|---|---|---|---|---|
| TS-21 | Share **cùng một wallpaper 2 lần liên tiếp** → **cùng một `id`/link** | VI §6.01; API §3.2 (`200` = update, same `id`) | F | Vừa | Cao (link khác nhau ⇒ người nhận cũ bị bỏ rơi) | Cao | **P1** | TB-17 (cache vs network — **vẫn MỞ**, xem O-8) · ✅ **Q-1 đã chốt (CAO)** — không có UI thu hồi link ⇒ không có nhánh "link bị xoá rồi share lại" trong app · ✅ **Q-10 đã chốt (TRUNG BÌNH)** — cache bị xoá khi logout/đổi account/xoá tài khoản |
| TS-22 | **Sửa design** rồi share lại → link **giữ nguyên**, máy B mở ra thấy **bản đã sửa** | VI §6.02; API §The model ("replaces what that link shows") | F | Cao | Vừa | Cao | **P1** | |
| TS-23 | **Hai wallpaper khác nhau** → **hai link khác nhau** (không nhầm chéo nội dung) | VI §6.03; API §3.2 (`source_id` keyed) | F | Thấp | Cao | Vừa | P2 | |
| TS-24 | Share với *Include my photos* rồi share lại với *Use Ink backgrounds* → link giữ nguyên, ảnh **mất khỏi link**, **và** URL asset cũ trả **404** (ảnh thật sự bị xoá, không chỉ ẩn) | VI §6.04; API §Flow ("the server deletes images the new version no longer lists") | F · NF-Security | Cao | Cao | **Rất cao** | **P1** | |
| TS-25 | Share lần 2 khi **không có gì thay đổi** → không sinh link thứ hai; (ở tầng API) `updated_at` được bump hoặc request bị bỏ qua đúng theo thiết kế cache | API §3.2, §3.8 | F | Vừa | Thấp | Thấp–Vừa | P3 | TB-17 (không quan sát được từ UI) |
| TS-26 | **Cài lại app** (hoặc máy khác cùng account) rồi share lại cùng wallpaper → server trả **cùng link cũ**; **đăng xuất/đổi account** trên cùng máy ⇒ cache thiết bị **bị xoá**, account mới **không** thấy/tái dùng link của account cũ | API §3.2 ("After a reinstall the server still returns the same link"); API §3.9 (cache key) | F | Vừa | Vừa | Vừa | P2 | ✅ **Q-1 đã chốt (CAO)** — **nhãn chờ Q-1 đã gỡ** (không có UI 3.8/3.9 ⇒ không có nhánh delete) · ✅ **Q-10 đã chốt (TRUNG BÌNH)** — oracle cache đã có |

### Nhóm E · Vệ sinh payload & riêng tư khi publish (nguồn: API §3.1, §3.2 — kiểm qua payload/proxy hoặc qua máy B)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | ⚠️ |
|---|---|---|---|---|---|---|---|---|
| TS-27 | Ảnh **preview** là bản render trên **sự kiện mẫu**, **không bao giờ** chứa sự kiện thật của máy A — **phạm vi đợt này: kiểm trên màn *Shared template* trong app** | VI §3.04; API §3.1 (`kind=preview`) | F · NF-Security | Vừa | Cao | Cao | **P1** | ✅ **Q-8 đã chốt** (oracle: preview = sự kiện mẫu; bản **áp dụng** dùng lịch máy B — nhất quán, không còn mâu thuẫn với VI §9.04) · ⛔ **Out of scope 1-2-19** cho phần `preview_url` **công khai** / `og:image` (Q-5 — dev tự verify) |
| TS-28 | Payload publish **không chứa đường dẫn file máy**: mọi `backgrounds[].path`/`sourcePath` là `catalog:https://assets.homebod.ai/…` hoặc `shared:<asset_id>`; `backgroundImagePath` và `backgroundSourcePath` = **null** | API §3.2 (bảng `template.settings`) | NF-Security | Vừa | Cao | Cao | **P1** | TB-23 (cần proxy để xem payload) |
| TS-29 | **Device state bị strip**: calendar đã chọn, **note id**, **album id**, rotation clock **không** có trong payload | API §3.2 | NF-Security | Vừa | Cao | Cao | **P1** | TB-23 |
| TS-30 | Ảnh upload đã **re-encode**: không còn **EXIF/GPS** (tải lại bytes từ URL công khai và soi metadata) | API §3.1 | NF-Security | Vừa | Cao | Cao | **P1** | |
| TS-31 | App tự bảo đảm giới hạn mã hoá **trước khi gửi**: background JPEG ≤ 2048 px, sticker PNG ≤ 1536 px, ≤ **2 MB**/ảnh; vượt ⇒ `413` (API §Limits) và user thấy thông báo chung *"Couldn't create a share link. Try again."* | API §3.1, §Limits, §Errors | NF-Reliability | Vừa | Vừa | Vừa | P2 | ✅ **Q-9 đã chốt** — **giá trị biên cụ thể do `test-plan`/`test-case` quyết định** (EP/BVA), không chờ dev |
| TS-32 | Body publish ≤ **64 KB** (vượt ⇒ `413`) và `template.template` ≤ **48 KB** (vượt ⇒ `400 invalid_template`) — app kiểm trước khi gửi | API §3.2, §Limits | NF-Reliability | Vừa | Vừa | Vừa | P2 | ✅ **Q-9 đã chốt** — giá trị biên do `test-plan`/`test-case` quyết định |
| TS-33 | **Mọi** `shared:<id>` xuất hiện trong `settings` đều có trong `asset_ids`; ≤ **20** (vượt ⇒ `400 invalid_template`), không trùng lặp → máy B không bị **thiếu ảnh** | API §3.2 (`asset_ids`), §Limits | F | Vừa | Vừa | Vừa | P2 | ✅ **Q-9 đã chốt** — giá trị biên do `test-plan`/`test-case` quyết định |
| TS-34 | `layout_kind` gửi lên **không bao giờ** là layout `notes*` (nhất quán với TS-04) | API §3.2 | NF-Security | Thấp | Cao | Vừa | P2 | |
| TS-35 | Asset **chưa được claim** (upload rồi bỏ dở trước publish): **không ai tải được**, và bị **xoá sau 24 giờ** | API §3.1 | NF-Security | Thấp | Cao | Vừa | P2 | Chi phí cao (chờ 24h) |

### Nhóm F · Mở link / nhận (máy B) (nguồn: VI §7, API §3.3 + §Links)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | ⚠️ |
|---|---|---|---|---|---|---|---|---|
| TS-36 | `ink://template?id=<id>` khi **app đang chạy** → màn **"Shared template"** có ảnh xem trước, **tên design**, nút **Add to my collection** | VI §7.01 | F | Vừa | Cao | Cao | **P1** | TB-16 (tên rỗng/dài/untrusted trên màn app) |
| TS-37 | Mở link khi app **đã tắt hẳn** (cold start) → qua splash/paywall rồi **vẫn** hiện màn *Shared template* (deeplink không bị mất) | VI §7.02 | F · NF-Reliability | Cao | Cao | **Rất cao** | **P1** | |
| TS-38 | Mở và **Add** được khi **chưa đăng nhập** (không hiện yêu cầu tài khoản) | VI §7.03; API §The model ("Opening a link needs nothing") | F | Vừa | Cao | Cao | **P1** | TB-15 (Free/Pro của máy chưa đăng nhập) |
| TS-39 | Badge **PRO** trên màn *Shared template* theo đúng 2 nhánh: **(a) id đã biết trong catalog** ⇒ badge theo **cờ Pro thật** của template · **(b) id lạ / không nhận diện được** (app cũ hơn, hoặc design `stack` không `origin_template_id`) ⇒ **luôn coi là Pro** | VI §7.04; API §3.3 ("treat an unknown template as Pro") | F | Vừa | Vừa | Vừa | P2 | ✅ **Q-7 đã chốt** (2 nhánh, không mâu thuẫn) |
| TS-40 | Bấm **✕** → đóng màn, **không** thêm gì vào collection | VI §7.05 | F | Thấp | Vừa | Thấp–Vừa | P3 | |
| TS-41 | **Host allow-list trên response**: chỉ nhận `preview_url`/`assets` https trên `inkcalendar.app` và URL trong `data` trên `assets.homebod.ai`; mọi host khác bị **drop/reject** | API §3.3 ("Treat the whole response as untrusted") | NF-Security | Thấp | Cao | Vừa | P2 | TB-23 (cần mock response) |
| TS-42 | `data.schema` cao hơn build hỗ trợ, hoặc `layout_kind` **lạ** → hiện **"Update Ink"**, không crash/không màn trắng | API §3.3 | NF-Reliability | Vừa | Vừa | Vừa | P2 | TB-23 |
| TS-43 | `preview_url = null` → **fallback về artwork catalog** của `data.template`, không ảnh hỏng | API §3.3 | F | Vừa | Vừa | Vừa | P2 | |
| TS-44 | Id **sai định dạng** trong deeplink, và **query param lạ** đi kèm → *Template unavailable*; app **không** honour param nào khác ngoài `id` đã validate | API §3.3 (`400`), §Ids; FE §8 | F · NF-Security | Vừa | Vừa | Vừa | P2 | |
| TS-45 | **Thứ tự parse deeplink**: link template trên `inkcalendar.app` được parse **trước** link share **lịch** (cùng host) — không bị luồng calendar-share bắt nhầm | API §Links and deep links | F | Vừa | Vừa | Vừa | P2 | |

### Nhóm G · Add to my collection (máy B) (nguồn: VI §8, API §3.4)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | ⚠️ |
|---|---|---|---|---|---|---|---|---|
| TS-46 | **Add to my collection** → toast *"Added to your collection"*, design xuất hiện **đầu** *Your collection* | VI §8.01 | F | Vừa | Cao | Cao | **P1** | |
| TS-47 | Account **Free** đã đủ **5** design → **"Collection is full"** kèm **Go Pro** + **Cancel**; xoá bớt 1 design thì Add thành công | VI §8.02 | F | Vừa | Cao (doanh thu + chặn user) | Cao | **P1** | TB-15 (đếm cái gì vào 5) |
| TS-48 | Account **Pro** → Add được dù đã **hơn 5** design | VI §8.03 | F | Thấp | Cao | Vừa | P2 | |
| TS-49 | Design có ảnh riêng: **tắt mạng sau khi Add** → ảnh **vẫn hiện** (bytes đã lưu vào storage của app, **không** tham chiếu URL) | VI §8.04; API §3.4 | F · NF-Reliability | Vừa | Cao | Cao | **P1** | |
| TS-50 | Bytes tải về chỉ được giữ nếu **decode đúng PNG/JPEG** và ≤ **2 MB** (ảnh rác bị loại, không làm hỏng item) | API §3.4 | NF-Security | Thấp | Vừa | Thấp–Vừa | P3 | TB-23 |
| TS-51 | Mở **cùng một link** và Add **2 lần** → có **2 bản copy riêng** | VI §8.05 | F | Thấp | Thấp | Thấp | P3 | |
| TS-52 | Máy A **sửa và share lại** → bản máy B **đã Add trước đó không đổi** (bản copy là bất biến) | VI §8.06; API §The model | F | Vừa | Cao | Cao | **P1** | |
| TS-53 | **Thất bại giữa đường khi Add** (mất mạng/asset 404 ở ảnh thứ n) → **không** để lại item nửa vời trong collection, có thông báo rõ | API §3.4 (suy từ yêu cầu lưu trữ) | NF-Reliability | Vừa | Cao | Cao | **P1** | **TB-29** (không có acceptance criteria chi tiết — oracle hở) |

### Nhóm H · Set as current & Pro (máy B) (nguồn: VI §9, API §3.3)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | ⚠️ |
|---|---|---|---|---|---|---|---|---|
| TS-54 | **Free** + design có template id **đã biết trong catalog** + template **không** có tuỳ chỉnh Pro → **Set as current** chạy bình thường, **không** paywall | VI §9.01 | F | Vừa | Cao (paywall sai ⇒ chặn user Free vô cớ) | Cao | **P1** | ✅ **Q-7 đã chốt** — nhánh "id đã biết" |
| TS-54b | **Free** + template id **lạ / không nhận diện được** (máy B app cũ hơn, hoặc design `stack` **không** `origin_template_id`) → **Set as current luôn hiện paywall**, **bất kể** design có tuỳ chỉnh Pro hay không | API §3.3 ("treat an unknown template as Pro") | F · NF-Security | Vừa | Cao (hở paywall / chặn sai) | Cao | **P1** | ✅ **Q-7 đã chốt** — nhánh "id lạ" *(condition **mới sinh ra** từ quyết định Q-7)* |
| TS-55 | **Free** + design **có tuỳ chỉnh Pro** (design 5, id đã biết) → **Add vẫn được**, nhưng **Set as current** hiện **paywall** | VI §9.02 | F | Vừa | Cao (doanh thu) | Cao | **P1** | ✅ **Q-7 đã chốt** |
| TS-56 | **Pro** + design 5 → Set as current chạy bình thường | VI §9.03 | F | Thấp | Cao | Vừa | P2 | |
| TS-57 | **Không tin Pro flag trong share**: quyết định Pro **từ catalog local theo template id** (theo đúng 2 nhánh của TS-54/TS-54b); share bị sửa cờ Pro **không** mở được nội dung Pro | API §3.3 | NF-Security | Thấp | Cao | Vừa | P2 | ✅ **Q-7 đã chốt** · TB-23 (cần mock) |
| TS-58 | Wallpaper đã Add lên được **màn khoá** qua **Shortcut** như mọi wallpaper khác: **giống bản xem trước về style/bố cục**, và **dữ liệu sự kiện/calendar là của máy B** — **không bao giờ** là sự kiện mẫu của preview hay dữ liệu từ máy A | VI §9.04; API §3.2 (strip selected calendars) | F | Vừa | Cao | Cao | **P1** | ✅ **Q-8 đã chốt** — oracle đã rõ · Còn hở **không chặn**: *calendar nào* của máy B được bind (**O-22**) |

### Nhóm I · Lỗi, offline, hạn mức (nguồn: VI §10, API §Errors)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | ⚠️ |
|---|---|---|---|---|---|---|---|---|
| TS-59 | Id **không tồn tại** → **"Template unavailable"** / *"This template was removed, or the link is incomplete."* | VI §10.01; API §3.3 (`404`) | F | Vừa | Vừa | Vừa | P2 | |
| TS-60 | **Tắt mạng** rồi mở link đúng → *"Couldn't load this template. Check your connection and try again."*; bật mạng **thử lại thì mở được** | VI §10.02 | F · NF-Reliability | Vừa | Vừa | Vừa | P2 | |
| TS-61 | **Tắt mạng** rồi bấm Share (wallpaper **chưa từng** share) → *"Couldn't create a share link. Try again."* và **không** share sheet | VI §10.03 | F | Vừa | Vừa | Vừa | P2 | **TB-17** (nhánh wallpaper **đã** share + cache: expected result chưa xác định) |
| TS-62 | Chạm hạn mức **30 publish/ngày** (`429 rate_limited`) → hiện **thông báo chung**, không crash | API §Errors, §Limits | NF-Reliability | Thấp | Vừa | Thấp–Vừa | P3 | TB-18, TB-27 (khó tạo dữ liệu, khoá account cả ngày) |
| TS-63 | **Publish thất bại không bao giờ làm hỏng link đang có**: máy B vẫn mở được **bản cũ** sau một lần share lỗi | API §3.2 ("A failed publish never changes the existing link") | NF-Reliability | Thấp | Cao | Vừa | P2 | TB-18 |
| TS-64 | Asset trả **404** (ảnh đã bị xoá/chưa attach) → màn *Shared template* vẫn dùng được với fallback, không treo | API §3.4 (`404`) | NF-Reliability | Thấp | Vừa | Thấp–Vừa | P3 | |
| TS-65 | Upload lỗi `502` (storage) giữa chừng → app không publish **nửa vời** (không ra link thiếu ảnh), hiện lỗi chung và cho thử lại | API §3.1 (`502`), §3.2 | NF-Reliability | Vừa | Vừa | Vừa | P2 | TB-18, TB-23 |

### Nhóm J · Xoá tài khoản (nguồn: VI §11, API §Account deletion)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | ⚠️ |
|---|---|---|---|---|---|---|---|---|
| TS-66 | Máy A **xoá tài khoản** → mở link cũ trên máy B ra **"Template unavailable"**; sau đó máy A tạo/đăng nhập account mới và Share lại **cùng wallpaper** ⇒ app phát **link MỚI** (cache đã bị xoá), **không** phát lại link đã chết | VI §11.01; API §Account deletion; API §3.9 (cache key) | F · NF-Security | Vừa | Cao | Cao | **P1** | ✅ **Q-10 đã chốt (TRUNG BÌNH)** → GAP-7 đóng; nếu app **vẫn** phát link cũ ⇒ **bug (lỗi im lặng)** · ✅ **Q-1 đã chốt (CAO)** — app **không** có đường thu hồi link (3.9) ⇒ xoá tài khoản là **cách duy nhất**, ghi vào residual risk |
| TS-67 | Sau khi xoá tài khoản, **ảnh** của share cũ **không tải được nữa** (URL asset → `404`) | API §Account deletion ("and its images") | NF-Security | Vừa | Cao | Cao | **P1** | |
| TS-68 | Bản copy máy B **đã Add trước đó vẫn còn** và **vẫn dùng được** sau khi máy A xoá tài khoản | VI §11.02 | F | Thấp | Cao | Vừa | P2 | |
| TS-69 | Trang web `/t/<id>` của link đã chết chuyển sang trạng thái **unavailable** trong vòng ≤ **60 giây** | FE §5 ("404 pages: at most 60 seconds") | F | Vừa | Vừa | Vừa | P2 | ⏸ **Hoãn khỏi `1-2-19`** — ✅ Q-2 đã chốt **APP-ONLY**; chạy ở đợt riêng khi FE xác nhận trang `/t/<id>` đã live |

### Nhóm K · Ngôn ngữ (nguồn: VI §12, API §3.2 `lang`)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | ⚠️ |
|---|---|---|---|---|---|---|---|---|
| TS-70 | **Tiếng Việt**: màn Share, hộp hỏi ảnh, *"Share this text?"*, *"Shared template"*, *"Template unavailable"* dịch đủ, **không sót chuỗi tiếng Anh**, **không bị cắt chữ** | VI §12 | NF-Usability (Interaction capability) | Cao | Vừa | Cao | **P1** | TB-12 (không có ảnh baseline để so bố cục) |
| TS-71 | **Arabic / RTL**: 5 màn trên hiển thị đúng chiều phải→trái, không cắt chữ, không lệch icon | VI §12 | NF-Usability · NF-Portability | Cao | Vừa | Cao | P2 *(hạ từ P1 vì chưa xác nhận Arabic là locale đang ship)* | **TB-13** (chưa có danh sách locale; bằng chứng đối chiếu 1.2.15 **không có** Arabic ⇒ có thể **không thực thi được**) |
| TS-72 | `lang` gửi lên publish = **ngôn ngữ app đang dùng**; giá trị sai định dạng → server fallback `en` | API §3.2 | F | Thấp | Vừa | Thấp–Vừa | P3 | ✅ **Q-4 đã chốt** — `lang` là **hint/fallback** cho trang web (không "khoá" ngôn ngữ trang); phần kiểm phía app **vẫn trong phạm vi** |

### Nhóm L · Trang web `/t/<id>` (nguồn: FE §3 → §10) — ⏸ **TOÀN NHÓM HOÃN KHỎI SLUG `1-2-19`**

> ⏸ **Quyết định phạm vi 2026-10-02 (✅ Q-2 đã chốt — xem [answers §A-Q2](answers-1-2-19.md)):** phạm vi
> QC đợt `1-2-19` là **APP-ONLY**. **Cả 17 condition dưới đây (TS-73 → TS-89, gồm TS-88) tạm hoãn khỏi
> slug `1-2-19`** — **không xoá**, giữ nguyên tại đây để chạy ở **đợt riêng / slug mới** khi **FE xác
> nhận trang `/t/<id>` đã live**.
>
> **Lý do (nguồn: User — QC/test lead, hội thoại Claude Code, 2026-10-02):** VI (chính checklist QC đang
> dùng làm test basis cho đợt này) tự nói rõ trang web chưa làm và dặn "không cần báo lỗi" + cho cách
> test vòng qua bằng `ink://`. Đây là QC tự quyết phạm vi test của chính mình dựa trên checklist mình
> đang chạy, không phải đoán hành vi sản phẩm.
>
> **Nhãn ⚠️ `Q-2`/`Q-3` trong bảng dưới đã được giải quyết** (Q-2 chốt APP-ONLY; Q-3 out of scope — dev
> tự verify). **Nhãn `Q-5`** (TS-73, TS-82) ⇒ out of scope, dev tự verify. **Nhãn `Q-4`** (TS-86) ⇒ đã
> chốt: trang theo ngôn ngữ **visitor**. Các nhãn này giữ lại trong bảng để truy ngược, nhưng **không
> còn chặn** — thứ chặn duy nhất của nhóm này giờ là **điều kiện tiền đề "trang đã live"**.
>
> ⚠️ **Rủi ro còn lại phải mang sang `test-plan` (không được im lặng):** với APP-ONLY, **nhóm F** vào qua
> `ink://` — **không phải đường vào thật của user** (bấm link https trong chat). Luồng end-to-end thật
> **chưa từng được chạy một lần nào** trong đợt `1-2-19`; `test-plan` phải ghi ở phần residual risk /
> exit criteria.

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | ⚠️ |
|---|---|---|---|---|---|---|---|---|
| TS-73 | Trạng thái **Found (200)**: preview trong khung dạng điện thoại, **tên là `<h1>`**, 1 dòng mô tả, nút **Open in Ink**, nút **App Store**, hint bên dưới; alt text đúng mẫu | FE §6 (Found) | F | Vừa | Cao (mọi người nhận đều đi qua đây) | Cao | **P1** | ⏸ **Hoãn khỏi `1-2-19`** (✅ Q-2 = APP-ONLY) · ✅ Q-3 ⛔ out of scope · **Q-5 ⛔ out of scope** (phần ảnh preview — dev tự verify) |
| TS-74 | **Open in Ink** có `href` đúng `ink://template?id=<id đã validate>` và mở app vào **đúng** màn *Shared template* của id đó | FE §6, §8, §10 | F | Vừa | Cao | Cao | **P1** | Q-2, **Q-3** (build nào qua được App Check) |
| TS-75 | Id **sai định dạng** (`/t/bad%20id`, >64 ký tự, ký tự lạ) → trang **unavailable** + HTTP **404**, và **không** gọi API | FE §3, §10 | F · NF-Security | Vừa | Vừa | Vừa | P2 | Q-2 |
| TS-76 | Id **không tồn tại / chủ đã xoá account** (API 400/404) → trang unavailable, HTTP **404**, đúng copy *"Template unavailable"* + *"This template was removed, or the link is incomplete."*, **không** preview, **không** Open in Ink | FE §4, §6 | F | Vừa | Vừa | Vừa | P2 | Q-2 |
| TS-77 | API **500 / lỗi mạng** → trang **temporary error**, HTTP **503**, heading *"Couldn't load this template"* + link **Try again** về chính URL | FE §4, §6, §10 | NF-Reliability | Vừa | Vừa | Vừa | P2 | Q-2, TB-23 (cần fault injection) |
| TS-78 | `preview_url = null` → **placeholder**, **không** ảnh hỏng; meta dùng **ảnh Ink mặc định** | FE §4, §9, §10 | F | Vừa | Vừa | Vừa | P2 | Q-2 |
| TS-79 | `name` chứa `<script>`, dấu nháy, emoji → render **plain text** trong body **và** trong `<title>`/meta (không `dangerouslySetInnerHTML`) | FE §8, §9, §10 | NF-Security | Vừa | Cao | Cao | **P1** | Q-2 |
| TS-80 | `preview_url` **không** bắt đầu bằng `https://inkcalendar.app/api/ink/template-share/assets/` → coi như **không có preview** (không nạp ảnh host lạ) | FE §8 | NF-Security | Thấp | Cao | Vừa | P2 | Q-2, TB-23 |
| TS-81 | Người gửi **sửa rồi share lại** → **cùng URL** hiện preview/nội dung mới trong vòng **≤ 60 giây** (ISR revalidate ≤60s); trang 404 không bị cache quá 60s | FE §5, §10 | NF-Reliability | Vừa | Vừa | Vừa | P2 | Q-2, **TB-20** (card đã gửi trong chat có thể vẫn cũ — chưa có triage) |
| TS-82 | **SSR/ISR + meta tags**: dán link vào **iMessage, Zalo, Messenger** → card hiện **đúng tên + preview** (crawler lấy được meta **không cần JS**) | FE §3 (Rendering), §9, §10 | F · NF-Compatibility | Cao | Cao | **Rất cao** | **P1** | ⏸ **Hoãn khỏi `1-2-19`** (✅ Q-2 = APP-ONLY) · **Q-5 ⛔ out of scope** (ảnh trong card — dev tự verify) · TB-20 |
| TS-83 | `robots: noindex, nofollow` + `canonical` đúng trên trang found; trang 404 **giữ noindex** và title *"Template unavailable · Ink"* | FE §9, §10 | NF-Security (privacy) | Vừa | Cao (design công khai bị Google index) | Cao | **P1** | Q-2 |
| TS-84 | iPhone/iPad **không có Ink**: trang **không auto-redirect** sang `ink://` khi load; nút **App Store** hoạt động; hint hiển thị | FE §6 (Device behaviour), §10 | F · NF-Usability | Vừa | Vừa | Vừa | P2 | Q-2 |
| TS-85 | **Android / desktop**: vẫn hiện preview + tên, thay Open in Ink bằng ghi chú *"Open this link on your iPhone"*, giữ link App Store | FE §6, §10 | NF-Compatibility | Vừa | Vừa | Vừa | P2 | Q-2 |
| TS-86 | **Ngôn ngữ trang**: text của trang theo **ngôn ngữ của người xem (visitor)** — URL segment / `Accept-Language`; **fallback** về `lang` của share khi không xác định được, rồi **English**. `name` của design **hiển thị nguyên văn, không dịch** | FE §7; API §3.2 | F · NF-Usability | Vừa | Vừa | Vừa | P2 | ✅ **Q-4 đã chốt** (gỡ nhãn mâu thuẫn FE ↔ API) · ⏸ **vẫn hoãn** theo Q-2 (thuộc nhóm L) · TB-13 |
| TS-87 | Trang **chỉ** gọi `/api/ink/template-share/<id>/page` (**không** gọi route cần App Check), không gửi token/header đặc biệt; **không** gửi id/name/URL vào analytics (chỉ event `found`/`not_found`/`error`) | FE §4, §8 | NF-Security (privacy) | Thấp | Cao | Vừa | P2 | Q-2 |
| TS-88 | **Regression**: trang share **lịch** `/share/<id>` vẫn hoạt động sau khi thêm `/t/` | FE §10 | NF-Reliability | Vừa | Cao | Cao | P2 *(hạ vì chưa rõ thuộc phạm vi QC đợt này — O-13)* | **O-13**, Q-2 |
| TS-89 | **Không** có universal link cho `/t/`: bấm link `https` **không** mở app trực tiếp (không có AASA), đúng như quyết định FE §2/§11 | FE §2, §11; API §Links | NF-Compatibility | Thấp | Thấp | Thấp | P3 | Q-2 |

### Nhóm M · Xuyên suốt / phi chức năng (nguồn: API §Basics, §Limits, §Ids, §Links)

| # | Test condition | Nguồn | Loại | Likelihood | Impact | Risk level | Ưu tiên | ⚠️ |
|---|---|---|---|---|---|---|---|---|
| TS-90 | *"Creating link…"* kết thúc và share sheet mở ra trong thời gian chấp nhận được trên mạng bình thường; UI **không** bị treo/khoá vô hạn | VI §3.01 | NF-Performance efficiency | Vừa | Vừa | Vừa | P2 | **TB-24** (không có ngưỡng định lượng) |
| TS-91 | Design **nặng** (nhiều sticker ảnh, tiến tới 20 ảnh / body gần 64 KB) share + Add end-to-end thành công | API §Limits | NF-Performance efficiency · NF-Reliability | Vừa | Vừa | Vừa | P2 | ✅ **Q-9 đã chốt** (GAP-6 đóng) — giá trị biên do `test-plan`/`test-case` quyết định |
| TS-92 | **Compatibility**: luồng gửi và nhận chạy đúng trên tập thiết bị/OS đã chốt (iPhone + iPad nếu có) | — *(không có trong test basis)* | NF-Compatibility | Vừa | Vừa | Vừa | P2 | **TB-19** (bundle **không có** device matrix — phạm vi do QC/test lead quyết, phải ghi rõ ở test-plan) |
| TS-93 | **App Check bắt buộc** trên mọi call app gọi, **trừ** download ảnh: gọi thiếu App Check → `401 app_check_failed` (xác minh bằng `curl`) | API §Basics, §Testing | NF-Security | Thấp | Cao | Vừa | P2 | ⛔ **Out of scope đợt `1-2-19` — dev tự verify** (✅ Q-3, xem [answers §B-Q3](answers-1-2-19.md)). Giữ condition trong tài liệu, **không** đưa vào bộ test case đợt này |
| TS-94 | **Identity**: upload/publish/list/stop **cần** Bearer của account **Apple/Google**; đọc share (3.3) và tải ảnh (3.4) **không cần** Bearer | API §Basics (Identity), §Testing | NF-Security | Thấp | Cao | Vừa | P2 | |
| TS-95 | **Validate id** lấy từ response/link theo `[A-Za-z0-9_-]{1,64}` trước khi dùng (dựng link, gọi tiếp) | API §Basics (Ids), §3.2 | NF-Security | Thấp | Cao | Vừa | P2 | |
| TS-96 | Link app phát ra **đúng** `https://inkcalendar.app/t/<id>` do **app tự dựng** (bỏ qua `page_url` của server) | API §3.2 | NF-Security | Thấp | Cao | Vừa | P2 | |
| TS-97 | **Nội dung share sheet**: chỉ gồm link (và tiêu đề nếu có) — **không** kèm ảnh/attachment hay dữ liệu cá nhân nào khác | API §3.2 ("share sheet under the user's name") | NF-Security (privacy) | Thấp | Cao | Vừa | P2 | **TB-26** (câu chữ mơ hồ, chưa rõ share sheet mang gì) |

### Tổng hợp số lượng

> **Cập nhật 2026-10-02:** thêm **TS-54b** (sinh ra từ quyết định Q-7 — nhánh "id lạ ⇒ luôn coi là Pro")
> ⇒ tổng **98** condition. Cột **Trong phạm vi `1-2-19`** phản ánh quyết định APP-ONLY (Q-2) và 2 câu
> out of scope (Q-3, Q-5).

| | P1 | P2 | P3 | Tổng | Trong phạm vi `1-2-19` |
|---|---|---|---|---|---|
| A · Điểm vào Share | 1 | 4 | 1 | 6 | 6 |
| B · Đăng nhập | 4 | 1 | 0 | 5 | 5 |
| C · Hộp hỏi ảnh/chữ | 6 | 3 | 0 | 9 | 9 |
| D · Một wallpaper một link | 3 | 2 | 1 | 6 | 6 |
| E · Vệ sinh payload / riêng tư | 4 | 5 | 0 | 9 | 9 *(TS-27: phần `preview_url` công khai out of scope)* |
| F · Mở link / nhận | 3 | 6 | 1 | 10 | 10 *(vào qua `ink://`, không qua link https)* |
| G · Add to collection | 5 | 1 | 2 | 8 | 8 |
| H · Set as current & Pro | 5 | 1 | 0 | 6 | 6 *(+TS-54b)* |
| I · Lỗi / offline / hạn mức | 0 | 5 | 2 | 7 | 7 |
| J · Xoá tài khoản | 2 | 2 | 0 | 4 | **3** *(TS-69 hoãn)* |
| K · Ngôn ngữ | 1 | 1 | 1 | 3 | 3 |
| L · Trang web `/t/<id>` | 5 | 11 | 1 | 17 | **0** ⏸ *(toàn nhóm hoãn — Q-2)* |
| M · Xuyên suốt / NF | 0 | 8 | 0 | 8 | **7** ⛔ *(TS-93 out of scope — Q-3)* |
| **Tổng** | **39** | **50** | **9** | **98** | **79** |

**Phạm vi đợt `1-2-19`: 79 condition** — **P1 = 34 · P2 = 37 · P3 = 8**.
**Ngoài phạm vi đợt này: 19 condition** — ⏸ **18 hoãn** (17 nhóm L + TS-69, chạy ở slug mới khi trang
`/t/<id>` live) · ⛔ **1 out of scope** (TS-93, dev tự verify) · thêm **phần "ảnh preview công khai"**
của TS-14/TS-27 ⛔ out of scope (không phải cả condition).

**Nhãn ⚠️ còn lại sau 2026-10-02 (đợt 2):**
- **Còn CHẶN:** **không còn** — 0 condition bị chặn.
- **✅ Đã chốt (mang theo nhãn "assumption của QC/test lead, không phải fact từ dev")** — **18
  condition**, chia theo **mức tin cậy**:
  - *tin cậy CAO:* **Q-1** → TS-21, TS-26, TS-66 (và đóng GAP-1/GAP-2) · **Q-4** → TS-72, TS-86 ·
    **Q-7** → TS-39, TS-54, TS-54b, TS-55, TS-57 · **Q-8** → TS-27, TS-58 · **Q-9** → TS-31, TS-32,
    TS-33, TS-91.
  - *tin cậy TRUNG BÌNH:* **Q-10** → TS-21, TS-26, TS-66 (cùng tập với Q-1).
  - *tin cậy **THẤP** — oracle **tạm**:* **Q-6** → **TS-14** (phần nền), **TS-15** ⇒ `test-plan` /
    `test-case` **bắt buộc** ghi "expected result tạm, chờ dev xác nhận (**O-24**)".
- **Nhãn testability `TB-*` mức MỞ vẫn giữ nguyên toàn bộ** (TB-12 thiếu baseline ảnh, TB-13 locale,
  TB-14 biên bộ phát hiện, TB-17 cache, TB-18 không phân biệt error_code, TB-19 device matrix, TB-23
  thiếu môi trường mock, TB-29, TB-30…) — **không câu nào trong 7 quyết định 2026-10-02 đóng các mục
  này**; `test-plan` phải mang sang.

### GAP · Chưa viết được condition (không được suy diễn)

> **Cập nhật 2026-10-02 (đợt 2):** **7/8 cụm đã đóng** — GAP-3a (out of scope) · GAP-4 · GAP-5 · GAP-6
> (đợt 1) · **GAP-1, GAP-2** (Q-1, tin cậy CAO) · **GAP-3b** (Q-6, tin cậy **THẤP** ⇒ đóng **TẠM**) ·
> **GAP-7** (Q-10, tin cậy TRUNG BÌNH). **Còn mở: chỉ GAP-8** — ⏸ **parked** (không tạo được dữ liệu),
> không tính vào coverage ⇒ **không** chặn `test-plan`.

| # | Nội dung | Chặn bởi | Trạng thái | Nếu được trả lời thì sinh ra gì |
|---|---|---|---|---|
| **GAP-1** | Màn/luồng **"link của tôi"** trong app (API §3.8): thứ tự `updated_at` desc, `limit`/`cursor` paging, `has_photos`, host-check `preview_url`, hạn mức 60 call/giờ | ~~Q-1~~ | ✅ **ĐÓNG** (2026-10-02, đợt 2, [answers §C-Q1](answers-1-2-19.md), **tin cậy CAO**) — app 1.2.19 **không có UI** này ⇒ **0 condition UI** cho đợt `1-2-19`; route 3.8 **ngoài phạm vi UI test**, chỉ `curl` nếu cần (nhóm NF, **tuỳ chọn**) | **Không sinh condition** đợt này. Nếu dev xác nhận app **có** gọi 3.8 ⇒ bổ sung ~5–6 condition (P2) ở **slug mới** (**O-25**) |
| **GAP-2** | **Ngừng share một link** trong app (API §3.9): delete → 3.3/3.4/web đều `404`, bản copy người nhận **không** ảnh hưởng, publish lại sinh **id MỚI**, **xoá cache** `ink.template.share.links.v1`, delete lần 2 = `404`, hạn mức 60/ngày | ~~Q-1~~ | ✅ **ĐÓNG** (2026-10-02, đợt 2, **tin cậy CAO**) — app 1.2.19 **không có** nút ngừng share ⇒ **0 condition UI**; route 3.9 ngoài phạm vi UI test (chỉ `curl` nếu cần) | **Không sinh condition** đợt này. ⚠️ **Residual risk bắt buộc ghi ở `test-plan`:** **không có đường thu hồi link** trong app — link công khai **chỉ mất khi xoá tài khoản** (VI §KN.2); liên quan **O-7** (huỷ share sheet sau khi link đã tạo) |
| **GAP-3a** | Khi chọn **Use Ink backgrounds**: ảnh **preview công khai** (`preview_url` / `og:image`) có được render lại **không chứa ảnh riêng**? | ~~Q-5~~ | ⛔ **ĐÓNG vì OUT OF SCOPE đợt `1-2-19`** (2026-10-02, [answers §B-Q5](answers-1-2-19.md)) — **dev tự verify**. **QC không kết luận** hành vi nào đúng; câu hỏi về mặt nội dung **vẫn chưa được dev trả lời** | — *(trong đợt này không sinh condition; nếu sau này đưa vào phạm vi thì phục hồi oracle cho phần preview của TS-14/TS-27/TS-73/TS-82)* |
| **GAP-3b** | Khi chọn **Use Ink backgrounds**: **nền thay thế** chính xác là gì khi design tự dựng (`stack`, **không** `origin_template_id`) mà nền duy nhất là ảnh riêng — nền catalog template gốc / nền mặc định app / publish fail `400 invalid_template` | ~~Q-6~~ | ⚠️ **ĐÓNG TẠM THỜI** (2026-10-02, đợt 2, [answers §C-Q6](answers-1-2-19.md)) — **tin cậy THẤP**: nền thay thế = **nền mặc định chung của hệ thống**; **suy luận kỹ thuật**, không tài liệu nào gợi ý trực tiếp ⇒ **không phải fact** | **Đã sinh:** oracle **tạm** cho **TS-14** (phần nền) + **TS-15**. **Bắt buộc giữ O-24** (xác nhận lại với dev) — nếu sai thì **đổi expected result** của 2 condition này |
| **GAP-4** | Quyết định **Pro** cho share có template id **không có trong catalog local** (kể cả design `stack` không `origin_template_id`) | ~~Q-7~~ | ✅ **ĐÓNG** (2026-10-02, [answers §A-Q7](answers-1-2-19.md)) — **2 nhánh**: id đã biết ⇒ cờ Pro thật · id lạ ⇒ luôn coi là Pro | **Đã sinh:** tách nhánh TS-54 / TS-57, cập nhật TS-39, **thêm TS-54b** (P1). `test-plan` nên dùng **Decision Table** cho 3 yếu tố: id nhận diện được? × template có cờ Pro? × entitlement máy B |
| **GAP-5** | **Oracle của wallpaper đã áp dụng** trên màn khoá máy B: dữ liệu sự kiện/calendar nào được dùng sau khi `selected calendars` bị strip | ~~Q-8~~ | ✅ **ĐÓNG** (2026-10-02, [answers §A-Q8](answers-1-2-19.md)) — giống preview về **style/bố cục**; dữ liệu là **lịch của máy B** | **Đã sinh:** oracle của TS-58 + TS-27. Phần *calendar nào* của máy B được bind ⇒ hạ xuống **O-22** (MỞ, không chặn) |
| **GAP-6** | Hành vi khi design **vượt giới hạn** publish (>20 ảnh, body >64 KB, `template` >48 KB, ảnh >2 MB) | ~~Q-9~~ | ✅ **ĐÓNG** (2026-10-02, [answers §A-Q9](answers-1-2-19.md)) — API §Limits + §Errors đã định nghĩa đủ (mã lỗi + thông báo chung) | **Đã sinh:** oracle cho TS-31/32/33/91. **Giá trị biên** là việc của `test-plan`/`test-case` (EP/BVA), **không** chờ dev |
| **GAP-7** | Cache link thiết bị (`ink.template.share.links.v1`) sau **xoá tài khoản** / **đăng xuất** / **đổi account** | ~~Q-10~~ | ✅ **ĐÓNG** (2026-10-02, đợt 2, [answers §C-Q10](answers-1-2-19.md)) — **tin cậy TRUNG BÌNH**: cache **bị xoá** ở **cả 3** tình huống | **Đã sinh:** oracle của **TS-66** (Share lại sau account mới ⇒ **link mới**), **TS-21**, **TS-26** (nhánh đăng xuất / đổi account **đã gộp vào TS-26** thay vì sinh condition mới). Nếu app **không** xoá cache ⇒ case **fail** = bug lỗi im lặng; nếu dev nói "by design không xoá" ⇒ viết lại oracle (**O-25**) |
| **GAP-8** | Nhánh **`410` taken-down** (moderation chưa build) | **TB-22** (không tạo được dữ liệu) | ⏸ **PARKED** (không đổi) | 1 condition P3 — **parked**, không tính vào coverage |

---

## 3. Traceability nháp

> Theo [`.claude/rules/testing.md`](../../../.claude/rules/testing.md): `Requirement → Test Condition →
> Test Objective → Test Case`. Bảng này chốt mắt **Requirement ↔ Test Condition**; mã nhóm test object
> chỉ là **gợi ý**, `test-plan` chốt lại. Chỗ nào không trace được về requirement thì ghi **`GAP`**,
> không suy diễn.

| Mục test basis | Test condition | Gợi ý mã nhóm test object cho test-plan | Ghi chú cho test-plan |
|---|---|---|---|
| **VI §1** (6 ô tick) | TS-01 → TS-06 | `ST-A · Entry points` | TS-03 còn hở luồng picker (TB-25) |
| **VI §2** (3 ô) + API §Identity/§Errors | TS-07 → TS-11 | `ST-B · Auth gate` | TS-10/TS-11 **không** có trong VI — nguồn là API; phải ghi rõ trong scope |
| **VI §3** (4 ô) | TS-12, TS-27 (preview sample events) | `ST-C · Happy path gửi` | ✅ **Q-8 đã chốt** — VI §3.04 ↔ VI §9.04 **không còn mâu thuẫn**; phần `preview_url` công khai ⛔ out of scope (Q-5) |
| **VI §4** (4 ô) | TS-13 → TS-16 | `ST-C · Consent ảnh` | ⚠️ **TS-14 (phần nền) + TS-15 dùng oracle TẠM** — Q-6 đã chốt **tin cậy THẤP** (nền mặc định hệ thống), xem **O-24**; phần `asset_ids = []` có oracle chắc; phần ảnh preview công khai ⛔ out of scope (GAP-3a) |
| **VI §5** (3 ô) | TS-17 → TS-20 | `ST-C · Consent chữ` | Bảng quyết định 2 điều kiện (ảnh × chữ) — biên chưa định nghĩa (TB-14) |
| **VI §6** (4 ô) + API §3.2/§The model | TS-21 → TS-26 | `ST-D · Link identity` | TS-25/TS-26 là **API-level**, cần proxy (TB-17 / **O-8** vẫn MỞ). ✅ Q-1 (CAO) + ✅ Q-10 (TRUNG BÌNH) đã chốt ⇒ TS-21/TS-26 **gỡ nhãn chặn**; TS-26 nay gồm nhánh **đăng xuất / đổi account** (cache bị xoá) |
| **API §3.1 + §3.2** (bảng field + Limits) | TS-27 → TS-35 | `ST-E · Payload & privacy` | Phần lớn **không** kiểm được qua UI ⇒ cần proxy/`curl` (TB-23); **không có ô tick nào trong VI**. ✅ **Q-9 đã chốt** cho TS-31/32/33 — giá trị biên do `test-plan`/`test-case` quyết |
| **VI §7** (5 ô) + API §3.3 + §Links | TS-36 → TS-45 | `ST-F · Receive` | TS-41/TS-42 cần **mock response** (TB-23) |
| **VI §8** (6 ô) + API §3.4 | TS-46 → TS-53 | `ST-G · Add` | TS-53 oracle hở (TB-29) |
| **VI §9** (4 ô) + API §3.3 (Pro) | TS-54, **TS-54b**, TS-55 → TS-58 | `ST-H · Pro gate` | ✅ **Q-7 đã chốt** ⇒ 2 nhánh (id đã biết / id lạ), **TS-54b là condition mới**; `test-plan` dùng **Decision Table**. ✅ **Q-8 đã chốt** ⇒ TS-58 đã có oracle |
| **API §3.3** (unknown template ⇒ Pro) | **TS-54b** | `ST-H` | Condition **sinh ra từ quyết định Q-7 ngày 2026-10-02**, không phải từ ô tick VI ⇒ nguồn requirement là **API §3.3 + quyết định của QC/test lead**, phải ghi rõ trong test-plan |
| **VI §10** (3 ô) + API §Errors/§Limits | TS-59 → TS-65 | `ST-I · Error & offline` | TS-61 có nhánh chưa xác định (TB-17) |
| **VI §11** (2 ô) + API §Account deletion | TS-66 → TS-68 | `ST-J · Account deletion` | ✅ **TS-66 gỡ chặn** — Q-10 đã chốt (TRUNG BÌNH): cache bị xoá ⇒ Share lại cho **link mới**; Q-1 đã chốt (CAO): **không** có đường thu hồi 3.9 trong app. **TS-69 ⏸ hoãn** khỏi `1-2-19` (✅ Q-2 = APP-ONLY) |
| **VI §12** (1 ô) | TS-70 → TS-72 | `ST-K · Localisation` | Arabic có thể **không thực thi được** (TB-13). ✅ **Q-4 đã chốt** ⇒ TS-72 gỡ nhãn |
| **FE §3 → §10** | TS-73 → TS-89 | `ST-L · Web /t/<id>` | ⏸ **TOÀN NHÓM HOÃN khỏi slug `1-2-19`** (✅ Q-2 = APP-ONLY) — chạy ở **slug mới** khi FE xác nhận trang live. Q-3 ⛔ out of scope; Q-5 ⛔ out of scope; ✅ Q-4 đã chốt cho TS-86 |
| **API §Basics, §Ids, §Limits, §Links** | TS-90 → TS-97 | `ST-M · Cross-cutting NF` | TS-92 **không** trace được về test basis (không có device matrix) ⇒ nhãn `GAP` về nguồn requirement, phạm vi do test lead quyết (TB-19). **TS-93 ⛔ out of scope** (✅ Q-3 — dev tự verify) |
| **API §3.8** (list mine) | — *(không sinh condition đợt này)* | — | ✅ **`GAP-1` đóng** (Q-1, tin cậy CAO): app 1.2.19 **không có UI** ⇒ **ngoài phạm vi UI test** đợt `1-2-19`; chỉ `curl` nếu cần ở nhóm NF (**tuỳ chọn**, không bắt buộc) |
| **API §3.9** (stop sharing) | — *(không sinh condition đợt này)* | — | ✅ **`GAP-2` đóng** (Q-1, tin cậy CAO) — như trên. **Residual risk:** không có đường thu hồi link trong app |
| **API §3.3** (`410`) | — | — | **`GAP-8`** — không tạo được dữ liệu, parked |
| **API §3.5** (`/page`) | TS-87 (gián tiếp) | `ST-L` | API tự khai "**not for the app**" ⇒ không sinh condition phía app |
| **VI §KN.1 → §KN.3** (*đã biết, không báo lỗi*) | — | — | **Không** sinh condition; nhưng §KN.2 là **nguồn được chọn cho quyết định Q-1** (app không có UI 3.8/3.9 — tin cậy CAO), và §KN.3 ("tên wallpaper cũng công khai") là **thông tin riêng tư cần nói rõ trong test-plan**, không phải thứ để bỏ qua |

**Chưa trace được ngược về requirement (đánh dấu `GAP` theo rule):** TS-92 (device matrix), TS-53
(acceptance criteria cho thất bại giữa đường khi Add), TS-97 (nội dung share sheet). Ba condition này
**vẫn giữ trong mục 2** vì rủi ro thật, nhưng `test-plan` phải ghi rõ **oracle do QC đề xuất**, không
phải requirement của dev.

---

## 4. Câu hỏi cần làm rõ trước khi lập test plan

### 4A · Câu hỏi **CHẶN** — **0 còn lại / 10 ban đầu** (thuộc mục 0 của skill `test-analysis`)

> ✅ **Không còn câu hỏi CHẶN nào.** Cả 10 câu đã được xử lý bởi **con người (QC/test lead)**, chi tiết +
> lý do + nguồn ghi tại [answers-1-2-19.md](answers-1-2-19.md). Agent **không** tự trả lời câu nào.
>
> ⚠️ **"Hết câu CHẶN" KHÔNG đồng nghĩa "test basis đã sạch":** 8 câu được chốt bằng **assumption của
> QC/test lead** (không phải fact từ dev) với **mức tin cậy khác nhau**, 2 câu được chuyển **out of
> scope**. Các mâu thuẫn/khoảng trống văn bản trong 3 tài liệu test basis **vẫn chưa được dev sửa**.

#### 4A-1 · ✅ **ĐÃ CHỐT ĐỢT 2** (3 câu: Q-1, Q-6, Q-10) — QC/test lead **chủ động chốt để đi tiếp pipeline, KHÔNG chờ dev**

> **Nguồn cho cả 3 câu:** **User (QC/test lead), chủ động chốt để đi tiếp pipeline, xác nhận trong hội
> thoại Claude Code, 2026-10-02 — KHÔNG phải câu trả lời từ dev, độ tin cậy khác nhau theo từng câu.**
> Chi tiết: [answers-1-2-19.md §C](answers-1-2-19.md).
> ⚠️ `test-plan`/`test-case` **phải mang theo đúng mức tin cậy** — **không** được viết như thể cả 3
> quyết định đều chắc chắn ngang nhau.

| # | Câu hỏi gốc (lý do dừng mục 0 trước đây) | Quyết định | **Mức tin cậy** | Hệ quả |
|---|---|---|---|---|
| **Q-1** | App **1.2.19 có** màn "link của tôi" (API §3.8) và nút "ngừng share một link" (API §3.9) **hay không**? *(mục 0: **mâu thuẫn nội bộ** VI §KN.2 ↔ API §Section numbers, 2 cách hiểu ⇒ ±10–12 condition)* | **KHÔNG CÓ UI** này trong app 1.2.19. *Lý do: VI là checklist QC viết riêng cho đợt test 1.2.19, phần "Đã biết, không cần báo lỗi" khẳng định trực tiếp "chưa có cách xoá riêng một link, chưa có danh sách 'link của tôi'" — nguồn mô tả **hiện trạng UI** đáng tin hơn câu liệt kê route trong API doc (API doc liệt kê đủ protocol/route backend, kể cả 3.8/3.9 có thể chưa lộ ra UI app đợt này).* | **CAO** | **GAP-1 + GAP-2 đóng** — **không** sinh condition UI cho "list my shares"/"stop sharing" đợt `1-2-19`; route **3.8/3.9 ngoài phạm vi UI test** (chỉ `curl` nếu cần, nhóm NF, tuỳ chọn). **TS-26 gỡ nhãn chờ Q-1**; TS-21, TS-66 gỡ nhãn. **Residual risk:** app **không có đường thu hồi link** |
| **Q-10** | Cache link thiết bị `ink.template.share.links.v1` **có bị xoá** khi **xoá tài khoản** / **đăng xuất / đổi account**? *(mục 0: **thiếu acceptance criteria**, 2 cách hiểu pass/fail ngược nhau, nhánh xấu là lỗi im lặng)* | **BỊ XOÁ** cả khi **xoá tài khoản** (nhất quán với việc server xoá hết share khi xoá account) **và** khi **đăng xuất / đổi account**. *Nguyên tắc: cache gắn theo account đang đăng nhập, không xoá sẽ là rủi ro — account B có thể vô tình thấy/tái dùng link cache của account A trên cùng máy.* | **TRUNG BÌNH** | **GAP-7 đóng**; oracle cho **TS-66** (Share lại ⇒ **link mới**), **TS-21**, **TS-26** (nhánh logout/đổi account). Nếu app không xoá cache ⇒ case **fail** = bug lỗi im lặng |
| **Q-6** | Khi bỏ ảnh riêng ra (*Use Ink backgrounds*), **nền thay thế** chính xác là gì với design `stack` **không** `origin_template_id`? *(mục 0: **thiếu acceptance criteria** cho nhánh fallback, 3 expected result khác nhau)* | **Nền mặc định chung của hệ thống** — không phải nền catalog cụ thể nào, vì design `stack` tự dựng **không có catalog để tham chiếu**. ⚠️ *Đây là **suy luận kỹ thuật hợp lý nhất** khi **không có dòng nào trong 3 tài liệu gợi ý trực tiếp** — **KHÔNG phải fact**, độ tin cậy **thấp hơn mọi assumption trước**.* | **THẤP** ⚠️ | **GAP-3b đóng TẠM**; **TS-14** (phần nền) + **TS-15** dùng **oracle tạm**. **Bắt buộc giữ Open Question mới O-24** — nếu dev trả lời khác thì **đổi expected result** của TS-14/TS-15 |

#### 4A-2 · ✅ **ĐÃ CHỐT ĐỢT 1** (5 câu) — assumption có xác nhận của QC/test lead, **không phải fact từ dev**

> **Nguồn cho cả 5:** **User (QC/test lead), xác nhận trong hội thoại Claude Code, 2026-10-02.**
> Chi tiết + lý do nguyên văn: [answers-1-2-19.md §A](answers-1-2-19.md).
> ⚠️ `test-plan`/`test-case` **phải mang theo nhãn** *"Assumption đã xác nhận bởi QC/test lead,
> 2026-10-02, không phải fact từ dev"* — nếu dev trả lời khác thì expected result phải sửa lại.

| # | Quyết định | Hệ quả |
|---|---|---|
| **Q-2** | **Phạm vi QC đợt `1-2-19` = APP-ONLY.** Trang web `/t/<id>` không thuộc slug này. *Lý do: VI (chính checklist QC đang dùng làm test basis) tự nói rõ trang web chưa làm và dặn "không cần báo lỗi" + cho cách test vòng qua bằng `ink://`. Đây là QC tự quyết phạm vi test của chính mình dựa trên checklist mình đang chạy, không phải đoán hành vi sản phẩm.* | ⏸ Nhóm L (**17** condition TS-73 → TS-89) + **TS-69** hoãn khỏi `1-2-19`, **giữ nguyên trong tài liệu**, chạy ở **slug mới** khi FE xác nhận trang live. **Rủi ro còn lại:** nhóm F vào qua `ink://`, luồng end-to-end thật **chưa từng chạy** ⇒ `test-plan` phải ghi ở residual risk |
| **Q-4** | Trang `/t/<id>` theo **ngôn ngữ người xem (visitor)**; `lang` người gửi **chỉ là fallback** khi không xác định được ngôn ngữ visitor, rồi English. *Lý do: FE §7 nêu rõ thứ tự ưu tiên (URL segment/Accept-Language trước, fallback về `lang` của share sau, rồi English); câu của API chỉ là mô tả ngắn cho dev mobile, không phải spec ngôn ngữ chi tiết — FE có thẩm quyền cao hơn cho đúng topic này.* | TS-86 gỡ nhãn "mâu thuẫn Q-4" (**nhưng vẫn hoãn** theo Q-2); TS-72 gỡ nhãn, **vẫn trong phạm vi** |
| **Q-7** | **Không thực sự mâu thuẫn — 2 nhánh:** **(a) id đã biết trong catalog** ⇒ Pro gate theo **cờ Pro thật** của template · **(b) id lạ / không nhận diện được** (app cũ hơn, design `stack` không `origin_template_id`) ⇒ **luôn coi là Pro**, Set as current **luôn paywall** bất kể design có customization hay không. *Lý do: VI §9.01 nói về design thuộc catalog đã biết (id nhận diện được) không có Pro customization; API "unknown id ⇒ Pro" chỉ áp dụng khi máy B không nhận ra id. Hai tình huống khác nhau, không loại trừ nhau.* | **GAP-4 đóng**; TS-54/TS-55/TS-57/TS-39 cập nhật rõ 2 nhánh; **thêm TS-54b** (P1). `test-plan` nên dùng **Decision Table** |
| **Q-8** | *"Giống bản xem trước"* = giống về **style/bố cục**; **dữ liệu sự kiện/calendar luôn là của máy B**, **không bao giờ** là dữ liệu từ máy A. *Lý do: đây là cách mọi template trong app vốn hoạt động (preview luôn render sự kiện mẫu, áp dụng thật luôn dùng lịch thật của máy đang dùng) — không phải hành vi riêng của feature share.* | **GAP-5 đóng**; oracle của **TS-58** + **TS-27** đã rõ. Còn hở **không chặn**: *calendar nào* của máy B được bind ⇒ **O-22** |
| **Q-9** | **Hành vi đã được định nghĩa đủ bởi API — không còn là ambiguity ở mức test-analysis.** *Lý do: API đã có bảng Limits (413 khi vượt size ảnh/body, 400 invalid_template khi vượt design/photos) + bảng error-code (`invalid_template` → thông báo chung "Couldn't create a share link. Try again."). Phần còn lại (giá trị biên cụ thể để viết test case) là quyết định thiết kế test ở bước `test-plan`/`test-case`, không phải gap cần dev trả lời.* | **GAP-6 đóng**; TS-31/32/33/91 bỏ nhãn chờ + note **"giá trị biên cụ thể do `test-plan`/`test-case` quyết định"** |

#### 4A-3 · ⛔ **OUT OF SCOPE đợt `1-2-19`** (2 câu) — dev tự verify

> Đây là quyết định **phạm vi**, **không** phải quyết định về expected result. QC **không** kết luận
> hành vi nào đúng, **không** viết oracle cho phần này trong đợt `1-2-19`.
> **Nguồn:** User (QC/test lead), hội thoại Claude Code, 2026-10-02 — [answers §B](answers-1-2-19.md).

| # | Câu hỏi | Quyết định | Hệ quả |
|---|---|---|---|
| **Q-3** | **App Check chấp nhận build nào** cho (a) publish/upload (3.1/3.2) và (b) đọc share (3.3)? VI: chỉ **Ink Prod**. FE §10: *"1.2.19 or a TestFlight build"*. API §Testing: gợi ý **simulator**. | ⛔ **Out of scope đợt `1-2-19` — dev tự test/verify** | **TS-93** giữ trong tài liệu, đổi trạng thái "out of scope", **không** vào bộ test case đợt này. **Môi trường QC đợt này chốt theo VI §0.1** (Ink Prod 1.2.19, máy thật, 2 máy A/B) |
| **Q-5** | Khi người gửi chọn **Use Ink backgrounds**, ảnh **preview công khai** (`preview_url` / `og:image`) **có bắt buộc** được render lại **không chứa ảnh riêng** hay không? | ⛔ **Out of scope đợt `1-2-19` — dev tự test/verify** | **GAP-3a đóng** (out of scope), **GAP-3b vẫn mở** (Q-6). Nhãn out-of-scope áp cho **đúng phần ảnh preview công khai** của TS-14, TS-27, TS-73, TS-82 — phần **design data** của TS-14 **vẫn trong phạm vi** |

### 4B · Câu hỏi **MỞ** (không chặn `test-plan`, nhưng phải mang sang) — **25 câu** (O-21 **đã chốt** 2026-10-02 ⇒ **24 câu còn mở**)

> **Vì sao các câu này KHÔNG chặn (tự kiểm theo mục 0 của skill `test-analysis`, 2026-10-02 đợt 2):**
> không câu nào trong O-1 → O-25 thuộc 4 lý do dừng bắt buộc nữa — (a) **không** câu nào tạo ra 2 cách
> hiểu dẫn tới **2 tập test condition khác hẳn** (các cách hiểu còn lại chỉ thay đổi **độ sâu coverage**
> hoặc **dữ liệu test**, không đảo pass/fail của condition đã viết); (b) **không** còn mâu thuẫn nội bộ
> nào chưa được con người xử lý; (c) risk likelihood/impact đã được gán **có căn cứ định tính ghi rõ**
> (A-2) — **O-21** chỉ là **phê chuẩn** thang đó, không phải thiếu căn cứ; (d) test basis **không phải**
> user story thiếu acceptance criteria (các ô tick VI được dùng nguyên văn làm acceptance criteria — A-3).
> **Phần lớn O-* còn lại là quyết định thuộc bước `test-plan`** (môi trường/mock **O-11**, device matrix
> **O-14**, baseline ảnh **O-9**, ngưỡng hiệu năng **O-15**, phương tiện tạo dữ liệu hạn mức **O-20**,
> giảm phạm vi tường minh) — `test-plan` có cơ chế để quyết (entry/exit criteria, descope tường minh),
> `test-analysis` thì không.
>
> **Cập nhật 2026-10-02 (chuyển `DRAFT → READY`):** **O-21 đã được chốt** (thang risk/ưu tiên được phê
> chuẩn) ⇒ còn **24 câu MỞ**, **không câu nào chặn** `test-plan`. **O-9 / O-11 / O-14 / O-15 / O-20** được
> **chuyển cho `test-plan` xử lý** theo xác nhận của user 2026-10-02 (descope tường minh nếu thiếu phương
> tiện). **O-24 / O-25** chạy **song song, không chặn**, **với điều kiện** `test-plan`/`test-case` mang
> theo **đúng mức tin cậy** của từng assumption (CAO / TRUNG BÌNH / **THẤP**), không tô đều ngang hàng.
> **Không câu nào bị xoá hay coi là đã trả lời** — `test-plan` phải mang nguyên cả 24 câu.

| # | Câu hỏi | Gốc | Ảnh hưởng |
|---|---|---|---|
| O-1 | Xin **4 tài liệu đang thiếu** (`runbooks/template-sharing.md`, `template-sharing.md`, `template-sharing-history.md`, bản gốc `template-sharing-web-page.md`) — runbook là nguồn duy nhất cho nội bộ app, nhiều oracle đang hở vì thiếu nó | TB-11 | Runbook là cách **kiểm chứng** các quyết định tin cậy THẤP/TRUNG BÌNH (Q-6 → **O-24**; Q-8, Q-10 → **O-25**) — hiện chúng chỉ dựa trên phán đoán của QC/test lead |
| O-2 | **Danh sách locale** app đang ship (18 ngôn ngữ gồm những gì), và **Arabic có nằm trong đó** không ⇒ condition RTL có thực thi được không | TB-13 | TS-70, TS-71, TS-86 |
| O-3 | Biên của bộ phát hiện: ảnh **cutout/tách nền**, ảnh **Ink AI**, **quote catalog chưa sửa**, **tên wallpaper** — cái nào tính là "ảnh riêng"/"chữ tự gõ" để chọn hộp thoại | TB-14 | TS-12 → TS-20 |
| O-4 | Hạn mức Free **5 design** đếm **cái gì** (có tính Live Activity/Note/Widget?), và máy **chưa đăng nhập** được coi là Free hay Pro | TB-15 | TS-47, TS-48, TS-38 |
| O-5 | Tên wallpaper **>80 ký tự** / **rỗng** / chứa `<script>`/emoji/RTL: app cắt, chặn, hay publish lỗi; màn *Shared template* **trong app** xử lý untrusted text thế nào | TB-16 | TS-36, TS-79 |
| O-6 | Card unfurl **đã gửi** trong iMessage/Zalo/Messenger giữ ảnh/tiêu đề **cũ** sau khi người gửi sửa và share lại — **bug hay by design**? | TB-20 | TS-81, TS-82 |
| O-7 | **Huỷ share sheet iOS sau khi link đã tạo**: link vẫn công khai dù chưa gửi cho ai — by design (và cách thu hồi là 3.9?) hay lỗi? | TB-21 | TS-16, TS-18, GAP-2 |
| O-8 | App **có** cache link per-wallpaper không (VI nói "không tạo lại", API nói cache là tuỳ chọn)? Lần share thứ 2 có **tốn 1 publish/ngày**? Có cho share **offline** wallpaper đã share không? | TB-17 | TS-21, TS-25, TS-61, TS-62 |
| O-9 | Kế hoạch **chụp screenshot** cho 5–7 màn mới của feature, và quyết định `flow-no`/`screen-name` theo [`screenshot-naming.md`](../../../.claude/rules/screenshot-naming.md) (thuộc `04_discover` hay **mint flow mới** — rule §2 cấm chèn giữa). **➡️ Chuyển cho `test-plan` xử lý, theo xác nhận của user 2026-10-02** (descope tường minh nếu không chụp được trong đợt) | TB-12 | Visual oracle cho mọi condition UI; TS-70, TS-71 |
| O-10 | Có **proxy/log/diagnostic** nào để phân biệt `error_code` (mọi lỗi publish đang thu về **một** thông báo)? | TB-18 | TS-11, TS-62, TS-63, TS-65 |
| O-11 | Có **môi trường mock/staging** hoặc cách **inject response độc / lỗi 500** để chạy nhóm điều kiện bảo mật "untrusted response"? **➡️ Chuyển cho `test-plan` xử lý, theo xác nhận của user 2026-10-02** — nếu không có phương tiện thì `test-plan` phải **descope tường minh** nhóm bảo mật này (không im lặng tính là đã phủ) | TB-23 | TS-41, TS-42, TS-57, TS-77, TS-80 |
| O-12 | Nhánh **`410`** có cách tạo dữ liệu nào không (moderation chưa build) — nếu không, chốt **parked** | TB-22 | GAP-8 |
| O-13 | Ô *"`/share/<id>` calendar share pages still work"* (FE §10) có thuộc **phạm vi QC đợt này** không, hay thuộc feature share **lịch** (ngoài phạm vi theo README của spec)? **Cập nhật 2026-10-02:** TS-88 thuộc nhóm L ⇒ **đã hoãn khỏi `1-2-19`** theo Q-2; câu hỏi vẫn cần trả lời **trước đợt web** | FE §10 | TS-88 ⏸ |
| O-14 | **Device/OS matrix** chính thức cho đợt này (iPhone 18.x / 26.x? iPad có không?) và **build number** cụ thể của 1.2.19 để gắn bug. **➡️ Chuyển cho `test-plan` xử lý, theo xác nhận của user 2026-10-02** (chốt trong entry criteria; nếu chưa có số build thì ghi rõ là chưa có, **không** suy diễn) | TB-19 | TS-92; entry criteria |
| O-15 | Ngưỡng **thời gian** chấp nhận được cho *"Creating link…"* (có SLA nào không). **➡️ Chuyển cho `test-plan` xử lý, theo xác nhận của user 2026-10-02** — không có SLA thì `test-plan` **descope tường minh** phần pass/fail định lượng, chỉ giữ "không treo UI / cuối cùng có ra share sheet" | TB-24 | TS-90, TS-91 |
| O-16 | Hành vi mong đợi khi **Add thất bại giữa đường** (tải được một phần ảnh): rollback, giữ item không ảnh, hay thông báo gì | TB-29 | TS-53 |
| O-17 | "The link goes into a **share sheet under the user's name**" nghĩa chính xác là gì — share sheet mang theo **những gì** ngoài URL? | TB-26 | TS-97 |
| O-18 | Luồng sau khi bấm **⬆︎** rồi chọn wallpaper (có chọn nhiều được không, huỷ giữa danh sách thì sao) | TB-25 | TS-03 |
| O-19 | Các nhánh đăng nhập **thất bại / mất mạng giữa lúc sign-in**: có resume không, có giữ lựa chọn ảnh/chữ đã bấm không | TB-30 | TS-07 → TS-10 |
| O-20 | Có **script/seed** nào để chạm hạn mức (500 link, 30 publish/ngày, 100 upload/ngày) không — nếu không, test-plan phải quyết định **giảm phạm vi** nhóm hạn mức một cách tường minh. **➡️ Chuyển cho `test-plan` xử lý, theo xác nhận của user 2026-10-02** | TB-27 | TS-62, TS-63 |
| O-21 | ✅ **ĐÃ CHỐT 2026-10-02** — thang **risk** do QC gán ở mục 2 (ưu tiên: rò rỉ dữ liệu công khai > mất dữ liệu/paywall > lỗi hiển thị) **đã được phê chuẩn**. **Nguồn:** User (QC/test lead), xác nhận trong hội thoại Claude Code, 2026-10-02. ⚠️ Vẫn là **thang định tính do QC đặt** (bundle **không** có số liệu business — A-2), chỉ là **đã được người có thẩm quyền phê chuẩn**, **không** phải đã có dữ liệu business | A-2 | Ưu tiên P1/P2/P3 toàn mục 2 — **không đổi**, nay đã có phê chuẩn |
| **O-22** | Sau khi Add + Set as current, **calendar nào của máy B** được bind vào wallpaper (tất cả calendar? lựa chọn mặc định của app? lựa chọn hiện hành của máy B)? *(hạ từ CHẶN xuống MỞ ngày 2026-10-02: ✅ Q-8 đã chốt oracle ở mức "dữ liệu là lịch của máy B" ⇒ pass/fail của TS-58 **không** còn phụ thuộc câu này)* | TB-08 (phần còn lại sau Q-8) | TS-58 (độ chi tiết của oracle, không đổi pass/fail) |
| **O-23** | ⏸ **Điều kiện tiền đề cho đợt web (slug mới):** FE **xác nhận trang `/t/<id>` đã live trên production** — khi nào? Sau đó mint **slug mới** cho bộ test-analysis/test-plan/test-case của 17 condition nhóm L + TS-69 (theo convention repo: không ghi đè bộ `1-2-19`) | Quyết định Q-2 (2026-10-02) | Nhóm L (17), TS-69 |
| **O-24** | **Xác nhận lại với dev: nền mặc định chính xác là gì** khi chọn *Use Ink backgrounds* trên design `stack` **không** `origin_template_id` (hiện dùng oracle tạm "nền mặc định chung của hệ thống" — **Q-6, tin cậy THẤP**). **Nếu sai sẽ đổi expected result của TS-14 (phần nền) và TS-15.** *(không chặn: TS-14 vẫn còn phần oracle chắc `asset_ids = []`; TS-15 là P2 và phần "máy B thấy đúng ảnh của máy A" không phụ thuộc câu này)* | Quyết định Q-6 (2026-10-02, đợt 2) — TB-06 | **TS-14** (phần nền), **TS-15** |
| **O-25** | **Xác nhận lại với dev 2 quyết định QC tự chốt:** (a) **Q-1** — app 1.2.19 thật sự **không** gọi 3.8/3.9 (nếu có ⇒ bổ sung ~10–12 condition, có 2–3 P1 về thu hồi link công khai, ở **slug mới**) · (b) **Q-10** — cache link **có** bị xoá khi logout/đổi account/xoá tài khoản (nếu dev nói "by design không xoá" ⇒ viết lại oracle TS-66). Đồng thời đề nghị dev **sửa mâu thuẫn văn bản** API §Section numbers ↔ VI §KN.2 và bổ sung cache vào API §Account deletion | Quyết định Q-1 (CAO) + Q-10 (TRUNG BÌNH), 2026-10-02 đợt 2 — TB-01, TB-10 | TS-21, TS-26, TS-66; GAP-1, GAP-2 (có thể mở lại ở slug mới) |

### 4C · Giả định đang dùng (**là giả định, KHÔNG phải fact**)

| # | Giả định | Vì sao phải nêu |
|---|---|---|
| **A-1** | Cả **3 file** là test basis của slug `1-2-19` và cùng mô tả **một luồng end-to-end** (app gửi → API → trang web → app nhận); đối tượng chính của đợt là **app**, trạng thái của trang web là **Q-2** | Do caller cung cấp; 3 file **không** có mục nào tự khai quan hệ với nhau, cũng không có version/ngày |
| **A-2** | Mọi **risk likelihood/impact** ở mục 2 là **phán đoán của QC** dựa trên tính chất tài liệu hoá được (mức công khai dữ liệu, mất dữ liệu, paywall/doanh thu, tần suất gặp) — bundle **không** có dữ liệu business | ISTQB §5.2: risk level phải có căn cứ; đây là căn cứ **định tính của QC**, không phải fact ⇒ xem O-21 |
| **A-3** | **Ô tick của VI** được coi là **acceptance criteria** (§4.5.2) ở những ô có nêu **kết quả quan sát được**; ô chỉ nói "kiểm …" (vd §12) được coi là **hướng dẫn**, không phải oracle | Tránh biến câu hướng dẫn thành expected result |
| **A-4** | Mã `VI §N.MM` / `FE §N` / `API §3.x` là **do QC gán** (VI không có mã cho từng ô tick) | Để test-plan/test-case trace được, nhưng không tưởng là mã của dev |
| **A-5** | **Im lặng ở 4 tài liệu thiếu** (runbook/history/backend/web-page gốc) **không** được coi là "không có gì" hay "giữ nguyên" — đó là **gap** | Nguyên tắc của `.claude/rules/testing.md`: không suy diễn requirement thiếu |
| **A-6** | Phạm vi thiết bị **tạm** theo thói lệ repo (iPhone iOS 18.x / 26.x, iPad "nếu có") vì bundle **không có** device matrix | Phải được test lead xác nhận (O-14) — nếu không, TS-92 không có nguồn |
| **A-7** | **Dark Mode không thuộc phạm vi** (project chưa hỗ trợ Dark Mode) ⇒ **không** tính là khoảng trống coverage | Theo bối cảnh project đã ghi nhận; nêu ra để không ai bổ sung condition Dark Mode |
| **A-8** | Feature **không** liên quan flow `11_share` (share lịch/co-edit, Phase 2) ⇒ **không** cross-reference `login-and-calendar-sharing/` hay `ink-identity-sync-flow/`. **Ngoại lệ duy nhất:** TS-88 (`/share/<id>` regression) chạm sang trang share lịch ⇒ O-13 | Do caller + [README của spec](../../specs/share-template-link/README.md) xác nhận |
| **A-9** | `fe-template-share-page.md` **là** tài liệu mà API §Not available yet gọi là `template-sharing-web-page.md` | Tên khác nhau, chưa xác nhận (TB-28) — nếu sai thì nhóm L đang dựa trên bản spec khác |

**Bổ sung 2026-10-02 — 5 assumption mới, đã được QC/test lead xác nhận nhưng VẪN LÀ ASSUMPTION:**

| # | Giả định | Nguồn | Vì sao vẫn phải nêu là **giả định**, không phải fact |
|---|---|---|---|
| **A-10** | **Q-2:** phạm vi QC đợt `1-2-19` là **APP-ONLY**; trang `/t/<id>` hoãn sang slug mới | User (QC/test lead), hội thoại Claude Code, **2026-10-02** | Đây là **quyết định phạm vi của QC**, không phải cam kết của PM/FE về exit criteria của release 1.2.19. FE §Status vẫn nói trang là **điều kiện trước khi 1.2.19 lên App Store** ⇒ nếu PM giữ nguyên yêu cầu đó, exit criteria release **không** khớp với phạm vi QC đợt này |
| **A-11** | **Q-4:** trang `/t/<id>` theo ngôn ngữ **visitor**, `lang` người gửi là **fallback** | User (QC/test lead), **2026-10-02** | Dev backend **chưa** sửa câu của API §3.2 (*"the web page is rendered in it"*). Mâu thuẫn văn bản **vẫn tồn tại** trong test basis — QC chỉ chọn FE là nguồn có thẩm quyền cho topic này |
| **A-12** | **Q-7:** VI §9.01 và API §3.3 là **2 nhánh** (id đã biết / id lạ), không mâu thuẫn | User (QC/test lead), **2026-10-02** | Không tài liệu nào **viết ra** cách phân nhánh này — đó là cách đọc hợp lý nhất do QC/test lead chốt. Nếu dev xác nhận app **không** phân biệt 2 nhánh thì TS-54/TS-54b phải viết lại |
| **A-13** | **Q-8:** wallpaper áp dụng giống preview về **style/bố cục**, dữ liệu sự kiện là **của máy B** | User (QC/test lead), **2026-10-02** | Suy ra từ **hành vi chung của mọi template trong app**, không từ câu nào trong 3 file test basis. `runbooks/template-sharing.md` (nơi duy nhất có thể xác nhận) **vẫn thiếu** (TB-11/A-5) |
| **A-14** | **Q-9:** API §Limits + §Errors đã định nghĩa đủ hành vi vượt giới hạn; **giá trị biên** là việc của `test-plan`/`test-case` | User (QC/test lead), **2026-10-02** | API định nghĩa hành vi **phía server** (mã lỗi). Việc **app có tự hạ kích thước/tự cắt trước khi gửi hay không** vẫn **không** có trong tài liệu — assumption ở đây là *"không cần biết điều đó để viết condition/oracle ở mức test-analysis"*, không phải *"app không tự hạ kích thước"* |

**Bổ sung 2026-10-02 (đợt 2) — 3 assumption mới cho Q-1 / Q-10 / Q-6, VẪN LÀ ASSUMPTION, mức tin cậy khác nhau:**

| # | Giả định | Mức tin cậy | Nguồn | Vì sao vẫn phải nêu là **giả định**, không phải fact |
|---|---|---|---|---|
| **A-17** | **Q-1:** app 1.2.19 **không có** UI "link của tôi"/"ngừng share" ⇒ route API **3.8/3.9 ngoài phạm vi UI test** đợt này | **CAO** | User (QC/test lead), chủ động chốt để đi tiếp pipeline, **2026-10-02** — **không** phải câu trả lời từ dev | Dev **chưa** xác nhận và **chưa** sửa câu API §Section numbers (*"the app calls 3.1–3.4 and 3.8–3.9"*). **Mâu thuẫn văn bản vẫn tồn tại** trong test basis; QC chỉ chọn VI §KN.2 là nguồn có thẩm quyền hơn cho **hiện trạng UI**. Nếu sai ⇒ thiếu ~10–12 condition (2–3 P1) ⇒ xem **O-25** |
| **A-18** | **Q-10:** cache `ink.template.share.links.v1` **bị xoá** khi xoá tài khoản **và** khi đăng xuất/đổi account | **TRUNG BÌNH** | User (QC/test lead), **2026-10-02** — không phải câu trả lời từ dev | Suy ra từ **nguyên tắc nhất quán** (server xoá hết share khi xoá account; cache gắn theo account đang đăng nhập), **không** từ câu nào trong test basis — API §Account deletion **vẫn không nhắc** cache thiết bị. Nhánh xấu là **lỗi im lặng** ⇒ phải test tường minh |
| **A-19** | **Q-6:** nền thay thế khi chọn *Use Ink backgrounds* trên design `stack` không `origin_template_id` = **nền mặc định chung của hệ thống** | **THẤP** ⚠️ | User (QC/test lead), **2026-10-02** — không phải câu trả lời từ dev | **Suy luận kỹ thuật**, **không một dòng nào trong 3 tài liệu test basis gợi ý trực tiếp** (runbook — nơi duy nhất có thể xác nhận — **vẫn thiếu**, TB-11/A-5). Đây là **assumption yếu nhất** của cả tài liệu ⇒ expected result của **TS-14 (phần nền)** và **TS-15** là **TẠM**, giữ **O-24** |

**Bổ sung 2026-10-02 — 2 quyết định PHẠM VI (không phải assumption về expected result):**

| # | Quyết định phạm vi | Nguồn | Ghi chú bắt buộc |
|---|---|---|---|
| **A-15** | **Q-3** (App Check chấp nhận build nào) ⛔ **out of scope đợt `1-2-19`** — dev tự verify | User (QC/test lead), **2026-10-02** | QC **không** khẳng định App Check chấp nhận build nào. Môi trường QC đợt này = **VI §0.1**. TS-93 không vào bộ test case đợt này |
| **A-16** | **Q-5** (ảnh preview công khai có rò ảnh riêng) ⛔ **out of scope đợt `1-2-19`** — dev tự verify | User (QC/test lead), **2026-10-02** | QC **không** kết luận preview có/không chứa ảnh riêng, **không** kết luận đây là bug hay by design. Đường rò rỉ tiềm năng này **không** được QC phủ trong đợt `1-2-19` ⇒ `test-plan` phải ghi vào **residual risk** |

---

## 5. Trạng thái & điều kiện chuyển tiếp

> **Lần cập nhật gần nhất:** 2026-10-02 **(đợt 3)** — **con người chuyển `DRAFT → READY`** sau khi xác
> nhận **cả 3 điều kiện tối thiểu** nêu ở đợt 2.
> **Nguồn:** **User (QC/test lead), xác nhận cả 3 điều kiện trong hội thoại Claude Code, 2026-10-02**
> (ghi nhận qua orchestrator `/spec-intake`; agent `qc-test-analysis` chỉ ghi lại, **không** tự chuyển).
> Trước đó: đợt 2 (2026-10-02) ghi nhận **3 quyết định cuối** (Q-1, Q-6, Q-10) do QC/test lead chủ động
> chốt ([answers-1-2-19.md §C](answers-1-2-19.md)) ⇒ **0 câu CHẶN**, trạng thái `BLOCKED → DRAFT`.
> **Nội dung phân tích (condition / risk / assumption) KHÔNG đổi ở đợt 3** — chỉ đổi trạng thái và ghi
> chú chuyển việc cho `test-plan`.

| | |
|---|---|
| **Analysis Status** | **`READY`** *(chuyển `DRAFT → READY` ngày **2026-10-02** bởi **con người**; trước đó `BLOCKED → DRAFT` cùng ngày)* |
| **Căn cứ chuyển `READY`** | **Quyết định của User (QC/test lead), xác nhận cả 3 điều kiện trong hội thoại Claude Code, 2026-10-02:** (1) **phê chuẩn thang risk & ưu tiên P1/P2/P3** ở mục 2 (**O-21** — vẫn là thang **định tính của QC**, bundle không có số liệu business, nay **đã được phê chuẩn**) · (2) xác nhận **O-9 / O-11 / O-14 / O-15 / O-20** (baseline ảnh, môi trường mock/staging, device matrix, ngưỡng hiệu năng, phương tiện tạo dữ liệu hạn mức) là **việc thuộc bước `test-plan`** — phải **descope tường minh** nếu thiếu phương tiện — **không** phải gap chặn phân tích · (3) đồng ý **O-24** (nền thay thế, Q-6 tin cậy **THẤP**) và **O-25** (xác nhận lại Q-1 **CAO** + Q-10 **TRUNG BÌNH** với dev) chạy **song song, không chặn**, **điều kiện kèm theo:** `test-plan`/`test-case` **phải mang theo đúng mức tin cậy từng assumption**, **không** tô đều ngang hàng. |
| **Lý do (tự kiểm lại độc lập theo mục 0 của skill, giữ nguyên từ đợt 2)** | **Hết lý do dừng bắt buộc:** (a) *ambiguity 2 cách hiểu ⇒ 2 tập condition khác hẳn* — Q-1/Q-6/Q-10 đã được **con người** chọn cách hiểu, agent không tự chọn; (b) *mâu thuẫn nội bộ* — TB-01/TB-04/TB-07 đã có người phân xử (văn bản vẫn chưa sửa ⇒ **O-25**); (c) *thiếu căn cứ risk* — mọi condition đã có likelihood × impact kèm **căn cứ định tính ghi rõ** (A-2, ma trận ở đầu mục 2), **không** mặc định "trung bình cho xong"; **O-21** chỉ là **phê chuẩn** và **nay đã có** (2026-10-02); (d) *user story thiếu acceptance criteria* — không áp dụng (ô tick VI dùng nguyên văn làm acceptance criteria, A-3). **Mục 4 vẫn còn 24 câu MỞ** — không câu nào thuộc mục 0, và việc chúng không chặn đã được **người** xác nhận; chúng **phải được mang nguyên** sang `test-plan`, **không** được coi là đã trả lời. |
| **Downstream Permission** | **`ALLOWED`** — `test-plan` cho slug `1-2-19` **được phép chạy** từ 2026-10-02 ([`.claude/rules/testing.md`](../../../.claude/rules/testing.md): chỉ `READY` mới được đi tiếp — điều kiện này **đã** thoả, do **người** chốt chứ không phải agent tự mở). |
| **Điều kiện tối thiểu để chuyển `DRAFT → READY` (đã thoả đủ 3/3, 2026-10-02)** | (1) ✅ Test lead **phê chuẩn thang risk & ưu tiên P1/P2/P3** ở mục 2 (**O-21**) · (2) ✅ xác nhận **O-11** (môi trường mock/staging cho nhóm bảo mật), **O-14** (device/OS matrix + build number), **O-9** (kế hoạch chụp baseline ảnh), **O-15** (ngưỡng hiệu năng), **O-20** (phương tiện chạm hạn mức) là **quyết định ở bước `test-plan`** — `test-plan` phải **descope tường minh** nếu không có phương tiện · (3) ✅ chấp nhận **O-24** + **O-25** chạy **song song**, không chặn, kèm điều kiện mang đúng mức tin cậy. **Người chốt + ngày:** **User (QC/test lead), 2026-10-02.** |
| **Đã xử lý ngày 2026-10-02** | **Đợt 3:** con người chuyển **`DRAFT → READY`** / **`BLOCKED → ALLOWED`** sau khi xác nhận 3/3 điều kiện (O-21 phê chuẩn · O-9/O-11/O-14/O-15/O-20 chuyển cho `test-plan` · O-24/O-25 song song, kèm điều kiện mang đúng mức tin cậy) — **không** sửa nội dung condition/risk/assumption nào. **Đợt 1:** 5 câu chốt bằng assumption có xác nhận của QC/test lead (Q-2, Q-4, Q-7, Q-8, Q-9 — A-10 → A-14) · 2 câu out of scope, dev tự verify (Q-3, Q-5 — A-15, A-16) · 4 GAP đóng (GAP-3a, GAP-4, GAP-5, GAP-6). **Đợt 2:** 3 câu cuối do QC/test lead **chủ động chốt, không chờ dev** — **Q-1 (CAO)**, **Q-10 (TRUNG BÌNH)**, **Q-6 (THẤP)** — xem A-17 → A-19; **GAP-1, GAP-2, GAP-7 đóng**, **GAP-3b đóng TẠM**; sinh **O-24**, **O-25**. |
| **Ai đã chuyển trạng thái** | **Con người — User (QC/test lead)**, xác nhận cả 3 điều kiện trong hội thoại Claude Code, **2026-10-02**. Agent `qc-test-analysis` **không** tự chuyển `DRAFT → READY` (chỉ ghi nhận quyết định của người, nhận qua orchestrator `/spec-intake`) và **không** tự trả lời câu nào — cả 10 quyết định ở mục 4A đều do **user (QC/test lead)** đưa ra, nguồn ghi ở [`answers-1-2-19.md`](answers-1-2-19.md). |
| **Trạng thái nội dung** | **98 test condition** (P1 = 39 · P2 = 50 · P3 = 9), trong đó **79 thuộc phạm vi đợt `1-2-19`** (P1 = 34 · P2 = 37 · P3 = 8) — **số lượng không đổi sau đợt 2** + **30 vấn đề testability** (nay **0 CHẶN**, 20 MỞ, 10 đã chốt/out of scope) + traceability nháp. **0 condition bị chặn**; **2 condition dùng oracle TẠM** (TS-14 phần nền, TS-15 — Q-6 tin cậy THẤP). **GAP còn mở: chỉ GAP-8** (⏸ parked, không tính coverage). |
| **Nhãn `test-plan` BẮT BUỘC mang sang (nay ĐÃ được phép chạy — `ALLOWED`)** | (0) **Điều kiện kèm theo của việc mở `READY` (user, 2026-10-02):** mỗi assumption phải xuất hiện **kèm mức tin cậy** (**CAO** / **TRUNG BÌNH** / **THẤP**), **tuyệt đối không** trình bày 10 quyết định như nhau; và **O-9/O-11/O-14/O-15/O-20** phải được `test-plan` **quyết hoặc descope tường minh**, không im lặng bỏ. (1) **18 condition** mang nhãn *"assumption của QC/test lead 2026-10-02, không phải fact từ dev"* — **kèm mức tin cậy** (CAO: Q-1/Q-4/Q-7/Q-8/Q-9 · TRUNG BÌNH: Q-10 · **THẤP: Q-6 ⇒ oracle tạm**) · (2) **18 condition hoãn** (nhóm L + TS-69) ⇒ **mint slug mới**, không ghi đè bộ `1-2-19` · (3) **TS-93 out of scope** · (4) toàn bộ nhãn **TB-\* mức MỞ** (không quyết định nào trong 10 câu đóng chúng) · (5) **O-24 / O-25** (xác nhận lại với dev) phải xuất hiện trong test-plan, không được bỏ. |
| **Residual risk đã biết của phạm vi APP-ONLY** | (a) **Luồng end-to-end thật** (người nhận bấm link https trong chat) **chưa từng được QC chạy một lần nào** trước khi 1.2.19 lên App Store — nhóm F chỉ vào qua `ink://`. (b) **Đường rò rỉ "ảnh preview công khai"** (Q-5) **không** được QC phủ trong đợt này. (c) **Không có đường thu hồi link trong app** (Q-1 — route 3.8/3.9 không có UI): link công khai **chỉ mất khi xoá tài khoản**, kể cả khi user huỷ share sheet sau khi link đã tạo (**O-7**). (d) **Oracle nền thay thế là TẠM** (Q-6, tin cậy THẤP — **O-24**): TS-14 (phần nền)/TS-15 có thể phải viết lại expected result. (e) **Q-10 tin cậy TRUNG BÌNH**: nếu app thực tế không xoá cache, nhánh "phát link đã chết" là **lỗi im lặng**. **Cả 5 điểm không được im lặng** trong `test-plan`. |
| **Rủi ro lớn nhất của việc đi tiếp bằng 10 quyết định của QC/test lead** | Cả 10 câu được chốt **không có dev xác nhận**. Nặng nhất: **Q-6 (tin cậy THẤP)** — nằm trên đường **dữ liệu người dùng công khai**, nếu sai thì expected result của 1 condition **P1** (TS-14) và 1 **P2** (TS-15) sai; **Q-10 (TRUNG BÌNH)** — nếu sai thì TS-66 (P1) đổi oracle; **Q-1 (CAO)** — nếu sai thì thiếu nguyên cụm ~10–12 condition (2–3 P1) về **thu hồi dữ liệu công khai**. Vì vậy **O-24/O-25 phải được giải quyết song song**, và `test-plan`/`test-case` phải ghi mức tin cậy ở từng chỗ, **không** trình bày như fact. |

