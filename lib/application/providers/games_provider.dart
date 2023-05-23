import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
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
  int correctScore = 0;
  int incorrectScore = 0;
  List<Picto> selectedPicts = [];
  int useTime = 00;
  int streak = 0;
  List<bool> matchPictoTop = List.filled(4, false);
  List<bool> matchPictoBottom = List.filled(4, false);
  bool isMute = false;
  List<Picto> gamePictsWTP = [];
  List<Picto> gamePictsMP = [];
  int correctPictoWTP = 99;
  bool hintsBtn = false;
  late Timer hintTimer, gameTimer;
  bool hintsEnabled = false;

  /// 0 == 2 pictos, 1 == 3 pictos, 2 == 4 pictos
  int difficultyLevel = 0;

  final AudioPlayer backgroundMusicPlayer = AudioPlayer();
  final AudioPlayer clicksPlayer = AudioPlayer();

  Map<int, Picto> bottomPositionsMP = {};
  Map<int, Picto> topPositionsMP = {};

  final PictogramsRepository _pictogramsService;
  final GroupsRepository _groupsService;
  final PatientNotifier patientState;

  GamesProvider(this._groupsService, this._pictogramsService, this.patientState);

  Future<void> createRandomForGameWTP() async {
    gamePictsWTP.clear();
    List<int> numbers = [];
    Random random = Random();
    while (numbers.length < difficultyLevel + 2) {
      int num = random.nextInt(selectedPicts.length - 1);
      if (!numbers.contains(num)) {
        numbers.add(num);
      }
    }
    for (var element in numbers) {
      gamePictsWTP.add(selectedPicts[element]);
    }

    correctPictoWTP = Random().nextInt(difficultyLevel + 2);
    print(correctPictoWTP);
    notifyListeners();
  }

  resetScore() {
    incorrectScore == 0;
    correctScore = 0;
    gameTimer.cancel();
    useTime = 0;
    streak = 0;
    difficultyLevel = 0;
  }

  Future<void> createRandomForGameMP() async {
    topPositionsMP.clear();
    bottomPositionsMP.clear();
    List<int> topNumbers = [];
    List<int> bottomNumbers = [];
    Random random = Random();
    while (topNumbers.length < difficultyLevel + 2) {
      int num = random.nextInt(selectedPicts.length - 1);
      if (!topNumbers.contains(num)) {
        topNumbers.add(num);
      }
    }
    while (bottomNumbers.length < difficultyLevel + 2) {
      int num = random.nextInt(topNumbers.length);
      if (!bottomNumbers.contains(num)) {
        bottomNumbers.add(num);
      }
    }
    int i = 0;
    for (var element in topNumbers) {
      topPositionsMP[i] = selectedPicts[element];
      i++;
    }
    i = 0;
    for (var element in bottomNumbers) {
      bottomPositionsMP[i] = topPositionsMP[element]!;
      i++;
    }
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
  }

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

    if (currentPosition >= gridScrollController.position.maxScrollExtent) {
      return;
    }

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

    for (var e in groupsData) {
      if (!e.block) {
        activeGroups++;
      }
    }

    pictograms = Map.fromIterables(pictos.map((e) => e.id), pictos);
    groups = Map.fromIterables(groupsData.map((e) => e.id), groupsData);

    notifyListeners();
  }

  // Future<void> fetchBoardsForType({required List<String> ids}) async {
  //   gptBoards.clear();
  //   ids.forEach((element) {
  //     print(groups[element]!.text);
  //   });
  // }

  Future<void> checkAnswerMatchPicto({required bool upper, required int index}) async {}

  Future<void> init() async {
    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      useTime = useTime + 1;
    });
    await initializeBackgroundMusic();
    if (hintsBtn) {
      showHints();
    }
  }

  Future<void> showHints() async {
    hintTimer = Timer.periodic(const Duration(seconds: 8), (timer) {
      Timer(const Duration(seconds: 2), () {
        hintsEnabled = true;
        notify();
      });
      hintsEnabled = false;
      notify();
    });
  }

  Future<void> cancelHints() async {
    hintTimer.cancel();
    hintTimer.cancel();
    hintsEnabled = false;
  }

  void notify() {
    notifyListeners();
  }

  Future<void> playClickSounds({required String assetName}) async {
    await clicksPlayer.setAsset('assets/audios/$assetName.mp3');
    await clicksPlayer.play();
  }

  Future<void> changeMusic() async {
    isMute = !isMute;
    notifyListeners();
    if (isMute) {
      await backgroundMusicPlayer.pause();
    } else {
      await backgroundMusicPlayer.play();
    }
  }

  Future<void> initializeBackgroundMusic() async {
    ///check if we can buffer the audios before even loading the properties of the given class
    // backgroundMusicPlayer.setAudioSource();
    if (isMute) {
    } else {
      await backgroundMusicPlayer.setAsset('assets/audios/funckygroove.mp3');
      await backgroundMusicPlayer.setLoopMode(LoopMode.one);
      await backgroundMusicPlayer.setVolume(0.2);
      await backgroundMusicPlayer.play();
    }
  }
}

final gameProvider = ChangeNotifierProvider<GamesProvider>((ref) {
  final pictogramService = GetIt.I<PictogramsRepository>();
  final groupsService = GetIt.I<GroupsRepository>();
  final patientState = ref.watch(patientNotifier.notifier);
  // final tts = ref.watch(ttsProvider);
  // final chatGpt = GetIt.I<ChatGPTRepository>();
  // final whatsThePictoController = ref.watch(whatsThePictoProvider);
  return GamesProvider(groupsService, pictogramService, patientState);
});
