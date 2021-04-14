// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersistedSettingAdapter extends TypeAdapter<PersistedSetting> {
  @override
  final int typeId = 1;

  @override
  PersistedSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersistedSetting(
      fields[0] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, PersistedSetting obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersistedSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
