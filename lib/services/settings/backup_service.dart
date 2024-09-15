import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cashie/models/settings/backup_model.dart';

class BackupService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> createBackup() async {
    final backup = Backup(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      timestamp: DateTime.now(),
    );

    await _firestore.collection('backups').doc(backup.id).set({
      'id': backup.id,
      'timestamp': backup.timestamp,
    });
  }

  static Future<List<Backup>> getBackups() async {
    final snapshot = await _firestore.collection('backups').get();
    final backups = snapshot.docs.map((doc) {
      final data = doc.data();
      return Backup(
        id: data['id'],
        timestamp: (data['timestamp'] as Timestamp).toDate(),
      );
    }).toList();

    return backups;
  }
}
