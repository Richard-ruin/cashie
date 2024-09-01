import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:cashie/providers/theme_provider.dart';

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
                ? Color(0xFF2B2B2B)
                : Colors.blue,
        title: Text(
          AppLocalizations.of(context)!.statistics,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(AppLocalizations.of(context)!.statisticsPage),
      ),
    );
  }
}
