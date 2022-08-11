import 'dart:convert';
import 'package:ezhealth_app/screens/user/doctor_section/appointment_booking.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class AboutDoctor extends StatefulWidget {
  final String doctorID;
  final String userID;
  final String doctorname;
  final String doctorGender;
  final String userName;
  final String description;
  final String degree;
  final String designation;
  final String mail;
  final int phone;
  final int userPhone;
  AboutDoctor(
      this.doctorID,
      this.userID,
      this.doctorname,
      this.doctorGender,
      this.userName,
      this.description,
      this.degree,
      this.designation,
      this.mail,
      this.phone,
      this.userPhone);

  @override
  _AboutDoctorState createState() => _AboutDoctorState(
        doctorID,
        userID,
        doctorname,
        doctorGender,
        userName,
        description,
        degree,
        designation,
        mail,
        phone,
        userPhone,
      );
}

class _AboutDoctorState extends State<AboutDoctor>
    with TickerProviderStateMixin {
  final String doctorID;
  final String userID;
  final String doctorname;
  final String doctorGender;
  final String userName;
  final String description;
  final String degree;
  final String designation;
  final String mail;
  final int phone;
  final int userPhone;
  _AboutDoctorState(
      this.doctorID,
      this.userID,
      this.doctorname,
      this.doctorGender,
      this.userName,
      this.description,
      this.degree,
      this.designation,
      this.mail,
      this.phone,
      this.userPhone);

  Map doctors;
  bool isExpanded = false;
  Map doctorIdNumber;

  @override
  void initState() {
    super.initState();
    getDoctorId();
    print(phone);
  }

  getDoctorId() async {
    final String url = 'https://bcrecapc.ml/api/doctor/$doctorID/';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
    });
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
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  //! Profile Photo
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: doctorGender == 'Female'
                            ? AssetImage(
                                'assets/images/doctor.png',
                              )
                            : AssetImage(
                                'assets/images/doctor-male.png',
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
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                'Dr. ' + doctorname,
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
                        child: GestureDetector(
                          onTap: () {
                            _makePhoneCall();
                          },
                          child: Container(
                            height: 55,
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
                      'About Doctor :',
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
                        PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: AppointmentBooking(
                            doctorID,
                            userID,
                            userName,
                            doctorname,
                            userPhone,
                          ),
                        ),
                      );
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
            Positioned(
              top: 10,
              left: 5,
              child: Container(
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                // color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
