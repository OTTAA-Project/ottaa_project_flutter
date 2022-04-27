import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/modules/games/local_widgets/game_model_data.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';

class GamesController extends GetxController {
  /// Game Types Data
  List<GameModelData> gameTypes = [
    GameModelData(
        subtitle:
            'Answer hte questions by choosing the right pictogram.\nLearn by playing!',
        completedNumber: 0,
        totalLevel: 45,
        title: 'Whats the picto?',
      imageAsset: 'assets/games_images/whats_picto.png',
    ),
    GameModelData(
      title: 'Match pictos',
      totalLevel: 45,
      completedNumber: 0,
      subtitle: 'Attach the pictogram correctly',
      imageAsset: 'assets/games_images/match_picto.png',
    ),
    GameModelData(
      title: 'Memory game',
      completedNumber: 0,
      totalLevel: 45,
      subtitle: 'Test your memory',
      imageAsset: 'assets/games_images/memory_game.png',
    ),
  ];
  final _homeController = Get.find<HomeController>();
  List<Grupos> grupos = [];
  int gameSelected = -1;
  int grupoSelectedIndex = -1;
  late String language;

  final initialGamePageController = PageController(initialPage: 0);
  final grupoPageController = PageController(initialPage: 0);

  void goToNextPage({required PageController pageController}) {
    pageController.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void goToPreviousPage({required PageController pageController}) {
    pageController.previousPage(
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    grupos.addAll(_homeController.grupos);
    language = _homeController.language;
    super.onReady();
  }
}
