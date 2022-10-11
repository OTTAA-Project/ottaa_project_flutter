// To parse this JSON data, do
//
//     final pict = pictFromJson(jsonString);

import 'dart:convert';

Pict pictFromJson(String str) => Pict.fromJson(json.decode(str));

String pictToJson(Pict data) => json.encode(data.toJson());

class Pict {
  Pict({
    required this.id,
    required this.texto,
    required this.tipo,
    required this.imagen,
    this.relacion,
    this.agenda = 0,
    this.gps = 0,
    this.esSugerencia = false,
  });

  final int id;
  final Texto texto;
  final int tipo;
  final Imagen imagen;
  final List<Relacion>? relacion;
  final int? agenda;
  final int? gps;
  final bool? esSugerencia;

  factory Pict.fromJson(Map<String, dynamic> json) => Pict(
        id: json["id"],
        texto: Texto.fromJson(json["texto"]),
        tipo: json["tipo"],
        imagen: Imagen.fromJson(json["imagen"]),
        relacion: List<Relacion>.from(
            json["relacion"].map((x) => Relacion.fromJson(x))),
        agenda: json["agenda"],
        gps: json["gps"],
        esSugerencia: json["esSugerencia"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "texto": texto.toJson(),
        "tipo": tipo,
        "imagen": imagen.toJson(),
        "relacion": List<dynamic>.from(relacion!.map((x) => x.toJson())),
        "agenda": agenda,
        "gps": gps,
        "esSugerencia": esSugerencia,
      };
  @override
  String toString() {
    return "$id - $texto";
  }
}

class Imagen {
  Imagen({
    required this.picto,
  });

  final String picto;

  factory Imagen.fromJson(Map<String, dynamic> json) => Imagen(
        picto: json["picto"],
      );

  Map<String, dynamic> toJson() => {
        "picto": picto,
      };
}

class Relacion {
  Relacion({
    required this.id,
    required this.frec,
  });

  final int id;
  final int frec;

  factory Relacion.fromJson(Map<String, dynamic> json) => Relacion(
        id: json["id"],
        frec: json["frec"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "frec": frec,
      };
}

class Texto {
  Texto({
    required this.en,
    required this.es,
  });

  final String en;
  final String es;

  factory Texto.fromJson(Map<String, dynamic> json) => Texto(
        en: json["en"],
        es: json["es"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "es": es,
      };
}
