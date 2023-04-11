import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';

class TipsWidget extends StatelessWidget {
  const TipsWidget({
    Key? key,
    required this.subtitle,
    required this.title,
  }) : super(key: key);
  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                AppImages.kIconoOttaa,
                height: 12,
                width: 12,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: textTheme.headline2,
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          subtitle,
          maxLines: 3,
          style: textTheme.headline4,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Divider(
            color: colorScheme.onBackground,
          ),
        ),
      ],
    );
  }
}
