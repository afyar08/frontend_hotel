import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';
import 'detail_room.dart'; // Make sure this points to the correct detail_room.dart file

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late Future<List<dynamic>> res;

  @override
  void initState() {
    super.initState();
    res = getKamar(); // Fetch data when the widget is initialized
    res.then((data) {
      print(data[0]); // Print the fetched data for debugging
    });
  }

  // API get kamar
  Future<List<dynamic>> getKamar() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/kamar'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load kamar');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        title: Text(
          'Home',
          style: TextStyle(
            fontFamily: 'Jakarta',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.list_rounded),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2050, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: res,
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
                    child: Text('No Kamar Found'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      var kamar = snapshot.data![i];
                      var tipeKamar = kamar['tipe_kamar'];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailRoom(
                                roomName: tipeKamar['nama_tipe'],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Image.asset(
                                  'assets/images/dash.png',
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: ListTile(
                                  title: Text(tipeKamar['nama_tipe']),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text('IDR ${kamar['harga']}'),
                                          Text('/night'),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(Icons.bed_rounded),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '1 Room ${tipeKamar['kapasitas_ruangan']} ${tipeKamar['bed_tipe']}',
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(Icons.calendar_month),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(kamar['status_reservasi']),
                                        ],
                                      ),
                                    ],
                                  ),
                                  isThreeLine: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
