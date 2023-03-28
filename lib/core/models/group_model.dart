import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';

part 'group_model.g.dart';

typedef GroupText = Map<String, String>;

@HiveType(typeId: HiveTypesIds.groupTypeId)
class Group {
  @HiveField(0, defaultValue: false)
  bool block;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final List<GroupRelation> relations;
  @HiveField(3)
  final String text;

  @HiveField(4)
  final AssetsImage resource;

  @HiveField(5)
  final int freq;

  Group({
    this.block = false,
    required this.id,
    required this.relations,
    required this.text,
    required this.resource,
    required this.freq,
  });

  Group copyWith({
    bool? block,
    String? id,
    List<GroupRelation>? relations,
    String? text,
    AssetsImage? resource,
    int? freq,
  }) {
    return Group(
      block: block ?? this.block,
      id: id ?? this.id,
      relations: relations ?? this.relations,
      text: text ?? this.text,
      resource: resource ?? this.resource,
      freq: freq ?? this.freq,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'block': block,
      'id': id,
      'relations': relations.map((x) => x.toMap()).toList(),
      'text': text,
      'resource': resource.toMap(),
      'freq': freq,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      block: map['block'] != null ? map['block'] as bool : false,
      id: map['id'] as String,
      relations: map['relations'] != null
          ? List<GroupRelation>.from(
              (map['relations'] as List).map(
                (k) => GroupRelation.fromMap(Map.from(k as Map<dynamic, dynamic>)),
              ),
            ).toList()
          : [],
      text: map['text'],
      resource: AssetsImage.fromMap(map['resource'] != null ? Map.from(map['resource'] as Map<dynamic, dynamic>) : {}),
      freq: map['freq'] != null ? map['freq'] as int : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Group.fromJson(String source) => Group.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Group(block: $block, id: $id, relations: $relations, text: $text, resource: $resource, freq: $freq)';
  }

  @override
  bool operator ==(covariant Group other) {
    if (identical(this, other)) return true;

    return other.block == block && other.id == id && listEquals(other.relations, relations) && other.text == text && other.resource == resource && other.freq == freq;
  }

  @override
  int get hashCode {
    return block.hashCode ^ id.hashCode ^ relations.hashCode ^ text.hashCode ^ resource.hashCode ^ freq.hashCode;
  }
}

@HiveType(typeId: HiveTypesIds.groupRelationTypeId)
class GroupRelation {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final double value;

  const GroupRelation({
    required this.id,
    required this.value,
  });

  GroupRelation copyWith({
    String? id,
    double? value,
  }) {
    return GroupRelation(
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

  factory GroupRelation.fromMap(Map<String, dynamic> map) {
    return GroupRelation(
      id: map['id'] as String,
      value: (map['value'] as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupRelation.fromJson(String source) => GroupRelation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GroupRelation(id: $id, value: $value)';

  @override
  bool operator ==(covariant GroupRelation other) {
    if (identical(this, other)) return true;

    return other.id == id && other.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ value.hashCode;
}
