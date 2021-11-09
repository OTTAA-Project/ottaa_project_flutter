import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/data/service/grupo_service.dart';

class GrupoRepository {
  GrupoService _gruposService = Get.find<GrupoService>();

  Future<List<Grupos>> getAll() async {
    return _gruposService.getAll();
  }
}