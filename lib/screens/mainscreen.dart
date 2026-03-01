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

  final _screens = const [
    HomeScreen(),
    ExploreScreen(),
    LibraryScreen(),
    StatsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: 'Khám phá'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books_outlined), label: 'Thư viện'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: 'Thống kê'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Cài đặt'),
        ],
      ),
    );
  }
}