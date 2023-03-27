import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

class GamesProvider extends ChangeNotifier {
  int numberOfGroups = 45;
  int completedGroups = 0;
  bool moversMain = true;
  int selectedGame = 0;
  int selectedGroupIndex = 0;
  final PageController mainPageController = PageController(initialPage: 0);
  ScrollController gridScrollController = ScrollController();
  Map<String, Picto> pictograms = {};
  Map<String, Group> groups = {};
  List<Picto> selectedPicts = [];
  List<Picto> gamePicts = [];

  final PictogramsRepository _pictogramsService;
  final GroupsRepository _groupsService;
  final PatientNotifier patientState;

  GamesProvider(
      this._groupsService, this._pictogramsService, this.patientState);

  void moveForward() {
    mainPageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    if (mainPageController.page!.toInt() == 1) {
      moversMain = false;
    }
    notifyListeners();
  }

  void moveBackward() {
    mainPageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    if (mainPageController.page!.toInt() == 1) {
      moversMain = true;
    }
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

    if (currentPosition >= gridScrollController.position.maxScrollExtent)
      return;

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

      groupsData =
          patientState.user.groups[patientState.user.settings.language];

      print(patientState.user.groups);
    }

    pictos ??= (await _pictogramsService.getAllPictograms())
        .where((element) => !element.block)
        .toList();
    groupsData ??= (await _groupsService.getAllGroups())
        .where((element) => !element.block)
        .toList();

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
    print("$random1 $random2");
    gamePicts.add(selectedPicts[random1]);
    gamePicts.add(selectedPicts[random2]);

  }
}

final gameProvider = ChangeNotifierProvider<GamesProvider>((ref) {
  final pictogramService = GetIt.I<PictogramsRepository>();
  final groupsService = GetIt.I<GroupsRepository>();
  final patientState = ref.watch(patientNotifier.notifier);
  return GamesProvider(groupsService, pictogramService, patientState);
});
