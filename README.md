# 📚 Bookify – Ứng dụng đọc sách điện tử

Bookify là một ứng dụng đọc sách điện tử được phát triển bằng **Flutter** dành cho thiết bị di động.  
Ứng dụng cho phép người dùng khám phá sách, đọc nội dung dưới dạng **PDF**, quản lý thư viện cá nhân và theo dõi quá trình đọc thông qua các thống kê trực quan.

Dự án được thực hiện trong khuôn khổ học phần **Lập trình cho thiết bị di động**.

---

# 📌 Thông tin dự án

| Thuộc tính | Giá trị |
|---|---|
| Tên ứng dụng | Bookify |
| Nền tảng | Flutter |
| Ngôn ngữ | Dart |
| Loại ứng dụng | E-book Reader |

---

# ✨ Tính năng

## 📚 Khám phá sách

- Hiển thị danh sách các đầu sách trong hệ thống
- Tìm kiếm sách theo **tên sách hoặc tác giả**
- Lọc sách theo **danh mục**

---

## 📖 Đọc sách

- Mở và đọc sách dưới dạng **PDF**
- Chuyển trang khi đọc
- Phóng to / thu nhỏ nội dung
- Lưu tiến độ đọc

---

## ❤️ Thư viện cá nhân

- Thêm sách vào **danh sách yêu thích**
- Đánh dấu trang đang đọc
- Quay lại trang đọc gần nhất

---

## 📊 Thống kê đọc sách

- Tổng số sách trong hệ thống
- Tổng số trang đã đọc
- Thời gian đọc
- Số sách đã hoàn thành
- Biểu đồ thống kê quá trình đọc

---

## ⚙️ Cài đặt

- Thay đổi ngôn ngữ (**Việt / Anh**)
- Bật / tắt **Dark Mode**
- Bật / tắt **Thông báo**

---

# 🖥 Demo giao diện

---

# 🏗 Kiến trúc hệ thống

Ứng dụng **Bookify** được thiết kế theo **mô hình kiến trúc phân lớp (Layered Architecture)** nhằm tách biệt rõ ràng các thành phần của hệ thống, giúp ứng dụng dễ bảo trì, mở rộng và phát triển trong tương lai.

```
Bookify Architecture
│
├── UI Layer (Screens)
│   ├── HomeScreen
│   ├── ExploreScreen
│   ├── LibraryScreen
│   ├── ReaderScreen
│   ├── StatsScreen
│   └── SettingsScreen
│
├── Data Layer
│   ├── BookModel
│   └── BooksData
│
└── Core Layer
    └── AppState
        ├── Theme
        ├── Language
        └── Settings
```

---

## Các thành phần chính của hệ thống

| Thành phần | Vai trò |
|---|---|
| Screens | Giao diện người dùng |
| Models | Mô hình dữ liệu |
| Data | Dữ liệu sách |
| State Management | Quản lý trạng thái ứng dụng |

---

# ⚙️ Cài đặt và chạy dự án

### 1. Clone repository

```bash
git clone https://github.com/yourusername/bookify.git
```

### 2. Di chuyển vào thư mục dự án

```bash
cd bookify
```

### 3. Cài đặt dependencies

```bash
flutter pub get
```

### 4. Chạy ứng dụng

```bash
flutter run
```

---

# 👨‍💻 Nhóm thực hiện

**Nguyễn Thế Cường**  
Email: 23010176@st.phenikaa-uni.edu.vn  

**Nguyễn Quốc Quang Anh**  
Email: 23010173@st.phenikaa-uni.edu.vn  

---

# 🙏 Lời cảm ơn

Nhóm em xin gửi lời cảm ơn chân thành tới **thầy Nguyễn Xuân Quế** đã hướng dẫn và hỗ trợ trong suốt quá trình thực hiện dự án.

Những kiến thức và sự hướng dẫn của thầy là nền tảng quan trọng giúp nhóm có thể hoàn thành ứng dụng **Bookify**.
