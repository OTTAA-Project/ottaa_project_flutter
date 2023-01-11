import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/customise_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/customize_board_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/customize_shortcut_screen.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class CustomizedMainTabScreen extends ConsumerStatefulWidget {
  const CustomizedMainTabScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomizedMainTabScreen> createState() =>
      _CustomizedMainTabScreenState();
}

class _CustomizedMainTabScreenState
    extends ConsumerState<CustomizedMainTabScreen> {
  int index = 1;
  final PageController pageController =
      PageController(initialPage: 0, keepPage: true);

  @override
  void initState() {
    super.initState();

    final provider = ref.read(customiseProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await provider.fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(customiseProvider);
    final user = ref.read(userNotifier);
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
                  ? "customize.board.appbar".trl
                  : "customize.shortcut.appbar".trl,
              style: textTheme.headline3!.copyWith(fontSize: 13),
            ),
            const SizedBox(
              width: 8,
            ),
            GestureDetector(
              child: Icon(
                Icons.help_outline_rounded,
                size: 24,
                color: colorScheme.onSurface,
              ),
              onTap: () async {
                print('yes');
                await BasicBottomSheet.show(
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
                );
              },
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              final bool? res = await BasicBottomSheet.show(
                context,
                cancelButtonEnabled: true,
                title: "customize.board.skip".trl,
              );
              if (res != null && res == true) {
                context.push(AppRoutes.customizeWaitScreen);
              }
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
                          : "board.shortcut.title".trl,
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
                onPressed: () async {
                  if (pageController.page == 0) {
                    setState(() {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                      index = 2;
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                    await provider.uploadData(userId: user!.id);
                    context.push(AppRoutes.customizeWaitScreen);
                  }
                },
                text: "global.next".trl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
