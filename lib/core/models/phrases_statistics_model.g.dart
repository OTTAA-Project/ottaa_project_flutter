// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phrases_statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhraseStatisticModel _$PhraseStatisticModelFromJson(
        Map<String, dynamic> json) =>
    PhraseStatisticModel(
      totalFrases: json['totalFrases'] as int,
      frases7Days: json['frases7days'] as int? ?? 0,
      averagePictoFrase: (json['averagePictoFrase'] as num?)?.toDouble() ?? 0.0,
      frecLast7Days: Map<String, int>.from(json['frecLast7days'] as Map),
    );

Map<String, dynamic> _$PhraseStatisticModelToJson(
        PhraseStatisticModel instance) =>
    <String, dynamic>{
      'totalFrases': instance.totalFrases,
      'frases7days': instance.frases7Days,
      'averagePictoFrase': instance.averagePictoFrase,
      'frecLast7days': instance.frecLast7Days,
    };
