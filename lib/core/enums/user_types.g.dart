// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_types.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserTypeAdapter extends TypeAdapter<UserType> {
  @override
  final int typeId = 19;

  @override
  UserType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UserType.caregiver;
      case 1:
        return UserType.user;
      case 2:
        return UserType.none;
      default:
        return UserType.none;
    }
  }

  @override
  void write(BinaryWriter writer, UserType obj) {
    switch (obj) {
      case UserType.caregiver:
        writer.writeByte(0);
        break;
      case UserType.user:
        writer.writeByte(1);
        break;
      case UserType.none:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
