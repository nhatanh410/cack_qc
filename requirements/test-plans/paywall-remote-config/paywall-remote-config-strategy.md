# Test Strategy — Paywall Remote Config (`pro_paywall_config_v1`)

> **Phân biệt với 2 tài liệu đã có:** đây là **Test Strategy** (ISTQB Foundation) — trả lời "**vì sao** chọn cách tiếp cận này", tổng quát hơn và ổn định hơn theo thời gian. [Test Plan](paywall-remote-config.md) trả lời "**làm gì, khi nào, ai làm**" cho vòng test hiện tại. [Test Cases](../../../test-cases/paywall-remote-config/paywall-remote-config.md) là mức thực thi cụ thể nhất. Cả 3 dùng chung 1 bộ [test data](paywall-remote-config-payloads/).
> **Ngày lập:** 2026-09-14 · **Người lập:** QC

---

## 1. Bối cảnh quyết định chiến lược

- **QC không có quyền vào code** — mọi kỹ thuật white-box đều loại khỏi phạm vi ngay từ đầu, không phải lựa chọn mà là ràng buộc.
- **Đây là lớp nội dung (content layer) trên app đã build sẵn** — logic decoder cố định trong binary, chỉ dữ liệu JSON đổi qua Firebase. Mỗi lần publish RC là một "bản phát hành nội dung" độc lập với chu kỳ release app.
- **Không có UI baseline đầy đủ** — thiếu ảnh cho 5/8 trạng thái của chính màn paywall (`unlocked`, lỗi thanh toán, Restore purchases, `locked`, Annual đang chọn) — loại bỏ khả năng dùng thuần specification-based-từ-ảnh như các test plan khác trong dự án (vd `1.2.15-decoration-inkai.md` dựa hoàn toàn vào screenshot).
- **Có 1 "oracle thay thế" không chính thức** — `paywall-config-builder.html` đóng vai trò đặc tả hành vi (`checks()`/`emit()`) thay cho `paywall-config.md` bị thiếu trong repo, nhưng tự nhận rủi ro lệch tay với decoder thật (test plan §10.2). Chiến lược phải tính đến việc oracle này có thể sai.

## 2. Chiến lược tổng thể — tổ hợp đa mô hình, không chọn 1 loại thuần

> ISTQB Foundation liệt kê các nhóm generic test strategy (analytical, model-based, methodical, process-compliant, dynamic/heuristic, consultative, regression-averse). Feature này dùng **tổ hợp có chủ đích**, mỗi loại phủ đúng phần nó mạnh nhất — không dùng 1 chiến lược duy nhất cho toàn bộ.

