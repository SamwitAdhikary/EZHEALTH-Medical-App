import 'package:ezhealth_app/config/palette.dart';
import 'package:ezhealth_app/screens/doctor_screen/clinic_days_screen/friday.dart';
import 'package:ezhealth_app/screens/doctor_screen/clinic_days_screen/monday.dart';
import 'package:ezhealth_app/screens/doctor_screen/clinic_days_screen/saturday.dart';
import 'package:ezhealth_app/screens/doctor_screen/clinic_days_screen/sunday.dart';
import 'package:ezhealth_app/screens/doctor_screen/clinic_days_screen/thursday.dart';
import 'package:ezhealth_app/screens/doctor_screen/clinic_days_screen/tuesday.dart';
import 'package:ezhealth_app/screens/doctor_screen/clinic_days_screen/wednesday.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ChamberScreen extends StatefulWidget {
  final String doctorId;
  ChamberScreen(this.doctorId);

  @override
  _ChamberScreenState createState() => _ChamberScreenState(doctorId);
}

class _ChamberScreenState extends State<ChamberScreen> {
  final String doctorId;
  _ChamberScreenState(this.doctorId);

  String message;

  @override
  void initState() {
    super.initState();
    print(doctorId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "DAY WISE CLINIC",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Palette.scaffoldColor,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: Colors.red,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),

                //! Monday
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.97,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        // color: Colors.red,
                        child: Text(
                          "Monday",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             MondayScreen(doctorId)));
                            Navigator.push(
                                context,
                                PageTransition(
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
                                    child: MondayScreen(doctorId)));
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      // SizedBox(width: 10),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //! Tuesday
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.97,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        // color: Colors.red,
                        child: Text(
                          "Tuesday",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             TuesdayScreen(doctorId)));
                            Navigator.push(
                                context,
                                PageTransition(
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
                                    child: TuesdayScreen(doctorId)));
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      // SizedBox(width: 10),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //! Wednesday
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.97,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        // color: Colors.red,
                        child: Text(
                          "Wednesday",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             WednesdayScreen(doctorId)));
                            Navigator.push(
                                context,
                                PageTransition(
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
                                    child: WednesdayScreen(doctorId)));
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      // SizedBox(width: 10),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //! Thursday
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.97,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        // color: Colors.red,
                        child: Text(
                          "Thursday",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             ThursdayScreen(doctorId)));
                            Navigator.push(
                                context,
                                PageTransition(
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
                                    child: ThursdayScreen(doctorId)));
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      // SizedBox(width: 10),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //! Friday
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.97,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        // color: Colors.red,
                        child: Text(
                          "Friday",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             FridayScreen(doctorId)));
                            Navigator.push(
                                context,
                                PageTransition(
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
                                    child: FridayScreen(doctorId)));
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      // SizedBox(width: 10),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //! Saturday
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.97,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        // color: Colors.red,
                        child: Text(
                          "Saturday",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             SaturdayScreen(doctorId)));
                            Navigator.push(
                                context,
                                PageTransition(
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
                                    child: SaturdayScreen(doctorId)));
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      // SizedBox(width: 10),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //! Sunday
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.97,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        // color: Colors.red,
                        child: Text(
                          "Sunday",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             SundayScreen(doctorId)));
                            Navigator.push(
                                context,
                                PageTransition(
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
                                    child: SundayScreen(doctorId)));
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      // SizedBox(width: 10),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
