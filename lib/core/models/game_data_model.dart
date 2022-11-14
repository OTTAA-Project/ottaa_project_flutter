import 'package:json_annotation/json_annotation.dart';

part 'game_data_model.g.dart';

@JsonSerializable()
class GameData {
  GameData({
    required this.game,
    required this.levelId,
    required this.bestStreak,
    required this.score,
    this.reloj,
    required this.timeUse,
  });

  int game;
  int levelId;
  int bestStreak;
  Score score;
  List<RelojElement>? reloj;
  int timeUse;

  factory GameData.fromJson(Map<String, dynamic> json) => _$GameDataFromJson(json);

  Map<String, dynamic> toJson() => _$GameDataToJson(this);
}

@JsonSerializable()
class Score {
  Score({
    required this.hit,
    required this.mistakes,
    required this.score,
    required this.tries,
  });

  int hit;
  int mistakes;
  double score;
  int tries;

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreToJson(this);
}

@JsonSerializable()
class RelojElement {
  RelojElement({
    required this.startTime,
    required this.endTime,
    required this.useTime,
  });

  int startTime;
  int endTime;
  int useTime;

  factory RelojElement.fromJson(Map<String, dynamic> json) => _$RelojElementFromJson(json);

  Map<String, dynamic> toJson() => _$RelojElementToJson(this);
}
