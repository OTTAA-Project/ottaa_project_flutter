import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
    required this.onTap,
    required this.text,
    required this.icon,
    this.divider = true,
  }) : super(key: key);

  final String? icon;
  final String text;
  final void Function()? onTap;
  final bool divider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (icon != null)
                Image.asset(
                  icon!,
                  height: 24,
                  width: 24,
                ),
              const SizedBox(
                width: 16,
              ),
              Text(
                text,
              ),
            ],
          ),
          if (divider) ...[
            const SizedBox(
              height: 12,
            ),
            const Divider(
              color: Colors.black,
            ),
          ],
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
