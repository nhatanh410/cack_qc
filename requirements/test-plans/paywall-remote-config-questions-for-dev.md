# Câu hỏi tồn đọng gửi dev — Paywall Remote Config

> Gộp từ [test plan §10](paywall-remote-config.md#10-gap-cần-làm-rõ-trước-khi-execute) (mục 6, 8, 9, 11) — chỉ giữ lại câu hỏi thật sự cần dev/PO trả lời, không gồm action item QC tự làm được (log bug, chụp ảnh...). Điền cột **Trả lời** khi có phản hồi, rồi đồng bộ ngược lại test plan §10 (đánh dấu ✅ đã đóng).
> **Ngày gửi:** _(điền khi gửi)_ · **Người hỏi:** QC

---

## 1. Bản seed "Variant B" trong `paywall-config-builder.html` thiếu field `hero`

**Câu hỏi:** Bản seed mẫu (dòng ~617–644, đặt tên biến thể `hero_matrix_trial_vi`) set `heroMode: "animation"` nội bộ nhưng khi xuất JSON qua `emit()` lại **không có key `hero`** nào cả. Đây là lỗi trong chính tool (`emit()` không đồng bộ với default của `seed()`), hay cố ý bỏ trống để dùng hero mặc định?

**Nguồn:** test plan §10.6 · **Bằng chứng:** [`payloads/11-realistic-full-case/`](paywall-remote-config-payloads/11-realistic-full-case/) (TC-HERO-09/10)

**Trả lời:** _(chưa có)_

---

## 2. Thứ tự ưu tiên khi có ≥2 lỗi envelope cùng lúc

**Câu hỏi:** Vd `schema_version: 2` **và** `min_app_version` sai định dạng trong cùng 1 payload — decoder dừng ở lỗi đầu tiên (short-circuit) hay đánh giá hết rồi mới quyết định bỏ? Có ảnh hưởng gì tới log debug (category `paywall-config`) không?

**Nguồn:** test plan §10.8

**Trả lời:** _(chưa có)_

---

## 3. GA4 custom dimension `paywall_variant` đã đăng ký thật chưa?

**Câu hỏi:** Cần xác nhận đã đăng ký (Admin → Custom definitions → Custom dimensions, scope User) cho **cả 2 project** — dev (`workout-ai-1bdb1`) và prod (`lockscreencalendar-4477e`) — hay chưa. Việc này không hồi tố, nên cần biết chắc trước khi kết luận kết quả Suite Analytics (TC-ANA-02/04).

**Nguồn:** test plan §10.9

**Trả lời:** _(chưa có)_

---

## 4. `min_app_version` sai định dạng KHÔNG bị từ chối — quy tắc parse thật là gì?

**Câu hỏi:** Test bằng `"1.9.0-beta1"` (dự đoán sai định dạng theo regex `^\d+(\.\d+){0,3}$` trong tool JS, không chính thức) — thực tế payload **vẫn được áp dụng bình thường**, không bị bỏ. `paywall-config.md` không nêu rõ quy tắc validate format. Decoder có validate format `min_app_version` không, hay chỉ cố parse best-effort (vd chỉ đọc phần số đầu, bỏ qua hậu tố không phải số)?

**Nguồn:** test plan §10.11 · **Bằng chứng:** [`screenshots/01-envelope/04-min-app-version-bad-format.png`](paywall-remote-config-payloads/screenshots/01-envelope/04-min-app-version-bad-format.png), TC-ENV-04 trong test-cases

**Trả lời:** _(chưa có)_

---

## 5. `discount = 1` vẫn hiện pill "Save 100%" — điều kiện hiển thị pill thật là gì?

**Câu hỏi:** Dự đoán theo `previewModel()` của builder tool (`r.discount = (d>0 && d<1) ? d : null`) là `discount: 1` sẽ **không** có pill "Save" (vì 1 nằm ngoài khoảng `(0,1)` hở) — nhưng thực tế pill **"SAVE 100%" vẫn hiện**, chỉ riêng giá gạch ngang không hiện (chia cho 0, không tính được). Có vẻ điều kiện hiển thị **pill** chỉ cần `discount > 0` (không cần `< 1`), còn điều kiện tính **giá gạch ngang** mới thực sự cần `< 1`. 2 UI element này có đang dùng 2 điều kiện validate khác nhau trong code thật không? Điều kiện chính xác của mỗi cái là gì?

**Mức độ:** thấp — "Save 100%" vẫn đúng về mặt số học (giảm 100% = miễn phí), không gây hiểu nhầm cho user, không cần fix khẩn.

**Nguồn:** test plan §10.12 · **Bằng chứng:** [`screenshots/10-discount-boundary/04-discount-1-invalid.png`](paywall-remote-config-payloads/screenshots/10-discount-boundary/04-discount-1-invalid.png), TC-PLAN-12 trong test-cases

**Trả lời:** _(chưa có)_

---

## Không đưa vào danh sách này (đang tự điều tra / là action item của QC)

- **Trial `{trial}` không hiện dù ASC đã có offer thật** — QC đang verify lại trên prod với Sandbox Tester mới trước khi escalate thành câu hỏi chính thức (test plan §10.10). Nếu sau khi verify vẫn treo, sẽ thêm thành câu hỏi #6 ở đây.
- **Lỗi giá KRW/VND** — đã đủ thông tin để log bug (Critical), không cần hỏi thêm.
