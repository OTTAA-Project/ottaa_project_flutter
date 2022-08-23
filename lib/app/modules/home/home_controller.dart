import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/repositories/grupos_repository.dart';
import 'package:ottaa_project_flutter/app/data/repositories/picts_repository.dart';
import 'package:ottaa_project_flutter/app/global_controllers/local_file_controller.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/services/auth_service.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:ottaa_project_flutter/app/utils/custom_analytics.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ottaa_project_flutter/app/data/models/search_model.dart';

class HomeController extends GetxController {
  final _ttsController = Get.find<TTSController>();
  final dataController = Get.find<DataController>();
  RxBool showOrNot = true.obs;

  TTSController get ttsController => _ttsController;
  final _pictsRepository = Get.find<PictsRepository>();
  final _grupoRepository = Get.find<GrupoRepository>();
  final authController = AuthService();
  late AnimationController pictoAnimationController;
  late String language;

  String _voiceText = "";
  String textToShare = '';

  String get voiceText => _voiceText;
  List<Pict> picts = [];
  List<Grupos> grupos = [];
  List<Pict> _suggestedPicts = [];

  List<Pict> get suggestedPicts => _suggestedPicts;
  int _suggestedIndex = 0;

  int get suggestedIndex => _suggestedIndex;

  final int _suggestedQuantity = 4;

  int get suggestedQuantity => _suggestedQuantity;

  // set suggestedQuantity(value) {
  //   _suggestedQuantity = value;
  //   _suggestedIndex = 0;
  // }

  final List<Pict> _sentencePicts = [];

