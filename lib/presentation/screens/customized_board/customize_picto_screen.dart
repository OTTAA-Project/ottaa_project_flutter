import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class CustomizePictoScreen extends StatelessWidget {
  const CustomizePictoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            OTTAAAppBar(
              title: Row(
                children: [
                  Text(
                    'Title'.trl,
                    style: textTheme.headline3,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.help_outline_rounded,
                      size: 24,
                    ),
                    onPressed: () => BasicBottomSheet.show(
                      context,
                      // title: "",
                      subtitle: "board.customize.helpText".trl,
                      children: <Widget>[
                        Image.asset(
                          AppImages.kBoardImageEdit1,
                          height: 166,
                        ),
                      ],
                      okButtonText: "board.customize.okText".trl,
                    ),
                    padding: const EdgeInsets.all(0),
                    color: colorScheme.onSurface,
                  ),
                ],
              ),
              leading: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
