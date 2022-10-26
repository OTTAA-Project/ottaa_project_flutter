import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/data/service/grupo_service.dart';
import 'package:ottaa_project_flutter/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GrupoRepository {
  GrupoService _gruposService = Get.find<GrupoService>();

  Future<List<Grupos>> getAll() async {
    return await _gruposService.getAll();
  }
}