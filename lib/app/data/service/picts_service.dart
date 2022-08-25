import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';

class PictsService {
  final _dataController = Get.find<DataController>();

  Future<List<Pict>> getAll() async {
    return _dataController.fetchPictos();
  }

  Future<List<Pict>> getPortuguese() async {
    return _dataController.fetchOtherPictos(
      languageName: 'portuguesePicto',
      assetName: 'assets/languages/pictos_pt.json',
      firebaseName: 'portuguesePicto',
      fileName: 'picto_pt_file',
    );
  }

  Future<List<Pict>> getFrench() async {
    return _dataController.fetchOtherPictos(
      languageName: 'frenchPicto',
      assetName: 'assets/languages/pictos_fr.json',
      firebaseName: 'frenchPicto',
      fileName: 'picto_fr_file',
    );
  }
}
