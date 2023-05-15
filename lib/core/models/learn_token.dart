// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LearnToken {
  String name;

  String? id;

  LearnToken({
    required this.name,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': name,
      ...(id != null ? {'id': id} : {})
    };
  }

  factory LearnToken.fromMap(Map<String, dynamic> map) {
    return LearnToken(
      name: map['text'] as String,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LearnToken.fromJson(String source) =>
      LearnToken.fromMap(json.decode(source) as Map<String, dynamic>);
}
