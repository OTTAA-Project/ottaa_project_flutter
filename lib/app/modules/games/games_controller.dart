// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ottaa_project_flutter/app/data/models/game_data_model.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/models/game_question_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/games/local_widgets/game_model_data.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/games/games_playing_page.dart';

class GamesController extends GetxController {
  /// Game Types Data
  List<GameModelData> gameTypes = [
    GameModelData(
      subtitle: 'game1'.tr,
      completedNumber: 0,
      totalLevel: 45,
      title: 'whats_the_picto'.tr,
      imageAsset: 'assets/games_images/whats_picto.png',
    ),
    GameModelData(
      title: 'match_picto'.tr,
      totalLevel: 45,
      completedNumber: 0,
      subtitle: 'game2'.tr,
      imageAsset: 'assets/games_images/match_picto.png',
    ),
    GameModelData(
      title: 'memory_game'.tr,
      completedNumber: 0,
      totalLevel: 45,
      subtitle: 'game3'.tr,
      imageAsset: 'assets/games_images/memory_game.png',
    ),
  ];
  final Map<int, double> leftRatios = {
    /// postions for the pictos to move
    0: 0.05,
    1: 0.28,
    2: 0.51,
    3: 0.74,
  };
  RxList<GameQuestionModel> questions = <GameQuestionModel>[].obs;
  final AudioPlayer backgroundMusicPlayer = AudioPlayer();
  final AudioPlayer clicksPlayer = AudioPlayer();
  final homeController = Get.find<HomeController>();
  final _ttsController = Get.find<TTSController>();
  List<Grupos> grupos = [];
  List<Pict> pictos = [];
  List<Pict> currentGrupoPicts = [];
  RxInt gameSelected = 0.obs;
  RxBool changeViewForListview = true.obs;
  int tries = 0;
  int startTimeInEpoch = 0;
  int previousIndexMatchPicto = -1;

  /// 0 = easy, 1 = medium, 2 = hard///
  RxInt difficultyLevel = 2.obs;
  int grupoSelectedIndex = -1;

  // hack for match picto
  int sameOrNotIndex = -1;

  late GameData gameData;

  // late String language;
  RxBool muteOrNot = false.obs;
  RxBool helpOrNot = false.obs;
  RxInt correctScore = 0.obs;
  RxInt incorrectScore = 0.obs;
  RxInt timeInSeconds = 0.obs;
  RxInt currentStreak = 0.obs;
  RxInt maximumStreak = 0.obs;
  late Timer _gameStartTimer, hintTimer;
  List<RxBool> imageOrEmoji = [true.obs, true.obs, true.obs, true.obs];
  RxString selectedAnswer = ''.obs;
  RxString selectedAnswerBottom = ''.obs;
  List<RxString> bottomWidgetNames = [''.obs, ''.obs, ''.obs, ''.obs];
  RxString selectedImage = ''.obs;
  RxBool showImage = false.obs;
  List<RxBool> topOrBottom = [true.obs, true.obs, true.obs, true.obs];
  List<RxInt> randomPositionsForBottomWidgets = [8.obs, 8.obs, 8.obs, 8.obs];
  List<bool> selectedOrNot = [false, false, false, false];
  int totalCorrectMatchPicto = 0;
  List<RxInt> positions = [
    0.obs,
    0.obs,
    0.obs,
    0.obs,
    0.obs,
    0.obs,
    0.obs,
    0.obs,
  ];
  List<RxBool> showOrHideMemoryGame = [
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
  ];
  RxString first = ''.obs;
  RxString second = ''.obs;
  RxInt firstIndex = 99.obs;
  RxInt secondIndex = 99.obs;
  int totalCorrectMemoryGame = 0;
  final initialGamePageController = PageController(initialPage: 0);
  final grupoPageController = PageController(initialPage: 0);

