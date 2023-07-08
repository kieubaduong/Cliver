# Cliver-mobile - Phần mềm giao dịch dịch vụ thương mại giữa người bán và người mua <p id="Top"/>

## I. Tổng quan ứng dụng

### Yêu cầu thiết bị

- Android:
  - minSdkVersion: 24.0
  - targetSdkVersion: 33.0
- iOS 11

### Công nghệ và thư viện

- Front end:
  - Ngôn ngữ: Dart
  - Công nghệ: Flutter
- Backend:
  - Ngôn ngữ: C#
  - Công nghệ: ASP.NET Core
    - Backend Platform: ASP.NET Core
    - Database: SQL Server

### Chức năng ứng dụng

1. Đối tượng sử dụng

   - Người bán
   - Người mua

2. Vai trò người bán

   1. Trang chủ
      - Cung cấp tổng quan tình trạng đơn hàng mới, các dịch vụ, đăng bán các bài đăng dịch vụ
        - <img src="https://user-images.githubusercontent.com/90909489/171345876-9bb9e834-584a-4531-a205-760ae0b6b10a.png" width="337" height="600"/>
   2. Trò chuyện
      - Nhắn tin trực tiếp với người mua, gọi thoại
        - <span><img src="https://user-images.githubusercontent.com/90909489/171347136-eb00c3ab-8e91-4eb0-a92b-0f8b7ba63e02.png" width="337" height="600"/> <img src="https://user-images.githubusercontent.com/90909489/171347388-6e5cd3a8-3dcd-4508-9a45-41207a2f7c6b.png" width="337" height="600"/> </span>
   3. Quản lý đơn hàng
      - Quản lý toàn bộ đơn hàng, gồm 5 trạng thái: Vừa tạo, Đang chờ, Đã xử lý, Đã xong, Đã hủy
      - Xem chi tiết và cập nhật trạng thái đơn hàng
        - <span><img src="https://user-images.githubusercontent.com/90909489/171348141-2a3dff26-ab31-4d5b-a42f-0744d79e9f02.png" width="337" height="600"/> <img src="https://user-images.githubusercontent.com/90909489/171350309-a97673fb-c99d-41ab-ac2f-5b0ae9eae8ec.png" width="337" height="600"/> </span>
   4. Quản lý bài đăng dịch vụ
      - Quản lý toàn bộ sản phẩm, thêm-xóa-sửa sản phẩm
        - <span><img src="https://user-images.githubusercontent.com/90909489/171350629-5c835c17-9807-4797-85d3-05bacfb14e42.png" width="337" height="600"/> <img src="https://user-images.githubusercontent.com/90909489/171350864-8fb399b3-0570-40d3-a8be-9fa29d285dc4.png" width="337" height="600"/> </span>

3. Vai trò người mua

   1. Trang chủ
      - Gợi ý các đơn hàng đã mua
        - <img src="https://user-images.githubusercontent.com/90909489/171352208-026ed8ac-d37b-41d9-86ab-a6d470f348da.png" width="337" height="600"/>
   2. Trò chuyện
      - Nhắn tin trực tiếp với người bán
        - <img src="https://user-images.githubusercontent.com/90909489/171353186-c141cba5-48d5-4d05-b676-45177a8e6444.png" width="337" height="600"/>
   3. Quản lý giỏ hàng
      - Quản lý các dịch vụ trong giỏ hàng, toàn bộ đơn hàng, đặt hàng
      - Xem chi tiết và cập nhật phản hồi cho người bán
        - <span><img src="https://user-images.githubusercontent.com/90909489/171353493-f7b223cf-7701-4494-b6a6-539826e54c09.png" width="337" height="600"/> <img src="https://user-images.githubusercontent.com/90909489/171353538-fba8b244-2adc-40df-9e42-2f39f8d489a7.png" width="337" height="600"/> </span>
   4. Tra cứu sản phẩm
      - Tìm kiếm sản phẩm theo tên hoặc các tiêu chuẩn tra cứu
        - <img src="https://user-images.githubusercontent.com/90909489/171353982-2fde3532-a89b-486e-b55d-646cb162bc66.png" width="337" height="600"/>
   5. Xem mô tả sản phẩm
      - Người mua có thể xem thông tin sản phẩm sau đó thêm trực tiếp vào giỏ hàng hoặc mục yêu thích
      - Xem các lượt đánh giá của khách hàng khác về sản phẩm
        - <span><img src="https://user-images.githubusercontent.com/90909489/171354438-9856fceb-4480-4ce8-81d4-5d05835fd6f5.png" width="337" height="600"/> <img src="https://user-images.githubusercontent.com/90909489/171354858-29b93406-8482-48e6-8edb-0bb6ac006902.png" width="337" height="600"/> </span>

