import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/common/constants.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/core/models/groups_model.dart';
import 'package:ottaa_project_flutter/core/models/pictogram_model.dart';
import 'package:ottaa_project_flutter/core/models/sentence_model.dart';
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/sentences_repository.dart';

class HomeProvider extends ChangeNotifier {
  final PictogramsRepository _pictogramsService;
  final GroupsRepository _groupsService;
  final SentencesRepository _sentencesService;

  final TTSProvider _tts;

  HomeProvider(this._pictogramsService, this._groupsService, this._sentencesService, this._tts);

  List<SentenceModel> mostUsedSentences = [];
  int indexForMostUsed = 0;

  List<Pict> pictograms = [];
  List<Groups> groups = [];

  List<Pict> suggestedPicts = [];

  int suggestedIndex = 0;

  int suggestedQuantity = 4;

  Future<void> init() async {
    await fetchPictograms();
    buildSuggestion(0);
    notifyListeners();
  }

  Future<void> fetchMostUsedSentences() async {
    mostUsedSentences = await _sentencesService.fetchSentences(
      language: "", //TODO!: Fetch language code LANG-CODE
      type: Constants.kMostUsedSentences,
    );
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

    final Pict addPict = Pict(
      id: 0,
      texto: Texto(en: "add", es: "agregar"),
      tipo: 6,
      imagen: Imagen(picto: "ic_agregar_nuevo"),
      localImg: true,
    );

    final Pict pict = pictograms.firstWhere((pict) => pict.id == id);
    print('the id of the pict is ${pict.id}');

    if (pict.relacion!.isNotEmpty) {
      final List<Relacion> recomendedPicts = pict.relacion!.toList();
      recomendedPicts.sort((b, a) => a.frec!.compareTo(b.frec!));
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

  List<Pict> predictiveAlgorithm({required List<Relacion> list}) {
    const int pesoFrec = 2,
        // pesoAgenda = 8,
        // pesoGps = 12,
        // pesoEdad = 5,
        // pesoSexo = 3,
        pesoHora = 50;
    final time = DateTime.now().hour;

    List<Pict> requiredPicts = [];

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
      if (e.hora == null) {
        hora = 0;
      } else {
        for (var e in e.hora!) {
          if (tag == e) {
            hora = 1;
          }
        }
      }
      e.score = (list[i].frec! * pesoFrec) + (hora * pesoHora);
      // print(e.score);
    }

    requiredPicts.sort((b, a) => a.score!.compareTo(b.score!));

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
