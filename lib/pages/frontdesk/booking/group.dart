import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:frontend_hotel/pages/frontdesk/booking/summary.dart';
import 'package:frontend_hotel/pages/frontdesk/booking/group_next.dart';

class GroupBooking extends StatefulWidget {
  const GroupBooking({Key? key}) : super(key: key);

  @override
  State<GroupBooking> createState() => _GroupBookingState();
}

class _GroupBookingState extends State<GroupBooking> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _reservationController = TextEditingController();
  final TextEditingController _checkInController = TextEditingController();
  final TextEditingController _checkoutController = TextEditingController();
  final TextEditingController _roomTotalController = TextEditingController();
  final TextEditingController _roomTypeController = TextEditingController();

  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool _isChecked4 = false;

  List<DateTime?> _dialogCalendarPickerValue = [];
  int _durationInDays = 0;

  @override
  void initState() {
    super.initState();
  }

  String _getValueText(CalendarDatePicker2Type datePickerType, List<DateTime?> values) {
    values = values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null).toString().replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values.map((v) => v.toString().replaceAll('00:00:00.000', '')).join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1 ? values[1].toString().replaceAll('00:00:00.000', '') : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
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
                  _buildRoomNumbers(),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GroupNext()),
                        );
                      }
                    },
                    child: Container(
                      child: Text(
                        'Next',
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

  Widget _buildDropdown() {
    final config = CalendarDatePicker2WithActionButtonsConfig(
      calendarType: CalendarDatePicker2Type.range,
      disableModePicker: true,
    );

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
              hintText: 'Reservation by',
              items: ['Online', 'Walk-in'],
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
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      final values = await showCalendarDatePicker2Dialog(
                        context: context,
                        config: config,
                        dialogSize: const Size(325, 400),
                        borderRadius: BorderRadius.circular(15),
                        value: _dialogCalendarPickerValue,
                        dialogBackgroundColor: Colors.white,
                      );
                      if (values != null) {
                        setState(() {
                          _dialogCalendarPickerValue = values;
                          _checkInController.text = _dialogCalendarPickerValue.isNotEmpty ? _dialogCalendarPickerValue[0]?.toString().split(' ')[0] ?? '' : '';
                          _checkoutController.text = _dialogCalendarPickerValue.length > 1 ? _dialogCalendarPickerValue[1]?.toString().split(' ')[0] ?? '' : '';
                          _durationInDays = _dialogCalendarPickerValue.length > 1
                              ? _dialogCalendarPickerValue[1]!.difference(_dialogCalendarPickerValue[0]!).inDays
                              : 0;
                        });
                      }
                    },
                    child: Text(
                      'Select Check-in and Check-out Dates',
                      style: TextStyle(
                        fontFamily: 'Jakarta',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 11),
        if (_checkInController.text.isNotEmpty || _checkoutController.text.isNotEmpty)
          Column(
            children: [
              Text(
                'Check-in: ${_checkInController.text}, Check-out: ${_checkoutController.text}',
                style: TextStyle(
                  fontFamily: 'Jakarta',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Duration: $_durationInDays days',
                style: TextStyle(
                  fontFamily: 'Jakarta',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        SizedBox(height: 8),
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
            SizedBox(width: 1),
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
                    hintText: 'Room Type',
                    items: ['Deluxe Room', 'Suite Room', 'Standard Room'],
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
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            
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
