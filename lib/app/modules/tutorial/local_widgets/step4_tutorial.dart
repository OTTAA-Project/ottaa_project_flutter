import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ottaa_project_flutter/app/global_widgets/step_button.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:get/get.dart';

step4Tutorial<widget>(PageController controller, context) {
  double verticalSize = MediaQuery.of(context).size.height;
  double horizontalSize = MediaQuery.of(context).size.width;
  return Container(
    color: Colors.grey.withOpacity(0.5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(),
        ),
        Container(
          height: verticalSize * 0.45,
          child: FittedBox(
            child: SvgPicture.asset(
              'assets/Group 727.svg',
              placeholderBuilder: (BuildContext context) =>
                  Container(child: const CircularProgressIndicator()),
            ),
          ),
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              height: horizontalSize * 0.05,
              child: FittedBox(
                child: Text(
                  "Play_and_learn".tr,
                  style: GoogleFonts.montserratAlternates(
                      color: kOTTAOrange, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.2),
              child: AutoSizeText(
                "${'Step4_long'.tr}!.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserratAlternates(
                    fontSize: 20, color: Colors.black87),
                maxLines: 3,
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StepButton(
              text: "Previous".tr,
              leading: Icons.chevron_left,
              onTap: () => controller.animateToPage(2,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut),
              backgroundColor: Colors.white,
              fontColor: Colors.grey,
            ),
            StepButton(
              text: "Ready".tr,
              trailing: Icons.chevron_right,
              onTap: () => Get.toNamed(AppRoutes.HOME),
              backgroundColor: kOTTAOrange,
              fontColor: Colors.white,
            ),
          ],
        ),
        Expanded(
          child: Container(),
        ),
      ],
    ),
  );
}
