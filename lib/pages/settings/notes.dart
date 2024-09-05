import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cashie/providers/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotesPage extends StatefulWidget {
  final String initialNotes;
  final Function(String) onNotesChanged;

  NotesPage({required this.initialNotes, required this.onNotesChanged});

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController(text: widget.initialNotes);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          AppLocalizations.of(context)!.notes,
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
        controller: _notesController,
        onChanged: widget.onNotesChanged,
      ),
    );
  }
}
