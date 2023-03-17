import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/ui_widget.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userNotifier);
    return Scaffold(
      body: UIWidget(
        subtitle: 'game.main.play'.trl,
        headline: 'profile.hello'.trlf({'name': user!.settings.data.name}),
        uiWidget: const GameScreenUI(),
        show: true,
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
    return SizedBox(
      width: 260,
      child: PageView.builder(
        controller: provider.mainPageController,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Container(
                  height: 280,
                  width: 240,
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
                            AppImages.kGameSelectPhoto,
                            height: 92,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              'game.main.game_header_$index'.trl,
                              style: textTheme.headline2,
                            ),
                          ),
                          Text(
                            'game.main.game_sub_$index'.trl,
                            style: textTheme.headline2!
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      SimpleButton(
                        /// niceu emir chan
                        width: false,
                        onTap: () {},
                        text: 'game.main.next'.trl,
                      ),
                    ],
                  ),
                ),
              ),
              Wrap(
                children: [
                  Text(
                    '${'novel'.trl}  ',
                    style: textTheme.headline4!.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  Text(
                    '0/45',
                    style: textTheme.headline4!.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600),
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
