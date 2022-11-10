import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class SimpleButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final IconData? leading;
  final IconData? trailing;
  final Color? backgroundColor;
  final Color? fontColor;
  final bool width;

  const SimpleButton({
    super.key,
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
    final horizontalSize = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width ? horizontalSize * 0.17 : double.maxFinite,
      height: 40,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: backgroundColor,
          elevation: 0,
          foregroundColor: fontColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leading != null) Icon(leading!, color: fontColor),
            Text(
              text,
              style: TextStyle(
                color: fontColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            if (trailing != null) Icon(trailing!, color: fontColor),
          ],
        ),
      ),
    );
  }
}
