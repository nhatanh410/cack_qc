# Payload test data — Paywall Remote Config

32 file JSON — 30 file cô lập đúng 1 biến số đang test, cộng 2 file "realistic full case" (mục 11)
dựng từ config mẫu thật do dev cung cấp — dán thẳng vào Firebase Console (Remote
Config → `pro_paywall_config_v1`, theo [paywall-qc-vi.md §A2](../../specs/paywall-qc-vi.md#a2-tạo-parameter))
để chạy từng case trong [paywall-remote-config.md §5](../paywall-remote-config.md#5-kỹ-thuật-thiết-kế-test-case).

**Chụp lại kết quả thật khi test?** → [`screenshots/`](screenshots/) — cùng cấu trúc thư mục, tên file
khớp `.json` ↔ `.png`, kèm bảng log PASS/FAIL.

**⚠️ Trước khi dùng bất kỳ file nào:** verify build đang test có commit `c711ceb4`+ (`paywall-qc-vi.md`
A0) — build cũ hơn đọc `pro_paywall_config_v1` **vô tác dụng**, và mọi file dưới đây sẽ trông như
"không đổi gì" giống hệt case envelope-reject, dễ kết luận nhầm.

**Cách dùng:**
1. Copy nguyên nội dung 1 file `.json` → dán vào ô value của parameter → **Publish changes**.
2. Kill app hoàn toàn → mở lại. **Trên dev** (`minimumFetchInterval = 0`) là đủ. **Trên prod**
   (`minimumFetchInterval = 3600` = 1 tiếng), kill+mở lại trong vòng 1 tiếng **không** lấy được giá trị
   mới — cách chắc chắn duy nhất là gỡ app rồi cài lại (`paywall-qc-vi.md` A6).
3. Mọi file đều có `headline.en` bắt đầu bằng `[TC ...]` nói rõ **kỳ vọng** (PHẢI hiện / KHÔNG được
   hiện / control) — không cần mở lại test plan để nhớ case đang test là gì.
4. Test xong 1 file, ghi PASS/FAIL vào bảng dưới trước khi chuyển file kế — các file **không** tự
   sinh case tiếp theo, phải publish thủ công từng cái một (mỗi lần publish là 1 lần kill+mở app).

**Không thuộc bộ file này:** case JSON sai cú pháp (B6, mục cuối) — cố tình gõ tay 1 đoạn JSON hỏng
thẳng vào Console (vd thiếu dấu `}`), vì mọi trình soạn thảo local sẽ tự chặn/tự sửa JSON không hợp lệ.

---

## ⭐ Release gấp, chỉ còn thời gian test tối thiểu? — 8 case bắt buộc

> P1 tạm skip (chờ verify trên prod). Trong số P2/P3 chưa chạy, đây là 8 case **không nên bỏ qua** dù thời
> gian gấp — lọc theo risk-based: case chưa được inferred gián tiếp từ ảnh đã có, là cấu hình RC dễ xảy ra
> thật ngoài đời, hoặc lỗi sẽ chặn/user-facing. Chi tiết lý do từng case: xem hội thoại QC 2026-09-15.

| # | Case | Cần config mới? | Test data | Trạng thái |
|---|---|---|---|---|
| 1 | TC-FLOW-01 (tap chọn gói → đổi viền + Auto-renew) | Không, dùng lại | `02-plans-fallback/04-plans-normal.json` — có đủ 3 loại gói (weekly/annual sub, lifetime) để thấy Auto-renew bật/tắt đúng | ✅ PASS (chức năng, verify bằng lời trên device) |
| 2 | TC-FLOW-04 (huỷ sheet StoreKit → quay về đúng trạng thái) | Không, dùng lại | Bất kỳ payload hợp lệ nào, vd `02-plans-fallback/04-plans-normal.json` — thao tác tay: mở sheet StoreKit rồi Cancel/vuốt xuống | ✅ PASS (chức năng, verify bằng lời trên device) |
| 3 | TC-FLOW-05 (Restore purchases) | Không, dùng lại | Bất kỳ payload — thao tác tay bằng tài khoản **đã mua trước đó**, không phụ thuộc nội dung RC | ✅ PASS (chức năng, verify bằng lời trên device) |
| 4 | TC-HERO-05 (nút ✕ luôn bấm được) | Không, dùng lại | Thử ✕ trên vài payload hero đã có: `06-hero/01-animation-valid.json`, `06-hero/03-image-https-valid.json` | ✅ PASS (chức năng, verify bằng lời trên device) |
| 5 | TC-BEN-04 (`benefits: []` → ẩn khối) | ✅ Có | [`09-benefits-boundary/03-benefits-empty.json`](09-benefits-boundary/03-benefits-empty.json) | ✅ PASS |
| 6 | TC-BEN-05 (icon sai tên → fallback `sparkles`) | ✅ Có | [`09-benefits-boundary/04-benefits-invalid-icon.json`](09-benefits-boundary/04-benefits-invalid-icon.json) | ✅ PASS *(bonus: ảnh cùng lượt chụp cũng xác nhận luôn TC-FLOW-02 — trạng thái `purchasing`)* |
| 7 | TC-PLAN-15 (không `preselected` nào → tự chọn gói đầu mảng) | ✅ Có | [`05-plans-edge-cases/04-no-preselected.json`](05-plans-edge-cases/04-no-preselected.json) | ✅ PASS |
| 8 | TC-PLAN-16 (Lifetime không cần cuộn trên máy nhỏ) | Không, dùng lại | `02-plans-fallback/04-plans-normal.json`, test trên **iPhone SE hoặc 13 mini** — đây là test thiết bị, không phải test config | ⬜ **Chưa test — chưa có thiết bị** |

**Tiến độ: 7/8 PASS** (+ 1 bonus TC-FLOW-02 ngoài danh sách 8 case). Chỉ còn **TC-PLAN-16** — riêng case này cần đúng thiết bị màn nhỏ (iPhone SE/13 mini), chưa có sẵn để test, không phải do quên hay do config thiếu.

---

## 01-envelope — Decision Table 1

| File | Biến số đang cô lập | Kỳ vọng |
|---|---|---|
| `01-kill-switch-on.json` | `use_bundled_paywall: true` | Bỏ toàn bộ, hiện paywall bundled — headline KHÔNG đổi |
| `02-schema-version-not-integer.json` | `schema_version: 0` | Coi như vắng mặt (= v1) — headline PHẢI đổi |
| `03-schema-version-too-high.json` | `schema_version: 2` | Bỏ toàn bộ payload — headline KHÔNG đổi |
| `04-min-app-version-bad-format.json` | `min_app_version: "1.9.0-beta1"` | Sai regex → bỏ toàn bộ payload |
| `05-min-app-version-too-high.json` | `min_app_version: "99.0.0"` | Build hiện tại < min → bỏ toàn bộ payload |
| `06-valid-baseline.json` | envelope hợp lệ | **Control** — headline PHẢI đổi, dùng để chắc chắn 5 case trên fail vì đúng lý do, không phải do publish/cache lỗi |

## 02-plans-fallback — Decision Table 2

| File | Kỳ vọng |
|---|---|
| `01-plans-not-declared.json` | Không gửi `plans` → app đọc key cũ `pro_plan_config` |
| `02-plans-all-invalid-rows.json` | 0 hàng hợp lệ → `pro_plan_config`, rồi bundled |
| `03-plans-all-hidden-CRITICAL.json` | ⭐ **P1** — 3 hàng hợp lệ nhưng `show:false` hết → app phải tự dựng lại bằng danh sách bundled, **không được trống** |
| `04-plans-normal.json` | Control — 3 gói hiện bình thường, Annual `preselected` |

## 03-trial-title — Decision Table 3

> Cần test bằng **2 loại Apple ID**: chưa dùng thử bao giờ, và đã hết hạn dùng thử (qc-vi.md "Chuẩn bị").

| File | Trên tài khoản còn trial | Trên tài khoản hết trial |
|---|---|---|
| `01-trial-with-fallback.json` | "Get 3-day free trial" (số ngày thật từ StoreKit) | "Weekly plan" |
| `02-trial-missing-fallback-CRITICAL.json` | "Get 3-day free trial" | ⭐ **P1 — rơi về tên gói bundled**, không phải tên đã đặt trong RC |
| `03-title-no-trial-only.json` | Tên gói bundled (vì không có `title` cho nhánh có trial) | "Weekly (no trial wording)" |

## 04-empty-field-asymmetry — Decision Table 4

> Đổi ngôn ngữ máy sang **Tiếng Việt** trước khi test 2 file này.

| File | Kỳ vọng trên máy vi |
|---|---|
| `01-headline-empty-vi.json` | Headline hiện **chữ bundled hard-code** ("Unlock everything" bản dịch vi), KHÔNG phải chuỗi `en` đã set trong file, KHÔNG phải khoảng trắng |
| `02-subtitle-empty-vi.json` | Dòng subtitle **biến mất hoàn toàn** — không fallback về bundled như headline |

## 05-plans-edge-cases

| File | Kỳ vọng |
|---|---|
| `01-duplicate-product-id.json` | Cả 2 hàng cùng hiện (app không tự loại trùng) — chỉ cảnh báo ở tool builder, verify app thật có bug hiển thị 2 dòng giống hệt nhau không |
| `02-unknown-product-id.json` | Nếu id không tồn tại trên App Store Connect thật, StoreKit trả rỗng → hàng biến mất khỏi màn hình |
| `03-period-type-mismatch.json` | CTA / dòng auto-renew hiển thị sai (vì logic dựa vào `type`, không phải `period`) — quan sát xem có tự "Auto-renew. Cancel anytime." dù đây phải là gói mua đứt |
| `04-no-preselected.json` **(mới)** — TC-PLAN-15, P2, mandatory nếu release gấp | Không hàng nào có `preselected` → gói **Weekly** (đứng đầu mảng) phải được chọn sẵn, KHÔNG phải Annual dù Annual có badge `best_value`. Cố ý đặt Weekly (không badge) lên đầu để tách bạch "chọn theo thứ tự mảng" khỏi "chọn theo badge nổi bật" |

## 06-hero

| File | Kỳ vọng |
|---|---|
| `01-animation-valid.json` | Hiện animation `matrix_lock_screen` — đổi giá trị `hero.animation` để test 2 tên còn lại (`tidy_timetable`, `phone_assemble`) |
| `02-animation-unknown-name.json` | Tên lạ → rơi xuống tier ảnh (không phải bundled hoàn toàn) — verify đúng hành vi này, không phải màn trắng |
| `03-image-https-valid.json` | Hiện ảnh từ URL |
| `04-image-http-invalid.json` | Bị bỏ qua vì không phải https → dùng ảnh bundled mặc định |

## 07-locale

| File | Kỳ vọng |
|---|---|
| `01-zh-hant-demo.json` | Máy đặt ngôn ngữ **繁體中文 (zh-Hant)**: đọc **chuỗi bundled zh-Hant** cho phần không override, nhưng override headline lấy từ map `zh` (không phải `zh-Hant`) — verify đúng dòng `[TC locale-01]` xuất hiện trên máy zh-Hant dù key trong JSON là `"zh"` |

## 08-open-questions — ✅ đã CHỐT 2026-09-14, giữ tên thư mục để không phá link cũ

| File | Mục đích |
|---|---|
| `01-yearly-vs-annual.json` | **Không còn là câu hỏi mở** — `paywall-config.md` § Failure modes xác nhận thẳng "yearly is not a case", hàng bị loại âm thầm khi decode, các hàng khác không đổi. File này giờ là **regression check** (TC-PLAN-18): publish, xác nhận đúng 2 gói weekly/lifetime còn lại vẫn hiện bình thường — nếu chúng cũng biến mất theo thì khác tài liệu, cần báo ngay |

## 09-benefits-boundary

| File | Kỳ vọng |
|---|---|
| `01-benefits-5.json` | Đủ 5 dòng lợi ích |
| `02-benefits-6.json` | Chỉ hiện 5 dòng đầu, "Benefit 6" bị cắt lặng lẽ |
| `03-benefits-empty.json` **(mới)** — TC-BEN-04, P2, mandatory nếu release gấp | `benefits: []` → khối benefit **ẩn hẳn**, không có khoảng trống bất thường giữa headline và danh sách gói |
| `04-benefits-invalid-icon.json` **(mới)** — TC-BEN-05, P2, mandatory nếu release gấp | Dòng 1 dùng icon không tồn tại → phải fallback icon `sparkles`, **giữ nguyên dòng** (không bị bỏ, không crash, không ô trống). Dòng 2 là đối chứng icon bình thường |

## 10-discount-boundary

> Dùng gói Lifetime — chỉ loại gói `lifetime` mới hiện giá gạch ngang khi có discount hợp lệ.

| File | `discount` | Kỳ vọng |
|---|---|---|
| `01-discount-0-invalid.json` | 0 | Không pill "Save", không giá gạch ngang |
| `02-discount-0.01-valid.json` | 0.01 | Có pill "Save 1%" + giá gạch ngang |
| `03-discount-0.99-valid.json` | 0.99 | Có pill "Save 99%" + giá gạch ngang |
| `04-discount-1-invalid.json` | 1 | Không pill, không giá gạch ngang |
| `05-discount-negative-invalid.json` | -0.1 | Không pill, không giá gạch ngang |

## 11-realistic-full-case

> Nguồn: payload "Variant B" hard-code sẵn trong hàm `seed()` của `paywall-config-builder.html` (dòng 617–644)
> — tức đây là dữ liệu **demo có trong chính mã nguồn của tool**, rất có thể sẽ được ai đó copy làm điểm khởi
> đầu khi soạn payload thật. Khác với 30 file còn lại (mỗi file cô lập đúng 1 biến số), 2 file này là **payload
> đầy đủ, thực tế** — dùng làm control case tổng hợp, đồng thời phát hiện 1 lỗi ngay trong chính bản seed gốc.

| File | Khác biệt | Kỳ vọng |
|---|---|---|
| `01-as-given-missing-hero.json` | Nguyên văn payload gốc — **không có key `hero`**, dù tên `variant` là `hero_matrix_trial_vi` (ngụ ý animation Matrix) | Hero rơi về **ảnh/animation mặc định của app** (bundled), không phải `matrix_lock_screen` — verify đúng hành vi fallback này, đồng thời xác nhận đây là lỗi thật trong bản seed của tool (không phải hành vi cố ý) |
| `02-fixed-with-hero.json` | Thêm `"hero": {"animation": "matrix_lock_screen"}` — đúng như `heroMode`/`heroAnimation` đã set trong `seed()` gốc (chỉ tồn tại ở state nội bộ của tool, không lọt ra `emit()`) | Hero hiện đúng animation Matrix — dùng để **so sánh cạnh nhau** với file `01` nhằm khẳng định khác biệt duy nhất là field `hero` |

**Bằng chứng phụ (đã CHỐT, không còn cần thêm bằng chứng):** cả 2 đều dùng `"period": "annual"` cho gói năm — đây là bằng chứng thứ 2 (cùng với whitelist trong builder) khớp với kết luận chính thức của `paywall-config.md`: `"yearly"` không tồn tại, đó là lỗi đánh máy ở payload mẫu A4 cũ của `paywall-qc-vi.md` (đã tự sửa).

**Ghi chú thêm (2026-09-14, sau khi đọc `paywall-config.md`):** gói weekly được `preselected:true` + badge `popular`, còn gói annual có badge `best_value` nhưng **không** `preselected` — ban đầu tưởng là điểm lạ cần hỏi dev, nhưng `paywall-config.md` mục `plans` xác nhận đây là **thiết kế cố ý**: *"`preselected` picks the row that starts selected. It is split out of `recommended`, which also draws the badge — so preselecting weekly while badging annual is now expressible."* Không cần hỏi lại, không phải anomaly.

---

## Chưa có file — làm bằng tay khi cần

- **Payload sai cú pháp JSON** (test nhánh parse-error của B6) — gõ tay trực tiếp trong Console.
- **Độ dài headline biên 29/30/31 ký tự** và **`variant` biên 36/37 ký tự** — chỉ cần sửa tay 1 field
  trong `06-valid-baseline.json`, không đáng tạo file riêng.
- **Payload chạm ngưỡng cảnh báo kích thước 30 000 bytes** — ghép nhiều locale + 5 benefit + 3 plan
  vào 1 file, dùng `paywall-config-builder.html` (tab JSON → Copy JSON) để đo `sizeMeta` trước khi
  publish thật.
