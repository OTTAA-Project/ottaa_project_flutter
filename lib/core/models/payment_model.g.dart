// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
part of 'payment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentAdapter extends TypeAdapter<Payment> {
  @override
  final int typeId = 4;

  @override
  Payment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Payment(
      payment: fields[0] == null ? false : fields[0] as bool,
      paymentDate: fields[1] == null ? 0 : fields[1] as int,
      paymentExpire: fields[2] == null ? 0 : fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Payment obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.payment)
      ..writeByte(1)
      ..write(obj.paymentDate)
      ..writeByte(2)
      ..write(obj.paymentExpire);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
