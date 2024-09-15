class PurchaseOrder {
  final String id;
  final String purchaseOrder;

  PurchaseOrder({required this.id, required this.purchaseOrder});

  factory PurchaseOrder.fromMap(Map<String, dynamic> map) {
    return PurchaseOrder(
      id: map['id'],
      purchaseOrder: map['purchaseOrder'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'purchaseOrder': purchaseOrder,
    };
  }
}