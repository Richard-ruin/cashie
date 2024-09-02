import 'package:hive/hive.dart';

part 'notes_model.g.dart';

enum NoteContentType { text, image, drawing }

@HiveType(typeId: 5)
class NoteContent extends HiveObject {
  @HiveField(0)
  final NoteContentType contentType;

  @HiveField(1)
  final String? text; // Jika tipe konten adalah teks

  @HiveField(2)
  final String? imagePath; // Jika tipe konten adalah gambar

  @HiveField(3)
  final String? drawingPath; // Jika tipe konten adalah gambar yang digambar

  NoteContent({
    required this.contentType,
    this.text,
    this.imagePath,
    this.drawingPath,
  });
}

@HiveType(typeId: 6)
class Note extends HiveObject {
  @HiveField(0)
  final String noteId;

  @HiveField(1)
  final String header;

  @HiveField(2)
  final List<NoteContent>
      contents; // Daftar konten yang bisa berupa teks, gambar, atau gambar yang digambar

  Note({
    required this.noteId,
    required this.header,
    required this.contents,
  });
}
