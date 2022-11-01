import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/models/sentence_model.dart';
import 'package:ottaa_project_flutter/app/data/repositories/grupos_repository.dart';
import 'package:ottaa_project_flutter/app/data/repositories/picts_repository.dart';
import 'package:ottaa_project_flutter/app/global_controllers/local_file_controller.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/services/auth_service.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:ottaa_project_flutter/app/utils/CustomAnalytics.dart';
import 'package:ottaa_project_flutter/app/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ottaa_project_flutter/app/data/models/search_model.dart';

class HomeController extends GetxController {
  final _ttsController = Get.find<TTSController>();
  final dataController = Get.find<DataController>();
  RxBool showOrNot = true.obs;

  TTSController get ttsController => this._ttsController;
  final _pictsRepository = Get.find<PictsRepository>();
  final _grupoRepository = Get.find<GrupoRepository>();
  final authController = AuthService();
  late AnimationController _pictoAnimationController;
  late String language;

  AnimationController get pictoAnimationController =>
      this._pictoAnimationController;

  set pictoAnimationController(AnimationController value) {
    this._pictoAnimationController = value;
  }

  String _voiceText = "";
  String textToShare = '';

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

  //editing from homescreen
  bool editingFromHomeScreen = false;
  int suggestedMainScreenIndex = -1;

  //paid version screen
  final String paidUrl =
      'https://www.paypal.com/webapps/billing/plans/subscribe?plan_id=P-7H209758Y47141226MAMGTWY';
  late Timer _timer;
  int currentPage = 0;
  PageController pageController = PageController(
    initialPage: 0,
  );
  int userSubscription = 0;
  String audioFilePath = '';
  late Uint8List imageFile;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  List<Sentence> mostUsedSentences = [];
  int indexForMostUsed = 0;

  Future<void> fetchMostUsedSentences() async {
    switch (this._ttsController.languaje) {
      case "es-AR":
        mostUsedSentences = await dataController.fetchFrases(
          language: language,
          type: Constants.MOST_USED_SENTENCES,
        );
        break;
      case "en-US":
        mostUsedSentences = await dataController.fetchFrases(
          language: language,
          type: Constants.MOST_USED_SENTENCES,
        );
        break;
      case "pt-BR":
        mostUsedSentences = await dataController.fetchFrases(
          language: language,
          type: Constants.MOST_USED_SENTENCES,
        );
        break;
      case "fr-FR":
        mostUsedSentences = await dataController.fetchFrases(
          language: language,
          type: Constants.MOST_USED_SENTENCES,
        );
        break;
      default:
        mostUsedSentences = await dataController.fetchFrases(
          language: language,
          type: Constants.MOST_USED_SENTENCES,
        );
    }
  }

  Future<void> uploadFrases({
    required String phrase,
  }) async {
    switch (this._ttsController.languaje) {
      case "es-AR":
        await addSentenceToList(
          phrase: phrase,
        );
        break;
      case "en-US":
        await addSentenceToList(
          phrase: phrase,
        );
        break;
      case "pt-BR":
        await addSentenceToList(
          phrase: phrase,
        );
        break;
      case "fr-FR":
        await addSentenceToList(
          phrase: phrase,
        );
        break;
      default:
        await addSentenceToList(
          phrase: phrase,
        );
    }
    mostUsedSentences.forEach((element) {
      print(
          'Sentence: ${element.frase},Here is the frequency: ${element.frecuencia}');
    });
    await dataController.uploadFrases(
      language: language,
      data: mostUsedSentences,
      type: Constants.MOST_USED_SENTENCES,
    );
  }

