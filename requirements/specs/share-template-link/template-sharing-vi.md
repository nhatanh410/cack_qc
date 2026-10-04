# QC — Chia sẻ template (share một wallpaper đã lưu bằng link)

Tính năng: người dùng share một wallpaper trong "Your collection" thành **một link công khai**. Người nhận mở
link, xem trước và thêm bản copy vào bộ sưu tập của mình. Chi tiết kỹ thuật:
[runbook](../runbooks/template-sharing.md).

## Chuẩn bị

- Bản **Ink Prod 1.2.19** trên **máy thật**. Simulator và bản Dev **không** share được (App Check và backend
  chỉ nhận Ink Prod).
- Trên máy test **chỉ cài Ink Prod**. Nếu cài cả Ink Dev, iOS có thể mở link `ink://` bằng Ink Dev và báo lỗi.
- **Hai máy**: máy **A** (người gửi) và máy **B** (người nhận). Nếu chỉ có một máy thì mở link trên chính máy A.
- Tài khoản:
  - máy A đăng nhập **Apple hoặc Google**;
  - máy B dùng tài khoản **Free**, có lúc cần thêm một tài khoản **Pro** để so sánh.
- Trên máy A, chuẩn bị sẵn trong "Your collection" các wallpaper sau:
  1. một design **catalog để nguyên** (không ảnh riêng, không chữ tự gõ);
  2. một design có **ảnh riêng** làm nền hoặc sticker ảnh;
  3. một design có **text sticker** hoặc quote tự gõ, **không** có ảnh riêng;
  4. một design có **cả ảnh riêng lẫn chữ tự gõ**;
  5. một design có **tuỳ chỉnh Pro** (Pro font, Custom colours, Text size…).
- **Cách mở link khi test:** trang web `inkcalendar.app/t/<id>` **chưa làm**, nên bấm link https sẽ ra trang lỗi.
  Đây là lỗi đã biết, **không** cần báo. Để test:
  1. Trong share sheet, bấm **Copy**. Link có dạng `https://inkcalendar.app/t/<id>`.
  2. Đổi thành `ink://template?id=<id>`, dán vào Notes rồi bấm, hoặc dán vào thanh địa chỉ Safari.

---

## 1. Nút Share nằm ở đâu

- [ ] Home → "Your collection": giữ tay trên một **wallpaper** thì menu có **Share**.
- [ ] Màn "Your collection" (bấm vào tiêu đề): giữ tay trên wallpaper cũng có **Share**.
- [ ] Màn "Your collection" có nút share (⬆︎) ở góc trên phải. Bấm vào thì mở danh sách để chọn một wallpaper.
- [ ] **Live Activity**, **Note** và **Widget** **không** có Share.
- [ ] Bộ sưu tập chỉ có Live Activity, Note hoặc Widget thì **không** có nút share ở góc trên.
- [ ] Nút Share hiện mà **không cần bật gì** trong Remote Config.

## 2. Đăng nhập

- [ ] Đăng xuất rồi bấm Share: hiện màn **"Sign in to share this template"**.
- [ ] Đăng nhập Apple hoặc Google xong thì luồng share **tự chạy tiếp**, không phải bấm Share lại.
- [ ] Vuốt xuống để đóng màn đăng nhập: **không** share gì.

## 3. Share một design bình thường (design 1)

- [ ] Bấm Share: hiện "Creating link…", sau đó mở share sheet của iOS có link `inkcalendar.app`.
- [ ] **Không** có câu hỏi về ảnh hay chữ.
- [ ] Copy link rồi mở trên máy B: design trông giống bản trên máy A.
- [ ] Bản xem trước **không** chứa sự kiện thật của máy A. Nó chỉ hiện sự kiện mẫu.

## 4. Câu hỏi về ảnh (design 2)

- [ ] Bấm Share: hiện hộp **"Share your photos too?"**, có hai nút **Use Ink backgrounds** và **Include my photos**.
- [ ] Chọn **Use Ink backgrounds**, mở link trên máy B: **không** có ảnh riêng của máy A, chỉ còn nền của template hoặc catalog.
- [ ] Share lại, chọn **Include my photos**, mở link trên máy B: **có** ảnh của máy A.
- [ ] Vuốt xuống để đóng hộp câu hỏi: **không** share gì, **không** có share sheet.

## 5. Cảnh báo chữ tự gõ (design 3 và 4)

