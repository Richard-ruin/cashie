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

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'imagePath': imagePath,
      'itemType': itemType,
      'itemCategory': itemCategory,
      'itemCompany': itemCompany,
      'capitalPrice': capitalPrice,
      'itemPrice': itemPrice,
      'packagedPrice': packagedPrice,
    };
  }

  static Item fromMap(Map<String, dynamic> map) {
    return Item(
      itemId: map['itemId'] ?? '',
      itemName: map['itemName'] ?? '',
      imagePath: map['imagePath'] ?? '',
      itemType: map['itemType'] ?? '',
      itemCategory: map['itemCategory'] ?? '',
      itemCompany: map['itemCompany'] ?? '',
      capitalPrice: map['capitalPrice']?.toDouble() ?? 0.0,
      itemPrice: map['itemPrice']?.toDouble() ?? 0.0,
      packagedPrice: map['packagedPrice']?.toDouble() ?? 0.0,
    );
  }
}
