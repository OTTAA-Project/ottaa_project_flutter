// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arsaac_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArsaacDataModel _$ArsaacDataModelFromJson(Map<String, dynamic> json) =>
    ArsaacDataModel(
      id: json['id'] as int,
      text: json['text'] as String,
      textDiacritised: json['text_diacritised'] as String?,
      description: json['description'] as String?,
      language: json['language'] as String,
      picto: SearchPicto.fromJson(json['picto'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArsaacDataModelToJson(ArsaacDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'text_diacritised': instance.textDiacritised,
      'description': instance.description,
      'language': instance.language,
      'picto': instance.picto,
    };

SearchPicto _$SearchPictoFromJson(Map<String, dynamic> json) => SearchPicto(
      id: json['id'] as int,
      symbolsetId: json['symbolset_id'] as int?,
      partOfSpeech: json['part_of_speech'] as String,
      imageUrl: json['image_url'] as String,
      nativeFormat: json['native_format'] as String,
      adaptable: json['adaptable'] as bool,
    );

Map<String, dynamic> _$SearchPictoToJson(SearchPicto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbolset_id': instance.symbolsetId,
      'part_of_speech': instance.partOfSpeech,
      'image_url': instance.imageUrl,
      'native_format': instance.nativeFormat,
      'adaptable': instance.adaptable,
    };
