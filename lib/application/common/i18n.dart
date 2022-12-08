import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ottaa_project_flutter/application/language/translation_tree.dart';

class I18N {
  final Map<String, TranslationTree> _languages = {};

  Locale locale;
  TranslationTree? _currentLanguage;

  I18N(this.locale);

  Future<I18N> init() async {
    final languageCode = "${locale.languageCode}_${locale.countryCode}";

    if (_languages.containsKey(languageCode)) {
      _currentLanguage = _languages[languageCode]!;
      return this;
    }

    final newLanguage = await loadTranslation(locale);

    if (newLanguage != null) {
      _languages.putIfAbsent(languageCode, () => newLanguage);
      _currentLanguage = newLanguage;
    }

    return this;
  }

  Future<TranslationTree?> loadTranslation(Locale locale) async {
    try {
      if (locale.languageCode == "es" && locale.countryCode == "US") {
        locale = const Locale("en", "US");
      }

      final languageCode = "${locale.languageCode}_${locale.countryCode}";

      if (_languages.containsKey(languageCode)) {
        return _languages[languageCode];
      }

      final languageString = await rootBundle.loadString("assets/i18n/$languageCode.json");

      final languageJson = json.decode(languageString) as Map<String, dynamic>;

      final newLanguage = TranslationTree(locale);

      newLanguage.addTranslations(languageJson);

      return newLanguage;
    } catch (e) {
      return null;
    }
  }

  TranslationTree? get currentLanguage => _currentLanguage;

  void changeLanguage(String languageCode) {
    locale = Locale(languageCode.split("_")[0], languageCode.split("_")[1]);
    _currentLanguage = _languages[languageCode];
  }

  void changeLanguageFromLocale(Locale locale) {
    changeLanguage("${locale.languageCode}_${locale.countryCode}");
  }
}
