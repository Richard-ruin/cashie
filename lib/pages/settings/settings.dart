import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cashie/widgets/settings/settings_tile.dart';
import 'package:cashie/pages/settings/notes.dart';
import 'package:cashie/pages/settings/membership.dart';
import 'package:cashie/pages/settings/purchase_order.dart';
import 'package:cashie/pages/settings/discount.dart';
import 'package:cashie/pages/settings/debts.dart';
import 'package:cashie/pages/settings/data.dart';
import 'package:cashie/pages/settings/language.dart';
import 'package:cashie/pages/settings/theme.dart';
import 'package:cashie/pages/settings/about.dart';
import "package:provider/provider.dart";
import 'package:cashie/providers/cashie_theme_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
                ? Color(0xFF2B2B2B)
                : Colors.blue,
        title: Text(
          AppLocalizations.of(context)!.settings,
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
          SettingsTile(
            icon: Icons.note,
            title: AppLocalizations.of(context)!.notes,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotesPage()),
            ),
          ),
          SettingsTile(
            icon: Icons.group,
            title: AppLocalizations.of(context)!.membership,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MembershipPage()),
            ),
          ),
          SettingsTile(
            icon: Icons.shopping_cart,
            title: AppLocalizations.of(context)!.purchaseOrder,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PurchaseOrderPage()),
            ),
          ),
          SettingsTile(
            icon: Icons.local_offer,
            title: AppLocalizations.of(context)!.discount,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DiscountPage()),
            ),
          ),
          SettingsTile(
            icon: Icons.account_balance,
            title: AppLocalizations.of(context)!.debts,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DebtsPage()),
            ),
          ),
          SettingsTile(
            icon: Icons.data_usage,
            title: AppLocalizations.of(context)!.data,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DataPage()),
            ),
          ),
          SettingsTile(
            icon: Icons.language,
            title: AppLocalizations.of(context)!.language,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LanguagePage()),
            ),
          ),
          SettingsTile(
            icon: Icons.color_lens,
            title: AppLocalizations.of(context)!.theme,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThemePage()),
            ),
          ),
          SettingsTile(
            icon: Icons.info,
            title: AppLocalizations.of(context)!.about,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutPage()),
            ),
          ),
        ],
      ),
    );
  }
}
