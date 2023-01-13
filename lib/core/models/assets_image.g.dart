// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssetsImageAdapter extends TypeAdapter<AssetsImage> {
  @override
  final int typeId = 17;

  @override
  AssetsImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AssetsImage(
      asset: fields[0] as String,
      network: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AssetsImage obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.asset)
      ..writeByte(1)
      ..write(obj.network);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssetsImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
