import 'package:flutter/material.dart';

class ProfileUserWidget extends StatelessWidget {
  const ProfileUserWidget({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              title,
              style: textTheme.displaySmall,
            ),
          ),
          Divider(
            height: 1,
            color: colorScheme.background,
          ),
        ],
      ),
    );
  }
}
