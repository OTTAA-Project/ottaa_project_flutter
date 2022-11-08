import 'package:json_annotation/json_annotation.dart';

part 'groups_model.g.dart';

@JsonSerializable()
class Groups {
  Groups({
    required this.id,
    required this.texto,
    this.tipo = 0,
    required this.imagen,
    required this.relacion,
    this.frecuencia,
    this.tags,
  });

  int id;
  TextGroups texto;
  int tipo;
  ImageGroups imagen;
  List<GroupRelation> relacion;
  int? frecuencia;
  List<String>? tags;

  factory Groups.fromJson(Map<String, dynamic> json) => _$GruposFromJson(json);

  Map<String, dynamic> toJson() => _$GruposToJson(this);
}

@JsonSerializable()
class ImageGroups {
  ImageGroups({
    required this.picto,
    this.pictoEditado,
    this.urlFoto,
    this.pushKey,
  });

  String picto;
  String? pictoEditado;
  String? urlFoto;
  String? pushKey;

  factory ImageGroups.fromJson(Map<String, dynamic> json) => _$ImagenGruposFromJson(json);

  Map<String, dynamic> toJson() => _$ImagenGruposToJson(this);
}

@JsonSerializable()
class GroupRelation {
  GroupRelation({
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
  TextGroups? texto;
  int? tipo;
  ImageGroups? imagen;
  List<RelationRelation>? relacion;
  int? agenda;
  int? gps;
  bool? esSugerencia;
  List<String>? edad;
  List<String>? horario;

  factory GroupRelation.fromJson(Map<String, dynamic> json) => _$GrupoRelacionFromJson(json);

  Map<String, dynamic> toJson() => _$GrupoRelacionToJson(this);
}

@JsonSerializable()
class RelationRelation {
  RelationRelation({
    required this.id,
    required this.frec,
  });

  int id;
  int frec;

  factory RelationRelation.fromJson(Map<String, dynamic> json) => _$RelacionRelacionFromJson(json);

  Map<String, dynamic> toJson() => _$RelacionRelacionToJson(this);
}

@JsonSerializable()
class TextGroups {
  TextGroups({
    this.en = '',
    this.es = '',
    this.fr = '',
    this.pt = '',
  });

  String en;
  String es;
  String fr;
  String pt;

  factory TextGroups.fromJson(Map<String, dynamic> json) => _$TextoGruposFromJson(json);

  Map<String, dynamic> toJson() => _$TextoGruposToJson(this);
}
