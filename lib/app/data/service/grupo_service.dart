import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';

class GrupoService {
  Future<List<Grupos>> getAll() async {
    final String grupoString =
    await rootBundle.loadString('assets/grupos.json');

    return (jsonDecode(grupoString) as List)
        .map((e) => Grupos.fromJson(e))
        .toList();
  }
}