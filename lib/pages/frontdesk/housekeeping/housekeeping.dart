import 'package:flutter/material.dart';

class HouseKeeping extends StatefulWidget {
  const HouseKeeping({Key? key}) : super(key: key);

  @override
  State<HouseKeeping> createState() => _HouseKeepingState();
}

class Room {
  final String status_kamar;
  final String status_reservasi;
  final double harga;
  final String no_kamar;
  final String roomType;

  Room(this.status_kamar, this.status_reservasi, this.harga, this.no_kamar,
      this.roomType);
}

class _HouseKeepingState extends State<HouseKeeping> {
  bool _isSearching = false;
  bool _cleanChecked = false;
  bool _dirtyChecked = false;
  bool _pickupChecked = false;
  bool _inspectedChecked = false;
  bool _outOfOrderChecked = false;
  List<Room> _initialRooms = [
    Room('clean', 'reserved', 100.0, '101', 'Deluxe'),
    Room('dirty', 'check in', 120.0, '102', 'Suite'),
    Room('pickup', 'out of order', 80.0, '103', 'Standard'),
    Room('inspected', 'reserved', 90.0, '104', 'Deluxe'),
    Room('out of order', 'reserved', 90.0, '104', 'Deluxe'),
  ];
  List<Room> _rooms = [];

  @override
  void initState() {
    super.initState();
    _rooms = [];
  }

  void updateSearch(String searchText) {
    setState(() {
      if (searchText.isEmpty &&
          !_cleanChecked &&
          !_dirtyChecked &&
          !_pickupChecked &&
          !_inspectedChecked &&
          !_outOfOrderChecked) {
        _isSearching = false;
        _rooms = [];
      } else {
        _isSearching = true;
        _rooms = _initialRooms
            .where((room) =>
                room.no_kamar.toLowerCase().contains(searchText) &&
                (_cleanChecked && room.status_kamar == 'clean' ||
                    _dirtyChecked && room.status_kamar == 'dirty' ||
                    _pickupChecked && room.status_kamar == 'pickup' ||
                    _inspectedChecked && room.status_kamar == 'inspected' ||
                    _outOfOrderChecked && room.status_kamar == 'out of order'))
            .toList();
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
                          // Define what happens when the button is pressed
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
