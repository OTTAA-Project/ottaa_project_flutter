import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/models/search_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';
import 'package:ottaa_project_flutter/app/global_controllers/local_file_controller.dart';
import 'package:ottaa_project_flutter/app/global_controllers/shared_pref_client.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:http/http.dart' as http;
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:ottaa_project_flutter/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPictoController extends GetxController {
  RxBool text = true.obs;
  RxBool frame = false.obs;
  RxBool tags = false.obs;
  RxBool pictoBorder = true.obs;
  final _homeController = Get.find<HomeController>();
  final _pictoController = Get.find<PictogramGroupsController>();
  final _ttsController = Get.find<TTSController>();
  final _dataController = Get.find<DataController>();
  final sharedPref = SharedPrefClient();
  TextEditingController nameController = TextEditingController();
  Rx<Pict?> pict = Rx<Pict?>(null);
  late String lang;
  final ImagePicker picker = ImagePicker();
  RxBool editingPicture = false.obs;
  Rx<File?> fileImage = Rx<File?>(null);
  Rx<String?> selectedPhotoUrl = ''.obs;
  Rx<XFile?> imageTobeUploaded = Rx<XFile?>(null);

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
  bool firstTime = true;

  late String url;

  /// variables for web
  Rx<Image?> imageWidget = Rx<Image?>(null);

  Future<void> uploadToFirebase({required String data}) async {
    // final language = _ttsController.languaje;
    // final User? auth = FirebaseAuth.instance.currentUser;
    // final ref = databaseRef.child('Picto/${auth!.uid}/');
    // await ref.set({
    //   'data': data,
    // });
    switch (_ttsController.languaje) {
      case "es-AR":
        await _dataController.uploadDataToFirebaseRealTime(
          data: data,
          type: 'Picto',
        );
        break;
      case "en-US":
        await _dataController.uploadDataToFirebaseRealTime(
          data: data,
          type: 'Picto',
        );
        break;
      case "fr-FR":
        await _dataController.uploadDataToFirebaseRealTime(
          data: data,
          type: Constants.FRENCH_PICTO_FIREBASE_NAME,
        );
        break;
      case "pt-BR":
        await _dataController.uploadDataToFirebaseRealTime(
          data: data,
          type: Constants.PORTUGUESE_PICTO_FIREBASE_NAME,
        );
        break;
      default:
        await _dataController.uploadDataToFirebaseRealTime(
          data: data,
          type: 'Picto',
        );
        break;
    }

    // await _dataController.uploadDataToFirebaseRealTime(
    //   data: data,
    //   type: 'Picto',
    // );
  }

  Future<void> pictsExistsOnFirebase() async {
    // final User? auth = FirebaseAuth.instance.currentUser;
    // final ref = databaseRef.child('PictsExistsOnFirebase/${auth!.uid}/');
    // await ref.set({
    //   'value': true,
    // });
    // await _dataController.uploadBoolToFirebaseRealtime(
    //   data: true,
    //   type: 'PictsExistsOnFirebase',
    // );
    switch (_ttsController.languaje) {
      case "es-AR":
        await _dataController.uploadBoolToFirebaseRealtime(
          data: true,
          type: 'PictsExistsOnFirebase',
        );
        break;
      case "en-US":
        await _dataController.uploadBoolToFirebaseRealtime(
          data: true,
          type: 'PictsExistsOnFirebase',
        );
        break;
      case "fr-FR":
        await _dataController.uploadBoolToFirebaseRealtime(
          data: true,
          type: 'PictsExistsOnFirebase${Constants.FRENCH_LANGUAGE_NAME}',
        );
        break;
      case "pt-BR":
        await _dataController.uploadBoolToFirebaseRealtime(
          data: true,
          type: 'PictsExistsOnFirebase${Constants.PORTUGUESE_LANGUAGE_NAME}',
        );
        break;
      default:
        await _dataController.uploadBoolToFirebaseRealtime(
          data: true,
          type: 'PictsExistsOnFirebase',
        );
        break;
    }
  }

  Future<List<SearchModel>> fetchPhotoFromGlobalSymbols(
      {required String text}) async {
    final String languageFormat = lang == 'en-US' ? '639-3' : '639-1';
    final language = lang == 'en-US' ? 'eng' : 'es';
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

  void cameraFunction() async {
    imageTobeUploaded.value = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      maxHeight: 300,
      maxWidth: 300,
    );
    if (imageTobeUploaded != null) {
      print('yes');
      fileImage.value = File(imageTobeUploaded.value!.path);
      editingPicture.value = true;
      Get.back();
    } else {
      Get.back();
      print('no');
    }
  }

  void galleryFunction() async {
    if (kIsWeb) {
      imageTobeUploaded.value =
          await picker.pickImage(source: ImageSource.gallery);
      if (imageTobeUploaded != null) {
        print('I was here');
        final imageInBytes = await imageTobeUploaded.value!.readAsBytes();
        imageWidget.value = Image.memory(
          imageInBytes,
        );
        editingPicture.value = true;
        Get.back();
      } else {
        Get.back();
        print('no');
      }
    } else {
      imageTobeUploaded.value =
          await picker.pickImage(source: ImageSource.gallery);
      if (imageTobeUploaded != null) {
        fileImage.value = File(imageTobeUploaded.value!.path);
        editingPicture.value = true;
        Get.back();
      } else {
        Get.back();
        print('no');
      }
    }
  }

  void uploadChanges(
      {required BuildContext context, RxBool? editPicBool}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    /// upload photo here
    if (editingPicture.value) {
      if (kIsWeb) {
        /// method for uploading images for web
        if (selectedPhotoUrl.value == '') {
          final imageInBytes = await imageTobeUploaded.value!.readAsBytes();
          // Reference _reference = FirebaseStorage.instance
          //     .ref()
          //     .child('testingUpload/${pict.value!.texto.en}');
          // await _reference
          //     .putData(
          //   await imageTobeUploaded.value!.readAsBytes(),
          //   SettableMetadata(contentType: 'image/jpeg'),
          // )
          //     .whenComplete(() async {
          //   await _reference.getDownloadURL().then((value) {
          //     pict.value!.imagen.pictoEditado = value;
          //   });
          // });
          final value = await _dataController.uploadImageToStorageForWeb(
            storageName: 'testingUpload',
            imageInBytes: imageInBytes,
          );
          pict.value!.imagen.pictoEditado = value;
        } else {
          pict.value!.imagen.pictoEditado = selectedPhotoUrl.value;
        }
      } else {
        if (selectedPhotoUrl.value == '') {
          await uploadImageToFirebaseStorage(path: fileImage.value!.path);
        } else {
          pict.value!.imagen.pictoEditado = selectedPhotoUrl.value;
        }
      }
    }
    int index = 0;
    while (index < _homeController.picts.length) {
      if (pict.value!.id == _homeController.picts[index].id) {
        break;
      }
      index++;
    }
    _homeController.picts[index] = pict.value!;
    if (_homeController.editingFromHomeScreen) {
    } else {
      _pictoController.picts[index] = pict.value!;
    }
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
        language: _ttsController.languaje,
      );
      // print('writing to file');
    }
    //for the file data
    final instance = await SharedPreferences.getInstance();
    switch (_ttsController.languaje) {
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
    await sharedPref.getPictosFile();
    // print(res1);
    //upload to the firebase
    await uploadToFirebase(data: fileData.toString());
    await pictsExistsOnFirebase();
    // for refreshing the UI of listing
    if (_homeController.editingFromHomeScreen) {
      _homeController.updateSuggested(
          suggestedMainScreenIndex: _homeController.suggestedMainScreenIndex,
          updatedOne: pict.value!);
    } else {
      _pictoController.pictoGridviewOrPageview.value =
          !_pictoController.pictoGridviewOrPageview.value;
      _pictoController.pictoGridviewOrPageview.value =
          !_pictoController.pictoGridviewOrPageview.value;
    }
    _homeController.editingFromHomeScreen = false;
    Get.back();
    Navigator.of(context).pop(true);
  }

  Future<void> uploadImageToFirebaseStorage({required String path}) async {
    // Reference ref = FirebaseStorage.instance
    //     .ref()
    //     .child('testingUpload/')
    //     .child(pict.value!.texto.en);
    // final UploadTask uploadTask = ref.putFile(File(path));
    // final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    final url = await _dataController.uploadImageToStorage(
      path: path,
      storageDirectory: 'testingUpload',
      childName: nameController.text,
    );
    pict.value!.imagen.pictoEditado = url;
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    pict.value = _homeController.pictToBeEdited;
    lang = _ttsController.languaje;
  }

  @override
  void onReady() {
    super.onReady();
    // nameController.text = lang == 'en-US'
    //     ? pict.value!.texto.en.toUpperCase()
    //     : pict.value!.texto.es.toUpperCase();

    switch (lang) {
      case "es-AR":
        nameController.text = pict.value!.texto.es;
        break;
      case "en-US":
        nameController.text = pict.value!.texto.en;
        break;
      case "fr-FR":
        nameController.text = pict.value!.texto.fr;
        break;
      case "pt-BR":
        nameController.text = pict.value!.texto.pt;
        break;
      default:
        nameController.text = pict.value!.texto.es;
    }
  }
}
