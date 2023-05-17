import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/chat_gpt_game_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/background_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/header_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/sentence_widget.dart';

class ChatGptGame extends ConsumerWidget {
  const ChatGptGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(chatGptGameProvider);
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final user = ref.read(userProvider.select((value) => value.user!));
    return Scaffold(
      body: Stack(
        children: [
          const BackGroundWidget(),
          HeaderWidget(
            headline: 'profile.hello'.trlf({'name': user.settings.data.name}),
            subtitle: 'game.game_4_line'.trl,
            onTap: () {
              // provider.resetStoryGame();
            },
          ),
          const SentenceWidget(),
          Positioned(
            left: 24,
            bottom: 24,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Icon(
                Icons.folder_open,
                size: 24,
                color: colorScheme.primary,
              ),
            ),
          ),
          // Positioned(
          //   right: provider.btnText ? 24 : 48,
          //   bottom: provider.btnText ? 24 : 48,
          //   child: provider.gptPictos.length == 4
          //       ? SimpleButton(
          //           onTap: () async {
          //             /// goto teh screen where you are showing the sentence
          //             if (provider.gptPictos.length == 4) {
          //               showDialog(
          //                 context: context,
          //                 barrierDismissible: false,
          //                 builder: (context) => const Center(
          //                   child: CircularProgressIndicator(),
          //                 ),
          //               );
          //               await provider.createStory();
          //               context.push(AppRoutes.showCreatedStory);
          //             }
          //           },
          //           text: 'game.gptbtn'.trl,
          //         )
          //       : Text(
          //           'game.gptbtn'.trl,
          //           style: textTheme.displaySmall!.copyWith(color: Colors.grey),
          //         ),
          // ),
        ],
      ),
    );
  }
}
