import 'dart:math' show min;

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/common/constants.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/common/extensions/user_extension.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/chatgpt_provider.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/core/enums/display_types.dart';
import 'package:ottaa_project_flutter/core/enums/home_screen_status.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/learn_token.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';
import 'package:ottaa_project_flutter/core/models/phrase_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/sentences_repository.dart';
import 'package:ottaa_project_flutter/core/use_cases/learn_pictogram.dart';
import 'package:ottaa_project_flutter/core/use_cases/predict_pictogram.dart';

const String kStarterPictoId = "FWy18PiX2jLwZQF6-oNZR";

List<Picto> basicPictograms = [];

class HomeProvider extends ChangeNotifier {
  final PictogramsRepository _pictogramsService;
  final GroupsRepository _groupsService;
  final SentencesRepository _sentencesService;
  final PatientNotifier patientState;
  final UserNotifier userState;

  final TTSProvider _tts;

  final PredictPictogram predictPictogram;
  final LearnPictogram learnPictogram;

  final ChatGPTNotifier _chatGPTNotifier;

  HomeProvider(
    this._pictogramsService,
    this._groupsService,
    this._sentencesService,
    this._tts,
    this.patientState,
    this.predictPictogram,
    this.learnPictogram,
    this.userState,
    this._chatGPTNotifier,
  );

  List<Phrase> mostUsedSentences = [];
  int indexForMostUsed = 0;

  Map<String, Picto> pictograms = {};
  Map<String, Group> groups = {};

  List<Picto>? suggestedPicts;

  List<Picto> pictoWords = [];

  String suggestedIndex = kStarterPictoId;

  int suggestedQuantity = 4;

  int indexPage = 0;

  bool confirmExit = false;

  bool talkEnabled = true;
  bool show = false;
  int? selectedWord;
  ScrollController scrollController = ScrollController();

  HomeScreenStatus status = HomeScreenStatus.pictos;

  // Home Tabs
  String currentTabGroup = "";
  ScrollController groupTabsScrollController = ScrollController();
  ScrollController pictoTabsScrollController = ScrollController();

  //Home grids
  String? currentGridGroup;
  ScrollController gridScrollController = ScrollController();

  final List<CancelToken> _cancelsToken = [];

  void setCurrentGroup(String group) {
    currentTabGroup = group;
    pictoTabsScrollController.jumpTo(0);
    notifyListeners();
  }

  Future<void> init() async {
    await fetchPictograms();

    basicPictograms = predictiveAlgorithm(list: pictograms[kStarterPictoId]!.relations);

    currentTabGroup = groups.keys.first;

    await buildSuggestion();
    notifyListeners();
  }

  void switchToPictograms() {
    final currentUser = patientState.patient ?? userState.user!;

    bool isGrid = currentUser.isPatient && currentUser.patient.patientSettings.layout.display == DisplayTypes.grid;

    if (isGrid) {
      status = HomeScreenStatus.grid;
    } else {
      status = HomeScreenStatus.tabs;
    }

    notify();
  }

