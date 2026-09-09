# Exploratory Checklist — 02 Permission

> **Nguồn:** [wireframe](../ui/ux/wideframes/02_permission.md) · 4 screenshot
> **Khung đánh giá:** [exploratory-references](../../references/exploratory-references.md) ·
> [permissions-matrix](../../references/permissions-matrix.md)
> **Build:** TestFlight 1.2.10 (27) · **Thiết bị:** ____________ · **Người test:** ____________

---

## 0 · Framing

**Q1 — Mục tiêu user:** cấp vừa đủ quyền để Ink hiển thị được lịch, **mà không cảm thấy bị đòi hỏi quá đáng**.
User không đến đây để "cấp quyền" — họ đến để thấy lịch trên lock screen.

**Q8 — Mục tiêu business:** đây là **cửa ải một chiều**. iOS chỉ cho hỏi mỗi quyền **đúng một lần**; từ chối
là phải tự vào Settings, mà phần lớn user không biết đường. Tỷ lệ đồng ý ở đây đặt trần cho toàn bộ tỷ lệ
kích hoạt sản phẩm.

**Đặc thù flow này:** 2/4 màn là **dialog hệ thống iOS** — Ink chỉ kiểm soát được **purpose string** và
**thời điểm hỏi**, không kiểm soát bố cục hay nút. Hai màn còn lại là màn hình phục hồi do Ink dựng.

