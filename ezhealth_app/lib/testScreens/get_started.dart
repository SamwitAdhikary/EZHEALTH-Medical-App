// import 'package:ezhealth_app//login_screen/login_screen.dart';
// import 'package:ezhealth_app/testScreens/doctorRegisterScreen/doctor_registration_number.dart';
// import 'package:ezhealth_app/screens/doctor_screen/doctor_screen.dart';
import 'package:ezhealth_app/testScreens/doctorRegisterScreen/doctor_registration_screen.dart';
import 'package:ezhealth_app/testScreens/loginScreen/login_screen.dart';
// import 'package:ezhealth_app/testScreens/user/userRegisterScreen/user_name.dart';
import 'package:ezhealth_app/testScreens/user/userRegisterScreen/user_registration_screen.dart';
// import 'package:ezhealth_app/testScreens/user/user_dashboard/user_home.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:ezhealth_app/testScreens/userRegisterScreen/user_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

class GetStartedScreen extends StatefulWidget {
  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: Colors.red,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),

                //! Login Button
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 30),
                  width: MediaQuery.of(context).size.width,
                  child: InkWell(
                    onTap: () {
                      print('pressed on login');
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => LoginScreen()));
                      Navigator.push(
                          context,
                          PageTransition(
                              child: LoginScreen(),
                              type: PageTransitionType.rightToLeftWithFade));
                      // FirebaseAuth.instance.signOut();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    "Start by choosing your role.",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),

                //! Doctor Signup Button
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    print('pressed on doctor');
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => DoctorRegistrationScreen()));
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            child: DoctorRegistrationScreen()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      // color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(),
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              padding: EdgeInsets.only(top: 10, left: 20),
                              child: FaIcon(
                                FontAwesomeIcons.userMd,
                                size: 40,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              padding: EdgeInsets.only(left: 20, top: 10),
                              child: Text(
                                "I'm a doctor",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Center(
                          child: Icon(
                            Icons.chevron_right_outlined,
                            size: 40,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                //! Patient Signup Button
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    print('pressed on patient');
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => UserRegistrationScreen()));
                    Navigator.push(
                        context,
                        PageTransition(
                            child: UserRegistrationScreen(),
                            type: PageTransitionType.rightToLeftWithFade));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      // color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(),
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              padding: EdgeInsets.only(left: 20, top: 10),
                              child: FaIcon(
                                FontAwesomeIcons.procedures,
                                size: 40,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              padding: EdgeInsets.only(left: 20, top: 10),
                              child: Text(
                                "I'm a patient",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Center(
                          child: Icon(
                            Icons.chevron_right_outlined,
                            size: 40,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
