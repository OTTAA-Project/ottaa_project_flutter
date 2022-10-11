import 'package:get/get.dart';

import 'sentences_controller.dart';

class SentencesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SentencesController());
  }
}