  List<Pict> get sentencePicts => _sentencePicts;
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
  final String paidUrl = 'https://www.paypal.com/webapps/billing/plans/subscribe?plan_id=P-7H209758Y47141226MAMGTWY';
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
    Get.put(PictogramGroupsController());
  }

  void initializePageViewer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (currentPage < 2) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 350),
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
    if (_sentencePicts.isEmpty) {
      if (picts[0].relacion!.isEmpty) {
        picts[0].relacion!.add(
              Relacion(id: pict.id, frec: 1),
            );
      }

      /// if the length of the relacion >1

      if (picts[0].relacion!.isNotEmpty) {
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
          picts[0].relacion![relacionID].frec = picts[0].relacion![relacionID].frec! + 1;
        } else {
          picts[0].relacion!.add(
                Relacion(id: pict.id, frec: 1),
              );
        }
      }
      _sentencePicts.add(pict);
      await suggest(_sentencePicts.last.id);
    } else {
      final addToThisOnePictId = _sentencePicts.last.id;
      int addToThisOneIndex = -1;
      print('the size is here ${picts.length}');
      picts.firstWhere((element) {
        addToThisOneIndex++;
        return addToThisOnePictId == element.id;
      });

      /// if the length of the relacion == 0

      if (_sentencePicts.last.relacion == null || _sentencePicts.last.relacion!.isEmpty) {
        picts[addToThisOneIndex].relacion = [
          Relacion(id: pict.id, frec: 1),
        ];
      }

      /// if the length of the relacion >1

      if (_sentencePicts.last.relacion!.isNotEmpty) {
        bool alreadyInTheList = false;
        int relacionID = -1;
        _sentencePicts.last.relacion!.firstWhereOrNull((e) {
          if (e.id == pict.id) {
            alreadyInTheList = true;
          }
          relacionID++;
          return e.id == pict.id;
        });

        ///if  it is in the relacion just increment it
        if (alreadyInTheList) {
          picts[addToThisOneIndex].relacion![relacionID].frec = (picts[addToThisOneIndex].relacion![relacionID].frec! + 1);
        } else {
          picts[addToThisOneIndex].relacion!.add(
                Relacion(id: pict.id, frec: 1),
              );
        }
      }

      _sentencePicts.add(pict);
      await suggest(_sentencePicts.last.id);
    }
    update(['screenshot']);
  }

  Future<void> loadPicts() async {
    picts = await _pictsRepository.getAll();
    grupos = await _grupoRepository.getAll();
    await suggest(0);
    update(["suggested"]);
  }

  void moreSuggested() {
    if (_suggestedPicts.length % _suggestedQuantity != 0) {
      suggest(_sentencePicts.isNotEmpty ? _sentencePicts.last.id : 0);
    }
    if (_suggestedPicts.length > (_suggestedIndex + 1) * _suggestedQuantity) {
      _suggestedIndex++;
    } else {
      _suggestedIndex = 0;
    }
    if (_suggestedPicts.length != suggestedQuantity) {
      pictoAnimationController.forward(from: 0.0);
    }
    update(["suggested"]);
  }

  removePictFromSentence() async {
    if (_sentencePicts.isNotEmpty) {
      _sentencePicts.removeLast();
      _suggestedIndex = 0;
      await suggest(_sentencePicts.isNotEmpty ? _sentencePicts.last.id : 0);
    }
    update(['screenshot']);
  }

  removeWholeSentence() async {
    if (_sentencePicts.isNotEmpty) {
      _sentencePicts.clear();
      _suggestedIndex = 0;
      await suggest(_sentencePicts.isNotEmpty ? _sentencePicts.last.id : 0);
    }
    update(['screenshot']);
  }

  bool hasText() {
    if (_voiceText != "") return true;
    return false;
  }

  Future speak() async {
    if (_sentencePicts.isNotEmpty) {
      _voiceText = "";
      for (var pict in _sentencePicts) {
        switch (_ttsController.languaje) {
          case "es":
            _voiceText += "${pict.texto.es} ";
            break;
          case "en":
            _voiceText += "${pict.texto.en} ";
            break;

          default:
            _voiceText += "${pict.texto.es} ";
        }
      }
      update(["subtitle"]);
      print(hasText());
      await _ttsController.speakPhrase(_voiceText);
      _suggestedIndex = 0;
      _sentencePicts.clear();
      await suggest(0);
      await Future.delayed(const Duration(seconds: 1), () {
        _voiceText = "";
        update(["subtitle"]);
      });
    }
  }

  Future<void> suggest(int id) async {
    _suggestedPicts = [];
    _suggestedIndex = 0;

    final Pict addPict = Pict(
      id: 0,
      texto: Texto(en: "add", es: "agregar"),
      tipo: 6,
      imagen: Imagen(picto: "ic_agregar_nuevo"),
      localImg: true,
    );

    final Pict pict = picts.firstWhere((pict) => pict.id == id);
    print('the id of the pict is ${pict.id}');

    if (pict.relacion!.isNotEmpty) {
      final List<Relacion> recomendedPicts = pict.relacion!.toList();
      recomendedPicts.sort((b, a) => a.frec!.compareTo(b.frec!));
      _suggestedPicts = await predictiveAlgorithm(list: recomendedPicts);
    } else {
      _suggestedPicts = [];
    }

    /// *
    /// predictive algo will replace teh code from here

    // recomendedPicts.forEach((recommendedPict) {
    //   _suggestedPicts.add(picts.firstWhere(
    //       (suggestedPict) => suggestedPict.id == recommendedPict.id));
    // });

    /// to here
    /// *
    _suggestedPicts.add(addPict);
    while (suggestedPicts.isEmpty || suggestedPicts.length % _suggestedQuantity != 0) {
      _suggestedPicts.add(addPict);
    }
    pictoAnimationController.forward(from: 0.0);
    update(["suggested", "sentence"]);
  }

  Future<void> getPicNumber() async {
    // final User? auth = FirebaseAuth.instance.currentUser;
    // final ref = databaseRef.child('Avatar/${auth!.uid}/');
    final res = await dataController.getPicNumber();
    picNumber.value = res;
  }

  Future<List<Pict>> predictiveAlgorithm({required List<Relacion> list}) async {
    const int pesoFrec = 2,
        // pesoAgenda = 8,
        // pesoGps = 12,
        // pesoEdad = 5,
        // pesoSexo = 3,
        pesoHora = 50;
    final time = DateTime.now().hour;
    List<Pict> requiredPicts = [];
    for (var recommendedPict in list) {
      print(recommendedPict.frec);
      requiredPicts.add(
        picts.firstWhere((suggestedPict) => suggestedPict.id == recommendedPict.id),
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

  List<SearchModel?> dataMainForImages = [];
  List<SearchModel?> dataMainForImagesReferences = [];

  void deletePicto({
    required BuildContext context,
    required int index,
    required int suggestedIndexMainScreen,
  }) async {
    final pictogramController = Get.find<PictogramGroupsController>();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: kOTTAAOrangeNew,
            ),
          );
        });
    int indexGrupo = 0;
    picts[indexGrupo].relacion!.removeWhere((element) => element.id == index);
    final dataPicts = picts;
    List<String> fileDataPicts = [];
    for (var element in dataPicts) {
      final obj = jsonEncode(element);
      fileDataPicts.add(obj);
    }

    /// saving changes to file
    if (!kIsWeb) {
      final localFile = LocalFileController();
      await localFile.writePictoToFile(
        data: fileDataPicts.toString(),
      );
      // print('writing to file');
    }
    //for the file data
    final instance = await SharedPreferences.getInstance();
    await instance.setBool('Pictos_file', true);
    // print(res1);
    //upload to the firebase
    await pictogramController.uploadToFirebasePicto(
      data: fileDataPicts.toString(),
    );
    await pictogramController.pictoExistsOnFirebase();
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
    Get.toNamed(AppRoutes.kEditPictogram);
    CustomAnalyticsEvents.setEventWithParameters("Touch", CustomAnalyticsEvents.createMyMap('name', 'Edit '));
  }

  void updateSuggested({required Pict updatedOne, required int suggestedMainScreenIndex}) {
    suggestedPicts[suggestedMainScreenIndex] = updatedOne;
    update(['suggested']);
  }

  final FlutterTts _flutterTts = FlutterTts();
  late String fileName;

  /// converting text to speech
  Future createAudioScript({
    required String name,
    required String script,
  }) async {
    await _flutterTts.setLanguage(_ttsController.languaje);
    await _flutterTts.setSpeechRate(1.0);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
    if (_ttsController.languaje == 'en') {
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
    textToShare = "";
    for (var pict in _sentencePicts) {
      switch (_ttsController.languaje) {
        case "es":
          textToShare += "${pict.texto.es} ";
          break;
        case "en":
          textToShare += "${pict.texto.en} ";
          break;

        default:
          textToShare += "${pict.texto.es} ";
      }
    }
  }

  Future<void> startTimerForDialogueExit() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.back();
  }
}

// enum Horario { MANANA, MEDIODIA, TARDE, NOCHE, ISEMPTY }
