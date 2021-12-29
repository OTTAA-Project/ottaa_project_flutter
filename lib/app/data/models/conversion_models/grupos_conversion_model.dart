import 'package:json_annotation/json_annotation.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';

part 'grupos_conversion_model.g.dart';

@JsonSerializable()
class GruposConversionModel {
  final List<Grupos> gruposToConvert;

  GruposConversionModel({required this.gruposToConvert});

  factory GruposConversionModel.fromJson(Map<String, dynamic> json) =>
      _$GruposConversionModelFromJson(json);

  Map<String, dynamic> toJson() => _$GruposConversionModelToJson(this);
}
