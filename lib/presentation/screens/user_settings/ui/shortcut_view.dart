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
    final width = MediaQuery.of(context).size.width;
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
                    provider.layoutSetting.shortcuts.favs =
                        !provider.layoutSetting.shortcuts.favs;
                    provider.notify();
                  },
                  heading: "customize.shortcut.favorites".trl,
                  image: AppImages.kBoardFavouriteIcon,
                  image2: AppImages.kBoardFavouriteIconSelected,
                  selected: provider.layoutSetting.shortcuts.favs,
                ),
                ShortcutWidget(
                  onTap: () {
                    provider.layoutSetting.shortcuts.history =
                        !provider.layoutSetting.shortcuts.history;
                    provider.notify();
                  },
                  heading: "customize.shortcut.history".trl,
                  image: AppImages.kBoardHistoryIcon,
                  image2: AppImages.kBoardHistoryIconSelected,
                  selected: provider.layoutSetting.shortcuts.history,
                ),
                ShortcutWidget(
                  onTap: () {
                    provider.layoutSetting.shortcuts.camera =
                        !provider.layoutSetting.shortcuts.camera;
                    provider.notify();
                  },
                  heading: "customize.shortcut.camera".trl,
                  image2: AppImages.kBoardCameraIconSelected,
                  image: AppImages.kBoardCameraIcon,
                  selected: provider.layoutSetting.shortcuts.camera,
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
                      provider.layoutSetting.shortcuts.games =
                          !provider.layoutSetting.shortcuts.games;
                      provider.notify();
                    },
                    heading: "customize.shortcut.games".trl,
                    image: AppImages.kBoardDiceIcon,
                    image2: AppImages.kBoardDiceIconSelected,
                    selected: provider.layoutSetting.shortcuts.games,
                  ),
                  ShortcutWidget(
                    onTap: () {
                      provider.layoutSetting.shortcuts.yes =
                          !provider.layoutSetting.shortcuts.yes;
                      provider.notify();
                    },
                    heading: "global.yes".trl,
                    image: AppImages.kBoardYesIcon,
                    image2: AppImages.kBoardYesIconSelected,
                    selected: provider.layoutSetting.shortcuts.yes,
                  ),
                  ShortcutWidget(
                    onTap: () {
                      provider.layoutSetting.shortcuts.no =
                          !provider.layoutSetting.shortcuts.no;
                      provider.notify();
                    },
                    heading: "global.no".trl,
                    image: AppImages.kBoardNoIcon,
                    image2: AppImages.kBoardNoIconSelected,
                    selected: provider.layoutSetting.shortcuts.no,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShortcutWidget(
                  onTap: () {
                    provider.layoutSetting.shortcuts.share =
                        !provider.layoutSetting.shortcuts.share;
                    provider.notify();
                  },
                  heading: "global.share".trl,
                  image: AppImages.kBoardShareIcon,
                  image2: AppImages.kBoardShareIconSelected,
                  selected: provider.layoutSetting.shortcuts.share,
                ),
              ],
            ),
          ],
        ),
        !provider.layoutSetting.shortcuts.enable
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
