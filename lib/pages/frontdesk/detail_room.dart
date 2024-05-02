import 'package:flutter/material.dart';

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
                FeatureItem(icon: Icons.star, label: '5.0', spaceWidth: 10.0),
                // Add more FeatureItem widgets for additional features
              ],
            ),
          ),
          // Description of the room
          Container(
            padding: EdgeInsets.all(16), // Add some padding around the text
            child: Text(
              '2 Twin Classic',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
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
