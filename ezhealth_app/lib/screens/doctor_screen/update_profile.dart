
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class UpdateProfile extends StatefulWidget {
  final String doctorId;
  final String doctorName;
  final String doctorDegree;
  final String doctorDegisnation;
  final String doctorPhone;
  UpdateProfile(this.doctorId, this.doctorName, this.doctorDegree,
      this.doctorDegisnation, this.doctorPhone);

  @override
  _UpdateProfileState createState() => _UpdateProfileState(
      doctorId, doctorName, doctorDegree, doctorDegisnation, doctorPhone);
}

class _UpdateProfileState extends State<UpdateProfile> {
  final String doctorId;
  final String doctorName;
  final String doctorDegree;
  final String doctorDesignation;
  final String doctorPhone;
  _UpdateProfileState(this.doctorId, this.doctorName, this.doctorDegree,
      this.doctorDesignation, this.doctorPhone);

  final _formKey = GlobalKey<FormState>();

  String nameText;
  String degreeText;
  String designationText;
  String phoneText;

  final _name = TextEditingController();
  final _degree = TextEditingController();
  final _designation = TextEditingController();
  final _phone = TextEditingController();

  void clearForm() {
    _name.clear();
    _degree.clear();
    _designation.clear();
    _phone.clear();
  }

  void updateData() async {
    final String url = 'https://bcrecapc.ml/api/doctor/$doctorId/';

    try {
      var response = await http.put(Uri.parse(url), body: {
        "doctor_name": nameText,
        "degree": degreeText,
        "designation": designationText,
        "phone_no": phoneText
      });
      if (!mounted) return;
      print(response.body);
      if (response.statusCode == 200) {
        print('success');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Profile Updated Successfully")));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        // color: Colors.red,
                        child: Center(
                          child: Text(
                            "Update Profile",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      //! Name
                      TextFormField(
                        // initialValue: doctorName,
                        decoration: InputDecoration(
                          label: Text("Name"),
                          alignLabelWithHint: true,
                          // hintText: doctorName,
                          border: OutlineInputBorder(),
                        ),
                        validator: nameValidate,
                        controller: _name..text = doctorName,
                        onSaved: (value) {
                          nameText = value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //! Degree
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Degree"),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                        ),
                        controller: _degree,
                        validator: degreeValidate,
                        onSaved: (value) {
                          degreeText = value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //! Designation
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Designation"),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                        ),
                        controller: _designation,
                        validator: designationValidate,
                        onSaved: (value) {
                          designationText = value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //!Phone
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Phone"),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        controller: _phone..text = doctorPhone,
                        validator: phoneValidate,
                        onSaved: (value) {
                          phoneText = value;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                              }

                              setState(() {
                                updateData();
                              });

                              print(nameText);
                              print(degreeText);
                              print(designationText);
                              print(phoneText);

                              FocusScope.of(context).unfocus();
                            },
                            child: Text("Save"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              clearForm();
                              FocusScope.of(context).unfocus();
                            },
                            child: Text("Clear All"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  String nameValidate(String name) {
    if (name.isEmpty) {
      return "Name must not be empty";
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
    } else if (phone.length > 10) {
      return "Phone number must not exeed 10 digits";
    } else {
      return null;
    }
  }
}
