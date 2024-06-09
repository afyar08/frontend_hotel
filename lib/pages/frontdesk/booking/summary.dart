import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(BookingSummary());
}

class BookingSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking Summary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookingSummaryApp(bookId: '12345'),
    );
  }
}

class BookingSummaryApp extends StatefulWidget {
  final String bookId;

  const BookingSummaryApp({Key? key, required this.bookId}) : super(key: key);

  @override
  _BookingSummaryState createState() => _BookingSummaryState();
}

class GuestDetail {
  final int roomTotal;
  final String duration;
  final double extra;
  final double subTotal;
  final double hargaPerKamar;

  GuestDetail({
    required this.roomTotal,
    required this.duration,
    required this.extra,
    required this.subTotal,
    required this.hargaPerKamar,
  });

  factory GuestDetail.fromJson(Map<String, dynamic> json) {
    return GuestDetail(
      roomTotal: json['room_total'],
      duration: json['duration'],
      extra: double.parse(json['extra']),
      subTotal: double.parse(json['sub_total']),
      hargaPerKamar: double.parse(json['harga_per_kamar']),
    );
  }
}

class _BookingSummaryState extends State<BookingSummaryApp> {
  GuestDetail? _guestDetail;
  NumberFormat rupiahFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');

  @override
  void initState() {
    super.initState();
    _fetchGuestDetail();
  }

  Future<void> _fetchGuestDetail() async {
    final url = Uri.parse('http://localhost:8000/api/reservasi/${widget.bookId}');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          _guestDetail = GuestDetail.fromJson(responseData);
        });
      } else {
        throw Exception('Failed to fetch guest detail');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Summary'),
      ),
      body: _guestDetail == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking Summary',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Room Total: ${_guestDetail!.roomTotal}'),
                              SizedBox(height: 8),
                              Text('Duration: ${_guestDetail!.duration} days'),
                              SizedBox(height: 8),
                              Text('Extras: ${rupiahFormat.format(_guestDetail!.extra)}'),
                              SizedBox(height: 8),
                              Text('Subtotal: ${rupiahFormat.format(_guestDetail!.subTotal)}'),
                              SizedBox(height: 8),
                              Text('Discount: 0'), // Assuming no discount
                              SizedBox(height: 8),
                              Text('Fixed Amount Taxes: 0'), // Assuming no taxes
                              SizedBox(height: 16),
                              Text(
                                'Total: ${rupiahFormat.format(_guestDetail!.subTotal)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
