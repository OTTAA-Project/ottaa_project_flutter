import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';
import 'package:ottaa_project_flutter/app/utils/constants.dart';
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
    if (maleOrFemale) {
      ///male pictos
      print('came to male');
      await uploadPictos(
        assetRoute: 'assets/gender_based/pictos/pictos_es_male.json',
      );
      await uploadGrupos(
        assetRoute: 'assets/gender_based/grupos/grupos_es_male.json',
      );
    } else {
      /// female pictos
      print('came to female');
      await uploadPictos(
        assetRoute: 'assets/gender_based/pictos/pictos_es_female.json',
      );
      await uploadGrupos(
        assetRoute: 'assets/gender_based/grupos/grupos_es_female.json',
      );
    }
  }

  Future<void> uploadPictos({
    required String assetRoute,
    // required String type,
  }) async {
    final dynamic pictsString = await rootBundle.loadString(assetRoute);

    final data =
        (jsonDecode(pictsString) as List).map((e) => Pict.fromJson(e)).toList();
    final dynamic fileData = [];
    data.forEach((element) {
      final obj = jsonEncode(element);
      fileData.add(obj);
    });
    await _dataController.uploadPictosToFirebaseRealTime(
      data: data,
      type: 'Pictos',
      languageCode: "es-AR",
    );
    // if (!kIsWeb) {
    //   final localFile = LocalFileController();
    //   await localFile.writePictoToFile(
    //     data: fileData.toString(),
    //     language: 'es-AR',
    //   );
    //   // print('writing to file');
    //   //for the file data
    //   final instance = await SharedPreferences.getInstance();
    //   await instance.setBool(
    //       Constants
    //           .LANGUAGE_CODES[instance.getString('Language_KEY') ?? 'Spanish']!,
    //       true);
    // }
    // await _dataController.uploadBoolToFirebaseRealtime(
    //   data: true,
    //   type: 'PictsExistsOnFirebase',
    // );
  }

  Future<void> uploadGrupos({
    required String assetRoute,
    // required String type,
  }) async {
    final dynamic gruposString = await rootBundle.loadString(assetRoute);

    final data = (jsonDecode(gruposString) as List)
        .map((e) => Grupos.fromJson(e))
        .toList();
    final dynamic fileData = [];
    data.forEach((element) {
      final obj = jsonEncode(element);
      fileData.add(obj);
    });
    await _dataController.uploadGruposToFirebaseRealTime(
      data: data,
      type: 'Grupos',
      languageCode: "es-AR",
    );
    /*if (!kIsWeb) {
      final localFile = LocalFileController();
      await localFile.writeGruposToFile(
        data: fileData.toString(),
        language: 'es-AR',
      );

      // print('writing to file');
      //for the file data
      final instance = await SharedPreferences.getInstance();
      await instance.setBool(
          "${Constants.LANGUAGE_CODES[instance.getString('Language_KEY') ?? 'Spanish']!}_grupo",
          true);
    }*/
  }
}
