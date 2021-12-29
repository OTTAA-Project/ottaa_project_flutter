import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/auth_controller.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';

class SettingsController extends GetxController {
  final _ttsController = Get.find<TTSController>();
  TTSController get ttsController => this._ttsController;
  final _authController = Get.find<AuthController>();
  AuthController get authController => this._authController;


  toggleIsCustomTTSEnable(bool value) {
    _ttsController.isCustomTTSEnable = value;
    update();
  }

  toggleIsCustomSubtitle(bool value) {
    _ttsController.isCustomSubtitle = value;
    update();
  }

  toggleIsSubtitleUppercase(bool value) {
    _ttsController.isSubtitleUppercase = value;
    update();
  }

  toggleLanguaje(bool value) {
    if (value == false) {
      _ttsController.languaje = "es";
      _ttsController.isEnglish = value;
    } else {
      _ttsController.languaje = "en";
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
  setSubtitleSize(value) {
    _ttsController.subtitleSize = value;
    update();
  }
}
