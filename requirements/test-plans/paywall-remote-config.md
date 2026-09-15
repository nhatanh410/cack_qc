# Test Plan — Paywall Remote Config (`pro_paywall_config_v1`)

> **Test strategy:** [paywall-remote-config-strategy.md](paywall-remote-config-strategy.md) — vì sao chọn tổ hợp risk-based + specification-based + exploratory có giới hạn, thay vì lặp lại chi tiết ở đây
> **Test basis:**
> - [paywall-config.md](../specs/paywall-config.md) — **runbook kỹ thuật chính thức, mới bổ sung 2026-09-14** (trước đó bị thiếu, xem lịch sử ở mục 10.3 cũ) — schema đầy đủ, field rules, Analytics, bảng Failure modes. Nguồn thẩm quyền cao nhất, dùng để chốt mọi mâu thuẫn giữa 2 tài liệu còn lại.
> - [paywall-qc-vi.md](../specs/paywall-qc-vi.md) — hướng dẫn setup Firebase RC (Phần A, nay có thêm A0 "bản build nào đọc được key") + checklist QC thủ công B1–B9 (Phần B). **Đã cập nhật 2026-09-14** — payload mẫu A4 đã tự sửa `yearly`→`annual`.
> - [paywall-config-builder.html](../specs/paywall-config-builder.html) — tool dựng payload, tự khai: **"Mirrors `ios/Ink/Domain/Pro/PaywallConfigDecoder.swift` + `PaywallContent.swift`"**, chứa hàm `checks()` (từ dòng 750) mã hoá luật validate/fallback. **Đã cập nhật 2026-09-14** — thêm `APP_VERSION`/`versionAtLeast()` (so sánh version thật thay vì chỉ cảnh báo định dạng) và `localeGap()` (cảnh báo locale thiếu áp dụng cho mọi field localized, không chỉ headline).
> - [08_paywall.md](../ui/ux/wideframes/08_paywall.md) — wireframe dựng từ 3 screenshot thật, tự phát hiện 1 lỗi 🔴 đang mở (giá sai đơn vị tiền tệ) và liệt kê 5 màn hình còn thiếu ảnh.
> **Chuẩn:** ISTQB Foundation Level (test basis → test object → kỹ thuật thiết kế → rủi ro → entry/exit)
> **Test data:** [paywall-remote-config-payloads/](paywall-remote-config-payloads/) — 32 file JSON dán thẳng vào Firebase Console: 30 file cô lập từng biến số theo 4 decision table + case biên ở mục 5, cộng 2 file "realistic full case" (mục 11) dựng từ config mẫu thật do dev cung cấp, xem `README.md` trong đó để biết kỳ vọng từng file
> **Test case:** [test-cases/paywall-remote-config.md](../../test-cases/paywall-remote-config.md) — 75 case ISTQB (ID, tiền điều kiện, test data, bước thực hiện, expected result, priority) suy trực tiếp từ mục 2/5/6 dưới đây, kèm traceability matrix
> **Ngoài phạm vi:** `pro_legal_urls` (link Terms/Privacy) — key RC riêng, cùng hệ thống nhưng chưa nằm trong test plan này. `pro_plan_config` (key cũ) dùng **camelCase**, khác hẳn `pro_paywall_config_v1` dùng **snake_case** — không copy tên field qua lại giữa 2 key.
> **Ngày lập:** 2026-09-14 · **Người lập:** QC · **Cập nhật:** 2026-09-14 (sau khi có `paywall-config.md` + 2 spec cập nhật từ dev)

> ✅ **`yearly` vs `annual` — đã CHỐT, không còn là câu hỏi mở.** `paywall-config.md` mục Failure modes ghi thẳng: *"period is not one of weekly/annual/lifetime — **yearly is not a case** — ... the row is dropped on decode, silently"*. Payload mẫu A4 của `paywall-qc-vi.md` đã tự sửa thành `annual`. TC-PLAN-18 giờ là case xác nhận hành vi đã biết (silently dropped, các hàng khác không đổi), không còn là case "mở câu hỏi".

---

## 1. Test basis

- **`paywall-config.md` là nguồn thẩm quyền cao nhất** — runbook kỹ thuật, tham chiếu thẳng tên symbol Swift thật (`PaywallConfigDecoder.maxBenefits`, `SplashGateView`...), có bảng Failure modes đối chiếu triệu chứng ↔ nguyên nhân ↔ nơi tra log. Mọi mâu thuẫn giữa 2 tài liệu còn lại đều chốt theo file này.
- `paywall-qc-vi.md` Phần B (B1–B9) là checklist thao tác, viết cho người thực thi tay — không có kỹ thuật thiết kế test case tường minh (EP/BVA/decision table). Phần A (nay có thêm A0) là điều kiện tiên quyết vận hành — xem mục 8.
- `paywall-config-builder.html` liệt kê tường minh từng điều kiện validate/fallback (severity `error`/`warn`/`info`) qua hàm `checks()`. Test plan này dùng `checks()` làm nguồn chốt cho mục 5 (kỹ thuật thiết kế) — **đã đối chiếu chéo với `paywall-config.md` và khớp ở mọi điểm kiểm tra được** (envelope, `period` whitelist, benefits cap, discount range, `{trial}` logic), nên rủi ro "tool tự sync tay có thể lệch code thật" (từng ghi ở mục 10.2 bản cũ) **giảm đáng kể cho các rule đã đối chiếu** — không loại bỏ hoàn toàn vì `checks()` vẫn được duy trì thủ công, chỉ là nay có nguồn thứ 2 độc lập xác nhận.
- `08_paywall.md` là bằng chứng ảnh thật (3 screenshot, iPhone) + đối chiếu thêm 1 ảnh iPad (`ipad/index.md` dòng 92) — dùng để xác nhận layout/giá trị mặc định đang chạy trên production **trước khi** có RC nào can thiệp, và để phát hiện lỗi đã tồn tại độc lập với RC (mục 10.4).

