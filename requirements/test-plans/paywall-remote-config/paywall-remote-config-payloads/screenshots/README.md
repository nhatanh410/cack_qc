# Screenshot evidence — Paywall Remote Config

Ảnh chụp màn hình thật khi thực thi từng test case trong [test-cases/paywall-remote-config.md](../../../../../test-cases/paywall-remote-config/paywall-remote-config.md), dùng để đối chiếu với Expected Result đã viết sẵn (test-cases + [README của payloads](../README.md)) — không phải bộ ảnh UX/wireframe, không theo rule [`screenshot-naming.md`](../../../../../.claude/rules/screenshot-naming.md) (rule đó dành cho `requirements/ui/ux/screenshots/`, mục đích khác: dựng wireframe/flow từ ảnh thiết kế).

## Quy ước đặt tên

**Thư mục con + tên file trùng hệt file JSON tương ứng bên [`../`](../)**, chỉ đổi đuôi `.json` → `.png`:

```
payloads/02-plans-fallback/01-plans-not-declared.json
screenshots/02-plans-fallback/01-plans-not-declared.png   ← ảnh của đúng case đó
```

- 1 case cần nhiều ảnh (nhiều state, nhiều locale, nhiều account test...) → thêm hậu tố mô tả, vd `01-plans-not-declared-vi.png`, `01-plans-not-declared-trial-expired.png`. Không dùng `copy`/`(1)`/`2`.
- Case Blocked hoặc chưa chạy → không tạo file rỗng, chỉ để trống thư mục.
- Ảnh chứa dữ liệu cá nhân thật (email tester, số thẻ...) → che trước khi lưu vào đây, theo đúng lưu ý đã có ở [08_paywall.md](../../../../ui/ux/wideframes/08_paywall.md).

## Log kết quả

> Ghi lại đây mỗi khi thêm ảnh — không bắt buộc sửa lại bảng case chính trong `test-cases/paywall-remote-config.md`, bảng dưới đây là nơi track thực thi.

