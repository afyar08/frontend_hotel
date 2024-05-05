import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:frontend_hotel/pages/customer/profile.dart'; // Impor file profile.dart
import 'package:frontend_hotel/pages/customer/my_booking.dart';

class CustomerDashboard extends StatefulWidget {
  @override
  _CustomerDashboardState createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  int _currentIndex = 0;

  // Ganti teks menjadi instance dari class ProfilePage1
  final List<Widget> _tabs = [
    Center(
        child: Text('Home',
            style: TextStyle(
                fontFamily: 'Jakarta', fontWeight: FontWeight.bold))),
    Center(
        child: Text('My Booking',
            style: TextStyle(
                fontFamily: 'Jakarta', fontWeight: FontWeight.bold))),
    Center(
        child: ProfilePage1(), // Ganti teks menjadi instance dari class ProfilePage1
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            fontFamily: 'Jakarta',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false, // Menghilangkan tombol back
      ),
      body: _tabs[_currentIndex],
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
        initialActiveIndex: _currentIndex,
        onTap: (int index) {
          if (index == 1) { // When "My Booking" icon is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyBooking()),
            );
          } else if (index == 2) { // When "Profile" icon is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage1()),
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }
}
