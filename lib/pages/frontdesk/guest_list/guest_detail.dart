import 'package:flutter/material.dart';
import 'guest_list.dart';

class GuestDetailPage extends StatelessWidget {
  final Guest guest;

  const GuestDetailPage({Key? key, required this.guest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Guest List')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
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
            icon: Icon(Icons.more_horiz),
            onSelected: (value) {
              // Handle selected option
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 1, // satu item
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Room Type: ${guest.roomType}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Name: ${guest.name}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Book ID: ${guest.bookId}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Subtitle 1', style: TextStyle(fontSize: 16)),
                  Text('Data 1'),
                  Text('Data 2'),
                  Text('Data 3'),
                  Text('Data 4'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Subtitle 2', style: TextStyle(fontSize: 16)),
                  Text('Data 5'),
                  Text('Data 6'),
                  Text('Data 7'),
                  Text('Data 8'),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Subtitle 3', style: TextStyle(fontSize: 16)),
                Text('Long Data 1'),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Booking Data',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
