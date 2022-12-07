import 'dart:ui';

import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:test/test.dart';

void main() {
  var language = I18N(const Locale('en', 'US'));
  group('I18N Coverage', () {
    test('set Language', () async {
      language.changeLanguage('es_AR');

      expect(language.locale.languageCode, 'es');
    });
    test('set Language by Locale', () {
      language.changeLanguageFromLocale(const Locale('en', 'US'));
      expect(language.locale.languageCode, 'en');
    });
    test('null testing', () async {
      var result = await language.loadTranslation(const Locale('es', 'US'));
      expect(result, null);
    });
    test('init language', () async {
      language = I18N(const Locale('it', 'IT'));
      var init = await language.init();
      expect(init.locale.languageCode, 'it');
    });
    test('translation to english', () {});
  });
}
