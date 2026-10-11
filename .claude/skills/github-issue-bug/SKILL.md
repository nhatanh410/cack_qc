---
name: github-issue-bug
description: Soạn GitHub issue báo bug theo đúng form "QC bug" của team (repo sfunvn/lockscreen-calendar) cho app Ink Calendar iOS. Dùng khi user nói "log bug", "tạo issue bug", "viết issue cho lỗi này", "báo bug lên GitHub", hoặc đưa mô tả/screenshot/ghi chú một lỗi và muốn có issue sẵn để dán vào form. Xuất nội dung theo từng field của form, không tự bịa Build/thiết bị.
---

# Soạn GitHub Issue — QC bug (Ink Calendar iOS)

Biến mô tả lỗi thô (text, screenshot, ghi chú, 1 mục trong `bugs/bug-log.md`) thành **nội dung điền sẵn cho form
"QC bug"** trên GitHub. Form nguyên văn nhắc: *"Mỗi issue một lỗi. Ghi đủ để người khác (và agent) tái hiện
được mà không phải hỏi lại."* — đó là tiêu chí chất lượng duy nhất của skill này.

## Ngôn ngữ — bắt buộc tiếng Anh

**Toàn bộ nội dung báo cáo viết bằng tiếng Anh**: Title, Build, Thiết bị, Ngôn ngữ app, Các bước tái hiện (gồm
Actual result / Expected result / Frequency), và nội dung ghi vào `bugs/bug-log.md` (section chi tiết của bug).
Dù input của user là tiếng Việt, hoặc app đang ở tiếng Việt, report vẫn là tiếng Anh.

- Tên nút/màn hình/tab: dùng **đúng nhãn UI bản English của app** (`Your collection`, `Lockscreen`, `Set as current`).
  Nếu lỗi chỉ ở bản Việt và chưa biết nhãn English → ghi nhãn Việt trong ngoặc kép kèm bản dịch nghĩa, vd
  `"Bộ sưu tập của bạn" (Your collection)`.
- Nội dung do user nhập hoặc text hiển thị sai (tên event, message lỗi) giữ nguyên gốc trong ngoặc kép, không dịch.
- Tên field của form GitHub (Build, Bản cài, Thiết bị và iOS…) giữ nguyên tên gốc tiếng Việt để user biết dán vào đâu.
- Chỉ phần trao đổi với user (hỏi thông tin thiếu, lời dẫn, danh sách `❓` cần bổ sung) dùng tiếng Việt.
- Nhãn `❓` trong report ghi tiếng Anh: `❓ needs confirmation`, `❓ not retested`.

## Các field của form (thứ tự đúng như trên GitHub)

| # | Field | Bắt buộc | Dạng | Ghi chú |
|---|---|---|---|---|
| 1 | **Title** | ✅ | text, **tiền tố `[QC]`** | `[QC] [Where] <What> when <When>` — How để ở Steps |
| 2 | **Build** | ✅ | text | `<version> (<build>) — <rc tag nếu biết>`, vd `1.2.13 (456) — v1.2.13-rc2`. Lấy ở Cài đặt → Giới thiệu hoặc TestFlight |
| 3 | **Bản cài** | ✅ | dropdown | vd `TestFlight (Prod)`. Chỉ chọn trong các option có thật của form — xem mục "Chưa xác nhận" |
| 4 | **Thiết bị và iOS** | ✅ | text | vd `iphone 17 pro, iOS 26` |
| 5 | **Ngôn ngữ app** | ❌ | text | vd `Vietnamese` / `English` / `Vietnamese and English` |
| 6 | **Các bước tái hiện** | ✅ | markdown, danh sách đánh số | bước đầu thường là `Open the Calendar tab` |

⚠️ Ảnh chụp form chỉ thấy tới field 6 (có ô đính kèm file). Nếu form còn field phía dưới (vd Kết quả thực tế /
Kết quả mong đợi / Mức độ) mà chưa được user cho xem → **hỏi user gửi ảnh phần cuộn xuống**, không tự thêm field.
Trong lúc chờ, vẫn xuất 6 field trên; kết quả thực tế/mong đợi để **trong phần "Các bước tái hiện"** (bước cuối)
và ghi rõ đó là tạm thời.

## Quy trình

1. **Đọc input**: mô tả, screenshot, hoặc bug trong `bugs/bug-log.md`. Một issue = một lỗi; nếu input chứa ≥2 lỗi
   khác nhau → tách thành nhiều issue, hỏi user nếu ranh giới không rõ.
2. **Gom dữ kiện theo field**. Tên màn hình/flow dùng đúng tên trong
   `.claude/rules/screenshot-naming.md` §7 (vd `04_discover`, `create-note`) nhưng **trong Title/Steps viết tên
   hiển thị trên UI app** (tab "Lịch", "Discover"…), vì dev đọc theo UI chứ không theo tên file.
