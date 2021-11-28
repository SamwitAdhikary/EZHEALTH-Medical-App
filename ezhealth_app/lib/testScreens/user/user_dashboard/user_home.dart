import 'dart:convert';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ezhealth_app/config/palette.dart';
import 'package:ezhealth_app/screens/user_screen/corona_stats.dart';
import 'package:ezhealth_app/screens/user_screen/news.dart';
import 'package:ezhealth_app/testScreens/user/doctor_section/about_doctor.dart';
import 'package:ezhealth_app/testScreens/user/user_dashboard/user_appointment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class UserHome extends StatefulWidget {
  final String userID;
  UserHome(this.userID);

  @override
  _UserHomeState createState() => _UserHomeState(userID);
}

class _UserHomeState extends State<UserHome> {
  final String userID;
  _UserHomeState(this.userID);

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  Map data;
  List doctors;
  List quotes;

  @override
  void initState() {
    super.initState();
    getUserDetails();
    getDoctorQuotes();
    getDoctors();
  }

  getUserDetails() async {
    final String url = 'http://192.168.43.2:8000/api/user/$userID/';
    // final String url =
    //     'http://192.168.43.2:8000/api/user/I5pEXaj4EcM6PHj6xpbFRjOVo4u1/';
    // final String url = 'http://142.93.212.221/api/user/$userID/';
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      data = convertJson;
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

  getDoctors() async {
    final String url = 'http://192.168.43.2:8000/api/chamberdoctor/';
    // final String url = 'http://142.93.212.221/api/chamberdoctor/';
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      doctors = convertJson;
      print(doctors);
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
                title: Text(
                  'Your Appointments',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                leading: Icon(
                  Icons.calendar_today,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserAppointment(userID)));
                },
              )
            ],
          ),
        ),
        // appBar: AppBar(
        //   title: Text("User Home Screen"),
        // ),
        key: _scaffoldState,
        body: data != null
            ? Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: 65,
                                  top: 10,
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.75,
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
                                        data['user_name'],
                                        style: TextStyle(
                                          fontSize: 19,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/man.png')),
                                  shape: BoxShape.circle,
                                  // border: Border.all(),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //! Corona Stats
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CoronaStats()));
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => News()));
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                          SizedBox(
                            height: 30,
                          ),
                          quotes != null
                              ? CarouselSlider.builder(
                                  itemCount: quotes.length,
                                  options: CarouselOptions(
                                    aspectRatio: 3.0,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 6),
                                    // enlargeCenterPage: true,
                                  ),
                                  itemBuilder: (BuildContext context, int index,
                                      int pageViewIndex) {
                                    final quote = quotes[index];
                                    return Container(
                                      margin:
                                          EdgeInsets.only(left: 5, right: 5),
                                      padding: EdgeInsets.all(20),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius: BorderRadius.circular(20),
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
                                            alignment: Alignment.centerRight,
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
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            // color: Colors.red,
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              'Available Doctors',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          //! Available Doctors List
                          doctors != null
                              ? Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: doctors.length,
                                    itemBuilder: (context, index) {
                                      final doctor = doctors[index];
                                      return GestureDetector(
                                        onTap: () {
                                          print(doctor['doctor_name']);
                                          // print(doctor['registration_id']);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => AboutDoctor(
                                                      doctor['registration_id'],
                                                      userID,
                                                      doctor['doctor_name'],
                                                      data['user_name'],
                                                      doctor[
                                                          'doctor_description'],
                                                      doctor['degree'],
                                                      doctor['designation'],
                                                      doctor['mail_id'],
                                                      doctor['phone_no'])));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(top: 10),
                                          height: 120,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          padding: EdgeInsets.only(left: 20),
                                          child: Row(
                                            children: [
                                              Hero(
                                                tag: doctor['registration_id'],
                                                child: Container(
                                                  height: 100,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                        'assets/images/doctor.png',
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Dr. ' +
                                                        doctor['doctor_name'],
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(doctor['degree']),
                                                      SizedBox(width: 10),
                                                      Text(
                                                          doctor['designation'])
                                                    ],
                                                  ),
                                                  // Row(
                                                  //   children: [
                                                  //     Text('Rating:'),
                                                  //     SizedBox(
                                                  //       width: 5,
                                                  //     ),
                                                  //     Text('4.5⭐'),
                                                  //   ],
                                                  // )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 5,
                    top: 40,
                    child: IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () => _scaffoldState.currentState.openDrawer(),
                    ),
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
