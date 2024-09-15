import 'package:flutter/material.dart';
import 'package:cashie/models/settings/backup_model.dart';
import 'package:cashie/services/settings/backup_service.dart';

class BackupProvider with ChangeNotifier {
  List<Backup> _backups = [];

  List<Backup> get backups => _backups;

  Future<void> fetchBackups() async {
    _backups = await BackupService.getBackups();
    notifyListeners();
  }

  Future<void> createBackup() async {
    await BackupService.createBackup();
    await fetchBackups();
  }
}
