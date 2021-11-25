import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController extends GetxController {
  final _authController = Get.find<AuthController>();

  AuthController get authController => this._authController;
  RxString name = ''.obs;
  RxInt dateOfBirthInMs = 0.obs;
  RxString gender = ''.obs;
  final databaseRef = FirebaseDatabase.instance.reference();

  // final firebaseAuth = FirebaseAuth.instance

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    await _init();
  }

  Future<void> uploadInfo() async {
    final User? auth = FirebaseAuth.instance.currentUser;
    final ref = databaseRef.child('Usuarios/${auth!.uid}/');
    await ref.set({
      'Nombre': name.value,
      'birth_date': dateOfBirthInMs.value,
      'pref_sexo': gender.value,
    }).then((value) => print('done'));
  }
  Future<void> setPref()async{
    final instance = await SharedPreferences.getInstance();
    instance.setBool('First_time', true);
  }

  _init() async {}
}
