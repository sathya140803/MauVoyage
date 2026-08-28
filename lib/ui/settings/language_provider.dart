import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = Locale('en'); // Default language
  final GetStorage _storage = GetStorage();

  LanguageProvider() {
    String? savedLocale = _storage.read('language');
    if (savedLocale != null && _isSupportedLocale(savedLocale)) {
      _locale = Locale(savedLocale);
    }
  }

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!_isSupportedLocale(locale.languageCode)) return;

    _locale = locale;
    _storage.write('language', locale.languageCode);
    notifyListeners();
  }

  bool _isSupportedLocale(String code) {
    return ['en', 'fr', 'es', 'hi'].contains(code);
  }
}
