// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_page.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JournalPageAdapter extends TypeAdapter<JournalPage> {
  @override
  final int typeId = 3;

  @override
  JournalPage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JournalPage()
      ..created = fields[0] as DateTime?
      ..title = fields[1] as String?
      ..content = fields[2] as String?
      ..fav = fields[3] as bool?;
  }

  @override
  void write(BinaryWriter writer, JournalPage obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.created)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.fav);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalPageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
