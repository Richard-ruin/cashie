import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cashie/providers/language_provider.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          AppLocalizations.of(context)!.language,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.defaultLanguage,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            onTap: () {
              Provider.of<LanguageProvider>(context, listen: false)
                  .changeLanguage('en');
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.englishLanguage,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            trailing: AppLocalizations.of(context)!.localeName == 'en'
                ? const Icon(Icons.check, color: Colors.blue)
                : null,
            onTap: () {
              Provider.of<LanguageProvider>(context, listen: false)
                  .changeLanguage('en');
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.indonesianLanguage,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            trailing: AppLocalizations.of(context)!.localeName == 'id'
                ? const Icon(Icons.check, color: Colors.blue)
                : null,
            onTap: () {
              Provider.of<LanguageProvider>(context, listen: false)
                  .changeLanguage('id');
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.chineseLanguage,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            trailing: AppLocalizations.of(context)!.localeName == 'zh'
                ? const Icon(Icons.check, color: Colors.blue)
                : null,
            onTap: () {
              Provider.of<LanguageProvider>(context, listen: false)
                  .changeLanguage('zh');
            },
          ),
        ],
      ),
    );
  }
}
