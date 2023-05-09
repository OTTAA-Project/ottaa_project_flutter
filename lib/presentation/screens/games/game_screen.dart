import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/ui_widget.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider.select((value) => value.user));
    final provider = ref.read(gameProvider);
    return Scaffold(
      body: UIWidget(
        subtitle: 'game.play'.trl,
        headline: 'profile.hello'.trlf({'name': user!.settings.data.name}),
        uiWidget: const GameScreenUI(),
        backward: () {
          provider.moveBackward();
        },
        forward: () {
          provider.moveForward();
        },
      ),
    );
  }
}

class GameScreenUI extends ConsumerWidget {
  const GameScreenUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(gameProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.6,
      child: PageView.builder(
        controller: provider.mainPageController,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Container(
                  // height: size.height * 0.7,
                  width: size.width * 0.3,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            '${AppImages.kGameSelectPhoto}_$index.png',
                            height: 92,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              'game.game_header_$index'.trl,
                              style: textTheme.displayMedium,
                            ),
                          ),
                          Text(
                            'game.game_sub_$index'.trl,
                            textAlign: TextAlign.center,
                            style: textTheme.displaySmall!
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: SimpleButton(
                          /// niceu emir chan
                          width: false,
                          onTap: () {
                            provider.selectedGame = index;
                            if (index == 3) {
                              // context.push(AppRoutes.chatGPTGame);
                            } else {
                              // context.push(AppRoutes.selectGroupScreen);
                            }
                          },
                          text: 'game.next'.trl,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Wrap(
                children: [
                  Text(
                    '${'game.novel'.trl}  ',
                    style: textTheme.displaySmall!.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  Text(
                    '0 / ${provider.activeGroups}',
                    style: textTheme.displaySmall!.copyWith(color: colorScheme.primary, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
