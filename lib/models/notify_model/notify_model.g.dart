// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notify_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotifyModelAdapter extends TypeAdapter<NotifyModel> {
  @override
  final int typeId = 1;

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
      notifyBackgroundColors: fields[4] == null
          ? NotifyBackgroundColors.grey
          : fields[4] as NotifyBackgroundColors,
      timestamp: fields[5] == null ? 0 : fields[5] as int,
      recurring: fields[6] == null ? 1 : fields[6] as int?,
      idList: fields[7] == null ? [] : (fields[7] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, NotifyModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.iconPath)
      ..writeByte(3)
      ..write(obj.isOneTime)
      ..writeByte(4)
      ..write(obj.notifyBackgroundColors)
      ..writeByte(5)
      ..write(obj.timestamp)
      ..writeByte(6)
      ..write(obj.recurring)
      ..writeByte(7)
      ..write(obj.idList);
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
