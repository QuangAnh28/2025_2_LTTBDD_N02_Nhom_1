📚 Bookify – Ứng dụng đọc sách điện tử
📖 Thông tin dự án

Bookify là một ứng dụng đọc sách điện tử được phát triển trên nền tảng Flutter dành cho thiết bị di động. Ứng dụng cho phép người dùng khám phá các đầu sách, đọc nội dung sách dưới dạng PDF, quản lý thư viện cá nhân và theo dõi quá trình đọc thông qua các thống kê trực quan.

Dự án được thực hiện trong khuôn khổ học phần Lập trình cho thiết bị di động.

Thông tin dự án

Tên ứng dụng: Bookify

Nền tảng: Flutter

Ngôn ngữ: Dart

Loại ứng dụng: Ứng dụng đọc sách điện tử (E-book Reader)

✨ Tính năng

Ứng dụng cung cấp các chức năng chính sau:

📚 Khám phá sách

Hiển thị danh sách các đầu sách trong hệ thống

Tìm kiếm sách theo tên

Lọc sách theo danh mục

📖 Đọc sách

Mở và đọc sách dưới dạng PDF

Chuyển trang khi đọc

Phóng to / thu nhỏ nội dung

Lưu tiến độ đọc

❤️ Thư viện cá nhân

Thêm sách vào danh sách yêu thích

Đánh dấu trang đang đọc

Quay lại trang đọc gần nhất

📊 Thống kê đọc sách

Tổng số sách trong hệ thống

Tổng số trang đã đọc

Thời gian đọc

Số sách đã hoàn thành

Biểu đồ thống kê quá trình đọc

⚙️ Cài đặt

Thay đổi ngôn ngữ (Việt / Anh)

Bật / tắt Dark Mode

Bật / tắt Thông báo

🎬 Demo

Một số màn hình chính của ứng dụng:

Trang chủ

Khám phá sách

Màn hình đọc sách

Thư viện cá nhân

Thống kê

Cài đặt

📌 Demo ứng dụng:
(Bạn có thể thêm ảnh hoặc video demo tại đây)

Ví dụ:

/demo
   home.png
   reader.png
   library.png
🏗 Kiến trúc

Ứng dụng được thiết kế theo mô hình kiến trúc phân lớp, bao gồm:

UI Layer (Screens)
   │
   ├── HomeScreen
   ├── ExploreScreen
   ├── LibraryScreen
   ├── ReaderScreen
   ├── StatsScreen
   └── SettingsScreen

Data Layer
   │
   ├── Book Model
   └── Books Data

Core Layer
   │
   └── App State (Theme, Language, Settings)

Các thành phần chính của hệ thống:

Screens – giao diện người dùng

Models – mô hình dữ liệu

Data – dữ liệu sách

State Management – quản lý trạng thái ứng dụng

⚙️ Cài đặt
1️⃣ Clone repository
git clone https://github.com/yourusername/bookify.git
2️⃣ Di chuyển vào thư mục dự án
cd bookify
3️⃣ Cài đặt dependencies
flutter pub get
4️⃣ Chạy ứng dụng
flutter run
📬 Liên hệ

Nhóm thực hiện

Nguyễn Thế Cường
Email: 23010176@st.phenikaa-uni.edu.vn

Nguyễn Quốc Quang Anh
Email: 23010173@st.phenikaa-uni.edu.vn

🙏 Lời cảm ơn

Nhóm xin gửi lời cảm ơn chân thành tới giảng viên Nguyễn Xuân Quế đã hướng dẫn và hỗ trợ trong suốt quá trình thực hiện dự án.

Những kiến thức và sự hướng dẫn của thầy là nền tảng quan trọng giúp nhóm có thể hoàn thành ứng dụng Bookify.
