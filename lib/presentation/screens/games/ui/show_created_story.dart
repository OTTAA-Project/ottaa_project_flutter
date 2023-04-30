import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/chatgpt_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/background_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/header_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/storyWidget.dart';

class ShowCreatedStory extends ConsumerWidget {
  const ShowCreatedStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(chatGPTProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final user = ref.read(userNotifier);
    return Scaffold(
      body: Stack(
        children: [
          const BackGroundWidget(),
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
            child: Column(
              children: [
                HeaderWidget(
                  headline: 'profile.hello'.trlf({'name': user!.settings.data.name}),
                  subtitle: 'game.game_4_line'.trl,
                  simple: false,
                  onTap: () {
                    ///reset the whole game
                    provider.resetStoryGame();
                    context.pop();
                    context.pop();
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                const StoryWidget(),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            right: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                StoryButton(
                  onTap: () {},
                  image: AppImages.kSaveIcon,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: StoryButton(
                    onTap: () {},
                    image: AppImages.kShareIcon,
                  ),
                ),
                StoryButton(
                  onTap: () {
                    provider.speakStory();
                  },
                  image: AppImages.kOttaa,
                  orange: true,
                ),
                const SizedBox(
                  width: 24,
                ),
                GestureDetector(
                  onTap: () {
                    provider.stopTTS();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.stop,
                      color: colorScheme.primary,
                      size: 44,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StoryButton extends StatelessWidget {
  const StoryButton({
    Key? key,
    this.orange = false,
    required this.image,
    required this.onTap,
  }) : super(key: key);
  final bool orange;
  final String image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: orange ? colorScheme.primary : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(
          image,
          height: 40,
        ),
      ),
    );
  }
}
