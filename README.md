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
   2. Trò chuyện
      - Nhắn tin trực tiếp với người mua
   3. Quản lý đơn hàng
      - Quản lý toàn bộ đơn hàng, gồm 5 trạng thái: Vừa tạo, Đang chờ, Đã xử lý, Đã xong, Đã hủy
      - Xem chi tiết và cập nhật trạng thái đơn hàng
   4. Quản lý bài đăng dịch vụ
      - Quản lý toàn bộ sản phẩm, thêm-xóa-sửa sản phẩm
        
3. Vai trò người mua

   1. Trang chủ
      - Quản lý các đơn hàng đã mua
   2. Trò chuyện
      - Nhắn tin trực tiếp với người bán
   3. Quản lý giỏ hàng
      - Quản lý các dịch vụ trong giỏ hàng, toàn bộ đơn hàng, đặt hàng
      - Xem chi tiết và cập nhật phản hồi cho người bán
   4. Tra cứu sản phẩm
      - Tìm kiếm sản phẩm theo tên hoặc các tiêu chuẩn tra cứu
   5. Xem mô tả sản phẩm
      - Người mua có thể xem thông tin sản phẩm sau đó thêm trực tiếp vào giỏ hàng hoặc mục yêu thích
      - Xem các lượt đánh giá của khách hàng khác về sản phẩm

4. Một số tính năng khác
   1. Xác thực người dùng
      - Đăng nhập, tạo tài khoản, khôi phục tài khoản
   2. Cài đặt hệ thống
      - Song ngữ Anh - Việt
      - Giao diện sáng - tối
   3. Xem thông tin Profile
      - Xem các mục đã yêu thích
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
