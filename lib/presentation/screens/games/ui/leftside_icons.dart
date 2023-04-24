import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';

class LeftSideIcons extends StatelessWidget {
  const LeftSideIcons({
    Key? key,
    required this.music,
    required this.score,
    required this.mute,
    required this.hint,
  }) : super(key: key);
  final void Function()? music, score,hint;
  final bool mute;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Positioned(
      bottom: 24,
      left: 24,
      child: Row(
        children: [
          GestureDetector(
            onTap: score,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Image.asset(
                AppImages.kGamesTrophy,
                height: 24,
              ),
            ),
          ),
          GestureDetector(
            onTap: music,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Icon(
                  mute ? Icons.volume_mute_outlined : Icons.volume_up_outlined,
                  color: colorScheme.primary,
                  size: 24,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: hint,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                AppImages.kGamesMark,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
