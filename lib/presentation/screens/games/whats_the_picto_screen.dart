import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/background_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/header_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/leftside_icons.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/pict_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';
import 'package:picto_widget/picto_widget.dart';

class WhatsThePictoScreen extends ConsumerWidget {
  const WhatsThePictoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(gameProvider);
    final user = ref.read(userNotifier);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
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
                  backgroundColor:
                      MaterialStateProperty.all(colorScheme.primary),
                  overlayColor:
                      MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                    ),
                  ),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                  elevation: MaterialStateProperty.all(0),
                ),
                onPressed: () async {
                  print('hello');
                },
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
                  show: true,
                  onTap: () {},
                  rightOrWrong: true,
                ),
                const SizedBox(
                  width: 24,
                ),
                PictWidget(
                  pict: provider.gamePicts[1],
                  show: true,
                  onTap: () {},
                  rightOrWrong: true,
                ),
              ],
            ),
          ),
          LeftSideIcons(
            music: () {},
            score: () {},
            mute: true,
          ),
        ],
      ),
    );
  }
}
