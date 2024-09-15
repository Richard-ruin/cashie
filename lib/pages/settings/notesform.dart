import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cashie/models/settings/notes_model.dart';
import 'package:cashie/services/settings/notes_service.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';

class NotesFormPage extends StatefulWidget {
  final Note? note;

  const NotesFormPage({super.key, this.note});

  @override
  _NotesFormPageState createState() => _NotesFormPageState();
}

class _NotesFormPageState extends State<NotesFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _headerController;
  late List<NoteContent> _contents;
  final NotesService _notesService = NotesService();

  @override
  void initState() {
    super.initState();
    _headerController = TextEditingController(
      text: widget.note?.header ?? '',
    );
    _contents = widget.note?.contents ?? [];
  }

  @override
  void dispose() {
    _headerController.dispose();
    super.dispose();
  }

  void _addTextContent() {
    setState(() {
      _contents.add(NoteContent(contentType: NoteContentType.text));
    });
  }

  void _addImageContent() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _contents.add(NoteContent(
          contentType: NoteContentType.image,
          imagePath: pickedImage.path,
        ));
      });
    }
  }

  void _addDrawingContent() {
    // Implementasi untuk menambahkan konten gambar yang digambar
  }

  void _saveNote() async {
    if (_formKey.currentState!.validate()) {
      final note = Note(
        noteId: widget.note?.noteId ?? const Uuid().v4(),
        header: _headerController.text,
        contents: _contents,
      );
      await _notesService.saveNote(note);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Add Note' : 'Edit Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _headerController,
              decoration: const InputDecoration(labelText: 'Header'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a header';
                }
                return null;
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _contents.length,
                itemBuilder: (context, index) {
                  final content = _contents[index];
                  if (content.contentType == NoteContentType.text) {
                    return TextFormField(
                      initialValue: content.text,
                      onChanged: (value) {
                        content.text = value;
                      },
                      decoration: const InputDecoration(labelText: 'Content'),
                    );
                  } else if (content.contentType == NoteContentType.image) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: [
                          Image.file(
                            File(content.imagePath!),
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _contents.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  } else if (content.contentType == NoteContentType.drawing) {
                    // Tampilan untuk konten gambar yang digambar
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.text_fields),
              onPressed: _addTextContent,
            ),
            IconButton(
              icon: const Icon(Icons.image),
              onPressed: _addImageContent,
            ),
            IconButton(
              icon: const Icon(Icons.brush),
              onPressed: _addDrawingContent,
            ),
          ],
        ),
      ),
    );
  }
}
