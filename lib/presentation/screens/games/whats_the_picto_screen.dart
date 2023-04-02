import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/background_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/header_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/leftside_icons.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/pict_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/score_dialouge.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/scroe_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class WhatsThePictoScreen extends ConsumerWidget {
  const WhatsThePictoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(gameProvider);
    final user = ref.read(userNotifier);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //todo: add the hinst right next to the mute.
      body: Stack(
        children: [
          const BackGroundWidget(),
          HeaderWidget(
            headline: 'game.game_header_${provider.selectedGame}'.trl,
            subtitle: 'game.game_1_line'.trl,
          ),
          Positioned(
            right: 48,
            top: 24,
            child: SizedBox(
              width: 84,
              height: 80,
              child: BaseButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(colorScheme.primary),
                  overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                    ),
                  ),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                  elevation: MaterialStateProperty.all(0),
                ),
                onPressed: () async => await provider.speak(),
                child: Image.asset(
                  AppImages.kOttaaMinimalist,
                  color: Colors.white,
                  width: 59,
                  height: 59,
                ),
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                const SizedBox(
                  width: 24,
                ),
                PictWidget(
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
              ],
            ),
          ),
          provider.showText
              ? Positioned(
                  top: size.height * 0.8,
                  left: size.width * 0.46,
                  child: Text(
                    provider.selectedPicto == provider.correctPicto ? 'game.yes'.trl : 'game.no'.trl,
                    style: textTheme.headline1,
                  ),
                )
              : const SizedBox.shrink(),
          LeftSideIcons(
            hint: (){

            },
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
