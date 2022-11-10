import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/providers/onboarding_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/onboarding/ui/tutorial_step.dart';
import 'package:ottaa_project_flutter/presentation/screens/onboarding/ui/user_avatar_selector_step.dart';
import 'package:ottaa_project_flutter/presentation/screens/onboarding/ui/user_info_step.dart';

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
      body: SafeArea(
        top: false,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: provider.controller,
          children: const <Widget>[
            UserInfoStep(),
            TutorialStep(),
            UserAvatarSelectorStep(),
          ],
        ),
      ),
    );
  }
}
