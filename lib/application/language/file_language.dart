import 'package:flutter/rendering.dart';
import 'package:ottaa_project_flutter/core/abstracts/language.dart';

class FileLanguage implements Language {
  const FileLanguage({required this.languageCode, required this.translations});

  @override
  final String languageCode;

  @override
  final Map<String, String> translations;
}
