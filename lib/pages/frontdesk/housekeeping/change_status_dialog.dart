import 'package:flutter/material.dart';

class ChangeStatusDialog extends StatefulWidget {
  final String roomNumber;
  final String roomType;

  const ChangeStatusDialog({
    Key? key,
    required this.roomNumber,
    required this.roomType,
  }) : super(key: key);

  @override
  _ChangeStatusDialogState createState() => _ChangeStatusDialogState();
}

class _ChangeStatusDialogState extends State<ChangeStatusDialog> {
  String _selectedStatus = ''; // Variable to store the selected status

  // List of status options
  final List<String> _statusOptions = [
    'Clean',
    'Dirty',
    'Pickup',
    'Inspected',
    'Out of Order',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Change Room Status',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'Room Number: ${widget.roomNumber}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue, // Optionally change text color
                ),
              ),
            ),
            Center(
              child: Text(
                'Room Type: ${widget.roomType}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue, // Optionally change text color
                ),
              ),
            ),
            SizedBox(height: 16),
            // Build radio buttons for status options
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _statusOptions.map((String status) {
                return Row(
                  children: [
                    Radio(
                      value: status,
                      groupValue: _selectedStatus,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedStatus = value!;
                        });
                      },
                    ),
                    Text(status),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Add logic to submit the selected status here
                  if (_selectedStatus.isNotEmpty) {
                    // You can pass the selected status back to the calling widget
                    Navigator.pop(context, _selectedStatus);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  minimumSize: Size(double.maxFinite, 50),
                ),
                child: Text(
                  'Change',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(height: 8), // Add space between buttons
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(double.maxFinite, 50),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
