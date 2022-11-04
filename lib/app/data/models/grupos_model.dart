import 'package:json_annotation/json_annotation.dart';

part 'grupos_model.g.dart';

@JsonSerializable()
class Grupos {
  Grupos({
    required this.id,
    required this.texto,
    this.tipo = 0,
    required this.imagen,
    required this.relacion,
    this.frecuencia,
    this.tags,
  });

  int id;
  TextoGrupos texto;
  int tipo;
  ImagenGrupos imagen;
  @JsonKey(nullable: true,includeIfNull: true,defaultValue: [])
  List<GrupoRelacion> relacion;
  int? frecuencia;
  List<String>? tags;

  factory Grupos.fromJson(Map<String, dynamic> json) => _$GruposFromJson(json);

  Map<String, dynamic> toJson() => _$GruposToJson(this);
}

@JsonSerializable()
class ImagenGrupos {
  ImagenGrupos({
    required this.picto,
    this.pictoEditado,
    this.urlFoto,
    this.pushKey,
  });

  String picto;
  String? pictoEditado;
  String? urlFoto;
  String? pushKey;

  factory ImagenGrupos.fromJson(Map<String, dynamic> json) =>
      _$ImagenGruposFromJson(json);

  Map<String, dynamic> toJson() => _$ImagenGruposToJson(this);
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

  int id;
  int? frec;
  TextoGrupos? texto;
  int? tipo;
  ImagenGrupos? imagen;
  List<RelacionRelacion>? relacion;
  int? agenda;
  int? gps;
  bool? esSugerencia;
  List<String>? edad;
  List<String>? horario;

  factory GrupoRelacion.fromJson(Map<String, dynamic> json) =>
      _$GrupoRelacionFromJson(json);

  Map<String, dynamic> toJson() => _$GrupoRelacionToJson(this);
}

@JsonSerializable()
class RelacionRelacion {
  RelacionRelacion({
    required this.id,
    required this.frec,
  });

  int id;
  int frec;

  factory RelacionRelacion.fromJson(Map<String, dynamic> json) =>
      _$RelacionRelacionFromJson(json);

  Map<String, dynamic> toJson() => _$RelacionRelacionToJson(this);
}

@JsonSerializable()
class TextoGrupos {
  TextoGrupos({
    this.en = '',
    this.es = '',
    this.fr = '',
    this.pt = '',
  });

  String en;
  String es;
  String fr;
  String pt;

  factory TextoGrupos.fromJson(Map<String, dynamic> json) =>
      _$TextoGruposFromJson(json);

  Map<String, dynamic> toJson() => _$TextoGruposToJson(this);
}
