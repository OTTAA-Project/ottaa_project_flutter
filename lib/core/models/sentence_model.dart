import 'package:json_annotation/json_annotation.dart';

part 'sentence_model.g.dart';

@JsonSerializable()
class SentenceModel {
  SentenceModel({
    required this.frase,
    required this.frecuencia,
    required this.complejidad,
    required this.fecha,
    required this.locale,
    required this.id,
  });

  String frase;
  int frecuencia;
  Complex complejidad;
  List<int> fecha;
  String locale;
  int id;

  factory SentenceModel.fromJson(Map<String, dynamic> json) => _$FraseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FraseModelToJson(this);
}

@JsonSerializable()
class Complex {
  Complex({
    required this.valor,
    required this.pictosComponentes,
  });

  int valor;
  @JsonKey(name: 'pictos componentes')
  List<PictosComponente> pictosComponentes;

  factory Complex.fromJson(Map<String, dynamic> json) => _$ComplejidadFromJson(json);

  Map<String, dynamic> toJson() => _$ComplejidadToJson(this);
}

@JsonSerializable()
class PictosComponente {
  PictosComponente({
    required this.id,
    required this.esSugerencia,
    this.hora,
    required this.edad,
    required this.sexo,
  });

  int id;
  bool esSugerencia;
  List<String?>? hora;
  List<String> edad;
  List<String> sexo;

  factory PictosComponente.fromJson(Map<String, dynamic> json) => _$PictosComponenteFromJson(json);

  Map<String, dynamic> toJson() => _$PictosComponenteToJson(this);
}
