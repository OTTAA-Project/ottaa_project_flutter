import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.headline,
    required this.subtitle,
    this.bold = true,
  }) : super(key: key);
  final String headline, subtitle;
  final bool? bold;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Positioned(
      top: 24,
      left: 24,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.close_rounded,
                  color: colorScheme.primary,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headline,
                style: textTheme.headline3,
              ),
              Text(
                subtitle,
                style: bold!
                    ? textTheme.headline3!.copyWith(
                        fontWeight: FontWeight.w600,
                      )
                    : textTheme.headline3!.copyWith(
                        color: colorScheme.primary,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}