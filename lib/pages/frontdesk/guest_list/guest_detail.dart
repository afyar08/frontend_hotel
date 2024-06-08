import 'package:flutter/material.dart';
import 'guest_list.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class GuestDetailPage extends StatefulWidget {
  final Guest guest;

  const GuestDetailPage({Key? key, required this.guest}) : super(key: key);

  @override
  _GuestDetailPageState createState() => _GuestDetailPageState();
}

class GuestDetail {
  final String room_plan;
  final String reservation_by;
  final String request;
  final String duration;
  final int roomTotal;
  final int adult;
  final int children;
  final double extra;
  final double subTotal;
  final double harga_per_kamar;

  GuestDetail(
      this.room_plan,
      this.reservation_by,
      this.request,
      this.duration,
      this.roomTotal,
      this.adult,
      this.children,
      this.extra,
      this.subTotal,
      this.harga_per_kamar);
}

class _GuestDetailPageState extends State<GuestDetailPage> {
  GuestDetail? _guestDetail;
  NumberFormat rupiahFormat =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
  @override
  void initState() {
    super.initState();
    _fetchGuestDetail();
  }

  Future<void> _fetchGuestDetail() async {
    final bookId = widget.guest.bookId;
    print('Fetching details for bookId: $bookId'); // Log bookId yang diambil
    final url = Uri.parse('http://localhost:8000/api/reservasi/$bookId');

    try {
      final response = await http.get(url);
      print('GET request made to: $url'); // Log URL yang diambil
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          _guestDetail = GuestDetail(
            responseData['room_plan'],
            responseData['reservation_by'],
            responseData['request'],
            responseData['duration'],
            responseData['room_total'],
            responseData['adult'],
            responseData['children'],
            double.parse(responseData['extra']),
            double.parse(responseData['sub_total']),
            double.parse(responseData['harga_per_kamar']),
          );
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
        title: Text('Guest List'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0),
            ),
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: widget.guest.roomTypeImage.isNotEmpty
                      ? Image.network(
                          widget.guest.roomTypeImage,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Text(
                            'No Photo',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${widget.guest.roomType}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '${widget.guest.name}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Book ID: ${widget.guest.bookId}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Check in',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  _guestDetail != null
                      ? Text(
                          DateFormat('dd MMMM yyyy')
                              .format(widget.guest.checkInDate),
                        )
                      : CircularProgressIndicator(),
                  SizedBox(height: 8),
                  Text(
                    'Guest',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  _guestDetail != null
                      ? Text(
                          '${_guestDetail!.adult} Adult, ${_guestDetail!.children} Children')
                      : CircularProgressIndicator(),
                  SizedBox(height: 8),
                  Text(
                    'Room plan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  _guestDetail != null
                      ? Text('${_guestDetail!.room_plan}')
                      : CircularProgressIndicator(),
                  SizedBox(height: 8),
                  Text(
                    'Status',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  _guestDetail != null
                      ? Text(
                          widget.guest.status,
                        )
                      : CircularProgressIndicator(),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Check out',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  _guestDetail != null
                      ? Text(
                          DateFormat('dd MMMM yyyy')
                              .format(widget.guest.checkOutDate),
                        )
                      : CircularProgressIndicator(),
                  SizedBox(height: 8),
                  Text(
                    'Room type',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  _guestDetail != null
                      ? Text(
                          widget.guest.roomType,
                        )
                      : CircularProgressIndicator(),
                  SizedBox(height: 8),
                  Text(
                    'Room number',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  _guestDetail != null
                      ? Text(
                          widget.guest.roomNumber,
                        )
                      : CircularProgressIndicator(),
                  SizedBox(height: 8),
                  Text('Reservation by',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  _guestDetail != null
                      ? Text('${_guestDetail!.reservation_by}')
                      : CircularProgressIndicator(),
                  SizedBox(height: 8),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Guest Comment/Request',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold)), // bold and larger font size
                _guestDetail != null
                    ? Text('${_guestDetail!.request}')
                    : CircularProgressIndicator(),
                SizedBox(height: 8),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: double.infinity,
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
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4.0),
                                Text(
                                    'Room Total (${_guestDetail?.roomTotal ?? "Loading..."})'),
                                SizedBox(height: 4),
                                Text(
                                  'Duration: ', // Duration
                                ),
                                SizedBox(height: 4),
                                Text('Extras '),
                                SizedBox(height: 14),
                                Text('Subtotal '),
                                SizedBox(height: 4),
                                Text(
                                    'Discount: '), // Assuming discount is not provided
                                SizedBox(height: 4),
                                Text(
                                    'Fixed Amount Taxes: '), // Assuming taxes are not provided
                                SizedBox(height: 4),
                                Text(
                                  'Total',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(height: 4),
                                _guestDetail != null
                                    ? Text(
                                        rupiahFormat.format(
                                            _guestDetail?.harga_per_kamar ?? 0),
                                      )
                                    : Text('Loading...'), // price per room
                                SizedBox(height: 4),
                                _guestDetail != null
                                    ? Text(
                                        '${_guestDetail?.duration ?? "Loading..."} days')
                                    : Text('Loading...'), // price per room
                                SizedBox(height: 4),
                                _guestDetail != null
                                    ? Text(
                                        rupiahFormat
                                            .format(_guestDetail?.extra ?? 0),
                                      )
                                    : Text('Loading...'), // additional charges
                                SizedBox(height: 14),
                                _guestDetail != null
                                    ? Text(
                                        rupiahFormat.format(
                                            _guestDetail?.subTotal ?? 0),
                                      )
                                    : Text(
                                        'Loading...'), // total before discounts and taxes
                                SizedBox(height: 4),
                                Text('0'), // Assuming no discount
                                SizedBox(height: 4),
                                Text('0'), // Assuming no taxes
                                SizedBox(height: 4),
                                _guestDetail != null
                                    ? Text(
                                        rupiahFormat.format(
                                            _guestDetail?.subTotal ??
                                                0), // final total
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.red,
                                        ))
                                    : Text('Loading...',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.red,
                                        ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
