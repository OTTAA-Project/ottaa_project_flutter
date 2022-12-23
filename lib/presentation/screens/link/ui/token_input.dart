import 'package:flutter/material.dart';

class TokenInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? node;
  final int tokenId;
  final void Function(int id, String value)? onChanged;

  const TokenInput({super.key, required this.tokenId, required this.controller, this.node, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: node,
      style: const TextStyle(
        fontSize: 40,
      ),
      onChanged: (value) => onChanged?.call(tokenId, value),
      textAlign: TextAlign.center,
    );
  }
}
