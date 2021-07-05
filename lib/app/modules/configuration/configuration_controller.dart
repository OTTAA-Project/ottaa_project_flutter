import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';

class ConfigurationController extends GetxController {
  final _ttsController = Get.find<TTSController>();
  TTSController get ttsController => this._ttsController;

  toggleLanguaje(bool value) {
    if (value == false) {
      _ttsController.languaje = "es-US";
      _ttsController.isEnglish = value;
    } else {
      _ttsController.languaje = "en-US";
      _ttsController.isEnglish = value;
    }
    update();
  }

  setPitch(value) {
    _ttsController.pitch = value;
    update();
  }

  setRate(value) {
    _ttsController.rate = value;
    update();
  }
}
