# Hệ thống Quản lý vụ việc Công An Cửa Khẩu Nội Bài

> **Nguồn:** Google Doc "Mô tả chức năng Giao việc" — https://docs.google.com/document/d/1APynC86qfJnRKOm_UmxIZ4-xyRGLdYr3Y5QGFpRN82A
> **Bản chụp:** xuất ngày 2026-10-26, nội dung giữ nguyên văn (chỉ chuyển sang Markdown, ảnh đánh số theo thứ tự xuất hiện `images/hinh-NN.png`).
> **Vai trò trong pipeline:** test basis cấp hệ thống (module Xử lý vi phạm + Giao việc). Khi tách theo chức năng để chạy `/spec-intake`, trích dẫn về file này.
>
> ⚠️ **Tài liệu gốc dừng giữa chừng** ở mục "Ký lại biên bản — Mô tả:" (chưa có nội dung) — không suy diễn phần còn thiếu.
> 📌 **Đã có đặc tả chi tiết [dac-ta-chuc-nang-v2.1.md](dac-ta-chuc-nang-v2.1.md)** (22/10/2026) — bổ sung cho file này và **được ưu tiên khi mâu thuẫn**.
> 📌 **Đọc kèm [lam-ro-2026-10-26.md](lam-ro-2026-10-26.md)** — câu trả lời của QC lead về vai trò, ký lại biên bản, nền tảng (iPhone).
>
> ⚠️ **Ảnh trong `images/` có thể chứa dữ liệu cá nhân thật** (vd Hình 10: họ tên, ngày sinh, số CCCD) → thư mục `images/` đang bị `.gitignore` chặn vì repo GitHub hiện ở chế độ **public**. Chỉ bỏ chặn sau khi repo chuyển private hoặc ảnh đã được che thông tin.


Chức năng: Xử lý vi phạm và Giao Việc
Mục đích tổng quan của 2 chức năng: Quản lí giao việc và tạo vụ việc xử lý vi phạm tới từng nhân sự trong hệ thống theo từng phân quyền và vai trò của người dùng. Người sử dụng có thể tiếp nhận việc linh hoạt thông qua app Quản lý trên thiết bị điện thoại cá nhân, dễ dàng nhận nhiệm vụ và báo cáo đến với người quản lý. Người quản lý cũng nhận được báo cáo nhanh chóng, nắm bắt được thông tin nhanh nhất có thể → tiện lợi, ít giấy tờ, thủ tục phức tạp, quản lý được nhiều việc và nhân sự 1 lúc, không bị thiếu thông tin trong quá trình giao nhận và làm việc

Bao gồm 2 phân quyền cho user:
1. Phân quyền được giao việc/tạo vụ việc bao gồm: Đội trưởng/chỉ huy Đội, Tổ trưởng, Tổ phó được uỷ quyền, Phó đội trưởng, Phó trưởng CACK, Trưởng CACK
2. Phân quyền nhận việc/vụ việc được giao: Cán bộ

Các tính năng chính trong Giao việc:
1. Tạo vụ việc xử lý vi phạm giao đến cán bộ
* Mô tả: Tạo vụ việc cần xử lý vi phạm và giao đến với cán bộ xử lý sự việc
* Luồng chính:
   * Phía người có quyền tạo và giao việc/vụ việc: Người giao việc tạo 1 vụ việc mới → nhập các thông tin → chỉ định cán bộ xử lý công việc → submit
   * Phía nhận việc/xử lý vi phạm được giao: Bấm vào vụ việc được giao → đọc thông tin chi tiết của việc → chuyển trạng thái sang đang thực hiện → bấm vào trạng thái hoàn thành khi đã hoà thành xong công việc
   * → Kết quả: Xử lý vi phạm được giao hoàn thành, lưu log ở từng tài khoản, gửi thông báo đến người giao việc và cấp trên. Lưu kết quả vào trang quản trị hệ thống chung
