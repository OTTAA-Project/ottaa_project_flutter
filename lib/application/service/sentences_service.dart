import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/core/models/phrase_model.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/sentences_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

@Singleton(as: SentencesRepository)
class SentencesService implements SentencesRepository {
  final AuthRepository _auth;
  final ServerRepository _serverRepository;

  SentencesService(this._auth, this._serverRepository);

  @override
  Future<Either<String, List<Phrase>>> fetchSentences({required String language, required String type, bool isFavorite = false}) async {
    final authResult = await _auth.getCurrentUser();

    if (authResult.isLeft) return const Left('no data');

    final user = authResult.right;

    final response = await _serverRepository.getUserSentences(
      user.id,
      language: language,
      type: type,
    );

    if (response.isEmpty) return const Left('no data');
    List<Phrase> data = response.map((e) => Phrase.fromMap(e)).toList();

    return Right(data);
  }

  @override
  Future<EitherVoid> uploadSentences({required String language, required List<Phrase> data, required String type}) async {
    final authResult = await _auth.getCurrentUser();

    if (authResult.isLeft) return const Left("no user");

    final user = authResult.right;

    final List<Map<String, dynamic>> jsonData = List.empty(growable: true);
    for (var e in data) {
      jsonData.add(e.toMap());
    }

    _serverRepository.uploadUserSentences(user.id, language, type, jsonData);
    return const Right(null);
  }
}
