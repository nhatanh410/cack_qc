---
name: github-issue-bug
description: Soạn GitHub issue báo bug theo đúng form "QC bug" của team (repo sfunvn/lockscreen-calendar) cho app Ink Calendar iOS. Dùng khi user nói "log bug", "tạo issue bug", "viết issue cho lỗi này", "báo bug lên GitHub", hoặc đưa mô tả/screenshot/ghi chú một lỗi và muốn có issue sẵn để dán vào form. Xuất nội dung theo từng field của form, không tự bịa Build/thiết bị. Có thể đẩy thẳng lên repo source bằng script nhưng chỉ sau khi user duyệt và xác nhận rõ.
---

# Soạn GitHub Issue — QC bug (Ink Calendar iOS)

Biến mô tả lỗi thô (text, screenshot, ghi chú, 1 mục trong `bugs/bug-log.md`) thành **nội dung điền sẵn cho form
"QC bug"** trên GitHub. Form nguyên văn nhắc: *"Mỗi issue một lỗi. Ghi đủ để người khác (và agent) tái hiện
được mà không phải hỏi lại."* — đó là tiêu chí chất lượng duy nhất của skill này.

## Ngôn ngữ — bắt buộc tiếng Anh

**Toàn bộ nội dung báo cáo viết bằng tiếng Anh**: Title, Build, Thiết bị, Ngôn ngữ app, Các bước tái hiện (gồm
Mong đợi / Thực tế / Tần suất / Mức độ), và nội dung ghi vào `bugs/bug-log.md` (section chi tiết của bug).
Dù input của user là tiếng Việt, hoặc app đang ở tiếng Việt, report vẫn là tiếng Anh.

- Tên nút/màn hình/tab: dùng **đúng nhãn UI bản English của app** (`Your collection`, `Lockscreen`, `Set as current`).
  Nếu lỗi chỉ ở bản Việt và chưa biết nhãn English → ghi nhãn Việt trong ngoặc kép kèm bản dịch nghĩa, vd
  `"Bộ sưu tập của bạn" (Your collection)`.
- Nội dung do user nhập hoặc text hiển thị sai (tên event, message lỗi) giữ nguyên gốc trong ngoặc kép, không dịch.
- Tên field của form GitHub (Build, Bản cài, Thiết bị và iOS…) giữ nguyên tên gốc tiếng Việt để user biết dán vào đâu.
- Chỉ phần trao đổi với user (hỏi thông tin thiếu, lời dẫn, danh sách `❓` cần bổ sung) dùng tiếng Việt.
- Nhãn `❓` trong report ghi tiếng Anh: `❓ needs confirmation`, `❓ not retested`.

## Các field của form (thứ tự đúng như trên GitHub)

Nguồn: file issue form thật `.github/ISSUE_TEMPLATE` của repo (đọc 2026-10-11). Form tự gắn label `qc-bug`,
`needs-triage` và tiền tố title `[QC] `. Phần "Mỗi issue một lỗi…" là lời dẫn đầu form.

| # | Field | Bắt buộc | Dạng | Ghi chú |
|---|---|---|---|---|
| 1 | **Build** | ✅ | text | `<version> (<build>) — <rc tag nếu biết>`, vd `1.2.13 (456) — v1.2.13-rc2`. Lấy ở Cài đặt → Giới thiệu hoặc TestFlight |
| 2 | **Bản cài** | ✅ | dropdown | `TestFlight (Prod)` · `Firebase App Distribution (Dev)` · `App Store` · `Build local từ Xcode` |
| 3 | **Thiết bị và iOS** | ✅ | text | vd `iPhone 15 Pro, iOS 18.6` |
| 4 | **Ngôn ngữ app** | ❌ | text | vd `Vietnamese` / `English` |
| 5 | **Các bước tái hiện** | ✅ | textarea | danh sách đánh số, bước đầu thường là `Open the Calendar tab` |
| 6 | **Mong đợi** | ✅ | textarea | chỉ ghi khi có căn cứ; chưa có spec → `❓ no spec — needs PM/dev confirmation` |
| 7 | **Thực tế** | ✅ | textarea | điều quan sát được, không phỏng đoán nguyên nhân |
| 8 | **Tần suất** | ✅ | dropdown | `Luôn luôn` · `Thỉnh thoảng` · `Chỉ gặp một lần` — chưa thử lại thì **phải thử lại** hoặc hỏi user |
| 9 | **Mức độ** | ✅ | dropdown | `critical — crash, mất dữ liệu, chặn luồng chính` · `major — sai chức năng, có cách né` · `minor — lỗi hiển thị, chữ, chi tiết nhỏ` |
| 10 | **Ảnh, video, log** | ❌ | textarea | kéo thả file; **không đính kèm dữ liệu lịch thật của người dùng** |

