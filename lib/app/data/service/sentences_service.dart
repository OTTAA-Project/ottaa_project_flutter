import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ottaa_project_flutter/app/data/models/sentence_model.dart';

class SentencesService {
  Future<List<Sentence>> getAll() async {
    final String sentencesString = await rootBundle.loadString('assets/frases.json');

    return (jsonDecode(sentencesString) as List).map((e) => Sentence.fromJson(e)).toList();
  }
}