  Future<void> addSentenceToList({
    required String phrase,
  }) async {
    if (mostUsedSentences.isEmpty) {
      List<PictosComponente> pictosComponente = [];
      _sentencePicts.forEach((element) {
        pictosComponente.add(
          PictosComponente(
              id: element.id,
              //todo: chat with hector aout this
              esSugerencia: element.esSugerencia != null ? true : false,
              hora: element.hora,
              edad: element.edad),
        );
      });
      final timeWhenUsed = DateTime.now().millisecondsSinceEpoch;
      mostUsedSentences.add(
        Sentence(
          fecha: [timeWhenUsed],
          complejidad: Complejidad(
            pictosComponentes: pictosComponente,
            valor: 0,
          ),
          frase: phrase,
          id: mostUsedSentences.length,
          frecuencia: 1,
          locale: '',
        ),
      );
    } else {
      ///check if the mostUsedSentences has the sentence already or not
      final res = checkIfSentenceExist(
        phrase: phrase,
      );
      if (res) {
        /// increment the new sentence to the list
        mostUsedSentences[indexForMostUsed].frecuencia++;
        mostUsedSentences[indexForMostUsed]
            .fecha
            .add(DateTime.now().millisecondsSinceEpoch);
      } else {
        /// add the new sentence to the list
        List<PictosComponente> pictosComponente = [];
        _sentencePicts.forEach((element) {
          pictosComponente.add(
            PictosComponente(
                id: element.id,
                //todo: chat with hector aout this
                esSugerencia: element.esSugerencia != null ? true : false,
                hora: element.hora,
                edad: element.edad),
          );
        });
        final timeWhenUsed = DateTime.now().millisecondsSinceEpoch;
        mostUsedSentences.add(
          Sentence(
            fecha: [timeWhenUsed],
            complejidad: Complejidad(
              pictosComponentes: pictosComponente,
              valor: 0,
            ),
            frase: phrase,
            id: mostUsedSentences.length,
            frecuencia: 1,
            locale: ttsController.languaje,
          ),
        );
      }
    }
  }

