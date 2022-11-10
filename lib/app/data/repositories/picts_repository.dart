import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/service/picts_service.dart';
import 'package:ottaa_project_flutter/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PictsRepository {
  PictsService _pictsService = Get.find<PictsService>();

  Future<List<Pict>> getAll() async {
    return await _pictsService.getAll();
  }
}
