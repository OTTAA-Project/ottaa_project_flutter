import 'package:either_dart/either.dart';
import 'package:ottaa_project_flutter/core/models/sentence_model.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/sentences_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

class SentencesService implements SentencesRepository {
  final AuthRepository _auth;
  final ServerRepository _serverRepository;

  SentencesService(this._auth, this._serverRepository);

  @override
  Future<Either<String, List<SentenceModel>>> fetchSentences(
      {required String language,
      required String type,
      bool isFavorite = false}) async {
    final authResult = await _auth.getCurrentUser();

    if (authResult.isLeft) return Left(authResult.left);

    final user = authResult.right;

    final data = await _serverRepository.getUserSentences(user.id,
        language: language, type: type);

    if (data.isLeft) return Left(data.left);

    final sentences = data.right;

    return Right(sentences.map((e) => SentenceModel.fromJson(e)).toList());
  }

  @override
  Future<void> uploadSentences(
      {required String language,
      required List<SentenceModel> data,
      required String type}) async {
    final authResult = await _auth.getCurrentUser();

    if (authResult.isLeft) return;

    final user = authResult.right;

    final List<Map<String, dynamic>> jsonData = List.empty(growable: true);
    for (var e in data) {
      jsonData.add(e.toJson());
    }

    _serverRepository.uploadUserSentences(user.id, language, type, jsonData);
  }
}
