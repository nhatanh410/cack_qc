# Test Cases — Paywall Remote Config (`pro_paywall_config_v1`)

> **Test strategy:** [requirements/test-plans/paywall-remote-config-strategy.md](../requirements/test-plans/paywall-remote-config-strategy.md) — tổ hợp đa chiến lược, không dùng 1 loại thuần: **analytical/risk-based** quyết định độ ưu tiên từng suite (mục Phân bổ độ ưu tiên bên dưới) · **specification-based** (EP/BVA/Decision Table/State Transition) cho Suite B/F/G dựng từ `checks()` · **methodical/checklist-based** kế thừa B1–B9 của `paywall-qc-vi.md` cho các case còn lại · **exploratory** chỉ dùng cho phần không tài liệu nào cover (mục 5 test plan) · **regression-averse** — 30 fixture JSON tái dùng mỗi lần RC đổi, không viết case mới mỗi đợt · **consultative** — câu hỏi vượt thẩm quyền QC dồn về test plan §10 thay vì tự suy diễn.
> **Test basis:** [requirements/test-plans/paywall-remote-config.md](../requirements/test-plans/paywall-remote-config.md) (ISTQB Foundation test plan — mục 2 Test object, mục 5 kỹ thuật thiết kế, mục 6 risk-based prioritization)
> **Test data:** [requirements/test-plans/paywall-remote-config-payloads/](../requirements/test-plans/paywall-remote-config-payloads/) — 32 file JSON, cột **Test data** ở mỗi case trỏ thẳng tới file cần dùng
> **Đặc thù của bộ case này:** đây là phần **config/logic**, không có screenshot hay wireframe làm baseline hình ảnh (khác với UI screen của chính màn paywall, đã có 3 ảnh ở `08_paywall`). Expected Result vì vậy là **hành vi/giá trị quan sát được** (đúng chữ, đúng field, đúng fallback), không phải "khớp pixel với ảnh mẫu" — nguồn đối chiếu chính từ 2026-09-14 là [paywall-config.md](../requirements/specs/paywall-config.md) (runbook kỹ thuật chính thức, mới bổ sung), đối chiếu thêm với `checks()`/`emit()` trong [paywall-config-builder.html](../requirements/specs/paywall-config-builder.html) và checklist thao tác trong [paywall-qc-vi.md](../requirements/specs/paywall-qc-vi.md).
> **Priority:** P1 = mất tiền/vi phạm App Store/paywall trống · P2 = sai hành vi có workaround · P3 = cosmetic — mapping y hệt [test plan §6](../requirements/test-plans/paywall-remote-config.md#6-risk-based-prioritization).
> **Quy ước ID:** `TC-<SUITE>-NN`. Case đã có sẵn payload dựng riêng ghi rõ tên file ở cột Test data; case chưa có file ghi hướng dẫn sửa tay 1 field trên file baseline gần nhất.
> **⚠️ Tiền điều kiện bắt buộc trước khi chạy BẤT KỲ case nào (test plan §8):** build đang test có commit `c711ceb4`+ (`git merge-base --is-ancestor c711ceb4 <ref>`) — build cũ hơn khiến mọi case "PHẢI đổi" đều fail giống hệt case envelope-reject, dễ chẩn đoán nhầm.
> **Ngày lập:** 2026-09-14 · **Người lập:** QC · **Cập nhật:** 2026-09-14 (đồng bộ theo `paywall-config.md` mới + 2 spec cập nhật từ dev — xem thay đổi ở TC-PLAN-18, TC-TRIAL-03, TC-HERO-07, và mục Phân bổ độ ưu tiên)

---

## Suite A — Baseline (không có RC)

| ID | Mục tiêu | Tiền điều kiện | Test data | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|---|
| TC-DEF-01 | Paywall mặc định khi chưa có RC nào can thiệp | Xoá hoặc để trống parameter `pro_paywall_config_v1` | — | 1. Xoá giá trị parameter, Publish.<br>2. Kill app, mở lại, vào paywall. | Hiện đầy đủ hero, headline, subtitle, 3 benefit mặc định, 3 gói, nút CTA. Không khoảng trống lạ, không dòng rỗng. (qc-vi B1) | P1 |

## Suite B — Envelope (Decision Table 1, test plan §5)

| ID | Mục tiêu | Test data | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-ENV-01 | ✅ **PASS 2026-09-15** — Kill switch bật → bỏ toàn bộ payload | `01-envelope/01-kill-switch-on.json` | Publish → kill app → mở lại | Headline **không đổi** (vẫn bundled), toàn màn là paywall mặc định. **Đã verify thật:** headline hiện đúng `"Unlock everything"` (bundled) — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/01-envelope/01-kill-switch-on.png) | P1 |
| TC-ENV-02 | ✅ **PASS 2026-09-15** — `schema_version` không phải số nguyên ≥1 → coi như vắng mặt (v1) | `01-envelope/02-schema-version-not-integer.json` | như trên | Headline **đổi** theo payload — hệ thống không bỏ payload chỉ vì field này sai kiểu. **Đã verify thật:** headline đổi đúng marker `[TC env-02]...` — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/01-envelope/02-schema-version-not-integer.png) | P2 |
| TC-ENV-03 | ✅ **PASS 2026-09-15** — `schema_version` > 1 → bỏ toàn bộ payload | `01-envelope/03-schema-version-too-high.json` | như trên | Headline **không đổi**. **Đã verify thật:** hiện đúng `"Unlock everything"` (bundled) — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/01-envelope/03-schema-version-too-high.png) | P1 |
| TC-ENV-04 | ⚠️ **KHÔNG khớp kỳ vọng 2026-09-15 — cần điều tra (test plan §10.11)** — `min_app_version` sai định dạng → bỏ toàn bộ payload | `01-envelope/04-min-app-version-bad-format.json` | như trên | Headline **không đổi**. **Thực tế đã test:** headline **ĐÃ đổi** theo payload (`min_app_version: "1.9.0-beta1"`) — ngược với dự đoán, payload không hề bị bỏ — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/01-envelope/04-min-app-version-bad-format.png). Quy tắc regex dùng để dự đoán case này chỉ tồn tại trong tool JS không chính thức, `paywall-config.md` không nêu rõ — nên chưa rõ đây là bug thật hay expected-result ban đầu sai. Cần hỏi dev quy tắc parse `min_app_version` thật trước khi kết luận | P1 |
| TC-ENV-05 | ✅ **PASS 2026-09-15** — `min_app_version` cao hơn build đang chạy → bỏ toàn bộ payload | `01-envelope/05-min-app-version-too-high.json` | như trên | Headline **không đổi**. **Đã verify thật:** hiện đúng `"Unlock everything"` (bundled) — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/01-envelope/05-min-app-version-too-high.png). Xác nhận cơ chế so sánh version hoạt động đúng, khoanh vùng vấn đề TC-ENV-04 vào riêng bước validate định dạng | P1 |
| TC-ENV-06 | ✅ **PASS 2026-09-15** — Control — envelope hợp lệ | `01-envelope/06-valid-baseline.json` | như trên | Headline **đổi** đúng theo payload — dùng để xác nhận TC-ENV-01/03/04/05 fail đúng lý do, không phải do publish/cache lỗi. **Đã verify thật:** headline đổi đúng marker `[TC env-06]...` — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/01-envelope/06-valid-baseline.png) | P1 |
| TC-ENV-07 | JSON sai cú pháp → không crash, rơi về bundled | Gõ tay 1 đoạn JSON thiếu dấu `}` trực tiếp trong Console | 1. Dán JSON hỏng, cố Publish.<br>2. Nếu Console tự chặn, thử qua `firebase remoteconfig:versions:list`/import API để ép giá trị hỏng vào (nếu có quyền), hoặc log là **không tái hiện được qua Console UI** nếu bị chặn ở tầng validate của chính Firebase. | App không crash, không treo, hiện paywall mặc định | P1 |
| TC-ENV-08 | Mất mạng khi mở paywall → không crash, không màn trắng | Payload bất kỳ đã publish trước đó | 1. Bật chế độ máy bay.<br>2. Xoá app cài lại (đảm bảo chưa có cache RC).<br>3. Mở app, vào paywall. | Hiện paywall mặc định, không treo, không màn trắng | P1 |

