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
    print(mpProvider.pick1);
    print(mpProvider.show[0]);
    return Scaffold(
      body: Stack(
        children: [
          const BackGroundWidget(),
          HeaderWidget(
            headline: 'game.game_header_${provider.selectedGame}'.trl,
            subtitle: 'game.game_2_line'.trl,
            onTap: () {
              provider.backgroundMusicPlayer.pause();
              provider.gameTimer.cancel();
            },
          ),
          Positioned(
            bottom: size.height * 0.1,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        MPPictoWidget(
                          pict: provider.topPositionsMP[0]!,
                          show: mpProvider.show[0],
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
                                  // print(mpProvider.pick1);
                                  // print(mpProvider.show[0]);
                                }
                              : () {},
                          rightOrWrong: provider.matchPictoTop[0],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: MPPictoWidget(
                            pict: provider.topPositionsMP[1]!,
                            show: mpProvider.show[1],
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
                            rightOrWrong: provider.matchPictoTop[1],
                          ),
                        ),
                        provider.difficultyLevel == 1
                            ? Padding(
                                padding: const EdgeInsets.only(right: 24),
                                child: MPPictoWidget(
                                  pict: provider.topPositionsMP[2]!,
                                  show: mpProvider.show[4],
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
                                  rightOrWrong: provider.matchPictoTop[3],
                                ),
                              )
                            : const SizedBox.shrink(),
                        provider.difficultyLevel == 2
                            ? MPPictoWidget(
                                pict: provider.topPositionsMP[3]!,
                                show: mpProvider.show[5],
                                onTap: !mpProvider.show[5]
                                    ? () async {
                                        showDialog(
                                            barrierColor: Colors.transparent,
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return const SizedBox.shrink();
                                            });
                                        await mpProvider.checkAnswerMatchPicto(index: 5, picto: provider.topPositionsMP[3]!);
                                        context.pop();
                                      }
                                    : () {},
                                rightOrWrong: provider.matchPictoTop[3],
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),

                    ///bottom
                    Row(
                      children: [
                        MPPictoWidget(
                          pict: provider.bottomPositionsMP[0]!,
                          show: mpProvider.show[2],
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
                          rightOrWrong: provider.matchPictoBottom[0],
                          hide: true,
                          hideText: provider.bottomPositionsMP[0]!.text,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: MPPictoWidget(
                            pict: provider.bottomPositionsMP[1]!,
                            show: mpProvider.show[3],
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
                            rightOrWrong: provider.matchPictoBottom[1],
                            hide: true,
                            hideText: provider.bottomPositionsMP[1]!.text,
                          ),
                        ),
                        provider.difficultyLevel == 1
                            ? Padding(
                                padding: const EdgeInsets.only(right: 24),
                                child: MPPictoWidget(
                                  pict: provider.bottomPositionsMP[2]!,
                                  show: mpProvider.show[6],
                                  onTap: !mpProvider.show[6]
                                      ? () async {
                                          showDialog(
                                              barrierColor: Colors.transparent,
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return const SizedBox.shrink();
                                              });
                                          await mpProvider.checkAnswerMatchPicto(index: 6, picto: provider.bottomPositionsMP[2]!);
                                          context.pop();
                                        }
                                      : () {},
                                  rightOrWrong: provider.matchPictoBottom[2],
                                  hide: true,
                                  hideText: provider.bottomPositionsMP[2]!.text,
                                ),
                              )
                            : const SizedBox.shrink(),
                        provider.difficultyLevel == 2
                            ? MPPictoWidget(
                                pict: provider.bottomPositionsMP[3]!,
                                show: mpProvider.show[7],
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
                                rightOrWrong: provider.matchPictoBottom[3],
                                hide: true,
                                hideText: provider.bottomPositionsMP[3]!.text,
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ],
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
                        style: textTheme.headline1,
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
                        style: textTheme.headline1,
                      )
                    : const SizedBox.shrink()
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
