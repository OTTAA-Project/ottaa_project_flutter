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
    required this.onTap,
    required this.text,
    this.leading,
    this.trailing,
    this.backgroundColor = kOTTAOrange,
    this.fontColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        width: 150,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (this.leading != null)
              Icon(this.leading!, color: this.fontColor),
            AutoSizeText(this.text,
                style: TextStyle(
                    color: this.fontColor, fontWeight: FontWeight.bold)),
            if (this.trailing != null)
              Icon(this.trailing!, color: this.fontColor),
          ],
        ),
        decoration: BoxDecoration(
            color: this.backgroundColor,
            borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
