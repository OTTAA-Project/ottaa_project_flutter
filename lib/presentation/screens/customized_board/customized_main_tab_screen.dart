import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/customize_board_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/customize_shortcut_screen.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class CustomizedMainTabScreen extends StatefulWidget {
  const CustomizedMainTabScreen({Key? key}) : super(key: key);

  @override
  State<CustomizedMainTabScreen> createState() =>
      _CustomizedMainTabScreenState();
}

class _CustomizedMainTabScreenState extends State<CustomizedMainTabScreen> {
  int index = 1;
  bool tabChange = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //todo: emir fix it again XD
              OTTAAAppBar(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "board.customize.title".trl,
                      style: textTheme.headline3,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.help_outline_rounded,
                        size: 24,
                      ),
                      onPressed: () => BasicBottomSheet.show(
                        context,
                        // title: "",
                        subtitle: "helpText".trl,
                        children: <Widget>[
                          Image.asset(
                            AppImages.kBoardImageEdit1,
                            height: 166,
                          ),
                        ],
                        okButtonText: "okText".trl,
                      ),
                      padding: const EdgeInsets.all(0),
                      color: colorScheme.onSurface,
                    ),
                  ],
                ),
                actions: [
                  Text(
                    "Omitir".trl,
                    style: textTheme.headline4!
                        .copyWith(color: colorScheme.onSurface),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 12,
                          width: 32,
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Container(
                          height: 12,
                          width: 16,
                          decoration: BoxDecoration(
                            color: colorScheme.onSurface,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Paso $index/2",
                          style: textTheme.headline4!
                              .copyWith(color: colorScheme.onSurface),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "board.customize.heading".trl,
                      style: textTheme.headline3!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              // Expanded(
              //   child: ListView(
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     scrollDirection: Axis.horizontal,
              //     children: const [
              //       CustomizeBoardScreen(),
              //       CustomizeShortcutScreen(),
              //     ],
              //   ),
              // )
              tabChange
                  ? const CustomizeBoardScreen()
                  : const CustomizeShortcutScreen(),
            ],
          ),
          Positioned(
            bottom: 16,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PrimaryButton(
                onPressed: () {
                  setState(() {
                    tabChange = !tabChange;
                  });
                },
                //todo: add text here after discussing with the team
                text: "Continuar".trl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
