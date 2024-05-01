import 'package:flutter/material.dart';
import 'package:frontend_hotel/pages/login/customer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomerRegistration extends StatefulWidget {
  const CustomerRegistration({Key? key}) : super(key: key);

  @override
  _CustomerRegistrationState createState() => _CustomerRegistrationState();
}

class _CustomerRegistrationState extends State<CustomerRegistration> {
  bool _isChecked = false;
  String _kategori = 'ON';
  TextEditingController _namaController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _noTelpController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _register() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/guest/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nama': _namaController.text,
        'email': _emailController.text,
        'no_telp': _noTelpController.text,
        'password': _passwordController.text,
        'kategori': _kategori,
      }),
    );

    if (response.statusCode == 200) {
      _showDialog('Registrasi Berhasil', 'Registrasi berhasil!');
    } else if (response.statusCode == 422) {
      // Registrasi gagal karena validasi
      final jsonResponse = json.decode(response.body);
      final errorMessage = jsonResponse['message'];
      final validationErrors = jsonResponse['errors'];
      String errorText = 'Registrasi gagal!';
      if (validationErrors != null) {
        // Jika terdapat kesalahan validasi yang spesifik, tambahkan pesan ke errorText
        validationErrors.forEach((key, value) {
          errorText += '\n$key: $value';
        });
      } else if (errorMessage != null) {
        // Jika terdapat pesan kesalahan umum, gunakan pesan tersebut
        errorText = errorMessage;
      }
      _showDialog('Registrasi Gagal', errorText);
    } else {
      // Registrasi gagal karena alasan lain
      _showDialog('Registrasi Gagal', 'Registrasi gagal! Silakan coba lagi.');
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

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
                      text: 'Get Started!\n',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    TextSpan(
                      text: 'by creating a new account.',
                      style: TextStyle(
                        fontSize: 40,
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
                      controller:
                          _noTelpController, // Gunakan controller untuk field nomor telepon
                      decoration: InputDecoration(
                        labelText: 'Nomor Telepon', // Label field
                        labelStyle:
                            TextStyle(color: Colors.grey[600]), // Warna label
                        border: InputBorder.none, // Tidak ada border
                      ),
                    ),
                  ),
                ),
              ),
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
                        // Tambahkan logika untuk mengirimkan data registrasi
                        _register(); // Memanggil fungsi _register() saat tombol ditekan
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
                    'Already a member? ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Customer(),
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
