import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cashie/providers/cashie_theme_provider.dart';
import 'package:cashie/providers/theme_mode_provider.dart';

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cashieThemeController = Provider.of<CashieThemeController>(context);
    final themeModeProvider = Provider.of<ThemeModeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.theme,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CupertinoSegmentedControl<ThemeMode>(
              groupValue: themeModeProvider.themeMode,
              onValueChanged: (ThemeMode mode) {
                themeModeProvider.toggleThemeMode(mode);
              },
              children: {
                ThemeMode.system: Text(AppLocalizations.of(context)!.system),
                ThemeMode.light: Text(AppLocalizations.of(context)!.lightTheme),
                ThemeMode.dark: Text(AppLocalizations.of(context)!.darkTheme),
              },
            ),
            SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.colorScheme,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text(
                      "Default Color Scheme",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                      ),
                    ),
                    trailing:
                        cashieThemeController.appTheme == 'DefaultColorScheme'
                            ? Icon(
                                Icons.check,
                                color: Theme.of(context).primaryColor,
                              )
                            : null,
                    onTap: () {
                      cashieThemeController.updateTheme('DefaultColorScheme');
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Green Apple Color Scheme",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                      ),
                    ),
                    trailing: cashieThemeController.appTheme ==
                            'GreenAppleColorScheme'
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                    onTap: () {
                      cashieThemeController
                          .updateTheme('GreenAppleColorScheme');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
