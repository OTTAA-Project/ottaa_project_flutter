import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/common/constants.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/core/models/phrase_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/sentences_repository.dart';

class SentencesProvider extends ChangeNotifier {
  final SentencesRepository sentenceService;
  final TTSProvider _tts;
  final PictogramsRepository _pictogramsService;

  SentencesProvider(
    this.sentenceService,
    this._tts,
    this._pictogramsService,
  );

  // final _tts = Get.find<_tts>();
  // final _pictsRepository = Get.find<PictsRepository>();
  // final _sentencesRepository = Get.find<SentencesRepository>();
  // final dataController = Get.find<DataController>();
  final searchController = TextEditingController();
  bool showCircular = true;
  late AnimationController sentenceAnimationController;

  bool searchOrIcon = false;

  List<Picto> _picts = [];
  List<Phrase> sentences = [];
  List<Picto> _sentencePicts = [];
  List<List<Picto>> favouritePicts = [];
  List<Phrase> favouriteSentences = [];
  int currentFavIndex = 0;
  List<List<Picto>> favouriteOrNotPicts = [];
  List<Phrase> favouriteOrNotSentences = [];
  int currentFavOrNotIndex = 0;
  ScrollController favouriteSelectionController = ScrollController();
  final List<List<Picto>> _sentencesPicts = [];
  int _selectedIndexFavSelection = 0;
  int _selectedIndexFav = 0;

  List<List<Picto>> get sentencesPicts => _sentencesPicts;

  int _sentencesIndex = 0;
  int searchIndex = 0;

  int get sentencesIndex => _sentencesIndex;

  set sentencesIndex(value) {
    _sentencesIndex = value;

    if (sentencesIndex == sentencesPicts.length) {
      _sentencesIndex = 0;
    }
    if (sentencesIndex == -1) {
      _sentencesIndex = sentencesPicts.length - 1;
    }
    sentenceAnimationController.forward(from: 0.0);
    notifyListeners();
  }

  set selectedIndexFavSelection(value) {
    _selectedIndexFavSelection = value;

    if (_selectedIndexFavSelection == favouriteOrNotPicts.length) {
      _selectedIndexFavSelection = 0;
    }
    if (_selectedIndexFavSelection == -1) {
      _selectedIndexFavSelection = favouriteOrNotPicts.length - 1;
    }
    notifyListeners();
  }

  int get selectedIndexFavSelection => _selectedIndexFavSelection;

  set selectedIndexFav(value) {
    _selectedIndexFav = value;

    if (_selectedIndexFav == favouritePicts.length) {
      _selectedIndexFav = 0;
    }
    if (_selectedIndexFav == -1) {
      _selectedIndexFav = favouritePicts.length - 1;
    }
    notifyListeners();
  }

  int get selectedIndexFav => _selectedIndexFav;

  // sentences for searching list
  // List<SearchIndexedSentences> sentencesForSearch = [];
  // List<SearchIndexedSentences> sentencesForList = [];

  Future<void> inIt() async {
    await _loadSentences();
    fetchFavOrNot();
    createListForSearching();
    showCircular = false;
  }

  void setAnimationController(AnimationController anim) => sentenceAnimationController = anim;

  Future<void> saveFavourite() async {
    // List<SentenceModel> toBeSaved = [];
    // for (var element in sentences) {
    //   if (element.favouriteOrNot) {
    //     toBeSaved.add(element);
    //   }
    // }
    // await sentenceService.uploadSentences(
    //   //todo: add the language here
    //   language: 'es-AR',
    //   data: toBeSaved,
    //   type: kFavouriteSentences,
    // );
    // await fetchFavourites();
    // notifyListeners();
    // _selectedIndexFav = 0;
    // _selectedIndexFavSelection = 0;
  }