## 2. Test object — In scope

| # | Feature | Nguồn | Ghi chú |
|---|---|---|---|
| 1 | Envelope: `schema_version`, `min_app_version`, kill switch `use_bundled_paywall` | qc-vi B6, builder dòng 737–753 | Sai 1 trong 3 → **bỏ nguyên payload**, không áp một nửa (nguyên tắc 2, dòng 32–34 của qc-vi.md) |
| 2 | Copy: `headline`, `subtitle` — resolve theo locale + fallback `en` | qc-vi B2, builder dòng 760–776 | Headline và subtitle có **luật rỗng khác nhau** — xem mục 5, Decision Table 4 |
| 3 | Hero: `animation` (3 tên cố định) / `image_url` (https-only) | qc-vi B4, builder dòng 778–790 | Ảnh hero cập nhật **chậm 1 lần mở app** (cache) — không phải bug nếu QC test ngay sau publish |
| 4 | Benefits: tối đa 5 dòng, icon/tint/title | qc-vi B3, builder dòng 792–811 | Icon sai tên → `sparkles`; tint sai → `brandViolet` — cả 2 đều **giữ dòng**, không bỏ |
| 5 | Plans: show/preselected/badge/discount/title/title_no_trial, thứ tự hiển thị = thứ tự mảng | qc-vi B5, builder dòng 813–854 | Bao gồm cả rơi về key cũ `pro_plan_config` khi không gửi `plans` (dòng 814–815) |
| 6 | ⭐ Fallback toàn hệ thống — payload hỏng/rỗng/kill-switch/offline → paywall mặc định, không bao giờ trống | qc-vi B6 | **Ưu tiên cao nhất theo chính tài liệu** (đánh dấu ⭐ ở qc-vi.md dòng 223) |
| 7 | Trial `{trial}` — luôn lấy từ StoreKit, không từ RC | qc-vi B7, nguyên tắc 1 (dòng 28–31) | Decision Table 3 ở mục 5 |
| 8 | L10n & accessibility: 10 locale RC + `zh-Hant` (locale xem-thử, đọc override từ `zh`) | qc-vi B8, builder dòng 496–503, 1065–1070 | `zh-Hant` là trường hợp đặc biệt không có trong checklist B gốc |
| 9 | Analytics: `pro_paywall_viewed`, user property `paywall_variant` | qc-vi B9 | Mặc định `"bundled"` khi không có `variant` (builder dòng 755–758) |
| 10 | **Giá hiển thị đúng locale/tiền tệ thật của StoreKit** | 08_paywall.md dòng 151–168 | **Không nằm trong checklist B nào cả** — bổ sung mới, xem mục 6 (P1) |
| 11 | A/B experiment: mỗi nhánh 1 `variant` riêng, ≤36 ký tự | qc-vi A5 (dòng 132–142) | |

## 3. Out of scope

- **Thao tác dựng payload trên UI của `paywall-config-builder.html`** (nhập liệu, live preview trong trình duyệt) — đây là *test data authoring tool*, không phải app đang test. Chỉ dùng JSON nó xuất ra (`emit()`) làm input cho Firebase RC thật.
- **Logic StoreKit/App Store Connect** (tạo sản phẩm, cấu hình giá, duyệt app) — QC chỉ verify app đọc đúng những gì StoreKit trả về, không audit cấu hình ASC.
- **`pro_plan_config` (key cũ)** — theo qc-vi.md dòng 60–62, key này đã "đóng băng", chỉ sửa khi cần đổi gói cho bản cũ; test plan này chỉ verify app **rơi đúng vào** key này khi thiếu `plans` (mục 2, item 5), không test nội dung key đó.
- **A/B Testing statistics** (ý nghĩa thống kê, thời gian chạy thử nghiệm) của Firebase — nghiệp vụ marketing, không phải QC.

## 4. Test levels & types

- **Level:** System testing, black-box, trên build TestFlight + Firebase RC project **dev** (qc-vi.md A1, dòng 42–50 — luôn thử dev trước, vì đây là màn ra tiền và là màn đầu tiên user chưa mua nhìn thấy).
- **Functional:** đúng theo 11 mục ở mục 2 — parse/validate/fallback từng field, hiển thị đúng theo locale, đúng theo trạng thái trial thật của tài khoản Apple ID test.
- **Non-functional:**
  - **Usability** — độ dài headline/benefit bị co/xuống dòng (builder dòng 768–769, 807); nút ✕ luôn bấm được dù hero là ảnh custom (B4).
  - **Accessibility** — Reduce Motion (hero đứng yên, không nhấp nháy), Dynamic Type tối đa (B8).
  - **Localization** — 10 locale RC + `zh-Hant`; câu chữ dài (Đức) không tràn; ít nhất 1 ngôn ngữ CJK.
  - **Compatibility** — iPhone SE/13 mini (B5 — gói Lifetime phải thấy không cần cuộn) và iPad (B8 — không kéo giãn hết chiều ngang).
  - **Reliability / Revenue integrity** — mục 2 item 6 (fallback) và item 10 (giá đúng) là 2 hạng mục có thể gây **mất tiền thật hoặc bị App Store reject**, xếp non-functional loại "trustworthiness" cao nhất trong toàn bộ app.
  - **Security/Privacy** — ảnh `08_paywall_02_storekit-sheet_system-dialog.png` đang chứa email tester thật (wireframe dòng 170); khi log bug mới cho mục này, không đính kèm ảnh gốc chưa che.
