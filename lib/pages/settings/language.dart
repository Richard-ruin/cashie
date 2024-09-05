import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cashie/providers/language_provider.dart';
import 'package:cashie/providers/theme_provider.dart';

class LanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          AppLocalizations.of(context)!.language,
          style: TextStyle(
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
              style: TextStyle(
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
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            trailing: AppLocalizations.of(context)!.localeName == 'en'
                ? Icon(Icons.check, color: Colors.blue)
                : null,
            onTap: () {
              Provider.of<LanguageProvider>(context, listen: false)
                  .changeLanguage('en');
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.indonesianLanguage,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            trailing: AppLocalizations.of(context)!.localeName == 'id'
                ? Icon(Icons.check, color: Colors.blue)
                : null,
            onTap: () {
              Provider.of<LanguageProvider>(context, listen: false)
                  .changeLanguage('id');
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.chineseLanguage,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            trailing: AppLocalizations.of(context)!.localeName == 'zh'
                ? Icon(Icons.check, color: Colors.blue)
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
