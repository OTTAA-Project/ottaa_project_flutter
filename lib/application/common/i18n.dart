import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/application/language/translation_tree.dart';
import 'package:universal_io/io.dart';

@Singleton()
class I18N extends ChangeNotifier {
  final Map<String, TranslationTree> _languages = {};
  final platformLanguages = {
    "es": const Locale("es", "AR"),
    "en": const Locale("en", "US"),
    "it": const Locale("it", "IT"),
    "pt": const Locale("pt", "BR"),
  };

  late Locale locale;
  TranslationTree? _currentLanguage;

  @FactoryMethod(preResolve: true)
  static Future<I18N> start() => I18N().init();

  Future<I18N> init() async {
    final List<String> deviceLanguage = Platform.localeName.split('_');

    if (deviceLanguage.length == 2) {
      locale = Locale(deviceLanguage[0], deviceLanguage[1]);
    } else {
      locale = platformLanguages[deviceLanguage[0]] ?? const Locale("es", "AR");
    }

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
    changeLanguageFromLocale(locale);
  }

  Future<void> changeLanguageFromLocale(Locale locale) async {
    assert(locale.countryCode != null, "Locale must have a country code");
    TranslationTree? newLanguage = _languages[locale.toString()] ?? await loadTranslation(locale);
    if (newLanguage == null) {
      throw Exception("Language not found");
    }
    _languages[locale.toString()] ??= newLanguage;
    _currentLanguage = _languages[locale.toString()];
    this.locale = locale;

    notify();
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
