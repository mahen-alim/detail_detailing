import 'dart:js_interop';
import 'dart:ui';
import 'package:crud_flutter/detail_pages/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'detail_pages/add.dart';

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
                                      'Detail Detailing',
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
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/aa.png',
              width: 500,
              height: 500,
              fit: BoxFit.cover,
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

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String title = args['title']!;
    final String imagePath = args['imagePath']!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghilangkan tombol kembali
      ),
      body: SingleChildScrollView(
        reverse: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10), // Tambahkan padding di sini
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Posisikan widget Row di tengah
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15.0), // Atur sudut radius sesuai kebutuhan
                            side: const BorderSide(
                              color: Color.fromRGBO(
                                  255, 133, 119, 1), // Warna border
                              width: 2.0, // Ketebalan border
                            ),
                          ),
                          color: Colors.white, // Warna background
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Image.asset(
                                    'assets/bag.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  title,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(
                                        255, 133, 119, 1), // Warna teks
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
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  imagePath,
                  width: 100,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Deskripsi:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      const Text(
                        'Interior detailing adalah proses pembersihan dan perawatan dalam kendaraan untuk menjaga kebersihan, keamanan, dan kenyamanan penggunanya. Ini melibatkan pembersihan mendalam dari setiap bagian interior kendaraan, termasuk kursi, karpet, panel pintu, konsol, jok, dan area lainnya. Selama proses interior detailing, berbagai teknik dan produk pembersih khusus digunakan untuk menghilangkan debu, kotoran, noda, dan bau yang menempel pada permukaan interior kendaraan. Ini bisa meliputi vakum, pembersihan kering, pembersihan basah, penghilangan noda, dan perlindungan permukaan.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Manfaat:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      const Text(
                        'Kebersihan: Interior detailing membantu menjaga kebersihan dan higienitas kendaraan dengan menghilangkan debu, kotoran, dan bakteri yang menumpuk di dalamnya. Kenyamanan: Kendaraan yang bersih dan segar dari interior detailing menciptakan lingkungan yang nyaman untuk pengemudi dan penumpang. Kesehatan: Menghilangkan kotoran dan bakteri dari interior kendaraan juga dapat berkontribusi pada kesehatan pengemudi dan penumpang dengan mengurangi risiko alergi dan penyakit. Estetika: Interior detailing membantu menjaga penampilan dan nilai estetika kendaraan dengan merawat material interior dan menjaga kebersihan permukaannya. Nilai Mobil: Dengan merawat interior kendaraan secara teratur, Anda dapat mempertahankan nilai jual mobil yang tinggi karena interior yang terawat dengan baik memberikan kesan yang positif kepada calon pembeli.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Harga:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      const Text(
                        'Rp 200.000',
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Durasi Pengerjaan:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      const Text(
                        '2 jam',
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Hasil Detailing',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Ulasan:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(255, 133, 119, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Pesan",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/pesan_detailing',
                          arguments: title,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
