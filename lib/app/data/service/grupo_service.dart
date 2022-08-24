import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';

class GrupoService {
  final _dataController = Get.find<DataController>();

  Future<List<Grupos>> getAll() async {
    return await _dataController.fetchGrupos();
  }

  Future<List<Grupos>> getFrench() async {
    return _dataController.fetchOtherGrupos(
      languageName: 'French',
      assetName: 'assets/languages/grupos_fr.json',
      firebaseName: 'frenchGrupo',
      fileName: 'grupo_fr_file',
    );
  }

  Future<List<Grupos>> getPortuguese() async {
    return _dataController.fetchOtherGrupos(
      languageName: 'Portuguese',
      assetName: 'assets/languages/grupos_pt.json',
      firebaseName: 'portugueseGrupo',
      fileName: 'grupo_pt_file',
    );
  }
}

// final String grupoString =
// await rootBundle.loadString('assets/grupos.json');
//
// return (jsonDecode(grupoString) as List)
//     .map((e) => Grupos.fromJson(e))
//     .toList();
