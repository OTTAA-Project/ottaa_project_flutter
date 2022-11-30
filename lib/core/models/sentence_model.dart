// To parse this JSON data, do
//
//     final sentence = sentenceFromJson(jsonString);

import 'dart:convert';

SentenceModel sentenceFromJson(String str) => SentenceModel.fromJson(json.decode(str));

String sentenceToJson(SentenceModel data) => json.encode(data.toJson());

class SentenceModel {
  SentenceModel({
    required this.frase,
    required this.frecuencia,
    required this.complejidad,
    required this.fecha,
    required this.locale,
    required this.id,
    this.favouriteOrNot = false,
  });

  final String frase;
  int frecuencia;
  final Complejidad complejidad;
  List<int> fecha;
  final String locale;
  final int id;
  bool favouriteOrNot;

  factory SentenceModel.fromJson(Map<String, dynamic> json) {
    late List<int> fecha;
    if (json["fecha"].runtimeType == int) {
      fecha = List.empty(growable: true);
      fecha.add(json["fecha"]);
    } else {
      fecha = List.empty(growable: true);
      fecha = List<int>.from(json["fecha"].map((x) => x));
    }
    return SentenceModel(
      frase: json["frase"],
      frecuencia: json["frecuencia"],
      complejidad: Complejidad.fromJson(json["complejidad"]),
      // fecha: json["fecha"] is int
      //     ? json["fecha"]
      //     : List<int>.from(json["fecha"].map((x) => x)),
      fecha: fecha,
      locale: json["locale"],
      id: json["id"],
      favouriteOrNot:
      json['favouriteOrNot'] == null ? false : json['favouriteOrNot'],
    );
  }

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
        esSugerencia: json["esSugerencia"] ?? false,
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
