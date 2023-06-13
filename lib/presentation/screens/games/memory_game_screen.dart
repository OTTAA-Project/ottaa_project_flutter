import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/application/providers/memory_game_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/background_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/header_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/leftside_icons.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/memory_picto_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/speak_button.dart';

class MemoryGameScreen extends ConsumerStatefulWidget {
  const MemoryGameScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MemoryGameState();
}

class _MemoryGameState extends ConsumerState<MemoryGameScreen> {
  late final MemoryGameNotifier __gameNot = ref.read(memoryGameProvider);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      __gameNot.createRandomPictos();
    });
    super.initState();
  }

  @override
  void dispose() {
    __gameNot.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final game = ref.watch(gameProvider);
    final memoryGame = ref.watch(memoryGameProvider);
    final user = ref.read(userProvider.select((value) => value.user!));
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
          const LeftSideIcons(),
          memoryGame.pictos.isNotEmpty
              ? Positioned(
                  left: 0,
                  right: 0,
                  bottom: size.height * 0.03,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: memoryGame.pictos.sublist(0, memoryGame.pictos.length - (game.difficultyLevel + 2)).mapIndexed((pictoId, e) {
                          return MemoryPictoWidget(
                            isSelected: memoryGame.openedPictos.contains(pictoId),
                            isVisible: memoryGame.matchedPictos.contains(pictoId),
                            picto: e,
                            isRight: memoryGame.openedPictos.length == 2 && memoryGame.openedPictos.contains(pictoId) ? memoryGame.rightPictos.contains(pictoId) : null,
                            onTap: () {
                              memoryGame.openPicto(pictoId);
                            },
                            onBuild: (controller) {
                              memoryGame.addAnimationController(controller, pictoId);
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: memoryGame.pictos.sublist(((game.difficultyLevel + 2))).mapIndexed((i, e) {
                          int pictoId = (i + (game.difficultyLevel + 2));

                          return MemoryPictoWidget(
                            picto: e,
                            isRight: memoryGame.openedPictos.length == 2 && memoryGame.openedPictos.contains(pictoId) ? memoryGame.rightPictos.contains(pictoId) : null,
                            isVisible: memoryGame.matchedPictos.contains(pictoId),
                            isSelected: memoryGame.openedPictos.contains(pictoId),
                            onTap: () {
                              memoryGame.openPicto(pictoId);
                            },
                            onBuild: (controller) {
                              memoryGame.addAnimationController(controller, pictoId);
                            },
                          );
                        }).toList(),
                      )
                    ],
                  ),
                )
              : Positioned(
                  left: 0,
                  right: 0,
                  bottom: size.height * 0.03,
                  child: CircularProgressIndicator(
                    color: colorScheme.primary,
                  ),
                ),
        ],
      ),
    );
  }
}