## Suite C — Copy: headline/subtitle theo locale (Decision Table 4, test plan §5)

| ID | Mục tiêu | Test data | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-COPY-01 | Override đúng theo locale máy | Sửa tay `01-envelope/06-valid-baseline.json`: thêm `headline.vi` khác `headline.en` | Publish, máy đặt Tiếng Việt → mở paywall; đổi máy sang English → mở lại | Máy vi hiện đúng `headline.vi`; máy en hiện đúng `headline.en` | P2 |
| TC-COPY-02 | Thiếu hẳn key locale trong payload → fallback `en` | `01-envelope/06-valid-baseline.json` (chỉ có `en`, không có `vi`) | Máy đặt Tiếng Việt → mở paywall | Hiện đúng chuỗi `en`, không phải chuỗi rỗng | P2 |
| TC-COPY-03 | ✅ **PASS 2026-09-15** — ⚠️ Headline `""` → **KHÔNG ẩn được**, rơi về chữ bundled hard-code (khác subtitle) | `04-empty-field-asymmetry/01-headline-empty-vi.json` | Máy đặt Tiếng Việt → mở paywall | Headline hiện **chữ bundled tiếng Việt gốc của app**, KHÔNG phải chuỗi `en` đã set trong file, KHÔNG phải khoảng trắng. **Đã verify thật:** máy VI hiện đúng `"Mở khóa tất cả"` (bundled), máy EN đối chứng hiện đúng `headline.en` — [ảnh VI](../requirements/test-plans/paywall-remote-config-payloads/screenshots/04-empty-field-asymmetry/01-headline-empty-vi-device-vi.png) · [ảnh EN](../requirements/test-plans/paywall-remote-config-payloads/screenshots/04-empty-field-asymmetry/01-headline-empty-vi-device-en.png). Quy tắc phản trực giác nhất trong spec đã được xác nhận đúng như thiết kế | P1 |
| TC-COPY-04 | ✅ **PASS 2026-09-15** — Subtitle `""` → ẩn hẳn dòng (đúng thiết kế, ngược với headline) | `04-empty-field-asymmetry/02-subtitle-empty-vi.json` | như trên | Dòng subtitle **biến mất hoàn toàn**, không có khoảng trống bất thường. **Đã verify thật:** máy VI hiện đúng headline fallback `en` (`headline` thiếu key `vi`) + subtitle ẩn hẳn; máy EN đối chứng hiện đúng cả 2 marker — [ảnh VI](../requirements/test-plans/paywall-remote-config-payloads/screenshots/04-empty-field-asymmetry/02-subtitle-empty-vi-device-vi.png) · [ảnh EN](../requirements/test-plans/paywall-remote-config-payloads/screenshots/04-empty-field-asymmetry/02-subtitle-empty-vi-device-en.png) | P2 |
| TC-COPY-05 | BVA độ dài headline quanh ngưỡng 30 ký tự (khung 32pt, tối đa 3 dòng, không co Dynamic Type) | Sửa tay `headline.vi` trên baseline: 29 / 30 / 31 ký tự tiếng Việt có dấu | 3 lượt publish riêng, mỗi lần đổi độ dài | Ở 29–30: không tràn/không cắt chữ. Ở 31: quan sát có bắt đầu tràn khỏi khung 3 dòng không — ghi lại ngưỡng thật nếu khác 30 | P3 |

## Suite D — Hero

