class TranslationTreeNode {
  final Map<String, TranslationTreeNode> children;
  String? translation;

  TranslationTreeNode({
    this.children = const {},
    this.translation,
  });
}
