# Phân tích và đặc tả chức năng — Xử lý vi phạm và Giao việc (v2.1)

> **Nguồn:** `Phan-tich-va-dac-ta-Xu-ly-vi-pham-va-Giao-viec.html` (kèm bản `.docx` cùng tên), phiên bản **2.1 – Bản để
> khách hàng duyệt**, ngày 22/10/2026. Đưa vào repo ngày 2026-10-26; nội dung giữ **nguyên văn** (chỉ chuyển
> HTML → Markdown; 1 hình sơ đồ trạng thái ở `images/dac-ta-hinh-01.png`).
> **Vai trò trong pipeline:** **test basis chính** của module Xử lý vi phạm + Giao việc (ứng dụng di động).
> **Quan hệ với tài liệu khác** (QC lead chốt 2026-10-26): **bổ sung** cho
> [mo-ta-chuc-nang-v1.md](mo-ta-chuc-nang-v1.md) — khi mâu thuẫn, **đặc tả này được ưu tiên**. Đọc kèm
> [lam-ro-2026-10-26.md](lam-ro-2026-10-26.md) mục "Đối chiếu với đặc tả v2.1" (2 điểm khác nhau đã ghi nhận).
>
> ⚠️ **Trùng ký hiệu:** `[Bn]` trong tài liệu này là quyết định của khách hàng ở **Phụ lục B của đặc tả** — KHÁC với câu
> hỏi chặn B1–B7 trong `test-analysis-mo-ta-v1-SUPERSEDED.md` (đã xoá 2026-10-28, xem git `5fc75a6`). Khi trích dẫn trong tài liệu QC, ghi rõ "đặc tả [B7]" hoặc "TA-B7".
> ⚠️ Các điểm `[Bn*]`, `[Q37*]` là **giả định chưa được khách hàng xác nhận** (Phụ lục B: B25–B27) — không dùng làm fact.
> Bảng 39 câu hỏi `[Qn]` được tham chiếu nhưng **chưa có trong repo** (chỉ có tóm tắt ở Phụ lục A).

**HỆ THỐNG QUẢN LÝ VỤ VIỆC CÔNG AN CỬA KHẨU NỘI BÀI — PHÂN TÍCH VÀ ĐẶC TẢ CHỨC NĂNG XỬ LÝ VI PHẠM VÀ GIAO VIỆC**

Phiên bản 2.1 – Bản để khách hàng duyệt

Ngày 22 tháng 10 năm 2026

| **Nguồn thông tin** | Bản mô tả chức năng Xử lý vi phạm và Giao việc (bản cập nhật, kèm 71 ảnh màn hình ứng dụng); bảng 39 câu hỏi làm rõ với câu trả lời của khách hàng. |
|---|---|
| **Trạng thái** | 30 trong 39 câu hỏi và cả 24 điểm ở Phụ lục B đã có quyết định; còn 3 điểm mới (B25–B27) và Q37 dùng giả định. |
| **Phạm vi** | Ứng dụng di động. Trang quản trị web đặc tả riêng. |

## Lịch sử thay đổi

| **Phiên bản** | **Ngày** | **Nội dung** |
|---|---|---|
| 1.0 | 21/10/2026 | Bản đặc tả đầu tiên, lập từ bản mô tả, ảnh màn hình và 30 câu trả lời của khách hàng. |
| 1.1 | 21/10/2026 | Bổ sung mô tả chi tiết ba tính năng chính (mục 2.4) và các chức năng bổ trợ (mục 2.5): mục đích, điều kiện, người tham gia, các bước thực hiện, kết quả đạt được. |
| 2.0 | 22/10/2026 | Viết lại theo bản mô tả cập nhật: tách thành hai chức năng độc lập Xử lý vi phạm (nút +) và Giao việc (option Giao việc); đổi mã use case thành XL, GV, CH; thêm trạng thái việc giao, điểm mở B22–B24. |
| 2.1 | 22/10/2026 | Bổ sung quyết định của khách hàng cho 24 điểm ở Phụ lục B vào toàn bộ tài liệu; XL05 và GV03 chỉ còn thêm ảnh và điều chỉnh; đổi phân quyền tab Tiếp nhận, Của tôi; thêm điểm mở B25–B27. |

## Mục lục

1. Giới thiệu

1.1. Mục đích

1.2. Phạm vi

1.3. Tài liệu tham chiếu

1.4. Quy ước trình bày

1.5. Thuật ngữ

2. Tổng quan chức năng

2.1. Mục tiêu nghiệp vụ

2.2. Hai chức năng độc lập

2.3. Danh sách use case

2.4. Mô tả chi tiết các tính năng chính

2.5. Các chức năng bổ trợ

3. Tác nhân và phân quyền

3.1. Tác nhân

3.2. Phạm vi giao việc

3.3. Ủy quyền Tổ phó

3.4. Ma trận quyền theo chức năng

4. Mô hình trạng thái

4.1. Phần việc (dùng chung)

4.2. Vụ việc xử lý vi phạm

4.3. Việc giao

5. Chức năng Xử lý vi phạm

XL01 – Tạo vụ việc xử lý vi phạm

XL02 – Tiếp nhận, thực hiện và hoàn thành vụ việc

XL03 – Lập và ký biên bản

XL04 – Ký lại biên bản

XL05 – Bổ sung ảnh và điều chỉnh vụ việc sau khi tạo

6. Chức năng Giao việc

GV01 – Tạo giao việc

GV02 – Nhận việc, thực hiện và hoàn thành việc được giao

GV03 – Bổ sung ảnh và điều chỉnh việc giao sau khi tạo

7. Chức năng dùng chung

CH01 – Gia hạn

CH02 – Phân công lại

CH03 – Phân công tiếp

CH04 – Huỷ phần việc

CH05 – Xem thống kê trên Trang chủ

CH06 – Xuất báo cáo hằng ngày

CH07 – Thông báo, nhắc việc và nhật ký

8. Mô hình dữ liệu logic

8.1. Thực thể

8.2. Danh mục

9. Quy tắc nghiệp vụ

10. Yêu cầu phi chức năng

Phụ lục A. Tổng hợp quyết định của khách hàng

Phụ lục B. Quyết định cho các điểm còn mở

Phụ lục C. Điểm chưa nhất quán của tài liệu nguồn và cách xử lý

# 1. Giới thiệu

## 1.1. Mục đích

Tài liệu mô tả hai chức năng **Xử lý vi phạm** (tạo vụ việc xử lý vi phạm) và **Giao việc** trên ứng dụng di động của Hệ thống Quản lý vụ việc Công an cửa khẩu (CACK) Nội Bài. Tài liệu là cơ sở thống nhất giữa nghiệp vụ, thiết kế, lập trình và kiểm thử.

Nội dung được lập từ bản mô tả chức năng Xử lý vi phạm và Giao việc (bản cập nhật), 71 ảnh màn hình ứng dụng kèm theo và các câu trả lời của khách hàng cho 39 câu hỏi làm rõ. Các quyết định đã chốt được tổng hợp ở Phụ lục A; các điểm còn dùng giả định hoặc chưa có thông tin nằm ở Phụ lục B.

## 1.2. Phạm vi

**Trong phạm vi:**

- **Xử lý vi phạm:** tạo vụ việc xử lý vi phạm và giao cán bộ; tiếp nhận, thực hiện, hoàn thành vụ việc; lập và ký biên bản điện tử; ký lại biên bản; sửa vụ việc.

- **Giao việc:** tạo giao việc; nhận việc, thực hiện, hoàn thành việc được giao; theo dõi việc ở các tab Giao cho tôi, Tôi đã giao, Của Đội.

- **Dùng chung cho cả hai:** gia hạn, phân công lại, phân công tiếp, huỷ phần việc; thống kê trên Trang chủ; báo cáo hằng ngày; thông báo, nhắc việc và nhật ký.

**Ngoài phạm vi giai đoạn này:**

- Nút "Xử lý tại chỗ và hoàn thành" ở bước cuối tạo vụ việc xử lý vi phạm [Q4].

- Bộ lọc trạng thái Chờ tiếp nhận, Đang xử lý tại Đội, Chờ chỉ đạo [Q5]; trạng thái Đã đóng và Chờ chỉ đạo tạm thời bỏ qua [B4].

- Hoạt động ngoại tuyến và thông báo qua SMS [Q32].

- Tích hợp hệ thống ngoài: tra biển số xe, chuyến bay và số ghế, CSDL dân cư, hồ sơ cán bộ, hệ thống nhà ga [Q35].

- Tệp đính kèm khác ngoài ảnh [Q20].

- Các nội dung khách hàng chọn bỏ qua: nguồn Camera và Chỉ đạo [B14]; thời gian lưu dữ liệu, sao lưu, số người dùng đồng thời [B17]; biên bản song ngữ [B18].

- Trang quản trị web (quản lý tài khoản, ủy quyền, danh mục, cấu hình biểu mẫu, xem kết quả) sẽ đặc tả riêng [Q37*]; tài liệu này chỉ nêu những gì ứng dụng di động cần từ trang quản trị.

- Các mô-đun khác trong menu Cá nhân: Điểm danh ca trực, Bảng điểm KPI, Cân hàng hoá, Sổ bàn giao, Sổ liên lạc, Kiểm soát phương tiện, Tra cứu vi phạm, Tra cứu đồ thất lạc, Đồ vô chủ, Thư viện giấy tờ.

## 1.3. Tài liệu tham chiếu

- "Mô tả chức năng Xử lý vi phạm và Giao việc" (bản cập nhật, kèm 71 ảnh màn hình ứng dụng; dữ liệu thử ngày 20–22/10/2026).

- Bảng câu hỏi và trả lời làm rõ yêu cầu (39 câu), cập nhật ngày 21/10/2026.

- Phụ lục B (24 điểm còn mở) đã được khách hàng trả lời ngày 22/10/2026.

## 1.4. Quy ước trình bày

| **Ký hiệu** | **Ý nghĩa** |
|---|---|
| **[Qn]** | Quy tắc do khách hàng đã trả lời ở câu hỏi số n (xem Phụ lục A). |
| **[Bn]** | Quyết định của khách hàng cho điểm còn mở ở Phụ lục B (trả lời ngày 22/10/2026). |
| **[Bn*]**, **[Q37*]** | Giả định tạm thời, khách hàng chưa xác nhận (xem Phụ lục B, các điểm B25–B27). |
| **(ảnh)** | Chi tiết thấy trong ảnh màn hình nhưng bản mô tả bằng chữ không nêu. |
| **(suy ra)** | Điều suy ra từ dữ liệu trong ảnh, cần khách hàng xác nhận khi nghiệm thu. |
| **XL, GV, CH** | Mã use case: XL = Xử lý vi phạm; GV = Giao việc; CH = dùng chung cho cả hai. |

## 1.5. Thuật ngữ

| **Thuật ngữ** | **Ý nghĩa** |
|---|---|
| **CACK** | Công an cửa khẩu. |
| **Xử lý vi phạm** | Chức năng tạo vụ việc xử lý vi phạm, mở bằng nút + (Tạo vụ việc) ở Trang chủ. |
| **Giao việc** | Chức năng giao nhiệm vụ cho cán bộ, mở bằng option Giao việc ở Trang chủ. |
| **Vụ việc** | Vụ việc xử lý vi phạm: sự việc phát sinh tại cửa khẩu, có mã dạng VV000156, gồm khu vực, loại, mức độ, đối tượng, bằng chứng. |
| **Việc giao** | Nhiệm vụ tạo ở chức năng Giao việc; không gắn khu vực, loại vụ việc, đối tượng. |
| **Phần việc** | Nhiệm vụ giao cho **một** cán bộ, trong vụ việc hoặc việc giao. Mỗi cán bộ được giao có một phần việc riêng với tiến độ, hạn và kết quả riêng. |
| **Người giao** | Người có quyền giao việc hoặc tạo vụ việc (xem mục 3). |
| **Cán bộ được chỉ định** | Cán bộ được giao một phần việc. |
| **Biên bản** | Văn bản điện tử lập từ biểu mẫu, có chữ ký tay của cá nhân liên quan và cán bộ đại diện CACK trên thiết bị của cán bộ. |
| **Cá nhân** | Người liên quan tham gia biên bản: hành khách hoặc cán bộ, nhân viên. Không có tài khoản. |
| **Đội, Tổ** | Đơn vị tổ chức của cán bộ, ví dụ Đội Tester, Tổ Tổng hợp. |

# 2. Tổng quan chức năng

## 2.1. Mục tiêu nghiệp vụ

- Quản lý việc giao và việc xử lý vi phạm tới từng nhân sự theo phân quyền và vai trò của người dùng.

- Cán bộ nhận việc, xử lý và báo cáo ngay trên điện thoại cá nhân; người quản lý nắm thông tin sớm nhất, giảm giấy tờ và thủ tục.

- Quản lý nhiều việc và nhiều nhân sự cùng lúc, không thiếu thông tin trong quá trình giao nhận và làm việc.

- Lập và ký biên bản ngay tại hiện trường, lưu tự động, truy xuất được.

- Lưu nhật ký theo từng tài khoản; thông báo cho người giao và cấp trên.

## 2.2. Hai chức năng độc lập

**Xử lý vi phạm** và **Giao việc** là hai chức năng hoàn toàn khác nhau. Người giao mở Giao việc bằng option **Giao việc**; mở Tạo vụ việc xử lý vi phạm bằng nút **+** ở Trang chủ [Q1].

| **Tiêu chí** | **Xử lý vi phạm** | **Giao việc** |
|---|---|---|
| **Mục đích** | Ghi nhận và xử lý một vi phạm hoặc sự việc phát sinh tại cửa khẩu, giao cán bộ xử lý, lập biên bản khi cần. | Giao một nhiệm vụ bất kỳ cho cán bộ, không cần địa điểm hay vụ việc. |
| **Điểm vào** | Nút + (Tạo vụ việc) ở Trang chủ và tab Của tôi. | Option Giao việc ở Trang chủ, rồi nút Giao việc; hoặc Cá nhân → Giao việc. |
| **Cách nhập** | 9 bước, chọn các tuỳ chọn đã cấu hình sẵn: khu vực, loại, mức độ, mô tả, đối tượng, đề xuất xử lý, cán bộ, hạn. | Biểu mẫu gọn: mức độ, nội dung, hạn, ảnh, đội và cán bộ nhận. |
| **Khu vực, loại, đối tượng** | Khu vực và loại bắt buộc; đối tượng tuỳ chọn. | Không có. |
| **Nơi hiển thị việc đã giao** | Tab **Tiếp nhận** và tab **Của tôi** (cán bộ chỉ thấy tab Của tôi) [B24]. | Màn Giao việc, ba tab **Giao cho tôi**, **Tôi đã giao**, **Của Đội**. |
| **Màn chi tiết** | Chi tiết vụ việc. | Chi tiết giao việc. |
| **Biên bản và chữ ký** | Có, theo loại vụ việc (hiện chỉ "Phát hiện vật phẩm nguy hiểm") [Q19]. | Không. |
| **Sửa sau khi tạo** | Chỉ thêm ảnh vào Hình ảnh/Bằng chứng; thông tin đã nhập không sửa được; điều chỉnh bằng Phân công lại, Gia hạn, Huỷ, Phân công tiếp [B21]. | Tương tự vụ việc xử lý vi phạm [B22]. |

