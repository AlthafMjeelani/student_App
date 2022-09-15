// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentModelAdapter extends TypeAdapter<StudentModel> {
  @override
  final int typeId = 1;

  @override
  StudentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentModel(
      id: fields[5] as String?,
      username: fields[0] as String,
      age: fields[1] as String,
      mobilenumber: fields[2] as String,
      domain: fields[3] as String,
      photo: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StudentModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.mobilenumber)
      ..writeByte(3)
      ..write(obj.domain)
      ..writeByte(4)
      ..write(obj.photo)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
