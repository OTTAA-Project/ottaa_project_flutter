import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/application/language/translation_tree.dart';
import 'package:universal_io/io.dart';

const Map<String, Locale> supportedLocales = {
  "es_AR": Locale("es", "AR"),
  "en_US": Locale("en", "US"),
  "it_IT": Locale("it", "IT"),
  "pt_BR": Locale("pt", "BR"),
  "ca_ES": Locale("ca", "ES"),
  "es_CL": Locale("es", "CL"),
  "es_CO": Locale("es", "CO"),
  "es_ES": Locale("es", "ES"),
  "ur_PK": Locale("ur", "PK"),
};

@Singleton()
class I18N extends ChangeNotifier {
  final Map<String, TranslationTree> _languages = {};
  final platformLanguages = {
    "es": const Locale("es", "CO"),
    "en": const Locale("en", "US"),
    "it": const Locale("it", "IT"),
    "pt": const Locale("pt", "BR"),
  };

  late Locale currentLocale;
  TranslationTree? _currentLanguage;

  TranslationTree? get currentLanguage => _currentLanguage;

  @FactoryMethod(preResolve: true)
  static Future<I18N> start() => I18N().init();

  Future<I18N> init() async {
    final List<String> deviceLanguage = Platform.localeName.split('_');

    if (deviceLanguage.length == 2) {
      currentLocale = Locale(deviceLanguage[0], deviceLanguage[1]);
    } else {
      currentLocale = platformLanguages[deviceLanguage[0]] ?? const Locale("es", "CO");
    }

    String languageCode = "${currentLocale.languageCode}_${currentLocale.countryCode}";

    if (!supportedLocales.containsKey(languageCode)) {
      languageCode = platformLanguages[currentLocale.languageCode]?.toString() ?? "es_CO";
    }

    if (_languages.containsKey(languageCode)) {
      _currentLanguage = _languages[languageCode]!;
      return this;
    }

    TranslationTree? newLanguage = await loadTranslation(currentLocale);
    newLanguage ??= await loadTranslation(const Locale("es", "CO"));

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

      //We execute this in a compute function to avoid blocking the UI thread
      final languageJson = await compute(json.decode, languageString) as Map<String, dynamic>;

      final newLanguage = TranslationTree(locale);

      newLanguage.addTranslations(languageJson);

      return newLanguage;
    } catch (e) {
      return null;
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    if (languageCode == 'en_US') {
      final languageString = await rootBundle.loadString("assets/i18n/$languageCode.json");
      final languageJson = json.decode(languageString) as Map<String, dynamic>;
      Locale locale = const Locale('en', 'US');
      final newLanguage = TranslationTree(locale);
      newLanguage.addTranslations(languageJson);
      _languages[locale.toString()] = newLanguage;
      _currentLanguage = _languages[locale.toString()];
      currentLocale = locale;
      notify();
      return;
    }
    var split = languageCode.split("_");
    assert(split.length == 2, "Language code must be in the format: languageCode_countryCode (en_US)");
    Locale locale = Locale(split[0], split[1]);
    await changeLanguageFromLocale(locale);
    notify();
  }

  Future<void> changeLanguageFromLocale(Locale locale) async {
    assert(locale.countryCode != null, "Locale must have a country code");

    if (!supportedLocales.containsKey(locale.toString())) return;
    TranslationTree? newLanguage = _languages[locale.toString()] ?? await loadTranslation(locale);
    if (newLanguage == null) {
      throw Exception("Language not found");
    }
    _languages[locale.toString()] ??= newLanguage;
    _currentLanguage = _languages[locale.toString()];
    currentLocale = locale;
    notify();
  }

  void notify() {
    notifyListeners();
  }

  static I18N of(BuildContext context) => (context.dependOnInheritedWidgetOfExactType<I18nNotifier>())!.notifier!;
}

class I18nNotifier extends InheritedNotifier<I18N> {
  const I18nNotifier({super.key, super.notifier, required super.child});

  @override
  bool updateShouldNotify(I18nNotifier oldWidget) {
    return true;
  }
}
