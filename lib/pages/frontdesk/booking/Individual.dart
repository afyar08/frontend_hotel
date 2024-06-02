import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_hotel/pages/frontdesk/booking/summary.dart';

class IndividualBooking extends StatefulWidget {
  const IndividualBooking({Key? key}) : super(key: key);

  @override
  State<IndividualBooking> createState() => _IndividualBookingState();
}

class _IndividualBookingState extends State<IndividualBooking> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedOption;
  DateTimeRange? _selectedDateRange;
  String? _selectedRoomType;
  String? _selectedSize;
  String? _selectedRoomNumber;
  String? _selectedRoomPlan;
  String? _selectedAdults;
  String? _selectedChildren;
  String _lastName = '';
  String _firstName = '';
  String? _selectedTitle;
  String _selectedMember = 'Yes';
  String _email = '';
  String _phoneNumber = '';
  String _request = '';
  String? _selectedPaymentType;
  String? _selectedBank;
  String _cardNumber = '';

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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
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

  BoxDecoration _containerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
      ],
    );
  }

  Widget _buildDropdown() {
    return Column(
      children: [
        ListTile(
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: _containerDecoration(),
            child: DropdownButtonFormField<String>(
              value: _selectedOption,
              hint: Text('Reservation by'),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              items: <String>[
                'Online',
                'Walk-in',
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
              isExpanded: true,
            ),
          ),
        ),
        ListTile(
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: _containerDecoration(),
            child: TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Select check-in and check-out dates',
                border: InputBorder.none,
              ),
              onTap: () async {
                DateTimeRange? pickedDateRange = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDateRange != null) {
                  setState(() {
                    _selectedDateRange = pickedDateRange;
                  });
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Selected Dates'),
                      content: Text(
                        'Check-in: ${pickedDateRange.start}\n'
                        'Check-out: ${pickedDateRange.end}\n'
                        'Duration: ${pickedDateRange.duration.inDays} days',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
        if (_selectedDateRange != null) ...[
          SizedBox(height: 10),
          Text(
            'Check-in: ${_selectedDateRange!.start}',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Check-out: ${_selectedDateRange!.end}',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Duration: ${_selectedDateRange!.duration.inDays} days',
            style: TextStyle(fontSize: 16),
          ),
        ],
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ListTile(
                title: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: _containerDecoration(),
                  child: DropdownButtonFormField<String>(
                    value: _selectedRoomType,
                    hint: Text('Room type'),
                    decoration: InputDecoration(
                      border: InputBorder.none,
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
                    isExpanded: true,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ListTile(
                title: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: _containerDecoration(),
                  child: DropdownButtonFormField<String>(
                    value: _selectedRoomNumber,
                    hint: Text('Room number'),
                    decoration: InputDecoration(
                      border: InputBorder.none,
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
                    isExpanded: true,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: ListTile(
                title: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: _containerDecoration(),
                  child: DropdownButtonFormField<String>(
                    value: _selectedRoomPlan,
                    hint: Text('Room plan'),
                    decoration: InputDecoration(
                      border: InputBorder.none,
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
                    isExpanded: true,
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
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: _containerDecoration(),
                  child: DropdownButtonFormField<String>(
                    value: _selectedAdults,
                    hint: Text('Adults'),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    items: <String>[
                      '1 Adult',
                      '2 Adults',
                      '3 Adults',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedAdults = newValue!;
                      });
                    },
                    isExpanded: true,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: ListTile(
                title: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: _containerDecoration(),
                  child: DropdownButtonFormField<String>(
                    value: _selectedChildren,
                    hint: Text('Children'),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    items: <String>[
                      'No Children',
                      '1 Child',
                      '2 Children',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedChildren = newValue!;
                      });
                    },
                    isExpanded: true,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        ListTile(
          title: Text(
            'Guest Detail',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10),
        ListTile(
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: _containerDecoration(),
            child: DropdownButtonFormField<String>(
              value: _selectedTitle,
              hint: Text('Title'),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              items: <String>[
                'Mr.',
                'Ms.',
                'Mrs.',
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
              isExpanded: true,
            ),
          ),
        ),
        ListTile(
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: _containerDecoration(),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'First Name',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  _firstName = value;
                });
              },
            ),
          ),
        ),
        ListTile(
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: _containerDecoration(),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Last Name',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  _lastName = value;
                });
              },
            ),
          ),
        ),
        ListTile(
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: _containerDecoration(),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Email',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
          ),
        ),
        ListTile(
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: _containerDecoration(),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Phone Number',
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                setState(() {
                  _phoneNumber = value;
                });
              },
            ),
          ),
        ),
        SizedBox(height: 10),
        ListTile(
          title: Text(
            'Special Request',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10),
        ListTile(
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: _containerDecoration(),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Request',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  _request = value;
                });
              },
            ),
          ),
        ),
        SizedBox(height: 10),
        ListTile(
          title: Text(
            'Payment Detail',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10),
        ListTile(
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: _containerDecoration(),
            child: DropdownButtonFormField<String>(
              value: _selectedPaymentType,
              hint: Text('Payment Type'),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              items: <String>[
                'Credit Card',
                'Debit Card',
                'Cash',
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
              isExpanded: true,
            ),
          ),
        ),
        SizedBox(height: 10),
        ListTile(
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: _containerDecoration(),
            child: DropdownButtonFormField<String>(
              value: _selectedBank,
              hint: Text('Bank'),
              decoration: InputDecoration(
                border: InputBorder.none,
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
              isExpanded: true,
            ),
          ),
        ),
        ListTile(
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: _containerDecoration(),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Card Number',
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                setState(() {
                  _cardNumber = value;
                });
              },
            ),
          ),
        ),
        SizedBox(height: 20),
        // ElevatedButton(
        //   onPressed: () {
        //     if (_formKey.currentState!.validate()) {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => Summary(
        //           ),
        //         ),
        //       );
        //     }
        //   },
        //   child: Text('Submit'),
        // ),
      ],
    );
  }
}

