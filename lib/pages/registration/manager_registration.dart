import 'package:flutter/material.dart';
import 'package:frontend_hotel/pages/login/manager.dart';
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

final Logger logger = Logger();

class ManagerRegistration extends StatefulWidget {
  const ManagerRegistration({Key? key}) : super(key: key);

  @override
  _ManagerRegistrationState createState() => _ManagerRegistrationState();
}

class _ManagerRegistrationState extends State<ManagerRegistration> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 100),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Register!\n',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    TextSpan(
                      text: 'your manager account.',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue[800],
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Latar belakang field
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Warna bayangan
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            Offset(0, 3), // Offset agar terlihat sedikit naik
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      //yang mengontrol inputan nama
                      controller: _namaController,
                      decoration: InputDecoration(
                        labelText: 'Nama',
                        labelStyle:
                            TextStyle(color: Colors.grey[600]), // Warna label
                        border: InputBorder.none, // Tidak ada border
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Latar belakang field
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Warna bayangan
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            Offset(0, 3), // Offset agar terlihat sedikit naik
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      //yang mengontrol inputan email
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle:
                            TextStyle(color: Colors.grey[600]), // Warna label
                        border: InputBorder.none, // Tidak ada border
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Latar belakang field
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Warna bayangan
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            Offset(0, 3), // Offset agar terlihat sedikit naik
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      //yang mengontrol inputan password
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle:
                            TextStyle(color: Colors.grey[600]), // Warna label
                        border: InputBorder.none, // Tidak ada border
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                  Text(
                    'I agree to the terms and conditions',
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                ],
              ),
              SizedBox(height: 30),
              TextButton(
                onPressed: _isChecked
                    ? () {
                        //panggil BE
                        registerManager(
                          _namaController
                              .text, // Mengambil nilai nama dari controller
                          _emailController
                              .text, // Mengambil nilai email dari controller
                          _passwordController
                              .text, // Mengambil nilai password dari controller
                        );
                      }
                    : null,
                child: Container(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  width: 345,
                  decoration: BoxDecoration(
                    color: _isChecked
                        ? Colors.blue[800]
                        : Colors
                            .grey, // Mengubah warna tombol berdasarkan status checkbox
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have an account? ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Manager(),
                        ),
                      );
                    },
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        color: Colors.blue[
                            600], // Mengubah warna teks menjadi biru biruan
                        decoration:
                            TextDecoration.underline, // Memberi garis bawah
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// sambung ke BE
Future<void> registerManager(String nama, String email, String password) async {
  final Uri uri = Uri.parse('http://127.0.0.1:8000/api/admin/create_manager');

  try {
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'nama': nama,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      // Registrasi berhasil
      // nama.clear();
      // email.clear();
      // password.clear();
      logger.d('Registrasi berhasil!');
    } else {
      // Gagal melakukan registrasi
      logger.e('Registrasi gagal: ${response.statusCode}');
      logger.e(response.body); // Tampilkan pesan kesalahan dari backend
    }
  } catch (e) {
    // Tangani kesalahan selama proses HTTP request
    logger.e('Kesalahan koneksi: $e');
  }
}