Điểm chung: cả hai sinh phần việc cho từng cán bộ với tiến độ, hạn, kết quả, nhật ký riêng, và dùng chung các thao tác Gia hạn, Phân công lại, Phân công tiếp, Huỷ phần việc, Lịch sử, cùng thống kê, báo cáo, thông báo. Ảnh cho thấy mã hiển thị của cả hai đều có tiền tố VV; hai chức năng dùng chung một chuỗi mã bắt đầu bằng VV [B1].

## 2.3. Danh sách use case

| **Mã** | **Use case** | **Ai dùng** | **Mục** |
|---|---|---|---|
| XL01 | Tạo vụ việc xử lý vi phạm (9 bước) | Người giao | 5 |
| XL02 | Tiếp nhận, thực hiện và hoàn thành vụ việc | Cán bộ được chỉ định; người giao (hoàn thành thay) | 5 |
| XL03 | Lập và ký biên bản | Cán bộ được chỉ định; cá nhân liên quan | 5 |
| XL04 | Ký lại biên bản | Cán bộ được chỉ định; người giao | 5 |
| XL05 | Bổ sung ảnh và điều chỉnh vụ việc sau khi tạo | Người giao; cán bộ được chỉ định (thêm ảnh) | 5 |
| GV01 | Tạo giao việc | Người giao | 6 |
| GV02 | Nhận việc, thực hiện và hoàn thành việc được giao | Cán bộ được chỉ định; người giao (hoàn thành thay) | 6 |
| GV03 | Bổ sung ảnh và điều chỉnh việc giao sau khi tạo | Người giao; cán bộ được chỉ định (thêm ảnh) | 6 |
| CH01 | Gia hạn | Người giao | 7 |
| CH02 | Phân công lại | Người giao | 7 |
| CH03 | Phân công tiếp | Người giao | 7 |
| CH04 | Huỷ phần việc | Người giao | 7 |
| CH05 | Xem thống kê trên Trang chủ | Mọi thành viên của Đội | 7 |
| CH06 | Xuất báo cáo hằng ngày | Đội trưởng; Phó trưởng và Trưởng CACK | 7 |
| CH07 | Thông báo, nhắc việc và nhật ký | Hệ thống | 7 |

## 2.4. Mô tả chi tiết các tính năng chính

Bản mô tả cập nhật nêu bốn tính năng chính: **Tạo vụ việc xử lý vi phạm giao đến cán bộ**, **Tạo giao việc**, **Tạo biểu mẫu xử lý vụ việc** và **Xem thống kê**. Mỗi tính năng dưới đây nêu mục đích, điều kiện, người tham gia, các bước thực hiện và kết quả đạt được. Chi tiết trường nhập và quy tắc nằm ở mục 5 đến 7 (use case) và mục 9 (quy tắc nghiệp vụ).

| **Tính năng chính** | **Chức năng** | **Use case liên quan** |
|---|---|---|
| **1. Tạo vụ việc xử lý vi phạm giao đến cán bộ** | Xử lý vi phạm | XL01, XL02, XL05 và CH01–CH04, CH07 |
| **2. Tạo giao việc** | Giao việc | GV01, GV02, GV03 và CH01–CH04, CH07 |
| **3. Tạo biểu mẫu xử lý vụ việc (lập và ký biên bản)** | Xử lý vi phạm | XL03, XL04 |
| **4. Xem thống kê** | Cả hai | CH05, CH06 |

### Tính năng 1 – Tạo vụ việc xử lý vi phạm giao đến cán bộ

| **Mục đích** | Tạo vụ việc cần xử lý vi phạm và giao đến cán bộ xử lý sự việc. Quản lý và giao vụ việc tới từng nhân sự theo phân quyền và vai trò; cán bộ nhận vụ việc linh hoạt qua ứng dụng trên điện thoại cá nhân, báo cáo nhanh về người quản lý. Người quản lý nắm thông tin sớm nhất, giảm giấy tờ và thủ tục, quản lý nhiều vụ việc và nhân sự cùng lúc, không thiếu thông tin trong quá trình giao nhận và làm việc. |
|---|---|
| **Điều kiện** | • Cả hai bên đã đăng nhập bằng tài khoản do quản trị viên tạo; thiết bị có kết nối mạng [Q32, Q33].• Người giao thuộc một trong sáu vai trò có quyền giao việc hoặc được ủy quyền Tổ phó [Q2, Q4].• Người nhận là cán bộ nằm trong phạm vi giao: Đội mình phụ trách, hoặc toàn bộ các Đội đối với Trưởng, Phó trưởng CACK [Q3].• Danh mục khu vực, loại vụ việc, đề xuất xử lý đã được cấu hình trên trang quản trị [Q19]. |
| **Người tham gia** | • **Người giao:** tạo vụ việc, giao cán bộ, theo dõi, điều chỉnh.• **Cán bộ được chỉ định:** nhận vụ việc, xử lý, báo cáo kết quả.• **Đội trưởng của Đội (cấp trên):** nhận thông báo [B20].• **Quản trị viên:** tạo tài khoản, ủy quyền, cấu hình danh mục.• **Hệ thống:** ghi nhật ký, gửi thông báo, nhắc việc. |
| **Kết quả đạt được** | • Tạo thành công một vụ việc xử lý vi phạm mới; vụ việc hiện ở tab Tiếp nhận và Của tôi của người giao, tab Của tôi của cán bộ [B24].• Xử lý vi phạm được giao hoàn thành, kết quả và lý do được ghi lại.• Nhật ký lưu ở từng tài khoản; kết quả lưu vào trang quản trị chung.• Thông báo tới người giao và cấp trên khi hoàn thành.• Thống kê Trang chủ và báo cáo hằng ngày cập nhật theo. |

**A. Người giao tạo vụ việc xử lý vi phạm và giao việc (XL01)**

| **Bước** | **Người thực hiện** | **Thao tác** | **Phản hồi của hệ thống** |
|---|---|---|---|
| 1 | Người giao | Đăng nhập; bấm nút **+ Tạo vụ việc** ở Trang chủ hoặc tab Của tôi. | Mở màn hình "Tạo vụ việc", Bước 1/9, có thanh tiến độ. |
| 2 | Người giao | Bước 1: chụp ảnh hoặc chọn ảnh bằng chứng từ thư viện (không bắt buộc). | Hiện ảnh đã chọn; nút Tiếp tục sáng. |
| 3 | Người giao | Bước 2: chọn khu vực phát sinh. | Đánh dấu lựa chọn. |
| 4 | Người giao | Bước 3: chọn loại vụ việc, hoặc "Khác" rồi nhập tên loại. | Nút Tiếp tục chỉ sáng khi đã chọn. |
| 5 | Người giao | Bước 4: chọn mức độ Bình thường, Nghiêm trọng hoặc Khẩn cấp. | Mức Khẩn cấp hiển thị ghi chú "Cảnh báo Lãnh đạo + BCH đội". |
| 6 | Người giao | Bước 5: nhập Mô tả vụ việc (bắt buộc); có thể nhập Vị trí cụ thể và Hành động đã thực hiện; có thể đọc bằng micro. | Nút Tiếp tục sáng khi đã có mô tả. |
| 7 | Người giao | Bước 6: thêm đối tượng bằng Quét giấy tờ, Từ thư viện hoặc Thêm thủ công; nhập biển số xe, đơn vị liên quan (không bắt buộc). | Thông tin quét tự điền vào các trường; người giao kiểm tra và sửa. Không lưu ảnh giấy tờ [Q18]. |
| 8 | Người giao | Bước 7: chọn một hoặc nhiều đề xuất xử lý (không bắt buộc). | Ghi nhận lựa chọn. |
| 9 | Người giao | Bước 8: chọn Đội nhận việc; tìm theo email và chọn một hoặc nhiều cán bộ. | Hiện cán bộ đã chọn kèm Đội và vai trò. |
| 10 | Người giao | Bước 9: kiểm tra tóm tắt, chọn ngày và giờ hạn hoàn thành; bấm **Giao việc và gửi**. | Tạo vụ việc có mã VV; tạo một phần việc "Đã giao" cho mỗi cán bộ; tính thời điểm nhắc việc; ghi nhật ký "Giao việc"; gửi thông báo "Bạn có phần việc mới"; vụ việc hiện ở tab Tiếp nhận và Của tôi của người giao, tab Của tôi của cán bộ [B24]. |

**B. Cán bộ nhận và xử lý vụ việc xử lý vi phạm (XL02)**

| **Bước** | **Người thực hiện** | **Thao tác** | **Phản hồi của hệ thống** |
|---|---|---|---|
| 1 | Cán bộ | Đăng nhập; nhận thông báo "Bạn có phần việc mới". | Thông báo hiện ở tab Thông báo, in đậm cho đến khi đọc. |
| 2 | Cán bộ | Mở vụ việc từ tab **Của tôi** hoặc tab **Thông báo** (cán bộ chỉ có tab Của tôi) [B24]. | Mở màn Chi tiết vụ việc. |
| 3 | Cán bộ | Đọc chi tiết: loại, mức độ, đối tượng, đề xuất xử lý, bằng chứng, hạn, thời điểm nhắc việc, diễn biến xử lý. | Hiển thị các khối thông tin của vụ việc và phần việc của mình. |
| 4 | Cán bộ | Bấm **Đang làm** để bắt đầu (không bắt buộc) [Q6]. | Tiến độ chuyển Đang tiến hành; nhật ký ghi "Bắt đầu thực hiện". |
| 5 | Cán bộ | Xử lý vi phạm; bổ sung ảnh bằng chứng; lập biên bản nếu loại vụ việc có biểu mẫu (tính năng 3). | Ảnh mới lưu vào vụ việc. |
| 6 | Cán bộ | Bấm **Hoàn thành**, nhập kết quả hoặc lý do, bấm **Xác nhận**. | Nếu để trống thì báo "Yêu cầu nhập Kết quả hoặc lí do khi chọn Hoàn thành". Nếu hợp lệ: phần việc Hoàn thành, ghi giờ thực tế và kết quả đúng hạn hay không, ghi nhật ký, thông báo cho người giao và cấp trên. |
| 7 | Cán bộ | Bấm **Lịch sử** để xem các mốc xử lý. | Liệt kê giờ, người thực hiện, hành động. |

Người giao theo dõi và điều chỉnh bằng Gia hạn, Phân công lại, Phân công tiếp, Huỷ phần việc, Hoàn thành thay (mục 7, CH01–CH04) và có thể sửa vụ việc (XL05).

**Luồng thay thế và ngoại lệ**

- Thiếu trường bắt buộc: nút Tiếp tục hoặc gửi không sáng.

- Quá hạn: phần việc giữ tiến độ, Kết quả đổi thành "Không hoàn thành đúng hạn"; vụ việc có nhãn "Quá hạn xử lý"; thông báo người giao và người nhận việc [B6].

- Nhắc việc: gửi một lần cho cán bộ tại thời điểm giao + 2/3 thời gian đến hạn [Q14].

- Mất mạng: không thao tác được, ứng dụng không hỗ trợ ngoại tuyến [Q32].

- Cán bộ chưa được chỉ định chỉ xem được nút Lịch sử [Q7].

### Tính năng 2 – Tạo giao việc

| **Mục đích** | Tạo giao việc và giao đến cán bộ xử lý công việc đó. Người giao giao bất kỳ nhiệm vụ nào cho người nhận, không cần chọn địa điểm hay vụ việc [Q1]. Cán bộ nhận việc, thực hiện và báo cáo ngay trên điện thoại; người giao theo dõi nhiều việc và nhân sự cùng lúc. |
|---|---|
| **Điều kiện** | • Cả hai bên đã đăng nhập; thiết bị có kết nối mạng [Q32, Q33].• Người giao thuộc một trong sáu vai trò có quyền giao việc hoặc được ủy quyền Tổ phó [Q2].• Người nhận nằm trong phạm vi giao [Q3]. |
| **Người tham gia** | • **Người giao:** tạo giao việc, theo dõi, điều chỉnh.• **Cán bộ được chỉ định:** nhận việc, xử lý, báo cáo kết quả.• **Thành viên Đội khác:** xem việc ở tab Của Đội.• **Hệ thống:** ghi nhật ký, gửi thông báo, nhắc việc. |
| **Kết quả đạt được** | • Việc được giao hoàn thành, kết quả được ghi lại.• Nhật ký lưu ở từng tài khoản; thông báo tới người giao và cấp trên; kết quả lưu vào trang quản trị chung.• Việc hiện ở tab **Tôi đã giao** của người giao, tab **Giao cho tôi** của người được chỉ định, tab **Của Đội** của các thành viên Đội khác. |

**A. Người giao tạo giao việc (GV01)**

| **Bước** | **Người thực hiện** | **Thao tác** | **Phản hồi của hệ thống** |
|---|---|---|---|
| 1 | Người giao | Đăng nhập; ở Trang chủ chọn option **Giao việc**. | Mở màn hình Giao việc với ba tab Giao cho tôi, Tôi đã giao, Của Đội. |
| 2 | Người giao | Bấm nút **Giao việc**. | Mở biểu mẫu "Giao việc". |
| 3 | Người giao | Chọn mức độ nghiêm trọng; nhập nội dung; chọn ngày và giờ hạn; thêm ảnh nếu cần; chọn Đội và cán bộ nhận việc. | Nút Giao việc và gửi chỉ sáng khi đủ trường bắt buộc. |
| 4 | Người giao | Bấm **Giao việc và gửi** (hoặc Xác nhận). | Việc hiện ở tab Tôi đã giao của người giao, Giao cho tôi của cán bộ được chỉ định, Của Đội của thành viên khác; gửi thông báo; ghi nhật ký. |

**B. Cán bộ nhận việc được giao (GV02)**

| **Bước** | **Người thực hiện** | **Thao tác** | **Phản hồi của hệ thống** |
|---|---|---|---|
| 1 | Cán bộ | Đăng nhập; nhận thông báo "Bạn có phần việc mới". | Thông báo hiện ở tab Thông báo. |
| 2 | Cán bộ | Ở Trang chủ chọn option **Giao việc**, mở tab **Giao cho tôi**, bấm vào việc (hoặc mở từ tab Thông báo). | Mở màn Chi tiết giao việc. |
| 3 | Cán bộ | Đọc nội dung, mức độ, hạn hoàn thành, giờ giao, ảnh đính kèm. | Hiển thị phần việc của mình với NỘI DUNG, TIẾN ĐỘ, Hạn, NHẮC VIỆC, KẾT QUẢ. |
| 4 | Cán bộ | Bấm **Đang làm** để bắt đầu (không bắt buộc) [Q6]. | Tiến độ Đang tiến hành; nhật ký ghi "Bắt đầu thực hiện". |
| 5 | Cán bộ | Làm xong, bấm **Hoàn thành**, nhập kết quả hoặc lý do, **Xác nhận**. | Phần việc Hoàn thành; ghi giờ thực tế; thông báo cho người giao và cấp trên; ghi nhật ký. |
| 6 | Cán bộ | Bấm **Lịch sử** để xem các mốc. | Liệt kê giờ, người thực hiện, hành động. |

