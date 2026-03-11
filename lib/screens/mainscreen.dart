import 'package:flutter/material.dart';
import '../main.dart';
import 'homescreen.dart';
import 'explorescreen.dart';
import 'libraryscreen.dart';
import 'statsscreen.dart';
import 'settingsscreen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const Color bgColor = Color(0xFFF6EEE8);
  static const Color primaryBrown = Color(0xFF9C6B4F);
  static const Color borderColor = Color(0xFFE8D9CF);
  static const Color textSoft = Color(0xFF8A6F60);
  static const Color navBg = Color(0xFFFFFAF6);

  static const List<Widget> _screens = [
    HomeScreen(),
    ExploreScreen(),
    LibraryScreen(),
    StatsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final vi = MyApp.of(context).isVietnamese;

    return Scaffold(
      backgroundColor: bgColor,

      // SỬA CHỖ NÀY: bỏ IndexedStack để màn Library được build lại
      body: _screens[_index],

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: navBg,
          border: Border(
            top: BorderSide(color: borderColor, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          type: BottomNavigationBarType.fixed,
          backgroundColor: navBg,
          elevation: 0,
          selectedItemColor: primaryBrown,
          unselectedItemColor: textSoft,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home_rounded),
              label: vi ? 'Trang chủ' : 'Home',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.explore_outlined),
              activeIcon: const Icon(Icons.explore_rounded),
              label: vi ? 'Khám phá' : 'Explore',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.library_books_outlined),
              activeIcon: const Icon(Icons.library_books_rounded),
              label: vi ? 'Thư viện' : 'Library',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bar_chart_outlined),
              activeIcon: const Icon(Icons.bar_chart_rounded),
              label: vi ? 'Thống kê' : 'Stats',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings_outlined),
              activeIcon: const Icon(Icons.settings_rounded),
              label: vi ? 'Cài đặt' : 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}