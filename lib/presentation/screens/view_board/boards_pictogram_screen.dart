import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/view_board/board_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/view_board/pictogram_screen.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class BoardsPictogramScreen extends ConsumerWidget {
  const BoardsPictogramScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final provider = ref.watch(createPictoProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: OTTAAAppBar(
        title: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: AutoSizeText(
                'customize.board.appbar'.trl,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const Icon(
              Icons.help_outline_sharp,
              color: Colors.grey,
              size: 24,
            ),
          ],
        ),
        actions: [
          Icon(
            Icons.star_border,
            color: colorScheme.primary,
            size: 24,
          ),
          const SizedBox(
            width: 16,
          ),
          Icon(
            Icons.history,
            color: colorScheme.primary,
            size: 24,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              child: TextFormField(
                enabled: false,
                onTap: () {
                  //todo: lead to the search page
                },
                decoration: InputDecoration(
                  hintText: 'global.search'.trl,
                  suffixIcon: const Icon(
                    Icons.search,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: SizedBox(
                width: size.width,
                height: 35,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ChooserWidget(
                      text: 'home.grid.title'.trl,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ChooserWidget(
                        text: 'global.pictogram'.trl,
                      ),
                    ),
                    ChooserWidget(
                      text: 'create.created_by_me'.trl,
                    ),
                  ],
                ),
              ),
            ),
            provider.selectedType == 'global.pictogram'.trl
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: SizedBox(
                      width: size.width,
                      height: 35,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 26,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: AlphabetWidget(
                            text: String.fromCharCode(65 + index),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            provider.selectedType == 'home.grid.title'.trl ? const BoardScreen() : const PictogramScreen()
          ],
        ),
      ),
    );
  }
}

class ChooserWidget extends ConsumerWidget {
  const ChooserWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final provider = ref.watch(createPictoProvider);
    return GestureDetector(
      onTap: () {
        provider.selectedType = text;
        provider.notify();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: provider.selectedType == text ? colorScheme.primary : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: textTheme.bodySmall!.copyWith(color: provider.selectedType == text ? Colors.white : Colors.grey),
        ),
      ),
    );
  }
}

class AlphabetWidget extends ConsumerWidget {
  const AlphabetWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final provider = ref.watch(createPictoProvider);
    return GestureDetector(
      onTap: () async {
        provider.selectedAlphabet = text;
        provider.notify();
        await provider.filterPictosForView();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: provider.selectedAlphabet == text ? colorScheme.primary : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: textTheme.bodySmall!.copyWith(color: provider.selectedAlphabet == text ? Colors.white : Colors.grey),
        ),
      ),
    );
  }
}