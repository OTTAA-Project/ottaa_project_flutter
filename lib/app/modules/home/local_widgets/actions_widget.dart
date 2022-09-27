import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import '../../../utils/CustomAnalytics.dart';

class ActionsWidget extends StatelessWidget {
  const ActionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double horizontalSize = MediaQuery.of(context).size.width;
    double verticalSize = MediaQuery.of(context).size.height;
    return GetBuilder<HomeController>(builder: (_) {
      return Container(
        width: horizontalSize * 0.8,
        color: kOTTAAOrangeNew,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: verticalSize * 0.04),
              child: GestureDetector(
                onTap: () {
                  CustomAnalyticsEvents.setEventWithParameters(
                    "Touch",
                    CustomAnalyticsEvents.createMyMap('name', 'More Options'),
                  );
                  _.moreSuggested();
                },
                child: Center(
                  child: Icon(
                    Icons.menu_sharp,
                    color: Colors.white,
                    size: horizontalSize / 10,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(),
            SizedBox(width: 10),
            Padding(
              padding: EdgeInsets.only(top: verticalSize * 0.045),
              child: GestureDetector(
                onLongPress: () {
                  _.removeWholeSentence();
                },
                onTap: () {
                  _.removePictFromSentence();
                  CustomAnalyticsEvents.setEventWithParameters(
                    "Touch",
                    CustomAnalyticsEvents.createMyMap('name', 'Erase'),
                  );
                },
                child: Center(
                  child: Icon(
                    Icons.backspace_rounded,
                    color: Colors.white,
                    size: horizontalSize / 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
