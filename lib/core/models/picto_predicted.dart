// coverage:ignore-file
import 'dart:convert';

import 'package:ottaa_project_flutter/core/models/picto_predicted_reduced.dart';

class PictoPredicted extends PictoPredictedReduced {
  double value;
  int contextScore;
  int tagScore;
  int nameLength;
  int nameSplitLength;

  PictoPredicted({
    required super.name,
    required super.id,
    required this.value,
    required this.contextScore,
    required this.tagScore,
    required this.nameLength,
    required this.nameSplitLength,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'value': value,
      'contextScore': contextScore,
      'tagScore': tagScore,
      'nameLength': nameLength,
      'nameSplitLength': nameSplitLength,
    };
  }

  factory PictoPredicted.fromMap(Map<String, dynamic> map) {
    return PictoPredicted(
      name: map['name'] as String,
      id: ((map['id'] ?? {}) as Map).map((key, value) {
        return MapEntry(key as String, value.toString());
      }),
      value: (map['value'] as num).toDouble(),
      contextScore: ((map['contextScore'] ?? 0) as num).toInt(),
      tagScore: ((map['tagScore'] ?? 0) as num).toInt(),
      nameLength: ((map['nameLength'] ?? 0) as num).toInt(),
      nameSplitLength: ((map['nameSplitLength'] ?? 0) as num).toInt(),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory PictoPredicted.fromJson(String source) =>
      PictoPredicted.fromMap(json.decode(source) as Map<String, dynamic>);
}
