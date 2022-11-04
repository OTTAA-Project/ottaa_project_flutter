// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameData _$GameDataFromJson(Map<String, dynamic> json) => GameData(
      game: json['game'] as int,
      levelId: json['levelId'] as int,
      bestStreak: json['bestStreak'] as int,
      score: Score.fromJson(json['score'] as Map<String, dynamic>),
      reloj: (json['reloj'] as List<dynamic>?)
          ?.map((e) => RelojElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      timeUse: json['timeUse'] as int,
    );

Map<String, dynamic> _$GameDataToJson(GameData instance) => <String, dynamic>{
      'game': instance.game,
      'levelId': instance.levelId,
      'bestStreak': instance.bestStreak,
      'score': instance.score,
      'reloj': instance.reloj,
      'timeUse': instance.timeUse,
    };

Score _$ScoreFromJson(Map<String, dynamic> json) => Score(
      hit: json['hit'] as int,
      mistakes: json['mistakes'] as int,
      score: (json['score'] as num).toDouble(),
      tries: json['tries'] as int,
    );

Map<String, dynamic> _$ScoreToJson(Score instance) => <String, dynamic>{
      'hit': instance.hit,
      'mistakes': instance.mistakes,
      'score': instance.score,
      'tries': instance.tries,
    };

RelojElement _$RelojElementFromJson(Map<String, dynamic> json) => RelojElement(
      startTime: json['startTime'] as int,
      endTime: json['endTime'] as int,
      useTime: json['useTime'] as int,
    );

Map<String, dynamic> _$RelojElementToJson(RelojElement instance) =>
    <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'useTime': instance.useTime,
    };