Title: form chỉ điền sẵn `[QC] `; phần còn lại theo "Quy tắc Title" bên dưới.

**Map Severity của bug-log → Mức độ của form** (bug-log có 4 mức, form có 3; QC đã đồng ý, vẫn hiện ở dry-run): `Critical → critical` · `High → major` · `Medium → major` · `Low → minor`. Nếu user muốn khác thì ghi đè
(`--severity`).

## Quy trình

1. **Đọc input**: mô tả, screenshot, hoặc bug trong `bugs/bug-log.md`. Một issue = một lỗi; nếu input chứa ≥2 lỗi
   khác nhau → tách thành nhiều issue, hỏi user nếu ranh giới không rõ.
2. **Gom dữ kiện theo field**. Tên màn hình/flow dùng đúng tên trong
   `.claude/rules/screenshot-naming.md` §7 (vd `04_discover`, `create-note`) nhưng **trong Title/Steps viết tên
   hiển thị trên UI app** (tab "Lịch", "Discover"…), vì dev đọc theo UI chứ không theo tên file.
3. **Dừng hỏi (human-in-the-loop)** khi thiếu field bắt buộc mà không suy ra được từ input: **Build**, **Bản
   cài**, **Thiết bị và iOS**, **Tần suất** (chưa thử lại → nhờ user thử lại hoặc cho biết). Không đoán, không dùng lại giá trị cũ của bug khác trừ khi user nói "giống bug
   trước". Nếu user bảo cứ xuất bản nháp → để `❓ cần bổ sung` đúng tại field đó.
4. **Viết Steps** (xem quy tắc dưới), **soát lại** theo checklist cuối, rồi xuất **bản nháp (tiếng Anh) kèm Mức độ đề xuất** (map từ Severity, xem bảng ở trên).
5. **Chờ user duyệt** → sau khi duyệt mới **ghi vào `bugs/bug-log.md`** (xem mục "Ghi nhận vào bug log").
6. **Đẩy lên GitHub (chỉ khi user muốn)** → làm đúng mục "Đẩy issue lên repo source": hỏi 4 field nhập tay → dry-run →
   nêu đích đến → **chờ xác nhận rõ** → `--submit`. Đây là cổng human-in-the-loop thứ hai, độc lập với bước 5:
   user duyệt bản nháp **không** có nghĩa là đồng ý đẩy lên GitHub.

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
```
**Mong đợi**
```
...
```
**Thực tế**
```
...
```
**Tần suất** → `<option>`  (dropdown option nguyên văn)
**Mức độ** → `<option>`  (dropdown option nguyên văn)
**Ảnh, video, log:** <file cần kéo vào; không đính kèm dữ liệu lịch thật của người dùng>
````

Cuối bản nháp thêm 1 dòng lý do chọn **Mức độ** (theo định nghĩa Severity trong header bug-log). Form có field Mức độ
nên giá trị này **được dán/đẩy lên GitHub**; bug-log vẫn lưu Severity 4 mức gốc.
Sau đó **một dòng** liệt kê field còn `❓` hoặc giả định đã dùng. Đẩy lên GitHub theo mục "Đẩy issue lên repo source"
bên dưới (script có cổng xác nhận); user vẫn có thể chọn dán tay qua web UI.

## Chưa xác nhận

- Map Severity 4 mức → Mức độ 3 mức (`High → major`, `Medium → major`): QC đã đồng ý (2026-10-11), dev chưa xác nhận.
- Team có assignee/triage riêng cho label `needs-triage` không (form chỉ gắn label, không gắn assignee).
- Cách đính kèm ảnh/video: `gh` không upload được → kéo thả thủ công vào issue sau khi tạo.

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
4. **Severity**: bug-log dùng 4 mức (Critical/High/Medium/Low), form GitHub chỉ có 3 (critical/major/minor) → **đề xuất
   trong bản nháp** kèm 1 dòng lý do để user duyệt cùng lúc. Không tự chốt ngầm.
5. **Status** mặc định `Open`; `Need info` nếu report còn field `❓` quan trọng (Expected, điều kiện tái hiện).
6. **Link GitHub issue**: chưa tạo → ghi `❓ not created yet`. Sau khi tạo bằng script thì script tự ghi URL; nếu user
   dán tay qua web, nhắc user gửi URL rồi **cập nhật đúng dòng đó** (không tạo mục mới).
7. **Evidence**: nếu ảnh/video chưa nằm trong repo, ghi rõ như các mục cũ ("ảnh chưa được lưu vào repo") thay vì
   bịa đường dẫn.
8. Báo lại user 1 dòng: ID đã cấp + file đã sửa.

Không sửa/xoá bug cũ trong file này trừ khi user yêu cầu.

## Đẩy issue lên repo source (script, SAU KHI đã ghi bug-log)

Cấu hình repo đích/label/tên heading: [`scripts/bug-issue.conf`](../../../scripts/bug-issue.conf). Cần `gh auth login`
một lần (tài khoản cá nhân có quyền tạo issue ở repo đích). Không lưu token trong repo.

1. **Điều kiện:** bug đã được user duyệt và ghi vào bug-log, section có dòng `**Issue title:** \`...\``.
   **Bốn field luôn do user nhập tay mỗi lần: Build, Bản cài, Thiết bị và iOS, Tần suất.** Không lấy từ bug-log,
   không dùng lại giá trị bug trước, không đoán từ ảnh/ghi chú. Trước khi chạy script, **hỏi user cả 4** (dùng
   AskUserQuestion cho 2 dropdown Bản cài / Tần suất; Build và Thiết bị+iOS để user gõ), **chờ trả lời đủ rồi mới chạy**.
   User chưa trả lời → dừng, không chạy dry-run với giá trị giả. (Mức độ: map `High/Medium → major` đã được user
   đồng ý ngày 2026-10-11, vẫn hiện trong dry-run để user thấy.)
