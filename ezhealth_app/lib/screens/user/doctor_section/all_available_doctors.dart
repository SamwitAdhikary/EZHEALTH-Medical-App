import 'dart:convert';
import 'package:ezhealth_app/config/palette.dart';
import 'package:ezhealth_app/screens/user/doctor_section/about_doctor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

class AllAvailableDoctors extends StatefulWidget {
  final String userId;
  final String userName;
  AllAvailableDoctors(this.userId, this.userName);

  @override
  _AllAvailableDoctorsState createState() =>
      _AllAvailableDoctorsState(userId, userName);
}

class _AllAvailableDoctorsState extends State<AllAvailableDoctors> {
  final String userId;
  final String userName;
  _AllAvailableDoctorsState(this.userId, this.userName);

  List doctors;
  Map data;

  @override
  void initState() {
    super.initState();
    getDoctorDetails();
    getUserDetails();
    print(userId);
    print(userName);
  }

  getDoctorDetails() async {
    final String url = 'https://bcrecapc.ml/api/chamberdoctor/';
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      doctors = convertJson;
      // print(doctors);
    });
  }

  getUserDetails() async {
    final String url = 'https://bcrecapc.ml/api/user/$userId/';
    // final String url =
    //     'https://bcrecapc.ml/api/user/I5pEXaj4EcM6PHj6xpbFRjOVo4u1/';
    // final String url = 'http://142.93.212.221/api/user/$userID/';
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      data = convertJson;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'All Available Doctors',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Palette.scaffoldColor,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: doctors != null
              ? ListView.builder(
                  itemCount: doctors.length,
                  itemBuilder: (BuildContext context, int index) {
                    var doctor = doctors[index];
                    return GestureDetector(
                      onTap: () {
                        print(doctor['doctor_name']);
                        // print(doctor['registration_id']);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => AboutDoctor(
                        // doctor['registration_id'],
                        // userId,
                        // doctor['doctor_name'],
                        // userName,
                        // doctor['doctor_description'],
                        // doctor['degree'],
                        // doctor['designation'],
                        // doctor['mail_id'],
                        // doctor['phone_no'])));

                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: AboutDoctor(
                                  doctor['registration_id'],
                                  userId,
                                  doctor['doctor_name'],
                                  doctor['doctor_gender'],
                                  userName,
                                  doctor['doctor_description'],
                                  doctor['degree'],
                                  doctor['designation'],
                                  doctor['mail_id'],
                                  doctor['phone_no'],
                                  data['phone_no'],
                                )));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                image: DecorationImage(
                                  image: doctor['doctor_gender'] == 'Female'
                                      ? AssetImage(
                                          'assets/images/doctor.png',
                                        )
                                      : AssetImage(
                                          'assets/images/doctor-male.png',
                                        ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dr. ' + doctor['doctor_name'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(doctor['degree']),
                                    SizedBox(width: 10),
                                    Text(doctor['designation'])
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
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
