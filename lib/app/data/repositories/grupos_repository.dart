import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/data/service/grupo_service.dart';
import 'package:ottaa_project_flutter/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GrupoRepository {
  GrupoService _gruposService = Get.find<GrupoService>();

  Future<List<Grupos>> getAll() async {
    final instance = await SharedPreferences.getInstance();
    final String language = Constants
        .LANGUAGE_CODES[instance.getString('Language_KEY') ?? 'Spanish']!;
    switch (language) {
      case "es-AR":
        return _gruposService.getAll();
      case "en-US":
        return _gruposService.getAll();
      case "fr-FR":
        return _gruposService.getFrench();
      case "pt-BR":
        return _gruposService.getPortuguese();
      default:
        return _gruposService.getAll();
    }
  }
}