- **Change-related (regression):** mỗi lần đổi payload RC là một "bản build nội dung" mới — coi mỗi variant publish như một lần thay đổi cần regression lại đủ B1–B9 + case mới (mục 6), không chỉ test riêng field vừa đổi, vì envelope lỗi (mục 2 item 1) làm hỏng **toàn bộ** payload chứ không riêng field đó.

## 5. Kỹ thuật thiết kế test case

- **Equivalence Partitioning:**
  - `schema_version`: {không phải số nguyên · nguyên ≥1 hợp lệ (=1) · nguyên >1 (bị bỏ)}.
  - Trạng thái trial của Apple ID: {chưa từng dùng thử · đang trong kỳ thử · đã hết quyền thử}.
  - Locale máy: {có override RC · không có override (rơi về `en`) · `zh-Hant` (đọc bundled riêng, override từ `zh`)}.
  - Số dòng benefit khai báo: {0 (`benefits:[]`) · 1–5 (hợp lệ) · >5 (bị cắt)}.
  - `plans` tổng thể: {không khai báo (rơi `pro_plan_config`) · khai báo nhưng 0 hàng hợp lệ · khai báo có hàng hợp lệ nhưng tất cả `show:false` · khai báo bình thường}.
- **Boundary Value Analysis:**
  - `schema_version`: test tại 1 (pass) và 2 (bị bỏ toàn bộ payload, builder dòng 744–746).
  - Số benefit: test tại 5 (giữ đủ) và 6 (cắt còn 5, builder dòng 798–800).
  - `discount`: hợp lệ khi *strictly* trong khoảng (0, 1) — builder dòng 843 dùng `<= 0 || >= 1` để cảnh báo. Test tại 0, 0.01, 0.99, 1, và giá trị âm.
  - Độ dài headline: builder cảnh báo tại >30 ký tự (dòng 768–769, khung 32pt tối đa 3 dòng không co theo Dynamic Type) — test tại 29/30/31 ký tự bằng tiếng Việt có dấu (ký tự dài hơn tiếng Anh).
  - `variant`: test tại 36 và 37 ký tự (giới hạn theo qc-vi.md A5 dòng 142).
  - Payload size: builder cảnh báo tại >30 000 bytes (dòng 858) trong khi giới hạn thật của cả template RC là 1 MB (A2 cảnh báo dòng 156) — test 1 payload nhiều locale + nhiều benefit/plan để chạm ngưỡng cảnh báo, ghi rõ đây là ngưỡng *khuyến nghị* của tool, không phải ngưỡng chặn cứng của Firebase.
- **Decision Table 1 — Envelope, quyết định payload có được áp dụng hay bị bỏ toàn bộ (builder dòng 737–753, 867–874):**

  | `use_bundled_paywall` | `schema_version` | `min_app_version` đúng định dạng? | build hiện tại ≥ `min_app_version`? | Kết quả |
  |---|---|---|---|---|
  | true | — | — | — | Bỏ toàn bộ, luôn hiện bundled |
  | false | không nguyên hoặc <1 | — | — | Coi như vắng mặt → schema v1, **vẫn áp payload** |
  | false | >1 (vd 2) | — | — | Bỏ toàn bộ payload |
  | false | 1 (hoặc vắng) | sai regex `^\d+(\.\d+){0,3}$` | — | Bỏ toàn bộ payload |
  | false | 1 | đúng định dạng | build < min | Bỏ toàn bộ payload (build cũ hơn) |
  | false | 1 | đúng định dạng (hoặc để trống) | build ≥ min | **Áp dụng payload bình thường** |

- **Decision Table 2 — Plans, khi nào rơi về bundled toàn bộ vs giữ được 1 phần (builder dòng 814–828):**

  | Có khai `plans`? | Số hàng hợp lệ (đủ `product_id`+`period`+`type`) | Số hàng `show:true` trong đó | Kết quả |
  |---|---|---|---|
  | Không | – | – | Đọc `pro_plan_config` (key cũ), rồi mới tới bundled |
  | Có | 0 | – | `pro_plan_config`, rồi bundled — **lỗi doanh thu**, xem B6 |
  | Có | ≥1 | 0 (tất cả `show:false`) | Phải tự dựng lại bằng danh sách bundled — **case quan trọng nhất của toàn bộ tính năng** |
  | Có | ≥1 | ≥1 | Hiện đúng các hàng `show:true`, thứ tự theo mảng |

- **Decision Table 3 — Tiêu đề gói theo trạng thái trial (qc-vi B7 + builder dòng 848–852, đây là loại lỗi tài liệu tự gọi "Lỗi nặng"):**

  | `title` có `{trial}`? | Có `title_no_trial`? | User còn trial? | Text hiển thị | Rủi ro |
  |---|---|---|---|---|
  | Có | Có | Có | `title` với `{trial}` thay số ngày thật từ StoreKit | Đúng |
  | Có | Có | Không | `title_no_trial` | Đúng |
  | Có | **Không** | Có | `title` với `{trial}` | Đúng |
  | Có | **Không** | Không | **Rơi về tên gói bundled**, không phải tên bạn đặt trong RC | 🔴 Lỗi nặng đã biết — user hết trial thấy tên gói sai với thiết kế |
  | Không | Có, không | — | `title` tĩnh (nếu có) hoặc bundled | Không có `{trial}` thì `title_no_trial` gần như vô nghĩa (info, không phải lỗi) |

