import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cashie/models/settings/backup_model.dart';
import 'package:permission_handler/permission_handler.dart';

class BackupService {
  static Future<bool> requestStoragePermission() async {
    var status = await Permission.storage.request();
    return status.isGranted;
  }

  static Future<String?> selectBackupFolder() async {
    final String? selectedDirectory =
        await FilePicker.platform.getDirectoryPath();
    return selectedDirectory;
  }

  static Future<File> createBackupFile(
      String folderPath, String fileName) async {
    final Directory directory = Directory(folderPath);
    final File backupFile = File('${directory.path}/$fileName');
    return backupFile;
  }

  static Future<BackupModel?> selectBackupFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result != null && result.files.isNotEmpty) {
      final File file = File(result.files.first.path!);
      final DateTime createdAt = await file.lastModified();
      return BackupModel(filePath: file.path, createdAt: createdAt);
    }

    return null;
  }

  static Future<void> restoreBackup(BackupModel backup) async {
    // Implementasikan logika untuk memulihkan cadangan di sini
    // Misalnya, baca file JSON dan pulihkan data ke dalam database
  }
}
