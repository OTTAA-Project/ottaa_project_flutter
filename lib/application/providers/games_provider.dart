import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/application/providers/whats_the_picto_provider.dart';
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
  int correctScore = 0;
  int incorrectScore = 0;
  List<Picto> selectedPicts = [];
  String useTime = '';
  int streak = 0;
  List<bool> matchPictoTop = [false, false];
  List<bool> matchPictoBottom = [false, false];
  bool mute = false;
  List<Picto> gamePictsWTP = [];
  int correctPictoWTP = 99;
  bool hintsEnabled = false;

  final AudioPlayer backgroundMusicPlayer = AudioPlayer();
  final AudioPlayer clicksPlayer = AudioPlayer();

  Map<int, Picto> bottomPositions = {};
  Map<int, Picto> topPositions = {};

  final PictogramsRepository _pictogramsService;
  final GroupsRepository _groupsService;
  final PatientNotifier patientState;
  final TTSProvider _tts;

  GamesProvider(this._groupsService, this._pictogramsService, this.patientState, this._tts);

  Future<void> createRandomForGameWTP() async {
    print('u was called');
    gamePictsWTP.clear();
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
    gamePictsWTP.add(selectedPicts[random1]);
    gamePictsWTP.add(selectedPicts[random2]);

    /// matchPicto and guessPicto things
    same = true;
    while (same) {
      if (random1 == random2) {
        random2 = Random().nextInt(2);
      } else {
        same = false;
      }
    }
    same = true;
    while (same) {
      if (random1 == random2) {
        random2 = Random().nextInt(2);
      } else {
        same = false;
      }
    }
    correctPictoWTP = Random().nextInt(2);
    print(correctPictoWTP);
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

  // Future<void> fetchBoardsForType({required List<String> ids}) async {
  //   gptBoards.clear();
  //   ids.forEach((element) {
  //     print(groups[element]!.text);
  //   });
  // }

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

  Future<void> initializeBackgroundMusic() async {
    ///check if we can buffer the audios before even loading the properties of the given class
    // backgroundMusicPlayer.setAudioSource();
    if (mute) {
    } else {
      await backgroundMusicPlayer.setAsset('assets/audios/funckygroove.mp3');
      await backgroundMusicPlayer.setLoopMode(LoopMode.one);
      await backgroundMusicPlayer.play();
    }
  }
}

final gameProvider = ChangeNotifierProvider<GamesProvider>((ref) {
  final pictogramService = GetIt.I<PictogramsRepository>();
  final groupsService = GetIt.I<GroupsRepository>();
  final patientState = ref.watch(patientNotifier.notifier);
  final tts = ref.watch(ttsProvider);
  // final chatGpt = GetIt.I<ChatGPTRepository>();
  // final whatsThePictoController = ref.watch(whatsThePictoProvider);
  return GamesProvider(groupsService, pictogramService, patientState, tts);
});