  void goToNextPage({required PageController pageController}) {
    pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void goToPreviousPage({required PageController pageController}) {
    pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  void dispose() async {
    super.dispose();
    await backgroundMusicPlayer.dispose();
  }

  @override
  void onInit() async {
    super.onInit();
    await initializeBackgroundMusic();
  }

  Future<void> initializeBackgroundMusic() async {
    ///check if we can buffer the audios before even loading the properties of the given class
    // backgroundMusicPlayer.setAudioSource();
    await backgroundMusicPlayer.setAsset('assets/audios/funckygroove.mp3');
    await backgroundMusicPlayer.setLoopMode(LoopMode.one);
    backgroundMusicPlayer.setVolume(0.5);
  }

  @override
  void onReady() {
    grupos.addAll(homeController.grupos);
    pictos.addAll(homeController.picts);
    super.onReady();
  }

  void startGameTimer() {
    startTimeInEpoch = DateTime.now().millisecondsSinceEpoch;
    _gameStartTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      timeInSeconds.value = timeInSeconds.value + 1;
    });
  }

  void cancelTimer() {
    _gameStartTimer.cancel();
    timeInSeconds.value = 0;
    print('time cancel called');
  }

  Future<void> pictoFunctionWhatsThePicto({required int index}) async {
    final bool correctOrNot = questions[index].text.toLowerCase() == selectedAnswer.toLowerCase();
    imageOrEmoji[index].value = !imageOrEmoji[index].value;
    if (correctOrNot) {
      showImage.value = !showImage.value;
      await playClickSounds(assetName: 'yay');
    } else {
      await playClickSounds(assetName: 'ohoh');
    }
    await Future.delayed(
      const Duration(milliseconds: 1000),
    );
    imageOrEmoji[index].value = !imageOrEmoji[index].value;
    if (correctOrNot) {
      showImage.value = !showImage.value;
      await Future.delayed(const Duration(milliseconds: 500));

      /// change the question and increment to the correct one and streak if it is there
      await createQuestion();
      correctScore.value++;
      currentStreak++;
      if (currentStreak.value > maximumStreak.value) {
        maximumStreak.value++;
      }
      if (currentStreak.value == 20) {
        difficultyLevel.value = 1;
        changeViewForListview.value = changeViewForListview.value;
        changeViewForListview.value = changeViewForListview.value;
      }
      if (currentStreak.value == 40) {
        difficultyLevel.value = 2;
        changeViewForListview.value = changeViewForListview.value;
        changeViewForListview.value = changeViewForListview.value;
      }
      // controller.changeViewForListview.value = !controller.changeViewForListview.value;
      // controller.changeViewForListview.value = !controller.changeViewForListview.value;
    } else {
      /// just delete the streak and increment to the false one...
      incorrectScore.value++;
      currentStreak.value = 0;
      difficultyLevel.value = 2;
      changeViewForListview.value = changeViewForListview.value;
      changeViewForListview.value = changeViewForListview.value;
    }
  }

