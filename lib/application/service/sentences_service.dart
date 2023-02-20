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
  Future<List<Phrase>> fetchSentences({required String language, required String type, bool isFavorite = false}) async {
    final authResult = await _auth.getCurrentUser();

    if (authResult.isLeft) return [];

    final user = authResult.right;

    return await _serverRepository.getUserSentences(
      user.id,
      language: language,
      type: type,
    );
  }

  @override
  Future<void> uploadSentences({required String language, required List<Phrase> data, required String type}) async {
    final authResult = await _auth.getCurrentUser();

    if (authResult.isLeft) return;

    final user = authResult.right;

    final List<Map<String, dynamic>> jsonData = List.empty(growable: true);
    for (var e in data) {
      jsonData.add(e.toMap());
    }

    _serverRepository.uploadUserSentences(user.id, language, type, jsonData);
  }
}
