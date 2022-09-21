import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/models/sentence_model.dart';
import 'package:ottaa_project_flutter/app/data/repositories/picts_repository.dart';
import 'package:ottaa_project_flutter/app/data/repositories/sentences_repository.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/utils/constants.dart';

class SentencesController extends GetxController {
  final _ttsController = Get.find<TTSController>();
  final _pictsRepository = Get.find<PictsRepository>();
  final _sentencesRepository = Get.find<SentencesRepository>();
  final dataController = Get.find<DataController>();
  final searchController = TextEditingController();
  RxBool showCircular = true.obs;
  late AnimationController _sentenceAnimationController;

  AnimationController get sentenceAnimationController =>
      this._sentenceAnimationController;

  set sentenceAnimationController(AnimationController value) {
    this._sentenceAnimationController = value;
  }

  RxBool searchOrIcon = false.obs;

  List<Pict> _picts = [];
  List<Sentence> sentences = [];
  List<Pict> _sentencePicts = [];
  List<List<Pict>> favouritePicts = [];
  List<Sentence> favouriteSentences = [];
  RxInt currentFavIndex = 0.obs;
  List<List<Pict>> favouriteOrNotPicts = [];
  List<Sentence> favouriteOrNotSentences = [];
  RxInt currentFavOrNotIndex = 0.obs;
  ScrollController favouriteSelectionController = ScrollController();
  List<List<Pict>> _sentencesPicts = [];
  int _selectedIndexFavSelection = 0;
  int _selectedIndexFav = 0;

  List<List<Pict>> get sentencesPicts => this._sentencesPicts;

  int _sentencesIndex = 0;
  int searchIndex = 0;

  int get sentencesIndex => this._sentencesIndex;

  set sentencesIndex(value) {
    this._sentencesIndex = value;

    if (this.sentencesIndex == this.sentencesPicts.length)
      this._sentencesIndex = 0;
    if (this.sentencesIndex == -1)
      this._sentencesIndex = this.sentencesPicts.length - 1;
    this.sentenceAnimationController.forward(from: 0.0);
    update();
  }

  set selectedIndexFavSelection(value) {
    this._selectedIndexFavSelection = value;

    if (this._selectedIndexFavSelection == this.favouriteOrNotPicts.length)
      this._selectedIndexFavSelection = 0;
    if (this._selectedIndexFavSelection == -1)
      this._selectedIndexFavSelection = this.favouriteOrNotPicts.length - 1;
    update();
  }

  int get selectedIndexFavSelection => this._selectedIndexFavSelection;

  set selectedIndexFav(value) {
    this._selectedIndexFav = value;

    if (this._selectedIndexFav == this.favouriteOrNotPicts.length)
      this._selectedIndexFav = 0;
    if (this._selectedIndexFav == -1)
      this._selectedIndexFav = this.favouriteOrNotPicts.length - 1;
    update();
  }

  int get selectedIndexFav => this._selectedIndexFav;

  // sentences for searching list
  List<SearchIndexedSentences> sentencesForSearch = [];
  List<SearchIndexedSentences> sentencesForList = [];

  @override
  void onInit() async {
    super.onInit();
    await _loadPicts();
    fetchFavOrNot();
    createListForSearching();
    showCircular.value = false;
  }

  Future<void> saveFavourite() async {
    List<Sentence> toBeSaved = [];
    sentences.forEach((element) {
      if (element.favouriteOrNot) {
        toBeSaved.add(element);
      }
    });
    List<String> dataUpload = [];
    toBeSaved.forEach((element) {
      final obj = jsonEncode(element);
      dataUpload.add(obj);
    });
    await dataController.uploadFrases(
      language: _ttsController.languaje,
      data: dataUpload.toString(),
      type: Constants.FAVOURITE_SENTENCES,
    );
    await fetchFavourites();
    update(["favourite_sentences"]);
    this._selectedIndexFav = 0;
    this._selectedIndexFavSelection = 0;
  }

