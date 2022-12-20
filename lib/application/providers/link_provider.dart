import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

class LinkNotifier extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> codeFormKey = GlobalKey<FormState>();

  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  List<TextEditingController> controllers = List.generate(4, (index) => TextEditingController());

  void tokenChanged(int id, String value) {
    if (value.length > 2) {
      value.characters.take(4).toList().forEachIndexed((index, element) {
        controllers[index].text = element;
      });
      return;
    }

    if (value.isEmpty) {
      if (id == 0) return;

      focusNodes[id].unfocus();
      focusNodes[id - 1].requestFocus();
      return;
    }

    final code = value.characters.last;

    controllers[id].text = code;

    if (id != 3) {
      focusNodes[id].unfocus();
      focusNodes[id + 1].requestFocus();
    } else {
      focusNodes[id].unfocus();
    }
  }

  bool? validateCode() {
    final code = controllers.map((e) => e.text).join();
    if (code.length == 4 && (codeFormKey.currentState?.validate() ?? false)) {
      //TODO: Validate code
      return code == '1234';
    }

    return null;
  }

  void reset() {
    focusNodes = List.generate(4, (index) => FocusNode());
    controllers = List.generate(4, (index) => TextEditingController());

    formKey.currentState?.reset();
    codeFormKey.currentState?.reset();
    notifyListeners();
  }
}

final linkProvider = ChangeNotifierProvider<LinkNotifier>((ref) {
  return LinkNotifier();
});
