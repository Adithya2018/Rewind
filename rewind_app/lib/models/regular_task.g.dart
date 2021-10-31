// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regular_task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegularTaskAdapter extends TypeAdapter<RegularTask> {
  @override
  final int typeId = 1;

  @override
  RegularTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegularTask()
      ..created = fields[0] as DateTime?
      ..orderIndex = fields[1] as int?
      ..label = fields[2] as String?
      ..description = fields[3] as String?
      ..weekly = fields[4] as bool?
      ..weeklyRepeat = (fields[5] as List?)
          ?.map((dynamic e) => (e as List)?.cast<TimeInterval>())
          ?.toList()
      ..customRepeat = (fields[6] as Map?)?.cast<dynamic, dynamic>()
      ..level = fields[7] as int?
      ..completionStatus = fields[8] as bool?;
  }

  @override
  void write(BinaryWriter writer, RegularTask obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.created)
      ..writeByte(1)
      ..write(obj.orderIndex)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.weekly)
      ..writeByte(5)
      ..write(obj.weeklyRepeat)
      ..writeByte(6)
      ..write(obj.customRepeat)
      ..writeByte(7)
      ..write(obj.level)
      ..writeByte(8)
      ..write(obj.completionStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegularTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
