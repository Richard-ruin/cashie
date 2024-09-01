import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cashie/providers/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
                ? Color(0xFF2B2B2B)
                : Colors.blue,
        title: Text(
          AppLocalizations.of(context)!.about,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Versi: 1.0.0',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Cashie adalah aplikasi kasir yang dirancang khusus untuk memenuhi kebutuhan bisnis Anda dalam mengelola penjualan dan inventaris secara efisien. Aplikasi ini dibuat sebagai bagian dari tugas mata kuliah Proyek 2 di Universitas Logistik & Bisnis Internasional.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Cashie hadir dengan antarmuka yang user-friendly, fitur yang fungsional, dan dirancang untuk membantu Anda dalam mencatat transaksi, mengelola produk, serta melihat riwayat penjualan dengan mudah. Versi pertama dari aplikasi ini adalah langkah awal dalam mewujudkan solusi teknologi yang sederhana namun efektif untuk usaha Anda.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Saya berharap Cashie dapat memberikan kemudahan dan efisiensi dalam mengelola bisnis Anda. Terima kasih telah menggunakan aplikasi saya!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              'Dibuat oleh:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Richard Johannes Pakpahan',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Universitas:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Universitas Logistik & Bisnis Internasional',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
