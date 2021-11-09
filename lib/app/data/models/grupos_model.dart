import 'package:json_annotation/json_annotation.dart';
part 'grupos_model.g.dart';
@JsonSerializable()
class Grupos {
  Grupos({
    required this.id,
    required this.texto,
    required this.tipo,
    required this.imagen,
    required this.relacion,
    this.frecuencia,
    this.tags,
  });

  final int id;
  final Texto texto;
  final int tipo;
  final Imagen imagen;
  final List<GrupoRelacion> relacion;
  final int? frecuencia;
  final List<String>? tags;

  factory Grupos.fromJson(Map<String, dynamic> json) => _$GruposFromJson(json);
  Map<String, dynamic> toJson() => _$GruposToJson(this);
}
@JsonSerializable()
class Imagen {
  Imagen({
    required this.picto,
    this.pictoEditado,
    this.urlFoto,
    this.pushKey,
  });

  final String picto;
  final String? pictoEditado;
  final String? urlFoto;
  final String? pushKey;
  factory Imagen.fromJson(Map<String, dynamic> json) => _$ImagenFromJson(json);
  Map<String, dynamic> toJson() => _$ImagenToJson(this);
}
@JsonSerializable()
class GrupoRelacion {
  GrupoRelacion({
    required this.id,
    this.frec,
    this.texto,
    this.tipo,
    this.imagen,
    this.relacion,
    this.agenda,
    this.gps,
    this.esSugerencia,
    this.edad,
    this.horario,
  });

  final int id;
  final int? frec;
  final Texto? texto;
  final int? tipo;
  final Imagen? imagen;
  final List<RelacionRelacion>? relacion;
  final int? agenda;
  final int? gps;
  final bool? esSugerencia;
  final List<String>? edad;
  final List<String>? horario;
  factory GrupoRelacion.fromJson(Map<String, dynamic> json) => _$GrupoRelacionFromJson(json);
  Map<String, dynamic> toJson() => _$GrupoRelacionToJson(this);
}

@JsonSerializable()
class RelacionRelacion {
  RelacionRelacion({
    required this.id,
    required this.frec,
  });

  final int id;
  final int frec;
  factory RelacionRelacion.fromJson(Map<String, dynamic> json) => _$RelacionRelacionFromJson(json);
  Map<String, dynamic> toJson() => _$RelacionRelacionToJson(this);
}
@JsonSerializable()
class Texto {
  Texto({
    required this.en,
    required this.es,
  });

  final String en;
  final String es;
  factory Texto.fromJson(Map<String, dynamic> json) => _$TextoFromJson(json);
  Map<String, dynamic> toJson() => _$TextoToJson(this);
}
