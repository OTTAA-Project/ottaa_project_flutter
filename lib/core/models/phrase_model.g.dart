// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
part of 'phrase_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhraseAdapter extends TypeAdapter<Phrase> {
  @override
  final int typeId = 3;

  @override
  Phrase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Phrase(
      date: fields[0] as DateTime,
      id: fields[1] as String,
      sequence: (fields[2] as List).cast<Sequence>(),
      tags: (fields[3] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<String>())),
    );
  }

  @override
  void write(BinaryWriter writer, Phrase obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.sequence)
      ..writeByte(3)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhraseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SequenceAdapter extends TypeAdapter<Sequence> {
  @override
  final int typeId = 9;

  @override
  Sequence read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sequence(
      id: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Sequence obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SequenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
