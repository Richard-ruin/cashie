import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:cashie/providers/language_provider.dart';
import 'package:cashie/providers/theme_provider.dart';
import 'package:cashie/pages/cashier/cashier.dart';
import 'package:cashie/pages/items/items.dart';
import 'package:cashie/pages/calculator/calculator.dart';
import 'package:cashie/pages/statistics/statistics.dart';
import 'package:cashie/pages/settings/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cashie/l10n/l10n.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cashie/providers/settings_page_provider.dart';
import 'models/settings/notes_model.dart';
import 'curved_navigation_bar.dart';
import 'splash_screen.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();

  Hive.registerAdapter(NoteContentTypeAdapter());
  Hive.registerAdapter(NoteContentAdapter());
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox(ThemeProvider.themeBoxName);
  await Hive.openBox(LanguageProvider.languageBoxName);
  await Hive.openBox(SettingsPageProvider.settingsBoxName);
  await Hive.openBox<Note>('notes');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => SettingsPageProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider, ThemeProvider>(
      builder: (context, languageProvider, themeProvider, _) {
        return MaterialApp(
          title: 'Cashie',
          localizationsDelegates: [
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
          home: SplashScreen(),
          routes: {
            '/home': (context) => HomeScreen(),
          },
        );
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    CashierPage(),
    ItemsPage(),
    CalculatorPage(),
    StatisticsPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        items: <Widget>[
          Icon(
            Icons.point_of_sale,
            size: 30,
            color: isDarkMode ? Colors.white : null,
          ),
          Icon(
            Icons.list,
            size: 30,
            color: isDarkMode ? Colors.white : null,
          ),
          Icon(
            Icons.calculate,
            size: 30,
            color: isDarkMode ? Colors.white : null,
          ),
          Icon(
            Icons.bar_chart,
            size: 30,
            color: isDarkMode ? Colors.white : null,
          ),
          Icon(
            Icons.settings,
            size: 30,
            color: isDarkMode ? Colors.white : null,
          ),
        ],
        color: isDarkMode ? Color(0xFF2B2B2B) : Colors.white,
        buttonBackgroundColor: isDarkMode ? Color(0xFF424242) : Colors.white,
        backgroundColor: isDarkMode ? Color(0xFF121212) : Colors.blueAccent,
        onTap: _onItemTapped,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
      ),
    );
  }
}
