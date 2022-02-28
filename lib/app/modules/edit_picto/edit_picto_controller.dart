import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/models/search_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/local_file_controller.dart';
import 'package:ottaa_project_flutter/app/global_controllers/shared_pref_client.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:http/http.dart' as http;
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:image_picker_web/image_picker_web.dart';
// // import 'dart:html' as html;
// import 'package:mime_type/mime_type.dart';
// import 'package:path/path.dart' as Path;

class EditPictoController extends GetxController {
  RxBool text = true.obs;
  RxBool frame = false.obs;
  RxBool tags = false.obs;
  RxBool pictoBorder = true.obs;
  final _homeController = Get.find<HomeController>();
  final _pictoController = Get.find<PictogramGroupsController>();
  final _ttsController = Get.find<TTSController>();
  final sharedPref = SharedPrefClient();
  TextEditingController nameController = TextEditingController();
  Rx<Pict?> pict = Rx<Pict?>(null);
  late String lang;
  final databaseRef = FirebaseDatabase.instance.reference();
  final ImagePicker picker = ImagePicker();
  RxBool editingPicture = false.obs;
  Rx<File?> fileImage = Rx<File?>(null);
  Rx<String> selectedPhotoUrl = ''.obs;
  Rx<XFile?> imageTobeUploaded = Rx<XFile?>(null);

  late String url;

  /// variables for web
  Rx<Image?> imageWidget = Rx<Image?>(null);

  Future<void> uploadToFirebase({required String data}) async {
    // final language = _ttsController.languaje;
    final User? auth = FirebaseAuth.instance.currentUser;
    final ref = databaseRef.child('Picto/${auth!.uid}/');
    await ref.set({
      'data': data,
    });
  }

  Future<void> pictsExistsOnFirebase() async {
    final User? auth = FirebaseAuth.instance.currentUser;
    final ref = databaseRef.child('PictsExistsOnFirebase/${auth!.uid}/');
    await ref.set({
      'value': true,
    });
  }

  Future<List<SearchModel>> fetchPhotoFromArsaac({required String text}) async {
    final String languageFormat = lang == 'en' ? '639-3' : '639-1';
    final language = lang == 'en' ? 'eng' : 'es';
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

  void uploadChanges({required BuildContext context}) async {
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
        if (selectedPhotoUrl.value == null) {
          Reference _reference = FirebaseStorage.instance
              .ref()
              .child('testingUpload/${pict.value!.texto.en}');
          await _reference
              .putData(
            await imageTobeUploaded.value!.readAsBytes(),
            SettableMetadata(contentType: 'image/jpeg'),
          )
              .whenComplete(() async {
            await _reference.getDownloadURL().then((value) {
              pict.value!.imagen.pictoEditado = value;
            });
          });
        } else {
          pict.value!.imagen.pictoEditado = selectedPhotoUrl.value;
        }
      } else {
        if (selectedPhotoUrl.value == null) {
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
    _pictoController.picts[index] = pict.value!;
    final data = _homeController.picts;
    List<String> fileData = [];
    data.forEach((element) {
      final obj = jsonEncode(element);
      fileData.add(obj);
    });
    if (!kIsWeb) {
      final localFile = LocalFileController();
      await localFile.writePictoToFile(data: fileData.toString());
      // print('writing to file');
    }
    //for the file data
    final instance = await SharedPreferences.getInstance();
    await instance.setBool('Pictos_file', true);
    final res1 = await sharedPref.getPictosFile();
    // print(res1);
    //upload to the firebase
    await uploadToFirebase(data: fileData.toString());
    await pictsExistsOnFirebase();
    // for refreshing the UI of listing
    _pictoController.pictoGridviewOrPageview.value =
        !_pictoController.pictoGridviewOrPageview.value;
    _pictoController.pictoGridviewOrPageview.value =
        !_pictoController.pictoGridviewOrPageview.value;
    Get.back();
    Navigator.of(context).pop(true);
  }

  Future<void> uploadImageToFirebaseStorage({required String path}) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('testingUpload/')
        .child(pict.value!.texto.en);
    final UploadTask uploadTask = ref.putFile(File(path));
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    final url = await taskSnapshot.ref.getDownloadURL();
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
    nameController.text =
        lang == 'en' ? pict.value!.texto.en : pict.value!.texto.es;
  }
}
