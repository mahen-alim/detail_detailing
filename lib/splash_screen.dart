import 'package:flutter/material.dart';

void main() => runApp(const splash());

class splash extends StatelessWidget {
  const splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .center, // Mengatur posisi ke tengah secara horizontal
          children: [
            Container(
              // width: 24, // Set lebar gambar
              // height: 24, // Set tinggi gambar
              child: Image.asset(
                'assets/logo_eviasi.png', // Ganti dengan path gambar Anda
                fit: BoxFit.cover, // Sesuaikan gambar ke kontainer
              ),
            ),
            const SizedBox(width: 8),
            Container(
              // width: 24, // Set lebar gambar
              // height: 24, // Set tinggi gambar
              child: Image.asset(
                'assets/aa.png', // Ganti dengan path gambar Anda
                fit: BoxFit.cover, // Sesuaikan gambar ke kontainer
              ),
            ),
          ],
        ),
      ),
    );
  }
}
