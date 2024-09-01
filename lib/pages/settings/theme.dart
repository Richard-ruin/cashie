import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cashie/providers/theme_provider.dart';

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
                ? Color(0xFF2B2B2B)
                : Colors.blue,
        title: Text(
          AppLocalizations.of(context)!.theme,
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
              AppLocalizations.of(context)!.lightTheme,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            trailing:
                Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
                    ? Icon(Icons.check, color: Colors.blue)
                    : null,
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.darkTheme,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            trailing:
                Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
                    ? Icon(Icons.check, color: Colors.blue)
                    : null,
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}
