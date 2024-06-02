import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import untuk menggunakan TextInputFormatter
import 'package:frontend_hotel/pages/frontdesk/booking/summary.dart';
import 'package:frontend_hotel/pages/frontdesk/booking/individual.dart';

class GroupNext extends StatefulWidget {
  const GroupNext({Key? key}) : super(key: key);

  @override
  State<GroupNext> createState() => _GroupNext();
}

class _GroupNext extends State<GroupNext> {
  final _formKey = GlobalKey<FormState>(); // Define a GlobalKey for the form

  String _selectedOption =
      'Option 1'; // Initialize the selected dropdown option
  String _selectedCheckIn =
      'Morning'; // Initialize the selected check-in option
  String _selectedDuration =
      '1 Hour'; // Initialize the selected duration option
  String _selectedRoomType =
      'Single'; // Initialize the selected room type option
  String _selectedSize = 'Standard'; // Initialize the selected size option
  String _selectedRoomNumber =
      '101'; // Initialize the selected room number option
  String _selectedRoomPlan =
      'Standard'; // Initialize the selected room plan option
  int _selectedAdults = 1; // Initialize the selected number of adults
  int _selectedChildren = 0; // Initialize the selected number of children
  String _lastName = ''; // Initialize the last name field
  String _firstName = ''; // Initialize the first name field
  String _selectedTitle = 'Mr.'; // Initialize the selected title option
  String _selectedMember = 'Yes'; // Initialize the selected member option
  String _email = ''; // Initialize the email field
  String _phoneNumber = ''; // Initialize the phone number field
  String _request = ''; // Initialize the request field
  String _selectedPaymentType =
      'Cash'; // Initialize the selected payment type option
  String _selectedBank = 'Bank A'; // Initialize the selected bank option
  String _cardNumber = ''; // Initialize the card number field

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
          'Individual Booking',
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
            height: 55,
            child: DropdownButtonFormField<String>(
              value: _selectedOption,
              decoration: InputDecoration(
                labelText: 'Reservation by',
                border: OutlineInputBorder(),
              ),
              items: <String>[
                'Option 1',
                'Option 2',
                'Option 3',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue!;
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
                  height: 55,
                  child: DropdownButtonFormField<String>(
                    value: _selectedCheckIn,
                    decoration: InputDecoration(
                      labelText: 'Check-in',
                      border: OutlineInputBorder(),
                    ),
                    items: <String>[
                      'Morning',
                      'Afternoon',
                      'Evening',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCheckIn = newValue!;
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
                  height: 55,
                  child: DropdownButtonFormField<String>(
                    value: _selectedDuration,
                    decoration: InputDecoration(
                      labelText: 'Duration',
                      border: OutlineInputBorder(),
                    ),
                    items: <String>[
                      '1 Hour',
                      '2 Hours',
                      '3 Hours',
                      '4 Hours',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedDuration = newValue!;
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
                  height: 55,
                  child: DropdownButtonFormField<String>(
                    value: _selectedRoomType,
                    decoration: InputDecoration(
                      labelText: 'Room Type',
                      border: OutlineInputBorder(),
                    ),
                    items: <String>[
                      'Single',
                      'Double',
                      'Suite',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRoomType = newValue!;
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
                  'Check out: $_selectedSize', // Display selected size as text
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
                  height: 55,
                  child: DropdownButtonFormField<String>(
                    value: _selectedRoomNumber,
                    decoration: InputDecoration(
                      labelText: 'Room Number',
                      border: OutlineInputBorder(),
                    ),
                    items: <String>[
                      '101',
                      '102',
                      '103',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRoomNumber = newValue!;
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
                  height: 55,
                  child: DropdownButtonFormField<String>(
                    value: _selectedRoomPlan,
                    decoration: InputDecoration(
                      labelText: 'Room Plan',
                      border: OutlineInputBorder(),
                    ),
                    items: <String>[
                      'Standard',
                      'Deluxe',
                      'Premium',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRoomPlan = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        ListTile(
          title: Text(
            'Guest Detail', // Title for the section
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10),
        ListTile(
          title: TextFormField(
            decoration: InputDecoration(
              labelText: 'Last Name',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _lastName = value;
              });
            },
          ),
        ),
        SizedBox(height: 5),
        ListTile(
          title: TextFormField(
            decoration: InputDecoration(
              labelText: 'First Name',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _firstName = value;
              });
            },
          ),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ListTile(
                title: Container(
                  height: 55,
                  child: DropdownButtonFormField<String>(
                    value: _selectedTitle,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    items: <String>[
                      'Mr.',
                      'Mrs.',
                      'Ms.',
                      'Miss',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedTitle = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
        SizedBox(height: 10),
        ListTile(
          title: TextFormField(
            decoration: InputDecoration(
              labelText: 'Other',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _email = value;
              });
            },
          ),
        ),
        SizedBox(height: 30),
        ListTile(
          title: TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _email = value;
              });
            },
          ),
        ),
        SizedBox(height: 5),
        ListTile(
          title: TextFormField(
            keyboardType: TextInputType.number, // Set keyboard type ke number
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter
                  .digitsOnly, // Hanya menerima input digit
              LengthLimitingTextInputFormatter(
                  13), // Batasi panjang input hingga 13 karakter
            ],
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _phoneNumber = value;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Number is required';
              } else if (value.length != 13) {
                return 'Format tidak sesuai';
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 5),
        ListTile(
          title: TextFormField(
            decoration: InputDecoration(
              labelText: 'Guest Comment/Request',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _request = value;
              });
            },
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ListTile(
                title: Container(
                  height: 55,
                  child: DropdownButtonFormField<String>(
                    value: _selectedPaymentType,
                    decoration: InputDecoration(
                      labelText: 'Payment Type',
                      border: OutlineInputBorder(),
                    ),
                    items: <String>[
                      'Cash',
                      'Credit Card',
                      'Debit Card',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedPaymentType = newValue!;
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
                  height: 55,
                  child: DropdownButtonFormField<String>(
                    value: _selectedBank,
                    decoration: InputDecoration(
                      labelText: 'Bank',
                      border: OutlineInputBorder(),
                    ),
                    items: <String>[
                      'Bank A',
                      'Bank B',
                      'Bank C',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedBank = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        ListTile(
          title: TextFormField(
            decoration: InputDecoration(
              labelText: 'Card Number',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _cardNumber = value;
              });
            },
          ),
        ),
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
              'Booking',
              style: TextStyle(
                fontFamily: 'Jakarta',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: IndividualBooking(),
  ));
}
