import 'package:flutter/material.dart';
import 'package:frontend_hotel/pages/login/customer.dart';

class CustomerRegistration extends StatefulWidget {
  const CustomerRegistration({Key? key}) : super(key: key);

  @override
  _CustomerRegistrationState createState() => _CustomerRegistrationState();
}

class _CustomerRegistrationState extends State<CustomerRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Registration'),
      ),
      body: Center(
        child: Text(
          'Hai gaesss',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
