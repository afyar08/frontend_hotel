import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 8.0), // Atur jarak atas, kanan, bawah, kiri
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
          Expanded(
            child: _buildBody(),
          ),
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
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: 20, // Example, you can adjust this number according to your needs
      itemBuilder: (context, index) => _ListRoom(index), // Passing index as parameter
      separatorBuilder: (context, index) => SizedBox(height: 11),
    );
  }

  Widget _ListRoom(int index) {
    return Container(
      padding: const EdgeInsets.all(20),
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
            child: Image.asset(
              'assets/images/prv.png', // Using index to dynamically load image
              width: 88,
              height: 103,
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deluxe Room', // Example name
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
                    text: 'IDR 1.000.000 / night', // Example service
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
                    Icon(
                      Icons.bed_rounded,
                      size: 14,
                      color: Color(0xFFACA3A3),
                    ),
                    SizedBox(width: 7),
                    Text(
                      'Queen Bed', // Example distance
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
                      'Available',
                      style: TextStyle(
                        color: Color(0xFF50CC98),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    // Image.asset('assets/svgs/cat.svg'),
                    SizedBox(width: 10),
                    // Image.asset('assets/svgs/dog.svg'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
