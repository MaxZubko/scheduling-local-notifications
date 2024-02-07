// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notify_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotifyModelAdapter extends TypeAdapter<NotifyModel> {
  @override
  final int typeId = 0;

  @override
  NotifyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotifyModel(
      time: fields[0] == null ? '' : fields[0] as String,
      message: fields[1] == null ? '' : fields[1] as String,
      iconPath: fields[2] == null ? '' : fields[2] as String,
      isOneTime: fields[3] == null ? false : fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NotifyModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.iconPath)
      ..writeByte(3)
      ..write(obj.isOneTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotifyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
