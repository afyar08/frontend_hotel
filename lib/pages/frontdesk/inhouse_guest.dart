import 'package:flutter/material.dart';

void main() => runApp(const ListTileApp());

class ListTileApp extends StatelessWidget {
  const ListTileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const InHouseGuest(),
    );
  }
}

class InHouseGuest extends StatefulWidget {
  const InHouseGuest({Key? key}) : super(key: key);

  @override
  State<InHouseGuest> createState() => _InHouseGuestState();
}

class _InHouseGuestState extends State<InHouseGuest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guest List')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SearchInput(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Total In House Guest:',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RoomList(),
          ),
        ],
      ),
    );
  }
}

class SearchInput extends StatefulWidget {
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
          labelText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onTap: () {
          setState(() {
            // Set _selectedDate to null when the search field is tapped
            // Clear _guests
            // Fill _guests with all initial guest data
          });
        },
        onChanged: (value) {
          setState(() {
            _searchText = value.toLowerCase();
            _isSearching = true; // Start searching
          });
        },
      ),
    );
  }
}

class RoomList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> rooms = ['Room 001', 'Room 002', 'Room 003', 'Room 004'];

    return ListView.builder(
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailRoom(roomName: rooms[index]),
              ),
            );
          },
          child: Card(
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
                        'Room',
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
                            ' u',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            ' y',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 4),
                          
                        ],
                      ),
                      trailing: Text(
                            ' Book ID : ',
                            style: TextStyle(fontSize: 16),
                          ),
                      onTap: () {
                        // Navigasi ke halaman detail tamu saat ListTile ditekan
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => GuestDetailPage(guest: guest),
                        //   ),
                        // );
                      },
                    ),
                  ),
        );
      },
    );
  }
}




class DetailRoom extends StatelessWidget {
  final String roomName;

  const DetailRoom({Key? key, required this.roomName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( 
          roomName,
        ),
      ),
      body: Center(
        child: Text('Detail of $roomName'),
      ),
    );
  }
}

