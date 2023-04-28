import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/chatgpt_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

class GamesProvider extends ChangeNotifier {
  int numberOfGroups = 45;
  int completedGroups = 0;
  int activeGroups = 00;
  int selectedGame = 0;
  int selectedGroupIndex = 0;
  final PageController mainPageController = PageController(initialPage: 0);
  ScrollController gridScrollController = ScrollController();
  Map<String, Picto> pictograms = {};
  Map<String, Group> groups = {};
  List<Picto> selectedPicts = [];
  List<Picto> gamePicts = [];
  List<Picto> chatGptPictos = [];
  int correctScore = 0;
  int incorrectScore = 0;
  String useTime = '';
  int streak = 0;
  List<bool> pictoShowWhatsThePict = [false, false];
  List<bool> matchPictoTop = [false, false];
  List<bool> matchPictoBottom = [false, false];
  int correctPicto = 99;
  int selectedPicto = 0;
  bool showText = false;
  bool mute = false;
  bool btnText = false;
  int sentencePhase = 0;
  String generatedStory = '';
  final List<String> nounBoards = ['APLbz00sRZDNGyGzioXMz', 'DDrKGBCRqNeAy4LgKfN4J', 'alr_Y_ZidZDqQJQCRiqoE', 'lyr-m9k0Q6-rffFFBwPEk'];
  final List<String> modifierBoards = ['--PHmDIFeKHvulVxNtBgk', '5kfboTpsoH8RSFvA9ruE1', 'TMO8t_1hMaHiyh1SUwaFH'];
  final List<String> actionBoards = ['L6pHIipM3ocu3wYlMuo2y'];
  final List<String> placeBoards = ['H6zmHfH-5XVtpy1RJ1ci7', 'kBVGvu0NygXFUWTFxcQJe'];
  List<String> gptBoards = [];
  bool boardOrPicto = true;
  List<Picto> gptPictos = [];

  final AudioPlayer backgroundMusicPlayer = AudioPlayer();
  final AudioPlayer clicksPlayer = AudioPlayer();

  Map<int, Picto> bottomPositions = {};
  Map<int, Picto> topPositions = {};

  final PictogramsRepository _pictogramsService;
  final GroupsRepository _groupsService;
  final PatientNotifier patientState;
  final TTSProvider _tts;
  final ChatGPTRepository _chatGPTServices;

  GamesProvider(this._groupsService, this._pictogramsService, this.patientState, this._tts, this._chatGPTServices);

  void moveForward() {
    mainPageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    notifyListeners();
  }

  void moveBackward() {
    mainPageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    notifyListeners();
  }

