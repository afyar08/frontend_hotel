import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:table_calendar/table_calendar.dart';
import 'detail_room.dart'; // Pastikan ini mengarah ke file detail_room.dart yang benar

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  var res;

  @override
  void initState() {
    super.initState();
    res = getKamar(); // Fetch data when the widget is initialized/
    res.then((data) {
      print(data[0]); // Print the fetched data
    });
  }

// Api get kamar yg udh dibuat di be
  Future<List<dynamic>> getKamar() async {
    Response response = await get(
      Uri.parse('http://127.0.0.1:8000/api/kamar'),
    );

    return jsonDecode(response.body);
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
          fontWeight: FontWeight.bold, // Medium
          fontSize: 18, // Ukuran font yang Anda inginkan
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
              return _selectedDay == day;
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
              child: FutureBuilder(
                  future: res,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailRoom(
                                        roomName: snapshot.data[i]['tipe_kamar']
                                            [0]['nama_tipe']),
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
                                        title: Text(snapshot.data[i]
                                            ['tipe_kamar'][0]['nama_tipe']),
                                        subtitle: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text('IDR ' +
                                                    snapshot.data[i]['harga']),
                                                Text('/night')
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Icon(Icons.room),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text('1 Room ' +
                                                    snapshot.data[i]
                                                            ['tipe_kamar'][0][
                                                            'kapasitas_ruangan']
                                                        .toString() +
                                                    ' ' +
                                                    snapshot.data[i]
                                                            ['tipe_kamar'][0]
                                                        ['bed_tipe'])
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Icon(Icons.calendar_month),
                                                SizedBox(
                                                  width: 10,
                                                ),             
                                                Text(snapshot.data[i]['status_reservasi'])
                                              ],
                                            )
                                          ],
                                        ),
                                        isThreeLine: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })),
        ],
      ),
    );
  }
}