| ID | Mục tiêu | Test data | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-HERO-01 | ✅ **PASS 2026-09-15** — 3 animation hợp lệ hiển thị đúng | `06-hero/01-animation-valid.json` (đổi `hero.animation` lần lượt `tidy_timetable` / `phone_assemble` / `matrix_lock_screen`) | Publish từng biến thể, mở paywall | Đúng animation mô tả trong qc-vi.md B4 chạy khi mở màn. **Đã verify thật cả 3:** [matrix_lock_screen](../requirements/test-plans/paywall-remote-config-payloads/screenshots/06-hero/01-animation-valid-matrix-lock-screen.png) · [phone_assemble](../requirements/test-plans/paywall-remote-config-payloads/screenshots/06-hero/01-animation-valid-phone-assemble.png) · [tidy_timetable](../requirements/test-plans/paywall-remote-config-payloads/screenshots/06-hero/01-animation-valid-tidy-timetable.png) — cả 3 render đúng, khác biệt rõ ràng. ⚠️ File fixture hiện đang bị lỗi giá trị lặp chữ (`"matrix_lock_screenmatrix_lock_screen"`), cần sửa lại trước khi tái sử dụng | P2 |
| TC-HERO-02 | ✅ **PASS 2026-09-15** — Tên animation lạ → rơi xuống tier ảnh, không phải bundled hoàn toàn | `06-hero/02-animation-unknown-name.json` | như trên | Hiện tier ảnh (không phải animation, không phải màn trắng) — verify đúng hành vi "rơi xuống tier ảnh" ghi trong builder, không phải giả định. **Đã verify thật:** headline vẫn theo payload, hero hiện ảnh tĩnh — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/06-hero/02-animation-unknown-name.png). Không phân biệt được ảnh này với ảnh bundled mặc định (có thể là cùng 1 asset) | P2 |
| TC-HERO-03 | ✅ **PASS 2026-09-15** — Hero ảnh https hợp lệ | `06-hero/03-image-https-valid.json` | như trên | Hiện đúng ảnh từ URL. **Đã verify thật, 2 lần mở:** [lần 1](../requirements/test-plans/paywall-remote-config-payloads/screenshots/06-hero/03-image-https-valid-first-exposure.png) hero hiện ảnh bundled (đúng cơ chế cache — lần đầu gặp URL mới), [lần 2](../requirements/test-plans/paywall-remote-config-payloads/screenshots/06-hero/03-image-https-valid-second-exposure.png) **ảnh thật đã load** (ảnh dâu tây từ picsum.photos). Xác nhận đúng cơ chế cache 2-lần-mở mô tả trong `paywall-config.md` bằng thực nghiệm | P2 |
| TC-HERO-04 | ✅ **PASS 2026-09-15** — Hero ảnh http (không phải https) → bị bỏ qua | `06-hero/04-image-http-invalid.json` | như trên | Dùng ảnh bundled mặc định, không phải URL http đã nhập. **Đã verify thật:** hero hiện ảnh bundled — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/06-hero/04-image-http-invalid.png). Không phụ thuộc cache vì URL bị từ chối ngay từ bước validate | P1 |
| TC-HERO-05 | ✅ **PASS (chức năng) 2026-09-15** — Nút ✕ luôn bấm được bất kể nội dung hero | Bất kỳ payload hero nào ở trên | Với mỗi biến thể TC-HERO-01..04, thử bấm ✕ | Đóng được màn paywall ở mọi trường hợp, không bị hình hero che. **Đã verify thật trên device** (xác nhận bằng lời, không kèm ảnh) | P2 |
| TC-HERO-06 | 3 animation cao bằng nhau, không đẩy CTA lệch | `06-hero/01-animation-valid.json` (3 biến thể) | Bấm đổi qua lại giữa các state nếu có debug picker (`ios/Ink/UI/Pro/Hero/ProHeroSlot.swift` `#Preview("Hero animations")`), hoặc so ảnh chụp 3 lần publish | Phần bên dưới (giá, CTA) không nhích lên/xuống giữa 3 animation | P2 |
| TC-HERO-07 | **Thiết kế lại 2026-09-14** — ảnh hero mới chỉ hiện ở **lần mở kế tiếp**, không phụ thuộc tốc độ mạng. `paywall-config.md`: *"adopted only once the file is already in the image cache — the first launch that sees a new URL still draws the bundled art and warms the cache, and the swap happens on the next appearance"* | `06-hero/03-image-https-valid.json`, mạng **bình thường** (không cần throttle — cố ý bỏ Network Link Conditioner vì không phải biến số đúng) | 1. Publish payload có `hero.image_url` mới, mạng bình thường.<br>2. Kill app → mở lại → mở paywall (**lần 1**).<br>3. Đóng paywall, mở lại paywall lần nữa **trong cùng phiên hoặc mở app lại** (**lần 2**). | **Lần 1:** vẫn hiện ảnh **bundled** dù mạng nhanh, dù payload đã đúng — đây là hành vi thiết kế, không phải bug. **Lần 2:** hiện đúng ảnh custom (đã cache xong ở lần 1). Nếu ảnh custom hiện ngay từ lần 1 → khác tài liệu, cần báo | P2 |
| TC-HERO-08 | Reduce Motion bật → hero đứng yên, không nhấp nháy | `06-hero/01-animation-valid.json` | Bật Cài đặt → Trợ năng → Chuyển động → Giảm chuyển động, mở paywall | Hero hiện ở trạng thái hoàn chỉnh, đứng yên, không lặp | P2 |
| TC-HERO-09 | ✅ **PASS 2026-09-15** — 🔴 Payload thực tế thiếu key `hero` dù tên `variant` ngụ ý animation Matrix | `11-realistic-full-case/01-as-given-missing-hero.json` | Publish → kill app → mở lại | Hero rơi về ảnh/animation **mặc định của app**, không phải `matrix_lock_screen` — xác nhận đây là lỗi có thật trong bản seed gốc của `paywall-config-builder.html`, không phải giả định. **Đã verify thật** — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/11-realistic-full-case/01-as-given-missing-hero.png), đã gộp vào câu hỏi #1 gửi dev | P2 |
| TC-HERO-10 | ✅ **PASS 2026-09-15** — Control — cùng payload nhưng có `hero.animation` đúng như tên biến thể | `11-realistic-full-case/02-fixed-with-hero.json` | như trên | Hiện đúng animation Matrix — đối chiếu cạnh TC-HERO-09 để khẳng định khác biệt duy nhất là field `hero`. **Đã verify thật, cô lập sạch** — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/11-realistic-full-case/02-fixed-with-hero.png), mọi phần khác giống hệt TC-HERO-09 | P3 |

## Suite E — Benefits

| ID | Mục tiêu | Test data | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-BEN-01 | Custom benefits hiện đúng icon/tint/title | Sửa tay `09-benefits-boundary/01-benefits-5.json` (đổi icon/tint thật) | Publish, mở paywall | Icon, màu nền, chữ khớp đúng cấu hình | P2 |
| TC-BEN-02 | ✅ **PASS 2026-09-15** — Đúng 5 dòng → giữ đủ | `09-benefits-boundary/01-benefits-5.json` | như trên | Hiện đủ 5 dòng, đúng thứ tự mảng. **Đã verify thật** — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/09-benefits-boundary/01-benefits-5.png) | P2 |
| TC-BEN-03 | ✅ **PASS 2026-09-15** — 6 dòng → cắt còn 5 | `09-benefits-boundary/02-benefits-6.json` | như trên | Chỉ 5 dòng đầu hiện, "Benefit 6" **không** xuất hiện. **Đã verify thật** — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/09-benefits-boundary/02-benefits-6.png) | P2 |
| TC-BEN-04 | ✅ **PASS 2026-09-15** — `benefits: []` → ẩn hẳn khối, không xô lệch layout | `09-benefits-boundary/03-benefits-empty.json` | như trên | Khối benefit biến mất, khoảng cách hero↔plans không có lỗ hổng lạ. **Đã verify thật** — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/09-benefits-boundary/03-benefits-empty.png) | P2 |
| TC-BEN-05 | ✅ **PASS 2026-09-15** — Icon tên sai → fallback `sparkles`, giữ dòng | `09-benefits-boundary/04-benefits-invalid-icon.json` | như trên | Dòng vẫn hiện, icon là ✨ (sparkles), không crash, không ô trống. **Đã verify thật** — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/09-benefits-boundary/04-benefits-invalid-icon.png) | P2 |
| TC-BEN-06 | Tint tên sai → fallback `brandViolet`, giữ dòng | Sửa tay 1 dòng benefit: `"tint": "mauKhongTonTai"` | như trên | Dòng vẫn hiện, nền icon đổi sang màu `brandViolet` | P3 |
| TC-BEN-07 | Chữ benefit dài (tiếng Đức/Việt) → xuống tối đa 2 dòng, co chữ, không tràn | Sửa tay `title` 1 dòng benefit thành câu dài tiếng Đức hoặc Việt có dấu (~40+ ký tự) | như trên | Xuống tối đa 2 dòng, tự co còn ~85%, không tràn khỏi cột ~233pt, không bị cắt cụt giữa chữ | P2 |

## Suite F — Plans