  bool checkIfSentenceExist({required String phrase}) {
    indexForMostUsed = -1;
    bool boolean = false;
    mostUsedSentences.forEach((sentence) {
      if (sentence.frase.trim().toLowerCase() == phrase.trim().toLowerCase()) {
        boolean = true;
      }
      indexForMostUsed++;
    });
    if (boolean) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> fetchAccountType() async {
    // final User? auth = FirebaseAuth.instance.currentUser;
    // final ref = databaseRef.child('Pago/${auth!.uid}/Pago');
    // final res = await ref.get();
    final res = await dataController.fetchAccountType();

    /// this means there is a value
    if (res == 1) {
      userSubscription = 1;
    } else {
      userSubscription = 0;
    }
    print('the value of user sub is $userSubscription');
  }

  @override
  void onInit() async {
    super.onInit();
    await loadPicts();
    await fetchAccountType();
    await getPicNumber();
    language = _ttsController.languaje;
    showOrNot.value = false;
    final _pictogram = Get.put(PictogramGroupsController());
    await fetchMostUsedSentences();
  }

  void initializePageViewer() {
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (currentPage < 2) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  Future<bool> disposeTimerAndController() async {
    _timer.cancel();
    Get.back();
    return true;
  }

  addPictToSentence(Pict pict) async {
    if (this._sentencePicts.isEmpty) {
      if (picts[0].relacion == null) {
        picts[0].relacion = [];
        picts[0].relacion!.add(
              Relacion(id: pict.id, frec: 1),
            );
      }

      /// if the length of the relacion >1

      if (picts[0].relacion!.length >= 1) {
        bool alreadyInTheList = false;
        int relacionID = -1;
        picts[0].relacion!.firstWhereOrNull((e) {
          if (e.id == pict.id) {
            alreadyInTheList = true;
          }
          relacionID++;
          return e.id == pict.id;
        });

        ///if  it is in the relacion just increment it
        if (alreadyInTheList) {
          picts[0].relacion![relacionID].frec =
              picts[0].relacion![relacionID].frec! + 1;
        } else {
          picts[0].relacion!.add(
                Relacion(id: pict.id, frec: 1),
              );
        }
      }
      this._sentencePicts.add(pict);
      await suggest(this._sentencePicts.last.id);
    } else {
      final addToThisOnePictId = this._sentencePicts.last.id;
      int addToThisOneIndex = -1;
      print('the size is here ${picts.length}');
      picts.firstWhere((element) {
        addToThisOneIndex++;
        return addToThisOnePictId == element.id;
      });

      /// if the length of the relacion == 0

      if (this._sentencePicts.last.relacion == null ||
          this._sentencePicts.last.relacion!.isEmpty) {
        picts[addToThisOneIndex].relacion = [
          Relacion(id: pict.id, frec: 1),
        ];
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
              (picts[addToThisOneIndex].relacion![relacionID].frec! + 1);
        } else {
          picts[addToThisOneIndex].relacion!.add(
                Relacion(id: pict.id, frec: 1),
              );
        }
      }

      this._sentencePicts.add(pict);
      await suggest(this._sentencePicts.last.id);
    }
    update(['screenshot']);
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
    update(['screenshot']);
  }

  removeWholeSentence() async {
    if (this._sentencePicts.isNotEmpty) {
      this._sentencePicts.clear();
      this._suggestedIndex = 0;
      await suggest(
          this._sentencePicts.isNotEmpty ? this._sentencePicts.last.id : 0);
    }
    update(['screenshot']);
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
          case "es-AR":
            this._voiceText += "${pict.texto.es} ";
            break;
          case "en-US":
            this._voiceText += "${pict.texto.en} ";
            break;
          case "pt-BR":
            this._voiceText += "${pict.texto.pt} ";
            break;
          case "fr-FR":
            this._voiceText += "${pict.texto.fr} ";
            break;
          default:
            this._voiceText += "${pict.texto.es} ";
        }
      });
      update(["subtitle"]);
      // print(hasText());
      await _ttsController.speakPhrase(_voiceText);
      //todo: add a function here to keep the used sentences and upload them to firebase
      await uploadFrases(phrase: _voiceText);
      this._suggestedIndex = 0;
      this._sentencePicts.clear();
      await this.suggest(0);
      await Future.delayed(Duration(seconds: 1));
      this._voiceText = "";
      update(["subtitle"]);
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
    print('the id of the pict is ${pict.id}');

    if (pict.relacion!.length >= 1) {
      final List<Relacion> recomendedPicts = pict.relacion!.toList();
      recomendedPicts.sort((b, a) => a.frec!.compareTo(b.frec!));
      this._suggestedPicts = await predictiveAlgorithm(list: recomendedPicts);
    } else {
      this._suggestedPicts = [];
    }

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
    // final User? auth = FirebaseAuth.instance.currentUser;
    // final ref = databaseRef.child('Avatar/${auth!.uid}/');
    final res = await dataController.getPicNumber();
    picNumber.value = res;
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
      e.score = (list[i].frec! * pesoFrec) + (hora * pesoHora);
      // print(e.score);
    });

    requiredPicts.sort((b, a) => a.score!.compareTo(b.score!));

    return requiredPicts;
  }

  List<SearchModel?> dataMainForImages = [];
  List<SearchModel?> dataMainForImagesReferences = [];

  void deletePicto({
    required BuildContext context,
    required int index,
    required int suggestedIndexMainScreen,
  }) async {
    final _pictogramController = Get.find<PictogramGroupsController>();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: kOTTAAOrangeNew,
            ),
          );
        });
    int indexGrupo = 0;
    picts[indexGrupo].relacion!.removeWhere((element) => element.id == index);
    final dataPicts = picts;
    List<String> fileDataPicts = [];
    dataPicts.forEach((element) {
      final obj = jsonEncode(element);
      fileDataPicts.add(obj);
    });

    /// saving changes to file
   /* if (!kIsWeb) {
      final localFile = LocalFileController();
      await localFile.writePictoToFile(
        data: fileDataPicts.toString(),
        language: language,
      );
      // print('writing to file');
    }
    //for the file data
    final instance = await SharedPreferences.getInstance();
    await instance.setBool(
        Constants
            .LANGUAGE_CODES[instance.getString('Language_KEY') ?? 'Spanish']!,
        true);*/
    // print(res1);
    //upload to the firebase
    await dataController.uploadPictosToFirebaseRealTime(
      data: picts,
      languageCode: language,
      type: 'Pictos',
    );
    // await _pictogramController.pictoExistsOnFirebase();
    suggestedPicts.removeAt(suggestedIndexMainScreen);
    update(['suggested']);
    Get.back();
    Get.back();
  }

  void editPicto({
    required int suggestedIndexMainScreen,
  }) {
    Get.back();
    editingFromHomeScreen = true;
    pictToBeEdited = suggestedPicts[suggestedIndexMainScreen];
    Get.toNamed(AppRoutes.EDITPICTO);
    CustomAnalyticsEvents.setEventWithParameters(
        "Touch", CustomAnalyticsEvents.createMyMap('name', 'Edit '));
  }

  void updateSuggested(
      {required Pict updatedOne, required int suggestedMainScreenIndex}) {
    suggestedPicts[suggestedMainScreenIndex] = updatedOne;
    update(['suggested']);
  }

  final FlutterTts _flutterTts = FlutterTts();
  late var fileName;

  /// converting text to speech
  Future createAudioScript({
    required String name,
    required String script,
  }) async {
    await _flutterTts.setLanguage(_ttsController.languaje);
    await _flutterTts.setSpeechRate(1.0);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
    if (_ttsController.languaje == 'en-US') {
      await _flutterTts.setVoice(
        {"name": "en-us-x-tpf-local", "locale": "en-US"},
      );
    }
    if (GetPlatform.isIOS) _flutterTts.setSharedInstance(true);
    // await _flutterTts.speak(script);
    fileName = GetPlatform.isAndroid ? '$name.wav' : '$name.caf';
    print('FileName: $fileName');

    await _flutterTts.synthesizeToFile(script, fileName).then((value) async {
      if (value == 1) {
        print('Value $value');
        print('generated');
      }
    });
    final externalDirectory = await getExternalStorageDirectory();
    audioFilePath = '${externalDirectory!.path}/$fileName';
    print(audioFilePath);
    // saveToFirebase(path, fileName, firebasPath: '$firebasepath/$name')
    //     .then((value) => {log('Received Audio Link: $value')});
  }

