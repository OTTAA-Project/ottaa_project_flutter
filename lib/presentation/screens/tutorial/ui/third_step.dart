import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';

class ThirdStep extends StatelessWidget {
  final PageController controller;

  const ThirdStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: verticalSize * 0.45,
            child: FittedBox(
              child: Image.asset(
                AppImages.kStep3Tutorial,
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
                    "Access_thousands_of_pictograms".trl,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.2),
                child: Text(
                  'Step3_long'.trl,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
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
              SimpleButton(
                text: "Previous".trl,
                leading: Icons.chevron_left,
                onTap: () => controller.animateToPage(1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut),
                backgroundColor: Colors.white,
                fontColor: Colors.grey,
              ),
              SimpleButton(
                text: "Next".trl,
                trailing: Icons.chevron_right,
                onTap: () => controller.animateToPage(3,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut),
                backgroundColor: Colors.white,
                fontColor: kOTTAAOrangeNew,
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
}