- **Decision Table 4 — Rỗng ở từng field xử lý KHÁC nhau, dễ nhầm lẫn nhất trong toàn bộ spec (builder dòng 762–776):**

  | Field | Không khai báo locale này | Khai báo giá trị `""` (rỗng) |
  |---|---|---|
  | `headline` | Fallback `en` | ⚠️ **KHÔNG ẩn được** — vẫn fallback `en`. Rỗng thật sự chỉ xảy ra khi *không* fallback được gì (hiếm) |
  | `subtitle` | Fallback `en` | **Ẩn hẳn dòng subtitle** — đúng thiết kế |
  | `benefits[].title` | (bắt buộc, thiếu → bỏ cả dòng) | Coi như thiếu `title` → bỏ cả dòng |
  | `plans[].subtitle` | Dùng logic tính tự động (per-week/per-month…) | Ẩn dòng phụ, không tính tự động nữa |

  → Test case bắt buộc: set `headline: {"vi": ""}` và kỳ vọng **vẫn thấy chuỗi `en`**, không phải khoảng trắng. Đây là hành vi phản trực giác nhất trong cả spec, rất dễ bị hiểu nhầm là bug khi thấy đúng.

- **State Transition Testing:**
  - CTA mua hàng: `mặc định (chọn sẵn theo preselected) → tap Continue → purchasing (màn mờ, toast "Processing…", CTA→spinner, khoá tương tác) → StoreKit sheet (external) → {Double Click xác nhận → ❓ unlocked (chưa có ảnh, mục 11) | Cancel → quay lại mặc định | lỗi thanh toán → ❓ chưa có ảnh, mục 11}`.
  - Chọn gói: `gói A đang chọn (viền tím) → tap gói B → viền tím chuyển sang B, dòng Auto-renew hiện/ẩn theo type của B` (kiểm tra đúng transition khi đổi qua lại Lifetime ↔ Weekly/Annual, xem wireframe dòng 107).
  - RC publish → app nhận: `Publish changes ở Console → (chưa đổi ngay) → kill app hoàn toàn → mở lại → đã nhận payload mới` (qc-vi A6, dòng 144–153); nếu vẫn cũ → gỡ cài lại.
- **Exploratory testing (session-based, time-boxed):**
  - Đổi ngôn ngữ máy **trong khi đang mở paywall** (background app → Settings đổi ngôn ngữ → foreground lại) — không case nào trong B1–B9 hay `checks()` cover kịch bản này.
  - Bấm liên tục nhiều gói khác nhau thật nhanh trong lúc `purchasing` đang chạy — B6/state transition chỉ test happy path tuần tự.
  - Kết hợp nhiều lỗi cùng lúc trong 1 payload (vd `schema_version:2` **và** `min_app_version` sai định dạng cùng lúc) — `checks()` liệt kê từng lỗi độc lập nhưng chưa rõ hành vi decoder thật khi có ≥2 lý do reject cùng lúc, có bỏ sớm (short-circuit) hay đánh giá hết rồi mới bỏ.

## 6. Risk-based prioritization

> **Mapping severity** theo đúng convention [bugs/bug-log.md](../../bugs/bug-log.md): P1 → Critical/High, P2 → Medium, P3 → Low. Đây là độ ưu tiên **test**, không tự động là severity bug.

**P1 — mất tiền / vi phạm App Store / paywall trống:**
- **🔴 Giá sai đơn vị tiền tệ** (₩ hiện trong app, thật ra tài khoản tính bằng ₫ theo StoreKit) — phát hiện đã có sẵn trong `08_paywall.md` dòng 151–168, **chưa được log vào `bugs/bug-log.md`** (đã kiểm tra, không có entry nào chứa "paywall"/"KRW"/"StoreKit"). Vi phạm Guideline 3.1.2, rủi ro reject App Store. **Đề xuất log bug ngay, severity Critical**, trước khi bắt đầu execute mục này — xem mục 10.4.
- B6 Fallback toàn hệ thống (Decision Table 1 & 2) — đúng như qc-vi.md tự đánh dấu ⭐, đây là "chốt chặn cuối" chống paywall trống.
- Decision Table 3, dòng 4 — user hết trial thấy nhầm tên gói bundled thay vì tên đã thiết kế trong RC (đã được tài liệu tự gọi "Lỗi nặng").
- **Sai lệch `yearly` vs `annual`** giữa payload mẫu A4 và whitelist thật trong `checks()` (xem cảnh báo đầu file, mục 10.1) — nếu không xác nhận trước, mọi test case dùng nguyên payload A4 cho kết quả sai lệch, dễ kết luận nhầm "gói năm bị lỗi" trong khi thực ra chỉ là payload mẫu sai.
- `variant` trùng giữa 2 nhánh A/B → hỏng khả năng đọc kết quả thử nghiệm, không tự phát hiện được bằng mắt (qc-vi A5, dòng 137–139).

**P2:**
- Benefits >5 dòng bị cắt, icon/tint sai tên rơi về mặc định nhưng vẫn giữ dòng (builder dòng 798–800, 809).
- `product_id` trùng giữa 2 gói, hoặc dùng id ngoài 3 id đang bán → StoreKit trả rỗng, hàng biến mất (builder dòng 835–838).
- `period`/`type` lệch nhau (vd `period:"lifetime"` nhưng `type:"subscription"`) → CTA và dòng auto-renew hiển thị sai (builder dòng 840–841).
- Dòng `Auto-renew. Cancel anytime.` hiển thị có điều kiện theo loại gói — wireframe tự đánh dấu cần xác nhận có phải chủ ý (dòng 107, 201).
- `zh-Hant`: đọc chuỗi bundled riêng nhưng override lấy từ map `zh` — hành vi dễ gây hiểu nhầm khi QC không biết rule này trước (builder dòng 501–503).
- Hero ảnh custom trên mạng chậm — phải hiện ảnh mặc định trước, không được để trống trắng (B4).
- L10n đủ 10 locale cho toàn bộ field text, đặc biệt ngôn ngữ dài (Đức) không tràn (B8).