  Future<void> createQuestion() async {
    /// check difficulty level
    /// which is checked by the streak of correct answers
    if (gameSelected.value == 1) {
      topOrBottom = [true.obs, true.obs, true.obs, true.obs];
      randomPositionsForBottomWidgets = [8.obs, 8.obs, 8.obs, 8.obs];
      selectedOrNot = [false, false, false, false];
      totalCorrectMatchPicto = 0;
      selectedAnswer.value = '';
    }
    if (difficultyLevel.value == 0) {
      ///easy difficulty
      int picto1 = random(0, currentGrupoPicts.length);
      int picto2 = random(0, currentGrupoPicts.length);
      while (picto1 == picto2) {
        picto1 = random(0, currentGrupoPicts.length);
      }
      if (gameSelected.value == 2) {
        totalCorrectMemoryGame = 0;
        first.value = '';
        second.value = '';
        firstIndex.value = 99;
        secondIndex.value = 99;
        showOrHideMemoryGame = [
          false.obs,
          false.obs,
          false.obs,
          false.obs,
          false.obs,
          false.obs,
          false.obs,
          false.obs,
        ];
      }
      print('the values are here');
      print(picto1);
      print(picto2);
      questions.clear();
      questions.add(
        GameQuestionModel(
          id: picto1,
          imageUrl: currentGrupoPicts[picto1].imagen.pictoEditado == null ? currentGrupoPicts[picto1].imagen.picto : currentGrupoPicts[picto1].imagen.pictoEditado!,
          text: homeController.language.toLowerCase() == 'en'.toLowerCase() ? currentGrupoPicts[picto1].texto.en : currentGrupoPicts[picto1].texto.es,
        ),
      );
      questions.add(
        GameQuestionModel(
          id: picto2,
          imageUrl: currentGrupoPicts[picto2].imagen.pictoEditado == null ? currentGrupoPicts[picto2].imagen.picto : currentGrupoPicts[picto2].imagen.pictoEditado!,
          text: homeController.language.toLowerCase() == 'en'.toLowerCase() ? currentGrupoPicts[picto2].texto.en : currentGrupoPicts[picto2].texto.es,
        ),
      );
      await clicksPlayer.pause();
      if (gameSelected.value == 0) {
        int correctAnswer = DateTime.now().microsecondsSinceEpoch % 2;
        selectedAnswer.value = questions[correctAnswer].text;
        selectedImage.value = questions[correctAnswer].imageUrl;
        speakNameWhatsThePicto();
      }
      if (gameSelected.value == 1) {
        await generateRandomPositioningForMatchPictos();
      }
      if (gameSelected.value == 2) {
        await generateRandomPositionsForMemoryGame();
      }
    } else if (difficultyLevel.value == 1) {
      ///medium difficulty
      int picto1 = random(0, currentGrupoPicts.length);
      int picto2 = random(0, currentGrupoPicts.length);
      int picto3 = random(0, currentGrupoPicts.length);
      while (picto1 == picto2) {
        picto1 = random(0, currentGrupoPicts.length);
      }
      while (picto3 == picto1 || picto3 == picto2) {
        picto3 = random(0, currentGrupoPicts.length);
      }
      questions.clear();
      questions.add(
        GameQuestionModel(
          id: picto1,
          imageUrl: currentGrupoPicts[picto1].imagen.pictoEditado == null ? currentGrupoPicts[picto1].imagen.picto : currentGrupoPicts[picto1].imagen.pictoEditado!,
          text: homeController.language.toLowerCase() == 'en'.toLowerCase() ? currentGrupoPicts[picto1].texto.en : currentGrupoPicts[picto1].texto.es,
        ),
      );
      questions.add(
        GameQuestionModel(
          id: picto2,
          imageUrl: currentGrupoPicts[picto2].imagen.pictoEditado == null ? currentGrupoPicts[picto2].imagen.picto : currentGrupoPicts[picto2].imagen.pictoEditado!,
          text: homeController.language.toLowerCase() == 'en'.toLowerCase() ? currentGrupoPicts[picto2].texto.en : currentGrupoPicts[picto2].texto.es,
        ),
      );
      questions.add(
        GameQuestionModel(
          id: picto2,
          imageUrl: currentGrupoPicts[picto3].imagen.pictoEditado == null ? currentGrupoPicts[picto3].imagen.picto : currentGrupoPicts[picto3].imagen.pictoEditado!,
          text: homeController.language.toLowerCase() == 'en'.toLowerCase() ? currentGrupoPicts[picto3].texto.en : currentGrupoPicts[picto3].texto.es,
        ),
      );
      await clicksPlayer.pause();
      if (gameSelected.value == 0) {
        int correctAnswer = DateTime.now().microsecondsSinceEpoch % 3;
        selectedAnswer.value = questions[correctAnswer].text;
        selectedImage.value = questions[correctAnswer].imageUrl;
        speakNameWhatsThePicto();
      }
      if (gameSelected.value == 1) {
        await generateRandomPositioningForMatchPictos();
      }
      if (gameSelected.value == 2) {
        await generateRandomPositionsForMemoryGame();
      }
    } else {
      ///hard difficulty
      int picto1 = random(0, currentGrupoPicts.length);
      int picto2 = random(0, currentGrupoPicts.length);
      int picto3 = random(0, currentGrupoPicts.length);
      int picto4 = random(0, currentGrupoPicts.length);
      while (picto1 == picto2) {
        picto1 = random(0, currentGrupoPicts.length);
      }
      while (picto3 == picto1 || picto3 == picto2) {
        picto3 = random(0, currentGrupoPicts.length);
      }
      while (picto4 == picto1 || picto4 == picto2 || picto4 == picto3) {
        picto4 = random(0, currentGrupoPicts.length);
      }
      questions.clear();
      questions.add(
        GameQuestionModel(
          id: picto1,
          imageUrl: currentGrupoPicts[picto1].imagen.pictoEditado == null ? currentGrupoPicts[picto1].imagen.picto : currentGrupoPicts[picto1].imagen.pictoEditado!,
          text: homeController.language.toLowerCase() == 'en'.toLowerCase() ? currentGrupoPicts[picto1].texto.en : currentGrupoPicts[picto1].texto.es,
        ),
      );
      questions.add(
        GameQuestionModel(
          id: picto2,
          imageUrl: currentGrupoPicts[picto2].imagen.pictoEditado == null ? currentGrupoPicts[picto2].imagen.picto : currentGrupoPicts[picto2].imagen.pictoEditado!,
          text: homeController.language.toLowerCase() == 'en'.toLowerCase() ? currentGrupoPicts[picto2].texto.en : currentGrupoPicts[picto2].texto.es,
        ),
      );
      questions.add(
        GameQuestionModel(
          id: picto3,
          imageUrl: currentGrupoPicts[picto3].imagen.pictoEditado == null ? currentGrupoPicts[picto3].imagen.picto : currentGrupoPicts[picto3].imagen.pictoEditado!,
          text: homeController.language.toLowerCase() == 'en'.toLowerCase() ? currentGrupoPicts[picto3].texto.en : currentGrupoPicts[picto3].texto.es,
        ),
      );
      questions.add(
        GameQuestionModel(
          id: picto4,
          imageUrl: currentGrupoPicts[picto4].imagen.pictoEditado == null ? currentGrupoPicts[picto4].imagen.picto : currentGrupoPicts[picto4].imagen.pictoEditado!,
          text: homeController.language.toLowerCase() == 'en'.toLowerCase() ? currentGrupoPicts[picto4].texto.en : currentGrupoPicts[picto4].texto.es,
        ),
      );
      await clicksPlayer.pause();
      if (gameSelected.value == 0) {
        int correctAnswer = DateTime.now().microsecondsSinceEpoch % 4;
        selectedAnswer.value = questions[correctAnswer].text;
        selectedImage.value = questions[correctAnswer].imageUrl;
        speakNameWhatsThePicto();
      }
      if (gameSelected.value == 1) {
        await generateRandomPositioningForMatchPictos();
      }
      if (gameSelected.value == 2) {
        await generateRandomPositionsForMemoryGame();
      }
    }
  }