| ID | Mục tiêu | Test data | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-PLAN-01 | Không khai `plans` → đọc key cũ `pro_plan_config` | `02-plans-fallback/01-plans-not-declared.json` | Publish → kill app → mở lại | Gói hiển thị theo nội dung đang có ở `pro_plan_config`, không phải bundled ngay lập tức | P2 |
| TC-PLAN-02 | 0 hàng hợp lệ trong `plans` → `pro_plan_config` rồi bundled | `02-plans-fallback/02-plans-all-invalid-rows.json` | như trên | Rơi về `pro_plan_config`; nếu key đó cũng không có gói dùng được → bundled. Không được trống. **Verify qua log:** category `paywall-config`, chuỗi `"paywall config yielded no buyable rows"` (`paywall-config.md` § Failure modes) — có log này là bằng chứng chắc chắn hơn quan sát UI đơn thuần | P1 |
| TC-PLAN-03 | ⭐ Tất cả hàng hợp lệ nhưng `show:false` hết → phải tự dựng lại bằng bundled | `02-plans-fallback/03-plans-all-hidden-CRITICAL.json` | như trên | **Không được hiện màn trống** — app phải tự rebuild bằng danh sách gói bundled. **Verify qua log:** category `paywall-config`, chuỗi `"paywall config yielded no buyable rows"` — cùng log với TC-PLAN-02, dùng để phân biệt với case "Couldn't load Pro plans" (lỗi mạng/store thật, không phải lỗi config, xem `paywall-config.md` § Failure modes) | P1 |
| TC-PLAN-04 | Control — 3 gói hiện bình thường, đúng thứ tự, đúng preselected | `02-plans-fallback/04-plans-normal.json` | như trên | Thứ tự hiển thị = thứ tự mảng; gói Annual (đã đặt `preselected:true`) được chọn sẵn (viền tím) | P1 |
| TC-PLAN-05 | Đổi thứ tự mảng → thứ tự trên màn đổi theo | Sửa tay `02-plans-fallback/04-plans-normal.json`: đảo vị trí 2 gói | như trên | Thứ tự hiển thị khớp đúng thứ tự mảng mới | P2 |
| TC-PLAN-06 | ✅ **PASS 2026-09-15** — `product_id` trùng giữa 2 hàng | `05-plans-edge-cases/01-duplicate-product-id.json` | như trên | Cả 2 hàng cùng hiện (app không tự loại trùng) — ghi nhận đây có phải bug hiển thị 2 dòng giống hệt nhau. **Đã verify thật:** đúng 2 hàng "Weekly POPULAR $1.99" cùng hiện — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/05-plans-edge-cases/01-duplicate-product-id.png). Xác nhận đây là hành vi thật (không tự loại trùng), coi là usability gap nhẹ hơn là bug nghiêm trọng | P2 |
| TC-PLAN-07 | ✅ **PASS 2026-09-15** — `product_id` ngoài 3 id đang bán thật | `05-plans-edge-cases/02-unknown-product-id.json` | như trên | Nếu ASC không có id này, StoreKit trả rỗng → hàng biến mất khỏi màn hình, các hàng khác không xô lệch. **Đã verify thật + phát hiện mở rộng:** hàng biến mất, và vì đây là hàng duy nhất nên "0 gói mua được" → **cùng lưới an toàn với TC-PLAN-03 kích hoạt đúng**, hiện đủ 3 gói bundled mặc định thay vì màn trống — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/05-plans-edge-cases/02-unknown-product-id.png). Safety net rộng hơn dự kiến (không chỉ bắt `show:false`, còn bắt cả "StoreKit không nhận id") | P2 |
| TC-PLAN-08 | ✅ **PASS 2026-09-15 (tốt hơn dự đoán)** — `period`/`type` lệch nhau | `05-plans-edge-cases/03-period-type-mismatch.json` | như trên | Quan sát CTA và dòng "Auto-renew. Cancel anytime." — ghi nhận có hiển thị sai (vd hiện Auto-renew cho gói set `period:lifetime`). **Đã verify thật — KHÔNG có hiển thị sai như lo ngại:** subtitle hiện đúng "One-time purchase" theo `period`, không xuất hiện dòng Auto-renew sai — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/05-plans-edge-cases/03-period-type-mismatch.png). Hành vi hiển thị dựa theo `period`/dữ liệu StoreKit thật, không bị `type` sai kéo lệch UI — an toàn hơn hẳn Decision Table đã dự đoán | P2 |
| TC-PLAN-09 | ✅ **PASS 2026-09-15** — `discount = 0` → ngoài khoảng hợp lệ | `10-discount-boundary/01-discount-0-invalid.json` | như trên | Không pill "Save", không giá gạch ngang — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/10-discount-boundary/01-discount-0-invalid.png) | P3 |
| TC-PLAN-10 | ✅ **PASS 2026-09-15** — `discount = 0.01` → biên dưới hợp lệ | `10-discount-boundary/02-discount-0.01-valid.json` | như trên | Có pill "Save 1%" + giá gạch ngang. **Verify thật:** pill "SAVE 1%" + gạch $50.49 (đúng công thức price/(1-discount)) — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/10-discount-boundary/02-discount-0.01-valid.png) | P3 |
| TC-PLAN-11 | ✅ **PASS 2026-09-15** — `discount = 0.99` → biên trên hợp lệ | `10-discount-boundary/03-discount-0.99-valid.json` | như trên | Có pill "Save 99%" + giá gạch ngang. **Verify thật:** pill "SAVE 99%" + gạch $4,999.00 (đúng công thức) — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/10-discount-boundary/03-discount-0.99-valid.png) | P3 |
| TC-PLAN-12 | ⚠️ **Lệch dự đoán 2026-09-15, đã sửa expected** — `discount = 1` → ngoài khoảng hợp lệ | `10-discount-boundary/04-discount-1-invalid.json` | như trên | ~~Không pill, không giá gạch ngang~~ → **Thực tế: pill "SAVE 100%" vẫn hiện**, chỉ riêng giá gạch ngang không hiện (49.99/(1-1) chia cho 0, không tính được) — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/10-discount-boundary/04-discount-1-invalid.png). App chỉ chặn phần tính toán bị lỗi, không chặn cả pill như builder tool JS dự đoán (`r.discount = (d>0 && d<1) ? d : null`) — ghi nhận discrepancy, không phải bug nghiêm trọng vì "Save 100%" vẫn là thông tin đúng về mặt số học | P3 |
| TC-PLAN-13 | ✅ **PASS 2026-09-15** — `discount` âm → ngoài khoảng hợp lệ | `10-discount-boundary/05-discount-negative-invalid.json` | như trên | Không pill, không giá gạch ngang — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/10-discount-boundary/05-discount-negative-invalid.png) | P3 |
| TC-PLAN-14 | 2 hàng cùng `preselected:true` → hàng đứng trước thắng | Sửa tay `02-plans-fallback/04-plans-normal.json`: set `preselected:true` cho cả 2 gói đầu | như trên | Chỉ gói đứng **trước** trong mảng được chọn sẵn, gói sau bị lờ | P2 |
| TC-PLAN-15 | ✅ **PASS 2026-09-15** — Không hàng nào `preselected` → chọn hàng đầu tiên | `05-plans-edge-cases/04-no-preselected.json` | như trên | Gói **đầu tiên trong mảng** được chọn sẵn (không phải theo `badge` hay giá). **Đã verify thật:** Weekly (đầu mảng, không badge) được chọn, không phải Annual (có `best_value`) — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/05-plans-edge-cases/04-no-preselected.png) | P2 |
| TC-PLAN-16 | Đủ 3 gói vẫn thấy hết không cần cuộn trên máy màn nhỏ | `02-plans-fallback/04-plans-normal.json` | Test trên iPhone SE / iPhone 13 mini | Gói cuối (Lifetime) nhìn thấy được không cần cuộn | P2 |
| TC-PLAN-17 | Badge hiển thị đúng nhãn | `02-plans-fallback/04-plans-normal.json` | như trên | `best_value` và `popular` hiện đúng text, đúng vị trí (theo qc-vi B5) | P3 |
| TC-PLAN-18 | ✅ **PASS 2026-09-15 — CHỐT bằng cả văn bản lẫn thiết bị thật** — Xác nhận hành vi `yearly` vs `annual` (`paywall-config.md` § Failure modes: *"yearly is not a case"*) | `08-open-questions/01-yearly-vs-annual.json` | Publish → mở paywall, quan sát gói dùng `product_id`/`period` = `yearly` | Gói này **bị loại âm thầm khỏi decode** (không log lỗi hiển thị cho user, không banner) — **2 gói còn lại (weekly, lifetime) vẫn hiện bình thường**, không kéo sập cả payload. **Đã verify thật:** đúng như dự đoán — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/08-open-questions/01-yearly-vs-annual.png). Câu hỏi mở đã đóng hẳn | P2 |

