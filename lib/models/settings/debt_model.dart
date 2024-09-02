import 'package:hive/hive.dart';

part 'debt_model.g.dart';

@HiveType(typeId: 6)
class Debt extends HiveObject {
  @HiveField(0)
  final String debtId;

  @HiveField(1)
  final String memberId;

  @HiveField(2)
  final String transactionId;

  @HiveField(3)
  double totalDebt;

  Debt({
    required this.debtId,
    required this.memberId,
    required this.transactionId,
    required this.totalDebt,
  });

  void payInstallment(double amount) {
    totalDebt -= amount;
  }

  void payInFull() {
    totalDebt = 0.0;
  }

  void addDebt(double amount) {
    totalDebt += amount;
  }
}