2. Tạo Giao việc
* Mô tả: Tạo giao việc và giao đến cán bộ xử lý công việc đó
* Luồng chính:
   * Phía người có quyền tạo và giao việc/vụ việc: Người giao việc tạo giao việc mới → nhập các thông tin → chỉ định cán bộ xử lý công việc → submit
   * Phía nhận việc/xử lý vi phạm được giao: Bấm vào vụ việc được giao → đọc thông tin chi tiết của việc → chuyển trạng thái sang đang thực hiện → bấm vào trạng thái hoàn thành khi đã hoà thành xong công việc
   * → Kết quả: Việc được giao hoàn thành, lưu log ở từng tài khoản, gửi thông báo đến người giao việc và cấp trên. Lưu kết quả vào trang quản trị hệ thống chung
3. Tạo biểu mẫu xử lý vụ việc
* Mô tả: Một vài vụ việc sẽ cần phải tạo biểu mẫu xử lý vụ việc và yêu cầu chữ ký của 2 bên tham gia, ví dụ: hành khách trên chuyến bay và cán bộ được giao xử lý vụ việc hoặc cán bộ tham gia vụ việc và cán bộ được giao xử lý vụ việc . Mục đích để tạo văn bản nhanh chóng, ký xác nhận giữa 2 bên mà không cần phải có giấy tờ đi kèm gây kéo dài thời gian thực hiện. Biên bản được lưu tự động trên hệ thống, dễ dàng truy xuất thông tin.
* Luồng chính: Cán bộ chọn vụ việc được chỉ định cho mình → Ở chi tiết vụ việc → chọn Lập biên bản → điền thông tin → đưa thiết bị di động của cán bộ cho người tham gia ký → cán bộ xử lý ký → Lưu
* → Kết quả: Lập biên bản thành công, ký xác nhận nhanh, lưu kết quả trên trang quản trị
4. Xem thống kê
* Mô tả: Xem thống kê về các việc/xử lý vi phạm được giao, có thông tin tổng quát nhanh chóng về các vấn đề vụ việc đã giao và xử lý
* Vị trí của Thống kê nằm ngay ở tab Trang chủ khi vừa truy cập thành công vào app

Giao diện và thao tác với từng tính năng trong chức năng giao việc:
1. Người giao việc tạo giao vụ việc xử lý vi phạm mới
* Đăng nhập vào hệ thống bằng tài khoản hợp lệ

![Hình 1: Giao diện đăng nhập vào hệ thống](images/hinh-01.png)
*Hình 1: Giao diện đăng nhập vào hệ thống*

* Click button Tạo vụ việc

![Hình 2: Button tạo vụ việc](images/hinh-02.png)
*Hình 2: Button tạo vụ việc*

* Thêm các trường thông tin (bao gồm 9 bước)
   * Bước 1: Thềm Hình ảnh/Bằng chứng (không bắt buộc)

![Hình 3: Giao diện Thêm hình ảnh/Bằng chứng](images/hinh-03.png)
*Hình 3: Giao diện Thêm hình ảnh/Bằng chứng*

* Bước 2: Chọn khu vực phát sinh

![Hình 4: Giao diện chọn khu vực phát sinh](images/hinh-04.png)
*Hình 4: Giao diện chọn khu vực phát sinh*

* Bước 3: Chọn loại vụ việc

![Hình 5: Chon loại vụ việc](images/hinh-05.png)
*Hình 5: Chon loại vụ việc*

* Bước 4: Chọn mức độ

![Hình 6: Giao diện Chọn mức độ](images/hinh-06.png)
*Hình 6: Giao diện Chọn mức độ*

* Bước 5: Mô tả

![Hình 7: Giao diện Mô tả](images/hinh-07.png)
*Hình 7: Giao diện Mô tả*

* Bước 6: Nhập thông tin đối tượng

![Hình 8: Giao diện Nhập thông tin đối tượng](images/hinh-08.png)
*Hình 8: Giao diện Nhập thông tin đối tượng*

* Bước 6.1: Nhập thông tin bằng option quét giấy tờ → Mở Camera để quét giấy tờ, thông tin sau khi quét được điền tự động vào các trường

