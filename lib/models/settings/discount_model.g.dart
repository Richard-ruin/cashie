// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiscountAdapter extends TypeAdapter<Discount> {
  @override
  final int typeId = 2;

  @override
  Discount read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Discount(
      discountId: fields[0] as String,
      target: fields[1] as DiscountTarget,
      startTime: fields[2] as DateTime,
      endTime: fields[3] as DateTime,
      discountType: fields[4] as DiscountType,
      value: fields[5] as double,
      isItemSpecific: fields[6] as bool,
      itemId: fields[7] as String?,
      minItemCount: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Discount obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.discountId)
      ..writeByte(1)
      ..write(obj.target)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.endTime)
      ..writeByte(4)
      ..write(obj.discountType)
      ..writeByte(5)
      ..write(obj.value)
      ..writeByte(6)
      ..write(obj.isItemSpecific)
      ..writeByte(7)
      ..write(obj.itemId)
      ..writeByte(8)
      ..write(obj.minItemCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiscountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
