import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangController extends ChangeNotifier {
  // Default language
  static const String _defaultLangCode = "en";

  // Private variables
  late SharedPreferences _prefs; // Shared preferences instance
  Locale _locale = Locale(_defaultLangCode); // Current locale
  String _currentLangCode = _defaultLangCode; // Synchronous language code

  // Public getters
  Locale get locale => _locale;
  String get currentLangCode => _currentLangCode;

  // Constructor: Initialize shared preferences and load the saved language
  LangController() {
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadSavedLanguage();
  }

  // Load saved language from shared preferences
  Future<void> _loadSavedLanguage() async {
    String langCode = _prefs.getString("lang") ?? _defaultLangCode;
    _updateLocale(langCode);
  }

  // Update the locale and notify listeners
  void _updateLocale(String langCode) {
    _locale = Locale(langCode);
    _currentLangCode = langCode; // Update the synchronous language code
    notifyListeners();
  }

  // Change the language
  Future<void> changeLang({required String langCode}) async {
    try {
      await _prefs.setString("lang", langCode);
      _updateLocale(langCode);
    } catch (e) {
      print("Failed to save language preference: $e");
    }
  }
}