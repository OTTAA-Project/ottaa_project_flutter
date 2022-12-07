import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/locator.dart';

extension TranslateString on String {
  String get trl {
    final currentTree = locator.get<I18N>().currentLanguage;

    if (currentTree == null) {
      return this;
    }

    return currentTree.translate(this) ?? this;
  }

  String trlf(Map<String, dynamic> args) {
    final translation = trl;

    if (args.isEmpty) {
      return translation;
    }

    String result = translation;

    args.forEach((key, value) {
      result = result.replaceAll("{$key}", value.toString());
    });

    return result;

  }
}
