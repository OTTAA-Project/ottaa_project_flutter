// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picto_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PictoAdapter extends TypeAdapter<Picto> {
  @override
  final int typeId = 6;

  @override
  Picto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Picto(
      id: fields[1] as String,
      type: fields[7] as int,
      resource: fields[4] as AssetsImage,
      text: fields[3] == null ? "" : fields[3] as String,
      freq: fields[5] as double,
      block: fields[0] == null ? false : fields[0] as bool,
      relations: (fields[2] as List).cast<PictoRelation>(),
      tags: fields[6] == null
          ? {}
          : (fields[6] as Map).map((dynamic k, dynamic v) =>
              MapEntry(k as String, (v as List).cast<String>())),
    );
  }

  @override
  void write(BinaryWriter writer, Picto obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.freq)
      ..writeByte(6)
      ..write(obj.tags)
      ..writeByte(7)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PictoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PictoRelationAdapter extends TypeAdapter<PictoRelation> {
  @override
  final int typeId = 7;

  @override
  PictoRelation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PictoRelation(
      id: fields[0] as String,
      value: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, PictoRelation obj) {
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
      other is PictoRelationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
