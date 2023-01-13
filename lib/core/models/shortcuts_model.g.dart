// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shortcuts_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShortcutsAdapter extends TypeAdapter<Shortcuts> {
  @override
  final int typeId = 5;

  @override
  Shortcuts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Shortcuts(
      favs: fields[0] == null ? false : fields[0] as bool,
      gallery: fields[1] == null ? false : fields[1] as bool,
      games: fields[2] == null ? false : fields[2] as bool,
      share: fields[3] == null ? false : fields[3] as bool,
      shuffle: fields[4] == null ? false : fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Shortcuts obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.favs)
      ..writeByte(1)
      ..write(obj.gallery)
      ..writeByte(2)
      ..write(obj.games)
      ..writeByte(3)
      ..write(obj.share)
      ..writeByte(4)
      ..write(obj.shuffle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShortcutsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