![Hình 9: Giao diện Quét giấy tờ](images/hinh-09.png)
*Hình 9: Giao diện Quét giấy tờ*

![Hình 10: Tự động điền thông tin vào các trường từ thông tin quét được](images/hinh-10.png)
*Hình 10: Tự động điền thông tin vào các trường từ thông tin quét được*

* Bước 6.2: Nhập thông tin bằng option Nhập ảnh từ thư viện, upload ảnh giấy tờ, thông tin sau khi quét được điền tự động vào các trường
* Bước 6.3: Nhập thông tin bằng option Thêm đối tượng thủ công. Người giao việc tự điền các trường thông tin thủ công

![Hình 11: Giao diện Thêm đối tượng thủ công](images/hinh-11.png)
*Hình 11: Giao diện Thêm đối tượng thủ công*

* Bước 7: Nhập Đề xuất xử lý

![Hình 12: Giao diện Đề xuất xử lý](images/hinh-12.png)
*Hình 12: Giao diện Đề xuất xử lý*

* Bước 8: Chọn cán bộ để giao việc - có thể chọn 1 hoặc nhiều người

![Hình 13: Giao diện Chọn cán bộ giao việc](images/hinh-13.png)
*Hình 13: Giao diện Chọn cán bộ giao việc*

![Hình 14: Giao diện cán bộ được chọn ở phần Giao việc](images/hinh-14.png)
*Hình 14: Giao diện cán bộ được chọn ở phần Giao việc*

* Bước 9: Chọn thời gian đến hạn hoàn thành công việc

![Hình 15: Giao diện chọn thời gian đến hạn hoàn thành](images/hinh-15.png)
*Hình 15: Giao diện chọn thời gian đến hạn hoàn thành*

![Hình 16: Giao diện khi đã chọn thời gian đến hạn hoàn thành công việc](images/hinh-16.png)
*Hình 16: Giao diện khi đã chọn thời gian đến hạn hoàn thành công việc*

* Click button Giao việc và gửi
→ Kết quả: Tạo thành công 1vụ việc xử lý vi phạm mới, hiện các xử lý vi phạm được tạo ở tab Tiếp nhận

![Hình 17: Giao diện tab Tiếp nhận](images/hinh-17.png)
*Hình 17: Giao diện tab Tiếp nhận*

2. Cán bộ nhận vụ việc xử lý vi phạm được giao
* Đăng nhập vào hệ thống bằng tài khoản hợp lệ
*  Mở đến vụ việc vi phạm được giao - có thể chọn từ tab Của tôi hoặc chọn từ tab Thông báo

![Hình 18: Giao diện tab Của tôi](images/hinh-18.png)
*Hình 18: Giao diện tab Của tôi*

![Hình 19: Giao diện tab Thông báo](images/hinh-19.png)
*Hình 19: Giao diện tab Thông báo*

* Xem chi tiết Vụ việc được giao

![Hình 20: Giao diện chi tiết vụ việc được giao - ảnh 1](images/hinh-20.png)
*Hình 20: Giao diện chi tiết vụ việc được giao - ảnh 1*

![Hình 21: Giao diện chi tiết vụ việc được giao - ảnh 2](images/hinh-21.png)
*Hình 21: Giao diện chi tiết vụ việc được giao - ảnh 2*

![Hình 22: Giao diện chi tiết vụ việc được giao - ảnh 3](images/hinh-22.png)
*Hình 22: Giao diện chi tiết vụ việc được giao - ảnh 3*

* Click button Đang làm để bắt đầu xử lý việc

![Hình 23: Giao diện Chi tiết vụ việc - button Đang làm](images/hinh-23.png)
*Hình 23: Giao diện Chi tiết vụ việc - button Đang làm*

* Sau khi làm xong công việc → Click button Hoàn thành

![Hình 24: Giao diện Chi tiết vụ việc - button Hoàn thành](images/hinh-24.png)
*Hình 24: Giao diện Chi tiết vụ việc - button Hoàn thành*

