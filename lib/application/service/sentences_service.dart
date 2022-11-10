import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:ottaa_project_flutter/core/models/sentence_model.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/sentences_repository.dart';

class SentencesService implements SentencesRepository {
  final AuthRepository _auth;
  final _database = FirebaseDatabase.instance.ref();

  SentencesService(this._auth);

  @override
  Future<List<SentenceModel>> fetchSentences({required String language, required String type, bool isFavorite = false}) async {
    final authResult = await _auth.getCurrentUser();

    if (authResult.isLeft) return [];

    final user = authResult.right;

    final refNew = _database.child('${user.id}/Frases/$language/$type');
    final resNew = await refNew.get();
    if (resNew.exists && resNew.value != null) {
      final encode = jsonEncode(resNew.value);
      // print('returned from bew');
      return (jsonDecode(encode) as List).map((e) => SentenceModel.fromJson(e)).toList();
    } else {
      final refOld = _database.child('Frases/${user.id}/$language/$type');
      final resOld = await refOld.get();
      if (resOld.exists && resOld.value != null) {
        final data = resOld.children.first.value as String;
        final da = (jsonDecode(data) as List).map((e) => SentenceModel.fromJson(e)).toList();

        return da;
      } else {
        /// if there are no frases we will be returning the empty string
        return [];
      }
    }
  }

  @override
  Future<void> uploadSentences({required String language, required List<SentenceModel> data, required String type}) async {
    final authResult = await _auth.getCurrentUser();

    if (authResult.isLeft) return;

    final user = authResult.right;
    final ref = _database.child('${user.id}/Frases/$language/$type');
    final List<Map<String, dynamic>> jsonData = List.empty(growable: true);
    for (var e in data) {
      jsonData.add(e.toJson());
    }
    await ref.set(jsonData);
  }
}
