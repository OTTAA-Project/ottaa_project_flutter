import 'dart:convert';

class PictoPredictedReduced {
  String name;
  Map<String, String> id;

  PictoPredictedReduced({
    required this.name,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
    };
  }

  factory PictoPredictedReduced.fromMap(Map<String, dynamic> map) {
    return PictoPredictedReduced(
      name: map['name'] as String,
      id: ((map['id'] ?? {}) as Map).map((key, value) {
        return MapEntry(key as String, value.toString());
      }),
    );
  }

  String toJson() => json.encode(toMap());

  factory PictoPredictedReduced.fromJson(String source) => PictoPredictedReduced.fromMap(json.decode(source) as Map<String, dynamic>);
}
