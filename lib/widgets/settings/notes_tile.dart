import 'package:flutter/material.dart';
import 'package:cashie/models/settings/notes_model.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;

  const NoteTile({super.key, required this.note, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(note.header),
      onTap: onTap,
    );
  }
}
