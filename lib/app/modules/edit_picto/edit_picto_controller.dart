import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditPictoController extends GetxController {
  RxBool text = true.obs;
  RxBool frame = false.obs;
  RxBool tags = false.obs;
  TextEditingController nameController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
