import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';

class LeftSideIcons extends StatelessWidget {
  const LeftSideIcons({
    Key? key,
    required this.music,
    required this.score,
    required this.mute,
  }) : super(key: key);
  final void Function()? music, score;
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
            onTap: music,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Image.asset(
                AppImages.kGamesTrophy,
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
                mute ? Icons.volume_mute_outlined : Icons.volume_up_outlined,
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
