// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MembershipAdapter extends TypeAdapter<Membership> {
  @override
  final int typeId = 1;

  @override
  Membership read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Membership(
      memberId: fields[0] as String,
      memberName: fields[1] as String,
      memberNoTel: fields[2] as String,
      memberGender: fields[3] as String,
      memberPoin: fields[4] as int,
      memberRegDate: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Membership obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.memberId)
      ..writeByte(1)
      ..write(obj.memberName)
      ..writeByte(2)
      ..write(obj.memberNoTel)
      ..writeByte(3)
      ..write(obj.memberGender)
      ..writeByte(4)
      ..write(obj.memberPoin)
      ..writeByte(5)
      ..write(obj.memberRegDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MembershipAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
