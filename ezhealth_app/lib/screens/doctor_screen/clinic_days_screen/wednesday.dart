import 'dart:convert';

import 'package:ezhealth_app/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WednesdayScreen extends StatefulWidget {
  final String doctorId;
  WednesdayScreen(this.doctorId);

  @override
  _WednesdayScreenState createState() => _WednesdayScreenState(doctorId);
}

class _WednesdayScreenState extends State<WednesdayScreen> {
  final String doctorId;
  _WednesdayScreenState(this.doctorId);

  final _formKey = GlobalKey<FormState>();

  final _clinic = TextEditingController();
  final _timeController = TextEditingController();

  Map data;

  String chamberLocation = "";

  String clinicText;

  String _chosenValue;

  TimeOfDay time;

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );
    if (newTime == null) return;
    setState(() {
      time = newTime;
      _timeController.text = newTime.format(context);
    });
  }

  void sendData() async {
    final String url = 'https://bcrecapc.ml/api/wednesday/$doctorId/';
    var response = await http.put(Uri.parse(url), body: {
      "wednesday_id": doctorId,
      "chamber_location": clinicText,
      "available_time": _timeController.text,
      "slots_available": _chosenValue,
      "wednesday_name": doctorId
    });

    if (response.statusCode == 200) {
      print(response.body);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Wednesday Clinic Uploaded")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something Went Wrong")));
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final String url = 'https://bcrecapc.ml/api/wednesday/$doctorId/';
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      data = convertJson;
      chamberLocation = data['chamber_location'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "WEDNESDAY",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Palette.scaffoldColor,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //! Clinic Location
                      chamberLocation == ""
                          ? TextFormField(
                              decoration: InputDecoration(
                                label: Text("Clinic Location"),
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                              ),
                              textCapitalization: TextCapitalization.words,
                              controller: _clinic,
                              validator: clinicValidate,
                              onSaved: (value) {
                                clinicText = value;
                              },
                            )
                          : TextFormField(
                              decoration: InputDecoration(
                                label: Text("Clinic Location"),
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                              ),
                              textCapitalization: TextCapitalization.words,
                              controller: _clinic
                                ..text = data['chamber_location'],
                              validator: clinicValidate,
                              onSaved: (value) {
                                clinicText = value;
                              },
                            ),
                      SizedBox(
                        height: 20,
                      ),

                      //! Slots Available
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          label: Text("Choose Slots Available"),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value == null ? 'Field must not be empty' : null,
                        isExpanded: true,
                        value: _chosenValue,
                        items: [
                          '0',
                          '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          '6',
                          '7',
                          '8',
                          '9',
                          '10',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String value) {
                          setState(() {
                            _chosenValue = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),

                      //! Available Time
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            // color: Colors.red,
                            child: TextFormField(
                              decoration: InputDecoration(
                                label: Text("Available Time"),
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                              ),
                              enabled: false,
                              controller: _timeController,
                            ),
                          ),
                          SizedBox(width: 10),
                          IconButton(
                              icon: Icon(Icons.access_time),
                              onPressed: () {
                                pickTime(context);
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    sendData();
                  }
                  print(clinicText);
                  print(_chosenValue);
                  print(_timeController.text);

                  FocusScope.of(context).unfocus();
                },
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String clinicValidate(String clinic) {
    if (clinic.isEmpty) {
      return "Clinic must not be empty";
    } else {
      return null;
    }
  }
}