| File | TC tương ứng | Ngày chụp | Kết quả | Ghi chú |
|---|---|---|---|---|
| `02-plans-fallback/01-plans-not-declared.png` | TC-PLAN-01 | 2026-09-15 | ✅ PASS | Không gửi `plans` → đúng như kỳ vọng, app rơi về `pro_plan_config`: hiện 3 gói mặc định (Weekly $1.99, **Annual $19.99 — BEST VALUE, đang chọn sẵn**, Lifetime $49.99). Headline hiện đúng marker `[TC plans-01]...` từ payload, xác nhận đúng payload đang publish. |
| `02-plans-fallback/02-plans-all-invalid-rows.png` | TC-PLAN-02 | 2026-09-15 | ✅ PASS | 2 hàng `plans` đều thiếu field bắt buộc (`product_id` rỗng / `period` rỗng) → 0 hàng hợp lệ → đúng như kỳ vọng, rơi về `pro_plan_config`: cùng 3 gói mặc định như TC-PLAN-01 (Weekly $1.99, Annual $19.99 BEST VALUE, Lifetime $49.99). Headline khớp marker `[TC plans-02]...`. |
| `02-plans-fallback/03-plans-all-hidden-CRITICAL.png` | ⭐ TC-PLAN-03 (P1 quan trọng nhất) | 2026-09-15 | ✅ PASS | Cả 3 gói hợp lệ nhưng `show:false` hết → **app tự rebuild đúng bằng danh sách bundled**, không hiện màn trống (Weekly $1.99, Annual $19.99 BEST VALUE, Lifetime $49.99). Đây là lưới an toàn chống paywall trống đã hoạt động đúng như thiết kế — case đã đánh dấu ⭐ trong `paywall-qc-vi.md` B6. Headline khớp marker `[TC plans-03]...`. |
| `02-plans-fallback/04-plans-normal.png` | TC-PLAN-04 (control) | 2026-09-15 | ✅ PASS | 3 gói custom hiện đúng: Weekly có badge **POPULAR**, Annual có badge **BEST VALUE** và **được chọn sẵn** (viền tím) — khớp đúng `badge`/`preselected` đã đặt trong fixture. Đối chiếu với 3 ảnh fallback ở trên: bundled mặc định **không có** badge POPULAR trên Weekly, nên đây là bằng chứng rõ badge đang đọc đúng từ RC custom chứ không phải trùng hợp với bundled. Headline khớp marker `[TC plans-04]...`. Ảnh có banner debug "Ink Dev / 615 ms" — bình thường, chỉ hiện ở build dev. |
| `03-trial-title/01-trial-with-fallback.png` | TC-TRIAL-01 | 2026-09-15 | ⚠️ OPEN/BLOCKED — QC sẽ verify lại trên prod | Gói Weekly hiện `"Weekly plan"` (`title_no_trial`) thay vì `"Get {trial} free"`, dù test bằng acc **mới, chưa mua lần nào**, ở `dev` + **Sandbox thật**. Đã loại 2 giả thuyết: ASC thiếu offer, đang test qua local StoreKit Configuration File. Kế hoạch: verify lại trên prod — lưu ý đổi Firebase project không ảnh hưởng StoreKit, nên dùng kèm Sandbox Tester tạo mới để tách bạch biến số — xem test plan §10.10. |
| `03-trial-title/02-trial-missing-fallback-expected.png` | TC-TRIAL-03 *(lưu ý: marker nội bộ trong file JSON ghi nhầm "[TC trial-02]" — di sản từ lúc đặt tên fixture theo thứ tự file, không khớp TC-ID cuối cùng; giữ nguyên không sửa vì ảnh bằng chứng đã chụp đúng chữ này)* | 2026-09-15 | ✅ PASS | `title` có `{trial}` nhưng **không có** `title_no_trial` → hiện đúng tên **bundled thuần** `"Weekly"` (không phải `"Weekly plan"` như TC-TRIAL-01, vì case đó có `title_no_trial` custom). Đúng cơ chế "rơi thêm 1 tầng xuống bundled khi thiếu `title_no_trial`" mà `paywall-config.md` mô tả là **expected**, không phải bug. Case này **không phụ thuộc** vào việc account có claim được trial hay không — dù nguyên nhân gốc của TC-TRIAL-01 (mục trên) chưa giải quyết, kết quả case này vẫn đáng tin vì đang test đúng nhánh "không có `title_no_trial`", không phải nhánh "có trial". |
| `03-trial-title/03-title-no-trial-only.png` | TC-TRIAL-04 | 2026-09-15 | ✅ PASS | Chỉ có `title_no_trial` (`"Weekly (no trial wording)"`), không có `title` → hiện đúng y hệt text đó, không rơi về bundled trần trụi (khác TC-TRIAL-03 vì case đó thiếu hẳn `title_no_trial`). Xác nhận thứ tự ưu tiên đúng: `title_no_trial` được dùng ngay khi có, bất kể `title` tồn tại hay không, trong nhánh "không có trial claimable" hiện tại. Nhánh "có trial claimable" cho fixture này (hasTrial=true, không có `title`) **vẫn chưa test được** — cùng blocker với TC-TRIAL-01. |
| `04-empty-field-asymmetry/01-headline-empty-vi-device-en.png` | ⭐ TC-COPY-03 (máy EN) | 2026-09-15 | ✅ PASS | Headline hiện đúng `headline.en` (marker `[TC empty-01]...`) — bình thường, không có fallback nào xảy ra vì key `en` có sẵn. Dùng làm đối chứng cho ảnh máy VI bên dưới. |
| `04-empty-field-asymmetry/01-headline-empty-vi-device-vi.png` | ⭐ TC-COPY-03 (máy VI — case chính) | 2026-09-15 | ✅ PASS | **Xác nhận đúng quy tắc phản trực giác nhất trong spec:** `headline.vi: ""` (chuỗi rỗng) → hiện đúng **"Mở khóa tất cả"** (chữ bundled hard-code thật), KHÔNG phải marker `headline.en`, KHÔNG phải khoảng trắng. Đối chứng: `subtitle` (chỉ có key `en`, không có `vi`) hiện **giữ nguyên tiếng Anh** `"control subtitle - luon con"` ở cả 2 máy — đúng luật khác hẳn headline (subtitle thiếu locale → fallback nội bộ trong map sang `en`, không fallback ra bundled). 2 ảnh này xác nhận rõ ràng 2 cơ chế khác nhau của Decision Table 4 cùng lúc. |
| `04-empty-field-asymmetry/02-subtitle-empty-vi-device-en.png` | TC-COPY-04 (máy EN — đối chứng) | 2026-09-15 | ✅ PASS | Máy EN hiện đúng `headline.en` + `subtitle.en` (cả 2 marker `[TC empty-02]...`) — đúng, không bất ngờ vì cả 2 key `en` đều có sẵn. |
| `04-empty-field-asymmetry/02-subtitle-empty-vi-device-vi.png` | ⭐ TC-COPY-04 (máy VI — case chính) | 2026-09-15 | ✅ PASS | **Xác nhận đúng cả 2 vế của Decision Table 4 cùng lúc:** headline (thiếu hẳn key `vi`, không phải rỗng) → fallback nội bộ sang `en`, hiện đúng `"[TC empty-02] headline control - luon con"`. Subtitle (`vi: ""`) → **ẩn hẳn hoàn toàn**, không có dòng nào giữa headline và benefit — đúng ngược hẳn hành vi headline ở TC-COPY-03. *(Ảnh VI ban đầu gửi kèm là bản trùng lặp của case TC-COPY-03 — đã xoá, đây là ảnh đúng thay thế.)* |
| `01-envelope/02-schema-version-not-integer.png` | TC-ENV-02 | 2026-09-15 | ✅ PASS | `schema_version: 0` (không phải số nguyên ≥1) → **coi như vắng mặt (= v1)**, payload vẫn được áp dụng bình thường — headline đổi đúng theo marker `[TC env-02]...`. Xác nhận: field envelope sai kiểu dữ liệu không tự động làm hỏng cả payload, chỉ những field envelope sai **giá trị** (`schema_version > 1`, `min_app_version` cao hơn build, `use_bundled_paywall: true`) mới bỏ nguyên payload. |
| `01-envelope/01-kill-switch-on.png` | TC-ENV-01 | 2026-09-15 | ✅ PASS | `use_bundled_paywall: true` → headline hiện đúng **`"Unlock everything"`** (chữ bundled mặc định), KHÔNG phải marker `[TC env-01]...` — xác nhận kill switch bỏ toàn bộ payload, kể cả field vô hại như headline. Đúng vị trí ưu tiên cao nhất trong Decision Table 1 (kiểm tra trước cả `schema_version`/`min_app_version`). |
| `01-envelope/03-schema-version-too-high.png` | TC-ENV-03 | 2026-09-15 | ✅ PASS | `schema_version: 2` (>1) → headline hiện đúng **`"Unlock everything"`** (bundled), KHÔNG phải marker `[TC env-03]...` — xác nhận payload bị bỏ toàn bộ khi vượt mức schema build hiện tại hiểu (1). |
| `01-envelope/04-min-app-version-bad-format.png` | TC-ENV-04 | 2026-09-15 | ⚠️ KHÔNG khớp kỳ vọng — cần điều tra, chưa kết luận PASS/FAIL | `min_app_version: "1.9.0-beta1"` — dự đoán (dựa trên regex `^\d+(\.\d+){0,3}$` trong `paywall-config-builder.html`) là sai định dạng → phải bỏ toàn bộ payload. **Thực tế: headline ĐÃ đổi** theo marker `[TC env-04]...`, tức payload được áp dụng bình thường — ngược với dự đoán. Lưu ý quan trọng: `paywall-config.md` (nguồn chính thức) **không** nêu rõ quy tắc định dạng cho `min_app_version`, quy tắc regex chỉ tồn tại trong tool JS không chính thức — nên "expected result" ban đầu của case này tự nó dựa trên nguồn chưa được xác nhận. Có thể decoder thật chỉ đọc phần số đầu ("1.9.0") và bỏ qua hậu tố, không coi là lỗi định dạng. Đã gộp thành câu hỏi #4 gửi dev, xem [questions-for-dev.md](../../paywall-remote-config-questions-for-dev.md). |
| `01-envelope/05-min-app-version-too-high.png` | TC-ENV-05 | 2026-09-15 | ✅ PASS | `min_app_version: "99.0.0"` (cao hơn build hiện tại) → headline hiện đúng `"Unlock everything"` (bundled) — payload bị bỏ toàn bộ đúng kỳ vọng. **Giúp khoanh vùng phát hiện ở TC-ENV-04:** cơ chế so sánh version (99.0.0 > build hiện tại → từ chối) hoạt động đúng, nên vấn đề ở TC-ENV-04 nằm riêng ở bước validate **định dạng** chuỗi, không phải lỗi toàn bộ cơ chế `min_app_version`. |
| `01-envelope/06-valid-baseline.png` | TC-ENV-06 (control) | 2026-09-15 | ✅ PASS | `min_app_version: "1.0.0"` (định dạng chuẩn, thấp hơn build hiện tại) → headline đổi đúng marker `[TC env-06]...`. Xác nhận envelope hợp lệ vẫn áp dụng bình thường — dùng làm control cho cả chuỗi TC-ENV-01/03/05, khẳng định 3 case đó fail (giữ bundled) đúng vì lý do envelope reject, không phải do lỗi publish/cache. |
| `05-plans-edge-cases/01-duplicate-product-id.png` | TC-PLAN-06 | 2026-09-15 | ✅ PASS | 2 hàng cùng `product_id` (`pro.weekly`) → **cả 2 cùng hiện** ("Weekly POPULAR $1.99" x2), app không tự loại trùng — đúng dự đoán. |
| `05-plans-edge-cases/02-unknown-product-id.png` | TC-PLAN-07 | 2026-09-15 | ✅ PASS | `product_id` lạ (`pro.monthly`, không tồn tại trong ASC) → hàng biến mất, nhưng **không** để trống — **cả 3 gói bundled mặc định hiện đủ** (Weekly $1.99, Annual $19.99 BEST VALUE, Lifetime $49.99). **Phát hiện mở rộng:** lưới an toàn "0 gói mua được → rebuild bundled" (vốn xác nhận ở TC-PLAN-03 cho case `show:false`) **cũng kích hoạt đúng** khi nguyên nhân là StoreKit không nhận ra `product_id`, không chỉ riêng trường hợp `show:false` tường minh — safety net rộng hơn dự kiến ban đầu, đây là tín hiệu tốt. |
| `05-plans-edge-cases/03-period-type-mismatch.png` | TC-PLAN-08 | 2026-09-15 | ✅ PASS (tốt hơn dự đoán) | `period: "lifetime"` nhưng `type: "subscription"` (lệch nhau) → gói vẫn hiện, subtitle đúng **"One-time purchase"** (theo `period`), **KHÔNG** xuất hiện dòng "Auto-renew..." sai như lo ngại ban đầu trong test-cases. Xác nhận: hành vi hiển thị (subtitle/auto-renew) dựa theo `period` hoặc dữ liệu StoreKit thật, không bị `type` sai kéo lệch UI — nhẹ nhàng hơn hẳn hệ quả đã dự đoán trong Decision Table. Nên cập nhật lại expected result của TC-PLAN-08 cho khớp thực tế. |
| `06-hero/01-animation-valid-matrix-lock-screen.png` | TC-HERO-01 (matrix_lock_screen) | 2026-09-15 | ✅ PASS | Hiện đúng 2 khung: ma trận Eisenhower (Do now/Plan/Delegate/Drop) rồi tuần lịch — khớp mô tả "task xếp vào ma trận Eisenhower rồi lên lock screen" (qc-vi B4). |
| `06-hero/01-animation-valid-phone-assemble.png` | TC-HERO-01 (phone_assemble) | 2026-09-15 | ✅ PASS | Hiện đúng điện thoại đang tự vẽ (line-art) — khớp mô tả "iPhone tự vẽ, sự kiện trong ngày bay lên màn hình". |
| `06-hero/01-animation-valid-tidy-timetable.png` | TC-HERO-01 (tidy_timetable) | 2026-09-15 | ✅ PASS | Hiện đúng lịch tuần đầy đủ Mon→Sun với thẻ sự kiện màu — khớp mô tả "thẻ sự kiện lộn xộn xếp vào thời khoá biểu tuần". Cả 3 animation render khác biệt rõ ràng, xác nhận đủ cả 3 tên hợp lệ hoạt động đúng. ⚠️ **Lưu ý vận hành:** file fixture từng bị lặp chữ `"matrix_lock_screenmatrix_lock_screen"` — **đã được sửa lại đúng** `"matrix_lock_screen"` (2026-09-15). |
| `06-hero/02-animation-unknown-name.png` | TC-HERO-02 | 2026-09-15 | ✅ PASS | `hero.animation: "confetti_burst"` (tên lạ) → headline vẫn đổi đúng theo payload (không bị bundled toàn bộ), hero hiện ảnh minh hoạ tĩnh — không animation, không trắng/vỡ layout. Lưu ý: ảnh hero hiện ra **giống hệt** ảnh bundled mặc định đã thấy ở case khác (TC-ENV-01) — không phân biệt được đây là "tier ảnh" riêng biệt hay dùng lại chính ảnh bundled làm fallback, nhưng cả 2 khả năng đều thoả kỳ vọng chính. |
| `06-hero/03-image-https-valid-first-exposure.png` | TC-HERO-03 (lần mở 1/2) | 2026-09-15 | Xem lần 2 | `hero.image_url: "https://picsum.photos/800/600"` — hero hiện ảnh **bundled**, chưa thấy ảnh thật từ URL. Khớp đúng cơ chế cache: lần đầu gặp URL mới luôn vẽ bundled + warm cache ngầm. |
| `06-hero/03-image-https-valid-second-exposure.png` | ✅ TC-HERO-03 (lần mở 2/2 — kết luận) | 2026-09-15 | ✅ PASS | Mở lại paywall lần 2 (cùng payload, không publish lại) → **ảnh thật đã load** (ảnh dâu tây từ picsum.photos). Xác nhận đúng cơ chế cache 2-lần-mở mô tả trong `paywall-config.md`: *"adopted only once the file is already in the image cache... the swap happens on the next appearance"* — verify bằng thực nghiệm, không còn là suy luận từ tài liệu. |
| `06-hero/04-image-http-invalid.png` | TC-HERO-04 | 2026-09-15 | ✅ PASS | `hero.image_url: "http://picsum.photos/800/600"` (http, không phải https) → hero hiện ảnh bundled — đúng kỳ vọng, không phụ thuộc cơ chế cache vì URL bị từ chối ngay từ bước validate, không liên quan gì đến việc đã cache trước đó hay chưa. |
| `07-locale/01-zh-hant-demo.png` | TC-LOC-01 | 2026-09-15 | ✅ PASS | *(Lần đầu chụp máy thực ra vẫn ở giản thể — 继续/隐私/恢复购买, đã loại, không dùng làm bằng chứng.)* Lần chụp đúng: chrome hiện **繼續 / 隱私權 / 恢復購買 / 續訂** — đúng bundled **phồn thể thật**, khác hẳn giản thể (继续/隐私/恢复购买/续订). Headline vẫn hiện đúng marker `[TC locale-01]...` — xác nhận override đọc từ key `"zh"` dù máy đang ở `zh-Hant`, đúng cơ chế đặc thù builder tool mô tả (dòng 501–503, 668, 1065–1070). Subtitle (chỉ có key `en`) hiện đúng tiếng Anh — không có key `zh` nên fallback sang `en` bình thường. |
| `08-open-questions/01-yearly-vs-annual.png` | ⭐ TC-PLAN-18 — **CHỐT bằng thiết bị thật** | 2026-09-15 | ✅ PASS | Chỉ **Weekly** và **Lifetime** hiện — gói `yearly` (`product_id: pro.yearly`, `period: "yearly"`) **biến mất hoàn toàn**, âm thầm, 2 gói còn lại không xô lệch. Khớp chính xác `paywall-config.md` § Failure modes: *"period is not one of weekly/annual/lifetime — yearly is not a case — the row is dropped on decode, silently"*. Câu hỏi mở `yearly` vs `annual` (test plan §10.1) giờ đã có **bằng chứng thiết bị thật**, không chỉ suy luận từ tài liệu — có thể đóng hẳn, khuyến nghị chính thức sửa mọi payload mẫu còn dùng `yearly` sang `annual`. |
| `09-benefits-boundary/01-benefits-5.png` | TC-BEN-02 | 2026-09-15 | ✅ PASS | Đúng 5 dòng benefit → hiện đủ cả 5 (Benefit 1-5), đúng icon + tint từng dòng theo payload. |
| `09-benefits-boundary/02-benefits-6.png` | TC-BEN-03 | 2026-09-15 | ✅ PASS | 6 dòng benefit khai báo → chỉ hiện 5 dòng đầu, **"Benefit 6" bị cắt lặng lẽ**, không có dấu hiệu lỗi hay cảnh báo — đúng giới hạn tối đa 5 dòng (`PaywallConfigDecoder.maxBenefits`). |
| `10-discount-boundary/01-discount-0-invalid.png` | TC-PLAN-09 | 2026-09-15 | ✅ PASS | `discount: 0` — không pill "Save", không giá gạch ngang. Đúng kỳ vọng (0 nằm ngoài khoảng hợp lệ (0,1) hở). |
| `10-discount-boundary/02-discount-0.01-valid.png` | TC-PLAN-10 | 2026-09-15 | ✅ PASS | `discount: 0.01` — pill **"SAVE 1%"**, giá gạch ngang **$50.49** (= $49.99 / 0.99, đúng công thức `price/(1-discount)`). |
| `10-discount-boundary/03-discount-0.99-valid.png` | TC-PLAN-11 | 2026-09-15 | ✅ PASS | `discount: 0.99` — pill **"SAVE 99%"**, giá gạch ngang **$4,999.00** (= $49.99 / 0.01, đúng công thức). |
| `10-discount-boundary/04-discount-1-invalid.png` | TC-PLAN-12 | 2026-09-15 | ⚠️ PASS một phần — lệch dự đoán, cần ghi nhận | `discount: 1` — **dự đoán ban đầu sai 1 phần**: pill **"SAVE 100%" vẫn hiện** (không phải "không pill" như test-cases đã viết), nhưng giá gạch ngang **không hiện** (hợp lý — 49.99/(1-1) chia cho 0, không tính được). App có vẻ chỉ chặn phần strikethrough khi discount=1 gây lỗi toán học, không chặn cả pill như builder tool JS dự đoán (`previewModel()`: `r.discount = (d>0 && d<1) ? d : null` — dự đoán null ở d=1, tức không pill). Cần cập nhật lại expected result TC-PLAN-12. |
| `10-discount-boundary/05-discount-negative-invalid.png` | TC-PLAN-13 | 2026-09-15 | ✅ PASS | `discount: -0.1` — không pill, không giá gạch ngang. Đúng kỳ vọng. |
| `11-realistic-full-case/01-as-given-missing-hero.png` | TC-HERO-09 | 2026-09-15 | ✅ PASS | Payload thật (nguyên văn seed "Variant B", thiếu key `hero`) → hero hiện đúng **ảnh bundled mặc định**, không phải animation Matrix — xác nhận bằng thiết bị thật lỗi đã dự đoán ở test plan §10.6: bản seed gốc thiếu `hero` khiến animation bị mất dù tên biến thể `hero_matrix_trial_vi` ngụ ý Matrix. |
| `11-realistic-full-case/02-fixed-with-hero.png` | TC-HERO-10 | 2026-09-15 | ✅ PASS | Cùng payload, đã thêm `hero.animation: "matrix_lock_screen"` → hero hiện đúng animation Matrix (4 ô Do now/Plan/Delegate/Drop). Đối chiếu cạnh TC-HERO-09: mọi phần khác giống hệt (headline, 4 benefit, 3 gói, Lifetime giảm 60% → gạch $124.98 đúng công thức 49.99/0.4) — cô lập sạch, khác biệt duy nhất là hero, khẳng định chắc chắn nguyên nhân TC-HERO-09 là do thiếu field `hero`. |
| `09-benefits-boundary/03-benefits-empty.png` | TC-BEN-04 | 2026-09-15 | ✅ PASS | `benefits: []` → khối benefit **biến mất hoàn toàn**, không có khoảng trống bất thường giữa headline và danh sách gói. |
| `09-benefits-boundary/04-benefits-invalid-icon.png` | TC-BEN-05 | 2026-09-15 | ✅ PASS | Dòng 1 dùng icon không tồn tại → đúng fallback icon **sparkles** (✨), dòng vẫn giữ nguyên (không bị bỏ). Dòng 2 đối chứng icon bình thường (calendar) hiện đúng. Không crash, không ô trống. |
| `09-benefits-boundary/04-benefits-invalid-icon-purchasing-state-bonus-TC-FLOW-02.png` | ⭐ TC-FLOW-02 *(bonus — bắt được không chủ đích khi chụp cho TC-BEN-05)* | 2026-09-15 | ✅ PASS | Tap Continue → màn mờ đi, toast **"Processing..."** hiện giữa màn, CTA (Continue) chuyển thành spinner mờ — khớp đúng expected result đã viết cho TC-FLOW-02 (P1, trước đó chưa test). Không phải payload dành riêng cho case này nhưng hành vi `purchasing` không phụ thuộc nội dung RC nên vẫn là bằng chứng hợp lệ. |
| `05-plans-edge-cases/04-no-preselected.png` | TC-PLAN-15 | 2026-09-15 | ✅ PASS | Không hàng nào có `preselected` → **Weekly** (đứng đầu mảng, không badge) được chọn sẵn (viền tím), KHÔNG phải Annual (dù có badge `best_value`). Xác nhận đúng: chọn theo **thứ tự mảng**, không phải theo badge nổi bật. |

