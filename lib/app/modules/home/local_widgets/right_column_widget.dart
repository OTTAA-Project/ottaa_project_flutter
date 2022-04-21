import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:ottaa_project_flutter/app/utils/CustomAnalytics.dart';

class RightColumnWidget extends StatelessWidget {
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
                Fluttertoast.showToast(
                  msg: "we_are_working_on_this_feature".tr,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: verticalSize * 0.03,
                );
                CustomAnalyticsEvents.setEventWithParameters(
                    "Touch",
                    CustomAnalyticsEvents.createMyMap(
                        'Principal', "Share Phrases"));
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