  Future<void> _loadSentences() async {
    _picts = await _pictogramsService.getAllPictograms();
    //todo: add the language here
    final language = 'es-AR';
    switch (language) {
      case "es-AR":
        sentences = await sentenceService.fetchSentences(
          language: language,
          type: kMostUsedSentences,
        );
        // if (res.isRight) {
        //   sentences = res.right;
        // }
        break;
      case "en-US":
        sentences = await sentenceService.fetchSentences(
          language: language,
          type: kMostUsedSentences,
        );
        // if (res.isRight) {
        //   sentences = res.right;
        // }
        break;
      case "fr-FR":
        sentences = await sentenceService.fetchSentences(
          language: language,
          type: kMostUsedSentences,
        );
        // if (res.isRight) {
        //   sentences = res.right;
        // }
        break;
      case "pt-BR":
        sentences = await sentenceService.fetchSentences(
          language: language,
          type: kMostUsedSentences,
        );
        // if (res.isRight) {
        //   sentences = res.right;
        // }
        break;
      default:
        sentences = await sentenceService.fetchSentences(
          language: language,
          type: kMostUsedSentences,
        );
        // if (res.isRight) {
        //   sentences = res.right;
        // }
        break;
    }

    ///sorting
    // Comparator<Phrase> sortById = (a, b) => a.frecuencia.compareTo(b.frecuencia);
    // sentences.sort(sortById);
    sentences = sentences.reversed.toList();
    if (sentences.length >= 10) {
      for (int i = 0; i <= 9; i++) {
        _sentencePicts = [];
        // for (var pictoComponente in sentences[i].complejidad.pictosComponentes) {
        //   _sentencePicts.add(_picts.firstWhere((pict) => pict.id == pictoComponente.id));
        // }
        _sentencesPicts.add(_sentencePicts);
      }
    } else {
      for (var sentence in sentences) {
        _sentencePicts = [];
        // for (var pictoComponente in sentence.complejidad.pictosComponentes) {
        //   _sentencePicts.add(_picts.firstWhere((pict) => pict.id == pictoComponente.id));
        // }
        _sentencesPicts.add(_sentencePicts);
      }
    }
    notifyListeners();
  }

  void fetchFavOrNot() {
    // Comparator<SentenceModel> sortById = (a, b) => a.frecuencia.compareTo(b.frecuencia);
    // sentences.sort(sortById);
    sentences = sentences.reversed.toList();
    for (var element in sentences) {
      _sentencePicts = [];
      for (var pictoComponente in element.sequence) {
        // if()
        //todo: will fix it when we will be working on the new UI, For now it is juts a lazy fix
        bool found = false;
        int index = -1;
        for (var element in _picts) {
          if (element.id == pictoComponente.id) {
            found = true;
          }
          index++;
        }
        // _picts.firstWhere((pict) => pict.id == pictoComponente.id);
        if (found) {
          _sentencePicts.add(_picts[index]);
        }
      }
      favouriteOrNotPicts.add(_sentencePicts);
    }
    print('the size is this: ${favouriteOrNotPicts.length}');
  }

  Future<void> fetchFavourites() async {
    //todo:
    final language = 'es-AR';
    switch (language) {
      case "es-AR":
        favouriteSentences = await sentenceService.fetchSentences(
          language: language,
          type: kFavouriteSentences,
          isFavorite: true,
        );
        // if (res.isRight) {
        //   favouriteSentences = res.right;
        // }

        break;
      case "en-US":
        favouriteSentences = await sentenceService.fetchSentences(
          language: language,
          type: kFavouriteSentences,
          isFavorite: true,
        );
        // if (res.isRight) {
        //   favouriteSentences = res.right;
        // }
        break;
      case "fr-FR":
        favouriteSentences = await sentenceService.fetchSentences(
          language: language,
          type: kFavouriteSentences,
          isFavorite: true,
        );
        // if (res.isRight) {
        //   favouriteSentences = res.right;
        // }
        break;
      case "pt-BR":
        favouriteSentences = await sentenceService.fetchSentences(
          language: language,
          type: kFavouriteSentences,
          isFavorite: true,
        );
        // if (res.isRight) {
        //   favouriteSentences = res.right;
        // }
        break;
      default:
        favouriteSentences = await sentenceService.fetchSentences(
          language: language,
          type: kFavouriteSentences,
          isFavorite: true,
        );
        // if (res.isRight) {
        //   favouriteSentences = res.right;
        // }
        break;
    }

    if (favouriteSentences.length >= 10) {
      for (int i = 0; i <= 9; i++) {
        _sentencePicts = [];
        for (var pictoComponente in favouriteSentences[i].sequence) {
          _sentencePicts.add(_picts.firstWhere((pict) => pict.id == pictoComponente.id));
        }
        favouritePicts.add(_sentencePicts);
      }
    } else {
      for (var sentence in favouriteSentences) {
        _sentencePicts = [];
        for (var pictoComponente in sentence.sequence) {
          _sentencePicts.add(_picts.firstWhere((pict) => pict.id == pictoComponente.id));
        }
        favouritePicts.add(_sentencePicts);
      }
    }
  }

  Future<void> speak() async {
    if (_sentencesPicts[_sentencesIndex].isNotEmpty) {
      String voiceText = "";
      for (var pict in _sentencesPicts[_sentencesIndex]) {
        //todo: add the language here too
        final language = 'es-AR'; //FUCK THE POLICE!!!
        voiceText += ' ${pict.text[language]}';
      }

      await _tts.speak(voiceText);
      // print(sentencesForSearch[_sentencesIndex].sentence);
      print(_sentencesIndex);
    }
  }

