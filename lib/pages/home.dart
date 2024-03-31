import 'package:flutter/material.dart';
import 'package:frontend_hotel/pages/login/frontoffice.dart';
import './login/customer.dart';
import './login/manager.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            GestureDetector(
              // ini pas pencet costomer
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Customer()),
                );
              },
              child: Container(
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/images/family.png'),
                    SizedBox(height: 20),
                    Container(
                      child: Text(
                        'Customer',
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
            ),
            SizedBox(height: 20),
            // ini yang tampilan login Manajer
            GestureDetector(
              // ini pas pencet costomer
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Manager()),
                );
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
            ),
            SizedBox(height: 20),
            // ini yang tampilan login Front Desk
            GestureDetector(
              // ini pas pencet costomer
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Frontoffice()),
                );
              },
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
