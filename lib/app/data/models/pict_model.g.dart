// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pict_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pict _$PictFromJson(Map<String, dynamic> json) => Pict(
      id: json['id'] as int,
      texto: Texto.fromJson(json['texto'] as Map<String, dynamic>),
      tipo: json['tipo'] as int,
      imagen: Imagen.fromJson(json['imagen'] as Map<String, dynamic>),
      relacion: (json['relacion'] as List<dynamic>?)
          ?.map((e) => Relacion.fromJson(e as Map<String, dynamic>))
          .toList(),
      agenda: json['agenda'] as int? ?? 0,
      gps: json['gps'] as int? ?? 0,
      esSugerencia: json['esSugerencia'] as bool? ?? false,
      edad: (json['edad'] as List<dynamic>?)?.map((e) => e as String).toList(),
      horario:
          (json['horario'] as List<dynamic>?)?.map((e) => e as String).toList(),
      hora: (json['hora'] as List<dynamic>?)?.map((e) => e as String).toList(),
      localImg: json['localImg'] as bool? ?? false,
      sexo: (json['sexo'] as List<dynamic>?)?.map((e) => e as String).toList(),
      ubicacion: (json['ubicacion'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      score: json['score'] as int?,
    );

Map<String, dynamic> _$PictToJson(Pict instance) => <String, dynamic>{
      'id': instance.id,
      'texto': instance.texto,
      'tipo': instance.tipo,
      'imagen': instance.imagen,
      'relacion': instance.relacion,
      'agenda': instance.agenda,
      'gps': instance.gps,
      'hora': instance.hora,
      'edad': instance.edad,
      'sexo': instance.sexo,
      'esSugerencia': instance.esSugerencia,
      'horario': instance.horario,
      'ubicacion': instance.ubicacion,
      'score': instance.score,
      'localImg': instance.localImg,
    };

Imagen _$ImagenFromJson(Map<String, dynamic> json) => Imagen(
      picto: json['picto'] as String,
      pictoEditado: json['pictoEditado'] as String?,
      urlFoto: json['urlFoto'] as String?,
      pushKey: json['pushKey'] as String?,
    );

Map<String, dynamic> _$ImagenToJson(Imagen instance) => <String, dynamic>{
      'picto': instance.picto,
      'pictoEditado': instance.pictoEditado,
      'urlFoto': instance.urlFoto,
      'pushKey': instance.pushKey,
    };

Relacion _$RelacionFromJson(Map<String, dynamic> json) => Relacion(
      id: json['id'] as int,
      frec: json['frec'] as int,
    );

Map<String, dynamic> _$RelacionToJson(Relacion instance) => <String, dynamic>{
      'id': instance.id,
      'frec': instance.frec,
    };

Texto _$TextoFromJson(Map<String, dynamic> json) => Texto(
      en: json['en'] as String,
      es: json['es'] as String,
    );

Map<String, dynamic> _$TextoToJson(Texto instance) => <String, dynamic>{
      'en': instance.en,
      'es': instance.es,
    };
