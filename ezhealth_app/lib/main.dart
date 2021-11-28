import 'package:ezhealth_app/config/palette.dart';
// import 'package:ezhealth_app/screens/doctor_screen/doctor_screen.dart';
import 'package:ezhealth_app/testScreens/get_started.dart';
// import 'package:ezhealth_app/testScreens/user/user_dashboard/user_home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Palette.scaffoldColor,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      // home: MainHomeScreen(),
      home: GetStartedScreen(),
      // home: UserHome('I5pEXaj4EcM6PHj6xpbFRjOVo4u1'),
      // home: DoctorScreen('2EhYUkvPzwalEIIErEZmpsZBNdC2'),
      debugShowCheckedModeBanner: false,
    );
  }
}