3. **Dừng hỏi (human-in-the-loop)** khi thiếu field bắt buộc mà không suy ra được từ input: **Build**, **Bản
   cài**, **Thiết bị và iOS**. Không đoán, không dùng lại giá trị cũ của bug khác trừ khi user nói "giống bug
   trước". Nếu user bảo cứ xuất bản nháp → để `❓ cần bổ sung` đúng tại field đó.
4. **Viết Steps** (xem quy tắc dưới), **soát lại** theo checklist cuối, rồi xuất **bản nháp (tiếng Anh) kèm Severity đề xuất**.
5. **Chờ user duyệt** → sau khi duyệt mới **ghi vào `bugs/bug-log.md`** (xem mục "Ghi nhận vào bug log").

## Quy tắc viết "Các bước tái hiện"

- Danh sách đánh số `1. 2. 3.`, mỗi bước **một thao tác** người khác làm theo được, bắt đầu từ trạng thái xuất
  phát rõ (đã đăng nhập chưa, đã cấp quyền Calendar chưa, có data gì sẵn, Pro hay Free nếu liên quan).
- Dữ liệu cụ thể: giá trị đã nhập, tên template, tên nút đúng chữ trên UI (`Tap ✓`, không viết "tap the done button").
- Bước cuối là hành động gây lỗi. Sau danh sách thêm 2 dòng:
  - **Actual result:** điều đã xảy ra (quan sát được, không phỏng đoán nguyên nhân).
  - **Expected result:** chỉ ghi khi có căn cứ (spec/wireframe/hành vi màn tương tự); nếu không có căn cứ →
    `❓ no spec — needs PM/dev confirmation`, không tự bịa.
- Tần suất tái hiện (`always` / `x/y times` / `intermittent`) nếu biết; nếu chưa thử lại → ghi `not retested`.
- Thêm điều kiện đặc biệt nếu có: mạng yếu/offline, múi giờ, Google Calendar sync bật/tắt, quyền bị từ chối…
- Nhắc user **đính kèm ảnh/video** vào ô "Paste, drop, or click to add files"; liệt kê rõ file nào nên đính.
  Không tự nhúng link ảnh không tồn tại.

## Quy tắc Title