![Hình 25: Giao diện Yêu cầu nhập Kết quả hoặc lí do khi đã Hoàn thành nhiệm vụ](images/hinh-25.png)
*Hình 25: Giao diện Yêu cầu nhập Kết quả hoặc lí do khi đã Hoàn thành nhiệm vụ*

* Click button Lịch sử để xem lịch sử

![Hình 26: Giao diện Chi tiết vụ việc - Lịch sử](images/hinh-26.png)
*Hình 26: Giao diện Chi tiết vụ việc - Lịch sử*

3. Tạo và ký văn bản
* Mở vụ việc xử lý vi phạm cần yêu cầu tạo và ký biên bản (vd: Vụ việc Phát hiện vật phẩm nguy hiểm cần yêu cầu tạo biên bản và ký xác nhận)

![Hình 27: Chi tiết vụ việc yêu cầu phần Biểu mẫu và chữ ký](images/hinh-27.png)
*Hình 27: Chi tiết vụ việc yêu cầu phần Biểu mẫu và chữ ký*

* Click button Mở biểu mẫu
* Click button Lập biên bản mới

![Hình 28: Giao diện các biểu mẫu trong biểu mẫu và chữ ký](images/hinh-28.png)
*Hình 28: Giao diện các biểu mẫu trong biểu mẫu và chữ ký*

* Kiểm tra và điền đầy đủ các thông tin trong Biểu mẫu - hệ thống đã tự điền các trường thông tin có sẵn

![Hình 29: Giao diện biểu mẫu - ảnh 1](images/hinh-29.png)
*Hình 29: Giao diện biểu mẫu - ảnh 1*

![Hình 30: Giao diện Biểu mẫu - ảnh 2](images/hinh-30.png)
*Hình 30: Giao diện Biểu mẫu - ảnh 2*

![Hình 31: Giao diện Biểu mẫu - ảnh 3](images/hinh-31.png)
*Hình 31: Giao diện Biểu mẫu - ảnh 3*

![Hình 32: Giao diện biểu mẫu - ảnh 3](images/hinh-32.png)
*Hình 32: Giao diện biểu mẫu - ảnh 3*

* Nếu cá nhân thuộc nhóm Hành khách → Yêu cầu nhập thêm trường Chuyến bay và số ghế

![Hình 33: Các trường nhập thêm khi cá nhân là Hành khách](images/hinh-33.png)
*Hình 33: Các trường nhập thêm khi cá nhân là Hành khách*

* Nếu cá nhân thuộc nhóm Cán bộ → Yêu cầu nhập thêm trường Đơn vị công tác

![Hình 34: Trường nhập thêm khi cá nhân là cán bộ](images/hinh-34.png)
*Hình 34: Trường nhập thêm khi cá nhân là cán bộ*

* Thêm thông tin Vật phẩm nguy hiểm

![Hình 35: Các trường nhập thông tin Vật phẩm nguy hiểm](images/hinh-35.png)
*Hình 35: Các trường nhập thông tin Vật phẩm nguy hiểm*

* Kiểm tra lại toàn bộ thông tin và click button Kiểm tra và chốt để ký

![Hình 36: Click button Kiểm tra & chốt để ký](images/hinh-36.png)
*Hình 36: Click button Kiểm tra & chốt để ký*

* Hệ thống tạo biên bản dựa trên các thông tin đã nhập từ biểu mẫu

![Hình 37: Biên bản được tạo - ảnh 1](images/hinh-37.png)
*Hình 37: Biên bản được tạo - ảnh 1*

![Hình 38: Biên bản được tạo - ảnh 2](images/hinh-38.png)
*Hình 38: Biên bản được tạo - ảnh 2*

![Hình 39: Biên bản được tạo - ảnh 3](images/hinh-39.png)
*Hình 39: Biên bản được tạo - ảnh 3*

![Hình 40: Biên bản được tạo - ảnh 4](images/hinh-40.png)
*Hình 40: Biên bản được tạo - ảnh 4*

* Click button Mời cá nhân ký - Cán bộ cần đưa device đang mở hệ thống để cá nhân tham gia ký
* Cần bật toggle Tôi đã đọc và xác nhận nội dung biên bản này thì chữ ký mới hợp lệ và button Xác nhận chữ ký mới được enable