Người giao theo dõi ở tab Tôi đã giao và điều chỉnh bằng Gia hạn, Phân công lại, Phân công tiếp, Huỷ phần việc, Hoàn thành thay (mục 7, CH01–CH04).

### Tính năng 3 – Tạo biểu mẫu xử lý vụ việc (lập và ký biên bản)

| **Mục đích** | Một số vụ việc xử lý vi phạm cần lập biểu mẫu xử lý và có chữ ký của hai bên, ví dụ hành khách trên chuyến bay và cán bộ được giao xử lý, hoặc cán bộ tham gia vụ việc và cán bộ được giao xử lý. Tạo văn bản nhanh chóng, ký xác nhận giữa hai bên ngay trên thiết bị mà không cần giấy tờ đi kèm làm kéo dài thời gian. Biên bản lưu tự động trên hệ thống, dễ truy xuất. |
|---|---|
| **Điều kiện** | • Người lập là cán bộ được chỉ định xử lý vụ việc.• Vụ việc thuộc loại có biểu mẫu; hiện chỉ "Phát hiện vật phẩm nguy hiểm" [Q19]; biểu mẫu đã cấu hình trên trang quản trị [Q22].• Cá nhân cần ký có mặt tại chỗ để nhận thiết bị của cán bộ.• Thiết bị có kết nối mạng [Q32].• Hồ sơ cán bộ có cấp bậc, số hiệu CAND, chức vụ; thiếu thì cán bộ nhập tay [B11]. |
| **Người tham gia** | • **Cán bộ được chỉ định:** lập biên bản, ký đại diện Công an cửa khẩu.• **Cá nhân liên quan:** hành khách hoặc cán bộ, nhân viên; đọc và ký trên thiết bị của cán bộ.• **Người giao:** tạo biên bản mới khi cần ký lại [Q26].• **Quản trị viên:** cấu hình biểu mẫu và hồ sơ cán bộ.• **Hệ thống:** tự điền, tạo văn bản, lưu và xuất PDF. |
| **Kết quả đạt được** | • Lập biên bản thành công, hai bên ký xác nhận nhanh, không cần giấy tờ kèm theo.• Biên bản trạng thái Hoàn tất, lưu tự động trên hệ thống, xem lại và mở được dạng PDF.• Kết quả lưu trên trang quản trị, dễ tra cứu.• Thiếu chữ ký của một bên thì biên bản giữ trạng thái Chờ ký [Q24]. |

**Các bước thực hiện (XL03)**

| **Bước** | **Người thực hiện** | **Thao tác** | **Phản hồi của hệ thống** |
|---|---|---|---|
| 1 | Cán bộ | Mở vụ việc xử lý vi phạm cần lập biên bản (ví dụ "Phát hiện vật phẩm nguy hiểm") từ tab Của tôi, ở khối "Biểu mẫu và chữ ký" bấm **Mở biểu mẫu**. | Mở màn "Biểu mẫu và chữ ký" với các bước Điền, Kiểm tra, Cá nhân ký, Cán bộ ký; biên bản hiện "Chưa lập". |
| 2 | Cán bộ | Bấm **+ Lập biên bản mới**. | Mở biểu mẫu với các trường đã có được tự điền (đơn vị lập, cán bộ, thông tin cá nhân từ đối tượng); trường thiếu để trống. |
| 3 | Cán bộ | Kiểm tra và điền đủ: thông tin biên bản (đơn vị, thời gian bắt đầu, địa điểm); thành phần tham gia (cán bộ, cá nhân và nhóm của cá nhân); vật phẩm nguy hiểm (nhiều dòng); biện pháp xử lý; tài liệu kèm theo; thời gian kết thúc. | Cá nhân thuộc nhóm Hành khách thì yêu cầu thêm Chuyến bay, Số ghế; nhóm Cán bộ, nhân viên thì thêm Đơn vị công tác. |
| 4 | Cán bộ | Có thể bấm **Lưu nháp** để dừng và làm tiếp sau. | Biên bản ở trạng thái Nháp. |
| 5 | Cán bộ | Kiểm tra lại toàn bộ và bấm **Kiểm tra và chốt để ký**. | Kiểm tra trường bắt buộc; tạo biên bản (nhiều trang) từ dữ liệu đã nhập; trạng thái Chờ ký; không sửa được nữa [B10]. |
| 6 | Cán bộ | Xem trước biên bản, bấm **Mời cá nhân ký** và đưa thiết bị cho cá nhân. | Chuyển sang màn ký của cá nhân. |
| 7 | Cá nhân | Đọc biên bản; bật công tắc **"Tôi đã đọc và xác nhận nội dung biên bản này"**; ký tay trên vùng ký; bấm **Xác nhận chữ ký**. | Nút Xác nhận chữ ký chỉ sáng khi đã bật công tắc; liên kết Ký lại xoá nét vẽ để ký lại. |
| 8 | Cá nhân | Nếu không ký: nhập lý do và bấm **Ghi nhận từ chối ký** hoặc **Ghi nhận không có mặt**. | Lưu lý do; biên bản ở trạng thái Chờ ký [B9]. |
| 9 | Cá nhân | Bấm **Trả thiết bị cho cán bộ**. | Quay lại màn của cán bộ. |
| 10 | Cán bộ | Bấm **Đại diện Công an cửa khẩu ký**; bật công tắc xác nhận; ký tay; bấm **Xác nhận chữ ký**. | Chỉ cho ký khi cá nhân đã ký thành công [Q24]. |
| 11 | Hệ thống | Lưu biên bản đã ký. | Trạng thái Hoàn tất; số biên bản tự tăng [B10]; xem lại và mở được PDF; lưu lên trang quản trị; ghi nhật ký. |

**Luồng thay thế và ngoại lệ**

- **Ký lại (XL04):** khi biên bản trước ký không thành công, cán bộ hoặc người giao tạo biên bản mới tự điền toàn bộ thông tin từ biên bản cũ; biên bản cũ vẫn được giữ [Q26].

- **Nhiều đối tượng:** mỗi cá nhân một biên bản; nhiều cán bộ cùng tham gia thì một cán bộ ký là đủ [Q25].

- **Không lập biên bản:** vụ việc vẫn Hoàn thành được [Q22].

- **Thiếu hồ sơ cán bộ:** cán bộ nhập tay các trường thiếu cho riêng biên bản đó [B11].

### Tính năng 4 – Xem thống kê

| **Mục đích** | Xem thống kê về các vụ việc xử lý vi phạm được giao; có thông tin tổng quát nhanh chóng về các vấn đề của vụ việc đã giao và đã xử lý, ngay khi vừa vào ứng dụng. Thống kê chỉ ghi số liệu của vụ việc xử lý vi phạm, không tính việc giao [B23]. |
|---|---|
| **Điều kiện** | • Đã đăng nhập thành công; thiết bị có kết nối mạng.• Người dùng thuộc một Đội; có vụ việc trong kỳ được chọn.• Vị trí hiển thị: tab **Trang chủ**, tab mặc định khi vào ứng dụng. |
| **Người tham gia** | • **Mọi thành viên trong Đội:** thấy thống kê giống nhau [Q29].• **Người giao:** từ thống kê đi tiếp tới màn Giao việc và Báo cáo hằng ngày.• **Phó trưởng và Trưởng CACK:** thấy số liệu của Đội như mọi thành viên [B19].• **Hệ thống:** tổng hợp số liệu theo kỳ. |
| **Kết quả đạt được** | • Người dùng nắm nhanh số lượng vụ việc, vụ việc quá hạn, vụ việc khẩn cấp, xu hướng theo ngày và phân bố theo khu vực.• Đi thẳng từ Trang chủ tới màn Giao việc; không cần giấy tờ hay báo cáo thủ công để biết tình hình. |

**Các bước thực hiện (CH05)**

| **Bước** | **Người thực hiện** | **Thao tác** | **Phản hồi của hệ thống** |
|---|---|---|---|
| 1 | Người dùng | Đăng nhập vào ứng dụng. | Mở tab Trang chủ: lời chào, vai trò, Đội, Nhà ga và trạng thái điểm danh. |
| 2 | Người dùng | Xem thẻ **Giao việc**. | Hiện "Không có việc đang mở" hoặc số việc đang mở. |
| 3 | Người dùng | Chọn kỳ thống kê: **Hôm nay**, **Tuần này** hoặc **Tuỳ chọn**. | Số liệu và biểu đồ cập nhật theo kỳ. |
| 4 | Người dùng | Xem sáu ô số: Tổng vụ việc, Chờ tiếp nhận, Chờ chỉ đạo, Quá hạn, Đã đóng, Khẩn cấp mở. | Hiển thị số lượng từng ô; ô gắn trạng thái chưa dùng hiện 0 [B19]. |
| 5 | Người dùng | Xem biểu đồ **Xu hướng**. | Biểu đồ cột số vụ việc theo ngày. |
| 6 | Người dùng | Xem **Vụ việc theo khu vực**. | Biểu đồ phân bố theo khu vực phát sinh. |
| 7 | Người giao | Bấm thẻ Giao việc để xem danh sách. | Mở màn Giao việc với bộ lọc trạng thái có số đếm (Tất cả, Đang thực hiện, Chưa hoàn thành, Hoàn thành), tìm kiếm, sắp xếp theo hạn. |
| 8 | Người giao | Cần số liệu chi tiết của một ngày: Cá nhân → **Báo cáo hằng ngày** (CH06). | Xem trên màn và xuất PDF. |

## 2.5. Các chức năng bổ trợ

Bản mô tả còn nêu các chức năng khác đi kèm các tính năng chính. Bảng dưới tóm tắt từng chức năng; chi tiết ở use case tương ứng. Bốn chức năng đầu dùng chung cho Xử lý vi phạm và Giao việc.

| **Chức năng** | **Mục đích** | **Điều kiện và người tham gia** | **Các bước** | **Kết quả** |
|---|---|---|---|---|
| **Gia hạn (CH01)** | Kéo dài thời gian thực hiện nhiệm vụ. | Người giao; phần việc chưa Hoàn thành hoặc đã quá hạn. | Mở vụ việc hoặc việc giao → Gia hạn → nhập ngày giờ và lý do → Xác nhận. | Gia hạn thành công; hạn mới; xoá kết quả quá hạn. |
| **Phân công lại (CH02)** | Đổi cán bộ phụ trách. | Người giao; có cán bộ khác trong Đội. | Mở vụ việc hoặc việc giao → Phân công lại → nhập lý do, chọn cán bộ mới → Xác nhận. | Hiện tên cán bộ phụ trách mới. |
| **Phân công tiếp (CH03)** | Chỉ định cán bộ cùng thực hiện. | Người giao. | Mở vụ việc hoặc việc giao → Phân công tiếp → chọn cán bộ, nhập lý do → Xác nhận. | Thêm phần việc cho cán bộ được chọn. |
| **Huỷ phần việc (CH04)** | Huỷ phần việc đã giao. | Người giao. | Mở vụ việc hoặc việc giao → Huỷ phần việc → nhập lý do → Xác nhận. | Phần việc Đã huỷ kèm lý do. |
| **Xuất báo cáo hằng ngày (CH06)** | Xuất báo cáo theo ngày chỉ định. | Đội trưởng (báo cáo Đội); Phó trưởng, Trưởng CACK (toàn đơn vị). | Tab Cá nhân → Báo cáo hằng ngày → chọn ngày → Xem/Xuất PDF. | File PDF báo cáo; lưu trên hệ thống quản trị. |
| **Ký lại biên bản (XL04)** | Ký lại khi lần ký trước không thành công. | Cán bộ hoặc người giao; biên bản đang Chờ ký. Chỉ có ở Xử lý vi phạm. | Tạo biên bản mới tự điền từ biên bản cũ → chốt → ký như tính năng 3. | Biên bản mới Hoàn tất; biên bản cũ được giữ. |

# 3. Tác nhân và phân quyền

Bản mô tả chia người dùng thành hai nhóm quyền: **được giao việc hoặc tạo vụ việc**, và **nhận việc hoặc vụ việc được giao** (cán bộ).

## 3.1. Tác nhân

| **Tác nhân** | **Vai trò cụ thể** | **Ghi chú** |
|---|---|---|
| **Người giao** | Đội trưởng/Chỉ huy Đội, Tổ trưởng, Tổ phó, Phó đội trưởng, Phó trưởng CACK, Trưởng CACK; cán bộ được ủy quyền Tổ phó. | Có quyền tạo vụ việc xử lý vi phạm, tạo giao việc và các thao tác quản lý phần việc. |
| **Cán bộ** | Cán bộ hiện trường, cán bộ Phòng Camera và các cán bộ khác. | Nhận việc và vụ việc. Phòng Camera không có quyền tạo vụ việc [Q31]. |
| **Quản trị viên** | Người dùng trang quản trị web. | Tạo tài khoản, cài đặt ủy quyền, quản lý danh mục và biểu mẫu [Q2, Q19, Q22, Q33]. |
| **Cá nhân liên quan** | Hành khách; cán bộ, nhân viên. | Không có tài khoản; ký trên thiết bị của cán bộ. |
| **Hệ thống** | Dịch vụ nền. | Gửi thông báo, nhắc việc; chốt báo cáo lúc 0:00. |

## 3.2. Phạm vi giao việc

| **Vai trò** | **Được giao cho** | **Căn cứ** |
|---|---|---|
| Đội trưởng/Chỉ huy Đội, Tổ phó (và cán bộ ủy quyền Tổ phó) | Cán bộ trong Đội mình phụ trách | [Q3] |
| Tổ trưởng, Phó đội trưởng | Các thành viên trong Đội mình; với Xử lý vi phạm, chỉ ở các khu vực được phụ trách | [B3, B25*] |
| Phó trưởng CACK, Trưởng CACK | Toàn bộ các Đội trong hệ thống | [Q3] |

Phạm vi này áp dụng cho cả Xử lý vi phạm và Giao việc. Khu vực được phụ trách do quản trị viên gán cho tài khoản (giả định [B25*]). Mọi thành viên trong Đội đều thấy tab **Của Đội** của Giao việc [Q3].

## 3.3. Ủy quyền Tổ phó

- Quản trị viên cài đặt ủy quyền trong mục Tài khoản trên trang quản trị [Q2].

- Ủy quyền cho cán bộ trong Đội; người được ủy quyền có quyền tương đương Đội trưởng: giao việc, tạo vụ việc, gia hạn, phân công; không giới hạn số người được ủy quyền [Q2, Q4, B2].

- Cán bộ không được ủy quyền không có quyền tạo vụ việc và không thấy các nút quản lý phần việc [Q4, Q7].

- Không giới hạn thời gian ủy quyền; quản trị viên thu hồi quyền ở mục quản lý tài khoản trên trang quản trị [B2].

## 3.4. Ma trận quyền theo chức năng

