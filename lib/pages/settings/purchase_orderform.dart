import 'package:flutter/material.dart';

class PurchaseOrderform extends StatelessWidget {
  const PurchaseOrderform({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Pembelian',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Halaman Hutang'),
      ),
    );
  }
}
