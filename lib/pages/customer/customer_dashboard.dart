import 'package:flutter/material.dart';

class CustomerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Dashboard'),
      ),
      body: Center(
        child: Text(
          'Hello, World!',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
