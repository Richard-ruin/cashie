import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cashie/providers/cashie_theme_provider.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return ListTile(
      leading: Icon(
        icon,
        color:
            isDarkMode ? Color(0xFFE4E6EB) : Color.fromARGB(190, 10, 54, 173),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: isDarkMode ? Colors.white : Colors.lightBlue,
      ),
      onTap: onTap,
    );
  }
}
