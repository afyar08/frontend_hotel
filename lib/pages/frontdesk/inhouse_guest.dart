import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  late Future<List<dynamic>> res;

  Future<List<dynamic>> getGuest() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/inHouseGuest'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load tamu');
    }
  }

  @override
  void initState() {
    super.initState();
    res = getGuest(); // Fetch data when the widget is initialized
    res.then((data) {
      print(data[0]); // Print the fetched data for debugging
    });
  }

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
                FutureBuilder<List<dynamic>>(
                  future: res,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text(
                        'Total In House Guest: ${snapshot.error}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    } else {
                      return Text(
                        'Total In House Guest: ${snapshot.data!.length}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: RoomList(res),
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
  final Future<List<dynamic>> guestData; // Tambahkan parameter

  RoomList(this.guestData); // Konstruktor dengan parameter
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<dynamic>>(
        future: guestData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No Guest Found'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, i) {
                var guest = snapshot.data![i];

                return Card(
                  color: Colors.grey[200],
                  //margin: EdgeInsets.all(8.0),
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: Text(
                      'Room ${guest['kamar']['no_kamar']}',
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
                          '${guest['tamu']['nama']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${guest['tipe_kamar']['nama_tipe']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 4),
                      ],
                    ),
                    trailing: Text(
                      ' Book ID : ${guest['kamar']['id']}',
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
                );
              },
            );
          }
        },
      ),
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
