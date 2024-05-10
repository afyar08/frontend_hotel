import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:frontend_hotel/pages/customer/profile.dart'; 
import 'package:frontend_hotel/pages/customer/my_booking.dart';

class CustomerDashboard extends StatefulWidget {
  @override
  _CustomerDashboardState createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  int _currentIndex = 0;
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  List<Map<String, dynamic>> _roomData = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  fetchDataFromApi() async {
    var url = Uri.parse('http://127.0.0.1:8000/api/tipe_kamar');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          _roomData = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            fontFamily: 'Jakarta',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false, 
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Color.fromARGB(255, 239, 239, 239),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Color(0xFF4C4DDC)),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),
          _buildBody(),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.white,
        style: TabStyle.reactCircle,
        color: Colors.blueGrey,
        activeColor: Color(0xFF4C4DDC),
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.bookmark_add, title: 'My Booking'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        initialActiveIndex: _currentIndex,
        onTap: (int index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyBooking()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage1()),
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _roomData.length,
        itemBuilder: (context, index) {
          return _ListRoom(index);
        },
      ),
    );
  }

  Widget _ListRoom(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF35385A).withOpacity(.12),
              blurRadius: 30,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: _roomData[index]['gambar'] != null
                  ? Image.network(
                      _roomData[index]['gambar'],
                      width: 88,
                      height: 103,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 88,
                          height: 103,
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image_not_supported,
                            size: 40,
                            color: Colors.grey[600],
                          ),
                        );
                      },
                    )
                  : Container(
                      width: 88,
                      height: 103,
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.image_not_supported,
                        size: 40,
                        color: Colors.grey[600],
                      ),
                    ),
            ),
            const SizedBox(width: 20),
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _roomData[index]['nama_tipe'] ?? "Nama Kamar",
                    style: TextStyle(
                      fontFamily: 'Jakarta',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: const Color(0xFF3F3E3F),
                    ),
                  ),
                  SizedBox(height: 7),
                  RichText(
                    text: TextSpan(
                      text: _roomData[index]['harga'] != null
                          ? 'IDR ${_roomData[index]['harga'] .toStringAsFixed(2)} /Night' // Format harga dengan dua digit desimal
                          : "Harga",
                      style: TextStyle(
                        fontFamily: 'Jakarta',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color(0xFF4C4DDC),
                      ),
                    ),
                  ),
                  SizedBox(height: 7),
                  Row(
  children: [
    Text(
      '${_roomData[index]['kapasitas_ruangan']} orang : ',
      style: TextStyle(
        fontSize: 12,
        color: Color(0xFFACA3A3),
      ),
    ),
    Text(
      _roomData[index]['bed_tipe'] ?? "Tipe Tempat Tidur",
      style: TextStyle(
        fontSize: 12,
        color: Color(0xFFACA3A3),
      ),
    ),
  ],
),
                  SizedBox(height: 7),
                  Row(
                    children: [
                      Text(
                        'Available', // Example, can be replaced with data from API
                        style: TextStyle(
                          color: Color(0xFF50CC98),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
