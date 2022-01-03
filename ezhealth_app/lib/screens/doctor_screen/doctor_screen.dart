import 'dart:convert';
import 'package:ezhealth_app/config/palette.dart';
import 'package:ezhealth_app/screens/doctor_screen/chamber_screen.dart';
import 'package:ezhealth_app/screens/get_started.dart';
import 'package:ezhealth_app/screens/user_screen/corona_stats.dart';
import 'package:ezhealth_app/screens/user_screen/news.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorScreen extends StatefulWidget {
  final String userId;
  DoctorScreen(this.userId);

  @override
  _DoctorScreenState createState() => _DoctorScreenState(userId);
}

class _DoctorScreenState extends State<DoctorScreen> {
  final String userId;
  _DoctorScreenState(this.userId);

  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  Map doctorData;

  @override
  void initState() {
    super.initState();
    print(userId + " success");
    getDoctor();
  }

  void getDoctor() async {
    // final String url = 'http://192.168.0.101:8000/api/doctor/$userId/';
    final String url = 'http://192.168.0.101:8000/api/doctor/$userId/';
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      doctorData = convertJson;
      print(doctorData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: Drawer(
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                ListTile(
                  title: Text('Logout'),
                  leading: Icon(Icons.logout),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('role');
                    prefs.remove('doctorId');

                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.leftToRightWithFade,
                            child: GetStartedScreen()));
                  },
                ),
                ListTile(
                  title: Text('Clinics'),
                  leading: FaIcon(FontAwesomeIcons.clinicMedical),
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            child: ChamberScreen(userId)));
                  },
                )
              ],
            ),
          ),
          key: _scaffold,
          body: doctorData != null
              ? Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 65,
                                      top: 10,
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                    // color: Colors.red,
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Welcome',
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Dr. ' + doctorData['doctor_name'],
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      image: DecorationImage(
                                        image: doctorData['doctor_gender'] ==
                                                'Male'
                                            ? AssetImage(
                                                'assets/images/doctor-male.png')
                                            : AssetImage(
                                                'assets/images/doctor.png'),
                                      ),
                                      shape: BoxShape.circle,
                                      // border: Border.all(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              // color: Colors.blue,
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  //! Corona Stats
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => CoronaStats()));
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: CoronaStats(),
                                              type: PageTransitionType
                                                  .rightToLeftWithFade));
                                    },
                                    child: Container(
                                      height: 105,
                                      width: 105,
                                      decoration: BoxDecoration(
                                        color: Palette.scaffoldColor,
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 5,
                                            color: Colors.grey.withOpacity(0.5),
                                            offset: Offset(5, 5),
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.viruses,
                                            size: 40,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text('Corona Stats')
                                        ],
                                      ),
                                    ),
                                  ),

                                  //! News
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => News()));
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: News(),
                                              type: PageTransitionType
                                                  .rightToLeftWithFade));
                                    },
                                    child: Container(
                                      height: 105,
                                      width: 105,
                                      decoration: BoxDecoration(
                                        color: Palette.scaffoldColor,
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 5,
                                            color: Colors.grey.withOpacity(0.5),
                                            offset: Offset(5, 5),
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.newspaper,
                                            size: 40,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text('News')
                                        ],
                                      ),
                                    ),
                                  ),

                                  //! BMI
                                  Container(
                                    height: 105,
                                    width: 105,
                                    decoration: BoxDecoration(
                                      color: Palette.scaffoldColor,
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: Offset(5, 5),
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.weight,
                                          size: 40,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('BMI')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 5,
                      top: 30,
                      child: IconButton(
                        onPressed: () => _scaffold.currentState.openDrawer(),
                        icon: Icon(
                          Icons.menu,
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
