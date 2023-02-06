// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';

part 'picto_model.g.dart';

@HiveType(typeId: HiveTypesIds.pictoTypeId)
class Picto {
  @HiveField(0, defaultValue: false)
  bool block;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final List<PictoRelation> relations;
  @HiveField(3, defaultValue: "")
  String text;

  @HiveField(4)
  AssetsImage resource;

  @HiveField(5)
  double freq;

  @HiveField(6, defaultValue: <String, List<String>>{})
  Map<String, List<String>> tags;

  @HiveField(7)
  int type;

  Picto({
    required this.id,
    required this.type,
    required this.resource,
    this.text = "",
    this.freq = 0,
    this.block = false,
    this.relations = const [],
    this.tags = const <String, List<String>>{},
  });

  Picto copyWith({
    bool? block,
    String? id,
    List<PictoRelation>? relations,
    String? text,
    AssetsImage? resource,
    double? freq,
    Map<String, List<String>>? tags,
    int? type,
  }) {
    return Picto(
      block: block ?? this.block,
      id: id ?? this.id,
      relations: relations ?? this.relations,
      text: text ?? this.text,
      resource: resource ?? this.resource,
      freq: freq ?? this.freq,
      tags: tags ?? this.tags,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'block': block,
      'id': id,
      'relations': relations.map((x) => x.toMap()).toList(),
      'text': text,
      'resource': resource.toMap(),
      'freq': freq,
      'tags': tags,
      'type': type,
    };
  }

  factory Picto.fromMap(Map<String, dynamic> map) {
    return Picto(
      block: map['block'] ?? false,
      id: map['id'] ?? "",
      relations: map['relations'] != null
          ? List<PictoRelation>.from(
              (map['relations'] as List<dynamic>).map<PictoRelation>(
                (x) =>
                    PictoRelation.fromMap(Map.from(x as Map<dynamic, dynamic>)),
              ),
            ).toList()
          : [],
      tags: Map<String, List<String>>.from(
          ((map['tags'] ?? {}) as Map<dynamic, dynamic>).map((key, value) {
        return MapEntry<String, List<String>>(
            key as String, List<String>.from(value as List<dynamic>));
      })),
      resource: AssetsImage.fromMap(
          Map.from((map['resource'] ?? {}) as Map<dynamic, dynamic>)),
      text: map['text'],
      freq: map['freq'] ?? 0,
      type: map['type'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Picto.fromJson(String source) =>
      Picto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Picto(block: $block, id: $id, relations: $relations, text: $text, resource: $resource, freq: $freq, tags: $tags, type: $type)';
  }

  @override
  bool operator ==(covariant Picto other) {
    if (identical(this, other)) return true;

    return other.block == block &&
        other.id == id &&
        listEquals(other.relations, relations) &&
        other.text == text &&
        other.resource == resource &&
        other.freq == freq &&
        mapEquals(other.tags, tags) &&
        other.type == type;
  }

  @override
  int get hashCode {
    return block.hashCode ^
        id.hashCode ^
        relations.hashCode ^
        text.hashCode ^
        resource.hashCode ^
        freq.hashCode ^
        tags.hashCode ^
        type.hashCode;
  }
}

@HiveType(typeId: HiveTypesIds.pictoTextTypeId)
class PictoRelation {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final double value;

  const PictoRelation({
    required this.id,
    required this.value,
  });

  PictoRelation copyWith({
    String? id,
    double? value,
  }) {
    return PictoRelation(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
    };
  }

  factory PictoRelation.fromMap(Map<String, dynamic> map) {
    return PictoRelation(
      id: map['id'] as String,
      value: ((map['value'] ?? 0) as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PictoRelation.fromJson(String source) =>
      PictoRelation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PictoRelation(id: $id, value: $value)';

  @override
  bool operator ==(covariant PictoRelation other) {
    if (identical(this, other)) return true;

    return other.id == id && other.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ value.hashCode;
}
