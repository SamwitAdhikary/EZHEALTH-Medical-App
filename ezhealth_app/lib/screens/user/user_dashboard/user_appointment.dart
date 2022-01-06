import 'dart:convert';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:ezhealth_app/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserAppointment extends StatefulWidget {
  final String userId;
  UserAppointment(this.userId);

  @override
  _UserAppointmentState createState() => _UserAppointmentState(userId);
}

class _UserAppointmentState extends State<UserAppointment> {
  final String userId;
  _UserAppointmentState(this.userId);

  List userAppointments;
  List reversedList = [];

  @override
  void initState() {
    super.initState();
    getUserAppointment();
  }

  getUserAppointment() async {
    final String url = 'https://bcrecapc.ml/api/appointmentuser/$userId/';
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      userAppointments = convertJson['appointment_user'];

      reversedList = userAppointments.reversed.toList();
      print(reversedList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Your Appointments',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Palette.scaffoldColor,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: userAppointments == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: reversedList.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: reversedList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var userAppointment = reversedList[index];
                          return Container(
                              margin: EdgeInsets.only(
                                bottom: 5,
                                top: 5,
                              ),
                              width: MediaQuery.of(context).size.width,
                              // color: Colors.red,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    // padding: EdgeInsets.only(left: 30),
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      // color: Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          userAppointment['day']
                                                  .toString()
                                                  .characters
                                                  .take(3)
                                                  .toString()
                                                  .toUpperCase() +
                                              " |",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              userAppointment['place'],
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            Text(userAppointment['time'])
                                          ],
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "|",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Doctor',
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            Container(
                                              // color: Colors.red,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              child: Center(
                                                child: AutoSizeText(
                                                  userAppointment['doctorname'],
                                                  maxLines: 1,
                                                  wrapWords: true,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ));
                        },
                      )
                    : Center(
                        child: Text("No Appointments Found"),
                      ),
              ),
      ),
    );
  }
}