| Loại chiến lược | Áp dụng ở đâu | Vì sao chọn |
|---|---|---|
| **Analytical — risk-based** | Toàn bộ phân bổ P1/P2/P3 ([test plan §6](paywall-remote-config.md#6-risk-based-prioritization), [test-cases § Phân bổ độ ưu tiên](../../../test-cases/paywall-remote-config/paywall-remote-config.md#phân-bổ-độ-ưu-tiên)) | Feature có rủi ro tài chính/pháp lý thật (App Store Guideline 3.1.2, mất doanh thu nếu paywall trống) — phải test theo **mức thiệt hại**, không dàn đều 73 case như nhau |
| **Model-based / specification-based (black-box)** | Suite Envelope, Plans, Trial-title — 4 Decision Table + BVA dựng trực tiếp từ `checks()` | `checks()` là đặc tả hành vi tường minh nhất hiện có (dù không chính thức) — đúng loại input rời rạc, có ngưỡng rõ ràng mà EP/BVA/Decision Table phát huy tối đa |
| **Methodical — checklist-based** | Kế thừa nguyên B1–B9 của `paywall-qc-vi.md` thay vì viết lại | Đã tồn tại, đã đúng ở mức thao tác — viết lại từ đầu là lãng phí, chiến lược ưu tiên **tái dùng tài sản đã có** trước khi tạo mới |
| **Reactive / heuristic — exploratory** | Mục 5 test plan: đổi ngôn ngữ giữa chừng, spam tap lúc `purchasing`, tổ hợp ≥2 lỗi envelope cùng lúc | Dành riêng cho vùng **không tài liệu nào** (kể cả `checks()`) nói tới hành vi — cố tình giới hạn phạm vi exploratory để không dùng nó thay cho việc thiết kế case có hệ thống |
| **Regression-averse** | Bộ 30 fixture JSON trong `paywall-remote-config-payloads/`, dùng lại nguyên vẹn mỗi lần RC đổi | Mỗi lần publish RC = 1 content release mới, cần bộ regression pack **sẵn sàng chạy ngay**, không viết lại case mỗi đợt |
| **Consultative / directed** | [Test plan §10](paywall-remote-config.md#10-gap-cần-làm-rõ-trước-khi-execute) — đưa câu hỏi ngược cho dev/PO thay vì tự suy diễn | Nhiều quyết định (`yearly` vs `annual`, độ tin cậy của builder tool, dòng Auto-renew có chủ ý hay không) **vượt thẩm quyền QC tự quyết** |

## 3. Test level strategy

- **Chỉ System testing (black-box)**, qua Firebase project `dev` rồi `prod`, trên build TestFlight — không có Component/Integration vì QC không có quyền code, khác hẳn cách tiếp cận đã dùng cho `12_ai-assistant` (nơi có backend riêng nên bắt buộc đủ 4 cấp, xem [ai-assistant-tab.md §4](../ai-assistant/ai-assistant-tab.md#4-test-levels--types)).
- **Không có Acceptance level tách riêng theo kiểu "release 1 lần"** — vì đây là content layer vận hành liên tục, không phải feature ra mắt 1 lần. Thay vào đó, **mỗi lần publish 1 variant RC coi như 1 vòng acceptance thu nhỏ**: phải qua lại entry criteria (test plan §8) trước khi variant đó được coi là "sẵn sàng chạy A/B thật", không chỉ chạy 1 lần cho tất cả các variant tương lai.

## 4. Vì sao chọn tổ hợp kỹ thuật thiết kế case này (test plan §5)

- **Ưu tiên tuyệt đối black-box specification-based** (Equivalence Partitioning, Boundary Value Analysis, Decision Table, State Transition) vì input là **JSON có schema tường minh, có ngưỡng số rõ ràng** (`schema_version`, `discount`, độ dài chuỗi, số dòng benefit) — đây đúng loại dữ liệu 4 kỹ thuật này phát huy tối đa, hiệu quả hơn hẳn so với việc chỉ dựa vào checklist thao tác.
- **Loại white-box hoàn toàn khỏi lựa chọn** — không phải vì kém phù hợp mà vì **không khả thi** (không có quyền code), khác với quyết định "chọn không dùng" mang tính chiến lược thật sự.
- **Giới hạn phạm vi exploratory có chủ đích** — chỉ áp dụng cho phần thật sự thiếu đặc tả (mục 2, dòng "Reactive/heuristic"), tránh biến exploratory thành lối tắt để né việc thiết kế case có hệ thống — đúng nguyên tắc chiến lược, không phải giới hạn về nhân lực.

## 5. Test data strategy

- **1 bộ fixture cố định, version-hoá trong repo**, không dựng lại thủ công mỗi lần test — mỗi file cô lập đúng **1 biến số duy nhất** ("one reason to fail"), giúp một case fail chỉ trỏ về đúng 1 nguyên nhân, không phải đoán giữa nhiều field cùng đổi.
- **Không dùng dữ liệu thật của user** trong bộ fixture mới — cách ly hẳn khỏi rủi ro đã phát hiện ở ảnh cũ (email tester lộ trong `08_paywall_02_storekit-sheet_system-dialog.png`).
- Test data và test case **tách file vật lý riêng** (`paywall-remote-config-payloads/` vs `test-cases/`) thay vì nhúng JSON trực tiếp vào từng case — cho phép sửa 1 payload mà không phải sửa lại toàn bộ tài liệu case.

## 6. Automation strategy — hiện tại 0%, có chủ đích, không phải thiếu sót

- **Không tự động hoá** vì 3 lý do: (a) QC không có cách launch/điều khiển app qua script, (b) thay đổi là remote-config, không gắn với build/CI nào để hook vào, (c) tần suất đổi RC hiện tại chưa đủ cao để chi phí viết + bảo trì automation vượt qua chi phí test tay 73 case.
- **Đề xuất nâng cấp nếu tần suất RC tăng:** biến `checks()` (đang chỉ là công cụ preview trong trình duyệt) thành **gate pre-publish thật** — chạy validate JSON tự động trước khi cho phép dán vào Firebase Console, giảm phụ thuộc vào việc con người nhớ tự kiểm tra bằng tay. Đây là bước automation rẻ nhất vì logic JS đã viết sẵn, chỉ cần đổi nơi chạy.
- Ranh giới rõ ràng: **automation hoá việc validate config** là hợp lý và rẻ; **automation hoá việc "nhìn thấy đúng UI paywall"** vẫn cần con người vì đây là màn hình bán hàng, thay đổi trực quan quan trọng hơn khả năng chạy nhanh.

## 7. Rủi ro của chính chiến lược này (khác risk của feature)

- ~~**Toàn bộ mục 5 test plan phụ thuộc vào 1 oracle không chính thức**~~ — **✅ Giảm đáng kể 2026-09-14:** `paywall-config.md` (runbook kỹ thuật chính thức) đã xuất hiện và đối chiếu khớp với `checks()` ở mọi rule kiểm tra được (envelope, `period` whitelist, benefits cap, discount range, `{trial}` logic). Đúng như chiến lược "consultative" ở mục 2 dự tính: câu hỏi đưa ngược cho dev (test plan §10, đặc biệt `yearly`/`annual` và Auto-renew điều kiện) đã có câu trả lời bằng văn bản, không phải tự đoán. **Rủi ro tập trung không biến mất hoàn toàn** — vẫn tìm thấy 1 điểm lệch thật giữa 2 nguồn ngay trong lần đối chiếu đầu tiên (bản seed "Variant B" của builder tool thiếu `hero`, xem test plan §10.6) — nên vẫn giữ nguyên tắc "đối chiếu 2 nguồn độc lập trước khi tin", chỉ là mức độ tin tưởng vào `checks()` nay có cơ sở hơn, không còn là giả định trần trụi.
- **0% automation nghĩa là chi phí lặp lại cao** — mỗi lần RC đổi là một vòng test tay đầy đủ lại từ đầu (dù có fixture sẵn, vẫn cần người publish + kill app + quan sát từng case). Chiến lược này đánh đổi **tốc độ triển khai ban đầu** (không cần đầu tư hạ tầng automation) lấy **chi phí vận hành dài hạn cao hơn** — cần chủ động theo dõi xem đánh đổi này còn hợp lý không khi tần suất đổi RC tăng.
- **Test data cô lập từng biến số (mục 5) đơn giản hoá debug nhưng không phủ được tổ hợp nhiều lỗi cùng lúc** — đã ghi nhận đúng ở test plan §5/§10.7 như một giới hạn có chủ đích, không phải lỗ hổng bị bỏ sót.

## 8. Khi nào cần review lại chiến lược này

| Điều kiện xảy ra | Cần đổi gì trong chiến lược |
|---|---|
| `paywall-config.md` (tài liệu kỹ thuật chính thức) xuất hiện trong repo | Chuyển oracle chính từ `checks()` sang tài liệu chính thức, hạ mức rủi ro tập trung ở mục 7 |
| Tần suất publish RC tăng đáng kể (vd nhiều A/B test chạy song song mỗi tuần) | Cân nhắc đầu tư automation validate JSON (mục 6) — điểm hoà vốn đã tới gần hơn |
| Paywall có thêm backend riêng (quota, personalization server-side) | Bổ sung Component/Integration test level, không còn chỉ System testing thuần black-box (mục 3) |
| 5 màn hình còn thiếu ảnh baseline đã được chụp | Suite L (state transition) chuyển từ dựa exploratory/chức năng sang dùng được specification-based-từ-ảnh như phần còn lại của dự án |
