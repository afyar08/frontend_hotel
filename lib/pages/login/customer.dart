import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // for jsonEncode

import 'package:frontend_hotel/pages/password/forgotpassword.dart';
import 'package:frontend_hotel/pages/registration/customer_registration.dart';
import 'package:frontend_hotel/pages/customer/customer_dashboard.dart';

class Customer extends StatefulWidget {
  const Customer({Key? key}) : super(key: key);

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  final _formKey = GlobalKey<FormState>();
  String? _email, _password;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isEmailFilled = false;
  bool _isPasswordFilled = false;

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();

      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/guest/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Login successful
        final responseData = jsonDecode(response.body);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CustomerDashboard(),
          ),
        );
      } else {
        // Login failed
        final responseData = jsonDecode(response.body);
        _showErrorDialog();
      }
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Login Failed'),
        content: Text('Email atau password salah. Mohon coba lagi.'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  void _forgotPassword() {
    // Handle forgot password action, navigate to appropriate screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Forgotpassword(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              'to FrontOfficePro',
              style: TextStyle(fontSize: 30, color: Colors.blue[800]),
              textAlign: TextAlign.left,
            ),
            // Login Form
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Latar belakang field
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.5), // Warna bayangan
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(
                                0, 3), // Offset agar terlihat sedikit naik
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                color: Colors.grey[600]), // Warna label
                            border: InputBorder.none, // Tidak ada border
                          ),
                          onChanged: (value) {
                            setState(() {
                              _isEmailFilled = value.isNotEmpty;
                            });
                          },
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
                            color:
                                Colors.grey.withOpacity(0.5), // Warna bayangan
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(
                                0, 3), // Offset agar terlihat sedikit naik
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: Colors.grey[600]), // Warna label
                            border: InputBorder.none, // Tidak ada border
                          ),
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              _isPasswordFilled = value.isNotEmpty;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: _forgotPassword,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.blue[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  TextButton(
                    onPressed: (_isEmailFilled && _isPasswordFilled) ? _trySubmit : null,
                    child: Container(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      width: 345,
                      decoration: BoxDecoration(
                        color: (_isEmailFilled && _isPasswordFilled)
                            ? Colors.blue[800]
                            : Colors.grey, // Mengubah warna tombol berdasarkan status pada checkbox
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New member? ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomerRegistration(),
                            ),
                          );
                        },
                        child: Text(
                          'Register now',
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
          ],
        ),
      ),
    );
  }
}