**P3:**
- Payload gần ngưỡng cảnh báo kích thước (30 000 bytes) — chỉ là cảnh báo mềm của tool, không chặn cứng ở Firebase.
- Badge/label cosmetic (`best_value`/`popular` đúng chữ, đúng vị trí).
- Thời điểm ảnh hero mới cập nhật tới máy user chậm 1 lần mở app — hành vi đã biết, đã có ghi chú trong cả 2 tài liệu, không phải bug nếu QC không kill app trước.

## 7. Test environment matrix

- **Firebase project (2 project tách rời, KHÔNG dùng chung template — set ở dev xong vẫn phải set lại bằng tay ở prod, `paywall-qc-vi.md` A1):**

  | Môi trường | Project ID | `minimumFetchInterval` | Ghi chú |
  |---|---|---|---|
  | Dev | `workout-ai-1bdb1` | `0` | Đổi là thấy ngay, kill app + mở lại là đủ |
  | Prod | `lockscreencalendar-4477e` | `3600` (1 tiếng) | **Chỉ COLD launch sau khi hết cửa sổ 1 tiếng mới fetch lại.** Kill + mở lại trong vòng 1 tiếng **không** lấy được giá trị mới. Cách chắc chắn duy nhất khi QC trên prod: **gỡ app rồi cài lại.** |

  `dev` bắt buộc trước — chỉ chuyển `prod` sau khi mục 6 (P1) đã pass hết trên dev.
- **Apple ID test cần chuẩn bị trước (qc-vi "Chuẩn bị"):**
  - 1 tài khoản **chưa từng mua gói nào**.
  - 1 tài khoản **đã hết hạn dùng thử** (test Decision Table 3, dòng 4).
  - 1 tài khoản App Store khu vực **Việt Nam** (tính bằng ₫) để test mục 6 (P1, lỗi giá) — đối chiếu đúng bằng sheet StoreKit thật (`Get Info` hoặc sheet mua hàng), không so bằng mắt với số trong app.
- **Device:** iPhone SE/13 mini (B5 — gói cuối không cần cuộn) + ít nhất 1 iPhone thường; iPad (B8 — không kéo giãn hết ngang).
- **Ngôn ngữ máy:** tối thiểu vi + en; đủ vòng qua 10 locale RC (`en,vi,es,id,ja,ko,ms,pt,th,zh`) + `zh-Hant` cho 1 lượt đầy đủ theo mục 5.
- **Accessibility settings:** Reduce Motion bật, Dynamic Type mức lớn nhất (B8).
- **Mạng:** bình thường + chế độ máy bay (test nhánh offline của B6). **Không cần** giả lập mạng chậm cho hero ảnh — cơ chế cache của `hero.image_url` không phụ thuộc tốc độ mạng, xem TC-HERO-07 đã thiết kế lại.
- **Payload test cần chuẩn bị trước publish:** đã có sẵn đủ trong [payloads/](paywall-remote-config-payloads/), không cần dựng tay — xem README trong đó.

## 8. Entry criteria

- **Build đang test có mang commit `c711ceb4` trở lên** — verify bằng `git merge-base --is-ancestor c711ceb4 <ref> && echo "có đọc" || echo "KHÔNG đọc"` (`paywall-qc-vi.md` A0). Build cũ hơn set RC **vô hại nhưng vô tác dụng**, và trên màn hình **không phân biệt được** với case envelope-reject — chỉ phân biệt qua Console log category `paywall-config`. Bỏ qua bước này = có thể chạy hết cả 75 case mà không phát hiện ra build không hề đọc key.
- Đã có quyền truy cập Firebase Console cả 2 project (`workout-ai-1bdb1` dev, `lockscreencalendar-4477e` prod), parameter `pro_paywall_config_v1` đã tồn tại ở cả 2.
- **Custom dimension `paywall_variant` (scope User) đã đăng ký trong GA4** cho **cả 2 project** trước khi execute Suite Analytics (I) — đăng ký sau khi đã publish variant thì dữ liệu trước đó **không hồi tố**, coi như mất, không sửa lại được.
- **Đã kiểm tra `Pro.storekit` (local) và App Store Connect có introductory offer thật** cho gói weekly/annual trước khi execute Suite Trial title (G) — nếu chưa có, mọi case `{trial}` sẽ luôn rơi vào nhánh `title_no_trial`/bundled kể cả trên tài khoản đủ điều kiện, **không phải bug**, chỉ là chưa đủ điều kiện test.
- Đã chuẩn bị đủ 3 Apple ID test ở mục 7, gồm tài khoản khu vực Việt Nam.
- Đã log bug Critical cho lỗi giá KRW/VND (mục 6, mục 10.4) **trước khi** bắt đầu execute mục 2 item 10 — tránh vừa test vừa phát hiện lại 1 bug đã biết mà tưởng là mới.

## 8.1 Suspension & Resumption criteria