2. **Dry-run (luôn chạy trước):**
   `scripts/create-bug-issue.sh BUG-NNN --build V --install V --device V --frequency V [--lang V] [--severity V]`
   → in title/labels/body, chống trùng theo mã `BUG-NNN`. Exit 3 = còn thiếu field (`❓`) → quay lại hỏi user, không đoán.
3. **Cổng xác nhận trước `--submit` (bắt buộc).** Sau dry-run, hiển thị cho user: **repo đích, title, labels, 4 field
   đã nhập, Mức độ đã map** và nói rõ *"issue sẽ hiện công khai với dev và họ sẽ nhận thông báo"*. Rồi hỏi một câu
   xác nhận riêng (AskUserQuestion: `Submit` / `Chưa, để chỉnh`).
   - Chỉ coi là xác nhận khi user **nói rõ ý đẩy lên GitHub** ("submit", "tạo issue đi", "đẩy lên"…). "ok", "được",
     "tiếp đi", im lặng, hoặc việc user vừa duyệt bản nháp **không** tính. Mơ hồ → hỏi lại.
   - Xác nhận chỉ có hiệu lực cho **đúng bản dry-run vừa xem**. Nếu sau đó có bất kỳ thay đổi nào (sửa bug-log, đổi
     field, đổi prefix) → chạy lại dry-run và xin xác nhận lại.
   - Xác nhận cho BUG này không áp dụng cho bug khác; mỗi lần `--submit` một bug, một xác nhận.
   - **Không bao giờ tự thêm `--submit`**, kể cả khi đang "làm cho xong pipeline".
4. Script tự ghi URL vào dòng `GitHub issue` của BUG-NNN. Nhắc user **kéo ảnh/video vào issue thủ công** (`gh` không
   upload được file đính kèm).
5. Không tự sửa hay đóng issue của dev.

### Đồng bộ trạng thái (resolve)

`scripts/sync-bug-status.sh` (chỉ in đề xuất) → user xem → `scripts/sync-bug-status.sh --write`. Ánh xạ: closed +
completed → `Fixed`; closed + not planned → `Won't fix`; open giữ nguyên. Chỉ đổi cột Status (bảng Tổng hợp + section).
Chạy khi user yêu cầu, không tự chạy.

## Checklist trước khi xuất

- [ ] Một issue = một lỗi.
- [ ] Title có `[QC]`, có `[Where]` + What (triệu chứng cụ thể) + When, không chứa các bước How và không đoán nguyên nhân.
- [ ] Các field bắt buộc (Build, Bản cài, Thiết bị+iOS, Tần suất, Mức độ) có giá trị thật hoặc `❓`; dropdown dùng đúng option nguyên văn.
- [ ] Toàn bộ report bằng tiếng Anh (trừ tên field form và lời dẫn cho user).
- [ ] Người chưa biết lỗi làm theo Steps được mà không cần hỏi lại.
- [ ] Actual result tách khỏi nguyên nhân phỏng đoán; mong đợi có căn cứ hoặc `❓`.
- [ ] Đã nhắc đính kèm ảnh/video.
- [ ] Đã đề xuất Severity; **chưa** ghi bug log cho tới khi user duyệt.
- [ ] Nếu đẩy lên GitHub: đã hỏi 4 field nhập tay, đã dry-run, đã nêu repo/title/labels + cảnh báo dev nhận thông báo,
      đã có xác nhận rõ cho đúng bản dry-run đó; **chưa** `--submit` khi thiếu một trong các điều trên.
