import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

import '../frontdesk/frontdesk_dashboard.dart';

class Frontoffice extends StatefulWidget {
  const Frontoffice({Key? key}) : super(key: key);

  @override
  State<Frontoffice> createState() => _FrontofficeState();
}

class _FrontofficeState extends State<Frontoffice> {
  final _formKey = GlobalKey<FormState>();
  String? _email, _password, _errorMessage;
  bool _isEmailFilled = false;
  bool _isPasswordFilled = false;

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      try {
        Response response = await post(
            Uri.parse(
                'http://127.0.0.1:8000/api/receptionist/auth_receptionist'),
            body: {'username': _email, 'password': _password});

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body.toString());
          // print(data.success['token']);
          print('Login successfully');
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    FrontDeskDashboard()), // Replace NextScreen() with the name of the screen you want to navigate to
          );
        } else if (response.statusCode == 401) {
          setState(() {
            _errorMessage = ('Username or Password Wrong!');
          });
        } else {
          setState(() {
            _errorMessage = "error";
          });
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              'to FrontOfficePro',
              style: TextStyle(fontSize: 20, color: Colors.blue[800]),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 40),
            // Existing content
            Container(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/images/receptionist.png'),
                  SizedBox(height: 18),
                  Container(
                    child: Text(
                      'Front Desk',
                      style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.all(7), // jarak ke dalam
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  )
                ],
              ),
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              alignment: Alignment.center,
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                      width: 1.0, color: Colors.grey.withOpacity(0.5)),
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)]),
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
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(
                                color: Colors.grey[600]), // Warna label
                            border: InputBorder.none, // Tidak ada border
                          ),
                          onSaved: (value) {
                            _email = value; // Save the value to _email variable
                          },
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
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: Colors.grey[600]), // Warna label
                            border: InputBorder.none, // Tidak ada border
                          ),
                          obscureText: true,
                          onSaved: (value) {
                            _password =
                                value; // Save the value to _email variable
                          },
                          onChanged: (value) {
                            setState(() {
                              _isPasswordFilled = value.isNotEmpty;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  if (_errorMessage != null)
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 22, 0, 0),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextButton(
                    onPressed: (_isEmailFilled && _isPasswordFilled)
                        ? _trySubmit
                        : null,
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
                            : Colors
                                .grey, // Mengubah warna tombol berdasarkan status checkbox
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
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