| **Chức năng** | **Người giao** | **Cán bộ được chỉ định** | **Thành viên Đội khác** |
|---|---|---|---|
| **Tạo vụ việc xử lý vi phạm (XL01)** | Có | Không | Không |
| **Tạo giao việc (GV01)** | Có | Không | Không |
| **Xem tab Của Đội (Giao việc); thống kê Trang chủ** | Có | Có | Có [Q3, Q29] |
| **Xem tab Tiếp nhận (mọi vụ việc được tạo trong Đội)** | Có | Không | Không [B24] |
| **Xem tab Của tôi (vụ việc mình đã giao hoặc được chỉ định)** | Có | Có | Có [B24] |
| **Nút Lịch sử** | Có | Có | Có [Q7] |
| **Nút Đang làm** | Không | Có | Không [Q7] |
| **Nút Hoàn thành** | Có, bấm thay cán bộ | Có, phần của mình | Không [Q7] |
| **Gia hạn, Phân công lại, Phân công tiếp, Huỷ phần việc (CH01–CH04)** | Có | Không | Không [Q7] |
| **Lập biên bản (XL03)** | Không | Có | Không |
| **Tạo biên bản mới khi ký lại (XL04)** | Có | Có | Không [Q26] |
| **Thêm ảnh vào Hình ảnh/Bằng chứng (XL05, GV03)** | Có | Có | Không [B21, B22] |
| **Báo cáo hằng ngày (CH06)** | Đội trưởng: báo cáo Đội. Phó trưởng, Trưởng CACK: toàn đơn vị | Không | Không [Q30] |

Cán bộ được ủy quyền Tổ phó có quyền như người giao ở mọi dòng của ma trận. "Người giao" gồm cả cán bộ này. Ma trận áp dụng như nhau cho Xử lý vi phạm và Giao việc, trừ các chức năng XL (chỉ có ở Xử lý vi phạm).

# 4. Mô hình trạng thái

## 4.1. Phần việc (dùng chung)

Mỗi phần việc, ở Xử lý vi phạm cũng như Giao việc, đi từ Đã giao, qua Đang tiến hành (không bắt buộc), đến Hoàn thành hoặc Đã huỷ. Tiến độ và Kết quả là hai trường riêng: phần việc quá hạn giữ nguyên tiến độ nhưng Kết quả đổi thành "Không hoàn thành đúng hạn".

![Sơ đồ trạng thái phần việc](images/dac-ta-hinh-01.png)

| **Trường** | **Giá trị** |
|---|---|
| **Tiến độ** | Đã giao; Đang tiến hành; Hoàn thành; Đã huỷ |
| **Kết quả** | Chưa bắt đầu; Đang tiến hành; Hoàn thành đúng hạn; Không hoàn thành đúng hạn; Đã huỷ |

**Chuyển trạng thái:**

| **Hành động** | **Từ** | **Sang** | **Ai thực hiện** | **Quy tắc** |
|---|---|---|---|---|
| Đang làm | Đã giao | Đang tiến hành | Cán bộ được chỉ định | Không bắt buộc; ghi nhật ký "Bắt đầu thực hiện" [Q6]. |
| Hoàn thành | Đã giao hoặc Đang tiến hành | Hoàn thành | Cán bộ được chỉ định; người giao bấm thay | Bắt buộc nhập kết quả hoặc lý do; không hoàn tác [Q7, Q8]. |
| Huỷ phần việc | Đã giao hoặc Đang tiến hành | Đã huỷ | Người giao | Bắt buộc nhập lý do; xem CH04 [Q10]. |
| Gia hạn | Bất kỳ trạng thái chưa kết thúc | Giữ nguyên | Người giao | Đổi hạn; xoá kết quả "Không hoàn thành đúng hạn" [Q13]. |
| Phân công lại | Chưa kết thúc | Giữ nguyên | Người giao | Đổi người trên cùng phần việc, giữ mọi thông tin đã tạo, ghi nhật ký [B5]. |
| Phân công tiếp | — | Tạo phần việc mới ở Đã giao | Người giao | Thêm cán bộ cùng thực hiện [Q12]. |

## 4.2. Vụ việc xử lý vi phạm

| **Trạng thái** | **Điều kiện** | **Ghi chú** |
|---|---|---|
| **Đang thực hiện** | Mặc định sau khi giao, cho đến khi hoàn thành hoặc huỷ. | Nhãn trên thẻ và chi tiết vụ việc (ảnh). |
| **Đã hoàn thành** | Cán bộ phụ trách hoặc người giao bấm Hoàn thành; không hoàn tác về Đang thực hiện [Q8]. | Mỗi cán bộ tự Hoàn thành phần việc của mình, không có nút Hoàn thành chung [B4]. Vụ việc Đã hoàn thành khi mọi phần việc còn hiệu lực đã Hoàn thành (ảnh VV000158: một phần Hoàn thành, một phần Đã huỷ). |
| **Đã huỷ** | Huỷ hết người phụ trách [Q10]. | Xem CH04. |
| **Nhãn "Quá hạn xử lý"** | Có phần việc quá hạn chưa hoàn thành. | Nhãn đỏ trên thẻ vụ việc (ảnh), không phải trạng thái riêng [B6]. |

Các trạng thái Chờ tiếp nhận, Đang xử lý tại Đội, Chờ chỉ đạo chưa dùng ở giai đoạn này [Q5]. Các trạng thái "Đã đóng" và "Chờ chỉ đạo" tạm thời bỏ qua [B4].

## 4.3. Việc giao

| **Nhãn trạng thái** | **Ý nghĩa** | **Ghi chú** |
|---|---|---|
| **Chưa bắt đầu** | Mọi phần việc còn ở Đã giao. | Nhãn cam trên thẻ việc (ảnh). |
| **Đang thực hiện** | Có phần việc đã Đang tiến hành. | Chip lọc kèm số đếm (ảnh). |
| **Chưa hoàn thành** | Việc chưa được hoàn thành. | Chip đỏ trên màn Giao việc (ảnh) [B23]. |
| **Hoàn thành** | Việc đã được người phụ trách ấn chọn Hoàn thành; việc nhiều người: khi mọi phần việc còn hiệu lực đã Hoàn thành. | Chip xanh (ảnh) [B23, B27*]. |

# 5. Chức năng Xử lý vi phạm

Chức năng Xử lý vi phạm mở bằng nút **+** (Tạo vụ việc) ở Trang chủ. Vụ việc xử lý vi phạm hiện ở tab **Tiếp nhận** và tab **Của tôi**: người có quyền giao thấy cả hai tab, cán bộ chỉ thấy tab Của tôi [Q1, B24]. Mỗi use case nêu tác nhân, điều kiện, luồng chính, luồng thay thế và kết quả. Các quy tắc đánh số BRnn nằm ở mục 9.

## XL01 – Tạo vụ việc xử lý vi phạm

| **Tác nhân** | Người giao, kể cả cán bộ được ủy quyền Tổ phó. Cán bộ thường và Phòng Camera không có quyền [Q4, Q31]. |
|---|---|
| **Tiền điều kiện** | Đã đăng nhập bằng tài khoản do quản trị viên tạo; có quyền tạo vụ việc; thiết bị có kết nối mạng [Q32, Q33]. |
| **Kích hoạt** | Bấm nút + (Tạo vụ việc) ở Trang chủ hoặc tab Của tôi (ảnh). Đây là Tạo vụ việc xử lý vi phạm, không phải option Giao việc (GV01) [Q1]. |
| **Hậu điều kiện** | Vụ việc mới có mã VVxxxxxx, hiện ở tab Tiếp nhận và tab Của tôi của người giao, tab Của tôi của cán bộ được chỉ định [B24]; mỗi cán bộ được chỉ định có một phần việc ở trạng thái Đã giao và nhận thông báo "Bạn có phần việc mới"; ghi nhật ký "Giao việc". |

Khu vực phát sinh, loại vụ việc, đề xuất xử lý là các tuỳ chọn cấu hình sẵn trên trang quản trị [Q1, Q19]. Màn hình có 9 bước, thanh tiến độ "Bước n/9", nút **Quay lại** (giữ dữ liệu đã nhập) và **Tiếp tục** (mờ cho đến khi bước hợp lệ).

**Các bước nhập**

| **Bước** | **Trường** | **Kiểu nhập** | **Bắt buộc** | **Giá trị và quy tắc** |
|---|---|---|---|---|
| 1 | Hình ảnh/Bằng chứng | Chụp ảnh hoặc chọn từ thư viện | Không | Chỉ ảnh, tối đa 50MB mỗi ảnh, gắn thời gian, không GPS [Q20, B12]. Màn xem lại hiển thị "Bằng chứng: n tệp". |
| 2 | Khu vực phát sinh | Chọn 1 | Có | Theo danh mục (mục 8.2). Tổ trưởng, Phó đội trưởng chỉ chọn trong các khu vực được phụ trách [B3]. |
| 3 | Loại vụ việc | Chọn 1 hoặc nhập tay | Có | Theo danh mục hai cấp; mục "Khác" cho nhập tên loại bằng tay [Q19]. |
| 4 | Mức độ | Chọn 1 | Có | Bình thường; Nghiêm trọng; Khẩn cấp (ghi chú trên màn: "Cảnh báo Lãnh đạo + BCH đội") [B7]. |
| 5 | Mô tả | Văn bản, có micro | Có | Ba ô: Mô tả vụ việc (bắt buộc, nút Tiếp tục mờ khi để trống); Vị trí cụ thể (tuỳ chọn); Hành động đã thực hiện (tuỳ chọn) (ảnh). |
| 6 | Thông tin đối tượng | Xem bên dưới | Không | Đối tượng không bắt buộc; số lượng đối tượng không cần khớp số đã nhập [Q17]. |
| 7 | Đề xuất xử lý | Chọn nhiều | Không | Nhắc nhở, khuyến cáo; Đưa vào diện chú ý; Bàn giao; Phối hợp; Khác. |
| 8 | Giao việc | Chọn Đội, chọn 1 hoặc nhiều cán bộ | Có | Tìm cán bộ theo email; mỗi dòng hiển thị email, Đội, vai trò. Chỉ chọn được người trong phạm vi giao (mục 3.2). |
| 9 | Xem lại và gửi | Chọn ngày, chọn giờ (giờ Việt Nam) | Có | Tóm tắt loại, mô tả, bằng chứng, người được giao. Chỉ có nút **Giao việc và gửi**; bỏ phần "xử lý tại chỗ và hoàn thành" [Q4]. Hạn: không chọn quá khứ, không giới hạn tối đa, giờ mặc định 17:00 đổi được [B8]. |

**Bước 6 – Thông tin đối tượng**

Các trường chung: Số lượng đối tượng; Biển số xe (nhập tay, chưa có tra cứu tự động [Q35]); Đơn vị liên quan. Ba cách thêm đối tượng:

1. **Quét giấy tờ:** mở camera quét giấy tờ, thông tin tự điền vào các trường.

2. **Từ thư viện:** chọn ảnh giấy tờ có sẵn, thông tin tự điền.

3. **Thêm đối tượng thủ công:** tự nhập.

| **Trường đối tượng** | **Kiểu** | **Ghi chú** |
|---|---|---|
| Họ tên | Văn bản |  |
| Ngày sinh | Ngày |  |
| Giới tính | Chọn 1 | Nam; Nữ; Khác |
| Quốc tịch | Danh sách chọn |  |
| Số CCCD/CMND | Văn bản |  |
| Số hộ chiếu | Văn bản |  |

- Quét giấy tờ áp dụng cho CCCD gắn chip, CMND, hộ chiếu Việt Nam và nước ngoài [Q18].

- Cán bộ phải kiểm tra lại thông tin tự điền [Q18].

- Ảnh giấy tờ chỉ dùng để quét, **không lưu**; hệ thống chỉ lưu văn bản [Q18].

- Mỗi đối tượng có nút xoá; nút "Thêm đối tượng thủ công" thêm đối tượng tiếp theo.

**Luồng thay thế và ngoại lệ**

- Chọn loại "Khác": nhập tên loại bằng tay.

- Mức Khẩn cấp: gửi thông báo đẩy ưu tiên cao cho Chỉ huy Đội và lãnh đạo trực tiếp, không bắt buộc xác nhận [B7].

- Mất kết nối: không gửi được; ứng dụng yêu cầu có mạng để thao tác, không lưu nháp ngoại tuyến [Q32].

- Người giao chọn cán bộ ngoài phạm vi giao: không hiển thị trong danh sách.

## XL02 – Tiếp nhận, thực hiện và hoàn thành vụ việc

| **Tác nhân** | Cán bộ được chỉ định; người giao khi bấm Hoàn thành thay [Q7]. |
|---|---|
| **Tiền điều kiện** | Vụ việc xử lý vi phạm đã được giao; phần việc ở trạng thái Đã giao hoặc Đang tiến hành. |
| **Kích hoạt** | Cán bộ mở vụ việc từ tab **Của tôi** hoặc tab **Thông báo**; người giao mở thêm từ tab **Tiếp nhận** [B24]. |
| **Hậu điều kiện** | Phần việc Hoàn thành; ghi giờ hoàn thành thực tế và kết quả đúng hạn hay không; ghi nhật ký; thông báo cho người giao và Đội trưởng của Đội [B20]; kết quả được lưu về hệ thống quản trị. |

Người có quyền giao thấy cả tab **Tiếp nhận** (tất cả vụ việc được tạo trong Đội) và tab **Của tôi** (vụ việc mình đã giao hoặc được chỉ định làm). Tài khoản cán bộ chỉ thấy tab **Của tôi** [B24].

**Luồng chính**

1. Cán bộ mở vụ việc được giao và đọc **Chi tiết vụ việc**.

2. Bấm **Đang làm** để bắt đầu xử lý. Bước này không bắt buộc; ghi nhật ký "Bắt đầu thực hiện" khi bấm [Q6].

3. Có thể bổ sung ảnh bằng chứng (Chụp ảnh, Thư viện) và lập biên bản nếu loại vụ việc có biểu mẫu (XL03).

4. Xử lý xong, bấm **Hoàn thành**; hệ thống mở hộp thoại **Cập nhật phần việc** với ô "Kết quả hoặc lý do" (có micro).

5. Nhập kết quả và bấm **Xác nhận**. Nếu để trống, hệ thống báo "Yêu cầu nhập Kết quả hoặc lí do khi chọn Hoàn thành".

6. Phần việc chuyển Hoàn thành; Kết quả là "Hoàn thành đúng hạn" hoặc "Không hoàn thành đúng hạn".

7. Bấm **Lịch sử** để xem các mốc xử lý (giờ · người thực hiện · hành động).

**Nút hiển thị theo người xem [Q7]**

| **Người xem** | **Nút trên phần việc** |
|---|---|
| **Người có quyền giao việc** | Hoàn thành, Phân công lại, Gia hạn, Huỷ phần việc, Phân công tiếp, Lịch sử |
| **Cán bộ được chỉ định** | Đang làm, Hoàn thành, Lịch sử |
| **Cán bộ không được chỉ định** | Lịch sử |

**Màn Chi tiết vụ việc (ảnh)**

