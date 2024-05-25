import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import untuk menggunakan TextInputFormatter
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:frontend_hotel/pages/frontdesk/booking/summary.dart';

class GroupBooking extends StatefulWidget {
  const GroupBooking({Key? key}) : super(key: key);

  @override
  State<GroupBooking> createState() => _GroupBookingState();
}

class _GroupBookingState extends State<GroupBooking> {
  final _formKey = GlobalKey<FormState>(); // Define a GlobalKey for the form

  final TextEditingController _reservationController = TextEditingController();
  final TextEditingController _checkInController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _roomTotalController = TextEditingController();
  final TextEditingController _roomTypeController = TextEditingController();

  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool _isChecked4 = false;

  @override
  void initState() {
    super.initState();
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
          'Group Booking',
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey, // Assign the key to the form
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  _buildDropdown(),
                  SizedBox(height: 20),
                  _buildRoomNumbers(),
                  SizedBox(height: 20),
                  TextButton(
                    //buat next
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BookingSummary()),
                        );
                      }
                    },
                    child: Container(
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontFamily: 'Jakarta',
                          fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      padding: EdgeInsets.fromLTRB(100, 20, 100, 20), // jarak ke dalam
                      decoration: BoxDecoration(
                        color: Color(0xFF4C4DDC),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Column(
      children: [
        ListTile(
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: CustomDropdown(
              hintText: 'Reservation by',
              items: ['Option 1', 'Option 2', 'Option 3'],
              controller: _reservationController,
              onChanged: (value) {
                setState(() {
                  _reservationController.text = value;
                });
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ListTile(
                title: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: CustomDropdown(
                    hintText: 'Check-in',
                    items: ['Morning', 'Afternoon', 'Evening'],
                    controller: _checkInController,
                    onChanged: (value) {
                      setState(() {
                        _checkInController.text = value;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: ListTile(
                title: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: CustomDropdown(
                    hintText: 'Duration',
                    items: ['1 Day', '2 Days', '3 Days', '4 Days'],
                    controller: _durationController,
                    onChanged: (value) {
                      setState(() {
                        _durationController.text = value;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ListTile(
                title: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: CustomDropdown(
                    hintText: 'Room Total',
                    items: ['2 rooms', '3 rooms', '4 rooms'],
                    controller: _roomTotalController,
                    onChanged: (value) {
                      setState(() {
                        _roomTotalController.text = value;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: ListTile(
                title: Text(
                  'Check out: ${_roomTotalController.text}', // Display selected size as text
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ListTile(
                title: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: CustomDropdown(
                    hintText: 'Room Type',
                    items: ['Single', 'Double', 'Suite'],
                    controller: _roomTypeController,
                    onChanged: (value) {
                      setState(() {
                        _roomTypeController.text = value;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
      ],
    );
  }

  Widget _buildRoomNumbers() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFE5F1FF),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Room Numbers:',
                style: TextStyle(
                  fontFamily: 'Jakarta',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: Text('Room 101'),
                    value: _isChecked1,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked1 = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: Text('Room 102'),
                    value: _isChecked2,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked2 = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: Text('Room 201'),
                    value: _isChecked3,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked3 = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: Text('Room 202'),
                    value: _isChecked4,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked4 = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GroupBooking(),
  ));
}
