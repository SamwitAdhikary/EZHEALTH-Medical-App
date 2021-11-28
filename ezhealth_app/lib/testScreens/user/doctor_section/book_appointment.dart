import 'dart:convert';

import 'package:ezhealth_app/config/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookAppointment extends StatefulWidget {
  final String doctorId;
  final String userID;
  final String userName;
  final String doctorName;
  BookAppointment(this.doctorId, this.userID, this.userName, this.doctorName);

  @override
  _BookAppointmentState createState() =>
      _BookAppointmentState(doctorId, userID, userName, doctorName);
}

class _BookAppointmentState extends State<BookAppointment> {
  final String doctorId;
  final String userID;
  final String userName;
  final String doctorName;
  _BookAppointmentState(
      this.doctorId, this.userID, this.userName, this.doctorName);

  bool _mondaySelected;
  bool _tuesdaySelected;
  bool _wednesdaySelected;
  bool _thursdaySelected;
  bool _fridaySelected;
  bool _saturdaySelected;
  bool _sundaySelected;

  Map monday;
  Map tuesday;
  Map wednesday;
  Map thursday;
  Map friday;
  Map saturday;
  Map sunday;

  String mondayChamber;
  String tuesdayChamber;
  String wednesdayChamber;
  String thursdayChamber;
  String fridayChamber;
  String saturdayChamber;
  String sundayChamber;

  String mondayTime;
  String tuesdayTime;
  String wednesdayTime;
  String thursdayTime;
  String fridayTime;
  String saturdayTime;
  String sundayTime;

  String mondaySlot;
  String tuesdaySlot;
  String wednesdaySlot;
  String thursdaySlot;
  String fridaySlot;
  String saturdaySlot;
  String sundaySlot;

  String mondayNumber;
  String tuesdayNumber;
  String wednesdayNumber;
  String thursdayNumber;
  String fridayNumber;
  String saturdayNumber;
  String sundayNumber;

  String day;
  String time;
  String place;

  @override
  void initState() {
    super.initState();

    _mondaySelected = false;
    _tuesdaySelected = false;
    _wednesdaySelected = false;
    _thursdaySelected = false;
    _fridaySelected = false;
    _saturdaySelected = false;
    _sundaySelected = false;

    getMonday();
    getTuesday();
    getWednesday();
    getThursday();
    getFriday();
    getSaturday();
    getSunday();
  }

  bookAppointment() {
    print('Book Appointment');
  }

