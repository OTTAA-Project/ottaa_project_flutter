import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
    required this.onTap,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final String icon, text;
  final void Function()? onTap;

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
              Image.asset(
                icon,
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
          const SizedBox(
            height: 12,
          ),
          const Divider(
            color: Colors.black,
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
