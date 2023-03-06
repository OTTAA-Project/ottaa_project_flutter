// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BaseSettingsModelAdapter extends TypeAdapter<BaseSettingsModel> {
  @override
  final int typeId = 15;

  @override
  BaseSettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BaseSettingsModel(
      data: fields[0] as UserData,
      language: fields[1] as LanguageSetting,
    );
  }

  @override
  void write(BinaryWriter writer, BaseSettingsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.language);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseSettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
