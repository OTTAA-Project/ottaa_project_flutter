import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/presentation/tutorial/local_widgets/step_button.dart';

Widget step1Tutorial<widget>(PageController controller, context) {
  double verticalSize = MediaQuery.of(context).size.height;
  double horizontalSize = MediaQuery.of(context).size.width;
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
          width: horizontalSize*0.20,
          child: Image.asset(
            AppImages.kStep1Tutorial,
            fit: BoxFit.fill,
          ),
        ),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              height: horizontalSize * 0.05, // TODO WIDTH
              child: FittedBox(
                child: Text(
                  "Create_your_phrase".trl,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.2),
              child: Text(
                "${'step1_long'.trl}.",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
                maxLines: 4,
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(),
        ),
        StepButton(
          text: "Next".trl,
          trailing: Icons.chevron_right,
          onTap: () => controller.animateToPage(1,
              duration: const Duration(
                milliseconds: 300,
              ),
              curve: Curves.easeInOut),
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
