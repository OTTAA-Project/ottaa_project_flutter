import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/empty_text_dialog_widget.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/sentence_share_widget.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:ottaa_project_flutter/app/utils/CustomAnalytics.dart';

class RightColumnWidget extends GetView<HomeController> {
  RightColumnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return Container(
      height: verticalSize * 0.5,
      width: horizontalSize * 0.10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          /*FittedBox(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.CONFIGURATION);
              },
              child: Center(
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: horizontalSize / 10,
                ),
              ),
            ),
          ),*/
          FittedBox(
            child: GestureDetector(
              onTap: () async {
                // controller.ttsController
                CustomAnalyticsEvents.setEventWithParameters(
                  "Touch",
                  CustomAnalyticsEvents.createMyMap(
                      'Principal', "Share Phrases"),
                );
                controller.sentencePicts.length == 0
                    ? showDialog(
                        context: context,
                        barrierDismissible: false,
                        barrierColor: Colors.transparent,
                        builder: (context) {
                          return EmptyTextDialogWidget();
                        },
                      )
                    : showDialog(
                        context: context,
                        builder: (context) {
                          return SentenceShareWidget();
                        },
                      );
                if(controller.sentencePicts.length == 0){
                  await controller.startTimerForDialogeExit();
                }
              },
              child: Center(
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                  size: horizontalSize / 10,
                ),
              ),
            ),
          ),
          FittedBox(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.SENTENCES);
                CustomAnalyticsEvents.setEventWithParameters(
                    "Touch",
                    CustomAnalyticsEvents.createMyMap(
                        'Principal', "Favourite Phrases"));
              },
              child: Center(
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: horizontalSize / 10,
                ),
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: kOTTAAOrangeNew,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(horizontalSize / 40),
        ),
      ),
    );
  }
}
