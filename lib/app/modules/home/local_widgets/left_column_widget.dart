import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';

class LeftColumnWidget extends StatelessWidget {
  LeftColumnWidget({Key? key}) : super(key: key);
  final _homeController = Get.find<HomeController>();

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
          FittedBox(
            child: GestureDetector(
              onTap: null,
              child: Center(
                  child: Icon(
                // Icons.gamepad,
                Icons.gamepad,
                color: Colors.white,
                size: horizontalSize / 10,
              )),
            ),
          ),
          FittedBox(
            child: GestureDetector(
              onTap: () {
                if (_homeController.sentencePicts.isEmpty) {
                  Get.toNamed(AppRoutes.PICTOGRAMGROUP);
                } else {
                  if (_homeController.sentencePicts.last.texto.es ==
                      "agregar") {
                    Get.toNamed(AppRoutes.PICTOGRAMGROUP);
                  } else {
                    _homeController.toId =
                        _homeController.sentencePicts.last.id;
                    _homeController.fromAdd = true;
                    Get.toNamed(AppRoutes.PICTOGRAMGROUP);
                  }
                }
              },
              child: Center(
                child: Icon(
                  Icons.image,
                  color: Colors.white,
                  size: horizontalSize / 10,
                ),
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: kOTTAOrangeNew,
        borderRadius:
            BorderRadius.only(topRight: Radius.circular(horizontalSize / 40)),
      ),
    );
  }
}
