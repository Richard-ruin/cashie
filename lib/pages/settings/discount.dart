import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cashie/providers/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiscountPage extends StatefulWidget {
  final String initialDiscount;
  final Function(String) onDiscountChanged;

  DiscountPage(
      {required this.initialDiscount, required this.onDiscountChanged});

  @override
  _DiscountPageState createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  late TextEditingController _discountController;

  @override
  void initState() {
    super.initState();
    _discountController = TextEditingController(text: widget.initialDiscount);
  }

  @override
  void dispose() {
    _discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          AppLocalizations.of(context)!.discount,
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
        controller: _discountController,
        onChanged: widget.onDiscountChanged,
      ),
    );
  }
}