![Hình 41: Giao diện Cá nhân ký](images/hinh-41.png)
*Hình 41: Giao diện Cá nhân ký*

* Click button Đại diện Công an cửa khẩu ký
* Cần bật toggle Tôi đã đọc và xác nhận nội dung biên bản này thì chữ ký mới hợp lệ và button Xác nhận chữ ký mới được enable

![Hình 42: Giao diện Cán bộ ký](images/hinh-42.png)
*Hình 42: Giao diện Cán bộ ký*

* Biên bản sau khi được ký thành công có thể xem lại và mở được bằng file PDF

![Hình 43: Biên bản sau khi ký thành công](images/hinh-43.png)
*Hình 43: Biên bản sau khi ký thành công*

![Hình 44: Biên bản khi xuất định dạng file PDF](images/hinh-44.png)
*Hình 44: Biên bản khi xuất định dạng file PDF*

4. Giao việc
* Đăng nhập vào hệ thống bằng tài khoản hợp lệ
* Ở Trang chủ, chọn Giao việc

![Hình 45: Giao diện Giao việc ở Trang chủ](images/hinh-45.png)
*Hình 45: Giao diện Giao việc ở Trang chủ*

* Ở Trang Giao việc, chọn Button Giao việc

![Hình 46: Button Tạo Giao việc](images/hinh-46.png)
*Hình 46: Button Tạo Giao việc*

* Chọn Mức độ nghiêm trọng và điền các thông tin

![Hình 47: Giao diện điền thông tin giao việc - ảnh 1](images/hinh-47.png)
*Hình 47: Giao diện điền thông tin giao việc - ảnh 1*

![Hình 48: Giao diện điền thông tin giao việc - ảnh 2](images/hinh-48.png)
*Hình 48: Giao diện điền thông tin giao việc - ảnh 2*

* Click button Xác nhận
* → Việc đã giao show ở tab Tôi đã giao ở tài khoản người giao việc
* → Ở tab người được chỉ định việc sẽ show ở tab Giao cho tôi
* → Với các member trong đội không chỉ định giao việc, việc đã giao show ở tab Của Đội

![Hình 49: Giao việc được tạo thành công - hiển thị ở tab Tôi đã giao ở tài khoản người giao](images/hinh-49.png)
*Hình 49: Giao việc được tạo thành công - hiển thị ở tab Tôi đã giao ở tài khoản người giao*

![Hình 50: Giao diện chi tiết giao việc](images/hinh-50.png)
*Hình 50: Giao diện chi tiết giao việc*

5. Các chức năng khác
* Chức năng Gia hạn vụ việc:
   * Mô tả: Người giao việc có thể gia hạn thêm thời gian cho vụ việc nhằm kéo dài thời gian thực hiện nhiệm vụ
   * Các bước thực hiện:
      * Mở vụ việc cần gia hạn
      * Chọn button Gia hạn
      * Nhập ngày giờ, và lí do gia hạn
      * Click Xác nhận
      * → Gia hạn thành công
   * Giao diện:

![Hình 51: Giao diện button Gia hạn](images/hinh-51.png)
*Hình 51: Giao diện button Gia hạn*

![Hình 52: Giao diện Chọn thời gian gia hạn và nhập kết quả/lí do gia hạn](images/hinh-52.png)
*Hình 52: Giao diện Chọn thời gian gia hạn và nhập kết quả/lí do gia hạn*

![Hình 53: Điền thông tin và click button Gia hạn](images/hinh-53.png)
*Hình 53: Điền thông tin và click button Gia hạn*

![Hình 54: Gia hạn vụ việc thành công](images/hinh-54.png)
*Hình 54: Gia hạn vụ việc thành công*

* Chức năng phân công lại:
   * Mô tả: Phân công lại về cán bộ phụ trách vụ việc
   * Các bước thực hiện:
      * Mở vụ việc cần gia hạn
      * Chọn button Phân công lại
      * Nhập lí do và chọn cán bộ phụ trách mới
      * → Phân công lại thành công
   * Giao diện:

![Hình 55: Giao diện button Phân công lại](images/hinh-55.png)
*Hình 55: Giao diện button Phân công lại*

![Hình 56: Giao diện Màn phân công lại](images/hinh-56.png)
*Hình 56: Giao diện Màn phân công lại*

![Hình 57: Nhập lí do và chọn Cán bộ phụ trách mới](images/hinh-57.png)
*Hình 57: Nhập lí do và chọn Cán bộ phụ trách mới*

![Hình 58: Phân công lại thành công - hiện tên cán bộ phụ trách mới](images/hinh-58.png)
*Hình 58: Phân công lại thành công - hiện tên cán bộ phụ trách mới*

* Chức năng Huỷ phần việc:
   * Mô tả: Huỷ phần việc đã giao
   * Các bước thực hiện:;
      * Mở vụ việc cần huỷ
      * Chọn button Huỷ phần việc
      * Nhập lí do huỷ
      * Click button Xác nhận
   * Giao diện:

![Hình 59: Giao diện button Huỷ phần việc](images/hinh-59.png)
*Hình 59: Giao diện button Huỷ phần việc*

![Hình 60: Giao diện điền lí do huỷ phần việc](images/hinh-60.png)
*Hình 60: Giao diện điền lí do huỷ phần việc*

![Hình 61: Nhập lí do và click button Xác nhận](images/hinh-61.png)
*Hình 61: Nhập lí do và click button Xác nhận*

![Hình 62: Kết quả Huỷ phần việc thành công](images/hinh-62.png)
*Hình 62: Kết quả Huỷ phần việc thành công*

* Chức năng phân công tiếp:
   * Mô tả: Chỉ định cán bộ cùng thực hiện vụ việc này
   * Các bước thực hiện:
      * Mở vụ việc cần Phân công tiếp
      * Chọn button Phân công tiếp
      * Chọn Cán bộ và nhập kết quả/lí do
      * Click button Xác nhận
   * Giao diện:

![Hình 63: Giao diện button Phân công tiếp](images/hinh-63.png)
*Hình 63: Giao diện button Phân công tiếp*

![Hình 64: Giao diện Phân công tiếp](images/hinh-64.png)
*Hình 64: Giao diện Phân công tiếp*

![Hình 65: Chọn cán bộ, nhập lí do và Xác nhận](images/hinh-65.png)
*Hình 65: Chọn cán bộ, nhập lí do và Xác nhận*

![Hình 66: Phân công tiếp thành công](images/hinh-66.png)
*Hình 66: Phân công tiếp thành công*

* Xuất Báo cáo hằng ngày:
   * Đối tượng có thể dùng: Chỉ người được quyền giao việc
   * Mô tả: Xuất báo cáo theo ngày chỉ định
   * Các bước thực hiện:
      * Chọn tab Cá nhân
      * Chọn Báo cáo hằng ngày
      * Chọn ngày
      * Click button Xem/Xuất PDF
   * Giao diện:

![Hình 67: Giao diện tab Cá nhân](images/hinh-67.png)
*Hình 67: Giao diện tab Cá nhân*

![Hình 68: Chọn ngày cần báo cáo](images/hinh-68.png)
*Hình 68: Chọn ngày cần báo cáo*

![Hình 69: Các mục có thể mở rộng để xem nội dung bên trong - vd mục Thông tin chung](images/hinh-69.png)
*Hình 69: Các mục có thể mở rộng để xem nội dung bên trong - vd mục Thông tin chung*

![Hình 70: Các mục có thể mở rộng để xem nội dung bên trong - vd mục Phát sinh](images/hinh-70.png)
*Hình 70: Các mục có thể mở rộng để xem nội dung bên trong - vd mục Phát sinh*

![Hình 71: Demo file Báo cáo được xuất ra](images/hinh-71.png)
*Hình 71: Demo file Báo cáo được xuất ra*

* Ký lại biên bản:
   * Mô tả:
