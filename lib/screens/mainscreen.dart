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

  static const _screens = [
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
      body: _screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: vi ? 'Trang chủ' : 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.explore_outlined),
            label: vi ? 'Khám phá' : 'Explore',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.library_books_outlined),
            label: vi ? 'Thư viện' : 'Library',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bar_chart_outlined),
            label: vi ? 'Thống kê' : 'Stats',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            label: vi ? 'Cài đặt' : 'Settings',
          ),
        ],
      ),
    );
  }
}