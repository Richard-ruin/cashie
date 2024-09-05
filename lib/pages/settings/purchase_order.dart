import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cashie/providers/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PurchaseOrderPage extends StatefulWidget {
  final String initialPurchaseOrder;
  final Function(String) onPurchaseOrderChanged;

  PurchaseOrderPage(
      {required this.initialPurchaseOrder,
      required this.onPurchaseOrderChanged});

  @override
  _PurchaseOrderPageState createState() => _PurchaseOrderPageState();
}

class _PurchaseOrderPageState extends State<PurchaseOrderPage> {
  late TextEditingController _purchaseOrderController;

  @override
  void initState() {
    super.initState();
    _purchaseOrderController =
        TextEditingController(text: widget.initialPurchaseOrder);
  }

  @override
  void dispose() {
    _purchaseOrderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          AppLocalizations.of(context)!.purchaseOrder,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: TextField(
        controller: _purchaseOrderController,
        onChanged: widget.onPurchaseOrderChanged,
      ),
    );
  }
}
