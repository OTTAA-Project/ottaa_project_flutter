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
  final PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: OTTAAAppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              index == 1
                  ? "customize.board.title".trl
                  : "customize.shortcut.title".trl,
              style: textTheme.headline3!.copyWith(fontSize: 13),
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
                subtitle: index == 1
                    //TODO: check this if it is OK
                    ? "board.customize.helpText".trl
                    : "global.back".trl,
                children: <Widget>[
                  Image.asset(
                    index == 1
                        ? AppImages.kBoardImageEdit1
                        : AppImages.kBoardImageEdit2,
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
        actions: [
          GestureDetector(
            onTap: () {
              //todo: add the required things here
            },
            child: Text(
              "global.skip".trl,
              style:
                  textTheme.headline4!.copyWith(color: colorScheme.onSurface),
            ),
          ),
        ],
      ),
      backgroundColor: colorScheme.background,
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //todo: emir fix it again XD
              //todo: add the emir widgets here
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 12,
                          width: index == 1 ? 32 : 16,
                          decoration: BoxDecoration(
                            color: index == 1
                                ? colorScheme.primary
                                : colorScheme.onSurface,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 12,
                          width: index == 2 ? 32 : 16,
                          decoration: BoxDecoration(
                            color: index == 2
                                ? colorScheme.primary
                                : colorScheme.onSurface,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "${"global.step".trl} $index / 2",
                          style: textTheme.headline4!
                              .copyWith(color: colorScheme.onSurface),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      index == 1
                          ? "customize.board.title".trl
                          : "board.shortcut.heading".trl,
                      style: textTheme.headline3!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),

              /// main view is here
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  children: const [
                    CustomizeBoardScreen(),
                    CustomizeShortcutScreen(),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PrimaryButton(
                onPressed: () {
                  //todo: add the proper things here
                  setState(() {
                    if (pageController.page == 1) {
                      pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                      index = 1;
                    } else {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                      index = 2;
                    }
                  });
                },
                //todo: add text here after discussing with the team
                text: "global.next".trl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
