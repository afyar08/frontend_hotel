import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:frontend_hotel/pages/frontdesk/booking/summary.dart';
import 'package:frontend_hotel/pages/frontdesk/booking/individual.dart';

class GroupNext extends StatefulWidget {
  const GroupNext({Key? key}) : super(key: key);

  @override
  State<GroupNext> createState() => _GroupNext();
}

class _GroupNext extends State<GroupNext> {
  final _formKey = GlobalKey<FormState>();

  String _selectedRoomPlan = '';
  String _selectedAdults = '';
  String _selectedChildren = '';
  String _lastName = '';
  String _firstName = '';
  String _selectedTitle = '';
  String _email = '';
  String _phoneNumber = '';
  String _request = '';
  String _selectedPaymentType = '';
  String _selectedBank = '';
  String _cardNumber = '';

  final TextEditingController _roomPlanController = TextEditingController();
  final TextEditingController _adultsController = TextEditingController();
  final TextEditingController _childrenController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _paymentTypeController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.black),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      errorStyle: TextStyle(color: Colors.red),
      isDense: true,
      hintStyle: TextStyle(color: Colors.grey),
    );
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
                  SizedBox(height: 20),
                  _buildBookingButton(),
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
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: CustomDropdown(
              hintText: 'Select Room plan',
              items: ['Room only', 'Room with breakfast', 'Full service'],
              controller: _roomPlanController,
              onChanged: (value) {
                setState(() {
                  _selectedRoomPlan = value;
                  _roomPlanController.text = value;
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
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CustomDropdown(
                    hintText: 'Select Adults',
                    items: ['1 Adult', '2 Adults', '3 Adults'],
                    controller: _adultsController,
                    onChanged: (value) {
                      setState(() {
                        _selectedAdults = value;
                        _adultsController.text = value;
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
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CustomDropdown(
                    hintText: 'Select Children',
                    items: ['1 Child', '2 Children', '3 Children', '4 Children'],
                    controller: _childrenController,
                    onChanged: (value) {
                      setState(() {
                        _selectedChildren = value;
                        _childrenController.text = value;
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
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
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
            ),
            child: TextFormField(
              decoration: _inputDecoration('Last Name'),
              onChanged: (value) {
                setState(() {
                  _lastName = value;
                });
              },
            ),
          ),
        ),
        SizedBox(height: 5),
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
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TextFormField(
              decoration: _inputDecoration('First Name'),
              onChanged: (value) {
                setState(() {
                  _firstName = value;
                });
              },
            ),
          ),
        ),
        SizedBox(height: 5),
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
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CustomDropdown(
                    hintText: 'Select Title',
                    items: ['Mr.', 'Mrs.', 'Ms.', 'Miss'],
                    controller: _titleController,
                    onChanged: (value) {
                      setState(() {
                        _selectedTitle = value;
                        _titleController.text = value;
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
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TextFormField(
              decoration: _inputDecoration('Email Address'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
          ),
        ),
        SizedBox(height: 5),
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
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TextFormField(
              decoration: _inputDecoration('Phone Number'),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                setState(() {
                  _phoneNumber = value;
                });
              },
            ),
          ),
        ),
        SizedBox(height: 5),
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
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TextFormField(
              decoration: _inputDecoration('Guest Comment/Request'),
              onChanged: (value) {
                setState(() {
                  _request = value;
                });
              },
            ),
          ),
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
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CustomDropdown(
                    hintText: 'Select Payment type',
                    items: ['Cash', 'Credit', 'Debit'],
                    controller: _paymentTypeController,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentType = value;
                        _paymentTypeController.text = value;
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
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CustomDropdown(
                    hintText: 'Select Bank',
                    items: ['Bank A', 'Bank B', 'Bank C'],
                    controller: _bankController,
                    onChanged: (value) {
                      setState(() {
                        _selectedBank = value;
                        _bankController.text = value;
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
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
              ],
              decoration: _inputDecoration('Card Number'),
              onChanged: (value) {
                setState(() {
                  _cardNumber = value;
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Number is required';
                } else if (value.length != 16) {
                  return 'Format tidak sesuai';
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookingButton() {
    return TextButton(
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
        padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
        decoration: BoxDecoration(
          color: Color(0xFF4C4DDC),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}
