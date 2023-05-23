import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    Key? key,
    required this.title,
    required this.image,
    required this.selected,
    required this.onTap,
  }) : super(key: key);
  final String title, image;
  final bool selected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.displaySmall,
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: selected ? colorScheme.primary : colorScheme.background,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              image,
              height: 100,
              width: 150,
            ),
          ),
        ],
      ),
    );
  }
}
