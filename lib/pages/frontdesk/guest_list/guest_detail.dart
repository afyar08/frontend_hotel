import 'package:flutter/material.dart';
import 'guest_list.dart';
import 'package:intl/intl.dart';

class GuestDetailPage extends StatelessWidget {
  final Guest guest;

  const GuestDetailPage({Key? key, required this.guest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookId = guest.bookId; // Simpan id book di variabel
    // Print bookId di sini
    print('Book ID: $bookId');

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Guest List')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: Text('Option 1'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Option 2'),
                value: 2,
              ),
              PopupMenuItem(
                child: Text('Option 3'),
                value: 3,
              ),
            ],
            icon: Icon(Icons.more_horiz),
            onSelected: (value) {
              // Handle selected option
            },
          )
        ],
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
                        '${guest.roomType}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '${guest.name}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Book ID: ${guest.bookId}',
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
                    DateFormat('dd MMMM yyyy').format(guest.checkInDate),
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
                    DateFormat('dd MMMM yyyy').format(guest.checkInDate),
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
                    DateFormat('dd MMMM yyyy').format(guest.checkInDate),
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
                    guest.status,
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
                    DateFormat('dd MMMM yyyy').format(guest.checkOutDate),
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
                    guest.roomType,
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
                    guest.roomNumber,
                  ),
                  SizedBox(height: 8),
                  Text('Reservation by',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text(
                    //
                    guest.roomNumber,
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
                  DateFormat('dd MMMM yyyy').format(guest.checkOutDate),
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
                                Text('Room Total ( )'),
                                SizedBox(height: 4),
                                Text('Extras'),
                                SizedBox(height: 14),
                                Text('Subtotal'),
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
                                Text('1'), // Teks kosong untuk kolom kanan
                                SizedBox(height: 4),
                                Text('2'), // Teks kosong untuk kolom kanan
                                SizedBox(height: 14),
                                Text('3'), // Teks kosong untuk kolom kanan
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
