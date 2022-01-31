import 'dart:convert';

import 'package:ezhealth_app/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProfile extends StatefulWidget {
  final String userId;
  UserProfile(this.userId);

  @override
  _UserProfileState createState() => _UserProfileState(userId);
}

class _UserProfileState extends State<UserProfile> {
  final String userId;
  _UserProfileState(this.userId);

  Map user;

  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _mail = TextEditingController();
  final _gender = TextEditingController();
  final _phone = TextEditingController();

  String nameText;
  String mailText;
  String genderText;
  String phoneText;

  String userImage;

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  void getUserDetails() async {
    final String url = 'https://bcrecapc.ml/api/user/$userId/';
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      user = convertJson;
      userImage = user['user_gender'];
      print(userImage);
    });
  }

  void updateUserDetails() async {
    final String url = 'https://bcrecapc.ml/api/user/$userId/';
    try {
      var response = await http.put(Uri.parse(url),
          body: {"user_name": nameText, "phone_no": phoneText});

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile Updated Successfully!!')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Something Went Wrong. Try Again Later!!!')));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'USER PROFILE',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Palette.scaffoldColor,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: user != null
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 160,
                        // width: 160,
                        // color: Colors.red,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              userImage == 'Male'
                                  ? 'assets/images/man.png'
                                  : 'assets/images/woman.png',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              //! User Name
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  label: Text('Name*'),
                                  alignLabelWithHint: true,
                                ),
                                textInputAction: TextInputAction.next,
                                validator: _nameValidator,
                                controller: _name..text = user['user_name'],
                                onSaved: (value) {
                                  nameText = value;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  label: Text('Gender*'),
                                  alignLabelWithHint: true,
                                ),
                                textInputAction: TextInputAction.next,
                                enabled: false,
                                validator: _genderValidator,
                                controller: _gender..text = user['user_gender'],
                                onSaved: (value) {
                                  genderText = value;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              //! User Email
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  label: Text('Email*'),
                                  alignLabelWithHint: true,
                                ),
                                textInputAction: TextInputAction.next,
                                validator: _mailValidator,
                                enabled: false,
                                controller: _mail..text = user['mail_id'],
                                onSaved: (value) {
                                  mailText = value;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              //! User Phone
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  label: Text('Phone Number*'),
                                  alignLabelWithHint: true,
                                ),
                                textInputAction: TextInputAction.next,
                                validator: _phoneValidator,
                                controller: _phone
                                  ..text = user['phone_no'].toString(),
                                onSaved: (value) {
                                  phoneText = value;
                                },
                              ),
                              SizedBox(
                                height: 20,
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
                            // print(nameText);
                            // print(genderText);
                            // print(mailText);
                            // print(phoneText.toString());
                            updateUserDetails();
                            Future.delayed(Duration(seconds: 2), () {
                              getUserDetails();
                            });
                          }

                          FocusScope.of(context).unfocus();
                        },
                        child: Text(
                          'Update',
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  String _nameValidator(String name) {
    if (name.isEmpty) {
      return "Field must not be empty";
    } else {
      return null;
    }
  }

  String _mailValidator(String mail) {
    if (mail.isEmpty) {
      return 'Field must not be empty';
    } else {
      return null;
    }
  }

  String _phoneValidator(String phone) {
    if (phone.isEmpty) {
      return 'Field must not be empty';
    } else {
      return null;
    }
  }

  String _genderValidator(String gender) {
    if (gender.isEmpty) {
      return 'Field must not be empty';
    } else {
      return null;
    }
  }
}
