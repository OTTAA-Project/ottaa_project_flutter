import 'dart:convert';

class PictoPredictedReduced {
  String name;
  bool isCached;
  Map<String, String> id;

  PictoPredictedReduced({
    required this.name,
    required this.isCached,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'isCached': isCached,
      'id': id,
    };
  }

  factory PictoPredictedReduced.fromMap(Map<String, dynamic> map) {
    return PictoPredictedReduced(
      name: map['name'] as String,
      isCached: map['isCached'] as bool,
      id: ((map['id'] ?? {}) as Map).map((key, value) {
        return MapEntry(key as String, value.toString());
      }),
    );
  }

  String toJson() => json.encode(toMap());

  factory PictoPredictedReduced.fromJson(String source) => PictoPredictedReduced.fromMap(json.decode(source) as Map<String, dynamic>);
}
