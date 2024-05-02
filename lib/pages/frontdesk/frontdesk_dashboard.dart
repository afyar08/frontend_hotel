import 'package:flutter/material.dart';
import 'package:frontend_hotel/pages/frontdesk/available_status.dart';
import 'package:frontend_hotel/pages/frontdesk/guest_list.dart';
import 'package:frontend_hotel/pages/home.dart' as mainHome;
import 'package:frontend_hotel/pages/frontdesk/home.dart';
import 'package:frontend_hotel/pages/frontdesk/housekeeping.dart';
import 'package:frontend_hotel/pages/frontdesk/inhouse_guest.dart';
import 'package:frontend_hotel/pages/frontdesk/logout.dart';
import 'package:frontend_hotel/pages/frontdesk/new_booking.dart';
import 'package:frontend_hotel/pages/frontdesk/reserved_status.dart';
import 'package:frontend_hotel/pages/login/frontoffice.dart';
import 'package:http/http.dart';

void main() => runApp(const FrontDeskDashboard());

class FrontDeskDashboard extends StatelessWidget {
  const FrontDeskDashboard({super.key});

  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ini untuk login ges
  void _logout() async {
    try {
      Response response = await post(Uri.parse(
          'http://127.0.0.1:8000/api/receptionist/logout_receptionist'));

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => mainHome.Home(),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    NewBooking(),
    GuestList(),
    InHouseGuest(),
    ReservedStatus(),
    AvailableStatus(),
    HouseKeeping(),
    Logout(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('FrontOfficePro'),
            ),
            ListTile(
              leading: Icon(Icons.home_filled),
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.inventory),
              title: const Text('New Booking'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: const Text('Guest List'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.groups),
              title: const Text('In House Guest'),
              selected: _selectedIndex == 3,
              onTap: () {
                // Update the state of the app
                _onItemTapped(3);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.event_busy),
              title: const Text('Reserved Status'),
              selected: _selectedIndex == 4,
              onTap: () {
                // Update the state of the app
                _onItemTapped(4);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.event_available),
              title: const Text('Available Status'),
              selected: _selectedIndex == 5,
              onTap: () {
                // Update the state of the app
                _onItemTapped(5);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.menu_book),
              title: const Text('Housekeeping'),
              selected: _selectedIndex == 6,
              onTap: () {
                // Update the state of the app
                _onItemTapped(6);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Logout'),
              selected: _selectedIndex == 7,
              onTap: () {
                // Update the state of the app
                _logout();
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