  Future<void> fetchMostUsedSentences() async {
    final res = await _sentencesService.fetchSentences(
      language: "es_AR",
      type: kMostUsedSentences,
    );
    if (res.isRight) {
      mostUsedSentences = res.right;
    } else {
      mostUsedSentences = [];
    }

    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  void setSuggedtedQuantity(int quantity) {
    suggestedQuantity = quantity;
    notifyListeners();
  }

  void addPictogram(Picto picto) {
    pictoWords.add(picto);
    suggestedPicts = null;

    if (pictoWords.length > 5) {
      scrollController.jumpTo(scrollController.offset + 100);
    }

    buildSuggestion(picto.id);
    notifyListeners();
  }

  void removeLastPictogram() {
    pictoWords.removeLast();
    if (pictoWords.isEmpty) {
      for (var element in _cancelsToken) {
        element.cancel();
      }

      _cancelsToken.clear();
    }
    notify();
    suggestedPicts = null;
    Picto? lastPicto = pictoWords.lastOrNull;

    buildSuggestion(lastPicto?.id);
    notifyListeners();
  }

  Future<void> fetchPictograms() async {
    List<Picto>? pictos;
    List<Group>? groupsData;

    if (patientState.patient != null) {
      pictos = patientState.user.pictos[patientState.user.settings.language.language];

      groupsData = patientState.user.groups[patientState.user.settings.language.language];
    }

    pictos ??= (await _pictogramsService.getAllPictograms()).where((element) => !element.block).toList();
    groupsData ??= (await _groupsService.getAllGroups()).where((element) => !element.block).toList();

    pictograms = Map.fromIterables(pictos.map((e) => e.id), pictos);
    groups = Map.fromIterables(groupsData.map((e) => e.id), groupsData);

    notifyListeners();
  }

  Future<void> buildSuggestion([String? id]) async {
    indexPage = 0;

    if (patientState.patient != null) {
      PatientUserModel user = patientState.user;
      final cancelToken = CancelToken();

      cancelToken.whenCancel.then((value) {
        _cancelsToken.remove(cancelToken);
      });

      for (var element in _cancelsToken) {
        element.cancel();
      }

      _cancelsToken.clear();

      _cancelsToken.add(cancelToken);

      String hour = "";

      int time = DateTime.now().hour;

      if (time >= 5 && time <= 11) {
        hour = 'MANANA';
      } else if (time > 11 && time <= 14) {
        hour = 'MEDIODIA';
      } else if (time > 14 && time < 20) {
        hour = 'TARDE';
      } else {
        hour = 'NOCHE';
      }

      final response = await predictPictogram.call(
        sentence: pictoWords.map((e) => e.text).join(" "),
        uid: user.id,
        language: user.settings.language.language,
        model: "test",
        groups: (user.groups[user.settings.language.language] ?? []).where((element) => !element.block).map((e) => e.id).toList(),
        tags: {
          "HORA": [hour]
        },
        reduced: true,
        chunk: suggestedQuantity,
        cancelToken: cancelToken,
      );

      _cancelsToken.remove(cancelToken);

      bool isCancelled = 12 >= 2;
      if (response.isRight) {
        suggestedPicts = response.right.map((e) => pictograms[e.id["local"]]!).toList();
        notifyListeners();
        return;
      }
    }
    id ??= kStarterPictoId;

    if (id == kStarterPictoId) {
      suggestedPicts = [];
      suggestedPicts!.addAll(basicPictograms);
      notify();
    }

    if (id == kStarterPictoId) return;

    Picto? pict = pictograms[id];

    if (pict == null) return;

    if (pict.relations.isNotEmpty) {
      final List<PictoRelation> recomendedPicts = pict.relations.toList();
      recomendedPicts.sortBy<num>((element) => element.value);
      List<Picto> requiredPictos = predictiveAlgorithm(list: recomendedPicts);
      suggestedPicts ??= [];
      suggestedPicts!.addAll(requiredPictos);
      suggestedPicts = suggestedPicts!.toSet().toList();
    }

    suggestedIndex = id;

    // suggestedPicts = suggestedPicts.sublist(0, min(suggestedPicts.length, suggestedQuantity));
    return notifyListeners();
  }

  List<Picto> getPictograms() {
    if (suggestedPicts == null) {
      return List.generate(4, (index) {
        return Picto(
          id: "-777",
          text: "",
          type: 0,
          resource: AssetsImage(
            asset: "",
            network: null,
          ),
        );
      });
    }

    int currentPage = (suggestedPicts!.length / suggestedQuantity).round();

    if (indexPage > currentPage) {
      indexPage = currentPage;
    }
    if (indexPage < 0) {
      indexPage = 0;
    }
    int start = indexPage * suggestedQuantity;
    List<Picto> pictos = suggestedPicts!.sublist(start, min(suggestedPicts!.length, (indexPage * suggestedQuantity) + suggestedQuantity));

    if (pictos.length < suggestedQuantity) {
      int pictosLeft = suggestedQuantity - pictos.length;
      pictos.addAll(
        List.generate(
          pictosLeft,
          (index) => Picto(
            id: "777",
            text: "",
            type: 0,
            resource: AssetsImage(
              asset: "",
              network: null,
            ),
          ),
        ),
      );
    }

    return pictos;
  }

  List<Picto> predictiveAlgorithm({required List<PictoRelation> list}) {
    const int pesoFrec = 2, pesoHora = 50;
    final time = DateTime.now().hour;

    List<Picto> requiredPicts = [];

    for (var recommendedPict in list) {
      requiredPicts.add(
        pictograms[recommendedPict.id]!,
      );
    }
    late String tag;
    if (time >= 5 && time <= 11) {
      tag = 'MANANA';
    } else if (time > 11 && time <= 14) {
      tag = 'MEDIODIA';
    } else if (time > 14 && time < 20) {
      tag = 'TARDE';
    } else {
      tag = 'NOCHE';
    }
    int i = -1;
    for (var e in requiredPicts) {
      i++;
      int hora = 0;

      /// '0' should be replaced by the value of HORA
      if (e.tags["hour"] == null) {
        hora = 0;
      } else {
        for (var e in e.tags["hour"]!) {
          if (tag == e) {
            hora = 1;
          }
        }
      }
      e.freq = (list[i].value * pesoFrec) + (hora * pesoHora);
    }

    requiredPicts.sort((b, a) => a.freq.compareTo(b.freq));

    return requiredPicts;
  }

  Future<void> speakSentence() async {
    show = true;
    notifyListeners();
    if (patientState.state != null) {
      learnPictogram.call(
        uid: patientState.user.id,
        language: patientState.user.patientSettings.language.language,
        model: "", //TODO: Change to the current model later uwu
        tokens: pictoWords.map((e) => LearnToken(name: e.text, id: e.id)).toList(),
      );
    }

    if (patientState.state != null && !patientState.user.patientSettings.layout.oneToOne) {
      notifyListeners();
      String? sentence;
      scrollController.jumpTo(0);
      if (patientState.user.patientSettings.language.labs) {
        sentence = await _chatGPTNotifier.generatePhrase(pictoWords);
        if (sentence != null && sentence.startsWith(".")) sentence = sentence.replaceFirst(".", "");
      }

      sentence ??= pictoWords.map((e) => e.text).join(' ');
      await _tts.speak(sentence);

      show = false;
      notifyListeners();
    } else {
      for (var i = 0; i < pictoWords.length; i++) {
        selectedWord = i;
        scrollController.animateTo(
          i == 0 ? 0 : i * 45,
          duration: const Duration(microseconds: 50),
          curve: Curves.easeIn,
        );
        notifyListeners();
        await _tts.speak(pictoWords[i].text);
      }
      show = false;
      notifyListeners();
    }

    show = false;
    notifyListeners();

    if (patientState.state != null && patientState.user.patientSettings.layout.cleanup) {
      pictoWords.clear();
      await buildSuggestion();
      notify();
    }
  }

  void refreshPictograms() {
    if (suggestedPicts == null) return;

    int currentPage = suggestedPicts!.length ~/ suggestedQuantity;

    indexPage++;

    if (indexPage > currentPage) {
      indexPage = 0;
    }
    if (indexPage < 0) {
      indexPage = 0;
    }

    notifyListeners();
  }

  void scrollUp(ScrollController controller, double amount) {
    int currentPosition = controller.position.pixels.toInt();

    if (currentPosition == 0) return;

    controller.animateTo(
      currentPosition - amount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void scrollDown(ScrollController controller, double amount) {
    int currentPosition = controller.position.pixels.toInt();

    if (currentPosition >= controller.position.maxScrollExtent) return;

    controller.animateTo(
      currentPosition + amount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  Future<void> speakYes() async {
    await _tts.speak("global.yes".trl);
  }

  Future<void> speakNo() async {
    await _tts.speak("global.no".trl);
  }

  @override
  void dispose() {
    patientState.setUser(null);

    super.dispose();
  }
}

final AutoDisposeChangeNotifierProvider<HomeProvider> homeProvider = ChangeNotifierProvider.autoDispose<HomeProvider>((ref) {
  final pictogramService = GetIt.I<PictogramsRepository>();
  final groupsService = GetIt.I<GroupsRepository>();
  final sentencesService = GetIt.I<SentencesRepository>();
  final tts = ref.watch(ttsProvider);
  final patientState = ref.watch(patientNotifier.notifier);
  final userState = ref.watch(userProvider);

  final predictPictogram = GetIt.I<PredictPictogram>();
  final learnPictogram = GetIt.I<LearnPictogram>();

  final chatGptNotifier = ref.watch(chatGPTProvider.notifier);

  return HomeProvider(
    pictogramService,
    groupsService,
    sentencesService,
    tts,
    patientState,
    predictPictogram,
    learnPictogram,
    userState,
    chatGptNotifier,
  );
});
