import 'dart:async';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/models/sentence_model.dart';
import 'package:ottaa_project_flutter/app/data/repositories/picts_repository.dart';
import 'package:ottaa_project_flutter/app/data/repositories/sentences_repository.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/sentences/models/search_indexed_sentences.dart';

class SentencesController extends GetxController {
  final _ttsController = Get.find<TTSController>();

  final _pictsRepository = Get.find<PictsRepository>();
  final _sentencesRepository = Get.find<SentencesRepository>();
  final searchController = TextEditingController();
  RxBool showCircular = true.obs;
  late AnimationController sentenceAnimationController;

  RxBool searchOrIcon = false.obs;

  List<Pict> _picts = [];
  List<Sentence> _sentences = [];
  List<Pict> _sentencePicts = [];

  final List<List<Pict>> _sentencesPicts = [];

  List<List<Pict>> get sentencesPicts => _sentencesPicts;

  int _sentencesIndex = 0;
  int searchIndex = 0;

  int get sentencesIndex => _sentencesIndex;

  set sentencesIndex(value) {
    _sentencesIndex = value;

    if (sentencesIndex == sentencesPicts.length) _sentencesIndex = 0;
    if (sentencesIndex == -1) _sentencesIndex = sentencesPicts.length - 1;
    sentenceAnimationController.forward(from: 0.0);
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
    _picts = await _pictsRepository.getAll();
    _sentences = await _sentencesRepository.getAll();

    for (var sentence in _sentences) {
      _sentencePicts = [];
      for (var pictoComponente in sentence.complejidad.pictosComponentes) {
        _sentencePicts.add(_picts.firstWhere((pict) => pict.id == pictoComponente.id));
      }
      _sentencesPicts.add(_sentencePicts);
    }
    update();
  }

  Future<void> speak() async {
    if (_sentencesPicts[_sentencesIndex].isNotEmpty) {
      String voiceText = "";
      for (var pict in _sentencesPicts[_sentencesIndex]) {
        switch (_ttsController.languaje) {
          case "es":
            voiceText += ' ${pict.texto.es}';
            break;
          case "en":
            voiceText += ' ${pict.texto.en}';
            break;

          default:
            voiceText += ' ${pict.texto.en}';
        }
      }

      await _ttsController.speak(voiceText);
      print(sentencesForSearch[_sentencesIndex].sentence);
      print(_sentencesIndex);
    }
  }

  Future<void> searchSpeak() async {
    if (_sentencesPicts[sentencesForList[searchIndex].index].isNotEmpty) {
      String voiceText = "";
      for (var pict in _sentencesPicts[sentencesForList[searchIndex].index]) {
        switch (_ttsController.languaje) {
          case "es":
            voiceText += ' ${pict.texto.es}';
            break;
          case "en":
            voiceText += ' ${pict.texto.en}';
            break;
          default:
            voiceText += ' ${pict.texto.en}';
        }
      }

      await _ttsController.speak(voiceText);
      print(sentencesForList[searchIndex].sentence);
      print('search index is $searchIndex');
      print('the index from controller is ${sentencesForList[searchIndex].index}');
    }
  }

  Future<void> createListForSearching() async {
    int i = 0;
    for (var pictograms in _sentencesPicts) {
      String sentence = '';
      for (var setences in pictograms) {
        switch (_ttsController.languaje) {
          case "es":
            sentence += ' ${setences.texto.es}';
            break;
          case "en":
            sentence += ' ${setences.texto.en}';
            break;
          default:
            sentence += ' ${setences.texto.en}';
        }
      }

      sentencesForSearch.add(
        SearchIndexedSentences(sentence: sentence, index: i),
      );
      i++;
    }
    for (var sentencesIndexed in sentencesForSearch) {
      print(sentencesIndexed.sentence);
    }
    sentencesForList.addAll(sentencesForSearch);
  }

  Future<void> onChangedText(String text) async {
    List<SearchIndexedSentences> listData = [];
    if (text.isNotEmpty) {
      for (var sentenceIndexed in sentencesForSearch) {
        final b = sentenceIndexed.sentence.toUpperCase().contains(text.toString().toUpperCase(), 0);
        if (b) {
          listData.add(sentenceIndexed);
        }
      }
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
