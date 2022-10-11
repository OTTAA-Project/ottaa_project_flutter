import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';

class PictsService {
  Future<List<Pict>> getAll() async {
    final String pictsString =
        await rootBundle.loadString('assets/pictos.json');

    return (jsonDecode(pictsString) as List)
        .map((e) => Pict.fromJson(e))
        .toList();
  }
}