| **Khối** | **Nội dung hiển thị** |
|---|---|
| **Đầu trang** | Mã VV, trạng thái, loại · khu vực, mức độ, mô tả ngắn; nhãn "Quá hạn xử lý" nếu có. |
| **Giao việc · x/y** | Mỗi phần việc: Đội · cán bộ; NỘI DUNG; TIẾN ĐỘ; Hạn; NHẮC VIỆC; KẾT QUẢ; Hoàn thành thực tế; các nút. |
| **Biểu mẫu và chữ ký** | Danh sách biên bản, trạng thái từng biên bản (ví dụ "Chờ ký (2/2)"), nút **Mở biểu mẫu**. |
| **Thông tin vụ việc** | Đội phụ trách, Tổ, Nguồn phát hiện, Vị trí, Hành động đã thực hiện, Hạn xử lý, Thời gian tạo. |
| **Thông tin liên quan** | Đối tượng 1..n: họ tên, ngày sinh, giới tính, quốc tịch, CCCD (hiển thị đầy đủ, không che số [B16]). |
| **Đề xuất xử lý của cán bộ** | Các lựa chọn ở bước 7 của XL01. |
| **Hình ảnh/Bằng chứng** | Ảnh đã có; nút Chụp ảnh, Thư viện để thêm. |
| **Diễn biến xử lý** | Dòng thời gian, ví dụ "Phân công – KT001 · Đội trưởng/Chỉ huy Đội · 14:35 20/10/2026". |

**Danh sách vụ việc (tab Của tôi và Tiếp nhận, ảnh)**

Ô tìm theo mã hoặc mô tả; bộ lọc mức độ (Mọi mức độ, Bình thường, Nghiêm trọng, Khẩn cấp); thẻ Giao việc "Không có việc đang mở"; mỗi thẻ có mã, loại · khu vực, mô tả, mức độ, Tổ, giờ tạo, nhãn "Cần xử lý" và nút **Hoàn thành** nhanh; nút + để tạo vụ việc mới (chỉ người có quyền). Bộ lọc trạng thái (Chờ tiếp nhận, Đang xử lý tại Đội...) chưa dùng [Q5].

## XL03 – Lập và ký biên bản

| **Tác nhân** | Cán bộ được chỉ định; cá nhân liên quan (hành khách hoặc cán bộ, nhân viên). |
|---|---|
| **Tiền điều kiện** | Vụ việc thuộc loại có biểu mẫu; hiện chỉ "Phát hiện vật phẩm nguy hiểm" [Q19]. Biểu mẫu do quản trị viên cấu hình, các trường khác nhau theo loại vụ việc [Q22]. |
| **Kích hoạt** | Chi tiết vụ việc → khối **Biểu mẫu và chữ ký** → **Mở biểu mẫu**. |
| **Hậu điều kiện** | Biên bản đã ký đủ hai bên, lưu tự động trên hệ thống, xem lại và xuất PDF. Không bắt buộc phải lập biên bản mới hoàn thành vụ việc [Q22]. |

**Luồng chính**

1. Bấm **+ Lập biên bản mới**. Hệ thống tự điền các trường đã có; trường thiếu để trống.

2. Cán bộ kiểm tra, điền đủ trường bắt buộc; có thể **Lưu nháp**.

3. Bấm **Kiểm tra và chốt để ký**. Hệ thống tạo biên bản (nhiều trang) từ dữ liệu đã nhập.

4. Bấm **Mời cá nhân ký**; cán bộ đưa thiết bị cho cá nhân.

5. Cá nhân bật công tắc **"Tôi đã đọc và xác nhận nội dung biên bản này"**, ký tay trên vùng ký, bấm **Xác nhận chữ ký**. Chỉ khi bật công tắc thì chữ ký hợp lệ và nút Xác nhận chữ ký mới sáng.

6. Cá nhân bấm **Trả thiết bị cho cán bộ**.

7. Cán bộ bấm **Đại diện Công an cửa khẩu ký** và thực hiện tương tự (công tắc xác nhận, ký, Xác nhận chữ ký).

8. Biên bản chuyển Hoàn tất; xem lại và mở được dạng PDF.

**Quy tắc ký [Q23, Q24, Q25]**

- Chỉ yêu cầu **chữ ký tay của hai bên**: cá nhân và cán bộ [Q23].

- Khi đưa thiết bị cho cá nhân ký, ứng dụng không khoá màn hình và không ẩn thông tin, vì cá nhân được xác nhận lại thông tin [B15].

- **Cá nhân phải ký trước**; cán bộ không có quyền ký nếu cá nhân chưa ký thành công [Q24].

- Thiếu chữ ký của một trong hai bên thì ký không thành công và biên bản ở trạng thái **Chờ ký** [Q24]. Chờ ký là biên bản thiếu một trong hai chữ ký của người tham gia [B9].

- Mỗi cá nhân một biên bản; nhiều cán bộ cùng tham gia thì chỉ cần một cán bộ ký [Q25].

- Màn ký cá nhân còn có: liên kết **Ký lại** (xoá nét vẽ), ô "Ghi lý do" (bắt buộc), nút **Ghi nhận từ chối ký** và **Ghi nhận không có mặt** (ảnh). Hai nút này ghi lý do; biên bản ở trạng thái Chờ ký, tức thiếu một trong hai chữ ký [B9].

**Trạng thái biên bản**

| **Trạng thái** | **Điều kiện** |
|---|---|
| **Nháp** | Đang điền, đã Lưu nháp. |
| **Chờ ký** | Đã chốt; chưa đủ chữ ký của cá nhân và cán bộ. |
| **Hoàn tất** | Cá nhân và cán bộ đã ký thành công. |

**Các trường của biểu mẫu "Biên bản xử lý vật phẩm nguy hiểm" (dấu * là bắt buộc, theo ảnh)**

| **Nhóm** | **Trường** | **Ghi chú** |
|---|---|---|
| Thông tin biên bản | Đơn vị lập biên bản* | Tự điền, ví dụ "Đội Tester". |
|  | Thời gian bắt đầu (giờ Việt Nam)* | Ngày và giờ; mặc định hiện tại. |
|  | Địa điểm lập biên bản* | Ví dụ "Trực quan B3". |
| I. Thành phần tham gia – cán bộ | Họ tên cán bộ*, Cấp bậc*, Số hiệu CAND*, Chức vụ*, Đơn vị công tác | Lấy từ hồ sơ cán bộ do quản trị viên nhập; cấp bậc, số hiệu, chức vụ, đơn vị do quản trị viên nhập; thiếu tức là chưa nhập, cán bộ tự điền vào biên bản đó [B11]. |
| I. Thành phần tham gia – cá nhân | Thông tin cá nhân (từ đối tượng của vụ việc), Điện thoại/email, Cá nhân thuộc nhóm* | Nhóm: **Hành khách** (thêm Chuyến bay, Số ghế) hoặc **Cán bộ, nhân viên** (thêm Đơn vị công tác). Chuyến bay và số ghế nhập tay [Q35]. |
| Vật phẩm nguy hiểm* | Nhiều dòng: Tên vật phẩm, Chủng loại, Kích thước, Màu sắc, Số lượng | Số lượng mặc định 1; nút Thêm dòng, Xoá dòng. |
| II. Biện pháp xử lý* | Chọn 1 | Tự nguyện giao nộp; Đề nghị gửi theo hành lý ký gửi; Khác. |
| III. Tài liệu kèm theo | Ảnh vật phẩm, soi chiếu, giấy tờ, thẻ lên tàu bay | Bật hoặc tắt từng tài liệu đưa vào biên bản. |
| Kết thúc | Thời gian kết thúc lập biên bản (giờ Việt Nam)* | Nút Lưu nháp; Kiểm tra và chốt để ký. |

Sau khi chốt, biên bản không sửa được; mỗi biên bản có số tự tăng [B10]. Mẫu PDF (quốc hiệu, tiêu ngữ, mã QR) dùng mẫu gốc khi khách hàng cung cấp [B26*].

## XL04 – Ký lại biên bản

| **Tác nhân** | Cán bộ được chỉ định hoặc người giao [Q26]. |
|---|---|
| **Điều kiện** | Biên bản trước đó ký không thành công, tức đang Chờ ký (thiếu một trong hai chữ ký) [Q26, B9]. |
| **Hậu điều kiện** | Có biên bản mới để ký; biên bản cũ vẫn được giữ trên hệ thống nhưng không ký tiếp được [Q26, B9]. |

1. Cán bộ hoặc người giao tạo **biên bản mới** từ vụ việc.

2. Biên bản mới **tự động điền tất cả thông tin** từ biên bản cũ [Q26].

3. Cán bộ kiểm tra, chốt và thực hiện lại quy trình ký như XL03.

Sau khi ký lại, biên bản cũ **không thể ký tiếp** [B9]. Liên kết **Ký lại** ở màn ký chỉ xoá chữ ký đang vẽ trong cùng phiên, không phải UC này.

## XL05 – Bổ sung ảnh và điều chỉnh vụ việc sau khi tạo

| **Tác nhân** | Người giao; cán bộ được chỉ định (thêm ảnh bằng chứng) [B21]. |
|---|---|
| **Quy tắc** | Sau khi tạo, chỉ được **thêm ảnh** vào trường Hình ảnh/Bằng chứng. Mọi thông tin đã nhập trước đó (khu vực, loại, mức độ, mô tả, đối tượng, đề xuất xử lý, cán bộ, hạn...) **không thể sửa** [B21]. |
| **Điều chỉnh khác** | Chỉ có thể dùng Phân công lại, Gia hạn, Huỷ phần việc, Phân công tiếp (CH01–CH04) [B21]. Không cho xoá vụ việc [Q38]. |
| **Hậu điều kiện** | Ảnh mới hiện trong khối Hình ảnh/Bằng chứng và ghi vào nhật ký (suy ra). |

1. Mở Chi tiết vụ việc, ở khối Hình ảnh/Bằng chứng bấm **Chụp ảnh** hoặc **Thư viện**.

2. Chọn hoặc chụp ảnh (tối đa 50MB mỗi ảnh, gắn thời gian, không GPS [B12]).

3. Ảnh được thêm vào vụ việc; các trường còn lại không có nút sửa.

Quy định này thay cho trả lời Q38 ("người giao sửa được") vì B21 cụ thể hơn; xem Phụ lục C.

# 6. Chức năng Giao việc

Chức năng Giao việc mở bằng option **Giao việc** ở Trang chủ. Các việc được giao hiện khi bấm vào option này, ở ba tab **Giao cho tôi**, **Tôi đã giao**, **Của Đội** [Q1]. Giao việc không gắn với địa điểm hay vụ việc.

## GV01 – Tạo giao việc

| **Tác nhân** | Người giao. |
|---|---|
| **Kích hoạt** | Trang chủ → option **Giao việc** (hoặc Cá nhân → Giao việc); bấm nút **Giao việc**. Không dùng nút + của Xử lý vi phạm [Q1]. |
| **Hậu điều kiện** | Việc hiện ở tab **Tôi đã giao** của người giao, tab **Giao cho tôi** của cán bộ được chỉ định, tab **Của Đội** của các thành viên Đội khác [Q3]. Ghi nhật ký; gửi thông báo cho cán bộ được chỉ định. |

| **Trường** | **Bắt buộc** | **Chi tiết** |
|---|---|---|
| **Mức độ nghiêm trọng** | Có | Bình thường (mặc định); Nghiêm trọng; Khẩn cấp. |
| **Nội dung** | Có | Văn bản; có nút micro để đọc thay gõ. |
| **Hạn hoàn thành (giờ Việt Nam)** | Có | Chọn ngày; giờ mặc định 17:00 có thể thay đổi; không chọn thời điểm đã qua; không có giới hạn tối đa [B8]. |
| **Ảnh** | Không | Chụp ảnh hoặc chọn từ thư viện. Chỉ nhận ảnh, tối đa 50MB mỗi ảnh, gắn thời gian, không GPS [Q20, B12]. Màn hình hiện còn nêu video và các loại tệp (PDF, Word, Excel, PowerPoint, TXT, CSV, ZIP, RAR): ẩn các tuỳ chọn này. |
| **Giao cho: Đội nhận việc** | Có | Chọn Đội trong phạm vi giao (mục 3.2). |
| **Giao cho: Cán bộ nhận việc** | Có | Tìm theo email; chọn 1 hoặc nhiều cán bộ. |

Nút **Giao việc và gửi** chỉ bật khi đủ trường bắt buộc.

**Màn danh sách Giao việc (ảnh)**

- Ba tab: **Giao cho tôi**, **Tôi đã giao**, **Của Đội**.

- Ô tìm theo nội dung hoặc mã; bộ lọc trạng thái có số đếm (Tất cả, Đang thực hiện, Chưa hoàn thành, Hoàn thành); nút Lọc; sắp xếp mặc định "Hạn sớm nhất trước".

- Mỗi thẻ: mã, mức độ, người được giao, nội dung, hạn, tiến độ (ví dụ 0/1), nhãn trạng thái (ví dụ "Chưa bắt đầu").

- Chi tiết giao việc: người giao, trạng thái, mức độ, nội dung, hạn hoàn thành, giờ giao, từng phần việc với các nút theo quyền (mục 3.4), tệp đính kèm.

## GV02 – Nhận việc, thực hiện và hoàn thành việc được giao

| **Tác nhân** | Cán bộ được chỉ định; người giao khi bấm Hoàn thành thay [Q7]. |
|---|---|
| **Tiền điều kiện** | Việc đã được giao qua GV01; phần việc ở trạng thái Đã giao hoặc Đang tiến hành. |
| **Kích hoạt** | Ở Trang chủ chọn option **Giao việc**, mở tab **Giao cho tôi** và bấm vào việc; hoặc mở từ tab **Thông báo**. |
| **Hậu điều kiện** | Phần việc Hoàn thành; ghi giờ hoàn thành thực tế và kết quả đúng hạn hay không; ghi nhật ký; thông báo cho người giao và Đội trưởng của Đội [B20]; kết quả lưu về hệ thống quản trị. |

Việc được giao chỉ hiện ở màn Giao việc (ba tab Giao cho tôi, Tôi đã giao, Của Đội), không hiện ở tab Tiếp nhận hay Của tôi của Xử lý vi phạm.

**Luồng chính**

1. Cán bộ mở việc được giao và đọc **Chi tiết giao việc**.

2. Bấm **Đang làm** để bắt đầu. Không bắt buộc; ghi nhật ký "Bắt đầu thực hiện" [Q6].

3. Thực hiện công việc; có thể xem ảnh hoặc tệp đính kèm của người giao.

4. Làm xong, bấm **Hoàn thành**; hệ thống mở hộp thoại **Cập nhật phần việc** với ô "Kết quả hoặc lý do" (có micro).

5. Nhập kết quả và bấm **Xác nhận**. Nếu để trống, hệ thống báo "Yêu cầu nhập Kết quả hoặc lí do khi chọn Hoàn thành".

6. Phần việc chuyển Hoàn thành; Kết quả là "Hoàn thành đúng hạn" hoặc "Không hoàn thành đúng hạn"; bộ đếm tiến độ x/y tăng.

7. Bấm **Lịch sử** để xem các mốc.

**Nút hiển thị theo người xem [Q7]**

