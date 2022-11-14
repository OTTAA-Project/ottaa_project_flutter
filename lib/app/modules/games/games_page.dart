import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/about/about_ottaa_page.dart';
import 'package:ottaa_project_flutter/app/modules/games/games_controller.dart';
import 'package:ottaa_project_flutter/app/modules/games/grupo_selection_page.dart';
import 'package:ottaa_project_flutter/app/modules/games/local_widgets/page_viewer_widget/page_viewer_widget.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class GamesPage extends GetView<GamesController> {
  const GamesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double horizontalSize = MediaQuery.of(context).size.width;
    double verticalSize = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          RotatedBox(
            quarterTurns: 4,
            child: HeaderWave(
              color: kOTTAAOrangeNew,
              bgColor: Colors.black,
            ),
          ),

          ///close button
          Positioned(
            left: horizontalSize * 0.02,
            top: verticalSize * 0.05,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(verticalSize * 0.01),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(verticalSize * 0.04),
                ),
                child: Container(
                  padding: EdgeInsets.all(verticalSize * 0.01),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      verticalSize * 0.04,
                    ),
                  ),
                  child: Icon(
                    Icons.close,
                    color: kOTTAAOrangeNew,
                    size: verticalSize * 0.04,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: verticalSize,
              width: horizontalSize * 0.6,
              child: PageViewerWidget(
                gameTypes: controller.gameTypes,
                verticalSize: verticalSize,
                horizontalSize: horizontalSize * 0.6,
                gameSelectionOrGruposSelection: true,
                centerButton: () {
                  controller.gameSelected.value =
                      controller.initialGamePageController.page!.toInt();
                  Get.to(() => GrupoSelectionPage());
                  // print(controller.initialGamePageController.page);
                },
                nextButton: () => controller.goToNextPage(
                    pageController: controller.initialGamePageController),
                pageControllerGame: controller.initialGamePageController,
                pageControllerGrupo: controller.initialGamePageController,
                previousButton: () => controller.goToPreviousPage(
                    pageController: controller.initialGamePageController),
                color: kOTTAAOrangeNew,
                onTap: () {
                  controller.gameSelected.value =
                      controller.initialGamePageController.page!.toInt();
                  Get.to(() => GrupoSelectionPage());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
