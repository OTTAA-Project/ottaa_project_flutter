import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/customise_provider.dart';
import 'package:ottaa_project_flutter/application/providers/link_provider.dart';
import 'package:ottaa_project_flutter/application/providers/profile_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/core/enums/customise_data_type.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/responsive_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/customize_board_screen.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class CustomizedBoardTabScreen extends ConsumerStatefulWidget {
  const CustomizedBoardTabScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomizedBoardTabScreen> createState() => _CustomizedMainTabScreenState();
}

class _CustomizedMainTabScreenState extends ConsumerState<CustomizedBoardTabScreen> {
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
    final user = ref.read(userProvider.select((value) => value.user));
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final userID = ref.read(linkProvider);
    return ResponsiveWidget(
      child: Scaffold(
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
                  "customize.board.appbar".trl,
                  style: textTheme.bodyMedium!.copyWith(fontSize: 14),
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
                    subtitle: "customize.help.boards".trl,
                    children: <Widget>[
                      Image.asset(
                        AppImages.kBoardImageEdit1,
                        height: 166,
                      ),
                    ],
                    okButtonText: "global.done".trl,
                  );
                },
              ),
            ],
          ),
        ),
        backgroundColor: colorScheme.background,
        body: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// main view is here
                const Expanded(
                  child: CustomizeBoardScreen(),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(24),
                  child: PrimaryButton(
                    onPressed: () async {
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
                          await provider.uploadData(userId: user!.id);
                          provider.groupsFetched = false;
                          provider.type = CustomiseDataType.defaultCase;

                          context.pop();
                          context.go(AppRoutes.home);
                          break;
                        case CustomiseDataType.careGiver:
                          await provider.uploadData(userId: provider.userId);
                          provider.type = CustomiseDataType.defaultCase;
                          provider.groupsFetched = false;

                          await ref.read(profileProvider).fetchUserById(provider.userId);
                          // provider.notify();
                          context.pop();
                          context.go(AppRoutes.home);
                          break;
                        case CustomiseDataType.defaultCase:
                        default:
                          await provider.uploadData(userId: userID.userId ?? provider.userId);
                          context.pop();
                          context.go(AppRoutes.userCustomizeWait);
                          break;
                      }
                    },
                    text: "global.save_changes".trl,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
