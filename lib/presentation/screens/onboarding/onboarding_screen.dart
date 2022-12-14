import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/onboarding_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/onboarding/ui/onboarding_layout.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = ref.read(onBoardingProvider);
      provider.goToPage(widget.defaultIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(onBoardingProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: OTTAAAppBar(
        leading: TextButton.icon(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          label: Text("back".trl),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "skip".trl,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: provider.controller,
          children: <Widget>[
            OnboardingLayout(
              title: "onboarding_title_1".trl,
              subtitle: "onboarding_title_1".trl,
              description: "onboarding_title_1".trl,
              image: AppImages.kOnboardingFirstScreen,
            ),
            OnboardingLayout(
              title: "onboarding_title_1".trl,
              subtitle: "onboarding_title_1".trl,
              description: "onboarding_title_1".trl,
              image: AppImages.kOnboardingSecondScreen,
            ),
            OnboardingLayout(
              title: "onboarding_title_1".trl,
              subtitle: "onboarding_title_1".trl,
              description: "onboarding_title_1".trl,
              image: AppImages.kOnboardingThirdScreen,
            ),
          ],
        ),
      ),
    );
  }
}
