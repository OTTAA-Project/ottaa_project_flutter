import 'dart:async';

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
          'Answer the questions by choosing the right pictogram.\nLearn by playing!',
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
  RxInt gameSelected = 0.obs;
  int grupoSelectedIndex = -1;
  late String language;
  RxBool muteOrNot = false.obs;
  RxBool helpOrNot = false.obs;
  RxInt correctScore = 0.obs;
  RxInt incorrectScore = 0.obs;
  RxInt timeInSeconds = 0.obs;
  RxInt maximumStreak = 0.obs;
  late Timer _gameStartTimer,hintTimer;
  List<RxBool> imageOrEmoji  = [true.obs,true.obs,true.obs,true.obs];
  List<RxString> selectedAnswer = [''.obs,''.obs,''.obs,''.obs];

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
  void dispose() {
    super.dispose();
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

  void startGameTimer() {
    _gameStartTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      timeInSeconds.value = timeInSeconds.value + 1;
    });
  }

  void cancelTimer() {
    _gameStartTimer.cancel();
    timeInSeconds.value = 0;
    print('time cancel called');
  }
}
