import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/background_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/header_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/leftside_icons.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/pict_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/score_dialouge.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/speak_button.dart';
import 'package:picto_widget/picto_widget.dart';

class MatchPictogramScreen extends ConsumerWidget {
  const MatchPictogramScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(gameProvider);
    final size = MediaQuery.of(context).size;
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
                          pict: provider.gamePicts[0],
                          show: provider.pictoShow[0],
                          onTap: () async {
                            showDialog(
                                barrierColor: Colors.transparent,
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return SizedBox.shrink();
                                });
                            await provider.checkAnswerWhatThePicto(index: 0);
                            context.pop();
                          },
                          rightOrWrong: provider.correctPicto == 0,
                        ),
                        Container(
                          color: Colors.pink,
                          child: PictWidget(
                            pict: provider.gamePicts[1],
                            show: provider.pictoShow[1],
                            onTap: () async {
                              showDialog(
                                  barrierColor: Colors.transparent,
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return SizedBox.shrink();
                                  });
                              await provider.checkAnswerWhatThePicto(index: 1);
                              context.pop();
                            },
                            rightOrWrong: provider.correctPicto == 1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        PictWidget(
                          pict: provider.gamePicts[0],
                          show: provider.pictoShow[0],
                          onTap: () async {
                            showDialog(
                                barrierColor: Colors.transparent,
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return SizedBox.shrink();
                                });
                            await provider.checkAnswerWhatThePicto(index: 0);
                            context.pop();
                          },
                          rightOrWrong: provider.correctPicto == 0,
                          hide: true,
                          hideText: 'text',
                        ),
                        PictWidget(
                          pict: provider.gamePicts[0],
                          show: provider.pictoShow[0],
                          onTap: () async {
                            showDialog(
                                barrierColor: Colors.transparent,
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return SizedBox.shrink();
                                });
                            await provider.checkAnswerWhatThePicto(index: 0);
                            context.pop();
                          },
                          rightOrWrong: provider.correctPicto == 0,
                          hide: true,
                          hideText: 'text',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          LeftSideIcons(
            hint: () {},
            music: () {
              provider.mute = !provider.mute;
              provider.notifyListeners();
            },
            score: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const ScoreDialouge();
                },
              );
            },
            mute: provider.mute,
          ),
        ],
      ),
    );
  }
}
