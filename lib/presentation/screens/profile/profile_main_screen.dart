import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/profile_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/responsive_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/connected_users_list.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/drop_down_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/profile_photo_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class ProfileMainScreen extends ConsumerStatefulWidget {
  const ProfileMainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileMainScreen> createState() => _ProfileMainScreenState();
}

class _ProfileMainScreenState extends ConsumerState<ProfileMainScreen> {
  //todo: a jojo reference XD
  final String userName = 'Dio';

  @override
  void initState() {
    super.initState();
    final provider = ref.read(profileProvider);
    final user = ref.read(userProvider.select((value) => value.user));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await provider.setDate();
      if (user!.type == UserType.caregiver) {
        await provider.fetchConnectedUsersData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final provider = ref.watch(profileProvider);

    final user = ref.watch(userProvider.select((value) => value.user));

    if (user == null) return Container();

    return ResponsiveWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => context.push(AppRoutes.userProfile),
                            child: ProfilePhotoWidget(
                              image: user.settings.data.avatar.network ?? "",
                              asset: '671',
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            "profile.hello".trlf({"name": user.settings.data.name}),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          // context.push(AppRoutes.customizedBoardScreen);
                        },
                        child: Image.asset(
                          AppImages.kNotificationIcon,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    "profile.what_do".trl,
                    style: textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  provider.connectedUsersFetched ? const ConnectedUsersList() : const SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ActionCard(
                      title: "profile.link_account".trl,
                      subtitle: "profile.new_existant".trl,
                      trailingImage: const AssetImage(AppImages.kProfileMainScreenIcon),
                      imageSize: const Size(94, 96),
                      focused: provider.isLinkAccountOpen,
                      onPressed: () {
                        provider.isLinkAccountOpen = !provider.isLinkAccountOpen;
                        provider.notify();
                      },
                    ),
                  ),
                  //todo: add the trigger here for the container to show and hide
                  AnimatedContainer(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    duration: const Duration(milliseconds: 500),
                    height: provider.isLinkAccountOpen ? 65 : 0,
                    width: double.maxFinite,
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          // DropDownWidget(
                          //   onTap: () {},
                          //   image: AppImages.kProfileAddIcon,
                          //   text: "profile.crear.nueva.cuenta".trl,
                          // ),
                          // const SizedBox(
                          //   height: 16,
                          // ),
                          // DropDownWidget(
                          //   onTap: () {},
                          //   image: AppImages.kProfileAddIcon,
                          //   text: "profile.crear.nueva.cuenta".trl,
                          // ),
                          // const SizedBox(
                          //   height: 16,
                          // ),
                          DropDownWidget(
                            onTap: () => context.push(AppRoutes.caregiverLink),
                            image: AppImages.kProfileLinkIcon,
                            text: "profile.link_account".trl,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ActionCard(
                    subtitle: "profile.no_account".trl,
                    focused: false,
                    title: "profile.use.ottaa".trl,
                    trailingImage: const AssetImage(AppImages.kProfileIcon2),
                    imageSize: const Size(129, 96),
                    onPressed: () {
                      context.push(AppRoutes.userTalk);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
