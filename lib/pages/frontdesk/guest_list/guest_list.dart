import 'package:flutter/material.dart';
import 'guest_detail.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GuestList extends StatefulWidget {
  const GuestList({Key? key}) : super(key: key);

  @override
  State<GuestList> createState() => _GuestListState();
}

class Guest {
  final String name;
  final String roomNumber;
  final String roomType;
  final String bookId;
  final String status;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String roomTypeImage;

  Guest(this.name, this.roomNumber, this.roomType, this.bookId, this.status,
      this.checkInDate, this.checkOutDate, this.roomTypeImage);
}

class _GuestListState extends State<GuestList> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  late List<Guest> _initialGuests;
  bool _isSearching = false;
  List<Guest> _guests = []; // Ganti dengan daftar tamu yang diambil dari API

  DateTime?
      _selectedDate; // Tambahkan properti untuk menyimpan tanggal yang dipilih

  @override
  void initState() {
    super.initState();
    _fetchGuests(); // Panggil fungsi untuk mengambil data tamu dari API
  }

  void _fetchGuests() async {
    final response =
        await http.get(Uri.parse('http://localhost:8000/api/reservasi'));
    if (response.statusCode == 200) {
      // Respons berhasil diterima
      final List<dynamic> responseData = json.decode(response.body);
      List<Guest> guests = responseData.map((data) {
        return Guest(
            data['name'],
            data['roomNumber'],
            data['roomType'],
            data['bookId'].toString(),
            data['status'],
            DateTime.parse(data['checkInDate']),
            DateTime.parse(data['checkOutDate']),
            data['roomTypeImage']);
      }).toList();

      setState(() {
        _initialGuests = guests;
        _guests = List<Guest>.from(_initialGuests);
      });
    } else {
      // Gagal mengambil data, cetak pesan kesalahan
      print('Failed to load data: ${response.statusCode}');
    }
  }

  void _onDatePressed(DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate;
      _searchController.clear();
      _isSearching = false;

      if (_selectedDate != null) {
        // Mengatur daftar tamu yang akan di-filter
        print('Selected Date: $_selectedDate');
        List<Guest> filteredGuests = _initialGuests
            .where((guest) =>
                (_selectedDate != null &&
                    ((guest.checkInDate.year == _selectedDate!.year &&
                            guest.checkInDate.month == _selectedDate!.month &&
                            guest.checkInDate.day == _selectedDate!.day) ||
                        (guest.checkOutDate.year == _selectedDate!.year &&
                            guest.checkOutDate.month == _selectedDate!.month &&
                            guest.checkOutDate.day == _selectedDate!.day))) &&
                guest.status != 'out of order')
            .toList();

        // Menampilkan daftar tamu yang telah difilter
        _guests.clear();
        _guests.addAll(filteredGuests);
        // Print semua tamu yang telah difilter
        print('Filtered Guests:');
        filteredGuests.forEach((guest) {
          print(guest.name);
        });
      } else {
        // Jika tanggal tidak dipilih, tampilkan semua tamu
        _guests.clear();
        _guests.addAll(_initialGuests);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime firstDayOfMonth =
        DateTime(DateTime.now().year, DateTime.now().month, 1);
    DateTime lastDayOfMonth =
        DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
    int daysInMonth =
        lastDayOfMonth.day; // Mendapatkan jumlah hari dalam bulan ini
    int startingDayOfWeek = firstDayOfMonth.weekday;

// Cek apakah ada tamu yang cocok dengan filter pada tanggal tersebut
    bool hasGuestsForSelectedDate = _guests.any((guest) =>
        (_selectedDate != null &&
            (_selectedDate!.isAfter(guest.checkInDate) ||
                _selectedDate!.isAtSameMomentAs(guest.checkInDate)) &&
            (_selectedDate!.isBefore(guest.checkOutDate) ||
                _selectedDate!.isAtSameMomentAs(guest.checkOutDate))));

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Guest List')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Tambahkan fungsi untuk kembali ke layar sebelumnya
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
            icon: Icon(Icons.more_horiz), // Ikon tiga titik vertikal
            onSelected: (value) {
              // Tambahkan fungsi untuk menangani opsi yang dipilih
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Search by name or room number',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onTap: () {
                setState(() {
                  _selectedDate =
                      null; // Set _selectedDate menjadi null saat field pencarian ditekan
                  _guests.clear(); // Kosongkan _guests
                  _guests.addAll(
                      _initialGuests); // Isi _guests dengan semua data tamu awal
                });
              },
              onChanged: (value) {
                setState(() {
                  _searchText = value.toLowerCase();
                  _isSearching = true; // Mulai melakukan pencarian
                });
              },
            ),
          ),
          //untuk kalender itu
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: daysInMonth,
              itemBuilder: (context, index) {
                final TextStyle dayTextStyle = TextStyle(fontSize: 12);
                final TextStyle dateTextStyle = TextStyle(
                  fontSize: 20, // Mengubah ukuran teks angka tanggal
                  fontWeight: FontWeight
                      .bold, // Membuat teks angka tanggal menjadi bold
                );
                DateTime date = DateTime(
                    DateTime.now().year, DateTime.now().month, index + 1);
                // inkwell untuk bayangan kalender di tekan
                return InkWell(
                    splashColor:
                        Color.fromARGB(255, 117, 45, 179).withOpacity(0.5),
                    onTap: () {
                      _onDatePressed(DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        index +
                            1, // Menggunakan index + 1 untuk mendapatkan nomor hari
                      ));
                    },
                    borderRadius: BorderRadius.circular(180),
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape
                                .circle, // Mengatur bentuk menjadi bulat
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _getDayOfWeek(date.weekday), // Get day of week
                                style: dayTextStyle,
                              ),
                              Text(
                                '${date.day}', // Get day of month
                                style: dateTextStyle,
                              ),
                            ],
                          ),
                        )));
              },
            ),
          ),

          SizedBox(height: 20),
          // Pesan "Tidak Ada Tamu" jika tidak ada tamu yang cocok dengan filter pada tanggal tersebut
          if (!hasGuestsForSelectedDate && !_searchText.isEmpty)
            Center(
              child: Text(
                'Tidak Ada Tamu',
                style:
                    TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
              ),
            ),
          // Daftar tamu yang sesuai dengan filter
          // buat yg hasil pencariannya
          Expanded(
            child: ListView.builder(
              itemCount: _guests.length,
              itemBuilder: (context, index) {
                // Ambil data tamu dari _guests
                final guest = _guests[index];

                Color statusColor = Colors.grey;

                // Tentukan warna berdasarkan status
                switch (guest.status) {
                  case 'reserved':
                    statusColor = Colors.orange;
                    break;
                  case 'check in':
                    statusColor = Colors.green;
                    break;
                  case 'check out':
                    statusColor = Colors.red;
                    break;
                }

                // Cek apakah nama atau nomor kamar tamu cocok dengan _searchText
                // Ubah kondisi pencarian di sini
                if (!_isSearching ||
                    guest.name.toLowerCase().contains(_searchText) ||
                    guest.roomNumber.toLowerCase().contains(_searchText)) {
                  // Jika cocok, tampilkan data tamu tersebut dalam bentuk Card
                  return Card(
                    color: Colors.grey[200],
                    //margin: EdgeInsets.all(8.0),
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      title: Text(
                        'Room ${guest.roomNumber}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                          Text(
                            ' ${guest.name}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            ' ${guest.roomType}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 4),
                          Text(
                            ' Book ID : ${guest.bookId}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 6),
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                _capitalizeEachWord(guest.status ??
                                    ''), // Memanggil fungsi _capitalizeEachWord
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        // Navigasi ke halaman detail tamu saat ListTile ditekan
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GuestDetailPage(guest: guest),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  // Jika tidak cocok, return SizedBox untuk menyembunyikan item dari daftar
                  return SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mo';
      case 2:
        return 'Tu';
      case 3:
        return 'We';
      case 4:
        return 'Th';
      case 5:
        return 'Fr';
      case 6:
        return 'Sa';
      case 7:
        return 'Su';
      default:
        return '';
    }
  }

  String _capitalizeEachWord(String text) {
    return text.toLowerCase().replaceAllMapped(
        RegExp(r'^.|(\s|\-).'), (match) => match.group(0)!.toUpperCase());
  }
}
