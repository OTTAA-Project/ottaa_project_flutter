import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class StepButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final IconData? leading;
  final IconData? trailing;
  final Color? backgroundColor;
  final Color? fontColor;
  final bool? width;

  const StepButton({
    required this.onTap,
    required this.text,
    this.leading,
    this.trailing,
    this.backgroundColor = kOTTAAOrange,
    this.fontColor = Colors.white,
    this.width = true,
  });

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    final horizontalSize = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        width: width! ? horizontalSize * 0.17 : double.maxFinite,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (this.leading != null)
              Icon(this.leading!, color: this.fontColor),
            Text(
              this.text,
              style: TextStyle(
                color: this.fontColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
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