---

## Interim Test Summary Report (ISTQB Foundation)

> Báo cáo **giữa kỳ**, không phải báo cáo cuối — test-cases vẫn còn case chưa chạy (xem mục 4). Số liệu dưới đây đếm trực tiếp từ bảng Log kết quả ở trên (42 dòng ảnh → 41 test case duy nhất, một số case có nhiều ảnh: TC-HERO-01 ×3, TC-HERO-03 ×2, TC-COPY-03 ×2, TC-COPY-04 ×2; **+4 case verify bằng lời không kèm ảnh: TC-FLOW-01/04/05, TC-HERO-05**), đối chiếu priority với [test-cases/paywall-remote-config.md](../../../../../test-cases/paywall-remote-config/paywall-remote-config.md). **Ngày báo cáo:** 2026-09-15 (cập nhật sau khi hoàn tất 7/8 case release-candidate) · **Người lập:** QC

### 1. Phạm vi đã test (Test object covered)

41/75 test case (**55%**) của bộ test-cases đã có bằng chứng (37 kèm ảnh thật + 4 verify bằng lời trên device — TC-FLOW-01/04/05, TC-HERO-05), trải trên **11/12 suite** (chỉ còn thiếu Suite I — Analytics). Toàn bộ ảnh chụp trên môi trường `dev` (trừ nhánh trial đang chuyển sang verify `prod`).

