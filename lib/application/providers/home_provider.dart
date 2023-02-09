import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/common/constants.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';
import 'package:ottaa_project_flutter/core/models/phrase_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/sentences_repository.dart';
import 'package:collection/collection.dart';
import 'package:ottaa_project_flutter/core/use_cases/learn_pictogram.dart';
import 'package:ottaa_project_flutter/core/use_cases/predict_pictogram.dart';

const String kStarterPictoId = "FWy18PiX2jLwZQF6-oNZR";

class HomeProvider extends ChangeNotifier {
  final PictogramsRepository _pictogramsService;
  final GroupsRepository _groupsService;
  final SentencesRepository _sentencesService;
  final PatientNotifier patientState;

  final TTSProvider _tts;

  final PredictPictogram predictPictogram;
  final LearnPictogram learnPictogram;

  HomeProvider(
    this._pictogramsService,
    this._groupsService,
    this._sentencesService,
    this._tts,
    this.patientState,
    this.predictPictogram,
    this.learnPictogram,
  );

  List<Phrase> mostUsedSentences = [];
  int indexForMostUsed = 0;

  Map<String, Picto> pictograms = {};
  Map<String, Group> groups = {};

  List<Picto> suggestedPicts = [];

  List<Picto> pictoWords = [];

  String suggestedIndex = kStarterPictoId;

  int suggestedQuantity = 4;

  bool confirmExit = false;

  void setSuggedtedQuantity(int quantity) {
    suggestedQuantity = quantity;
    notifyListeners();
  }

  void addPictogram(Picto picto) {
    pictoWords.add(picto);
    suggestedPicts.clear();
    buildSuggestion(picto.id);
    notifyListeners();
  }

  void removeLastPictogram() {
    pictoWords.removeLast();
    suggestedPicts.clear();
    Picto? lastPicto = pictoWords.lastOrNull;

    buildSuggestion(lastPicto?.id);
    notifyListeners();
  }

  Future<void> init() async {
    await fetchPictograms();
    buildSuggestion();
    notifyListeners();
  }

  Future<void> fetchMostUsedSentences() async {
    mostUsedSentences = await _sentencesService.fetchSentences(
      language: "es_AR", //TODO!: Fetch language code LANG-CODE
      type: kMostUsedSentences,
    );

    // if (result.isRight) {
    //   mostUsedSentences = result.right;
    // }

    notifyListeners();
  }

  Future<void> fetchPictograms() async {
    final pictos = (await _pictogramsService.getAllPictograms());
    final groupsData = await _groupsService.getAllGroups();
    pictograms = Map.fromIterables(pictos.map((e) => e.id), pictos);
    groups = Map.fromIterables(groupsData.map((e) => e.id), groupsData);
    notifyListeners();
  }

  Future<void> buildSuggestion([String? id]) async {
    id ??= kStarterPictoId;

    if (patientState.state != null && id != kStarterPictoId) {
      PatientUserModel user = patientState.user;

      final response = await predictPictogram.call(
        sentence: pictoWords.map((e) => e.text).join(" "),
        uid: user.id,
        language: user.settings.language,
        model: "test",
        groups: [],
        tags: {},
        reduced: false,
      );

      if (response.isRight) {
        print(response.right);

        List<Picto> picts = response.right.map((e) => pictograms[e.id["local"]]!).toList();

        suggestedPicts = picts.sublist(0, suggestedQuantity);
        notifyListeners();
      }

      return;
    }

    Picto? pict = pictograms[id];

    if (pict == null) return;

    print('the id of the pict is ${pict.id}');

    if (pict.relations.isNotEmpty) {
      final List<PictoRelation> recomendedPicts = pict.relations.toList();
      recomendedPicts.sort((b, a) => a.value.compareTo(b.value));
      suggestedPicts.addAll(predictiveAlgorithm(list: recomendedPicts));
      suggestedPicts = suggestedPicts.toSet().toList();
    }

    suggestedIndex = id;
    suggestedPicts = suggestedPicts.sublist(0, suggestedQuantity);
    return notifyListeners();
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
      e.freq = (list[i].value * pesoFrec) + (hora * pesoHora); //TODO: Check this with asim
    }

    requiredPicts.sort((b, a) => a.freq.compareTo(b.freq)); //TODO: Check this with assim too

    return requiredPicts;
  }

  Future<void> speakSentence() async {
    final sentence = pictoWords.map((e) => e.text).join(' ');
    await _tts.speak(sentence);
  }
}

final homeProvider = ChangeNotifierProvider.autoDispose<HomeProvider>((ref) {
  final pictogramService = GetIt.I<PictogramsRepository>();
  final groupsService = GetIt.I<GroupsRepository>();
  final sentencesService = GetIt.I<SentencesRepository>();
  final tts = ref.watch(ttsProvider);
  final patientState = ref.watch(patientNotifier.notifier);

  final predictPictogram = GetIt.I<PredictPictogram>();
  final learnPictogram = GetIt.I<LearnPictogram>();

  return HomeProvider(
    pictogramService,
    groupsService,
    sentencesService,
    tts,
    patientState,
    predictPictogram,
    learnPictogram,
  );
});
