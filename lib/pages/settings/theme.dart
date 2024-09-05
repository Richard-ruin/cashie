import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cashie/providers/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cashie/themes/ThemeController.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 149, 157, 163),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Theme',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) {
                return ToggleButtons(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('System'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Light'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Dark'),
                    ),
                  ],
                  isSelected: [
                    themeProvider.themeMode == ThemeMode.system,
                    themeProvider.themeMode == ThemeMode.light,
                    themeProvider.themeMode == ThemeMode.dark,
                  ],
                  onPressed: (index) {
                    if (index == 0) {
                      themeProvider.setThemeMode(ThemeMode.system);
                    } else if (index == 1) {
                      themeProvider.setThemeMode(ThemeMode.light);
                    } else if (index == 2) {
                      themeProvider.setThemeMode(ThemeMode.dark);
                    }
                  },
                );
              },
            ),
            SizedBox(height: 40),
            Text(
              'Select Color Scheme',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) {
                return ToggleButtons(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Default'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Green Apple'),
                    ),
                  ],
                  isSelected: [
                    themeProvider.colorScheme == ColorScheme.light(),
                    themeProvider.colorScheme ==
                        ColorScheme.dark(
                          primary: Color(0xFF7ADB8F),
                          onPrimary: Color(0xFF003917),
                          // ...
                        ),
                  ],
                  onPressed: (index) {
                    if (index == 0) {
                      themeProvider.setColorScheme(ColorScheme.light());
                    } else if (index == 1) {
                      themeProvider.setColorScheme(ColorScheme.dark(
                        primary: Color(0xFF7ADB8F),
                        onPrimary: Color(0xFF003917),
                        // ...
                      ));
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
