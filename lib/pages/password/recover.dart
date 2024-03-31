import 'package:flutter/material.dart';

class Recover extends StatefulWidget {
  const Recover({Key? key}) : super(key: key);

  @override
  _RecoverState createState() => _RecoverState();
}

class _RecoverState extends State<Recover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 225),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/images/approved.png'),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We have sent a password recover intructions to your email',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 0, 0, 1),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Did not recive the email? check you spam filter or resend',
              style: TextStyle(fontSize: 13, color: Color(0xFF8F8F8F)),
              textAlign: TextAlign.center,
            ),
            // Add the TextFormField here
          ],
        ),
      ),
    );
  }
}