| **Người xem** | **Nút trên phần việc** |
|---|---|
| **Người có quyền giao việc (xem ở tab Tôi đã giao)** | Hoàn thành, Phân công lại, Gia hạn, Huỷ phần việc, Phân công tiếp, Lịch sử |
| **Cán bộ được chỉ định (tab Giao cho tôi)** | Đang làm, Hoàn thành, Lịch sử |
| **Thành viên Đội khác (tab Của Đội)** | Lịch sử |

**Màn Chi tiết giao việc (ảnh)**

| **Khối** | **Nội dung hiển thị** |
|---|---|
| **Đầu trang** | Mã, Người giao (kèm vai trò, Đội), nhãn trạng thái, mức độ. |
| **Thông tin giao việc** | Nội dung; Hạn hoàn thành; Giao lúc. |
| **Giao việc · x/y** | Mỗi phần việc: Đội · cán bộ; NỘI DUNG; TIẾN ĐỘ; Hạn; NHẮC VIỆC; KẾT QUẢ; Hoàn thành thực tế; các nút theo quyền. |
| **Tệp đính kèm** | Ảnh người giao đã đính kèm. |

**Ghi chú khác biệt so với XL02**

- Việc giao không có khu vực, loại vụ việc, đối tượng, đề xuất xử lý, biểu mẫu và chữ ký.

- Việc giao có nhãn trạng thái riêng (mục 4.3).

## GV03 – Bổ sung ảnh và điều chỉnh việc giao sau khi tạo

| **Tác nhân** | Người giao; cán bộ được chỉ định (thêm ảnh) [B22]. |
|---|---|
| **Quy tắc** | Tương tự XL05: sau khi tạo chỉ được thêm ảnh; nội dung, mức độ, hạn, người nhận đã nhập không thể sửa [B22, B21]. Điều chỉnh bằng Gia hạn, Phân công lại, Huỷ phần việc, Phân công tiếp (CH01–CH04). |

Ảnh thêm ở khối ảnh đính kèm của Chi tiết giao việc (tối đa 50MB mỗi ảnh, gắn thời gian, không GPS [B12]).

# 7. Chức năng dùng chung

Các use case dưới đây áp dụng cho cả vụ việc xử lý vi phạm và việc giao. Thao tác Gia hạn, Phân công lại, Phân công tiếp, Huỷ phần việc thực hiện trên từng phần việc ở màn Chi tiết vụ việc hoặc Chi tiết giao việc (ảnh).

## CH01 – Gia hạn

| **Tác nhân** | Người giao. |
|---|---|
| **Phạm vi** | Từng phần việc, tức từng cán bộ được phân công trong vụ việc [Q13]. |
| **Hậu điều kiện** | Hạn mới có hiệu lực; kết quả "Không hoàn thành đúng hạn" bị xoá; ghi nhật ký; thông báo cho Đội trưởng, người giao và cán bộ được chỉ định [Q5, Q13]. |

1. Mở vụ việc cần gia hạn, chọn **Gia hạn** trên phần việc.

2. Trong hộp thoại "Cập nhật phần việc": chọn ngày, chọn giờ (giờ Việt Nam), nhập kết quả hoặc lý do (ảnh).

3. Bấm **Xác nhận**; hệ thống báo gia hạn thành công và hiển thị hạn mới.

- Không giới hạn số lần gia hạn và tổng thời gian; không cần cấp trên duyệt [Q13].

- Phần việc đã quá hạn vẫn gia hạn được [Q13].

- Bắt buộc nhập lý do gia hạn [Q13].

- Thời điểm nhắc việc tính lại theo hạn mới (suy ra từ ảnh phần việc mới của Phân công tiếp).

## CH02 – Phân công lại

| **Tác nhân** | Người giao. |
|---|---|
| **Mục đích** | Đổi cán bộ phụ trách một phần việc. |
| **Hậu điều kiện** | Phần việc chuyển sang cán bộ mới, đổi người trên cùng phần việc, giữ mọi thông tin đã tạo (hạn, nội dung, nhật ký cũ); ghi nhật ký; thông báo "Đã phân công lại" cho Đội trưởng, người giao và người được chỉ định [Q5, B5]. |

1. Mở vụ việc, chọn **Phân công lại** trên phần việc.

2. Hộp thoại "Phân công cán bộ – Đội": nhập **Lý do phân công lại** (có micro), chọn **một** cán bộ trong danh sách (ảnh).

3. Hệ thống báo thành công và hiển thị tên cán bộ phụ trách mới.

- Danh sách không hiện cán bộ đang phụ trách phần việc đó [Q12].

- Phân công lại là đổi người trên cùng phần việc, ghi nhật ký, vẫn giữ tất cả thông tin đã tạo. Bỏ qua ghi chú "Biên chế đã đổi; chỉ huy cần phân công lại..." trong ảnh [B5].

## CH03 – Phân công tiếp

| **Tác nhân** | Người giao. |
|---|---|
| **Mục đích** | Chỉ định thêm cán bộ cùng thực hiện vụ việc. |
| **Hậu điều kiện** | Mỗi cán bộ được chọn có một phần việc mới ở trạng thái Đã giao; ghi nhật ký; thông báo [Q5]. |

1. Mở vụ việc, chọn **Phân công tiếp** trên phần việc.

2. Trong hộp thoại "Cập nhật phần việc": tích chọn **một hoặc nhiều** cán bộ; nhập kết quả hoặc lý do (ảnh).

3. Bấm **Xác nhận**; bộ đếm "Giao việc" tăng (ví dụ 0/1 thành 0/2).

- Phần việc mới có nội dung "Thêm cán bộ phụ trách", cùng hạn với việc gốc, thời điểm nhắc việc tính lại (ảnh).

- Phần việc cũ vẫn còn hiệu lực.

- Danh sách không hiện cán bộ đang được phân công phần việc đó [Q12].

## CH04 – Huỷ phần việc

| **Tác nhân** | Người giao. |
|---|---|
| **Hậu điều kiện** | Phần việc Đã huỷ, kèm lý do; ghi nhật ký; thông báo cho Đội trưởng, người giao và người được chỉ định [Q5]. |

1. Mở vụ việc, chọn **Huỷ phần việc** trên phần việc.

2. Nhập lý do huỷ, bấm **Xác nhận**.

3. Phần việc có Tiến độ và Kết quả đều là "Đã huỷ" kèm lý do (ảnh).

**Ảnh hưởng tới vụ việc [Q10]**

| **Trường hợp** | **Kết quả** |
|---|---|
| Vụ việc có 1 người phụ trách và huỷ phần việc đó | Huỷ cả vụ việc. |
| Vụ việc có từ 2 người phụ trách trở lên | Chỉ huỷ phần việc của người được chọn huỷ. |
| Huỷ toàn bộ người phụ trách | Huỷ cả vụ việc. |

Bộ đếm "Giao việc x/y" vẫn tính phần việc đã huỷ vào mẫu số (ví dụ 0/2 sau khi huỷ một trong hai phần việc) [Q9]. Phần việc đã huỷ vẫn hiện dòng "Không hoàn thành đúng hạn từ..." nếu đã quá hạn (ảnh VV000152) [B6].

## CH05 – Xem thống kê trên Trang chủ

Thống kê nằm ở tab **Trang chủ** ngay khi đăng nhập. Các thành viên trong Đội thấy thống kê **giống nhau** [Q29]. Thống kê chỉ ghi số liệu của vụ việc xử lý vi phạm, không tính việc giao [B23]; mọi thành viên thấy số liệu của Đội [B19]. Bộ lọc thời gian: **Hôm nay**, **Tuần này**, **Tuỳ chọn**.

| **Thành phần** | **Nội dung** | **Định nghĩa** |
|---|---|---|
| **Lời chào** | Tên, vai trò, Đội, mã đội; Nhà ga và trạng thái điểm danh. | — |
| **Thẻ Giao việc** | Dòng phụ "Không có việc đang mở" hoặc số việc đang mở; bấm để vào màn Giao việc. | — |
| **6 ô số** | Tổng vụ việc; Chờ tiếp nhận; Chờ chỉ đạo; Quá hạn; Đã đóng; Khẩn cấp mở. | Ba ô Chờ tiếp nhận, Chờ chỉ đạo, Đã đóng gắn với trạng thái chưa dùng nên hiện 0 [Q5, B4, B19]; các ô còn lại tính trên vụ việc xử lý vi phạm của Đội |
| **Xu hướng** | Biểu đồ cột số vụ việc theo ngày. | — |
| **Vụ việc theo khu vực** | Biểu đồ phân bố theo khu vực phát sinh. | — |

## CH06 – Xuất báo cáo hằng ngày

| **Tác nhân** | Đội trưởng lập báo cáo của Đội; Phó trưởng và Trưởng CACK lập báo cáo toàn đơn vị gồm nhiều Đội [Q30]. |
|---|---|
| **Kích hoạt** | Tab **Cá nhân** → **Báo cáo hằng ngày**. |
| **Đầu ra** | Xem trên màn và xuất PDF để xem, lưu hoặc chia sẻ; bản báo cáo được lưu trên hệ thống quản trị. Không cần ký duyệt [Q30]. |

1. Chọn ngày bằng mũi tên trước/sau hoặc nút **Hôm qua**, **Hôm nay**.

2. Mở rộng các mục để xem nội dung.

3. Bấm **Xem/Xuất PDF**.

| **Mục** | **Các chỉ số (ảnh)** |
|---|---|
| **I. Thông tin chung** | Ngày, Phạm vi, Tổng phát sinh, Hoàn thành, Tồn, Quá hạn, Nghiêm trọng, Khẩn cấp, Chỉ đạo, Nguồn hiện trường, Nguồn camera; nhóm "So với ngày trước": phát sinh, hoàn thành, tồn, quá hạn của hôm qua. |
| **II. Xu hướng** | Chưa thấy rõ trong ảnh. |
| **III. Phát sinh** | Theo loại (2 cấp: Nhóm cha, Loại, SL, %), theo mức độ và các nhóm khác. |

Báo cáo chỉ ghi số liệu của vụ việc xử lý vi phạm, không tính việc giao [B23]. Báo cáo ngày hôm nay là số liệu tạm; bản chính thức được chốt tự động lúc 0:00 [BR26]. Mục "Phạm vi" ghi theo Đội, ví dụ "Đội Tester – KT_01".

## CH07 – Thông báo, nhắc việc và nhật ký

Thông báo chỉ đẩy từ ứng dụng, không qua SMS [Q32]. Mỗi dòng trong tab **Thông báo** có tiêu đề, dòng phụ "Mở phần việc để xem nội dung và kết quả", giờ; thông báo chưa đọc in đậm nền xanh nhạt, đã đọc chuyển nền trắng; có nút **Đánh dấu đã đọc tất cả** (ảnh).

| **Sự kiện** | **Người nhận** | **Căn cứ** |
|---|---|---|
| Giao việc mới ("Bạn có phần việc mới") | Cán bộ được chỉ định | (ảnh) |
| Gia hạn, phân công lại ("Đã phân công lại"), phân công tiếp, huỷ phần việc | Đội trưởng, người giao và người được chỉ định | [Q5] |
| Hoàn thành phần việc ("Đã hoàn thành phần việc") | Người giao và Đội trưởng của Đội | [B20], (ảnh) |
| Nhắc việc | Cán bộ được giao, một lần, qua thông báo trong ứng dụng, tại thời điểm giao + 2/3 × (hạn − giao) | [Q14] |
| Quá hạn | Người giao và người nhận việc | [B6] |
| Vụ việc mức Khẩn cấp | Chỉ huy Đội và lãnh đạo trực tiếp, thông báo đẩy ưu tiên cao, không bắt buộc xác nhận | [B7] |

**Nhật ký**

- Nút **Lịch sử** trên từng phần việc liệt kê "giờ · người thực hiện · hành động" (Giao việc, Bắt đầu thực hiện, Hoàn thành...) (ảnh).

- Hành động Đang làm và Hoàn thành đều ghi nhật ký [Q6].

- Gia hạn, phân công lại, phân công tiếp, huỷ phần việc đều ghi nhật ký kèm lý do.

- Nhật ký lưu theo từng tài khoản và đồng bộ về trang quản trị; không sửa, không xoá.

# 8. Mô hình dữ liệu logic

## 8.1. Thực thể

Mô hình đủ để thiết kế cơ sở dữ liệu sơ bộ. Trường có dấu (?) là suy ra từ màn hình.

| **Thực thể** | **Trường chính** | **Ghi chú** |
|---|---|---|
| **Người dùng** | email, họ tên, mã cán bộ (ví dụ KT001), Đội, Tổ, vai trò, cờ ủy quyền Tổ phó, cấp bậc, số hiệu CAND, chức vụ, đơn vị công tác | Do quản trị viên tạo và quản lý [Q33]; cấp bậc, số hiệu, chức vụ, đơn vị do quản trị viên nhập, tự điền vào biên bản [B11]; Tổ trưởng, Phó đội trưởng có thêm khu vực phụ trách [B3]. |
| **Vụ việc xử lý vi phạm** | mã VVxxxxxx, loại (cha, con), tên loại nhập tay, khu vực, vị trí cụ thể, mức độ, mô tả, nguồn phát hiện, Đội phụ trách, Tổ, hành động đã thực hiện, hạn xử lý, trạng thái, nhãn quá hạn, người tạo, thời gian tạo, biển số xe, đơn vị liên quan, đề xuất xử lý (nhiều giá trị) | Tạo từ XL01; sửa được, không xoá (BR31). Mã dùng chung chuỗi VV với việc giao [B1]. |
| **Việc giao** | mã VVxxxxxx, nội dung, mức độ, hạn, người giao, thời gian giao, ảnh đính kèm, trạng thái | Tạo từ GV01; không có loại, khu vực, đối tượng, biên bản. |
| **Đối tượng** | vụ việc, họ tên, ngày sinh, giới tính, quốc tịch, số CCCD/CMND, số hộ chiếu | Không lưu ảnh giấy tờ [Q18]; dữ liệu cá nhân nhạy cảm; không che số CCCD [B16]. |
| **Phần việc** | vụ việc hoặc việc giao, cán bộ, Đội, nội dung, người giao, giờ giao, hạn, tiến độ, thời điểm nhắc việc, kết quả, nội dung kết quả hoặc lý do, giờ hoàn thành thực tế | Mỗi dòng ứng với một cán bộ; bộ đếm "Giao việc x/y" đếm trên bảng này, gồm cả phần việc đã huỷ [Q9]. |
| **Nhật ký phần việc** | phần việc, thời gian, người thực hiện, hành động, lý do hoặc ghi chú | Chỉ thêm, không sửa, không xoá. |
| **Ảnh đính kèm** | vụ việc hoặc phần việc, tệp ảnh, người tải lên, thời gian | Chỉ ảnh [Q20]. |
| **Biên bản** | vụ việc, cá nhân (đối tượng), loại biểu mẫu, số biên bản, trạng thái (Nháp, Chờ ký, Hoàn tất), dữ liệu các trường, thời gian bắt đầu và kết thúc, địa điểm, tham chiếu biên bản gốc khi ký lại, cờ "không ký tiếp được" của biên bản cũ [B9], tệp PDF | Mỗi cá nhân một biên bản [Q25]; không sửa sau khi chốt [B10]. |
| **Chữ ký** | biên bản, vai trò (Cá nhân, Đại diện CACK), người ký, hình nét ký, thời gian, kết quả (Đã ký, Từ chối ký, Không có mặt), lý do, cờ "đã đọc và xác nhận" | Cá nhân ký trước cán bộ [Q24]. |
| **Thông báo** | người nhận, loại sự kiện, tham chiếu phần việc, thời gian, đã đọc | CH07. |
| **Báo cáo ngày** | ngày, phạm vi (Đội hoặc toàn đơn vị), chỉ số, thời điểm chốt, tệp PDF, người lập | Số liệu chốt lúc 0:00 [Q30]. |
| **Danh mục** | khu vực, loại vụ việc (2 cấp, cờ yêu cầu biểu mẫu), mức độ, đề xuất xử lý, biện pháp xử lý, nhóm cá nhân, quốc tịch | Quản trị trên web [Q19]. |