**Rủi ro xuyên suốt chạm vào flow này:**
- [permissions-matrix §1.1](../../references/permissions-matrix.md#-ba-trạng-thái-quyền--và-cái-ở-giữa-là-bẫy)
  — quyền Calendar có **3 trạng thái**, dialog chỉ có 2 nút.
- [permissions-matrix §1.2](../../references/permissions-matrix.md#-từ-chối-reminders-làm-chết-cả-task-nguồn-ink)
  — từ chối Reminders chặn cả task nguồn `Ink`.
- [§1.0 Bản đồ phụ thuộc](../../references/exploratory-references.md#10--bản-đồ-phụ-thuộc-ngoài-app) — quyền
  là mắt xích đầu tiên; đứt ở đây thì mọi thứ phía sau vô nghĩa.

---

## 1 · Happy path — `PRM-H`

| ID | Việc làm | Phải quan sát được | Đo gì | ☐ |
|---|---|---|---|:---:|
| **PRM-H01** | Máy sạch, đi tới S05 onboarding, bấm CTA | Dialog **Calendar** hiện ngay, không delay | ⏱ độ trễ từ lúc bấm | ☐ |
| **PRM-H02** | Đọc kỹ dialog Calendar | Purpose string đúng: *"Ink needs calendar access to show and create your events."* · có preview 1 event thật · có số *"N events in the next year"* | Chuỗi có khớp `Info.plist` không | ☐ |
| **PRM-H03** | Bấm `Allow Full Access` | Dialog **Reminders** hiện **ngay sau**, cùng một lần bấm CTA | ⏱ khoảng cách 2 dialog | ☐ |
| **PRM-H04** | Đọc dialog Reminders | Purpose string đúng · **2 nút nằm ngang** · **không có** preview dữ liệu | — | ☐ |
| **PRM-H05** | Bấm `Allow` | Về S06 onboarding, wallpaper preview render **event thật** | Đối chiếu với Apple Calendar | ☐ |
| **PRM-H06** | Vào Settings → Ink | Thấy **Calendars = Full Access** và **Reminders** đã bật | — | ☐ |
| **PRM-H07** | Mở tab Calendar và tab Tasks | Hiện dữ liệu thật, **không** hiện màn hình xin quyền | — | ☐ |

---

## 2 · Negative — `PRM-N`

### 2.1 · Từ chối quyền

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **PRM-N01** | `Don't Allow` ở dialog **Calendar** | Vào được app; tab Calendar hiện **S03** kèm nút `Open Settings` | Kẹt ở onboarding, hoặc lịch trống không giải thích | 🔴 | ☐ |
| **PRM-N02** | `Don't Allow` ở dialog **Reminders** | Tab Tasks hiện **S04**; các tab khác vẫn chạy bình thường | Coi như từ chối hết, chặn cả Calendar | 🟠 | ☐ |
| **PRM-N03** | Từ chối **cả hai** | Cả 2 tab hiện màn phục hồi tương ứng, app không crash | Màn trắng / crash | 🔴 | ☐ |
| **PRM-N04** | Dùng link **`Skip for now`** ở màn nền dialog Reminders | Bỏ qua được, app vào tiếp | Link không bấm được / không có tác dụng | 🟠 | ☐ |
| **PRM-N05** | Sau khi từ chối, thử bấm CTA ở S05 **lần nữa** | App phải biết iOS **không hỏi lại** → dẫn thẳng ra Settings | Bấm không có gì xảy ra → user tưởng app treo | 🔴 | ☐ |

### 2.2 · Màn hình phục hồi S03 / S04

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **PRM-N06** | Ở S03, bấm `Open Settings` | Mở **thẳng trang Ink** trong Settings, không phải Settings gốc | Mở Settings gốc → user phải tự mò tìm Ink | 🟠 | ☐ |
| **PRM-N07** | Bật quyền trong Settings rồi quay lại app | App **tự nhận** và hiện dữ liệu ngay | Phải tự kill app mới thấy → user tưởng bật không ăn | 🔴 | ☐ |
| **PRM-N08** | Đổi quyền Calendar trong Settings *(iOS thường **kill app** khi đổi)* | Mở lại app vào đúng tab đang xem, hiện dữ liệu | Crash lúc relaunch, hoặc quay lại onboarding từ đầu | 🟠 | ☐ |
| **PRM-N09** | Ở S03, bấm **2 icon header** *(chọn view · chọn calendar)* | Xử lý có nghĩa: disable, hoặc mở nhưng trống có giải thích | Sheet Calendars **trống trơn** hoặc crash *(liệt kê calendar cần quyền đọc)* | 🟠 | ☐ |
| **PRM-N10** | Ở S03/S04, tìm nút tạo mới | FAB `+` **biến mất** *(đã quan sát)* — xác nhận là chủ ý và nhất quán ở cả 2 màn | — | 🟡 | ☐ |
| **PRM-N11** | 🔴 Ở S04, kiểm **task nguồn `Ink`** | Task `Ink` **không cần** quyền Reminders → đáng ra vẫn xem/tạo được | Toàn bộ tab bị chặn, mất tính năng không phụ thuộc quyền — xem [phân tích](../ui/ux/wideframes/02_permission.md#-nhưng-ở-đây-có-vấn-đề-nặng-hơn-chặn-cả-tính-năng-không-cần-quyền) | 🔴 | ☐ |
| **PRM-N12** | Kiểm tab **Discover** và **Notes** khi bị từ chối quyền | Có màn phục hồi tương tự? Template preview cần event để render | Trống trơn không giải thích | 🟠 | ☐ |

### 2.3 · Rút quyền sau khi đã cấp

| ID | Tình huống | Kỳ vọng | Rủi ro nếu sai | Mức | ☐ |
|---|---|---|---|:---:|:---:|
| **PRM-N13** | Đang dùng app bình thường → vào Settings **tắt quyền Calendar** → quay lại | Chuyển sang S03 mượt, không crash | Crash, hoặc hiện dữ liệu cache như thể vẫn còn quyền | 🔴 | ☐ |
| **PRM-N14** | Rút quyền Calendar **sau khi shortcut đã setup xong** | Shortcut chạy → phải xử lý an toàn | ⚠️ Ghi đè wallpaper bằng **ảnh trống** — mất luôn wallpaper đang dùng. Xem [SCT/N15](../../references/shortcut-flow-cases.md#nhóm-34--phá-vỡ-sau-khi-đã-setup-xong) | 🔴 | ☐ |
| **PRM-N15** | Rút quyền Reminders khi đang mở tab Tasks | Chuyển sang S04 ngay | Hiện task cũ từ cache, thao tác vào thì lỗi | 🟠 | ☐ |

---

## 3 · Edge — `PRM-E`

### 3.1 · Ba trạng thái quyền Calendar 🔴

| ID | Tình huống | Câu hỏi | Mức | ☐ |
|---|---|---|:---:|:---:|
| **PRM-E01** | Settings → Ink → Calendars = **`Add Events Only`** | ⚠️ **Đã biết: app hiện y hệt trạng thái `None`** — user vừa cấp quyền mà app vẫn bảo *"Turn on Calendar access"*. Xác nhận lại và ghi lại chính xác nội dung | 🔴 | ☐ |
| **PRM-E02** | Ở `Add Events Only`, thử **tạo event** | App **ghi được** về mặt kỹ thuật. FAB `+` có hiện không? Nếu hiện thì form chọn calendar đích thế nào *(liệt kê calendar cần quyền đọc)*? | 🔴 | ☐ |
| **PRM-E03** | Ở `Add Events Only`, mở **sheet Calendars** | Trống? Crash? Có giải thích không? | 🟠 | ☐ |
| **PRM-E04** | Ở `Add Events Only`, xem **wallpaper / widget / live activity** | Đều trống — có báo gì cho user không, hay im lặng? | 🔴 | ☐ |
| **PRM-E05** | Đổi `Full Access` → `Add Events Only` khi app **đang mở** | App phát hiện và chuyển màn hình chứ? | 🟠 | ☐ |
| **PRM-E06** | Kiểm **Reminders** có 3 trạng thái không *(`None` / `Add Reminders Only` / `Full Access`)* | Nếu có → mọi vấn đề của PRM-E01→E05 lặp lại y hệt cho Tasks | 🟠 | ☐ |

### 3.2 · Môi trường & vòng đời

| ID | Tình huống | Câu hỏi | Mức | ☐ |
|---|---|---|:---:|:---:|
| **PRM-E07** | Máy **chưa có calendar nào** *(tài khoản iCloud mới tinh)* | Dialog hiện *"0 events in the next year"*? App xử lý sao sau khi cấp? | 🟡 | ☐ |
| **PRM-E08** | Máy có **rất nhiều event** *(dialog mẫu báo 1.872)* | Dialog có delay không? Sau khi cấp, app render mất bao lâu? | 🟠 | ☐ |
| **PRM-E09** | **Screen Time / MDM** hạn chế thay đổi quyền | `Open Settings` dẫn tới đâu? Có thông báo phù hợp không? | 🟡 | ☐ |
| **PRM-E10** | **Dark Mode** ở S03/S04 | Icon tím và chữ có đủ tương phản không? *(Ảnh chụp đều nền sáng)* | 🟠 | ☐ |
| **PRM-E11** | **Dynamic Type** cỡ lớn nhất ở S03/S04 | Câu giải thích 2 dòng có tràn không? Nút `Open Settings` còn vừa không? | 🟠 | ☐ |
| **PRM-E12** | **VoiceOver** ở S03/S04 | Đọc được tiêu đề, giải thích, và nhãn nút không? | 🟠 | ☐ |
| **PRM-E13** | Ngôn ngữ máy **tiếng Việt** | Purpose string trong dialog hệ thống có bản dịch không? *(iOS hiện đúng chuỗi trong `InfoPlist.strings` theo ngôn ngữ máy)* | 🟠 | ☐ |
| **PRM-E14** | **Gỡ app rồi cài lại** | Quyền iOS **reset về `notDetermined`** → app xin lại được. Xác nhận flow chạy đúng từ đầu | 🟠 | ☐ |
| **PRM-E15** | Khôi phục máy **từ backup** | Quyền còn giữ không? Nếu còn mà app vẫn xin lại thì hiện gì? | 🟡 | ☐ |

---

## 4 · Coverage matrix

| State | Đã có ảnh | Đã chạm khi test |
|---|:---:|:---:|
| S01 dialog Calendar | ✅ | ☐ |
| S02 dialog Reminders | ✅ | ☐ |
| S03 tab Calendar — `denied` | ✅ | ☐ |
| S04 tab Tasks — `denied` | ✅ | ☐ |
| **Calendar = `Add Events Only`** | ❌ chưa có ảnh | ☐ |
| **Reminders = `Add Reminders Only`** *(nếu tồn tại)* | ❌ | ☐ |
| Discover / Notes khi bị từ chối | ❌ | ☐ |
| Màn hình sau khi bật lại quyền và quay về app | ❌ | ☐ |
| S03/S04 ở Dark Mode · Dynamic Type lớn | ❌ | ☐ |
| Quyền **Photos** · **Notifications** | ❌ chưa thấy dialog nào trong toàn bộ 57 ảnh | ☐ |

---

## 5 · Câu hỏi cần PO / dev trả lời — `PRM-Q`

| ID | Câu hỏi | Vì sao cần |
|---|---|---|
| **PRM-Q01** | 🔴 Task nguồn **`Ink`** lưu ở đâu — local (Core Data/SwiftData) hay chỉ là một list trong Apple Reminders? | Quyết định PRM-N11 là **bug** hay là **tên gọi gây hiểu nhầm**. Không trả lời được thì không kết luận được |
| **PRM-Q02** | App dùng `EKEventStore.authorizationStatus(for:)` để phân biệt `.writeOnly` với `.denied` chưa? | `.writeOnly` **phân biệt được** — nên PRM-E01 là lỗi nội dung, sửa rẻ, không phải giới hạn nền tảng |
| **PRM-Q03** | Gửi danh sách đầy đủ key `*UsageDescription` trong `Info.plist` | Khai thừa → bị soi khi App Review · dùng mà chưa khai → **app crash** khi gọi API |
| **PRM-Q04** | App có xin quyền **Notifications** và **Photos** không? Xin lúc nào? | Chưa thấy dialog nào. Nếu Notifications bị từ chối mà app vẫn cho đặt nhắc rồi im lặng không kêu → bug nghiêm trọng |
| **PRM-Q05** | Có **analytics đo tỷ lệ đồng ý** từng dialog không? | Đây là chỉ số quan trọng nhất của flow. Không có → **gap về đo lường** |
| **PRM-Q06** | Vì sao xin **2 quyền liên tiếp** trong một lần bấm? Đã cân nhắc hoãn Reminders tới lúc user mở tab Tasks chưa? | Reminders được app coi là tuỳ chọn *(có `Skip for now`)* — quyền tuỳ chọn nên hỏi đúng lúc cần |
| **PRM-Q07** | Nội dung S03/S04 có kế hoạch **gọi tên lựa chọn** *(`Full Access`)* không? | Đây là **lần thứ 3** cùng mẫu lỗi trong sản phẩm — nên sửa một lượt thành nguyên tắc chung |

---

## 6 · Smoke 15 phút cho flow này

| Thứ tự | Việc | Thời lượng |
|:---:|---|:---:|
| 1 | **PRM-E01, E02** — đặt `Add Events Only`, mở app, thử tạo event | 4 phút |
| 2 | **PRM-N11** — từ chối Reminders, kiểm task nguồn `Ink` còn dùng được không | 3 phút |
| 3 | **PRM-N07** — bật lại quyền từ Settings, quay về app xem có tự nhận không | 3 phút |
| 4 | **PRM-N14** — rút quyền Calendar rồi chạy shortcut tay, xem có ghi đè wallpaper trống không | 3 phút |
| 5 | **PRM-N06** — `Open Settings` có mở thẳng trang Ink không | 1 phút |
| 6 | **PRM-N05** — sau khi từ chối, bấm lại CTA ở onboarding | 1 phút |

---

## 7 · Kết luận phiên

```
Phiên: __________      Build: 1.2.10 (27)      Thiết bị: __________

Q1 Mục tiêu user:            cấp vừa đủ quyền để thấy lịch, không thấy bị đòi hỏi quá đáng
Q8 Mục tiêu business:        cửa ải một chiều — iOS chỉ cho hỏi 1 lần
— Chạy luồng chính —
Q2 Xong dễ lần đầu?          Có / Không — vì: __________
Q3 Điểm khựng/bối rối:       ______________________________
Q4 Thao tác sai / gián đoạn: ______________________________
Q5 State chưa test:          ______________________________
— Kết luận —
Q6 Rủi ro #1 nếu ship:       ______________________________
Q7 Tự mình dùng hằng ngày?   Có / Không — vì: __________
Q9 15 phút thì test gì:      §6 ở trên

=> Verdict: 🟢 / 🟡 / 🔴  — kèm bằng chứng
```

**Ngưỡng cho riêng flow này:**

| Verdict | Điều kiện |
|---|---|
| 🔴 | `Add Events Only` không có đường sửa · rút quyền làm **ghi đè wallpaper trống** · từ chối quyền làm crash hoặc kẹt · task `Ink` bị chặn dù lưu local |
| 🟡 | Màn phục hồi có nhưng **không gọi tên `Full Access`** · phải kill app mới nhận quyền mới · `Open Settings` chỉ mở Settings gốc |
| 🟢 | Mọi đường từ chối đều có lối ra rõ ràng · bật lại quyền từ Settings là app nhận ngay · nội dung nêu đúng tên lựa chọn cần bấm |

---

## Ghi chú về giới hạn checklist này

- **PRM-N11 chưa kết luận được** cho tới khi có câu trả lời `PRM-Q01`. Ghi lại quan sát, **đừng** kết luận là
  bug khi chưa biết task `Ink` lưu ở đâu.
- **PRM-E01 đã được xác nhận bằng lời** từ team *(app hiện cùng nội dung với `None`)* nhưng **chưa có
  screenshot**. Chụp lại khi test để bổ sung vào wireframe.
- **Reminders 3 trạng thái** (`PRM-E06`) là **suy luận từ iOS 17**, chưa xác nhận trên máy thật — nếu không
  kiểm được, ghi là **coverage gap**, không giả định.
- Toàn bộ nhóm 3.1 cần **quyền vào Settings hệ thống** — máy bị MDM quản lý có thể không test được, khi đó
  ghi rõ lý do.
