import 'package:flutter/material.dart';

class TimeSlot extends StatefulWidget {
  final String chamberName;
  final String doctorName;
  final String day;
  final String time;
  final int slots;
  TimeSlot(this.chamberName, this.doctorName, this.day, this.time, this.slots);

  @override
  _TimeSlotState createState() =>
      _TimeSlotState(chamberName, doctorName, day, time, slots);
}

class _TimeSlotState extends State<TimeSlot> {
  final String chamberName;
  final String doctorName;
  final String day;
  final String time;
  final int slots;
  _TimeSlotState(
      this.chamberName, this.doctorName, this.day, this.time, this.slots);

  @override
  void initState() {
    super.initState();
    print(chamberName);
    print(doctorName);
    print(day);
    print(time);
    print(slots);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: Colors.red,
          // child: Text(slots.toString()),
          child: ListView.builder(
            itemCount: slots,
            itemBuilder: (context, int) {
              return Text(chamberName);
            },
          ),
        ),
      ),
    );
  }
}
