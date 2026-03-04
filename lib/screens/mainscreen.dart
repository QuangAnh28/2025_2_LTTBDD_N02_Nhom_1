import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final isVietnamese = Localizations.localeOf(context).languageCode == 'vi';

    final screens = const [
      HomeScreen(),
      ExploreScreen(),
      LibraryScreen(),
      StatsScreen(),
      SettingsScreen(),
    ];

    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: isVietnamese ? 'Trang chủ' : 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.explore_outlined),
            label: isVietnamese ? 'Khám phá' : 'Explore',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.library_books_outlined),
            label: isVietnamese ? 'Thư viện' : 'Library',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bar_chart_outlined),
            label: isVietnamese ? 'Thống kê' : 'Stats',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            label: isVietnamese ? 'Cài đặt' : 'Settings',
          ),
        ],
      ),
    );
  }
}
