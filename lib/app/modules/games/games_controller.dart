import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/models/game_question_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/games/local_widgets/game_model_data.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';

import 'games_playing_page.dart';

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
  final Map<int, RxDouble> leftRatios = {
    0: 0.05.obs,
    1: 0.28.obs,
    2: 0.51.obs,
    3: 0.74.obs,
  };
  RxList<GameQuestionModel> questions = <GameQuestionModel>[].obs;
  final AudioPlayer backgroundMusicPlayer = AudioPlayer();
  final AudioPlayer clicksPlayer = AudioPlayer();
  final _homeController = Get.find<HomeController>();
  final _ttsController = Get.find<TTSController>();
  List<Grupos> grupos = [];
  List<Pict> pictos = [];
  List<Pict> currentGrupoPicts = [];
  RxInt gameSelected = 0.obs;
  RxBool changeViewForListview = true.obs;

  /// 0 = easy, 1 = medium, 2 = hard///
  RxInt difficultyLevel = 0.obs;
  int grupoSelectedIndex = -1;
  late String language;
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
  RxString selectedImage = ''.obs;
  RxBool showImage = false.obs;
  List<RxBool> topOrBottom = [true.obs, true.obs, true.obs, true.obs];

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
  void dispose() async {
    super.dispose();
    await backgroundMusicPlayer.dispose();
  }

  @override
  void onClose() {
    super.onClose();
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
  }

  @override
  void onReady() {
    grupos.addAll(_homeController.grupos);
    pictos.addAll(_homeController.picts);
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

  Future<void> pictoFunctionWhatsThePicto({required int index}) async {
    final bool correctOrNot =
        questions[index].text.toLowerCase() == selectedAnswer.toLowerCase();
    imageOrEmoji[index].value = !imageOrEmoji[index].value;
    if (correctOrNot) {
      showImage.value = !showImage.value;
      await playClickSounds(assetName: 'yay');
    } else {
      await playClickSounds(assetName: 'ohoh');
    }
    await Future.delayed(
      Duration(milliseconds: 1000),
    );
    imageOrEmoji[index].value = !imageOrEmoji[index].value;
    if (correctOrNot) {
      showImage.value = !showImage.value;
      await Future.delayed(Duration(milliseconds: 500));

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
    if (difficultyLevel.value == 0) {
      ///easy difficulty
      int picto1 = random(0, currentGrupoPicts.length);
      int picto2 = random(0, currentGrupoPicts.length);
      int correctAnswer = DateTime.now().microsecondsSinceEpoch % 2;
      print('the values are here');
      print('the correct answer is $correctAnswer');
      print(picto1);
      print(picto2);
      questions.clear();
      questions.add(
        GameQuestionModel(
          id: picto1,
          imageUrl: currentGrupoPicts[picto1].imagen.pictoEditado == null
              ? currentGrupoPicts[picto1].imagen.picto
              : currentGrupoPicts[picto1].imagen.pictoEditado!,
          text: language.toLowerCase() == 'en'.toLowerCase()
              ? currentGrupoPicts[picto1].texto.en
              : currentGrupoPicts[picto1].texto.es,
        ),
      );
      questions.add(
        GameQuestionModel(
          id: picto2,
          imageUrl: currentGrupoPicts[picto2].imagen.pictoEditado == null
              ? currentGrupoPicts[picto2].imagen.picto
              : currentGrupoPicts[picto2].imagen.pictoEditado!,
          text: language.toLowerCase() == 'en'.toLowerCase()
              ? currentGrupoPicts[picto2].texto.en
              : currentGrupoPicts[picto2].texto.es,
        ),
      );
      selectedAnswer.value = questions[correctAnswer].text;
      selectedImage.value = questions[correctAnswer].imageUrl;
      await clicksPlayer.pause();
      await _ttsController.speak('What\'s the picto ${selectedAnswer.value}');
    } else if (difficultyLevel.value == 1) {
      ///medium difficulty
      int picto1 = random(0, currentGrupoPicts.length);
      int picto2 = random(0, currentGrupoPicts.length);
      int picto3 = random(0, currentGrupoPicts.length);
      int correctAnswer = DateTime.now().microsecondsSinceEpoch % 3;
      questions.clear();
      questions.add(
        GameQuestionModel(
          id: picto1,
          imageUrl: currentGrupoPicts[picto1].imagen.pictoEditado == null
              ? currentGrupoPicts[picto1].imagen.picto
              : currentGrupoPicts[picto1].imagen.pictoEditado!,
          text: language.toLowerCase() == 'en'.toLowerCase()
              ? currentGrupoPicts[picto1].texto.en
              : currentGrupoPicts[picto1].texto.es,
        ),
      );
      questions.add(
        GameQuestionModel(
          id: picto2,
          imageUrl: currentGrupoPicts[picto2].imagen.pictoEditado == null
              ? currentGrupoPicts[picto2].imagen.picto
              : currentGrupoPicts[picto2].imagen.pictoEditado!,
          text: language.toLowerCase() == 'en'.toLowerCase()
              ? currentGrupoPicts[picto2].texto.en
              : currentGrupoPicts[picto2].texto.es,
        ),
      );
      questions.add(
        GameQuestionModel(
          id: picto2,
          imageUrl: currentGrupoPicts[picto3].imagen.pictoEditado == null
              ? currentGrupoPicts[picto3].imagen.picto
              : currentGrupoPicts[picto3].imagen.pictoEditado!,
          text: language.toLowerCase() == 'en'.toLowerCase()
              ? currentGrupoPicts[picto3].texto.en
              : currentGrupoPicts[picto3].texto.es,
        ),
      );
      selectedAnswer.value = questions[correctAnswer].text;
      selectedImage.value = questions[correctAnswer].imageUrl;
      await clicksPlayer.pause();
      await _ttsController.speak('What\'s the picto ${selectedAnswer.value}');
    } else {
      ///hard difficulty
      int picto1 = random(0, currentGrupoPicts.length);
      int picto2 = random(0, currentGrupoPicts.length);
      int picto3 = random(0, currentGrupoPicts.length);
      int picto4 = random(0, currentGrupoPicts.length);
      int correctAnswer = DateTime.now().microsecondsSinceEpoch % 4;
      questions.clear();
      questions.add(
        GameQuestionModel(
          id: picto1,
          imageUrl: currentGrupoPicts[picto1].imagen.pictoEditado == null
              ? currentGrupoPicts[picto1].imagen.picto
              : currentGrupoPicts[picto1].imagen.pictoEditado!,
          text: language.toLowerCase() == 'en'.toLowerCase()
              ? currentGrupoPicts[picto1].texto.en
              : currentGrupoPicts[picto1].texto.es,
        ),
      );
      questions.add(
        GameQuestionModel(
          id: picto2,
          imageUrl: currentGrupoPicts[picto2].imagen.pictoEditado == null
              ? currentGrupoPicts[picto2].imagen.picto
              : currentGrupoPicts[picto2].imagen.pictoEditado!,
          text: language.toLowerCase() == 'en'.toLowerCase()
              ? currentGrupoPicts[picto2].texto.en
              : currentGrupoPicts[picto2].texto.es,
        ),
      );
      questions.add(
        GameQuestionModel(
          id: picto3,
          imageUrl: currentGrupoPicts[picto3].imagen.pictoEditado == null
              ? currentGrupoPicts[picto3].imagen.picto
              : currentGrupoPicts[picto3].imagen.pictoEditado!,
          text: language.toLowerCase() == 'en'.toLowerCase()
              ? currentGrupoPicts[picto3].texto.en
              : currentGrupoPicts[picto3].texto.es,
        ),
      );
      questions.add(
        GameQuestionModel(
          id: picto4,
          imageUrl: currentGrupoPicts[picto4].imagen.pictoEditado == null
              ? currentGrupoPicts[picto4].imagen.picto
              : currentGrupoPicts[picto4].imagen.pictoEditado!,
          text: language.toLowerCase() == 'en'.toLowerCase()
              ? currentGrupoPicts[picto4].texto.en
              : currentGrupoPicts[picto4].texto.es,
        ),
      );
      selectedAnswer.value = questions[correctAnswer].text;
      selectedImage.value = questions[correctAnswer].imageUrl;
      await clicksPlayer.pause();
      if (gameSelected.value == 0) {
        await _ttsController.speak('What\'s the picto ${selectedAnswer.value}');
      }
    }
  }

  void fetchPictosForCurrentGrupo() async {
    currentGrupoPicts = [];
    for (int i = 0; i < grupos[grupoSelectedIndex].relacion.length; i++) {
      pictos.forEach((element) {
        if (element.id == grupos[grupoSelectedIndex].relacion[i].id) {
          currentGrupoPicts.add(element);
        }
      });
    }
  }

  Future<void> playClickSounds({required String assetName}) async {
    await clicksPlayer.setAsset('assets/audios/$assetName.mp3');
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
    Get.to(() => GamesPlayingPage());
  }

  Future<void> pauseMusic() async {
    await backgroundMusicPlayer.pause();
  }

  void speakName() {
    _ttsController.speak('What\'s the picto ${selectedAnswer.string}');
  }

  Future<void> topWidgetFunction() async {
    topOrBottom[0].value = !topOrBottom[0].value;
  }

  Future<void> bottomWidgetFunction() async {}
}
