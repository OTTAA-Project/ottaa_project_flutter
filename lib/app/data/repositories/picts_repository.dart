import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/service/picts_service.dart';

class PictsRepository {
  final PictsService _pictsService = Get.find<PictsService>();

  Future<List<Pict>> getAll() async {
    return _pictsService.getAll();
  }
}
