import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class StepButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final IconData? leading;
  final IconData? trailing;
  final Color? backgroundColor;
  final Color? fontColor;

  const StepButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.leading,
    this.trailing,
    this.backgroundColor = kOTTAAOrange,
    this.fontColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 40,
        decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leading != null) Icon(leading!, color: fontColor),
            AutoSizeText(text, style: TextStyle(color: fontColor, fontWeight: FontWeight.bold)),
            if (trailing != null) Icon(trailing!, color: fontColor),
          ],
        ),
      ),
    );
  }
}
