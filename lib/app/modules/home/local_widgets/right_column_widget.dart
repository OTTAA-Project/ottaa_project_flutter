import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';

class RightColumnWidget extends StatelessWidget {
  const RightColumnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return Container(
      height: verticalSize * 0.75,
      width: horizontalSize * 0.10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FittedBox(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.CONFIGURATION);
              },
              child: Center(
                  child: Icon(
                Icons.settings,
                color: Colors.white,
                size: horizontalSize / 10,
              )),
            ),
          ),
          FittedBox(
            child: GestureDetector(
              onTap: null,
              child: Center(
                  child: Icon(
                Icons.share,
                color: Colors.white,
                size: horizontalSize / 10,
              )),
            ),
          ),
          FittedBox(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.SENTENCES);
              },
              child: Center(
                  child: Icon(
                Icons.favorite,
                color: Colors.white,
                size: horizontalSize / 10,
              )),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius:
            BorderRadius.only(topLeft: Radius.circular(horizontalSize / 40)),
      ),
    );
  }
}
