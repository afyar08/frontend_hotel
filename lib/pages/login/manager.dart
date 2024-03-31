import 'package:flutter/material.dart';
import 'package:frontend_hotel/pages/registration/manager_registration.dart'; // Import halaman ManagerRegistration

class Manager extends StatefulWidget {
  const Manager({Key? key}) : super(key: key);

  @override
  State<Manager> createState() => _ManagerState();
}

class _ManagerState extends State<Manager> {
  final _formKey = GlobalKey<FormState>();
  String? _email, _password;

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      // handle login here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FrontOfficePro'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 100),
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
            SizedBox(height: 100),
            // Existing content
            GestureDetector(
              onTap: () {
                // Handle tap on existing content
              },
              child: Container(
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/images/network.png'),
                    SizedBox(height: 20),
                    Container(
                      child: Text(
                        'Manager',
                        style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Login Form
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  'Sign in',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter your email',
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return 'Please enter a valid password (at least 6 characters)';
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value,
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text('Login'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      '',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
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
