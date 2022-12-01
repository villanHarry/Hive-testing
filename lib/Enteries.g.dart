// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Enteries.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnteriesAdapter extends TypeAdapter<Enteries> {
  @override
  final int typeId = 0;

  @override
  Enteries read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Enteries()
      ..Name = fields[0] as String
      ..Email = fields[1] as String
      ..Message = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, Enteries obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.Name)
      ..writeByte(1)
      ..write(obj.Email)
      ..writeByte(2)
      ..write(obj.Message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnteriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