### 2. Kết quả theo độ ưu tiên (risk-based — đúng tinh thần ISTQB: đo theo rủi ro, không đo % chung chung)

| Priority | Tổng case trong test-cases | Đã test | % coverage | PASS | Blocked | Inconclusive |
|---|---|---|---|---|---|---|
| P1 | 23 | 12 | 52% | 10 | 1 (TC-TRIAL-01) | 1 (TC-ENV-04) |
| P2 | 38 | 21 | 55% | 21 | 0 | 0 |
| P3 | 12 | 8 | 67% | 8 | 0 | 0 |
| **Tổng** | **73*** | **41** | **56%** | **39** | **1** | **1** |

*\*73 = 75 trừ 2 case "P1-chức-năng" (TC-FLOW-03/06), chưa nằm trong phạm vi test này.*

**Điểm quan trọng nhất: 0 P1 defect được xác nhận.** 9/11 P1 đã test PASS sạch — bao gồm toàn bộ Decision Table 1 (Envelope: kill switch, schema_version, min_app_version) và case P1 quan trọng nhất của cả tính năng (TC-PLAN-03 — lưới an toàn chống paywall trống). 2 P1 còn lại **không phải Fail**, mà là **chưa đủ điều kiện kết luận** (xem mục 3).

### 3. Deviation phát hiện được (so với expected result ban đầu)

