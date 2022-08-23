import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/service/picts_service.dart';

class PictsRepository {
  PictsService _pictsService = Get.find<PictsService>();

  Future<List<Pict>> getAll() async {
    return _pictsService.getAll();
  }
  Future<List<Pict>> getFrench() async {
    return _pictsService.getFrench();
  }

  Future<List<Pict>> getPortuguese() async {
    return _pictsService.getPortuguese();
  }
}
