import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';

class NewSimpleButton extends StatelessWidget {
  const NewSimpleButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.active = false,
  }) : super(key: key);
  final String text;
  final bool active;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      //todo: add the colors scheme from the theme here and some other stuff
      child: Container(
        height: 48,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: active ? kOTTAAOrangeNew : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
