import 'package:flutter/material.dart';

class Frontoffice extends StatefulWidget {
  const Frontoffice({super.key});

  @override
  State<Frontoffice> createState() => _FrontofficeState();
}

class _FrontofficeState extends State<Frontoffice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 100),
            Text('Welcome!',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.blue[800]),
                textAlign: TextAlign.left),
            Text(
              'to FrontOfficePro',
              style: TextStyle(fontSize: 30, color: Colors.blue[800]),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 50),
            // ini yang tampilan login costumer
            Container(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/images/receptionist.png'),
                  SizedBox(height: 20),
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
            SizedBox(height: 30),
            Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Receptionist ID',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            TextButton(
                //buat next
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => () ),
                  // );
                },
                child: Container(
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  width: 345, // jarak ke dalam
                  decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
