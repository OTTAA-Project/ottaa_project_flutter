import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/common/screen_util.dart';
import 'package:ottaa_project_flutter/application/notifiers/auth_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/onboarding_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/screens/onboarding/ui/onboarding_layout.dart';
import 'package:ottaa_project_flutter/presentation/screens/onboarding/ui/onboarding_page_indicator.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class OnBoardingScreen extends ConsumerStatefulWidget {
  final int defaultIndex;

  const OnBoardingScreen({super.key, this.defaultIndex = 0});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends ConsumerState<OnBoardingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(onBoardingProvider.select((value) => value.goToPage))(widget.defaultIndex);

      await blockPortraitMode();

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

    final currentIndex = ref.watch(onBoardingProvider.select((value) => value.currentIndex));

    final isLogged = ref.read(authNotifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  if (mounted) context.go(isLogged ? AppRoutes.profileChooserScreen : AppRoutes.login);
                }
              },
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              child: Text("global.skip".trl),
            ),
        ],
      ),
      body: SafeArea(
        top: false,
        left: true,
        right: true,
        child: SizedBox.fromSize(
          size: MediaQuery.of(context).size,
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
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: PrimaryButton(
                      onPressed: () {
                        if (currentIndex == 2) {
                          context.go(isLogged ? AppRoutes.profileChooserScreen : AppRoutes.login);
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
    );
  }
}
