import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:frontend_hotel/pages/customer/profile.dart';
import 'package:frontend_hotel/pages/customer/customer_dashboard.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({Key? key}) : super(key: key);

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Booking',
          style: TextStyle(
            fontFamily: 'Jakarta',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false, // Menghilangkan tombol back
      ),
      body: Center(
        child: Text('My booking'),
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.white,
        style: TabStyle.reactCircle,
        color: Colors.blueGrey,
        activeColor: Color(0xFF4C4DDC),
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.bookmark_add, title: 'My Booking'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        initialActiveIndex: 1,
        onTap: (int index) {
          if (index == 0) { // Ketika ikon "Home" ditekan
            // Navigasi ke halaman CustomerDashboard
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CustomerDashboard()),
            );
          } else if (index == 2) { // Ketika ikon "Profile" ditekan
            // Navigasi ke halaman ProfilePage1
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage1()),
            );
          } else {
            // Ganti ke halaman yang sesuai
            
          }
        },
      ),
    );
  }
}
