import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/games_provider.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/background_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/board_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/header_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/picto_select.dart';
import 'package:ottaa_ui_kit/theme.dart';

class SelectBoardAndPicto extends ConsumerWidget {
  const SelectBoardAndPicto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(gameProvider);
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final user = ref.read(userNotifier);
    final colorScheme = Theme.of(context).colorScheme;
    final groups = provider.gptBoards.map((e) => provider.groups[e]).toList();
    return Scaffold(
      body: Stack(
        children: [
          const BackGroundWidget(),
          HeaderWidget(
            headline: 'profile.hello'.trlf({'name': user!.settings.data.name}),
            subtitle: 'game.game_4_line'.trl,
          ),
          provider.boardOrPicto ? const BoardWidget() : const PictoSelectWidget(),
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
                provider.scrollUp();
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
                provider.scrollDown();
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
