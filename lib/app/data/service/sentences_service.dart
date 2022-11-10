import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/sentence_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';

class SentencesService {
  final DataController _dataController = Get.find<DataController>();

  Future<List<Sentence>> getAll({
    required String language,
    required String type,
  }) async =>
      await _dataController.fetchFrases(
        language: language,
        type: type,
      );

  Future<List<Sentence>> fetchFavouriteFrases({
    required String language,
    required String type,
  }) async =>
      await _dataController.fetchFavouriteFrases(
        language: language,
        type: type,
      );
}
