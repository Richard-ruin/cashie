import 'package:hive/hive.dart';

part 'items_model.g.dart';

@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  final String itemId;

  @HiveField(1)
  final String itemName;

  @HiveField(2)
  final String imagePath;

  @HiveField(3)
  final String itemType;

  @HiveField(4)
  final String itemCategory;

  @HiveField(5)
  final String itemCompany;

  @HiveField(6)
  final double capitalPrice;

  @HiveField(7)
  final double itemPrice;

  @HiveField(8)
  final double packagedPrice;
  Item({
    required this.itemId,
    required this.itemName,
    required this.imagePath,
    required this.itemType,
    required this.itemCategory,
    required this.itemCompany,
    required this.capitalPrice,
    required this.itemPrice,
    required this.packagedPrice,
  });
}
