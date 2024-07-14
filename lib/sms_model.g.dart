// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SmsModelAdapter extends TypeAdapter<SmsModel> {
  @override
  final int typeId = 0;

  @override
  SmsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SmsModel(
      message: fields[0] as String,
      sender: fields[1] as String,
      receivedAt: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SmsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.sender)
      ..writeByte(2)
      ..write(obj.receivedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
