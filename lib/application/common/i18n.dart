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
      _languages[languageCode] = newLanguage;
      _currentLanguage = newLanguage;
    }

    return this;
  }

  Future<TranslationTree?> loadTranslation(Locale locale) async {
    try {
      final languageCode = "${locale.languageCode}_${locale.countryCode}";

      if (_languages.containsKey(languageCode)) {
        return _languages[languageCode];
      }

      final languageString = await rootBundle.loadString("assets/i18n/$languageCode.json");

      final languageJson = Map.from(json.decode(languageString));

      final newLanguage = TranslationTree(locale);

      languageJson.forEach((key, value) {
        newLanguage.addTranslation(key, value);
      });

      _languages.putIfAbsent(languageCode, () => newLanguage);

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
