import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/giaodiencho.dart';
import 'screens/mainscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('vi');
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _themeMode = ThemeMode.values[prefs.getInt('themeMode') ?? 0];
      _locale = Locale(prefs.getString('language') ?? 'vi');
      _notificationsEnabled = prefs.getBool('notifications') ?? true;
    });
  }

  Future<void> changeTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
    prefs.setInt('themeMode', _themeMode.index);
  }

  Future<void> changeLanguage(bool isVietnamese) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _locale = Locale(isVietnamese ? 'vi' : 'en');
    });
    prefs.setString('language', isVietnamese ? 'vi' : 'en');
  }

  Future<void> changeNotification(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = value;
    });
    prefs.setBool('notifications', value);
  }

  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isVietnamese => _locale.languageCode == 'vi';
  bool get notificationsEnabled => _notificationsEnabled;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reading App',
      themeMode: _themeMode,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      locale: _locale,
      home: const SplashScreen(),
    );
  }
}
