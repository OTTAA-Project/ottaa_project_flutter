import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ottaa_project_flutter/app/global_widgets/step_button.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:get/get.dart';

Widget step1Tutorial<widget>(PageController controller, context) {
  double verticalSize = MediaQuery.of(context).size.height;
  double horizontalSize = MediaQuery.of(context).size.width;
  print(verticalSize);
  print(horizontalSize);
  return Container(
    color: kOTTAAOrangeNew,
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
                'assets/Group 729.svg',
                placeholderBuilder: (BuildContext context) =>
                    Container(child: const CircularProgressIndicator()),
              ),
              fit: BoxFit.cover),
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              height: horizontalSize * 0.05, // TODO WIDTH
              child: FittedBox(
                child: Text(
                  "Create_your_phrase".tr,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.2),
              child: Text(
                "${'step1_long'.tr}.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                maxLines: 4,
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(),
        ),
        StepButton(
          text: "Next".tr,
          trailing: Icons.chevron_right,
          onTap: () => controller.animateToPage(1,
              duration: Duration(milliseconds: 300), curve: Curves.easeInOut),
          backgroundColor: Colors.white,
          fontColor: kOTTAAOrangeNew,
        ),
        Expanded(
          child: Container(),
        ),
      ],
    ),
  );
}
