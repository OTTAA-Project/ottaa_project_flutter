// To parse this JSON data, do
//
//     final sentence = sentenceFromJson(jsonString);

import 'dart:convert';

Sentence sentenceFromJson(String str) => Sentence.fromJson(json.decode(str));

String sentenceToJson(Sentence data) => json.encode(data.toJson());

class Sentence {
  Sentence({
    required this.frase,
    required this.frecuencia,
    required this.complejidad,
    required this.fecha,
    required this.locale,
    required this.id,
  });

  final String frase;
  final int frecuencia;
  final Complejidad complejidad;
  final List<int> fecha;
  final String locale;
  final int id;

  factory Sentence.fromJson(Map<String, dynamic> json) => Sentence(
        frase: json["frase"],
        frecuencia: json["frecuencia"],
        complejidad: Complejidad.fromJson(json["complejidad"]),
        fecha: List<int>.from(json["fecha"].map((x) => x)),
        locale: json["locale"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "frase": frase,
        "frecuencia": frecuencia,
        "complejidad": complejidad.toJson(),
        "fecha": List<dynamic>.from(fecha.map((x) => x)),
        "locale": locale,
        "id": id,
      };
}

class Complejidad {
  Complejidad({
    required this.valor,
    required this.pictosComponentes,
  });

  final int valor;
  final List<PictosComponente> pictosComponentes;

  factory Complejidad.fromJson(Map<String, dynamic> json) => Complejidad(
        valor: json["valor"],
        pictosComponentes: List<PictosComponente>.from(
            json["pictos componentes"]
                .map((x) => PictosComponente.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "valor": valor,
        "pictos componentes":
            List<dynamic>.from(pictosComponentes.map((x) => x.toJson())),
      };
}

class PictosComponente {
  PictosComponente({
    required this.id,
    required this.esSugerencia,
    this.hora,
    this.sexo,
    this.edad,
  });

  final int id;
  final bool esSugerencia;
  final List<String>? hora;
  final List<String>? sexo;
  final List<String>? edad;

  factory PictosComponente.fromJson(Map<String, dynamic> json) =>
      PictosComponente(
        id: json["id"],
        esSugerencia: json["esSugerencia"],
        hora: json["hora"] == null
            ? null
            : List<String>.from(json["hora"].map((x) => x)),
        sexo: json["sexo"] == null
            ? null
            : List<String>.from(json["sexo"].map((x) => x)),
        edad: json["edad"] == null
            ? null
            : List<String>.from(json["edad"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "esSugerencia": esSugerencia,
        "hora": hora == null ? null : List<String>.from(hora!.map((x) => x)),
        "sexo": sexo == null ? null : List<String>.from(sexo!.map((x) => x)),
        "edad": edad == null ? null : List<String>.from(edad!.map((x) => x)),
      };
}