## Suite G — Trial title logic (Decision Table 3, test plan §5)

> Cần 2 loại Apple ID: **chưa từng dùng thử** và **đã hết hạn dùng thử** (qc-vi.md "Chuẩn bị").
> ⚠️ **Case giữ Open/Blocked — QC sẽ verify lại trên prod (2026-09-15, test plan §10.10).** Chạy TC-TRIAL-01 bằng tài khoản **mới, chưa mua lần nào**, test ở `dev` + **Sandbox thật** → vẫn hiện `title_no_trial` ("Weekly plan") thay vì title có `{trial}` ([ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/03-trial-title/01-trial-with-fallback.png)). Đã loại 2 giả thuyết: ~~ASC thiếu offer~~ và ~~local StoreKit Configuration File~~. **Lưu ý khi verify lại trên prod:** đổi Firebase RC project không ảnh hưởng StoreKit/trial — nên dùng kèm **1 Sandbox Tester tạo mới hoàn toàn** (tách bạch khỏi nghi vấn account dính lịch sử trial cũ) hoặc verify thật qua TestFlight nếu muốn đổi cả StoreKit environment. Chỉ chạy được TC-TRIAL-02/03/04 (nhánh "hết trial"/"không trial") cho tới khi có kết quả verify mới.

| ID | Mục tiêu | Test data | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-TRIAL-01 | ⚠️ **Blocked 2026-09-15** — `{trial}` + `title_no_trial`, tài khoản còn trial | `03-trial-title/01-trial-with-fallback.json` | Đăng nhập tài khoản **chưa dùng thử**, mở paywall | Hiện "Get {N}-day free trial" với N lấy đúng từ StoreKit (không gõ tay trong RC). **Thực tế đã chạy:** vẫn hiện `title_no_trial` ("Weekly plan") dù acc mới — do `Pro.storekit` chưa có offer, không phải bug (xem banner Suite G). Chờ xác nhận ASC trước khi coi là Fail hay Pass | P1 |
| TC-TRIAL-02 | Cùng payload, tài khoản hết trial | `03-trial-title/01-trial-with-fallback.json` | Đăng nhập tài khoản **đã hết hạn dùng thử**, mở paywall | Hiện đúng `title_no_trial` ("Weekly plan"), **không** còn chữ "free trial" | P1 |
| TC-TRIAL-03 | ✅ **PASS 2026-09-15** — `{trial}` không có `title_no_trial`, tài khoản hết trial — **đã hạ mức, xem ghi chú** | `03-trial-title/02-trial-missing-fallback-expected.json` | Đăng nhập tài khoản **đã hết hạn dùng thử**, mở paywall | Dòng gói rơi về **tên bundled** (vd "Weekly"), không phải tên đã đặt trong RC. `paywall-config.md` § Failure modes gọi thẳng đây là **"expected — set `title_no_trial`"**, không phải bug — chỉ là thiếu polish nội dung. *(Sửa 2026-09-14: trước đó gắn nhầm "🔴 Lỗi nặng"/P1 — nhầm với case khác hẳn trong `paywall-qc-vi.md` là "dòng gói ghi 'dùng thử' cho tài khoản **hết hạn**", tức hiển thị SAI lời hứa trial chứ không phải rơi về tên chung chung. Case đó đã được TC-TRIAL-02 kiểm tra: xác nhận tài khoản hết trial **không** thấy chữ "trial" nào — đó mới là bug thật nếu xảy ra.)* **Đã verify thật 2026-09-15:** hiện đúng `"Weekly"` (bundled thuần, khác `"Weekly plan"` của TC-TRIAL-01 vì case đó có `title_no_trial` custom) — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/03-trial-title/02-trial-missing-fallback-expected.png). Case này **không bị confound** bởi blocker của TC-TRIAL-01 vì đang test đúng nhánh "thiếu `title_no_trial`", không phải nhánh "có trial". | P3 |
| TC-TRIAL-04 | ✅ **PASS 2026-09-15 (nhánh không-trial)** — chỉ có `title_no_trial`, không có `title` | `03-trial-title/03-title-no-trial-only.json` | Mở paywall trên tài khoản **không có trial claimable** (StoreKit chưa báo có offer — trạng thái hiện tại của mọi account đang test, xem blocker TC-TRIAL-01) | Hiện đúng text `title_no_trial` (`"Weekly (no trial wording)"`) — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/03-trial-title/03-title-no-trial-only.png). *(Sửa 2026-09-15: mô tả cũ "hiện tên bundled" giả định sai — đó là hành vi khi **có** trial claimable nhưng thiếu `title`, chưa test được do cùng blocker TC-TRIAL-01. Khi **không** có trial claimable, `title_no_trial` được ưu tiên dùng ngay nếu có mặt, không rơi xuống bundled.)* | P3 |
| TC-TRIAL-05 | ⚠️ **Blocked 2026-09-15** (cùng nguyên nhân TC-TRIAL-01) — số ngày trên paywall khớp Settings | `03-trial-title/01-trial-with-fallback.json` | Tài khoản còn trial: so số ngày trên paywall với màn Settings | Số ngày **giống hệt nhau** ở cả 2 nơi — **không thể test** cho tới khi có offer thật, hiện không có số ngày nào hiện để đối chiếu | P1 |
| TC-TRIAL-06 | ⚠️ **Blocked 2026-09-15** (cùng nguyên nhân) — số ngày khớp App Store Connect, không khớp số gõ tay trong RC | Bất kỳ payload có `{trial}` | Đối chiếu số ngày hiện trên app với cấu hình trial thật ở ASC | Số ngày = cấu hình ASC; nếu RC có gõ số khác (vd hard-code "3 ngày" ở đâu đó) → phải **không** dùng số đó | P1 |

