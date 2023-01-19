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

class HomeProvider extends ChangeNotifier {
  final PictogramsRepository _pictogramsService;
  final GroupsRepository _groupsService;
  final SentencesRepository _sentencesService;

  final TTSProvider _tts;

  HomeProvider(this._pictogramsService, this._groupsService, this._sentencesService, this._tts);

  List<Phrase> mostUsedSentences = [];
  int indexForMostUsed = 0;

  List<Picto> pictograms = [];
  List<Group> groups = [];

  List<Picto> suggestedPicts = [];

  int suggestedIndex = 0;

  int suggestedQuantity = 4;

  Future<void> init() async {
    await fetchPictograms();
    buildSuggestion(0);
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
    pictograms = await _pictogramsService.getAllPictograms();
    groups = await _groupsService.getAllGroups();
    notifyListeners();
  }

  void buildSuggestion(int id) {
    suggestedPicts = [];
    suggestedIndex = 0;

    final Picto addPict = Picto(
      id: "",
      text: "Agregar nuevo pictograma",
      type: 6,
      resource: AssetsImage(asset: "ic_agregar_nuevo", network: ""),
    );

    final Picto pict = pictograms.firstWhere((pict) => pict.id == id);
    print('the id of the pict is ${pict.id}');

    if (pict.relations.isNotEmpty) {
      final List<PictoRelation> recomendedPicts = pict.relations.toList();
      // recomendedPicts.sort((b, a) => a.frec!.compareTo(b.frec!)); //TODO: Check this with assim
      suggestedPicts = predictiveAlgorithm(list: recomendedPicts);
    } else {
      suggestedPicts = [];
    }

    ///
    /// predictive algorithm will replace teh code from here

    // recomendedPicts.forEach((recommendedPict) {
    //   this._suggestedPicts.add(picts.firstWhere(
    //       (suggestedPict) => suggestedPict.id == recommendedPict.id));
    // });

    /// to here
    ///
    suggestedPicts.add(addPict);

    while (suggestedPicts.isEmpty || suggestedPicts.length % suggestedQuantity != 0) {
      suggestedPicts.add(addPict);
    }

    notifyListeners();
  }

  List<Picto> predictiveAlgorithm({required List<PictoRelation> list}) {
    const int pesoFrec = 2,
        // pesoAgenda = 8,
        // pesoGps = 12,
        // pesoEdad = 5,
        // pesoSexo = 3,
        pesoHora = 50;
    final time = DateTime.now().hour;

    List<Picto> requiredPicts = [];

    for (var recommendedPict in list) {
      requiredPicts.add(
        pictograms.firstWhere((suggestedPict) => suggestedPict.id == recommendedPict.id),
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
      // e.freq = (list[i].value! * pesoFrec) + (hora * pesoHora); //TODO: Check this with asim
      // print(e.score);
    }

    // requiredPicts.sort((b, a) => a.score!.compareTo(b.score!)); //TODO: Check this with assim too

    return requiredPicts;
  }
}

final homeProvider = ChangeNotifierProvider<HomeProvider>((ref) {
  final pictogramService = GetIt.I<PictogramsRepository>();
  final groupsService = GetIt.I<GroupsRepository>();
  final sentencesService = GetIt.I<SentencesRepository>();
  final tts = ref.watch(ttsProvider);

  return HomeProvider(pictogramService, groupsService, sentencesService, tts);
});
