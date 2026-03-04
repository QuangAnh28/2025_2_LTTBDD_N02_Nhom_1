import 'package:flutter/material.dart';
import '../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = MyApp.of(context);

    final isVietnamese = appState.isVietnamese;
    final isDarkMode = appState.isDarkMode;
    final notificationsEnabled = appState.notificationsEnabled;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            isVietnamese ? "Cài đặt" : "Settings",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // 🌍 NGÔN NGỮ
          Card(
            child: SwitchListTile(
              title: Text(isVietnamese ? "Ngôn ngữ" : "Language"),
              subtitle: Text(isVietnamese ? "Tiếng Việt" : "English"),
              value: isVietnamese,
              onChanged: (value) {
                appState.changeLanguage(value);
              },
            ),
          ),

          // 🌙 DARK MODE
          Card(
            child: SwitchListTile(
              title: Text(isVietnamese ? "Chế độ tối" : "Dark Mode"),
              subtitle: Text(isDarkMode
                  ? (isVietnamese ? "Đang bật" : "Enabled")
                  : (isVietnamese ? "Đang tắt" : "Disabled")),
              value: isDarkMode,
              onChanged: (value) {
                appState.changeTheme(value);
              },
            ),
          ),

          // 🔔 THÔNG BÁO
          Card(
            child: SwitchListTile(
              title: Text(isVietnamese ? "Thông báo" : "Notifications"),
              subtitle: Text(notificationsEnabled
                  ? (isVietnamese
                      ? "Đang bật thông báo"
                      : "Notifications enabled")
                  : (isVietnamese
                      ? "Đang tắt thông báo"
                      : "Notifications disabled")),
              value: notificationsEnabled,
              onChanged: (value) {
                appState.changeNotification(value);
              },
            ),
          ),

          const SizedBox(height: 20),

          // 📄 THÔNG TIN LIÊN HỆ
          Card(
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(
                  isVietnamese ? "Thông tin liên hệ" : "Contact Information"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(isVietnamese
                        ? "Thông tin dự án"
                        : "Project Information"),
                    content: SingleChildScrollView(
                      child: Text(
                        isVietnamese
                            ? """Dự án: E-book Reading - Ứng dụng đọc sách điện tử

Lớp: Lập trình cho thiết bị di động 1-2-25(N02)

Giảng viên: Nguyễn Xuân Quế

Nhóm: 1

Tên:
Nguyễn Thế Cường
Nguyễn Quốc Quang Anh

MSV:
23010176
23010173

Email:
23010176@st.phenikaa-uni.edu.vn
23010173@st.phenikaa-uni.edu.vn
"""
                            : """Project: E-book Reading Application

Class: Mobile Programming 1-2-25(N02)

Lecturer: Nguyen Xuan Que

Group: 1

Members:
Nguyen The Cuong
Nguyen Quoc Quang Anh

Student IDs:
23010176
23010173

Emails:
23010176@st.phenikaa-uni.edu.vn
23010173@st.phenikaa-uni.edu.vn
""",
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(isVietnamese ? "Đóng" : "Close"),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
