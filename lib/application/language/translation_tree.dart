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
      currentNode.children.putIfAbsent(section, () => TranslationTreeNode());
      currentNode = currentNode.children[section]!;
    }

    currentNode.translation = translation;
  }

  String? translate(String key) {
    final sections = key.split(".");
    TranslationTreeNode currentNode = root;

    for (final section in sections) {
      if (!currentNode.children.containsKey(section)) {
        return null;
      }

      currentNode = currentNode.children[section]!;
    }

    return currentNode.translation;
  }
}
