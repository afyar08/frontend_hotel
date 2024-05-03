import 'package:flutter/material.dart';
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

  // Contoh data kamar
  final List<String> _rooms = [
    'Kamar Deluxe',
    'Kamar Suite',
    'Kamar Double',
    'Kamar Single',
    'Kamar Presiden'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: ListView.builder(
              itemCount: _rooms.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){},
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
                          title: Text('Three-line ListTile'),
                          subtitle: Text(
                              'A sufficiently long subtitle warrants three lines.'),
                          trailing: Icon(Icons.more_vert),
                          isThreeLine: true,
                        ),
                      ),
                    ],
                  ),
                )
                );
                // return Card(
                //   child: ListTile(
                //     leading: ,
                //     title: Text(_rooms[index]),
                //     onTap: () {
                //       // Navigasi ke halaman detail kamar
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) =>
                //               DetailRoom(roomName: _rooms[index]),
                //         ),
                //       );
                //     },
                //   ),
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}
