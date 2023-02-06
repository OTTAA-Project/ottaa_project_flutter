import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ottaa_project_flutter/application/language/translation_tree.dart';

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

    TranslationTree? newLanguage = await loadTranslation(locale);
    newLanguage ??= await loadTranslation(const Locale("es", "AR"));

    _languages.putIfAbsent(languageCode, () => newLanguage!);
    _currentLanguage = newLanguage;

    return this;
  }

  Future<TranslationTree?> loadTranslation(Locale locale) async {
    try {
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

  static I18N of(BuildContext context) {
    final provider = (context.dependOnInheritedWidgetOfExactType<I18nNotifier>());
    assert(provider != null, "No I18nNotifier found in context");

    final notifier = provider!.notifier;
    assert(notifier != null, "No I18N found in context");

    return notifier!;
  }
}

class I18nNotifier extends InheritedNotifier<I18N> {
  const I18nNotifier({super.key, super.notifier, required super.child});

  @override
  bool updateShouldNotify(I18nNotifier oldWidget) {
    return oldWidget.notifier?.locale != notifier?.locale;
  }
}
