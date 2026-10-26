---
name: github-issue-bug
description: Soạn GitHub issue báo bug theo đúng form "QC bug" (repo nhatanh410/cack_qc) cho hệ thống Quản lý vụ việc CACK Nội Bài (app mobile + web quản trị). Dùng khi user nói "log bug", "tạo issue bug", "viết issue cho lỗi này", "báo bug lên GitHub", hoặc đưa mô tả/screenshot/ghi chú một lỗi và muốn có issue sẵn để dán vào form. Xuất nội dung theo từng field của form, không tự bịa Phiên bản/thiết bị. Có thể đẩy thẳng lên repo issue bằng script nhưng chỉ sau khi user duyệt và xác nhận rõ.
---

# Soạn GitHub Issue — QC bug (Hệ thống Quản lý vụ việc CACK Nội Bài)

Biến mô tả lỗi thô (text, screenshot, ghi chú, 1 mục trong `bugs/bug-log.md`) thành **nội dung điền sẵn cho form
"QC bug"** trên GitHub. Form nguyên văn nhắc: *"Mỗi issue một lỗi. Ghi đủ để người khác (và agent) tái hiện
được mà không phải hỏi lại."* — đó là tiêu chí chất lượng duy nhất của skill này.

## Ngôn ngữ — tiếng Việt

**Toàn bộ nội dung báo cáo viết bằng tiếng Việt** (app và team dev dùng tiếng Việt): Title, các field, và nội dung
ghi vào `bugs/bug-log.md`.

- Tên nút/màn hình/tab: dùng **đúng nhãn trên UI** (`Tạo vụ việc`, `Tiếp nhận`, `Kiểm tra & chốt để ký`).
- Nội dung do user nhập hoặc text hiển thị sai (mô tả vụ việc, message lỗi) giữ nguyên gốc trong ngoặc kép.
- **Tiêu đề section trong bug-log giữ nguyên tiếng Anh** (`### Steps to reproduce`, `### Expected`, `### Actual`, các
  dòng `| **Severity** |`, `| **Account role** |`…) vì `scripts/` đọc đúng các khoá này — chỉ nội dung bên dưới là
  tiếng Việt.
- Nhãn `❓` trong report: `❓ cần xác nhận`, `❓ chưa thử lại`.

## Dữ liệu cá nhân — bắt buộc

Hệ thống xử lý CCCD/hộ chiếu, họ tên, ngày sinh, chuyến bay/số ghế hành khách, chữ ký. **Không bao giờ** đưa dữ
liệu cá nhân thật vào title, steps, bug-log hay ảnh đính kèm — chỉ dùng dữ liệu test, hoặc thay bằng mô tả
(`<CCCD 12 số hợp lệ>`). Input của user có dữ liệu thật → thay thế khi soạn và nói rõ với user đã thay.

## Các field của form (thứ tự đúng như trên GitHub)

Nguồn: issue form `.github/ISSUE_TEMPLATE/qc-bug.yml` của repo này (tạo 2026-10-26). Form tự gắn label `qc-bug`,
`needs-triage` và tiền tố title `[QC] `. Phần "Mỗi issue một lỗi…" là lời dẫn đầu form.

