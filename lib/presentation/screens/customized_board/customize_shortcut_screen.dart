import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/customise_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/ui/shortcu_widget.dart';

class CustomizeShortcutScreen extends ConsumerStatefulWidget {
  const CustomizeShortcutScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomizeShortcutScreen> createState() => _CustomizeShortcutScreenState();
}

class _CustomizeShortcutScreenState extends ConsumerState<CustomizeShortcutScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(customiseProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShortcutWidget(
                  onTap: () {
                    setState(() {
                      provider.selectedShortcuts[0] = !provider.selectedShortcuts[0];
                    });
                  },
                  heading: "customize.shortcut.favorites".trl,
                  image: AppImages.kBoardFavouriteIcon,
                  image2: AppImages.kBoardFavouriteIconSelected,
                  selected: provider.selectedShortcuts[0],
                ),
                ShortcutWidget(
                  onTap: () {
                    setState(() {
                      provider.selectedShortcuts[1] = !provider.selectedShortcuts[1];
                    });
                  },
                  heading: "customize.shortcut.history".trl,
                  image: AppImages.kBoardHistoryIcon,
                  image2: AppImages.kBoardHistoryIconSelected,
                  selected: provider.selectedShortcuts[1],
                ),
                ShortcutWidget(
                  onTap: () {
                    provider.selectedShortcuts[2] = !provider.selectedShortcuts[2];
                    setState(() {});
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
                      provider.selectedShortcuts[3] = !provider.selectedShortcuts[3];
                      setState(() {});
                    },
                    heading: "customize.shortcut.games".trl,
                    image: AppImages.kBoardDiceIcon,
                    image2: AppImages.kBoardDiceIconSelected,
                    selected: provider.selectedShortcuts[3],
                  ),
                  ShortcutWidget(
                    onTap: () {
                      provider.selectedShortcuts[4] = !provider.selectedShortcuts[4];
                      setState(() {});
                    },
                    heading: "global.yes".trl,
                    image: AppImages.kBoardYesIcon,
                    image2: AppImages.kBoardYesIconSelected,
                    selected: provider.selectedShortcuts[4],
                  ),
                  ShortcutWidget(
                    onTap: () {
                      provider.selectedShortcuts[5] = !provider.selectedShortcuts[5];
                      setState(() {});
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
                    provider.selectedShortcuts[6] = !provider.selectedShortcuts[6];
                    setState(() {});
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
      ),
    );
  }
}
