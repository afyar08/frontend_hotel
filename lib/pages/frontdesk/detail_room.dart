import 'package:flutter/material.dart';
import 'package:frontend_hotel/pages/frontdesk/new_booking.dart';

class DetailRoom extends StatefulWidget {
  final String roomName;

  const DetailRoom({Key? key, required this.roomName}) : super(key: key);

  @override
  State<DetailRoom> createState() => _DetailRoomState();
}

class _DetailRoomState extends State<DetailRoom> {
  @override
  Widget build(BuildContext context) {
    // Determine the size of the screen to adjust the image size accordingly
    var screenSize = MediaQuery.of(context).size;
    var imageHeight =
        screenSize.height * 0.3; // Example: 30% of the screen height

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName), // Display room name in AppBar
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Set a fixed height for the image using SizedBox
          SizedBox(
            height: imageHeight,
            width: screenSize.width, // Use the full width of the screen
            child: Image.asset('assets/images/kamar.png', fit: BoxFit.cover),
          ),
          // Display list of features horizontally
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FeatureItem(
                    icon: Icons.wifi, label: 'Free Wifi', spaceWidth: 10.0),
                FeatureItem(
                    icon: Icons.free_breakfast_outlined,
                    label: 'Free Breakfast',
                    spaceWidth: 10.0),
              ],
            ),
          ),
          // Description of the room
          Container(
              padding: EdgeInsets.all(16), // Add some padding around the text
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '2 Twin Classic',
                        style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        'IDR 2.000.000/night',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  SizedBox(height: 8, ),
                  Text('Dua ruangan dengan fasilitas kolam pribadi.'),
                  SizedBox(height: 18, ),
                  Text(
                    'Description', 
                    style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                    ),
                  SizedBox(height: 8, ),
                  Text(
                    '2 Twin Classic adalah salah satu fasilitas unggulan kami yang menyediakan pemandangan serta fasilitas yang membuat nyaman, disediakan dengan dua buah kasur dalam satu kamar.'
                    ),
                  SizedBox(height: 18, ),
                  Text(
                    'Preview',
                    style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                    ),
                    Row( 
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Image.asset('assets/images/prv.png'),
                        ),
                        Container(
                          child: Image.asset('assets/images/prv2.png'),
                        ),
                        Container(
                          child: Image.asset('assets/images/prv3.png'),
                        )
                      ],
                    ),

                    SizedBox(height: 50),
                    TextButton(
                  //buat next
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewBooking()),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Booking Now',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      
                      padding: EdgeInsets.fromLTRB(
                          100, 20, 100, 20), // jarak ke dalam
                      decoration: BoxDecoration(
                        color: Colors.blue[800],
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ))
                ],
              )),
        ],
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final double spaceWidth;

  const FeatureItem(
      {Key? key,
      required this.icon,
      required this.label,
      this.spaceWidth = 8.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 20.0),
        SizedBox(width: spaceWidth),
        Text(label, style: TextStyle(fontSize: 16.0)),
      ],
    );
  }
}
