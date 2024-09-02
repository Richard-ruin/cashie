import 'package:hive/hive.dart';

part 'purchase_order_model.g.dart';

@HiveType(typeId: 4)
class PurchaseOrder extends HiveObject {
  @HiveField(0)
  final String POId;

  @HiveField(1)
  final String POSalesName;

  @HiveField(2)
  final String POCompany;

  @HiveField(3)
  final String imagePath; // Path untuk menyimpan gambar

  PurchaseOrder({
    required this.POId,
    required this.POSalesName,
    required this.POCompany,
    required this.imagePath,
  });
}