  void fetchPictosForCurrentGrupo() async {
    currentGrupoPicts = [];
    for (int i = 0; i < grupos[grupoSelectedIndex].relacion.length; i++) {
      for (var element in pictos) {
        if (element.id == grupos[grupoSelectedIndex].relacion[i].id) {
          currentGrupoPicts.add(element);
        }
      }
    }
  }

  Future<void> playClickSounds({required String assetName}) async {
    await clicksPlayer.setAsset('assets/audios/$assetName.mp3');
    print('playing');
    await clicksPlayer.play();
  }

  static int random(min, max) {
    return min + Random().nextInt(max - min);
  }

  Future<void> selectingGrupoFunction() async {
    grupoSelectedIndex = grupoPageController.page!.toInt();
    //todo: do some work here for games before going to the actual playing
    startGameTimer();
    backgroundMusicPlayer.play();
    muteOrNot.value = false;
    // await controller.initializeBackgroundMusic();
    fetchPictosForCurrentGrupo();
    await createQuestion();
    Get.to(() => const GamesPlayingPage());
  }

  Future<void> pauseMusic() async {
    await backgroundMusicPlayer.pause();
  }

  void speakNameWhatsThePicto() async {
    await _ttsController.speak('${'whats_the_picto'.tr} ${selectedAnswer.string}');
    print('${'whats_the_picto'.tr} ${selectedAnswer.string}');
  }

