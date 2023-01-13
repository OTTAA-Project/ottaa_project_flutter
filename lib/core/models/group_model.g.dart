// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroupAdapter extends TypeAdapter<Group> {
  @override
  final int typeId = 11;

  @override
  Group read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Group(
      block: fields[0] == null ? false : fields[0] as bool,
      id: fields[1] as int,
      relations: (fields[2] as List).cast<GroupRelation>(),
      text: (fields[3] as Map).cast<String, String>(),
      resource: fields[4] as AssetsImage,
      freq: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Group obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.block)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.relations)
      ..writeByte(3)
      ..write(obj.text)
      ..writeByte(4)
      ..write(obj.resource)
      ..writeByte(5)
      ..write(obj.freq);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GroupRelationAdapter extends TypeAdapter<GroupRelation> {
  @override
  final int typeId = 13;

  @override
  GroupRelation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroupRelation(
      id: fields[0] as int,
      value: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, GroupRelation obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupRelationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
