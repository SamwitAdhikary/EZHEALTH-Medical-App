import 'dart:convert';

import 'package:ezhealth_app/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class DoctorProfile extends StatefulWidget {
  final String doctorId;
  final String doctorName;
  final String doctorDescription;
  final String doctorDegree;
  final String doctorDegisnation;
  final String doctorPhone;
  DoctorProfile(this.doctorId, this.doctorName, this.doctorDescription,
      this.doctorDegree, this.doctorDegisnation, this.doctorPhone);

  @override
  _DoctorProfileState createState() => _DoctorProfileState(doctorId, doctorName,
      doctorDescription, doctorDegree, doctorDegisnation, doctorPhone);
}

class _DoctorProfileState extends State<DoctorProfile> {
  final String doctorId;
  final String doctorName;
  final String doctorDescription;
  final String doctorDegree;
  final String doctorDesignation;
  final String doctorPhone;
  _DoctorProfileState(this.doctorId, this.doctorName, this.doctorDescription,
      this.doctorDegree, this.doctorDesignation, this.doctorPhone);

  final _formKey = GlobalKey<FormState>();

  String nameText;
  String descriptionText;
  String degreeText;
  String designationText;
  String phoneText;

  String doctorGender;

  bool isSave = false;

  Map myDoctor;

  final _name = TextEditingController();
  final _description = TextEditingController();
  final _degree = TextEditingController();
  final _designation = TextEditingController();
  final _phone = TextEditingController();

  void updateItem() async {
    // final String url = 'https://bcrecapc.ml/api/doctor/$doctorId';
    final String url = 'https://bcrecapc.ml/api/doctor/$doctorId/';
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      myDoctor = convertJson;
      doctorGender = myDoctor['doctor_gender'];
      print(doctorGender);
    });
  }

  void saveItem() async {
    isSave = true;
    // final String url = 'https://bcrecapc.ml/api/doctor/$doctorId/';
    final String url = 'https://bcrecapc.ml/api/doctor/$doctorId/';
    try {
      var response = await http.put(Uri.parse(url), body: {
        "doctor_name": nameText,
        "doctor_description": descriptionText,
        "degree": degreeText,
        "designation": designationText,
        "phone_no": phoneText
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Profile Updated Successfully")));
        setState(() {
          isSave = false;
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Something Went Wrong")));
        setState(() {
          isSave = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    updateItem();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "DOCTOR PROFILE",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          elevation: 0,
          backgroundColor: Palette.scaffoldColor,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: Colors.red,
          child: myDoctor != null
              ? SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.grey, width: 3),
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(doctorGender == 'Male'
                                ? 'assets/images/doctor-male.png'
                                : 'assets/images/doctor.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              //! Name
                              TextFormField(
                                decoration: InputDecoration(
                                  label: Text("Name"),
                                  border: OutlineInputBorder(),
                                  alignLabelWithHint: true,
                                ),
                                validator: nameValidate,
                                controller: _name
                                  ..text = myDoctor['doctor_name'],
                                onSaved: (value) {
                                  nameText = value;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              myDoctor['doctor_description'] == ''
                                  ? TextFormField(
                                      decoration: InputDecoration(
                                        label: Text('Bio'),
                                        border: OutlineInputBorder(),
                                        alignLabelWithHint: true,
                                      ),
                                      validator: descriptionValidate,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      controller: _description,
                                      // expands: true,
                                      maxLines: 5,
                                      maxLength: 500,
                                      textAlign: TextAlign.justify,
                                      onSaved: (value) {
                                        descriptionText = value;
                                      },
                                    )
                                  : TextFormField(
                                      decoration: InputDecoration(
                                        label: Text('Bio'),
                                        border: OutlineInputBorder(),
                                        alignLabelWithHint: true,
                                      ),
                                      validator: descriptionValidate,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      controller: _description
                                        ..text = myDoctor['doctor_description'],
                                      // expands: true,
                                      maxLines: 5,
                                      maxLength: 500,
                                      textAlign: TextAlign.justify,
                                      onSaved: (value) {
                                        descriptionText = value;
                                      },
                                    ),
                              SizedBox(
                                height: 20,
                              ),

                              //! Degree
                              myDoctor['degree'] == ''
                                  ? TextFormField(
                                      decoration: InputDecoration(
                                        label: Text("Degree"),
                                        alignLabelWithHint: true,
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: degreeValidate,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      controller: _degree,
                                      onSaved: (value) {
                                        degreeText = value;
                                      },
                                    )
                                  : TextFormField(
                                      decoration: InputDecoration(
                                        label: Text("Degree"),
                                        alignLabelWithHint: true,
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: degreeValidate,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      controller: _degree
                                        ..text = myDoctor['degree'],
                                      onSaved: (value) {
                                        degreeText = value;
                                      },
                                    ),
                              SizedBox(
                                height: 20,
                              ),

                              //! Designation
                              myDoctor['designation'] == ''
                                  ? TextFormField(
                                      decoration: InputDecoration(
                                        label: Text("Designation"),
                                        alignLabelWithHint: true,
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: designationValidate,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      controller: _designation,
                                      onSaved: (value) {
                                        designationText = value;
                                      },
                                    )
                                  : TextFormField(
                                      decoration: InputDecoration(
                                        label: Text("Designation"),
                                        alignLabelWithHint: true,
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: designationValidate,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      controller: _designation
                                        ..text = myDoctor['designation'],
                                      onSaved: (value) {
                                        designationText = value;
                                      },
                                    ),
                              SizedBox(
                                height: 20,
                              ),

                              //! Phone
                              TextFormField(
                                decoration: InputDecoration(
                                  label: Text("Phone"),
                                  alignLabelWithHint: true,
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: phoneValidate,
                                controller: _phone
                                  ..text = myDoctor['phone_no'].toString(),
                                onSaved: (value) {
                                  phoneText = value;
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      isSave == false
                          ? ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  saveItem();
                                  updateItem();
                                }

                                print(nameText);
                                print(degreeText);
                                print(designationText);
                                print(phoneText);
                                print(doctorId);

                                FocusScope.of(context).unfocus();
                              },
                              child: Text("Save"),
                            )
                          : CircularProgressIndicator()
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }

  String nameValidate(String name) {
    if (name.isEmpty) {
      return "Name must not be empty";
    } else {
      return null;
    }
  }

  String descriptionValidate(String description) {
    if (description.isEmpty) {
      return "Field must not be empty";
    } else {
      return null;
    }
  }

  String degreeValidate(String degree) {
    if (degree.isEmpty) {
      return "Degree must not be empty";
    } else {
      return null;
    }
  }

  String designationValidate(String designation) {
    if (designation.isEmpty) {
      return "Designation must not be empty";
    } else {
      return null;
    }
  }

  String phoneValidate(String phone) {
    if (phone.isEmpty) {
      return "Phone must not be empty";
    } else if (phone.length < 10 || phone.length > 10) {
      return "Enter valid phone number";
    } else {
      return null;
    }
  }
}
