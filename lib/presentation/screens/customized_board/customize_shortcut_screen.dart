import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/ui/shortcu_widget.dart';

class CustomizeShortcutScreen extends StatefulWidget {
  const CustomizeShortcutScreen({Key? key}) : super(key: key);

  @override
  State<CustomizeShortcutScreen> createState() =>
      _CustomizeShortcutScreenState();
}

class _CustomizeShortcutScreenState extends State<CustomizeShortcutScreen> {
  bool selected = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShortcutWidget(
                onTap: () {
                  setState(() {
                    selected = !selected;
                  });
                },
                heading: "customize.shortcut.favorites".trl,
                image: AppImages.kBoardFavouriteIcon,
                image2: AppImages.kBoardFavouriteIconSelected,
                selected: selected,
              ),
              ShortcutWidget(
                onTap: () {
                  context.push(AppRoutes.customizeWaitScreen);
                },
                heading: "customize.shortcut.history".trl,
                image: AppImages.kBoardHistoryIcon,
                image2: AppImages.kBoardHistoryIconSelected,
                selected: selected,
              ),
              ShortcutWidget(
                onTap: () {
                  context.push(AppRoutes.customizePictoScreen);
                },
                heading: "customize.shortcut.camera".trl,
                image2: AppImages.kBoardCameraIconSelected,
                image: AppImages.kBoardCameraIcon,
                selected: selected,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShortcutWidget(
                  onTap: () {},
                  heading: "customize.shortcut.games".trl,
                  image: AppImages.kBoardDiceIcon,
                  image2: AppImages.kBoardDiceIconSelected,
                  selected: selected,
                ),
                ShortcutWidget(
                  onTap: () {},
                  heading: "global.yes".trl,
                  image: AppImages.kBoardYesIcon,
                  image2: AppImages.kBoardYesIconSelected,
                  selected: selected,
                ),
                ShortcutWidget(
                  onTap: () {},
                  heading: "global.no".trl,
                  image: AppImages.kBoardNoIcon,
                  image2: AppImages.kBoardNoIconSelected,
                  selected: selected,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShortcutWidget(
                onTap: () {},
                heading: "global.share".trl,
                image: AppImages.kBoardShareIcon,
                image2: AppImages.kBoardShareIconSelected,
                selected: selected,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
