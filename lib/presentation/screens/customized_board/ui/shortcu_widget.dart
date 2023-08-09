import 'package:flutter/material.dart';
import 'package:ottaa_ui_kit/theme.dart';

class ShortcutWidget extends StatelessWidget {
  const ShortcutWidget({
    Key? key,
    required this.heading,
    required this.image,
    required this.onTap,
    required this.selected,
    required this.image2,
  }) : super(key: key);

  final String image, image2, heading;
  final void Function()? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(8),
                border: selected
                    ? Border.all(color: colorScheme.primary, width: 1)
                    : Border.all(),
              ),
              padding: const EdgeInsets.all(18),
              child: Image.asset(
                selected ? image2 : image,
                height: 44,
                width: 44,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              heading,
              style: selected
                  ? textTheme.headline3
                  : textTheme.headline3!.copyWith(color: kDarkenGrayColor),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
