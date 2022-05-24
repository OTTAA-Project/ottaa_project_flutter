import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';

class PictsService {
  final _dataController = Get.find<DataController>();

  Future<List<Pict>> getAll() async {
    return _dataController.fetchPictos();
  }
}
