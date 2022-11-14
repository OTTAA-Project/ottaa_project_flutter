import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/repositories/grupos_repository.dart';
import 'package:ottaa_project_flutter/app/data/repositories/picts_repository.dart';
import 'package:ottaa_project_flutter/app/global_controllers/auth_controller.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:ottaa_project_flutter/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  final _ttsController = Get.find<TTSController>();
  final _homeController = Get.find<HomeController>();
  final _pictogramController = Get.find<PictogramGroupsController>();
  final _pictsRepository = Get.find<PictsRepository>();
  final _grupoRepository = Get.find<GrupoRepository>();

  TTSController get ttsController => this._ttsController;
  final _authController = Get.find<AuthController>();
  RxString language = ''.obs;

  AuthController get authController => this._authController;

  toggleIsCustomTTSEnable(bool value) {
    _ttsController.isCustomTTSEnable = value;
    update();
  }

  @override
  void onInit() async {
    final instance = await SharedPreferences.getInstance();
    language.value = instance.getString('Language_KEY') ?? 'Spanish';
    print(language.value);
    super.onInit();
  }

  toggleIsCustomSubtitle(bool value) {
    _ttsController.isCustomSubtitle = value;
    update();
  }

  toggleIsSubtitleUppercase(bool value) {
    _ttsController.isSubtitleUppercase = value;
    update();
  }

  toggleLanguaje(String value) async {
    _ttsController.languaje = Constants.LANGUAGE_CODES[value];
    final instance = await SharedPreferences.getInstance();
    /*if (language.value == 'French') {
      _homeController.picts = await _pictsRepository.getFrench();
      _homeController.grupos = await _grupoRepository.getFrench();
    }
    if (language.value == 'Portuguese') {
      _homeController.picts = await _pictsRepository.getPortuguese();
      _homeController.grupos = await _grupoRepository.getPortuguese();
    }
    if (language.value == 'Spanish' || language.value == 'English') {
      _homeController.picts = await _pictsRepository.getAll();
      _homeController.grupos = await _grupoRepository.getAll();
    }*/
    _homeController.picts.clear();
    _homeController.grupos.clear();
    _homeController.picts = await _pictsRepository.getAll();
    _homeController.grupos = await _grupoRepository.getAll();
    _homeController.language = _ttsController.languaje;
    await _homeController.suggest(0);
    instance.setString('Language_KEY', language.value);
    print(language.value);
    await _pictogramController.loadAssets();
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
