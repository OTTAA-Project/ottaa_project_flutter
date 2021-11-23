import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/onboarding/local_widgets/step1_onboarding.dart';
import 'package:ottaa_project_flutter/app/modules/onboarding/local_widgets/step2_onboarding.dart';
import 'package:ottaa_project_flutter/app/modules/onboarding/onboarding_controller.dart';

import 'local_widgets/step3_onboarding.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return GetBuilder<OnboardingController>(
        id: "onboarding",
        builder: (_) {
          return Scaffold(
            body: SafeArea(
              child: PageView(
                /// [PageView.scrollDirection] defaults to [Axis.horizontal].
                /// Use [Axis.vertical] to scroll vertically.
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                controller: controller,
                children: <Widget>[
                  step1Onboarding(_, controller, context),
                  step2Onboarding(_, controller, context),
                  step3Onboarding(_, controller, context),
                ],
              ),
            ),
          );
        });
  }
}