## 8.2. Danh mục

| **Danh mục** | **Giá trị hiện có** |
|---|---|
| **Khu vực phát sinh** | Boarding; Vị trí cổng cửa; Đơn Vị; Kho Hàng; Sảnh Công cộng; Soi chiếu an ninh quốc nội; Sân đỗ tàu bay; Trạm gác, hàng rào |
| **Loại vụ việc** | Gây rối trật tự; Khách không hợp tác trong quá trình kiểm tra; Hỗ trợ y tế; Phát hiện vật phẩm nguy hiểm (yêu cầu biểu mẫu và chữ ký); Xâm nhập trái phép; Khác (tự nhập). Danh sách hiển thị theo cấu hình. |
| **Mức độ** | Bình thường; Nghiêm trọng; Khẩn cấp |
| **Đề xuất xử lý** | Nhắc nhở, khuyến cáo; Đưa vào diện chú ý; Bàn giao; Phối hợp; Khác |
| **Biện pháp xử lý (biên bản)** | Tự nguyện giao nộp; Đề nghị gửi theo hành lý ký gửi; Khác |
| **Nhóm cá nhân (biên bản)** | Hành khách; Cán bộ, nhân viên |
| **Giới tính** | Nam; Nữ; Khác |
| **Quốc tịch** | Danh sách quốc gia (chưa cung cấp) |

# 9. Quy tắc nghiệp vụ

Cột "Căn cứ": **[Qn]** do khách hàng chốt; **[Qn*]** giả định chưa xác nhận; **ảnh** thấy trong ảnh màn hình; **mô tả** ghi trong bản mô tả; **suy ra** do phân tích.

| **Mã** | **Quy tắc** | **Căn cứ** |
|---|---|---|
| BR01 | Chỉ người có quyền giao việc, kể cả cán bộ được ủy quyền Tổ phó, được tạo vụ việc, giao việc, Gia hạn, Phân công lại, Phân công tiếp, Huỷ phần việc. | [Q2, Q4, Q7] |
| BR02 | Phạm vi giao việc theo mục 3.2. | [Q3] |
| BR03 | Mỗi cán bộ được giao có một phần việc riêng với tiến độ, hạn và kết quả riêng. | Mô tả, ảnh |
| BR04 | XL01 bắt buộc: khu vực, loại, mức độ, mô tả, Đội, ít nhất một cán bộ, hạn. Tuỳ chọn: bằng chứng, vị trí cụ thể, hành động đã thực hiện, đối tượng, đề xuất xử lý. | Ảnh, [Q17] |
| BR05 | GV01 bắt buộc: mức độ, nội dung, hạn, Đội, ít nhất một cán bộ. Nút gửi chỉ bật khi đủ. | Ảnh |
| BR06 | Mọi thời gian nhập và hiển thị theo giờ Việt Nam. Hạn hoàn thành không chọn thời điểm đã qua, không giới hạn tối đa; giờ mặc định 17:00 có thể thay đổi. | Ảnh, [B8] |
| BR07 | Bấm Đang làm không bắt buộc trước Hoàn thành. Đang làm và Hoàn thành đều ghi nhật ký. | [Q6] |
| BR08 | Hoàn thành bắt buộc nhập kết quả hoặc lý do. Đã Hoàn thành thì không hoàn tác về Đang thực hiện. | Ảnh, [Q8] |
| BR09 | Kết quả "Hoàn thành đúng hạn" khi giờ hoàn thành thực tế không muộn hơn hạn; ngược lại "Không hoàn thành đúng hạn". | Suy ra |
| BR10 | Phần việc quá hạn giữ tiến độ hiện tại, Kết quả = "Không hoàn thành đúng hạn từ hh:mm:ss dd/mm/yyyy"; vụ việc có nhãn "Quá hạn xử lý". Hệ thống chỉ đánh dấu và thông báo người giao và người nhận việc; phần việc đã huỷ vẫn hiện dòng quá hạn. | Ảnh, [B6] |
| BR11 | Nhắc việc một lần cho cán bộ được giao, qua thông báo trong ứng dụng, tại thời điểm giao + 2/3 × (hạn − giao). Ví dụ VV000161: giao 14:15 21/10, hạn 17:00 22/10, nhắc 08:05 22/10 (ảnh 08:05:07). Ba ví dụ trong ảnh khớp trong 10 giây. | [Q14], suy ra |
| BR12 | Gia hạn theo từng phần việc; không giới hạn số lần và thời gian; không cần duyệt; phần việc quá hạn vẫn gia hạn được và kết quả "Không hoàn thành đúng hạn" bị xoá; bắt buộc lý do; nhắc việc tính lại. | [Q13] |
| BR13 | Phân công lại: đổi người trên cùng phần việc, giữ mọi thông tin đã tạo, ghi nhật ký; chọn một cán bộ cùng Đội, nhập lý do. Phân công tiếp: chọn nhiều cán bộ, tạo phần việc mới "Thêm cán bộ phụ trách" cùng hạn. Cả hai loại trừ cán bộ đang phụ trách phần việc đó khỏi danh sách. | [B5, Q12], ảnh |
| BR14 | Huỷ phần việc bắt buộc lý do. Vụ việc 1 người phụ trách thì huỷ cả vụ việc; từ 2 người trở lên thì chỉ huỷ phần của người được chọn; huỷ hết người phụ trách thì huỷ cả vụ việc. | [Q10], mô tả |
| BR15 | Bộ đếm "Giao việc x/y" tính cả phần việc đã huỷ vào mẫu số y. | [Q9] |
| BR16 | Vụ việc mức Khẩn cấp gửi thông báo đẩy ưu tiên cao cho Chỉ huy Đội và lãnh đạo trực tiếp. Không bắt buộc xác nhận. | Ảnh, [B7] |
| BR17 | Thông báo chỉ đẩy từ ứng dụng, không qua SMS. Ứng dụng yêu cầu kết nối mạng để thao tác, không hỗ trợ ngoại tuyến. | [Q32] |
| BR18 | Đối tượng không bắt buộc; số lượng đối tượng không cần khớp số đã nhập. | [Q17] |
| BR19 | Quét giấy tờ dùng cho CCCD gắn chip, CMND, hộ chiếu Việt Nam và nước ngoài; cán bộ phải kiểm tra lại thông tin tự điền; không lưu ảnh giấy tờ. | [Q18] |
| BR20 | Tệp đính kèm chỉ là ảnh, tối đa 50MB mỗi ảnh, gắn thời gian, không lưu GPS. | [Q20, B12] |
| BR21 | Biểu mẫu cấu hình trên trang quản trị, các trường khác nhau theo loại vụ việc; hiện chỉ "Phát hiện vật phẩm nguy hiểm" cần biểu mẫu và chữ ký. Không lập biểu mẫu vẫn Hoàn thành được. | [Q19, Q22] |
| BR22 | Chỉ yêu cầu chữ ký tay của cá nhân và cán bộ. Chữ ký chỉ hợp lệ khi đã bật "Tôi đã đọc và xác nhận nội dung biên bản này". Cá nhân ký trước; thiếu chữ ký của một bên thì biên bản Chờ ký. | [Q23, Q24, B9], mô tả |
| BR23 | Từ chối ký hoặc không có mặt phải ghi lý do. | Ảnh |
| BR24 | Mỗi cá nhân một biên bản; nhiều cán bộ tham gia chỉ cần một cán bộ ký. | [Q25] |
| BR25 | Ký lại: tạo biên bản mới tự điền từ biên bản cũ; biên bản cũ được giữ nhưng không ký tiếp được. | [Q26, B9] |
| BR26 | Báo cáo ngày hôm nay là số liệu tạm; bản chính thức chốt tự động lúc 0:00. Đội trưởng lập báo cáo Đội; Phó trưởng, Trưởng CACK lập báo cáo toàn đơn vị; xuất PDF, lưu trên hệ thống quản trị; không cần ký duyệt. | Ảnh, [Q30] |
| BR27 | Các thành viên trong Đội thấy thống kê Trang chủ giống nhau, là số liệu của Đội; ô gắn trạng thái chưa dùng hiện 0. Thống kê và báo cáo chỉ ghi vụ việc xử lý vi phạm. | [Q29, B19, B23] |
| BR28 | Biên bản đã chốt không sửa được; số biên bản tự tăng. | [B10] |
| BR29 | Không che số CCCD; dữ liệu đối tượng hiển thị đầy đủ cho người xem vụ việc. Chưa có yêu cầu về độ mật hay ghi log người xem. | [B16] |
| BR30 | Tài khoản do quản trị viên tạo; đăng nhập không có xác thực hai lớp; chỉ quản trị viên quản lý tài khoản. | [Q33] |
| BR31 | Sau khi tạo chỉ được thêm ảnh vào Hình ảnh/Bằng chứng; thông tin đã nhập không thể sửa; chỉ điều chỉnh bằng Phân công lại, Gia hạn, Huỷ, Phân công tiếp. Không cho xoá vụ việc. | [B21, B22, Q38] |
| BR32 | Mọi thay đổi trạng thái phần việc ghi nhật ký gồm giờ, người thực hiện, hành động; nhật ký không sửa, không xoá. | Mô tả, ảnh |
| BR33 | Vụ việc hoặc việc giao có nhiều cán bộ: mỗi cán bộ tự Hoàn thành phần việc của mình, không có nút Hoàn thành chung. Các trạng thái Đã đóng và Chờ chỉ đạo tạm bỏ qua. | [B4] |
| BR34 | Ủy quyền Tổ phó không giới hạn thời gian và số người; quản trị viên thu hồi ở mục quản lý tài khoản trên trang quản trị. | [B2] |
| BR35 | Người có quyền giao thấy cả tab Tiếp nhận (mọi vụ việc được tạo trong Đội) và tab Của tôi (vụ việc mình đã giao hoặc được chỉ định); tài khoản cán bộ chỉ thấy tab Của tôi. | [B24] |
| BR36 | Tổ trưởng, Phó đội trưởng giao cho các thành viên trong Đội mình và, với Xử lý vi phạm, ở các khu vực được phụ trách. | [B3, B25*] |
| BR37 | Khi cá nhân ký, ứng dụng không khoá màn hình và không ẩn thông tin vì cá nhân được xác nhận lại thông tin. | [B15] |
| BR38 | Mã vụ việc và mã việc giao dùng chung một chuỗi mã bắt đầu bằng VV. | [B1] |

# 10. Yêu cầu phi chức năng

| **Nhóm** | **Yêu cầu** | **Căn cứ** |
|---|---|---|
| **Nền tảng** | Ứng dụng di động cho iOS và Android. Phiên bản hệ điều hành tối thiểu chưa định. | [Q32] |
| **Kết nối** | Cần mạng để thao tác; không hỗ trợ ngoại tuyến. | [Q32] |
| **Thông báo** | Thông báo đẩy từ ứng dụng; không dùng SMS. | [Q32] |
| **Tài khoản** | Tài khoản do quản trị viên tạo; không xác thực hai lớp. | [Q33] |
| **Quy mô** | Không đặt giới hạn số người dùng và số vụ việc mỗi ngày. Chỉ tiêu người dùng đồng thời bỏ qua giai đoạn này [B17]. | [Q34] |
| **Hiệu năng (đề xuất)** | Mở danh sách và chi tiết vụ việc dưới 2 giây trên mạng 4G; thông báo tới người nhận dưới 10 giây; xuất PDF dưới 10 giây. Chờ khách hàng duyệt. | Đề xuất |
| **Bảo mật dữ liệu** | BR29: không che số CCCD; mã hoá khi truyền và khi lưu (đề xuất). | [B16], đề xuất |
| **Sẵn sàng** | Hoạt động 24/7 vì ca trực liên tục. | Suy ra |
| **Múi giờ và ngôn ngữ** | Giờ Việt Nam; giao diện tiếng Việt; biên bản tiếng Việt, tên theo giấy tờ; không yêu cầu song ngữ. | Ảnh, [B18] |
| **Xử lý trên thiết bị** | Nhận dạng giấy tờ (quét) và nhập giọng nói chạy trên thiết bị; yêu cầu độ chính xác cao (chưa có ngưỡng cụ thể). | [B13] |
| **Khả dụng** | Nhập bằng giọng nói ở các ô Mô tả, Nội dung, Kết quả hoặc lý do, Lý do. | Ảnh |
| **Lưu trữ** | Thời gian lưu vụ việc, biên bản, ảnh; sao lưu và khôi phục: bỏ qua giai đoạn này. | [B17] |

# Phụ lục A. Tổng hợp quyết định của khách hàng

Các quyết định lấy từ cột "Giả định tạm thời" của bảng câu hỏi, cập nhật 21/10/2026. Cột cuối chỉ nơi áp dụng trong tài liệu.

