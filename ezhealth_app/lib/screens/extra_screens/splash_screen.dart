import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:ezhealth_app/config/palette.dart';
import 'package:ezhealth_app/screens/doctor_screen/doctor_screen.dart';
import 'package:ezhealth_app/screens/extra_screens/get_started.dart';
import 'package:ezhealth_app/screens/extra_screens/offline.dart';
import 'package:ezhealth_app/screens/onboarding/onboard.dart';
import 'package:ezhealth_app/screens/user/user_dashboard/user_home.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 4;

  bool connection = true;
  Connectivity connectivity;

  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    connectivity = Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      print(result);
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        setState(() {
          connection = false;
        });
      }
    });
    _loadWidget();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  _loadWidget() {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isViewed = prefs.getInt('onBoard');
    var role = prefs.getString('role');
    var userId = prefs.getString('userId');
    var doctorId = prefs.getString('doctorId');

    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: connection
            ? Offline()
            : isViewed != 0
                ? OnBoard()
                : Builder(
                    builder: (context) {
                      if (role == 'Doctor') {
                        return ShowCaseWidget(
                          builder: Builder(
                              builder: (context) => DoctorScreen(doctorId)),
                        );
                      } else if (role == 'User') {
                        return ShowCaseWidget(
                          builder:
                              Builder(builder: (context) => UserHome(userId)),
                        );
                      } else if (role == null) {
                        return GetStartedScreen();
                      }
                      return GetStartedScreen();
                    },
                  ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Palette.scaffoldColor,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image(
                  image: AssetImage(
                    'assets/images/logo.png',
                  ),
                ),
                // color: Colors.red,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Text('Version: 1.0.0'),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
