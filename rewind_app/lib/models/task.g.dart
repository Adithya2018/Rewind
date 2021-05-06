// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task()
      ..created = fields[0] as DateTime
      ..orderIndex = fields[1] as int
      ..label = fields[2] as String
      ..description = fields[3] as String
      ..deadline = fields[4] as DateTime
      ..level = fields[5] as int
      ..completionStatus = fields[6] as bool
      ..completed = fields[7] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.created)
      ..writeByte(1)
      ..write(obj.orderIndex)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.deadline)
      ..writeByte(5)
      ..write(obj.level)
      ..writeByte(6)
      ..write(obj.completionStatus)
      ..writeByte(7)
      ..write(obj.completed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
