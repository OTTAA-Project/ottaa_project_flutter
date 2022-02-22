import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/repositories/grupos_repository.dart';
import 'package:ottaa_project_flutter/app/data/repositories/picts_repository.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/services/auth_service.dart';

class HomeController extends GetxController {
  final _ttsController = Get.find<TTSController>();

  TTSController get ttsController => this._ttsController;
  final databaseRef = FirebaseDatabase.instance.reference();
  final _pictsRepository = Get.find<PictsRepository>();
  final _grupoRepository = Get.find<GrupoRepository>();
  final authController = AuthService();
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
  int addId = 0;
  int toId = 0;
  bool fromAdd = false;

  late Pict pictToBeEdited;
  RxInt picNumber = 617.obs;

  //predictive algo vars

  List<Pict> predictivePicts = [];

  //for opening drawer
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  /// checker for adding the picto from pictogroupPage
  Pict? pictToAddPict;

  //web
  RxBool valueToRefresh = false.obs;
  RxBool sentenceBack = false.obs;

  //drawer
  RxBool muteOrNot = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await loadPicts();
    await getPicNumber();
  }

  addPictToSentence(Pict pict) async {
    if (this._sentencePicts.isEmpty) {
      this._sentencePicts.add(pict);
      await suggest(this._sentencePicts.last.id);
    } else {
      final addToThisOnePictId = this._sentencePicts.last.id;
      int addToThisOneIndex = -1;
      picts.firstWhere((element) {
        addToThisOneIndex++;
        return addToThisOnePictId == element.id;
      });

      /// if the length of the relacion == 0

      if (this._sentencePicts.last.relacion!.length == 0) {
        picts[addToThisOneIndex].relacion!.add(
              Relacion(id: pict.id, frec: 1),
            );
      }

      /// if the length of the relacion >1

      if (this._sentencePicts.last.relacion!.length >= 1) {
        bool alreadyInTheList = false;
        int relacionID = -1;
        this._sentencePicts.last.relacion!.firstWhereOrNull((e) {
          if (e.id == pict.id) {
            alreadyInTheList = true;
          }
          relacionID++;
          return e.id == pict.id;
        });

        ///if  it is in the relacion just increment it
        if (alreadyInTheList) {
          picts[addToThisOneIndex].relacion![relacionID].frec =
              picts[addToThisOneIndex].relacion![relacionID].frec + 1;
        } else {
          picts[addToThisOneIndex].relacion!.add(
                Relacion(id: pict.id, frec: 1),
              );
        }
      }

      this._sentencePicts.add(pict);
      await suggest(this._sentencePicts.last.id);
    }
  }

  Future<void> loadPicts() async {
    this.picts = await this._pictsRepository.getAll();
    this.grupos = await this._grupoRepository.getAll();
    await suggest(0);
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

  removePictFromSentence() async {
    if (this._sentencePicts.isNotEmpty) {
      this._sentencePicts.removeLast();
      this._suggestedIndex = 0;
      await suggest(
          this._sentencePicts.isNotEmpty ? this._sentencePicts.last.id : 0);
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
      await this.suggest(0);
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
    this._suggestedPicts = await predictiveAlgorithm(list: recomendedPicts);

    /// *
    /// predictive algo will replace teh code from here

    // recomendedPicts.forEach((recommendedPict) {
    //   this._suggestedPicts.add(picts.firstWhere(
    //       (suggestedPict) => suggestedPict.id == recommendedPict.id));
    // });

    /// to here
    /// *
    this._suggestedPicts.add(addPict);
    while (this.suggestedPicts.length == 0 ||
        this.suggestedPicts.length % this._suggestedQuantity != 0) {
      this._suggestedPicts.add(addPict);
    }
    this._pictoAnimationController.forward(from: 0.0);
    update(["suggested", "sentence"]);
  }

  Future<void> getPicNumber() async {
    final User? auth = FirebaseAuth.instance.currentUser;
    final ref = databaseRef.child('Avatar/${auth!.uid}/');
    final res = await ref.get();
    picNumber.value = res.value['urlFoto'];
  }

  Future<List<Pict>> predictiveAlgorithm({required List<Relacion> list}) async {
    final int pesoFrec = 2,
        // pesoAgenda = 8,
        // pesoGps = 12,
        // pesoEdad = 5,
        // pesoSexo = 3,
        pesoHora = 50;
    final time = DateTime.now().hour;
    List<Pict> requiredPicts = [];
    list.forEach((recommendedPict) {
      print(recommendedPict.frec);
      requiredPicts.add(
        picts.firstWhere(
            (suggestedPict) => suggestedPict.id == recommendedPict.id),
      );
    });
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
    requiredPicts.forEach((e) {
      i++;
      int hora = 0;

      /// '0' should be replaced by the value of HORA
      if (e.hora == null) {
        hora = 0;
      } else {
        e.hora!.forEach((e) {
          if (tag == e) {
            hora = 1;
          }
        });
      }
      e.score = (list[i].frec * pesoFrec) + (hora * pesoHora);
      print(e.score);
    });

    requiredPicts.sort((b, a) => a.score!.compareTo(b.score!));

    return requiredPicts;
  }
}

enum Horario { MANANA, MEDIODIA, TARDE, NOCHE, ISEMPTY }
