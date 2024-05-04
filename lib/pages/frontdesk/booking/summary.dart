import 'package:flutter/material.dart';

class BookingSummary extends StatelessWidget {
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
          'Booking Summary',
          style: TextStyle(
            fontFamily: 'Jakarta',
            fontWeight: FontWeight.bold, // Medium
            fontSize: 18, // Ukuran font yang Anda inginkan
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
      body: Center(
        child: Text(
          'buat Booking summary',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BookingSummary(),
  ));
}