| # | Field | Bắt buộc | Dạng | Ghi chú |
|---|---|---|---|---|
| 1 | **Phiên bản** | ✅ | text | phiên bản / build đang test — ❓ dự án chưa thống nhất cách đánh số, hỏi user |
| 2 | **Nền tảng** | ✅ | dropdown | `App mobile` · `Web quản trị` |
| 3 | **Thiết bị / Trình duyệt** | ✅ | text | vd `iPhone 13, iOS 17.5` (app hiện chỉ chạy trên iPhone) hoặc `Chrome 129, Windows 11` |
| 4 | **Vai trò tài khoản** | ❌ | text | vai trò của tài khoản test, vd `Cán bộ` / `Tổ trưởng` / `Đội trưởng` — nên điền vì quyền khác nhau theo vai trò |
| 5 | **Các bước tái hiện** | ✅ | textarea | danh sách đánh số, bước đầu thường là `Đăng nhập bằng tài khoản <vai trò>` |
| 6 | **Mong đợi** | ✅ | textarea | chỉ ghi khi có căn cứ; chưa có spec → `❓ spec chưa nêu — cần PM/dev xác nhận` |
| 7 | **Thực tế** | ✅ | textarea | điều quan sát được, không phỏng đoán nguyên nhân |
| 8 | **Tần suất** | ✅ | dropdown | `Luôn luôn` · `Thỉnh thoảng` · `Chỉ gặp một lần` — chưa thử lại thì **phải thử lại** hoặc hỏi user |
| 9 | **Mức độ** | ✅ | dropdown | `critical — crash, mất dữ liệu, lộ dữ liệu cá nhân, sai quyền, chặn luồng chính` · `major — sai chức năng, có cách né` · `minor — lỗi hiển thị, chữ, chi tiết nhỏ` |
| 10 | **Ảnh, video, log** | ❌ | textarea | kéo thả file; **che toàn bộ dữ liệu cá nhân trước khi đính kèm** |

Title: form chỉ điền sẵn `[QC] `; phần còn lại theo "Quy tắc Title" bên dưới.

**Map Severity của bug-log → Mức độ của form** (bug-log có 4 mức, form có 3; QC lead xác nhận giữ quy ước của dự án Ink ngày 2026-10-26, vẫn hiện ở dry-run): `Critical → critical` · `High → major` · `Medium → major` · `Low → minor`. Nếu user muốn khác thì ghi đè
(`--severity`).

## Quy trình

1. **Đọc input**: mô tả, screenshot, hoặc bug trong `bugs/bug-log.md`. Một issue = một lỗi; nếu input chứa ≥2 lỗi
   khác nhau → tách thành nhiều issue, hỏi user nếu ranh giới không rõ.
2. **Gom dữ kiện theo field**. Tên màn hình/flow dùng đúng tên trong
   `.claude/rules/screenshot-naming.md` §7 (vd `03_case-create`, `subject-info`) nhưng **trong Title/Steps viết tên
   hiển thị trên UI** (tab "Tiếp nhận", nút "Tạo vụ việc"…), vì dev đọc theo UI chứ không theo tên file.
3. **Dừng hỏi (human-in-the-loop)** khi thiếu field bắt buộc mà không suy ra được từ input: **Phiên bản**, **Nền
   tảng**, **Thiết bị / Trình duyệt**, **Tần suất** (chưa thử lại → nhờ user thử lại hoặc cho biết). Không đoán, không dùng lại giá trị cũ của bug khác trừ khi user nói "giống bug
   trước". Nếu user bảo cứ xuất bản nháp → để `❓ cần bổ sung` đúng tại field đó.
4. **Viết Steps** (xem quy tắc dưới), **soát lại** theo checklist cuối, rồi xuất **bản nháp (tiếng Việt) kèm Mức độ đề xuất** (map từ Severity, xem bảng ở trên).
5. **Chờ user duyệt** → sau khi duyệt mới **ghi vào `bugs/bug-log.md`** (xem mục "Ghi nhận vào bug log").
6. **Đẩy lên GitHub (chỉ khi user muốn)** → làm đúng mục "Đẩy issue lên GitHub": hỏi 4 field nhập tay → dry-run →
   nêu đích đến → **chờ xác nhận rõ** → `--submit`. Đây là cổng human-in-the-loop thứ hai, độc lập với bước 5:
   user duyệt bản nháp **không** có nghĩa là đồng ý đẩy lên GitHub.

## Quy tắc viết "Các bước tái hiện"

- Danh sách đánh số `1. 2. 3.`, mỗi bước **một thao tác** người khác làm theo được, bắt đầu từ trạng thái xuất
  phát rõ (đăng nhập bằng vai trò nào, vụ việc đang ở trạng thái gì, đã cấp quyền camera/thư viện ảnh chưa).
