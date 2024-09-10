import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BackupPage extends StatefulWidget {
  const BackupPage({super.key});

  @override
  _BackupPageState createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          AppLocalizations.of(context)!.data,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: null,
              child: Text('Create Backup'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: null,
              child: Text('Restore Backup'),
            ),
          ],
        ),
      ),
    );
  }
}
