import 'package:flutter/material.dart';
import 'package:frontend_hotel/pages/registration/manager_registration.dart'; // Import halaman ManagerRegistration

class Manager extends StatefulWidget {
  const Manager({Key? key}) : super(key: key);

  @override
  State<Manager> createState() => _ManagerState();
}

class _ManagerState extends State<Manager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manager Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigasi ke halaman ManagerRegistration ketika tombol ditekan
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ManagerRegistration()),
            );
          },
          child: Text('Go to Manager Registration'),
        ),
      ),
    );
  }
}
