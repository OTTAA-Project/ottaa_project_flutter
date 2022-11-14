import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/loading_notifier.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_avatar_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/onboarding_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/presentation/common/ui/ottaa_wave.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/image_avatar.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';

class UserAvatarSelectorStep extends ConsumerStatefulWidget {
  const UserAvatarSelectorStep({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserInfoStepState();
}

class _UserInfoStepState extends ConsumerState<UserAvatarSelectorStep> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final size = MediaQuery.of(context).size;

    final width = size.width;
    final height = size.height;

    final provider = ref.watch(onBoardingProvider);

    final avatarNotifier = ref.watch(userAvatarNotifier);

    final loading = ref.watch(loadingProvider);

    return SizedBox.fromSize(
      size: size,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: FadeInLeft(
              child: const OTTAAWave(
                color: kOTTAAOrangeNew,
                bgColor: kOTTAABackgroundNew,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: width * 0.05,
            child: JelloIn(
              child: Image.asset(
                'assets/Group 706.png',
                width: width * 0.3,
              ),
            ),
          ),
          Positioned(
            right: width * 0.05,
            top: height * 0.03,
            height: height,
            child: FadeInUp(
              child: Center(
                child: SizedBox(
                  width: width * 0.45,
                  height: height,
                  child: Column(
                    children: [
                      Text("Choose_your_avatar".trl),
                      const SizedBox(height: 20),
                      Container(
                        height: height * 0.2,
                        width: width * 0.16,
                        child: Stack(
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/profiles/Group $avatarNotifier@2x.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 0,
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: kOTTAAOrangeNew,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 5,
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          // padding:
                          // EdgeInsets.symmetric(vertical: verticalSize * 0.05),
                          mainAxisSpacing: height * 0.02,
                          children: [
                            ImageAvatar(imageId: 615, onTap: ref.read(onBoardingProvider).changeAvatar),
                            ImageAvatar(imageId: 617, onTap: ref.read(onBoardingProvider).changeAvatar),
                            ImageAvatar(imageId: 639, onTap: ref.read(onBoardingProvider).changeAvatar),
                            ImageAvatar(imageId: 663, onTap: ref.read(onBoardingProvider).changeAvatar),
                            ImageAvatar(imageId: 664, onTap: ref.read(onBoardingProvider).changeAvatar),
                            ImageAvatar(imageId: 665, onTap: ref.read(onBoardingProvider).changeAvatar),
                            ImageAvatar(imageId: 666, onTap: ref.read(onBoardingProvider).changeAvatar),
                            ImageAvatar(imageId: 667, onTap: ref.read(onBoardingProvider).changeAvatar),
                            ImageAvatar(imageId: 668, onTap: ref.read(onBoardingProvider).changeAvatar),
                            ImageAvatar(imageId: 669, onTap: ref.read(onBoardingProvider).changeAvatar),
                            ImageAvatar(imageId: 670, onTap: ref.read(onBoardingProvider).changeAvatar),
                            ImageAvatar(imageId: 674, onTap: ref.read(onBoardingProvider).changeAvatar),
                            ImageAvatar(imageId: 672, onTap: ref.read(onBoardingProvider).changeAvatar),
                            ImageAvatar(imageId: 673, onTap: ref.read(onBoardingProvider).changeAvatar),
                            ImageAvatar(imageId: 671, onTap: ref.read(onBoardingProvider).changeAvatar),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: width * 0.05,
            bottom: height * 0.05,
            child: SizedBox(
              width: width * 0.35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SimpleButton(
                    text: "Previous".trl,
                    // leading: Icons.chevron_left,
                    onTap: () {
                      provider.previousPage();
                    },
                    backgroundColor: kQuantumGrey,
                    fontColor: Colors.white,
                  ),
                  SimpleButton(
                    text: "Next".trl,
                    // trailing: Icons.chevron_right,
                    onTap: () async {
                      await provider.updateUserAvatar();
                      if (mounted) context.go(AppRoutes.home);
                    },
                    backgroundColor: kOTTAAOrangeNew,
                    fontColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: width * 0.045,
            left: height * 0.025,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'por_ltimo'.trl,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  height: width * 0.02,
                ),
                Text(
                  'elige_un_personaje_que_nmejor_te_represente'.trl,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          if (loading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
