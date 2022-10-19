import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// import 'package:getwidget/getwidget.dart';
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
      FadeInLeft(
        child: HeaderWave(
          color: kOTTAAOrangeNew,
          bgColor: kOTTAABackgroundNew,
        ),
      ),
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
        bottom: verticalSize * 0.05,
        child: Container(
          width: horizontalSize * 0.35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StepButton(
                text: "Previous".tr,
                // leading: Icons.chevron_left,
                onTap: () {
                  _.pageNumber.value = 0;
                  controller.animateToPage(_.pageNumber.value,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                backgroundColor: kQuantumGrey,
                fontColor: Colors.white,
              ),
              StepButton(
                text: "Next".tr,
                // trailing: Icons.chevron_right,
                onTap: () {
                  _.pageNumber.value = 2;
                  controller.animateToPage(_.pageNumber.value,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                backgroundColor: kOTTAAOrangeNew,
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
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalSize * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(verticalSize * 0.03),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image(image: AssetImage('assets/imgs/logo_ottaa.webp')),
                        StepButton(
                          width: false,
                          onTap: () => Get.toNamed(AppRoutes.TUTORIAL),
                          text: "Launch_short_tutorial".tr,
                          fontColor: Colors.white,
                          // disabledTextColor: Colors.grey,
                          backgroundColor: kOTTAAOrange,
                          // disabledColor: kQuantumGrey,
                          // shape: GFButtonShape.pills,
                          // size: verticalSize * 0.07,
                          // blockButton: true,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: verticalSize * 0.07),
                          child: StepButton(
                            width: false,
                            fontColor: Colors.white,
                            backgroundColor: Colors.grey,
                            // color: kOTTAAOrange,
                            // disabledColor: kQuantumGrey,
                            onTap: () {},
                            text: "Do_a_guided_workshop".tr,
                            // shape: GFButtonShape.pills,
                            // size: verticalSize * 0.07,
                            // blockButton: true,
                          ),
                        ),
                        StepButton(
                          width: false,
                          onTap: () {},
                          text: "Book_a_demo".tr,
                          fontColor: Colors.white,
                          backgroundColor: Colors.grey,
                          // color: kOTTAAOrange,
                          // disabledColor: kQuantumGrey,
                          // shape: GFButtonShape.pills,
                          // size: verticalSize * 0.07,
                          // blockButton: true,
                        ),
                      ],
                    ),
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
              child: Text(
                'Ottaa_is_a_powerful_communication_tool'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: verticalSize * 0.05,
                ),
              ),
            ),
            SizedBox(
              height: verticalSize * 0.02,
            ),
            Container(
              width: horizontalSize * 0.45,
              child: Text(
                'te_ofrecemos_varias_opciones_para_naprender_a_utilizarla_y_sacarle_el_maximo_provecho'
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
