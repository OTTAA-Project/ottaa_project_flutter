// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frases_statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FrasesStatisticsModel _$FrasesStatisticsModelFromJson(
        Map<String, dynamic> json) =>
    FrasesStatisticsModel(
      totalFrases: json['totalFrases'] as int,
      frases7Days: json['frases7days'] as int? ?? 0,
      averagePictoFrase: (json['averagePictoFrase'] as num?)?.toDouble() ?? 0.0,
      frecLast7Days: Map<String, int>.from(json['frecLast7days'] as Map),
    );

Map<String, dynamic> _$FrasesStatisticsModelToJson(
        FrasesStatisticsModel instance) =>
    <String, dynamic>{
      'totalFrases': instance.totalFrases,
      'frases7days': instance.frases7Days,
      'averagePictoFrase': instance.averagePictoFrase,
      'frecLast7days': instance.frecLast7Days,
    };
