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
import 'package:ottaa_project_flutter/presentation/screens/games/ui/speak_button.dart';
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
          SpeakButton(
            onTap: () async => await provider.speak(),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PictWidget(
                  pict: provider.gamePicts[0],
                  show: provider.pictoShowWhatsThePict[0],
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
                  show: provider.pictoShowWhatsThePict[1],
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
          const LeftSideIcons(),
        ],
      ),
    );
  }
}