  void scrollUp() {
    int currentPosition = gridScrollController.position.pixels.toInt();

    if (currentPosition == 0) return;

    gridScrollController.animateTo(
      currentPosition - 96,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void scrollDown() {
    int currentPosition = gridScrollController.position.pixels.toInt();

    if (currentPosition >= gridScrollController.position.maxScrollExtent) return;

    gridScrollController.animateTo(
      currentPosition + 96,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  Future<void> fetchPictograms() async {
    List<Picto>? pictos;
    List<Group>? groupsData;

    if (patientState.state != null) {
      pictos = patientState.user.pictos[patientState.user.settings.language];

      groupsData = patientState.user.groups[patientState.user.settings.language];

      print(patientState.user.groups);
    }

    pictos ??= (await _pictogramsService.getAllPictograms()).where((element) => !element.block).toList();
    groupsData ??= (await _groupsService.getAllGroups()).where((element) => !element.block).toList();

    groupsData.forEach((e) {
      if (!e.block) {
        activeGroups++;
      }
    });

    pictograms = Map.fromIterables(pictos.map((e) => e.id), pictos);
    groups = Map.fromIterables(groupsData.map((e) => e.id), groupsData);

    notifyListeners();
  }

  Future<void> fetchSelectedPictos() async {
    List<Picto> picts = [];
    final gro = groups.values.where((element) => !element.block).toList();
    for (var e in gro[selectedGroupIndex].relations) {
      picts.add(
        pictograms[e.id]!,
      );
    }
    selectedPicts.clear();
    selectedPicts.addAll(picts);
    // print(picts.toString());
    await createRandomForGame();
  }

  Future<void> fetchGptPictos({required String id}) async {
    List<Picto> picts = [];
    final gro = groups[id];
    for (var e in gro!.relations) {
      picts.add(
        pictograms[e.id]!,
      );
    }
    chatGptPictos.clear();
    chatGptPictos.addAll(picts);
    // print(picts.toString());
    notifyListeners();
  }

  Future<void> createRandomForGame() async {
    gamePicts.clear();
    bool same = true;
    int random1 = Random().nextInt(selectedPicts.length - 1);
    int random2 = Random().nextInt(selectedPicts.length - 1);
    while (same) {
      if (random1 == random2) {
        random2 = Random().nextInt(selectedPicts.length - 1);
      } else {
        same = false;
      }
    }
    gamePicts.add(selectedPicts[random1]);
    gamePicts.add(selectedPicts[random2]);

    /// matchPicto and guessPicto things
    int p1 = Random().nextInt(2);
    int p2 = Random().nextInt(2);
    same = true;
    while (same) {
      if (random1 == random2) {
        random2 = Random().nextInt(2);
      } else {
        same = false;
      }
    }
    topPositions[0] = gamePicts[p1];
    topPositions[1] = gamePicts[p2];
    int pD1 = Random().nextInt(2);
    int pD2 = Random().nextInt(2);
    same = true;
    while (same) {
      if (random1 == random2) {
        random2 = Random().nextInt(2);
      } else {
        same = false;
      }
    }
    bottomPositions[0] = gamePicts[pD1];
    bottomPositions[1] = gamePicts[pD2];
    correctPicto = Random().nextInt(2);
    print(correctPicto);
    notifyListeners();
  }

  // Future<void> fetchBoardsForType({required List<String> ids}) async {
  //   gptBoards.clear();
  //   ids.forEach((element) {
  //     print(groups[element]!.text);
  //   });
  // }

  Future<void> checkAnswerWhatThePicto({required int index}) async {
    //todo: show the text that it is correct
    selectedPicto = index;
    pictoShowWhatsThePict[index] = !pictoShowWhatsThePict[index];
    showText = !showText;
    notifyListeners();
    await Future.delayed(
      const Duration(seconds: 1),
    );
    //todo: remove the text around
    pictoShowWhatsThePict[index] = !pictoShowWhatsThePict[index];
    showText = !showText;
    notifyListeners();
    //todo: create the new question
    if (correctPicto == index) {
      correctScore++;
      await createRandomForGame();
    } else {
      if (correctScore == 0) {
        correctScore = 0;
      } else {
        correctScore--;
      }
      streak = 0;
    }
    notifyListeners();
  }

  Future<void> checkAnswerMatchPicto({required bool upper, required int index}) async {}

  Future<void> init() async {
    await initializeBackgroundMusic();
  }

  void notify() {
    notifyListeners();
  }

  Future<void> playClickSounds({required String assetName}) async {
    await clicksPlayer.setAsset('assets/audios/$assetName.mp3');
    await clicksPlayer.play();
  }

  Future<void> changeMusic() async {
    mute = !mute;
    notifyListeners();
    if (mute) {
      await backgroundMusicPlayer.pause();
    } else {
      await backgroundMusicPlayer.play();
    }
  }

  void speakNameWhatsThePicto() async {
    await _tts.speak('game.speak_what'.trlf({'name': gamePicts[correctPicto].text}));
  }

  Future<void> initializeBackgroundMusic() async {
    ///check if we can buffer the audios before even loading the properties of the given class
    // backgroundMusicPlayer.setAudioSource();
    await backgroundMusicPlayer.setAsset('assets/audios/funckygroove.mp3');
    await backgroundMusicPlayer.setLoopMode(LoopMode.one);
    await backgroundMusicPlayer.play();
  }

  Future<void> createStory() async {
    final String prompt = 'game.prompt'.trl;
    final finalPrompt = '$prompt ${gptPictos[0].text}, ${gptPictos[1].text}, ${gptPictos[2].text}, ${gptPictos[3].text}.';
    final res = await _chatGPTServices.getStory(prompt: finalPrompt);
    if (res.isRight) {
      generatedStory = res.right;
    }
    notifyListeners();
  }

  Future<void> speakStory() async {
    if (backgroundMusicPlayer.playing) {
      backgroundMusicPlayer.pause();
    }
    _tts.speak(generatedStory);
  }

  Future<void> resetStoryGame() async {
    gptPictos.clear();
    gptBoards = [];
    sentencePhase = 0;
    notifyListeners();
  }

  Future<void> stopTTS() async {
    await _tts.ttsStop();
  }
}

final gameProvider = ChangeNotifierProvider<GamesProvider>((ref) {
  final pictogramService = GetIt.I<PictogramsRepository>();
  final groupsService = GetIt.I<GroupsRepository>();
  final patientState = ref.watch(patientNotifier.notifier);
  final tts = ref.watch(ttsProvider);
  final chatGpt = GetIt.I<ChatGPTRepository>();
  return GamesProvider(groupsService, pictogramService, patientState, tts, chatGpt);
});
