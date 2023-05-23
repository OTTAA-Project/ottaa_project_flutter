import 'package:flutter/material.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({
    Key? key,
    required this.onChanged,
    required this.title,
    required this.value,
  }) : super(key: key);
  final dynamic Function(bool)? onChanged;
  final String title;
  final bool value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.displaySmall,
        ),
        OTTAASwitch(value: value, onChanged: onChanged),
      ],
    );
  }
}
