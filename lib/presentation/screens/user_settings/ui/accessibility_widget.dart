import 'package:flutter/material.dart';

class AccessibilityWidget extends StatelessWidget {
  const AccessibilityWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.onTap,
    required this.selected,
  }) : super(key: key);
  final String image, title;
  final void Function()? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            height: 94,
            width: 94,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: selected ? colorScheme.primary : Colors.white,
                width: 3,
              ),
            ),
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            title,
            style: textTheme.headline3,
          ),
        ],
      ),
    );
  }
}
