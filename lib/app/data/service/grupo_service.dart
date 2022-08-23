import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';

class GrupoService {
  final _dataController = Get.find<DataController>();

  Future<List<Grupos>> getAll() async {
    return await _dataController.fetchGrupos();
  }

  Future<List<Grupos>> getFrench() async {
    final String grupoString =
        await rootBundle.loadString('assets/languages/grupos_fr.json');

    return (jsonDecode(grupoString) as List)
        .map((e) => Grupos.fromJson(e))
        .toList();
  }

  Future<List<Grupos>> getPortuguese() async {
    final String grupoString =
        await rootBundle.loadString('assets/languages/grupos_fr.json');

    return (jsonDecode(grupoString) as List)
        .map((e) => Grupos.fromJson(e))
        .toList();
  }
}

// final String grupoString =
// await rootBundle.loadString('assets/grupos.json');
//
// return (jsonDecode(grupoString) as List)
//     .map((e) => Grupos.fromJson(e))
//     .toList();