  Future<void> _loadPicts() async {
    this._picts = await this._pictsRepository.getAll();
    final language = _ttsController.languaje;
    switch (language) {
      case "es-AR":
        this.sentences = await this._sentencesRepository.getAll(
              language: language,
              type: Constants.MOST_USED_SENTENCES,
            );
        break;
      case "en-US":
        this.sentences = await this._sentencesRepository.getAll(
              language: language,
              type: Constants.MOST_USED_SENTENCES,
            );
        break;
      case "fr-FR":
        this.sentences = await this._sentencesRepository.getAll(
              language: language,
              type: Constants.MOST_USED_SENTENCES,
            );
        break;
      case "pt-BR":
        this.sentences = await this._sentencesRepository.getAll(
              language: language,
              type: Constants.MOST_USED_SENTENCES,
            );
        break;
      default:
        this.sentences = await this._sentencesRepository.getAll(
              language: language,
              type: Constants.MOST_USED_SENTENCES,
            );
    }

    ///sorting
    Comparator<Sentence> sortById =
        (a, b) => a.frecuencia.compareTo(b.frecuencia);
    sentences.sort(sortById);
    sentences = sentences.reversed.toList();
    if (sentences.length >= 10) {
      for (int i = 0; i <= 9; i++) {
        this._sentencePicts = [];
        sentences[i].complejidad.pictosComponentes.forEach((pictoComponente) {
          this
              ._sentencePicts
              .add(_picts.firstWhere((pict) => pict.id == pictoComponente.id));
        });
        this._sentencesPicts.add(this._sentencePicts);
      }
    } else {
      this.sentences.forEach((sentence) {
        this._sentencePicts = [];
        sentence.complejidad.pictosComponentes.forEach((pictoComponente) {
          this
              ._sentencePicts
              .add(_picts.firstWhere((pict) => pict.id == pictoComponente.id));
        });
        this._sentencesPicts.add(this._sentencePicts);
      });
    }
    update();
  }

  void fetchFavOrNot() {
    Comparator<Sentence> sortById =
        (a, b) => a.frecuencia.compareTo(b.frecuencia);
    sentences.sort(sortById);
    sentences = sentences.reversed.toList();
    sentences.forEach((element) {
      this._sentencePicts = [];
      element.complejidad.pictosComponentes.forEach((pictoComponente) {
        this
            ._sentencePicts
            .add(_picts.firstWhere((pict) => pict.id == pictoComponente.id));
      });
      this.favouriteOrNotPicts.add(this._sentencePicts);
    });
    print('the size is this: ${favouriteOrNotPicts.length}');
  }

  Future<void> fetchFavourites() async {
    final language = _ttsController.languaje;
    switch (language) {
      case "es-AR":
        this.favouriteSentences =
            await this._sentencesRepository.fetchFavouriteFrases(
                  language: language,
                  type: Constants.FAVOURITE_SENTENCES,
                );
        break;
      case "en-US":
        this.favouriteSentences =
            await this._sentencesRepository.fetchFavouriteFrases(
                  language: language,
                  type: Constants.FAVOURITE_SENTENCES,
                );
        break;
      case "fr-FR":
        this.favouriteSentences =
            await this._sentencesRepository.fetchFavouriteFrases(
                  language: language,
                  type: Constants.FAVOURITE_SENTENCES,
                );
        break;
      case "pt-BR":
        this.favouriteSentences =
            await this._sentencesRepository.fetchFavouriteFrases(
                  language: language,
                  type: Constants.FAVOURITE_SENTENCES,
                );
        break;
      default:
        this.favouriteSentences =
            await this._sentencesRepository.fetchFavouriteFrases(
                  language: language,
                  type: Constants.FAVOURITE_SENTENCES,
                );
    }

    if (favouriteSentences.length >= 10) {
      for (int i = 0; i <= 9; i++) {
        this._sentencePicts = [];
        favouriteSentences[i]
            .complejidad
            .pictosComponentes
            .forEach((pictoComponente) {
          this
              ._sentencePicts
              .add(_picts.firstWhere((pict) => pict.id == pictoComponente.id));
        });
        this.favouritePicts.add(this._sentencePicts);
      }
    } else {
      this.favouriteSentences.forEach((sentence) {
        this._sentencePicts = [];
        sentence.complejidad.pictosComponentes.forEach((pictoComponente) {
          this
              ._sentencePicts
              .add(_picts.firstWhere((pict) => pict.id == pictoComponente.id));
        });
        this.favouritePicts.add(this._sentencePicts);
      });
    }
  }

  Future<void> speak() async {
    if (this._sentencesPicts[this._sentencesIndex].isNotEmpty) {
      String voiceText = "";
      this._sentencesPicts[this._sentencesIndex].forEach((pict) {
        switch (this._ttsController.languaje) {
          // case "es-AR":
          //   voiceText += ' ' + pict.texto.es;
          //   break;
          case "es-AR":
            voiceText += ' ' + pict.texto.es;
            break;
          case "en-US":
            voiceText += ' ' + pict.texto.en;
            break;
          case "fr-FR":
            voiceText += ' ' + pict.texto.fr;
            break;
          case "pt-BR":
            voiceText += ' ' + pict.texto.pt;
            break;
          default:
            voiceText += ' ' + pict.texto.es;
        }
      });

      await this._ttsController.speak(voiceText);
      print(sentencesForSearch[this._sentencesIndex].sentence);
      print(this._sentencesIndex);
    }
  }