  Future<void> speakFavOrNot() async {
    if (favouriteOrNotPicts[_selectedIndexFavSelection].isNotEmpty) {
      String voiceText = "";
      for (var pict in favouriteOrNotPicts[_selectedIndexFavSelection]) {
        //todo: add teh language here
        voiceText += ' ${pict.text['es']}';

        ///TODO: Update this
      }

      await _tts.speak(voiceText);
      print(voiceText);
      notifyListeners();
      // print(favouriteOrNotPicts[this._selectedIndexFavSelection]);
      // print(favouriteOrNotPicts[this._sel);
    }
  }

  Future<void> speakFav() async {
    if (favouritePicts[_selectedIndexFav].isNotEmpty) {
      String voiceText = "";
      for (var pict in favouritePicts[_selectedIndexFav]) {
        //todo: add teh language here
        voiceText += ' ${pict.text['es']}';

        ///TODO: Update this
      }

      await _tts.speak(voiceText);
      print(voiceText);
      notifyListeners();
      // print(favouriteOrNotPicts[this._selectedIndexFavSelection]);
      // print(favouriteOrNotPicts[this._sel);
    }
  }

  Future<void> searchSpeak() async {
    // if (_sentencesPicts[sentencesForList[searchIndex].index].isNotEmpty) {
    //   String voiceText = "";
    //   for (var pict in _sentencesPicts[sentencesForList[searchIndex].index]) {
    //     //todo: add the language here
    //     switch ('es-AR') {
    //       // case "es-AR":
    //       //   voiceText += ' ' + pict.texto.es;
    //       //   break;
    //       case "es-AR":
    //         voiceText += ' ${pict.texto.es}';
    //         break;
    //       case "en-US":
    //         voiceText += ' ${pict.texto.en}';
    //         break;
    //       case "fr-FR":
    //         voiceText += ' ${pict.texto.fr}';
    //         break;
    //       case "pt-BR":
    //         voiceText += ' ${pict.texto.pt}';
    //         break;
    //       default:
    //         voiceText += ' ${pict.texto.es}';
    //     }
    //   }

    //   await _tts.speak(voiceText);
    //   print(sentencesForList[searchIndex].sentence);
    //   print('search index is $searchIndex');
    //   print('the index from controller is ${sentencesForList[searchIndex].index}');
    // }
  }

  Future<void> createListForSearching() async {
    int i = 0;
    for (var e1 in _sentencesPicts) {
      String sentence = '';
      // for (var e2 in e1) {
      //   //todo: add the language here
      //   switch ('es-AR') {
      //     // case "es":
      //     //   sentence += ' ' + e2.texto.es;
      //     //   break;
      //     case "es-AR":
      //       sentence += ' ${e2.texto.es}';
      //       break;
      //     case "en-US":
      //       sentence += ' ${e2.texto.en}';
      //       break;
      //     case "fr-FR":
      //       sentence += ' ${e2.texto.fr}';
      //       break;
      //     case "pt-BR":
      //       sentence += ' ${e2.texto.pt}';
      //       break;
      //     default:
      //       sentence += ' ${e2.texto.es}';
      //   }
      // }

      // sentencesForSearch.add(
      //   SearchIndexedSentences(sentence: sentence, index: i),
      // );
      i++;
    }
    // for (var element in sentencesForSearch) {
    //   print(element.sentence);
    // }
    // sentencesForList.addAll(sentencesForSearch);
  }

  Future<void> onChangedText(String v) async {
    // List<SearchIndexedSentences> listData = [];
    // if (v.isNotEmpty) {
    //   for (var element in sentencesForSearch) {
    //     final b = element.sentence.toUpperCase().contains(v.toString().toUpperCase(), 0);
    //     if (b) {
    //       listData.add(element);
    //     }
    //   }
    //   sentencesForList.clear();
    //   sentencesForList.addAll(listData);
    //   searchIndex = 0;
    //   print(sentencesForList.length);
    //   notifyListeners();
    // } else {
    //   sentencesForList.addAll(sentencesForSearch);
    //   searchIndex = 0;
    //   print(sentencesForList.length);
    //   notifyListeners();
    // }
  }

  void decrementOne() {
    if (searchIndex != 0) {
      searchIndex--;
    }
    notifyListeners();
    print(searchIndex);
  }

  void incrementOne() {
    // s
  }

  void changeSelectedIndexFavSelection(int index) {
    _selectedIndexFavSelection = index;
    notifyListeners();
  }

  void changeSelectedIndexFav(int index) {
    _selectedIndexFav = index;
    notifyListeners();
  }
}

final sentencesProvider = ChangeNotifierProvider<SentencesProvider>((ref) {
  final pictogramService = GetIt.I<PictogramsRepository>();

  final sentencesService = GetIt.I<SentencesRepository>();
  final tts = ref.watch(ttsProvider);

  return SentencesProvider(
    sentencesService,
    tts,
    pictogramService,
  );
});