- Dữ liệu cụ thể: giá trị đã nhập, mã vụ việc test, tên nút đúng chữ trên UI (`Bấm "Giao việc và gửi"`, không viết "bấm nút gửi").
- Bước cuối là hành động gây lỗi. Sau danh sách thêm 2 dòng:
  - **Thực tế:** điều đã xảy ra (quan sát được, không phỏng đoán nguyên nhân).
  - **Mong đợi:** chỉ ghi khi có căn cứ (spec/wireframe/hành vi màn tương tự); nếu không có căn cứ →
    `❓ spec chưa nêu — cần PM/dev xác nhận`, không tự bịa.
- Tần suất tái hiện (`luôn luôn` / `x/y lần` / `thỉnh thoảng`) nếu biết; nếu chưa thử lại → ghi `chưa thử lại`.
- Thêm điều kiện đặc biệt nếu có: mạng yếu/offline, vai trò tài khoản, nhiều cán bộ cùng thao tác, thời hạn đã qua, quyền camera bị từ chối…
- Nhắc user **đính kèm ảnh/video** vào ô "Ảnh, video, log" (đã che dữ liệu cá nhân); liệt kê rõ file nào nên đính.
  Không tự nhúng link ảnh không tồn tại.

## Quy tắc Title

- Title trả lời **Ở đâu / Cái gì / Khi nào**, không có các bước thao tác:
  - **Ở đâu** — màn hình/tính năng bị lỗi, đặt trong ngoặc vuông ngay sau `[QC]`: `[Tạo vụ việc]`, `[Biên bản]`,
    `[Giao việc]`. Dùng nhãn UI, 1–3 từ, nhất quán giữa các bug để dễ search/gom nhóm.
  - **Cái gì** — triệu chứng quan sát được, cụ thể ("không lưu được vụ việc", "nút Xác nhận chữ ký vẫn bấm được",
    "màn hình trắng"), không nêu nguyên nhân giả định trừ khi đã có log xác nhận.
  - **Khi nào** — điều kiện kích hoạt ngắn gọn ("khi chưa bật toggle xác nhận", "khi chọn 2 cán bộ", "khi offline").
    Nếu lỗi chỉ xảy ra trên một nền tảng/vai trò cụ thể thì thêm vào cuối title (`— vai trò Cán bộ`).
  - Các bước thao tác **không** vào Title — chỉ viết ở "Các bước tái hiện".
- Dạng `[QC] [Ở đâu] <Cái gì> khi <Khi nào>`, **tiếng Việt**, ngắn gọn (≤ ~80 ký tự).
  - ✅ `[QC] [Tạo vụ việc] Mất thông tin đối tượng đã quét khi bấm Quay lại`
  - ✅ `[QC] [Biên bản] Xác nhận chữ ký được khi chưa bật toggle đã đọc`
  - ❌ `[QC] Lỗi lưu` (chung chung, thiếu Ở đâu/Khi nào)
  - ❌ `[QC] Mở Trang chủ → Tạo vụ việc → bước 6 → Quay lại thì mất dữ liệu` (đây là các bước)
  - ❌ `[QC] [Tạo vụ việc] Không lưu được vì API lỗi` (nguyên nhân giả định)

## Định dạng đầu ra

Xuất theo thứ tự field, mỗi field trong 1 code block riêng để copy-paste nguyên vào ô tương ứng:

````
**Title**
```
[QC] ...
```
**Phiên bản**
```
...
```
**Nền tảng** → `<option>`  (dropdown option nguyên văn)
**Thiết bị / Trình duyệt**
```
...
```
**Vai trò tài khoản** (tuỳ chọn)
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
**Ảnh, video, log:** <file cần kéo vào; đã che dữ liệu cá nhân>
````

Cuối bản nháp thêm 1 dòng lý do chọn **Mức độ** (theo định nghĩa Severity trong header bug-log). Form có field Mức độ
nên giá trị này **được dán/đẩy lên GitHub**; bug-log vẫn lưu Severity 4 mức gốc.
Sau đó **một dòng** liệt kê field còn `❓` hoặc giả định đã dùng. Đẩy lên GitHub theo mục "Đẩy issue lên GitHub"
bên dưới (script có cổng xác nhận); user vẫn có thể chọn dán tay qua web UI.

