// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groups_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Groups _$GroupsFromJson(Map<String, dynamic> json) => Groups(
      id: json['id'] as int,
      texto: TextGroups.fromJson(json['texto'] as Map<String, dynamic>),
      tipo: json['tipo'] as int? ?? 0,
      imagen: ImageGroups.fromJson(json['imagen'] as Map<String, dynamic>),
      relacion: (json['relacion'] as List<dynamic>)
          .map((e) => GroupRelation.fromJson(e as Map<String, dynamic>))
          .toList(),
      frecuencia: json['frecuencia'] as int?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GroupsToJson(Groups instance) => <String, dynamic>{
      'id': instance.id,
      'texto': instance.texto,
      'tipo': instance.tipo,
      'imagen': instance.imagen,
      'relacion': instance.relacion,
      'frecuencia': instance.frecuencia,
      'tags': instance.tags,
    };

ImageGroups _$ImageGroupsFromJson(Map<String, dynamic> json) => ImageGroups(
      picto: json['picto'] as String,
      pictoEditado: json['pictoEditado'] as String?,
      urlFoto: json['urlFoto'] as String?,
      pushKey: json['pushKey'] as String?,
    );

Map<String, dynamic> _$ImageGroupsToJson(ImageGroups instance) =>
    <String, dynamic>{
      'picto': instance.picto,
      'pictoEditado': instance.pictoEditado,
      'urlFoto': instance.urlFoto,
      'pushKey': instance.pushKey,
    };

GroupRelation _$GroupRelationFromJson(Map<String, dynamic> json) =>
    GroupRelation(
      id: json['id'] as int,
      frec: json['frec'] as int?,
      texto: json['texto'] == null
          ? null
          : TextGroups.fromJson(json['texto'] as Map<String, dynamic>),
      tipo: json['tipo'] as int?,
      imagen: json['imagen'] == null
          ? null
          : ImageGroups.fromJson(json['imagen'] as Map<String, dynamic>),
      relacion: (json['relacion'] as List<dynamic>?)
          ?.map((e) => RelationRelation.fromJson(e as Map<String, dynamic>))
          .toList(),
      agenda: json['agenda'] as int?,
      gps: json['gps'] as int?,
      esSugerencia: json['esSugerencia'] as bool?,
      edad: (json['edad'] as List<dynamic>?)?.map((e) => e as String).toList(),
      horario:
          (json['horario'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GroupRelationToJson(GroupRelation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'frec': instance.frec,
      'texto': instance.texto,
      'tipo': instance.tipo,
      'imagen': instance.imagen,
      'relacion': instance.relacion,
      'agenda': instance.agenda,
      'gps': instance.gps,
      'esSugerencia': instance.esSugerencia,
      'edad': instance.edad,
      'horario': instance.horario,
    };

RelationRelation _$RelationRelationFromJson(Map<String, dynamic> json) =>
    RelationRelation(
      id: json['id'] as int,
      frec: json['frec'] as int,
    );

Map<String, dynamic> _$RelationRelationToJson(RelationRelation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'frec': instance.frec,
    };

TextGroups _$TextGroupsFromJson(Map<String, dynamic> json) => TextGroups(
      en: json['en'] as String? ?? '',
      es: json['es'] as String? ?? '',
      fr: json['fr'] as String? ?? '',
      pt: json['pt'] as String? ?? '',
    );

Map<String, dynamic> _$TextGroupsToJson(TextGroups instance) =>
    <String, dynamic>{
      'en': instance.en,
      'es': instance.es,
      'fr': instance.fr,
      'pt': instance.pt,
    };
