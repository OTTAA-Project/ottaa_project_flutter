import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/scroe_widget.dart';

class ScoreDialouge extends ConsumerWidget {
  const ScoreDialouge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(gameProvider);
    return Center(
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        contentPadding: const EdgeInsets.all(16),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('game.score'.trl),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ScoreWidget(
                number: provider.correctScore.toString(),
                title: 'game.correct'.trl,
              ),
            ),
            ScoreWidget(
              number: provider.incorrectScore.toString(),
              title: 'game.incorrect'.trl,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ScoreWidget(
                number: provider.useTime,
                title: 'game.use_time'.trl,
              ),
            ),
            ScoreWidget(
              number: provider.streak.toString(),
              title: 'game.maximum_streak'.trl,
            ),
          ],
        ),
      ),
    );
  }
}
