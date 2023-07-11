// coverage:ignore-file
import 'package:json_annotation/json_annotation.dart';

part 'picto_statistics_model.g.dart';

@JsonSerializable()
class PictoStatisticsModel {
  PictoStatisticsModel({
    required this.mostUsedSentences,
    required this.pictoUsagePerGroup,
  });
  @JsonKey(name: 'most_used_sentences')
  List<MostUsedSentence> mostUsedSentences;
  @JsonKey(name: 'picto_usage_per_group')
  List<PictoUsagePerGroup> pictoUsagePerGroup;

  factory PictoStatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$PictoStatisticsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PictoStatisticsModelToJson(this);
}

@JsonSerializable()
class MostUsedSentence {
  MostUsedSentence({
    required this.frec,
    required this.pictoComponentes,
  });

  int frec;
  @JsonKey(name: 'picto_componentes')
  List<PictoComponente> pictoComponentes;

  factory MostUsedSentence.fromJson(Map<String, dynamic> json) =>
      _$MostUsedSentenceFromJson(json);

  Map<String, dynamic> toJson() => _$MostUsedSentenceToJson(this);
}

@JsonSerializable()
class PictoComponente {
  PictoComponente({
    required this.id,
    required this.esSugerencia,
    required this.hora,
    required this.sexo,
    required this.edad,
  });

  String id;
  bool esSugerencia;
  @JsonKey(nullable: true, defaultValue: [], name: 'hora')
  List<String> hora;
  @JsonKey(nullable: true, defaultValue: [], name: 'sexo')
  List<String> sexo;
  @JsonKey(nullable: true, defaultValue: [], name: 'edad')
  List<String> edad;
  factory PictoComponente.fromJson(Map<String, dynamic> json) =>
      _$PictoComponenteFromJson(json);

  Map<String, dynamic> toJson() => _$PictoComponenteToJson(this);
}

@JsonSerializable()
class PictoUsagePerGroup {
  PictoUsagePerGroup({
    required this.groupId,
    required this.percentage,
    required this.name,
  });
  @JsonKey(nullable: true, defaultValue: 000, name: 'groupId')
  int groupId;
  double percentage;
  Name name;
  factory PictoUsagePerGroup.fromJson(Map<String, dynamic> json) =>
      _$PictoUsagePerGroupFromJson(json);

  Map<String, dynamic> toJson() => _$PictoUsagePerGroupToJson(this);
}

@JsonSerializable()
class Name {
  Name({
    required this.en,
    required this.es,
    required this.fr,
    required this.pt,
  });

  String en;
  String es;
  String fr;
  String pt;
  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);

  Map<String, dynamic> toJson() => _$NameToJson(this);
}
