import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DebtsPage extends StatefulWidget {
  final String initialDebts;
  final Function(String) onDebtsChanged;

  const DebtsPage(
      {super.key, required this.initialDebts, required this.onDebtsChanged});

  @override
  _DebtsPageState createState() => _DebtsPageState();
}

class _DebtsPageState extends State<DebtsPage> {
  late TextEditingController _debtsController;

  @override
  void initState() {
    super.initState();
    _debtsController = TextEditingController(text: widget.initialDebts);
  }

  @override
  void dispose() {
    _debtsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          AppLocalizations.of(context)!.debts,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: TextField(
        controller: _debtsController,
        onChanged: widget.onDebtsChanged,
      ),
    );
  }
}
