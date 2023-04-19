import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/customise_provider.dart';
import 'package:ottaa_project_flutter/application/providers/link_provider.dart';
import 'package:ottaa_project_flutter/application/providers/profile_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/core/enums/customise_data_type.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/customize_board_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/customize_shortcut_screen.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class CustomizedMainTabScreen extends ConsumerStatefulWidget {
  const CustomizedMainTabScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomizedMainTabScreen> createState() => _CustomizedMainTabScreenState();
}

class _CustomizedMainTabScreenState extends ConsumerState<CustomizedMainTabScreen> {
  int index = 1;
  final PageController pageController = PageController(initialPage: 0, keepPage: true);

  @override
  void initState() {
    super.initState();

    final provider = ref.read(customiseProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await provider.inIt(userId: provider.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(customiseProvider);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    /// using that variable here from the linkProvider
    final userID = ref.read(linkProvider);
    return Scaffold(
      appBar: OTTAAAppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            provider.groupsFetched = false;
            context.pop();
          },
          splashRadius: 24,
        ),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                index == 1 ? "customize.board.appbar".trl : "customize.shortcut.appbar".trl,
                style: textTheme.bodyText2!.copyWith(fontSize: 14),
                softWrap: true,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              child: Icon(
                Icons.help_outline_rounded,
                size: 24,
                color: colorScheme.onSurface,
              ),
              onTap: () async {
                await BasicBottomSheet.show(
                  context,
                  // title: "",
                  subtitle: index == 1 ? "customize.help.boards".trl : "customize.help.shortcut".trl,
                  children: <Widget>[
                    Image.asset(
                      index == 1 ? AppImages.kBoardImageEdit1 : AppImages.kBoardImageEdit2,
                      height: 166,
                    ),
                  ],
                  okButtonText: "global.done".trl,
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
                okButtonText: "global.yes".trl,
                cancelButtonText: "global.cancel".trl,
                cancelButtonEnabled: true,
                title: "customize.board.skip".trl,
              );
              if (res != null && res == true) {
                // provider.uploadData(userId: user!.id);
                context.push(AppRoutes.userCustomizeWait);
              }
            },
            child: Text(
              "global.skip".trl,
              style: textTheme.headline4!.copyWith(color: colorScheme.onSurface),
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
                            color: index == 1 ? colorScheme.primary : colorScheme.onSurface,
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
                            color: index == 2 ? colorScheme.primary : colorScheme.onSurface,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "${"global.step".trl} $index / 2",
                          style: textTheme.headline4!.copyWith(color: colorScheme.onSurface),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      index == 1 ? "customize.board.title".trl : "customize.shortcut.title".trl,
                      style: textTheme.headline3!.copyWith(fontWeight: FontWeight.w600),
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
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(24),
                child: PrimaryButton(
                  onPressed: () async {
                    if (pageController.page == 0) {
                      setState(() {
                        pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                        index = 2;
                      });
                    } else {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                      switch (provider.type) {
                        case CustomiseDataType.user:
                          await provider.uploadData(userId: provider.userId);
                          provider.groupsFetched = false;
                          provider.type = CustomiseDataType.defaultCase;
                          provider.notify();
                          context.pop();
                          context.pop();
                          break;
                        case CustomiseDataType.careGiver:
                          await provider.uploadData(userId: provider.userId);
                          provider.type = CustomiseDataType.defaultCase;
                          provider.groupsFetched = false;

                          await ref.read(profileProvider).fetchUserById(provider.userId);
                          provider.notify();
                          context.pop();
                          context.pop();
                          break;
                        case CustomiseDataType.defaultCase:
                        default:
                          await provider.uploadData(userId: userID.userId!);
                          context.pop();
                          context.push(AppRoutes.userCustomizeWait);
                          break;
                      }
                    }
                  },
                  text: "global.next".trl,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
