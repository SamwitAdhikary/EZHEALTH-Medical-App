import 'package:ezhealth_app/screens/doctorRegisterScreen/doctor_registration_screen.dart';
import 'package:ezhealth_app/screens/user/userRegisterScreen/user_registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

import '../loginScreen/login_screen.dart';

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
                      Navigator.push(
                          context,
                          PageTransition(
                              child: LoginScreen(),
                              type: PageTransitionType.rightToLeftWithFade));
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
                    "Sign up by choosing your role.",
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
