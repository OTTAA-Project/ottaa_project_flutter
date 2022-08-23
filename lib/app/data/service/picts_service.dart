import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';

class PictsService {
  final _dataController = Get.find<DataController>();

  Future<List<Pict>> getAll() async {
    return _dataController.fetchPictos();
  }

  Future<List<Pict>> getFrench() async {
    final pictsString =
        await rootBundle.loadString('assets/languages/pictos_fr.json');
    final pictos =
        (jsonDecode(pictsString) as List).map((e) => Pict.fromJson(e)).toList();
    return pictos;
  }

  Future<List<Pict>> getPortuguese() async {
    final pictsString =
        await rootBundle.loadString('assets/languages/pictos_pt.json');
    final pictos =
        (jsonDecode(pictsString) as List).map((e) => Pict.fromJson(e)).toList();
    return pictos;
  }
}
