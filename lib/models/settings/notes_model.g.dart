// notes_model.g.dart

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_model.dart';

class NoteContentTypeAdapter extends TypeAdapter<NoteContentType> {
  @override
  final int typeId = 4;

  @override
  NoteContentType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NoteContentType.text;
      case 1:
        return NoteContentType.image;
      case 2:
        return NoteContentType.drawing;
      default:
        return NoteContentType.text;
    }
  }

  @override
  void write(BinaryWriter writer, NoteContentType obj) {
    switch (obj) {
      case NoteContentType.text:
        writer.writeByte(0);
        break;
      case NoteContentType.image:
        writer.writeByte(1);
        break;
      case NoteContentType.drawing:
        writer.writeByte(2);
        break;
    }
  }
}

class NoteContentAdapter extends TypeAdapter<NoteContent> {
  @override
  final int typeId = 5;

  @override
  NoteContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteContent(
      contentType: fields[0] as NoteContentType,
      text: fields[1] as String?,
      imagePath: fields[2] as String?,
      drawingPath: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NoteContent obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.contentType)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.drawingPath);
  }
}

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final int typeId = 6;

  @override
  Note read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Note(
      noteId: fields[0] as String,
      header: fields[1] as String,
      contents: (fields[2] as List).cast<NoteContent>(),
    );
  }

  @override
  void write(BinaryWriter writer, Note obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.noteId)
      ..writeByte(1)
      ..write(obj.header)
      ..writeByte(2)
      ..write(obj.contents);
  }
}
