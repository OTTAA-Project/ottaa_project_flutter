import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/sentence_model.dart';
import 'package:ottaa_project_flutter/app/data/service/sentences_service.dart';

class SentencesRepository {
  SentencesService _sentencesService = Get.find<SentencesService>();

  Future<List<Sentence>> getAll() async {
    return _sentencesService.getAll();
  }
}
