// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LanguageSettingAdapter extends TypeAdapter<LanguageSetting> {
  @override
  final int typeId = 30;

  @override
  LanguageSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LanguageSetting(
      language: fields[0] as String,
      labs: fields[1] == null ? false : fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LanguageSetting obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.language)
      ..writeByte(1)
      ..write(obj.labs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
