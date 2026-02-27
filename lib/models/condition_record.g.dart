// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'condition_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConditionRecordAdapter extends TypeAdapter<ConditionRecord> {
  @override
  final int typeId = 2;

  @override
  ConditionRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConditionRecord(
      id: fields[0] as String,
      dateStr: fields[1] as String,
      sleepHours: fields[2] as double,
      mood: fields[3] as int,
      focus: fields[4] as int,
      createdAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ConditionRecord obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dateStr)
      ..writeByte(2)
      ..write(obj.sleepHours)
      ..writeByte(3)
      ..write(obj.mood)
      ..writeByte(4)
      ..write(obj.focus)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConditionRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
