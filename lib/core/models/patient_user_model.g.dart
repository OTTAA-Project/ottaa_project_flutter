// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PatientUserModelAdapter extends TypeAdapter<PatientUserModel> {
  @override
  final int typeId = 0;

  @override
  PatientUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PatientUserModel(
      id: fields[0] as String,
      groups: (fields[1] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<Group>())),
      phrases: (fields[2] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<Phrase>())),
      pictos: (fields[3] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<Picto>())),
      settings: fields[4] as UserSettings,
      type: fields[5] as UserType,
      email: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PatientUserModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.groups)
      ..writeByte(2)
      ..write(obj.phrases)
      ..writeByte(3)
      ..write(obj.pictos)
      ..writeByte(4)
      ..write(obj.settings)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PatientSettingsAdapter extends TypeAdapter<PatientSettings> {
  @override
  final int typeId = 1;

  @override
  PatientSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PatientSettings(
      data: fields[0] as UserData,
      language: fields[1] as LanguageSetting,
      payment: fields[2] as Payment,
      layout: fields[3] as LayoutSetting,
      accessibility: fields[4] as AccessibilitySetting,
      tts: fields[5] as TTSSetting,
    );
  }

  @override
  void write(BinaryWriter writer, PatientSettings obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.language)
      ..writeByte(2)
      ..write(obj.payment)
      ..writeByte(3)
      ..write(obj.layout)
      ..writeByte(4)
      ..write(obj.accessibility)
      ..writeByte(5)
      ..write(obj.tts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