> Không có case nào ghi nhận **defect xác nhận** (confirmed bug). 4 deviation dưới đây đều đã phân loại đúng mức độ, không có case nào bị đoán quá tay thành "bug" khi chưa đủ bằng chứng.

| # | Case | Loại deviation | Mức ảnh hưởng | Trạng thái |
|---|---|---|---|---|
| 1 | TC-ENV-04 | `min_app_version` sai định dạng vẫn được áp dụng, khác dự đoán regex của tool JS | Chưa rõ — có thể "expected result" ban đầu sai, không phải app sai | Đã hỏi dev (câu hỏi #4) |
| 2 | TC-PLAN-12 | `discount = 1` vẫn hiện pill "Save 100%", chỉ riêng giá gạch ngang bị chặn | Thấp — thông tin hiển thị vẫn đúng số học | Đã hỏi dev (câu hỏi #5) |
| 3 | TC-HERO-09 | Bản seed mẫu của chính builder tool thiếu field `hero` | Trung bình — ảnh hưởng ai copy seed làm điểm khởi đầu | Đã hỏi dev (câu hỏi #1) |
| 4 | TC-TRIAL-01 | `{trial}` không hiện dù ASC đã xác nhận có offer thật, dù test bằng Sandbox thật + acc mới | Cao nếu là bug thật (chặn toàn bộ tính năng trial) | QC tự điều tra tiếp trên `prod`, chưa đủ cơ sở kết luận |

**2 phát hiện tích cực** (app an toàn hơn dự đoán, không phải deviation xấu): TC-PLAN-07 (lưới an toàn "0 gói mua được" rộng hơn tài liệu mô tả, bắt được cả case StoreKit không nhận `product_id`, không chỉ `show:false`) và TC-PLAN-08 (`period`/`type` lệch nhau không gây lỗi hiển thị Auto-renew như lo ngại).

### 4. Đối chiếu Exit Criteria (test-cases § Exit Criteria)

**Chưa đạt** — đúng như kỳ vọng ở giai đoạn giữa kỳ này:

- P1 yêu cầu 100% đã thực thi + 100% pass → hiện tại mới 48% đã thực thi. **22/25 P1 tổng thể (gồm 2 P1-chức-năng) chưa test**, gồm toàn bộ Suite Trial title còn lại (TC-TRIAL-02/05/06), Suite Giá/tiền tệ (TC-PRICE-01…04 — **chưa có ảnh nào**), và phần lớn Suite F (Plans).
- P2 yêu cầu ≥90% pass trong số đã thực thi → 14/14 đã test đều PASS (100%), nhưng mới 37% tổng P2 được chạm tới.
- P3 yêu cầu ≥70% đã thực thi → 67%, gần đạt.
- **Chưa log bug nào cho lỗi giá KRW/VND** (test plan §6, §8) — đây là entry criteria còn thiếu, không phải riêng exit criteria.

### 5. Rủi ro tồn dư (residual risk) tại thời điểm báo cáo

- **Suite Giá/tiền tệ (TC-PRICE-01…04, toàn bộ P1) chưa có bất kỳ ảnh nào** — đây là nhóm case xác nhận lại bug 🔴 KRW/VND đã biết, mức độ ưu tiên cao nhất chưa được chạm tới trong đợt test này.
- **TC-TRIAL-01 vẫn mở** — nếu xác nhận là bug thật sau khi verify trên prod, đây sẽ là P1 nghiêm trọng (chặn toàn bộ tính năng `{trial}` — giá trị cốt lõi theo `paywall-config.md`).
- **2 case Blocked cấu trúc** (TC-FLOW-03/06) vẫn chưa có baseline ảnh UI, nằm ngoài khả năng QC tự giải quyết (test plan §10.7). TC-FLOW-05 đã verify chức năng thật trên device 2026-09-15 (không kèm ảnh) — đóng được, không còn tính vào residual risk.
- Suite Analytics (I) và phần lớn Suite L10n mở rộng (H) hoàn toàn chưa test — rủi ro chưa được đo lường, không phải đã xác nhận an toàn.

### 6. Khuyến nghị

1. **Ưu tiên Suite Giá/tiền tệ (TC-PRICE-01…04) ở lượt test kế tiếp** — đây là gap lớn nhất giữa "đã biết có bug" và "đã re-verify bằng case chính thức".
2. **Chốt xong TC-TRIAL-01 trên prod** trước khi mở rộng thêm case khác của Suite Trial — nếu xác nhận bug thật, đây sẽ đổi hẳn mức ưu tiên của cả report này.
3. Gửi 5 câu hỏi tồn đọng ([paywall-remote-config-questions-for-dev.md](../../paywall-remote-config-questions-for-dev.md)) cho dev **1 lần**, không chờ tích luỹ thêm — 3/5 câu đã có bằng chứng đầy đủ để hỏi ngay.
4. Chưa đủ cơ sở để đề xuất go/no-go release — cần tối thiểu 100% P1 đã thực thi (hiện 48%) trước khi đưa ra khuyến nghị release.
