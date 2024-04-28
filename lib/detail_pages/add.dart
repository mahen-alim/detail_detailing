import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'home.dart';

class Add extends StatefulWidget {
  final String initialValue;

  Add({required this.initialValue});

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController carTypeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  String? selectedComplaint;
  DateTime? selectedDate;
  late List<bool> selectedDetailing;
  bool showOtherField = false;

  @override
  void initState() {
    super.initState();
    // Inisialisasi selectedDetailing berdasarkan nilai yang diterima dari halaman sebelumnya
    selectedDetailing = [false, false, false, false, false];
    if (widget.initialValue == 'Detailing Velg & Ban') {
      selectedDetailing[0] = true;
    } else if (widget.initialValue == 'Detailing Interior') {
      selectedDetailing[1] = true;
    } else if (widget.initialValue == 'Detailing Eksterior') {
      selectedDetailing[2] = true;
    } else if (widget.initialValue == 'Detailing Ruang Mesin') {
      selectedDetailing[3] = true;
    } else if (widget.initialValue == 'Detailing Kaca Mobil') {
      selectedDetailing[4] = true;
    }
  }

  Future<void> _onSubmit() async {
    try {
      // Mengubah nilai boolean dari selectedDetailing menjadi '1' jika dicentang, dan '0' jika tidak dicentang
      String selectedDetailingString = selectedDetailing
          .map((isSelected) => isSelected ? '1' : '0')
          .join(',');

      var response = await http.post(
        Uri.parse("http://192.168.48.236/latihan/note_app/create.php"),
        body: {
          "car_type": carTypeController.text,
          "complain": selectedComplaint ?? '',
          "detailing_serve": selectedDetailingString,
          "price": priceController.text,
          "date": selectedDate != null
              ? DateFormat('yyyy-MM-dd').format(selectedDate!)
              : '',
        },
      );
      var data = jsonDecode(response.body);
      print(data["message"]);

      // Navigasi ke halaman Home setelah submit berhasil
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print(e);
    }
  }

  void _onCheckboxChanged(int index, bool newValue) {
    setState(() {
      selectedDetailing[index] = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghilangkan tombol kembali
      ),
      body: SingleChildScrollView(
        reverse: false,
        child: Expanded(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              color: Colors.white, // Set background color to white
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                      'Pesan Detailing',
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
                  const SizedBox(height: 30),
                  const Text(
                    'Jenis Mobil',
                    style: TextStyle(
                      color: Colors.black, // Change text color to black
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: carTypeController,
                    decoration: InputDecoration(
                      hintText: "Masukkan Jenis Mobil",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none),
                      fillColor: const Color(0xFFEDEEEF),
                      filled: true,
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Jenis Mobil Harus Diisi!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Tanggal Pesan',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: selectedDate != null
                          ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                          : null, // Menggunakan null jika selectedDate null
                    ),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null && picked != selectedDate) {
                        setState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Masukkan Tanggal Pesan',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none),
                      fillColor: const Color(0xFFEDEEEF),
                      filled: true,
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tanggal Pesan Harus Diisi!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Keluhan',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    value: selectedComplaint,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedComplaint = newValue;
                        // Jika pengguna memilih "Lainnya", tampilkan field isian
                        showOtherField = newValue == 'Lainnya';
                      });
                    },
                    items: <String>[
                      'Bau tidak sedap',
                      'Noda membandel',
                      'Penyok atau goresan',
                      'Rusak interior',
                      'Lainnya',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      hintText: 'Pilih Keluhan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: const Color(0xFFEDEEEF),
                      filled: true,
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    dropdownColor: const Color(
                        0xFFEDEEEF), // Warna abu-abu untuk preview list
                  ),
                  if (showOtherField)
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Masukkan Keluhan Spesifik Anda',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: const Color(0xFFEDEEEF),
                          filled: true,
                        ),
                        // Tambahkan fungsi onChanged dan validasi sesuai kebutuhan
                      ),
                    ),
                  const SizedBox(height: 20),
                  const Text(
                    'Pilih Detailing',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Mapping detailing options to checkboxes
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: <Widget>[
                      for (int i = 0; i < selectedDetailing.length; i++)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Checkbox(
                              value: selectedDetailing[i],
                              onChanged: (newValue) {
                                _onCheckboxChanged(i, newValue!);
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              i == 0
                                  ? 'Velg & Ban'
                                  : i == 1
                                      ? 'Interior'
                                      : i == 2
                                          ? 'Eksterior'
                                          : i == 3
                                              ? 'Ruang Mesin'
                                              : 'Kaca Mobil',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Harga',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(
                      hintText: "",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none),
                      fillColor: const Color(0xFFEDEEEF),
                      filled: true,
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Harga Harus Diisi!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity, // Lebarkan SizedBox sejauh mungkin
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(255, 133, 119, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Konfirmasi",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        //validate
                        if (_formKey.currentState!.validate()) {
                          //send data to database with this method
                          _onSubmit();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
