import 'dart:async';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';

import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/repositories/grupos_repository.dart';
import 'package:ottaa_project_flutter/app/data/repositories/picts_repository.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';

class HomeController extends GetxController {
  final _ttsController = Get.find<TTSController>();

  TTSController get ttsController => this._ttsController;

  final _pictsRepository = Get.find<PictsRepository>();
  final _grupoRepository = Get.find<GrupoRepository>();

  late AnimationController _pictoAnimationController;

  AnimationController get pictoAnimationController =>
      this._pictoAnimationController;

  set pictoAnimationController(AnimationController value) {
    this._pictoAnimationController = value;
  }

  String _voiceText = "";

  String get voiceText => this._voiceText;

  List<Pict> picts = [];
  List<Grupos> grupos = [];

  List<Pict> _suggestedPicts = [];

  List<Pict> get suggestedPicts => this._suggestedPicts;

  int _suggestedIndex = 0;

  int get suggestedIndex => this._suggestedIndex;

  int _suggestedQuantity = 4;

  int get suggestedQuantity => this._suggestedQuantity;

  // set suggestedQuantity(value) {
  //   this._suggestedQuantity = value;
  //   this._suggestedIndex = 0;
  // }

  List<Pict> _sentencePicts = [];

  List<Pict> get sentencePicts => this._sentencePicts;
  int addId  = 0;
  int toId = 0;
  bool fromAdd = false;


  late Pict pictToBeEdited;

  @override
  void onInit() async {
    super.onInit();
    await _loadPicts();
  }

  addPictToSentence(Pict pict) {
    this._sentencePicts.add(pict);
    suggest(this._sentencePicts.last.id);
  }

  Future<void> _loadPicts() async {
    this.picts = await this._pictsRepository.getAll();
    this.grupos = await this._grupoRepository.getAll();
    suggest(0);
    update(["suggested"]);
  }

  void moreSuggested() {
    if (this._suggestedPicts.length % this._suggestedQuantity != 0)
      suggest(this._sentencePicts.isNotEmpty ? this._sentencePicts.last.id : 0);
    if (this._suggestedPicts.length >
        (this._suggestedIndex + 1) * this._suggestedQuantity) {
      this._suggestedIndex++;
    } else {
      this._suggestedIndex = 0;
    }
    if (this._suggestedPicts.length != this.suggestedQuantity)
      this._pictoAnimationController.forward(from: 0.0);
    update(["suggested"]);
  }

  removePictFromSentence() {
    if (this._sentencePicts.isNotEmpty) {
      this._sentencePicts.removeLast();
      this._suggestedIndex = 0;
      suggest(this._sentencePicts.isNotEmpty ? this._sentencePicts.last.id : 0);
    }
  }

  bool hasText() {
    if (this._voiceText != "") return true;
    return false;
  }

  Future speak() async {
    if (this._sentencePicts.isNotEmpty) {
      this._voiceText = "";
      this._sentencePicts.forEach((pict) {
        switch (this._ttsController.languaje) {
          case "es":
            this._voiceText += "${pict.texto.es} ";
            break;
          case "en":
            this._voiceText += "${pict.texto.en} ";
            break;

          default:
            this._voiceText += "${pict.texto.es} ";
        }
      });
      update(["subtitle"]);
      print(hasText());
      await this._ttsController.speak(this._voiceText);
      this._suggestedIndex = 0;
      this._sentencePicts.clear();
      this.suggest(0);
      await Future.delayed(new Duration(seconds: 3), () {
        this._voiceText = "";
        update(["subtitle"]);
      });
    }
  }

  Future<void> suggest(int id) async {
    this._suggestedPicts = [];
    this._suggestedIndex = 0;

    final Pict addPict = Pict(
      id: 0,
      texto: Texto(en: "add", es: "agregar"),
      tipo: 6,
      imagen: Imagen(picto: "ic_agregar_nuevo"),
      localImg: true,
    );

    final Pict pict = picts.firstWhere((pict) => pict.id == id);

    final List<Relacion> recomendedPicts = pict.relacion!.toList();
    recomendedPicts.sort((b, a) => a.frec.compareTo(b.frec));
    recomendedPicts.forEach((recommendedPict) {
      this._suggestedPicts.add(picts.firstWhere(
          (suggestedPict) => suggestedPict.id == recommendedPict.id));
    });
    this._suggestedPicts.add(addPict);
    while (this.suggestedPicts.length == 0 ||
        this.suggestedPicts.length % this._suggestedQuantity != 0) {
      this._suggestedPicts.add(addPict);
    }
    this._pictoAnimationController.forward(from: 0.0);
    update(["suggested", "sentence"]);
  }
}
