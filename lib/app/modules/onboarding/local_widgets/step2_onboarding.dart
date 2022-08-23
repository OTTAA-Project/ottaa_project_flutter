import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ottaa_project_flutter/app/global_widgets/step_button.dart';
import 'package:ottaa_project_flutter/app/modules/onboarding/local_widgets/header_wave.dart';
import 'package:ottaa_project_flutter/app/modules/onboarding/onboarding_controller.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

step2Onboarding<widget>(OnboardingController _, PageController controller, context) {
  double verticalSize = MediaQuery.of(context).size.height;
  double horizontalSize = MediaQuery.of(context).size.width;

  return Stack(
    children: [
      FadeInLeft(
        child: const HeaderWave(
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
            placeholderBuilder: (BuildContext context) => const CircularProgressIndicator(),
          ),
        ),
      ),
      Positioned(
        right: horizontalSize * 0.05,
        bottom: verticalSize * 0.10,
        child: SizedBox(
          width: horizontalSize * 0.35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StepButton(
                text: "Previous".tr,
                // leading: Icons.chevron_left,
                onTap: () {
                  _.pageNumber.value = 0;
                  controller.animateToPage(_.pageNumber.value, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                },
                backgroundColor: kQuantumGrey,
                fontColor: Colors.white,
              ),
              StepButton(
                text: "Next".tr,
                // trailing: Icons.chevron_right,
                onTap: () {
                  _.pageNumber.value = 2;
                  controller.animateToPage(_.pageNumber.value, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
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
                  padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.02),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(verticalSize * 0.03)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: verticalSize * 0.05),
                          child: const Image(image: AssetImage('assets/imgs/logo_ottaa.webp')),
                        ),
                        GFButton(
                          onPressed: () => Get.toNamed(AppRoutes.kTutorial),
                          text: "Launch_short_tutorial".tr,
                          textColor: Colors.white,
                          disabledTextColor: Colors.grey,
                          color: kOTTAAOrange,
                          disabledColor: kQuantumGrey,
                          shape: GFButtonShape.pills,
                          size: verticalSize * 0.07,
                          blockButton: true,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: verticalSize * 0.07),
                          child: GFButton(
                            textColor: Colors.white,
                            disabledTextColor: Colors.grey,
                            color: kOTTAAOrange,
                            disabledColor: kQuantumGrey,
                            onPressed: null,
                            text: "Do_a_guided_workshop".tr,
                            shape: GFButtonShape.pills,
                            size: verticalSize * 0.07,
                            blockButton: true,
                          ),
                        ),
                        GFButton(
                          onPressed: null,
                          text: "Book_a_demo".tr,
                          textColor: Colors.white,
                          disabledTextColor: Colors.grey,
                          color: kOTTAAOrange,
                          disabledColor: kQuantumGrey,
                          shape: GFButtonShape.pills,
                          size: verticalSize * 0.07,
                          blockButton: true,
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
            SizedBox(
              width: horizontalSize * 0.45,
              child: Text(
                'Ottaa_is_a_powerful_communication_tool'.tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
            ),
            SizedBox(
              height: verticalSize * 0.02,
            ),
            SizedBox(
              width: horizontalSize * 0.45,
              child: AutoSizeText(
                'te_ofrecemos_varias_opciones_para_naprender_a_utilizarla_y_sacarle_el_maximo_provecho'.tr,
                style: const TextStyle(color: Colors.white),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
