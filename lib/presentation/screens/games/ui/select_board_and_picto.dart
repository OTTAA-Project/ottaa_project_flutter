import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/chatgpt_provider.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/background_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/board_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/header_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/picto_select.dart';

class SelectBoardAndPicto extends ConsumerWidget {
  const SelectBoardAndPicto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
    final provider = ref.watch(chatGPTProvider);
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final user = ref.read(userProvider.select((value) => value.user!));
    final colorScheme = Theme.of(context).colorScheme;
    final groups = [];
    return Scaffold(
      body: Stack(
        children: [
          const BackGroundWidget(),
          HeaderWidget(
            headline: 'profile.hello'.trlf({'name': user.settings.data.name}),
            subtitle: 'game.game_4_line'.trl,
            onTap: () {
              // if (provider.sentencePhase < provider.chatGptPictos.length) {
              //   provider.boardOrPicto = true;
              // }
            },
          ),
          true ? const BoardWidget() : const PictoSelectWidget(), //TODO!: FIX ALL GPT PROVIDER
          Positioned(
            right: 24,
            top: size.height * 0.3,
            child: GestureDetector(
              onTap: () {
                //todo: search is disabled for now
                // context.push(AppRoutes.searchScreen);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.search,
                  color: colorScheme.primary,
                  size: 24,
                ),
              ),
            ),
          ),
          Positioned(
            right: 24,
            top: size.height * 0.5,
            child: GestureDetector(
              onTap: () {
                // provider.boardOrPicto ? provider.scrollUpBoards() : provider.scrollUpPictos();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color: colorScheme.primary,
                  size: 24,
                ),
              ),
            ),
          ),
          Positioned(
            right: 24,
            top: size.height * 0.7,
            child: GestureDetector(
              onTap: () {
                // provider.boardOrPicto ? provider.scrollDownBoards() : provider.scrollDownPictos();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: colorScheme.primary,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
