import 'package:flutter/material.dart';
import 'package:frontend_hotel/pages/password/recover.dart'; // Pastikan Anda mengimpor recover.dart

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({Key? key}) : super(key: key);

  @override
  _ForgotpasswordState createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  bool _isEmailFilled = false;

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
            Container(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/images/lock.png'),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Forgot your password?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 0, 0, 1),
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Text(
              'Enter your registered email below to receive password reset instruction',
              style: TextStyle(fontSize: 13, color: Color(0xFF8F8F8F)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter your email',
                      labelStyle: TextStyle(color: Colors.grey[600]),
                      border: InputBorder.none,
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
            TextButton(
              onPressed: (_isEmailFilled)
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Recover(),
                        ),
                      );
                    }
                  : null,
              child: Container(
                child: Text(
                  'Send',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                width: 345,
                decoration: BoxDecoration(
                  color: (_isEmailFilled) ? Colors.blue[800] : Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Remember your password? ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Implement logic for navigating to login page
                  },
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.blue[600],
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
