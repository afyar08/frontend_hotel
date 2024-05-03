import 'package:flutter/material.dart';
import 'guest_list.dart';

class GuestDetailPage extends StatelessWidget {
  final Guest guest;

  const GuestDetailPage({Key? key, required this.guest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guest Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${guest.name}'),
            Text('Room Number: ${guest.roomNumber}'),
            // Tambahkan detail tamu lainnya sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}
