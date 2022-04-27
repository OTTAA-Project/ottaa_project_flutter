import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/games/games_controller.dart';
import 'package:ottaa_project_flutter/app/modules/games/games_playing_page.dart';
import 'package:ottaa_project_flutter/app/modules/games/local_widgets/page_viewer_widget/page_viewer_widget.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class GrupoSelectionPage extends GetView<GamesController> {
  const GrupoSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double horizontalSize = MediaQuery.of(context).size.width;
    double verticalSize = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: kOTTAAOrangeNew,
        leading: Container(),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text('Select a category to play'),
      ),
      body: Stack(
        children: [
          PageViewerWidget(
            verticalSize: verticalSize,
            horizontalSize: horizontalSize,
            gameSelectionOrGruposSelection: false,
            nextButton: () {
              controller.goToNextPage(
                  pageController: controller.grupoPageController);
            },
            previousButton: () {
              controller.goToPreviousPage(
                  pageController: controller.grupoPageController);
            },
            pageControllerGame: controller.initialGamePageController,
            pageControllerGrupo: controller.grupoPageController,
            centerButton: () {
              controller.grupoSelectedIndex =
                  controller.grupoPageController.page!.toInt();
              //todo: do some work here for games before going to the actual playing
              controller.startGameTimer();
              Get.to(() => GamesPlayingPage());
            },
            color: kOTTAAOrangeNew,
            onTap: () {
              controller.grupoSelectedIndex =
                  controller.grupoPageController.page!.toInt();
              //todo: do some work here for games before going to the actual playing
              controller.startGameTimer();
              Get.to(() => GamesPlayingPage());
            },
            grupos: controller.grupos,
            language: controller.language,
          ),
          Positioned(
            bottom: verticalSize * 0.01,
            left: horizontalSize * 0.3,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(verticalSize * 0.01),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(verticalSize * 0.1),
                ),
                child: Icon(
                  Icons.close,
                  color: kOTTAAOrangeNew,
                  size: verticalSize * 0.08,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
