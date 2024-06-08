import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangeStatusDialog extends StatefulWidget {
  final String roomNumber;
  final String roomType;
  final int roomId;
  final Function(bool) onUpdateStatus;

  const ChangeStatusDialog({
    Key? key,
    required this.roomId,
    required this.roomNumber,
    required this.roomType,
    required this.onUpdateStatus,
  }) : super(key: key);

  @override
  _ChangeStatusDialogState createState() => _ChangeStatusDialogState();
}

class _ChangeStatusDialogState extends State<ChangeStatusDialog> {
  String _selectedStatus = ''; // Variable to store the selected status
  bool _isLoading = false; // Variable to track loading state

  // List of status options
  final List<String> _statusOptions = [
    'Clean',
    'Dirty',
    'Pickup',
    'Inspected',
    'Out of Order',
  ];

  Future<void> _updateRoomStatus() async {
    setState(() {
      _isLoading = true;
    });

    String url;
    Map<String, dynamic> requestBody;

    // Tentukan URL dan requestBody berdasarkan status yang dipilih
    if (_selectedStatus.toLowerCase().contains('out of order')) {
      url = 'http://localhost:8000/api/kamar/out-of-order/${widget.roomId}';
      requestBody = {};
    } else {
      url = 'http://localhost:8000/api/kamar/status/${widget.roomId}';
      requestBody = {'status_kamar': _selectedStatus.toLowerCase()};
    }

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        // Panggil fungsi callback onUpdateStatus dengan true untuk sukses
        widget.onUpdateStatus(true);
        Navigator.of(context).pop(true);
      } else {
        // Panggil fungsi callback onUpdateStatus dengan false untuk kegagalan
        widget.onUpdateStatus(false);
        Navigator.of(context).pop(false);
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      // Panggil fungsi callback onUpdateStatus dengan false untuk kegagalan
      widget.onUpdateStatus(false);
      Navigator.of(context).pop(false);
      // Tampilkan pesan kesalahan kepada pengguna jika terjadi kesalahan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Change Room Status',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      content: _isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : SizedBox(
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
                  if (_selectedStatus.isNotEmpty) {
                    _updateRoomStatus();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select a status')),
                    );
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
