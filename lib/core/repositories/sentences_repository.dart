import 'package:either_dart/either.dart';
import 'package:ottaa_project_flutter/core/models/phrase_model.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

abstract class SentencesRepository {
  Future<Either<String,List<Phrase>>> fetchSentences({
    required String language,
    required String type,
    bool isFavorite = false,
  });

  Future<EitherVoid> uploadSentences({
    required String language,
    required List<Phrase> data,
    required String type,
  });
}