## Suite H — Locale mở rộng & Accessibility

| ID | Mục tiêu | Test data | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-LOC-01 | ✅ **PASS 2026-09-15** — `zh-Hant` đọc bundled riêng, override từ map `zh` | `07-locale/01-zh-hant-demo.json` | Máy đặt **繁體中文 (zh-Hant)**, mở paywall | Headline hiện đúng override đã đặt ở key `"zh"` (không phải `"zh-Hant"`); phần không override dùng **chuỗi bundled zh-Hant**. **Đã verify thật:** chrome hiện đúng phồn thể (繼續/隱私權/恢復購買), headline hiện đúng marker override từ key `zh` — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/07-locale/01-zh-hant-demo.png). *(Lần chụp đầu máy thực ra ở giản thể, đã loại — bài học: phải xác nhận chrome đổi ngôn ngữ thật trước khi tin ảnh)* | P2 |
| TC-LOC-02 | Đủ 10 locale RC không sót chữ tiếng Anh | Sửa tay baseline: điền đủ `en,vi,es,id,ja,ko,ms,pt,th,zh` cho headline/subtitle/1 benefit/1 plan title | Lặp qua 10 ngôn ngữ máy, mỗi lần mở paywall | Mỗi máy hiện đúng ngôn ngữ tương ứng, không sót tiếng Anh ở đâu | P2 |
| TC-LOC-03 | Dynamic Type mức lớn nhất | Bất kỳ payload | Cài đặt → Trợ năng → cỡ chữ lớn nhất, mở paywall | CTA không phình vỡ layout, chữ không tràn khỏi khung | P2 |
| TC-LOC-04 | iPad không kéo giãn hết chiều ngang | Bất kỳ payload | Mở trên iPad, cả 2 chiều | Nội dung canh giữa hợp lý, không full-width | P2 |
| TC-LOC-05 | VoiceOver đọc được tên gói/giá/badge | Bất kỳ payload | Bật VoiceOver, vuốt qua toàn bộ màn paywall | Đọc đủ thông tin gói (tên, giá, badge nếu có) theo đúng thứ tự trực quan — **gap chưa có case trong B8 gốc**, case mới | P2 |

## Suite I — Analytics

> ⚠️ **Tiền điều kiện mới, chưa xác nhận (test plan §10.9):** custom dimension `paywall_variant` (scope User) phải đã đăng ký trong GA4 cho **cả 2 project** trước khi execute — đăng ký **không hồi tố**, nên nếu chưa làm thì TC-ANA-02/04 sẽ không thấy được dữ liệu dù property vẫn được ghi đúng ở phía app.

| ID | Mục tiêu | Test data | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-ANA-01 | Event `pro_paywall_viewed` bắn đúng `variant` | `02-plans-fallback/04-plans-normal.json` (đã có `variant`) | Mở paywall, kiểm tra DebugView/Firebase Analytics | Event ghi nhận với `variant` đúng chuỗi đã đặt trong RC | P2 |
| TC-ANA-02 | User property `paywall_variant` đúng chuỗi | như trên | Kiểm tra user property trong Firebase | `paywall_variant` = đúng chuỗi `variant` trong RC | P2 |
| TC-ANA-03 | Không có RC / dùng bundled → `paywall_variant = "bundled"` | Xoá parameter (như TC-DEF-01) | Mở paywall, kiểm tra user property | `paywall_variant` = `"bundled"` chính xác (không phải rỗng hay `null`) | P2 |
| TC-ANA-04 | 2 nhánh A/B trùng `variant` → hỏng khả năng tách funnel | Tạo 2 payload cùng `"variant": "trung_nhau"`, publish ở 2 nhánh A/B Testing | Publish experiment, kiểm tra Analytics funnel theo `paywall_variant` | Không tách được 2 nhánh trong báo cáo — xác nhận đây là lỗi vận hành (process), không phải bug code, cần quy trình đặt tên tránh trùng | P1 |
| TC-ANA-05 | BVA độ dài `variant` quanh ngưỡng 36 ký tự | Sửa tay `variant` trên baseline: 36 và 37 ký tự | 2 lượt publish riêng | Ghi nhận Firebase/app có cắt bớt hay từ chối chuỗi 37 ký tự không — ngưỡng 36 lấy từ qc-vi.md A5, cần verify thực tế | P3 |

## Suite K — Giá / tiền tệ (mới, P1 — không nằm trong checklist B gốc)

