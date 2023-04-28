import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/new_simple_button.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/background_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/header_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/select_board_and_picto.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/sentence_widget.dart';

class ChatgptGame extends ConsumerWidget {
  const ChatgptGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(gameProvider);
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final user = ref.read(userNotifier);
    return Scaffold(
      body: Stack(
        children: [
          const BackGroundWidget(),
          HeaderWidget(
            headline: 'profile.hello'.trlf({'name': user!.settings.data.name}),
            subtitle: 'game.game_4_line'.trl,
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
          Positioned(
            right: provider.btnText ? 24 : 48,
            bottom: provider.btnText ? 24 : 48,
            child: provider.gptPictos.length == 4
                ? SimpleButton(
                    onTap: () {
                      /// goto teh screen where you are showing the sentence
                   if(provider.gptPictos.length == 4){
                     provider.createStory();
                   }
                   print(provider.gptPictos.length);
                   print('yes');
                      // context.push(AppRoutes.showCreatedStory);
                    },
                    text: 'game.gptbtn'.trl,
                  )
                : Text(
                    'game.gptbtn'.trl,
                    style: textTheme.headline3!.copyWith(color: Colors.grey),
                  ),
          ),
        ],
      ),
    );
  }
}
