import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class OnboardingController extends GetxController {
  final _authController = Get.find<AuthController>();
  RxInt imageNumber = 671.obs;
  RxInt pageNumber = 0.obs;

  AuthController get authController => this._authController;
  RxString name = ''.obs;
  RxInt dateOfBirthInMs = 0.obs;
  RxString gender = '${'Male'.tr}'.obs;
  final databaseRef = FirebaseDatabase.instance.reference();

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
    final User? auth = FirebaseAuth.instance.currentUser;
    final ref = databaseRef.child('Usuarios/${auth!.uid}/');
    await ref.set(<String, Object>{
      'Nombre': name.value,
      'birth_date': dateOfBirthInMs.value,
      'pref_sexo': gender.value,
    }).then((onValue) {
      return true;
    }).catchError((onError) {
      print(onError.toString());
      return false;
    });
    print('hi');
  }

  Future<void> uploadAvatar({required int photoNumber}) async {
    final User? auth = FirebaseAuth.instance.currentUser;
    final ref = databaseRef.child('Avatar/${auth!.uid}/');
    await ref.set({
      'name': 'TestName',
      'urlFoto': photoNumber,
    });
  }

  // Future<void> uploadToStorage() async {
  //   firebase_storage.FirebaseStorage storage =
  //       firebase_storage.FirebaseStorage.instance;
  // }

  Future<void> setFirstTimePref() async {
    final instance = await SharedPreferences.getInstance();
    instance.setBool('First_time', true);
  }
  Future<void> setPhotoPref() async {
    final instance = await SharedPreferences.getInstance();
    instance.setBool('Avatar_photo', true);
  }

  _init() async {}
}
