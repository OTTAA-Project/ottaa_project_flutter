import 'package:json_annotation/json_annotation.dart';

part 'frases_statistics_model.g.dart';

@JsonSerializable()
class FrasesStatisticsModel {
  FrasesStatisticsModel({
    required this.totalFrases,
    required this.frases7Days,
    required this.averagePictoFrase,
    required this.frecLast7Days,
  });

  int totalFrases;
  @JsonKey(nullable: true, defaultValue: 000, name: 'frases7days')
  int frases7Days;
  @JsonKey(name: 'averagePictoFrase')
  double averagePictoFrase;
  @JsonKey(name: 'frecLast7days')
  Map<String, int> frecLast7Days;

  factory FrasesStatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$FrasesStatisticsModelFromJson(json);

  Map<String, dynamic> toJson() => _$FrasesStatisticsModelToJson(this);
}
