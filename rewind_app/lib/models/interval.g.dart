// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interval.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeIntervalAdapter extends TypeAdapter<TimeInterval> {
  @override
  final int typeId = 2;

  @override
  TimeInterval read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeInterval()
      ..startTime = (fields[0] as Map)?.cast<String, int>()
      ..endTime = (fields[1] as Map)?.cast<String, int>();
  }

  @override
  void write(BinaryWriter writer, TimeInterval obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.startTime)
      ..writeByte(1)
      ..write(obj.endTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeIntervalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