  Future<void> topWidgetFunction({
    required int index,
    required BuildContext context,
    required String text,
  }) async {
    selectedAnswer.value = text;
    _ttsController.speak(text);
    if (selectedOrNot[index]) {
      sameOrNotIndex = index;

      /// it is selected for checking user clicked on the below question
      if (selectedAnswer.value == selectedAnswerBottom.value) {
        await playClickSounds(assetName: 'yay');
        showTheDialog(context);
        totalCorrectMatchPicto++;
        topOrBottom[index].value = !topOrBottom[index].value;
        print('the index is $index and the value is $selectedAnswer');
        await Future.delayed(const Duration(milliseconds: 500));
        Get.back();
        correctScore.value++;
        if (currentStreak.value >= 0) {
          if (maximumStreak.value == currentStreak.value) {
            maximumStreak.value++;
          }
          currentStreak.value++;
        }
      } else {
        showTheDialog(context);
        await playClickSounds(assetName: 'ohoh');
        await Future.delayed(const Duration(milliseconds: 500));
        Get.back();
        selectedOrNot[index] = false;
        selectedAnswerBottom.value = '';
        selectedAnswer.value = '';
        incorrectScore.value++;
        currentStreak.value--;
        tries++;
      }
    } else {
      /// it is not selected for checking
      selectedOrNot[index] = true;
      selectedAnswer.value = text;
    }
    print('the values of the current stack is');
    for (var element in selectedOrNot) {
      print('the value is : $element');
    }
    int i = 0;
    while (i < selectedOrNot.length) {
      if (i == index) {
      } else {
        selectedOrNot[i] = false;
      }
      i++;
    }
    if (totalCorrectMatchPicto == difficultyLevel.value + 2) {
      await Future.delayed(const Duration(seconds: 2));
      sameOrNotIndex = -1;
      createQuestion();
    }
    print('the index is $index and the value is $selectedAnswer : $selectedAnswerBottom');
  }

  Future<void> bottomWidgetFunction({
    required int index,
    required String text,
    required BuildContext context,
  }) async {
    selectedAnswerBottom.value = text;
    _ttsController.speak(text);
    if (selectedOrNot[index]) {
      /// it is selected for checking user clicked on the below question
      if (selectedAnswer.value.toLowerCase() == selectedAnswerBottom.value.toLowerCase()) {
        showTheDialog(context);
        await playClickSounds(assetName: 'yay');
        print('the index is $index and the value is $selectedAnswer');
        await Future.delayed(const Duration(milliseconds: 500));
        Get.back();
        totalCorrectMatchPicto++;
        topOrBottom[index].value = !topOrBottom[index].value;
        correctScore.value++;
        if (currentStreak.value >= 0) {
          if (maximumStreak.value == currentStreak.value) {
            maximumStreak.value++;
          }
          currentStreak.value++;
        }
      } else {
        showTheDialog(context);
        await playClickSounds(assetName: 'ohoh');
        await Future.delayed(const Duration(milliseconds: 500));
        Get.back();
        tries++;
        selectedOrNot[index] = false;
        selectedAnswerBottom.value = '';
        selectedAnswer.value = '';
        incorrectScore.value++;
        currentStreak.value--;
      }
    } else {
      /// it is not selected for checking
      selectedOrNot[index] = true;
      selectedAnswerBottom.value = questions[index].text;
    }
    print('the values of the current stack is');
    for (var element in selectedOrNot) {
      print('the value is : $element');
    }
    if (totalCorrectMatchPicto == difficultyLevel.value + 2) {
      await Future.delayed(const Duration(seconds: 2));
      sameOrNotIndex = -1;
      await createQuestion();
    }
    int i = 0;
    while (i < selectedOrNot.length) {
      if (i == index) {
      } else {
        selectedOrNot[i] = false;
      }
      i++;
    }
    print(';;;;;');
    for (var element in selectedOrNot) {
      print('the value is : $element');
    }
    print('the index is $index and the value is $selectedAnswer : $selectedAnswerBottom');
  }

