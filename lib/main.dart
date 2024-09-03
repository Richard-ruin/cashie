import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'curved_navigation_bar.dart';
import 'splash_screen.dart';
import 'package:cashie/pages/cashier/cashier.dart';
import 'package:cashie/pages/items/items.dart';
import 'package:cashie/pages/history/history.dart';
import 'package:cashie/pages/statistics/statistics.dart';
import 'package:cashie/pages/settings/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cashie/l10n/l10n.dart';
import 'package:cashie/providers/language_provider.dart';
import 'package:cashie/providers/cashie_theme_provider.dart';
import 'providers/theme_mode_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(
            create: (_) =>
                CashieThemeController()), // Update with CashieThemeController
        ChangeNotifierProvider(
            create: (_) => ThemeModeProvider()), // Added for ThemeMode
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer3<LanguageProvider, CashieThemeController,
        ThemeModeProvider>(
      builder:
          (context, languageProvider, themeController, themeModeProvider, _) {
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
          theme: CashieTheme.getTheme(themeController.appTheme),
          darkTheme: CashieTheme.getTheme(themeController.appTheme),
          themeMode: themeModeProvider.themeMode,
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
    HistoryPage(),
    StatisticsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeModeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        items: <Widget>[
          Icon(Icons.point_of_sale,
              size: 30,
              color: isDarkMode
                  ? CashieTheme.getTheme(
                              context.watch<CashieThemeController>().appTheme)
                          .iconTheme
                          .color ??
                      Colors.white
                  : null),
          Icon(Icons.list,
              size: 30,
              color: isDarkMode
                  ? CashieTheme.getTheme(
                              context.watch<CashieThemeController>().appTheme)
                          .iconTheme
                          .color ??
                      Colors.white
                  : null),
          Icon(Icons.history,
              size: 30,
              color: isDarkMode
                  ? CashieTheme.getTheme(
                              context.watch<CashieThemeController>().appTheme)
                          .iconTheme
                          .color ??
                      Colors.white
                  : null),
          Icon(Icons.bar_chart,
              size: 30,
              color: isDarkMode
                  ? CashieTheme.getTheme(
                              context.watch<CashieThemeController>().appTheme)
                          .iconTheme
                          .color ??
                      Colors.white
                  : null),
          Icon(Icons.settings,
              size: 30,
              color: isDarkMode
                  ? CashieTheme.getTheme(
                              context.watch<CashieThemeController>().appTheme)
                          .iconTheme
                          .color ??
                      Colors.white
                  : null),
        ],
        color: isDarkMode
            ? CashieTheme.getTheme(
                        context.watch<CashieThemeController>().appTheme)
                    .bottomNavigationBarTheme
                    .backgroundColor ??
                Color(0xFF2B2B2B)
            : Colors.white,
        buttonBackgroundColor: isDarkMode
            ? CashieTheme.getTheme(
                        context.watch<CashieThemeController>().appTheme)
                    .bottomNavigationBarTheme
                    .selectedItemColor ??
                Color(0xFF424242)
            : Colors.white,
        backgroundColor: isDarkMode
            ? CashieTheme.getTheme(
                        context.watch<CashieThemeController>().appTheme)
                    .scaffoldBackgroundColor ??
                Color(0xFF121212)
            : Colors.blueAccent,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
      ),
    );
  }
}
