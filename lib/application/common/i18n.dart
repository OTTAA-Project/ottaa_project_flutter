import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ottaa_project_flutter/application/language/file_language.dart';
import 'package:ottaa_project_flutter/application/language/spanish.dart';
import 'package:ottaa_project_flutter/core/abstracts/language.dart';

const defaultFallbackLanguage = SpanishLanguage();

class I18N {
  final Map<String, Language> _languages = {"es": defaultFallbackLanguage};

  final String languageCode;
  late Language _currentLanguage;

  I18N(this.languageCode);

  Future<I18N> init() async {
    if (_languages.containsKey(languageCode)) {
      _currentLanguage = _languages[languageCode]!;
      return this;
    }

    final newLanguage = await loadLanguage(languageCode);

    if (newLanguage != null) {
      _languages[languageCode] = newLanguage;
      _currentLanguage = newLanguage;
    } else {
      _currentLanguage = defaultFallbackLanguage;
    }

    return this;
  }

  Future<Language?> loadLanguage(String languageCode) async {
    try {
      final languageString = await rootBundle.loadString("assets/i18n/$languageCode.json");

      FileLanguage newLanguage = FileLanguage(
        languageCode: languageCode,
        translations: Map.from(json.decode(languageString)),
      );

      return newLanguage;
    } catch (e) {
      return null;
    }
  }

  Language get currentLanguage => _currentLanguage;

  void changeLanguage(String languageCode) {
    _currentLanguage = _languages[languageCode] ?? const SpanishLanguage();
  }

  void changeLanguageFromLocale(Locale locale) {
    changeLanguage(locale.languageCode);
  }
}
