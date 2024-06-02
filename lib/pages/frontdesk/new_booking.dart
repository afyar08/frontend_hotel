import 'package:flutter/material.dart';
import 'package:frontend_hotel/pages/frontdesk//booking/group.dart';
import 'package:frontend_hotel/pages/frontdesk//booking/individual.dart';

class NewBooking extends StatefulWidget {
  const NewBooking({Key? key}) : super(key: key);

  @override
  State<NewBooking> createState() => _NewBookingState();
}

class _NewBookingState extends State<NewBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Center(
        child: Container(
          width: 300, // Lebar kotak
          height :300,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFE5F1FF), // Warna latar belakang kotak
            borderRadius: BorderRadius.circular(10), // Mengatur sudut kotak
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'New Booking', // Teks "New Booking" di sini
                style: TextStyle(
                  fontFamily: 'Jakarta',
                  fontWeight: FontWeight.bold,
                  fontSize: 24, // Atur ukuran font sesuai kebutuhan
                ),
              ),
              SizedBox(height: 32), // Spacer untuk memberikan jarak antara judul dan tombol
              // Tombol Individual dan Group/Company tetap di sini
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IndividualBooking()),
                  );
                },
                heroTag: 'IndividualBooking',
                elevation: 0,
                backgroundColor: Color(0xFF4C4DDC),
                label: Text(
                  "Individual",
                  style: TextStyle(
                    fontFamily: 'Jakarta',
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Mengubah warna teks
                  ),
                ),
                icon: Icon(
                  Icons.person,
                  color: Colors.white, // Mengubah warna ikon
                ),
              ),
              SizedBox(height: 16), // Spacer untuk memberikan jarak antara kedua button
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GroupBooking()),
                  );
                },
                heroTag: 'GroupBooking',
                elevation: 0,
                backgroundColor: Color(0xFF4C4DDC),
                label: Text(
                  "Group/Company",
                  style: TextStyle(
                    fontFamily: 'Jakarta',
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Mengubah warna teks
                  ),
                ),
                icon: Icon(
                  Icons.group,
                  color: Colors.white, // Mengubah warna ikon
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Posisi floating action button di tengah halaman
    );
  }
}
