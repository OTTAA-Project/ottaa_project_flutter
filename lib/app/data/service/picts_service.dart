import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';
import 'package:ottaa_project_flutter/app/utils/constants.dart';

class PictsService {
  final _dataController = Get.find<DataController>();

  Future<List<Pict>> getAll() async {
    return _dataController.fetchPictos();
  }

  Future<List<Pict>> getPortuguese() async {
    return _dataController.fetchOtherPictos(
      languageName: Constants.PORTUGUESE_LANGUAGE_NAME,
      assetName: 'assets/languages/pictos_pt.json',
      firebaseName: Constants.PORTUGUESE_PICTO_FIREBASE_NAME,
      fileName: Constants.PORTUGUESE_PICTO_FILE_NAME,
    );
  }

  Future<List<Pict>> getFrench() async {
    return _dataController.fetchOtherPictos(
      languageName: Constants.FRENCH_LANGUAGE_NAME,
      assetName: 'assets/languages/pictos_fr.json',
      firebaseName: Constants.FRENCH_PICTO_FIREBASE_NAME,
      fileName: Constants.FRENCH_PICTO_FILE_NAME,
    );
  }
}
