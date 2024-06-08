import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend_hotel/pages/frontdesk/housekeeping/change_status_dialog.dart';

class HouseKeeping extends StatefulWidget {
  const HouseKeeping({Key? key}) : super(key: key);

  @override
  State<HouseKeeping> createState() => _HouseKeepingState();
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

class _HouseKeepingState extends State<HouseKeeping> {
  bool _isSearching = false;
  bool _cleanChecked = false;
  bool _dirtyChecked = false;
  bool _pickupChecked = false;
  bool _inspectedChecked = false;
  bool _outOfOrderChecked = false;
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
          _rooms = _initialRooms;
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
      List<String> activeStatuses = [];
      if (_cleanChecked) activeStatuses.add('clean');
      if (_dirtyChecked) activeStatuses.add('dirty');
      if (_pickupChecked) activeStatuses.add('pickup');
      if (_inspectedChecked) activeStatuses.add('inspected');
      if (_outOfOrderChecked) activeStatuses.add('out of order');

      if (searchText.isEmpty && activeStatuses.isEmpty) {
        _isSearching = false;
        _rooms = _initialRooms;
      } else {
        _isSearching = true;
        _rooms = _initialRooms.where((room) {
          bool matchesSearchText =
              room.no_kamar.toLowerCase().contains(searchText);
          bool matchesStatus = activeStatuses.isEmpty ||
              activeStatuses.contains(room.status_kamar);
          return matchesSearchText && matchesStatus;
        }).toList();
        _rooms.sort((a, b) =>
            a.no_kamar.compareTo(b.no_kamar)); // Sorting rooms by no_kamar
      }
    });
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'clean':
        return Colors.blue;
      case 'dirty':
        return Colors.red;
      case 'pickup':
        return Colors.lime;
      case 'inspected':
        return Colors.green;
      case 'out of order':
        return Colors.grey;
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
        );
      },
    );

    if (result == true) {
      // Refresh daftar kamar setelah status berhasil diperbarui
      fetchRooms();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('House Keeping')),
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
          Card(
            color: Colors.grey[200],
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Checkbox(
                              value: _cleanChecked,
                              onChanged: (value) {
                                setState(() {
                                  _cleanChecked = value!;
                                  updateSearch('');
                                });
                              },
                            ),
                            Text('Clean'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Checkbox(
                              value: _inspectedChecked,
                              onChanged: (value) {
                                setState(() {
                                  _inspectedChecked = value!;
                                  updateSearch('');
                                });
                              },
                            ),
                            Text('Inspected'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Checkbox(
                              value: _dirtyChecked,
                              onChanged: (value) {
                                setState(() {
                                  _dirtyChecked = value!;
                                  updateSearch('');
                                });
                              },
                            ),
                            Text('Dirty'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Checkbox(
                              value: _outOfOrderChecked,
                              onChanged: (value) {
                                setState(() {
                                  _outOfOrderChecked = value!;
                                  updateSearch('');
                                });
                              },
                            ),
                            Text('Out of Order'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Checkbox(
                              value: _pickupChecked,
                              onChanged: (value) {
                                setState(() {
                                  _pickupChecked = value!;
                                  updateSearch('');
                                });
                              },
                            ),
                            Text('Pickup'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(), // Empty container to fill the space
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
                          _showChangeStatusDialog(
                            room.id,
                            room.no_kamar,
                            room.roomType,
                          );
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
