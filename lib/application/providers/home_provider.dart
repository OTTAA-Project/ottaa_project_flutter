import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/common/constants.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/phrase_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/sentences_repository.dart';
import 'package:collection/collection.dart';

class HomeProvider extends ChangeNotifier {
  final PictogramsRepository _pictogramsService;
  final GroupsRepository _groupsService;
  final SentencesRepository _sentencesService;

  final TTSProvider _tts;

  HomeProvider(this._pictogramsService, this._groupsService,
      this._sentencesService, this._tts);

  List<Phrase> mostUsedSentences = [];
  int indexForMostUsed = 0;

  List<Picto> pictograms = [];
  List<Group> groups = [];

  List<Picto> suggestedPicts = [];

  List<Picto> pictoWords = [];

  String suggestedId = 'FWy18PiX2jLwZQF6-oNZR';

  int suggestedQuantity = 4;

  int wordsQuantity = 6;

  //talk feature
  bool talkEnabled = true;
  bool show = false;
  String selectedWord = '';
  ScrollController scrollController = ScrollController();

  void setSuggedtedQuantity(int quantity) {
    suggestedQuantity = quantity;
    notifyListeners();
  }

  void setWordQuantity(int quantity) {
    wordsQuantity = quantity;
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
    int pictoIndex = pictoWords.length - 1;
    suggestedPicts.clear();
    if (pictoIndex == -1) {
      buildSuggestion();
      notifyListeners();
      return;
    }
    buildSuggestion(pictoWords.last.id);
    notifyListeners();
  }

  Future<void> init() async {
    await fetchPictograms();
    buildSuggestion('FWy18PiX2jLwZQF6-oNZR');
    notifyListeners();
  }

  Future<void> fetchMostUsedSentences() async {
    mostUsedSentences = await _sentencesService.fetchSentences(
      language: "es-AR", //TODO!: Fetch language code LANG-CODE
      type: kMostUsedSentences,
    );

    // if (result.isRight) {
    //   mostUsedSentences = result.right;
    // }

    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  Future<void> fetchPictograms() async {
    pictograms = await _pictogramsService.getAllPictograms();
    groups = await _groupsService.getAllGroups();
    notifyListeners();
  }

  void buildSuggestion([String? id]) {
    id ??= 'FWy18PiX2jLwZQF6-oNZR';

    Picto? pict =
        pictograms.firstWhereIndexedOrNull((index, picto) => picto.id == id);

    if (pict == null) return;

    print('the id of the pict is ${pict.id}');

    if (pict.relations.isNotEmpty) {
      final List<PictoRelation> recomendedPicts = pict.relations.toList();
      recomendedPicts.sort((b, a) => a.value.compareTo(b.value));
      suggestedPicts.addAll(predictiveAlgorithm(list: recomendedPicts));
      suggestedPicts = suggestedPicts.toSet().toList();
    } else {
      print(
          'it is for you hector san to tell us what to do over here. If you have found this message contact us.');
    }

    suggestedId = id;
    return notifyListeners();
    // if (suggestedPicts.length >= suggestedQuantity) {
    //   suggestedPicts = suggestedPicts.sublist(0, suggestedQuantity);
    //
    // }
  }

  List<Picto> predictiveAlgorithm({required List<PictoRelation> list}) {
    const int pesoFrec = 2, pesoHora = 50;
    final time = DateTime.now().hour;

    List<Picto> requiredPicts = [];

    for (var recommendedPict in list) {
      requiredPicts.add(
        pictograms.firstWhere(
            (suggestedPict) => suggestedPict.id == recommendedPict.id),
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
      e.freq = (list[i].value * pesoFrec) +
          (hora * pesoHora); //TODO: Check this with asim
    }

    requiredPicts.sort(
        (b, a) => a.freq.compareTo(b.freq)); //TODO: Check this with assim too

    return requiredPicts;
  }

  Future<void> speakSentence() async {
    if (!talkEnabled) {
      final sentence = pictoWords.map((e) => e.text).join(' ');
      await _tts.speak(sentence);
    } else {
      show = true;
      notifyListeners();
      print('totoal values are');
      print(scrollController.position.maxScrollExtent);
      int i = 0;
      for (var e in pictoWords) {
        selectedWord = e.text;
        scrollController.animateTo(
          i == 0 ? 0 : i * 45,
          duration: Duration(microseconds: 50),
          curve: Curves.easeIn,
        );
        notifyListeners();
        await _tts.speak(e.text);
        i++;
      }
      scrollController.animateTo(
        0,
        duration: Duration(microseconds: 50),
        curve: Curves.easeIn,
      );
      show = false;
      notifyListeners();
    }
  }
}

final homeProvider = ChangeNotifierProvider<HomeProvider>((ref) {
  final pictogramService = GetIt.I<PictogramsRepository>();
  final groupsService = GetIt.I<GroupsRepository>();
  final sentencesService = GetIt.I<SentencesRepository>();
  final tts = ref.watch(ttsProvider);

  return HomeProvider(pictogramService, groupsService, sentencesService, tts);
});
