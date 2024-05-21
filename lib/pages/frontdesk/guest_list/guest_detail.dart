import 'package:flutter/material.dart';
import 'guest_list.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GuestDetail {
  final String duration;
  final int roomTotal;
  final int adult;
  final int children;
  final double extra;
  final double subTotal;

  GuestDetail(this.duration, this.roomTotal, this.adult, this.children,
      this.extra, this.subTotal);
}

class GuestDetailPage extends StatefulWidget {
  final Guest guest;

  const GuestDetailPage({Key? key, required this.guest}) : super(key: key);

  @override
  _GuestDetailPageState createState() => _GuestDetailPageState();
}

class _GuestDetailPageState extends State<GuestDetailPage> {
  late GuestDetail _guestDetail;

  @override
  void initState() {
    super.initState();
    _fetchGuestDetail();
  }

  Future<void> _fetchGuestDetail() async {
    final bookId = widget.guest.bookId;
    print('Fetching details for bookId: $bookId'); // Log bookId yang diambil
    final url = Uri.parse(
        'https://9236-182-253-124-170.ngrok-free.app/api/reservasi/$bookId');

    try {
      final response = await http.get(url);
      print('GET request made to: $url'); // Log URL yang diambil
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          _guestDetail = GuestDetail(
            responseData['duration'],
            responseData['room_total'],
            responseData['adult'],
            responseData['children'],
            double.parse(responseData['extra']),
            double.parse(responseData['sub_total']),
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
        title: Center(child: Text('Guest List')),
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
                // Tambahkan foto di sini
                Container(
                  width: 100, // Atur lebar foto
                  height: 100, // Atur tinggi foto
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.0),
                    // image: DecorationImage(
                    //   image: NetworkImage(
                    //       'URL_FOTO'), // Ganti dengan URL foto dari database
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  // Tambahkan placeholder teks jika foto belum tersedia
                  child: Center(
                    child: Text(
                      'No Photo',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(width: 16.0), // Jarak antara foto dan teks
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
                  Text(
                    DateFormat('dd MMMM yyyy').format(widget.guest.checkInDate),
                  ), // Menampilkan nilai guest.checkInDate
                  SizedBox(height: 8),
                  Text(
                    'Guest',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    _guestDetail!.duration,
                  ), // Menampilkan nilai guest.checkInDate
                  SizedBox(height: 8), // bold and larger font size
                  Text(
                    'Room plan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    DateFormat('dd MMMM yyyy').format(widget.guest.checkInDate),
                  ), // Menampilkan nilai guest.checkInDate
                  SizedBox(height: 8), // bold and larger font size
                  Text(
                    'Status',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    widget.guest.status,
                  ),
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
                  Text(
                    DateFormat('dd MMMM yyyy')
                        .format(widget.guest.checkOutDate),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Room type',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    widget.guest.roomType,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Room number',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    widget.guest.roomNumber,
                  ),
                  SizedBox(height: 8),
                  Text('Reservation by',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text(
                    widget.guest.roomNumber,
                  ),
                  SizedBox(height: 8), // bold and larger font size
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
                Text(
                  DateFormat('dd MMMM yyyy').format(widget.guest.checkOutDate),
                ),
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
                      // Bagian atas
                      Text(
                        'Booking Summary',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                          height:
                              4.0), // Jarak antara subjudul dan teks pertama
                      // Bagian bawah (teks)
                      Row(
                        children: [
                          // Column 1 (kiri)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height:
                                        4.0), // Jarak antara subjudul dan teks pertama
                                Text('Room Total (${_guestDetail.roomTotal})'),
                                SizedBox(height: 4),
                                Text('Extras (${_guestDetail.extra})'),
                                SizedBox(height: 14),
                                Text('Subtotal (${_guestDetail.subTotal})'),
                                SizedBox(height: 4),
                                Text('Discount'),
                                SizedBox(height: 4),
                                Text('Fixed Amount Taxes'),
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
                          // Spacer untuk memberikan jarak antara dua kolom
                          SizedBox(width: 20),
                          // Column 2 (kanan)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                    height:
                                        4), // Jarak antara subjudul dan teks pertama
                                Text(
                                    '${_guestDetail.roomTotal}'), // Teks kosong untuk kolom kanan
                                SizedBox(height: 4),
                                Text(
                                    '${_guestDetail.extra}'), // Teks kosong untuk kolom kanan
                                SizedBox(height: 14),
                                Text(
                                    '${_guestDetail.subTotal}'), // Teks kosong untuk kolom kanan
                                SizedBox(height: 4),
                                Text('4'), // Teks kosong untuk kolom kanan
                                SizedBox(height: 4),
                                Text('5'), // Teks kosong untuk kolom kanan
                                SizedBox(height: 4),
                                Text(
                                  '6',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.red,
                                  ),
                                ) // Teks kosong untuk kolom kanan
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
