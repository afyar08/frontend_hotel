import 'package:flutter/material.dart';
import 'package:frontend_hotel/pages/home.dart';

class Home1 extends StatelessWidget {
  const Home1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/home.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 100),
                Text('Get Your Room.',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Colors.blue[800]),
                    textAlign: TextAlign.left),
                Text('Book Today.',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Colors.blue[800]),
                    textAlign: TextAlign.left),
                SizedBox(
                  height: 550,
                ),
                // button ges
                TextButton(
                  //buat next
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                    child: Container(
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      padding: EdgeInsets.fromLTRB(
                          150, 20, 150, 20), // jarak ke dalam
                      decoration: BoxDecoration(
                        color: Colors.blue[800],
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ))
              ],
            ),
          )),
    );
  }
}
