import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({
    Key? key,
    required this.number,
    required this.title,
  }) : super(key: key);
  final String title, number;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textTheme.headline3!.copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            number,
            style: textTheme.headline3!.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
