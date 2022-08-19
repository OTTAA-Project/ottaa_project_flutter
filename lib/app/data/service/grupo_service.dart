import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';

class GrupoService {
  final _dataController = Get.find<DataController>();

  Future<List<Grupos>> getAll() async {
    return await _dataController.fetchGrupos();
  }
}

// final String grupoString =
// await rootBundle.loadString('assets/grupos.json');
//
// return (jsonDecode(grupoString) as List)
//     .map((e) => Grupos.fromJson(e))
//     .toList();
