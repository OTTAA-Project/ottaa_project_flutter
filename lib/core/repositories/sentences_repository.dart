import 'package:ottaa_project_flutter/core/models/phrase_model.dart';

abstract class SentencesRepository {
  Future<List<Phrase>> fetchSentences({
    required String language,
    required String type,
    bool isFavorite = false,
  });

  Future<void> uploadSentences({
    required String language,
    required List<Phrase> data,
    required String type,
  });
}
