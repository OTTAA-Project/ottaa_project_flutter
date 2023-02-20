// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LayoutSettingAdapter extends TypeAdapter<LayoutSetting> {
  @override
  final int typeId = 20;

  @override
  LayoutSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LayoutSetting(
      display:
          fields[2] == null ? DisplayTypes.grid : fields[2] as DisplayTypes,
      cleanup: fields[0] == null ? false : fields[0] as bool,
      shortcuts: fields[1] as Shortcuts,
    );
  }

  @override
  void write(BinaryWriter writer, LayoutSetting obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.cleanup)
      ..writeByte(1)
      ..write(obj.shortcuts)
      ..writeByte(2)
      ..write(obj.display);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LayoutSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
