import 'package:cashie/models/settings/notes_model.dart';
import 'package:hive/hive.dart';

class NotesService {
  static const String _boxName = 'notes';

  Future<void> saveNote(Note note) async {
    final box = await Hive.openBox<Note>(_boxName);
    await box.put(note.noteId, note);
  }

  Future<void> deleteNote(String noteId) async {
    final box = await Hive.openBox<Note>(_boxName);
    await box.delete(noteId);
  }

  Future<List<Note>> getAllNotes() async {
    final box = await Hive.openBox<Note>(_boxName);
    return box.values.toList();
  }
}
