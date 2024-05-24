import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_hotel/pages/frontdesk/booking/Individual.dart';
import 'package:frontend_hotel/pages/frontdesk/detail_room.dart';
import 'package:frontend_hotel/pages/frontdesk/home.dart';
import 'package:frontend_hotel/pages/home1.dart';
import 'package:frontend_hotel/pages/login/frontoffice.dart';
import 'package:frontend_hotel/pages/frontdesk/guest_list/guest_list.dart';
import 'package:frontend_hotel/pages/frontdesk/home.dart' as homeDash;
import 'package:frontend_hotel/pages/frontdesk/frontdesk_dashboard.dart';
import 'package:frontend_hotel/pages/customer/customer_dashboard.dart';
import 'package:frontend_hotel/pages/frontdesk/housekeeping/housekeeping.dart';
import 'package:frontend_hotel/pages/frontdesk/inhouse_guest.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //ini untuk splash logo hotel di awall ya mentemennn
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => HouseKeeping()));
    });
  }

  //ini jugaa untuk splash logo hotel di awall ya mentemennn
  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/image.png',
              height: 130,
            )
          ],
        ),
      ),
    );
  }
}
