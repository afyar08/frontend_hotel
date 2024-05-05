import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:frontend_hotel/pages/customer/profile.dart';
import 'package:frontend_hotel/pages/customer/my_booking.dart';


class CustomerDashboard extends StatefulWidget {
  @override
  _CustomerDashboardState createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    Center(child: Text('Home', style: TextStyle(fontFamily: 'Jakarta', fontWeight: FontWeight.bold))),
    Center(child: Text('My Booking', style: TextStyle(fontFamily: 'Jakarta', fontWeight: FontWeight.bold))),
    Center(child: Text('Profile', style: TextStyle(fontFamily: 'Jakarta', fontWeight: FontWeight.bold))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        title: Text(
          'Home',
          style: TextStyle(
            fontFamily: 'Jakarta',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.list_rounded),
          )
        ],
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
          if (index == 2) { // Ketika ikon "Profile" ditekan
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