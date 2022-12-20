class TranslationTreeNode {
  Map<String, TranslationTreeNode>? children;
  String? translation;

  TranslationTreeNode({
    this.translation,
    this.children,
  });
}
