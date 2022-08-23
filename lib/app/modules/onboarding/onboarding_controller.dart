import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';

class OnboardingController extends GetxController {
  final _authController = Get.find<AuthController>();
  final _dataController = Get.find<DataController>();
  RxInt imageNumber = 671.obs;
  RxInt pageNumber = 0.obs;

  AuthController get authController => _authController;
  RxString name = ''.obs;
  RxInt dateOfBirthInMs = 0.obs;
  RxString gender = 'Male'.tr.obs;

  // final firebaseAuth = FirebaseAuth.instance

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController(text: 'Male'.tr);
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
}
