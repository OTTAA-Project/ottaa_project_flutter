import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/presentation/tutorial/local_widgets/step_button.dart';

Widget step2Tutorial<widget>(PageController controller, context) {
  double verticalSize = MediaQuery.of(context).size.height;
  double horizontalSize = MediaQuery.of(context).size.width;
  return Container(
    color: kQuantumGrey,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(),
        ),
        SizedBox(
          height: verticalSize * 0.45,
          child: FittedBox(
            child: Image.asset(
              AppImages.kStep2Tutorial,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              height: horizontalSize * 0.05,
              child: FittedBox(
                child: Text(
                  "Talk_to_the_world".trl,
                  style: const TextStyle(
                      color: kOTTAAOrangeNew, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.2),
              child: Text(
                "${'step2_long'.trl}.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, color: Colors.black87),
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
              text: "Previous".trl,
              leading: Icons.chevron_left,
              onTap: () => controller.animateToPage(0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut),
              backgroundColor: Colors.white,
              fontColor: Colors.grey,
            ),
            StepButton(
              text: "Next".trl,
              trailing: Icons.chevron_right,
              onTap: () => controller.animateToPage(2,
                  duration: const Duration(
                    milliseconds: 300,
                  ),
                  curve: Curves.easeInOut),
              backgroundColor: kOTTAAOrangeNew,
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
