import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend_hotel/pages/frontdesk/reserved/change_status_dialog.dart';

class ReservedRooms extends StatefulWidget {
  const ReservedRooms({Key? key}) : super(key: key);

  @override
  State<ReservedRooms> createState() => _ReservedRoomsState();
}

class Room {
  final int id;
  final String status_kamar;
  final String status_reservasi;
  final double harga;
  final String no_kamar;
  final String roomType;

  Room({
    required this.id,
    required this.status_kamar,
    required this.status_reservasi,
    required this.harga,
    required this.no_kamar,
    required this.roomType,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      status_kamar: json['status_kamar'],
      status_reservasi: json['status_reservasi'],
      harga: double.parse(json['harga']),
      no_kamar: json['no_kamar'],
      roomType: json['tipe_kamar']['nama_tipe'],
    );
  }
}

class _ReservedRoomsState extends State<ReservedRooms> {
  bool _isSearching = false;
  List<Room> _initialRooms = [];
  List<Room> _rooms = [];

  @override
  void initState() {
    super.initState();
    fetchRooms();
  }

  Future<void> fetchRooms() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:8000/api/kamar'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _initialRooms = data.map((json) => Room.fromJson(json)).toList();
          _rooms = _initialRooms
              .where((room) =>
                  room.status_reservasi == 'reserved' ||
                  room.status_reservasi == 'check in')
              .toList();
          _rooms.sort((a, b) =>
              a.no_kamar.compareTo(b.no_kamar)); // Sorting rooms by no_kamar
        });
      } else {
        throw Exception('Failed to load rooms');
      }
    } catch (e) {
      print('Error fetching rooms: $e');
    }
  }

  void updateSearch(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        _isSearching = false;
        _rooms = _initialRooms
            .where((room) =>
                room.status_reservasi == 'reserved' ||
                room.status_reservasi == 'check in')
            .toList();
        _rooms.sort((a, b) =>
            a.no_kamar.compareTo(b.no_kamar)); // Sorting rooms by no_kamar
      } else {
        _isSearching = true;
        _rooms = _initialRooms
            .where((room) =>
                room.no_kamar.toLowerCase().contains(searchText) &&
                (room.status_reservasi == 'reserved' ||
                    room.status_reservasi == 'check in'))
            .toList();
        _rooms.sort((a, b) =>
            a.no_kamar.compareTo(b.no_kamar)); // Sorting rooms by no_kamar
      }
    });
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'reserved':
        return Colors.red;
      case 'check in':
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  void _showChangeStatusDialog(
      int roomId, String roomNumber, String roomType) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ChangeStatusDialog(
          roomId: roomId,
          roomNumber: roomNumber,
          roomType: roomType,
          onUpdateStatus: (success) {
            if (success) {
              // Refresh daftar kamar setelah status berhasil diperbarui
              fetchRooms();
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Reserved Rooms')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Add navigation to the previous screen here
          },
        ),
      ),
      body: Column(
        children: [
          SearchInput(onSearchChanged: updateSearch),
          Expanded(
            child: ListView.builder(
              itemCount: _rooms.length,
              itemBuilder: (context, index) {
                final room = _rooms[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Room ${room.no_kamar}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Room Type: ${room.roomType}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              getStatusColor(room.status_reservasi),
                          foregroundColor: Colors.white,
                          minimumSize: Size(120, 40), // Increased button size
                          textStyle: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          // Show Change Status dialog
                          _showChangeStatusDialog(
                            room.id,
                            room.no_kamar,
                            room.roomType,
                          );
                        },
                        child: Text(room.status_reservasi),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchInput extends StatefulWidget {
  final ValueChanged<String> onSearchChanged;

  const SearchInput({Key? key, required this.onSearchChanged})
      : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          labelText: 'Search by Room Number',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onTap: () {
          setState(() {
            _isSearching = false;
            _searchController.clear();
            widget.onSearchChanged(''); // Reset search when tapped
          });
        },
        onChanged: (value) {
          setState(() {
            _searchText = value.toLowerCase();
            _isSearching = true; // Start searching
            widget.onSearchChanged(_searchText); // Update search results
          });
        },
      ),
    );
  }
}
