import 'dart:ui';

import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:test/test.dart';

void main(){
  var language = I18N("en");
  group('I18N Coverage', (){
    test('set Language', (){
      language.changeLanguage('es');
      expect(language.currentLanguage.languageCode, 'es');
    });
    test('set Language by Locale', (){
      language.changeLanguageFromLocale(Locale('en'));
      expect(language.languageCode, 'en');
    });
    test('null testing', ()async{
      var result = await Future.value(language.loadLanguage('cl'));
      expect(result,null);
    });
    test('init language', () async {
      language = I18N('fr');
      var init = await language.init();
      expect(init.languageCode,'fr');
    });
    test('translation to english', (){

    });


  });
}