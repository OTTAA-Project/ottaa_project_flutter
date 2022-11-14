// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picto_statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PictoStatisticsModel _$PictoStatisticsModelFromJson(
        Map<String, dynamic> json) =>
    PictoStatisticsModel(
      mostUsedSentences: (json['most_used_sentences'] as List<dynamic>)
          .map((e) => MostUsedSentence.fromJson(e as Map<String, dynamic>))
          .toList(),
      pictoUsagePerGroup: (json['picto_usage_per_group'] as List<dynamic>)
          .map((e) => PictoUsagePerGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PictoStatisticsModelToJson(
        PictoStatisticsModel instance) =>
    <String, dynamic>{
      'most_used_sentences': instance.mostUsedSentences,
      'picto_usage_per_group': instance.pictoUsagePerGroup,
    };

MostUsedSentence _$MostUsedSentenceFromJson(Map<String, dynamic> json) =>
    MostUsedSentence(
      frec: json['frec'] as int,
      pictoComponentes: (json['picto_componentes'] as List<dynamic>)
          .map((e) => PictoComponente.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MostUsedSentenceToJson(MostUsedSentence instance) =>
    <String, dynamic>{
      'frec': instance.frec,
      'picto_componentes': instance.pictoComponentes,
    };

PictoComponente _$PictoComponenteFromJson(Map<String, dynamic> json) =>
    PictoComponente(
      id: json['id'] as int,
      esSugerencia: json['esSugerencia'] as bool,
      hora:
          (json['hora'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      sexo:
          (json['sexo'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      edad:
          (json['edad'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
    );

Map<String, dynamic> _$PictoComponenteToJson(PictoComponente instance) =>
    <String, dynamic>{
      'id': instance.id,
      'esSugerencia': instance.esSugerencia,
      'hora': instance.hora,
      'sexo': instance.sexo,
      'edad': instance.edad,
    };

PictoUsagePerGroup _$PictoUsagePerGroupFromJson(Map<String, dynamic> json) =>
    PictoUsagePerGroup(
      groupId: json['groupId'] as int? ?? 0,
      percentage: (json['percentage'] as num).toDouble(),
      name: Name.fromJson(json['name'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PictoUsagePerGroupToJson(PictoUsagePerGroup instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'percentage': instance.percentage,
      'name': instance.name,
    };

Name _$NameFromJson(Map<String, dynamic> json) => Name(
      en: json['en'] as String,
      es: json['es'] as String,
      fr: json['fr'] as String,
      pt: json['pt'] as String,
    );

Map<String, dynamic> _$NameToJson(Name instance) => <String, dynamic>{
      'en': instance.en,
      'es': instance.es,
      'fr': instance.fr,
      'pt': instance.pt,
    };
