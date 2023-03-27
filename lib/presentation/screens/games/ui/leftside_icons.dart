import 'package:flutter/material.dart';

class LeftSideIcons extends StatelessWidget {
  const LeftSideIcons({
    Key? key,
    required this.music,
    required this.score,
  }) : super(key: key);
  final void Function()? music, score;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Positioned(
      bottom: 24,
      left: 24,
      child: Row(
        children: [
          GestureDetector(
            onTap: music,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Icon(
                Icons.volume_up_outlined,
                color: colorScheme.primary,
                size: 24,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: music,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Icon(
                Icons.volume_up_outlined,
                color: colorScheme.primary,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
