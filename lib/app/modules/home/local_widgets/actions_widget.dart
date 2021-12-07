import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class ActionsWidget extends StatelessWidget {
  const ActionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return GetBuilder<HomeController>(builder: (_) {
      return Container(
        height: verticalSize * 0.2,
        width: horizontalSize * 0.8,
        color: kOTTAOrangeNew,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              child: GestureDetector(
                onTap: () {
                  _.moreSuggested();
                },
                child: Center(
                    child: Icon(
                  Icons.menu_sharp,
                  color: Colors.white,
                  size: horizontalSize / 10,
                )),
              ),
            ),
            SizedBox(width: 10),
            FittedBox(
              child: GestureDetector(
                onTap: () {
                  _.speak();
                },
                child: Center(
                    child: Icon(
                  Icons.surround_sound_rounded,
                  color: Colors.white,
                  size: horizontalSize / 10,
                )),
              ),
            ),
            SizedBox(width: 10),
            FittedBox(
              child: GestureDetector(
                onTap: () {
                  _.removePictFromSentence();
                },
                child: Center(
                    child: Icon(
                  Icons.backspace,
                  color: Colors.white,
                  size: horizontalSize / 10,
                )),
              ),
            ),
          ],
        ),
      );
    });
  }
}
