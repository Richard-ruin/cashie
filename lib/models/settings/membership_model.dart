import 'package:hive/hive.dart';

part 'membership_model.g.dart';

@HiveType(typeId: 1)
class Membership extends HiveObject {
  @HiveField(0)
  final String memberId;

  @HiveField(1)
  final String memberName;

  @HiveField(2)
  final String memberNoTel;

  @HiveField(3)
  final String memberGender;

  @HiveField(4)
  int memberPoin;

  @HiveField(5)
  final DateTime memberRegDate;

  Membership({
    required this.memberId,
    required this.memberName,
    required this.memberNoTel,
    required this.memberGender,
    this.memberPoin = 0,
    required this.memberRegDate,
  });

  void addPoints(int points) {
    memberPoin += points;
  }

  void redeemPoints(int points) {
    memberPoin -= points;
  }
}

final generalMember = Membership(
  memberId: 'general',
  memberName: 'Member Umum',
  memberNoTel: '',
  memberGender: '',
  memberRegDate: DateTime.now(),
);
