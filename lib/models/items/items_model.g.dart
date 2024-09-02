// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 0;

  @override
  Item read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item(
      itemId: fields[0] as String,
      itemName: fields[1] as String,
      imagePath: fields[2] as String,
      itemType: fields[3] as String,
      itemCategory: fields[4] as String,
      itemCompany: fields[5] as String,
      capitalPrice: fields[6] as double,
      itemPrice: fields[7] as double,
      packagedPrice: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.itemId)
      ..writeByte(1)
      ..write(obj.itemName)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.itemType)
      ..writeByte(4)
      ..write(obj.itemCategory)
      ..writeByte(5)
      ..write(obj.itemCompany)
      ..writeByte(6)
      ..write(obj.capitalPrice)
      ..writeByte(7)
      ..write(obj.itemPrice)
      ..writeByte(8)
      ..write(obj.packagedPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
