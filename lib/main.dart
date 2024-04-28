import 'dart:convert';
import 'dart:js_interop';
import 'dart:ui';
import 'package:crud_flutter/detail_detailing.dart';
import 'package:crud_flutter/detail_pages/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'detail_pages/add.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // themeMode: ThemeMode.dark,
      title: 'Detail Layanan Detailing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/detail_layanan': (context) => DetailPage(),
        '/pesan_detailing': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String;
          return Add(initialValue: args);
        },
      },
    );
  }
}

class HomePage extends StatelessWidget {
  String buttonValue = '';
  String buttonImg = '';
  // String descValue = '';
  // String benefValue = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghilangkan tombol kembali
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                          color: const Color.fromRGBO(255, 133, 119, 1),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Center(
                            child: Card(
                              color: const Color.fromRGBO(255, 133, 119, 1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Mengatur posisi ke tengah secara horizontal
                                  children: [
                                    Container(
                                      // width: 24, // Set lebar gambar
                                      // height: 24, // Set tinggi gambar
                                      child: Image.asset(
                                        'assets/bag.png', // Ganti dengan path gambar Anda
                                        fit: BoxFit
                                            .cover, // Sesuaikan gambar ke kontainer
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            8), // Spasi antara gambar dan teks
                                    const Text(
                                      'Detailing Terlaris',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildCustomButton(context, 'Detailing Velg & Ban',
                      Colors.white, 'assets/velg&ban.png'),
                  const SizedBox(height: 20),
                  _buildCustomButton(context, 'Detailing Interior',
                      Colors.white, 'assets/interior.png'),
                  const SizedBox(height: 20),
                  _buildCustomButton(context, 'Detailing Eksterior',
                      Colors.white, 'assets/eksterior.png'),
                  const SizedBox(height: 20),
                  _buildCustomButton(context, 'Detailing Ruang Mesin',
                      Colors.white, 'assets/enginebay.png'),
                  const SizedBox(height: 20),
                  _buildCustomButton(context, 'Detailing Kaca Mobil',
                      Colors.white, 'assets/kacamobil.png'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomButton(
      BuildContext context, String text, Color color, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          // Navigasi ke DetailPage dengan mengirim text sebagai argument
          Navigator.pushNamed(
            context,
            '/detail_layanan',
            arguments: {
              'title': text,
              'imagePath': imagePath,
            },
          );
        },
        child: Container(
          width: double
              .infinity, // Lebar tombol diatur agar mengisi ruang yang tersedia
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          child: Stack(
            alignment: Alignment.centerLeft, // Meletakkan gambar di kiri
            children: <Widget>[
              Image.asset(
                imagePath,
                fit: BoxFit.cover, // Gambar akan dipenuhi dalam kontainer
                width: double.maxFinite,
              ),
              Positioned(
                left: 16, // Jarak gambar dari kiri
                top: 16, // Jarak gambar dari atas
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Warna latar belakang teks
                    borderRadius: BorderRadius.circular(8), // Radius sudut
                    border: Border.all(
                      color: const Color.fromRGBO(
                          255, 133, 119, 1), // Warna border
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4), // Padding untuk kontainer teks
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Color.fromRGBO(255, 133, 119, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
