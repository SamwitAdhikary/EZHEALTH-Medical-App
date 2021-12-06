import 'package:ezhealth_app/config/palette.dart';
import 'package:ezhealth_app/screens/doctor_screen/doctor_screen.dart';
import 'package:ezhealth_app/testScreens/get_started.dart';
import 'package:ezhealth_app/testScreens/user/user_dashboard/user_home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var role = prefs.getString('role');
  var userId = prefs.getString('userId');
  var doctorId = prefs.getString('doctorId');

  runApp(
    MaterialApp(
      title: "EZHEALTH",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Palette.scaffoldColor,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        if (role == 'Doctor') {
          return DoctorScreen(doctorId);
        } else if (role == 'User') {
          return UserHome(userId);
        } else if (role == null) {
          return GetStartedScreen();
        }
        return GetStartedScreen();
      }),
    ),
  );
}
