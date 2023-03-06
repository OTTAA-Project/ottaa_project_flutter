import 'package:json_annotation/json_annotation.dart';

part 'phrases_statistics_model.g.dart';

@JsonSerializable()
class PhraseStatisticModel {
  PhraseStatisticModel({
    required this.totalFrases,
    required this.frases7Days,
    required this.averagePictoFrase,
    required this.frecLast7Days,
  });

  int totalFrases;
  @JsonKey(nullable: true, defaultValue: 000, name: 'frases7days')
  int frases7Days;
  @JsonKey(name: 'averagePictoFrase', defaultValue: 0.00, nullable: true)
  double averagePictoFrase;
  @JsonKey(name: 'frecLast7days')
  Map<String, int> frecLast7Days;

  factory PhraseStatisticModel.fromJson(Map<String, dynamic> json) => _$PhraseStatisticModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhraseStatisticModelToJson(this);
}