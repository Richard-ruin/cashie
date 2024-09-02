import 'package:hive/hive.dart';

part 'discount_model.g.dart';

enum DiscountType { percentage, fixedAmount }

enum DiscountTarget { all, membersOnly }

@HiveType(typeId: 2)
class Discount extends HiveObject {
  @HiveField(0)
  final String discountId;

  @HiveField(1)
  final DiscountTarget target;

  @HiveField(2)
  final DateTime startTime;

  @HiveField(3)
  final DateTime endTime;

  @HiveField(4)
  final DiscountType discountType;

  @HiveField(5)
  final double value;

  @HiveField(6)
  final bool isItemSpecific;

  @HiveField(7)
  final String? itemId;

  @HiveField(8)
  final int? minItemCount;

  Discount({
    required this.discountId,
    required this.target,
    required this.startTime,
    required this.endTime,
    required this.discountType,
    required this.value,
    this.isItemSpecific = false,
    this.itemId,
    this.minItemCount,
  });
}
