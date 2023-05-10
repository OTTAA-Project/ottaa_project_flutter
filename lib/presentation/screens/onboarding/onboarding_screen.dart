import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/common/screen_helpers.dart';
import 'package:ottaa_project_flutter/application/providers/auth_provider.dart';
import 'package:ottaa_project_flutter/application/providers/onboarding_provider.dart';
import 'package:ottaa_project_flutter/application/providers/splash_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/screens/onboarding/ui/onboarding_layout.dart';
import 'package:ottaa_project_flutter/presentation/screens/onboarding/ui/onboarding_page_indicator.dart';
import 'package:ottaa_ui_kit/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

class OnBoardingScreen extends ConsumerStatefulWidget {
  final int defaultIndex;

  const OnBoardingScreen({super.key, this.defaultIndex = 0});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends ConsumerState<OnBoardingScreen> {
  bool isLogged = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(onBoardingProvider.select((value) => value.goToPage))(widget.defaultIndex);
      isLogged = await ref.read(authProvider.select((value) => value.isUserLoggedIn()));
      DeviceScreenType deviceScreenType = getDeviceType(MediaQuery.of(context).size);
      if (deviceScreenType != DeviceScreenType.mobile) {
        await blockLandscapeMode();
      } else {
        await unblockRotation();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.read(onBoardingProvider);
    final spProvider = ref.read(splashProvider);

    final currentIndex = ref.watch(onBoardingProvider.select((value) => value.currentIndex));

    return LayoutBuilder(
      key: const Key("onboarding_layout_builder"),
      builder: (context, constraints) {
        bool isMedium = constraints.maxWidth > 800;

        return Scaffold(
          appBar: OTTAAAppBar(
            leading: (currentIndex) > 0
                ? TextButton.icon(
                    onPressed: provider.previousPage,
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                    label: Text("global.back".trl),
                    style: TextButton.styleFrom(foregroundColor: Colors.grey),
                  )
                : null,
            actions: [
              if ((currentIndex) < 2)
                TextButton(
                  onPressed: () async {
                    final bool? skip = await BasicBottomSheet.show<bool>(
                      context,
                      title: "onboarding.skip.title".trl,
                      okButtonText: "global.yes".trl,
                      cancelButtonText: "global.no".trl,
                      cancelButtonEnabled: true,
                    );

                    if (skip != null && skip) {
                      if (mounted) {
                        await spProvider.setFirstTime();
                        context.go(isLogged ? AppRoutes.userProfileRole : AppRoutes.login);
                      }
                    }
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.grey),
                  child: Text("global.skip".trl),
                ),
            ],
          ),
          resizeToAvoidBottomInset: false,
          body: Center(
            child: SafeArea(
              top: true,
              left: true,
              right: true,
              child: SizedBox.fromSize(
                size: isMedium ? Size(constraints.maxHeight / 2, constraints.maxHeight) : Size(constraints.maxWidth, constraints.maxHeight),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 10,
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        controller: provider.controller,
                        children: <Widget>[
                          OnboardingLayout(
                            title: "onboarding.profile.title".trl,
                            subtitle: "onboarding.profile.subtitle".trl,
                            description: "onboarding.profile.description".trl,
                            image: AppImages.kOnboardingFirstScreen,
                          ),
                          OnboardingLayout(
                            title: "onboarding.home.title".trl,
                            subtitle: "onboarding.home.subtitle".trl,
                            description: "onboarding.home.description".trl,
                            image: AppImages.kOnboardingSecondScreen,
                          ),
                          OnboardingLayout(
                            title: "onboarding.customize.title".trl,
                            subtitle: "onboarding.customize.subtitle".trl,
                            description: "onboarding.customize.description".trl,
                            image: AppImages.kOnboardingThirdScreen,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          OnboardinPageIndicator(active: currentIndex == 0),
                          OnboardinPageIndicator(active: currentIndex == 1),
                          OnboardinPageIndicator(active: currentIndex == 2),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: PrimaryButton(
                            onPressed: () async {
                              if (currentIndex == 2) {
                                await spProvider.setFirstTime();
                                context.go(isLogged ? AppRoutes.home : AppRoutes.login);
                                return;
                              }
                              provider.nextPage();
                            },
                            text: currentIndex == 2 ? "onboarding.start".trl : "global.next".trl,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
