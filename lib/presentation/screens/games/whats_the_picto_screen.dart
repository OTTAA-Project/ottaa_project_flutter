import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/application/providers/whats_the_picto_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/background_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/header_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/leftside_icons.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/pict_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/speak_button.dart';

class WhatsThePictoScreen extends ConsumerWidget {
  const WhatsThePictoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(whatsThePictoProvider);
    final game = ref.read(gameProvider);
    final user = ref.read(userNotifier);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          const BackGroundWidget(),
          HeaderWidget(
            headline: 'game.game_header_${game.selectedGame}'.trl,
            subtitle: 'game.game_1_line'.trl,
            onTap: () {
              game.backgroundMusicPlayer.pause();
              game.resetScore();
              game.gameTimer.cancel();
              if (game.hintsBtn) {
                game.cancelHints();
              }
            },
          ),
          SpeakButton(
            onTap: () async => provider.speakNameWhatsThePicto(),
          ),
          Container(
            height: size.height,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///first
                  ShakeAnimatedWidget(
                    enabled: game.hintsEnabled
                        ? game.correctPictoWTP == 0
                            ? true
                            : false
                        : false,
                    duration: const Duration(milliseconds: 400),
                    shakeAngle: Rotation.deg(z: 4),
                    curve: Curves.linear,
                    child: PictWidget(
                      pict: game.gamePictsWTP[0],
                      show: provider.pictoShowWhatsThePict[0],
                      onTap: () async {
                        await provider.checkAnswerWhatThePicto(index: 0);
                        print('here are');
                        print(game.gamePictsWTP[0].text);
                        print(game.gamePictsWTP[1].text);
                        print(game.gamePictsWTP[2].text);
                        print(game.gamePictsWTP[3].text);
                        print(game.difficultyLevel);
                      },
                      rightOrWrong: game.correctPictoWTP == 0,
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),

                  ///second
                  ShakeAnimatedWidget(
                    enabled: game.hintsEnabled
                        ? game.correctPictoWTP == 1
                            ? true
                            : false
                        : false,
                    duration: const Duration(milliseconds: 400),
                    shakeAngle: Rotation.deg(z: 4),
                    curve: Curves.linear,
                    child: PictWidget(
                      pict: game.gamePictsWTP[1],
                      show: provider.pictoShowWhatsThePict[1],
                      onTap: () async {
                        await provider.checkAnswerWhatThePicto(index: 1);
                      },
                      rightOrWrong: game.correctPictoWTP == 1,
                    ),
                  ),

                  ///third
                  game.difficultyLevel >= 1
                      ? const SizedBox(
                          width: 24,
                        )
                      : const SizedBox.shrink(),
                  game.difficultyLevel >= 1
                      ? ShakeAnimatedWidget(
                          enabled: game.hintsEnabled
                              ? game.correctPictoWTP == 2
                                  ? true
                                  : false
                              : false,
                          duration: const Duration(milliseconds: 400),
                          shakeAngle: Rotation.deg(z: 4),
                          curve: Curves.linear,
                          child: PictWidget(
                            pict: game.gamePictsWTP[2],
                            show: provider.pictoShowWhatsThePict[2],
                            onTap: () async {
                              await provider.checkAnswerWhatThePicto(index: 2);
                            },
                            rightOrWrong: game.correctPictoWTP == 2,
                          ),
                        )
                      : const SizedBox.shrink(),

                  ///forth
                  game.difficultyLevel >= 2
                      ? const SizedBox(
                          width: 24,
                        )
                      : const SizedBox.shrink(),
                  game.difficultyLevel >= 2
                      ? ShakeAnimatedWidget(
                          enabled: game.hintsEnabled
                              ? game.correctPictoWTP == 3
                                  ? true
                                  : false
                              : false,
                          duration: const Duration(milliseconds: 400),
                          shakeAngle: Rotation.deg(z: 4),
                          curve: Curves.linear,
                          child: PictWidget(
                            pict: game.gamePictsWTP[3],
                            show: provider.pictoShowWhatsThePict[3],
                            onTap: () async {
                              await provider.checkAnswerWhatThePicto(index: 3);
                            },
                            rightOrWrong: game.correctPictoWTP == 3,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          provider.showText
              ? Positioned(
                  top: size.height * 0.8,
                  left: size.width * 0.46,
                  child: Text(
                    provider.selectedPicto == game.correctPictoWTP ? 'game.yes'.trl : 'game.no'.trl,
                    style: textTheme.headline1,
                  ),
                )
              : const SizedBox.shrink(),
          const LeftSideIcons(
            hints: true,
          ),
        ],
      ),
    );
  }
}
