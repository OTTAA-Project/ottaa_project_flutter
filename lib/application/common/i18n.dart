import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/language/translation_tree.dart';
import 'package:ottaa_project_flutter/application/locator.dart';

class I18N extends ChangeNotifier {
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

  Future<void> changeLanguage(String languageCode) async {
    var split = languageCode.split("_");
    assert(split.length == 2, "Language code must be in the format: languageCode_countryCode (en_US");
    locale = Locale(split[0].toLowerCase(), split[1].toUpperCase());
    TranslationTree? newLanguage = _languages[languageCode] ?? await loadTranslation(locale);
    if (newLanguage == null) {
      throw Exception("Language not found");
    }
    _languages[languageCode] ??= newLanguage;
    _currentLanguage = _languages[languageCode];
    notify();
  }

  Future<void> changeLanguageFromLocale(Locale locale) async {
    assert(locale.countryCode != null, "Locale must have a country code");
    changeLanguage("${locale.languageCode.toLowerCase()}_${locale.countryCode?.toUpperCase()}");
  }

  void notify() {
    notifyListeners();
  }
}

final i18nProvider = ChangeNotifierProvider<I18N>((ref) {
  return locator<I18N>();
});
