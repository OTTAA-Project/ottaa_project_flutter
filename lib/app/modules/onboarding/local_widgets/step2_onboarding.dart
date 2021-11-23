import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ottaa_project_flutter/app/global_widgets/step_button.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import '../onboarding_controller.dart';
import 'header_wave.dart';

step2Onboarding<widget>(
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
            'assets/wheelchair girl.svg',
            width: horizontalSize * 0.35,
            placeholderBuilder: (BuildContext context) =>
                Container(child: const CircularProgressIndicator()),
          ),
        ),
      ),
      Positioned(
        right: horizontalSize * 0.05,
        bottom: verticalSize * 0.10,
        child: Container(
          width: horizontalSize * 0.35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StepButton(
                text: "Previous".tr,
                leading: Icons.chevron_left,
                onTap: () => controller.animateToPage(0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut),
                backgroundColor: Colors.grey,
                fontColor: Colors.white,
              ),
              StepButton(
                text: "Next".tr,
                trailing: Icons.chevron_right,
                onTap: () => controller.animateToPage(2,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut),
                backgroundColor: kOTTAOrange,
                fontColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
      Positioned(
        right: horizontalSize * 0.05,
        top: verticalSize * 0.05,
        child: FadeInUp(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: horizontalSize * 0.35,
                  height: verticalSize * 0.7,
                  // decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/imgs/logo_ottaa.webp')),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 30),
                            child: GFButton(
                              onPressed: () => Get.toNamed(AppRoutes.TUTORIAL),
                              text: "Launch_short_tutorial".tr,
                              textColor: Colors.white,
                              disabledTextColor: Colors.grey,
                              color: kOTTAOrange,
                              disabledColor: kQuantumGrey,
                              shape: GFButtonShape.pills,
                              size: GFSize.LARGE,
                              blockButton: true,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 30),
                            child: GFButton(
                              textColor: Colors.white,
                              disabledTextColor: Colors.grey,
                              color: kOTTAOrange,
                              disabledColor: kQuantumGrey,
                              onPressed: null,
                              text: "Do_a_guided_workshop".tr,
                              shape: GFButtonShape.pills,
                              size: GFSize.LARGE,
                              blockButton: true,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 30),
                            child: GFButton(
                              onPressed: null,
                              text: "Book_a_demo".tr,
                              textColor: Colors.white,
                              disabledTextColor: Colors.grey,
                              color: kOTTAOrange,
                              disabledColor: kQuantumGrey,
                              shape: GFButtonShape.pills,
                              size: GFSize.LARGE,
                              blockButton: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        top: verticalSize * 0.045,
        left: horizontalSize * 0.025,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: horizontalSize * 0.45,
              child: FittedBox(
                child: Text(
                  'Ottaa_is_a_powerful_communication_tool'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            Container(
              width: horizontalSize * 0.45,
              child: AutoSizeText(
                'We_offer_you_different_options_so_that_you_learn_how_to_use_it_and_get_the_most_out_of_it'
                    .tr,
                style: TextStyle(color: Colors.white),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
