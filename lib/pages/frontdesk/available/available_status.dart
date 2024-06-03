import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend_hotel/pages/frontdesk/housekeeping/change_status_dialog.dart';

class AvailableStatus extends StatefulWidget {
  const AvailableStatus({Key? key}) : super(key: key);

  @override
  State<AvailableStatus> createState() => _AvailableStatusState();
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

class _AvailableStatusState extends State<AvailableStatus> {
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
                  room.status_kamar == 'clean' ||
                  room.status_kamar == 'inspected' ||
                  room.status_kamar == 'dirty')
              .toList();
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
                room.status_kamar == 'clean' ||
                room.status_kamar == 'inspected' ||
                room.status_kamar == 'dirty')
            .toList();
      } else {
        _isSearching = true;
        _rooms = _initialRooms
            .where((room) =>
                (room.status_kamar == 'clean' ||
                    room.status_kamar == 'inspected' ||
                    room.status_kamar == 'dirty') &&
                room.no_kamar.toLowerCase().contains(searchText))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Available Status')),
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
                          backgroundColor: getStatusColor(room.status_kamar),
                          foregroundColor: Colors.white,
                          minimumSize: Size(120, 40), // Increased button size
                          textStyle: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          // Add logic to handle button press here
                        },
                        child: Text(room.status_kamar),
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

  Color getStatusColor(String status) {
    switch (status) {
      case 'clean':
        return Colors.blue;
      case 'inspected':
        return Colors.green;
      case 'dirty':
        return Colors.red;
      default:
        return Colors.black;
    }
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
        onChanged: (value) {
          widget.onSearchChanged(value.toLowerCase());
        },
      ),
    );
  }
}
