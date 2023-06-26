import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class ChooseBoardScreen extends ConsumerWidget {
  const ChooseBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(createPictoProvider);
    final isSelected = ref.watch(createPictoProvider).selectedBoardID;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Expanded(
          child: provider.isBoardFetched
              ? ListView.builder(
                  itemCount: provider.boards.length,
                  padding: const EdgeInsets.only(bottom: 16),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        decoration: provider.selectedBoardID == index
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: colorScheme.primary, width: 2),
                              )
                            : const BoxDecoration(),
                        child: PictogramCard(
                          title: provider.boards[index].text,
                          actionText: "customize.board.subtitle".trl,
                          pictogram: CachedNetworkImageProvider(
                            provider.boards[index].resource.network!,
                          ),
                          onPressed: () async {
                            provider.selectedBoardID = index;
                            provider.notify();
                          },
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SimpleButton(
            onTap: provider.selectedBoardID == -1 ? () {} : () => provider.nextPage(),
            width: false,
            text: 'global.next'.trl,
            backgroundColor: isSelected == -1 ? colorScheme.background : colorScheme.primary,
            fontColor: isSelected == -1 ? Colors.grey : Colors.white,
          ),
        ),
      ],
    );
  }
}
