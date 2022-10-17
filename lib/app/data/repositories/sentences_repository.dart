import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/sentence_model.dart';
import 'package:ottaa_project_flutter/app/data/service/sentences_service.dart';

class SentencesRepository {
  SentencesService _sentencesService = Get.find<SentencesService>();

  Future<List<Sentence>> getAll({
    required String language,
    required String type,
  }) async =>
      _sentencesService.getAll(
        type: type,
        language: language,
      );

  Future<List<Sentence>> fetchFavouriteFrases({
    required String language,
    required String type,
  }) async =>
      _sentencesService.fetchFavouriteFrases(
        language: language,
        type: type,
      );
}
