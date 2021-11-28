import 'package:ezhealth_app/screens/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _passwordVisible;
  bool _confirmPasswordVisible;
  String _chosenValue;

  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  final databaseReference =
      FirebaseDatabase.instance.reference().child("Users");

  String nameText;
  String emailText;
  String phoneText;
  String passwordText;
  String confirmPasswordText;

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  void reset() {
    _name.clear();
    _email.clear();
    _phone.clear();
    _password.clear();
    _confirmPassword.clear();
  }

  void _saveItem() async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: emailText, password: passwordText);
      if (newUser != null) {
        final User user = FirebaseAuth.instance.currentUser;
        final userID = user.uid;
        // print(userID);

        _addUser(userID);

        sendHttp(userID);
      }
    } catch (e) {
      print(e);
    }
  }

  void _addUser(String userID) {
    databaseReference
        .child(userID)
        .set({'name': nameText, 'role': _chosenValue});
  }

  getDoctor(String userID) async {
    final String url = 'http://192.168.43.2:8000/api/doctor/';

    try {
      var response = await http.post(Uri.parse(url), body: {
        "registration_id": userID,
        "doctor_name": nameText,
        "mail_id": emailText,
        "phone_no": phoneText
      });
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  getUser(String userId) async {
    final String url = 'http://192.168.43.2:8000/api/user/';

    try {
      var response = await http.post(Uri.parse(url), body: {
        "registration_id": userId,
        "user_name": nameText,
        "mail_id": emailText,
        "phone_number": phoneText
      });
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  sendMondayData(String userID) async {
    final String url = 'http://192.168.43.2:8000/api/monday/';
    try {
      var response = await http.post(Uri.parse(url), body: {
        "monday_id": userID,
        "chamber_location": "",
        "available_time": "",
        "slots_available": "",
        "monday_name": userID
      });

      if (response.statusCode == 201) {
        print(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  sendTuesdayData(String userID) async {
    final String url = 'http://192.168.43.2:8000/api/tuesday/';
    try {
      var response = await http.post(Uri.parse(url), body: {
        "tuesday_id": userID,
        "chamber_location": "",
        "available_time": "",
        "slots_available": "",
        "tuesday_name": userID
      });

      if (response.statusCode == 201) {
        print(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  sendWednesdayData(String userID) async {
    final String url = 'http://192.168.43.2:8000/api/wednesday/';
    try {
      var response = await http.post(Uri.parse(url), body: {
        "wednesday_id": userID,
        "chamber_location": "",
        "available_time": "",
        "slots_available": "",
        "wednesday_name": userID
      });

      if (response.statusCode == 201) {
        print(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  sendThursdayData(String userID) async {
    final String url = 'http://192.168.43.2:8000/api/thursday/';
    try {
      var response = await http.post(Uri.parse(url), body: {
        "thursday_id": userID,
        "chamber_location": "",
        "available_time": "",
        "slots_available": "",
        "thursday_name": userID
      });

      if (response.statusCode == 201) {
        print(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  sendFridayData(String userID) async {
    final String url = 'http://192.168.43.2:8000/api/friday/';
    try {
      var response = await http.post(Uri.parse(url), body: {
        "friday_id": userID,
        "chamber_location": "",
        "available_time": "",
        "slots_available": "",
        "friday_name": userID
      });

      if (response.statusCode == 201) {
        print(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  sendSaturdayData(String userID) async {
    final String url = 'http://192.168.43.2:8000/api/saturday/';
    try {
      var response = await http.post(Uri.parse(url), body: {
        "saturday_id": userID,
        "chamber_location": "",
        "available_time": "",
        "slots_available": "",
        "saturday_name": userID
      });

      if (response.statusCode == 201) {
        print(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  sendSundayData(String userID) async {
    final String url = 'http://192.168.43.2:8000/api/sunday/';
    try {
      var response = await http.post(Uri.parse(url), body: {
        "sunday_id": userID,
        "chamber_location": "",
        "available_time": "",
        "slots_available": "",
        "sunday_name": userID
      });

      if (response.statusCode == 201) {
        print(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  sendChamberData(userID) async {
    final String url = 'http://192.168.43.2:8000/api/chamber/';
    try {
      var response = await http.post(Uri.parse(url), body: {
        "chamber_id": userID,
        "name": userID,
        "sunday_chamber": userID,
        "monday_chamber": userID,
        "tuesday_chamber": userID,
        "wednesday_chamber": userID,
        "thursday_chamber": userID,
        "friday_chamber": userID,
        "saturday_chamber": userID,
      });

      if (response.statusCode == 201) {
        print(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  void sendHttp(String userID) {
    if (_chosenValue == 'Doctor') {
      getDoctor(userID);

      //! Sending weekly chamber data
      Future.delayed(Duration(milliseconds: 500), () {
        sendMondayData(userID);
        sendTuesdayData(userID);
        sendWednesdayData(userID);
        sendThursdayData(userID);
        sendFridayData(userID);
        sendSaturdayData(userID);
        sendSundayData(userID);
      });

      //! Updating the chamber
      Future.delayed(Duration(seconds: 2), () {
        sendChamberData(userID);
      });
    } else if (_chosenValue == 'User') {
      getUser(userID);
    }
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _confirmPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              Container(
                // color: Colors.red,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    "Registration Form",
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
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //! Name
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Name*"),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        validator: nameValidate,
                        controller: _name,
                        onSaved: (value) {
                          nameText = value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //! Email
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Email*"),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: emailValidate,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _email,
                        onSaved: (value) {
                          emailText = value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //! Phone
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Phone Number*"),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        validator: phoneValidate,
                        controller: _phone,
                        onSaved: (value) {
                          phoneText = value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //! Role
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          label: Text("I am a*"),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value == null ? 'Field must not be empty' : null,
                        isExpanded: true,
                        value: _chosenValue,
                        items: [
                          'User',
                          'Doctor',
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
                      SizedBox(
                        height: 20,
                      ),

                      //! Password
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Password*"),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                              icon: Icon(_passwordVisible != false
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                        ),
                        textInputAction: TextInputAction.next,
                        obscureText: !_passwordVisible,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscuringCharacter: "*",
                        validator: validatePassword,
                        controller: _password,
                        onSaved: (value) {
                          passwordText = value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //! Confirm Password
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Confirm Password*"),
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(_confirmPasswordVisible != false
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _confirmPasswordVisible =
                                    !_confirmPasswordVisible;
                              });
                            },
                          ),
                        ),
                        obscureText: !_confirmPasswordVisible,
                        obscuringCharacter: "*",
                        validator: validateConfirmPassword,
                        controller: _confirmPassword,
                        onSaved: (value) {
                          confirmPasswordText = value;
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
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              }
                              print(nameText);
                              print(emailText);
                              print(phoneText);
                              print(passwordText);
                              print(confirmPasswordText);
                              print(_chosenValue);

                              _saveItem();

                              FocusScope.of(context).unfocus();
                            },
                            child: Text("Save"),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                reset();
                                FocusScope.of(context).unfocus();
                              },
                              child: Text("Reset"))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Registered?"),
                  // SizedBox(width: 5),
                  TextButton(
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen())),
                      child: Text("Login"))
                ],
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

  String emailValidate(String email) {
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regEx = RegExp(pattern);

    if (email.isEmpty) {
      return "Email must not be empty";
    } else if (!regEx.hasMatch(email)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  String phoneValidate(String phone) {
    if (phone.isEmpty) {
      return "Phone number must not be empty";
    } else if (phone.length > 10) {
      return "Phone number should not contain more than 10 digits";
    } else {
      return null;
    }
  }

  String validatePassword(String password) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    final regEx = RegExp(pattern);

    if (password.isEmpty) {
      return "Password must not be empty";
    } else if (!regEx.hasMatch(password)) {
      return "Choose a strong password";
    } else {
      return null;
    }
  }

  String validateConfirmPassword(String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return "Re-enter password";
    } else if (confirmPassword != _password.text) {
      return "Password not matched";
    } else {
      return null;
    }
  }

  // String validateRole(String role) {
  //   if (role.isEmpty) {
  //     return 'Select Role';
  //   } else {
  //     return null;
  //   }
  // }
}
