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

  late AnimationController _sentenceAnimationController;
  AnimationController get sentenceAnimationController =>
      this._sentenceAnimationController;
  set sentenceAnimationController(AnimationController value) {
    this._sentenceAnimationController = value;
  }

  List<Pict> _picts = [];
  List<Sentence> _sentences = [];
  List<Pict> _sentencePicts = [];

  List<List<Pict>> _sentencesPicts = [];
  List<List<Pict>> get sentencesPicts => this._sentencesPicts;

  int _sentencesIndex = 0;
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

  @override
  void onInit() async {
    super.onInit();
    await _loadPicts();
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
      print("object");
      this._sentencesPicts.add(this._sentencePicts);
    });
    update();
  }

  Future speak() async {
    if (this._sentencesPicts[this._sentencesIndex].isNotEmpty) {
      String voiceText = "";
      this._sentencesPicts[this._sentencesIndex].forEach((pict) {
        switch (this._ttsController.languaje) {
          case "es-US":
            voiceText += pict.texto.es;
            break;
          case "en-US":
            voiceText += pict.texto.en;
            break;

          default:
            voiceText += pict.texto.es;
        }
      });

      await this._ttsController.speak(voiceText);
    }
  }
}
