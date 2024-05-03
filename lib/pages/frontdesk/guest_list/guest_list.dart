import 'package:flutter/material.dart';
import 'guest_detail.dart'; // Pastikan file guest_detail.dart diimpor

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

  Guest(this.name, this.roomNumber, this.roomType, this.bookId, this.status,
      this.checkInDate, this.checkOutDate);
}

class _GuestListState extends State<GuestList> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  late List<Guest> _initialGuests;

  // Data dummy untuk daftar tamu
  List<Guest> _guests = [
    Guest('John Doe', '101', '2 Twin Classic', 'BOOK ID : 12345', 'reserved',
        DateTime(2024, 5, 1), DateTime(2024, 5, 2)),
    Guest('Jane Smith', '102', 'King Suite', 'BOOK ID : 54321', 'check in',
        DateTime(2024, 5, 2), DateTime(2024, 5, 3)),
    Guest('Alice Johnson', '103', 'Double Room', 'BOOK ID : 98765', 'reserved',
        DateTime(2024, 5, 3), DateTime(2024, 5, 4)),
    Guest('Bob Brown', '104', 'Standard Room', 'BOOK ID : 13579', 'check out',
        DateTime(2024, 5, 6), DateTime(2024, 5, 7)),
    Guest('Emma Lee', '105', '2 Twin Classic', 'BOOK ID : 24680', 'reserved',
        DateTime(2024, 5, 7), DateTime(2024, 5, 8)),
    Guest('Michael Davis', '106', 'King Suite', 'BOOK ID : 11223', 'check in',
        DateTime(2024, 5, 8), DateTime(2024, 5, 9)),
    Guest('Sarah Wilson', '107', 'Double Room', 'BOOK ID : 33445', 'check out',
        DateTime(2024, 5, 5), DateTime(2024, 5, 10)),
  ];

  DateTime?
      _selectedDate; // Tambahkan properti untuk menyimpan tanggal yang dipilih

  void initState() {
    super.initState();
    // Menginisialisasi _initialGuests dengan salinan dari _guests
    _initialGuests = List<Guest>.from(_guests);
  }

  void _onDatePressed(DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate;
      // Memfilter daftar tamu sesuai dengan tanggal yang dipilih
      _guests.clear();
      _guests.addAll(_initialGuests.where((guest) =>
          (_selectedDate!.isAfter(guest.checkInDate) ||
              _selectedDate!.isAtSameMomentAs(guest.checkInDate)) &&
          _selectedDate!.isBefore(guest.checkOutDate)));
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
              onChanged: (value) {
                setState(() {
                  _searchText = value.toLowerCase();
                });
              },
            ),
          ),
          //untuk kalender itu
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: daysInMonth,
              itemBuilder: (context, index) {
                final TextStyle dayTextStyle = TextStyle(fontSize: 12);
                final TextStyle dateTextStyle = TextStyle(fontSize: 16);
                DateTime date = DateTime(
                    DateTime.now().year, DateTime.now().month, index + 1);
                // inkwell untuk bayangan kalender di tekan
                return InkWell(
                    splashColor:
                        Colors.purple, // Warna bayangan ketika item ditekan
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      _onDatePressed(DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        index +
                            1, // Menggunakan index + 1 untuk mendapatkan nomor hari
                      ));
                    },
                    child: Container(
                      width: 80,
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                    ));
              },
            ),
          ),
          // Pesan "Tidak Ada Tamu" jika tidak ada tamu yang cocok dengan filter pada tanggal tersebut
          if (!hasGuestsForSelectedDate)
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

                // Filter tamu berdasarkan tanggal yang dipilih
                if (_selectedDate != null &&
                    (_selectedDate!.isAfter(guest.checkInDate) ||
                        _selectedDate!.isAtSameMomentAs(guest.checkInDate)) &&
                    (_selectedDate!.isBefore(guest.checkOutDate) ||
                        _selectedDate!.isAtSameMomentAs(guest.checkOutDate)))
                // Cek apakah nama atau nomor kamar tamu cocok dengan _searchText
                if (guest.name.toLowerCase().contains(_searchText) ||
                    guest.roomNumber.toLowerCase().contains(_searchText)) {
                  // Jika cocok, tampilkan data tamu tersebut dalam bentuk Card
                  return Card(
                    color: Colors.grey[200],
                    margin: EdgeInsets.all(8.0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      title: Text(guest.name),
                      subtitle: Text('Room ${guest.roomNumber}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              guest.status,
                              style: TextStyle(color: Colors.white),
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
}
