import 'package:flutter/material.dart';
import '../main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = MyApp.of(context);

    final isVietnamese = appState.isVietnamese;
    final isDarkMode = appState.isDarkMode;
    final notificationsEnabled = appState.notificationsEnabled;

    final title = isVietnamese ? "Cài đặt" : "Setting";
    final languageLabel = isVietnamese ? "Ngôn ngữ" : "Language";
    final darkModeLabel = isVietnamese ? "Chế độ tối" : "Dark mode";
    final notiLabel = isVietnamese ? "Thông báo" : "Notifications";
    final aboutLabel = isVietnamese ? "Về ứng dụng" : "About";
    final contactLabel = isVietnamese ? "Liên hệ / Góp ý" : "Contact / Feedback";
    final rateLabel = isVietnamese ? "Đánh giá ứng dụng" : "Rate app";
    final logoutLabel = isVietnamese ? "Đăng xuất" : "Logout";

    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xff6A6AE3),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff6A6AE3), Color(0xff8B8BEF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(26)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 36,
                      color: Color(0xff6A6AE3),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // CHỈ HIỂN THỊ MSSV/ID (KHÔNG HIỂN THỊ TÊN)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isVietnamese ? "MSSV:" : "ID:",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 14),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Column(
                      children: [
                        _infoRow(
                          icon: Icons.book,
                          label: isVietnamese ? "Dự án" : "Project",
                          value: isVietnamese
                              ? "BookReader - Ứng dụng đọc sách"
                              : "BookReader - Reading app",
                        ),
                        const SizedBox(height: 10),
                        _infoRow(
                          icon: Icons.class_,
                          label: isVietnamese ? "Lớp" : "Class",
                          value: isVietnamese
                              ? "Lập trình cho thiết bị di động 1-2-25(N02)"
                              : "Mobile Programming 1-2-25(N02)",
                        ),
                        const SizedBox(height: 10),
                        _infoRow(
                          icon: Icons.school,
                          label: isVietnamese ? "Giảng viên" : "Lecturer",
                          value: isVietnamese
                              ? "Nguyễn Xuân Quế"
                              : "Nguyen Xuan Que",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _cardSection(
              children: [
                ListTile(
                  leading: const Icon(Icons.language, color: Color(0xff1b74e4)),
                  title: Text(languageLabel),
                  trailing: DropdownButtonHideUnderline(
                    child: DropdownButton<bool>(
                      value: isVietnamese,
                      items: const [
                        DropdownMenuItem(
                          value: true,
                          child: Text("Tiếng Việt"),
                        ),
                        DropdownMenuItem(
                          value: false,
                          child: Text("English"),
                        ),
                      ],
                      onChanged: (v) {
                        if (v == null) return;
                        appState.changeLanguage(v);
                        setState(() {});
                      },
                    ),
                  ),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary:
                      const Icon(Icons.dark_mode, color: Color(0xff2d7dff)),
                  title: Text(darkModeLabel),
                  value: isDarkMode,
                  onChanged: (v) {
                    appState.changeTheme(v);
                    setState(() {});
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.notifications,
                      color: Color(0xff2d7dff)),
                  title: Text(notiLabel),
                  value: notificationsEnabled,
                  onChanged: (v) {
                    appState.changeNotification(v);
                    setState(() {});
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.info_outline,
                      color: Color(0xff2d7dff)),
                  title: Text(aboutLabel),
                  subtitle: const Text("Version 1.0.0"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showAboutDialog(context, isVietnamese),
                ),
              ],
            ),

            const SizedBox(height: 12),

            _cardSection(
              children: [
                ListTile(
                  leading: const Icon(Icons.mail_outline,
                      color: Color(0xff2d7dff)),
                  title: Text(contactLabel),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showContactDialog(context, isVietnamese),
                ),
                const Divider(height: 1),
                ListTile(
                  leading:
                      const Icon(Icons.star_outline, color: Color(0xfff5a623)),
                  title: Text(rateLabel),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isVietnamese
                            ? "Chức năng minh hoạ: mở đánh giá ứng dụng"
                            : "Demo: open app rating"),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),

                // ✅ LOGOUT
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: Text(
                    logoutLabel,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  onTap: () async {
                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(logoutLabel),
                        content: Text(isVietnamese
                            ? "Bạn có chắc muốn đăng xuất không?"
                            : "Are you sure you want to logout?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text(isVietnamese ? "Hủy" : "Cancel"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text(logoutLabel),
                          ),
                        ],
                      ),
                    );

                    if (ok != true) return;

                    // Tạm thời: quay về màn trước
                    if (context.mounted) Navigator.pop(context);
                  },
                ),
              ],
            ),

            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  static Widget _cardSection({required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 18,
            offset: Offset(0, 8),
            color: Color(0x14000000),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(children: children),
      ),
    );
  }

  static Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static void _showAboutDialog(BuildContext context, bool isVietnamese) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isVietnamese ? "Về ứng dụng" : "About"),
        content: Text(
          isVietnamese
              ? "Bookify.\nPhiên bản: 1.0.0"
              : "Bookify.\nVersion: 1.0.0",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isVietnamese ? "Đóng" : "Close"),
          )
        ],
      ),
    );
  }

  static void _showContactDialog(BuildContext context, bool isVietnamese) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isVietnamese ? "Thông tin liên hệ" : "Contact"),
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
  }
}