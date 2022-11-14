import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';

class OTTAATextInput extends StatefulWidget {
  final String? hintText;

  final String? labelText;

  final TextEditingController? controller;

  final bool isPassword;

  final void Function(String)? onChanged;

  final String? Function(String?)? validator;

  final void Function()? onTap;

  final bool isReadOnly;

  final bool? enabled;

  final TextInputType? keyboardType;

  const OTTAATextInput({super.key, this.hintText, this.labelText, this.controller, this.isPassword = false, this.onChanged, this.validator, this.onTap, this.isReadOnly = false, this.enabled = true, this.keyboardType});

  @override
  State<OTTAATextInput> createState() => _OTTAATextInputState();
}

class _OTTAATextInputState extends State<OTTAATextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      cursorColor: kOTTAAOrangeNew,
      validator: widget.validator,
      readOnly: widget.isReadOnly,
      enabled: widget.enabled,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        focusColor: kOTTAAOrangeNew,
        fillColor: kOTTAAOrangeNew,
        hintText: widget.hintText,
        labelText: widget.labelText,
        isDense: true,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kOTTAAOrangeNew),
        ),
      ),
    );
  }
}
