import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cashie/models/settings/purchase_order.dart';
import 'package:cashie/services/settings/firestore_service.dart';

class PurchaseOrderPage extends StatefulWidget {
  const PurchaseOrderPage({super.key});

  @override
  _PurchaseOrderPageState createState() => _PurchaseOrderPageState();
}

class _PurchaseOrderPageState extends State<PurchaseOrderPage> {
  late TextEditingController _purchaseOrderController;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _purchaseOrderController = TextEditingController();
  }

  @override
  void dispose() {
    _purchaseOrderController.dispose();
    super.dispose();
  }

  void _savePurchaseOrder() async {
    final purchaseOrder = PurchaseOrder(
      id: '',
      purchaseOrder: _purchaseOrderController.text,
    );
    await _firestoreService.addPurchaseOrder(purchaseOrder);
    Navigator.pop(context);
  }

  void _updatePurchaseOrder(PurchaseOrder purchaseOrder) async {
    final updatedPurchaseOrder = PurchaseOrder(
      id: purchaseOrder.id,
      purchaseOrder: _purchaseOrderController.text,
    );
    await _firestoreService.updatePurchaseOrder(updatedPurchaseOrder);
  }

  void _deletePurchaseOrder(PurchaseOrder purchaseOrder) async {
    await _firestoreService.deletePurchaseOrder(purchaseOrder.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          AppLocalizations.of(context)!.purchaseOrder,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _savePurchaseOrder,
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: _purchaseOrderController,
          ),
          StreamBuilder<List<PurchaseOrder>>(
            stream: _firestoreService.getPurchaseOrders(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final purchaseOrders = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: purchaseOrders.length,
                  itemBuilder: (context, index) {
                    final purchaseOrder = purchaseOrders[index];
                    return ListTile(
                      title: Text(purchaseOrder.purchaseOrder),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () =>
                                _updatePurchaseOrder(purchaseOrder),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                _deletePurchaseOrder(purchaseOrder),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