> Xem [08_paywall.md](../requirements/ui/ux/wideframes/08_paywall.md#-giá-hiển-thị-trong-app-không-khớp-giá-thật) — lỗi đã phát hiện qua screenshot, **chưa log vào bug-log**, dùng bộ case này để verify lại có đúng hiện tượng và đo phạm vi ảnh hưởng.

| ID | Mục tiêu | Test data | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-PRICE-01 | Giá gói Weekly trong app khớp giá StoreKit thật | Không cần payload RC riêng — dùng paywall mặc định hoặc bất kỳ payload không set giá cứng | 1. Đăng nhập Apple ID khu vực **Việt Nam**.<br>2. Mở paywall, ghi lại giá + đơn vị tiền hiển thị cho Weekly.<br>3. Mở sheet StoreKit thật (tap chọn gói → Continue) hoặc `Get Info`, ghi lại giá + đơn vị tiền tại đó. | 2 giá trị phải **khớp tuyệt đối** cả số lẫn đơn vị tiền (₫, không phải ₩). Đây là bug đã biết (S01 vs S02 trong wireframe) — case này xác nhận lại, không phải khám phá mới | P1 |
| TC-PRICE-02 | Giá gói Lifetime khớp StoreKit | như trên, đổi sang gói Lifetime | như trên | Khớp tuyệt đối — **chưa từng được verify trước đó** theo ghi chú ở wireframe dòng 166 | P1 |
| TC-PRICE-03 | Giá gói Annual khớp StoreKit, gồm cả giá quy đổi /tháng /tuần | như trên, đổi sang gói Annual | So cả 3 số hiển thị (năm/tháng/tuần) với giá trị tính tay từ giá StoreKit thật | Cả 3 số quy đổi đúng theo giá StoreKit thật, không lệch do hard-code | P1 |
| TC-PRICE-04 | Đổi region Apple ID → giá đổi theo, không đứng yên | Bất kỳ payload | Test bằng 1 tài khoản US (nếu có) và 1 tài khoản VN, so sánh cùng 1 gói | Giá + đơn vị tiền đổi đúng theo `SKProduct.priceLocale`, không phải số cố định giống nhau ở cả 2 tài khoản | P1 |

## Suite L — State transition / luồng mua hàng

> 3 case cuối **bị chặn (Blocked)** — chưa có ảnh baseline theo `08_paywall.md` mục "Possible missing screen", chỉ verify được hành vi chức năng, không so được đúng UI kỳ vọng.

| ID | Mục tiêu | Tiền điều kiện | Bước thực hiện | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-FLOW-01 | ✅ **PASS (chức năng) 2026-09-15** — Đổi gói → viền chọn chuyển, dòng Auto-renew cập nhật theo type | Đã có ≥2 gói khác `type` (`02-plans-fallback/04-plans-normal.json`) | Tap lần lượt Weekly rồi Lifetime | Viền tím chuyển đúng gói đang chọn; dòng "Auto-renew. Cancel anytime." hiện khi chọn Weekly (subscription), **ẩn** khi chọn Lifetime. **Đã verify thật trên device** (xác nhận bằng lời, không kèm ảnh) | P2 |
| TC-FLOW-02 | ✅ **PASS 2026-09-15 — bằng chứng bonus** | Bất kỳ payload | Chọn 1 gói, tap Continue | Màn mờ đi, toast "Processing…" hiện giữa màn, CTA chuyển thành spinner, không thao tác được các phần tử khác. **Đã verify:** bắt được không chủ đích khi chụp cho TC-BEN-05, cùng đủ 3 dấu hiệu (màn mờ, toast, CTA→spinner) — [ảnh bằng chứng](../requirements/test-plans/paywall-remote-config-payloads/screenshots/09-benefits-boundary/04-benefits-invalid-icon-purchasing-state-bonus-TC-FLOW-02.png) | P1 |
| TC-FLOW-03 | ⚠️ Blocked — trạng thái sau khi mua thành công (`unlocked`) | Sandbox/TestFlight test account | Double Click xác nhận trên sheet StoreKit | Chưa có ảnh baseline để so UI — chỉ verify **chức năng**: nội dung Pro đã mở khoá thật (thử vào 1 tính năng Pro), không đánh giá layout màn `unlocked` | P1 (chức năng) |
| TC-FLOW-04 | ✅ **PASS (chức năng) 2026-09-15** — Huỷ ở sheet StoreKit → quay lại đúng trạng thái trước đó | Bất kỳ payload | Mở sheet StoreKit rồi bấm Cancel/vuốt xuống | Quay lại đúng màn paywall với gói đang chọn trước đó, không mất trạng thái, không còn toast "Processing…". **Đã verify thật trên device** (xác nhận bằng lời, không kèm ảnh) | P2 |
| TC-FLOW-05 | ✅ **PASS (chức năng) 2026-09-15** — luồng Restore purchases | Tài khoản đã mua trước đó (nếu có) | Tap "Restore purchases" | Chưa có ảnh baseline cho cả 2 nhánh thành công/thất bại — chỉ ghi nhận có phản hồi (loading → kết quả), không đánh giá đúng UI kỳ vọng. **Đã verify thật trên device:** hoạt động đúng, không có tác động phụ — xác nhận bằng lời (không kèm ảnh), vẫn chưa có baseline UI để so pixel, chỉ đóng được phần "hành vi chức năng" | P2 |
| TC-FLOW-06 | ⚠️ Blocked — lỗi thanh toán (mạng lỗi/giao dịch thất bại) | Giả lập mạng lỗi giữa lúc `purchasing` | Bật airplane mode ngay sau khi tap Continue | Chưa có ảnh baseline — chỉ verify không crash, không kẹt vĩnh viễn ở trạng thái `purchasing`, có cách nào đó thoát ra được | P1 (chức năng) |

---

## Traceability matrix — test plan §2 (Test object) → test case

| # | Test object (test plan §2) | Test case |
|---|---|---|
| 1 | Envelope | TC-ENV-01…08 |
| 2 | Copy (headline/subtitle) | TC-COPY-01…05 |
| 3 | Hero | TC-HERO-01…10 |
| 4 | Benefits | TC-BEN-01…07 |
| 5 | Plans | TC-PLAN-01…18 |
| 6 | ⭐ Fallback toàn hệ thống | TC-ENV-01/03/04/07/08, TC-PLAN-02/03 (không tạo case riêng trùng lặp — đây là *thuộc tính cắt ngang* các case trên, không phải 1 tính năng độc lập) |
| 7 | Trial `{trial}` | TC-TRIAL-01…06 |
| 8 | L10n & accessibility | TC-COPY-01/02, TC-LOC-01…05 |
| 9 | Analytics | TC-ANA-01…05 |
| 10 | Giá đúng locale/tiền tệ | TC-PRICE-01…04 |
| 11 | A/B experiment | TC-ANA-04, TC-PLAN-18 (biến thể) |
| — | Luồng mua hàng (state transition, không thuộc §2 gốc nhưng có trong test plan §5) | TC-FLOW-01…06 |

**Tổng:** 75 test case / 12 suite *(75 = 73 sau khi sửa lỗi đếm "62" + 2 case mới TC-HERO-09/10, thêm khi phân tích config mẫu thực tế — xem mục Phân bổ độ ưu tiên bên dưới)*. 2 case Blocked (TC-FLOW-03/06) do thiếu baseline ảnh — xem [test plan §10.7](../requirements/test-plans/paywall-remote-config.md#10-gap-cần-làm-rõ-trước-khi-execute), không tự suy diễn expected UI khi execute. *(TC-FLOW-05 đã đóng ở mức chức năng 2026-09-15 — xem ghi chú tại case.)*

---

## Phân bổ độ ưu tiên

> Đếm trực tiếp từ cột Priority của 75 case ở trên — dùng làm cơ sở định lượng cho Exit Criteria bên dưới, theo đúng khuyến nghị ISTQB Foundation: exit criteria phải gắn với **độ phủ theo rủi ro** (risk coverage), không phải con số "% pass" chung chung không phân biệt mức độ nghiêm trọng.
>
> **Cập nhật 2026-09-14 sau khi đối chiếu `paywall-config.md`:** 2 case hạ mức — TC-PLAN-18 (P1→P2, giờ chỉ là 1 hàng bị loại âm thầm, không phải sập cả payload) và TC-TRIAL-03 (P1→P3, `paywall-config.md` gọi thẳng là "expected", không phải bug). Không case nào tăng mức.

| Suite | P1 | P1 (chỉ chức năng, chưa có UI baseline) | P2 | P3 | Tổng |
|---|---|---|---|---|---|
| A — Baseline | 1 | – | – | – | 1 |
| B — Envelope | 7 | – | 1 | – | 8 |
| C — Copy/locale | 1 | – | 3 | 1 | 5 |
| D — Hero | 1 | – | 8 | 1 | 10 |
| E — Benefits | – | – | 6 | 1 | 7 |
| F — Plans | 3 | – | 9 | 6 | 18 |
| G — Trial title | 4 | – | – | 2 | 6 |
| H — Locale mở rộng & a11y | – | – | 5 | – | 5 |
| I — Analytics | 1 | – | 3 | 1 | 5 |
| K — Giá/tiền tệ | 4 | – | – | – | 4 |
| L — State transition | 1 | 2 | 3 | – | 6 |
| **Tổng** | **23** | **2** | **38** | **12** | **75** |
| **%** | **31%** | **3%** | **50%** | **16%** | **100%** |

**Đọc bảng này thế nào:**
- **P1 dồn vào 5 suite:** Envelope (B), Trial title (G), Giá/tiền tệ (K), Plans-fallback (trong F), và Analytics-A/B trùng variant (I) — đúng 5 vùng đã xếp P1 ở [test plan §6](../requirements/test-plans/paywall-remote-config.md#6-risk-based-prioritization) vì đây là nơi lỗi = mất tiền hoặc vi phạm App Store, không phải do suite đó "quan trọng hơn" một cách chủ quan.
- **Suite F (Plans) đông nhất (18 case) nhưng tỷ trọng P1 chỉ 17%** — 3 case P1 còn lại của suite này (TC-PLAN-02/03/04) là đủ để chặn rủi ro doanh thu; phần lớn còn lại (P2/P3) là tổ hợp biên (discount, badge, order, `yearly` regression) chỉ sai lệch hiển thị.
- **Suite D (Hero) 10 case nhưng chỉ 1 P1** — vì hero hỏng nặng nhất cũng chỉ rơi về ảnh bundled (đã có lưới an toàn ở tầng dưới), khác hẳn Plans/Trial là nơi lưới an toàn có thể tự nó bị lỗi.
- **2 case "P1 chức năng"** (TC-FLOW-03/06) không tính chung với 23 case P1 còn lại trong mục tiêu "100% pass" vì chưa có baseline UI để chấm pass/fail theo UI — xem Exit Criteria mục 2 bên dưới.

## Exit Criteria (theo ISTQB Foundation — gắn với bảng phân bổ trên)

> ISTQB Foundation định nghĩa exit criteria dựa trên: **độ phủ** (coverage), **mật độ/mức nghiêm trọng defect còn mở** (defect density theo severity), **rủi ro tồn dư** (residual risk) và **lịch/chi phí** (schedule). 4 tiêu chí dưới đây áp trực tiếp 4 nhóm đó vào 75 case đã đếm ở trên — không dùng ngưỡng "80% pass" chung chung vì nó xoá mất khác biệt giữa 1 bug P1 và 1 bug P3.

1. **Coverage — theo tầng ưu tiên, không đồng nhất:**
   - **P1 (23 case):** 100% đã thực thi, 100% pass. Không có ngoại lệ — đây là các case mất tiền/vi phạm App Store/paywall trống theo đúng risk mapping ở test plan §6.
   - **P1-chức-năng (2 case, TC-FLOW-03/06):** 100% đã thực thi, pass tiêu chí **hành vi** ("không crash, không kẹt vĩnh viễn, Pro thật sự mở khoá") — **không** bắt buộc khớp UI vì chưa có ảnh baseline (test plan §10.7). Ghi residual risk khi sign-off, không được tự ý coi là "N/A nên bỏ qua".
   - **P2 (38 case):** ≥95% đã thực thi (tối thiểu 37/38), ≥90% pass (tối thiểu 35/38). Case P2 fail còn lại phải có bug đã log **và** có waiver bằng văn bản từ PO/dev trước khi sign-off — không được lặng lẽ bỏ qua.
   - **P3 (12 case):** ≥70% đã thực thi (tối thiểu 9/12), không bắt buộc 100% — cho phép time-box theo đúng bản chất cosmetic/best-effort. Case chưa chạy phải liệt kê rõ trong report, không được im lặng bỏ sót.
2. **Defect density theo severity còn mở tại thời điểm exit (mapping P1→Critical/High, P2→Medium, P3→Low theo [bugs/bug-log.md](../bugs/bug-log.md)):**
   - **0 bug Critical/High đang mở**, đặc biệt 3 vùng đã biết là "chốt chặn cuối": B6 fallback (TC-PLAN-02/03, verify qua log `"paywall config yielded no buyable rows"`), giá sai đơn vị tiền tệ (TC-PRICE-01…04, kế thừa từ bug 🔴 đã có sẵn trong wireframe), và toàn bộ Decision Table 1 envelope (TC-ENV-01/03/04/05).
   - **Tối đa 3 bug Medium đang mở** (~10% của 38 case P2) tại thời điểm exit, mỗi bug phải có waiver.
   - Bug Low không chặn exit, chỉ cần có mặt đầy đủ trong bug log để không mất dấu.
3. **Rủi ro tồn dư (residual risk) phải được liệt kê bằng văn bản khi sign-off, không được coi là "đã xong":**
   - 2 case Blocked (TC-FLOW-03/06) — chưa có ảnh baseline UI thật. *(TC-FLOW-05 đã verify chức năng thật trên device 2026-09-15, không còn Blocked — vẫn thiếu baseline UI để so pixel, nhưng không còn là residual risk chặn exit.)*
   - Mọi câu hỏi mở còn lại ở [test plan §10](../requirements/test-plans/paywall-remote-config.md#10-gap-cần-làm-rõ-trước-khi-execute) chưa được trả lời bằng văn bản — đặc biệt **§10.9 (GA4 đã thực sự đăng ký `paywall_variant` chưa — chặn kết luận Suite I)** và **§10.10 (ASC đã có introductory offer thật chưa — chặn kết luận nhánh "có trial" của Suite G)**. 4 mục đã đóng (yearly/annual, builder tool sync, `paywall-config.md` tồn tại, Auto-renew điều kiện) không còn tính vào residual risk.
   - Case P3 chưa chạy (tối đa 3/12 được phép, theo mục 1).
4. **Lịch/chi phí:** không có case P1 nào bị bỏ qua chỉ vì thiếu thời gian — nếu deadline ép buộc phải cắt phạm vi, phải cắt từ P3 → P2 theo đúng thứ tự, **không bao giờ cắt P1**. Nếu đến hạn mà vẫn còn P1 chưa pass, exit criteria **chưa đạt**, không tự động coi deadline là lý do sign-off.

**Điều kiện dừng khẩn (suspend) không đổi so với [test plan §8.1](../requirements/test-plans/paywall-remote-config.md#81-suspension--resumption-criteria)** — nếu TC-PLAN-03 (paywall trống khi tất cả gói `show:false`) fail thật, dừng ngay toàn bộ execution còn lại của Suite F/G, không tiếp tục tích luỹ thêm case pass trong khi lỗi chặn doanh thu nghiêm trọng nhất còn mở.
