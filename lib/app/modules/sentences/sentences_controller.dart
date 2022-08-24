import 'dart:async';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/models/sentence_model.dart';
import 'package:ottaa_project_flutter/app/data/repositories/picts_repository.dart';
import 'package:ottaa_project_flutter/app/data/repositories/sentences_repository.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';

class SentencesController extends GetxController {
  final _ttsController = Get.find<TTSController>();

  final _pictsRepository = Get.find<PictsRepository>();
  final _sentencesRepository = Get.find<SentencesRepository>();
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
  List<Sentence> _sentences = [];
  List<Pict> _sentencePicts = [];

  List<List<Pict>> _sentencesPicts = [];

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

  // sentences for searching list
  List<SearchIndexedSentences> sentencesForSearch = [];
  List<SearchIndexedSentences> sentencesForList = [];

  @override
  void onInit() async {
    super.onInit();
    await _loadPicts();
    createListForSearching();
    showCircular.value = false;
  }

  Future<void> _loadPicts() async {
    this._picts = await this._pictsRepository.getAll();
    this._sentences = await this._sentencesRepository.getAll();

    this._sentences.forEach((sentence) {
      this._sentencePicts = [];
      sentence.complejidad.pictosComponentes.forEach((pictoComponente) {
        this
            ._sentencePicts
            .add(_picts.firstWhere((pict) => pict.id == pictoComponente.id));
      });
      this._sentencesPicts.add(this._sentencePicts);
    });
    update();
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
          case "pt-br":
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
          case "pt-br":
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
    this._sentencesPicts.forEach((e1) {
      String sentence = '';
      e1.forEach((e2) {
        switch (this._ttsController.languaje) {
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
          case "pt-br":
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
