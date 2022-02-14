import 'package:json_annotation/json_annotation.dart';

part 'pict_model.g.dart';

@JsonSerializable()
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
    this.edad,
    this.horario,
    this.hora,
    this.localImg = false,
    this.sexo,
    this.ubicacion,
  });

  int id;
  Texto texto;
  int tipo;
  Imagen imagen;
  List<Relacion>? relacion;
  int? agenda;
  int? gps;
  List<String>? hora;
  List<String>? edad;
  List<String>? sexo;
  bool? esSugerencia;
  List<String>? horario;
  List<String>? ubicacion;

  //local used variables
  bool localImg;

  factory Pict.fromJson(Map<String, dynamic> json) => _$PictFromJson(json);

  Map<String, dynamic> toJson() => _$PictToJson(this);
}

@JsonSerializable()
class Imagen {
  Imagen({
    required this.picto,
    this.pictoEditado,
    this.urlFoto,
    this.pushKey,
  });

  String picto;
  String? pictoEditado;
  String? urlFoto;
  String? pushKey;
  factory Imagen.fromJson(Map<String, dynamic> json) => _$ImagenFromJson(json);

  Map<String, dynamic> toJson() => _$ImagenToJson(this);
}

@JsonSerializable()
class Relacion {
  Relacion({
    required this.id,
    required this.frec,
  });

  int id;
  int frec;

  factory Relacion.fromJson(Map<String, dynamic> json) =>
      _$RelacionFromJson(json);

  Map<String, dynamic> toJson() => _$RelacionToJson(this);
}

@JsonSerializable()
class Texto {
  Texto({
    required this.en,
    required this.es,
  });

  String en;
  String es;

  factory Texto.fromJson(Map<String, dynamic> json) => _$TextoFromJson(json);

  Map<String, dynamic> toJson() => _$TextoToJson(this);
}
