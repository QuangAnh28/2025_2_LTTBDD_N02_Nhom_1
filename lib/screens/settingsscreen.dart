import 'package:flutter/material.dart';
import '../main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const Color bgColor = Color(0xFFF6EEE8);
  static const Color primaryBrown = Color(0xFF9C6B4F);
  static const Color darkBrown = Color(0xFF5E4032);
  static const Color softBrown = Color(0xFFD8C2B3);
  static const Color cardColor = Color(0xFFFFFAF6);
  static const Color borderColor = Color(0xFFE8D9CF);
  static const Color textSoft = Color(0xFF8A6F60);
  static const Color chipBg = Color(0xFFF1E4DB);
  static const Color dangerColor = Color(0xFFD87C7C);
  static const Color accentColor = Color(0xFFE0A85A);

  @override
  Widget build(BuildContext context) {
    final appState = MyApp.of(context);

    final isVietnamese = appState.isVietnamese;
    final isDarkMode = appState.isDarkMode;
    final notificationsEnabled = appState.notificationsEnabled;

    final title = isVietnamese ? "Cài đặt" : "Settings";
    final languageLabel = isVietnamese ? "Ngôn ngữ" : "Language";
    final darkModeLabel = isVietnamese ? "Chế độ tối" : "Dark mode";
    final notiLabel = isVietnamese ? "Thông báo" : "Notifications";
    final aboutLabel = isVietnamese ? "Về ứng dụng" : "About";
    final contactLabel = isVietnamese ? "Liên hệ / Góp ý" : "Contact / Feedback";
    final rateLabel = isVietnamese ? "Đánh giá ứng dụng" : "Rate app";
    final logoutLabel = isVietnamese ? "Đăng xuất" : "Logout";

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: darkBrown,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        backgroundColor: bgColor,
        foregroundColor: darkBrown,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
              decoration: BoxDecoration(
                color: primaryBrown,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 4),
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white24),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      size: 38,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.16),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isVietnamese ? "MSSV:" : "ID:",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Column(
                      children: [
                        _infoRow(
                          icon: Icons.book_rounded,
                          label: isVietnamese ? "Dự án" : "Project",
                          value: isVietnamese
                              ? "BookReader - Ứng dụng đọc sách"
                              : "BookReader - Reading app",
                        ),
                        const SizedBox(height: 12),
                        _infoRow(
                          icon: Icons.class_rounded,
                          label: isVietnamese ? "Lớp" : "Class",
                          value: isVietnamese
                              ? "Lập trình cho thiết bị di động 1-2-25(N02)"
                              : "Mobile Programming 1-2-25(N02)",
                        ),
                        const SizedBox(height: 12),
                        _infoRow(
                          icon: Icons.school_rounded,
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
                  leading: _leadingIcon(Icons.language_rounded),
                  title: Text(
                    languageLabel,
                    style: const TextStyle(
                      color: darkBrown,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  trailing: DropdownButtonHideUnderline(
                    child: DropdownButton<bool>(
                      value: isVietnamese,
                      dropdownColor: cardColor,
                      style: const TextStyle(
                        color: darkBrown,
                        fontWeight: FontWeight.w700,
                      ),
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
                const Divider(height: 1, color: borderColor),
                SwitchListTile(
                  secondary: _leadingIcon(Icons.dark_mode_rounded),
                  title: const Text(
                    "Chế độ tối",
                    style: TextStyle(
                      color: darkBrown,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  value: isDarkMode,
                  activeColor: primaryBrown,
                  onChanged: (v) {
                    appState.changeTheme(v);
                    setState(() {});
                  },
                ),
                const Divider(height: 1, color: borderColor),
                SwitchListTile(
                  secondary: _leadingIcon(Icons.notifications_rounded),
                  title: Text(
                    notiLabel,
                    style: const TextStyle(
                      color: darkBrown,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  value: notificationsEnabled,
                  activeColor: primaryBrown,
                  onChanged: (v) {
                    appState.changeNotification(v);
                    setState(() {});
                  },
                ),
                const Divider(height: 1, color: borderColor),
                ListTile(
                  leading: _leadingIcon(Icons.info_outline_rounded),
                  title: Text(
                    aboutLabel,
                    style: const TextStyle(
                      color: darkBrown,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: const Text(
                    "Version 1.0.0",
                    style: TextStyle(color: textSoft),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: textSoft,
                  ),
                  onTap: () => _showAboutDialog(context, isVietnamese),
                ),
              ],
            ),

            const SizedBox(height: 12),

            _cardSection(
              children: [
                ListTile(
                  leading: _leadingIcon(Icons.mail_outline_rounded),
                  title: Text(
                    contactLabel,
                    style: const TextStyle(
                      color: darkBrown,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: textSoft,
                  ),
                  onTap: () => _showContactDialog(context, isVietnamese),
                ),
                const Divider(height: 1, color: borderColor),
                ListTile(
                  leading: _leadingIcon(
                    Icons.star_outline_rounded,
                    iconColor: accentColor,
                  ),
                  title: Text(
                    rateLabel,
                    style: const TextStyle(
                      color: darkBrown,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: textSoft,
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: primaryBrown,
                        content: Text(
                          isVietnamese
                              ? "Chức năng minh hoạ: mở đánh giá ứng dụng"
                              : "Demo: open app rating",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
                const Divider(height: 1, color: borderColor),
                ListTile(
                  leading: _leadingIcon(
                    Icons.logout_rounded,
                    iconColor: dangerColor,
                  ),
                  title: Text(
                    logoutLabel,
                    style: const TextStyle(
                      color: dangerColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  onTap: () async {
                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Text(
                          logoutLabel,
                          style: const TextStyle(
                            color: darkBrown,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        content: Text(
                          isVietnamese
                              ? "Bạn có chắc muốn đăng xuất không?"
                              : "Are you sure you want to logout?",
                          style: const TextStyle(color: textSoft),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text(
                              isVietnamese ? "Hủy" : "Cancel",
                              style: const TextStyle(color: textSoft),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text(
                              "Logout",
                              style: TextStyle(
                                color: dangerColor,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );

                    if (ok != true) return;

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

  static Widget _leadingIcon(
    IconData icon, {
    Color iconColor = primaryBrown,
  }) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: chipBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: iconColor, size: 20),
    );
  }

  static Widget _cardSection({required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            blurRadius: 14,
            offset: const Offset(0, 6),
            color: Colors.black.withOpacity(0.04),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
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
        backgroundColor: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          isVietnamese ? "Về ứng dụng" : "About",
          style: const TextStyle(
            color: darkBrown,
            fontWeight: FontWeight.w800,
          ),
        ),
        content: Text(
          isVietnamese
              ? "Bookify.\nPhiên bản: 1.0.0"
              : "Bookify.\nVersion: 1.0.0",
          style: const TextStyle(
            color: textSoft,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              isVietnamese ? "Đóng" : "Close",
              style: const TextStyle(
                color: primaryBrown,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }

  static void _showContactDialog(BuildContext context, bool isVietnamese) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          isVietnamese ? "Thông tin liên hệ" : "Contact",
          style: const TextStyle(
            color: darkBrown,
            fontWeight: FontWeight.w800,
          ),
        ),
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
            style: const TextStyle(
              color: textSoft,
              height: 1.5,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              isVietnamese ? "Đóng" : "Close",
              style: const TextStyle(
                color: primaryBrown,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }
}