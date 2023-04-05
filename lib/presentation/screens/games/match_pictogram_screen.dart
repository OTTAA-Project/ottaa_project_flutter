import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/background_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/header_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/leftside_icons.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/pict_widget.dart';

class MatchPictogramScreen extends ConsumerWidget {
  const MatchPictogramScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(gameProvider);
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        children: [
          const BackGroundWidget(),
          HeaderWidget(
            headline: 'game.game_header_${provider.selectedGame}'.trl,
            subtitle: 'game.game_2_line'.trl,
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
                        PictWidget(
                          pict: provider.topPositions[0]!,
                          show: provider.matchPictoTop[0],
                          onTap: () async {
                            showDialog(
                                barrierColor: Colors.transparent,
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return const SizedBox.shrink();
                                });
                            await provider.checkAnswerWhatThePicto(index: 0);
                            context.pop();
                          },
                          rightOrWrong: provider.correctPicto == 0,
                        ),
                        PictWidget(
                          pict: provider.topPositions[1]!,
                          show: provider.matchPictoTop[1],
                          onTap: () async {
                            showDialog(
                                barrierColor: Colors.transparent,
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return const SizedBox.shrink();
                                });
                            await provider.checkAnswerWhatThePicto(index: 1);
                            context.pop();
                          },
                          rightOrWrong: provider.correctPicto == 1,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        PictWidget(
                          pict: provider.bottomPositions[0]!,
                          show: provider.matchPictoBottom[0],
                          onTap: () async {
                            showDialog(
                                barrierColor: Colors.transparent,
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return const SizedBox.shrink();
                                });
                            await provider.checkAnswerWhatThePicto(index: 0);
                            context.pop();
                          },
                          rightOrWrong: provider.correctPicto == 0,
                          hide: true,
                          hideText: provider.bottomPositions[0]!.text,
                        ),
                        PictWidget(
                          pict: provider.bottomPositions[1]!,
                          show: provider.matchPictoBottom[1],
                          onTap: () async {
                            // showDialog(
                            //     barrierColor: Colors.transparent,
                            //     barrierDismissible: false,
                            //     context: context,
                            //     builder: (context) {
                            //       return const SizedBox.shrink();
                            //     });
                            // context.pop();
                            await provider.createRandomForGame();
                            print('hello');
                          },
                          rightOrWrong: provider.correctPicto == 0,
                          hide: true,
                          hideText: provider.bottomPositions[1]!.text,
                        ),
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
            left: size.width * 0.2,
            child: provider.showText
                ? provider.selectedPicto == provider.correctPicto
                    ? Text(
                        'game.yes'.trl,
                        style: textTheme.headline1,
                      )
                    : const SizedBox.shrink()
                : const SizedBox.shrink(),
          ),
          Positioned(
            top: size.height * 0.5,
            right: size.width * 0.2,
            child: provider.showText
                ? provider.selectedPicto != provider.correctPicto
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
