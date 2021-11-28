import 'dart:convert';
import 'package:ezhealth_app/config/palette.dart';
import 'package:ezhealth_app/screens/doctor_screen/chamber_screen.dart';
import 'package:ezhealth_app/screens/doctor_screen/doctor_profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DoctorScreen extends StatefulWidget {
  final String userId;
  DoctorScreen(this.userId);

  @override
  _DoctorScreenState createState() => _DoctorScreenState(userId);
}

class _DoctorScreenState extends State<DoctorScreen> {
  final String userId;
  _DoctorScreenState(this.userId);

  Map doctorData;

  @override
  void initState() {
    super.initState();
    print(userId + " success");
    getDoctor();
  }

  void getDoctor() async {
    final String url = 'http://192.168.43.2:8000/api/doctor/$userId/';
    // final String url = 'http://142.93.212.221/api/doctor/$userId/';
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
      child: doctorData != null
          ? Scaffold(
              appBar: AppBar(
                title: Text("Welcome Dr. " +
                    doctorData['doctor_name']
                        .toString()
                        .split(" ")[0]
                        .toString()),
                // title: Text("Doctor's Dashboard"),
              ),
              drawer: Drawer(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.red,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      ListTile(
                        title: Text("Profile"),
                        leading: Icon(Icons.person),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DoctorProfile(
                                      doctorData['registration_id'].toString(),
                                      doctorData['doctor_name'].toString(),
                                      doctorData['doctor_description'].toString(),
                                      doctorData['degree'].toString(),
                                      doctorData['designation'].toString(),
                                      doctorData['phone_no'].toString(),
                                    ))),
                      ),
                      ListTile(
                        title: Text("Clinics"),
                        leading: Icon(Icons.settings),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChamberScreen(
                                    doctorData['registration_id']))),
                      )
                    ],
                  ),
                ),
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Palette.scaffoldColor,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
