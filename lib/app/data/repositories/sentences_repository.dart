import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/sentence_model.dart';
import 'package:ottaa_project_flutter/app/data/service/sentences_service.dart';

class SentencesRepository {
  final SentencesService _pictsService = Get.find<SentencesService>();

  Future<List<Sentence>> getAll() async {
    return _pictsService.getAll();
  }
}
