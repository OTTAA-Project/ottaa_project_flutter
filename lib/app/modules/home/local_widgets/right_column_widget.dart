import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/empty_text_dialog_widget.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/sentence_share_widget.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:ottaa_project_flutter/app/utils/custom_analytics.dart';

class RightColumnWidget extends GetView<HomeController> {
  const RightColumnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return Container(
      height: verticalSize * 0.5,
      width: horizontalSize * 0.10,
      decoration: const BoxDecoration(
        color: kOTTAAOrangeNew,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
        ),
      ),
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
                  CustomAnalyticsEvents.createMyMap('Principal', "Share Phrases"),
                );
                controller.sentencePicts.isEmpty
                    ? showDialog(
                        context: context,
                        barrierDismissible: false,
                        barrierColor: Colors.transparent,
                        builder: (context) {
                          return const EmptyTextDialogWidget();
                        },
                      )
                    : showDialog(
                        context: context,
                        builder: (context) {
                          return const SentenceShareWidget();
                        },
                      );
                if (controller.sentencePicts.isEmpty) {
                  await controller.startTimerForDialogueExit();
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
                Get.toNamed(AppRoutes.kSentences);
                CustomAnalyticsEvents.setEventWithParameters("Touch", CustomAnalyticsEvents.createMyMap('Principal', "Favourite Phrases"));
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
    );
  }
}
