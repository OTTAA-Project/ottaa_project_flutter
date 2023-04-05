import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/score_dialouge.dart';

class LeftSideIcons extends ConsumerWidget {
  const LeftSideIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(gameProvider);
    final colorScheme = Theme.of(context).colorScheme;
    return Positioned(
      bottom: 24,
      left: 24,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const ScoreDialouge();
                },
              );
            },
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
            onTap: () async => provider.changeMusic(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Icon(
                  provider.mute ? Icons.volume_mute_outlined : Icons.volume_up_outlined,
                  color: colorScheme.primary,
                  size: 24,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              //todo: hints here
            },
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
