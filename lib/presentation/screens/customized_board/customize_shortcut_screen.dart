import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShortcutWidget(
                  onTap: () {
                    selected = !selected;
                  },
                  heading: 'Favourite',
                  image: AppImages.kBoardFavouriteIcon,
                  image2: AppImages.kBoardFavouriteIconSelected,
                  selected: selected,
                ),
                ShortcutWidget(
                  onTap: () {},
                  heading: 'History',
                  image: AppImages.kBoardHistoryIcon,
                  image2: AppImages.kBoardHistoryIconSelected,
                  selected: true,
                ),
                ShortcutWidget(
                  onTap: () {},
                  heading: 'camera',
                  image2: AppImages.kBoardCameraIconSelected,
                  image: AppImages.kBoardCameraIcon,
                  selected: true,
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
                    heading: 'History',
                    image: AppImages.kBoardDiceIcon,
                    image2: AppImages.kBoardDiceIconSelected,
                    selected: true,
                  ),
                  ShortcutWidget(
                    onTap: () {},
                    heading: 'History',
                    image: AppImages.kBoardYesIcon,
                    image2: AppImages.kBoardYesIconSelected,
                    selected: true,
                  ),
                  ShortcutWidget(
                    onTap: () {},
                    heading: 'History',
                    image: AppImages.kBoardNoIcon,
                    image2: AppImages.kBoardNoIconSelected,
                    selected: true,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShortcutWidget(
                  onTap: () {},
                  heading: 'History',
                  image: AppImages.kBoardShareIcon,
                  image2: AppImages.kBoardShareIconSelected,
                  selected: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
