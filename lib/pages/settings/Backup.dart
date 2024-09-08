import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cashie/services/settings/backup_service.dart';
import 'package:cashie/models/settings/backup_model.dart';
import 'package:cashie/services/items/items_service.dart';

class BackupPage extends StatefulWidget {
  @override
  _BackupPageState createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  Future<void> _createItemsBackup() async {
    final String? selectedDirectory = await BackupService.selectBackupFolder();

    if (selectedDirectory != null) {
      final DateTime now = DateTime.now();
      final String fileName = 'items_backup_${now.toIso8601String()}.json';
      final File backupFile =
          await BackupService.createBackupFile(selectedDirectory, fileName);

      // Mendapatkan data items dan menyimpannya ke dalam file cadangan
      final Map<String, dynamic> itemsData = await ItemsService.getItemsData();
      await backupFile.writeAsString(json.encode(itemsData));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Items backup created successfully')),
      );
    }
  }

  Future<void> _restoreItemsBackup() async {
    final BackupModel? selectedBackup = await BackupService.selectBackupFile();

    if (selectedBackup != null) {
      // Membaca data dari file cadangan dan memulihkan data items
      final String jsonString =
          await File(selectedBackup.filePath).readAsString();
      final Map<String, dynamic> itemsData = json.decode(jsonString);
      await ItemsService.restoreItemsData(itemsData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Items backup restored successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items Backup'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _createItemsBackup,
              child: Text('Create Items Backup'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _restoreItemsBackup,
              child: Text('Restore Items Backup'),
            ),
          ],
        ),
      ),
    );
  }
}
