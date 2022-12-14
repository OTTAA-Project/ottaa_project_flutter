import 'package:flutter/material.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    //todo: add the theme here
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          color: colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colorScheme.onBackground,
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: textTheme.headline3,
            ),
            Icon(
              Icons.keyboard_arrow_down_sharp,
            ),
          ],
        ),
      ),
    );
  }
}
