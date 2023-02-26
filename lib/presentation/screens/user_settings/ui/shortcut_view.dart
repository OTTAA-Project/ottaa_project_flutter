import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/user_settings_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/ui/shortcu_widget.dart';

class ShortcutView extends ConsumerWidget {
  const ShortcutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(userSettingsProvider);
    final width= MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.loose,
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShortcutWidget(
                  onTap: () {
                    provider.selectedShortcuts[0] =
                        !provider.selectedShortcuts[0];
                    provider.notify();
                  },
                  heading: "customize.shortcut.favorites".trl,
                  image: AppImages.kBoardFavouriteIcon,
                  image2: AppImages.kBoardFavouriteIconSelected,
                  selected: provider.selectedShortcuts[0],
                ),
                ShortcutWidget(
                  onTap: () {
                    provider.selectedShortcuts[1] =
                        !provider.selectedShortcuts[1];
                    provider.notify();
                  },
                  heading: "customize.shortcut.history".trl,
                  image: AppImages.kBoardHistoryIcon,
                  image2: AppImages.kBoardHistoryIconSelected,
                  selected: provider.selectedShortcuts[1],
                ),
                ShortcutWidget(
                  onTap: () {
                    provider.selectedShortcuts[2] =
                        !provider.selectedShortcuts[2];
                    provider.notify();
                  },
                  heading: "customize.shortcut.camera".trl,
                  image2: AppImages.kBoardCameraIconSelected,
                  image: AppImages.kBoardCameraIcon,
                  selected: provider.selectedShortcuts[2],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShortcutWidget(
                    onTap: () {
                      provider.selectedShortcuts[3] =
                          !provider.selectedShortcuts[3];
                      provider.notify();
                    },
                    heading: "customize.shortcut.games".trl,
                    image: AppImages.kBoardDiceIcon,
                    image2: AppImages.kBoardDiceIconSelected,
                    selected: provider.selectedShortcuts[3],
                  ),
                  ShortcutWidget(
                    onTap: () {
                      provider.selectedShortcuts[4] =
                          !provider.selectedShortcuts[4];
                      provider.notify();
                    },
                    heading: "global.yes".trl,
                    image: AppImages.kBoardYesIcon,
                    image2: AppImages.kBoardYesIconSelected,
                    selected: provider.selectedShortcuts[4],
                  ),
                  ShortcutWidget(
                    onTap: () {
                      provider.selectedShortcuts[5] =
                          !provider.selectedShortcuts[5];
                      provider.notify();
                    },
                    heading: "global.no".trl,
                    image: AppImages.kBoardNoIcon,
                    image2: AppImages.kBoardNoIconSelected,
                    selected: provider.selectedShortcuts[5],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShortcutWidget(
                  onTap: () {
                    provider.selectedShortcuts[6] =
                        !provider.selectedShortcuts[6];
                    provider.notify();
                  },
                  heading: "global.share".trl,
                  image: AppImages.kBoardShareIcon,
                  image2: AppImages.kBoardShareIconSelected,
                  selected: provider.selectedShortcuts[6],
                ),
              ],
            ),
          ],
        ),
        !provider.shortcut
            ? Container(
          height: 400,
          width: width - 48,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
