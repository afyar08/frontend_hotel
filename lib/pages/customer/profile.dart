import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:frontend_hotel/pages/customer/customer_dashboard.dart';

class ProfilePage1 extends StatelessWidget {
  const ProfilePage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Jakarta',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Expanded(flex: 2, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Richie Lorie",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    FloatingActionButton.extended(
                      onPressed: () {},
                      heroTag: 'Logout',
                      elevation: 0,
                      backgroundColor: const Color.fromARGB(255, 254, 78, 66),
                      label: const Text("Logout"),
                      icon: const Icon(Icons.logout_rounded),
                    ),
                    const SizedBox(height: 16),
                    _ProfileInfo()
                  ],
                ),
              ),
            ),
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
        initialActiveIndex: 2,
        onTap: (int index) {
          if (index == 0) { // Ketika ikon "Home" ditekan
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CustomerDashboard()),
            );
          } else if (index == 2) { // Ketika ikon "Profile" ditekan
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage1()),
            );
          } else {
            // Tindakan lainnya
          }
        },
      ),
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo({Key? key}) : super(key: key);

  final List<ProfileInfoItem> _items = const [
    ProfileInfoItem("Richie Lorie", Icons.person),
    ProfileInfoItem("richie.lorie@example.com", Icons.email),
    ProfileInfoItem("+1234567890", Icons.phone),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _items
            .map((item) => _singleItem(context, item))
            .toList(),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Icon(
          item.icon,
          size: 30,
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(width: 16),
        Text(
          item.value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}

class ProfileInfoItem {
  final String value;
  final IconData icon;

  const ProfileInfoItem(this.value, this.icon);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 100),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xFFC8DCFF), Color(0xFF4C4DDC)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80')),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