  getMonday() async {
    final String url = 'http://192.168.43.2:8000/api/monday/$doctorId/';
    // final String url = 'http://142.93.212.221/api/monday/$doctorId/';
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      monday = convertJson;
      mondayChamber = monday['chamber_location'];
      mondayTime = monday['available_time'];
      mondaySlot = monday['slots_available'].toString();
    });
    print(monday['chamber_location']);
  }

  getTuesday() async {
    final String url = 'http://192.168.43.2:8000/api/tuesday/$doctorId/';
    // final String url = 'http://142.93.212.221/api/tuesday/$doctorId/';
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      tuesday = convertJson;
      tuesdayChamber = tuesday['chamber_location'];
      tuesdayTime = tuesday['available_time'];
      tuesdaySlot = tuesday['slots_available'].toString();
    });
  }

  getWednesday() async {
    final String url = 'http://192.168.43.2:8000/api/wednesday/$doctorId/';
    // final String url = 'http://142.93.212.221/api/wednesday/$doctorId/';
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      wednesday = convertJson;
      wednesdayChamber = wednesday['chamber_location'];
      wednesdayTime = wednesday['available_time'];
      wednesdaySlot = wednesday['slots_available'].toString();
    });
  }

  getThursday() async {
    final String url = 'http://192.168.43.2:8000/api/thursday/$doctorId/';
    // final String url = 'http://142.93.212.221/api/thursday/$doctorId/';
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      thursday = convertJson;
      thursdayChamber = thursday['chamber_location'];
      thursdayTime = thursday['available_time'];
      thursdaySlot = thursday['slots_available'].toString();
    });
  }

  getFriday() async {
    final String url = 'http://192.168.43.2:8000/api/friday/$doctorId/';
    // final String url = 'http://142.93.212.221/api/friday/$doctorId/';
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      friday = convertJson;
      fridayChamber = friday['chamber_location'];
      fridayTime = friday['available_time'];
      fridaySlot = friday['slots_available'].toString();
    });
  }

  getSaturday() async {
    final String url = 'http://192.168.43.2:8000/api/saturday/$doctorId/';
    // final String url = 'http://142.93.212.221/api/saturday/$doctorId';
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      saturday = convertJson;
      saturdayChamber = saturday['chamber_location'];
      saturdayTime = saturday['available_time'];
      saturdaySlot = saturday['slots_available'].toString();
    });
  }

  getSunday() async {
    final String url = 'http://192.168.43.2:8000/api/sunday/$doctorId/';
    // final String url = 'http://142.93.212.221/api/sunday/$doctorId/';
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      sunday = convertJson;
      sundayChamber = sunday['chamber_location'];
      sundayTime = sunday['available_time'];
      sundaySlot = sunday['slots_available'].toString();
    });
  }

  appointment() async {
    final String url = 'http://192.168.43.2:8000/api/appointment/';
    var response = await http.post(Uri.parse(url), body: {
      "username": userName,
      "doctorname": doctorName,
      "place": place,
      "day": day,
      "time": time,
      "user": userID,
      "doctor": doctorId,
    });
    if (response.statusCode == 201) {
      showDialog(
        context: (context),
        builder: (_) => AlertDialog(
          title: Text('Success'),
          content: Text(
              'You have successfully booked the appointment at $time on $day at $place.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something Went Wrong. Try Again!!!')));
    }
  }

  // decreaseSlot() async {
  //   final String url = ''
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Available Clinics',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Palette.scaffoldColor,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 0,
        ),
        body: mondayChamber != "" ||
                tuesdayChamber != "" ||
                wednesdayChamber != "" ||
                thursdayChamber != "" ||
                fridayChamber != "" ||
                saturdayChamber != "" ||
                sundayChamber != ""
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // color: Colors.yellow,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      width: MediaQuery.of(context).size.width,
                      // color: Colors.yellow,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                //!Monday
                                mondayChamber != ""
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                print('clicked');

                                                day = 'Monday';
                                                place = mondayChamber;
                                                time = mondayTime;

                                                print(place);
                                                print(day);
                                                print(time);

                                                _mondaySelected = true;
                                                _tuesdaySelected = false;
                                                _wednesdaySelected = false;
                                                _thursdaySelected = false;
                                                _fridaySelected = false;
                                                _saturdaySelected = false;
                                                _sundaySelected = false;
                                              });
                                            },
                                            child: Container(
                                              // padding: EdgeInsets.only(left: 30),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              decoration: BoxDecoration(
                                                // color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: _mondaySelected != false
                                                    ? Border.all(
                                                        color: Colors.green)
                                                    : Border.all(),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "MON |",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        mondayChamber != null
                                                            ? mondayChamber
                                                            : '',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      Text(mondayTime != null
                                                          ? mondayTime
                                                          : "")
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Text(
                                                    "|",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Slot Available',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Text(mondaySlot != null
                                                          ? mondaySlot
                                                          : "")
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Offstage(),

                                //! Tuesday
                                tuesdayChamber != ""
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                print('clicked');

                                                day = 'Tuesday';
                                                place = tuesdayChamber;
                                                time = tuesdayTime;

                                                print(place);
                                                print(day);
                                                print(time);

                                                _mondaySelected = false;
                                                _tuesdaySelected = true;
                                                _wednesdaySelected = false;
                                                _thursdaySelected = false;
                                                _fridaySelected = false;
                                                _saturdaySelected = false;
                                                _sundaySelected = false;
                                              });
                                            },
                                            child: Container(
                                              // padding: EdgeInsets.only(left: 30),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              decoration: BoxDecoration(
                                                // color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border:
                                                    _tuesdaySelected != false
                                                        ? Border.all(
                                                            color: Colors.green)
                                                        : Border.all(),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "TUE |",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        tuesdayChamber != null
                                                            ? tuesdayChamber
                                                            : '',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      Text(tuesdayTime != null
                                                          ? tuesdayTime
                                                          : "")
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Text(
                                                    "|",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Slot Available',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Text(tuesdaySlot != null
                                                          ? tuesdaySlot
                                                          : "")
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Offstage(),

                                //! Wednesday
                                wednesdayChamber != ""
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                print('clicked');

                                                day = 'Wednesday';
                                                place = wednesdayChamber;
                                                time = wednesdayTime;

                                                print(place);
                                                print(day);
                                                print(time);

                                                _mondaySelected = false;
                                                _tuesdaySelected = false;
                                                _wednesdaySelected = true;
                                                _thursdaySelected = false;
                                                _fridaySelected = false;
                                                _saturdaySelected = false;
                                                _sundaySelected = false;
                                              });
                                            },
                                            child: Container(
                                              // padding: EdgeInsets.only(left: 30),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              decoration: BoxDecoration(
                                                // color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: _wednesdaySelected ==
                                                        false
                                                    ? Border.all()
                                                    : Border.all(
                                                        color: Colors.green),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "WED |",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        wednesdayChamber != null
                                                            ? wednesdayChamber
                                                            : '',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      Text(wednesdayTime != null
                                                          ? wednesdayTime
                                                          : "")
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Text(
                                                    "|",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Slot Available',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Text(wednesdaySlot != null
                                                          ? wednesdaySlot
                                                          : "")
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Offstage(),

                                //! Thursday
                                thursdayChamber != ""
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                print('clicked');

                                                day = 'Thursday';
                                                place = thursdayChamber;
                                                time = thursdayTime;

                                                print(place);
                                                print(day);
                                                print(time);

                                                _mondaySelected = false;
                                                _tuesdaySelected = false;
                                                _wednesdaySelected = false;
                                                _thursdaySelected = true;
                                                _fridaySelected = false;
                                                _saturdaySelected = false;
                                                _sundaySelected = false;
                                              });
                                            },
                                            child: Container(
                                              // padding: EdgeInsets.only(left: 30),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              decoration: BoxDecoration(
                                                // color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: _thursdaySelected ==
                                                        false
                                                    ? Border.all()
                                                    : Border.all(
                                                        color: Colors.green),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "THU |",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        thursdayChamber != null
                                                            ? thursdayChamber
                                                            : '',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      Text(thursdayTime != null
                                                          ? thursdayTime
                                                          : "")
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Text(
                                                    "|",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Slot Available',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Text(thursdaySlot != null
                                                          ? thursdaySlot
                                                          : "")
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Offstage(),

                                //! Friday
                                fridayChamber != ""
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                print('clicked');

                                                day = 'Friday';
                                                place = fridayChamber;
                                                time = fridayTime;

                                                print(place);
                                                print(day);
                                                print(time);

                                                _mondaySelected = false;
                                                _tuesdaySelected = false;
                                                _wednesdaySelected = false;
                                                _thursdaySelected = false;
                                                _fridaySelected = true;
                                                _saturdaySelected = false;
                                                _sundaySelected = false;
                                              });
                                            },
                                            child: Container(
                                              // padding: EdgeInsets.only(left: 30),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              decoration: BoxDecoration(
                                                // color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: _fridaySelected == false
                                                    ? Border.all()
                                                    : Border.all(
                                                        color: Colors.green),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "FRI |",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        fridayChamber != null
                                                            ? fridayChamber
                                                            : '',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      Text(fridayTime != null
                                                          ? fridayTime
                                                          : "")
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Text(
                                                    "|",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Slot Available',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Text(fridaySlot != null
                                                          ? fridaySlot
                                                          : "")
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Offstage(),

                                //! Saturday
                                saturdayChamber != ""
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                print('clicked');

                                                day = 'Saturday';
                                                place = saturdayChamber;
                                                time = saturdayTime;

                                                print(place);
                                                print(day);
                                                print(time);

                                                _mondaySelected = false;
                                                _tuesdaySelected = false;
                                                _wednesdaySelected = false;
                                                _thursdaySelected = false;
                                                _fridaySelected = false;
                                                _saturdaySelected = true;
                                                _sundaySelected = false;
                                              });
                                            },
                                            child: Container(
                                              // padding: EdgeInsets.only(left: 30),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              decoration: BoxDecoration(
                                                // color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: _saturdaySelected ==
                                                        false
                                                    ? Border.all()
                                                    : Border.all(
                                                        color: Colors.green),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "SAT |",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        saturdayChamber != null
                                                            ? saturdayChamber
                                                            : '',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      Text(saturdayTime != null
                                                          ? saturdayTime
                                                          : "")
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Text(
                                                    "|",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Slot Available',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Text(saturdaySlot != null
                                                          ? saturdaySlot
                                                          : "")
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Offstage(),

                                //! Sunday
                                sundayChamber != ""
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                print('clicked');

                                                day = 'Sunday';
                                                place = sundayChamber;
                                                time = sundayTime;

                                                print(place);
                                                print(day);
                                                print(time);

                                                _mondaySelected = false;
                                                _tuesdaySelected = false;
                                                _wednesdaySelected = false;
                                                _thursdaySelected = false;
                                                _fridaySelected = false;
                                                _saturdaySelected = false;
                                                _sundaySelected = true;
                                              });
                                            },
                                            child: Container(
                                              // padding: EdgeInsets.only(left: 30),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              decoration: BoxDecoration(
                                                // color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: _sundaySelected == false
                                                    ? Border.all()
                                                    : Border.all(
                                                        color: Colors.green),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "SUN |",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        sundayChamber != null
                                                            ? sundayChamber
                                                            : '',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      Text(sundayTime != null
                                                          ? sundayTime
                                                          : "")
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Text(
                                                    "|",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Slot Available',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Text(sundaySlot != null
                                                          ? sundaySlot
                                                          : "")
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Offstage(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      width: 100,
                      // alignment: Alignment.bottomCenter,
                      // color: Colors.red,
                      child: ElevatedButton(
                        onPressed: _mondaySelected ||
                                _tuesdaySelected ||
                                _wednesdaySelected ||
                                _thursdaySelected ||
                                _fridaySelected ||
                                _saturdaySelected ||
                                _sundaySelected
                            ? () {
                                print('clicked on book');
                                appointment();
                              }
                            : null,
                        child: Text('Book'),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: Text("No Clinics Available"),
              ),
      ),
    );
  }
}