- **Suspend toàn bộ:** nếu Decision Table 2, dòng "tất cả `show:false`" **không** rơi về bundled mà hiện paywall trống thật → dừng ngay toàn bộ execute còn lại của test plan này. Đây là lỗi doanh thu nghiêm trọng nhất có thể có (không ai mua được gì), tiếp tục test các mục khác không có ý nghĩa cho tới khi có bản vá.
- **Suspend cục bộ — nhánh giá:** nếu xác nhận lỗi KRW/VND (mục 6) ảnh hưởng **cả 3 gói** chứ không riêng Weekly (wireframe mới xác nhận 1 gói) → dừng riêng nhánh mục 2 item 10, báo ngay severity Critical, không cần dừng các nhánh RC khác vì độc lập với engine hiển thị giá.
- **Resume:** sau khi có build/config fix, chạy lại từ đầu case đã suspend, không tiếp tục giữa chừng — theo đúng pattern đã áp dụng ở [1.2.15-decoration-inkai.md §8.1](1.2.15-decoration-inkai.md#81-suspension--resumption-criteria).

## 9. Exit criteria

> **Bản đầy đủ, định lượng theo từng mức ưu tiên (25 P1 · 2 P1-chức-năng · 36 P2 · 10 P3 / 73 case) nằm ở [test-cases/paywall-remote-config.md § Exit Criteria](../../test-cases/paywall-remote-config.md#exit-criteria-theo-istqb-foundation--gắn-với-bảng-phân-bổ-trên)** — mục dưới đây chỉ tóm tắt 5 điều kiện chốt để sign-off, không lặp lại toàn bộ bảng phân bổ.

- **Coverage theo tầng ưu tiên** (không dùng 1 ngưỡng % chung): P1 100% pass · P1-chức-năng 100% pass theo tiêu chí hành vi (chưa cần khớp UI) · P2 ≥90% pass (≤3 case fail còn lại phải có waiver) · P3 ≥70% đã thực thi.
- **0 bug Critical/High đang mở** — đặc biệt B6/Decision Table 1–2 (fallback), Decision Table 3 dòng "Lỗi nặng" (title `{trial}` thiếu `title_no_trial`), và lỗi giá KRW/VND (Suite K) phải verify **hết hẳn nguyên nhân gốc**, không chỉ hết hiện tượng nhìn thấy trên 1 tài khoản test.
- **Residual risk đã liệt kê bằng văn bản khi sign-off**, không coi là "đã xong": 2 case Blocked thiếu baseline ảnh (TC-FLOW-03/06 — TC-FLOW-05 đã verify chức năng thật trên device 2026-09-15, đóng bớt 1/3), và mọi câu hỏi ở mục 10 chưa trả lời — đặc biệt 10.1 (yearly vs annual, chặn TC-PLAN-18) và 10.2 (builder tool có khớp decoder thật không, chặn độ tin cậy toàn bộ mục 5).
- Analytics đã verify cả `pro_paywall_viewed` lẫn user property `paywall_variant`, kể cả case không có RC (phải ra đúng `"bundled"`), và case trùng `variant` giữa 2 nhánh A/B (TC-ANA-04) đã xác nhận đúng hệ quả gây hỏng funnel.
- Deadline không phải lý do hợp lệ để bỏ qua P1 — nếu hết hạn mà còn P1 fail, exit criteria **chưa đạt**; chỉ được cắt phạm vi từ P3 trước, không bao giờ cắt P1.
- Không còn ảnh nào trong bộ screenshot chứa dữ liệu cá nhân thật (email tester ở `08_paywall_02_storekit-sheet_system-dialog.png`) khi tài liệu này được chia sẻ ra ngoài team.

## 10. Gap cần làm rõ trước khi execute

> **Bản gộp sẵn để gửi dev 1 lần:** [paywall-remote-config-questions-for-dev.md](paywall-remote-config-questions-for-dev.md) — 4 câu hỏi còn mở (mục 6, 8, 9, 11 dưới đây), có ô điền câu trả lời, đồng bộ ngược lại đây khi có phản hồi.
> **Cập nhật 2026-09-14 sau khi có `paywall-config.md` + 2 spec cập nhật từ dev** — 4 mục đã đóng (✅), giữ lại nguyên văn để thấy lịch sử suy luận, không xoá.

1. ~~**`yearly` vs `annual`**~~ — ✅ **Đã CHỐT hoàn toàn, có bằng chứng thiết bị thật (2026-09-15).** `paywall-config.md` (Failure modes): *"period is not one of weekly/annual/lifetime — yearly is not a case — the row is dropped on decode, silently"*. `paywall-qc-vi.md` A4 đã tự sửa. **TC-PLAN-18 đã chạy thật:** publish payload có gói `yearly` → gói đó biến mất âm thầm, 2 gói còn lại (weekly, lifetime) hiện bình thường ([ảnh bằng chứng](paywall-remote-config-payloads/screenshots/08-open-questions/01-yearly-vs-annual.png)) — khớp 100% với tài liệu. Không còn là câu hỏi mở dưới bất kỳ hình thức nào.
2. ~~**`paywall-config-builder.html` có khớp decoder thật không?**~~ — ✅ **Giảm rủi ro đáng kể, chưa đóng hẳn.** Đối chiếu `checks()` với `paywall-config.md` khớp ở mọi rule kiểm tra được (envelope, `period` whitelist, benefits cap 5, discount 0…1, `{trial}` logic, `show` mặc định `true`). Rủi ro còn lại: `checks()` vẫn cần sync tay cho các thay đổi tương lai, không có cơ chế tự động phát hiện lệch — xem mục 10.6 (chưa đóng) cho 1 ví dụ cụ thể tool vẫn còn sai.
3. ~~**`paywall-config.md` không tồn tại**~~ — ✅ **Đã có, 2026-09-14.** Nguồn thẩm quyền cao nhất từ giờ, xem mục 1.
4. **Lỗi giá KRW/VND đã có trong wireframe từ trước nhưng chưa từng được log vào `bugs/bug-log.md`.** Vẫn **chưa đóng** — cần log ngay (mục 6, mục 8) trước khi execute mục 2 item 10.
5. ~~**Dòng `Auto-renew...` hiển thị có điều kiện theo loại gói — có chủ ý không?**~~ — ✅ **Đã CHỐT.** `paywall-config.md` mục "What is deliberately NOT configurable": *"The auto-renew disclosure and the Terms/Privacy row [...] Store requirements, not experiment surface."* — xác nhận đây là logic cứng trong app theo `type` của gói đang chọn, không phải RC, không phải lỗi ẩn/hiện ngẫu nhiên.
6. **Bản seed "Variant B" trong `paywall-config-builder.html` (`seed()`) thiếu key `hero` khi xuất qua `emit()`** dù đặt `heroMode: "animation"` nội bộ — **vẫn CHƯA đóng**, 2 spec mới không nhắc tới điểm này. Đây chính là ví dụ cụ thể cho thấy tool vẫn còn drift dù đã đối chiếu khớp phần lớn (mục 10.2). TC-HERO-09/10 verify hành vi thật, không thay thế câu trả lời từ dev.
7. **5 màn hình chưa có ảnh** (wireframe dòng 204–209) — vẫn chưa đóng, 2 spec mới không phải nguồn ảnh UI.
8. **Payload nhiều lỗi envelope cùng lúc** — vẫn chưa đóng; `paywall-config.md` mô tả 3 field envelope độc lập nhưng không nói rõ thứ tự ưu tiên khi ≥2 field cùng sai (chỉ `use_bundled_paywall` được xác nhận có ưu tiên tuyệt đối qua `envelopeRejected()`, còn `schema_version` vs `min_app_version` khi cùng sai thì chưa rõ).
9. **NEW — GA4 custom dimension `paywall_variant` đã thực sự được đăng ký cho cả 2 project chưa?** `paywall-config.md`/`paywall-qc-vi.md` mới chỉ nói **cần** đăng ký, không xác nhận **đã** đăng ký. Đây là entry criteria (mục 8) — cần verify trạng thái thật trong GA4 Console trước khi execute Suite Analytics (I), không giả định đã có.
10. **`Pro.storekit` cục bộ vs ASC — giả thuyết ban đầu đã bị BÁC BỎ, chuyển hướng điều tra 2026-09-15.** Chạy TC-TRIAL-01 thật (tài khoản mới, chưa mua lần nào) → gói Weekly hiện `"Weekly plan"` (`title_no_trial`) thay vì `"Get {trial} free"` (ảnh [`screenshots/03-trial-title/01-trial-with-fallback.png`](paywall-remote-config-payloads/screenshots/03-trial-title/01-trial-with-fallback.png)). Ban đầu nghi do ASC thiếu offer — **đã kiểm tra trực tiếp ASC (App Store Connect → Subscription Pricing → Introductory Offers): có offer thật, "Free for the first 3 days", hiệu lực từ 26/6/2026, 175 quốc gia.** Vậy nguyên nhân không nằm ở ASC.
   ~~**Giả thuyết local StoreKit Configuration File**~~ — **cũng đã bị loại 2026-09-15.** QC xác nhận đang test ở Firebase project `dev` + **Sandbox thật** (không phải file `.storekit` cục bộ), tức app đáng lẽ phải đọc đúng entitlement từ ASC.
   **Hiện trạng: cả 2 giả thuyết ban đầu đều đã loại, nguyên nhân thật vẫn CHƯA XÁC ĐỊNH.** 3 hướng còn lại cần loại trừ trước khi coi đây là bug thật (chưa có hướng nào được xác nhận là đúng, chỉ là thứ tự nên thử):
   1. **Sandbox Tester account đã "dính" lịch sử trial trước đó** trong cùng subscription group (kể cả giao dịch cũ đã huỷ giữa chừng từ các lần test khác) — Apple Sandbox không phải lúc nào cũng tự reset đúng eligibility. Thử lại bằng 1 Sandbox Tester **tạo mới hoàn toàn trong ASC**, chưa từng chạm giao dịch nào — không chỉ dựa vào "acc chưa mua" theo trí nhớ.
   2. **Độ trễ lan truyền của offer** — ASC hiển thị "live" nhưng Sandbox có thể cần thời gian, hoặc cần sign out/sign in lại tài khoản Sandbox trên máy test để app fetch lại đúng entitlement.
   3. **Sai lệch `product_id`** — xác nhận `com.silverai.calendar.lockscreen.pro.weekly` khớp chính xác với sản phẩm "Weekly - $1.99 - Trial 3" đang có offer trong ASC, không phải 1 SKU trùng tên khác.
   **Kế hoạch verify tiếp theo (QC, 2026-09-15):** giữ case **Open/Blocked**, sẽ verify lại trên **prod**. Lưu ý khi verify: "prod" ở đây là Firebase RC project (`lockscreencalendar-4477e`) — đổi project này **không** ảnh hưởng StoreKit/trial eligibility (trial luôn lấy thẳng từ StoreKit, độc lập với RC project). Nếu vẫn dùng lại cùng 1 Sandbox Tester đã test trước đó, nghi vấn #1 (account dính lịch sử trial cũ) vẫn chưa được loại trừ — nên dùng **Sandbox Tester tạo mới hoàn toàn** khi verify lại, tách bạch khỏi biến số Firebase project. Nếu verify thật qua TestFlight (đổi cả StoreKit environment) thì có ý nghĩa hơn để loại nghi vấn Sandbox. TC-TRIAL-01/05/06 giữ nguyên **Blocked** (không phải Fail) cho tới khi có kết quả verify mới.
11. **NEW — `min_app_version` sai định dạng KHÔNG bị bỏ payload như dự đoán, phát hiện 2026-09-15.** TC-ENV-04 test `min_app_version: "1.9.0-beta1"` (dự đoán sai định dạng theo regex `^\d+(\.\d+){0,3}$` trong `paywall-config-builder.html` → phải bỏ toàn bộ payload) — **thực tế headline vẫn đổi theo payload** ([ảnh bằng chứng](paywall-remote-config-payloads/screenshots/01-envelope/04-min-app-version-bad-format.png)), tức payload được áp dụng bình thường.
    **Điểm mấu chốt:** `paywall-config.md` (nguồn chính thức) **không hề nêu quy tắc định dạng** cho `min_app_version` — chỉ ghi "below it ⇒ ignored wholesale; omit if unsure", không nói gì về validate format. Quy tắc regex chỉ tồn tại trong `checks()` của tool JS không chính thức. Vậy khả năng cao: **"expected result" ban đầu của TC-ENV-04 tự nó sai** (dựa trên 1 rule tool JS tự nghĩ ra, không có trong decoder thật), không phải app có bug.
    **Giả thuyết về decoder thật:** có thể chỉ parse phần số đầu ("1.9.0") và bỏ qua hậu tố không phải số ("-beta1"), không coi cả chuỗi là "sai định dạng".
    **Cần làm trước khi kết luận:** (1) hỏi dev quy tắc parse `min_app_version` thật — có validate format không, hay chỉ cố parse best-effort; (2) thử thêm 1-2 định dạng sai rõ ràng hơn (vd `"abc"`, chuỗi không có số nào) để xem có ngưỡng nào thực sự bị từ chối không, hay `min_app_version` sai định dạng **luôn luôn** được app bỏ qua an toàn (coi như không có field này). TC-ENV-04 giữ trạng thái "không khớp kỳ vọng, chưa kết luận" — không tự ý sửa expected result khi chưa có xác nhận từ dev.
12. **NEW — `discount = 1` vẫn hiện pill "Save 100%", khác dự đoán, phát hiện 2026-09-15.** TC-PLAN-12 test `discount: 1` (dự đoán theo `previewModel()` của builder tool: `r.discount = (d>0 && d<1) ? d : null` → d=1 cho `null`, nghĩa là **không** pill, **không** gạch giá) — **thực tế: pill "SAVE 100%" vẫn hiện** ([ảnh bằng chứng](paywall-remote-config-payloads/screenshots/10-discount-boundary/04-discount-1-invalid.png)), chỉ riêng giá gạch ngang không hiện (chia cho 0, không tính được).
    **Khác biệt với phát hiện #11:** ở đây app **không** áp dụng đúng khoảng `(0,1)` hở như builder tool giả định cho phần hiển thị pill — có vẻ điều kiện hiển thị pill chỉ cần `discount > 0` (không cần `< 1`), còn điều kiện tính giá gạch ngang mới thực sự cần `< 1` (để tránh chia cho 0). Tức 2 UI element (pill và giá gạch ngang) có thể đang dùng 2 điều kiện validate khác nhau trong code thật, không dùng chung 1 điều kiện `(0,1)` như builder tool mô tả gộp chung.
    **Mức độ ảnh hưởng:** thấp — "Save 100%" về mặt số học vẫn đúng (giảm giá 100% = miễn phí), không sai thông tin cho user, chỉ là khác spec đã viết. Không cần log bug khẩn, nhưng nên hỏi dev để xác nhận điều kiện hiển thị pill thật là gì (`> 0` hay `(0,1)`) — gộp vào lần hỏi tiếp theo nếu có.

## 11. Coverage gap — case chưa được checklist B nào liệt kê

| Thiếu | Vì sao là gap |
|---|---|
| Giá hiển thị đúng currency/locale thật của StoreKit | Không có mục B nào test giá — trong khi đây là lỗi 🔴 đã biết tồn tại (mục 6) |
| Đổi ngôn ngữ máy **trong khi** đang mở paywall (background/foreground) | B8 chỉ test bằng cách đổi ngôn ngữ trước khi mở màn, không test đổi giữa chừng |
| Tương tác dồn dập nhiều gói trong lúc `purchasing` đang chạy | B6/state transition chỉ test tuần tự, không test spam tap |
| `product_id` trùng giữa 2 hàng trong `plans` | `checks()` có cảnh báo (dòng 835) nhưng B5 không có case tương ứng |
| `period`/`type` lệch nhau | Cùng tình trạng — có trong `checks()` (dòng 840–841), không có trong B5 |
| Trường hợp chỉ có `title_no_trial`, không có `title` | `checks()` dòng 851–852 ghi info, B7 không đề cập |
| Rỗng ở `headline` khác rỗng ở `subtitle`/`benefits[].title` (Decision Table 4) | Không mục B nào phân biệt 2 hành vi khác nhau này — rất dễ QC tự suy luận sai theo trực giác |
| Nhiều lỗi envelope cùng lúc trong 1 payload | Xem mục 10.8 |
| Accessibility VoiceOver cho toàn bộ paywall (đọc tên gói, giá, badge) | B8 chỉ có Reduce Motion + Dynamic Type, không có VoiceOver |
| Kill switch bật cho 1 nhánh A/B nhưng tắt ở nhánh kia | Không case nào test tương tác giữa envelope và A/B experiment cùng lúc |
| `pro_legal_urls` (link Terms/Privacy) | Key RC riêng, cùng hệ thống nhưng nằm ngoài phạm vi test plan này (xem header) — nếu cần test, phải mở 1 test plan riêng, không âm thầm gộp vào đây |
| `paywall_variant` có refresh đúng mỗi lần app mở lại không, hay giữ giá trị cũ từ lần cài trước | `paywall-config.md` mục Analytics tự cảnh báo: *"an install left on a finished experiment's label would poison every later cut"* — property ghi lại ở mỗi lần mở từ `SplashGateView`, nhưng chưa có case nào chủ động verify việc ghi đè này xảy ra đúng, chỉ verify giá trị tại 1 thời điểm |
| Hành vi khi build vừa qua commit `c711ceb4` (biên chuyển từ "không đọc" sang "đọc") | Chỉ có xác nhận 2 trạng thái {trước, sau} qua git, chưa có case build đúng tại thời điểm chuyển — rủi ro thấp vì đây là biên theo commit, không theo input runtime, nhưng ghi nhận để không bỏ sót |