## Chưa xác nhận

- Cách đánh số Phiên bản/build của app CACK.
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
     `.claude/rules/screenshot-naming.md` §7; không xác định được → `❓`), `Severity`, `Status`, `Account role`, `Device / Build`
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

## Đẩy issue lên GitHub (script, SAU KHI đã ghi bug-log)

Cấu hình repo đích/label/tên heading: [`scripts/bug-issue.conf`](../../../scripts/bug-issue.conf). Cần `gh auth login`
một lần (tài khoản cá nhân có quyền tạo issue ở repo đích). Không lưu token trong repo.

> ⚠️ **Repo đích `nhatanh410/cack_qc` đang PUBLIC (kiểm tra 2026-10-26).** Trước mỗi `--submit`, kiểm tra lại
> `gh repo view <REPO> --json visibility`; nếu vẫn `PUBLIC` → nói rõ với user issue sẽ ai cũng đọc được và khuyên
> chuyển private trước. Label `qc-bug`, `needs-triage` phải tồn tại trên repo (xem `docs/guides/bug-issue-setup.md`).

1. **Điều kiện:** bug đã được user duyệt và ghi vào bug-log, section có dòng `**Issue title:** \`...\``.
   **Bốn field luôn do user nhập tay mỗi lần: Phiên bản, Nền tảng, Thiết bị / Trình duyệt, Tần suất.** Không lấy từ bug-log,
   không dùng lại giá trị bug trước, không đoán từ ảnh/ghi chú. Trước khi chạy script, **hỏi user cả 4** (dùng
   AskUserQuestion cho 2 dropdown Nền tảng / Tần suất; Phiên bản và Thiết bị để user gõ), **chờ trả lời đủ rồi mới chạy**.
   User chưa trả lời → dừng, không chạy dry-run với giá trị giả. (Mức độ: map `High/Medium → major` vẫn hiện trong
   dry-run để user thấy và xác nhận.)
2. **Dry-run (luôn chạy trước):**
   `scripts/create-bug-issue.sh BUG-NNN --build V --install V --device V --frequency V [--lang V] [--severity V]`
   → in title/labels/body, chống trùng theo mã `BUG-NNN`. Exit 3 = còn thiếu field (`❓`) → quay lại hỏi user, không đoán.
3. **Cổng xác nhận trước `--submit` (bắt buộc).** Sau dry-run, hiển thị cho user: **repo đích (kèm public/private), title, labels,
   4 field đã nhập, Mức độ đã map** và nói rõ *"issue sẽ hiện với mọi người xem được repo và họ sẽ nhận thông báo"*. Rồi hỏi một câu
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
- [ ] Các field bắt buộc (Phiên bản, Nền tảng, Thiết bị / Trình duyệt, Tần suất, Mức độ) có giá trị thật hoặc `❓`; dropdown dùng đúng option nguyên văn.
- [ ] Toàn bộ report bằng tiếng Việt; tiêu đề section bug-log giữ khoá tiếng Anh cho script.
- [ ] Không có dữ liệu cá nhân thật trong title/steps/bug-log/ảnh.
- [ ] Người chưa biết lỗi làm theo Steps được mà không cần hỏi lại.
- [ ] Actual result tách khỏi nguyên nhân phỏng đoán; mong đợi có căn cứ hoặc `❓`.
- [ ] Đã nhắc đính kèm ảnh/video.
- [ ] Đã đề xuất Severity; **chưa** ghi bug log cho tới khi user duyệt.
- [ ] Nếu đẩy lên GitHub: đã hỏi 4 field nhập tay, đã dry-run, đã nêu repo/title/labels + cảnh báo dev nhận thông báo,
      đã có xác nhận rõ cho đúng bản dry-run đó; **chưa** `--submit` khi thiếu một trong các điều trên.
