// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notify_background_enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotifyBackgroundColorsAdapter
    extends TypeAdapter<NotifyBackgroundColors> {
  @override
  final int typeId = 2;

  @override
  NotifyBackgroundColors read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NotifyBackgroundColors.grey;
      case 1:
        return NotifyBackgroundColors.orange;
      case 2:
        return NotifyBackgroundColors.yellow;
      case 3:
        return NotifyBackgroundColors.purple;
      case 4:
        return NotifyBackgroundColors.pink;
      case 5:
        return NotifyBackgroundColors.none;
      default:
        return NotifyBackgroundColors.grey;
    }
  }

  @override
  void write(BinaryWriter writer, NotifyBackgroundColors obj) {
    switch (obj) {
      case NotifyBackgroundColors.grey:
        writer.writeByte(0);
        break;
      case NotifyBackgroundColors.orange:
        writer.writeByte(1);
        break;
      case NotifyBackgroundColors.yellow:
        writer.writeByte(2);
        break;
      case NotifyBackgroundColors.purple:
        writer.writeByte(3);
        break;
      case NotifyBackgroundColors.pink:
        writer.writeByte(4);
        break;
      case NotifyBackgroundColors.none:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotifyBackgroundColorsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
