// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';

part 'picto_model.g.dart';

typedef PictoText = Map<String, String>;

@HiveType(typeId: HiveTypesIds.pictoTypeId)
class Picto {
  @HiveField(0, defaultValue: false)
  bool block;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final List<PictoRelation> relations;
  @HiveField(3, defaultValue: <String, String>{})
  PictoText text;

  @HiveField(4)
  AssetsImage resource;

  @HiveField(5)
  int freq;

  @HiveField(6, defaultValue: <String, List<String>>{})
  Map<String, List<String>> tags;

  @HiveField(7)
  int type;

  Picto({
    required this.id,
    required this.type,
    required this.resource,
    this.text = const <String, String>{},
    this.freq = 0,
    this.block = false,
    this.relations = const [],
    this.tags = const <String, List<String>>{},
  });

  Picto copyWith({
    bool? block,
    int? id,
    List<PictoRelation>? relations,
    PictoText? text,
    AssetsImage? resource,
    int? freq,
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
      block: map['block'] as bool,
      id: map['id'] as int,
      relations: List<PictoRelation>.from(
        (map['relations'] as List<int>).map<PictoRelation>(
          (x) => PictoRelation.fromMap(x as Map<String, dynamic>),
        ),
      ),
      text: (map['text'] as Map<String, String>),
      resource: AssetsImage.fromMap(map['resource'] as Map<String, dynamic>),
      freq: map['freq'] as int,
      tags: Map<String, List<String>>.from((map['tags'] as Map<String, List<String>>)),
      type: map['type'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Picto.fromJson(String source) => Picto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Picto(block: $block, id: $id, relations: $relations, text: $text, resource: $resource, freq: $freq, tags: $tags, type: $type)';
  }

  @override
  bool operator ==(covariant Picto other) {
    if (identical(this, other)) return true;

    return other.block == block && other.id == id && listEquals(other.relations, relations) && other.text == text && other.resource == resource && other.freq == freq && mapEquals(other.tags, tags) && other.type == type;
  }

  @override
  int get hashCode {
    return block.hashCode ^ id.hashCode ^ relations.hashCode ^ text.hashCode ^ resource.hashCode ^ freq.hashCode ^ tags.hashCode ^ type.hashCode;
  }
}

@HiveType(typeId: HiveTypesIds.pictoTextTypeId)
class PictoRelation {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final double value;

  const PictoRelation({
    required this.id,
    required this.value,
  });

  PictoRelation copyWith({
    int? id,
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
      id: map['id'] as int,
      value: map['value'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory PictoRelation.fromJson(String source) => PictoRelation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GroupRelation(id: $id, value: $value)';

  @override
  bool operator ==(covariant PictoRelation other) {
    if (identical(this, other)) return true;

    return other.id == id && other.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ value.hashCode;
}