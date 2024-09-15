import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cashie/models/settings/purchase_order.dart';

class FirestoreService {
  final CollectionReference _purchaseOrdersCollection =
      FirebaseFirestore.instance.collection('purchaseOrders');

  Future<void> addPurchaseOrder(PurchaseOrder purchaseOrder) async {
    await _purchaseOrdersCollection.add(purchaseOrder.toMap());
  }

  Future<void> updatePurchaseOrder(PurchaseOrder purchaseOrder) async {
    await _purchaseOrdersCollection
        .doc(purchaseOrder.id)
        .update(purchaseOrder.toMap());
  }

  Future<void> deletePurchaseOrder(String id) async {
    await _purchaseOrdersCollection.doc(id).delete();
  }

  Stream<List<PurchaseOrder>> getPurchaseOrders() {
    return _purchaseOrdersCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => PurchaseOrder.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }
}
