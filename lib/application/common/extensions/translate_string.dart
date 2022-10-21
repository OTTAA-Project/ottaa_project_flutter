import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/service/locator.dart';

extension TranslateString on String {
  String get trl {
    return locator.get<I18N>().currentLanguage.translations[this] ?? this;
  }
}
