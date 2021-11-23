import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import '../onboarding_controller.dart';
import 'header_wave.dart';

step3Onboarding<widget>(
    OnboardingController _, PageController controller, context) {
  double verticalSize = MediaQuery.of(context).size.height;
  double horizontalSize = MediaQuery.of(context).size.width;
  return Stack(
    children: [
      FadeInLeft(child: HeaderWave(color: kOTTAOrange)),
      Positioned(
        bottom: 0,
        left: horizontalSize * 0.05,
        child: JelloIn(
          child: SvgPicture.asset(
            'assets/Group 706.svg',
            width: horizontalSize * 0.43,
            placeholderBuilder: (BuildContext context) =>
                Container(child: const CircularProgressIndicator()),
          ),
        ),
      ),
      Positioned(
        right: horizontalSize * 0.05,
        top: verticalSize * 0.12,
        child: FadeInUp(
          child: Center(
            child: Container(
              width: horizontalSize * 0.4,
              height: verticalSize * 0.8,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Choose_your_avatar".tr),
                  ClipRRect(
                    child: Image(image: AssetImage('assets/Group 671.png')),
                  ),
                  Column(
                    children: [
                      Text("${"Hello".tr}!"),
                      Text("Please_register_for".tr),
                      Text("Continue".tr)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => controller.animateToPage(1,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut),
                        iconSize: 150,
                        icon: SvgPicture.asset(
                          'assets/Group 731.svg',
                        ),
                      ),
                      IconButton(
                        onPressed: () => Get.toNamed(AppRoutes.TUTORIAL),
                        iconSize: 150,
                        icon: SvgPicture.asset(
                          'assets/Group 732.svg',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: verticalSize * 0.045,
        left: horizontalSize * 0.05,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${'Final_step_join'.tr}!',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40)),
            Text(
              '${'Create_your_avatar_to_be_able_to_recognize_you_all_the_time'.tr}!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
