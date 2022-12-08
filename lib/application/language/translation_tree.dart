import 'dart:ui';

import 'package:ottaa_project_flutter/application/language/translation_tree_node.dart';

class TranslationTree {
  final Locale locale;
  final TranslationTreeNode root = TranslationTreeNode();

  TranslationTree(this.locale);

  void addTranslation(String key, String translation) {
    final sections = key.split(".");
    TranslationTreeNode currentNode = root;

    for (final section in sections) {
      currentNode.children ??= {};
      currentNode.children!.putIfAbsent(section, () => TranslationTreeNode());
      currentNode = currentNode.children![section]!;
    }

    currentNode.translation = translation;
  }

  String buildKeyFromMap(Map<String, dynamic> map, String key) {
    String newKey = "";
    map.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        newKey = buildKeyFromMap(value, key);
      } else {
        newKey = key;
      }
    });
    return "$key.$newKey";
  }

  void addTranslations(Map<String, dynamic> translations) {
    void processMap(Map<String, dynamic> translations, String? parentKey) {
      translations.forEach((key, value) {
        final String fullKey = parentKey != null ? "$parentKey.$key" : key;
        if (value is String) {
          addTranslation(fullKey, value);
        } else {
          processMap(value, fullKey);
        }
      });
    }

    processMap(translations, null);
  }

  String? translate(String key) {
    final sections = key.split(".");
    TranslationTreeNode currentNode = root;

    for (final section in sections) {
      if (!currentNode.children!.containsKey(section)) {
        return null;
      }

      currentNode = currentNode.children![section]!;
    }

    return currentNode.translation;
  }
}
