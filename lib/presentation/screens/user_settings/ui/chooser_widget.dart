import 'package:flutter/material.dart';
import 'package:ottaa_ui_kit/theme.dart';

class ChooserWidget extends StatelessWidget {
  const ChooserWidget({
    Key? key,
    required this.selected,
    required this.onTap,
    required this.title,
  }) : super(key: key);
  final String title;
  final bool selected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? colorScheme.primary : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: selected
              ? textTheme.caption!.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                )
              : textTheme.caption!.copyWith(
                  color: kDarkenGrayColor,
                ),
        ),
      ),
    );
  }
}
