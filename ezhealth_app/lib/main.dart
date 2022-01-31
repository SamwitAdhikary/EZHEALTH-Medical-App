import 'package:ezhealth_app/config/palette.dart';
import 'package:ezhealth_app/screens/extra_screens/restart.dart';
import 'package:ezhealth_app/screens/extra_screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    RestartWidget(
      child: MaterialApp(
        title: "EZHEALTH",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Palette.scaffoldColor,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    ),
  );
}
