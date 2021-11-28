import 'dart:convert';

import 'package:ezhealth_app/testScreens/user/doctor_section/book_appointment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class AboutDoctor extends StatefulWidget {
  final String doctorID;
  final String userID;
  final String doctorname;
  final String userName;
  final String description;
  final String degree;
  final String designation;
  final String mail;
  final int phone;
  AboutDoctor(
    this.doctorID,
    this.userID,
    this.doctorname,
    this.userName,
    this.description,
    this.degree,
    this.designation,
    this.mail,
    this.phone,
  );

  @override
  _AboutDoctorState createState() => _AboutDoctorState(doctorID, userID,
      doctorname, userName, description, degree, designation, mail, phone,);
}

class _AboutDoctorState extends State<AboutDoctor>
    with TickerProviderStateMixin {
  final String doctorID;
  final String userID;
  final String doctorname;
  final String userName;
  final String description;
  final String degree;
  final String designation;
  final String mail;
  final int phone;
  _AboutDoctorState(this.doctorID, this.userID, this.doctorname, this.userName,
      this.description, this.degree, this.designation, this.mail, this.phone,);

  Map doctors;
  bool isExpanded = false;
  Map doctorIdNumber;

  @override
  void initState() {
    super.initState();
    getDoctorId();
    print(userID);
  }

  getDoctorId() async {
    final String url = 'http://192.168.43.2:8000/api/doctor/$doctorID/';
    // final String url = 'http://142.93.212.221/api/doctor/$doctorID/';
    var response = await http.get(Uri.parse(url));
    // print(response.body);
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      doctorIdNumber = convertJson;
      print(doctorIdNumber);
    });
  }

  _makePhoneCall() async {
    final url = 'tel:+91' + phone.toString();
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              //! Profile Photo
              Hero(
                tag: doctorID,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('assets/images/doctor.png'),
                      // fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    color: Colors.red,
                  ),

                  //! Name and designation
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.1,
                    // color: Colors.blue,
                    child: Container(
                      // color: Colors.red,
                      child: Column(
                        children: [
                          Text(
                            'Dr. ' + userName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            designation,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //! Call Button
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    // color: Colors.red,
                    child: GestureDetector(
                      onTap: () {
                        _makePhoneCall();
                      },
                      child: Container(
                        height: 55,
                        // width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.blue, width: 2),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.call,
                            color: Colors.blue,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              //! About Doctor
              Container(
                padding: EdgeInsets.only(left: 20),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'About Doctor:',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              description != ""
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.26,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          description,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.26,
                      // color: Colors.red,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Center(
                        child: Text(
                          "No Description",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),

              //! Book Appointment Button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookAppointment(
                                doctorIdNumber['registration_id'],
                                userID, userName, doctorname,
                              ),),);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        offset: Offset(5, 5),
                        blurRadius: 8,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "BOOK APPOINTMENT",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