  Future<void> generateRandomPositioningForMatchPictos() async {
    randomPositionsForBottomWidgets = [99.obs, 99.obs, 99.obs, 99.obs];
    if (difficultyLevel.value == 0) {
      int position0 = Random().nextInt(4000) % 2;
      int position1 = Random().nextInt(4000) % 2;
      while (position1 == position0) {
        position1 = Random().nextInt(4000) % 2;
      }
      randomPositionsForBottomWidgets[0].value = position0;
      bottomWidgetNames[position0].value = questions[0].text;
      randomPositionsForBottomWidgets[1].value = position1;
      bottomWidgetNames[position1].value = questions[1].text;
      print('position 0 has this one $position0');
      print('position 1 has this one $position1');
    } else if (difficultyLevel.value == 1) {
      int position0 = Random().nextInt(4000) % 3;
      int position1 = Random().nextInt(4000) % 3;
      int position2 = Random().nextInt(4000) % 3;
      while (position1 == position0) {
        position1 = Random().nextInt(4000) % 3;
      }
      while (position2 == position0 || position2 == position1) {
        position2 = Random().nextInt(4000) % 3;
      }
      randomPositionsForBottomWidgets[0].value = position0;
      bottomWidgetNames[position0].value = questions[0].text;
      randomPositionsForBottomWidgets[1].value = position1;
      bottomWidgetNames[position1].value = questions[1].text;
      randomPositionsForBottomWidgets[2].value = position2;
      print('position 0 has this one $position0');
      print('position 1 has this one $position1');
      print('position 2 has this one $position2');
    } else if (difficultyLevel.value == 2) {
      int position0 = Random().nextInt(4000) % 4;
      int position1 = Random().nextInt(4000) % 4;
      int position2 = Random().nextInt(4000) % 4;
      int position3 = Random().nextInt(4000) % 4;
      while (position1 == position0) {
        position1 = Random().nextInt(4000) % 4;
      }
      while (position2 == position0 || position2 == position1) {
        position2 = Random().nextInt(4000) % 4;
      }
      while (position3 == position0 || position3 == position1 || position3 == position2) {
        position3 = Random().nextInt(4000) % 4;
      }
      randomPositionsForBottomWidgets[0].value = position0;
      bottomWidgetNames[position0].value = questions[0].text;
      randomPositionsForBottomWidgets[1].value = position1;
      bottomWidgetNames[position1].value = questions[1].text;
      randomPositionsForBottomWidgets[2].value = position2;
      bottomWidgetNames[position2].value = questions[2].text;
      randomPositionsForBottomWidgets[3].value = position3;
      bottomWidgetNames[position3].value = questions[3].text;
      print('position 0 has this one ${randomPositionsForBottomWidgets[0].value}');
      print('position 1 has this one ${randomPositionsForBottomWidgets[1].value}');
      print('position 2 has this one ${randomPositionsForBottomWidgets[2].value}');
      print('position 3 has this one ${randomPositionsForBottomWidgets[3].value}');
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }

  Future<void> generateRandomPositionsForMemoryGame() async {
    /// shuffle the positions for having randomising
    positions = [0.obs, 0.obs, 0.obs, 0.obs, 0.obs, 0.obs, 0.obs, 0.obs];
    if (difficultyLevel.value == 0) {
      int position0 = Random().nextInt(4000) % 2;
      int position1 = Random().nextInt(4000) % 2;
      int position2 = Random().nextInt(4000) % 2;
      int position3 = Random().nextInt(4000) % 2;
      while (position1 == position0) {
        position1 = Random().nextInt(4000) % 2;
      }
      while (position2 == position3) {
        position2 = Random().nextInt(4000) % 2;
      }
      print(position0);
      print(position1);
      print(position2);
      print(position3);
      positions[0].value = position0;
      positions[1].value = position1;
      positions[4].value = position2;
      positions[5].value = position3;
    }
    if (difficultyLevel.value == 1) {
      int position0 = Random().nextInt(4000) % 3;
      int position1 = Random().nextInt(4000) % 3;
      int position2 = Random().nextInt(4000) % 3;
      while (position1 == position0) {
        position1 = Random().nextInt(4000) % 3;
      }
      while (position2 == position0 || position2 == position1) {
        position2 = Random().nextInt(4000) % 3;
      }
      int position3 = Random().nextInt(4000) % 3;
      int position4 = Random().nextInt(4000) % 3;
      int position5 = Random().nextInt(4000) % 3;
      while (position4 == position3) {
        position4 = Random().nextInt(4000) % 3;
      }
      while (position5 == position3 || position5 == position4) {
        position5 = Random().nextInt(4000) % 3;
      }
      positions[0].value = position0;
      positions[1].value = position1;
      positions[2].value = position2;
      positions[4].value = position3;
      positions[5].value = position4;
      positions[6].value = position5;
    }
    if (difficultyLevel.value == 2) {
      int position0 = Random().nextInt(4000) % 4;
      int position1 = Random().nextInt(4000) % 4;
      int position2 = Random().nextInt(4000) % 4;
      int position3 = Random().nextInt(4000) % 4;
      while (position1 == position0) {
        position1 = Random().nextInt(4000) % 4;
      }
      while (position2 == position0 || position2 == position1) {
        position2 = Random().nextInt(4000) % 4;
      }
      while (position3 == position0 || position3 == position1 || position3 == position2) {
        position3 = Random().nextInt(4000) % 4;
      }
      positions[0].value = position0;
      positions[1].value = position1;
      positions[2].value = position2;
      positions[3].value = position3;
      int position4 = Random().nextInt(4000) % 4;
      int position5 = Random().nextInt(4000) % 4;
      int position6 = Random().nextInt(4000) % 4;
      int position7 = Random().nextInt(4000) % 4;
      while (position5 == position4) {
        position5 = Random().nextInt(4000) % 4;
      }
      while (position6 == position4 || position6 == position5) {
        position6 = Random().nextInt(4000) % 4;
      }
      while (position7 == position4 || position7 == position5 || position7 == position6) {
        position7 = Random().nextInt(4000) % 4;
      }
      positions[4].value = position4;
      positions[5].value = position5;
      positions[6].value = position6;
      positions[7].value = position7;
    }
  }

  Future<void> memoryGameOnTap({required int index, required String text, required BuildContext context}) async {
    print('index is floowing $index');
    showOrHideMemoryGame[index].value = !showOrHideMemoryGame[index].value;
    if (first.value == '') {
      first.value = text;
      firstIndex.value = index;
    } else {
      if (index == firstIndex.value) return;
      second.value = text;
      secondIndex.value = index;
      if (first.value == second.value) {
        showTheDialog(context);
        first.value = '';
        second.value = '';
        await playClickSounds(assetName: 'yay');
        await Future.delayed(const Duration(seconds: 1));
        Get.back();
        // showOrHideMemoryGame[secondIndex.value].value = !showOrHideMemoryGame[secondIndex.value].value;
        totalCorrectMemoryGame++;
        correctScore.value++;

        if (currentStreak.value >= 0) {
          if (maximumStreak.value == currentStreak.value) {
            maximumStreak.value++;
          }
          currentStreak.value++;
        }
      } else {
        showTheDialog(context);
        first.value = '';
        second.value = '';
        incorrectScore.value++;
        currentStreak.value--;
        await playClickSounds(assetName: 'ohoh');
        await Future.delayed(const Duration(seconds: 1));
        Get.back();
        tries++;
        showOrHideMemoryGame[firstIndex.value].value = !showOrHideMemoryGame[firstIndex.value].value;
        showOrHideMemoryGame[secondIndex.value].value = !showOrHideMemoryGame[secondIndex.value].value;
      }
    }
    print('first is ${first.value}');
    print('second is ${second.value}');
    if (totalCorrectMemoryGame == difficultyLevel.value + 2) {
      first.value = '';
      second.value = '';
      await Future.delayed(const Duration(seconds: 3));
      await createQuestion();
      update(['MemoryGame']);
    }
  }

  Future<void> uploadScore() async {
    // final endTimeInEpoch = DateTime.now().millisecondsSinceEpoch;
    // double score = (correctScore.value + incorrectScore.value) / 2;

    /// check if the level is played or not

    // GameData game = GameData(
    //   game: gameSelected.value,
    //   levelId: grupoSelectedIndex,
    //   bestStreak: maximumStreak.value,
    //   score: Score(
    //     hit: correctScore.value,
    //     mistakes: incorrectScore.value,
    //     score: score,
    //     tries: tries,
    //   ),
    //   timeUse: timeInSeconds.value,
    //   reloj: [
    //     RelojElement(
    //       endTime: endTimeInEpoch,
    //       startTime: startTimeInEpoch,
    //       useTime: timeInSeconds.value,
    //     ),
    //   ],
    // );
    //TODO: ??
  }

  void showTheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Container(color: Colors.transparent),
      barrierColor: Colors.transparent,
      barrierDismissible: false,
    );
  }
}
