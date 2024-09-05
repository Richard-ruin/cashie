import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cashie/providers/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DataPage extends StatefulWidget {
  final String initialData;
  final Function(String) onDataChanged;

  DataPage({required this.initialData, required this.onDataChanged});

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  late TextEditingController _dataController;

  @override
  void initState() {
    super.initState();
    _dataController = TextEditingController(text: widget.initialData);
  }

  @override
  void dispose() {
    _dataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          AppLocalizations.of(context)!.data,
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
        controller: _dataController,
        onChanged: widget.onDataChanged,
      ),
    );
  }
}
