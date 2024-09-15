import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cashie/providers/theme_provider.dart';
import 'package:cashie/pages/cashier/cashier.dart';
import 'package:cashie/pages/items/items.dart';
import 'package:cashie/pages/calculator/calculator.dart';
import 'package:cashie/pages/statistics/statistics.dart';
import 'package:cashie/pages/settings/settings.dart';
import 'navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const CashierPage(),
    const ItemsPage(),
    const CalculatorPage(),
    const StatisticsPage(),
    const SettingsPage(),
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
        color: isDarkMode ? const Color(0xFF2B2B2B) : Colors.white,
        buttonBackgroundColor:
            isDarkMode ? const Color(0xFF424242) : Colors.white,
        backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.blue,
        onTap: _onItemTapped,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