- Title trả lời **Where / What / When**, không có How:
  - **Where** — màn hình/tính năng bị lỗi, đặt trong ngoặc vuông ngay sau `[QC]`: `[Create note]`, `[Paywall]`,
    `[Wallpaper]`. Dùng nhãn UI bản English, 1–3 từ, nhất quán giữa các bug để dễ search/gom nhóm.
  - **What** — *cái gì* bị lỗi + triệu chứng quan sát được, cụ thể ("note is not saved", "SAVE 100% pill is shown",
    "blank screen"), không nêu nguyên nhân giả định ("do sập DB", "thiếu gọi API") trừ khi đã có log xác nhận.
  - **When** — *khi nào* lỗi xảy ra: điều kiện/tình huống kích hoạt ngắn gọn ("when tapping ✓", "after enabling Google
    Calendar sync", "when offline"). Nếu lỗi chỉ xảy ra trên một thiết bị/iOS/ngôn ngữ cụ thể thì thêm vào cuối
    title (`on iOS 26`); nếu lỗi chung thì không ghi vì đã có field Thiết bị.
  - **How** (các thao tác từng bước) **không** vào Title — chỉ viết ở "Các bước tái hiện".
- Dạng `[QC] [Where] <What> when <When>`, **tiếng Anh**, ngắn gọn, đọc một lần là hiểu lỗi gì (≤ ~80 ký tự).
  - ✅ `[QC] [Create note] Note is not saved when tapping ✓`
  - ✅ `[QC] [Wallpaper] Google Calendar event is missing when sync is on`
  - ✅ `[QC] [Paywall] "SAVE 100%" pill is shown when discount = 1`
  - ❌ `[QC] Save error` (chung chung, thiếu Where/When)
  - ❌ `[QC] Button does not work` (không rõ nút nào, màn nào)
  - ❌ `[QC] Open Discover → Lockscreen → Note → enter title → tap ✓ and the note is lost` (đây là How)
  - ❌ `[QC] [Create note] Save fails because the API is not called` (nguyên nhân giả định)

## Định dạng đầu ra

Xuất theo thứ tự field, mỗi field trong 1 code block riêng để copy-paste nguyên vào ô tương ứng:

````
**Title**
```
[QC] ...
```
**Build**
```
...
```
**Bản cài** → `<option>`  (dropdown option nguyên văn)
**Thiết bị và iOS**
```
...
```
**Ngôn ngữ app** (tuỳ chọn)
```
...
```
**Các bước tái hiện**
```
1. ...
2. ...

Actual result: ...
Expected result: ...
```
**Đính kèm:** <file cần kéo vào>
````

Cuối bản nháp thêm dòng **Severity đề xuất:** `<mức>` — `<lý do 1 câu>` (chỉ dùng cho bug log, không dán vào form).
Sau đó **một dòng** liệt kê field còn `❓` hoặc giả định đã dùng. Không tự `gh issue create` — repo là private và
form dùng issue form (field riêng) nên dán qua web UI là cách chắc chắn; chỉ tạo bằng `gh` khi user yêu cầu rõ.

## Chưa xác nhận (hỏi user lần đầu dùng skill, rồi ghi lại vào đây)

- Danh sách đầy đủ option của dropdown **Bản cài** (đã thấy: `TestFlight (Prod)`).
- Form có field nào dưới "Các bước tái hiện" không (xem cảnh báo ở trên).
- Có label/severity/assignee mặc định nào team yêu cầu không.

## Ghi nhận vào bug log (bắt buộc, SAU KHI user duyệt)

File chung: [`bugs/bug-log.md`](../../../bugs/bug-log.md) — một file cho mọi bug, sort theo ngày phát hiện (mới nhất ở dưới).

**Điều kiện kích hoạt:** chỉ ghi khi user **duyệt rõ ràng** bản report ("ok", "duyệt", "ghi lại đi"…). Chưa duyệt, hoặc
user còn đang sửa → **không ghi**. User sửa gì thì ghi bản đã sửa, không ghi bản nháp ban đầu.

Cách làm:

1. **Kiểm tra file**: nếu `bugs/bug-log.md` chưa tồn tại → tạo mới với header (tiêu đề, quote giải thích, định nghĩa
   Severity/Status, bảng Tổng hợp rỗng, `---`) giống cấu trúc file hiện có; nếu đã có → **đọc lại** để lấy ID cuối
   và format, không ghi đè.
2. **ID**: `BUG-NNN` = số lớn nhất hiện có + 1 (3 chữ số). Không đánh lại số bug cũ.
3. **Thêm 1 dòng vào bảng Tổng hợp** (cuối bảng) và **1 section chi tiết** ở cuối file, đúng format các mục sẵn có:
   - Bảng field: `Date` (hôm nay, `YYYY-MM-DD`), `Flow` / `Screen` / `State` (đúng tên trong
     `.claude/rules/screenshot-naming.md` §7; không xác định được → `❓`), `Severity`, `Status`, `Device / Build`
     (lấy từ form đã duyệt), thêm dòng **`GitHub issue`**.
   - Section: *Steps to reproduce*, *Expected*, *Actual*, *Evidence*, *Notes* — **copy từ nội dung đã duyệt**,
     không viết lại theo ý khác.
4. **Severity**: form GitHub không có field này nên **đề xuất trong bản nháp** (kèm 1 dòng lý do theo định nghĩa
   trong header của bug-log) để user duyệt cùng lúc. Không tự chốt ngầm.
5. **Status** mặc định `Open`; `Need info` nếu report còn field `❓` quan trọng (Expected, điều kiện tái hiện).
6. **Link GitHub issue**: user thường dán form rồi mới có URL. Chưa có → ghi `❓ chưa tạo` và nhắc user gửi URL;
   khi user gửi, **cập nhật đúng dòng đó** (không tạo mục mới).
7. **Evidence**: nếu ảnh/video chưa nằm trong repo, ghi rõ như các mục cũ ("ảnh chưa được lưu vào repo") thay vì
   bịa đường dẫn.
8. Báo lại user 1 dòng: ID đã cấp + file đã sửa.

Không sửa/xoá bug cũ trong file này trừ khi user yêu cầu.

## Checklist trước khi xuất

- [ ] Một issue = một lỗi.
- [ ] Title có `[QC]`, có `[Where]` + What (triệu chứng cụ thể) + When, không chứa các bước How và không đoán nguyên nhân.
- [ ] 3 field bắt buộc Build / Bản cài / Thiết bị+iOS có giá trị thật hoặc `❓`.
- [ ] Toàn bộ report bằng tiếng Anh (trừ tên field form và lời dẫn cho user).
- [ ] Người chưa biết lỗi làm theo Steps được mà không cần hỏi lại.
- [ ] Actual result tách khỏi nguyên nhân phỏng đoán; mong đợi có căn cứ hoặc `❓`.
- [ ] Đã nhắc đính kèm ảnh/video.
- [ ] Đã đề xuất Severity; **chưa** ghi bug log cho tới khi user duyệt.
