import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cashie/providers/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cashie/themes/ThemeController.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 149, 157, 163),
        title: Text(
          AppLocalizations.of(context)!.theme,
          style: const TextStyle(
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
            const Text(
              'Select Theme',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) {
                return ToggleButtons(
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
                  children: const [
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
                );
              },
            ),
            const SizedBox(height: 40),
            const Text(
              'Select Color Scheme',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) {
                return ToggleButtons(
                  isSelected: [
                    themeProvider.colorScheme == const ColorScheme.light(),
                    themeProvider.colorScheme ==
                        const ColorScheme.dark(
                          primary: Color(0xFF7ADB8F),
                          onPrimary: Color(0xFF003917),
                          // ...
                        ),
                  ],
                  onPressed: (index) {
                    if (index == 0) {
                      themeProvider.setColorScheme(const ColorScheme.light());
                    } else if (index == 1) {
                      themeProvider.setColorScheme(const ColorScheme.dark(
                        primary: Color(0xFF7ADB8F),
                        onPrimary: Color(0xFF003917),
                        // ...
                      ));
                    }
                  },
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Default'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Green Apple'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