4. Một số tính năng khác
   1. Xác thực người dùng
      - Đăng nhập, tạo tài khoản, khôi phục tài khoản
        > Gồm nhiều bước xác thực
        - <span><img src="https://user-images.githubusercontent.com/90909489/171355277-a2e7c153-f2f9-46ac-9fee-e3e88ff5bc9d.png" width="282" height="500"/> <img src="https://user-images.githubusercontent.com/90909489/171356259-c2111225-99d2-4e95-88e7-430ca74c169f.png" width="282" height="500"/> <img src="https://user-images.githubusercontent.com/90909489/171355788-62f5dd58-5392-492f-b44a-0a3055a52ce3.png" width="282" height="500"/> </span>
   2. Cài đặt hệ thống
      - Song ngữ Anh - Việt
      - Giao diện sáng - tối
      - Bật - tắt âm báo
        - <img src="https://user-images.githubusercontent.com/90909489/171357186-10fdebf1-94c2-4076-8c3a-76a82e72df97.png" width="337" height="600"/>
   3. Xem thông tin Profile
      - Xem các mục đã yêu thích
        - <img src="https://user-images.githubusercontent.com/90909489/171358389-82ec3d07-ec72-431c-b3b8-4eaa2ba36c69.png" width="337" height="600"/>
   4. Và còn nữa...

### Backend

Source code: https://github.com/ddatdt12/cliver-system.git

### Sơ đồ ERD

<p align="center">
  <img src="./assets/ERD_Foca.drawio.png" width="100%" title="hover text">
</p>

## II. Tổng kết

### Tác giả

- [Trần Đình Khôi](https://github.com/TranDKhoi) (Team lead)

- [Đỗ Thành Đạt](https://github.com/ddatdt12) (BE)

- [Lê Hải Phong](https://github.com/HaiPhong146) (FE)

- [Kiều Bá Dương](https://github.com/kieubaduong) (FE)

### Giảng viên hướng dẫn

- Giảng viên: Nguyễn Tấn Toàn

### Lời cảm ơn

Sản phẩm là kết quả sau quá trình cùng nhau thực hiện đồ án của những thành viên trong nhóm. Thông qua quá trình này, các thành viên đã có cho mình những lượng kiến thức và kỹ năng chuyên môn nhất định về quy trình lập trình thực tế, hiểu hơn về lập trình ứng dụng di động và có riêng cho mình những bài học quý giá làm hành trang cho công việc sau này.

Ngoài ra, nhóm cũng muốn gửi lời cảm ơn chân thành và sự tri ân sâu sắc đến giảng viên giảng dạy, thầy **Nguyễn Tấn Toàn** đã cùng đồng hành với nhóm trong suốt quá trình thực hiện đồ án để có được thành quả như hôm nay.

Sản phẩm của nhóm có thể còn nhiều thiếu sót trong quá trình xây dựng và phát triển. Vì vậy, đừng ngần ngại gửi những đóng góp hoặc ý kiến của bạn đến email SquandinCinema@gmail.com. Mỗi đóng góp của các bạn đều sẽ được ghi nhận và sẽ là động lực để nhóm có thể hoàn thiện sản phẩm hơn nữa.

Cảm ơn bạn đã quan tâm!

<p align="right"><a href="#Top">Quay lại đầu trang</a></p>