| **Câu** | **Quyết định** | **Áp dụng** |
|---|---|---|
| Q1 | "Tạo vụ việc" (xử lý vi phạm) và "Giao việc" là hai chức năng hoàn toàn riêng. Tạo vụ việc xử lý vi phạm: tạo giao việc theo mẫu các vụ việc có sẵn ở địa điểm cụ thể đã phân công cho Đội, điền 9 bước, chọn các tuỳ chọn cấu hình sẵn; mở bằng nút + ở Trang chủ; việc hiện ở tab Tiếp nhận và Của tôi. Giao việc: người có quyền giao bất kỳ nhiệm vụ nào, không cần địa điểm, vụ việc; mở bằng option Giao việc; việc hiện ở màn Giao việc. | 2.2, XL01, GV01 |
| Q2 | Sáu vai trò có quyền giao việc. Ủy quyền Tổ phó là ủy quyền cho một cán bộ trong Đội, quyền tương đương Đội trưởng: giao việc, giao vụ việc, gia hạn, phân công; cài đặt trong mục Tài khoản trên trang quản trị. | 3.3 |
| Q3 | Đội trưởng, Tổ phó giao trong Đội mình phụ trách; Trưởng, Phó trưởng CACK giao toàn bộ các Đội. Mọi thành viên Đội thấy tab Của Đội. Người được chỉ định có Đang làm, Hoàn thành. | 3.2, 3.4 |
| Q4 | Cán bộ không có quyền tạo vụ việc trừ khi được ủy quyền Tổ phó. Bỏ phần xử lý tại chỗ. | XL01 |
| Q5 | Tạm bỏ bộ lọc trạng thái. Gia hạn, phân công, huỷ thông báo đến Đội trưởng, người giao và người được chỉ định. | 4.2, CH07 |
| Q6 | Không bắt buộc bấm Đang làm trước Hoàn thành; Đang làm và Hoàn thành đều ghi nhật ký. | XL02, GV02, BR07 |
| Q7 | Người có quyền giao thấy Hoàn thành, Phân công lại, Gia hạn, Huỷ phần việc, Phân công tiếp, Lịch sử. Cán bộ được chỉ định thấy Đang làm, Hoàn thành, Lịch sử. Cán bộ không được chỉ định chỉ thấy Lịch sử. Người giao bấm Hoàn thành thay cán bộ. Cán bộ thường không thấy nút quản lý trừ khi được ủy quyền Tổ phó. | 3.4, XL02, GV02 |
| Q8 | Đã hoàn thành khi cán bộ phụ trách hoặc người giao bấm Hoàn thành; không hoàn tác. | 4.2, BR08 |
| Q9 | Phần việc đã huỷ vẫn tính vào mẫu số. | CH04, BR15 |
| Q10 | Một người phụ trách huỷ thì huỷ cả vụ việc; từ hai người trở lên chỉ huỷ phần của người được chọn; huỷ hết thì huỷ cả vụ việc. | CH04, BR14 |
| Q12 | Người đang được phân công không hiện trong danh sách của Phân công tiếp và Phân công lại. Phân công tiếp kế thừa hạn, chỉ người giao dùng. | CH02, CH03 |
| Q13 | Gia hạn không giới hạn số lần và thời gian, không cần duyệt, theo từng người được phân công; phần việc quá hạn vẫn gia hạn và kết quả "Không hoàn thành đúng hạn" bị xoá; bắt buộc lý do. | CH01, BR12 |
| Q14 | Nhắc một lần cho cán bộ được giao theo quy tắc 2/3, qua thông báo. | CH07, BR11 |
| Q17 | Đối tượng không bắt buộc; số lượng đối tượng không cần khớp số đã nhập. | XL01, BR18 |
| Q18 | Quét giấy tờ cho mọi loại giấy tờ; cán bộ kiểm tra lại; không lưu ảnh giấy tờ. | XL01, BR19 |
| Q19 | Danh mục quản trị trên web, loại hai cấp, có cờ yêu cầu biểu mẫu. Hiện chỉ "Phát hiện vật phẩm nguy hiểm" cần biểu mẫu và chữ ký. | 6.2, BR21 |
| Q20 | Tệp đính kèm hiện chỉ gửi ảnh. | XL01, GV01, BR20 |
| Q22 | Biểu mẫu cấu hình trên trang quản trị, trường khác nhau theo loại vụ việc; tập trung biểu mẫu Phát hiện vật phẩm nguy hiểm; không lập biểu mẫu vẫn Hoàn thành. | XL03, BR21 |
| Q23 | Chỉ yêu cầu chữ ký tay của hai bên (cá nhân và cán bộ). | XL03, BR22 |
| Q24 | Thiếu chữ ký của một bên thì ký không thành công, biên bản Chờ ký. Cá nhân ký trước; cán bộ không có quyền ký nếu cá nhân chưa ký thành công. | XL03, BR22 |
| Q25 | Mỗi cá nhân một biên bản; nhiều cán bộ tham gia chỉ cần một cán bộ ký. | XL03, BR24 |
| Q26 | Ký lại khi biên bản trước ký không thành công. Cán bộ hoặc người giao tạo biên bản mới tự điền từ biên bản cũ; biên bản cũ được giữ. | XL04, BR25 |
| Q29 | Các thành viên trong Đội thấy thống kê Trang chủ giống nhau. | CH05, BR27 |
| Q30 | Đội trưởng lập báo cáo Đội; Phó trưởng, Trưởng CACK lập báo cáo toàn đơn vị gồm nhiều Đội. Không cần ký duyệt, xuất PDF, lưu trên hệ thống quản trị. | CH06, BR26 |
| Q31 | Phòng Camera không có quyền tạo vụ việc. | 3.1, [B14] |
| Q32 | iOS và Android; cần kết nối mạng để thao tác; chỉ đẩy thông báo từ ứng dụng, không SMS. | 10, BR17 |
| Q33 | Đăng nhập bằng tài khoản do quản trị viên tạo; không xác thực hai lớp; chỉ quản trị viên quản lý tài khoản. | 10, BR30 |
| Q34 | Không giới hạn người dùng; không giới hạn số vụ việc mỗi ngày. | 10 |
| Q35 | Tạm bỏ qua tích hợp hệ thống ngoài. | 1.2, XL01, XL03 |
| Q38 | Người giao sửa được vụ việc, có lưu vết, không cho xoá (B21 giới hạn chỉ còn thêm ảnh). | XL05, BR31 |

# Phụ lục B. Quyết định cho các điểm còn mở

Khách hàng đã trả lời 24 điểm còn mở (B1–B24) ngày 22/10/2026; các quyết định được đưa vào các mục tương ứng và ký hiệu [Bn]. Cuối phụ lục là ba điểm mới (B25–B27) cần khách hàng xác nhận, đang dùng giả định.

| **Mã** | **Điểm còn mở** | **Quyết định của khách hàng** | **Áp dụng** |
|---|---|---|---|
| B1 | Chuỗi mã của vụ việc và việc giao. | Dùng chung chuỗi mã bắt đầu bằng VV. | 2.2, BR38 |
| B2 | Ủy quyền Tổ phó: thời hạn, thu hồi, số người. | Không giới hạn thời gian và số người được ủy quyền. Quản trị viên thu hồi quyền ở mục quản lý tài khoản trên trang quản trị. | 3.3, BR34 |
| B3 | Phạm vi giao của Tổ trưởng và Phó đội trưởng. | Các thành viên trong Đội và các khu vực được phụ trách. | 3.2, BR36 |
| B4 | Vụ việc, việc giao nhiều cán bộ; trạng thái Đã đóng, Chờ chỉ đạo. | Mỗi cán bộ tự Hoàn thành phần việc của mình, không có nút Hoàn thành chung. Đã đóng và Chờ chỉ đạo tạm thời bỏ qua. | 4.2, BR33 |
| B5 | Phân công lại. | Đổi người trên cùng phần việc, ghi nhật ký, giữ tất cả thông tin đã tạo. Bỏ qua ghi chú "Biên chế đã đổi; chỉ huy cần phân công lại...". | CH02, BR13 |
| B6 | Quá hạn. | Chỉ đánh dấu và báo người giao, người nhận việc; phần việc đã huỷ vẫn hiện dòng quá hạn. | CH04, BR10 |
| B7 | Mức Khẩn cấp. | Thông báo đẩy ưu tiên cao cho Chỉ huy Đội và lãnh đạo trực tiếp; không bắt buộc xác nhận. | XL01, BR16 |
| B8 | Hạn hoàn thành. | Không chọn quá khứ; không giới hạn tối đa; mặc định 17:00 có thể thay đổi. | XL01, GV01, BR06 |
| B9 | Biên bản: từ chối ký, không có mặt, ký lại. | Sau khi ghi nhận Từ chối ký hoặc Không có mặt, biên bản ở trạng thái Chờ ký (thiếu một trong hai chữ ký). Ký lại tạo biên bản mới tự điền thông tin từ biên bản cũ; biên bản cũ không thể ký tiếp. | XL03, XL04, BR22, BR25 |
| B10 | Sửa biên bản sau khi chốt, số biên bản. | Không sửa sau khi chốt; số biên bản tự tăng. | XL03, BR28 |
| B11 | Hồ sơ cán bộ. | Cấp bậc, số hiệu, chức vụ, đơn vị do quản trị viên nhập. Thiếu tức là chưa nhập; khi lập biên bản cán bộ tự điền các thông tin thiếu. | XL03 |
| B12 | Tệp đính kèm. | Chỉ ảnh, tối đa 50MB mỗi ảnh, gắn thời gian, không GPS. | XL01, GV01, BR20 |
| B13 | Nhận dạng giấy tờ và nhập giọng nói. | Chạy trên thiết bị; độ chính xác cao. | 10 |
| B14 | Nguồn Camera và Chỉ đạo. | Bỏ qua. | 1.2 |
| B15 | Thiết bị khi cá nhân ký. | Không khoá màn hình vào bước ký, không ẩn thông tin vì cá nhân được xác nhận lại thông tin. | XL03, BR37 |
| B16 | Dữ liệu cá nhân. | Không che số CCCD. | BR29 |
| B17 | Lưu trữ, sao lưu, người dùng đồng thời. | Bỏ qua. | 1.2, 10 |
| B18 | Ngôn ngữ biên bản cho người nước ngoài. | Bỏ qua. | 1.2, 10 |
| B19 | Thống kê Trang chủ. | Hiện số liệu của Đội cho mọi thành viên; các ô trạng thái chưa dùng hiện 0. | CH05, BR27 |
| B20 | Cấp trên nhận thông báo hoàn thành. | Đội trưởng của Đội. | CH07, XL02, GV02 |
| B21 | Sửa vụ việc sau khi tạo. | Chỉ được thêm ảnh vào trường Hình ảnh/Bằng chứng; thông tin đã nhập không thể sửa. Chỉ có thể Phân công lại, Gia hạn, Huỷ, Phân công tiếp. | XL05, BR31 |
| B22 | Sửa việc giao sau khi tạo. | Tương tự B21. | GV03, BR31 |
| B23 | Chip trạng thái việc giao; phạm vi thống kê và báo cáo. | Chip "Chưa hoàn thành" khi việc chưa hoàn thành; "Hoàn thành" khi người phụ trách ấn chọn Hoàn thành. Thống kê Trang chủ và Báo cáo chỉ ghi số liệu của vụ việc xử lý vi phạm. | 4.3, CH05, CH06 |
| B24 | Tab Tiếp nhận và tab Của tôi. | Người có quyền giao thấy cả hai tab; cán bộ chỉ thấy tab Của tôi. Tiếp nhận: tất cả vụ việc được tạo trong Đội. Của tôi: vụ việc tôi đã giao hoặc được chỉ định làm. | 3.4, XL02, BR35 |

**Điểm mới phát sinh khi tổng hợp (giả định, cần xác nhận):**

| **Mã** | **Điểm còn mở** | **Giả định đang dùng** |
|---|---|---|
| B25* | Khu vực được phụ trách của Tổ trưởng và Phó đội trưởng: ai gán, cấu hình ở đâu; có áp dụng cho Giao việc (không có khu vực) không. | Quản trị viên gán khu vực phụ trách cho từng tài khoản; chỉ giới hạn bước chọn khu vực của XL01; Giao việc chỉ giới hạn theo thành viên Đội. |
| B26* | Mẫu PDF biên bản (quốc hiệu, tiêu ngữ, số biên bản, mã QR) và mẫu gốc Word/PDF của từng biên bản chưa được cung cấp. | Trình bày theo mẫu gốc khi khách hàng cung cấp. |
| B27* | Việc giao có nhiều cán bộ: khi nào chip chuyển "Hoàn thành" (từng phần việc hay cả việc). | Chip Hoàn thành khi mọi phần việc còn hiệu lực đã Hoàn thành; còn phần chưa xong thì "Chưa hoàn thành". |

# Phụ lục C. Điểm chưa nhất quán của tài liệu nguồn và cách xử lý

| **#** | **Điểm chưa nhất quán** | **Cách xử lý** |
|---|---|---|
| 1 | Bản mô tả nói "2 phân quyền" nhưng nhóm giao việc có sáu vai trò và "Tổ phó được ủy quyền"; ảnh cho thấy Tổ phó cũng nằm trong danh sách người nhận. | Mục 3 theo [Q2, Q3]. |
| 2 | Bản mô tả trước dùng chung tên "Giao việc" cho cả tạo vụ việc và giao việc, và nói việc đã tạo hiện ở tab Tiếp nhận; bản cập nhật tách rõ Xử lý vi phạm (tab Tiếp nhận, Của tôi) và Giao việc (màn Giao việc). | Theo bản cập nhật (mục 2.2); phân biệt hai tab theo [B24]. |
| 3 | Bản mô tả ghi "Bước 9: chọn thời gian đến hạn"; màn hình Bước 9/9 tên "Xem lại và gửi", Bước 8 tên "Giao việc". | Theo ảnh (XL01). |
| 4 | Bản mô tả nói chuyển sang "đang thực hiện" rồi mới Hoàn thành; ảnh cho thấy hai nút cùng hiện ở trạng thái Đã giao. | [Q6]. |
| 5 | Bản mô tả nói thống kê về "các việc và xử lý vi phạm được giao"; ảnh thống kê rộng hơn (chờ tiếp nhận, khẩn cấp mở, đã đóng). | [B19, B23]: thống kê và báo cáo chỉ ghi vụ việc xử lý vi phạm. |
| 6 | Bước Phân công lại ghi nhầm "Mở vụ việc cần gia hạn". | Bỏ qua lỗi sao chép; sửa trong bản mô tả. |
| 7 | Mục "Ký lại biên bản" để trống phần mô tả. | Bổ sung theo [Q26] (XL04). |
| 8 | Báo cáo hằng ngày "chỉ người được quyền giao việc" dùng, nhưng mục nằm trong menu Cá nhân chung. | [Q30]; ẩn mục với cán bộ không có quyền. |
| 9 | Phần việc đã huỷ vẫn hiện dòng "Không hoàn thành đúng hạn từ..." (VV000152). | [B6]: giữ nguyên, phần việc đã huỷ vẫn hiện dòng quá hạn. |
| 10 | Màn Giao việc nêu nhiều loại tệp (PDF, Word, Excel, ZIP, RAR; 50MB) nhưng yêu cầu hiện chỉ gửi ảnh. | [Q20, B12]: chỉ ảnh. |
| 11 | Hai ảnh biểu mẫu cùng chú thích "ảnh 3"; lỗi chính tả ("Thềm", "hoà thành xong", "Chon loại"); dữ liệu thử ("Cggc", "Hự ăn", "Test"). | Sửa trong bản mô tả; không dùng dữ liệu thử làm giá trị chuẩn. |
| 12 | Phần luồng nhận việc của Giao việc trong bản mô tả vẫn viết "bấm vào vụ việc được giao" (sao chép từ phần Xử lý vi phạm); ảnh cho thấy việc được giao mở từ tab Giao cho tôi. | Hiểu là việc được giao (GV02); nên sửa lại câu chữ trong bản mô tả. |
| 13 | Q38 trả lời người giao sửa được vụ việc sau khi tạo; B21 giới hạn chỉ còn thêm ảnh vào Hình ảnh/Bằng chứng. | Theo B21 (cụ thể hơn); XL05, GV03. |
| 14 | Q7 và Q8 nói người giao bấm Hoàn thành thay cán bộ; B4 nói không có nút Hoàn thành chung. | Hiểu là Hoàn thành theo từng phần việc: người giao bấm thay cho từng cán bộ, không có nút hoàn thành cả vụ việc. |
