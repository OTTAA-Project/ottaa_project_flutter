import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';
import 'package:ottaa_project_flutter/app/utils/constants.dart';

class GrupoService {
  final _dataController = Get.find<DataController>();

  Future<List<Grupos>> getAll() async {
    return await _dataController.fetchGrupos();
  }

  Future<List<Grupos>> getFrench() async {
    return _dataController.fetchOtherGrupos(
      languageName: Constants.FRENCH_LANGUAGE_NAME,
      assetName: 'assets/languages/grupos_fr.json',
      firebaseName: Constants.FRENCH_GRUPO_FIREBASE_NAME,
      fileName: Constants.FRENCH_GRUPO_FILE_NAME,
    );
  }

  Future<List<Grupos>> getPortuguese() async {
    return _dataController.fetchOtherGrupos(
      languageName: Constants.PORTUGUESE_LANGUAGE_NAME,
      assetName: 'assets/languages/grupos_pt.json',
      firebaseName: Constants.PORTUGUESE_GRUPO_FIREBASE_NAME,
      fileName: Constants.PORTUGUESE_GRUPO_FILE_NAME,
    );
  }
}

// final String grupoString =
// await rootBundle.loadString('assets/grupos.json');
//
// return (jsonDecode(grupoString) as List)
//     .map((e) => Grupos.fromJson(e))
//     .toList();
