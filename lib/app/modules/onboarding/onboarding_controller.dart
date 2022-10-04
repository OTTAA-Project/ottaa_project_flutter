import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';
import 'package:ottaa_project_flutter/app/global_controllers/local_file_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController extends GetxController {
  final _authController = Get.find<AuthController>();
  final _dataController = Get.find<DataController>();
  RxInt imageNumber = 671.obs;
  RxInt pageNumber = 0.obs;

  AuthController get authController => this._authController;
  RxString name = ''.obs;
  RxInt dateOfBirthInMs = 0.obs;
  RxString gender = '${'Male'.tr}'.obs;

  // final firebaseAuth = FirebaseAuth.instance

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController =
      TextEditingController(text: '${'Male'.tr}');
  TextEditingController birthDateController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    await _init();
  }

  Future<void> uploadInfo() async {
    // final User? auth = FirebaseAuth.instance.currentUser;
    // final ref = databaseRef.child('Usuarios/${auth!.uid}/');
    // await ref.set(<String, Object>{
    //   'Nombre': name.value,
    //   'birth_date': dateOfBirthInMs.value,
    //   'pref_sexo': gender.value,
    // }).then((onValue) {
    //   return true;
    // }).catchError((onError) {
    //   print(onError.toString());
    //   return false;
    // });
    await _dataController.uploadInfo(
      name: name.value,
      gender: gender.value,
      dateOfBirthInMs: dateOfBirthInMs.value,
    );
    print('hi');
  }

  Future<void> uploadAvatar({required int photoNumber}) async {
    await _dataController.uploadAvatar(photoNumber: photoNumber);
  }

  // Future<void> uploadToStorage() async {
  //   firebase_storage.FirebaseStorage storage =
  //       firebase_storage.FirebaseStorage.instance;
  // }

  _init() async {}

  Future<void> uploadDataForSelectedGender({required bool maleOrFemale}) async {
    late dynamic fileData;
    if (maleOrFemale) {
      ///male pictos
      final String pictsString = await rootBundle
          .loadString('assets/gender_based/pictos/pictos_es_male.json');

      final data = (jsonDecode(pictsString) as List)
          .map((e) => Pict.fromJson(e))
          .toList();
      fileData = [];
      data.forEach((element) {
        final obj = jsonEncode(element);
        fileData.add(obj);
      });
      _dataController.uploadDataToFirebaseRealTime(
        data: fileData.toString(),
        type: 'Pictos',
        languageCode: "es-AR",
      );
    } else {
      /// female pictos
      final String pictsString = await rootBundle
          .loadString('assets/gender_based/pictos/pictos_es_female.json');

      final data = (jsonDecode(pictsString) as List)
          .map((e) => Pict.fromJson(e))
          .toList();
      fileData = [];
      data.forEach((element) {
        final obj = jsonEncode(element);
        fileData.add(obj);
      });
      _dataController.uploadDataToFirebaseRealTime(
        data: fileData.toString(),
        type: 'Pictos',
        languageCode: "es-AR",
      );
    }

    /// saving changes to file
    if (!kIsWeb) {
      final localFile = LocalFileController();
      await localFile.writePictoToFile(
        data: fileData.toString(),
        language: 'es-AR',
      );
      // print('writing to file');
      //for the file data
      final instance = await SharedPreferences.getInstance();
      await instance.setBool('Pictos_file', true);
    }
  }
}
