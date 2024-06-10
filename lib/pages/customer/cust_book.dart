import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IndividualBooking extends StatefulWidget {
  const IndividualBooking({Key? key}) : super(key: key);

  @override
  State<IndividualBooking> createState() => _IndividualBookingState();
}

class _IndividualBookingState extends State<IndividualBooking> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedReservationBy;
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

  Future<void> createReservation() async {
    if (_selectedDateRange == null ||
        _selectedReservationBy == null ||
        _selectedRoomPlan == null ||
        _selectedAdults == null ||
        _selectedTitle == null ||
        _selectedPaymentType == null ||
        _firstName.isEmpty ||
        _lastName.isEmpty ||
        _email.isEmpty ||
        _phoneNumber.isEmpty) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all the required fields')),
      );
      return;
    }

    final url = Uri.parse('http://localhost:8000/api/reservations');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'first_name': _firstName,
        'last_name': _lastName,
        'email': _email,
        'phone_number': _phoneNumber,
        'title': _selectedTitle,
        'tgl_check_in': DateFormat('yyyy-MM-dd').format(_selectedDateRange!.start),
        'tgl_check_out': DateFormat('yyyy-MM-dd').format(_selectedDateRange!.end),
        'detail_tamu': 'Some detail', // Add actual details
        'pembayaran': 'Credit Card', // Add actual payment method
        'total_bayar': 100.0, // Add actual total amount
        'status_pembayaran': 'Pending', // Add actual payment status
        'id_kamar': 1, // Add actual room ID
        'room_plan': _selectedRoomPlan,
        'request': _request,
        'reservation_by': _selectedReservationBy,
        'duration': _selectedDateRange!.duration.inDays,
        'room_total': 1, // Add actual room total
        'adult': int.parse(_selectedAdults!.split(' ')[0]),
        'children': _selectedChildren != 'No Children' ? int.parse(_selectedChildren!.split(' ')[0]) : 0,
        'extra': 0.0, // Add actual extra charge if any
        'sub_total': 100.0, // Add actual sub total
      }),
    );

    if (response.statusCode == 201) {
      // Reservation created successfully
      print('Reservation created successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reservation created successfully')),
      );
    } else {
      // Error occurred
      print('Failed to create reservation');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create reservation')),
      );
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
                  ElevatedButton(
                    onPressed: createReservation,
                    child: Container(
                      child: Text(
                        'Booking',
                        style: TextStyle(
                          fontFamily: 'Jakarta',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
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
              value: _selectedReservationBy,
              hint: Text('Reservation by'),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              items: <String>[
                'By Phone',
                'Walk-in',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedReservationBy = newValue!;
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
                        'Check-in: ${DateFormat('yyyy-MM-dd').format(_selectedDateRange!.start)}\n'
                        'Check-out: ${DateFormat('yyyy-MM-dd').format(_selectedDateRange!.end)}\n'
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
            'Check-in: ${DateFormat('yyyy-MM-dd').format(_selectedDateRange!.start)}',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Check-out: ${DateFormat('yyyy-MM-dd').format(_selectedDateRange!.end)}',
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
                      'Standard',
                      'Deluxe',
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
            Expanded(
              child: ListTile(
                title: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: _containerDecoration(),
                  child: DropdownButtonFormField<String>(
                    value: _selectedSize,
                    hint: Text('Size'),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    items: <String>[
                      'Single',
                      'Double',
                      'Family',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedSize = newValue!;
                      });
                    },
                    isExpanded: true,
                  ),
                ),
              ),
            ),
          ],
        ),
        ListTile(
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
        ListTile(
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
                'Room Only',
                'Bed and Breakfast',
                'Half Board',
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
        _buildTextInput('First Name', onChanged: (value) {
          _firstName = value;
        }),
        _buildTextInput('Last Name', onChanged: (value) {
          _lastName = value;
        }),
        _buildDropdownFormField(
          value: _selectedTitle,
          hint: 'Title',
          items: ['Mr', 'Ms', 'Mrs', 'Dr', 'Prof'],
          onChanged: (newValue) {
            setState(() {
              _selectedTitle = newValue!;
            });
          },
        ),
        _buildTextInput('Email', onChanged: (value) {
          _email = value;
        }),
        _buildTextInput('Phone Number', onChanged: (value) {
          _phoneNumber = value;
        }),
        _buildTextInput('Special Requests', onChanged: (value) {
          _request = value;
        }),
        _buildDropdownFormField(
          value: _selectedPaymentType,
          hint: 'Payment Type',
          items: ['Credit Card', 'Debit Card', 'Cash', 'Bank Transfer'],
          onChanged: (newValue) {
            setState(() {
              _selectedPaymentType = newValue!;
            });
          },
        ),
        if (_selectedPaymentType == 'Credit Card' || _selectedPaymentType == 'Debit Card') ...[
          _buildDropdownFormField(
            value: _selectedBank,
            hint: 'Bank',
            items: ['Bank A', 'Bank B', 'Bank C'],
            onChanged: (newValue) {
              setState(() {
                _selectedBank = newValue!;
              });
            },
          ),
          _buildTextInput('Card Number', onChanged: (value) {
            _cardNumber = value;
          }, inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
          ]),
        ],
      ],
    );
  }

  Widget _buildTextInput(String label, {required Function(String) onChanged, List<TextInputFormatter>? inputFormatters}) {
    return ListTile(
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: _containerDecoration(),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: label,
            border: InputBorder.none,
          ),
          onChanged: onChanged,
          inputFormatters: inputFormatters,
        ),
      ),
    );
  }

  Widget _buildDropdownFormField({
    String? value,
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return ListTile(
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: _containerDecoration(),
        child: DropdownButtonFormField<String>(
          value: value,
          hint: Text(hint),
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
          isExpanded: true,
        ),
      ),
    );
  }
}
