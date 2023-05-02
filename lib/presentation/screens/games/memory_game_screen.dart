import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/application/providers/memory_game_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/background_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/header_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/leftside_icons.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/memory_picto_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/pict_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/speak_button.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/ui_widget.dart';

class MemoryGameScreen extends ConsumerStatefulWidget {
  const MemoryGameScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MemoryGameState();
}

class _MemoryGameState extends ConsumerState<MemoryGameScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(memoryGameProvider).createRandomPictos();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final game = ref.watch(gameProvider);
    final memoryGame = ref.watch(memoryGameProvider);
    final user = ref.read(userNotifier);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    print(memoryGame.pictos.length);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(
        children: [
          const BackGroundWidget(),
          HeaderWidget(
            headline: 'game.game_header_${game.selectedGame}'.trl,
            subtitle: 'game.game_2_line'.trl,
            onTap: () {
              game.backgroundMusicPlayer.pause();
              game.gameTimer.cancel();
              if (game.hintsBtn) {
                game.cancelHints();
              }
            },
          ),
          SpeakButton(
            onTap: () async => {},
          ),
          Center(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: game.difficultyLevel + 2,
                childAspectRatio: 1,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                mainAxisExtent: 140,
              ),
              children: memoryGame.pictos.mapIndexed((i, e) {
                return MemoryPictoWidget(
                  picto: e,
                  show: memoryGame.openedPictos.contains(i),
                  onTap: (controller) {
                     memoryGame.openPicto(i, controller);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
