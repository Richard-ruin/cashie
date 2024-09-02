import 'package:hive/hive.dart';
import 'package:cashie/models/settings/debt_model.dart';
import 'package:cashie/models/settings/membership_model.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class Transaction extends HiveObject {
  @HiveField(0)
  final String transactionId;

  @HiveField(1)
  final List<String> itemIds;

  @HiveField(2)
  final String? memberId;

  @HiveField(3)
  final double totalTransaction;

  @HiveField(4)
  final double totalDisc;

  @HiveField(5)
  final DateTime transactionDate;

  @HiveField(6)
  final double amountPaid;

  Transaction({
    required this.transactionId,
    required this.itemIds,
    this.memberId,
    required this.totalTransaction,
    required this.totalDisc,
    required this.transactionDate,
    required this.amountPaid,
  });

  double get remainingDebt => totalTransaction - amountPaid;

  void updateMemberPoints(Membership member) {
    final pointsEarned = (totalTransaction * 0.01).round();
    member.addPoints(pointsEarned);
  }

  Debt? insertDebt() {
    if (remainingDebt > 0) {
      final newDebt = Debt(
        debtId: 'debt_${DateTime.now().millisecondsSinceEpoch}',
        memberId: memberId!,
        transactionId: transactionId,
        totalDebt: remainingDebt,
      );

      final debtBox = Hive.box<Debt>('debtBox');
      debtBox.add(newDebt);

      return newDebt;
    }
    return null;
  }
}
