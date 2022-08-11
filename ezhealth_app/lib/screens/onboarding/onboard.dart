import 'package:ezhealth_app/config/palette.dart';
import 'package:ezhealth_app/screens/extra_screens/get_started.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  _storeOnboardInfo() async {
    print('Shared Pref called');
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  @override
  Widget build(BuildContext context) {
    final Color kDarkBlueColor = Color(0xFF053149);

    return SafeArea(
      child: OnBoardingSlider(
        finishButtonText: 'Get Started',
        onFinish: () {
          _storeOnboardInfo();
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: GetStartedScreen(),
                  type: PageTransitionType.rightToLeft));
        },
        finishButtonColor: kDarkBlueColor,
        skipFunctionOverride: () {
          _storeOnboardInfo();
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: GetStartedScreen(),
                  type: PageTransitionType.rightToLeft));
        },
        skipTextButton: Text(
          'Skip',
          style: TextStyle(
            fontSize: 16,
            color: kDarkBlueColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        // imageHorizontalOffset: -10,
        imageVerticalOffset: 0,
        controllerColor: kDarkBlueColor,
        totalPage: 5,
        headerBackgroundColor: Palette.scaffoldColor,
        pageBackgroundColor: Palette.scaffoldColor,
        background: [
          // Image.asset(
          //   'assets/images/calendar.png',
          //   height: 400,
          // ),
          Lottie.asset('assets/animations/appointment.json', height: 400),
          // Image.asset(
          //   'assets/images/corona.png',
          //   height: 400,
          // ),
          Lottie.asset('assets/animations/corona.json', height: 400),
          // Image.asset(
          //   'assets/images/news.png',
          //   height: 400,
          // ),
          Lottie.asset('assets/animations/news1.json', height: 400),
          // Image.asset(
          //   'assets/images/bmi.png',
          //   height: 400,
          // ),
          Lottie.asset('assets/animations/bmi1.json', height: 400),
          // Image.asset(
          //   'assets/images/get_started.png',
          //   height: 400,
          // ),
          Lottie.asset('assets/animations/start1.json', height: 400),
        ],
        speed: 1.8,
        pageBodies: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 480,
                ),
                Text(
                  'Appointment Booking',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kDarkBlueColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Book appointment at your fingertips...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black26,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 480,
                ),
                Text(
                  'COVID Stats',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kDarkBlueColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Get latest COVID Stats from verified source',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 480,
                ),
                Text(
                  'Health News',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kDarkBlueColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Get all latest health related news at your fingertips',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 480,
                ),
                Text(
                  'Body Mass Index',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kDarkBlueColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Check your BMI at a single click',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 480,
                ),
                Text(
                  'Start Now!!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kDarkBlueColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Click below to get started',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
