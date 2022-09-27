import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ottaa_project_flutter/app/data/models/search_model.dart';
import 'package:ottaa_project_flutter/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ottaa_project_flutter/app/global_controllers/local_file_controller.dart';

class PictogramGroupsController extends GetxController {
  late ScrollController categoriesGridController;
  late ScrollController pictoGridController;
  late PageController categoriesPageController;
  late PageController pictoPageController;
  final _homeController = Get.find<HomeController>();
  final ttsController = Get.find<TTSController>();
  final _dataController = Get.find<DataController>();
  List<Pict> picts = [];
  List<Grupos> grupos = [];
  late List<Pict> pictsForGroupAdding;
  late Grupos selectedGrupos;
  List<Pict> selectedGruposPicts = [];
  RxBool pictoGridviewOrPageview = true.obs;
  RxBool categoryGridviewOrPageview = true.obs;
  String selectedPicto = '';
  late ScrollController addPictoGridController;
  int selectedGroupIndex = 0;
  int selectedIndex = 0;

  ///Edit Grupo
  late Grupos grupoToEdit;
  final TextEditingController grupoEditNameController = TextEditingController();
  RxBool editingGrupo = false.obs;
  RxBool isImageProvidedGrupoEdit = false.obs;
  Rx<File?> fileImageGrupoEdit = Rx<File?>(null);
  Rx<String?> selectedPhotoUrlGrupoEdit = ''.obs;
  Rx<XFile?> imageTobeUploadedGrupoEdit = Rx<XFile?>(null);

  ///Add Group
  bool textOrBorder = true;
  final TextEditingController grupoNameController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  RxBool isImageProvidedGrupo = false.obs;
  Rx<File?> fileImageGrupo = Rx<File?>(null);
  Rx<String?> selectedPhotoUrlGrupo = ''.obs;
  Rx<XFile?> imageTobeUploadedGrupo = Rx<XFile?>(null);
  late String url;
  Grupos grupo = Grupos(
    id: 0,
    texto: TextoGrupos(),
    imagen: ImagenGrupos(picto: ''),
    relacion: [],
  );

  Pict pict = Pict(
    imagen: Imagen(picto: ''),
    id: 0,
    texto: Texto(),
    tipo: 6,
  );

  //Add Pict
  final TextEditingController pictoNameController = TextEditingController();
  RxBool isImageProvidedPicto = false.obs;
  Rx<File?> fileImagePicto = Rx<File?>(null);
  Rx<String?> selectedPhotoUrlPicto = ''.obs;
  Rx<XFile?> imageTobeUploadedPicto = Rx<XFile?>(null);
  RxInt tipoValue = 6.obs;

  /// variables for web
  Rx<Image?> imageWidgetGrupo = Rx<Image?>(null);
  Rx<Image?> imageWidgetGrupoEdit = Rx<Image?>(null);
  Rx<Image?> imageWidgetPicto = Rx<Image?>(null);

  /// add picts to grupos
  late List<RxBool> selectedList;
  int secondTimeSameGroup = -69;

  /// variables for global symbols one
  /// multiple dataset map
  final Map<int, int> dataSetMapId = {
    0: 0,
    1: 17,
    2: 84,
    3: 14,
    4: 13,
    5: 82,
    6: 83,
    7: 81,
    8: 66,
    9: 95,
    10: 75,
    11: 16,
    12: 67,
    13: 74,
    14: 86,
    15: 88,
    16: 15,
    17: 97,
    18: 76,
  };

  final Map<int, String> dataSetMapStrings = {
    0: 'All',
    17: 'ARASAAC',
    84: 'Gumeil',
    14: 'Jellow',
    13: 'mulberry',
    82: 'OCHA Humanitarian Icons',
    83: 'OpenMoji',
    81: 'Sclera Symbols',
    66: 'Srbija Simboli',
    95: 'Typical Bulgarian Symbols',
    75: 'Adam Urdu Symbols',
    16: 'Blissymbolics',
    67: 'Cma Gora',
    74: 'Hrvatski simboli za PK',
    86: 'Mulberry Plus',
    88: 'Otsmin Turkish',
    15: 'Tawasol',
    97: 'Typical Bulgarian Symbols SVG',
    76: 'DoeDY',
  };
  RxInt selectedId = 0.obs;
  RxBool refreshSearchResult = true.obs;

