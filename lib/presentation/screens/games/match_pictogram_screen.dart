import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/application/providers/match_pictogram_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/background_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/header_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/leftside_icons.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/match_pictogram_picto_widget.dart';

class MatchPictogramScreen extends ConsumerWidget {
  const MatchPictogramScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(gameProvider);
    final mpProvider = ref.watch(matchPictogramProvider);
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        const BackGroundWidget(),
        HeaderWidget(
          headline: 'game.game_header_${provider.selectedGame}'.trl,
          subtitle: 'game.game_2_line'.trl,
          onTap: () {
            provider.backgroundMusicPlayer.pause();
            provider.resetScore();
          },
        ),
        Positioned(
          bottom: size.height * 0.2,
          left: 0,
          right: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MPPictoWidget(
                      pict: provider.topPositionsMP[0]!,
                      hideFlag: mpProvider.hideFlags[0],
                      showCorrectOrWrongFlag: mpProvider.show[0],
                      onTap: !mpProvider.show[0]
                          ? () async {
                              showDialog(
                                  barrierColor: Colors.transparent,
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return const SizedBox.shrink();
                                  });
                              await mpProvider.checkAnswerMatchPicto(index: 0, picto: provider.topPositionsMP[0]!);
                              context.pop();
                            }
                          : () {},
                      rightOrWrong: mpProvider.rightOrWrong[0],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: MPPictoWidget(
                        pict: provider.topPositionsMP[1]!,
                        showCorrectOrWrongFlag: mpProvider.show[1],
                        hideFlag: mpProvider.hideFlags[1],
                        onTap: !mpProvider.show[1]
                            ? () async {
                                showDialog(
                                    barrierColor: Colors.transparent,
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return const SizedBox.shrink();
                                    });
                                await mpProvider.checkAnswerMatchPicto(index: 1, picto: provider.topPositionsMP[1]!);
                                context.pop();
                              }
                            : () {},
                        rightOrWrong: mpProvider.rightOrWrong[1],
                      ),
                    ),
                    provider.difficultyLevel >= 1
                        ? Padding(
                            padding: const EdgeInsets.only(right: 24),
                            child: MPPictoWidget(
                              pict: provider.topPositionsMP[2]!,
                              showCorrectOrWrongFlag: mpProvider.show[4],
                              hideFlag: mpProvider.hideFlags[4],
                              onTap: !mpProvider.show[4]
                                  ? () async {
                                      showDialog(
                                          barrierColor: Colors.transparent,
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return const SizedBox.shrink();
                                          });
                                      await mpProvider.checkAnswerMatchPicto(index: 4, picto: provider.topPositionsMP[2]!);
                                      context.pop();
                                    }
                                  : () {},
                              rightOrWrong: mpProvider.rightOrWrong[4],
                            ),
                          )
                        : const SizedBox.shrink(),
                    provider.difficultyLevel == 2
                        ? MPPictoWidget(
                            pict: provider.topPositionsMP[3]!,
                            showCorrectOrWrongFlag: mpProvider.show[6],
                            hideFlag: mpProvider.hideFlags[6],
                            onTap: !mpProvider.show[6]
                                ? () async {
                                    showDialog(
                                        barrierColor: Colors.transparent,
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return const SizedBox.shrink();
                                        });
                                    await mpProvider.checkAnswerMatchPicto(index: 6, picto: provider.topPositionsMP[3]!);
                                    context.pop();
                                  }
                                : () {},
                            rightOrWrong: mpProvider.rightOrWrong[6],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),

              ///bottom
              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MPPictoWidget(
                      pict: provider.bottomPositionsMP[0]!,
                      showCorrectOrWrongFlag: mpProvider.show[2],
                      hideFlag: mpProvider.hideFlags[2],
                      onTap: !mpProvider.show[2]
                          ? () async {
                              showDialog(
                                  barrierColor: Colors.transparent,
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return const SizedBox.shrink();
                                  });
                              await mpProvider.checkAnswerMatchPicto(index: 2, picto: provider.bottomPositionsMP[0]!);
                              context.pop();
                            }
                          : () {},
                      rightOrWrong: mpProvider.rightOrWrong[2],
                      hideWidgetEnabled: true,
                      hideText: provider.bottomPositionsMP[0]!.text,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: MPPictoWidget(
                        pict: provider.bottomPositionsMP[1]!,
                        showCorrectOrWrongFlag: mpProvider.show[3],
                        hideFlag: mpProvider.hideFlags[3],
                        onTap: !mpProvider.show[3]
                            ? () async {
                                showDialog(
                                    barrierColor: Colors.transparent,
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return const SizedBox.shrink();
                                    });
                                await mpProvider.checkAnswerMatchPicto(index: 3, picto: provider.bottomPositionsMP[1]!);
                                context.pop();
                              }
                            : () {},
                        rightOrWrong: mpProvider.rightOrWrong[3],
                        hideWidgetEnabled: true,
                        hideText: provider.bottomPositionsMP[1]!.text,
                      ),
                    ),
                    provider.difficultyLevel >= 1
                        ? Padding(
                            padding: const EdgeInsets.only(right: 24),
                            child: MPPictoWidget(
                              pict: provider.bottomPositionsMP[2]!,
                              showCorrectOrWrongFlag: mpProvider.show[5],
                              hideFlag: mpProvider.hideFlags[5],
                              onTap: !mpProvider.show[5]
                                  ? () async {
                                      showDialog(
                                          barrierColor: Colors.transparent,
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return const SizedBox.shrink();
                                          });
                                      await mpProvider.checkAnswerMatchPicto(index: 5, picto: provider.bottomPositionsMP[2]!);
                                      context.pop();
                                    }
                                  : () {},
                              rightOrWrong: mpProvider.rightOrWrong[5],
                              hideWidgetEnabled: true,
                              hideText: provider.bottomPositionsMP[2]!.text,
                            ),
                          )
                        : const SizedBox.shrink(),
                    provider.difficultyLevel == 2
                        ? MPPictoWidget(
                            pict: provider.bottomPositionsMP[3]!,
                            showCorrectOrWrongFlag: mpProvider.show[7],
                            hideFlag: mpProvider.hideFlags[7],
                            onTap: !mpProvider.show[7]
                                ? () async {
                                    showDialog(
                                        barrierColor: Colors.transparent,
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return const SizedBox.shrink();
                                        });
                                    await mpProvider.checkAnswerMatchPicto(index: 7, picto: provider.bottomPositionsMP[3]!);
                                    context.pop();
                                  }
                                : () {},
                            rightOrWrong: mpProvider.rightOrWrong[7],
                            hideWidgetEnabled: true,
                            hideText: provider.bottomPositionsMP[3]!.text,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
        const LeftSideIcons(),
        Positioned(
          top: size.height * 0.5,
          left: size.width * 0.1,
          child: mpProvider.showResult
              ? mpProvider.trueOrFalse
                  ? Text(
                      'game.yes'.trl,
                      style: textTheme.displayLarge,
                    )
                  : const SizedBox.shrink()
              : const SizedBox.shrink(),
        ),
        Positioned(
          top: size.height * 0.5,
          right: size.width * 0.1,
          child: mpProvider.showResult
              ? !mpProvider.trueOrFalse
                  ? Text(
                      'game.no'.trl,
                      style: textTheme.displayLarge,
                    )
                  : const SizedBox.shrink()
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
