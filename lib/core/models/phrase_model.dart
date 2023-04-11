// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';

part 'phrase_model.g.dart';

@HiveType(typeId: HiveTypesIds.phraseTypeId)
class Phrase {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final List<Sequence> sequence;

  @HiveField(3)
  final Map<String, List<String>> tags;

  const Phrase({
    required this.date,
    required this.id,
    required this.sequence,
    required this.tags,
  });

  Phrase copyWith({
    DateTime? date,
    String? id,
    List<Sequence>? sequence,
    Map<String, List<String>>? tags,
  }) {
    return Phrase(
      date: date ?? this.date,
      id: id ?? this.id,
      sequence: sequence ?? this.sequence,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.millisecondsSinceEpoch,
      'id': id,
      'sequence': sequence.map((x) => x.toMap()).toList(),
      'tags': tags,
    };
  }

  factory Phrase.fromMap(Map<String, dynamic> map) {
    return Phrase(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      id: map['id'] as String,
      sequence: List<Sequence>.from(
        (map['sequence'] as List<int>).map<Sequence>(
          (x) => Sequence.fromMap(x as Map<String, dynamic>),
        ),
      ),
      tags: Map<String, List<String>>.from((map['tags'] as Map<String, List<String>>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Phrase.fromJson(String source) => Phrase.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Phrase(date: $date, id: $id, sequence: $sequence, tags: $tags)';
  }

  @override
  bool operator ==(covariant Phrase other) {
    if (identical(this, other)) return true;

    return other.date == date && other.id == id && listEquals(other.sequence, sequence) && mapEquals(other.tags, tags);
  }

  @override
  int get hashCode {
    return date.hashCode ^ id.hashCode ^ sequence.hashCode ^ tags.hashCode;
  }
}

@HiveType(typeId: HiveTypesIds.sequenceTypeId)
class Sequence {
  @HiveField(0)
  final String id;

  const Sequence({
    required this.id,
  });

  Sequence copyWith({
    String? id,
  }) {
    return Sequence(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory Sequence.fromMap(Map<String, dynamic> map) {
    return Sequence(
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Sequence.fromJson(String source) => Sequence.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Sequence(id: $id)';

  @override
  bool operator ==(covariant Sequence other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
