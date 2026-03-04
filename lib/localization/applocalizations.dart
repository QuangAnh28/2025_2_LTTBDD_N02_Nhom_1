import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(
      context,
      AppLocalizations,
    )!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const supportedLocales = [
    Locale('vi'),
    Locale('en'),
  ];

  static const Map<String, Map<String, String>> _localizedValues = {
    'vi': {
      'home': 'Trang chủ',
      'explore': 'Khám phá',
      'library': 'Thư viện',
      'stats': 'Thống kê',
      'settings': 'Cài đặt',
      'language': 'Ngôn ngữ',
      'dark_mode': 'Chế độ tối',
      'notifications': 'Thông báo',
    },
    'en': {
      'home': 'Home',
      'explore': 'Explore',
      'library': 'Library',
      'stats': 'Statistics',
      'settings': 'Settings',
      'language': 'Language',
      'dark_mode': 'Dark Mode',
      'notifications': 'Notifications',
    },
  };

  String get(String key) {
    return _localizedValues[locale.languageCode]![key]!;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['vi', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
