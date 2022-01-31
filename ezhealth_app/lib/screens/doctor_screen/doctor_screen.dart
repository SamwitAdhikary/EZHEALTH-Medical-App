import 'dart:convert';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ezhealth_app/config/palette.dart';
import 'package:ezhealth_app/screens/bmi_screen/screens/input_page.dart';
import 'package:ezhealth_app/screens/doctor_screen/chamber_screen.dart';
import 'package:ezhealth_app/screens/doctor_screen/doctor_profile.dart';
import 'package:ezhealth_app/screens/extra_screens/corona_stats.dart';
import 'package:ezhealth_app/screens/extra_screens/news.dart';
import 'package:ezhealth_app/screens/extra_screens/get_started.dart';
import 'package:ezhealth_app/screens/extra_screens/privacy_policy.dart';
import 'package:ezhealth_app/screens/extra_screens/terms_and_condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

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

  GlobalKey _optionsKey = GlobalKey();
  GlobalKey _coronaKey = GlobalKey();
  GlobalKey _newsKey = GlobalKey();
  GlobalKey _bmiKey = GlobalKey();
  GlobalKey _totalBooking = GlobalKey();
  GlobalKey _totalUniqueUser = GlobalKey();

  Map doctorData;
  List appointments;
  List appointment = [];

  List quotes;

  final unique = Set();

  DateTime timeBackPressed = DateTime.now();

  @override
  void initState() {
    super.initState();
    getDoctor();
    getAppointmentDetails();
    getDoctorQuotes();
  }

  getAppointmentDetails() async {
    final String url =
        'https://bcrecapc.ml/api/appointmentdoctor/$userId/';
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      appointments = convertJson['appointment_doctor'];
      appointment = appointments.toSet().toList();
      appointment.retainWhere((x) => unique.add(x['username']));
      print(unique);
    });
  }

  void getDoctor() async {
    // final String url = 'https://bcrecapc.ml/api/doctor/$userId/';
    final String url = 'https://bcrecapc.ml/api/doctor/$userId/';
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      doctorData = convertJson;
      // print(doctorData);
    });
  }

  getDoctorQuotes() async {
    final String url =
        'https://samwitadhikary.github.io/doctor_quote/doctor_quote.json';
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      quotes = convertJson['quotes'];
      // print(quotes);
    });
  }

  @override
  Widget build(BuildContext context) {
    displayShowCase() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool showCaseVisibilityStatus = prefs.getBool('displayShowCase');

      if (showCaseVisibilityStatus == null) {
        prefs.setBool('displayShowCase', false);
        return true;
      }
      return false;
    }

    Future.delayed(Duration(seconds: 1), () {
      displayShowCase().then((status) {
        if (status) {
          ShowCaseWidget.of(context).startShowCase([
            _optionsKey,
            _coronaKey,
            _newsKey,
            _bmiKey,
            _totalBooking,
            _totalUniqueUser,
          ]);
        }
      });
    });

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final difference = DateTime.now().difference(timeBackPressed);
          timeBackPressed = DateTime.now();
          if (difference >= Duration(seconds: 2)) {
            final String msg = 'Press the back button to exit';
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(msg)));
            return false;
          } else {
            SystemNavigator.pop();
            return true;
          }
        },
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                ListTile(
                  title: Text('Doctor Profile'),
                  leading: FaIcon(FontAwesomeIcons.pen),
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: DoctorProfile(
                                doctorData['registration_id'],
                                doctorData['doctor_name'],
                                doctorData['doctor_description'],
                                doctorData['degree'],
                                doctorData['designation'],
                                doctorData['phone_no'].toString()),
                            type: PageTransitionType.rightToLeft));
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
                ),
                ListTile(
                  title: Text('Terms & Condition'),
                  leading: Icon(Icons.note_alt_rounded),
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: TermsAndCondition(),
                            type: PageTransitionType.rightToLeft));
                  },
                ),
                ListTile(
                  title: Text('Privacy Policy'),
                  leading: Icon(Icons.lock),
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: PrivacyPolicy(),
                            type: PageTransitionType.rightToLeft));
                  },
                ),
                Divider(color: Colors.grey),
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
                                    child: Showcase(
                                      key: _coronaKey,
                                      description: 'Check covid-19 status',
                                      child: Container(
                                        height: 105,
                                        width: 105,
                                        decoration: BoxDecoration(
                                          color: Palette.scaffoldColor,
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 5,
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                    child: Showcase(
                                      key: _newsKey,
                                      description:
                                          'Read all trending medical and health news',
                                      child: Container(
                                        height: 105,
                                        width: 105,
                                        decoration: BoxDecoration(
                                          color: Palette.scaffoldColor,
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 5,
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                  ),

                                  //! BMI
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: InputPage()));
                                    },
                                    child: Showcase(
                                      key: _bmiKey,
                                      description: 'Check body mass index',
                                      child: Container(
                                        height: 105,
                                        width: 105,
                                        decoration: BoxDecoration(
                                          color: Palette.scaffoldColor,
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 5,
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              // color: Colors.pink,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: quotes != null
                                  ? CarouselSlider.builder(
                                      itemCount: quotes.length,
                                      options: CarouselOptions(
                                        aspectRatio: 3.0,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        autoPlay: true,
                                        autoPlayInterval: Duration(seconds: 6),
                                        // enlargeCenterPage: true,
                                      ),
                                      itemBuilder: (BuildContext context,
                                          int index, int pageViewIndex) {
                                        final quote = quotes[index];
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 5, right: 5),
                                          padding: EdgeInsets.all(20),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.black87,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AutoSizeText(
                                                quote['quote'],
                                                maxLines: 3,
                                                // minFontSize: 14,
                                                // maxFontSize: 16,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                // color: Colors.red,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Text(
                                                  '~ ' + quote['author'],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      height: 150,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 30),
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                'Analytics :',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            appointments != null
                                ? Column(
                                    children: [
                                      Showcase(
                                        key: _totalBooking,
                                        description:
                                            'Total users booked till date',
                                        child: Container(
                                          height: 100,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          decoration: BoxDecoration(
                                            // color: Colors.red,
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                // color: Colors.red,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Text(
                                                  'TOTAL BOOKINGS :',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  appointments.length
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Showcase(
                                        key: _totalUniqueUser,
                                        description:
                                            'Total unique users booked till date',
                                        child: Container(
                                          height: 100,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          decoration: BoxDecoration(
                                            // color: Colors.red,
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                // color: Colors.red,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Text(
                                                  'TOTAL UNIQUE USERS :',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  unique.length.toString(),
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 5,
                      top: 30,
                      child: Showcase(
                        key: _optionsKey,
                        description: 'Click here for more options',
                        child: IconButton(
                          onPressed: () => _scaffold.currentState.openDrawer(),
                          icon: Icon(
                            Icons.menu,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