// /// saving converted audio file to firebase
// Future<String> saveToFirebase(String path, String name,
//     {required String firebasPath}) async {
//   final firebaseStorage = FirebaseStorage.instance;
//   SettableMetadata metadata = SettableMetadata(
//     contentType: 'audio/mpeg',
//     customMetadata: <String, String>{
//       'userid': _app.userid.value,
//       'name': _app.name.value,
//       'filename': name,
//     },
//   );
//   var snapshot = await firebaseStorage
//       .ref()
//       .child(firebasPath)
//       .putFile(File(path), metadata);
//   var downloadUrl = await snapshot.ref.getDownloadURL();
//   print(downloadUrl + " saved url");
//   return downloadUrl;
// }

  Future<void> generateStringToShare() async {
    this.textToShare = "";
    this._sentencePicts.forEach((pict) {
      switch (this._ttsController.languaje) {
        case "es-AR":
          this.textToShare += "${pict.texto.es} ";
          break;
        case "en-US":
          this.textToShare += "${pict.texto.en} ";
          break;
        case "fr-FR":
          this.textToShare += "${pict.texto.fr} ";
          break;
        case "pt-BR":
          this.textToShare += "${pict.texto.pt} ";
          break;
        default:
          this.textToShare += "${pict.texto.es} ";
      }
    });
  }

  Future<void> startTimerForDialogueExit() async {
    await Future.delayed(Duration(seconds: 2));
    Get.back();
  }
}

// enum Horario { MANANA, MEDIODIA, TARDE, NOCHE, ISEMPTY }