  Future<void> speakFavOrNot() async {
    if (this.favouriteOrNotPicts[this._selectedIndexFavSelection].isNotEmpty) {
      String voiceText = "";
      this.favouriteOrNotPicts[this._selectedIndexFavSelection].forEach((pict) {
        switch (this._ttsController.languaje) {
          // case "es-AR":
          //   voiceText += ' ' + pict.texto.es;
          //   break;
          case "es-AR":
            voiceText += ' ' + pict.texto.es;
            break;
          case "en-US":
            voiceText += ' ' + pict.texto.en;
            break;
          case "fr-FR":
            voiceText += ' ' + pict.texto.fr;
            break;
          case "pt-BR":
            voiceText += ' ' + pict.texto.pt;
            break;
          default:
            voiceText += ' ' + pict.texto.es;
        }
      });

      await this._ttsController.speak(voiceText);
      print(voiceText);
      update();
      // print(favouriteOrNotPicts[this._selectedIndexFavSelection]);
      // print(favouriteOrNotPicts[this._sel);
    }
  }

  Future<void> searchSpeak() async {
    if (this._sentencesPicts[sentencesForList[searchIndex].index].isNotEmpty) {
      String voiceText = "";
      this._sentencesPicts[sentencesForList[searchIndex].index].forEach((pict) {
        switch (this._ttsController.languaje) {
          // case "es-AR":
          //   voiceText += ' ' + pict.texto.es;
          //   break;
          case "es-AR":
            voiceText += ' ' + pict.texto.es;
            break;
          case "en-US":
            voiceText += ' ' + pict.texto.en;
            break;
          case "fr-FR":
            voiceText += ' ' + pict.texto.fr;
            break;
          case "pt-BR":
            voiceText += ' ' + pict.texto.pt;
            break;
          default:
            voiceText += ' ' + pict.texto.es;
        }
      });

      await this._ttsController.speak(voiceText);
      print(sentencesForList[searchIndex].sentence);
      print('search index is $searchIndex');
      print(
          'the index from controller is ${sentencesForList[searchIndex].index}');
    }
  }

  Future<void> createListForSearching() async {
    int i = 0;
    _sentencesPicts.forEach((e1) {
      String sentence = '';
      e1.forEach((e2) {
        switch (_ttsController.languaje) {
          // case "es":
          //   sentence += ' ' + e2.texto.es;
          //   break;
          case "es-AR":
            sentence += ' ' + e2.texto.es;
            break;
          case "en-US":
            sentence += ' ' + e2.texto.en;
            break;
          case "fr-FR":
            sentence += ' ' + e2.texto.fr;
            break;
          case "pt-BR":
            sentence += ' ' + e2.texto.pt;
            break;
          default:
            sentence += ' ' + e2.texto.es;
        }
      });

      sentencesForSearch.add(
        SearchIndexedSentences(sentence: sentence, index: i),
      );
      i++;
    });
    sentencesForSearch.forEach((element) {
      print(element.sentence);
    });
    sentencesForList.addAll(sentencesForSearch);
  }

  Future<void> onChangedText(String v) async {
    List<SearchIndexedSentences> listData = [];
    if (v.length != 0) {
      sentencesForSearch.forEach((element) {
        final b = element.sentence
            .toUpperCase()
            .contains(v.toString().toUpperCase(), 0);
        if (b) {
          listData.add(element);
        }
      });
      sentencesForList.clear();
      sentencesForList.addAll(listData);
      searchIndex = 0;
      print(sentencesForList.length);
      update(['searchBuilder']);
    } else {
      sentencesForList.addAll(sentencesForSearch);
      searchIndex = 0;
      print(sentencesForList.length);
      update(['searchBuilder']);
    }
  }

  void decrementOne() {
    if (searchIndex != 0) {
      searchIndex--;
    }
    update(['searchBuilder']);
    print(searchIndex);
  }

  void incrementOne() {
    if (sentencesForList.length - 1 != searchIndex) {
      searchIndex++;
    }
    update(['searchBuilder']);
    print(searchIndex);
  }

}

class SearchIndexedSentences {
  SearchIndexedSentences({
    required this.sentence,
    required this.index,
  });

  final String sentence;
  final int index;
}
