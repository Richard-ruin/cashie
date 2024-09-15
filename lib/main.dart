import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:cashie/providers/language_provider.dart';
import 'package:cashie/providers/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cashie/l10n/l10n.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cashie/providers/settings_page_provider.dart';
import 'models/settings/notes_model.dart';
import 'splash_screen.dart';
import 'package:cashie/models/items/items_model.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase core package
import 'package:cashie/providers/backup_provider.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  await Hive.initFlutter();

  Hive.registerAdapter(NoteContentAdapter());
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(ItemAdapter());

  await Hive.openBox(ThemeProvider.themeBoxName);
  await Hive.openBox(LanguageProvider.languageBoxName);
  await Hive.openBox(SettingsPageProvider.settingsBoxName);
  await Hive.openBox<Item>('items');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => SettingsPageProvider()),
        ChangeNotifierProvider(create: (_) => BackupProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider, ThemeProvider>(
      builder: (context, languageProvider, themeProvider, _) {
        return MaterialApp(
          title: 'Cashie',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
          locale: languageProvider.currentLocale,
          theme: ThemeData.light().copyWith(
            colorScheme: themeProvider.colorScheme,
          ),
          darkTheme: ThemeData.dark().copyWith(
            colorScheme: themeProvider.colorScheme,
          ),
          themeMode: themeProvider.themeMode,
          home: const SplashScreen(),
          routes: {
            '/home': (context) => const HomeScreen(),
          },
        );
      },
    );
  }
}