- [ ] Design 3 (chỉ có chữ): hiện hộp **"Share this text?"**, nội dung nói ai có link cũng đọc được chữ.
  - [ ] Bấm **Share**: share bình thường.
  - [ ] Bấm **Cancel**: **không** share gì.
- [ ] Design 4 (ảnh + chữ): chỉ hiện **một** hộp câu hỏi về ảnh, nội dung nhắc cả chữ đi kèm. **Không** hiện thêm hộp "Share this text?".
- [ ] Mở link trên máy B: chữ tự gõ **vẫn còn**, kể cả khi đã chọn Use Ink backgrounds.

## 6. Mỗi wallpaper chỉ có một link

- [ ] Share design 1 hai lần liên tiếp: **cùng một link**. Lần hai ra share sheet nhanh vì không tạo lại.
- [ ] Sửa design 1 (đổi màu hoặc nền) rồi share lại: link **giữ nguyên**, mở trên máy B thì thấy **bản đã sửa**.
- [ ] Hai wallpaper khác nhau thì có **hai link khác nhau**.
- [ ] Share design 2 với Include my photos, rồi share lại với Use Ink backgrounds: link giữ nguyên và **ảnh biến mất** khỏi link.

## 7. Mở link (máy B)

- [ ] Mở link khi app **đang chạy**: hiện màn **"Shared template"** có ảnh xem trước, tên design và nút **Add to my collection**.
- [ ] Mở link khi app **đã tắt hẳn**: app mở, qua splash hoặc paywall xong thì hiện màn "Shared template".
- [ ] Mở link khi **chưa đăng nhập**: vẫn xem và thêm được, **không** cần tài khoản.
- [ ] Template Pro của catalog: có badge **PRO**.
- [ ] Bấm ✕: đóng màn, **không** thêm gì.

## 8. Thêm vào bộ sưu tập (máy B)

- [ ] Bấm **Add to my collection**: hiện "Added to your collection", design xuất hiện đầu "Your collection".
- [ ] Tài khoản **Free** đã đủ **5** design: hiện **"Collection is full"** kèm nút Go Pro và Cancel. Xoá bớt một design thì thêm được.
- [ ] Tài khoản **Pro**: thêm được dù đã có hơn 5 design.
- [ ] Design có ảnh riêng: tắt mạng sau khi thêm, ảnh **vẫn hiện**, vì đã tải về máy.
- [ ] Mở cùng một link và thêm hai lần: có **hai** bản copy riêng.
- [ ] Máy A sửa và share lại design: bản máy B đã thêm **không đổi**.

## 9. Set as current và Pro (máy B)

- [ ] Free + design **không** có tuỳ chỉnh Pro: **Set as current** chạy bình thường, không có paywall.
- [ ] Free + design 5 (có tuỳ chỉnh Pro): **Add** vẫn được, nhưng **Set as current** hiện **paywall**.
- [ ] Pro + design 5: Set as current chạy bình thường.
- [ ] Wallpaper hiện lên màn khoá đúng như bản xem trước, qua Shortcut như mọi wallpaper khác.

## 10. Link lỗi và mất mạng

- [ ] Mở `ink://template?id=abc123` (id không tồn tại): hiện **"Template unavailable"** / "This template was removed, or the link is incomplete."
- [ ] Tắt mạng rồi mở link đúng: hiện "Couldn't load this template. Check your connection and try again." Bật mạng rồi thử lại thì mở được.
- [ ] Tắt mạng rồi bấm Share trên máy A: hiện "Couldn't create a share link. Try again." và **không** có share sheet.

## 11. Xoá tài khoản (máy A)

- [ ] Settings → xoá tài khoản. Mở lại link cũ trên máy B: **"Template unavailable"**.
- [ ] Bản máy B đã thêm từ trước **vẫn còn** và vẫn dùng được.

## 12. Ngôn ngữ

- [ ] Đổi sang **Tiếng Việt** và **Arabic** (chữ phải sang trái), kiểm các màn: Share, câu hỏi ảnh, "Share this text?",
  "Shared template", "Template unavailable". Chữ không bị cắt và không còn chữ tiếng Anh sót lại.

---

## Đã biết, không cần báo lỗi

- Bấm link `https://inkcalendar.app/t/<id>` ra trang lỗi, vì trang web chưa làm.
- Chưa có cách xoá riêng một link, chưa có danh sách "link của tôi", chưa có nút báo cáo. Link chỉ mất khi xoá tài khoản.
- Tên wallpaper cũng công khai theo link.
