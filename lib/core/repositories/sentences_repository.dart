import 'package:either_dart/either.dart';
import 'package:ottaa_project_flutter/core/models/sentence_model.dart';

abstract class SentencesRepository {
  Future<List<SentenceModel>> fetchSentences({
    required String language,
    required String type,
    bool isFavorite = false,
  });

  Future<void> uploadSentences({
    required String language,
    required List<SentenceModel> data,
    required String type,
  });
}