  void addSomeScroll(ScrollController controller) {
    controller.animateTo(controller.offset.toDouble() + 200,
        duration: Duration(milliseconds: 100), curve: Curves.ease);
  }

  void removeSomeScroll(ScrollController controller) {
    controller.animateTo(controller.offset.toDouble() - 200,
        duration: Duration(milliseconds: 100), curve: Curves.ease);
  }

  void gotoNextPage(PageController pageController) {
    pageController.nextPage(
        duration: Duration(milliseconds: 100), curve: Curves.easeIn);
  }

  void gotoPreviousPage(PageController pageController) {
    pageController.previousPage(
        duration: Duration(milliseconds: 100), curve: Curves.easeOut);
  }

  Future<void> fetchDesiredPictos() async {
    selectedGruposPicts = [];
    for (int i = 0; i < selectedGrupos.relacion.length; i++) {
      picts.forEach((element) {
        if (element.id == selectedGrupos.relacion[i].id) {
          selectedGruposPicts.add(element);
        }
      });
    }
  }

  void changeToText() {
    textOrBorder = true;
    update(['second']);
  }

  void changeToBorderColor() {
    textOrBorder = false;
    update(['second']);
  }

  void changeToTags(
      {required BuildContext context, required double verticalSize}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'tags_will_come_in_next_release'.tr,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: verticalSize * 0.02,
              ),
            ),
          ],
        ),
      ),
    );
    update(['second']);
  }

  void cameraFunctionGrupo() async {
    imageTobeUploadedGrupo.value = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      maxHeight: 700,
      maxWidth: 700,
    );
    if (imageTobeUploadedGrupo.value != null) {
      print('yes');
      fileImageGrupo.value = File(imageTobeUploadedGrupo.value!.path);
      isImageProvidedGrupo.value = true;
      Get.back();
    } else {
      Get.back();
      print('no');
    }
  }

  void cameraFunctionGrupoEdit() async {
    imageTobeUploadedGrupoEdit.value = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      maxHeight: 700,
      maxWidth: 700,
    );
    if (imageTobeUploadedGrupoEdit.value != null) {
      print('yes');
      fileImageGrupoEdit.value = File(imageTobeUploadedGrupoEdit.value!.path);
      editingGrupo.value = true;
      Get.back();
    } else {
      Get.back();
      print('no');
    }
  }

  void cameraFunctionPicto() async {
    imageTobeUploadedPicto.value = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      maxHeight: 600,
      maxWidth: 600,
    );
    if (imageTobeUploadedPicto.value != null) {
      print('yes');
      fileImagePicto.value = File(imageTobeUploadedPicto.value!.path);
      isImageProvidedPicto.value = true;
      Get.back();
    } else {
      Get.back();
      print('no');
    }
  }

  void galleryFunctionGrupo() async {
    if (kIsWeb) {
      imageTobeUploadedGrupo.value =
          await picker.pickImage(source: ImageSource.gallery);
      if (imageTobeUploadedGrupo.value != null) {
        print('I was here');
        final imageInBytes = await imageTobeUploadedGrupo.value!.readAsBytes();
        imageWidgetGrupo.value = Image.memory(
          imageInBytes,
        );
        isImageProvidedGrupo.value = true;
        Get.back();
      } else {
        Get.back();
        print('no');
      }
    } else {
      imageTobeUploadedGrupo.value =
          await picker.pickImage(source: ImageSource.gallery);
      if (imageTobeUploadedGrupo.value != null) {
        fileImageGrupo.value = File(imageTobeUploadedGrupo.value!.path);
        isImageProvidedGrupo.value = true;
        Get.back();
      } else {
        Get.back();
        print('no');
      }
    }
  }

  void galleryFunctionGrupoEdit() async {
    if (kIsWeb) {
      imageTobeUploadedGrupoEdit.value =
          await picker.pickImage(source: ImageSource.gallery);
      if (imageTobeUploadedGrupoEdit.value != null) {
        print('I was here');
        final imageInBytes =
            await imageTobeUploadedGrupoEdit.value!.readAsBytes();
        imageWidgetGrupoEdit.value = Image.memory(
          imageInBytes,
        );
        editingGrupo.value = true;
        selectedPhotoUrlGrupoEdit.value = '';
        Get.back();
      } else {
        Get.back();
        print('no');
      }
    } else {
      imageTobeUploadedGrupoEdit.value =
          await picker.pickImage(source: ImageSource.gallery);
      if (imageTobeUploadedGrupoEdit.value != null) {
        fileImageGrupoEdit.value = File(imageTobeUploadedGrupoEdit.value!.path);
        editingGrupo.value = true;
        selectedPhotoUrlGrupoEdit.value = '';
        Get.back();
      } else {
        Get.back();
        print('no');
      }
    }
  }

  void galleryFunctionPicto() async {
    if (kIsWeb) {
      imageTobeUploadedPicto.value =
          await picker.pickImage(source: ImageSource.gallery);
      if (imageTobeUploadedPicto.value != null) {
        print('I was here');
        final imageInBytes = await imageTobeUploadedPicto.value!.readAsBytes();
        imageWidgetPicto.value = Image.memory(
          imageInBytes,
        );
        isImageProvidedPicto.value = true;
        selectedPhotoUrlPicto.value = '';
        Get.back();
      } else {
        Get.back();
        print('no');
      }
    } else {
      imageTobeUploadedPicto.value =
          await picker.pickImage(source: ImageSource.gallery);
      if (imageTobeUploadedPicto.value != null) {
        fileImagePicto.value = File(imageTobeUploadedPicto.value!.path);
        isImageProvidedPicto.value = true;
        selectedPhotoUrlPicto.value = '';
        Get.back();
      } else {
        Get.back();
        print('no');
      }
    }
  }

  Future<List<SearchModel>> fetchPhotoFromGlobalSymbols(
      {required String text}) async {
    final String languageFormat =
        _homeController.language == 'en' ? '639-3' : '639-1';
    final language = _homeController.language == 'en' ? 'eng' : 'es';
    url =
        'https://globalsymbols.com/api/v1/labels/search?query=${text.replaceAll(' ', '+')}&language=$language&language_iso_format=$languageFormat&limit=60';
    var urlF = Uri.parse(url);
    http.Response response = await http.get(
      urlF,
      headers: {"Accept": "application/json"},
    );
    // print(url);
    if (response.statusCode == 200) {
      // var data = jsonDecode(response.body);
      // print(data['symbols'][0]['name']);
      final res = (jsonDecode(response.body) as List)
          .map((e) => SearchModel.fromJson(e))
          .toList();
      // SearchModel searchModel = SearchModel.fromJson(jsonDecode(response.body));
      // print(searchModel.itemCount);
      // print(searchModel.symbols[0].name);
      // print(jsonDecode(response.body));
      return res;
    } else {
      throw 'error';
    }
  }

  Future<void> uploadImageToFirebaseStorageGrupo({
    required String path,
    bool edit = false,
  }) async {
    // Reference ref = FirebaseStorage.instance
    //     .ref()
    //     .child('groupImages/')
    //     .child(grupoNameController.text);
    // final UploadTask uploadTask = ref.putFile(File(path));
    // final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    // final url = await taskSnapshot.ref.getDownloadURL();
    final url = await _dataController.uploadImageToStorage(
        path: path,
        storageDirectory: 'groupImages/',
        childName: grupoNameController.text);
    if (edit) {
      grupoToEdit.imagen.picto = url;
    } else {
      grupo.imagen.picto = url;
    }
  }

  Future<void> uploadImageToFirebaseStoragePicto({required String path}) async {
    // Reference ref = FirebaseStorage.instance
    //     .ref()
    //     .child('pictoImages/')
    //     .child(pictoNameController.text);
    // final UploadTask uploadTask = ref.putFile(File(path));
    // final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    // final url = await taskSnapshot.ref.getDownloadURL();
    final url = await _dataController.uploadImageToStorage(
      path: path,
      storageDirectory: 'pictoImages/',
      childName: pictoNameController.text,
    );
    pict.imagen.picto = url;
  }

  Future<void> uploadToFirebaseGrupo({required String data}) async {
    // final language = _ttsController.languaje;
    // final User? auth = FirebaseAuth.instance.currentUser;
    // final ref = databaseRef.child('Grupo/${auth!.uid}/');
    // await ref.set({
    //   'data': data,
    // });
    // await _dataController.uploadDataToFirebaseRealTime(
    //   data: data,
    //   type: 'Grupo',
    // );

    switch (_homeController.language) {
      case "es-AR":
        await _dataController.uploadDataToFirebaseRealTime(
          data: data,
          languageCode: ttsController.languaje,
          type: 'Grupos',
        );
        break;
      case "en-US":
        await _dataController.uploadDataToFirebaseRealTime(
          data: data,
          languageCode: ttsController.languaje,
          type: 'Grupos',
        );
        break;
      case "fr-FR":
        await _dataController.uploadDataToFirebaseRealTime(
          data: data,
          type: 'Grupos',
          languageCode: ttsController.languaje,
        );
        break;
      case "pt-BR":
        await _dataController.uploadDataToFirebaseRealTime(
          data: data,
          type: 'Grupos',
          languageCode: ttsController.languaje,
        );
        break;
      default:
        await _dataController.uploadDataToFirebaseRealTime(
          data: data,
          type: 'Grupos',
          languageCode: ttsController.languaje,
        );
    }
  }

  Future<void> uploadToFirebasePicto({required String data}) async {
    // final language = _ttsController.languaje;
    // final User? auth = FirebaseAuth.instance.currentUser;
    // final ref = databaseRef.child('Picto/${auth!.uid}/');
    // await ref.set({
    //   'data': data,
    // });
    await _dataController.uploadDataToFirebaseRealTime(
      data: data,
      type: 'Pictos',
      languageCode: ttsController.languaje,
    );
  }

  Future<void> gruposExistsOnFirebase() async {
    // final User? auth = FirebaseAuth.instance.currentUser;
    // final ref = databaseRef.child('GruposExistsOnFirebase/${auth!.uid}/');
    // await ref.set({
    //   'value': true,
    // });

    switch (_homeController.language) {
      case "es-AR":
        await _dataController.uploadBoolToFirebaseRealtime(
            data: true, type: 'GruposExistsOnFirebase');
        break;
      case "en-US":
        await _dataController.uploadBoolToFirebaseRealtime(
            data: true, type: 'GruposExistsOnFirebase');
        break;
      case "fr-FR":
        await _dataController.uploadBoolToFirebaseRealtime(
            data: true,
            type: 'GruposExistsOnFirebase${Constants.FRENCH_LANGUAGE_NAME}');
        break;
      case "pt-BR":
        await _dataController.uploadBoolToFirebaseRealtime(
            data: true,
            type:
                'GruposExistsOnFirebase${Constants.PORTUGUESE_LANGUAGE_NAME}');
        break;
      default:
        await _dataController.uploadBoolToFirebaseRealtime(
            data: true, type: 'GruposExistsOnFirebase');
    }
    // await _dataController.uploadBoolToFirebaseRealtime(
    //     data: true, type: 'GruposExistsOnFirebase');
  }

  Future<void> pictoExistsOnFirebase() async {
    // final User? auth = FirebaseAuth.instance.currentUser;
    // final ref = databaseRef.child('PictsExistsOnFirebase/${auth!.uid}/');
    // await ref.set({
    //   'value': true,
    // });
    switch (_homeController.language) {
      case "es-AR":
        await _dataController.uploadBoolToFirebaseRealtime(
            data: true, type: 'PictsExistsOnFirebase');
        break;
      case "en-US":
        await _dataController.uploadBoolToFirebaseRealtime(
            data: true, type: 'PictsExistsOnFirebase');
        break;
      case "fr-FR":
        await _dataController.uploadBoolToFirebaseRealtime(
            data: true,
            type: 'PictsExistsOnFirebase${Constants.FRENCH_LANGUAGE_NAME}');
        break;
      case "pt-BR":
        await _dataController.uploadBoolToFirebaseRealtime(
            data: true,
            type: 'PictsExistsOnFirebase${Constants.PORTUGUESE_LANGUAGE_NAME}');
        break;
      default:
        await _dataController.uploadBoolToFirebaseRealtime(
            data: true, type: 'PictsExistsOnFirebase');
    }
    // await _dataController.uploadBoolToFirebaseRealtime(
    //     data: true, type: 'PictsExistsOnFirebase');
  }

  void uploadGrupoEdit(
      {required BuildContext context, RxBool? editPicBool}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    /// upload photo here
    if (editingGrupo.value) {
      if (kIsWeb) {
        /// method for uploading images for web
        if (selectedPhotoUrlGrupoEdit.value == '') {
          final imageInBytes =
              await imageTobeUploadedGrupoEdit.value!.readAsBytes();
          // Reference _reference = FirebaseStorage.instance
          //     .ref()
          //     .child('testingUpload/${grupoEditNameController.text}');
          // await _reference
          //     .putData(
          //   await imageTobeUploadedGrupoEdit.value!.readAsBytes(),
          //   SettableMetadata(contentType: 'image/jpeg'),
          // )
          //     .whenComplete(() async {
          //   await _reference.getDownloadURL().then((value) {
          //     grupoToEdit.imagen.picto = value;
          //   });
          // });
          final value = await _dataController.uploadImageToStorageForWeb(
            storageName: grupoEditNameController.text,
            imageInBytes: imageInBytes,
          );
          grupoToEdit.imagen.picto = value;
        } else {
          grupoToEdit.imagen.picto = selectedPhotoUrlGrupoEdit.value!;
        }
      } else {
        if (selectedPhotoUrlGrupoEdit.value == '') {
          await uploadImageToFirebaseStorageGrupo(
            path: fileImageGrupoEdit.value!.path,
            edit: true,
          );
        } else {
          grupoToEdit.imagen.picto = selectedPhotoUrlGrupoEdit.value!;
        }
      }
    }
    // if (_homeController.language.toUpperCase() == 'en-US'.toUpperCase()) {
    //   grupoToEdit.texto.en = grupoEditNameController.text;
    // } else {
    //   grupoToEdit.texto.es = grupoEditNameController.text;
    // }
    switch (_homeController.language) {
      case "es-AR":
        grupoToEdit.texto.es = grupoEditNameController.text;
        break;
      case "en-US":
        grupoToEdit.texto.en = grupoEditNameController.text;
        break;
      case "fr-FR":
        grupoToEdit.texto.fr = grupoEditNameController.text;
        break;
      case "pt-BR":
        grupoToEdit.texto.pt = grupoEditNameController.text;
        break;
      default:
        grupoToEdit.texto.es = grupoEditNameController.text;
    }
    int index = -1;
    _homeController.grupos.firstWhere((element) {
      index++;
      // print(element.texto.en);
      return grupoToEdit.id == element.id;
    });
    // print(grupoToEdit.texto.en);
    _homeController.grupos[index] = grupoToEdit;
    grupos[index] = grupoToEdit;
    final data = _homeController.grupos;
    List<String> fileData = [];
    data.forEach((element) {
      final obj = jsonEncode(element);
      fileData.add(obj);
    });

    /// saving changes to file
    if (!kIsWeb) {
      final localFile = LocalFileController();
      await localFile.writeGruposToFile(
        data: fileData.toString(),
        language: _homeController.language,
      );
      // print('writing to file');
    }
    //for the file data
    final instance = await SharedPreferences.getInstance();
    switch (_homeController.language) {
      case "es-AR":
        await instance.setBool('Grupos_file', true);
        break;
      case "en-US":
        await instance.setBool('Grupos_file', true);
        break;
      case "fr-FR":
        await instance.setBool(Constants.FRENCH_GRUPO_FILE_NAME, true);
        break;
      case "pt-BR":
        await instance.setBool(Constants.PORTUGUESE_GRUPO_FILE_NAME, true);
        break;
      default:
        await instance.setBool('Grupos_file', true);
    }
    // await instance.setBool('Grupos_file', true);
    // print(res1);
    //upload to the firebase
    await uploadToFirebaseGrupo(data: fileData.toString());
    await gruposExistsOnFirebase();
    // for refreshing the UI of listing
    categoryGridviewOrPageview.value = !categoryGridviewOrPageview.value;
    categoryGridviewOrPageview.value = !categoryGridviewOrPageview.value;
    resetDataForEditGrupo();
    Get.back();
    Navigator.of(context).pop(true);
  }

  void uploadChangesGrupos(
      {required BuildContext context, RxBool? editPicBool}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    /// upload photo here
    if (isImageProvidedGrupo.value) {
      if (kIsWeb) {
        /// method for uploading images for web
        if (selectedPhotoUrlGrupo.value == '') {
          final imageInBytes =
              await imageTobeUploadedGrupo.value!.readAsBytes();
          // Reference _reference = FirebaseStorage.instance
          //     .ref()
          //     .child('testingUpload/${grupoNameController.text}');
          // await _reference
          //     .putData(
          //   await imageTobeUploadedGrupo.value!.readAsBytes(),
          //   SettableMetadata(contentType: 'image/jpeg'),
          // )
          //     .whenComplete(() async {
          //   await _reference.getDownloadURL().then((value) {
          //     grupo.imagen.picto = value;
          //   });
          // });
          final value = await _dataController.uploadImageToStorageForWeb(
            storageName: grupoNameController.text,
            imageInBytes: imageInBytes,
          );
          grupo.imagen.picto = value;
        } else {
          grupo.imagen.picto = selectedPhotoUrlGrupo.value!;
        }
      } else {
        if (selectedPhotoUrlGrupo.value == '') {
          await uploadImageToFirebaseStorageGrupo(
              path: fileImageGrupo.value!.path);
        } else {
          grupo.imagen.picto = selectedPhotoUrlGrupo.value!;
        }
      }
    }
    grupo.tipo = 0;
    grupo.texto.en = grupoNameController.text;
    grupo.texto.es = grupoNameController.text;
    grupo.id = _homeController.grupos.length;
    print(_homeController.grupos.length);
    print(_homeController.grupos.last);
    _homeController.grupos.add(grupo);
    print(_homeController.grupos.length);
    print(_homeController.grupos.last);
    final data = _homeController.grupos;
    List<String> fileData = [];
    data.forEach((element) {
      final obj = jsonEncode(element);
      fileData.add(obj);
    });

    /// saving changes to file
    if (!kIsWeb) {
      final localFile = LocalFileController();
      await localFile.writeGruposToFile(
        data: fileData.toString(),
        language: _homeController.language,
      );
      // print('writing to file');
    }
    //for the file data
    final instance = await SharedPreferences.getInstance();
    switch (_homeController.language) {
      case "es-AR":
        await instance.setBool('Grupos_file', true);
        break;
      case "en-US":
        await instance.setBool('Grupos_file', true);
        break;
      case "fr-FR":
        await instance.setBool(Constants.FRENCH_GRUPO_FILE_NAME, true);
        break;
      case "pt-BR":
        await instance.setBool(Constants.PORTUGUESE_GRUPO_FILE_NAME, true);
        break;
      default:
        await instance.setBool('Grupos_file', true);
    }
    // await instance.setBool('Grupos_file', true);
    // print(res1);
    //upload to the firebase
    await uploadToFirebaseGrupo(data: fileData.toString());
    await gruposExistsOnFirebase();
    // for refreshing the UI of listing
    categoryGridviewOrPageview.value = !categoryGridviewOrPageview.value;
    categoryGridviewOrPageview.value = !categoryGridviewOrPageview.value;
    resetDataForAddGrupos();
    Get.back();
    Navigator.of(context).pop(true);
  }

  void uploadChangesPicto(
      {required BuildContext context, RxBool? editPicBool}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    final timeSeconds = DateTime.now().millisecondsSinceEpoch;

    /// upload photo here
    if (isImageProvidedPicto.value) {
      if (kIsWeb) {
        /// method for uploading images for web
        if (selectedPhotoUrlPicto.value == '') {
          final imageInBytes =
              await imageTobeUploadedPicto.value!.readAsBytes();
          // Reference _reference = FirebaseStorage.instance
          //     .ref()
          //     .child('testingUpload/${pictoNameController.text}');
          // await _reference
          //     .putData(
          //   await imageTobeUploadedPicto.value!.readAsBytes(),
          //   SettableMetadata(contentType: 'image/jpeg'),
          // )
          //     .whenComplete(() async {
          //   await _reference.getDownloadURL().then((value) {
          //     pict.imagen.picto = value;
          //   });
          // });
          final value = await _dataController.uploadImageToStorageForWeb(
            storageName: pictoNameController.text,
            imageInBytes: imageInBytes,
          );
          pict.imagen.picto = value;
        } else {
          pict.imagen.picto = selectedPhotoUrlPicto.value!;
        }
      } else {
        if (selectedPhotoUrlPicto.value == '') {
          await uploadImageToFirebaseStoragePicto(
              path: fileImagePicto.value!.path);
        } else {
          pict.imagen.picto = selectedPhotoUrlPicto.value!;
        }
      }
    }
    // pict.tipo = 6;
    switch (_homeController.language) {
      case "es-AR":
        pict.texto.es = pictoNameController.text;
        break;
      case "en-US":
        pict.texto.en = pictoNameController.text;
        break;
      case "fr-FR":
        pict.texto.fr = pictoNameController.text;
        break;
      case "pt-BR":
        pict.texto.pt = pictoNameController.text;
        break;
      default:
        pict.texto.es = pictoNameController.text;
    }
    // pict.texto.en = pictoNameController.text;
    // pict.texto.es = pictoNameController.text;
    pict.id = timeSeconds;
    pict.tipo = tipoValue.value;
    pict.relacion = [];
    print(_homeController.picts.length);
    print(_homeController.picts.last);
    _homeController.picts.add(pict);
    int index = -1;
    int indexForAll = -1;
    grupos.firstWhere((element) {
      index++;
      return element.id == selectedGrupos.id;
    });
    grupos.firstWhere((element) {
      indexForAll++;

      /// 24 is the id of all Grupo
      return element.id == 24;
    });
    grupos[index].relacion.add(
          GrupoRelacion(
            id: timeSeconds,
            frec: 0,
          ),
        );
    grupos[indexForAll].relacion.add(
          GrupoRelacion(
            id: timeSeconds,
            frec: 0,
          ),
        );
    selectedGruposPicts.add(pict);
    print(_homeController.picts.length);
    print(_homeController.picts.last.texto.en);
    print('values are : $index : ${selectedGrupos.id}');
    final data = _homeController.picts;
    List<String> fileData = [];
    data.forEach((element) {
      final obj = jsonEncode(element);
      fileData.add(obj);
    });

    /// saving changes to file
    if (!kIsWeb) {
      final localFile = LocalFileController();
      await localFile.writePictoToFile(
        data: fileData.toString(),
        language: _homeController.language,
      );
      // print('writing to file');
    }
    //for the file data
    final instance = await SharedPreferences.getInstance();
    switch (_homeController.language) {
      case "es-AR":
        await instance.setBool('Pictos_file', true);
        break;
      case "en-US":
        await instance.setBool('Pictos_file', true);
        break;
      case "fr-FR":
        await instance.setBool(Constants.FRENCH_PICTO_FILE_NAME, true);
        break;
      case "pt-BR":
        await instance.setBool(Constants.PORTUGUESE_PICTO_FILE_NAME, true);
        break;
      default:
        await instance.setBool('Pictos_file', true);
        break;
    }
    // await instance.setBool('Pictos_file', true);
    // print(res1);
    //upload to the firebase
    await uploadToFirebasePicto(data: fileData.toString());
    await pictoExistsOnFirebase();

    final dataGrupo = _homeController.grupos;
    List<String> fileDataGrupo = [];
    dataGrupo.forEach((element) {
      final obj = jsonEncode(element);
      fileDataGrupo.add(obj);
    });

    /// saving changes to file
    if (!kIsWeb) {
      final localFile = LocalFileController();
      await localFile.writeGruposToFile(
        data: fileDataGrupo.toString(),
        language: _homeController.language,
      );
      // print('writing to file');
    }
    //for the file data
    switch (_homeController.language) {
      case "es-AR":
        await instance.setBool('Grupos_file', true);
        break;
      case "en-US":
        await instance.setBool('Grupos_file', true);
        break;
      case "fr-FR":
        await instance.setBool(Constants.FRENCH_GRUPO_FILE_NAME, true);
        break;
      case "pt-BR":
        await instance.setBool(Constants.PORTUGUESE_GRUPO_FILE_NAME, true);
        break;
      default:
        await instance.setBool('Grupos_file', true);
    }
    // await instance.setBool('Grupos_file', true);
    // print(res1);
    //upload to the firebase
    await uploadToFirebaseGrupo(data: fileDataGrupo.toString());
    await gruposExistsOnFirebase();

    // for refreshing the UI of listing
    pictoGridviewOrPageview.value = !pictoGridviewOrPageview.value;
    pictoGridviewOrPageview.value = !pictoGridviewOrPageview.value;
    selectedList = List.generate(
        _homeController.picts.length, (index) => false.obs,
        growable: true);
    print(selectedGruposPicts.length);
    secondTimeSameGroup = selectedGroupIndex;
    resetDataForAddPicto();
    Get.back();
    Navigator.of(context).pop(true);
  }

  void resetDataForEditGrupo() {
    grupoEditNameController.text = '';
    editingGrupo.value = false;
    isImageProvidedGrupoEdit.value = false;
    fileImageGrupoEdit.value = null;
    selectedPhotoUrlGrupoEdit.value = '';
    imageTobeUploadedGrupoEdit.value = null;
  }

  void resetDataForAddGrupos() {
    isImageProvidedGrupo.value = false;
    fileImageGrupo.value = null;
    selectedPhotoUrlGrupo.value = '';
    imageTobeUploadedGrupo.value = null;
    grupoNameController.text = '';
    grupo = Grupos(
      id: 0,
      texto: TextoGrupos(),
      imagen: ImagenGrupos(picto: ''),
      relacion: [],
    );
    imageWidgetGrupo.value = null;
  }

  void resetDataForAddPicto() {
    isImageProvidedPicto.value = false;
    fileImagePicto.value = null;
    selectedPhotoUrlPicto.value = '';
    imageTobeUploadedPicto.value = null;
    pictoNameController.text = '';
    tipoValue.value = 6;
    pict = Pict(
      imagen: Imagen(picto: ''),
      id: 0,
      texto: Texto(
        en: '',
        es: '',
      ),
      tipo: 0,
    );
    imageWidgetPicto.value = null;
  }

  void updateTipo({required int tipo}) {
    tipoValue.value = tipo;
    update(['second']);
  }

  @override
  void onInit() async {
    super.onInit();
    categoriesGridController = ScrollController();
    pictoGridController = ScrollController();
    categoriesPageController = PageController();
    pictoPageController = PageController();
    addPictoGridController = PageController();
    await loadAssets();
    // lang = ttsController.languaje;
  }

  @override
  void dispose() {
    categoriesGridController.dispose();
    pictoGridController.dispose();
    pictoPageController.dispose();
    addPictoGridController.dispose();
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
    selectedList = List.generate(
        _homeController.picts.length, (index) => false.obs,
        growable: true);
    pictsForGroupAdding = _homeController.picts;
  }

  Future<void> loadAssets() async {
    this.picts = _homeController.picts;
    this.grupos = _homeController.grupos;
  }
}
