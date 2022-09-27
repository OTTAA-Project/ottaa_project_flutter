import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/service/picts_service.dart';
import 'package:ottaa_project_flutter/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PictsRepository {
  PictsService _pictsService = Get.find<PictsService>();

  Future<List<Pict>> getAll() async {
    // return _pictsService.getAll();
    final instance = await SharedPreferences.getInstance();
    final String language = Constants
        .LANGUAGE_CODES[instance.getString('Language_KEY') ?? 'Spanish']!;
    switch (language) {
      case "es-AR":
        return _pictsService.getAll();
      case "en-US":
        return _pictsService.getAll();
      case "fr-FR":
        return _pictsService.getFrench();
      case "pt-BR":
        return _pictsService.getPortuguese();
      default:
        return _pictsService.getAll();
    }
  }
  Future<List<Pict>> getFrench() async {
    return _pictsService.getFrench();
  }

  Future<List<Pict>> getPortuguese() async {
    return _pictsService.getPortuguese();
  }
}
